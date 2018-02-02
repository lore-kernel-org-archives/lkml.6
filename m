Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227kcc77xzrNBYEoRWc964hh+Gh1l9Gys8ugLs5n2y988pBi773eoQQdxX2HD6TRac1SVXJW
ARC-Seal: i=1; a=rsa-sha256; t=1517591167; cv=none;
        d=google.com; s=arc-20160816;
        b=FqI0CirAxMUfHdczQAaZfhIvq4Z5LgTxBlTXlUPYEG1UQaSoiDbc9wCaYnMSLU3cU8
         PXbkeVETp0RLxWDhjC0hi4uocsMIH1R6iDaN4HqYHnfTaKn8rvLV5XG6UrcCeAvIYgIt
         xs7wDWgcgj7m07MS2+MtDIEVXW/vGLloxjo9WAfJcogJ1FCx7KeHIK5ibXXh4Jseau9i
         kEa1/8YluMGN9a0aZsmO1VT367pLf6oK/dtxU5p9AWps0B5KBwXk41jz9MMb/oMM//HQ
         +9kO9RFhF2NTn1sv3AwQ94WhqtyajRBZ5/JK5bYLBg/U4mCJsY5Tw23po+sSgb9yEn5g
         td9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=znJSDbFz00l0/z6KIlax3wHEubk0oUM4bjMy8/eC7to=;
        b=sbDltnBroJjSXfUTiuEK3EqMAzC900XxYSYLmOaM/MPTW31IOP4P6nq09kp3Q+JKc2
         Su+IVmZRJWMhXIPVLZ7cTfs+D9yaUPkLNoMaxfeF2KiBuNuJDJbk/1kDvOa1Zxk1JBH3
         aw6orwIUe57AkL95K/4cSI2YnVYGgqTZZXHMjSaLFUPtY9+EeuWKj621sM4yTblFD325
         kjbzVtuMUXdmHsaqoGaIthGlq+Rt6L8Fpbak5V+wcdbj48QP2WgBg7C7seQvBRAQDuOE
         OU5j7P9jTTi+Hpw7OKOngi1ije0NUqKxefM2vpPDjyaAZ1klUY+u/yIEZFXLQ/O7dqDl
         CTQw==
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
Subject: [PATCH 4.9 74/86] USB: serial: pl2303: new device id for Chilitag
Date: Fri,  2 Feb 2018 17:58:34 +0100
Message-Id: <20180202140829.520877600@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309411957795471?=
X-GMAIL-MSGID: =?utf-8?q?1591309675835421733?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
