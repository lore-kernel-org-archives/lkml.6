Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B34BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B43E20643
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197412;
	bh=CEKvv2oOEH3I/qiwezyNWnZ4+LoTBXILI8Go9SMP6bI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pMaMlQTQdebtyTPMi+hDQ9CM6n/m4L/QCgUzE4RVm1X+lDZmK47i8WBd2+Qmaymse
	 Yi1vmAhEcY4zCtkTZvPlsYib+EwSWI5PTDb3Nr8dSM7fusabAATtjSFHN6MRmDNi0u
	 m0uO54szZ96E/1TF2wjOtuK23Qr9XtQKmno8QOBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733221AbfBOCXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391781AbfBOCOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:14:31 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5A7720643;
        Fri, 15 Feb 2019 02:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196870;
        bh=CEKvv2oOEH3I/qiwezyNWnZ4+LoTBXILI8Go9SMP6bI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T1Vjoj/lQ84yyA8FmHk15MRs0xWCrw9RgKcEAApU2VMxVZzAib2sg30D0MU6KMGWI
         yW5/L0q5tjOyaNvfdsiT2IikCF4fNjCMG04idFuqDO3zA4HcsE6E6KyUEI3pKpQbBs
         RCsB2Ef/t+Fbn2QQz+Ua5wZy+/33dFCARr/yFBgw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rander Wang <rander.wang@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 02/27] ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field
Date:   Thu, 14 Feb 2019 21:13:59 -0500
Message-Id: <20190215021424.178979-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021424.178979-1-sashal@kernel.org>
References: <20190215021424.178979-1-sashal@kernel.org>
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
index 7486a0022fde..993d2c105ae1 100644
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
index 863f1d5e2a2c..11d0cc2b0e39 100644
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

