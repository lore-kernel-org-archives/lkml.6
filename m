Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225P4G6TC82s6ILSDL3kK5WcUMK2x0v3u8HC0MqJ85bKt72iREM6d226yTo7/XLmw0/M+wOB
ARC-Seal: i=1; a=rsa-sha256; t=1519217930; cv=none;
        d=google.com; s=arc-20160816;
        b=kki0nDGljaoESifz2/05MQqmS90l5KqMwwInIQjX+wgc29Yw35H7r97rZhRC4WZwPR
         we8tuRnHkAOwlf3BU7ZGttHCm35ttFuX890Mdu4ZLP0UEGGS3aT5koOzr+Cazw5mA3wg
         dqRlsOuKLedbRF9zvApJ+0Z9lUtihLrMkzI8OXwFa/gcT71dhquo0zKpQumsIkAtlSFU
         c7QxUb9QdkEnactyLjrzzFYacYmJpJxxt6v3+GtigT2/zZcXD+CUpmzWE+Cu9/Xf4MSh
         srrwiLSRJBPbuIAj+ccliwCO07dvOswMwci7UVuO3W5BOiDZdgwqZQIfRaiJlZ5AZQrp
         uziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vB2HCTFMa0GVCJXY3RSYm/BbWtJXSEyo7SHszPEdAm0=;
        b=odKzZScidhrz4ydM16bpZuEEJuUHhYBJg7md45TW6N7d2COIlsvqqaCgYIvCdHk/JC
         OFC5XhzU5ah8yWd/3/gIas3eNc66OSI13QUmwF9T3NmdYEVP1nw6DIakKBzF+fWhdIKl
         rxOD+twhdtQpa9u4fUkBzI0SCp7Hz2czBFfJE4XB9vCq0ibKxaL/qhJqcF2dRL9r8YgJ
         uwnsIbIpu+m2SBylzBDF+rQEd89RfGsxQY6KUSeyKHQpyCG1YcRq9/jKeiILftPVlrzc
         6OIFofx0ww+bcH/q+oig7+KmzILJD+ctx6ghG1pP6zNgR4MoPwm7lOwoH+jYny43XIj4
         KxXw==
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
Subject: [PATCH 4.14 028/167] ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property
Date: Wed, 21 Feb 2018 13:47:19 +0100
Message-Id: <20180221124526.127177910@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014617824025062?=
X-GMAIL-MSGID: =?utf-8?q?1593015460430016209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -122,7 +123,7 @@
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
@@ -213,7 +214,7 @@
 					 <&clk_s_d2_quadfs 0>,
 					 <&clk_s_d2_quadfs 1>;
 
-				hdmi,hpd-gpio = <&pio5 3>;
+				hdmi,hpd-gpio = <&pio5 3 GPIO_ACTIVE_LOW>;
 				reset-names = "hdmi";
 				resets = <&softreset STIH407_HDMI_TX_PHY_SOFTRESET>;
 				ddc = <&hdmiddc>;
