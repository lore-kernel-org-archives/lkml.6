Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EBAC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4B6214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4B6214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbeIXXnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:43:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37860 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbeIXXnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:43:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g4Ups-0000Jn-87; Mon, 24 Sep 2018 17:39:52 +0000
From:   Colin King <colin.king@canonical.com>
To:     Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
        linux-wimax@intel.com, "David S . Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] wimax/i2400m: fix spelling mistake "not unitialized" -> "uninitialized"
Date:   Mon, 24 Sep 2018 18:39:51 +0100
Message-Id: <20180924173951.3931-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in ms_to_errno array of error messages
and remove confusing "not" from the error text since the error code
refers to an uninitialized error code.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: remove "not" from text too. Thanks to Sergei Shtylyov for spotting that.

---
 drivers/net/wimax/i2400m/control.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wimax/i2400m/control.c b/drivers/net/wimax/i2400m/control.c
index 094cea775d0c..0475ad553707 100644
--- a/drivers/net/wimax/i2400m/control.c
+++ b/drivers/net/wimax/i2400m/control.c
@@ -257,7 +257,7 @@ static const struct
 	[I2400M_MS_ACCESSIBILITY_ERROR] = { "accesibility error", -EIO },
 	[I2400M_MS_BUSY] = { "busy", -EBUSY },
 	[I2400M_MS_CORRUPTED_TLV] = { "corrupted TLV", -EILSEQ },
-	[I2400M_MS_UNINITIALIZED] = { "not unitialized", -EILSEQ },
+	[I2400M_MS_UNINITIALIZED] = { "uninitialized", -EILSEQ },
 	[I2400M_MS_UNKNOWN_ERROR] = { "unknown error", -EIO },
 	[I2400M_MS_PRODUCTION_ERROR] = { "production error", -EIO },
 	[I2400M_MS_NO_RF] = { "no RF", -EIO },
-- 
2.17.1

