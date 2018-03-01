Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966943AbeCAJZb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:25:31 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38596 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966902AbeCAJYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:24:42 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: kishon@ti.com, heiko@sntech.de
Cc: groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        vicencb@gmail.com, devicetree@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>, Will Deacon <will.deacon@arm.com>,
        Rask Ingemann Lambertsen <rask@formelder.dk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] arm64: dts: rockchip: enable typec-phy0 for rk3399-puma-haikou.
Date: Thu,  1 Mar 2018 10:24:20 +0100
Message-Id: <20180301092420.1191-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180301092420.1191-1-enric.balletbo@collabora.com>
References: <20180301092420.1191-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
support for rk3399") caused a regression regarding the USB3. During
boot, the following message appears a few times:

    dwc3: failed to initialize core

The driver is deferred waiting for the typec-phy, but this never
happens beause is disabled. So, enable it.

Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 9a7486058455..2c9c696d1383 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -191,6 +191,10 @@
 	status = "okay";
 };
 
+&tcphy0 {
+	status = "okay";
+};
+
 &u2phy0 {
 	status = "okay";
 };
-- 
2.16.1
