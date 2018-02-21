Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1568560-1519219242-2-8804026483910389188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219241; b=jUnfhqaF+nKKWQ9i5zdC48nB4SC6UeF/CMyza2M9Kkk69T8
    U0nEa+nBo5nCqwBD/1KkjUeqrytoIntJxo7pnK7YKEk7r2Y0rm117gggjyveYqVx
    5pkMxfLhO1BLjQCmQfpx0Lzyo8QtXOUaO9L5Tfp02vbEnrP2wJpOHtNnQvfYJ5OQ
    fBT9gKgBGPU2S/r1gxxRTR5vXQMdaPKjoVO8VisQFuq0buCbnybflulkY52VPILV
    bbIRl41LTDV80njHbCEB8Fzo9qzQDpBS6JG1Kpd8gDmkCdT0TpBEeFkXixgMFSjh
    1YoXdATbVWZ1BlR85ugqMYqnZwuUQ4kSyiC8r1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219241; bh=D08C0hgVXTAtcmOlO9eeYwkaSk
    ZA0NUennRkBxqkSkM=; b=sXYP5lu5/SUle0RJO57adMCLyv1BkBTzWF3OAIQRto
    1BiF5sB1Yhyq4xLDu8oaU48/rApw/fa69zljBxjtx0wo3K4fpA4XgkriXIG+ytXV
    I/fXlEZWPGKCbMRlWA3tXM+zywXoWpUhkBXz7WcEkp2xOnMD3izrRjuoRcedeDdr
    s26n+lvBCDXF6FzV1BhVGMzxURFWJDaM6mrj38o9e9ucOOj1pd2s0i40UO1eYfZz
    Cd0hiCkH3oRpRY6V1T5zHPmlTqub/RufRhlv5fuKJVECw9QjPX2eaoyoCT6zeCYL
    6ijC2fdS43XmX0e98V2RT3Eyj9f8IyQ+i7MOYe1NGzlA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936535AbeBUNUB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:20:01 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936466AbeBUNMU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lassi Ylikojola <lassi.ylikojola@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 148/163] ALSA: usb-audio: add implicit fb quirk for Behringer UFX1204
Date: Wed, 21 Feb 2018 13:49:37 +0100
Message-Id: <20180221124538.234880031@linuxfoundation.org>
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

From: Lassi Ylikojola <lassi.ylikojola@gmail.com>

commit 5e35dc0338d85ccebacf3f77eca1e5dea73155e8 upstream.

Add quirk to ensure a sync endpoint is properly configured.
This patch is a fix for same symptoms on Behringer UFX1204 as patch
from Albertto Aquirre on Dec 8 2016 for Axe-Fx II.

Signed-off-by: Lassi Ylikojola <lassi.ylikojola@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/pcm.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -357,6 +357,15 @@ static int set_sync_ep_implicit_fb_quirk
 
 		alts = &iface->altsetting[1];
 		goto add_sync_ep;
+	case USB_ID(0x1397, 0x0002):
+		ep = 0x81;
+		iface = usb_ifnum_to_if(dev, 1);
+
+		if (!iface || iface->num_altsetting == 0)
+			return -EINVAL;
+
+		alts = &iface->altsetting[1];
+		goto add_sync_ep;
 
 	}
 	if (attr == USB_ENDPOINT_SYNC_ASYNC &&
