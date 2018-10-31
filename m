Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A796AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F432054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F432054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeKAGWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:22:24 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:60196 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbeKAGWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:22:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7BF33603C29E;
        Wed, 31 Oct 2018 22:22:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id z4fLeASm32Ap; Wed, 31 Oct 2018 22:22:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3D37F603C29F;
        Wed, 31 Oct 2018 22:22:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 6v2ZmOojSoVg; Wed, 31 Oct 2018 22:22:34 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 0B22D603C29E;
        Wed, 31 Oct 2018 22:22:34 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linux-foundation.org
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UML changes for 4.20-rc1
Date:   Wed, 31 Oct 2018 22:22:33 +0100
Message-ID: <1829585.6m1bt7BjAO@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

First of all, welcome back!

Please note that the vast majority of these changes have
been in -next since 4.18.
Due to vacation and other troubles I didn't send a pull request
back then.
I rebased them a few days ago on top of 4.19.

The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.20-rc1

for you to fetch changes up to 917e2fd2c53eb3c4162f5397555cbd394390d4bc:

  um: Make line/tty semantics use true write IRQ (2018-10-29 22:34:16 +0100)

----------------------------------------------------------------
This pull request contains the following updates for UML:

- Removal of old and dead code
- A bug fix for our tty driver
- Other minor cleanups across the code base
----------------------------------------------------------------

Anton Ivanov (1):
      um: Make line/tty semantics use true write IRQ

Christoph Hellwig (1):
      um: remove unused AIO code

Colin Ian King (1):
      um: trap: fix spelling mistake, EACCESS -> EACCES

Richard Weinberger (3):
      um: Drop own definition of PTRACE_SYSEMU/_SINGLESTEP
      um: Remove update_debugregs()
      um: Give start_idle_thread() a return code

Ritesh Raj Sarraf (1):
      um: Don't hardcode path as it is architecture dependent

YueHaibing (1):
      um: NULL check before kfree is not needed

 arch/um/drivers/line.c                |   4 +-
 arch/um/drivers/port_user.c           |   2 +-
 arch/um/drivers/vector_kern.c         |  15 +-
 arch/um/drivers/vector_user.c         |   6 +-
 arch/um/include/shared/aio.h          |  28 ---
 arch/um/kernel/irq.c                  |   3 +-
 arch/um/kernel/trap.c                 |   2 +-
 arch/um/os-Linux/Makefile             |   8 +-
 arch/um/os-Linux/aio.c                | 390 ----------------------------------
 arch/um/os-Linux/skas/process.c       |   5 +
 arch/x86/um/shared/sysdep/ptrace_32.h |  12 --
 11 files changed, 19 insertions(+), 456 deletions(-)
 delete mode 100644 arch/um/include/shared/aio.h
 delete mode 100644 arch/um/os-Linux/aio.c



