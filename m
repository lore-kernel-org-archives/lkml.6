Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E3FC43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B142218A3
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 08:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfAFIib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Jan 2019 03:38:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:57222 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726538AbfAFIiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jan 2019 03:38:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8FBE7AE26;
        Sun,  6 Jan 2019 08:38:05 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-lpwan@lists.infradead.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Ben Whitten <ben.whitten@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH lora-next 09/11] net: lora: sx130x: Mark AGCSTS register as volatile
Date:   Sun,  6 Jan 2019 09:37:52 +0100
Message-Id: <20190106083754.6004-10-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190106083754.6004-1-afaerber@suse.de>
References: <20190106083754.6004-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AGC status register reads should not be cached.

Sort the volatile registers by number while at it.

Cc: Ben Whitten <ben.whitten@gmail.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 drivers/net/lora/sx130x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 0a79548a7480..8bdd343a273f 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -123,11 +123,13 @@ static const struct regmap_range_cfg sx130x_regmap_ranges[] = {
 static bool sx130x_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
-	case SX1301_DBG_AGC_MCU_RAM_DATA:
-	case SX1301_DBG_ARB_MCU_RAM_DATA:
 	case SX1301_MPD:
+	case SX1301_AGCSTS:
+
 	case SX1301_RADIO_A_SPI_DATA_RB:
 	case SX1301_RADIO_B_SPI_DATA_RB:
+	case SX1301_DBG_ARB_MCU_RAM_DATA:
+	case SX1301_DBG_AGC_MCU_RAM_DATA:
 		return true;
 	default:
 		return false;
-- 
2.16.4

