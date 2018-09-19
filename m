Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402ABECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C663520877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 05:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD7ToH+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C663520877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbeISKzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:55:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41248 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbeISKzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:55:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so2144836pgv.8;
        Tue, 18 Sep 2018 22:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wi6rTgjuR0PH9KgNLjn3w8neA5M4mIfVf5OwE5JHAd8=;
        b=jD7ToH+VDUyloVcqs+n0V8k1Br9p6kWrLmCi9uf65YmkTE61kROrymOL0d7ruju6y2
         QSDRsR2OjG7er+70hZ6D6otFyOhSI6tYcE8rcdTtBwvma2dNGJKgFRNGPh1Yw0dr/p+9
         ieZuq6RfI4yHwHIbp2/8MQCmNANRaSH3+1EgR6d2ZMT7hjZw9HAvff0WfH4x4vFuzK0v
         mVuYmM7hKf7wIykYuNy44bWVWj7lsHT5fk0RyTw0iEyUWJ1fvXasfry0MwZJJ3waJvfy
         4lMp3YqdExulmMgr5LdcRC8EwyZ99FF0u805uqsIFD/UOmDV+edx2o4Rcs+5RwSvo1Ac
         LE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=wi6rTgjuR0PH9KgNLjn3w8neA5M4mIfVf5OwE5JHAd8=;
        b=RvlqZHLITpP2hXaxPq3Ab5v8/1xJx5emz4YtTcrbbF1cTWev4bBT03A+Bwe2V7xLum
         921cz9lX8IU+SgwBmxZNYWq9MrYnGWscYh83GkB7H4C9+3a8JMk81x18IKvy30viucul
         4qer0je3QrxiIz6oItyo41PVTQG2eXvpZvrmY/fDWG4xvFQohQ64b8hZ+RbU9CLVPK7H
         gRLcwVwfr+hAzvyawm1rFUEMuilRNa0RuRw2dnMbnuGHV5uwYmXhrkLM/I0WRvtV3NX9
         v58POMkAFKsA7XD4Gu7cxq6TgVfEv0o3yulJLnoGnkC5lwm+Gt98ikMznYu1UdxSP0VI
         JTiw==
X-Gm-Message-State: APzg51DeO/EaLdoF4k0VWoi+F3MNWY6ShFQa0QU0RmRIoo1IMo3lPiEz
        XAMnnXVmAhJNLdo3FmxSb5cTC3ID
X-Google-Smtp-Source: ANB0VdauYef2MCH4i+NWgUwW29YpzoXmm5QezLc93Ah4PxELZO4jX91M9GURGdl7gupFMgt2j3TowQ==
X-Received: by 2002:a63:991a:: with SMTP id d26-v6mr30900864pge.159.1537334343949;
        Tue, 18 Sep 2018 22:19:03 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id n29-v6sm23425622pgl.30.2018.09.18.22.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 22:19:02 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] zram: fix missing zero pages for memory tracking
Date:   Wed, 19 Sep 2018 14:18:46 +0900
Message-Id: <20180919051846.234615-1-minchan@kernel.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to count zero filled pages as well as other pages in zram.
Otherwise, it doesn't match swap page count via pagemap of process
so that memory tracking feature in zram doesn't provide accurate
information.

Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: <stable@vger.kernel.org>    [4.18+]
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a1d6b5597c17..40d303d8826f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -71,7 +71,7 @@ static inline bool init_done(struct zram *zram)
 static inline bool zram_allocated(struct zram *zram, u32 index)
 {
 
-	return (zram->table[index].value >> (ZRAM_FLAG_SHIFT + 1)) ||
+	return zram->table[index].value >> ZRAM_FLAG_SHIFT ||
 					zram->table[index].handle;
 }
 
-- 
2.19.0.397.gdd90340f6a-goog

