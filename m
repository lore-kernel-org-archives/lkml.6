Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2590916-1525773962-2-3969771468880178750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525773962; b=ijroL3P+jQheGRw8npcWb/gJeQLfd2qZx08lbyN+743LI2mmYR
    wRTR5daU15oTMrY6D8ys8jkfbZvek0L4YNagLGcTwmskCzgqtbsZEzm+/l7fmLMY
    Jhlm/BIvVYAVAphsv9DIQ7NrbL1IEh5y+wd+vRyjVCfb7XGs4TU6KO6qxvYlnIyM
    wYl3h8RpA4C9hLFaKzgsjMAmui3ZKvGolpTKU9ujRIE6gGfHydbXVzTQgbm8eY6F
    5zWwQ+nU93zku2sHRQjNew0ynmbFCKAXk4837a/baACADVHObVJgi0XHcHa7S4Wh
    MzeCbLfVMbDBEO4EoegXi0x3J8ZiLB20C51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525773962;
    bh=SFWMmY3NnavFqK2aU1GvkfxI7UJz674yAsKIvwX89Mg=; b=Kjqgh3962W6x
    BN1nnnaLy6Xy2Q8FHhPGpZdHHIddsoeJdpqQCqtUhSqja8WH0RkI2WtjpbsJAPTA
    dXRWYnr0/52nIMFBsQ5CJojg7+0VkCMfQsumfThptI9KS+RYNwzGwHCRdYpELWQR
    7iW5eO5BQSYf8bBQYjQb0gfrRrNojksJcpkjcecV1BxuLsPIES2EK9D+YbZ3XiOu
    XBbBG8T8zUObFfnELe+Yu/qEd/v8ilHx4qQ8C+UqBocl2iELu+4qki1O/DoaYYSq
    4jJHxAo4yrmFqMupC5zaSl2CBPeFc3+y8WZzLZULmNPhsg5a9aw7gLY8pgPYnJwy
    ynV8MM02bA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=pengutronix.de header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=pengutronix.de header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJW7OQnfjqRN5N9lMtO5dBSla2xVfTk789BfBBUW09UupLu/3TMwNw/un9FAxJ2R5TfOnaligWsWieDD064yKe5OqZWPi1NwRTNwl1etd39/nKTNO9pv
    W+hJrjyiWCCsPjXX7hl/NpbwDhSlUZhYsE/bVpNxW0XZuHmfLsFKPeoBV6EPg9n80CJ6VNURMiVmfqlv+FE1u82D3FBzSSnpsTtHuQL+esxIyYBHDHYhM0IQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=Y0EZ_3Me7X8V3HQvQ1AA:9
    a=xm9MyJz92PizenVW:21 a=euw3ciX0XFAIKz-z:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeEHKF6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 06:05:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42435 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754916AbeEHKFz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 May 2018 06:05:55 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc: linux-serial@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-can@vger.kernel.org, kernel@pengutronix.de,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/3] tty: implement led triggers
Date: Tue,  8 May 2018 12:05:43 +0200
Message-Id: <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The rx trigger fires when data is pushed to the ldisc by the driver. This
is a bit later than the actual receiving of data but has the nice benefit
that it doesn't need adaption for each driver and isn't in the hot path.

Similarly the tx trigger fires when data was copied from userspace and is
given to the ldisc.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/imx25-logitech-baby.dts | 192 ++++++++++++++++++++++
 drivers/tty/Kconfig                       |   7 +
 drivers/tty/tty_buffer.c                  |   2 +
 drivers/tty/tty_io.c                      |   3 +
 drivers/tty/tty_port.c                    |  32 +++-
 include/linux/tty.h                       |  22 +++
 6 files changed, 256 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx25-logitech-baby.dts

