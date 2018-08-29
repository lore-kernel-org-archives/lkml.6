Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC49C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B206020850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="jnUTiIzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B206020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbeH2Q2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:28:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41915 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbeH2Q2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:28:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so3788821edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VNdJHFbN8KWM8+bNJqvSnzQsqXjKe+ArKerxXIjrkNo=;
        b=jnUTiIzL+0XmPYjd2iNtzXN9BNpdyvmD27midBzj4MWqXaUJ3oryowCPGMO76ZyGW0
         A/cdREBjdubKacHCSDrbYFV+zU1Q4sEMiXIFoElcazCS3QuxOyWGb1sGYquCoaQ4RhJ4
         Kxe+rvFC/z+u/ZDBtJK/NJAWXzGFHpNFJG2FuQ6U6kfqEbaOCD0o4afWH+G51qxsAx1X
         BldkytSFUb/BwQJqUOzJ/pTyAjUQcjLO1IpKYO9caqdmBzA9Gc4ETDkypOk+dcu4oU/W
         ttQy4C2RWekvsYR5am3gK3yYh9Ct9DupqKRWw/aButmMQHLqviIXDXIddtv6iqdqa2UF
         sU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VNdJHFbN8KWM8+bNJqvSnzQsqXjKe+ArKerxXIjrkNo=;
        b=iTyBGAzqjoTiosVxICZ/ROG+JYJbveLl6D9JWql10KSFEDascdpwJJF+tK2f/1dh6t
         ysLwVjpHWW2u8pFPkSkhuBYmqSw7/aXakj3jOxsNYM+HRapuZt0bx4zAdseNbdPMjLsl
         PYEoKhmM8luPnXtg0AQEeLXYTscTzF/FBCEYw8vpPpMBwiNPm3GrLsn9Y8iOkgguF0w3
         ac4RvkCv0c2k4EpVl8tK2Lri54xKiM/tc2u+5VGpLr2K6drYMs2L5FpNowJNvDVa0HmU
         VGEbFVFmX/ArY3a8xjBvXhLHe/nXVr/kbZcNxKMhxi4Vmwm5V0dElLNbHDCljS5Iw1ot
         z9pA==
X-Gm-Message-State: APzg51BD5bTFY/XiSVdXTAUZJZrl7QpMZrP9lS1vbaEefSCUBAUOMJvG
        k7BFguZRFqbR/IqXNhovswrmoQ==
X-Google-Smtp-Source: ANB0VdYqwrrT9kfcdikgF6RReusNrdHB1Ddr3qTz4Zrrnrl14gD+obX9CpTt+LFLQHBfTmrb1rv0lA==
X-Received: by 2002:a50:b53a:: with SMTP id y55-v6mr7539785edd.191.1535545893243;
        Wed, 29 Aug 2018 05:31:33 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id r44-v6sm2765454edd.87.2018.08.29.05.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:31:32 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 4/4] lightnvm: pblk: add tracing for chunk resets
Date:   Wed, 29 Aug 2018 14:31:17 +0200
Message-Id: <1535545877-770-5-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Trace state of chunk resets.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  | 12 ++++++++++++
 drivers/lightnvm/pblk-trace.h | 31 +++++++++++++++++++++++++++++++
 drivers/lightnvm/pblk.h       |  6 ++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 566a5d3165ee..b874001d1175 100644
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
 
@@ -958,6 +964,9 @@ int pblk_line_erase(struct pblk *pblk, struct pblk_line *line)
 		WARN_ON(test_and_set_bit(bit, line->erase_bitmap));
 		spin_unlock(&line->lock);
 
+		trace_pblk_chunk_reset(pblk_disk_name(pblk),
+				&ppa, PBLK_CHUNK_RESET_START);
+
 		ret = pblk_blk_erase_sync(pblk, ppa);
 		if (ret) {
 			pblk_err(pblk, "failed to erase line %d\n", line->id);
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
index ed17db2cae2c..6195e3f5d2e6 100644
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

