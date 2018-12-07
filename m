Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD289C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7242820868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 09:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Nud5MsL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7242820868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeLGJSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 04:18:51 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37625 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbeLGJSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 04:18:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so1569585plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 01:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=emaha2gf5Gj7+YTlhynaOWZVh5v9mgbK4I4DH8K0DeU=;
        b=Nud5MsL5qmctGtSXJ0F7TmL05KMHEQcF2+JDjsXYnpyisq6mLs3S6Rf3JWnliq4lim
         cClmSqvLhNfo36QvBamogi5zC3L5SGgVfj7i+0+F5XhxNfvN/A2Z5QhbH8c2j4jT9EZV
         K4ZxP+ahY1aXBW5Ryeni8UcNTBmmK9CF4spYPsFXZm2Hf+A3Q9BX3CtLcv4Q/vLkhGrQ
         PFR/Z2TlwnptV7Dw04sfArRTs8WX2RSTnJmhyK2RFNFFQAq5YUil/E0P1PJLq1c2WGRW
         AWheRnnvq7Yk4vBMOeK7J28cOePS7O9+9sIPX09f/kjwp7h2kN6XjfAjpQCS2Lbfp9gA
         I7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=emaha2gf5Gj7+YTlhynaOWZVh5v9mgbK4I4DH8K0DeU=;
        b=df5fd0WWw0LQ8Rr0UbydP1stsjowpS/XWLUD/G9bm0PuVZT+a9JKEGImaXJcfm1n0L
         7fd0CfrccFvF28cTVtrhQUT93qVaDutssu+HohTwFZAk5I6ch9urfnuraoOWX7FmbWv1
         PhqdqqbkiyaexJJH7IZOnVnRXTW3fM43kin04jfWOIv6FggWBYxTBWiwsqAYosSVY/7f
         VylmtF1CTCPoC44PbUoRDxzzC6t981CtXF7CU9XzIwHPdXavT9M4hp3TFTBhjNkAu6qy
         bn+dUzTmWCKNn7yF4ww8pv2FtQBK0ha3P8NPFGPxZAJXTX1foRGjFXLaZUiK88j3xZuH
         eUCg==
X-Gm-Message-State: AA+aEWayuMYTl9RBzupRvYclLczvupKCNX+DB9GzeZerTRrMGqEvqmyQ
        IHedKj5sOzXJDV2EOYkOmy6DPQ==
X-Google-Smtp-Source: AFSGD/WRnooJsghzmTaa6c10q0Zv8SR0TctG0EfX9lqmSK2N6attcaWStztbo58SQ6Z3dVtvp0F0QQ==
X-Received: by 2002:a17:902:7b88:: with SMTP id w8mr1391860pll.320.1544174328072;
        Fri, 07 Dec 2018 01:18:48 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id y1sm3480927pfe.9.2018.12.07.01.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 01:18:47 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com, josh@wtmec.com,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>
Subject: [PATCH v3 3/3] ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN/UX333FA with ALC294
Date:   Fri,  7 Dec 2018 17:17:13 +0800
Message-Id: <20181207091713.7483-4-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181207091713.7483-1-jian-hong@endlessm.com>
References: <CAPpJ_edVC+zgVrh3TwOL3NsM_6yeq-P0sgmX0L-5OE-QFDN3Zg@mail.gmail.com>
 <20181207091713.7483-1-jian-hong@endlessm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS UX433FN and UX333FA with ALC294 cannot detect the headset MIC
and output through the internal speaker and the headphone until
ALC294_FIXUP_ASUS_SPK and ALC294_FIXUP_ASUS_HEADSET_MIC quirk applied.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
v2:
- Add UX333FA support.  ASUS UX533FD, UX433FN and UX333FA use the same quirk now.

v3:
- Modify the quirk's entry name

 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index aa7aabd6e09a..14c883a16290 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7190,6 +7190,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x14, 0x90170110},
 		{0x1b, 0x90a70130},
 		{0x21, 0x04211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0294, 0x1043, "ASUS", ALC294_FIXUP_ASUS_SPK,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC295_STANDARD_PINS,
 		{0x17, 0x21014020},
-- 
2.11.0

