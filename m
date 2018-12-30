Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B0AC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 15:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7B820828
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 15:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iSEyUtWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeL3PJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 10:09:04 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38048 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeL3PJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 10:09:04 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so17164282lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 07:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=oRimxVBFH5qKTt5tXi96R3sEtJOH0NBXfxLXVVwiwZM=;
        b=iSEyUtWrRa4TxZBsjQRdChh2TldN4z13UQ774UXohKlIVQHsW0KOe4WVVF5NnCB6E4
         fzqoVDkvbTRSlneV801q4Nll2yi7+BNaGWBoA7LtvzFCiaMT3cCuHw56WV3Wi6jKg12/
         NUnBW5/VaTLeM2jKmJZLIImSCk3nQyYrurDRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=oRimxVBFH5qKTt5tXi96R3sEtJOH0NBXfxLXVVwiwZM=;
        b=Fz8rPFLa9LXzggcxWmIKwMs6saOZ4dyI6/WpzbnC7p/cWwx4CWs79OUUoUn85XhqD9
         rYfqqLVKT9EWxHPAZblHBdaJyPM11gQ+sBhETwjDyLfeY6/JjHXQoE2H9fbPe6tmrL6y
         k2bQZFGYZOQQdst2DFd7oWS1m9vqAEV5LwtJEzz64gKq4S0Vy2wiPGey4cvj5XkGiU5u
         RAKlsp52GX7EcRUM6aQk9wRp+qe95VEKQscBm64wsuIlN6ZuLXjsrUsL4obQSur7zAG1
         9pQ3tt9p1BzoTbBEfJIwcfmvRfwoAnF2Zaybi9PZcGu+bun2ifOx4GWy5lMvSJNwC7aY
         YCyQ==
X-Gm-Message-State: AA+aEWaExnQjGivdM9PA6W3RBTmQEFAlKXcGaoQ1EsxS4nhbYUVkecVs
        MXy1kn8XVdykhB83LspfBGSsofuzcp9WwwtDoRuLSg==
X-Google-Smtp-Source: AFSGD/XsHpsYz2JN3ewVaSdGEZBipPdpVwCI4gvjKBkOVUeWxE4e7Gl8DYbIm1j/TUkgxACdBdmlYXI3J6oIKqVtATM=
X-Received: by 2002:a19:8d01:: with SMTP id p1mr16092819lfd.149.1546182540183;
 Sun, 30 Dec 2018 07:09:00 -0800 (PST)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Dec 2018 16:08:48 +0100
Message-ID: <CACRpkdYfxQqxtCkDQ86ocZC5fL9b4zO0a7SyEau7UD26PE07AQ@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for the v4.21 kernel
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the big pull request for pin control changes this merge
window.

It took some days to stabilize some last minute Kconfig changes
and I wanted some build coverage before sending the pull request.

We have no core changes but lots of incremental development
in drivers all over the place: Renesas, NXP, Mediatek and Actions
Semiconductor keep churning out new SoCs.

I have some subtree maintainers for Renesas and Intel helping
out to keep down the load, it's been working smoothly (Samsung
also have a subtree but it was not used this cycle.)

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a=
:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.21-1

for you to fetch changes up to 88cc9fc41c7318565bcf28a843b1e4e3f2acf894:

  dt-bindings: arm: fsl-scu: add imx8qm pinctrl support (2018-12-27
10:42:11 +0100)

----------------------------------------------------------------
Pin control bulk changes for the v4.21 kernel cycle:

No core changes this time.

New drivers:

- NXP (ex Freescale) i.MX 8 QXP SoC driver.

- Mediatek MT6797 SoC driver.

- Mediatek MT7629 SoC driver.

- Actions Semiconductor S700 SoC driver.

- Renesas RZ/A2 SoC driver.

- Allwinner sunxi suniv F1C100 SoC driver.

- Qualcomm PMS405 PMIC driver.

- Microsemi Ocelot Jaguar2 SoC driver.

Improvements:

- Some RT improvements (using raw spinlocks where appropriate).

