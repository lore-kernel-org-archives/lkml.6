Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbeDLSiK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 14:38:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38347 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeDLSiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 14:38:09 -0400
X-Google-Smtp-Source: AIpwx4/cnPtOBda+DnqeoXn3fsA5ltRLuPTmX+3ZMCeLyAeCPQX+9HqgW4I86uD0OOuUlxzDZAODgA==
Date: Thu, 12 Apr 2018 20:37:54 +0200
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Robert Abel <rabel@robertabel.eu>, Sean Young <sean@mess.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] auxdisplay for v4.17-rc1
Message-ID: <20180412183754.lyql6ihg6tcegebi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these fixes and cleanups for auxdisplay.

They are recently rebased -- I am not on my main computer.

Cheers,
Miguel Ojeda

The following changes since commit 0adb32858b0bddf4ada5f364a84ed60b196dbcda:

  Linux 4.16 (2018-04-01 14:20:27 -0700)

are available in the git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v4.17-rc1

for you to fetch changes up to 351f683b9823a3d1bffb6e2e3f381601aa0b2671:

  auxdisplay: Replace licenses with SPDX identifiers (2018-04-12 19:02:45 +0200)

----------------------------------------------------------------
Mostly small fixes and cleanups, plus a non-trivial fix for charlcd

  - charlcd: fixes and cleanups
    From Robert Abel and Sean Young

  - Kconfig fixes
    From Randy Dunlap, Corentin Labbe and Ulf Magnusson

  - cfag12864bfb: const cleanup
    From Gustavo A. R. Silva

  - Docs/licenses/warnings cleanups

----------------------------------------------------------------
Corentin Labbe (1):
      auxdisplay: img-ascii-lcd: fix typo on select SYSCON/MFD_SYSCON

Gustavo A. R. Silva (1):
      auxdisplay: cfag12864bfb: constify fb_fix_screeninfo and fb_var_screeninfo structures

Miguel Ojeda (5):
      Doc: misc-devices: move lcd-panel-cgram.txt to auxdisplay/
      MAINTAINERS: auxdisplay: remove obsolete webpages
      auxdisplay: arm-charlcd: Fix struct charlcd doc line
      auxdisplay: charlcd: Fix and clean up handling of x/y commands
      auxdisplay: Replace licenses with SPDX identifiers

Randy Dunlap (2):
      auxdisplay: fix broken menu
      auxdisplay: make PANEL a menuconfig

Robert Abel (4):
      auxdisplay: charlcd: use null character instead of zero literal to terminate strings
      auxdisplay: charlcd: replace octal literal with form-feed escape sequence
      auxdisplay: charlcd: fix two-line command ^[[LN not marked as processed
      auxdisplay: charlcd: fix hex literal ranges for graphics command

Sean Young (1):
      auxdisplay: charlcd: no need to call charlcd_gotoxy() if nothing changes

Ulf Magnusson (1):
      auxdisplay: img-ascii-lcd: kconfig: Remove MIPS_SEAD3 reference

 .../lcd-panel-cgram.txt                            |   0
 MAINTAINERS                                        |   8 --
 drivers/auxdisplay/Kconfig                         |  16 +--
 drivers/auxdisplay/arm-charlcd.c                   |   4 +-
 drivers/auxdisplay/cfag12864b.c                    |  16 +--
 drivers/auxdisplay/cfag12864bfb.c                  |  20 +---
 drivers/auxdisplay/charlcd.c                       | 119 +++++++++++++++------
 drivers/auxdisplay/hd44780.c                       |   6 +-
 drivers/auxdisplay/ht16k33.c                       |  10 +-
 drivers/auxdisplay/ks0108.c                        |  16 +--
 drivers/auxdisplay/panel.c                         |   6 +-
 include/linux/cfag12864b.h                         |  16 +--
 include/linux/ks0108.h                             |  16 +--
 samples/auxdisplay/cfag12864b-example.c            |  16 +--
 14 files changed, 111 insertions(+), 158 deletions(-)
 rename Documentation/{misc-devices => auxdisplay}/lcd-panel-cgram.txt (100%)
