Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046B5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5F92243E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xkaU0QK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5F92243E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbeKOIs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:48:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbeKOI1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:20 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B92E62252B;
        Wed, 14 Nov 2018 22:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234136;
        bh=cuU0Y+1+4MZu70SiMPCRSVcfvRFKuwfmbGfpe+0Mauk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkaU0QK9LENunMmXQ01FTna91kNyXfJzQ6tUPN9PacoB59e82Pvs1oRgjhjnkOJ49
         W3W9ppdTvgffrxQZEqiqzI9ocMQzbmU2KEM0WKGYx2PfKUZO9JRj6fsBz77s0CpyHK
         WBwSHiqzQXUUzXVAHRHT+tv/47kjTQFvQD/kT1L8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 35/73] arm64: dts: renesas: condor: switch from EtherAVB to GEther
Date:   Wed, 14 Nov 2018 17:21:29 -0500
Message-Id: <20181114222207.98701-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[ Upstream commit eab53fdfd60a84b0cc514d4f1f5d79226c76df01 ]

The "official" Condor boards have always been wired to mount NFS via
GEther, not EtherAVB -- the boards resoldered for EtherAVB were local
to Cogent Embedded, so we've been having an unpleasant situation where
a "normal" Condor board still can't mount NFS (unless an EtherAVB PHY
extension board is plugged in). Switch from EtherAVB to GEther at last!

Fixes: 8091788f3d38 ("arm64: dts: renesas: condor: add EtherAVB support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/renesas/r8a77980-condor.dts      | 47 ++++++++++---------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
index 9f25c407dfd7..e830b6162375 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -15,7 +15,7 @@
 
 	aliases {
 		serial0 = &scif0;
-		ethernet0 = &avb;
+		ethernet0 = &gether;
 	};
 
 	chosen {
@@ -47,23 +47,6 @@
 	};
 };
 
-&avb {
-	pinctrl-0 = <&avb_pins>;
-	pinctrl-names = "default";
-
-	phy-mode = "rgmii-id";
-	phy-handle = <&phy0>;
-	renesas,no-ether-link;
-	status = "okay";
-
-	phy0: ethernet-phy@0 {
-		rxc-skew-ps = <1500>;
-		reg = <0>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
-	};
-};
-
 &canfd {
 	pinctrl-0 = <&canfd0_pins>;
 	pinctrl-names = "default";
@@ -82,6 +65,23 @@
 	clock-frequency = <32768>;
 };
 
+&gether {
+	pinctrl-0 = <&gether_pins>;
+	pinctrl-names = "default";
+
+	phy-mode = "rgmii-id";
+	phy-handle = <&phy0>;
+	renesas,no-ether-link;
+	status = "okay";
+
+	phy0: ethernet-phy@0 {
+		rxc-skew-ps = <1500>;
+		reg = <0>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <23 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -118,16 +118,17 @@
 };
 
 &pfc {
-	avb_pins: avb {
-		groups = "avb_mdio", "avb_rgmii";
-		function = "avb";
-	};
-
 	canfd0_pins: canfd0 {
 		groups = "canfd0_data_a";
 		function = "canfd0";
 	};
 
+	gether_pins: gether {
+		groups = "gether_mdio_a", "gether_rgmii",
+			 "gether_txcrefclk", "gether_txcrefclk_mega";
+		function = "gether";
+	};
+
 	i2c0_pins: i2c0 {
 		groups = "i2c0";
 		function = "i2c0";
-- 
2.17.1

