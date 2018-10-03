Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71915C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3226721473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmuW2Nqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3226721473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJDC2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:28:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40049 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJDC2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:28:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id j62-v6so6435464edd.7;
        Wed, 03 Oct 2018 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PjA+sX8gLHXduyIAmFIqULLnywYjal55pxx0KrC3qkQ=;
        b=lmuW2Nqx4zU3tHrg3KDrrV6JiBwTzvLnnIUuMfjZuAetstjFjZ/pa4Zs+VF2kfjLk2
         MrB4bG/3/nnDDY2J/LZhV4Oz66MqjspeHCxI6Ty/e4mpSu8SaqsYt2kFzYJW+oaNx0Ml
         YuPCuWsrsfSkq7mw7RgUqXs4t1SjPjQZkU9EW0bTFf/eGpjwZZlXlTM1FIHnIGSBXRGs
         LNgJUc0OXLT/AQ9PFqCom8lmerQXKVu6z1oAWOUtiJ7IGfh88Sy1CuzJzbdt7LTlLJRK
         46htrVThir9Ue3lV2KFfScMnZ1eWlwKPPwpSHZXzlaW6DKsHCJywhdUI/D5baWJBpvRR
         vgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PjA+sX8gLHXduyIAmFIqULLnywYjal55pxx0KrC3qkQ=;
        b=DpupEO0mZ/dc5wZnRGo+mNBGewBNr/tVuM0P9A5Qalp1e38NLnUNNaaEBwSSqpQbMa
         YMaSB7AMTetfJza69HWS8FxmZ4FwimYNZS/KEX5RpnQsyYdbpQwQby6kTFyqwV/uf7gg
         qTmbnf8zig9+LW69jajES2X+u6fRhKOUKUecZuxB2zZhGNVmcvEf2OKHraqsfGJ34XgH
         uTCnlLUQYKStxrlZXZa84I48jseuknrSH5FkI9PdxLAwSB7hCc5QX8nNojPl6jRbzZUA
         iWZlaMBXv2BbX+uop8xkBpxtS/YVaDxvAFgNi5N+mm9DPsY6O7M+KH7HPX5/LO6Hl0h0
         9pog==
X-Gm-Message-State: ABuFfohiA/rcY677WczUF4uFZFplw7eJLAcQ1A2VdPnVWPMpNa8Bnk2H
        E3VkiJ8QXldW/EAerMisJvPJbVRQ
X-Google-Smtp-Source: ACcGV602M5OgJQcBMW0nF7AeLzSZA/hqlCIQTavWYFDGBQIa6g3prLN6Rs9XnR734e/NuBXiyl7Q8g==
X-Received: by 2002:a50:8d1b:: with SMTP id s27-v6mr4319626eds.107.1538595543543;
        Wed, 03 Oct 2018 12:39:03 -0700 (PDT)
Received: from piling.lan (80-71-134-83.u.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id b49-v6sm765263eda.70.2018.10.03.12.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 12:39:02 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 2/8] mtd: maps: gpio-addr-flash: Fix ioremapped size
Date:   Wed,  3 Oct 2018 21:38:53 +0200
Message-Id: <20181003193859.23928-2-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
References: <20181003193859.23928-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 drivers/mtd/maps/gpio-addr-flash.c | 2 +-
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
2.19.0

