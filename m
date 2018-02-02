Return-Path: <jackstocker.93@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517586749; cv=none;
        d=google.com; s=arc-20160816;
        b=ST/H3xv9zARSC24I6Or/02AhN8ZqthRYwCWDB0Rmgujyu2a4Sad6xOiQYIqYtLoB8H
         2xtQJBdLQzrZME03ACXUZ9XRowrA0p9xtm5Fef+v35jeNk2Lfz3TXfF7kPZcncckom+1
         kOVUp2Q0soFFzerRDyM0eun7s+EXM2iQ1nQUsHnay3rLz24SOm8hWv+nG/7oe1bl3bSS
         B4E0NJ7P1uzPmVX3nTlXvUHCNJMziQvA/yqbpWrhgVGvEDkn67bQZkiipzdFfK8nO/WS
         4WwKVDMPWDrZn57fnqpxIebcQqvFwIkndeBFt5USIu+u2MGSoi243D/1lYmewYCeRpFr
         +HaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=NC5/uHlMwVGnwmaPL5XO2I5I/f6hrQiUKXGE0hMhSHs=;
        b=IXlJkayfx12JJvTFUux+Lj9cHpu8vDiakt39FLQ9ZdVOOchFyN0hlIschyCVQGZIyB
         9zXkenoWy9dMfFjPK30AAj0MZz5+uLCjF9sjV1VZ4q+hVTw7nJy8k8XxidVD7jEp6e68
         Nea9NsPMVtT7e9J5LpuedaqDb+5Ca7jiC+P79sinqpKVYBSCuCeBRZBq/1BBr+SVcYDp
         172LftZfDzx2pqPR+93aE6ArCsz4P7gL7FODwbTbTHjU9AW9sNkl7fqDvAtSIxXK+xuu
         RkdNk2EbCmQMcOg6X5N1QV0+tpOXnQBp5bxqnRC9B2AkB3bEJhOKXvxBmeYPtkjJhL/Y
         veXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bvLOVNHZ;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=bvLOVNHZ;
       spf=pass (google.com: domain of jackstocker.93@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=jackstocker.93@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227lJZC4oBAR7CP5CR1XX1kpwsDxjx28vfjfsQVPY75SNvqc1hxcpelfsuXk6NqM5BCvU+oerQ==
From: JackStocker <jackstocker.93@gmail.com>
To: 
Cc: Jack Stocker <jackstocker.93@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Seth Forshee <seth.forshee@canonical.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Stefan Bader <stefan.bader@canonical.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Devin Heitmueller <dheitmueller@kernellabs.com>,
	Sandeep Singh <sandeep.singh@amd.com>,
	Dmitry Fleytman <dmitry@daynix.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Add delay-init quirk for Corsair K70 RGB keyboards
Date: Fri,  2 Feb 2018 15:51:57 +0000
Message-Id: <1517586717-6209-1-git-send-email-jackstocker.93@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591305042869034715?=
X-GMAIL-MSGID: =?utf-8?q?1591305042869034715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jack Stocker <jackstocker.93@gmail.com>

Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
Corsair K70 RGB keyboards also require the DELAY_INIT quirk to
start correctly at boot.

Device ids found here:
usb 3-3: New USB device found, idVendor=1b1c, idProduct=1b13
usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 3-3: Product: Corsair K70 RGB Gaming Keyboard 

Signed-off-by: Jack Stocker <jackstocker.93@gmail.com>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index a6aaf2f..9eb92dc 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -221,6 +221,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* Corsair K70 RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* MIDI keyboard WORLDE MINI */
 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
-- 
2.7.4
