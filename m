Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45429C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CD020837
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EoisiKcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07CD020837
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbeLIKVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 05:21:45 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56344 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeLIKVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 05:21:44 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB9ALTJ8072718;
        Sun, 9 Dec 2018 04:21:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544350889;
        bh=mgRwYiBEY3pRNWQwPydIfmoAjp10LRT9DjzAcV9iVKM=;
        h=From:To:CC:Subject:Date;
        b=EoisiKcXFnDRd4u9eRDE8s3gWdwKr0gil7cfJH100Na8lanSbVo81zzozt0wI6FEH
         vGTr8F2cvcmdBNH2q+xav+qSMBFRM5DyU7VuG83v5ppU1dk56NHv8gKsUQ77J/ij4E
         QQc4WEnoV+iix/uACD3CZAFukk7aDV5LbIIJ+wdk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB9ALTGx078737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Dec 2018 04:21:29 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sun, 9
 Dec 2018 04:21:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sun, 9 Dec 2018 04:21:29 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB9ALQ8K007865;
        Sun, 9 Dec 2018 04:21:27 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] AM654: Add McSPI DT entry
Date:   Sun, 9 Dec 2018 15:52:20 +0530
Message-ID: <20181209102222.7624-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Couple of patches to add support for McSPIs in AM654 SoC.

Vignesh R (2):
  arm64: dts: ti: k3-am654: Add McSPI DT nodes
  arm64: dts: ti: k3-am654: Enable main domain McSPI0

 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 52 +++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 30 +++++++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 27 ++++++++++
 3 files changed, 109 insertions(+)

-- 
2.19.2

