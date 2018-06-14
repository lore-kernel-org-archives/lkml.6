Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4D8E5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBCF20864
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="epulGyQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBCF20864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966263AbeFNOTd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:19:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966164AbeFNONF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:13:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 174F9208DD;
        Thu, 14 Jun 2018 14:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528985584;
        bh=zv9YUr+Y9z43RSpsmQ72orf8qTZnpDwGtnNm90cppE8=;
        h=From:To:Cc:Subject:Date:From;
        b=epulGyQsR2/1plvfsR6RPlzXubD7p3wsdfGp5PFORuJYWeSO8tgsCTp0eZvQJuP+c
         IOaLnZVG1oGuy5AjDWaJUVr2/lr7ZmkW7r1wI5AENxb7iJfkSMfbmi/GLHh3Km6hTW
         RhFb33+pvWDX02KRSOZ+qB/emWI2GehtoB45Wc2M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/24] 4.4.138-stable review
Date:   Thu, 14 Jun 2018 16:04:55 +0200
Message-Id: <20180614132724.483802160@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.138-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.138-rc1
X-KernelTest-Deadline: 2018-06-16T13:27+00:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.138 release.
There are 24 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Jun 16 13:27:15 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.138-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.138-rc1

Michael Ellerman <mpe@ellerman.id.au>
    crypto: vmx - Remove overly verbose printk from AES init routines

Johannes Wienke <languitar@semipol.de>
    Input: elan_i2c - add ELAN0612 (Lenovo v330 14IKB) ACPI ID

Ethan Lee <flibitijibibo@gmail.com>
    Input: goodix - add new ACPI id for GPD Win 2 touch screen

Paolo Bonzini <pbonzini@redhat.com>
    kvm: x86: use correct privilege level for sgdt/sidt/fxsave/fxrstor access

Gil Kupfer <gilkup@gmail.com>
    vmw_balloon: fixing double free when batching mode is off

Marek Szyprowski <m.szyprowski@samsung.com>
    serial: samsung: fix maxburst parameter for DMA transactions

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: pass kvm_vcpu to kvm_read_guest_virt and kvm_write_guest_virt_system

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: introduce linear_{read,write}_system

Linus Torvalds <torvalds@linux-foundation.org>
    Clarify (and fix) MAX_LFS_FILESIZE macros

Linus Walleij <linus.walleij@linaro.org>
    gpio: No NULL owner

Andy Lutomirski <luto@kernel.org>
    x86/crypto, x86/fpu: Remove X86_FEATURE_EAGER_FPU #ifdef from the crc32c code

Kevin Easton <kevin@guarana.org>
    af_key: Always verify length of provided sadb_key

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Fix math emulation in eager fpu mode

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Fix FNSAVE usage in eagerfpu mode

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Hard-disable lazy FPU mode

Borislav Petkov <bp@alien8.de>
    x86/fpu: Fix eager-FPU handling on legacy FPU machines

Yu-cheng Yu <yu-cheng.yu@intel.com>
    x86/fpu: Revert ("x86/fpu: Disable AVX when eagerfpu is off")

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Fix 'no387' regression

Andy Lutomirski <luto@kernel.org>
    x86/fpu: Default eagerfpu=on on all CPUs

yu-cheng yu <yu-cheng.yu@intel.com>
    x86/fpu: Disable AVX when eagerfpu is off

yu-cheng yu <yu-cheng.yu@intel.com>
    x86/fpu: Disable MPX when eagerfpu is off

Borislav Petkov <bp@suse.de>
    x86/cpufeature: Remove unused and seldomly used cpu_has_xx macros

Juergen Gross <jgross@suse.com>
    x86: Remove unused function cpu_has_ht_siblings()

yu-cheng yu <yu-cheng.yu@intel.com>
    x86/fpu: Fix early FPU command-line parsing


-------------

Diffstat:

 Makefile                                    |   4 +-
 arch/x86/crypto/chacha20_glue.c             |   2 +-
 arch/x86/crypto/crc32c-intel_glue.c         |   7 +-
 arch/x86/include/asm/cmpxchg_32.h           |   2 +-
 arch/x86/include/asm/cmpxchg_64.h           |   2 +-
 arch/x86/include/asm/cpufeature.h           |  39 +------
 arch/x86/include/asm/fpu/internal.h         |   6 +-
 arch/x86/include/asm/fpu/xstate.h           |   2 +-
 arch/x86/include/asm/kvm_emulate.h          |   6 +-
 arch/x86/include/asm/smp.h                  |   9 --
 arch/x86/include/asm/xor_32.h               |   2 +-
 arch/x86/kernel/cpu/amd.c                   |   4 +-
 arch/x86/kernel/cpu/common.c                |   4 +-
 arch/x86/kernel/cpu/intel.c                 |   3 +-
 arch/x86/kernel/cpu/intel_cacheinfo.c       |   6 +-
 arch/x86/kernel/cpu/mtrr/generic.c          |   2 +-
 arch/x86/kernel/cpu/mtrr/main.c             |   2 +-
 arch/x86/kernel/cpu/perf_event_amd.c        |   4 +-
 arch/x86/kernel/cpu/perf_event_amd_uncore.c |  11 +-
 arch/x86/kernel/fpu/core.c                  |  24 +++-
 arch/x86/kernel/fpu/init.c                  | 169 +++++++---------------------
 arch/x86/kernel/fpu/xstate.c                |   3 +-
 arch/x86/kernel/hw_breakpoint.c             |   6 +-
 arch/x86/kernel/smpboot.c                   |   2 +-
 arch/x86/kernel/traps.c                     |   1 -
 arch/x86/kernel/vm86_32.c                   |   4 +-
 arch/x86/kvm/emulate.c                      |  72 ++++++------
 arch/x86/kvm/vmx.c                          |  23 ++--
 arch/x86/kvm/x86.c                          |  51 ++++++---
 arch/x86/kvm/x86.h                          |   4 +-
 arch/x86/mm/setup_nx.c                      |   4 +-
 drivers/char/hw_random/via-rng.c            |   5 +-
 drivers/crypto/padlock-aes.c                |   2 +-
 drivers/crypto/padlock-sha.c                |   2 +-
 drivers/crypto/vmx/aes.c                    |   2 -
 drivers/crypto/vmx/aes_cbc.c                |   2 -
 drivers/crypto/vmx/aes_ctr.c                |   2 -
 drivers/crypto/vmx/ghash.c                  |   2 -
 drivers/gpio/gpiolib.c                      |   9 +-
 drivers/input/mouse/elan_i2c_core.c         |   1 +
 drivers/input/touchscreen/goodix.c          |   1 +
 drivers/iommu/intel_irq_remapping.c         |   2 +-
 drivers/misc/vmw_balloon.c                  |  23 ++--
 drivers/tty/serial/samsung.c                |   7 +-
 fs/btrfs/disk-io.c                          |   2 +-
 include/linux/fs.h                          |   4 +-
 net/key/af_key.c                            |  45 ++++++--
 47 files changed, 259 insertions(+), 332 deletions(-)


