Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbeBRRDB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 12:03:01 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33957 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeBRRCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 12:02:34 -0500
X-Google-Smtp-Source: AH8x225h3+DvdCqdLzK/f94oWAkS8UluuLHX7mIdLqlpJfphf5AGjDGxrhT7rSrwcnsE7/aIAc3qsA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: dts: tegra30: Add IRAM node
Date: Sun, 18 Feb 2018 20:01:45 +0300
Message-Id: <082616811bfc669ec92e74c26d23cc73ac8e77a9.1518973069.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518973069.git.digetx@gmail.com>
References: <cover.1518973069.git.digetx@gmail.com>
In-Reply-To: <cover.1518973069.git.digetx@gmail.com>
References: <cover.1518973069.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IRAM is a static RAM that consists of four contiguous 64 KiB blocks,
it is currently used to store CPU resume code, utilized by the video
decoder engine and could be used as a general-purpose fast memory.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra30.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index c3e9f1e847db..1fb0c421a9d8 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -11,6 +11,14 @@
 	compatible = "nvidia,tegra30";
 	interrupt-parent = <&lic>;
 
+	iram@40000000 {
+		compatible = "mmio-sram";
+		reg = <0x40000000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x40000000 0x40000>;
+	};
+
 	pcie@3000 {
 		compatible = "nvidia,tegra30-pcie";
 		device_type = "pci";
-- 
2.16.1
