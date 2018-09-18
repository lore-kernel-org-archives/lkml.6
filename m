Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5476AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF552150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msPamjZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEF552150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbeISAIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:40 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37965 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbeISAIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:39 -0400
Received: by mail-qt0-f194.google.com with SMTP id x7-v6so2678510qtk.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XujK8MQidMKcntyzJgmscXkxVAVwHJrM1gc7tVVoGv4=;
        b=msPamjZQUfczybnPhK0i8dtRCc9Hn3nyEWLjQj2Eg1OnAl/FkJ27sUpd69ihn+iVsi
         59o4jLj6QwciNWgxrLoXirrPKt0MHamhSBFxikgiezx1CRVOv0HRj1ikQbOIWGoTf5FD
         keV8MF4lTxPwew1L42dlOwaqJKgmxm7yIy9MLOuKkukIH9prOLgxAKIO+kkU+lmocPvU
         v2PT75rOe4ZwnN8Z0BLcmiFL6U3uP6FBRFVIvB52L16yN5HiKoNcd/MfYZRiBSvgIEgv
         jpeST35ogBiYROJ7lc2ahpb085DsY03xwXA+imSVys1kdGnnoAGtf4ufPymJBFVze16Y
         k/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XujK8MQidMKcntyzJgmscXkxVAVwHJrM1gc7tVVoGv4=;
        b=LkgsOpJsIPW95ohzAVCWw6ua9iYuBP12b3/RFwEgzvVsB+UhUEfGHHCdzI7IH8J5np
         Tm5aYTlPQw1KeihueeV+0T0XECo5NNNuox4/C20TvNuCSPmRhqhJslnjqG1cNOx3PrqV
         nQhAWoEjIU9fD5cEuFBtonlevzf5zf8NQrXaf0mac98NRP0oSGcaiFHWcVGKvrLO6/ut
         gBwT8bmpn5WStauXi4zPh2SntSgS1OEzUtHZ0O/pCDpKYlQ02HmE4R0MS0W+vl1593ee
         BHErl5XNeiQBBqrGLabS6Vjd5UCRV5oSIBJorsv1DgmdcOeRpqirD1QLL/AquJMEpicT
         6eMQ==
X-Gm-Message-State: APzg51BGtF0ZGdlzUoPP55vonnhskzAf2YQvqWH4iKWZY8hwxm44LLGm
        mIX6KOZxXzI9M97x2XBhDOQ=
X-Google-Smtp-Source: ANB0VdbXZ6tX5uNZR5ofPeFhIbDudV9HgWgu6Cvc+7cnEADlRWWvuQ3xFjcVcTAVkRq5EkfMGrmmiQ==
X-Received: by 2002:ac8:27dc:: with SMTP id x28-v6mr22620159qtx.61.1537295687422;
        Tue, 18 Sep 2018 11:34:47 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:47 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/15] ALSA: hda/ca0132 - Add DSP setup functions for AE-5
Date:   Tue, 18 Sep 2018 14:33:38 -0400
Message-Id: <1537295625-8082-11-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DSP setup functions for the AE-5.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 215 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 215 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 66c1150..a625e9d 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6524,6 +6524,151 @@ static void ca0132_alt_dsp_initial_mic_setup(struct hda_codec *codec)
 	}
 }
 
