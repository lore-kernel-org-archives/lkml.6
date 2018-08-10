Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0AE6C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59238223F0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:02:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59238223F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeHJKbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:31:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38612 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbeHJKbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:31:02 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fo2NF-00028g-Ld; Fri, 10 Aug 2018 08:02:17 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: chelsio: cxgb2: remove unused array pci_speed
Date:   Fri, 10 Aug 2018 09:02:17 +0100
Message-Id: <20180810080217.26758-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Array pci_speed is defined but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: 'pci_speed' defined but not used [-Wunused-const-variable=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/chelsio/cxgb/cxgb2.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
index 8623be13bf86..0ccdde366ae1 100644
--- a/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
+++ b/drivers/net/ethernet/chelsio/cxgb/cxgb2.c
@@ -109,10 +109,6 @@ static int disable_msi = 0;
 module_param(disable_msi, int, 0);
 MODULE_PARM_DESC(disable_msi, "Disable Message Signaled Interrupt (MSI)");
 
-static const char pci_speed[][4] = {
-	"33", "66", "100", "133"
-};
-
 /*
  * Setup MAC to receive the types of packets we want.
  */
-- 
2.17.1

