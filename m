Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753040AbeDLSlO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:41:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:57459 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752896AbeDLSlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:41:13 -0400
Date: Thu, 12 Apr 2018 20:41:01 +0200
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for 4.17-rc1
Message-ID: <20180412184101.GA20775@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:zDPoHSFKcUq2LOoS9Dw63lMrmEhTKpERBgW6ziaYFZpnVNR2DEM
 gjiInIYuj3Rv3iOK3GMTq6TnYTytYulQiyp62eEpvDWNUxGj2+uSJZ5NQ0yiTG34eyda6/H
 zXXB9EOMD6ag3hLMcWaXxXotJpfrDVuwYWb4uWmk176mNo9YtyvRDRJmwlscmRXAdOF+kLL
 D3O1EvswUvMN04bm20hPA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:O97sO+Y8QsY=:WBGUnN1N9B/fZpVv1i9/1+
 okiQT7EyeDMFcnyLW9Q4oHQmHLJ5eXNbPFzaRRoKIpHiPrgWV7xqpS8w3VnXcOZU2FUjBxgIy
 mfVdqXqc++HFTM9XYsMQg6evN3hnekuVHCqRvoCR1+RXMabquqoti6Q7+w7+yPd/zTwpZdIau
 N2Lmwe87UGfuzEtSUsNyn6nxfJgLk3PMGZKlJ+HiDz8lWso6Pg06lNRY1AbctUHoCvr9HsYE4
 tSL45fW2g4P64cHZp1Bz8j7dAQt0kvlPVZUjiQ3xEfQSM+viMd4WC3aCga8XZAmuWp9Nca2JV
 bSnAI3J7yG+QI6zd+/bhRf9p1j/zvpDbTpe5Cj875tRv9gx7NbSzc95GLcyHloN0ARQY3Rh5y
 hX6iHw0ebd69AXUytthlJbbF0nQ4Viw8QUcKbTz/Lx6wTfBTIhwnXMgWyauoA0JeWGJKyC7nW
 8ZChXrAM1mjZAMVfJcLCKDkbjL8T4wRGh791bOzcB/ic92F+My6Xe4iUDgQJtBT2salHvMFqs
 t3Tp446mVjRekAUZrNsEcJR2olz4zxonBaGTEgraRq8B0BGZwcZ7RFLtdhrvb4YUzLUcsJDF6
 geYdwSbT7DTA32uLXWvL5bjegqcwMLjkr1fbTC14VFS2xmuGmvOT94u7/dZ9NlEDuCJMkcx/m
 wULYhXi1iGPKRnvtl5eRWrPYcWbV3HP3wHfMKKhixnVw6M5ygK3eLf4NHmfwubTBCE96fbSNv
 he7dAiRr8PfKO3ucU/EU1BFWnBfS2jxuhhQGBp7DEKHfZqKKON8ANUJ6QD6pn8LZsOQsuDSa8
 /vX9KDAxtIVCNgH7NH/4eLmXwGfhA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few last changes for this merge window for the parisc architecture from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.17-2

Changes:
- Fix panic when halting system via "shutdown -h now"
- Drop own coding in favour of generic CONFIG_COMPAT_BINFMT_ELF implementation
- Add FPE_CONDTRAP constant: last outstanding parisc-specific cleanup for Eric
  Biedermans siginfo patches
- move some functions to .init and some to .text.hot linker sections

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (4):
      parisc/signal: Add FPE_CONDTRAP for conditional trap handling
      parisc: Move cache flush functions into .text.hot section
      parisc: Switch to generic COMPAT_BINFMT_ELF
      parisc: Prevent panic at system halt

 arch/parisc/Kconfig                    |  1 +
 arch/parisc/include/asm/compat.h       |  6 +++
 arch/parisc/include/asm/elf.h          | 69 ++++++++++++------------
 arch/parisc/include/uapi/asm/siginfo.h |  7 ---
 arch/parisc/kernel/binfmt_elf32.c      | 98 ----------------------------------
 arch/parisc/kernel/cache.c             |  2 +-
 arch/parisc/kernel/pacache.S           |  9 ++--
 arch/parisc/kernel/process.c           | 13 ++---
 arch/parisc/kernel/traps.c             |  7 +--
 arch/x86/kernel/signal_compat.c        |  2 +-
 include/uapi/asm-generic/siginfo.h     |  3 +-
 11 files changed, 60 insertions(+), 157 deletions(-)
 delete mode 100644 arch/parisc/kernel/binfmt_elf32.c