+static void ae5_post_dsp_register_set(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	chipio_8051_write_direct(codec, 0x93, 0x10);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x44);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc2);
+
+	writeb(0xff, spec->mem_base + 0x304);
+	writeb(0xff, spec->mem_base + 0x304);
+	writeb(0xff, spec->mem_base + 0x304);
+	writeb(0xff, spec->mem_base + 0x304);
+	writeb(0x00, spec->mem_base + 0x100);
+	writeb(0xff, spec->mem_base + 0x304);
+	writeb(0x00, spec->mem_base + 0x100);
+	writeb(0xff, spec->mem_base + 0x304);
+	writeb(0x00, spec->mem_base + 0x100);
+	writeb(0xff, spec->mem_base + 0x304);
+	writeb(0x00, spec->mem_base + 0x100);
+	writeb(0xff, spec->mem_base + 0x304);
+
+	ca0113_mmio_command_set(codec, 0x30, 0x2b, 0x3f);
+	ca0113_mmio_command_set(codec, 0x30, 0x2d, 0x3f);
+	ca0113_mmio_command_set(codec, 0x48, 0x07, 0x83);
+}
+
+static void ae5_post_dsp_param_setup(struct hda_codec *codec)
+{
+	/*
+	 * Param3 in the 8051's memory is represented by the ascii string 'mch'
+	 * which seems to be 'multichannel'. This is also mentioned in the
+	 * AE-5's registry values in Windows.
+	 */
+	chipio_set_control_param(codec, 3, 0);
+	/*
+	 * I believe ASI is 'audio serial interface' and that it's used to
+	 * change colors on the external LED strip connected to the AE-5.
+	 */
+	chipio_set_control_flag(codec, CONTROL_FLAG_ASI_96KHZ, 1);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x724, 0x83);
+	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 0);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x92);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0xfa);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x22);
+}
+
+static void ae5_post_dsp_pll_setup(struct hda_codec *codec)
+{
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x41);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc8);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x45);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xcc);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x40);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xcb);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x43);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc7);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x51);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0x8d);
+}
+
+static void ae5_post_dsp_stream_setup(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	mutex_lock(&spec->chipio_mutex);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x725, 0x81);
+
+	chipio_set_conn_rate_no_mutex(codec, 0x70, SR_96_000);
+
+	chipio_set_stream_channels(codec, 0x0C, 6);
+	chipio_set_stream_control(codec, 0x0C, 1);
+
+	chipio_set_stream_source_dest(codec, 0x5, 0x43, 0x0);
+
+	chipio_set_stream_source_dest(codec, 0x18, 0x9, 0xd0);
+	chipio_set_conn_rate_no_mutex(codec, 0xd0, SR_96_000);
+	chipio_set_stream_channels(codec, 0x18, 6);
+	chipio_set_stream_control(codec, 0x18, 1);
+
+	chipio_set_control_param_no_mutex(codec, CONTROL_PARAM_ASI, 4);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x43);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc7);
+
+	ca0113_mmio_command_set(codec, 0x48, 0x01, 0x80);
+
+	mutex_unlock(&spec->chipio_mutex);
+}
+
+static void ae5_post_dsp_startup_data(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	mutex_lock(&spec->chipio_mutex);
+
+	chipio_write_no_mutex(codec, 0x189000, 0x0001f101);
+	chipio_write_no_mutex(codec, 0x189004, 0x0001f101);
+	chipio_write_no_mutex(codec, 0x189024, 0x00014004);
+	chipio_write_no_mutex(codec, 0x189028, 0x0002000f);
+
+	ca0113_mmio_command_set(codec, 0x48, 0x0a, 0x05);
+	chipio_set_control_param_no_mutex(codec, CONTROL_PARAM_ASI, 7);
+	ca0113_mmio_command_set(codec, 0x48, 0x0b, 0x12);
+	ca0113_mmio_command_set(codec, 0x48, 0x04, 0x00);
+	ca0113_mmio_command_set(codec, 0x48, 0x06, 0x48);
+	ca0113_mmio_command_set(codec, 0x48, 0x0a, 0x05);
+	ca0113_mmio_command_set(codec, 0x48, 0x07, 0x83);
+	ca0113_mmio_command_set(codec, 0x48, 0x0f, 0x00);
+	ca0113_mmio_command_set(codec, 0x48, 0x10, 0x00);
+	ca0113_mmio_gpio_set(codec, 0, true);
+	ca0113_mmio_gpio_set(codec, 1, true);
+	ca0113_mmio_command_set(codec, 0x48, 0x07, 0x80);
+
+	chipio_write_no_mutex(codec, 0x18b03c, 0x00000012);
+
+	ca0113_mmio_command_set(codec, 0x48, 0x0f, 0x00);
+	ca0113_mmio_command_set(codec, 0x48, 0x10, 0x00);
+
+	mutex_unlock(&spec->chipio_mutex);
+}
+
 /*
  * Setup default parameters for DSP
  */
@@ -6671,6 +6816,73 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 }
 
 /*
+ * Setup default parameters for the Sound BlasterX AE-5 DSP.
+ */
+static void ae5_setup_defaults(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+	int num_fx;
+	int idx, i;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return;
+
+	ca0132_alt_dsp_scp_startup(codec);
+	ca0132_alt_init_analog_mics(codec);
+	chipio_set_stream_control(codec, 0x03, 1);
+	chipio_set_stream_control(codec, 0x04, 1);
+
+	/* New, unknown SCP req's */
+	tmp = FLOAT_ZERO;
+	dspio_set_uint_param(codec, 0x96, 0x29, tmp);
+	dspio_set_uint_param(codec, 0x96, 0x2a, tmp);
+	dspio_set_uint_param(codec, 0x80, 0x0d, tmp);
+	dspio_set_uint_param(codec, 0x80, 0x0e, tmp);
+
+	ca0113_mmio_command_set(codec, 0x30, 0x2e, 0x3f);
+	ca0113_mmio_gpio_set(codec, 0, false);
+	ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
+
+	/* Internal loopback off */
+	tmp = FLOAT_ONE;
+	dspio_set_uint_param(codec, 0x37, 0x08, tmp);
+	dspio_set_uint_param(codec, 0x37, 0x10, tmp);
+
+	/*remove DSP headroom*/
+	tmp = FLOAT_ZERO;
+	dspio_set_uint_param(codec, 0x96, 0x3C, tmp);
+
+	/* set WUH source */
+	tmp = FLOAT_TWO;
+	dspio_set_uint_param(codec, 0x31, 0x00, tmp);
+	chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
+
+	/* Set speaker source? */
+	dspio_set_uint_param(codec, 0x32, 0x00, tmp);
+
+	ca0132_alt_dsp_initial_mic_setup(codec);
+	ae5_post_dsp_register_set(codec);
+	ae5_post_dsp_param_setup(codec);
+	ae5_post_dsp_pll_setup(codec);
+	ae5_post_dsp_stream_setup(codec);
+	ae5_post_dsp_startup_data(codec);
+
+	/* out, in effects + voicefx */
+	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
+	for (idx = 0; idx < num_fx; idx++) {
+		for (i = 0; i <= ca0132_effects[idx].params; i++) {
+			dspio_set_uint_param(codec,
+					ca0132_effects[idx].mid,
+					ca0132_effects[idx].reqs[i],
+					ca0132_effects[idx].def_vals[i]);
+		}
+	}
+
+	ca0132_alt_create_dummy_stream(codec);
+}
+
+/*
  * Initialization of flags in chip
  */
 static void ca0132_init_flags(struct hda_codec *codec)
@@ -7490,6 +7702,9 @@ static int ca0132_init(struct hda_codec *codec)
 	case QUIRK_SBZ:
 		sbz_setup_defaults(codec);
 		break;
+	case QUIRK_AE5:
+		ae5_setup_defaults(codec);
+		break;
 	default:
 		ca0132_setup_defaults(codec);
 		ca0132_init_analog_mic2(codec);
-- 
2.7.4

