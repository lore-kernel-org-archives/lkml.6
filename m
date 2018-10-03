Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC53C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816C72089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sXVF8uBE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816C72089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbeJCXr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:47:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57720 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCXr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:47:57 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w93Guju8083698;
        Wed, 3 Oct 2018 11:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538585805;
        bh=0MwPTThinpBUqcQ8r36Aa03S7/kqXXztHkFtd9mM+Ac=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=sXVF8uBEgAPoKaVb4kUisGqp/C9V0vBqNeD5Za0jd9cki1iFjrX2BHVFxcyF6X5Fm
         bn01J7uWAKVV31pvMWXa8PJ8hzZl8dfO3t3yT18IAIhnaLXW8UeMNzlpziVOJUqFns
         Pwe80KAi+/hlY7EOBJJg9v4ghYFAySS1ooAchxzw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93Gujlr010393;
        Wed, 3 Oct 2018 11:56:45 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 3 Oct
 2018 11:56:45 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 3 Oct 2018 11:56:45 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w93GuZMJ030968;
        Wed, 3 Oct 2018 11:56:42 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Brian Norris <computersforpeace@gmail.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/3] dt-bindings: cadence-quadspi: Add new compatible for AM654 SoC
Date:   Wed, 3 Oct 2018 22:26:02 +0530
Message-ID: <20181003165603.2579-3-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003165603.2579-1-vigneshr@ti.com>
References: <20181003165603.2579-1-vigneshr@ti.com>
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
---
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
2.19.0

