Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BADDC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E9A20842
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549993867;
	bh=Y9Q0OxZhuzcTIEW9s/8KTeqGtmmlVTtjf2PpH/LOqnY=;
	h=From:To:Subject:Date:List-ID:From;
	b=AS7DRtsaChGCZ6KyttUzULM4OEO+zv9ssf6GJboEzoxomMrxvvsaYYllTZNrU4nPV
	 WT+CI+EVk6N0kFPrvmkyDeseYeIMZ4DoNAa4TJZyyWABYcruhjUEYf+VSVV55ksW/E
	 FRsu6MEZgivOgqvl+5D2Ji+2TMYNMDak3nzDOkSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfBLRvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:51:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:55212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728438AbfBLRvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:51:02 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72BA420842;
        Tue, 12 Feb 2019 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549993860;
        bh=Y9Q0OxZhuzcTIEW9s/8KTeqGtmmlVTtjf2PpH/LOqnY=;
        h=From:To:Subject:Date:From;
        b=r12BhEqKl/QWhUrqlqyXZGGxy5N9T0hfqus0VxArxehSmfIwRPSqO5z8U+Ig70Mm8
         7aFDfi3XJPHyoLes+FFw2qFcJRTPI51gjjRK6GL7eGZfjWllOfPIpvFzM+aHu1T+Mg
         zV3yzgAvNdKD6LGlaJEBf3A8V2aJJ3ivpesWUYK8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 0/4] clk/ARM: exynos: Add ADC to Exynos5410 (Odroid XU)
Date:   Tue, 12 Feb 2019 18:50:48 +0100
Message-Id: <20190212175052.6310-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The DTS patch depends on bindings header with clock ID.  I will take it
through samsung-soc for consecutive release.


Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  dt-bindings: clock: exynos: Put CLK_UART3 in order
  dt-bindings: clock: exynos: Add ADC clock ID to Exynos5410
  clk: samsung: exynos5410: Add gate clock for ADC
  ARM: dts: exynos: Add ADC node to Exynos5410 and Odroid XU

 arch/arm/boot/dts/exynos5410-odroidxu.dts |  5 +++++
 arch/arm/boot/dts/exynos5410.dtsi         |  6 ++++++
 arch/arm/boot/dts/exynos5420.dtsi         | 18 ++++++------------
 arch/arm/boot/dts/exynos54xx.dtsi         |  9 +++++++++
 drivers/clk/samsung/clk-exynos5410.c      |  1 +
 include/dt-bindings/clock/exynos5410.h    |  3 ++-
 6 files changed, 29 insertions(+), 13 deletions(-)

-- 
2.17.1

