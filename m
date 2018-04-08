Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751911AbeDHMCD (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 08:02:03 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39208 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeDHMCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 08:02:01 -0400
X-Google-Smtp-Source: AIpwx4/RiDBia/KQo3BXGRcOqDZaFuFlJAVjdgSISWu6fEWjQF+GuBMVCjiUuiK0xXS9ICWlMNA7zQ==
From: srplinux2008 <srplinux2008@gmail.com>
To: thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, srplinux2008@gmail.com
Subject: [PATCH] thermal: tegra: soctherm: add const to struct thermal_cooling_device_ops
Date: Sun,  8 Apr 2018 17:31:45 +0530
Message-Id: <1523188905-3066-1-git-send-email-srplinux2008@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: srp linux <srplinux2008@gmail.com>

Correct the typecast with const to struct thermal_cooling_device_ops.
It is the last argument to the function thermal_of_cooling_device_register
and this argument is of type const. So, declare this structure
thermal_cooling_device_ops as constant.

Signed-off-by: srp linux <srplinux2008@gmail.com>
---
 drivers/thermal/tegra/soctherm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 455b58c..72da745 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -926,7 +926,7 @@ static int throt_set_cdev_state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static struct thermal_cooling_device_ops throt_cooling_ops = {
+static const struct thermal_cooling_device_ops throt_cooling_ops = {
 	.get_max_state = throt_get_cdev_max_state,
 	.get_cur_state = throt_get_cdev_cur_state,
 	.set_cur_state = throt_set_cdev_state,
-- 
2.7.4
