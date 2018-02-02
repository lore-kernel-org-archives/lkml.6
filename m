Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226hCpR1z8UTtfLU2ebyVIoefgiugTvPNImYnc8kXxYXbbQSA/eY1VurBuzlnFVomfyTUD1t
ARC-Seal: i=1; a=rsa-sha256; t=1517590915; cv=none;
        d=google.com; s=arc-20160816;
        b=CGxWTPy9tF/98s3cZN5di0nE+EScvXum+rYAKzYsOk7I+1oOds5mZnVDFPLMSieDXV
         5K7FFIGuawyhhh0298JDGn17fjPV5YzdCf7yvZBGXz/SC/EEKjNv0Zk1u4P0oUJRulEa
         rHSfS3axSmI1NNe281Kj/bxIon24ZuZkg8DF/JnrlCZjcWul9JsR4aPKxx9w4bAZi3bR
         uJPXIUdPVuow/IDx6DFr+bnPviCwe/W+tQgdmkPDm5SEXH75jElZO45jzcwxkjQsYV2H
         L2wIEdBBNBr9v5RBd23ZompF8jtH0aK/cpYp4CfkzRXlvXVzjt2HI7PScfFihyoLW62V
         gNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=i+wZaluvXm0KZkNOA0Glu3lWt2e+ZTGOmVDI2a/ww20=;
        b=XzajL5/23JeUnYFsENOXVfRjzg3yeZ87H3n+7Ws/xiipjqObYxQVMBCg1iyUmWwyN1
         q68DIzPEnAdHK7ES45YLcFdI3Ifz7nFQs2KoBa9Xgaxg7keyjZFgl+je6DC3791REiEj
         rjfkNnHV8L/3EKz6A0yhZ8qGfkdfhiRFGZhWvjSh1XUmOl6CoO7Pmil/H6kcMHQt5DwB
         x5/teQ8zAFgQGrxhmoMJh1C2015UIPuGXVDo6ltaUGSRQqHrtutWj4s6emGoWWl+moBj
         DfFZabXHl5zUz12uxEAU24wvThySi5AUj1yPdoc/n0TAbl6PMjWxY8TURlH/6nlZiDiZ
         3HWg==
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
Subject: [PATCH 4.4 56/67] USB: serial: pl2303: new device id for Chilitag
Date: Fri,  2 Feb 2018 17:58:25 +0100
Message-Id: <20180202140821.451491209@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140815.091718203@linuxfoundation.org>
References: <20180202140815.091718203@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309411957795471?=
X-GMAIL-MSGID: =?utf-8?q?1591309411957795471?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
