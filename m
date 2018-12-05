Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE2DC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F81920850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:38:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F81920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeLEIiK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:38:10 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52812 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeLEIiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:38:06 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID wB58aShb030450, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcas12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id wB58aShb030450
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 5 Dec 2018 16:36:28 +0800
Received: from RTITMBSV02.realtek.com.tw ([fe80::cc0e:6d5f:56d7:c15f]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0415.000; Wed, 5 Dec 2018
 16:36:27 +0800
From:   Kailang <kailang@realtek.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Hui Wang <hui.wang@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: RE: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN
Thread-Topic: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode
 fixups for ASUS X542UN
Thread-Index: AQHUjG4z5Y1EMUXolEKQbVvni1nQzqVv0chg
Date:   Wed, 5 Dec 2018 08:36:23 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18420099@RTITMBSV02.realtek.com.tw>
References: <20181205074212.31104-1-jian-hong@endlessm.com>
 <20181205074212.31104-2-jian-hong@endlessm.com>
In-Reply-To: <20181205074212.31104-2-jian-hong@endlessm.com>
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

Hi Jian-Hong,

Could you test to change the model to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC?

.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE  ==> change to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC


BR,
Kailang
-----Original Message-----
From: Jian-Hong Pan <jian-hong@endlessm.com> 
Sent: Wednesday, December 5, 2018 3:42 PM
To: Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>
Cc: Kailang <kailang@realtek.com>; Hui Wang <hui.wang@canonical.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; linux@endlessm.com; Chris Chiu <chiu@endlessm.com>; Jian-Hong Pan <jian-hong@endlessm.com>; Daniel Drake <drake@endlessm.com>
Subject: [PATCH 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN

From: Chris Chiu <chiu@endlessm.com>

The known ALC256_FIXUP_ASUS_MIC fixup can fix the headphone jack sensing and enable use of the internal microphone on this laptop X542UN. However, it's ALC294 so create a new fixup named ALC294_FIXUP_ASUS_MIC to avoid confusion.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c index bb40624fb6d5..bbae06267054 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5517,6 +5517,7 @@ enum {
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 	ALC295_FIXUP_HP_AUTO_MUTE,
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
+	ALC294_FIXUP_ASUS_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = { @@ -6403,6 +6404,16 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC294_FIXUP_ASUS_MIC] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x13, 0x90a60160 }, /* use as internal mic */
+			{ 0x19, 0x04a11120 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = { @@ -7152,6 +7163,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0293, 0x1028, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC292_STANDARD_PINS,
 		{0x13, 0x90a60140}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_MIC,
+		{0x14, 0x90170110},
+		{0x1b, 0x90a70130},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},
--
2.11.0

