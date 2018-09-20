Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D35C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B6D21525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eSYp4a0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B6D21525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387939AbeITXnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:43:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41178 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbeITXnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:43:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so4725525pfk.8;
        Thu, 20 Sep 2018 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UAU6/eXRgeoTQS4Qea6/w2qCMQGE0r04ho42F6TDaD4=;
        b=eSYp4a0BRd89wHMMVhmivDgVDjmU2BomwtXYwdfzosttk/T1Tp2EyiDJaNzCWMDKyz
         fwqyj1fUor63z4FRMkDabtd6BCz4UoX48it50Zkf35NFEPHvlc17DU8uCDNa4bObJpWZ
         bx9KpjV3ndl7IDIoQddST6LiCXZNlKEyyNy33euK1gtWE3pHyLJzepIbdglxSIYSZMKm
         I5tNNeE9Lfdw62eadaIXNytMvOB66cp7d3Gw/S1pVy1mp91xHpSKmGKAZoMJpt5AWTXT
         62lx1Jlz3y9XzfyPe3h6VH70bSGIvqoks6hbO0vwV5bXc1BwL2J/3wTHvCbyJUm3iGGY
         yrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UAU6/eXRgeoTQS4Qea6/w2qCMQGE0r04ho42F6TDaD4=;
        b=FF9oNm5zVptsSuwmZjzdfHnx+C9Q4KEKZBIfK+q4/kKJF60UF49I/jquqeOgubSiS0
         +HrqmfIaQ1b1JszPEQsACItrNkk9IrwwwCoIdWOCQs3ZXIEOrsYyD5q404RKCu6028wv
         whPgzLyd+sJTMYd9dICYtd7iiavfHB5lSUV+kGxx7WsmMW5c31GSZ1D6tcgshjyge+Qt
         dkl1UrSZDfYR3DiJpAQWswkGcsJPsUr070JlOxzKPYFVZb6QaJQbLJztDSSQCBgTg/Rk
         P1+7K+Oi4//m1eg9I5jT/RRJmbrSoIwuLor6jniTQGDkt8cG5au+5+TNRT5+0GIXe749
         sm4w==
X-Gm-Message-State: APzg51CWt+qBPsJdCJKF2voDKcZsIJa7esZ18fGhGkLhS0yNZUBJW4xW
        aY1Qkp0V6snQ1m7RrYwGUxU=
X-Google-Smtp-Source: ANB0VdZztPGEWLGcOXQk2HjMA+mhqBzhmRBK/DkBhBXt8eeTQURPRvca839jtyYrwq3qPImWw2eOhQ==
X-Received: by 2002:a63:5815:: with SMTP id m21-v6mr37815588pgb.78.1537466335578;
        Thu, 20 Sep 2018 10:58:55 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.159])
        by smtp.gmail.com with ESMTPSA id n29-v6sm29963555pgl.30.2018.09.20.10.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:58:55 -0700 (PDT)
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
Subject: [PATCHv3 3/7] ARM: dts: exynos5422: update maximum frequency for sdcard to 200MHz
Date:   Thu, 20 Sep 2018 17:58:22 +0000
Message-Id: <20180920175826.1284-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180920175826.1284-1-linux.amoon@gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
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
index 01593f4537ae..914ee08c7eb2 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -368,6 +368,7 @@
 	pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus1 &sd2_bus4>;
 	bus-width = <4>;
 	cap-sd-highspeed;
+	max-frequency = <200000000>;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
 	sd-uhs-sdr50;
-- 
2.17.1

