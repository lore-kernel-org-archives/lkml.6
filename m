Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752744AbeDQON4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 10:13:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43490 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeDQONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 10:13:54 -0400
X-Google-Smtp-Source: AIpwx48U1tK8+qYvQZwzwdqJQ9l0axoyRzktT0CI0/rwo1MVXn+5RczBBoECylC1DUZgAi3UjQUbOA==
Date: Tue, 17 Apr 2018 19:45:47 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: alexander.shishkin@linux.intel.com
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] hwtracing: intel_th: Change return type to vm_fault_t
Message-ID: <20180417141547.GA30799@jordon-HP-15-Notebook-PC>
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
 drivers/hwtracing/intel_th/msu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index dfb57ea..0ac84eb 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1190,7 +1190,7 @@ static void msc_mmap_close(struct vm_area_struct *vma)
 	mutex_unlock(&msc->buf_mutex);
 }

-static int msc_mmap_fault(struct vm_fault *vmf)
+static vm_fault_t msc_mmap_fault(struct vm_fault *vmf)
 {
 	struct msc_iter *iter = vmf->vma->vm_file->private_data;
 	struct msc *msc = iter->msc;
--
1.9.1
