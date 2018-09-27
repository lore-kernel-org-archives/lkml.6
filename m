Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390D9C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B6C21547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBM6gONP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B6C21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728120AbeI0U0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:26:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40080 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeI0U0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:26:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id n31-v6so2052036pgm.7;
        Thu, 27 Sep 2018 07:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dm5u6qPz+qiZpTpZ61emFhPT0rUFtszstfeRwzbhEkA=;
        b=sBM6gONPhL9orDFgpy61GZi2yX4j9GGmubWlmxzHwXXe5pMiya2SU6iCVMzZQmWJTi
         Avc6BKdyVXjAbOXjW6D8kasrqiraUEdloYZsWoKCT05/jfyqMJK5WO6n0eimV32ZIdjd
         0ApqMHGl5dqTonOcm5uqrCt4B3xhygwKGX0D6roJaBgmvUnQdpzFNLh4fmAN0JG2+GLD
         FfTcn6XEDJsfebxjRzD6Ud0a1RnHN8DD/l7ZAvT2y6/hjDc7rwIHblS9GmYVPT1GRM9K
         FQ7IAcOX+dSm0qZuzReEth/N1tYBbEfKk4Hls0izkj29bO3Sa+p5veGejSqiI7E6jv5o
         q4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dm5u6qPz+qiZpTpZ61emFhPT0rUFtszstfeRwzbhEkA=;
        b=VBVNhbYfvCrinHFibNYjhu/Kx4pGEw0W1hTlsBRApmncdJ5rIihKwpqHlrWvTXKPAt
         AFwtMPauXHEd8TkcbIKp68abrxHE7ZXui4bQcR2M5+URo71mSEsIUstJ9LnxE+Jg3udp
         k1AzLnkBVngmVIHUcR5s10FhWygzisD2jS+hyUY9JYQWwi8kwbBTKrE1Y2NtKASqqt5I
         XC11dIQBxG20bq8tUdbu0cm8J7edD6EpdFIsssVZwJAS0y/GQ3DISmDMcuRSdIt8/d/q
         kCU8HZD4YYnE2lfFPV6xLz/ih9K65K4ibk5/Dy/NNW4AUdRd1imgKMP1bbH8fRpLqeOA
         JRsA==
X-Gm-Message-State: ABuFfois5iSL5uHmCpGez23B4EV73vGfgR4xV8W8n2a/8sgjJcKuiAwd
        usbL346tz+YkY5w55hRIhbk=
X-Google-Smtp-Source: ACcGV60xno8+5LYUOszDggyYIlNC1emmONi3NNrF9QOKLg5S6gFR9Xteutvatv3s7kKnGmw1NWbcxg==
X-Received: by 2002:a63:4443:: with SMTP id t3-v6mr10517247pgk.102.1538057296243;
        Thu, 27 Sep 2018 07:08:16 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.185])
        by smtp.gmail.com with ESMTPSA id r205-v6sm4259763pgr.11.2018.09.27.07.08.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:08:15 -0700 (PDT)
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
Subject: [PATCHv5 5/6] ARM: dts: exynos: update maximum frequency for emmc to 200MHz
Date:   Thu, 27 Sep 2018 14:07:37 +0000
Message-Id: <20180927140738.1006-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the max-frequency to 200MHz for optimal performace of eMMC.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
eMMC

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
index e522edb2bb82..1f2d3987dde1 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -392,6 +392,7 @@
 	cap-mmc-highspeed;
 	mmc-hs200-1_8v;
 	mmc-hs400-1_8v;
+	max-frequency = <200000000>;
 	vmmc-supply = <&ldo18_reg>;
 	vqmmc-supply = <&ldo3_reg>;
 };
-- 
2.17.1

