Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754313AbeBLOnl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:43:41 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:17521 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754285AbeBLOnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:43:40 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v2 00/12] ARM: dts: STi: Fix DT dtc warnings 
Date: Mon, 12 Feb 2018 15:42:58 +0100
Message-ID: <1518446590-16800-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

This series fixes all dtc warnings related to STi platforms dt files.
It has been reported by Rob Herring [1]

For most of implicated node, the addition of a fake reg property
fixes these warnings.

[1] https://www.spinics.net/lists/devicetree/msg206209.html

v2: _ add a fake reg property to node without reg property, instead 
      of moving them outside soc node.

Patrice Chotard (7):
  ARM: dts: STi: fix bindings notation
  ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property
  ARM: dts: STi: Move clocks without reg outside soc
  ARM: dts: STi: Move leds node outside soc node
  ARM: dts: STi: Add fake reg property for sti-display-subsystem
  ARM: dts: STi: Add fake reg property for miphy28lp_phy
  ARM: dts: STi: Add fake reg property for irq-syscfg
  ARM: dts: STi: Add fake reg property for remote processors
  ARM: dts: STi: Add fake reg for restart, powerdown and
    picophy/softreset
  ARM: dts: STi: Add fake reg property for usb2_picophyX nodes
  ARM: dts: STi: Add fake reg property for sound related nodes
  ARM: dts: STi: Add fake reg property for clocks
  ARM: dts: STi: Move clk_sysin clock ouside soc node
  ARM: dts: STi: Remove unused clk_ext2f_a9 clock

 arch/arm/boot/dts/stih407-b2120.dts    |  2 +-
 arch/arm/boot/dts/stih407-clock.dtsi   | 40 +++++++++-------------
 arch/arm/boot/dts/stih407-family.dtsi  | 31 +++++++++++------
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 10 +++---
 arch/arm/boot/dts/stih407.dtsi         |  4 +--
 arch/arm/boot/dts/stih410-b2120.dts    |  8 ++---
 arch/arm/boot/dts/stih410-b2260.dts    | 62 +++++++++++++++++-----------------
 arch/arm/boot/dts/stih410-clock.dtsi   | 42 ++++++++++-------------
 arch/arm/boot/dts/stih410-pinctrl.dtsi |  2 +-
 arch/arm/boot/dts/stih410.dtsi         | 13 ++++---
 arch/arm/boot/dts/stih418-b2199.dts    | 30 ++++++++--------
 arch/arm/boot/dts/stih418-clock.dtsi   | 42 ++++++++++-------------
 arch/arm/boot/dts/stih418.dtsi         |  6 ++--
 arch/arm/boot/dts/stihxxx-b2120.dtsi   | 41 +++++++++++-----------
 14 files changed, 163 insertions(+), 170 deletions(-)

-- 
1.9.1
