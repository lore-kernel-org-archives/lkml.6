Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19241C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 08:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62012173B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 08:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="OWZPUnzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbeL3IfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 03:35:11 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:57160 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeL3IfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 03:35:11 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain ([1.132.227.105])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wBU8YAfu019893
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sun, 30 Dec 2018 19:34:41 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1546158883; bh=hW0k090UnqnrvIFcQrBoyopFFP36BdmUVkhRVU9FjQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=OWZPUnzty317D1TD5bcZOEf7Z2FSiHI3rbZ7++A+XbC/cECV9b4F03Js/7o7gEoI2
         bnARLUo1HmLTFcwyyqW/+kOxaw3Y85TQHljIIy2dcM56/uuWnyVoJxxTmrssGFa/hX
         NSxQXBMJu0+rd9GEMjUcJmECkOtTpsLADZ/4rNPIqD6Hb3XFC/TJOtFY9fLBTr+lrc
         2Qpq6gwj9nurwSajP8liETCHJqzhQcn/rbRCtuoOxBB9C9hjE+BfxfD39DsV7knmtY
         UwFpTcRV0NP9XzxQnJ6foxzZ3Xx8Fa7nj8l3T9x43p7rXBHsRXAB24BNnHYu37I/D4
         8Bjvv3I1EOFLg==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, devicetree@vger.kernel.org,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ricardo Martins <rasm@fe.up.pt>,
        James Nuss <jamesnuss@nanometrics.ca>,
        Lukas Senger <lukas@fridolin.com>
Subject: [PATCH v14 2/3] dt-bindings: pps: pps-gpio PPS ECHO implementation
Date:   Sun, 30 Dec 2018 19:33:32 +1100
Message-Id: <20181230083333.27210-3-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181230083333.27210-2-tom@aussec.com>
References: <20181230083333.27210-1-tom@aussec.com>
 <20181230083333.27210-2-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the device tree binding changes required for the
pps echo functionality for pps-gpio, that sysfs claims is available
already.

This patch was originally written by Lukas Senger as part of a masters
thesis project and modified for inclusion into the linux kernel by Tom
Burkart.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lukas Senger <lukas@fridolin.com>
Signed-off-by: Tom Burkart <tom@aussec.com>
---
 Documentation/devicetree/bindings/pps/pps-gpio.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
index 3683874832ae..9012a2a02e14 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -7,6 +7,10 @@ Required properties:
 - compatible: should be "pps-gpio"
 - gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
 
+Additional required properties for the PPS ECHO functionality:
+- echo-gpios: one PPS ECHO GPIO in the format described by ../gpio/gpio.txt
+- echo-active-ms: duration in ms of the active portion of the echo pulse
+
 Optional properties:
 - assert-falling-edge: when present, assert is indicated by a falling edge
                        (instead of by a rising edge)
@@ -19,5 +23,8 @@ Example:
 		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		assert-falling-edge;
 
+		echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		echo-active-ms = <100>;
+
 		compatible = "pps-gpio";
 	};
-- 
2.12.3

