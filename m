Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CBIzA9WMGVvNcAAAmS7hNA
	; Thu, 07 Jun 2018 19:52:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EC5846074D; Thu,  7 Jun 2018 19:52:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="T5BkJz7n"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5C30460452;
	Thu,  7 Jun 2018 19:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C30460452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753647AbeFGTwm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 15:52:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51862 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbeFGTwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 15:52:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so20072638wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=qqGf1Q8V3xtjN64HXiR2hMgfQfWhQ96iMGWrZZorIyc=;
        b=T5BkJz7nJoVuExwPOxtIciKzUpLaqiJqStktYoZIEbeo5UPuOloeX20YDav1qM8klj
         PrUU+mqv+bXTP2PQHdoU9ELnQductA8EWk5PQhP+xiGxjpwaEcxWebR4+t0pZwNdy5W0
         H+pM2nbEo27hH8I7rtt+wv0ka+QTmI6XdAE17o5Q2wO4E84+YEQWKrzIYckZwCb9cJ09
         nQ1jadiMipP6ASsHQobMmYY18HnAhnIngUKy/xDcMq0QLS+NJpT/Mqd2YH+scSXWog1c
         gmCJScS6FqWQyFDpC2B9NGlDSUA4xu2dpJFDKHx0m/89RvuVTgraPE5zKE8KQwFU1y1K
         nN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qqGf1Q8V3xtjN64HXiR2hMgfQfWhQ96iMGWrZZorIyc=;
        b=ofweowcZ67kCOOh79BYmm8+P5UYs89o6DI3+q1eCHGex9M5ZXoZA/lmpsAZe2XRLNl
         wIhhp1dbJY+aODjkAuY4syrO6l4U/jfrEUcn6SH6B6VKeAHYIL/KxlavCx/Flf+jKCWE
         K24pf0E8TmoBCSQ5IsA1AgcMbzhvrovM6W1bDXOVSSJKNaSfj1jP3f2ZC9u1Q0HqaKqk
         mNOM3bpHetlF31p2LXsRlU52Hbr0v3gsZTaxhJYfmU39xaWAbfmsO//HvYWkovoL/awj
         fzK67kCyGRnhZaJ0Z6ZA6Xs660b3rsEZ+ThETsglJymTN0KZK7DCymhvB40XWO7HZyA7
         2tGA==
X-Gm-Message-State: APt69E0bDjnlRe3FslG41CeNqQhknq+y20+yJWi9L40tTGcW0OlHniq/
        SQ84XPYF4S1+JweLeyyY+kK5AgiR
X-Google-Smtp-Source: ADUXVKLHwJOI85u52pmEhvbPjAlw2Cc9QUpbFINAyCNTrvnF/IV0+lnn7TW9Mwewl8I03M881QyX2Q==
X-Received: by 2002:a1c:8f8b:: with SMTP id r133-v6mr224078wmd.1.1528401160093;
        Thu, 07 Jun 2018 12:52:40 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z16-v6sm23870201wro.41.2018.06.07.12.52.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 12:52:39 -0700 (PDT)
From: Corentin Labbe <clabbe@baylibre.com>
To: shc_work@mail.ru
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] spi: clps711x: remove unused header
Date: Thu,  7 Jun 2018 19:52:34 +0000
Message-Id: <1528401154-37592-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/platform_data/spi-clps711x.h is unused since 6acaadc852f1
("spi: clps711x: Driver refactor")
Let's remove it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 include/linux/platform_data/spi-clps711x.h | 21 ---------------------
 1 file changed, 21 deletions(-)
 delete mode 100644 include/linux/platform_data/spi-clps711x.h

diff --git a/include/linux/platform_data/spi-clps711x.h b/include/linux/platform_data/spi-clps711x.h
deleted file mode 100644
index 301956e63143..000000000000
--- a/include/linux/platform_data/spi-clps711x.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- *  CLPS711X SPI bus driver definitions
- *
- *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#ifndef ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-#define ____LINUX_PLATFORM_DATA_SPI_CLPS711X_H
-
-/* Board specific platform_data */
-struct spi_clps711x_pdata {
-	int *chipselect;	/* Array of GPIO-numbers */
-	int num_chipselect;	/* Total count of GPIOs */
-};
-
-#endif
-- 
2.16.4
