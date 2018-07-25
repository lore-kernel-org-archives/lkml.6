Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1A7C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B6520894
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 16:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6IC3E+5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B6520894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeGYRgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:50414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728606AbeGYRgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:36:31 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C50A20893;
        Wed, 25 Jul 2018 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532535848;
        bh=bYe5GuEvCX+ZC8oXGcmRVq1syNoW2nGyN5rOj/BI0Ec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D6IC3E+572Jbr5SlFOk8dWGLssnNoIwG0iDb0wMShObaeAUwdTXkRMgJ1V2EJWr0X
         9P7p8AanC6JwdOHIRSRsOQvcJi9wJ+AeVjFbWAhyLN9CnMfe+Af2y190obiZA4cMYg
         hrxsMfBYZmttTQzmwZf6SOgssMqExcMhpQdyyGjo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 2/3] ARM: dts: exynos: Second round for v4.19
Date:   Wed, 25 Jul 2018 18:23:39 +0200
Message-Id: <20180725162340.7488-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180725162340.7488-1-krzk@kernel.org>
References: <20180725162340.7488-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On top of previous pull request.


Best regards,
Krzysztof


The following changes since commit 57f4e8bc1c3ebbd06a278107edeb6af95b53e5bf:

  dt-bindings: samsung: Document bindings for SGH-T959P board (2018-07-07 12:28:07 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.19-2

for you to fetch changes up to 965228d33cd2b47adb493bb1864761420c632e41:

  ARM: dts: exynos: Configure Midas SD card CD pin (2018-07-23 19:12:01 +0200)

----------------------------------------------------------------
Samsung DTS ARM changes for v4.19, part 2

1. Add missing interrupts to PWM nodes on Exynos5.
2. Add missing interrupt pin pull up/down configuration on Exynos4412
   Midas boards.  The interrupts were mostly working thanks to initial
   configuration by bootloader.

----------------------------------------------------------------
Anand Moon (1):
      ARM: dts: exynos: Add missing interrupts for pwm node on Exynos5

Simon Shields (5):
      ARM: dts: exynos: Add max77693 pinctrl config for Midas
      ARM: dts: exynos: Add pinctrl config for Midas keys
      ARM: dts: exynos: Add pinctrl for Midas fuelgauge IRQ pin
      ARM: dts: exynos: Configure max77686 IRQ pin on Midas
      ARM: dts: exynos: Configure Midas SD card CD pin

 arch/arm/boot/dts/exynos4412-midas.dtsi | 35 ++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/exynos5.dtsi          |  5 +++++
 2 files changed, 39 insertions(+), 1 deletion(-)
