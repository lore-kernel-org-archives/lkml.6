Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750808AbeCFFFt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 00:05:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:6201 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750713AbeCFFFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 00:05:47 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,430,1515484800";
   d="scan'208";a="209124780"
Date: Tue, 6 Mar 2018 13:05:06 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Stefan Chulski <stefanc@marvell.com>
Cc: kbuild-all@01.org, Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Miquel Raynal <miquel.raynal@free-electrons.com>,
        Marcin Wojtas <mw@semihalf.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH linux-next] net: mvpp2: mvpp2_check_hw_buf_num() can be
 static
Message-ID: <20180306050506.GA35183@xian>
References: <201803061326.5AOkQ4Wu%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803061326.5AOkQ4Wu%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: effbf5f58d64 ("net: mvpp2: update the BM buffer free/destroy logic")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 mvpp2.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index c7b8093..c360430 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4285,7 +4285,7 @@ static void mvpp2_bm_bufs_free(struct device *dev, struct mvpp2 *priv,
 }
 
 /* Check number of buffers in BM pool */
-int mvpp2_check_hw_buf_num(struct mvpp2 *priv, struct mvpp2_bm_pool *bm_pool)
+static int mvpp2_check_hw_buf_num(struct mvpp2 *priv, struct mvpp2_bm_pool *bm_pool)
 {
 	int buf_num = 0;
 
