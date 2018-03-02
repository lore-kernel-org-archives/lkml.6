Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033307AbeCBPoy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:44:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:33835 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S936325AbeCBPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:44:47 -0500
From: yannick fertre <yannick.fertre@st.com>
To: Vikas Manocha <vikas.manocha@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Patrice Chotard <patrice.chotard@st.com>,
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
Subject: [PATCH v2 08/10] arm: dts: stm32: add dsi for STM32F746
Date: Fri, 2 Mar 2018 16:44:09 +0100
Message-ID: <1520005451-23217-9-git-send-email-yannick.fertre@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
References: <1520005451-23217-1-git-send-email-yannick.fertre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.68]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-02_08:,,
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
index e4d32bf..4ec954d 100644
--- a/arch/arm/dts/stm32f746.dtsi
+++ b/arch/arm/dts/stm32f746.dtsi
@@ -332,6 +332,18 @@
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
