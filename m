Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CD1ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD542150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHmux/k/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD542150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbeITXnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:43:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41389 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbeITXnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:43:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so4700646plr.8;
        Thu, 20 Sep 2018 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7ozPV58ZprJGFFho2v59oZM+irN0bDqxCFuUpPHJrUY=;
        b=ZHmux/k/8jxmv3+h2FLiUodfeb2AKDEFAEVRggaBpGB29zXoMr38Uvp11up9IE3rps
         6YRPC4UmSWYJIjYppG6i50HlimtIa9IRbzGX/SdzVBYns4k3GoObqNFEK2iIPeamQq+2
         UQhf3lajmTIJWDWiqYyhBeJk80kPEZ85EaxDyssw6v0d9N47J2aIq6/Qi5s+LHGP+b0z
         n0WszHK8VSJ/PBrDcfkr3L0Bksxp/19pw0VYov8t4Eyejy7G0+7bDPsMLQI3mU9zreBM
         xowcPtemqw8bRqVhKys4y3Zxsi3EOLgAWtx0UX5Pv6/6E2slz08eqbhk6xc6vaFby71P
         zkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7ozPV58ZprJGFFho2v59oZM+irN0bDqxCFuUpPHJrUY=;
        b=gCO9qrR3QXKOZpRktBr97MhLCAMPEj07zaDxcK0E9lm6Hcsh6LkswTBcUhROuDlmF7
         j/Xi5EXnpnaDd76cgtO8YF/FcwXXsBnkF3br4FTzYUpCwoSqyLVkmrY1QlK1YA0mzF0M
         7n6Qau39nbXJAyC2nzde9Bq4PuoQTbPWa1NgKgKgV45e6rXSC2wDfzhGmR0TkcFydlee
         pkP7gKMo2buPlmDMymwPP8jfkSZkGC3lRrpvjNpiEvo4Q+LDMMWpWv6X9M3X7y8Qvduh
         /dovzoYttMcGDSH1JQCq75Lwvy/ugxCfOW4JWkEWjCXqHfidDH4fGLCK/BIFkJbL1xGe
         RkQw==
X-Gm-Message-State: APzg51CGjf2QfbBA7rO0gmwKUzLRg4oNRvI6EFuzwdwCh4bZt3POUWEJ
        7me54a34E8vmUx5Id8ILi/rYNByG
X-Google-Smtp-Source: ANB0VdbN1hKuu5TfYkUXgbO1f9H3VAhd4Jj6Qkr2sqizS9bZAsKmV7Yap+THbBWhlTruoTpw5RB4GQ==
X-Received: by 2002:a17:902:a507:: with SMTP id s7-v6mr39595693plq.303.1537466347809;
        Thu, 20 Sep 2018 10:59:07 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.159])
        by smtp.gmail.com with ESMTPSA id n29-v6sm29963555pgl.30.2018.09.20.10.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:59:07 -0700 (PDT)
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
Subject: [PATCHv3 6/7] ARM: dts: exynos5422: update maximum frequency for emmc to 200MHz
Date:   Thu, 20 Sep 2018 17:58:25 +0000
Message-Id: <20180920175826.1284-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set the max-frequency to 200MHz for optimal performace of eMMC.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
This patch is new to this series.

MMC
root@odroid:~# sudo cat /sys/kernel/debug/mmc0/ios
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            7 (1.65 - 1.95 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    10 (mmc HS400)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index 96e281c0a118..5748f840becc 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -386,6 +386,7 @@
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
+	max-frequency = <200000000>;
 	vmmc-supply = <&ldo18_reg>;
 	vqmmc-supply = <&ldo3_reg>;
 };
-- 
2.17.1

