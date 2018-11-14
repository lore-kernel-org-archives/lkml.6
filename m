Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1894C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16FB22419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="oAR0yRsy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16FB22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbeKNW6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:58:36 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:48350 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732278AbeKNW6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:58:35 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAECsstW003333
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Wed, 14 Nov 2018 23:55:19 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542200119; bh=u1gvbTXIXREuXP4V1T7NSdoBcitO5OT1wrR7uyNNtCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=oAR0yRsyiHb/ck7Yx58FVYTjyUcYhmcB41sUMaewL9NU9X51MIgMqGM6zBiV5MLgt
         QfRU5cLhXysYfCjx8Egf9QJuIK6fNuIQjPdUdqN/RLdh6HDet4i0DD23vivJeKVasb
         YhVCDeTnTpXrKamMvisTn3gToW5lHWDeHTG1YOp9gyDArcNo/dH5Y5glInry3LKW4Y
         PIYyw7tAJLk1T1px70hbEkecMTYGA7JUKI9mlqYkRy95qGthxbGg2NPy+Q954b3xpG
         qBRL/A92UybHfKCxkI8uT6rsJR51Ad1S8T4pzd70tRY+fGtU3ec2GfG1WIfrgmm0bO
         VyhG3wcH1dVFQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, devicetree@vger.kernel.org
Subject: [PATCH v7 1/4] dt-bindings: pps: descriptor-based gpio, capture-clear addition
Date:   Wed, 14 Nov 2018 23:54:29 +1100
Message-Id: <20181114125432.16044-2-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181114125432.16044-1-tom@aussec.com>
References: <20181114125432.16044-1-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the devicetree bindings for the pps-gpio driver
from the integer based ABI to the descriptor based ABI.  It also adds
documentation for the device tree capture-clear option.  The legacy
device tree entry for the GPIO pin is supported.

Signed-off-by: Tom Burkart <tom@aussec.com>
---
 Documentation/devicetree/bindings/pps/pps-gpio.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
index 3683874832ae..6c9fc0998d94 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -5,19 +5,23 @@ a GPIO pin.
 
 Required properties:
 - compatible: should be "pps-gpio"
-- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
+- pps-gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
+Alternatively (DEPRECATED), instead of pps-gpios above, it may have:
+- gpios: one PPS GPIO as above
 
 Optional properties:
 - assert-falling-edge: when present, assert is indicated by a falling edge
                        (instead of by a rising edge)
+- capture-clear: when present, also capture the PPS clear event
 
 Example:
 	pps {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pps>;
 
-		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
+		pps-gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		assert-falling-edge;
+		capture-clear;
 
 		compatible = "pps-gpio";
 	};
-- 
2.12.3

