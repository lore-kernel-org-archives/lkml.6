Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 34444C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75F62086A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 06:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9QhS8yU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D75F62086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755852AbeFOG2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 02:28:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35278 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755801AbeFOG2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 02:28:06 -0400
Received: by mail-lf0-f65.google.com with SMTP id i15-v6so13003411lfc.2;
        Thu, 14 Jun 2018 23:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qn9DhGEWTMaawUxaGfYqOvXnzJRBZPC7KzIu0SJDlM8=;
        b=Z9QhS8yUzmL2rmqSoVyentDiVpfpnMpzTkSNLxgOdOZ02SwqqtGcu8amFA5KM0qhu9
         mS2LN4eSXjvGZgbIOwKbi3i5V8mtPjf5ZTrw1qMZRFRy7xqYlXGhhQurvanWwsZSJLuu
         mY5hpjO7Yb5iVsKQIWUtTfXAl++yFa1lqcnOStHlLXORXjLY2eKZKQmYLyrZ9YKNxax5
         heFJho0TvXytcozch1T9DMdzGSzWjtGqm8X0qGGSTGyOEbQx+fbuVIdCUNXawytfKyPe
         xtnN+UxxjI6S0b+ZIwwHnPzTIlAFFFzErsdEoIESj+3Y4CO81+JUJAD59HIlIrsFi7db
         wFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qn9DhGEWTMaawUxaGfYqOvXnzJRBZPC7KzIu0SJDlM8=;
        b=UJhsTyEw0ZLvfcY/npzdxoeLQtJJW7oQynut4E80BPrQR08qRFOaJQV3ioK17vvBnw
         d0jzZr+YfCgyAmW1Mzc+PAoOz7Bj7g2Pq5p8h+akT4ycb0euNiY3DcUqS2fqyKHT+/q7
         Ujoq3Cme7dV/n0ZRnSzDHJ7gaJL8olKdbeZ9sIhcS8ynzv9+cNlcUjGrZGw1byvkIwKo
         Axn3N4e78kVkpvHwzCUEA01BFYfGrg5Z2CqXLRUqXeYmEpQJsoEH4Y8FXYrdNwk9AzWj
         q5S7/Q0Zh1flwLCzOG7plXfDfMGeaNeXXlAhhunJmlnjjA9luhhG8MwxYWZsiMi3zQTv
         fqQg==
X-Gm-Message-State: APt69E0LSjzyUAJ9R3s4/S+pjtksvBClnpaJ9UfHueEqmaXh6vEWTmJh
        2EJf5n/hmKjqjWrdBsJpdkk=
X-Google-Smtp-Source: ADUXVKLZFzCl58q6Ph/9d9uLGpP8FusblobSVXIrNUU3zcWmd4KDIxd89v2vyh6Pad3JN9iCbeYYyg==
X-Received: by 2002:a2e:5f8f:: with SMTP id x15-v6mr314292lje.70.1529044085057;
        Thu, 14 Jun 2018 23:28:05 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id t126-v6sm1355040lff.7.2018.06.14.23.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 23:28:03 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v4 2/9] xen/grant-table: Make set/clear page private code shared
Date:   Fri, 15 Jun 2018 09:27:46 +0300
Message-Id: <20180615062753.9229-3-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615062753.9229-1-andr2000@gmail.com>
References: <20180615062753.9229-1-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Make set/clear page private code shared and accessible to
other kernel modules which can re-use these instead of open-coding.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 drivers/xen/grant-table.c | 54 +++++++++++++++++++++++++--------------
 include/xen/grant_table.h |  3 +++
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index ba36ff3e4903..dbb48a89e987 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -769,29 +769,18 @@ void gnttab_free_auto_xlat_frames(void)
 }
 EXPORT_SYMBOL_GPL(gnttab_free_auto_xlat_frames);
 
-/**
- * gnttab_alloc_pages - alloc pages suitable for grant mapping into
- * @nr_pages: number of pages to alloc
- * @pages: returns the pages
- */
-int gnttab_alloc_pages(int nr_pages, struct page **pages)
+int gnttab_pages_set_private(int nr_pages, struct page **pages)
 {
 	int i;
-	int ret;
-
-	ret = alloc_xenballooned_pages(nr_pages, pages);
-	if (ret < 0)
-		return ret;
 
 	for (i = 0; i < nr_pages; i++) {
 #if BITS_PER_LONG < 64
 		struct xen_page_foreign *foreign;
 
 		foreign = kzalloc(sizeof(*foreign), GFP_KERNEL);
-		if (!foreign) {
-			gnttab_free_pages(nr_pages, pages);
+		if (!foreign)
 			return -ENOMEM;
-		}
+
 		set_page_private(pages[i], (unsigned long)foreign);
 #endif
 		SetPagePrivate(pages[i]);
@@ -799,14 +788,30 @@ int gnttab_alloc_pages(int nr_pages, struct page **pages)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(gnttab_alloc_pages);
+EXPORT_SYMBOL_GPL(gnttab_pages_set_private);
 
 /**
- * gnttab_free_pages - free pages allocated by gnttab_alloc_pages()
- * @nr_pages; number of pages to free
- * @pages: the pages
+ * gnttab_alloc_pages - alloc pages suitable for grant mapping into
+ * @nr_pages: number of pages to alloc
+ * @pages: returns the pages
  */
-void gnttab_free_pages(int nr_pages, struct page **pages)
+int gnttab_alloc_pages(int nr_pages, struct page **pages)
+{
+	int ret;
+
+	ret = alloc_xenballooned_pages(nr_pages, pages);
+	if (ret < 0)
+		return ret;
+
+	ret = gnttab_pages_set_private(nr_pages, pages);
+	if (ret < 0)
+		gnttab_free_pages(nr_pages, pages);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gnttab_alloc_pages);
+
+void gnttab_pages_clear_private(int nr_pages, struct page **pages)
 {
 	int i;
 
@@ -818,6 +823,17 @@ void gnttab_free_pages(int nr_pages, struct page **pages)
 			ClearPagePrivate(pages[i]);
 		}
 	}
+}
+EXPORT_SYMBOL_GPL(gnttab_pages_clear_private);
+
+/**
+ * gnttab_free_pages - free pages allocated by gnttab_alloc_pages()
+ * @nr_pages; number of pages to free
+ * @pages: the pages
+ */
+void gnttab_free_pages(int nr_pages, struct page **pages)
+{
+	gnttab_pages_clear_private(nr_pages, pages);
 	free_xenballooned_pages(nr_pages, pages);
 }
 EXPORT_SYMBOL_GPL(gnttab_free_pages);
diff --git a/include/xen/grant_table.h b/include/xen/grant_table.h
index 2e37741f6b8d..de03f2542bb7 100644
--- a/include/xen/grant_table.h
+++ b/include/xen/grant_table.h
@@ -198,6 +198,9 @@ void gnttab_free_auto_xlat_frames(void);
 int gnttab_alloc_pages(int nr_pages, struct page **pages);
 void gnttab_free_pages(int nr_pages, struct page **pages);
 
+int gnttab_pages_set_private(int nr_pages, struct page **pages);
+void gnttab_pages_clear_private(int nr_pages, struct page **pages);
+
 int gnttab_map_refs(struct gnttab_map_grant_ref *map_ops,
 		    struct gnttab_map_grant_ref *kmap_ops,
 		    struct page **pages, unsigned int count);
-- 
2.17.1