diff --git a/arch/arm/boot/dts/imx25-logitech-baby.dts b/arch/arm/boot/dts/imx25-logitech-baby.dts
new file mode 100644
index 000000000000..39cf763d228b
--- /dev/null
+++ b/arch/arm/boot/dts/imx25-logitech-baby.dts
@@ -0,0 +1,192 @@
+/dts-v1/;
+#include "imx25.dtsi"
+
+/ {
+	model = "Logitech MX25 Baby";
+	compatible = "logitech,baby", "fsl,imx25";
+
+	chosen {
+		linux,stdout-path = &uart2;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+
+	clock-frequency = <100000>;
+
+	status = "okay";
+
+	codec: tlv320aic3104@18 {
+		compatible = "ti,tlv320aic310x";
+		reg = <0x18>;
+//		HPVDD-supply
+//		SPRVDD-supply
+//		SPLVDD-supply
+//		AVDD-supply
+//		IOVDD-supply
+//		DVDD-supply
+//		?gpio-reset
+//		?ai31xx-micbias-vg
+	};
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+
+	clock-frequency = <100000>;
+
+	status = "okay";
+
+	msp430@10 {
+		reg = <0x10>;
+	};
+};
+
+&iomuxc {
+	baby {
+		pinctrl_fec: fecgrp {
+			fsl,pins = <
+				MX25_PAD_FEC_MDC__FEC_MDC		0x040
+				MX25_PAD_FEC_MDIO__FEC_MDIO		0x1f0
+				MX25_PAD_FEC_TDATA0__FEC_TDATA0		0x040
+				MX25_PAD_FEC_TDATA1__FEC_TDATA1		0x040
+				MX25_PAD_A22__FEC_TDATA2		0x000
+				MX25_PAD_A23__FEC_TDATA3		0x000
+				MX25_PAD_FEC_TX_EN__FEC_TX_EN		0x040
+				MX25_PAD_FEC_RDATA0__FEC_RDATA0		0x0c0
+				MX25_PAD_FEC_RDATA1__FEC_RDATA1		0x0c0
+				MX25_PAD_A20__FEC_RDATA2		0x000
+				MX25_PAD_A21__FEC_RDATA3		0x000
+				MX25_PAD_FEC_RX_DV__FEC_RX_DV		0x0c0
+				MX25_PAD_FEC_TX_CLK__FEC_TX_CLK		0x1c0
+				MX25_PAD_A17__FEC_TX_ERR		0x080
+				MX25_PAD_A19__FEC_RX_ERR		0x080
+				MX25_PAD_A24__FEC_RX_CLK		0x000
+				MX25_PAD_A18__FEC_COL			0x080
+				MX25_PAD_A25__FEC_CRS			0x080
+
+				/*
+				 * PHY_RESET:
+				 * hwref 1: MX25_PIN_A10
+				 * hwref 2: MX25_PIN_CSI_D7
+				 * hwref 3+: MX25_PIN_PWM
+				 */
+				MX25_PAD_PWM__GPIO_1_26			0x0c0
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX25_PAD_I2C1_CLK__I2C1_CLK		0x0a8
+				MX25_PAD_I2C1_DAT__I2C1_DAT		0x0a8
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX25_PAD_GPIO_C__I2C2_SCL		0x0e8
+				MX25_PAD_GPIO_D__I2C2_SDA		0x0a8
+			>;
+		};
+
+		pinctrl_nfc: nfcgrp {
+			fsl,pins = <
+				MX25_PAD_NFRB__NFRB			0x0
+				MX25_PAD_NFWP_B__NFWP_B			0x0
+				MX25_PAD_NFRE_B__NFRE_B			0x0
+				MX25_PAD_NFWE_B__NFWE_B			0x0
+				MX25_PAD_NFALE__NFALE			0x0
+				MX25_PAD_NFCLE__NFCLE			0x0
+				MX25_PAD_NF_CE0__NF_CE0			0x0
+				MX25_PAD_D0__D0				0x0
+				MX25_PAD_D1__D1				0x0
+				MX25_PAD_D2__D2				0x0
+				MX25_PAD_D3__D3				0x0
+				MX25_PAD_D4__D4				0x0
+				MX25_PAD_D5__D5				0x0
+				MX25_PAD_D6__D6				0x0
+				MX25_PAD_D7__D7				0x0
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX25_PAD_UART2_RXD__UART2_RXD	0x1e0
+				MX25_PAD_UART2_TXD__UART2_TXD	0x0e0
+				/*
+				 * These are configured in the vendor kernel,
+				 * but the corresponding lines don't seem to be
+				 * available:
+				 * MX25_PAD_UART2_RTS__UART2_RTS	0x1e0
+				 * MX25_PAD_UART2_CTS__UART2_CTS	0x0e0
+				 */
+			>;
+		};
+	};
+};
+
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec>;
+
+	//phy-reset-gpios = <&gpio1 26 0>;
+	phy-handle = <&ethphy>;
+	phy-mode = "rmii";
+
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <1>;
+			max-speed = <100>;
+		};
+	};
+};
+
+&kpp {
+	linux,keymap = <
+		0x000000cf	/* KEY_PLAY */
+		0x0001004e	/* KEY_KPPLUS */
+		0x00020069	/* KEY_LEFT */
+		0x00030066	/* KEY_HOME */
+		0x0100003b	/* KEY_F1 */
+		0x010100a4	/* KEY_PLAYPAUSE */
+		0x010200a3	/* KEY_NEXTSONG */
+		0x010300a5	/* KEY_PREVIOUSSONG */
+		0x0200003f	/* KEY_F5 */
+		0x0201003e	/* KEY_F4 */
+		0x0202003d	/* KEY_F3 */
+		0x0203003c	/* KEY_F2 */
+		0x03000000	/* KEY_RESERVED */
+		0x03010000	/* KEY_RESERVED */
+		0x0302008e	/* KEY_SLEEP */
+		0x03030040	/* KEY_F6 */
+		>;
+
+	status = "okay";
+};
+
+&nfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nfc>;
+
+	nand-on-flash-bbt;
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+
+	status = "okay";
+};
+
+&uart2 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_uart2>;
+
+        status = "okay";
+};
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 0840d27381ea..b119c0fa1f5a 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -41,6 +41,13 @@ config VT
 	  If unsure, say Y, or else you won't be able to do much with your new
 	  shiny Linux system :-)
 
