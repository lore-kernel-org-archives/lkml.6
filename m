Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5296C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C812081B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 11:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfBBLhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 06:37:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40726 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfBBLhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 06:37:13 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gptbh-0000Sx-2S; Sat, 02 Feb 2019 11:37:09 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bna: fix indentation issue on call to bfa_ioc_pf_failed
Date:   Sat,  2 Feb 2019 11:37:07 +0000
Message-Id: <20190202113707.18005-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The call to bfa_ioc_pf_failed is indented too far, fix this by
removing a tab.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
index cbc9175d74c5..84741d288ffa 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -743,7 +743,7 @@ bfa_iocpf_sm_hwinit(struct bfa_iocpf *iocpf, enum iocpf_event event)
 
 	case IOCPF_E_TIMEOUT:
 		bfa_nw_ioc_hw_sem_release(ioc);
-			bfa_ioc_pf_failed(ioc);
+		bfa_ioc_pf_failed(ioc);
 		bfa_fsm_set_state(iocpf, bfa_iocpf_sm_initfail_sync);
 		break;
 
-- 
2.20.1

