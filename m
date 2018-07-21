Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D35BECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797A220856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797A220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lineageos.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeGUNpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:45:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38311 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGUNpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:45:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id k3-v6so9016681pgq.5;
        Sat, 21 Jul 2018 05:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tIbTj74v/WmH5kw0a7WvNG/g2fhHyK0nX+t5+y9Y/jM=;
        b=l44NSjhdATCkKSG/ZtTBCd/bVRZnDoM49EaJqg4OC4clHyiC49UU6AHamlUFAtgDMH
         MTlp7WuQ/SzfAEipdh+E7sID8Xvw0jqRaEpCiPuqhzdiSN56wQ8a/OK43kCc4MOns+Sn
         lFj4S46WSL0GgcrIDsUKyP7gJ73JmjOL4V84zGLdlgaa6xpjrqx4m7iMwJ+iCXQIeIUa
         h589mOdkzQLuQ2NrxvGfDPeBOMmLyJ8i4gMLJo4KqS6I+xHUdvoZRYk/qqxENQ7MpSt3
         TYKs52mUcu1pC1EFtpHh8Z9P5F34IY7Rt1yhWebIJwwQK18uZiK/NHnCPRBRzko9YYv7
         5EuA==
X-Gm-Message-State: AOUpUlHSZxOnOPL1y9McH7JwyqKtVLOuArnIspZWOGPzxq0K8/RsQRht
        PN3hTMIUm2I8Mw9DqAwrRT/5BJ/w2wc=
X-Google-Smtp-Source: AAOMgpd71Igl7Ubbar3JYWalu4IyLPZ3tEBmxgyiNbN9Q4ihKMD2uxGkhCvMD6jxYqbOZMo2TXtKLw==
X-Received: by 2002:a62:a649:: with SMTP id t70-v6mr5985279pfe.149.1532177551637;
        Sat, 21 Jul 2018 05:52:31 -0700 (PDT)
Received: from forlindon.lan (27-32-42-49.static.tpgi.com.au. [27.32.42.49])
        by smtp.gmail.com with ESMTPSA id o72-v6sm6625945pfk.76.2018.07.21.05.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:52:30 -0700 (PDT)
From:   Simon Shields <simon@lineageos.org>
To:     linux-samsung-soc@vger.kernel.org
Cc:     Simon Shields <simon@lineageos.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ARM: dts: exynos: add pinctrl config for midas keys
Date:   Sat, 21 Jul 2018 22:50:50 +1000
Message-Id: <20180721125128.31498-3-simon@lineageos.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721125128.31498-1-simon@lineageos.org>
References: <20180721125128.31498-1-simon@lineageos.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pins are externally pulled up, and so we should explicitly
configure them to disable the SoC-internal pull-downs. Previously
we relied on the bootloader doing this in order to allow the buttons
to function properly.

Signed-off-by: Simon Shields <simon@lineageos.org>
---
 arch/arm/boot/dts/exynos4412-midas.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-midas.dtsi b/arch/arm/boot/dts/exynos4412-midas.dtsi
index ee7cda1432f7..6f7b564905ab 100644
--- a/arch/arm/boot/dts/exynos4412-midas.dtsi
+++ b/arch/arm/boot/dts/exynos4412-midas.dtsi
@@ -112,6 +112,8 @@
 
 	gpio-keys {
 		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys>;
 
 		key-down {
 			gpios = <&gpx3 3 GPIO_ACTIVE_LOW>;
@@ -1126,6 +1128,11 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&sleep1>;
 
+	gpio_keys: gpio-keys {
+		samsung,pins = "gpx0-1", "gpx2-2", "gpx2-7", "gpx3-3";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+
 	max77693_irq: max77693-irq {
 		samsung,pins = "gpx1-5";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-- 
2.18.0

