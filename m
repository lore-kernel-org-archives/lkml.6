Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B4BECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E9E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pados.hu header.i=@pados.hu header.b="MCnr8gOn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E9E206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=pados.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbeGTNX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:23:56 -0400
Received: from erza.pados.hu ([176.9.136.194]:42220 "EHLO erza.pados.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732791AbeGTNX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pados.hu;
         s=february2016; h=References:In-Reply-To:Cc:To:Subject:Message-ID:From:
        Content-Transfer-Encoding:Content-Type:Date:MIME-Version:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kv9s+l5mc1qWqIikC/nbtLXWqweCYueqxndmmUZ7BC0=; b=MCnr8gOn2QF/ndGQNgtEwQ00FC
        3STQ+9UxeIBaZUou7NkKFwdELQrQNzTo7ilqVePK+iJPUBtw9ezcMxTDUfciz63L80OULD1d7tH3d
        Dfd3doHICAvNg9beKiK9dVLIfBwv7AsqTP5nUhTWLkBBbtqyFrWxuF330but5Eh4qCUQ+aElOK89D
        MvQR2FcdLxXKWvqfxssllT4TCD1ihUy2OeQzEA8PkEW48qcx8gEaKFJFMRFeY/6Mq5wQfPTCHWOTy
        tKRONGKvmd4p80zz7MBy/Y3sYnId0V86317rncx7O9sQA4F+lzPbCDkLD8QuTfGe/ResNKuhRC+jy
        P0Ul6NWw==;
Received: from localhost ([127.0.0.1] helo=webmail.pados.hu)
        by erza with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <pados@pados.hu>)
        id 1fgUdK-00031O-UO; Fri, 20 Jul 2018 14:35:49 +0200
MIME-Version: 1.0
Date:   Fri, 20 Jul 2018 12:35:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: RainLoop/1.12.0
From:   "Karoly Pados" <pados@pados.hu>
Message-ID: <444431dd30f45f753644e2ea80dbe0c0@pados.hu>
Subject: [PATCH v4] USB: serial: cp210x: Implement GPIO support for
 CP2102N
