Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303463-1521214049-2-4210595597002092872
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521214048; b=TjeVnw6nuOUN6EdI15D3mjwbDHeG7pECEIfGJyM2hhsWcoh
    abct8x2mjMZ/D8PWuaxzOtBPOlhkVD6+tBaWJStTbvGzEWuMPu5YO6Y3o6u4YaEt
    NWc8yHMKT9CKUveTgwz0Lq2KomwOQKvh9LSoFhQExDS6Hu92+hcPEZHy7NoTsYRI
    YAfZKDYcXHiultYcGg+Z57f2yk0X6xMMZHnEFDl1iiRkFplEOaknYXpiEnokT/cc
    DsFF3I32pC3j4zxiZJEJ9IIIXX9d8Zvbo+zQ4KBTzKjRD4xeB4nJ2bd8ayFGEq3r
    SoXDAmofl+PoOAZ0VDrCBlErZ5fXSTHp/QLKl3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521214048; bh=1O5mdM4Zwvt9DT8bLum+Uf3itB
    VzDPWtySkKYdnW23s=; b=BbXwPXQWEdEt284XR8ShjxQswTw35tfMpMtdtxJiS6
    px5sYFYv2FAymFAUtuci6IqSY8XM6TVzU5PCUKjVfg16PCVW4mbw0a9setx7ADuR
    iT1Pj6ibq2rbUWZJYsqVGa0FeA03I1rz5BiPwMcPfuMwdBF0R1dUyXFQOIX50CX8
    GCHet0Hn17bDw1n/oubSVSvetaCRR7eZm88lTsrmJme8if76EiCM7qE4T56nLLpn
    7F3iLhyi1D2Dz/NhI3/6xXL6tCAmxaVJgl+1quKq2Lo3ylF6DiMXYGy6KzSeUZVL
    2gsP7ZM0UXQDNjnnqNa3MSED/zD7WkZl8GkGm6vOu0VA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeCPP10 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:27:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34186 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754098AbeCPP1Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 21/63] ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520
Date: Fri, 16 Mar 2018 16:22:53 +0100
Message-Id: <20180316152302.422372162@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit e312a869cd726c698a75caca0d9e5c22fd3f1534 upstream.

The dock line-out pin (NID 0x17 of ALC3254 codec) on Dell Precision
7520 may route to three different DACs, 0x02, 0x03 and 0x06.  The
first two DACS have the volume amp controls while the last one
doesn't.  And unfortunately, the auto-parser assigns this pin to DAC3,
resulting in the non-working volume control for the line out.

Fix it by disabling the routing to DAC3 on the corresponding pin.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=199029
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4722,6 +4722,16 @@ static void alc298_fixup_speaker_volume(
 	}
 }
 
+/* disable DAC3 (0x06) selection on NID 0x17 as it has no volume amp control */
+static void alc295_fixup_disable_dac3(struct hda_codec *codec,
+				      const struct hda_fixup *fix, int action)
+{
+	if (action == HDA_FIXUP_ACT_PRE_PROBE) {
+		hda_nid_t conn[2] = { 0x02, 0x03 };
+		snd_hda_override_conn_list(codec, 0x17, 2, conn);
+	}
+}
+
 /* Hook to update amp GPIO4 for automute */
 static void alc280_hp_gpio4_automute_hook(struct hda_codec *codec,
 					  struct hda_jack_callback *jack)
@@ -4871,6 +4881,7 @@ enum {
 	ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY,
 	ALC255_FIXUP_DELL_SPK_NOISE,
 	ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+	ALC295_FIXUP_DISABLE_DAC3,
 	ALC280_FIXUP_HP_HEADSET_MIC,
 	ALC221_FIXUP_HP_FRONT_MIC,
 	ALC292_FIXUP_TPT460,
@@ -5560,6 +5571,10 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC298_FIXUP_DELL_AIO_MIC_NO_PRESENCE,
 	},
+	[ALC295_FIXUP_DISABLE_DAC3] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc295_fixup_disable_dac3,
+	},
 	[ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -5617,6 +5632,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x0725, "Dell Inspiron 3162", ALC255_FIXUP_DELL_SPK_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075b, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x1028, 0x07b0, "Dell Precision 7520", ALC295_FIXUP_DISABLE_DAC3),
 	SND_PCI_QUIRK(0x1028, 0x0798, "Dell Inspiron 17 7000 Gaming", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
