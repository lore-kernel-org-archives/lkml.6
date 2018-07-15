Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 798E0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E48120844
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHycQ3Mo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E48120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeGOU0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:26:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35280 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeGOU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:26:21 -0400
Received: by mail-wm0-f65.google.com with SMTP id a9-v6so6902416wmb.0;
        Sun, 15 Jul 2018 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YRj6yLCAtwa4d5ow6tddlLv3TA5jF/PNAMI5Oag6lBI=;
        b=GHycQ3MoIZZLLuKqC/Mpf06thiu1dHZvVwyKtOKV7N11u35Zw/DPCwgGNc13kxkuaD
         P9lwKu2hG1SSDrP9qD8Yf+JKazKXNAyM8cEKuwrt2+1RFylzKMgy+edgXr6OGD0/lBXj
         NstumoiQVJlvjGgXeqzt+/XKgno3cQV0QVvx13WOCei03X2ZlYH5Y3mduYviiB8EjkVa
         viLPkmwwVzqm23tq5itqPBCcXiT11//vf8BnqdV0gLaDZyALEdSgR0luOXXv21QU19rn
         MIy1XX7tzdRYLKrdJuk3JWWiN/VwcvqDWGBJNRoMJYfkgWDNdv1U2TexsLvyzqn6Q0pf
         vStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YRj6yLCAtwa4d5ow6tddlLv3TA5jF/PNAMI5Oag6lBI=;
        b=sCQK2mptAHYgHR93k5W945uU6LxGymU53svDO6RTCBERpRZWDa0mSL4rqqBc5abn/B
         X+pRoX6RTp1Gb/u4eJ9fkBBW0gOlNoN7c0j9+iviUNQuZy2bP7HbVL1b8/KPWV2sfTPk
         qFgysZIoTsYV1oJMEp3FgMx1Xv8Xt2tV1BklHXyoMWZYEbLY8RfBThl/S0MeYp/4j/Lm
         lTyPeQFFfOyeS6Bf6CEY/D5gfj0TiQZ6OUcMcl/wXoXkoD982pDZMLqpMKQX+5fawTvu
         IBpJQLY0A3lS04gYsV5wdjbag37gXNXIXL0hDqw1Eq99HJHqTi/Yw0VqOQbNrUEJVXR4
         gfwg==
X-Gm-Message-State: AOUpUlGdW6z7kQxUV72PqM2xonF+zl0fakPYLR3syp2bVyf08F37HhCu
        m3qphAFWNKS/MvSgi1WYbos=
X-Google-Smtp-Source: AAOMgpcBzFA8SWCHv5TcSTbuXq7cWgN2+46pEGRW0xSi5+ZS1CL38O4IU6Hsdfjo94mXFvkRdKWMpQ==
X-Received: by 2002:a1c:9947:: with SMTP id b68-v6mr7879452wme.159.1531684938902;
        Sun, 15 Jul 2018 13:02:18 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id z7-v6sm20816234wrh.85.2018.07.15.13.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:02:18 -0700 (PDT)
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
Subject: [PATCH v5 4/5] arm64: dts: actions: Add Clock Management Unit for S700
Date:   Sun, 15 Jul 2018 22:01:50 +0200
Message-Id: <20180715200151.10416-5-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715200151.10416-1-sravanhome@gmail.com>
References: <20180715200151.10416-1-sravanhome@gmail.com>
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
index 66dd5309f0a2..4497741d48b2 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/actions,s700-cmu.h>
 
 / {
 	compatible = "actions,s700";
@@ -44,6 +45,13 @@
 		};
 	};
 
+	cmu: clock-controller@e0168000 {
+		compatible = "actions,s700-cmu";
+		reg = <0x0 0xe0168000 0x0 0x1000>;
+		clocks = <&hosc>, <&losc>;
+		#clock-cells = <1>;
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -87,6 +95,12 @@
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
-- 
2.18.0

