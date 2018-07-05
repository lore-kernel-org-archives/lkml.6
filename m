Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC6C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 243EA2415C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 243EA2415C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeGEJ0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:26:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57286 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753131AbeGEJ0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:26:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fb0Wk-0004xF-6L; Thu, 05 Jul 2018 09:26:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: socionext: remove redundant pointer ndev
Date:   Thu,  5 Jul 2018 10:26:13 +0100
Message-Id: <20180705092613.20560-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer ndev is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'ndev' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/socionext/netsec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index e080d3e7c582..01589b6982e4 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -780,11 +780,9 @@ static int netsec_process_rx(struct netsec_priv *priv, int budget)
 static int netsec_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct netsec_priv *priv;
-	struct net_device *ndev;
 	int tx, rx, done, todo;
 
 	priv = container_of(napi, struct netsec_priv, napi);
-	ndev = priv->ndev;
 
 	todo = budget;
 	do {
-- 
2.17.1

