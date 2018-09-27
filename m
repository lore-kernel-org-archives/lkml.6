Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CEDC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741A721537
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CxSuqDRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741A721537
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeI0LRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:17:51 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53942 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbeI0LRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:17:51 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8R50tHM017989;
        Thu, 27 Sep 2018 00:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538024455;
        bh=leBOwN/sG7kHs4Sm4Dyt0T3mIgV6v21q4PLMEMCCAuc=;
        h=From:To:CC:Subject:Date;
        b=CxSuqDRRy5idf0CeFcU7He74QXiZavAxahcPArNu9j8IPFrd1WeovdzicV/EOVwTl
         g4WQMEWuPazgsz4pvxGclZCneKrPxqKtXh0Dc04xQIdfpcgKi61z4yb2JB1iewd/E2
         t51BL49PxJn2jkcBk2yk/4lcfr34/qDUONH/i2bo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8R50tQC019327;
        Thu, 27 Sep 2018 00:00:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 27
 Sep 2018 00:00:55 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 27 Sep 2018 00:00:55 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8R50qVC005315;
        Thu, 27 Sep 2018 00:00:53 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH] arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address
Date:   Thu, 27 Sep 2018 10:31:46 +0530
Message-ID: <20180927050146.17847-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cbass_wakeup interconnect which is the parent of wakeup_uart node
defines address-cells=1 and size-cells=1, therefore fix up reg property
of wakeup_uart node accordingly. Otherwise, this UART instance fails to
probe if enabled.

Fixes: 4201af2544b3 ("arm64: dts: ti: am654: Add uart nodes")
Signed-off-by: Vignesh R <vigneshr@ti.com>
---

Based on next-20180926

 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index ee56959f4af8..c617393ea767 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -44,7 +44,7 @@
 
 	wkup_uart0: serial@42300000 {
 		compatible = "ti,am654-uart";
-		reg = <0x00 0x42300000 0x00 0x100>;
+		reg = <0x42300000 0x100>;
 		reg-shift = <2>;
 		reg-io-width = <4>;
 		interrupts = <GIC_SPI 697 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.19.0

