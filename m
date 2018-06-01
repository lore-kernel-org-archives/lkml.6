Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753586AbeFATrP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:47:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:50898 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753526AbeFATrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:47:10 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,467,1520924400";
   d="scan'208";a="44002596"
Date: Sat, 2 Jun 2018 03:46:13 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: kbuild-all@01.org, netdev@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Yan Markman <ymarkman@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next] net: mvpp2: mvpp2_percpu_read_relaxed() can be
 static
Message-ID: <20180601194613.GA44770@xian>
References: <201806020329.B1k6qmEB%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201806020329.B1k6qmEB%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: db9d7d36eecc ("net: mvpp2: Split the PPv2 driver to a dedicated directory")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 mvpp2_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 45622bf..0319ed9 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -141,7 +141,7 @@ void mvpp2_percpu_write_relaxed(struct mvpp2 *priv, int cpu,
 	writel_relaxed(data, priv->swth_base[cpu] + offset);
 }
 
-u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, int cpu,
+static u32 mvpp2_percpu_read_relaxed(struct mvpp2 *priv, int cpu,
 				     u32 offset)
 {
 	return readl_relaxed(priv->swth_base[cpu] + offset);
