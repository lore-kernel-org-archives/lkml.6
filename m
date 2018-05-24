Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032240AbeEXOTo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:19:44 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45648 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032054AbeEXOTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:19:39 -0400
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: [PATCH v2 3/5] crypto: ccree: silence debug prints
Date: Thu, 24 May 2018 15:19:08 +0100
Message-Id: <1527171551-21979-4-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cache parameter register configuration was being too verbose.
Use dev_dbg() to only provide the information if needed.

Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index b266657..1e40e76 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -168,14 +168,14 @@ int init_cc_regs(struct cc_drvdata *drvdata, bool is_probe)
 	val = cc_ioread(drvdata, CC_REG(AXIM_CACHE_PARAMS));
 
 	if (is_probe)
-		dev_info(dev, "Cache params previous: 0x%08X\n", val);
+		dev_dbg(dev, "Cache params previous: 0x%08X\n", val);
 
 	cc_iowrite(drvdata, CC_REG(AXIM_CACHE_PARAMS), cache_params);
 	val = cc_ioread(drvdata, CC_REG(AXIM_CACHE_PARAMS));
 
 	if (is_probe)
-		dev_info(dev, "Cache params current: 0x%08X (expect: 0x%08X)\n",
-			 val, cache_params);
+		dev_dbg(dev, "Cache params current: 0x%08X (expect: 0x%08X)\n",
+			val, cache_params);
 
 	return 0;
 }
-- 
2.7.4
