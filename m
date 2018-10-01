Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C02AC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6390620684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er7sHnp8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6390620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbeJATVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40822 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729245AbeJATVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id j62-v6so14042722edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZUbn50UsHuR5ct+6gyJtPRAN067Ky0FADOBnmfRKwk=;
        b=er7sHnp8+EEuHm3NSyIVwJTG/X/IaJKI5GvTlpw/I8yVuJ1HoPIrcZFS0kk200FEtF
         8h7VPRy9qYj+pGHUwz45pxwYFyODYfIfLzK131miMqsbrN1KscXvIsc7qlQltNcGf+hF
         h4syNmPIXxWL25YpeGc/Q7fBezF5KzZBcIOVz8ZEW1oCEJ3YjyfoKeensnRv8Wz7ZsHB
         iGKp/QTdVhC5nb+HJLp1OKIMunO8Qi/5lSq3GkC2K3eFmcSGWFWIzvkppN5jYyHBFcc1
         Wh5Egw6Ji3MD+/Mn8tGkv5xx9B+urM4DfSU5qF1SCCNd7RudhkxvPamtfg3qgV5rvcbC
         T2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZUbn50UsHuR5ct+6gyJtPRAN067Ky0FADOBnmfRKwk=;
        b=mWFMoluPzCGufijZYX0KXgY00bP/m9wvOF2vRvvQCU9i6aA7HvypCRnEDO+64wGYRQ
         qOiKWffzihCnFGtYoXsuW3O5wVz8PU8D45yD7w60c0FJVu5xYmaCi71qKtaP/4iNpi0C
         DDrM+CMFxCoBCZW+K0nQ1EO8f2Mnhx/2Xcbh1cQJ1EtX5eP+AasHw430FDOLHHfpRRGx
         LC5dhwLAWft8i5Nt9wap249K1t0O0ntzpQQR2zWjXS2PLQmI4KwYEZ9VGltpzNOmfDNB
         Uc+pOsEbwdUZE47G3WQTj+Tkcv0JXlwXCdzM7Z4nIim9ogPB5db1FMf1h4XSJIQTywYP
         G54w==
X-Gm-Message-State: ABuFfohGBgTXbQuIjAw5ZuCVITV4v88O9M3F/EE4fCnQwFbidOlxckW9
        8mk+TWgK/VlXmHCyH3VZpvI=
X-Google-Smtp-Source: ACcGV60S8Vw5e4ECvkGZ8FVaxslL3f6iIKGdmDPGDrBB95buwWzp5a7rK5uPppl3fDLjWGtBrJMWQg==
X-Received: by 2002:aa7:c549:: with SMTP id s9-v6mr17808771edr.73.1538397838271;
        Mon, 01 Oct 2018 05:43:58 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h3-v6sm5278700ede.42.2018.10.01.05.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:43:57 -0700 (PDT)
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
Subject: [PATCH v4 3/8] mtd: maps: gpio-addr-flash: Use devm_* functions
Date:   Mon,  1 Oct 2018 14:43:46 +0200
Message-Id: <20181001124351.31615-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
References: <20181001124351.31615-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using devm functions we can make the code cleaner.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 6de16e81994c..84404dcc7824 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -213,7 +213,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	arr_size = sizeof(int) * gpios->end;
-	state = kzalloc(sizeof(*state) + arr_size, GFP_KERNEL);
+	state = devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
 
@@ -234,9 +234,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
 	state->map.size       = state->win_size * (1 << state->gpio_count);
-	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
-	if (!state->map.virt)
-		return -ENOMEM;
+	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
+	if (IS_ERR(state->map.virt))
+		return PTR_ERR(state->map.virt);
 
 	state->map.phys       = NO_XIP;
 	state->map.map_priv_1 = (unsigned long)state;
@@ -245,12 +245,10 @@ static int gpio_flash_probe(struct platform_device *pdev)
 
 	i = 0;
 	do {
-		if (gpio_request(state->gpio_addrs[i], DRIVER_NAME)) {
+		if (devm_gpio_request(&pdev->dev, state->gpio_addrs[i],
+				      DRIVER_NAME)) {
 			dev_err(&pdev->dev, "failed to request gpio %d\n",
 				state->gpio_addrs[i]);
-			while (i--)
-				gpio_free(state->gpio_addrs[i]);
-			kfree(state);
 			return -EBUSY;
 		}
 		gpio_direction_output(state->gpio_addrs[i], 0);
@@ -259,12 +257,8 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	dev_notice(&pdev->dev, "probing %d-bit flash bus\n",
 		   state->map.bankwidth * 8);
 	state->mtd = do_map_probe(memory->name, &state->map);
-	if (!state->mtd) {
-		for (i = 0; i < state->gpio_count; ++i)
-			gpio_free(state->gpio_addrs[i]);
-		kfree(state);
+	if (!state->mtd)
 		return -ENXIO;
-	}
 	state->mtd->dev.parent = &pdev->dev;
 
 	mtd_device_parse_register(state->mtd, part_probe_types, NULL,
@@ -276,13 +270,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
 static int gpio_flash_remove(struct platform_device *pdev)
 {
 	struct async_state *state = platform_get_drvdata(pdev);
-	size_t i = 0;
-	do {
-		gpio_free(state->gpio_addrs[i]);
-	} while (++i < state->gpio_count);
+
 	mtd_device_unregister(state->mtd);
 	map_destroy(state->mtd);
-	kfree(state);
 	return 0;
 }
 
-- 
2.19.0

