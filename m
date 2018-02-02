Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226r+6yDpvdz0HiaE2VrZ0duvbndfk5BhRCV4RQk5OSco2tXWhfnQEdsg+bpX5TfPz8XqFnx
ARC-Seal: i=1; a=rsa-sha256; t=1517591654; cv=none;
        d=google.com; s=arc-20160816;
        b=J+nSDEDJeoH4/BjDq5WJo3rTdS4qmCy4iuHaEx1EydhaJ9kHyFBUkD1iw6HkcKGY7X
         LV3v4EMo9H0TjdldKRstnr3OvxFgP6gBKNQ9XsGMHyjx8UaHG1bfTfVScknR2kepgy0x
         Rrosmt9hhhY1Sji/yslCeoxz2DaanPZmeX7oycvIICxoGsmwMFYFr3hGlvcIM36ve+kE
         4gFfjY9/6Vg3/v+Cifg/KVvo1t1WxAV47s2GgtLHNmAFSB5UZzoH6PWTFt+31bF7ZjL1
         J50FxcFHjtHKH7eMz0Ud7i3e3qXZY/+0Jd9e2JXKweGk6NsIK2w0bEa+0gVEBk+b7Jsf
         77YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5aDUcjqOiF19Nnk0KOHBA7xKIwuTLUs++laNBQzDvXU=;
        b=rHeyn445Kvy8gIbH5uL5bwpmHxBnSP/TsIdDB4nQB7nR88F9fStc7/PsDG4w+G+dtv
         aCCGSDouRlPul+F7+TDZuB2SxArEZ8zsAXbBGWVRVzbHvecesSGLbZc8AGNjtMh12v5h
         t/gKI9Xrf45+4QutJJiVX4boEZZGJpiHEIFwqNHC2iWvmcQLwUGeOqE0ykSmmbzdc61C
         QVATTmZuZl2pRKbtiQMBpIIVzzXtaen5lJfxyJjaquuvwWkPuILH+iw6BSTNqlu/Xk28
         ot+9LMKI8jZoTUVo0V8hK0sM83hNz5JM00cczJSA9in9RJ/2R5XJiIF7MLwE9r+OqztP
         /D9w==
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
Subject: [PATCH 4.14 133/156] usb: option: Add support for FS040U modem
Date: Fri,  2 Feb 2018 17:58:34 +0100
Message-Id: <20180202140846.389149171@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591309409648037799?=
X-GMAIL-MSGID: =?utf-8?q?1591310186576160481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
