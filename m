Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08205C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023EB20663
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2SpJsXx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023EB20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeJVWvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 18:51:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41900 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbeJVWvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 18:51:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so37172458lja.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=EdPDyTguv1/EODl/+82K+FxHg2Yo2sitO/7U+L32KMQ=;
        b=A2SpJsXxq/dCvab+Xyl3FCn58YwhZMxH8wLqjZolB8JuubU6AZ7bUnc0Bli4UMqeKA
         YIOxL9RxQW3hHXa8AqEj19nxBOmeD9EXGRStWrwTJO+jDNPqyi4+4zPrbH0SceEJwGY9
         rl6IeXh6c0eskeme6hj7fUsu8MIKks9SlAdOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=EdPDyTguv1/EODl/+82K+FxHg2Yo2sitO/7U+L32KMQ=;
        b=PFModaRG+bONf/z4NmNL9Dm3OVw1ujv0HXuaM4AGllKi8oxUyDpkANMzMUXe7M83iB
         6/RfSIqn/UknMGzQhUPtuCLO/ROZKoPowg9z9dSp9RXSJXtXp/97Dfhh3xvHo+pB/KQO
         W2V021Fl6+Usdz03sJsPEQqnSpKpSTQFoEPSg7t/0zxt9lA0e3Kv+2zOo1CA9nOY1yxb
         XspvCD3ml7RexqvgoiBIrMW2FG14aa+9NMXxI4D4xsFuybIIZB+gO3Dl5it7eslDoO2p
         mDUVMCfEJ4DqyWMAKACuKwgJnJg/UPJfJDsIXgcBYQDdM4NzkHcNWG2/LPHV0MtLe4fY
         c4FQ==
X-Gm-Message-State: AGRZ1gJA/Wx9EmqCLl5r5+3Z/n9rfVjO7DGp1xDyVDniRe1iXzBDDNza
        NKGO7M5x6gGn/3mBz+ab2qb7ASbC4cmDcH6y1QEgyg==
X-Google-Smtp-Source: ACcGV62ksJTdh8jmrPjbJv4LDQktbpQ2+0id0wDPeY+BkVHi1Ka+TOYlF5E3YGpjYS7UTB6YUMZuk3QoT3W9d7iiqqI=
X-Received: by 2002:a2e:9e56:: with SMTP id g22-v6mr10453235ljk.120.1540218767918;
 Mon, 22 Oct 2018 07:32:47 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Oct 2018 16:32:36 +0200
Message-ID: <CACRpkdbXc_tihBUraLM3STP1bNMozhmfBcKdy+-ETiw9JT+4+g@mail.gmail.com>
Subject: [GIT PULL] GPIO bulk changes for v4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the bulk of GPIO changes for v4.20. Lots of changes
this time, all good stuff, the details are in the signed tag
as usual. They have all boiled in linux-next as is custom.

Some merge mechanics:

- The Ingenic driver was moved over to pin control as mentioned
  in my pin control pull request and these commits naturally
  appear here as well.

- Some single patches affecting arch/arm, drivers/mmc,
  drivers/bus and drivers/auxdisplay
  are here because of dependencies, and those have been ACKed
  by respective subsystem maintainer.

- One patch hits arch/x86/platform/ts5500/ts5500.c
  was augmented and I have requested comments from the
  maintainers. They seem to be unresponsive for close to 2
  months (patch sent august 29) so the patch is applied anyway.
  It's no big change anyway.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3=
:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/gpio-v4.20-1

for you to fetch changes up to 40f5ff4f9f23a849ad135cb736d4d448d810ac17:

  gpio: Clarify kerneldoc on gpiochip_set_chained_irqchip()
(2018-10-16 09:30:22 +0200)

----------------------------------------------------------------
This is the bulk of GPIO changes for the v4.20 series:

Core changes:

