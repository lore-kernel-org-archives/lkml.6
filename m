Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864B7C6783B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0C62086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 22:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="k8BK+uHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0C62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbeLLWTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 17:19:44 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:40650 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728521AbeLLWQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 17:16:42 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 01/26] dt-bindings: ingenic: Add DT bindings for TCU clocks
Date:   Wed, 12 Dec 2018 23:08:56 +0100
Message-Id: <20181212220922.18759-2-paul@crapouillou.net>
In-Reply-To: <20181212220922.18759-1-paul@crapouillou.net>
References: <20181212220922.18759-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1544652574; bh=jDjeSp9zB/3eH+mPAvg15webR0kBtHrBWa1POnLOpwU=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k8BK+uHILIsY7vy5AKwAXE7TjXEq7M7sPBBFCsSRLB7W4btA9sE1szF1ZtUc/zhgOWXYUuwrGf6H+ZMj9eZO4anoj9XoUn5gTcpPJR+EUvMFtWIxICZCcg4Kd5PCgTrCtc1NCksKOgFSO6ZudXkJKTD8der+2R0ixYosHi87Zjo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This header provides clock numbers for the ingenic,tcu
DT binding.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
     v2: Use SPDX identifier for the license
    
     v3: No change
    
     v4: No change
    
     v5: s/JZ47*_/TCU_/ and dropped *_CLK_LAST defines
    
     v6: No change
    
     v7: No change

     v8: No change

 include/dt-bindings/clock/ingenic,tcu.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/clock/ingenic,tcu.h

diff --git a/include/dt-bindings/clock/ingenic,tcu.h b/include/dt-bindings/clock/ingenic,tcu.h
new file mode 100644
index 000000000000..d569650a7945
--- /dev/null
+++ b/include/dt-bindings/clock/ingenic,tcu.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides clock numbers for the ingenic,tcu DT binding.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
+#define __DT_BINDINGS_CLOCK_INGENIC_TCU_H__
+
+#define TCU_CLK_TIMER0	0
+#define TCU_CLK_TIMER1	1
+#define TCU_CLK_TIMER2	2
+#define TCU_CLK_TIMER3	3
+#define TCU_CLK_TIMER4	4
+#define TCU_CLK_TIMER5	5
+#define TCU_CLK_TIMER6	6
+#define TCU_CLK_TIMER7	7
+#define TCU_CLK_WDT	8
+#define TCU_CLK_OST	9
+
+#endif /* __DT_BINDINGS_CLOCK_INGENIC_TCU_H__ */
-- 
2.11.0

