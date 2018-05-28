Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbeE1Fl4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 01:41:56 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38797 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753327AbeE1Flv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 01:41:51 -0400
X-Google-Smtp-Source: ADUXVKIEYE4mKCA7x2FT79YGcfKPzGBhFLmXV4GNGhPHu797oCyqiykW/ZH+K4IFuUK/Teen4Rrdvw==
From: Srinath Mannam <srinath.mannam@broadcom.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Pramod Kumar <pramod.kumar@broadcom.com>
Subject: [PATCH 2/3] arm64: dts: stingray: Add Stingray Thermal DT support.
Date: Mon, 28 May 2018 11:11:23 +0530
Message-Id: <1527486084-4636-3-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
References: <1527486084-4636-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pramod Kumar <pramod.kumar@broadcom.com>

Add DT nodes for thermal zones memory base address
to read temperature.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 99aaff0..db1cc67 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -593,4 +593,41 @@
 			status = "disabled";
 		};
 	};
+
+	tmons {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x8f100000 0x100>;
+
+		tmon_ihost0: thermal@0 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x0 0x4>;
+		};
+
+		tmon_ihost1: thermal@4 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x4 0x4>;
+		};
+
+		tmon_ihost2: thermal@8 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x8 0x4>;
+		};
+
+		tmon_ihost3: thermal@c {
+			compatible = "brcm,sr-thermal";
+			reg = <0xc 0x4>;
+		};
+
+		tmon_crmu: thermal@10 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x10 0x4>;
+		};
+
+		tmon_nitro: thermal@14 {
+			compatible = "brcm,sr-thermal";
+			reg = <0x14 0x4>;
+		};
+	};
 };
-- 
2.7.4
