Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932082AbeEWF2f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 01:28:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:46868 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753987AbeEWF12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 01:27:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,431,1520924400";
   d="scan'208";a="57687156"
From: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
To: alan@linux.intel.com, sakari.ailus@linux.intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org
Cc: linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] media: staging: atomisp: remove redundent check
Date: Wed, 23 May 2018 10:51:31 +0530
Message-Id: <1527052896-30777-2-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527052896-30777-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
References: <1527052896-30777-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assignment asd = &isp->asd[i] can never be null hence remove
redundent check.

Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
---
 drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c
index f668c68..7a9f3c9 100644
--- a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c
+++ b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_compat_css20.c
@@ -4592,8 +4592,6 @@ int atomisp_css_isr_thread(struct atomisp_device *isp,
 	 * delete wdt timer. */
 	for (i = 0; i < isp->num_of_streams; i++) {
 		asd = &isp->asd[i];
-		if (!asd)
-			continue;
 		if (asd->streaming != ATOMISP_DEVICE_STREAMING_ENABLED)
 			continue;
 		if (!atomisp_buffers_queued(asd))
-- 
2.7.4
