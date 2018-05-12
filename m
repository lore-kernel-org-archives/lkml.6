Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbeELRr3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 13:47:29 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41540 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751284AbeELRr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 13:47:27 -0400
X-Google-Smtp-Source: AB8JxZqU7BAfgW72jRumFxNnxIbf7jPw1O59arFgRsRIzkLd2ZWOsHciJXNhpqn9I+BsguZ+4Mrw9w==
From: sumeet p <srplinux2008@gmail.com>
To: thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org
Cc: rui.zhang@intel.com, edubezval@gmail.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, srplinux2008@gmail.com
Subject: [PATCH V2] thermal: tegra: soctherm: add const to struct thermal_cooling_device_ops
Date: Sat, 12 May 2018 23:17:08 +0530
Message-Id: <1526147228-5317-1-git-send-email-srplinux2008@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the typecast with const to struct thermal_cooling_device_ops.
It is the last argument to the function thermal_of_cooling_device_register
and this argument is of type const. So, declare this structure
thermal_cooling_device_ops as constant.

Signed-off-by: sumeet p <srplinux2008@gmail.com>
---
Changes in V2:
- Updated Signed-off-by with correct name.

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
