Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFF5C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B0C24496
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B0C24496
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933890AbeGDLUr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:20:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42180 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932673AbeGDLUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:20:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fafq0-0005fh-Fq; Wed, 04 Jul 2018 11:20:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet: micrel: remove redundant pointer 'info'
Date:   Wed,  4 Jul 2018 12:20:44 +0100
Message-Id: <20180704112044.7930-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'info' is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'info' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/micrel/ksz884x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet/micrel/ksz884x.c
index b72d1bd11296..ebbdfb908745 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -3373,7 +3373,6 @@ static void port_get_link_speed(struct ksz_port *port)
  */
 static void port_set_link_speed(struct ksz_port *port)
 {
-	struct ksz_port_info *info;
 	struct ksz_hw *hw = port->hw;
 	u16 data;
 	u16 cfg;
@@ -3382,8 +3381,6 @@ static void port_set_link_speed(struct ksz_port *port)
 	int p;
 
 	for (i = 0, p = port->first_port; i < port->port_cnt; i++, p++) {
-		info = &hw->port_info[p];
-
 		port_r16(hw, p, KS884X_PORT_CTRL_4_OFFSET, &data);
 		port_r8(hw, p, KS884X_PORT_STATUS_OFFSET, &status);
 
-- 
2.17.1

