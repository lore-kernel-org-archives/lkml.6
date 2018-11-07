Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FA6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782BA20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 15:47:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782BA20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbeKHBS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:18:28 -0500
Received: from gloria.sntech.de ([185.11.138.130]:45538 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726858AbeKHBS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:18:28 -0500
Received: from wd0416.dip.tu-dresden.de ([141.76.109.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gKQ39-0006kt-QC; Wed, 07 Nov 2018 16:47:23 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@bq.com>
Subject: [PATCH] dt-bindings: hwmon: tmp108: add optional interrupts and #thermal-sensor-cells
Date:   Wed,  7 Nov 2018 16:47:08 +0100
Message-Id: <20181107154708.422-1-heiko@sntech.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@bq.com>

The tmp108 does have an alert output that can be used as interrupt source
and can of course also be used as part of a thermal sensor setup for things
like thermal-based cpu frequencies, so document the necessary properties.

Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
---
 Documentation/devicetree/bindings/hwmon/tmp108.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/tmp108.txt b/Documentation/devicetree/bindings/hwmon/tmp108.txt
index 8c4b10df86d9..54d4beed4ee5 100644
--- a/Documentation/devicetree/bindings/hwmon/tmp108.txt
+++ b/Documentation/devicetree/bindings/hwmon/tmp108.txt
@@ -7,6 +7,10 @@ Requires node properties:
 - compatible : "ti,tmp108"
 - reg : the I2C address of the device. This is 0x48, 0x49, 0x4a, or 0x4b.
 
+Optional properties:
+- interrupts: Reference to the TMP108 alert interrupt.
+- #thermal-sensor-cells: should be set to 0.
+
 Example:
 	tmp108@48 {
 		compatible = "ti,tmp108";
-- 
2.18.0

