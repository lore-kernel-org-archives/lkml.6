Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03B3C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70008208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 12:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="PEW0wq7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70008208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeKTXD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 18:03:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40147 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeKTXD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 18:03:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id q26so2035301wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 04:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uNJLkR6hn0GQxpQLiNymF31AMmlG+G6ZblnQq6cZGno=;
        b=PEW0wq7IEbV8USiOPcrCgfbxaxHqFNTihq/igvaxfqykNJn4lYjz4KeWERsErQSccU
         /dJdRerLHBZlZ0+XrtlCBRKARExHUoXXRNVk3tkOteaZYcK+K0sEwBZazJyUeMuZAG3q
         +X0odsFjWreXLJQnVgTcTmxOAo/xYTRO5kJOqU08rVk7WSiLTVqu3g8SYoG3AflVmjGG
         8jatTMFiw+s6UjqCgZdvbpdnzrZchWf6NaInpDTXH1l7cSM3C/ZqLuavkVE4xbxryXJb
         QRjbQNEf1nck1pH5Ktuymka38r045MJy9BR2I8dYABRQQN0qgRzDRUMzSKjMPObjiFAS
         vufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNJLkR6hn0GQxpQLiNymF31AMmlG+G6ZblnQq6cZGno=;
        b=JFTTzGwr64/XLa2BznWQYTy9Mnr1jdajPXkPUVo02S2qR2OfgXaUbs+Tpl/cBjhf6f
         bhTNTLVTfUKmlb4fHbIosKoTFJsy3BlW3KjirjO+xwkbpUVZvaQArB6ne2mE50Hbkomq
         pEcCfYccl08xhSIoeMtt140YDpAQ3WmaWs+W/4eM4jrYlUmI5rU/cWyFXMnok/oFVDXI
         APuT+8YSKAw9tcrAQTFrHtFVJEfkzBswjL4QjkSeBgqw0VuKUhMhR3dWo93elQ6U0FMV
         XsasNIx9AhzkTxX117Cxr7WRNzOnzJlUZo5XkwLIVhMBe4qaPGRnPIIM8bAg0wklElMy
         UpeA==
X-Gm-Message-State: AA+aEWZMXVyEqyLSAsgIWopjksbEzRe5/ax2E3LELIHfil4oI3tf10KS
        R9ZoxCwYivpaxptumm8dSy032A==
X-Google-Smtp-Source: AFSGD/VmEeJIN/hQjJgAuoDQfeI/jdlBV8AckUHemQQf/DDybGy4S71fjtCMo2ngpHG3QDxI01fxUQ==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr2159886wmj.30.1542717271520;
        Tue, 20 Nov 2018 04:34:31 -0800 (PST)
Received: from debian-brgl.home (lfbn-mar-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id v189-v6sm33482685wmd.40.2018.11.20.04.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 04:34:31 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable@vger.kernel.org
Subject: [PATCH 4/5] ARM: davinci: da830: set the GPIO base to 0
Date:   Tue, 20 Nov 2018 13:31:24 +0100
Message-Id: <20181120123125.24938-5-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/da830.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 0bc5bd2665df..822d2590fbc9 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -759,6 +759,8 @@ static struct davinci_id da830_ids[] = {
 };
 
 static struct davinci_gpio_platform_data da830_gpio_platform_data = {
+	.no_auto_base = true,
+	.base = 0,
 	.ngpio = 128,
 };
 
-- 
2.19.1

