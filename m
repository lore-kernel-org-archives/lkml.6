Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065E8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9DAA20833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="U9CNVgpk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9DAA20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbeIXQNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:13:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39525 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728059AbeIXQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:13:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so9403506wmq.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XAjBhV4AEAXhQXiXfZCfBofMzbagPKbxDfjukdf0psM=;
        b=U9CNVgpkzrL4OvueGLRFk8ZILjjyyFHgpudl/5z72bjMk/62AELNp9gA6tX9L7TCcz
         CRPFzqc/lGBawA+rhlkaGrI8zfUnnxosaYgtsRIzHLK8pRlRhPeUnxrZy8dyTTeRjiWv
         oog6+Oslhp3r2TLolLk3wAYISd2W7vVOQBA2XGS5LmOw0cnvvXTKe7H22dkjWquxI86e
         4jZyrCn5dXpxT33ysfflcye7D5rP14tNbrqRBhTU7+bUeMsrFPYo7RpYHaLIvZibYx9b
         6bLh9F4/F3pNAz5uS+3jYGsIqF71x5BPAhtLK4XvqYYUrP3eERMiZOLaDeVZf2VeFnzA
         SWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XAjBhV4AEAXhQXiXfZCfBofMzbagPKbxDfjukdf0psM=;
        b=fGrJj1MxLy4pfnA49kJUfa/2i//0vTx0HEXG1ZOAlXaurQv8FRL4ehJOOIrLNfuB+V
         VPTGmTQ3WdhKf49NHrS1gCcfzDPY4WQJ9IK0+3Rm0VWbK8SiBOAmCOTHjJ+g1ItYLN3d
         DFoH8qEfpWY23r6H2KNQmXP4z0zlu6UCTZJmAhhpGSI04Ecff+pdHtQ6JxFq/B1M6DbC
         EkXMMVc0rdaW7M9W+XGR5Hr0fkDpTS3Sd7+LL+NYvdAWrituFpBlCCtbfR7tkB3rFRXL
         N0cZLbNIdBARRDAhZTrY7Pk1VedtC+yA4sh1NPzWepoe/5cibLiD3gkZwm20IBZBeJIp
         iqfQ==
X-Gm-Message-State: APzg51BZwVY9o02cmYXA9Y3DOLTzHaQkvcFtQFiLJAyVWFa0nqbQyvpJ
        1CyNd+dBzwu1YeXFh9mfdTmsow==
X-Google-Smtp-Source: ACcGV62+Sgy75fLne3seCROrjfDu6thd6VNFdZQleEdJLCr1Uj8yOtYHIB12h5OQlRf3mCk0DL/+bQ==
X-Received: by 2002:a1c:b5d3:: with SMTP id e202-v6mr6487055wmf.23.1537783927188;
        Mon, 24 Sep 2018 03:12:07 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-2-33.w90-86.abo.wanadoo.fr. [90.86.1.33])
        by smtp.gmail.com with ESMTPSA id o12-v6sm3291728wrj.58.2018.09.24.03.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 03:12:06 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 3/4] devres: provide devm_kstrdup_const()
Date:   Mon, 24 Sep 2018 12:11:49 +0200
Message-Id: <20180924101150.23349-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180924101150.23349-1-brgl@bgdev.pl>
References: <20180924101150.23349-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a resource managed version of kstrdup_const(). This variant
internally calls devm_kstrdup() on pointers that are outside of
.rodata section and returns the string as is otherwise.

Also provide a corresponding version of devm_kfree().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/base/devres.c  | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/device.h |  3 +++
 2 files changed, 41 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 438c91a43508..48185d57bc5b 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -11,6 +11,8 @@
 #include <linux/slab.h>
 #include <linux/percpu.h>
 
+#include <asm/sections.h>
+
 #include "base.h"
 
 struct devres_node {
@@ -822,6 +824,28 @@ char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp)
 }
 EXPORT_SYMBOL_GPL(devm_kstrdup);
 
+/**
+ * devm_kstrdup_const - resource managed conditional string duplication
+ * @dev: device for which to duplicate the string
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ *
+ * Strings allocated by devm_kstrdup_const will be automatically freed when
+ * the associated device is detached.
+ *
+ * RETURNS:
+ * Source string if it is in .rodata section otherwise it falls back to
+ * devm_kstrdup.
+ */
+const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp)
+{
+	if (is_kernel_rodata((unsigned long)s))
+		return s;
+
+	return devm_kstrdup(dev, s, gfp);
+}
+EXPORT_SYMBOL(devm_kstrdup_const);
+
 /**
  * devm_kvasprintf - Allocate resource managed space and format a string
  *		     into that.
@@ -895,6 +919,20 @@ void devm_kfree(struct device *dev, const void *p)
 }
 EXPORT_SYMBOL_GPL(devm_kfree);
 
+/**
+ * devm_kfree_const - Resource managed conditional kfree
+ * @dev: device this memory belongs to
+ * @p: memory to free
+ *
+ * Function calls devm_kfree only if @p is not in .rodata section.
+ */
+void devm_kfree_const(struct device *dev, const void *p)
+{
+	if (!is_kernel_rodata((unsigned long)p))
+		devm_kfree(dev, p);
+}
+EXPORT_SYMBOL(devm_kfree_const);
+
 /**
  * devm_kmemdup - Resource-managed kmemdup
  * @dev: Device this memory belongs to
diff --git a/include/linux/device.h b/include/linux/device.h
index 33f7cb271fbb..79ccc6eb0975 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -693,7 +693,10 @@ static inline void *devm_kcalloc(struct device *dev,
 	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
 extern void devm_kfree(struct device *dev, const void *p);
+extern void devm_kfree_const(struct device *dev, const void *p);
 extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
+extern const char *devm_kstrdup_const(struct device *dev,
+				      const char *s, gfp_t gfp);
 extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
 			  gfp_t gfp);
 
-- 
2.18.0