- A patch series from Hans Verkuil to make it possible to
  enable/disable IRQs on a GPIO line at runtime and drive GPIO
  lines as output without having to put/get them from scratch.
  The irqchip callbacks have been improved so that they can
  use only the fastpatch callbacks to enable/disable irqs
  like any normal irqchip, especially the gpiod_lock_as_irq()
  has been improved to be callable in fastpath context.
  A bunch of rework had to be done to achieve this but it is
  a big win since I never liked to restrict this to slowpath.
  The only call requireing slowpath was try_module_get() and
  this is kept at the .request_resources() slowpath callback.
  In the GPIO CEC driver this is a big win sine a single
  line is used for both outgoing and incoming traffic, and
  this needs to use IRQs for incoming traffic while actively
  driving the line for outgoing traffic.

- Janusz Krzysztofik improved the GPIO array API to pass a
  "cookie" (struct gpio_array) and a bitmap for setting or
  getting multiple GPIO lines at once. This improvement
  orginated in a specific need to speed up an OMAP1 driver and
  has led to a much better API and real performance gains
  when the state of the array can be used to bypass a lot
  of checks and code when we want things to go really fast.
  The previous code would minimize the number of calls
  down to the driver callbacks assuming the CPU speed was
  orders of magnitude faster than the I/O latency, but this
  assumption was wrong on several platforms: what we needed
  to do was to profile and improve the speed on the hot
  path of the array functions and this change is now
  completed.

- Clean out the painful and hard to grasp BNF experiments
  from the device tree bindings. Future approaches are looking
  into using JSON schema for this purpose. (Rob Herring
  is floating a patch series.)

New drivers:

- The RCAR driver now supports r8a774a1 (RZ/G2M).

- Synopsys GPIO via CREGs driver.

Major improvements:

- Modernization of the EP93xx driver to use irqdomain and
  other contemporary concepts.

- The ingenic driver has been merged into the Ingenic pin
  control driver and removed from the GPIO subsystem.

- Debounce support in the ftgpio010 driver.

----------------------------------------------------------------
Andrew F. Davis (5):
      gpio: davinci: Remove unused member of davinci_gpio_controller
      gpio: davinci: Use dev name for label and automatic base selection
      gpio: davinci: Allocate the correct amount of memory for controller
      gpio: davinci: Remove unneeded GPIO macro
      gpio: davinci: Move driver local definitions to driver

Andy Shevchenko (1):
      MAINTAINERS: Add myself as designated reviewer of Intel PMIC GPIO

Arnd Bergmann (1):
      ARM/gpio: ep93xx: build standalone

Bartosz Golaszewski (1):
      gpio: mockup: use device properties instead of platform_data

Biju Das (3):
      gpio: rcar: Add GPIO hole support
      dt-bindings: gpio: rcar: Add gpio-reserved-ranges support
      dt-bindings: gpio: rcar: Add r8a7744 (RZ/G1N) support

Christophe Blaess (1):
      Accept partial 'gpio-line-names' property.

Colin Ian King (1):
      gpio: ep93xx: fix incorrect array element size check

Dan Carpenter (1):
      gpio: ep93xx: fix test for end of loop

Eugeniy Paltsev (2):
      dt-bindings: Document the Synopsys GPIO via CREG bindings
      GPIO: add single-register GPIO via CREG driver

Fabrizio Castro (1):
      dt-bindings: gpio: rcar: Add r8a774a1 (RZ/G2M) support

Geert Uytterhoeven (4):
      gpio: uapi: Grammar s/array/array of/
      Documentation: gpio: Fix return type of gpiod_set_raw_array_value*()
      gpio: Propagate errors from gpiod_set_array_value_complex()
      gpio: Restore indentation of continued lines

Grygorii Strashko (2):
      gpio: omap: get rid of the conditional PM runtime calls
      gpio: omap: drop omap_gpio_list

Hans Verkuil (7):
      gpiolib: export gpiochip_irq_reqres/relres()
      gliolib: set hooks in gpiochip_set_irq_hooks()
      gpiolib: add flag to indicate if the irq is disabled
      gpiolib: override irq_enable/disable
      gpio/driver.rst: document gpiochip_disable/enable_irq()
      gpio-bcm-kona: use new req/relres and dis/enable_irq funcs
      gpiolib: check if irqchip already has the irq hook replacements

