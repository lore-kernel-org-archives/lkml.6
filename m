Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49oo00tUdPctv3clUvF0hYBgDAWcaRnnAmr1rkfvCY4qRq6xqbhRr0OMY2WhPGO14Bn4fT3
ARC-Seal: i=1; a=rsa-sha256; t=1523021920; cv=none;
        d=google.com; s=arc-20160816;
        b=zvw109UgyKOqTWuEaOFpEGoG/gmEVL68mLY39TTFsAnLJWhyE+hSMzEawcJOZso4qj
         KVK/5UpUWmNAZoTf0QcUPzHVWzF2yQTp2BH0eEL1nYTIu078hQsf991J00UfghQihX89
         8DKs+R7auoXuC+o27nUtK6NFP0mP0pgr+S9ROO+ccvSWfjt34Y0RJDUx1/fIaxwrDKPv
         SYZuVHej7ExCjoo4/2OvQbfhlYjlXpD8sQ49roaC3npcMNuArImLXgkRW4uYabDEfaT+
         bYEAAbeKrx+3zyfId76HWPBODV71l0tW2LOCYDnSu7IlZtW9ultimGYlS7kngV+q+4xr
         2Fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=D3JXm4e8ev5ndaIVAUneztJdmbLU6XXcwbG0bMNcVZo=;
        b=MnVbJelSayLCBBLu+psdgkqYPuSVFexkwpaClRJFR0rFbeFRB/qFpxMCz2RrdHl8SS
         ehGBk+vZz2KgzcwtgbOh3GtAktv+gUAG6aWXx7Wh12DiJHsrNIZBwF+XSYmtuH8yGds8
         BXu9Iv7i+SG3OgObPimNgkYRrbX6TD377c2sg9LN9fOgVOhEawfRC5uIkUKHoE/h9qfk
         DqhB3y075AF9Txtm5nm0qq+iO8b1cYYFXoiKpvL2AQuwIhnDmfdpJYS3+umXVsCcHPpC
         jSQVpUffEJ/N/jyfDIiSoIE+XcRV5zSy9Zgy5HWhVI9n8ExQFeTL1lbh7f6N5q59Q8Jw
         gINQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Philipp Rossak <embed3d@gmail.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4.14 04/67] ARM: dts: sun6i: a31s: bpi-m2: add missing regulators
Date: Fri,  6 Apr 2018 15:23:34 +0200
Message-Id: <20180406084341.839604476@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004233968755330?=
X-GMAIL-MSGID: =?utf-8?q?1597004233968755330?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Philipp Rossak <embed3d@gmail.com>

commit 70b8d21496758dd7ff600ec9de0ee3812fac7a40 upstream.

This patch fixes a bootproblem with the Bananapi M2 board. Since there
are some regulators missing we add them right now. Those values come
from the schematic, below you can find a small overview:

* reg_aldo1:  3,3V, powers the wifi
* reg_aldo2:  2,5V, powers the IO of the RTL8211E
* reg_aldo3:  3,3V, powers the audio

* reg_dldo1:  3,0V, powers the RTL8211E
* reg_dldo2:  2,8V, powers the analog part of the csi
* reg_dldo3:  3,3V, powers misc
* reg_eldo1:  1,8V, powers the csi
* reg_ldo_io1:1,8V, powers the gpio

* reg_dc5ldo: needs to be always on

This patch updates also the vmmc-supply properties on the mmc0 and mmc2
node to use the allready existent regulators.
We can now remove the sunxi-common-regulators.dtsi include since we
don't need it anymore.

Fixes: 7daa21370075 ("ARM: dts: sunxi: Add regulators for Sinovoip BPI-M2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts |   61 +++++++++++++++++++++--
 1 file changed, 58 insertions(+), 3 deletions(-)

--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -42,7 +42,6 @@
 
 /dts-v1/;
 #include "sun6i-a31s.dtsi"
-#include "sunxi-common-regulators.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
 / {
@@ -99,6 +98,7 @@
 	pinctrl-0 = <&gmac_pins_rgmii_a>, <&gmac_phy_reset_pin_bpi_m2>;
 	phy = <&phy1>;
 	phy-mode = "rgmii";
+	phy-supply = <&reg_dldo1>;
 	snps,reset-gpio = <&pio 0 21 GPIO_ACTIVE_HIGH>; /* PA21 */
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 30000>;
@@ -118,7 +118,7 @@
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_bpi_m2>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_dcdc1>;
 	bus-width = <4>;
 	cd-gpios = <&pio 0 4 GPIO_ACTIVE_HIGH>; /* PA4 */
 	cd-inverted;
@@ -132,7 +132,7 @@
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_a>;
-	vmmc-supply = <&reg_vcc3v0>;
+	vmmc-supply = <&reg_aldo1>;
 	mmc-pwrseq = <&mmc2_pwrseq>;
 	bus-width = <4>;
 	non-removable;
@@ -195,7 +195,28 @@
 
 #include "axp22x.dtsi"
 
+&reg_aldo1 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi";
+};
+
+&reg_aldo2 {
+	regulator-always-on;
+	regulator-min-microvolt = <2500000>;
+	regulator-max-microvolt = <2500000>;
+	regulator-name = "vcc-gmac";
+};
+
+&reg_aldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "avcc";
+};
+
 &reg_dc5ldo {
+	regulator-always-on;
 	regulator-min-microvolt = <700000>;
 	regulator-max-microvolt = <1320000>;
 	regulator-name = "vdd-cpus";
@@ -235,6 +256,40 @@
 	regulator-name = "vcc-dram";
 };
 
+&reg_dldo1 {
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+	regulator-name = "vcc-mac";
+};
+
+&reg_dldo2 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "avdd-csi";
+};
+
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-pb";
+};
+
+&reg_eldo1 {
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vdd-csi";
+	status = "okay";
+};
+
+&reg_ldo_io1 {
+	regulator-always-on;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+	regulator-name = "vcc-pm-cpus";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
