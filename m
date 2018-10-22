Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A6EC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E14320853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuZ3eqGP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E14320853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbeJVVHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:07:23 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39571 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbeJVVHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:07:22 -0400
Received: by mail-lf1-f67.google.com with SMTP id p11-v6so3836665lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 05:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ElHXdzjLoDXh5fv6Df51PNbEO6WnBCSbWRI5WJLK1F8=;
        b=JuZ3eqGP4CfkTeIRfS0ugONAXIDnXFQT5++4Dt5jmBMPc0osmoPgzub3uaYpjh2BoT
         nwZcKvrtaPTbi/Cb2c9m5VlBGeB7z8zPLiywO1daYGl5C1WTACM3Uknci+QFCJekZFGB
         xHKwD4qwduAvkTF4wb3lMBMXtCpebLbZ/2DwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ElHXdzjLoDXh5fv6Df51PNbEO6WnBCSbWRI5WJLK1F8=;
        b=QkReiim3tRbeENmX8E7wfRy/Dq5/o8/PsR26k6XP5pOyRYc5K9W8umCgCx0A6bd/M4
         b4ZwDXwiZ4u5TNXh7WbP8slM8CMf1hyR2jV2NAHM7XveS6189LvcYJge+K4jJYmQY2JF
         kmGWrxrJUuknEW64VwjvEwx6rRddZSNVG+RusSTk0PsvlVB54buYCB6o/JCZB6/XHPxZ
         X4bsl1nMLvtHZZE4zwGSq/Wm8wEQaVGPYNBpd3egoQGs6UvVYVcC2PQtfSa111E4x1E1
         yOmCtHv5lvqV8Aty3w3Py4GITzVoEY7MMMk1vyGtr5hI6oi3d546EFA4uSKaxMveMLKq
         csnQ==
X-Gm-Message-State: ABuFfoie1ux1HJ5lLFjNsZ1YTZ6EHxwLBH6PK+64ste6s+yxkogfSEEr
        NKP1m33R98ey3YcCbB2p1EitWu0uS6CVlGfeKgPdxkaq658=
X-Google-Smtp-Source: ACcGV62jZtxPWZfDRdhywT+C0sYKx8Oq5bO/WTUlpdy3IAeLfp6U8tw+UMFIGnd+pdhw/aaOr7ZdwjBw8xQUNcSI2OM=
X-Received: by 2002:a19:f813:: with SMTP id a19mr9211473lff.67.1540212531892;
 Mon, 22 Oct 2018 05:48:51 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 22 Oct 2018 14:48:40 +0200
Message-ID: <CACRpkdaXnwXX9Pe6Bo39t-PNcDMufKoJ-S6Zw44GB6n5YPP47A@mail.gmail.com>
Subject: [GIT PULL] Pin control bulk changes for v4.20
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

this is the bulk of pin control changes for the v4.20 series.

The main information about the changes is in the signed tag,
some notices about the git mechanics:

- I pulled in v4.19-rc6 as there was some serious fallout
  between a Qualcomm fix and the development branch
  that could not be trivially resolved. So I just dealt with it
  so as not to mess up linux-next.

- There are two immutable branches for Ingenic and for
  Mediatek floating around. The Ingenic is also merged into
  the GPIO tree, possibly these branches appear in yet more
  trees.

