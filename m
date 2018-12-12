Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6343C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AF320870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 02:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="Zr+mYxxH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AF320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLLCxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:53:18 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:55176 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbeLLCxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 21:53:18 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain ([1.128.224.233])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wBC2qbuY002983
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Wed, 12 Dec 2018 13:53:06 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1544583187; bh=ntkkHZ/NBuS6dueZtnOdsAm746bQeXqspMV4Gssbllw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Zr+mYxxH5XrNOTWnGcJu8RW6o/Yw1M5aE4u1DXPHwdD9DaVearCb1O8rY/EWbhJz+
         1N2/Dxk/zSsJ8IL0OYa94xpL1vkuN7q/GqIEH8uaKkZ6HuQat45jKCY3MM4OdJq8CA
         vGNa2rMVqZpD30FgYVFeqaFkiGuA3CNDzL4JWWZ1luPlwwielPI9+TAhTNhh2QqR6N
         CMVcnhVVlfS/vMEX/xWcK8s9CmWVGg1voueL4WOiOyK/ruqOq1+8EwFaydW5GfpQpM
         nnqFGA+Mn88OD8pu6a957IyIx8qq22AnFdeA1AuIqXfItglnCu4BDm6AXahX4F7aF2
         9lLSafEFlkzgg==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, devicetree@vger.kernel.org,
        Lukas Senger <lukas@fridolin.com>
Subject: [PATCH v12 2/3] dt-bindings: pps: pps-gpio PPS ECHO implementation
Date:   Wed, 12 Dec 2018 13:52:13 +1100
Message-Id: <20181212025214.29911-3-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181212025214.29911-2-tom@aussec.com>
References: <20181212025214.29911-1-tom@aussec.com>
 <20181212025214.29911-2-tom@aussec.com>
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

