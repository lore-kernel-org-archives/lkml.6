Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C43C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A955021477
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 15:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eI0qM3/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A955021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbeHOSJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 14:09:54 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:47043 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbeHOSJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 14:09:53 -0400
Received: by mail-io0-f193.google.com with SMTP id x5-v6so1229198iop.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 08:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=w44I4Z74m6kqdxKs2f3rClnLPeQr6/0qyNZSUx9e7GY=;
        b=eI0qM3/vmtUZgaNw96y2r/hAD1l3mMzUYgPrNlalhKl9Hlkikib7MYjLuWnKTKw9Gd
         UhyR/IfzwMF09TgcpHrSIBaLEi47JTB1bpvUxoaHWxRTvexqyD9UZ8Uad2ekRwUWLwpS
         8NYkA7iZoU1d5P8wsr/0JTH1HHb8JCHlQb+6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=w44I4Z74m6kqdxKs2f3rClnLPeQr6/0qyNZSUx9e7GY=;
        b=R9yvqveAk2MYyTF3lW9HVlN4QUu7bWSslWNA/dPTMCmnMflNt3sSAjZ81NzAO7atVW
         itUyDms7AlA8TbSBNxq3xCyXlm6vV+wqz+r6+UJ8t0ijE1oxgNl0DPjPowY3E5fmAhym
         0cCahxiiTwyxIQK/W/QOZrnHy+6jFvhgwqCPjHOjXv/nmrz6R2JwyXrSeO81FY+QsyVF
         3npGPVP0JFyIip80NqPJW59tUUuFsI/uFO+S/6zrs2IkWXRS8ceY+x6ceat467hpY/Iq
         +M4DsNbQCacnp80iFSLX7w1rBAS0WvUM5cOcnl8o+WXgT4/lQ7YaNjV+v41aERDVZGMZ
         9dDg==
X-Gm-Message-State: AOUpUlFfYKAV/x/s7e2GrIOAXUhjUmw0CNnR8bb4pKUKu0+mcC/sOsSz
        MUd5BpUMAuNKVLMZYS86yw9BIPP6VHNWC7VutuuFHHk4trffFQ==
X-Google-Smtp-Source: AA+uWPzdgC5Rf/5JUlQ+dit9/mtZ+RJGjfV5cWg0gpcJ0tde40o3xd9PURrPPofs3tviz7saXUZjWlA9t8QM2zzNvb4=
X-Received: by 2002:a6b:c3c4:: with SMTP id t187-v6mr22224821iof.304.1534346238520;
 Wed, 15 Aug 2018 08:17:18 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Aug 2018 17:17:06 +0200
Message-ID: <CACRpkdbTAeD4Sf_Kjw7A7=ctpOq1-p7qyt8QwyaSmiFeqW3=LQ@mail.gmail.com>
Subject: [GIT PULL] GPIO bulk changes for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the bulk of GPIO changes for the v4.19 kernel cycle.

