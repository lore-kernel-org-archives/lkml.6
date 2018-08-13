Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2571CC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B170C217B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFuDuuwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B170C217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbeHMRS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:18:26 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:39127 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbeHMRS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:18:26 -0400
Received: by mail-it0-f67.google.com with SMTP id g141-v6so14306868ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Aug 2018 07:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=TW0DvVuzAHAPaiPkwmPAf3FlgBf+xTifD0/21YoYR+8=;
        b=RFuDuuwWu4VNkR8Ml0kdqvu6QWHfD6I6ZDf6mmcZ6XrngGdWDkKjgbf242zS+IBgdn
         6ZoQ8eNv6CrOg9yo6zLQiaSFl79r9NeHfrphKYOEAe2La+0HPCOogXk9Mhhk3C+nOzlB
         YEj4FIPr2QDRKrG6sxbhNkKuTIodCguKqirBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=TW0DvVuzAHAPaiPkwmPAf3FlgBf+xTifD0/21YoYR+8=;
        b=VSWw656wA7mcFQ0B01mE/2TZXf4yRMpI6iZw4S9vczNm0c+5R+GihAIQ/2p0zslR7x
         rdGmZ7e+JuHZ4/lzfbAtn1t2X2DQlJObw6+6vcy+vYdwYaomsk4+5StaEhH28MFu2s9O
         GbniF1eBh/DSZImVS6HBApvFdh/HU6Zo7TIhi6V31YkOoc21OgrbrI18WHeY0sUPxLWt
         cf6d3RflOCq7otUIRSdTt3yoJSufZt/+vfe3GCEdMDLeKV2DJrC8YSL30xQzDsJB80vy
         ZqOaC3cefjovE6lk6IcJiQp2xfLE3hhDGxrPFfnYpymt9lPFHcu7VMA+altIZb7TxBF+
         lJlA==
X-Gm-Message-State: AOUpUlF71h8JMfI+xz6xLmDC5spu+uNwa3MO98yg0i+NnPS2VNEcoWcv
        +KBZibzB3Kx+mhKOmOMQiGrhYEzkBHqGDlh6xSmMfTkFKiU=
X-Google-Smtp-Source: AA+uWPzEwqeo3Ct5aNcJzsraegM3NneeYvyTN16N/l79ToMNulNZEEULMpPRWbpOpcb0zrdjkx+FKpQpgTIfXUwhQy8=
X-Received: by 2002:a02:5916:: with SMTP id p22-v6mr14797354jab.113.1534170952445;
 Mon, 13 Aug 2018 07:35:52 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Aug 2018 16:35:40 +0200
Message-ID: <CACRpkdYHqQyh6mgi6OjKurJcXg55Cz4-sGys3HJNUAaFh3DXAg@mail.gmail.com>
Subject: [GIT PULL] bulk pin control changes for v4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

this is the bulk of pin control changes for v4.19, nothing much
special to say about it, mainly linear development. The most exciting
might be the support for Intel's Ice Lake PCH from Andy.

The details are in the signed tag as usual.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40=
:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.19-1

for you to fetch changes up to c2944a9a09a21b917fa86858f078e77115ca9d22:

  pinctrl: nomadik: silence uninitialized variable warning (2018-08-10
23:14:04 +0200)

----------------------------------------------------------------
This is the bulk of pin control changes for v4.19:

Core changes:

- Augment pinctrl_generic_add_group() and pinmux_generic_add_function()
  to return the selector for the added group/function to the caller
  and augment (hopefully) all drivers to handle this.

New subdrivers:

- Qualcomm PM8998 and PM8005 are supported in the SPMI pin
  control and GPIO driver.

- Intel Ice Lake PCH (platform controller hub) support.

- NXP (ex Freescale) i.MX8MQ support.

- Berlin AS370 support.

Improvements to drivers:

- Support interrupts on the Ocelot pin controller.

- Add SPI pins to the Uniphier driver.

- Define a GPIO compatible per SoC in the Tegra driver.

- Push Tegra initialization down in the initlevels.

- Support external wakeup interrupts on the Exynos.

- Add generic clocks pins to the meson driver.

- Add USB and HSCIF pins for some Renesas PFC chips.

- Suspend/resume support in the armada-37xx.

- Interrupt support for the Actions Semiconductor S900 also
  known as "owl".

