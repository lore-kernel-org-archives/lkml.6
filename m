Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 05A32C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A421F208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMEN7B+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A421F208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933888AbeFLNmV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:42:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45990 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933203AbeFLNmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:42:17 -0400
Received: by mail-lf0-f65.google.com with SMTP id n3-v6so36086833lfe.12;
        Tue, 12 Jun 2018 06:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7b9yXN8I7+y9xFpsRLeuFAzs6185E05kVswKBKHWIhk=;
        b=TMEN7B+AcR3a/AIszAI3dRMmqco3vouslDdKK2TLDBMMPfp9VmOqkUmdL3H0+RtK3r
         veF/QTVGrreod2YsNPuQgQYg9IZIItf4y61qQURUzDipMH1a0QtV5KW3rR8stlk5aj/p
         BooaBf7pgZuOSm0Z5BE0QSxVJyqM6I/KI+0gIiOODRE/5zwT1nr6NGM6NM9PcKXQo7or
         fa6aB8HXP27h79lsdcYGgywKLXRxOvDVn1Ba2kGPOs4F6HG2ZvfOZGJJEd+kEvA2PO/v
         0MgYz/uBZ3JVzucRMGm+Ky2cLA2AHqLBWODUc+I4t40eL++Qu5lxvkkUCllx6s1JgSIR
         QXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7b9yXN8I7+y9xFpsRLeuFAzs6185E05kVswKBKHWIhk=;
        b=SnI53RzmQ9wyo/JW+Kza+agBdekf5ho3caon27FkOpYWv7kri0X7yjNgoHCyiB7XUo
         jCedJRZTH6kjOLorvh93P3MImZJJluRd+/ApaocSlsEx71o4o2ZNA6jqcvOdQc+rfUkp
         OEFxRtb4KBSuJ2ee5lqpCTzJrguBWyX9NN+pEdNSi0F7Tj98Hm5gqen2imwzjDR2lBgw
         bHYRmK8kRGmyqPueFfpUBqlZgcATCjX331eAkFhp4bnaoW+8LzS1KtTgK9buCZIIYJgP
         nRRHh7LhnUfX8JXIq6/QWECk1Hk9jNAKaIrq7jxSdXS6fdAkfashOPdUv91KkD14Hyh8
         uB5Q==
X-Gm-Message-State: APt69E0MWK9dk45OwGEURZaKcvtaVAoBsLzXtWT8mTGzXIk309fqCn8A
        pqy3v4iGMjoDPwmDdPMMdH0=
X-Google-Smtp-Source: ADUXVKLVIinkAgOji5KlhLRpd4xPEUBeGTsZKGWxcRFNG7iBHah0vwdWuTk0Tt+X6TOsEDo9ARLI+Q==
X-Received: by 2002:a2e:8810:: with SMTP id x16-v6mr296535ljh.45.1528810935279;
        Tue, 12 Jun 2018 06:42:15 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id x18-v6sm46692ljh.63.2018.06.12.06.42.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 06:42:14 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v3 4/9] xen/grant-table: Allow allocating buffers suitable for DMA
Date:   Tue, 12 Jun 2018 16:41:55 +0300
Message-Id: <20180612134200.17456-5-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612134200.17456-1-andr2000@gmail.com>
References: <20180612134200.17456-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Extend grant table module API to allow allocating buffers that can
be used for DMA operations and mapping foreign grant references
on top of those.
The resulting buffer is similar to the one allocated by the balloon
driver in terms that proper memory reservation is made
({increase|decrease}_reservation and VA mappings updated if needed).
This is useful for sharing foreign buffers with HW drivers which
cannot work with scattered buffers provided by the balloon driver,
but require DMAable memory instead.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 drivers/xen/Kconfig       | 13 ++++++
 drivers/xen/grant-table.c | 97 +++++++++++++++++++++++++++++++++++++++
 include/xen/grant_table.h | 18 ++++++++
 3 files changed, 128 insertions(+)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index e5d0c28372ea..39536ddfbce4 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -161,6 +161,19 @@ config XEN_GRANT_DEV_ALLOC
 	  to other domains. This can be used to implement frontend drivers
 	  or as part of an inter-domain shared memory channel.
 
+config XEN_GRANT_DMA_ALLOC
+	bool "Allow allocating DMA capable buffers with grant reference module"
+	depends on XEN && HAS_DMA
+	help
+	  Extends grant table module API to allow allocating DMA capable
+	  buffers and mapping foreign grant references on top of it.
+	  The resulting buffer is similar to one allocated by the balloon
+	  driver in terms that proper memory reservation is made
+	  ({increase|decrease}_reservation and VA mappings updated if needed).
+	  This is useful for sharing foreign buffers with HW drivers which
+	  cannot work with scattered buffers provided by the balloon driver,
+	  but require DMAable memory instead.
+
 config SWIOTLB_XEN
 	def_bool y
 	select SWIOTLB
diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index dbb48a89e987..26ed498b5e6d 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -45,6 +45,9 @@
 #include <linux/workqueue.h>
 #include <linux/ratelimit.h>
 #include <linux/moduleparam.h>
