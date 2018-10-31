Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2335C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A05520657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 19:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVm2dFw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A05520657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbeKAEUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 00:20:22 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33392 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeKAEUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 00:20:21 -0400
Received: by mail-yw1-f66.google.com with SMTP id z72-v6so2679817ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 12:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=/jgzLLdgtRBNR9xsIhqFTgOi4UQ5pmynFIkBK8l/D94=;
        b=EVm2dFw8fI29uxQktWdcTsXze2X4Ge93w54gDTulTsEys3FQQUfMOjVeOHugTCXwOB
         wI2d7Vpbqq/GybIGR3nQ2yi8jgZvsLh4nN0GvMvry7X3gpDUwFGiMaf11HNexw4D1oZ3
         6XDpWy+ZO0/REYaSQrxItjE6p3a69nvQV9ratuaajhFd6VdVjfv0NsfCXSsvGuyNXXOQ
         ZXwxvdNbzslG37XREvwmpdfRsitFfu1V0YIMXdOUmG2KII03zwaZPMYS9XQ/IQWBFaXk
         RZbA7Ne3Wp5abCDrqDsa+xUdJKaj4A7xe+ifZxqikCRY7mUE4AG6BnIdSxSo4hmiC1Xl
         xoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=/jgzLLdgtRBNR9xsIhqFTgOi4UQ5pmynFIkBK8l/D94=;
        b=ENJo/EgCwswbfZEk4LEMd5az2K5TBQ7gYO4ZQpcvLMwNTVC1+Epi7EJOah8BjHpzGD
         iRDYjqM68FPZiD7KGjfw/jJSpx9VzbkfO7f8gjc/tnaXBgCXj5WyeMAPqnIugyyOMxQK
         TyssHqU1iz3nhHHu3EcENDIbrlcmsu0P7ZVnCUczkufktBlvcGQ0b6bC9HqdjEU8z8HP
         MQOcit7eVMMGIXvkKgs+6kacTXEcyCDgQ7smHdrV3iHbEmCTi1R4jn4CssP7x08D1YMw
         48PbsyErZbnMLKqqT8QCnW6A2KJ8faCCsX9pGT6MOS4bdoayMitOjTAi/oskhONaUmkq
         Wn3g==
X-Gm-Message-State: AGRZ1gK9xPT2XwUu0xBQOvBNAN/k/QraR/6QalJPx/O4nUQ7UII1GN6Z
        zxodI05XgiGaQP4azM5I6g==
X-Google-Smtp-Source: AJdET5eCUg3L+VqVnC8E086A/MYizCUERuumre3DoUm6xPGZVPxTV6Y1h8PSgVnW/a0m/v1dcmwTOw==
X-Received: by 2002:a81:2813:: with SMTP id o19-v6mr4552529ywo.225.1541013656905;
        Wed, 31 Oct 2018 12:20:56 -0700 (PDT)
Received: from 960.armstrong.edu ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id l186-v6sm6577857ywb.2.2018.10.31.12.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 12:20:56 -0700 (PDT)
From:   Ayman Bagabas <ayman.bagabas@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [PATCH 3/3] ALSA:hda: add support for Huawei WMI MicMute LED
Date:   Wed, 31 Oct 2018 15:20:38 -0400
Message-Id: <20181031192045.7877-1-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of Huawei laptops come with a LED in the mic mute key. This patch
enables and disable this LED when the internal microphone status is
changed.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 include/linux/huawei_wmi.h        |  7 ++++
 sound/pci/hda/huawei_wmi_helper.c | 66 +++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     | 12 ++++++
 3 files changed, 85 insertions(+)
 create mode 100644 include/linux/huawei_wmi.h
 create mode 100644 sound/pci/hda/huawei_wmi_helper.c

