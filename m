Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E9BECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE762147C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY1FI6+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE762147C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732792AbeGLVLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:11:33 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:53693 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732341AbeGLVLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:11:33 -0400
Received: by mail-it0-f68.google.com with SMTP id a195-v6so8760898itd.3;
        Thu, 12 Jul 2018 14:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XH3Iz6kHtbJwD7viiVKJA8q6jh72IeoVAX7OhAgjG+8=;
        b=OY1FI6+1p2/swXsLLha+uKXSoKOJ6cRb9sv9a2HSNQnsKqlGC43SKn9z5y4QJcxWwT
         dQOmL88S2bHnlLYNd5aYi7LOWKFTMAlJIeSEEdEvbLSFzAisDA+4/CWbEF79YrgrhnHE
         cmN3cTEg/7AoQCk7Q4XgXSHOByWBWU5Rrod1TfjaBX51TYvaFWUJQeHLTFwN7hHFrwhb
         aWVne3u4XHuELMrNTU6GIc3Lf+BmkuhSva4X/z9J56xaBhd43kLklTS/54izIit7qvk8
         rRIVLGjdZMLbVmkYB30saL7OgicX5BgIf/KgrvjwQ0cxlMljdgjnWbSkTiBt8mRNbbPp
         jtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XH3Iz6kHtbJwD7viiVKJA8q6jh72IeoVAX7OhAgjG+8=;
        b=rf5BnJl0WRNL9ejt372QmvgVSxxObm5CByUmsFZVWfXl3g/wC5GkBdqyAtRSvEGt43
         /d4pbzA6ZapJLQRZwPPD2KEy6IE26Os9pfXoGa4S7FbfbMMTwQLr2t2ivT3ftoXveUtM
         MMQb/ESCUaJpYYkGTDZHbYOKey7FQeXcISyHXEZXlcruLetTMQPChkuyt4WLQmZ1ZCRj
         9Ygw6KsB3lxOy1Wp/8w+Zis51tsgB8BzYb1CHVzzlteVgOxikXkZSENoEnqd2yl8WZwS
         pLTP+L4F0NEbUIeH4XjyGR05sIKvJUivfJcE67RqwjBjEzHHaxA62oEfwLZdRu67jUeD
         Wr/Q==
X-Gm-Message-State: AOUpUlE7HEAgr7vd0OpKC5baaQIqqj5LSbrtjMSy5sccBdzUVuhayEJC
        ciIBYTUU8nx/QaIcVwy3Ci11Jw==
X-Google-Smtp-Source: AAOMgpeCm3qT1WeJ1Q1zglqiuHVDwVsfYsmvH/HUY++Hy9cFRqt19XP9tJIIjBeffUqnkEDEF6dsDw==
X-Received: by 2002:a24:360c:: with SMTP id l12-v6mr2638100itl.128.1531429215459;
        Thu, 12 Jul 2018 14:00:15 -0700 (PDT)
Received: from xps15.home (dsl-74-83-93-125.fuse.net. [74.83.93.125])
        by smtp.gmail.com with ESMTPSA id w193-v6sm3484893ita.35.2018.07.12.14.00.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 14:00:14 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Alan Tull <atull@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: [PATCH] of: overlay: update phandle cache on overlay apply and remove
Date:   Thu, 12 Jul 2018 14:00:07 -0700
Message-Id: <1531429207-3245-1-git-send-email-frowand.list@gmail.com>
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

Changes since RFC:
  - update code comment to mention race condition avoidance

For the RFC version of this patch, the 0day test reported a general
protection fault from the KASAN runtime memory debugger on x86_64
in qemu.  The GPF was in a devicetree unittest.

0day tested the patch on v4.17-rc1, with some other patches applied.
I was unable to replicate the GPF on v4.18-rc1 with just this patch
applied.  I was also unable to replicate the GPF on a clone of the
v4.17-rc1 0day repository, using the 0day kernel config.  I will
reply to this email with the 0day GPF report.


 drivers/of/base.c       |  6 +++---
 drivers/of/of_private.h |  2 ++
 drivers/of/overlay.c    | 11 +++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

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
index 7baa53e5b1d7..eda57ef12fd0 100644
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
@@ -1046,8 +1048,17 @@ int of_overlay_remove(int *ovcs_id)
 
 	list_del(&ovcs->ovcs_list);
 
+	/*
+	 * Disable phandle cache.  Avoids race condition that would arise
+	 * from removing cache entry when the associated node is deleted.
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

