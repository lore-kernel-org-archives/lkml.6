Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7470ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFBB21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFBB21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbeJQXXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:23:30 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57524 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbeJQXXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:23:30 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5A42D20791; Wed, 17 Oct 2018 17:27:16 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2BA3A20DEE;
        Wed, 17 Oct 2018 17:27:06 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH] net: mscc: ocelot: Fix comment in ocelot_vlant_wait_for_completion()
Date:   Wed, 17 Oct 2018 17:26:35 +0200
Message-Id: <20181017152635.22981-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ocelot_vlant_wait_for_completion() function is very similar to the
ocelot_mact_wait_for_completion(). It seemed to have be copied but the
comment was not updated, so let's fix it.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 1a4f2bb48ead..ed4e298cd823 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -133,9 +133,9 @@ static inline int ocelot_vlant_wait_for_completion(struct ocelot *ocelot)
 {
 	unsigned int val, timeout = 10;
 
-	/* Wait for the issued mac table command to be completed, or timeout.
-	 * When the command read from ANA_TABLES_MACACCESS is
-	 * MACACCESS_CMD_IDLE, the issued command completed successfully.
+	/* Wait for the issued vlan table command to be completed, or timeout.
+	 * When the command read from ANA_TABLES_VLANACCESS is
+	 * VLANACCESS_CMD_IDLE, the issued command completed successfully.
 	 */
 	do {
 		val = ocelot_read(ocelot, ANA_TABLES_VLANACCESS);
-- 
2.19.1

