Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225eDHb5C+/phlZ+bXHlIE0YUviSAr//an8pqmsjALeKjwvLuZMbGcjci0aNovDt5o4keoat
ARC-Seal: i=1; a=rsa-sha256; t=1519676209; cv=none;
        d=google.com; s=arc-20160816;
        b=UCqcysOHjkv8tdsumDFZwyAi/Uyv3jzNya++2q7Seb5gxhjaYpkXEBXBg58bpIoLCv
         fG26hwNSRWFB0aHivYrE5fV0dmfybv9z3PQcagz2zC1tPFZC8oeiW3JJ2HHEyPoMdZ4R
         a98Fj1PgWwy3dBU1ndDr9lG4NqaJ0KCYviTqaY8UeESvjBX8vVJgRaOooXEgxvsvbDtJ
         SOrJaJM7ARCFE2CVAzaT3pmvEuK/MAQg9Rp8Kbw56GqhQCOb1+d4c2X/7l3hrZB9z2uL
         CYnR3R4hPJLmgWLQ2v8y8VOnXvCzdjYGH2+EBLtQk1dzqXzGgzR8fVl4owz7pO2n7bh9
         Ofzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iQp/fmcTr/FZb4kdrNvlfbYJUTYiU5GOch3UXkIAgMw=;
        b=g4pc1uqL0MFi6ec8WTlVY+MHfrmap4CS8WLT9QXahZbTnkSziYsPhUbY4WvMmhcyp0
         /h/ZoEkQBd/Cr9oiTttw4RCFKVl533tdS46iNGLsE+ByU8xC+6ucO5iGk31JA/C4/UJV
         3UMY82mwCHkUlyOMXxpWAOzfyDK/29wPCLLJWozyv1je8TDpQrMqmPsenpUfrCjFsAl3
         BBj93qLMQjLICb9kS71iiXLzCVe/LGsjXo+sS0/6o65SPFj5PHLo36ofRJhI8QnnI35d
         uI+/mPBdiHZEeAYwlSK3amaov2NZDL56Oe3FqwwkBVn74Ztw3INxkECbwRlbwqT0wtsZ
         wG+A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jack Stocker <jackstocker.93@gmail.com>
Subject: [PATCH 4.4 15/22] Add delay-init quirk for Corsair K70 RGB keyboards
Date: Mon, 26 Feb 2018 21:16:15 +0100
Message-Id: <20180226201559.393477489@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496000178812018?=
X-GMAIL-MSGID: =?utf-8?q?1593496000178812018?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 
