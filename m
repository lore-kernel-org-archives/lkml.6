Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeDRSpY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:45:24 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41424 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751830AbeDRSpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:45:22 -0400
X-Google-Smtp-Source: AIpwx48AIawAaJqsSLLRsgFehJn+xNniyoH4y//B6CqHh0acBMjbe//CIQ5gOVn4kWUhM0fMOn5ERQ==
Date: Thu, 19 Apr 2018 00:17:16 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: sakari.ailus@iki.fi, mchehab@kernel.org, jack@suse.cz,
        dan.j.williams@intel.com
Cc: akpm@linux-foundation.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH v3] videobuf: Change return type to vm_fault_t
Message-ID: <20180418184716.GA25507@jordon-HP-15-Notebook-PC>
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
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
v2: Updated patch subject

v3: Correcting patch subject

 drivers/media/v4l2-core/videobuf-dma-sg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/videobuf-dma-sg.c b/drivers/media/v4l2-core/videobuf-dma-sg.c
index f412429..54257ea 100644
--- a/drivers/media/v4l2-core/videobuf-dma-sg.c
+++ b/drivers/media/v4l2-core/videobuf-dma-sg.c
@@ -435,7 +435,7 @@ static void videobuf_vm_close(struct vm_area_struct *vma)
  * now ...).  Bounce buffers don't work very well for the data rates
  * video capture has.
  */
-static int videobuf_vm_fault(struct vm_fault *vmf)
+static vm_fault_t videobuf_vm_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
--
1.9.1
