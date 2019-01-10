Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A25FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B2121783
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fU4YdSsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfAJHbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:31:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57666 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfAJHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:31:16 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0A7V7nJ102211;
        Thu, 10 Jan 2019 01:31:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547105467;
        bh=0UM8BoEUFLapEG50gQhjK3ZcFicTENsT9w6/Mpg/YFc=;
        h=From:To:CC:Subject:Date;
        b=fU4YdSsKKl0gK/Vnv5JBCoOGL7t/w+Mn0U0gZIFMRqi6W33gmyRXTISHdimsHmZbf
         UnWzL6C6ptJ/GIq1gCwzWUKC4iG+TPTLryOSKuCWLmTcCX8ogY2/yI0iCPmhHsYqcD
         6AqDUzEZn74HXEhgIl6ciw7AqDuh53fzqRsN2kgY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0A7V7A7106510
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 01:31:07 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 10
 Jan 2019 01:31:06 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 10 Jan 2019 01:31:06 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0A7V38h020221;
        Thu, 10 Jan 2019 01:31:04 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 0/2] Support for eMMC in AM65x-evm
Date:   Thu, 10 Jan 2019 13:03:53 +0530
Message-ID: <20190110073355.3382-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add eMMC support on TI's AM65x-evm.

v2:
 1. The SD card node is under debug for some usecases.
    Only upstreaming eMMC support for now.
 2. Rebased to latest mainline.
 3. Removed status = "disabled" from dtsi patch
 4. Fixed node name to not include '_'s

Faiz Abbas (2):
  arm64: dts: ti: k3-am654: Add Support for MMC/SD
  arm64: dts: ti: k3-am654-base-board: Add MMC/SD support

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 13 ++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.19.2

