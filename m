Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A97FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB9D20651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HW/e6EYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394479AbfAPRGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 12:06:34 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36844 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbfAPRGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 12:06:33 -0500
Received: by mail-vs1-f68.google.com with SMTP id v205so4381831vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KslaoNLbpk8QO+HmkVMr/iXKmgwVzbEFp1BIG5K/3bg=;
        b=HW/e6EYu4TNDqYm2BPgSFDoihTciGw7xwrfQuP3CSnhOxHg6xAhNCFrtKR6Zso3MbP
         8WgEXp0jELztyZloJwmm6ui1YO/ig2BIYLUvUSRLVBHgc7exrvNth+0qiTYsaJ4toxRX
         fPjvRi9WjyL8iySip8Vgq9Kfth5Z0mqHbQOaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KslaoNLbpk8QO+HmkVMr/iXKmgwVzbEFp1BIG5K/3bg=;
        b=DMGZ2l6kabQdYJtO+UFH0+GWHcfSN/x0FZbaKTg7aUlnrTis/yfm5CR7GguJPE8VHJ
         /CEAJVX9A5HW0Pa4A71s460lkPe8xSsAWhrTtg0928pQnl4Q5KC04O1gYNeJhI9GnnLV
         INAtbgQeBXo0L4Wtp+Cq6vHfeMmJWLEo3boPhwQJr0L7rzDrmO4t05rTi0JS8GboZ37d
         Oa+/QgI4atXdcZEz1qxRYJxVmuxrvJdMKZz1kJ7MT8nqJR/MdeItg1In7KdhHy+ztSbK
         keP6EcsfuZn7RXE3TypxegRB/GPUKQi5WNOiXjeIv9uQDMy4+leiHcOom3wGOWQjVip0
         EBeQ==
X-Gm-Message-State: AJcUuke+4ndd5KFFEdgN9oLrO8/w+e67J7u53ydP8JPyIsOt2i/nMB8k
        b2cFLXpieXQkTzCZq4BBuw1uWqYC7L8=
X-Google-Smtp-Source: ALg8bN560WnUtUri/YhsWTH6mODsA6MBgk/PVYD1g9jyXhA4W9zU25LCSabPWU+YBPTFBrwfKevoHw==
X-Received: by 2002:a67:a944:: with SMTP id s65mr4061163vse.108.1547658391632;
        Wed, 16 Jan 2019 09:06:31 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id w65sm15187973vsc.16.2019.01.16.09.06.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 09:06:30 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id x28so4335427vsh.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 09:06:30 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr4168154vsl.188.1547658389570;
 Wed, 16 Jan 2019 09:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20190116125422.19643-1-vincent.whitchurch@axis.com>
In-Reply-To: <20190116125422.19643-1-vincent.whitchurch@axis.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 16 Jan 2019 09:06:18 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+dM867PJKR+eHjhUjZvsih5ndHmGJY3y+yWGMf2-gg4w@mail.gmail.com>
Message-ID: <CAGXu5j+dM867PJKR+eHjhUjZvsih5ndHmGJY3y+yWGMf2-gg4w@mail.gmail.com>
Subject: Re: [PATCH] sysctl: Add panic-fatal-signals
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <rabinv@axis.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 4:54 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Add a sysctl which asks the kernel to panic when any userspace process
> receives a fatal signal which would trigger a core dump.  This has
> proven to be quite useful when debugging problems seen during testing of
> embedded systems:  When combined with kernel core dumps (saved due to
> the panic), it allows easier debugging of crashes which have their
> origin in system-wide problems such as buggy drivers or other kernel or
> hardware-related issues.
>
> The crashing process's core dump can be extracted from the kernel core
> dump using tools such as the crash utility's gcore extension.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Whoa. That's intense. :) If you have a use-case for it, then I guess I
can't complain. Given that this is an instant DoS for a system that
isn't expecting it, I do wonder if it should live behind a CONFIG or
something to make it available only when really wanted?

-Kees

> ---
>  include/linux/signal.h | 1 +
>  kernel/signal.c        | 5 ++++-
>  kernel/sysctl.c        | 7 +++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index cc7e2c1cd444..109efd1432e9 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -10,6 +10,7 @@ struct task_struct;
>
>  /* for sysctl */
>  extern int print_fatal_signals;
> +extern int panic_fatal_signals;
>
>  static inline void copy_siginfo(kernel_siginfo_t *to,
>                                 const kernel_siginfo_t *from)
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e1d7ad8e6ab1..83c6877b0182 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -59,6 +59,7 @@
>  static struct kmem_cache *sigqueue_cachep;
>
>  int print_fatal_signals __read_mostly;
> +int panic_fatal_signals __read_mostly;
>
>  static void __user *sig_handler(struct task_struct *t, int sig)
>  {
> @@ -2497,8 +2498,10 @@ bool get_signal(struct ksignal *ksig)
>                 current->flags |= PF_SIGNALED;
>
>                 if (sig_kernel_coredump(signr)) {
> -                       if (print_fatal_signals)
> +                       if (print_fatal_signals || panic_fatal_signals)
>                                 print_fatal_signal(ksig->info.si_signo);
> +                       if (panic_fatal_signals)
> +                               panic("Fatal signal and panic_fatal_signals=1");
>                         proc_coredump_connector(current);
>                         /*
>                          * If it was able to dump core, this kills all
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ba4d9e85feb8..ad1ac6ec2004 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -557,6 +557,13 @@ static struct ctl_table kern_table[] = {
>                 .mode           = 0644,
>                 .proc_handler   = proc_dointvec,
>         },
> +       {
> +               .procname       = "panic-fatal-signals",
> +               .data           = &panic_fatal_signals,
> +               .maxlen         = sizeof(int),
> +               .mode           = 0644,
> +               .proc_handler   = proc_dointvec,
> +       },
>  #ifdef CONFIG_SPARC
>         {
>                 .procname       = "reboot-cmd",
> --
> 2.20.0
>


-- 
Kees Cook
