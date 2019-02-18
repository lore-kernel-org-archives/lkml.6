Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437A12086C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550519339;
	bh=Vwca8hO+LibGD8+0CJHWfALb+VJ+1t08azDOmNdrltQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AXGfC7ZyU1PdHSe6vgW3T0ed9nDNx0rsCG1GhryokhwAwgJZviCsCPMPZRX+FZJUJ
	 M535bmHBLgtBAp/uVGJFVuX3SLvyfOiFj1/jH6dDpV9WIw5mApLjG7NtuCWtQ0Mtkd
	 kKyq0/oxnRpiGE9Pd73cqMQeMerOOwDo5js/V32w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfBRTs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfBRTsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:48:55 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2D2217F5;
        Mon, 18 Feb 2019 19:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550519334;
        bh=Vwca8hO+LibGD8+0CJHWfALb+VJ+1t08azDOmNdrltQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IsvsDjz8oBRFEph6mQSW2JI8RHrp6tRQJ8t3v0UI5rJaEkAJQuQGmiqZllgJHXL73
         iugL4v6quoggKjBQvPUWVpGa1QFmtR0lbrUG2Hdfq6FxbgVryhFJkaoyDNnOIhC03G
         eFN9XmBqm82ASLyTIxFHAXFfMmGR0DiP870dSyKg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Markus Reichl <reichl@t-online.de>
Subject: [PATCH 2/2] ARM: dts: exynos: Order nodes alphabetically in Arndale Octa
Date:   Mon, 18 Feb 2019 20:48:41 +0100
Message-Id: <20190218194841.21374-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218194841.21374-1-krzk@kernel.org>
References: <20190218194841.21374-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having nodes and overrides-by-label ordered alphabetically reduces the
possibility of conflicts from simultaneous edits.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 2b227246c685..6b4bf5ee2e45 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -51,6 +51,10 @@
 	};
 };
 
+&cci {
+	status = "disabled";
+};
+
 &cpu0 {
 	cpu-supply = <&buck2_reg>;
 };
@@ -323,14 +327,6 @@
 	};
 };
 
-&usbdrd_dwc3_1 {
-	dr_mode = "host";
-};
-
-&cci {
-	status = "disabled";
-};
-
 &hdmi {
 	hpd-gpios = <&gpx3 7 GPIO_ACTIVE_HIGH>;
 	vdd_osc-supply = <&ldo7_reg>;
@@ -724,3 +720,7 @@
 	clocks = <&clock CLK_RTC>, <&s2mps11_osc S2MPS11_CLK_AP>;
 	clock-names = "rtc", "rtc_src";
 };
+
+&usbdrd_dwc3_1 {
+	dr_mode = "host";
+};
-- 
2.17.1

