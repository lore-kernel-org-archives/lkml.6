Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE058C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DCA62086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DCA62086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeIHTQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:16:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55195 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726351AbeIHTQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:16:52 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CE1664D1E4398;
        Sat,  8 Sep 2018 22:30:48 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 22:30:49 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <boris.ostrovsky@oracle.com>, <jgross@suse.com>
CC:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] xen: remove unnecessary condition check before kfree
Date:   Sat, 8 Sep 2018 22:18:38 +0800
Message-ID: <1536416318-34106-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree has taken null pointer into account. So just remove the
condition check before kfree.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/xen/xen-acpi-processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
index fbb9137..7e1d49e 100644
--- a/drivers/xen/xen-acpi-processor.c
+++ b/drivers/xen/xen-acpi-processor.c
@@ -268,7 +268,7 @@ static int push_pxx_to_hypervisor(struct acpi_processor *_pr)
 		pr_warn("(_PXX): Hypervisor error (%d) for ACPI CPU%u\n",
 			ret, _pr->acpi_id);
 err_free:
-	if (!IS_ERR_OR_NULL(dst_states))
+	if (!IS_ERR(dst_states))
 		kfree(dst_states);
 
 	return ret;
-- 
1.7.12.4

