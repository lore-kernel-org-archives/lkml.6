Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF683C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6227520850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="wAArCvAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6227520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbeH2Q2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:28:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39166 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeH2Q2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:28:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so3795500edi.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E96ewGW/cxvzA3sms7PEeeZvOEBkXvNuxE2VAuhUXsE=;
        b=wAArCvAuIlKlUh21/E0/3dwAzjgLjLSH1CYm4/eXdr1IEUzalYsPElmMFDBxPiSFg6
         ccvz/8/a6VMDEefEhbf0Vja47mfJkR3I1QkT5fSGBNVEe5YrI1iGvd4UAhJOJfOdAPOa
         9/lbBpNaLG0D5Ydxk1Py3/mDiqBn5pHPP/nZwIp+HhUrzMXqNYMWAaY+6DnNRwPCfYlr
         L7FABlcbd5N7iqGPB6EIFHeWs1AbMnHR5+57Xv68ADnlFfr9vWnVhzzAsrpayEjQLagT
         79LueqK+y9Q5t1S5BVsCNSW7YQRhMc4PVpcirI9xY9gkwriktL17tCDB3/rb8+P0UTV0
         QvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E96ewGW/cxvzA3sms7PEeeZvOEBkXvNuxE2VAuhUXsE=;
        b=JW0zDgO764Dfcpyo3jMENwRVmco2fSgL0dkDetqqc+pcbD8kbuldFQ6IRqzmgVeFg9
         NmWhLjw4TXE6UKitIYt7Je/deWCK/ScPL53eqCcIUHYIoaKToFmMbZBUTbn+avMkjg7Q
         XUlkpEFy4naLx7qqZS9+UmABimVu+ZN130QOiJ3LYm5a21tZdt4actLmudzqLWLhI0E8
         PieyI9pa0qhNIRc8S5FeXyLw1lpJBegytwa++RwAOBokkVSTm3UaJB54XzP+BMehkvhE
         ztn4akwaxmZM6tjwtQ8n/uOFidBAtcwUB0aL52RUHE0cANT4zCJDBVyvoA32xUUnqAo4
         nhDA==
X-Gm-Message-State: APzg51DmfISUMhyfxn1ckpagLc/xS4UEVZmRVP25O1EKKrlQ6HkpMQvB
        UwafTldXXPBJiWq3sGdJIR4omw==
X-Google-Smtp-Source: ANB0VdagHrVEV1MWIKB2zyU/+KucFh+dsQX2iPlJ0/WEOCqBlxT6wdwZFcHXv8Z7cbryyxiMJhqDAQ==
X-Received: by 2002:a50:d4d5:: with SMTP id e21-v6mr7695667edj.127.1535545891846;
        Wed, 29 Aug 2018 05:31:31 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id r44-v6sm2765454edd.87.2018.08.29.05.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:31:31 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 2/4] lightnvm: pblk: add trace events for line state changes
