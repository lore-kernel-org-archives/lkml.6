Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C890C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EECB216FA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXY94iVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EECB216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeI1MCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:02:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46627 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbeI1MCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:02:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so3574591pga.13;
        Thu, 27 Sep 2018 22:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThRzzWpBpu4s48OlpLDvaH54RyEw4MNxyT1MO+mJU2I=;
        b=oXY94iVcGXqVYOVsyrL60tx2EzoBczbAy7YBhVQxjcdSZwlYXxbKExa7jHilnyBs8j
         QjC/djhpqbPVPN2GVY6qxBzo5aGhRhctuMyuEI+QGGxAwT19qkBBOAgmkN2OyldBOK2B
         J34ONI5c9LN6PuRNaDTr6FvxiB5+22YkdxGdDuGqplcxyV5kcJEl0uNd1AJF8FhS9Kmx
         WzWt8MXU7ZeKczlfdbiurh5O76NeEvJjldxaGyWe4ugD+9nBDb4H2Zhw2GROcBXHGbAB
         W08O7RBUef9IkTYmBKAxyKZqAkRfQAA3g6sNszemh9ALVphLjZwFt/xc46Lhh+LzCjAE
         VcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThRzzWpBpu4s48OlpLDvaH54RyEw4MNxyT1MO+mJU2I=;
        b=jZ1tRDd9ByViy3a7a6TyaF9B+5fME6XUjZX1l4BZVY5MZRpMOGTw6XpviPGnLrhY09
         t+gnyMSEBmktoYvtOQoKj8PYgpFOg3BMARDlbTQX4myCm1mRXA4mo0f6yy7gXQhLeOPQ
         1wfqYmqEGDzF7GkWsNUkufnD0UikVlXvcHICdYB/M7yQN1RuwlgLXw8G+h48Vz4xEU+O
         VQ+Dvi2A1lR1JeyMQxhGMoehudJ9vImvR+RFq8cnGBuR8mMxmXhNNC7u2wOoYCP137IO
         68/WtkAyXsBfvg/BpiMMYVEVwQOUSOCaZvWX/PtJ2GQ/rxc4Iymc3KezMtJstsb3kZ2G
         jp2w==
X-Gm-Message-State: ABuFfohImc7aYk+ewp5pHHWjwVZLNHDShOUcI0vbOuUd8mkHTWLx0GQg
        Jfd6q+/dJVwlwiJsABB0vdA=
X-Google-Smtp-Source: ACcGV63im43pJbETQH3bFshzFo7dV3xsDzH3NWhLxzp7kBSMLcE3yPW9Bruuq2pUeXW/hVOToZUwbg==
X-Received: by 2002:a65:6409:: with SMTP id a9-v6mr5126447pgv.204.1538113199449;
        Thu, 27 Sep 2018 22:39:59 -0700 (PDT)
Received: from blueforge.nvidia.com (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id u9-v6sm6569953pfi.104.2018.09.27.22.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 22:39:58 -0700 (PDT)
From:   john.hubbard@gmail.com
X-Google-Original-From: jhubbard@nvidia.com
To:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: [PATCH 3/4] infiniband/mm: convert to the new put_user_page() call
Date:   Thu, 27 Sep 2018 22:39:47 -0700
Message-Id: <20180928053949.5381-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180928053949.5381-1-jhubbard@nvidia.com>
References: <20180928053949.5381-1-jhubbard@nvidia.com>
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
in [1], and is following a plan listed in [2].

[1] https://lwn.net/Articles/753027/ : "The Trouble with get_user_pages()"

[2] https://lkml.kernel.org/r/20180709080554.21931-1-jhubbard@nvidia.com
    Proposed steps for fixing get_user_pages() + DMA problems.

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
 drivers/infiniband/core/umem.c              | 2 +-
 drivers/infiniband/core/umem_odp.c          | 2 +-
 drivers/infiniband/hw/hfi1/user_pages.c     | 2 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c | 6 +++---
 drivers/infiniband/hw/qib/qib_user_pages.c  | 2 +-
 drivers/infiniband/hw/qib/qib_user_sdma.c   | 8 ++++----
 drivers/infiniband/hw/usnic/usnic_uiom.c    | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

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
index e341e6dcc388..c7516029af33 100644
--- a/drivers/infiniband/hw/hfi1/user_pages.c
+++ b/drivers/infiniband/hw/hfi1/user_pages.c
@@ -126,7 +126,7 @@ void hfi1_release_user_pages(struct mm_struct *mm, struct page **p,
 	for (i = 0; i < npages; i++) {
 		if (dirty)
 			set_page_dirty_lock(p[i]);
-		put_page(p[i]);
+		put_user_page(p[i]);
 	}
 
 	if (mm) { /* during close after signal, mm can be NULL */
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
index 16543d5e80c3..3f8fd42dd7fc 100644
--- a/drivers/infiniband/hw/qib/qib_user_pages.c
+++ b/drivers/infiniband/hw/qib/qib_user_pages.c
@@ -45,7 +45,7 @@ static void __qib_release_user_pages(struct page **p, size_t num_pages,
 	for (i = 0; i < num_pages; i++) {
 		if (dirty)
 			set_page_dirty_lock(p[i]);
-		put_page(p[i]);
+		put_user_page(p[i]);
 	}
 }
 
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

