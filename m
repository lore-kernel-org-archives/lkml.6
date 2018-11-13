Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A31BDC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E6A223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="R4AlbJYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68E6A223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbeKMOBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:01:52 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:40420 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730729AbeKMOBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:01:51 -0500
X-Greylist: delayed 1347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 09:01:47 EST
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain (dhcp-3-227.csm-office.com.au [172.16.3.227])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAD3gTrj014074
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 13 Nov 2018 14:43:22 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542080603; bh=7u/1zhFN3+RvfS70xCejVchRz3as1x2n2R30HlxmIJU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=R4AlbJYyc0Xj9+89Uoc8ewVVSAzQOt+yN/2WyTfp0ZrzXAwFiwpdtUDf7qTkDhVsd
         9RcFUGVWn2KWpw+Nzq8yteiRkWnIScISyUehTJqNCAHWFIFUa+MqMIBQLFcwGtgrE4
         D7Z4Rm5Iw81SGcRqILpn60XuX7jsFJDbmEjW8rAJDtghdCMCeJJlDv2JKgSB4t9KSh
         pFc8guSKpvaqvsJ3soNVLcpbVFqROH51kTbd5ZjlfyKyXTUZJ0FkjLrIYTxEDudm+l
         cDyF1Cik+muILLJokLc5KucsVjwWKYvMjVHJPvAvmh1QQ3eRu8kmcCfRNEqneJs93a
         ShO4zsuswbFJw==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, devicetree@vger.kernel.org,
        Lukas Senger <lukas@fridolin.com>
Subject: [PATCH v6 3/4] dt-bindings: pps: pps-gpio PPS ECHO implementation
Date:   Tue, 13 Nov 2018 14:40:06 +1100
Message-Id: <20181113034007.3878-4-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181113034007.3878-3-tom@aussec.com>
References: <20181113034007.3878-1-tom@aussec.com>
 <20181113034007.3878-2-tom@aussec.com>
 <20181113034007.3878-3-tom@aussec.com>
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
index f7789e48a022..dabf885e568a 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -7,10 +7,15 @@ Required properties:
 - compatible: should be "pps-gpio"
 - pps-gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
 
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

