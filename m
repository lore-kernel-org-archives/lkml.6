Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F30C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F20218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 21:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="m7V7k7Qp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbeLaVrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 16:47:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41862 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbeLaVrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 16:47:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id m1so13053710pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 13:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RzfQe8L70nuS7aQnwtVFosetJZhtzd6MrinO9S/kgP8=;
        b=m7V7k7Qp+OxcorOFSpkQ7KaVN1NKWD30izG5fyV4bLJznk2X0oDy3gbhkc2c4vhWFv
         XP/8L5T3MUSvT41eBxlKkfuBwcILKuP5Wqu9qIoZ84lTT5d79/XC2I+oqa3PIaoXXrxb
         TqWw3E43PJe8gvQdkYKwPVejBZ9P8N6bCvGwxiyygmxRiAv2Z+p7I755Gas0fHlfPeWs
         Ir7LqZYMoj9f/jpRQm2fewX/+JShkWpDyPQ76hrhHoqRU8Ly5PGW7/udjP9x9TDjQa4b
         7chnqn1RFCJfdp+g1JK1A9Dy3F5pDUbiSIUdbUbUd0fhd3Uf9+e0endPPzQR4t+Jmgpq
         rPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RzfQe8L70nuS7aQnwtVFosetJZhtzd6MrinO9S/kgP8=;
        b=rY+lTlCYWpxWT/kmxlv72unQnDej2spRC6ciyV8T7N/CIuPJhdNbyg8aVsq4T5Pmvx
         io7VHiORsk38VXtMPnVfFzqbd84HlZMK7QHkxBzc/9DldKVRHY4mUsfS7ghh0cg67z9O
         yXbupoGyPNIjbEjGB95vCE8eX7dl2GGfZGk9gRna2YTIChcWrUqw3QZceke16rekxxBc
         cpwh5aiwXbx0wEtx0iGlwwnbkCmS2x9pdP9On+d1wLseFUvPUEfpxkO42bnRkTmX7nMk
         iez6XVWcl/AYizonrTdpYyY6QkAjX0ds0WcVVjY1CBwpJzxBwxhdZ/omnX9WBJcxbVZH
         lqZQ==
X-Gm-Message-State: AJcUukdEdb3hLree4a2ENX0IUuM4VNIrP/1jxvCQ6ULU6/RBjGuWEipX
        7Y7hv1tMykhC8WwU++kWDG1Aaw==
X-Google-Smtp-Source: ALg8bN5FOG4uD7My1dB80LhR/U2aV1dE2Ht0S4b3TvWzrpzD6bJqIH4wzA8IdEqMcZh6F4FZCPUBxg==
X-Received: by 2002:a63:1321:: with SMTP id i33mr8878689pgl.380.1546292817931;
        Mon, 31 Dec 2018 13:46:57 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u126sm96477085pgb.2.2018.12.31.13.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Dec 2018 13:46:56 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 3/4] ARM: Device-tree updates
Date:   Mon, 31 Dec 2018 13:46:39 -0800
Message-Id: <20181231214640.17015-4-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181231214640.17015-1-olof@lixom.net>
References: <20181231214640.17015-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As usual, this is where the bulk of our changes end up landing each
merge window.

The individual updates are too many to enumerate, many many platforms
have seen additions of device descriptions such that they are
functionally more complete (in fact, this is often the bulk of updates
we see).

Instead I've mostly focused on highlighting the new platforms below as
they are introduced. Sometimes the introduction is of mostly a fragment,
that later gets filled in on later releases, and in some cases it's
near-complete platform support. The latter is more common for derivative
platforms that already has similar support in-tree.

Two SoCs are slight outliers from the usual range of additions. Allwinner
support for F1C100s, a quite old SoC (ARMv5-based) shipping in the
Lychee Pi Nano platform. At the other end is NXP Layerscape LX2160A,
a 16-core 2.2GHz Cortex-A72 SoC with a large amount of I/O aimed at
infrastructure/networking.

TI updates stick out in the diff stats too, in particular because they
have moved the description of their L4 on-chip interconnect to devicetree,
which opens up for removal of even more of their platform-specific
'hwmod' description tables over the next few releases.

SoCs:
- Qualcomm QCS404 (4x Cortex-A53)
- Allwinner T3 (rebranded R40) and f1c100s (armv5)
- NXP i.MX7ULP (1x Cortex-A7 + 1x Cortex-M4)
- NXP LS1028A (2x Cortex-A72), LX2160A (16x Cortex-A72)

New platforms:
- Rockchip: Gru Scarlet (RK3188 Tablet)
- Amlogic: Phicomm N1 (S905D), Libretech S805-AC
- Broadcom: Linksys EA6500 v2 Wi-Fi router (BCM4708)
- Qualcomm: QCS404 base platform and EVB
- Qualcomm: Remove of Arrow SD600
- PXA: First PXA3xx DT board: Raumfeld
- Aspeed: Facebook Backpack-CMM BMC
- Renesas iWave G20D-Q7 (RZ/G1N)
- Allwinner t3-cqa3t-bv3 (T3/R40) and Lichee Pi Nano (F1C100s)
- Allwinner Emlid Neutis N5, Mapleboard MP130
- Marvell Macchiatobin Single Shot (Armada 8040, no 10GbE)
- i.MX: mtrion emCON-MX6, imx6ul-pico-pi, imx7d-sdb-reva
- VF610: Liebherr's BK4 device, ZII SCU4 AIB board
- i.MX7D PICO Hobbit baseboard
- i.MX7ULP EVK board
- NXP LX2160AQDS and LX2160ARDB boards

Other:
- Coresight binding updates across the board
- CPU cooling maps updates across the board

----------------------------------------------------------------

The following changes since commit e97aa8e759e6b01d37ba8bafff59aa63bed24f8d:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 3f47de2c6b6068cf7d5221f8f307969e7e4f1fc5:

  Merge tag 'samsung-dt-4.21-2' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into next/dt

----------------------------------------------------------------

A.s. Dong (4):
      dt-bindings: fsl: add compatible for imx7ulp evk
      dt-bindings: fsl: add imx7ulp pm related components bindings
      ARM: dts: imx: add common imx7ulp dtsi support
      ARM: dts: imx: add imx7ulp evk support

Adam Ford (1):
      ARM: dts: am3517-evm: Enable earlycon stdout path

Aisheng Dong (7):
      ARM: dts: imx6sx-sdb: add flexcan support
      ARM: dts: imx6sx-sabreauto: add flexcan support
      ARM: dts: imx6qdl-sabreauto: add flexcan support
      ARM: dts: imx6sx: Add flexcan stop mode wakeup support
      ARM: dts: imx6qdl: Add flexcan stop mode wakeup support
      ARM: dts: imx6ul: Add flexcan stop mode wakeup support
      ARM: dts: imx7s: Add flexcan stop mode wakeup support

Aleksandr Aleksandrov (2):
      dt-bindings: vendor-prefix: new vendor - Emlid
      arm64: dts: allwinner: new board - Emlid Neutis N5

Alex Gonzalez (4):
      ARM: dts: imx6ul: ccimx6ulsom: Add support for wireless SOM variant
      ARM: dts: imx6ul: ccimx6ulsom: Fix indentation on iomuxc nodes
      ARM: dts: ccimx6ulsbcpro: Enable AUO G101EVN010 lcdif panel
      ARM: dts: ccimx6ulsbcpro: Add support for Goodix touch controller

Alexandre Belloni (7):
      ARM: dts: at91: sama5d4: switch to new clock bindings
      ARM: dts: at91: sama5d2: switch to new clock binding
      ARM: dts: at91: at91sam9260: switch to new clock bindings
      ARM: dts: at91: at91sam9261: switch to new clock bindings
      ARM: dts: at91: at91sam9263: switch to new clock bindings
      ARM: dts: at91: at91sam9x5: switch to new clock bindings
      ARM: dts: at91: at91sam9rl: switch to new clock bindings

Amit Kucheria (8):
      MAINTAINERS: Add entry for Qualcomm TSENS thermal drivers
      ARM: dts: msm8974: thermal: split address space into two
      ARM: dts: msm8974: thermal: Add "qcom,sensors" property
      arm64: dts: msm8916: thermal: split address space into two
      arm64: dts: msm8916: thermal: Add "qcom,sensors" property
      arm64: dts: msm8916: Add gpu thermal zone
      arm64: dts: msm8916: Add camera thermal zone
      arm64: dts: sdm845: enable tsens thermal zones

Anand Moon (5):
      ARM: dts: exynos: Add UHS-I bus speed support to Odroid XU3/XU4/HC1
      ARM: dts: exynos: Fix LDO13 min values on Odroid XU3/XU4/HC1
      ARM: dts: exynos: Update maximum frequency for SD card to 200MHz on Odroid XU3/XU4/HC1
      ARM: dts: exynos: Update maximum frequency for eMMC to 200MHz on Odroid XU3/XU4
      ARM: dts: exynos: Add pin configuration for SD write protect on Odroid XU3/XU4/HC1

Andrey Smirnov (1):
      ARM: dts: imx51-zii-rdu1: Do not specify "power-gpio" for hpa1

Andrzej Hajda (1):
      ARM: dts: exynos: remove display-port node from Arndale

Andy Gross (6):
      Merge tag 'qcom-fixes-for-4.20-rc1' into arm64-for-4.21
      ARM: dts: qcom: Remove Arrow SD600 eval board
      Merge tag 'qcom-fixes-for-4.20-rc1' into arm64-for-4.21-3
      Merge branch 'arm64-for-4.21' into arm64-for-4.21-3
      Merge branch 'qcs404-topic-revised' into arm64-for-4.21-3
      arm64: dts: qcom: msm8998: Fixup clock to use xo_board

Anson Huang (11):
      ARM: dts: imx6: add mmdc ipg clock
      ARM: dts: imx6sll: remove unused property in gpc node
      ARM: dts: imx6sl: vddpu is NOT an always-on regulator
      ARM: dts: imx6sx: specify proper clock for nodes with dummy clock
      ARM: dts: imx7d-sdb: add rev-a board support
      ARM: dts: imx6sll-evk: add debug LED support
      ARM: dts: imx6sll-evk: use WDOG_B pin reset
      ARM: dts: imx6qdl-sabresd: add egalax touch screen support on i2c2 bus
      ARM: dts: imx6qdl-sabresd: add light sensor support
      ARM: dts: imx6qdl-sabresd: add magnetometer sensor support
      ARM: dts: imx6qdl-sabresd: add accelerometer sensor support

Arnd Bergmann (8):
      Merge tag 'zynqmp-dt-for-v5.0' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'zynq-dt-for-v5.0' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'omap-for-v4.21/dt-ti-sysc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'am654-for-v4.21' of git://git.kernel.org/.../kristo/linux into next/dt
      Merge tag 'imx-qspi-dt-clean' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'sunxi-dt-for-4.21-2' of git://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt64-for-4.21-2' of git://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'samsung-dt-4.21-2' of git://git.kernel.org/.../krzk/linux into next/dt

Bao Xiaowei (1):
      arm64: dts: fsl: Add the status property disable PCIe

Baruch Siach (4):
      arm64: dts: clearfog-gt-8k: fix USB regulator gpio polarity
      arm64: dts: clearfog-gt-8k: 1G eth PHY reset signal
      arm64: dts: clearfog-gt-8k: enable mini-PCIe CON2 USB
      arm64: dts: clearfog-gt-8k: describe mini-PCIe CON2 USB

Benjamin Herrenschmidt (2):
      ARM: dts: aspeed: Romulus system can use coprocessor for FSI
      ARM: dts: aspeed: Palmetto system can use coprocessor for FSI

Bhaskar Upadhaya (1):
      arm64: dts: Add support for NXP LS1028A SoC

