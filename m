Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6CFECE560
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E120E2146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 11:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="aFLw3mkj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E120E2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeIRRXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 13:23:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36944 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeIRRXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 13:23:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id u12-v6so1762927wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 04:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=L/55MlbjPfdwGtl3muNIrxq3cAmFvpsTguv/ZCNVV/g=;
        b=aFLw3mkjFIWjjqkp25orQdkV3HjOYUl0WBw3PVPE/vsgEEjXQ7AC9/mckbzuVoCVCh
         w887kFgjDWKzgS+o2cWn79/Nf1p1wnwCLQsSHGvEF+g2GHIdYsEFTEfPKT7nH581jtTv
         IGhmXV7v3BU88m/fwySR6qH/Wrzpcpk3/9ex/02PvKEXhdN7YbhiR1/umzPrxEqCHc7Z
         ZwY2m5N+C2Oxcbhm1UhVK4YsZazV2WDWj1mdy2zDCj7HcMvQZGq0eRhgqA7lFrQm2+mr
         2THMG9ue4m1CdYeItfXAnRHDWVwgYOA6pxHeL1dbvcEX+MVDAzOX5wf5o6FxQ4zeuE1W
         I/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=L/55MlbjPfdwGtl3muNIrxq3cAmFvpsTguv/ZCNVV/g=;
        b=AL0rC4mu/NuxcU3dzSn7G18146IfltMm9eWRoszoDTY3Hf//rfuBEkyvoyGsQBAJ33
         iyNEgpU12bsWA9JeI/+LT9G+nHFSPjmspiPGj1ziRhsiyr3P0ic/i0BKXjFrXAFWIHtD
         6TrlzFScttGLnQyAzhApc4HsxGwZP53fI7qEy/wybfxTTcaKLKZDg82M0AjqHh7RFPFM
         CVxsGIZWxQ5ntSWE/csXB3dEZm/AFYNTEo5q3lM6ixqZ5O2ybcToFoAlVFfUgCKPD+48
         obLiEKp0s6WPWsw4rNpbDPNtWJ/hdgt7tdzIIg9kUQIqzqfhIClXU9GVHcRLQiHahUx/
         Wd3Q==
X-Gm-Message-State: APzg51B3Drw3Kpoph4TF0u/WwgdcIHUr2bE5vxp0KIq7xa5f2X9vjmqM
        oyM6tIZqhCjE2/gmim2nKBCut4cZ+rtkmQ==
X-Google-Smtp-Source: ANB0VdbjGv16Zv213vp/MVRBy6l+8hmKu03gYetqhMH9LDUkfoYkn4bR/ixjUy0R3p0RkL914BGP2g==
X-Received: by 2002:a05:6000:81:: with SMTP id m1mr22679794wrx.28.1537271482327;
        Tue, 18 Sep 2018 04:51:22 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id b12sm17057135wrx.11.2018.09.18.04.51.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 04:51:21 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH v2 1/2] of: base: Introduce of_alias_check_id() to check alias IDs
Date:   Tue, 18 Sep 2018 13:51:19 +0200
Message-Id: <6b07b21f60dcf07e1f6d6e39bae1f3750c4aa804.1537271478.git.michal.simek@xilinx.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v2:
- Add empty function for !CONFIG_OF case
- Add return to that function
- Add Rob's Reviewed-by tag

Based on discussion with Rob
https://lkml.org/lkml/2018/4/27/397
nbits is passed to the function not to limit only to 32/64bit fields.

---
 drivers/of/base.c  | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of.h | 10 ++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 466e3c8582f0..f27a2b2f0247 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt)	"OF: " fmt
 
+#include <linux/bitmap.h>
 #include <linux/console.h>
 #include <linux/ctype.h>
 #include <linux/cpu.h>
@@ -1893,6 +1894,57 @@ int of_alias_get_id(struct device_node *np, const char *stem)
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
index 4d25e4f952d9..dadd2e448c92 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -387,6 +387,9 @@ extern int of_phandle_iterator_args(struct of_phandle_iterator *it,
 extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
+extern int of_alias_get_alias_list(const struct of_device_id *matches,
+				   const char *stem, unsigned long *bitmap,
+				   unsigned int nbits);
 
 extern int of_machine_is_compatible(const char *compat);
 
@@ -872,6 +875,13 @@ static inline int of_alias_get_highest_id(const char *stem)
 	return -ENOSYS;
 }
 
+static int of_alias_get_alias_list(const struct of_device_id *matches,
+				   const char *stem, unsigned long *bitmap,
+				   unsigned int nbits)
+{
+	return -ENOSYS;
+}
+
 static inline int of_machine_is_compatible(const char *compat)
 {
 	return 0;
-- 
1.9.1

