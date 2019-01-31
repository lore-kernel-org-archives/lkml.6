Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F918C282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E56220881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfAaIZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:25:41 -0500
Received: from olimex.com ([184.105.72.32]:52387 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731663AbfAaIZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:25:36 -0500
Received: from localhost.localdomain ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 00:25:34 -0800
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC
        DEVICE DRIVERS)
Cc:     Stefan Mavrodiev <stefan@olimex.com>
Subject: [PATCH 5/5] arm: dts: axpxx: add charge led node
Date:   Thu, 31 Jan 2019 10:23:07 +0200
Message-Id: <20190131082308.22522-5-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190131082308.22522-1-stefan@olimex.com>
References: <20190131082308.22522-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt node for axp20x-led driver controlling CHGLED.
Default status is disabled, since it may be not used.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 arch/arm/boot/dts/axp209.dtsi | 5 +++++
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 0d9ff12bdf28..f972b6f3ecd0 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -69,6 +69,11 @@
 		#gpio-cells = <2>;
 	};
 
+	axp_led: led {
+		compatible = "x-powers,axp20x-led";
+		status = "disabled";
+	};
+
 	battery_power_supply: battery-power-supply {
 		compatible = "x-powers,axp209-battery-power-supply";
 		status = "disabled";
diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 65a07a67aca9..92a0b64252b1 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -62,6 +62,11 @@
 		#io-channel-cells = <1>;
 	};
 
+	axp_led: led {
+		compatible = "x-powers,axp20x-led";
+		status = "disabled";
+	};
+
 	battery_power_supply: battery-power-supply {
 		compatible = "x-powers,axp221-battery-power-supply";
 		status = "disabled";
diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index bd83962d3627..22e243cc40d5 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -74,6 +74,11 @@
 		};
 	};
 
+	axp_led: led {
+		compatible = "x-powers,axp20x-led";
+		status = "disabled";
+	};
+
 	battery_power_supply: battery-power-supply {
 		compatible = "x-powers,axp813-battery-power-supply";
 		status = "disabled";
-- 
2.17.1