Biju Das (43):
      arm64: dts: renesas: r8a774a1: Add VIN and CSI-2 nodes
      arm64: dts: renesas: r8a7796: Add CMT device nodes
      ARM: dts: r8a77470: Add watchdog support to SoC dtsi
      ARM: dts: iwg23s-sbc: Enable watchdog support
      ARM: dts: r8a77470: Add USB-DMAC device nodes
      ARM: dts: r8a77470: Add CMT SoC specific support
      ARM: dts: iwg23s-sbc: Enable cmt0
      ARM: dts: iwg23s-sbc: Add pinctl support for EtherAVB
      ARM: dts: r8a7744-iwg20m: Add iWave RZ/G1N Qseven SOM
      ARM: dts: r8a7744: Initial SoC device tree
      ARM: dts: r8a7744-iwg20d-q7: Add support for iWave G20D-Q7 board based on RZ/G1N
      ARM: dts: r8a7744: Add SYS-DMAC support
      ARM: dts: r8a7744: Add GPIO support
      ARM: dts: r8a7744: Add Ethernet AVB support
      ARM: dts: r8a7744: Add SMP support
      ARM: dts: r8a7744: Add [H]SCIF{A|B} support
      ARM: dts: r8a7744: Add I2C and IIC support
      ARM: dts: r8a7744: Add SDHI nodes
      ARM: dts: r8a7744: Add MMC node
      ARM: dts: r8a7744-iwg20m: Add eMMC support
      ARM: dts: r8a7744-iwg20m: Enable SDHI0 controller
      ARM: dts: r8a7744: USB 2.0 host support
      ARM: dts: r8a7744: Add USB-DMAC and HSUSB device nodes
      ARM: dts: r8a7744: Add RWDT node
      ARM: dts: r8a7744: Add audio support
      ARM: dts: r8a7744: Add CAN support
      ARM: dts: r8a7744: Add IRQC support
      ARM: dts: r8a7744: Add thermal device to DT
      ARM: dts: r8a7744: Add CMT SoC specific support
      ARM: dts: r8a7744: add VIN dt support
      ARM: dts: r8a7744: Add VSP support
      ARM: dts: r8a7744: Add IPMMU DT nodes
      ARM: dts: r8a7744: Add PWM SoC support
      ARM: dts: r8a7744: Add TPU support
      ARM: dts: r8a7744-iwg20d-q7-dbcm-ca: Add device tree for camera DB
      ARM: dts: r8a7744: Add QSPI support
      ARM: dts: r8a7744: Add MSIOF[012] support
      ARM: dts: r8a7744: Add xhci support
      ARM: dts: r8a7744: Add PCIe Controller device node
      ARM: dts: iwg20d-q7-common: Move cmt/rwdt node out of RZ/G1M SOM
      ARM: dts: r8a7744-iwg20m: Add SPI NOR support
      dt-bindings: arm: renesas: Document iWave RZ/G1N SOM
      dt-bindings: arm: renesas: Document iW-RainboW-G20D-Qseven-RZG1N board

Bjorn Andersson (8):
      arm64: dts: qcom: qcs404: Add reserved-memory regions
      arm64: dts: qcom: qcs404: Add RPM GLINK related nodes
      arm64: dts: qcom: qcs404: Add PMS405 RPM regulators
      arm64: dts: qcom: qcs404: Add TLMM pinctrl node
      arm64: dts: qcom: qcs404: Add sdcc1 node
      arm64: dts: qcom: qcs404: Add scm firmware node
      arm64: dts: qcom: qcs404: Add remoteproc nodes
      arm64: dts: qcom: msm8998: Fix compatible of scm node

Brian Masney (1):
      ARM: dts: qcom: msm8974-hammerhead: correct gpios property on magnetometer

Carlo Caione (4):
      arm64: dts: meson-axg: Enable watchdog on Meson AXG SoCs
      arm64: dts: meson-axg: s400: Enable PHY interrupt
      arm64: dts: meson-axg: Enable GPIO interrupt controller
      arm64: dts: meson: Fix IRQ trigger type for macirq

Chen-Yu Tsai (13):
      arm64: dts: allwinner: h6: orangepi: Add board-wide 5V regulator
      arm64: dts: allwinner: h6: orangepi: Enable USB 2.0 host and OTG ports
      arm64: dts: allwinner: h6: orangepi: Add device nodes for LEDs
      arm64: dts: allwinner: a64: bananapi-m64: Enable audio codec
      ARM: dts: sun8i: a33: Drop audio codec oversampling rate to 128 fs
      ARM: dts: sunxi: h3/h5: Add clock accuracy for external oscillators
      ARM: dts: sun8i: r40: Add clock accuracy for external oscillators
      ARM: dts: sun8i: a23/a33: Fix up RTC device node
      ARM: dts: sunxi: h3/h5: Fix up RTC device node and clock references
      ARM: dts: sun8i: r40: Add RTC device node
      arm64: dts: allwinner: a64: Fix up RTC device node and clock references
      arm64: dts: allwinner: a64: bananapi-m64: Add Bluetooth device node
      ARM: dts: sunxi: Enable Broadcom-based Bluetooth for multiple boards

Chris Paterson (1):
      arm64: dts: renesas: r8a774a1: Add CAN nodes

Christian Hewitt (1):
      arm64: dts: meson-gxl-s905x-khadas-vim enable Bluetooth

Daniel Mack (8):
      ARM: dts: pxa3xx: add gcu node
      ARM: dts: pxa2xx: drop #address-cells and #size-cells from /cpus
      ARM: dts: pxa3xx: drop #address-cells and #size-cells from pinctrl node
      ARM: dts: pxa2xx: fix hwuart memory range
      ARM: dts: pxa3xx: order timer and gcu nodes under /pxabus
      ARM: dts: pxa3xx: clean up pxa3xx clock controller node name
      ARM: dts: pxa: clean up USB controller nodes
      ARM: dts: pxa3xx: Add Raumfeld DTS files

Dave Gerlach (5):
      ARM: dts: am437x-gp-evm: Add state for ddr3 vtt toggle pin
      ARM: dts: am437x-gp-evm: Add pinctrl for unused_pins
      ARM: dts: am437x-gp-evm: Add pinctrl for debugss pins
      ARM: dts: am437x-gp-evm: Add uart0 pinctrl default and sleep states
      ARM: dts: am437x-gp-evm: Add pinmux for gpio0 wake

Derek Basehore (1):
      arm64: dts: rockchip: Add 32k clk on rk3399-gru

Ding Tao (2):
      arm64: dts: marvell: armada37xx: Add emmc/sdio pinctrl definition
      arm64: dts: marvell: armada-37xx: Enable emmc on espressobin

Dinh Nguyen (2):
      arm: dts: socfpga: remove dma-mask property
      arm64: dts: stratix10: use "altr,stratix10-rst-mgr" binding

Dmitry Osipenko (5):
      ARM: dts: tegra20: Add interrupt entry to External Memory Controller
      ARM: dts: tegra20: Add clock entry to External Memory Controller
      dt: bindings: tegra20-emc: Document interrupt property
      dt: bindings: tegra20-emc: Document clock property
      dt: bindings: Move tegra20-emc binding to memory-controllers directory

Dong Aisheng (1):
      ARM: dts: imx6ul: add flexcan support

Douglas Anderson (1):
      ARM: dts: qcom: Add SoC-specific string for sdhci-msm-v4 nodes

Emil Renner Berthing (1):
      arm64: dts: rockchip: add rk3399 SPI DMAs

Enric Balletbo i Serra (1):
      arm64: dts: rockchip: Use default brightness table for rk3399-gru

Ezequiel Garcia (2):
      arm64: dts: rockchip: add VPU device node for RK3399
      ARM: dts: rockchip: add VPU device node for RK3288

Fabio Estevam (42):
      ARM: dts: vf610: Add ZII SCU4 AIB board
      ARM: dts: imx51: Fix memory node duplication
      ARM: dts: imx53: Fix memory node duplication
      ARM: dts: imx6sx: Complete the PXP support
      ARM: dts: imx31: Fix memory node duplication
      ARM: dts: imx35: Fix memory node duplication
      ARM: dts: imx7: Fix memory node duplication
      ARM: dts: imx6ul-ccimx6ulsom: Add memory node to board dts
      ARM: dts: imx6ul: Fix memory node duplication
      ARM: dts: imx6sx: Fix memory node duplication
      ARM: dts: imx6sl: Fix memory node duplication
      ARM: dts: imx50: Fix memory node duplication
      ARM: dts: imx6qdl-wandboard: Switch to SPDX identifier
      ARM: dts: imx6: Switch NXP board dts to SPDX identifier
      ARM: dts: imx23: Fix memory node duplication
      ARM: dts: imx28: Fix memory node duplication
      ARM: dts: imx1: Fix memory node duplication
      ARM: dts: imx27: Fix memory node duplication
      ARM: dts: imx25: Fix memory node duplication
      ARM: dts: imx50: Switch to SPDX identifier
      ARM: dts: imx53: Switch to SPDX identifier
      ARM: dts: imx6ul: Correct mask for GIC PPI interrupts
      ARM: dts: imx7: Correct mask for GIC PPI interrupts
      ARM: dts: vf: Fix memory node duplication
      ARM: dts: imx6ul-pico-hobbit: Switch to SPDX identifier
      ARM: dts: imx6ul-pico-hobbit: Move SoM related part to imx6ul-pico.dtsi
      ARM: dts: imx6ul-pico-hobbit: Make the child led nodes standard
      ARM: dts: imx6ul-pico-hobbit: Extend peripherals support
      ARM: dts: imx6ul-pico: Add the imx6ul-pico-pi variant
      ARM: dts: vf610-zii-scu4-aib: Add HI8435 support
      ARM: dts: imx53-voipac-dmm-668: Fix memory node duplication
      ARM: dts: imx6dl-mamoj: Add a memory node
      ARM: dts: imx6qdl-sabresd: Move regulators outside of "simple-bus"
      ARM: dts: imx6qdl-sabresd: Use GPIO_ACTIVE_HIGH for regulators
      ARM: dts: imx7d-pico: Do not harcode the memory size
      ARM: dts: imx7d-pico: Switch to SPDX identifier
      ARM: dts: imx7d-pico-pi: Move SoM related part to imx7d-pico.dtsi
      ARM: dts: imx7d-pico: Pass the USBOTG1_PWR pinctrl
      ARM: dts: imx7d-pico: Pass the Ethernet PHY reset GPIO
      ARM: dts: imx7d-pico: Extend peripherals support
      ARM: dts: imx7d-pico-pi: Extend peripherals support
      ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant

Fabrizio Castro (8):
      arm64: dts: renesas: r8a774a1: Replace power magic numbers
      arm64: dts: renesas: r8a774a1: Replace clock magic numbers
      ARM: dts: r8a77470: Add I2C[0123] support
      ARM: dts: r8a77470: Add SDHI0 support
      ARM: dts: r8a77470: Add SDHI1 support
      ARM: dts: iwg23s-sbc: Add uSD and eMMC support
      ARM: dts: r8a77470: Add QSPI support
      ARM: dts: iwg23s-sbc: Add QSPI flash support

Florian Fainelli (4):
      ARM: dts: BCM63xx: enable SATA PHY and AHCI controller
      ARM: dts: BCM63xx: Enable SATA AHCI and PHY for BCM963138DVT
      ARM: dts: NSP: Move aliases to bcm-nsp.dtsi
      Merge tag 'tags/bcm2835-dt-next-2018-11-27' into devicetree/next

Frieder Schrempf (6):
      ARM: dts: imx: Add dummy PHYs for HSIC-only USB controllers
      ARM: dts: Remove unused properties from FSL QSPI driver nodes
      ARM: dts: imx6sx-sdb: Fix the reg properties for the FSL QSPI nodes
      ARM: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller
      arm64: dts: Remove unused properties from FSL QSPI driver nodes
      arm64: dts: Add spi-[tx/rx]-bus-width for the FSL QSPI controller

Gaku Inami (2):
      arm64: dts: renesas: Add CPU topology on R-Car Gen3 SoCs
      arm64: dts: renesas: Add CPU capacity-dmips-mhz

Geert Uytterhoeven (3):
      arm64: dts: renesas: r8a77965: Remove non-existent IPMMU-IR
      arm64: dts: renesas: r8a7795-es1: Add missing power domains to IPMMU nodes
      ARM: dts: r8a7743: Remove legacy "renesas,rcar-thermal" compatibility

Hao Zhang (2):
      Documentation: ARM: sunxi: Add Allwinner SoC T3.
      ARM: dts: sun8i: Add board dts file for t3-cqa3t-bv3.

He Yangxuan (4):
      arm64: dts: meson: p230: disable advertisement EEE for GbE.
      arm64: dts: meson-gxl: add support for phicomm n1
      dt-bindings: Add vendor prefix for PHICOMM Co., Ltd.
      dt-bindings: arm: amlogic: Add Phicomm N1

Heiko Stuebner (10):
      Merge branch 'v4.21-shared/pdids' into v4.21-armsoc/dts32
      ARM: dts: rockchip: add qos nodes found on rk3066 and rk3188
      ARM: dts: rockchip: add rk3066/rk3188 power-domains
      arm64: dts: rockchip: add Gru Scarlet devicetrees
      ARM: dts: rockchip: add #sound-dai-cells to Cortex-A9 i2s
      ARM: dts: rockchip: convert rk3188 to opp-v2
      ARM: dts: rockchip: add cpu-core resets for rk3188
      ARM: dts: rockchip: add phandles to secondary cpu cores
      ARM: dts: rockchip: update cpu supplies on rk3188
      ARM: dts: rockchip: add BQ Edison 2 QC devicetree

Hou Zhiqiang (4):
      arm64: dts: layerscape: removed compatible string "snps,dw-pcie"
      dt-bindings: pci: layerscape-pci: add compatible strings "fsl,ls1043a-pcie"
      dt-bindings: pci: layerscape-pci: removed compatible string "snps,dw-pcie"
      ARM: dts: ls1021a: removed compatible string "snps,dw-pcie"

Houlong Wei (1):
      arm64: dts: mt8173: Add GCE node

