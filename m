Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5922C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B34E42146F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 01:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZaofClG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfBTB7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 20:59:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41304 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfBTB7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 20:59:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id d25so2755034pfn.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 17:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2SRxal34wQeNyZlTUmsGVAEJJg7Go7JQ/XIJK9SAQAA=;
        b=tZaofClGEBOOIov8h4JL9zYgGCgXM0EjZZOFg921jUIJUxrDjFqzrf9FafxlAPynuX
         MMtRP7GqZN7eNqNDvGSPczf+dYlWlh9EvjQz5adxa8Ch89jZZUUrPj8vqiSanM6vUXBF
         9wcLAhlue05bCoEJFwfq5qpqqs8IOilpojFCFXx4hqu0k8BFrO0hKS3hDOlyNKHQa8Mk
         4BL8y7ek4m1qGX1jlNe2Yc7XH27YHj0vtdkYVPov+1cPm7Hv4AtZeZxYVeF6n1cNUaPy
         tpCYciUyW+un931rWBivM3oBXbJ5BpFZDMkW3x84GvGdVSN71U4PppY00LRI1914y0dr
         iQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2SRxal34wQeNyZlTUmsGVAEJJg7Go7JQ/XIJK9SAQAA=;
        b=YriTqfM9DA1Y6I1+MpgSClvl1jFLDRQ8HzjCzAzNXTaNdzhaJzu59mAIkyvE0zOQcM
         1keoT2aXPY9EF2xLB8IYyhFNkk1c9PD4/zsfNe8uqS43U3Jk1di7WdKX4QW1tGUqNePm
         wKG6rAGWzDX52+DnwKyd3d6Ni49BYnIOV2z8hYltz5M5C3bTLOi+aomNOINICaZvulBs
         ELO1Gt3LpMvkmRXS0k4b4Fg9WwQu0A8VEGNzmbxKFpmH+pcpdJQ7yFfFoGS1OAugVjAs
         4Opa/8vk4Uxlcgs6OKX7IpB2b8TwZilu7efnhIrN+fsVRpoVjX0JXnSlt7uu8so5Ofdf
         Hj2A==
X-Gm-Message-State: AHQUAuade4sHW9G+LFWexxejiymkcyp250iXE6KotJ2v6sWz/+ogaoDh
        SCj3rW5KpeFrAQ23l9sfYmY=
X-Google-Smtp-Source: AHgI3IZj30pfN8U9fiZ88V05TZS+7EDHUJVRGvotfAXk4QhdwEsS7cu/o7nEqxPLKyBCxH3COHl7uQ==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr26930331pgm.414.1550627949904;
        Tue, 19 Feb 2019 17:59:09 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id h3sm2562525pgv.38.2019.02.19.17.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 17:59:09 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
Date:   Tue, 19 Feb 2019 17:58:53 -0800
Message-Id: <20190220015857.7136-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220015857.7136-1-andrew.smirnov@gmail.com>
References: <20190220015857.7136-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark iomuxc_gpr as compatible with "fsl,imx6q-iomuxc-gpr" in order for
to allow i.MX6 PCIe driver to use it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Acked-by: Lucas Stach <l.stach@pengutronix.de>
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
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 892063a7c26c..f6c37bf9cbce 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -230,7 +230,7 @@
 			};
 
 			iomuxc_gpr: syscon@30340000 {
-				compatible = "fsl,imx8mq-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx8mq-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x30340000 0x10000>;
 			};
 
-- 
2.20.1

