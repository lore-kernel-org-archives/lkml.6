Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D526C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DC5218FC
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 14:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbfABOLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 09:11:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:9274 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729067AbfABOKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 09:10:35 -0500
X-UUID: 25e44eb602514f53bf918fff357437a8-20190102
X-UUID: 25e44eb602514f53bf918fff357437a8-20190102
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1262923212; Wed, 02 Jan 2019 22:10:28 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 2 Jan 2019 22:10:26 +0800
Received: from mtkslt205.mediatek.inc (10.21.15.75) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 2 Jan 2019 22:10:26 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Fan Chen <fan.chen@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Kees Cook <keescook@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC RESEND PATCH 1/7] dt-bindings: soc: Add DVFSRC driver bindings
Date:   Wed, 2 Jan 2019 22:09:52 +0800
Message-ID: <1546438198-1677-2-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 218B0A421E84B4284B0CE4A8316AB19826A2E0BC71E3BCB0664419FF9E97905C2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the binding for enabling DVFSRC on MediaTek SoC.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 26 ++++++++++++++++++++++
 include/dt-bindings/soc/mtk,dvfsrc.h               | 18 +++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
 create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h

diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
new file mode 100644
index 0000000..402c885
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
@@ -0,0 +1,26 @@
+MediaTek DVFSRC Driver
+
+The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
+HW module which is used to collect all the requests from both software and
+hardware and turn into the decision of minimum operating voltage and minimum
+DRAM frequency to fulfill those requests.
+
+Required Properties:
+- compatible: Should be one of the following
+	- "mediatek,mt8183-dvfsrc": For MT8183 SoC
+- reg: Address range of the DVFSRC unit
+- dram_type: Refer to <include/dt-bindings/soc/mtk,dvfsrc.h> for the
+	different dram type support.
+- clock-names: Must include the following entries:
+	"dvfsrc": DVFSRC module clock
+- clocks: Must contain an entry for each entry in clock-names.
+
+Example:
+
+	dvfsrc_top@10012000 {
+		compatible = "mediatek,mt8183-dvfsrc";
+		reg = <0 0x10012000 0 0x1000>;
+		clocks = <&infracfg CLK_INFRA_DVFSRC>;
+		clock-names = "dvfsrc";
+		dram_type = <MT8183_DVFSRC_OPP_LP4>;
+	};
diff --git a/include/dt-bindings/soc/mtk,dvfsrc.h b/include/dt-bindings/soc/mtk,dvfsrc.h
new file mode 100644
index 0000000..60b3497
--- /dev/null
+++ b/include/dt-bindings/soc/mtk,dvfsrc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MTK_DVFSRC_H
+#define _DT_BINDINGS_POWER_MTK_DVFSRC_H
+
+#define MT8183_DVFSRC_OPP_LP4	0
+#define MT8183_DVFSRC_OPP_LP4X	1
+#define MT8183_DVFSRC_OPP_LP3	2
+
+#define MT8183_DVFSRC_LEVEL_1	1
+#define MT8183_DVFSRC_LEVEL_2	2
+#define MT8183_DVFSRC_LEVEL_3	3
+#define MT8183_DVFSRC_LEVEL_4	4
+
+#endif /* _DT_BINDINGS_POWER_MTK_DVFSRC_H */
-- 
1.9.1

