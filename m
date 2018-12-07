Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C9C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1BF208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiHA1C5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C1BF208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeLGOnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:43:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46645 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeLGOnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:43:14 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so1804371pgp.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 06:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+m3IAR1X/OTOtjB9jc+ln1t5KBP5gteAtU+41d6GFpA=;
        b=PiHA1C5CsTT0u2FT3JDIbtpx3zYcgU9YC96EFEwXz0mYA25oy4Q+frTuVx5cIsaaXl
         N2YpdbUA5E54fQDMMyoIjwnJjNX+b+byhWCWVIZVhi1LdD9nc0R4lHohaGMrfB6Pz+q1
         Kjv6YkxLkZ5rKk41sSke1Su2AADr2Wi/e7FiN4qWTqzkiRjiXqE5wU5pKL6WYjsHM79a
         1mb4Jj9ZQcIzorfiFNFh7WlOiQyTZAfu/e6Ey31cVwV91tk8QrDPfkVb3HrEVGzrqnF3
         dQl68Jh//C91sTPniFznAoCXA1RANg1AWmvC7kl6GvgCUs6hNU4xZNdLcGGGb9thALmv
         YvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=+m3IAR1X/OTOtjB9jc+ln1t5KBP5gteAtU+41d6GFpA=;
        b=fVPhMbh5bQHeAeiu0gz95KqZX++njhPCtXckXEOZa3qjQ/0prSmgwota/0Z+kSIcLd
         d4D266smSH/pn0ClaYV6EfpKr1QIdNxF8Y8bC8UbZf7F4VgauAT58vyMxoJPYuVoly7o
         NusuiAc2+zCj3Bi6LiGvB92M+7Sd9CfNYJjpvcZRDUm8aID8hz6BIRiKqqaHzmOpy8TP
         QS7OpCnKHxEXzvM5LBkbWSUaRkQtU8HxYcVtNp6mEZWH5YmiJfQ3Z16Yq7QPNkKiUSIO
         jjHyeRmA8+yRlFpY00sjiW2XGeBdRWNZLgJH9h7V5RCTfYJIvnQ/FYaUc3qTKOOawzHx
         f6rw==
X-Gm-Message-State: AA+aEWaCOCLuqAxrBvYNVdzKPz+NoE/2SHavfWyfGsG+iPHxWs0W/5yQ
        TDFVz1KDrH+/CwKxPi9aYxI=
X-Google-Smtp-Source: AFSGD/V70JSNoj+arladIJEB1DWQDbHrdK2nHwjGxwxyKCTEYyLF1BWGeBCrKUD89YuRKNTdQUchcQ==
X-Received: by 2002:a63:7154:: with SMTP id b20mr2179159pgn.342.1544193793784;
        Fri, 07 Dec 2018 06:43:13 -0800 (PST)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id n68sm5310699pfb.62.2018.12.07.06.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:43:13 -0800 (PST)
Date:   Fri, 7 Dec 2018 09:43:12 -0500
From:   YU Bo <tsu.yubo@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, joe@perches.com,
        yuzibode@126.com
Subject: Re: [PATCH v3 2/2] kobject: drop newline from msg string
Message-ID: <20181207144311.oijj3lj53ojtlnyl@yubo-2>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, joe@perches.com, yuzibode@126.com
References: <cover.1544175417.git.tsu.yubo@gmail.com>
 <f03d23a34df36d55274c5cce7d4081d9017668c1.1544175417.git.tsu.yubo@gmail.com>
 <20181207120405.GC15336@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20181207120405.GC15336@kroah.com>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 01:04:05PM +0100, Greg KH wrote:
>On Fri, Dec 07, 2018 at 05:21:49AM -0500, Bo YU wrote:
>> There is currently a missing terminating newline in non-switch case
>> match, when msg == NULL.
>>
>> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
>> ---
>> Changes in v3:
>> Improve the commit log,requested by rafael.
>>
>> Changes in v2:
>> According to Joe's suggestion,drop newline from msg
>>
>>  lib/kobject_uevent.c | 11 ++++++-----
>>  1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> index b7c088c902a2..1837765ebf01 100644
>> --- a/lib/kobject_uevent.c
>> +++ b/lib/kobject_uevent.c
>> @@ -195,12 +195,12 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>>  	enum kobject_action action;
>>  	const char *action_args;
>>  	struct kobj_uevent_env *env;
>> -	const char *msg = NULL, *devpath;
>> +	const char *msg = NULL;
>
>Why did you move the devpath variable from here to lower down?  That
>really doesn't do anything :(
Hm...If i resend the one patch will be ok?
Or whole series?
>
>thanks,
>
>greg k-h
