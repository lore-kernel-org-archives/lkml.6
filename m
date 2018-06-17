Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE920C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC2820891
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz8MXFS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC2820891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934128AbeFQQEJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:04:09 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38155 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933506AbeFQQEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:04:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id b14-v6so7719210pls.5;
        Sun, 17 Jun 2018 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6SkbvkrlIT/+VYIs+K3O0rVU7WFwFKMeAAjgzKJ6b14=;
        b=iz8MXFS1ioiLa13ptA4wtUZRAXrvy8+XVjYaSNTJAi66ldY1aBvz4Uu5dM1auurw1d
         1Q+ZJNNsj6gzDC7BKy4E1TDWCWiunRqi2QajEwmmo9ao3uenFZ1/eFPiFII5x14dG7RO
         e2dzZvSyP4gBLtUJm3qs26Noz2CemMivRYIST7wMcuP+2XLPbCEjZa53aIkPleTQXFGq
         L5d1amDlcGK+QtauTO+bY149/oQfhnioiuJs81hLBSYQ9DWgpk5V4e8csP1WQ/3b4jNd
         2VpNE3aOIBcwTEKkTi2hPnUspn3paO6Iyw6Q99D9LYp41IcBAKz8SfiZILjEFy2HbPZ1
         xSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6SkbvkrlIT/+VYIs+K3O0rVU7WFwFKMeAAjgzKJ6b14=;
        b=LpnO/YToyVyV3YUoNIkxeVLjg/b+1EaPpTWKm5XKwqAnOA6PoPivZddrKi8qIn9wvf
         esPUxNRnq0KhNZoCX6gny45GLBLxF/acZ1D0SW2U9xrppY5qN7qJ4ArK94y0xekCEMo7
         KgywICnM58kE9mpMP6q9UZaG2z+dVlmZwr2QMEsfqYhBbELpEeVbHI9QRmghUmUgfXMI
         SL6PoCYQc/OhdPh+zuEPpU2/LY9k90OYHIkNy8uYW/gLzsQFJJvi3xnl1SIIhTrSGz1X
         s4TMroS/qX32SZsHL+x2OAHsitzkdlpx0FDtGXFXzEiaKJQDubK1ifUKoqT7PCnCkr7f
         lzEA==
X-Gm-Message-State: APt69E1hyecQjPIlQ+6FdURAGRlV9KVpC8fU8emGpLGoHC0BF7aPC+r0
        Brn8sPjLAqSSIynNKjvBRJQUeg==
X-Google-Smtp-Source: ADUXVKLhrFWMrUA90K2DYrTF7BoDEJ4FkTwLw5IFYzRKp2qHoUXYGGiZ10tXDM7b9w0WbHnaMGyQ7A==
X-Received: by 2002:a17:902:8e87:: with SMTP id bg7-v6mr10524505plb.129.1529251447041;
        Sun, 17 Jun 2018 09:04:07 -0700 (PDT)
Received: from localhost.localdomain (mobile-166-137-176-247.mycingular.net. [166.137.176.247])
        by smtp.gmail.com with ESMTPSA id e5-v6sm14773066pgs.59.2018.06.17.09.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Jun 2018 09:04:06 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [RFC PATCH] of: overlay: update phandle cache on overlay apply and remove
Date:   Sun, 17 Jun 2018 09:03:36 -0700
Message-Id: <1529251416-14814-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

A comment in the review of the patch adding the phandle cache said that
the cache would have to be updated when modules are applied and removed.
This patch implements the cache updates.

Fixes: 0b3ce78e90fc ("of: cache phandle nodes to reduce cost of of_find_node_by_phandle()")
Reported-by: Alan Tull <atull@kernel.org>
Suggested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

Compiles for one configuration.
NOT boot tested.
Not run through my normal process to check for new warnings, etc.

It is late, I'm tired, my brain is fuzzy.  I need to review this more to have
any confidence in it.  But I wanted to get a version out for Alan to see (and
test if he wants).

 drivers/of/base.c       |  6 +++---
 drivers/of/of_private.h |  2 ++
 drivers/of/overlay.c    | 12 ++++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 848f549164cd..466e3c8582f0 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -102,7 +102,7 @@ static u32 phandle_cache_mask;
  *   - the phandle lookup overhead reduction provided by the cache
  *     will likely be less
  */
-static void of_populate_phandle_cache(void)
+void of_populate_phandle_cache(void)
 {
 	unsigned long flags;
 	u32 cache_entries;
@@ -134,8 +134,7 @@ static void of_populate_phandle_cache(void)
 	raw_spin_unlock_irqrestore(&devtree_lock, flags);
 }
 
-#ifndef CONFIG_MODULES
-static int __init of_free_phandle_cache(void)
+int of_free_phandle_cache(void)
 {
 	unsigned long flags;
 
@@ -148,6 +147,7 @@ static int __init of_free_phandle_cache(void)
 
 	return 0;
 }
+#if !defined(CONFIG_MODULES)
 late_initcall_sync(of_free_phandle_cache);
 #endif
 
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 891d780c076a..216175d11d3d 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -79,6 +79,8 @@ int of_resolve_phandles(struct device_node *tree);
 #if defined(CONFIG_OF_OVERLAY)
 void of_overlay_mutex_lock(void);
 void of_overlay_mutex_unlock(void);
+int of_free_phandle_cache(void);
+void of_populate_phandle_cache(void);
 #else
 static inline void of_overlay_mutex_lock(void) {};
 static inline void of_overlay_mutex_unlock(void) {};
diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 7baa53e5b1d7..3f76e58fbec4 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -804,6 +804,8 @@ static int of_overlay_apply(const void *fdt, struct device_node *tree,
 		goto err_free_overlay_changeset;
 	}
 
+	of_populate_phandle_cache();
+
 	ret = __of_changeset_apply_notify(&ovcs->cset);
 	if (ret)
 		pr_err("overlay changeset entry notify error %d\n", ret);
@@ -1046,8 +1048,18 @@ int of_overlay_remove(int *ovcs_id)
 
 	list_del(&ovcs->ovcs_list);
 
+	/*
+	 * Empty and disable phandle cache.  Must empty here so that
+	 * changeset notifiers do not use stale cache entry for a removed
+	 * phandle.
+	 */
+	of_free_phandle_cache();
+
 	ret_apply = 0;
 	ret = __of_changeset_revert_entries(&ovcs->cset, &ret_apply);
+
+	of_populate_phandle_cache();
+
 	if (ret) {
 		if (ret_apply)
 			devicetree_state_flags |= DTSF_REVERT_FAIL;
-- 
Frank Rowand <frank.rowand@sony.com>

