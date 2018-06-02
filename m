Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbeFBHyF (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 03:54:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33248 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeFBHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 03:54:00 -0400
Date: Sat, 2 Jun 2018 10:52:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: David Lechner <david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] clk: davinci: cfgchip: testing the wrong variable
Message-ID: <20180602075256.hrvidsfsmr33mv2f@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8911 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=912
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806020091
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a copy and paste bug here.  We should be testing "usb1" instead
of "usb0".

Fixes: 58e1e2d2cd89 ("clk: davinci: cfgchip: Add TI DA8XX USB PHY clocks")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/clk/davinci/da8xx-cfgchip.c b/drivers/clk/davinci/da8xx-cfgchip.c
index c971111d2601..20a120aa147e 100644
--- a/drivers/clk/davinci/da8xx-cfgchip.c
+++ b/drivers/clk/davinci/da8xx-cfgchip.c
@@ -672,7 +672,7 @@ static int of_da8xx_usb_phy_clk_init(struct device *dev, struct regmap *regmap)
 
 	usb1 = da8xx_cfgchip_register_usb1_clk48(dev, regmap);
 	if (IS_ERR(usb1)) {
-		if (PTR_ERR(usb0) == -EPROBE_DEFER)
+		if (PTR_ERR(usb1) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
 
 		dev_warn(dev, "Failed to register usb1_clk48 (%ld)\n",
