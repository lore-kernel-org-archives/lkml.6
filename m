Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E390EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EE020849
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jetgvpcp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EE020849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbeGLEhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:37:13 -0400
Received: from ozlabs.org ([203.11.71.1]:59031 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725756AbeGLEhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:37:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41R2yW271sz9s1R;
        Thu, 12 Jul 2018 14:29:23 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531369766;
        bh=dPfoZowBDSiEIM7nj5TPJTpPGHuble/KdcxQbQWjeX8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jetgvpcpBL/q9r591eHlxsjPXouH3Pv3YWttT4pnN7VNCKwcygRShslPnjVs7l/4x
         IbfEY1+donkdbpve8ETZpNYr/MGb/B4/8vc8zG6A/6olfqlJtF9f+GZdcCDTeYuuB4
         /hTw31I6U5gNQ7mWON5aL2shHEOdFSD5pZoki+tPbHMwKKhH4jPrY/duQtPfRvQt7J
         Sx8tg+CoSGQ9bu653Ny0Ut34t+gqiViY4+SGddvXykXpIlHIZF6jE+TQu1AEkzOOI1
         Bd5FTcBRrSJBVkYZkgtGYVtjr1NG7lsOznEoAKP3XVYi8ABu4ry/WlYYdsC3XLqTJF
         Og+I5F7t91+tQ==
Date:   Thu, 12 Jul 2018 14:29:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Joel Stanley <joel@jms.id.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: linux-next: manual merge of the scsi-mkp tree with Linus' tree
Message-ID: <20180712142922.57ac7ca2@canb.auug.org.au>
In-Reply-To: <20180711140457.5c366429@canb.auug.org.au>
References: <20180711140457.5c366429@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eFqml6=aE8tyX/oc6ZpjG7Y"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eFqml6=aE8tyX/oc6ZpjG7Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 11 Jul 2018 14:04:57 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the scsi-mkp tree got a conflict in:
>=20
>   MAINTAINERS
>=20
> between commit:
>=20
>   54e45716a84a ("scsi: remove NCR_D700 driver")
>=20
> from Linus' tree and commit:
>=20
>   01a21986f8ed ("MAINTAINERS: Add Sam as the maintainer for NCSI")
>=20
> from the scsi-mkp tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc MAINTAINERS
> index e5f8823b5f02,f3de5d37179a..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -9810,17 -9750,6 +9810,11 @@@ F:	drivers/scsi/mac_scsi.
>   F:	drivers/scsi/sun3_scsi.*
>   F:	drivers/scsi/sun3_scsi_vme.c
>  =20
> - NCR DUAL 700 SCSI DRIVER (MICROCHANNEL)
> - M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> - L:	linux-scsi@vger.kernel.org
> - S:	Maintained
> - F:	drivers/scsi/NCR_D700.*
> -=20
>  +NCSI LIBRARY:
>  +M:	Samuel Mendoza-Jonas <sam@mendozajonas.com>
>  +S:	Maintained
>  +F:	net/ncsi/
>  +
>   NCT6775 HARDWARE MONITOR DRIVER
>   M:	Guenter Roeck <linux@roeck-us.net>
>   L:	linux-hwmon@vger.kernel.org

This conflict is now between the scsi tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/eFqml6=aE8tyX/oc6ZpjG7Y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltG2SIACgkQAVBC80lX
0Gx6Hgf/SMbEvXbJeM3dKb5yk2j2CDfonGoX6bEP0i9cFldePm/rZ+VgATiPLwtV
gowaZ8HgHy0G6s6Em0xCbruvYcKt1dzYSaiKJj2URgjx4ZlwINeJ2B3yaNZVILsC
XDhuGmwENk7rUHG6MLpuRmE2gHzwf8BvSo5UBuI2KjDrELZakRVE78TTEjb5zlee
rxArcpUWtvGN1I2yUn6aCVp4Uzj5dol9+fgFuHztvqaXgHkEfiI98Cxr5gm4TXYL
fohJn0cvESeGSpclYoqcW+TU7FpimUmjT6mTK85LnVLkYt3STvutA3XEQdaS+c0+
ZFX4oggyvwyZIxam1utY+hzCPxLQiw==
=mzFH
-----END PGP SIGNATURE-----

--Sig_/eFqml6=aE8tyX/oc6ZpjG7Y--
