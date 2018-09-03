Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE10DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD3220867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 13:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="z+uQTwCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AD3220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeICRem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 13:34:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeICRel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 13:34:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so640472wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 06:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=vC4HsHePbrA9MYsdl4gN76KQEIHRgKq1X2b6kUfPv6Y=;
        b=z+uQTwCuXYfYEaKJPB6x5PRld2Y4QSypDMGlgk5WwlvWI1jfER99sRBYEp/sDaYuX4
         nRxYW3QZ3Vz5YkTQ0IUC5ugDJHzBjVdC4hkgMgK0CCZSYNBetEHsKklckvW+rHDw+S5T
         2eIEvZMANtcVxXDcJcn7Qh5DGKv6wQdwJp7Z+RqsHmaJghuHDAISy1q6uiAwOj4MQV7r
         LHbaJJOEwu3APVsS97LTEalm4rJ6/UIXG66ZteWPq2kkqEi5GWsgaUBIFd8Sym7UTKR7
         my5QCa6JJohIDcOxGHoDIj3STd+GNfxj1OW95N3jVO+lQn2UcXgpLDLE+Hrijk/bpBbz
         B3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=vC4HsHePbrA9MYsdl4gN76KQEIHRgKq1X2b6kUfPv6Y=;
        b=tIppgyU5//Yz2kwhRa9ukUAZghBJ7RmIEbVXeU6m02ultfLY9KXwA9bcTI3HDWEzxj
         2NOV+yTfXrp7u1bW4hzLR4OFUCN/g6ZvwTXBJLhOF+mi01fu/tc6tEqtw7DH8lVxHZbb
         mr6HZWcXrbfO8vE4I70guDTPGXx+7V2qeSPcXWe+f2UMTJ6KM0Xz96yB1xm5ijJulfov
         OqGHYHmYG0A9+mKt/jSsJlQUhj/21s24Z+TFj5I8MLdbH8F8+1QLxDViJuqJUfpCwO8W
         ta6q/XzPkOjEJ0DEi6FM2T6K6Co1NQYKXaxQr9OnYci1ae1/D/mUemwhH4cwM2z42MBN
         cXSg==
X-Gm-Message-State: APzg51Cji3L8YyJJovFfOjMQTd8LI4UiRcdXj7YEaiP19+jeyEW6vddy
        LH8J8hePdGF7UjVkv3uzt0hYOyJ82IJq5Q==
X-Google-Smtp-Source: ANB0VdbOPjurU9fMVLjCfMfrxhSvHbxOLHvNIfi0MmCCF/SYjIhFh583aKxKzFyl7DBtwE/rg7ofjg==
X-Received: by 2002:adf:bd90:: with SMTP id l16-v6mr19908922wrh.250.1535980472750;
        Mon, 03 Sep 2018 06:14:32 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 185-v6sm14766512wmy.38.2018.09.03.06.14.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 06:14:32 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 1/2] of: base: Introduce of_alias_check_id() to check alias IDs
Date:   Mon,  3 Sep 2018 15:14:29 +0200
Message-Id: <0ee4683a7d3927c2ef20b1e106720e6154811cd7.1535980468.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function travers the lookup table to check if the request alias
id is compatible with the device driver match structure.
This function will be used by serial drivers to check if requested alias
is allocated or free to use.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Based on discussion with Rob
https://lkml.org/lkml/2018/4/27/397
nbits is passed to the function not to limit only to 32/64bit fields.

---
 drivers/of/base.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h |  3 +++
 2 files changed, 51 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 466e3c8582f0..236a85d69957 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/bitmap.h>
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/cpu.h>
@@ -1893,6 +1894,53 @@ int of_alias_get_id(struct device_node *np, const char *stem)
 EXPORT_SYMBOL_GPL(of_alias_get_id);
 
 /**
+ * of_alias_get_alias_list - Get alias list for the given device driver
+ * @matches:	Array of OF device match structures to search in
+ * @stem:	Alias stem of the given device_node
+ * @bitmap:	Bitmap field pointer
+ * @nbits:	Maximum number of alias ID which can be recorded it bitmap
+ *
+ * The function travels the lookup table to record alias ids for the given
+ * device match structures and alias stem.
+ */
+void of_alias_get_alias_list(const struct of_device_id *matches,
+			     const char *stem, unsigned long *bitmap,
+			     unsigned int nbits)
+{
+	struct alias_prop *app;
+
+	/* Zero bitmap field to make sure that all the time it is clean */
+	bitmap_zero(bitmap, nbits);
+
+	mutex_lock(&of_mutex);
+	pr_debug("%s: Looking for stem: %s\n", __func__, stem);
+	list_for_each_entry(app, &aliases_lookup, link) {
+		pr_debug("%s: stem: %s, id: %d\n",
+			 __func__, app->stem, app->id);
+
+		if (strcmp(app->stem, stem) != 0) {
+			pr_debug("%s: stem comparison doesn't passed %s\n",
+				 __func__, app->stem);
+			continue;
+		}
+
+		if (app->id >= nbits) {
+			pr_debug("%s: ID %d greater then bitmap field %d\n",
+				__func__, app->id, nbits);
+			continue;
+		}
+
+		if (of_match_node(matches, app->np)) {
+			pr_debug("%s: Allocated ID %d\n", __func__, app->id);
+			set_bit(app->id, bitmap);
+		}
+		/* Alias exist but it not compatible with matches */
+	}
+	mutex_unlock(&of_mutex);
+}
+EXPORT_SYMBOL_GPL(of_alias_get_alias_list);
+
+/**
  * of_alias_get_highest_id - Get highest alias id for the given stem
  * @stem:	Alias stem to be examined
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 4d25e4f952d9..e474710e3930 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -387,6 +387,9 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
+extern void of_alias_get_alias_list(const struct of_device_id *matches,
+				    const char *stem, unsigned long *bitmap,
+				    unsigned int nbits);
 
 extern int of_machine_is_compatible(const char *compat);
 
-- 
1.9.1

