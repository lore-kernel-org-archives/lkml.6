Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F38C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 346A221523
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 19:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Z5Ocdvwl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 346A221523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbeITA51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 20:57:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39372 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeITA50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 20:57:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so6926793wrw.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7/gjPjuTClWP+Uoskbu3dhqxNR4jW40PA2lMB/45sqQ=;
        b=Z5OcdvwldJ8nkpCIGk3IbQWsVhdtTAhiNa4TrKniRKwEG5X0fmW99y3f8W3AcDncgx
         f2xiIneCqE10Kjqa1tB4FYmmIsNSKzE1HrB3rCx9jLOTtZsqQDWVz/bZdpsugtq746N5
         uG4redwJmLOvd5GZ0C3mm6yZKb57CUgyZ4a0QGXjGuZencPcL+YQ1XvUv2BhyGpA2BOT
         shqE7XaQcuu+Phjr770SQIx22YRdPJst7FoROptgG0/Z2n3VUkNpGF7vVeh7qsIYRT/O
         1xfV29SSxXhJT9zj2YdbTN5qcstH2D73uv8KbHt5vzwcewHkPnhPuy5SHZvzMjVWhltE
         PS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7/gjPjuTClWP+Uoskbu3dhqxNR4jW40PA2lMB/45sqQ=;
        b=AaSA8Z0JFOv+i7z/Zvm9BppMJwB6TJF9RucfkDEthF5vLM5AdcD5FceBnFJo5HtE21
         lZJov8rnPUtonbuPJuK+/yiik1zEUbAMr6JJH/jzpmlV2gk70aewPT6/L39Cto+UZwfv
         OJjsFABtAnZw1n/4xwFzc242aOcEsrdsjF0/qCRIz8rIiVEUYbWbdWFWI/ohhm297Tb0
         x/C2Ps59nnNOr99a2MZinOOH8QXrNVaESUn1iq1FQOQRTaQCg+o3PLvu7rFCHrk1dK+Z
         EdZjUEkMxrSaS5ABUnF7V2D1LkKGl5Bju1iUyNFbKGTvcglAFYV2oHANz2jUnDmE9nzE
         EKbA==
X-Gm-Message-State: APzg51B22mDl4UA8DT1Tf+6MD68eg6G+b0fljqAR8O4TIiImh+xVRqD1
        16CqOidJYG59B7xWTkFwyJzHRA==
X-Google-Smtp-Source: ANB0VdZmKrdQOsrWJGigXtgB7+AfUcO23DVWusnBCYoR3ZCNQQubNhk3q2XbwAhIl6OKY+VenH8S6g==
X-Received: by 2002:adf:9227:: with SMTP id 36-v6mr31172261wrj.275.1537384685305;
        Wed, 19 Sep 2018 12:18:05 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a37-v6sm47738999wrc.21.2018.09.19.12.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Sep 2018 12:18:04 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     shc_work@mail.ru
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RESEND] spi: clps711x: remove unused header
Date:   Wed, 19 Sep 2018 19:17:54 +0000
Message-Id: <1537384674-12280-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/platform_data/spi-clps711x.h is unused since commit 6acaadc852f1 ("spi: clps711x: Driver refactor")
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

