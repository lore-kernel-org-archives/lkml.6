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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F4C2084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 07:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqHNmOrv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeLQH46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 02:56:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34819 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeLQH4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 02:56:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so5748765plo.2;
        Sun, 16 Dec 2018 23:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IjwDbTS/z4KBFIXquKZ/wO5Kv02klbSOetli+9vOaNc=;
        b=KqHNmOrvGwcJtyxcs+bLRIXLWzVX36HkNJGLRrfUR3CEKBqXsklbYR8C/KA3IZlnWc
         FhT2iZq68uXcJra2JRQaCR/mofFsGze1c2WyGlMnVsWOYCo4Wcs1px01cXn7jc65rK0r
         vUUkqslHiEp2qW0jnK3exTlgppFkm+6Ef8gjP2dlsWvh7PtMAdgKML5jRGUFQ1+AAQiY
         qX64KCYho5j38we+2uf1hPVAo+CrPmCGBC49ZG4I28MFDJ4IMGOUiXB+tjZS4gABlODB
         TleAV3VEoo5GNiyJ8W7bTz/JLFcBuXoM3L0YgfaH8DRx1qOno+A9wSYov+WbgxISo3Yu
         97nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IjwDbTS/z4KBFIXquKZ/wO5Kv02klbSOetli+9vOaNc=;
        b=n5M5vVOxB90TNTBg0g9fyyv4xjbHcbkgWzyWTO+ODS4TKtLqCN+obVCYKXBfI3gBnU
         4hRvshAQFY/DHH5Ew6FDyXWve++p8Omeyj/2PBDsJIMFyEhmF/whlpdcYjPLd0Bpz0Qu
         QsODOOMSS03Lw3Jq21mx0A3TRF6v/PiShlKMD5+4jDNl+48kh923CA/WT/70hXWN73Oc
         j0f8A1M97D85WlLhVheTfc5WB5TIVjodmn2hMONq9It9CpD0cnC5yO9vZYTh6twV3ggR
         V3Do2H4Kwjr+oTmC6e0O3PQ1b+8y0SLC7LGOWVJDvSL2BEbUpqRLtwZI0iUsI4ZpWjME
         h21w==
X-Gm-Message-State: AA+aEWZWAOBz9DGe9Y9PXgvnG3ZH7nNZyuwqLVS+Txrs1SRZtsjmmUpW
        gNmwJm795UjorB17f0TJWXU=
X-Google-Smtp-Source: AFSGD/VzadQ7KllZWniZ0SFntweMpX+J7hhizCMBCQ81Z8FIwynVKUz+AnTwbjeju7NabFGK7OQK1g==
X-Received: by 2002:a17:902:724a:: with SMTP id c10mr12061675pll.51.1545033414561;
        Sun, 16 Dec 2018 23:56:54 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id r8sm14216610pgr.48.2018.12.16.23.56.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 16 Dec 2018 23:56:54 -0800 (PST)
From:   frowand.list@gmail.com
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] of: of_node_get()/of_node_put() nodes held in phandle cache
Date:   Sun, 16 Dec 2018 23:56:35 -0800
Message-Id: <1545033396-24485-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
References: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

The phandle cache contains struct device_node pointers.  The refcount
of the pointers was not incremented while in the cache, allowing use
after free error after kfree() of the node.  Add the proper increment
and decrement of the use count.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

changes since v1
  - make __of_free_phandle_cache() static

 drivers/of/base.c | 70 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 09692c9b32a7..6c33d63361b8 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -116,9 +116,6 @@ int __weak of_node_to_nid(struct device_node *np)
 }
 #endif
 
-static struct device_node **phandle_cache;
-static u32 phandle_cache_mask;
-
 /*
  * Assumptions behind phandle_cache implementation:
  *   - phandle property values are in a contiguous range of 1..n
@@ -127,6 +124,44 @@ int __weak of_node_to_nid(struct device_node *np)
  *   - the phandle lookup overhead reduction provided by the cache
  *     will likely be less
  */
+
+static struct device_node **phandle_cache;
+static u32 phandle_cache_mask;
+
+/*
+ * Caller must hold devtree_lock.
+ */
+static void __of_free_phandle_cache(void)
+{
+	u32 cache_entries = phandle_cache_mask + 1;
+	u32 k;
+
+	if (!phandle_cache)
+		return;
+
+	for (k = 0; k < cache_entries; k++)
+		of_node_put(phandle_cache[k]);
+
+	kfree(phandle_cache);
+	phandle_cache = NULL;
+}
+
+int of_free_phandle_cache(void)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&devtree_lock, flags);
+
+	__of_free_phandle_cache();
+
+	raw_spin_unlock_irqrestore(&devtree_lock, flags);
+
+	return 0;
+}
+#if !defined(CONFIG_MODULES)
+late_initcall_sync(of_free_phandle_cache);
+#endif
+
 void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
@@ -136,8 +171,7 @@ void of_populate_phandle_cache(void)
 
 	raw_spin_lock_irqsave(&devtree_lock, flags);
 
-	kfree(phandle_cache);
-	phandle_cache = NULL;
+	__of_free_phandle_cache();
 
 	for_each_of_allnodes(np)
 		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
@@ -155,30 +189,15 @@ void of_populate_phandle_cache(void)
 		goto out;
 
 	for_each_of_allnodes(np)
-		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL)
+		if (np->phandle && np->phandle != OF_PHANDLE_ILLEGAL) {
+			of_node_get(np);
 			phandle_cache[np->phandle & phandle_cache_mask] = np;
+		}
 
 out:
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 }
 
-int of_free_phandle_cache(void)
-{
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&devtree_lock, flags);
-
-	kfree(phandle_cache);
-	phandle_cache = NULL;
-
-	raw_spin_unlock_irqrestore(&devtree_lock, flags);
-
-	return 0;
-}
-#if !defined(CONFIG_MODULES)
-late_initcall_sync(of_free_phandle_cache);
-#endif
-
 void __init of_core_init(void)
 {
 	struct device_node *np;
@@ -1195,8 +1214,11 @@ struct device_node *of_find_node_by_phandle(phandle handle)
 	if (!np) {
 		for_each_of_allnodes(np)
 			if (np->phandle == handle) {
-				if (phandle_cache)
+				if (phandle_cache) {
+					/* will put when removed from cache */
+					of_node_get(np);
 					phandle_cache[masked_handle] = np;
+				}
 				break;
 			}
 	}
-- 
Frank Rowand <frank.rowand@sony.com>

