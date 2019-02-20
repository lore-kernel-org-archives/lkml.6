Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC38C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B745E2183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlFf6Q6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfBTFSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:22 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51858 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfBTFSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:17 -0500
Received: by mail-it1-f195.google.com with SMTP id y184so12455870itc.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ciqk+uqFKrZqpMKGAg0DrYJPsR1EGm9FFygAIm8kVM=;
        b=XlFf6Q6kjzhVOBbxdhhjDTI+WyLMOP276wWY4epiLHVfTlMUpvT3tgzzK+8LgQ9nG3
         ld/pnfsNvHe47WqMhGVxWQdaJBUmPF3JW+/4WjXfQb127uQm2NSx3KLvt9U9FgNJADPk
         +HHSu0GWhCbehK6KE6O4tJOMwIB9VbSGU/qeTEVEkYQMRYGiO3JC8QMDBIA6tEFxN1e1
         lcfZ8qXpNbxEVcEiQEf/TcS3YS0lglTDTeyB/RtjF8lO7IlwyU5UNYYK+KzN36MTa+Ha
         BrGLtTNDXVEbtAG+7QfZXGFHzyzo4tC2f0zec3dDAptXlGKgHNIrgP3mGDuARRHGF7e4
         uSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ciqk+uqFKrZqpMKGAg0DrYJPsR1EGm9FFygAIm8kVM=;
        b=Mom4L2JRviIO9hQ8vo8wWho5yn8tDWGtqKz4rl9ED8OkiRyTxb1Yz9TOjtIaxc3/Yb
         pJsSH/eKgrGuQ7bmiaF+rpap9OsyKTKjgb74ZYBaOxff/5U0We01Z86BPrz0+tOhCeT2
         zGRg2evIC9J0WIVRwOXXRwKD2CYjG5j9rerhuhga5WrQSv8TRc1YTV6eA6XTN/enQfFy
         i2exUyo0G67X6CiuefpZtPyemLri+GK8OY1tXo1xSt20d4oNJmFF8nzyV2wkFCUqrDrm
         zo6pqm8CU/i/9sG2ROTxlW+dw+Em2qQuCvTZsn85g5lVgFrIrUOrYiTVU4F3tdGPGQ0E
         Labg==
X-Gm-Message-State: AHQUAuY8ouwM/hu++MCycmPbbjFxb5eGmHeP4O/RDvtBrGUhMY7zm/+l
        CMnnvp3nbtXZfnZr+oUxLj36LEfwnc0=
X-Google-Smtp-Source: AHgI3Ibxa5PLLnL2qg692p1i/0AAQI6Wi04myl5offbAPFS3GOsigAQZfjslDUScKwb9+Iot+nWiwA==
X-Received: by 2002:a02:4fc1:: with SMTP id r62mr17814026jad.55.1550639896070;
        Tue, 19 Feb 2019 21:18:16 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:15 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>,
        George Hilliard <thirtythreeforty@gmail.com>
Subject: [PATCH 09/10] staging: mt7621-mmc: Remove redundant host->mmc->f_max write
Date:   Tue, 19 Feb 2019 22:17:53 -0700
Message-Id: <20190220051754.12195-10-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190220051754.12195-1-thirtythreeforty@gmail.com>
References: <20190220051754.12195-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is set once during initialization and never changed.  Don't bother
setting it again in the interrupt handler.

Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/mt7621-mmc/sd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
index 736e1d23b391..472318a979cb 100644
--- a/drivers/staging/mt7621-mmc/sd.c
+++ b/drivers/staging/mt7621-mmc/sd.c
@@ -210,7 +210,6 @@ static void msdc_tasklet_card(struct work_struct *work)
 	host->card_inserted = inserted;
 
 	if (!host->suspend) {
-		host->mmc->f_max = HOST_MAX_MCLK;
 		mmc_detect_change(host->mmc, msecs_to_jiffies(20));
 	}
 
-- 
2.20.1

