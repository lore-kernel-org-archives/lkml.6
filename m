Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A1AC04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA17220E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLIyWtea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA17220E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeHURwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:52:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44947 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeHURwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:52:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id s10-v6so3431050edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1X9SeLxMkYUfY/VqyIygkrF9CnPm2MQCzqigX/Lt3w=;
        b=gLIyWteaqT/TgLGRTo7FYQOxVVTJSocdkmiXfrhUOjPzMiHeLmY3OoQpwo7mYuB63X
         V2AQFPPx+xV7UVobbdxuTjHfFfSQWdhGbjO7rTNIOaX8B5zrRZMu7UTe/LtVGpaFHYZY
         qLPtKHPw5MWwAZlGJGefHkBVL55ZEOlI3wKOvmXa0ZApfRuRS6eCdYLB/zkniChJyq3J
         YKluWNsyoX+piy69osoEILenU16MVwMiD6JLNBgUU7FfmX9HJgs6oUMPJSZpOJVnccJt
         VNUDi83grLLhfuTrKNLqEKNe9NvqVswIqDf9gb5k9bxHuWpAzUNwIkeNd9N4CssI34A0
         WMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1X9SeLxMkYUfY/VqyIygkrF9CnPm2MQCzqigX/Lt3w=;
        b=rsIOjFKdGm+CfhqqQxIzKxRf5hzzT0ulE7MVLHTjZaqpnhckoDPUFoSZSDHC5jH8eo
         JnXZe46jr+vD2/0roMkH1JPxxXweYNETpLjQnvUEmmkCIVAAAMTKCJzrH4DqgcLkFiUH
         NoXrAexVujsF+7SJxgWKJ0UuNzl5+gpIlLDLyisoq5ig/6HS7qWoZjSABuG9RMfjidLi
         HFk+leUyxkzA9ZeO+b24jeYI5HPtjo6IN5/V0RiFOoddVSmlFEX+njcNKymKpoB+MTSU
         rRmXii0ZWIrmdV+w/aDeCIp2ppQwd/s0GKfF0EYCGX8fK9IzcNK9y1u2aubu7T4p/l7l
         qCTw==
X-Gm-Message-State: AOUpUlGeyVUADR/fRN2+mw6Y8w4qRFB11cAy4J8aBryqn/TG7evYtDCy
        ExoWSIB/ZB5FflQn2gMN5PA=
X-Google-Smtp-Source: AA+uWPzNwMqbjX9ThmfyJ2TlSn054PrE5Vpo2Fo5uzvJPfdsROh6w780uLtjEZ8plmVH2fzsOI0+fg==
X-Received: by 2002:a50:8d5e:: with SMTP id t30-v6mr9061625edt.256.1534861927560;
        Tue, 21 Aug 2018 07:32:07 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6766144edq.10.2018.08.21.07.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:32:06 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 6/8] mtd: maps: gpio-addr-flash: Split allocation in two
Date:   Tue, 21 Aug 2018 16:31:50 +0200
Message-Id: <20180821143152.32293-7-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of making one allocation and then calculating the addresses of
those two pointers in that area make two allocations. This simplifies
the code.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 8f5e3dce9be3..9455a8448064 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -205,7 +205,7 @@ static const char * const part_probe_types[] = {
  */
 static int gpio_flash_probe(struct platform_device *pdev)
 {
-	size_t i, arr_size;
+	size_t i;
 	struct physmap_flash_data *pdata;
 	struct resource *memory;
 	struct resource *gpios;
@@ -218,8 +218,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	if (!memory || !gpios || !gpios->end)
 		return -EINVAL;
 
-	arr_size = sizeof(state->gpio_addrs[0]) * gpios->end;
-	state = devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP_KERNEL);
+	state = devm_kzalloc(&pdev->dev, sizeof(*state), GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
 
@@ -228,7 +227,12 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	 * away their pointer types here to the known types (gpios->xxx).
 	 */
 	state->gpio_count     = gpios->end;
-	state->gpio_addrs     = (void *)(unsigned long)gpios->start;
+	state->gpio_addrs     = devm_kzalloc(&pdev->dev,
+					     sizeof(state->gpio_addrs[0]) *
+								gpios->end,
+					     GFP_KERNEL);
+	if (!state->gpio_addrs)
+		return -ENOMEM;
 	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
 
 	state->map.name       = DRIVER_NAME;
-- 
2.18.0

