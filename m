Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CEBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757A6214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 08:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="RyDDsCMU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfA2I4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 03:56:20 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2044 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfA2I4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 03:56:18 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5015320001>; Tue, 29 Jan 2019 00:56:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 29 Jan 2019 00:56:17 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 29 Jan 2019 00:56:17 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 29 Jan
 2019 08:56:17 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 08:56:17 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c50152f0000>; Tue, 29 Jan 2019 00:56:16 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <blaws05@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
Subject: [PATCH v2 4/4] mfd: max77620: add documentation for low battery monitoring
Date:   Tue, 29 Jan 2019 16:55:31 +0800
Message-ID: <20190129085531.32364-5-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190129085531.32364-1-markz@nvidia.com>
References: <20190129085531.32364-1-markz@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548752178; bh=L9LH9hSL3Ib/CS/ZOqBpbZI2CIcUfJ74WbkHuzn+K/w=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=RyDDsCMU3jyqr4fxrC2MNB5vSblqUiIOiBB3vczowS/uXpMyxOtb3ovu+iodJO/JL
         hRusacVkzDY/n5hI/ULv4fZYPN4X2xbKsSDp6+Ma32evh2hXRVR5VVqKD8PMp/bq8Q
         cqtEIZYx+FcwCC0mHgjFO9RaWGM+qbOVVjAQJzZq7oj15QepfaaVMfmgwuX+1VVxzh
         8n1+zp4A6eYKeCFEX6dzoEL/b3qDmZxjfISgfsPOxnT7XnZw+wHMzbRnI3vAi3SoF0
         CsHoflTZauu9XDUeG5JxRa4/IzizdXUZXP5oiSvAFlRwL2zn8+FzEgUB0dZSCMs36R
         TiP4VmF/51Xfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding documentation for low battery monitor properties:
- maxim,low-battery-dac-enable
- maxim,low-battery-dac-disable
- maxim,low-battery-shutdown-enable
- maxim,low-battery-shutdown-disable
- maxim,low-battery-reset-enable
- maxim,low-battery-reset-disable

Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 Documentation/devicetree/bindings/mfd/max77620.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documenta=
tion/devicetree/bindings/mfd/max77620.txt
index 484b17e4fba5..5fed0a463b80 100644
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -142,6 +142,20 @@ Optional properties:
 			Device supports 100/1000/3000/6000 Ohms.
 			Default will be set to 1000 Ohm.
=20
+Low-Battery Monitor:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+This sub-node configure low battery monitor configuration registers. Devic=
e has
+support for low-battery monitor configuration through child DT node
+"low-battery-monitor".
+
+Optional properties:
+	- maxim,low-battery-dac-enable: Enable low battery DAC.
+	- maxim,low-battery-dac-disable: Disable low battery DAC.
+	- maxim,low-battery-shutdown-enable: Enable low battery shutdown.
+	- maxim,low-battery-shutdown-disable: Disable low battery shutdown.
+	- maxim,low-battery-reset-enable: Enable low battery reset.
+	- maxim,low-battery-reset-disable: Disable low battery reset.
+
 Example:
 --------
 #include <dt-bindings/mfd/max77620.h>
--=20
2.19.2

