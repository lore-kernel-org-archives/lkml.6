Return-Path: <edward.chang.mcs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522722901; cv=none;
        d=google.com; s=arc-20160816;
        b=jNyrMEW4JIrCE8FgsRXv8jX4NvE5xUvXSecQx6rqFpulcb6IV7EAT2Zi3tPjDp18LB
         sYJxUMrWgOBbXAlza5ZwHV115yWL1ElGSHXrpL06ROFEgUQgfAE4lh7W8/8dcrIS3/IS
         WqMsOfsGyK6wDLu6QZxWqKPPr2mvj0l0Vl8UkUAGrYfshUPUD4wbvFhoIK+5EWedJSd7
         sDzSFw6ku2qiSyp8kt92kLHxfc3slnNsca1VxpiqAB05fcVabLmseXJph2JPwcMoOHrf
         oKSSLgUBeGzyqT64fu+F+RZRGfScG2K5BNuBWKX/udkwXv3vzzmGZKGGC702hK/Mr2uW
         9x2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=tDQgsy0LAx1ZXTr/BnuECc+mt+BWe08vWFNFLz7WwJg=;
        b=euWonID3OOuWUQw8z+TVNRNUoktVjS0KQRS2RVfxigg8vpaRuWpQ46yurmUUFpMiBx
         WbQwgLUczum0QCXqqeDgTV2pKOiW4THLxXU4OWiA42/QjOOuNyNrNVYHy/9uPaMxnIbO
         TkPQYKrC8R+RfBAiqIkBVtpPcW2jPdobgPCQNGbXUSgk/AXyU0ysk+4tKfo8+B+vEadT
         YGIw6hGHKLyLW7/0EO9x/+UcEpGzvHbup8fu8F5DZZPRhFOcYhwqSm79KLNn74DSIqNe
         kY0UulhggK8Cfo7BwHWXXGCYvz5YeJPAPFf6xx+ORGacmNjl+LGHI0CB5ybat/Xi8UPK
         +z3g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YTSmYLp9;
       spf=pass (google.com: domain of edward.chang.mcs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=edward.chang.mcs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=YTSmYLp9;
       spf=pass (google.com: domain of edward.chang.mcs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=edward.chang.mcs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/WGslqoySpMnHi1UGrFxsHuXfQ7oA1gqm4otakUxwacMqN6zEnVUPg6BNWBz/748++75uZiw==
From: Edward Chang <edward.chang.mcs@gmail.com>
To: johan@kernel.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Edward Chang <edward.chang.mcs@gmail.com>
Subject: [PATCH] usb: serial: option: add HP LT4220 support 
Date: Tue,  3 Apr 2018 10:34:39 +0800
Message-Id: <1522722879-2171-1-git-send-email-edward.chang.mcs@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596690689481175486?=
X-GMAIL-MSGID: =?utf-8?q?1596690689481175486?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds support for HP LT4220. 

Signed-off-by: Edward Chang <edward.chang.mcs@gmail.com>

---
 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2d8d915..a8988d5 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -548,6 +548,10 @@ static int  option_probe(struct usb_serial *serial,
 #define WETELECOM_PRODUCT_6802			0x6802
 #define WETELECOM_PRODUCT_WMD300		0x6803
 
+/* HP products */
+#define HP_VENDOR_ID				0x03f0
+#define HP_PRODUCT_LT4220			0x0857
+
 struct option_blacklist_info {
 	/* bitmask of interface numbers blacklisted for send_setup */
 	const unsigned long sendsetup;
@@ -2066,6 +2070,8 @@ struct option_blacklist_info {
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_6802, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(WETELECOM_VENDOR_ID, WETELECOM_PRODUCT_WMD300, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x03f0, 0x421d, 0xff, 0xff, 0xff) }, /* HP lt2523 (Novatel E371) */
+	{ USB_DEVICE_INTERFACE_CLASS(HP_VENDOR_ID, HP_PRODUCT_LT4220, USB_CLASS_VENDOR_SPEC),
+	  .driver_info = (kernel_ulong_t)&telit_le920a4_blacklist_1 },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
-- 
1.9.1
