Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A0FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7642084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu2esHu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7642084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeGTJtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:49:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41621 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbeGTJtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:49:18 -0400
Received: by mail-lj1-f194.google.com with SMTP id y17-v6so10520478ljy.8;
        Fri, 20 Jul 2018 02:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eEs/VHMVbfTrVrQCy3MwCEDIiZb5jAmROKAyIberZpk=;
        b=Cu2esHu/AAIR4NBaK8y7nLzg2Di+041RxbpqucOC3QX/pYTsZ8ly8vb1xoVOe3F1iK
         yHcp8PSjB/iXboUh99sKwsdUrb7epE/IeV/vJ375fKTsoSAuHiAyzzBOius32kd7US39
         BPxYOf3bNKYZ0D43c06iky3hxK5mGhURnx5CiETjpCydUrwqcuxv90aa3X567aWI8Kp6
         StKejCNmWXsr9ooDEUuAvxNv1W1M5sek7Ks7yOJzmvaKnDaTPMoJK9Ryiucqs6/b0XXb
         X85J6UOjyBJkNHumQsEN8cieExZ2cFyyY0QJgD1si3WXS4P6wgLLuf1zRLjQ3VVaiylw
         md2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eEs/VHMVbfTrVrQCy3MwCEDIiZb5jAmROKAyIberZpk=;
        b=uQZli37fFz7Cq8a3NuomZlv6VuDNJ7PEi8W2MtdWKPK2BMaNWsKcV+V/aa4RharJjB
         w/SOvbNXuAP95HKH4JEK6AF4Gj8+1XosW1QHDbthGiAHjh5fCRGmzjXBePa5We192KvC
         I45xlUgH+I7UHGf0QRgXXm6URocSukkehmbQjVHf4uF483ok0s+KgKMHkKxHA8+8OfoY
         3cAA7Qbmfe2LynxrNx8vl60PA5hDkVQSCTSHGfTeqjBK5XxblcExDw77ma2sz0zytzKM
         sXhncSNfFO9lLYFAhc0Xa3ByRkkeuaYc7cxbiCFi2AkkRUnNfc6J6Dcm5I1414iUxY/y
         x1tA==
X-Gm-Message-State: AOUpUlEDawe75eZLVX1IkrZsDrkmkDgjxgMqfW+ExVnx09qFvBlJ7Bfw
        YQYtHPo8FBLQ7HLwm3/CXRE=
X-Google-Smtp-Source: AAOMgpeSUKbqMYxI5agy3S8GVBx8+m2saj8KKH249QK+L2a54PU2qhCPRfGW0xG17UfnFIWZBBklOg==
X-Received: by 2002:a2e:9c4d:: with SMTP id t13-v6mr957109ljj.153.1532077320048;
        Fri, 20 Jul 2018 02:02:00 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id w2-v6sm252394lje.73.2018.07.20.02.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Jul 2018 02:01:59 -0700 (PDT)
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Cc:     daniel.vetter@intel.com, andr2000@gmail.com, dongwon.kim@intel.com,
        matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v5 1/8] xen/grant-table: Make set/clear page private code shared
Date:   Fri, 20 Jul 2018 12:01:43 +0300
Message-Id: <20180720090150.24560-2-andr2000@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720090150.24560-1-andr2000@gmail.com>
References: <20180720090150.24560-1-andr2000@gmail.com>
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
index ba9f3eec2bd0..bb4840653bf2 100644
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
2.18.0