Janusz Krzysztofik (8):
      gpiolib: Pass bitmaps, not integer arrays, to get/set array
      gpiolib: Identify arrays matching GPIO hardware
      gpiolib: Pass array info to get/set array functions
      gpiolib: Implement fast processing path in get/set array
      gpiolib: Fix missing updates of bitmap index
      gpiolib: Fix array members of same chip processed separately
      gpiolib: Fix incorrect use of find_next_zero_bit()
      mmc: pwrseq_simple: Fix incorrect handling of GPIO bitmap

Justin Chen (1):
      gpio: brcmstb: allow 0 width GPIO banks

Linus Walleij (56):
      gpio: tb10x: Create local helper variables
      gpio: tb10x: Use GENERIC_GPIO
      gpio: ep93xx: Cut down variable names
      gpio: ep93xx: Switch to SPDX license tag
      gpio: ep93xx: Pass around struct gpio_chip
      gpio: ep93xx: Rename has_debounce to has_irq
      gpio: ep93xx: Properly call the chained IRQ handler
      gpio: ep93xx: Do not pingpong irq numbers
      gpio: ep93xx: Use the hwirq and port
      gpio: ep93xx: Use for_each_set_bit() in IRQ handler
      gpio: ep93xx: Cut gpio_to_irq() usage
      gpio: ep93xx: Switch A and B to use GPIOLIB_IRQCHIP
      pinctrl: ingenic: Include the right header
      Merge branch 'ib-ingenic' of ../linux-pinctrl into devel
      gpio: ftgpio: Support optional silicon clock
      gpio: ftgpio: Support debounce timer
      gpio: tpx65xxx: Include the right header
      gpio: tps65xxx: Use SPDX license tag
      gpio: mxs: Get rid of external API call
      gpio: ts5500: Include the right header
      gpio: ts5500: Use SPDX header
      gpio: ts5500: Delete platform data handling
      gpio: zevio: Include the right header
      gpio: twl4030: Include the right header
      gpio: twl4030: Cut down boilerplate
      gpio: twl4030: Implement .get_direction()
      gpio: twl6040: Include the right header
      gpio: twl6040: Cut down boilerplate
      gpio: twl6040: Use bitops
      gpio: twl6040: Implement .get_direction()
      gpio: of: Handle SPI chipselect legacy bindings
      gpio: vf610: Include the right header
      gpio: vf610: Cut down on boilerplate
      gpio: vr41xx: Include the right header
      gpio: vr41xx: Cut down on boilerplate
      gpio: vr41xx: Delete vr41xx_gpio_pullupdown() callback
      gpio: xtensa: Include the right header
      gpio: xtensa: Cut down on boilerplate
      gpio: viperboard: Include the right header
      gpio: viperboard: Cut down on boilerplate
      gpio: vx855: Include the right header
      gpio: vx855: Cut down on boilerplate
      gpio: xlp: Include the right header
      gpio: xlp: Cut down on boilerplate
      gpio: wm8xxx: Use the right header
      gpio: wm8xxx: Cut down on boilerplate
      gpio: Get rid of legacy header
      gpio: OF: Cut painful BNF experiments from bindings
      gpio: OF: Remove bad practice examples
      Merge branch 'ib-array-bitmaps' into devel
      gpio: htc-egpio: Unique label per chip
      Merge branch 'ib-omap' into devel
      gpio: Use SPDX header for core library
      gpio: Rename devres implementation file
      gpio: Add comments on single direction chips
      gpio: Slightly more helpful debugfs

Marek Vasut (1):
      gpio: syscon: Fix possible NULL ptr usage

Michael Hennerich (1):
      drivers: gpio: Update MODULE AUTHOR email address

Paul Cercueil (8):
      dt-bindings: pinctrl: Update pinctrl-ingenic for JZ4725B and GPIO mer=
ge
      pinctrl: ingenic: Probe driver at subsys_initcall
      pinctrl: ingenic: Mark probe function as __init
      pinctrl: ingenic: Merge GPIO functionality
      pinctrl: ingenic: Implement .get_direction for GPIO chips
      pinctrl: ingenic: Add support for the JZ4725B
      pinctrl: ingenic: Drop dependency on MACH_INGENIC
      gpio: ingenic: Remove driver

