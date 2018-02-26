Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvQSlZV04vaaRVHBO5o973ZCi3d4WcyTZUu2e/yJsoYBxA8Xof5Tcuft/rmD+bWTZbO79qn
ARC-Seal: i=1; a=rsa-sha256; t=1519676218; cv=none;
        d=google.com; s=arc-20160816;
        b=Xt1MNic+Z3XV5gQt0HgRQw7pGjqu9/cQ1v3dC+37fcw2ZWyZlN6rz/cjBf1hE49NUa
         sXwlvLmeYUx6zLFJEx7iTJSpZ8CiT5YsTV66DWc3TOD7MrJ+vV3Rg6bUfvMiLU4ZtdsW
         i2/m58IawhZBYxKcTKYUmvmjh1Ed6EQHu434JgoU14Zemu33R8FXFUkFU2/yFYP1IgZD
         zPNhuZvSRzBD6KZ92ueXJuXM7A+Xu4uacByHPA4HD1i0HKx0aCnlZ1ACHK5A8UehEXeS
         uwa0Rp7Y69IJq2I1kine5JmJOUNbcAGtrcc7n9VwazP3E+drOyICCPg/zsy6Wqk136Wf
         Csfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5Bv4b0h9VHglAQhL+1ZkbwHA/3i1oSZ8OBSHBYYbOuA=;
        b=pkwjQHnEey5B91XDBIxk7wtWtojVom0JV3jG9zvBQYJK5LlhuQ0z+1FjpWhfXdGMHb
         ozglY6tozE+LrR3Ipov5Knk+qBJsRZxRi+06F3p3TkZNYdR8E7WvhMOr9Rti5QMJA6YK
         UXYSGo4fjD0KRUdbSvzDKs+2/roZ9Ny+87xN6Ay9yDqbTHiwHHEXYBzkylU/YcNuB061
         Pv3R43XjzPuw7dsmLbBKs/5TgvZ6agVftcY+SH1LlVbkp6ZV35Dp5XcRFdfu3O0CkoF/
         9a7roOlCJHLlner7ekHae/K2A1pJgJLA21RaTaBlPA5dJRqzTYLsKnzfNuzI3U7rlcR6
         zdJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Karsten Koop <kkoop@ld-didactic.de>
Subject: [PATCH 4.4 18/22] usb: ldusb: add PIDs for new CASSY devices supported by this driver
Date: Mon, 26 Feb 2018 21:16:18 +0100
Message-Id: <20180226201559.526980698@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496011031039879?=
X-GMAIL-MSGID: =?utf-8?q?1593496011031039879?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2386,6 +2386,9 @@ static const struct hid_device_id hid_ig
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
@@ -570,6 +570,9 @@
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
@@ -46,6 +46,9 @@
 #define USB_DEVICE_ID_LD_MICROCASSYTIME		0x1033	/* USB Product ID of Micro-CASSY Time (reserved) */
 #define USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE	0x1035	/* USB Product ID of Micro-CASSY Temperature */
 #define USB_DEVICE_ID_LD_MICROCASSYPH		0x1038	/* USB Product ID of Micro-CASSY pH */
+#define USB_DEVICE_ID_LD_POWERANALYSERCASSY	0x1040	/* USB Product ID of Power Analyser CASSY */
+#define USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY	0x1042	/* USB Product ID of Converter Controller CASSY */
+#define USB_DEVICE_ID_LD_MACHINETESTCASSY	0x1043	/* USB Product ID of Machine Test CASSY */
 #define USB_DEVICE_ID_LD_JWM		0x1080	/* USB Product ID of Joule and Wattmeter */
 #define USB_DEVICE_ID_LD_DMMP		0x1081	/* USB Product ID of Digital Multimeter P (reserved) */
 #define USB_DEVICE_ID_LD_UMIP		0x1090	/* USB Product ID of UMI P */
@@ -88,6 +91,9 @@ static const struct usb_device_id ld_usb
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTIME) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYTEMPERATURE) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MICROCASSYPH) },
+	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_POWERANALYSERCASSY) },
+	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_CONVERTERCONTROLLERCASSY) },
+	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_MACHINETESTCASSY) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_JWM) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_DMMP) },
 	{ USB_DEVICE(USB_VENDOR_ID_LD, USB_DEVICE_ID_LD_UMIP) },
