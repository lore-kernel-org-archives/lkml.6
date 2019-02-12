Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB901C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A925D2184A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WGncKsot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfBLIhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:37:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51402 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbfBLIhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:37:22 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1C8bIeh035462;
        Tue, 12 Feb 2019 02:37:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549960638;
        bh=kHtkNpgeizkVUbFjNo4CQPMBiMf11gexNBuHrfIznPA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WGncKsotTxNh/VXyuCcSgFj3B1BDmqiTP+zFIUJmTItqtWahTPrUv83YO2qdhjEWY
         9kXU1WzRKc3tLrZrmySVHy7Mc+HeG7I88KBEEdwjY1YfZQP4+MQ+JvtR5dsN5R3fWg
         UrY3HaybLgyf9ml3DV19uq9M9vCx5NhVXitY+XvQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1C8bHoH084015
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Feb 2019 02:37:18 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Feb 2019 02:37:17 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Feb 2019 02:37:17 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1C8bBsS027304;
        Tue, 12 Feb 2019 02:37:15 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        <Tudor.Ambarus@microchip.com>
CC:     Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH v6 1/2] dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
Date:   Tue, 12 Feb 2019 14:08:08 +0530
Message-ID: <20190212083809.6534-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212083809.6534-1-vigneshr@ti.com>
References: <20190212083809.6534-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM654 SoC has Cadence Octal SPI controller, which is similar to Cadence
QSPI controller but supports Octal IO(x8 data lines) and Double Data
Rate(DDR) mode. Add new compatible to support OSPI controller on TI's
AM654 SoCs.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v6: No change

 Documentation/devicetree/bindings/mtd/cadence-quadspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
index bb2075df9b38..4345c3a6f530 100644
--- a/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/mtd/cadence-quadspi.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible : should be one of the following:
 	Generic default - "cdns,qspi-nor".
 	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
+	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
 - reg : Contains two entries, each of which is a tuple consisting of a
 	physical address and length. The first entry is the address and
 	length of the controller register set. The second entry is the
-- 
2.20.1

