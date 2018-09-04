Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC63C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4062F20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="NHZV9x4H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4062F20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeIDPCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:02:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43811 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeIDPCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:02:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id z27-v6so2830786edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 03:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkPWbB/x39SeFKAOOwNX9ozIb3TYZsz2f/YKTTP2pnQ=;
        b=NHZV9x4HYh4ZF53rpOdDBQAtFepPYQwLmWSbBOFM4vxX2gs5GlQoJzlTwVL9/0+QH0
         5LUEOH0YcmPJ6kqmdLhEkaA2vYi6NaJIYvjcsnKZGaeR80TlYgZF76z3MgRtkG1GDDvE
         A8eQcXgOahLpYDB0Ar5kjWZ1FAZNDcAjFUkNU2wnVwjIPOLJmF8Ckj90MkrMw9gUrRD+
         EaoylFwHoOcULITWJxthuZgxO0AFE6jW7o9As/GOxOenMECc98WWhUeYzEWpkj4Lbldi
         CVP3IoGX5g+YP4q1FkpNUJdkyS4V7yEJ0xUtXzC4qW2j15/Wvpcuw0neVzu7GxySC3qS
         MC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nkPWbB/x39SeFKAOOwNX9ozIb3TYZsz2f/YKTTP2pnQ=;
        b=AxMojQRaEjMNAhhaAuzgG9GSCfCDEHGXmdVlQYygI304vhiV51SZF7N/x2qY+l54n2
         vRIpOo01d2P/G+pf32XBPT494bF+G6Y4A9r1vphrPCb+qhw7XjGYCdX1KKJVRzJ74rMx
         IBiulCOFVqUe3f0XHVIGFsUZLjzzpvpcJr1yIx5KOL7pAdpDPwTJZKVsl4VUC+J8GRaE
         75emlbMrLMj5B99VKgOQgknc0FvOzpcOzObSpYcHKhvx7nWWFJY/KSfvmqLqWiD8EHVS
         b9+puNo2XoOuFLWED1njwcupzB8scLyKMQ+Fx0EArFJ3X6yWRtgJiXu0SD/UdfvNrzQx
         ot8w==
X-Gm-Message-State: APzg51B7bJAFQDGpBOZQVZGnaBbL8Px4+R4YGz7qsQZ5g+akdCQACgXu
        7UaAOOs2gaEFunf52/L9ZPNvxrH0zjwAXQ==
X-Google-Smtp-Source: ANB0VdaL9FOYj9TJyGUqMEp9KT/jdzh1IcOOneVJFcR/YdojLlMZxEwEqzIDXCpSj0S4i8DGw/mUgw==
X-Received: by 2002:a50:fa8b:: with SMTP id w11-v6mr13257908edr.59.1536057497063;
        Tue, 04 Sep 2018 03:38:17 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id b44-v6sm11803477edd.93.2018.09.04.03.38.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 03:38:16 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH V2] lightnvm: pblk: add tracing for chunk resets
Date:   Tue,  4 Sep 2018 12:38:05 +0200
Message-Id: <1536057487-17267-1-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
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

You already picked up the first version of this patch Matias,
but here's a V2 adressing the review comment from Javier that came
after that.

Changes in V2:
	Moved the synchronous PBLK_CHUNK_RESET_START trace to
	pblk_blk_erase_sync (as Javier suggested)

 drivers/lightnvm/pblk-core.c  | 12 ++++++++++++
 drivers/lightnvm/pblk-trace.h | 31 +++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk.h       |  6 ++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 73f117bc99a9..951f81a1b273 100644
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
index ae705fb52cf7..f0fcd963ab3a 100644
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
2.7.4

