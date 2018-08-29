Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04C0C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877DC20897
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8ZroHn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877DC20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbeH2MUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:20:23 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39628 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbeH2MUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:20:22 -0400
Received: by mail-wm0-f67.google.com with SMTP id q8-v6so4578028wmq.4;
        Wed, 29 Aug 2018 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sdztba6uFaWWq/Z99bvFeHmIdTv+dYbpOzGbtLiwdZU=;
        b=u8ZroHn053oW3ZfzFcMAFBzvwYlu9yyTT6QK69UZ8ye9a/Y6Chs0uRK5dsN6j3+fFm
         eSK03DR+K49ebcO3Ux9sAIsJkF0UFSBsmC7GDoq6JxaTZuXHJWsvcnBXyxliZmpSDLhU
         nLzlpq4gmxRX6GLAIEW2RYpV9JQn2mYW8xNx1s4k3HCATsMuuaf9ZYtsCeqd1mSUwrHH
         dHYnyOyG956ZxkMRNlPXzrhgKy5fItwGC+Tk6+VqFy5Bv/NtgkG4SfudXRXzDdfQbBey
         llQfC+kVs6xqw68t819GtirxDJ7inQbGxds/2rGjYBEEiF73nhbYv+l2TetmlTaM3QNu
         1dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sdztba6uFaWWq/Z99bvFeHmIdTv+dYbpOzGbtLiwdZU=;
        b=AnF0Mpee5a80yyEJfKTd8KLnkpWMdeODT/msb1wUA24GauOQdhWGonYkgHVG9tnlr7
         budLpz4cJ9Pwnt0qfl7XwRP0ffWdpgc0bvCp5hJoMtRThOosxVtj+hIbND1n5KR6++ZF
         KvGV3zij/XZk8kYBe0KdZr9lXhAsc4q1p7T0A68CG/ocgDxrgSFDNELpXcV2/7A1Sb+S
         yBIk4u9cpFtpvDQxf1edyshnXjJikLkEneDVCSCgCQfh4zC9QD8A5SyefClQNrWu5Tlf
         bi+/ESD6Pl/B2obImW1cF5HrnzpqluPOPCqzAvLL0MlvIB0XhIV5jvYiP3uastEzQI1u
         QwLw==
X-Gm-Message-State: APzg51DymYOpB9MhcBJ+VNYyqGO4DxGU/Eq3ZWwmMq7X2lGL2Ropd1I2
        NGfQlFpzR1us9t8cDEA4MC8=
X-Google-Smtp-Source: ANB0VdbAJw6TMKNpmv257bfyNtcAG0xgJSkD8VrusG7fg34SssnTLmsRpOjB3WdbwXxr6YWLjfenJw==
X-Received: by 2002:a1c:7301:: with SMTP id d1-v6mr3479777wmb.34.1535531076807;
        Wed, 29 Aug 2018 01:24:36 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id g7-v6sm3013025wrw.30.2018.08.29.01.24.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 01:24:36 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     manivannan.sadhasivam@linaro.org, linus.walleij@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [PATCH v5 5/5] arm64: dts: actions: Add pinctrl node for Actions Semi S700
Date:   Wed, 29 Aug 2018 10:24:13 +0200
Message-Id: <20180829082413.2512005-6-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829082413.2512005-1-sravanhome@gmail.com>
References: <20180829082413.2512005-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl nodes for Actions Semi S700 SoC

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index 66dd5309f0a2..8fbd7b1570a7 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -165,5 +165,21 @@
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "timer1";
 		};
+
+		pinctrl: pinctrl@e01b0000 {
+			compatible = "actions,s700-pinctrl";
+			reg = <0x0 0xe01b0000 0x0 0x1000>;
+			clocks = <&cmu CLK_GPIO>;
+			gpio-controller;
+			gpio-ranges = <&pinctrl 0 0 136>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.14.4

