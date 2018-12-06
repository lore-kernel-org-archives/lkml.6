Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11054C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9AC214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="UXpJOO4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB9AC214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbeLFIrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:47:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33192 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFIrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:47:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so10349124pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 00:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8RG9DGsLTky/JZ1in/dz32c6uI7zGn2e292wRTOfLck=;
        b=UXpJOO4SO7GZI/DQ7E4FBGyvTLWUlSOtMOOYKl5LFLAEcYPBI4WZ+vFL4USuhIJ8SN
         pv7A1VMiwS74SvoHEysD0xKa8nUpFv3wUraTXm3OrTsrudrjs2MYR6HCivCEu4RuP9Gn
         W0Za0TfvEmCa235U1LaVkYDYXOFSOKykH7XeArnS5g94D0SsVnSZrM8baVN/7xvqr2th
         OdSimP/pR+hyvbn+EWgISNPJr7ssXn21VyOBgkF9IbeSVWKaVvPg00hGimzyA+4lBHNt
         /LrEPAkMr3biRyTtkm7ayl9vCQWzwqCKjMA29SYgHlozvkx4ZGF1f0Rum+9eqmQpMDS1
         e8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8RG9DGsLTky/JZ1in/dz32c6uI7zGn2e292wRTOfLck=;
        b=kooMCoSPPjrMRWafO/Jl+3Tlo7GGrD85UsxrjTQ+V/9D0nlmh6Wa/ByWNIebGoprvf
         0fl86oJfXqaatY663ukFhJyymxuBY5pdBfia/Ne1c6hIxxkXD6suPXrz4GDoL+ucKvC6
         kY4Mf9UByMuQ9xOkDxbtxB0tEMN1DpxxSO68U6jhL+GVHrxZM5e+Cspoys+HXWCG4MQB
         o2RhEGP0dOJH2B+t1qP4Em6tWK1uV/i/+wzALHSICpe5pULhflvsxnf8p5EGqbmu8WnK
         3SrQS0YZQl2mzq5LRRUPOBo/cTPu1sETu3eruj0NAptDG0R/tUDalciMOVXZ9LTCy0F9
         H8LA==
X-Gm-Message-State: AA+aEWYO4oVgzFnZ5Td7bUIOPb8oSmgSkVecD0zDMWlrGx0yeKtzjqX8
        RSY3LCcohu0SrwRHcr8PZbEcKQ==
X-Google-Smtp-Source: AFSGD/XWLt/l/4+Bca9BWtebaQ/o/BfFzQnaeW86KiDQ0wQUUCRZs3dZFY+qM1drarpLLANVinKRtQ==
X-Received: by 2002:a62:ed0f:: with SMTP id u15mr26811426pfh.188.1544086052246;
        Thu, 06 Dec 2018 00:47:32 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id u70sm40484836pfa.176.2018.12.06.00.47.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 00:47:31 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH v2 1/3] ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN
Date:   Thu,  6 Dec 2018 16:45:52 +0800
Message-Id: <20181206084554.4728-2-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181206084554.4728-1-jian-hong@endlessm.com>
References: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
 <20181206084554.4728-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

The known ALC256_FIXUP_ASUS_MIC fixup can fix the headphone jack
sensing and enable use of the internal microphone on this laptop
X542UN. However, it's ALC294 so create a new fixup named
ALC294_FIXUP_ASUS_MIC to avoid confusion.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
v2:
- .chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE  ==> change to ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC

 sound/pci/hda/patch_realtek.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index bb40624fb6d5..d32e50b1ed60 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5517,6 +5517,7 @@ enum {
 	ALC285_FIXUP_LENOVO_HEADPHONE_NOISE,
 	ALC295_FIXUP_HP_AUTO_MUTE,
 	ALC286_FIXUP_ACER_AIO_MIC_NO_PRESENCE,
+	ALC294_FIXUP_ASUS_MIC,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -6403,6 +6404,16 @@ static const struct hda_fixup alc269_fixups[] = {
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
+		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7152,6 +7163,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
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

