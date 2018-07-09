Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08171C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1555208A5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="bwhLWR0R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1555208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933578AbeGIPM0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:12:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36467 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933317AbeGIPKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id s14-v6so21151361wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ojcRlyLPr40Tt6/Zpx8CMXf3WpaRXSbLQlx9xyp8hmY=;
        b=bwhLWR0RxhdKa+nYECbe4u+DOLdtm9TfYoOT0TqL5htnqRHW1wjhoIJknaTjgL+M20
         3gKz53nhfgb/+DCo9ATe8S6krZ+lQiiASlWpGvbuUIpBE0GmjHIPuet8GZy2rE19hGR9
         EYNSPeBVW3M+OcP/CLUOErUACYuYxG8FEyyLzJryvLShR3rhPSJVjlZOi9rlSTo/55kX
         FUNqDbmXL9ft2ZQzA4wKeLyDds6+Sqtl5R+vnCw4pH0r83jpHrdriTvQGXbn11YZtv3A
         E4Sgq0Wz7rP8STitCcywlNS4Pbrzkdkm1bH97Hv4Xz8T5a04N94O3BsgVU5yBmp1QB8z
         Vb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ojcRlyLPr40Tt6/Zpx8CMXf3WpaRXSbLQlx9xyp8hmY=;
        b=OLGIeVL4GhXI++G5Ez2Bywjxl+CtVYnnA6xNHsPcB+4G3az/NorNprUunMc+K3f3IO
         LSUw31x4Su8XZHv9YK9bQBtuAHS9HXLWxeRCbVw1bk34VtTJ4div2B3x9D9sFc5GDP/Z
         2q0P8dtkGxyauoLtdA34wDLtlKTdCTAnQhL9MS2kmRH0nAWax7nmKw6aZNAQ1OGT0ifU
         nn59mRbRLGW2jyj26jvHfL9IgRs07mHG2r1P0UqukeyUh3yFvswCyglzov1TwGKeNBm7
         8fi2Q9QXxPkBHRMrXrAjYPtnEVp9APloGa/+4boYVQV5oNX1SMWf2JaREVQn/g8t2VwZ
         UcMQ==
X-Gm-Message-State: APt69E3V1egL+1/K0nQC9i7L9MP8IquHsL5ZMqPUBs49sLTJsn9mUylR
        zWCKsj+0TqJKIfuaL+2cEk+Xmg==
X-Google-Smtp-Source: AAOMgpfelzD+tCSUhwYXVt4EqnEVg45qSrubxMIK77B1qhKh/euGk6VKJp+EpmJQkZJ3Lve0i04p/Q==
X-Received: by 2002:a1c:8312:: with SMTP id f18-v6mr13123896wmd.127.1531149037739;
        Mon, 09 Jul 2018 08:10:37 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:37 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 07/12] ipc_idr_alloc refactoring
Date:   Mon,  9 Jul 2018 17:10:14 +0200
Message-Id: <20180709151019.1336-8-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Vyukov <dvyukov@google.com>

ipc_idr_alloc refactoring

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/util.c | 51 +++++++++++++--------------------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 8bc166bb4981..a41b8a69de13 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -193,52 +193,32 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 	return NULL;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
 /*
  * Specify desired id for next allocated IPC object.
  */
-static inline int ipc_idr_alloc(struct ipc_ids *ids,
-				struct kern_ipc_perm *new)
+static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 {
-	int key;
+	int key, next_id = -1;
 
-	if (ids->next_id < 0) {
-		key = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
-	} else {
-		key = idr_alloc(&ids->ipcs_idr, new,
-				ipcid_to_idx(ids->next_id),
-				0, GFP_NOWAIT);
-		ids->next_id = -1;
-	}
-	return key;
-}
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	next_id = ids->next_id;
+	ids->next_id = -1;
+#endif
 
-static inline void ipc_set_seq(struct ipc_ids *ids,
-				struct kern_ipc_perm *new)
-{
-	if (ids->next_id < 0) { /* default, behave as !CHECKPOINT_RESTORE */
+	if (next_id < 0) { /* !CHECKPOINT_RESTORE or next_id is unset */
 		new->seq = ids->seq++;
 		if (ids->seq > IPCID_SEQ_MAX)
 			ids->seq = 0;
+		key = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
 	} else {
-		new->seq = ipcid_to_seqx(ids->next_id);
+		new->seq = ipcid_to_seqx(next_id);
+		key = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
+				0, GFP_NOWAIT);
 	}
+	new->id = SEQ_MULTIPLIER * new->seq + key;
+	return key;
 }
 
-#else
-#define ipc_idr_alloc(ids, new)					\
-	idr_alloc(&(ids)->ipcs_idr, (new), 0, 0, GFP_NOWAIT)
-
-static inline void ipc_set_seq(struct ipc_ids *ids,
-			      struct kern_ipc_perm *new)
-{
-	new->seq = ids->seq++;
-	if (ids->seq > IPCID_SEQ_MAX)
-		ids->seq = 0;
-}
-
-#endif /* CONFIG_CHECKPOINT_RESTORE */
-
 /**
  * ipc_addid - add an ipc identifier
  * @ids: ipc identifier set
@@ -278,8 +258,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	current_euid_egid(&euid, &egid);
 	new->cuid = new->uid = euid;
 	new->gid = new->cgid = egid;
-
-	ipc_set_seq(ids, new);
 	new->deleted = false;
 
 	/*
@@ -317,9 +295,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	ids->in_use++;
 	if (id > ids->max_id)
 		ids->max_id = id;
-
-	new->id = SEQ_MULTIPLIER * new->seq + id;
-
 	return id;
 }
 
-- 
2.17.1

