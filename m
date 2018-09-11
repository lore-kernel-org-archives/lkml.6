Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD11C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DA020839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 10:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DA020839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeIKPQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 11:16:37 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41294 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbeIKPQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 11:16:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1CD315B2;
        Tue, 11 Sep 2018 03:17:57 -0700 (PDT)
Received: from en101.Emea.Arm.com (en101.emea.arm.com [10.4.13.23])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B0B643F557;
        Tue, 11 Sep 2018 03:17:55 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, robh@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        mathieu.poirier@linaro.org, arm@kernel.org, sudeep.holla@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/11] dts: arm: omap: Update coresight bindings for hardware ports
Date:   Tue, 11 Sep 2018 11:17:08 +0100
Message-Id: <1536661032-30481-8-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new coresight bindings for hardware ports

Cc: linux-omap@vger.kernel.org
Cc: "Benoît Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 17 ++++++++++-------
 arch/arm/boot/dts/omap3-beagle.dts    | 17 ++++++++++-------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index d80587d..9985ee2 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -160,10 +160,11 @@
 
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
-		port {
-			etb_in: endpoint {
-				slave-mode;
-				remote-endpoint = <&etm_out>;
+		in-ports {
+			port {
+				etb_in: endpoint {
+					remote-endpoint = <&etm_out>;
+				};
 			};
 		};
 	};
@@ -174,9 +175,11 @@
 
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
-		port {
-			etm_out: endpoint {
-				remote-endpoint = <&etb_in>;
+		out-ports {
+			port {
+				etm_out: endpoint {
+					remote-endpoint = <&etb_in>;
+				};
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3ca8991..91bb50a 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -147,10 +147,11 @@
 
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
-		port {
-			etb_in: endpoint {
-				slave-mode;
-				remote-endpoint = <&etm_out>;
+		in-ports {
+			port {
+				etb_in: endpoint {
+					remote-endpoint = <&etm_out>;
+				};
 			};
 		};
 	};
@@ -161,9 +162,11 @@
 
 		clocks = <&emu_src_ck>;
 		clock-names = "apb_pclk";
-		port {
-			etm_out: endpoint {
-				remote-endpoint = <&etb_in>;
+		out-ports {
+			port {
+				etm_out: endpoint {
+					remote-endpoint = <&etb_in>;
+				};
 			};
 		};
 	};
-- 
2.7.4

