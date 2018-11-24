Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AD5C04EBB
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD71F20868
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="u9NNhACM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD71F20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=aussec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeKXW3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 17:29:04 -0500
Received: from csm1.csm-office.com.au ([165.228.118.109]:44490 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbeKXW3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 17:29:04 -0500
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id wAOBeOqA008096
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sat, 24 Nov 2018 22:40:43 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1543059643; bh=VxbDn2ERucCe/efj0InIzv5N3YLJwkbfeQERfZB+d9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=u9NNhACME8NMyi9KW1F5p9on5CyC2GIaiTqUE13kFn5ivWfb77Qt6z6mveEZONowr
         lfv1nHunsXy/qYVQnHl8MZ/rZEAzt4oD3xc/Um0Wdz3aLuZh8sPf85kkaiJXBmS1mY
         DSFH3WOqvV7axd+7lIv40GqzQR1LuQNSBqz6o3IjtStoYepBkcZj4fogMU5izvjRAj
         +5vbZTjeCI/hU2qevYsaA9L6FBw3ec3Y3JzCqUv7y3si+9Br+teiKTj99wY1J+zemL
         yyY+niEZnwBCPJqfS0HjhX5oRW8Z7jyRU6qVSxcg73NKPSXkFef+iORNs3SslLRcss
         1iJyT6QD4RG1Q==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc:     Tom Burkart <tom@aussec.com>, devicetree@vger.kernel.org
Subject: [PATCH v10 1/4] dt-bindings: pps: capture-clear addition
Date:   Sat, 24 Nov 2018 22:38:09 +1100
Message-Id: <20181124113812.31700-2-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181124113812.31700-1-tom@aussec.com>
References: <20181124113812.31700-1-tom@aussec.com>
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

