Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C366C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB1B720868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfAQANE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:13:04 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53513 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfAQAND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:13:03 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gjvIr-0003cN-Q8; Thu, 17 Jan 2019 00:13:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sb1000: fix a couple of indentation issues
Date:   Thu, 17 Jan 2019 00:13:01 +0000
Message-Id: <20190117001301.29948-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an if statement and a return statement that are incorrectly
indented. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/sb1000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sb1000.c b/drivers/net/sb1000.c
index 7820fced33f6..af4838124f8c 100644
--- a/drivers/net/sb1000.c
+++ b/drivers/net/sb1000.c
@@ -540,12 +540,12 @@ sb1000_activate(const int ioaddr[], const char* name)
 	if ((status = card_send_command(ioaddr, name, Command1, st)))
 		return status;
 	if (st[3] != 0xf1) {
-    	if ((status = sb1000_start_get_set_command(ioaddr, name)))
+		if ((status = sb1000_start_get_set_command(ioaddr, name)))
 			return status;
 		return -EIO;
 	}
 	udelay(1000);
-    return sb1000_start_get_set_command(ioaddr, name);
+	return sb1000_start_get_set_command(ioaddr, name);
 }
 
 /* get SB1000 firmware version */
-- 
2.19.1

