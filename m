Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ACFC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F1EB20656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RPsmqt7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfAOImQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:42:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41500 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfAOImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:42:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so955442plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mhru6wLl9kz+UIAzkZRUNY2BQGrA9zV8yTyVy7573Rk=;
        b=RPsmqt7bbJK9BTMZ343ENC9MtLG6QzpzbduiTIY++f5Y598NVi2y2qUyXxqDyCtOlC
         sAlJT95csHRYrV9e3RMDxOmywqXyUkBkFUrLv1MAWmI7QUuB6h4RcCXWE0m22x4Thddd
         5fcoqeXPyekQD30EQ6p69iTh6W2h8j6LCCaNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Mhru6wLl9kz+UIAzkZRUNY2BQGrA9zV8yTyVy7573Rk=;
        b=CfK2QtEhnhfU4q1ha5Dsf8+wuOTuaQgKCAhHRwEXhblKrEeBFeTMc22RoWSOFyeaQV
         mBzwQILHJ9NBEQG1IeS5IW0zr0aIaaRpPUfe0U4FUN7uAUnBqCun9P9ROgWcnrueLYZ5
         34eDPC5nlNOUUPjwGCwrTubqJnBanSbncEV93/b4SNCRtSR/y9cFAXXHfPxk2v7khKSu
         N80F+vRn9mdR8EiJD8nKEt9IeusTePoYiEZpSxMg8NILGUw/kYkqcOuBw/zMOXou7LhT
         /9baEFBRpflyBz6Nmx35TyknoU0e3UIVfcjwFo/73wT0BBP1faW0J62zX3g5ekCwofVC
         B+lw==
X-Gm-Message-State: AJcUukcTAmo7k9wXUsiMkipcQqrANZw4HJuRhx9G+n8HwZ+fK5JxiOjI
        SA7+OQUj1cDkhGOb5HYuy53KyytbtYs=
X-Google-Smtp-Source: ALg8bN4Qc5pwrcW3UoJk7QIVDhTBpg3encsvGah7/VAqG22sJ5wee2OLUwAdzWQKAOTa6Vby0lG3ZA==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr2931685plr.15.1547541735057;
        Tue, 15 Jan 2019 00:42:15 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:d3e3:8b64:9238:2823])
        by smtp.gmail.com with ESMTPSA id w88sm5388037pfk.11.2019.01.15.00.42.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 00:42:13 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: sdm845: Set DAI format for dmic codec
Date:   Tue, 15 Jan 2019 16:41:59 +0800
Message-Id: <20190115084159.135113-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set codec DAI format for dmic codec in startup.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 6f66a58e23ca..882f52ed8231 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -248,12 +248,14 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		break;
 
 	case SECONDARY_MI2S_TX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
 		if (++(data->sec_mi2s_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
 				MI2S_BCLK_RATE,	SNDRV_PCM_STREAM_CAPTURE);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
 		break;
 
 	case QUATERNARY_TDM_RX_0:
-- 
2.20.1.97.g81188d93c3-goog

