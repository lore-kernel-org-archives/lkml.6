Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757431AbeEJOBf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 10:01:35 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43572 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757419AbeEJOBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 10:01:31 -0400
X-Google-Smtp-Source: AB8JxZoQAvYKxaq45579Z0Qp1VES3TWK/l2YniQC3RVweA+QvqpMJsJlwwXCJHbu+GVqO38+AKYveQ==
Date: Thu, 10 May 2018 19:33:35 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, ebiggers@google.com,
        viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kernel: relay: Change return type to vm_fault_t
Message-ID: <20180510140335.GA25363@jordon-HP-15-Notebook-PC>
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

commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 kernel/relay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index c302940..a8cdbf7 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -39,7 +39,7 @@ static void relay_file_mmap_close(struct vm_area_struct *vma)
 /*
  * fault() vm_op implementation for relay file mapping.
  */
-static int relay_buf_fault(struct vm_fault *vmf)
+static vm_fault_t relay_buf_fault(struct vm_fault *vmf)
 {
 	struct page *page;
 	struct rchan_buf *buf = vmf->vma->vm_private_data;
--
1.9.1
