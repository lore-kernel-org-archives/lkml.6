Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816AFC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27ADF216E5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 11:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27ADF216E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbeHHOMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 10:12:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53933 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726733AbeHHOMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 10:12:44 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7C166AACD3145;
        Wed,  8 Aug 2018 19:53:18 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Wed, 8 Aug 2018
 19:53:13 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <davem@davemloft.net>, <idryomov@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <zyan@redhat.com>, <sage@redhat.com>, <ceph-devel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] crush: fix using plain integer as NULL warning
Date:   Wed, 8 Aug 2018 19:52:57 +0800
Message-ID: <20180808115257.6088-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:
net/ceph/crush/mapper.c:517:76: warning: Using plain integer as NULL pointer
net/ceph/crush/mapper.c:728:68: warning: Using plain integer as NULL pointer

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/ceph/crush/mapper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 417df67..3f323ed 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -514,7 +514,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 						in, work->work[-1-in->id],
 						x, r,
 						(choose_args ?
-						 &choose_args[-1-in->id] : 0),
+						 &choose_args[-1-in->id] : NULL),
 						outpos);
 				if (item >= map->max_devices) {
 					dprintk("   bad item %d\n", item);
@@ -725,7 +725,7 @@ static void crush_choose_indep(const struct crush_map *map,
 					in, work->work[-1-in->id],
 					x, r,
 					(choose_args ?
-					 &choose_args[-1-in->id] : 0),
+					 &choose_args[-1-in->id] : NULL),
 					outpos);
 				if (item >= map->max_devices) {
 					dprintk("   bad item %d\n", item);
-- 
2.7.0


