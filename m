Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21187C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E962A2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfBDUlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:41:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:30920 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726676AbfBDUlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:41:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 12:41:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="140624638"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga002.fm.intel.com with ESMTP; 04 Feb 2019 12:40:59 -0800
From:   richard.gong@linux.intel.com
To:     catalin.marinas@arm.com, will.deacon@arm.com, dinguyen@kernel.org,
        atull@kernel.org, mdf@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        todd.riffel@intel.com, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv2] arm64: defconfig: enable fpga and service layer
Date:   Mon,  4 Feb 2019 14:48:37 -0600
Message-Id: <1549313317-22964-1-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Enable FPGA framework, Intel Stratix10 SoC FPGA manager, Stratix10
service layer, and Altera Freeze Bridge drivers.

Intel Stratix10 service layer driver was added with commit 7ca5ce896524
("firmware: add Intel Stratix10 service layer driver").

Intel Stratix10 service layer provides kernel APIs for drivers to request
access to the secure features. Such features include FPGA programming,
remote status update, and read and write secure registers.

While clients of the service layer can be built as modules, the service
layer itself has to be configured as built-in.  The service layer is
dependent on ARCH_STRATIX10.

Enabling Altera Freeze Bridge depends on commit 38cd7ad5bd25
("fpga: altera_freeze_bridge: remove restriction to socfpga").

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
v2: add to enable FPGA framework, Intel Stratix10 SoC FPGA manager and
    Altera freeze bridge drivers.
---
 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 931429d9..96c52f4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -733,6 +733,13 @@ CONFIG_QCOM_QFPROM=y
 CONFIG_ROCKCHIP_EFUSE=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_MESON_EFUSE=m
+CONFIG_INTEL_STRATIX10_SERVICE=y
+CONFIG_FPGA=m
+CONFIG_FPGA_MGR_STRATIX10_SOC=m
+CONFIG_FPGA_BRIDGE=m
+CONFIG_ALTERA_FREEZE_BRIDGE=m
+CONFIG_FPGA_REGION=m
+CONFIG_OF_FPGA_REGION=m
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_EXT2_FS=y
-- 
2.7.4

