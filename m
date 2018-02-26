Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226ytSCO8BsvQ0TmBFIeIaga/OWW46kSDVxZeekUpTsujE1vO7w6zCVE7OOxwtla830OQzp3
ARC-Seal: i=1; a=rsa-sha256; t=1519676733; cv=none;
        d=google.com; s=arc-20160816;
        b=TwIlhMKau6kE/9e9n1zGvIOje7jjZ3smalMUgLAHvSR4+4VIF79BR7QLnsk89gKZk6
         bzm1cuerliNwVuG1ThTzmi30rGj9aCPRZUDhceJK/sbSW7LFVkYShZNcDSeLRc7WJZ/p
         70/fjq0qX0HMUR3CQ64dIjOVg2ateCVEcFgbO9bkRgMoGoxQoWq5PI6I94j0hHyiW+Am
         7btsmEtOvF3oQUSTovLEJCnNG2tgxDNy8NBsepydHY/3x7M8Fl2l71PSeL/CO+GfALuX
         QOCvHo9jIVmYZymL5dr8DuwSDbTGHzoWD1LsW+SEjBgN7GpQiFgwB6CKiMMS8LnrROKB
         MbJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=tYGvNq8xlguW6kboZoXhBs6qgVhyjPZsEd5ZFMWpDHE=;
        b=BxXC1B6vR8RT9M1D6EEeNLfBR5yPXIcM1G30hTEexWFXFW4x9TOOZuccMhGUDwKhyr
         isctTvtTcqhUfG3U5LgTqqtJuz0kjv+Wf6KyKJDOxmu3P0jLXtrpa8iwO5I8nuNVrUFi
         nHD8b54HkzxdsMogBkAC6JTEa97ms8CQT7ivaAOJh4V4J61aszsnr3Z3mc+rwA/PCb3k
         sJcC0HF9kcX9NnjaddndCNcLm2uZiFpEK6bfqfVx6lDpSjQ3ZK9tBsh1Sz4MepeU0zX0
         fI1ZmrDv55jqWytCDZpPgFkTgjl38d0hP0B+Zs77c/FKxAIvA8qR36vW2CaPTmAWGh2S
         1Kpw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jack Stocker <jackstocker.93@gmail.com>
Subject: [PATCH 4.14 36/54] Add delay-init quirk for Corsair K70 RGB keyboards
Date: Mon, 26 Feb 2018 21:22:13 +0100
Message-Id: <20180226202146.176577559@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496000178812018?=
X-GMAIL-MSGID: =?utf-8?q?1593496550282213889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
