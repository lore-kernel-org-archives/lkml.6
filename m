Return-Path: <SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr46halXjzmdSC57c5JcDnkryAIjRJjiAaHtv1Jnl50842Q8oXu7D30SVYf1hjpbYjrMe17
ARC-Seal: i=1; a=rsa-sha256; t=1526280863; cv=none;
        d=google.com; s=arc-20160816;
        b=vWx0QR2VrOM67ZS3VllOLWdhTSruKRq+F9irioJ2yiXWW7MySuWw1dGlG1Cnz76QiK
         yAZu2QPCYh7iE7S4fQbSNUmLiuLbALGtc6OX6nDzZKDRMLTURgicE9siBdvIV4SbhCPV
         4gXkyoZs2eMJYT5Ar81ClIhxeI0hR+B8/6TB7uA8Oa7tD6asQ+THdZw9AHygQDgPqa6B
         t4s3t7Cmt7toKXmQZOZcbn807Ds98JOJoxQx0mYGPeFLy3GaM8BW7lbT9Ab4FV0NP+JZ
         yIC+cUiaiR6NwRrQ5GZwE5q/IspfPbKOqlcitXKk2lUmkJ5Nxd5in9BNXMR7ddSwRn0u
         tlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=x4GkPNQLW7WomHq1YE5mf+pGyhPKASG9vZMNwVoxKG8=;
        b=wEu5j/zOXnJgEFXNXPzWiWH8evGM4gYX3imabS6m/PRsXlseUkQVNXUHyCy/4rY7xc
         OwQ6fXMsTUtjZLqVYDcVgSLXIP46upQENVyGF02HRULdTa+NJHaF/ce0MiQFSrA3iemk
         Bar4owdk/h/+30BS0N+HtzwHcbjzw+OPhjm0AbgI5xfTpkh9Ji2k3VighxHuORIcdEi+
         Opv4mIUejv8aUdNeB6tYu3R052PnrnJMSvX6g4cbaMvp1THyd2UYn1C06vaWpQiOUIXU
         AqOn8ScMw6sBdMLuMRNa0JpDhEgUgzaBFUhuc53CsnjxE6pPMxlHC/6GxtrGrquAvxKn
         1RVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Suxss/m3;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Suxss/m3;
       spf=pass (google.com: domain of srs0=ywzk=ib=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=ywzk=IB=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH 4.9 28/36] Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"
Date: Mon, 14 May 2018 08:49:02 +0200
Message-Id: <20180514064806.432383359@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180514064804.252823817@linuxfoundation.org>
References: <20180514064804.252823817@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600421385600199153?=
X-GMAIL-MSGID: =?utf-8?q?1600421482930843566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -217,6 +217,7 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0930, 0x0227), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0b05, 0x17d0), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x0036), .driver_info = BTUSB_ATH3012 },
+	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x3008), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
 	{ USB_DEVICE(0x0cf3, 0x311e), .driver_info = BTUSB_ATH3012 },
@@ -249,7 +250,6 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x0489, 0xe03c), .driver_info = BTUSB_ATH3012 },
 
 	/* QCA ROME chipset */
-	{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe007), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe009), .driver_info = BTUSB_QCA_ROME },
 	{ USB_DEVICE(0x0cf3, 0xe300), .driver_info = BTUSB_QCA_ROME },
