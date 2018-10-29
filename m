Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEC1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173AE2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173AE2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbeJ3GLW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:11:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38634 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeJ3GLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:11:22 -0400
Received: by mail-qt1-f194.google.com with SMTP id v1-v6so6879694qtq.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 14:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pacvYx73niW5e519aX5oXx819FWWNKykskMFZ5WyT1s=;
        b=WE5TxJdxx/PwmS4yGj3lcw8Ma/aH8ij1zeQlz2fJZyBUobGNlWBq3hB9wpYa8OKX64
         BTytc9NKDCidpEPtCV9F6P26mw6zHe7DiOsdpOlw+ol7eNEFwq00P+AhVkXkpRz3geLe
         aO08z8tjMPesO3qIppNw/IVlDpQndmhZpjV50O9OgecHXFs54cDn/1q18BtHG/A4+K5g
         M/68WLsIjT1TZLqgBeU7o06gF2ErkanGFB4MTKIx6q6e+m0AgXQ4HY8HM/0BWGmYTq7b
         vevVrGsct4vQhfqm8zPB90r/2xbNGy6cP4zX8LJJKAmf9ZLGI2Syqi3VEDxKGdJ1jXca
         zuSQ==
X-Gm-Message-State: AGRZ1gJEll9Ujj+iHA0bqGncJ/Fxr9d2BwrJaQwEa0NJpYSkFjbBO/Gk
        eHLE+mt9+ZeNRTKpH3iN8aKDHm13alaXUb1vCc0=
X-Google-Smtp-Source: AJdET5cLtJafvmmI/hAXwt3ZaTU5CE5MYfPznv7a1bovAT7bOYHQw34CXnUWa7WAi+aDkUTCZU0dDis03nj0TWRIG24=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr8234518qvm.149.1540848048405;
 Mon, 29 Oct 2018 14:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
