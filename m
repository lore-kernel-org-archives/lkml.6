Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227jQjSWvqCWE3pxkF3jVcpXmAACDStmBjaMH7qk9ZKEhNBOaI3J4V6H+O3LtY0FYJZ0YV4d
ARC-Seal: i=1; a=rsa-sha256; t=1518323643; cv=none;
        d=google.com; s=arc-20160816;
        b=1JHloIMF2+6ypioDKOMgWWY04vZJsjzv4NJubrhGvUpFZhNKqmNcRi4ZFJnoQm1SMt
         QxBIrzTxdtZllk38TQwykIwkuLdNKv3HG5cJoMEs0Y+DlbIFnJjzJhsqTkrqJanmX+Ee
         QFLb7EcE/eFCAcf9dxgHkXN95Tw8opPJ8CjfNe4L58saUAyY1MNvCTp+2yaEHMV5tFzX
         wpHCjSfZ37/szTo5XbJcBEExwpkbwQUuJZY6hpzcyRlzrbKI34gtDIQAt1VU7UErcAVA
         SpTy4KnW/6KBeA9XknhrkF8AWqEMsxgWrJw0xiQzPPN1A9Z09/ArcIhqu8Q1TLreY5o2
         I6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=CSYrzNFrkWNmMGgRe4RYru7DmCvBYUXhJLb9BB4/s6U=;
        b=AH9YxGQXuObiQ1Y/oJKpQgRwzoOaSM7Rnea0/bknGAP21nbFTPV14WyXNMymaXE3b2
         LaJv1MK1+jAjKwMpShL8Xfd7uv5r9GnDvXKUjesZks8JAwHLK31Mrvif5Q0XA9EO5XCI
         vKdpTJZvvoZ9kA2boWKvYUPDfr01cRwIyYm6RXcaOlq/WEBKA2OUsD/YQtCLefrv3Q5n
         KxbKj0Gn/56OTI/sa0EoujdSAFrQJv5c7KHJoPhop3Yrj+lifK07vWhap6qTq7ajCuYG
         YsHkByLYqkVErxAjhj3g873QY0UqPs1BP9JD+r1mICLGBa/GIBvZ7BIWQXR0TiKhqUA8
         qM/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Bernhard Rosenkraenzer" <Bernhard.Rosenkranzer@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Bernhard Rosenkraenzer" <bernhard.rosenkranzer@linaro.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.451537637@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 050/136] USB: Add delay-init quirk for Corsair K70
 LUX keyboards
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592077710773842199?=
X-GMAIL-MSGID: =?utf-8?q?1592077732963729105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Bernhard Rosenkraenzer <bernhard.rosenkranzer@linaro.org>

commit a0fea6027f19c62727315aba1a7fae75a9caa842 upstream.

Without this patch, K70 LUX keyboards don't work, saying
usb 3-3: unable to read config index 0 descriptor/all
usb 3-3: can't read configurations, error -110
usb usb3-port3: unable to enumerate USB device

Signed-off-by: Bernhard Rosenkraenzer <Bernhard.Rosenkranzer@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -218,6 +218,9 @@ static const struct usb_device_id usb_qu
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* Corsair K70 LUX */
+	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* MIDI keyboard WORLDE MINI */
 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
