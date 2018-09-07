Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5815C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9709F2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:23:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9709F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeIGNCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:02:50 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:48576 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeIGNCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:02:50 -0400
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="20245111"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Sep 2018 01:23:00 -0700
Received: from ibiza.rfo.atmel.com (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Fri, 7 Sep 2018
 01:23:00 -0700
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl
Date:   Fri, 7 Sep 2018 10:18:51 +0200
Message-ID: <20180907081851.15911-1-ludovic.desroches@microchip.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drive strength has to be set to medium otherwise some data
corruption may happen.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
---

Hi,

This fix depends on the support of the drive-strength for the atmel pio4
pinctroller. It has been added in v4.19 but I omitted to send it at the
same time.

Ludovic

 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index b10dccd0958f..3b1baa8605a7 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -11,6 +11,7 @@
 #include "sama5d2-pinfunc.h"
 #include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/at91.h>
 
 / {
 	model = "Atmel SAMA5D2 PTC EK";
@@ -299,6 +300,7 @@
 							 <PIN_PA30__NWE_NANDWE>,
 							 <PIN_PB2__NRD_NANDOE>;
 						bias-pull-up;
+						atmel,drive-strength = <ATMEL_PIO_DRVSTR_ME>;
 					};
 
 					ale_cle_rdy_cs {
-- 
2.12.2

