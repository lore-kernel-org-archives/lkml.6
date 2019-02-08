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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DFAC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023EE2080D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 00:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+TQ4Gn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBHAaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 19:30:01 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:37900 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfBHA36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 19:29:58 -0500
Received: by mail-pf1-f169.google.com with SMTP id q1so817604pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 16:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uW/mc9bOKLDqIolIzjRAHEjOwO1/pc5BGZ9n7AiIB/k=;
        b=r+TQ4Gn6CBB2kcCKMo8Uqga7g3wHGv3ojbmKsPWXFoSlpMQMixy5Aye+pNvlgY2ixZ
         1Vvqtpi5QchsXZU+KpRVl+bJMXxXr47+/UN6epDiAFD+S0ywrNzDamDSzohAPxqyCODn
         aMbjHxfBmyffwakfdSVW+ii0T1j0ka0EPa1HKDdg3ZEnc9EmKKtTAiLhwI8doovx6DD8
         CifsIN4HoRLTMKxtNhJCVWYpMYWd2NMElgxLpdFE6U0e1Ruh+iCU6yiHk4Qkjsh9KFxq
         s0PQbnuzajNC3nRrmpy4KX1aDeeeXmFLu6UeOLB/WnYX3Wca7VwVTblo5rJUBQG3ebVB
         WWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uW/mc9bOKLDqIolIzjRAHEjOwO1/pc5BGZ9n7AiIB/k=;
        b=S55GFcl54n1YMQ1YQcWyQZERNlWo7D/gOZCtc49ptzjjI0gv7M3EBZPA9uR7io1ezs
         PbavGKUtsfUBaf9OGTL7i7xMg2LflJ94GNPY1y36zq61cy2cCm72l06oVKZawOh9tWdh
         0vN2r8PlDRx0KCV/7+dLai9QfIlg9NtkQhjass8+cLMqQLXncijk3qSsy8eoilo3EZz5
         MksO/GSmRRZmTqDjxRVRRMeTB50fO8mZY8KsrR8Fo2ZHZbZoKPynUo2c7d/8zMQjESKl
         NHIsXKRuyW5urLboDsAePuL9NiCIZcJRYmLiCfA/IQrtzJhPP54h5XsMM9mUgAU20cCR
         EbHQ==
X-Gm-Message-State: AHQUAubNH8xt8kmNXW9A7m7rUFIwQ6fF84ZQO3BOt1OneJfRpEVNvlP/
        YUidIAFExohrLOYiCpMVGHY=
X-Google-Smtp-Source: AHgI3IauG3AAMgvMTpqW5IOS494fZrzA6KIlc5MiaatGOwVfHh/ws3S4MsGmyV6yJIFvjR7PaMIFAA==
X-Received: by 2002:a63:ef50:: with SMTP id c16mr8662258pgk.3.1549585797269;
        Thu, 07 Feb 2019 16:29:57 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id p81sm380835pfa.107.2019.02.07.16.29.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 16:29:56 -0800 (PST)
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
Subject: [RFC v2 1/5] arm64: dts: imx8mq: Mark iomuxc_gpr as i.MX6Q compatible
Date:   Thu,  7 Feb 2019 16:29:37 -0800
Message-Id: <20190208002941.30343-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208002941.30343-1-andrew.smirnov@gmail.com>
References: <20190208002941.30343-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark iomuxc_gpr as compatible with "fsl,imx6q-iomuxc-gpr" in order for
to allow i.MX6 PCIe driver to use it.

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