- Correct the pin ordering in Cedarfork.

- Debugfs output for INTF in the mcp23s08 driver

- Avoid divisions in context save/restore in pinctrl-single.

The rest is minor bug fixes or cleanups.

----------------------------------------------------------------
Abel Vesa (1):
      pinctrl: imx: Add DT binding for i.MX8MQ IOMUXC

Alexander Stein (1):
      pinctrl: baytrail: actually print the apparently misconfigured pin

Alexandre Belloni (1):
      pinctrl: ocelot: fix gpio4 twi function

Alexandre Torgue (2):
      pinctrl: stm32: fix bank io port number
      pinctrl: stm32: check node status before new gpio bank registering

Andy Shevchenko (6):
      pinctrl: intel: Add Ice Lake PCH pin controller support
      pinctrl: intel: Convert to use SPDX identifier
      pinctrl: intel: Do pin translation when lock IRQ
      pinctrl: cannonlake: Fix community ordering for H variant
      MAINTAINERS: Replace Heikki as maintainer of Intel pinctrl
      pinctrl: intel: Don't shadow error code of gpiochip_lock_as_irq()

Anton Vasilyev (1):
      pinctrl: axp209: Fix NULL pointer dereference after allocation

Arnd Bergmann (1):
      pinctrl: mediatek: include chained_irq.h header

Christian Lamparter (1):
      dt-bindings: pinctrl: qcom: add gpio-ranges, gpio-reserved-ranges

Colin Ian King (1):
      pinctrl: actions: fix unsigned less than zero comparison

Dan Carpenter (3):
      pinctrl: imx: off by one in imx_pinconf_group_dbg_show()
      pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()
      pinctrl: nomadik: silence uninitialized variable warning

Daniel Kurtz (2):
      pinctrl/amd: fix gpio irq level in debugfs
      pinctrl/amd: only handle irq if it is pending and unmasked

Dmitry Osipenko (2):
      pinctrl: tegra: Move drivers registration to arch_init level
      gpio: tegra: Move driver registration to subsys_init level

Douglas Anderson (3):
      pinctrl: Document pin_config_group_get() return codes like
pin_config_get()
      pinctrl: msm: Fix msm_config_group_get() to be compliant
      pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant

Geert Uytterhoeven (1):
      pinctrl: pinctrl-single: Avoid divisions in context save/restore

Gustavo A. R. Silva (2):
      pinctrl: mt7622: mark expected switch fall-through
      pinctrl: baytrail: Mark expected switch fall-throughs

Jan Kundr=C3=A1t (2):
      pinctrl: mcp23s08: Kconfig: update to reflect supported features
      pinctrl: mcp23s08: debugfs: Do not restore the INTF register

Jerome Brunet (1):
      pinctrl: meson: add gen_clk pins

Jisheng Zhang (2):
      dt-binding: pinctrl: berlin: document AS370 SoC pinctrl
      pinctrl: berlin: add the as370 SoC pinctrl driver

Joel Stanley (1):
      pinctrl: aspeed: Fix documentation

Krzysztof Kozlowski (8):
      pinctrl: samsung: Define suspend and resume callbacks for all
banks and SoCs
      pinctrl: samsung: Document suspend and resume members
      pinctrl: samsung: Document hidden requirement about one external wake=
up
      pinctrl: samsung: Add dedicated compatible for S5Pv210 wakeup interru=
pts
      ARM: exynos: Define EINT_WAKEUP_MASK registers for S5Pv210 and Exynos=
5433
      pinctrl: samsung: Write external wakeup interrupt mask
      dt-bindings: pinctrl: samsung: Add SPDX license identifier
      pinctrl: samsung: Remove duplicated "wakeup" in printk

Kunihiko Hayashi (1):
      pinctrl: uniphier: add spi pin-mux settings

Linus Walleij (3):
      pinctrl: Cut unused sysfs includes
      pinctrl: gemini: Mask properly
      Merge tag 'samsung-pinctrl-4.19' of
https://git.kernel.org/.../pinctrl/samsung into devel

Lucas Stach (1):
      pinctrl: imx: add driver for i.MX8MQ

Ludovic Barre (2):
      dt-bindings: pinctrl: add syscfg mask parameter
      pinctrl: stm32: add syscfg mask parameter

