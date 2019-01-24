Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BAFC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E2521726
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="a90IHH49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfAXUAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:00:05 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39925 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731786AbfAXUAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:00:03 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so3534957pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Mn8TUKedPpPTwJJGFCwGJQpWISkySJ1aVESwLSs9Og=;
        b=a90IHH49RLC8u6YgVR2YrGTkKeb3Zwe1s490sZYOmkA5ikOdYurAIGn40rdO5IJLLb
         WaLV6ku6UwDgFYLAAWlsDvXATmill3rfsWge2+kK1a+bu4P/SrhiZafvGGiVqO+IQ3iF
         KYtVn4JY2oow8J659KR1jUYFF4tpbwGufMF2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Mn8TUKedPpPTwJJGFCwGJQpWISkySJ1aVESwLSs9Og=;
        b=Pef1eehTUVU6GwwWMvk7W6fj84f3TqFL8Efywzb6/tWiOv+yXdbh2GPKoUh+ek5AAj
         dqbb0ftZNlaTr/albp7hYLqZ7Ji04kCGoSVVUuFBB8llz0JX4VuuHfB3IPJ+eFEwHKHJ
         wEKJb5MfsNCrynT39jyVHJV9/wEZKWzN66L+jaxqUGvHPY4j1cWiFpQhxxOkyCrRRiR3
         ZBuDePT0PH77UIRDd/ncWAuC+VK/WY4sDBH+tV4nCh8Beuc9eRzNjLC+00vF4AuhQ/lS
         q/Uk4sTL0sK+xXdjUVKoBOzQbkSdVr3+peQX5SvutWtS1VCC4k550SyrwNcoTXi/YwSY
         iKEw==
X-Gm-Message-State: AJcUukfYp1j96otdgxg4HgHBSW7Zaj51CS4PxonesZgV6rq7/wNvx0mT
        e8dZm1ko9QC8hhqLWqrDW4xzOA==
X-Google-Smtp-Source: ALg8bN4cAGeBI6s1ZiVbiYz22ae57CBUg/beYIPEDJ8uj3kLe/zNBcz8/iJJHjtbyolmzAsMvMZrgA==
X-Received: by 2002:a63:7e5b:: with SMTP id o27mr7163496pgn.214.1548360002252;
        Thu, 24 Jan 2019 12:00:02 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.11.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 12:00:01 -0800 (PST)
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
Subject: [PATCH v6 08/22] drm/sun4i: sun6i_mipi_dsi: Enable 2byte trail for 4-lane burst mode
Date:   Fri, 25 Jan 2019 01:28:46 +0530
Message-Id: <20190124195900.22620-9-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For 4-lane, burst mode panels would need to enable 2byte trail_fill
along with filling trail_env in dsi base control register.

Similar reference code avialable in BSP (from linux-sunxi/
drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)

if (panel->lcd_dsi_lane == 4)
{
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_inv = 0xc;
   dsi_dev[sel]->dsi_basic_ctl.bits.trail_fill     = 1;
}

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 46ad142e66e8..a2ad9fa7f8d5 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -33,6 +33,8 @@
 #define SUN6I_DSI_CTL_EN			BIT(0)
 
 #define SUN6I_DSI_BASIC_CTL_REG		0x00c
+#define SUN6I_DSI_BASIC_CTL_TRAIL_INV(n)	(((n) & 0xf) << 4)
+#define SUN6I_DSI_BASIC_CTL_TRAIL_FILL		BIT(3)
 #define SUN6I_DSI_BASIC_CTL_HBP_DIS		BIT(2)
 #define SUN6I_DSI_BASIC_CTL_HSA_HSE_DIS		BIT(1)
 #define SUN6I_DSI_BASIC_CTL_VIDEO_BURST		BIT(0)
@@ -464,6 +466,10 @@ static void sun6i_dsi_setup_burst(struct sun6i_dsi *dsi,
 	/* enable burst mode */
 	regmap_read(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, &val);
 	val |= SUN6I_DSI_BASIC_CTL_VIDEO_BURST;
+	if (device->lanes == 4) {
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_INV(0xc);
+		val |= SUN6I_DSI_BASIC_CTL_TRAIL_FILL;
+	}
 	regmap_write(dsi->regs, SUN6I_DSI_BASIC_CTL_REG, val);
 }
 
-- 
2.18.0.321.gffc6fa0e3

