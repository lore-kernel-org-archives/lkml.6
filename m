Return-Path: <SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrKIP/Y+076b/Tdd1sWVsjN76RwkfQLfOXcgbmroHlbr3BrF3PsbY+xuNQKHYk0cbUaqKqv
ARC-Seal: i=1; a=rsa-sha256; t=1524837806; cv=none;
        d=google.com; s=arc-20160816;
        b=Zo3d6JVtxd6/yD+9ORRfWTYVaq4HSXtYuKEhqH4L8fDix8QC9q/uL1axaAWuFsovLU
         19A2UmBIA7yZwcI/0HTZo4agCz96fLvuhxzD14Hgat1EXAf6838So2972S4MqyfGjpnE
         EhPSaOZkQT29cNjm1qnaNLi24qbhdw2+Y5jKEyI5SgjIabSJB3hiMlz3EzXxxCvtrKkq
         rZBc4VloDJQc9uGY4QkVTYWHiFaCwi2LxeIrR3DWwQWlwe6W+401ew3frkyIrPY2CAPB
         E00xM1gSNtfNEfYlM5tZCS0RZi8LO++kmW1m44j1j/d5q3gF7XTtbx8H8SMbXcu8SDs0
         qMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=NiLlxWyPJ/i98STzbG7DcXiPbXyYoEzqlpG00cnY44o=;
        b=J58f7NBDY+wRkkCuHuRegwmJii6t2lw0i3c+Gmvh+i0hcdyuQzPVeMa+SQb+tQ1P0y
         15a2ce4G9uiv1ZHb+zV8L/5zdlueY9XgLrc4uoKGjsGrFI0eYu0IrytzsKWcM9UQvkOH
         d77wbvVxKznpKxCWYO8ODpCYTgZxBgvbdhmosS4ocJe8q1BHHQsWIAwP/K7i9lDRZRD3
         eoZZWFTIipO28bEd9aAfjHoLyKgG36lST6OLKvtL9Q/drWgy+W7ZtrXtP2IRr7qhaoA0
         npQiLju27FDOMmKVw1TpuSPAQVnNsXpKQsbegIuBTzMwozPs6OKC/U0qTMlYEpAGeaXY
         uULg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=4/0d=hq=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4/0d=HQ=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B817F2189F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Grant Grundler <grundler@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.9 24/74] r8152: add Linksys USB3GIGV1 id
Date: Fri, 27 Apr 2018 15:58:14 +0200
Message-Id: <20180427135710.901094132@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135709.899303463@linuxfoundation.org>
References: <20180427135709.899303463@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598908159806034716?=
X-GMAIL-MSGID: =?utf-8?q?1598908328223538023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Grant Grundler <grundler@chromium.org>

commit 90841047a01b452cc8c3f9b990698b264143334a upstream.

This linksys dongle by default comes up in cdc_ether mode.
This patch allows r8152 to claim the device:
   Bus 002 Device 002: ID 13b1:0041 Linksys

Signed-off-by: Grant Grundler <grundler@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
[krzk: Rebase on v4.4]
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ether.c |   10 ++++++++++
 drivers/net/usb/r8152.c     |    2 ++
 2 files changed, 12 insertions(+)

--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -530,6 +530,7 @@ static const struct driver_info wwan_inf
 #define REALTEK_VENDOR_ID	0x0bda
 #define SAMSUNG_VENDOR_ID	0x04e8
 #define LENOVO_VENDOR_ID	0x17ef
+#define LINKSYS_VENDOR_ID	0x13b1
 #define NVIDIA_VENDOR_ID	0x0955
 #define HP_VENDOR_ID		0x03f0
 
@@ -719,6 +720,15 @@ static const struct usb_device_id	produc
 	.driver_info = 0,
 },
 
+#if IS_ENABLED(CONFIG_USB_RTL8152)
+/* Linksys USB3GIGV1 Ethernet Adapter */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(LINKSYS_VENDOR_ID, 0x0041, USB_CLASS_COMM,
+			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = 0,
+},
+#endif
+
 /* Lenovo Thinkpad USB 3.0 Ethernet Adapters (based on Realtek RTL8153) */
 {
 	USB_DEVICE_AND_INTERFACE_INFO(LENOVO_VENDOR_ID, 0x7205, USB_CLASS_COMM,
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -519,6 +519,7 @@ enum rtl8152_flags {
 #define VENDOR_ID_REALTEK		0x0bda
 #define VENDOR_ID_SAMSUNG		0x04e8
 #define VENDOR_ID_LENOVO		0x17ef
+#define VENDOR_ID_LINKSYS		0x13b1
 #define VENDOR_ID_NVIDIA		0x0955
 
 #define MCU_TYPE_PLA			0x0100
@@ -4506,6 +4507,7 @@ static struct usb_device_id rtl8152_tabl
 	{REALTEK_USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x7205)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x304f)},
+	{REALTEK_USB_DEVICE(VENDOR_ID_LINKSYS, 0x0041)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_NVIDIA,  0x09ff)},
 	{}
 };
