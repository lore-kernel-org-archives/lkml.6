Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47968C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097A62084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 17:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9OQ4/LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097A62084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeJEA2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 20:28:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51385 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbeJEA2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 20:28:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id 143-v6so9775707wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 10:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AIZu1cVH6VXZelD1rqMghap6Ebp1rR+Sz/ZsB4vIn6c=;
        b=s9OQ4/LLV3pAKB4yhBOCwL4StETzlqgeeGtsqe+2Iqysnyp14J+MNu8/j0zBFT3eVy
         1d5YBfi5N7r4p+iO35NINNhD035JAdb7zLRD5k0k0k+1Q2XhsQhVwlfGAOeDWu2uw339
         YwXeQ303N1XCW3umFWAEm3KUx4hXwI9jeybLd+U/8C/tQJdihdV4u4mzDlg63IWIPRUM
         bSnJdgWU9cJzgDQUcVG7m/mKWbmRuH5oo+2/dwWFKOluDY0e69GhXwzbtMdSxnAW9Fsa
         USM7qddnNATgWS2e6NdrvC7lb0EF2xXlt1EcKQFsy8BfDLsuLmiTiTRZuBiOZPem5X2B
         0lbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AIZu1cVH6VXZelD1rqMghap6Ebp1rR+Sz/ZsB4vIn6c=;
        b=PwkXnBdq0Vm4dYypWXkq/+kvG2qp9ImoX5DcMDddIX3aEPTrFSUhDaZk2C/unlXMG6
         0q4j8Ar1KRTPathmovFN1JTpvDz5Oy8ahRWpaGwn+U7ieUOaShkWvmi0L6TTQcwFJKle
         GAsp7uq13rleHnA1e7yECKcLjuz7mco6AoDpCFYF11wl04XubOUK57/FnHTtYN4yVCWx
         Zs+YqmxLqrmv1KwMgOTZLh5ILbChU6j7Td6BGlCCpccjHpZluanjY2Lxo2T39GR+Lu3V
         XrI/jHF0XDWsXRBIxN3kUKY3H7WINwSLZC5+R6YQalz6iGjqVxUb3G8+z/uan/LzWaYm
         d+5Q==
X-Gm-Message-State: ABuFfoi+i+wxnaZyAXMT3q7EuAjzjCV1hdRf2XJ5Tr54YzUNKr6EFvdY
        2DcVz3o4NX+NTSe9P2/p+V0=
X-Google-Smtp-Source: ACcGV63p+NsCOlc1fycEbzS2w10CbHey+dZcFPn5mfmrze5OpiqIXibvb82JxtlCd1lPaOV5EGV/Gg==
X-Received: by 2002:a1c:5702:: with SMTP id l2-v6mr5020172wmb.83.1538674429731;
        Thu, 04 Oct 2018 10:33:49 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id m12sm3608298wrx.75.2018.10.04.10.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 10:33:48 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:33:47 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     chenchacha <chen.chenchacha@foxmail.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH 1/2] Add FAT_IOCTL_GET_VOLUME_LABEL in fat_generic_ioctl()
Message-ID: <20181004173347.kmymtmiilo7lrxmy@pali>
References: <20181004172101.15525-1-chen.chenchacha@foxmail.com>
 <20181004172101.15525-2-chen.chenchacha@foxmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yy2izu3rfglgbmus"
Content-Disposition: inline
In-Reply-To: <20181004172101.15525-2-chen.chenchacha@foxmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yy2izu3rfglgbmus
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Friday 05 October 2018 01:21:00 chenchacha wrote:
> Signed-off-by: chenchacha <chen.chenchacha@foxmail.com>
> ---
>  fs/fat/file.c                 | 22 ++++++++++++++++++++++
>  include/uapi/linux/msdos_fs.h |  1 +
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index 4724cc9ad650..56db0b5a8df1 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -121,10 +121,30 @@ static int fat_ioctl_get_volume_id(struct inode *in=
ode, u32 __user *user_attr)
>  	return put_user(sbi->vol_id, user_attr);
>  }
> =20
> +static int fat_ioctl_get_volume_label(struct inode *inode, u8 __user *la=
bel)
> +{
> +	struct super_block *sb =3D inode->i_sb;
> +	struct inode *root_inode =3D d_inode(sb->s_root);
> +	struct buffer_head *bh =3D NULL;
> +	struct msdos_dir_entry *de;
> +	int err;
> +
> +	inode_lock_shared(root_inode);
> +	err =3D fat_get_root_entry(root_inode, &bh, &de);
> +	if (err =3D=3D 0) {
> +		if (copy_to_user(label, de->name, MSDOS_NAME))

You need to convert entry name from 8.3 format to label in correct
encoding specified by codepage mount option. Plus needs to handle
leading 0x03 byte.

> +			err =3D -EFAULT;
> +	}
> +	inode_unlock_shared(root_inode);
> +
> +	return err;
> +}
> +
>  long fat_generic_ioctl(struct file *filp, unsigned int cmd, unsigned lon=
g arg)
>  {
>  	struct inode *inode =3D file_inode(filp);
>  	u32 __user *user_attr =3D (u32 __user *)arg;
> +	u8 __user *user_vol_label =3D (u8 __user *)arg;
> =20
>  	switch (cmd) {
>  	case FAT_IOCTL_GET_ATTRIBUTES:
> @@ -133,6 +153,8 @@ long fat_generic_ioctl(struct file *filp, unsigned in=
t cmd, unsigned long arg)
>  		return fat_ioctl_set_attributes(filp, user_attr);
>  	case FAT_IOCTL_GET_VOLUME_ID:
>  		return fat_ioctl_get_volume_id(inode, user_attr);
> +	case FAT_IOCTL_GET_VOLUME_LABEL:
> +		return fat_ioctl_get_volume_label(inode, user_vol_label);
>  	default:
>  		return -ENOTTY;	/* Inappropriate ioctl for device */
>  	}
> diff --git a/include/uapi/linux/msdos_fs.h b/include/uapi/linux/msdos_fs.h
> index fde753735aba..8ba8e2d7bafe 100644
> --- a/include/uapi/linux/msdos_fs.h
> +++ b/include/uapi/linux/msdos_fs.h
> @@ -109,6 +109,7 @@ struct __fat_dirent {
>  #define FAT_IOCTL_SET_ATTRIBUTES	_IOW('r', 0x11, __u32)
>  /*Android kernel has used 0x12, so we use 0x13*/
>  #define FAT_IOCTL_GET_VOLUME_ID		_IOR('r', 0x13, __u32)
> +#define FAT_IOCTL_GET_VOLUME_LABEL	_IOR('r', 0x14, __u8[MSDOS_NAME])
> =20
>  struct fat_boot_sector {
>  	__u8	ignored[3];	/* Boot strap short or near jump */

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--yy2izu3rfglgbmus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCW7ZO+gAKCRCL8Mk9A+RD
UjYyAKDOTjXURBsmPf88HeQtz+BblhlqPACfTMbUX6slXYKn2/DI3uxfjzshLFw=
=ys9q
-----END PGP SIGNATURE-----

--yy2izu3rfglgbmus--
