Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C107BC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F8320833
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sNirJhDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F8320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeILVHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:07:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33196 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeILVHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:07:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DC8VCz/nDf7DRYDASPGB5gU41kIWFZRCMSM++6l7RxY=; b=sNirJhDpzDuTLj0z9vgzgrdyV
        WhCR3ugHc/TG9p4uyMr2j5vKWb9cXd76dhmC54+EAdw8Pxp8V1E7KgtIYRyS4oojVmlOr1iO85UTg
        s+w/Qh8dsTcDEXbYGrWJNBxagU1La/8SeukhOi9e3M+C9xbj8ufuVYgj8dXX0GtPZ5ZAS4u44/lSC
        yY3f7ftRzqV6gioXw0L+HJgmGkHDDTrlYZPnErU5dszFoIXn/khOYBRjE2/1ik66TGN2KJa/Pf8uT
        zhuSVineaJkbHygfCL2nM2qK0X6n9W4qtS0n7jwo0H0Mi2u/w8faYsVAElLvrbE05mowIpF7V9q1A
        fb2UeM8UA==;
Received: from [177.97.26.110] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g07aG-0003YR-Ed; Wed, 12 Sep 2018 16:01:40 +0000
Date:   Wed, 12 Sep 2018 13:01:31 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
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
Message-ID: <20180912130131.2c6581d5@coco.lan>
In-Reply-To: <20180912151134.436719-1-arnd@arndb.de>
References: <20180912150142.157913-1-arnd@arndb.de>
        <20180912151134.436719-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Sep 2018 17:08:52 +0200
Arnd Bergmann <arnd@arndb.de> escreveu:

> The .ioctl and .compat_ioctl file operations have the same prototype so
> they can both point to the same function, which works great almost all
> the time when all the commands are compatible.
>=20
> One exception is the s390 architecture, where a compat pointer is only
> 31 bit wide, and converting it into a 64-bit pointer requires calling
> compat_ptr(). Most drivers here will ever run in s390, but since we now
> have a generic helper for it, it's easy enough to use it consistently.
>=20
> I double-checked all these drivers to ensure that all ioctl arguments
> are used as pointers or are ignored, but are not interpreted as integer
> values.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

>  drivers/media/rc/lirc_dev.c                 | 4 +---

> diff --git a/drivers/media/rc/lirc_dev.c b/drivers/media/rc/lirc_dev.c
> index f862f1b7f996..077209f414ed 100644
> --- a/drivers/media/rc/lirc_dev.c
> +++ b/drivers/media/rc/lirc_dev.c
> @@ -730,9 +730,7 @@ static const struct file_operations lirc_fops =3D {
>  	.owner		=3D THIS_MODULE,
>  	.write		=3D ir_lirc_transmit_ir,
>  	.unlocked_ioctl	=3D ir_lirc_ioctl,
> -#ifdef CONFIG_COMPAT
> -	.compat_ioctl	=3D ir_lirc_ioctl,
> -#endif
> +	.compat_ioctl	=3D generic_compat_ioctl_ptrarg,
>  	.read		=3D ir_lirc_read,
>  	.poll		=3D ir_lirc_poll,
>  	.open		=3D ir_lirc_open,

Adding an infrared remote controller to a s390 mainframe sounds fun :-)

I suspect that one could implement it on a s390 platform=20
using gpio-ir-recv and/or gpio-ir-tx drivers. Perhaps one possible
practical usage would be to let the mainframe to send remote
controller codes to adjust the air conditioning system ;-)

=46rom lirc driver's PoV, there's nothing that really prevents one to
do that and use lirc API, and the driver is generic enough to work
on any hardware platform.

I didn't check the implementation of generic_compat_ioctl_ptrarg(),
but assuming it is ok,

Acked-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Thanks,
Mauro
