Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeA3KaM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 05:30:12 -0500
Received: from vegas.theobroma-systems.com ([144.76.126.164]:39710 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751718AbeA3KaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 05:30:10 -0500
From: Klaus Goger <klaus.goger@theobroma-systems.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Klaus Goger <klaus.goger@theobroma-systems.com>
Subject: [PATCH] arm64: dts: rockchip: enable tsadc on rk3399-puma
Date: Tue, 30 Jan 2018 11:15:55 +0100
Message-Id: <20180130101555.41475-1-klaus.goger@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the SoC thermal sensor on RK3399-Q7 (Puma).
As we want to do do a full board reset instead of just a SoC one, set
hw-tshut-mode to GPIO.

Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>

---

 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index a3fcb803ff69..524f47c7e79f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -523,6 +523,12 @@
 	};
 };
 
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <1>;
+	status = "okay";
+};
+
 &u2phy1 {
 	status = "okay";
 
-- 
2.11.0
