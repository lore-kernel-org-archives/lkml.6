Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37901C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0653920881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VACCNkOW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfAaUpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:45:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34370 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfAaUpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:45:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so2036047pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/d0qYjvUjOnhK3byzjqxMrsrkZAK3+9jUq6QNPQ6V0=;
        b=VACCNkOWHNp0gHVNgItfZ7UJZZHmj+kQXl8MMDgurV6S5VvSoewKO2Gq6vDw9wIh50
         BDrIkbmIwNNwHPyeWBu+TeIEOzPZbhkpa4OY7GSCWwlwICeHALDKN6hbX5dn9lY32wBR
         nxWosgis1tn4oH2s2aU3T584pqKZ5njcI6cVrPWQGjrlMPUMB9WuU/IZ3N3tPDzh5TGn
         rPGsIA9TK+BnNUUknLUsmDs5PcLYiXQuuORmilTg4dJa6zApg71aJSBrbtuBfLWdNjoG
         4xY3MxBVExY9KYmkaHnEPKhOmk0jsrk/ETEt33T3A4QOm/vHXnqPHG0sNagtOspGDxNh
         LHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k/d0qYjvUjOnhK3byzjqxMrsrkZAK3+9jUq6QNPQ6V0=;
        b=ZnFd7kF4uVxQ8NMCgl2VCOiTBWpYBfAf85uMPvPxdmLZ0/PShwZyAiOveMAJU7+Ih8
         y+Gx2iQSH6LVzyhcX8bNEFeG0WAEMVSoAwSs58HSAW0ca1CgCApk7kVziO2aKpPwJn1L
         MB3jV/QtmntkfxO6+Ei2wyfhFSaPcGA7c2Q6EG+L1VrFtgr/Y3Foel0oJPWWIHgq8AX0
         zEpQs6yAyV+VhaNcm8QGEYjTxR6WzZVZvaQeDqBonOmQ5mKLo60fw3BXh24KiYXWz0nG
         GjWow1vy+W1o/JPcZmgf5kKBiry86xcUAAY1Hs62TaUfR5490sGKg6TT6j8gWID4rb0+
         ng6Q==
X-Gm-Message-State: AJcUukfp66czbMVL55cnIFaRVXWF8o1SiYKYUSTRuo/61CXQxioV1o0+
        3cYyi8crc9C+yrWQb00FkU5lTwya
X-Google-Smtp-Source: ALg8bN5lyN17RFOlkB5Dcg5EzsR5JtMfeU1YZzRbWG/L2OB/7Ndye9FSc2SnO4T2ztSP1WKarvKCwQ==
X-Received: by 2002:a62:4549:: with SMTP id s70mr35947940pfa.233.1548967531819;
        Thu, 31 Jan 2019 12:45:31 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i1sm7228759pgb.46.2019.01.31.12.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:45:30 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq: Make GPC default interrupt parent
Date:   Thu, 31 Jan 2019 12:45:24 -0800
Message-Id: <20190131204524.1218-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the GPCv2 driver supports i.MX8MQ, make GPC default interrupt
parent.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Leonard Crestez <leonard.crestez@nxp.com>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d20e5c7e21a3..e9aa64156577 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -12,8 +12,7 @@
 #include "imx8mq-pinfunc.h"
 
 / {
-	/* This should really be the GPC, but we need a driver for this first */
-	interrupt-parent = <&gic>;
+	interrupt-parent = <&gpc>;
 
 	#address-cells = <2>;
 	#size-cells = <2>;
@@ -265,6 +264,11 @@
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
 
+				interrupt-controller;
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				#interrupt-cells = <3>;
+				interrupt-parent = <&gic>;
+
 				pgc {
 					#address-cells = <1>;
 					#size-cells = <0>;
-- 
2.20.1

