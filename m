Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE63EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD07020685
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD07020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbeHGPRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:17:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10641 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbeHGPRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:17:50 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 160E143FEA4A7;
        Tue,  7 Aug 2018 21:03:27 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.399.0; Tue, 7 Aug 2018
 21:03:20 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <idryomov@gmail.com>, <zyan@redhat.com>,
        <sage@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <ceph-devel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] ceph: remove unnecessary non NULL check for request_key
Date:   Tue, 7 Aug 2018 21:02:34 +0800
Message-ID: <20180807130234.5380-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

request_key never return NULL,so no need do non-NULL check.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/ceph/ceph_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 584fdbe..9834edc 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -304,7 +304,7 @@ static int get_secret(struct ceph_crypto_key *dst, const char *name) {
 	struct ceph_crypto_key *ckey;
 
 	ukey = request_key(&key_type_ceph, name, NULL);
-	if (!ukey || IS_ERR(ukey)) {
+	if (IS_ERR(ukey)) {
 		/* request_key errors don't map nicely to mount(2)
 		   errors; don't even try, but still printk */
 		key_err = PTR_ERR(ukey);
-- 
2.7.0


