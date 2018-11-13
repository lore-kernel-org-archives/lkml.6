Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2115C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CC5223DD
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 04:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="UhnA19tc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CC5223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbeKMOBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 09:01:48 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:40420 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 09:01:48 -0500
X-Greylist: delayed 1347 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Nov 2018 09:01:47 EST
X-Virus-Scanned: amavisd-new at aussec.com
Received: from localhost.localdomain (dhcp-3-227.csm-office.com.au [172.16.3.227])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAD3gTrh014074
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Tue, 13 Nov 2018 14:43:05 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542080585; bh=cMTLpzofMexiv4sRJkvGep6q1Wy2B8Q4EKqWearahG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UhnA19tc6bIbMKBXKDlUpASztprxy6ErMwAv7KBM8wxLF96bVzDfLpdqSiVAMX6uW
         xKSCNvR+hIye6f6EmQVEt82vDkB5+4n29HsVsF/rQ1sKkKMbVmVp7WRq3SbsfRO/mv
         2XiRm7V6H3zUX+bctHozG0dtY/8ppE3q93HfSNhV+NIccAzfTikQ2T3VI0LwsUPxcK
         wyXAF01kXPma7PdMpIbw9jERI0wv63jCUcehe8OaR4XOLAaAYX8J559WdUIwhrlghi
         2SuWeFR+K3EkSF+lEN0hs3g0w5vbOCQGntjkpGgE7zW4h0T9Lv+PerBSjCV+1zyKYS
         cUGIuQJl+tIuQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, devicetree@vger.kernel.org
Subject: [PATCH v6 1/4] dt-bindings: pps: descriptor-based gpio, capture-clear addition
Date:   Tue, 13 Nov 2018 14:40:04 +1100
Message-Id: <20181113034007.3878-2-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181113034007.3878-1-tom@aussec.com>
References: <20181113034007.3878-1-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the devicetree bindings for the pps-gpio driver
from the integer based API to the descriptor based API.  It also adds
documentation for the device tree capture-clear option.

The change from integer based GPIO API to the descriptor based API
breaks backward compatibility for the devicetree.  This is due to
the descriptor based API appending "-gpio" or "-gpios" (see
Documentation/gpio/base.txt.)

Signed-off-by: Tom Burkart <tom@aussec.com>
---
 Documentation/devicetree/bindings/pps/pps-gpio.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
index 3683874832ae..f7789e48a022 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -5,19 +5,21 @@ a GPIO pin.
 
 Required properties:
 - compatible: should be "pps-gpio"
-- gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
+- pps-gpios: one PPS GPIO in the format described by ../gpio/gpio.txt
 
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

