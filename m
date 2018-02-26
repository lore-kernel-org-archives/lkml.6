Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeBZIdH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:33:07 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41595 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752420AbeBZIdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:33:00 -0500
From: Patrice CHOTARD <patrice.chotard@st.com>
To: "arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "arm@kernel.org" <arm@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Patrice CHOTARD <patrice.chotard@st.com>
Subject: [GIT PULL] STi DT update for v4.17 round 1
Thread-Topic: [GIT PULL] STi DT update for v4.17 round 1
Thread-Index: AQHTrtxUcmGnhU0xXk+Qzyu4YASmBQ==
Date: Mon, 26 Feb 2018 08:32:25 +0000
Message-ID: <e30ac9b4-253c-106d-4ea5-604ec3eeb953@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC124B4D25AA0C4BAFEE674ACD5B9FDE@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-26_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1Q8XAo0016134

Hi Arnd, Kevin, Olof

PLease consider this first round of STi dts update for v4.17 :

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

   Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git

for you to fetch changes up to 0e04ce02e6a2ac30d21294d8bb2aeceb8489e52b:

   ARM: dts: STi: Remove unused clk_ext2f_a9 clock (2018-02-13 13:31:38 
+0100)

----------------------------------------------------------------
warn: You locally have sti-dt-for-v4.17-round1 but it does not (yet)
warn: appear to be at 
git://git.kernel.org/pub/scm/linux/kernel/git/pchotard/sti.git
warn: Do you want to push it there, perhaps?
warning: refname 'sti-dt-for-v4.17-round1' is ambiguous.
STi dts update:

Fix all DT dtc warnings when building with W=1
For most of implicated node, the addition of a fake reg property
fixes these warnings.
For others nodes, their location in device tree
have been updated.

----------------------------------------------------------------
Patrice Chotard (11):
       ARM: dts: STi: Fix bindings notation
       ARM: dts: STi: Move leds node outside soc node
       ARM: dts: STi: Add fake reg property for sti-display-subsystem
       ARM: dts: STi: Add fake reg property for miphy28lp_phy
       ARM: dts: STi: Add fake reg property for irq-syscfg
       ARM: dts: STi: Add fake reg property for remote processors
       ARM: dts: STi: Add fake reg for restart, powerdown and 
picophy/softreset
       ARM: dts: STi: Add fake reg property for usb2_picophyX nodes
       ARM: dts: STi: Update sound related nodes location
       ARM: dts: STi: Update clocks node location
       ARM: dts: STi: Remove unused clk_ext2f_a9 clock

  arch/arm/boot/dts/stih407-b2120.dts    |   2 +-
  arch/arm/boot/dts/stih407-clock.dtsi   |  92 +++++++++++-------------
  arch/arm/boot/dts/stih407-family.dtsi  |  42 ++++++-----
  arch/arm/boot/dts/stih407-pinctrl.dtsi |  10 +--
  arch/arm/boot/dts/stih407.dtsi         |   4 +-
  arch/arm/boot/dts/stih410-b2120.dts    |   8 +--
  arch/arm/boot/dts/stih410-b2260.dts    |  89 ++++++++++++-----------
  arch/arm/boot/dts/stih410-clock.dtsi   |  96 +++++++++++--------------
  arch/arm/boot/dts/stih410-pinctrl.dtsi |   2 +-
  arch/arm/boot/dts/stih410.dtsi         |  13 ++--
  arch/arm/boot/dts/stih418-b2199.dts    |  30 ++++----
  arch/arm/boot/dts/stih418-clock.dtsi   |  95 +++++++++++--------------
  arch/arm/boot/dts/stih418.dtsi         |   6 +-
  arch/arm/boot/dts/stihxxx-b2120.dtsi   | 126 
+++++++++++++++++----------------
  14 files changed, 300 insertions(+), 315 deletions(-)
