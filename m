Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB5EC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7A520881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 20:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1xVUXMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfAaUoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 15:44:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32983 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728989AbfAaUnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 15:43:51 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so2035867pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pfG5fkUaRj/fht/6ipkewqnaacFZ9IZoXIVJQq92s6U=;
        b=O1xVUXMmY8mLwMYtaFSd0Mi55r4/0iuNEytSdQ5/azYdmkHpmH5LPAgZgs+JBFIKWj
         Kt7+76kvZyGgMLODm00ZTUeybIkv8wOZdEmGJzlYhplCRtmLxmzAi/meNXpzfmQMReZO
         EA8DFsLEVqwuV3Vny+igmrAoXw+CNhoOJsL6UvA9ZdqDwkSt1nUqPhBTIi1PYDrIraph
         GRNKyNJk9fcakxEluSHBooEIVyjSzTe99/1ggcQfatgOj1Gay0Y/nDbH68aVauxz/F1b
         YLYttGTI2rI9fQJNsrluRyJxUyctd37UJ8va8XGhIF5mJbx1O5rQnNOjpDLKrwsTN+p5
         xYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pfG5fkUaRj/fht/6ipkewqnaacFZ9IZoXIVJQq92s6U=;
        b=qbfl5Kohc1JkDfgfHf54FE2RhA1tK7moPC8W+spZNLNHYr90dxfbnkW4RC+B4C76/w
         9BW7lSEGbS9jJzER0JvEuUmOAi3VYaKiEhr9Mm9aNxgFQyvhG0wHKUpq0JUrGwnkjrmx
         3LTlBxnrXpXOG/T5keCOvXQx9fuHq0jLN3ncBoVq0U6YiqY2lBSl6fZAA4YTc4YVHlvq
         X+fPg+AK7jCk2XnHNuX0FbAsY3XGYmsYJEeM94qIyGmWI1U8VMRt+Hbs6m18BlP5ht9Q
         x3fVsR6WkPj7cUGKktSOjVegzBs3HxxbnpfCIjgFMkfnoJMfJ4dPjcXPquY4UvhSE9fi
         mvPw==
X-Gm-Message-State: AJcUukfGUWQzRroWGzL447Q0yb5ggWwIuxu5wqkEZxhK47t6mVYQvg42
        HcbDFihzrls8K1HAbt+FYW4=
X-Google-Smtp-Source: ALg8bN4BqZ9LC4h3GFTwcODC23FmHtDL/aJJyqv6O/kkXxW6SHpSg9WimWbsxDDndW4CSbLbDMK0yw==
X-Received: by 2002:a63:e001:: with SMTP id e1mr26721389pgh.39.1548967430002;
        Thu, 31 Jan 2019 12:43:50 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id s190sm7272034pfb.103.2019.01.31.12.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 12:43:49 -0800 (PST)
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
Subject: [RFC 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
Date:   Thu, 31 Jan 2019 12:43:30 -0800
Message-Id: <20190131204333.31846-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131204333.31846-1-andrew.smirnov@gmail.com>
References: <20190131204333.31846-1-andrew.smirnov@gmail.com>
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

