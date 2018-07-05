Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038FFC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC4E24181
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 09:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC4E24181
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753346AbeGEJhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 05:37:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57476 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeGEJhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 05:37:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fb0hg-0005uS-Ll; Thu, 05 Jul 2018 09:37:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: sun: remove redundant variables adv and lpa
Date:   Thu,  5 Jul 2018 10:37:32 +0100
Message-Id: <20180705093732.21650-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables adv and lpa are being assigned but are never used hence they
are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'lpa' set but not used [-Wunused-but-set-variable]
warning: variable 'adv' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/sun/niu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 88c12474a0c3..2d6b62c6d9ab 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -1225,17 +1225,13 @@ static int link_status_1g_rgmii(struct niu *np, int *link_up_p)
 
 	bmsr = err;
 	if (bmsr & BMSR_LSTATUS) {
-		u16 adv, lpa;
-
 		err = mii_read(np, np->phy_addr, MII_ADVERTISE);
 		if (err < 0)
 			goto out;
-		adv = err;
 
 		err = mii_read(np, np->phy_addr, MII_LPA);
 		if (err < 0)
 			goto out;
-		lpa = err;
 
 		err = mii_read(np, np->phy_addr, MII_ESTATUS);
 		if (err < 0)
-- 
2.17.1

