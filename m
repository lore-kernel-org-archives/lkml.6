Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE86DC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08B821798
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08B821798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754126AbeGGOqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:46:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36705 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753686AbeGGOqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:46:35 -0400
Received: by mail-pf0-f196.google.com with SMTP id u16-v6so10633774pfh.3;
        Sat, 07 Jul 2018 07:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dNmX4CuaxuOvOpgqDdlEBP6/fnnxDD+ULcuh1wlMBEE=;
        b=NEQnXM+13N7kUr0nKUuvgkDN5Bf++005b3krJiV805aT9EtP53s8MD1fBmKiD7fIyH
         VuFp5RalsY0Jb1gm61OUfvUsAI58PjenJNObxIo46RtSid0iFq/ClmNIaZw2Gh0FDrHF
         UrgpbwUBNp6/89IDacgV40qXGzP5LJMHV4fhnHdvQ3kcZKYYX5Zx36nftz3WBN0SGR0y
         o7uoju/ndGGZR1Rm6vL24J9hkftLxsPoXPbTs2mCOqL6Wz4+ZWTmNbPzCDl4wUTz6Koj
         8TE7vCQiXMBcW/koLVAI7+ZRZoHIMzj3+5Kkg0IZFq+bwuro9VdSDDAAovXpm/5RyBgd
         QAnA==
X-Gm-Message-State: APt69E1uZlfN40SG9uOXwaSzoZqaeOxeU2jycs+KKAbAqp/8dvmVMKwF
        FrD+u+0gmV5bPdScNee8Z3xZRk/q
X-Google-Smtp-Source: AAOMgpff1bzR+GWCJ/sPbTzLuT1JzApEAB1SE2u1R1Mg0k3gDDj81M8YAgctaGXkmWPgC6CcgkCTxw==
X-Received: by 2002:a65:5c03:: with SMTP id u3-v6mr12259708pgr.402.1530974794438;
        Sat, 07 Jul 2018 07:46:34 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id d65-v6sm21915040pfj.20.2018.07.07.07.46.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:46:33 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-samsung-soc@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: exynos: add max77693 irq configuration for midas
Date:   Sun,  8 Jul 2018 00:45:22 +1000
Message-Id: <20180707144527.6662-1-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we assume that the bootloader has correctly configured
the interrupt pin for max77693. This might not actually be the case -
so it's better to configure it explicitly.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index f35176a35a15..30760bf2eb71 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -156,6 +156,8 @@
 			compatible = "maxim,max77693";
 			interrupt-parent = <&gpx1>;
 			interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&max77693_irq>;
 			reg = <0x66>;
 
 			regulators {
@@ -1117,6 +1119,13 @@
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
 
+	max77693_irq: max77693-irq {
+		samsung,pins = "gpx1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
 	sleep1: sleep-states {
 		PIN_SLP(gpk0-0, PREV, NONE);
 		PIN_SLP(gpk0-1, PREV, NONE);
-- 
2.18.0

