Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC97C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F02421927
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 05:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMRnOqpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbfBHFAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 00:00:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42782 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfBHFAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 00:00:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id r15so1720656eds.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 21:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTcpChwmopYs8aEyjJhEMtiLIKLRzcFXiyjfHHM2XYU=;
        b=nMRnOqpc8wagCKJOHvkjrkHWpSt9WocYP4UoWP+xREBc8X7GOa5osbr53XZSEXM3cv
         fYHq2kj/3QWeWN3++oHPTtr/M5o1DWDdbBMKFvVjsjnsGLnSJusg3EpsilPYcE5liecL
         /IxWaHblGJawaIx2XGd0MlVvVCkF6SvTCiNNnoLTQAts9QucRIW8wEuxwlk84oIrdWue
         rpLnzZbRXSYzrPDRskiewi7xTR9MTHrxwoBIAEQdg0l8bm1YuS2eBsxaX+PhnWz0s3Zt
         a+YNj8C1q5nsb5SS5MgmnXEBZQ85aNQTzTODJgs/WZR7MWlaf2Mywh4DaXrec+8oOGs6
         zX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nTcpChwmopYs8aEyjJhEMtiLIKLRzcFXiyjfHHM2XYU=;
        b=VzU5yxn3qUMif5w7t24dJDASPvCix0ENX6BQaK+gufStjLTQtL71vsg+bzLZqacYBG
         qcc3fyAIHlVNZgk7twf1E+YOW35Fwz7dXgLWC8gwybmXMVnMyjwXLBc6bvvllLrlrhB8
         X1Vt/a5S+D/vI4SnX4b9z2CrBcauveceBxuPjURrrTRr44zIksLndj0KVDhmbbI1rHjv
         ZzUAPcV35vjgQGSz2MrXco+6k1KKmG7Mycs/o99D2pnNbO/tk4OneQ4Nd57FQ60oqmP5
         Jbk9BCUhO1LjC6dJEEr5ROHG2E7umeI3mzWAHgNgLX5GetQ0qU8ThVS3GlHNDn2sN3Pl
         RRtQ==
X-Gm-Message-State: AHQUAubAf03rJt/I+WogTwae4xHpbxDvH++9QKYKynd77jX+pENCfmqM
        SbuvGwO6+qUVAbaiZCN/4R8qYRpEd+B7Iw==
X-Google-Smtp-Source: AHgI3IaynJB2LtcYd7NxS+sMp+e63V9RHzZ4eR95qkekDWDlvbUdxQWnqAtzeuDv3zQ0bWTKy2voGQ==
X-Received: by 2002:a50:98a6:: with SMTP id j35mr15164991edb.141.1549602005401;
        Thu, 07 Feb 2019 21:00:05 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id v11sm332287edy.49.2019.02.07.21.00.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 21:00:04 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: codecs: jz4725b: Remove unnecessary const qualifier
Date:   Thu,  7 Feb 2019 21:59:18 -0700
Message-Id: <20190208045918.16799-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

sound/soc/codecs/jz4725b.c:177:14: warning: duplicate 'const' declaration specifier [-Wduplicate-decl-specifier]
static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
             ^
include/sound/soc.h:356:2: note: expanded from macro 'SOC_VALUE_ENUM_SINGLE_DECL'
        SOC_VALUE_ENUM_DOUBLE_DECL(name, xreg, xshift, xshift, xmask, xtexts, xvalues)
        ^
include/sound/soc.h:353:2: note: expanded from macro 'SOC_VALUE_ENUM_DOUBLE_DECL'
        const struct soc_enum name = SOC_VALUE_ENUM_DOUBLE(xreg, xshift_l, xshift_r, xmask, \
        ^

As it points out, SOC_VALUE_ENUM_DOUBLE_DECL has the const attribute in
its definition so remove it here.

Fixes: e9d97b05a80f ("ASoC: codecs: Add jz4725b-codec driver")
Link: https://github.com/ClangBuiltLinux/linux/issues/354
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/codecs/jz4725b.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index e3dba92f30bd..5cc8c7ca24c6 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -174,12 +174,12 @@ static const char * const jz4725b_codec_adc_src_texts[] = {
 	"Mic 1", "Mic 2", "Line In", "Mixer",
 };
 static const unsigned int jz4725b_codec_adc_src_values[] = { 0, 1, 2, 3, };
-static const SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
-					JZ4725B_CODEC_REG_CR3,
-					REG_CR3_INSEL_OFFSET,
-					REG_CR3_INSEL_MASK,
-					jz4725b_codec_adc_src_texts,
-					jz4725b_codec_adc_src_values);
+static SOC_VALUE_ENUM_SINGLE_DECL(jz4725b_codec_adc_src_enum,
+				  JZ4725B_CODEC_REG_CR3,
+				  REG_CR3_INSEL_OFFSET,
+				  REG_CR3_INSEL_MASK,
+				  jz4725b_codec_adc_src_texts,
+				  jz4725b_codec_adc_src_values);
 static const struct snd_kcontrol_new jz4725b_codec_adc_src_ctrl =
 			SOC_DAPM_ENUM("Route", jz4725b_codec_adc_src_enum);
 
-- 
2.20.1

