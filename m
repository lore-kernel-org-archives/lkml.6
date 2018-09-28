Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E86C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384902172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 06:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SLBuG4rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384902172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbeI1MZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 08:25:59 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39276 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbeI1MZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 08:25:58 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8S63pqH091038;
        Fri, 28 Sep 2018 01:03:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538114631;
        bh=mq/q1w/6ljawy5JLo9FShOWPiejB9wu/KfWaeJUJEp4=;
        h=From:To:CC:Subject:Date;
        b=SLBuG4rdWSK2lCtfTAx/d7ib6vleonJGdl6HiqGFKJOj3SFrjT4vRyGBRAzVr2pIY
         Fakf6ERnOFgSRGmS1c7O8F17qlAVyRnq5AFBF3DLSAPfem7OWpYsUS69wbFdypv8R4
         86SiVFynvzhrtm0Saugh68Q0SUYB90bQ52vZBcX4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S63pxa018407;
        Fri, 28 Sep 2018 01:03:51 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 01:03:51 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 01:03:51 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S63mC2005522;
        Fri, 28 Sep 2018 01:03:49 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Rob Herring <robh+dt@kernel.org>, <linux-omap@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
Subject: [PATCH v4] ARM: dts: dra7: Enable workaround for errata i870 in PCIe host mode
Date:   Fri, 28 Sep 2018 11:34:42 +0530
Message-ID: <20180928060442.24312-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ti,syscon-unaligned-access property to PCIe RC nodes to set
appropriate bits in CTRL_CORE_SMA_SW_7 register to enable workaround for
errata i870.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
This patch is split from v3 here:
https://lore.kernel.org/patchwork/cover/967020/
Dependent DT binding documentation and driver changes are now merged via
PCI tree and part of next-20180928

 arch/arm/boot/dts/dra7.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9136b3cf9a2c..7ce24b282d42 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -336,6 +336,7 @@
 						<0 0 0 2 &pcie1_intc 2>,
 						<0 0 0 3 &pcie1_intc 3>,
 						<0 0 0 4 &pcie1_intc 4>;
+				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
 				status = "disabled";
 				pcie1_intc: interrupt-controller {
 					interrupt-controller;
@@ -387,6 +388,7 @@
 						<0 0 0 2 &pcie2_intc 2>,
 						<0 0 0 3 &pcie2_intc 3>,
 						<0 0 0 4 &pcie2_intc 4>;
+				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
 				pcie2_intc: interrupt-controller {
 					interrupt-controller;
 					#address-cells = <0>;
-- 
2.19.0