Other than that it is pretty much business as usual.
The new Qualcomm, Mediatek and Broadcom drivers are
quite interesting as they will be used in a few million embedded
devices the coming years as it seems.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 17b57b1883c1285f3d0dc2266e8f79286a7bef38=
:

  Linux 4.19-rc6 (2018-09-30 07:15:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.20-1

for you to fetch changes up to a93a676b079144009f55fff2ab0e34c3b7258c8a:

  pinctrl: sunxi: Fix a memory leak in 'sunxi_pinctrl_build_state()'
(2018-10-16 10:03:48 +0200)

----------------------------------------------------------------
This is the bulk of pin control changes for the v4.20 series:

There were no significant changes to the core this time!

New drivers:

- Broadcom Northstar pin control driver.

- Mediatek MT8183 subdriver.

- Mediatek MT7623 subdriver.

- Mediatek MT6765 subdriver.

- Meson g12a subdriver.

- Nuvoton NPCM7xx pin control and GPIO driver.

- Qualcomm QCS404 pin control and GPIO subdriver.

- Qualcomm SDM660 pin control and GPIO subdriver.

- Renesas R8A7744 PFC subdriver.

- Renesas R8A774C0 PFC subdriver.

- Renesas RZ/N1 pinctrl driver

Major improvements:

- Pulled the GPIO support for Ingenic over from the GPIO
  subsystem and consolidated it all in the Ingenic pin control
  driver.

- Major cleanups and consolidation work in all Intel drivers.

- Major cleanups and consolidation work in all Mediatek drivers.

- Lots of incremental improvements to the Renesas PFC pin
  controller family.

- All drivers doing GPIO now include <linux/gpio/driver.h> and
  nothing else.

----------------------------------------------------------------
Andy Shevchenko (34):
      pinctrl: intel: Fix a spelling typo in kernel documentation
      pinctrl: intel: Introduce intel_pinctrl_probe_by_uid() internal API
      pinctrl: broxton: Convert to use intel_pinctrl_probe_by_uid()
      pinctrl: geminilake: Convert to use intel_pinctrl_probe_by_uid()
      pinctrl: baytrail: Convert to use device_get_match_data()
      pinctrl: intel: Introduce intel_pinctrl_probe_by_hid() internal API
      pinctrl: cannonlake: Convert to use intel_pinctrl_probe_by_hid()
      pinctrl: sunrisepoint: Convert to use intel_pinctrl_probe_by_hid()
      pinctrl: intel: Introduce common macro for PM operations
      pinctrl: broxton: Define PM ops via INTEL_PINCTRL_PM_OPS()
      pinctrl: cannonlake: Define PM ops via INTEL_PINCTRL_PM_OPS()
      pinctrl: cedarfork: Define PM ops via INTEL_PINCTRL_PM_OPS()
      pinctrl: denverton: Define PM ops via INTEL_PINCTRL_PM_OPS()
      pinctrl: geminilake: Define PM ops via INTEL_PINCTRL_PM_OPS()
      pinctrl: icelake: Define PM ops via INTEL_PINCTRL_PM_OPS()
      pinctrl: sunrisepoint: Define PM ops via INTEL_PINCTRL_PM_OPS()
      pinctrl: lewisburg: Define PM ops via INTEL_PINCTRL_PM_OPS()
      pinctrl: intel: Move linux/pm.h to the local header
      pinctrl: baytrail: Remove unneeded MODULE_DEVICE_TABLE()
      pinctrl: baytrail: Sort headers alphabetically
      pinctrl: cherryview: Re-use data structures from pinctrl-intel.h
      pinctrl: cherryview: Remove unused groups of pins
      pinctrl: cherryview: Describe members of couple of structs
      pinctrl: cherryview: Remove linux/init.h and sort headers
      pinctrl: intel: merrifield: Introduce mrfld_read_bufcfg()
      pinctrl: intel: merrifield: Group IO accessors in code
      pinctrl: intel: Convert unsigned to unsigned int
      pinctrl: baytrail: Convert unsigned to unsigned int
      pinctrl: cherryview: Convert unsigned to unsigned int
      pinctrl: broxton: Convert unsigned to unsigned int
      pinctrl: intel: Fix a spelling typo in kernel documentation
      pinctrl: geminilake: Update pin list for B0 stepping
      pinctrl: geminilake: Get rid of unneeded ->probe() stub
      pinctrl: geminilake: Sort register offsets by value

Arnd Bergmann (3):
      pinctrl: mediatek: mark dummy helpers as 'static inline'
      pinctrl: qcom: fix 'const' pointer handling
      pinctrl: mediatek: select GPIOLIB

Avaneesh Kumar Dwivedi (1):
      pinctrl: qcom: Add qcs404 pinctrl driver

Baolin Wang (1):
      pinctrl: sprd: Move DT parsing before registering pinctrl device

Biju Das (5):
      pinctrl: sh-pfc: r8a77470: Add EtherAVB pin groups
      dt-bindings: pinctrl: sh-pfc: Document r8a774a1 PFC support
      pinctrl: sh-pfc: r8a7796: Add R8A774A1 PFC support
      dt-bindings: pinctrl: sh-pfc: Document r8a7744 PFC support
      pinctrl: sh-pfc: r8a7791: Add r8a7744 support

Bjorn Andersson (3):
      pinctrl: qcom: Introduce readl/writel accessors
      pinctrl: qcom: Support dispersed tiles
      dt-bindings: pinctrl: qcom: Add QCS404 pinctrl binding

Christophe JAILLET (1):
      pinctrl: sunxi: Fix a memory leak in 'sunxi_pinctrl_build_state()'

Colin Ian King (1):
      pinctrl: mediatek: fix check on EINT_NA comparison

Craig Tatlor (1):
      dt-bindings: pinctrl: qcom: Add SDM660 pinctrl binding

Dan Carpenter (1):
      pinctrl: at91-pio4: fix has_config check in atmel_pctl_dt_subnode_to_=
map()

Douglas Anderson (2):
      pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be compliant
      pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be compliant

Fabio Estevam (1):
      pinctrl: mxs: do not export mxs_pinctrl_probe

Fabrizio Castro (7):
      dt-bindings: pinctrl: sh-pfc: Document r8a774c0 PFC support
      pinctrl: sh-pfc: r8a77990: Add R8A774C0 PFC support
      pinctrl: sh-pfc: r8a77470: Add I2C4 pin groups
      pinctrl: sh-pfc: r8a77470: Add DU0 pin groups
      pinctrl: sh-pfc: r8a77470: Add QSPI0 pin groups
      pinctrl: sh-pfc: r8a77470: Add SDHI2 pin groups
      pinctrl: sh-pfc: r8a77470: Add USB pin groups

Geert Uytterhoeven (2):
      pinctrl: sh-pfc: rcar: Rename automotive-only arrays to automotive
      pinctrl: sh-pfc: r8a77990: Add INTC-EX pins, groups and function

Gustavo A. R. Silva (2):
      pinctrl: lpc18xx: mark expected switch fall-throughs
      pinctrl: madera: Fix uninitialized variable bug in madera_mux_set_mux

Hoan Nguyen An (2):
      pinctrl: sh-pfc: r8a77965: Add Audio clock pin support
      pinctrl: sh-pfc: r8a77965: Add Audio SSI pin support

Igor Stoppa (1):
      pinctrl: remove unnecessary unlikely()

Kuninori Morimoto (2):
      pinctrl: sh-pfc: Convert to SPDX identifiers
      pinctrl: rza1: Convert to SPDX identifiers

Laurent Pinchart (1):
      pinctrl: sh-pfc: r8a77990: Add DU pins, groups and function

Linus Walleij (14):
      pinctrl: ingenic: Include the right header
      Merge branch 'ib-ingenic' into devel
      Merge tag 'sh-pfc-for-v4.20-tag1' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      pinctrl: at91-pio4: Get rid of legacy call
      pinctrl: Include <linux/gpio/driver.h> nothing else
      Merge branch 'ib-mtk' into devel
      pinctrl: mtk: Fix up GPIO includes
      Merge tag 'v4.19-rc6' into devel
      Merge tag 'sh-pfc-for-v4.20-tag2' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      pinctrl: nomadik: Fix debugfs
      Merge tag 'sh-pfc-for-v4.20-tag3' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      pinctrl: gemini: Mask and set properly
      pinctrl: gemini: Drop noisy debug prints
      pinctrl: gemini: Fix up TVC clock group

Ludovic Desroches (1):
      pinctrl: at91: don't use the same irqchip with multiple gpiochips

Manivannan Sadhasivam (1):
      pinctrl: mediatek: Make eint_m u16

Mars Cheng (2):
      pinctrl: mediatek: add no eint function for pin define
      pinctrl: mediatek: add eint support to MT6765 pinctrl driver

Masahiro Yamada (3):
      pinctrl: uniphier: drop meaningless pin from SD1 pin-mux of Pro4
      pinctrl: uniphier: include <linux/bits.h> instead of <linux/bitops.h>
      gpio: uniphier: include <linux/bits.h> instead of <linux/bitops.h>

Neeraj Upadhyay (1):
      pinctrl: qcom: Add sdm660 pinctrl driver

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

Phil Edworthy (2):
      dt-bindings: pinctrl: renesas,rzn1-pinctrl: documentation
      pinctrl: renesas: Renesas RZ/N1 pinctrl driver

Rafa=C5=82 Mi=C5=82ecki (4):
      dt-bindings: pinctrl: document Broadcom Northstar pin mux controller
      pinctrl: bcm: add Northstar driver
      pinctrl: bcm: ns: Use uintptr_t for casting data
      dt-bindings: pinctrl: bcm4708-pinmux: improve example binding

Richard Fitzgerald (3):
      pinctrl: madera: Set is_generic
      pinctrl: madera: Return ENOTSUPP for unsupported pin attributes
      pinctrl: madera: Fix missing space in debugfs output

Rob Herring (1):
      pinctrl: Convert to using %pOFn instead of device_node.name

Sean Wang (21):
      pinctrl: mediatek: add pinctrl-mtk-common-v2 for all MediaTek pinctrl=
s
      pinctrl: mediatek: add pinctrl-moore that implements the generic
pinctrl dt-bindings
      pinctrl: mediatek: extend struct mtk_pin_field_calc to
pinctrl-mtk-common-v2.c
      pinctrl: mediatek: extend struct mtk_pin_desc to pinctrl-mtk-common-v=
2.c
      pinctrl: mediatek: extend struct mtk_pin_soc to pinctrl-mtk-common-v2=
.c
      pinctrl: mediatek: add driving strength related support to
pinctrl-mtk-common-v2.c
      pinctrl: mediatek: add drv register support to pinctrl-mtk-common-v2.=
c
      pinctrl: mediatek: add pull related support to pinctrl-mtk-common-v2.=
c
      pinctrl: mediatek: add advanced pull related support to
pinctrl-mtk-common-v2.c
      pinctrl: mediatek: add ies register support to pinctrl-mtk-common-v2.=
c
      pinctrl: mediatek: add pullen, pullsel register support to
pinctrl-mtk-common-v2.c
      pinctrl: mediatek: add MT7623 pinctrl driver based on generic
pinctrl binding
      pinctrl: mediatek: use pin descriptor all in pinctrl-mtk-common-v2.c
      pinctrl: mediatek: add multiple register bases support to
pinctrl-mtk-common-v2.c
      pinctrl: mediatek: adjust error code and message when some
register not supported is found
      pinctrl: mediatek: extend struct mtk_pin_desc which per-pin
driver depends on
      pinctrl: mediatek: extend advanced pull support in pinctrl-mtk-common=
-v2.c
      pinctrl: mediatek: extend eint build to pinctrl-mtk-common-v2.c
      pinctrl: mediatek: add eint support to MT8183 pinctrl driver
      pinctrl: mediatek: fix static checker warning caused by EINT_NA
      MAINTAINERS: update entry for Mediatek pin controller

Stefan Agner (1):
      pinctrl: tegra: do not export tegra_pinctrl_probe

Stephen Boyd (4):
      pinctrl: msm: Mux out gpio function with gpio_request()
      pinctrl: msm: Configure interrupts as input and gpio mode
      pinctrl: qcom: spmi-mpp: Fix drive strength setting
      pinctrl: msm: Actually use function 0 for gpio selection

Takeshi Kihara (4):
      pinctrl: sh-pfc: r8a77965: Add SATA pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add PWM pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add MSIOF pins, groups and functions
      pinctrl: sh-pfc: r8a77995: Add MSIOF pins, groups and functions

Tomer Maimon (2):
      dt-binding: pinctrl: Add NPCM7xx pinctrl and GPIO documentation
      pinctrl: nuvoton: add NPCM7xx pinctrl and GPIO driver

Uwe Kleine-K=C3=B6nig (1):
      pinctrl: rza1: don't manually release devm managed resources

Vinod Koul (1):
      dt-bindings: pinctrl: qcom-pmic-gpio: Add pms405 support

Wei Yongjun (3):
      pinctrl: mediatek: paris: fix return value check in
mtk_paris_pinctrl_probe()
      pinctrl: mediatek: make symbol 'mtk_drive' static
      pinctrl: mediatek: moore: fix return value check in
mtk_moore_pinctrl_probe()

Yanjiang Jin (1):
      pinctrl: core: make sure strcmp() doesn't get a null parameter

Yixun Lan (2):
      pinctrl: Add compatibles for Amlogic Meson G12A pin controllers
      pinctrl: meson-g12a: add pinctrl driver support

YueHaibing (4):
      pinctrl: sirf: atlas7: remove set but not used variables 'conf, bank'
      pinctrl: qcom: spmi-mpp: Fix err handling of pmic_mpp_set_mux
      pinctrl: sunxi: fix 'pctrl->functions' allocation in
sunxi_pinctrl_build_state
      pinctrl: renesas: Fix platform_no_drv_owner.cocci warnings

ZH Chen (1):
      pinctrl: mediatek: add MT6765 pinctrl driver

Zhiyong Tao (3):
      pinctrl: mediatek: add pinctrl-paris that implements the vendor
dt-bindings
      pinctrl: mediatek: add MT8183 pinctrl driver
      pintcrl: mediatek: add pull tweaks for I2C related pins on MT8183

 .../devicetree/bindings/gpio/ingenic,gpio.txt      |   46 -
 .../bindings/pinctrl/brcm,bcm4708-pinmux.txt       |   57 +
 .../bindings/pinctrl/ingenic,pinctrl.txt           |   39 +-
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |    2 +
 .../bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt   |  216 ++
 .../devicetree/bindings/pinctrl/qcom,pmic-gpio.txt |    2 +
 .../bindings/pinctrl/qcom,qcs404-pinctrl.txt       |  199 ++
 .../bindings/pinctrl/qcom,sdm660-pinctrl.txt       |  191 ++
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    3 +
 .../bindings/pinctrl/renesas,rzn1-pinctrl.txt      |  153 ++
 MAINTAINERS                                        |    7 +-
 drivers/gpio/Kconfig                               |   11 -
 drivers/gpio/Makefile                              |    1 -
 drivers/gpio/gpio-ingenic.c                        |  392 ----
 drivers/gpio/gpio-uniphier.c                       |    2 +-
 drivers/pinctrl/Kconfig                            |   17 +-
 drivers/pinctrl/Makefile                           |    2 +
 drivers/pinctrl/aspeed/pinctrl-aspeed.c            |    2 +-
 drivers/pinctrl/bcm/Kconfig                        |   13 +
 drivers/pinctrl/bcm/Makefile                       |    1 +
 drivers/pinctrl/bcm/pinctrl-ns.c                   |  372 ++++
 drivers/pinctrl/berlin/berlin.c                    |    6 +-
 drivers/pinctrl/cirrus/pinctrl-madera-core.c       |   10 +-
 drivers/pinctrl/core.c                             |    4 +-
 drivers/pinctrl/freescale/pinctrl-imx.c            |    7 +-
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      |   12 +-
 drivers/pinctrl/freescale/pinctrl-mxs.c            |    1 -
 drivers/pinctrl/intel/pinctrl-baytrail.c           |   41 +-
 drivers/pinctrl/intel/pinctrl-broxton.c            |  154 +-
 drivers/pinctrl/intel/pinctrl-cannonlake.c         |   19 +-
 drivers/pinctrl/intel/pinctrl-cedarfork.c          |    7 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |  147 +-
 drivers/pinctrl/intel/pinctrl-denverton.c          |    7 +-
 drivers/pinctrl/intel/pinctrl-geminilake.c         |   75 +-
 drivers/pinctrl/intel/pinctrl-icelake.c            |    7 +-
 drivers/pinctrl/intel/pinctrl-intel.c              |  150 +-
 drivers/pinctrl/intel/pinctrl-intel.h              |   42 +-
 drivers/pinctrl/intel/pinctrl-lewisburg.c          |    7 +-
 drivers/pinctrl/intel/pinctrl-merrifield.c         |   56 +-
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c       |   19 +-
 drivers/pinctrl/mediatek/Kconfig                   |   49 +-
 drivers/pinctrl/mediatek/Makefile                  |    5 +
 drivers/pinctrl/mediatek/mtk-eint.c                |    2 +-
 drivers/pinctrl/mediatek/mtk-eint.h                |    4 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c           |  690 +++++++
 drivers/pinctrl/mediatek/pinctrl-moore.h           |   51 +
 drivers/pinctrl/mediatek/pinctrl-mt6765.c          | 1108 +++++++++++
 drivers/pinctrl/mediatek/pinctrl-mt7622.c          | 1407 +++----------
 drivers/pinctrl/mediatek/pinctrl-mt7623.c          | 1441 ++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mt8183.c          |  544 +++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c   |  670 +++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h   |  291 +++
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |    4 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6765.h      | 1754 ++++++++++++++++=
+
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8183.h      | 1916 ++++++++++++++++=
++
 drivers/pinctrl/mediatek/pinctrl-paris.c           |  907 +++++++++
 drivers/pinctrl/mediatek/pinctrl-paris.h           |   63 +
 drivers/pinctrl/meson/Kconfig                      |    6 +
 drivers/pinctrl/meson/Makefile                     |    1 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c         | 1404 +++++++++++++
 drivers/pinctrl/meson/pinctrl-meson.c              |    4 +-
 drivers/pinctrl/meson/pinctrl-meson.h              |    2 +-
 drivers/pinctrl/mvebu/pinctrl-mvebu.c              |    6 +-
 drivers/pinctrl/nomadik/pinctrl-ab8500.c           |    2 +-
 drivers/pinctrl/nomadik/pinctrl-ab8505.c           |    2 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |    2 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |   12 +-
 drivers/pinctrl/nuvoton/Kconfig                    |   12 +
 drivers/pinctrl/nuvoton/Makefile                   |    4 +
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          | 2072 ++++++++++++++++=
++++
 drivers/pinctrl/pinctrl-amd.c                      |    2 +-
 drivers/pinctrl/pinctrl-as3722.c                   |    2 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |   29 +-
 drivers/pinctrl/pinctrl-at91.c                     |   40 +-
 drivers/pinctrl/pinctrl-coh901.c                   |    2 +-
 drivers/pinctrl/pinctrl-digicolor.c                |    1 -
 drivers/pinctrl/pinctrl-falcon.c                   |    2 +-
 drivers/pinctrl/pinctrl-gemini.c                   |   79 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |  462 ++++-
 drivers/pinctrl/pinctrl-lantiq.c                   |    8 +-
 drivers/pinctrl/pinctrl-lpc18xx.c                  |    6 +
 drivers/pinctrl/pinctrl-mcp23s08.c                 |    2 +-
 drivers/pinctrl/pinctrl-pistachio.c                |    1 -
 drivers/pinctrl/pinctrl-rockchip.c                 |   10 +-
 drivers/pinctrl/pinctrl-rza1.c                     |   21 +-
 drivers/pinctrl/pinctrl-rzn1.c                     |  947 +++++++++
 drivers/pinctrl/pinctrl-single.c                   |   32 +-
 drivers/pinctrl/pinctrl-st.c                       |    6 +-
 drivers/pinctrl/qcom/Kconfig                       |   17 +
 drivers/pinctrl/qcom/Makefile                      |    2 +
 drivers/pinctrl/qcom/pinctrl-msm.c                 |  171 +-
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    4 +
 drivers/pinctrl/qcom/pinctrl-qcs404.c              | 1697 ++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sdm660.c              | 1455 ++++++++++++++
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           |    2 +-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |   29 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |   30 +-
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c            |    2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    2 +-
 drivers/pinctrl/sh-pfc/Kconfig                     |   16 +
 drivers/pinctrl/sh-pfc/Makefile                    |    3 +
 drivers/pinctrl/sh-pfc/core.c                      |   23 +-
 drivers/pinctrl/sh-pfc/core.h                      |    7 +-
 drivers/pinctrl/sh-pfc/gpio.c                      |    5 +-
 drivers/pinctrl/sh-pfc/pfc-emev2.c                 |    5 +-
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c               |   15 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |   15 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c              |  408 ++++
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c               |   10 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c               |   14 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c               |   15 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c               |   43 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c               |    5 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c               |    5 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c           |    5 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               |    5 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |  842 ++++----
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c              |  419 ++++
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c              |    5 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c              |  981 ++++++++-
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c              |  370 +++-
 drivers/pinctrl/sh-pfc/pfc-sh7203.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-sh7264.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-sh7269.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c                |   15 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-sh7723.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-sh7724.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-sh7734.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-sh7757.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-sh7785.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-sh7786.c                |    5 +-
 drivers/pinctrl/sh-pfc/pfc-shx3.c                  |    5 +-
 drivers/pinctrl/sh-pfc/pinctrl.c                   |    5 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   10 +-
 drivers/pinctrl/sirf/pinctrl-atlas7.c              |   11 +-
 drivers/pinctrl/sirf/pinctrl-sirf.c                |    2 +-
 drivers/pinctrl/spear/pinctrl-spear.h              |    2 +-
 drivers/pinctrl/sprd/pinctrl-sprd.c                |   13 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |    4 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   34 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c              |    1 -
 drivers/pinctrl/ti/pinctrl-ti-iodelay.c            |    8 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-pro4.c   |    5 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier.h        |    2 +-
 drivers/pinctrl/vt8500/pinctrl-wmt.c               |    6 +-
 drivers/pinctrl/vt8500/pinctrl-wmt.h               |    2 +-
 include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 ++
 include/dt-bindings/pinctrl/rzn1-pinctrl.h         |  141 ++
 150 files changed, 22655 insertions(+), 2990 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/gpio/ingenic,gpio.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/brcm,bcm4708-pinmux.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/nuvoton,npcm7xx-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
 create mode 100644
Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt
 delete mode 100644 drivers/gpio/gpio-ingenic.c
 create mode 100644 drivers/pinctrl/bcm/pinctrl-ns.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-moore.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6765.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt7623.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt8183.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6765.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt8183.h
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-paris.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-paris.h
 create mode 100644 drivers/pinctrl/meson/pinctrl-meson-g12a.c
 create mode 100644 drivers/pinctrl/nuvoton/Kconfig
 create mode 100644 drivers/pinctrl/nuvoton/Makefile
 create mode 100644 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c
 create mode 100644 drivers/pinctrl/pinctrl-rzn1.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qcs404.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm660.c
 create mode 100644 include/dt-bindings/gpio/meson-g12a-gpio.h
 create mode 100644 include/dt-bindings/pinctrl/rzn1-pinctrl.h
