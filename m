Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D5ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A932150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A932150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389910AbeIUSlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:41:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12671 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727697AbeIUSlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:41:14 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6541F60820233;
        Fri, 21 Sep 2018 20:52:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 20:52:23 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <isdn@linux-pingi.de>
CC:     <arvind.yadav.cs@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ISDN: Should use request_mem_region instead of request_region
Date:   Fri, 21 Sep 2018 20:40:00 +0800
Message-ID: <1537533600-44391-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this case, Obviously, we should use request_mem_region to handle.
hence just replace the function.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/isdn/hisax/isurf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hisax/isurf.c b/drivers/isdn/hisax/isurf.c
index 53e299b..ebf49f0 100644
--- a/drivers/isdn/hisax/isurf.c
+++ b/drivers/isdn/hisax/isurf.c
@@ -263,7 +263,7 @@ int setup_isurf(struct IsdnCard *card)
 		       cs->hw.isurf.reset);
 		return (0);
 	}
-	if (!request_region(cs->hw.isurf.phymem, ISURF_IOMEM_SIZE, "isurf iomem")) {
+	if (!request_mem_region(cs->hw.isurf.phymem, ISURF_IOMEM_SIZE, "isurf iomem")) {
 		printk(KERN_WARNING "HiSax: Siemens I-Surf memory region "
 		       "%lx-%lx already in use\n",
 		       cs->hw.isurf.phymem,
-- 
1.7.12.4

