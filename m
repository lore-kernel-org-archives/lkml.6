Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224J+rjAzqL0xgODOy0QsmCPHi37BWFLb4CqWL9JW1wR00x5/Q3DXXcUkM2ZpbYH89hBMWgo
ARC-Seal: i=1; a=rsa-sha256; t=1517591662; cv=none;
        d=google.com; s=arc-20160816;
        b=xp+K3Lt3cSQtmsmmVJhvXak3EjhI8iTHMfZ3O3Mau1JY3+PeZm0LPH7YHut1C+L4F0
         npiZyUQEHyBHqGYiCxjP3tW3oNmZxsm77BPNbn4/tEzVa0MdTeSJ8JE5EDuM8hfOH2rj
         ryOpbBmmnsSCEGA2Y/7OM4kd19oXh+AMCP9hyms+mKO77BuurOBpP9Gmsjse1E5Ih7BI
         DyYxkQTpbETL5bRETvaUKLKquOiXSROu0stuVsd2YdwTJjCCdTOdZTAZg2AM59Kj1exD
         hFe3EzX+Mbql1cPFg1GPQjA+yzUABF7noGV2SwZz5HHuZLLVbwPf/y19IqSbLna19+GL
         4iMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IScxSoGb1MVgcdFK6nQrcs8dXcggNg/6cd6Y/a6Y+/4=;
        b=TeyKWMQ+Yw2iMtETlvknbniLp/mhZaY6b6FXASWtzY+bVamw422MtAYouJv9+i6woz
         Nt3kmx5uxjfEmfv17XeoZPNfbriwk71mtcOuyqzfrCpu8/RSk4LVSRpdto1KRnBRYOTc
         j8ik+b+NwnAdeCIq3VvWfc9nfdAzItJXaNr45HUHbBhu4kArpecBut+GWbNtX1NDVv5k
         YnZNHTUZTmAtnZpji8/kS0opZuf/jp14Y5IRLmc/NHhQ28giKtnkWjOKd9W+hThDYS+5
         mh9baUFqiasFbQmEBK4tq22EhzpPsjXBs8O7hRh0GxzSq70kjAZFlbRYAwU30BAtOuhz
         GxDw==
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
Subject: [PATCH 4.14 134/156] USB: serial: pl2303: new device id for Chilitag
Date: Fri,  2 Feb 2018 17:58:35 +0100
Message-Id: <20180202140846.444794735@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309411957795471?=
X-GMAIL-MSGID: =?utf-8?q?1591310194812673510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -41,6 +41,7 @@ static const struct usb_device_id id_tab
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
