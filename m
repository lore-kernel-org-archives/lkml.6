Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BBDC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E05620864
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E05620864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbeGKLC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:02:59 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47451 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeGKLC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:02:59 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdCq0-00052U-5v; Wed, 11 Jul 2018 10:59:12 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: ks7010: remove redundant variable eth_proto
Date:   Wed, 11 Jul 2018 11:59:11 +0100
Message-Id: <20180711105911.30887-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable eth_proto is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'eth_proto' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/ks7010/ks_hostif.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
index 0ecffab52ec2..a85975f63d26 100644
--- a/drivers/staging/ks7010/ks_hostif.c
+++ b/drivers/staging/ks7010/ks_hostif.c
@@ -354,7 +354,6 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 	u16 auth_type;
 	unsigned char temp[256];
 	struct ether_hdr *eth_hdr;
-	unsigned short eth_proto;
 	struct ieee802_1x_hdr *aa1x_hdr;
 	size_t size;
 	int ret;
@@ -369,7 +368,6 @@ void hostif_data_indication(struct ks_wlan_private *priv)
 	get_word(priv);	/* Reserve Area */
 
 	eth_hdr = (struct ether_hdr *)(priv->rxp);
-	eth_proto = ntohs(eth_hdr->h_proto);
 
 	/* source address check */
 	if (ether_addr_equal(&priv->eth_addr[0], eth_hdr->h_source)) {
-- 
2.17.1

