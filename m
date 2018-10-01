Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1910C0044B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6791521473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 10:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0cIh0Rg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6791521473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbeJARHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:07:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35891 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbeJARHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:07:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id n23-v6so8167967wmc.1;
        Mon, 01 Oct 2018 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=14qXf8FTfStXCuMfxFD5sUAc0+iyBkt3QVppyXlAkhE=;
        b=G0cIh0RgoWvbr7VEiXBcXTo2HNRCvggCODA8/cPWZkAlyi9EDFqfjBOZouo2FTpVjA
         Qcud7gtQ5nMy//Ax9V2ggdRQBT+gA3Ai7R1uZZeHoR3p9fL2M50tUD1smE3F2QUJZ4qI
         3DOg97nhjF7PRzQvTO6NFdj9YBzOKgOt9cC6qsIrdRFkNl2w6zjrLzlbTbh5knF3BuyE
         8E3CYNK0OO+5FxuTMUfphMEjm0KhuCIIu7ivCADBQDQeEULKg7QAW+FK8H1MyUrvMm87
         KlBCivkAROx5EC2tg/vjv+4Z8lj8X2QfFLj5LPjnM3OWH/kcRF1On5f2yptpqGI35ZjC
         E5qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=14qXf8FTfStXCuMfxFD5sUAc0+iyBkt3QVppyXlAkhE=;
        b=RuX9nfxh743c/XbND/48OP7qgcT6JJA6S58UmPNFACkhArblcsIQiOPo1ii1E+x25U
         PiuPaYGknU94CTPi2E+By9JQ6XjVe9fPyHdGGs4y/all6qMhYLk6TGhdMJUUVPDQ+0qr
         0qhV4hutcN/JQJ/HZAxNryW7IHm5S3OmdTv8K2F32DvEtB5XFQ+PSsPVrJNd9H60xpSE
         T/Rm8C+zZG8lFfzCFW/akMaABDECwFTvA4PWxHQ+jzLGn1rRladqRTkzQ7MlxELoF2mi
         0Uc1oFXZKr2ZCFB8krsdFynumzijzk4CgmgsnE1APFbzixTsRxH3bmQTecCMm2sN+URp
         Ka8Q==
X-Gm-Message-State: ABuFfog/5PcnkJdcdfYFkYUvSd7Yzep+GLMBaISW+rRNdeLvhlvsCfDp
        Y4qPV3ypmUSitu9mVWnoIac=
X-Google-Smtp-Source: ACcGV6351YfS9QoSsDHUiOobVuh0U60BefEsiS7Y7IjD2T3QfYR1rex/Fn2+DvOQtAuilYEPyBk2ew==
X-Received: by 2002:a1c:1e8e:: with SMTP id e136-v6mr3177051wme.100.1538389822335;
        Mon, 01 Oct 2018 03:30:22 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2461169wmf.45.2018.10.01.03.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 03:30:22 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC v2 4/7] dt-binding: timer: Document RTL8186 SoC DT bindings
Date:   Mon,  1 Oct 2018 13:29:49 +0300
Message-Id: <20181001102952.7913-5-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181001102952.7913-1-yasha.che3@gmail.com>
References: <20181001102952.7913-1-yasha.che3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree binding doc for the
Realtek RTL8186 SoC timer controller.

Signed-off-by: Yasha Cherikovsky <yasha.che3@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
---
 .../bindings/timer/realtek,rtl8186-timer.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt b/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
new file mode 100644
index 000000000000..eaa6292c16e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/realtek,rtl8186-timer.txt
@@ -0,0 +1,17 @@
+Realtek RTL8186 SoC timer
+
+Required properties:
+
+- compatible : Should be "realtek,rtl8186-timer".
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt number of the timer.
+- clocks: phandle to the source clock (usually a 22 MHz fixed clock)
+
+Example:
+
+timer {
+	compatible = "realtek,rtl8186-timer";
+	reg = <0x1d010050 0x30>;
+	interrupts = <0>;
+	clocks = <&sysclk>;
+};
-- 
2.19.0

