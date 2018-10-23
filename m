Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBE2C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D077E207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJqXW7Wo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D077E207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeJWT7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:59:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46918 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeJWT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:59:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id i4-v6so1284630wrr.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=WjueJowDytlJYQa8wtMIBp6VV8khkHltQlTQl13wtBI=;
        b=RJqXW7Wo8rAEXwTC55uS2AYPyuos0sgufBlFYT/c0V7X0CofuUoMTZYD1DuNHdUoMm
         7mwpFb0Qss7bHX2PUAF7LvnO0VFAPAjZub6vpaMj9lR08dMiBSUyjaR3p8dXAKABdlQh
         MPfwvzYFWuE4z6hK4BGlUqZsZr4rjWVeLtPPyAcj88fMH73vcNwPZ/HXFgEAaxJvINYV
         GIXfV0IIXWeCxas09k7sFra2X2b1qFiBXlkJvBh6PdI4Qmnwsp4d5xlGRBr+RikR4fl9
         BOKunU3HgWAeU1pDAktwOURUMDBFuJzMDrdIZERGTaO/0HThAXXnEPRv3W9XEomNwgeG
         +5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=WjueJowDytlJYQa8wtMIBp6VV8khkHltQlTQl13wtBI=;
        b=l9DXhwyx1HZtIPWIZNwkyM/rWvLGM031JzPtbjrLcL6N8hsXGp1NAbNNxf7IuGGi1s
         6xvBFmAnTcN7tZvzckuF0cKA6IWlNNfV1Vp/wrqiqioeuxVny8mRbFt+s/NRumeRTTvB
         61Z/5+BkF40FER5TfkvSWf+rnRqgkNthmC473vxfrd4s4o6q0Q2FYPnmnRERqCTnkl5y
         yo1vXw6fNfKj24Yl5T/omET0Aj6OJzVeXMttJ+m4I6Orqd9D4NFi2UHGbEy7owfEs48n
         S1G82/TxZBtNu2x6Yn4lHBPUCQz0gHnGMakO1VwpucqzCoNIc7GRGX3Dby+I+/3qWhpA
         xuSw==
X-Gm-Message-State: ABuFfoiiAQ+iPxcfTX2VquK1zDoX7d6zp6IxhpHIlmhzGTpiERImilBC
        MFTJGq0p+LoZ2dtocfHz/pw=
X-Google-Smtp-Source: ACcGV60A5VQw1+pnxIM5k3Yr50y8hLXCLjMTv58z4UEjWu6qAxRvwkXGf3bAtAOYRUYdBU9Yn/FG3w==
X-Received: by 2002:adf:da43:: with SMTP id r3-v6mr51334082wrl.221.1540294604841;
        Tue, 23 Oct 2018 04:36:44 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x8-v6sm2409748wrd.54.2018.10.23.04.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 04:36:44 -0700 (PDT)
Date:   Tue, 23 Oct 2018 13:36:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cpu changes for v4.20
Message-ID: <20181023113642.GA80151@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cpu-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cpu-for-linus

   # HEAD: 995d5f64b62f20f05b8e0972f07ec4d6c23333c9 tools/cpupower: Add Hygon Dhyana support

The main changes in this cycle were:

 - Add support for the "Dhyana" x86 CPUs by Hygon: these are licensed 
   based on the AMD Zen architecture, and are built and sold in China, 
   for domestic datacenter use. The code is pretty close to AMD support, 
   mostly with a few quirks and enumeration differences. (Pu Wen)

 - Enable CPUID support on Cyrix 6x86/6x86L processors.


  out-of-topic modifications in x86-cpu-for-linus:
  --------------------------------------------------
  MAINTAINERS                        # c9661c1e80b6: x86/cpu: Create Hygon Dhyana
  drivers/acpi/acpi_pad.c            # 7377ed4bd56e: ACPI: Add Hygon Dhyana suppo
  drivers/acpi/processor_idle.c      # 7377ed4bd56e: ACPI: Add Hygon Dhyana suppo
  drivers/cpufreq/acpi-cpufreq.c     # cc9690cfc7a3: cpufreq: Add Hygon Dhyana su
  drivers/cpufreq/amd_freq_sensitivity.c# cc9690cfc7a3: cpufreq: Add Hygon Dhyana su
  include/linux/pci_ids.h            # c6babb5806b7: x86/pci, x86/amd_nb: Add Hyg
  tools/power/cpupower/utils/cpufreq-info.c# 995d5f64b62f: tools/cpupower: Add Hygon Dh
  tools/power/cpupower/utils/helpers/amd.c# 995d5f64b62f: tools/cpupower: Add Hygon Dh
  tools/power/cpupower/utils/helpers/cpuid.c# 995d5f64b62f: tools/cpupower: Add Hygon Dh
  tools/power/cpupower/utils/helpers/helpers.h# 995d5f64b62f: tools/cpupower: Add Hygon Dh
  tools/power/cpupower/utils/helpers/misc.c# 995d5f64b62f: tools/cpupower: Add Hygon Dh
  tools/power/cpupower/utils/idle_monitor/mperf_monitor.c# 995d5f64b62f: tools/cpupower: Add Hygon Dh

 Thanks,

	Ingo

