Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeDXPFT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 11:05:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:49106 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751709AbeDXPFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 11:05:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="45681391"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] mfd: intel-lpss: Correct names of RESETS register bits
Date: Tue, 24 Apr 2018 18:05:12 +0300
Message-Id: <20180424150512.60824-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation the function has 2 bits for reset
while iDMA 64-bit has only one.

Rename it accordingly. Note, there is no functional change since
we always handle them together.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel-lpss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 4bcf117a7ba8..50bffc3382d7 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -40,8 +40,8 @@
 
 /* Offsets from lpss->priv */
 #define LPSS_PRIV_RESETS		0x04
-#define LPSS_PRIV_RESETS_FUNC		BIT(2)
-#define LPSS_PRIV_RESETS_IDMA		0x3
+#define LPSS_PRIV_RESETS_IDMA		BIT(2)
+#define LPSS_PRIV_RESETS_FUNC		0x3
 
 #define LPSS_PRIV_ACTIVELTR		0x10
 #define LPSS_PRIV_IDLELTR		0x14
-- 
2.17.0
