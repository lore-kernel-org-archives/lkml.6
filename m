Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeDQOci (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:32:38 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41302 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752086AbeDQOcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:32:35 -0400
X-Google-Smtp-Source: AIpwx4/h+pB2lvQqUKX96owr31x3kdEtkPi0kAQjAxOIKWSkOPE07eL8N+J93E8pCVVCzRdE1/v1tA==
Date: Tue, 17 Apr 2018 20:04:28 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] infiniband: hw: qib: Change return type to vm_fault_t
Message-ID: <20180417143428.GA31255@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For
now, this is just documenting that the function returns
a VM_FAULT value rather than an errno. Once all instances
are converted, vm_fault_t will become a distinct type.

Reference id -> 1c8f422059ae ("mm: change return type to
vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/infiniband/hw/qib/qib_file_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qib/qib_file_ops.c b/drivers/infiniband/hw/qib/qib_file_ops.c
index 52c29db3..52aea84 100644
--- a/drivers/infiniband/hw/qib/qib_file_ops.c
+++ b/drivers/infiniband/hw/qib/qib_file_ops.c
@@ -868,7 +868,7 @@ static int mmap_rcvegrbufs(struct vm_area_struct *vma,
 /*
  * qib_file_vma_fault - handle a VMA page fault.
  */
-static int qib_file_vma_fault(struct vm_fault *vmf)
+static vm_fault_t qib_file_vma_fault(struct vm_fault *vmf)
 {
 	struct page *page;

--
1.9.1
