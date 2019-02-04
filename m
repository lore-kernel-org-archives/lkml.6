Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEDAC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8382082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 15:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NVAj96Su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731522AbfBDPzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 10:55:16 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:46378 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbfBDPzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 10:55:14 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14FsMGq119417;
        Mon, 4 Feb 2019 09:54:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549295662;
        bh=BiXMQuMZ9eiNysfRIHNum8sRRwJ1Hp4E3fwt8m4C9Ww=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NVAj96SuPPmLr+hnpwmLPHpqX9vHHSuFc7tkFW6m4JY53WK2RiuZJ2uc1RP4GlZUZ
         OTPWPz3dLUaaSQ5T0nN18HMNZEw/kXhxa5JeJpoMvOPUQ7YKUxs/6CYvo5+by93e2m
         oxpG9Nen5tgiBlXkC4A+7SyZgOeFTydt5oBIqPhE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14FsM8W112040
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 09:54:22 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 09:54:17 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 09:54:17 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14Fs1mP012077;
        Mon, 4 Feb 2019 09:54:14 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <s-anna@ti.com>, <nsekhar@ti.com>, <linux-omap@vger.kernel.org>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <david@lechnology.com>,
        <woods.technical@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH 4/4] ARM: dts: am57xx-idk-common: Enable PRU-ICSS nodes
Date:   Mon, 4 Feb 2019 17:53:57 +0200
Message-ID: <1549295637-24890-5-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549295637-24890-1-git-send-email-rogerq@ti.com>
References: <1549295637-24890-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The two PRU-ICSS processor subsystem bus nodes and their corresponding
subsystem nodes were left in disabled state in the base dra7.dts file.
The PRU-ICSSs are supported on only the AM57xx SoCs, so enable these
nodes (both PRU-ICSS1 and PRU-ICSS2 instances) to support them on
all the AM571x, AM572x and AM574x IDK boards. The PRU nodes are
already enabled in the base dts file, and so become effective
automatically with the enabling of these PRU-ICSS nodes.

The corresponding PRU nodes can be disabled later on if there are
no use-cases defined to use a particular PRU core or the whole
PRU-ICSS subsystem itself if both its PRU cores are unused.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index f7bd264..6991412 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -492,3 +492,11 @@
 &cpu0 {
 	vdd-supply = <&smps12_reg>;
 };
+
+&pruss1 {
+	status = "okay";
+};
+
+&pruss2 {
+	status = "okay";
+};
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

