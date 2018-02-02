Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225U4eP33f2IGc3V4m5IPsxRJhxXXScXjdBD40TGW/WCNgi9YUiUHBMoTFTASwYfErfuGi/H
ARC-Seal: i=1; a=rsa-sha256; t=1517591566; cv=none;
        d=google.com; s=arc-20160816;
        b=cZsDcOZrZHg8/yYxywaoxdqfOA4KMOupa1ZQDcAAeB2KVONOe4k4mbD+XCdR0dpqso
         zHOA2UPSkuEt4xnDWp1xJVD/fxMXDnI2M9UYyberHhHaY1+A9jziX83zFraRYuduVraH
         DPjZ4CAUyVZBRG0E410VrlobbDxlsv2WAhG9MAEjMcs/FlCz1gKA2iLh4xNXDpUSc+2F
         c4ezISU61JVr3/3cvjzpa2lejsiQm4TQVEfet5leuZhDY2rsLgSJ0nyL5orJ5U5aSMS5
         iAdEFmHpSqR3IiqVEEMLdYdbBRXQqrDMWbUGaQGvLzlKKdoQpmstprUtSMwpGaE0oVwK
         uUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yntCMC73hAHJRuFRetS2q8xjbQcJdinPv1qkX6W7Gdg=;
        b=u1PP0qGaSgypDI5arWFsmTL+0xuGZY5K4WD1xWmmmLYfG4Z0nSK7GX2Qphbh0JqmB9
         BHpde50r3IgWKWhXLWd+15a9sRY7ShhKPkl0Ftefmp17U1Mv2HsxvKHQMY1qpl8+YLi9
         g4nIM+EO/u4dV/Y7u+4RWonXdihpu9CamlcK2+Cu9wl4Dun1P8CBwEbacj8o+W/RhjiY
         s47Gv/hY+KBlO9Ic1XfxBz4OVuHz1cehajllPM/7+mDCXLDO/3A6MlJxNf/0Ub/GLSRi
         +AjBJ71i7KsgXCnwg51sDm5VOwCYBExj8OBcknrPfV9i1oMBobG+9Y8N5UYR6pRBOhaT
         mn/A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Icenowy Zheng <icenowy@aosc.io>,
	Lubomir Rintel <lkundrak@v3.sk>,
	Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 123/156] media: usbtv: add a new usbid
Date: Fri,  2 Feb 2018 17:58:24 +0100
Message-Id: <20180202140845.918637519@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309398323406308?=
X-GMAIL-MSGID: =?utf-8?q?1591310094686692356?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <icenowy@aosc.io>


[ Upstream commit 04226916d2360f56d57ad00bc48d2d1854d1e0b0 ]

A new usbid of UTV007 is found in a newly bought device.

The usbid is 1f71:3301.

The ID on the chip is:
UTV007
A89029.1
1520L18K1

Both video and audio is tested with the modified usbtv driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/usbtv/usbtv-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -144,6 +144,7 @@ static void usbtv_disconnect(struct usb_
 
 static const struct usb_device_id usbtv_id_table[] = {
 	{ USB_DEVICE(0x1b71, 0x3002) },
+	{ USB_DEVICE(0x1f71, 0x3301) },
 	{}
 };
 MODULE_DEVICE_TABLE(usb, usbtv_id_table);
