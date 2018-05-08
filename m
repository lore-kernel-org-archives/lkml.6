Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrl17xY4VTsHVry1xYbSSzKqck48TdDAmrrJCYZA3Kwx5oh2rMXypWsSpurqjne7anoDLD0
ARC-Seal: i=1; a=rsa-sha256; t=1525767238; cv=none;
        d=google.com; s=arc-20160816;
        b=au2L/nMOSepcYkAwniMnEJHu5J6+b/a4JREvjxbOSajLXooou8JrcOUE7V99qMr/d0
         fPCzmcs1Q7OpIWjjTdJ5XYTHuT8w6nRf8QnAqgX9TJxNFIoBkiVevAoyLxx/Hu2L1H27
         WvXiEC+OrdahLgkvwu8BX3SpVabSFLoeDuK7Bu7P7pGzwV/bwCiFm3JiZ8noHj18Gahn
         lB0+iPF+DI2132c+cyziQ00AB5FLTQo0V31wC5Pceo49mGtY+fZqt5e/VA8zi1MkqAlc
         /W3sc0NihMXQ9jU+wS+wqJIrofi/Blp+7kK2UQJrvzuJpXJScZdhXn+U4kixHHp+w14B
         mqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=VV93QIqmUl6zD3tp2c+ghStBt+/3Aj/y59DG6b4FW28=;
        b=ULTQ7KLSSEHF1niTwrpaS8ImO3Y0zMhzIh41EwQkaJTWzHozcE4YAyS0nKt3PY2WFG
         TM0pGD081+TqTWN6Do272FmIZTqplbkpoDjV9kJOVo0pQOX028w1YeHWwZbAeGS7bbpX
         9AiHAgI4lXrHSa6sbDDzox6Jf8nolcchIQnxSmWkr+vDF2bGPU+ooEyU8fL9QMa0EusA
         VhzylEyc+kP6s6OJzWgN9yLOKlnA5K035Ey5tgFzWCtTpnV5+tswPF/YTrfEztheJ9fG
         H1oT73J7qWQwJQAMMKh6rmOFuLh37Gfaum28eZgwbu+ebJW/yLD1ta+TGiTRPgWsVEcE
         jwfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=as2Q91dX;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=as2Q91dX;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	=?UTF-8?q?SZ=20Lin=20 ?= <sz.lin@moxa.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.16 40/52] USB: serial: option: adding support for ublox R410M
Date: Tue,  8 May 2018 10:10:38 +0200
Message-Id: <20180508073933.743278288@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882907525716192?=
X-GMAIL-MSGID: =?utf-8?q?1599882907525716192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -233,6 +233,8 @@ static void option_instat_callback(struc
 /* These Quectel products use Qualcomm's vendor ID */
 #define QUECTEL_PRODUCT_UC20			0x9003
 #define QUECTEL_PRODUCT_UC15			0x9090
+/* These u-blox products use Qualcomm's vendor ID */
+#define UBLOX_PRODUCT_R410M			0x90b2
 /* These Yuga products use Qualcomm's vendor ID */
 #define YUGA_PRODUCT_CLM920_NC5			0x9625
 
@@ -1065,6 +1067,9 @@ static const struct usb_device_id option
 	/* Yuga products use Qualcomm vendor ID */
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, YUGA_PRODUCT_CLM920_NC5),
 	  .driver_info = RSVD(1) | RSVD(4) },
+	/* u-blox products using Qualcomm vendor ID */
+	{ USB_DEVICE(QUALCOMM_VENDOR_ID, UBLOX_PRODUCT_R410M),
+	  .driver_info = RSVD(1) | RSVD(3) },
 	/* Quectel products using Quectel vendor ID */
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC21),
 	  .driver_info = RSVD(4) },
