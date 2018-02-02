Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227GDHq/k558QWXEYYzN0OC7sy7VT49FrEx7uPVuoAbstYL2+7gc/YgkiKhzVuAkJiZ3Yu9F
ARC-Seal: i=1; a=rsa-sha256; t=1517591773; cv=none;
        d=google.com; s=arc-20160816;
        b=OlVX3dNE8KqCpg0htamffMgS8r3B+KwbphUF+k2IM08OsMsXka2FiqYbK+HoBosoP4
         1AS0NktC4wuV91O8iVUBUaO9gUCN4UTCDyXXsqmiDMqrP4Zd/fb6IbTNYI4O8n7ELy97
         ElvnkTsI9TeaokKudKoyEOXH5Vx4fFOEV6BMFoY2vKsrVIWoQl4xTPpBJrJkzntr98Gy
         PLroVjrlhmIuRO+eChyDy6uTI1MvSTjQvLSqp2SV5M4E76Fe6MPQ8nvGAxiEK8ZYG3sN
         MXdWcbviygEk/jK2pvUmMlndmXklx8QPS0ryftAGlMHY6caaB1GVY4xmd4ci2XN2+xBu
         mVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/3rVBo2hp4npXTBkNHOM8o6ziOrLThTJA0xG0p10lW0=;
        b=GkBOoteHDdH/QC2IMrUVnYkWcw6PufA3jUn5Zdj2sgjypIHeVWeHwyJMa5V0joxJo/
         Xc5CS/XHT/MEpgUebFad6cdElstXKErRTW7Kyi6mu/TKgDX14yTGxO/4SrwfXTwXzmM3
         Wm82nR3KhflOQ6zz2cZbiaQ81Lu+9AXs+JCcjrmYxp3zFRd2YlvRxsfHsp/zLf1Cp2Xk
         IpjFJHEi+fj2b4u/JpgzNaNhJGfp4hYNB9lzuBk4ywhYNShHyQKa1eKjKh3gv3RgOdoC
         gXmD3hwsBOrFLRoLXeYb2LEbqnNQvRV1yOkrjbR9qnmfpmXR8USl1WJ0cJ9v2rHrGMn/
         7dxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Max Schulze <max.schulze@posteo.de>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.15 38/55] USB: serial: simple: add Motorola Tetra driver
Date: Fri,  2 Feb 2018 17:58:56 +0100
Message-Id: <20180202140829.916706581@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309449263095125?=
X-GMAIL-MSGID: =?utf-8?q?1591310311683118454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 46fe895e22ab3845515ec06b01eaf1282b342e29 upstream.

Add new Motorola Tetra (simple) driver for Motorola Solutions TETRA PEI
devices.

D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0cad ProdID=9011 Rev=24.16
S:  Manufacturer=Motorola Solutions Inc.
S:  Product=Motorola Solutions TETRA PEI interface
C:  #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=500mA
I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
I:  If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)

Note that these devices do not support the CDC SET_CONTROL_LINE_STATE
request (for any interface).

Reported-by: Max Schulze <max.schulze@posteo.de>
Tested-by: Max Schulze <max.schulze@posteo.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/Kconfig             |    1 +
 drivers/usb/serial/usb-serial-simple.c |    7 +++++++
 2 files changed, 8 insertions(+)

--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -63,6 +63,7 @@ config USB_SERIAL_SIMPLE
 		- Google USB serial devices
 		- HP4x calculators
 		- a number of Motorola phones
+		- Motorola Tetra devices
 		- Novatel Wireless GPS receivers
 		- Siemens USB/MPI adapter.
 		- ViVOtech ViVOpay USB device.
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -77,6 +77,11 @@ DEVICE(vivopay, VIVOPAY_IDS);
 	{ USB_DEVICE(0x22b8, 0x2c64) }	/* Motorola V950 phone */
 DEVICE(moto_modem, MOTO_IDS);
 
+/* Motorola Tetra driver */
+#define MOTOROLA_TETRA_IDS()			\
+	{ USB_DEVICE(0x0cad, 0x9011) }	/* Motorola Solutions TETRA PEI */
+DEVICE(motorola_tetra, MOTOROLA_TETRA_IDS);
+
 /* Novatel Wireless GPS driver */
 #define NOVATEL_IDS()			\
 	{ USB_DEVICE(0x09d7, 0x0100) }	/* NovAtel FlexPack GPS */
@@ -107,6 +112,7 @@ static struct usb_serial_driver * const
 	&google_device,
 	&vivopay_device,
 	&moto_modem_device,
+	&motorola_tetra_device,
 	&novatel_gps_device,
 	&hp4x_device,
 	&suunto_device,
@@ -122,6 +128,7 @@ static const struct usb_device_id id_tab
 	GOOGLE_IDS(),
 	VIVOPAY_IDS(),
 	MOTO_IDS(),
+	MOTOROLA_TETRA_IDS(),
 	NOVATEL_IDS(),
 	HP4X_IDS(),
 	SUUNTO_IDS(),
