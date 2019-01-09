Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F7FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC07206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcnCwQlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfAIJaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:30:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39971 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfAIJaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:30:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so6699235edr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9bt6318KuI4Mb3GDgutajPT/Cvnzguj3ZEGYUBvG1Ss=;
        b=NcnCwQlvTOMcQ3YvE48Ay6kxdnx/Eqlmsr7L7YX0p9mfk4yx2MDNdrjkIbU6MLMFM+
         67jh7pZSJHhiiES6Y6NUezlrfKYV9d0UIMzrKoLoit84nBbTILHKqufHNhgOYwT7IOJ3
         9gX12OZreu1gXhHzqnRmZ9jmWcWZMjDZmHQSD6Oh6p2mczMpIgAhJwDd5olZxVp+i3cs
         ujRgmGKZtNd2rt7DWLG/x4xIIE7KjF/5D+dMaYD78IwNMHuSpRUTAj+EPBNhB0kNoC8n
         HRSpKlxIBZs0RypA5raxqm4+BKOjRiQ0uyizV8I8faoMumGbnJ0qeIu4OPqgUP1LfKsq
         Y7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=9bt6318KuI4Mb3GDgutajPT/Cvnzguj3ZEGYUBvG1Ss=;
        b=A4UJ5WEE5CHK2wIU6EuLqM8XA9Y8ag47o1/T31yu5YUc1lhz6uTq0WImmqVCjFR2te
         fA4iL/0zwk9dw/iCMvL4S/mdQpJd58ZTLxS7rv9l3F06k2hzCU5F9kgy9vxY91JbVSr7
         e7nOAPLFgI2LqYZcwJ8HBMv9IMB2TIOgwSfHii8zdCH1LoGasKbU/m1p+lgMM+XmjWHu
         QXuHA+/6Iim1e17I0gaWLs/jJhfBnAE2iq4sGuZwyCHSU1KVOwd8SVTF8bwHiyoDky72
         q8+xQA2W7z29dmeJKygH7lJaZdGk5zu1hmH3qLgbEBw+draxrbhfnwXazsDK6RSh2ilI
         dBzQ==
X-Gm-Message-State: AJcUukfwLAhRn5X8/X0qno3Rh2Z2G4Gv8XDwF+nQpicSt5b1jqe3+DbH
        M2uORBYwRHhnbcvwDqztHK05wj9mbNs=
X-Google-Smtp-Source: ALg8bN5tYntkwYXLf0iUL1FoS5j1DYx1a7jcNUaEN2TycabtLhkRYTG+UALI3uX3EyUIKs6HXxiEKg==
X-Received: by 2002:a17:906:474e:: with SMTP id j14-v6mr4823979ejs.55.1547026219498;
        Wed, 09 Jan 2019 01:30:19 -0800 (PST)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id h51sm1297205edh.17.2019.01.09.01.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:30:19 -0800 (PST)
Date:   Wed, 9 Jan 2019 04:30:16 -0500
From:   YU Bo <tsu.yubo@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, yuzibode@126.com
Subject: Re: [PATCH V5 2/2] kobject: drop newline from msg string
Message-ID: <20190109093014.cjheviy67szigzfg@yubo-2>
Mail-Followup-To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, yuzibode@126.com
References: <cover.1547024167.git.tsu.yubo@gmail.com>
 <db8c353e82b944654fec17beb99d96bebff91864.1547024167.git.tsu.yubo@gmail.com>
 <CAJZ5v0guQizE2mi3qv=0CVz9FYf6Kzv222Ff0RX1NyGuKAiucA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0guQizE2mi3qv=0CVz9FYf6Kzv222Ff0RX1NyGuKAiucA@mail.gmail.com>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2019 at 10:21:37AM +0100, Rafael J. Wysocki wrote:
>On Wed, Jan 9, 2019 at 10:17 AM Bo YU <tsu.yubo@gmail.com> wrote:
>>
>> There is currently a missing terminating newline in non-switch case
>> match when msg == NULL
>>
>> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
>
>I have given you an R-by for this one already, so why haven't you added it here?
Oh, i got it.This is the first time i encountered the circumstances.
>
>Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Thank you :)
>
>> ---
>> Changes in V4:
>> Recovery originly declaration, requested by Greg.
>>
>> Change in V3:
>> Improve the commit log, requested by Rafael.
>>
>> Changes in V2:
>> Drop newline from msg according to Joe's suggestion.
>> ---
>>  lib/kobject_uevent.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> index c87a96c4800e..f05802687ba4 100644
>> --- a/lib/kobject_uevent.c
>> +++ b/lib/kobject_uevent.c
>> @@ -200,7 +200,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>>
>>         r = kobject_action_type(buf, count, &action, &action_args);
>>         if (r) {
>> -               msg = "unknown uevent action string\n";
>> +               msg = "unknown uevent action string";
>>                 goto out;
>>         }
>>
>> @@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>>         r = kobject_action_args(action_args,
>>                                 count - (action_args - buf), &env);
>>         if (r == -EINVAL) {
>> -               msg = "incorrect uevent action arguments\n";
>> +               msg = "incorrect uevent action arguments";
>>                 goto out;
>>         }
>>
>> @@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>>  out:
>>         if (r) {
>>                 devpath = kobject_get_path(kobj, GFP_KERNEL);
>> -               pr_warn("synth uevent: %s: %s",
>> +               pr_warn("synth uevent: %s: %s\n",
>>                        devpath ?: "unknown device",
>>                        msg ?: "failed to send uevent");
>>                 kfree(devpath);
>> --
>> 2.11.0
>>
