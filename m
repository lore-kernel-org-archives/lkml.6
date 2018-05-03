Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeECXwe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:52:34 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40870 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbeECXwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:52:12 -0400
X-Google-Smtp-Source: AB8JxZpBMZkEN1XdY7rYZQjphfmBOpdxYc4NWeVjkWpNJ8UmgjU8JbH2AKdqo59W+4pgCZDrUVPx4w==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] ARM: dts: tegra30: Add IOMMU nodes to Host1x and its clients
Date: Fri,  4 May 2018 02:47:22 +0300
Message-Id: <20180503234723.4368-5-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503234723.4368-1-digetx@gmail.com>
References: <20180503234723.4368-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IOMMU support for Host1x and its clients.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index a110cf84d85f..09087b9c5e26 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -112,6 +112,7 @@
 		clocks = <&tegra_car TEGRA30_CLK_HOST1X>;
 		resets = <&tegra_car 28>;
 		reset-names = "host1x";
+		iommus = <&mc TEGRA_SWGROUP_HC>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -125,6 +126,8 @@
 			clocks = <&tegra_car TEGRA30_CLK_MPE>;
 			resets = <&tegra_car 60>;
 			reset-names = "mpe";
+
+			iommus = <&mc TEGRA_SWGROUP_MPE>;
 		};
 
 		vi@54080000 {
@@ -134,6 +137,8 @@
 			clocks = <&tegra_car TEGRA30_CLK_VI>;
 			resets = <&tegra_car 20>;
 			reset-names = "vi";
+
+			iommus = <&mc TEGRA_SWGROUP_VI>;
 		};
 
 		epp@540c0000 {
@@ -143,6 +148,8 @@
 			clocks = <&tegra_car TEGRA30_CLK_EPP>;
 			resets = <&tegra_car 19>;
 			reset-names = "epp";
+
+			iommus = <&mc TEGRA_SWGROUP_EPP>;
 		};
 
 		isp@54100000 {
@@ -152,6 +159,8 @@
 			clocks = <&tegra_car TEGRA30_CLK_ISP>;
 			resets = <&tegra_car 23>;
 			reset-names = "isp";
+
+			iommus = <&mc TEGRA_SWGROUP_ISP>;
 		};
 
 		gr2d@54140000 {
@@ -161,6 +170,8 @@
 			clocks = <&tegra_car TEGRA30_CLK_GR2D>;
 			resets = <&tegra_car 21>;
 			reset-names = "2d";
+
+			iommus = <&mc TEGRA_SWGROUP_G2>;
 		};
 
 		gr3d@54180000 {
@@ -172,6 +183,9 @@
 			resets = <&tegra_car 24>,
 				 <&tegra_car 98>;
 			reset-names = "3d", "3d2";
+
+			iommus = <&mc TEGRA_SWGROUP_NV>,
+				 <&mc TEGRA_SWGROUP_NV2>;
 		};
 
 		dc@54200000 {
-- 
2.17.0
