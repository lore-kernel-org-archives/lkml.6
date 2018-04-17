Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbeDQU5I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 16:57:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:53065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752658AbeDQU5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 16:57:06 -0400
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] arm: dts: rockchip: default serial for Tinker Board
Date: Tue, 17 Apr 2018 22:56:23 +0200
Message-Id: <20180417205623.764-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.17.0
X-Provags-ID: V03:K1:qciwsf6BDRuBCeddQN65cCR4xScOEu9WHAUyhlanXYHYuu6x5uJ
 xNjADjoDqeVOyrSLFtf8IsgxtiFNYAr9HO+JHYg38Y2TAVsUqKgjbVdM2s08QfJxs5c6QNv
 fy2JxWqYQ1ZNgtVhpTNIVi6KG17u/nqaWVr8JhyO/eaxpRqwNyqD1MEEyWplIBJiuPBf4ee
 FlUlMY9MKCBmQj7HBS3Pw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PZDequ+aSYo=:qSXG02XsAPElSBkhsKdu5Y
 5DGZgO4GjYoJWtPyEUUoLC/1FAgeflTIdwmro13u6gSDTjzRtxOHQ1Om8ilWXWYOWJUw/LOZy
 cdflcBcoOmhtSld0/f3y3b+n2iGskNhSkxWEeSETJkoHIxSoRGRSDOjgswQ2xJo9aDQ9ueGRf
 AJYIwZrSsGfymLeq8gx/MMcQF9TIsRWkj1gtsi18NHzvwycndBzXlV40VaG0cC+u43wDA8nJ2
 HhuDsoFp0iAzMxHW9hbS0ur2WfII80C6o1WSM7PiHifxTx+f+f5Sbkdlw5Eaaq3625+ZSbeWh
 EofyVtRwWTqRRDMeP5Dn8t2mu1j06wqGayJDsX5louJvkSLmzGn657hcXydX5cZNlYnm8JaBz
 gWSnC9HaldjCqQKWgRBoxQSVxW6ulECd/XPvF+3cVSVpgUSbeXF65nDJELOnCVNyQ+WzMjJPN
 HnfSBBpCEFrnr6iuyLsb0swf8kqufGPnl987kRbKV5SG0H3iuJgUYCDyqnWOKNdRa32BfbFR5
 K5jE7GL/ldPAZW8KOmlrSN9/eCLRz6OSJrP7anY/e3Yi/SnPnj/nEtZIcaKBddZe7MaOA4N6J
 miO5bxJKYm0pxSWwTJJ4yM3mf+0iBzd+2qSgOQtldUMKqdJeEgZSbwUJxUfxb3ODcS6hLDAPY
 PupAfDbn1defZnnRvq6bXPoEO4G9x/+trrRIqWrHDSMmZozmJkhI2TTqudlmV7AJcFhPFrThI
 WOhiRVwgntFZr9Qoe1ujJA/P+zCds6GGIgOn7v8/nmIZIi8qXxVRGVoAnPEFAwmL93f6tEpkC
 N1wERVmyQkRA8/GjfAwdNE1/CYevw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Asus Tinker Board uses serial 2 with 115,200 baud by default for
communication in U-Boot. The same value is also chosen for other RK3288
boards.

So let us set the same value in the Tinker Board device tree.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 arch/arm/boot/dts/rk3288-tinker.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dts b/arch/arm/boot/dts/rk3288-tinker.dts
index 346b0d8b474d..127488f9f174 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dts
+++ b/arch/arm/boot/dts/rk3288-tinker.dts
@@ -49,6 +49,10 @@
 	model = "Rockchip RK3288 Tinker Board";
 	compatible = "asus,rk3288-tinker", "rockchip,rk3288";
 
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
 	memory {
 		reg = <0x0 0x0 0x0 0x80000000>;
 		device_type = "memory";
-- 
2.17.0
