Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9002C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9928A2147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="U45XSPt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfBDJtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:49:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34101 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfBDJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:49:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id f7so13729481wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 01:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aJKpDy3gSru5/yeZkdF8qEEYyeLbGINpZQT5a5qGfg=;
        b=U45XSPt3vXXADrNKM1Cn4aYrHY1JoG/c8vqzxpbzdEswLo9kIU7WvMm52WehCXJ6MP
         JPxmPAm1z7W3XWiB4eJ0K/NgLgdBR6oK72IyU4ra9F1t7mIwLWP0xRCPn/CLUTjwhEm5
         yLf5yVNmDG+E/lOcDLtyBIjGtOorCk6o/bKIitmlg6tDJlaVSG0/XwII/rBWFzOiUsYt
         AGsZcZ5iJ6KY9KK5139AN76yyYM41z0g9ZA+HLoHbIfyaTPNRpslF2E7/oSbJ33kUnRk
         Vw8TMT4KrQTkcT1H/cinaEsAYzh37d3xrBREP/19Bz7rOk8EaQ1FXfHEicLn6BEuNMaW
         LY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1aJKpDy3gSru5/yeZkdF8qEEYyeLbGINpZQT5a5qGfg=;
        b=H5JBACtA4AIHK4iY1hDMjIaO+baBYguNRBJ6/+pyQOuQ1h8JLC+7K5TFzPOrsABj0F
         JRFWybbPanZMJo1iIOcDN8vTC7TKV1PQjnHUHKCtY90S3TqoIrkWLNSkQmA9d9ds8ZoR
         11MAqvNc+0SllKp+GtojEfpWbgG2G54MdkcWIp2n31jOZZ+QXjz3jJBT2cfgc5SxIcwM
         xEAuOT5t6vCWH0a1SOuIpc5dMkw6y11emqox1s3OHK1DIAW9ZcV04wLSG+KiUF+uqL4k
         xhW2zF6MR+rcjMga9VHwC2a16ZCsZsoMY9uZky59Jj41p64yaOeouEn3ZRLY0PW3q8wr
         Ijlw==
X-Gm-Message-State: AJcUuke6Ye4Sx7ZROo9VXdAecsVHFn0t60sgxs3i5DGCyqY/MGDcW+g2
        BrN/EBaNS+5yRz7GJIIC96nBtg==
X-Google-Smtp-Source: ALg8bN63COmWcluxOx4nbtfWy7lq6CO1QBOGik3CaPZ36RwQvhhuGEGhIfXSjdfZSa+GA7ZgZQf7jg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr49558677wro.32.1549273779348;
        Mon, 04 Feb 2019 01:49:39 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y20sm10248655wra.51.2019.02.04.01.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 01:49:38 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc: amlogic: canvas: Fix meson_canvas_get when probe failed
Date:   Mon,  4 Feb 2019 10:49:37 +0100
Message-Id: <20190204094937.22763-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When probe fails, a platforn_device is still associated to the node,
but dev_get_drvdata() returns NULL.

Handle this case by returning a consistent error.

Fixes: d4983983d987 ("soc: amlogic: add meson-canvas driver")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/soc/amlogic/meson-canvas.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

This fix depends on "soc: amlogic: add missing of_node_put()" at [1]

[1] https://patchwork.kernel.org/patch/10794545/

diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
index 87a6c6e23591..151aa84bc593 100644
--- a/drivers/soc/amlogic/meson-canvas.c
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -51,6 +51,7 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
 {
 	struct device_node *canvas_node;
 	struct platform_device *canvas_pdev;
+	struct meson_canvas *canvas;
 
 	canvas_node = of_parse_phandle(dev->of_node, "amlogic,canvas", 0);
 	if (!canvas_node)
@@ -63,7 +64,17 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
 	}
 
 	of_node_put(canvas_node);
-	return dev_get_drvdata(&canvas_pdev->dev);
+
+	/*
+	 * If priv is NULL, it's probably because the canvas hasn't
+	 * properly initialized. Bait out with -EINVAL because, in the
+	 * current state, this driver probe cannot return -EPROBE_DEFER
+	 */
+	canvas = dev_get_drvdata(&canvas_pdev->dev);
+	if (!canvas)
+		return ERR_PTR(-EINVAL);
+
+	return canvas;
 }
 EXPORT_SYMBOL_GPL(meson_canvas_get);
 
-- 
2.20.1

