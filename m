Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39D8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84032218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="HMAolznC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfAYNhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:37:02 -0500
Received: from forward104o.mail.yandex.net ([37.140.190.179]:37541 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727826AbfAYNhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:37:01 -0500
Received: from mxback6j.mail.yandex.net (mxback6j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10f])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 42DE2942F1A;
        Fri, 25 Jan 2019 16:36:49 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback6j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id eu2ssGKB7e-aniaXDOs;
        Fri, 25 Jan 2019 16:36:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1548423409;
        bh=TuBMlX5/v7jXm2kI9MQ+sU2l18YHTG4NcoeL70x9Veg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=HMAolznCH6oJIxCbOyqgt8yuRcGZVJpTs1TIvwqOIadEIGI9TyQGdPRh3pThLHeR1
         El1w0US9KpnyPABaNv9+m9lZgkWEilfrj1PN+RLJj5QqOQWoEyYRdbPnguupYYVkyt
         z1rxdjGlK2MJsoqMhSAZkK+pxrHmlbUypC18lvHE=
Authentication-Results: mxback6j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id XwuTEG9eza-aie0nwwf;
        Fri, 25 Jan 2019 16:36:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] dt-bindings: clock: Add loongson-1 clock bindings
Date:   Fri, 25 Jan 2019 21:34:13 +0800
Message-Id: <20190125133413.4130-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125133413.4130-1-jiaxun.yang@flygoat.com>
References: <20190125133413.4130-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongson-1 is a series of MIPS MCUs.
This patch add the clock bindings for loongson-1b and
loongson-1c clock subsystem.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 .../bindings/clock/loongson1-clock.txt        | 11 ++++++++++
 include/dt-bindings/clock/ls1b-clock.h        | 20 +++++++++++++++++++
 include/dt-bindings/clock/ls1c-clock.h        | 17 ++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson1-clock.txt
 create mode 100644 include/dt-bindings/clock/ls1b-clock.h
 create mode 100644 include/dt-bindings/clock/ls1c-clock.h

diff --git a/Documentation/devicetree/bindings/clock/loongson1-clock.txt b/Documentation/devicetree/bindings/clock/loongson1-clock.txt
new file mode 100644
index 000000000000..f0119fbd0851
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/loongson1-clock.txt
@@ -0,0 +1,11 @@
+* Clock bindings for Loongson-1 MCUs
+
+Required properties:
+- compatible: Should be "loongson,ls1c-clock" or "loongson,ls1b-clock"
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+- clocks: list of input clocks
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell. See include/dt-bindings/clock/ls1c-clock.h
+or include/dt-bindings/clock/ls1b-clock.h for the full list of clocks.
diff --git a/include/dt-bindings/clock/ls1b-clock.h b/include/dt-bindings/clock/ls1b-clock.h
new file mode 100644
index 000000000000..814227842ae0
--- /dev/null
+++ b/include/dt-bindings/clock/ls1b-clock.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier:	GPL-2.0
+/*
+ * Copyright (C) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_LS1B_CLOCK_H__
+#define __DT_BINDINGS_CLOCK_LS1B_CLOCK_H__
+
+#define LS1B_CLK_PLL 0
+#define LS1B_CLK_CPU_DIV 1
+#define LS1B_CLK_CPU 2
+#define LS1B_CLK_DC_DIV 3
+#define LS1B_CLK_DC 4
+#define LS1B_CLK_DDR_DIV 5
+#define LS1B_CLK_DDR 6
+#define LS1B_CLK_AHB 7
+#define LS1B_CLK_APB 8
+
+#endif /* __DT_BINDINGS_CLOCK_LS1B_CLOCK_H__ */
diff --git a/include/dt-bindings/clock/ls1c-clock.h b/include/dt-bindings/clock/ls1c-clock.h
new file mode 100644
index 000000000000..40f386cb92ce
--- /dev/null
+++ b/include/dt-bindings/clock/ls1c-clock.h
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier:	GPL-2.0
+/*
+ * Copyright (C) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_LS1C_CLOCK_H__
+#define __DT_BINDINGS_CLOCK_LS1C_CLOCK_H__
+
+#define LS1C_CLK_PLL 0
+#define LS1C_CLK_CPU 1
+#define LS1C_CLK_DC 2
+#define LS1C_CLK_DDR 3
+#define LS1C_CLK_AHB 4
+#define LS1C_CLK_APB 5
+
+#endif /* __DT_BINDINGS_CLOCK_LS1C_CLOCK_H__ */
-- 
2.20.1

