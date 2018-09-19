Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEE0ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F2020880
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F2020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732031AbeISUcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:32:25 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43487 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731421AbeISUcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:32:25 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1CB7FCA84F34A;
        Wed, 19 Sep 2018 22:53:58 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Wed, 19 Sep 2018 22:53:58 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>
CC:     <stefan@datenfreihafen.org>, <alex.aring@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ieee802154: remove a redundant local variable 'i'
Date:   Wed, 19 Sep 2018 22:41:37 +0800
Message-ID: <1537368097-60101-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local variable 'i' is never used after being assigned.
hence it should be redundant adn can be removed.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/ieee802154/nl802154.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ieee802154/nl802154.c b/net/ieee802154/nl802154.c
index 99f6c25..5b90151 100644
--- a/net/ieee802154/nl802154.c
+++ b/net/ieee802154/nl802154.c
@@ -445,7 +445,6 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 {
 	struct nlattr *nl_cmds;
 	void *hdr;
-	int i;
 
 	hdr = nl802154hdr_put(msg, portid, seq, flags, cmd);
 	if (!hdr)
@@ -508,7 +507,6 @@ static int nl802154_send_wpan_phy(struct cfg802154_registered_device *rdev,
 	if (!nl_cmds)
 		goto nla_put_failure;
 
-	i = 0;
 #define CMD(op, n)							\
 	do {								\
 		if (rdev->ops->op) {					\
-- 
1.7.12.4

