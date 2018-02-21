Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519219170-2-8515227410435241168
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219170; b=h8mgm8XK2b+OrfNozO3Sa4n9yr3/e87Slp4T6xlr1tYRGna
    NYPeUbKsV3Qz4bzSRqbYU+yrmLqqapYB+V0NU8CFCCzXQdNc7xTZAz8XmZdKaq0h
    cVb19mxszlK4QKjSD7wm9q7z9tpT0nq+Wkq6CVz63r20+W4rlZt7ugCMZQrYS3Vx
    ZqzD/0NPZsJIlNh/1Cdh8VhPSobHi9q07UaHgiMXJ7ldZGeHcuyIPAPw+wakgJBS
    mt7ee/P8KjtD8RyTd4zCHmqVvwtYE3+WEtCvB6Vjg6+L+xJ+TTJOQMyw1JjhcYzZ
    YAIj32PKONRLo3r+UUkpFfofC1dU8L2Ex/uAOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219170; bh=7UyaaF+g3+vxzmZKvbQcLDEbUB
    B1wASfR2HqqjZ1+ws=; b=jEKHysPNvTpvTn+/Z7wUIHxq3fCGGYyPrP5H1tdkr5
    9fQ8MEnWQuuArjF9dB54ZhSP9/XAyR88/d89hPThmAe7/zYO9NMTQph2fiTN6dz9
    2Qx+F7GilDHtQ+al5i9430qU/2OgcsOOq7KeXTtjPBLJPgICne7mRGO1WT/mFVRP
    kOl9IMwzuwz75gdFgr2eW4QMuIGgOhpgeEI50XbhxjiJ2VlUQvEGhMjj/H1LqAJL
    n5PLu+b2N7k2kw6mJ66dj83fK6DN4VCuBVzAF9fOX8sI6bm3DB3eABEeyQbmaVfB
    xSg/sbL4pU+F63FMxt6o3B8UD1em4ELSLNXuvqjFlN2Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeBUNM3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:12:29 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45686 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbeBUNM0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 149/163] ALSA: usb: add more device quirks for USB DSD devices
Date: Wed, 21 Feb 2018 13:49:38 +0100
Message-Id: <20180221124538.271989372@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1363,8 +1363,11 @@ u64 snd_usb_interface_dsd_format_quirks(
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
