Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38413C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5AB26CDF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="XfJEqwp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC5AB26CDF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeFZPLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:11:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeFZPLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=xxt2PMvioVLZIqxpkpaGujDUWjDlDwp5j2L96dmWiso=; b=XfJEqwp4OwE/
        ZGj6NiwUNWnrwy7woXG1aKMoXQQG3jfEMWkbi5V9JzpI0WwacM6494Ae1GKyPWfxHCT1uj2MueQdk
        JvVMl0xbQOOcRTG4dSfL+pgFJxSjckF41HnJnKhI74j0U5pXL00JsyegkaSo1iFXlpzWhO1d0IZYA
        KADw4=;
Received: from host109-146-194-33.range109-146.btcentralplus.com ([109.146.194.33] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fXpcS-0001Jl-IU; Tue, 26 Jun 2018 15:11:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1963E440070; Tue, 26 Jun 2018 16:11:00 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: qdsp6: q6routing: support dt based module loading" to the asoc tree
In-Reply-To:  <20180626092016.9296-10-srinivas.kandagatla@linaro.org>
Message-Id: <20180626151100.1963E440070@finisterre.ee.mobilebroadband>
Date:   Tue, 26 Jun 2018 16:11:00 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: qdsp6: q6routing: support dt based module loading

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

From f48bde4bfbcf434d6aef604c1c50d68b12a4bc45 Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Tue, 26 Jun 2018 10:20:13 +0100
Subject: [PATCH] ASoC: qdsp6: q6routing: support dt based module loading

This patch uses new compatible string to make DT based module loading work.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index 593f66b8622f..ab696bf8d1d3 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -993,9 +993,16 @@ static int q6pcm_routing_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id q6pcm_routing_device_id[] = {
+	{ .compatible = "qcom,q6adm-routing" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, q6pcm_routing_device_id);
+
 static struct platform_driver q6pcm_routing_platform_driver = {
 	.driver = {
 		.name = "q6routing",
+		.of_match_table = of_match_ptr(q6pcm_routing_device_id),
 	},
 	.probe = q6pcm_routing_probe,
 	.remove = q6pcm_routing_remove,
-- 
2.17.1

