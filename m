Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855DBC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7D0A20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kOGoh+5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7D0A20894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732065AbeGaAlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:41:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36428 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeGaAlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:41:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id u7-v6so12002344lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 16:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5eAxge3UX1cjtPEnMODz+hkFYEF7XI/MZyOJ8LnakI=;
        b=kOGoh+5oOk0ZDFxvYvm/96XFdzmKe+v5g2qt9lYCQqMmFiSpdOg0vZZfc8FxjsZVYg
         Hg3hRqMFvrAK04oz9HVep2Dt+CFAYyXeF5fbtvU5a7jbixvu4AflsPmD3IeH4q3jwZod
         PR1441mdO/b1i6b4AUcx/QosebKrnsgTCzhNlc5j1pgHTc86HlDRnP4nHPd3yeldLqpv
         GopUZXaaHM+0JWamVTcfjyblHDjxsNYY5TOwZXGrIgZ3iQ+uy30i5wfyLyYzofx1bgs0
         0v6NXOxAMO9pSQbvCK3/JnkuojdPXJ7E2rFiGe9F4S0iehDx/dcf2uBPmAMCpTZGm3ao
         BRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5eAxge3UX1cjtPEnMODz+hkFYEF7XI/MZyOJ8LnakI=;
        b=ToHTGTFcrdSCoIIsFnjxZw6PNfOQ7J3SMxw43f5mIWXNYM4gUhQ8iILZZteY7Q6CS3
         9sshxAvlWQn0BhRBPiRgMH9JIkaNnW2NeFlv7r5C96ek0fasJbXhj+u5cvHHFEClJSbC
         uh/MitnLk7/ZszTfr9x9VYZLzR0mjYsTKZWYjn8UOMjsKh0JiE/oTpxgadgakFuAbege
         lZqtFt51BGVWO0TNEBjfeCfyyul4rqLb63bsFzstrO2XJt5/fAc39vo6wQ+UNjLcbY+E
         Hl7z8oPz884mV59dETtmFt2gAoUnYcx67cG+gKJUsGZGeK5tx8la04Oxe9xAE2z0JI4m
         gAig==
X-Gm-Message-State: AOUpUlFe10fI3ax/DnsMjKGNqt+PFlbXVQ4v7AudxPmeYQxwcQBKEkq6
        DE0fPVZd/lxkIRdzTDxrpYwlPi4a9zAgxaB/gZ/h
X-Google-Smtp-Source: AAOMgpc3+436UUTMrOhJ1IfXGqIjZsgbIWSI79Fu2NHXwLyl4t1N27F6ND/L5tENf4ol3v28WSW55KYym0XuKW9ASe0=
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr13757926lje.70.1532991869729;
 Mon, 30 Jul 2018 16:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <1532485579-34431-1-git-send-email-wang.yi59@zte.com.cn>
In-Reply-To: <1532485579-34431-1-git-send-email-wang.yi59@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 30 Jul 2018 19:04:18 -0400
Message-ID: <CAHC9VhRo8xohn+iayiEet54tUPGjQxzQ4oqCD3WSGX=9X_YHsA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: fix potential null dereference 'context->module.name'
To:     wang.yi59@zte.com.cn
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:28 PM Yi Wang <wang.yi59@zte.com.cn> wrote:
> The variable 'context->module.name' may be null pointer when
> kmalloc return null, so it's better to check it before using
> to avoid null dereference.
> Another one more thing this patch does is using kstrdup instead
> of (kmalloc + strcpy), and signal a lost record via audit_log_lost.
>
> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
> v2: use kstrdup instead of kmalloc + strcpy, and signal a lost
> record. Thanks to Eric and Paul.
>
>  kernel/auditsc.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Thanks, this looks good to me.  I'm also going to tag this for -stable.

I'm building a test kernel right now and if all goes well I'll send
this up to Linus for v4.18; if he doesn't pull it for v4.18 I'll add
this to the audit/next branch.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index e80459f..713386a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1272,8 +1272,12 @@ static void show_special(struct audit_context *context, int *call_panic)
>                 break;
>         case AUDIT_KERN_MODULE:
>                 audit_log_format(ab, "name=");
> -               audit_log_untrustedstring(ab, context->module.name);
> -               kfree(context->module.name);
> +               if (context->module.name) {
> +                       audit_log_untrustedstring(ab, context->module.name);
> +                       kfree(context->module.name);
> +               } else
> +                       audit_log_format(ab, "(null)");
> +
>                 break;
>         }
>         audit_log_end(ab);
> @@ -2408,8 +2412,9 @@ void __audit_log_kern_module(char *name)
>  {
>         struct audit_context *context = current->audit_context;
>
> -       context->module.name = kmalloc(strlen(name) + 1, GFP_KERNEL);
> -       strcpy(context->module.name, name);
> +       context->module.name = kstrdup(name, GFP_KERNEL);
> +       if (!context->module.name)
> +               audit_log_lost("out of memory in __audit_log_kern_module");
>         context->type = AUDIT_KERN_MODULE;
>  }
>
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
