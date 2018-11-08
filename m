Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67978ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2540820817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHJooLJQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2540820817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbeKICyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 21:54:15 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40044 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbeKICyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 21:54:15 -0500
Received: by mail-ua1-f66.google.com with SMTP id n7so7472604uao.7;
        Thu, 08 Nov 2018 09:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=h0+0KTJsu6PVSeFp8yzXYmba/nQ5Vz0KUhLkno1pcPY=;
        b=MHJooLJQM9wviND3/4scHjWVhq6cN4hWGfJdhMSfKSZq9syulxH52eF77Hv8HrmXZ1
         mpIwnxV7BRAONeVR9RT01lXAiQ3rHaHiVjnlWNCDKFUKs0LziOkMuY+71/fCPGtJEvbP
         rB3RII8kyGtGTVuEcRBopM75JQwIMlGpZtySVXfDbsGohQD5wcgBFpNbHUgJW+ZhHU2o
         m8KrGS8EfYE9mjD9slOcoeMqu7Yj2jYOuaMX0sO9ASiZ4NM5a9VKVakjL4bvPkoN6Bzs
         6UEu3HNbcP7OCk6HnwP7eDmS9/rh0ct5YWMYrtqalobPZK2HOGB2qZqEFci2ERZBsyYG
         Yu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=h0+0KTJsu6PVSeFp8yzXYmba/nQ5Vz0KUhLkno1pcPY=;
        b=Knm4MyAev6yrsm+G2cw5hb4YXs22Q/1Fa3AQbQ2yNF5CBdNIg0xewI07PNyp8tgPBa
         GhKlsEBrESb/B0g+REv3zqQ2IfpS+GkeUOsEcTADPnmcDGkepeFxC+4jr9BDNVxSIcRk
         X2NQ3ZSDxd4FOlmWtHVqvOygtNBG74D7fx+LF2w1bixAvpANrh6Ky9cXKCNtUsoMfYBn
         i64++Yviag6AjKnpwPL6yaOeMmkVUFM3L1kl14IlKUwCO0/Hux8DUATujVjrAmaTzMIU
         lE+VhcrWiVDqn8WjtE9XS5flSEm5RivyVspWyMy+70J9ZiKNX9GLs+a0eD+rRzTUhayZ
         VLNw==
X-Gm-Message-State: AGRZ1gKEn/RoBbmsVTbUUI6QV7VJLXZrU36WRKPKuC+jfMbKBA+d9txq
        lNpxL8F1E9OwvvbEjpCAuA==
X-Google-Smtp-Source: AJdET5cBA8713ve5bnYHHnoeqxI9J5YWAGaRLlzTc86gWYvPhPglkuzZ6OwW2/1UFa/vvsIVybYt+Q==
X-Received: by 2002:ab0:498a:: with SMTP id e10mr2544323uad.134.1541697465907;
        Thu, 08 Nov 2018 09:17:45 -0800 (PST)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id y195sm1792776vkd.0.2018.11.08.09.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 09:17:45 -0800 (PST)
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
Subject: [PATCH v3 3/3] ALSA: hda: add support for Huawei WMI micmute LED
Date:   Thu,  8 Nov 2018 12:16:55 -0500
Message-Id: <20181108171701.4444-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181108171701.4444-1-ayman.bagabas@gmail.com>
References: <20181108171701.4444-1-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of Huawei laptops come with a LED in the micmute key. This patch
enables and disable this LED accordingly.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei_wmi.c            |  1 +
 include/linux/platform_data/x86/huawei_wmi.h |  9 ++++
 sound/pci/hda/huawei_wmi_helper.c            | 47 ++++++++++++++++++++
 sound/pci/hda/patch_realtek.c                | 13 +++++-
 4 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/platform_data/x86/huawei_wmi.h
 create mode 100644 sound/pci/hda/huawei_wmi_helper.c

diff --git a/drivers/platform/x86/huawei_wmi.c b/drivers/platform/x86/huawei_wmi.c
index 658c44ab2126..f06aa967c311 100644
--- a/drivers/platform/x86/huawei_wmi.c
+++ b/drivers/platform/x86/huawei_wmi.c
@@ -23,6 +23,7 @@
 #include <linux/input.h>
 #include <linux/input/sparse-keymap.h>
 #include <linux/module.h>
+#include <linux/platform_data/x86/huawei_wmi.h>
 
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
 MODULE_DESCRIPTION("Huawei WMI hotkeys");
diff --git a/include/linux/platform_data/x86/huawei_wmi.h b/include/linux/platform_data/x86/huawei_wmi.h
new file mode 100644
index 000000000000..dd251780ee5c
--- /dev/null
+++ b/include/linux/platform_data/x86/huawei_wmi.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
+#ifndef __HUAWEI_WMI_H__
+#define __HUAWEI_WMI_H__
+
+int huawei_wmi_micmute_led_set(bool on);
+
+#endif
+#endif
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
+#if IS_ENABLED(CONFIG_HUAWEI_LAPTOP)
+#include <linux/platform_data/x86/huawei_wmi.h>
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
index ed6c9c79ce46..a0fdcfb0b635 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5374,6 +5374,9 @@ static void alc_fixup_thinkpad_acpi(struct hda_codec *codec,
 /* for alc295_fixup_hp_top_speakers */
 #include "hp_x360_helper.c"
 
+/* for alc_fixup_huawei_micmute_led */
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
@@ -6609,6 +6619,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x5109, "Thinkpad", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x511e, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x511f, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x19e5, 0x3200, "Huawei MBX", ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED),
 	SND_PCI_QUIRK(0x19e5, 0x3204, "Huawei MBXP", ALC256_FIXUP_HUAWEI_MBXP_PINS),
 	SND_PCI_QUIRK(0x17aa, 0x3bf8, "Quanta FL1", ALC269_FIXUP_PCM_44K),
 	SND_PCI_QUIRK(0x17aa, 0x9e54, "LENOVO NB", ALC269_FIXUP_LENOVO_EAPD),
-- 
2.17.2