Ludovic Desroches (1):
      pinctrl: at91-pio4: add support for drive strength

Manivannan Sadhasivam (2):
      dt-bindings: pinctrl: Add gpio interrupt bindings for Actions S900 So=
C
      pinctrl: actions: Add interrupt support for OWL S900 SoC

Mika Westerberg (1):
      pinctrl: cedarfork: Correct EAST pin ordering

Miquel Raynal (1):
      pinctrl: armada-37xx: add suspend/resume support

Quentin Schulz (1):
      pinctrl: ocelot: add support for interrupt controller

Sean Wang (1):
      pinctrl: mt7622: Fix probe fail by misuse the selector

Stefan Agner (1):
      pinctrl: tegra: define GPIO compatible node per SoC

Stephen Boyd (1):
      pinctrl: qcom: spmi-gpio: Add pm8998 and pm8005 to binding

Takeshi Kihara (3):
      pinctrl: sh-pfc: r8a77965: Add HSCIF pins, groups, and functions
      pinctrl: sh-pfc: r8a77990: Add USB2.0 pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add USB3.0 pins, groups and functions

Tony Lindgren (5):
      pinctrl: core: Return selector to the pinctrl driver
      pinctrl: pinmux: Return selector to the pinctrl driver
      pinctrl: single: Fix group and function selector use
      pinctrl: rza1: Fix selector use for groups and functions
      pinctrl: core: Remove broken remove_last group and pinmux functions

Wei Yongjun (2):
      pinctrl: at91-pio4: Remove redundant return value check
      pinctrl: single: Fix missing unlock on error path

Yoshihiro Shimoda (1):
      pinctrl: sh-pfc: r8a77990: Revise USB ID pin name

YueHaibing (1):
      pinctrl: berlin: fix 'pctrl->functions' allocation in
berlin_pinctrl_build_state

 .../bindings/pinctrl/actions,s900-pinctrl.txt      |  10 +
 .../bindings/pinctrl/atmel,at91-pio4-pinctrl.txt   |   3 +
 .../devicetree/bindings/pinctrl/berlin,pinctrl.txt |   3 +-
 .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        |  36 ++
 .../bindings/pinctrl/qcom,apq8064-pinctrl.txt      |   6 +
 .../bindings/pinctrl/qcom,apq8084-pinctrl.txt      |   9 +
 .../bindings/pinctrl/qcom,ipq4019-pinctrl.txt      |   6 +
 .../bindings/pinctrl/qcom,ipq8064-pinctrl.txt      |   6 +
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.txt      |   9 +
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.txt      |   9 +
 .../bindings/pinctrl/qcom,msm8660-pinctrl.txt      |   6 +
 .../bindings/pinctrl/qcom,msm8916-pinctrl.txt      |   9 +
 .../bindings/pinctrl/qcom,msm8960-pinctrl.txt      |   9 +
 .../bindings/pinctrl/qcom,msm8974-pinctrl.txt      |   6 +
 .../bindings/pinctrl/qcom,msm8994-pinctrl.txt      |   9 +
 .../bindings/pinctrl/qcom,msm8996-pinctrl.txt      |   9 +
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.txt |   6 +-
 .../bindings/pinctrl/samsung-pinctrl.txt           |  11 +-
 .../bindings/pinctrl/st,stm32-pinctrl.txt          |   9 +-
 MAINTAINERS                                        |   2 +-
 arch/arm/mach-exynos/suspend.c                     |   2 +-
 drivers/gpio/gpio-tegra.c                          |   2 +-
 drivers/pinctrl/Kconfig                            |   9 +-
 drivers/pinctrl/actions/Kconfig                    |   1 +
 drivers/pinctrl/actions/pinctrl-owl.c              | 270 ++++++++++++-
 drivers/pinctrl/actions/pinctrl-owl.h              |  22 +-
 drivers/pinctrl/actions/pinctrl-s900.c             |  31 +-
 drivers/pinctrl/aspeed/pinctrl-aspeed.c            |   4 +-
 drivers/pinctrl/berlin/Kconfig                     |   5 +
 drivers/pinctrl/berlin/Makefile                    |   1 +
 drivers/pinctrl/berlin/berlin.c                    |  14 +-
 drivers/pinctrl/berlin/pinctrl-as370.c             | 368 +++++++++++++++++
 drivers/pinctrl/core.c                             |  36 +-
 drivers/pinctrl/core.h                             |   6 -
 drivers/pinctrl/freescale/Kconfig                  |   7 +
 drivers/pinctrl/freescale/Makefile                 |   1 +
 drivers/pinctrl/freescale/pinctrl-imx.c            |   2 +-
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      |   2 +-
 drivers/pinctrl/freescale/pinctrl-imx8mq.c         | 351 +++++++++++++++++
 drivers/pinctrl/intel/Kconfig                      |  12 +-
 drivers/pinctrl/intel/Makefile                     |   1 +
 drivers/pinctrl/intel/pinctrl-baytrail.c           |  17 +-
 drivers/pinctrl/intel/pinctrl-broxton.c            |   5 +-
 drivers/pinctrl/intel/pinctrl-cannonlake.c         |  13 +-
 drivers/pinctrl/intel/pinctrl-cedarfork.c          |  97 +++--
 drivers/pinctrl/intel/pinctrl-cherryview.c         |   5 +-
 drivers/pinctrl/intel/pinctrl-denverton.c          |   5 +-
 drivers/pinctrl/intel/pinctrl-geminilake.c         |   5 +-
 drivers/pinctrl/intel/pinctrl-icelake.c            | 436 +++++++++++++++++=
