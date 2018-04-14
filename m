Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeDNU1z (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 16:27:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33202 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeDNU1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 16:27:54 -0400
X-Google-Smtp-Source: AIpwx48ik0ZNKxnE2PG1sl0jkrz8tyGyYqO4NyFS7t05R1f30DDXtIABDtsusycGal2gikJWVCCWmw==
Date: Sun, 15 Apr 2018 01:59:45 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: willy@infradead.org
Subject: [PATCH] kernel: relay: Change return type to vm_fault_t
Message-ID: <20180414202945.GA20388@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct.

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
