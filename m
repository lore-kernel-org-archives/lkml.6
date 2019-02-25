Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCFF2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130072;
	bh=sHPnrT2yXwxr1eTX9ZvsKEMSf0k2QoFlH27m6qrac1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a5W9ghuOa1HvbXzhLKx8DVWGXjLSMAvHq9PpWIqOa8gnOIgWGizvzXHE5id34i9lH
	 B8viEACz2EkfUIZupg6I+BGu3/QVRgeGI3Oko5v2K+pG1Frfeh6U6zUmuxEvfE2yVa
	 p4aymnkBFx9WL/skzGOMdrZ4IO1fBU2djxa7iyl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730567AbfBYV1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:27:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730954AbfBYV1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:27:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7F252087C;
        Mon, 25 Feb 2019 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130067;
        bh=sHPnrT2yXwxr1eTX9ZvsKEMSf0k2QoFlH27m6qrac1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u1whRjzd/Vbm2wZtj4iig8wP9sJqh1kH+Nji+U66zeq7qXJhl6btzA8DlqNuEijLf
         dbv1IJzPwJ8gbl5s9SzXp6XF8/tX0fEumbwyAS/2Pev7y/hpw6R2ipgRhIdUki2U5I
         01Oe+KqifSRPOMnS+5bX6bq1veEgvnxbRfy/X2f0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4.19 143/152] staging: erofs: unzip_{pagevec.h,vle.c}: rectify BUG_ONs
Date:   Mon, 25 Feb 2019 22:12:15 +0100
Message-Id: <20190225195054.235076108@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit 70b17991d89554cdd16f3e4fb0179bcc03c808d9 upstream.

remove all redundant BUG_ONs, and turn the rest
useful usages to DBG_BUGONs.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 drivers/staging/erofs/unzip_pagevec.h |    2 -
 drivers/staging/erofs/unzip_vle.c     |   35 +++++++++++++---------------------
 2 files changed, 15 insertions(+), 22 deletions(-)

--- a/drivers/staging/erofs/unzip_pagevec.h
+++ b/drivers/staging/erofs/unzip_pagevec.h
@@ -150,7 +150,7 @@ z_erofs_pagevec_ctor_dequeue(struct z_er
 	erofs_vtptr_t t;
 
 	if (unlikely(ctor->index >= ctor->nr)) {
-		BUG_ON(ctor->next == NULL);
+		DBG_BUGON(!ctor->next);
 		z_erofs_pagevec_ctor_pagedown(ctor, true);
 	}
 
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -18,9 +18,6 @@ static struct kmem_cache *z_erofs_workgr
 
 void z_erofs_exit_zip_subsystem(void)
 {
-	BUG_ON(z_erofs_workqueue == NULL);
-	BUG_ON(z_erofs_workgroup_cachep == NULL);
-
 	destroy_workqueue(z_erofs_workqueue);
 	kmem_cache_destroy(z_erofs_workgroup_cachep);
 }
@@ -363,7 +360,10 @@ z_erofs_vle_work_register(struct super_b
 	struct z_erofs_vle_work *work;
 
 	/* if multiref is disabled, grp should never be nullptr */
-	BUG_ON(grp != NULL);
+	if (unlikely(grp)) {
+		DBG_BUGON(1);
+		return ERR_PTR(-EINVAL);
+	}
 
 	/* no available workgroup, let's allocate one */
 	grp = kmem_cache_zalloc(z_erofs_workgroup_cachep, GFP_NOFS);
@@ -742,7 +742,7 @@ static inline void z_erofs_vle_read_endi
 		bool cachemngd = false;
 
 		DBG_BUGON(PageUptodate(page));
-		BUG_ON(page->mapping == NULL);
+		DBG_BUGON(!page->mapping);
 
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
 		if (unlikely(mngda == NULL && !z_erofs_is_stagingpage(page))) {
@@ -800,7 +800,7 @@ static int z_erofs_vle_unzip(struct supe
 
 	might_sleep();
 	work = z_erofs_vle_grab_primary_work(grp);
-	BUG_ON(!READ_ONCE(work->nr_pages));
+	DBG_BUGON(!READ_ONCE(work->nr_pages));
 
 	mutex_lock(&work->lock);
 	nr_pages = work->nr_pages;
@@ -849,8 +849,8 @@ repeat:
 		else
 			pagenr = z_erofs_onlinepage_index(page);
 
-		BUG_ON(pagenr >= nr_pages);
-		BUG_ON(pages[pagenr] != NULL);
+		DBG_BUGON(pagenr >= nr_pages);
+		DBG_BUGON(pages[pagenr]);
 
 		pages[pagenr] = page;
 	}
@@ -873,9 +873,8 @@ repeat:
 		if (z_erofs_is_stagingpage(page))
 			continue;
 #ifdef EROFS_FS_HAS_MANAGED_CACHE
-		else if (page->mapping == mngda) {
-			BUG_ON(PageLocked(page));
-			BUG_ON(!PageUptodate(page));
+		if (page->mapping == mngda) {
+			DBG_BUGON(!PageUptodate(page));
 			continue;
 		}
 #endif
@@ -883,8 +882,8 @@ repeat:
 		/* only non-head page could be reused as a compressed page */
 		pagenr = z_erofs_onlinepage_index(page);
 
-		BUG_ON(pagenr >= nr_pages);
-		BUG_ON(pages[pagenr] != NULL);
+		DBG_BUGON(pagenr >= nr_pages);
+		DBG_BUGON(pages[pagenr]);
 		++sparsemem_pages;
 		pages[pagenr] = page;
 
@@ -894,9 +893,6 @@ repeat:
 	llen = (nr_pages << PAGE_SHIFT) - work->pageofs;
 
 	if (z_erofs_vle_workgrp_fmt(grp) == Z_EROFS_VLE_WORKGRP_FMT_PLAIN) {
-		/* FIXME! this should be fixed in the future */
-		BUG_ON(grp->llen != llen);
-
 		err = z_erofs_vle_plain_copy(compressed_pages, clusterpages,
 			pages, nr_pages, work->pageofs);
 		goto out;
@@ -911,10 +907,8 @@ repeat:
 	if (err != -ENOTSUPP)
 		goto out_percpu;
 
-	if (sparsemem_pages >= nr_pages) {
-		BUG_ON(sparsemem_pages > nr_pages);
+	if (sparsemem_pages >= nr_pages)
 		goto skip_allocpage;
-	}
 
 	for (i = 0; i < nr_pages; ++i) {
 		if (pages[i] != NULL)
@@ -1007,7 +1001,7 @@ static void z_erofs_vle_unzip_wq(struct
 		struct z_erofs_vle_unzip_io_sb, io.u.work);
 	LIST_HEAD(page_pool);
 
-	BUG_ON(iosb->io.head == Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
+	DBG_BUGON(iosb->io.head == Z_EROFS_VLE_WORKGRP_TAIL_CLOSED);
 	z_erofs_vle_unzip_all(iosb->sb, &iosb->io, &page_pool);
 
 	put_pages_list(&page_pool);
@@ -1336,7 +1330,6 @@ static inline int __z_erofs_vle_normalac
 			continue;
 		}
 
-		BUG_ON(PagePrivate(page));
 		set_page_private(page, (unsigned long)head);
 		head = page;
 	}


