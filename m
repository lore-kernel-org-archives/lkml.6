Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF8FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4635220684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B1iMeDVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4635220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeIZSkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:40:42 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8729 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeIZSkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:40:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bab7b520000>; Wed, 26 Sep 2018 05:28:02 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Sep 2018 05:27:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Sep 2018 05:27:56 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 12:27:55 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Sep 2018 12:27:55 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.143]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bab7b490001>; Wed, 26 Sep 2018 05:27:55 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 5/5] arm64: dts: tegra210: Add power-domains for xHCI
Date:   Wed, 26 Sep 2018 13:27:38 +0100
Message-ID: <1537964858-30332-6-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537964858-30332-1-git-send-email-jonathanh@nvidia.com>
References: <1537964858-30332-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537964882; bh=A5+LaSIS2MtAbQ6Lm1NQ7m3punvjkIxzOXDsA/lzCpo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=B1iMeDVVdOnmP13Sf3GIS2mFOtDfLOYBUD3rr+TwU/zyL3JGXYSOMvzCupVApcW05
         ucoF9ZmD2NRan+4B3uV1DiwGJ5Ptv50+82di9vZXnq/O8zfARM/RwvXX1OklWVVp26
         VfDt5sdEqfpvMRa3Vi1U6puPLfiU2yc699EjI7/NwVNMG2FR4awqneT0k/qtv4RT3W
         nCoVv48ojxrFSN/oNfA2BF6zHUWAdR6/I1eP8c2Q1YhyjGxuYnStZQhe8Ktmz7dA4D
         jOOfsdRAimxPSFvC3XocoD/zZHQ6Lh/4c598KH2iCXXCHDfRnv9QBdSr/75MMqat4M
         yxi/AQn8CLwcw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Populate the power-domain properties for the xHCI device for Tegra210.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 8fe47d6445a5..2205d66b0443 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -879,6 +879,8 @@
 		resets = <&tegra_car 89>, <&tegra_car 156>,
 			 <&tegra_car 143>;
 		reset-names = "xusb_host", "xusb_ss", "xusb_src";
+		power-domains = <&pd_xusbhost>, <&pd_xusbss>;
+		power-domain-names = "xusb_host", "xusb_ss";
 
 		nvidia,xusb-padctl = <&padctl>;
 
-- 
2.7.4

