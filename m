Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A22C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D0F214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 21:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544133542;
	bh=NDZi15ArRjLZYT2bCpxYx75qHXvyrJ36dvrIFwmMSSE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Vlw4JG8rWUpaCcS9gYgkaYFyO8vQ4j7IaH3nebUt7q6Gf0woq5Y09A4ZHbmuk/Uox
	 oIpoNbGCXhbvheeEFlV1pu4elp3KMEV/clszOOQdZEy9RWIkQSfr9HmzWzWvsmeBYU
	 p9H4BkQX/XMr9MHsM8ux/8C2rai+jdjzz7hWrEuo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D0F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLFV7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 16:59:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:60024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbeLFV7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 16:59:00 -0500
Received: from mail.kernel.org (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3A9F20838;
        Thu,  6 Dec 2018 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544133539;
        bh=NDZi15ArRjLZYT2bCpxYx75qHXvyrJ36dvrIFwmMSSE=;
        h=From:To:Cc:Subject:Date:From;
        b=tl/D7oeUkdITLA9nD6aaIRjMG74ibU3AtqYu5XetnjrOTXwvOe9hcGMUixqCWQx/O
         OM4uHRnvjqzQAF/BDTNV2+CMHXUK8ZM9pPtcC2WCqgGQ3dTa4dDZwYFr/FttPsueNF
         m6YalabOGZZjy4Fw3lyzO877DfgL5AtG+OaUiFBE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Anders Berg <anders.berg@lsi.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        uclinux-h8-devel@lists.sourceforge.jp,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH 0/8] Remove CLK_IS_BASIC usage from clk drivers
Date:   Thu,  6 Dec 2018 13:58:50 -0800
Message-Id: <20181206215858.3880-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A collection of patches to remove CLK_IS_BASIC from drivers
that don't look to have any need for it. There are some files
outside of drivers/clk/ that aren't include here because I'll
send those patches to respective maintainers.

Cc: Anders Berg <anders.berg@lsi.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Jiancheng Xue <xuejiancheng@hisilicon.com>
Cc: Jianguo Sun <sunjianguo1@huawei.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: <linux-renesas-soc@vger.kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: <uclinux-h8-devel@lists.sourceforge.jp>
Cc: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Stephen Boyd (8):
  clk: renesas: Remove usage of CLK_IS_BASIC
  clk: st: Remove usage of CLK_IS_BASIC
  clk: axm5516: Remove usage of CLK_IS_BASIC
  clk: h8300: Remove usage of CLK_IS_BASIC
  clk: hisilicon: Remove usage of CLK_IS_BASIC
  clk: versatile: sp810: Remove usage of CLK_IS_BASIC
  clk: samsung: s3c2410: Remove usage of CLK_IS_BASIC
  clk: Loongson1: Remove usage of CLK_IS_BASIC

 drivers/clk/clk-axm5516.c                 | 2 --
 drivers/clk/h8300/clk-h8s2678.c           | 2 +-
 drivers/clk/hisilicon/clk-hi3620.c        | 2 +-
 drivers/clk/hisilicon/clk-hisi-phase.c    | 2 +-
 drivers/clk/hisilicon/clk-hix5hd2.c       | 2 +-
 drivers/clk/hisilicon/clkgate-separated.c | 2 +-
 drivers/clk/loongson1/clk.c               | 8 +++++---
 drivers/clk/renesas/clk-div6.c            | 2 +-
 drivers/clk/renesas/clk-mstp.c            | 2 +-
 drivers/clk/renesas/r9a06g032-clocks.c    | 8 ++++----
 drivers/clk/renesas/rcar-gen3-cpg.c       | 2 +-
 drivers/clk/renesas/renesas-cpg-mssr.c    | 2 +-
 drivers/clk/samsung/clk-s3c2410-dclk.c    | 2 +-
 drivers/clk/st/clk-flexgen.c              | 2 +-
 drivers/clk/st/clkgen-fsyn.c              | 4 ++--
 drivers/clk/st/clkgen-pll.c               | 2 +-
 drivers/clk/versatile/clk-sp810.c         | 2 +-
 17 files changed, 24 insertions(+), 24 deletions(-)

-- 
Sent by a computer through tubes
