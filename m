Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753700AbeDSOWw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:22:52 -0400
Received: from sauhun.de ([88.99.104.3]:45378 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753330AbeDSOG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:56 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Subject: [PATCH 13/61] gpu: drm: msm: disp: mdp5: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:43 +0200
Message-Id: <20180419140641.27926-14-wsa+renesas@sang-engineering.com>
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

 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 6d8e3a9a6fc0..d50927f00c6f 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -1014,8 +1014,7 @@ static int mdp5_dev_remove(struct platform_device *pdev)
 
 static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
+	struct mdp5_kms *mdp5_kms = dev_get_drvdata(dev);
 
 	DBG("");
 
@@ -1024,8 +1023,7 @@ static __maybe_unused int mdp5_runtime_suspend(struct device *dev)
 
 static __maybe_unused int mdp5_runtime_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct mdp5_kms *mdp5_kms = platform_get_drvdata(pdev);
+	struct mdp5_kms *mdp5_kms = dev_get_drvdata(dev);
 
 	DBG("");
 
-- 
2.11.0
