Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92665C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FB92084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 04:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BUDstZN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfBYEwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 23:52:23 -0500
Received: from ozlabs.org ([203.11.71.1]:49597 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbfBYEwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 23:52:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4478gm2jWhz9s71;
        Mon, 25 Feb 2019 15:52:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551070341;
        bh=R6oATmers/Hz4q0+Zy+5vMoFjFZ2jjSLOGgCjOFp9aU=;
        h=Date:From:To:Cc:Subject:From;
        b=BUDstZN+iT6jgkR3w6Z4y8D9rTU+B0hadHk6EnveN7cmM+MQaGIscH+RU0ZgOS5MH
         STpzO6dfjh4lglQgpr+QR7fGC0mIRYTF+r8xQuhVzFNOg27VsRcPT60UU+ORrmT7p3
         51NS8AcBm/WrL1Y1NipBPRIjb5yd05VS7Tf/6Yqv97pzE0V5nbKWeTls1Dmof+K0eB
         RRCWnc3mor66ACflhC0JQfU4rmIpI3/C+PRw1E9dvqIcLcu7YddVtK0HBIpDhFAgtG
         VRzpd8Dfh6fU5W2h1mYTdiRGBXn15wZPf2IL8j4Qw/5srkjNv/AQdSH4kZFFZXiVRw
         +QG7fOEm3bruw==
Date:   Mon, 25 Feb 2019 15:52:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: linux-next: build warning after merge of the gpio tree
Message-ID: <20190225155219.3ed4979c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Q5yfiHQ1x7dkA5sHNRDHoyX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q5yfiHQ1x7dkA5sHNRDHoyX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

After merging the gpio tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/gpio/gpio-amd-fch.c: In function 'amd_fch_gpio_probe':
drivers/gpio/gpio-amd-fch.c:164:49: warning: passing argument 2 of 'devm_io=
remap_resource' discards 'const' qualifier from pointer target type [-Wdisc=
arded-qualifiers]
  priv->base =3D devm_ioremap_resource(&pdev->dev, &amd_fch_gpio_iores);
                                                 ^~~~~~~~~~~~~~~~~~~
In file included from include/linux/platform_device.h:14,
                 from drivers/gpio/gpio-amd-fch.c:15:
include/linux/device.h:709:15: note: expected 'struct resource *' but argum=
ent is of type 'const struct resource *'
 void __iomem *devm_ioremap_resource(struct device *dev, struct resource *r=
es);
               ^~~~~~~~~~~~~~~~~~~~~

Introduced by commit

  e09d168f13f0 ("gpio: AMD G-Series PCH gpio driver")

--=20
Cheers,
Stephen Rothwell

--Sig_/Q5yfiHQ1x7dkA5sHNRDHoyX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxzdIMACgkQAVBC80lX
0Gwgugf/S+ddkjwOvu8aDpA+Q59Cmr6zPSTiRHYymhFK5M3BtNbclN63WTKNhTzS
NfxsRBgNoGdy4M1wKi7WiQ74kYGyUCin8EV6piBy8x57sE8XPgkwJKddu2bGain1
Lsj5uvS9z3so7RO8Y29wzSSLXduemaMcekWZ8rIfXaWzQitYPc1Tt13P6YLj4z84
2xkFj1FOrfPPeadx+KKYle9Brn33wJ3J/4KK28HOOxAlug25lWZapmWX2FT2Mluv
YJsIc6Tulj6xsqKkGbKJ46DCx5n5jyi4XyBKdBx7+Gve0L44JDA5u9vWiwW5ca4X
f+LKP4eqSI599OSSju4cduQMQFLE0A==
=rkTb
-----END PGP SIGNATURE-----

--Sig_/Q5yfiHQ1x7dkA5sHNRDHoyX--
