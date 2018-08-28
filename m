Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06285C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51522064A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rg/ZQe2p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51522064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeH1VrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:47:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37839 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeH1VrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:47:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so559666pgo.4;
        Tue, 28 Aug 2018 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n4ZJEGZnhqrGdVeWYMnTCHn9LIITEWAYG3JkHNaGGr8=;
        b=Rg/ZQe2pZyAOS8GfdnClXiNb78hmrxrU61r3a4m3bTnZToh5+aC2roDUvbao3SjOLX
         AL6CWZyeD/onj+dNxtHysAyKIQtdGEyI20TUty6fCKom8UIIb30Z5vA3R2cWBhMZv3/b
         sMnVunwUfgjibBpneObNg6+imJKOtHfuLJ2E2brzTritA0Gyq2Rpuhxfg2rXpp23BM9P
         IrOX9SumkDJ/87CBrHmXT+7HFdyr2DrRtIjd1UFAsMWxNYK8DUOMmZEBksAcsloEwQlx
         8D3pmxSQUz1Mp95Wybr2c4fLwSZT5/CVl0KHxwdmvCqWqyJnOGlQW/HDBUnVFdHIrzSh
         bynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n4ZJEGZnhqrGdVeWYMnTCHn9LIITEWAYG3JkHNaGGr8=;
        b=kp29bEfufuUakEd7iHdc9M0DIkErVswBSWoGqNJTh+60KdhXo4uFilT/R6NSZGMbu7
         4xQhbGsEUv6nmFDye689XUe0GH63PbbXhVdIs+IKAFX7LPTophdN0p9+dCNKYhhLaTVo
         ptRnQuDsWkEBBOH7h1Suf5F1j+8e1JraKvHYq0aKqJ21MUqM6FyhHgxowTealeLffVhC
         yyEziWx/MbiOcBm6Aky7ZPR2b0bOShC8XOMxJRXhoO2aek0yBEwBBXnsUFizZBQfj4Ih
         1sXIA58OX/yJqt2eAhiuNP1aFDDfbFAslecwgP8MI6R4gFwnKKRHiml2J72R3FxeWBGi
         iLDg==
X-Gm-Message-State: APzg51D/8HEUuTD3plvMoPg4J+pIKZq4Y8NVJuTQvRkhvmBcoXoh3BKm
        szKS675gl6ByPx5y7OSxCck=
X-Google-Smtp-Source: ANB0VdYt8xXoCEBCnrZP4l/uYl8MUG2/xjhEyih1j9TZCAcHItGtwBbW0ovz2NczhiV40ZKSEtZZNA==
X-Received: by 2002:a65:520d:: with SMTP id o13-v6mr2553172pgp.282.1535478878008;
        Tue, 28 Aug 2018 10:54:38 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v23-v6sm2664465pfm.80.2018.08.28.10.54.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 10:54:36 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        andrew@lunn.ch, rmk+kernel@armlinux.org.uk
Subject: [PATCH v2 3/3] ARM: dts: NSP: Wire up switch interrupts
Date:   Tue, 28 Aug 2018 10:54:20 -0700
Message-Id: <20180828175420.7992-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828175420.7992-1-f.fainelli@gmail.com>
References: <20180828175420.7992-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Switch Register Access Block (SRAB) has one interrupt for link state
change on each ports (0-5, 7-8) a PHY interrupt, timestamping interrupt
and sleep timer interrupts for each management ports (5,7,8). Wire those
up so we can utilize them to speed up link resolution.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 09ba85046322..ec869a80f9ba 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -377,7 +377,36 @@
 
 		srab: srab@36000 {
 			compatible = "brcm,nsp-srab";
-			reg = <0x36000 0x1000>;
+			reg = <0x36000 0x1000>,
+			      <0x3f308 0x8>,
+			      <0x3f410 0xc>;
+			reg-names = "srab", "mux_config", "sgmii";
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "link_state_p0",
+					  "link_state_p1",
+					  "link_state_p2",
+					  "link_state_p3",
+					  "link_state_p4",
+					  "link_state_p5",
+					  "link_state_p7",
+					  "link_state_p8",
+					  "phy",
+					  "ts",
+					  "imp_sleep_timer_p5",
+					  "imp_sleep_timer_p7",
+					  "imp_sleep_timer_p8";
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-- 
2.17.1

