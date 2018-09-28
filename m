Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD083206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="p1BYL9tp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD083206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbeI1WSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:18:42 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:32247 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbeI1WSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:18:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1538150055;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=Ig+N/AFXJJvd/hv9LJIYRhtQw8wbxvY27l5+lkAd1ws=;
        b=p1BYL9tpOoTq+43dnoRjzVRgxvz7dON1fOlRV5FgdG7KW8N9k50IflcgHshb5SRlXx
        Nf2KSjeF5QkeJSu+vmykOqp7Kexp5bfYrl9edYyCL6ikX1vSXw0/m0vZ4OMkPpTWywep
        tRl4XgX3RB9boSY/ehcn0S0k9myvI97C3JvaNkI3ywZPB/JXrQDJzCi/JKKrvIvoZrBk
        3c8CXuucsf2xhn4uRNXEB3pJHpLAcr4c1+hNKbZJvayQ8/f+A/TnVj7ITH5XMa09J/Pu
        vZstYvxzAKUJefamGWmT6e0jN8IkVuH4B8rEe5N4qcrAJuVE5Q9k1+Qzy1uKIf8B0xNy
        74rQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1pxICp41QvXLY9sHKU="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 44.2 DYNA|AUTH)
        with ESMTPSA id N05e1au8SFs06c1
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 28 Sep 2018 17:54:00 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pyra-handheld.com,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] ARM: DTS: OMAP5: enable OTG role for DWC3 controller
Date:   Fri, 28 Sep 2018 17:54:00 +0200
Message-Id: <0c739437f2331913e6593d651fd782fde3181e0a.1538150039.git.hns@goldelico.com>
X-Mailer: git-send-email 2.12.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since SMPS10 and OTG cable detection extcon are described here, and
work to enable OTG power when an OTG cable is plugged in, we can
define OTG mode in the controller (which is disabled by default in
omap5.dtsi).

Tested on OMAP5EVM and Pyra.

Suggested-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index da5d9a86a1f1..ce524f239e84 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -708,6 +708,10 @@
 	vbus-supply = <&smps10_out1_reg>;
 };
 
+&dwc3 {
+	dr_mode = "otg";
+};
+
 &mcspi1 {
 
 };
-- 
2.12.2

