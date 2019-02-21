Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78389C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DA12083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 21:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550786244;
	bh=RrplMlGhdB7Wm9lg4n/L5iMAWtb0cODUzRZ/YstjTBw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WOFumUhy0iyv2kqGzfCJomK/ikWl/mVD2J4AUTTkWM2TflepfOCYlrmpWzSo0GKp6
	 chIyzs9WjM7997885ys5cTJwcZWyFiKB9wRrvrFsoy2erQ1FVEaurD/MNmLMGHlNQq
	 YXHdUj1ICiBpUMXM+siYMsTHe8mQLFibdZH1SQg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfBUV5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 16:57:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbfBUV5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 16:57:22 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E76642070B;
        Thu, 21 Feb 2019 21:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550786242;
        bh=RrplMlGhdB7Wm9lg4n/L5iMAWtb0cODUzRZ/YstjTBw=;
        h=From:To:Cc:Subject:Date:From;
        b=Mj303zbgGSH1I9oCIWcLJCNku0eches9tAVOSvYzYRrM2dyh2EG/y5dVf8AZUA60Y
         ffZpmXOvhNewrTlSKpiJR8Ban9BeTYIsLJSOVlntoFmSblXsJ6AgLPUOSwnIORBnPa
         9X/2oMA24Z7xN6GhAK4HbUL5GG3OA6JVBcO/ABQA=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.0-rc7
Date:   Thu, 21 Feb 2019 13:57:21 -0800
Message-Id: <20190221215721.3407-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9ff1a3b4912528f853048ccd9757ba6a2cc75557:

  clk: qcom: gcc: Use active only source for CPUSS clocks (2019-01-24 11:41:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 65a91e2e597dea62a798a8b771edc44859037e7f:

  clk: at91: fix masterck name (2019-02-20 11:40:21 -0800)

----------------------------------------------------------------
A few more fixes for clk drivers causing regressions this release.
Two Allwinner index fixes for A31 and V3 and two Microchip AT91 fixes
for an incorrect clk parent linkage and a miscalculated number
of clks.

----------------------------------------------------------------
Alexandre Belloni (2):
      clk: at91: fix at91sam9x5 peripheral clock number
      clk: at91: fix masterck name

Andre Przywara (1):
      clk: sunxi: A31: Fix wrong AHB gate number

Paul Kocialkowski (1):
      clk: sunxi-ng: v3s: Fix TCON reset de-assert bit

Stephen Boyd (1):
      Merge tag 'sunxi-clk-fixes-for-5.0' of https://git.kernel.org/.../sunxi/linux into clk-fixes

 drivers/clk/at91/at91sam9x5.c        | 5 ++---
 drivers/clk/at91/sama5d2.c           | 4 ++--
 drivers/clk/at91/sama5d4.c           | 2 +-
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c | 4 ++--
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 2 +-
 5 files changed, 8 insertions(+), 9 deletions(-)

-- 
Sent by a computer through tubes
