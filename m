Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0971EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78712081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="vOsBnknw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78712081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeK2Lap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:30:45 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:41418 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbeK2Lap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:30:45 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAT0QZ3T025194
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 29 Nov 2018 11:27:03 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1543451224; bh=aZrgIouvOgYx+lOAVPVHPpRC2xvj+q1LNGs+mERKBj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=vOsBnknwMHu+mZyqDjMd3srHbzgvlqlExjc5GjvG1O2+k9CkAqY1FSpT1LR6lWGXE
         Up8718YF9RQN27pHGJ8kmAIED37VudsmDnzpZag64qqSaaWHfZot4hs4diWgZnwAie
         0BnDIaoxyb+UzQxBT4DJF62w2ZPnzS+rYP4A0x36vxbbydJLhfa3atKR5Qg7c1U2mg
         nGS5UWGFfZLKBS+KHHMcFyjIXr31FSzLI9KH+Wtojxx3jolHI6P6plg1WCJ/BJ8U7v
         azlytFyPda8BstNNRoWSnvmDiAonREIj48o5IfuYOqXsPp/2jGujiMH28oyP8h6RVt
         gbKy4hWsIhiIA==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, devicetree@vger.kernel.org,
        Lukas Senger <lukas@fridolin.com>
Subject: [PATCH v11 2/3] dt-bindings: pps: pps-gpio PPS ECHO implementation
Date:   Thu, 29 Nov 2018 11:26:25 +1100
Message-Id: <20181129002626.5410-3-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181129002626.5410-2-tom@aussec.com>
References: <20181129002626.5410-1-tom@aussec.com>
 <20181129002626.5410-2-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the device tree changes required for the pps
echo functionality for pps-gpio, that sysfs claims is available
already.

This patch was originally written by Lukas Senger as part of a masters
thesis project and modified for inclusion into the linux kernel by Tom
Burkart.

Signed-off-by: Lukas Senger <lukas@fridolin.com>
Signed-off-by: Tom Burkart <tom@aussec.com>
---
 Documentation/devicetree/bindings/pps/pps-gpio.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
index 3683874832ae..3760c271f211 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -7,9 +7,14 @@ Required properties:
 - compatible: should be "pps-gpio"
 - gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
 
+Additional required properties for the PPS ECHO functionality:
+- echo-gpios: one PPS ECHO GPIO in the format described by ../gpio/gpio.txt
+- echo-active-ms: duration in ms of the active portion of the echo pulse
+
 Optional properties:
 - assert-falling-edge: when present, assert is indicated by a falling edge
                        (instead of by a rising edge)
+- invert-pps-echo: when present, invert the PPS ECHO pulse
 
 Example:
 	pps {
@@ -19,5 +24,9 @@ Example:
 		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		assert-falling-edge;
 
+		echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		echo-active-ms = <100>;
+		invert-pps-echo;
+
 		compatible = "pps-gpio";
 	};
-- 
2.12.3

