Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B777C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E9120836
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="VGQ5eT7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfBLGob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:44:31 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:14062 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfBLGo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:44:28 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c626b4c0000>; Mon, 11 Feb 2019 22:44:28 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 22:44:27 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 Feb 2019 22:44:27 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 06:44:26 +0000
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 12 Feb
 2019 06:44:27 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Tue, 12 Feb 2019 06:44:26 +0000
Received: from localhost.localdomain (Not Verified[10.19.225.143]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c626b490000>; Mon, 11 Feb 2019 22:44:26 -0800
From:   Mark Zhang <markz@nvidia.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-tegra@vger.kernel.org>, Mark Zhang <markz@nvidia.com>
Subject: [PATCH v3 4/4] mfd: max77620: add documentation for low battery monitoring
Date:   Tue, 12 Feb 2019 14:43:53 +0800
Message-ID: <20190212064353.7451-5-markz@nvidia.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190212064353.7451-1-markz@nvidia.com>
References: <20190212064353.7451-1-markz@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549953868; bh=RXsCU8E8kLZ/hlyc7W/fHifCcnj1LoXOg9fJTiV+R6c=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=VGQ5eT7dyxsgmWQnS8N4NVxL0pL2UvnVvhAxc0qtqEmITOItMzi2RlnhFo4O9eGmJ
         thpcm3GSPUY/Nh+XNMgxbJ3dY7EXOOFdwrFhxIScMKUk33q8W549FMg/I9Z1IMUDLy
         9hISZu14KxzHJbRd636qyzzz13NqQW1OxGkS0Hc4mfoq1Va3ij4yLhNHFBPGmt+OWS
         r5D/FqSs/ARub+LWFLtlDge48Fj0n/58kkj+s46NEpLud/IGfnyBP0C0lxub/qkaWh
         Fiani0nz4/OJ+n4hC4z8de1De/egk7cYrPaRVq2HH6xJ/SBXq1+nE3Z5+4oEsWhSBj
         9Pjh6gPF+DLZA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding documentation for low battery monitor properties:
- maxim,low-battery-dac-enable
- maxim,low-battery-mode

Signed-off-by: Mark Zhang <markz@nvidia.com>
---
 Documentation/devicetree/bindings/mfd/max77620.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/max77620.txt b/Documenta=
tion/devicetree/bindings/mfd/max77620.txt
index 88825eaf2567..f5b298ccc929 100644
--- a/Documentation/devicetree/bindings/mfd/max77620.txt
+++ b/Documentation/devicetree/bindings/mfd/max77620.txt
@@ -142,6 +142,20 @@ Optional properties:
 			Device supports 100/1000/3000/6000 Ohms.
 			Default will be set to 1000 Ohm.
=20
+Low-Battery Monitor:
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+max77620 is able to monitor the main battery voltage and shutdown/reset th=
e
+chip connected accordingly.
+
+Optional properties:
+	- maxim,low-battery-dac-enable: Enable low battery monitoring.
+			Low battery monitoring will be disabled if missing
+			this property.
+	- maxim,low-battery-mode: Shutdown or reset the chip.
+			The value of this property is "shutdown" which means
+			a global shutdown will be triggered. Any other values
+			or missing this property causes a chip reset.
+
 Example:
 --------
 #include <dt-bindings/mfd/max77620.h>
--=20
2.19.2

