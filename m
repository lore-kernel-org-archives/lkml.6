Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF0C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AC02087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dWCfnec8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AC02087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeILUiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:38:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46294 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbeILUiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:38:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so1179245pfn.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Erh9Dg+RiMAiy9HjZnazEgbEJ8PMdQAqsBJo9ckm8uw=;
        b=dWCfnec8vRFWp7+dIbMTxp8GtdT2tpvy0TfDui//rm1C/yGGBFnkttVGyM189c9Qaf
         stXcaGCNwjfwwUAathMSVitQbkv4aou0Sqtw6BGOwqF1/J3ovlF8j+/PpQRaWzSgANTc
         vLL5xZ1Z+K537alUlB4m0NMI/BoCaDWC//g2zWWH9VPFYnB1KSZZWveZ29zb/PZE192p
         n7CRJuIUTOP9U6tLAhoQzmcvKpeIu0Iv9oUAwKXSzfyJFe393Zi0RHpSm+cvSg8pgnjd
         GBYoxGhCXAiX9njfBNHrbCUFpFSMgvwVoR5xG33eofVOVJmi2QxiNxNVJ/6GE/jhAx0U
         5s2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Erh9Dg+RiMAiy9HjZnazEgbEJ8PMdQAqsBJo9ckm8uw=;
        b=jpUvySIuKTEygSRtd5ve9MvEtdW0GhjpSF02Wd/P5j9S4YmpEb+ZMEfziTG3luBk8+
         qMbZEl4sib6RezX9iL9+IBMZJyL5HCvjFIZb3IFtDAcux3ef8cUTtnvra2in2d9xMTBY
         9CvwB2rv3JOclQI53M/6vdFnuQ5GgflEUv/HxMlVRog8/sLgymPX/ivjsGCgDkXxPX5y
         pzfSrKhvx051aaEw5nUkDt4Gi+R2WWsRhE3becfyvtw655eS1Yq2K5S3WRjSTichqsdi
         Gk2ueWUYzZCD4I/MFxV8SZ4tV9jKWeyHan637wpOIuP50j9rMOXNYermLCE5gbf3eF0c
         ycZg==
X-Gm-Message-State: APzg51AK1FSUStUosTFeQOjwT78EJjUoWwMlaYJI4IGtaZr4A1YqWUqU
        zDnswwBbStG9F3uWd1V8zqLkvQ==
X-Google-Smtp-Source: ANB0VdZT1lkh5FeGvBFf8fwQctLBN1Qft1DZQYufg/E8ghAsOu/V7LUwwL8IINJfA6AbNrNNTpuyVQ==
X-Received: by 2002:a65:50c9:: with SMTP id s9-v6mr2962510pgp.417.1536766382561;
        Wed, 12 Sep 2018 08:33:02 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z11-v6sm2133238pff.162.2018.09.12.08.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 08:33:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g078W-00072D-GD; Wed, 12 Sep 2018 09:33:00 -0600
Date:   Wed, 12 Sep 2018 09:33:00 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net, linux-usb@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mtd@lists.infradead.org,
        netdev@vger.kernel.org, devel@driverdev.osuosl.org,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 02/17] compat_ioctl: move drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20180912153300.GE5633@ziepe.ca>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912150142.157913-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912150142.157913-2-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:01:03PM +0200, Arnd Bergmann wrote:
> Each of these drivers has a copy of the same trivial helper function to
> convert the pointer argument and then call the native ioctl handler.
> 
> We now have a generic implementation of that, so use it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>  drivers/char/ppdev.c              | 12 +---------
>  drivers/char/tpm/tpm_vtpm_proxy.c | 12 +---------
>  drivers/firewire/core-cdev.c      | 12 +---------
>  drivers/hid/usbhid/hiddev.c       | 11 +--------
>  drivers/hwtracing/stm/core.c      | 12 +---------
>  drivers/misc/mei/main.c           | 22 +----------------
>  drivers/mtd/ubi/cdev.c            | 36 +++-------------------------
>  drivers/net/tap.c                 | 12 +---------
>  drivers/staging/pi433/pi433_if.c  | 12 +---------
>  drivers/usb/core/devio.c          | 16 +------------
>  drivers/vfio/vfio.c               | 39 +++----------------------------
>  drivers/vhost/net.c               | 12 +---------
>  drivers/vhost/scsi.c              | 12 +---------
>  drivers/vhost/test.c              | 12 +---------
>  drivers/vhost/vsock.c             | 12 +---------
>  fs/fat/file.c                     | 13 +----------
>  16 files changed, 20 insertions(+), 237 deletions(-)
> 

> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 87a0ce47f201..a170f5ca7416 100644
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -678,20 +678,10 @@ static long vtpmx_fops_ioctl(struct file *f, unsigned int ioctl,
>  	}
>  }
>  
> -#ifdef CONFIG_COMPAT
> -static long vtpmx_fops_compat_ioctl(struct file *f, unsigned int ioctl,
> -					  unsigned long arg)
> -{
> -	return vtpmx_fops_ioctl(f, ioctl, (unsigned long)compat_ptr(arg));
> -}
> -#endif
> -
>  static const struct file_operations vtpmx_fops = {
>  	.owner = THIS_MODULE,
>  	.unlocked_ioctl = vtpmx_fops_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl = vtpmx_fops_compat_ioctl,
> -#endif
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  	.llseek = noop_llseek,
>  };

For vtpm:

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Arnd, would you consider including a patch as part of/after this
series to make compat_ioctl in drivers/infiniband/core/uverbs_main.c
use this as well?  Looks like a bug too?

Thanks,
Jason
