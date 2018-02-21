Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224gyS/ui8b2710vvs6uvYZtXYaeG1KdOpUhNZo616/Lc2PoqN56vmyfeCXrPn4r3eWOq/h9
ARC-Seal: i=1; a=rsa-sha256; t=1519217780; cv=none;
        d=google.com; s=arc-20160816;
        b=0cMu5VqGBundI8zK89ynhoZwOuDPO8NvC4w97dU+otVFBdcx4A8J38MTHL5Ezyd5r8
         rfKsN52fa5Q3uI51QNSNdsKaWmM1Ts140sknpZZJswYFgFNykgSpekEgzzLoIUZwP3zx
         vB8yVegluVg2G5NiAGqYLTsmCaJYx+VGgBkm0v+BLACDIz1IN1BiPmohxCZvMhDlYdxc
         fYJqYfVV46u6V5Z0C6Tvq5KlMqS31qyMJnFWH83u7xjNls7r5u5vugvjlJaOU2JkD6NW
         UFZ5CpNB8ZI95CgyN05aNv26DyzUPB4CdLkfYAoOiZOuoLPk9sIjJijQLQfjYT+lhZ1S
         AQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/UGUaKQBJVdfacaI8AZrLnWU1DO8O/tjEOYWZTjQ6Mc=;
        b=iFwalbmD0hsBKDZEpClmKeQ1oq1+qMd38ScPg5JZIXG46vJB9+4FLJnod2cUBLAecm
         z0lABY2G3O8ENBOBDLijlre6QI+k3kzeATrwOzsxWym2+LuRiD2M6kGnzoovoYWiWQ7L
         8uOmopcIf847/K8cY0Pp2S1Xp6/K3p0kg31+xRycWT31xewwrceAUIbtEvwg0MS6bGM4
         8Je05tbHsUc1xd5xh4AtzFJ4K69q7elBJy89MUuxufP5KUl1ftWy+f3E+ENraI36S36I
         emFRGZZUZxvhqA4smVcTIlh8uz03Umui8w81OO5IuRv2H/c3I7yxvNwbS6vdsOamKSyf
         H8nw==
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
Subject: [PATCH 4.9 45/77] ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property
Date: Wed, 21 Feb 2018 13:48:54 +0100
Message-Id: <20180221124434.085414330@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014617824025062?=
X-GMAIL-MSGID: =?utf-8?q?1593015303723452948?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
