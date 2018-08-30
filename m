Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15893C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC3620835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC3620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeH3U4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:56:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:63534 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeH3U4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:56:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:53:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="69365341"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2018 09:52:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 22FE31C9; Thu, 30 Aug 2018 19:52:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/7] mfd: Sort headers alphabetically for Intel PMIC drivers
Date:   Thu, 30 Aug 2018 19:52:53 +0300
Message-Id: <20180830165255.43114-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort headers alphabetically for better maintenance.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_bxtwc.c |  5 +++--
 drivers/mfd/intel_soc_pmic_core.c  | 13 +++++++------
 drivers/mfd/intel_soc_pmic_crc.c   |  3 ++-
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 9ca1f8c015de..c878724497a9 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -13,15 +13,16 @@
  * more details.
  */
 
-#include <linux/module.h>
 #include <linux/acpi.h>
-#include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/intel_soc_pmic.h>
 #include <linux/mfd/intel_soc_pmic_bxtwc.h>
+#include <linux/module.h>
+
 #include <asm/intel_pmc_ipc.h>
 
 /* PMIC device registers */
diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
index 274306d98ac1..170d5ed16a3b 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -16,16 +16,17 @@
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
  */
 
-#include <linux/module.h>
-#include <linux/mfd/core.h>
+#include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/gpio/consumer.h>
-#include <linux/acpi.h>
-#include <linux/regmap.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
 #include <linux/mfd/intel_soc_pmic.h>
-#include <linux/gpio/machine.h>
 #include <linux/pwm.h>
+#include <linux/regmap.h>
+
 #include "intel_soc_pmic_core.h"
 
 /* Crystal Cove PMIC shares same ACPI ID between different platforms */
diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index d33a0cff8cbd..5ac6f3710294 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -16,10 +16,11 @@
  * Author: Zhu, Lejun <lejun.zhu@linux.intel.com>
  */
 
-#include <linux/mfd/core.h>
 #include <linux/interrupt.h>
 #include <linux/regmap.h>
+#include <linux/mfd/core.h>
 #include <linux/mfd/intel_soc_pmic.h>
+
 #include "intel_soc_pmic_core.h"
 
 #define CRYSTAL_COVE_MAX_REGISTER	0xC6
-- 
2.18.0

