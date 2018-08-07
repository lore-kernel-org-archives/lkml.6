Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047DBC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B2D21779
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B2D21779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388842AbeHGNXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:23:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34320 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeHGNXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:23:13 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fmzrf-0005Dk-NY; Tue, 07 Aug 2018 11:09:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: apds990x: remove unused array ir_currents
Date:   Tue,  7 Aug 2018 12:09:23 +0100
Message-Id: <20180807110923.16550-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Array ir_currents is declared but never used, hence it is redundant
and can be removed.

Cleans up clang warning:
warning: 'ir_currents' defined but not used [-Wunused-const-variable=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/apds990x.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/apds990x.c b/drivers/misc/apds990x.c
index ed9412d750b7..24876c615c3c 100644
--- a/drivers/misc/apds990x.c
+++ b/drivers/misc/apds990x.c
@@ -188,7 +188,6 @@ struct apds990x_chip {
 #define APDS_LUX_DEFAULT_RATE		200
 
 static const u8 again[]	= {1, 8, 16, 120}; /* ALS gain steps */
-static const u8 ir_currents[]	= {100, 50, 25, 12}; /* IRled currents in mA */
 
 /* Following two tables must match i.e 10Hz rate means 1 as persistence value */
 static const u16 arates_hz[] = {10, 5, 2, 1};
-- 
2.17.1

