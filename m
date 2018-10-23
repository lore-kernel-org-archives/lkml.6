Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD27C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3ED20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 12:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHt1ahhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3ED20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeJWUgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 16:36:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34566 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJWUgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 16:36:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id l6-v6so1457081wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=SY9sm4mtyJg6CY9D6kkJ3F0Bl2eNlSoO/9jF3Woxy94=;
        b=AHt1ahhPJ6EYrAXc8SgDKz97a5lMgpRQTxLYZYjmoFEgP24cTxh2jQZEi84ZDbDDEr
         Ox1qeEtRtTwgUD8y71Qw7qL1P1jqx3W1/G2cCeRoa55tsghITBWZNGq/6RGCgGY3Zhab
         cF/ihmtgBZHZPg75NQ1g1zJn3CHnySmRSNYgFiokcdP/ZyE1qucQUjyEJhGlg9j0Q7X/
         opeiVr41GCJeKjNvdDqPGcoOjo9vhP4LbL12CzJ9MA6oxzUqd8OED5EOuqfjFq+3KiAq
         tXkbaaXVI5R0vpfQIB9WKr7+nuGoONMLRf3HDALENLRpAzbKctEWTvDCHtszqC0JvVFr
         xIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=SY9sm4mtyJg6CY9D6kkJ3F0Bl2eNlSoO/9jF3Woxy94=;
        b=JJisRzQbbvVFI/nhM0w0K/LPV/wYv/k//1kHk40syvSIJR555f7P+i3JPEL5DvFKka
         a0GANgptraK2RhO0t8IW7CuaTLfL47XaFBL7Ye3qFOl1wDcdfruYzFA2PH7L/f6SC0j2
         8Yjl7/aHMyJzgrL77C7PbHOcdpnfPnzQ3ibKkakTytWbYQlaYq9zGBJV2hZjU8xq+Qhi
         XxHg0By9LAgsAUP3c4hQ5RBR0US2yK9t7qL4cs24Xge2qqQWIZf6jcxUqp2OUVkzLKgU
         M7I97jmhFTkFAmhQeJMNz61MsL74tomz0ED9O8BlmNYvghuPrk6YF+5wZiEL42QTHfCq
         9PZQ==
X-Gm-Message-State: ABuFfogTZV3x1RM33JZPkhevEvfzYhbskJH/KWjm6opRc84zWnmjdrz7
        mUsOPvBzV5fBIHfUr7abgh0=
X-Google-Smtp-Source: ACcGV60v4Wl0CvUk2DePauxhjA/soi1DfH0F/nAYXMiwyK3X+KF6iUrNufgGcVCSbl2F1kn9P/Hnwg==
X-Received: by 2002:a5d:6902:: with SMTP id t2-v6mr49578404wru.323.1540296816972;
        Tue, 23 Oct 2018 05:13:36 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id p7-v6sm1688703wrt.10.2018.10.23.05.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 05:13:36 -0700 (PDT)
Date:   Tue, 23 Oct 2018 14:13:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>
Subject: [GIT PULL] x86/paravirt changes for v4.20
Message-ID: <20181023121333.GA114100@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-paravirt-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-paravirt-for-linus

   # HEAD: 3a025de64bf89c84a79909069e3c24ad9e710d27 x86/hyperv: Enable PV qspinlock for Hyper-V

Two main changes:

 - Remove no longer parts of the paravirt infrastructure and put large 
   quantities of paravirt ops under a new config option PARAVIRT_XXL=y,
   which is selected by XEN_PV only. (Joergen Gross)

 - Enable PV spinlocks on Hyperv (Yi Sun)


 Thanks,

	Ingo

  out-of-topic modifications in x86-paravirt-for-linus:
  -------------------------------------------------------
  arch/arm/include/asm/paravirt.h    # 5c83511bdb98: x86/paravirt: Use a single o
  arch/arm/kernel/paravirt.c         # 5c83511bdb98: x86/paravirt: Use a single o
  arch/arm64/include/asm/paravirt.h  # 5c83511bdb98: x86/paravirt: Use a single o
  arch/arm64/kernel/paravirt.c       # 5c83511bdb98: x86/paravirt: Use a single o

------------------>
Borislav Petkov (1):
      x86/paravirt: Clean up native_patch()

Juergen Gross (17):
      x86/xen: Move pv irq related functions under CONFIG_XEN_PV umbrella
      x86/xen: Move pv specific parts of arch/x86/xen/mmu.c to mmu_pv.c
      x86/xen: Link platform-pci-unplug.o only if CONFIG_XEN_PVHVM
      x86/xen: Add SPDX identifier in arch/x86/xen files
      x86/paravirt: Make paravirt_patch_call() and paravirt_patch_jmp() static
      x86/paravirt: Remove clobbers parameter from paravirt patch functions
      x86/paravirt: Remove clobbers from struct paravirt_patch_site
      x86/paravirt: Use a single ops structure
      x86/paravirt: Remove unused paravirt bits
      x86/paravirt: Introduce new config option PARAVIRT_XXL
      x86/paravirt: Move items in pv_info under PARAVIRT_XXL umbrella
      x86/paravirt: Move the Xen-only pv_cpu_ops under the PARAVIRT_XXL umbrella
      x86/paravirt: Move the pv_irq_ops under the PARAVIRT_XXL umbrella
      x86/paravirt: Move the Xen-only pv_mmu_ops under the PARAVIRT_XXL umbrella
      x86/paravirt: Remove unneeded mmu related paravirt ops bits
      x86/xen: Make xen_reservation_lock static
      x86/paravirt: Prevent redefinition of SAVE_FLAGS macro

