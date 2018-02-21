Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2264EyfGfbKGFRdPclBZgA4DyofiY62UcL0TN1RTXJugisOtX1SzjDwTzxCUrNtA/EbM/GQn
ARC-Seal: i=1; a=rsa-sha256; t=1519217126; cv=none;
        d=google.com; s=arc-20160816;
        b=qC2jgQA9TJQEHCykwlvxOwhnYjbwTAx0OzvXHhSBVV2x2QwN8olc/szzHND0F6YGrZ
         bCd1yLkrARrZHlvA176R5wb7EUe4fFRhv+h826yg7uFqflEHWczIHcPJifAiWl1/yP2I
         hqRVnFXZJGJBGItoll3bg7cnY7LmVDV9S+nPfkR95AAa7CJcUGOHx8IKOkCBOLsdyAF1
         QGEfpHQrG3tNjzeAvwhTkYA2k0BqGfHrq1lvL2SDkCC3Zz4IT6VntiWLjBqCLc5g/894
         XL/GaKKOVjhjugoZ3PezL0fPfI8kgcZBAtfRds/rKLw8EDlWiTYXi6WwSP0sQ7sCdxS9
         FyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/08wzJ1GhmbQumW5I2T7MFnrQO34iaAvtU+/sIxHsA8=;
        b=yKuKMpVeKwzEG8Db8ok/q3gaFjiHLipvSgrM5FzzWY0/oD+wJkPodBx8R+Smjff1q0
         QxQ9tlBeYC/jmy0Y8nOGDVhY4ycNkHzPDfmKV4GSJa2eGZLlF8QLC2wi9IwZJQdFvA3l
         k48kpbcgCqx3QanU/j+Cqkhyg+RWg15z4ekAdldjMmdSdMJjm437meicXN6az12J99gg
         tax50NYOqOaDrmPlqqLCKrgXE6WUCM/28lFEMVzYBmBRCzC+RTRwepjHaXcdpQFt44jh
         ghjMToKHT4wgfyfeg84XIEtz6lBqpadviEfkTWbWXwHFg6mIRxSQITNP1BWAtaiwu7So
         ynxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Patrice Chotard <patrice.chotard@st.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 04/33] ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property
Date: Wed, 21 Feb 2018 13:44:47 +0100
Message-Id: <20180221124409.769957350@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014617824025062?=
X-GMAIL-MSGID: =?utf-8?q?1593014617824025062?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrice Chotard <patrice.chotard@st.com>

commit 7ac1f59c09a61e6af6622df6809e003b0af07f3d upstream.

The GPIO polarity is missing in the hdmi,hpd-gpio property, this
fixes the following DT warnings:

arch/arm/boot/dts/stih410-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property
size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi@8d04000

arch/arm/boot/dts/stih407-b2120.dtb: Warning (gpios_property): hdmi,hpd-gpio property
size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi@8d04000

arch/arm/boot/dts/stih410-b2260.dtb: Warning (gpios_property): hdmi,hpd-gpio property
size (8) too small for cell size 2 in /soc/sti-display-subsystem/sti-hdmi@8d04000

[arnd: marked Cc:stable since this warning shows up with the latest dtc
       by default, and is more likely to actually cause problems than the
       other patches from this series]

Cc: stable@vger.kernel.org
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/stih407.dtsi |    3 ++-
 arch/arm/boot/dts/stih410.dtsi |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -8,6 +8,7 @@
  */
 #include "stih407-clock.dtsi"
 #include "stih407-family.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 / {
 	soc {
 		sti-display-subsystem {
@@ -112,7 +113,7 @@
 					 <&clk_s_d2_quadfs 0>,
 					 <&clk_s_d2_quadfs 1>;
 
-				hdmi,hpd-gpio = <&pio5 3>;
+				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
 				reset-names = "hdmi";
 				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
 				ddc = <&hdmiddc>;
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -9,6 +9,7 @@
 #include "stih410-clock.dtsi"
 #include "stih407-family.dtsi"
 #include "stih410-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 / {
 	aliases {
 		bdisp0 = &bdisp0;
@@ -203,7 +204,7 @@
 					 <&clk_s_d2_quadfs 0>,
 					 <&clk_s_d2_quadfs 1>;
 
-				hdmi,hpd-gpio = <&pio5 3>;
+				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
 				reset-names = "hdmi";
 				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
 				ddc = <&hdmiddc>;
