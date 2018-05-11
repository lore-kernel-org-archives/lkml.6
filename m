Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeEKR35 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 13:29:57 -0400
Received: from foss.arm.com ([217.140.101.70]:45146 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeEKR34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 13:29:56 -0400
Date: Fri, 11 May 2018 18:30:20 +0100
From: Will Deacon <will.deacon@arm.com>
To: torvalds@linux-foundation.org
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64: fixes for -rc5
Message-ID: <20180511173020.GG4954@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these arm64 fixes for -rc5. There's a small memblock accounting
problem when freeing the initrd and a Spectre-v2 mitigation for NVIDIA Denver
CPUs which just requires a match on the CPU ID register.

Thanks,

Will

--->8

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 0583a4ef05987f7e0f3a7bdd3365e5dc36ca306d:

  arm64: capabilities: Add NVIDIA Denver CPU to bp_harden list (2018-05-09 14:28:28 +0100)

----------------------------------------------------------------
arm64 fixes:

- Mitigate Spectre-v2 for NVIDIA Denver CPUs

- Free memblocks corresponding to freed initrd area

----------------------------------------------------------------
CHANDAN VN (1):
      arm64: To remove initrd reserved area entry from memblock

David Gilhooley (2):
      arm64: Add MIDR encoding for NVIDIA CPUs
      arm64: capabilities: Add NVIDIA Denver CPU to bp_harden list

 arch/arm64/include/asm/cputype.h | 6 ++++++
 arch/arm64/kernel/cpu_errata.c   | 1 +
 arch/arm64/mm/init.c             | 4 +++-
 3 files changed, 10 insertions(+), 1 deletion(-)
