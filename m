Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432CBC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E526D2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="UU7TmFl/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E526D2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbeGZFRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:17:54 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42597 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbeGZFRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:17:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C5A2D8448D;
        Thu, 26 Jul 2018 16:03:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532577780;
        bh=fSHTauMTwrBtABkb9Jf/5Zb4/dHN3QA9eArawq978kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UU7TmFl/erLFWvV7n4Gdz7CzmzyLNl/lj6ALOmbuH6m7XsHCDp80rjDwcx3scyGjn
         1Lehpi8cuDboHeBxZP3lkaHunwkzvq/qTdXDCLLZ4eXrDMrn1EvoLF3Q3zUyyxCT8U
         TxJDTT8fiaA6E/FtLHmO8jXNYmc/XLfCPxEgS5z4=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5947f50001>; Thu, 26 Jul 2018 16:03:01 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 14E3513ED1C;
        Thu, 26 Jul 2018 16:03:02 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id AF0281E262C; Thu, 26 Jul 2018 16:03:00 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jason@lakedaemon.net,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/4] ARM: dts: mvebu: 98dx3236: Rename nand controller node
Date:   Thu, 26 Jul 2018 16:02:54 +1200
Message-Id: <20180726040257.22285-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
References: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the 98dx3236 SoC and dependent boards to use
"nand-controller" instead of "nand".

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi     | 2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts      | 2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index 8d708cc22495..eb03a5773903 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -189,7 +189,7 @@
 				};
 			};
 
-			nand: nand@d0000 {
+			nand_controller: nand-controller@d0000 {
 				clocks = <&dfx_coredivclk 0>;
 			};
 
diff --git a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
index f42fc6118b7c..944e0a9c9dac 100644
--- a/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
+++ b/arch/arm/boot/dts/armada-xp-db-dxbc2.dts
@@ -68,7 +68,7 @@
 	status = "okay";
 };
 
-&nand {
+&nand_controller {
 	status = "okay";
 	label = "pxa3xx_nand-0";
 	num-cs = <1>;
diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index 8432f517e346..d58ea48cb151 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -67,7 +67,7 @@
 	status = "okay";
 };
 
-&nand {
+&nand_controller {
 	status = "okay";
 	label = "pxa3xx_nand-0";
 	num-cs = <1>;
-- 
2.18.0

