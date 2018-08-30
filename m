Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A360C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB5020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 16:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB5020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeH3U4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 16:56:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:54737 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbeH3U4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 16:56:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Aug 2018 09:53:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,307,1531810800"; 
   d="scan'208";a="67220562"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2018 09:52:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E9F6F110; Thu, 30 Aug 2018 19:52:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/7] mfd: intel_msic: Use DEFINE_RES_IRQ() macro
Date:   Thu, 30 Aug 2018 19:52:49 +0300
Message-Id: <20180830165255.43114-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding each data structure with IRQ resources,
use dedicated macro.

In one case use DEFINE_RES_IRQ_NAMED() and DEFINE_RES_MEM_NAMED().

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/intel_msic.c | 44 +++++++++-------------------------------
 1 file changed, 10 insertions(+), 34 deletions(-)

diff --git a/drivers/mfd/intel_msic.c b/drivers/mfd/intel_msic.c
index 2017446c5b4b..441de7b3d231 100644
--- a/drivers/mfd/intel_msic.c
+++ b/drivers/mfd/intel_msic.c
@@ -54,68 +54,44 @@ struct intel_msic {
 };
 
 static struct resource msic_touch_resources[] = {
-	{
-		.flags		= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(0),
 };
 
 static struct resource msic_adc_resources[] = {
-	{
-		.flags		= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(0),
 };
 
 static struct resource msic_battery_resources[] = {
-	{
-		.flags		= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(0),
 };
 
 static struct resource msic_gpio_resources[] = {
-	{
-		.flags		= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(0),
 };
 
 static struct resource msic_audio_resources[] = {
-	{
-		.name		= "IRQ",
-		.flags		= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ_NAMED(0, "IRQ"),
 	/*
 	 * We will pass IRQ_BASE to the driver now but this can be removed
 	 * when/if the driver starts to use intel_msic_irq_read().
 	 */
-	{
-		.name		= "IRQ_BASE",
-		.flags		= IORESOURCE_MEM,
-		.start		= MSIC_IRQ_STATUS_ACCDET,
-		.end		= MSIC_IRQ_STATUS_ACCDET,
-	},
+	DEFINE_RES_MEM_NAMED(MSIC_IRQ_STATUS_ACCDET, 1, "IRQ_BASE"),
 };
 
 static struct resource msic_hdmi_resources[] = {
-	{
-		.flags		= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(0),
 };
 
 static struct resource msic_thermal_resources[] = {
-	{
-		.flags		= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(0),
 };
 
 static struct resource msic_power_btn_resources[] = {
-	{
-		.flags		= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(0),
 };
 
 static struct resource msic_ocd_resources[] = {
-	{
-		.flags		= IORESOURCE_IRQ,
-	},
+	DEFINE_RES_IRQ(0),
 };
 
 /*
-- 
2.18.0

