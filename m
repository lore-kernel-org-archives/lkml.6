Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpPccqi8q+21gS86dY52g3NfFyLY7QvdICbnBS96f1r5RBVMHW9uJ4TK8f18L8KcPEbi9Rf
ARC-Seal: i=1; a=rsa-sha256; t=1526280663; cv=none;
        d=google.com; s=arc-20160816;
        b=jejPGFujAapbeIrT3pMut3n0fgar/7UKyA/VeD7OUgjnUgauuNlh6mDDWQ9dHBXwqP
         ZG89PTgREyBXQlAO8mSLG+nICQDMpE9F9N07te6IScZMtDHYkI+2cmw+B9dDmTIz/5rV
         XqkgDNeQ/Z1lnx9UVzXyA/otY7w/OUOaYGQM1wQvDWcMQvrZh6mzcIdYdm96oQZS5zO0
         aVVpdBagglwyuPXmC7ZZLu0T4Pt0axoNgfGO6Q7Sij1DiU2hwdLtGG3P2QBldjuyheMq
         IdaYn8AQ6cnBq4UFJunb9pOYui1+GhiM7Yk0V4FQAPuLj//RMTFRRQyAQM5zfUrehtxl
         +33Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=bVRGr21PnAiFTInQNJh85VLpSQ33RY+uxiTLVfi/fME=;
        b=lyTDwdYiNiLeqIOcI0Tzfm87i2trr0/tK0LVU9UH4moiewYt+ogQH335Z+tQB1iYCD
         p4cXyKDSd6nHNGRSS5t+m7ehFGUED+aypohVTdYV/8mcG2pBBgFVCCKN73oMjw7ASFz3
         YlSdksElaKnGh6XHCu/CfQF7xgdZHqdDaU7u/4lMOpZ7Vzml28D5OSl2VZHoXJ5u9N7C
         Da6KU310e0JuYhho3DOw5NOXoBY3fhCgJ7aEUjM3UnyzvpZWC1WDyDG/IWklk7mkYQJQ
         KbQzdvlMYLU1CK9ky9bn9sGbJhYN5aK0vCOgtn8rM7w7e7UyH5kdjltZVrOdnew/rbo5
         L3mw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QxYg0Nw8;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=QxYg0Nw8;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kristian Evensen <kristian.evensen@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 4.4 11/56] USB: serial: option: Add support for Quectel EP06
Date: Mon, 14 May 2018 08:48:16 +0200
Message-Id: <20180514064756.142591429@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421273058702598?=
X-GMAIL-MSGID: =?utf-8?q?1600421273058702598?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kristian Evensen <kristian.evensen@gmail.com>

commit 71a0483d56e784b1e11f38f10d7e22d265dbe244 upstream.

The Quectel EP06 is a Cat. 6 LTE modem, and the interface mapping is as
follows:

0: Diag
1: NMEA
2: AT
3: Modem

Interface 4 is QMI and interface 5 is ADB, so they are blacklisted.

This patch should also be considered for -stable. The QMI-patch for this
modem is already in the -stable-queue.

v1->v2:
* Updated commit prefix (thanks Johan Hovold)
* Updated commit message slightly.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Acked-by: Johan Hovold <johan@kernel.org>
Cc: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -244,6 +244,7 @@ static void option_instat_callback(struc
 #define QUECTEL_PRODUCT_EC21			0x0121
 #define QUECTEL_PRODUCT_EC25			0x0125
 #define QUECTEL_PRODUCT_BG96			0x0296
+#define QUECTEL_PRODUCT_EP06			0x0306
 
 #define CMOTECH_VENDOR_ID			0x16d8
 #define CMOTECH_PRODUCT_6001			0x6001
@@ -692,6 +693,10 @@ static const struct option_blacklist_inf
 	.reserved = BIT(1) | BIT(4),
 };
 
+static const struct option_blacklist_info quectel_ep06_blacklist = {
+	.reserved = BIT(4) | BIT(5),
+};
+
 static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_COLT) },
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_RICOLA) },
@@ -1206,6 +1211,8 @@ static const struct usb_device_id option
 	  .driver_info = (kernel_ulong_t)&net_intf4_blacklist },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
 	  .driver_info = (kernel_ulong_t)&net_intf4_blacklist },
+	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EP06),
+	  .driver_info = (kernel_ulong_t)&quectel_ep06_blacklist },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6003),
