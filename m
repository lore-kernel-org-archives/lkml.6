Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F75C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEAF82083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 04:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="KpWeCEsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAF82083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbeGZFRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 01:17:53 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:42607 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbeGZFRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 01:17:53 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0D2EB86CE8;
        Thu, 26 Jul 2018 16:03:01 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1532577781;
        bh=M5xMa/UVXLiKVVCQPtdNFmnqyTQljPKpXtDIxHJo++Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KpWeCEsffuZAH81jd1ivMs0qVrnUaVcXCfKEnQBa7WW++Ptud0eGWFP3ht8S8ltyd
         RQfRvENCJhK2AKdt9D1659zAZ9CJnSGm0QPUnjP9dTQmheOwcfQecCAxEc2B1QtEdK
         zjfUUQXLBx0ye7F6qWR5bhh/F+byM9+YDPpAHt2A=
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b5947f50003>; Thu, 26 Jul 2018 16:03:01 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
        by smtp (Postfix) with ESMTP id 47F7913ED1C;
        Thu, 26 Jul 2018 16:03:02 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id E21561E262C; Thu, 26 Jul 2018 16:03:00 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jason@lakedaemon.net,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 3/4] ARM: dts: mvebu: db-xc3-24g4: use new style nand binding
Date:   Thu, 26 Jul 2018 16:02:56 +1200
Message-Id: <20180726040257.22285-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
References: <20180726040257.22285-1-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the nand flash binding to the new style.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
index d58ea48cb151..df048050615f 100644
--- a/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
+++ b/arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts
@@ -69,12 +69,16 @@
 
 &nand_controller {
 	status = "okay";
-	label = "pxa3xx_nand-0";
-	num-cs = <1>;
-	marvell,nand-keep-config;
-	nand-on-flash-bbt;
-	nand-ecc-strength = <4>;
-	nand-ecc-step-size = <512>;
+
+	nand@0 {
+		reg = <0>;
+		label = "pxa3xx_nand-0";
+		nand-rb = <0>;
+		marvell,nand-keep-config;
+		nand-on-flash-bbt;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+	};
 };
 
 &spi0 {
-- 
2.18.0

