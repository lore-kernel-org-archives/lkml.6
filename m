Return-Path: <chunfeng.yun@mediatek.com>
X-Google-Smtp-Source: AB8JxZqPEG/8GgAzzlytYBWjtGBm1isXAkupcU+oa3NlVBLJE8+8wtcMDAh7yx8vFmK4k/12Ykt8
ARC-Seal: i=1; a=rsa-sha256; t=1525865771; cv=none;
        d=google.com; s=arc-20160816;
        b=sa4JhUevhiL1F/mo6+hlrrtTO/BVTHHr69K1PKZvXifHZyNaNH4DRtrwIx99+m//9T
         jZnzpJgMCV48G65i4z0kVkRBdagr8WZCpyjcXSChzgZOe76LWc12+bkpzGWHqekNVfrF
         dUI/YSjGQa+Js+1UddCozNYG9FupnI5RiQ6d3zZ0X37Yk0KkXU6oIm7k2vE5T0IhLd8O
         5Y+HR2dzc4J86oMsfC1wkaAEFQ3bo2N7ElJZ+YMNGpcrqLcKHIqLdO/gj8RZOYF1Z+Sw
         J2HxrqBm+3bqHxn/Y90k1uGWBtLbF3kB+mRasirjKJgqQ++0yHaafUNGxVW7gk4rv86i
         bhkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=TM/fvOfDgJ66A9g6kkvxNsZ4i4YcdfM2tP8i04PNqQ0=;
        b=Y/iG5/ho4KZoPbnh6i/vfMmNwVbAUbR0blUTaPpJMoTWIM8f2Du0mT2UP6UVy3iFOu
         +Z4FZewk+BmMFUyEFN3OX0GIo132f6x5Rxh5Zt3/jwMRqdBm9zyhMrFv/2vtdhsRaa58
         FM3Beq0uKQh8BO7qaK16+yTfrQfI87LH+wqVftLDL8X967tcEEZCH6NVxe3/QXaxXZVh
         3dwq5x7V5S4Ni4pHoDSHCiKtwRkoZqlQAjJfXF/5OWdaW0md3Fx18kBqgdsH6i5TbvMg
         vs62cj9qsnfCEn4ANRpGWxyY070fOmufAY0/wc50kKhiHRQENvRatie5PdsUgr4NIS5B
         yLog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.81 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of chunfeng.yun@mediatek.com designates 1.203.163.81 as permitted sender) smtp.mailfrom=chunfeng.yun@mediatek.com
X-UUID: 2eb52b308edf4afa9c7e26bb51cb0733-20180509
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi
	<felipe.balbi@linux.intel.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>, Chunfeng Yun
	<chunfeng.yun@mediatek.com>, <linux-usb@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] usb: gadget: composite: fill bcdUSB as 0x0320 for SuperSpeed or higher speeds
Date: Wed, 9 May 2018 19:29:16 +0800
Message-ID: <69cc710fa8b7d18c494c9f482fd2b8e6fb7c0c94.1525865206.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599986136874105880?=
X-GMAIL-MSGID: =?utf-8?q?1599986227089452801?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The USB3CV version 2.1.80 (March 26, 2018) requires all devices
( gen1, gen2, single lane, dual lane) to return the value of 0x0320
in the bcdUSB field

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/gadget/composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 63a7cb8..f242c2b 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1601,7 +1601,7 @@ static int fill_ext_prop(struct usb_configuration *c, int interface, u8 *buf)
 				cdev->gadget->ep0->maxpacket;
 			if (gadget_is_superspeed(gadget)) {
 				if (gadget->speed >= USB_SPEED_SUPER) {
-					cdev->desc.bcdUSB = cpu_to_le16(0x0310);
+					cdev->desc.bcdUSB = cpu_to_le16(0x0320);
 					cdev->desc.bMaxPacketSize0 = 9;
 				} else {
 					cdev->desc.bcdUSB = cpu_to_le16(0x0210);
-- 
1.9.1
