Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031919AbeCAPZx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 10:25:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41094 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031977AbeCAPZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 10:25:31 -0500
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: kishon@ti.com, heiko@sntech.de
Cc: groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        vicencb@gmail.com, devicetree@vger.kernel.org,
        Jianqun Xu <jay.xu@rock-chips.com>, Jacob Chen <jacob-chen@iotwrt.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/6] arm64: dts: rockchip: enable typec-phy1 for rk3399-puma.
Date: Thu,  1 Mar 2018 16:25:14 +0100
Message-Id: <20180301152515.20940-6-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180301152515.20940-1-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
support for rk3399") caused a regression regarding the USB3. During boot,
the following message appears a few times:

      dwc3: failed to initialize core

The driver is deferred waiting for the typec-phy, but this never happens
beause is disabled. So, enable it.

Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 1fc5060d7027..3a3b24383482 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -505,6 +505,10 @@
 	};
 };
 
+&tcphy1 {
+	status = "okay";
+};
+
 &u2phy1 {
 	status = "okay";
 
-- 
2.16.1
