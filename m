Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BFC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6721218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ljfkEW3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfAXUAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:00:11 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45355 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbfAXUAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:00:08 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so3359870plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8q97sbmpzgiJ0X8sY10lWWdB/Eo6/FNKaSHSF4bAxYo=;
        b=ljfkEW3e5CkcbpUDcCUm2KymfdIdH5kLxFLVfaeP2gMsoJoDHICvERjswSxoPmFqPM
         EFFj75rodXEVTPCimGazX3Tiiry2kz0RKcHQ5WOlhmK0fkvy2mUJ8HLT2plqiTUEDqKV
         itBRjaeY3H2t/oBCydXgFmvS6jX5rEqdIxJm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8q97sbmpzgiJ0X8sY10lWWdB/Eo6/FNKaSHSF4bAxYo=;
        b=FaXXVzFtIQboaJvifWSzDsx0qs9RmsTYroMrL/B0O78Oh+CbTHjLzzT9Ucx26gOqy7
         oeHTCkVvdOOQ/F0sqlmDEBDeoqSWOgkTM38g+l2IxazpkCDqoOImFRJpKFq+c6EQhGJ3
         tvVG0RQv0O8+lHxjQOtxKpOTGGwNcwDM//XvCrb2ERco+TJmVK4Q9A9BXF+gZBb17LWt
         0pihJWMxl/PONGIZCblnT9gjTpvd8c72Dfe/pZKU0wtiNXPFGD9CcAYS2cljlgtbVTS7
         E6m38hNWJuF3S6ppvS0j+oluz+REIHM8C4NfDlSETYJWmFFtyc/RJDSbOGkHOKhb6mcJ
         Y/EQ==
X-Gm-Message-State: AJcUukcYVd5fAAFONfmyE1B9jkbGkYDUZaEf8hRrO3TWSIBZn346kvVF
        mF/AKacHq6iTL8rDEYvnh9nuXw==
X-Google-Smtp-Source: ALg8bN4JB1sFbrT1QGetXTKGwn0uHo8a4Ub5bRDOtZZpisg2qwYQ4vbkWFp9Gite9nop0n4WrX0J2g==
X-Received: by 2002:a17:902:3283:: with SMTP id z3mr8014727plb.76.1548360007757;
        Thu, 24 Jan 2019 12:00:07 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:00:07 -0800 (PST)
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
Subject: [PATCH v6 09/22] drm/sun4i: sun6i_mipi_dsi: Enable burst mode HBP, HSA_HSE
Date:   Fri, 25 Jan 2019 01:28:47 +0530
Message-Id: <20190124195900.22620-10-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Horizontal back porch, sync active and sync end bits are
needed to disable for burst mode panel operations.

So, disable them via dsi base control register.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index a2ad9fa7f8d5..3d7c03161954 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -549,12 +549,17 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	u16 hbp, hfp, hsa, hblk, vblk;
 	size_t bytes;
 	u8 *buffer;
+	u32 val = 0;
 
 	/* Do all timing calculations up front to allocate buffer space */
 
 	if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST) {
 		hbp = hfp = hsa = vblk = 0;
 		hblk = (mode->hdisplay * Bpp);
+
+		regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
+		val |= SUN6I_DSI_BASIC_CTL_HBP_DIS;
+		val |= SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS;
 		goto alloc_buf;
 	}
 
@@ -603,7 +608,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
 	if (WARN_ON(!buffer))
 		return;
 
-	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, 0);
+	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 
 	regmap_write(dsi->regs, SUN6I_DSI_SYNC_HSS_REG,
 		     sun6i_dsi_build_sync_pkt(MIPI_DSI_H_SYNC_START,
-- 
2.18.0.321.gffc6fa0e3

