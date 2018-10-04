Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C252BC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1EC2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=neverware.com header.i=@neverware.com header.b="df3aVKQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1EC2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neverware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJEBxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:53:35 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45625 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeJEBxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:53:35 -0400
Received: by mail-qt1-f195.google.com with SMTP id e10-v6so25800qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 11:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neverware.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DmpLN7jl8dOyjcHvlmW7QHGVoHmIXAmQAKW9LpIK2Wc=;
        b=df3aVKQga0sg2LCNCBtOQUUwSmCo77xGWBuNrzNgQi7o3q+S2Impjz3s3UcVRb2LKH
         B2zI1BF/Jv87fAllQ371x5dHIMmF53uFnUkvmBnU9WVSZKYF4BgeXewJPkzdxLh2PFgt
         upMsaLA6x+qKPIaBg3JKDtLDg841NdZbp6XfU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DmpLN7jl8dOyjcHvlmW7QHGVoHmIXAmQAKW9LpIK2Wc=;
        b=GsPYDEfB9vXgqKiOI2uI6CLIFcnotkqjOnSvqTC73I2VgXYq6ejsz+ksffq0B9R8sv
         PkXAEVxWh0RG6RKU2F/aydQVguXW4Zy3FbikpicVf4DTk1y37BaZeYCiRNcOP0Vdm4kT
         EHeUOwVKGXV7R99wEdELf/saH2Vw+ZddWANc9f8tKxSKPwBmwizVqrBbqpATEr/U+L4j
         ZwjJWB7J7oODbJNw18ls+MnaOOs6/Z7DcnfBRMZjr55UkjYgZQixc5LDa962mgxBmCLS
         dDRgH6+tWFhzkq8zQDHNEKGdzCmbkAu5mMGvZLmjbOhT5qH8KvYdCpbFq2ggkNZ7oPrV
         2pDQ==
X-Gm-Message-State: ABuFfogpKWZVSgXXQt37oJFI+2XUAIabWZ7fSVedj9nT9FWox+XmssY2
        EIRHBjBxCZ2xiRc3RiL1+A0CVw==
X-Google-Smtp-Source: ACcGV61ksO+KTN3+JQZDq5DpFIUfIUREDB6Vnn3zmJCsU4hiLiLjvbJpffsqAc4um0s7sZ2FDfPcfA==
X-Received: by 2002:ac8:362a:: with SMTP id m39-v6mr6611128qtb.210.1538679540222;
        Thu, 04 Oct 2018 11:59:00 -0700 (PDT)
Received: from hotbox.seaworld.local (rrcs-208-105-51-90.nyc.biz.rr.com. [208.105.51.90])
        by smtp.googlemail.com with ESMTPSA id j18-v6sm3404852qkh.20.2018.10.04.11.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 11:58:59 -0700 (PDT)
From:   Michael Pobega <mpobega@neverware.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Michael Pobega <mpobega@neverware.com>
Subject: [PATCH] ALSA: hda/sigmatel - Disable automute for Elo VuPoint
Date:   Thu,  4 Oct 2018 14:58:21 -0400
Message-Id: <20181004185821.67612-1-mpobega@neverware.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Elo VuPoint 15MX has two headphone jacks of which neither work by
default. Disabling automute allows ALSA to work normally with the
speakers & left headphone jack.

Future pin configuration changes may be required in the future to get
the right headphone jack working in tandem.

Signed-off-by: Michael Pobega <mpobega@neverware.com>
---
 sound/pci/hda/patch_sigmatel.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 046705b4691a..d8168aa2cef3 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -77,6 +77,7 @@ enum {
 	STAC_DELL_M6_BOTH,
 	STAC_DELL_EQ,
 	STAC_ALIENWARE_M17X,
+	STAC_ELO_VUPOINT_15MX,
 	STAC_92HD89XX_HP_FRONT_JACK,
 	STAC_92HD89XX_HP_Z1_G2_RIGHT_MIC_JACK,
 	STAC_92HD73XX_ASUS_MOBO,
@@ -1879,6 +1880,18 @@ static void stac92hd73xx_fixup_no_jd(struct hda_codec *codec,
 		codec->no_jack_detect = 1;
 }
 
+
+static void stac92hd73xx_disable_automute(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct sigmatel_spec *spec = codec->spec;
+
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	spec->gen.suppress_auto_mute = 1;
+}
+
 static const struct hda_fixup stac92hd73xx_fixups[] = {
 	[STAC_92HD73XX_REF] = {
 		.type = HDA_FIXUP_FUNC,
@@ -1904,6 +1917,10 @@ static const struct hda_fixup stac92hd73xx_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = stac92hd73xx_fixup_alienware_m17x,
 	},
+	[STAC_ELO_VUPOINT_15MX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = stac92hd73xx_disable_automute,
+	},
 	[STAC_92HD73XX_INTEL] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = intel_dg45id_pin_configs,
@@ -1942,6 +1959,7 @@ static const struct hda_model_fixup stac92hd73xx_models[] = {
 	{ .id = STAC_DELL_M6_BOTH, .name = "dell-m6" },
 	{ .id = STAC_DELL_EQ, .name = "dell-eq" },
 	{ .id = STAC_ALIENWARE_M17X, .name = "alienware" },
+	{ .id = STAC_ELO_VUPOINT_15MX, .name = "elo-vupoint-15mx" },
 	{ .id = STAC_92HD73XX_ASUS_MOBO, .name = "asus-mobo" },
 	{}
 };
@@ -1991,6 +2009,8 @@ static const struct snd_pci_quirk stac92hd73xx_fixup_tbl[] = {
 		      "Alienware M17x", STAC_ALIENWARE_M17X),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_DELL, 0x0490,
 		      "Alienware M17x R3", STAC_DELL_EQ),
+	SND_PCI_QUIRK(0x1059, 0x1011,
+		      "ELO VuPoint 15MX", STAC_ELO_VUPOINT_15MX),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x1927,
 				"HP Z1 G2", STAC_92HD89XX_HP_Z1_G2_RIGHT_MIC_JACK),
 	SND_PCI_QUIRK(PCI_VENDOR_ID_HP, 0x2b17,
-- 
2.17.1

