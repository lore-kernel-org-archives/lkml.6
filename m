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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8425AC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CFA2150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii/zoK+d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CFA2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbeISAIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:08:22 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42038 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeISAIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:08:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id g13-v6so1578971qki.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 11:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zRn06kbT8q3Tf1HvriDrhmv9JTsI4Ym8MxflvOoI6ME=;
        b=ii/zoK+dtY6/RYUgmBFffkOVeGSKLb09K1tMSut0CliLv4i9f1BjoGjKIEDPh3BABx
         /fPUQcM0WV8nG2tnWYqPBoRRTwbWodtMVhtlLMH6XhdzTp02vmTvp+BUGbTNGFZ4mjas
         +jlW4PTaisnk5O3c1TADkd2dwNbhCHWR4wS1tneQY75vryK/FHkQDzWCZ6CTH3vLrQ6B
         FgnnvFLebtYSEKr5PvzVBrYRrIG0pHuVyf2a5Pq6LNU8OSmV+rsGbaRnpZ1LSMFzl8Fy
         Qf3j+clNtdrV46XQBfFUFjwuLeVrplsrV2a0n/sbtNEyWNVYsIYAKGKFTduH5tuoaogJ
         0JxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zRn06kbT8q3Tf1HvriDrhmv9JTsI4Ym8MxflvOoI6ME=;
        b=mAXKKn77nqbP0uq8wYsrwF0HPpS3zF/hZS71fDVYqULCd4FIjvB3P52TvJWtKQXf7g
         tsiIs+0KjSlzXcmYlpuHHOvAhuQ6fG0ah/NgSfKiCl8Nf5JSnrejChveGi95eF1+OM/K
         3iHCc78dXTcFZZDgZGUYZaUbaewX875rrogOG7MROBOYzC+4Dqkbvt897FUjp9YJeTqQ
         fZj4k0315Dqj8jDECF/JrvrEr+njGK4fwzwxAwlaFAnVeU7nXK/H5XTKoWfomJsWP4CV
         CwZs7T+s63uMQdCyd4aeB+lO0kFP1uoZYMvstSMGIHC8QdEEH3kNq9aC4tf3aqzQJRUs
         +PhA==
X-Gm-Message-State: APzg51AtOw8c73MsLf5FWKWe7DuWWoSMVsbCOmRdQN9cGuPrWMY+99rB
        dwclG3gPdZqF9WVwe6uB72w=
X-Google-Smtp-Source: ANB0VdbrXfa+h8exmz6P5ZNtDuMxP+TDS57XQXFO93/i8+6AlIuRwp542aQvQu/ckLf19JLzPKejDA==
X-Received: by 2002:a37:cf48:: with SMTP id e69-v6mr21738925qkj.293.1537295669945;
        Tue, 18 Sep 2018 11:34:29 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:4273:719d:df26:b0cf:931a])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm13819101qki.1.2018.09.18.11.34.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 11:34:29 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] ALSA: hda/ca0132 - Add quirk for Sound BlasterX AE-5
Date:   Tue, 18 Sep 2018 14:33:30 -0400
Message-Id: <1537295625-8082-3-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
References: <1537295625-8082-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the PCI subsys ID quirk for the Sound BlasterX AE-5.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index cd93c86..81bbec1 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1009,6 +1009,7 @@ enum {
 	QUIRK_SBZ,
 	QUIRK_R3DI,
 	QUIRK_R3D,
+	QUIRK_AE5,
 };
 
 static const struct hda_pintbl alienware_pincfgs[] = {
@@ -1081,6 +1082,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA036, "Gigabyte GA-Z170X-Gaming 7", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1102, 0x0013, "Recon3D", QUIRK_R3D),
+	SND_PCI_QUIRK(0x1102, 0x0051, "Sound Blaster AE-5", QUIRK_AE5),
 	{}
 };
 
-- 
2.7.4

