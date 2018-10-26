Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E629C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0495C20824
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t9lBg1rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0495C20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeJZTxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38644 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeJZTxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id d10-v6so950941wrs.5;
        Fri, 26 Oct 2018 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KjXTlb8qK+gg2OxZSgtIJOZvzKIY8RWxIBzJQUft5ac=;
        b=t9lBg1rdvjGf728DRA88/EWUliUgK+9j1kmSzJk9ylUsQasLDX+0W7bgZ63ejlgYxB
         ugaMwnmQ4k8N22dQ3LkmtauzaVKRTB/3T0y/zYyQvOboo8BrqsFcHqRw1nZlcwqQI5DL
         klDPsvEB0nlIR/ahoEsYWOznitNM+1iAMcnXaSV5vCY2xXuxHXM19ldCX0TSn7JBV5Co
         LL2some5UbfM1O1K07idOM/FyEIhdhe/C+0I+WbZ0ECerRYNXVhoxKhsRWzo+kK6RyAH
         pERg1jd+/Rr9olWFoFEqU4UQgqZMHlnzv/8epCi1mZbbH8tGlCzmQ1PrKMibDNTgpB2g
         RbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KjXTlb8qK+gg2OxZSgtIJOZvzKIY8RWxIBzJQUft5ac=;
        b=b3c5p3umNvpudIzgNU8VoU+5OooE/6MSjHfs6Wkso67/zA8gukF69/BqDKnJFiMUOO
         QBppPBMF3Hm4gK+4wsIVgZjBEh9JCasy6SlxdO+WCKmkfmGM3CC1JACzxN5lrcASlJl+
         hJXlq+LFtq1HFnRSmMS/5uZUV+PIoAUfnmCOKNeg3crsQUvF0l6zfbSpXCmuZk4U27vj
         gcbtWBAXvmOmI1+0FjJjbabvA+zCQ4kD/UH4ZL3E+aRi7HXmioJgrTGqp9ctSli6f2ko
         PJMJQhVHyrBkoZ2+MQj8SyQ6P0fW3cQFopm+qwRRudD8NS2CaGF6J94dH+IZxM+8FQl4
         d9bg==
X-Gm-Message-State: AGRZ1gIhOOnewK5FdGOLsv7E+MvLCitPMEonqDkZ18ZCrtF0bo0oJMLV
        S4lynhJSz5QFKm7a+/cNpwY=
X-Google-Smtp-Source: AJdET5fV7TABOAvk6FyuKKKc6ge5+0h8BO9Hdo/tZdzWW6A3rSgb3o+irg/H0xMZrSxB7dVijAmpXA==
X-Received: by 2002:adf:b716:: with SMTP id l22-v6mr5781182wre.157.1540552615106;
        Fri, 26 Oct 2018 04:16:55 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id y195-v6sm4485038wme.22.2018.10.26.04.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:54 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/9] arm64: tegra: Add nodes for TCU on Tegra194
Date:   Fri, 26 Oct 2018 13:16:37 +0200
Message-Id: <20181026111638.10759-9-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Add nodes required for communication through the Tegra Combined UART.
This includes the AON HSP instance, addition of shared interrupts
for the TOP0 HSP instance, and finally the TCU node itself. Also
mark the HSP instances as compatible to tegra194-hsp, as the hardware
is not identical but is compatible to tegra186-hsp.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 38 ++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index c2091bb16546..521d13be0457 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -340,10 +340,35 @@
 		};
 
 		hsp_top0: hsp@3c00000 {
-			compatible = "nvidia,tegra186-hsp";
+			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
 			reg = <0x03c00000 0xa0000>;
-			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "doorbell";
+			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "doorbell", "shared0", "shared1", "shared2",
+			                  "shared3", "shared4", "shared5", "shared6",
+			                  "shared7";
+			#mbox-cells = <2>;
+		};
+
+		hsp_aon: hsp@c150000 {
+			compatible = "nvidia,tegra194-hsp", "nvidia,tegra186-hsp";
+			reg = <0x0c150000 0xa0000>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+			/*
+			 * Shared interrupt 0 is routed only to AON/SPE, so
+			 * we only have 4 shared interrupts for the CCPLEX.
+			 */
+			interrupt-names = "shared1", "shared2", "shared3", "shared4";
 			#mbox-cells = <2>;
 		};
 
@@ -531,6 +556,13 @@
 		method = "smc";
 	};
 
+	tcu: tcu {
+		compatible = "nvidia,tegra194-tcu";
+		mboxes = <&hsp_top0 TEGRA_HSP_MBOX_TYPE_SM 0>,
+		         <&hsp_aon TEGRA_HSP_MBOX_TYPE_SM 1>;
+		mbox-names = "rx", "tx";
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
-- 
2.19.1

