Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F13ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F211D20850
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 21:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F211D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387956AbeGVWTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 18:19:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:38772 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730715AbeGVWSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 18:18:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3347FAFCA;
        Sun, 22 Jul 2018 21:20:20 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        James Hartley <james.hartley@sondrel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH 05/15] MIPS: dts: img: pistachio_marduk: Enable SPIM0
Date:   Sun, 22 Jul 2018 23:20:00 +0200
Message-Id: <20180722212010.3979-6-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180722212010.3979-1-afaerber@suse.de>
References: <20180722212010.3979-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPIM0 supplies SPI pins on the mikroBUS and Raspberry Pi B+ connectors.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 arch/mips/boot/dts/img/pistachio_marduk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
index 5557a6ad61c3..d723b68084c9 100644
--- a/arch/mips/boot/dts/img/pistachio_marduk.dts
+++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
@@ -123,6 +123,14 @@
 	pins = "mfio17", "mfio18", "mfio19", "mfio20";
 };
 
+&pin_spim0 {
+	drive-strength = <2>;
+};
+
+&pin_spim0_clk {
+	drive-strength = <2>;
+};
+
 &pwm {
 	status = "okay";
 
@@ -137,6 +145,21 @@
 	disable-wp;
 };
 
+&spfi0 {
+	status = "okay";
+
+	pinctrl-0 = <&spim0_pins>,
+		    <&spim0_cs0_alt_pin>,
+		    <&spim0_cs2_alt_pin>,
+		    <&spim0_cs3_alt_pin>,
+		    <&spim0_cs4_alt_pin>;
+	pinctrl-names = "default";
+	cs-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>, <0>,
+		   <&gpio1 12 GPIO_ACTIVE_HIGH>,
+		   <&gpio1 13 GPIO_ACTIVE_HIGH>,
+		   <&gpio1 14 GPIO_ACTIVE_HIGH>;
+};
+
 &spfi1 {
 	status = "okay";
 
-- 
2.16.4

