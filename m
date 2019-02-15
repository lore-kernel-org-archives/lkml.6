Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F0AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79545206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197088;
	bh=gxK/Rro34MmhJMYfF/7NpBvTEiZzb3QIbfPgIdOq9AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PnjlHlgajpvkoT+DqwH9HRNx4G6qJ5euP94KabYmluCvDihBAJBXWzTHoPNCOpf2v
	 LQr0lHcX4z+YP2OIeHoxwunMD3gQVqnCxlCbqLD+t3cqEObJv5DUqUbh+9GWbSKqHn
	 HvVB3CxszY+Ohv89I2/dD04qwB/2lF4TbYS0CaNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406870AbfBOCSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:18:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:55448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392096AbfBOCPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:15:50 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 488A9206BA;
        Fri, 15 Feb 2019 02:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196949;
        bh=gxK/Rro34MmhJMYfF/7NpBvTEiZzb3QIbfPgIdOq9AA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xODiuG7PMwfwxs5j7GTcdb4oYIHbfA+NIFVklbUDt4NGkR/zEHBmVdL5g5gGFnc9F
         uU/lLh2BgxIhFi0sNlLcNBQ7gRx2ABhM11HyzYX8qUkFim2FM+c7qdZSA25gyGxLyv
         RlQxs3EcobwaaqsKtbM/YBdVgIVB5fB0rFJ6XzrM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rander Wang <rander.wang@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 02/16] ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field
Date:   Thu, 14 Feb 2019 21:15:32 -0500
Message-Id: <20190215021546.179605-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021546.179605-1-sashal@kernel.org>
References: <20190215021546.179605-1-sashal@kernel.org>
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
 sound/soc/intel/broadwell.c | 2 +-
 sound/soc/intel/haswell.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
index 0e550f14028f..4aba2286a5ab 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/broadwell.c
@@ -168,7 +168,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 		.stream_name = "Loopback",
 		.cpu_dai_name = "Loopback Pin",
 		.platform_name = "haswell-pcm-audio",
-		.dynamic = 0,
+		.dynamic = 1,
 		.codec_name = "snd-soc-dummy",
 		.codec_dai_name = "snd-soc-dummy-dai",
 		.trigger = {SND_SOC_DPCM_TRIGGER_POST, SND_SOC_DPCM_TRIGGER_POST},
diff --git a/sound/soc/intel/haswell.c b/sound/soc/intel/haswell.c
index 3981982674ac..0efd574d3770 100644
--- a/sound/soc/intel/haswell.c
+++ b/sound/soc/intel/haswell.c
@@ -146,7 +146,7 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
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

