Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2698C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBDB214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 05:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cLXsRb3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBDB214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbeHVI4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 04:56:22 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58904 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVI4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 04:56:22 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7M5WgDc034756;
        Wed, 22 Aug 2018 00:32:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534915962;
        bh=orvvOJMsBGYyWOm8AavAvYPBT/9HzUdGKUxWUid30y8=;
        h=From:To:CC:Subject:Date;
        b=cLXsRb3FvlFEsFC3pMncapHp7AaDnA7YjEye0MYmT5PXdyI/vVkXsrkznCizAfd0f
         wdvt+uI1nuwSUt9CEF0zDFBt9ur8C2L7qD7HM8bJbym9Od7yN76ux97wUrXb/fR3qY
         oHtFp42oIgqF8Kr//vJr6FdubL4O6Jnd3Iw04Nbc=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7M5Wg8u012835;
        Wed, 22 Aug 2018 00:32:42 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 22
 Aug 2018 00:32:42 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 22 Aug 2018 00:32:42 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7M5Wd08029170;
        Wed, 22 Aug 2018 00:32:40 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>
CC:     <ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <d-gerlach@ti.com>,
        <j-keerthy@ti.com>, <t-kristo@ti.com>
Subject: [PATCH] soc: ti: pm33xx: Enable DS0 for the platforms on which it is functional
Date:   Wed, 22 Aug 2018 11:02:31 +0530
Message-ID: <1534915951-8783-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DS0 for only those platforms on which it is functional

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/pm33xx-core.c    | 5 +++++
 drivers/soc/ti/pm33xx.c              | 9 +++++++++
 include/linux/platform_data/pm33xx.h | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/arch/arm/mach-omap2/pm33xx-core.c b/arch/arm/mach-omap2/pm33xx-core.c
index f4971e4..f0f6e8e 100644
--- a/arch/arm/mach-omap2/pm33xx-core.c
+++ b/arch/arm/mach-omap2/pm33xx-core.c
@@ -135,6 +135,11 @@ static int am43xx_suspend(unsigned int state, int (*fn)(unsigned long),
 {
 	int ret = 0;
 
+	if (!(args & WFI_FLAG_DEEP_SLEEP0)) {
+		pr_err("DS0 mode not supported\n");
+		return -ENOTSUPP;
+	}
+
 	amx3_pre_suspend_common();
 	scu_power_mode(scu_base, SCU_PM_POWEROFF);
 	ret = cpu_suspend(args, fn);
diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index d0dab32..53238d7 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -324,6 +324,15 @@ static int am33xx_pm_probe(struct platform_device *pdev)
 	suspend_wfi_flags |= WFI_FLAG_SAVE_EMIF;
 	suspend_wfi_flags |= WFI_FLAG_WAKE_M3;
 
+	/*
+	 * Deep Sleep0 mode is currently functional only on am437x-gp-evm,
+	 * am33xx-evm and boneblack family. Hence set the DS0 flag
+	 */
+	if (of_machine_is_compatible("ti,am437x-gp-evm") ||
+	    of_machine_is_compatible("ti,am335x-bone-black") ||
+	    of_machine_is_compatible("ti,am335x-evm"))
+		suspend_wfi_flags |= WFI_FLAG_DEEP_SLEEP0;
+
 	ret = pm_ops->init();
 	if (ret) {
 		dev_err(dev, "Unable to call core pm init!\n");
diff --git a/include/linux/platform_data/pm33xx.h b/include/linux/platform_data/pm33xx.h
index fbf5ed7..5c54b64 100644
--- a/include/linux/platform_data/pm33xx.h
+++ b/include/linux/platform_data/pm33xx.h
@@ -28,12 +28,14 @@
  * WFI_FLAG_WAKE_M3: Disable MPU clock or clockdomain to cause wkup_m3 to
  *		     execute when WFI instruction executes.
  * WFI_FLAG_RTC_ONLY: Configure the RTC to enter RTC+DDR mode.
+ * WFI_FLAG_DEEP_SLEEP0: Configure to enter Depp Sleep 0 mode.
  */
 #define WFI_FLAG_FLUSH_CACHE		BIT(0)
 #define WFI_FLAG_SELF_REFRESH		BIT(1)
 #define WFI_FLAG_SAVE_EMIF		BIT(2)
 #define WFI_FLAG_WAKE_M3		BIT(3)
 #define WFI_FLAG_RTC_ONLY		BIT(4)
+#define WFI_FLAG_DEEP_SLEEP0		BIT(5)
 
 #ifndef __ASSEMBLER__
 struct am33xx_pm_sram_addr {
-- 
1.9.1

