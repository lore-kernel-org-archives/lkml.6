Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DD6ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27E3920846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fALK6TmS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27E3920846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387937AbeGWHLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:11:03 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34319 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbeGWHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:11:03 -0400
Received: by mail-pl0-f66.google.com with SMTP id f6-v6so7805409plo.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 23:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xmVG/3H/SqHkjHCnVbBdoRYLrJINBOgTFoQQWr7Ye/E=;
        b=fALK6TmSm9Biy+erkbFPV0bEPlgrRaGAJyqDfjI5tXSGgdv7pzHXg22uS1eLAtHdOk
         MKG5BVwvZhZUCZFXoSU50TrzRizFlLEz1UulOsiEtPn/IMPMmrfWctopn40RV2mU04Tn
         OmRiHFnfchm4X+AO9+Wvz8MtzIXkseBSsKHRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=xmVG/3H/SqHkjHCnVbBdoRYLrJINBOgTFoQQWr7Ye/E=;
        b=uVI4TYNNNjICC7IxW4wY2KqWTs8J8yQe8WvReQTSow0YfoZm7SNHc2NE23RfNl0DdA
         jzCw0UbSYqOKzo8+S2Y1sZWn4u15eynmUWPHYP/juvicmIcvPpZmb6TQ1Jdt8FPWbamu
         Mg67g7KSmjZnhSkn2LiLkghcZirnXBqgYYXySL5vpMWc2op5Ykng9ZGsoNFhzw2ogpaa
         tDMiBJgfrw5bz0SKEbVPOupqHvafa4Hg6XWPE6xEMNf80aDvtuqg8qcZDO4ZmwaTjyOD
         eXZes339IKvfjYiD9ViRZFkGypNxPo7p9kNaxq7TzWmgxTcuNOOrTeqGPeqMUi5/b2X2
         5cog==
X-Gm-Message-State: AOUpUlEF6z8aKRkRGXZfyf6YOXtzR1d66+aiFkSvtvZHKGg5m88MiKiN
        P67Wheo0JIkUf8eiIzje9x/bWw==
X-Google-Smtp-Source: AAOMgpdOAyFFRykA3BL9ijfVgzU0kQnX1E19H1h3EjGQ3JjBPu7aOOB8WWqGUIKACfpCoEpFeUfF0w==
X-Received: by 2002:a17:902:b7c5:: with SMTP id v5-v6mr11806523plz.30.1532326289474;
        Sun, 22 Jul 2018 23:11:29 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 8-v6sm11972303pfk.132.2018.07.22.23.11.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 23:11:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, arnd@arndb.de, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Cc:     devicetree@vger.kernel.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, baolin.wang@linaro.org
Subject: [PATCH 4/5] arm64: dts: sprd: Add SC27XX ADC device
Date:   Mon, 23 Jul 2018 14:10:19 +0800
Message-Id: <1b98cf860c86f745a1efea21f39abb2ba4d5493f.1531881619.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
In-Reply-To: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
References: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Spreadtrum SC27XX PMICs ADC device node which contains 32 channels.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index fc68076..82bd642 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -65,6 +65,15 @@
 			hwlocks = <&hwlock 12>;
 		};
 
+		pmic_adc: adc@480 {
+			compatible = "sprd,sc27xx-adc", "sprd,sc2731-adc";
+			reg = <0x480>;
+			interrupt-parent = <&sc2731_pmic>;
+			interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+			#io-channel-cells = <1>;
+			hwlocks = <&hwlock 4>;
+		};
+
 		vibrator@ec8 {
 			compatible = "sprd,sc27xx-vibrator", "sprd,sc2731-vibrator";
 			reg = <0xec8>;
-- 
1.7.9.5

