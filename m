Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5388C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5812089E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="K7DgoVj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E5812089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeH1Ncf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:32:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44784 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1Ncf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:32:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so915009wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZhPS8aKWZHYYGJDbC8vwHCt0WY7YA5vftpevadBx97w=;
        b=K7DgoVj8B2c94KzxsFLciUUUVbJs9GG+54y9l44xJv0cIGKEsWtmJ6asfgtAuJRNWG
         3YWTqiKNWfRuzi4MGrLExpWGQh33pnpPC31fZLOE1iAYaZnvNBt/3EJXVAqNj7ZSE+GI
         BMJhuQNbkhunybgsu80wI2MVHZF+0+S2fKypURC6G8Pc77I+SuMexD717Ca3+aF+LLbe
         UzJnEY249o+9lwmLaJUX6IZQ3YbgBPFpZpqVHYRbpKuZno3BH9GupI4N9Roz4FVRGDCH
         96bpEf6CsVsmyV6piYYOMmj0WwEH7xTECiwsKNNBE6PoyKyKGeFQ9Ba7YdipTSodR1f+
         fs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZhPS8aKWZHYYGJDbC8vwHCt0WY7YA5vftpevadBx97w=;
        b=cKzeitQx+SE1LnHQEoSxGL7e6TugKMB0kWREgrskYaWBTEwqhI11CSWj53U4QGfGAl
         0VAII1bwNnvD17zZHoeEUO/Gjl7FyycOxOr1NPos+YqrMnxHQ7EP/yg0h1jouXL92UHg
         vrW3RlPwBliIgNIVpjRcNlt35tcfpOi5stxM+NanNWbm5z87AYitEp5I06+lxVtTxtpN
         GbbO0iQAFEM/HHSkLXZVEED9amb3+XNL48Yd9hpcPnHJlDKayY/mqPW0Oaz0ayLhWpvv
         +KFcFzbudAm7lkoNetCT7xwtZkkqhPD/Yt4u7s3d9pOXzzlbTHVtFXbVn6MrISBQs1q2
         WmmA==
X-Gm-Message-State: APzg51AIFe2bGUEbTppcmSNIT3BcFV4/5rpDT86/yzxlOgC/ITvuHvUM
        r6WHqLg55baaa8zYUoCy+AGbyA==
X-Google-Smtp-Source: ANB0VdazQ1b4GJa2MqkcHdXAY4E48XRwkQi/Vh5haOo3iQRppCTAdopcVEtiX1xS13EEr5bEkgPC0A==
X-Received: by 2002:adf:e8c1:: with SMTP id k1-v6mr539276wrn.43.1535448849697;
        Tue, 28 Aug 2018 02:34:09 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l18-v6sm952276wru.75.2018.08.28.02.34.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:34:09 -0700 (PDT)
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
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 3/4] devres: provide devm_kstrdup_const()
Date:   Tue, 28 Aug 2018 11:33:31 +0200
Message-Id: <20180828093332.20674-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828093332.20674-1-brgl@bgdev.pl>
References: <20180828093332.20674-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a resource managed version of kstrdup_const(). This variant
internally calls devm_kstrdup() on pointers that are outside of
.rodata section and returns the string as is otherwise.

Also provide a corresponding version of devm_kfree().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
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

