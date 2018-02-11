Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752727AbeBKHyd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 02:54:33 -0500
Received: from mga09.intel.com ([134.134.136.24]:33680 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbeBKHya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 02:54:30 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,494,1511856000";
   d="scan'208";a="200290944"
Date: Sun, 11 Feb 2018 15:54:13 +0800
From: kbuild test robot <lkp@intel.com>
To: Andy Yan <andy.yan@rock-chips.com>
Cc: kbuild-all@01.org, cyrille.pitchen@wedev4u.fr, mchehab@kernel.org,
        robh+dt@kernel.org, linux-mtd@lists.infradead.org,
        shawn.lin@rock-chips.com, heiko@sntech.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@free-electrons.com, Andy Yan <andy.yan@rock-chips.com>
Subject: [RFC PATCH] mtd: spi-nor: rockchip_sfc_runtime_suspend() can be
 static
Message-ID: <20180211075413.GA11432@lkp-wsm-ep2>
References: <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518092327-3827-1-git-send-email-andy.yan@rock-chips.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: dbc2d867929a ("mtd: spi-nor: add rockchip serial flash controller driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 rockchip-sfc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/rockchip-sfc.c b/drivers/mtd/spi-nor/rockchip-sfc.c
index 60371011..e38d79d 100644
--- a/drivers/mtd/spi-nor/rockchip-sfc.c
+++ b/drivers/mtd/spi-nor/rockchip-sfc.c
@@ -896,7 +896,7 @@ static int rockchip_sfc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-int rockchip_sfc_runtime_suspend(struct device *dev)
+static int rockchip_sfc_runtime_suspend(struct device *dev)
 {
 	struct rockchip_sfc *sfc = dev_get_drvdata(dev);
 
@@ -904,7 +904,7 @@ int rockchip_sfc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-int rockchip_sfc_runtime_resume(struct device *dev)
+static int rockchip_sfc_runtime_resume(struct device *dev)
 {
 	struct rockchip_sfc *sfc = dev_get_drvdata(dev);
 
