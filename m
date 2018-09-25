Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CB6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1F420877
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="htgAqfBy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1F420877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeIYSyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:54:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39929 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbeIYSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:54:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so23211462wrw.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 05:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hl9QIj3GGHz5egGHWiKaZEu8TXn7XsISVPAF0TF2KVk=;
        b=htgAqfBy0Mu2sHH/EWsnpBdHsrnt38NPo1ive4eEyB7MNwXwBgt0149uo+1I9dBpLX
         7tu7ifpw82ch2jPzeUp+VQ1Izh9pt+YIsk7cVAHhm4HpRkpkWBXavcevjWvfkr7c1eWS
         gYYBbaoiYMoU/b1SVgOr7lYZn5NRXVLMZWuXSs51edhNMk4J83LzfGJW/bBPEKP8KuIr
         sGpt0LLTY0EoqC2YpYWYd6rm1BgqRrYZtnR8wS4rtk+WquXduNK2qfOVeXf/vPHtuLy1
         yzQlFfxj8TwEKa3e2F0QWf0PbjseMz/7vNj385Se3ZJn7Adsf4jGgpCD5nRQDnuiAABz
         YFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hl9QIj3GGHz5egGHWiKaZEu8TXn7XsISVPAF0TF2KVk=;
        b=jz9bLIfFUiILG/5xyGjMP2E8YOyfGrSSPEQwehbVLUJtWnzSpiH0kR/XA/K4mbT9/R
         gbo7Cd8mmjfBd2jOfyrecWDxNoEu2uIVXSoEH++TQTmanxpWx0+x4fPBgv93Up8T3xLc
         XcPUjE+TKrumMYiLOE3CMBsG1laTppa4f+Fl1Kh+J+TnwDmACcxI6I4+hxQnIpHixMiN
         O+5DIxXDMFiYypbU5AF/nbuH7EdVeZRN98HYRWmqe2iATK5nwYhS1ZdV8qlRFyZSzTvt
         BMkWjzTMn3wjCoi9JaL36JhDo8MPTtVP9Z7K6nqqihkOLi2F6MNBgTytCTKjCvjruLTf
         1V2w==
X-Gm-Message-State: ABuFfohBRZQhIk2IvnXSrezkfa+yqgeZ2YBnzUvhHsKX2HOLsNKD5ph9
        tzGFO5d/P9fFkBB29EFztMd8Ew==
X-Google-Smtp-Source: ACcGV62xLZYmZrn9c8PVYHVbNSgo+7ZTD/3j+mzVuYTmGomL0Ie0eulbUQp2z5+QwP/kwCX2tW5alw==
X-Received: by 2002:a5d:50cf:: with SMTP id f15-v6mr908600wrt.128.1537879604000;
        Tue, 25 Sep 2018 05:46:44 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id z13sm2276160wrw.19.2018.09.25.05.46.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 05:46:43 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v4 3/4] devres: provide devm_kstrdup_const()
Date:   Tue, 25 Sep 2018 14:46:28 +0200
Message-Id: <20180925124629.20710-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180925124629.20710-1-brgl@bgdev.pl>
References: <20180925124629.20710-1-brgl@bgdev.pl>
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
Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
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

