Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id BC27A7DnGFucSgAAmS7hNA
	; Thu, 07 Jun 2018 08:15:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 124F36089E; Thu,  7 Jun 2018 08:15:05 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bb5QsWW3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E560F607E7;
	Thu,  7 Jun 2018 08:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E560F607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeFGIPA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:15:00 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44283 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932279AbeFGIOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:14:55 -0400
Received: by mail-io0-f195.google.com with SMTP id g7-v6so10799962ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=KRJTq6LYNIPQorxrBiCmZR7v6746eNyMpLpMeXYyMrA=;
        b=bb5QsWW3LlRMCnWalb/idQaXNkwbnZNGHJ/OpB/Zkeey8KCgJCkClcOcD1HWaaJtIN
         7ktybGgy3boAGpdWFPVgFGeKEDhmT2oN1H6YhK3sMZfIQk//9qcJ00oOLmUCecuhdUXO
         AS5um0i+REHIb+1aYeMHNm87zkx/A6ip/Hwfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=KRJTq6LYNIPQorxrBiCmZR7v6746eNyMpLpMeXYyMrA=;
        b=JtnetQYGzNzEw5ynCXfNsRrjeyadCG9ATuYn8mOmPshx3L9lSiJjyVTlWuSV4fpmhz
         S3XLCWioTGBNlfWAOPP4qDWc98bW+enmK0ANLp+wH8xHFNQasyjxDcoYMv9jl82slkdV
         PV7cgaFLiEzWaMKq1idCSJ4ud0FU3oX9i6S4PCrjQcmcWlqneGJqgOlEwQn+eYjj08dV
         Xy3d95+FMkUCezdgdex0NH+TryCRJB8pRqMor8WDoNWJa96LhysxsfkqlmoogMhN+iT+
         Jx/ojuBwz+ob/IqmjLMIxcd2h8/pDrdFuiErhppXmrLKxIeJ2XoL3dnYRbjLgqUzkBrs
         cEXA==
X-Gm-Message-State: APt69E1BgHR8OQlgUo/72TfV19bMmSAQ8q8/b4oZv3eUr+bgTIGZgIUM
        0nDhm39O7tzErJeUqR0gg8V3BLwrJeRioECsGA7frg==
X-Google-Smtp-Source: ADUXVKJDf+7nUsDxcu62DtebVDec0dbL8Y59+RYJBflrl7y0FVXft7efcE9Ms/g8ZmYfNZIv41ypsqopJJI9Bx/MX0g=
X-Received: by 2002:a6b:4014:: with SMTP id k20-v6mr613100ioa.277.1528359294894;
 Thu, 07 Jun 2018 01:14:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:78c9:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 01:14:53 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 7 Jun 2018 10:14:53 +0200
Message-ID: <CACRpkdZ5Kp9fhGfOq41VFXK7YubLOKm-3UBa6RL0_Hu8xyFM+w@mail.gmail.com>
Subject: [GIT PULL] pin control bulk changes for v4.18
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here is the pin control stash for v4.18. No surprises,
just driver updates and fixes.

Details are in the signed tag as usual.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338=
:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v4.18-1

for you to fetch changes up to 86c5dd6860a60e9b69558ecfce2c4769045d110c:

  pinctrl: cherryview: limit Strago DMI workarounds to version 1.0
(2018-06-04 08:34:14 +0200)

----------------------------------------------------------------
This is the bulk of pin control changes for v4.18.

No core changes this time! Just a calm all-over-the-place
drivers, updates and fixes cycle as it seems.

New drivers/subdrivers:

- Actions Semiconductor S900 driver with more Actions
  variants for S700, S500 in the pipe. Also generic GPIO
  support on top of the same driver and IRQ support is in
  the pipe.

- Renesas r8a77470 PFC support.

- Renesas r8a77990 PFC support.

- Allwinner Sunxi H6 R_PIO support.

- Rockchip PX30 support.

- Meson Meson8m2 support.

- Remove support for the ill-fated Samsung Exynos 5440 SoC.

Improvements:

- Context save/restore support in pinctrl-single.

- External interrupt support for the Mediatek MT7622.

- Qualcomm ACPI HID QCOM8002 supported.

Fixes:

- Fix up suspend/resume support for Exynos 5433.

- Fix Strago DMI fixes on the Intel Cherryview.

----------------------------------------------------------------
Andy Shevchenko (1):
      pinctrl: armada-37xx: Convert to use match_string() helper

Biju Das (2):
      dt-bindings: pinctrl: sh-pfc: Document r8a77470 PFC support
      pinctrl: sh-pfc: Add r8a77470 PFC support

Chanho Park (1):
      pinctrl: samsung: add pin_dbg_show callback for debugfs

Chris Packham (2):
      pinctrl: mvebu: use correct MPP sel value for dev pins
      pinctrl: mvebu: update use "nand" function for "rb" pin

