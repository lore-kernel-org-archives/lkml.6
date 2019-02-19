Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16371C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D97B9217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 06:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dk5eMTMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfBSGfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 01:35:53 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54894 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfBSGfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 01:35:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1J6ZUNC106176;
        Tue, 19 Feb 2019 00:35:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550558130;
        bh=2ozQ4ppo4JwbQ8D73QWhmpA+tbu5S+S976GnIshYGoA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dk5eMTMubazpzNNflUEpqrGvafLuiEn7sDVTQEfZt17V5ZSJdKRC/HzGhADX6RIdt
         kLprYN4NA6f0s/eax594PWBh1FlSoPqLf4f+YP9Gb5c+PJ/uHy8bRI44Ss8eh4D6kx
         pyn3xysjLHaIeIce2J3HX8xa93XlsScvMERc0TRQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1J6ZUgo123386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 00:35:30 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 00:35:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 00:35:29 -0600
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1J6ZCt0025516;
        Tue, 19 Feb 2019 00:35:24 -0600
From:   Vignesh R <vigneshr@ti.com>
To:     Vignesh R <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <tudor.ambarus@microchip.com>, <nsekhar@ti.com>
Subject: [RFC PATCH 2/5] dt-bindings: mtd: Add binding documentation for Hyperbus memory devices
Date:   Tue, 19 Feb 2019 12:06:04 +0530
Message-ID: <20190219063607.29949-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190219063607.29949-1-vigneshr@ti.com>
References: <20190219063607.29949-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding documentation for Hyperbus memory devices. For now only
Hyperflash is supported.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt | 6 ++++++
 1 file changed, 6 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt

diff --git a/Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt b/Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
new file mode 100644
index 000000000000..cb408f80b868
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
@@ -0,0 +1,6 @@
+Bindings for Hyperflash NOR flash chips compliant with Cypress Hyperbus
+specification and supports Cypress CFI specification 1.5 command set.
+
+Required properties:
+- compatible : "cypress,hyperflash" for Hyperflash NOR chips
+- reg : Address where flash's memory mapped space
-- 
2.20.1

