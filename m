Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00031C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94CD0214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="LTtqlT3z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94CD0214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbeIRUbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:31:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35178 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeIRUbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:31:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so2477564wre.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=tWAJ5ehl8dkATEE7czTzScLiB0dlXRdfPp0umosaGuU=;
        b=LTtqlT3zxcMbaZVUVo+4e5FE8E1TZmQ+zakuBP0B0iahmtRMMrEEvZf72jLmUtzuz6
         C5qkjIlsbDVtHz1zN7J2EviJe2f/v4nPZ/VxxRODKKxgbcI6G4dsqKHVQEKJR2+uDDhQ
         W1PjEJaE2qyBtYotawrs/MLY0VMsjTWy6gCKpx4iqwyTDlz3/pzoKv8f/Lu4rs9GlBMZ
         cHSHUamBDCeBet/T8LhcCNN9Vdr/B1N+Z5UoeIm1mxDlbJsroh0qyhv5JQeclkOMQDnf
         PzGk5DV40GBtzE0nWgy3NgZc5y/eYnY/KT+7GK0QqKu4ddEWUCMeZIMwvEPydMLAWMKP
         4gaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=tWAJ5ehl8dkATEE7czTzScLiB0dlXRdfPp0umosaGuU=;
        b=jaNs1UDNUdrrIuvHLSE2aXFdSnw9oSJM9YYmQvf9/XeJBCOWw/finEVF/brBJHKMI2
         U9En1lX/X6aIbiRHN5/KUTiCFcYgE/R+cBWV5+koN9D3jRc/HMSHUA+bSEdNPnskyCHx
         ZoAGjOOYZKkYrYBUP55tn1CdFdiKeiRtp8ilntFeeDK4Z7QLBllf66Es5IBBL/R48OHQ
         nZtY6PvkNvaVe+lfTa3ihPc4lGEVB97N+elDNQDAvDtHhMiu375SqioyAiQ4ce8c7qME
         1regLASqHLbVSxRt9D+sBQtoh9uuZQ4+Rlxav/77W8rMTeT3Q2WE1zRZAqhdFXmugKKN
         VVqg==
X-Gm-Message-State: APzg51AmpxgwVbaWHO6i7b0YaALeiSMLIp5mjFUFDqgwBXABegqJTAAo
        ip3Ki++IkEn2TUoly+z2VBOKnCp81IIy7A==
X-Google-Smtp-Source: ANB0VdayaGVHKUd0YtC4fHViLEpEZOcYtHFbCxycH/Vx1YZ6zVE2QwHPLgmj3udFpoW81M7lJHJiCQ==
X-Received: by 2002:a5d:448d:: with SMTP id j13-v6mr24210017wrq.236.1537282680986;
        Tue, 18 Sep 2018 07:58:00 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id o14-v6sm12697973wrp.57.2018.09.18.07.58.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 07:58:00 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v3 1/2] of: base: Introduce of_alias_get_alias_list() to check alias IDs
Date:   Tue, 18 Sep 2018 16:57:58 +0200
Message-Id: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537282676.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function travels the lookup table to record alias ids for the given
device match structures and alias stem.
This function will be used by serial drivers to check if requested alias
is allocated or free to use.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v3:
- Fix subject s/of_alias_check_id/of_alias_get_alias_list/
- And also fix commit message description to match
  of_alias_get_alias_list()
- mark empty function with inline

Changes in v2:
- Add empty function for !CONFIG_OF case
- Add return to that function
- Add Rob's Reviewed-by tag

Based on discussion with Rob
https://lkml.org/lkml/2018/4/27/397
nbits is passed to the function not to limit only to 32/64bit fields.

Greg: Please apply this together with serial: uartps: Change uart ID
port allocation. Rob is fine with that (link above)

---
 drivers/of/base.c  | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h | 10 ++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 74eaedd5b860..33011b88ed3f 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/bitmap.h>
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/cpu.h>
@@ -1943,6 +1944,57 @@ int of_alias_get_id(struct device_node *np, const char *stem)
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
+ *
+ * Return:	0 or -ENOSYS when !CONFIG_OF
+ */
+int of_alias_get_alias_list(const struct of_device_id *matches,
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
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(of_alias_get_alias_list);
+
+/**
  * of_alias_get_highest_id - Get highest alias id for the given stem
  * @stem:	Alias stem to be examined
  *
diff --git a/include/linux/of.h b/include/linux/of.h
index 99b0ebf49632..d51457b40725 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -392,6 +392,9 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
+extern int of_alias_get_alias_list(const struct of_device_id *matches,
+				   const char *stem, unsigned long *bitmap,
+				   unsigned int nbits);
 
 extern int of_machine_is_compatible(const char *compat);
 
@@ -893,6 +896,13 @@ static inline int of_alias_get_highest_id(const char *stem)
 	return -ENOSYS;
 }
 
+static inline int of_alias_get_alias_list(const struct of_device_id *matches,
+					  const char *stem, unsigned long *bitmap,
+					  unsigned int nbits)
+{
+	return -ENOSYS;
+}
+
 static inline int of_machine_is_compatible(const char *compat)
 {
 	return 0;
-- 
1.9.1