Christian Lamparter (2):
      pinctrl: msm: fix gpio-hog related boot issues
      gpiolib: discourage gpiochip_add_pin[group]_range for DT pinctrls

Cl=C3=A9ment P=C3=A9ron (1):
      pinctrl: qcom: fix wrong pull status display for no_keeper SoC

Colin Ian King (2):
      pinctrl: actions: make s900_functions, s900_padinfo and s900_pads sta=
tic
      pinctrl: actions: fix missing break in PIN_CONFIG_DRIVE_STRENGTH case=
.

David Wu (1):
      pinctrl: rockchip: Add pinctrl support for PX30

Dmitry Osipenko (1):
      pinctrl: tegra20: Provide CDEV1/2 clock muxes

Dmitry Torokhov (1):
      pinctrl: cherryview: limit Strago DMI workarounds to version 1.0

Dong Aisheng (3):
      pinctrl: imx: fix unsigned check if nfuncs with less than or equal ze=
ro
      pinctrl: pinctrl-imx: improve the code comments of PIN_FUNC_ID
      pinctrl: imx: use seq_puts() instead of seq_printf()

Fabio Estevam (1):
      pinctrl: freescale: Switch to SPDX identifier

Geert Uytterhoeven (3):
      pinctrl: sh-pfc: r8a7795: Fix comment for MSIOF3 SS2_E pin
      pinctrl: sh-pfc: r8a7796: Fix comment for MSIOF3 SS2_E pin
      pinctrl: sh-pfc: rcar-gen3: Fix grammar in static pin comments

Icenowy Zheng (1):
      pinctrl: sunxi: add support for H6 R_PIO pin controller

Jerome Brunet (1):
      pinctrl: meson: axg: add tdm pins

Jisheng Zhang (1):
      pinctrl: berlin: switch to SPDX license identifier

Julia Lawall (1):
      pinctrl: at91-pio4: add missing of_node_put

Katsuhiro Suzuki (2):
      pinctrl: uniphier: add LD20 MPEG2-TS I/O pin-mux settings
      pinctrl: uniphier: add LD11 MPEG2-TS I/O pin-mux settings

Keerthy (1):
      pinctrl: pinctrl-single: Add functions to save and restore pinctrl co=
ntext

Kieran Bingham (1):
      pinctrl: sh-pfc: r8a77965: Add DU RGB output pins, groups and functio=
ns

Krzysztof Kozlowski (1):
      pinctrl: samsung: Remove support for Exynos5440

Linus Walleij (2):
      Merge tag 'sh-pfc-for-v4.18-tag2' of
git://git.kernel.org/.../geert/renesas-drivers into devel
      Merge tag 'samsung-pinctrl-4.18-2' of
https://git.kernel.org/.../pinctrl/samsung into devel

Manivannan Sadhasivam (5):
      pinctrl: actions: Add Actions S900 pinctrl driver
      pinctrl: actions: Fix Kconfig dependency and help text
      dt-bindings: pinctrl: Add gpio bindings for Actions S900 SoC
      pinctrl: actions: Add gpio support for Actions S900 SoC
      MAINTAINERS: Add Actions Semi S900 pinctrl entries

Marek Szyprowski (1):
      pinctrl: samsung: Fix suspend/resume for Exynos5433 GPF1..5 banks

Martin Blumenstingl (3):
      dt-bindings: pinctrl: meson: add support for the Meson8m2 SoC
      pinctrl: meson: meson8: add support for the Meson8m2 SoC
      pinctrl: meson: meson8: add the RGMII RXD2/RXD3 and TXD2/TXD3 signals

Matheus Castello (3):
      dt-bindings: pinctrl: bcm2835-gpio: Add generic pinctrl support
      pinctrl: bcm2835: Add support for generic pinctrl binding
      pinctrl: bcm2835: Add support for output-low output-high properties

Niklas S=C3=B6derlund (1):
      pinctrl: sh-pfc: r8a77965: Add I2C pin support

Pawe=C5=82 Chmiel (2):
      pinctrl: samsung: Correct EINTG banks order
      pinctrl: samsung: Document required order of banks

Ricardo Silva (1):
      dt-bindings: pinctrl: mcp23s08: Clarify gpiospec flags cell usage

Ryder Lee (1):
      pinctrl: mediatek: update pinmux defintions for MT7623

Sean Wang (6):
      dt-bindings: pinctrl: add external interrupt support to MT7622 pinctr=
l
      pinctrl: mediatek: refactor EINT related code for all MediaTek
pinctrl can fit
      pinctrl: mediatek: add EINT support to MT7622 SoC
      pinctrl: mediatek: use generic EINT register maps for each SoC
      pinctrl: mediatek: remove unused fields in struct mtk_eint_hw
      MAINTAINERS: update entry for Mediatek pin controller

