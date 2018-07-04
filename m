Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC103C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF8324633
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 07:15:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF8324633
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbeGDHPf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 03:15:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38181 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeGDHPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 03:15:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fac0g-0001hJ-Sy; Wed, 04 Jul 2018 07:15:30 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: alx: remove redundant variable old_duplex
Date:   Wed,  4 Jul 2018 08:15:30 +0100
Message-Id: <20180704071530.14431-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable old_duplex is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'old_duplex' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/atheros/alx/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index 5e5022fa1d04..6d3221134927 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -1279,7 +1279,6 @@ static void alx_check_link(struct alx_priv *alx)
 	struct alx_hw *hw = &alx->hw;
 	unsigned long flags;
 	int old_speed;
-	u8 old_duplex;
 	int err;
 
 	/* clear PHY internal interrupt status, otherwise the main
@@ -1288,7 +1287,6 @@ static void alx_check_link(struct alx_priv *alx)
 	alx_clear_phy_intr(hw);
 
 	old_speed = hw->link_speed;
-	old_duplex = hw->duplex;
 	err = alx_read_phy_link(hw);
 	if (err < 0)
 		goto reset;
-- 
2.17.1

