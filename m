Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519833752-2-4571193898892950109
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519833751; b=SY7+HUzYR0CDbrRSN8BTd0dVpho4QZt07xXyZDulB7qQ4Sj
    ngRISrIJyEK51dOMuAYKjbEgY1b8fmE0d6tryuxQRDl4Lt0opSjuvolZfy5DwXoW
    9sCz5U4dqtrUTCdB7OBaUskxmKPb65hCCdpYNZphnUgzth0rTSNsedAJfCpVhydX
    fLrS/dU2mn5bB4ceW2SF/Au6BEN63kG7A22awGmx3reptNhYMsxQglNlVtTWvPPO
    Rp28ACKhChIQomtDQB7S13XxmfJFs5THM5RG2TvNjQ3jUnLv4o/lNsQX4m51LfA6
    8YWA0X3z3CZXumxW0V71cSjekOy0QtnRRK6PPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833751; bh=T8fcu6Wwpp8dEsqfp3+
    ERyun0eyMHyIu/Dm7UcjaQI4=; b=N2wim95nhBL0zRk0N0PXKxxxRqXKF2crEhi
    ezbt6Dn92or1ESHW6g2k0jefzM0HuaGKmAFbDvkH6AjglBZjcAL+F5rTZehSKwFS
    UbPpogrJzMKwaxPMe0irpjK03rPyaswk5DD1pYChetg1ffXIMNEMuY7E50niAqlW
    6eLFaqFeBRguGyTGiMaVA49ZU64WXLftCEXhM0Mn9sab9TAUb1gvgrrUNL0eTtDk
    I6jeXioOtl16XBEBStsI6FmHNzhQUvb/X4drMDGG0xaz3A8lY+EZuh52O/prJtlE
    Fx17AwCohn59kqSIKWqG2ZpHDYnuL8R5eMn8NXhYxJ6oatQzeCg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753107AbeB1QCB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:02:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34700 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753100AbeB1QCA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:02:00 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Hui Wang" <hui.wang@canonical.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.90694422@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 140/254] ALSA: hda - Add MIC_NO_PRESENCE fixup for 2
 HP machines
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit 322f74ede933b3e2cb78768b6a6fdbfbf478a0c1 upstream.

There is a headset jack on the front panel, when we plug a headset
into it, the headset mic can't trigger unsol events, and
read_pin_sense() can't detect its presence too. So add this fixup
to fix this issue.

Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/pci/hda/patch_conexant.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -2845,6 +2845,8 @@ enum {
 	CXT_FIXUP_MUTE_LED_EAPD,
 	CXT_FIXUP_HP_SPECTRE,
 	CXT_FIXUP_HP_GATE_MIC,
+	CXT_FIXUP_HEADSET_MIC,
+	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 };
 
 /* for hda_fixup_thinkpad_acpi() */
@@ -2923,6 +2925,18 @@ static void cxt_fixup_headphone_mic(stru
 	}
 }
 
+static void cxt_fixup_headset_mic(struct hda_codec *codec,
+				    const struct hda_fixup *fix, int action)
+{
+	struct conexant_spec *spec = codec->spec;
+
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
+		spec->parse_flags |= HDA_PINCFG_HEADSET_MIC;
+		break;
+	}
+}
+
 /* OPLC XO 1.5 fixup */
 
 /* OLPC XO-1.5 supports DC input mode (e.g. for use with analog sensors)
@@ -3374,6 +3388,19 @@ static const struct hda_fixup cxt_fixups
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_hp_gate_mic_jack,
 	},
+	[CXT_FIXUP_HEADSET_MIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cxt_fixup_headset_mic,
+	},
+	[CXT_FIXUP_HP_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x1a, 0x02a1113c },
+			{ }
+		},
+		.chained = true,
+		.chain_id = CXT_FIXUP_HEADSET_MIC,
+	},
 };
 
 static const struct snd_pci_quirk cxt5045_fixups[] = {
@@ -3425,6 +3452,8 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
+	SND_PCI_QUIRK(0x103c, 0x8299, "HP 800 G3 SFF", CXT_FIXUP_HP_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x103c, 0x829a, "HP 800 G3 DM", CXT_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
 	SND_PCI_QUIRK(0x152d, 0x0833, "OLPC XO-1.5", CXT_FIXUP_OLPC_XO),
 	SND_PCI_QUIRK(0x17aa, 0x20f2, "Lenovo T400", CXT_PINCFG_LENOVO_TP410),
