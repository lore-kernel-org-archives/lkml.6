Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225slFkZhTZ/U5v2EFmTacx+B6UT2UMJTAxx88v2FO2IspS2Ze65x9Lh36ZXpNkPIADh2CiD
ARC-Seal: i=1; a=rsa-sha256; t=1517855216; cv=none;
        d=google.com; s=arc-20160816;
        b=lzfrxE63nHy9ImsEyhzIR5ZWtn7Vql1HopYExsx+0WSXNp7TLkHIqF86yIYmnKBUS8
         npceZniWSdl4HQR8IZtX8nSLhxtVAEtPxr9Sse9ycq3PDbCGJAVLJFm+6jIrfVBC/V1+
         1HGcDF+bVefRxPIAqzrTgMAqH5Q7Nb9lF9h3GA27EJ1M28wto+b3Rn7xj9Gplv/2lFFL
         Ci+z0VP4QQGQrF1/Pv45PLpo7P9GVLk4jy2e9VerBleJTioL218aNm3re8ZorIF67L4G
         2spIjWMphttNXOlMzAfqpJKsbthJww1Y+QhQy00p8tXoMRPjcPO80MqZwKMMZQipZQtD
         dThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rZBwc7bckv8guEdi4aIitHiGwIWmFOT7s4v7oEtOwms=;
        b=BdX0Fdjwhd+r2At8fgnZ4ZTJobIxjJlJBseoSLYPzCovifsO4iLqDxGN6lSQWdLQdx
         HT/JBZ9Zhw8jLIMVu5Yw61IIjS8OaC80SksmJ6RF9WtTQdTAz87GPwjGdJf6MuFG6bhk
         wZcSNTWqNzr39yN/IgV8W46onCtdrHF5gyHtLMxqQ/LriU9WuYYQUbxjcz5Yj+sM1wUv
         YQ7OLPAEnYjov6Lb987RdH8NkVB1090s48A9mEbsfgBfLwn2KpjlgxVrNktjGw5VzxNU
         QuZRQmPUw3AjROBfcVde3aeJVR1Qw15nWjJrv3LUSnEOZ6o6h/DxeI8pIoRaTC0lEGJM
         cCdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Max Schulze <max.schulze@posteo.de>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3.18 31/36] USB: serial: simple: add Motorola Tetra driver
Date: Mon,  5 Feb 2018 10:23:59 -0800
Message-Id: <20180205182353.053961265@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586551720469633?=
X-GMAIL-MSGID: =?utf-8?q?1591586551720469633?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -62,6 +62,7 @@ config USB_SERIAL_SIMPLE
 		- Fundamental Software dongle.
 		- HP4x calculators
 		- a number of Motorola phones
+		- Motorola Tetra devices
 		- Novatel Wireless GPS receivers
 		- Siemens USB/MPI adapter.
 		- ViVOtech ViVOpay USB device.
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -72,6 +72,11 @@ DEVICE(vivopay, VIVOPAY_IDS);
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
@@ -101,6 +106,7 @@ static struct usb_serial_driver * const
 	&flashloader_device,
 	&vivopay_device,
 	&moto_modem_device,
+	&motorola_tetra_device,
 	&novatel_gps_device,
 	&hp4x_device,
 	&suunto_device,
@@ -115,6 +121,7 @@ static const struct usb_device_id id_tab
 	FLASHLOADER_IDS(),
 	VIVOPAY_IDS(),
 	MOTO_IDS(),
+	MOTOROLA_TETRA_IDS(),
 	NOVATEL_IDS(),
 	HP4X_IDS(),
 	SUUNTO_IDS(),
