Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960AEC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5857E22448
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5857E22448
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbeHJUj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:39:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19008 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbeHJUj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:39:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4ae0000>; Fri, 10 Aug 2018 11:08:46 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:09:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Aug 2018 11:09:01 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:09:00 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:09:00 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4b90002>; Fri, 10 Aug 2018 11:09:00 -0700
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
Subject: [PATCH v2 04/40] dt-bindings: mmc: Add Tegra SDHCI sampling trimmer values
Date:   Fri, 10 Aug 2018 21:08:06 +0300
Message-ID: <1533924522-1037-5-git-send-email-avienamo@nvidia.com>
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

Document the Tegra SDHCI inbound and outbound sampling trimmer values.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 .../devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt          | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 9713e05..edecf97 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -67,6 +67,10 @@ Optional properties for Tegra210 and Tegra186:
 - nvidia,pad-autocal-pull-up-offset-hs400,
   nvidia,pad-autocal-pull-down-offset-hs400 : Specify drive strength
   calibration offsets for HS400 mode.
+- nvidia,default-tap : Specify the default inbound sampling clock
+  trimmer value for non-tunable modes.
+- nvidia,default-trim : Specify the default outbound clock trimmer
+  value.
 
   Notes on the pad calibration pull up and pulldown offset values:
     - The property values are drive codes which are programmed into the
@@ -77,6 +81,13 @@ Optional properties for Tegra210 and Tegra186:
     - The SDR104 and HS400 timing specific values are used in
       corresponding modes if specified.
 
+  Notes on tap and trim values:
+    - The values are used for compensating trace length differences
+      by adjusting the sampling point.
+    - The values are programmed to the Vendor Clock Control Register.
+      Please refer to the reference manual of the SoC for correct
+      values.
+
 Example:
 sdhci@700b0000 {
 	compatible = "nvidia,tegra210-sdhci", "nvidia,tegra124-sdhci";
-- 
2.7.4

