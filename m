Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D937C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F257E204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gP0rSb3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F257E204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbeJWU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:26:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45101 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJWU05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:26:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id f17-v6so1377909wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=g1CWf4WNifOkh20ul9UwY6MMi17ZDwkk54WcXxDKvsk=;
        b=gP0rSb3cposJqq7xEighI+ZpOxgklQLEn1SI0W85k2Zm8n6kgiSHvanupsJiOhtF2a
         01cEWbI6Ddpn8H8xWQfUWmoEfBmZcJbTpPMhP6+VH+Cu4QggsFlsfFQpDzKpNvptsVFr
         jGYsgZIUmZHihLv2x2/w7nquhTbY85KruQ/0Uq0IDkkhYsIgsqA5HvOD0I5HcXyYVtbD
         q+gDa7WD/ofrEYLSaFrF1EWPMJnN3DkVe4zkbC+1dG5ph2Qv/idEFRXiMpYvtNRe2bBT
         4V73GlN6In8+R+mF8c1431P0Hrh233e9u94upJ2z0q5AFiBidewB+KftR93bFUOxNAVR
         8ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=g1CWf4WNifOkh20ul9UwY6MMi17ZDwkk54WcXxDKvsk=;
        b=BqIvlhnPFFXtDg8Ul3In0++K6GuPMgsEzy0pEhfDESXjsSZHx8tfYa4LxwfVpNgzB5
         S4l4OWlTAmpIQTW2tPTmzszJMLdy/J1uN7KQuVtZO96WudVifTbrIPPmPWZjzEdI+up6
         kwiKJ0DHnOvV2YFKfIJIu3WNMh4Qt9S6tqpheLLUa42wO9aTrAxEP3cBdfEvZJgtpsi4
         6OyGbu34g67O0l2HV8u76jDYLmYh/wUfX+uE9GP84wqhwN9cCR6Phm8otlhYcYeyQL0b
         mGy1f6LipRt9TwfxejoHgKAgkragP75GffOPXAV00BeIEZreJ03LrnVs86dgNAkE9+V1
         yo7A==
X-Gm-Message-State: AGRZ1gJjBgGo2tOdTZytau1lXg4ORN4J3eUlE+YOT4SNBWcFiUQHVBzz
        LawdFKp7PR/r4/weah07Do4=
X-Google-Smtp-Source: AJdET5e/srzOqdAs3rjCz17MU+6ZtWixSimKRd6HhoW7wwd7ar8wjLBINMASBal7LFAYu9xg/B8seQ==
X-Received: by 2002:a5d:558b:: with SMTP id i11-v6mr6009397wrv.38.1540296223563;
        Tue, 23 Oct 2018 05:03:43 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 2-v6sm1764952wro.96.2018.10.23.05.03.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 05:03:42 -0700 (PDT)
Date:   Tue, 23 Oct 2018 14:03:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mm changes for v4.20
Message-ID: <20181023120340.GA38083@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-mm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

   # HEAD: 977e4be5eb714c48a67afc26a6c477f24130a1f2 x86/stackprotector: Remove the call to boot_init_stack_canary() from cpu_startup_entry()

Lots of changes in this cycle:

 - Lots of CPA optimizations and related cleanups (Thomas Gleixner, Peter Zijstra)

 - Make lazy TLB mode even lazier (Rik van Riel)

 - Fault handler cleanups and improvements (Dave Hansen)

 - kdump, vmcore: Enable kdumping encrypted memory with AMD SME enabled 
   (Lianbo Jiang)

 - Clean up VM layout documentation (Baoquan He, Ingo Molnar)

 - ... plus misc other fixes and enhancements.

Thanks,

	Ingo

================>

Baoquan He (2):
      x86/KASLR: Update KERNEL_IMAGE_SIZE description
      x86/mm/doc: Clean up the x86-64 virtual memory layout descriptions

Bjorn Helgaas (3):
      x86/kexec: Correct KEXEC_BACKUP_SRC_END off-by-one error
      resource: Include resource end in walk_*() interfaces
      resource: Fix find_next_iomem_res() iteration issue

Borislav Petkov (2):
      proc/vmcore: Fix i386 build error of missing copy_oldmem_page_encrypted()
      resource: Clean it up a bit

Christophe Leroy (1):
      x86/stackprotector: Remove the call to boot_init_stack_canary() from cpu_startup_entry()

Dave Hansen (9):
      x86/mm: Clarify hardware vs. software "error_code"
      x86/mm: Break out kernel address space handling
      x86/mm: Break out user address space handling
      x86/mm: Add clarifying comments for user addr space
      x86/mm: Fix exception table comments
      x86/mm: Add vsyscall address helper
      x86/mm/vsyscall: Consider vsyscall page part of user address space
      x86/mm: Remove spurious fault pkey check
      x86/mm: Kill stray kernel fault handling comment

