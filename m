Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED51C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E1621547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWJkiNPI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63E1621547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeI0U0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:26:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33537 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0U0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:26:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id y18-v6so2079749pge.0;
        Thu, 27 Sep 2018 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQiZIpqZCyb/15muQvEVGtCrC8IrAFJLh0dOxMdHDi4=;
        b=TWJkiNPIcvF+iZmOsYy7LgSu59ve/bJggHpR1qWrCWiZh+7kxr9Xzv6lXavVlfmRhK
         GnaYjRUHtsS9LYwxe9ZfjCjIU08RvY8cXOZ6bBueXflaKyselv6jznbsKcKrVmlLt2uC
         NlZ4RSJFaalHvYTCJV/ua8y41ODbJhD7aebqcb/nRlBOXvuBBbeMkn7AQoe1v6w/kPKp
         KDrGN4WBt3zfop229aPkN5IKhbDbYND4Rnhe9t/OIv7Neh1Z6QBCTxz1+z0/VH2M1Pgv
         SP71SxVNp68mGiEJK1nFU74pjWG8UCMBRIBdqAzT/WZxLMIYkYhfC20/YG8HdPuzEac+
         cPMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQiZIpqZCyb/15muQvEVGtCrC8IrAFJLh0dOxMdHDi4=;
        b=bArefd/dS2vkcj7EJ2MuZg8pp2m/LJeFZe2eibNr0kmc4/EAoimEhgS7FNp7T7Lyro
         4WcujtWb1tFXF+0OUEajAnbAavCr+hGZgHQzDDAD1rfAfasaCwHH5gBFGpJJt0i8vGKj
         CNkNYxbDzockH4FOR3seYDVOvBAknywXr4jU2VmSrij/zgUZi8EDtjsFo+JFmTOp2CYC
         R9hQsl9cHKhgi4uaTyQCV/X/wUs0b2J0R8NS1e+1r2tPjVIHTi9PnhnFFyZGrNJ8fZ2E
         ih821Tm97eqfQvCvslY1UQ50vn3/D6AJC4HvBs/UomIg/kN1bSedQiQALI33k9TNaG2a
         KQww==
X-Gm-Message-State: ABuFfogD129sRcsDlsmSR+UKj01N9l9G/yKf8/c1oqJ2ZysR28YKUaAL
        CaBIni94TmZ23Dj20HhVeoM=
X-Google-Smtp-Source: ACcGV61U8abH1BkEwcKrByEWrKv30JnmNWRrWkP67tNOC4bZ0hFYwYgpZJzub4cP65oTefpLnlerFg==
X-Received: by 2002:a62:5543:: with SMTP id j64-v6mr11564373pfb.188.1538057288132;
        Thu, 27 Sep 2018 07:08:08 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.185])
        by smtp.gmail.com with ESMTPSA id r205-v6sm4259763pgr.11.2018.09.27.07.08.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:08:07 -0700 (PDT)
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
Subject: [PATCHv5 3/6] ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
Date:   Thu, 27 Sep 2018 14:07:35 +0000
Message-Id: <20180927140738.1006-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set the max-frequency to 200MHz for optimal performace.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
This patch is new to this series.

microSD card.
root@odroid:~# sudo cat /sys/kernel/debug/mmc1/ios
clock:          200000000 Hz
actual clock:   200000000 Hz
vdd:            16 (2.8 ~ 2.9 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      2 (4 bits)
timing spec:    6 (sd uhs SDR104)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 15ab380e5fcf..a80b6c045154 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -501,6 +501,7 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	max-frequency = <200000000>;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
 	sd-uhs-sdr50;
-- 
2.17.1

