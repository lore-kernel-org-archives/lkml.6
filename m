Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvAUAeAKeFPneMv0e0eMKh+gjbM6LTbvdXUkHQuOVzV2cC7yfKs96SHpdS5z8OZw5py23oN
ARC-Seal: i=1; a=rsa-sha256; t=1519676889; cv=none;
        d=google.com; s=arc-20160816;
        b=oGjDbUMj310o30B4YkGSUixvS1Qy0w+H/igxIRRax1ERmh4pNF6wZzuLeU1JqsBJCb
         8NhYsxK0GSO+1Osw2VhztOMV6Mtf/+Agqjxk4ouWwtoFauphA3NqyWBoJiNazZVL85ab
         f8PzhrSq/Q+CAOAMsyb4au96blJ3E4WbsYc2OFNE/D96SlboMO51+ilWPhghT82DrsO0
         VPZpZkzBOAR6qjK6B48dA37lbuT19gDwi3e/e3W1XO3fr/8OlJo3E2jBCPrDlLz5CHSz
         TNLxtyZQQJt14FNnVsXWXo/V0gpoEMDE6TPjUx3tgzSO09o3cyMvdkTxl+fnPVTB7jFP
         cxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1kh0LqGMJFBSfJ2YF/4isV6+S/MEQ5U7wrwh8nD4HeM=;
        b=EVaKwg4iuByPxIUHsSMNZXLHEO2daHxvvjB2HbU8u6GyR4z2/yhJDhfgFjDWnhdrIR
         ANsFz54vvl44Oce5Dzy6uRq7+znIUBC60OkJCVv83Kyb53+ku2rTR2qI4RCNIgxsIjH6
         VHteONJy7ZukZ9SnjNy1V3v/Z//Q0DeMRYJjgYLWwnVokLRAVxxYxgM///zzd3Ce89uI
         ofRq3Q22F6/pWqZROqHw/zW3EEOYgVO2vJED/RcwruJxTxpGtnVQgJXkztj1QWkNa6WE
         Vm7ZieWZPIU8IW4C5oN7xoasaxTF9BF7t4VuDYyUeqTLz69NXm03nM8kF3SVgcRNeSy5
         q+9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Karsten Koop <kkoop@ld-didactic.de>
Subject: [PATCH 4.15 48/64] usb: ldusb: add PIDs for new CASSY devices supported by this driver
Date: Mon, 26 Feb 2018 21:22:25 +0100
Message-Id: <20180226202155.505957417@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496011031039879?=
X-GMAIL-MSGID: =?utf-8?q?1593496714069367080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Karsten Koop <kkoop@ld-didactic.de>

commit 52ad2bd8918158266fc88a05f95429b56b6a33c5 upstream.

This patch adds support for new CASSY devices to the ldusb driver. The
PIDs are also added to the ignore list in hid-quirks.

Signed-off-by: Karsten Koop <kkoop@ld-didactic.de>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-core.c   |    3 +++
 drivers/hid/hid-ids.h    |    3 +++
 drivers/usb/misc/ldusb.c |    6 ++++++
 3 files changed, 12 insertions(+)

--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2721,6 +2721,9 @@ static const struct hid_device_id hid_ig
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTIME) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYPH) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_POWERANALYSERCASSY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MACHINETESTCASSY) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_JWM) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_DMMP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_UMIP) },
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -641,6 +641,9 @@
 #define USB_DEVICE_ID_LD_MICROCASSYTIME		0x1033
 #define USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE	0x1035
 #define USB_DEVICE_ID_LD_MICROCASSYPH		0x1038
+#define USB_DEVICE_ID_LD_POWERANALYSERCASSY	0x1040
+#define USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY	0x1042
+#define USB_DEVICE_ID_LD_MACHINETESTCASSY	0x1043
 #define USB_DEVICE_ID_LD_JWM		0x1080
 #define USB_DEVICE_ID_LD_DMMP		0x1081
 #define USB_DEVICE_ID_LD_UMIP		0x1090
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -42,6 +42,9 @@
 #define USB_DEVICE_ID_LD_MICROCASSYTIME		0x1033	/* USB Product ID of Micro-CASSY Time (reserved) */
 #define USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE	0x1035	/* USB Product ID of Micro-CASSY Temperature */
 #define USB_DEVICE_ID_LD_MICROCASSYPH		0x1038	/* USB Product ID of Micro-CASSY pH */
+#define USB_DEVICE_ID_LD_POWERANALYSERCASSY	0x1040	/* USB Product ID of Power Analyser CASSY */
+#define USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY	0x1042	/* USB Product ID of Converter Controller CASSY */
+#define USB_DEVICE_ID_LD_MACHINETESTCASSY	0x1043	/* USB Product ID of Machine Test CASSY */
 #define USB_DEVICE_ID_LD_JWM		0x1080	/* USB Product ID of Joule and Wattmeter */
 #define USB_DEVICE_ID_LD_DMMP		0x1081	/* USB Product ID of Digital Multimeter P (reserved) */
 #define USB_DEVICE_ID_LD_UMIP		0x1090	/* USB Product ID of UMI P */
@@ -84,6 +87,9 @@ static const struct usb_device_id ld_usb
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTIME) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYPH) },
+	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_POWERANALYSERCASSY) },
+	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY) },
+	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MACHINETESTCASSY) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_JWM) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_DMMP) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_UMIP) },
