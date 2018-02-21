Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1546708-1519219213-2-5327451530231903523
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219213; b=w231ndjjVnOQS725NKUf0J6bBrOG6LI7QSQ7LnkMmQVic7k
    JW2ludAifg/3t1Y9mZYD7yuv8QuhzMyzfrqaiF6Jg0x9pt2vG9UJK6xQCPurQM94
    3ZwQ5dWiplbSNhdWFcYpwI2kkycoQfHGlBKS8O+96CEULTiZmxZt6eSHGZKHZgF4
    yHoIBHHD0pD6xmCpbth9RwBUQgS/1xEqA3dMx4FnJzqOF2DdQdV5hCE6Yge0QIhQ
    EErrum23XRdTMHoIZrNT6fDgafLQS6/b2YtzN7xlR2dRP9pRrWsYMX/SS344ROLg
    SSZPw2g56W60CFOtMtLWM2qSB+NA2S5i+GWSvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219213; bh=AgfCMF2TfJinSPGNrL3BtvE38e
    /u7QiB+hrJj3Sp6DI=; b=oT588Mn8ncSeKZTjVVyTDrk4+Cv8T9L4qIKVjsQNKO
    +g3VazkKYB/vbgtWN9rb+8k5/kw9VRfC5RTec+k8x6NUe0mdMWbWRT5z67/4GDLi
    CxrsdS5++uGi/4jmMZBaK1lFZXoPcYHKAtEYcYWvP6caPWUB82kPivAoQNY46aFn
    18BuZx9ZSgMzOW34iQzregw1ZBDQ6p5cPZqSniuuVKg5K3p7lmNU2iX1prOnjiYg
    NRGs1pN2EvEy+dsu4twMIS3Jz3ByPd5SpPLttATmAyKvZtWopdwQQ458RHYiUP7P
    HpT8yGrVsblGF2crNMwhbhPx5BQecPvoX3bND3ZLiG6w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933261AbeBUNMV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:12:21 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936459AbeBUNMS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 08:12:18 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan-Marek Glogowski <glogow@fbihome.de>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 147/163] ALSA: hda/realtek: PCI quirk for Fujitsu U7x7
Date: Wed, 21 Feb 2018 13:49:36 +0100
Message-Id: <20180221124538.190390721@linuxfoundation.org>
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

From: Jan-Marek Glogowski <glogow@fbihome.de>

commit fdcc968a3b290407bcba9d4c90e2fba6d8d928f1 upstream.

These laptops have a combined jack to attach headsets, the U727 on
the left, the U757 on the right, but a headsets microphone doesn't
work. Using hdajacksensetest I found that pin 0x19 changed the
present state when plugging the headset, in addition to 0x21, but
didn't have the correct configuration (shown as "Not connected").

So this sets the configuration to the same values as the headphone
pin 0x21 except for the device type microphone, which makes it
work correctly. With the patch the configured pins for U727 are

Pin 0x12 (Internal Mic, Mobile-In): present = No
Pin 0x14 (Internal Speaker): present = No
Pin 0x19 (Black Mic, Left side): present = No
Pin 0x1d (Internal Aux): present = No
Pin 0x21 (Black Headphone, Left side): present = No

Signed-off-by: Jan-Marek Glogowski <glogow@fbihome.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3378,6 +3378,19 @@ static void alc269_fixup_pincfg_no_hp_to
 		spec->parse_flags = HDA_PINCFG_NO_HP_FIXUP;
 }
 
+static void alc269_fixup_pincfg_U7x7_headset_mic(struct hda_codec *codec,
+						 const struct hda_fixup *fix,
+						 int action)
+{
+	unsigned int cfg_headphone = snd_hda_codec_get_pincfg(codec, 0x21);
+	unsigned int cfg_headset_mic = snd_hda_codec_get_pincfg(codec, 0x19);
+
+	if (cfg_headphone && cfg_headset_mic == 0x411111f0)
+		snd_hda_codec_set_pincfg(codec, 0x19,
+			(cfg_headphone & ~AC_DEFCFG_DEVICE) |
+			(AC_JACK_MIC_IN << AC_DEFCFG_DEVICE_SHIFT));
+}
+
 static void alc269_fixup_hweq(struct hda_codec *codec,
 			       const struct hda_fixup *fix, int action)
 {
@@ -5251,6 +5264,7 @@ enum {
 	ALC269_FIXUP_LIFEBOOK_EXTMIC,
 	ALC269_FIXUP_LIFEBOOK_HP_PIN,
 	ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT,
+	ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC,
 	ALC269_FIXUP_AMIC,
 	ALC269_FIXUP_DMIC,
 	ALC269VB_FIXUP_AMIC,
@@ -5457,6 +5471,10 @@ static const struct hda_fixup alc269_fix
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc269_fixup_pincfg_no_hp_to_lineout,
 	},
+	[ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc269_fixup_pincfg_U7x7_headset_mic,
+	},
 	[ALC269_FIXUP_AMIC] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -6331,6 +6349,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x10cf, 0x159f, "Lifebook E780", ALC269_FIXUP_LIFEBOOK_NO_HP_TO_LINEOUT),
 	SND_PCI_QUIRK(0x10cf, 0x15dc, "Lifebook T731", ALC269_FIXUP_LIFEBOOK_HP_PIN),
 	SND_PCI_QUIRK(0x10cf, 0x1757, "Lifebook E752", ALC269_FIXUP_LIFEBOOK_HP_PIN),
+	SND_PCI_QUIRK(0x10cf, 0x1629, "Lifebook U7x7", ALC255_FIXUP_LIFEBOOK_U7x7_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10cf, 0x1845, "Lifebook U904", ALC269_FIXUP_LIFEBOOK_EXTMIC),
 	SND_PCI_QUIRK(0x10ec, 0x10f2, "Intel Reference board", ALC700_FIXUP_INTEL_REFERENCE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
