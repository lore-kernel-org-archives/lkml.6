Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqzb32FVonouR6mPLI/8FcbkMNaPYM9xFeI8r3Dq+tv8uINq+bYIBciWtcp2Hd0E2NseJvW
ARC-Seal: i=1; a=rsa-sha256; t=1525116418; cv=none;
        d=google.com; s=arc-20160816;
        b=Fb5Ns+e3vwIoFXSxv88TkOYW8VrofBLANdEawH0h0tV49yifC//M3HUjA6O523B71z
         pG05bvWSd2a6VAZK4pbPMYw73fo+UnRwMHpzbK+XgRhtiJOT8ibxW2dkPH4o7xQptRUC
         XGKaL4UWJ0sUnTogkY6HwsSbpJltOEimkskLAPTmPjkIgX9A6edGZ/3RxsiK7Ao7+Huv
         EpbedAW8dMDw5uoy1mb2lowjKpOhBLY+mxR1AN4mq1Yb1xTnBIXp3bDhJnHKRKz4lxmI
         qZLKYXbuBA5IKQIhKv/mTRyDv0mi11twc0a6zoUWrpE0VDbzOyvSGxrBlUdHmCJiQwQa
         VkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=XuR6C0seD3YM45MOFQge7KzKTWlkBy2owcBRO0n/ZME=;
        b=zBl0Bq9wZpjFkgCPT+Aaucao/GBgzYytsewaK8E2UjyDOCRLFVCsmjilVXteLe4K7l
         uO4jvPVPUmMeuIGW6ChS9FH7SA4q9mRS4Q1nv9xFyMa0eLImOqp7Wp5/THkXrT/8wSK5
         Mxr69SA8XL1Fo25kVqEcy2RqMHlLavL/itX6qJcoixBWMQXtH468ipLQF8yijJY7/0uC
         iOi8bHZhzsc2uVcZXPLct1wqGIjf/XZEEUsV3nu/cBLX8FNNA8K5PZfUC4T1eaVqUWl5
         atXuQSB4vG52R7b/VKim+Hb1l8wPHjJw62u38l0zEOMGvwxKXhMex19uLyjt4yO/7wYA
         +pOg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E69122DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Collin May <collin@collinswebsite.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 15/91] USB: serial: simple: add libtransistor console
Date: Mon, 30 Apr 2018 12:23:57 -0700
Message-Id: <20180430184005.011250398@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200404256407404?=
X-GMAIL-MSGID: =?utf-8?q?1599200473796511449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
