Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224lyWCD8Zvou5gjJNNwR7n0/NkbGJC2dNHmmA6Mpjf8cwii4Y11/v8pxIQLJEpzattBwJtb
ARC-Seal: i=1; a=rsa-sha256; t=1517855201; cv=none;
        d=google.com; s=arc-20160816;
        b=PSlbONlQSU4lrkNLqmf03Tf0tgV4y5Z9zm02Qi8rtXhqqBPqOHwmtSN2/bOY3pc2RG
         wPdekp2HzTQOZmeIn+BPHeCHhxqbKszmsb5jFteKAsoFCOETSInhgyb9wZ8c9XEwIMmV
         wEQzBxuOFqg3jeYfLSFaq64/nhPgDGa9Gzgsv1bntJ83/pVHynJUG6eiflNXeAvS/WqN
         BbLGZIp8wocRERlCf272eSoE6adrwImhuHT6BnZ+BSXLYLqmdXmoneyG1Ah60JyZ6fDk
         Jr0QvKPqNgOyQo2OHD5SQznGEfwSeJrFihVInBK3rI08k2vN6FJj7OeCP9CZdebEwX0k
         7eUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=F+7DGlCEkLSsKyboW9EQbQ0fIuJF/LkK6BmVjCMqxdo=;
        b=fUka31d11flA3e3mpk6S0qKBokOw5hKTL7gkI4+nnpBP5e0KADYbKuvx6pOM/Oa1DD
         ZM9VUY5kghCO+zGNubeZojtFNW63C66d/0IXcdntEVrVeDjhJot0pnfLER2N2U+mrhk8
         MzKGGxC8063rNeW+/5qVjTETqqgd+RwvE6dim9TTpGrSFu662A+RRIP+zvU6T5ACQJOO
         2sLd0EQjDQgDjOBYHPfTU9MshkIIO6ae52tRXNdP98tXkcx2ztTXgNs7L6NAACusJ9Gu
         orS8PAbeus3xjWi6myx4G40KOGAI1LquMp/6qI7Vk4U3eiX17RohYKhN1fcBg8Ew7y6f
         5TCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"=?UTF-8?q?Chu . Mike=20 [ =E6=9C=B1=E5=A0=85=E5=AE=9C ] ?=" <Mike-Chu@prolific.com.tw>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 3.18 25/36] USB: serial: pl2303: new device id for Chilitag
Date: Mon,  5 Feb 2018 10:23:53 -0800
Message-Id: <20180205182352.810460407@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182351.774761393@linuxfoundation.org>
References: <20180205182351.774761393@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586535876811663?=
X-GMAIL-MSGID: =?utf-8?q?1591586535876811663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -39,6 +39,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_RSAQ2) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_DCU11) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_RSAQ3) },
+	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_CHILITAG) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_PHAROS) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_ALDIGA) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_MMX) },
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -17,6 +17,7 @@
 #define PL2303_PRODUCT_ID_DCU11		0x1234
 #define PL2303_PRODUCT_ID_PHAROS	0xaaa0
 #define PL2303_PRODUCT_ID_RSAQ3		0xaaa2
+#define PL2303_PRODUCT_ID_CHILITAG	0xaaa8
 #define PL2303_PRODUCT_ID_ALDIGA	0x0611
 #define PL2303_PRODUCT_ID_MMX		0x0612
 #define PL2303_PRODUCT_ID_GPRS		0x0609
