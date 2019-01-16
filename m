Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340C9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0218720866
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 06:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="OSb7RyoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387671AbfAPG2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 01:28:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51542 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfAPG2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 01:28:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so720052wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 22:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j8r1VojM7Oe7A42p5EcXZwLJtsILh9hx+CDQ+IK833w=;
        b=OSb7RyoI1eYHIbyE+1TfzcWWcsvP2EXsgZ8yJ2jOxlTySOEMSCF1F6zXcyyFL1XZ0s
         1phSUQA/QddzPbKpwEwbPhlaeXfDNRupfx68ASP5g5Mt5zV8b9mXaVYzFcxT5FFT8JP9
         xsF5dTHOCuAnxGBvms4nuebDFamKBzp2x1zoPV3fT+1Lw0yVgz+hwIdgBOPw4c9IyYBM
         n70CbsTmFLnaChVzDXLkxOf7dB0aNWJwjC+4lF7AB55Eea6gUgMMDkgeEEhkZTh64UPk
         YLY6SgDhSW9ea1BVfeI4U4bp8elrSZmcq2U2KpR/uqMkJPN2lLrBCNvOC4CN1jm/d17V
         v7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j8r1VojM7Oe7A42p5EcXZwLJtsILh9hx+CDQ+IK833w=;
        b=d99KK/Y+tDFA7Nv1bht2srunRFQqZpRGaZZIZ7TCE8zXTYJ69WGU5EDnZ1Azefs3z+
         a9Vlvfd3dTd1Q5OXMiOxARShAr8lnZ47pxRaUvZlD6Z2MgevkdlqGRO7NrmAHA1f/ye6
         vwvligKkhnZymNRaU17xd6kDWuow9pR2OUwSqTAPpUoTTR+KQM3kEL3TpB7n1R6V2Hzf
         r8Iqi6DuZELwojLbq/j/EHt8eJE9rPDoUNgHNo+1NcigrRo87bfjHd2McuNVo3ngmCp+
         KT3spJRuMZWb81MGHB/UXUKx0fVjIdHB8P0gRwBZkT/jsI0e46AsjaIO6t1p3e7aJBya
         vH5Q==
X-Gm-Message-State: AJcUukftmcY5+BAKl01JVTyFTU5tFxTAFoVhg4car9JsmalFUKB+U1/D
        sDOa1t9BdrL+p6owy34krjP0dw==
X-Google-Smtp-Source: ALg8bN6IAwkD7YUnZO8F9p05ZoAhNXM5OBzLG51KRvykd1xOYXdo9KGgEl/yclnd1Uy8720a21XmQQ==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr6044249wmi.24.1547620111718;
        Tue, 15 Jan 2019 22:28:31 -0800 (PST)
Received: from brauner.io ([154.119.33.254])
        by smtp.gmail.com with ESMTPSA id t70sm56215320wmd.36.2019.01.15.22.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 22:28:31 -0800 (PST)
Date:   Wed, 16 Jan 2019 07:28:26 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] binderfs: fix error return code in
 binderfs_fill_super()
Message-ID: <20190116062825.thzsb5edkihepgm4@brauner.io>
References: <1547607664-5612-1-git-send-email-weiyongjun1@huawei.com>
 <20190116062546.ufoeresnwz3wyxiu@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190116062546.ufoeresnwz3wyxiu@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 07:25:46AM +0100, Christian Brauner wrote:
> On Wed, Jan 16, 2019 at 03:01:04AM +0000, Wei Yongjun wrote:
> > Fix to return a negative error code -ENOMEM from the new_inode() and
> > d_make_root() error handling cases instead of 0, as done elsewhere in
> > this function.
> > 
> > Fixes: 3ad20fe393b3 ("binder: implement binderfs")

This Fixes tag is technically wrong since this codepath was introduced
by a commit that is still sitting in Greg's char-misc-linus branch. Not
sure how to handle that though. Might just leave it.

> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/android/binderfs.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index 9518e2e..2bf4b2b 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -519,8 +519,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >  	sb->s_fs_info = info;
> >  
> >  	inode = new_inode(sb);
> > -	if (!inode)
> > +	if (!inode) {
> > +		ret = -ENOMEM;
> 
> Hey, thanks for the patch. Just a nit:
> can you please just do?
> 
> 	ret = -ENOMEM;
>         inode = new_inode(sb);
> 
> This is more consistent with how we do it everywhere else and let's us
> avoid shoving ret = -ENOMEM into two places.
> 
> Thanks!
> Christian
> 
> >  		goto err_without_dentry;
> > +	}
> >  
> >  	inode->i_ino = FIRST_INODE;
> >  	inode->i_fop = &simple_dir_operations;
> > @@ -530,8 +532,10 @@ static int binderfs_fill_super(struct super_block *sb, void *data, int silent)
> >  	set_nlink(inode, 2);
> >  
> >  	sb->s_root = d_make_root(inode);
> > -	if (!sb->s_root)
> > +	if (!sb->s_root) {
> > +		ret = -ENOMEM;
> >  		goto err_without_dentry;
> > +	}
> >  
> >  	ret = binderfs_binder_ctl_create(sb);
> >  	if (ret)
> > 
> > 
> > 
