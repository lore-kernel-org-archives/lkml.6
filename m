Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A2DC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 01:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727F2208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 01:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGMvLYWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 727F2208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbeGIBNb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 21:13:31 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37655 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933368AbeGIBN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 21:13:29 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so5219531plc.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 18:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MqlCR35pg1Nd2tj3329NOthUCf0aYbBw75+wG299Dng=;
        b=bGMvLYWsUJ5GLbsJPMbaXGF5pgN/NYK0RNoH/ch59VrHx1jRaVaYdjytpmF6qkkfHx
         yBCm7sQfpaUyK5com4g5J8RYiZgXn7ZPo+1d1kRJOj2Kk5rpt5cPRHwItuVJxaldw9dQ
         ZXb9UtDek0TmRkIq3TgVuW34sPQAfggLJ5rQS7k8pJJ4avzC5krrZR5cbr2NwB9h31oi
         ++ivIPQWBqlvGAZ6KWXXMLoNAcYt7kHNcFhouQrcEngcTb12zlzylVaSn2KNX3zfDNXp
         QFRR7AGpecu5ErWrVqwt54mEpwfigBwTYzEQOy0eW1hT79Iv7xx+h2DBJyk38q6Lx8KB
         7tmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MqlCR35pg1Nd2tj3329NOthUCf0aYbBw75+wG299Dng=;
        b=DLDsYmDlvhdY+QjlsQOPpO2qNBr2V6gkTq2zoaRZBQifTA8nmrnwQFezQNindgnEoq
         PIpcTXYl3IjO+7SRDLE8HYZ2Hs4T/JKOkEokXxLTw75q5OalAmEbG0pLHETeCsCmO2ag
         D9Zli5dGUmtm+siWjrVZN4Z6zPWBHsbVe5mz+i+BLhDcGJVglXrSH9KF8aF9KEhroRIQ
         xjsYp2YqjMuXRw8KERRRjx9uygVltIOhL8yHXesXu7HSQhKSU/Iyz31d/htaPT98cAZf
         TM5vKBS81ffcf/BcDV0rxvFXGO3Fvn/+KCxiTgczWOCNVDDKzcLSvYDbEzHpQl/opNli
         iNGw==
X-Gm-Message-State: APt69E2q+MJfWJee/U+V2VxggE78Kwz+tky9HK6v2zUCqaKuoWlvmQNt
        /Muf5i4mFW/kxlU2Hs0TQVUwNw==
X-Google-Smtp-Source: AAOMgpfYwwnAXO+t556dyrtGKP/u6MZPXsF4J4mWt+BFEcoPCPflqrJuV8dCwG7AWtoN8ivFlHmYQA==
X-Received: by 2002:a17:902:1682:: with SMTP id h2-v6mr18589920plh.327.1531098808435;
        Sun, 08 Jul 2018 18:13:28 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:0:1000:1501:e4e8:e3c6:19f1:ae51])
        by smtp.gmail.com with ESMTPSA id x184-v6sm6396581pfx.188.2018.07.08.18.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Jul 2018 18:13:26 -0700 (PDT)
Date:   Sun, 8 Jul 2018 18:13:24 -0700
From:   Benson Leung <bleung@google.com>
To:     lee.jones@linaro.org, dmitry.torokhov@gmail.com,
        linux@armlinux.org.uk
Cc:     bleung@chromium.org, enric.balletbo@collabora.com, krzk@kernel.org,
        linux-kernel@vger.kernel.org, bleung@google.com
Subject: [GIT PULL] Immutable branch (mfd, chrome) due for the v4.19 window
Message-ID: <20180709011324.GA86474@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Please see this Immutable Branch which moves the cros_ec_i2c and cros_ec_spi
transport drivers from mfd to platform/chrome. Changes in arm are a simple
rename in defconfigs. Change in input is a rename in help text.

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/ib-platform-chrome-mfd-move-cros-ec-transport-for-4.19

for you to fetch changes up to 413c94469a9db26ac4e1d16bf8de0248de93e2d8:

  Input: keyboard: Fix ChromeOS EC keyboard help message. (2018-07-03 12:40=
:44 -0700)

----------------------------------------------------------------
Immutable branch (mfd, chrome) due for the v4.19 window

Immutable Branch which moves the cros_ec_i2c and cros_ec_spi
transport drivers from mfd to platform/chrome. Changes in arm are a simple
rename in defconfigs. Change in input is a rename in help text.

----------------------------------------------------------------
Enric Balletbo i Serra (3):
      platform/chrome: Move cros-ec transport drivers to drivers/platform.
      arm/arm64: configs: Remove the MFD_ prefix for MFD_CROS_EC_I2C/SPI sy=
mbols.
      Input: keyboard: Fix ChromeOS EC keyboard help message.

 arch/arm/configs/exynos_defconfig              |  4 ++--
 arch/arm/configs/multi_v7_defconfig            |  4 ++--
 arch/arm/configs/pxa_defconfig                 |  4 ++--
 arch/arm64/configs/defconfig                   |  4 ++--
 drivers/input/keyboard/Kconfig                 |  2 +-
 drivers/mfd/Kconfig                            | 20 --------------------
 drivers/mfd/Makefile                           |  2 --
 drivers/platform/chrome/Kconfig                | 20 ++++++++++++++++++++
 drivers/platform/chrome/Makefile               |  2 ++
 drivers/{mfd =3D> platform/chrome}/cros_ec_i2c.c |  0
 drivers/{mfd =3D> platform/chrome}/cros_ec_spi.c |  0
 11 files changed, 31 insertions(+), 31 deletions(-)
 rename drivers/{mfd =3D> platform/chrome}/cros_ec_i2c.c (100%)
 rename drivers/{mfd =3D> platform/chrome}/cros_ec_spi.c (100%)

Thanks,
Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAltCtrQACgkQHwn1ewov
5lgVkQ//fj7eT1T+eKO4lXyJJeWvbdgJL3si47C3BQcL+4DNn87ElZhqdFNtA/I8
OzZGeEkKeCL5e/GTIy5CGWS63HZ7L0QeaP7Z5W2sScGqELMWcVMdYuD80z85R20S
UzmdAG3fxXAGbHHglX8PGuXUZLxjVgyz0TSSrmHrlxj3sd5V9J2hqXzSVf1NlphK
1PnpoMSF+pqI07trhCNue4/tKFmtAjK0LqKpgqi+zyEKN2aA45yfeYMbZOseIHXx
ey7qWFAqASPNlN1B80xMJt+VqFi8Im8MvVFnaz4M94zSsI6AVYTVD79a/jyAIbb6
9UUsbHEEfQJdl/ATVbDcbpr+zX/bCGolI7OG5oxYXzpXbW1DydFjVkg7GzpbCleM
+8C18XjHRbDj4F1cRJQkXai8QFBJrZaT3G6mt5/47Pszey4wO2jsyibuWtTQJQLV
qIRYC43WqJTr1/gRvGJcNfo/F3OeR+mGVR2WXJoxn2ZWuP6zGCt5qrJexqyFD9VE
AuM36zU2Z/G0i5zIstrjHB5axi+WWiz/ldVlpxz9zaa1EWM8SWi0DSTFIfwGHR7e
KlE30A6opgDmL0/5jJv5p8Zy+M9VEzzaf8SDlaC2mCWsDsvqWfl0QTahKFWJOQnr
R6nSLjBrjkl97d1fYHBjZ7o73RJwcY+drlaEhMF6zKjilL8egDA=
=AyoL
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
