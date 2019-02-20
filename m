Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EB5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB0F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkB8vv3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfBTFSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:21 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55605 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbfBTFSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:18 -0500
Received: by mail-it1-f193.google.com with SMTP id z131so12413194itf.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5MGMTJN26WOckax2yCwvZuIyv8nIc7OLqZndI8AqWw=;
        b=QkB8vv3RRB59LJzg3CVBrU4NwlIraLoRq2cuXUtTXSbc+K9jJke0Sxm2sgkmfDjh+9
         /T1pc5hjLafClsdO9uw0D6u4DLV4TXnP9ZS9su3cIWpnn2megQOLal5d90/EeYpaKv9H
         H+hrzPQpnw3Uhfn4bD6AQGjwGctPnq6Y3bepc88NdTRB51Oz3wcFArri3e/0nHVhJwIt
         Vt8ZB/fOOCFRGYdQB2AC/U2yH9X5dcANhYgw1Bhy5JVpDnSi8uS/JqABWa0FObqRUvqc
         G1PdrYSUYdygoRKTuZfL+SF/GVAuK20cp0gdQJK4FeUQ6rMOPdI1IgY8+bqfOldO1kQz
         162w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5MGMTJN26WOckax2yCwvZuIyv8nIc7OLqZndI8AqWw=;
        b=dYMXElUI26GJENd1ThalmsHWVFZtvOld/VX9DcnqgAcq2HUmg5Reyl8u7gDSnCL6+e
         7CPz6LAssf8PxBrKcLq/fSwof+AK+KzUsffGwzAw3V8AZuX5cz7SMl4OENacACJz+kMV
         qYmvpLYhIDIZ2AP58KYda1WI9jqmQrhgZu7I+QW3uhCetz1luBwxjSiNgrhnqlNBIi/N
         8G6ph8j8IVDyASzeP7FGEir3OauDrsiJ28Ho9MTeeaPNvQL6OWuKpmioraS1ook7wvvO
         AXF9xzDKH/LcH5tD8pUdwe1Z7tmk9VnIDNrbseisPJIOiwBNlJfil7bhJuDQGm2twjji
         9pFQ==
X-Gm-Message-State: AHQUAua0V0zYl4I1G69vGav0KXFuD1LuSHBFk/nIpYaRdbJXD3b2xYnK
        uozF8RIyStxyNdcWPnBcu995q0Xdrrk=
X-Google-Smtp-Source: AHgI3Ia1UrxODbT/8+GzznHEtrX3+Brj7zsxsghnN/oq3KMXvsywP8rteefvEWLsLsEsiUAFzpxOrA==
X-Received: by 2002:a5d:824e:: with SMTP id n14mr18477619ioo.16.1550639897377;
        Tue, 19 Feb 2019 21:18:17 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:16 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 10/10] staging: mt7621-mmc: Immediately notify mmc layer of card change detection
Date:   Tue, 19 Feb 2019 22:17:54 -0700
Message-Id: <20190220051754.12195-11-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to delay notifying the mmc layer.  Schedule the delayed
work to run immediately.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 472318a979cb..0a7f8384edf8 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -1355,7 +1355,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
 	if (intsts & MSDC_INT_CDSC) {
 		if (host->mmc->caps & MMC_CAP_NEEDS_POLL)
 			return IRQ_HANDLED;
-		schedule_delayed_work(&host->card_delaywork, HZ);
+		schedule_delayed_work(&host->card_delaywork, 0);
 		/* tuning when plug card ? */
 	}
 
-- 
2.20.1

