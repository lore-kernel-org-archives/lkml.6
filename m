Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E4C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E0D220675
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfAQAdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:33:41 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53691 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbfAQAdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:33:35 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gjvcj-0004Xl-F8; Thu, 17 Jan 2019 00:33:33 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix a couple of indentation issues and remove assignment in if statements
Date:   Thu, 17 Jan 2019 00:33:33 +0000
Message-Id: <20190117003333.30605-1-colin.king@canonical.com>
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
indented. Fix these.  Also replace the assignment-in-if statements
to assignment followed by an if to keep to the coding style.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: also clean up the assignment-in-if statements too

---

 drivers/net/sb1000.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/sb1000.c b/drivers/net/sb1000.c
index 7820fced33f6..941cfa8f1c2a 100644
--- a/drivers/net/sb1000.c
+++ b/drivers/net/sb1000.c
@@ -535,17 +535,20 @@ sb1000_activate(const int ioaddr[], const char* name)
 	int status;
 
 	ssleep(1);
-	if ((status = card_send_command(ioaddr, name, Command0, st)))
+	status = card_send_command(ioaddr, name, Command0, st);
+	if (status)
 		return status;
-	if ((status = card_send_command(ioaddr, name, Command1, st)))
+	status = card_send_command(ioaddr, name, Command1, st);
+	if (status)
 		return status;
 	if (st[3] != 0xf1) {
-    	if ((status = sb1000_start_get_set_command(ioaddr, name)))
+		status = sb1000_start_get_set_command(ioaddr, name);
+		if (status)
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

