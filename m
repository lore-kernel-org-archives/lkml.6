Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB497C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A988420578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130711;
	bh=jbrQ+umqOKjYZXS5I9+yVkUGW/Zde2VF6OsCm8Pw7Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W73ZjbSt1P4Dll59f5DW79t8UcaspWahtRMjIgRf+L5yns5ZTkIE7EG/NjzGfA6W7
	 /gw9IQA+W4YGnGcahJ08OoT28lwPO2eFFcltB9awip2vqZrElRFI3Nmp7QDqCFWwHo
	 9ydb6nJCugWIUx2hU3oAkyTleC5SzKnFyMIbkVZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbfBYVg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733268AbfBYVgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:36:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D0320578;
        Mon, 25 Feb 2019 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130615;
        bh=jbrQ+umqOKjYZXS5I9+yVkUGW/Zde2VF6OsCm8Pw7Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfMiHSRwMm/8uR6qCh0+Rdw9dj1NIVmQJBBY+OQGmYRvON28EBk/DIa/nY1rH4M5c
         Dtp5wN+dA/QsrLjixsKSn9C3xlKJNzOe2SArgYZJfjFoOzWnGzp04C44SELKx1rSOF
         FzriVkUPqf+bu1IoQVtIE4csJ/I2i2CD4Qzp6bzY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gao Xiang <gaoxiang25@huawei.com>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4.20 176/183] staging: erofs: unzip_vle_lz4.c,utils.c: rectify BUG_ONs
Date:   Mon, 25 Feb 2019 22:12:29 +0100
Message-Id: <20190225195124.815038636@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <gaoxiang25@huawei.com>

commit b8e076a6ef253e763bfdb81e5c72bcc828b0fbeb upstream.

remove all redundant BUG_ONs, and turn the rest
useful usages to DBG_BUGONs.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/erofs/unzip_vle_lz4.c |    2 +-
 drivers/staging/erofs/utils.c         |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -57,7 +57,7 @@ int z_erofs_vle_plain_copy(struct page *
 			if (compressed_pages[j] != page)
 				continue;
 
-			BUG_ON(mirrored[j]);
+			DBG_BUGON(mirrored[j]);
 			memcpy(percpu_data + j * PAGE_SIZE, dst, PAGE_SIZE);
 			mirrored[j] = true;
 			break;
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -23,9 +23,6 @@ struct page *erofs_allocpage(struct list
 		list_del(&page->lru);
 	} else {
 		page = alloc_pages(gfp | __GFP_NOFAIL, 0);
-
-		BUG_ON(page == NULL);
-		BUG_ON(page->mapping != NULL);
 	}
 	return page;
 }
@@ -58,7 +55,7 @@ repeat:
 		/* decrease refcount added by erofs_workgroup_put */
 		if (unlikely(oldcount == 1))
 			atomic_long_dec(&erofs_global_shrink_cnt);
-		BUG_ON(index != grp->index);
+		DBG_BUGON(index != grp->index);
 	}
 	rcu_read_unlock();
 	return grp;
@@ -71,8 +68,11 @@ int erofs_register_workgroup(struct supe
 	struct erofs_sb_info *sbi;
 	int err;
 
-	/* grp->refcount should not < 1 */
-	BUG_ON(!atomic_read(&grp->refcount));
+	/* grp shouldn't be broken or used before */
+	if (unlikely(atomic_read(&grp->refcount) != 1)) {
+		DBG_BUGON(1);
+		return -EINVAL;
+	}
 
 	err = radix_tree_preload(GFP_NOFS);
 	if (err)


