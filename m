Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpFH+uc4msGQhA9y1+EcbXgTrnUOQLFuBnmYHp9m7x+/+MuqyYGyA4htkry8OrOP/NzcG2i
ARC-Seal: i=1; a=rsa-sha256; t=1526281015; cv=none;
        d=google.com; s=arc-20160816;
        b=QB3mWHCXFz2tuzHIb5w517nY/GGBbsdSoeXN6VdJnZK4+L47QYbhsFmP7nT4oxEsPC
         yxmW9ZEZCvNz0jgvcguOVKm/fc60TOkbwYxm6BSYmk7t5uuYuNi/RYz4fOzHh9RibVKO
         kF8ndvLYWQyy1aut9YRKoWyIiu3CB008z8+nd36PH0Kt8Iaua3IxxYqnFXlYD1LXM2dr
         2FvXugFN3s2I+p1E+WzHwQl+dgH1Bp9ezvpxtrakH0AEvGUjp3RDVUhdESTWdnS87y3Y
         XggvDhd3ciokjO0oc6+P8GPWawrH/aJGVx3Aak2zAdKH32KmA5Fhir359bmB+Q313in9
         Wq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=fpBLG/rEe773omuXeqY6DGGoHpyheTQ6pEneqge4BHE=;
        b=SKbvA9T/V2I/L9s+K0r0L+rJx92onK/wbd4wBz8hTFU+mRpgKEztjh+i+PUHNlyn47
         APEN6ioJZ/ZXfWBz6X5FqDQlCcn9QLfoBFzBUWx2Xmmq2sC9ZpHwHq5forj5u9eN6ibA
         4ztVeoB1TWNWYtx3qhnVEM5IRkzLH9/lkOEkp4gTgC29YbpKFJh32lyeZVUQ5novW7vH
         tqPNEPpW6sMuCMitrEcUJVu+g6zYYBWX7WncJX2EqgZvjpNAQUy8NlI/OM2TNG7zjePZ
         faLoQwUaMU4mFrpsun7HaGT8jiaYac7n4njmCKvIb1tdpalS4GXF7JQEbC7wQ9ec78pd
         l7AQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ugf0xoeP;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ugf0xoeP;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.14 47/62] Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"
Date: Mon, 14 May 2018 08:49:03 +0200
Message-Id: <20180514064819.113443493@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064816.436958006@linuxfoundation.org>
References: <20180514064816.436958006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421385600199153?=
X-GMAIL-MSGID: =?utf-8?q?1600421642255013149?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 544a591668813583021474fa5c7ff4942244d654 upstream.

Commit f44cb4b19ed4 ("Bluetooth: btusb: Fix quirk for Atheros
1525/QCA6174") is causing bluetooth to no longer work for several
people, see: https://bugzilla.redhat.com/show_bug.cgi?id=1568911

So lets revert it for now and try to find another solution for
devices which need the modified quirk.

Cc: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/bluetooth/btusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -235,6 +235,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
@@ -267,7 +268,6 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
-	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
