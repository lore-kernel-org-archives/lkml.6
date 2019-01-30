Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EAA9C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3D420989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 17:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fC+DRBSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbfA3RBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 12:01:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41104 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732338AbfA3RBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 12:01:09 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so176732edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 09:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xB8TVOqQ38SsN1+u5qq8WNps6391MAN699+3LR2JMUg=;
        b=fC+DRBSnGa1nCHPZjeOHwzLn2N4mbEGUBl6fHagwGW1CkqYZ9Ibrksp/Mq4MnJuzqd
         uqd6wlL0iGhM9K9TWF6eKBGjqTwjEokvf2lHt9p0821ul7wCn2gXFD7k+T2jQiAIB13c
         WR5pl9Zjeab25o0B4C6Ie1CYFze4tXAcNrKc7fBadph/lgV4TtAWmn5WLyG5sy9e0+k1
         BUhr35GlgbRppQFv/eAmRJUYpIVHM0y6uT6jYHrAX7qeHJGLduQfIa2V9nN9aLHhcyh0
         PVW4870lzVBPXzM1XlLcXqWiWUdYtV0GSk0F7Nn5RVc1p2Eah518aY72s13Wr2wS7qnv
         kO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xB8TVOqQ38SsN1+u5qq8WNps6391MAN699+3LR2JMUg=;
        b=UDAcFXNbB/B71cvBAm2ma7o3RyiDByxoIm6HNgr28QT25auPPaWBHCt3aMm7CQUNyD
         ppQOad+IdDByoVSIAOj5j90kb8V2FAhYebXOSO6kA2F3wt5AAp1CyTdIlG0vqXLsCo8b
         9L3yW6kR7wnZK+9YjrWKeVwlbRSCIv2/v8drtSuNlw0R+adTtBMwjisxcJ2jC6jxJS6d
         lxUsmvYTDlYMUNNiw7cRRaNsDcWOw/yZAtnN7OTDuEWmqdpi0VnIxGiEXRAvHTjNWQUv
         hbEXqt9SDfhHeOYH7LiGomzUcqlf8Q1So3Th3s1SFFj9gmOoMstZyHMtBBmyDrpCjrsn
         AlMQ==
X-Gm-Message-State: AJcUuke8kSjx5YrcoyEJMIHNczUNj/RP/q1+K+lvQ6+OUhQ/9v4FnAd2
        1eUDonk8PbkoQi6b1qAmYGaSM795dNj+Lg==
X-Google-Smtp-Source: ALg8bN7T/ka4Z8+MSBgclczdHtdnB6EW53AxL0pTpy0cf8tp/NqDmF147ObmiRA0bP7IRz/JUxIDow==
X-Received: by 2002:a50:95b4:: with SMTP id w49mr30215742eda.186.1548867667136;
        Wed, 30 Jan 2019 09:01:07 -0800 (PST)
Received: from brauner.io (84-199-88-155.iFiber.telenet-ops.be. [84.199.88.155])
        by smtp.gmail.com with ESMTPSA id a38sm642781edd.44.2019.01.30.09.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 09:01:05 -0800 (PST)
Date:   Wed, 30 Jan 2019 18:01:02 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     tkjos@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, arve@android.com, maco@android.com,
        joel@joelfernandes.org, tkjos@google.com
Subject: Re: [PATCH 2/2] binderfs: remove separate device_initcall()
Message-ID: <20190130170101.wfdrqc3374az75yo@brauner.io>
References: <20190123114116.5251-1-christian@brauner.io>
 <20190123114116.5251-2-christian@brauner.io>
 <20190130142412.GA13798@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130142412.GA13798@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 03:24:12PM +0100, Greg KH wrote:
> On Wed, Jan 23, 2019 at 12:41:16PM +0100, Christian Brauner wrote:
> > binderfs should not have a separate device_initcall(). When a kernel is
> > compiled with CONFIG_ANDROID_BINDERFS register the filesystem alongside
> > CONFIG_ANDROID_IPC. This use-case is especially sensible when users specify
> > CONFIG_ANDROID_IPC=y, CONFIG_ANDROID_BINDERFS=y and
> > ANDROID_BINDER_DEVICES="".
> > When CONFIG_ANDROID_BINDERFS=n then this always succeeds so there's no
> > regression potential for legacy workloads.
> > 
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > ---
> >  drivers/android/binder.c          | 4 ++++
> >  drivers/android/binder_internal.h | 9 +++++++++
> >  drivers/android/binderfs.c        | 4 +---
> >  3 files changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index cdfc87629efb..751d76173f81 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -5915,6 +5915,10 @@ static int __init binder_init(void)
> >  			goto err_init_binder_device_failed;
> >  	}
> >  
> > +	ret = init_binderfs();
> > +	if (ret)
> > +		goto err_init_binder_device_failed;
> > +
> >  	return ret;
> >  
> >  err_init_binder_device_failed:
> > diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> > index 7fb97f503ef2..045b3e42d98b 100644
> > --- a/drivers/android/binder_internal.h
> > +++ b/drivers/android/binder_internal.h
> > @@ -46,4 +46,13 @@ static inline bool is_binderfs_device(const struct inode *inode)
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_ANDROID_BINDERFS
> > +extern int __init init_binderfs(void);
> > +#else
> > +static inline int __init init_binderfs(void)
> > +{
> > +	return 0;
> > +}
> > +#endif
> > +
> >  #endif /* _LINUX_BINDER_INTERNAL_H */
> > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > index 7a550104a722..e773f45d19d9 100644
> > --- a/drivers/android/binderfs.c
> > +++ b/drivers/android/binderfs.c
> > @@ -550,7 +550,7 @@ static struct file_system_type binder_fs_type = {
> >  	.fs_flags	= FS_USERNS_MOUNT,
> >  };
> >  
> > -static int __init init_binderfs(void)
> > +int __init init_binderfs(void)
> >  {
> >  	int ret;
> >  
> > @@ -568,5 +568,3 @@ static int __init init_binderfs(void)
> >  
> >  	return ret;
> >  }
> > -
> > -device_initcall(init_binderfs);
> 
> I get a build warning when applying this patch :(

Hm, I can't reproduce that build error with this patch applied to what
you currently have in char-misc-linus. :(
Any chance you can give me the config that produced this warning?
I tried with CONFIG_BINDERFS=y and CONFIG_BINDERFS=n.

Thanks!
Christian
