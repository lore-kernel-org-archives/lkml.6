Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E78C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD3C20684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBcdk28E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD3C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbeJATVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41402 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeJATVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:44 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so14042268edd.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MMQ9kfM7flhT0ujfnmfa8SGNilm0pWVzU+faJ5UvNts=;
        b=JBcdk28EuEDBC+QcTyyPmGbFIEx3O7YGKlo5eIrtaR2cbSlWM9C4viuu/jzlJ8MaX6
         R/aHDCfF1lVfH3s37zdaW3xvewzmtrMjYHKymkghwKY+M14TwowE6Hc4BRhv0+ZmM3hH
         mGSaagNZ7JeNhRmbYSfDjbf7jIi8UryBBYQtjq95/i0ueh0rk5MCEeNgMnC0wN4v8BJH
         XbQWCtcBlkPqYweWj17MxT2VSJkFn/v0h07MrE2V0hgjG6L9tEULyhxCZ0BVwvHN0YwL
         3GKRXtbOsELricHPsDRGboOXKbMg5GGXlT45JfJM/7Y0DQbzMGYL6ftm4W7tr+uPdzYm
         FFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMQ9kfM7flhT0ujfnmfa8SGNilm0pWVzU+faJ5UvNts=;
        b=YoctRhKaBEUnx449Oguprtd/yskSvglYqV22nG/h24E8VpB2pAFY/GOdiHfniJl39i
         u6OV0rTY5mnOkJob5qjGrR7iH5gCke2kqS6tE+oZELMcrOTm112tiNKX2788JJu+wJG4
         4uk8owmwdp94j1CSlVfoKyQEB8Z9+c1SAS0i6RJ3CQEt27GvczyI5B/V1A7IjvA5ltXw
         9HC7cobC2k31leHT/bQBHSZX0+qntv/EqHG4w5GDClXLO87uGvxDdVRgoaPzriQcgwAp
         nbNJzDD2O8cJ+fsitn6XBK/C9oIKriA2HbkVQp0+jSXwRQNnSt4a02bWKEDA/3XM+vTD
         7b3A==
X-Gm-Message-State: ABuFfohZAy7S+TU8jE1T2yYRxJpCxc23pyYy5KARpfD7lsLDvBpmGfc1
        vGXTGMLfDsm47+gN2Sxhz8k=
X-Google-Smtp-Source: ACcGV61jD3G7VCB/jwiqvWR0uIeUFTtQsU8MqBUod0hsSVEpVlt8hA1f2fQ7UxZEhjKrNa8Brz1E+Q==
X-Received: by 2002:a17:906:66cd:: with SMTP id k13-v6mr14198164ejp.152.1538397843850;
        Mon, 01 Oct 2018 05:44:03 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5278700ede.42.2018.10.01.05.44.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:44:02 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v4 6/8] mtd: maps: gpio-addr-flash: Convert to gpiod
Date:   Mon,  1 Oct 2018 14:43:49 +0200
Message-Id: <20181001124351.31615-6-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert from legacy gpio API to gpiod.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 45 ++++++++++++++++++------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 47b12a6fead4..c6fe1de33a82 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -33,16 +34,14 @@
  * struct async_state - keep GPIO flash state
  *	@mtd:         MTD state for this mapping
  *	@map:         MTD map state for this flash
- *	@gpio_count:  number of GPIOs used to address
- *	@gpio_addrs:  array of GPIOs to twiddle
+ *	@gpios:       Struct containing the array of GPIO descriptors
  *	@gpio_values: cached GPIO values
  *	@win_order:   dedicated memory size (if no GPIOs)
  */
 struct async_state {
 	struct mtd_info *mtd;
 	struct map_info map;
-	size_t gpio_count;
-	unsigned *gpio_addrs;
+	struct gpio_descs *gpios;
 	unsigned int gpio_values;
 	unsigned int win_order;
 };
@@ -66,11 +65,11 @@ static void gf_set_gpios(struct async_state *state, unsigned long ofs)
 	if (ofs == state->gpio_values)
 		return;
 
-	for (i = 0; i < state->gpio_count; i++) {
+	for (i = 0; i < state->gpios->ndescs; i++) {
 		if ((ofs & BIT(i)) == (state->gpio_values & BIT(i)))
 			continue;
 
-		gpio_set_value(state->gpio_addrs[i], !!(ofs & BIT(i)));
+		gpiod_set_value(state->gpios->desc[i], !!(ofs & BIT(i)));
 	}
 
 	state->gpio_values = ofs;
@@ -222,12 +221,17 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	if (!state)
 		return -ENOMEM;
 
-	/*
-	 * We cast start/end to known types in the boards file, so cast
-	 * away their pointer types here to the known types (gpios->xxx).
-	 */
-	state->gpio_count     = gpios->end;
-	state->gpio_addrs     = (void *)(unsigned long)gpios->start;
+	state->gpios = devm_kzalloc(&pdev->dev,
+			sizeof(*state->gpios) +
+			gpios->end * sizeof(state->gpios->desc[0]),
+			GFP_KERNEL);
+	if (!state->gpios)
+		return -ENOMEM;
+	state->gpios->ndescs = gpios->end;
+
+	if (!state->gpios->desc)
+		return -ENOMEM;
+
 	state->win_order      = get_bitmask_order(resource_size(memory)) - 1;
 
 	state->map.name       = DRIVER_NAME;
@@ -236,7 +240,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.write      = gf_write;
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
-	state->map.size       = BIT(state->win_order + state->gpio_count);
+	state->map.size       = BIT(state->win_order + state->gpios->ndescs);
 	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
 	if (IS_ERR(state->map.virt))
 		return PTR_ERR(state->map.virt);
@@ -248,14 +252,19 @@ static int gpio_flash_probe(struct platform_device *pdev)
 
 	i = 0;
 	do {
-		if (devm_gpio_request(&pdev->dev, state->gpio_addrs[i],
-				      DRIVER_NAME)) {
+		unsigned int *gpio_id = (unsigned int *)gpios->start;
+
+		if (devm_gpio_request_one(&pdev->dev, gpio_id[i], GPIOD_OUT_LOW,
+					DRIVER_NAME)) {
 			dev_err(&pdev->dev, "failed to request gpio %d\n",
-				state->gpio_addrs[i]);
+				gpio_id[i]);
 			return -EBUSY;
 		}
-		gpio_direction_output(state->gpio_addrs[i], 0);
-	} while (++i < state->gpio_count);
+
+		state->gpios->desc[i] = gpio_to_desc(gpio_id[i]);
+		if (!state->gpios->desc[i])
+			return -EINVAL;
+	} while (++i < state->gpios->ndescs);
 
 	dev_notice(&pdev->dev, "probing %d-bit flash bus\n",
 		   state->map.bankwidth * 8);
-- 
2.19.0

