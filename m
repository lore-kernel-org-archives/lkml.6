Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF985C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877B32054F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 01:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lQXwUdzy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877B32054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeJ3KMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 06:12:15 -0400
Received: from ozlabs.org ([203.11.71.1]:41475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbeJ3KMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 06:12:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42kYZD1CLSz9s3l;
        Tue, 30 Oct 2018 12:20:51 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540862452;
        bh=JCkA1Y2ymEQwb091fZfuRDcAAuDYRJAp8dsSCMsFAwk=;
        h=Date:From:To:Cc:Subject:From;
        b=lQXwUdzykzTuxW2BqzVRq4YBTEn/sAQkIjURVIDXl18Nq4zlZkGmB/0Gdtl4UHsA5
         mtwDP7HJpAmHDdyH95yfrYCWvoFL47fRgJvcpFsJGls0hAi2UXwqpwgdpVBP1aJRUs
         XVfSQ8GWzC7VbW8AaBwj8C9OdAtihDqUMh7d1MHWYSRMKNyjUkquwuNB9ssMjusdHL
         iz91udxIHdgRxz1exx/QP1oMHWfxQYQIlAIloW48adxmUeN4SPTfJDOpKTAWBMEZL7
         yUCDuru/+QqMZ2msMJoBJH07/sCpW37n5ZUIUDCmy5EgWIILdGqZxvXYGCflodAapw
         enY/Me6weBa1w==
Date:   Tue, 30 Oct 2018 12:20:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with Linus' tree
Message-ID: <20181030122050.1bd82c30@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mwwwIutqEkPptyjt=g5VmnB"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/mwwwIutqEkPptyjt=g5VmnB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Al,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/compat_ioctl.c

between commit:

  77654350306a ("take compat TIOC[SG]SERIAL treatment into tty_compat_ioctl=
()")

from Linus' tree and commit:

  69374d063be0 ("compat_ioctl: remove pointless HCI... ioctls")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/compat_ioctl.c
index 6e30949d9f77,326ceab5246a..000000000000
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@@ -429,13 -499,68 +429,6 @@@ static int mt_ioctl_trans(struct file *
 =20
  #endif /* CONFIG_BLOCK */
 =20
- /* Bluetooth ioctls */
- #define HCIUARTSETPROTO		_IOW('U', 200, int)
- #define HCIUARTGETPROTO		_IOR('U', 201, int)
- #define HCIUARTGETDEVICE	_IOR('U', 202, int)
- #define HCIUARTSETFLAGS		_IOW('U', 203, int)
- #define HCIUARTGETFLAGS		_IOR('U', 204, int)
 -struct serial_struct32 {
 -        compat_int_t    type;
 -        compat_int_t    line;
 -        compat_uint_t   port;
 -        compat_int_t    irq;
 -        compat_int_t    flags;
 -        compat_int_t    xmit_fifo_size;
 -        compat_int_t    custom_divisor;
 -        compat_int_t    baud_base;
 -        unsigned short  close_delay;
 -        char    io_type;
 -        char    reserved_char[1];
 -        compat_int_t    hub6;
 -        unsigned short  closing_wait; /* time to wait before closing */
 -        unsigned short  closing_wait2; /* no longer used... */
 -        compat_uint_t   iomem_base;
 -        unsigned short  iomem_reg_shift;
 -        unsigned int    port_high;
 -     /* compat_ulong_t  iomap_base FIXME */
 -        compat_int_t    reserved[1];
 -};
 -
 -static int serial_struct_ioctl(struct file *file,
 -		unsigned cmd, struct serial_struct32 __user *ss32)
 -{
 -        typedef struct serial_struct32 SS32;
 -        int err;
 -	struct serial_struct __user *ss =3D compat_alloc_user_space(sizeof(*ss));
 -        __u32 udata;
 -	unsigned int base;
 -	unsigned char *iomem_base;
 -
 -	if (ss =3D=3D NULL)
 -		return -EFAULT;
 -        if (cmd =3D=3D TIOCSSERIAL) {
 -		if (copy_in_user(ss, ss32, offsetof(SS32, iomem_base)) ||
 -		    get_user(udata, &ss32->iomem_base))
 -			return -EFAULT;
 -		iomem_base =3D compat_ptr(udata);
 -		if (put_user(iomem_base, &ss->iomem_base) ||
 -		    convert_in_user(&ss32->iomem_reg_shift,
 -		      &ss->iomem_reg_shift) ||
 -		    convert_in_user(&ss32->port_high, &ss->port_high) ||
 -		    put_user(0UL, &ss->iomap_base))
 -			return -EFAULT;
 -        }
 -	err =3D do_ioctl(file, cmd, (unsigned long)ss);
 -        if (cmd =3D=3D TIOCGSERIAL && err >=3D 0) {
 -		if (copy_in_user(ss32, ss, offsetof(SS32, iomem_base)) ||
 -		    get_user(iomem_base, &ss->iomem_base))
 -			return -EFAULT;
 -		base =3D (unsigned long)iomem_base  >> 32 ?
 -			0xffffffff : (unsigned)(unsigned long)iomem_base;
 -		if (put_user(base, &ss32->iomem_base) ||
 -		    convert_in_user(&ss->iomem_reg_shift,
 -		      &ss32->iomem_reg_shift) ||
 -		    convert_in_user(&ss->port_high, &ss32->port_high))
 -			return -EFAULT;
 -        }
 -        return err;
 -}
--
  #define RTC_IRQP_READ32		_IOR('p', 0x0b, compat_ulong_t)
  #define RTC_IRQP_SET32		_IOW('p', 0x0c, compat_ulong_t)
  #define RTC_EPOCH_READ32	_IOR('p', 0x0d, compat_ulong_t)

--Sig_/mwwwIutqEkPptyjt=g5VmnB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvXsfIACgkQAVBC80lX
0GyWkggAk+mGzr3YiRPXwF7N3+MwbgE4v1IyRXSBCl/CyOfHmPxjHyKZyEsBk+Fl
cV64iqSJFDLvdanIRyuivDd/AYu/9E1KcUvsmSWogkTE1ut7Sia/2fBi0+w2lbId
S0YuCUxJDwhMLRd0FR2Sk7C7yNa07EECKsS6qOsgOk7AFJvuF2twPpHnjgDCdc7S
q/xLfhgYV7J8c1QGsZhUl0tjnMtMk29XUznjcX64nCU+cfYhnei7RR/VtoYsVxbD
2s0hcZZyflLtK0cjE6r0ceEM/Mej8zwHhxyPgG4CsIU4ZFCxOLE7ST1HQvUeO8bW
wJG8UdL7jSUwS2XL4vijgcFjOT1ytQ==
=VfoC
-----END PGP SIGNATURE-----

--Sig_/mwwwIutqEkPptyjt=g5VmnB--
