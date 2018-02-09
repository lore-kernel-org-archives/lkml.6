Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226oAwJ536Sx3xpiIdP9yAalY8C1qAQyYbs2XEjmPGRnZwru+P3YZ4XyiuxT5RgE8vvUYg5o
ARC-Seal: i=1; a=rsa-sha256; t=1518183954; cv=none;
        d=google.com; s=arc-20160816;
        b=XesgOz1W06+eRjd4weytclJnhEtGwVR9molvh8n+10QM3+/HxTlNKzV+0LCPxiD08r
         TZTnWhg/b+Uw7Md17QpaViX/PHwMwKmJ6dVOSiqDz8GTZWIS13fFz6aBdhzPoOn2OywE
         ytCjew/UHhZlQZ32jKn1dXFqKk9AYneFp7qmqW3nhZ3RDGwfNQjAoB/gBkcYC3cbmjuq
         4yLKtnQNwPxh6YYQXR93oFixTsQzm6XokV6SdesjNSZ+GjzSDZ18BCuqLBE0sHyy2A3y
         OJT2g9a02bovi8xLKe9V7/srkkE19/Fgw8Rg0OixYpu6GJuouEweRXbud0y5m1tQrkQB
         7vOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=dJtUgLUrVQtr0UYzP3Gg3IIh0+aZuw+RljAEql/jugc=;
        b=fJLr+//VoXdwRLIWIHXRvxIw7in0gAIKw5wPxSCWYGMZoCYjAB8+6PL0xraYRrf1vW
         pKJ1NWqSrPKvFVQn2FV/6GoNt6FESj6zfk5sUEskYWW+X8706lIfYmWsSFo2Y5uKoKP/
         m2nbQAgGCT84/kloaFxyHAELn1t+EuzE4yVzRGJwBaVp5GArvmlXR1rT9GJEzisVMk02
         ccIwmPqkakyeKrGaX6D+UC/By8QPxK5o40gJQ+KJBSKdGo+9rNpGMPBqfJX84iThlJAz
         BaD5bC+jIFU+9Gx0oi+7QyePOP0QtPAdCTG8WwCxcyvbkKI+l4Yo6mQJfGrdFmtjlUau
         FzVw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kristian Evensen <kristian.evensen@gmail.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 07/22] qmi_wwan: Add support for Quectel EP06
Date: Fri,  9 Feb 2018 14:39:56 +0100
Message-Id: <20180209133934.576203467@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133934.024795822@linuxfoundation.org>
References: <20180209133934.024795822@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591930962484755065?=
X-GMAIL-MSGID: =?utf-8?q?1591931257843749642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kristian Evensen <kristian.evensen@gmail.com>


[ Upstream commit c0b91a56a2e57a5a370655b25d677ae0ebf8a2d0 ]

The Quectel EP06 is a Cat. 6 LTE modem. It uses the same interface as
the EC20/EC25 for QMI, and requires the same "set DTR"-quirk to work.

Signed-off-by: Kristian Evensen <kristian.evensen@gmail.com>
Acked-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1243,6 +1243,7 @@ static const struct usb_device_id produc
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0125, 4)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0306, 4)},	/* Quectel EP06 Mini PCIe */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
