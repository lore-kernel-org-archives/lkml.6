Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1A1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D75D2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T2gvHZCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeLSW6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:58:16 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14263 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbeLSW6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:58:16 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1accfc0008>; Wed, 19 Dec 2018 14:58:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 19 Dec 2018 14:58:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 19 Dec 2018 14:58:14 -0800
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 22:58:13 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 22:58:13 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1acc7c0000>; Wed, 19 Dec 2018 14:55:58 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <pchandru@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 1/3] dt-bindings: mmc: tegra: Add pinctrl for pad drive strength config
Date:   Wed, 19 Dec 2018 14:55:51 -0800
Message-ID: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545260285; bh=aeW5srTuVMljeFxTYLeI1rl+Rzz9wq/UVcb0OHGTpeg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=T2gvHZCBcLQzJV32jpHfhFz/AZ2Vku/MjlBQ+XsdAx6QvPb/DKuuSSzw82DoNGxMK
         3yYYE5QTNzuccaas2lI2cQ5sgu5HaXrAwffsXAWg+YsrKPLuBusqTjkLjsxwwRTxpb
         DcWwRrcqdaT0THmm2fOGT53zDq6qQcgw9UB7dv17znBaKYW/rxV8BDNId0cJcJBjMu
         gAInb1qmL81mGPhbCovAYFq4LGEwxag4xpC4f+K4CZYygHDzYSPchLLLBRfrQ6IBdP
         09olVGFQtIc27IUHxhFxxsCzYliAh92JKp02A0anGuH8qLDXCwvvPgdbVMyRadY/li
         e0exxLF1NpRTQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl for 3V3 and 1V8 pad drive strength configuration for
Tegra210 sdmmc which has pad configuration registers in the pinmux
reigster domain.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 32b4b4e41923..2cecdc71d94c 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -39,12 +39,16 @@ sdhci@c8000200 {
 	bus-width = <8>;
 };
 
-Optional properties for Tegra210 and Tegra186:
+Optional properties for Tegra210, Tegra186 and Tegra194:
 - pinctrl-names, pinctrl-0, pinctrl-1 : Specify pad voltage
   configurations. Valid pinctrl-names are "sdmmc-3v3" and "sdmmc-1v8"
   for controllers supporting multiple voltage levels. The order of names
   should correspond to the pin configuration states in pinctrl-0 and
   pinctrl-1.
+- pinctrl-names : "sdmmc-3v3-drv" and "sdmmc-1v8-drv" are applicable for
+  Tegra210 where pad config registers are in the pinmux register domain
+  for pull-up-strength and pull-down-strength values configuration when
+  using pads at 3V3 and 1V8 levels.
 - nvidia,only-1-8-v : The presence of this property indicates that the
   controller operates at a 1.8 V fixed I/O voltage.
 - nvidia,pad-autocal-pull-up-offset-3v3,
-- 
2.7.4

