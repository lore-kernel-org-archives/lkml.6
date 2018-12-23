Return-Path: <SRS0=rRkv=PA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D71FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FEB21903
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Dec 2018 10:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeLWKGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Dec 2018 05:06:06 -0500
Received: from www1102.sakura.ne.jp ([219.94.129.142]:42046 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbeLWKGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Dec 2018 05:06:05 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wBNA5fYm078297;
        Sun, 23 Dec 2018 19:05:41 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Sun, 23 Dec 2018 19:05:41 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from localhost.localdomain (183.38.232.153.ap.dti.ne.jp [153.232.38.183])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wBNA5ciC078276
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 23 Dec 2018 19:05:41 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] arm64: dts: rockchip: add rk3328 ACODEC node
Date:   Sun, 23 Dec 2018 19:05:30 +0900
Message-Id: <20181223100530.12892-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds audio codec (ACODEC) node that converts to analog
audio signal from I2S for rk3328.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---

This patch depends on Rockcihp RK3328 ACODEC driver patches that were
applied in ALSA SoC tree. We can see the patches on this thread.
  https://lkml.org/lkml/2018/12/20/665

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index ecd7f19c3542..0f02b1dc87e3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -672,6 +672,16 @@
 		};
 	};
 
+	codec: codec@ff410000 {
+		compatible = "rockchip,rk3328-codec";
+		reg = <0x0 0xff410000 0x0 0x1000>;
+		rockchip,grf = <&grf>;
+		clocks = <&cru PCLK_ACODECPHY>, <&cru SCLK_I2S1>;
+		clock-names = "pclk", "mclk";
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	hdmiphy: phy@ff430000 {
 		compatible = "rockchip,rk3328-hdmi-phy";
 		reg = <0x0 0xff430000 0x0 0x10000>;
-- 
2.19.2