------------------>
Matthew Whitehead (2):
      x86/CPU: Use correct macros for Cyrix calls
      x86/CPU: Change query logic so CPUID is enabled before testing

Pu Wen (16):
      x86/cpu: Create Hygon Dhyana architecture support file
      x86/cpu: Get cache info and setup cache cpumap for Hygon Dhyana
      x86/cpu/mtrr: Support TOP_MEM2 and get MTRR number
      x86/smpboot: Do not use BSP INIT delay and MWAIT to idle on Dhyana
      x86/events: Add Hygon Dhyana support to PMU infrastructure
      x86/alternative: Init ideal_nops for Hygon Dhyana
      x86/amd_nb: Check vendor in AMD-only functions
      x86/pci, x86/amd_nb: Add Hygon Dhyana support to PCI and northbridge
      x86/apic: Add Hygon Dhyana support
      x86/bugs: Add Hygon Dhyana to the respective mitigation machinery
      x86/mce: Add Hygon Dhyana support to the MCA infrastructure
      x86/kvm: Add Hygon Dhyana support to KVM
      x86/xen: Add Hygon Dhyana support to Xen
      ACPI: Add Hygon Dhyana support
      cpufreq: Add Hygon Dhyana support
      tools/cpupower: Add Hygon Dhyana support


 MAINTAINERS                                        |   6 +
 arch/x86/Kconfig.cpu                               |  14 +
 arch/x86/events/amd/core.c                         |   4 +
 arch/x86/events/amd/uncore.c                       |  20 +-
 arch/x86/events/core.c                             |   4 +
 arch/x86/include/asm/amd_nb.h                      |   3 +
 arch/x86/include/asm/cacheinfo.h                   |   1 +
 arch/x86/include/asm/kvm_emulate.h                 |   4 +
 arch/x86/include/asm/mce.h                         |   2 +
 arch/x86/include/asm/processor.h                   |   3 +-
 arch/x86/include/asm/virtext.h                     |   5 +-
 arch/x86/kernel/alternative.c                      |   4 +
 arch/x86/kernel/amd_nb.c                           |  49 ++-
 arch/x86/kernel/apic/apic.c                        |   7 +
 arch/x86/kernel/apic/probe_32.c                    |   1 +
 arch/x86/kernel/cpu/Makefile                       |   1 +
 arch/x86/kernel/cpu/bugs.c                         |   4 +-
 arch/x86/kernel/cpu/cacheinfo.c                    |  31 +-
 arch/x86/kernel/cpu/common.c                       |   5 +-
 arch/x86/kernel/cpu/cpu.h                          |   1 +
 arch/x86/kernel/cpu/cyrix.c                        |   2 +-
 arch/x86/kernel/cpu/hygon.c                        | 408 +++++++++++++++++++++
 arch/x86/kernel/cpu/mcheck/mce-severity.c          |   3 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |  20 +-
 arch/x86/kernel/cpu/mtrr/cleanup.c                 |   3 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c                    |   2 +-
 arch/x86/kernel/cpu/perfctr-watchdog.c             |   2 +
 arch/x86/kernel/smpboot.c                          |   4 +-
 arch/x86/kvm/emulate.c                             |  11 +-
 arch/x86/pci/amd_bus.c                             |   6 +-
 arch/x86/xen/pmu.c                                 |  12 +-
 drivers/acpi/acpi_pad.c                            |   1 +
 drivers/acpi/processor_idle.c                      |   1 +
 drivers/cpufreq/acpi-cpufreq.c                     |   5 +
 drivers/cpufreq/amd_freq_sensitivity.c             |   9 +-
 include/linux/pci_ids.h                            |   2 +
 tools/power/cpupower/utils/cpufreq-info.c          |   6 +-
 tools/power/cpupower/utils/helpers/amd.c           |   4 +-
 tools/power/cpupower/utils/helpers/cpuid.c         |   8 +-
 tools/power/cpupower/utils/helpers/helpers.h       |   2 +-
 tools/power/cpupower/utils/helpers/misc.c          |   2 +-
 .../cpupower/utils/idle_monitor/mperf_monitor.c    |   3 +-
 42 files changed, 635 insertions(+), 50 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/hygon.c
