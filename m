Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FA6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFB3219AC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3YySDl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFFB3219AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934276AbeGFRw6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933775AbeGFRw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:52:57 -0400
Received: from swboyd.mtv.corp.google.com (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77940219AC;
        Fri,  6 Jul 2018 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530899576;
        bh=jxODZ/g3uBL5j+f6cAlajlWmIx2sOJxfQcD3DRnpY70=;
        h=From:To:Cc:Subject:Date:From;
        b=H3YySDl8su5TtXDP+KuyGAgobr8VkAr3KHqOGhdx688rZ76F3gyI/SPW1CB5ElAhX
         2WuCnpHxDjDF2kjdNJl7/+qqmDSYrw79lMsIAmBaig+3sgtrcj2OpqrkbKxs5X+vAA
         iAl1nYtRyCsVbpLYlAlUq+w7AaAbR4Bk3acQdIDw=
From:   sboyd@kernel.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v4.18-rc3
Date:   Fri,  6 Jul 2018 10:52:54 -0700
Message-Id: <20180706175254.174724-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Boyd <sboyd@kernel.org>

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 9cc63791fad6d2624878c93f3415da77780e68a7:

  Merge branch 'clk-fix-imx6ul-defs' into clk-fixes (2018-06-29 11:40:29 -0700)

----------------------------------------------------------------
The usual collection of driver fixlets:

 - Build cleanup/fix for the sunxi makefile that tried to save size
   but failed and prevented dead code elimination from working

 - Two Davinci clk driver fixes for a typo causing build failures
   in different configurations and an error check that checks
   the wrong variable.

 - Undo the DT ABI breaking imx6ul binding header shuffle that got
   merged this cycle.

----------------------------------------------------------------
Bartosz Golaszewski (1):
      clk: davinci: fix a typo (which leads to build failures)

Dan Carpenter (1):
      clk: davinci: cfgchip: testing the wrong variable

Fabio Estevam (1):
      dt-bindings: clock: imx6ul: Do not change the clock definition order

Masahiro Yamada (1):
      clk: sunxi-ng: replace lib-y with obj-y

Stephen Boyd (2):
      Merge tag 'clk-davinci-fixes-4.18' of https://github.com/dlech/linux into clk-fixes
      Merge branch 'clk-fix-imx6ul-defs' into clk-fixes

 drivers/clk/Makefile                     |  2 +-
 drivers/clk/davinci/da8xx-cfgchip.c      |  2 +-
 drivers/clk/davinci/psc.h                |  2 +-
 drivers/clk/sunxi-ng/Makefile            | 39 ++++++++++++-------------------
 include/dt-bindings/clock/imx6ul-clock.h | 40 +++++++++++++++-----------------
 5 files changed, 37 insertions(+), 48 deletions(-)

-- 
Sent by a computer through tubes
