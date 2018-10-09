Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E40C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2CC214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="S0x1skEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C2CC214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbeJISbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:31:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38689 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbeJISbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:31:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id b5-v6so674495plr.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J6AOKCcdZpaPo0z9TI+wgv9/xXbJhuIRYvEcLNzLWcQ=;
        b=S0x1skEkmPmRvQQ46ETuDp5tREJkyqNP1wceS99o8XPS8Y+Ndb+I8pFU4r5QstcKz3
         oXpaFzbz2DGIYb2MTm+EzhJ5g47MpoWuEMWii59ilnC0csGe2GpyRoIxM1cj0dD6n17s
         XgL//4hR8qvwLn/3bW08Jo8YuxhpVQaGY8OMFLor8flYUcVALA2ZPjLlzBLqJ9bLs0RM
         pUQ19rPSdL2anRSdjo6yxhZp87Bp82G/mMmW8Mz2JOQOns6KgaeQkVKs+PKSuP90Scxq
         5mwcsDgmrofep5S+sk4rZikIUkHe7t/u9BNrMx6hTkEsIqoSfHDg6rUd1jTLBmqf6Twa
         eZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6AOKCcdZpaPo0z9TI+wgv9/xXbJhuIRYvEcLNzLWcQ=;
        b=JXNlhNNm6a/D44IuAv+UAIXEpuzJqQ2icUeWwBhHokXQWzuDG6/ihF6LcUHTrJ6oCS
         tObXWXN9xDspKW2S+3/agx/WV1q1tEkFk6NwJbLJyIwlxFFXKKXYHBmV1+lEMuyFKyMQ
         ZBCh9V2nreRTf2bSHyM9XK5Ycf5IuG+xwzKiu7HPFph3EgLeKSZTzObAIqj+95s81tJ0
         OvRiNTaf8WlWm3yhckRr3zVLitV8JgDCy5MXmSWDPtKwfUD7pUGoYJH2n/hQxa22o7RJ
         FA1EcdsiDCzMXNeVbYg/v7av9uAW5pt1UomTSXYJbgCDcMCwwqXfjKb855xH6be7l1w4
         C+ig==
X-Gm-Message-State: ABuFfoi1qxNux4ihSb81vvHkncCwbZwDVbwOaLgNDKo7zzvrOaFzGJK6
        x6h4brZLqb4TnsW+nWIXCZGJVg==
X-Google-Smtp-Source: ACcGV63umZj/88hh5yFJ8sWkRKVHpVwcg65cD8yJJL+qTg5rlGBSNkOCp3u2uqUDRreXdR8u1Ws+9w==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2-v6mr28211735plt.133.1539083677680;
        Tue, 09 Oct 2018 04:14:37 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:36 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 25/45] lightnvm: pblk: add tracing for chunk resets
Date:   Tue,  9 Oct 2018 13:11:55 +0200
Message-Id: <20181009111215.7653-26-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Trace state of chunk resets.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  | 12 ++++++++++++
 drivers/lightnvm/pblk-trace.h | 31 +++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk.h       |  6 ++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index c482ef7dd4b5..84f3b4912b92 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -90,9 +90,15 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 	atomic_dec(&line->left_seblks);
 
 	if (rqd->error) {
+		trace_pblk_chunk_reset(pblk_disk_name(pblk),
+				&rqd->ppa_addr, PBLK_CHUNK_RESET_FAILED);
+
 		chunk->state = NVM_CHK_ST_OFFLINE;
 		pblk_mark_bb(pblk, line, rqd->ppa_addr);
 	} else {
+		trace_pblk_chunk_reset(pblk_disk_name(pblk),
+				&rqd->ppa_addr, PBLK_CHUNK_RESET_DONE);
+
 		chunk->state = NVM_CHK_ST_FREE;
 	}
 
@@ -923,6 +929,9 @@ static int pblk_blk_erase_sync(struct pblk *pblk, struct ppa_addr ppa)
 	struct nvm_rq rqd = {NULL};
 	int ret;
 
+	trace_pblk_chunk_reset(pblk_disk_name(pblk), &ppa,
+				PBLK_CHUNK_RESET_START);
+
 	pblk_setup_e_rq(pblk, &rqd, ppa);
 
 	/* The write thread schedules erases so that it minimizes disturbances
@@ -1736,6 +1745,9 @@ int pblk_blk_erase_async(struct pblk *pblk, struct ppa_addr ppa)
 	rqd->end_io = pblk_end_io_erase;
 	rqd->private = pblk;
 
+	trace_pblk_chunk_reset(pblk_disk_name(pblk),
+				&ppa, PBLK_CHUNK_RESET_START);
+
 	/* The write thread schedules erases so that it minimizes disturbances
 	 * with writes. Thus, there is no need to take the LUN semaphore.
 	 */
diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
index c171d0450c07..679e5c458ca6 100644
--- a/drivers/lightnvm/pblk-trace.h
+++ b/drivers/lightnvm/pblk-trace.h
@@ -31,6 +31,37 @@ struct ppa_addr;
 	{ PBLK_STATE_RECOVERING,	"RECOVERING",	},	\
 	{ PBLK_STATE_STOPPED,		"STOPPED"	})
 
+#define show_chunk_erase_state(state) __print_symbolic(state,	\
+	{ PBLK_CHUNK_RESET_START,	"START",	},	\
+	{ PBLK_CHUNK_RESET_DONE,	"OK",		},	\
+	{ PBLK_CHUNK_RESET_FAILED,	"FAILED"	})
+
+
+TRACE_EVENT(pblk_chunk_reset,
+
+	TP_PROTO(const char *name, struct ppa_addr *ppa, int state),
+
+	TP_ARGS(name, ppa, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(u64, ppa)
+		__field(int, state);
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->ppa = ppa->ppa;
+		__entry->state = state;
+	),
+
+	TP_printk("dev=%s grp=%llu pu=%llu chk=%llu state=%s", __get_str(name),
+			(u64)(((struct ppa_addr *)(&__entry->ppa))->m.grp),
+			(u64)(((struct ppa_addr *)(&__entry->ppa))->m.pu),
+			(u64)(((struct ppa_addr *)(&__entry->ppa))->m.chk),
+			show_chunk_erase_state((int)__entry->state))
+
+);
 
 TRACE_EVENT(pblk_chunk_state,
 
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index b2746099ca1d..7f4e46dfb0d7 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -79,6 +79,12 @@ enum {
 	PBLK_BLK_ST_CLOSED =	0x2,
 };
 
+enum {
+	PBLK_CHUNK_RESET_START,
+	PBLK_CHUNK_RESET_DONE,
+	PBLK_CHUNK_RESET_FAILED,
+};
+
 struct pblk_sec_meta {
 	u64 reserved;
 	__le64 lba;
-- 
2.17.1

