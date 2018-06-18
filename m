Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DB5C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA8F20836
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 03:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kunnzuLw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EA8F20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbeFRDqr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 23:46:47 -0400
Received: from ozlabs.org ([203.11.71.1]:41775 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754549AbeFRDqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 23:46:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418H8M5kgpz9s31;
        Mon, 18 Jun 2018 13:46:43 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529293603;
        bh=0l2cBjj9XYazQj8kl7e6tca0h+L213eXwc55KNgZlVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kunnzuLwant7Ahwj73k4fJQXSxGi7J8+/YqjcfqgVAnup4U7A/aGrTLyvcruPIvy3
         78wDSnSeMtd+vOcvyR0yS+8mgF14rTc0ViQGgAVX2PC5iujBgstAQPbngNo9rLR71H
         Tb1YzgzNqPgDTCFgQ4Acmo2wdnco7QuQR2wfldTWeRYIPgODLUsmP/D0An2+jeYGtq
         Bh9JsMV2rqFNhHoTHtpc1ClJ7M1LRXlzsE7Kvwi2AxualsycGrcdCUxZMpUl/4dEF7
         TL70WiwNXvOQeEpjKdTEPkqzqpnvcxxnGtTuo6buwSQKKBPiV5p2lnUSYbAkWJ7pfS
         6K1a3ywkjCanw==
Date:   Mon, 18 Jun 2018 13:46:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Samuel Ortiz <sameo@linux.intel.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: Re: linux-next: build warning after merge of the nfc-next tree
Message-ID: <20180618134643.27e47330@canb.auug.org.au>
In-Reply-To: <20180612101954.63eb9e60@canb.auug.org.au>
References: <20180612101954.63eb9e60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/B00vV8p5HaA88v/ucws0TlM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/B00vV8p5HaA88v/ucws0TlM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 12 Jun 2018 10:19:54 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the nfc-next tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>=20
> drivers/nfc/fdp/fdp.c: In function 'fdp_nci_open':
> drivers/nfc/fdp/fdp.c:250:17: warning: unused variable 'dev' [-Wunused-va=
riable]
>   struct device *dev =3D &info->phy->i2c_dev->dev;
>                  ^~~
> drivers/nfc/fdp/fdp.c: In function 'fdp_nci_close':
> drivers/nfc/fdp/fdp.c:260:17: warning: unused variable 'dev' [-Wunused-va=
riable]
>   struct device *dev =3D &info->phy->i2c_dev->dev;
>                  ^~~
> drivers/nfc/fdp/fdp.c: In function 'fdp_nci_send':
> drivers/nfc/fdp/fdp.c:268:17: warning: unused variable 'dev' [-Wunused-va=
riable]
>   struct device *dev =3D &info->phy->i2c_dev->dev;
>                  ^~~
> drivers/nfc/fdp/fdp.c: In function 'fdp_nci_recv_frame':
> drivers/nfc/fdp/fdp.c:279:17: warning: unused variable 'dev' [-Wunused-va=
riable]
>   struct device *dev =3D &info->phy->i2c_dev->dev;
>                  ^~~
> drivers/nfc/fdp/fdp.c: In function 'fdp_nci_core_reset_ntf_packet':
> drivers/nfc/fdp/fdp.c:602:17: warning: unused variable 'dev' [-Wunused-va=
riable]
>   struct device *dev =3D &info->phy->i2c_dev->dev;
>                  ^~~
> drivers/nfc/fdp/fdp.c: In function 'fdp_nci_prop_patch_ntf_packet':
> drivers/nfc/fdp/fdp.c:614:17: warning: unused variable 'dev' [-Wunused-va=
riable]
>   struct device *dev =3D &info->phy->i2c_dev->dev;
>                  ^~~
> drivers/nfc/fdp/fdp.c: In function 'fdp_nci_remove':
> drivers/nfc/fdp/fdp.c:789:17: warning: unused variable 'dev' [-Wunused-va=
riable]
>   struct device *dev =3D &info->phy->i2c_dev->dev;
>                  ^~~
>=20
> Introduced by commit
>=20
>   7579d009c4a1 ("NFC: fdp: Remove __func__ from dev_dbg()")

I am still getting these ...
--=20
Cheers,
Stephen Rothwell

--Sig_/B00vV8p5HaA88v/ucws0TlM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnKyMACgkQAVBC80lX
0GxhiQgAnmYKkMeQI+5m4nHRXIoy6KPTzRjEPt4sppt50b7f3borRcgkbul5H/Ac
90KbtduoaUAqNuKsCq2s7ZHrL/Nh1LPFebU6mQH1M6utuaT8BIbnBDhYsWZzJkSv
L24MMhsqXwl85QRwMh+6P8ZgV0t9KCDka47TvS679/Rf+/0wPFR8Esyljv5xJJKo
BYQyax0OjlABsXVBDF/OUaVcpvW27yQXVtCS3y9jilVnRIrerVxy55hfUvEZ+DOg
cDyXtiQaaShggG9tvtzP4+6DARjUm9sUMOrZVWxIGg+JtqcTxC5J12bLimPDBsJr
1uUhKv6FMvAszBL2TRW4WyKNU1Xm/g==
=/l+W
-----END PGP SIGNATURE-----

--Sig_/B00vV8p5HaA88v/ucws0TlM--
