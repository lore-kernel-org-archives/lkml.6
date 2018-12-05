Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52FD8C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BB92084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 08:53:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BB92084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeLEIxu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 03:53:50 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:55524 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726866AbeLEIxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 03:53:49 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID wB58qE0O003804, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id wB58qE0O003804
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 5 Dec 2018 16:52:14 +0800
Received: from RTITMBSV02.realtek.com.tw ([fe80::cc0e:6d5f:56d7:c15f]) by
 RTITCASV02.realtek.com.tw ([::1]) with mapi id 14.03.0415.000; Wed, 5 Dec
 2018 16:52:14 +0800
From:   Kailang <kailang@realtek.com>
To:     Jian-Hong Pan <jian-hong@endlessm.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Hui Wang <hui.wang@canonical.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: RE: [PATCH 1/4] ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer Aspire U27-880
Thread-Topic: [PATCH 1/4] ALSA: hda/realtek: ALC286 mic and headset-mode
 fixups for Acer Aspire U27-880
Thread-Index: AQHUjGa4XN13mVP0E0CVDcC2o9xZn6Vv1lzw
Date:   Wed, 5 Dec 2018 08:52:10 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A184200A7@RTITMBSV02.realtek.com.tw>
References: <20181205064856.19380-1-jian-hong@endlessm.com>
In-Reply-To: <20181205064856.19380-1-jian-hong@endlessm.com>
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

Please also try to change model to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC.

+		.chain_id = ALC269_FIXUP_HEADSET_MIC  ==> change to  ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC

BR,
Kailang
-----Original Message-----
From: Jian-Hong Pan <jian-hong@endlessm.com> 
Sent: Wednesday, December 5, 2018 2:49 PM
To: Jaroslav Kysela <perex@perex.cz>; Takashi Iwai <tiwai@suse.com>
Cc: Kailang <kailang@realtek.com>; Hui Wang <hui.wang@canonical.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; linux@endlessm.com; Chris Chiu <chiu@endlessm.com>; Jian-Hong Pan <jian-hong@endlessm.com>; Daniel Drake <drake@endlessm.com>
Subject: [PATCH 1/4] ALSA: hda/realtek: ALC286 mic and headset-mode fixups for Acer Aspire U27-880

From: Chris Chiu <chiu@endlessm.com>

Acer Aspire U27-880(AIO) with ALC286 codec can not detect headset mic and internal mic not working either. It needs the similar quirk like Sony laptops to fix headphone jack sensing and enables use of the internal microphone.

Unfortunately jack sensing for the headset mic is still not working.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c index c0b289ba397f..f21d52eb2ed3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5516,6 +5516,7 @@ enum {
 	ALC221_FIXUP_HP_HEADSET_MIC,
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 	ALC295_FIXUP_HP_AUTO_MUTE,
+	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = { @@ -6393,6 +6394,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_auto_mute_via_amp,
 	},
+	[ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = { @@ -7071,6 +7081,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x19, 0x04a11040},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0286, 0x1025, "Acer", ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0288, 0x1028, "Dell", ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},
--
2.11.0

