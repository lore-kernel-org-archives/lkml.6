Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4829FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BE42084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsSxbB6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbeLQH5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:57:02 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34517 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731576AbeLQH44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:56:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so5972681pfg.1;
        Sun, 16 Dec 2018 23:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=au8EiM8byvG0y1Hv7QLp0mVhGQvk710Vc9STgbc0N48=;
        b=PsSxbB6wTE0H5YQel8vnGmdkBREnOOdX8oEXQV5qc4BPK9ICS3ZUIkqSzgfXDJWA9g
         P7zC+UyxG+QZb1UZXKBYY6kvIHG+2VJZY1OOc1dGLe0ImXR4Dx/huuuFSdCTaZspGQ9u
         Otqq8R0osb9hgOmUdLad3l200yl25gE5KIWQPVz/Hdbtqlrogx2nYoXkRaVOJ9wjCEyl
         JkvDF17KCT8l4v+F7TDAe7qkHLA37awgSAUUslMdCKROfYlH8v7Vpf+eYBq9xy9U17Iv
         MCZMPUb+PDDg1TiTWOuLJvB3H5qotK6oj/Y245vK/u6kpxd+e/vk60Irnv3BfbPs78xl
         hwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=au8EiM8byvG0y1Hv7QLp0mVhGQvk710Vc9STgbc0N48=;
        b=F3KwuHgtZ694Y45Yfi+lRWwBHzevEnaDREIlLr7WpHGTCXx7uraaDyUZYR3btaMpJv
         WsoVsaI3iaxBqbgTspmPy13oaix4IHI5DEBHHDAYWhtcLyX2YUiibQfdEGfMGo8UtDG+
         fY9Ibg6dsCsX2rM4QiWiNfSbfdRrll4wqKqCizMQNdvl4WtB4LVOGqlkx9kNjnbSCAh8
         zAkUC5JP9FweeZ5EKmK90j21lWAENNfTScO9UbJSql2am1SQ5YT87SR/RjMMqjPlEKiT
         /ejsgnl6fOAGWN21V/pCPFIs25lPZzQSrElm8mmKdHLzcb1wdrU0VR0qBjIPKu5el1Bw
         8ZCg==
X-Gm-Message-State: AA+aEWbH2ziyotvguVdM2MF9M7vNhxiOg2TfBNhp3HzuzjIkKa68zQKt
        hCNBtmxmBfLVQsNCjA1eS6vSBTSe
X-Google-Smtp-Source: AFSGD/VITzx/iT2E843sYjhHKQvhXFgUaF/GLt0spXhxUmG9dVpChMUCC1mF6fbGF5mDYuwFW11zVA==
X-Received: by 2002:a62:220d:: with SMTP id i13mr11892705pfi.162.1545033415905;
        Sun, 16 Dec 2018 23:56:55 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r8sm14216610pgr.48.2018.12.16.23.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 23:56:55 -0800 (PST)
From:   frowand.list@gmail.com
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] of: __of_detach_node() - remove node from phandle cache
Date:   Sun, 16 Dec 2018 23:56:36 -0800
Message-Id: <1545033396-24485-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
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

changes since v1:
  - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()

 drivers/of/base.c       | 30 +++++++++++++++++++++++++++++-
 drivers/of/dynamic.c    |  3 +++
 drivers/of/of_private.h |  4 ++++
 3 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6c33d63361b8..ad71864cecf5 100644
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
@@ -1209,11 +1230,18 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 		if (phandle_cache[masked_handle] &&
 		    handle == phandle_cache[masked_handle]->phandle)
 			np = phandle_cache[masked_handle];
+		if (np && of_node_check_flag(np, OF_DETACHED)) {
+			WARN_ON(1);
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

