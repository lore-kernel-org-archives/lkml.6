Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C29C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DA620894
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xs6QW+Cz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74DA620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbeGYRIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbeGYRIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:08:10 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E67C120891;
        Wed, 25 Jul 2018 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532534154;
        bh=VE/zg2LUpZNoyus4XZdWZG6hB2UPkPY6ApH0mZqFIBI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=xs6QW+CzLWlTmuX6cufcGmH31jKO2swOaM6wfmrZjXuVdOqa3boDrYUHDhcopz8zV
         T6CXfcLcnDJmcejFNRbABpcJ7ivUNK79f0sLP5ZLmU+5WY/vspE4uOU5nYZveI2ZvP
         HdYjK6N2viPwtInxIQ/IuoeqVgg1enHrm5K1PbR8=
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
Subject: [PATCH 3/3] ARM: dts: exynos: Add compatible for s5m8767 clocks node on Itop Core
Date:   Wed, 25 Jul 2018 17:55:17 +0200
Message-Id: <20180725155517.4872-4-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180725155517.4872-1-krzk@kernel.org>
References: <20180725155517.4872-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings for s2mps11/s5m8767 clocks driver require a compatible for
clocks node.  Parent MFD sec-core driver will also use it when
instantiating children.

The compatible is not needed for proper working because device will be
anyway created by parent MFD device.  Add it for correctness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index ab7affab7f1c..8fdfd80c3acc 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -446,6 +446,7 @@
 		};
 
 		s5m8767_osc: clocks {
+			compatible = "samsung,s5m8767-clk";
 			#clock-cells = <1>;
 			clock-output-names = "s5m8767_ap",
 					"s5m8767_cp", "s5m8767_bt";
-- 
2.14.1

