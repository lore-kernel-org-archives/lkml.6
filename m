Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C111C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57C920877
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57C920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbeIXXds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:33:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37733 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728916AbeIXXds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:33:48 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g4Ugp-0008Kb-VY; Mon, 24 Sep 2018 17:30:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix spelling mistake "unvalid" -> "invalid"
Date:   Mon, 24 Sep 2018 18:30:31 +0100
Message-Id: <20180924173031.3669-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in DBG_871X debug messages.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 0833cce43dd3..12c1cd590056 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -3084,7 +3084,7 @@ static int phy_ParsePowerLimitTableFile(struct adapter *Adapter, char *buffer)
 
 			if (colNum > TXPWR_LMT_MAX_REGULATION_NUM) {
 				DBG_871X(
-					"unvalid col number %d (greater than max %d)\n",
+					"invalid col number %d (greater than max %d)\n",
 					colNum, TXPWR_LMT_MAX_REGULATION_NUM
 				);
 				return _FAIL;
@@ -3102,7 +3102,7 @@ static int phy_ParsePowerLimitTableFile(struct adapter *Adapter, char *buffer)
 				/* DBG_871X("regulation %s!\n", regulation[forCnt]); */
 
 				if (regulation_name_cnt == 0) {
-					DBG_871X("unvalid number of regulation!\n");
+					DBG_871X("invalid number of regulation!\n");
 					return _FAIL;
 				}
 			}
-- 
2.17.1

