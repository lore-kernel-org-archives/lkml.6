Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE70FC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9F821A13
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 18:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9F821A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbeHHUZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 16:25:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35690 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHUZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 16:25:20 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fnSot-00085e-OT; Wed, 08 Aug 2018 18:04:27 +0000
From:   Colin King <colin.king@canonical.com>
To:     Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ethernet/qlogic: remove unused array msi_tgt_status
Date:   Wed,  8 Aug 2018 19:04:27 +0100
Message-Id: <20180808180427.14864-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Array msi_tgt_status is defined but never used, hence it is
redundant and can be removed.

Cleans up clang warning:
warning: 'msi_tgt_status' defined but not used [-Wunused-const-variable=]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
index 7848cf04b29a..822aa393c370 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -276,13 +276,6 @@ static const unsigned crb_hub_agt[64] = {
 	0,
 };
 
-static const u32 msi_tgt_status[8] = {
-	ISR_INT_TARGET_STATUS, ISR_INT_TARGET_STATUS_F1,
-	ISR_INT_TARGET_STATUS_F2, ISR_INT_TARGET_STATUS_F3,
-	ISR_INT_TARGET_STATUS_F4, ISR_INT_TARGET_STATUS_F5,
-	ISR_INT_TARGET_STATUS_F6, ISR_INT_TARGET_STATUS_F7
-};
-
 /*  PCI Windowing for DDR regions.  */
 
 #define QLCNIC_PCIE_SEM_TIMEOUT	10000
-- 
2.17.1

