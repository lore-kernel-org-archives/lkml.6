Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A117BC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675C920883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 09:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546507812;
	bh=c8UlAL0HywmzXBeyUvA7XHXwnqHiC7Q7AScqu01u6S0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vI0dy4CH1jhzk9WgAqTwVQjZMrlI5gI1BY1RUkSVm1zuRtn4l7NMYX8tIes4Xa44s
	 6kAI6920L/vGHG6RobvqeOOKva2AUb+OgiOiKr/Badji+oJIdQKuv2YM0Th4R/NAUT
	 dSmf9Xp4VkLa2ELu59brCxaTPUt1J1JCPCH5VkqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfACJaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 04:30:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39991 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfACJaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 04:30:10 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so28889495oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 01:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbOPGJ3IJDcBrfRMPKv/jkAuNaYdqSWYsR7bgi+yrfw=;
        b=KnFM4Gg0TPGgQasu3oa5FSQe4C7cFfqNl8c6peQz7Esq4SJmtfeGMhxnXDaPLTtfE+
         a57RjJ7ibzltKIVQBGnB5BwnCXdKEYixtLYsNjxeQInYkL63DYJGArVULvXOJlDpAwK5
         D7gna5QlopFPa4vR2bjj60JRArIi8S62uEisLNizoYN8DqvVKFJcDnH1yWaTn2nj797f
         8kIYvsPDKIukiMvzxoSzF35H+W1+Giuo5pBW0hQ6XD3/9ATCMpQXwccZjAETdg+5FC3Z
         r8Sm4BZx+3tY2e4rf9ZgDf76CzEwhRp8n5Tla940bvsWkVD/zGKwpRYXj+9zrokLJwT6
         Iulg==
X-Gm-Message-State: AJcUukfh2/AxX5GSOt18j3mYGg+2MBqh2RbgExkL70hSqjEEsPKsPII4
        P13onwecLs7mWh71QVU/4Jvc6HHg8CRZhYHcExU=
X-Google-Smtp-Source: ALg8bN5Lt2ZpimpKtORUiB8U0JrHyQgwqEgaTKtLPq8ygwM212PbjXsm8Z85LkZ1Nc+IRSCm/uSR6R5WJo1yfc0fI7c=
X-Received: by 2002:a9d:7f0d:: with SMTP id j13mr30873358otq.119.1546507809667;
 Thu, 03 Jan 2019 01:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20190102005704.GC17624@shao2-debian> <CAHk-=wh2sparb1qw4h5QTCR+YF7xsssLgZtNtthRA6QiJjKfbA@mail.gmail.com>
 <CAJZ5v0hXEqtaiV56sGCOd1VzsRETkS39YiLV-OfnFWiZH4tcAQ@mail.gmail.com> <20190103092622.GA6262@kroah.com>
In-Reply-To: <20190103092622.GA6262@kroah.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Jan 2019 10:29:58 +0100
Message-ID: <CAJZ5v0jQP-hYHva4xoTxgf815DTSp4MBnF__XPt3cViWF5=zcQ@mail.gmail.com>
Subject: Re: [LKP] [mtd] c4dfa25ab3: kernel_BUG_at_fs/sysfs/file.c
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Alban Bedel <albeu@free.fr>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 3, 2019 at 10:26 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 02, 2019 at 10:44:50PM +0100, Rafael J. Wysocki wrote:
> > On Wed, Jan 2, 2019 at 8:53 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >
> > [cut]
> >
> > > Greg, Rafael: it does strike me that the "BUG_ON()" in
> > > sysfs_create_file_ns() could easily have been a
> > >
> > >         if (WARN_ON(..))
> > >                 return -EINVAL;
> > >
> > > which would have made the machine boot and probably make things easier
> > > for normal users to report. The kernel test robot doesn't care, but
> > > non-booting kernels are usually not nice to debug or report for normal
> > > human beings..
> >
> > I agree.
> >
> > This isn't a good enough reason to crash the kernel IMO.
>
> I agree too.
>
> Here's a patch for this, I'll queue it up after -rc1 is out.  Rafael,
> look good to you?

Yes, it does.

Please feel free to add

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to it.

>
> --------------
>
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Subject: [PATCH] sysfs: convert BUG_ON to WARN_ON
>
> It's rude to crash the system just because the developer did something
> wrong, as it prevents them from usually even seeing what went wrong.
>
> So convert the few BUG_ON() calls that have snuck into the sysfs code
> over the years to WARN_ON() to make it more "friendly".  All of these
> are able to be recovered from, so it makes no sense to crash.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/sysfs/dir.c     | 3 ++-
>  fs/sysfs/file.c    | 6 ++++--
>  fs/sysfs/group.c   | 3 ++-
>  fs/sysfs/symlink.c | 3 ++-
>  4 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
> index feeae8081c22..aa85f2874a9f 100644
> --- a/fs/sysfs/dir.c
> +++ b/fs/sysfs/dir.c
> @@ -43,7 +43,8 @@ int sysfs_create_dir_ns(struct kobject *kobj, const void *ns)
>         kuid_t uid;
>         kgid_t gid;
>
> -       BUG_ON(!kobj);
> +       if (WARN_ON(!kobj))
> +               return -EINVAL;
>
>         if (kobj->parent)
>                 parent = kobj->parent->sd;
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index bb71db63c99c..51398457fe00 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -325,7 +325,8 @@ int sysfs_create_file_ns(struct kobject *kobj, const struct attribute *attr,
>         kuid_t uid;
>         kgid_t gid;
>
> -       BUG_ON(!kobj || !kobj->sd || !attr);
> +       if (WARN_ON(!kobj || !kobj->sd || !attr))
> +               return -EINVAL;
>
>         kobject_get_ownership(kobj, &uid, &gid);
>         return sysfs_add_file_mode_ns(kobj->sd, attr, false, attr->mode,
> @@ -537,7 +538,8 @@ int sysfs_create_bin_file(struct kobject *kobj,
>         kuid_t uid;
>         kgid_t gid;
>
> -       BUG_ON(!kobj || !kobj->sd || !attr);
> +       if (WARN_ON(!kobj || !kobj->sd || !attr))
> +               return -EINVAL;
>
>         kobject_get_ownership(kobj, &uid, &gid);
>         return sysfs_add_file_mode_ns(kobj->sd, &attr->attr, true,
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index 1eb2d6307663..57038604d4a8 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -112,7 +112,8 @@ static int internal_create_group(struct kobject *kobj, int update,
>         kgid_t gid;
>         int error;
>
> -       BUG_ON(!kobj || (!update && !kobj->sd));
> +       if (WARN_ON(!kobj || (!update && !kobj->sd)))
> +               return -EINVAL;
>
>         /* Updates may happen before the object has been instantiated */
>         if (unlikely(update && !kobj->sd))
> diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
> index 215c225b2ca1..c4deecc80f67 100644
> --- a/fs/sysfs/symlink.c
> +++ b/fs/sysfs/symlink.c
> @@ -23,7 +23,8 @@ static int sysfs_do_create_link_sd(struct kernfs_node *parent,
>  {
>         struct kernfs_node *kn, *target = NULL;
>
> -       BUG_ON(!name || !parent);
> +       if (WARN_ON(!name || !parent))
> +               return -EINVAL;
>
>         /*
>          * We don't own @target_kobj and it may be removed at any time.
> --
