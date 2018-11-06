Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D25EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3262081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 13:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="1RMUG+GY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE3262081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388398AbeKFW7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 17:59:02 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53877 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388110AbeKFW7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 17:59:02 -0500
Received: by mail-it1-f193.google.com with SMTP id r12-v6so15000195ita.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 05:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bvaul9mon6EWHTTGLVuoHFaIgp/GGBZICJDtZAMqK6o=;
        b=1RMUG+GY47T2+WiSu2dIgb6ngdkzaeA/HfvkJbVkSfPahHRScd2x/axKm2f3Okok/d
         aOOb0n/EEOgyDK/1KdMARXY9DpXPQ1r4szdc2goGX2b+1LiLY4kM7/yxSOt1K0CRPIJU
         EYJ4JoyCIgn/UQgbLgA0+OIk+YmXdmSfDG+oZsct5tx2rypW4I+V1elihH4180+r1xuy
         8SCcdijprc9bZANsBgJE6xzqkCAO2wI4I6ad0PCXuJq7os44TIS0DcJu8iG0fvgD2Vmc
         5kcQavSMQFSXlD5A3OxliVH+wkcpVxjqf4s8h/H6aEPKsAUcoh4N0HET4eacHnxN7LGH
         zxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bvaul9mon6EWHTTGLVuoHFaIgp/GGBZICJDtZAMqK6o=;
        b=MjhHHiMtk5HjPBQXwxDDOD/p8dbAfZK1z/K9JC/dC/8lFbm8ZzHV/scO5uBvtA7IAV
         UI4YxDQiNFJQjGGOkXiP0XU/9ckFkDTqRvSUcUQITDh2sa3OENVaiUPuX2I6CcAEQqWy
         H6w4T79MJpz5oSvxMO6gFIWg3CgP3PRq/TTseeI2J9XDYm08RRruiow3CAjkL4fmqeu9
         jVGWKGLR3vBEhwvrS9XNtvpWQ/UsrLZ6J7v6Q+a212YtTthB7NyixKsE+Q8pJYNuc9W0
         SNhA6I3iLjMWwnYhDJZ0ODBV0NyfePAlu/WD6KYkn9xoj+fP4oXVw9uldHK8kB2DNTZI
         PynA==
X-Gm-Message-State: AGRZ1gKRPJeocN3Y3leJB1MuzuvlNGRJ8sT9DKE9yRBipBtTnCrqapjt
        RDujKmDqkwW8mgk+UaE8dfcFRgCoaNLbrA==
X-Google-Smtp-Source: AJdET5d3caW/skE/Kpv2j0MshCP5RQR3nNsslFybhz022CL6EIYZi/1WQm9ZLEKCpBWkt7s55P9Xrg==
X-Received: by 2002:a02:4cd4:: with SMTP id q81-v6mr24442201jad.119.1541511225802;
        Tue, 06 Nov 2018 05:33:45 -0800 (PST)
Received: from ch-lap-hans.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id u132-v6sm897282itb.21.2018.11.06.05.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 05:33:45 -0800 (PST)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     Javier Gonzales <javier@cnexlabs.com>,
        Sebastien Boisvert <sboisvert@gydle.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH v3 4/7] lightnvm: pblk: set conservative threshold for user writes
Date:   Tue,  6 Nov 2018 14:33:27 +0100
Message-Id: <20181106133330.26570-5-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
References: <20181106133330.26570-1-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

In a worst-case scenario (random writes), OP% of sectors
in each line will be invalid, and we will then need
to move data out of 100/OP% lines to free a single line.

So, to prevent the possibility of running out of lines,
temporarily block user writes when there is less than
100/OP% free lines.

Also ensure that pblk creation does not produce instances
with insufficient over provisioning.

Insufficient over-provising is not a problem on real hardware,
but often an issue when running QEMU simulations (with few lines).
100 lines is enough to create a sane instance with the standard
(11%) over provisioning.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-init.c | 40 ++++++++++++++++++++++++++++--------
 drivers/lightnvm/pblk-rl.c   |  5 ++---
 drivers/lightnvm/pblk.h      | 12 ++++++++++-
 3 files changed, 44 insertions(+), 13 deletions(-)

diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 13822594647c..f083130d9920 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -635,7 +635,7 @@ static unsigned int calc_emeta_len(struct pblk *pblk)
 	return (lm->emeta_len[1] + lm->emeta_len[2] + lm->emeta_len[3]);
 }
 
-static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
+static int pblk_set_provision(struct pblk *pblk, int nr_free_chks)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
@@ -643,23 +643,41 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
 	struct nvm_geo *geo = &dev->geo;
 	sector_t provisioned;
 	int sec_meta, blk_meta;
+	int minimum;
 
 	if (geo->op == NVM_TARGET_DEFAULT_OP)
 		pblk->op = PBLK_DEFAULT_OP;
 	else
 		pblk->op = geo->op;
 
-	provisioned = nr_free_blks;
+	minimum = pblk_get_min_chks(pblk);
+	provisioned = nr_free_chks;
 	provisioned *= (100 - pblk->op);
 	sector_div(provisioned, 100);
 
