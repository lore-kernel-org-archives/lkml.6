Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFEDEC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0E4205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0E4205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbeH3U4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:56:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:63542 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbeH3U4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:56:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:53:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="69365338"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 30 Aug 2018 09:52:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F3C73A1; Thu, 30 Aug 2018 19:52:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/7] mfd: intel_soc_pmic_crc: Use DEFINE_RES_IRQ_NAMED() macro
Date:   Thu, 30 Aug 2018 19:52:50 +0300
Message-Id: <20180830165255.43114-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
References: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding each data structure with IRQ resources,
use dedicated macro.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_soc_pmic_crc.c | 35 +++++---------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
index 6d19a6d0fb97..de3f31266c57 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -36,48 +36,23 @@
 #define CRYSTAL_COVE_IRQ_VHDMIOCP	6
 
 static struct resource gpio_resources[] = {
-	{
-		.name	= "GPIO",
-		.start	= CRYSTAL_COVE_IRQ_GPIO,
-		.end	= CRYSTAL_COVE_IRQ_GPIO,
-		.flags	= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_GPIO, "GPIO"),
 };
 
 static struct resource pwrsrc_resources[] = {
-	{
-		.name  = "PWRSRC",
-		.start = CRYSTAL_COVE_IRQ_PWRSRC,
-		.end   = CRYSTAL_COVE_IRQ_PWRSRC,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_PWRSRC, "PWRSRC"),
 };
 
 static struct resource adc_resources[] = {
-	{
-		.name  = "ADC",
-		.start = CRYSTAL_COVE_IRQ_ADC,
-		.end   = CRYSTAL_COVE_IRQ_ADC,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_ADC, "ADC"),
 };
 
 static struct resource thermal_resources[] = {
-	{
-		.name  = "THERMAL",
-		.start = CRYSTAL_COVE_IRQ_THRM,
-		.end   = CRYSTAL_COVE_IRQ_THRM,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_THRM, "THERMAL"),
 };
 
 static struct resource bcu_resources[] = {
-	{
-		.name  = "BCU",
-		.start = CRYSTAL_COVE_IRQ_BCU,
-		.end   = CRYSTAL_COVE_IRQ_BCU,
-		.flags = IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(CRYSTAL_COVE_IRQ_BCU, "BCU"),
 };
 
 static struct mfd_cell crystal_cove_byt_dev[] = {
-- 
2.18.0

