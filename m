Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757414AbeEJSZP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:25:15 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44849 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757247AbeEJSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:25:13 -0400
X-Google-Smtp-Source: AB8JxZpGI7132HnH9tWiEkGxT0f45R0tzBDhIE3tB/hiTs59AKMOHODc472JF9oy8Z2lf0kqxZ9rFw==
Date: Thu, 10 May 2018 23:57:19 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
        willy@infradead.org
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc: kvm: Change return type to vm_fault_t
Message-ID: <20180510182719.GA22217@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler
in struct vm_operations_struct. For now, this is
just documenting that the function returns a 
VM_FAULT value rather than an errno.  Once all
instances are converted, vm_fault_t will become
a distinct type.

commit 1c8f422059ae ("mm: change return type to
vm_fault_t")

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
v2: Updated the change log

 arch/powerpc/kvm/book3s_64_vio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index 4dffa61..346ac0d 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -237,7 +237,7 @@ static void release_spapr_tce_table(struct rcu_head *head)
 	kfree(stt);
 }

-static int kvm_spapr_tce_fault(struct vm_fault *vmf)
+static vm_fault_t kvm_spapr_tce_fault(struct vm_fault *vmf)
 {
 	struct kvmppc_spapr_tce_table *stt = vmf->vma->vm_file->private_data;
 	struct page *page;
--
1.9.1
