Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E414BECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958472075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZhMBajp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 958472075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGRKMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:12:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39254 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbeGRKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:12:03 -0400
Received: by mail-pl0-f66.google.com with SMTP id p23-v6so1796178plo.6;
        Wed, 18 Jul 2018 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=N61JST6zGfZWnL1yoRO6wZsOgFTXVVeoMaT9G5VUHXs=;
        b=mZhMBajpvfBoAXEDclM8F1g8e671N+AY7rQxyTaYHfMwfvcoZZXqIE98ABK7SxOcRT
         +MF5+itG6G5QoKlc3QPlaJHl/GJR4rFH0ySapg7GNid2cjJuZ8+xvN5LbXfQnlT2AP+X
         FsaAfEk3EM+qHzPvZmiNiI7q4G9ZXnbHj3ZWzGkz8j7jVVSXs83Bo1MPCSSLjIq6zEYS
         tRTJ7UxiHpCfru/4Mbwo9rAiedgEysEMzEVN8npn26/2HUCCfwMBfkh96q6dCOKTbtr1
         eNDg42pI+EXPiIlszIewhOVob1wxyCxKpwALbDfb2IiU0839dBRICvgnE5Xp5OL0IU5A
         9Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N61JST6zGfZWnL1yoRO6wZsOgFTXVVeoMaT9G5VUHXs=;
        b=db3fj4DsEBSnj1e/Iv9QQ6bssLYqW4tjJQcIoPn6D9/lZ4sPZBPWdYPqSoKS6nwyAc
         2wU8AvG2UluHK/hNoOE1mzpP8nEHepCTgGVFndUrijsgTaqEbtAPrr5N5CyXN90BsQTd
         pyrIlxCkimvu9dvvMafndnuwSdOz08E55wI2zSGd3v9Ow/8la//iEquUVcJWR0cZrqbv
         Tw2ysxfqXrfmwQFUKbdr7sIlv9bWNxfkLFGkNRM+Eb6CAU+DKkQMT8Ayhe6S+2UZ6xHX
         en9YmnBlUJiM/BBMwd3Yg6saNpTDXtr6PCYIsbjIMz+TfcHCieItinncCSP6HCQ3ZtpZ
         5fYQ==
X-Gm-Message-State: AOUpUlFNsiXe4+zbBKTZoZPvYKzTOrNEXRFKt09uibtiOvGO4bqTiZka
        1d7LHpfQ9VIWtEVWf/93Xn8=
X-Google-Smtp-Source: AAOMgper4wPkE+mW3uMNbcKgQxf30UWO2kg0+W130FmVMOWORjQi1O9DV0qx57s/oOasA/xedVsNAQ==
X-Received: by 2002:a17:902:20ca:: with SMTP id v10-v6mr5132388plg.255.1531906502192;
        Wed, 18 Jul 2018 02:35:02 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.135])
        by smtp.gmail.com with ESMTPSA id d123-v6sm5324199pfa.22.2018.07.18.02.34.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Jul 2018 02:35:01 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH] ARM: dts: exynos5: add missing interrupts for pwm node
Date:   Wed, 18 Jul 2018 09:34:50 +0000
Message-Id: <1531906490-1739-1-git-send-email-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing GIC interrupts property for pwm nodes.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/exynos5.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 5d2f0a0..9406108 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -169,6 +169,11 @@
 		pwm: pwm@12dd0000 {
 			compatible = "samsung,exynos4210-pwm";
 			reg = <0x12DD0000 0x100>;
+			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
+				   <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
 			samsung,pwm-outputs = <0>, <1>, <2>, <3>;
 			#pwm-cells = <3>;
 		};
-- 
2.7.4

