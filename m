Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeCZOht (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 10:37:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751677AbeCZOhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 10:37:48 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh@kernel.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        "Tyrel Datwyler" <tyreld@linux.vnet.ibm.com>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] powerpc: Fix error return code in ppc4xx_msi_probe()
Date: Mon, 26 Mar 2018 14:43:09 +0000
Message-ID: <1522075389-23511-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/powerpc/platforms/4xx/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/4xx/msi.c b/arch/powerpc/platforms/4xx/msi.c
index 4b859c8..0b71c52 100644
--- a/arch/powerpc/platforms/4xx/msi.c
+++ b/arch/powerpc/platforms/4xx/msi.c
@@ -241,7 +241,8 @@ static int ppc4xx_msi_probe(struct platform_device *dev)
 	if (!msi_irqs)
 		return -ENODEV;
 
-	if (ppc4xx_setup_pcieh_hw(dev, res, msi))
+	err = ppc4xx_setup_pcieh_hw(dev, res, msi)
+	if (err)
 		goto error_out;
 
 	err = ppc4xx_msi_init_allocator(dev, msi);
