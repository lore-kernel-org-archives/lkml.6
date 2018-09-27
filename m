Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB4AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AFB21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwCYsjEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8AFB21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeI0U01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:26:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43024 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbeI0U01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:26:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id q19-v6so2040848pgn.10;
        Thu, 27 Sep 2018 07:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wrVbKHx8U5uLLj1imAYO/Pu0eZL3Rt4//xeDHB+8AMo=;
        b=QwCYsjEWAwvNPYVaYB1GqPYit8cX2uzt7D/4pmeA2uPe+1Et9Hm+7CJqU2EjmEthi1
         njQmEoDOVrMs54oyQKUlH8Wn6vV2hL0TEKLJVubORkFpUMozsT9UGiuLR07Xt7heYgQt
         D+7XY5XY+7DNiRVjSgekP8SGWkS//9QHYt4oLfOJXG3INyobXP/XTAqmdax4iItRO1VN
         csEV6F+pH54N1Wh637hL348z0fKpnASci+3HC0b+5KvIe5Yusw3IhRtAeN+HushJnFgC
         6MW6nUB9JZr7FRaSbQAoDWa1u3Kvz55Oo8Ss+N//atczlKqEMCg7WXAdAoR4XhofujaC
         byLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wrVbKHx8U5uLLj1imAYO/Pu0eZL3Rt4//xeDHB+8AMo=;
        b=f6euBI8sgw3rUPmt4xWzDat0g5AQ+IhLK00s/geiJv1L5ONgjqsAyHAEmE16bJpGh3
         ujkM0bfttqaR/XOODS8ykLXnoQEwvy9QySaPEYJ8Dn8Q3czxaHxqywpTGzmNfj+Z+pZN
         PTZ20oeLdNbMWe4oTP9qkN3yo+qK9FZ1Z2KEihsW0/YYPXva4Fy93cNhndg2ejUVMmSw
         ql8937pFO6F3KtVkGTKiyqA5Qk6QP/jASbq4wZQrLVNpwQpqynYYukwD8MekDUK3SSAJ
         I5knCu4U7sLZK7btf0NO/jpB+V2g9h1/A2cqUMq7VqfvgxRkdgivH57FYnMscQctn3yQ
         EyeA==
X-Gm-Message-State: ABuFfoidOPxIfTUdbrwYLqit2H+YnRnRsNhXc84d84d+URxTwoK8HfLM
        w518IZQ6WTez7ILaz1z2fWc=
X-Google-Smtp-Source: ACcGV6308tDG272i7cTeDsS3LrbmWkPUu0B9DSPyvgUFkEuvYoXHEXL44Jiqlxe0T2QjDR5YO8Rz7w==
X-Received: by 2002:a17:902:ba95:: with SMTP id k21-v6mr11337575pls.38.1538057279735;
        Thu, 27 Sep 2018 07:07:59 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.185])
        by smtp.gmail.com with ESMTPSA id r205-v6sm4259763pgr.11.2018.09.27.07.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:07:59 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv5 1/6] ARM: dts: exynos: Added UHS-I bus speed support
Date:   Thu, 27 Sep 2018 14:07:33 +0000
Message-Id: <20180927140738.1006-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for UHS-I bus speed tuning for SDR50, DDR50 SDR104.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
---
[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376263.html
Changes from above.
Fix the subject and commit message.
drop sd-uhs-sdr12 and sd-uhs-sdr25 as host driver is not enable as of now.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2fac4baf1eb4..0508e6891f41 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -503,6 +503,9 @@
 	cap-sd-highspeed;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 };
 
 &nocp_mem0_0 {
-- 
2.17.1

