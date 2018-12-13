Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF449C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D5720849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csGmEa0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D5720849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbeLMEgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:36:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37229 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbeLMEgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:36:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so945579wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 20:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDVi6ueEqLDxcXtda0yxNBgbEeJ7nCgRPmiJUJPQ+Ko=;
        b=csGmEa0j6+x2Xccji99Ik0ST6G4f58oGUDIYqsdqzK119bGHBF74DIVNpp82fUMBpQ
         wfkTN6G9DdBekhAopeH6W560C2pTm3DGv1o+jXnWfFrJzs2QaU6xsVsXijjbgpLdt+me
         9uidmDpovCkxlq/k0fWDKyAzLWUFDV+o/yWy7qt6FBHVUd0ndoVtImjn3woIsL3qxBDM
         kCA2G/WqAw2v9JZPdcR1dZolEUo0zjM29p4dUCTQc3AN3ZprhUsVu/R67SAebPSNwpZY
         TdPFLvkeE+9xNzmaysOOTjhE9L7ELSk815EO/XJWh1pReQrg0uuXlX60f/cshss2YifE
         0AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cDVi6ueEqLDxcXtda0yxNBgbEeJ7nCgRPmiJUJPQ+Ko=;
        b=WbCXnJckSZSTNCSEOy41l0QxVaq7vrGwxykHtItpM00V1MWoHfGBW/IF5/bin7ZV5w
         6yePXfoRuUtHU9YZxo6ddLA1jKo0qqN1IillSdjGR7suhgBg8XSlADeDzsxXHJsvOBL0
         2ANHO51tOjLZzFc+WObW36eOYw2ogtsLT2uAnjWJ0/WwLnuTlS+B2/uRwIL93U17BfCd
         S3M7cqauei6zbUhIJ7hI/XHcfUjrtunj9+/aodalFizsbCOmhf7+WeqUCoZvvtQgd8Bi
         +/ccrWYw9dmLGZDe47FcnKyr3QPrKSVotCFyat18R2UEWonpSQWYCAAZ4YcyttE8zbZI
         Z+Cg==
X-Gm-Message-State: AA+aEWZ+4kuXoAWbkyXQbvWMuvnEKSj+6gtVkcOtA+Pm1cMNtNJe0XLo
        lZE/Tt01tRJ9CQtoSimQ5MF35UR3
X-Google-Smtp-Source: AFSGD/UdYWzmZ5sXZEH8KUc+nx7k88QWwX2f3hBCDjkjrkwL/0ugz8lBripstufU3l9luIlWUy4Zrg==
X-Received: by 2002:a1c:70b:: with SMTP id 11mr9028447wmh.74.1544675760291;
        Wed, 12 Dec 2018 20:36:00 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id e17sm661759wri.36.2018.12.12.20.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 20:35:59 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: simple-card: Dereference pointer for memcpy sizeof in asoc_simple_card_probe
Date:   Wed, 12 Dec 2018 21:35:48 -0700
Message-Id: <20181213043548.29747-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

sound/soc/generic/simple-card.c:462:6: warning: argument to 'sizeof' in
'memcpy' call is the same pointer type 'struct asoc_simple_dai *' as the
source; expected 'struct asoc_simple_dai' or an explicit length
[-Wsizeof-pointer-memaccess]
                                        sizeof(priv->dai_props->cpu_dai));
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/generic/simple-card.c:464:6: warning: argument to 'sizeof' in
'memcpy' call is the same pointer type 'struct asoc_simple_dai *' as the
source; expected 'struct asoc_simple_dai' or an explicit length
[-Wsizeof-pointer-memaccess]
                                        sizeof(priv->dai_props->codec_dai));
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 warnings generated.

Commit 4fb7f4df49d3 ("ASoC: simple-card: use cpu/codec pointer on
simple_dai_props") updated {cpu,codec}_dai to be pointers in struct
simple_dai_props but didn't update these locations to dereference the
pointers to get the proper size of their contents.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/generic/simple-card.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 766123485d7c..d4738d3eb2f1 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -459,9 +459,9 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 		dai_link->dai_fmt	= cinfo->daifmt;
 		dai_link->init		= asoc_simple_card_dai_init;
 		memcpy(&priv->dai_props->cpu_dai, &cinfo->cpu_dai,
-					sizeof(priv->dai_props->cpu_dai));
+					sizeof(*priv->dai_props->cpu_dai));
 		memcpy(&priv->dai_props->codec_dai, &cinfo->codec_dai,
-					sizeof(priv->dai_props->codec_dai));
+					sizeof(*priv->dai_props->codec_dai));
 	}
 
 	snd_soc_card_set_drvdata(card, priv);
-- 
2.20.0

