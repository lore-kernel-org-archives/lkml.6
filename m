Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6435C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C0FB21546
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="G1YDbEzX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0FB21546
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbeI1UhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:37:02 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4263 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1UhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:37:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bae36ef0000>; Fri, 28 Sep 2018 07:13:04 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 28 Sep 2018 07:13:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 28 Sep 2018 07:13:02 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 14:13:01 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 14:13:00 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Sep 2018 14:13:00 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bae36eb0000>; Fri, 28 Sep 2018 07:13:00 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Jon Hunter" <jonathanh@nvidia.com>
Subject: [PATCH V2 1/5] dt-bindings: usb: xhci-tegra: Add power-domain details
Date:   Fri, 28 Sep 2018 15:11:46 +0100
Message-ID: <1538143910-24400-2-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538143984; bh=QiCY1OBjJA8jzGGo2BTTCq8k6o92/xxPDihoF/PByhg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=G1YDbEzX7T3HQDCJmkHoiGwImMwJf6aCpiuJuScnf4BijCpAv1WpsYvH1YpOBuVwg
         XlivPCTFnMLKMsI+qp0eUi0lZ3BUlT1t1LSPdSZBbcB0aVRRC0x8X5bpSJlnobYvlU
         XWXULX8FpmD6ID3CXj06dpgR6uBIFxL1+lqpDNnfhjEgziCwo/vTo8W9Ji0sA5l0Tv
         q3uWBw6e+u2UZe+3G7IL7nWcYg86ssj+J+vAtAASw3FEw4Cpjy+1WBLlZfKmZ7UWYS
         IxsJCf3+m5eBBsJxNhp+aFqkTlCAGSsyRGMuVXGQs61ekcYtLf4jushu5T5k7aORl2
         j1KKM297J6ipw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add details for power-domains to the Tegra xHCI bindings so that
generic power-domains can be used for inconjunction with the xHCI
driver.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
index 3eee9e505400..4156c3e181c5 100644
--- a/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
+++ b/Documentation/devicetree/bindings/usb/nvidia,tegra124-xusb.txt
@@ -59,6 +59,14 @@ For Tegra210:
 - avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
 - dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
 - hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8 V.
+- power-domains: A list of PM domain specifiers that reference each power-domain
+  used by the xHCI controller. This list must comprise of a specifier for the
+  XUSBA and XUSBC power-domains. See ../power/power_domain.txt and
+  ../arm/tegra/nvidia,tegra20-pmc.txt for details.
+- power-domain-names: A list of names that represent each of the specifiers in
+  the 'power-domains' property. Must include 'xusb_ss' and 'xusb_host' which
+  represent the power-domains XUSBA and XUSBC, respectively. See
+  ../power/power_domain.txt for details.
 
 Optional properties:
 --------------------
-- 
2.7.4

