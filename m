Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC6FC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CB12154F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHX8GIrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31CB12154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeIVNp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:45:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38419 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVNp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:45:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so1919305pgr.5;
        Sat, 22 Sep 2018 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dm5u6qPz+qiZpTpZ61emFhPT0rUFtszstfeRwzbhEkA=;
        b=ZHX8GIrwwc8Zp+n6qr9Vgu7L7GqSLWLKvMfjGswpNzh8Q1YX3BM/uNaDdsFgLzU3ru
         djRa5qErc0caE/RJOt20EE4JY4JgKwKwBp6oZ0Uv6ZLj+nhX4UzU3ahqxMH98fdnpYHW
         TcUZPaXIHLKJhqmFi5AAeR/ZQ68xxE24DdZYwVxuI/8S6qv5ki/Vg4DrkFFHF07s72/n
         IHJq711IFaNxao9jfIk68PLPmjRyXzON6mktws8eu23HwxsMgugaHsdyPmPaYn77cjKR
         CswkrgU187APPsRk7nVF0m8GZoFtmbdEKEqECrIQlIK2oJHpO2ARKOXQMZx15Gsxj+Qg
         rZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dm5u6qPz+qiZpTpZ61emFhPT0rUFtszstfeRwzbhEkA=;
        b=deoL8aK6f88nFqYN28MuVkHLx3J3HJWLMaKYZuWD4P6YCBzFi4xweAwfpMGPzLXEkS
         VLiwlMkl0lBjJ8Kze86lgow3Ftb5SXOGX/FJvRPN69ikdkcntCeh20blbQ+EYYokIrI7
         CmoPQuVr6gGCONerCqlaj9nCnfVrzcLPF/7SVur6ieTkqXRKSgMwATaO+Nx9G5G4co0s
         hBIrCBUmimuyEWZnLWOgGqiRHvNH7oHBWCzH5nODcbSXU/ag5ZYyLuFCRg4jT1pY1lSf
         bY5W8WNyZtYwFCWdy10VvE75alWawt+Dd7mL7aoew2Fwhi8BTyCVOulS9x2j/Jmd3W2n
         YDkg==
X-Gm-Message-State: ABuFfoh5d9zoEiCoRoxODDz+9iGbCdKPtnRgjRjiSxA6eEG9FtlTk0/n
        by1cP7jW0jWFYQPs1JnIxoc=
X-Google-Smtp-Source: ACcGV60DD5V03qFNq5cEpC4vT5Q5FvnoXmJHel7EXk+y+UxHhcoDy6TttN/+gMrWCBZqySkyr8beAw==
X-Received: by 2002:a63:db15:: with SMTP id e21-v6mr1318938pgg.418.1537602798610;
        Sat, 22 Sep 2018 00:53:18 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.116])
        by smtp.gmail.com with ESMTPSA id f67-v6sm53219253pff.29.2018.09.22.00.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 00:53:18 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv4 5/6] ARM: dts: exynos: update maximum frequency for emmc to 200MHz
Date:   Sat, 22 Sep 2018 07:52:37 +0000
Message-Id: <20180922075238.884-7-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922075238.884-1-linux.amoon@gmail.com>
References: <20180922075238.884-1-linux.amoon@gmail.com>
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

