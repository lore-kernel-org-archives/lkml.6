Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CBDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52DE21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388972AbeLUWjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:39:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58023 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbeLUWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:39:47 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gaTSK-0000UV-IX; Fri, 21 Dec 2018 22:39:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Hennerich <michael.hennerich@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: misc: ad525x_dpot: clean indentation issue, remove tabs
Date:   Fri, 21 Dec 2018 22:39:44 +0000
Message-Id: <20181221223944.15128-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a hunk of code in a case statement that is indented one level
too deeply, fix this by removing extra tabs. Also remove one empty line.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/ad525x_dpot.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/ad525x_dpot.c b/drivers/misc/ad525x_dpot.c
index a0afadefcc49..1f6d008e0036 100644
--- a/drivers/misc/ad525x_dpot.c
+++ b/drivers/misc/ad525x_dpot.c
@@ -202,22 +202,20 @@ static s32 dpot_read_i2c(struct dpot_data *dpot, u8 reg)
 		return dpot_read_r8d8(dpot, ctrl);
 	case DPOT_UID(AD5272_ID):
 	case DPOT_UID(AD5274_ID):
-			dpot_write_r8d8(dpot,
+		dpot_write_r8d8(dpot,
 				(DPOT_AD5270_1_2_4_READ_RDAC << 2), 0);
 
-			value = dpot_read_r8d16(dpot,
-				DPOT_AD5270_1_2_4_RDAC << 2);
-
-			if (value < 0)
-				return value;
-			/*
-			 * AD5272/AD5274 returns high byte first, however
-			 * underling smbus expects low byte first.
-			 */
-			value = swab16(value);
+		value = dpot_read_r8d16(dpot, DPOT_AD5270_1_2_4_RDAC << 2);
+		if (value < 0)
+			return value;
+		/*
+		 * AD5272/AD5274 returns high byte first, however
+		 * underling smbus expects low byte first.
+		 */
+		value = swab16(value);
 
-			if (dpot->uid == DPOT_UID(AD5274_ID))
-				value = value >> 2;
+		if (dpot->uid == DPOT_UID(AD5274_ID))
+			value = value >> 2;
 		return value;
 	default:
 		if ((reg & DPOT_REG_TOL) || (dpot->max_pos > 256))
-- 
2.19.1

