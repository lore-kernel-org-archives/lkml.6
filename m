Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id aegZFTwyGlsDTgAAmS7hNA
	; Fri, 08 Jun 2018 07:37:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AD9DF607E4; Fri,  8 Jun 2018 07:37:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gTZtvCQJ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2116160590;
	Fri,  8 Jun 2018 07:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2116160590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeFHHhs (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:37:48 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:40507 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbeFHHhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:37:47 -0400
Received: by mail-io0-f193.google.com with SMTP id g22-v6so14847330iob.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 00:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=o6kt1w0J9N6EEOHZMgNHoY/okiS8LSf1/1iaAswOYfg=;
        b=gTZtvCQJHjL1Q8IxsY2ntiEfAoIrR6pwocd+e2Zo4CmgRZCbDMXRwsqgZXdOYGsMYc
         09FdC5Kk0c4ctlZv3XjPoF1WJ5+qqYj1Y8349u8FCSBmMvKpSUtdVp4LFcwHGqv2H/00
         mTftNQd9hyupicwvjsyEYAPKXEnOLSvErD+9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=o6kt1w0J9N6EEOHZMgNHoY/okiS8LSf1/1iaAswOYfg=;
        b=d3BR7J4Wsiq+8/fBcU1cS801YhPpL+5bWDcgwmVwWPd+7WTFD8y+7UuTR5Q4Vh+Wfp
         9HTRrI50x/q4Yayj82WEgL2g1YByvR7amWLxTU9uNR9RIs2Kd5QORsAwrYuy+0QM4lf5
         bJPeIMQxGTL2cQoqVLVrgRb/OxLF38UMSFxMvEquq7vo6NpLFhhBgm5/8WALlFmwjNfw
         zlMKj2Ujz0aQexr8D/vPYwkQmm9DNp1G6fLIPRduWVcUVTW1wEONqGJfkh4DsjrQUACW
         NjZHYW2Gx/JlcELiCmW8ka9GjPOGQ04VgBvi07X/6woOQpnU5xTkItclMBUiQ3gM7kW0
         2NVQ==
X-Gm-Message-State: APt69E3pyxFq2p1X5jtLk6nDgn1VyO/Qqa9Y0F2j57CR+1qMzInsuaL5
        7tSDOmp6vQ3B+RoNZ0flKBYl/0sWLCMTkV9QCtA7Eg==
X-Google-Smtp-Source: ADUXVKIMMN8am1flFukrRWq0/BNkiqE7Bqs4OlZVc+Q3kx9tm+WpQq741zsQg5XZNQkCiN0XtqvwNGMZI4wwUBmXjWk=
X-Received: by 2002:a6b:1902:: with SMTP id 2-v6mr4206539ioz.304.1528443466222;
 Fri, 08 Jun 2018 00:37:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Fri, 8 Jun 2018 00:37:45 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 8 Jun 2018 09:37:45 +0200
Message-ID: <CACRpkdZcxFVMLo2_R9wMjXSM480sk_74pA7Cv7n28ZDjp=ij-g@mail.gmail.com>
Subject: [GIT PULL] GPIO bulk changes for v4.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the big bulk of GPIO changes for v4.18.

Highlight: we get rid of the pesky VLAs.

The one change hitting MFD has an ACK from the MFD
maintainer.

The rest of the details are in the signed tag as usual.
Mostly smallish cleanups.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.18-1

for you to fetch changes up to 6310b930ccbba55168f30b610fae681d73bd7bd2:

  gpio: davinci: fix build warning when !CONFIG_OF (2018-05-30 09:11:11 +0200)

----------------------------------------------------------------
This is the bulk of GPIO changes for the v4.18 development
cycle.

Core changes:

- We have killed off VLA from the core library and all drivers.
  The background should be clear for everyone at this point:
  https://lwn.net/Articles/749064/
  Also I just don't like VLA's, kernel developers hate it when
  compilers do things behind their back. It's as simple as that.
  I'm sorry that they even slipped in to begin with.
  Kudos to Laura Abbott for exorcising them.

- Support GPIO hogs in machines/board files.

New drivers and chip support:

- R-Car r8a77470 (RZ/G1C)
- R-Car r8a77965 (M3-N)
- R-Car r8a77990 (E3)
- PCA953x driver improvements to accomodate more variants.

Improvements and new features:

- Support one interrupt per line on port A in the DesignWare
  dwapb driver.

Misc:

- Random cleanups, right header files in the drivers, some
  size optimizations etc.

----------------------------------------------------------------
Andy Shevchenko (1):
      gpio: Convert to use match_string() helper

Anson Huang (1):
      gpio: mxc: add clock operation

Baolin Wang (2):
      gpio: eic: Add edge trigger emulation for EIC
      gpio: pmic_eic: Add edge trigger emulation for PMIC EIC

Bartosz Golaszewski (2):
      gpiolib: add hogs support for machine code
      gpio: mockup: use the SPDX identifier and remove license boilerplate

Benjamin Herrenschmidt (2):
      gpio: aspeed: Set output latch before changing direction
      gpio: aspeed: Use a cache of output data registers

Biju Das (1):
      dt-bindings: gpio: rcar: Add r8a77470 (RZ/G1C) support

Colin Ian King (2):
      gpio: 104-dio-48e: make array 'ports' static, shrinks object size
      gpio: make several const arrays static, shrinks object size

Dan Carpenter (1):
      gpiolib: fix gpiochip_machine_hog()

Fabio Estevam (2):
      gpio: mxc: Switch to SPDX identifier
      gpio: mxs: Switch to SPDX identifier

Grigoryev Denis (1):
      gpio: pca953x: Clear irq trigger type on irq shutdown

H. Nikolaus Schaller (8):
      gpio: pca953x: convert register constants to hex
      gpio: pca953x: add more register definitions for pcal953x
      gpio: pca953x: add more register definitions for pcal6524
      DTS: Bindings: pca953x add an optional vcc-supply property
      pca953x: add example how to use interrupt-controller and gpio-controller
      gpio: pca953x: set the PCA_PCAL flag also when matching by DT
      gpio: pca953x: define masks for addressing common and extended registers
      gpio: pca953x: fix address calculation for pcal6524

Heiko Stuebner (1):
      gpio: syscon: allow fetching syscon from parent node

Jacopo Mondi (1):
      dt-bindings: gpio: Add support for r8a77965

Laura Abbott (3):
      gpio: xra1403: Switch to a fixed upper bound for registers
      gpio: Remove VLA from gpiolib
      gpio: Remove VLA from stmpe driver

Linus Walleij (24):
      gpio: Add a reference to CEC on GPIO
      gpio: loongson: Use right include
      gpio: loongson: Create a dynamic platform device
      gpio: loongson: Use BIT() macros
      gpio: lp3943: Include the right header
      gpio: lp873x: Include the right header
      gpio: lpc32xx: Include the right header
      gpio: lynxpoint: Include the right header
      gpio: max730x: Include the right header
      gpio: mc33880: Include the right header
      gpio: mc9s08dz60: Include the right header
      gpio: ml_ioh: Include the right header
      gpio: mm-lantiq: Include the right header
      gpio: msic: Include the right header
      gpio: mvebu: Use the proper APIs
      gpio: mxc: Remove reliance on <linux/gpio.h>
      gpio: octeon: Include the right header
      gpio: omap: Include the right header
      gpio: palmas: Include the right header
      gpio: pca953x: Include the right header
      gpio: pcf857x: Include the right header
      gpio: pch: Include the right header
      gpio: pl061: Include the right header
      gpio: pxa: Include the right header

Michal Simek (1):
      gpio: zynq: Setup chip->base based on alias ID

Phil Edworthy (3):
      gpio: dwapb: Add support for 1 interrupt per port A GPIO
      gpio: dwapb: Rework support for 1 interrupt per port A GPIO
      gpio: dwapb: Fix rework support for 1 interrupt per port A GPIO

Sekhar Nori (1):
      gpio: davinci: fix build warning when !CONFIG_OF

Shubhrajyoti Datta (2):
      gpio: zynq: Remove call to platform_get_irq
      gpio: zynq: simplifly getting drvdata

Thierry Reding (13):
      gpio: 74xx-mmio: Use of_device_get_match_data()
      gpio: dwapb: Use of_device_get_match_data()
      gpio: ge: Use of_device_get_match_data()
      gpio: ingenic: Use of_device_get_match_data()
      gpio: mxs: Use of_device_get_match_data()
      gpio: palmas: Use of_device_get_match_data()
      gpio: pca953x: Use of_device_get_match_data()
      gpio: pxa: Use of_device_get_match_data()
      gpio: syscon: Use of_device_get_match_data()
      gpio: ts4900: Use of_device_get_match_data()
      gpio: vf610: Use of_device_get_match_data()
      gpio: xlp: Use of_device_get_match_data()
      gpio: ge: Fix build warning

Yoshihiro Shimoda (1):
      gpio: rcar: Add DT binding for r8a77990

 .../devicetree/bindings/gpio/gpio-pca953x.txt      |  34 +++++
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   3 +
 .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |   9 +-
 Documentation/driver-api/gpio/board.rst            |  16 +++
 Documentation/driver-api/gpio/drivers-on-gpio.rst  |   4 +
 drivers/gpio/Kconfig                               |  12 ++
 drivers/gpio/gpio-104-dio-48e.c                    |   2 +-
 drivers/gpio/gpio-104-idi-48.c                     |   2 +-
 drivers/gpio/gpio-74xx-mmio.c                      |   9 +-
 drivers/gpio/gpio-aspeed.c                         |  24 +++-
 drivers/gpio/gpio-davinci.c                        |   2 -
 drivers/gpio/gpio-dwapb.c                          |  57 ++++----
 drivers/gpio/gpio-eic-sprd.c                       |  73 +++++++++++
 drivers/gpio/gpio-ge.c                             |   4 +-
 drivers/gpio/gpio-gpio-mm.c                        |   2 +-
 drivers/gpio/gpio-ingenic.c                        |   4 +-
 drivers/gpio/gpio-loongson.c                       | 116 ++++++++++-------
 drivers/gpio/gpio-lp3943.c                         |   2 +-
 drivers/gpio/gpio-lp873x.c                         |   2 +-
 drivers/gpio/gpio-lpc32xx.c                        |   3 +-
 drivers/gpio/gpio-lynxpoint.c                      |   2 +-
 drivers/gpio/gpio-max730x.c                        |   2 +-
 drivers/gpio/gpio-mc33880.c                        |   2 +-
 drivers/gpio/gpio-mc9s08dz60.c                     |   2 +-
 drivers/gpio/gpio-ml-ioh.c                         |   2 +-
 drivers/gpio/gpio-mm-lantiq.c                      |   2 +-
 drivers/gpio/gpio-mockup.c                         |   7 +-
 drivers/gpio/gpio-msic.c                           |   2 +-
 drivers/gpio/gpio-mvebu.c                          |  20 ++-
 drivers/gpio/gpio-mxc.c                            |  54 ++++----
 drivers/gpio/gpio-mxs.c                            |  32 ++---
 drivers/gpio/gpio-octeon.c                         |   2 +-
 drivers/gpio/gpio-omap.c                           |   2 +-
 drivers/gpio/gpio-palmas.c                         |   8 +-
 drivers/gpio/gpio-pca953x.c                        |  81 ++++++++----
 drivers/gpio/gpio-pcf857x.c                        |   2 +-
 drivers/gpio/gpio-pch.c                            |   2 +-
 drivers/gpio/gpio-pl061.c                          |   2 +-
 drivers/gpio/gpio-pmic-eic-sprd.c                  |  58 ++++++++-
 drivers/gpio/gpio-pxa.c                            |  10 +-
 drivers/gpio/gpio-stmpe.c                          |   9 +-
 drivers/gpio/gpio-syscon.c                         |   9 +-
 drivers/gpio/gpio-ts4900.c                         |   7 +-
 drivers/gpio/gpio-vf610.c                          |   4 +-
 drivers/gpio/gpio-xlp.c                            |   9 +-
 drivers/gpio/gpio-xra1403.c                        |  15 +--
 drivers/gpio/gpio-zynq.c                           |  14 +-
 drivers/gpio/gpiolib-of.c                          |   7 +-
 drivers/gpio/gpiolib.c                             | 143 ++++++++++++++++++---
 drivers/gpio/gpiolib.h                             |   2 +-
 drivers/mfd/intel_quark_i2c_gpio.c                 |   3 +-
 include/linux/gpio/consumer.h                      |  10 +-
 include/linux/gpio/machine.h                       |  31 +++++
 include/linux/platform_data/gpio-dwapb.h           |   3 +-
 54 files changed, 647 insertions(+), 293 deletions(-)
