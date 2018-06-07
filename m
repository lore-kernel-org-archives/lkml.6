Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7PazCFyMGVu/bgAAmS7hNA
	; Thu, 07 Jun 2018 19:50:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C2CB96074D; Thu,  7 Jun 2018 19:50:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hFsWlild"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EEEDC601B4;
	Thu,  7 Jun 2018 19:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EEEDC601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932889AbeFGTuv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:50:51 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41728 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932448AbeFGTut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:50:49 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so11020931wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Oj/8xGcBb9F2VBvvxNIuM3OguCdqAj12BGhJ1uZrshc=;
        b=hFsWlildEbTJ8BYMx6OLzkmMZBJ9k0ZSvES1m1ae6TZ5TpYGMFnwgEYxZ2JtSb3/a/
         Y2uvAlHsQmm63+7bIvKlkxCaDFr6GBhxtDmXSJTGdZAMQ+A+AZ0UaRdXZllmoyDnpLLG
         OLeJxOwlbjTsU7AG1Hq4Mg2d6k0FpOEzEFeG3z6+9GrSxbpoJgugvGGiE8VuRgDdN8Ba
         p5opF41e8QYRs12NccVMaqFAp8nGfMqRxWPd3KlelOCBmuJKaKhZRVj1pAArzldAjEJ4
         Gfih1BJHVRFwZI0dQXHzUHUNH6IId9oCa2LsTkiJeJJt9aI6z2Hig6MvtBkskVuCcR99
         P3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Oj/8xGcBb9F2VBvvxNIuM3OguCdqAj12BGhJ1uZrshc=;
        b=NpxOYvTf1X2TT7A45cKwkIEI75e0o+yHk6FioXYbQOYbQ145IGpnZfznycE1oTCV3n
         XVk0PFKvGvhopTelTfgxmhQJ4Jz3tO3V4Nrrk0yB3qlciEbuheS36Kjn91/mep4FWr/8
         VvOe1IuSuwCFrZVrXtn53sNm+zAhd6Vm04Cr7TF9FL8GhMrnO2lMdlwgV/sX/XZuNZjF
         OuBMRVbYjlMQZYYHMT+hdEkUltGnCUPzHRcaGZVu/AxGTwPHs6K6/JuYtR7SLWrBSodH
         NQyoTiHBV59bmPAxajxGdQXulr8EYm7tF5AXQYYobyBfVhZ1RA3l81fy0gWHqRt+ujyj
         Tu/w==
X-Gm-Message-State: APt69E2wvdLr8cHWUr4Wz9e9bMf1uXu48ChX4zQq/A6KFOrKgNqLHYaN
        YXXXaUWIYp8l2GGmvAbSRpLqDA==
X-Google-Smtp-Source: ADUXVKIJL+Kwx2EbtqtL4xqkrLKkfo6t/WQFfri3S0ZGpjiCOqGTsocxSNmKoZdpU2fy8ZHkP93qJg==
X-Received: by 2002:adf:9025:: with SMTP id h34-v6mr2954713wrh.123.1528401048766;
        Thu, 07 Jun 2018 12:50:48 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id s9-v6sm1501627wmc.34.2018.06.07.12.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 12:50:48 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] bluetooth: remove unused bt-nokia-h4p.h header
Date: Thu,  7 Jun 2018 19:50:38 +0000
Message-Id: <1528401038-36287-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing in tree use this header which seems a remains of a staging
driver.
This patch remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/platform_data/bt-nokia-h4p.h | 38 ------------------------------
 1 file changed, 38 deletions(-)
 delete mode 100644 include/linux/platform_data/bt-nokia-h4p.h

diff --git a/include/linux/platform_data/bt-nokia-h4p.h b/include/linux/platform_data/bt-nokia-h4p.h
deleted file mode 100644
index 30d169dfadf3..000000000000
--- a/include/linux/platform_data/bt-nokia-h4p.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- * This file is part of Nokia H4P bluetooth driver
- *
- * Copyright (C) 2010 Nokia Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
- * 02110-1301 USA
- *
- */
-
-
-/**
- * struct hci_h4p_platform data - hci_h4p Platform data structure
- */
-struct hci_h4p_platform_data {
-	int chip_type;
-	int bt_sysclk;
-	unsigned int bt_wakeup_gpio;
-	unsigned int host_wakeup_gpio;
-	unsigned int reset_gpio;
-	int reset_gpio_shared;
-	unsigned int uart_irq;
-	phys_addr_t uart_base;
-	const char *uart_iclk;
-	const char *uart_fclk;
-	void (*set_pm_limits)(struct device *dev, bool set);
-};
-- 
2.16.4