Randy Dunlap (3):
      gpio: fix kernel-doc notation warning for 'request_key'
      gpio: fix kernel-doc after devres.c file rename
      gpio: fix SNPS_CREG kconfig dependency warning

Ricardo Ribalda Delgado (5):
      gpiolib: Fix gpio_direction_* for single direction GPIOs
      gpiolib: Add init_valid_mask exported function
      pinctrl: msm: Use init_valid_mask exported function
      gpiolib: Show correct direction from the beginning
      gpiolib: Initialize gdev field before is used

Rob Herring (1):
      gpio: Convert to using %pOFn instead of device_node.name

Robert Jarzmik (1):
      gpio: pxa: handle corner case of unprobed device

Stephen Boyd (3):
      gpio: Drop parent irq assignment during cascade setup
      gpio: Remove unused 'irqchip' argument to gpiochip_set_cascaded_irqch=
ip()
      gpio: Clarify kerneldoc on gpiochip_set_chained_irqchip()

Tony Lindgren (3):
      gpio: omap: Add level wakeup handling for omap4 based SoCs
      gpio: omap: Remove custom PM calls and use cpu_pm instead
      gpio: omap: Get rid of pm_runtime_irq_safe()

Uwe Kleine-K=C3=B6nig (3):
      gpiolib: Don't support irq sharing for userspace
      gpio: new driver to work with a 8x12 siox
      gpio: fix doc string for devm_gpiochip_add_data() to not talk
about irq_chip

Wolfram Sang (2):
      gpio: of: make example syntactically correct
      gpiolib: use better errno if get_direction is not available

YueHaibing (2):
      gpio: htc-egpio: Remove set but not used variable 'bit'
      gpio: omap: Remove set but not used variable 'dev'

 Documentation/devicetree/bindings/gpio/gpio.txt    | 142 ++---
 .../devicetree/bindings/gpio/ingenic,gpio.txt      |  46 --
 .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |  65 ++-
 .../devicetree/bindings/gpio/snps,creg-gpio.txt    |  21 +
 .../bindings/pinctrl/ingenic,pinctrl.txt           |  39 +-
 Documentation/driver-api/gpio/board.rst            |  24 +
 Documentation/driver-api/gpio/consumer.rst         |  64 ++-
 Documentation/driver-api/gpio/driver.rst           |  23 +-
 Documentation/driver-api/gpio/index.rst            |   2 +-
 MAINTAINERS                                        |  13 +
 arch/arm/mach-davinci/board-neuros-osd2.c          |   8 +-
 arch/arm/mach-ep93xx/core.c                        |   9 +
 arch/arm/mach-omap2/pm24xx.c                       |   7 +-
 arch/arm/mach-omap2/pm34xx.c                       |  14 +-
 arch/mips/include/asm/vr41xx/giu.h                 |   8 -
 arch/x86/platform/ts5500/ts5500.c                  |   1 -
 drivers/auxdisplay/hd44780.c                       |  61 +-
 drivers/bus/ts-nbus.c                              |  20 +-
 drivers/gpio/Kconfig                               |  31 +-
 drivers/gpio/Makefile                              |   5 +-
 drivers/gpio/gpio-adp5520.c                        |   2 +-
 drivers/gpio/gpio-adp5588.c                        |   2 +-
 drivers/gpio/gpio-bcm-kona.c                       |  14 +-
 drivers/gpio/gpio-brcmstb.c                        |  15 +-
 drivers/gpio/gpio-creg-snps.c                      | 191 +++++++
 drivers/gpio/gpio-davinci.c                        |  60 +-
 drivers/gpio/gpio-ep93xx.c                         | 297 +++++-----
 drivers/gpio/gpio-ftgpio010.c                      | 115 +++-
 drivers/gpio/gpio-htc-egpio.c                      |  10 +-
 drivers/gpio/gpio-ingenic.c                        | 392 -------------
 drivers/gpio/gpio-max3191x.c                       |  16 +-
 drivers/gpio/gpio-mmio.c                           |   6 +-
 drivers/gpio/gpio-mockup.c                         |  82 +--
 drivers/gpio/gpio-mxs.c                            |   4 +-
 drivers/gpio/gpio-omap.c                           | 356 +++++++-----
 drivers/gpio/gpio-pxa.c                            |   6 +
 drivers/gpio/gpio-rcar.c                           |   6 +
 drivers/gpio/gpio-siox.c                           | 293 ++++++++++
 drivers/gpio/gpio-syscon.c                         |   2 +-
 drivers/gpio/gpio-tb10x.c                          | 123 ++--
 drivers/gpio/gpio-tps65086.c                       |  12 +-
 drivers/gpio/gpio-tps6586x.c                       |  15 +-
 drivers/gpio/gpio-tps65910.c                       |   9 +-
 drivers/gpio/gpio-tps65912.c                       |  16 +-
 drivers/gpio/gpio-ts5500.c                         |  13 +-
 drivers/gpio/gpio-twl4030.c                        |  59 +-
 drivers/gpio/gpio-twl6040.c                        |  31 +-
 drivers/gpio/gpio-vf610.c                          |  13 +-
 drivers/gpio/gpio-viperboard.c                     |  10 +-
 drivers/gpio/gpio-vr41xx.c                         |  55 +-
 drivers/gpio/gpio-vx855.c                          |  20 +-
 drivers/gpio/gpio-wm831x.c                         |   8 +-
 drivers/gpio/gpio-wm8350.c                         |   8 +-
 drivers/gpio/gpio-wm8994.c                         |   8 +-
 drivers/gpio/gpio-xlp.c                            |  12 +-
 drivers/gpio/gpio-xtensa.c                         |   7 +-
 drivers/gpio/gpio-zevio.c                          |   2 +-
 drivers/gpio/gpiolib-acpi.c                        |   6 +-
 drivers/gpio/gpiolib-devprop.c                     |  26 +-
 drivers/gpio/{devres.c =3D> gpiolib-devres.c}        |  12 +-
 drivers/gpio/gpiolib-legacy.c                      |   1 +
 drivers/gpio/gpiolib-of.c                          |  60 +-
 drivers/gpio/gpiolib-sysfs.c                       |  11 +-
 drivers/gpio/gpiolib.c                             | 619 +++++++++++++++--=
