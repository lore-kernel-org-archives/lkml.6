Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F155C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E8F620882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjAiUM/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbfA2Tqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:46:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53551 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfA2Tqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 14:46:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so19183171wmb.3;
        Tue, 29 Jan 2019 11:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=20blMOHuyAbQUXb2gdRexITNWuPKKSD4eW2JNIItz8Y=;
        b=cjAiUM/e/d+kumGxCK4UfUtgOQ0f0MkgLCT1vPxsWHL2FPLwLaRC7wmXzLQmiiZtuS
         mZnRlAlK80CQ7a1rP/1freJlZSpGpdiyo9ZL41q2eveNrDDrkEEAmhNyqLzpS6Ytzvyx
         PEjxyET/5sBMBu17C46OKzlbH4dqzVWdqq0EQg+QbD1HJ2rWJ32Z9kfWRGVYcyHa91Aa
         MiL04rai0GchYRZmms8q/e3+WaP7iiU8T18ID19NQyO349t37DwKpTeKKumlB5f9oCoH
         QxhCAn36MUomVVV8/+6taxtWHsZEBIR3A8wfZBIFslwk84gI9XF8q+MOldhBXyrfzMrr
         aq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=20blMOHuyAbQUXb2gdRexITNWuPKKSD4eW2JNIItz8Y=;
        b=SR7nxa/6jQ25wkmefmFy79aIPdMzcCjfKNm19FKt0iXr+jIoSBLN7WjV6U5uVZUOqL
         Kfkv/B9oxz/9TQeeNN+QfLwBZbOEiychjaA684lGO1sZNZVJLndQyygeXGTD9idsy0fN
         rWaPRFXVeOvOw+E0D0RtSBNRkuBYSnnKBOV5cDDx417IJi/52VW2H7EnzuBSvXZts6uK
         +ZZLRzqxy9lrbW3RdrNCAnJelx7YgbRBl8OhuqPqpGYIsde4NYQ7BUA+dOUiIOVSGxvv
         9ei5Et/cjEfCVSpRVsfHEvhT4hu1Ecyl/wJIbqI/RhQaJv59Kwzh91hZBjTLrSQ5Przj
         bZVQ==
X-Gm-Message-State: AJcUukeQsPHXpQm3Ij1mwQYBPcAnpsWp8LJg8hXpwRv0Sr8qEpbjiuuq
        dSykBa+tfa/krwwhI22CRP0=
X-Google-Smtp-Source: ALg8bN48o9Nv2HwWQ0w0kpXSWLZe2swGi5gmDL4bu1sWvg/JRniT1ve4RVkEtw6fASmUJVJvmWnbrw==
X-Received: by 2002:a1c:a185:: with SMTP id k127mr22227190wme.134.1548791200081;
        Tue, 29 Jan 2019 11:46:40 -0800 (PST)
Received: from ubuntu.home ([2a02:8071:6a3:700:8c22:ee0c:efc8:ed86])
        by smtp.gmail.com with ESMTPSA id x1sm30151558wru.34.2019.01.29.11.46.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:46:39 -0800 (PST)
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
X-Google-Original-From: Simon Goldschmidt <goldsimon@gmx.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Simon Goldschmidt <goldsimon@gmx.de>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: socfpga: update more missing reset properties
Date:   Tue, 29 Jan 2019 20:46:25 +0100
Message-Id: <20190129194625.19218-1-goldsimon@gmx.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset property for dma, can and sdram on socfpga gen5.

Signed-off-by: Simon Goldschmidt <goldsimon@gmx.de>

---
This series applies on top of  kernel/git/dinguyen/linux.git,
branch socfpga_for_next_v5.1_dts_v1

 arch/arm/boot/dts/socfpga.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index f365003f0..ec1966480 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -84,6 +84,7 @@
 				#dma-requests = <32>;
 				clocks = <&l4_main_clk>;
 				clock-names = "apb_pclk";
+				resets = <&rst DMA_RESET>;
 			};
 		};
 
@@ -100,6 +101,7 @@
 			reg = <0xffc00000 0x1000>;
 			interrupts = <0 131 4>, <0 132 4>, <0 133 4>, <0 134 4>;
 			clocks = <&can0_clk>;
+			resets = <&rst CAN0_RESET>;
 			status = "disabled";
 		};
 
@@ -108,6 +110,7 @@
 			reg = <0xffc01000 0x1000>;
 			interrupts = <0 135 4>, <0 136 4>, <0 137 4>, <0 138 4>;
 			clocks = <&can1_clk>;
+			resets = <&rst CAN1_RESET>;
 			status = "disabled";
 		};
 
@@ -791,6 +794,7 @@
 		sdr: sdr@ffc25000 {
 			compatible = "altr,sdr-ctl", "syscon";
 			reg = <0xffc25000 0x1000>;
+			resets = <&rst SDR_RESET>;
 		};
 
 		sdramedac {
-- 
2.17.1

