Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A7DC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D54972075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 16:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MQ2Wig8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D54972075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeJXAgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 20:36:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34207 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeJXAgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 20:36:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id g12-v6so897146pgs.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 09:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1i2lznVyglXGUJdFbyOeaEkfvd6J8yKfE652P5VFc1U=;
        b=MQ2Wig8y8nsZc8ub8dy2kA61PJ5KOBypJ+sIhKmOvBfNE6cDiR3D0X1/rTel7pg3wT
         99lXS1kyLWteGQWnQyr36DMEIl4J42/7WTN651LPxRQf3gpxLpyertp6l2H9M8FjXHDA
         DRrFUDA3bukw6atwYxAsuWzZzWVbbvMl0PYpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1i2lznVyglXGUJdFbyOeaEkfvd6J8yKfE652P5VFc1U=;
        b=cnmP04Vh84cg81zuRnbjHXzzO0B70ahq7aUwMrFECU0wji0aT32EWvCmRWRHbcotF+
         YFaXP1oFCukbZScrGoruzkDwq9zkbB+3PgItIrlj52XQeNHSgxsvilsCpsoWfv9fb9FD
         /jt0541L5NdTbTRQIFgq1JhQHKwFCyoGgaRl9BtLOqMOnjzLBiOrESSaI7ZzFa29mUr5
         NApN1iEvfY3BPSxMd27TMbe5LX/Kxc6J3ByA3wNgdNKY4CB3kZb90u4AFYuwXFKsk/uX
         7G/Son5njq5izm+a+/HCCDaVNZNmBDDn50FhC2fv658uo2DGLyt/uwcGJlvfZ3N7a+K0
         YSdw==
X-Gm-Message-State: AGRZ1gKkkzb74S1IRrm+BXeJ9FYHZKhUlhKs0ACIO9oy9OjYOj/1eV9T
        hXbAXSRleaPW6s5GrWxC/YvsgQ==
X-Google-Smtp-Source: AJdET5ei1Xh0Jr57Y+8ahXuHjX6PvN6g8BqGc0gI9s0LlKHMFabDUapOsDuZyA4D6J8QFTQgYMIF6Q==
X-Received: by 2002:a63:314c:: with SMTP id x73mr7782810pgx.323.1540311136170;
        Tue, 23 Oct 2018 09:12:16 -0700 (PDT)
Received: from localhost.localdomain ([27.7.51.1])
        by smtp.gmail.com with ESMTPSA id u21-v6sm2771449pfa.176.2018.10.23.09.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 09:12:15 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: dts: allwinner: a64: Add device node for Mali-400 GPU
Date:   Tue, 23 Oct 2018 21:42:03 +0530
Message-Id: <20181023161203.2956-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Allwinner A64 has Mali-400MP2.

All interrupt lines are mentioned in the manual so used the same.
Used 408MHz as assigned clock rate used by BSP, so used the same as
well.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note:
- Modules was able to load it on 4.19. 

 .../bindings/gpu/arm,mali-utgard.txt          |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 25 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
index 63cd91176a68..a0ee62a5b221 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.txt
@@ -11,6 +11,7 @@ Required properties:
       + allwinner,sun4i-a10-mali
       + allwinner,sun7i-a20-mali
       + allwinner,sun8i-h3-mali
+      + allwinner,sun50i-a64-mali
       + allwinner,sun50i-h5-mali
       + amlogic,meson-gxbb-mali
       + amlogic,meson-gxl-mali
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index f82e6b165d57..2db3aa151902 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -812,6 +812,31 @@
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
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <408000000>;
+		};
+
 		gic: interrupt-controller@1c81000 {
 			compatible = "arm,gic-400";
 			reg = <0x01c81000 0x1000>,
-- 
2.18.0.321.gffc6fa0e3

