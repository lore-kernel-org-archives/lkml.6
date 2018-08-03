Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72036C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208B22175D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 13:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="LL9cim/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208B22175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeHCP0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 11:26:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45342 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729630AbeHCP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 11:26:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id s16-v6so2152387edq.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUvsjD9m1QX7o5WGCRuXIk0TAKa5VmkAaQ+JpCUQt64=;
        b=LL9cim/Q+heT2mDJlQC5BmWMW+LDPU3kypF4dOm4w+ZkhBKPjSPAXFIxt7e04YwKbK
         IJCcjuBxLVdXP/S2grcm0aHga9IPP1ujXKbnHTu87OHfHt2Dlek2Z/O7si09lWJjWkR6
         FSF1FZCyNDcw4d5e0ERISJFkF+LcjdLJc+lSyAkvzRM5fjNuasmuPy3IMdxkj+caVapD
         fQ4e7mx4t7WS7mbhyOdQycFr48BIM1yzrnhUy/HRIIQByPf5BA93SMQlbU2+FyvEIEUj
         kbPsJL8p9jc/e72RUNqArP+SVV3GcWuCGXxgLmbmZy5R/6PfUMwylxvJo+n3kvjMPquU
         bsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUvsjD9m1QX7o5WGCRuXIk0TAKa5VmkAaQ+JpCUQt64=;
        b=jwKvOOHB061oiWaOggk6BsPJjdavIpgePfegSkBEPYs1dJGTqfDUpkeeOpla1XuuRQ
         Eyjdicv9UAD8NOmNB9WrzTqTw4fV3S2FJrRgxYQw3TqI3nLaqjwInMiuOPRJGuC5omu8
         KrajBhe5nSg0wznuB1I4fwngF/7n9eq/kKd7lzn4w+KI0DUTM10V0BvG5vBZvROKshHZ
         8O/S9Rm6Nk7jH2mvFdA29tClLfPG5Mq7ZVxZ6RjahqMG0+9+Z1kX7HHoKw9C8ONhJ8OW
         mzDgNOr5//QnsE4qUoZM40ZgTkxmTAj+2tgJZZ4Q8ip4mRsij0DvOE44WcvS0ZhQg+Jm
         we5Q==
X-Gm-Message-State: AOUpUlGDGNcIvHAEQwX7J97nI1TEm+ElGost7D/aVv6Rr4bIeJkns4bJ
        XAxy3npPtVNtzJZObkBPRppzIA==
X-Google-Smtp-Source: AAOMgpc9douFSS0U/WyPeyLjVpFIPxpRuEjJK7MqvrlczwnexExKo2leOPZRFQEI6itddvBZo0rRVQ==
X-Received: by 2002:a50:9286:: with SMTP id k6-v6mr7560592eda.66.1533303029923;
        Fri, 03 Aug 2018 06:30:29 -0700 (PDT)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id b44-v6sm5998532edd.93.2018.08.03.06.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 03 Aug 2018 06:30:29 -0700 (PDT)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH V2] lightnvm: pblk: take write semaphore on metadata
Date:   Fri,  3 Aug 2018 15:30:11 +0200
Message-Id: <1533303011-2855-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

# Changes singe V1:
  - Fix double I/O on the read path (by Matias)
  - Improve commit message (by Jens)

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
 drivers/lightnvm/pblk-core.c | 18 ++++++++++++++++--
 drivers/lightnvm/pblk.h      |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 00984b486fea..6432faf5b19c 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -493,6 +493,20 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 	return nvm_submit_io_sync(dev, rqd);
 }
 
+int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	int ret;
+
+	if (rqd->opcode != NVM_OP_PWRITE)
+		return pblk_submit_io_sync(pblk, rqd);
+
+	pblk_down_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+	ret = pblk_submit_io_sync(pblk, rqd);
+	pblk_up_page(pblk, rqd->ppa_list, rqd->nr_ppas);
+
+	return ret;
+}
+
 static void pblk_bio_map_addr_endio(struct bio *bio)
 {
 	bio_put(bio);
@@ -737,7 +751,7 @@ static int pblk_line_submit_emeta_io(struct pblk *pblk, struct pblk_line *line,
 		}
 	}
 
-	ret = pblk_submit_io_sync(pblk, &rqd);
+	ret = pblk_submit_io_sync_sem(pblk, &rqd);
 	if (ret) {
 		pblk_err(pblk, "emeta I/O submission failed: %d\n", ret);
 		bio_put(bio);
@@ -842,7 +856,7 @@ static int pblk_line_submit_smeta_io(struct pblk *pblk, struct pblk_line *line,
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

