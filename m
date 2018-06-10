Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hMSiJl6jHVskaAAAmS7hNA
	; Sun, 10 Jun 2018 22:17:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F6DC60791; Sun, 10 Jun 2018 22:17:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4F964606FA;
	Sun, 10 Jun 2018 22:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F964606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753572AbeFJWQ7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 18:16:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:37226 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753345AbeFJWQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 18:16:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 661EA20850; Mon, 11 Jun 2018 00:16:55 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2AF47203D9;
        Mon, 11 Jun 2018 00:16:45 +0200 (CEST)
Date: Mon, 11 Jun 2018 00:16:45 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 4.18
Message-ID: <20180610221645.GA26123@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Here is the pull-request for the RTC subsystem for 4.18.

Setting the supported range from drivers for RTCs failing soon has
started. A few fixes are developed along the way.
Some drivers have been switched to SPDX by their maintainers.

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc=
-4.18

for you to fetch changes up to e4302aec8a0646828a701443e303eb5ef48b37f5:

  rtc: pxa: fix probe function (2018-06-07 20:11:08 +0200)

----------------------------------------------------------------
RTC for 4.18

Subsystem:
 - rework of the rtc-test driver which allows to test the core more thoroug=
hly
 - rtc_set_alarm() now fails early when alarms are not supported

Drivers:
 - mktime is now replaced by mktime64
 - RTC range added for 88pm80x, ab-b5ze-s3, at91rm9200, brcmstb-waketimer,
   ds1685, ftrtc010, ls1x, mxc_v2, rx8581, sprd, st-lpc, tps6586x, tps65910=
 and
   vr41xx
 - Fixed a possible race condition in probe functions
 - pxa: fix the probe function that is broken since v4.3
 - stm32: now supports stm32mp1

----------------------------------------------------------------
Alexandre Belloni (49):
      rtc: nvmem: don't return an error when not enabled
      rtc: at91rm9200: add range
      rtc: 88pm80x: stop setting a default time
      rtc: 88pm80x: remove unused pm80x_rtc_info members
      rtc: 88pm80x: fix possible race condition
      rtc: 88pm80x: let the core handle the RTC range
      rtc: 88pm80x: convert to rtc_tm_to_time64/rtc_time64_to_tm
      rtc: ab-b5ze-s3: fix possible race conditions
      rtc: ab-b5ze-s3: let the core handle the RTC range
      rtc: tps65910: fix possible race condition
      rtc: tps65910: allow platform power up
      rtc: tps65910: add range
      rtc: rx8581: switch to rtc_register_device
      rtc: rx8581: add RTC range
      rtc: rx8581: let the core handle rtc range
      rtc: rx8581: remove useless indirection
      rtc: rx8581: remove useless declaration
      rtc: rx8581: error out when time invalid
      rtc: rx8581: switch to regmap
      rtc: vr41xx: fix possible race condition
      rtc: vr41xx: add range
      rtc: tps6586x: fix possible race condition
      rtc: tps6586x: let the core handle rtc range
      rtc: ls1x: switch to rtc_register_device
      rtc: ls1x: remove useless label and goto
      rtc: ls1x: add range
      rtc: mxc_v2: fix possible race condition
      rtc: mxc_v2: let the core handle rtc range
      rtc: mxc_v2: use rtc_time64_to_tm in mxc_rtc_read_alarm
      rtc: brcmstb-waketimer: switch to rtc_register_device
      rtc: brcmstb-waketimer: add range
      rtc: st-lpc: fix possible race condition
      rtc: st-lpc: add range
      rtc: test: remove obsolete .set_mmss
      rtc: ds1685: fix possible race condition
      rtc: ds1685: Add range
      rtc: test: remove useless proc info
      rtc: test: allow registering many devices
      rtc: test: store time as an offset to system time
      rtc: test: emulate alarms using timers
      rtc: test: remove irq sysfs file
      rtc: sunxi: fix possible race condition
      rtc: mrst: switch to devm functions
      rtc: ftrtc010: switch to devm_rtc_allocate_device
      rtc: ftrtc010: handle dates after 2106
      rtc: ftrtc010: let the core handle range
      rtc: test: convert to devm_rtc_allocate_device
      rtc: test: remove alarm support from the first device
      rtc: ensure rtc_set_alarm fails when alarms are not supported

Amelie Delaunay (8):
      rtc: stm32: fix copyright and adopt SPDX identifier
      rtc: stm32: fix alarm interrupt flags by removing IRQF_TRIGGER_RISING
      dt-bindings: rtc: update stm32-rtc documentation for st, syscfg prope=
rty
      rtc: stm32: get DBP register and mask from DT st, syscfg property
      rtc: stm32: fix misspelling and misalignment issues
      rtc: stm32: rework register management to prepare other version of RTC
      dt-bindings: rtc: update stm32-rtc documentation for stm32mp1 rtc
      rtc: stm32: add stm32mp1 rtc support

Andrea Greco (1):
      rtc: ds1340: Add support for trickle charger.

Arnd Bergmann (3):
      rtc: vr41xx: remove mktime usage
      rtc: ls1x: remove mktime usage
      rtc: tps6586x: remove mktime usage

Baolin Wang (3):
      rtc: sprd: Change to use devm_rtc_allocate_device()
      rtc: sprd: Add RTC hardware range
      rtc: sprd: Add new RTC power down check method

Dan Carpenter (1):
      rtc: pxa: fix probe function

Enric Balletbo i Serra (2):
      rtc: cros-ec: Make license text and module license match.
      rtc: cros-ec: Switch to SPDX identifier.

Fabio Estevam (3):
      dt-bindings: rtc-2123: Make the node name generic
      rtc: snvs: Switch to SPDX identifier
      rtc: mxc: Switch to SPDX identifier

