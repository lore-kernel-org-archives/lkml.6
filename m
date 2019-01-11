Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE44FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AAB9214C6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 03:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bT4LfCgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbfAKDJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 22:09:21 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2672 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbfAKDJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 22:09:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c3808d30000>; Thu, 10 Jan 2019 19:09:07 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 10 Jan 2019 19:09:20 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 10 Jan 2019 19:09:20 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 11 Jan
 2019 03:09:19 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 11 Jan 2019 03:09:19 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c3808df0001>; Thu, 10 Jan 2019 19:09:19 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <chunyan.zhang@unisoc.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>
CC:     <anrao@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V8 1/3] dt-bindings: mmc: tegra: Add supports-cqe property
Date:   Thu, 10 Jan 2019 19:08:53 -0800
Message-ID: <1547176135-2470-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1547176147; bh=7LmrZ9OsZ3o9SobpreCnQv4ByFBfGKe0Dav4/9uMQ1U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=bT4LfCgpu8u2Wi4CrRUfTPqgHqnYUK3nenrT5bGaNr319m1W+gdCjt35MipzvPAK5
         8aKpLIFxBc56KJ1gUMQrSDaM4W9SIcmAhicoco2vLe52pb0QGLON0GErVCgq6ApMZy
         r9yruVNmR86+4ONYL/yf6bFjsTKZ8ZF1Ywwr7URr5hlGaNis8vXdnuSpCS4hRgWBMs
         0Wv08CXiMQMHFVvQoZFRYdBuBz8ctGeYrHvYK/dTPg5bZ6w0zkZxAWJxnXrZYUDyFg
         zu9uoYtGKuQDzLoNyOq42sGGC9WlFvc51bih4Px7bkgLgRCTj5bRFp2AZ6sljeSYSp
         kio75y+Yu08jg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add supports-cqe optional property for Tegra SDMMC.

Tegra186 and Tegra194 supports HW Command queue only
on SDMMC4 controller. This property is used to identify
command queue support controller in the tegra sdhci driver.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
index 32b4b4e41923..fb14c2c8d7ee 100644
--- a/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/nvidia,tegra20-sdhci.txt
@@ -72,6 +72,10 @@ Optional properties for Tegra210 and Tegra186:
 - nvidia,default-trim : Specify the default outbound clock trimmer
   value.
 - nvidia,dqs-trim : Specify DQS trim value for HS400 timing
+- supports-cqe : The presence of this property indicates that the
+  corresponding controller supports HW command queue feature.
+  Tegra186 and Tegra194 has 4 SDMMC Controllers and only SDMMC4
+  controller supports HW Command Queue with eMMC device.
 
   Notes on the pad calibration pull up and pulldown offset values:
     - The property values are drive codes which are programmed into the
-- 
2.7.4