- A lot of new pin sets on the Renesas PFC pin controllers.

- GPIO hogs now work on the Qualcomm SPMI/SSBI pin controller GPIO
  chips, and Xway.

- Major modernization of the Intel pin control drivers.

- STM32 pin control driver will now synchronize usage of pins
  with another CPU using a hardware spinlock.

----------------------------------------------------------------
A.s. Dong (5):
      pinctrl: fsl: add scu based pinctrl support
      pinctrl: imx: add imx8qxp driver
      dt-bindings: pinctrl: imx7ulp: back to imx legacy binding for consist=
ency
      pinctrl: fsl: imx7ulp: change to use imx legacy binding
      pinctrl: imx: fix NO_PAD_CTL setting for MMIO pads

Abel Vesa (1):
      pinctrl: freescale: Break dependency on SOC_IMX8MQ for i.MX8MQ

Aisheng Dong (2):
      pinctrl: imx8qxp: break the dependency on SOC_IMX8QXP
      dt-bindings: arm: fsl-scu: add imx8qm pinctrl support

Alexandre Belloni (1):
      pinctrl: ocelot: add MSCC Jaguar2 support

Andy Shevchenko (18):
      MAINTAINERS: Add tree link for Intel pin control driver
      pinctrl: cedarfork: Get rid of unneeded ->probe() stub
      pinctrl: denverton: Get rid of unneeded ->probe() stub
      pinctrl: lewisburg: Get rid of unneeded ->probe() stub
      pinctrl: broxton: Get rid of unneeded ->probe() stub
      pinctrl: cannonlake: Get rid of unneeded ->probe() stub
      pinctrl: icelake: Get rid of unneeded ->probe() stub
      pinctrl: sunrisepoint: Get rid of unneeded ->probe() stub
      pinctrl: intel: Unexport intel_pinctrl_probe()
      pinctrl: merrifield: include bits.h instead of bitops.h
      pinctrl: cedarfork: Replace acpi.h with mod_devicetable.h
      pinctrl: denverton: Replace acpi.h with mod_devicetable.h
      pinctrl: lewisburg: Replace acpi.h with mod_devicetable.h
      pinctrl: broxton: Code formatting fixes
      pinctrl: geminilake: Code formatting fixes
      pinctrl: cannonlake: Code formatting fixes
      pinctrl: icelake: Code formatting fixes
      pinctrl: baytrail: Code formatting fixes

Arnd Bergmann (1):
      pinctrl: msm: mark PM functions as __maybe_unused

Benjamin Gaignard (2):
      dt-bindings: pinctrl: stm32: Document hwlocks properties
      pinctrl: stm32: protect configuration registers with a hwspinlock

Brian Masney (2):
      pinctrl: qcom: spmi-gpio: fix gpio-hog related boot issues
      pinctrl: qcom: ssbi-gpio: fix gpio-hog related boot issues

Chen-Yu Tsai (2):
      pinctrl: sunxi: a64: Rename function csi0 to csi
      pinctrl: sunxi: a64: Rename function ts0 to ts

Chris Brandt (2):
      dt-bindings: pinctrl: Add RZ/A2 pinctrl and GPIO
      pinctrl: Add RZ/A2 pin and gpio controller

Colin Ian King (1):
      pinctrl: mediatek: clean up indentation issues, add missing tab

Dmitry Shifrin (2):
      pinctrl: sh-pfc: r8a77970: Add QSPI pins, groups, and functions
      pinctrl: sh-pfc: r8a77980: Add QSPI pins, groups, and functions

Evan Green (1):
      pinctrl: msm: Add sleep pinctrl state transitions

Fabrizio Castro (5):
      pinctrl: sh-pfc: r8a77470: Add remaining I2C pin groups
      pinctrl: sh-pfc: r8a77470: Add DU1 pin groups
      pinctrl: sh-pfc: r8a77470: Add VIN pin groups
      pinctrl: sh-pfc: r8a77470: Add QSPI1 pin groups
      pinctrl: sh-pfc: r8a77470: Add SDHI support

