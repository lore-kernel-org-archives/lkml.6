Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeDNU0l (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 16:26:41 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:43143 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751152AbeDNU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 16:26:40 -0400
X-Google-Smtp-Source: AIpwx48RBAJXUfAj0pJmBG2Rw7rHNVasK/A53rF3NdBeRlZZIebsbo54iff4+kIdKnQCFfKI6YfauQ==
Date: Sun, 15 Apr 2018 01:58:31 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] kernel: event: core: Change return type to vm_fault_t
Message-ID: <20180414202831.GA20373@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler and
page_mkwrite handler in struct vm_operations_struct.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 kernel/events/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 96db9ae..d09f1c4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4918,11 +4918,11 @@ void perf_event_update_userpage(struct perf_event *event)
 }
 EXPORT_SYMBOL_GPL(perf_event_update_userpage);

-static int perf_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t perf_mmap_fault(struct vm_fault *vmf)
 {
 	struct perf_event *event = vmf->vma->vm_file->private_data;
 	struct ring_buffer *rb;
-	int ret = VM_FAULT_SIGBUS;
+	vm_fault_t ret = VM_FAULT_SIGBUS;

 	if (vmf->flags & FAULT_FLAG_MKWRITE) {
 		if (vmf->pgoff == 0)
--
1.9.1
