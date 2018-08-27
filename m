Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B6BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6547C2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6547C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeH0Rtx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 13:49:53 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:17120 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeH0Rtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 13:49:53 -0400
X-IronPort-AV: E=Sophos;i="5.53,295,1531810800"; 
   d="scan'208";a="18751235"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 27 Aug 2018 07:03:07 -0700
Received: from eh-station.mchp-main.com (10.10.76.4) by
 CHN-SV-EXCH01.mchp-main.com (10.10.76.37) with Microsoft SMTP Server id
 14.3.352.0; Mon, 27 Aug 2018 07:03:06 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>
CC:     Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v7 RESEND 1/2] ARM: dts: at91: sama5d2: add channel cells for ADC device
Date:   Mon, 27 Aug 2018 16:57:12 +0300
Message-ID: <1535378233-10901-1-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Preparing the ADC device to connect channel consumer drivers

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Resending after merge window that includes the bindings was closed.
Rebased on 4.19-rc1 : no changes

 arch/arm/boot/dts/sama5d2.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 61f68e5..f06ba99 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -47,6 +47,7 @@
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/clock/at91.h>
+#include <dt-bindings/iio/adc/at91-sama5d2_adc.h>
 
 / {
 	model = "Atmel SAMA5D2 family SoC";
@@ -1437,6 +1438,7 @@
 				atmel,max-sample-rate-hz = <20000000>;
 				atmel,startup-time-ms = <4>;
 				atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
+				#io-channel-cells = <1>;
 				status = "disabled";
 			};
 
-- 
2.7.4

