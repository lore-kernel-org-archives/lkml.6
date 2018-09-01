Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED19FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFE22083A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A32yDu5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFE22083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeIAGjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 02:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbeIAGjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 02:39:24 -0400
Received: from mail.kernel.org (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72AC92083A;
        Sat,  1 Sep 2018 02:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535768948;
        bh=qT1T7v08KLPGj09xx7P2ycozqcwe30uOyrKI1DzSGV0=;
        h=From:To:Cc:Subject:Date:From;
        b=A32yDu5Fy0T0qk2EG8/FmrdtTXkWATXy2NfXpVyZJ0RN0qAvKv2Vuqnj0e92dVGJS
         iQMw1pwsITaQdfybzC0/RXhxBMgU3WewX48+VHfF9N8Qz6GsyIyfDdghuOUik8z00c
         OqL3e65b1CwC7Ae+snJAUeedonCoG+FHWc3TfXi4=
From:   sboyd@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v4.19-rc1
Date:   Fri, 31 Aug 2018 19:29:07 -0700
Message-Id: <20180901022907.195811-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to bded6c03e398dc6e862dc8301fb9a60175740653:

  clk: x86: Set default parent to 48Mhz (2018-08-30 14:47:41 -0700)

----------------------------------------------------------------
Two small fixes, one for the x86 Stoney SoC to get a more accurate clk
frequency and the other to fix a bad allocation in the Nuvoton NPCM7XX
driver.

----------------------------------------------------------------
Akshu Agrawal (1):
      clk: x86: Set default parent to 48Mhz

Gustavo A. R. Silva (1):
      clk: npcm7xx: fix memory allocation

 drivers/clk/clk-npcm7xx.c | 4 ++--
 drivers/clk/x86/clk-st.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Sent by a computer through tubes
