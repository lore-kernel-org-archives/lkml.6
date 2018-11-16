Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06710C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A112087C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 13:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A112087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389948AbeKPXtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 18:49:07 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35746 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeKPXtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 18:49:07 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gNeIX-0002c7-Ai; Fri, 16 Nov 2018 13:36:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Igor Russkikh <igor.russkikh@aquantia.com>,
        Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>,
        netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: aquantia: fix spelling mistake "specfield" -> "specified"
Date:   Fri, 16 Nov 2018 13:36:36 +0000
Message-Id: <20181116133636.6913-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a netdev_err message. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_filters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
index f6145e7473b1..18bc035da850 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_filters.c
@@ -136,7 +136,7 @@ aq_check_approve_fl2(struct aq_nic_s *aq_nic,
 	if (be16_to_cpu(fsp->m_ext.vlan_tci) == VLAN_PRIO_MASK &&
 	    fsp->m_u.ether_spec.h_proto == 0U) {
 		netdev_err(aq_nic->ndev,
-			   "ethtool: proto (ether_type) parameter must be specfied");
+			   "ethtool: proto (ether_type) parameter must be specified");
 		return -EINVAL;
 	}
 
-- 
2.19.1

