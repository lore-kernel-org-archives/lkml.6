Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227kyjmkwgqrFkSBfkkdJuFdgcQtgbXFrAV4RKZ4MAT3+5KqqP69EUw/CH4At8q+vV6wN02Q
ARC-Seal: i=1; a=rsa-sha256; t=1519218335; cv=none;
        d=google.com; s=arc-20160816;
        b=vsqcmTgw78l9MkduFzhNCVD2ou/vQyLr7vWtF4DNx6XyHpyTpFmr4TDEFJP6ndSW7L
         /FnFPUmmqC93crwz290CrFm9GB9FhKSvUULnK7g9zG85wnCFwWHS552Lm/hpO+O3ZAE0
         3Qd03hwlGmyT15Z1ziguTji9wTQFMTAPKHuLvOwbuC0Jjpe3xkV6yz4LhOQ6bkzPIxsV
         mzOGv28A42vy6EmwYia3JNZ8/d4zNjBkcXm9y2hn/mdU1AhWG6PEu31DYJ4ph0IHhHcZ
         4+ZczMb63W3juIoZdKN+scCQ+okU0cIf8Y3axabh65F8Gppyia1jKTmvcProEAa1KG7K
         mpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Xcu7RDQo9NTJFBpuAV6nV/9/l/52uQZJsx8/sSgkiOo=;
        b=NfmRB1yJoqnBLMS2QG2Sm+cnmdBjfFj5QffnvU7it1AwxlvKs1PvBkS6ZtN/nlmKU/
         zDIwgp1KSzWQCZHCbj/4pue/uEqFKe9R8SFl6up/Pt2nQUwuLhQ7tR+ParGBgx36A/Ak
         SwSb4EEC4c9XrKF4eDiWfu8aK3z2xlvg4TeTz0IY0GhZ7W4NzPrEy49j/yOEVIsMbafK
         +kOeZBteoJm/StiLF8AI0CHWhGmqUIWAEnGWqgYVcXRQXxuKmBr+pPd9cG8M2HQjd6os
         sy3pCY6x961/xhGI1gayIw9/A7eaHu9c7d2TAS3eo1rW7q1Oq4gSnPxIBkGZvTPX96O3
         A9dw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Mack <daniel@zonque.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 148/167] ALSA: usb: add more device quirks for USB DSD devices
Date: Wed, 21 Feb 2018 13:49:19 +0100
Message-Id: <20180221124532.849565593@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015885600564211?=
X-GMAIL-MSGID: =?utf-8?q?1593015885600564211?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Mack <daniel@zonque.org>

commit 7c74866baef1827e18f8269aec85030063520bd4 upstream.

Add some more devices that need quirks to handle DSD modes correctly.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Reported-and-tested-by: Thomas Gresens <tgresens@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1369,8 +1369,11 @@ u64 snd_usb_interface_dsd_format_quirks(
 			return SNDRV_PCM_FMTBIT_DSD_U32_BE;
 		break;
 
-	/* Amanero Combo384 USB interface with native DSD support */
-	case USB_ID(0x16d0, 0x071a):
+	/* Amanero Combo384 USB based DACs with native DSD support */
+	case USB_ID(0x16d0, 0x071a):  /* Amanero - Combo384 */
+	case USB_ID(0x2ab6, 0x0004):  /* T+A DAC8DSD-V2.0, MP1000E-V2.0, MP2000R-V2.0, MP2500R-V2.0, MP3100HV-V2.0 */
+	case USB_ID(0x2ab6, 0x0005):  /* T+A USB HD Audio 1 */
+	case USB_ID(0x2ab6, 0x0006):  /* T+A USB HD Audio 2 */
 		if (fp->altsetting == 2) {
 			switch (le16_to_cpu(chip->dev->descriptor.bcdDevice)) {
 			case 0x199:
