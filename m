Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69595C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A9B20834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRTffUe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A9B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeHaCkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34535 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeHaCkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so8571943ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OEG1WFkQCBmn2lvueq1gonbdYBMx8CbXlS/DaappwSQ=;
        b=kRTffUe218uvJ+YNdOhNiUo1g4ojBP9WWinq9PovUGBU4uuEDeLe7qnBFer51u3GRb
         yBZAe6AyGRdh5cPoIabpq7iMCMkRSx0r8Z+40PU0hnLoAxCK8RMKCNK6oN9kOGk65xPr
         v8hV6IUt2tVAS4SOT0c4RVC7x2drWLF7yHbLDruDNq6uU/chEcIypgcmVqkK/WS5JFV/
         Zrz3jcOdLBz+htZSkaNIiawcdirUHdlkNSv2iF/waeCMyKeb/RUQj9PN50x+YG5qTXLI
         vYhxKRpPMADNKloB2WIajcs0S+cjg6BRHUjMCDpNc9ZHoTbSGVos2K+oTmKSscdX4MdE
         JKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OEG1WFkQCBmn2lvueq1gonbdYBMx8CbXlS/DaappwSQ=;
        b=MXGw3iMtNhPbYr/m48tfQ3CdvtApSE2DrSdzkiD+X3Us5jq3IQTxwRxbeAIPoGl+mF
         stdaDIuHfxeKYMHOkrulbuiobFwJjxgnxF0EHGdLVxg0CslTY6YGsiQv3NWNmbPyVo16
         xoUdI+wVd3O9pW0/2nv8OKuufqzs7ZHQMxfI7Fgl3ooKoQboMoaJhWIiRsnZtoEZVk1n
         +W13+Pyal+h3oyMv1jctLWeE0sHwQWDMVhRyfp+VjPSkxLOTalydCblTWqBDoYe+oE7Z
         FcgyoZq27KoJb3NBAo2cmV2K1AimRFPnYNGxKVJctCSKkeTx8aLx5OCU2/OR/vTSFB24
         ZF2A==
X-Gm-Message-State: APzg51DJr9E1auYnmfneyDQfGjAs0lKA+MqfusaZF0tkgjwmKKIX6dGK
        2jB9yvw19RWQOm+g8qrAf2LqOgqa+no=
X-Google-Smtp-Source: ANB0VdZatyAzgna9RtGXyXArlUAsLizbqQdNociXiw5A0568v2deKgufWX4G6i2TuGqreN9sy5UvHA==
X-Received: by 2002:a2e:44c6:: with SMTP id b67-v6mr8405274ljf.102.1535668539500;
        Thu, 30 Aug 2018 15:35:39 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:38 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 12/23] wireless: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:18 +0300
Message-Id: <20180830223429.30051-13-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/broadcom/b43/dma.c       | 2 +-
 drivers/net/wireless/broadcom/b43legacy/dma.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index 6b0e1ec346cb..d113bd997f4b 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1432,7 +1432,7 @@ int b43_dma_tx(struct b43_wldev *dev, struct sk_buff *skb)
 		goto out;
 	}
 
-	if (unlikely(WARN_ON(free_slots(ring) < TX_SLOTS_PER_FRAME))) {
+	if (WARN_ON(free_slots(ring) < TX_SLOTS_PER_FRAME)) {
 		/* If we get here, we have a real error with the queue
 		 * full, but queues not stopped. */
 		b43err(dev->wl, "DMA queue overflow\n");
diff --git a/drivers/net/wireless/broadcom/b43legacy/dma.c b/drivers/net/wireless/broadcom/b43legacy/dma.c
index 2f0c64cef65f..1b1da7d83652 100644
--- a/drivers/net/wireless/broadcom/b43legacy/dma.c
+++ b/drivers/net/wireless/broadcom/b43legacy/dma.c
@@ -1149,7 +1149,7 @@ int b43legacy_dma_tx(struct b43legacy_wldev *dev,
 		return -ENOSPC;
 	}
 
-	if (unlikely(WARN_ON(free_slots(ring) < SLOTS_PER_PACKET))) {
+	if (WARN_ON(free_slots(ring) < SLOTS_PER_PACKET)) {
 		/* If we get here, we have a real error with the queue
 		 * full, but queues not stopped. */
 		b43legacyerr(dev->wl, "DMA queue overflow\n");
-- 
2.17.1

