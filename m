Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C476C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F4D20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="Ca8nSz3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfBAGg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:36:28 -0500
Received: from forward100o.mail.yandex.net ([37.140.190.180]:41639 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfBAGg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:36:26 -0500
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward100o.mail.yandex.net (Yandex) with ESMTP id 3C9004AC2A57;
        Fri,  1 Feb 2019 09:36:22 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id qJCCBI1Fap-aLPKoXau;
        Fri, 01 Feb 2019 09:36:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1549002982;
        bh=bw8o9PbShB3Y6hhdn7ifBb3eYe95FLWeMK5ModEQ+Iw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=Ca8nSz3CbmINCn7RK5K7HSShpGhLu1UfjHmNCg/xD3WRYwKnROipuIPZpFTlOvL/H
         pLwpjg8rccTAeo6ib5ve3zzA9SvXNUJJxifcZSNH3AfeuSvmUM8aQ+ZNd9y58ovFS8
         47kedHdd+RIR+YFmhfbzl0z0YrruuC/D57IEOl8Y=
Authentication-Results: mxback20j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 5VfXSCstdQ-aHVCPGMI;
        Fri, 01 Feb 2019 09:36:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 3/3] dt-bindings: clock: Add loongson-1 clock bindings
Date:   Fri,  1 Feb 2019 14:35:40 +0800
Message-Id: <20190201063540.19636-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190201063540.19636-1-jiaxun.yang@flygoat.com>
References: <20190128152052.3047-1-jiaxun.yang@flygoat.com>
 <20190201063540.19636-1-jiaxun.yang@flygoat.com>
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
 .../bindings/clock/loongson1-clock.txt          | 14 ++++++++++++++
 include/dt-bindings/clock/ls1b-clock.h          | 17 +++++++++++++++++
 include/dt-bindings/clock/ls1c-clock.h          | 14 ++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/loongson1-clock.txt
 create mode 100644 include/dt-bindings/clock/ls1b-clock.h
 create mode 100644 include/dt-bindings/clock/ls1c-clock.h

diff --git a/Documentation/devicetree/bindings/clock/loongson1-clock.txt b/Documentation/devicetree/bindings/clock/loongson1-clock.txt
new file mode 100644
index 000000000000..5afd13a98eaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/loongson1-clock.txt
@@ -0,0 +1,14 @@
+* Clock bindings for Loongson-1 MCUs
+
+Required properties:
+- compatible: must contain one of the following compatibles:
+                - "loongson,ls1b-clock"
+                - "loongson,ls1c-clock"
+
+- reg: Address and length of the register set
+- #clock-cells: Should be <1>
+- clocks: list of input clocks
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell. See include/dt-bindings/clock/ls1c-clock.h
+or include/dt-bindings/clock/ls1b-clock.h for the full list of clocks.
diff --git a/include/dt-bindings/clock/ls1b-clock.h b/include/dt-bindings/clock/ls1b-clock.h
new file mode 100644
index 000000000000..c7ae85bb4583
--- /dev/null
+++ b/include/dt-bindings/clock/ls1b-clock.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com> */
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
index 000000000000..9d01914f374e
--- /dev/null
+++ b/include/dt-bindings/clock/ls1c-clock.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) 2019 Jiaxun Yang <jiaxun.yang@flygoat.com> */
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

