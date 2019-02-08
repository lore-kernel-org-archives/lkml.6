Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD682C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B41720869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfBHX1o convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:27:44 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45105 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHX1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:27:44 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so5880742qtr.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 15:27:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=ksV8HOTGcaBZ0icP0QRz9YLMCpLlv1Djn1UW2N3dgVc=;
        b=FxNcScdnBEFrhfuyzaSgRVcgmF9MdFaZ1kDA11C20uaPRo+IaXYAmc89FzVxlvCOx7
         29G8MSkku+Kpj4EVS53KOS651H7e59FpoljGGgctdRTLLaogqZtryK9IcB2CFmrjlCUt
         UmiYMzSYyC7Jqrb6ivko/siEwG5IKOJLbIsDKZe+WN4AtxQz2nEjGG1fQ0HZb9us0X/l
         oC7tNXlumP58CADv9zNZOjeSMQnQGXMz0c8N7YP1HZnD/QT5KHGbJVdrQKGmx+i6UEff
         EJi0MJuX461j+giOhCPgR6aHrMqwQ4wb6ax9Rs9V2rByDVwdsaW7DYEKPz5MISaF0b3+
         fQ7A==
X-Gm-Message-State: AHQUAubkQMWbU2AKuVZ4GrEXyM7GiSIikas5ib5qJji3CoIE+mjIvd0v
        HRrNRtxFD9PW/67DN6n2ykGZJYJztESE+wiiHefV2oON
X-Google-Smtp-Source: AHgI3IaYLu0kAJ34yIRDjo+Pj3Al/e5YK8pqS6C/zHTA5Yv6LWmM/pIAK3kDIJWMx5CN5adhPjaFfOB1xviRN5GcQvc=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr18094695qtl.343.1549668462721;
 Fri, 08 Feb 2019 15:27:42 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 9 Feb 2019 00:27:26 +0100
Message-ID: <CAK8P3a1riu3bpUf492t1zmw-jA5AcP2CQOaKYM_BgfPpdaBJ=g@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for linux-5.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, soc@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git armsoc-fixes-5.0

for you to fetch changes up to d0f9f16788e15d9eb40f68b047732d49658c5a3a:

  ARM: tango: Improve ARCH_MULTIPLATFORM compatibility (2019-01-30
11:45:10 +0100)

----------------------------------------------------------------
ARM: SoC fixes for linux-5.0

This is a bit larger than normal, as we had not managed to send out
a pull request before traveling for a week without my signing key.

There are multiple code fixes for older bugs, all of which should
get backported into stable kernels:

- tango: one fix for multiplatform configurations broken on other
  platforms when tango is enabled
- arm_scmi: device unregistration fix
- iop32x: fix kernel oops from extraneous __init annotation
- pxa: remove a double kfree
- fsl qbman: close an interrupt clearing race

The rest is the usual collection of smaller fixes for device tree
files, on the renesas, allwinner, meson, omap, davinci, qualcomm
and imx platforms. Some of these are for compile-time warnings,
most are for board specific functionality that fails to work
because of incorrect settings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: dts: N950/N9: fix onenand timings

Anson Huang (1):
      ARM: dts: imx6sx: correct backward compatible of gpt

Arnd Bergmann (11):
      Merge tag 'imx-fixes-5.0' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'soc-fsl-fix-v5.0' of
git://git.kernel.org/.../leo/linux into arm/fixes
      Merge tag 'imx-fixes-5.0-2' of
git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'pxa-fixes-5.0' of https://github.com/rjarzmik/linux
into arm/fixes
      Merge tag 'renesas-fixes2-for-v5.0' of
git://git.kernel.org/.../horms/renesas into arm/fixes
      Merge tag 'qcom-fixes-for-5.0-rc3' of
git://git.kernel.org/.../agross/linux into arm/fixes
      Merge tag 'davinci-fixes-for-v5.0-part2' of
git://git.kernel.org/.../nsekhar/linux-davinci into arm/fixes
      Merge tag 'omap-for-v5.0/fixes-rc3' of
git://git.kernel.org/.../tmlind/linux-omap into arm/fixes
      Merge tag 'amlogic-fixes-2.1' of
git://git.kernel.org/.../khilman/linux-amlogic into arm/fixes
      Merge tag 'sunxi-fixes-for-5.0' of
git://git.kernel.org/.../sunxi/linux into arm/fixes
      Merge tag 'renesas-fixes3-for-v5.0' of
git://git.kernel.org/.../horms/renesas into arm/fixes

Arthur Demchenkov (1):
      ARM: dts: n900: fix mmc1 card detect gpio polarity

