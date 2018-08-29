Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92CAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7480120850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=owltronix-com.20150623.gappssmtp.com header.i=@owltronix-com.20150623.gappssmtp.com header.b="BOxBLl1T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7480120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbeH2Q2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:28:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40022 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbeH2Q2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:28:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so3784387edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=owltronix-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NeDTjzJOqfY5rZWytS4mgF4YyZi+wjNgQMmbZ7e/6y4=;
        b=BOxBLl1TkOuLvCuxPjhOrIJOZXuHu5Bkrg87rdyXrQqFkZ49O/6AsbNF2e10GqvBe4
         t0Lf1wQ6Ykl9hQwT6RJhJzho+j1PoUyJl09iaRUn29g+hu3cpWv5UWka58uGsyQ5Wqr0
         TNyBMYm0aGq5CunsskJ7Lk/5ZdQGkdlpENzvNL9Ol5cuT+BhDszGnO2J2GXf9IONBD8e
         441e7Kfuep5en4/NuB3LV6HCZDNY/dKPDzzE1C5C8iyTQp5hxaA1J9XLbp9TGxKuKlGL
         hksRmGJKS8Uz+P86irXio7vavDF1Yy/Nth/8A6H2suzU3BOqSsiEC+3Bj7GCqDmURv4m
         fOVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NeDTjzJOqfY5rZWytS4mgF4YyZi+wjNgQMmbZ7e/6y4=;
        b=OcnBC9VKpoqL71SgD3BeoJNFKrxGXzWzc6UMcNub/4cMuywcuf8WKQeGvrE152aNgs
         gc4mAurLm90MdxAEmHmkIjHCJLHNS3DwhfFZKfDRznYOgX27v9XTPuj8AEwZlBhIm+X4
         H/XTXCX/JhVbiAiCUPN7pG1IdorpPkjFEFi6s8baQYiSScipphsqZalLNmPk4TLu9dGi
         ByyomNn2rS3pldUA5uedEllZXC/pE0BtrdTZKZZ1wGtznTIffCceAgl56b4iBDYN7X6K
         sobRxIrqx8hVG3MTGem+Nd8E5HpPSa0OW/4TlTLdMSaqpJ9wtymVi15NCuJuc0XDq0xV
         4Yhg==
X-Gm-Message-State: APzg51CnW8rZwHuso6kXD39CWzBJyrVBDIeGW2xNTlngSlaeZLy/kr7q
        uo6GJw+qSu6SE/S6L3jFCu5nyA==
X-Google-Smtp-Source: ANB0VdaNFsOl0HXmoyXeXOV0rMVImNgZH0YHQu1X+n5nzBxcpX2AQHvYdQIBoz035nMm57AmlrkBtg==
X-Received: by 2002:a50:92ce:: with SMTP id l14-v6mr7529921eda.43.1535545892535;
        Wed, 29 Aug 2018 05:31:32 -0700 (PDT)
Received: from titan.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id r44-v6sm2765454edd.87.2018.08.29.05.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 05:31:32 -0700 (PDT)
From:   Hans Holmberg <hans.ml.holmberg@owltronix.com>
To:     Matias Bjorling <mb@lightnvm.io>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Javier Gonzales <javier@cnexlabs.com>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: [PATCH 3/4] lightnvm: pblk: add trace events for pblk state changes
Date:   Wed, 29 Aug 2018 14:31:16 +0200
Message-Id: <1535545877-770-4-git-send-email-hans.ml.holmberg@owltronix.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
References: <1535545877-770-1-git-send-email-hans.ml.holmberg@owltronix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Holmberg <hans.holmberg@cnexlabs.com>

Add trace events for tracking pblk state changes.

Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c  |  3 +++
 drivers/lightnvm/pblk-init.c  |  1 +
 drivers/lightnvm/pblk-trace.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 05775a279b20..566a5d3165ee 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1503,6 +1503,7 @@ static void pblk_stop_writes(struct pblk *pblk, struct pblk_line *line)
 
 	pblk_set_space_limit(pblk);
 	pblk->state = PBLK_STATE_STOPPING;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 }
 
 static void pblk_line_close_meta_sync(struct pblk *pblk)
@@ -1552,6 +1553,7 @@ void __pblk_pipeline_flush(struct pblk *pblk)
 		return;
 	}
 	pblk->state = PBLK_STATE_RECOVERING;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 	spin_unlock(&l_mg->free_lock);
 
 	pblk_flush_writer(pblk);
@@ -1573,6 +1575,7 @@ void __pblk_pipeline_stop(struct pblk *pblk)
 
 	spin_lock(&l_mg->free_lock);
 	pblk->state = PBLK_STATE_STOPPED;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 	l_mg->data_line = NULL;
 	l_mg->data_next = NULL;
 	spin_unlock(&l_mg->free_lock);
diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
index ddbd91d80119..d0546213c64f 100644
--- a/drivers/lightnvm/pblk-init.c
+++ b/drivers/lightnvm/pblk-init.c
@@ -1093,6 +1093,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
 	pblk->dev = dev;
 	pblk->disk = tdisk;
 	pblk->state = PBLK_STATE_RUNNING;
+	trace_pblk_state(pblk_disk_name(pblk), pblk->state);
 	pblk->gc.gc_enabled = 0;
 
 	if (!(geo->version == NVM_OCSSD_SPEC_12 ||
diff --git a/drivers/lightnvm/pblk-trace.h b/drivers/lightnvm/pblk-trace.h
index f9aa9e25e428..c171d0450c07 100644
--- a/drivers/lightnvm/pblk-trace.h
+++ b/drivers/lightnvm/pblk-trace.h
@@ -25,6 +25,13 @@ struct ppa_addr;
 	{ PBLK_LINESTATE_CORRUPT,	"CORRUPT"	})
 
 
+#define show_pblk_state(state) __print_symbolic(state,		\
+	{ PBLK_STATE_RUNNING,		"RUNNING",	},	\
+	{ PBLK_STATE_STOPPING,		"STOPPING",	},	\
+	{ PBLK_STATE_RECOVERING,	"RECOVERING",	},	\
+	{ PBLK_STATE_STOPPED,		"STOPPED"	})
+
+
 TRACE_EVENT(pblk_chunk_state,
 
 	TP_PROTO(const char *name, struct ppa_addr *ppa, int state),
@@ -75,6 +82,27 @@ TRACE_EVENT(pblk_line_state,
 
 );
 
+TRACE_EVENT(pblk_state,
+
+	TP_PROTO(const char *name, int state),
+
+	TP_ARGS(name, state),
+
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(int, state);
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->state = state;
+	),
+
+	TP_printk("dev=%s state=%s", __get_str(name),
+			show_pblk_state((int)__entry->state))
+
+);
+
 #endif /* !defined(_TRACE_PBLK_H) || defined(TRACE_HEADER_MULTI_READ) */
 
 /* This part must be outside protection */
-- 
2.7.4

