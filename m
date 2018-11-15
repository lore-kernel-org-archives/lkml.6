Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A919C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F282F214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 02:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F282F214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeKOM34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 07:29:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:50516 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726480AbeKOM34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 07:29:56 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2EB2D9EDBCCFC;
        Thu, 15 Nov 2018 10:24:01 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Thu, 15 Nov 2018
 10:23:52 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <isdn@linux-pingi.de>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <natechancellor@gmail.com>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] isdn/hisax: remove set but not used variable 'total'
Date:   Thu, 15 Nov 2018 10:23:03 +0800
Message-ID: <20181115022303.22604-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/isdn/hisax/hfc_pci.c:277:6: warning:
 variable ‘total’ set but not used [-Wunused-but-set-variable]

It never used since git history start.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/isdn/hisax/hfc_pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/isdn/hisax/hfc_pci.c b/drivers/isdn/hisax/hfc_pci.c
index ea0e4c6..5b719b5 100644
--- a/drivers/isdn/hisax/hfc_pci.c
+++ b/drivers/isdn/hisax/hfc_pci.c
@@ -274,7 +274,7 @@ hfcpci_empty_fifo(struct BCState *bcs, bzfifo_type *bz, u_char *bdata, int count
 	u_char *ptr, *ptr1, new_f2;
 	struct sk_buff *skb;
 	struct IsdnCardState *cs = bcs->cs;
-	int total, maxlen, new_z2;
+	int maxlen, new_z2;
 	z_type *zp;
 
 	if ((cs->debug & L1_DEB_HSCX) && !(cs->debug & L1_DEB_HSCX_FIFO))
@@ -297,7 +297,6 @@ hfcpci_empty_fifo(struct BCState *bcs, bzfifo_type *bz, u_char *bdata, int count
 	} else if (!(skb = dev_alloc_skb(count - 3)))
 		printk(KERN_WARNING "HFCPCI: receive out of memory\n");
 	else {
-		total = count;
 		count -= 3;
 		ptr = skb_put(skb, count);
 
-- 
2.7.0