diff --git a/include/linux/huawei_wmi.h b/include/linux/huawei_wmi.h
new file mode 100644
index 000000000000..69b656c5029b
--- /dev/null
+++ b/include/linux/huawei_wmi.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __HUAWEI_WMI_H__
+#define __HUAWEI_WMI_H__
+
+int huawei_wmi_micmute_led_set(bool on);
+
+#endif
diff --git a/sound/pci/hda/huawei_wmi_helper.c b/sound/pci/hda/huawei_wmi_helper.c
new file mode 100644
index 000000000000..57256f51fd88
--- /dev/null
+++ b/sound/pci/hda/huawei_wmi_helper.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Helper functions for Huawei WMI Mic Mute LED;
+ * to be included from codec driver
+ */
+
+#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
+#include <linux/huawei_wmi.h>
+
+static int (*huawei_wmi_micmute_led_set_func)(bool);
+
+static void update_huawei_wmi_micmute_led(struct hda_codec *codec,
+					  struct snd_kcontrol *kcontrol,
+					  struct snd_ctl_elem_value *ucontrol)
+{
+	if (!ucontrol || !huawei_wmi_micmute_led_set_func)
+		return;
+	if (strcmp("Capture Switch", ucontrol->id.name) == 0 && ucontrol->id.index == 0) {
+		/* TODO: How do I verify if it's a mono or stereo here? */
+		bool val = ucontrol->value.integer.value[0] || ucontrol->value.integer.value[1];
+		huawei_wmi_micmute_led_set_func(!val);
+	}
+}
+
+static void alc_fixup_huawei_wmi(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	bool removefunc = false;
+
+	codec_info(codec, "In alc_fixup_huawei_wmi\n");
+
+	if (action == HDA_FIXUP_ACT_PROBE) {
+		if (!huawei_wmi_micmute_led_set_func)
+			huawei_wmi_micmute_led_set_func = symbol_request(huawei_wmi_micmute_led_set);
+		if (!huawei_wmi_micmute_led_set_func) {
+			codec_warn(codec, "Failed to find huawei_wmi symbol huawei_wmi_micmute_led_set\n");
+			return;
+		}
+
+		removefunc = true;
+		if (huawei_wmi_micmute_led_set_func(false) >= 0) {
+			if (spec->num_adc_nids > 1 && !spec->dyn_adc_switch)
+				codec_dbg(codec, "Skipping micmute LED control due to several ADCs");
+			else {
+				spec->cap_sync_hook = update_huawei_wmi_micmute_led;
+				removefunc = false;
+			}
+		}
+		codec_info(codec, "In alc_fixup_huawei_wmi IF\n");
+
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
+static void hda_fixup_huawei_wmi(struct hda_codec *codec,
+				   const struct hda_fixup *fix, int action)
+{
+}
+
+#endif
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4f7a39c7883c..0dab00c0df50 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5371,6 +5371,9 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
 /* for dell wmi mic mute led */
 #include "dell_wmi_helper.c"
 
+/* for huawei wmi mic mute led */
+#include "huawei_wmi_helper.c"
+
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
@@ -5494,6 +5497,7 @@ enum {
 	ALC255_FIXUP_DUMMY_LINEOUT_VERB,
 	ALC255_FIXUP_DELL_HEADSET_MIC,
 	ALC256_FIXUP_HUAWEI_MBXP_PINS,
+	ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED,
 	ALC295_FIXUP_HP_X360,
 	ALC221_FIXUP_HP_HEADSET_MIC,
 };
@@ -6348,6 +6352,10 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_huawei_wmi,
+	},
 	[ALC256_FIXUP_HUAWEI_MBXP_PINS] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -6363,6 +6371,8 @@ static const struct hda_fixup alc269_fixups[] = {
 			{0x21, 0x04211020},
 			{ },
 		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED
 	},
 	[ALC295_FIXUP_HP_X360] = {
 		.type = HDA_FIXUP_FUNC,
@@ -6610,6 +6620,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x511e, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
+	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
@@ -6775,6 +6786,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC274_FIXUP_DELL_AIO_LINEOUT_VERB, .name = "alc274-dell-aio"},
 	{.id = ALC255_FIXUP_DUMMY_LINEOUT_VERB, .name = "alc255-dummy-lineout"},
 	{.id = ALC255_FIXUP_DELL_HEADSET_MIC, .name = "alc255-dell-headset"},
+	{.id = ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED, .name = "alc256-huawei-micmute"},
 	{.id = ALC295_FIXUP_HP_X360, .name = "alc295-hp-x360"},
 	{}
 };
-- 
2.17.2

