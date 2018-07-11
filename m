Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82575C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30D16208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="UjBeUtZs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D16208EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbeGKBff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:35:35 -0400
Received: from onstation.org ([52.200.56.107]:37666 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732330AbeGKBfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:35:34 -0400
Received: from xilitla.hsd1.wv.comcast.net (c-98-236-77-125.hsd1.wv.comcast.net [98.236.77.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id A057D142;
        Wed, 11 Jul 2018 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1531272827;
        bh=959YFxcWCLZVI4hQI3Tk1DqfGaWD7+2zxytQimNMVk4=;
        h=From:To:Cc:Subject:Date:From;
        b=UjBeUtZsMlLAhiBehTMmmi7BjY9DmVicGs+PnfEYdVeOXDiJlJjvZbXbn5yMur+tX
         3EAIuNZM1ekeC2wFwa0zyhrpdLK9eZyFS3xoNaQ9JBvlAXnZmFVdSk2X1cww/aTfQG
         C8Od4WnY5pbNXke604CyK8qdxs+HtOVWfiaAQIQg=
From:   Brian Masney <masneyb@onstation.org>
To:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: bmp280: remove unused options from device tree documentation
Date:   Tue, 10 Jul 2018 21:33:45 -0400
Message-Id: <20180711013345.22951-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several options in the device tree documentation that are
no longer relevant for the current in-kernel bmp280 driver so this patch
removes them.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 Documentation/devicetree/bindings/iio/pressure/bmp085.txt | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
index c7198a03c906..abcab02504fb 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.txt
@@ -8,10 +8,6 @@ Required properties:
   "bosch,bme280"
 
 Optional properties:
-- chip-id: configurable chip id for non-default chip revisions
-- temp-measurement-period: temperature measurement period (milliseconds)
-- default-oversampling: default oversampling value to be used at startup,
-  value range is 0-3 with rising sensitivity.
 - interrupt-parent: should be the phandle for the interrupt controller
 - interrupts: interrupt mapping for IRQ
 - reset-gpios: a GPIO line handling reset of the sensor: as the line is
@@ -24,9 +20,6 @@ Example:
 pressure@77 {
 	compatible = "bosch,bmp085";
 	reg = <0x77>;
-	chip-id = <10>;
-	temp-measurement-period = <100>;
-	default-oversampling = <2>;
 	interrupt-parent = <&gpio0>;
 	interrupts = <25 IRQ_TYPE_EDGE_RISING>;
 	reset-gpios = <&gpio0 26 GPIO_ACTIVE_LOW>;
-- 
2.17.1

