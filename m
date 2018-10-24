Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB28C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8654206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8654206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeJXL57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:57:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57404 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbeJXL57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:57:59 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9162714771C2E;
        Tue, 23 Oct 2018 20:31:49 -0700 (PDT)
Date:   Tue, 23 Oct 2018 20:31:48 -0700 (PDT)
Message-Id: <20181023.203148.123764172393516338.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 23 Oct 2018 20:31:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mostly VDSO cleanups and optimizations.

Please pull, thanks a lot!

The following changes since commit 91b15613ce7fb3e724ca0d433eef8e6bf15322af:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-10-19 09:16:20 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 8dbc450f76dc8f3b47fe117cd0cde166e1f21b64:

  Merge branch 'sparc-vdso' (2018-10-22 19:14:24 -0700)

----------------------------------------------------------------
David S. Miller (10):
      sparc: Fix parport build warnings.
      sparc: Improve VDSO instruction patching.
      sparc: Inline VDSO gettime code aggressively.
      sparc: Don't bother masking out TICK_PRIV_BIT in VDSO code.
      sparc: Set DISABLE_BRANCH_PROFILING in VDSO CFLAGS.
      sparc: Improve VDSO CFLAGS.
      sparc: Really use linker with LDFLAGS.
      sparc: Validate VDSO for undefined symbols.
      sparc: Several small VDSO vclock_gettime.c improvements.
      Merge branch 'sparc-vdso'

 arch/sparc/include/asm/parport.h        |   2 ++
 arch/sparc/include/asm/thread_info_64.h |   4 ++++
 arch/sparc/include/asm/vdso.h           |   6 +++---
 arch/sparc/kernel/time_64.c             |   3 ---
 arch/sparc/vdso/Makefile                |  33 +++++++++++++++++----------------
 arch/sparc/vdso/checkundef.sh           |  10 ++++++++++
 arch/sparc/vdso/vclock_gettime.c        | 102 ++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------
 arch/sparc/vdso/vdso-layout.lds.S       |   7 ++-----
 arch/sparc/vdso/vdso2c.c                |   6 ------
 arch/sparc/vdso/vdso2c.h                |  18 ++++++++++++++++--
 arch/sparc/vdso/vma.c                   |  39 +++++++++++++++++++++++----------------
 11 files changed, 123 insertions(+), 107 deletions(-)
 create mode 100644 arch/sparc/vdso/checkundef.sh
