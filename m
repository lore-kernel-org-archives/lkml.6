Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C55C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AA220894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31AA220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbeH1RkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:40:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:61240 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728401AbeH1RkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:40:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 06:48:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,299,1531810800"; 
   d="scan'208";a="85609978"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga001.jf.intel.com with ESMTP; 28 Aug 2018 06:48:15 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, catalin.marinas@arm.com,
        will.deacon@arm.com, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, atull@kernel.org, mdf@kernel.org,
        arnd@arndb.de, corbet@lwn.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, yves.vandervennet@linux.intel.com,
        richard.gong@intel.com
Subject: [PATCHv8 7/9] defconfig: enable fpga and service layer
Date:   Tue, 28 Aug 2018 08:50:43 -0500
Message-Id: <1535464245-11638-8-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535464245-11638-1-git-send-email-richard.gong@linux.intel.com>
References: <1535464245-11638-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Enable fpga framework, Stratix 10 SoC FPGA manager and Stratix10
Service Layer

Signed-off-by: Richard Gong <richard.gong@intel.com>
Signed-off-by: Alan Tull <atull@kernel.org>
---
v2: this patch is added in patch set version 2
v3: no change
v4: s/CONFIG_INTEL_SERVICE/CONFIG_STRATIX10_SERVICE/
    add CONFIG_OF_FPGA_REGION=y
    s/Intel/Stratix10/ in subject line
v5: no change
v6: no change
v7: no change
v8: no change
---
 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5..2ad50a5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -185,6 +185,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_NVME=m
+CONFIG_STRATIX10_SERVICE=y
 CONFIG_SRAM=y
 CONFIG_EEPROM_AT25=m
 # CONFIG_SCSI_PROC_FS is not set
@@ -642,6 +643,12 @@ CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_HISI_PMU=y
 CONFIG_QCOM_L2_PMU=y
 CONFIG_QCOM_L3_PMU=y
+CONFIG_MESON_EFUSE=m
+CONFIG_FPGA=y
+CONFIG_FPGA_MGR_STRATIX10_SOC=y
+CONFIG_FPGA_REGION=y
+CONFIG_FPGA_BRIDGE=y
+CONFIG_OF_FPGA_REGION=y
 CONFIG_QCOM_QFPROM=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_UNIPHIER_EFUSE=y
-- 
2.7.4