Geert Uytterhoeven (23):
      MAINTAINERS: Add Renesas RZ/A and RZ/N files to Renesas pinctrl secti=
on
      pinctrl: sh-pfc: Reduce kernel size for narrow VIN channels
      pinctrl: sh-pfc: r8a77995: Remove unused PINMUX_IPSR_{MSEL2,PHYS}()
      pinctrl: sh-pfc: r8a77990: Add support for pull-up only pins
      pinctrl: sh-pfc: r8a77990: Fix IOCTRL reg state after s2ram on R-Car =
E3
      pinctrl: sh-pfc: r8a7740: Add missing REF125CK pin to gether_gmii gro=
up
      pinctrl: sh-pfc: r8a7740: Add missing LCD0 marks to lcd0_data24_1 gro=
up
      pinctrl: sh-pfc: r8a7791: Remove bogus ctrl marks from qspi_data4_b g=
roup
      pinctrl: sh-pfc: r8a7791: Remove bogus marks from vin1_b_data18 group
      pinctrl: sh-pfc: sh73a0: Add missing TO pin to tpu4_to3 group
      pinctrl: sh-pfc: Validate pins/marks in pin groups at build time
      pinctrl: sh-pfc: r8a7794: Remove bogus IPSR9 field
      pinctrl: sh-pfc: r8a77970: Add missing MOD_SEL0 field
      pinctrl: sh-pfc: r8a77980: Add missing MOD_SEL0 field
      pinctrl: sh-pfc: sh7734: Add missing IPSR11 field
      pinctrl: sh-pfc: r8a77990: Fix MOD_SEL0 SEL_I2C1 field width
      pinctrl: sh-pfc: r8a77995: Remove bogus SEL_PWM[0-3]_3 configurations
      pinctrl: sh-pfc: sh7264: Fix PFCR3 and PFCR0 register configuration
      pinctrl: sh-pfc: sh7269: Add missing PCIOR0 field
      pinctrl: sh-pfc: sh7734: Remove bogus IPSR10 value
      pinctrl: sh-pfc: sh7734: Fix shifted values in IPSR10
      pinctrl: sh-pfc: Print actual field width for variable-width fields
      pinctrl: sh-pfc: Make pinmux_cfg_reg.var_field_width[] variable-lengt=
h

Guido G=C3=BCnther (1):
      pinctrl: imx-scu: Depend on IMX_SCU

Hans de Goede (2):
      pinctrl: cherryview: Add chv_gpio_clear_triggering() helper function
      pinctrl: cherryview: Stop clearing the GPIO_EN bit from
chv_gpio_disable_free

Heiko Stuebner (2):
      pinctrl: rockchip: allow specifying the regmap location for pin-route=
s
      pinctrl: rockchip: add rk3188 routes to switch between nand and emmc

Jacopo Mondi (6):
      pinctrl: sh-pfc: Add optional arg to VIN_DATA_PIN_GROUP
      pinctrl: sh-pfc: r8a7792: Fix VIN versioned groups
      pinctrl: sh-pfc: r8a7795: Fix VIN versioned groups
      pinctrl: sh-pfc: r8a7796: Fix VIN versioned groups
      pinctrl: sh-pfc: r8a77965: Add VIN[4|5] groups/functions
      pinctrl: sh-pfc: r8a77990: Add VIN[4|5] groups/functions

Laurent Pinchart (1):
      MAINTAINERS: Remove Laurent Pinchart as Renesas pinctrl maintainer

Linus Walleij (5):
      Merge tag 'sh-pfc-for-v4.21-tag1' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      Merge tag 'sh-pfc-for-v4.21-tag2' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      Merge tag 'intel-pinctrl-v4.21-1' of
git://git.kernel.org/.../pinctrl/intel into devel
      Merge tag 'sh-pfc-for-v4.21-tag3' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      pinctrl: ocelot: Add dependency on HAS_IOMEM

Ludovic Desroches (1):
      MAINTAINERS: merge at91 pinctrl entries

