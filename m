Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13787C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16FB2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbE6S6FC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C16FB2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeIETHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:07:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43294 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:07:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so6265427edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 07:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x1X9SeLxMkYUfY/VqyIygkrF9CnPm2MQCzqigX/Lt3w=;
        b=IbE6S6FCGe9id6Cxtizw+sLo1JChbA5CmLBhDoQB+/BD4zmZMIuij+l9PIwOkgWoez
         7u0yi00GxSqk6jbMS961ktz+RUoB2YVyjiZ3xuF7eaXgS1kMJ+QKsLlUENo+sQRhzK7y
         yEmJR5f4k4x1aBmXx3XpmV7nPKLvExZrxvnxvu/4iLZZtZ2VODcXwdTSIQj5CheEPZRc
         VpW3BJX3lboFwxd/npNF/gPzP3lt2RQ3IbrzJgBJBdnirkqOkX/z+RpwU8xVLLIDjjju
         9pl2kGox0fPYZuB7cYWPAxYRSgirhSWdagqkFQWDQR5Jfat1bLANatM2LmeOS8Kc6D8l
         Yiwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x1X9SeLxMkYUfY/VqyIygkrF9CnPm2MQCzqigX/Lt3w=;
        b=rRB1YL/rjJOsQ/59hLQvFhs7qQecv7ZBFw6lEbxNE0lZEFta2nvrZhGTJMeG0BN/U0
         ysD1dBrmEEf5KzL9PFvUJlq7XlXEemH+SmqayBsZuBakZrB771Mo9IHpy6WmlRrxfAal
         enNxXNHm7Ilw+1NrrMJy5MtsveRUyuN0VFssqhgwglIeiAAtJyxC8/1Wsa8gMAEuaBqJ
         8JbQRwjOwhSNrkspql6x08GWQUyJPk2ZVMIGtQ5099DeygayzLa92zuxQDwkidvioWTn
         bHZGFQZWPd7vHRTyb74iWMTW3eqFLmj3SoAA1mbMXlmrSpChsG8rGy0LRY5RuZcvs0YX
         2oog==
X-Gm-Message-State: APzg51DlZZjLL9J4PsBqwSKIDdUo6eUvnD+t9DJKXGfhL+wt3IxQDLuo
        qpQJAZQ4Ak2GHAYY1MxSY30=
X-Google-Smtp-Source: ANB0VdY0dMXtuEjFWjB8sipa/10vMBMLR6rXovAeu3EItcBDqg5kCpI0fbgA3ByMXAmynaDiebZLrA==
X-Received: by 2002:a50:95dd:: with SMTP id x29-v6mr42974402eda.3.1536158222271;
        Wed, 05 Sep 2018 07:37:02 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u53-v6sm1556413edm.51.2018.09.05.07.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:37:01 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v2 6/8] mtd: maps: gpio-addr-flash: Split allocation in two
Date:   Wed,  5 Sep 2018 16:36:41 +0200
Message-Id: <20180905143643.9871-7-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
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

