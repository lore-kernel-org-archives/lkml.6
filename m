Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2249QvcnSDwC+LqR31Tg4dPfF1JLKTtGDAxS3Sj9ZyuYt5XIl+NAf50fd0RoW7unu3HtGRqL
ARC-Seal: i=1; a=rsa-sha256; t=1517591164; cv=none;
        d=google.com; s=arc-20160816;
        b=jrJKoMcS52+OfMccO3cXPkA0dPnjqfhpJkSQO0PDepPgGDxUrXKvbTt5VfRiwTkcHY
         XvvM0lhtVbEllg6tA+psytAv3qRBeq8flmDAbmASKzHM05BrKXPsKfVZDXI4aUQ0zIVW
         /C31M3a6da3op91Cel2kv5pdMFzWOPqHX+HajQsAGw1qJmbKXC07wuxqrjrgpnJCINEm
         /XpJl1zDkjIhRV43iB/Gf6y7+SdnqQYNzsCJDt8GXuIXNxpVxitdgxpCFlQGqGvohlE2
         46qP/pZX05v+khwWN0ZHRbL4Ch+M7Xz44Nm0q/DVVO6ShS2eNDEHzTvoHgfbOFrDkLvQ
         7w6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vPJemg6aLQnQ1CFRs0K8w86F7Z5R/fFHt7YXNChTugI=;
        b=YQzhH14kDWc93o2XFispUaTaozwCxV1w1uRemA+qkyLYeNE/nUaxtnxrA4Kfte1xqT
         hQYT1ypufbXueU3SIn1xWyXA6ZUNJ5eXQEPq0YHpsErhOUkQukY9JE0A3h8RhM1ztS7g
         71ciTrVa3qirhsTaVS8/lATkvKcSqIkdaxHZkiBcFbqNiYNNQMMpd0hpBebk22srQcrG
         NYJHcT4r5N1haqrSLDR4gtx+5Q8HlVZ/4HfQGWGvJgVUFEECOV6ycl53rs2rL/N7p/1o
         IXYd+i542GJdSyUMo4CpTV/oautxuXkT7l/0r7di+XCvg1FduGP7mfkRubIez37M4PPz
         pYRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>,
	Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.9 73/86] usb: option: Add support for FS040U modem
Date: Fri,  2 Feb 2018 17:58:33 +0100
Message-Id: <20180202140829.405384351@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309409648037799?=
X-GMAIL-MSGID: =?utf-8?q?1591309672539145625?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: OKAMOTO Yoshiaki <yokamoto@allied-telesis.co.jp>

commit 69341bd15018da0a662847e210f9b2380c71e623 upstream.

FS040U modem is manufactured by omega, and sold by Fujisoft. This patch
adds ID of the modem to use option1 driver. Interface 3 is used as
qmi_wwan, so the interface is ignored.

Signed-off-by: Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>
Signed-off-by: Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -383,6 +383,9 @@ static void option_instat_callback(struc
 #define FOUR_G_SYSTEMS_PRODUCT_W14		0x9603
 #define FOUR_G_SYSTEMS_PRODUCT_W100		0x9b01
 
+/* Fujisoft products */
+#define FUJISOFT_PRODUCT_FS040U			0x9b02
+
 /* iBall 3.5G connect wireless modem */
 #define IBALL_3_5G_CONNECT			0x9605
 
@@ -1897,6 +1900,8 @@ static const struct usb_device_id option
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, FOUR_G_SYSTEMS_PRODUCT_W100),
 	  .driver_info = (kernel_ulong_t)&four_g_w100_blacklist
 	},
+	{USB_DEVICE(LONGCHEER_VENDOR_ID, FUJISOFT_PRODUCT_FS040U),
+	 .driver_info = (kernel_ulong_t)&net_intf3_blacklist},
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, SPEEDUP_PRODUCT_SU9800, 0xff) },
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, 0x9801, 0xff),
 	  .driver_info = (kernel_ulong_t)&net_intf3_blacklist },
