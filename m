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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0ECECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBFC21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpZYqV5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBFC21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbeITXnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:43:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45056 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeITXnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:43:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id j8-v6so4684988pll.12;
        Thu, 20 Sep 2018 10:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zC+SpiGvDffisRWF4lDh3IrlftlwiMtadKOftk7sQX0=;
        b=MpZYqV5r3gmwHip6ZIr1mWhg09ryIX98pmEl1hpeY5uHDtyw83hGNtWbAoXElt84R2
         GXlLjL/3/AU8iPedr87hkx0yNTxghp4MGtHXmaF1YTotM0u9ZNJnfFC4xxnVRkBhnOlA
         /IK5ISwk06vEAp0awpOazoLSSa2g00RK6Hu/v3EQ3pE+wPdgO4GS1591S5gfCkjRusHr
         epetFVpLU2166YKU4U1H1qMpp+auUGwKoJ8afZpa2MlKJgIEd5gd9v5nUYusaAUjQI9T
         urPyfnJcnMb1LGDSi3Pyggfr0uipKoXL0tcmGuCVtmI8geNKQyzx7vRdwkvMVYNoqvm6
         Dq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zC+SpiGvDffisRWF4lDh3IrlftlwiMtadKOftk7sQX0=;
        b=kuSY2G5WGlF4AXZP3sMqnEHpkrUePBeHrLXESdSZf5Qed6E7Sl/2NlOFka5zm+6NL0
         8MClCqE9TUpqI4Gp3KbwWEimCxWPnihLqkLKPT46s4LH4/mls4zbfhQSZZ1f0ajU0qE6
         9dYBC6gyk90nvQQpF7m6HxtPtER7bDKxp6+Gli9WD8tbt0wOtcvZUJcS44grvJJl/Rcj
         KnNHeXjkdevcv/gT4b9/5lCYIwHEi92n32fAZwQpjsnMN5W4dC++re5m4ePeLwUYe3qe
         F97f2qNPkQ1TN61vtf7ltRFiGYV3eD8BcmzELwbl51OY9+bzzLzN82PKE333aIkf5Nuv
         OgVg==
X-Gm-Message-State: APzg51DrsT1EcOygHZXKVHvX8hPYESWPZFqa8a63LqnSc48iBiA2oxvL
        cIYT5nh3ez9PbXN5XHX02LE=
X-Google-Smtp-Source: ANB0VdZvHXptXyhQemKjNhxbpN3FzN830lmnRAZm0LGN1IM3+XKDmHfMomwNUy+rHfSY1nhY+eJR+A==
X-Received: by 2002:a17:902:d688:: with SMTP id v8-v6mr4407976ply.79.1537466339653;
        Thu, 20 Sep 2018 10:58:59 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.159])
        by smtp.gmail.com with ESMTPSA id n29-v6sm29963555pgl.30.2018.09.20.10.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:58:59 -0700 (PDT)
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
Subject: [PATCHv3 4/7] ARM: dts: exynos5422: use cd-gpio method to detect sd-card
Date:   Thu, 20 Sep 2018 17:58:23 +0000
Message-Id: <20180920175826.1284-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the Card Detect GPIO property for sdcard detect, to fix
the warning message during boot time.
of_get_named_gpiod_flags: can't parse 'cp-gpios' property of node '/soc/mmc@12220000[0]'

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376261.html
Fixed the commit message.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 914ee08c7eb2..03fe02ceae66 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -369,6 +369,7 @@
 	bus-width = <4>;
 	cap-sd-highspeed;
 	max-frequency = <200000000>;
+	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
 	sd-uhs-sdr50;
-- 
2.17.1

