Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ED3C67839
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D1F2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 18:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="SyfUTFuc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6D1F2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=plaes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeLJSme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 13:42:34 -0500
Received: from plaes.org ([188.166.43.21]:55170 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbeLJSma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 13:42:30 -0500
Received: from localhost (unknown [213.204.46.240])
        by plaes.org (Postfix) with ESMTPSA id 287604195C;
        Mon, 10 Dec 2018 18:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1544467348; bh=rL1R6deG8R4m86FOSDKOCU7rxrxi6SE5YJnbhqg7w48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SyfUTFucZNxHfb6zdMH+nBz7AF5svNHDzNRiiTY4Sz9vRSBQlkK6da+gAnMUei6+B
         cllyP3Xlc1/FqQ48+2yGeUTubaVoVdaYtzN5pHc6tj0tBTxfMxpNjCnZ+C7OYihnSE
         1MT30MRD2wWYTG6V2ZItqx89sUyQ09VTCSUub/CneifpKrNKeAfkVs7fRts3UbsmdQ
         Cn1cLj+vKMJVoaJrEh9sKz+68FFZqTnPrg/oq26QqG4p9Q+VNGCrMv/qaugKH0jajz
         aNPGZPw3QAoNsOwCg5z1UR64LBDTgvia75OP4haDR2ryy7fSWN4cQ1kqIO77dnb7Uo
         dM37smIMKCmhw==
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Cc:     Priit Laes <plaes@plaes.org>
Subject: [PATCH 6/8] regulator: dts: enable soft-start and ramp delay for the OLinuXino Lime2
Date:   Mon, 10 Dec 2018 20:42:17 +0200
Message-Id: <b76e1964fee095164ed9313e9f57d4d4318c083f.1544466940.git-series.plaes@plaes.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
References: <cover.4110554ae84987dedb8b58888a8a63d6b7f98c72.1544466940.git-series.plaes@plaes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olliver Schinagl <oliver@schinagl.nl>

The OLinuXino Lime2 has a big capacitor on its LDO3 output. It is
actually too large, causing the PMIC to shutdown when toggling the LDO3.

By enabling soft-start and ramp delay we increase the time for the
capacitor to charge lowering the current drain on the power regulator.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
Signed-off-by: Priit Laes <plaes@plaes.org>
---
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 55c9086..4e1c590 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -232,6 +232,8 @@
 	regulator-min-microvolt = <2800000>;
 	regulator-max-microvolt = <2800000>;
 	regulator-name = "vddio-csi0";
+	regulator-soft-start;
+	regulator-ramp-delay = <1600>;
 };
 
 &reg_ldo4 {
-- 
git-series 0.9.1