I don't know if anything in particular stands out. Maybe the Aspeed
coprocessor thing from Benji: Aspeed is doing baseboard management
chips (BMC's) for servers etc. These Aspeed's are ARM processors
that exist inside (I guess) Intel servers, and they are moving forward to
using mainline Linux in those. This is one of the pieces of the puzzle
to achive that. They are doing OpenBMC, it's pretty cool.
https://lwn.net/Articles/683320/

The other details are in the signed tag.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.19-1

for you to fetch changes up to a5ec96ddfd55c501d451cb310566a1170c267ecb:

  gpio: it87: Add support for IT8613 (2018-08-10 23:19:17 +0200)

----------------------------------------------------------------
This is the bulk of GPIO changes for the v4.19 kernel cycle:

Core changes:

- Add a new API for explicitly naming GPIO consumers, when needed.

- Don't let userspace set values on input lines. While we do not
  think anyone would do this crazy thing we better plug the hole
  before someone uses it and think it's a nifty feature.

- Avoid calling chip->request() for unused GPIOs.

New drivers/subdrivers:

- The Mediatek MT7621 is supported which is a big win for OpenWRT
  and similar router distributions using this chip, as it seems
  every major router manufacturer on the planet has made products
  using this chip:
  https://wikidevi.com/wiki/MediaTek_MT7621

- The Tegra 194 is now supported.

- The IT87 driver now supports IT8786E and IT8718F super-IO
  chips.

- Add support for Rockchip RK3328 in the syscon GPIO driver.

Driver changes:

- Handle the get/set_multiple() properly on MMIO chips with
  inverted direction registers. We didn't have this problem
  until a new chip appear that has get/set registers AND
  inverted direction bits, OK now we handle it.

- A patch series making more error codes percolate upward
  properly for different errors on gpiochip_lock_as_irq().

- Get/set multiple for the OMAP driver, accelerating these
  multiple line operations if possible.

- A coprocessor interface for the Aspeed driver. Sometimes a few
  GPIO lines need to be grabbed by a co-processor for doing
  automated tasks, sometimes they are available as GPIO lines.
  By adding an explicit API in this driver we make it possible
  for the two line consumers to coexist. (This work was
  made available on the ib-aspeed branch, which may be appearing
  in other pull requests.)

- Implemented .get_direction() and open drain in the SCH311x
  driver.

- Continuing cleanup of included headers in GPIO drivers.

----------------------------------------------------------------
Andy Shevchenko (13):
      gpiolib: Join string literals back
      gpiolib: Respect error code of ->get_direction()
      gpiolib: Mark gpio_suffixes array with __maybe_unused
      gpiolib: Consistent use of ->get_direction() inside gpiolib
      gpiolib: Join one line back for better readability
      gpiolib: Use GPIOD_OUT_{LOW,HIGH} macros in open drain ones
      gpiolib: Don't shadow error code of gpiochip_lock_as_irq()
      gpio: bcm-kona: Don't shadow error code of gpiochip_lock_as_irq()
      gpio: dwapb: Don't shadow error code of gpiochip_lock_as_irq()
      gpio: em: Don't shadow error code of gpiochip_lock_as_irq()
      gpio: xgene-sb: Don't shadow error code of gpiochip_lock_as_irq()
      gpio: uniphier: Bail out on gpiochip_lock_as_irq() error
      gpio: vr41xx: Bail out on gpiochip_lock_as_irq() error

Anson Huang (2):
      gpio: mxc: Add clocks optional binding for imx gpio
      gpio: mxc: add power management support

Anton Vasilyev (1):
      gpio: ml-ioh: Fix buffer underwrite on probe error path

Arnd Bergmann (2):
      gpio: aspeed: fix compile testing warning
      gpio: mt7621: add OF_GPIO dependency

Bartosz Golaszewski (2):
      gpiolib: don't allow userspace to set values of input lines
      gpiolib: remove an unnecessary TODO

Baruch Siach (1):
      gpio: pca953x: suppress interrupts warning when not applicable

Benjamin Herrenschmidt (4):
      gpio: aspeed: Rework register type accessors
      gpio: aspeed: Add "Read Data" register to read the write latch
      gpio: aspeed: Add command source registers
      gpio: aspeed: Add interfaces for co-processor to grab GPIOs

Biju Das (2):
      gpiolib: Fix of_node inconsistency
      gpiolib: Avoid calling chip->request() for unused gpios

Daniel Mack (1):
      gpio: pxa: disable pinctrl calls for PXA3xx

Dmitry Osipenko (1):
      gpio: tegra: Fix tegra_gpio_irq_set_type()

Fabio Estevam (1):
      gpio: mxs: Fit writel() into a single line

Geert Uytterhoeven (2):
      w1: Allow compile test of GPIO consumers if !GPIOLIB
      gpio: rcar: Implement .get_direction() callback

Ivan Podovalov (1):
      gpio: it87: add support for IT8718F Super I/O.

Janusz Krzysztofik (2):
      gpiolib: Defer on non-DT find_chip_by_name() failure
      gpio: omap: Add get/set_multiple() callbacks

Keerthy (2):
      gpio: davinci: Shuffle IRQ resource fetching from DT to beginning of probe
      gpio: davinci: Do not assume continuous IRQ numbering

Leonid Bloch (1):
      gpio: it87: Add support for IT8613

Levin Du (1):
      gpio: syscon: rockchip: add GRF GPIO support for rk3328

Linus Walleij (26):
      gpio: Add API to explicitly name a consumer
      gpio: rc5t583: Include the right header
      gpio: rcar: Include the right header
      gpio: rdc321x: Include the right header
      gpio: sa1100: Include the right header
      gpio: sch: Include the right header
      gpio: sch: Implement .get_direction()
      gpio: sch311x: Include the right header
      gpio: sch311x: Implement .get_direction()
      gpio: sch311x: Use RMW to change direction
      gpio: sch311x: Implement open drain support
      gpio: sch311x: Replace unsigned char with u8
      gpio: spear-spics: Include the right header
      gpio: sta2x11: Include the right header
      gpio: sta2x11: Use BIT() macro
      gpio: sta2x11: Inline regs macro
      gpio: stmpe: Include the right header
      gpio: stp-xway: Include the right header
      gpio: syscon: Include the right header
      Merge branch 'ib-aspeed' into devel
      gpio: mt7621: Edit to preferred syntax
      gpio: tb10x: Use the right include
      gpio: timberdale: Include the right header
      gpio: xilinx: Use the right include
      gpio: mmio: Fix up inverted direction registers
      gpio: tegra: Include the right header

Marcel Ziswiler (1):
      gpiolib: probe deferral error reporting

Mathias Kresin (1):
      gpio: stp-xway: Implement get callback

Mikko Perttunen (2):
      dt-bindings: tegra186-gpio: Add information for Tegra194
      gpio: tegra186: Add support for Tegra194

Morten Hein Tiljeset (1):
      gpio-pisosr: add support for get_multiple

Nadav Amit (1):
      gpio: Fix wrong rounding in gpio-menz127

Rafael David Tinoco (1):
      gpio: selftests: gpio-mockup-chardev GPIOHANDLE_REQUEST_OUTPUT fix

Sergei Shtylyov (1):
      gpio-rcar: document R8A77980 bindings

Sergio Paracuellos (2):
      gpio: mt7621: Add DT bindings
      gpio: mt7621: Add a driver for MT7621

Stefan Agner (1):
      gpio: tegra: drop tegra specific GPIO lockdep classes

Vincent Prince (1):
      gpio-it87: add support for IT8786E Super I/O

Wei Yongjun (2):
      gpio: pxa: Fix potential NULL dereference
      gpio: pxa: remove set but not used variable 'gpio_offset'

Zhouyang Jia (1):
      gpio: max732x: add error handling for i2c_new_dummy

zhong jiang (1):
      gpio: fix meaningless return expression

 .../devicetree/bindings/gpio/fsl-imx-gpio.txt      |   3 +
 .../bindings/gpio/mediatek,mt7621-gpio.txt         |  35 ++
 .../bindings/gpio/nvidia,tegra186-gpio.txt         |   4 +
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |   1 +
 .../bindings/gpio/rockchip,rk3328-grf-gpio.txt     |  32 ++
 drivers/gpio/Kconfig                               |  12 +-
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-aspeed.c                         | 426 ++++++++++++++++++---
 drivers/gpio/gpio-ath79.c                          |   2 +-
 drivers/gpio/gpio-bcm-kona.c                       |   6 +-
 drivers/gpio/gpio-davinci.c                        |  70 ++--
 drivers/gpio/gpio-dwapb.c                          |   6 +-
 drivers/gpio/gpio-em.c                             |   6 +-
 drivers/gpio/gpio-it87.c                           |  13 +
 drivers/gpio/gpio-max732x.c                        |  12 +
 drivers/gpio/gpio-menz127.c                        |   4 +-
 drivers/gpio/gpio-ml-ioh.c                         |   3 +-
 drivers/gpio/gpio-mmio.c                           | 108 +++---
 drivers/gpio/gpio-mt7621.c                         | 332 ++++++++++++++++
 drivers/gpio/gpio-mxc.c                            |  73 ++++
 drivers/gpio/gpio-mxs.c                            |   3 +-
 drivers/gpio/gpio-omap.c                           |  88 ++++-
 drivers/gpio/gpio-pca953x.c                        |   2 +-
 drivers/gpio/gpio-pisosr.c                         |  22 ++
 drivers/gpio/gpio-pxa.c                            |  42 +-
 drivers/gpio/gpio-rc5t583.c                        |   2 +-
 drivers/gpio/gpio-rcar.c                           |  10 +-
 drivers/gpio/gpio-rdc321x.c                        |   2 +-
 drivers/gpio/gpio-sa1100.c                         |   2 +-
 drivers/gpio/gpio-sch.c                            |  11 +-
 drivers/gpio/gpio-sch311x.c                        |  70 +++-
 drivers/gpio/gpio-spear-spics.c                    |   2 +-
 drivers/gpio/gpio-sta2x11.c                        |  41 +-
 drivers/gpio/gpio-stmpe.c                          |   2 +-
 drivers/gpio/gpio-stp-xway.c                       |  18 +-
 drivers/gpio/gpio-syscon.c                         |  33 +-
 drivers/gpio/gpio-tb10x.c                          |   3 +-
 drivers/gpio/gpio-tegra.c                          |  28 +-
 drivers/gpio/gpio-tegra186.c                       |  74 ++++
 drivers/gpio/gpio-timberdale.c                     |   2 +-
 drivers/gpio/gpio-uniphier.c                       |   3 +-
 drivers/gpio/gpio-vr41xx.c                         |   8 +-
 drivers/gpio/gpio-xgene-sb.c                       |   6 +-
 drivers/gpio/gpio-xilinx.c                         |   2 +-
 drivers/gpio/gpiolib-of.c                          |   3 -
 drivers/gpio/gpiolib.c                             |  82 ++--
 drivers/gpio/gpiolib.h                             |   2 +-
 drivers/w1/masters/Kconfig                         |   2 +-
 include/linux/gpio/aspeed.h                        |  15 +
 include/linux/gpio/consumer.h                      |  14 +-
 include/linux/gpio/driver.h                        |   3 +
 include/linux/platform_data/gpio-davinci.h         |   3 +-
 tools/testing/selftests/gpio/gpio-mockup-chardev.c |   6 +-
 53 files changed, 1481 insertions(+), 274 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/gpio/mediatek,mt7621-gpio.txt
 create mode 100644
Documentation/devicetree/bindings/gpio/rockchip,rk3328-grf-gpio.txt
 create mode 100644 drivers/gpio/gpio-mt7621.c
 create mode 100644 include/linux/gpio/aspeed.h
