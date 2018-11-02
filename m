Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388DEC6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D4F2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 04:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPiLRerk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D4F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeKBNRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 09:17:36 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40133 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeKBNRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 09:17:36 -0400
Received: by mail-vs1-f67.google.com with SMTP id s9so366401vsk.7;
        Thu, 01 Nov 2018 21:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=5SMTWRHblam50hFXCZFpH9+3ZtgrRgiP4fXKZNWtfJ4=;
        b=HPiLRerkAYVujBw+9k4TpapXG3ghOiEkffXYkePKjdYbpAkBfFyD/6cNX8UzpVktw0
         p9oxG6M2dY0im+id5/rBrGjCE8N6kLD8thALVx+YgvhxPSeLLoz+9Mfs02EQza5AKm70
         +Q8RF2yOIjr12rxrzUsuB8QoE4OdO3PegwbBEj73B5DjxOQW0zY5QvHt9dBIUQCt3mgN
         7h46OZFt3y7NkO/P3toxSSnsjgKonCOBPlBIVLkPqzuD7liIpksV8GRyTkCD4WJ+oDrE
         6HMcYuiP8pwIpudh7TrslnvexeaUiyLKht2EwJPxZbfUQZhlkYQ2KWa2it6EuA2KShiF
         9WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=5SMTWRHblam50hFXCZFpH9+3ZtgrRgiP4fXKZNWtfJ4=;
        b=XLTpgdf0XqQXOIBOlEtxaBkJPWsOY1H46/HszlJHq85SsNF51ZAooTSeIxcETIlQuq
         /B4kcEH5YNuryECgaFj2Axw/YJknJ6vrGxp3FBdUIoBDeHBXdh4lh3wsiNgw0XY3Tl8a
         IZaoQiaWlplAS9hh+2/uF/9DPjYpG4e5sqkITDX/y2cYedEpIhmx6oCJhLZohnU8PbuE
         twu3j5D38wm0jEF4KHuN5WrCjFO3CG4ta0dCVl0qgad26EjgJc1ty5txbQ/usvNP1JEe
         BZ7b1Amn9dqAsSi9kw/OmJPfRkY7ArGja/tdde8EK5R3zrYJNtSHym8KeuR/g6K0lWC2
         F8sg==
X-Gm-Message-State: AGRZ1gJeRIaqfjAaRBbX83PFiSYmNaGLKqP5+ZeWEOYWJFJ8M7U9XV1Y
        qV+rLheOvm3Kth0yl4GyZg==
X-Google-Smtp-Source: AJdET5ddNVCQaStRGQHiZ8wrxnFW5fZf00R9K6xBoxsZk6UAppM4gkXiWQ3MNxQmd9hf55NxTF51sQ==
X-Received: by 2002:a67:d81:: with SMTP id 123mr3880137vsn.211.1541131912606;
        Thu, 01 Nov 2018 21:11:52 -0700 (PDT)
Received: from localhost.localdomain ([2601:902:c200:6512:a50b:fc5d:3604:d966])
        by smtp.gmail.com with ESMTPSA id a2sm1661150uaa.15.2018.11.01.21.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 21:11:52 -0700 (PDT)
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
Subject: [PATCH v2 3/3] ALSA: hda: add support for Huawei WMI MicMute LED
Date:   Fri,  2 Nov 2018 00:11:15 -0400
Message-Id: <20181102041120.7603-4-ayman.bagabas@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181102041120.7603-1-ayman.bagabas@gmail.com>
References: <20181102041120.7603-1-ayman.bagabas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of Huawei laptops come with a LED in the mic mute key. This patch
enables and disable this LED accordingly.

Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
---
 drivers/platform/x86/huawei_wmi.c |  1 +
 include/linux/huawei_wmi.h        |  7 +++++
 sound/pci/hda/huawei_wmi_helper.c | 48 +++++++++++++++++++++++++++++++
 sound/pci/hda/patch_realtek.c     | 10 +++++++
 4 files changed, 66 insertions(+)
 create mode 100644 include/linux/huawei_wmi.h
 create mode 100644 sound/pci/hda/huawei_wmi_helper.c

diff --git a/drivers/platform/x86/huawei_wmi.c b/drivers/platform/x86/huawei_wmi.c
index 83545217ac19..cc5492571727 100644
--- a/drivers/platform/x86/huawei_wmi.c
+++ b/drivers/platform/x86/huawei_wmi.c
@@ -26,6 +26,7 @@
 #include <linux/input/sparse-keymap.h>
 #include <linux/acpi.h>
 #include <linux/wmi.h>
+#include <linux/huawei_wmi.h>
 
 MODULE_AUTHOR("Ayman Bagabas <ayman.bagabas@gmail.com>");
 MODULE_DESCRIPTION("Huawei WMI hotkeys");
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
index 000000000000..77edb658cbf0
--- /dev/null
+++ b/sound/pci/hda/huawei_wmi_helper.c
@@ -0,0 +1,48 @@
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
+static void update_huawei_wmi_micmute_led(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
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
+		removefunc = (huawei_wmi_micmute_led_set_func(false) < 0)
+			|| (snd_hda_gen_add_micmute_led(codec, update_huawei_wmi_micmute_led) < 0);
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
+static void alc_fixup_huawei_wmi(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+}
+
+#endif
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 4f7a39c7883c..d09457d2a4f3 100644
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
@@ -6348,6 +6352,10 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -6363,6 +6371,8 @@ static const struct hda_fixup alc269_fixups[] = {
 			{0x21, 0x04211020},
 			{ },
 		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_HUAWEI_WMI_MICMUTE_LED
 	},
 	[ALC295_FIXUP_HP_X360] = {
 		.type = HDA_FIXUP_FUNC,
-- 
2.17.2

