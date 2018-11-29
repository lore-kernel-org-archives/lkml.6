Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD15DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81EC2208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8o3xqIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81EC2208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeK3BOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:14:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42326 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbeK3BOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:14:18 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so2036445wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZ46lF1kZgeG7hRI9mhsyQ5A/snqFvHnufSxyNOckOk=;
        b=p8o3xqITjMNa8DeqduZf5WYbmWmWzIZiDe0OS6yXcm7jEJcswWjViIB7PzvJ5X1cw0
         O9o7B8X5rj8aJGUh7YL9KSPNYoN9ReQPxKVbjcRCS1yfPIc2zaGo9SI8LloTqbHijkKW
         /EaNMJtpWrJF1Ew0Hh+k7dve5a3RZLwjdkwwI1gJMBhdQl+fg2WnpsRiO2ZkTqeHH2Bp
         f1f0ZAEU0nMtpmAy/TVOUceqDaNZSi+ht6mnkMgTGUDo2jOhCyNNmzlRxL/Ffd/X6/WO
         K7jSaW+EyvzPHMjlg1yZvcSIQ+QZ3Oy8M9/4E8ozgzRjzkmqP/yRKD+TOjSRi9NXbrXB
         wX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sZ46lF1kZgeG7hRI9mhsyQ5A/snqFvHnufSxyNOckOk=;
        b=e1UM9emRn67Hxv44pkvmWCo6A7Nl5XLVvkrl/0RRrIVRljKHFTJS7ZiKy4gP/0j/Qn
         BlIxV9Pa1EZWVcqMCnGyRizZY6z7Yu+5LL5MQYYMcckMRAjF3effEuW2Ktv7aNPnRMpT
         RAUoYSLjxq/T8Q2V3m7AVPUQ9qpcpDknIO7qDX5T+hWQyIzKe67YqcBL9CDPTMNWkg76
         ll3LWduL2LoK8hz6M/6popdT3zN646d6EEDRJPXL4t6UlyDD6D+bXz/GGjpNYOQXMs7t
         JU+5JjEuXZOl/JCBRMoG2uURUVtHEdyTWjPTIBPiUyv1SnPzE3evL20muDErmUrxyD7U
         Odqw==
X-Gm-Message-State: AA+aEWYwcyyBbFZLsQgNhMpxH6NLucUIQ4HT6bWQ76wvjDyAD2tpL/wb
        zVT2inNHUmmBb6RCyjNTzgE=
X-Google-Smtp-Source: AFSGD/WJxfCCVTbdYnP/m3w/nsLyOAoIWBbi/UplMgNJHMC7BhWVoByY5bqSDBCn3xe1r1iBAT72Cg==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr1457196wre.94.1543500527965;
        Thu, 29 Nov 2018 06:08:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id l3sm3070217wru.36.2018.11.29.06.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:08:47 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     ajay.kathat@microchip.com, adham.abozaeid@microchip.com,
        joe@perches.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2] staging: wilc1000: correct inconsistent indenting
Date:   Thu, 29 Nov 2018 15:08:38 +0100
Message-Id: <20181129140838.29621-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct inconsistent indenting reported by smatch.
Instead of simply remove indentation, refactor the
loop to also improve readabilitiy.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v1 -> v2
Refactor loop instead of simply remove indentation
as suggested by Joe Perches.

 drivers/staging/wilc1000/wilc_spi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_spi.c b/drivers/staging/wilc1000/wilc_spi.c
index 35ff432587fe..153e120eff00 100644
--- a/drivers/staging/wilc1000/wilc_spi.c
+++ b/drivers/staging/wilc1000/wilc_spi.c
@@ -927,7 +927,8 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
 	int ret;
 	u32 tmp;
 	u32 byte_cnt;
-	int happened, j;
+	bool unexpected_irq;
+	int j;
 	u32 unknown_mask;
 	u32 irq_flags;
 	int k = IRG_FLAGS_OFFSET + 5;
@@ -947,8 +948,6 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
 
 	j = 0;
 	do {
-		happened = 0;
-
 		wilc_spi_read_reg(wilc, 0x1a90, &irq_flags);
 		tmp |= ((irq_flags >> 27) << IRG_FLAGS_OFFSET);
 
@@ -959,15 +958,15 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
 
 		unknown_mask = ~((1ul << spi_priv->nint) - 1);
 
-		if ((tmp >> IRG_FLAGS_OFFSET) & unknown_mask) {
+		unexpected_irq = (tmp >> IRG_FLAGS_OFFSET) & unknown_mask;
+		if (unexpected_irq) {
 			dev_err(&spi->dev,
 				"Unexpected interrupt(2):j=%d,tmp=%x,mask=%x\n",
 				j, tmp, unknown_mask);
-				happened = 1;
 		}
 
 		j++;
-	} while (happened);
+	} while (unexpected_irq);
 
 	*int_status = tmp;
 
-- 
2.19.2