Ian Ray (1):
      ARM: dts: imx6q-bx50v3: user-space watchdog GPIO configuration

Icenowy Zheng (7):
      dt-binding: dwmac-sun8i: add H6 compatible string (w/ A64 fallback)
      arm64: allwinner: h6: add EMAC device nodes
      arm64: allwinner: h6: add support for the Ethernet on Pine H64
      arm64: dts: allwinner: h6: add USB2-related device nodes
      arm64: dts: allwinner: h6: add USB Vbus regulator for Pine H64
      arm64: dts: allwinner: h6: enable USB2 on Pine H64
      arm64: dts: allwinner: h6: fix EMAC compatible string sequence

Ioana Ciocoi Radulescu (2):
      arm64: dts: ls1088a: Move fsl-mc node
      arm64: dts: ls1088a: Add missing dma-ranges property

Jacopo Mondi (1):
      arm64: dts: renesas: r8a77990: Fix VIN endpoint numbering

Jagan Teki (4):
      arm64: allwinner: h6: Add common orangepi nodes into dtsi
      arm64: allwinner: h6: Add OrangePi Lite2 initial support
      dt-bindings: gpu: mali-utgard: Add compatible for A64 Mali
      arm64: dts: allwinner: a64: Add device node for Mali-400 GPU

Jan Tuerk (3):
      ARM: dts: imx: Add an cpu0 label for imx6dl devices
      dt-bindings: arm: Document emtrion emCON-MX6 bindings
      ARM: dts: Add support for emtrion emCON-MX6 series

Jeffrey Hugo (4):
      arm64: dts: qcom: msm8998: correct xo clock name
      arm64: dts: qcom: msm8998: Add SDCC2
      arm64: dts: qcom: msm8998-mtp: Add external SD
      arm64: dts: qcom: msm8998: Add SDC2 control pins

Jernej Skrabec (2):
      arm64: dts: allwinner: h6: Add HDMI pipeline
      arm64: dts: allwinner: h6: Enable HDMI output on Pine H64 board

Jerome Brunet (18):
      arm64: dts: meson-gx: add efuse pclk
      ARM: dts: meson: consistently disable pin bias
      arm64: dts: meson-axg: fix dtc warning about unit address
      arm64: dts: meson-axg: s400: add cts-rts to the bluetooth uart
      arm64: dts: meson-axg: add secure monitor
      arm64: dts: meson-axg: fix mailbox address
      arm64: dts: meson-axg: correct sram shared mem unit-address
      Documentation: bindings: Add missing Amlogic SCPI sensor bindings
      arm64: dts: meson-axg: enable SCPI
      arm64: dts: meson: s400: add bcm bluetooth device
      arm64: dts: meson: remove extra subnode in mmc clk_gate pinmux
      arm64: dts: meson: disable pad bias for mmc pinmuxes
      arm64: dts: meson: consistently disable pin bias
      dt-bindings: arm: amlogic: add libretech aml-s805x-ac bindings
      arm64: dts: meson-axg: remove alternate xtal
      dt-bindings: clk: meson: add ao controller clock inputs
      dt-bindings: clk: meson: add main controller clock input
      arm64: dts: meson: add clock controller clock inputs

Joakim Zhang (1):
      ARM: dts: imx6qdl-sabreauto: Remove reg property from fixed regulator

Joel Stanley (2):
      ARM: dts: aspeed-palmetto: Add LPC control node
      ARM: dts: aspeed: Enable VHUB on Romulus

John Keeping (1):
      ARM: dts: rockchip: Fix rk3288-rock2 vcc_flash name

Jon Hunter (2):
      dt-bindings: usb: xhci-tegra: Add power-domain details
      arm64: dts: tegra210: Add power-domains for xHCI

Jonathan Marek (1):
      ARM: dts: imx5: add gpu nodes

Jonathan McDowell (1):
      ARM: dts: sun8i-h3: Add dts for the Mapleboard MP130

Jorik Jonker (1):
      ARM: dts: sun8i-h3: add sy8106a to orange pi plus

Keerthy (1):
      ARM: dts: am437x-gp-evm: Add sleep state for beeper pins

Kevin Hilman (1):
      Merge tag 'meson-clk-headers-4.21-1' of git://github.com/BayLibre/clk-meson into v4.21/dt

Krishna Reddy (1):
      arm64: dts: tegra186: Enable IOMMU for SDHCI

Krzysztof Kozlowski (3):
      ARM: dts: exynos: Add compatible for s2mps11 clocks node on Exynos542x
      ARM: dts: exynos: Add compatible for s5m8767 clocks node on Itop Core
      ARM: dts: exynos: Clarify comment explaining purpose of Odroid XU3 DTSI

Kuninori Morimoto (3):
      arm64: dts: renesas: r8a7795: remove unneeded sound #address/size-cells
      arm64: dts: renesas: r8a7795: add SSIU support for sound
      arm64: dts: renesas: r8a7796: add SSIU support for sound

Laurent Pinchart (3):
      arm64: dts: renesas: r8a77965: Add LVDS support
      ARM: dts: r8a779[01]: Disable unconnected LVDS encoders
      arm64: dts: renesas: r8a77995: draak: Add backlight

Lei YU (1):
      ARM: dts: aspeed: romulus: Enable iio-hwmon-battery

Leonard Crestez (3):
      ARM: dts: imx6ull: Add dcp node
      ARM: dts: imx6qdl-sabreauto: Enable pcie
      ARM: dts: imx6ul: Remove extra space between node name and brace

Linus Walleij (6):
      ARM: dts: Modernize the Vexpress PL111 integration
      ARM: dts: Fix up the D-Link DIR-685 MTD partition info
      ARM: dts: Enable Gemini flash access
      ARM: dts: Fix up SQ201 flash access
      ARM: dts: Add the FOTG210 USB host to Gemini boards
      ARM: dts: Bump Gemini platforms to use 100ms debounce

Lubomir Rintel (11):
      dt-bindings: mrvl,mmp-timer: add clock
      ARM: dts: mmp2: fix the gpio interrupt cell number
      ARM: dts: mmp2: give gpio node a name
      ARM: dts: mmp2: add clock to the timer
      ARM: dts: mmp2: add MMC controllers
      ARM: dts: mmp2: fix TWSI2
      ARM: dts: mmp2: add more TWSI controllers
      ARM: dts: mmp2: add OTG PHY
      ARM: dts: mmp2: add USB OTG host controller
      ARM: dts: mmp2: Add SSP controllers
      ARM: mmp2: DT: be compatible with mrvl,mmp2

Lucas Stach (2):
      ARM: dts: imx6: RDU2: fix eGalax touchscreen node
      ARM: dts: imx6: add thermal sensor and cooling cells

Lukasz Luba (1):
      ARM: dts: exynos: Add opp-suspend to DMC and leftbus devfreq OPPs on Exynos4

Lukasz Majewski (1):
      ARM: dts: Add support for Liebherr's BK4 device (vf610 based)

Magnus Damm (4):
      arm64: dts: renesas: r8a77965: Connect R-Car M3-N AVB to IPMMU
      arm64: dts: renesas: r8a77980: Connect R-Car V3H AVB to IPMMU
      arm64: dts: renesas: r8a77990: Connect R-Car E3 AVB to IPMMU
      ARM: dts: r8a7740, emev2, sh73a0: Include SoC name in DTSI

Manish Narani (1):
      arm64: dts: zynqmp: Add DDRC node

Manivannan Sadhasivam (12):
      arm64: dts: hisilicon: Add clock nodes for Hi3670 SoC
      arm64: dts: hisilicon: Source SoC clock for UART6
      arm64: dts: hisilicon: Add Pinctrl support for HiKey970 board
      arm64: dts: hisilicon: hi3670: Add GPIO controller support
      arm64: dts: hisilicon: hi3670: Add UART nodes
      arm64: dts: hisilicon: hikey970: Enable on-board UARTs
      arm64: dts: hisilicon: hikey970: Add GPIO line names
      arm64: dts: hisilicon: hikey: Standardize LED labels and triggers
      arm64: dts: hisilicon: hikey960: Standardize LED labels and triggers
      arm64: dts: hisilicon: poplar: Standardize LED labels and triggers
      arm64: dts: rockchip: Add on-board LED support on rk3399-ficus
      arm64: dts: rockchip: Add on-board LED support on rk3399-rock960

Manu Gautam (1):
      arm64: dts: msm8996: Use dwc3-qcom glue driver for USB

Marco Franchi (1):
      ARM: dts: imx6qdl: Fix memory node duplication

Marek Szyprowski (3):
      ARM: dts: exynos: Add missing clocks to RTC node for Arndale board
      arm64: dts: exynos: Update DWC3 modules on Exynos5433 SoCs
      ARM: dts: exynos: Use Samsung SoC specific compatible for DWC2 module

Marek Vasut (2):
      arm64: dts: renesas: Switch eMMC bus to 1V8 on Salvator-X and ULCB
      arm64: dts: renesas: r8a77990: ebisu: Add and enable CAN,FD device nodes

Markus Kueffner (1):
      ARM: dts: imx6qdl-udoo: Add Pincfgs for UART4

Markus Reichl (1):
      ARM: dts: exynos: Add missing CPUs in cooling maps for Odroid X2

Martin Blumenstingl (14):
      dt-bindings: timer: meson6_timer: document all interrupts
      dt-bindings: timer: meson6_timer: document the clock inputs
      ARM: dts: meson6: atv1200: add the /chosen/stdout-path property
      ARM: dts: meson8: minix-neo-x8: add the /chosen/stdout-path property
      ARM: dts: meson8b: mxq: add the /chosen/stdout-path property
      ARM: dts: meson: add the TIMER B/C/D interrupts
      ARM: dts: meson: add the clock inputs for the Meson timer
      ARM: dts: meson: group the Cortex-A5 / Cortex-A9 peripherals
      ARM: dts: meson8: add the ARM TWD timer
      ARM: dts: meson8: add the Cortex-A9 global timer
      ARM: dts: meson8b: add the ARM TWD timer
      ARM: dts: meson8b: add the Cortex-A5 global timer
      ARM: dts: meson: meson8: add the CPU OPP table
      ARM: dts: meson: meson8b: add the CPU OPP tables

Martin Kaiser (1):
      ARM: dts: i.MX25: add the clocks for the EPIT blocks

Masahiro Yamada (3):
      dt-bindings: uniphier: add bindings for UniPhier SoC family
      dt-bindings: uniphier: move cache-uniphier.txt to vendor directory
      ARM: dts: uniphier: add MIO DMAC nodes

Matt Spinler (1):
      ARM: dts: aspeed: wspoon: Enable iio-hwmon battery

Matthias Kaehlcke (3):
      dt-bindings: iio: vadc: Add unit address to ADC channel node in example
      arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
      arm64: dts: qcom: sdm845: Add UART nodes

