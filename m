Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A07C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1957F20894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1957F20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbeGZNn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:43:57 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12220 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbeGZNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:43:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b59be1a0002>; Thu, 26 Jul 2018 05:27:06 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 26 Jul 2018 05:27:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Jul 2018 05:27:17 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 12:27:16 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 26 Jul 2018 12:27:16 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b59be220002>; Thu, 26 Jul 2018 05:27:16 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 05/10] dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
Date:   Thu, 26 Jul 2018 15:26:51 +0300
Message-ID: <1532608016-14319-6-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings documentation for pad pull up and pull down offset values to be
programmed before executing automatic pad drive strength calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 95010cf..c3d8a15 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -24,6 +24,7 @@ Required properties:
 Optional properties:
 - power-gpios : Specify GPIOs for power control
 
+Optional properties for Tegra210 and Tegra186:
 Example:
 
 sdhci@c8000200 {
@@ -47,6 +48,35 @@ Optional properties for Tegra210 and Tegra186:
   pinctrl-1.
 - nvidia,only-1-8-v : The presence of this property indicates that the
   controller operates at a 1.8 V fixed I/O voltage.
+- nvidia,pad-autocal-pull-up-offset-3v3,
+  nvidia,pad-autocal-pull-down-offset-3v3 : Specify drive strength
+  calibration offsets for 3.3 V signaling modes.
+- nvidia,pad-autocal-pull-up-offset-1v8,
+  nvidia,pad-autocal-pull-down-offset-1v8 : Specify drive strength
+  calibration offsets for 1.8 V signaling modes.
+- nvidia,pad-autocal-pull-up-offset-3v3-timeout,
+  nvidia,pad-autocal-pull-down-offset-3v3-timeout : Specify drive
+  strength used as a fallback in case the automatic calibration times
+  out on a 3.3 V signaling mode.
+- nvidia,pad-autocal-pull-up-offset-1v8-timeout,
+  nvidia,pad-autocal-pull-down-offset-1v8-timeout : Specify drive
+  strength used as a fallback in case the automatic calibration times
+  out on a 1.8 V signaling mode.
+- nvidia,pad-autocal-pull-up-offset-sdr104,
+  nvidia,pad-autocal-pull-down-offset-sdr104 : Specify drive strength
+  calibration offsets for SDR104 mode.
+- nvidia,pad-autocal-pull-up-offset-hs400,
+  nvidia,pad-autocal-pull-down-offset-hs400 : Specify drive strength
+  calibration offsets for HS400 mode.
+
+  Notes on the pad calibration pull up and pulldown offset values:
+    - The property values are drive codes which are programmed into the
+      PD_OFFSET and PU_OFFSET sections of the
+      SDHCI_TEGRA_AUTO_CAL_CONFIG register.
+    - A higher value corresponds to higher drive strength. Please refer
+      to the reference manual of the SoC for correct values.
+    - The SDR104 and HS400 timing specific values are used in
+      corresponding modes if specified.
 
 Example:
 sdhci@700b0000 {
@@ -60,5 +90,9 @@ sdhci@700b0000 {
 	pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 	pinctrl-0 = <&sdmmc1_3v3>;
 	pinctrl-1 = <&sdmmc1_1v8>;
+	pad-autocal-pull-up-offset-3v3 = <0x00>;
+	pad-autocal-pull-down-offset-3v3 = <0x7d>;
+	pad-autocal-pull-up-offset-1v8 = <0x7b>;
+	pad-autocal-pull-down-offset-1v8 = <0x7b>;
 	status = "disabled";
 };
-- 
2.7.4