++++
 drivers/pinctrl/intel/pinctrl-intel.c              |  37 +-
 drivers/pinctrl/intel/pinctrl-intel.h              |   5 +-
 drivers/pinctrl/intel/pinctrl-lewisburg.c          |   5 +-
 drivers/pinctrl/intel/pinctrl-merrifield.c         |   5 +-
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c       |   5 +-
 drivers/pinctrl/mediatek/mtk-eint.c                |   1 +
 drivers/pinctrl/mediatek/pinctrl-mt7622.c          |   5 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c          |   9 +
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c         |   8 +
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        | 118 ++++++
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |  11 +-
 drivers/pinctrl/pinctrl-amd.c                      |  17 +-
 drivers/pinctrl/pinctrl-amd.h                      |   4 +
 drivers/pinctrl/pinctrl-at91-pio4.c                |  46 ++-
 drivers/pinctrl/pinctrl-axp209.c                   |  26 +-
 drivers/pinctrl/pinctrl-gemini.c                   |   2 +
 drivers/pinctrl/pinctrl-mcp23s08.c                 |   2 +-
 drivers/pinctrl/pinctrl-ocelot.c                   | 104 ++++-
 drivers/pinctrl/pinctrl-rza1.c                     |  24 +-
 drivers/pinctrl/pinctrl-single.c                   | 127 +++---
 drivers/pinctrl/pinmux.c                           |  17 +-
 drivers/pinctrl/pinmux.h                           |   7 -
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  14 +-
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |  32 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       |  16 +
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  68 +++-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |  11 +
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c              | 333 ++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c              |  69 +++-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |  43 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c              |   6 +-
 drivers/pinctrl/tegra/pinctrl-tegra.h              |   1 +
 drivers/pinctrl/tegra/pinctrl-tegra114.c           |   8 +-
 drivers/pinctrl/tegra/pinctrl-tegra124.c           |   8 +-
 drivers/pinctrl/tegra/pinctrl-tegra20.c            |   8 +-
 drivers/pinctrl/tegra/pinctrl-tegra210.c           |   8 +-
 drivers/pinctrl/tegra/pinctrl-tegra30.c            |   8 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c   |  10 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c   |  20 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld4.c    |   5 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld6b.c   |  10 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c   |  10 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro5.c   |  15 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c   |  10 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs3.c   |  10 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-sld8.c   |   5 +
 include/dt-bindings/pinctrl/at91.h                 |   4 +
 include/dt-bindings/pinctrl/samsung.h              |   7 +-
 include/linux/pinctrl/pinconf.h                    |   3 +-
 include/linux/soc/samsung/exynos-regs-pmu.h        |   8 +-
 99 files changed, 2936 insertions(+), 302 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
 create mode 100644 drivers/pinctrl/berlin/pinctrl-as370.c
 create mode 100644 drivers/pinctrl/freescale/pinctrl-imx8mq.c
 create mode 100644 drivers/pinctrl/intel/pinctrl-icelake.c
