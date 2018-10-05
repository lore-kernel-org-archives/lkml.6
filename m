Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADC9C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFE72084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m01qciC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFE72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbeJEK7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 06:59:22 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35467 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbeJEK7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 06:59:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so4136185pgb.2;
        Thu, 04 Oct 2018 21:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06kpAZHYKZG3hvFobEbSnj6k7+UsR1Ngfd/d8YfSvoY=;
        b=m01qciC3ihAX+OJYOJUHMVZJQUb2OHYOl4hJWZhhGfRtUaRe254M9NSR7MWq6eEnLG
         3GJ7RN5fBskGy+1f8TmRo+9gfRF67uw/W12/9wx9Drwc+DuODH/LzLuYvFTALPEOIdJm
         UivOvTtzO9HBgq64T3dNE0dHrY++PBEqS22Od1A91UQ7A41uKNmYrdbRh8pyNj5SFb3g
         nx4xsnG5ZQkbLsX0kYGEnrUpCvOSZ3ichQNQlcmLOOgHnzA2MLQ+qkcuAVhyWeTT79oq
         EntOuw16DUkfTFAEZIcyIG4X+oXC28W5cK02kdFQZZiHBtPEGi8rIm65CCDC/WvM5wnE
         t/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06kpAZHYKZG3hvFobEbSnj6k7+UsR1Ngfd/d8YfSvoY=;
        b=lrsUWemuCZwMe/XpvZH/djZYE3cTjKs0VWKRBCw99PXwShePTCcQXupDbvG3/V6pD+
         a7dPYDu2YS6tsVKnBqtkcYoPnjEU5Y6bI5tL+h9bfHmPlZXmHKah005xV+ChQegcpNJC
         hklA5ajDlUAtCuQBXRyT8zqZWBJj5zd1rD2hgJG68OW1gscFVe0ysshSMHk3eaUMRMpX
         kX3J6NNpXOZgWiljtA6zBD8d0mnGBob8wOIBWEuSasLLcZ82rwjDZj69XN3z7y6CJ6lh
         OoWagkv789BiujI/9H00snfGpu1Hl5w2Fif3jL+xCv1i+BwR61nIwrloeFa2KlM7tC6a
         UO7g==
X-Gm-Message-State: ABuFfojeixfas35rbts73CJrydjsrDKcMAD3p04VhB9ry4zMJxAbMHyc
        uIE53tZlxKSLrQkKXy5q4f8=
X-Google-Smtp-Source: ACcGV60bqr96u2KQwI/dbT7TXLTzDOPCI3TbVohRWSQxZcY4mSWa2YztvMFams7Dx3hHS7DAC3Xfpw==
X-Received: by 2002:a65:668d:: with SMTP id b13-v6mr8326568pgw.163.1538712153246;
        Thu, 04 Oct 2018 21:02:33 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id c2-v6sm8787899pfo.107.2018.10.04.21.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 21:02:32 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: [PATCH v2 3/3] infiniband/mm: convert to the new put_user_page[s]() calls
Date:   Thu,  4 Oct 2018 21:02:25 -0700
Message-Id: <20181005040225.14292-4-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005040225.14292-1-jhubbard@nvidia.com>
References: <20181005040225.14292-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hubbard <jhubbard@nvidia.com>

For code that retains pages via get_user_pages*(),
release those pages via the new put_user_page(),
instead of put_page().

This prepares for eventually fixing the problem described
in [1], and is following a plan listed in [2], [3], [4].

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

[2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
    Proposed steps for fixing get_user_pages() + DMA problems.

[3]https://lkml.kernel.org/r/20180710082100.mkdwngdv5kkrcz6n@quack2.suse.cz
    Bounce buffers (otherwise [2] is not really viable).

[4] https://lkml.kernel.org/r/20181003162115.GG24030@quack2.suse.cz
    Follow-up discussions.

CC: Doug Ledford <dledford@redhat.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>
CC: Mike Marciniszyn <mike.marciniszyn@intel.com>
CC: Dennis Dalessandro <dennis.dalessandro@intel.com>
CC: Christian Benvenuti <benve@cisco.com>

CC: linux-rdma@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-mm@kvack.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/infiniband/core/umem.c              |  2 +-
 drivers/infiniband/core/umem_odp.c          |  2 +-
 drivers/infiniband/hw/hfi1/user_pages.c     | 11 ++++-------
 drivers/infiniband/hw/mthca/mthca_memfree.c |  6 +++---
 drivers/infiniband/hw/qib/qib_user_pages.c  | 11 ++++-------
 drivers/infiniband/hw/qib/qib_user_sdma.c   |  8 ++++----
 drivers/infiniband/hw/usnic/usnic_uiom.c    |  2 +-
 7 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index a41792dbae1f..9430d697cb9f 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -60,7 +60,7 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 		page = sg_page(sg);
 		if (!PageDirty(page) && umem->writable && dirty)
 			set_page_dirty_lock(page);
-		put_page(page);
+		put_user_page(page);
 	}
 
 	sg_free_table(&umem->sg_head);
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 6ec748eccff7..6227b89cf05c 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -717,7 +717,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem *umem, u64 user_virt, u64 bcnt,
 					ret = -EFAULT;
 					break;
 				}
-				put_page(local_page_list[j]);
+				put_user_page(local_page_list[j]);
 				continue;
 			}
 
