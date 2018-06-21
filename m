Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE98C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC17020837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC17020837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754543AbeFUB5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:57:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35692 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754172AbeFUB5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:57:10 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 34FA8B5D5B0A5;
        Thu, 21 Jun 2018 09:57:07 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.382.0; Thu, 21 Jun 2018 09:57:00 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] mqueue: fix a typo in mq_init_ns()
Date:   Thu, 21 Jun 2018 02:02:47 +0000
Message-ID: <1529546567-74814-1-git-send-email-weiyongjun1@huawei.com>
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

Fix a typo, use 'm' instead of 'ns->mq_mnt'.

Fixes: 5cd6a50ace05 ("ipc: Convert mqueue fs to fs_context")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 ipc/mqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 833b8d7..0f10221 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1620,7 +1620,7 @@ int mq_init_ns(struct ipc_namespace *ns)
 
 	m = mq_create_mount(&init_ipc_ns);
 	if (IS_ERR(m))
-		return PTR_ERR(ns->mq_mnt);
+		return PTR_ERR(m);
 	ns->mq_mnt = m;
 	return 0;
 }

