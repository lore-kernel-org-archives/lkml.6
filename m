Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0788C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E702174A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="bAKJB+6Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E702174A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeH0MHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:07:15 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41001 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeH0MHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:07:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id z96-v6so12751480wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=fE0L4qS4JAIcIeGVF5WHMr5nRwEMI4xXJIjWAI4oJwo=;
        b=bAKJB+6ZeJaBDy0gRuAYKSpwqe8e7mxVfGS3uGmJ9XEnoHTA/g9z+ibiHWvvAt5We9
         A0HA9PUmAlPtA4SoAn9CMXYZD2S/tgSqpZbGQzoH7/Q8PcxfnKZOXpnac9lU2GXqhCfW
         F7xIPrhcZ9D3e65SPVHmlwyG+JCuoxkT+rPeTF4x9XsOAgv6gyapsKrMWSjgWSIlRpBQ
         0ddGzn3PSS0XCslxGwK0hDuoi/7RpAiQPH8/6w7ymGN/6MQI39yaIU7sm5h/XHtg9nUn
         /ejm45JtXTw5Ex0ntGhVoqQRbNsSa/tNjBpqMV/kkYQ/sQe0b2G6WQ4iJa/QgH89UOYp
         nUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fE0L4qS4JAIcIeGVF5WHMr5nRwEMI4xXJIjWAI4oJwo=;
        b=jajES9pdVjlgD2BYq7hkokIfrOrmlnyi7hopRF9cuHNweDoGEAiatBbeRJ3GtjNU+c
         e24hF6Rj+6othN8OOk8zbEtMcE2Qqv13bMSTzLRRAElamVL1OVdBWm1zjE6Jh5cFVnI4
         4qij7JyeKBRigmeU1HFdIYdRz+N5Gxx5zHrIpop/oeNc/y94YqQoCmV1S+w7GKFh6iUm
         YHiBMt/RCsVIgkSGrOWFcG9gptfQ3C6kLK8uBsSMTmAlFEJuyFz8gfBbuwem09hxAlOd
         pFgehwbHN2uXhFMmzRhP/Zcqdh7hwZXO6KKuzhctq5SXqsZSW1ZX11cO4q0fxSNU9jbk
         wWag==
X-Gm-Message-State: APzg51CyDXXd4tucueECyJEP+p28TC1PQlb/K0Jbr2zAQ63gJIajH2Ot
        cHTivBjLeE+vV9yTHFVy2miFzA==
X-Google-Smtp-Source: ANB0VdYVp6PH5lkGi93mUyekgo0jMNaTlitZiC7F1f47jSxuq+FzHEVKpHdnWQCwlydgRgnKfRA7nw==
X-Received: by 2002:adf:b583:: with SMTP id c3-v6mr7953572wre.79.1535358097344;
        Mon, 27 Aug 2018 01:21:37 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-34-229.w90-86.abo.wanadoo.fr. [90.86.153.229])
        by smtp.gmail.com with ESMTPSA id b144-v6sm15402309wmd.23.2018.08.27.01.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:21:36 -0700 (PDT)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 1/2] devres: provide devm_kstrdup_const()
Date:   Mon, 27 Aug 2018 10:21:00 +0200
Message-Id: <20180827082101.5036-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a resource managed version of kstrdup_const(). This variant
internally calls devm_kstrdup() on pointers that are outside of
.rodata section. Also provide a corresponding version of devm_kfree().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 include/linux/device.h |  2 ++
 mm/util.c              | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 8f882549edee..f8f5982d26b2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -693,7 +693,9 @@ static inline void *devm_kcalloc(struct device *dev,
 	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
 extern void devm_kfree(struct device *dev, void *p);
+extern void devm_kfree_const(struct device *dev, void *p);
 extern char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
+extern char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
 extern void *devm_kmemdup(struct device *dev, const void *src, size_t len,
 			  gfp_t gfp);
 
diff --git a/mm/util.c b/mm/util.c
index d2890a407332..6d1f41b5775e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -39,6 +39,20 @@ void kfree_const(const void *x)
 }
 EXPORT_SYMBOL(kfree_const);
 
+/**
+ * devm_kfree_const - Resource managed conditional kfree
+ * @dev: device this memory belongs to
+ * @p: memory to free
+ *
+ * Function calls devm_kfree only if @p is not in .rodata section.
+ */
+void devm_kfree_const(struct device *dev, void *p)
+{
+	if (!is_kernel_rodata((unsigned long)p))
+		devm_kfree(dev, p);
+}
+EXPORT_SYMBOL(devm_kfree_const);
+
 /**
  * kstrdup - allocate space for and copy an existing string
  * @s: the string to duplicate
@@ -78,6 +92,27 @@ const char *kstrdup_const(const char *s, gfp_t gfp)
 }
 EXPORT_SYMBOL(kstrdup_const);
 
+/**
+ * devm_kstrdup_const - resource managed conditional string duplication
+ * @dev: device for which to duplicate the string
+ * @s: the string to duplicate
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ *
+ * Function returns source string if it is in .rodata section otherwise it
+ * fallbacks to devm_kstrdup.
+ *
+ * Strings allocated by devm_kstrdup_const will be automatically freed when
+ * the associated device is detached.
+ */
+char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp)
+{
+	if (is_kernel_rodata((unsigned long)s))
+		return s;
+
+	return devm_kstrdup(dev, s, gfp);
+}
+EXPORT_SYMBOL(devm_kstrdup_const);
+
 /**
  * kstrndup - allocate space for and copy an existing string
  * @s: the string to duplicate
-- 
2.18.0

