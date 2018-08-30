Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA48C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB974205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB974205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeH3U4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:56:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:20167 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbeH3U4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:56:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:53:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="84732164"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 30 Aug 2018 09:52:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0C706173; Thu, 30 Aug 2018 19:52:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/7] mfd: intel_soc_pmic_crc: Use REGMAP_IRQ_REG() macro
Date:   Thu, 30 Aug 2018 19:52:51 +0300
Message-Id: <20180830165255.43114-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding each data structure with regmap IRQresources,
use dedicated macro.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index de3f31266c57..d33a0cff8cbd 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -109,27 +109,13 @@ static const struct regmap_config crystal_cove_regmap_config = {
 };
 
 static const struct regmap_irq crystal_cove_irqs[] = {
-	[CRYSTAL_COVE_IRQ_PWRSRC] = {
-		.mask = BIT(CRYSTAL_COVE_IRQ_PWRSRC),
-	},
-	[CRYSTAL_COVE_IRQ_THRM] = {
-		.mask = BIT(CRYSTAL_COVE_IRQ_THRM),
-	},
-	[CRYSTAL_COVE_IRQ_BCU] = {
-		.mask = BIT(CRYSTAL_COVE_IRQ_BCU),
-	},
-	[CRYSTAL_COVE_IRQ_ADC] = {
-		.mask = BIT(CRYSTAL_COVE_IRQ_ADC),
-	},
-	[CRYSTAL_COVE_IRQ_CHGR] = {
-		.mask = BIT(CRYSTAL_COVE_IRQ_CHGR),
-	},
-	[CRYSTAL_COVE_IRQ_GPIO] = {
-		.mask = BIT(CRYSTAL_COVE_IRQ_GPIO),
-	},
-	[CRYSTAL_COVE_IRQ_VHDMIOCP] = {
-		.mask = BIT(CRYSTAL_COVE_IRQ_VHDMIOCP),
-	},
+	REGMAP_IRQ_REG(CRYSTAL_COVE_IRQ_PWRSRC, 0, BIT(CRYSTAL_COVE_IRQ_PWRSRC)),
+	REGMAP_IRQ_REG(CRYSTAL_COVE_IRQ_THRM, 0, BIT(CRYSTAL_COVE_IRQ_THRM)),
+	REGMAP_IRQ_REG(CRYSTAL_COVE_IRQ_BCU, 0, BIT(CRYSTAL_COVE_IRQ_BCU)),
+	REGMAP_IRQ_REG(CRYSTAL_COVE_IRQ_ADC, 0, BIT(CRYSTAL_COVE_IRQ_ADC)),
+	REGMAP_IRQ_REG(CRYSTAL_COVE_IRQ_CHGR, 0, BIT(CRYSTAL_COVE_IRQ_CHGR)),
+	REGMAP_IRQ_REG(CRYSTAL_COVE_IRQ_GPIO, 0, BIT(CRYSTAL_COVE_IRQ_GPIO)),
+	REGMAP_IRQ_REG(CRYSTAL_COVE_IRQ_VHDMIOCP, 0, BIT(CRYSTAL_COVE_IRQ_VHDMIOCP)),
 };
 
 static const struct regmap_irq_chip crystal_cove_irq_chip = {
-- 
2.18.0

