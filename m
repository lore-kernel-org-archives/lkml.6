Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A664BECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592842150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="cq1a6K6y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592842150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733029AbeISXcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 19:32:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34252 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732300AbeISXcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 19:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=oY8rSpyHhTsrb/a4hc4FRe4lSn7x01apPEbPXA6usJ4=; b=cq1a6K6yY4aS
        A/egS2KVBQGt2YrsYFQ8AOB5ypEISwx+pptLtP6+e5NzRZ3TDtXRE9oIAjUEcicAYqFezEmaqar6/
        gdRSyRJH6cZz4c+d1O2+daeUyUq919NmqrEQZ5EPoZuYJUO+mhftka0x4W91XbLGRc4Iv84Zlfoe3
        OwElM=;
Received: from [209.121.128.187] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1g2gez-0004xt-1y; Wed, 19 Sep 2018 17:53:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 277CC440078; Wed, 19 Sep 2018 18:53:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     Mark Brown <broonie@kernel.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com,
        srinivas.kandagatla@linaro.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: q6afe: dt-bindings: Update input range for qcom,sd-lines" to the asoc tree
In-Reply-To:  <1537337481-2123-1-git-send-email-rohitkr@codeaurora.org>
Message-Id: <20180919175307.277CC440078@finisterre.ee.mobilebroadband>
Date:   Wed, 19 Sep 2018 18:53:07 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: q6afe: dt-bindings: Update input range for qcom,sd-lines

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

From 3a6818c771671c34b090244c92ab5aea6176d6da Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Wed, 19 Sep 2018 11:41:21 +0530
Subject: [PATCH] ASoC: q6afe: dt-bindings: Update input range for
 qcom,sd-lines

Input to qcom,sd-lines should be between 0 and 3 instead of
1 to 4 as 0 corresponds to BIT(0) which is MI2S_SD0 line.
Bit 1 to 3 corresponds to SD1 to SD3 lines respectively.
Updated documentation for the same.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/qcom,q6afe.txt   | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
index a8179409c194..d74888b9f1bb 100644
--- a/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
+++ b/Documentation/devicetree/bindings/sound/qcom,q6afe.txt
@@ -49,7 +49,7 @@ configuration of each dai. Must contain the following properties.
 	Usage: required for mi2s interface
 	Value type: <prop-encoded-array>
 	Definition: Must be list of serial data lines used by this dai.
-	should be one or more of the 1-4 sd lines.
+	should be one or more of the 0-3 sd lines.
 
  - qcom,tdm-sync-mode:
 	Usage: required for tdm interface
@@ -137,42 +137,42 @@ q6afe@4 {
 
 		prim-mi2s-rx@16 {
 			reg = <16>;
-			qcom,sd-lines = <1 3>;
+			qcom,sd-lines = <0 2>;
 		};
 
 		prim-mi2s-tx@17 {
 			reg = <17>;
-			qcom,sd-lines = <2>;
+			qcom,sd-lines = <1>;
 		};
 
 		sec-mi2s-rx@18 {
 			reg = <18>;
-			qcom,sd-lines = <1 4>;
+			qcom,sd-lines = <0 3>;
 		};
 
 		sec-mi2s-tx@19 {
 			reg = <19>;
-			qcom,sd-lines = <2>;
+			qcom,sd-lines = <1>;
 		};
 
 		tert-mi2s-rx@20 {
 			reg = <20>;
-			qcom,sd-lines = <2 4>;
+			qcom,sd-lines = <1 3>;
 		};
 
 		tert-mi2s-tx@21 {
 			reg = <21>;
-			qcom,sd-lines = <1>;
+			qcom,sd-lines = <0>;
 		};
 
 		quat-mi2s-rx@22 {
 			reg = <22>;
-			qcom,sd-lines = <1>;
+			qcom,sd-lines = <0>;
 		};
 
 		quat-mi2s-tx@23 {
 			reg = <23>;
-			qcom,sd-lines = <2>;
+			qcom,sd-lines = <1>;
 		};
 	};
 };
-- 
2.19.0

