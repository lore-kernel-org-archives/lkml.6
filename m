Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037A8C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7E1214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="UeK85UV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7E1214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeLFIrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:47:41 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41100 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729054AbeLFIri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:47:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so11436177pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 00:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HWmRGnQfB5yREIphnhfXfwNXTJMNE2AWhXB81JcZyh8=;
        b=UeK85UV8GBvu1k90fFnaBmd7HSQ4JmT8C//3O/hzS8pLoomO+SkgUZj7kQYJKMcBnV
         V0BIBHEhnGQccN1Rxx4V3GyAwHlPUs2piB8YODUsewTabyiv+nnQCsEvDvBv2Xokf2LJ
         bIN+9lSHHRfSbJpApESRuRZNsjy7/mIJfh4KA0/NFP/lSV4WmYDQr3Ky1ny33RGhnqA/
         IJ9Mibm58SJXdxSN6wnBXxxwaUBuUSIa1qZMPwwRRKXHp0AYo5H6Pp21GMbs5h15dkL2
         npl+ulmiNZ6NGzjm2Y5janIdmh9CUKiATXsLXq2LxQtX+nvkN0os4LigpwTQlRotY7uV
         7w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HWmRGnQfB5yREIphnhfXfwNXTJMNE2AWhXB81JcZyh8=;
        b=SERSw2GmN6Pdh/B0te8PcfvrUfkTa9bivQIePLRh42gHvLyjwnHyQ/uCGK44qplpI2
         B7liHpTezQZqZuYQ/fAYDXmASRHBh5JW0MC5uhw0DFVJuTKtxVJV83mpSzhM1s7HRM7A
         hqIV+/jL/TdQT+LuKGCD3lSU104qHLWV9wyK1f+TGVBLHIDgtmgkLOYiFfZDvh5kLfru
         Am88fvJQuzCccea1jjnaHh4hgiLr9VkeZR+UGH+WtD6Iwme3D8/o5XburtUVntwt1/hY
         3yfS/sjJ8drbAnuNQioUVXfWwHqX2Ph4WMLBhY+kcSmaE1tOM1y999UjkLFuhyyOVqED
         0t6g==
X-Gm-Message-State: AA+aEWbW6+oNO0Z9Qy08X7kWpAWQy0l9U1gHtc2BrXpkvgrtGxea9qId
        bTU1UtkjKDTdvDwfvQ8XaKt4SQ==
X-Google-Smtp-Source: AFSGD/XJm8NqEru1gxEeHY1SuILExYi2MFcJqXwa71ieKjyJDcwkfBx/RZqkcvUkSW1x64JfQzrrjw==
X-Received: by 2002:a63:4b25:: with SMTP id y37mr24081916pga.181.1544086057881;
        Thu, 06 Dec 2018 00:47:37 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id u70sm40484836pfa.176.2018.12.06.00.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 00:47:37 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH v2 3/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN/UX333FA with ALC294
Date:   Thu,  6 Dec 2018 16:45:54 +0800
Message-Id: <20181206084554.4728-4-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181206084554.4728-1-jian-hong@endlessm.com>
References: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
 <20181206084554.4728-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS UX433FN and UX333FA with ALC294 cannot detect the headset MIC
and output through the internal speaker and the headphone until
ALC294_FIXUP_ASUS_SPK_NOISE quirk applied.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
v2:
- Add UX333FA support.  ASUS UX533FD, UX433FN and UX333FA use the same quirk now.

 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1525bcdf96e8..97d1a4aaeccd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7192,6 +7192,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK_NOISE,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},
-- 
2.11.0

