Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrEwbGN0QiajvfZyK/cLh1lHOVqKQ0spocpDqI5lnaG6W0ZnSwTPtz4fbY23KFM5QUA0F3P
ARC-Seal: i=1; a=rsa-sha256; t=1525116477; cv=none;
        d=google.com; s=arc-20160816;
        b=witSvomf2XzlfihocHGEDH4sLNk/dNo0Wb3D9UsUnraeqX2lAqgLwu8wOnbOpc+y1T
         YKf8h5xyYS0W4orzMoY5TphnWZU5F68c/uyjVLD3I2FMSG3jVa6wxwkYRrrLhqGhVvw3
         xYDLmdmwbV9Wa7cD4C1NzGgtz0PwgBl/KSQuuCpE/nfLq4daDPw8AaPxA0M3zFXULSed
         mEHgeD6gUAjq16DlIlP9s3UXOlR5VG8FTpw7oNukNesTXLBsJAmwULcEGE3RFwEXJxzV
         qHvRIae+43QgEz8OgbtpQNh4s4wVH4k/ygVQKA6aPnib4AWo2l0Bbf70gOt6nr9nprSK
         dOWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=CV+7V1dPUUrAyYhIQfdTovQDop0dybELtIZmCv8Et8E=;
        b=OeovKczntBVU+WtBEF+JgNERxj3Rtoy2A/W3Gi1Y2WyeW8TbpcvHiE3p3DUsx+o/WB
         Ad+m4P3QzgdT5n7/d97KYgWqFiLYiopJoSHjDHGl448dcobk+QLpEfti48YjICwKVoBL
         GDAUKMyHPNhElI6coBKaIGwgqR0lfUacwn5Owah5pvTaT7vgbLlYFPgD3TB/bG+8POtJ
         OoOMH7r3CW82Mb3OkxlDFvsRHyYV2FrUBWQXKnDH9T58wn/u0Z92lJUFmHU3GIrbIONp
         7I/Ay0o9JKG6tDaC6iMKxOZsOPRFze+4X88vyeG/9xuK+tNz35SzlQpqEQGQ508LMf+x
         kUlw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A211622DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Collin May <collin@collinswebsite.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.16 016/113] USB: serial: simple: add libtransistor console
Date: Mon, 30 Apr 2018 12:23:47 -0700
Message-Id: <20180430184015.766207178@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200404256407404?=
X-GMAIL-MSGID: =?utf-8?q?1599200535200919107?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -63,6 +63,11 @@ DEVICE(flashloader, FLASHLOADER_IDS);
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
@@ -110,6 +115,7 @@ static struct usb_serial_driver * const
 	&funsoft_device,
 	&flashloader_device,
 	&google_device,
+	&libtransistor_device,
 	&vivopay_device,
 	&moto_modem_device,
 	&motorola_tetra_device,
@@ -126,6 +132,7 @@ static const struct usb_device_id id_tab
 	FUNSOFT_IDS(),
 	FLASHLOADER_IDS(),
 	GOOGLE_IDS(),
+	LIBTRANSISTOR_IDS(),
 	VIVOPAY_IDS(),
 	MOTO_IDS(),
 	MOTOROLA_TETRA_IDS(),