Sergei Shtylyov (2):
      pinctrl: sh-pfc: r8a77980: Add pin I/O voltage control support
      pinctrl: sh-pfc: r8a77970: Fix pin I/O voltage control support

Shawn Lin (1):
      pinctrl: rockchip: Add set_config callback support for gpiolib

Stephen Boyd (1):
      pinctrl: qcom: Print high/low status of gpios in debugfs

Takeshi Kihara (9):
      pinctrl: sh-pfc: r8a77965: Add MSIOF pins, groups and functions
      pinctrl: sh-pfc: r8a77965: Add PWM pins, groups and functions
      pinctrl: sh-pfc: r8a77965: Add SDHI pins, groups and functions
      pinctrl: sh-pfc: Add PORT_GP_11 helper macro
      pinctrl: sh-pfc: Initial R8A77990 PFC support
      pinctrl: sh-pfc: r8a77990: Add bias pinconf support
      pinctrl: sh-pfc: r8a77990: Add SCIF pins, groups and functions
      pinctrl: sh-pfc: r8a77990: Add I2C{1,2,4,5,6,7} pins, groups and func=
tions
      pinctrl: sh-pfc: r8a77990: Add EthernetAVB pins, groups and functions

Terry Zhou (1):
      pinctrl: armada-37xx: Fix spurious irq management

Thomas Gleixner (1):
      pinctrl: sh-pfc: r8a77965: Fixup incorrect SPDX identifier

Timur Tabi (2):
      pinctrl: qcom: remove static globals to allow multiple TLMMs
      pinctrl: qcom: qdf2xxx: add support for new ACPI HID QCOM8002

