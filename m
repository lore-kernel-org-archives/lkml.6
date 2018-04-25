Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDYEcT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 00:32:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:45601 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeDYEcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 00:32:18 -0400
X-Google-Smtp-Source: AIpwx4/djXaANtzYf5cGA5TlSPOexEs/kEiH6ui+bRRw7DQL3foT8WomJMXbFVoZKggHNM2N9XX9FA==
Date: Wed, 25 Apr 2018 10:04:13 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        manfred@colorfullife.com, dave@stgolabs.net, ebiederm@xmission.com,
        linux@dominikbrodowski.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] ipc: Adding new return type vm_fault_t
Message-ID: <20180425043413.GA21467@jordon-HP-15-Notebook-PC>
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

Commit 1c8f422059ae ("mm: change return type to vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
v2: Updated the change log

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
