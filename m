Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07BDC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A6E2208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="g1GzJJHd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A6E2208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933460AbeGIPLN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:11:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40215 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933092AbeGIPKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id t6-v6so11380910wrn.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rIOzyEFvIQL2DQ4Z97T2nwYUV09j+BmZWHxNQoPoP4M=;
        b=g1GzJJHdS3H2hDBEimn3TR73pvFHLA8fwQF9wPE+7whpEEtFqQXg+LlHtvzS/7Arkj
         xCr8jtkXwFPVgFmd2Q8CW59Ka0npCH6U3YW4hjZd8aSA73Hy0jOsatRoWTul+kUvryjq
         U/rIazOHsCXjQeZUqv3GXq3fxW3pJ97HOGJyl/UQSsZW6YTHmXl/DoO3FWB+r3Xo9LO5
         BEUQd/sArzmFsOrL9Dyi+pvtE6zWMT1rFFLh5FMIB7bpL7cSTJ5GFkirMyu12qe6Bn6x
         yK3dMzV0ME7SIx7xKtwZLaVJASdgjKD2OYRrFrOLP5YZ5kLLGn9midnqboIta1OPjeN8
         sxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rIOzyEFvIQL2DQ4Z97T2nwYUV09j+BmZWHxNQoPoP4M=;
        b=YtP7lClHcc436pOqkhNbDK3o5XhJOxTw/RQczsKP/hV3PjsVCeq4313TAn/qMIM9dg
         dSmgm/iKUOOUXIU+RcyZX3pnruePjvdv04SNOvfVqQSdQzYbOOllbBhafx84d3fIb7So
         47EtNHS7wrLxV5uJdJkPt6Lx9af4TizcEkaHXJCS/upMxVpD9omHuce0CO/+Y9SVLICt
         tuebDJb+hv6Thjr2rjbupJSKaC0IPKKdH9CTgGqm9iGf8LZNsbbkzh/M00JAHjFCHqJ7
         vACWfJoID4yyvXzr2RHX5ZAcg5+/IPrLVRtZLC9sHtY1kBuL0NvcFBbZfMriV4THCOCT
         KuXA==
X-Gm-Message-State: AOUpUlGS5IcxDhGILPHH4jRKtUJVlxtp9DVtFL/lsjSt39UVgnroB6Qs
        zxju0eDp8wCQPxV3eW2sEbPOWw==
X-Google-Smtp-Source: AAOMgpfLZkUaz7XAMqlRMb2bW/Bky32ozXBQhMJr2wH6qWDuedUKEjotOqCfwabcussZCCIA7a64Qg==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr2553765wra.120.1531149042910;
        Mon, 09 Jul 2018 08:10:42 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:42 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 12/12] ipc/util.c: Further ipc_idr_alloc cleanups.
Date:   Mon,  9 Jul 2018 17:10:19 +0200
Message-Id: <20180709151019.1336-13-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If idr_alloc within ipc_idr_alloc fails, then the return value (-ENOSPC)
is used to calculate new->id.
Technically, this is not a bug, because new->id is never accessed.

But: Clean it up anyways: On error, just return, do not set new->id.
And improve the documentation.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 ipc/util.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index d474f2b3b299..302c18fc846b 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -182,11 +182,20 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 }
 
 /*
- * Specify desired id for next allocated IPC object.
+ * Insert new IPC object into idr tree, and set sequence number and id
+ * in the correct order.
+ * Especially:
+ * - the sequence number must be set before inserting the object into the idr,
+ *   because the sequence number is accessed without a lock.
+ * - the id can/must be set after inserting the object into the idr.
+ *   All accesses must be done after getting kern_ipc_perm.lock.
+ *
+ * The caller must own kern_ipc_perm.lock.of the new object.
+ * On error, the function returns a (negative) error code.
  */
 static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 {
-	int key, next_id = -1;
+	int id, next_id = -1;
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	next_id = ids->next_id;
@@ -197,14 +206,15 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 		new->seq = ids->seq++;
 		if (ids->seq > IPCID_SEQ_MAX)
 			ids->seq = 0;
-		key = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
+		id = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
-		key = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
+		id = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
 				0, GFP_NOWAIT);
 	}
-	new->id = SEQ_MULTIPLIER * new->seq + key;
-	return key;
+	if (id >= 0)
+		new->id = SEQ_MULTIPLIER * new->seq + id;
+	return id;
 }
 
 /**
-- 
2.17.1

