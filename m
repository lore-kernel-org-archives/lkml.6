Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DA4C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493A622448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493A622448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbeHJUjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:39:55 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11308 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbeHJUjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:39:54 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4ab0000>; Fri, 10 Aug 2018 11:08:44 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:08:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Aug 2018 11:08:59 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:08:57 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:08:57 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4b60001>; Fri, 10 Aug 2018 11:08:57 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 03/40] dt-bindings: Add Tegra SDHCI pad pdpu offset bindings
Date:   Fri, 10 Aug 2018 21:08:05 +0300
Message-ID: <1533924522-1037-4-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
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
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 90c214d..9713e05 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -45,6 +45,37 @@ Optional properties for Tegra210 and Tegra186:
   for controllers supporting multiple voltage levels. The order of names
   should correspond to the pin configuration states in pinctrl-0 and
   pinctrl-1.
+- nvidia,only-1-8-v : The presence of this property indicates that the
+  controller operates at a 1.8 V fixed I/O voltage.
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
@@ -58,5 +89,9 @@ sdhci@700b0000 {
 	pinctrl-names = "sdmmc-3v3", "sdmmc-1v8";
 	pinctrl-0 = <&sdmmc1_3v3>;
 	pinctrl-1 = <&sdmmc1_1v8>;
+	nvidia,pad-autocal-pull-up-offset-3v3 = <0x00>;
+	nvidia,pad-autocal-pull-down-offset-3v3 = <0x7d>;
+	nvidia,pad-autocal-pull-up-offset-1v8 = <0x7b>;
+	nvidia,pad-autocal-pull-down-offset-1v8 = <0x7b>;
 	status = "disabled";
 };
-- 
2.7.4

