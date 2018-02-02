Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226umCJCvfE2jFTjTFOXb/yEa8ZQ+6MdkylXydGFqqX7M8aRoMsA2il656uayFATIu4CGt7p
ARC-Seal: i=1; a=rsa-sha256; t=1517591187; cv=none;
        d=google.com; s=arc-20160816;
        b=0UkI2g9EYd075lIaNu6qQ9SA+/tlcXGsj1D/KKEaMJ3ig9lWjRjPyx/1F+ZzHDaK/e
         SZ1isMS+oDXWquKGEFmc5o0PkXY8Vg0rUpoHpdqa8Zf6ULwUx/4NLxUiQuqYdWaPw9kO
         jAtcUvda/3qNSUcfNVTmUh5VUOS/ABeWfBYqX6mxWlD95lq1AJaBH+F8TBVsxOUE8wGR
         z/6sUQfSquTUDloosegog+XFgztKHSTn8OP+6Bn5F7jWMbaCBDRDutWh5IEsWRvsDhrk
         6fIw5ImwlCQSynKTTX9MZijPjs0E/g6475xbUoi6u5/t2mOD0R/XQ+DJVc34PTSIuYMS
         aTLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mZ48PDPNe7CksuH+K9xuyRy3EPylWN+2iez+2rDWz8A=;
        b=EIhf8AfGdhDPpiYRyh93qbyiq53/dfV5OwPu1F29IaeRBV3hXA/b8GFgn+K/CaiK5K
         6D89n/i9aQmBnKQhpK9fhpwDUJCAOTNON1ypMZEPIZY+bf/rgjvSS3v2gvVDLNWotX4H
         dtIvLSPo7HXN3cWIgeThA4BBc6tzVBFs+hyD/DYG8lPXwUgh54rfVFKX+Y/fjFwWNSCK
         HuwIAV1K70FFrSunKDlxgAvpH0E8AhjAkLqt9hzbK3NPrMmPy5UR+InTrgSmzcXULv3W
         ZZo0FHjmi3kMW+FWjjfZh4w3sbrubnuPlbt8M7PcNldswE/1KCtIfIFDVYawWJu7llTh
         psgg==
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
Subject: [PATCH 4.9 80/86] USB: serial: simple: add Motorola Tetra driver
Date: Fri,  2 Feb 2018 17:58:40 +0100
Message-Id: <20180202140830.020886758@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309449263095125?=
X-GMAIL-MSGID: =?utf-8?q?1591309696923507077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
