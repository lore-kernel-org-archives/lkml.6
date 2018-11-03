Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB10C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C8C20833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 23:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t6SnXuoo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8C8C20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeKDIWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 03:22:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41619 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeKDIWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 03:22:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id x12-v6so5500015wrw.8
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 16:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OSLZ26tqXLRTIuUThgJhzJRfbNmO0RwkZnZy5D1rSYU=;
        b=t6SnXuooEsp7edNuAUmkOoDxNpvuQN1RmaCQdDVF+XB2qAUx9lw9Tfg9UAW1mk5X77
         ZLLXbhxTVZvidaqrM+F+8vOljWGnOmVZVOXGtnH/wSLuJJ9yojUVWdO5ygrBnzjEPSp+
         vZj5KPVzW8+1SIYg7mgQBEhkjAExwXcGLiMui9sk7le1IgEDq2u4cE1ux4bZvt1a3J9s
         jy2mjOnpQJkFzynoqfgP7rXI+fvjR3eHigbwOQmma5+y7kGFTYPj++uHbgWzunA4nL3J
         B1iZeLsMOqvAVpxy3n4wyLJwbJo50KSgGrcteYf7PXXhfN36lo7K/J0B7wlh69ZneyNe
         PUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OSLZ26tqXLRTIuUThgJhzJRfbNmO0RwkZnZy5D1rSYU=;
        b=A8n8TPaAIfdQ4kp4fumSFXMeGPveDdxfcYOR/oDpCEOT0PA+zLhGF2TtETxuz4QV08
         A/wnD1M3dS4J9VTyYRNeCHHmV6pJpMsrWpuCRWA4CU7aPbsNVU+cK81ZdkaltwcXWSiu
         TbEvryJYeHmaMKa5SXPIaAaMNl4pYhp+LC9hFe2wtaM9E0zZSxAns/BOdtfuXgbKPPAC
         XxWhbA+qDBWWCf93lUCKjEkCuSrw5cxyQx1PPXwveLRvJ7iG9bcoefDf7jmAwEPtuFYp
         nts9mUaq4iCMokw5ruJYECyW1Tp46Anf59Yfz+Ywd19LZzF14h+LCGW549yLyU4y3pcG
         0wow==
X-Gm-Message-State: AGRZ1gIJ1Rrqy7fNqphroxPFBnqPaJBlUUUay7toFcWQX0m3AKrIsWGS
        eWNhSklv2KOteWwaubCorjk=
X-Google-Smtp-Source: AJdET5cCnRYMw8qNUooAgoGlAXRnmqhba9WKRJzcadG9uRR0M6MRpGWp1hNehWFwczuEWhWq65bKMw==
X-Received: by 2002:adf:9b12:: with SMTP id b18-v6mr14943951wrc.35.1541286590517;
        Sat, 03 Nov 2018 16:09:50 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 21-v6sm22672356wmv.5.2018.11.03.16.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 16:09:49 -0700 (PDT)
Date:   Sun, 4 Nov 2018 00:09:47 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20181103230947.GA95167@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 23a12ddee1ce28065b71f14ccc695b5a0c8a64ff Merge branch 'core/urgent' into x86/urgent, to pick up objtool fix

A number of fixes and some late updates:

  - make in_compat_syscall() behavior on x86-32 similar to other 
    platforms, this touches a number of generic files but is not intended 
    to impact non-x86 platforms.

  - objtool fixes

  - PAT preemption fix

  - paravirt fixes/cleanups

  - cpufeatures updates for new instructions

  - earlyprintk quirk

  - make microcode version in sysfs world-readable (it is already world-readable in procfs) 

  - minor cleanups and fixes

  out-of-topic modifications in x86-urgent-for-linus:
  -----------------------------------------------------
  drivers/firmware/efi/efivars.c     # 98f76206b335: compat: Cleanup in_compat_sy
  include/linux/compat.h             # a846446b1914: x86/compat: Adjust in_compat
  kernel/time/time.c                 # 98f76206b335: compat: Cleanup in_compat_sy
  net/xfrm/xfrm_state.c              # 98f76206b335: compat: Cleanup in_compat_sy
  net/xfrm/xfrm_user.c               # 98f76206b335: compat: Cleanup in_compat_sy
  tools/objtool/check.c              # 4a60aa05a063: objtool: Support per-functio
  tools/objtool/check.h              # 4a60aa05a063: objtool: Support per-functio
  tools/objtool/elf.c                # bcb6fb5da77c: objtool: Support GCC 9 cold 
                                   # 4a60aa05a063: objtool: Support per-functio
  tools/objtool/elf.h                # 4a60aa05a063: objtool: Support per-functio

 Thanks,

	Ingo

