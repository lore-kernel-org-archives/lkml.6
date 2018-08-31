Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E85C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CD42083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Zkrv7OZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13CD42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeHaX0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:26:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36146 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaX0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:26:42 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJHXmN108527;
        Fri, 31 Aug 2018 14:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535743053;
        bh=mC8hbOH5u5O4SoE5F9HKpl8nUL4CNQBWbsC6rlKgP/U=;
        h=From:To:CC:Subject:Date;
        b=Zkrv7OZKus68HJjtCqH9Xo3UF/jWwJqyPsVU2OZLKLl6ug+M7zCfj3GRtYK/irwuG
         fXqqOLXeZp/EFqq+IX7dnKe1wuMqrogrqQfQjzNYd6pmqL4x8tQNcmAww9kFE0+CuK
         IV9P7S3a3ewSIbsrSaRUYvyX4s/xneSaN255qboE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJHX3J031225;
        Fri, 31 Aug 2018 14:17:33 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:17:33 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:17:33 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJHXaO027142;
        Fri, 31 Aug 2018 14:17:33 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJHWx13637;
        Fri, 31 Aug 2018 14:17:32 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 1/2] ARM: dts: imx6: RDU2: Fix the audio CODEC's reset pin
Date:   Fri, 31 Aug 2018 14:17:31 -0500
Message-ID: <20180831191732.25504-1-afd@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: d763762e3b58 ("ARM: dts: imx6: add ZII RDU2 boards")

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 7fff3717cf7c..a0f5cfda0055 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -384,7 +384,7 @@
 		AVDD-supply = <&reg_3p3v>;
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&vgen4_reg>;
-		gpio-reset = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 	};
 
 	accel@1c {
@@ -572,7 +572,7 @@
 		AVDD-supply = <&reg_3p3v>;
 		IOVDD-supply = <&reg_3p3v>;
 		DVDD-supply = <&vgen4_reg>;
-		gpio-reset = <&gpio1 0 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	};
 
 	touchscreen@20 {
-- 
2.18.0

