Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8ACC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4697208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 06:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbeL1Gd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 01:33:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:16664 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728430AbeL1GdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 01:33:17 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 08B401FC4AA0B;
        Fri, 28 Dec 2018 14:33:14 +0800 (CST)
Received: from SIA1000080854.huawei.com (10.180.101.187) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.408.0; Fri, 28 Dec 2018 14:33:05 +0800
From:   h00249924 <hutenghui@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
CC:     <suzhuangluan@hisilicon.com>, <kongfei@hisilicon.com>,
        <liyuequan@hisilicon.com>, <cash.qianli@hisilicon.com>,
        <huangli295@hisilicon.com>, <hantanglei@huawei.com>,
        <wangyoulin1@hisilicon.com>, <ninggaoyu@hisilicon.com>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        "Wei Xu" <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 1/2] arm64: dts: hi3660: Add i2s & sound device
Date:   Fri, 28 Dec 2018 14:30:45 +0800
Message-ID: <1545978646-124051-1-git-send-email-hutenghui@huawei.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.101.187]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youlin Wang <wwx575822@notesmail.huawei.com>

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
Signed-off-by: Tanglei Han <hantanglei@huawei.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
index 5223e36..ae535da 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
@@ -1136,5 +1136,33 @@
 			interrupt-names = "asp_dma_irq";
 			status = "ok";
 		};
+
+		i2s2: hisi_i2s {
+			compatible = "hisilicon,hisi-i2s";
+			reg = <0x0 0xe804f800 0x0 0x400>,
+			      <0x0 0xe804e000 0x0 0x400>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2s2_pmx_func &i2s2_cfg_func>;
+			dmas = <&asp_dmac 18 &asp_dmac 19>;
+			dma-names = "rx", "tx";
+			#sound-dai-cells = <0>;
+		};
+
+		sound {
+			compatible = "simple-audio-card";
+			simple-audio-card,name = "hikey-hdmi";
+			simple-audio-card,format = "i2s";
+
+			simple-audio-card,bitclock-master = <&sound_master>;
+			simple-audio-card,frame-master = <&sound_master>;
+
+			sound_master: simple-audio-card,cpu {
+				sound-dai = <&i2s2>;
+			};
+
+			simple-audio-card,codec {
+				sound-dai = <&adv7533>;
+			};
+		};
 	};
 };
-- 
1.9.1

