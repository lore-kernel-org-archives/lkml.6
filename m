Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A04ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCBA214FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I3jtGw4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCBA214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbeIQXon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:44:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38473 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeIQXom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:44:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id u11-v6so7804279plq.5;
        Mon, 17 Sep 2018 11:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8mNCJS03Mr9/67bWJUwh5jkftsqLb++Nk1K1auq53Y=;
        b=I3jtGw4fD0wpL80B4RZaxWxWhB5Wy9PjM5O0FPyBPWUbaXkrEHwrvss0c6BUN7FTEi
         /7H2MulVUabnqIX6Db9ZG6UAEv/1uxiHuA+9K7zkDDGjFPOrZUxdRk6ZCrTY0/2BgChR
         L1FKYI4FdrI56p5wKDbTMn5sZr6QpJJdxR/ykFQ4MRNPL0DiEFK0cQdHAnAJiW7s5NkJ
         2WIMsqO7jp5AWjOxh6uyJg95GG8hihp2fZxbmIcNxyMD5jsCVUofy0JAk1VirgLaHXPu
         LV/+rYzOJ2Bk1siJLxAKR4T+WBoTTHcwAIw/3k1MAhYKhiAXPNcrjl9F0IdokYV1rK9P
         TE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8mNCJS03Mr9/67bWJUwh5jkftsqLb++Nk1K1auq53Y=;
        b=dUsRRfBaQ8bVbxFg4JpYUcunY07Zhh6CywXywvs4Kxprk74xydOqIY6bPjMesxBMkY
         bSua0urZ7j9WbABEVT+vWohhM23SMqsEE+9zc7N5kNB72l16kY1Gzbtib0LCUWtY9Tfl
         wzkM63WCaL130bM1FtXcUl2qGDMmapBbPCKx2a0MH4xnYxEEaGEC3+B/CZ2igxwVA0Ui
         aH5nEoHhgTqeZeUFZF6S9eyra4VXlzNkPidIjhMFXeN7dqzoE15FtaAOHVbuJQP0b5VB
         YskRLiu1G/kbZkxAgSWazFfjU58/0MW8H0LIalOc8SFP1txrypF5VB88xOUhB2oehzHb
         GaiA==
X-Gm-Message-State: APzg51A0vboBTmTGQGCpeI+7jQaPlVCKMc44EO6EOxYLCCdDDTPNzDFL
        50mYLl1mff3b+l7z4EKESFA=
X-Google-Smtp-Source: ANB0VdYJh0/BnClHmiPjbt4L1btxq+Ee0x+g73dY8RrCJO1u+NIHJ73Laat6r1hRRQxzT0TVOCVk3g==
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr25788070plf.320.1537208172276;
        Mon, 17 Sep 2018 11:16:12 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 74-v6sm24076366pfv.33.2018.09.17.11.16.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 11:16:10 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RFC/PATCH 3/5] device property: export property_set structure
Date:   Mon, 17 Sep 2018 11:16:01 -0700
Message-Id: <20180917181603.125492-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Future gpiolib will need to handle property sets properly, and this we
need to export property_set, is_pset_node() and to_pset_node().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/base/pset_property.c | 31 ++-----------------------------
 include/linux/property.h     | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
index 63f2377aefe8..7118528816a4 100644
--- a/drivers/base/pset_property.c
+++ b/drivers/base/pset_property.c
@@ -14,34 +14,6 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-struct property_set {
-	struct device *dev;
-	struct fwnode_handle fwnode;
-	const struct property_entry *properties;
-
-	struct property_set *parent;
-	/* Entry in parent->children list */
-	struct list_head child_node;
-	struct list_head children;
-};
-
-static const struct fwnode_operations pset_fwnode_ops;
-
-static inline bool is_pset_node(const struct fwnode_handle *fwnode)
-{
-	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
-}
-
-#define to_pset_node(__fwnode)						\
-	({								\
-		typeof(__fwnode) __to_pset_node_fwnode = __fwnode;	\
-									\
-		is_pset_node(__to_pset_node_fwnode) ?			\
-			container_of(__to_pset_node_fwnode,		\
-				     struct property_set, fwnode) :	\
-			NULL;						\
-	})
-
 static const struct property_entry *
 pset_prop_get(const struct property_set *pset, const char *name)
 {
@@ -323,13 +295,14 @@ pset_fwnode_get_next_subnode(const struct fwnode_handle *fwnode,
 	return &next->fwnode;
 }
 
-static const struct fwnode_operations pset_fwnode_ops = {
+const struct fwnode_operations pset_fwnode_ops = {
 	.property_present = pset_fwnode_property_present,
 	.property_read_int_array = pset_fwnode_read_int_array,
 	.property_read_string_array = pset_fwnode_property_read_string_array,
 	.get_parent = pset_fwnode_get_parent,
 	.get_next_child_node = pset_fwnode_get_next_subnode,
 };
+EXPORT_SYMBOL_GPL(pset_fwnode_ops);
 
 static void property_entry_free_data(const struct property_entry *p)
 {
diff --git a/include/linux/property.h b/include/linux/property.h
index bb1cf4f30770..957f75d10cf9 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -13,6 +13,7 @@
 #ifndef _LINUX_PROPERTY_H_
 #define _LINUX_PROPERTY_H_
 
+#include <linux/err.h>
 #include <linux/fwnode.h>
 #include <linux/types.h>
 
@@ -281,6 +282,34 @@ device_add_child_properties(struct device *dev,
 			    const struct property_entry *properties);
 void device_remove_properties(struct device *dev);
 
+struct property_set {
+	struct device *dev;
+	struct fwnode_handle fwnode;
+	const struct property_entry *properties;
+
+	struct property_set *parent;
+	/* Entry in parent->children list */
+	struct list_head child_node;
+	struct list_head children;
+};
+
+extern const struct fwnode_operations pset_fwnode_ops;
+
+static inline bool is_pset_node(const struct fwnode_handle *fwnode)
+{
+	return !IS_ERR_OR_NULL(fwnode) && fwnode->ops == &pset_fwnode_ops;
+}
+
+#define to_pset_node(__fwnode)						\
+	({								\
+		typeof(__fwnode) __to_pset_node_fwnode = __fwnode;	\
+									\
+		is_pset_node(__to_pset_node_fwnode) ?			\
+			container_of(__to_pset_node_fwnode,		\
+				     struct property_set, fwnode) :	\
+			NULL;						\
+	})
+
 bool device_dma_supported(struct device *dev);
 
 enum dev_dma_attr device_get_dma_attr(struct device *dev);
-- 
2.19.0.397.gdd90340f6a-goog

