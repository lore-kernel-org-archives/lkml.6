Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D759C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CE32159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:52:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CE32159D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbeI0RJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:09:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59277 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726820AbeI0RJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:09:57 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6D405A281FE97;
        Thu, 27 Sep 2018 18:52:13 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Thu, 27 Sep 2018 18:52:06 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        zhong jiang <zhongjiang@huawei.com>,
        Al Viro <viro@zeniv.linux.org.uk>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] VMCI: remove set but not used variable 'cid'
Date:   Thu, 27 Sep 2018 11:01:19 +0000
Message-ID: <1538046079-137795-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/misc/vmw_vmci/vmci_host.c: In function 'vmci_host_do_alloc_queuepair':
drivers/misc/vmw_vmci/vmci_host.c:450:6: warning:
 variable 'cid' set but not used [-Wunused-but-set-variable]
  u32 cid;
      ^

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/misc/vmw_vmci/vmci_host.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index be732e5..edfffc9 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -447,15 +447,12 @@ static int vmci_host_do_alloc_queuepair(struct vmci_host_dev *vmci_host_dev,
 	struct vmci_handle handle;
 	int vmci_status;
 	int __user *retptr;
-	u32 cid;
 
 	if (vmci_host_dev->ct_type != VMCIOBJ_CONTEXT) {
 		vmci_ioctl_err("only valid for contexts\n");
 		return -EINVAL;
 	}
 
-	cid = vmci_ctx_get_id(vmci_host_dev->context);
-
 	if (vmci_host_dev->user_version < VMCI_VERSION_NOVMVM) {
 		struct vmci_qp_alloc_info_vmvm alloc_info;
 		struct vmci_qp_alloc_info_vmvm __user *info = uptr;



