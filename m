Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80729C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4914220818
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 07:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HJz7YfDQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oBN0+otP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4914220818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389377AbeKPRxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 12:53:32 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36742 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeKPRxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 12:53:31 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 970D6607EF; Fri, 16 Nov 2018 07:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542354138;
        bh=PKwOCpyVUgf2gi0v1K1HRwsQEfeFoBHrjB1CxZPLmSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HJz7YfDQViB0/7UZgZfDhQijcFMfqYstDLgk1xAAdPG6tcRGVIG8R8dcx4nrE5zr3
         NaWm1YW9jOhzfO3XxGzcOVfLx3wtxfCe26ePRZhiXgo87FM8OK8C7YyM2oxHR1Z/5w
         Ps7l7OHmzF2TSM7AU6a9NLYGgW8odr3b0IgqFHvU=
Received: from rohkumar-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3C202607DC;
        Fri, 16 Nov 2018 07:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542354137;
        bh=PKwOCpyVUgf2gi0v1K1HRwsQEfeFoBHrjB1CxZPLmSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oBN0+otPebVEY1xxIXKDrw4qzDPCy4PG5t2oZdwFfHAMdX9JXc+ykevH09Og034J7
         TgoRmpJ+84qbTZEN/c19fIeXnzi2EtXche8q88NBETtR7ZZZBDZhrF47lzNBpmYmT2
         RUB9MvISrECHho4naTK7+F6AshE72livm2L/KbtI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3C202607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
From:   Rohit kumar <rohitkr@codeaurora.org>
To:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
Cc:     Rohit kumar <rohitkr@codeaurora.org>
Subject: [PATCH 1/2] ASoC: sdm845: Update slot_width for Quaternary TDM port
Date:   Fri, 16 Nov 2018 13:11:57 +0530
Message-Id: <1542354118-23360-2-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
References: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change slot_width for quaternary TDM port to 16 and
update bclk rate for TDM and MI2S interfaces
accordingly.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/sdm845.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 8d0cdff..84e6ee7 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -13,7 +13,8 @@
 
 #define DEFAULT_SAMPLE_RATE_48K		48000
 #define DEFAULT_MCLK_RATE		24576000
-#define DEFAULT_BCLK_RATE		12288000
+#define TDM_BCLK_RATE		6144000
+#define MI2S_BCLK_RATE		1536000
 
 struct sdm845_snd_data {
 	struct snd_soc_card *card;
@@ -33,7 +34,7 @@ static int sdm845_tdm_snd_hw_params(struct snd_pcm_substream *substream,
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
-		slot_width = 32;
+		slot_width = 16;
 		break;
 	default:
 		dev_err(rtd->dev, "%s: invalid param format 0x%x\n",
@@ -115,7 +116,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 				DEFAULT_MCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_PRI_MI2S_IBIT,
-				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+				MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		snd_soc_dai_set_fmt(cpu_dai, fmt);
 		break;
@@ -125,7 +126,7 @@ static int sdm845_snd_startup(struct snd_pcm_substream *substream)
 		if (++(data->quat_tdm_clk_count) == 1) {
 			snd_soc_dai_set_sysclk(cpu_dai,
 				Q6AFE_LPASS_CLK_ID_QUAD_TDM_IBIT,
-				DEFAULT_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+				TDM_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		break;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

