Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9747BC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6505D20866
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 22:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548196653;
	bh=oEL/yInKmSXM4cE27r6QqJaR0pqECWFDAFU8BfdRiWk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WMbwImr9Xr/X3hVpqpnEMh0UjVO7ONlB/7F8w/0F75/tBUdyl8kVTl7tBPTY5bHG8
	 7YfYp6zbK3FpIw1Y26QeGJfIYkRQrASKPZ07TKQHSB2IhLO0c0kisT0XBv8l9MOUrV
	 /kDLRj2CX+xqwiUYWloGQpKdaoWN5vUN6VMzYtDA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfAVWhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 17:37:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:42980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfAVWhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 17:37:31 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9596E20866;
        Tue, 22 Jan 2019 22:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548196650;
        bh=oEL/yInKmSXM4cE27r6QqJaR0pqECWFDAFU8BfdRiWk=;
        h=From:To:Cc:Subject:Date:From;
        b=DEJQN+TI0EST0C3bQafw2Q1s3jR8f5AjYqjZ7GEtzvqhCNtPZa61tAThpPRPrkqbz
         SuNiONfYbBfkgZVpjpYG6baMP0/fB7Jv/hN+n7a+oXa2A49ZvW3ojWqYTOZKFTPzsb
         Fg4qRK5MihHT2zminQkvrN3pLXXZhc9kSUFJGUcw=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.0-rc3
Date:   Tue, 22 Jan 2019 14:37:29 -0800
Message-Id: <20190122223729.95720-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to b488517b28a47d16b228ce8dcf07f5cb8e5b3dc5:

  clk: socfpga: stratix10: fix naming convention for the fixed-clocks (2019-01-15 12:58:38 -0800)

----------------------------------------------------------------
This is a sort of random collection of clk fixes that have come in since
the merge window.

 - Handful of memory allocation and potentially bad pointer usage fixes

 - JSON format was incorrect for clk_dump because it missed a comma

 - Two Kconfig fixes, one duplicate and one missing select line

 - Compiler warning fix for the VC5 clk driver

 - Name and rate fixes for PLLs in the stratix10 driver so it can
   properly detect PLL rates and parents

----------------------------------------------------------------
Abel Vesa (1):
      clk: imx: Remove Kconfig duplicate include

Dan Carpenter (1):
      clk: tegra: dfll: Fix a potential Oop in remove()

Dinh Nguyen (2):
      clk: socfpga: stratix10: fix rate calculation for pll clocks
      clk: socfpga: stratix10: fix naming convention for the fixed-clocks

Gustavo A. R. Silva (1):
      clk: zynqmp: Fix memory allocation in zynqmp_clk_setup

Lubomir Rintel (1):
      clk: sysfs: fix invalid JSON in clk_dump

Marc Gonzalez (1):
      clk: qcom: Select QCOM_GDSC with MSM_GCC_8998

Marek Vasut (1):
      clk: vc5: Abort clock configuration without upstream clock

Wei Yongjun (1):
      clk: imx: fix potential NULL dereference in imx8qxp_lpcg_clk_probe()

 drivers/clk/Kconfig                        |  1 -
 drivers/clk/clk-versaclock5.c              |  4 +++-
 drivers/clk/clk.c                          |  2 +-
 drivers/clk/imx/clk-imx8qxp-lpcg.c         |  2 ++
 drivers/clk/qcom/Kconfig                   |  1 +
 drivers/clk/socfpga/clk-pll-s10.c          |  2 +-
 drivers/clk/socfpga/clk-s10.c              | 20 ++++++++++----------
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c |  4 +++-
 drivers/clk/zynqmp/clkc.c                  |  4 ++--
 9 files changed, 23 insertions(+), 17 deletions(-)

-- 
Sent by a computer through tubes
