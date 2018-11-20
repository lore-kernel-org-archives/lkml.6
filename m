Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB7AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 267D42087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="FNR8YGsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267D42087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbeKTXDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:03:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35226 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeKTXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:03:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so2057315wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3kyk+wNbDD2b90ve4QeMI1tgKD9o0nY4RuZPk1Thmfg=;
        b=FNR8YGsJL5cW1CDtRA9IJhEr95YZsvpxDI6DvLrR6PlGa7qqZHJ/tU9KDwiUVe5Scu
         rRck7Fk9KdeUnsqZH4bdamcQybfXBbKUg0alGkfBZGMUntQW80lCD0DjsK/IeAqKT0Ag
         1Uf3RTl/GFxJ31EVfm+7Cl5AaiL01SJfE5vfSqraO4dGMJErkiP4IZW7B6x2X5PLrIsU
         jblVAz9ppvd8561+6twCZqXM/wBn0+lKa8LsFMND3r1luYKZ9jkLTKCvFWFKbDCM5KPe
         EDGNYPQ/rEyq7WKqrk1pQxyt/iY41JnG60rTDVOmZ4zhEtaV/f+SETjse4UbnYmIwShr
         IOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3kyk+wNbDD2b90ve4QeMI1tgKD9o0nY4RuZPk1Thmfg=;
        b=IbrO3UsnqOkrvDnrdfESenKAbkYQXJ4p5Ak36snvUqlw4HUQ9h7ZB08SNrfxPYwYp8
         4wVkxP1S2g6zHT4AIYskdKI6FWv2fNlVMZhedYI6RbNuEdaYT7TODFfrShuQ3744KYVb
         veKKif89JsSCppTSEwW0XSz7PSyLgQpRh4HbwLyvJ3Vv4PW13l2sNEiGFbL1fnlxncxw
         AXA7zItYW07of9aAe5If8V0aobOc7Yn0Y3p1L3CgHoHyNcVZcBAXEYAfW/ocEwS/mCHa
         I36tmSVJ9xzRb6YYZHmz+p6mKmyMepjZ0x40OWo2Gvrx7fWzBICRPqTNEteGXMmJsv8m
         SD/g==
X-Gm-Message-State: AGRZ1gKfONBvJ0UTtfY7AJYg7YDdm3MQPV5iyetdjtw4mRZUhD0pad3G
        PcL+12unkfSDX3KgM/IrczRrJw==
X-Google-Smtp-Source: AJdET5e4j5cHMMq8Ui/uovhz7+mRM5riqnCRs+bUtVjxVD8GXsJfQ8XzFPtzwNlJ1hOQME4EGP/CkA==
X-Received: by 2002:a7b:c003:: with SMTP id c3-v6mr1852575wmb.133.1542717272985;
        Tue, 20 Nov 2018 04:34:32 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id v189-v6sm33482685wmd.40.2018.11.20.04.34.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:34:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 5/5] ARM: davinci: dm644x: set the GPIO base to 0
Date:   Tue, 20 Nov 2018 13:31:25 +0100
Message-Id: <20181120123125.24938-6-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120123125.24938-1-brgl@bgdev.pl>
References: <20181120123125.24938-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Commit 587f7a694f01 ("gpio: davinci: Use dev name for label and
automatic base selection") broke the GPIO support on DaVinci boards
in legacy mode by allowing gpiolib to set the GPIO base automatically.

DaVinci board files use the legacy GPIO API with hard-coded GPIO line
numbers. Use the new fields in struct davinci_gpio_platform_data to
manually set the GPIO base to 0.

Fixes: 587f7a694f01 ("gpio: davinci: Use dev name for label and automatic base selection")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm644x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 0720da7809a6..f25b508a831b 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -498,6 +498,8 @@ static struct resource dm644_gpio_resources[] = {
 };
 
 static struct davinci_gpio_platform_data dm644_gpio_platform_data = {
+	.no_auto_base	= true,
+	.base		= 0,
 	.ngpio		= 71,
 };
 
-- 
2.19.1

