Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162489AbeCAWFr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 17:05:47 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:33477 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162420AbeCAWFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 17:05:46 -0500
X-Mozilla-News-Host: news://gmane.comp.lib.uclibc.buildroot:119
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Luis de Bethencourt <luisbg@kernel.org>,
        Ulf Magnusson <ulfalizer@gmail.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [GIT PULL] ARC fixes for 4.16-rc4
Message-ID: <d363d22e-d465-c1de-a665-103543f21cf0@synopsys.com>
Date: Thu, 1 Mar 2018 14:05:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull ARC fixes for 4.16-rc4.

Thx,
-Vineet

------------------->
The following changes since commit b2cd1df66037e7c4697c7e40496bf7e4a5e16a2d:

   Linux 4.15-rc7 (2018-01-07 14:22:41 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-4.15-rc4

for you to fetch changes up to a29a25275452c97fe35815f1eb9564f2a07a1965:

   ARC: setup cpu possible mask according to possible-cpus dts property 
(2018-02-28 10:45:32 -0800)

----------------------------------------------------------------
ARC fixes for 4.16-rc4

  - MCIP aka ARconnect fixes for SMP builds [Euginey]

  - Preventive fix for SLC (L2 cache) flushing [Euginey]

  - Kconfig default fix [Ulf Magnusson]

  - trailing semicolon fixes [Luis de Bethencourt]

  - other assorted minor fixes

----------------------------------------------------------------
Alexey Brodkin (2):
       ARCv2: Don't pretend we may set L-bit in STATUS32 with kflag instruction
       ARC: Enable fatal signals on boot for dev platforms

Bartosz Golaszewski (1):
       arc: dts: use 'atmel' as manufacturer for at24 in axs10x_mb

Eugeniy Paltsev (4):
       ARCv2: cache: fix slc_entire_op: flush only instead of flush-n-inv
       ARC: mcip: halt GFRC counter when ARC cores halt
       ARC: mcip: update MCIP debug mask when the new cpu came online
       ARC: setup cpu possible mask according to possible-cpus dts property

Luis de Bethencourt (2):
       ARC: dw2 unwind: Fix trailing semicolon
       ARC: boot log: Fix trailing semicolon

Ulf Magnusson (1):
       ARC: Fix malformed ARC_EMUL_UNALIGNED default

Vineet Gupta (1):
       ARCv2: boot log: fix HS48 release number

  arch/arc/Kconfig                      |  1 -
  arch/arc/boot/dts/axs101.dts          |  2 +-
  arch/arc/boot/dts/axs10x_mb.dtsi      |  4 +-
  arch/arc/boot/dts/haps_hs_idu.dts     |  2 +-
  arch/arc/boot/dts/nsim_700.dts        |  2 +-
  arch/arc/boot/dts/nsim_hs.dts         |  2 +-
  arch/arc/boot/dts/nsim_hs_idu.dts     |  2 +-
  arch/arc/boot/dts/nsimosci.dts        |  2 +-
  arch/arc/boot/dts/nsimosci_hs.dts     |  2 +-
  arch/arc/boot/dts/nsimosci_hs_idu.dts |  2 +-
  arch/arc/include/asm/entry-arcv2.h    |  2 +-
  arch/arc/kernel/mcip.c                | 74 ++++++++++++++++++++++++++++++++---
  arch/arc/kernel/setup.c               |  4 +-
  arch/arc/kernel/smp.c                 | 50 ++++++++++++++++++-----
  arch/arc/kernel/unwind.c              |  2 +-
  arch/arc/mm/cache.c                   |  5 ++-
  include/soc/arc/mcip.h                |  5 +++
  17 files changed, 132 insertions(+), 31 deletions(-)
