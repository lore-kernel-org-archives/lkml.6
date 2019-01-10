Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0638AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0397214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 22:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="daz1XW/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfAJWqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 17:46:07 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18594 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfAJWqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 17:46:06 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c37cb140000>; Thu, 10 Jan 2019 14:45:40 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 14:46:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 10 Jan 2019 14:46:05 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 22:46:05 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 10 Jan
 2019 22:46:04 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 10 Jan 2019 22:46:05 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c37cb2c0005>; Thu, 10 Jan 2019 14:46:04 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 1/3] dt-bindings: mmc: tegra: Add pinctrl for SDMMC drive strengths
Date:   Thu, 10 Jan 2019 14:46:01 -0800
Message-ID: <1547160363-25323-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547160340; bh=bcwV4dxjZ88cRI7fIL79yp172szgzNqAoTuw9XEiVEc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=daz1XW/UKJdG5uxFVnLxnBdp8kw5Vh0vdeQi2eL7TCSH+QeCKYvM+5gdGRRc42u/p
         wam4jgmePvn96b/Orq62dNtFWyguTPvf9CAn8haYzQzf8cSAso2mObFMyQTzfW4nH5
         Bb+pUzWvda/AlpVbTPL0MrXFj9zCwgMwKAb0rDfjMZOPKSM3r4LwinA9foFY3Ox8ZH
         O1ZJnyYdcSyywdZseqgXx8SB12WKoZ3i+MxTZ2QK+y+IFRCXTsiXr6WvlDldgvI5iF
         1yJoMDnm75OUBRyjclIFR86u10zbJohuP2lsmYaAsrpwdHFH1YUadxE17Abp0XRDKv
         n+BKt6pbw2pnQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrls for 3V3 and 1V8 pad drive strength configuration for
Tegra210 sdmmc.

Tegra210 sdmmc has pad configuration registers in pinmux register
domain and handled thru pinctrl to pinmux device node.

Tegra186 and Tegra194 has pad configuration register with in the
SDMMC register domain itself and are handles thru drive strength
properties in sdmmc device node.

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

