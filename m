Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3261C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA242154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfxGSFpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA242154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeIVNpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:45:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39970 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVNps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:45:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17-v6so6931168plp.7;
        Sat, 22 Sep 2018 00:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQiZIpqZCyb/15muQvEVGtCrC8IrAFJLh0dOxMdHDi4=;
        b=kfxGSFpo+S3jOPmvY42b/PmgQFCnNrhmYrdpqUkEwkxv1wddhfGN6M+EAwQBxE7M97
         SlW54Wno6GuQKAsgve7nYbdfbNsalQYZS9J2xmTGIwrJKInb3L8dlxPaV5IhuaHg5F7T
         YgBnltGENfPtBUCgIPSgqvE5ooy3pqJyx/Hbbba8kOAE+SQgln9FNq84hZHX1ENfMAe8
         n123AVds5ZfYbuXd5AcW9zkZC1eySobTEvrpUsl9zrPhqoCR4B4rWjgaPX0XlPxzTgis
         KS1ayilSAzaPZl05GF1Nv4ip1yvOVVwl3RdiPR9pkEmU4ixDDIp1zdPJuCmcRQ1dgcOt
         lbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQiZIpqZCyb/15muQvEVGtCrC8IrAFJLh0dOxMdHDi4=;
        b=JjriI3yNgg3IuiRiwtpzCkGgNe/7TQeZvHFOQTg59fTBWGJV0iUBgXqTlrX0XoUmGq
         Or8vnkFHuhqjHNAPr85/H6amH+3HhX7sCiDcQLhYqvh8cPUkwguJ10lf2qfUiGjsHxVF
         9tbRn10MWHVnEpy0ZQYNItviLeP0RqP+Mt0n7Li68PVc7qQ1kEQvO+ZlBVtakeTjp1eJ
         AsQbgPldjXhdHP/jTjmjHhdn+m8Vm0b2IQUtgoTTjWwpxZg/fMW/Ydg6bBHjOfQiP7AQ
         lSzeD34UAC8h9vpylN/HblFGj1qr36/O8vqu8+GEqG6Xqd8vyvwxumBeejcD8dPEf3r8
         rfGA==
X-Gm-Message-State: ABuFfojcxDizzEAULnOw6pIkB9nAarFFRuDwzc0iBTqmbk2rcKRwmwOB
        KOsi+cgNL3XEmV+XbBBTwr4=
X-Google-Smtp-Source: ACcGV639/Gh6RL1UN07kIN4e/UAVOjBg+yRfR7kYyGnoGHNI4HYc75vB+UTfG8ErXzNg0W2AacW9rg==
X-Received: by 2002:a17:902:82c9:: with SMTP id u9-v6mr1476409plz.138.1537602790897;
        Sat, 22 Sep 2018 00:53:10 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.116])
        by smtp.gmail.com with ESMTPSA id f67-v6sm53219253pff.29.2018.09.22.00.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 00:53:10 -0700 (PDT)
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
Subject: [PATCHv4 3/6] ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
Date:   Sat, 22 Sep 2018 07:52:35 +0000
Message-Id: <20180922075238.884-5-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922075238.884-1-linux.amoon@gmail.com>
References: <20180922075238.884-1-linux.amoon@gmail.com>
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