Maxime Ripard (69):
      ARM: dts: sun4i: Fix gpio-keys warning
      ARM: dts: sun4i: Fix HDMI output DTC warning
      ARM: dts: sun5i: Change framebuffer node names to avoid warnings
      ARM: dts: sun5i: Change clock node names to avoid warnings
      ARM: dts: sun5i: Remove skeleton to avoid warnings
      ARM: dts: sun5i: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun5i: Remove redundant interrupt-controller
      ARM: dts: sun5i: Change LRADC node names to avoid warnings
      ARM: dts: sun5i: Remove all useless pinctrl nodes
      ARM: dts: sun5i: Remove card detect pull-up
      ARM: dts: sun5i: Change pinctrl nodes to avoid warning
      ARM: dts: sun5i: a10s: Fix HDMI output DTC warning
      ARM: dts: sunxi: Change default CMA pool node name
      ARM: dts: sunxi: Remove the CMA node label
      ARM: dts: sun5i: Remove underscores from nodes names
      ARM: dts: sunxi: Change LRADC node names to avoid warnings
      ARM: dts: sun5i: A10s: Remove empty SRAM node
      ARM: dts: sun5i: Provide default muxing for relevant controllers
      ARM: dts: sun6i: Remove skeleton and memory to avoid warnings
      ARM: dts: sun6i: Change framebuffer node names to avoid warnings
      ARM: dts: sun6i: Change clock node names to avoid warnings
      ARM: dts: sun6i: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun6i: Change LRADC node names to avoid warnings
      ARM: dts: sun6i: Remove all useless pinctrl nodes
      ARM: dts: sun6i: Remove card detect pull-up
      ARM: dts: sun6i: Remove redundant MMC pinmux tuning
      ARM: dts: sun6i: Change pinctrl nodes to avoid warning
      ARM: dts: sun6i: Remove underscores from nodes names
      ARM: dts: sun6i: colombus: Change i2c node name to avoid warnings
      ARM: dts: sun6i: Provide default muxing for relevant controllers
      ARM: dts: sun7i: Remove skeleton and memory to avoid warnings
      ARM: dts: sun7i: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun7i: Change clock node names to avoid warnings
      ARM: dts: sun7i: Change framebuffer node names to avoid warnings
      ARM: dts: sun7i: Remove all useless pinctrl nodes
      ARM: dts: sun7i: Remove card detect pull-up
      ARM: dts: sun7i: Change LRADC node names to avoid warnings
      ARM: dts: sun7i: Remove gpio-keys warnings
      ARM: dts: sun7i: Change pinctrl nodes to avoid warning
      ARM: dts: sun7i: Split the RTS and CTS pins out of the UART nodes
      ARM: dts: sun7i: som204: Use the UART3 TX and RX pin group
      ARM: dts: sun7i: Remove underscores from nodes names
      ARM: dts: sun7i: Fix HDMI output DTC warning
      ARM: dts: sun7i: Provide default muxing for relevant controllers
      ARM: dts: sun7i: Remove redundant MMC pinmux tuning
      ARM: dts: sun7i: lamobo-r1: Remove unused address-cells/size-cells
      ARM: dts: sun8i: a23/a33: Remove skeleton and memory to avoid warnings
      ARM: dts: sun8i: a23/a33: Remove SoC node unit-name to avoid warnings
      ARM: dts: sun8i: a23/a33: Fix OPP DTC warnings
      ARM: dts: sun8i: a23/a33: Remove unused address-cells/size-cells
      ARM: dts: sun8i: a23/a33: Remove leading zeros from unit-addresses
      ARM: dts: sun8i: a23/a33: Change framebuffer node names to avoid warnings
      ARM: dts: sun8i: a23/a33: Remove redundant MMC pinmux tuning
      ARM: dts: sun8i: a23/a33: Remove all useless pinctrl nodes
      ARM: dts: sun8i: a23/a33: Change LRADC node names to avoid warnings
      ARM: dts: sun8i: a23/a33: Reorder the pin groups
      ARM: dts: sun8i: a23/a33: Remove card detect pull-up
      ARM: dts: sun8i: a23/a33: Change pinctrl nodes to avoid warning
      ARM: dts: sun8i: a23/a33: Remove underscores from nodes names
      ARM: dts: sunxi: reference: Move the muxing back to the common DTSI
      ARM: dts: sun8i: a23/a33: Provide default muxing for relevant controllers
      ARM: dts: sun8i: BPI-M2M: Remove i2c nodes
      ARM: dts: sun8i: h3: Remove leading zeros from unit-addresses
      ARM: dts: sun8i: v3s: Change LRADC node names to avoid warnings
      ARM: dts: sun8i: v3s: Change pinctrl nodes to avoid warning
      ARM: dts: sun8i: v3s: Provide default muxing for relevant controllers
      ARM: dts: sun8i: v3s: Remove skeleton and memory to avoid warnings
      ARM: dts: suniv: Fix improper bindings include patch
      ARM: dts: suniv: Fix improper bindings include patch

Mesih Kilinc (2):
      ARM: dts: suniv: add initial DTSI file for F1C100s
      ARM: dts: suniv: Add device tree for Lichee Pi Nano

Michal Simek (4):
      ARM: dts: Use mmc@ instead sdhci@
      arm64: dts: zynqmp: Use mmc@ instead sdhci@
      arm64: dts: zynqmp: Add missing gpio-controller to ps gpio
      arm64: dts: zynqmp: Fix node names which contain "_"

Mylène Josserand (1):
      ARM: dts: sun8i: Add the H3/H5 CSI controller

Nathan Chancellor (1):
      ARM: dts: omap3-gta04: Fix comment block

Neil Armstrong (7):
      arm64: dts: meson-gxl-libretech-cc: fix GPIO lines names
      arm64: dts: meson-gxbb-nanopi-k2: fix GPIO lines names
      arm64: dts: meson-gxbb-odroidc2: fix GPIO lines names
      arm64: dts: meson-gxl-khadas-vim: fix GPIO lines names
      arm64: dts: meson-gx: Add hdmi_5v regulator as hdmi tx supply
      arm64: dts: meson: add libretech aml-s805x-ac board
      arm64: dts: meson-gx: Add Internal Clock Measurer node

Olliver Schinagl (1):
      ARM: dts: sun7i: set proper lradc vref on OLinuXino Lime2

Olof Johansson (42):
      Merge branch 'next-for-4.21' of https://github.com/lyrazhang/linux into next/dt
      Merge tag 'vexpress-updates-4.20' of git://git.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'v4.21-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.21-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'renesas-arm-dt-for-v4.21' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-arm64-dt-for-v4.21' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'socfpga_dts_updates_for_v5.0' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'vexpress-drm-arm-soc' of git://git.kernel.org/.../linusw/linux-integrator into next/dt
      Merge tag 'omap-for-v4.21/dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'amlogic-dt' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'amlogic-dt64' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'hisi-arm64-dt-for-4.21' of git://github.com/hisilicon/linux-hisi into next/dt
      Merge tag 'arm-soc/for-4.21/devicetree' of https://github.com/Broadcom/stblinux into next/dt
      Merge tag 'qcom-arm64-for-4.21' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'qcom-dts-for-4.21' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'pxa-dt-4.21' of https://github.com/rjarzmik/linux into next/dt
      Merge tag 'aspeed-4.21-devicetree' of git://git.kernel.org/.../joel/aspeed into next/dt
      Merge tag 'renesas-arm64-dt2-for-v4.21' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-arm-dt2-for-v4.21' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-bindings-for-v4.21' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'tegra-for-4.21-dt-bindings' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.21-arm-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'tegra-for-4.21-arm64-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'sunxi-dt-for-4.21' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt64-for-4.21' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'qcom-arm64-for-4.21-2' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'mvebu-dt64-4.21-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'samsung-dt-4.21' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'samsung-dt64-4.21' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'v4.20-next-dts64' of https://git.kernel.org/.../matthias.bgg/linux into next/dt
      Merge tag 'imx-dt-4.21' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx7d-pico-4.21' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx7ulp-dt-4.21' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'imx-dt64-4.21' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'uniphier-dt-v4.21' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'amlogic-dt-2' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'at91-4.21-dt' of git://git.kernel.org/.../at91/linux into next/dt
      Merge tag 'v4.21-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.21-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'sunxi-h3-h5-for-4.21' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'gemini-dts' of git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'amlogic-dt64-2-redo' of https://git.kernel.org/.../khilman/linux-amlogic into next/dt

Ondrej Jirman (1):
      ARM: dts: sun8i-a83t-tbs-a711: Change MMC0 bus-width to 4

Oskari Lemmela (4):
      ARM: dts: axp81x: add AC power supply subnode
      arm64: dts: allwinner: axp803: add AC and battery power supplies
      arm64: dts: allwinner: a64: sopine-baseboard: enable power supplies
      arm64: dts: rockchip: enable hdmi output on rk3399-rockpro64

Otavio Salvador (9):
      ARM: dts: rockchip: add rv1108 eMMC pin settings
      ARM: dts: rockchip: Add rv1108 GMAC support
      ARM: dts: rockchip: Pass the 'clock-latency' property on rv1108
      ARM: dts: rockchip: Pass the 'arm,cpu-registers-not-fw-configured' property on rv1108
      ARM: dts: rockchip: Fix the PMU interrupt number for rv1108
      ARM: dts: rockchip: Assign the proper GPIO clocks for rv1108
      ARM: dts: rockchip: Add UART DMA support for rv1108
      ARM: dts: imx7d-pico: Improve WiFi regulator name
      ARM: dts: rockchip: Add internal timer support for rv1108

Pankaj Bansal (1):
      arm64: dts: add LX2160AQDS board support

Patrick Havelange (1):
      ARM: dts: ls1021a: add nodes for PWMs

Paul Kocialkowski (8):
      ARM: dts: sun8i: h3: Fix the system-control register range
      arm64: dts: allwinner: h5: Add system-control node with SRAM C1
      ARM/arm64: dts: allwinner: Move H3/H5 syscon label over to soc-specific nodes
      arm64: dts: allwinner: h5: Add Video Engine node
      ARM: dts: sun8i: a33: Remove unnecessary reserved memory node
      ARM: dts: sun8i: h3: Remove unnecessary reserved memory node
      arm64: dts: allwinner: a64: Add support for the SRAM C1 section
      arm64: dts: allwinner: a64: Add Video Engine node

Paweł Chmiel (1):
      ARM: dts: s5pv210: Add s5p-jpeg codec node.

Peng Ma (3):
      arm64: dts: ls1043a: add qdma device tree nodes
      arm64: dts: ls1046a: add qdma device tree nodes
      ARM: dts: ls1021a: add qdma device tree nodes

Peter Rosin (1):
      ARM: dts: at91: nattis: initialize the BLON pin as output-low early

Phil Edworthy (2):
      ARM: dts: r9a06g032: Add pinctrl node
      ARM: dts: r9a06g032: Correct the GIC DT node name

Phil Elwell (3):
      dt-bindings: soc: Document "brcm,bcm2836-vchiq"
      ARM: dts: bcm283x: Correct vchiq compatible string
      ARM: dts: bcm283x: Correct mailbox register sizes

Pramod Kumar (1):
      arm64: dts: ls1012a: Add FRWY-LS1012A board support

Rafał Miłecki (5):
      ARM: dts: BCM5301X: Relicense BCM47081/BCM4709 files to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Relicense BCM47094 file to the GPL 2.0+ / MIT
      ARM: dts: BCM53573: Relicense Tenda AC9 file to the GPL 2.0+ / MIT
      ARM: dts: BCM53573: Relicense SoC file to the GPL 2.0+ / MIT
      ARM: dts: BCM5301X: Describe Northstar pins mux controller

René Kjellerup (1):
      ARM: dts: BCM5301X: Add basic DT for Linksys EA6500 V2

Rob Herring (5):
      ARM: dts: realview-pbx: Fix duplicate regulator nodes
      ARM: dts: aspeed: add missing memory unit-address
      dt-bindings: arm: renesas: Move 'renesas,prr' binding to its own doc
      ARM: dts: sunxi: Fix PMU compatible strings
      dt-bindings: arm: Convert Rockchip board/soc bindings to json-schema

Russell King (1):
      arm64: dts: add support for Macchiatobin Single Shot board

Sameer Pujar (1):
      arm64: tegra: Add HDA controller on Tegra194

Sergei Shtylyov (5):
      arm64: dts: renesas: r8a779{7|8}0: add PWM support
      arm64: dts: renesas: r8a77970: add thermal support
      arm64: dts: renesas: r8a77980: add thermal support
      arm64: dts: renesas: r8a779{7|8}0: add MSIOF support
      arm64: dts: renesas: r8a779{7|8}0: add TMU support

Shawn Guo (2):
      Merge tag 'imx-fixes-4.20-3' into imx7d/pico
      Merge tag 'imx-dt64-4.21' into imx/qspi-dt

Shyam Saini (1):
      ARM: dts: imx6qdl-icore: Add missing stdout-path property

Simon Goldschmidt (2):
      arm: dts: socfpga*.dts*: use SPDX-License-Identifier
      ARM: dts: socfpga: use tabs for indentation

Stefan Wahren (1):
      ARM: dts: bcm2835-rpi-zero: Switch to SPDX identifier

Sudeep Holla (1):
      arm64: dts: zynqmp: replace gpio-key,wakeup with wakeup-source property

Suzuki K Poulose (2):
      ARM: dts: vexpress/TC2: Update entries to match latest coresight bindings
      arm64: dts: sc9836/sc9860: Update coresight bindings for hardware ports

Sylwester Nawrocki (1):
      ARM: dts: exynos: Specify I2S assigned clocks in proper node

Takeshi Kihara (10):
      arm64: dts: renesas: r8a77990: Add INTC-EX device node
      arm64: dts: renesas: r8a77990: Add SCIF-{0,1,3,4,5} device nodes
      arm64: dts: renesas: ebisu: Enable Audio
      arm64: dts: renesas: r8a77990: Add all HSCIF nodes
      arm64: dts: renesas: ebisu: Add serial console pins
      arm64: dts: renesas: ebisu: Add and enable SDHI device nodes
      arm64: dts: renesas: r8a77990: ebisu: Add and enable PCIe device node
      arm64: dts: renesas: r8a77965: Add CAN and CANFD controller nodes
      arm64: dts: renesas: r8a77990: Add I2C-DVFS device node
      arm64: dts: renesas: r8a77990: Enable I2C DMA

Tao Ren (2):
      ARM: dts: Add Facebook BMC flash layout
      ARM: dts: aspeed: Add Facebook Backpack-CMM BMC

Tero Kristo (5):
      ARM: dts: am33xx: convert to use new clkctrl layout
      ARM: dts: am43xx: convert to use new clkctrl layout
      ARM: dts: dra7: convert to use new clkctrl layout
      ARM: dts: dra7: Move the ti,no-idle quirk on proper gmac node
      arm64: dts: ti: k3-am65: Add pinctrl regions

