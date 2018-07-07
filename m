Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4F3C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F2521884
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 11:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F2521884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754135AbeGGL1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 07:27:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38466 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753358AbeGGL1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 07:27:33 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fblNC-0004Mc-Jy; Sat, 07 Jul 2018 11:27:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kevin Curtis <kevin.curtis@farsite.co.uk>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] farsync: remove redundant variable txq_length
Date:   Sat,  7 Jul 2018 12:27:30 +0100
Message-Id: <20180707112730.21404-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable txq_length is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'txq_length' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wan/farsync.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index bd46b2552980..2a3f0f1a2b0a 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -2134,7 +2134,6 @@ static void
 fst_openport(struct fst_port_info *port)
 {
 	int signals;
-	int txq_length;
 
 	/* Only init things if card is actually running. This allows open to
 	 * succeed for downloads etc.
@@ -2161,7 +2160,6 @@ fst_openport(struct fst_port_info *port)
 		else
 			netif_carrier_off(port_to_dev(port));
 
-		txq_length = port->txqe - port->txqs;
 		port->txqe = 0;
 		port->txqs = 0;
 	}
-- 
2.17.1

