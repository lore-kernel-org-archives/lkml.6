Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F40C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449252082D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 03:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449252082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLGDcZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:32:25 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46820 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbeLGDcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 22:32:24 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID wB73Vnwc026282, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id wB73Vnwc026282
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 7 Dec 2018 11:31:49 +0800
Received: from RTITMBSV02.realtek.com.tw ([fe80::cc0e:6d5f:56d7:c15f]) by
 RTITCAS11.realtek.com.tw ([fe80::7c6d:ced5:c4ff:8297%15]) with mapi id
 14.03.0399.000; Fri, 7 Dec 2018 11:31:48 +0800
From:   Kailang <kailang@realtek.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Hui Wang <hui.wang@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: RE: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
Thread-Topic: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS
 UX533FD with ALC294
Thread-Index: AQHUjUBWWH/9RC4DZUm4FqBMJMBJNaVyn9rA
Date:   Fri, 7 Dec 2018 03:31:47 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18420211@RTITMBSV02.realtek.com.tw>
References: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
 <20181206084554.4728-1-jian-hong@endlessm.com>
 <20181206084554.4728-3-jian-hong@endlessm.com>
In-Reply-To: <20181206084554.4728-3-jian-hong@endlessm.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.105.152]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jian Hong,

Could I know who give you the value as below?

+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
+			{ 0x20, 0x4c4, 0x20 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
+			{ 0x20, 0x488, 0x00 },

BR,
Kailang

-----Original Message-----
From: Jian-Hong Pan <jian-hong@endlessm.com> 
Sent: Thursday, December 6, 2018 4:46 PM
To: Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>; Kailang <kailang@realtek.com>
Cc: Hui Wang <hui.wang@canonical.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; linux@endlessm.com; Jian-Hong Pan <jian-hong@endlessm.com>; Daniel Drake <drake@endlessm.com>
Subject: [PATCH v2 2/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294

The ASUS UX533FD with ALC294 cannot detect the headset MIC and output through the internal speaker and the headphone until ALC294_FIXUP_ASUS_SPK_NOISE quirk applied.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
v2:
- Modify the HDA verbs for UX333FA support
- Make a new ALC294_FIXUP_ASUS_HEADSET_MIC quirk for ALC294 chain
- .chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE  ==> change to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC

 sound/pci/hda/patch_realtek.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c index d32e50b1ed60..1525bcdf96e8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5518,6 +5518,8 @@ enum {
 	ALC295_FIXUP_HP_AUTO_MUTE,
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 	ALC294_FIXUP_ASUS_MIC,
+	ALC294_FIXUP_ASUS_HEADSET_MIC,
+	ALC294_FIXUP_ASUS_SPK_NOISE,
 };
 
 static const struct hda_fixup alc269_fixups[] = { @@ -6414,6 +6416,28 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
+	[ALC294_FIXUP_ASUS_HEADSET_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1113c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
+	[ALC294_FIXUP_ASUS_SPK_NOISE] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Set EAPD high */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x10 },
+			{ 0x20, 0x4c4, 0x20 },
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x40 },
+			{ 0x20, 0x488, 0x00 },
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = { @@ -6556,6 +6580,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x12e0, "ASUS X541SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x13b0, "ASUS Z550SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1427, "Asus Zenbook UX31E", ALC269VB_FIXUP_ASUS_ZENBOOK),
+	SND_PCI_QUIRK(0x1043, 0x14a1, "ASUS UX533FD", 
+ALC294_FIXUP_ASUS_SPK_NOISE),
 	SND_PCI_QUIRK(0x1043, 0x1517, "Asus Zenbook UX31A", ALC269VB_FIXUP_ASUS_ZENBOOK_UX31A),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
--
2.11.0

