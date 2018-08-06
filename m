Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679B7C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199C621A04
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:31:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199C621A04
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbeHFPkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:40:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44071 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727510AbeHFPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:40:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fmfbC-0003mR-JO; Mon, 06 Aug 2018 13:31:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Janani Sankara Babu <jananis37@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: remove unused array dB_Invert_Table
Date:   Mon,  6 Aug 2018 14:31:02 +0100
Message-Id: <20180806133102.28897-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Array dB_Invert_Table is declared but not used, hence it is redundant
and can be removed.

Cleans up clang warning:
warning: ‘dB_Invert_Table’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/rtl8188eu/hal/odm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 1f21728f5084..9d567838a43a 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -11,16 +11,6 @@
 #include "phy.h"
 
 u32 GlobalDebugLevel;
-static const u16 dB_Invert_Table[8][12] = {
-	{1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 4, 4},
-	{4, 5, 6, 6, 7, 8, 9, 10, 11, 13, 14, 16},
-	{18, 20, 22, 25, 28, 32, 35, 40, 45, 50, 56, 63},
-	{71, 79, 89, 100, 112, 126, 141, 158, 178, 200, 224, 251},
-	{282, 316, 355, 398, 447, 501, 562, 631, 708, 794, 891, 1000},
-	{1122, 1259, 1413, 1585, 1778, 1995, 2239, 2512, 2818, 3162, 3548, 3981},
-	{4467, 5012, 5623, 6310, 7079, 7943, 8913, 10000, 11220, 12589, 14125, 15849},
-	{17783, 19953, 22387, 25119, 28184, 31623, 35481, 39811, 44668, 50119, 56234, 65535}
-};
 
 /* avoid to warn in FreeBSD ==> To DO modify */
 static u32 EDCAParam[HT_IOT_PEER_MAX][3] = {
-- 
2.17.1

