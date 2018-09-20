Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15817C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF2B2152C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 11:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="AAccMnEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF2B2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732477AbeITRZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 13:25:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43478 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeITRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 13:25:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so9034841wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id;
        bh=tWAJ5ehl8dkATEE7czTzScLiB0dlXRdfPp0umosaGuU=;
        b=AAccMnEqkcz1NsXexuSF0XvjqOMbwGBxvEo9DIuGP9IOjPQcCQ0dBxg6ZysEQb/bPe
         PUrIv6VQPfDmWNXdXq2lYLvYIwg0Ev7WOUG4DXgmemGdJ9ExdRRCSZdgk8B5lg7LAwjc
         KB3tTZw/fW62e0z4iW2e0ON5xPb5ROdi0OWzcGo+PacYx16ujGmlv+KScFw7s1dYUPbd
         F+e1Yq2ggbgZ8WsMyGrsbNrWR0j/b+z+rfd3ST54lk9cQr0VSVTXgyqq3TSbQLAIOVT6
         xg0l538gTL2t5D2VSi7q3+Ey/aQ8TgT2eR0qSF3DLPqsSQhu+8rY9Fy/DYFacBuee9lg
         o57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=tWAJ5ehl8dkATEE7czTzScLiB0dlXRdfPp0umosaGuU=;
        b=tZhU0Qmr12wuVjaaHFNu3bMBDjuK+5KaID4YVxtCu+W95QNgv92mfyppGYbBdokKf+
         mwB6k9iQab4GfiqnrT0ERVFjPc/Di0Ln+uX2VJt+ysZjLc4239rusWQT+ilByD30s/Cs
         1OsF5f77xy4XbY/CA/jZX1to9jUIZJ6a3Upwowgdi8AyuwuotP4sdZsAUD2RFNPhRJ1d
         9SeanfKFjXCHc+PHYkWBC65lN/rc4MgBswEeHKBXHDZuv4mWOjGUbEZOHcWWShy/9M8/
         3wbanW/19trT9LpDxw0Qa+L827X7TaO8SNzw2QeOCPgMkB8yqzZ1VbO0iQubNlcGYC7A
         /z7Q==
X-Gm-Message-State: ABuFfoirF4vDt4fM4Un4/bfk9kt9kN2XWPvzQOy+EfAkIg/pdKi6uK2/
        tTNPh2PP8IcsV9m4i/d61f836bddP40j8w==
X-Google-Smtp-Source: ACcGV617W84x3aQchGF7w9Rj3B6wbcqEFJr6yfkNyr7VsTY/8d8peAg0xp3Ww+tZgXsfv1GrqHzHVQ==
X-Received: by 2002:adf:e643:: with SMTP id b3-v6mr1769421wrn.254.1537443717763;
        Thu, 20 Sep 2018 04:41:57 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id e14-v6sm16888807wrv.44.2018.09.20.04.41.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 04:41:57 -0700 (PDT)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [RESEND PATCH v3 1/2] of: base: Introduce of_alias_get_alias_list() to check alias IDs
Date:   Thu, 20 Sep 2018 13:41:52 +0200
Message-Id: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
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