Yi Sun (2):
      x86/hyperv: Add GUEST_IDLE_MSR support
      x86/hyperv: Enable PV qspinlock for Hyper-V


 Documentation/admin-guide/kernel-parameters.txt |   5 +
 arch/arm/include/asm/paravirt.h                 |   9 +-
 arch/arm/kernel/paravirt.c                      |   4 +-
 arch/arm/xen/enlighten.c                        |  34 --
 arch/arm64/include/asm/paravirt.h               |   9 +-
 arch/arm64/kernel/paravirt.c                    |   4 +-
 arch/x86/Kconfig                                |   4 +
 arch/x86/boot/compressed/misc.h                 |   1 +
 arch/x86/entry/entry_32.S                       |   8 +-
 arch/x86/entry/entry_64.S                       |   8 +-
 arch/x86/hyperv/Makefile                        |   4 +
 arch/x86/hyperv/hv_spinlock.c                   |  88 +++++
 arch/x86/hyperv/mmu.c                           |   4 +-
 arch/x86/include/asm/debugreg.h                 |   2 +-
 arch/x86/include/asm/desc.h                     |   4 +-
 arch/x86/include/asm/fixmap.h                   |   2 +-
 arch/x86/include/asm/hyperv-tlfs.h              |   5 +
 arch/x86/include/asm/irqflags.h                 |  16 +-
 arch/x86/include/asm/mmu_context.h              |   4 +-
 arch/x86/include/asm/mshyperv.h                 |   2 +
 arch/x86/include/asm/msr.h                      |   4 +-
 arch/x86/include/asm/paravirt.h                 | 415 +++++++++++-------------
 arch/x86/include/asm/paravirt_types.h           |  82 +++--
 arch/x86/include/asm/pgalloc.h                  |   2 +-
 arch/x86/include/asm/pgtable-3level_types.h     |   2 +-
 arch/x86/include/asm/pgtable.h                  |   7 +-
 arch/x86/include/asm/processor.h                |   4 +-
 arch/x86/include/asm/ptrace.h                   |   2 +-
 arch/x86/include/asm/segment.h                  |   2 +-
 arch/x86/include/asm/special_insns.h            |   4 +-
 arch/x86/kernel/alternative.c                   |   2 +-
 arch/x86/kernel/asm-offsets.c                   |  13 +-
 arch/x86/kernel/asm-offsets_64.c                |   9 +-
 arch/x86/kernel/cpu/common.c                    |   4 +-
 arch/x86/kernel/cpu/mshyperv.c                  |  14 +
 arch/x86/kernel/cpu/vmware.c                    |   4 +-
 arch/x86/kernel/head_64.S                       |   2 +-
 arch/x86/kernel/kvm.c                           |  19 +-
 arch/x86/kernel/kvmclock.c                      |   4 +-
 arch/x86/kernel/paravirt-spinlocks.c            |  15 +-
 arch/x86/kernel/paravirt.c                      | 316 +++++++++---------
 arch/x86/kernel/paravirt_patch_32.c             |  87 +++--
 arch/x86/kernel/paravirt_patch_64.c             |  97 +++---
 arch/x86/kernel/tsc.c                           |   2 +-
 arch/x86/kernel/vsmp_64.c                       |  26 +-
 arch/x86/mm/mem_encrypt_identity.c              |   1 +
 arch/x86/xen/Kconfig                            |   1 +
 arch/x86/xen/Makefile                           |  41 ++-
 arch/x86/xen/efi.c                              |  14 +-
 arch/x86/xen/enlighten.c                        |   2 +
 arch/x86/xen/enlighten_hvm.c                    |   2 +
 arch/x86/xen/enlighten_pv.c                     |  31 +-
 arch/x86/xen/grant-table.c                      |  25 +-
 arch/x86/xen/irq.c                              |   2 +-
 arch/x86/xen/mmu.c                              | 188 +----------
 arch/x86/xen/mmu_hvm.c                          |   2 +-
 arch/x86/xen/mmu_pv.c                           | 168 +++++++++-
 arch/x86/xen/p2m.c                              |   2 +
 arch/x86/xen/pci-swiotlb-xen.c                  |   2 +
 arch/x86/xen/platform-pci-unplug.c              |  18 +-
 arch/x86/xen/spinlock.c                         |  11 +-
 arch/x86/xen/time.c                             |   4 +-
 arch/x86/xen/vdso.h                             |   2 +
 arch/x86/xen/xen-pvh.S                          |  15 +-
 drivers/xen/time.c                              |   2 +-
 include/xen/events.h                            |   2 +
 include/xen/interface/memory.h                  |   6 -
 include/xen/xen-ops.h                           | 133 +++++---
 68 files changed, 1023 insertions(+), 1006 deletions(-)
 create mode 100644 arch/x86/hyperv/hv_spinlock.c

