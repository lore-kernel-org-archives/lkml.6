Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68ADC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB10223E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="O3oVgWdD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB10223E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeHJLm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 07:42:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33181 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeHJLm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 07:42:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so7676727wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=sN96MkAkSAk5peqja7EI7GfPAZIenrIt+iqLM7JFBvM=;
        b=O3oVgWdDI7x5PEW2EgsgSyfH6jzgyZVkk+rc/TgUMZ6Xc7ldLDHzvFDuTlpb5dzcPq
         SMA0DEroSzKJUQ2uOah1/3LHczfQkuVTVKF3MWf2W5SBsM5a+o1bawi3wrfC/9pyAFNw
         LoJvE9bDYOUK5DpxZ/lQ2m780ITR6utO+3U9QTTzA8bvSSEDYy/2OHDrpwU7tyWtAyBX
         Zju8J0nUJEtkrj3cwid7u6V67VGkCUpVyzWeXCy94zkfQJSqMJPUKYPRNfZw5oB9j5BI
         KEPpCpIuBxrJKe/myrU9Hv7Gx30Mgej4FvAFTdYDZMXW46oVyTDyc7ewCJsmgDu+62yP
         wMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sN96MkAkSAk5peqja7EI7GfPAZIenrIt+iqLM7JFBvM=;
        b=jbZ8QcslmgmSjlNyOyQ9kkQMNlXH1l45YAAkQgyb7qgyehM9ztl0fTSzpLXSOOdv69
         IwBFcsQmDZ7umGHD4BgTUGw2FeyLZw+rgRz+mSBiNh7V58hffCizuUuEycaFT27VBUWV
         zUSt41Q99u97k1mg4reMXbN4Ar8XAuEh+1rLgdcg77HWJ+qf87bP9K4XeSFdSjuGIakH
         jjHAW9Z7+jjC8TRwI8jtKq5uIAPK9XY4PIQEvdq9PAXCwhbcXAibqVWzlwFkC58kP4gs
         UA2DXvppqUe6fUs78iJK7OKkfg866S8REOMP10c3Izyk/AjEz7AE4McYU5CwwBTbfLBk
         jR4A==
X-Gm-Message-State: AOUpUlGXSmxp9CZh333QvccIJJEqkXaJH/bnPHfF+NKqsCoACmTYnbAy
        2uTTxt4DBTkcvyKInaQj3fGmmA==
X-Google-Smtp-Source: AA+uWPwkWe8Jx5i41eMfshVn/6GkPnTjwjV8XxQZQB2XV/v4RrRSbUxB24yFBMR5kffCRrOKfp7XKA==
X-Received: by 2002:adf:97cf:: with SMTP id t15-v6mr3962897wrb.283.1533892437425;
        Fri, 10 Aug 2018 02:13:57 -0700 (PDT)
Received: from brgl-bgdev.lan (LFbn-MAR-1-609-89.w90-118.abo.wanadoo.fr. [90.118.185.89])
        by smtp.gmail.com with ESMTPSA id o6-v6sm800418wmc.15.2018.08.10.02.13.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:13:56 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] spi: davinci: fix a NULL pointer dereference
Date:   Fri, 10 Aug 2018 11:13:52 +0200
Message-Id: <20180810091352.30227-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

On non-OF systems spi->controlled_data may be NULL. This causes a NULL
pointer derefence on dm365-evm.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/spi/spi-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 577084bb911b..a02099c90c5c 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -217,7 +217,7 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
 	pdata = &dspi->pdata;
 
 	/* program delay transfers if tx_delay is non zero */
-	if (spicfg->wdelay)
+	if (spicfg && spicfg->wdelay)
 		spidat1 |= SPIDAT1_WDEL;
 
 	/*
-- 
2.18.0

