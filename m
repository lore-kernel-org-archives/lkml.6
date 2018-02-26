Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv5bck6WZHrQdOLTQuF3Vypdui2xZ3wa5NKrBjQIStlngBlSNcZwpWfkFjANvWTQ1SRAx6V
ARC-Seal: i=1; a=rsa-sha256; t=1519676491; cv=none;
        d=google.com; s=arc-20160816;
        b=on8VCpsvgUspi2VY/ysa9sAJfSztEDicje/odvVJKVBcSm76we/AUNHJZuDdK+ThDt
         4jlHsuKd3o941Q6Amm1hZsec0K487OUJQtIFZVj+1isDUinIbjZN80mWJwD2njr+fRtd
         uw1EAx13zwT9ev/nt5X8SAZ+dhVsHagb3aeMa4yy+BYnQzE9zMe6H7FtEmRFo3DkJPn1
         r+zgg+klsqeK6vS8NleAnLEkkWh61cFGEtv0hDS2KohcRPQSKlsapsoXmCcAh/KoyhKm
         Tp0fxoM84U9TkXA/5b4R26oMgp8+Y+QUAYmSDOao6feHPltgDBcq+Nw1fZQlyhGPzM+V
         RJzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=l/sQQV3BKMc9y5qtsaPwtz2CWvKNmkm/YLym/sHJ6tI=;
        b=mZ4nFNdNcsPh5on3OKCLIoeCyGQUse/UKrSllE15occu5vlYJMkHv0h4IAymY7205u
         F13OOig9fDL63N4nzkorX3kiCNA0Ox/9WiJIXZgWlSQ9cgKtnacn7mqUEVQRBMpVWZCW
         IUa5KwxjsKeNvnPuuA0uEQ/fc0FVAAQC4V/ifITKVNS3FvP79z6q7qUPIGXUOAgBNfgs
         minIoVKQoyik8fiuxufwtvH2M05OByZAdTYWs3HrIGvkXTg29H0sLyFisecaAg3FlRYe
         VswLaFgeY8PWXQX3cEtIPv/T22rkUmBoReJdGA2Ab6lsQcsVmmKhx3Qkms9Jb2jbGqos
         3cjQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jack Stocker <jackstocker.93@gmail.com>
Subject: [PATCH 4.9 16/39] Add delay-init quirk for Corsair K70 RGB keyboards
Date: Mon, 26 Feb 2018 21:20:37 +0100
Message-Id: <20180226201644.397375552@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496000178812018?=
X-GMAIL-MSGID: =?utf-8?q?1593496297447479594?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jack Stocker <jackstocker.93@gmail.com>

commit 7a1646d922577b5b48c0d222e03831141664bb59 upstream.

Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
Corsair K70 RGB keyboards also require the DELAY_INIT quirk to
start correctly at boot.

Device ids found here:
usb 3-3: New USB device found, idVendor=1b1c, idProduct=1b13
usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-3: Product: Corsair K70 RGB Gaming Keyboard

Signed-off-by: Jack Stocker <jackstocker.93@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -225,6 +225,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Corsair K70 RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
 
