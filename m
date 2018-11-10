Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F264AC0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8AAA20840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 18:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBvSiL5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8AAA20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeKKDuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 22:50:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbeKKDuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 22:50:14 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3FB20840;
        Sat, 10 Nov 2018 18:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541873064;
        bh=wipdquIStUjiYirMVBw3zYrZVxLBXMe/RB9vSMCGfAs=;
        h=From:To:Cc:Subject:Date:From;
        b=lBvSiL5Gmp2DhJ9d1ay00c5un+wlXGTkPalE8hbKWL1RNZKzlZ3wKuSvS3Z5D/PP1
         j41XOo4JpvNLF501uS0Zn8JRuCLySmFzDbjTsLic57CWgGWFPpdVuXrr74B/JfQit9
         0FEo2GIQHTbkCQGPHu76nxG2WqWxFVL6o56moQt4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v4.20-rc1
Date:   Sat, 10 Nov 2018 10:04:23 -0800
Message-Id: <20181110180423.208899-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 1aefa98b010e9cc7a07046cbcb1237ddad85b708:

  clk: qcom: gcc: Fix board clock node name (2018-11-09 14:13:55 -0800)

----------------------------------------------------------------
A small set of fixes for clk drivers. One to fix a DT refcount
imbalance, two to mark some Amlogic clks as critical, and one final
one that fixes a clk name for the Qualcomm driver merged this cycle.

----------------------------------------------------------------
Christian Hewitt (1):
      clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL

Jerome Brunet (1):
      clk: meson: axg: mark fdiv2 and fdiv3 as critical

Ricardo Ribalda Delgado (1):
      clk: fixed-factor: fix of_node_get-put imbalance

Vinod Koul (1):
      clk: qcom: gcc: Fix board clock node name

 drivers/clk/clk-fixed-factor.c |  1 +
 drivers/clk/meson/axg.c        | 13 +++++++++++++
 drivers/clk/meson/gxbb.c       | 12 ++++++++++++
 drivers/clk/qcom/gcc-qcs404.c  |  2 +-
 4 files changed, 27 insertions(+), 1 deletion(-)

-- 
Sent by a computer through tubes
