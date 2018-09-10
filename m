Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FC6C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5FED20833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5FED20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeIJQxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 12:53:50 -0400
Received: from shell.v3.sk ([90.176.6.54]:36055 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbeIJQxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 12:53:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id C00E0B82E6;
        Mon, 10 Sep 2018 14:00:03 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0XzoyFYtrThO; Mon, 10 Sep 2018 13:59:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7B388B82D7;
        Mon, 10 Sep 2018 13:59:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j4uIfSsATzg8; Mon, 10 Sep 2018 13:59:51 +0200 (CEST)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 5717DB82D9;
        Mon, 10 Sep 2018 13:59:50 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 5/5] DT: marvell,mmp2: add SSP1 and SSP3
Date:   Mon, 10 Sep 2018 13:59:35 +0200
Message-Id: <20180910115935.163121-6-lkundrak@v3.sk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910115935.163121-1-lkundrak@v3.sk>
References: <20180910115935.163121-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There seem to be SSP2, SSP4 and perhaps SSP5 too, but Marvel keeps their
base addresses secret.

The SSP1 and SSP3 addresses were taken from OLPC 1.75, OpenFirmware and
kernel respectively.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp2.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 766bbb8495b6..ba55d6483ed0 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -18,6 +18,8 @@
 		serial3 = &uart4;
 		i2c0 = &twsi1;
 		i2c1 = &twsi2;
+		spi0 = &ssp1;
+		spi3 = &ssp3;
 	};
 
 	soc {
@@ -239,6 +241,22 @@
 				resets = <&soc_clocks MMP2_CLK_RTC>;
 				status = "disabled";
 			};
+
+			ssp1: ssp@d4035000 {
+				compatible = "marvell,mmp2-ssp";
+				reg = <0xd4035000 0x1000>;
+				clocks = <&soc_clocks MMP2_CLK_SSP0>;
+				interrupts = <0>;
+				status = "disabled";
+			};
+
+			ssp3: ssp@d4037000 {
+				compatible = "marvell,mmp2-ssp";
+				reg = <0xd4037000 0x1000>;
+				clocks = <&soc_clocks MMP2_CLK_SSP2>;
+				interrupts = <20>;
+				status = "disabled";
+			};
 		};
 
 		soc_clocks: clocks{
-- 
2.17.1

