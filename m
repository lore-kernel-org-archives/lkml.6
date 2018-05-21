Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeEUSOy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 14:14:54 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35624 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbeEUSOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 14:14:50 -0400
X-Google-Smtp-Source: AB8JxZqUpCvSw56pjZqpnQ5K0xg3P6lf2EBnZ5gQafQ3R1e7uTKowye5BbrenjmpLcyTFOUvtPJp4A==
Date: Mon, 21 May 2018 23:47:04 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: airlied@linux.ie, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH v2] char: agp: Change return type to vm_fault_t
Message-ID: <20180521181704.GA19646@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For now,
this is just documenting that the function returns a
VM_FAULT value rather than an errno. Once all instances are
converted, vm_fault_t will become a distinct type.

Ref-> commit 1c8f422059ae ("mm: change return type to
vm_fault_t") was added in 4.17-rc1 to introduce the new
typedef vm_fault_t. Currently we are making change to all
drivers to return vm_fault_t for page fault handlers. As
part of that char/agp driver is also getting changed to
return vm_fault_t type from fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/char/agp/alpha-agp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index 53fe633..c9bf2c2 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -11,7 +11,7 @@
 
 #include "agp.h"
 
-static int alpha_core_agp_vm_fault(struct vm_fault *vmf)
+static vm_fault_t alpha_core_agp_vm_fault(struct vm_fault *vmf)
 {
 	alpha_agp_info *agp = agp_bridge->dev_private_data;
 	dma_addr_t dma_addr;
-- 
1.9.1