diff --git a/drivers/infiniband/hw/hfi1/user_pages.c b/drivers/infiniband/hw/hfi1/user_pages.c
index e341e6dcc388..99ccc0483711 100644
--- a/drivers/infiniband/hw/hfi1/user_pages.c
+++ b/drivers/infiniband/hw/hfi1/user_pages.c
@@ -121,13 +121,10 @@ int hfi1_acquire_user_pages(struct mm_struct *mm, unsigned long vaddr, size_t np
 void hfi1_release_user_pages(struct mm_struct *mm, struct page **p,
 			     size_t npages, bool dirty)
 {
-	size_t i;
-
-	for (i = 0; i < npages; i++) {
-		if (dirty)
-			set_page_dirty_lock(p[i]);
-		put_page(p[i]);
-	}
+	if (dirty)
+		put_user_pages_dirty_lock(p, npages);
+	else
+		put_user_pages(p, npages);
 
 	if (mm) { /* during close after signal, mm can be NULL */
 		down_write(&mm->mmap_sem);
diff --git a/drivers/infiniband/hw/mthca/mthca_memfree.c b/drivers/infiniband/hw/mthca/mthca_memfree.c
index cc9c0c8ccba3..b8b12effd009 100644
--- a/drivers/infiniband/hw/mthca/mthca_memfree.c
+++ b/drivers/infiniband/hw/mthca/mthca_memfree.c
@@ -481,7 +481,7 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
 
 	ret = pci_map_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
 	if (ret < 0) {
-		put_page(pages[0]);
+		put_user_page(pages[0]);
 		goto out;
 	}
 
@@ -489,7 +489,7 @@ int mthca_map_user_db(struct mthca_dev *dev, struct mthca_uar *uar,
 				 mthca_uarc_virt(dev, uar, i));
 	if (ret) {
 		pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
-		put_page(sg_page(&db_tab->page[i].mem));
+		put_user_page(sg_page(&db_tab->page[i].mem));
 		goto out;
 	}
 
@@ -555,7 +555,7 @@ void mthca_cleanup_user_db_tab(struct mthca_dev *dev, struct mthca_uar *uar,
 		if (db_tab->page[i].uvirt) {
 			mthca_UNMAP_ICM(dev, mthca_uarc_virt(dev, uar, i), 1);
 			pci_unmap_sg(dev->pdev, &db_tab->page[i].mem, 1, PCI_DMA_TODEVICE);
-			put_page(sg_page(&db_tab->page[i].mem));
+			put_user_page(sg_page(&db_tab->page[i].mem));
 		}
 	}
 
diff --git a/drivers/infiniband/hw/qib/qib_user_pages.c b/drivers/infiniband/hw/qib/qib_user_pages.c
index 16543d5e80c3..1a5c64c8695f 100644
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -40,13 +40,10 @@
 static void __qib_release_user_pages(struct page **p, size_t num_pages,
 				     int dirty)
 {
-	size_t i;
-
-	for (i = 0; i < num_pages; i++) {
-		if (dirty)
-			set_page_dirty_lock(p[i]);
-		put_page(p[i]);
-	}
+	if (dirty)
+		put_user_pages_dirty_lock(p, num_pages);
+	else
+		put_user_pages(p, num_pages);
 }
 
 /*
diff --git a/drivers/infiniband/hw/qib/qib_user_sdma.c b/drivers/infiniband/hw/qib/qib_user_sdma.c
index 926f3c8eba69..14f94d823907 100644
--- a/drivers/infiniband/hw/qib/qib_user_sdma.c
+++ b/drivers/infiniband/hw/qib/qib_user_sdma.c
@@ -266,7 +266,7 @@ static void qib_user_sdma_init_frag(struct qib_user_sdma_pkt *pkt,
 	pkt->addr[i].length = len;
 	pkt->addr[i].first_desc = first_desc;
 	pkt->addr[i].last_desc = last_desc;
-	pkt->addr[i].put_page = put_page;
+	pkt->addr[i].put_page = put_user_page;
 	pkt->addr[i].dma_mapped = dma_mapped;
 	pkt->addr[i].page = page;
 	pkt->addr[i].kvaddr = kvaddr;
@@ -321,7 +321,7 @@ static int qib_user_sdma_page_to_frags(const struct qib_devdata *dd,
 		 * the caller can ignore this page.
 		 */
 		if (put) {
-			put_page(page);
+			put_user_page(page);
 		} else {
 			/* coalesce case */
 			kunmap(page);
@@ -635,7 +635,7 @@ static void qib_user_sdma_free_pkt_frag(struct device *dev,
 			kunmap(pkt->addr[i].page);
 
 		if (pkt->addr[i].put_page)
-			put_page(pkt->addr[i].page);
+			put_user_page(pkt->addr[i].page);
 		else
 			__free_page(pkt->addr[i].page);
 	} else if (pkt->addr[i].kvaddr) {
@@ -710,7 +710,7 @@ static int qib_user_sdma_pin_pages(const struct qib_devdata *dd,
 	/* if error, return all pages not managed by pkt */
 free_pages:
 	while (i < j)
-		put_page(pages[i++]);
+		put_user_page(pages[i++]);
 
 done:
 	return ret;
diff --git a/drivers/infiniband/hw/usnic/usnic_uiom.c b/drivers/infiniband/hw/usnic/usnic_uiom.c
index 9dd39daa602b..0f607f31c262 100644
--- a/drivers/infiniband/hw/usnic/usnic_uiom.c
+++ b/drivers/infiniband/hw/usnic/usnic_uiom.c
@@ -91,7 +91,7 @@ static void usnic_uiom_put_pages(struct list_head *chunk_list, int dirty)
 			pa = sg_phys(sg);
 			if (!PageDirty(page) && dirty)
 				set_page_dirty_lock(page);
-			put_page(page);
+			put_user_page(page);
 			usnic_dbg("pa: %pa\n", &pa);
 		}
 		kfree(chunk);
-- 
2.19.0

