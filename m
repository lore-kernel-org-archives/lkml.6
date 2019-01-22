Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB29C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E459217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="H3JxqQFY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfAVX3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:29:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36092 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVX3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:29:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so148694pgm.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7FjeXgZyteMMNJ6FNddYRfn8Rbsze0sdjcX/f6Wy+i8=;
        b=H3JxqQFYrqAdBrqoUDPmyanGoA7waPQekzvXnH+DjjUnsbHheNkhPOT8sB3fLbAqrM
         yflNJ5dQye2+Gc5jHAHPh3p9FtWE9fovE+vcBrzZe0qt04DCbQJraJIag+k05Tg26Z9c
         swsTAD/URngT49Zz8oCaIV92olpA2Nz3YRTSIvwQ3JEPUVrGXTw6mwC/oWQJNPFnkt5F
         MMw/bQe2ygS9d3QmqBFArx6KN92KZANndjSWL/+rYmqx6GmQVcBXqdZ1HpyJvIc6KF0+
         +Pjnwa/75yF/nK8iZgpo+HBjg1rtlKUjNUg3Cbobd7993AMKKB8x8u1DHUhpors81ppp
         UEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7FjeXgZyteMMNJ6FNddYRfn8Rbsze0sdjcX/f6Wy+i8=;
        b=UrX54hTceJnXrm6QPxjh/kZ+RW8wwwKyCH3IvYuB1kw79XyAyrz6uIY9DtngwhBK17
         Bh769328xmsqIClus29IFyJupwR3dudfJhMxTRu6W8En0XqnTttpQUWFWSwJw+y+pBPx
         OJgHFYBztpRSOg9VpErhjlRvtXLgJpXCWbDNqoKk+J6/H9rMXfkEqhmixiLPb0eeoYda
         nvjVctlZ+dHGQ5hZ/o9rnZiM+T3/Yb2mFZ2OtN5Qrw/AAEdatX1YpLFPy/ZLpASJAlv9
         EBm96ZMKhC4SAB599UgMrjBKBt2W96IAd69ezQDsHlbFVZDDC1rJdTjxWjNM6BezFEci
         h7SA==
X-Gm-Message-State: AJcUukeZbApH/UPyPHFd9l/USEf2KUch2no/b5YMfoNi2BE126B2lqKa
        GHeNDWU89ogjTl1H2DJBX6uLlg==
X-Google-Smtp-Source: ALg8bN7dzD/hGYQEB+RQ8O6LQTLftgeX87lPdAE9GZueCzRJ94M1phN0vRiQARYatYgb7tsarszKsQ==
X-Received: by 2002:a63:1204:: with SMTP id h4mr33862365pgl.51.1548199775330;
        Tue, 22 Jan 2019 15:29:35 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:930f])
        by smtp.gmail.com with ESMTPSA id b202sm26758835pfb.88.2019.01.22.15.29.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 15:29:34 -0800 (PST)
Date:   Tue, 22 Jan 2019 15:29:33 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, "Ed L. Cashin" <ed.cashin@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: aoe: no need to check return value of
 debugfs_create functions
Message-ID: <20190122232933.GC5884@vader>
References: <20190122152151.16139-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122152151.16139-5-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:21:04PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: "Ed L. Cashin" <ed.cashin@acm.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/block/aoe/aoeblk.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> index e2c6aae2d636..b602646bfa04 100644
> --- a/drivers/block/aoe/aoeblk.c
> +++ b/drivers/block/aoe/aoeblk.c
> @@ -207,14 +207,7 @@ aoedisk_add_debugfs(struct aoedev *d)
>  	else
>  		p++;
>  	BUG_ON(*p == '\0');
> -	entry = debugfs_create_file(p, 0444, aoe_debugfs_dir, d,
> -				    &aoe_debugfs_fops);
> -	if (IS_ERR_OR_NULL(entry)) {
> -		pr_info("aoe: cannot create debugfs file for %s\n",
> -			d->gd->disk_name);
> -		return;
> -	}
> -	BUG_ON(d->debugfs);
> +	debugfs_create_file(p, 0444, aoe_debugfs_dir, d, &aoe_debugfs_fops);
>  	d->debugfs = entry;

Now entry is uninitialized here when we assign it to d->debugfs.

>  }
>  void
> @@ -472,10 +465,6 @@ aoeblk_init(void)
>  	if (buf_pool_cache == NULL)
>  		return -ENOMEM;
>  	aoe_debugfs_dir = debugfs_create_dir("aoe", NULL);
> -	if (IS_ERR_OR_NULL(aoe_debugfs_dir)) {
> -		pr_info("aoe: cannot create debugfs directory\n");
> -		aoe_debugfs_dir = NULL;
> -	}
>  	return 0;
>  }
>  
> -- 
> 2.20.1
> 
