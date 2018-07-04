Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A2FC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DA82454F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19DA82454F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933917AbeGDHzA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:55:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38868 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbeGDHy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:54:58 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1faccp-0003kI-Na; Wed, 04 Jul 2018 07:54:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: gianfar_ethtool: remove redundant variable last_rule_idx
Date:   Wed,  4 Jul 2018 08:54:55 +0100
Message-Id: <20180704075455.16010-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable last_rule_idx is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'last_rule_idx' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/freescale/gianfar_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar_ethtool.c b/drivers/net/ethernet/freescale/gianfar_ethtool.c
index 8cb98cae0a6f..395a5266ea30 100644
--- a/drivers/net/ethernet/freescale/gianfar_ethtool.c
+++ b/drivers/net/ethernet/freescale/gianfar_ethtool.c
@@ -740,7 +740,6 @@ static void ethflow_to_filer_rules (struct gfar_private *priv, u64 ethflow)
 static int gfar_ethflow_to_filer_table(struct gfar_private *priv, u64 ethflow,
 				       u64 class)
 {
-	unsigned int last_rule_idx = priv->cur_filer_idx;
 	unsigned int cmp_rqfpr;
 	unsigned int *local_rqfpr;
 	unsigned int *local_rqfcr;
@@ -819,7 +818,6 @@ static int gfar_ethflow_to_filer_table(struct gfar_private *priv, u64 ethflow,
 	}
 
 	priv->cur_filer_idx = l - 1;
-	last_rule_idx = l;
 
 	/* hash rules */
 	ethflow_to_filer_rules(priv, ethflow);
-- 
2.17.1

