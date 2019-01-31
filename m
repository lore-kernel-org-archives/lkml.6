Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA0C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B4A220833
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SWveudhh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfAaA0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:26:32 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42911 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfAaA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:26:32 -0500
Received: by mail-ed1-f66.google.com with SMTP id y20so1159055edw.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 16:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FomLYJ8SIMevqjUMJ0R0Oe8sO4q9KnfoHgjibf4O61U=;
        b=SWveudhhmAP+dPKQy1xunLL5Uw3Cq4RthCFJhWAJMmcY6SHleD2pZTZQYItfl6QCER
         H7CyWroUijVrya5FpkzJIGfhn7W8kwQVoJkfpI4vBTJbzMFf0+MyMOPD+zBtMiH+JcUG
         8lJLdSNseWPTFwq3IN0BRuKXVUYp36yPbvoc68UXOzRQbWJyYp91ypF77nmMR5iaZauZ
         TKHAUsQRuO62/CD47R9fYhRw2d0JH0XmPMK9jrWsppZkw2W61nUXj8ojPcwRW5LR6Qjt
         HKSzBIb9Hq6fytCg7UiT7JaX8CZpyw7uay8fTm4z7+l2xSY5DBmDSTYLchBehlWkGRON
         /lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FomLYJ8SIMevqjUMJ0R0Oe8sO4q9KnfoHgjibf4O61U=;
        b=k3EEDBB9J9rkEdHq+wOsUsXCio1+/3gsJKmVLi9jJfowxmDbe2eervJl46XfWGlV+L
         qfeYfuloxqFyebm84w/X0/VCoW0I+iBZCvyfWfIgpDLVcTdUFVwCD9AmqHkOCtOJhhaQ
         IOa+pT8fDHs/Qej3Sr2zEwhMk0sVEDmvirY3zUQIJc5TS17bnPNqF3Fqn7iZYgprhU+W
         xqxwzv9FQUoFqC22M3goRPON5DWW+WcrNdPnIcXb9PJBkOd3BSG41k7U1s5Qq9WAJ0Ca
         5LEp4PbZThAwezuu+BjUZv34ZD5t24RDj5lZ6WlsIdyOTw6arKo3TIcRpkS8OMAyZBcT
         LhYg==
X-Gm-Message-State: AJcUukfPfMp6I9dBQJvGTDe+h5iaMI3mWRTVCACMnvVd6vQr+yw+fTiV
        R271AolhALy1Oo2eAtyzmk75VQ==
X-Google-Smtp-Source: ALg8bN7a5l4hXYVSQ2bVRrtZ1S7N+K4qq1xO5bE3MmWzR4BRiJZjh6BDt2T48gOcl4M1HhfIBOIq7w==
X-Received: by 2002:a50:a622:: with SMTP id d31mr33562228edc.228.1548894389611;
        Wed, 30 Jan 2019 16:26:29 -0800 (PST)
Received: from brauner.io (84-199-88-155.iFiber.telenet-ops.be. [84.199.88.155])
        by smtp.gmail.com with ESMTPSA id ca21sm539651ejb.3.2019.01.30.16.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 16:26:29 -0800 (PST)
Date:   Thu, 31 Jan 2019 01:26:28 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com, tkjos@google.com
Subject: Re: [PATCH 2/2] binderfs: remove separate device_initcall()
Message-ID: <20190131002628.id24cpazctijiweo@brauner.io>
References: <20190123114116.5251-1-christian@brauner.io>
 <20190123114116.5251-2-christian@brauner.io>
 <20190130142412.GA13798@kroah.com>
 <20190130170101.wfdrqc3374az75yo@brauner.io>
 <20190130211739.GC25919@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190130211739.GC25919@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 10:17:39PM +0100, Greg KH wrote:
