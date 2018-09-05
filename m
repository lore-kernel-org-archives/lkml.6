Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD7AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE062077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuXeTgbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE062077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeIETHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:07:25 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43273 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbeIETHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:07:25 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so6265015edb.10;
        Wed, 05 Sep 2018 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sHb8PVHX+/hDg5ZCeZ6xJ/I8i8T170ijaxwbnhZfkTg=;
        b=JuXeTgbjJo6uv2GfVYAHsMvgCDNogtO8QA1G6fmNvhCartNx28ngj6qR8xRnECVlO8
         2xtm7dWa9eMp3IoPuIwMufzLp6ju6pDjCl9ln+Ac0VR0fLmdDoG3sfPZMfjTwP2OeZ7N
         sGO/cV8tsRlVf9W5/JjcsGpKJ/22+Dh6gAIpsRZpzpSGx8tXQO139fLaWZlhBlEiNn7G
         BnTDMKqXksM4HpMm3lVdnC04oIBwfI7nM0j4YMetw35iGJdK7r25sFVcIai2iXJxDMTb
         ybHDNqjqtHdKilHU5pb7qafATmBuvEIVoOLB8g5kSCloDaIyG8SR26GjLntYfNPMQptk
         7pQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sHb8PVHX+/hDg5ZCeZ6xJ/I8i8T170ijaxwbnhZfkTg=;
        b=istE/h1TpvGH9OorfSqDzv49ui1IUaYD6jaCfGC5wmAGq6ottp9GuzEYZokbSydFcL
         iHpfoOp/F3YC+vyG0sUfylWFqgWQDCER08DjHPqdbefgFi4W+SziFb1H+Ki2T8O95duz
         k3Q/zJfwY7UKCzjBLdJ0tlAGnEk2Ld8ZnBoPWBT44lqTV52SbODnJdrEzag5blxyn/Uy
         FeBAX/Cohelst9Rwr+Ft0/VFQNyWuT4lb2SDySmYea14C4BE2AEsMHJgfZMqzPI26Cm8
         /eHbnQHsO/ncnQcfXhrh51HIX10uj0zQBzXcCxqfGmyz8nNEB22Q5lWrky02mYFfzTNk
         sWew==
X-Gm-Message-State: APzg51BmZfTkKorDLRqLRBlXJMrDAvthTkVhvkMcmYkobORQZanj29TO
        0Wb8xyyi14AYKrxinDKaLUA=
X-Google-Smtp-Source: ANB0Vdb0jPK6xA/DeNqF1CZ8qyRDZbbN+0vG6ttV+Up1tDzo1fD33a0EszaUYRHgXAvDpBgSosXlwA==
X-Received: by 2002:a50:924e:: with SMTP id j14-v6mr42157791eda.249.1536158215102;
        Wed, 05 Sep 2018 07:36:55 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id u53-v6sm1556413edm.51.2018.09.05.07.36.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:36:53 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list)
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/8] mtd: maps: gpio-addr-flash: Fix ioremapped size
Date:   Wed,  5 Sep 2018 16:36:37 +0200
Message-Id: <20180905143643.9871-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
References: <20180905143643.9871-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should only iomap the area of the chip that is memory mapped.
Otherwise we could be mapping devices beyond the memory space or that
belong to other devices.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Fixes: ebd71e3a4861 ("mtd: maps: gpio-addr-flash: fix warnings and make more portable")
Cc: <stable@vger.kernel.org>
---
Changelog v2:

From Boris Brezillon:
-Add Fixes and cc:stable

 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 17be47f72973..6de16e81994c 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -234,7 +234,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
 	state->map.size       = state->win_size * (1 << state->gpio_count);
-	state->map.virt       = ioremap_nocache(memory->start, state->map.size);
+	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
 	if (!state->map.virt)
 		return -ENOMEM;
 
-- 
2.18.0

