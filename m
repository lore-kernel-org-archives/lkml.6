Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeDJVbQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 17:31:16 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58242 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752041AbeDJVbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 17:31:15 -0400
From: Richard Weinberger <richard@nod.at>
To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] UML changes for 4.17-rc1
Date: Tue, 10 Apr 2018 23:31:12 +0200
Message-ID: <1785113.iBXbRI6JsH@blindfold>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git 

for you to fetch changes up to e40238dedb484c8a19f8257e4ef5d77d038f9ad8:

  Fix vector raw inintialization logic (2018-03-29 22:18:02 +0200)

----------------------------------------------------------------
This pull request contains:
- A new and faster epoll based IRQ controller and NIC driver
- Misc fixes and janitorial updates

----------------------------------------------------------------
Anton Ivanov (5):
      Epoll based IRQ controller
      High Performance UML Vector Network Driver
      um: Add missing EXPORT for free_irq_by_fd()
      Migrate vector timers to new timer API
      Fix vector raw inintialization logic

Arnd Bergmann (1):
      um: time: Use timespec64 for persistent clock

Christophe JAILLET (2):
      um: vector: Fix a memory allocation check
      um: vector: Fix an error handling path in 'vector_parse()'

Geert Uytterhoeven (1):
      um: Restore symbol versions for __memcpy and memcpy

Jason A. Donenfeld (1):
      um: Compile with modern headers

Krzysztof Mazur (1):
      um: Use POSIX ucontext_t instead of struct ucontext

Wei Yongjun (1):
      um: vector: fix missing unlock on error in vector_net_open()

 arch/um/Kconfig.net                  |   11 +
 arch/um/drivers/Makefile             |    4 +-
 arch/um/drivers/chan_kern.c          |   53 +-
 arch/um/drivers/line.c               |    2 +-
 arch/um/drivers/net_kern.c           |    4 +-
 arch/um/drivers/random.c             |   11 +-
 arch/um/drivers/ubd_kern.c           |    4 +-
 arch/um/drivers/vector_kern.c        | 1633 ++++++++++++++++++++++++++++++++++
 arch/um/drivers/vector_kern.h        |  130 +++
 arch/um/drivers/vector_transports.c  |  458 ++++++++++
 arch/um/drivers/vector_user.c        |  590 ++++++++++++
 arch/um/drivers/vector_user.h        |  100 +++
 arch/um/include/asm/asm-prototypes.h |    1 +
 arch/um/include/asm/irq.h            |   12 +
 arch/um/include/shared/irq_user.h    |   12 +-
 arch/um/include/shared/net_kern.h    |    2 +
 arch/um/include/shared/os.h          |   17 +-
 arch/um/kernel/irq.c                 |  461 ++++++----
 arch/um/kernel/time.c                |    6 +-
 arch/um/os-Linux/file.c              |    1 +
 arch/um/os-Linux/irq.c               |  202 +++--
 arch/um/os-Linux/signal.c            |    3 +-
 arch/x86/um/stub_segv.c              |    3 +-
 23 files changed, 3395 insertions(+), 325 deletions(-)
 create mode 100644 arch/um/drivers/vector_kern.c
 create mode 100644 arch/um/drivers/vector_kern.h
 create mode 100644 arch/um/drivers/vector_transports.c
 create mode 100644 arch/um/drivers/vector_user.c
 create mode 100644 arch/um/drivers/vector_user.h
 create mode 100644 arch/um/include/asm/asm-prototypes.h
