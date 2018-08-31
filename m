Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4105DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECE72083C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 19:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="cgiNru1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECE72083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeHaXnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 19:43:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37156 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbeHaXnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 19:43:12 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VJY6Ur111343;
        Fri, 31 Aug 2018 14:34:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535744046;
        bh=F3uvtJGQrmVejDzHDqMiHJcgDdtspCPrbh6jQkDgU8I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cgiNru1qadNaYmXoS1LmXjTzBbPsZ8oUpX1QBdC5pRY4IHjlR7ocqkaeQnCUKNPrO
         qOprmYjkw24mj4Dh0lMWyTlV3A7LRBXsj3Kpnc8wLDxOrKqDCmSt3EfI4sB5vE9TbY
         2Pwj9dZM6Mgcya7TwEcSt+ocSkzr5zp1QVUeFwSM=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJY6sB026823;
        Fri, 31 Aug 2018 14:34:06 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 14:34:05 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 14:34:06 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VJY6gR027316;
        Fri, 31 Aug 2018 14:34:06 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VJY5x15929;
        Fri, 31 Aug 2018 14:34:05 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH 3/3] ARM: dts: am571x-idk: Add Industrial input load trigger
Date:   Fri, 31 Aug 2018 14:34:03 -0500
Message-ID: <20180831193403.26777-3-afd@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831193403.26777-1-afd@ti.com>
References: <20180831193403.26777-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SN65HVS882 load trigger is attached to GPIO2_23 on the AM571x IDK.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am571x-idk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index a206f3e344d7..afe188c5ec91 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -147,6 +147,10 @@
 	vbus-gpio = <&gpio7 22 GPIO_ACTIVE_HIGH>;
 };
 
+&sn65hvs882 {
+	load-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+};
+
 &mailbox5 {
 	status = "okay";
 	mbox_ipu1_ipc3x: mbox_ipu1_ipc3x {
-- 
2.18.0

