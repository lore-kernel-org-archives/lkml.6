Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991E4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB6A216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 07:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="eNOYYAPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB6A216FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeI1NhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 09:37:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33007 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728952AbeI1Ngs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 09:36:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id f10-v6so5198742wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 00:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mmvmbHeAPjG3Oc6euefkkNxK3Agi59+XcsUdVG7wIPA=;
        b=eNOYYAPccrzvANhkDNw26kqlmpRFu+n4SIXSBXPdEeJbPLkdD7VzMA9zRldxYzsL0X
         +ti+rePqmDBxnAfx3IAbg30up/VijzIanyusNpSFh7BzEI/xqN/lGWHi510Yt6d/65j4
         HBKs5DMfCXIIjXzlmaMfb0YJ4En7HMInTqUKk2U9cMk9uHK36WXNfHpGTiP56Jto/kYY
         I9VlHJmzjC6kT9DzkxFXYjkA8L7j46qsio4ZQZw4Eu46M97VTPAoqv5a2GXMd8Ymewvr
         LWMHPo+Ef7Q/atDKfBO9SwnhHLsbcgqcMmXYDgwEBTDM/dDyAKCoV2Llbs8XPpTcwhd/
         4K+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mmvmbHeAPjG3Oc6euefkkNxK3Agi59+XcsUdVG7wIPA=;
        b=X6GYI9ZKnS25XYlEWQA6+zxPu1UhuT/smhGLMrokxLc+hzRf8zT+bNNdu97LmP7NQS
         tKE0EYdzxrkRpORYCrY02pWO8cFWZLP7MfwTTjmctr1uq/YSnquN1C3aDcdqvnVM4QnI
         G6A24V3zT80UIj+RrzTVJmi4xCcH5YXHq5Ou9vYFM22H3RoiiG/E6n15Lzh0sYEUhJN7
         AbQCwDUbk7pkV7k00iUwtfN35klOds4RykX7r6M1a/gzFT6LhF9c2r4lI4weZGN6tsLl
         rjYdiJpdEkk3hV3CM99YQ06HpYRHpx2fRNr4iGPG4hX6IxOqmX2h0hLWctEbEcoS9bR0
         ltMQ==
X-Gm-Message-State: ABuFfoiT/1rL4nG2DXnvPKBA/SDiAkQtxyr3+HTGMeWdqv7oJ6B/3N73
        0N4xmttEQfA4BbjWxn5MXz0nyA==
X-Google-Smtp-Source: ACcGV60diTTFYUDpbOd928mTZZjaS5tbfO/hDV+qcR0JJz+7sxMuxuKOO395Mt1wYQ+8c3XChxeJEQ==
X-Received: by 2002:adf:bacf:: with SMTP id w15-v6mr11524709wrg.203.1538118866072;
        Fri, 28 Sep 2018 00:14:26 -0700 (PDT)
Received: from brgl-bgdev.sitez.s.ibrowse.com (93-158-26-51.subs.ibrowse.com. [93.158.26.51])
        by smtp.gmail.com with ESMTPSA id w3-v6sm2699580wru.93.2018.09.28.00.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 00:14:25 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v5 3/4] devres: provide devm_kstrdup_const()
Date:   Fri, 28 Sep 2018 09:14:13 +0200
Message-Id: <20180928071414.30703-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180928071414.30703-1-brgl@bgdev.pl>
References: <20180928071414.30703-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a resource managed version of kstrdup_const(). This variant
internally calls devm_kstrdup() on pointers that are outside of
.rodata section and returns the string as is otherwise.

Make devm_kfree() check if the passed pointer doesn't point to .rodata
and if so - don't actually destroy the resource.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 drivers/base/devres.c  | 31 +++++++++++++++++++++++++++++++
 include/linux/device.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 438c91a43508..00c70f0fcdcd 100644
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
@@ -889,6 +913,13 @@ void devm_kfree(struct device *dev, const void *p)
 {
 	int rc;
 
+	/*
+	 * Special case: pointer to a string in .rodata returned by
+	 * devm_kstrdup_const().
+	 */
+	if (unlikely(is_kernel_rodata((unsigned long)p)))
+		return;
+
 	rc = devres_destroy(dev, devm_kmalloc_release,
 			    devm_kmalloc_match, (void *)p);
 	WARN_ON(rc);
diff --git a/include/linux/device.h b/include/linux/device.h
index 33f7cb271fbb..e626acb93ef5 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -694,6 +694,8 @@ static inline void *devm_kcalloc(struct device *dev,
 }
 extern void devm_kfree(struct device *dev, const void *p);
 extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
+extern const char *devm_kstrdup_const(struct device *dev,
+				      const char *s, gfp_t gfp);
 extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
 			  gfp_t gfp);
 
-- 
2.18.0

