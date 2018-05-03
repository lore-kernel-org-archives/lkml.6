Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeECXwQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 19:52:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41166 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751287AbeECXwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 19:52:13 -0400
X-Google-Smtp-Source: AB8JxZpj23ZbhH7usLMQmRnE8CEr4rOkGi13c/No/VQSiKNjh4K7h6bqPRen3C6jiSL6l3oLjCyQ7A==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/5] ARM: dts: tegra114: Add IOMMU nodes to Host1x and its clients
Date: Fri,  4 May 2018 02:47:23 +0300
Message-Id: <20180503234723.4368-6-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180503234723.4368-1-digetx@gmail.com>
References: <20180503234723.4368-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IOMMU support for Host1x and its clients.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 0e4a13295d8a..84c4358dacac 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -19,6 +19,7 @@
 		clocks = <&tegra_car TEGRA114_CLK_HOST1X>;
 		resets = <&tegra_car 28>;
 		reset-names = "host1x";
+		iommus = <&mc TEGRA_SWGROUP_HC>;
 
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -32,6 +33,8 @@
 			clocks = <&tegra_car TEGRA114_CLK_GR2D>;
 			resets = <&tegra_car 21>;
 			reset-names = "2d";
+
+			iommus = <&mc TEGRA_SWGROUP_G2>;
 		};
 
 		gr3d@54180000 {
@@ -40,6 +43,8 @@
 			clocks = <&tegra_car TEGRA114_CLK_GR3D>;
 			resets = <&tegra_car 24>;
 			reset-names = "3d";
+
+			iommus = <&mc TEGRA_SWGROUP_NV>;
 		};
 
 		dc@54200000 {
-- 
2.17.0
