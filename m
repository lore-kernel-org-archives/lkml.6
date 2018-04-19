Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753512AbeDSOHG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:07:06 -0400
Received: from sauhun.de ([88.99.104.3]:45280 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753331AbeDSOG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:57 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: [PATCH 18/61] iio: common: cros_ec_sensors: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:48 +0200
Message-Id: <20180419140641.27926-19-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index a620eb5ce202..3df6c0e09832 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -448,8 +448,7 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_write);
 
 static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
 
 	if (st->curr_sampl_freq == 0)
@@ -471,8 +470,7 @@ static int __maybe_unused cros_ec_sensors_prepare(struct device *dev)
 
 static void __maybe_unused cros_ec_sensors_complete(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
 
 	if (st->curr_sampl_freq == 0)
-- 
2.11.0
