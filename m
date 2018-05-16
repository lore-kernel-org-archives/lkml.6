Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeEPFoV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 01:44:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57114 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbeEPFoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 01:44:16 -0400
From: Christoph Hellwig <hch@lst.de>
To: Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, devel@lists.orangefs.org,
        ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        linux-mtd@lists.infradead.org, dri-devel@lists.freedesktop.org,
        lustre-devel@lists.lustre.org, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 02/14] fs: make the filemap_page_mkwrite prototype consistent
Date: Wed, 16 May 2018 07:43:36 +0200
Message-Id: <20180516054348.15950-3-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516054348.15950-1-hch@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

!CONFIG_MMU version didn't agree with the rest of the kernel..

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 52517f28e6f4..cf21ced98eff 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2748,7 +2748,7 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_mmap(file, vma);
 }
 #else
-int filemap_page_mkwrite(struct vm_fault *vmf)
+vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	return -ENOSYS;
 }
-- 
2.17.0
