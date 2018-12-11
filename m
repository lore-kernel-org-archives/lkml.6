Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42477C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E242084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 00:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKQ5BkKh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E242084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeLKAl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:41:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37217 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbeLKAl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 19:41:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so12340760wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 16:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKq2htSNW/TcYrKCBtc+NHz3ZdYLc4gE7+TEtkC+ZXI=;
        b=mKQ5BkKhzSTs3VUSUrY9uPEaigPPxjvg7bA+zFRkHQR75lOMsOLQpHReo31n4HCN6u
         l819sqQ5frM5Dm0RdCzuqj/3e6wv6FfrGD/77a1bvg27zxo5n9ANyfHJU9KWE2rloejP
         Bq/zmsGUsmhYhlS0/TGcT26umDeJEbsR+vcVDZi+dIXDvPopSLVGpqXzPOLjjPkbwX5Y
         odqnZ0X/nxKURU7XjZq/NnWdwcIK9yRB7u5gfkGJw6GEehreRk05VGEAjPx63UeJWBKk
         Wo9Yc0B6LAS6grQnH/9jSpYFEGHiHiJno7WNH7TixxUMZbAeQCSY//acYmWy5xxeq9LX
         kb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZKq2htSNW/TcYrKCBtc+NHz3ZdYLc4gE7+TEtkC+ZXI=;
        b=cAcQ/v/nRiY6axQrmQyjx+6QfjaEF3abNqfTdIER3/kBLMoxcpSEAi/GziIEs39aHw
         HkGAr8UEP32y8tH/FuWcb/l4NbMRpo+ipRQ5h18TdCNT2Z380ygAJjyt4PGBG+wn/Xik
         07dl5BYrEBuGDQKvpPSAvvUaN2xiDeiua5nYaSDO0RBAkHs23S1IhC0xp40rXlcMAXRP
         vYiORrvisJTFoQu0djPwLuTTLvm4jr5htgSttill4UrqdDVIo0Fh4KNM5GGRzllJBDsG
         Hkk0LsLF4mlUu19VjgvDuHnm1pSRmcoucUosDV9ckt+PILF+AfJewBBuIgoi7iPYOTHK
         g/Uw==
X-Gm-Message-State: AA+aEWZqIPqYa2K0lcmBqukEWW8RAjZGyNjMntH8DyzBoJrnlakJBLvN
        3W2uExSIE5Yfz9pyDAAAmGY=
X-Google-Smtp-Source: AFSGD/XfB9wjbo3b5JotaoiMUEbwHmWXpSFXm/yfYQLz57D3YfU9Nsn+jArIks9JdzpFYPIOXHDD3A==
X-Received: by 2002:a5d:56d2:: with SMTP id m18mr12472045wrw.113.1544488883368;
        Mon, 10 Dec 2018 16:41:23 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id l20sm34624627wrb.93.2018.12.10.16.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:41:22 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] soc: ti: knav_dma: Use proper enum in pktdma_init_chan
Date:   Mon, 10 Dec 2018 17:41:14 -0700
Message-Id: <20181211004114.28029-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/soc/ti/knav_dma.c:601:20: warning: implicit conversion from
enumeration type 'enum dma_data_direction' to different enumeration type
'enum dma_transfer_direction' [-Wenum-conversion]
        chan->direction = DMA_NONE;
                        ~ ^~~~~~~~
1 warning generated.

While DMA_NONE and DMA_TRANS_NONE have different values, there is no
functional change because direction is never checked against DMA_NONE,
only against DMA_MEM_TO_DEV and DMA_DEV_TO_MEM.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/soc/ti/knav_dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index e05ab16d9a9e..6285cd8efb21 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -598,7 +598,7 @@ static int pktdma_init_chan(struct knav_dma_device *dma,
 
 	INIT_LIST_HEAD(&chan->list);
 	chan->dma	= dma;
-	chan->direction	= DMA_NONE;
+	chan->direction	= DMA_TRANS_NONE;
 	atomic_set(&chan->ref_count, 0);
 	spin_lock_init(&chan->lock);
 
-- 
2.20.0