Lukas Wunner (1):
      pinctrl: bcm2835: Use raw spinlock for RT compatibility

Manivannan Sadhasivam (2):
      dt-bindings: pinctrl: Add devicetree bindings for MT6797 SoC Pinctrl
      pinctrl: mediatek: Add initial pinctrl driver for MT6797 SoC

Martin Blumenstingl (6):
      pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins
      pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins
      pinctrl: meson: meson8: rename the "gpio" function to "gpio_periphs"
      pinctrl: meson: meson8: rename the "gpio" function to "gpio_periphs"
      pinctrl: meson: meson8: add the missing GPIO_GROUPs for BOOT and CARD
      pinctrl: meson: meson8b: add the missing GPIO_GROUPs for BOOT and CAR=
D

Martin Schiller (1):
      pinctrl: xway: fix gpio-hog related boot issues

Masahiro Yamada (2):
      pinctrl: uniphier: convert to SPDX License Identifier
      pinctrl: uniphier: constify uniphier_pinctrl_socdata

Maxime Ripard (2):
      pinctrl: sunxi: Deal with per-bank regulators
      dt-bindings: pinctrl: sunxi: Add supply properties

Mesih Kilinc (2):
      dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
      pinctrl: sunxi: add support for suniv F1C100s (newer F-series SoCs)

Nathan Chancellor (6):
      pinctrl: max77620: Use define directive for max77620_pinconf_param va=
lues
      pinctrl: sprd: Use define directive for sprd_pinconf_params values
      pinctrl: bcm2835: Use define directive for BCM2835_PINCONF_PARAM_PULL
      pinctrl: lpc18xx: Use define directive for PIN_CONFIG_GPIO_PIN_INT
      pinctrl: zynq: Use define directive for PIN_CONFIG_IO_STANDARD
      pinctrl: aspeed: Wrap -Woverride-init with cc-option

Neil Armstrong (1):
      pinctrl: meson-gxl: remove invalid GPIOX tsin_a pins

Nicholas Mc Guire (3):
      pinctrl: nuvoton: check for devm_kasprintf() failure
      pinctrl: sx150x: handle failure case of devm_kstrdup
      pinctrl: rza1: Handle devm_kasprintf() failure cases

Olof Johansson (1):
      pinctrl: mediatek: Fix dependencies for EINT_MTK

Phil Edworthy (2):
      pinctrl: rzn1: Fix check for used MDIO bus
      pinctrl: rzn1: Fix of_get_child_count() error check

Rafa=C5=82 Mi=C5=82ecki (2):
      dt-bindings: pinctrl: bcm4708-pinmux: rework binding to use syscon
      pinctrl: bcm: ns: support updated DT binding as syscon subnode

Rob Herring (2):
      pinctrl: mediatek: Convert to using %pOFn instead of device_node.name
      pinctrl: Use of_node_name_eq for node name comparisons

Ryder Lee (3):
      pinctrl: mediatek: add pinctrl support for MT7629 SoC
      dt-bindings: pinctrl: update bindings for MT7629 SoC
      pinctrl: mediatek: improve Kconfig dependencies

Saravanan Sekar (4):
      pinctrl: actions: define constructor generic to Actions Semi SoC's
      pinctrl: actions: define pad control configurtion to SoC specific
      dt-bindings: pinctrl: Add bindings for Actions Semi S700 SoC
      pinctrl: actions: Add Actions Semi S700 pinctrl driver

Shawn Guo (2):
      dt-bindings: pinctrl: fix qcom-pmic-gpio for pms405
      pinctrl: qcom: spmi-gpio: add compatible for pms405 GPIO

Stefan Wahren (1):
      pinctrl: bcm2835: Switch to SPDX identifier

Takeshi Kihara (12):
      pinctrl: sh-pfc: r8a77990: Add Audio clock pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add Audio SSI pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add SDHI pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add voltage switch operations for SDHI
      pinctrl: sh-pfc: r8a77990: Add HSCIF pins, groups, and functions
      pinctrl: sh-pfc: r8a7795: Add I2C{0,3,5} pins, groups and functions
      pinctrl: sh-pfc: r8a7795-es1: Add I2C{0,3,5} pins, groups and functio=
