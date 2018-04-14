Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeDNUWm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 16:22:42 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39299 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751355AbeDNUWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 16:22:41 -0400
X-Google-Smtp-Source: AIpwx487RLhSDdpS9JvpYehzoMdRS9rxdkBK09IJWzEjriTnv+n0eZsV/GLmwHu7e+X7ZLdODBDu4A==
Date: Sun, 15 Apr 2018 01:54:32 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: willy@infradead.org
Subject: [PATCH] ipc: Adding new return type vm_fault_t
Message-ID: <20180414202432.GA20356@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 ipc/shm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index 4643865..2ba0cfc 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -378,7 +378,7 @@ void exit_shm(struct task_struct *task)
 	up_write(&shm_ids(ns).rwsem);
 }
 
-static int shm_fault(struct vm_fault *vmf)
+static vm_fault_t shm_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
 	struct shm_file_data *sfd = shm_file_data(file);
-- 
1.9.1
