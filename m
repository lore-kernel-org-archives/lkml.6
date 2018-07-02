Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6C7C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C2525CF9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:42:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C2525CF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030705AbeGBLm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:42:29 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12892 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030657AbeGBLl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:41:58 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b3a0f630000>; Mon, 02 Jul 2018 04:41:23 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 02 Jul 2018 04:41:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 02 Jul 2018 04:41:58 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 11:41:57 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 2 Jul
 2018 11:41:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Mon, 2 Jul 2018 11:41:57 +0000
Received: from mperttunen-lnx.Nvidia.com (Not Verified[10.21.26.144]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b3a0f820000>; Mon, 02 Jul 2018 04:41:56 -0700
From:   Mikko Perttunen <mperttunen@nvidia.com>
To:     <jassisinghbrar@gmail.com>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v3 8/8] arm64: tegra: Mark tcu as primary serial port on Tegra194 P2888
Date:   Mon, 2 Jul 2018 14:40:33 +0300
Message-ID: <20180702114033.15654-9-mperttunen@nvidia.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180702114033.15654-1-mperttunen@nvidia.com>
References: <20180702114033.15654-1-mperttunen@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra Combined UART is the proper primary serial port on P2888,
so use it.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---

Notes:
    v2:
    - Added Jon's Acked-by.

 arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
index 859ab5af17c1..95e2433984f7 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194-p2888.dtsi
@@ -10,7 +10,7 @@
 	aliases {
 		sdhci0 = "/cbb/sdhci@3460000";
 		sdhci1 = "/cbb/sdhci@3400000";
-		serial0 = &uartb;
+		serial0 = &tcu;
 		i2c0 = "/bpmp/i2c";
 		i2c1 = "/cbb/i2c@3160000";
 		i2c2 = "/cbb/i2c@c240000";
-- 
2.16.1

