Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760B8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 475B721773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8H/4g4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbfBTFSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:48 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39631 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfBTFSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:09 -0500
Received: by mail-it1-f194.google.com with SMTP id l15so12633925iti.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kCuF4Ez1jv/fQt/zAg0bCPVaYuCDdFgFupuOusf36kg=;
        b=s8H/4g4Dw4J3EcbeGBRWR7whI1xkayLV9v0W+Ll06oIT0AxkRUj2HDHYwBI1wBXrRy
         vY2JdVnrLNsik98RhV/eRHPNvLaKiQ7qK0rdP3GILkBIGtpo2Utt2xTwTR69KpB2GC7u
         6WzYbBo1Ko/bX2Lu+pLh0wR1iDVU6z8R7q0SqhHahr7b+fED1XTNgrH5wTPs9v+VERFS
         k9pZoQ1wK0tbR7ljw7oLMWauSYv0T1ZE2eudoyN0/wqmH1X5YYH85O7TWqT6bK81bWsm
         PZqSbRrzApc6sC5IG50091vZnxYM+vgE1VBRJpQKhKbMAnlq3J52oMl9VvXNpaXh4Jfg
         bXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kCuF4Ez1jv/fQt/zAg0bCPVaYuCDdFgFupuOusf36kg=;
        b=uHzzyq8ulZuhfOBscu77CaSjy/LKdzRbhKpRpzUfrnDO0ItDRYrX46/iKI2AC8Bga1
         wgo0jv3kWgzsnd88h3KJlomT1qsP4gTf3nntP3TWBpXBdLSAvAW0bIbv4tpI4sdENXbd
         sm5KKmXE8ev0CIb9g7oB3HQ3W3FcJT5JU7vvlwBVA+as0yuY+xKHmrZAvuxoN/R99FFG
         7kWeO9cZKqDRwh54mi19+cGGzgcV4xVeNWeRH2xO6zfaSsZYzxoM9C16Ysn88rRj6fal
         K/S0klZudbFXK0Iq+jC+GlnR/8tQwLSWPzoWuKAOFL8/c4y/v+VHYsafcFqmtBtelBUm
         S1DQ==
X-Gm-Message-State: AHQUAuagXUOPVHm6c37b2gN6Ei0DLvukNKs2aF4Uj5wQF8xLFCA/NiyI
        SRZI8YMhcBGbSIAiP/77fQE=
X-Google-Smtp-Source: AHgI3IY7TQTTXaQr7Fya3FdxEr+mnYbeU44Tc1DBYedHS3VuRG6exH9H5HvZbnUI4rdJYn2vN37IOA==
X-Received: by 2002:a6b:b790:: with SMTP id h138mr17398257iof.114.1550639888042;
        Tue, 19 Feb 2019 21:18:08 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:07 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 02/10] staging: mt7621-mmc: Remove obsolete comments
Date:   Tue, 19 Feb 2019 22:17:46 -0700
Message-Id: <20190220051754.12195-3-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These comments don't contain useful code or alternate implementation
ideas.  Remove them.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 4b26ec896a96..1d357b898952 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -100,7 +100,6 @@ static int cd_active_low = 1;
 struct msdc_hw msdc0_hw = {
 	.clk_src        = 0,
 	.flags          = MSDC_CD_PIN_EN | MSDC_REMOVABLE,
-//	.flags          = MSDC_WP_PIN_EN | MSDC_CD_PIN_EN | MSDC_REMOVABLE,
 };
 
 /* end of +++ */
@@ -1671,7 +1670,6 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	host->timeout_clks = DEFAULT_DTOC * 65536;
 
 	host->mrq = NULL;
-	//init_MUTEX(&host->sem); /* we don't need to support multiple threads access */
 
 	dma_coerce_mask_and_coherent(mmc_dev(mmc), DMA_BIT_MASK(32));
 
-- 
2.20.1

