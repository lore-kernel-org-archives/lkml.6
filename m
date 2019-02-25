Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C9320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfBYTDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:03:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:35221 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfBYTCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:02:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2019 11:02:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,412,1544515200"; 
   d="scan'208";a="127150069"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by fmsmga008.fm.intel.com with ESMTP; 25 Feb 2019 11:02:35 -0800
From:   thor.thayer@linux.intel.com
To:     bp@alien8.de, dinguyen@kernel.org, linux@armlinux.org.uk,
        mchehab@kernel.org, james.morse@arm.com
Cc:     thor.thayer@linux.intel.com, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/2] ARM: socfpga_defconfig: enable EDAC by default
Date:   Mon, 25 Feb 2019 12:56:46 -0600
Message-Id: <1551121006-4657-3-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
References: <1551121006-4657-1-git-send-email-thor.thayer@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Enable the different ECC blocks by default on Cyclone5
and Arria10.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2 Rebase patch to the arm/defconfig on the arm-soc tree
---
 arch/arm/configs/socfpga_defconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 08d1b3e11d68..1f2056c76ef1 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -122,11 +122,23 @@ CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_CPU=y
+CONFIG_EDAC=y
+CONFIG_EDAC_ALTERA=y
+CONFIG_EDAC_ALTERA_SDRAM=y
+CONFIG_EDAC_ALTERA_L2C=y
+CONFIG_EDAC_ALTERA_OCRAM=y
+CONFIG_EDAC_ALTERA_ETHERNET=y
+CONFIG_EDAC_ALTERA_NAND=y
+CONFIG_EDAC_ALTERA_DMA=y
+CONFIG_EDAC_ALTERA_USB=y
+CONFIG_EDAC_ALTERA_QSPI=y
+CONFIG_EDAC_ALTERA_SDMMC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_DMATEST=m
+CONFIG_RAS=y
 CONFIG_FPGA=y
 CONFIG_FPGA_MGR_SOCFPGA=y
 CONFIG_FPGA_MGR_SOCFPGA_A10=y
-- 
2.7.4