To:     "Johan Hovold" <johan@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Martyn Welch" <martyn.welch@collabora.co.uk>
In-Reply-To: <20180720105240.24680-1-johan@kernel.org>
References: <20180720105240.24680-1-johan@kernel.org>
X-Spam_score: -2.9
X-Spam_report: Spam detection software, running on the system "erza",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  This patch adds GPIO support for CP2102N devices. It introduces
    new generic code to support emulating separate input and outputs directions
    even though these devices only know output modes (open-drain and pushpull).
    Existing GPIO support for CP2105 has been migrated over to the new code structure.
    [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
  0.0 URIBL_BLOCKED          ADMINISTRATOR NOTICE: The query to URIBL was blocked.
                             See
                             http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
                              for more information.
                             [URIs: silabs.com]
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds GPIO support for CP2102N devices.=0A=0AIt introduces new =
generic code to support emulating separate=0Ainput and outputs directions=
 even though these devices=0Aonly know output modes (open-drain and pushp=
ull). Existing=0AGPIO support for CP2105 has been migrated over to the ne=
w=0Acode structure.=0A=0AOnly limitation is that for the QFN28 variant, o=
nly 4 out of=0A7 GPIOs are supported. This is because the config array=0A=
locations of the last 3 pins are not documented, and reverse=0Aengineerin=
g revealed offsets that conflicted with other=0Adocumented functions. Hen=
ce we'll play it safe instead=0Auntil somebody clears this up further.=0A=
=0ASigned-off-by: Karoly Pados <pados@pados.hu>=0A---=0A=0APatch changelo=
g:=0Av1: Initial implementation.=0Av2: Incorporate Johan's feedback, most=
 importantly generalize=0A    new code and unify with CP2105.=0Av3 (by Jo=
han): Apply stylistic and minor bug fixes.=0Av4: Corrected commit message=
. No code changes.=0A=0A=0A drivers/usb/serial/cp210x.c | 245 +++++++++++=
+++++++++++++++++++------=0A 1 file changed, 209 insertions(+), 36 deleti=
ons(-)=0A=0Adiff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial=
/cp210x.c=0Aindex 4a118eb13590..b9bc80700be7 100644=0A--- a/drivers/usb/s=
erial/cp210x.c=0A+++ b/drivers/usb/serial/cp210x.c=0A@@ -224,9 +224,10 @@=
 MODULE_DEVICE_TABLE(usb, id_table);=0A struct cp210x_serial_private {=0A=
 #ifdef CONFIG_GPIOLIB=0A 	struct gpio_chip	gc;=0A-	u8			config;=0A-	u8		=
	gpio_mode;=0A 	bool			gpio_registered;=0A+	u8			gpio_pushpull;=0A+	u8			=
gpio_altfunc;=0A+	u8			gpio_input;=0A #endif=0A 	u8			partnum;=0A 	speed_=
t			max_speed;=0A@@ -343,6 +344,7 @@ static struct usb_serial_driver * co=
nst serial_drivers[] =3D {=0A #define CONTROL_WRITE_RTS	0x0200=0A =0A /* =
CP210X_VENDOR_SPECIFIC values */=0A+#define CP210X_READ_2NCONFIG	0x000E=
=0A #define CP210X_READ_LATCH	0x00C2=0A #define CP210X_GET_PARTNUM	0x370B=
=0A #define CP210X_GET_PORTCONFIG	0x370C=0A@@ -452,6 +454,12 @@ struct cp=
210x_config {=0A #define CP2105_GPIO1_RXLED_MODE		BIT(1)=0A #define CP210=
5_GPIO1_RS485_MODE		BIT(2)=0A =0A+/* CP2102N configuration array indices =
*/=0A+#define CP210X_2NCONFIG_CONFIG_VERSION_IDX	2=0A+#define CP210X_2NCO=
NFIG_GPIO_MODE_IDX		581=0A+#define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587=
=0A+#define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600=0A+=0A /* CP210X_VENDOR_=
SPECIFIC, CP210X_WRITE_LATCH call writes these 0x2 bytes. */=0A struct cp=
210x_gpio_write {=0A 	u8	mask;=0A@@ -1313,17 +1321,8 @@ static int cp210x=
_gpio_request(struct gpio_chip *gc, unsigned int offset)=0A 	struct usb_s=
erial *serial =3D gpiochip_get_data(gc);=0A 	struct cp210x_serial_private=
 *priv =3D usb_get_serial_data(serial);=0A =0A-	switch (offset) {=0A-	cas=
e 0:=0A-		if (priv->config & CP2105_GPIO0_TXLED_MODE)=0A-			return -ENODE=
V;=0A-		break;=0A-	case 1:=0A-		if (priv->config & (CP2105_GPIO1_RXLED_MO=
DE |=0A-				    CP2105_GPIO1_RS485_MODE))=0A-			return -ENODEV;=0A-		brea=
k;=0A-	}=0A+	if (priv->gpio_altfunc & BIT(offset))=0A+		return -ENODEV;=
=0A =0A 	return 0;=0A }=0A@@ -1331,10 +1330,15 @@ static int cp210x_gpio_=
request(struct gpio_chip *gc, unsigned int offset)=0A static int cp210x_g=
pio_get(struct gpio_chip *gc, unsigned int gpio)=0A {=0A 	struct usb_seri=
al *serial =3D gpiochip_get_data(gc);=0A+	struct cp210x_serial_private *p=
riv =3D usb_get_serial_data(serial);=0A+	u8 req_type =3D REQTYPE_DEVICE_T=
O_HOST;=0A 	int result;=0A 	u8 buf;=0A =0A-	result =3D cp210x_read_vendor=
_block(serial, REQTYPE_INTERFACE_TO_HOST,=0A+	if (priv->partnum =3D=3D CP=
210X_PARTNUM_CP2105)=0A+		req_type =3D REQTYPE_INTERFACE_TO_HOST;=0A+=0A+=
	result =3D cp210x_read_vendor_block(serial, req_type,=0A 					  CP210X_R=
EAD_LATCH, &buf, sizeof(buf));=0A 	if (result < 0)=0A 		return result;=0A=
@@ -1345,7 +1349,9 @@ static int cp210x_gpio_get(struct gpio_chip *gc, un=
signed int gpio)=0A static void cp210x_gpio_set(struct gpio_chip *gc, uns=
igned int gpio, int value)=0A {=0A 	struct usb_serial *serial =3D gpiochi=
p_get_data(gc);=0A+	struct cp210x_serial_private *priv =3D usb_get_serial=
_data(serial);=0A 	struct cp210x_gpio_write buf;=0A+	int result;=0A =0A 	=
if (value =3D=3D 1)=0A 		buf.state =3D BIT(gpio);=0A@@ -1354,25 +1360,68 =
@@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, i=
nt value)=0A =0A 	buf.mask =3D BIT(gpio);=0A =0A-	cp210x_write_vendor_blo=
ck(serial, REQTYPE_HOST_TO_INTERFACE,=0A-				  CP210X_WRITE_LATCH, &buf, =
sizeof(buf));=0A+	if (priv->partnum =3D=3D CP210X_PARTNUM_CP2105) {=0A+		=
result =3D cp210x_write_vendor_block(serial,=0A+						   REQTYPE_HOST_TO_=
INTERFACE,=0A+						   CP210X_WRITE_LATCH, &buf,=0A+						   sizeof(buf))=
;=0A+	} else {=0A+		u16 wIndex =3D buf.state << 8 | buf.mask;=0A+=0A+		re=
sult =3D usb_control_msg(serial->dev,=0A+					 usb_sndctrlpipe(serial->de=
v, 0),=0A+					 CP210X_VENDOR_SPECIFIC,=0A+					 REQTYPE_HOST_TO_DEVICE,=
=0A+					 CP210X_WRITE_LATCH,=0A+					 wIndex,=0A+					 NULL, 0, USB_CTRL=
_SET_TIMEOUT);=0A+	}=0A+=0A+	if (result < 0) {=0A+		dev_err(&serial->inte=
rface->dev, "failed to set GPIO value: %d\n",=0A+				result);=0A+	}=0A }=
=0A =0A static int cp210x_gpio_direction_get(struct gpio_chip *gc, unsign=
ed int gpio)=0A {=0A-	/* Hardware does not support an input mode */=0A-	r=
eturn 0;=0A+	struct usb_serial *serial =3D gpiochip_get_data(gc);=0A+	str=
uct cp210x_serial_private *priv =3D usb_get_serial_data(serial);=0A+=0A+	=
return priv->gpio_input & BIT(gpio);=0A }=0A =0A static int cp210x_gpio_d=
irection_input(struct gpio_chip *gc, unsigned int gpio)=0A {=0A-	/* Hardw=
are does not support an input mode */=0A-	return -ENOTSUPP;=0A+	struct us=
b_serial *serial =3D gpiochip_get_data(gc);=0A+	struct cp210x_serial_priv=
ate *priv =3D usb_get_serial_data(serial);=0A+=0A+	if (priv->partnum =3D=
=3D CP210X_PARTNUM_CP2105) {=0A+		/* hardware does not support an input m=
ode */=0A+		return -ENOTSUPP;=0A+	}=0A+=0A+	/* push-pull pins cannot be c=
hanged to be inputs */=0A+	if (priv->gpio_pushpull & BIT(gpio))=0A+		retu=
rn -EINVAL;=0A+=0A+	/* make sure to release pin if it is being driven low=
 */=0A+	cp210x_gpio_set(gc, gpio, 1);=0A+=0A+	priv->gpio_input |=3D BIT(g=
pio);=0A+=0A+	return 0;=0A }=0A =0A static int cp210x_gpio_direction_outp=
ut(struct gpio_chip *gc, unsigned int gpio,=0A 					int value)=0A {=0A+	s=
truct usb_serial *serial =3D gpiochip_get_data(gc);=0A+	struct cp210x_ser=
ial_private *priv =3D usb_get_serial_data(serial);=0A+=0A+	priv->gpio_inp=
ut &=3D ~BIT(gpio);=0A+	cp210x_gpio_set(gc, gpio, value);=0A+=0A 	return =
0;=0A }=0A =0A@@ -1385,11 +1434,11 @@ static int cp210x_gpio_set_config(s=
truct gpio_chip *gc, unsigned int gpio,=0A =0A 	/* Succeed only if in cor=
rect mode (this can't be set at runtime) */=0A 	if ((param =3D=3D PIN_CON=
FIG_DRIVE_PUSH_PULL) &&=0A-	    (priv->gpio_mode & BIT(gpio)))=0A+	    (p=
riv->gpio_pushpull & BIT(gpio)))=0A 		return 0;=0A =0A 	if ((param =3D=3D=
 PIN_CONFIG_DRIVE_OPEN_DRAIN) &&=0A-	    !(priv->gpio_mode & BIT(gpio)))=
=0A+	    !(priv->gpio_pushpull & BIT(gpio)))=0A 		return 0;=0A =0A 	retur=
n -ENOTSUPP;=0A@@ -1402,12 +1451,13 @@ static int cp210x_gpio_set_config(=
struct gpio_chip *gc, unsigned int gpio,=0A  * this driver that provide G=
PIO do so in a way that does not impact other=0A  * signals and are thus =
expected to have very different initialisation.=0A  */=0A-static int cp21=
05_shared_gpio_init(struct usb_serial *serial)=0A+static int cp2105_gpioc=
onf_init(struct usb_serial *serial)=0A {=0A 	struct cp210x_serial_private=
 *priv =3D usb_get_serial_data(serial);=0A 	struct cp210x_pin_mode mode;=
=0A 	struct cp210x_config config;=0A 	u8 intf_num =3D cp210x_interface_nu=
m(serial);=0A+	u8 iface_config;=0A 	int result;=0A =0A 	result =3D cp210x=
_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,=0A@@ -1424,20 +1474,26=
 @@ static int cp2105_shared_gpio_init(struct usb_serial *serial)=0A =0A =
	/*  2 banks of GPIO - One for the pins taken from each serial port */=0A=
 	if (intf_num =3D=3D 0) {=0A-		if (mode.eci =3D=3D CP210X_PIN_MODE_MODEM=
)=0A+		if (mode.eci =3D=3D CP210X_PIN_MODE_MODEM) {=0A+			/* mark all GPI=
Os of this interface as reserved */=0A+			priv->gpio_altfunc =3D 0xff;=0A=
 			return 0;=0A+		}=0A =0A-		priv->config =3D config.eci_cfg;=0A-		priv-=
>gpio_mode =3D (u8)((le16_to_cpu(config.gpio_mode) &=0A+		iface_config =
=3D config.eci_cfg;=0A+		priv->gpio_pushpull =3D (u8)((le16_to_cpu(config=
.gpio_mode) &=0A 						CP210X_ECI_GPIO_MODE_MASK) >>=0A 						CP210X_ECI_=
GPIO_MODE_OFFSET);=0A 		priv->gc.ngpio =3D 2;=0A 	} else if (intf_num =3D=
=3D 1) {=0A-		if (mode.sci =3D=3D CP210X_PIN_MODE_MODEM)=0A+		if (mode.sc=
i =3D=3D CP210X_PIN_MODE_MODEM) {=0A+			/* mark all GPIOs of this interfa=
ce as reserved */=0A+			priv->gpio_altfunc =3D 0xff;=0A 			return 0;=0A+	=
	}=0A =0A-		priv->config =3D config.sci_cfg;=0A-		priv->gpio_mode =3D (u8=
)((le16_to_cpu(config.gpio_mode) &=0A+		iface_config =3D config.sci_cfg;=
=0A+		priv->gpio_pushpull =3D (u8)((le16_to_cpu(config.gpio_mode) &=0A 		=
				CP210X_SCI_GPIO_MODE_MASK) >>=0A 						CP210X_SCI_GPIO_MODE_OFFSET);=
=0A 		priv->gc.ngpio =3D 3;=0A@@ -1445,6 +1501,125 @@ static int cp2105_s=
hared_gpio_init(struct usb_serial *serial)=0A 		return -ENODEV;=0A 	}=0A =
=0A+	/* mark all pins which are not in GPIO mode */=0A+	if (iface_config =
& CP2105_GPIO0_TXLED_MODE)	/* GPIO 0 */=0A+		priv->gpio_altfunc |=3D BIT(=
0);=0A+	if (iface_config & (CP2105_GPIO1_RXLED_MODE |	/* GPIO 1 */=0A+			=
CP2105_GPIO1_RS485_MODE))=0A+		priv->gpio_altfunc |=3D BIT(1);=0A+=0A+	/*=
 driver implementation for CP2105 only supports outputs */=0A+	priv->gpio=
_input =3D 0;=0A+=0A+	return 0;=0A+}=0A+=0A+static int cp2102n_gpioconf_i=
nit(struct usb_serial *serial)=0A+{=0A+	struct cp210x_serial_private *pri=
v =3D usb_get_serial_data(serial);=0A+	const u16 config_size =3D 0x02a6;=
=0A+	u8 gpio_rst_latch;=0A+	u8 config_version;=0A+	u8 gpio_pushpull;=0A+	=
u8 *config_buf;=0A+	u8 gpio_latch;=0A+	u8 gpio_ctrl;=0A+	int result;=0A+	=
u8 i;=0A+=0A+	/*=0A+	 * Retrieve device configuration from the device.=0A=
+	 * The array received contains all customization settings done at the=
=0A+	 * factory/manufacturer. Format of the array is documented at the=0A=
+	 * time of writing at:=0A+	 * https://www.silabs.com/community/interfac=
e/knowledge-base.entry.html/2017/03/31/cp2102n_setconfig-xsfa=0A+	 */=0A+=
	config_buf =3D kmalloc(config_size, GFP_KERNEL);=0A+	if (!config_buf)=0A=
+		return -ENOMEM;=0A+=0A+	result =3D cp210x_read_vendor_block(serial,=0A=
+					  REQTYPE_DEVICE_TO_HOST,=0A+					  CP210X_READ_2NCONFIG,=0A+					 =
 config_buf,=0A+					  config_size);=0A+	if (result < 0) {=0A+		kfree(con=
fig_buf);=0A+		return result;=0A+	}=0A+=0A+	config_version =3D config_buf=
[CP210X_2NCONFIG_CONFIG_VERSION_IDX];=0A+	gpio_pushpull =3D config_buf[CP=
210X_2NCONFIG_GPIO_MODE_IDX];=0A+	gpio_ctrl =3D config_buf[CP210X_2NCONFI=
G_GPIO_CONTROL_IDX];=0A+	gpio_rst_latch =3D config_buf[CP210X_2NCONFIG_GP=
IO_RSTLATCH_IDX];=0A+=0A+	kfree(config_buf);=0A+=0A+	/* Make sure this is=
 a config format we understand. */=0A+	if (config_version !=3D 0x01)=0A+	=
	return -ENOTSUPP;=0A+=0A+	/*=0A+	 * We only support 4 GPIOs even on the =
QFN28 package, because=0A+	 * config locations of GPIOs 4-6 determined us=
ing reverse=0A+	 * engineering revealed conflicting offsets with other=0A=
+	 * documented functions. So we'll just play it safe for now.=0A+	 */=0A=
+	priv->gc.ngpio =3D 4;=0A+=0A+	/*=0A+	 * Get default pin states after re=
set. Needed so we can determine=0A+	 * the direction of an open-drain pin=
.=0A+	 */=0A+	gpio_latch =3D (gpio_rst_latch >> 3) & 0x0f;=0A+=0A+	/* 0 i=
ndicates open-drain mode, 1 is push-pull */=0A+	priv->gpio_pushpull =3D (=
gpio_pushpull >> 3) & 0x0f;=0A+=0A+	/* 0 indicates GPIO mode, 1 is altern=
ate function */=0A+	priv->gpio_altfunc =3D (gpio_ctrl >> 2) & 0x0f;=0A+=
=0A+	/*=0A+	 * The CP2102N does not strictly has input and output pin mod=
es,=0A+	 * it only knows open-drain and push-pull modes which is set at=
=0A+	 * factory. An open-drain pin can function both as an=0A+	 * input o=
r an output. We emulate input mode for open-drain pins=0A+	 * by making s=
ure they are not driven low, and we do not allow=0A+	 * push-pull pins to=
 be set as an input.=0A+	 */=0A+	for (i =3D 0; i < priv->gc.ngpio; ++i) {=
=0A+		/*=0A+		 * Set direction to "input" iff pin is open-drain and reset=
=0A+		 * value is 1.=0A+		 */=0A+		if (!(priv->gpio_pushpull & BIT(i)) &&=
 (gpio_latch & BIT(i)))=0A+			priv->gpio_input |=3D BIT(i);=0A+	}=0A+=0A+=
	return 0;=0A+}=0A+=0A+static int cp210x_gpio_init(struct usb_serial *ser=
ial)=0A+{=0A+	struct cp210x_serial_private *priv =3D usb_get_serial_data(=
serial);=0A+	int result;=0A+=0A+	switch (priv->partnum) {=0A+	case CP210X=
_PARTNUM_CP2105:=0A+		result =3D cp2105_gpioconf_init(serial);=0A+		break=
;=0A+	case CP210X_PARTNUM_CP2102N_QFN28:=0A+	case CP210X_PARTNUM_CP2102N_=
QFN24:=0A+	case CP210X_PARTNUM_CP2102N_QFN20:=0A+		result =3D cp2102n_gpi=
oconf_init(serial);=0A+		break;=0A+	default:=0A+		return 0;=0A+	}=0A+=0A+=
	if (result < 0)=0A+		return result;=0A+=0A 	priv->gc.label =3D "cp210x";=
=0A 	priv->gc.request =3D cp210x_gpio_request;=0A 	priv->gc.get_direction=
 =3D cp210x_gpio_direction_get;=0A@@ -1477,7 +1652,7 @@ static void cp210=
x_gpio_remove(struct usb_serial *serial)=0A =0A #else=0A =0A-static int c=
p2105_shared_gpio_init(struct usb_serial *serial)=0A+static int cp210x_gp=
io_init(struct usb_serial *serial)=0A {=0A 	return 0;=0A }=0A@@ -1588,12 =
+1763,10 @@ static int cp210x_attach(struct usb_serial *serial)=0A =0A 	c=
p210x_init_max_speed(serial);=0A =0A-	if (priv->partnum =3D=3D CP210X_PAR=
TNUM_CP2105) {=0A-		result =3D cp2105_shared_gpio_init(serial);=0A-		if (=
result < 0) {=0A-			dev_err(&serial->interface->dev,=0A-				"GPIO initial=
isation failed, continuing without GPIO support\n");=0A-		}=0A+	result =
=3D cp210x_gpio_init(serial);=0A+	if (result < 0) {=0A+		dev_err(&serial-=
>interface->dev, "GPIO initialisation failed: %d\n",=0A+				result);=0A 	=
}=0A =0A 	return 0;=0A-- =0A2.18.0
