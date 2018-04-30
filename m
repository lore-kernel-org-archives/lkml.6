Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrJohvvhm08Xkskd+Vn4mIbke7SqcRfOSfcCfY9+W3KU6Ki4GAcNSyW7UDDb6ktvvX/VPG7
ARC-Seal: i=1; a=rsa-sha256; t=1525116244; cv=none;
        d=google.com; s=arc-20160816;
        b=jfNiFR8dMA+Dlk8ZRhhyU5zJKkC5YIwMzJkZVhv0cXaZ0O0vhLI3KNHtXt/rg+cD+g
         YM/+jGJivx+2H2EdaNHouJCJMnAI3XaNfXZrcCjQNtLkU9kJ7h0diUpvCgolVWZF7fae
         QpE5K2C0k0wilFzr8glakxdJqNQrMoA8R+Pq3HjNG5cwOb6TNMgg5crpAKUaoxUAlgte
         pD4LOKP6cf6YD3yALc4wH7bt9Tp/+Xx4qJW0hyuG5fY4uZ2hwCgWIbkBF57bHfSLWAAR
         GgxG5xnkWSR2cjH+Hzvu+JGM0EkqMY/9/pAl6bT1EWlW5RNXciDZ82gpcBxe6KtCNoBk
         WJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=Onrzl80H3zqVk/KGWb+Kd+rXsyTFAzYLNnI1PGh9ZY4=;
        b=nxs94W2gehqZA8hUdWjBo+oYYOY5cGoum6LhuZOTIuJJCAioYbUbd0byj8H3y3cA47
         ZSGShgum43rRHp0Bk016D2aQpElpMahcCiMlWysTpxMkfq920Dxb7/RJyOSBfOWxenpM
         ZEm2bTbCIuGP9z5ig6GI4gq0NKXdTbT9+x7F/6sP/EZpUj4qkEKA0IlqCWTjOcB/xAwf
         c9NseIHh/j0KsSU6LG5kwob3eI8ytodEfCbUEw3dOULhlKhnP6SbuEI0nrPTRXNw8oZU
         gykff8FReJJSXEFxSuKDmdLRGlc264BSxYbF1/I07/wWzjbArMb+zSYpDbACiatc9w3U
         fwRA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402E822DA3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kyle Roeschley <kyle.roeschley@ni.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3.18 07/25] USB: serial: cp210x: add ID for NI USB serial console
Date: Mon, 30 Apr 2018 12:23:14 -0700
Message-Id: <20180430183911.122368044@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200291501783641?=
X-GMAIL-MSGID: =?utf-8?q?1599200291501783641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kyle Roeschley <kyle.roeschley@ni.com>

commit 1e23aace21515a8f7615a1de016c0ea8d4e0cc6e upstream.

Added the USB VID and PID for the USB serial console on some National
Instruments devices.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -207,6 +207,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x3195, 0xF190) }, /* Link Instruments MSO-19 */
 	{ USB_DEVICE(0x3195, 0xF280) }, /* Link Instruments MSO-28 */
 	{ USB_DEVICE(0x3195, 0xF281) }, /* Link Instruments MSO-28 */
+	{ USB_DEVICE(0x3923, 0x7A0B) }, /* National Instruments USB Serial Console */
 	{ USB_DEVICE(0x413C, 0x9500) }, /* DW700 GPS USB interface */
 	{ } /* Terminating Entry */
 };
