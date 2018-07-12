Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49389EC2F02
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0719B208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="r42gTF8v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0719B208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732390AbeGLTEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:08 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36133 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732344AbeGLTEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:07 -0400
Received: by mail-wm0-f53.google.com with SMTP id s14-v6so7119864wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=34/lc7wzdbzbGT9TkKN03OB3zabW3AIhrTpTN2ASzm0=;
        b=r42gTF8vPLf/VQrS2ryNi6wPUqCZS37I451bstXsx9zygaG31Opqd7kj+SpT2IYXMD
         9gmJTPDejD4pe5cBAZLeFky6h6g6qWiL6YqJ3zPXy8Mj+ijclVpacCgurg07Elxdb4jR
         qpiLSVRVK4AkKIpSybtgNboYbKFpROGHbcbEaMadWaf+bw2OQ3YbpIxtgBi+ABBOmd2d
         tDc4TcK2iyennGk2qmUvOxOTtKtasH/oXQEwSz+Xp1wkgp8ud06xE5zit/zFii0mfJcn
         dfa3Ij4qQed8i4uRefeHJ69dwRyTiwJR6ojeDszby8CKLUBZknxEZHzRe+4yWfTflqGz
         GG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=34/lc7wzdbzbGT9TkKN03OB3zabW3AIhrTpTN2ASzm0=;
        b=F4QhU9xf6esAoQ/jJXLsbwgTqFIzYBdySmdWqw6b4R2dgBAkvFvR+55EnYDJHfj35U
         t3H8CU7Bxns1yassQVXUrwnxZy58EHXZ3thfDyx4F5nkzO3UMfsSa2CVjON8FfEi5Se1
         F4M1JBKGzCkv76rmRIjs5R0atmfaM3xUc/9++t+vNrVRewa+HNxNChdFNAlpaiciBX1P
         WBJxm/77hioD4FBNBuMib845+n10RvlkiWZ1XtMV+RAmpUCcHxIZb322Mefd3lyggEBA
         cIxMFToxEA5NwYmfvABePrZ7qjO85vb6kTEWkYhqMm65r8/SwwarMoBDqyDVct+zm0QP
         XCuA==
X-Gm-Message-State: AOUpUlF7nXVejDLBoCh7okxbrYPUVhaHTZMr7ePtAQMptCvzXsDqToEb
        jlFJrdD5HPF8u4X11YMk9PNDYA==
X-Google-Smtp-Source: AAOMgpf953mZDcw4aUFY1WAGJVhnHC39MvxWSc5HBdWhNrD+Uivv3yubQ2FdNT1nYJleVEDSxW8oXw==
X-Received: by 2002:a1c:8952:: with SMTP id l79-v6mr1982230wmd.7.1531421597373;
        Thu, 12 Jul 2018 11:53:17 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:16 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 12/12] ipc/util.c: update return value of ipc_getref from int to bool
Date:   Thu, 12 Jul 2018 20:52:41 +0200
Message-Id: <20180712185241.4017-13-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipc_getref has still a return value of type "int", matching the atomic_t
interface of atomic_inc_not_zero()/atomic_add_unless().

ipc_getref now uses refcount_inc_not_zero, which has a return value of
type "bool".

Therefore: Update the return code to avoid implicit conversions.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
---
 ipc/util.c | 2 +-
 ipc/util.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index fb69c911655a..6306eb25180b 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -461,7 +461,7 @@ void ipc_set_key_private(struct ipc_ids *ids, struct kern_ipc_perm *ipcp)
 	ipcp->key = IPC_PRIVATE;
 }
 
-int ipc_rcu_getref(struct kern_ipc_perm *ptr)
+bool ipc_rcu_getref(struct kern_ipc_perm *ptr)
 {
 	return refcount_inc_not_zero(&ptr->refcount);
 }
diff --git a/ipc/util.h b/ipc/util.h
index e74564fe3375..0a159f69b3bb 100644
--- a/ipc/util.h
+++ b/ipc/util.h
@@ -138,7 +138,7 @@ static inline int ipc_get_maxidx(struct ipc_ids *ids)
  * refcount is initialized by ipc_addid(), before that point call_rcu()
  * must be used.
  */
-int ipc_rcu_getref(struct kern_ipc_perm *ptr);
+bool ipc_rcu_getref(struct kern_ipc_perm *ptr);
 void ipc_rcu_putref(struct kern_ipc_perm *ptr,
 			void (*func)(struct rcu_head *head));
 
-- 
2.17.1

