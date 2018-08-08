Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9587C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6122921781
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 17:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHWrMc/V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6122921781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbeHHTzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:55:53 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34488 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbeHHTzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:55:52 -0400
Received: by mail-io0-f173.google.com with SMTP id l7-v6so2524681ioj.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 10:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+REd3TOF5vrTnbb47ZfnclYJIG5eVJHq5gV0UJA2zSg=;
        b=MHWrMc/V9tYIeBmMkEbodn37gPLDqZ5Fb3/3KPTrsHCBn3G5THGYqAeceVOPVGemGD
         oVn4r994B7/3UXMYWe1iUHBo4FfOegJB03IAPMLrYiM1cizWh3Ru+Zm5NGytUcv0jXDz
         oXlAnC+Okz2TNL+EUZIOQy2tJhj2sh4pbK4Op0ajiqHpoOcgzhuHYoWd4qrtSpRQn0Xj
         4QkC0p8el8zfAUmVagNld929R0cZnos/RTFa00AdHvmjEe4kns6JRROK//sl4sQktVQf
         CVvPi79O4Ya+nVjHyfyFXgvcvyTy1TqTD5l3CJ+KElsW9zQzUVavZKcdiGvhxBhijxh3
         in2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+REd3TOF5vrTnbb47ZfnclYJIG5eVJHq5gV0UJA2zSg=;
        b=PzCouJjC5/+nmWKRB3jas0dSvwibEEh+7fy0H4oXH19QeQJZpEX/kgFyXDNfECh8DO
         58+HNQd9ya9CSCF8D/GP1eUfAbtw85DbA+TqMiaQyyr8DSuGrchUQ1zEn3jEgt/bQkto
         yysCLXRokM3IP90MfiJLzuocqlz7QgwLAwrngvPw/c9o8Ghxq2FxVObdbxC5La4KI/60
         tJNdLSMBqQsEY7D6UD+GJRvdjET6NK1x9FQl8YYNk3Chg8ob0TWdurTFZVDUfvxnLzCD
         WGr4g94hNQJ4s2F/BkYVI+P/Sp4fxv4c/a/AbqT9vCmiCpyJsIgcxQfBHOFZWnOWr7j8
         lcxg==
X-Gm-Message-State: AOUpUlH4Qlj60RJvYUBVRhUsJ8P8LHGRZcuThO03igmEw9M5vns6+4mY
        BHWJz8oQR49mMPzAzZS2TRE=
X-Google-Smtp-Source: AA+uWPzOmyZXsh/dV++3er6xWKmaYxhjnD93/7jTP7t8E6q1P71KjcJs70Onizlharp8fJg3r4kfeQ==
X-Received: by 2002:a6b:445:: with SMTP id 66-v6mr2983430ioe.50.1533749710879;
        Wed, 08 Aug 2018 10:35:10 -0700 (PDT)
Received: from localhost.localdomain ([2605:a000:1316:45c1:6d6b:de32:e032:aa21])
        by smtp.googlemail.com with ESMTPSA id d8-v6sm1977480itj.10.2018.08.08.10.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 08 Aug 2018 10:35:10 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     Connor McAdams <conmanx360@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Alastair Bridgewater <alastair.bridgewater@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] ALSA: hda/ca0132 - Add alt_functions unsolicited response
Date:   Wed,  8 Aug 2018 13:34:14 -0400
Message-Id: <1533749663-8200-4-git-send-email-conmanx360@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
References: <1533749663-8200-1-git-send-email-conmanx360@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a previous oversight where the microphone unsolicited
response would use the wrong input selection function.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index b3c2cae..e2e1d29 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -6745,7 +6745,12 @@ static void hp_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
 
 static void amic_callback(struct hda_codec *codec, struct hda_jack_callback *cb)
 {
-	ca0132_select_mic(codec);
+	struct ca0132_spec *spec = codec->spec;
+
+	if (spec->use_alt_functions)
+		ca0132_alt_select_in(codec);
+	else
+		ca0132_select_mic(codec);
 }
 
 static void ca0132_init_unsol(struct hda_codec *codec)
-- 
2.7.4

