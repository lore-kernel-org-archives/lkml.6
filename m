Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876B6ECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427E52086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="SEDjcGl4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427E52086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIKQYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:24:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36609 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeIKQYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:24:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id f4-v6so18949890edq.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1XiKBCncoaG9o/bqWNARY7OJM1qM1pkxEa1pvIXz2Q=;
        b=SEDjcGl4h+jCh70/Q19SKp+H02dtaYtggGl3yClgGUDu/KVebfwMgg43fQqxOO91jt
         2ZkFYA7eQKqgwa1h7YfGHZQnAGZGaIdEjvLUurbiQODz6SGH13r1A7IcDIqWu7LkJVYb
         kdCcmx1+yjueHjrt+NjrWvL3MPYhoz8S1DBe/grkFSBNGv05jblJu/OO2CeRi9nzWV22
         XpWbbx4B5RcYg+J+KxJpwTLYZ/s2d6N/tumVzcya99qQ2Zr391vFJZBPG82kGYPXPHFG
         lDMTkf/drowPz9YY2CHuqv0DpTSzPov6NiwtsWdB7ax6/B9+yjzuqpqDSMxkj4FJYgKN
         4E9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1XiKBCncoaG9o/bqWNARY7OJM1qM1pkxEa1pvIXz2Q=;
        b=bMe26Oky58X+9LS9bTSmwU+CNvom/jxOql7INVmuAaxvxS5Bn6HPy/UJLYjx6uRz6A
         Hl1StXQ3bFc2I2eb9YXhCuHJqYqAD36lNJqle/8fyFlRafVUdanVx7y1mW7HIr2WaoYy
         XN2CF3RB++10vhNwqGWfaFtQmmfs+16F6SSvT99VlUyspv7xptDRrwixce/r8uqpcm+Z
         7S7g9tUbTOo2ubEcZZYGkv2B9MG3nwKysz4Z0zD3sRndw3fMX7VLQlzPRwxUjYKUW1ol
         cwyYVcUztUi481C8A2MK5u4EulmE8iM7dNBwqSJ5bi8d1UM+eKGqplwGxOT2RwIWjWJk
         B6Dw==
X-Gm-Message-State: APzg51ALdACMXOmfjHd0XpWwdDTT0STBzjkP+fw7suGt3JtDfbXdMC31
        tlLCyX/PLdHdwj/Cg8hsVNKqdA==
X-Google-Smtp-Source: ANB0VdaGwY23Du1JTJcC8WG0C6SPVaLs3sBps6+5mjc9vqPZQ2o7jsQUCKxNNRuyPK7am4EzF9osaw==
X-Received: by 2002:a50:b306:: with SMTP id q6-v6mr27571977edd.264.1536665112157;
        Tue, 11 Sep 2018 04:25:12 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id e38-v6sm10941351eda.74.2018.09.11.04.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 04:25:11 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 3/3] lightnvm: pblk: take write semaphore on metadata
Date:   Tue, 11 Sep 2018 13:24:51 +0200
Message-Id: <1536665091-12641-4-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
References: <1536665091-12641-1-git-send-email-javier@cnexlabs.com>
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
index 49cef93e328e..a3ce4a36dd33 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -557,6 +557,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 	return ret;
 }
 
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list;
+	int ret;
+
+	ppa_list = (rqd->nr_ppas > 1) ? rqd->ppa_list : &rqd->ppa_addr;
+
+	pblk_down_chunk(pblk, ppa_list[0]);
+	ret = pblk_submit_io_sync(pblk, rqd);
+	pblk_up_chunk(pblk, ppa_list[0]);
+
+	return ret;
+}
+
 static void pblk_bio_map_addr_endio(struct bio *bio)
 {
 	bio_put(bio);
@@ -787,7 +801,7 @@ static int pblk_line_smeta_write(struct pblk *pblk, struct pblk_line *line,
 		meta_list[i].lba = lba_list[paddr] = addr_empty;
 	}
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 02e2c02b0cf4..4c015c457197 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -792,6 +792,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
 void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd);
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
-- 
2.7.4

