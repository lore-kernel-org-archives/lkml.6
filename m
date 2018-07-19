Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EEAC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850EA206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSwvFrVp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850EA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbeGSJta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:49:30 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40925 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeGSJt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:49:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so5567187wma.5;
        Thu, 19 Jul 2018 02:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vbGoibFrZ0Vu03VQLybN68FBuCS4ui9YNJNUT8a6wds=;
        b=sSwvFrVpEHGW8JxWJTcK/sNa/9TIwAjLs/qJ0FoZHyZLkTEuu4Mvo77KWwv3xW0hj7
         iv7weNu3slhYnjkY29SEkA17znWQ3oL42WOdi3dhD3cgek5GhE37R4BkZ/dwjszCkNzD
         5+/OxHZYjwYHkqMSKJ8HWGApp2BVf6y+fSQjbV9QqvEO2hJyAngEB3sbP4Nv+7mD+Wtd
         qmJ2UyTjtVcLt0Y4GGF9K2ykkrM7d4JBlHzGsuc0bOFg0pMP0jlY26FGuuuRZQPh43I6
         SJh0Fs04yUbmyxa2WgBXifwwUJIbg45uKey/zp2hmkVeDtFiwxvDvkQ2iQ3kYFwYkNbe
         ghRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vbGoibFrZ0Vu03VQLybN68FBuCS4ui9YNJNUT8a6wds=;
        b=YdG5RYFM/iMaZGVMgvKNk9FcE9+frfg5eadymvomDxRYsaYJ45zmDHP+QcHhFHEWoG
         MU4oxfMIQ47DQGU5NcvRKZ1haLLnhdv/Z7LEpZH2Y/p3osYzodZpThgXv1dWFaTtgnv6
         cHnkZuRkwjjYO4ClE13MyTDw0UCgB1Hb+Zh1WCkYlMR1XWX+MuFZQf2rp1X13PTxsbvC
         CiLAeXr8hTuF6QPqw94am68IiPR2VQexvouNQxzOFPMItQTxNexC63Xl1WCRgqKqfbiR
         xEm+Gy4eQYCmKRvV7yi8L4E4yT7wvL0eF7K3wzrIZ1W+AOvI4Aa7Cx/Zy57S+kbvDNns
         NBPw==
X-Gm-Message-State: AOUpUlGhYYvC3SI3jtP/0fAn62oCPPdi7Yl7s32ex9kI97T9TCPnvXZ5
        gu7VvbM4ipoIq6GMOK74/1M=
X-Google-Smtp-Source: AAOMgpeGmnGT+Os2ME7fh5UN3MWRqzB5WWyRolhYK7AfMFFVQgEQvY+GEAvQQHVgqIaWXsKqhCaZtQ==
X-Received: by 2002:a1c:e5cf:: with SMTP id c198-v6mr3741923wmh.113.1531991236388;
        Thu, 19 Jul 2018 02:07:16 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id j11-v6sm8162160wrr.37.2018.07.19.02.07.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 02:07:15 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v7 4/5] arm64: dts: actions: Add Clock Management Unit for S700
Date:   Thu, 19 Jul 2018 11:06:48 +0200
Message-Id: <20180719090649.12460-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180719090649.12460-1-sravanhome@gmail.com>
References: <20180719090649.12460-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Clock Management Unit for Actions Semi S700 SoC.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 66dd5309f0a2..59d29e4ca404 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/actions,s700-cmu.h>
 
 / {
 	compatible = "actions,s700";
@@ -87,6 +88,12 @@
 		#clock-cells = <0>;
 	};
 
+	losc: losc {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
@@ -153,6 +160,13 @@
 			status = "disabled";
 		};
 
+		cmu: clock-controller@e0168000 {
+			compatible = "actions,s700-cmu";
+			reg = <0x0 0xe0168000 0x0 0x1000>;
+			clocks = <&hosc>, <&losc>;
+			#clock-cells = <1>;
+		};
+
 		sps: power-controller@e01b0100 {
 			compatible = "actions,s700-sps";
 			reg = <0x0 0xe01b0100 0x0 0x100>;
-- 
2.14.4