Bartosz Golaszewski (1):
      ARM: dts: da850: fix interrupt numbers for clocksource

Biju Das (1):
      ARM: dts: r8a7743: Convert to new LVDS DT bindings

Carlo Caione (1):
      arm: dts: meson: Fix IRQ trigger type for macirq

Chen-Yu Tsai (1):
      ARM: dts: sun6i: Add clock-output-names to osc24M clock

Geert Uytterhoeven (3):
      arm64: dts: renesas: r8a774a1: Enable DMA for SCIF2
      arm64: dts: renesas: r8a7796: Enable DMA for SCIF2
      arm64: dts: renesas: r8a77965: Enable DMA for SCIF2

Guido Günther (1):
      dt-bindings: imx8mq: Number clocks consecutively

Heiko Schocher (1):
      ARM: dts: am335x-shc.dts: fix wrong cd pin level

Jernej Skrabec (2):
      ARM: dts: sun8i: h3: Add ethernet0 alias to Beelink X2
      arm64: dts: allwinner: a64: Fix USB OTG regulator

Loys Ollivier (1):
      arm64: dts: meson: Fix mmc cd-gpios polarity

Madalin Bucur (1):
      soc: fsl: qbman: avoid race in clearing QMan interrupt

Marc Gonzalez (1):
      ARM: tango: Improve ARCH_MULTIPLATFORM compatibility

Martin Blumenstingl (3):
      ARM: dts: meson8b: odroidc1: mark the SD card detection GPIO active-low
      ARM: dts: meson8b: ec100: mark the SD card detection GPIO active-low
      ARM: dts: meson8m2: mxiii-plus: mark the SD card detection GPIO active-low

Paul Kocialkowski (1):
      arm64: dts: allwinner: a64: Fix the video engine compatible

Peng Hao (1):
      ARM: pxa: ssp: unneeded to free devm_ allocated data

Russell King (1):
      ARM: iop32x/n2100: fix PCI IRQ mapping

Shawn Guo (1):
      ARM: dts: vf610-bk4: fix incorrect #address-cells for dspi3

Srinivas Kandagatla (1):
      arm64: dts: add msm8996 compatible to gicv3

Sudeep Holla (2):
      ARM: dts: imx: replace gpio-key,wakeup with wakeup-source property
      firmware: arm_scmi: provide the mandatory device release callback

Tony Lindgren (3):
      ARM: dts: omap4-droid4: Fix typo in cpcap IRQ flags
      ARM: dts: Remove unnecessary idle flags for omap5 uart3
      ARM: dts: omap3-gta04: Fix graph_port warning

 arch/arm/boot/dts/am335x-shc.dts                   |  2 +-
 arch/arm/boot/dts/da850.dtsi                       |  2 +-
 arch/arm/boot/dts/imx6q-pistachio.dts              |  2 +-
 arch/arm/boot/dts/imx6sll-evk.dts                  |  2 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  2 +-
 arch/arm/boot/dts/meson.dtsi                       |  2 +-
 arch/arm/boot/dts/meson8b-ec100.dts                |  3 +-
 arch/arm/boot/dts/meson8b-odroidc1.dts             |  4 +--
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts          |  3 +-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  4 ---
 arch/arm/boot/dts/omap3-n900.dts                   |  2 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi               | 42 ++++++++++++++--------
 arch/arm/boot/dts/omap5-l4.dtsi                    |  2 --
 arch/arm/boot/dts/r8a7743.dtsi                     | 36 +++++++++++++++----
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  1 +
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts          |  2 +-
 arch/arm/boot/dts/vf610-bk4.dts                    |  4 +--
 arch/arm/mach-iop32x/n2100.c                       |  3 +-
 arch/arm/mach-tango/pm.c                           |  6 ++--
 arch/arm/mach-tango/pm.h                           |  7 ++++
 arch/arm/mach-tango/setup.c                        |  2 ++
 arch/arm/plat-pxa/ssp.c                            |  3 --
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  2 +-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi |  3 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts      |  3 +-
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  3 +-
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  3 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   |  3 +-
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      |  3 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi  |  3 +-
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts |  3 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |  3 +-
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    |  3 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dtsi     |  3 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts     |  3 +-
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts |  3 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts |  3 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  2 +-
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          |  3 ++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  3 ++
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |  3 ++
 drivers/firmware/arm_scmi/bus.c                    |  9 +++--
 drivers/soc/fsl/qbman/qman.c                       |  9 ++---
 include/dt-bindings/clock/imx8mq-clock.h           | 26 +++++++-------
 46 files changed, 136 insertions(+), 102 deletions(-)
 create mode 100644 arch/arm/mach-tango/pm.h
