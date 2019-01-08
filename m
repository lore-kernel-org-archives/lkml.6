Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C85AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687CC20827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJiGJT09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfAHMyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 07:54:02 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41324 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbfAHMyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 07:54:01 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so4091037edc.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 04:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ppW4chTqXj2TTlfsBrWJm50OYmgOQxIkY03mYwfkNZc=;
        b=OJiGJT09l3/wm2QMUc8fC0VRNOL4hcxk2HiXfGCnn7Nj7eb0slUp3evdkKFCBsdTOj
         TngC97b3Ppa2d75iIvcZzwz7a4bUfKqJ/5CncVyGGvaOwD7ECleDWpTN5W4pe3Uhi6T1
         iFD9zGclGj625JAZUDSjCZWgdn4TiJOVetcTxn9ywL+mKnk9syx+GLKpAutWCvhKoyQg
         dFM3NR0+tmSJQ2YAMcZAqe6+rnKYBkThBFREDjuCG/PxMdHDg+zJInUbXZHnjzHdLl/D
         eXFbW8XRteSpe9PNUQvXZOtKKMmoWblR2Ws0QgQEFoftcgwRa6mrr+utu7kOXSqfyDs8
         SOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ppW4chTqXj2TTlfsBrWJm50OYmgOQxIkY03mYwfkNZc=;
        b=XBEFxwUq6eZBOwj4rrriLhgM5gYs+aCKR9bKRKwC/iAf4/ZN719K+3bw3yaTWK+ugA
         dq930ewUdWoGmpOnb0MZQIGZQOgMJWOARqg3t0jDlaIj/5UaGvaiQ41+UYr1vosmnKWh
         nLr7qxxN1va+Fv3O8qw/TEajeumfTm5RMIHnuuPF5JPYZDLaGc4+gv/eAkMdELEAW4ul
         DkFsfGJT2hobBP3c7ZRq0f1bGvbtur4lnMEq84a+vaZelVSkilqfpkqVa7VBaWCq4o8Q
         qyk3X3y/ppS+qkk7oUL/XwhrYQkxjnuAk7ZsSZ7ydAPThXxLlfMfgBbklDORKTSnsly+
         9mOA==
X-Gm-Message-State: AJcUukcUkB61zsObKEoKtzRnmhpF4hiDOTYNjJuYuRBPIXrpGBlumIoN
        2mlW6t+4sCdSpedGiyeKWRs=
X-Google-Smtp-Source: ALg8bN6UHNPCCLJx4jaK/OtUixehuuZbltmJe4fzSqDKCi8zqmootO3EU+JKx2T5yVOS5phm6QZFgw==
X-Received: by 2002:a50:ab82:: with SMTP id u2mr2022781edc.111.1546952039894;
        Tue, 08 Jan 2019 04:53:59 -0800 (PST)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id r42sm32658228edd.23.2019.01.08.04.53.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 04:53:59 -0800 (PST)
Date:   Tue, 8 Jan 2019 07:53:56 -0500
From:   YU Bo <tsu.yubo@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, yuzibode@126.com
Subject: Re: [PATCH v4 1/2] kobject: use pr_warn to replace printk
Message-ID: <20190108125355.yc7ryyl34s2me4z7@yubo-2>
Mail-Followup-To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>, yuzibode@126.com
References: <cover.1546915794.git.tsu.yubo@gmail.com>
 <8c73ad4b2b29bda53f2dfb6624b8b7984b52e307.1546915794.git.tsu.yubo@gmail.com>
 <CAJZ5v0iiPKNVz3SE1oumOUDPGTrCHd5-hEoe6O=SsqSKD39XNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iiPKNVz3SE1oumOUDPGTrCHd5-hEoe6O=SsqSKD39XNg@mail.gmail.com>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, Jan 08, 2019 at 10:39:57AM +0100, Rafael J. Wysocki wrote:
>On Tue, Jan 8, 2019 at 4:11 AM Bo YU <tsu.yubo@gmail.com> wrote:
>>
>> This is a fix to replace printk with pr_warn
>
>You call it a "fix", but what exactly is wrong with the code as is?
Is there any differentions between pr_* and printk?
If they were the same with functionial, i think it  would be better
to use pr_* to replace printk.There are two lines code with printk only
and others are pr_* in kobject_uevent.c.
In fact,as you know, the code is fine.I just want to keep consistency with
looks like
Thanks
>
>> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
>> ---
>>  lib/kobject_uevent.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> index 27c6118afd1c..499dfcdafcb0 100644
>> --- a/lib/kobject_uevent.c
>> +++ b/lib/kobject_uevent.c
>> @@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>>  out:
>>         if (r) {
>>                 devpath = kobject_get_path(kobj, GFP_KERNEL);
>> -               printk(KERN_WARNING "synth uevent: %s: %s",
>> +               pr_warn("synth uevent: %s: %s",
>>                        devpath ?: "unknown device",
>>                        msg ?: "failed to send uevent");
>>                 kfree(devpath);
>> --
>> 2.11.0
>>