Thierry Reding (31):
      dt-bindings: thermal: tegra-bpmp: Add Tegra194 support
      Merge branch 'for-4.21/dt-bindings' into for-4.21/arm64/dt
      dt-bindings: tegra186-pmc: Add interrupt controller properties
      Merge branch 'for-4.21/dt-bindings' into for-4.21/arm64/dt
      arm64: tegra: Add PWM controllers on Tegra194
      arm64: tegra: Add PWM fan support on Jetson Xavier
      arm64: tegra: Clarify that P2972-0000 is Jetson Xavier
      ARM: tegra: Add VIC on Tegra124
      arm64: tegra: Add display support on Tegra194
      arm64: tegra: Add VIC support on Tegra194
      arm64: tegra: Enable HDMI on P2972-0000
      arm64: tegra: Add thermal zones on Tegra194
      arm64: tegra: p2972: Enable the CPU, GPU and AUX thermal zones
      arm64: tegra: Fix power key interrupt type on Jetson TX2
      arm64: tegra: Enable PMC wake events on Tegra186
      arm64: tegra: Add RTC support on Tegra186
      arm64: tegra: p3310: Enable on-die RTC
      arm64: tegra: Enable PMC wake events on Tegra194
      arm64: tegra: Add RTC support on Tegra194
      arm64: tegra: p2888: Enable on-die RTC
      arm64: tegra: Add AON GPIO controller on Tegra194
      arm64: tegra: Add gpio-keys on Jetson Xavier
      arm64: tegra: Add temperature sensor on P2888
      arm64: tegra: Add HDA controller on Tegra186
      arm64: tegra: Enable HDA on Jetson TX2
      arm64: tegra: Add CEC controller on Tegra186
      arm64: tegra: Enable HDA on Jetson Xavier
      arm64: tegra: Add CEC controller on Tegra194
      arm64: tegra: Enable HDA controller on Jetson TX1
      arm64: tegra: Set reg property for display-hub on Tegra186
      arm64: tegra: Set reg property for display-hub on Tegra194

Todor Tomov (6):
      arm64: dts: qcom: msm8916: Add IOMMU sub-node for VFE context bank
      arm64: dts: qcom: msm8916: Add CAMSS support
      arm64: dts: qcom: Add Camera Control Interface pinctrls
      arm64: dts: qcom: Add pinctrls for camera sensors
      arm64: dts: qcom: msm8996: Add VFE SMMU node
      arm64: dts: qcom: msm8996: Add CAMSS support

Tony Lindgren (21):
      Merge commit 'd6e7bbc148f9fbec8a0117b0d0f420c9710e6d81' into omap-for-v4.21/dt-ti-sysc
      Merge commit 'ce32d59ee2cd036f6e8a6ed17a06a0b0bec5c67c' into omap-for-v4.21/dt-ti-sysc
      Merge remote-tracking branch 'gpio/ib-omap' into omap-for-v4.21/dt-ti-sysc
      Merge tag 'omap-for-v4.20/ti-sysc-take2-signed' into omap-for-v4.21/dt-ti-sysc
      ARM: dts: am437x: Add l4 interconnect hierarchy and ti-sysc data
      ARM: dts: am437x: Move l4 child devices to probe them with ti-sysc
      ARM: dts: am335x: Add l4 interconnect hierarchy and ti-sysc data
      ARM: dts: am335x: Move l4 child devices to probe them with ti-sysc
      ARM: dts: dra7: Add l4 interconnect hierarchy and ti-sysc data
      ARM: dts: dra7: Move l4 child devices to probe them with ti-sysc
      Merge tag 'v4.20-rc1' into omap-for-v4.21/dt-ti-sysc
      ARM: dts: Use dra7 mcasp compatible for mcasp instances
      ARM: dts: omap5: Add l4 interconnect hierarchy and ti-sysc data
      ARM: dts: Revert am335x mcasp ti-sysc changes
      ARM: dts: Add missing ranges for am437x mcasp l3 ports
      ARM: dts: Add am335x mcasp with l3 data port ranges
      ARM: dts: Fix hsi gdd range for omap4
      ARM: dts: Fix ranges for am335x epwmss
      ARM: dts: Add missing ranges for dra7 mcasp l3 ports
      ARM: dts: Fix wrong address for omap5 sata phy
      ARM: dts: Cosmetic fix for omap5 USB node names

Vabhav Sharma (2):
      arm64: dts: add QorIQ LX2160A SoC support
      arm64: dts: add LX2160ARDB board support

Vasily Khoruzhick (6):
      arm64: dts: rockchip: enable HS200 for eMMC on rock64
      arm64: dts: allwinner: add backlight regulator for Pinebook
      arm64: dts: allwinner: a64: add nodes necessary for analog sound support
      arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine
      arm64: dts: allwinner: a64: enable sound on Pinebook
      arm64: dts: allwinner: a64: pinebook: enable power supplies

Vicente Bergas (3):
      arm64: dts: rockchip: add fan on rk3399-sapphire board
      arm64: dts: rockchip: add chosen node on rk3399-sapphire
      arm64: dts: rockchip: move backlight from rk3399 sapphire to excavator

Vignesh R (8):
      dt-bindings: pinctrl: k3: Introduce pinmux definitions
      arm64: dts: ti: am654-base-board: Add pinmux for main uart0
      arm64: dts: ti: k3-am654-base-board: Add I2C nodes
      arm64: dts: ti: k3-am65-main: Add ECAP PWM node
      arm64: dts: ti: k3-am654-base-board: Enable ECAP PWM
      arm64: dts: ti: k3-am654: Populate power-domain property for UART nodes
      arm64: dts: ti: k3-am654: Add McSPI DT nodes
      arm64: dts: ti: k3-am654: Enable main domain McSPI0

Vinod Koul (13):
      arm64: dts: msm8996: add prng-ee node
      arm64: dts: sdm845: add prng-ee node
      arm64: dts: qcom: qcs404: add base dts files
      arm64: dts: qcom: qcs404-evb: add dts files for EVBs
      arm64: dts: qcom: qcs404: add smp2p nodes
      arm64: dts: qcom: pms405: add spmi node
      arm64: dts: qcom: qcs404: add spmi node
      arm64: dts: qcom: pms405: add rtc node
      arm64: dts: qcom: pms405: add gpios
      arm64: dts: qcom: qcs404: add prng-ee node
      arm64: dts: qcom: qcs404: Add BAM DMA node
      arm64: dts: qcom: qcs404: Use BAM DMA for serial uart2
      arm64: dts: qcom: pms405: Add pon and pwrkey nodes

Viresh Kumar (14):
      ARM: dts: exynos: Add all CPUs in cooling maps
      arm64: dts: exynos: Add all CPUs in cooling maps
      ARM: dts: rockchip: Add all CPUs in cooling maps
      arm64: dts: rockchip: Add all CPUs in cooling maps
      ARM: dts: sunxi: Add all CPUs in cooling maps
      arm64: dts: renesas: Add all CPUs in cooling maps
      ARM: dts: uniphier: Add all CPUs in cooling maps
      arm64: dts: hi3660: Add missing cooling device properties for CPUs
      ARM64: dts: hisilicon: Add all CPUs in cooling maps
      arm64: dts: amlogic: Add all CPUs in cooling maps
      arm64: dts: msm8916: Add all CPUs in cooling maps
      arm64: dts: fsl: Add all CPUs in cooling maps
      ARM: dts: ls1021a: Add all CPUs in cooling maps
      arm64: dts: uniphier: Add all CPUs in cooling maps

Xiaowei Bao (1):
      ARM: dts: ls1021a: Add the status property disable PCIe

Yoshihiro Kaneko (3):
      arm64: dts: renesas: r8a77990: Add DMA properties to MSIOF nodes
      arm64: dts: renesas: r8a77990: Add Audio-DMAC and Sound device nodes
      arm64: dts: renesas: r8a77990: add thermal device support

