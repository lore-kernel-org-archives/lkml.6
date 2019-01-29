Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13EFC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81535214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q7dc592W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfA2I4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:56:15 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2035 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbfA2I4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:56:12 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c50152d0000>; Tue, 29 Jan 2019 00:56:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 00:56:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 00:56:12 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 08:56:11 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 08:56:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 08:56:11 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c5015290001>; Tue, 29 Jan 2019 00:56:11 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <blaws05@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
Subject: [PATCH v2 2/4] mfd: max77620: add documentation for backup battery charging
Date:   Tue, 29 Jan 2019 16:55:29 +0800
Message-ID: <20190129085531.32364-3-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190129085531.32364-1-markz@nvidia.com>
References: <20190129085531.32364-1-markz@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548752173; bh=B2Xjyu1hXNJ6DFzr0YfoY4Ut0RKFKDHRJ5eLSK1VsuM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Q7dc592WyV5z9BMubEU1mp/rNOBmjAVFBUP/hqlfqRJjyFLpXS/SwAD72fHOPOuh9
         DVhHlqafvlry/aYzmHdM5q2g2pGXeQm5znOqgLUWSKrWV6KnQ5VDAJvS65OKwZ43T2
         HkbVUTbo9+5A2eTvwjFG6V8Bbrc6KGySvZBuhXezoVkOLP37hrScqFbpWYGOetVPt/
         jCk4Cndv2WUU6E4iGSiRI8fiR4OFDap1ePT0Zbn6zePRszIh5teYR4R8GHTtQVZpOt
         XAwF4K0TDMDuaOVauu66UmvCGfUYsuPOpyapjanYzZWas/ZmXvI++PTpANDexgHEjN
         C6ktIgcbuLJiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding documentation for 3 new backup battery charging dts
properties:
- maxim,backup-battery-charging-current
- maxim,backup-battery-charging-voltage
- maxim,backup-battery-output-resister

Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 .../devicetree/bindings/mfd/max77620.txt      | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documenta=
tion/devicetree/bindings/mfd/max77620.txt
index 9c16d51cc15b..484b17e4fba5 100644
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
+	-maxim,backup-battery-charging-current: Charging current setting.
+			The device supports 50/100/200/400/600/800uA.
+			If this property is unavailable then it will
+			charge with 50uA.
+	-maxim,backup-battery-charging-voltage: Charging Voltage Limit Setting.
+			Device supports 2500000/3000000/3300000/350000uV.
+			Default will be set to 2500mV. The voltage will be roundoff
+			to nearest lower side if other than above is configured.
+	-maxim,backup-battery-output-resister: Output resistor on Ohm.
+			Device supports 100/1000/3000/6000 Ohms.
+			Default will be set to 1000 Ohm.
+
 Example:
 --------
 #include <dt-bindings/mfd/max77620.h>
--=20
2.19.2

