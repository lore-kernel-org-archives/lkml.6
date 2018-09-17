Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CFAECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8551A214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 11:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8551A214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbeIQRHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 13:07:11 -0400
Received: from shell.v3.sk ([90.176.6.54]:47121 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbeIQRHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 13:07:09 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 33D06AD8FC;
        Mon, 17 Sep 2018 13:40:10 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MBhsnkIt30f6; Mon, 17 Sep 2018 13:40:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B5087ACF8C;
        Mon, 17 Sep 2018 13:40:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id hiQoKGcFoNE1; Mon, 17 Sep 2018 13:40:03 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4CB14ADC9F;
        Mon, 17 Sep 2018 13:40:03 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] DT: marvell,mmp2: add more TWSI controllers
Date:   Mon, 17 Sep 2018 13:39:47 +0200
Message-Id: <20180917113947.12626-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180917113947.12626-1-lkundrak@v3.sk>
References: <20180917113947.12626-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've gotten the base addresses, clocks and interrupts from an rusty and old
out-of-tree driver. I haven't actually checked against the datasheet, since
that one is reserved for the Marvell inner circle.

Tested with an accelerometer on TWSI6 on an OLPC XO 1.75 machine.

Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 49 +++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 47e5b63339d1..2bd4e94501ce 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -232,6 +232,55 @@
 				status = "disabled";
 			};
 
+			twsi3: i2c@d4032000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4032000 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <1>;
+				clocks = <&soc_clocks MMP2_CLK_TWSI2>;
+				resets = <&soc_clocks MMP2_CLK_TWSI2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			twsi4: i2c@d4033000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4033000 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <2>;
+				clocks = <&soc_clocks MMP2_CLK_TWSI3>;
+				resets = <&soc_clocks MMP2_CLK_TWSI3>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+
+			twsi5: i2c@d4033800 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4033800 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <3>;
+				clocks = <&soc_clocks MMP2_CLK_TWSI4>;
+				resets = <&soc_clocks MMP2_CLK_TWSI4>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
+			twsi6: i2c@d4034000 {
+				compatible = "mrvl,mmp-twsi";
+				reg = <0xd4034000 0x1000>;
+				interrupt-parent = <&intcmux17>;
+				interrupts = <4>;
+				clocks = <&soc_clocks MMP2_CLK_TWSI5>;
+				resets = <&soc_clocks MMP2_CLK_TWSI5>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			rtc: rtc@d4010000 {
 				compatible = "mrvl,mmp-rtc";
 				reg = <0xd4010000 0x1000>;
-- 
2.17.1

