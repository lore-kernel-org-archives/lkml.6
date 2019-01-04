Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5964BC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DA521871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 05:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfADF5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 00:57:07 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40025 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbfADF5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 00:57:07 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DB8FE9B810071;
        Fri,  4 Jan 2019 13:57:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.408.0; Fri, 4 Jan 2019 13:56:56 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     YueHaibing <yuehaibing@huawei.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] xen/pvcalls: remove set but not used variable 'intf'
Date:   Fri, 4 Jan 2019 06:03:40 +0000
Message-ID: <1546581820-123466-1-git-send-email-yuehaibing@huawei.com>
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

drivers/xen/pvcalls-back.c: In function 'pvcalls_sk_state_change':
drivers/xen/pvcalls-back.c:286:28: warning:
 variable 'intf' set but not used [-Wunused-but-set-variable]

It not used since e6587cdbd732 ("pvcalls-back: set -ENOTCONN in
pvcalls_conn_back_read")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/xen/pvcalls-back.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index 71b6287..7aa64d1 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -283,12 +283,10 @@ static int pvcalls_back_socket(struct xenbus_device *dev,
 static void pvcalls_sk_state_change(struct sock *sock)
 {
 	struct sock_mapping *map = sock->sk_user_data;
-	struct pvcalls_data_intf *intf;
 
 	if (map == NULL)
 		return;
 
-	intf = map->ring;
 	atomic_inc(&map->read);
 	notify_remote_via_irq(map->irq);
 }



