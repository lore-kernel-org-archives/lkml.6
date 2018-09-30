Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB80CC64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B103521477
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 20:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="r0uTbSOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B103521477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbeJADAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 23:00:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34468 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728632AbeJADAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 23:00:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id z4-v6so10181063wrb.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ApeEBzYoZaLAzJI8/OmZ6g6k8Ab9sg8MfvJpY8+ZNMk=;
        b=r0uTbSOFcbxLO/QL+dB6Xp9rYYWrgEix4/bSo+dU3Hh3Os/+iNogUZxf737WQlai+s
         RpLOzVBo2ENEGHlT6cxeBgPcrqRRCs+4s54wOjUVo3yhhOGEqLt8VrM4NlG1FckFNZhZ
         PNCVDdqh2+X7kgIscVngodTnFVypBBYUY4h3PMJd5EU6N22nE8nOWwfxI2yGzLc+P2VZ
         pCi3RY/IivGRMmSKbbmsqGKk9AuqHBqH1j4oLIwjiSX0sJo7PNy2vbY4WmcoxqmlV33V
         DkldhHTjfEltCzCjezgSuwXCRsHC2vNCCzyHdH64sd0VxTh3iWaD0jUt72PfuqGlN6ot
         2tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ApeEBzYoZaLAzJI8/OmZ6g6k8Ab9sg8MfvJpY8+ZNMk=;
        b=OPw7avrlE7XhtVUYUutVpkEAtf9mfyT2+kHJRIB2/X5dbnYGcu/nBPArwDkrWSZ7aM
         IOX2uROtsRtVHj0vorwd+5K0j+/S9ugyKdWZWXwmbAzC0q8A16J+1WnG1FC4OG2UCYDS
         fcbMMwAdsdFva/mOYC4zVaDCMwsQOPRUOY5Try2c0iSIV+ZZxNgDB+qgvCOYI+X92dj4
         jqjEF2EImNMYkPfVAoDWa1L7TsLW/f5h1nmlZOJV8mc0+4erIwRk++CLrJRjsilPNJrn
         8eSn+Rxd50eZhS4Y1bzBkc5UI5vcA6Ca4GMhxPd1LNx2ltr96aMAk/MYUaeJY2R+8P7z
         BgQQ==
X-Gm-Message-State: ABuFfoi42JJzY2pY4BhtJy8SQ3NyxaLh6XknUrHNC0bN5Lu/8bDZooSt
        OWUIu+l9mTICSU+6HC5GUCLsAw==
X-Google-Smtp-Source: ACcGV62lj2UTN597McA9Vb6ftLO5eT+cWY8EeViVztRZ43TA6FXNif742UMJ7Bl/kjbdydYBoBT7og==
X-Received: by 2002:adf:e808:: with SMTP id o8-v6mr3076693wrm.269.1538339184696;
        Sun, 30 Sep 2018 13:26:24 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id v16-v6sm18566465wrw.12.2018.09.30.13.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Sep 2018 13:26:24 -0700 (PDT)
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
Subject: [PATCH v6 3/4] devres: provide devm_kstrdup_const()
Date:   Sun, 30 Sep 2018 22:26:14 +0200
Message-Id: <20180930202615.12951-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180930202615.12951-1-brgl@bgdev.pl>
References: <20180930202615.12951-1-brgl@bgdev.pl>
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

