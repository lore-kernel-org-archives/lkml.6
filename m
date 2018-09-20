Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4B4ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7292150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzE2Q/TM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7292150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbeITXn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:43:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45112 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeITXn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:43:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id i26-v6so4715742pfo.12;
        Thu, 20 Sep 2018 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xZj4ehUhArcu1C3R0L0csXdj1nGlzB03lWOcBQ0Pwho=;
        b=DzE2Q/TMaSyc+t7iJHcpJabLOqy7DYsO8LnA/XraEkfpxr/yHD+k9my/kfjzij6kHk
         uxny4Zwg83E6NYR45MbpV5w4aabZdQ0+mnUcypeqTQVPYFSXquS+GMFti89wf3mCyZib
         SZJGPqaO8k7/4Evxh3qMklreUhjQ11g5XGhQAb4XAt7WhDbMyLDuOvjFyK7boB9Kx4N6
         WWH00KOzv0/N83mXYQxOpYvhF3Pqf24G62klQhiojGJ+rBOOAv/TUq9GwiyvUrCLOsyC
         m2E8+yj74uQvvsY89rsaa14PguafdvFh6/7qHBAlDZ0EQXHcDzqX4Zfs9UHDlia4aw/x
         1JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xZj4ehUhArcu1C3R0L0csXdj1nGlzB03lWOcBQ0Pwho=;
        b=affzV3pg7WehN4YcIlNqnV4Jm0P/mKKw9uwLOsr2V9YoYHiDkfSrdT+KOFzQ7vxCIC
         LY4agKrHvatkoEMO3vwQ1s29H1thrB98dz+YiAJUrKMcafxiHhKt0iasizZ9lgrwBK55
         dJjZMAjLv+fVADuS30aIHqLgbDh6RyZUdxYh9wY5UeSI2Id+xrvHYEP2W1sGpavgs4c7
         JMxT8xW+UMNg4fhw/LJA8VHmV/qEhpNdAheaaNjxQ1W7wovmrBEayrhizdPG6Zw+dqNB
         KYblmKB6qoqsTlnzgARZsgxbyyt0mYJoNrS553YmQR1+sEFa5KxCui0GBK+VMYkxfzZU
         GPcw==
X-Gm-Message-State: APzg51BNuQ5LEMSITqAQSRPDeaEpFyc6b0Hld5oWhBQ5ZfmGqTtlafqA
        XTNEpHCnVysWCETbRxDMVVo=
X-Google-Smtp-Source: ANB0Vdbg6/LS/J6rpF5pxinGS1aiA3dbytOpXMgLtepOAiV8GJ30AkhlB7s8v/PObNSEU6n8QtTKBA==
X-Received: by 2002:a62:6f87:: with SMTP id k129-v6mr42120570pfc.26.1537466327143;
        Thu, 20 Sep 2018 10:58:47 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.159])
        by smtp.gmail.com with ESMTPSA id n29-v6sm29963555pgl.30.2018.09.20.10.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:58:46 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv3 1/7] ARM: dts: exynos5422: Added UHS-I bus speed support
Date:   Thu, 20 Sep 2018 17:58:20 +0000
Message-Id: <20180920175826.1284-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for UHS-I bus speed tuning for SDR50, DDR50 SDR104.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376263.html
Changes from above.
Fix the subject and commit message.
drop sd-uhs-sdr12 and sd-uhs-sdr25 as host driver is not enable as of now
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2f4f40882dab..3a58c935c52a 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -370,6 +370,9 @@
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

