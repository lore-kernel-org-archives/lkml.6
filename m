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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F0C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1284B204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 06:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlhK6C1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1284B204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeLNGnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 01:43:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33951 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNGnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 01:43:09 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so2364563pfg.1;
        Thu, 13 Dec 2018 22:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SrNwE1dsifW+PsaKdjrVC/A0/dZpx7t1MCORIh/eIU4=;
        b=IlhK6C1G2zL+Jchbrki+gADoEfLEGQwDdkBAEDDgoHh3Wm4UUyLD97TEo3XpX9xBmk
         +EnOcmsP/Tk9omSStXWxULRVWO+zi+GDI/JQwPt43fiASOUu7bcuLOUHmQM2QkThLsnC
         yKcIb7v7th3wz70me/Jntp//JVP2mu0Fp7FfiqgK8qQD67A7gTXyuQte7B2GL+Rn8tVH
         3sZAfKrmQhOAgqCgRtTsCRlHcjT8D0Bo1T+2d/cYH96qEJmB4t8U8k9PIaa6NW+IdQbb
         +M4QnR/yXvIAihMN3uoi4YemCKvGOsvGAuaijkpeEC1HxPTLHKn/Ph1LbEx4ruiYmf0I
         59OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SrNwE1dsifW+PsaKdjrVC/A0/dZpx7t1MCORIh/eIU4=;
        b=YJ+a2DmJf6aqmh/VOGtCLEjYGjay7KVHcGV19J2iEzX2CRSZTS0PWQ9J/GBtbQvVXG
         iAScFRGPuE8i2V0TgnmFgzd26LW7rsGn+6FhWPiHMLu/+BQZ/zlOxlF6+xtr81IH0MHZ
         tJz0akVpDl7ieB0Sbwf58YAalyJFbPjl6eCT+p+cDTunaPNiUc4qy75rrEO6esdjBKtJ
         Uv5K2jRHVMrqOGdTibt5nYcq778X3eEz3jeN5RRuh/grJgQ6x76GDtKOYGqlCLNoVEGo
         XpoqXoz3zzILvMAr9EPb/JPYA+8ATx5ULQRtiE52vKFGwa1JS+R9B+VaWj06GKz0IBtc
         fcGA==
X-Gm-Message-State: AA+aEWaa+8JF8Gn6Ysls3i0gybxHKY5y++vYGt6WpjCLy+ZZmOidpsmd
        YQvdsUhCTAApEIBVRDqgzOw=
X-Google-Smtp-Source: AFSGD/VUR1Phk9+hCjoPmSSscts0gfWzBNqvNiX7YCaTZYJD+6GWeqlnJFWa221bH83qYP2CEL3S2w==
X-Received: by 2002:a63:83c1:: with SMTP id h184mr1630881pge.437.1544769788811;
        Thu, 13 Dec 2018 22:43:08 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e16sm5132645pfn.46.2018.12.13.22.43.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Dec 2018 22:43:08 -0800 (PST)
From:   frowand.list@gmail.com
To:     robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] of: of_node_get()/of_node_put() nodes held in phandle cache
Date:   Thu, 13 Dec 2018 22:42:50 -0800
Message-Id: <1544769771-5468-2-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
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

do not "cc: stable", unless the following commits are also in stable:

  commit e54192b48da7 ("of: fix phandle cache creation for DTs with no phandles")
  commit b9952b5218ad ("of: overlay: update phandle cache on overlay apply and remove")
  commit 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")

 drivers/of/base.c | 70 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 24 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 09692c9b32a7..d599367cb92a 100644
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
+void __of_free_phandle_cache(void)
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

