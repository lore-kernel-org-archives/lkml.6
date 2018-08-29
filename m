Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1922C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A988C2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="qpck2XNX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A988C2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeH2MwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:52:24 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38148 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbeH2MwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:52:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id h33-v6so3351253edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCgTltU4L/jb9jPpj/o/ZnKv3o9cBTovLOPOmsj5eQE=;
        b=qpck2XNXHAw0aFGw3FaEfRyUih7ZAJnLYNL5X2W2ieAgSoCeb7jJigzuM3nIxqS7s0
         xHuOj2U8+Sy1gXKCvCQ+4ZrMp+imhQ/+dnwt0Or0u2X+8YtdmrpO+pi50EFncNDtMhsZ
         szHCzzhBIdCrdsdmirxkeb2zpNx+yPxRCTPcvSl9HKpS/6DT0pjDkBf50g3UuOihl94N
         TFcHVz6FZ/Nyrh5P7NkC1549lwWUlyXoCDYN4YFlvYoxJI3NPkoh0aOLrLjFv2YLrWih
         jyJlUYIpgje/4DrZRygdTMir2q7eKZ3F7ylEkJZVU2mO3EWOuVcFpHn+Jz6ktbr8DdWz
         Dd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCgTltU4L/jb9jPpj/o/ZnKv3o9cBTovLOPOmsj5eQE=;
        b=LRrKEMbSWQ3h0Sht1M+VkfaUrCwxAQMhjkzHZCazQw6Z2t5CEPfC0zT0252ejNojya
         2TeihVcJsD2T2s1dtje0eHc9VJJj5P+crYeU+OuVoOVdMxQZfgtkkfTSbGmu1+KCeQKC
         btbPFmpinlEFftzI7kLb2QBDLMkkKQ9C3nLeS9QeH/cdjl9y/s8A1WpbR2G31Q8iIcc3
         jo7ZmpHxNOE+PzTU9HLNdIUIafeRamVQaTuYYHp1V28fx0+PILBpQMFbGOzdepVL780S
         qkFCjjFlDlamzBtiJnHIj4Gf2xdZKFncDkk21nt98OH7cJQSlq64NTEvhgTfdGC8lm4V
         KtoA==
X-Gm-Message-State: APzg51B7AsClfU8fLQMFP9NEyWGCyKTv7+KeLR83r+RNHtoo3w8g6Sio
        ms/V/eG2Sqdbny+QupufrU5WkA==
X-Google-Smtp-Source: ANB0VdZ6wArf5DBoy1uHxB7vZ4d+JtueV0zFUUvottb7r47M67Z5lh+Y/EpOQzdRdzLGM+QNBbg3Zg==
X-Received: by 2002:a50:a7a2:: with SMTP id i31-v6mr6819392edc.296.1535532989917;
        Wed, 29 Aug 2018 01:56:29 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1867867eda.34.2018.08.29.01.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 01:56:29 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
Date:   Wed, 29 Aug 2018 10:56:20 +0200
Message-Id: <1535532980-27672-4-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
References: <1535532980-27672-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pblk guarantees write ordering at a chunk level through a per open chunk
semaphore. At this point, since we only have an open I/O stream for both
user and GC data, the semaphore is per parallel unit.

For the metadata I/O that is synchronous, the semaphore is not needed as
ordering is guaranteed. However, if the metadata scheme changes or
multiple streams are open, this guarantee might not be preserved.

This patch makes sure that all writes go through the semaphore, even for
synchronous I/O. This is consistent with pblk's write I/O model. It also
simplifies maintenance since changes in the metadata scheme could cause
ordering issues.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 16 +++++++++++++++-
 drivers/lightnvm/pblk.h      |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 767178185f19..1e4dc0c1ed88 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -558,6 +558,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 	return ret;
 }
 
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list;
+	int ret;
+
+	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+
+	pblk_down_page(pblk, ppa_list, rqd->nr_ppas);
+	ret = pblk_submit_io_sync(pblk, rqd);
+	pblk_up_page(pblk, ppa_list, rqd->nr_ppas);
+
+	return ret;
+}
+
 static void pblk_bio_map_addr_endio(struct bio *bio)
 {
 	bio_put(bio);
@@ -788,7 +802,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 		meta_list[i].lba = lba_list[paddr] = addr_empty;
 	}
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index c0d9eddd344b..54f937c1fb62 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -793,6 +793,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
 void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd);
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
-- 
2.7.4

