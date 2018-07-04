Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E10C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3A220847
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3A220847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933970AbeGDMNG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:13:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42796 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932997AbeGDMNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:13:05 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fagec-00085i-5K; Wed, 04 Jul 2018 12:13:02 +0000
From:   Colin King <colin.king@canonical.com>
To:     Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sfc: remove redundant variable old_vlan
Date:   Wed,  4 Jul 2018 13:13:01 +0100
Message-Id: <20180704121301.8896-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable old_vlan is being assigned but is never used hence it is
and can be removed.

Cleans up clang warning:
warning: variable 'old_vlan' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/sfc/ef10_sriov.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ef10_sriov.c b/drivers/net/ethernet/sfc/ef10_sriov.c
index 8820be83ce85..3d76fd1504c2 100644
--- a/drivers/net/ethernet/sfc/ef10_sriov.c
+++ b/drivers/net/ethernet/sfc/ef10_sriov.c
@@ -564,7 +564,7 @@ int efx_ef10_sriov_set_vf_vlan(struct efx_nic *efx, int vf_i, u16 vlan,
 {
 	struct efx_ef10_nic_data *nic_data = efx->nic_data;
 	struct ef10_vf *vf;
-	u16 old_vlan, new_vlan;
+	u16 new_vlan;
 	int rc = 0, rc2 = 0;
 
 	if (vf_i >= efx->vf_count)
@@ -619,7 +619,6 @@ int efx_ef10_sriov_set_vf_vlan(struct efx_nic *efx, int vf_i, u16 vlan,
 	}
 
 	/* Do the actual vlan change */
-	old_vlan = vf->vlan;
 	vf->vlan = new_vlan;
 
 	/* Restore everything in reverse order */
-- 
2.17.1

