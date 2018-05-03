Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeECNye (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 09:54:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34891 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbeECNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 09:54:29 -0400
X-Google-Smtp-Source: AB8JxZr2GUtRXXH5kNop9aCNBUA0oZ5J6QIrvLx6lTOmtQAC799mcnAX9l1Emb3Vvt/iLnvn5yfYtg==
From: Anders Roxell <anders.roxell@linaro.org>
To: architt@codeaurora.org, a.hajda@samsung.com, airlied@linux.ie,
        Laurent.pinchart@ideasonboard.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drm/bridge: cdns-dsi: mark PM functions as __maybe_unused
Date: Thu,  3 May 2018 15:54:21 +0200
Message-Id: <20180503135421.2294-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suspend/resume callbacks are now optional, leading to a warning when
they are unused:

drivers/gpu/drm/bridge/cdns-dsi.c:1353:12: warning: ‘cdns_dsi_suspend’
   defined but not used [-Wunused-function]
 static int cdns_dsi_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~
drivers/gpu/drm/bridge/cdns-dsi.c:1340:12: warning: ‘cdns_dsi_resume’
   defined but not used [-Wunused-function]
 static int cdns_dsi_resume(struct device *dev)
            ^~~~~~~~~~~~~~~

This marks the functions as __maybe_unused to avoid the warning.

Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index c255fc3e1be5..f2d43f24acfb 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -1337,7 +1337,7 @@ static const struct mipi_dsi_host_ops cdns_dsi_ops = {
 	.transfer = cdns_dsi_transfer,
 };
 
-static int cdns_dsi_resume(struct device *dev)
+static int __maybe_unused cdns_dsi_resume(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
@@ -1350,7 +1350,7 @@ static int cdns_dsi_resume(struct device *dev)
 	return 0;
 }
 
-static int cdns_dsi_suspend(struct device *dev)
+static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
-- 
2.17.0