In-Reply-To: <CAK8P3a0RbZiHCF+krpmPpmH=4yy5G57NoTDpOKE=xz1wbgy78A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 29 Oct 2018 22:20:31 +0100
Message-ID: <CAK8P3a3H9kFGmYgu=_VsZOs-LsX-zocBnGS7-dWCarw1DWhtmg@mail.gmail.com>
Subject: [GIT PULL 1/4] ARM: SoC device tree updates for 4.20
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 57361846b52bc686112da6ca5368d11210796804:

  Linux 4.19-rc2 (2018-09-02 14:37:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to be59a3282cf8e0c9c82e8835ffca98dfd2cd98e1:

  Merge tag 'socfpga_updates_for_v4.20_part3' of
git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux into
next/dt (2018-10-11 16:07:07 +0200)

----------------------------------------------------------------
ARM: SoC device tree updates for 4.20

There are close to 800 indivudal changesets in this branch again, which
feels like a lot. There are particularly many changes for the NVIDIA
Tegra platform this time, in fact more than it has seen in the two years
since the v4.9 merge window. Aside from this, it's been fairly normal,
with lots of changes going into Renesas R-CAR, NXP i.MX, Allwinner Sunxi,
Samsung Exynos, and TI OMAP.

Most of the changes are for adding new features into existing boards,
for brevity I'm only mentioning completely new machines and SoCs here.
For the first time I think we have (slightly) more new 64-bit hardware
than 32-bit:

Two boards get added for TI OMAP: Moxa UC-2101 is an industrial
computer, see https://www.moxa.com/product/UC-2100.htm; GTA04A5
is a minor variation of the motherboards of the GTA04 phone, see
https://shop.goldelico.com/wiki.php?page=GTA04A5

Clearfog is a nice little board for quad-core
Marvell Armada 8040 network processor, see
https://www.solid-run.com/marvell-armada-family/clearfog-gt-8k/

Two additional server boards come with the Aspeed baseboard management
controllers: Stardragon4800 is an arm64 reference platform made by HXT
(based on Qualcomm's server chips), and TiogaPass is an Open Compute
mainboard with x86 CPUs. Both use the ARM11 based AST2500 chips in
the BMC.

NXP i.MX usually sees a lot of new boards each release. This time there
we only add one minor variant: ConnectCore 6UL SBC Pro uses the same
SoM design as the ConnectCore 6UL SBC Express added later. However,
there is a new chip, the i.MX6ULZ, which is an even smaller variant
of the i.MX6ULL, with features removed. There is also support for the
reference board design, the i.MX6ULZ 14x14 EVK.

A new Raspberry Pi variant gets added, this one is the CM3 compute module
based on bcm2837, it was launched in early 2017 but only now added to
the kernel, both as 32-bit and as 64-bit files, as we tend to do for
Raspberry Pi.

On the Allwinner side, everything is again about cheap development
boards, usually of the "Fruit Pi" variety. The new ones this time
are:
Orange Pi Zero Plus2: http://www.orangepi.org/OrangePiZeroPlus2/
Orange Pi One Plus: http://www.orangepi.org/OrangePiOneplus/
Pine64 LTS: https://www.pine64.org/?product=pine-a64-lts
Banana Pi M2+ H5: http://www.banana-pi.org/m2plus.html
The last one of these is now a 64-bit version of the earlier Banana
Pi M2+ H3, with the same board layout.

Similarly, for Rockchips, get get another variant of the 32-bit
Asus Tinker board, the model 'S' based on rk3288, and three now
boards based on the popular RK3399 chip:
ROC-RK3399-PC: https://libre.computer/products/boards/roc-rk3399-pc/
Rock960: https://www.96boards.org/product/rock960/
RockPro64: https://www.pine64.org/?page_id=61454
These are all quite powerful boards with lots of RAM and I/O, and
the RK3399 is the same chip used in several Chromebooks.  Finally,
we get support for the PX30 (aka rk3326) chip, which is based on the
low-end 64-bit Cortex-A35 CPU core. So far, only the evaluation board
is supported.

One more Banana Pi is added with a Mediatek chip: Banana Pi R64 is based
on the MT7622 WiFi router platform, and the first product I've seen with
a 64-bit Mediatek chip in that market: http://www.banana-pi.org/r64.html

For HiSilicon, we gain support for the Hi3670 SoC and HiKey 370
development board, which are similar to the Hi3660 and Hikey 360
respectively, but add support for an NPU.

Amlogic gets initial support for the Meson-G12A chip (S905D2),
another quad-core Cortex-A53 SoC, and its evaluation platform.
On the 32-bit side, we gain support for an actual end-user product,
the Endless Computers Endless Mini based on Meson8b (S805), see
https://endlessos.com/computers/

Qualcomm adds support for their MSM8998 SoC and evaluation platform. This
chip is commonly known as the Snapdragon 835, and is used in high-end
phones as well as low-end laptops.

For Renesas, a very bare support for the r8a774a1 (RZ/G2M) is added,
but no boards for this one. However, we do add boards for the previously
added r8a77965 (R-Car M3-N): the M3NULCB Kingfisher and the M3NULCB
Starter Kit Pro.

While we have lots of DT changes for NVIDIA to update the existing files,
the only board that gets added is the Toradex Colibri T20 on Colibri
Evaluation Board for the old Tegra2.

Synaptics add support for their AS370 SoC, which is part of the (formerly
Marvell) Berlin line of set-top-box chips used e.g.  in the various Google
Chromecast. Only the .dtsi gets added at this point, no actual machines.

----------------------------------------------------------------
Aapo Vienamo (16):
      dt-bindings: Add Tegra PMC pad configuration bindings
      arm64: dts: Add Tegra210 sdmmc pinctrl voltage states
      arm64: dts: Add Tegra186 sdmmc pinctrl voltage states
      arm64: dts: tegra210-p2180: Allow ldo2 to go down to 1.8 V
      arm64: dts: tegra210-p2180: Correct sdmmc4 vqmmc-supply
      arm64: dts: tegra210-p2597: Remove no-1-8-v from sdmmc1
      arm64: dts: tegra210: Add sdmmc pad auto calibration offsets
      arm64: dts: tegra186: Add sdmmc pad auto calibration offsets
      arm64: dts: tegra210: Add SDHCI tap and trim values
      arm64: dts: tegra186: Add SDHCI tap and trim values
      arm64: dts: tegra210: Assign clocks for sdmmc1 and sdmmc4
      arm64: dts: tegra186: Assign clocks for sdmmc1 and sdmmc4
      arm64: dts: tegra210: Add SDMMC4 DQS trim value
      arm64: dts: tegra186: Add SDMMC4 DQS trim value
      arm64: dts: tegra210: Enable HS400
      arm64: dts: tegra186: Enable HS400

Adam Ford (2):
      ARM: dts: am3517-evm: Add support for UI board and Audio
      ARM: dts: da850-evm: Enable tca6416 on baseboard

Akash Gajjar (1):
      arm64: dts: rockchip: add initial dts support for Rockpro64

Alan Tull (1):
      arm64: dts: stratix10: i2c clock running out of spec

Alex Gonzalez (1):
      ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro

Amelie Delaunay (1):
      ARM: dts: stm32: update rtc st,syscfg property on stm32h743

Andre Przywara (9):
      arm64: dts: allwinner: a64: Add L2 cache nodes
      arm64: dts: allwinner: a64: Add Pine64-LTS device tree file
      arm64: dts: allwinner: a64: Olinuxino: fix DRAM voltage
      arm64: dts: allwinner: a64: Olinuxino: add Ethernet nodes
      arm64: dts: allwinner: a64: Olinuxino: enable USB
      arm64: dts: allwinner: a64: NanoPi-A64: Fix DCDC1 voltage
      arm64: dts: allwinner: a64: NanoPi-A64: Add Ethernet
      arm64: dts: allwinner: a64: NanoPi-A64: Add Wifi chip
      arm64: dts: allwinner: a64: NanoPi-A64: Add blue status LED

Andreas Färber (3):
      ARM: dts: owl: Convert to new-style SPDX license identifiers
      arm64: dts: actions: Convert to new-style SPDX license identifiers
      Merge branch 'v4.20/s900-sps-bindings' into v4.20/dt64

Andreas Kemnade (2):
      ARM: dts: gta04: add serial console wakeup irq
      ARM: dts: omap3-gta04: add pulldown/up settings for twl4030 gpio

Andrew F. Davis (3):
      ARM: dts: am571x-idk: Add tricolor Industrial LED support
      ARM: dts: am572x-idk: Add tricolor Industrial LED support
      ARM: dts: am571x-idk: Add Industrial input load trigger

Andrew Lunn (1):
      ARM: dts: vf610-zii-cfu1: Add SFF interface to switch

Andrzej Hajda (5):
      ARM: dts: exynos: Add DSI node on Exynos5250
      ARM: dts: exynos: Add DSI and panel nodes on Arndale
      ARM: dts: exynos: Use i2c-gpio for HDMI-DDC on Arndale
      ARM: dts: exynos: Fix HDMI-HPD line handling on Arndale
      arm64: dts: exynos: Add OF graph between USB-PHY and MUIC

Andy Gross (2):
      Revert "dt-bindings: iio: vadc: Fix documentation of 'reg'"
      Revert "dt-bindings: thermal: qcom-spmi-temp-alarm: Fix
documentation of 'reg'"

Anson Huang (16):
      ARM: dts: imx6sll: add gpio-ranges property
      ARM: dts: imx7ulp: update pinfunc header file
      ARM: dts: imx7s: remove snvs_poweroff node
      ARM: dts: imx6sll: add gpio clocks
      ARM: dts: imx6ull-14x14-evk: correct machine model name
      dt-bindings: arm: add missing compatible for i.MX boards
      ARM: dts: imx7d-sdb: enable gpio buttons as wakeup source
      ARM: dts: imx6sx-sdb: enable gpio buttons as wakeup source
      ARM: dts: imx7s: enable cpuidle driver
      ARM: dts: imx6ull: update iomux header
      ARM: dts: imx6qdl-sabreauto: add gpio keys support
      ARM: dts: imx6qdl-sabreauto: add egalax touch screen support
      ARM: dts: imx6ull: update vdd_soc voltage for 900MHz operating point
      ARM: dts: imx6ul: use nvmem-cells for cpu speed grading
      dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK board
      ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support

Antoine Tenart (2):
      arm64: dts: marvell: armada-cp110: change the PPv2 IRQ names
      arm64: dts: marvell: armada-cp110: describe more PPv2 interrupts

Arnd Bergmann (39):
      Merge tag 'zynq-dt-for-v4.20' of
https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'realview-dts-v4.20' of
git://git.kernel.org/.../linusw/linux-integrator into next/dt
      Merge tag 'berlin64-dt-for-v4.20' of
git://git.kernel.org/.../jszhang/linux-berlin into next/dt
      Merge tag 'amlogic-dt' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'amlogic-dt64-2' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'pxa-dt-4.20' of https://github.com/rjarzmik/linux into next/dt
      Merge tag 'tegra-for-4.20-dt-bindings' of
git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.20-arm-dt' of
git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.20-arm64-dt' of
git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'renesas-arm64-dt2-for-v4.20' of
git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-arm-dt2-for-v4.20' of
git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-bindings-for-v4.20' of
git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'sunxi-h3-h5-for-4.20' of
git://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt-for-4.20' of
git://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt64-for-4.20' of
git://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'v4.19-next-dts64' of
git://git.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'actions-arm-dt-for-4.20' of
git://git.kernel.org/.../afaerber/linux-actions into next/dt
      Merge tag 'actions-arm64-dt-for-4.20' of
git://git.kernel.org/.../afaerber/linux-actions into next/dt
      Merge tag 'qcom-arm64-for-4.20' of
git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'qcom-dts-for-4.20' of
git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'imx-dt-4.20' of
git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx-dt64-4.20' of
git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'mvebu-dt-4.20-1' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'mvebu-dt64-4.20-1' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'omap-for-v4.20/dt-signed-v2' of
git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'omap-for-v4.20/dt-signed-part2' of
git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'v4.20-rockchip-dts64-2' of
git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.20-rockchip-dts32-1' of
git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.19-next-dts32' of
git://git.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'at91-4.20-dt2' of git://git.kernel.org/.../at91/linux
into next/dt
      Merge tag 'uniphier-dt-v4.20' of
git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'amlogic-dt64-3' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'davinci-for-v4.20/dt' of
git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'mvebu-dt64-4.20-2' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'mvebu-dt-4.20-2' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'v4.19-next-dts32-2' of
git://git.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'samsung-dt-4.20-3' of
git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt64-4.20' of
git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'socfpga_updates_for_v4.20_part3' of
git://git.kernel.org/.../dinguyen/linux into next/dt

Baruch Siach (3):
      ARM: dts: clearfog: fix sdhci supply property name
      arm64: dts: add support for SolidRun Clearfog GT 8K
      arm64: dts: clearfog-gt-8k: add PCIe slot description

Biju Das (19):
      ARM: dts: r8a77470: Use r8a77470-sysc binding definitions
      ARM: dts: r8a77470: Add PFC support
      ARM: dts: iwg23s-sbc: Add pinctl support for scif1
      ARM: dts: r8a77470: Add GPIO support
      ARM: dts: iwg23s-sbc: specify EtherAVB PHY IRQ
      dt-bindings: arm: Document RZ/G2M SoC DT bindings
      arm64: dts: renesas: Initial r8a774a1 SoC device tree
      arm64: dts: renesas: r8a774a1: Add SYS-DMAC controller nodes
      arm64: dts: renesas: r8a774a1: Add INTC-EX device node
      arm64: dts: renesas: r8a774a1: Add RWDT node
      arm64: dts: renesas: r8a774a1: Add I2C and IIC-DVFS support
      arm64: dts: renesas: r8a774a1: Add RZ/G2M thermal support
      arm64: dts: renesas: r8a774a1: Add all MSIOF nodes
      arm64: dts: renesas: r8a774a1: Add Cortex-A53 CPU cores
      arm64: dts: renesas: r8a774a1: Add audio support
      arm64: dts: renesas: r8a774a1: Add USB2.0 phy and
host(EHCI/OHCI) device nodes
      arm64: dts: renesas: r8a774a1: Add USB-DMAC and HSUSB device nodes
      arm64: dts: renesas: r8a774a1: Add USB3.0 device nodes
      ARM: dts: iwg20d-q7-common: Move pciec node out of common dtsi

Bjorn Andersson (10):
      arm64: dts: qcom: msm8998: Add RPM and regulators for MTP
      arm64: dts: qcom: msm8998: Add tsens and thermal-zones
      arm64: dts: qcom: msm8998: Add pmi8998 file
      arm64: dts: qcom: msm8998: Add smem related nodes
      arm64: dts: qcom: msm8998: Add firmware node
      arm64: dts: qcom: msm8998: Add the qfprom node
      arm64: dts: qcom: msm8998: Add smp2p nodes
      arm64: dts: qcom: Populate pm8998 with additional nodes
      arm64: dts: qcom: sdm845: Add adsp, cdsp and slpi smp2p
      arm64: dts: msm8996: Transition smp2p and smd to mailbox

Brian Masney (3):
      ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for mpu6515
      ARM: dts: qcom: msm8974-hammerhead: add device tree bindings for
ALS / proximity
      ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value

Cedric Roux (3):
      ARM: s3c24xx: formatting cleanup in mach-mini2440.c
      ARM: s3c24xx: Correct SD card write protect detection on Mini2440
      ARM: s3c24xx: Restore proper usage of pr_info/pr_cont

Chen-Yu Tsai (9):
      arm64: dts: allwinner: a64: Split out data strobe pin from mmc2 pinmux
      arm64: dts: allwinner: a64: Rename uart0_pins_a label to uart0_pb_pins
      arm64: dts: allwinner: a64: Rename r_i2c_pins_a label to r_i2c_pl89_pins
      arm64: dts: rockchip: Enable SPI NOR flash on Rock64
      arm64: dts: allwinner: h5: Add device node for Mali-450 GPU
      ARM: dts: sun8i: h3: bpi-m2-plus: Fix address for external RGMII
Ethernet PHY
      ARM: dts: sun8i: h3: Split out non-SoC-specific parts of Bananapi M2 Plus
      arm64: dts: allwinner: h5: Add device tree for Bananapi M2 Plus H5
      ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees

Chris Brandt (1):
      dt-bindings: arm: Document RZ/A2 SoC DT bindings

Chris Packham (6):
      ARM: dts: mvebu: 98dx3236: Rename nand controller node
      ARM: dts: mvebu: db-dxbc2: use new style nand binding
      ARM: dts: mvebu: db-xc3-24g4: use new style nand binding
      ARM: dts: mvebu: Add device tree for db-88f6820-amc board
      ARM: dts: mvebu: add "marvell,prestera" to PP nodes
      ARM: dts: mvebu: armada-385-db-88f6820-amc: auto-detect nand ECC
properites

Christian Hewitt (1):
      arm64: dts: meson-gx: increase default shared CMA pool size

Christian Lamparter (1):
      ARM: dts: qcom: ipq4019: fix cpu0's qcom,saw2 reg value

Christophe Priouzeau (1):
      ARM: dts: stih410: change syntax of multiple DAI

Codrin Ciubotariu (1):
      ARM: dts: at91: sama5d2: add I2S clock muxing nodes

Corentin Labbe (2):
      ARM: dts: sun8i: r40: add sata node
      ARM: dts: sun8i: sun8i-r40-bananapi-m2-ultra: enable AHCI

Cyrille Pitchen (2):
      ARM: dts: at91: sama5d2: add nodes for I2S controllers
      ARM: dts: at91: sama5d2 Xplained: add pin muxing for I2S

David Lechner (1):
      ARM: dts: da850-lego-ev3: slow down A/DC as much as possible

David Summers (2):
      ARM: dts: rockchip: move shared tinker-board nodes to a common dtsi
      ARM: dts: rockchip: add rk3288-based Tinker board S

Diego Rondini (1):
      ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3 support

Dien Pham (1):
      arm64: dts: renesas: r8a77965: Add OPPs table for cpu devices

Dinh Nguyen (6):
      ARM: dts: arria10: update NAND clocking
      ARM: dts: socfpga: update NAND clocking for c5/a5
      ARM: dts: socfpga: Fix I2C bus unit-address error
      ARM: dts: socfpga: add timer resets for SoCFPGA platform
      arm64: dts: stratix10: add ethernet aliases
      ARM: dts: socfgpa: remove ethernet aliases from dtsi

Douglas Anderson (2):
      arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
      arm64: dts: qcom: sdm845-mtp: Add nodes for USB

Emmanuel Vadot (2):
      arm64: dts: allwinner: a64: Add SID node
      nvmem: sunxi-sid: add support for H5's SID controller

Esben Haabendal (1):
      ARM: dts: ls1021a: Enable I2C DMA support

Eugen Hristev (4):
      ARM: dts: at91: sama5d2: add channel cells for ADC device
      ARM: dts: at91: sama5d2: Add resistive touch device
      ARM: dts: at91: sama5d4: add labels to soc dtsi for derivative boards
      ARM: dts: at91: sama5d27_som1_ek: add adc regulators

Eugeniu Rosca (4):
      dt-bindings: arm: Document Renesas R-Car M3-N-based ULCB board
      arm64: dts: renesas: r8a77965: Add CAN{0,1} placeholder nodes
      arm64: dts: renesas: r8a77965: m3nulcb: Initial device tree
      arm64: dts: renesas: r8a77965: m3nulcb-kf: Initial device tree

Fabio Estevam (13):
      ARM: dts: imx51-babbage: Add MC13892 ADC support
      ARM: dts: imx6ul: Enable the PMU node
      ARM: dts: imx51: Add label for VPU node
      ARM: dts: imx51-zii-scu3-esb: Disable VPU
      ARM: dts: imx51-zii-scu2-mezz: Disable VPU
      ARM: dts: imx51-zii-scu2-mezz: Disable the internal watchdog
      ARM: dts: vf610-zii-cfu1: Pass the 'no-sdio' property
      ARM: dts: vf610-zii-cfu1: Pass the 'no-sd' property
      ARM: dts: imx51-zii-rdu1: Fix the rtc compatible string
      ARM: dts: imx6qdl-zii-rdu2: Disable the internal RTC
      ARM: dts: vf: Switch to SPDX identifier
      ARM: dts: vf610-twr: Switch to SPDX identifier
      ARM: dts: imx53-ppd: Remove 'num-chipselects' property

Fabrizio Castro (12):
      dt-bindings: arm: Document RZ/G2E SoC DT bindings
      arm64: dts: renesas: r8a774a1: Add SCIF and HSCIF nodes
      arm64: dts: renesas: r8a774a1: Add Ethernet AVB node
      arm64: dts: renesas: r8a774a1: Add pinctrl device node
      arm64: dts: renesas: r8a774a1: Add GPIO device nodes
      arm64: dts: renesas: r8a774a1: Add SDHI nodes
      arm64: dts: renesas: r8a774a1: Add IPMMU device nodes
      arm64: dts: renesas: r8a774a1: Add PWM device nodes
      arm64: dts: renesas: r8a774a1: Add FCPF and FCPV instances
      ARM: dts: r8a77470: Add SMP support
      ARM: dts: r8a77470: Add SDHI2 support
      ARM: dts: r8a77470: Add I2C4 support

Florian Fainelli (4):
      ARM: dts: NSP: Enable SFP on bcm958625hr
      dt-bindings: net: dsa: Document B53 SRAB interrupts and registers
      ARM: dts: NSP: Wire up switch interrupts
      Merge tag 'tags/bcm2835-dt-next-2018-09-09' into devicetree/next

Frank Rowand (6):
      ARM: dts: qcom-msm8974: use named constant for interrupt type GIC_PPI
      ARM: dts: qcom-msm8974: use named constant for interrupt type GIC_SPI
      ARM: dts: qcom-msm8974: use named constant for interrupt flag EDGE RISING
      ARM: dts: qcom-msm8974: use named constant for interrupt flag LEVEL HIGH
      ARM: dts: qcom-msm8974: use named constant for interrupt flag NONE
      ARM: dts: qcom-msm8974: change invalid flag IRQ NONE to valid value

Geert Uytterhoeven (15):
      ARM: dts: rcar: Correct SATA device sizes to 2 MiB
      ARM: dts: r9a06g032: Use r9a06g032-sysctrl binding definitions
      arm64: dts: renesas: Fix whitespace around assignments
      arm64: dts: renesas: v3hsk: Move lvds0 node
      arm64: dts: renesas: r8a77965: Move timer node
      arm64: dts: renesas: r8a77965: Fix HS-USB compatible
      arm64: dts: renesas: r8a77965: Fix clock/reset for usb2_phy1
      arm64: dts: renesas: salvator-xs: Improve SATA switch settings comments
      arm64: dts: renesas: r8a77990: Use CPG/MSSR and SYSC binding definitions
      arm64: dts: renesas: r8a7795: Move arm_cc630p node
      arm64: dts: renesas: r8a77990: Add all MSIOF nodes
      arm64: dts: renesas: draak: Sort device nodes
      arm64: dts: renesas: Remove unneeded status from thermal nodes
      ARM: dts: ux500: Correct SCU unit address
      dt-bindings: arm: scu: Correct example SCU unit addresses

Gregory CLEMENT (1):
      arm64: dts: marvell: Add node labels for the cpus

Grygorii Strashko (27):
      ARM: dts: am335x-evm: fix number of cpsw
      ARM: dts: am335x-shc: get rid of phy_id property
      ARM: dts: am335x-pepper: get rid of phy_id property
      ARM: dts: am335x-pdu001: get rid of phy_id property
      ARM: dts: am335x-nano: get rid of phy_id property
      ARM: dts: am335x-moxa-uc-8100-me-t: get rid of phy_id property
      ARM: dts: am335x-lxm: get rid of phy_id property
      ARM: dts: am335x-igep0033: get rid of phy_id property
      ARM: dts: am335x-evmsk: get rid of phy_id property
      ARM: dts: am335x-cm-t335: get rid of phy_id property
      ARM: dts: am335x-chiliboard: get rid of phy_id property
      ARM: dts: am335x-bone-common: get rid of phy_id property
      ARM: dts: am43x-epos-evm: get rid of phy_id property
      ARM: dts: am437x-sk-evm: get rid of phy_id property
      ARM: dts: am437x-idk-evm: get rid of phy_id property
      ARM: dts: am437x-gp-evm: get rid of phy_id property
      ARM: dts: am437x-cm-t43: get rid of phy_id property
      ARM: dts: dra76-evm: get rid of phy_id property
      ARM: dts: dra72-evm: get rid of phy_id property
      ARM: dts: dra72-evm-revc: get rid of phy_id property
      ARM: dts: dra71-evm: get rid of phy_id property
      ARM: dts: dra7-evm: get rid of phy_id property
      ARM: dts: am57xx-idk-common: get rid of phy_id property
      ARM: dts: am57xx-cl-som-am57x: get rid of phy_id property
      ARM: dts: dm8148-evm: get rid of phy_id property
      ARM: dts: dm8148-t410: get rid of phy_id property
      ARM: dts: dra62x-j5eco-evm: get rid of phy_id property

H. Nikolaus Schaller (34):
      ARM: dts: omap3-gta04: fix typo in backlight pins node name
      ARM: dts: omap3-gta04: fix some whitespace and tab style errors
      ARM: dts: omap3-gta04: give spi_lcd node a label so that we can
overwrite in other DTS files
      ARM: dts: omap3-gta04: fixes for tvout / venc
      ARM: dts: omap3-gta04: add devconf1 setup for correct tvout pins
      ARM: dts: omap3-gta04: tvout: enable as display1 alias
      ARM: dts: omap3-gta04: fix touchscreen tsc2007
      ARM: dts: omap3-gta04: add pinmux for bmp085 EOC interrupt
      ARM: dts: omap3-gta04: make NAND partitions compatible with recent U-Boot
      ARM: dts: omap3-gta04: update gpmc NAND setup
      ARM: dts: omap3-gta04: keep vpll2 always on
      ARM: dts: omap3-gta04: add a comment how to reference the tca6507 gpio
      ARM: dts: omap3-gta04: add warning comment to vaux2 regulator
      ARM: dts: omap3-gta04: explicitly describe that mmc1 has no CD/WP
      ARM: dts: omap3-gta04: make use of input event include file and constants
      ARM: dts: omap3-gta04: map antenna detect GPIO to
SW_LINEIN_INSERT key event
      ARM: dts: omap3-gta04: add camera interface parallel port
      ARM: dts: omap3-gta04: add camera pinmux
      ARM: dts: omap3-gta04: add mcbsp (audio subsystem) pinmux
      ARM: dts: omap3-gta04: add devconf0 setup for mcbsp1 clock pins
      ARM: dts: omap3-gta04: add mcbsp (audio subsystem) nodes
      ARM: dts: omap3-gta04a3: fix model name for A3 variant
      ARM: dts: omap3-gta04a4: fix model name for A4 variant
      ARM: dts: omap3-gta04a5: fix copyright of A5 variant
      ARM: dts: omap3-gta04a5: fix model name
      ARM: dts: omap3-gta04a5: fix whitepsace and tab style
      ARM: dts: omap3-gta04a5: add support for PPS
      ARM: dts: omap3-gta04a5: disable IrDA receiver to save power
      ARM: dts: omap3-gta04a5: add support for ti,wl1837 module
      ARM: dts: omap3-gta04a5: uses different sensors than gta04a4
      ARM: dts: omap3-gta04a5: define pinmux for bluetooth enable of
ti,wl1837 module
      ARM: dts: omap3-gta04a5one: define GTA04A5 variant with OneNAND
      ARM: dts: add omap3-gta04a5one to Makefile
      ARM: dts: omap5: enable OTG role for DWC3 controller

Hans Verkuil (1):
      ARM: dts: am335x-boneblack: add cec support

Heiko Stuebner (8):
      ARM: dts: rockchip: add rk3188 lcd controller nodes
      arm64: dts: rockchip: add dwc2 otg controller on px30
      arm64: dts: rockchip: enable dwc2-based otg controller on px30-evb
      ARM: dts: rockchip: explicitly set vcc_sd0 pin to gpio on rk3188-radxarock
      arm64: dts: rockchip: add missing address and size cells for
rk3399 mipi dsi
      arm64: dts: rockchip: add Innosilicon hdmi phy node to rk3328
      arm64: dts: rockchip: add rk3328 display nodes
      arm64: dts: rockchip: enable display nodes on rk3328-rock64

Hoan Nguyen An (1):
      arm64: dts: r8a77965: add FDP1 device nodes

Icenowy Zheng (1):
      arm64: dts: allwinner: h6: add system controller device tree node

Jacopo Mondi (3):
      ARM: dts: imx6qdl: Add Engicam i.Core 1.5 MX6
      ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core MX6
      arm64: dts: renesas: ebisu: Add HDMI and CVBS input

Jagan Teki (6):
      ARM: dts: imx: Switch Engicam boards to use SPDX identifier
      ARM: dts: imx6ul-isiot: Move node definitions into dtsi
      ARM: dts: i.MX6: Use consistent node names for Engicam files
      arm64: dts: allwinner: h6: Add OrangePi One Plus initial support
      arm64: dts: allwinner: a64: Add display pipeline
      arm64: dts: allwinner: a64: Enable HDMI output on A64 boards w/ HDMI

Jay Foster (1):
      ARM: dts: at91/trivial: Fix USART1 definition for at91sam9g45

Jerome Brunet (10):
      arm64: dts: meson-axg: add audio fifos
      arm64: dts: meson-axg: s400: enable audio devices
      arm64: dts: meson-axg: s400: add sound card
      arm64: dts: meson-axg: sort nodes consistently
      arm64: dts: meson: libretech: update board model
      arm64: dts: meson-axg: add pdm
      arm64: dts: meson-axg: s400: add dmic codec
      arm64: dts: meson-axg: s400: add pdm to the sound card
      arm64: dts: meson-axg: s400: add missing emmc pwrseq
      arm64: dts: meson-axg: s400: disable emmc

Jianxin Pan (2):
      dt-bindings: arm: amlogic: Add Meson G12A binding
      arm64: dts: meson-g12a: add initial g12a s905d2 SoC DT support

Jisheng Zhang (3):
      dt-bindings: arm: move berlin binding documentation to syna.txt
      dt-bindings: arm: syna: add support for the AS370 SoC
      arm64: dts: synaptics: add dtsi file for Synaptics AS370 SoC

John Crispin (1):
      ARM: dts: qcom: ipq4019: fix space vs tab indenting inside
qcom-ipq4019.dtsi

Joonwoo Park (1):
      arm64: dts: Add msm8998 SoC and MTP board support

Katsuhiro Suzuki (2):
      arm64: dts: rockchip: fix vcc_host1_5v pin assign on rk3328-rock64
      arm64: dts: rockchip: add spdif sound node for rock64

Keerthy (1):
      ARM: dts: am57xx-idk-common: Hook smps12 regulator as cpu vdd-supply

Kieran Bingham (2):
      arm64: dts: renesas: salvator-common: adv748x: Override
secondary addresses
      arm64: dts: renesas: r8a77995: Add LVDS support

Kishon Vijay Abraham I (1):
      arm64: dts: ti: k3-am65: Change #address-cells and #size-cells
of interconnect to 2

Koji Matsuoka (1):
      arm64: dts: renesas: r8a77990: Add VIN and CSI-2 device nodes

Krzysztof Kozlowski (13):
      ARM: dts: s5pv210: Switch to S5Pv210 specific pinctrl wakeup compatible
      ARM: dts: exynos: Add missing used PMIC regulators on Exynos5422
Odroid boards
      ARM: dts: exynos: Add unused PMIC regulators on Exynos5422 Odroid boards
      ARM: dts: exynos: Disable unused PMIC regulators on Exynos5422
Odroid boards
      ARM: dts: exynos: Add LDO28 regulator on Exynos5422 Odroid boards
      ARM: exynos: Store Exynos5420 register state in one variable
      ARM: exynos: Fix imprecise abort during Exynos5422 suspend to RAM
      ARM: s3c24xx: Remove empty gta02_pmu children probe
      ARM: dts: exynos: Remove double SD card detect pin inversion
      ARM: s3c24xx: Consistently use tab for indenting member assignments
      arm64: ARM: dts: exynos: Remove double SD card detect pin inversion on TM2
      ARM: tegra: tegra20: Fix mixed tabs-spaces indentation
      ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU

Kunihiko Hayashi (7):
      ARM: dts: uniphier: add SPI pin-mux node
      ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
      arm64: dts: uniphier: add SPI node for LD20, LD11 and PXs3
      ARM: dts: uniphier: Add USB3 controller nodes
      ARM: dts: uniphier: Add USB2 PHY nodes
      arm64: dts: uniphier: Add USB3 controller nodes
      arm64: dts: uniphier: Add USB2 PHY nodes

Kuninori Morimoto (1):
      arm64: dts: renesas: ulcb: add default bootargs

Kurt Kanzenbach (1):
      arm64: dts: ls208xa: add second duart

Laurent Pinchart (4):
      ARM: dts: rcar-gen2: Convert to new DU DT bindings
      arm64: dts: renesas: Convert to new LVDS DT bindings
      arm64: dts: renesas: r8a77990: Add display output support
      arm64: dts: renesas: r8a77990: ebisu: Enable VGA and HDMI outputs

Leilk Liu (1):
      arm64: dts: Add spi slave dts

Levin Du (4):
      arm64: dts: rockchip: add support for ROC-RK3399-PC board
      arm64: dts: rockchip: add io-domain to roc-rk3328-cc
      arm64: dts: rockchip: add GRF GPIO controller to rk3328
      arm64: dts: rockchip: add sdmmc UHS support for roc-rk3328-cc

Liang Chen (4):
      dt-bindings: rockchip: grf: add grf and pmugrf description for px30
      arm64: dts: rockchip: add core dtsi file for PX30 SoCs
      arm64: dts: rockchip: add PX30 evaluation board devicetree
      dt-bindings: usb: dwc2: add description for px30

Linus Walleij (3):
      ARM: dts: ux500: Fix LCDA clock line muxing
      ARM: dts: ux500: Get rid of DTC warnings
      ARM: dts: ux500: Mark PRCMU as syscon compatible

Liviu Dudau (1):
      arm64: dts: broadcom: Use the .dtb name in the rule, rather than .dts

Magnus Damm (8):
      ARM: dts: Include R-Car Gen1 product name in DTSI files
      arm64: dts: renesas: Include R-Car product name in DTSI files
      arm64: dts: renesas: r8a77995: Attach the SYS-DMAC to the IPMMU
      arm64: dts: renesas: r8a77965: Attach the SYS-DMAC to the IPMMU
      arm64: dts: renesas: r8a77990: Attach the SYS-DMAC to the IPMMU
      arm64: dts: renesas: r8a77980: Attach the SYS-DMAC to the IPMMU
      ARM: dts: Include R-Car Gen2 product name in DTSI files
      ARM: dts: R-Car Gen1 board comment update

Manivannan Sadhasivam (18):
      dt-bindings: arm: hisilicon: Add binding for Hi3670 SoC
      arm64: dts: Add devicetree for Hisilicon Hi3670 SoC
      dt-bindings: arm: hisilicon: Add binding for HiKey970 board
      arm64: dts: Add devicetree support for HiKey970 board
      arm64: dts: rockchip: Split out common nodes for Rock960 based boards
      dt-bindings: arm: rockchip: Add binding for Rock960 board
      arm64: dts: rockchip: Add support for Rock960 board
      arm64: dts: rockchip: Enable SD card detection for Rock960 boards
      dt-bindings: power: Add Actions Semi S900 SPS
      arm64: dts: actions: s900: Add Clock Management Unit nodes
      arm64: dts: actions: s900: Source CMU clock for UARTs
      arm64: dts: actions: s900: Add SPS node
      arm64: dts: actions: s900: Add pinctrl node
      arm64: dts: actions: s900: Add gpio properties to pinctrl node
      arm64: dts: actions: s900-bubblegum-96: Add gpio line names
      arm64: dts: actions: s900: Add I2C controller nodes
      arm64: dts: actions: s900-bubblegum-96: Enable I2C1 and I2C2
      arm64: dts: actions: s900: Add DMA Controller

Manu Gautam (1):
      arm64: dts: qcom: sdm845: Add USB-related nodes

Marc Dietrich (1):
      ARM: dts: paz00: fix wakeup gpio keycode

Marcel Ziswiler (128):
      ARM: dts: pxa: fix power i2c base address
      ARM: dts: tegra30: fix xcvr-setup-use-fuses
      ARM: dts: tegra20: restore address order
      ARM: dts: tegra20/tegra30: add pmu interrupt-affinity
      ARM: tegra: apalis_t30: fix mmc1 cmd pull-up
      ARM: tegra: apalis_t30: pull-up sd card detect pins
      ARM: tegra: apalis_t30: add local-mac-address property
      ARM: tegra: apalis_t30: reorder pcie properties
      ARM: tegra: apalis_t30: annotate/clean-up pcie controller/port nodes
      ARM: tegra: apalis_t30: reorder host1x/hdmi properties
      ARM: tegra: apalis_t30: regulator clean-up
      ARM: tegra: apalis_t30: add missing regulators
      ARM: tegra: apalis_t30: annotate uarts and move compatible to board
      ARM: tegra: apalis_t30: drop unused cami2c label
      ARM: tegra: apalis_t30: white-space/newline clean-up
      ARM: tegra: apalis_t30: drop unused mmc1/sd1 labels
      ARM: tegra: apalis_t30: annotate mmc1/sd1
      ARM: tegra: apalis_t30: move dr_mode property from phy to controller
      ARM: tegra: apalis_t30: reorder backlight properties
      ARM: tegra: apalis_t30: drop pwmleds
      ARM: tegra: apalis_t30: pinmux clean-up
      ARM: tegra: apalis_t30: add missing pinmux
      ARM: tegra: apalis_t30: use proper irq-gpio for stmpe811
      ARM: tegra: apalis_t30: further lm95245 temperature sensor annotation
      ARM: tegra: apalis_t30: add i2c-thermtrip
      ARM: tegra: apalis_t30: add proper emmc vmmc and vqmmc supplies
      ARM: tegra: apalis_t30: enable emmc ddr52 mode
      ARM: tegra: apalis_t30: get rid of fake clocks simple bus
      ARM: tegra: apalis_t30: line break long compatible property line
      dt-bindings: add broadcom (formerly plx technology) vendor prefix
      ARM: tegra: apalis_t30: drop module level model and compatible
      ARM: tegra: apalis_t30: drop obsolete spidev nodes
      ARM: tegra: apalis_t30: hog group for pcie switch reset gpio
      ARM: tegra: apalis_t30: rename hdmiddc to hdmi_ddc
      ARM: tegra: apalis_t30: rename tps65911@2d, stmpe811@41 and tps62362@60
      ARM: tegra: apalis_t30: fix mcp2515 can controller interrupt polarity
      ARM: tegra: apalis_t30: move hda node from carrier to module
      ARM: tegra: apalis_t30: support v1.1 hardware revision
      ARM: tegra: colibri_t30: add local-mac-address property
      ARM: tegra: colibri_t30: reorder host1x/hdmi properties
      ARM: tegra: colibri_t30: regulator clean-up
      ARM: tegra: colibri_t30: add missing regulators
      ARM: tegra: colibri_t30: annotate uarts and move compatible to board
      ARM: tegra: colibri_t30: white-space clean-up
      ARM: tegra: colibri_t30: move dr_mode property from phy to controller
      ARM: tegra: colibri_t30: reorder backlight properties
      ARM: tegra: colibri_t30: drop pwmleds
      ARM: tegra: colibri_t30: pinmux clean-up
      ARM: tegra: colibri_t30: add missing pinmux
      ARM: tegra: colibri_t30: use proper irq-gpio for stmpe811
      ARM: tegra: colibri_t30: further lm95245 temperature sensor annotation
      ARM: tegra: colibri_t30: add i2c-thermtrip
      ARM: tegra: colibri_t30: add proper emmc vmmc and vqmmc supplies
      ARM: tegra: colibri_t30: enable emmc ddr52 mode
      ARM: tegra: colibri_t30: get rid of fake clocks simple bus
      ARM: tegra: colibri_t30: line break long compatible property line
      ARM: tegra: colibri_t30: move input include to carrier board
      ARM: tegra: colibri_t30: remove unused nvidia, is-wired property
      ARM: tegra: colibri_t30: add gpio hog to unreset usb ethernet chip
      ARM: tegra: colibri_t30: enable hda over hdmi
      ARM: tegra: colibri_t30: annotate sd card detect
      ARM: tegra: colibri_t30: annotate ehci instance 1
      ARM: tegra: colibri_t30: update compatibility comment
      ARM: tegra: colibri_t30: drop module level model and compatible
      ARM: tegra: colibri_t30: drop obsolete spidev node
      ARM: tegra: colibri_t30: rename hdmiddc to hdmi_ddc
      ARM: tegra: colibri_t30: rename tps65911@2d, stmpe811@41 and tps62362@60
      ARM: tegra: colibri_t30: fix mcp2515 can controller interrupt polarity
      ARM: tegra: colibri_t30: remove unused mcp2515 can0 label
      ARM: tegra: colibri_t30: add mcp2515 vdd and xceiver supplies
      ARM: tegra: colibri_t30: annotate unused i2c busses
      ARM: tegra: colibri_t30: annotate power I2C being on-module
      ARM: tegra: apalis-tk1: add local-mac-address property
      ARM: tegra: apalis-tk1: reorder host1x/hdmi properties
      ARM: tegra: apalis-tk1: reorder padctl properties
      ARM: tegra: apalis-tk1: regulator clean-up
      ARM: tegra: apalis-tk1: add missing regulators
      ARM: tegra: apalis-tk1: drop unused pinmux label
      ARM: tegra: apalis-tk1: white-space clean-up
      ARM: tegra: apalis-tk1: reorder backlight properties
      ARM: tegra: apalis-tk1: add proper emmc vmmc and vqmmc supplies
      ARM: tegra: apalis-tk1: enable emmc ddr52 mode
      ARM: tegra: apalis-tk1: add toradex, apalis-tk1-v1.2 compatible
      ARM: tegra: apalis-tk1: reorder cpu dfll clock properties
      ARM: tegra: apalis-tk1: reorder SD card properties
      ARM: tegra: apalis-tk1: drop module level model and compatible
      ARM: tegra: apalis-tk1: drop obsolete spidev nodes
      ARM: tegra: apalis-tk1: replace underscores in node names with dashes
      ARM: tegra: apalis-tk1: get rid of fake clocks simple bus
      ARM: tegra: apalis-tk1: shorten temperature-sensor node
      ARM: tegra: apalis-tk1: drop unused hdmi_ddc label
      ARM: tegra: colibri_t20: move aliases from module to carrier board
      ARM: tegra: colibri_t20: iris: integrate i2c real time clock support
      ARM: tegra: colibri_t20: iris: add missing aliases
      ARM: tegra: colibri_t20: iris: annotate i2c busses
      ARM: tegra: colibri_t20: add local-mac-address property
      ARM: tegra: colibri_t20: reorder host1x/hdmi properties
      ARM: tegra: colibri_t20: iris: use no-1-8-v
      ARM: tegra: colibri_t20: regulator clean-up
      ARM: tegra: colibri_t20: add missing regulators
      ARM: tegra: colibri_t20: annotate usb ehci instances
      ARM: tegra: colibri_t20: remove phy-reset-gpio from controller node
      ARM: tegra: colibri_t20: indentation/line-feed/white-space clean-up
      ARM: tegra: colibri_t20: update sound nvidia,model
      ARM: tegra: colibri_t20: pinmux clean-up
      ARM: tegra: colibri_t20: add missing pinmux
      ARM: tegra: colibri_t20: iris: display controller rgb panel support
      ARM: tegra: colibri_t20: iris: annotate uarts
      ARM: tegra: colibri_t20: iris: add uart-c
      ARM: tegra: colibri_t20: use high speed uart driver
      ARM: tegra: colibri_t20: iris: add gpio wakeup key
      ARM: tegra: colibri_t20: iris: add dr_mode property
      ARM: tegra: colibri_t20: annotate/rename lm95245 temperature sensor
      ARM: tegra: colibri_t20: add i2c-thermtrip
      ARM: tegra: colibri_t20: add gpio hog to unreset usb ethernet chip
      ARM: tegra: colibri_t20: add gpio hogs for gmi_wr_n buffers
      ARM: tegra: colibri_t20: annotate/move sd card detect
      ARM: tegra: colibri_t20: add compatibility comment
      ARM: tegra: colibri_t20: simplify model and compatible properties
      ARM: tegra: colibri_t20: iris: simplify model and compatible properties
      ARM: tegra: colibri_t20: iris: add colibri ssp support
      ARM: tegra: colibri_t20: drop module level model and compatible
      ARM: tegra: colibri_t20: rename i2c_ddc to hdmi_ddc
      ARM: tegra: colibri_t20: iris: drop unused i2c_ddc label
      ARM: tegra: colibri_t20: rename tps6586x@34 and drop unused pmic label
      ARM: tegra: colibri_t20: get rid of fake clocks simple bus
      ARM: tegra: colibri_t20: rename ac97 label to tegra_ac97
      ARM: tegra: colibri_t20: add eval board device tree

Marek Behún (1):
      arm64: dts: marvell: armada-37xx: add nodes to support watchdog

Marek Szyprowski (10):
      ARM: dts: exynos: Convert exynos5250.dtsi to opp-v2 bindings
      ARM: dts: exynos: Mark 1 GHz CPU OPP as suspend OPP on Exynos5250
      ARM: dts: exynos: Fix sound in Snow-rev5 Chromebook
      ARM: dts: exynos: Fix regulators configuration on Peach Pi/Pit Chromebooks
      ARM: dts: exynos: Disable pull control for MAX8997 interrupts on Origen
      ARM: dts: exynos: Add missing PMIC interrupts on UniversalC210 board
      ARM: dts: exynos: Disable pull control for S5M8767 PMIC
      ARM: dts: exynos: Disable pull control for PMIC IRQ line on Artik5 board
      ARM: dts: exynos: Add external SD card support for Trats board
      ARM: dts: exynos: Correct audio subsystem parent clock on Peach
Chromebooks

Marek Vasut (5):
      ARM: dts: gose: Add DA9210 node for CPU DVFS
      ARM: dts: silk: Add DA9063 PMIC node
      ARM: dts: silk: Add DA9063 RTC and OnKey node
      ARM: dts: stout: Add DA9063 OnKey node
      ARM: dts: socfpga: Rename socfpga_cyclone5_de0_{sockit,nano_soc}

Martin Blumenstingl (11):
      ARM: dts: meson8: fix the clock controller register size
      ARM: dts: meson8b: fix the clock controller register size
      dt-bindings: add vendor prefix for "Endless Mobile, Inc."
      dt-bindings: arm: amlogic: Add the Endless Mobile Endless Mini (EC-100)
      ARM: dts: meson8b: add the I2C_A, PWM_C and UART_B pins
      ARM: dts: meson8b: add the RMII pins
      ARM: dts: meson8b: Add support for the Endless Mini (EC-100)
      ARM: dts: meson8b: odroidc1: add the CPU voltage regulator
      ARM: dts: meson8b: odroidc1: add the fixed voltage regulators
      ARM: dts: meson8b: odroidc1: enable the SAR ADC
      ARM: dts: meson8b: odroidc1: add stdout-path property

Masahiro Yamada (4):
      ARM: uniphier: dts: add more clocks to Denali NAND controller node
      arm64: uniphier: dts: add more clocks to Denali NAND controller node
      ARM: dts: uniphier: add SD/eMMC controller nodes
      arm64: dts: uniphier: add SD controller nodes

Mathias Kresin (1):
      ARM: dts: qcom: ipq4019: fix PCI range

Matthew McClintock (2):
      ARM: dts: qcom: ipq4019: use v2 of the kpss bringup mechanism
      ARM: dts: qcom: ipq4019: add cpu operating points for cpufreq support

Matthias Brugger (4):
      dt-bindings: clock: mediatek: add support for MT7623
      dt-bindings: iommu: mediatek: Add binding for MT7623
      dt-bindings: mediatek: Add JPEG Decoder binding for MT7623
      dt-bindings: mediatek: Add bindig for MT7623 IOMMU and SMI

Matthias Kaehlcke (6):
      dt-bindings: iio: vadc: Fix documentation of 'reg'
      arm64: dts: qcom: pm8998: Add adc node
      arm64: dts: sdm845: Add dispcc node
      dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'
      arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
      arm64: dts: qcom: pm8998: Add pm8998 thermal zone

Maxime Jourdan (1):
      arm64: dts: meson-gx: add dmcbus and canvas nodes.

Miquel Raynal (7):
      arm64: dts: marvell: move AP806/CP110 thermal nodes into a new syscon
      arm64: dts: marvell: add thermal-zone node in ap806 DTSI file
      arm64: dts: marvell: add macro to make distinction between node names
      arm64: dts: marvell: add thermal-zone node in cp110 DTSI file
      arm64: dts: marvell: add AP806 SEI subnode
      arm64: dts: marvell: use new bindings for CP110 interrupts
      arm64: dts: marvell: add CP110 ICU SEI subnode

Neil Armstrong (3):
      arm64: dts: meson-axg: use the proper compatible for ethmac
      arm64: dts: meson-axg-s400: Add chosen and memory nodes
      arm64: dts: meson: Switch simple-mfd and syscon order

Nicolas Ferre (1):
      ARM: dts: at91/trivial: remove old NAND bindings leftover in sama5d2

Niklas Cassel (3):
      arm64: dts: db820c: Add qcom,apq8096 to compatible string
      arm64: dts: msm8916: Drop model and compatible
      arm64: dts: msm8996: Drop model

Nishanth Menon (3):
      arm64: dts: ti: am654: Add uart nodes
      arm64: dts: ti: am654: Add secure proxy instance for main domain
      arm64: dts: ti: k3-am6: Add Device Management Security Controller support

Oleksij Rempel (3):
      ARM: dts: imx7s: add i.MX7 messaging unit support
      dt-bindings: imx6q-clock: add new fsl,pmic-stby-poweroff property
      ARM: dts: imx6: RIoTboard provide standby on power off option

Olof Johansson (19):
      Merge tag 'socfpga_updates_for_v4.20_part1' of
git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'renesas-arm-dt-for-v4.20' of
https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-arm64-dt-for-v4.20' of
https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'v4.20-rockchip-dts64-1' of
git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'amlogic-dt64' of
https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'arm-soc/for-4.20/devicetree' of
https://github.com/Broadcom/stblinux into next/dt
      Merge tag 'arm-soc/for-4.20/devicetree-arm64' of
https://github.com/Broadcom/stblinux into next/dt
      Merge tag 'juno-updates-4.20' of
git://git.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'am654-for-v4.20' of
git://git.kernel.org/.../kristo/linux into next/dt
      Merge tag 'aspeed-4.20-devicetree' of
git://git.kernel.org/.../joel/aspeed into next/dt
      Merge tag 'ux500-dts-arm-soc' of
git://git.kernel.org/.../linusw/linux-stericsson into next/dt
      Merge tag 'stm32-dt-for-v4.20-1' of
git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'hisi-arm64-dt-for-4.20' of
git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'hisi-arm32-dt-for-4.20' of
git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'samsung-soc-4.20' of
https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'at91-4.20-dt' of git://git.kernel.org/.../at91/linux
into next/dt
      Merge tag 'sti-dt-for-v4.20-round1' of
git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'socfpga_updates_for_v4.20_part2' of
git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'samsung-dt-4.20-2' of
https://git.kernel.org/.../krzk/linux into next/dt

Patrice Chotard (5):
      ARM: dts: stm32: Add clk-lse node's label on stm32f429
      ARM: dts: stm32: Remove cd-inverted property for stm32429i-eval
      ARM: dts: stm32: Remove cd-inverted property for stm32f469-disco
      ARM: dts: stm32: Remove cd-inverted property for stm32f769-disco
      ARM: dts: stm32: Remove cd-inverted property for stm32f746-disco

Patrick Venture (3):
      ARM: dts: aspeed: quanta-q71l: add aliases for i2c
      ARM: dts: aspeed: quanta-q71l: Add four PSUs
      ARM: dts: aspeed: quanta-q71l: Enable adc & ibt nodes

Paul Kocialkowski (4):
      ARM: dts: sun5i: Add Video Engine and reserved memory nodes
      ARM: dts: sun7i-a20: Add Video Engine and reserved memory nodes
      ARM: dts: sun8i-a33: Add Video Engine and reserved memory nodes
      ARM: dts: sun8i-h3: Add Video Engine and reserved memory nodes

Peter Rosin (7):
      ARM: dts: at91: nattis: set the PRLUD and HIPOW signals low
      ARM: dts: at91: nattis: make the SD-card slot work
      ARM: dts: at91: nattis: state the actual lvds-encoder chip
      ARM: dts: at91: nattis: move pinctrls for the lvds chip to the lvds node
      ARM: dts: at91: nattis: describe the lvds panel
      ARM: dts: at91: nattis: drop three indentation levels
      ARM: dts: at91: tse850: drop three indentation levels

Phil Edworthy (1):
      ARM: dts: r9a06g032: Correct UART and add all other UARTs

Philipp Rossak (4):
      ARM: dts: sun8i: a83t: Add the cir pin for the A83T
      ARM: dts: sun8i: a83t: Add support for the cir interface
      ARM: dts: sun8i: a83t: bananapi-m3: Enable IR controller
      ARM: dts: sun8i: h3-h5: ir register size should be the whole memory block

Pierre-Jean Texier (2):
      ARM: dts: imx7s-warp: enable i2c3 device support
      ARM: dts: imx7s-warp: use SPDX-License-Identifier

Prabhakar Kushwaha (3):
      ARM: dts: Add big-endian in nor node for ls1021a
      arm64: dts: Add big-endian in nor node for ls104xa
      arm64: dts: fsl: remove big-endian field from IFC controller

Rafał Miłecki (1):
      ARM: dts: BCM5301X: Specify flash partitions

Rob Herring (20):
      arm64: dts: broadcom: Fix I2C and SPI bus warnings
      ARM: dts: bcm: Fix SPI bus warnings
      ARM: dts: aspeed: Fix I2C bus warnings
      ARM: dts: sunxi: Fix I2C bus warnings
      ARM: dts: sun9i: Fix I2C bus warnings
      arm64: dts: meson: Fix erroneous SPI bus warnings
      ARM: dts: rockchip: Fix erroneous SPI bus dtc warnings on rk3036
      arm64: dts: rockchip: Fix I2C bus unit-address error on rk3399-puma-haikou
      ARM: dts: xilinx: Fix I2C and SPI bus warnings
      ARM: dts: atmel: Fix I2C and SPI bus warnings
      ARM: dts: ti: Fix SPI and I2C bus warnings
      ARM: dts: ste: Fix SPI controller node names
      ARM: dts: marvell: Fix SPI and I2C bus warnings
      ARM: dts: stm32: Fix SPI controller node names
      ARM: dts: imx: Fix SPI bus warnings
      arm64: dts: fsl: Fix I2C and SPI bus warnings
      ARM: dts: realview: Fix SPI controller node names
      arm64: dts: amd: Fix SPI bus warnings
      arm64: dts: lg: Fix SPI controller node names
      ARM: dts: lpc32xx: Fix SPI controller node names

Robert Jarzmik (3):
      ARM: dts: pxa: change serial node names
      ARM: dts: pxa: fix the rtc controller
      ARM: dts: pxa: add pincontrol helpers

Rodrigo Exterckötter Tjäder (1):
      arm64: dts: allwinner: a64: a64-olinuxino: set the PHY TX delay

Russell King (1):
      ARM: dts: vf610-zii-dev-rev-c: add support for one SFF module

Ryder Lee (8):
      arm64: dts: mt7622: add timer, CCI-400 and PMU nodes
      arm64: dts: mt7622: add a bluetooth 5 device node
      arm64: dts: mt7622: fix ram size for rfb1
      arm64: dts: mt7622: add bananapi BPI-R64 board
      arm: dts: mt7623: add a performance counter unit device node
      arm: dts: mt7623: update subsystem clock controller device nodes
      arm: dts: mt7623: add iommu/smi device nodes
      arm: dts: mt7623: add jpeg decoder device node

SZ Lin (林上智) (2):
      ARM: dts: am335x: add common file for UC-2100 series
      ARM: dts: am335x: add support for Moxa UC-2101 open platform

Samuel Holland (9):
      arm64: dts: allwinner: a64: Orange Pi Win: Fix SD card node
      arm64: dts: allwinner: a64: Orange Pi Win: Enable USB hub regulator
      arm64: dts: allwinner: a64: Orange Pi Win: Enable USB OTG socket
      arm64: dts: allwinner: a64: Orange Pi Win: Add Ethernet node
      arm64: dts: allwinner: a64: Orange Pi Win: Add UARTs
      arm64: dts: allwinner: a64: Orange Pi Win: Add LED node
      arm64: dts: allwinner: a64: Orange Pi Win: Add SDIO node
      arm64: dts: allwinner: a64: Orange Pi Win: Add SPI flash node
      arm64: dts: allwinner: a64: Orange Pi Win: Adjust CSI power rails

Sandy Huang (1):
      arm64: dts: rockchip: add missing vop properties for px30

Saravanan Sekar (2):
      arm64: dts: actions: s700: Add Clock Management Unit
      arm64: dts: actions: s700: Set UART clock references from CMU

Sergei Shtylyov (12):
      arm64: dts: renesas: r8a77980: add RWDT support
      arm64: dts: renesas: r8a77980: add Cortex-A53 PMU support
      arm64: dts: renesas: r8a77980: move IPMMU nodes
      arm64: dts: renesas: r8a779{7|8}0: move CAN clock node
      arm64: dts: renesas: r8a77980: add CSI2/VIN support
      arm64: dts: renesas: r8a77970: add MMC support
      arm64: dts: renesas: v3msk: add eMMC support
      arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support
      arm64: dts: renesas: r8a77980: add PCIe support
      arm64: dts: renesas: condor: add PCIe support
      arm64: dts: renesas: r8a779{7|8}0: add CMT support
      arm64: dts: renesas: r8a779{7|8}0: add TPU support

Shohei Maruyama (1):
      arm64: dts: rockchip: add WiFi module support for Firefly-RK3399

Sibi Sankar (1):
      arm64: dts: qcom: Add AOSS reset driver node for SDM845

Silvan Murer (1):
      ARM: dts: socfpga: set timer interrupt to edge sensitive

Simon Goldschmidt (1):
      ARM: dts: socfpga: use stdout-path for chosen node

Sricharan R (4):
      ARM: dts: qcom: Add pcie nodes for ipq8064
      ARM: dts: qcom: Add sdcc nodes for ipq8064
      ARM: dts: qcom: Move common nodes to ipq8064-v.1.0.dtsi
      ARM: dts: qcom: Add led and gpio-button nodes to ipq8064 boards

Stefan Agner (1):
      ARM: dts: imx6q-apalis: mux RESET_MOCI# signal

Stefan Wahren (4):
      dt-bindings: bcm: Add Raspberry Pi CM3 and CM3L
      ARM: dts: add Raspberry Pi Compute Module 3 and IO board
      arm64: dts: broadcom: Add reference to Compute Module IO Board V3
      ARM: dts: bcm283x-rpi-lan7515: Enable Ethernet LEDs

Suzuki K Poulose (10):
      arm64: dts: juno: Update entries to match latest coresight bindings
      arm64: dts: juno: Enable coresight tmc scatter gather in ETR
      arm64: dts: hi6220: Update coresight bindings for hardware ports
      arm: dts: hip04: Update coresight bindings for hardware ports
      arm: dts: sama5d2: Update coresight bindings for hardware ports
      ARM: dts: omap: Update coresight bindings for hardware ports
      arm: dts: ste: Update coresight bindings for hardware port
      ARM: dts: imx7: Update coresight binding for hardware ports
      arm64: dts: msm8916: Update coresight bindings for hardware ports
      ARM: dts: qcom: Update coresight bindings for hardware ports

Sébastien Szymanski (2):
      ARM: dts: imx6ull: keep IMX6UL_ prefix for signals on both
i.MX6UL and i.MX6ULL
      ARM: dts: imx6ul: Add weim node

Takeshi Kihara (5):
      arm64: dts: renesas: r8a77965: Add SATA controller node
      arm64: dts: renesas: r8a77990: Add BRG support to SCIF2
      arm64: dts: renesas: r8a77990: Add I2C device nodes
      arm64: dts: renesas: r8a77990: Add SYS-DMAC device nodes
      arm64: dts: renesas: r8a77965: Add Sound and Audio DMAC device nodes

Thierry Reding (2):
      Merge branch 'for-4.20/dt-bindings' into for-4.20/arm64/dt
      arm64: tegra: I2C on Tegra194 is not compatible with Tegra114

Thor Thayer (2):
      ARM: dts: socfpga: Fix SDRAM node address for Arria10
      arm64: dts: stratix10: Correct System Manager register size

Tony Lindgren (2):
      Merge branch 'am335x-evm-port-fix' into omap-for-v4.20/dt
      ARM: dts: am335x: Replace remaining legacy phy_id with phy-handle

Tony Xie (1):
      arm64: dts: rockchip: Add idle-states to device tree for rk3399

Tudor Ambarus (6):
      ARM: dts: at91: sama5d4_xplained: fix addressable nand flash size
      ARM: dts: at91: at91sam9x5cm: fix addressable nand flash size
      ARM: dts: at91: sama5d2_ptc_ek: fix bootloader env offsets
      ARM: dts: at91: at91sam9x5cm: even nand memory partitions
      ARM: dts: at91: sama5d3_xplained: even nand memory partitions
      ARM: dts: at91: sama5d4_xplained: even nand memory partitions

Tuomas Tynkkynen (3):
      arm64: dts: allwinner: Don't use cd-inverted in sun50i-a64-pinebook
      ARM: dts: sunxi: Don't use cd-inverted in sun8i-r40-bananapi-m2-ultra
      ARM: dts: imx6qdl-wandboard: Add stdout-path

Ulrich Hecht (1):
      arm64: dts: renesas: r8a77995: draak: Enable HDMI display output

Vicente Bergas (5):
      arm64: dts: rockchip: re-order vcc_sys on rk3399-sapphire
      arm64: dts: rockchip: Fix VCC5V0_HOST_EN on rk3399-sapphire
      arm64: dts: rockchip: remove dvs2 pinctrl from pmic on rk3399-sapphire
      arm64: dts: rockchip: Add type-c port supply on rk3399-sapphire board
      arm64: dts: rockchip: Fix microSD in rk3399 sapphire board

Vignesh R (2):
      ARM: dts: dra7: Fix up unaligned access setting for PCIe EP
      ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode

Vijay Khemka (1):
      ARM: dts: aspeed: Adding Facebook TiogaPass BMC

Vinod Koul (4):
      arm64: dts: qcom: pm8916: Add PON node
      arm64: dts: qcom: pm8994: Add PON node
      arm64: dts: qcom: apq8016-sbc: Add resin node
      arm64: dts: qcom: apq8096-db820c: Add resin node

Viresh Kumar (1):
      arm64: dts: hisilicon: Add missing clocks property for CPUs

Wolfram Sang (3):
      arm64: dts: renesas: salvator-xs: enable SATA
      arm64: dts: renesas: enable SDR104 on R-Car Gen3
      arm64: dts: renesas: gen3: use 400kHz for I2C DVFS bus

Yannick Fertré (1):
      ARM: dts: stm32: enable display on stm32mp157c-ev1 board

Yoshihiro Shimoda (2):
      arm64: dts: renesas: r8a77990: Enable PWM for Ebisu board
      arm64: dts: renesas: revise properties for R-Car Gen3 SoCs' usb 2.0

Yuan Yao (1):
      ARM: dts: aspeed: Add HXT StarDragon 4800 REP2 BMC

orenbh (1):
      arm64: dts: marvell: add CPU Idle power state support on Armada 7K/8K

 Documentation/arm/Samsung/Bootloader-interface.txt |    1 +
 Documentation/devicetree/bindings/arm/amlogic.txt  |    7 +
 .../devicetree/bindings/arm/bcm/brcm,bcm2835.txt   |    8 +
 Documentation/devicetree/bindings/arm/fsl.txt      |   44 +
 .../bindings/arm/hisilicon/hisilicon.txt           |    8 +
 .../bindings/arm/mediatek/mediatek,apmixedsys.txt  |    1 +
 .../bindings/arm/mediatek/mediatek,audsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,bdpsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,ethsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,hifsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,imgsys.txt      |    1 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,mmsys.txt       |    1 +
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |    1 +
 .../bindings/arm/mediatek/mediatek,topckgen.txt    |    1 +
 .../bindings/arm/mediatek/mediatek,vdecsys.txt     |    1 +
 Documentation/devicetree/bindings/arm/rockchip.txt |   20 +
 Documentation/devicetree/bindings/arm/scu.txt      |    2 +-
 Documentation/devicetree/bindings/arm/shmobile.txt |   16 +-
 .../arm/{marvell/marvell,berlin.txt => syna.txt}   |   11 +-
 Documentation/devicetree/bindings/arm/tegra.txt    |    9 +-
 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt     |   93 +
 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  103 +
 .../devicetree/bindings/arm/ux500/boards.txt       |    2 +-
 .../devicetree/bindings/clock/imx6q-clock.txt      |    8 +
 .../devicetree/bindings/iommu/mediatek,iommu.txt   |    4 +-
 .../bindings/media/mediatek-jpeg-decoder.txt       |    1 +
 .../memory-controllers/mediatek,smi-common.txt     |    1 +
 .../memory-controllers/mediatek,smi-larb.txt       |    3 +-
 Documentation/devicetree/bindings/net/dsa/b53.txt  |   36 +
 .../bindings/nvmem/allwinner,sunxi-sid.txt         |    1 +
 .../devicetree/bindings/power/actions,owl-sps.txt  |    2 +
 .../devicetree/bindings/soc/rockchip/grf.txt       |    2 +
 Documentation/devicetree/bindings/usb/dwc2.txt     |    1 +
 .../devicetree/bindings/vendor-prefixes.txt        |    2 +
 arch/arm/boot/dts/Makefile                         |   18 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |    6 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi     |    5 +-
 arch/arm/boot/dts/am335x-chiliboard.dts            |    6 +-
 arch/arm/boot/dts/am335x-cm-t335.dts               |    6 +-
 arch/arm/boot/dts/am335x-evm.dts                   |   12 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |   12 +-
 arch/arm/boot/dts/am335x-igep0033.dtsi             |   13 +-
 arch/arm/boot/dts/am335x-lxm.dts                   |   12 +-
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi  |  249 +++
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts          |   69 +
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts     |   12 +-
 arch/arm/boot/dts/am335x-nano.dts                  |   12 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts        |    8 +-
 arch/arm/boot/dts/am335x-pdu001.dts                |   14 +-
 arch/arm/boot/dts/am335x-pepper.dts                |   12 +-
 arch/arm/boot/dts/am335x-sancloud-bbe.dts          |    6 +-
 arch/arm/boot/dts/am335x-shc.dts                   |    1 -
 arch/arm/boot/dts/am3517-evm-ui.dtsi               |  220 +++
 arch/arm/boot/dts/am3517-evm.dts                   |    1 +
 arch/arm/boot/dts/am4372.dtsi                      |    2 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                |   12 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |    6 +-
 arch/arm/boot/dts/am437x-idk-evm.dts               |    6 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |   12 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |    6 +-
 arch/arm/boot/dts/am571x-idk.dts                   |   84 +-
 arch/arm/boot/dts/am572x-idk-common.dtsi           |   76 +
 arch/arm/boot/dts/am572x-idk.dts                   |    4 -
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts          |   14 +-
 arch/arm/boot/dts/am57xx-idk-common.dtsi           |   18 +-
 arch/arm/boot/dts/arm-realview-eb.dtsi             |    2 +-
 arch/arm/boot/dts/arm-realview-pb1176.dts          |    2 +-
 arch/arm/boot/dts/arm-realview-pb11mp.dts          |    2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi            |    2 +-
 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts    |  155 ++
 arch/arm/boot/dts/armada-388-clearfog.dtsi         |    2 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          |    4 +-
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi          |    2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |    2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts           |   18 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts      |   18 +-
 .../dts/aspeed-bmc-arm-stardragon4800-rep2.dts     |  207 ++
 .../arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts |  146 ++
 arch/arm/boot/dts/aspeed-bmc-quanta-q71l.dts       |   47 +
 arch/arm/boot/dts/aspeed-g4.dtsi                   |    2 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                   |    2 +-
 arch/arm/boot/dts/at91-dvk_su60_somc.dtsi          |    4 +-
 arch/arm/boot/dts/at91-dvk_su60_somc_lcm.dtsi      |    4 +-
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts        |  103 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |   42 +
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          |    8 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   30 +
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |   11 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |   13 +-
 arch/arm/boot/dts/at91-tse850-3.dts                |   32 +-
 arch/arm/boot/dts/at91-vinco.dts                   |    2 +-
 arch/arm/boot/dts/at91sam9260ek.dts                |    2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |    2 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |    2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    2 +-
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |   18 +-
 arch/arm/boot/dts/bcm-hr2.dtsi                     |    2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   33 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts          |   87 +
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi             |   52 +
 arch/arm/boot/dts/bcm283x-rpi-lan7515.dtsi         |   14 +
 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts |   28 +
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts        |   31 +
 arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts  |   28 +
 arch/arm/boot/dts/bcm5301x-nand-cs0.dtsi           |    4 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |    5 +-
 arch/arm/boot/dts/bcm958625hr.dts                  |   26 +
 arch/arm/boot/dts/da850-evm.dts                    |    6 +
 arch/arm/boot/dts/da850-lego-ev3.dts               |    3 +-
 arch/arm/boot/dts/dm8148-evm.dts                   |   14 +-
 arch/arm/boot/dts/dm8148-t410.dts                  |   14 +-
 arch/arm/boot/dts/dove-cubox.dts                   |    2 +-
 arch/arm/boot/dts/dove.dtsi                        |    6 +-
 arch/arm/boot/dts/dra62x-j5eco-evm.dts             |   14 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   14 +-
 arch/arm/boot/dts/dra7.dtsi                        |    6 +-
 arch/arm/boot/dts/dra71-evm.dts                    |    4 +-
 arch/arm/boot/dts/dra72-evm-revc.dts               |    4 +-
 arch/arm/boot/dts/dra72-evm.dts                    |    8 +-
 arch/arm/boot/dts/dra76-evm.dts                    |    4 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi           |    7 +
 arch/arm/boot/dts/exynos4210-origen.dts            |    9 +
 arch/arm/boot/dts/exynos4210-trats.dts             |   15 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |   11 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi            |    3 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |    3 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |  102 +-
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |   11 +
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         |   11 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  152 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |   10 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |    5 +-
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  157 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |    6 +
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         |    6 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |    5 +-
 arch/arm/boot/dts/hip04.dtsi                       |  346 ++--
 arch/arm/boot/dts/imx1.dtsi                        |    4 +-
 arch/arm/boot/dts/imx23-evk.dts                    |    2 +-
 arch/arm/boot/dts/imx23-olinuxino.dts              |    4 +-
 arch/arm/boot/dts/imx23-sansa.dts                  |    4 +-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts          |    2 +-
 arch/arm/boot/dts/imx23-xfi3.dts                   |    4 +-
 arch/arm/boot/dts/imx23.dtsi                       |    4 +-
 arch/arm/boot/dts/imx25.dtsi                       |    6 +-
 arch/arm/boot/dts/imx27.dtsi                       |    6 +-
 arch/arm/boot/dts/imx28-apf28dev.dts               |    4 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts             |    4 +-
 arch/arm/boot/dts/imx28-cfa10036.dts               |    2 +-
 arch/arm/boot/dts/imx28-duckbill-2-485.dts         |    4 +-
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts     |    4 +-
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts         |    4 +-
 arch/arm/boot/dts/imx28-duckbill-2.dts             |    4 +-
 arch/arm/boot/dts/imx28-duckbill.dts               |    4 +-
 arch/arm/boot/dts/imx28-evk.dts                    |    6 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                 |    4 +-
 arch/arm/boot/dts/imx28-m28evk.dts                 |    4 +-
 arch/arm/boot/dts/imx28-sps1.dts                   |    4 +-
 arch/arm/boot/dts/imx28-ts4600.dts                 |    2 +-
 arch/arm/boot/dts/imx28.dtsi                       |    8 +-
 arch/arm/boot/dts/imx31.dtsi                       |    4 +-
 arch/arm/boot/dts/imx35.dtsi                       |    4 +-
 arch/arm/boot/dts/imx50.dtsi                       |    6 +-
 arch/arm/boot/dts/imx51-babbage.dts                |    1 +
 arch/arm/boot/dts/imx51-zii-rdu1.dts               |    2 +-
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts          |    8 +
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts           |    4 +
 arch/arm/boot/dts/imx51.dtsi                       |    8 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |    1 -
 arch/arm/boot/dts/imx53.dtsi                       |    6 +-
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts       |    2 +-
 arch/arm/boot/dts/imx6dl-icore-mipi.dts            |    2 +-
 arch/arm/boot/dts/imx6dl-icore-rqs.dts             |   38 +-
 arch/arm/boot/dts/imx6dl-icore.dts                 |   38 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts             |    5 +
 arch/arm/boot/dts/imx6q-apalis-eval.dts            |    2 +
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts      |    2 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts           |    2 +
 arch/arm/boot/dts/imx6q-icore-mipi.dts             |    6 +-
 arch/arm/boot/dts/imx6q-icore-ofcap10.dts          |   38 +-
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts          |   38 +-
 arch/arm/boot/dts/imx6q-icore-rqs.dts              |   39 +-
 arch/arm/boot/dts/imx6q-icore.dts                  |   38 +-
 arch/arm/boot/dts/imx6q.dtsi                       |    2 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi              |    4 -
 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi           |   34 +
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi           |   41 +-
 arch/arm/boot/dts/imx6qdl-icore.dtsi               |   42 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   67 +
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |    4 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi            |    4 +
 arch/arm/boot/dts/imx6qdl.dtsi                     |    8 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |    8 +-
 arch/arm/boot/dts/imx6sll.dtsi                     |   31 +
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |    2 +
 arch/arm/boot/dts/imx6sx.dtsi                      |   14 +-
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts        |  390 ++++
 arch/arm/boot/dts/imx6ul-geam.dts                  |   40 +-
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts            |   61 +-
 arch/arm/boot/dts/imx6ul-isiot-nand.dts            |   63 +-
 arch/arm/boot/dts/imx6ul-isiot.dtsi                |   90 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   28 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts            |    2 +-
 arch/arm/boot/dts/imx6ull-pinfunc.h                |   39 +-
 arch/arm/boot/dts/imx6ull.dtsi                     |    2 +-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts            |   20 +
 arch/arm/boot/dts/imx6ulz.dtsi                     |   38 +
 arch/arm/boot/dts/imx7d-sdb.dts                    |    2 +
 arch/arm/boot/dts/imx7d.dtsi                       |   15 +-
 arch/arm/boot/dts/imx7s-warp.dts                   |   53 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  131 +-
 arch/arm/boot/dts/imx7ulp-pinfunc.h                |   16 +-
 arch/arm/boot/dts/iwg20d-q7-common.dtsi            |    4 -
 arch/arm/boot/dts/keystone-k2g.dtsi                |    2 +-
 arch/arm/boot/dts/lpc32xx.dtsi                     |    4 +-
 arch/arm/boot/dts/ls1021a-qds.dts                  |    2 +
 arch/arm/boot/dts/ls1021a-twr.dts                  |    2 +
 arch/arm/boot/dts/ls1021a.dtsi                     |   12 +-
 arch/arm/boot/dts/meson8.dtsi                      |    2 +-
 arch/arm/boot/dts/meson8b-ec100.dts                |  248 +++
 arch/arm/boot/dts/meson8b-odroidc1.dts             |  109 ++
 arch/arm/boot/dts/meson8b.dtsi                     |   47 +-
 arch/arm/boot/dts/mt7623.dtsi                      |  124 ++
 arch/arm/boot/dts/omap2.dtsi                       |    4 +-
 arch/arm/boot/dts/omap2430.dtsi                    |    2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts              |   17 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |   17 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  262 ++-
 arch/arm/boot/dts/omap3-gta04a3.dts                |    2 +-
 arch/arm/boot/dts/omap3-gta04a4.dts                |    2 +-
 arch/arm/boot/dts/omap3-gta04a5.dts                |  129 +-
 arch/arm/boot/dts/omap3-gta04a5one.dts             |  114 ++
 arch/arm/boot/dts/omap3-n9.dts                     |    2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi          |    4 +
 arch/arm/boot/dts/orion5x-linkstation.dtsi         |    2 +-
 arch/arm/boot/dts/owl-s500-cubieboard6.dts         |    3 +-
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts     |    3 +-
 arch/arm/boot/dts/owl-s500-guitar.dtsi             |    3 +-
 arch/arm/boot/dts/owl-s500.dtsi                    |    3 +-
 arch/arm/boot/dts/pxa25x.dtsi                      |    4 +
 arch/arm/boot/dts/pxa27x.dtsi                      |    6 +-
 arch/arm/boot/dts/pxa2xx.dtsi                      |   27 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                |   71 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |  143 +-
 arch/arm/boot/dts/qcom-ipq8064-ap148.dts           |   83 +-
 arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi           |  125 ++
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  286 +++
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts     |   83 +
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  198 +-
 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts    |    4 +
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            |    4 +
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts          |   12 +
 arch/arm/boot/dts/r8a77470.dtsi                    |  168 +-
 arch/arm/boot/dts/r8a7778-bockw.dts                |    2 +-
 arch/arm/boot/dts/r8a7778.dtsi                     |    2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |    2 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |    4 +-
 arch/arm/boot/dts/r8a7790-stout.dts                |    4 +
 arch/arm/boot/dts/r8a7790.dtsi                     |    6 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |    6 +-
 arch/arm/boot/dts/r8a7792.dtsi                     |    3 +-
 arch/arm/boot/dts/r8a7793-gose.dts                 |   16 +
 arch/arm/boot/dts/r8a7793.dtsi                     |    2 +-
 arch/arm/boot/dts/r8a7794-silk.dts                 |   25 +
 arch/arm/boot/dts/r8a7794.dtsi                     |    3 +-
 arch/arm/boot/dts/r9a06g032.dtsi                   |   88 +-
 arch/arm/boot/dts/rk3036.dtsi                      |    2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |    8 +
 arch/arm/boot/dts/rk3188.dtsi                      |   82 +
 arch/arm/boot/dts/rk3288-tinker-s.dts              |   26 +
 arch/arm/boot/dts/rk3288-tinker.dts                |  498 +----
 arch/arm/boot/dts/rk3288-tinker.dtsi               |  502 +++++
 arch/arm/boot/dts/s5pv210.dtsi                     |    2 +-
 arch/arm/boot/dts/sama5d2.dtsi                     |  123 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |    8 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   22 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi             |   32 +-
 ...ockit.dts => socfpga_cyclone5_de0_nano_soc.dts} |    2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts    |    7 +-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts |    3 +-
 arch/arm/boot/dts/ste-dbx5x0.dtsi                  |   80 +-
 arch/arm/boot/dts/ste-href-family-pinctrl.dtsi     |    8 +-
 arch/arm/boot/dts/ste-href.dtsi                    |    1 +
 arch/arm/boot/dts/ste-hrefprev60.dtsi              |    2 +-
 arch/arm/boot/dts/ste-snowball.dts                 |    3 +-
 arch/arm/boot/dts/ste-u300.dts                     |    2 +-
 arch/arm/boot/dts/stih410-b2260.dts                |    5 +-
 arch/arm/boot/dts/stihxxx-b2120.dtsi               |   11 +-
 arch/arm/boot/dts/stm32429i-eval.dts               |    3 +-
 arch/arm/boot/dts/stm32f429.dtsi                   |    2 +-
 arch/arm/boot/dts/stm32f469-disco.dts              |    3 +-
 arch/arm/boot/dts/stm32f746-disco.dts              |    3 +-
 arch/arm/boot/dts/stm32f769-disco.dts              |    3 +-
 arch/arm/boot/dts/stm32h743.dtsi                   |    2 +-
 arch/arm/boot/dts/stm32mp157c-ev1.dts              |   73 +-
 arch/arm/boot/dts/stm32mp157c.dtsi                 |    2 +-
 .../boot/dts/sun5i-reference-design-tablet.dtsi    |    3 +-
 arch/arm/boot/dts/sun5i.dtsi                       |   26 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   26 +
 arch/arm/boot/dts/sun8i-a33.dtsi                   |   26 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |    5 +
 arch/arm/boot/dts/sun8i-a83t.dtsi                  |   18 +
 .../boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts    |   13 +
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  190 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts |  140 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                    |   25 +
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   21 +-
 arch/arm/boot/dts/sun8i-r40.dtsi                   |   13 +
 .../boot/dts/sun8i-reference-design-tablet.dtsi    |    3 +-
 arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts  |    2 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                   |    2 +-
 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi |   31 +
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi      |  231 +++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |    2 +-
 arch/arm/boot/dts/tegra124-apalis-eval.dts         |   40 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts    |   43 +-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi        |  452 ++---
 arch/arm/boot/dts/tegra124-apalis.dtsi             |  451 ++---
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts      |  262 +++
 arch/arm/boot/dts/tegra20-colibri-iris.dts         |  200 +-
 arch/arm/boot/dts/tegra20-colibri.dtsi             |  657 ++++---
 arch/arm/boot/dts/tegra20-paz00.dts                |   12 +-
 arch/arm/boot/dts/tegra20.dtsi                     |   28 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts          |  148 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts     |  266 +++
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi         | 1189 ++++++++++++
 arch/arm/boot/dts/tegra30-apalis.dtsi              |  705 +++++--
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |  130 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi             |  780 ++++++--
 arch/arm/boot/dts/tegra30.dtsi                     |   10 +-
 arch/arm/boot/dts/uniphier-ld4-ref.dts             |    4 +
 arch/arm/boot/dts/uniphier-ld4.dtsi                |   48 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts            |   12 +
 arch/arm/boot/dts/uniphier-pinctrl.dtsi            |   25 +
 arch/arm/boot/dts/uniphier-pro4-ace.dts            |   12 +
 arch/arm/boot/dts/uniphier-pro4-ref.dts            |   12 +
 arch/arm/boot/dts/uniphier-pro4-sanji.dts          |   12 +
 arch/arm/boot/dts/uniphier-pro4.dtsi               |  189 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi               |   59 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts         |   12 +
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts          |    8 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |  239 ++-
 arch/arm/boot/dts/uniphier-sld8-ref.dts            |    4 +
 arch/arm/boot/dts/uniphier-sld8.dtsi               |   48 +-
 arch/arm/boot/dts/versatile-ab.dts                 |    2 +-
 arch/arm/boot/dts/vf500.dtsi                       |   43 +-
 arch/arm/boot/dts/vf610-twr.dts                    |   43 +-
 arch/arm/boot/dts/vf610-zii-cfu1.dts               |   30 +
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts          |   44 +-
 arch/arm/boot/dts/vf610.dtsi                       |   44 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |   55 +-
 arch/arm/boot/dts/zynq-zc702.dts                   |   12 +-
 arch/arm/boot/dts/zynq-zc770-xm010.dts             |    2 +-
 arch/arm/boot/dts/zynq-zc770-xm013.dts             |    2 +-
 arch/arm/mach-exynos/common.h                      |    1 +
 arch/arm/mach-exynos/firmware.c                    |   14 +-
 arch/arm/mach-exynos/suspend.c                     |   34 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |   42 -
 arch/arm/mach-s3c24xx/mach-mini2440.c              |  113 +-
 arch/arm64/boot/dts/actions/Makefile               |    2 +
 arch/arm64/boot/dts/actions/s700-cubieboard7.dts   |    7 -
 arch/arm64/boot/dts/actions/s700.dtsi              |   21 +
 arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |  224 ++-
 arch/arm64/boot/dts/actions/s900.dtsi              |  118 +-
 arch/arm64/boot/dts/allwinner/Makefile             |    4 +
 .../dts/allwinner/sun50i-a64-amarula-relic.dts     |    2 +-
 .../boot/dts/allwinner/sun50i-a64-bananapi-m64.dts |   30 +-
 .../boot/dts/allwinner/sun50i-a64-nanopi-a64.dts   |   85 +-
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts    |   99 +-
 .../boot/dts/allwinner/sun50i-a64-orangepi-win.dts |  175 +-
 .../boot/dts/allwinner/sun50i-a64-pine64-lts.dts   |   13 +
 .../arm64/boot/dts/allwinner/sun50i-a64-pine64.dts |   28 +-
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts     |    9 +-
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  |   28 +-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts      |    2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  193 +-
 .../allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts  |   11 +
 .../dts/allwinner/sun50i-h5-bananapi-m2-plus.dts   |   11 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       |   43 +
 .../dts/allwinner/sun50i-h6-orangepi-one-plus.dts  |  150 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       |   23 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |    2 +-
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |    5 +
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi       |    4 +-
 arch/arm64/boot/dts/amlogic/Makefile               |    1 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts     |  370 +++-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi         | 1615 +++++++--------
 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts    |   29 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi        |  172 ++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi          |   19 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        |    2 +-
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   |    2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         |    2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  162 +-
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi          |   52 +-
 arch/arm64/boot/dts/arm/juno.dts                   |   13 +-
 arch/arm64/boot/dts/broadcom/Makefile              |    3 +-
 .../boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts      |    2 +
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |    4 +-
 .../boot/dts/broadcom/stingray/bcm958742-base.dtsi |    2 +-
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |    4 +-
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     |   18 +-
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi     |    2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts  |    2 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts  |    2 +
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     |    8 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a-qds.dts  |    2 +
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  |    4 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi     |    6 +-
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi     |   20 +-
 arch/arm64/boot/dts/hisilicon/Makefile             |    1 +
 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts  |   35 +
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi          |  162 ++
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi |  181 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi          |    7 +
 arch/arm64/boot/dts/lg/lg1312.dtsi                 |    4 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi                 |    4 +-
 arch/arm64/boot/dts/marvell/Makefile               |    1 +
 arch/arm64/boot/dts/marvell/armada-372x.dtsi       |    2 +-
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   15 +-
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts     |  441 +++++
 arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi |    4 +-
 arch/arm64/boot/dts/marvell/armada-ap806-quad.dtsi |   12 +-
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi      |  110 +-
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi    |   16 +-
 arch/arm64/boot/dts/marvell/armada-common.dtsi     |    1 +
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi      |  189 +-
 arch/arm64/boot/dts/mediatek/Makefile              |    1 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |   11 +
 .../boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts  |  530 +++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |  196 +-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |   62 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |   76 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           |   16 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2180.dtsi     |   12 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |    1 -
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   57 +
 arch/arm64/boot/dts/qcom/Makefile                  |    1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |   14 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dts        |    2 +-
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi       |   14 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   98 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |   15 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dts           |   13 +
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi          |  243 +++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  690 +++++++
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |   18 +-
 arch/arm64/boot/dts/qcom/pm8994.dtsi               |   18 +
 arch/arm64/boot/dts/qcom/pm8998.dtsi               |   75 +-
 arch/arm64/boot/dts/qcom/pmi8998.dtsi              |   40 +
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts            |  382 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  300 +++
 arch/arm64/boot/dts/renesas/Makefile               |    2 +
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi          | 1663 ++++++++++++++++
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |    3 +-
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi       |   18 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |    3 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |    3 +-
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |   17 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  137 +-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |    3 +-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |    3 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |  103 +-
 .../arm64/boot/dts/renesas/r8a77965-m3nulcb-kf.dts |   16 +
 arch/arm64/boot/dts/renesas/r8a77965-m3nulcb.dts   |   33 +
 .../boot/dts/renesas/r8a77965-salvator-xs.dts      |   14 +
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |  417 +++-
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts     |   26 +
 arch/arm64/boot/dts/renesas/r8a77970.dtsi          |  116 +-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    |  123 ++
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts     |  134 ++
 arch/arm64/boot/dts/renesas/r8a77980.dtsi          |  677 ++++++-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts     |  272 +++
 arch/arm64/boot/dts/renesas/r8a77990.dtsi          |  681 ++++++-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts     |  362 ++--
 arch/arm64/boot/dts/renesas/r8a77995.dtsi          |   82 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi   |    9 +-
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi           |    2 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi              |    4 +
 arch/arm64/boot/dts/rockchip/Makefile              |    4 +
 arch/arm64/boot/dts/rockchip/px30-evb.dts          |  235 +++
 arch/arm64/boot/dts/rockchip/px30.dtsi             | 2047 ++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     |   30 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |   61 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   74 +-
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts      |  524 +----
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |   36 +
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |    2 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts     |  680 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts    |   52 +
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi   |  542 ++++++
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts  |  692 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |   68 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |   32 +
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   |   52 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts    |    4 +
 .../arm64/boot/dts/socionext/uniphier-ld20-ref.dts |    4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   |  255 ++-
 .../arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |   12 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi   |  283 ++-
 arch/arm64/boot/dts/synaptics/as370.dtsi           |  173 ++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |   51 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |   18 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |   46 +
 arch/arm64/boot/dts/ti/k3-am65.dtsi                |   54 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |    5 +
 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h |   18 +
 include/dt-bindings/power/owl-s900-powergate.h     |   23 +
 509 files changed, 29099 insertions(+), 6240 deletions(-)
 rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt
=> syna.txt} (89%)
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-2101.dts
 create mode 100644 arch/arm/boot/dts/am3517-evm-ui.dtsi
 create mode 100644 arch/arm/boot/dts/armada-385-db-88f6820-amc.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-icore-1.5.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi
 create mode 100644 arch/arm/boot/dts/meson8b-ec100.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04a5one.dts
 create mode 100644 arch/arm/boot/dts/rk3288-tinker-s.dts
 create mode 100644 arch/arm/boot/dts/rk3288-tinker.dtsi
 rename arch/arm/boot/dts/{socfpga_cyclone5_de0_sockit.dts =>
socfpga_cyclone5_de0_nano_soc.dts} (98%)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus-v1.2.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-zero-plus2.dts
 create mode 100644 arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
 create mode 100644 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
 create mode 100644 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts
 create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
 create mode 100644
arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus-v1.2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-bananapi-m2-plus.dts
 create mode 100644
arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a-u200.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3-io3.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hi3670.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-mtp.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pmi8998.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-m3nulcb-kf.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77965-m3nulcb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30-evb.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/px30.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
 create mode 100644 arch/arm64/boot/dts/synaptics/as370.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
 create mode 100644 include/dt-bindings/power/owl-s900-powergate.h
