Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE619C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C54A22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9g1bDws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C54A22360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbeKOBaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:30:04 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33754 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733043AbeKOBaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:30:04 -0500
Received: by mail-yb1-f194.google.com with SMTP id i78-v6so7054913ybg.0;
        Wed, 14 Nov 2018 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/J/J2yQlCB6JfpYHRJOvL8C31SV3iVfRTBQjfb8JZ1o=;
        b=R9g1bDws1xbyaZeZSU5gZ+Ck5+LLlpFndMW4FVNisOXVUqji+8bVGp/uh33qYQXg+3
         LQnaj3dbz1zUNXKBvgnchP0YHLPZMtMx6q1SPLDg43uTMDW9b/pU3ISMgVICjbxYlTPC
         IXW+Gjr0zYAI9RwVSXRxR8HVjoIH3xcTBb60lY+jY71CrxdLTISQElxyLD+Ii8NVyn/l
         8ROxXfuSvZrgDOyDLITyeCk4Ki6OG8P1GhVEC9dtexn3SPZQ2mH2ksgPGHvkIQpucXZX
         1bkJ6lMaPDIagJVp19w/q8bKi3GGulpRPHjJsVBYzjRG7LGa7IMfcEw9yxhnowTF/SB0
         agHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/J/J2yQlCB6JfpYHRJOvL8C31SV3iVfRTBQjfb8JZ1o=;
        b=k2mcT/CtEsA1sR3JYh+TcjcfCvmHqlhYTwbvXJG1yHjbp8FjFAtA6SQgEfcTQn4iWL
         VytI8dmDIghnOVlaCAPcBVEYH0zwexGGV3yL6LBJtiU/Yz9GWgAfK+t5WfeCcVoZG1OF
         9Y2K/tb/bKGgl9d3I+pNpSyyg9V2i8fU9LAPFyuYs3yocxtd6S/VfmJKUSwqU1N3O1EJ
         Wb8XzXllFP1uOqC85AVR9jstpLE+74E5PGyUuHe5y60W9TsuSOpVMlHqufhfDc1C7ljF
         nciO2er+JWDPxdrgWg0Xip02sjNTPKzx8Q4R879RKjWQWyYxJ3zcDEGHzE8VBD/Z5dKh
         Fo0g==
X-Gm-Message-State: AGRZ1gJvgKrQ4ZZptPL4vTdpU2NWKDRZP3myLABXNjxxJ4A89zbtasi2
        llOB1r19QQEvMOyvUFh27Q==
X-Google-Smtp-Source: AJdET5emXeHgj/Gbl4NlG8yVzmVKchL5CQkmsTkR8C6Xfro3JRbODZUppL+G9XaHdCaG2PS/Hb0jGw==
X-Received: by 2002:a25:6a45:: with SMTP id f66-v6mr1944165ybc.155.1542209182091;
        Wed, 14 Nov 2018 07:26:22 -0800 (PST)
Received: from 960.armstrong.edu ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id b196-v6sm11573815ywh.108.2018.11.14.07.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 07:26:21 -0800 (PST)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: [PATCH v6 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date:   Wed, 14 Nov 2018 10:25:58 -0500
Message-Id: <20181114152602.7842-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114152602.7842-1-ayman.bagabas@gmail.com>
References: <20181114152602.7842-1-ayman.bagabas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of Huawei laptops come with a LED in the micmute key. This patch
enables the use of micmute LED for these devices:
1. Matebook X (19e5:3200), (19e5:3201)
2. Matebook X Pro (19e5:3204)

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/huawei_wmi_helper.c | 47 +++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     | 14 ++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 sound/pci/hda/huawei_wmi_helper.c

diff --git a/sound/pci/hda/huawei_wmi_helper.c b/sound/pci/hda/huawei_wmi_helper.c
new file mode 100644
index 000000000000..7c91f914ffba
--- /dev/null
+++ b/sound/pci/hda/huawei_wmi_helper.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Helper functions for Huawei WMI micmute LED;
+ * to be included from codec driver
+ */
+
+#if IS_ENABLED(CONFIG_HUAWEI_WMI)
+#include <linux/platform_data/x86/huawei-wmi.h>
+
+static int (*huawei_wmi_micmute_led_set_func)(bool);
+
+static void update_huawei_wmi_micmute_led(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	huawei_wmi_micmute_led_set_func(spec->micmute_led.led_value);
+}
+
+static void alc_fixup_huawei_wmi(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	bool removefunc = false;
+
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		if (!huawei_wmi_micmute_led_set_func)
+			huawei_wmi_micmute_led_set_func = symbol_request(huawei_wmi_micmute_led_set);
+		if (!huawei_wmi_micmute_led_set_func) {
+			codec_warn(codec, "Failed to find huawei_wmi symbol huawei_wmi_micmute_led_set\n");
+			return;
+		}
+
+		removefunc = (huawei_wmi_micmute_led_set_func(false) < 0)
+			|| (snd_hda_gen_add_micmute_led(codec, update_huawei_wmi_micmute_led) < 0);
+	}
+
+	if (huawei_wmi_micmute_led_set_func && (action == HDA_FIXUP_ACT_FREE || removefunc)) {
+		symbol_put(huawei_wmi_micmute_led_set);
+		huawei_wmi_micmute_led_set_func = NULL;
+	}
+}
+
+#else
+
+static void alc_fixup_huawei_wmi(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+}
+
+#endif
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 135c0826859b..5431dee40f4f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5374,6 +5374,9 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
+/* for alc_fixup_huawei_wmi */
+#include "huawei_wmi_helper.c"
+
 enum {
 	ALC269_FIXUP_SONY_VAIO,
 	ALC275_FIXUP_SONY_VAIO_GPIO2,
@@ -5494,6 +5497,7 @@ enum {
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC256_FIXUP_HUAWEI_MBXP_PINS,
+	ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 };
@@ -5765,6 +5769,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_huawei_wmi
+	},
 	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -5779,7 +5787,9 @@ static const struct hda_fixup alc269_fixups[] = {
 			{0x1e, 0x411111f0},
 			{0x21, 0x04211020},
 			{ }
-		}
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED
 	},
 	[ALC269_FIXUP_ASUS_X101_FUNC] = {
 		.type = HDA_FIXUP_FUNC,
@@ -6611,6 +6621,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
+	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED),
+	SND_PCI_QUIRK(0x19e5, 0x3201, "Huawei MBX", ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 
-- 
2.17.2

