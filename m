Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B962C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C9020B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eQlH0d45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfAaJYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:24:20 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4684 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfAaJYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:24:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c52bec50001>; Thu, 31 Jan 2019 01:24:21 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 31 Jan 2019 01:24:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 31 Jan 2019 01:24:19 -0800
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 09:24:18 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 31 Jan
 2019 09:24:19 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 31 Jan 2019 09:24:18 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c52bec10001>; Thu, 31 Jan 2019 01:24:18 -0800
From:   Joseph Lo <josephl@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Joseph Lo <josephl@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH V4 1/7] dt-bindings: timer: add Tegra210 timer
Date:   Thu, 31 Jan 2019 17:24:04 +0800
Message-ID: <20190131092410.28222-2-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131092410.28222-1-josephl@nvidia.com>
References: <20190131092410.28222-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548926661; bh=AtUj36W3zYQHBmv+noQJcmd4x5qNY3mVboxC574zoyc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=eQlH0d45d7dFMrSrkIfyyJMxN4L0sqxMoQG6cGpNq0LMUZL7DoGTJaQVCvbgUfCiH
         8fcbQlQ2/dQFYKcCzClaq/++HzOBVtuKV+k6XOzsoS+m1NXeE/zlGI8YfckhWizCHg
         rCFperZMi9qRdmvV6dAVDCI2bL/dDgYdYfzKs7UHLLVTJ1MaKdDa2T5XTcneFy3vTB
         yNox2a4fMLLrbOC+1WOsEl5RhNvMIQx3LAxvKSx6IZr2qcG4H4wQn5n8aXG2EjgpcB
         T35aiZ9BRlz3rmPGKgUWsXBPYlPbZI0V/dRaCKZ1k4FhszngPpaTPiCF6U3nQSyNc1
         b9XgVtTnjvkpQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
(TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
or watchdog interrupts.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V4:
 * no change
v3:
 * no change
v2:
 * list all the interrupts that are supported by tegra210 timers block
 * add RB tag from Rob.
---
 .../bindings/timer/nvidia,tegra210-timer.txt  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210=
-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.=
txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
new file mode 100644
index 000000000000..032cda96fe0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
@@ -0,0 +1,36 @@
+NVIDIA Tegra210 timer
+
+The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
+timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
+from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
+(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
+or watchdog interrupts.
+
+Required properties:
+- compatible : "nvidia,tegra210-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 14 interrupts; one per each timer channels 0 thro=
ugh
+  13.
+- clocks : Must contain one entry, for the module clock.
+  See ../clocks/clock-bindings.txt for details.
+
+timer@60005000 {
+	compatible =3D "nvidia,tegra210-timer";
+	reg =3D <0x0 0x60005000 0x0 0x400>;
+	interrupts =3D <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>,
+		     <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
+	clocks =3D <&tegra_car TEGRA210_CLK_TIMER>;
+	clock-names =3D "timer";
+};
--=20
2.20.1

