Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FE5C7112C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253D120876
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="hCQx1K5R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 253D120876
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbeJNXBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:01:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41701 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbeJNXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:01:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so18355071wru.8
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YDVENKVWOJgFEZ88TbmXetJ81nbm7Zo0Uj8ZIHPmj3U=;
        b=hCQx1K5RLTa7EAW0on1YYORgSUVMkHCLGlFyEO9yXIDbNeluWAWErX1NN9aM+WCADE
         ipnztD1GhlXFpW73Z8f6FIShNh26fmtHIMxgn2XdwZnyYDEUfaPL5sDt4lqQdF/TW+GS
         cDT++0uO/XvqpWEgoCjij78sN6X/hFGT1pwkflsvUIqrTq5+cFfdLp4iO6IwJMEfX7aO
         NTd1EnfZ8/UDnNvTFIdPkyhhrgP7++bprVtKBZL8ZAsI4TKrmgn1KWec8WcEXBQf9h4c
         LXijOfG4zHFbj6HXUS+cyY8tyJrvm5wcK6TL4fpPhJ47WyFh3mGgBsXXrdZJETEA+LS5
         HVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YDVENKVWOJgFEZ88TbmXetJ81nbm7Zo0Uj8ZIHPmj3U=;
        b=kFbYYqlnwd0TfvBBMdWmyzpxcUyPiygLwT9Aswa1kV6+30vWpkCS+XaC/Ly7JY88te
         UITkedCEkogrOMQaHSjb/ZnyjRafCwP3SbDhF5HbsaQdOoqodw+b84npRPbHJy7ZK6zW
         PjP/QuqP3y08xIegueHHQk6XS2K4tYhXU1RNfEco6FDR14OTwJlLhrqXsOiws0mPrywJ
         ZIgINBKQxbGI7Sp1bXIZ9CmvkLzvIB97B6eTVb/JxHzetgPJmkOkUqMmqRR0D/ucMF2r
         ql5aVg3mUzspOAvWgAOUPrCml2ZWKc6Ao4H2cKoUYjYx2xFHyBDmVYImuY9yziokW2nf
         my4A==
X-Gm-Message-State: ABuFfojXb4PyiYEzb5OIW7UY7wqR/R0Aj9N9KIup06SjsGk+7QXXiBY1
        u+DSnUzLGUa7TsL+kPG38+IZOmduDjw=
X-Google-Smtp-Source: ACcGV62vns+I4hTEGXDH2LiX3Emw3xTh9MKY2HkBXcya9KsWzSWGFVRDiKCT1chL0iDe2mZDvmKxKg==
X-Received: by 2002:adf:9d26:: with SMTP id k38-v6mr12282396wre.18.1539530422790;
        Sun, 14 Oct 2018 08:20:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id b139-v6sm14789830wmd.36.2018.10.14.08.20.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 08:20:22 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [RESEND PATCH v6 3/4] devres: provide devm_kstrdup_const()
Date:   Sun, 14 Oct 2018 17:20:09 +0200
Message-Id: <20181014152010.2021-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181014152010.2021-1-brgl@bgdev.pl>
References: <20181014152010.2021-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
2.19.1

