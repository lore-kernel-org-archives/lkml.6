Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AH8x227J0HidX2x9ij/6RRVZRPi41XAq7u6Vwy4rXx1DORG6P+XGHTFYjFWF5TXBWaxZuEcRYyiT
ARC-Seal: i=1; a=rsa-sha256; t=1519831338; cv=none;
        d=google.com; s=arc-20160816;
        b=BCtuolNb94jtQT/DnENifoZgtucVlHrboFLpndoF+XJvssViW3vsJLvBB3CUHbt21F
         lzVh7LzxaKCIHuMGS7V40WLB0XfkD5tqbCdYBQsvnf3jRLJN1wf/W+PGsfcc4/NVThTY
         gJLuRSIbtuKZBpHBc3pw4uSruxXYx9ghTIngeoYVq64FnSyqyu+tR4wi5AxMdnb0ubcO
         YyBwPmb0BPO8jQft800bCpvvLftea/nVMI51JFwlIrzlIpo+tWDiX2gAnH+r6CpIScdr
         CNq3UzeeBYVYHQVp/2cDzncULXlyW7nb2y3/pAUcnrINHR2ZUfoC8ZYucq63x3MmuBHS
         5ibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=d2JDXerV0zAdHg5TaW9SlC42MYjM8PF+r76f/nMPxLo=;
        b=refAyPgagYgvftbi7Cd2uQ/mjiIBmhFZAjP5Nv0mF11buJRnGlrAik+4A/5s8c0Wrh
         G1q6Pehkk5CQGh84buxZerCEnCy7plMLchxMoiP5vD5a38XPIfIdy+EBVrdWbPatQ3Vt
         k8L39wVvoF3I91gtH81Uhseuo9dhzbLpt2J20PPhQQDuYWPybwghzZDHeqAiTxWAUPBq
         wWL5jG96b8bwvunslrCwU4eE1E9xq91VWlxUdk+XXDtTGNamhU5V9sbDg3wR+MyK2tJQ
         tRrpIO8zUYgPUCxlXX/n/5AD/oN7WAQRiYDantIzgea4I/7hwPJwJL/MCu8u7VqOQ/iO
         Yt0w==
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
 "Oliver Neukum" <oneukum@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.695583148@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 062/140] usb: add RESET_RESUME for ELSA MicroLink 56K
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593658665862784090?=
X-GMAIL-MSGID: =?utf-8?q?1593658665862784090?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit b9096d9f15c142574ebebe8fbb137012bb9d99c2 upstream.

This modem needs this quirk to operate. It produces timeouts when
resumed without reset.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -128,6 +128,9 @@ static const struct usb_device_id usb_qu
 	/* appletouch */
 	{ USB_DEVICE(0x05ac, 0x021a), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* ELSA MicroLink 56K */
+	{ USB_DEVICE(0x05cc, 0x2267), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	/* Avision AV600U */
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =
 	  USB_QUIRK_STRING_FETCH_255 },
