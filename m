Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133F0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E212156D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="blC5D2qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E212156D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbeI1UhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:37:09 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8752 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbeI1UhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:37:08 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bae36fc0000>; Fri, 28 Sep 2018 07:13:16 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 28 Sep 2018 07:13:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 28 Sep 2018 07:13:09 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 28 Sep
 2018 14:13:09 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Fri, 28 Sep 2018 14:13:09 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bae36f30001>; Fri, 28 Sep 2018 07:13:08 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH V2 5/5] arm64: dts: tegra210: Add power-domains for xHCI
Date:   Fri, 28 Sep 2018 15:11:50 +0100
Message-ID: <1538143910-24400-6-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
References: <1538143910-24400-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538143996; bh=A5+LaSIS2MtAbQ6Lm1NQ7m3punvjkIxzOXDsA/lzCpo=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=blC5D2qIecIzjhcURMMLSynJ0KL8hvSNdUt07bWPbKndyoGJmvgG/u94XFxixA9LI
         YMOY7TyYc2DDLEGogJK72j2FCicYgz9T+dyghygehEJCUa0c2c9+uasZXsbEjxqjKL
         CmjiIonUoosACSJdhwsFzQp+js0SlBelmbcEcZidSOqAxUcNi9RB9y8G6ifA3NO8eG
         WlyuZyh6izg9xv/sUwrMFl40WYD2dl7zj6kJqkm3xXy3RgrSi4ugXu6ZK9CJnzteSF
         ecXQSA9PbrvDEMNp5dPHQHt5j8rCXCFLVLKPm8YklTLi6Df1iHM0hNZV8Q1p0o1ppO
         HPOlKx5Tpvzsg==
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

