Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753032AbeCMNv3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:51:29 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27257 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752906AbeCMNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:50:54 -0400
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>, Tom Rini <trini@konsulko.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Patrice Chotard" <patrice.chotard@st.com>,
        Patrick DELAUNAY <patrick.delaunay@st.com>,
        Christophe KERELLO <christophe.kerello@st.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Brian Norris <briannorris@chromium.org>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Albert Aribaud <albert.u.boot@aribaud.net>,
        "Simon Glass" <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>,
        Thierry Reding <thierry.reding@gmail.com>
CC: <u-boot@lists.denx.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 08/10] arm: dts: stm32: add dsi for STM32F746
Date: Tue, 13 Mar 2018 14:50:11 +0100
Message-ID: <1520949014-21468-13-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
References: <1520949014-21468-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mipi dsi bridge node in device-tree.

Signed-off-by: yannick fertre <yannick.fertre@st.com>
---
 arch/arm/dts/stm32f746.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/dts/stm32f746.dtsi b/arch/arm/dts/stm32f746.dtsi
index 8581df9..3b8af67 100644
--- a/arch/arm/dts/stm32f746.dtsi
+++ b/arch/arm/dts/stm32f746.dtsi
@@ -339,6 +339,18 @@
 			u-boot,dm-pre-reloc;
 			status = "disabled";
 		};
+
+		dsi: dsi@40016c00 {
+			compatible = "st,stm32-dsi";
+			reg = <0x40016C00 0x800>;
+			resets = <&rcc STM32F7_APB2_RESET(DSI)>;
+			clocks =  <&rcc 0 STM32F7_APB2_CLOCK(DSI)>,
+				  <&rcc 0 STM32F7_APB2_CLOCK(LTDC)>,
+				  <&clk_hse>;
+			clock-names = "pclk", "px_clk", "ref";
+			u-boot,dm-pre-reloc;
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.9.1
