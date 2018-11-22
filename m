Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F58BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FDA20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="BrfIu21o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FDA20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393620AbeKVU1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:27:39 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:34224 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbeKVU1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:27:38 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAM9mAdj030201
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 22 Nov 2018 20:48:37 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542880118; bh=GvoLStNdmblN/ljgTUrGrsbTu19DmjLOwDoKUmH3bqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BrfIu21o88AJ+H1MHy3+PHmPWvBqrxvJJ0Yc+M9hhPb+vt8pzcdHFHeVHufrqxotM
         4I6HQHLBQFtN2Q7rLy4Sw5DUKFxxeB6gjBGzpKH1oA2NNvAdh46XIoVp9APn2AmWtV
         L1ghdjK8fw6z385tuexMxYN00L/hXor8kq6jo/xM7NjogTXJ6YPZXmjrug1R/MeBOx
         dI/dlmCBbB7vpEODSCYXapDJR+d4cPJ/CWapMq5//bL/z6/LbMjFrklHGeR1AbWfN+
         GIED32FeGmCegp52Mtnp0ylFO3Ildz2az1pBk4vh6mZ3RUiLy/y3IiDjk9dYBZ/KCL
         GZg0hVyJEPmvQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, devicetree@vger.kernel.org,
        Lukas Senger <lukas@fridolin.com>
Subject: [PATCH v9 3/4] dt-bindings: pps: pps-gpio PPS ECHO implementation
Date:   Thu, 22 Nov 2018 20:46:01 +1100
Message-Id: <20181122094602.5156-4-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181122094602.5156-3-tom@aussec.com>
References: <20181122094602.5156-1-tom@aussec.com>
 <20181122094602.5156-2-tom@aussec.com>
 <20181122094602.5156-3-tom@aussec.com>
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
index 1155d49c2699..e09f6f2405c5 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -7,10 +7,15 @@ Required properties:
 - compatible: should be "pps-gpio"
 - gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
 
+Additional required properties for the PPS ECHO functionality:
+- echo-gpios: one PPS ECHO GPIO in the format described by ../gpio/gpio.txt
+- echo-active-ms: duration in ms of the active portion of the echo pulse
+
 Optional properties:
 - assert-falling-edge: when present, assert is indicated by a falling edge
                        (instead of by a rising edge)
 - capture-clear: when present, also capture the PPS clear event
+- invert-pps-echo: when present, invert the PPS ECHO pulse
 
 Example:
 	pps {
@@ -21,5 +26,9 @@ Example:
 		assert-falling-edge;
 		capture-clear;
 
+		echo-gpios = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		echo-active-ms = <100>;
+		invert-pps-echo;
+
 		compatible = "pps-gpio";
 	};
-- 
2.12.3

