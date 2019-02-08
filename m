Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0971C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF072080D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcdaY8Aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBHAaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:30:22 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43700 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBHA37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:29:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id f90so573868plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pfG5fkUaRj/fht/6ipkewqnaacFZ9IZoXIVJQq92s6U=;
        b=jcdaY8AqHvODsk+ZBnTKQxzEI22PRT68VQ3vqIsb2AeYrp5K5EMgqBbYFkr9iVKaHd
         BkLxPkhD83V4JcfFHG/JzGsfCiHBU6AVYqZqcgJplFB6mWn+K1H1UZRHosEj3TeC+Sse
         afDxEtmmB6w73+NwpasY6XIhBa5hXMJXUTMtFzfvFFYjnESv0Q09tXwt2cQoLc3Q+YMp
         pUzc+F0L+yGSb3sRHoIJwD1/1koNQPgy+BazHAvMomcykvhp2YOFM47M6sk1ATHuWIZt
         V1vOYRkp4rRbnHuynJ1UCqBfbQBxTH/QxaIvg6Cl9ghH4HhH29JbKVrUlpzcL7Hc2Czq
         YvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pfG5fkUaRj/fht/6ipkewqnaacFZ9IZoXIVJQq92s6U=;
        b=kR2vg9kmMTYZ+h6Qa0Xf1Wj4469y+HUqcMSjjxMnclbYXL3DsgOSL1RG00KjAMlfqw
         MvV68wl5GxwMoP0HI1IgpKULcjry6sHfFy5JqCzBlXB4JY36FANAlEdaHlyFvAJoFdkG
         ZDue7GGpAREkpJU7ddzNr8888I6R1ghZUKs26ixHXN69H1Z285bl8Qzfp47+dg0zbOWd
         ZXvPXTEx3f/z0me5jp79XsQVq6PgEgXdbu4tK1dDcyzD6i5KZjzJAHiAPGo4KHTgIzfc
         +uvXwd7w7803hk9dgFaGHTWN1SCkqm1zuKg3iAeekxLAHLsqlF+a6J7JDFpSFic+04fr
         AUgA==
X-Gm-Message-State: AHQUAuaxiUM+kgmhKXXlOAeLf9l2ZnENNx9fOuI062vyyoyYsibXftUo
        p3z/rT0Fa/SlawnIUbVfT7k=
X-Google-Smtp-Source: AHgI3IY4QfQR1y0LrqJhJ2idCASFmSgjoYddZo9Kb+syvJFTCcwr+x0SBR2LRxgM5QHd9qSrOMTrFg==
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr19423173plb.238.1549585798704;
        Thu, 07 Feb 2019 16:29:58 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:29:57 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC v2 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
Date:   Thu,  7 Feb 2019 16:29:38 -0800
Message-Id: <20190208002941.30343-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for reset controller IP block found on i.MX8MQ.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index f6c37bf9cbce..50436bd393ed 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -254,6 +254,12 @@
 				              "clk_ext3", "clk_ext4";
 			};
 
+			src: src@30390000 {
+				compatible = "fsl,imx8mq-src", "syscon";
+				reg = <0x30390000 0x10000>;
+				#reset-cells = <1>;
+			};
+
 			gpc: gpc@303a0000 {
 				compatible = "fsl,imx8mq-gpc";
 				reg = <0x303a0000 0x10000>;
-- 
2.20.1

