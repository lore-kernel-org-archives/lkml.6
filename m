Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E66FC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF0420B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NjqBS2E2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbfAaKJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:09:30 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44793 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732244AbfAaKJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:09:27 -0500
Received: by mail-vs1-f65.google.com with SMTP id u11so1591419vsp.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TqfcER/WpG3pVm3Pf9Lr3V74srT8wVWkZMeoFRsH8cc=;
        b=NjqBS2E2dToPUfGhYJYq1Y/hMUpwrXDw6YR7RFfmUr0x4Fx7GecsCrGvG1ZO023P9O
         zah7tCLaj7qS1Ow/jKYZ6qM9WLcTK4gKTBMO9hNGjjXlCrZ7wWg1u5/6wA2MlxW9fB1d
         vf03gJuYTDIkzW9gHS1AZ9F+CVn4tTpTrlDB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqfcER/WpG3pVm3Pf9Lr3V74srT8wVWkZMeoFRsH8cc=;
        b=bopvOTn7Va32ejNzgRqlxb+Q+IWijzZtBj9GO83XWSM5yAqWO8vbXBnY1Yyu0Cdwhe
         cHsEP9vhgBsbqhCTtX1rkvHZXiWao30oJyvz9Tv8n8lVCIiRDyVW57swe6Z1c+o2SMZ6
         T+VpgWRAQiL9/v1F5a5ng2MoR20W2chucYectKYMWBLnZv67NnrSD93vo4ylyaWqgsu/
         qSv41NlKUuQCiHVhoURe57qYAe8SN/i+Cx/IrrPQp/8fha9UNOMI5mrR9aKeCvZbFWbg
         y1BrLD8y2r+9iNehWL5HCw5+xCXg9IdNLv1+npTwl5bcAxQXJPV9/H6sbK9J+3KeW4J3
         3AYQ==
X-Gm-Message-State: AJcUukd39/s+/e2CSl7p81eJlz9C1iHAsmCSSy6vovQBdP3ZQFiI5j1A
        g5h9YHTlZWvzmWlJqao9pQ3hOSYaAaM=
X-Google-Smtp-Source: ALg8bN7oknSKMycjo/SKuEZ8McbI7CFWPMe5tn4/r/IwxCZd9Iy8llhmKaxlIwk4vFJDssFGCoTFeg==
X-Received: by 2002:a67:1a84:: with SMTP id a126mr14360859vsa.165.1548929365968;
        Thu, 31 Jan 2019 02:09:25 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id e67sm3811919vsd.32.2019.01.31.02.09.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 02:09:24 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id h78so1621898vsi.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 02:09:24 -0800 (PST)
X-Received: by 2002:a67:7657:: with SMTP id r84mr14197755vsc.117.1548929363982;
 Thu, 31 Jan 2019 02:09:23 -0800 (PST)
MIME-Version: 1.0
References: <00000000000081e6cc0580aa76a2@google.com> <80e90ecd-77f5-00a3-4e91-5e9eea2aa117@I-love.SAKURA.ne.jp>
 <27008e5f-9dfc-a09a-cdb9-824d470fb9dd@I-love.SAKURA.ne.jp> <20190130114052.GB30781@kroah.com>
In-Reply-To: <20190130114052.GB30781@kroah.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 31 Jan 2019 23:09:11 +1300
X-Gmail-Original-Message-ID: <CAGXu5jKezbEYNUEhMZi=4UhKV9m8wiJc1fo+fxNf5CaaBUMP8w@mail.gmail.com>
Message-ID: <CAGXu5jKezbEYNUEhMZi=4UhKV9m8wiJc1fo+fxNf5CaaBUMP8w@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in dput (2)
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Omar Sandoval <osandov@fb.com>,
        syzbot <syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 12:41 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 30, 2019 at 08:26:24PM +0900, Tetsuo Handa wrote:
> > On 2019/01/30 20:11, Tetsuo Handa wrote:
> > > Hello, Omar.
> > >
> > > syzbot is reporting a crash due to dput(-EINVAL) [1]. I think the location is
> > >
> > >         dir = debugfs_lookup(buts->name, blk_debugfs_root);
> > >         if (!dir)
> > >                 bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
> > >
> > > added by commit 6ac93117ab009d39 ("blktrace: use existing disk debugfs directory").
> > >
> > > Currently, Greg Kroah-Hartman is posting patches:
> > >
> > >   When calling debugfs functions, there is no need to ever check the
> > >   return value.  The function can work or not, but the code logic should
> > >   never do something different based on this.
> > >
> > > Omar, what do you want to do for this case?
> > >
> > > [1] https://syzkaller.appspot.com/bug?extid=b382ba6a802a3d242790
> > >
> >
> > The function which returned -EINVAL instead of NULL seems to be debugfs_lookup()
> > modified by commit ff9fb72bc07705c0 ("debugfs: return error values, not NULL").
>
> Ok, the patch below should fix this up.
>
> thanks,
>
> greg k-h
>
> -------------------------
>
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Subject: [PATCH] debugfs: debugfs_lookup() should return NULL if not found
>
> Lots of callers of debugfs_lookup() were just checking NULL to see if
> the file/directory was found or not.  By changing this in ff9fb72bc077
> ("debugfs: return error values, not NULL") we caused some subsystems to
> easily crash.
>
> Fixes: ff9fb72bc077 ("debugfs: return error values, not NULL")
> Reported-by: syzbot+b382ba6a802a3d242790@syzkaller.appspotmail.com
> Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Omar Sandoval <osandov@fb.com>
> Cc: Jens Axboe <axboe@fb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  fs/debugfs/inode.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index b16f8035b1af..29c68c5d44d5 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -254,8 +254,8 @@ MODULE_ALIAS_FS("debugfs");
>   * @parent: a pointer to the parent dentry of the file.
>   *
>   * This function will return a pointer to a dentry if it succeeds.  If the file
> - * doesn't exist or an error occurs, %ERR_PTR(-ERROR) will be returned.  The
> - * returned dentry must be passed to dput() when it is no longer needed.
> + * doesn't exist or an error occurs, %NULL will be returned.  The returned
> + * dentry must be passed to dput() when it is no longer needed.
>   *
>   * If debugfs is not enabled in the kernel, the value -%ENODEV will be
>   * returned.
> @@ -265,17 +265,17 @@ struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
>         struct dentry *dentry;
>
>         if (IS_ERR(parent))
> -               return parent;
> +               return NULL;
>
>         if (!parent)
>                 parent = debugfs_mount->mnt_root;
>
>         dentry = lookup_one_len_unlocked(name, parent, strlen(name));
>         if (IS_ERR(dentry))
> -               return dentry;
> +               return NULL;
>         if (!d_really_is_positive(dentry)) {
>                 dput(dentry);
> -               return ERR_PTR(-EINVAL);
> +               return NULL;
>         }
>         return dentry;
>  }
> --
> 2.20.1
>

FYI, this patch does not fix the relay.c crash I bisected... I think
more clean-up is needed?

-Kees
