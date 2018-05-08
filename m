Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqGK2SFhHzbleFBKmweHuWJBeLBlUD9gFduM534VYaDK0Z9ALpfl8sQGB04lIIPHdzBD9C3
ARC-Seal: i=1; a=rsa-sha256; t=1525767273; cv=none;
        d=google.com; s=arc-20160816;
        b=V2zfPqAK5p+u+CICJdPz0uZHc+Rrg/5uT75nS3fKMYSWq2v8DFp3glJYj8pjkOz51H
         BP0+xS5MN+WEkFt1mCjz1+zTCm/KgwpamekoC4pN8eZKNvXhpMYCyqFuPTe8JXqQC98Q
         7fbiUH0XDJ7pbTlu2MyOeVdtg2MYMJ3qRW7hPWmsscdbdV7zOjU5toNZD85A599Ilwlv
         uAy81povSJi8cwyAMA8pnCodTjcn4+yJJufSEc+hf6FaE5dl/AHMB07Un6TbJASRtCyu
         UBZ+chzDZ382vl6AJ+hT9/NontirdhkBd/eGrXufSCPv6HQorMrJGPDeqMIjhu6JVIOw
         7cWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=HmDUu8ZPMFiasJh2f6CZBCVfGI9HCNjgE/z+w6PItzQ=;
        b=x7HXZK7XKlSUedGNT+bMdQA8lrexoZL6Buhzozf5yhlSA/45+RJsFWqHKAYiRAlO53
         LCE9pPSI3pMpjEvuoHkHpSEXMMo6dqJTXOph8sNfFy1Rg8Jz4zPwREzQY4/F3TxYLCfS
         dpo/E3qiygBUqAHkKJg+ZmySD7AMaR0xqliN/tKdD13IrXxYGatIsvz/74TqKhJG3DU+
         zpTck9eKq0mU1DO11bFN7Bgd5KRqhBZp3VdvFNAeiFFYMMK+03oThH2m5XGzFyZ8vzvb
         1jW3A6E+qN8xM4bJ0xc1F8sqNEphhbjMvT4QB0QZLzsW2C62rYNJLXAnFMa2w3hB/LLo
         QIBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fdoM5BaT;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=fdoM5BaT;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kristian Evensen <kristian.evensen@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 4.14 06/43] USB: serial: option: Add support for Quectel EP06
Date: Tue,  8 May 2018 10:10:25 +0200
Message-Id: <20180508074005.046629939@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882944393877963?=
X-GMAIL-MSGID: =?utf-8?q?1599882944393877963?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
