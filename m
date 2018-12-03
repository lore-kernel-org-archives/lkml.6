Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D31C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 030FD20851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="txGAbNmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030FD20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbeLCMID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:08:03 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56110 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeLCMID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:08:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=8j0z6XaYafNDsi2SOuDixCxN43HsTi9LdkrKEXWqhMk=; b=txGAbNmNUd2y
        X6XXA34EQSNUFTblJBxLKxU39rQuGKte9Rhu26JGzzhLKm4EUHf7GSfLnwA6ws+Zxj7hZWyDosy+p
        lz5pXsPV4mGbQ3fx4n8UO+j17tQpzg/1NmKIiWzxzmOHiud5dWdiXlLAwdZwmImop0RZfBqH2Pj5i
        rkpFo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gTn0K-0003T0-4E; Mon, 03 Dec 2018 12:07:12 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 92D33440080; Mon,  3 Dec 2018 12:07:11 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: dt-bindings: use a generic node name for rt5631" to the asoc tree
In-Reply-To:  <20181203114728.636936-1-lkundrak@v3.sk>
Message-Id: <20181203120711.92D33440080@finisterre.ee.mobilebroadband>
Date:   Mon,  3 Dec 2018 12:07:11 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: use a generic node name for rt5631

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

From 1286f930a0d7447748b398564d14e84ea5dfe890 Mon Sep 17 00:00:00 2001
From: Lubomir Rintel <lkundrak@v3.sk>
Date: Mon, 3 Dec 2018 12:47:28 +0100
Subject: [PATCH] ASoC: dt-bindings: use a generic node name for rt5631

The example should follow the practice or using a generic node name
instead of the precise programming model, as recommended by the DTSpec.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5631.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/rt5631.txt b/Documentation/devicetree/bindings/sound/rt5631.txt
index 92b986ca337b..56bc85232c49 100644
--- a/Documentation/devicetree/bindings/sound/rt5631.txt
+++ b/Documentation/devicetree/bindings/sound/rt5631.txt
@@ -35,14 +35,14 @@ Pins on the device (for linking into audio routes):
 
 Example:
 
-alc5631: alc5631@1a {
+alc5631: audio-codec@1a {
 	compatible = "realtek,alc5631";
 	reg = <0x1a>;
 };
 
 or
 
-rt5631: rt5631@1a {
+rt5631: audio-codec@1a {
 	compatible = "realtek,rt5631";
 	reg = <0x1a>;
 };
-- 
2.20.0.rc1

