Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D7BFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA9821872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 04:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HmUfWe28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfAXESn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 23:18:43 -0500
Received: from ozlabs.org ([203.11.71.1]:43373 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbfAXESn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 23:18:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43lTRh5MX6z9s3l;
        Thu, 24 Jan 2019 15:18:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548303521;
        bh=CW7rRce9yAofJLg6P8nY4zp44cpnbbaCGQqUxo9Jgio=;
        h=Date:From:To:Cc:Subject:From;
        b=HmUfWe28UggIioPgvg+Fw19wbYGDF4mcvVGLMGb9qoDnTdOo3bJnisaPDqowya9yu
         IR1gjqrnM87QAvHUnBsadPhhoSTIWekggmGLZT/bf2tt68XFcyHtcGoVNWfpb+saEF
         Eeunt0MBRDp6TlKymQdAknm+o58OPcrDCnWyugM8aR4i+5bmZB2hQ/gXOzt/ELKpLx
         l+fbF6ta+3UDXFJbjb7zXc0qDMfM8acCvlSrCdlfyl1oM73mQgSGyUYD6yx7x54007
         vRAm4JufLffhrf+aaif5VOzP7I/07vogW9/DZfqD9VUI1ew+0z4mIQmHEGiGiEJS1r
         yfn2TBzXDGo/g==
Date:   Thu, 24 Jan 2019 15:18:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: linux-next: build warning after merge of the gpio-brgl tree
Message-ID: <20190124151837.1ca96816@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LlXZFtKaEVR7rnrGM1hZWEG"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LlXZFtKaEVR7rnrGM1hZWEG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

After merging the gpio-brgl tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/gpio/gpio-davinci.c: In function 'davinci_gpio_get_irq_chip':
drivers/gpio/gpio-davinci.c:472:9: warning: function returns address of loc=
al variable [-Wreturn-local-addr]
  return &gpio_unbanked.chip;
         ^~~~~~~~~~~~~~~~~~~
drivers/gpio/gpio-davinci.c: In function 'keystone_gpio_get_irq_chip':
drivers/gpio/gpio-davinci.c:480:9: warning: function returns address of loc=
al variable [-Wreturn-local-addr]
  return &gpio_unbanked;
         ^~~~~~~~~~~~~~

Introduced by commit

  ee5e87158e63 ("gpio: davinci: drop pointless static qualifier")

--=20
Cheers,
Stephen Rothwell

--Sig_/LlXZFtKaEVR7rnrGM1hZWEG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxJPJ0ACgkQAVBC80lX
0Gyx9gf9EKJ9DCt1Nu7gnajJQwYGbD7ESYO7qE4omL8blmk1d8l5HhZPRCUNwjEA
HnpxqQqbaTgnU0e/fW7RvtHI6awvPW5N+FMkejs55NPeOzQTTUyEeq7j4FzCNgO7
twVCJS0+ntB5FuwARb3uivUq2z6iMKTFBJaetxlGJ+JcTEIm/tT586aMkhlkdx8N
8wUMWSNXF/YlIx7RPaYtKYYwZYrQmnXTALuw8o1ApBZMyThMPj5XeoQo7EJH86Y2
UqgwNioJvYi6OY3xbnrD9dqrMOEV8sJuSkS4v3Befaxs9FqvsXTy0TvVZ7nOv7om
ZDWBZz+3qvSiy3Asu4XpCq1kdhG54A==
=Z22C
-----END PGP SIGNATURE-----

--Sig_/LlXZFtKaEVR7rnrGM1hZWEG--
