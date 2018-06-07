Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fn1vEm+NGVuCdQAAmS7hNA
	; Thu, 07 Jun 2018 19:55:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DED7E6063F; Thu,  7 Jun 2018 19:55:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Qcs13/EP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0602D601B4;
	Thu,  7 Jun 2018 19:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0602D601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932544AbeFGTzg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:55:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50837 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932389AbeFGTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:55:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id e16-v6so20074228wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=5goB6PDN+siik0+2LVN3VPbM5I6Cv1+kh/WDwuZsPAo=;
        b=Qcs13/EPwn9/hohKBodcZO+jmnVc/JGXX2qRQFUucW5b9aQ4G2zs8b5tRGYDQUtg1M
         jEMUFSHhGWHLS0fXmDCrQvPy8EiqZS0+XeUzLL52+QiYPJExtTFqyq6cfZSUQxqUHyM3
         3HlJVh0L2yuM0owZAa3lKyANi+1SE3R5hdKcsakUdSpMqPQTysF62hbtknuM0TKxNKnt
         8mXm26iyMBXu2PdvvvTh+Ac5eKfvxBtbf3xTAAGiXSZnkxMuPt0lfVPWchTarDWEXx1Y
         Pxw1ucBC51SbMRKqiCv7tZTtqDzHdJl7RryxA20DO88ij7RzHbxhHOeOiDmWarkxyexK
         qBdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5goB6PDN+siik0+2LVN3VPbM5I6Cv1+kh/WDwuZsPAo=;
        b=hPSIyCYyQA99Whb+9qnnrrot39j1xjO7aZPDNqfWcSdPVpl5LF6xzsNdrR4e8MvAGc
         a7BbDKbPSthBURYpgXcUujGQcHMZsEYqWxRwuyIhzEimnUAIZNwuxJkhFEQ4dB+YMm5c
         mwh6HjR7RZw3SKa9QqxFze1T7N2WS87YFmwUjoLF1OJNx5qnb1hn+LJGHMYQi2LXcmkv
         ic5bbf9nzzGmIXYXOaHHhSaM2RczShELZ9DcAvY5Iqj3Y8UCRfM3phVcHeCrSu9AN10X
         Sp5/zvQjwhQmwYcu4AcsAv9yE+3vrul7By6C1YSXIln4SdEixtUNWKry+yC8Hj5GAjyX
         PqFQ==
X-Gm-Message-State: APt69E3DxFEMwo7N2qtc+b0/MHFgPSr5x4SrBHrmhnuaBSNnxS5Y4LuN
        nKrIegbg7Z5k2W4W233MVwfGoQ==
X-Google-Smtp-Source: ADUXVKKjn3YVc/Sopr5JWJ0AAG43V/Ltrpyz9Unsqrb8hpS/gqORJ+oqJeUR+XmDzr9q7rFsAQRbng==
X-Received: by 2002:a1c:43c5:: with SMTP id q188-v6mr2667075wma.69.1528401333531;
        Thu, 07 Jun 2018 12:55:33 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id x5-v6sm25086023wrr.3.2018.06.07.12.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 12:55:32 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: mchehab@kernel.org, t.stanislaws@samsung.com
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] media: sii9234: remove unused header
Date: Thu,  7 Jun 2018 19:55:25 +0000
Message-Id: <1528401325-39552-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The include/linux/platform_data/media/sii9234.h header file is unused,
let's remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/platform_data/media/sii9234.h | 24 ------------------------
 1 file changed, 24 deletions(-)
 delete mode 100644 include/linux/platform_data/media/sii9234.h

diff --git a/include/linux/platform_data/media/sii9234.h b/include/linux/platform_data/media/sii9234.h
deleted file mode 100644
index 6a4a809fe9a3..000000000000
--- a/include/linux/platform_data/media/sii9234.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/*
- * Driver header for SII9234 MHL converter chip.
- *
- * Copyright (c) 2011 Samsung Electronics, Co. Ltd
- * Contact: Tomasz Stanislawski <t.stanislaws@samsung.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef SII9234_H
-#define SII9234_H
-
-/**
- * @gpio_n_reset: GPIO driving nRESET pin
- */
-
-struct sii9234_platform_data {
-	int gpio_n_reset;
-};
-
-#endif /* SII9234_H */
-- 
2.16.4
