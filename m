Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933264AbeCMMGI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:06:08 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:40713 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933209AbeCMMGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:06:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: v4l: omap_vout: vrfb: remove an unused variable
Date: Tue, 13 Mar 2018 13:05:36 +0100
Message-Id: <20180313120548.2603484-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:jOoLuxAQsM6wfRNs80xOOcGcdIAaoC3BaeJpgIXMxcnrrc50ZNk
 SINJtHZuhDkiqeEVVZIHHaA7J12zSr/BjnzbyJwOqXNbhoSE5+EFeCfD7m7JP6Oh76MlMVd
 OKAzTPWowUmymLtTRXnK5OLvOjE5bn9D65RKNmO2irKQIB8bJTTjTzwG4AX7ob5O8K1AJ6Q
 y7ZjSwJTO1XkR+lCg6jzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DXJVmhvn5RY=:TQJVEJTGIWx1QUUnmHyr4G
 1+KQB4Phf5G1Xq8JK0M4tprGXLlvUbL6LAL72c+jVhu25q7/dytt7mRY5ruRITqP4yhRkUs7R
 0e/V1fNoOA5UpRQ0UW1wsgQh4iri2Le8SoUcm9msLpvl+UR/hym32bCqIBFCHbNzUgveFpPxp
 lLrnDrg3+eRqqO91CdXgeTInZxQOdc2eE/YNhkruTvIyFK7wQgQlY21/ipRUUQnj5wJK6rTqm
 L3/Yi5ktD0AbHtDw83chD2DmmZh/kshzCPZYBhCLqLanDUJ/JFd+zCrvoWUlV+38dnqnyG7DP
 38lBIcse0Osfens8eoZFgM8q9vr0XaoVr6OMGLLicOnQsqnXzGnBFvrTExAIk5J3IfHzY2U6T
 dviNDm9G+VDTgtOOx3gw11cSohBqRFpQjtGpRS2V7uMZnHFkYIdbgwJ2TaH5e+rQ17FqI6vX0
 L5AJNvUBW61odByfR4OgAzQ3lgFrXP6FcA7lW/xejFhqIuQrdzb4J7C0ekjxsPhZyXMg9WYaU
 sd2rk7f8WMzR/qohbdL1JaTfZqIOQHvRotewMBqX6kUXkIRZuuB0KB+vssSp/RY48YiIkBITp
 Ibwq7/4PpyWmstjtqSVNUbdjG7FQ3Q3M0ZLoxMtlf8xB2RCWgysS3hTpu6I5XPCmdyAx6KIfk
 dWTI0IbylSgbfJugc9uVui22+6GcF9G8cYDdTIC3xIEoOEM2Nhd+VA73Ioi9gTw9aUXzlxKAN
 mbI9442gEx513QVrJDqOUQbSopW/sZdQjdb/9Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We now get a warning after the 'dmadev' variable is no longer used:

drivers/media/platform/omap/omap_vout_vrfb.c: In function 'omap_vout_prepare_vrfb':
drivers/media/platform/omap/omap_vout_vrfb.c:239:21: error: unused variable 'dmadev' [-Werror=unused-variable]

Fixes: 8f0aa38292f2 ("media: v4l: omap_vout: vrfb: Use the wrapper for prep_interleaved_dma()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/platform/omap/omap_vout_vrfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/platform/omap/omap_vout_vrfb.c b/drivers/media/platform/omap/omap_vout_vrfb.c
index 72c0ac2cbf3d..1d8508237220 100644
--- a/drivers/media/platform/omap/omap_vout_vrfb.c
+++ b/drivers/media/platform/omap/omap_vout_vrfb.c
@@ -236,7 +236,6 @@ int omap_vout_prepare_vrfb(struct omap_vout_device *vout,
 	struct dma_async_tx_descriptor *tx;
 	enum dma_ctrl_flags flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 	struct dma_chan *chan = vout->vrfb_dma_tx.chan;
-	struct dma_device *dmadev = chan->device;
 	struct dma_interleaved_template *xt = vout->vrfb_dma_tx.xt;
 	dma_cookie_t cookie;
 	enum dma_status status;
-- 
2.9.0
