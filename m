Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68023C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA3F20853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 12:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTdgY5jv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA3F20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbeJVU15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 16:27:57 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33722 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJVU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 16:27:57 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6-v6so2148408pln.0;
        Mon, 22 Oct 2018 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RCSYodw650g5KDTGikhMzg5U2Hs5MAyqNWdf8/qnF8=;
        b=dTdgY5jvOP4W53MqbwotkYeOV1yzDsQ/iRXqTrM0tBY+JjTWF4KTyHTu8g/mSG5Klp
         7lAK7jH3pwouFKIny7wd0s+6xOO4xvpIYQRrWq9KOrD+eDLKzhc3m71hXJ0s01eGCu8G
         KSQdgMfR8smij1bc198Kwc+qwBrB4KeWZCzEBshaAMXNEJ6algvl5IwxqfoiXa0io3Fe
         7HCM3eObIG0L6DbiJ+lff0F/jHhgObMNtTSvEcZoYE30mc/n+B/sT3rNzIeZYSX9RV0k
         3zK37aU+t520rwS3OiaoeriqBbqkxp9mIrr2bO/xNBbJil04WZEUlpyd8OHxL/4MNx6u
         Gstw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RCSYodw650g5KDTGikhMzg5U2Hs5MAyqNWdf8/qnF8=;
        b=NLkBStS3zgyYE864rq9tiJrKWe7yeLcirg0BM73RjrwsHcW7Nyxm6h8xn4LfWNrxMM
         SLtuZm6TvMpYFDhv16a+D2xB+5nMPFkMJnYatpi06JWpmJAArSKqGZ6jtDNBIZSFNldr
         wxw9hrsE2N/BFF4HroV3TB6P6onZZxkw/Fp7UYAvDfisFhpBtw0MqmRnEkaom0owz5Lz
         bDhk6hxcHOFcM8EXowpgTa77Y9Bbarf9xGyW4OZf41b37VlVwQWXDeoLuvl+IBN46ITA
         DWfotJgBQo3f4g2qOGSdCqWe0YG4KyoaULuZSqvOWLLOcmedhIiDnC2jEzUp826KleWD
         o+KA==
X-Gm-Message-State: ABuFfogZIPMM9fWDkfGFlu94gJXlckWjSXYl4t81UfD3wIy9O3GPA3o6
        chseo2W8i5yRUxAaWH4+7Dc=
X-Google-Smtp-Source: ACcGV60XKKZdHSvo5LPoK4/vTIc4eNWPCsXMqGQq9ioa1NPK71y1g9DnG41ksHFvkE6NHJsdlp4urQ==
X-Received: by 2002:a17:902:4e25:: with SMTP id f34-v6mr36420968ple.43.1540210179227;
        Mon, 22 Oct 2018 05:09:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:268:c0a5:1904:c698:f9ce:cdd:454c])
        by smtp.gmail.com with ESMTPSA id u69-v6sm61250728pfk.68.2018.10.22.05.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 05:09:38 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     linus.walleij@linaro.org
Cc:     linux@rasmusvillemoes.dk, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 4/6] gpio: ws16c48: Mask read inputs for get_multiple
Date:   Mon, 22 Oct 2018 21:09:49 +0900
Message-Id: <304924e41af041f873abb5c3fe4701d0a870219b.1540209293.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1540209293.git.vilhelm.gray@gmail.com>
References: <cover.1540209293.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch masks the read inputs with the word mask in order to ensure
only requested input states are returned in the bits array.

Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/gpio-ws16c48.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ws16c48.c b/drivers/gpio/gpio-ws16c48.c
index c7028eb0b8e1..5cf3697bfb15 100644
--- a/drivers/gpio/gpio-ws16c48.c
+++ b/drivers/gpio/gpio-ws16c48.c
@@ -169,7 +169,7 @@ static int ws16c48_gpio_get_multiple(struct gpio_chip *chip,
 		port_state = inb(ws16c48gpio->base + i);
 
 		/* store acquired bits at respective bits array offset */
-		bits[word_index] |= port_state << word_offset;
+		bits[word_index] |= (port_state << word_offset) & word_mask;
 	}
 
 	return 0;
-- 
2.19.1

