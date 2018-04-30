Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoycGTGKXMJIJbYx8bpCEN0IG2yyXxyzq9t7pAzxSXpp5v8cmnTE/1eOzf0OjVK+hXp5Dbp
ARC-Seal: i=1; a=rsa-sha256; t=1525116376; cv=none;
        d=google.com; s=arc-20160816;
        b=GYkiIkrD1H4ry4KFkKPVcsX80TdiAXJSfk86D/Q/xyqupKVyL/yBU4YXxAaZaBpy9d
         5x/bEN8L6Z0gu4ipjC643QRKl3zfWVWvJg/j5DGfAE8nsl76P5DKh++nKM+WoD6BITtR
         1JzPgV4l+YIyKR7Gcx0EcR5LHHkmP6UCkS04hggtRWy8YU6XcQL9wPpUrnTDUhmytX7U
         k+Gy87iwxDhsjXW85ljWgRNmRaAJPCP891hK8NGZvPGQMlwLdpUFqITJz8GfAZr8xKxU
         NK9z2W9V4nJO68Qc6XWCz7/z/t5fLUYjq++D6mC/mGxswG8etNSt/02mv4VZhIVNZEif
         CXCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=/GhmYWp3EErm2WgWFbSKwHpjkRZFGGyGGGbnjTMzKm8=;
        b=DSJUhPdod9yvUMmghStGhHhi5edL9r1nvEwM3TfUljr/zIo3sIA9VajphBupr+AjDy
         LpYvkBMaJGqOmFkaLyGXVBF5ll0BPkfkvIchTVyHDEibFy1OF9/lX4Rs7wylyc8vWFbY
         vPOksUQxCZBt5b79DmPILOoBlIFYTOJQnI3JjntpZTS8rhlTcsmI3GuV5uCLrw/zd5oS
         4SEOICV1UCN1jlkE1Dow5ydYm6sWwYPZR8B9taubhdSMD4KXJWwHbBYbE38b3t4iWIQz
         pXER0IQPMrZ4hv2S5YnzevdPAoLqjj8YAv4P6to/4RXkEn7LpMoRBORaCz7J1WLR9n6u
         08zg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DE122DC0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Collin May <collin@collinswebsite.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 11/61] USB: serial: simple: add libtransistor console
Date: Mon, 30 Apr 2018 12:24:14 -0700
Message-Id: <20180430183952.213807453@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200404256407404?=
X-GMAIL-MSGID: =?utf-8?q?1599200429907331991?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
