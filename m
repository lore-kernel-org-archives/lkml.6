Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E7DC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6389620989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6389620989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbeLGNI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:08:56 -0500
Received: from sauhun.de ([88.99.104.3]:36254 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeLGNIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:08:55 -0500
Received: from localhost (p54B335DA.dip0.t-ipconnect.de [84.179.53.218])
        by pokefinder.org (Postfix) with ESMTPSA id 45DF73E409C;
        Fri,  7 Dec 2018 14:08:53 +0100 (CET)
Date:   Fri, 7 Dec 2018 14:08:52 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PULL REQUEST] i2c for 4.20
Message-ID: <20181207130848.GA2661@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

here is a set of driver bugfixes for the I2C subsystem.

Please pull.

Thanks,

   Wolfram


The following changes since commit 2e6e902d185027f8e3cb8b7305238f7e35d6a436:

  Linux 4.20-rc4 (2018-11-25 14:19:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-current-fixed

for you to fetch changes up to ece27a337d42a3197935711997f2880f0957ed7e:

  i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode (2018-12-06 23:14:59 +0100)

----------------------------------------------------------------
Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c: axxia: properly handle master timeout

Hans de Goede (1):
      i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI device node

Masahiro Yamada (4):
      i2c: uniphier-f: fix timeout error after reading 8 bytes
      i2c: uniphier-f: fill TX-FIFO only in IRQ handler for repeated START
      i2c: uniphier: fix violation of tLOW requirement for Fast-mode
      i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

Wolfram Sang (3):
      i2c: nvidia-gpu: adhere to I2C fault codes
      i2c: nvidia-gpu: limit reads also for combined messages
      i2c: rcar: check bus state before reinitializing


with much appreciated quality assurance from
----------------------------------------------------------------
Ajay Gupta (2):
      (Test) i2c: nvidia-gpu: limit reads also for combined messages
      (Test) i2c: nvidia-gpu: adhere to I2C fault codes

Alexander Sverdlin (1):
      (Rev.) i2c: axxia: properly handle master timeout

 drivers/i2c/busses/i2c-axxia.c      | 40 +++++++++++++++++++++---------
 drivers/i2c/busses/i2c-nvidia-gpu.c |  7 +++---
 drivers/i2c/busses/i2c-rcar.c       |  9 ++++---
 drivers/i2c/busses/i2c-scmi.c       | 10 +++++---
 drivers/i2c/busses/i2c-uniphier-f.c | 49 +++++++++++++++++++++++++++++++------
 drivers/i2c/busses/i2c-uniphier.c   |  8 +++++-
 6 files changed, 93 insertions(+), 30 deletions(-)

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwKcNsACgkQFA3kzBSg
KbZd4g/+K83Z6ZNIGbaMlGp7tKZ9ayTWeEvmv2JhaHK3SpxgZ2nO1K9eoiU9MFqK
u2ZDLz/BYw/6DGDy0KRH1lvoY3mVFBkUjEEJw/8b71WUBSrbkdwWZlLylegNQh8Y
MwEabGFaVxylntmyrnjBKrqWuqYIBcKcnyJDZHWldgzoLF35loR1dO8dIfjDLW3H
M/rK5GmP+a2L1IRuk6awewilF2NGiiCIXFj08s8hyepxJzrDmKYFXcguuRC4yuGH
lZtJtzZ05w1gVXbDrVw9N4N7ghmbSXtlyFxO1/V+dyhecxbh+FB+zNthyaveLcJY
lux0xvD3xsAnLV+F1IMMXmUlKDiI1iyT7Lqvu5BM8LtxX072yNBv53z6F8CHHpvP
G8XzoZSKmMNfU9+WzkpaRhCKFW7JCnoJCvsecJKwYSEjhZubsSMOoJuZ7/NHg7zY
x8LO5RfAayLbv7CGmUa6mWEBCdIEP4Uds/+j65gzTCAQT5pFV/nVjwQ9dlLSfipI
hEF4gIQnqRIYaRTaBsMMYEXCuSgkxmw8a1hB2fMXE/eRbsT2AGma35dLU5AqYY5I
ra9W5dSjIKYnmjSfNXFiI8rGjFWnWY92+6BwTQEuUKuUvrVMspgBRloCrEHuTRVp
LmBZkqIWrRStxxZ7SrNkBEmd8gqiu00sIROPSxEFZQjHDFIrjgo=
=Kb0Z
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
