Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40692C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FF720892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791467;
	bh=KwA8NiXQRDJ3sBBao+LZ77qxpb2qnxOPsX8XlzTXEhI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=bZfV0Vy2sUhfRQ0uETcN8AXAHN0kHzOFUVNP+iiNdb5baaDMa1K0ZjW2nh3Wg5tk6
	 E0bkw7DoLJLxrjbNTa7p1NtZhX/h+5Y+eVcEgb+641LPDFRgXDedliwNjVZjbhs7zD
	 M/Bqj2UrNWY6v5jyc4MJBkDzd19pQRT02Uu+Ne9w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07FF720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbeLNMoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:44:25 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41146 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeLNMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:44:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZULwrPacP2Bl/vFtkr5WkLd2+mrM63aFfdcwKr6+rso=; b=vC2OQDVjC0TD
        scROHPIA3ej/R+kGQ5ygjNTEh6f4KFDnF8dp0+/kr4tczPU7NPw2OPXtlhgT4L9IzNSmAdQVaQvS2
        hXDboqMZEi6tw5baBP/9pVPKf054kYfjEgL/B4Sht2ulEifBtz7+OVq/fqCzNgbXUZo1ZHwbHwZNs
        WOzhk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXmpD-0006lA-GR; Fri, 14 Dec 2018 12:44:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2B4C011258A2; Fri, 14 Dec 2018 12:44:15 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, vkoul@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        tiwai@suse.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, rohitkr@codeaurora.org, srini@kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6asm: add support to MP3 format" to the asoc tree
In-Reply-To:  <20181115181324.26784-5-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Message-Id: <20181214124415.2B4C011258A2@debutante.sirena.org.uk>
Date:   Fri, 14 Dec 2018 12:44:15 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6asm: add support to MP3 format

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From f2e6c6aa0cb5f39e48627850680b87ec688070f8 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Thu, 15 Nov 2018 18:13:23 +0000
Subject: [PATCH] ASoC: qdsp6: q6asm: add support to MP3 format

This patch adds support to mp3 format in ASM module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index e1cfa846a1dc..4f85cb19a309 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -12,6 +12,7 @@
 #include <linux/kref.h>
 #include <linux/of.h>
 #include <uapi/sound/asound.h>
+#include <uapi/sound/compress_params.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -36,6 +37,7 @@
 #define ASM_PARAM_ID_ENCDEC_ENC_CFG_BLK_V2	0x00010DA3
 #define ASM_SESSION_CMD_RUN_V2			0x00010DAA
 #define ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2	0x00010DA5
+#define ASM_MEDIA_FMT_MP3			0x00010BE9
 #define ASM_DATA_CMD_WRITE_V2			0x00010DAB
 #define ASM_DATA_CMD_READ_V2			0x00010DAC
 #define ASM_SESSION_CMD_SUSPEND			0x00010DEC
@@ -868,6 +870,9 @@ int q6asm_open_write(struct audio_client *ac, uint32_t format,
 	open->postprocopo_id = ASM_NULL_POPP_TOPOLOGY;
 
 	switch (format) {
+	case SND_AUDIOCODEC_MP3:
+		open->dec_fmt_id = ASM_MEDIA_FMT_MP3;
+		break;
 	case FORMAT_LINEAR_PCM:
 		open->dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
 		break;
-- 
2.19.0.rc2

