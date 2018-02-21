Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225aLIuwmZAsBbP3Du+qTAIt0LVxakX9g9NncZ54z7Ck0Uksw+eRBnZDjVDUC9kbY62qf30V
ARC-Seal: i=1; a=rsa-sha256; t=1519218407; cv=none;
        d=google.com; s=arc-20160816;
        b=rXdwJaiWMquhFue2j8f8TkcW4fNJsrqFCVx9Rpwqj1EnEF6tnrtK934E2VJnACxLl6
         BY8n7NewBHdGTDezzZRqFEi2HGvdOJVF2RvMOBKe9eCoBQKlmhO78DtgBFHx4b4tc6L7
         mtGI1eL49SryQ6Pvvnl6oMXKZgmxrcc7Euuep6s09qpnU/KJbnBLcnr/6blZJ9408KmN
         RkqKwnDgUkyREmAnmInce8Vr3vSyaq0NKTtUOroGIz8NxSABPsajgS80BQtNxEuJeLV3
         sq7uyIVaubElQWy9o/J5i9al86SyR+crZuedMOAMM/IaR/xKrgl4HWw6ZoDA0UKZZZ33
         k4iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kpYwOq1EGQ99ZtWMpvbpSf9+J0yJnxIQmGEsI8gygMo=;
        b=lrUkA2F54pYDt6uKYdJ6Vt8hkfelijjJnh9cfmFyPqkkoNeDNma94rB1pNvu3l2D8h
         pBW+3yVRtiwIhoALgiLO0W0jm5XymcsA2fKoJobxdKaI/RjSbKoPpfuhs7zVP6a/J3mw
         NwC69ZIO2Tqe3aGGqRj/1t7gIiJXPX3C+sy/dmfnydGSyMYbO9QaZetPF9fNcjp7qHP9
         ruCGE6LEgFveEU4+bNOz3wKTxKFKXROYLCxwrVf3boYX3CFtbNAcDBlusUg/+Vl3yGw9
         nCY2Neva3lv/SW2UcszDg8JgaRVRwibMVAytke+IQFeRZeBkFz50nkRsUou2NwsdWI4B
         OcRQ==
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
Subject: [PATCH 4.15 029/163] ARM: dts: STi: Add gpio polarity for "hdmi,hpd-gpio" property
Date: Wed, 21 Feb 2018 13:47:38 +0100
Message-Id: <20180221124531.837506596@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014617824025062?=
X-GMAIL-MSGID: =?utf-8?q?1593015960841738962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
