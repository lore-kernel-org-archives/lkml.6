Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18635C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C995220855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 10:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C995220855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeIHPYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:24:02 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51761 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbeIHPYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:24:02 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6840587723C2C;
        Sat,  8 Sep 2018 18:38:40 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.399.0; Sat, 8 Sep 2018 18:38:40 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <schwidefsky@de.ibm.com>, <heiko.carstens@de.ibm.com>,
        <jwi@linux.ibm.com>, <ubraun@linux.ibm.com>, <jdelvare@suse.de>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] s390: qeth_core_mpc: Use ARRAY_SIZE instead of reimplementing its function
Date:   Sat, 8 Sep 2018 18:26:28 +0800
Message-ID: <1536402388-23872-3-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
References: <1536402388-23872-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARRAY_SIZE has implemented its function. we prefer to use the function
rather than the open code.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/s390/net/qeth_core_mpc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/net/qeth_core_mpc.c b/drivers/s390/net/qeth_core_mpc.c
index 5bcb8da..e8263de 100644
--- a/drivers/s390/net/qeth_core_mpc.c
+++ b/drivers/s390/net/qeth_core_mpc.c
@@ -222,8 +222,7 @@ struct ipa_rc_msg {
 char *qeth_get_ipa_msg(enum qeth_ipa_return_codes rc)
 {
 	int x = 0;
-	qeth_ipa_rc_msg[sizeof(qeth_ipa_rc_msg) /
-			sizeof(struct ipa_rc_msg) - 1].rc = rc;
+	qeth_ipa_rc_msg[ARRAY_SIZE(qeth_ipa_rc_msg) - 1].rc = rc;
 	while (qeth_ipa_rc_msg[x].rc != rc)
 		x++;
 	return qeth_ipa_rc_msg[x].msg;
@@ -270,9 +269,7 @@ struct ipa_cmd_names {
 char *qeth_get_ipa_cmd_name(enum qeth_ipa_cmds cmd)
 {
 	int x = 0;
-	qeth_ipa_cmd_names[
-		sizeof(qeth_ipa_cmd_names) /
-			sizeof(struct ipa_cmd_names)-1].cmd = cmd;
+	qeth_ipa_cmd_names[ARRAY_SIZE(qeth_ipa_cmd_names) - 1].cmd = cmd;
 	while (qeth_ipa_cmd_names[x].cmd != cmd)
 		x++;
 	return qeth_ipa_cmd_names[x].name;
-- 
1.7.12.4

