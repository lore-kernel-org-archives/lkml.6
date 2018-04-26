Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756020AbeDZOIY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:08:24 -0400
Received: from hermes.aosc.io ([199.195.250.187]:45798 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756433AbeDZOIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:08:18 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] Enable basic MMC support on Allwinner H6
Date: Thu, 26 Apr 2018 22:07:25 +0800
Message-Id: <20180426140728.43155-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 features 3 SD/MMC controllers. The first and second ones
are similar to the ones on the Allwinner A64/H5 SoCs, and the third one
adds the function to use EMCE (EMbedded Crypto Engine) on the Allwinner
H6 chip to do full-disk encryption.

Enable basic MMC support on Allwinner H6. Higher speed bins are not
supported, similar to A64/H5. EMCE is also not supported, and keeps its
bypassed status by default.

Icenowy Zheng (3):
  mmc: sunxi: add support for the MMC controller on H6
  arm64: allwinner: h6: add device tree nodes for MMC controllers
  arm64: allwinner: h6: enable MMC0/2 on Pine H64

 .../devicetree/bindings/mmc/sunxi-mmc.txt          |  2 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts      | 32 +++++++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi       | 56 ++++++++++++++++++++++
 drivers/mmc/host/sunxi-mmc.c                       | 16 +++++++
 4 files changed, 106 insertions(+)

-- 
2.15.1
