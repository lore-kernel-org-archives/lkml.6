Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5569A21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 19:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvdIx7sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeLRTk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 14:40:29 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33374 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbeLRTk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 14:40:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id c123so8623726pfb.0;
        Tue, 18 Dec 2018 11:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QpdzDwSrsWE9LXF201TGBe/ML0bWOkO30Z8/kF7nPbI=;
        b=EvdIx7sWsnq7Qd2RW6u2Z4I/D44oPaP+GN0NKdh4xQu/pkczHfeotGbP3nFcVxvMsG
         OPcLpMUsddriRtjWdND7o4rcEx1DqEGmg0ILZRsfUAhC/nNiEustJdyjZjMb+aMkGIQU
         3U9g13bmUnCk1GmBZMZ3XLoMc4W1NT2Ck+P2R2NbV9BDbLLir4KtUzwyBAANz8QRk3+Y
         mZiPI4TZ497fQaSLNk9bNZWlkkigj6xXjwTcBy9dvxJAEtZ5k8a0GQ37UrTUhl/fXF4/
         /WPO1QykFrvQEAEY6qhkucoLrA3jQZk7zpU5KS42Afdm7PTRHHA1WTBGDBcilmlmxX8K
         slRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QpdzDwSrsWE9LXF201TGBe/ML0bWOkO30Z8/kF7nPbI=;
        b=sG9Feo9mYG7mG13Vk+2bnK7mNTXcDngAM8WTBj/Yl+BBpVdD7jfuMcEYBNyuZi23fE
         S80j0Aypl+PwvpsShpFt1VunWwZZcwu2jBqbzBpBkSqXkpdGQJP3OH3DBenwVQjjLf0h
         RMs3wjNImb2iwxnPWwMzHNBv6ADbx6TTE1lZM5yp6ARPAGWvHDY56BmqD6wEJcCGNYv/
         VKMnBniL85tZGwe2mFZ1PjSoDWXItNbxt+BJw8+Ajz9yLpVAaZ97pU0JnMeMYGuwxIrH
         JB8zflls4bQK+8RCTUmY1NeWeB/62zIgKFzoyb5CciUteBc09tQpVTWx97nG6qOmQ5Ka
         0biQ==
X-Gm-Message-State: AA+aEWZ/ondGjf5XlSB850gDiBsbQLbd+J6lrrVOvehI1V/G2klA/5Hi
        q/vqeLxozRjgij9H1hA8pCgV7xwg
X-Google-Smtp-Source: AFSGD/X7r9rnl1lgUNF7y1OGGMPqwJhmkVLN4/TzO8AAq32RmiBacasxsRfARiAyiD939uyB5i3dhg==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr422078pgl.186.1545162025672;
        Tue, 18 Dec 2018 11:40:25 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id b202sm29493069pfb.88.2018.12.18.11.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 11:40:25 -0800 (PST)
From:   frowand.list@gmail.com
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] of: __of_detach_node() - remove node from phandle cache
Date:   Tue, 18 Dec 2018 11:40:03 -0800
Message-Id: <1545162003-11577-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
References: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
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

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Reported-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

do not "cc: stable", unless the following commits are also in stable:

  commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")
  commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
  commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")


Changes since v2:
  - add temporary variable np in __of_free_phandle_cache_entry() to improve
    readability
  - explain reason for WARN_ON() in comment
  - add Fixes tag in patch comment

 drivers/of/base.c       | 31 ++++++++++++++++++++++++++++++-
 drivers/of/dynamic.c    |  3 +++
 drivers/of/of_private.h |  4 ++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6c33d63361b8..6d20b6dcf034 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -162,6 +162,28 @@ int of_free_phandle_cache(void)
 late_initcall_sync(of_free_phandle_cache);
 #endif
 
+/*
+ * Caller must hold devtree_lock.
+ */
+void __of_free_phandle_cache_entry(phandle handle)
+{
+	phandle masked_handle;
+	struct device_node *np;
+
+	if (!handle)
+		return;
+
+	masked_handle = handle & phandle_cache_mask;
+
+	if (phandle_cache) {
+		np = phandle_cache[masked_handle];
+		if (np && handle == np->phandle) {
+			of_node_put(np);
+			phandle_cache[masked_handle] = NULL;
+		}
+	}
+}
+
 void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
@@ -1209,11 +1231,18 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 		if (phandle_cache[masked_handle] &&
 		    handle == phandle_cache[masked_handle]->phandle)
 			np = phandle_cache[masked_handle];
+		if (np && of_node_check_flag(np, OF_DETACHED)) {
+			WARN_ON(1); /* did not uncache np on node removal */
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

