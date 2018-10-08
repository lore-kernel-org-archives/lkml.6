Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C32FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BD32089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcmF0HDA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BD32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbeJICzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:55:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44070 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbeJICzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:55:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id c56-v6so22207712qtd.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0JwxPgmn1m2jNF4k3qwNhh2a8MXZ5t0XCYEwY3serqg=;
        b=NcmF0HDAKYlvTAfPgnn9pgyM2HOX3yppKjryu2S9TrTFzkOL7MTQ3s4cHhXGBhd8On
         leZYAkVdMIVgN8sMwiTq1skdO2nr4qiU19CMDcGQqMp1mX/6CIkAJn1fPi4V3qib3vxu
         jyijuZ9Yz7DwzSi3lC/Vr7d643wKOvYzawdBkN5mWEwRbMXt3byK7sEGF/vV+091E5no
         5eLtPn65lIfRG5dLU0HfR4AAMoNwv5QrhTTEu5Y0NYguSsPUr/6PH6nCZKH5U5+Dzagq
         DiGGYjz57OtLguJDwiI4bzQRcuCATOKt612Q16FHXDoIkbeW30ak48eYV0QquwJ027no
         JoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0JwxPgmn1m2jNF4k3qwNhh2a8MXZ5t0XCYEwY3serqg=;
        b=HJNF1pmvm8dFfzF8b//hM99pfdOlzrBHemdBGCsQAEMIIHU8qo/cv/lqtrEYUk4Jr5
         NWILWBVf8MMaEt/JL/55s261omvbGELqVYgpTB5J/vYbPZomjUdEpythvP5LhyXnS7Iz
         B2ZlADtomWpg2wiYicmrREWDpUga9PCTkONJ9/C6j39uEWtPDsPqPyX0wxJSUHLFMtF/
         qZOMoYLRvbQ9nBYle6o9QK7KuVppv5Z4lEMzHG8CertORoEw8uez7Qo4C4H1jwvj49ex
         zmNJi3COn/wM9Hgm1WJHftAynxHT/WRD7M8WEikyjlms45YaqKh/ikz41nxqvEfR0wb+
         bQJA==
X-Gm-Message-State: ABuFfoh5vGCecphrTbzR2wLAAHY3NFr9fPrBGBwjdBeYqhkjvq68S7z0
        +vWypFAktNtahrH6MNnuL9c=
X-Google-Smtp-Source: ACcGV63SYOr1xjYxnJYgcSx59rIxB6G4mJXjKHb5ZVZyxmywPXvjDlh1HfW81msE9DYNoQHrme40mA==
X-Received: by 2002:ad4:42d0:: with SMTP id f16mr2969024qvr.54.1539027734933;
        Mon, 08 Oct 2018 12:42:14 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:f812:c27a:7560:4d6a])
        by smtp.googlemail.com with ESMTPSA id 76-v6sm13220644qkc.41.2018.10.08.12.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Oct 2018 12:42:14 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ALSA: hda/ca0132 - Fix input effect controls for desktop cards
Date:   Mon,  8 Oct 2018 15:40:00 -0400
Message-Id: <1539027601-20910-5-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
References: <1539027601-20910-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the echo cancellation control for desktop cards, and
makes use of the special 0x47 SCP command for noise reduction.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 693b063..1a13cea 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -4857,7 +4857,7 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 			val = 0;
 
 		/* If Voice Focus on SBZ, set to two channel. */
-		if ((nid == VOICE_FOCUS) && (spec->quirk == QUIRK_SBZ)
+		if ((nid == VOICE_FOCUS) && (spec->use_pci_mmio)
 				&& (spec->cur_mic_type != REAR_LINE_IN)) {
 			if (spec->effects_switch[CRYSTAL_VOICE -
 						 EFFECT_START_NID]) {
@@ -4876,7 +4876,7 @@ static int ca0132_effects_set(struct hda_codec *codec, hda_nid_t nid, long val)
 		 * For SBZ noise reduction, there's an extra command
 		 * to module ID 0x47. No clue why.
 		 */
-		if ((nid == NOISE_REDUCTION) && (spec->quirk == QUIRK_SBZ)
+		if ((nid == NOISE_REDUCTION) && (spec->use_pci_mmio)
 				&& (spec->cur_mic_type != REAR_LINE_IN)) {
 			if (spec->effects_switch[CRYSTAL_VOICE -
 						 EFFECT_START_NID]) {
@@ -6374,8 +6374,8 @@ static int ca0132_build_controls(struct hda_codec *codec)
 	 */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT;
 	for (i = 0; i < num_fx; i++) {
-		/* SBZ and R3D break if Echo Cancellation is used. */
-		if (spec->quirk == QUIRK_SBZ || spec->quirk == QUIRK_R3D) {
+		/* Desktop cards break if Echo Cancellation is used. */
+		if (spec->use_pci_mmio) {
 			if (i == (ECHO_CANCELLATION - IN_EFFECT_START_NID +
 						OUT_EFFECTS_COUNT))
 				continue;
-- 
2.7.4

