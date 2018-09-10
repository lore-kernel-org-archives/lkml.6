Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6736C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AF120855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AF120855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeIJQ4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:56:37 -0400
Received: from shell.v3.sk ([90.176.6.54]:36100 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbeIJQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:56:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BE1BBB8258;
        Mon, 10 Sep 2018 14:02:49 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id euyuptyfd3Yk; Mon, 10 Sep 2018 14:02:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 16C0FB82EA;
        Mon, 10 Sep 2018 14:02:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xfUe-IJueH1C; Mon, 10 Sep 2018 14:02:46 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7C010B82D8;
        Mon, 10 Sep 2018 14:02:46 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH] DT: marvell,mmp2: add MMC controllers
Date:   Mon, 10 Sep 2018 14:02:43 +0200
Message-Id: <20180910120243.163979-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's apparently four of them on a MMP2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 40 +++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..51d4a2d70db9 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -18,6 +18,10 @@
 		serial3 = &uart4;
 		i2c0 = &twsi1;
 		i2c1 = &twsi2;
+		sdhci0 = &mmc1;
+		sdhci1 = &mmc2;
+		sdhci2 = &mmc3;
+		sdhci3 = &mmc4;
 	};
 
 	soc {
@@ -239,6 +243,42 @@
 				resets = <&soc_clocks MMP2_CLK_RTC>;
 				status = "disabled";
 			};
+
+			mmc1: mmc@d4280000 {
+				compatible = "mrvl,pxav3-mmc";
+				reg = <0xd4280000 0x120>;
+				clocks = <&soc_clocks MMP2_CLK_SDH0>;
+				clock-names = "io";
+				interrupts = <39>;
+				status = "disabled";
+			};
+
+			mmc2: mmc@d4280800 {
+				compatible = "mrvl,pxav3-mmc";
+				reg = <0xd4280800 0x120>;
+				clocks = <&soc_clocks MMP2_CLK_SDH1>;
+				clock-names = "io";
+				interrupts = <52>;
+				status = "disabled";
+			};
+
+			mmc3: mmc@d4281000 {
+				compatible = "mrvl,pxav3-mmc";
+				reg = <0xd4281000 0x120>;
+				clocks = <&soc_clocks MMP2_CLK_SDH2>;
+				clock-names = "io";
+				interrupts = <53>;
+				status = "disabled";
+			};
+
+			mmc4: mmc@d4288000 {
+				compatible = "mrvl,pxav3-mmc";
+				reg = <0xd4281800 0x120>;
+				clocks = <&soc_clocks MMP2_CLK_SDH3>;
+				clock-names = "io";
+				interrupts = <54>;
+				status = "disabled";
+			};
 		};
 
 		soc_clocks: clocks{
-- 
2.17.1

