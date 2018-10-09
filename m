Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6405C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E34A214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="R4bLiJRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E34A214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJISaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:55 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33775 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeJISaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id s4-v6so680261plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WPvYV537OFUQX56qrdJfuB1fQiS6OELsp90PEAQ9z6s=;
        b=R4bLiJRy8QAWFJ9SRqHxXYS4W89+fk/NO0cq2J1VMuZjiMm2MzZavm/iBwmE8Ympqe
         nNWUgS8bY4PvU3zI4cVtvE3RzFHSqEBstoKgKR6RZCPL6g+f7FK34YmRgQbXgC7doqgG
         CRCxaqizug/xIdXiLgs2uX3a6KqI5aL3ajUzsn+uAzacZV3vlVaK6RCN94LS1spgxdJq
         ITrjX/NbZGJQExypusbvWbHKcTRXjjd+PdixaexbN1VJ1vqFcDTWPGd+jcl3BlrslBOa
         QQnLMkhTV5za/NRQNPo894/XGSEk9Jk0T7UuLbxy71R6S9bPMPYTmHGaip8Zx+TbGxtm
         CClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WPvYV537OFUQX56qrdJfuB1fQiS6OELsp90PEAQ9z6s=;
        b=gTnG+jNcfBRm7P2X3Ynel1OJih5CEwX5+/Yw8U36t40BZ6R2P4+Piblh7ESApQNmji
         YY76qkjtrC8J05yeWGD72ILzDI3TRkhUUOMX4JSGRvkG5QuJsgRS+z5ledLZ5hUpRrpS
         6Q0sYPcQv2JGeRkWinaP/IpYfIQOQ+hrw6Pwx0mI9c+192qhzoDKYdmLxoN0NK5+8Awy
         xVSQEUI8LF2fxXXec/64LBod2vDVOu0IwUCGKQTEd3DcqVwNWLNdDShSzKQrIb3tiBbk
         qV4icvagBrqKsm5kuxBiaXookfJ4CielZMxlzBol0yOrHD6nUmahkqdYhOMWZvI9AIay
         TPKQ==
X-Gm-Message-State: ABuFfogVolI72bPaMH30h0aadqBNBAqzLX3ibdIhlvkLWpSIN3O9dKSc
        yVzQcbHioui0wfdh2rAHhGYK4N5IKTCT3A==
X-Google-Smtp-Source: ACcGV63x8YxxwSMm3DtyS3a50T+ob0KB8Cr4hTCMUU+K6DbYxOqN/S/x6FG6d8DTQ+0VysalWdX4mg==
X-Received: by 2002:a17:902:104:: with SMTP id 4-v6mr1549962plb.189.1539083667996;
        Tue, 09 Oct 2018 04:14:27 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.14.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:14:26 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 22/45] lightnvm: pblk: add trace events for chunk states
Date:   Tue,  9 Oct 2018 13:11:52 +0200
Message-Id: <20181009111215.7653-23-mb@lightnvm.io>
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

Introduce trace points for tracking chunk states in pblk - this is
useful for inspection of the entire state of the drive, and real handy
for both fw and pblk debugging.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-core.c  | 35 ++++++++++++++++++++++-
 drivers/lightnvm/pblk-init.c  |  4 +++
 drivers/lightnvm/pblk-trace.h | 53 +++++++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk-write.c | 10 +++++--
 drivers/lightnvm/pblk.h       |  8 ++++++
 5 files changed, 107 insertions(+), 3 deletions(-)
 create mode 100644 drivers/lightnvm/pblk-trace.h

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 968597d10cc2..8a5158607467 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -16,7 +16,10 @@
  *
  */
 
+#define CREATE_TRACE_POINTS
+
 #include "pblk.h"
+#include "pblk-trace.h"
 
 static void pblk_line_mark_bb(struct work_struct *work)
 {
@@ -93,6 +96,9 @@ static void __pblk_end_io_erase(struct pblk *pblk, struct nvm_rq *rqd)
 		chunk->state = NVM_CHK_ST_FREE;
 	}
 
+	trace_pblk_chunk_state(pblk_disk_name(pblk), &rqd->ppa_addr,
+				chunk->state);
+
 	atomic_dec(&pblk->inflight_io);
 }
 
@@ -477,9 +483,30 @@ int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd)
 	return nvm_submit_io(dev, rqd);
 }
 
+void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd)
+{
+	struct ppa_addr *ppa_list = nvm_rq_to_ppa_list(rqd);
+
+	int i;
+
+	for (i = 0; i < rqd->nr_ppas; i++) {
+		struct ppa_addr *ppa = &ppa_list[i];
+		struct nvm_chk_meta *chunk = pblk_dev_ppa_to_chunk(pblk, *ppa);
+		u64 caddr = pblk_dev_ppa_to_chunk_addr(pblk, *ppa);
+
+		if (caddr == 0)
+			trace_pblk_chunk_state(pblk_disk_name(pblk),
+							ppa, NVM_CHK_ST_OPEN);
+		else if (caddr == chunk->cnlb)
+			trace_pblk_chunk_state(pblk_disk_name(pblk),
+							ppa, NVM_CHK_ST_CLOSED);
+	}
+}
+
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 {
 	struct nvm_tgt_dev *dev = pblk->dev;
+	int ret;
 
 	atomic_inc(&pblk->inflight_io);
 
@@ -488,7 +515,13 @@ int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd)
 		return NVM_IO_ERR;
 #endif
 