Date:   Wed, 29 Aug 2018 14:31:15 +0200
Message-Id: <1535545877-770-3-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Add trace events for logging for line state changes.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 19 ++++++++++++++++++-
 drivers/lightnvm/pblk-gc.c       |  8 ++++++++
 drivers/lightnvm/pblk-init.c     |  3 +++
 drivers/lightnvm/pblk-recovery.c |  6 ++++++
 drivers/lightnvm/pblk-trace.h    | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 4da37e29bb06..05775a279b20 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -413,6 +413,9 @@ struct list_head *pblk_line_gc_list(struct pblk *pblk, struct pblk_line *line)
 		}
 	} else {
 		line->state = PBLK_LINESTATE_CORRUPT;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
+
 		line->gc_group = PBLK_LINEGC_NONE;
 		move_list =  &l_mg->corrupt_list;
 		pblk_err(pblk, "corrupted vsc for line %d, vsc:%d (%d/%d/%d)\n",
@@ -1019,6 +1022,8 @@ static int pblk_line_init_metadata(struct pblk *pblk, struct pblk_line *line,
 		spin_lock(&l_mg->free_lock);
 		spin_lock(&line->lock);
 		line->state = PBLK_LINESTATE_BAD;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_add_tail(&line->list, &l_mg->bad_list);
@@ -1166,6 +1171,8 @@ static int pblk_line_init_bb(struct pblk *pblk, struct pblk_line *line,
 		bitmap_weight(line->invalid_bitmap, lm->sec_per_line)) {
 		spin_lock(&line->lock);
 		line->state = PBLK_LINESTATE_BAD;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_add_tail(&line->list, &l_mg->bad_list);
@@ -1218,6 +1225,8 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	if (line->state == PBLK_LINESTATE_NEW) {
 		blk_to_erase = pblk_prepare_new_line(pblk, line);
 		line->state = PBLK_LINESTATE_FREE;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 	} else {
 		blk_to_erase = blk_in_line;
 	}
@@ -1235,6 +1244,8 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	}
 
 	line->state = PBLK_LINESTATE_OPEN;
+	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+				line->state);
 
 	atomic_set(&line->left_eblks, blk_to_erase);
 	atomic_set(&line->left_seblks, blk_to_erase);
@@ -1331,6 +1342,8 @@ struct pblk_line *pblk_line_get(struct pblk *pblk)
 	if (unlikely(bit >= lm->blk_per_line)) {
 		spin_lock(&line->lock);
 		line->state = PBLK_LINESTATE_BAD;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_add_tail(&line->list, &l_mg->bad_list);
@@ -1650,6 +1663,8 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
 	line->state = PBLK_LINESTATE_FREE;
+	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 	line->gc_group = PBLK_LINEGC_NONE;
 	pblk_line_free(line);
 
@@ -1779,7 +1794,6 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
 	WARN_ON(line->state != PBLK_LINESTATE_OPEN);
 	line->state = PBLK_LINESTATE_CLOSED;
 	move_list = pblk_line_gc_list(pblk, line);
-
 	list_add_tail(&line->list, move_list);
 
 	mempool_free(line->map_bitmap, l_mg->bitmap_pool);
@@ -1798,6 +1812,9 @@ void pblk_line_close(struct pblk *pblk, struct pblk_line *line)
 
 	spin_unlock(&line->lock);
 	spin_unlock(&l_mg->gc_lock);
+
+	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 }
 
 void pblk_line_close_meta(struct pblk *pblk, struct pblk_line *line)
diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
index 157c2567c9e8..b841d84c4342 100644
--- a/drivers/lightnvm/pblk-gc.c
+++ b/drivers/lightnvm/pblk-gc.c
@@ -16,8 +16,10 @@
  */
 
 #include "pblk.h"
+#include "pblk-trace.h"
 #include <linux/delay.h>
 
+
 static void pblk_gc_free_gc_rq(struct pblk_gc_rq *gc_rq)
 {
 	if (gc_rq->data)
@@ -64,6 +66,8 @@ static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
 	spin_lock(&line->lock);
 	WARN_ON(line->state != PBLK_LINESTATE_GC);
 	line->state = PBLK_LINESTATE_CLOSED;
+	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 	move_list = pblk_line_gc_list(pblk, line);
 	spin_unlock(&line->lock);
 
@@ -405,6 +409,8 @@ void pblk_gc_free_full_lines(struct pblk *pblk)
 		spin_lock(&line->lock);
 		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
 		line->state = PBLK_LINESTATE_GC;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_del(&line->list);
@@ -451,6 +457,8 @@ static void pblk_gc_run(struct pblk *pblk)
 		spin_lock(&line->lock);
 		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
 		line->state = PBLK_LINESTATE_GC;
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 		spin_unlock(&line->lock);
 
 		list_del(&line->list);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index 3f8bae9be852..ddbd91d80119 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -971,6 +971,9 @@ static int pblk_lines_init(struct pblk *pblk)
 			goto fail_free_lines;
 
 		nr_free_chks += pblk_setup_line_meta(pblk, line, chunk_meta, i);
+
+		trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+								line->state);
 	}
 
 	if (!nr_free_chks) {
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index eea901d7cebc..f4c5318e99d7 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -15,6 +15,7 @@
  */
 
 #include "pblk.h"
+#include "pblk-trace.h"
 
 int pblk_recov_check_emeta(struct pblk *pblk, struct line_emeta *emeta_buf)
 {
@@ -932,6 +933,8 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 
 			spin_lock(&line->lock);
 			line->state = PBLK_LINESTATE_CLOSED;
+			trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
 			move_list = pblk_line_gc_list(pblk, line);
 			spin_unlock(&line->lock);
 
@@ -947,6 +950,9 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
 			if (open_lines > 1)
 				pblk_err(pblk, "failed to recover L2P\n");
 
+			trace_pblk_line_state(pblk_disk_name(pblk), line->id,
+					line->state);
+
 			open_lines++;
 			line->meta_line = meta_line;
 			data_line = line;
diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
index d985b729428f..f9aa9e25e428 100644
--- a/drivers/lightnvm/pblk-trace.h
+++ b/drivers/lightnvm/pblk-trace.h
@@ -15,6 +15,16 @@ struct ppa_addr;
 	{ NVM_CHK_ST_OPEN,		"OPEN",		},	\
 	{ NVM_CHK_ST_OFFLINE,		"OFFLINE",	})
 
+#define show_line_state(state) __print_symbolic(state,		\
+	{ PBLK_LINESTATE_NEW,		"NEW",		},	\
+	{ PBLK_LINESTATE_FREE,		"FREE",		},	\
+	{ PBLK_LINESTATE_OPEN,		"OPEN",		},	\
+	{ PBLK_LINESTATE_CLOSED,	"CLOSED",	},	\
+	{ PBLK_LINESTATE_GC,		"GC",		},	\
+	{ PBLK_LINESTATE_BAD,		"BAD",		},	\
+	{ PBLK_LINESTATE_CORRUPT,	"CORRUPT"	})
+
+
 TRACE_EVENT(pblk_chunk_state,
 
 	TP_PROTO(const char *name, struct ppa_addr *ppa, int state),
@@ -41,6 +51,29 @@ TRACE_EVENT(pblk_chunk_state,
 
 );
 
+TRACE_EVENT(pblk_line_state,
+
+	TP_PROTO(const char *name, int line, int state),
+
+	TP_ARGS(name, line, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, line)
+		__field(int, state);
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->line = line;
+		__entry->state = state;
+	),
+
+	TP_printk("dev=%s line=%d state=%s", __get_str(name),
+			(int)__entry->line,
+			show_line_state((int)__entry->state))
+
+);
 
 #endif /* !defined(_TRACE_PBLK_H) || defined(TRACE_HEADER_MULTI_READ) */
 
-- 
2.7.4

