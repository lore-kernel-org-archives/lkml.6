Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06635C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7011218EA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="E8nhCi+5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfBAPoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:44:24 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42282 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730707AbfBAPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:43:09 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so5359509lfh.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 07:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ckydVo2IPZQfXMKYGz1uqlUzm7n70fMIZ1xjq1PJknE=;
        b=E8nhCi+51LFS/kCsQ1K0KO5+96kzYaeX7hDXRUYltlI6GmQF3+G8oEy6e0xFYms18b
         vZRdpwrd1Ds1h5VfxOPgZFMabM7zq0/aRARe0iYvgzPEbJSk89y0exU+yNvSzCgj0q7d
         8dhqP53svf3j5DCMJccHQgTKYIx346UKMJg5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ckydVo2IPZQfXMKYGz1uqlUzm7n70fMIZ1xjq1PJknE=;
        b=T/k9DeqryusBqiJGslwJbWYYeN67Ke2fInk+EctZmKeJjWqbSKSthAevyGaX1AOECN
         gJ+fm2xLDDtA6MO+YoFwiGgUywu2ePEKHKUetOzuENR8tOv0pSBNb4JHsxAXz2aJ7PZd
         IKYT99vy05rgNqZDSTHX8W9hQXY2SYeZCqbjLzx2+ng7BiGkfziaLFTGifQzHcWqsWB+
         2BkGsKKho1lSxeQvQzQXx/ZLgj3y5j+U+rhiVwXnxGskdYlOaAE58VeB1ew02fC3U47q
         VnlelPGRAstHpq8Uhe4CzLBuxFinSH0wrz9uC/BmvbjFLOfZRZVLmmxQAsdu+5ZP3M5p
         ms+w==
X-Gm-Message-State: AHQUAuZnjmXIEPipL+W/KfuURjzdveSI7LZtvQ4P8MHYGW1tZxQP/HwC
        HR1oMtt0lFt4LkWUfUWfUzlCng==
X-Google-Smtp-Source: AHgI3IZXZu3/LqaYemTmfQvJ+qkjvAYaHJ7++ebH1U4g7xMEGGgRaGFNyutXQx6O1Wipu4jnjxT0rg==
X-Received: by 2002:a19:c18d:: with SMTP id r135mr1692116lff.59.1549035787575;
        Fri, 01 Feb 2019 07:43:07 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
        by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:43:06 -0800 (PST)
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
Subject: [PATCH v7 13/23] dt-bindings: sun6i-dsi: Add A64 MIPI-DSI compatible
Date:   Fri,  1 Feb 2019 21:12:22 +0530
Message-Id: <20190201154232.10505-14-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MIPI DSI controller in Allwinner A64 is similar to A33.

But unlike A33, A64 doesn't have DSI_SCLK gating so it is valid
to with separate compatible for A64 on the same driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Merlijn Wajer <merlijn@wizzup.org>
---
 Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
index 1cc40663b7a2..9877398be69a 100644
--- a/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
+++ b/Documentation/devicetree/bindings/display/sunxi/sun6i-dsi.txt
@@ -12,6 +12,7 @@ The DSI Encoder generates the DSI signal from the TCON's.
 Required properties:
   - compatible: value must be one of:
     * allwinner,sun6i-a31-mipi-dsi
+    * allwinner,sun50i-a64-mipi-dsi
   - reg: base address and size of memory-mapped region
   - interrupts: interrupt associated to this IP
   - clocks: phandles to the clocks feeding the DSI encoder
-- 
2.18.0.321.gffc6fa0e3

