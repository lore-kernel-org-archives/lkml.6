Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACCBC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AC721A27
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 12:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9AC721A27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754131AbeGGMrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 08:47:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39081 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753727AbeGGMrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 08:47:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fbmcF-0000Jx-08; Sat, 07 Jul 2018 12:47:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: net: lmc: remove redundant variable next_rx
Date:   Sat,  7 Jul 2018 13:47:06 +0100
Message-Id: <20180707124706.23344-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable next_rx is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'next_rx' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wan/lmc/lmc_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
index 90a4ad9a2d08..093bd21f574d 100644
--- a/drivers/net/wan/lmc/lmc_main.c
+++ b/drivers/net/wan/lmc/lmc_main.c
@@ -1491,7 +1491,6 @@ static int lmc_rx(struct net_device *dev)
     lmc_softc_t *sc = dev_to_sc(dev);
     int i;
     int rx_work_limit = LMC_RXDESCS;
-    unsigned int next_rx;
     int rxIntLoopCnt;		/* debug -baz */
     int localLengthErrCnt = 0;
     long stat;
@@ -1505,7 +1504,6 @@ static int lmc_rx(struct net_device *dev)
     rxIntLoopCnt = 0;		/* debug -baz */
 
     i = sc->lmc_next_rx % LMC_RXDESCS;
-    next_rx = sc->lmc_next_rx;
 
     while (((stat = sc->lmc_rxring[i].status) & LMC_RDES_OWN_BIT) != DESC_OWNED_BY_DC21X4)
     {
-- 
2.17.1

