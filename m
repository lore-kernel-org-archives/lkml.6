Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB95C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5466D20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 05:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kXmEq6Z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5466D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbeGYHF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 03:05:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55912 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbeGYHF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 03:05:57 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6P5tpHs009244;
        Wed, 25 Jul 2018 00:55:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532498151;
        bh=tB5mD508qNUlVMYvuwrZsal5WtCorhCPt7IqF4L3YvU=;
        h=From:To:CC:Subject:Date;
        b=kXmEq6Z5Y5OTb4KA0mu7r+3/WykMjk3Xh4863dz/EmW11CWx0F0kv2U0OGqpIRUgc
         xqAqTpMNXXvbHg3qlp0liUFa0JfeEXDoGMjgMAP9UU+Dfu4S069T7z/QQa6F8K8k1k
         q4Hkk9GvOKnQSiZt+zLOHeYzynm3O9Yw+uJ7uQh8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6P5tphb004065;
        Wed, 25 Jul 2018 00:55:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 25
 Jul 2018 00:55:50 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 25 Jul 2018 00:55:50 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6P5tmmX027691;
        Wed, 25 Jul 2018 00:55:49 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <tony@atomide.com>
CC:     <t-kristo@ti.com>, <j-keerthy@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] arm: dts: am4372: setup rtc as system-power-controller
Date:   Wed, 25 Jul 2018 11:25:35 +0530
Message-ID: <1532498135-9031-1-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RTC alarm2 is connected to pmic_en line and hence can be used to control
the pmic enabling/disabling. Hence add the system-power-controller for rtc
node.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index f0cbd86..d4b7c59 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -469,6 +469,7 @@
 			ti,hwmods = "rtc";
 			clocks = <&clk_32768_ck>;
 			clock-names = "int-clk";
+			system-power-controller;
 			status = "disabled";
 		};
 
-- 
1.9.1

