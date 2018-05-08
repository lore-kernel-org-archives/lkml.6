Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpDnTVYoks7OIoaBFEKpxJZPaYYNQrQan6rdnneEKBDqdGTgk35oNugNPfvM0zaXLo8eK/M
ARC-Seal: i=1; a=rsa-sha256; t=1525767346; cv=none;
        d=google.com; s=arc-20160816;
        b=Fu28DKcvauGy1UrbjpyxmqE2LWfOzbVG+68eBfEHfuvWgl7dBEdAJ1Wj23ypyfpxaw
         pERq0gGgozuPXe8PIsKBi1uP76u23MdCy5u4vSD5KlwFcBWyopZXI/bgciKGPtVMkR+j
         T9KfLC16ndoYDFMNPWugbhdEyIVNBzzAV/bt3QgCEpo4OJEXn9McGi0P7OeTMQTWE25S
         7e0ecK915rX6oSFoHFHJvSNVKtr7uKjTNVKuecsXR4U8t5noXXeI1A1i3FHtKXnWRSg3
         bSmWEHIsDJ+p+F+EEGv+W65QKKUgq3lXGFcZ8cuLQPtsamMSDxH5pOBOxKyYslFOkUrb
         Ep6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=iiOztBc5v2y0xoZQZe3i/xCc2Ktb1qpfRirw1CIh2Cc=;
        b=dpVYiMsSkiDA1Ef4Kkb6TKeruNPE3t450hiAGechU96Pb1wRWn0ZgC4Hy6/yyB0AYl
         BVV8sViA+DQK1i3QtOCbanrws2JLOrPy4b0OaTGGKeGzAm6H6XUkUPe3gsn9zL30WpPW
         z8F2q37QrqiH9lFwTDYL/FL/CA7HrkLfrwQYhQgA/f16kDqXsfp2TTN0znTiUQqahgN8
         QhGOUA6S0lU4eu/mqhrvkcTfPvTV2A8KvEpdQwbgfvPtePwHusYLD8Q+2PIZyStIAWjA
         PqPj0Bzs5Vr164XmtBBhf+oaVDaQGkP5AjjFTKrhOBskZXORbtjaG6egdLSxHHN1w5n3
         tVqA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ftQ+G6V1;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ftQ+G6V1;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 38/43] USB: serial: option: adding support for ublox R410M
Date: Tue,  8 May 2018 10:10:57 +0200
Message-Id: <20180508074010.026658859@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882907525716192?=
X-GMAIL-MSGID: =?utf-8?q?1599883020849935483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: SZ Lin (林上智) <sz.lin@moxa.com>

commit 4205cb01f6e9ef2ae6daa7be4e8ac1edeb4c9d64 upstream.

This patch adds support for ublox R410M PID 0x90b2 USB modem to option
driver, this module supports LTE Cat M1 / NB1.

Interface layout:
0: QCDM/DIAG
1: ADB
2: AT
3: RMNET

Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -236,6 +236,8 @@ static void option_instat_callback(struc
 /* These Quectel products use Qualcomm's vendor ID */
 #define QUECTEL_PRODUCT_UC20			0x9003
 #define QUECTEL_PRODUCT_UC15			0x9090
+/* These u-blox products use Qualcomm's vendor ID */
+#define UBLOX_PRODUCT_R410M			0x90b2
 /* These Yuga products use Qualcomm's vendor ID */
 #define YUGA_PRODUCT_CLM920_NC5			0x9625
 
@@ -1068,6 +1070,9 @@ static const struct usb_device_id option
 	/* Yuga products use Qualcomm vendor ID */
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, YUGA_PRODUCT_CLM920_NC5),
 	  .driver_info = RSVD(1) | RSVD(4) },
+	/* u-blox products using Qualcomm vendor ID */
+	{ USB_DEVICE(QUALCOMM_VENDOR_ID, UBLOX_PRODUCT_R410M),
+	  .driver_info = RSVD(1) | RSVD(3) },
 	/* Quectel products using Quectel vendor ID */
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC21),
 	  .driver_info = RSVD(4) },
