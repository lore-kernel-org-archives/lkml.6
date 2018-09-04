Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF19C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA2720843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 10:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Qc20k0HO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Y3tx4ZTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA2720843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbeIDOmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 10:42:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40152 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeIDOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 10:42:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0E926605BD; Tue,  4 Sep 2018 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536056267;
        bh=vcwJKc6DIeKDKAzOSUSJjXPsxjhl65GIRbKNIBnDBNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qc20k0HOLlL5Arxe2j2yQgH7gPs1/QZpFxzcDfvhTQpERGtYWTUvLZVJfFidJu3EP
         94Y1A3PJdsF8imik3+HtSItk8NF4eXiry98P0KbgxwCg3Bwlc85c4J1zIjfQGH8ND0
         UVCBQQQZx5xDy2OHo71KpyqCX+2ADeZ6zhDqMYvI=
Received: from blr-ubuntu-41.ap.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vivek.gautam@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DC26D607B9;
        Tue,  4 Sep 2018 10:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536056264;
        bh=vcwJKc6DIeKDKAzOSUSJjXPsxjhl65GIRbKNIBnDBNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y3tx4ZTP3LNxHEIhGC14XSD6ziIkpZoH1TMA/DzdG3Ve3Fct0CxeuCepGVBFASShY
         1w7tmhu6KIT2N/LrRAjK2vvkfkZJRPuRVOyV396iDNbCU7xbYKhTAPtfbCiXkIc1RA
         saPuKsSOCmmgRq+jeUwFAHK3jpTLr5HWlO3Ca/yU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DC26D607B9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vivek.gautam@codeaurora.org
From:   Vivek Gautam <vivek.gautam@codeaurora.org>
To:     kishon@ti.com, vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     subhashj@codeaurora.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linux-arm-msm@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 3/3] phy: qcom-ufs: Declare 20nm qcom ufs qmp phy as Broken
Date:   Tue,  4 Sep 2018 15:47:19 +0530
Message-Id: <20180904101719.18049-4-vivek.gautam@codeaurora.org>
X-Mailer: git-send-email 2.16.1.72.g5be1f00a9a70
In-Reply-To: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
References: <20180904101719.18049-1-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fork out separate configs for 14nm and 20nm qcom ufs qmp phys
to declare the 20nm phy as broken.

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/phy/qualcomm/Kconfig  | 17 +++++++++++++++++
 drivers/phy/qualcomm/Makefile |  4 ++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 632a0e73ee10..32f7d34eb784 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -50,6 +50,23 @@ config PHY_QCOM_UFS
 	help
 	  Support for UFS PHY on QCOM chipsets.
 
+if PHY_QCOM_UFS
+
+config PHY_QCOM_UFS_14NM
+	tristate
+	default PHY_QCOM_UFS
+	help
+	  Support for 14nm UFS QMP phy present on QCOM chipsets.
+
+config PHY_QCOM_UFS_20NM
+	tristate
+	default PHY_QCOM_UFS
+	depends on BROKEN
+	help
+	  Support for 20nm UFS QMP phy present on QCOM chipsets.
+
+endif
+
 config PHY_QCOM_USB_HS
 	tristate "Qualcomm USB HS PHY module"
 	depends on USB_ULPI_BUS
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index deb831f453ae..c56efd3af205 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)	+= phy-qcom-ipq806x-sata.o
 obj-$(CONFIG_PHY_QCOM_QMP)		+= phy-qcom-qmp.o
 obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs.o
-obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs-qmp-14nm.o
-obj-$(CONFIG_PHY_QCOM_UFS)		+= phy-qcom-ufs-qmp-20nm.o
+obj-$(CONFIG_PHY_QCOM_UFS_14NM)		+= phy-qcom-ufs-qmp-14nm.o
+obj-$(CONFIG_PHY_QCOM_UFS_20NM)		+= phy-qcom-ufs-qmp-20nm.o
 obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
 obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

