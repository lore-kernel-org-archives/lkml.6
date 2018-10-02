Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A229CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA2B20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 10:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="LtqH2JCp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA2B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ingics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJBQwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:52:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41839 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbeJBQwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:52:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id q17-v6so883323plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 03:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uomRvr0igxgzTEohcGLyB7R8DkySqJ8fScScV3p/Xhw=;
        b=LtqH2JCprTegkEF8NgTDqmhWz5vqjEsFSr9m4yO4lPqJkiKASmtL42OcPGVOPC25wY
         7vMBkHFVmA3ep1YVBhAPeToOyohNnQesgdbu+7EG/xIvQhJqlVwS7Owe0zIVaXYoMPGK
         QMfMGHQOS1gO9qtloEAxMgE3L/F8wzBCyi1ttb/igZJtv+uqHtARE4B5Xp8ZJkqtDL6H
         ojVFTIR73WEBMNeDpaLdKz0rdwPMf3hOTzX269kH9qx3SWTqyMtHDacMFCjxcwYBFOHg
         hF0q5tOk5764WrWyFltpCIf+okU9QRQ+uC5v8fwo0/WlpGpLDHHC2WB4biyqAkGwQ33t
         vB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uomRvr0igxgzTEohcGLyB7R8DkySqJ8fScScV3p/Xhw=;
        b=NtaoxE050zsJ8NW5X6yDyc9D4aeZhMjOSd0vLc6K/UYVexdQjQLKbj5XkXdSzKvp/J
         WQxsGabGY9Pox/AwWXW9wTyYiTC0gf+MqGLdcMJv3KOaMdJBfpSdKs4qugkvTWE/04h7
         dyANLMK2ZDWuQi+QKeQnIq1BZlF8uzjWMjkZFG0RZTUeIt0RYpam1xAQxNRspYWd6VLL
         ELr5XTERAEKdYaADIe7OpG6CSLzC0sZIqLZ74RW7VbnV1/OYHPPH1IG4P0wlAUGlJiYh
         8nkLyjQ/k+R+dkhHCZbagr7lDyJmVD/UDE9S9pFBF0ZLre/s/nGVbq4CBjgXPuhV43Ph
         Wdeg==
X-Gm-Message-State: ABuFfoh2hQdx7hHBC94NXF+fL3up2TgvWquInr6J8byV5yNjnM9huUtv
        fuKJYSqGNwASqdaCLps6G7SWsT2Rb14=
X-Google-Smtp-Source: ACcGV61CqYQBeODtjVoEbLfz8FTFIl78f40sL/9UabWM3zMOYUaMuupJDRZvg2sL38L+vRYSuNocNQ==
X-Received: by 2002:a62:14ce:: with SMTP id 197-v6mr15605465pfu.50.1538475020427;
        Tue, 02 Oct 2018 03:10:20 -0700 (PDT)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id j15-v6sm19729489pfn.52.2018.10.02.03.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 03:10:19 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Lee Jones <lee.jones@linaro.org>, linux-spi@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] spi: at91-usart: Remove duplicated checking for spi->bits_per_word
Date:   Tue,  2 Oct 2018 18:10:10 +0800
Message-Id: <20181002101010.29723-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This checking is already done in __spi_validate_bits_per_word().

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/spi/spi-at91-usart.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a924657642fa..519853f14934 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -176,12 +176,6 @@ static int at91_usart_spi_setup(struct spi_device *spi)
 	struct at91_usart_spi *aus = spi_master_get_devdata(spi->controller);
 	u32 *ausd = spi->controller_state;
 	unsigned int mr = at91_usart_spi_readl(aus, MR);
-	u8 bits = spi->bits_per_word;
-
-	if (bits != 8) {
-		dev_dbg(&spi->dev, "Only 8 bits per word are supported\n");
-		return -EINVAL;
-	}
 
 	if (spi->mode & SPI_CPOL)
 		mr |= US_MR_CPOL;
@@ -210,7 +204,7 @@ static int at91_usart_spi_setup(struct spi_device *spi)
 
 	dev_dbg(&spi->dev,
 		"setup: bpw %u mode 0x%x -> mr %d %08x\n",
-		bits, spi->mode, spi->chip_select, mr);
+		spi->bits_per_word, spi->mode, spi->chip_select, mr);
 
 	return 0;
 }
-- 
2.17.1