-	return nvm_submit_io_sync(dev, rqd);
+	ret = nvm_submit_io_sync(dev, rqd);
+
+	if (trace_pblk_chunk_state_enabled() && !ret &&
+	    rqd->opcode == NVM_OP_PWRITE)
+		pblk_check_chunk_state_update(pblk, rqd);
+
+	return ret;
 }
 
 static void pblk_bio_map_addr_endio(struct bio *bio)
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 76a4a271b9cf..4f2d9b502028 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -19,6 +19,7 @@
  */
 
 #include "pblk.h"
+#include "pblk-trace.h"
 
 static unsigned int write_buffer_size;
 
@@ -664,6 +665,9 @@ static int pblk_setup_line_meta_chk(struct pblk *pblk, struct pblk_line *line,
 		chunk->cnlb = chunk_meta->cnlb;
 		chunk->wp = chunk_meta->wp;
 
+		trace_pblk_chunk_state(pblk_disk_name(pblk), &ppa,
+					chunk->state);
+
 		if (chunk->type & NVM_CHK_TP_SZ_SPEC) {
 			WARN_ONCE(1, "pblk: custom-sized chunks unsupported\n");
 			continue;
diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
new file mode 100644
index 000000000000..d985b729428f
--- /dev/null
+++ b/drivers/lightnvm/pblk-trace.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pblk
+
+#if !defined(_TRACE_PBLK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PBLK_H
+
+#include <linux/tracepoint.h>
+
+struct ppa_addr;
+
+#define show_chunk_flags(state) __print_flags(state, "",	\
+	{ NVM_CHK_ST_FREE,		"FREE",		},	\
+	{ NVM_CHK_ST_CLOSED,		"CLOSED",	},	\
+	{ NVM_CHK_ST_OPEN,		"OPEN",		},	\
+	{ NVM_CHK_ST_OFFLINE,		"OFFLINE",	})
+
+TRACE_EVENT(pblk_chunk_state,
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
+			show_chunk_flags((int)__entry->state))
+
+);
+
+
+#endif /* !defined(_TRACE_PBLK_H) || defined(TRACE_HEADER_MULTI_READ) */
+
+/* This part must be outside protection */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../../drivers/lightnvm
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE pblk-trace
+#include <trace/define_trace.h>
diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index 674ba4d1a9f4..61fe22ccc7a1 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -16,6 +16,7 @@
  */
 
 #include "pblk.h"
+#include "pblk-trace.h"
 
 static unsigned long pblk_end_w_bio(struct pblk *pblk, struct nvm_rq *rqd,
 				    struct pblk_c_ctx *c_ctx)
@@ -251,11 +252,13 @@ static void pblk_end_io_write(struct nvm_rq *rqd)
 	if (rqd->error) {
 		pblk_end_w_fail(pblk, rqd);
 		return;
-	}
+	} else {
+		if (trace_pblk_chunk_state_enabled())
+			pblk_check_chunk_state_update(pblk, rqd);
 #ifdef CONFIG_NVM_PBLK_DEBUG
-	else
 		WARN_ONCE(rqd->bio->bi_status, "pblk: corrupted write error\n");
 #endif
+	}
 
 	pblk_complete_write(pblk, rqd, c_ctx);
 	atomic_dec(&pblk->inflight_io);
@@ -276,6 +279,9 @@ static void pblk_end_io_write_meta(struct nvm_rq *rqd)
 		pblk_log_write_err(pblk, rqd);
 		pblk_err(pblk, "metadata I/O failed. Line %d\n", line->id);
 		line->w_err_gc->has_write_err = 1;
+	} else {
+		if (trace_pblk_chunk_state_enabled())
+			pblk_check_chunk_state_update(pblk, rqd);
 	}
 
 	sync = atomic_add_return(rqd->nr_ppas, &emeta->sync);
diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
index 429347bcd1fa..b2746099ca1d 100644
--- a/drivers/lightnvm/pblk.h
+++ b/drivers/lightnvm/pblk.h
@@ -785,6 +785,7 @@ void pblk_log_read_err(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_io_sync(struct pblk *pblk, struct nvm_rq *rqd);
 int pblk_submit_meta_io(struct pblk *pblk, struct pblk_line *meta_line);
+void pblk_check_chunk_state_update(struct pblk *pblk, struct nvm_rq *rqd);
 struct bio *pblk_bio_map_addr(struct pblk *pblk, void *data,
 			      unsigned int nr_secs, unsigned int len,
 			      int alloc_type, gfp_t gfp_mask);
@@ -1427,4 +1428,11 @@ static inline void pblk_setup_uuid(struct pblk *pblk)
 	uuid_le_gen(&uuid);
 	memcpy(pblk->instance_uuid, uuid.b, 16);
 }
+
+static inline char *pblk_disk_name(struct pblk *pblk)
+{
+	struct gendisk *disk = pblk->disk;
+
+	return disk->disk_name;
+}
 #endif /* PBLK_H_ */
-- 
2.17.1

