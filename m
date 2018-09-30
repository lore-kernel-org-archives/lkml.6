Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB762C64EAD
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F39020685
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 03:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO1ieLzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F39020685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeI3JfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:35:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35366 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbeI3JfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:35:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id z14-v6so10729488qtn.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 20:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u6RZH27/jf0EO44rH2HKy2p09lZ0ofckinqTBL+leLA=;
        b=gO1ieLzQcMAJEGmsynEDiAuos7xq3x7ZGT13twPozsYqbB0XQ0kJz9mR7ta2f5d3a7
         cN+Ytel+5bo9QXrImrgCL/a9RJxTyfB3IiT1xy16Qx4jybcQ+PLsOzp8hguUVlEaq4Fu
         Z65ZUf/nVfx5abhhRaLm3PyXwfioHewlTdjUX6r9hMMvxkPwwN+No3SgLTtmi9aZsJKJ
         o/Fu01KU7pe1W64hEzb5vV7jW1FeyYcCafQB0G9OtyNdEo3L0adIQ1Twk8AGXyWsh2Eo
         44/ZR9YJkyEusz1dZwJyfPrjRNrq8WmtEttQWamupcsbd+c9L2mdmuNOEeQZNCuzUxbH
         TTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u6RZH27/jf0EO44rH2HKy2p09lZ0ofckinqTBL+leLA=;
        b=o/aVqDQnOLIWeRxbaPSK+/eBe/DlYw2Ki8VFd9iDAsa//TnWBQkOOksDMH8fj0qQrA
         Vij1Zc5Df6CbqOzEI+Hmm9b/ALBKIBjwKKQ1UlMkfuP5gA0gAujPIRnEKmiR6IgBTkuP
         I1jvNu4X16NSVIuTParRRPPVY4Ag940ny5Bagw8dLM733k3sFnP+b+t5M+SMTaKdQvgs
         Wc9KHBtS5RznNLR+dWBtRMyVuNBsAL5um2WYeSzBjY044WWPA/4/RIONNcD2RzC44dsX
         sCzxlWkzdB1zi6vuk2rEWRftHiVs5tLdZFzaF3KlpKLChCMywZR8ZB0p4ZXnUPrzMhW9
         GNlA==
X-Gm-Message-State: ABuFfogQBkiQ+VCrN0Jk4a1ahMzG/J5E1r6kUk1VZZqIgbyzFr4ISFxq
        5sBX9Gi7/T6QHEHkuwEZZY8=
X-Google-Smtp-Source: ACcGV63nYb6QnOGcr1auL1t2AVXJJIJ8yPvr8n3FoMN8Qo7ZAf+lzbOLK+3iQuoWnFqqUPn04hli/g==
X-Received: by 2002:ac8:21cd:: with SMTP id 13-v6mr4115833qtz.171.1538276645335;
        Sat, 29 Sep 2018 20:04:05 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:6520:8440:55b8:a001])
        by smtp.googlemail.com with ESMTPSA id p1-v6sm4782028qkg.82.2018.09.29.20.04.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Sep 2018 20:04:04 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] ALSA: hda/ca0132 - Fix AE-5 control type
Date:   Sat, 29 Sep 2018 23:03:16 -0400
Message-Id: <1538276607-30234-2-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
References: <1538276607-30234-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the control type of the additional AE-5 controls
added in a previous patch from HDA_INPUT to HDA_OUTPUT.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 225aa05..aebc592 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6109,7 +6109,7 @@ static int ae5_add_headphone_gain_enum(struct hda_codec *codec)
 {
 	struct snd_kcontrol_new knew =
 		HDA_CODEC_MUTE_MONO("AE-5: Headphone Gain",
-				    AE5_HEADPHONE_GAIN_ENUM, 1, 0, HDA_INPUT);
+				    AE5_HEADPHONE_GAIN_ENUM, 1, 0, HDA_OUTPUT);
 	knew.info = ae5_headphone_gain_info;
 	knew.get = ae5_headphone_gain_get;
 	knew.put = ae5_headphone_gain_put;
@@ -6126,7 +6126,7 @@ static int ae5_add_sound_filter_enum(struct hda_codec *codec)
 {
 	struct snd_kcontrol_new knew =
 		HDA_CODEC_MUTE_MONO("AE-5: Sound Filter",
-				    AE5_SOUND_FILTER_ENUM, 1, 0, HDA_INPUT);
+				    AE5_SOUND_FILTER_ENUM, 1, 0, HDA_OUTPUT);
 	knew.info = ae5_sound_filter_info;
 	knew.get = ae5_sound_filter_get;
 	knew.put = ae5_sound_filter_put;
-- 
2.7.4

