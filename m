Return-Path: <jackstocker.93@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517761113; cv=none;
        d=google.com; s=arc-20160816;
        b=00ghy4TJasB9UzDp+6k1ezkDNGFDQQfqdB07wY4M+3V8EyPoRIxsFoDXv+bdkykJ5L
         h8HXhxh/vhZMeBY7R6muwzEG7OaLbNdSE7TsHnelfn8BMcnptz87KNb9Ew4Ny6WFVVi4
         P1FddctoX+TY4CClJnbznzZ7GHpRLdCjvy6nOYLAu42hAaX5jSjybHjCslQIFrXIzKUx
         QosCjdbivjNnVtCApBAP/WuUtCeCXTVvabap+8Sooo983xbVMC+FpE7EhieeiRMZFE26
         ss3QKrQRL2mshJf0MPfO/dJ9b2VWeJasSahtnl5MoB4XnlQxWkt97MTmvBAZqPH+T11b
         /E+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=I3A5jLHOyOmWK/9ruNo+3dk2JO09ZjY77h/7ce1HjX8=;
        b=GEGplXdkkfFU81bYG221pasO43EvpdjF7XeSsQEJCYhh5+wCy6a3A5UMO3kdV6S+wP
         ImmAQo5177UaVhQfxKstGWODpmlI4EOYGAahPLM7M3vqqkGJRFZSo+Ik+/R9ZO7kY7Se
         K9MOOUInt6N5/Fzc5GnXCox7sjZcSRvxAIXdIDpfhqiHayVf2m5GhHkSi3EK9scIcdl+
         4HT3/aq2h4D7HXIHGo7LpgZ9Qi+m+ZkT3gbM2OwCxObemo6YpnLCgd53wtyHTQvgvDzc
         KMwqOx/ybDnv7eq7jRig9LXsNjTQwzI3z2LkBFm5kBsyVWflwrXCVxnZlF8pFuuvgb3g
         skVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VO2keQOD;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VO2keQOD;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225l/6BFeBZJLBmFac/tJIMyzDDIVMVEbjDYo9cUS9Ib6vzPplKcPLYgoX5mHdiF9CQ3DK2bsA==
From: JackStocker <jackstocker.93@gmail.com>
To: 
Cc: JackStocker <jackstocker.93@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Seth Forshee <seth.forshee@canonical.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
	Sandeep Singh <sandeep.singh@amd.com>,
	Devin Heitmueller <dheitmueller@kernellabs.com>,
	Dmitry Fleytman <dmitry@daynix.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Add delay-init quirk for Corsair K70 RGB keyboards
Date: Sun,  4 Feb 2018 16:18:21 +0000
Message-Id: <1517761102-6849-1-git-send-email-jackstocker.93@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <14038CE4-3754-426C-AC53-0AFE58D095A3@canonical.com>
References: <14038CE4-3754-426C-AC53-0AFE58D095A3@canonical.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591305042869034715?=
X-GMAIL-MSGID: =?utf-8?q?1591487877704779993?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Do you mean like this?

Signed-off-by: JackStocker <jackstocker.93@gmail.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index a6aaf2f..0405d68 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -218,6 +218,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Corsair K70 RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
 
-- 
2.7.4
