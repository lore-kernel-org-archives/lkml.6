Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A046ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2CA20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 10:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QCTFb1Ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2CA20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbeGRLc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 07:32:59 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44654 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbeGRLc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 07:32:59 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so1870439pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sj2w0YJhE4xroQbeLqcCEMbt4cE6iRcObMqpOtEaQEw=;
        b=QCTFb1AxfWkGgbdbvApqVq0YNMgFHAk5TTm9xKVt1MUEfqMMr6oP3dvW0xAWyQzYYV
         ywTU3MoDPwh0M7NIVvljFeP2WQIlIiaEZGc047GRsmCIejXOmwcuZnxrNsVRnQs1kN0/
         tYGNQGfk7kbOsavn31aPl8l/zxPUTSnXO1260=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sj2w0YJhE4xroQbeLqcCEMbt4cE6iRcObMqpOtEaQEw=;
        b=ue23KE4ks4DjHNV8SOs5ho7UcGkltcuFpo58vnDhJxdfTQiUcAGRkdXcqfet8iQOGe
         +1sixaX8ji9ydm7wsCIi7zGIIEO1Ox6VmesaXnXx+gSCZQmkbzg+oM96VFGK1s7719pJ
         fNgLZiOk2d0o8DeU4etDfEuSa0EEy7M236yCPfodGIs2hzNPFbpifpRrhni0+wMgjQYB
         PaEne5qd1yu+vFE/nqmUrxYQ26SkP2ptezi9X29bQfqHFZcnqcUog/BnkeUtqeKY681g
         SWvQPFBa2YlGqoCCuz4Z2WCYkMnUqXAtC1/8w1oC2UldKVHsRtbHD987g2kHY5xhjSyy
         weag==
X-Gm-Message-State: AOUpUlG8UVTddWSNSN+XCZ8pX90yqeU6Bpy3fmL8jmslPjZLJo1ydRJH
        ncl6b9RIwbuDudT8y0yD+d4GfQ==
X-Google-Smtp-Source: AAOMgpcH+e4/wmruibpTT6wZHYELu3tSXRtzUVnUVQooWhXHOkDIL+PJgJS15qzZfp4BvHd1IBW+bA==
X-Received: by 2002:a17:902:b08a:: with SMTP id p10-v6mr5393577plr.217.1531911339446;
        Wed, 18 Jul 2018 03:55:39 -0700 (PDT)
Received: from localhost.localdomain ([183.82.229.107])
        by smtp.gmail.com with ESMTPSA id x25-v6sm4644452pgv.63.2018.07.18.03.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 03:55:38 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 04/18] drm/sun4i: Add support for A64 display engine
Date:   Wed, 18 Jul 2018 16:24:44 +0530
Message-Id: <20180718105458.22304-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180718105458.22304-1-jagan@amarulasolutions.com>
References: <20180718105458.22304-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display Engine(DE2) in Allwinner A64 has two mixers and tcons.

The routing for mixer0 is through tcon0 and connected to
LVDS/RGB/MIPI-DSI controller.

The routing for mixer1 is through tcon1 and connected to HDMI.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3, v2:
- none

 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 03ffbcc98dd0..30a39946f747 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -421,6 +421,7 @@ static const struct of_device_id sun4i_drv_of_table[] = {
 	{ .compatible = "allwinner,sun8i-r40-display-engine" },
 	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
 	{ .compatible = "allwinner,sun9i-a80-display-engine" },
+	{ .compatible = "allwinner,sun50i-a64-display-engine" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_drv_of_table);
-- 
2.17.1

