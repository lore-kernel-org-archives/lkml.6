Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF12FC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE38920855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fuSJpcZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfBAPnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:43:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46359 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730414AbfBAPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:43:11 -0500
Received: by mail-lf1-f67.google.com with SMTP id f5so5345119lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RkT9METwUUSf5QTEToG7HBPINV4tos+GivD1TLgNTbs=;
        b=fuSJpcZNCoygctJX7n5myqfviNkMrtTfal+KUTcqzhZTYZmOUvONI/NqQktM7dDAAz
         g88EPytgTbpF6fIHV9zFZMMFRWHYW7+O8+U2X7CM4EhFHOz8X4fJ2w+i5HWv2/JvzyL5
         lvVaORZInY6yDpy6pfIzCa/81v2xbhksnRNFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RkT9METwUUSf5QTEToG7HBPINV4tos+GivD1TLgNTbs=;
        b=Hytjv3rWjugeLGN/DmLU5Oh+HG7yM4FMAxIYthmpBGg+a07MglsxpLHIVkwPGCeSGi
         SHxreNdLTF0WAIX89QBfyyZGM7qXydfoNpzi7+o5tS+Lj9o3OhETev8sn0RwWN9xvz98
         I+ymjsvGHOg1hr32vzrpdJBvH8n6Y7Jrx0YAl6rpb7pucPJ3tVr8uMQa2KwUlRDLlFoZ
         eegMm620uGGIV4Vxw2HRl5gHZ/BXiW+8ZVVPwQFG+Zcrz/sNOnPowt7JR4FfXVOKjbOY
         IRDVnVP1xGAvXxovea1LrtLiZlcwstRrJ68CZrcqlsd0DzkqDxFx6Pf5uVShe+Yy0ds6
         9WdQ==
X-Gm-Message-State: AJcUukeoujXiUX3NbDMyKeQxnnBFqWiLLyP2G+BR5jcDj5vficxxhpgZ
        r7mYkmx6HlM0wKIJf2xMDNPTKw==
X-Google-Smtp-Source: ALg8bN7Kxw6Pf/EAOmaIxz8Mx9Obn9sKEf9HWZo8iulGMFl1o3mrN3mA3vv/zvG2r+/EChgFTcCU7w==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr30132103lfi.19.1549035789216;
        Fri, 01 Feb 2019 07:43:09 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:43:08 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com, linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v7 14/23] dt-bindings: sun6i-dsi: Add A64 DPHY compatible (w/ A31 fallback)
Date:   Fri,  1 Feb 2019 21:12:23 +0530
Message-Id: <20190201154232.10505-15-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI PHY controller on Allwinner A64 is similar
on the one on A31.

Add A64 compatible and append A31 compatible as fallback.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 9877398be69a..d0ce51fea103 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -38,6 +38,7 @@ D-PHY
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dphy
+    * allwinner,sun50i-a64-mipi-dphy, allwinner,sun6i-a31-mipi-dphy
   - reg: base address and size of memory-mapped region
   - clocks: phandles to the clocks feeding the DSI encoder
     * bus: the DSI interface clock
-- 
2.18.0.321.gffc6fa0e3

