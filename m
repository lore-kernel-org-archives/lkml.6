Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B39C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E23092084C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 13:38:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23092084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754597AbeGINiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 09:38:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37171 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbeGINir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 09:38:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fcWNH-0002nD-UH; Mon, 09 Jul 2018 13:38:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] airo: remove unused variables len and dev and clean up formatting
Date:   Mon,  9 Jul 2018 14:38:43 +0100
Message-Id: <20180709133843.15615-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables len and dev assigned values but are never used hence they
are redundant and can be removed.  Also add in white space in for-loop
and remove some { } braces on if statement.

Cleans up clang warnings:
warning: variable 'len' set but not used [-Wunused-but-set-variable]
warning: variable 'dev' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/cisco/airo.c    | 8 +++-----
 drivers/net/wireless/cisco/airo_cs.c | 3 ---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/cisco/airo.c b/drivers/net/wireless/cisco/airo.c
index 72046e182745..04dd7a936593 100644
--- a/drivers/net/wireless/cisco/airo.c
+++ b/drivers/net/wireless/cisco/airo.c
@@ -3419,7 +3419,7 @@ static void airo_handle_rx(struct airo_info *ai)
 
 static void airo_handle_tx(struct airo_info *ai, u16 status)
 {
-	int i, len = 0, index = -1;
+	int i, index = -1;
 	u16 fid;
 
 	if (test_bit(FLAG_MPI, &ai->flags)) {
@@ -3443,11 +3443,9 @@ static void airo_handle_tx(struct airo_info *ai, u16 status)
 
 	fid = IN4500(ai, TXCOMPLFID);
 
-	for(i = 0; i < MAX_FIDS; i++) {
-		if ((ai->fids[i] & 0xffff) == fid) {
-			len = ai->fids[i] >> 16;
+	for (i = 0; i < MAX_FIDS; i++) {
+		if ((ai->fids[i] & 0xffff) == fid)
 			index = i;
-		}
 	}
 
 	if (index != -1) {
diff --git a/drivers/net/wireless/cisco/airo_cs.c b/drivers/net/wireless/cisco/airo_cs.c
index d9ed22b4cc6b..3718f958c0fc 100644
--- a/drivers/net/wireless/cisco/airo_cs.c
+++ b/drivers/net/wireless/cisco/airo_cs.c
@@ -102,11 +102,8 @@ static int airo_cs_config_check(struct pcmcia_device *p_dev, void *priv_data)
 
 static int airo_config(struct pcmcia_device *link)
 {
-	struct local_info *dev;
 	int ret;
 
-	dev = link->priv;
-
 	dev_dbg(&link->dev, "airo_config\n");
 
 	link->config_flags |= CONF_ENABLE_IRQ | CONF_AUTO_SET_VPP |
-- 
2.17.1

