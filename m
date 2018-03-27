Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-22565-1522168744-2-11263565819632863663
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522168744; b=HRI/RutTpgz03AV7jHqI2nSLPrVUbe/OhCOwqyb9yAJ4NiQ
    U2qX7sVugIKD+9OoSMTbLRrrDsplB8TTPLKXOfyzYIuKtuHkwU25Bs/bQIxN2ICA
    XJ1nX9e2007EETUD9CvqW4JGKGQMCxp8r0FO25CaAA22Gfn/3rgQ+1woNyeDvMSx
    1hcmGEI+s+nDYRndqIPO/61lvFTDwWochIq6JcAumvwqvfIYsFyfU2u4BKV+XihR
    pcmS+wtJm+87+wXlZTzZeYwz+XyhnL0ZjUEJma90HZjcpJW96B4jfkBpLjYBd/SP
    dkUsAQmuLAMGuJr77Lc6116fdHlDuYVWNs/tamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168744; bh=4YBAMCxl5/AAxYS+8hv/5smrWI
    AvKpzC/RHRM6AWEc4=; b=BsguaWjsIWjOmrVz/0S3ceIODTH0znGIgpQAxCZC6C
    fNZrKMm1z2ZP+1CLlImJcufvMiNLLh2Jhkr7s24z8NDmJnxZdsvy8nxdrf1YllIk
    w49OsTsOZTC8eAFi6o7tQvLGxraD9YU9/DiOSINVHXUDX3+1e5TdO9GuC7WEm9Xc
    lP759PSog3YKeVARPEP/xf4eNSuRVEvoKssvC2cJo4tDSFBDal6U82+CttFmTspq
    TvxPeAxnWW8IiWN5F0fDTJpg+aGu8UqV1slsWYlQIxgjpLu3hGv3eZeh9/AwBy++
    oEqU5O/S6+uwqT/eG7AwC5UG3UDAedRs3mAet6fA1Yiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOMIMvJfPOK/BS9BPPCLhExrATlNw+qkk/NmmxGkSMn+s+5EX/lQ7XoTcK4EY7W9VeNOmVr9nVfN42fZfKev/mmXRBjDCpD2lk1KPZDr26bQ6LTEYT1I
    f3atbo9xv2ofw2KIRd9XdhWQsOlBICNQBtOeDqJlmir5IqBskR3YjXUO7jtjaI01SlI8kJShTOjlnJmryjWw7oUWc6O4yzUJfM+M8w92kFVi0k2++kvi6O7T
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=kEuSYUkgaz3Z-NsYjEUA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755344AbeC0QjA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:39:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47036 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755307AbeC0Qi7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:38:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 015/105] ALSA: hda/realtek - Always immediately update mute LED with pin VREF
Date: Tue, 27 Mar 2018 18:26:55 +0200
Message-Id: <20180327162758.487676930@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit e40bdb03d3cd7da66bd0bc1e40cbcfb49351265c upstream.

Some HP laptops have a mute mute LED controlled by a pin VREF.  The
Realtek codec driver updates the VREF via vmaster hook by calling
snd_hda_set_pin_ctl_cache().

This works fine as long as the driver is running in a normal mode.
However, when the VREF change happens during the codec being in
runtime PM suspend, the regmap access will skip and postpone the
actual register change.  This ends up with the unchanged LED status
until the next runtime PM resume even if you change the Master mute
switch.  (Interestingly, the machine keeps the LED status even after
the codec goes into D3 -- but it's another story.)

For improving this usability, let the driver temporarily powering up /
down only during the pin VREF change.  This can be achieved easily by
wrapping the call with snd_hda_power_up_pm() / *_down_pm().

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199073
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3511,8 +3511,12 @@ static void alc269_fixup_mic_mute_hook(v
 	pinval = snd_hda_codec_get_pin_target(codec, spec->mute_led_nid);
 	pinval &= ~AC_PINCTL_VREFEN;
 	pinval |= enabled ? AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80;
-	if (spec->mute_led_nid)
+	if (spec->mute_led_nid) {
+		/* temporarily power up/down for setting VREF */
+		snd_hda_power_up_pm(codec);
 		snd_hda_set_pin_ctl_cache(codec, spec->mute_led_nid, pinval);
+		snd_hda_power_down_pm(codec);
+	}
 }
 
 /* Make sure the led works even in runtime suspend */
