Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751885AbeEKTCw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 15:02:52 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:54030 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbeEKTCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 15:02:50 -0400
Date: Fri, 11 May 2018 15:02:47 -0400
From: Rich Felker <dalias@libc.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rob Herring <robh@kernel.org>
Subject: [GIT PULL] arch/sh regression fixes for 4.17
Message-ID: <20180511190247.GA18860@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull these changes for arch/sh. They fix regressions introduced
in 4.15 and 4.17-rc1 that prevent booting on affected systems.

Rich



The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  git://git.libc.org/linux-sh tags/sh-for-4.17-fixes

for you to fetch changes up to ac21fc2dcb405cf250ad3f1228f64f64930d9211:

  sh: switch to NO_BOOTMEM (2018-05-11 13:35:46 -0400)

----------------------------------------------------------------
Fixes for critical regressions and a build failure.

----------------------------------------------------------------
Jacopo Mondi (1):
      sh: mm: Fix unprotected access to struct device

Rich Felker (1):
      sh: fix build failure for J2 cpu with SMP disabled

Rob Herring (1):
      sh: switch to NO_BOOTMEM

 arch/sh/Kconfig                |  1 +
 arch/sh/kernel/cpu/sh2/probe.c |  4 +++
 arch/sh/kernel/setup.c         |  1 -
 arch/sh/mm/consistent.c        | 11 +++++--
 arch/sh/mm/init.c              | 68 ++++--------------------------------------
 arch/sh/mm/numa.c              | 19 ------------
 6 files changed, 19 insertions(+), 85 deletions(-)
