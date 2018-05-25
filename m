Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967110AbeEYPwx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:52:53 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37085 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966593AbeEYPwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:52:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>, David Airlie <airlied@linux.ie>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] drm/bridge: cdns: mark PM functions as __maybe_unused
Date: Fri, 25 May 2018 17:50:15 +0200
Message-Id: <20180525155030.3667352-8-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180525155030.3667352-1-arnd@arndb.de>
References: <20180525155030.3667352-1-arnd@arndb.de>
X-Provags-ID: V03:K1:lga64+uz/9QQLDSfmMLk93/z4dpHilERqvwweRQ3nvCYM/n5dOf
 KhLeBcrOw+yHwoC6zoQDwlcSz+SY6MqXXoswc6OfdOV3u+fnF1kbIW449aakeUmVqwU5xJC
 5HMSBlq8bH90k54rDhcRvQ1BlufcFYoLVvBF/1YTSIh3XQQxh7Gp/rozJD/If8OSyBfOxOn
 0aJZORYE0iuXx5YoEpsmA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uwXKNT78spY=:SgwoEUxWbdiAKSZSBx5Rb+
 g0DxNsmyNQ/ZB3swW/LALHS2iVgnzgZwvBB92sVZTK755fbd0eAfOyCAgRIBihCsPRacPobKk
 zvzqItRPY7bbof902upNr1cEFl88xlf6+/yl/48LbsY+A5c5PgkD1b5SRZT0UPsrlGkuW4Fc+
 lWHTAqipCtJnDXMK0brije+fSRMUYBxZ/3AQzVg85VCbd1xFnCVRdcRQZZMbe+kR+Dz8tuoli
 7FgqGk3GfKEHMNOxZ8qtewFDFb0DFj9yGhlKSN/WZTKyw9QEhLEvtBbuLj6fsX2hshL6f97XH
 TGLxRIU4Ur4SjV3ID3OF1fTJqFZ5bqNDrixhVxGsvVonV9tU5IQ0LtxSk7YxNRBwIu2tbiydG
 JoRSzIiAS2bZlJ4Kd9QN6NEGqpbx5BpI13GcySllpefYpMZjySft1z/PVd7KanqI51uIi49ZO
 +CsCjz+YoxK4/v7l1PfSoKNIS9bMbelY3FF4L8Z7sf5vY9Som5vTXfqd2CCydE8+zz+ccvn34
 C78tI65OdyVDPhJ4VTEK81JHh99jZYZFQ/U7VuIX3sowA91yiFHyCu7sNvwk284FCGMCsm0pn
 Fnbc8twVQmL5rk6Ah6B6ObyqAmi0LYpzvhAetH0H66t6pZ9SGANOKLzg9fA3mFtSouMLICo6x
 Dvf8IStz03AxCskh/ZUVsGjxzZ7/ZK/h9Nr6IJfqCsyjHXlIIQLQM92jpW8hCnwlQEuE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two functions are unused in some configurations, and using __maybe_unused
is the easiest way to shut up the harmless warnings:

drivers/gpu/drm/bridge/cdns-dsi.c:1353:12: error: 'cdns_dsi_suspend' defined but not used [-Werror=unused-function]
 static int cdns_dsi_suspend(struct device *dev)
            ^~~~~~~~~~~~~~~~
drivers/gpu/drm/bridge/cdns-dsi.c:1340:12: error: 'cdns_dsi_resume' defined but not used [-Werror=unused-function]
 static int cdns_dsi_resume(struct device *dev)

Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
2.9.0
