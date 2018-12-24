Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACAAEC64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64AE021773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545692441;
	bh=p6lE/cenyn788coVwHeycyluK6PEVcc0tua5XLnlQmQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uEhcTx4SRRqLIgaGnudwqW+5geNSllRh+WH2BZivRYnXruMdNpBy/pzyV4HokLqGA
	 YM+VGXHLEbyjjMQcdMHEBHDI8pTV0secEKF8PmDp7jGaHsK9GWi/SodM/aGLzUALuB
	 Bhx50mMfwKOC2J6VfT7LSEbSUxGkb9yRUh2Hil1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbeLXXAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 18:00:39 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35063 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXXAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 18:00:39 -0500
Received: by mail-wm1-f44.google.com with SMTP id t200so651542wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lNqpWJTwoyR40WLk6yV6sbgTLviFeYqn5NRS3neQwWU=;
        b=Ui4i1v0D/l1OYfBmZiHddOh1oVi81yQR1BHYIhmL2+hX28gpyCCSJEtzrAK2NCiVs1
         zhOKHFEdYFViV4xy3i7NQI4K1J8si/nDVe0ykpsKrJyltvA0VAhY/oEpKYB63/BAZL6h
         wunrrCULK2bM7HVB4T3xiUSH+etlQLWpVFHT9eT7ZxEstLVXUWa1nGqCOoZXkpTO5I1N
         ZfxYRS7bUMQPgnXJTOYO+PS2Or8raF1wrLMTCJWkqar0GURzDwfjTTZzlwE3aSXoraEa
         9TLrav7AUbeQ7U1APSS1IV1wAjYkkCffkb8x7FzTZ2D0wYVPpkajUG/z0pvkgLrsoshL
         aGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=lNqpWJTwoyR40WLk6yV6sbgTLviFeYqn5NRS3neQwWU=;
        b=QyZF2bnsvZ6QcNzkQQagexIKkAapi7s5/VZ69h+EasXt16MiodR3/b95F7ccuGwmbw
         XiNRTH0ez0c1X4Rg8L2upapBmQjMoaili9QrCpywLPyCIzYHfAPfsTNU/3ZYeshj5kt6
         TVLxEgoLNXYZjlJO0sqcGykuw4fTDC3hH78cUALpU8w42duCforaYcyLUM1QzlmVeVrt
         AoJRd+lFs7J9yCTWx3ULzEAEC8PQjYVDdXQjxQPSFDGTN4vAixpviPhOdp6HJwIQ4dbX
         oYUOewMfqSf47QppQfn8MoGBd8/rNNuuU4aidqhtS9QUr4uoUUQhSdSpeSPFzNBnoirC
         zfrQ==
X-Gm-Message-State: AJcUukcew/o0d9gq5iOJl/vgHe+es/4p4m/kWiN06miBYsr9LQ0CyyQE
        ral+ywarLx1pBftRg1eQSDw=
X-Google-Smtp-Source: AFSGD/Vdio7Tiiw9cHConYshQkr5fRgDWQTfazAeHElQe4ExVJNeL+GIBF9zf+1DYYXsRKBRrMi2Dw==
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr13157048wmd.98.1545692435976;
        Mon, 24 Dec 2018 15:00:35 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r12sm30098096wrq.3.2018.12.24.15.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 15:00:35 -0800 (PST)
Date:   Tue, 25 Dec 2018 00:00:33 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/cleanups for v4.21
Message-ID: <20181224230033.GA65522@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-cleanups-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-cleanups-for-linus

   # HEAD: 4b1bacab61aa252d15dde99cd0440a965bd863e5 x86/kprobes: Remove trampoline_handler() prototype

Misc cleanups.

  out-of-topic modifications in x86-cleanups-for-linus:
  -------------------------------------------------------
  include/acpi/cppc_acpi.h           # ad3bc25a3207: x86/kernel: Fix more -Wmissi
  include/linux/ftrace.h             # 89f579ce99f7: x86/headers: Fix -Wmissing-p
  include/linux/kexec.h              # 89f579ce99f7: x86/headers: Fix -Wmissing-p
  include/linux/kprobes.h            # ad3bc25a3207: x86/kernel: Fix more -Wmissi
  include/linux/of_fdt.h             # 89f579ce99f7: x86/headers: Fix -Wmissing-p
  include/linux/ptrace.h             # 89f579ce99f7: x86/headers: Fix -Wmissing-p

 Thanks,

	Ingo

------------------>
Borislav Petkov (5):
      x86/gart: Rewrite early_gart_iommu_check() comment
      x86/mce: Fix -Wmissing-prototypes warnings
      x86/traps: Complete prototype declarations
      x86/kernel: Fix more -Wmissing-prototypes warnings
      x86/kprobes: Remove trampoline_handler() prototype

Ingo Molnar (1):
      x86: Fix various typos in comments

Yafang Shao (1):
      x86/process: Avoid unnecessary NULL check in get_wchan()