Yixun Lan (2):
      pinctrl: nand: meson-gxbb: fix missing data pins
      pinctrl: nand: meson-gxl: fix missing data pins

 .../bindings/pinctrl/actions,s900-pinctrl.txt      |   16 +
 .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |    1 +
 .../bindings/pinctrl/brcm,bcm2835-gpio.txt         |   18 +
 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |    2 +
 .../bindings/pinctrl/pinctrl-mcp23s08.txt          |    4 +-
 .../devicetree/bindings/pinctrl/pinctrl-mt7622.txt |   10 +
 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |    2 +
 .../bindings/pinctrl/rockchip,pinctrl.txt          |    1 +
 MAINTAINERS                                        |    3 +
 drivers/gpio/gpiolib.c                             |   10 +
 drivers/pinctrl/Kconfig                            |    1 +
 drivers/pinctrl/Makefile                           |    1 +
 drivers/pinctrl/actions/Kconfig                    |   15 +
 drivers/pinctrl/actions/Makefile                   |    2 +
 drivers/pinctrl/actions/pinctrl-owl.c              |  785 ++++++
 drivers/pinctrl/actions/pinctrl-owl.h              |  162 ++
 drivers/pinctrl/actions/pinctrl-s900.c             | 1888 ++++++++++++++
 drivers/pinctrl/bcm/Kconfig                        |    1 +
 drivers/pinctrl/bcm/pinctrl-bcm2835.c              |  100 +-
 drivers/pinctrl/berlin/berlin-bg2.c                |    5 +-
 drivers/pinctrl/berlin/berlin-bg2cd.c              |    5 +-
 drivers/pinctrl/berlin/berlin-bg2q.c               |    5 +-
 drivers/pinctrl/berlin/berlin-bg4ct.c              |   13 +-
 drivers/pinctrl/berlin/berlin.c                    |    5 +-
 drivers/pinctrl/berlin/berlin.h                    |    5 +-
 drivers/pinctrl/freescale/pinctrl-imx.c            |   42 +-
 drivers/pinctrl/freescale/pinctrl-imx.h            |    6 +-
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      |   27 +-
 drivers/pinctrl/freescale/pinctrl-imx1.c           |   15 +-
 drivers/pinctrl/freescale/pinctrl-imx1.h           |    6 +-
 drivers/pinctrl/freescale/pinctrl-imx21.c          |   15 +-
 drivers/pinctrl/freescale/pinctrl-imx23.c          |   19 +-
 drivers/pinctrl/freescale/pinctrl-imx25.c          |   28 +-
 drivers/pinctrl/freescale/pinctrl-imx27.c          |   19 +-
 drivers/pinctrl/freescale/pinctrl-imx28.c          |   19 +-
 drivers/pinctrl/freescale/pinctrl-imx35.c          |   24 +-
 drivers/pinctrl/freescale/pinctrl-imx50.c          |   19 +-
 drivers/pinctrl/freescale/pinctrl-imx51.c          |   21 +-
 drivers/pinctrl/freescale/pinctrl-imx53.c          |   21 +-
 drivers/pinctrl/freescale/pinctrl-imx6dl.c         |   16 +-
 drivers/pinctrl/freescale/pinctrl-imx6q.c          |   21 +-
 drivers/pinctrl/freescale/pinctrl-imx6sl.c         |   16 +-
 drivers/pinctrl/freescale/pinctrl-imx6sll.c        |    8 +-
 drivers/pinctrl/freescale/pinctrl-imx6sx.c         |   16 +-
 drivers/pinctrl/freescale/pinctrl-imx6ul.c         |   16 +-
 drivers/pinctrl/freescale/pinctrl-imx7d.c          |   16 +-
 drivers/pinctrl/freescale/pinctrl-imx7ulp.c        |   17 +-
 drivers/pinctrl/freescale/pinctrl-mxs.c            |   13 +-
 drivers/pinctrl/freescale/pinctrl-mxs.h            |    8 +-
 drivers/pinctrl/freescale/pinctrl-vf610.c          |   15 +-
 drivers/pinctrl/intel/pinctrl-cherryview.c         |    4 +
 drivers/pinctrl/mediatek/Kconfig                   |    6 +
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/mtk-eint.c                |  492 ++++
 drivers/pinctrl/mediatek/mtk-eint.h                |  106 +
 drivers/pinctrl/mediatek/pinctrl-mt2701.c          |   25 +-
 drivers/pinctrl/mediatek/pinctrl-mt2712.c          |   25 +-
 drivers/pinctrl/mediatek/pinctrl-mt7622.c          |  143 ++
 drivers/pinctrl/mediatek/pinctrl-mt8127.c          |   25 +-
 drivers/pinctrl/mediatek/pinctrl-mt8135.c          |   25 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c          |   25 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |  608 +----
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h      |   13 +-
 drivers/pinctrl/meson/pinctrl-meson-axg.c          |  107 +
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c         |    4 +-
 drivers/pinctrl/meson/pinctrl-meson-gxl.c          |    4 +-
 drivers/pinctrl/meson/pinctrl-meson8.c             |   23 +-
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c        |   32 +-
 drivers/pinctrl/mvebu/pinctrl-armada-xp.c          |   22 +-
 drivers/pinctrl/pinctrl-at91-pio4.c                |    4 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  246 ++
 drivers/pinctrl/pinctrl-single.c                   |   72 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   92 +-
 drivers/pinctrl/qcom/pinctrl-qdf2xxx.c             |  114 +-
 drivers/pinctrl/samsung/Kconfig                    |   10 +-
 drivers/pinctrl/samsung/Makefile                   |    1 -
 drivers/pinctrl/samsung/pinctrl-exynos-arm.c       |   30 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     |   20 +
 drivers/pinctrl/samsung/pinctrl-exynos.h           |    2 +-
 drivers/pinctrl/samsung/pinctrl-exynos5440.c       | 1005 --------
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   29 +
 drivers/pinctrl/sh-pfc/Kconfig                     |   10 +
 drivers/pinctrl/sh-pfc/Makefile                    |    2 +
 drivers/pinctrl/sh-pfc/core.c                      |   12 +
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c              | 2343 ++++++++++++++++=
+
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c           |    6 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c               |    8 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c               |    8 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c              | 1592 +++++++++++-
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c              |   32 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c              |   52 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c              | 2695 ++++++++++++++++=
++++
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |   10 +-
 drivers/pinctrl/sunxi/Kconfig                      |    4 +
 drivers/pinctrl/sunxi/Makefile                     |    1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c        |  128 +
 drivers/pinctrl/tegra/pinctrl-tegra.c              |   11 -
 drivers/pinctrl/tegra/pinctrl-tegra.h              |   11 +
 drivers/pinctrl/tegra/pinctrl-tegra20.c            |   30 +-
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld11.c   |   49 +
 drivers/pinctrl/uniphier/pinctrl-uniphier-ld20.c   |   54 +
 include/dt-bindings/pinctrl/mt7623-pinfunc.h       |   90 +-
 102 files changed, 11832 insertions(+), 2134 deletions(-)
 create mode 100644 drivers/pinctrl/actions/Kconfig
 create mode 100644 drivers/pinctrl/actions/Makefile
 create mode 100644 drivers/pinctrl/actions/pinctrl-owl.c
 create mode 100644 drivers/pinctrl/actions/pinctrl-owl.h
 create mode 100644 drivers/pinctrl/actions/pinctrl-s900.c
 create mode 100644 drivers/pinctrl/mediatek/mtk-eint.c
 create mode 100644 drivers/pinctrl/mediatek/mtk-eint.h
 delete mode 100644 drivers/pinctrl/samsung/pinctrl-exynos5440.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77470.c
 create mode 100644 drivers/pinctrl/sh-pfc/pfc-r8a77990.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6-r.c
