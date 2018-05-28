Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937690AbeE1Kom (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937393AbeE1Koi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 080/496] arm64: dts: rockchip: Fix DWMMC clocks
Date: Mon, 28 May 2018 11:57:45 +0200
Message-Id: <20180528100323.146750058@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit ca9eee95a2decc6f60bed65b5b836a26bff825c1 ]

Trying to boot an RK3328 box with an HS200-capable eMMC, I see said eMMC
fail to initialise as it can't run its tuning procedure, because the
sample clock is missing. Upon closer inspection, whilst the clock is
present in the DT, its name is subtly incorrect per the binding, so
__of_clk_get_by_name() never finds it. By inspection, the drive clock
suffers from a similar problem, so has never worked properly either.

Fix up all instances of the incorrect clock names across the 64-bit DTs.

Fixes: d717f7352ec6 ("arm64: dts: rockchip: add sdmmc/sdio/emmc nodes for RK3328 SoCs")
Fixes: b790c2cab5ca ("arm64: dts: add Rockchip rk3368 core dtsi and board dts for the r88 board")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi |    6 +++---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -683,7 +683,7 @@
 		interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
 			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		status = "disabled";
 	};
@@ -694,7 +694,7 @@
 		interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
 			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		status = "disabled";
 	};
@@ -705,7 +705,7 @@
 		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
 			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		status = "disabled";
 	};
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -257,7 +257,7 @@
 		max-frequency = <150000000>;
 		clocks = <&cru HCLK_SDIO0>, <&cru SCLK_SDIO0>,
 			 <&cru SCLK_SDIO0_DRV>, <&cru SCLK_SDIO0_SAMPLE>;
-		clock-names = "biu", "ciu", "ciu_drv", "ciu_sample";
+		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 		resets = <&cru SRST_SDIO0>;
