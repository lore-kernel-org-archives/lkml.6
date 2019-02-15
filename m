Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF46C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CFE21B18
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbfBOPL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:11:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37071 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbfBOPL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:11:58 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1guf9d-0000kb-UD; Fri, 15 Feb 2019 15:11:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] mlxsw: core: fix spelling mistake "temprature" -> "temperature"
Date:   Fri, 15 Feb 2019 15:11:53 +0000
Message-Id: <20190215151153.17206-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in several dev_err messages, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
index f1ada4cdbd6b..6956bbebe2f1 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_hwmon.c
@@ -208,7 +208,7 @@ static ssize_t mlxsw_hwmon_module_temp_show(struct device *dev,
 			    1);
 	err = mlxsw_reg_query(mlxsw_hwmon->core, MLXSW_REG(mtbr), mtbr_pl);
 	if (err) {
-		dev_err(dev, "Failed to query module temprature sensor\n");
+		dev_err(dev, "Failed to query module temperature sensor\n");
 		return err;
 	}
 
@@ -251,7 +251,7 @@ static ssize_t mlxsw_hwmon_module_temp_fault_show(struct device *dev,
 			    1);
 	err = mlxsw_reg_query(mlxsw_hwmon->core, MLXSW_REG(mtbr), mtbr_pl);
 	if (err) {
-		dev_err(dev, "Failed to query module temprature sensor\n");
+		dev_err(dev, "Failed to query module temperature sensor\n");
 		return err;
 	}
 
@@ -291,7 +291,7 @@ mlxsw_hwmon_module_temp_critical_show(struct device *dev,
 	err = mlxsw_env_module_temp_thresholds_get(mlxsw_hwmon->core, module,
 						   SFP_TEMP_HIGH_WARN, &temp);
 	if (err) {
-		dev_err(dev, "Failed to query module temprature thresholds\n");
+		dev_err(dev, "Failed to query module temperature thresholds\n");
 		return err;
 	}
 
@@ -314,7 +314,7 @@ mlxsw_hwmon_module_temp_emergency_show(struct device *dev,
 	err = mlxsw_env_module_temp_thresholds_get(mlxsw_hwmon->core, module,
 						   SFP_TEMP_HIGH_ALARM, &temp);
 	if (err) {
-		dev_err(dev, "Failed to query module temprature thresholds\n");
+		dev_err(dev, "Failed to query module temperature thresholds\n");
 		return err;
 	}
 
-- 
2.20.1

