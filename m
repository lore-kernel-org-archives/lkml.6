Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrPr6NuGbLVOSvs+np9JAtdzXOUpbjDqHYB4ZYvfPsjT7ax+b+rtLj/kmkMz9kH8w0VbA0X
ARC-Seal: i=1; a=rsa-sha256; t=1525767434; cv=none;
        d=google.com; s=arc-20160816;
        b=xy6sQzw+QcTTP0Mhfb950jR70tkciMyt7hFpnPH6IJ0ZBbbXGlQvY+PGSsaNzSPrTa
         iC8LwK6YiEhHwkZNHA+wv6hvJ3PzbZ6y/ZVJf52a42w8Sv2U7HVo/ALJIkllb/IoY3i1
         g6A09RBW9WivC5wuvomUVtLANUGFUrQe6Ldn4E3khaHG64qxPLUllMgfDG54VWLUb9Og
         8+obedzzdlHKS3c5pTZQl3WkTN+KId+c0BuDGq9csaabTSdqwp6SqSkote8ARRPsXG2B
         GZbfISrvKovCyd/QYKFevG5dr3uQa77CobDFWL3kPbYe6e7nM1naZlp/jqgrSVfS/NOj
         ZCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=3i3sLFfWMjDEnW5VMtnVBodNSUXhOwYpzaCHB4MPJPw=;
        b=Kzm/pv5hcXMn0BDLFCnUqY5qshOX0eVUSozKQCcMris5snwIZUnZ+D0J+fYAzvV2s8
         /3iddO4yoaN9Q2NqheKdSig28mRgdRVLWcg0Kv8vsLtTFR9FOukwuLf0450UTc7Nbwtq
         HSFPrpnnh7RISVToIZ9sQp5ZO9qWG2d7XJkCQrtJBp0BHwQ67hGffew+C7saKi1vB1lp
         bAHonzUycc1nNcZ55foLiK5YwVVuebEuQ9NSKbDxp0spkfgb/Mr8yYn5Rjlu6J8r560M
         7I4N82GIFvz7paI/fapHi+o47x+Kg7B8cY8HFrjIhYp/eMrIMgRaTWyWhEK368uzg9l+
         Sgaw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lQLpbfyk;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=lQLpbfyk;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kristian Evensen <kristian.evensen@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 4.9 07/32] USB: serial: option: Add support for Quectel EP06
Date: Tue,  8 May 2018 10:10:47 +0200
Message-Id: <20180508074009.992149247@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882944393877963?=
X-GMAIL-MSGID: =?utf-8?q?1599883113508814763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
