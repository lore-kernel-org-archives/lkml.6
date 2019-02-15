Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A7FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7EF2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197736;
	bh=pvp2LsIA6B1Kk7/ZyNN4XdMCtvtLU1xjH+NwpCSu+48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAEzNOcfo3V7Jx+HjPwpYKfofIMg8ezkoRiJj15H/gXF5tJkHRAZ0eyDJW8ckA5OI
	 xzmGR7JoOiZHxoX6hUrtk6sob7KC2YsS1NGZHI0puKcK3z37g4p8tKKm4NwFO+UYV/
	 uvvp3JsYB8b6M/2MBvgb0KNbcuziSKqMazyy/Mss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbfBOC2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:28:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:53270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404619AbfBOCNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:13:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B69DD206BA;
        Fri, 15 Feb 2019 02:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196799;
        bh=pvp2LsIA6B1Kk7/ZyNN4XdMCtvtLU1xjH+NwpCSu+48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rq6NlOB1+HTnMywNOGwxq12V/5g02gxUTWT90LSAMFwt0yB0DF7Y1ITe/ZyIKFRTg
         8NeRPiB/+j+8imL8tlwM1L6WAmeY2yBz/qCkL6cYfezY74un7dZ5w+UEDxOBrwTzWZ
         GP4+wNa9TQT6LY2meDVYXzmei8YPeAbKZTVwOeRs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rander Wang <rander.wang@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 02/40] ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field
Date:   Thu, 14 Feb 2019 21:12:35 -0500
Message-Id: <20190215021313.178476-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021313.178476-1-sashal@kernel.org>
References: <20190215021313.178476-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@linux.intel.com>

[ Upstream commit 906a9abc5de73c383af518f5a806f4be2993a0c7 ]

For some reason this field was set to zero when all other drivers use
.dynamic = 1 for front-ends. This change was tested on Dell XPS13 and
has no impact with the existing legacy driver. The SOF driver also works
with this change which enables it to override the fixed topology.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/boards/broadwell.c | 2 +-
 sound/soc/intel/boards/haswell.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 6dcbbcefc25b..88c26ab7b027 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -191,7 +191,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.stream_name = "Loopback",
 		.cpu_dai_name = "Loopback Pin",
 		.platform_name = "haswell-pcm-audio",
-		.dynamic = 0,
+		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
index 5e1ea0371c90..8158409921e0 100644
--- a/sound/soc/intel/boards/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -145,7 +145,7 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 		.stream_name = "Loopback",
 		.cpu_dai_name = "Loopback Pin",
 		.platform_name = "haswell-pcm-audio",
-		.dynamic = 0,
+		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
-- 
2.19.1

