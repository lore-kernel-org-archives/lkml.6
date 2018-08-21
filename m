Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7218FC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2022D2177F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 18:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lxKZ9Q+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2022D2177F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeHUWPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 18:15:37 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:33925 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbeHUWPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 18:15:37 -0400
Received: by mail-pg1-f176.google.com with SMTP id y5-v6so8870095pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eDP3J3WmsoXeJC+IogDc2Ql6ygKt2z7zmKuDC4K7ytY=;
        b=lxKZ9Q+FkazkoUsKzbXw03WbFALJ+UBqWn1OlPvtdzOf7c8X4hkiLTIXaJXK17piQW
         Qoa7bgWRi+kHf4K4Ve855B4+dPac3taLOry2Re5qBdHQ9NpiiFYF3UR92Jb1tLhTDIZS
         kStqCYy5ta1MmpJLwcYJzf0TAcrSGWj6OoqlqAU+mntgAVLsdMx9PK0luNBW4RZd8T82
         0msw07s4LDAUGIL1y0+Wc0K/HMLCMkbELfBNpgxPdoMCRSYipAQtmR7ycNfIKowCBRGe
         q7txsGPiLL/QFtP430RAj2QSHf76UdXf+rXABikZ2PxQdfhslJBHPlNr6rg2TKygv7Db
         j6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eDP3J3WmsoXeJC+IogDc2Ql6ygKt2z7zmKuDC4K7ytY=;
        b=kXSqw0z74+1uB5p1dC0APLaMCZc64dJRFo6W77iCOLvDzvMisg315EEe+0RVHPme0y
         K3NAEl2xr3wq/RvrcodMxreVrN4J+KhKCHqbNf4c8ouCdCAEO+qoC+yuPD//WypRF9Hc
         CS0mHjWW5LGmBbQYqt2cog5EQ7+EY+axTKHlzvkSCCB4DACuQbzUjEUaBnYlsBtUJE04
         1QB4MsgtIQaBy7G0KDZohx+Xk9kUPaPEYmXt7orTZ3OLozqiK0DtY5N+BFuiOBHWF4zM
         YFrj1rsS/baBQc783/dWL5+M5WchESgdDeVVzCkdwIcAeEN+NDvS88HnPYVDfJ4LcmU8
         ophA==
X-Gm-Message-State: APzg51DITqaiMJjr1wk9kaO8hzTlpcjxYTGJR2iMTkDL/4VrEGBoZqz3
        dwiK9YqqkDEu2aDZywTise4xzqfisiM=
X-Google-Smtp-Source: ANB0VdZf3V4k+fQICcar8qfl+C0U2P1ON7Rhhil1AlfVUJCWDNQXnXYlXXV5Ai8SFvY7a0dOCmeg8w==
X-Received: by 2002:a63:5126:: with SMTP id f38-v6mr1917700pgb.30.1534877656591;
        Tue, 21 Aug 2018 11:54:16 -0700 (PDT)
Received: from decatoncale.mtv.corp.google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id f6-v6sm20502862pgf.52.2018.08.21.11.54.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Aug 2018 11:54:15 -0700 (PDT)
Date:   Tue, 21 Aug 2018 11:54:13 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, bleung@chromium.org
Subject: [GIT PULL] chrome-platform updates for v4.19
Message-ID: <20180821185413.GA40305@decatoncale.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git =
tags/chrome-platform-for-linus-4.19

for you to fetch changes up to 40291fb75123816b35ba06696e56b9cf2d96bf90:

  Merge tag 'ib-platform-chrome-mfd-move-cros-ec-transport-for-4.19' into w=
orking-branch-for-4.19 (2018-07-09 16:36:00 -0700)

----------------------------------------------------------------
Minor changes this time around for 4.19.

cros_ec_i2c and cros_ec_spi drivers moved from mfd
to chrome platform.

----------------------------------------------------------------
Benson Leung (2):
      platform/chrome: chromeos_tbmc - fix SPDX identifier
      Merge tag 'ib-platform-chrome-mfd-move-cros-ec-transport-for-4.19' in=
to working-branch-for-4.19

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
 drivers/platform/chrome/chromeos_tbmc.c        | 10 +++++++++-
 drivers/{mfd =3D> platform/chrome}/cros_ec_i2c.c |  0
 drivers/{mfd =3D> platform/chrome}/cros_ec_spi.c |  0
 12 files changed, 40 insertions(+), 32 deletions(-)
 rename drivers/{mfd =3D> platform/chrome}/cros_ec_i2c.c (100%)
 rename drivers/{mfd =3D> platform/chrome}/cros_ec_spi.c (100%)


--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlt8X9UACgkQHwn1ewov
5lhjmRAAiwIQLxx7vbhzc7q7gvHuSDPPfEPSCfzlEAgq7UORSXFvZ8BAsqBPDKIm
5mtg9FLYvmVMtx088icfOLGOzycfsGIlvN0RY6UqM6uAFt1BQcsNAChrz+WTE7u+
HKFU7JZcSKyiArESxN0neYpm9XMv+5MvZVpfqkCMmppxBcelzBV5G+yyXaJU7DQF
01I8MDVsNlv+RESVbHsD09jVbDGC9qIXnsP5GNRY/ncbW5k5TP4X8VTcTBqThY2o
b1n0SYzyE/5aC/uIoqq97yIe1DBbR0VG/6FrZ+wZ0AoquBrfrZzb79FLuJ5270J6
KQCMITJO2UGLghvjMoX0Ouf249gHCa1SLOIzOAys73VNS6iAKK1MG49kENpoezqo
ku2wfd5mtLvY52TPl6suyuITTk83aEvNPfYuABYYMkCrpTTFIxHczaPbNVfDboyk
Tl/glXI+P60xY/FAhGzxPvUtVvbjCTUiD4S9SKSl1S+qQ2/v0Yn08Ds9FhVq26In
x8K5przHuIp05u/7DPo5pPctlpx92aWnJO/soG8IV6+JlFBk+skc1or7ZYMUR7Qh
QWJK4fjVxXDmqkn51JBJE2t+24siywSRmPlKDz9KTA8t5fE0bVhYGQvPtFuewwcE
JpDApQxy8bcKwGU4wwwL01ShD6RGO9oQA8Cx0GSmRviw83HQiWs=
=nk1l
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
