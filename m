Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A629EC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DA6205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1NAz7nr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61DA6205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeKAU0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:26:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42456 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727644AbeKAU0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:26:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so8892388pgq.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v0SeJkknGz3q/Lv9yKR6sTgb2RV0so/rhhrkkVIJNcE=;
        b=H1NAz7nrGafM3wfSSz/dtqf/u/IhVVsaX06OnRXk9b+Z/bkiL+jk5cYMk342TGwJod
         bbmRuKPE1hJO6sZeyGv16tOdbQ62u6p3D2o2F6u2OxtV44nQYVWij9fBpdFSc7dNiZTC
         1DZ9hheUOmjQD5BZvJKcNDqZJ2dvK108Mtmy7GnjKm1DD7Lje9VUZc0FMBwoBkW6MX3O
         cRpWTuw9x/Ipy8T7dn16QDX9c1E4As9D7umjhOQQfG367jlY/ZG8mUZrmEFHhMcL4XRM
         rtcRqvWZ7xZqwVax4C7KKZZY5iKlGEy+NCXWg/+AevElXKCRIrKa2cQxGW56ddYTYktu
         NIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=v0SeJkknGz3q/Lv9yKR6sTgb2RV0so/rhhrkkVIJNcE=;
        b=G/T4tvh3UJVdPFB51hEYz0vl8RWhjow3XaAJBMPuP5vGF27DMQ8rLLCVrxvFoyCAs3
         Pu372dm+PZMkLouiYvoggSRRoelHd76EujE0yK43A0KNrHqFCHco0VlDYQvSBWuOPilT
         MZHQ0HNu0ijPuboJEIre5kwVULCCVjmltddv5lFR2/agdw+IQ9uFTFhUguqH3xL5XeBo
         lU5+U2Iq/pIQMzhADKTrZjFKYnHC81/wOX5i0t9uPu3d4hDShP3w5rSjet65M2AZ5X+T
         1GAZpV22bLIYkHvVTcgOHmvp2L5M56/zPFAhWtwqCFP7R4Od81NH/J+efhCIis/Kwm6F
         Qt/w==
X-Gm-Message-State: AGRZ1gJMtfS6mstBpv7lBxU3R81x2gHzsahIL74vWpkxPWItVI/OG8lD
        1EULi69wBKCQQXdwP8Zg5SM=
X-Google-Smtp-Source: AJdET5dlLs7sNzOeXMTxSc/Qsamt6uEAXtsT4foZMiTFDXcV+jg0ylI44yEgs1ZTStl5lMNJRvWQHQ==
X-Received: by 2002:a63:64c:: with SMTP id 73mr6733526pgg.373.1541071453802;
        Thu, 01 Nov 2018 04:24:13 -0700 (PDT)
Received: from yubo-2 ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id l5-v6sm53174211pfl.28.2018.11.01.04.24.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 04:24:13 -0700 (PDT)
Date:   Thu, 1 Nov 2018 07:24:12 -0400
From:   YU Bo <tsu.yubo@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] kobject: fix warnings use pr_* to replace  printk
Message-ID: <20181101112411.4itilpv7mruybiat@yubo-2>
Mail-Followup-To: Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1540886346.git.tsu.yubo@gmail.com>
 <bdfdef7349f54a69eb5c57764805b8eeb96a24ae.1540886346.git.tsu.yubo@gmail.com>
 <b12c68ec5dc34f69a3538a90a9a17e8d6b853b41.camel@perches.com>
 <20181031134109.7t3fy5p6uzj4tpa6@yubo-2>
 <4229ff1aa3d11cf302f6d0a4eec8e8f8f2bb919b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <4229ff1aa3d11cf302f6d0a4eec8e8f8f2bb919b.camel@perches.com>
User-Agent: NeoMutt/20180512-62-03f98a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:48:15AM -0700, Joe Perches wrote:
>On Wed, 2018-10-31 at 09:41 -0400, YU Bo wrote:
>> Hi,
>> On Tue, Oct 30, 2018 at 08:01:50AM -0700, Joe Perches wrote:
>> > On Tue, 2018-10-30 at 08:01 -0400, Bo YU wrote:
>> > > Fix warning from checkpatch.pl use pr_* to replace printk
>> >
>> > If you look at msg, it can be unterminated with newline.
>> >
>> > > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> > []
>> > > @@ -224,7 +224,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>> > >  out:
>> > >  	if (r) {
>> > >  		devpath = kobject_get_path(kobj, GFP_KERNEL);
>> > > -		printk(KERN_WARNING "synth uevent: %s: %s",
>> > > +		pr_warn("synth uevent: %s: %s",
>> > >  		       devpath ?: "unknown device",
>> > >  		       msg ?: "failed to send uevent");
>> > >  		kfree(devpath);
>> >
>> > Perhaps this block should be:
>> >
>> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
>> > index 63d0816ab23b..0ba1197f366e 100644
>> > --- a/lib/kobject_uevent.c
>> > +++ b/lib/kobject_uevent.c
>> > @@ -195,12 +195,12 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>> > 	enum kobject_action action;
>> > 	const char *action_args;
>> > 	struct kobj_uevent_env *env;
>> > -	const char *msg = NULL, *devpath;
>> > +	const char *msg = NULL;
>> > 	int r;
>> >
>> > 	r = kobject_action_type(buf, count, &action, &action_args);
>> > 	if (r) {
>> > -		msg = "unknown uevent action string\n";
>> > +		msg = "unknown uevent action string";
>> > 		goto out;
>> > 	}
>> >
>> > @@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>> > 	r = kobject_action_args(action_args,
>> > 				count - (action_args - buf), &env);
>> > 	if (r == -EINVAL) {
>> > -		msg = "incorrect uevent action arguments\n";
>> > +		msg = "incorrect uevent action arguments";
>> > 		goto out;
>> > 	}
>> >
>> > @@ -223,10 +223,11 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>> > 	kfree(env);
>> > out:
>> > 	if (r) {
>> > -		devpath = kobject_get_path(kobj, GFP_KERNEL);
>> > -		printk(KERN_WARNING "synth uevent: %s: %s",
>> > -		       devpath ?: "unknown device",
>> > -		       msg ?: "failed to send uevent");
>> > +		char *devpath devpath = kobject_get_path(kobj, GFP_KERNEL);
>> > +
>> > +		pr_warn("synth uevent: %s: %s\n",
>> > +			devpath ?: "unknown device",
>> > +			msg ?: "failed to send uevent");
>> > 		kfree(devpath);
>> > 	}
>> > 	return r;
>> Sorry, but i have two stupid questions to annoy you:
>> Q1: If i agree with your patch, here should i to do? Acked-by tag or others or nothing to do?
>
>Send V2 with content and explanation of what
>it does and why.
>
>> Q2: In fact, i do not know how to test the patch. Only to cat /sys/bus/pci/* or something?
>
>That wouldn't work as these go to dmesg only on
>certain conditions.
>
>It's a trivial patch, obviously correct.
Thank you, joe, i will do.
>
>
