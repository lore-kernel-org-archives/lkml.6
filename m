Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312FEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E28B220833
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:10:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E28B220833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeI0Q2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:28:09 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeI0Q2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:28:09 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MirfG-1fZRp10R0e-00ey8H; Thu, 27 Sep 2018 12:10:19 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MirfG-1fZRp10R0e-00ey8H; Thu, 27 Sep 2018 12:10:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Arnd Bergmann <arnd@arndb.de>, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Matan Barak <matanb@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Huy Nguyen <huyn@mellanox.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/ucontext: fix building with CONFIG_MMU=n
Date:   Thu, 27 Sep 2018 12:10:03 +0200
Message-Id: <20180927101017.990471-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:3BtBNrFcgwoEjYfk6eNDJwm3+KhEaGLVUDVgNMa9+XQ6NIwC2St
 QCAIqGeIzNE+ZiXAtigG/qgXfkNKAGWELR9NfVI5u/Td2Zwommt5zazWLc0kGNzCxtdyEXH
 HvqDsUrlTaEujgIT95fGcKuy8boAIPcV4MFs57pMEM1IaB7VGgG0UXFhSiq7U+9AWxtf4I8
 87IXwlyaOB21ZN/3VO8sA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:scaJkVlG0II=:+Blvh5LMPxhld0/EVUedbI
 qlITSWWg+PwkxO3vuki7AvQSn0qIGJvScyUrJJO8YknCBWBgeyxUrOHxL4geJYclcQ//xlsJT
 4hv4qouYSrW/pWq5sz0mI29VrT/i2LLlZWZaH7F28j8nEBY7tALDantRpM46DCG7GH93m8lcq
 EeKdSajjdqQfXq8IG9Z0RX7DzsuUJ3S0igQKSTEip7FXkg1XaTtb5d9sF5VcOzutYrwM8iT1l
 9sUws0Z3XUox2R98hanzC5oIyL3s3GPfiv71sNJdId2Qpw0BzCGmYuG+6KYs9F+stEzzlFz0Q
 Cs3FAdATmjjiQcBJ7Hy/3oxwLEcKab7vBlTX6nNFADwp+yKMJHyNu18uYd/TruZ+dy8YyfRcU
 dcRHR1b0yIiwGL0UIjx4h46GEe7liPAQu24PAsEXIG4mmgk8PW5bahXSqNn2D2En6fctkfsHE
 LKYb8/fHMwI1NRlnJXBhTPPREFx+19btPBOo81eiqT4Xq0SqFgegZV9IkosTQUBR/+Y2uR55E
 cs/Ve9eCmzTBTP0m5O55pfIHMDP198sg+vpOUIZ7SdPtIZXCH2471pjIFgOtU/3F+jfN4/KvL
 gXLS3dp7c/+/JwbRqy4fGtIZttaF98v6L9RU19oNSbzkyJfIo6pcumnxVbGd/DoMWPzCh+Lmy
 xitK+SJpJbITH6kt9KkYREfQTla5vUKoQ/Vru15K2cspgXnmwV+PHfFOnHeu2Yf0IBtw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zap_vma_ptes() is declared but not defined on NOMMU kernels,
causing a link error for the newly added uverbs code:

drivers/infiniband/core/uverbs_main.o: In function `uverbs_user_mmap_disassociate':
uverbs_main.c:(.text+0x114c): undefined reference to `zap_vma_ptes'
drivers/infiniband/core/uverbs_main.o: In function `rdma_umap_open':
uverbs_main.c:(.text+0x53c): undefined reference to `zap_vma_ptes'

To fix this, we can either make uverbs depend on CONFIG_MMU, or try
to build it anyway. Since this is the only compile-time dependency,
I decided to allow building it with an extra compile-time check for
CONFIG_MMU before calling the one function.

Fixes: 5f9794dc94f5 ("RDMA/ucontext: Add a core API for mmaping driver IO memory")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/core/uverbs_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 40dcf3d02a4b..5c1202af0748 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -884,7 +884,8 @@ static void rdma_umap_open(struct vm_area_struct *vma)
 	 * point, so zap it.
 	 */
 	vma->vm_private_data = NULL;
-	zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
+	if (IS_ENABLED(CONFIG_MMU))
+		zap_vma_ptes(vma, vma->vm_start, vma->vm_end - vma->vm_start);
 }
 
 static void rdma_umap_close(struct vm_area_struct *vma)
@@ -1023,8 +1024,9 @@ void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile)
 				continue;
 			list_del_init(&priv->list);
 
-			zap_vma_ptes(vma, vma->vm_start,
-				     vma->vm_end - vma->vm_start);
+			if (IS_ENABLED(CONFIG_MMU))
+				zap_vma_ptes(vma, vma->vm_start,
+					     vma->vm_end - vma->vm_start);
 			vma->vm_flags &= ~(VM_SHARED | VM_MAYSHARE);
 		}
 		mutex_unlock(&ufile->umap_lock);
-- 
2.18.0

