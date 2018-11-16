Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D6DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9016208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 10:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZdFut/Oy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9016208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbeKPUND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 15:13:03 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35677 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbeKPUND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 15:13:03 -0500
Received: by mail-pf1-f194.google.com with SMTP id v9-v6so11177852pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 02:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaocSBgVSQTsyWZDwUyvm9AOU5NWzNYaxEXBwFA4KOE=;
        b=ZdFut/OyruJMA3LLM6BQthGHcgT/z7FbcwGqVbho259HwobgxkjeY3HCTP4pzQluk8
         1oSU11F+tbWgxmWRgwU234r4e/yOKBG60sgifVn6fA94eN/WVoFWh71Q3H+ych2OuzBm
         sub+J1lEbWM02lUd06Cyl86CDvyqS6B+1KDDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaocSBgVSQTsyWZDwUyvm9AOU5NWzNYaxEXBwFA4KOE=;
        b=iZUkrcqNPJrDVfe3lg+YZAPXThJV0ci0Op7VSXE9Jo1cNFZU4MtMdagQSj/ZyFmIGE
         q5sC8dnmZG3e3lN0rEp3i2vzlQap4E8ERks3vioUNSVyAIsodw39m3ga8RERzKAKKA+9
         Go6MXXUeinTa8y7Wrsr4CdR3Oz2uXmUXTnf5T9Yg14JTrbaYbw1ooQODfc/pxAnWBii/
         i/+XlA4l1B10wT/Y01ufHD2wnCwzbz/VmoILhsjIpQSk7q3kvbv/YgtviKsrlV4YVBU9
         /E7Cl4GswU7mENQ3DdbKhazDquKh95vY96QgMMGa2nixzcuKdHcx1ZbLInxnREPn/Rn3
         ujxA==
X-Gm-Message-State: AGRZ1gKbBld4or/r9FKTJ8rgHqChkjzOdWLTbJr30xTuvCC19URc0DBR
        yOcYixbR1bDWb7hU5TwmxGV+Pg==
X-Google-Smtp-Source: AJdET5enIB1r/mD6ySjDFaQu7GleUgt3JZEAYXHrIzibgVMHHxds53iEuGLj/ARERvX8h5T2vWrWoQ==
X-Received: by 2002:a63:bd51:: with SMTP id d17mr9459706pgp.443.1542362485534;
        Fri, 16 Nov 2018 02:01:25 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id c7-v6sm37862340pfh.25.2018.11.16.02.01.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 02:01:23 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/6] ARM: dts: Fix incomplete cooling-maps
Date:   Fri, 16 Nov 2018 15:31:09 +0530
Message-Id: <cover.1542362000.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Now that the below commit are merged in mainline, we can start fixing
the platform specific DT files:

commit d7a4303b8d1f ("dt-bindings: thermal: Allow multiple devices to
share cooling map")

commit a92bab8919e3 ("of: thermal: Allow multiple devices to share
cooling map")

Each CPU can (and does) participate in cooling down the system but the
DT only captures a handful of them, normally CPU0, in the cooling maps.
Things work by chance currently as under normal circumstances its the
first CPU of each cluster which is used by the operating systems to
probe the cooling devices. But as soon as this CPU ordering changes and
any other CPU is used to bring up the cooling device, we will start
seeing failures.

Also the DT is rather incomplete when we list only one CPU in the
cooling maps, as the hardware doesn't have any such limitations.

Update cooling maps to include all devices affected by individual trip
points.

--
viresh

Viresh Kumar (6):
  ARM: dts: exynos: Add all CPUs in cooling maps
  ARM: dts: ls1021a: Add all CPUs in cooling maps
  ARM: dts: mt7623: Add all CPUs in cooling maps
  ARM: dts: rockchip: Add all CPUs in cooling maps
  ARM: dts: sunxi: Add all CPUs in cooling maps
  ARM: dts: uniphier: Add all CPUs in cooling maps

 arch/arm/boot/dts/exynos3250-artik5.dtsi      |   6 +-
 arch/arm/boot/dts/exynos3250-monk.dts         |   6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts       |   6 +-
 arch/arm/boot/dts/exynos4210-trats.dts        |   4 +-
 arch/arm/boot/dts/exynos4210.dtsi             |   2 +-
 .../boot/dts/exynos4412-itop-scp-core.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-midas.dtsi       |   8 +-
 .../boot/dts/exynos4412-odroid-common.dtsi    |   8 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  17 ++-
 arch/arm/boot/dts/exynos4412.dtsi             |   6 +-
 arch/arm/boot/dts/exynos5250.dtsi             |   7 +-
 arch/arm/boot/dts/exynos5422-odroidhc1.dts    | 106 +++++++++++-------
 .../boot/dts/exynos5422-odroidxu3-common.dtsi | 106 +++++++++++-------
 arch/arm/boot/dts/ls1021a.dtsi                |   2 +
 arch/arm/boot/dts/mt7623.dtsi                 |  15 ++-
 arch/arm/boot/dts/rk322x.dtsi                 |  10 +-
 arch/arm/boot/dts/rk3288-veyron-mickey.dts    |  24 ++--
 arch/arm/boot/dts/rk3288.dtsi                 |  15 ++-
 arch/arm/boot/dts/sun6i-a31.dtsi              |  11 +-
 arch/arm/boot/dts/sun7i-a20.dtsi              |   5 +-
 arch/arm/boot/dts/sun8i-a33.dtsi              |  16 ++-
 arch/arm/boot/dts/uniphier-pxs2.dtsi          |   6 +-
 22 files changed, 250 insertions(+), 144 deletions(-)

-- 
2.19.1.568.g152ad8e3369a

