Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43548C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDAE72414E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDAE72414E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeFVLhI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:37:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33189 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751198AbeFVLhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:37:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BD7EFC633154A;
        Fri, 22 Jun 2018 19:37:02 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.382.0; Fri, 22 Jun 2018 19:36:56 +0800
From:   John Garry <john.garry@huawei.com>
To:     <tglx@linutronix.de>, <marc.zyngier@arm.com>,
        <will.deacon@arm.com>, <kstewart@linuxfoundation.org>,
        <julien.thierry@arm.com>, <andrew@lunn.ch>
CC:     <linux-kernel@vger.kernel.org>, <trivial@kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] irqdesc: Delete irq_desc_get_msi_desc()
Date:   Fri, 22 Jun 2018 19:35:33 +0800
Message-ID: <1529667333-92959-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function irq_desc_get_msi_desc() is not referenced in the kernel (and does
not seem to have been referenced since e39758e0ea76, 3 years ago), so
delete it.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 25b33b6..dd1e40d 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -145,11 +145,6 @@ static inline void *irq_desc_get_handler_data(struct irq_desc *desc)
 	return desc->irq_common_data.handler_data;
 }
 
-static inline struct msi_desc *irq_desc_get_msi_desc(struct irq_desc *desc)
-{
-	return desc->irq_common_data.msi_desc;
-}
-
 /*
  * Architectures call this to let the generic IRQ layer
  * handle an interrupt.
-- 
1.9.1