Yoshihiro Shimoda (4):
      arm64: dts: renesas: revise hsusb's reg size
      arm64: dts: renesas: r8a77990: add/enable USB3.0 peripheral device node
      arm64: dts: renesas: salvator-common: add companion property in usb3_peri0
      arm64: dts: renesas: r8a7799{0|5}: add/enable USB2.0 peripheral


 .../devicetree/bindings/arm/amlogic,scpi.txt    |    7 +
 .../devicetree/bindings/arm/amlogic.txt         |    2 +
 .../devicetree/bindings/arm/emtrion.txt         |   12 +
 .../bindings/arm/freescale/fsl,imx7ulp-pm.txt   |   23 +
 Documentation/devicetree/bindings/arm/fsl.txt   |    8 +
 .../devicetree/bindings/arm/renesas,prr.txt     |   20 +
 .../devicetree/bindings/arm/rockchip.txt        |  240 -
 .../devicetree/bindings/arm/rockchip.yaml       |  423 ++
 .../devicetree/bindings/arm/shmobile.txt        |   22 +-
 .../{uniphier => socionext}/cache-uniphier.txt  |    0
 .../bindings/arm/socionext/uniphier.txt         |   47 +
 Documentation/devicetree/bindings/arm/sunxi.txt |    3 +-
 .../bindings/arm/tegra/nvidia,tegra186-pmc.txt  |    3 +
 .../bindings/clock/amlogic,gxbb-aoclkc.txt      |   10 +-
 .../bindings/clock/amlogic,gxbb-clkc.txt        |    5 +
 .../devicetree/bindings/gpu/arm,mali-utgard.txt |    5 +
 .../bindings/iio/adc/qcom,spmi-vadc.txt         |    6 +-
 .../devicetree/bindings/media/cedrus.txt        |    2 +-
 .../nvidia,tegra20-emc.txt                      |    4 +
 .../devicetree/bindings/net/dwmac-sun8i.txt     |    1 +
 .../devicetree/bindings/pci/layerscape-pci.txt  |    7 +-
 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt     |    3 +-
 .../thermal/nvidia,tegra186-bpmp-thermal.txt    |    3 +-
 .../bindings/timer/amlogic,meson6-timer.txt     |   11 +-
 .../bindings/timer/mrvl,mmp-timer.txt           |    4 +
 .../bindings/timer/rockchip,rk-timer.txt        |    1 +
 .../bindings/usb/nvidia,tegra124-xusb.txt       |    8 +
 .../devicetree/bindings/vendor-prefixes.txt     |    2 +
 MAINTAINERS                                     |    9 +
 arch/arm/boot/dts/Makefile                      |   26 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi       |    2 +-
 arch/arm/boot/dts/am335x-boneblue.dts           |    2 +-
 arch/arm/boot/dts/am335x-cm-t335.dts            |    2 +-
 arch/arm/boot/dts/am335x-evm.dts                |    4 +-
 arch/arm/boot/dts/am335x-evmsk.dts              |    4 +-
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts     |    2 +-
 arch/arm/boot/dts/am335x-shc.dts                |    4 +-
 arch/arm/boot/dts/am33xx-clocks.dtsi            |  110 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                | 2132 ++++++++
 arch/arm/boot/dts/am33xx.dtsi                   |  623 +--
 arch/arm/boot/dts/am3517-evm.dts                |    4 +
 arch/arm/boot/dts/am4372.dtsi                   |  876 +---
 arch/arm/boot/dts/am437x-gp-evm.dts             |  127 +-
 arch/arm/boot/dts/am437x-l4.dtsi                | 2505 ++++++++++
 arch/arm/boot/dts/am43xx-clocks.dtsi            |   74 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |    2 +-
 arch/arm/boot/dts/arm-realview-pbx.dtsi         |    5 +-
 .../boot/dts/aspeed-bmc-arm-centriq2400-rep.dts |    2 +-
 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts   |  368 ++
 arch/arm/boot/dts/aspeed-bmc-intel-s2600wf.dts  |    2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-lanyang.dts    |    3 +-
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts   |   39 +-
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts    |   24 +-
 .../arm/boot/dts/aspeed-bmc-opp-witherspoon.dts |    9 +
 .../boot/dts/aspeed-bmc-portwell-neptune.dts    |    2 +-
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts     |    8 +
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts     |   12 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts       |    2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     |    4 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts            |    2 +-
 arch/arm/boot/dts/at91sam9260.dtsi              |  308 +-
 arch/arm/boot/dts/at91sam9261.dtsi              |  287 +-
 arch/arm/boot/dts/at91sam9263.dtsi              |  315 +-
 arch/arm/boot/dts/at91sam9g15.dtsi              |    4 +
 arch/arm/boot/dts/at91sam9g20.dtsi              |   23 +-
 arch/arm/boot/dts/at91sam9g25.dtsi              |    4 +
 arch/arm/boot/dts/at91sam9g25ek.dts             |    4 +-
 arch/arm/boot/dts/at91sam9g35.dtsi              |    4 +
 arch/arm/boot/dts/at91sam9rl.dtsi               |  239 +-
 arch/arm/boot/dts/at91sam9x25.dtsi              |    4 +
 arch/arm/boot/dts/at91sam9x35.dtsi              |    4 +
 arch/arm/boot/dts/at91sam9x5.dtsi               |  326 +-
 arch/arm/boot/dts/at91sam9x5_can.dtsi           |   18 +-
 arch/arm/boot/dts/at91sam9x5_isi.dtsi           |   11 +-
 arch/arm/boot/dts/at91sam9x5_lcd.dtsi           |   19 +-
 arch/arm/boot/dts/at91sam9x5_macb0.dtsi         |   11 +-
 arch/arm/boot/dts/at91sam9x5_macb1.dtsi         |   11 +-
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi        |   11 +-
 arch/arm/boot/dts/axp81x.dtsi                   |    5 +
 arch/arm/boot/dts/bcm-nsp.dtsi                  |    8 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts        |    8 +-
 arch/arm/boot/dts/bcm2835-rpi-zero.dts          |    8 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |    4 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts           |    2 +-
 arch/arm/boot/dts/bcm2836-rpi.dtsi              |    6 +
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts      |    2 +-
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts           |    2 +-
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi          |    2 +-
 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts |   45 +
 arch/arm/boot/dts/bcm47081.dtsi                 |   13 +-
 arch/arm/boot/dts/bcm4709.dtsi                  |    3 +-
 arch/arm/boot/dts/bcm47094.dtsi                 |    3 +-
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts        |    3 +-
 arch/arm/boot/dts/bcm5301x.dtsi                 |   44 +
 arch/arm/boot/dts/bcm53573.dtsi                 |    3 +-
 arch/arm/boot/dts/bcm63138.dtsi                 |   31 +
 arch/arm/boot/dts/bcm958522er.dts               |    4 -
 arch/arm/boot/dts/bcm958525er.dts               |    4 -
 arch/arm/boot/dts/bcm958525xmc.dts              |    4 -
 arch/arm/boot/dts/bcm958622hr.dts               |    4 -
 arch/arm/boot/dts/bcm958623hr.dts               |    4 -
 arch/arm/boot/dts/bcm958625hr.dts               |    4 -
 arch/arm/boot/dts/bcm958625k.dts                |    5 -
 arch/arm/boot/dts/bcm963138dvt.dts              |    8 +
 arch/arm/boot/dts/bcm988312hr.dts               |    4 -
 arch/arm/boot/dts/dra7-evm-common.dtsi          |    4 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  | 4600 ++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                     | 1434 +-----
 arch/arm/boot/dts/dra72-evm-common.dtsi         |    4 +-
 arch/arm/boot/dts/dra72x.dtsi                   |    4 +-
 arch/arm/boot/dts/dra74x.dtsi                   |    6 +-
 arch/arm/boot/dts/dra76x.dtsi                   |    2 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi            |  159 +-
 arch/arm/boot/dts/emev2.dtsi                    |    2 +-
 arch/arm/boot/dts/exynos3250-artik5.dtsi        |    6 +-
 arch/arm/boot/dts/exynos3250-monk.dts           |    6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts         |    6 +-
 arch/arm/boot/dts/exynos3250.dtsi               |    2 +-
 arch/arm/boot/dts/exynos4210-trats.dts          |    4 +-
 arch/arm/boot/dts/exynos4210.dtsi               |    4 +-
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi |    9 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi         |    8 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |    8 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |   18 +-
 arch/arm/boot/dts/exynos4412-prime.dtsi         |    6 +-
 arch/arm/boot/dts/exynos4412.dtsi               |    8 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |   34 +-
 arch/arm/boot/dts/exynos5250.dtsi               |    7 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |    1 +
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi       |    7 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    1 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |   11 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts      |  106 +-
 .../boot/dts/exynos5422-odroidxu3-audio.dtsi    |    9 +-
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   |  109 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts      |    9 +-
 .../arm/boot/dts/facebook-bmc-flash-layout.dtsi |   42 +
 arch/arm/boot/dts/gemini-dlink-dir-685.dts      |   63 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts      |    2 +-
 arch/arm/boot/dts/gemini-nas4220b.dts           |   12 +-
 arch/arm/boot/dts/gemini-rut1xx.dts             |   22 +-
 arch/arm/boot/dts/gemini-sl93512r.dts           |    8 +
 arch/arm/boot/dts/gemini-sq201.dts              |   78 +-
 arch/arm/boot/dts/gemini-wbd111.dts             |   10 +-
 arch/arm/boot/dts/gemini-wbd222.dts             |   10 +-
 arch/arm/boot/dts/gemini.dtsi                   |   32 +
 arch/arm/boot/dts/imx1-ads.dts                  |    1 +
 arch/arm/boot/dts/imx1-apf9328.dts              |    1 +
 arch/arm/boot/dts/imx1.dtsi                     |    2 -
 arch/arm/boot/dts/imx23-evk.dts                 |    1 +
 arch/arm/boot/dts/imx23-olinuxino.dts           |    1 +
 arch/arm/boot/dts/imx23-sansa.dts               |    1 +
 arch/arm/boot/dts/imx23-stmp378x_devb.dts       |    1 +
 arch/arm/boot/dts/imx23-xfi3.dts                |    1 +
 arch/arm/boot/dts/imx23.dtsi                    |    2 -
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi    |    1 +
 arch/arm/boot/dts/imx25-karo-tx25.dts           |    1 +
 arch/arm/boot/dts/imx25-pdk.dts                 |    1 +
 arch/arm/boot/dts/imx25.dtsi                    |    6 +-
 arch/arm/boot/dts/imx27-apf27.dts               |    1 +
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi    |    1 +
 arch/arm/boot/dts/imx27-pdk.dts                 |    1 +
 .../boot/dts/imx27-phytec-phycard-s-som.dtsi    |    1 +
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi |    1 +
 arch/arm/boot/dts/imx27.dtsi                    |    2 -
 arch/arm/boot/dts/imx28-apf28.dts               |    1 +
 arch/arm/boot/dts/imx28-apx4devkit.dts          |    1 +
 arch/arm/boot/dts/imx28-cfa10036.dts            |    1 +
 arch/arm/boot/dts/imx28-duckbill-2-485.dts      |    1 +
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts  |    1 +
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts      |    1 +
 arch/arm/boot/dts/imx28-duckbill-2.dts          |    1 +
 arch/arm/boot/dts/imx28-duckbill.dts            |    1 +
 arch/arm/boot/dts/imx28-eukrea-mbmx283lc.dts    |    1 +
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts    |    1 +
 arch/arm/boot/dts/imx28-evk.dts                 |    1 +
 arch/arm/boot/dts/imx28-m28.dtsi                |    1 +
 arch/arm/boot/dts/imx28-m28cu3.dts              |    1 +
 arch/arm/boot/dts/imx28-m28evk.dts              |    1 +
 arch/arm/boot/dts/imx28-sps1.dts                |    1 +
 arch/arm/boot/dts/imx28-ts4600.dts              |    1 +
 arch/arm/boot/dts/imx28-tx28.dts                |    1 +
 arch/arm/boot/dts/imx28.dtsi                    |    2 -
 arch/arm/boot/dts/imx31-bug.dts                 |    1 +
 arch/arm/boot/dts/imx31-lite.dts                |    1 +
 arch/arm/boot/dts/imx31.dtsi                    |    2 -
 arch/arm/boot/dts/imx35-eukrea-cpuimx35.dtsi    |    1 +
 arch/arm/boot/dts/imx35-pdk.dts                 |    1 +
 arch/arm/boot/dts/imx35.dtsi                    |    2 -
 arch/arm/boot/dts/imx50-evk.dts                 |    1 +
 arch/arm/boot/dts/imx50.dtsi                    |   19 +-
 arch/arm/boot/dts/imx51-apf51.dts               |    1 +
 arch/arm/boot/dts/imx51-babbage.dts             |    1 +
 .../boot/dts/imx51-digi-connectcore-som.dtsi    |    1 +
 arch/arm/boot/dts/imx51-eukrea-cpuimx51.dtsi    |    1 +
 arch/arm/boot/dts/imx51-ts4800.dts              |    1 +
 arch/arm/boot/dts/imx51-zii-rdu1.dts            |   18 +-
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts       |    1 +
 arch/arm/boot/dts/imx51-zii-scu3-esb.dts        |    1 +
 arch/arm/boot/dts/imx51.dtsi                    |   12 +-
 arch/arm/boot/dts/imx53-ard.dts                 |    1 +
 arch/arm/boot/dts/imx53-cx9020.dts              |    1 +
 arch/arm/boot/dts/imx53-m53.dtsi                |    1 +
 arch/arm/boot/dts/imx53-qsb-common.dtsi         |    1 +
 arch/arm/boot/dts/imx53-smd.dts                 |    1 +
 arch/arm/boot/dts/imx53-tqma53.dtsi             |    1 +
 arch/arm/boot/dts/imx53-tx53.dtsi               |    1 +
 arch/arm/boot/dts/imx53-usbarmory.dts           |    1 +
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi     |    8 +-
 arch/arm/boot/dts/imx53.dtsi                    |   27 +-
 arch/arm/boot/dts/imx6dl-apf6dev.dts            |    1 +
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts    |    1 +
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts    |    1 +
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts     |    1 +
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts     |    1 +
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts    |    1 +
 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts      |    1 +
 arch/arm/boot/dts/imx6dl-emcon-avari.dts        |   14 +
 arch/arm/boot/dts/imx6dl-mamoj.dts              |    6 +
 arch/arm/boot/dts/imx6dl-phytec-pfla02.dtsi     |    1 +
 arch/arm/boot/dts/imx6dl-rex-basic.dts          |    1 +
 arch/arm/boot/dts/imx6dl-riotboard.dts          |    1 +
 arch/arm/boot/dts/imx6dl-ts4900.dts             |    1 +
 arch/arm/boot/dts/imx6dl-ts7970.dts             |    1 +
 arch/arm/boot/dts/imx6dl-wandboard-revb1.dts    |    1 +
 arch/arm/boot/dts/imx6dl-wandboard-revd1.dts    |    1 +
 arch/arm/boot/dts/imx6dl-wandboard.dts          |    1 +
 arch/arm/boot/dts/imx6dl.dtsi                   |    2 +-
 arch/arm/boot/dts/imx6q-apf6dev.dts             |    1 +
 arch/arm/boot/dts/imx6q-arm2.dts                |    1 +
 arch/arm/boot/dts/imx6q-b450v3.dts              |    7 -
 arch/arm/boot/dts/imx6q-b650v3.dts              |    7 -
 arch/arm/boot/dts/imx6q-b850v3.dts              |   16 +
 arch/arm/boot/dts/imx6q-ba16.dtsi               |    1 +
 arch/arm/boot/dts/imx6q-bx50v3.dtsi             |   14 -
 arch/arm/boot/dts/imx6q-cm-fx6.dts              |    1 +
 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts       |    1 +
 arch/arm/boot/dts/imx6q-dhcom-som.dtsi          |    1 +
 arch/arm/boot/dts/imx6q-display5.dtsi           |    1 +
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts         |    1 +
 arch/arm/boot/dts/imx6q-emcon-avari.dts         |   14 +
 arch/arm/boot/dts/imx6q-evi.dts                 |    1 +
 arch/arm/boot/dts/imx6q-gk802.dts               |    1 +
 arch/arm/boot/dts/imx6q-gw5400-a.dts            |    1 +
 arch/arm/boot/dts/imx6q-h100.dts                |    1 +
 arch/arm/boot/dts/imx6q-kp-tpc.dts              |    1 +
 arch/arm/boot/dts/imx6q-marsboard.dts           |    1 +
 arch/arm/boot/dts/imx6q-mccmon6.dts             |    1 +
 arch/arm/boot/dts/imx6q-novena.dts              |    1 +
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi      |    1 +
 arch/arm/boot/dts/imx6q-pistachio.dts           |    1 +
 arch/arm/boot/dts/imx6q-rex-pro.dts             |    1 +
 arch/arm/boot/dts/imx6q-sbc6x.dts               |    1 +
 arch/arm/boot/dts/imx6q-tbs2910.dts             |    1 +
 arch/arm/boot/dts/imx6q-ts4900.dts              |    1 +
 arch/arm/boot/dts/imx6q-ts7970.dts              |    1 +
 arch/arm/boot/dts/imx6q-wandboard-revb1.dts     |    1 +
 arch/arm/boot/dts/imx6q-wandboard-revd1.dts     |    1 +
 arch/arm/boot/dts/imx6q-wandboard.dts           |    1 +
 arch/arm/boot/dts/imx6q-zii-rdu2.dts            |    1 +
 arch/arm/boot/dts/imx6q.dtsi                    |    1 +
 arch/arm/boot/dts/imx6qdl-apalis.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi          |    1 +
 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi      |  177 +
 arch/arm/boot/dts/imx6qdl-emcon.dtsi            |  833 ++++
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi           |    1 +
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi     |    1 +
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi    |    1 +
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi        |    1 +
 arch/arm/boot/dts/imx6qdl-icore.dtsi            |    5 +
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi        |    1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi    |    1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi   |    1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi       |    1 +
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi    |    1 +
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi        |  105 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi        |    1 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |  162 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi              |    1 +
 arch/arm/boot/dts/imx6qdl-udoo.dtsi             |   14 +
 arch/arm/boot/dts/imx6qdl-var-dart.dtsi         |    1 +
 arch/arm/boot/dts/imx6qdl-wandboard-revb1.dtsi  |   15 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revc1.dtsi  |   15 +-
 arch/arm/boot/dts/imx6qdl-wandboard-revd1.dtsi  |   15 +-
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi         |    5 +-
 arch/arm/boot/dts/imx6qdl.dtsi                  |   22 +-
 arch/arm/boot/dts/imx6qp-wandboard-revd1.dts    |    1 +
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts           |    1 +
 arch/arm/boot/dts/imx6sl-evk.dts                |    1 +
 arch/arm/boot/dts/imx6sl-warp.dts               |    1 +
 arch/arm/boot/dts/imx6sl.dtsi                   |   11 +-
 arch/arm/boot/dts/imx6sll-evk.dts               |   31 +
 arch/arm/boot/dts/imx6sll.dtsi                  |    2 +-
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts        |    1 +
 arch/arm/boot/dts/imx6sx-sabreauto.dts          |   58 +
 arch/arm/boot/dts/imx6sx-sdb-reva.dts           |   30 +-
 arch/arm/boot/dts/imx6sx-sdb-sai.dts            |   43 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                |   23 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi               |   53 +-
 .../arm/boot/dts/imx6sx-softing-vining-2000.dts |    1 +
 arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts     |    1 +
 arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts  |    1 +
 arch/arm/boot/dts/imx6sx-udoo-neo-full.dts      |    1 +
 arch/arm/boot/dts/imx6sx.dtsi                   |   25 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dtsi         |   66 +-
 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts     |   37 +
 arch/arm/boot/dts/imx6ul-ccimx6ulsom.dtsi       |   77 +-
 arch/arm/boot/dts/imx6ul-geam.dts               |    1 +
 arch/arm/boot/dts/imx6ul-isiot.dtsi             |    1 +
 arch/arm/boot/dts/imx6ul-litesom.dtsi           |    1 +
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi           |    1 +
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts        |  534 +-
 arch/arm/boot/dts/imx6ul-pico-pi.dts            |   97 +
 arch/arm/boot/dts/imx6ul-pico.dtsi              |  461 ++
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi             |    1 +
 arch/arm/boot/dts/imx6ul.dtsi                   |   17 +-
 arch/arm/boot/dts/imx6ull-14x14-evk.dts         |   43 +-
 arch/arm/boot/dts/imx6ull-colibri-nonwifi.dtsi  |    1 +
 arch/arm/boot/dts/imx6ull-colibri-wifi.dtsi     |    1 +
 arch/arm/boot/dts/imx6ull.dtsi                  |   10 +
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts         |    2 +
 arch/arm/boot/dts/imx6ulz.dtsi                  |    2 -
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts         |    3 +-
 arch/arm/boot/dts/imx7d-colibri-emmc.dtsi       |    1 +
 arch/arm/boot/dts/imx7d-colibri.dtsi            |    1 +
 arch/arm/boot/dts/imx7d-nitrogen7.dts           |    1 +
 arch/arm/boot/dts/imx7d-pico-hobbit.dts         |  105 +
 arch/arm/boot/dts/imx7d-pico-pi.dts             |  180 +-
 arch/arm/boot/dts/imx7d-pico.dtsi               |  356 +-
 arch/arm/boot/dts/imx7d-sdb-reva.dts            |   40 +
 arch/arm/boot/dts/imx7d-sdb.dts                 |   29 +-
 arch/arm/boot/dts/imx7d.dtsi                    |   21 +
 arch/arm/boot/dts/imx7s-colibri.dtsi            |    1 +
 arch/arm/boot/dts/imx7s-warp.dts                |    1 +
 arch/arm/boot/dts/imx7s.dtsi                    |   14 +-
 arch/arm/boot/dts/imx7ulp-evk.dts               |   77 +
 arch/arm/boot/dts/imx7ulp.dtsi                  |  346 ++
 arch/arm/boot/dts/iwg20d-q7-common.dtsi         |    9 +
 arch/arm/boot/dts/ls1021a-moxa-uc-8410a.dts     |    5 +-
 arch/arm/boot/dts/ls1021a.dtsi                  |  124 +-
 arch/arm/boot/dts/meson.dtsi                    |   31 +-
 arch/arm/boot/dts/meson6-atv1200.dts            |    4 +
 arch/arm/boot/dts/meson6.dtsi                   |    5 +
 arch/arm/boot/dts/meson8-minix-neo-x8.dts       |    4 +
 arch/arm/boot/dts/meson8.dtsi                   |  121 +-
 arch/arm/boot/dts/meson8b-mxq.dts               |    4 +
 arch/arm/boot/dts/meson8b.dtsi                  |  112 +-
 arch/arm/boot/dts/meson8m2.dtsi                 |    1 +
 arch/arm/boot/dts/mmp2.dtsi                     |  149 +-
 arch/arm/boot/dts/omap3-gta04.dtsi              |    2 +-
 arch/arm/boot/dts/omap4-l4.dtsi                 |    4 +-
 arch/arm/boot/dts/omap5-l4.dtsi                 | 2462 ++++++++++
 arch/arm/boot/dts/omap5.dtsi                    |  688 +--
 arch/arm/boot/dts/pxa27x.dtsi                   |    2 +-
 arch/arm/boot/dts/pxa2xx.dtsi                   |   13 +-
 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi   |  405 ++
 arch/arm/boot/dts/pxa300-raumfeld-connector.dts |   73 +
 .../arm/boot/dts/pxa300-raumfeld-controller.dts |  266 +
 arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts |   11 +
 arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts |   11 +
 .../boot/dts/pxa300-raumfeld-speaker-one.dts    |  137 +
 arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts |   11 +
 .../dts/pxa300-raumfeld-tuneable-clock.dtsi     |   85 +
 arch/arm/boot/dts/pxa3xx.dtsi                   |   30 +-
 .../dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi |   53 -
 .../boot/dts/qcom-apq8064-arrow-sd-600eval.dts  |  415 --
 arch/arm/boot/dts/qcom-apq8084.dtsi             |    4 +-
 .../dts/qcom-msm8974-lge-nexus5-hammerhead.dts  |    3 +-
 arch/arm/boot/dts/qcom-msm8974.dtsi             |   12 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |    2 +-
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi           |    9 -
 arch/arm/boot/dts/r8a7743.dtsi                  |    3 +-
 arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts |   17 +
 arch/arm/boot/dts/r8a7744-iwg20d-q7.dts         |   15 +
 arch/arm/boot/dts/r8a7744-iwg20m.dtsi           |   90 +
 arch/arm/boot/dts/r8a7744.dtsi                  | 1741 +++++++
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts       |  119 +
 arch/arm/boot/dts/r8a77470.dtsi                 |  222 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |    2 -
 arch/arm/boot/dts/r8a7791-koelsch.dts           |    2 -
 arch/arm/boot/dts/r8a7791-porter.dts            |    2 -
 arch/arm/boot/dts/r9a06g032.dtsi                |   10 +-
 arch/arm/boot/dts/rk3066a.dtsi                  |   55 +
 arch/arm/boot/dts/rk3188-bqedison2qc.dts        |  711 +++
 arch/arm/boot/dts/rk3188-px3-evb.dts            |   14 +-
 arch/arm/boot/dts/rk3188-radxarock.dts          |   14 +-
 arch/arm/boot/dts/rk3188.dtsi                   |  117 +-
 arch/arm/boot/dts/rk322x.dtsi                   |   10 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |    2 +-
 arch/arm/boot/dts/rk3288-veyron-mickey.dts      |   24 +-
 arch/arm/boot/dts/rk3288.dtsi                   |   29 +-
 arch/arm/boot/dts/rk3xxx.dtsi                   |   40 +
 arch/arm/boot/dts/rv1108.dtsi                   |   84 +-
 arch/arm/boot/dts/s5pv210.dtsi                  |    9 +
 arch/arm/boot/dts/sama5d2.dtsi                  |  670 +--
 arch/arm/boot/dts/sama5d4.dtsi                  |  535 +-
 arch/arm/boot/dts/sh73a0.dtsi                   |    2 +-
 arch/arm/boot/dts/socfpga.dtsi                  |   19 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi          |   14 +-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi    |   14 +-
 .../arm/boot/dts/socfpga_arria10_socdk_nand.dts |   13 +-
 .../arm/boot/dts/socfpga_arria10_socdk_qspi.dts |   13 +-
 .../boot/dts/socfpga_arria10_socdk_sdmmc.dts    |   14 +-
 arch/arm/boot/dts/socfpga_arria5.dtsi           |   15 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts      |   16 +-
 arch/arm/boot/dts/socfpga_cyclone5.dtsi         |   16 +-
 .../boot/dts/socfpga_cyclone5_de0_nano_soc.dts  |   13 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi     |   14 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts   |   14 +-
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts    |   16 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts   |   16 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts |   16 +-
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts    |   20 +-
 .../boot/dts/socfpga_cyclone5_vining_fpga.dts   |   46 +-
 arch/arm/boot/dts/socfpga_vt.dts                |   16 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts    |    2 -
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         |    2 -
 arch/arm/boot/dts/sun4i-a10.dtsi                |    2 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts    |   14 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts    |   25 +-
 arch/arm/boot/dts/sun5i-a10s-mk802.dts          |   29 +-
 .../arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |   54 +-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts   |   20 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts        |   30 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi               |   30 +-
 .../dts/sun5i-a13-empire-electronix-d709.dts    |   24 +-
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts        |   29 +-
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts    |   14 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts |   34 +-
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts       |   38 +-
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts        |   14 +-
 arch/arm/boot/dts/sun5i-a13.dtsi                |    6 +-
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts        |   34 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts             |   59 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi                |   12 +-
 arch/arm/boot/dts/sun5i-r8-chip.dts             |   40 +-
 .../boot/dts/sun5i-reference-design-tablet.dtsi |   35 +-
 arch/arm/boot/dts/sun5i.dtsi                    |   68 +-
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts       |   10 +-
 arch/arm/boot/dts/sun6i-a31-colombus.dts        |   33 +-
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts     |   39 +-
 arch/arm/boot/dts/sun6i-a31-i7.dts              |   32 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts              |   30 +-
 .../arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts |   30 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                |   79 +-
 .../boot/dts/sun6i-a31s-colorfly-e708-q1.dts    |    2 +-
 arch/arm/boot/dts/sun6i-a31s-cs908.dts          |    6 +-
 arch/arm/boot/dts/sun6i-a31s-inet-q972.dts      |    8 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts        |   27 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi  |    2 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts        |   27 +-
 .../arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts |   47 +-
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts  |   20 +-
 .../boot/dts/sun6i-reference-design-tablet.dtsi |   10 +-
 .../arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts |   46 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        |   44 +-
 arch/arm/boot/dts/sun7i-a20-bananapro.dts       |   65 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |   21 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |   83 +-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts     |   60 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts       |   47 +-
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts     |   10 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts      |   10 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts       |   48 +-
 arch/arm/boot/dts/sun7i-a20-m3.dts              |   21 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts          |   26 +-
 .../boot/dts/sun7i-a20-olimex-som-evb-emmc.dts  |    2 -
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts  |   68 +-
 .../dts/sun7i-a20-olimex-som204-evb-emmc.dts    |    2 -
 .../boot/dts/sun7i-a20-olimex-som204-evb.dts    |   36 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  |   22 +-
 .../boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts |   11 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   32 +-
 .../boot/dts/sun7i-a20-olinuxino-micro-emmc.dts |    2 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |   54 +-
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts   |   52 +-
 arch/arm/boot/dts/sun7i-a20-orangepi.dts        |   44 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts   |   31 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts        |   39 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts  |   39 +-
 .../arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts |   23 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                |  151 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |   88 +-
 arch/arm/boot/dts/sun8i-a23-evb.dts             |   20 +-
 arch/arm/boot/dts/sun8i-a23-gt90h-v4.dts        |    2 +-
 .../dts/sun8i-a23-polaroid-mid2407pxe03.dts     |   15 +-
 .../dts/sun8i-a23-polaroid-mid2809pxe04.dts     |   15 +-
 arch/arm/boot/dts/sun8i-a23.dtsi                |    6 +-
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts      |    4 +-
 arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts  |   12 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts       |    4 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts  |   20 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                |   43 +-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts    |   18 +
 .../arm/boot/dts/sun8i-a83t-cubietruck-plus.dts |   18 +
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts       |    1 +
 arch/arm/boot/dts/sun8i-a83t.dtsi               |    5 -
 arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts |  153 +
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts    |   20 +
 arch/arm/boot/dts/sun8i-h3.dtsi                 |   30 +-
 arch/arm/boot/dts/sun8i-q8-common.dtsi          |    8 +-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts    |   47 +-
 .../boot/dts/sun8i-r16-nintendo-nes-classic.dts |    2 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts          |   42 +-
 arch/arm/boot/dts/sun8i-r40.dtsi                |   18 +-
 .../boot/dts/sun8i-reference-design-tablet.dtsi |   17 +-
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts        |  226 +
 .../boot/dts/sun8i-v3s-licheepi-zero-dock.dts   |    8 +-
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero.dts   |    4 +-
 arch/arm/boot/dts/sun8i-v3s.dtsi                |   12 +-
 .../boot/dts/suniv-f1c100s-licheepi-nano.dts    |   26 +
 arch/arm/boot/dts/suniv-f1c100s.dtsi            |  144 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi              |   56 +-
 arch/arm/boot/dts/sunxi-itead-core-common.dtsi  |    2 +-
 .../boot/dts/sunxi-reference-design-tablet.dtsi |   10 +-
 arch/arm/boot/dts/tegra124.dtsi                 |   12 +
 arch/arm/boot/dts/tegra20.dtsi                  |    2 +
 arch/arm/boot/dts/uniphier-ld4.dtsi             |   14 +
 arch/arm/boot/dts/uniphier-pro4.dtsi            |   16 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi            |    6 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi            |   14 +
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi         |   49 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi             |   63 +-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts     |   14 +
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts      |  108 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts         |   14 +
 arch/arm/boot/dts/vexpress-v2p-ca9.dts          |   43 +-
 arch/arm/boot/dts/vf500-colibri.dtsi            |    1 +
 arch/arm/boot/dts/vf500.dtsi                    |    1 -
 arch/arm/boot/dts/vf610-bk4.dts                 |  502 ++
 arch/arm/boot/dts/vf610-colibri.dtsi            |    1 +
 arch/arm/boot/dts/vf610-cosmic.dts              |    1 +
 arch/arm/boot/dts/vf610-twr.dts                 |    1 +
 arch/arm/boot/dts/vf610-zii-cfu1.dts            |    1 +
 arch/arm/boot/dts/vf610-zii-dev.dtsi            |    1 +
 arch/arm/boot/dts/vf610-zii-scu4-aib.dts        |  851 ++++
 arch/arm/boot/dts/vf610-zii-ssmb-spu3.dts       |    1 +
 arch/arm/boot/dts/vf610m4-colibri.dts           |    1 +
 arch/arm/boot/dts/vf610m4.dtsi                  |    1 -
 arch/arm/boot/dts/zynq-7000.dtsi                |    4 +-
 arch/arm/mach-mmp/mmp2-dt.c                     |    2 +-
 arch/arm64/boot/dts/allwinner/Makefile          |    2 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi       |   33 +
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts   |   43 +
 .../boot/dts/allwinner/sun50i-a64-pine64.dts    |   27 +
 .../boot/dts/allwinner/sun50i-a64-pinebook.dts  |   67 +
 .../allwinner/sun50i-a64-sopine-baseboard.dts   |   34 +
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi   |    4 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |  123 +-
 .../sun50i-h5-emlid-neutis-n5-devboard.dts      |  149 +
 .../allwinner/sun50i-h5-emlid-neutis-n5.dtsi    |   61 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi    |   37 +
 .../dts/allwinner/sun50i-h6-orangepi-lite2.dts  |   11 +
 .../allwinner/sun50i-h6-orangepi-one-plus.dts   |  140 +-
 .../boot/dts/allwinner/sun50i-h6-orangepi.dtsi  |  210 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts   |   82 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi    |  311 ++
 .../boot/dts/altera/socfpga_stratix10.dtsi      |    3 +-
 arch/arm64/boot/dts/amlogic/Makefile            |    2 +
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts  |   36 +-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi      |  178 +-
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi    |    1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi       |    7 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts   |    4 +-
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts    |    5 +-
 .../boot/dts/amlogic/meson-gxbb-wetek.dtsi      |    1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi     |   68 +-
 .../amlogic/meson-gxl-s805x-libretech-ac.dts    |  248 +
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts   |    1 +
 .../dts/amlogic/meson-gxl-s905d-phicomm-n1.dts  |   21 +
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts  |   12 +-
 .../amlogic/meson-gxl-s905x-libretech-cc.dts    |    5 +-
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts   |    1 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi      |   70 +-
 .../boot/dts/amlogic/meson-gxm-khadas-vim2.dts  |   23 +-
 arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts      |   23 +
 .../arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi |   37 +-
 .../boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts   |   14 +
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi  |   36 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |   24 +-
 arch/arm64/boot/dts/freescale/Makefile          |    5 +
 .../boot/dts/freescale/fsl-ls1012a-frwy.dts     |   25 +
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi  |    3 +-
 .../boot/dts/freescale/fsl-ls1028a-qds.dts      |   93 +
 .../boot/dts/freescale/fsl-ls1028a-rdb.dts      |   73 +
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi  |  339 ++
 .../boot/dts/freescale/fsl-ls1043a-qds.dts      |    3 +-
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi  |   37 +-
 .../boot/dts/freescale/fsl-ls1046a-qds.dts      |    4 +-
 .../boot/dts/freescale/fsl-ls1046a-rdb.dts      |    6 +-
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi  |   36 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi  |  169 +-
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi  |    8 +-
 .../boot/dts/freescale/fsl-ls208xa-qds.dtsi     |    4 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi  |   44 +-
 .../boot/dts/freescale/fsl-lx2160a-qds.dts      |  112 +
 .../boot/dts/freescale/fsl-lx2160a-rdb.dts      |  119 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi  |  766 +++
 .../boot/dts/hisilicon/hi3660-hikey960.dts      |   18 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       |   16 +-
 .../boot/dts/hisilicon/hi3670-hikey970.dts      |  338 ++
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi       |  499 +-
 .../boot/dts/hisilicon/hi3798cv200-poplar.dts   |   13 +-
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts  |   25 +-
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |    9 +-
 .../boot/dts/hisilicon/hikey970-pinctrl.dtsi    |  244 +
 arch/arm64/boot/dts/marvell/Makefile            |    1 +
 .../dts/marvell/armada-3720-espressobin.dts     |   22 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi    |   10 +
 .../dts/marvell/armada-8040-clearfog-gt-8k.dts  |   22 +-
 .../marvell/armada-8040-mcbin-singleshot.dts    |   29 +
 .../boot/dts/marvell/armada-8040-mcbin.dts      |  333 +-
 .../boot/dts/marvell/armada-8040-mcbin.dtsi     |  346 ++
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |   10 +
 .../boot/dts/nvidia/tegra186-p2771-0000.dts     |    6 +
 arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi  |    4 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi        |   45 +-
 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi  |   30 +-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts     |  157 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi        |  538 +-
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi  |    4 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi        |    2 +
 arch/arm64/boot/dts/qcom/Makefile               |    2 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi    |    6 +-
 arch/arm64/boot/dts/qcom/msm8916-pins.dtsi      |   76 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi           |  144 +-
 arch/arm64/boot/dts/qcom/msm8996-pins.dtsi      |  120 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |  169 +-
 arch/arm64/boot/dts/qcom/msm8998-mtp.dtsi       |   12 +
 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi      |   78 +
 arch/arm64/boot/dts/qcom/msm8998.dtsi           |   25 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi            |    5 +
 arch/arm64/boot/dts/qcom/pms405.dtsi            |   55 +
 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts    |   11 +
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts    |   11 +
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi        |  188 +
 arch/arm64/boot/dts/qcom/qcs404.dtsi            |  490 ++
 arch/arm64/boot/dts/qcom/sdm845.dtsi            |  448 ++
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi       |  606 ++-
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts |    2 +
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi    |    2 +
 .../boot/dts/renesas/r8a7795-salvator-x.dts     |    2 +
 .../boot/dts/renesas/r8a7795-salvator-xs.dts    |    2 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        |  284 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi        |  321 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi       |   89 +-
 arch/arm64/boot/dts/renesas/r8a77970.dtsi       |  211 +
 arch/arm64/boot/dts/renesas/r8a77980.dtsi       |  221 +
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts  |  314 +-
 arch/arm64/boot/dts/renesas/r8a77990.dtsi       |  733 ++-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts  |   28 +
 arch/arm64/boot/dts/renesas/r8a77995.dtsi       |   45 +
 .../arm64/boot/dts/renesas/salvator-common.dtsi |   13 +-
 arch/arm64/boot/dts/renesas/ulcb.dtsi           |    8 +-
 arch/arm64/boot/dts/rockchip/Makefile           |    2 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts  |    1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        |    5 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        |   15 +-
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts   |   78 +
 .../dts/rockchip/rk3399-gru-chromebook.dtsi     |    8 -
 .../boot/dts/rockchip/rk3399-gru-kevin.dts      |    8 +-
 .../dts/rockchip/rk3399-gru-scarlet-inx.dts     |   33 +
 .../boot/dts/rockchip/rk3399-gru-scarlet-kd.dts |   33 +
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi   |  594 +++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi    |    7 +
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts |   79 +
 .../boot/dts/rockchip/rk3399-rockpro64.dts      |    7 +
 .../dts/rockchip/rk3399-sapphire-excavator.dts  |   46 +-
 .../boot/dts/rockchip/rk3399-sapphire.dtsi      |   77 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        |   36 +-
 .../arm64/boot/dts/socionext/uniphier-ld20.dtsi |   11 +-
 arch/arm64/boot/dts/sprd/sc9836.dtsi            |   78 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi            |  215 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi        |  126 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         |   42 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi      |   20 +
 arch/arm64/boot/dts/ti/k3-am65.dtsi             |    7 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts  |  124 +
 arch/arm64/boot/dts/xilinx/zynqmp-clk.dtsi      |    4 +-
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts      |    6 +-
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts      |   12 +-
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts      |    4 +-
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts      |    4 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi          |   16 +-
 include/dt-bindings/pinctrl/k3.h                |   35 +
 .../dt-bindings/thermal/tegra194-bpmp-thermal.h |   15 +
 695 files changed, 37336 insertions(+), 11954 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/emtrion.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
 create mode 100644 Documentation/devicetree/bindings/arm/renesas,prr.txt
 delete mode 100644 Documentation/devicetree/bindings/arm/rockchip.txt
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip.yaml
 rename Documentation/devicetree/bindings/arm/{uniphier => socionext}/cache-uniphier.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt
 rename Documentation/devicetree/bindings/{arm/tegra => memory-controllers}/nvidia,tegra20-emc.txt (95%)
 create mode 100644 arch/arm/boot/dts/am33xx-l4.dtsi
 create mode 100644 arch/arm/boot/dts/am437x-l4.dtsi
 create mode 100644 arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts
 create mode 100644 arch/arm/boot/dts/bcm2836-rpi.dtsi
 create mode 100644 arch/arm/boot/dts/bcm4708-linksys-ea6500-v2.dts
 create mode 100644 arch/arm/boot/dts/dra7-l4.dtsi
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6q-emcon-avari.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon-avari.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-emcon.dtsi
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-pi.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-pico.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-pico-hobbit.dts
 create mode 100644 arch/arm/boot/dts/imx7d-sdb-reva.dts
 create mode 100644 arch/arm/boot/dts/imx7ulp-evk.dts
 create mode 100644 arch/arm/boot/dts/imx7ulp.dtsi
 create mode 100644 arch/arm/boot/dts/omap5-l4.dtsi
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-common.dtsi
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-connector.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-controller.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dts
 create mode 100644 arch/arm/boot/dts/pxa300-raumfeld-tuneable-clock.dtsi
 delete mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval-pins.dtsi
 delete mode 100644 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20d-q7-dbcm-ca.dts
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20d-q7.dts
 create mode 100644 arch/arm/boot/dts/r8a7744-iwg20m.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7744.dtsi
 create mode 100644 arch/arm/boot/dts/rk3188-bqedison2qc.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-mapleboard-mp130.dts
 create mode 100644 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s-licheepi-nano.dts
 create mode 100644 arch/arm/boot/dts/suniv-f1c100s.dtsi
 create mode 100644 arch/arm/boot/dts/vf610-bk4.dts
 create mode 100644 arch/arm/boot/dts/vf610-zii-scu4-aib.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-lite2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-phicomm-n1.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
 create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey970-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin-singleshot.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-pins.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/pms405.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
 create mode 100644 include/dt-bindings/pinctrl/k3.h
 create mode 100644 include/dt-bindings/thermal/tegra194-bpmp-thermal.h
