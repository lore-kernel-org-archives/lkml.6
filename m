Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D1320936
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 19:35:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37D1320936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbeHVXBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 19:01:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:37041 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeHVXBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 19:01:39 -0400
Received: from ls3530.fritz.box ([92.116.128.175]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mh9yT-1fWLBw0x1d-00MKuY; Wed, 22
 Aug 2018 21:35:21 +0200
Date:   Wed, 22 Aug 2018 21:35:17 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc fixes and updates for kernel v4.19
Message-ID: <20180822193517.GA31476@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:RCxDjsItM4pA5iUGxsuMj/0qK4pcV7t7bFC8f9iboviG8uNTx0H
 HUYCNKIBf+LsqYQizhUyWTh6sDcj5zNoi32iZt0cWzXe5vJaOLTnGKEsS5Hitas5ofzu+bH
 dIY2EW03q10PPcEliFWLupNyJqikDnHcTnetkqylnxGPg9hUyeL2W4PxqERfhBm2xMDX9AW
 FySHlqGUwPTJ0dLzxyVHw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nS7o6ddL1qw=:WH6jw5PDhGTG/vjCnfgnJ0
 IiJj6SFTg+iMuvPSkbBseUWQQNBnvYJilsU1q3zHGGP2VOCcLOiCCFBYC7olzBLr+NGYbvDC7
 tHCMjrbq8A2oSaOiqytWa3ogp5iBBrac3wsV0DoS9wxrF37O0+UW7Ac8riOXW5gYu5TXB6NHF
 pU7Ep5gy+5rwRcXbvQ8KelHwAX1SPNGCIF3HWq1GlZp2U4z/O9XNxz4yupcIGv0mQVDHShNV6
 ChWtJ3xbAjTZhRlU7ovXVxOk2pmeK2b3U479/c/vfG5ExjNo8Vz2ucCWxKLpKkv5yvrc4tU/U
 JrhLtXHcVYsxXXuEY+HocJYRkuDe4FScVnWAvhQQZsQKHekeQwZ2/5vC9iixqDLyXeOZnTo2q
 DgMyRPWWikAZBWULagHyhWHnTNm0UFkHEtmv+iPyPG3OvG1WK3ucpt6HTtZAP82MXYMz5X+St
 rV+lkQg5siTXFBkMgYrIBtxSOa/z5yCIJngf6Lf2/mHOLomySZ+6EX7nwaODAJ2doKnH3k1bh
 hmx1NffR53yZ1e/1zgAxo7Vq/5sJDTKJ8xjxTQt4/vF3q8KLDBaqVx0gDHCGVVddP8SLogY4U
 WMK8R4+bxl2vBSnoCAefrBcciFIkX6SZ3t8WQcMXwVBx3/VSW2ugt72Autak6rgvIrXgruWja
 7yngOdTFqnlM+SJr4p/AfD8IPvzhdVC+TcOBkbwL2AfiV6SL4dFzpwHaCMuRqT5GIIMT5LEDf
 fO+xsEmOV+/JeK51XLe9ZO5z198JUEIjgxvCFZoNfhzp1q7akP4wlGJZZ5Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the second round of fixes and updates in this merge window
for the parisc architecture for kernel 4.19 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.19-2

Changes:
- fix boot failure of 64-bit kernel. It got broken by the unwind
  optimization commit in merge window.
- fix 64-bit userspace support (static 64-bit applications only, e.g. we
  don't yet have 64-bit userspace support in glibc).
- consolidate unwind initialization code.
- add machine model description to stack trace.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (6):
      parisc: Restore possibility to execute 64-bit applications
      parisc: Fix ptraced 64-bit applications to call 64-bit syscalls
      parisc: Update comments in syscall.S regarding wide userland
      parisc: Consolidate unwind initialization calls
      parisc: Fix boot failure of 64-bit kernel
      parisc: Add hardware description to stack traces

 arch/parisc/include/asm/elf.h       |  9 +++--
 arch/parisc/include/asm/linkage.h   |  9 -----
 arch/parisc/include/asm/processor.h |  6 +--
 arch/parisc/include/asm/traps.h     |  4 +-
 arch/parisc/include/asm/unwind.h    |  6 ++-
 arch/parisc/kernel/entry.S          | 79 ++++++++++++++++++-------------------
 arch/parisc/kernel/processor.c      |  2 +
 arch/parisc/kernel/stacktrace.c     | 15 +------
 arch/parisc/kernel/sys_parisc.c     |  5 ---
 arch/parisc/kernel/syscall.S        | 35 +++++++++-------
 arch/parisc/kernel/traps.c          | 37 +++--------------
 arch/parisc/kernel/unwind.c         | 43 ++++++++++++++------
 12 files changed, 113 insertions(+), 137 deletions(-)
