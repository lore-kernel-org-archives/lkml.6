Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F452C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403D721734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="CxGJDU0Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403D721734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbeHCOBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:01:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46968 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeHCOBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:01:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id o8-v6so2054566edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dm3JkuX9SluBkZwax0BjIf0dh38al7jqDNGLeHpaEU4=;
        b=CxGJDU0QsBzOy6T1rpvK66Ti9KltOGnf7y1PbQIU96Tr8M9N/b5MakPkC+kNnqQ08o
         tybCkcq0R2IhdYtOmcPSjvHR3P94xdwgXSiD6eq+r1brbVDzP7rVUvXXIeNgw2RR2yya
         hx4Oi26FCgMVdDJA7P8ZvddF7Xp2CQqubkUEW+Ed4am1INooT6zB0wYfMeB2Slmaca3O
         ihY023z/rmRWMgbsIHSzDfmc3NzteIwM2gg2GeiIP2ViqROxs5lrl9m8sv814Hw9fa0K
         cL15OhtYKQoJtusEwr24sfxUFMdzM+qTMyzhElpNjaud2lHEfcCwyyTik8f32GCn1BNc
         1rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dm3JkuX9SluBkZwax0BjIf0dh38al7jqDNGLeHpaEU4=;
        b=ZZo3MyoDqv5X8w5R5K3+ovEYyLI7ZuN87N9ujNcERbmBgmSITsG+pMrCM4HY2w7VNN
         q7uBSvOoDP0lZpfBYmAy5A9MBIvG3bC/LiNtNYufGSXr66NLqvNV2by7UCFaayaDROdU
         P1iRAKsDhArKRH0DQHPddI1Yc1anP2fXh5ddNkrOKysVI4mpPOZk9lJnjwUJM+npG8ke
         tMlkibA0Y+OtXcZ5Ye9HvuEHKUaOY4UFvWXMZQNhDOPBibR/zbGv3bGKgSlob6DaU6R1
         HJi1Aka+BODInPOHcunoZp+wpJm5Y4GqB8I1RSoBZMSn34xMW2HZrHiYBtQj4x4dkG2j
         y2iA==
X-Gm-Message-State: AOUpUlHhCJE5ZiTmJwJeD9jl+5CUO5xZmzrqYcCbh9yT4Wd1n6Ru38+2
        +S0ISHo4HAKMlM7J4aYYsC478w==
X-Google-Smtp-Source: AAOMgpeCYs8VVQaCmBfcLnb2i5cQjg7TX/AaoAI4oOweY1UkkoYckgNioQkMzZEp0Cr6GWCG1+6T5Q==
X-Received: by 2002:a50:8dcb:: with SMTP id s11-v6mr7089900edh.86.1533297940987;
        Fri, 03 Aug 2018 05:05:40 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id i15-v6sm3932831ede.66.2018.08.03.05.05.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Aug 2018 05:05:40 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: take write semaphore on metadata
Date:   Fri,  3 Aug 2018 14:05:19 +0200
Message-Id: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
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

Since metadata I/O is synchronous, the semaphore is not needed as
ordering is guaranteed. However, if the metadata scheme changes or
multiple streams are open, this guarantee might not be preserved.

This patch makes sure that all writes go through the semaphore, even for
synchronous I/O. This is consistent with pblk's write I/O model. It also
simplifies maintenance since changes in the metdatada scheme could cause
ordering issues.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
 drivers/lightnvm/pblk.h      |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 00984b486fea..160b54d26bfa 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 	return nvm_submit_io_sync(dev, rqd);
 }
 
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	if (rqd->opcode != NVM_OP_PWRITE)
+		pblk_submit_io_sync(pblk, rqd);
+
+	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	pblk_submit_io_sync(pblk, rqd);
+	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+}
+
 static void pblk_bio_map_addr_endio(struct bio *bio)
 {
 	bio_put(bio);
@@ -737,7 +747,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 		}
 	}
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
@@ -842,7 +852,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	 * the write thread is the only one sending write and erase commands,
 	 * there is no need to take the LUN semaphore.
 	 */
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 4760af7b6499..6ccc6ad8e1ce 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -782,6 +782,7 @@ void pblk_log_write_err(struct pblk *pblk, struct nvm_rq *rqd);
 void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
-- 
2.7.4

