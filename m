Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86925C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452052083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 05:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="tM6qRJHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452052083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=onstation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeJAMG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 08:06:28 -0400
Received: from onstation.org ([52.200.56.107]:35938 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbeJAMG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 08:06:27 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id B67DF971;
        Mon,  1 Oct 2018 05:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1538371828;
        bh=HKKpTXpta+eyqFVIIfeNq77LFoLU823CuRecnv9QvLE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tM6qRJHLEowD2yGv2+nRqmdZUUE0NFNMwy4wuTOzQYEKBWb3fLWzEuzueF+BzE8va
         2US7VgtePnXlclz0AyODjf1Lx0fXLT29Dy52dylNrGvrB8z9goVPO+9s0IxfY4sriT
         t1zf6csnC4I5uY2cx3wbXQK1eyeiRneGcBheO5yE=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, sre@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, david.brown@linaro.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, jonathan@marek.ca
Subject: [PATCH RFC 1/5] dt-bindings: power: supply: bq24190_charger: add bq24192 and usb-otg-vbus
Date:   Mon,  1 Oct 2018 01:30:01 -0400
Message-Id: <20181001053005.18906-2-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001053005.18906-1-masneyb@onstation.org>
References: <20181001053005.18906-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ti,bq24192 variant and a child node for the
usb-otg-vbus regulator.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 Documentation/devicetree/bindings/power/supply/bq24190.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.txt b/Documentation/devicetree/bindings/power/supply/bq24190.txt
index 9e517d307070..8f2560824a97 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.txt
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.txt
@@ -3,6 +3,7 @@ TI BQ24190 Li-Ion Battery Charger
 Required properties:
 - compatible: contains one of the following:
     * "ti,bq24190"
+    * "ti,bq24192"
     * "ti,bq24192i"
 - reg: integer, I2C address of the charger.
 - interrupts[-extended]: configuration for charger INT pin.
@@ -19,6 +20,12 @@ Optional properties:
 - ti,system-minimum-microvolt: when power is connected and the battery is below
   minimum system voltage, the system will be regulated above this setting.
 
+child nodes:
+- usb-otg-vbus:
+  Usage: optional
+  Description: Regulator that is used to control the VBUS voltage direction for
+               either USB host mode or for charging on the OTG port.
+
 Notes:
 - Some circuit boards wire the chip's "OTG" pin high (enabling 500mA default
   charge current on USB SDP ports, among other features). To simulate this on
-- 
2.17.1

