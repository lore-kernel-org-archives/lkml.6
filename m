Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66C3C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A122A20866
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 09:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="DNxqVr5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A122A20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393579AbeKVU1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 15:27:19 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:34188 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbeKVU1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 15:27:19 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAM9mAdh030201
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Thu, 22 Nov 2018 20:48:29 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1542880109; bh=VxbDn2ERucCe/efj0InIzv5N3YLJwkbfeQERfZB+d9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DNxqVr5HX/jCKhqT82+6XvLFd+FTUnQzUv23JRcK7ZHKPgEeXq5WwOskFHt4T/gEa
         aWcrbj7xvtalWXevewO0vZmw1iaxAxHgz9FA9FlEt5/UJR/5lQwdYzxSRnKh/B+FGr
         yFRt9azuYM3tPyPl6e1HyulB53TOGA6QwZcq5t5IXXVZdecPyNUzXPQXeoZ5zbabjf
         ZsVNX6eqx8NGd1viOeo3J3UC5kx9bHlOJSS+5JD0Lqi5wiUKJ7oshBobkcZ3A7en+G
         xt55Z0S6pOs0oUABMGOzbFTmT4Rs4jDTUagSo02yvqGCi6igryMjupwyQOhzG2CL2y
         8AMQu3iGg0anw==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, devicetree@vger.kernel.org
Subject: [PATCH v9 1/4] dt-bindings: pps: capture-clear addition
Date:   Thu, 22 Nov 2018 20:45:59 +1100
Message-Id: <20181122094602.5156-2-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181122094602.5156-1-tom@aussec.com>
References: <20181122094602.5156-1-tom@aussec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds documentation for the device tree capture-clear option.

Signed-off-by: Tom Burkart <tom@aussec.com>
---
 Documentation/devicetree/bindings/pps/pps-gpio.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pps/pps-gpio.txt b/Documentation/devicetree/bindings/pps/pps-gpio.txt
index 3683874832ae..1155d49c2699 100644
--- a/Documentation/devicetree/bindings/pps/pps-gpio.txt
+++ b/Documentation/devicetree/bindings/pps/pps-gpio.txt
@@ -10,6 +10,7 @@ Required properties:
 Optional properties:
 - assert-falling-edge: when present, assert is indicated by a falling edge
                        (instead of by a rising edge)
+- capture-clear: when present, also capture the PPS clear event
 
 Example:
 	pps {
@@ -18,6 +19,7 @@ Example:
 
 		gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 		assert-falling-edge;
+		capture-clear;
 
 		compatible = "pps-gpio";
 	};
-- 
2.12.3