------------------>
Allan Xavier (1):
      objtool: Support per-function rodata sections

Dave Jiang (1):
      x86/numa_emulation: Fix uniform-split numa emulation

Dmitry Safonov (2):
      x86/compat: Adjust in_compat_syscall() to generic code under !COMPAT
      compat: Cleanup in_compat_syscall() callers

Feng Tang (1):
      x86/earlyprintk: Add a force option for pciserial device

Fenghua Yu (2):
      x86/cpufeatures: Enumerate MOVDIRI instruction
      x86/cpufeatures: Enumerate MOVDIR64B instruction

Jacek Tomaka (1):
      x86/microcode: Make revision and processor flags world-readable

Jordan Borgner (1):
      x86: Clean up 'sizeof x' => 'sizeof(x)'

Josh Poimboeuf (1):
      objtool: Support GCC 9 cold subfunction naming scheme

Juergen Gross (2):
      x86/paravirt: Remove GPL from pv_ops export
      x86/paravirt: Remove unused _paravirt_ident_32

Rasmus Villemoes (1):
      x86/traps: Use format string with panic() call

Sebastian Andrzej Siewior (1):
      x86/mm/pat: Disable preemption around __flush_tlb_all()


 Documentation/admin-guide/kernel-parameters.txt |  6 +++-
 arch/x86/boot/cpucheck.c                        |  2 +-
 arch/x86/boot/early_serial_console.c            |  4 +--
 arch/x86/boot/edd.c                             |  6 ++--
 arch/x86/boot/main.c                            |  4 +--
 arch/x86/boot/memory.c                          |  2 +-
 arch/x86/boot/regs.c                            |  2 +-
 arch/x86/boot/video-vesa.c                      |  6 ++--
 arch/x86/boot/video.c                           |  2 +-
 arch/x86/events/intel/core.c                    |  2 +-
 arch/x86/include/asm/compat.h                   |  9 +++++-
 arch/x86/include/asm/cpufeatures.h              |  2 ++
 arch/x86/include/asm/ftrace.h                   |  4 +--
 arch/x86/include/asm/paravirt_types.h           |  2 --
 arch/x86/include/asm/tlbflush.h                 |  6 ++++
 arch/x86/kernel/cpu/common.c                    |  4 +--
 arch/x86/kernel/cpu/mcheck/mce.c                |  2 +-
 arch/x86/kernel/cpu/microcode/core.c            |  4 +--
 arch/x86/kernel/cpu/mtrr/generic.c              |  2 +-
 arch/x86/kernel/cpu/mtrr/if.c                   |  6 ++--
 arch/x86/kernel/early_printk.c                  | 29 +++++++++++------
 arch/x86/kernel/head64.c                        |  2 +-
 arch/x86/kernel/msr.c                           |  8 ++---
 arch/x86/kernel/paravirt.c                      | 28 +++++------------
 arch/x86/kernel/paravirt_patch_32.c             | 18 ++++-------
 arch/x86/kernel/paravirt_patch_64.c             | 20 ++++--------
 arch/x86/kernel/process_64.c                    |  4 +--
 arch/x86/kernel/sys_x86_64.c                    | 11 ++++---
 arch/x86/kernel/traps.c                         |  2 +-
 arch/x86/kvm/emulate.c                          | 22 ++++++-------
 arch/x86/kvm/lapic.c                            |  2 +-
 arch/x86/kvm/x86.c                              | 42 ++++++++++++-------------
 arch/x86/mm/hugetlbpage.c                       |  4 +--
 arch/x86/mm/mmap.c                              |  2 +-
 arch/x86/mm/numa_emulation.c                    | 12 +++++--
 arch/x86/mm/pageattr.c                          |  6 +++-
 arch/x86/tools/relocs.c                         |  4 +--
 arch/x86/um/asm/elf.h                           |  2 +-
 drivers/firmware/efi/efivars.c                  | 16 +++-------
 include/linux/compat.h                          |  4 +--
 kernel/time/time.c                              |  2 +-
 net/xfrm/xfrm_state.c                           |  2 --
 net/xfrm/xfrm_user.c                            |  2 --
 tools/objtool/check.c                           | 38 ++++++++++++++++++----
 tools/objtool/check.h                           |  4 +--
 tools/objtool/elf.c                             |  3 +-
 tools/objtool/elf.h                             |  3 +-
 47 files changed, 198 insertions(+), 171 deletions(-)

