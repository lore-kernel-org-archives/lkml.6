Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B27C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F7020833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NoxvxR7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F7020833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbeILVB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:01:56 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45710 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbeILVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:01:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id x26-v6so1265159pge.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 08:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EMNkJdPwdBpD5xBITzB4iDjL2dq/Im2icV1KK6sTT1c=;
        b=NoxvxR7eAuvDTalLZRHwo0Pcw4WQHG+TMxP2qAjjjvfLZHyQ6uZzB6ESNiYTWrTpdg
         K+aJNZZzMpDlPC0q4QaNmQOLpW5XbbcF/DArG33F09wwIxWNxCG5p3ksLpiCp6d2S8Lz
         b/IhQvUFrxIywkPl9KyGUuBcH11VrOmJUgiBlPbk+1lEBmIfOFFhqhzRW9GGXjqR/8Bw
         IZOy0hRDUyYs0FsI5mJyWGAXyeI4EdMm0nmkkOJBkeRUAfnZkiU2Q1v0N4NXVqar5aZf
         dFsIhcXEhnMXmrsPgiSilt1u+sT9/Y/K4ANKH3ZCVJd4O4irK0pks2dRMx40d+gmBNSq
         cxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EMNkJdPwdBpD5xBITzB4iDjL2dq/Im2icV1KK6sTT1c=;
        b=fPtdeRTF6uJH/+pp0tleOQ5LJWO9BGpt8dsq/NbYje7K2khmVR4/rlbUARI1DDgp0z
         bU3ZZef+MEUJJI3ev879BxhcyGcSjI3rZ2s+zY7DvGSXadwaovNTxmNmJOPOWlupCc1L
         5IhlI9NMS23kIOtE+M9a9xxBAR+vUMv0IKcjJyTDKCc+wDwWZIoO+Tlq7euOJ1cHoJaw
         Ni2e5IJsGhL9Va3Lec8LdnkOt06Kcf9HJeQAr4goxXPnmQuhzGzUycmdJsCpz3NIPneT
         Xy0StIKQxUgbE2LYN4yxO+WX7w8jAXoD2pU6ixyy28ZUPvK/mtegu1wAFp1C3AUurxVg
         yZXA==
X-Gm-Message-State: APzg51BXZuxmE81vWf9QyQxoiyAlieVz8AcZQGVTzO20yvSjSNOyvBQp
        r7skZLlNTM6ssZ0wlZQ62dUT5Q==
X-Google-Smtp-Source: ANB0Vdb9g/Gm1pm1I3lrG4BgLhJv4cd9YkSV09pAi5W7gHm1GPsLilz+jfhvSO/13u7JKNWvZsWiPg==
X-Received: by 2002:a62:9c17:: with SMTP id f23-v6mr3079094pfe.209.1536767801500;
        Wed, 12 Sep 2018 08:56:41 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id g25-v6sm4396806pfd.23.2018.09.12.08.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 08:56:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g07VP-0007Mj-9I; Wed, 12 Sep 2018 09:56:39 -0600
Date:   Wed, 12 Sep 2018 09:56:39 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, linux-crypto@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 05/17] compat_ioctl: move more drivers to
 generic_compat_ioctl_ptrarg
Message-ID: <20180912155639.GF5633@ziepe.ca>
References: <20180912150142.157913-1-arnd@arndb.de>
 <20180912151134.436719-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 05:08:52PM +0200, Arnd Bergmann wrote:
> The .ioctl and .compat_ioctl file operations have the same prototype so
> they can both point to the same function, which works great almost all
> the time when all the commands are compatible.
> 
> One exception is the s390 architecture, where a compat pointer is only
> 31 bit wide, and converting it into a 64-bit pointer requires calling
> compat_ptr(). Most drivers here will ever run in s390, but since we now
> have a generic helper for it, it's easy enough to use it consistently.
> 
> I double-checked all these drivers to ensure that all ioctl arguments
> are used as pointers or are ignored, but are not interpreted as integer
> values.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>  drivers/android/binder.c                    | 2 +-
>  drivers/crypto/qat/qat_common/adf_ctl_drv.c | 2 +-
>  drivers/dma-buf/dma-buf.c                   | 4 +---
>  drivers/dma-buf/sw_sync.c                   | 2 +-
>  drivers/dma-buf/sync_file.c                 | 2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c    | 2 +-
>  drivers/hid/hidraw.c                        | 4 +---
>  drivers/iio/industrialio-core.c             | 2 +-
>  drivers/infiniband/core/uverbs_main.c       | 4 ++--
>  drivers/media/rc/lirc_dev.c                 | 4 +---
>  drivers/mfd/cros_ec_dev.c                   | 4 +---
>  drivers/misc/vmw_vmci/vmci_host.c           | 2 +-
>  drivers/nvdimm/bus.c                        | 4 ++--
>  drivers/nvme/host/core.c                    | 2 +-
>  drivers/pci/switch/switchtec.c              | 2 +-
>  drivers/platform/x86/wmi.c                  | 2 +-
>  drivers/rpmsg/rpmsg_char.c                  | 4 ++--
>  drivers/sbus/char/display7seg.c             | 2 +-
>  drivers/sbus/char/envctrl.c                 | 4 +---
>  drivers/scsi/3w-xxxx.c                      | 4 +---
>  drivers/scsi/cxlflash/main.c                | 2 +-
>  drivers/scsi/esas2r/esas2r_main.c           | 2 +-
>  drivers/scsi/pmcraid.c                      | 4 +---
>  drivers/staging/android/ion/ion.c           | 4 +---
>  drivers/staging/vme/devices/vme_user.c      | 2 +-
>  drivers/tee/tee_core.c                      | 2 +-
>  drivers/usb/class/cdc-wdm.c                 | 2 +-
>  drivers/usb/class/usbtmc.c                  | 4 +---
>  drivers/video/fbdev/ps3fb.c                 | 2 +-
>  drivers/virt/fsl_hypervisor.c               | 2 +-
>  fs/btrfs/super.c                            | 2 +-
>  fs/ceph/dir.c                               | 2 +-
>  fs/ceph/file.c                              | 2 +-
>  fs/fuse/dev.c                               | 2 +-
>  fs/notify/fanotify/fanotify_user.c          | 2 +-
>  fs/userfaultfd.c                            | 2 +-
>  net/rfkill/core.c                           | 2 +-
>  37 files changed, 40 insertions(+), 58 deletions(-)

> diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
> index 823beca448e1..f4755c1c9cfa 100644
> +++ b/drivers/infiniband/core/uverbs_main.c
> @@ -930,7 +930,7 @@ static const struct file_operations uverbs_fops = {
>  	.release = ib_uverbs_close,
>  	.llseek	 = no_llseek,
>  	.unlocked_ioctl = ib_uverbs_ioctl,
> -	.compat_ioctl = ib_uverbs_ioctl,
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  };
>  
>  static const struct file_operations uverbs_mmap_fops = {
> @@ -941,7 +941,7 @@ static const struct file_operations uverbs_mmap_fops = {
>  	.release = ib_uverbs_close,
>  	.llseek	 = no_llseek,
>  	.unlocked_ioctl = ib_uverbs_ioctl,
> -	.compat_ioctl = ib_uverbs_ioctl,
> +	.compat_ioctl = generic_compat_ioctl_ptrarg,
>  };
>  
>  static struct ib_client uverbs_client = {

For uverbs:

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

It is very strange, this patch did not appear in the RDMA patchworks,
I almost missed it  :|

Jason
