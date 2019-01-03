Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BCBC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14CF2184B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBElct8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfACUZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:25:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34601 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfACUZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:25:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so30816452lje.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 12:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zp4ONwVhSrOAGCBr8XdvNaVeQ4j2NYgbK7Hle4PIX0=;
        b=ZBElct8B16fincxcBvQZr6euiXN33OklGsc95g9GYeS5YmEddEd+wgSCTvXp6Yu9kK
         33YkxzNiqG6zHTHRv0pqq3oqip1BiCDlMAz8lHS51W5Uz5doK+6Teu32QGVp53U3NE2g
         FYV+6N5WLP8SFAa/NMa2BdgxkXx6C5abVHkWhCaoVafT7SIC0kHSVDAVPeElu1+kct+D
         Ov0f1xeJAqVn5WvWPC8qb40EsapngCymXURHi5V5hHA4WFJS1HOpTj9PWDohSP7uHEdE
         bAdbrshk74UREcePcjEEQgIjBBFp75RHCW4W4nZe9ijY+KOGLAcRCfAGzpV9Ra181L+5
         wkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zp4ONwVhSrOAGCBr8XdvNaVeQ4j2NYgbK7Hle4PIX0=;
        b=FoC5DzADW6G4z8Mut4qxza88QMFkSmqdiAt+J7sMBKA0gXMCSF1u4ZFz91K3zKqCNE
         nkQHsGg52IugBZF4B1gWxiIbSpFitevr4hOM+6GNpBvVOTkLkOZ5s3NVj6A99aj2Rcku
         IRC/1EQKdN0sbIo5QBr3JLBcM8ZXmWOlyNle2W00D6Tv0BiwCLQqelhcRlE/XZH+IF8g
         Awmy+s+5YFZ3icQjkBf9Xs4JD7g757wjZCfh7rhlCmvBh+Md6zbk821R8DfxMvm4A/sc
         lvLGaKQalmu3eI+Yck82iqH4As+YxKOUVmPmsRWBeR2N7jlomU0zm59vruUBIDO/Ff5l
         L/Jw==
X-Gm-Message-State: AJcUukfpJ9rYPB1429lCDaLHpHqY1f0+aQ/TSOi2x4OqUGoodpfDXb03
        oSz0DhrDH1pavCr0nYUQPVxkdZZW4Q2vxIlneYhiAw==
X-Google-Smtp-Source: ALg8bN4/45dtUfoDrp3s9zkzpMtPL8k43Rr+MbVRtlk2MXNSiDV02vHnjL98qdm2F6YdjtRA0eIbIDGXRy6O1ApkbzY=
X-Received: by 2002:a2e:29d7:: with SMTP id p84-v6mr27200151ljp.12.1546547135540;
 Thu, 03 Jan 2019 12:25:35 -0800 (PST)
MIME-Version: 1.0
References: <20181223143550.10672-1-christian@brauner.io> <20181223143550.10672-2-christian@brauner.io>
In-Reply-To: <20181223143550.10672-2-christian@brauner.io>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 3 Jan 2019 12:25:24 -0800
Message-ID: <CAHRSSEythiuV6HH9c-q5TwU=tDyZ-K5gjgF+uYZmd6pmAJTovw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] binderfs: reserve devices for initial mount
To:     Christian Brauner <christian@brauner.io>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@android.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>, joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 6:36 AM Christian Brauner <christian@brauner.io> wrote:
>
> The binderfs instance in the initial ipc namespace will always have a
> reserve of 4 binder devices unless explicitly capped by specifying a lower
> value via the "max" mount option.
> This ensures when binder devices are removed (on accident or on purpose)
> they can always be recreated without risking that all minor numbers have
> already been used up.
>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
> v1:
> - patch introduced
> v0:
> - patch not present
> ---
>  drivers/android/binderfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 873adda064ac..aa635c7ea727 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -40,6 +40,8 @@
>  #define INODE_OFFSET 3
>  #define INTSTRLEN 21
>  #define BINDERFS_MAX_MINOR (1U << MINORBITS)
> +/* Ensure that the initial ipc namespace always has a devices available. */
> +#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)

Why do you ever need more minors per instance than the number of
devices listed in CONFIG_ANDROID_BINDER_DEVICES?

>
>  static struct vfsmount *binderfs_mnt;
>
> @@ -129,11 +131,14 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>         struct inode *inode = NULL;
>         struct super_block *sb = ref_inode->i_sb;
>         struct binderfs_info *info = sb->s_fs_info;
> +       bool use_reserve = (info->ipc_ns == &init_ipc_ns);
>
>         /* Reserve new minor number for the new device. */
>         mutex_lock(&binderfs_minors_mutex);
>         if (++info->device_count <= info->mount_opts.max)
> -               minor = ida_alloc_max(&binderfs_minors, BINDERFS_MAX_MINOR,
> +               minor = ida_alloc_max(&binderfs_minors,
> +                                     use_reserve ? BINDERFS_MAX_MINOR :
> +                                                   BINDERFS_MAX_MINOR_CAPPED,
>                                       GFP_KERNEL);
>         else
>                 minor = -ENOSPC;
> --
> 2.19.1
>