----
 drivers/gpio/gpiolib.h                             |  25 +-
 drivers/i2c/muxes/i2c-mux-gpio.c                   |  14 +-
 drivers/mmc/core/pwrseq_simple.c                   |  14 +-
 drivers/mux/gpio.c                                 |  12 +-
 drivers/net/phy/mdio-mux-gpio.c                    |  11 +-
 drivers/pcmcia/soc_common.c                        |   9 +-
 drivers/phy/motorola/phy-mapphone-mdm6600.c        |  19 +-
 drivers/pinctrl/Kconfig                            |   6 +-
 drivers/pinctrl/pinctrl-ingenic.c                  | 462 ++++++++++++++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  79 ++-
 drivers/staging/iio/adc/ad7606.c                   |   8 +-
 drivers/tty/serial/serial_mctrl_gpio.c             |   7 +-
 include/linux/gpio/consumer.h                      |  79 ++-
 include/linux/gpio/driver.h                        |  39 +-
 include/linux/platform_data/gpio-davinci.h         |  34 --
 include/linux/platform_data/gpio-omap.h            |  15 +-
 include/linux/platform_data/gpio-ts5500.h          |  27 -
 include/uapi/linux/gpio.h                          |   2 +-
 82 files changed, 2780 insertions(+), 1710 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
 create mode 100644 Documentation/devicetree/bindings/gpio/snps,creg-gpio.t=
xt
 create mode 100644 drivers/gpio/gpio-creg-snps.c
 delete mode 100644 drivers/gpio/gpio-ingenic.c
 create mode 100644 drivers/gpio/gpio-siox.c
 rename drivers/gpio/{devres.c =3D> gpiolib-devres.c} (96%)
 delete mode 100644 include/linux/platform_data/gpio-ts5500.h
