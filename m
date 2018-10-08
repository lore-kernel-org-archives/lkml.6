Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20526C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D825D2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwuITDaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D825D2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJICza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:55:30 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38598 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJICza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:55:30 -0400
Received: by mail-qk1-f193.google.com with SMTP id 204-v6so12795152qkd.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O001s7whb4Ej4c0eyEFKVYHRXfr2pcp/oR1AMNwDnmw=;
        b=JwuITDaOA/CZ4j/eCYsiE/5VRdi6PX9M1ydYHhAg1c+c4EgKVprm+Ahy8wWGVbEzmD
         zYXfZO5gzkeREoe/qQ/m4CAtJNh/ejq/8SOhclBriXkX0iUx/khm2gwJg5aE9wIxOmI2
         asmJFqjfqK3hcyJn780KklItNkPqbhzvLu8u/8ftP9jKZQNf16Zy614Glen0wuxx07DV
         mC6rPE96+/AHCOinMWLyIQKEwDigef5fXwf2W2geToRjzcC3M4PdbejDHcgPiGdz2N6S
         mNDUACgq8lzIjreAG2w6ZFzBNG/YpGkBoYPLtICRluIKwvqe3EFVFK9bLr0WMij2OAVp
         g4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O001s7whb4Ej4c0eyEFKVYHRXfr2pcp/oR1AMNwDnmw=;
        b=Eu+6xhjXNBcoL3SUn2kBvNFL3yqYzCZi1+1d20mk7Dst9YHJn8C2RC1M9x0XrR+fxH
         uKa7/JuwJe16SpsD4kbZEGti08IymFxuHLhXElgKpSGpS/A5a0W8aI1T42662/xO60G0
         yB4QuRsUfogA/IACmGeubMZ3uYqFjKK62XXg672A6mj/bi4O9gpbt8UYxvOOgbc+RS3m
         RJ+mJsYzmehvqmMbgUVWqqMDH3WziTLnApA7PjBJBFjh5XZCoSQ2XyqghMiaiC0/WMks
         cBcU9xairkrodPWcEjVK+vr0BoZjxJvdFDE61mpt0ZT1zxwr2Ir71CxlG8+yf5erZJ/V
         0u1Q==
X-Gm-Message-State: ABuFfohS8Q5QFXAhFew/Rm4exQ9T2Bfur+zO3RJPVrF7JssBxI02Ug2s
        t1sscUhPiGp2GD8jkxXI6Gk=
X-Google-Smtp-Source: ACcGV63Hzq5moyUfKMEi5XKQw0d/cXvxQpx/a8/RK9VYOmX1Wzo7ucTN4P1cVkPtoTRYAm4Y/NIvyg==
X-Received: by 2002:a37:9ac2:: with SMTP id c185-v6mr19304201qke.162.1539027728282;
        Mon, 08 Oct 2018 12:42:08 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:f812:c27a:7560:4d6a])
        by smtp.googlemail.com with ESMTPSA id 76-v6sm13220644qkc.41.2018.10.08.12.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 12:42:07 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ALSA: hda/ca0132 - Fix microphone inconsistency issues
Date:   Mon,  8 Oct 2018 15:39:57 -0400
Message-Id: <1539027601-20910-2-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
References: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes microphone inconsistency issues by adding a delay to
each setup_defaults function. Without this, the microphone only works
intermittently.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b098504..12a3581 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7223,6 +7223,8 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
+	msleep(100);
+
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
@@ -7267,6 +7269,8 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
+	msleep(100);
+
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
@@ -7324,6 +7328,8 @@ static void ae5_setup_defaults(struct hda_codec *codec)
 	int num_fx;
 	int idx, i;
 
+	msleep(100);
+
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-- 
2.7.4

