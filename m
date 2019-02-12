Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B3C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045E62186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="M8iKQrp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfBLGoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:44:24 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18214 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfBLGoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:44:23 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c626b490000>; Mon, 11 Feb 2019 22:44:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 22:44:22 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 22:44:22 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 06:44:22 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 06:44:21 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c626b440002>; Mon, 11 Feb 2019 22:44:21 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
Subject: [PATCH v3 2/4] mfd: max77620: add documentation for backup battery charging
Date:   Tue, 12 Feb 2019 14:43:51 +0800
Message-ID: <20190212064353.7451-3-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190212064353.7451-1-markz@nvidia.com>
References: <20190212064353.7451-1-markz@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549953865; bh=ANirisXvocDuNFpdMKLePowAQRhdm/3JS5zOx9KrepU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=M8iKQrp44+Kcf3w3aGtSIbxaawC8haYUCJ5uDuk0sEbAs/CwuN3DHXpEW1RFKyfZz
         LORMct2+/7bB0x+SvUgbU+TEkr0pFxVuZdDU+69+KX4sdYYvBpNfJcC0dFEgvo476F
         56I4cQX1Kjn+XrYdKCHvlPhrXVItOvY9rUEoohtLwaVPlgt3lr1ES4lcY+vv0Y4qNj
         KaMjDjWoIv9Wdb2OvzvywdV3ojtgEZjagbazgcAEzusTEsZ20fDcu3+KIBwzo5rDma
         ovxsnDGT0CHsh1xHPBV0jgDhCnz7YCmpPZMrEeJ3GQfsCVAsLxZlTdkUkytiNCu6Pz
         9sNHMopQwL8Sw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding documentation for 3 new backup battery charging dts
properties:
- maxim,charging-current-microamp
- maxim,charging-voltage-microvolt
- maxim,output-resister-ohms

Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 .../devicetree/bindings/mfd/max77620.txt      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documenta=
tion/devicetree/bindings/mfd/max77620.txt
index 9c16d51cc15b..88825eaf2567 100644
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -122,6 +122,26 @@ For DT binding details of different sub modules like G=
PIO, pincontrol,
 regulator, power, please refer respective device-tree binding document
 under their respective sub-system directories.
=20
+Backup Battery:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This sub-node configure charging backup battery of the device. Device has
+support of charging the backup battery. The subnode name is "backup-batter=
y".
+The property for backup-battery child nodes as:
+Presence of this child node will enable the backup battery charging.
+
+Optional properties:
+	-maxim,charging-current-microamp: Charging current setting.
+			The device supports 50/100/200/400/600/800uA.
+			If this property is unavailable then it will
+			charge with 50uA.
+	-maxim,charging-voltage-microvolt: Charging Voltage Limit Setting.
+			Device supports 2500000/3000000/3300000/350000uV.
+			Default will be set to 2500mV. The voltage will be roundoff
+			to nearest lower side if other than above is configured.
+	-maxim,output-resister-ohms: Output resistor on Ohm.
+			Device supports 100/1000/3000/6000 Ohms.
+			Default will be set to 1000 Ohm.
+
 Example:
 --------
 #include <dt-bindings/mfd/max77620.h>
--=20
2.19.2

