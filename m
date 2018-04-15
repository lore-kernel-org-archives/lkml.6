Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeDOEgy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 00:36:54 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42400 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbeDOEgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 00:36:52 -0400
X-Google-Smtp-Source: AIpwx48xfyTUoJg6BE22FdntGQK9dqeRwlvVdm9pfE9ZgGWFDm/v5IpF7K3SRG5KAdvVXk5ilPVHPQ==
From: Yaodong Liu <my375229675@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yaodong Liu <my375229675@gmail.com>
Subject: [PATCH] ARM: dts: rockchip: disable arm_global_timer for rk3066a
Date: Sun, 15 Apr 2018 12:35:55 +0800
Message-Id: <1523766955-9001-1-git-send-email-my375229675@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm_global_timer provides unstable clock to sched_clock, it will
be selected by default instead of rockchip_timer. The same issue has
been fixed in rk3188.

So we must disable arm_global_timer to get the correct clocksource.

Signed-off-by: Yaodong Liu <my375229675@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 06523ca..1920f93 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -749,3 +749,7 @@
 &emac {
 	compatible = "rockchip,rk3066-emac";
 };
+
+&global_timer {
+	status = "disabled";
+};
-- 
2.7.4
