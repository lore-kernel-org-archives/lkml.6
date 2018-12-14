Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA4EC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EF7920866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfR4psKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF7920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeLNGnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:43:12 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45665 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727179AbeLNGnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:43:10 -0500
Received: by mail-pf1-f194.google.com with SMTP id g62so2331789pfd.12;
        Thu, 13 Dec 2018 22:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cf9GacyXSfcSYQD1hrpRVZxNJit6THuob2xtfEuPnDI=;
        b=BfR4psKlef8o1v7MrtDWgkZZzDExJYmy4mI4dQpM+NCUPR36QJKUy4unCEA57QnUUA
         Sps7DfOJ1jBmEfYhhCSRvMGVHvGYFb/NaYX9J5SEqeGEnOHBlNihiicX61pVD+T28TYs
         4TNWbdVHqBicWWAIW/nkNhKqkqf1ldlMJ3WLyFWQB8MMWXMvSDs+reYLEKwrD0iVMTcq
         iSFJl0s30i76WyP/6mhp07Mw064q9uUVCjDzThKZd0Fh2H18oehZFVr+8s/f4SFm4zmT
         GWYzHI8o7MaYkIaXx7SA6AVW/SQ25KY8g9zbGr8eNhj7Onp5dm5QoOw031wSS8HFGDrj
         bdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cf9GacyXSfcSYQD1hrpRVZxNJit6THuob2xtfEuPnDI=;
        b=lkcXb/HpWzrzw4i5yM2F42hXtXhq/s/lnCxaeD8oPOnHCjPuSp8DuARPxKVkvERh4V
         7YAYg2Ejj1mdZwg+L3TVkczxyrWP84y4y/NwSTPmGYxArO685pFz4l2LV/NF+QmOzK/A
         4hYdjZ6EL5A8XT1pQdxvCFBkQLOwW6uES9ar2R8ejueFISGqFitBU/1hbjC0sDZLz2Be
         ctm8GrJ44NWDyp4JZQA4RyUJoB8FNPPpINsCcy6Eq+25co11NYl2+zCI4BV8yvDpwwyu
         auOUSC4cW5RYdefFD4EeqLQLsI8tl7aVLB4EBzB2/OO+2pd6z1bOpzY+0EFF46m1xtiz
         wPUw==
X-Gm-Message-State: AA+aEWbY/QZwKn3a2JJ8LQaHyzoWShyp+FmRTJQCe4JbWKh7oT5ALit2
        n8Pwhze3R4cO3YYqirJQneM=
X-Google-Smtp-Source: AFSGD/Vg2CvhlVmp4b//gn5A/j1f42Ky3SwA3E9gurSpJOgfuPyLKwTNxjQsnapNqgIr3rq+9M+qEA==
X-Received: by 2002:a63:9501:: with SMTP id p1mr1676451pgd.149.1544769790012;
        Thu, 13 Dec 2018 22:43:10 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e16sm5132645pfn.46.2018.12.13.22.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 22:43:09 -0800 (PST)
From:   frowand.list@gmail.com
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] of: __of_detach_node() - remove node from phandle cache
Date:   Thu, 13 Dec 2018 22:42:51 -0800
Message-Id: <1544769771-5468-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Non-overlay dynamic devicetree node removal may leave the node in
the phandle cache.  Subsequent calls to of_find_node_by_phandle()
will incorrectly find the stale entry.  Remove the node from the
cache.

Add paranoia checks in of_find_node_by_phandle() as a second level
of defense (do not return cached node if detached, do not add node
to cache if detached).

Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/base.c       | 29 ++++++++++++++++++++++++++++-
 drivers/of/dynamic.c    |  3 +++
 drivers/of/of_private.h |  4 ++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index d599367cb92a..34a5125713c8 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -162,6 +162,27 @@ int of_free_phandle_cache(void)
 late_initcall_sync(of_free_phandle_cache);
 #endif
 
+/*
+ * Caller must hold devtree_lock.
+ */
+void __of_free_phandle_cache_entry(phandle handle)
+{
+	phandle masked_handle;
+
+	if (!handle)
+		return;
+
+	masked_handle = handle & phandle_cache_mask;
+
+	if (phandle_cache) {
+		if (phandle_cache[masked_handle] &&
+		    handle == phandle_cache[masked_handle]->phandle) {
+			of_node_put(phandle_cache[masked_handle]);
+			phandle_cache[masked_handle] = NULL;
+		}
+	}
+}
+
 void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
@@ -1209,11 +1230,17 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 		if (phandle_cache[masked_handle] &&
 		    handle == phandle_cache[masked_handle]->phandle)
 			np = phandle_cache[masked_handle];
+		if (np && of_node_check_flag(np, OF_DETACHED)) {
+			of_node_put(np);
+			phandle_cache[masked_handle] = NULL;
+			np = NULL;
+		}
 	}
 
 	if (!np) {
 		for_each_of_allnodes(np)
-			if (np->phandle == handle) {
+			if (np->phandle == handle &&
+			    !of_node_check_flag(np, OF_DETACHED)) {
 				if (phandle_cache) {
 					/* will put when removed from cache */
 					of_node_get(np);
diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index f4f8ed9b5454..ecea92f68c87 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -268,6 +268,9 @@ void __of_detach_node(struct device_node *np)
 	}
 
 	of_node_set_flag(np, OF_DETACHED);
+
+	/* race with of_find_node_by_phandle() prevented by devtree_lock */
+	__of_free_phandle_cache_entry(np->phandle);
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 5d1567025358..24786818e32e 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -84,6 +84,10 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
 int of_resolve_phandles(struct device_node *tree);
 #endif
 
+#if defined(CONFIG_OF_DYNAMIC)
+void __of_free_phandle_cache_entry(phandle handle);
+#endif
+
 #if defined(CONFIG_OF_OVERLAY)
 void of_overlay_mutex_lock(void);
 void of_overlay_mutex_unlock(void);
-- 
Frank Rowand <frank.rowand@sony.com>