> On Wed, Jan 30, 2019 at 06:01:02PM +0100, Christian Brauner wrote:
> > On Wed, Jan 30, 2019 at 03:24:12PM +0100, Greg KH wrote:
> > > On Wed, Jan 23, 2019 at 12:41:16PM +0100, Christian Brauner wrote:
> > > > binderfs should not have a separate device_initcall(). When a kernel is
> > > > compiled with CONFIG_ANDROID_BINDERFS register the filesystem alongside
> > > > CONFIG_ANDROID_IPC. This use-case is especially sensible when users specify
> > > > CONFIG_ANDROID_IPC=y, CONFIG_ANDROID_BINDERFS=y and
> > > > ANDROID_BINDER_DEVICES="".
> > > > When CONFIG_ANDROID_BINDERFS=n then this always succeeds so there's no
> > > > regression potential for legacy workloads.
> > > > 
> > > > Signed-off-by: Christian Brauner <christian@brauner.io>
> > > > ---
> > > >  drivers/android/binder.c          | 4 ++++
> > > >  drivers/android/binder_internal.h | 9 +++++++++
> > > >  drivers/android/binderfs.c        | 4 +---
> > > >  3 files changed, 14 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > > > index cdfc87629efb..751d76173f81 100644
> > > > --- a/drivers/android/binder.c
> > > > +++ b/drivers/android/binder.c
> > > > @@ -5915,6 +5915,10 @@ static int __init binder_init(void)
> > > >  			goto err_init_binder_device_failed;
> > > >  	}
> > > >  
> > > > +	ret = init_binderfs();
> > > > +	if (ret)
> > > > +		goto err_init_binder_device_failed;
> > > > +
> > > >  	return ret;
> > > >  
> > > >  err_init_binder_device_failed:
> > > > diff --git a/drivers/android/binder_internal.h b/drivers/android/binder_internal.h
> > > > index 7fb97f503ef2..045b3e42d98b 100644
> > > > --- a/drivers/android/binder_internal.h
> > > > +++ b/drivers/android/binder_internal.h
> > > > @@ -46,4 +46,13 @@ static inline bool is_binderfs_device(const struct inode *inode)
> > > >  }
> > > >  #endif
> > > >  
> > > > +#ifdef CONFIG_ANDROID_BINDERFS
> > > > +extern int __init init_binderfs(void);
> > > > +#else
> > > > +static inline int __init init_binderfs(void)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +#endif
> > > > +
> > > >  #endif /* _LINUX_BINDER_INTERNAL_H */
> > > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > > index 7a550104a722..e773f45d19d9 100644
> > > > --- a/drivers/android/binderfs.c
> > > > +++ b/drivers/android/binderfs.c
> > > > @@ -550,7 +550,7 @@ static struct file_system_type binder_fs_type = {
> > > >  	.fs_flags	= FS_USERNS_MOUNT,
> > > >  };
> > > >  
> > > > -static int __init init_binderfs(void)
> > > > +int __init init_binderfs(void)
> > > >  {
> > > >  	int ret;
> > > >  
> > > > @@ -568,5 +568,3 @@ static int __init init_binderfs(void)
> > > >  
> > > >  	return ret;
> > > >  }
> > > > -
> > > > -device_initcall(init_binderfs);
> > > 
> > > I get a build warning when applying this patch :(
> > 
> > Hm, I can't reproduce that build error with this patch applied to what
> > you currently have in char-misc-linus. :(
> > Any chance you can give me the config that produced this warning?
> > I tried with CONFIG_BINDERFS=y and CONFIG_BINDERFS=n.
> 
> $ make M=drivers/android
>   CC      drivers/android/binderfs.o
>   CC      drivers/android/binder.o
> drivers/android/binder.c: In function ‘binder_init’:
> drivers/android/binder.c:5933:2: warning: ‘device_names’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   kfree(device_names);
>   ^~~~~~~~~~~~~~~~~~~
> 
> $ gcc --version
> gcc (GCC) 8.2.1 20181127
> 
> And gcc is right about this warning, that could happen with your change :(

Thanks for the pointer. New version sent out that fixes this issue! :)

Thanks!
Christian