+config TTY_LEDS_TRIGGERS
+	bool "Enable support for TTY actions making LEDs blink"
+	depends on LEDS_TRIGGERS
+	---help---
+	  This enable support for tty triggers. It provides two LED triggers
+	  (rx and tx) for each TTY.
+
 config CONSOLE_TRANSLATIONS
 	depends on VT
 	default y
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c996b6859c5e..364080ce8e91 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -521,6 +521,8 @@ static void flush_to_ldisc(struct work_struct *work)
 			continue;
 		}
 
+		tty_led_trigger_rx(port);
+
 		count = receive_buf(port, head, count);
 		if (!count)
 			break;
diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7c838b90a31d..8ef597dc0c3d 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -955,6 +955,9 @@ static inline ssize_t do_tty_write(
 		ret = -EFAULT;
 		if (copy_from_user(tty->write_buf, buf, size))
 			break;
+
+		tty_led_trigger_tx(tty->port);
+
 		ret = write(tty, file, tty->write_buf, size);
 		if (ret <= 0)
 			break;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d736880013..d313edfa6315 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -37,6 +37,8 @@ static int tty_port_default_receive_buf(struct tty_port *port,
 
 	ret = tty_ldisc_receive_buf(disc, p, (char *)f, count);
 
+	tty_led_trigger_rx(port);
+
 	tty_ldisc_deref(disc);
 
 	return ret;
@@ -163,8 +165,31 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 		return dev;
 	}
 
-	return tty_register_device_attr(driver, index, device, drvdata,
-			attr_grp);
+	if (IS_ENABLED(CONFIG_TTY_LEDS_TRIGGERS)) {
+		int ret;
+
+		ret = led_trigger_register_format(&port->led_trigger_rx,
+						  "%s%d-rx", driver->name, index);
+		if (ret < 0)
+			pr_warn("Failed to register rx trigger for %s%d (%d)\n",
+				driver->name, index, ret);
+
+		ret = led_trigger_register_format(&port->led_trigger_tx,
+						  "%s%d-tx", driver->name, index);
+		if (ret < 0)
+			pr_warn("Failed to register tx trigger for %s%d (%d)\n",
+				driver->name, index, ret);
+	}
+
+	dev = tty_register_device_attr(driver, index,
+				       device, drvdata, attr_grp);
+
+	if (IS_ENABLED(CONFIG_TTY_LEDS_TRIGGERS) && IS_ERR(dev)) {
+		led_trigger_unregister_simple(port->led_trigger_tx);
+		led_trigger_unregister_simple(port->led_trigger_rx);
+	}
+
+	return dev;
 }
 EXPORT_SYMBOL_GPL(tty_port_register_device_attr_serdev);
 
@@ -206,6 +231,9 @@ void tty_port_unregister_device(struct tty_port *port,
 	if (ret == 0)
 		return;
 
+	led_trigger_unregister_simple(port->led_trigger_rx);
+	led_trigger_unregister_simple(port->led_trigger_tx);
+
 	tty_unregister_device(driver, index);
 }
 EXPORT_SYMBOL_GPL(tty_port_unregister_device);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1dd587ba6d88..7e48de671bfa 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -13,6 +13,7 @@
 #include <uapi/linux/tty.h>
 #include <linux/rwsem.h>
 #include <linux/llist.h>
+#include <linux/leds.h>
 
 
 /*
@@ -249,8 +250,29 @@ struct tty_port {
 						   set to size of fifo */
 	struct kref		kref;		/* Ref counter */
 	void 			*client_data;
+
+	struct led_trigger	*led_trigger_rx;
+	struct led_trigger	*led_trigger_tx;
 };
 
+static inline void tty_led_trigger(struct led_trigger *trig)
+{
+	unsigned long delay_ms = 50;
+
+	if (IS_ENABLED(CONFIG_TTY_LEDS_TRIGGERS))
+		led_trigger_blink_oneshot(trig, &delay_ms, &delay_ms, 0);
+}
+
+static inline void tty_led_trigger_rx(struct tty_port *port)
+{
+	tty_led_trigger(port->led_trigger_rx);
+}
+
+static inline void tty_led_trigger_tx(struct tty_port *port)
+{
+	tty_led_trigger(port->led_trigger_tx);
+}
+
 /* tty_port::iflags bits -- use atomic bit ops */
 #define TTY_PORT_INITIALIZED	0	/* device is initialized */
 #define TTY_PORT_SUSPENDED	1	/* device is suspended */
-- 
2.17.0

