Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54391C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29601222D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 06:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfBPFz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 00:55:28 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60924 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfBPFz1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 00:55:27 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7DF8785BBA264D64A8F2;
        Sat, 16 Feb 2019 13:55:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Sat, 16 Feb 2019 13:55:15 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Duncan Laurie <dlaurie@google.com>,
        "Nick Crews" <ncrews@chromium.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] platform/chrome: Make function wilco_ec_transfer() static
Date:   Sat, 16 Feb 2019 06:09:10 +0000
Message-ID: <20190216060910.139768-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warning:

drivers/platform/chrome/wilco_ec/mailbox.c:126:5: warning:
 symbol 'wilco_ec_transfer' was not declared. Should it be static?

Fixes: 436dad4fda10 ("platform/chrome: Add new driver for Wilco EC")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/platform/chrome/wilco_ec/mailbox.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/mailbox.c b/drivers/platform/chrome/wilco_ec/mailbox.c
index c7028488e575..f6ff29a11f1a 100644
--- a/drivers/platform/chrome/wilco_ec/mailbox.c
+++ b/drivers/platform/chrome/wilco_ec/mailbox.c
@@ -123,8 +123,9 @@ static void wilco_ec_prepare(struct wilco_ec_message *msg,
  * Context: ec->mailbox_lock should be held while using this function.
  * Return: number of bytes received or negative error code on failure.
  */
-int wilco_ec_transfer(struct wilco_ec_device *ec, struct wilco_ec_message *msg,
-		      struct wilco_ec_request *rq)
+static int wilco_ec_transfer(struct wilco_ec_device *ec,
+			     struct wilco_ec_message *msg,
+			     struct wilco_ec_request *rq)
 {
 	struct wilco_ec_response *rs;
 	u8 checksum;



