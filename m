Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71015C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143B521A03
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143B521A03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeHFNXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 09:23:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40264 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbeHFNXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 09:23:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fmdSp-0003dF-9H; Mon, 06 Aug 2018 11:14:15 +0000
From:   Colin King <colin.king@canonical.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][usb-next] USB: typec: fsusb302: remove unused variables snk_pdo and toggling_mode_name
Date:   Mon,  6 Aug 2018 12:14:14 +0100
Message-Id: <20180806111414.9436-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables snk_pdo and toggling_mode_name are defined but are not used and
hence can be removed.

Cleans up clang warnings:
warning: 'snk_pdo' defined but not used [-Wunused-const-variable=]
warning: 'toggling_mode_name' defined but not used [-Wunused-const-variable=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/usb/typec/fusb302/fusb302.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/usb/typec/fusb302/fusb302.c b/drivers/usb/typec/fusb302/fusb302.c
index 82bed9810be6..ad7cfed1cea7 100644
--- a/drivers/usb/typec/fusb302/fusb302.c
+++ b/drivers/usb/typec/fusb302/fusb302.c
@@ -48,13 +48,6 @@ enum toggling_mode {
 	TOGGLING_MODE_SRC,
 };
 
-static const char * const toggling_mode_name[] = {
-	[TOGGLINE_MODE_OFF]	= "toggling_OFF",
-	[TOGGLING_MODE_DRP]	= "toggling_DRP",
-	[TOGGLING_MODE_SNK]	= "toggling_SNK",
-	[TOGGLING_MODE_SRC]	= "toggling_SRC",
-};
-
 enum src_current_status {
 	SRC_CURRENT_DEFAULT,
 	SRC_CURRENT_MEDIUM,
@@ -1178,10 +1171,6 @@ static const u32 src_pdo[] = {
 	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
 };
 
-static const u32 snk_pdo[] = {
-	PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
-};
-
 static const struct tcpc_config fusb302_tcpc_config = {
 	.src_pdo = src_pdo,
 	.nr_src_pdo = ARRAY_SIZE(src_pdo),
-- 
2.17.1

