Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoOB0uFwiatFgMpTQkuM3dvbuJRJsvkIkgI5d0nMAlrw7S6Hs84QCWSqB7aZzdv1jsM3Cri
ARC-Seal: i=1; a=rsa-sha256; t=1525116352; cv=none;
        d=google.com; s=arc-20160816;
        b=MQEuKcjGUxj91OLZrGv+ueIAcSalP5msxDCdZgnDwERmBamXOJKP0tto3sH5Hz3ZKr
         SErmopTtjC/DhrRuFCpOW93SN5XzLxH6NQKXoSGOIjpGGsWaaS696NzBA1/CPIJi3z6h
         tgZDWztsP2ZaOcrTNn/f2wmwRsukROD5KH53aVKDLsgIyGdem4Ju/wL+NCCxQhecWk45
         Ctaw+a444Vgiq2hwS/OxXUH64MrW5nX47o/2S8aYS2RywYb0p5l9GVf6hJdIyJon2uIF
         ntCsPDTLJ/v+lKS1620MWFDSceSIoj0ZrVMhp/JavM6Seim+OlZPKqaj2bPxgLZDoKzq
         nWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=JBLwXAL2LeR4MxHiIJo2Si8W0UTHdGX146Ga1ehQG9U=;
        b=V2xCJBXFpQBRIJ7qJq52yl3CH2XVU8gkzqefZlpAEyQuezZHF43OrJ/CclbEHF2lYF
         2siJqMV29QbOwntcau6hbUwJtK2SO1NHkgY5LQE01t6XKQor+pk0BMAZuoAL/jW4Dez0
         355evvs5YMye1SjknGlasu0aWmK0IAxJzLH0u9epfym8sfXQTR5UvLk50E8XcZRC6m69
         0nKqzTAkY3LN24uSebvfd8YR5J2el9l+eP2nI2L/Wbr+cDL1kPLKyCI51b2irbwEIbG1
         66mHX7uIaFY4qq6sj+ozKysiqQzZSLrGuaXnpYcsV+bcsM/1lDlEwAF0AATT+HbDGL2j
         6vVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD56A22DBF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Collin May <collin@collinswebsite.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 07/44] USB: serial: simple: add libtransistor console
Date: Mon, 30 Apr 2018 12:24:18 -0700
Message-Id: <20180430190946.631305721@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200404256407404?=
X-GMAIL-MSGID: =?utf-8?q?1599200404256407404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Collin May <collin@collinswebsite.com>

commit fe710508b6ba9d28730f3021fed70e7043433b2e upstream.

Add simple driver for libtransistor USB console.
This device is implemented in software:
https://github.com/reswitched/libtransistor/blob/development/lib/usb_serial.c

Signed-off-by: Collin May <collin@collinswebsite.com>
Cc: stable <stable@vger.kernel.org>
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
 		- Google USB serial devices
 		- HP4x calculators
+		- Libtransistor USB console
 		- a number of Motorola phones
 		- Motorola Tetra devices
 		- Novatel Wireless GPS receivers
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -66,6 +66,11 @@ DEVICE(flashloader, FLASHLOADER_IDS);
 					0x01) }
 DEVICE(google, GOOGLE_IDS);
 
+/* Libtransistor USB console */
+#define LIBTRANSISTOR_IDS()			\
+	{ USB_DEVICE(0x1209, 0x8b00) }
+DEVICE(libtransistor, LIBTRANSISTOR_IDS);
+
 /* ViVOpay USB Serial Driver */
 #define VIVOPAY_IDS()			\
 	{ USB_DEVICE(0x1d5f, 0x1004) }	/* ViVOpay 8800 */
@@ -113,6 +118,7 @@ static struct usb_serial_driver * const
 	&funsoft_device,
 	&flashloader_device,
 	&google_device,
+	&libtransistor_device,
 	&vivopay_device,
 	&moto_modem_device,
 	&motorola_tetra_device,
@@ -129,6 +135,7 @@ static const struct usb_device_id id_tab
 	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
 	GOOGLE_IDS(),
+	LIBTRANSISTOR_IDS(),
 	VIVOPAY_IDS(),
 	MOTO_IDS(),
 	MOTOROLA_TETRA_IDS(),