ns
      pinctrl: sh-pfc: r8a7796: Add I2C{0,3,5} pins, groups and functions
      pinctrl: sh-pfc: r8a77965: Add CAN pins, groups and functions
      pinctrl: sh-pfc: r8a77965: Add CAN FD pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add CAN pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add CAN FD pins, groups and functions

Tomer Maimon (1):
      pinctrl: nuvoton: modify NPCM7xx pin configuration function

Ulrich Hecht (1):
      pinctrl: sh-pfc: Add physical pin multiplexing helper macros

Wolfram Sang (5):
      pinctrl: pinctrl-amd: simplify getting .driver_data
      pinctrl: pinctrl-at91-pio4: simplify getting .driver_data
      pinctrl: baytrail: simplify getting .driver_data
      pinctrl: cherryview: simplify getting .driver_data
      pinctrl: intel: simplify getting .driver_data

Yangtao Li (1):
      pinctrl: Change to use DEFINE_SHOW_ATTRIBUTE macro

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |    5 +-
 .../bindings/pinctrl/actions,s700-pinctrl.txt      |  170 ++
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   14 +
 .../bindings/pinctrl/brcm,bcm4708-pinmux.txt       |   16 +-
 .../bindings/pinctrl/fsl,imx7ulp-pinctrl.txt       |   66 +-
 .../bindings/pinctrl/mscc,ocelot-pinctrl.txt       |    3 +-
 .../devicetree/bindings/pinctrl/pinctrl-mt6797.txt |   83 +
 .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt |  131 ++
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.txt |    2 +-
 .../bindings/pinctrl/renesas,rza2-pinctrl.txt      |   87 +
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |    1 +
 MAINTAINERS                                        |   13 +-
 drivers/pinctrl/Kconfig                            |   17 +-
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/actions/Kconfig                    |    6 +
 drivers/pinctrl/actions/Makefile                   |    1 +
 drivers/pinctrl/actions/pinctrl-owl.c              |   71 +-
 drivers/pinctrl/actions/pinctrl-owl.h              |  142 +-
 drivers/pinctrl/actions/pinctrl-s700.c             | 1912 +++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c             |  205 +-
 drivers/pinctrl/aspeed/Makefile                    |    2 +-
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |   33 +-
 drivers/pinctrl/bcm/pinctrl-ns.c                   |   29 +-
 drivers/pinctrl/freescale/Kconfig                  |   14 +-
 drivers/pinctrl/freescale/Makefile                 |    2 +
 drivers/pinctrl/freescale/pinctrl-imx.c            |  434 ++--
 drivers/pinctrl/freescale/pinctrl-imx.h            |   67 +-
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c        |   42 -
 drivers/pinctrl/freescale/pinctrl-imx8qxp.c        |  232 ++
 drivers/pinctrl/freescale/pinctrl-scu.c            |  121 +
 drivers/pinctrl/intel/pinctrl-baytrail.c           |    8 +-
 drivers/pinctrl/intel/pinctrl-broxton.c            |   13 +-
 drivers/pinctrl/intel/pinctrl-cannonlake.c         |    9 +-
 drivers/pinctrl/intel/pinctrl-cedarfork.c          |   11 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   32 +-
 drivers/pinctrl/intel/pinctrl-denverton.c          |   11 +-
 drivers/pinctrl/intel/pinctrl-geminilake.c         |    2 +-
 drivers/pinctrl/intel/pinctrl-icelake.c            |   11 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |   11 +-
 drivers/pinctrl/intel/pinctrl-intel.h              |    2 -
 drivers/pinctrl/intel/pinctrl-lewisburg.c          |   11 +-
 drivers/pinctrl/intel/pinctrl-merrifield.c         |    2 +-
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c       |    7 +-
 drivers/pinctrl/mediatek/Kconfig                   |   27 +-
 drivers/pinctrl/mediatek/Makefile                  |    2 +
 drivers/pinctrl/mediatek/pinctrl-moore.c           |    4 +-
 drivers/pinctrl/mediatek/pinctrl-mt6797.c          |   82 +
 drivers/pinctrl/mediatek/pinctrl-mt7629.c          |  450 ++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h      | 2429 ++++++++++++++++=
