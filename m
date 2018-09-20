Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE03C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2B2150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qlKqqtzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB2B2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388047AbeITXnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:43:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46499 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeITXnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:43:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id b129-v6so4771327pga.13;
        Thu, 20 Sep 2018 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eWPgu7ZWUMLA4z1NAFc9hmsjM9hmq408YVjcnpIfOr0=;
        b=qlKqqtzRdsfr5WZWYDJ4MaPL+e9zgFsYTQGGZs9e0V3qSCQTrwst9r7RR7qcljSwl+
         jAcXnba+3zP3YtFD1JyMftraStIn5oNRWC1sd+x42bRQREYf56qVuWlBSx5ysgjxTusU
         a5MFv6GOFHy0oglllHEdhTknneU8eYz4Jfsz9To2jlV0RF1wnsD6souha6m0oith5p/o
         l+6ckmangIlgv7rg3J4PgJWaE0AAaZkAtoMG/y80VvY/M45Z9pfNpIginKXotJunPZRA
         c26eHoyohJefO1L+3+LHUjoOrbDIsjQ+Siw1SxBf9gZFdUt+GzhYBOP4cWd0digya0Wm
         OtkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eWPgu7ZWUMLA4z1NAFc9hmsjM9hmq408YVjcnpIfOr0=;
        b=UnFyVm1uHlga+M4GRGuRxhKtMIhyoDQnI3G1Y5ESS5jwrQMQieA61O6DGOKft38pmR
         FnwX5j6isrC75LVcAuGYOSCUQxJ3cFCCYwry49ecPGz8QfAX7n6jB8jTmkBkjnTAVQFP
         SkwvLItAlLhxLK185mu6bgJdB5z/obSpkx6RL/BZoVlueAuNDXjy3YamVUE8UUbGZ9LC
         dJVRJVg1bVyuV/mGlYK2odct2V44LqrLZswRDG4Z9Fn4bJjDOSDl1FWjtmmQSHA/mJ/T
         +PhFXP2VWkNEw+oc59O3ztcXzYAjivixMQEDGwQ8F703fs22W8nhPUmN945iWOGzEIyl
         QCUQ==
X-Gm-Message-State: APzg51Bg+rPuerPzCaA/ToiT10iP2VgJOzdMjUDGH6rsJEcUqTo0d6qy
        M2tGggvvVoG86g7Hq1vml2J+YSnw
X-Google-Smtp-Source: ANB0VdY+v35+SvzqbyIkzXhhUYVjb3kJUWTbJdZZzHTe/u0h4VD7xkeTBtmoT7ch/dDe7jMWxutpxQ==
X-Received: by 2002:a63:8c4:: with SMTP id 187-v6mr4659767pgi.396.1537466343713;
        Thu, 20 Sep 2018 10:59:03 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.159])
        by smtp.gmail.com with ESMTPSA id n29-v6sm29963555pgl.30.2018.09.20.10.58.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:59:03 -0700 (PDT)
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
Subject: [PATCHv3 5/7] ARM: dts: exynos5422: use wp-gpio method to detect sd-card
Date:   Thu, 20 Sep 2018 17:58:24 +0000
Message-Id: <20180920175826.1284-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add the Write Protect GPIO property for sdcard, to fix
the warning message during boot time.
of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/soc/mmc@12220000[0]'

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
New patch to this series.
If we keep the wp-gpio GPIO_ACTIVE_LOW sdcard boot into RO mode.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 03fe02ceae66..475c38bbc99e 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -370,6 +370,7 @@
 	cap-sd-highspeed;
 	max-frequency = <200000000>;
 	cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpc4 0 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
 	sd-uhs-sdr50;
-- 
2.17.1

