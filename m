Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeBBSGP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:06:15 -0500
Received: from hermes.aosc.io ([199.195.250.187]:54856 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753417AbeBBSFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 13:05:33 -0500
From: Icenowy Zheng <icenowy@aosc.io>
To: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] Allwinner V3s EMAC support
Date: Sat,  3 Feb 2018 02:04:53 +0800
Message-Id: <20180202180456.60378-1-icenowy@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner V3/V3s SoCs have EMAC similar to the one in H3, but on V3s
the external MII is not exported due to packaging. (V3s is eLQFP128;
the BGA-packaged V3 exported the external MII bus.)

Add support for the EMAC on V3s. The external bus is not added yet, and
will be added when adding support for V3.

Icenowy Zheng (3):
  net: stmmac: dwmac-sun8i: drop V3s compatible and add V3 one
  ARM: sun8i: v3s: add V3s EMAC device tree node
  ARM: sun8i: v3s: enable Ethernet port on the Lichee Pi Zero Dock

 .../devicetree/bindings/net/dwmac-sun8i.txt        | 10 ++--
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts |  8 ++++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 55 ++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  | 10 ++--
 4 files changed, 74 insertions(+), 9 deletions(-)

-- 
2.15.1