Ingo Molnar (1):
      x86/mm/doc: Enhance the x86-64 virtual memory layout descriptions

Lianbo Jiang (4):
      x86/ioremap: Add an ioremap_encrypted() helper
      kexec: Allocate decrypted control pages for kdump if SME is enabled
      iommu/amd: Remap the IOMMU device table with the memory encryption mask for kdump
      kdump, proc/vmcore: Enable kdumping encrypted memory with SME enabled

Peter Zijlstra (9):
      x86/mm/cpa: Use flush_tlb_all()
      x86/mm/cpa: Move flush_tlb_all()
      x86/mm/cpa: Unconditionally avoid WBINDV when we can
      x86/mm/cpa: Use flush_tlb_kernel_range()
      x86/mm/cpa: Move CLFLUSH test into cpa_flush_range()
      x86/mm/cpa: Move CLFLUSH test into cpa_flush_array()
      x86/mm/cpa: Factor common code between cpa_flush_*()
      x86/mm/cpa: Optimize __cpa_flush_range()
      x86/mm: Page size aware flush_tlb_mm_range()

Rik van Riel (7):
      x86/mm/tlb: Always use lazy TLB mode
      x86/mm/tlb: Restructure switch_mm_irqs_off()
      smp: use __cpumask_set_cpu in on_each_cpu_cond
      smp,cpumask: introduce on_each_cpu_cond_mask
      x86/mm/tlb: Add freed_tables argument to flush_tlb_mm_range
      x86/mm/tlb: Add freed_tables element to flush_tlb_info
      x86/mm/tlb: Make lazy TLB mode lazier

Takuya Yamamoto (1):
      x86/mm: Fix typo in comment

Thomas Gleixner (12):
      x86/mm/init32: Mark text and rodata RO in one go
      x86/mm/cpa: Split, rename and clean up try_preserve_large_page()
      x86/mm/cpa: Rework static_protections()
      x86/mm/cpa: Allow range check for static protections
      x86/mm/cpa: Add debug mechanism
      x86/mm/cpa: Add large page preservation statistics
      x86/mm/cpa: Avoid static protection checks on unmap
      x86/mm/cpa: Add sanity check for existing mappings
      x86/mm/cpa: Optimize same protection check
      x86/mm/cpa: Do the range check early
      x86/mm/cpa: Avoid the 4k pages check completely
      x86/mm: Do not warn about PCI BIOS W+X mappings

 Documentation/x86/x86_64/mm.txt      | 171 ++++++++++++++++++++++++++++-------------
 arch/x86/Kconfig                     |   8 ++
 arch/x86/include/asm/io.h            |   3 +-
 arch/x86/include/asm/kexec.h         |   2 +-
 arch/x86/include/asm/page_64_types.h |  15 ++--
 arch/x86/include/asm/tlb.h           |  21 ++++--
 arch/x86/include/asm/tlbflush.h      |  33 +++-----
 arch/x86/kernel/crash_dump_64.c      |  60 ++++++++++-----
 arch/x86/kernel/ldt.c                |   2 +-
 arch/x86/kernel/vm86_32.c            |   2 +-
 arch/x86/mm/dump_pagetables.c        |  35 +++++++--
 arch/x86/mm/extable.c                |   2 +-
 arch/x86/mm/fault.c                  | 288 +++++++++++++++++++++++++++++++++++++++++++++------------------------
 arch/x86/mm/init_32.c                |  23 +-----
 arch/x86/mm/ioremap.c                |  24 ++++--
 arch/x86/mm/pageattr.c               | 627 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------
 arch/x86/mm/tlb.c                    | 167 ++++++++++++++++++++++++----------------
 arch/x86/xen/smp_pv.c                |   2 +
 drivers/iommu/amd_iommu_init.c       |  14 +++-
 fs/proc/vmcore.c                     |  34 +++++++--
 include/linux/crash_dump.h           |   4 +
 include/linux/smp.h                  |   4 +
 kernel/kexec_core.c                  |   6 ++
 kernel/resource.c                    | 141 ++++++++++++++++------------------
 kernel/sched/idle.c                  |  15 ----
 kernel/sched/sched.h                 |   1 -
 kernel/smp.c                         |  19 +++--
 kernel/up.c                          |  14 +++-
 mm/pgtable-generic.c                 |   1 +
 29 files changed, 1118 insertions(+), 620 deletions(-)
