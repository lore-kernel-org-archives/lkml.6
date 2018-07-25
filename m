Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644DCC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E9B20899
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRvsbHmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E9B20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbeGYRIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:08:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbeGYRIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:08:02 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F6EA204EC;
        Wed, 25 Jul 2018 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532534145;
        bh=L5aMtqzyLBwSQ4BO2usKLsEPFamKyMNvRGGUYEs8gV8=;
        h=From:To:Subject:Date:From;
        b=iRvsbHmhNBX0Z4s7/pl2y9tHPFJ8dNfGu/csJP1y7rX5UPBPuyFsxayI8dAhjd1IB
         UwcSh75p6+I8OzKDtBB4epjuDObzWGQ+W1iazPaDKhgdisqrfoqAmdWT6frLNpAf0H
         xXQyCTLyHH1e7y61lv12rmQeERN/1goO3Nd0VPto=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 0/3] clk/dts: s2mps11: Fix matching as module
Date:   Wed, 25 Jul 2018 17:55:14 +0200
Message-Id: <20180725155517.4872-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The DTS patches depend on 1st clock patch.  I will take them through
samsung-soc tree in next release.

Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  clk: s2mps11: Fix matching when built as module and DT node contains
    compatible
  ARM: dts: exynos: Add compatible for s2mps11 clocks node on Exynos542x
  ARM: dts: exynos: Add compatible for s5m8767 clocks node on Itop Core

 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi |  1 +
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |  1 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |  1 +
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi   |  1 +
 drivers/clk/clk-s2mps11.c                       | 30 +++++++++++++++++++++++++
 5 files changed, 34 insertions(+)

-- 
2.14.1

