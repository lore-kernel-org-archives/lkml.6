Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A28C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6982222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFaWKDBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394936AbfBMVlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:41:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33725 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbfBMVlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:41:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id y10so1850452plp.0;
        Wed, 13 Feb 2019 13:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9pJChXGUZE90I1A6YRRQlvmBFxTmAah9fpiTQbnEZbs=;
        b=LFaWKDBuDmeH60SA5O8/kHr3Q2eI6FxNSSuIAlGYqbnc+8Epki3yzplR0NWxNcgEAP
         MJZ0X8QUiigK8jEQMl0FmyANIX+FJ8wcDNZSf1z5I0xdbVmpGPoFDfzVbMqWQ2kqkcKt
         YVj6S+eafTxSeuAtVXqw3g5t7NPCBOwhpBuRvnq/Grj2Su8Qv/OzpCH+GXfZ7+ltY8YS
         F2RQxaiifxxsNDTZMcZBa0Vps0/5DZcXPvV/xdb1AwA5CvuG5nwAdbjvo1pqVMIeDv25
         98US6MB91HQDULHUr4dx+hy57vMxOMwSnttTI3rt7kWsSetm9RigqBE4cUBtW6/MOiDb
         2SNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9pJChXGUZE90I1A6YRRQlvmBFxTmAah9fpiTQbnEZbs=;
        b=MYefmiwP0A2AD9DHA24G2PWILkOlialUHsnYCFgUtSXGtQnKvrnQKbc7ma02L/CICB
         g+/z8IPXKPnBX0JK5SsEUQnKKBXhFNkY4bfn4Dsn825DX6ePBM7KlLQuFyGUDnJzuoOP
         ile3sT2WDSWInhTylkxwb1YGg3lp8/X0LPwxBrcWrsfTNyCUEg5nQvlpf+fLOY8XW90b
         2rli8SHu63PHxJ0w1MT4s8BzrmMCgJIjNDkiLYW0gVmCm5TSdKtmCoVRNjkiqQBeI0UE
         Tgg1/5ShIF4BCrV/F0PoHiraftZjz5rxhlEQtoNDIoJSKbte3CC4AJXdnCS5DiDo3psS
         0DCQ==
X-Gm-Message-State: AHQUAuaA5icHMRGi1dN106aecQ/55JrV0/kG7w2b9GYPYT2mu8y4KgQs
        8e6YK2xv8K4fiCv3zsqkwM/LbmbK
X-Google-Smtp-Source: AHgI3IYpF3L+T455jAgxe2URuseYbbQgPgBQii4iJ15XgT17v8uNb4JhCoBFrU3fJPcdqUG6tLfJuw==
X-Received: by 2002:a17:902:ab92:: with SMTP id f18mr280715plr.221.1550094060762;
        Wed, 13 Feb 2019 13:41:00 -0800 (PST)
Received: from localhost.localdomain ([103.51.74.137])
        by smtp.gmail.com with ESMTPSA id w128sm335321pfw.79.2019.02.13.13.40.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:41:00 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [RFC 0/2] Add support for Suspend and Resume for Exynos4412 on
Date:   Wed, 13 Feb 2019 21:40:50 +0000
Message-Id: <20190213214052.2427-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to set the Odroid U3+ device into DEEP sleep mode
and is able to resume from suspend state.

Changes base on Krxk/next/dt and worked on 5.0.0-rc6+
TODO: fix the eMMC failuer.

Any input are welcome.

Best Regards
-Anand

Anand Moon (2):
  ARM: dts: exynos: Add proper regulator states for suspend-to-mem for
    odroid-u3
  soc: samsung: pmu: Add the PMU data of exynos4412 to support low-power
    state

 .../boot/dts/exynos4412-odroid-common.dtsi    | 63 ++++++++++++++
 arch/arm/boot/dts/exynos4412-odroidu3.dts     |  3 +
 drivers/soc/samsung/exynos4-pmu.c             | 83 +++++++++++++++++++
 include/linux/soc/samsung/exynos-regs-pmu.h   | 21 +++++
 4 files changed, 170 insertions(+)

-- 
2.20.1

