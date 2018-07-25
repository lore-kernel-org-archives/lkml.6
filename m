Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D41F2C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9645620844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 12:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9645620844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeGYNic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 09:38:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33570 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728791AbeGYNic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 09:38:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id D0940208FF; Wed, 25 Jul 2018 14:27:01 +0200 (CEST)
Received: from localhost.localdomain (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4FFE8207AD;
        Wed, 25 Jul 2018 14:26:51 +0200 (CEST)
From:   Quentin Schulz <quentin.schulz@bootlin.com>
To:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linus.walleij@linaro.org
Cc:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 1/2] MIPS: mscc: ocelot: add interrupt controller properties to GPIO controller
Date:   Wed, 25 Jul 2018 14:26:20 +0200
Message-Id: <20180725122621.31713-1-quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO controller also serves as an interrupt controller for events
on the GPIO it handles.

An interrupt occurs whenever a GPIO line has changed.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 arch/mips/boot/dts/mscc/ocelot.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/dts/mscc/ocelot.dtsi b/arch/mips/boot/dts/mscc/ocelot.dtsi
index d7f0e3551500..afe8fc9011ea 100644
--- a/arch/mips/boot/dts/mscc/ocelot.dtsi
+++ b/arch/mips/boot/dts/mscc/ocelot.dtsi
@@ -168,6 +168,9 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&gpio 0 0 22>;
+			interrupt-controller;
+			interrupts = <13>;
+			#interrupt-cells = <2>;
 
 			uart_pins: uart-pins {
 				pins = "GPIO_6", "GPIO_7";
-- 
2.14.1

