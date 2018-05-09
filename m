Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934924AbeEIM6G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:58:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55362 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934905AbeEIM6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:58:03 -0400
From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de,
        linux-pm@vger.kernel.org, dbasehore@chromium.org,
        linux-kernel@vger.kernel.org, dianders@google.com, groeck@chromium.org,
        kernel@collabora.com, hl@rock-chips.com,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v4 6/6] devfreq: rk3399_dmc: fix spelling mistakes.
Date: Wed,  9 May 2018 14:57:48 +0200
Message-Id: <20180509125749.31318-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180509125749.31318-1-enric.balletbo@collabora.com>
References: <20180509125749.31318-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some spelling mistakes in error and debug messages.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v4:
- [6/6] Introduce this new patch that fixes some spelling.

Changes in v3: None
Changes in v2: None

 drivers/devfreq/rk3399_dmc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 5bfca028eaaf..d5c03e5abe13 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -103,7 +103,7 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 		err = regulator_set_voltage(dmcfreq->vdd_center, target_volt,
 					    target_volt);
 		if (err) {
-			dev_err(dev, "Cannot to set voltage %lu uV\n",
+			dev_err(dev, "Cannot set voltage %lu uV\n",
 				target_volt);
 			goto out;
 		}
@@ -111,8 +111,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 
 	err = clk_set_rate(dmcfreq->dmc_clk, target_rate);
 	if (err) {
-		dev_err(dev, "Cannot to set frequency %lu (%d)\n",
-			target_rate, err);
+		dev_err(dev, "Cannot set frequency %lu (%d)\n", target_rate,
+			err);
 		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
 				      dmcfreq->volt);
 		goto out;
@@ -128,8 +128,8 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 
 	/* If get the incorrect rate, set voltage to old value. */
 	if (dmcfreq->rate != target_rate) {
-		dev_err(dev, "Get wrong ddr frequency, Request frequency %lu,\
-			Current frequency %lu\n", target_rate, dmcfreq->rate);
+		dev_err(dev, "Got wrong frequency, Request %lu, Current %lu\n",
+			target_rate, dmcfreq->rate);
 		regulator_set_voltage(dmcfreq->vdd_center, dmcfreq->volt,
 				      dmcfreq->volt);
 		goto out;
@@ -137,7 +137,7 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 		err = regulator_set_voltage(dmcfreq->vdd_center, target_volt,
 					    target_volt);
 	if (err)
-		dev_err(dev, "Cannot to set vol %lu uV\n", target_volt);
+		dev_err(dev, "Cannot set voltage %lu uV\n", target_volt);
 
 	dmcfreq->rate = target_rate;
 	dmcfreq->volt = target_volt;
-- 
2.17.0
