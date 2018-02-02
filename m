Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2251QZoBC/FwoZIbs6jEDfmXP0aRt3r8eSQ0yv+rXiGdx4t2mZ6EHDNY5C47hFixbiBSdA5u
ARC-Seal: i=1; a=rsa-sha256; t=1517591752; cv=none;
        d=google.com; s=arc-20160816;
        b=useMMZAT9zuaFSlBGQliCCFmsKiAZjaCXqRxRJjWnry3heQV/t2mLgfasiLGdmF2c4
         MxV3NnFXEFTnm/vm7dlFgDXiJHsUT6ptx7hL78g+bioQ/dyaiMHXXaHBBGMYECMo0r79
         a42RPnzc9XBWPOxq2uIX5j+WHQCHvdEYGPtI9N92HN8ziU2BUk3z5kPm5xe1QxJVIxie
         l4zHlZewnP7aUI/HMYfXWQC03JnLawNzdOa3UqT8du5rRapCIpM/3sunSXnx2IeDS78L
         zBhSFB9tzSZf+embhr7qDZg1LNM+lrH0XwaoXD7fUj3hviKKxjCvz+G6lW3EyLTK6n0n
         X2Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=mKFpG/TJAopvynqA/2a285PhkbaKh4vWUekBpGuD+dc=;
        b=l7NipYCnkdQqKRJQ+s8zVUyL/MzeXd68MPXzVLSnWeuyddT5J0CfvQiYu+2hjNF67c
         AanzpHfJ4pMo2m6DiuQ7ZWGmjNU3AZBhmbNXmdzWyKpJZIq00ctlYvm+Nc7KlQUhZ3Gq
         J9IfuKgENbXGOHb0ZKbbWKPzsE7zvKHOzwfNYmVsE7Zjzy9I/ZDY/MvJw0/56fODitnM
         lHHot4n9gfgm8rafNyDbmzk32kkCrGBvxztfPMsf0pIutJkmeFCFzPGd9DgL5xj5m++g
         YMbf3P1xx3Df196vm6wyVyTIfgxoxhONLgy5j72UUlbpqycpoGtkQloKyd8FwocwmEX1
         TanA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Chu . Mike=20 [ =E6=9C=B1=E5=A0=85=E5=AE=9C ] ?=" <Mike-Chu@prolific.com.tw>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.15 32/55] USB: serial: pl2303: new device id for Chilitag
Date: Fri,  2 Feb 2018 17:58:50 +0100
Message-Id: <20180202140829.419159094@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309411957795471?=
X-GMAIL-MSGID: =?utf-8?q?1591310289925388498?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit d08dd3f3dd2ae351b793fc5b76abdbf0fd317b12 upstream.

This adds a new device id for Chilitag devices to the pl2303 driver.

Reported-by: "Chu.Mike [朱堅宜]" <Mike-Chu@prolific.com.tw>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    1 +
 2 files changed, 2 insertions(+)

--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -38,6 +38,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_RSAQ2) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_DCU11) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_RSAQ3) },
+	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_CHILITAG) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_PHAROS) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_ALDIGA) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_MMX) },
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -12,6 +12,7 @@
 #define PL2303_PRODUCT_ID_DCU11		0x1234
 #define PL2303_PRODUCT_ID_PHAROS	0xaaa0
 #define PL2303_PRODUCT_ID_RSAQ3		0xaaa2
+#define PL2303_PRODUCT_ID_CHILITAG	0xaaa8
 #define PL2303_PRODUCT_ID_ALDIGA	0x0611
 #define PL2303_PRODUCT_ID_MMX		0x0612
 #define PL2303_PRODUCT_ID_GPRS		0x0609
