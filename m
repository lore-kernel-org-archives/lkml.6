Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE319C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B249B2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="oPYKnOyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B249B2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbeKNOaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:30:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34858 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeKNOa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:30:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id 32-v6so6758588pgu.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 20:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MypUWzP/rb2MviOvNidl9IcL4F5bL7yyZ76plr/l33I=;
        b=oPYKnOytxuE7Gyu716xe//o8DUOf4IfmR7+d4f9VIP3km6KAD5kEJp6RE0yCcilp9T
         ccxurK5knUO8OH/Zatsn8VaJk6TV3OkIC3Fqqgkzs6E2DHoKvEXgaw6WTT4ijNbo7KTs
         /kRNdB72KydgZYdeFyTzkWP5Kqtq/I1+MCOzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MypUWzP/rb2MviOvNidl9IcL4F5bL7yyZ76plr/l33I=;
        b=A9Fk8VdvGX3tRMvHn0hPd98iJmqXkYxDcjkBOnaTKoUaghBbVnk2jtFdTMSMTCO2Zu
         863PwgskRoO1rSXMpk7mhJaanAaCMLNxoZLLAR301R64zl5BwH/fXOeHro5iGfmm7V+Y
         QrJ1XJKGscxm+xTGPGdX+r6xaGTB7g6K4VJCz3UjzJDyEXGDuwYuYgmL05PzLDdRmS6v
         JVTx9eDowxtfkdfzWcjDcZCWHlEb+4qv/YbRwJoFuudPruVt8G1X/fAfH67xwi92TMhp
         2v/meusRQQY11yTrUsvbKPD8GTF3/jZDh9TCNvFYTDpiaptPa+4yq27p98gu2t5pZ4j/
         cMuA==
X-Gm-Message-State: AGRZ1gLMPK3E5Bc0bZEXGtTpnmqI2bBqKOTdT/VJzOR9pvvkkBk+BuHa
        gwZriA27P+YyDoLJ0vscQgltGw==
X-Google-Smtp-Source: AJdET5f/QwHjfyDQvZ8NmgC+5FAxODbYqpNcgMVfotK6Hd298eoCEpPEdSP88CQtOklSlb18KiLoqA==
X-Received: by 2002:a62:4587:: with SMTP id n7mr406165pfi.118.1542169740155;
        Tue, 13 Nov 2018 20:29:00 -0800 (PST)
Received: from localhost.localdomain ([115.97.190.86])
        by smtp.gmail.com with ESMTPSA id d24-v6sm37131140pfe.40.2018.11.13.20.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 20:28:59 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amarula@amarulasolutions.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/2] arm64: dts: allwinner: a64: Add device node for Mali-400 GPU
Date:   Wed, 14 Nov 2018 09:58:37 +0530
Message-Id: <20181114042837.15149-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181114042837.15149-1-jagan@amarulasolutions.com>
References: <20181114042837.15149-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Allwinner A64 has Mali-400MP2.

All interrupt lines are mentioned in the manual so used the same.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Clean commit message 
Changes for v2:
- Drop assigned clock properties
- Separate dt-bindings as separate patch.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index d6f269883759..d507be9879d8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -813,6 +813,28 @@
 			};
 		};
 
+		mali: gpu@1c40000 {
+			compatible = "allwinner,sun50i-a64-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pmu";
+			clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_BUS_GPU>;
+		};
+
 		gic: interrupt-controller@1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-- 
2.18.0.321.gffc6fa0e3

