Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZoadur8UFzKfWTCGfmHudq2LlVBvGKIoGtvhg8gJPqfH7HUhS2JR7VcNKjQcwgPKtel6xhu
ARC-Seal: i=1; a=rsa-sha256; t=1526280733; cv=none;
        d=google.com; s=arc-20160816;
        b=afQSzgVWQSm7tJo4VFRntMRizqkLQa1fBLx8tlvFFGT+pz8KhBZEfsTjq6KWMiG0Lh
         uxQV3vWmVwHxeDLHW7yKvuchkxI334PM0ZrTioowEQHVbVABPMcEysqhJTkIIfnSmEis
         /JycB5/RXZfe/iMYLFRafWEy0DM9OFz+RuxetlQNDukHX+kLEL/Mqx5naWQ79pCFcDtB
         udVfZjYI74/4bERlj4AsXzz96nIe/ZQ+3tTF8fO/uG9x68IyAyonAWQAu2NmTI0Thi6B
         1m0eBPgohHLAO2zfr3UtR+5IfqsVxyaxxX9CCs/iexdan/XbsFd4YyvydjqDB1UlgIqA
         exCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=InYo4cJm06xS8vWaugDcDu7BzceAFfJMSni8FbsfgOY=;
        b=eqbifdnK7HjGti/MJQW/6JSmh9d5Qph61hVUWaNIE2opVwBQs3bgeRaslRq6BT8Az7
         6gSCCxPkuKqwLLAvFHi38c9lON+i1Um5iUMXhvgh3EW4SCf2yg0fu8P83dSTvLhSUB01
         b0xZDmvkqtD8CeWAMTCBd3QFT5+KgWVdYbey3EpaiBSFAjueUfnaeMPLGVxzFu9qLRDu
         ewW9yDWkuNQPEoZRRVZbq8RTh0jggCw5qZpN6l0waCH60i0AP6axU4dNbsAxLl/SXbCi
         5kdY5fBWsaiy1LzhmKPfY2CBLT7WHBJ759OG54EwWIBZsdwK9znxJvetqrogSn/TgeoB
         DVSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=c/rClaTo;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=c/rClaTo;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 29/56] USB: serial: option: adding support for ublox R410M
Date: Mon, 14 May 2018 08:48:34 +0200
Message-Id: <20180514064757.583516461@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421346679653642?=
X-GMAIL-MSGID: =?utf-8?q?1600421346679653642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
