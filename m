Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AE6C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE0CA2147C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789477;
	bh=jaA0P8q2I7Pa5WSVL5Np9RSkpy7/vfvEZa0sDWhGS1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TQEhzWZ1Ah4gve3qSXxi/JqgUt7t1mAF2Kp3JJ9RlD/fx+mKgdHM16a2h4YYhP6Er
	 vNDvVZKneSCAkFoIiCzL3vVp1tz/1MMWhe0lddbf/0Tvn++Xvl3m2X5V4j52kttP2z
	 +j3nJ4NiD3y3udLr6F0jkGWwDm6sZmhGYiVNyi4E=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0CA2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeLNMLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:11:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731738AbeLNMLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:11:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45E982133F;
        Fri, 14 Dec 2018 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789471;
        bh=jaA0P8q2I7Pa5WSVL5Np9RSkpy7/vfvEZa0sDWhGS1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fk4cclzEhXpBp+3yBJ641MeBZqPq5FlmfiwlcTpsUTUhfBPmvALb3k4F2G+DvlV83
         YVoBXJAZdJy15dBrL7J32g1QB7ApUtgSG/z0x9v0zLY+1T2gvDm7FZvNBPT0KtF9aE
         +B/zToHGxL7YlqT6gmSDyKZ55qrmHZqYmm5so2OI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 88/89] ALSA: hda/realtek - Fixed headphone issue for ALC700
Date:   Fri, 14 Dec 2018 13:00:41 +0100
Message-Id: <20181214115734.044368516@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit bde1a7459623a66c2abec4d0a841e4b06cc88d9a upstream.

If it plugged headphone or headset into the jack, then
do the reboot, it will have a chance to cause headphone no sound.
It just need to run the headphone mode procedure after boot time.
The issue will be fixed.
It also suitable for ALC234 ALC274 and ALC294.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6965,6 +6965,37 @@ static void alc269_fill_coef(struct hda_
 	alc_update_coef_idx(codec, 0x4, 0, 1<<11);
 }
 
+static void alc294_hp_init(struct hda_codec *codec)
+{
+	struct alc_spec *spec = codec->spec;
+	hda_nid_t hp_pin = spec->gen.autocfg.hp_pins[0];
+	int i, val;
+
+	if (!hp_pin)
+		return;
+
+	snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
+
+	msleep(100);
+
+	snd_hda_codec_write(codec, hp_pin, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+	alc_update_coef_idx(codec, 0x6f, 0x000f, 0);/* Set HP depop to manual mode */
+	alc_update_coefex_idx(codec, 0x58, 0x00, 0x8000, 0x8000); /* HP depop procedure start */
+
+	/* Wait for depop procedure finish  */
+	val = alc_read_coefex_idx(codec, 0x58, 0x01);
+	for (i = 0; i < 20 && val & 0x0080; i++) {
+		msleep(50);
+		val = alc_read_coefex_idx(codec, 0x58, 0x01);
+	}
+	/* Set HP depop to auto mode */
+	alc_update_coef_idx(codec, 0x6f, 0x000f, 0x000b);
+	msleep(50);
+}
+
 /*
  */
 static int patch_alc269(struct hda_codec *codec)
@@ -7101,6 +7132,7 @@ static int patch_alc269(struct hda_codec
 		spec->codec_variant = ALC269_TYPE_ALC294;
 		spec->gen.mixer_nid = 0; /* ALC2x4 does not have any loopback mixer path */
 		alc_update_coef_idx(codec, 0x6b, 0x0018, (1<<4) | (1<<3)); /* UAJ MIC Vref control by verb */
+		alc294_hp_init(codec);
 		break;
 	case 0x10ec0300:
 		spec->codec_variant = ALC269_TYPE_ALC300;
@@ -7112,6 +7144,7 @@ static int patch_alc269(struct hda_codec
 		spec->codec_variant = ALC269_TYPE_ALC700;
 		spec->gen.mixer_nid = 0; /* ALC700 does not have any loopback mixer path */
 		alc_update_coef_idx(codec, 0x4a, 1 << 15, 0); /* Combo jack auto trigger control */
+		alc294_hp_init(codec);
 		break;
 
 	}


