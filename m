Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244AEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD8C2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 11:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550749561;
	bh=OhizZ9wS/AQVMgARvV1McNtIA3yS1+yr5vSdzQtUxEY=;
	h=From:To:Subject:Date:List-ID:From;
	b=rLAUYJKAl8Zp3CJ7vAn/NRaB6FakLSD20obumTRC9UjxrNKaZIZI+A/hp/8r3lsOy
	 0cuj38UufXU0dyhDj/wXW0z7l3SW7+9aTJlO6Ec6YdoIBUrN7A+ZXs3qRoMaVS05yi
	 12L6vaAJkE2a1TK8l1dzx54QLqCl33e5sUUSOmBk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfBULp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 06:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbfBULp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 06:45:59 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E8120855;
        Thu, 21 Feb 2019 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550749558;
        bh=OhizZ9wS/AQVMgARvV1McNtIA3yS1+yr5vSdzQtUxEY=;
        h=From:To:Subject:Date:From;
        b=IgqU9TJauE/hDIrp9cBiR5PMG4p75hf+6l4ycpaTbPJiWYjnXwukWcRk58wcz96GG
         wlLMlu+lAkixGDWGRCpMsHqPmes36EDwIbtu7pBi//5C70usteqmGHo4xJNvhNu+N5
         ULXC2m/YoVqeaPOUQ1QlZytCuP7bIamfCJUYYrl0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] clk: samsung: Fix kfree() of const memory on setting driver_override
Date:   Thu, 21 Feb 2019 12:45:50 +0100
Message-Id: <1550749552-8133-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
1. Split clock-related fixes out of bigger platform patchset.
2. Remove usage of driver_override.

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  clk: samsung: exynos5: Fix possible NULL pointer exception on
    platform_device_alloc() failure
  clk: samsung: exynos5: Fix kfree() of const memory on setting
    driver_override

 drivers/clk/samsung/clk-exynos5-subcmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
2.7.4

