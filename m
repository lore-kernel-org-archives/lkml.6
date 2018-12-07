Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C442CC64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8571220838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qfTw/JdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8571220838
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbeLGIkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:40:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33874 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeLGIkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:40:09 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB78dnfu047619;
        Fri, 7 Dec 2018 02:39:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544171989;
        bh=c9fMy8QP0Or/Za94hml9OQl3nwTeIuSCpaFRMxjZbFM=;
        h=From:To:CC:Subject:Date;
        b=qfTw/JdCmsUuTRh1BpSlAqg7j+NGj7cU9/3R9YFpKTUTCPLqOBWkkq7PQKQ1Z/Q5T
         1nmPg6UAuyKa3IZt05Jrb6UHDOyn4/IWO6870rsEbISoVX+EOaggRANWmIYZ0xyXm0
         tVThylrqCWTdt5IAhJ/k0DsDnGfWGvvSGvAmz63g=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB78dnu8122421
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Dec 2018 02:39:49 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 02:39:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 02:39:49 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB78djGu012224;
        Fri, 7 Dec 2018 02:39:46 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>, <kishon@ti.com>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <michal.simek@xilinx.com>,
        <faiz_abbas@ti.com>
Subject: [PATCH 0/2] Add DT Support for MMCSD in Am65x-evm
Date:   Fri, 7 Dec 2018 14:12:31 +0530
Message-ID: <20181207084233.13700-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add dt support for MMCSD on the AM65x-evm.

THe series depends on driver support[1] and pinmux support[2] posted
separately.

[1] https://patchwork.kernel.org/project/linux-mmc/list/?series=53185
[2] https://lore.kernel.org/patchwork/project/lkml/list/?series=372649

Faiz Abbas (2):
  arm64: dts: ti: k3-am654: Add Support for MMC/SD
  arm64: dts: ti: k3-am654-base-board: Add MMC\SD support

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 28 +++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 46 +++++++++++++++++++
 2 files changed, 74 insertions(+)

-- 
2.19.2