Yi Wang (1):
      x86/headers: Fix -Wmissing-prototypes warning


 arch/x86/crypto/cast5_avx_glue.c                   |  2 +-
 arch/x86/crypto/cast6_avx_glue.c                   |  2 +-
 arch/x86/entry/common.c                            |  2 +-
 arch/x86/entry/vdso/vma.c                          |  2 +-
 arch/x86/events/intel/bts.c                        |  2 +-
 arch/x86/events/intel/core.c                       |  2 +-
 arch/x86/events/intel/ds.c                         |  2 +-
 arch/x86/events/intel/p4.c                         |  2 +-
 arch/x86/include/asm/alternative.h                 |  2 +-
 arch/x86/include/asm/cmpxchg.h                     |  2 +-
 arch/x86/include/asm/crash.h                       |  1 +
 arch/x86/include/asm/efi.h                         |  2 +-
 arch/x86/include/asm/irq.h                         |  7 +++
 arch/x86/include/asm/irq_work.h                    |  1 +
 arch/x86/include/asm/kvm_para.h                    |  1 +
 arch/x86/include/asm/paravirt.h                    |  5 ++
 arch/x86/include/asm/reboot.h                      |  1 +
 arch/x86/include/asm/setup.h                       |  3 ++
 arch/x86/include/asm/sighandling.h                 |  5 ++
 arch/x86/include/asm/smp.h                         |  6 +++
 arch/x86/include/asm/trace/exceptions.h            |  1 +
 arch/x86/include/asm/trace/irq_vectors.h           |  1 +
 arch/x86/include/asm/traps.h                       | 59 +++++++++++++---------
 arch/x86/include/asm/tsc.h                         |  1 +
 arch/x86/kernel/acpi/boot.c                        |  2 +-
 arch/x86/kernel/aperture_64.c                      | 25 +++++----
 arch/x86/kernel/apic/apic.c                        |  1 +
 arch/x86/kernel/apic/apic_flat_64.c                |  7 +--
 arch/x86/kernel/apic/vector.c                      |  1 +
 arch/x86/kernel/apic/x2apic_uv_x.c                 |  4 +-
 arch/x86/kernel/asm-offsets.c                      |  3 +-
 arch/x86/kernel/check.c                            |  3 +-
 arch/x86/kernel/cpu/amd.c                          |  1 +
 arch/x86/kernel/cpu/aperfmperf.c                   |  1 +
 arch/x86/kernel/cpu/bugs.c                         |  2 +
 arch/x86/kernel/cpu/cacheinfo.c                    |  1 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |  2 +-
 arch/x86/kernel/cpu/mcheck/mce_amd.c               |  5 +-
 arch/x86/kernel/cpu/mcheck/therm_throt.c           |  3 +-
 arch/x86/kernel/cpu/mcheck/threshold.c             |  3 +-
 arch/x86/kernel/cpu/scattered.c                    |  3 +-
 arch/x86/kernel/cpu/topology.c                     |  2 +
 arch/x86/kernel/crash.c                            |  1 +
 arch/x86/kernel/crash_dump_64.c                    |  2 +-
 arch/x86/kernel/devicetree.c                       |  1 +
 arch/x86/kernel/fpu/xstate.c                       |  2 +-
 arch/x86/kernel/jailhouse.c                        |  1 +
 arch/x86/kernel/kprobes/core.c                     |  2 +-
 arch/x86/kernel/process.c                          |  5 +-
 arch/x86/kernel/process_64.c                       |  2 +-
 arch/x86/kernel/quirks.c                           |  1 +
 arch/x86/kernel/sysfb_efi.c                        |  3 ++
 arch/x86/kernel/tracepoint.c                       |  2 +
 arch/x86/kvm/vmx.c                                 |  4 +-
 arch/x86/kvm/x86.c                                 |  2 +-
 arch/x86/mm/pageattr.c                             |  2 +-
 arch/x86/platform/ce4100/ce4100.c                  |  4 +-
 .../intel-mid/device_libs/platform_bcm43xx.c       |  2 +-
 .../intel-mid/device_libs/platform_mrfld_spidev.c  |  2 +-
 .../intel-mid/device_libs/platform_pcal9555a.c     |  2 +-
 arch/x86/platform/intel/iosf_mbi.c                 |  2 +-
 arch/x86/platform/olpc/olpc-xo1-sci.c              |  2 +-
 arch/x86/platform/uv/uv_nmi.c                      |  2 +-
 arch/x86/xen/setup.c                               |  2 +-
 include/acpi/cppc_acpi.h                           |  3 ++
 include/linux/ftrace.h                             |  3 ++
 include/linux/kexec.h                              |  1 +
 include/linux/kprobes.h                            |  3 ++
 include/linux/of_fdt.h                             |  1 +
 include/linux/ptrace.h                             |  1 +
 70 files changed, 165 insertions(+), 78 deletions(-)
