Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBA4C282D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4E52183E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 01:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MmBv98yt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfBFBQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 20:16:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41436 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbfBFBQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 20:16:51 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1-v6so670849lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 17:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JCyx6KuFbLCLGQpa9xm4JThbUJkOmGj24qKOMLVE1ac=;
        b=MmBv98ytij7zVbHrJ94SV1Z/lgC1qE6z/iJ3w62+M8EGscVMjMEDEHeqi2nos+458/
         cP9rTUAtajKCqYzQ+K8NKifBYXSQ+FeLpT7rk49Pt4y9xENCczVysL16YwYRyrv68GrS
         Wte8IsaveR3vvY2hcWtq4QeJukMaxc3vl/WrCqrXe5gEFhFhrEBQvmMyx89jHcbQJSTr
         TFIGZ4HYNYxa2fT3iF1G56EXhFg/zWl0YDKcMhTli/J+OVa66i/OyYzc1QxmLjdiZbbL
         L7XcbHBAcDAkynw1nqGUmM7npQxyXjGqsVYcm6L11RhVGo09un02xSeKx+NfVjO3I3w6
         Pa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JCyx6KuFbLCLGQpa9xm4JThbUJkOmGj24qKOMLVE1ac=;
        b=HblAgEeET923YftiOQOgc6kD37JYnSuHVWQ9IeboasKvCDonXcgwp+GVRCzkB0XPrJ
         T2PP1T41yzL9lW1oqEi7N9Fqfw0FOP4EQ3RRbW8iSQOo7yg5PAh5OC8kGheDsQxGnksD
         L/n/7WtxmdhEjsxBZ3NbPto5cAFTNauvgFWk0vKnfyeKd7VsnriR7ENKjYCMtoniWQ3T
         fkEoRa+ZB2ux6AZNo4RsC2fiBGs4r2IkwgDZQn6eNURKCZSKRAHDZU7qDgjFJY9H17n1
         omPBbAI607tK8JKMTNPLG7j/zoz6pr9xyS7Trw6S/4FE5YkKxNSqklgO96TnuaLu0Knf
         67jA==
X-Gm-Message-State: AHQUAuYsJ7mkwgbQKzhDWcXqYXschSGmq5WIY+M1W1jnWqS8SyeMlfis
        KsIz5VuDT+FT64fjVNcYXFnBiyct8SfhNwnIiwFGHg==
X-Google-Smtp-Source: AHgI3Ia6kGrBiem/P/1qbAbgJOSuMaKdJnNcXwYrsgeBRuMkY948xbE/3H2oBOKlxcotGi4AbVVcl7ETtWnpDI1/qwU=
X-Received: by 2002:a2e:5c07:: with SMTP id q7-v6mr4515618ljb.119.1549415809028;
 Tue, 05 Feb 2019 17:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20190131002502.14525-1-christian@brauner.io>
In-Reply-To: <20190131002502.14525-1-christian@brauner.io>
From:   Todd Kjos <tkjos@google.com>
Date:   Tue, 5 Feb 2019 17:16:37 -0800
Message-ID: <CAHRSSExnE1LMckz-2LB-08BWq9Czj0KXAXEx-F4Qj98Hhq3xSg@mail.gmail.com>
Subject: Re: [PATCH v1] binderfs: remove separate device_initcall()
To:     Christian Brauner <christian@brauner.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 4:25 PM Christian Brauner <christian@brauner.io> wrote:
>
> binderfs should not have a separate device_initcall(). When a kernel is
> compiled with CONFIG_ANDROID_BINDERFS register the filesystem alongside
> CONFIG_ANDROID_IPC. This use-case is especially sensible when users specify
> CONFIG_ANDROID_IPC=y, CONFIG_ANDROID_BINDERFS=y and
> ANDROID_BINDER_DEVICES="".
> When CONFIG_ANDROID_BINDERFS=n then this always succeeds so there's no
> regression potential for legacy workloads.
>
> Signed-off-by: Christian Brauner <christian@brauner.io>

Acked-by: Todd Kjos <tkjos@google.com>

>
> ---
> /* Changelog */
> - ensure that device_name is set to NULL so kfree() doesn't freak out
> ---
>  drivers/android/binder.c          | 7 ++++++-
>  drivers/android/binder_internal.h | 9 +++++++++
>  drivers/android/binderfs.c        | 4 +---
>  3 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 57cf259de600..4d2b2ad1ee0e 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5854,9 +5854,10 @@ static int __init init_binder_device(const char *name)
>  static int __init binder_init(void)
>  {
>         int ret;
> -       char *device_name, *device_names, *device_tmp;
> +       char *device_name, *device_tmp;
>         struct binder_device *device;
>         struct hlist_node *tmp;
> +       char *device_names = NULL;
>
>         ret = binder_alloc_shrinker_init();
>         if (ret)
> @@ -5917,6 +5918,10 @@ static int __init binder_init(void)
>                 }
>         }
>
> +       ret = init_binderfs();
> +       if (ret)
> +               goto err_init_binder_device_failed;
> +
>         return ret;
>
>  err_init_binder_device_failed:
> diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> index 7fb97f503ef2..045b3e42d98b 100644
> --- a/drivers/android/binder_internal.h
> +++ b/drivers/android/binder_internal.h
> @@ -46,4 +46,13 @@ static inline bool is_binderfs_device(const struct inode *inode)
>  }
>  #endif
>
> +#ifdef CONFIG_ANDROID_BINDERFS
> +extern int __init init_binderfs(void);
> +#else
> +static inline int __init init_binderfs(void)
> +{
> +       return 0;
> +}
> +#endif
> +
>  #endif /* _LINUX_BINDER_INTERNAL_H */
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 7a550104a722..e773f45d19d9 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -550,7 +550,7 @@ static struct file_system_type binder_fs_type = {
>         .fs_flags       = FS_USERNS_MOUNT,
>  };
>
> -static int __init init_binderfs(void)
> +int __init init_binderfs(void)
>  {
>         int ret;
>
> @@ -568,5 +568,3 @@ static int __init init_binderfs(void)
>
>         return ret;
>  }
> -
> -device_initcall(init_binderfs);
> --
> 2.20.1
>
