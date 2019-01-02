Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033A7C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAC421019
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfABWwa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:52:30 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:32870 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfABWwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:52:30 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F31C86091859;
        Wed,  2 Jan 2019 23:52:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2REFjSgBVpud; Wed,  2 Jan 2019 23:52:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9935B6091852;
        Wed,  2 Jan 2019 23:52:27 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XWrK6ERB3XDX; Wed,  2 Jan 2019 23:52:27 +0100 (CET)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 57E9A608A3B7;
        Wed,  2 Jan 2019 23:52:27 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds@linux-foundation.org
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] UML changes for 4.21
Date:   Wed, 02 Jan 2019 23:52:26 +0100
Message-ID: <1590974.xBRWhrZ5gH@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 8fe28cb58bcb235034b64cbbb7550a8a43fd88be:

  Linux 4.20 (2018-12-23 15:55:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git for-linus-4.21-rc1

for you to fetch changes up to 940b241d9050fc354f68c182e99fc3da1ff36bc0:

  um: Remove obsolete reenable_XX calls (2018-12-27 22:48:35 +0100)

----------------------------------------------------------------
Thiss pull requests contains UML updates for 4.21:

- DISCARD support for our block device driver
- Many TLB flush optimizations
- Various smaller fixes
- And most important, Anton agreed to help me maintaining UML

----------------------------------------------------------------
Anton Ivanov (11):
      um: Switch to block-mq constants in the UML UBD driver
      um: Clean-up command processing in UML UBD driver
      um: Remove unsafe printks from the io thread
      um: Add support for DISCARD in the UBD Driver
      um: Remove unnecessary faulted check in uaccess.c
      um: Optimize TLB operations v2
      um: Skip TLB flushing where not needed
      um: Avoid marking pages with "changed protection"
      um: Optimize Flush TLB for force/fork case
      Add Anton Ivanov to UML maintainers
      um: Remove obsolete reenable_XX calls

Christoph Hellwig (1):
      um: writev needs <sys/uio.h>

Hernán Gonzalez (1):
      um: Add HAVE_DEBUG_BUGVERBOSE

Masahiro Yamada (1):
      um: remove redundant generic-y

Richard Weinberger (3):
      um: Update maintainers file entry
      um: Include sys/uio.h to have writev()
      um: Make GCOV depend on !KCOV

 MAINTAINERS                       |   3 +-
 arch/um/Kconfig                   |   1 +
 arch/um/Kconfig.debug             |   1 +
 arch/um/drivers/chan_kern.c       |  10 --
 arch/um/drivers/line.c            |  10 --
 arch/um/drivers/mconsole_kern.c   |   2 -
 arch/um/drivers/net_kern.c        |   2 -
 arch/um/drivers/port_kern.c       |   1 -
 arch/um/drivers/random.c          |   1 -
 arch/um/drivers/ubd_kern.c        | 231 ++++++++++++++++++++++++--------------
 arch/um/drivers/vector_user.c     |   2 +
 arch/um/include/asm/Kbuild        |   2 -
 arch/um/include/asm/pgtable.h     |   9 +-
 arch/um/include/shared/irq_user.h |   1 -
 arch/um/include/shared/os.h       |   1 +
 arch/um/kernel/irq.c              |   6 -
 arch/um/kernel/sigio.c            |   1 -
 arch/um/kernel/skas/uaccess.c     |  23 ++--
 arch/um/kernel/tlb.c              | 115 ++++++++++++-------
 arch/um/os-Linux/file.c           |  10 ++
 20 files changed, 259 insertions(+), 173 deletions(-)



