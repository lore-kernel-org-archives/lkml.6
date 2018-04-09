Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758058AbeDICxX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 22:53:23 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:38852 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758068AbeDICxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 22:53:07 -0400
X-Google-Smtp-Source: AIpwx48PlCrrbS+P2yt3wpGXQoG5k233stabuCuyYPrEPHy5DurDimlMJ1HmnqV3u2su9afgEnsJHA==
From: srplinux2008 <srplinux2008@gmail.com>
To: orjan.eide@arm.com, rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        srplinux2008@gmail.com
Subject: [PATCH] thermal: devfreq_cooling: add const to struct thermal_cooling_device_ops
Date: Mon,  9 Apr 2018 08:22:55 +0530
Message-Id: <1523242375-3937-1-git-send-email-srplinux2008@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: srp linux <srplinux2008@gmail.com>

Add the typecast constant to structure thermal_cooling_device_ops. This
is the last argument to the function thermal_of_cooling_device_register
and this argument is of type const. So, declare this structure
thermal_cooling_device_ops as constant.

Signed-off-by: srp linux <srplinux2008@gmail.com>
---
 drivers/thermal/devfreq_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index ef59256..80efc4e 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -392,7 +392,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 	return 0;
 }
 
-static struct thermal_cooling_device_ops devfreq_cooling_ops = {
+static const struct thermal_cooling_device_ops devfreq_cooling_ops = {
 	.get_max_state = devfreq_cooling_get_max_state,
 	.get_cur_state = devfreq_cooling_get_cur_state,
 	.set_cur_state = devfreq_cooling_set_cur_state,
-- 
2.7.4
