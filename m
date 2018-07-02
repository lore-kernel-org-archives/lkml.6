Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25646C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19C324FB0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X8V0e3ud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19C324FB0
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeGBSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:12:53 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45876 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753348AbeGBSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:12:24 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w62ICJGZ008100;
        Mon, 2 Jul 2018 13:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530555139;
        bh=bKg+rYBVLwSZ1gI528KpwTNUAeRAwalAOFpCP1Lp9DE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=X8V0e3ud+af4ueYWiHO7EWevkcIQ3UOq5OIX39ctkp2MuAcDns0ePb4Fu0F7dtOlJ
         4MoJruh8h2l6jlQZtposi8mGPUK1AahPwTcP3ON4J8U1o7K+6wdouKlI5AGvhPRjl2
         LzM2oHovHOInKttTxbqnGKDXlXrSaHZNUhvqf1sE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62ICJ7X002979;
        Mon, 2 Jul 2018 13:12:19 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 2 Jul
 2018 13:12:19 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 2 Jul 2018 13:12:19 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w62ICJOa017669;
        Mon, 2 Jul 2018 13:12:19 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.180.30])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w62ICIx02919;
        Mon, 2 Jul 2018 13:12:18 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jacek.anaszewski@gmail.com>, <andy.shevchenko@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-leds@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 3/4] dt: bindings: lm3692x: Update binding for LED sync control
Date:   Mon, 2 Jul 2018 13:12:15 -0500
Message-ID: <20180702181216.19660-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180702181216.19660-1-dmurphy@ti.com>
References: <20180702181216.19660-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the binding to be able to configure the LED
sync to turn on.

The LM36922 has one output but can sync current to 2 LED
strings.  The user may only use one sync so the other
syncs need to be disabled.

The LM36923 has 3 LED syncs.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
index 6c9074f84a51..08b352840bd7 100644
--- a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
+++ b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
@@ -20,7 +20,10 @@ Optional properties:
 	- vled-supply : LED supply
 
 Required child properties:
-	- reg : 0
+	- reg : 0 - Will enable all LED sync paths
+		1 - Will enable the LED1 sync
+		2 - Will enable the LED2 sync
+		3 - Will enable the LED3 sync (LM36923 only)
 
 Optional child properties:
 	- label : see Documentation/devicetree/bindings/leds/common.txt
-- 
2.17.0.582.gccdcbd54c

