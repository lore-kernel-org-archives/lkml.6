Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72461C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4235520827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4235520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387501AbeKFRNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:13:24 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33311 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFRNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:13:24 -0500
Received: by mail-ot1-f65.google.com with SMTP id q1so10622626otk.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 23:49:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TM4UXZCRQ2i5Im90yTxafe3arw7a7mxBy1/Au+6raP8=;
        b=n/0EBquozKcf82NynTzinRb2ylwkoHpMC9/G0B77Jprff3LzGBVYl71BaU9LJd/Opj
         a/6JGB9bCqeMHEeivURliOJ80pAD8RR9vVbqHxU01Z3Y59+yFADRYbTfsQ1LbeNCi/Ul
         3BwmRZC190atYr5g3TPmf7bYWcWaQQUaORudDHFO41Yjtg9ZGrbPWWddblfUd6nu4WVr
         97dIjBfvnGnjcLVIcyeabdwMRtcgsN4rUoeMRJlJLlkKn53aOgKUMgUG0c0ToJUq2BBI
         JCRJs9weEEUbS4jBOcY1s6Zg5EIvnEuhk+VhhSQ7FTZu/Nvl9urvuv/HSY9RdPkhwI0/
         sAcw==
X-Gm-Message-State: AGRZ1gKYPKTHecr1BjFuI4DqE8ZOTKkgM2xnD7X3kNhhpVDjqUyfuMis
        RAS9kbUTdILq3vfDIz+k8LLYYhBv93EL/0A/nzUEdw==
X-Google-Smtp-Source: AJdET5fCm6uB3PWb6UMsuAtngXsrwZ3mcr6xhZNVi7Saz7NA3brNZG5YynA8NwBuleJH2lCH/8gdTnJsL4LLHk3o3mo=
X-Received: by 2002:a9d:4c84:: with SMTP id m4mr9646695otf.124.1541490567300;
 Mon, 05 Nov 2018 23:49:27 -0800 (PST)
MIME-Version: 1.0
References: <1541472103-6212-1-git-send-email-tsu.yubo@gmail.com>
In-Reply-To: <1541472103-6212-1-git-send-email-tsu.yubo@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 6 Nov 2018 08:49:15 +0100
Message-ID: <CAJZ5v0gzM+_a+HJa_kjpgaj96iiH3f_x1ZXjK3HE8=E5FvuAPA@mail.gmail.com>
Subject: Re: [PATCH v2] kobject: to use pr_warn replace KERN_WARNING
To:     tsu.yubo@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 3:42 AM Bo YU <tsu.yubo@gmail.com> wrote:
>
> Fix warning form checkpatch, use pr_warn replace KERN_WARNING
>
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>

First off, IMO, you should not change the existing code just in order
to make checkpatch happy about it.  That alone is not a good enough
reason for modifying it.

If the checkpatch warning indicates an issue like broken white space
(and I mean really broken and not lines longer than 80 chars etc),
then that may be a reason to modify the existing code, depending.

> ---
> changes in v2:
> According to Joe's suggestion,drop newline from msg, otherwise
> it can be unterminated with newline.
> ---
>  lib/kobject_uevent.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> index 63d0816ab23b..1837765ebf01 100644
> --- a/lib/kobject_uevent.c
> +++ b/lib/kobject_uevent.c
> @@ -195,12 +195,12 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>         enum kobject_action action;
>         const char *action_args;
>         struct kobj_uevent_env *env;
> -       const char *msg = NULL, *devpath;
> +       const char *msg = NULL;
>         int r;
>
>         r = kobject_action_type(buf, count, &action, &action_args);
>         if (r) {
> -               msg = "unknown uevent action string\n";
> +               msg = "unknown uevent action string";
>                 goto out;
>         }
>
> @@ -212,7 +212,7 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>         r = kobject_action_args(action_args,
>                                 count - (action_args - buf), &env);
>         if (r == -EINVAL) {
> -               msg = "incorrect uevent action arguments\n";
> +               msg = "incorrect uevent action arguments";

Second, this change is not what the changelog of your patch is talking about.

>                 goto out;
>         }
>
> @@ -223,8 +223,9 @@ int kobject_synth_uevent(struct kobject *kobj, const char *buf, size_t count)
>         kfree(env);
>  out:
>         if (r) {
> -               devpath = kobject_get_path(kobj, GFP_KERNEL);
> -               printk(KERN_WARNING "synth uevent: %s: %s",
> +               char *devpath = kobject_get_path(kobj, GFP_KERNEL);
> +
> +               pr_warn("synth uevent: %s: %s\n",
>                        devpath ?: "unknown device",
>                        msg ?: "failed to send uevent");
>                 kfree(devpath);
> --
> 2.11.0
>