+#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
+#include <linux/dma-mapping.h>
+#endif
 
 #include <xen/xen.h>
 #include <xen/interface/xen.h>
@@ -57,6 +60,7 @@
 #ifdef CONFIG_X86
 #include <asm/xen/cpuid.h>
 #endif
+#include <xen/mem-reservation.h>
 #include <asm/xen/hypercall.h>
 #include <asm/xen/interface.h>
 
@@ -838,6 +842,99 @@ void gnttab_free_pages(int nr_pages, struct page **pages)
 }
 EXPORT_SYMBOL_GPL(gnttab_free_pages);
 
+#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
+/**
+ * gnttab_dma_alloc_pages - alloc DMAable pages suitable for grant mapping into
+ * @args: arguments to the function
+ */
+int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args)
+{
+	unsigned long pfn, start_pfn;
+	size_t size;
+	int i, ret;
+
+	size = args->nr_pages << PAGE_SHIFT;
+	if (args->coherent)
+		args->vaddr = dma_alloc_coherent(args->dev, size,
+						 &args->dev_bus_addr,
+						 GFP_KERNEL | __GFP_NOWARN);
+	else
+		args->vaddr = dma_alloc_wc(args->dev, size,
+					   &args->dev_bus_addr,
+					   GFP_KERNEL | __GFP_NOWARN);
+	if (!args->vaddr) {
+		pr_debug("Failed to allocate DMA buffer of size %zu\n", size);
+		return -ENOMEM;
+	}
+
+	start_pfn = __phys_to_pfn(args->dev_bus_addr);
+	for (pfn = start_pfn, i = 0; pfn < start_pfn + args->nr_pages;
+			pfn++, i++) {
+		struct page *page = pfn_to_page(pfn);
+
+		args->pages[i] = page;
+		args->frames[i] = xen_page_to_gfn(page);
+		xenmem_reservation_scrub_page(page);
+	}
+
+	xenmem_reservation_va_mapping_reset(args->nr_pages, args->pages);
+
+	ret = xenmem_reservation_decrease(args->nr_pages, args->frames);
+	if (ret != args->nr_pages) {
+		pr_debug("Failed to decrease reservation for DMA buffer\n");
+		ret = -EFAULT;
+		goto fail;
+	}
+
+	ret = gnttab_pages_set_private(args->nr_pages, args->pages);
+	if (ret < 0)
+		goto fail;
+
+	return 0;
+
+fail:
+	gnttab_dma_free_pages(args);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gnttab_dma_alloc_pages);
+
+/**
+ * gnttab_dma_free_pages - free DMAable pages
+ * @args: arguments to the function
+ */
+int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args)
+{
+	size_t size;
+	int i, ret;
+
+	gnttab_pages_clear_private(args->nr_pages, args->pages);
+
+	for (i = 0; i < args->nr_pages; i++)
+		args->frames[i] = page_to_xen_pfn(args->pages[i]);
+
+	ret = xenmem_reservation_increase(args->nr_pages, args->frames);
+	if (ret != args->nr_pages) {
+		pr_debug("Failed to decrease reservation for DMA buffer\n");
+		ret = -EFAULT;
+	} else {
+		ret = 0;
+	}
+
+	xenmem_reservation_va_mapping_update(args->nr_pages, args->pages,
+					     args->frames);
+
+	size = args->nr_pages << PAGE_SHIFT;
+	if (args->coherent)
+		dma_free_coherent(args->dev, size,
+				  args->vaddr, args->dev_bus_addr);
+	else
+		dma_free_wc(args->dev, size,
+			    args->vaddr, args->dev_bus_addr);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gnttab_dma_free_pages);
+#endif
+
 /* Handling of paged out grant targets (GNTST_eagain) */
 #define MAX_DELAY 256
 static inline void
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index de03f2542bb7..9bc5bc07d4d3 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -198,6 +198,24 @@ void gnttab_free_auto_xlat_frames(void);
 int gnttab_alloc_pages(int nr_pages, struct page **pages);
 void gnttab_free_pages(int nr_pages, struct page **pages);
 
+#ifdef CONFIG_XEN_GRANT_DMA_ALLOC
+struct gnttab_dma_alloc_args {
+	/* Device for which DMA memory will be/was allocated. */
+	struct device *dev;
+	/* If set then DMA buffer is coherent and write-combine otherwise. */
+	bool coherent;
+
+	int nr_pages;
+	struct page **pages;
+	xen_pfn_t *frames;
+	void *vaddr;
+	dma_addr_t dev_bus_addr;
+};
+
+int gnttab_dma_alloc_pages(struct gnttab_dma_alloc_args *args);
+int gnttab_dma_free_pages(struct gnttab_dma_alloc_args *args);
+#endif
+
 int gnttab_pages_set_private(int nr_pages, struct page **pages);
 void gnttab_pages_clear_private(int nr_pages, struct page **pages);
 
-- 
2.17.1

