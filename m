Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227P/dqJRniJK4p5Jp46tXwuMTCo+gIN0GMni3mxIiSNtywVVTq8/5GbvfwbRkQGUgbNQXlj
ARC-Seal: i=1; a=rsa-sha256; t=1517591679; cv=none;
        d=google.com; s=arc-20160816;
        b=eHtiWGbNIWm9GVLRSg6J+kOD2UjuP5OCATvagAunQZxUZopV0c/adpowNhIgSxJ9Zb
         x09u5i3uGlr19L+A04BcrU/CA4bgVA+KqnRJcOysHqNeXQWmYo+K7ud6jIZer6SGiMG1
         Hx0r3ynF+zPGNSa7kpg+RrdAdO6gikYJZs6JzfiOC2SuktVxxZizrKlMnPlQXZvWyxYK
         q0WA/3TztKE5bbGPITCQ7Po93OGGQDWhr8iEBaeOeLHAhHHHqlrX4xWRBcdoOzV7PwME
         2k5jzNGMRXMXjSty3ZFmq4ttodrEXCyBSIoZSPrdVr+DcVJXeha5Yh0P3JmJroB6seNq
         EnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ijwqGSPYJKl1tV5mMiqSfuldjmC/zdfJYm+KynUrUwE=;
        b=tO2fw3v4wogGHJACieq0GQEXZQrn/nRoPt3/dNDgXzMPpR94OsHyl7KYzTCTiOcqSU
         3omgUQMWl6Ite31PcCfxyAVHI+au34HRDOyra79EicC1+E+WOtbtMdwH7CDd3n3pu4bP
         sZ29ds1MK5qhbnICBMz14TMbv4kCrooZDxKnlIOB6YoEgndsHmoH/M92eQ4IN/qzcD6N
         KtnJ11WweNNs2liHbJwzkAEQrC0Iax3g5zG1Ol/O6xJt/1T/cwbD3s/KpnrVhs4FcK27
         lXiL2qet4fWgF4i/wDTMW7IVmuYk1EfuuQLA4e3WiwBt5BLYAZd+DAUSyG2f6QqljoS9
         1LAg==
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
Subject: [PATCH 4.14 140/156] USB: serial: simple: add Motorola Tetra driver
Date: Fri,  2 Feb 2018 17:58:41 +0100
Message-Id: <20180202140846.710287805@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309449263095125?=
X-GMAIL-MSGID: =?utf-8?q?1591310213181132256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -80,6 +80,11 @@ DEVICE(vivopay, VIVOPAY_IDS);
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
@@ -110,6 +115,7 @@ static struct usb_serial_driver * const
 	&google_device,
 	&vivopay_device,
 	&moto_modem_device,
+	&motorola_tetra_device,
 	&novatel_gps_device,
 	&hp4x_device,
 	&suunto_device,
@@ -125,6 +131,7 @@ static const struct usb_device_id id_tab
 	GOOGLE_IDS(),
 	VIVOPAY_IDS(),
 	MOTO_IDS(),
+	MOTOROLA_TETRA_IDS(),
 	NOVATEL_IDS(),
 	HP4X_IDS(),
 	SUUNTO_IDS(),
