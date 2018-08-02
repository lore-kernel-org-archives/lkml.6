Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6908C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E59721501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 13:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="NpeohDFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E59721501
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbeHBPjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 11:39:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41087 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732255AbeHBPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 11:39:42 -0400
Received: by mail-ed1-f67.google.com with SMTP id s24-v6so970092edr.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2FCnVwbnlIPZbhmIKJdB+jYsOmhk3FItg9Cu9uXh+s=;
        b=NpeohDFGSzAEVx0QyxULInz3HUtNKH8HIRkDswlFpw7ddIoYQ8gSd/uoKJYHy8Q49O
         yLTs4yu/zrZtRfKWyIvbLMz71Dg68wlNcEY137IbZf/yXs8Hu6v5OXJLyapISnyuqU9C
         LE4H1caLDW/sAsY/YvFPFqFWT2Q2VepiO2bSewE06+piFMIbiFjFFluT1r/D4Mr5sVTz
         4xFuWMo8B1hQ5NYO4QfYOR3nehkD5bw4PLMDvQs/kWIeA7an0y4nfSfn7AOraAhGcTTA
         Jge5brLqKLUjeEcusf0IvqSc00gV0/tLRWCzOJ13jKAluW2EEs7PUlTcoVM0R/nNN+f5
         TYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f2FCnVwbnlIPZbhmIKJdB+jYsOmhk3FItg9Cu9uXh+s=;
        b=asKSH9WptJt4+NhAcgkINBoa7U4JtDzCg2HWPSIT47BzaZ8aqDEkg4CaZd5DsJvjIn
         y8RRSZXxSrFs9Oo8YMjqBVlM+987ecJkMOkva5b40g0AW+0piya3bbNK5gicQgObf4UM
         a/LQVCNKb32xYkagRAmVIOt6tHsFkBbYXR7S98Lkm/AgpdSIgNyFAn5bPTVzkLEn82Le
         yqgPlYvBG7Jnp8EfpEGmEuSNrT40qlPsm6JXVB2LLlEaMxyOB1lmbEi6C8RaZSDy1Mhc
         Q95lcE/oZV272lz52iQisWO62btPuxpiHKIhhP2NYL1FF413Sqq1atYXiP3uT75YxS6O
         ylmQ==
X-Gm-Message-State: AOUpUlF+rtLOSvaRsJT80fDvlx2GTHXV+jB4Sb6UUftpkd7bwuZJPq/a
        DT/cBwrCbi8dYvg8mlotdDuAmhOBJdU=
X-Google-Smtp-Source: AAOMgpcbrHa12nAMQc7QizUosGwq2GZKCBiqK8SlR8V2UFO+aR9cwEbvZV7oVpKTbZ/8Ho5PpUI9Rg==
X-Received: by 2002:a50:99db:: with SMTP id n27-v6mr3407331edb.111.1533217703926;
        Thu, 02 Aug 2018 06:48:23 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id u25-v6sm1080976edm.45.2018.08.02.06.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 06:48:23 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: take write semaphore on metadata
Date:   Thu,  2 Aug 2018 15:47:54 +0200
Message-Id: <1533217674-9514-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the write semaphore on metadata I/Os too.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
 drivers/lightnvm/pblk.h      |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 72acf2f6dbd6..73edb2d8104f 100644
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
@@ -735,7 +745,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 		}
 	}
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
@@ -837,7 +847,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
 	 * the write thread is the only one sending write and erase commands,
 	 * there is no need to take the LUN semaphore.
 	 */
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "smeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 48b3035df3c4..81401dd88951 100644
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