Mathieu Malaterre (1):
      rtc: jz4740: Fix a typo in Kconfig

Michael Trimarchi (1):
      rtc: sun6i: Fix bit_idx value for clk_register_gate

Uwe Kleine-K=F6nig (2):
      rtc: ds1742: don't explicitly specify word_size and stride of nvmem
      rtc: nvmem: don't use IS_ERR_OR_NULL

Wolfram Sang (1):
      rtc: simplify getting .drvdata

Zhang Rui (3):
      rtc: cmos: allow using ACPI for RTC alarm instead of HPET
      rtc: cmos: acknowledge ACPI driven wake alarms upon resume
      rtc: cmos: introduce quirks to enable use_acpi_alarm mode

 .../devicetree/bindings/rtc/nxp,rtc-2123.txt       |   2 +-
 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  37 ++-
 drivers/rtc/Kconfig                                |   2 +-
 drivers/rtc/interface.c                            |   5 +
 drivers/rtc/nvmem.c                                |   2 +-
 drivers/rtc/rtc-88pm80x.c                          |  58 ++--
 drivers/rtc/rtc-ab-b5ze-s3.c                       |  30 +-
 drivers/rtc/rtc-at91rm9200.c                       |   2 +
 drivers/rtc/rtc-bq4802.c                           |   6 +-
 drivers/rtc/rtc-brcmstb-waketimer.c                |  20 +-
 drivers/rtc/rtc-cmos.c                             | 155 ++++++++--
 drivers/rtc/rtc-cros-ec.c                          |  23 +-
 drivers/rtc/rtc-ds1216.c                           |   6 +-
 drivers/rtc/rtc-ds1307.c                           |   2 +
 drivers/rtc/rtc-ds1511.c                           |   9 +-
 drivers/rtc/rtc-ds1553.c                           |  15 +-
 drivers/rtc/rtc-ds1685.c                           |  66 ++--
 drivers/rtc/rtc-ds1742.c                           |   8 +-
 drivers/rtc/rtc-ftrtc010.c                         |  36 ++-
 drivers/rtc/rtc-lpc32xx.c                          |  16 +-
 drivers/rtc/rtc-ls1x.c                             |  32 +-
 drivers/rtc/rtc-m48t59.c                           |  41 +--
 drivers/rtc/rtc-mrst.c                             |  45 ++-
 drivers/rtc/rtc-mv.c                               |   3 +-
 drivers/rtc/rtc-mxc.c                              |  34 +--
 drivers/rtc/rtc-mxc_v2.c                           |  29 +-
 drivers/rtc/rtc-pcap.c                             |  15 +-
 drivers/rtc/rtc-pxa.c                              |   2 +-
 drivers/rtc/rtc-rx8581.c                           | 210 ++++---------
 drivers/rtc/rtc-sc27xx.c                           |  63 ++--
 drivers/rtc/rtc-sh.c                               |  15 +-
 drivers/rtc/rtc-snvs.c                             |  13 +-
 drivers/rtc/rtc-st-lpc.c                           |  26 +-
 drivers/rtc/rtc-stk17ta8.c                         |  15 +-
 drivers/rtc/rtc-stm32.c                            | 339 +++++++++++++++--=
----
 drivers/rtc/rtc-sun6i.c                            |   4 +-
 drivers/rtc/rtc-sunxi.c                            |  23 +-
 drivers/rtc/rtc-test.c                             | 208 ++++++-------
 drivers/rtc/rtc-tps6586x.c                         |  55 ++--
 drivers/rtc/rtc-tps65910.c                         |  26 +-
 drivers/rtc/rtc-vr41xx.c                           |  35 ++-
 drivers/rtc/rtc-zynqmp.c                           |  10 +-
 include/linux/rtc.h                                |   2 +-
 43 files changed, 904 insertions(+), 841 deletions(-)

--=20
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEXx9Viay1+e7J/aM4AyWl4gNJNJIFAlsdo0kACgkQAyWl4gNJ
NJIw1g/+ObfYPzbp2s5QjWK/2kjPQN5yOrfQ0jP+7f9DzXHoqiRx+Fo4ZXHYWeXQ
9v9aHs1R8vkJ97ZxB9SJ4Q9hTE74FrYY22hiOYrgG0nVAVZ7aIfE0HwAEK5iL8Rg
/P0R8W7JU9JyZW2cQ+fBePJdiGIEYy7kB6gDyPROyUgywvCv0FWkpqMa6PstJuYQ
+MtEI4JQtGBU4vJOLEhwXglHE/hA+fKtn0Muk42bD7I4S9ncDDA3Jp5TLiM007ga
Q158PpmXuj1QZ5zAQ7SfQ+QKrH7hsbrBcCRpxHlu6UJgxXt3bKaOr0XVN2EiXwR2
g+t3UqkG7kIdF1KEfNaxTmM5DxS04hWbOJtL2fBCyGSt2tmSe7SjazfPTyzVP5Wl
GVJ/ygWwPcaceElzft3UrKw95WBdYA1B7LgYZ6+vaBSK8PAeY2/3XO5E3eBkbTqr
c82N3DjbLsjaZk6F1OI61u6mMhXPB/nq7ViUQuBqMrQ48l5pl4jQGu5wv0u2JYz2
t3eTnG4G5WBLUR9GONQ5P5aeo2wKsiS+TCz1GA/J4Fpw7CIIiyjtVc0s+wnlu7pD
vd7M2bgkxcgPuSB+FIGrkGM+rVcmm5v5mTByH/cuI0BIQAYdurg52p+3CuCIzjCJ
V4Ra1LxX2BcNOoOjIIdor9EzA4M+ylc5OXFqvzNnCVmjFiDGZ+U=
=UrCr
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