-	pblk->op_blks = nr_free_blks - provisioned;
+	if ((nr_free_chks - provisioned) < minimum) {
+		if (geo->op != NVM_TARGET_DEFAULT_OP) {
+			pblk_err(pblk, "OP too small to create a sane instance\n");
+			return -EINTR;
+		}
+
+		/* If the user did not specify an OP value, and PBLK_DEFAULT_OP
+		 * is not enough, calculate and set sane value
+		 */
+
+		provisioned = nr_free_chks - minimum;
+		pblk->op =  (100 * minimum) / nr_free_chks;
+		pblk_info(pblk, "Default OP insufficient, adjusting OP to %d\n",
+				pblk->op);
+	}
+
+	pblk->op_blks = nr_free_chks - provisioned;
 
 	/* Internally pblk manages all free blocks, but all calculations based
 	 * on user capacity consider only provisioned blocks
 	 */
-	pblk->rl.total_blocks = nr_free_blks;
-	pblk->rl.nr_secs = nr_free_blks * geo->clba;
+	pblk->rl.total_blocks = nr_free_chks;
+	pblk->rl.nr_secs = nr_free_chks * geo->clba;
 
 	/* Consider sectors used for metadata */
 	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
@@ -667,8 +685,10 @@ static void pblk_set_provision(struct pblk *pblk, long nr_free_blks)
 
 	pblk->capacity = (provisioned - blk_meta) * geo->clba;
 
-	atomic_set(&pblk->rl.free_blocks, nr_free_blks);
-	atomic_set(&pblk->rl.free_user_blocks, nr_free_blks);
+	atomic_set(&pblk->rl.free_blocks, nr_free_chks);
+	atomic_set(&pblk->rl.free_user_blocks, nr_free_chks);
+
+	return 0;
 }
 
 static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
@@ -984,7 +1004,7 @@ static int pblk_lines_init(struct pblk *pblk)
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line *line;
 	void *chunk_meta;
-	long nr_free_chks = 0;
+	int nr_free_chks = 0;
 	int i, ret;
 
 	ret = pblk_line_meta_init(pblk);
@@ -1031,7 +1051,9 @@ static int pblk_lines_init(struct pblk *pblk)
 		goto fail_free_lines;
 	}
 
-	pblk_set_provision(pblk, nr_free_chks);
+	ret = pblk_set_provision(pblk, nr_free_chks);
+	if (ret)
+		goto fail_free_lines;
 
 	vfree(chunk_meta);
 	return 0;
diff --git a/drivers/lightnvm/pblk-rl.c b/drivers/lightnvm/pblk-rl.c
index db55a1c89997..76116d5f78e4 100644
--- a/drivers/lightnvm/pblk-rl.c
+++ b/drivers/lightnvm/pblk-rl.c
@@ -214,11 +214,10 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	struct nvm_geo *geo = &dev->geo;
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
 	struct pblk_line_meta *lm = &pblk->lm;
-	int min_blocks = lm->blk_per_line * PBLK_GC_RSV_LINE;
 	int sec_meta, blk_meta;
-
 	unsigned int rb_windows;
 
+
 	/* Consider sectors used for metadata */
 	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
 	blk_meta = DIV_ROUND_UP(sec_meta, geo->clba);
@@ -226,7 +225,7 @@ void pblk_rl_init(struct pblk_rl *rl, int budget)
 	rl->high = pblk->op_blks - blk_meta - lm->blk_per_line;
 	rl->high_pw = get_count_order(rl->high);
 
-	rl->rsv_blocks = min_blocks;
+	rl->rsv_blocks = pblk_get_min_chks(pblk);
 
 	/* This will always be a power-of-2 */
 	rb_windows = budget / NVM_MAX_VLBA;
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index f415aae600c8..e5b88a25d4d6 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -905,7 +905,6 @@ int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta *emeta);
 #define PBLK_GC_MAX_READERS 8	/* Max number of outstanding GC reader jobs */
 #define PBLK_GC_RQ_QD 128	/* Queue depth for inflight GC requests */
 #define PBLK_GC_L_QD 4		/* Queue depth for inflight GC lines */
-#define PBLK_GC_RSV_LINE 1	/* Reserved lines for GC */
 
 int pblk_gc_init(struct pblk *pblk);
 void pblk_gc_exit(struct pblk *pblk, bool graceful);
@@ -1370,4 +1369,15 @@ static inline char *pblk_disk_name(struct pblk *pblk)
 
 	return disk->disk_name;
 }
+
+static inline unsigned int pblk_get_min_chks(struct pblk *pblk)
+{
+	struct pblk_line_meta *lm = &pblk->lm;
+	/* In a worst-case scenario every line will have OP invalid sectors.
+	 * We will then need a minimum of 1/OP lines to free up a single line
+	 */
+
+	return DIV_ROUND_UP(100, pblk->op) * lm->blk_per_line;
+
+}
 #endif /* PBLK_H_ */
-- 
2.17.1