++++
 drivers/pinctrl/mediatek/pinctrl-paris.c           |    8 +-
 drivers/pinctrl/meson/pinctrl-meson-gxl.c          |   12 +-
 drivers/pinctrl/meson/pinctrl-meson8.c             |   33 +-
 drivers/pinctrl/meson/pinctrl-meson8b.c            |   45 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |   16 +-
 drivers/pinctrl/pinconf.c                          |   29 +-
 drivers/pinctrl/pinctrl-amd.c                      |    6 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |    6 +-
 drivers/pinctrl/pinctrl-lpc18xx.c                  |   10 +-
 drivers/pinctrl/pinctrl-max77620.c                 |   14 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |  338 ++-
 drivers/pinctrl/pinctrl-rockchip.c                 |   52 +-
 drivers/pinctrl/pinctrl-rza1.c                     |    5 +
 drivers/pinctrl/pinctrl-rza2.c                     |  519 +++++
 drivers/pinctrl/pinctrl-rzn1.c                     |    4 +-
 drivers/pinctrl/pinctrl-sx150x.c                   |   11 +-
 drivers/pinctrl/pinctrl-xway.c                     |   39 +-
 drivers/pinctrl/pinctrl-zynq.c                     |    9 +-
 drivers/pinctrl/pinmux.c                           |   29 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   19 +
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    2 +
 drivers/pinctrl/qcom/pinctrl-sdm845.c              |    1 +
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |   22 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |   23 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 +-
 drivers/pinctrl/sh-pfc/core.c                      |    2 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |    3 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c              |  678 +++++-
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |    6 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c               |   22 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c               |    6 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c           |   97 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               |  119 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |  122 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c              |  370 +++
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c              |   72 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c              |   72 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c              | 1948 ++++++++++++++--
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c              |   14 +-
 drivers/pinctrl/sh-pfc/pfc-sh7264.c                |    9 +-
 drivers/pinctrl/sh-pfc/pfc-sh7269.c                |    2 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c                |    1 +
 drivers/pinctrl/sh-pfc/pfc-sh7734.c                |   20 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   60 +-
 drivers/pinctrl/sprd/pinctrl-sprd.c                |    6 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |   71 +-
 drivers/pinctrl/sunxi/Kconfig                      |    4 +
 drivers/pinctrl/sunxi/Makefile                     |    1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c         |   52 +-
 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c      |  416 ++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   63 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.h              |    6 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c   |   22 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c    |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c   |   20 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier.h        |   13 +-
 include/dt-bindings/pinctrl/bcm2835.h              |    8 +-
 include/dt-bindings/pinctrl/mt6797-pinfunc.h       | 1368 +++++++++++
 include/dt-bindings/pinctrl/pads-imx8qm.h          |  960 ++++++++
 include/dt-bindings/pinctrl/pads-imx8qxp.h         |  751 ++++++
 include/dt-bindings/pinctrl/r7s9210-pinctrl.h      |   47 +
 117 files changed, 14486 insertions(+), 1405 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt679=
7.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/renesas,rza2-pinctrl.txt
 create mode 100644 drivers/pinctrl/actions/pinctrl-s700.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8qxp.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-scu.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6797.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7629.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
 create mode 100644 drivers/pinctrl/pinctrl-rza2.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-suniv-f1c100s.c
 create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h
 create mode 100644 include/dt-bindings/pinctrl/pads-imx8qm.h
 create mode 100644 include/dt-bindings/pinctrl/pads-imx8qxp.h
 create mode 100644 include/dt-bindings/pinctrl/r7s9210-pinctrl.h
