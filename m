Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224Ts65e6P3LJmTEd2qlRCT6lD9dgJC1KHwKVX6Pn0UZmAQgTndDkOF0vY26fiYKSwujK/72
ARC-Seal: i=1; a=rsa-sha256; t=1518183672; cv=none;
        d=google.com; s=arc-20160816;
        b=QJ1js4oK4Uo3RxuHv4KNQF3uxSBicKkqglbatFOXsGvipHADdqMNwOCA8D+fGy+AHZ
         U+woerDf3+f2R5NUABsbx0UIjc2GKboDMaLYHAY+4zrNPqo9HqJtnEwMCY51OCs6AHqz
         WL/WmF8m68jMHdND6xJgMszoACWlG1Hh/xbTbv1biGpAoUmL1XFwNT9EIibKQjMsnqtR
         Z+nhWFBBqTKQPsR32/U8jmOrowqRxKOJsR8Xr64iYfVrG6bkcYTENog1YhX4oyWK9D7E
         ujp3JNfju39TwcX1nxNOzVer/2BMOI9iBWApU/djCF0Y9i9NWiktSceUBOR/lb6ywUWK
         8ECQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rfhD4M6Z3fAmbzEEdN6i00UDjDmenvzxqWwl6HObAYI=;
        b=ARMpVzPH/G+iDmEbAPFw+QgIPPRkEWShL4AKgZOoC3vtlF8KNfTzQFrwZyedy1TsGw
         E0k5sFExmvRRhIze4mxzaiJAsPiuS458n4sevD03qrsR99oJQRYZYcZQBrELgwlYiGIq
         i1l1WPOG52ygPBFadvaUYHYuPfRfbg+A1ivun5MoK5emsE+KLx0W8VS36k3qfJPqmioU
         myGEN2IqYdw7D5PDYtp2yrFIkls2pB++KHZ3lHNcigXnH4J00cuNCEMs9/uR2ylKU+Bu
         ENe3XLdzE9z3lMKo0+Lc1hXDIPH12CAcIBcgkAWROwmtnjmlN+DPiR8hJ9lQmRkewO+q
         h4Fg==
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
Subject: [PATCH 4.9 22/92] qmi_wwan: Add support for Quectel EP06
Date: Fri,  9 Feb 2018 14:38:51 +0100
Message-Id: <20180209133932.896844267@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591930962484755065?=
X-GMAIL-MSGID: =?utf-8?q?1591930962484755065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -944,6 +944,7 @@ static const struct usb_device_id produc
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0125, 4)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0121, 4)},	/* Quectel EC21 Mini PCIe */
 	{QMI_FIXED_INTF(0x2c7c, 0x0296, 4)},	/* Quectel BG96 */
+	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0306, 4)},	/* Quectel EP06 Mini PCIe */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
