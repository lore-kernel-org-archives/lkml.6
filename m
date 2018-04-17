Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753754AbeDQNzv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:55:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36683 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbeDQNzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:55:50 -0400
X-Google-Smtp-Source: AIpwx48o3otK13CTDTbnktX8DRBBoSuBh6vm8Lnf65curA+AK1xkFIt9TdvUBvKxQR3qgTlC7dtf6w==
Date: Tue, 17 Apr 2018 19:27:42 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: sre@kernel.org, viro@zeniv.linux.org.uk, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] hsi: clients: Change return type to vm_fault_t
Message-ID: <20180417135742.GA30368@jordon-HP-15-Notebook-PC>
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
 drivers/hsi/clients/cmt_speech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hsi/clients/cmt_speech.c b/drivers/hsi/clients/cmt_speech.c
index 324cb8e..a1d4b93 100644
--- a/drivers/hsi/clients/cmt_speech.c
+++ b/drivers/hsi/clients/cmt_speech.c
@@ -1098,7 +1098,7 @@ static void cs_hsi_stop(struct cs_hsi_iface *hi)
 	kfree(hi);
 }

-static int cs_char_vma_fault(struct vm_fault *vmf)
+static vm_fault_t cs_char_vma_fault(struct vm_fault *vmf)
 {
 	struct cs_char *csdata = vmf->vma->vm_private_data;
 	struct page *page;
--
1.9.1
