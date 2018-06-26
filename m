Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573D8C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F280D26CDF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kbx/5FzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F280D26CDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751137AbeFZPLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:11:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49496 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750863AbeFZPLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9yHPPN6j/1fqrS4j5vtjWjzCVma0WTCT5SQwlMa5JrY=; b=kbx/5FzOBUeq
        ICTih7fge/3VseUu+e6xq1xbEZplialbAmCO8cEGEtxVaTMrFKFXBTZfCV5qjQQGuzKin7P7jsWDy
        ui8c8i+2NvVqS6b+D5O8DBt6g5F5mHm/HfeGUPmtaQMdLNiBOwOhq7RwU2gBVEk4WF3PYlSNLe7kA
        LVsRY=;
Received: from host109-146-194-33.range109-146.btcentralplus.com ([109.146.194.33] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXpcK-0001JN-NA; Tue, 26 Jun 2018 15:10:52 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2DE53440070; Tue, 26 Jun 2018 16:10:52 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6asm: remove unused struct q6asm member" to the asoc tree
In-Reply-To:  <20180626092016.9296-13-srinivas.kandagatla@linaro.org>
Message-Id: <20180626151052.2DE53440070@finisterre.ee.mobilebroadband>
Date:   Tue, 26 Jun 2018 16:10:52 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6asm: remove unused struct q6asm member

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

From f339155a4063cf3177bb38f6e83760951148e86b Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:16 +0100
Subject: [PATCH] ASoC: qdsp6: q6asm: remove unused struct q6asm member

pcmdev in struct q6asm seems be left over and unused, so just remove it.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index c4fd28f168d5..2b2c7233bb5f 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -174,7 +174,6 @@ struct q6asm {
 	struct device *dev;
 	struct q6core_svc_api_info ainfo;
 	wait_queue_head_t mem_wait;
-	struct platform_device *pcmdev;
 	spinlock_t slock;
 	struct audio_client *session[MAX_SESSIONS + 1];
 };
-- 
2.17.1

