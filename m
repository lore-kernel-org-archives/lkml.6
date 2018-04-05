Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeDEJ4m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 05:56:42 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39082 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752418AbeDEJ42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 05:56:28 -0400
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: [PATCH net] net: mvpp2: Fix parser entry init boundary check
Date: Thu,  5 Apr 2018 11:55:48 +0200
Message-Id: <20180405095548.14433-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boundary check in mvpp2_prs_init_from_hw must be done according to the
passed "tid" parameter, not the mvpp2_prs_entry index, which is not yet
initialized at the time of the check.

Fixes: 47e0e14eb1a6 ("net: mvpp2: Make mvpp2_prs_hw_read a parser entry init function")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 7fc1bbf51c44..54a038943c06 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -1604,7 +1604,7 @@ static int mvpp2_prs_init_from_hw(struct mvpp2 *priv,
 {
 	int i;
 
-	if (pe->index > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
+	if (tid > MVPP2_PRS_TCAM_SRAM_SIZE - 1)
 		return -EINVAL;
 
 	memset(pe, 0, sizeof(*pe));
-- 
2.11.0
