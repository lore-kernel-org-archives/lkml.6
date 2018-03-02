Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932700AbeCBULm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 15:11:42 -0500
Received: from mout.gmx.net ([212.227.17.20]:39587 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932631AbeCBULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 15:11:41 -0500
Date: Fri, 2 Mar 2018 21:11:30 +0100
From: Helge Deller <deller@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for 4.16-rc4
Message-ID: <20180302201130.GA5035@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K0:Z0S2dY4XMVQXHPn63jFI+4YRH9cXeNqx6B894l5yLVULMnwBBjm
 vk2lhktjJFCZMXHBu1nRAHQN8TcWg7TQaR7UG5kuxGepxHPfCvlFK6+RdDRy69nbICwpYQf
 fEzMh/mAP90gDk7j9oolr8ux0Tdiu3Peya9lvw79NXVmlnl79dPVhrJ1pSB5PIPvrP1Wxwe
 GwIuS0VMXY/NDD9r+uMVg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eBdB5/hYJLo=:m/9Vs7Ei/rbZ8DLRVyPAIF
 OoUD3HQziId4paFyJaZD3/qVK8jaFh61A5I1oPzgFmtGZ2enc8jU0kKFGSthPGKsa/k/BJwm1
 u98Y++v7vDVphL/KFEmzlCHQE5vG3H3/hcveqhYrCbVUeTEx6EKquAC3sbz9lb/HpZcBmc7O9
 qZvTNYpaoqMFH4X/8/P2IqXI5KefeSL3U7zUlJk+g2jEsERoequU8CwXeGFCgnIhiCL9aB8pl
 8iWTmzuuzuYp687BBjLP5ugXmvP3NHbSArMh5XhBBIdllHEgim8jkz+nAYV+FQMiNUeiJRb5U
 3Po1+2kVaftBzD4mjpD1XmOiOW4CBTFrArN9CHtFettdmUg4YCvAm7yEWm5VlXU1a0tLzNtYu
 LVRuwQseyZHvlP0InIV9FmzAYI1GvzGKVnCNngptPVv6GTi64Ps1MFF2HBVkflXMopXxDfSaW
 hUcEvJYe9z2/OVlxogIx3Fs4XC8Ct2Wg5T+PJbF/rSPuRYmybAhAogbJ+NVr7zB2hN89H5BYj
 YY+d1XNwloa/33SUvJ+xnqvfh2d3jg+pzXMHzsOCVEjQm5aux8WnqCiSXnWWKDN19fe/yNjaF
 wgYMG6qtq7GCRCliNJqE589f/SnfkgeMf+b5/jlpoo2bIPWFB8eMqMHrAumIWALN0Mj0ZQanO
 4wab7NTkpKRzmTQfUdoEIHY8vW+MWiXqMximnV8KCo/YwT7UBWr4dke9an/joW+tut1GsPocw
 viw23Tc7l1xR1IxlyjkAlIh2+cN8O0WNN/L6FK/0Rm3+W11Al08FQnouJxsSrTI+MFNEqGm8M
 oWl4M+QsbGRj3s5LEDEsorDuIud+A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few small updates and fixes for the parisc architecture from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.16-1

Changes:
- A patch to change the ordering of cache and TLB flushes to hopefully fix the
  random segfaults we very rarely face (by Dave Anglin).
- A patch to hide the virtual kernel memory layout due to security reasons.
- Two small patches to make the kernel run more smoothly under qemu.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (4):
      parisc: Hide virtual kernel memory layout
      parisc: Check if secondary CPUs want own PDC calls
      parisc: Use cr16 interval timers unconditionally on qemu
      parisc: Reduce irq overhead when run in qemu

John David Anglin (1):
      parisc: Fix ordering of cache and TLB flushes

 arch/parisc/include/asm/cacheflush.h |  1 +
 arch/parisc/include/asm/processor.h  |  2 ++
 arch/parisc/kernel/cache.c           | 57 ++++++++++++++++++++----------------
 arch/parisc/kernel/head.S            | 18 ++++++++----
 arch/parisc/kernel/pacache.S         | 22 ++++++++++++++
 arch/parisc/kernel/smp.c             |  7 ++++-
 arch/parisc/kernel/time.c            | 11 +++----
 arch/parisc/mm/init.c                |  7 ++++-
 8 files changed, 86 insertions(+), 39 deletions(-)
