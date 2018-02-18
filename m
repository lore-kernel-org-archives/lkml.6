Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeBRTsa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 14:48:30 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39631 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbeBRTsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 14:48:01 -0500
X-Google-Smtp-Source: AH8x226+66O/RzAsvkcZ7+CUhD5gXLDMagt1tTfVtBBwAM79JtCtzVbskdbJtI6lVtfk3r8Sei3XQA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: tegra30: Add IRAM node
Date: Sun, 18 Feb 2018 22:46:55 +0300
Message-Id: <eca7e53ced963c97e3363d7598fe3778f35e79f2.1518981147.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1518981147.git.digetx@gmail.com>
References: <cover.1518981147.git.digetx@gmail.com>
In-Reply-To: <cover.1518981147.git.digetx@gmail.com>
References: <cover.1518981147.git.digetx@gmail.com>
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
index c3e9f1e847db..833d97206aef 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -91,6 +91,14 @@
 		};
 	};
 
+	iram@40000000 {
+		compatible = "mmio-sram";
+		reg = <0x40000000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x40000000 0x40000>;
+	};
+
 	host1x@50000000 {
 		compatible = "nvidia,tegra30-host1x", "simple-bus";
 		reg = <0x50000000 0x00024000>;
-- 
2.16.1
