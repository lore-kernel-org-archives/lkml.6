Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2925AC0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B627120827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 01:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fGjOD5Xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B627120827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbeKFKhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 05:37:39 -0500
Received: from ozlabs.org ([203.11.71.1]:39447 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbeKFKhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 05:37:38 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42ps6G4BK8z9sCm;
        Tue,  6 Nov 2018 12:15:02 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541466902;
        bh=15H3DMzmLm3Q9kII2/4szy/f8HAKwNf9yMoJjJ4ZxXI=;
        h=Date:From:To:Cc:Subject:From;
        b=fGjOD5Xt4JSn9N8/4Hv32V/DuyMLLUdihXwH7tb7+sM/Ke4l76gr6163m30M36N5A
         vA6/iUcpTI+6EIkUTyjxAM9euCbIJNf7WVAdYA1NVk8uVobynz1/JEEmEQve7V4nPV
         F1BijzblMULs/CetcZCyFIWqHtG33ok8Hgmlm+ZgyTwatmsmw2LoqMuNvfQLW2nKOW
         +cs1CbuxY7jXg5LKvQoMu9dWipnQ3sIS7atB3foM5ZzbebQJg9fbgAmtflCrKUl4NC
         WjqCQTenDCT7MVQQEV2uVL+WPd9d4eQT4YXMQuaqBk6HaGVtfumN6ce6X/CZHP1SUh
         jf7ApiwGvs1yw==
Date:   Tue, 6 Nov 2018 12:15:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUs=?= =?UTF-8?B?w7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: build warning after merge of the gpio tree
Message-ID: <20181106121502.00efbd07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nJS+XEbRbrhzykgBwHnC4Qb"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nJS+XEbRbrhzykgBwHnC4Qb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

After merging the gpio tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

drivers/gpio/gpiolib.c:1514:12: warning: 'devm_gpio_chip_match' defined but=
 not used [-Wunused-function]
 static int devm_gpio_chip_match(struct device *dev, void *res, void *data)
            ^~~~~~~~~~~~~~~~~~~~

Caused by commit

  48207d7595d2 ("gpio: drop devm_gpiochip_remove()")

--=20
Cheers,
Stephen Rothwell

--Sig_/nJS+XEbRbrhzykgBwHnC4Qb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvg6xYACgkQAVBC80lX
0GxG8gf/WbVRfWaYn3Lngdi5dnLP9BfjaWoiXZDfL5yXP1l/vtfsweW6aba88Hpo
cYyDwjsIvYSPttcJQzzr/mQAUL0rbpw0T1kwpuBvRw+n/y9QlEiewG5ZeZDnKK7c
me07E8D4Hq6wSo4ogXYCc78ZJwCTTkNEM+90aIt3oLfU8RVYP6QSVKOzPSVubwDt
z05KJEr5OKH8lA1+jRqZGIdot7U478+A5czV4LhBZF/EbBke/rNShxqrLOekKHbP
ZadZnxc3J6+jOP/wSRPYwMjYPAq2C6NEB2nHvzzbq/isbnIycS/fxQq+/OHIiwt9
JKL4p2C12OcmbiZ7bCThdJrIVCT8GA==
=2g08
-----END PGP SIGNATURE-----

--Sig_/nJS+XEbRbrhzykgBwHnC4Qb--
