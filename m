Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-133288-1522172471-2-8367477076769496398
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522172471; b=R3+S0YoMTUAoBxBYu6FzEdoFST8ruyGb8JnttyOl4OZMl3z
    HMTRQ409TJzmnMrZLcOM0glyvRujp63Ij7sk1LSOAKMBs2qukiOkS1xs5huMmchG
    HSVl2ZcQIzvZNnVQ7ga5/9HyI7zuULptwNvnR4K79uQ8EUyhSdLSVhQoS9K9gsQ1
    C0uvIzF/eKSTi8gXCX3Un360sNInCWqYy+0MJjFclW4Nuxg0ZdHbwRzZA0RgfP5m
    IZA4dAdZCv7mNwIJbEdv3TCSnU7T7c33RtnVIeI5iz5oAPTAvGDSb5+nHFTMA2Xa
    tfwRuw/jkTaD6jQ8B+494ODSsaveesxCr1ZkEfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522172471; bh=2xUduSIcqXfn0J+NJPujYq6zZP
    VaqwGEkchGlI74Kuo=; b=Usrb+GuTaJ9fGWT+XRsBwtdki5tOymrMEbfVv/ZMOn
    v2CT4Xg0mO7UA310+0Kg1ZPzuz8FX/k3/PQuV9b3cnsxetzTI4lJqGRxZhKrFXr9
    FBNzeBq1LSI3IE2a0RK+Db1p1Yin307zJa+jNvyac99k/TivLUOxv5E7TL7E4lVQ
    K/T2OHa1LwyX3exRCQjKZZNMh8OGqu3dZePiW9XAXsIdHeXfQV6OzWNdTUEbILSS
    xK2rV1oqIgELS9/NQ9m3dHYlxFCxDJKaI7aWsfxpxLJaDrONJ2d57Xkidojt/tqN
    FatTZoGuuv3zMl+H8IEWUgLY36M6V09QNnW6LK4uW9hA==
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
X-CM-Envelope: MS4wfFFgSeJ1tcrV89uN6HKiQsRiV5LXzIx/K3113ZyZEQuLeuvJXNfhJX/OgA7xsM27mSkLnsS/EpgPb1ZFG8VZE/6gzWZYPDMqGuDnUWOhp2NByex7u4YC
    fnaY69u4CAgWsAVO29VCGor3xxbq/G3boK1PmON+tC8gIqFVlIqz/T/3AcjKcl44wtpL7G8DHFKSOrnvQseWoQ4kCMd3DimPupks+mDsx/hmaMB83opjNU53
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=n9Sqmae0AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=hPuV26AB_bd9D4WrZCYA:9
    a=QEXdDO2ut3YA:10 a=UmAUUZEt6-oIqEbegvw9:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751078AbeC0Rk5 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 13:40:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44162 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754129AbeC0QeC (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:34:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 014/101] ALSA: hda/realtek - Fix Dell headset Mic cant record
Date: Tue, 27 Mar 2018 18:26:46 +0200
Message-Id: <20180327162750.858265252@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit f0ba9d699e5ca2bcd07f70185d18720c4f1b597c upstream.

This platform was hardware fixed type for CTIA type for headset port.
Assigned 0x19 verb will fix can't record issue.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5354,6 +5354,7 @@ enum {
 	ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
 	ALC298_FIXUP_TPT470_DOCK,
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
+	ALC255_FIXUP_DELL_HEADSET_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6214,6 +6215,13 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC255_FIXUP_DELL1_MIC_NO_PRESENCE
 	},
+	[ALC255_FIXUP_DELL_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -6268,6 +6276,8 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
 	SND_PCI_QUIRK(0x1028, 0x084b, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x084e, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x0871, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1028, 0x0872, "Dell Precision 3630", ALC255_FIXUP_DELL_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1028, 0x0873, "Dell Precision 3930", ALC255_FIXUP_DUMMY_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
