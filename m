Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3071467-1517855011-2-1707837472625137918
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855009; b=QbV6YzPEQLQ3rzCFYbXXJrtNvJ6pc3mILSrYD7wibWUN/li
    FERHUl5aOs2VN4G3h0iclLX3ISmYM2CllYpmLNIAotiaZfV/T/bx06MFAj87Pwi1
    NQnSeUT6dBeqy49EhArPpjd3iLLkfITsgHqT9SBksuajMBzggYXzUvxRUxNYq6bM
    6fMKEoeMOpIxnCZliquJ9k3Zh+tjF7eiCuDmXYrj9kEoNAP6b9RwnEiOchEZugiM
    NMM2x82oBvTJl09CTl/OIL/6kYi6OoUeQje39BiSyhD3VZ+JWJtfiWFjZr98h2Lr
    E/nilOBZ/Ye50OMivqd1Ah1hWbw4/wOIozulS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517855009; bh=caiLz+TokZaJtp+3v1uBwQQ3Ct
    +8VACIru1qTlVIncE=; b=pCvHVBh21YJZzOEPw5WQPKy2VcS6/o94b7pfV/D5sj
    9AyayhBlgsTnA+4p5z6OD7EujL6blUhXQiZf0f3mYrNYm8YF199coAN+Lh1rD0aL
    pTiDzltwY/QKIPm7oSWIFPvR0Z3t0yhcJAy1Lx5wqhYs4jvtmabTHLcoTopbex5w
    xLBc8QQQqxmZZ96A4YrrhdWUzBAV9a6aqPHf8nqesb8B9YFvIwx1SyztWhFjT5Gg
    Kwaj9YgabdUb++IEEcM4LA7RWwih1Sy2/alNFDH7OKM40Evgz9d7CBMB1z3CuJ3l
    F2wAnP7sTdemw4KR88O8yztPKPK5xweUeOa1JNTNO0aw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752972AbeBESX0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:23:26 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50764 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeBESXZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:23:25 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/64] 4.14.18-stable review
Date: Mon,  5 Feb 2018 10:22:19 -0800
Message-Id: <20180205182138.571333346@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.18-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.18-rc1
X-KernelTest-Deadline: 2018-02-07T18:21+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.18 release.
There are 64 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb  7 18:21:22 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.18-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.18-rc1

Ian Abbott <abbotti@mev.co.uk>
    fpga: region: release of_parse_phandle nodes after use

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    serial: core: mark port as initialized after successful IRQ change

KarimAllah Ahmed <karahmed@amazon.de>
    KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL

KarimAllah Ahmed <karahmed@amazon.de>
    KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL

KarimAllah Ahmed <karahmed@amazon.de>
    KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES

Ashok Raj <ashok.raj@intel.com>
    KVM/x86: Add IBPB support

KarimAllah Ahmed <karahmed@amazon.de>
    KVM/x86: Update the reverse_cpuid list to include CPUID_7_EDX

Darren Kenny <darren.kenny@oracle.com>
    x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL

Arnd Bergmann <arnd@arndb.de>
    x86/pti: Mark constant arrays as __initconst

KarimAllah Ahmed <karahmed@amazon.de>
    x86/spectre: Simplify spectre_v2 command line parsing

David Woodhouse <dwmw@amazon.co.uk>
    x86/retpoline: Avoid retpolines for built-in __init functions

Dan Williams <dan.j.williams@intel.com>
    x86/kvm: Update spectre-v1 mitigation

Paolo Bonzini <pbonzini@redhat.com>
    KVM: VMX: make MSR bitmaps per-VCPU

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/paravirt: Remove 'noreplace-paravirt' cmdline option

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Use Indirect Branch Prediction Barrier in context switch

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpuid: Fix up "virtual" IBRS/IBPB/STIBP feature bits on Intel

Colin Ian King <colin.king@canonical.com>
    x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"

Dan Williams <dan.j.williams@intel.com>
    x86/spectre: Report get_user mitigation for spectre_v1

Dan Williams <dan.j.williams@intel.com>
    nl80211: Sanitize array index in parse_txq_params

Dan Williams <dan.j.williams@intel.com>
    vfs, fdtable: Prevent bounds-check bypass via speculative execution

Dan Williams <dan.j.williams@intel.com>
    x86/syscall: Sanitize syscall table de-references under speculation

Dan Williams <dan.j.williams@intel.com>
    x86/get_user: Use pointer masking to limit speculation

Dan Williams <dan.j.williams@intel.com>
    x86/uaccess: Use __uaccess_begin_nospec() and uaccess_try_nospec

Dan Williams <dan.j.williams@intel.com>
    x86/usercopy: Replace open coded stac/clac with __uaccess_{begin, end}

Dan Williams <dan.j.williams@intel.com>
    x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec

Dan Williams <dan.j.williams@intel.com>
    x86: Introduce barrier_nospec

Dan Williams <dan.j.williams@intel.com>
    x86: Implement array_index_mask_nospec

Dan Williams <dan.j.williams@intel.com>
    array_index_nospec: Sanitize speculative array de-references

Mark Rutland <mark.rutland@arm.com>
    Documentation: Document array_index_nospec

Andy Lutomirski <luto@kernel.org>
    x86/asm: Move 'status' from thread_struct to thread_info

Andy Lutomirski <luto@kernel.org>
    x86/entry/64: Push extra regs right away

Andy Lutomirski <luto@kernel.org>
    x86/entry/64: Remove the SYSCALL64 fast path

Dou Liyang <douly.fnst@cn.fujitsu.com>
    x86/spectre: Check CONFIG_RETPOLINE in command line parser

William Grant <william.grant@canonical.com>
    x86/mm: Fix overlap of i386 CPU_ENTRY_AREA with FIX_BTMAP

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Warn on stripped section symbol

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Add support for alternatives at the end of a section

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Improve retpoline alternative handling

Paolo Bonzini <pbonzini@redhat.com>
    KVM: VMX: introduce alloc_loaded_vmcs

Jim Mattson <jmattson@google.com>
    KVM: nVMX: Eliminate vmcs02 pool

Jesse Chan <jc@linux.com>
    ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    pinctrl: pxa: pxa2xx: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Linus Walleij <linus.walleij@linaro.org>
    iio: adc/accel: Fix up module licenses

Jesse Chan <jc@linux.com>
    auxdisplay: img-ascii-lcd: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Borislav Petkov <bp@suse.de>
    x86/speculation: Simplify indirect_branch_prediction_barrier()

Borislav Petkov <bp@alien8.de>
    x86/retpoline: Simplify vmexit_fill_RSB()

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeatures: Clean up Spectre v2 related CPUID flags

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu/bugs: Make retpoline module warning conditional

Borislav Petkov <bp@suse.de>
    x86/bugs: Drop one "mitigation" from dmesg

Borislav Petkov <bp@suse.de>
    x86/nospec: Fix header guards names

Borislav Petkov <bp@suse.de>
    x86/alternative: Print unadorned pointers

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Add basic IBPB (Indirect Branch Prediction Barrier) support

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeature: Blacklist SPEC_CTRL/PRED_CMD on early Spectre v2 microcodes

David Woodhouse <dwmw@amazon.co.uk>
    x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown

David Woodhouse <dwmw@amazon.co.uk>
    x86/msr: Add definitions for new speculation control MSRs

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeatures: Add AMD feature bits for Speculation Control

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeatures: Add Intel feature bits for Speculation Control

David Woodhouse <dwmw@amazon.co.uk>
    x86/cpufeatures: Add CPUID_7_EDX CPUID leaf

Andi Kleen <ak@linux.intel.com>
    module/retpoline: Warn about missing retpoline in module

Peter Zijlstra <peterz@infradead.org>
    KVM: VMX: Make indirect call speculation safe

Peter Zijlstra <peterz@infradead.org>
    KVM: x86: Make indirect calls in emulator speculation safe

Waiman Long <longman@redhat.com>
    x86/retpoline: Remove the esp/rsp thunk

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Allow control of RFI flush via debugfs

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Wire up cpu_show_meltdown()

Liu, Changcheng <changcheng.liu@intel.com>
    scripts/faddr2line: fix CROSS_COMPILE unset error


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt |   2 -
 Documentation/speculation.txt                   |  90 ++++
 Makefile                                        |   4 +-
 arch/powerpc/Kconfig                            |   1 +
 arch/powerpc/kernel/setup_64.c                  |  38 ++
 arch/x86/entry/common.c                         |   9 +-
 arch/x86/entry/entry_32.S                       |   3 +-
 arch/x86/entry/entry_64.S                       | 130 +----
 arch/x86/entry/syscall_64.c                     |   7 +-
 arch/x86/include/asm/asm-prototypes.h           |   4 +-
 arch/x86/include/asm/barrier.h                  |  28 +
 arch/x86/include/asm/cpufeature.h               |   7 +-
 arch/x86/include/asm/cpufeatures.h              |  22 +-
 arch/x86/include/asm/disabled-features.h        |   3 +-
 arch/x86/include/asm/fixmap.h                   |   6 +-
 arch/x86/include/asm/msr-index.h                |  12 +
 arch/x86/include/asm/msr.h                      |   3 +-
 arch/x86/include/asm/nospec-branch.h            |  86 +--
 arch/x86/include/asm/pgtable_32_types.h         |   5 +-
 arch/x86/include/asm/processor.h                |   5 +-
 arch/x86/include/asm/required-features.h        |   3 +-
 arch/x86/include/asm/syscall.h                  |   6 +-
 arch/x86/include/asm/thread_info.h              |   3 +-
 arch/x86/include/asm/tlbflush.h                 |   2 +
 arch/x86/include/asm/uaccess.h                  |  15 +-
 arch/x86/include/asm/uaccess_32.h               |   6 +-
 arch/x86/include/asm/uaccess_64.h               |  12 +-
 arch/x86/kernel/alternative.c                   |  28 +-
 arch/x86/kernel/cpu/bugs.c                      | 134 +++--
 arch/x86/kernel/cpu/common.c                    |  70 ++-
 arch/x86/kernel/cpu/intel.c                     |  66 +++
 arch/x86/kernel/cpu/scattered.c                 |   2 -
 arch/x86/kernel/process_64.c                    |   4 +-
 arch/x86/kernel/ptrace.c                        |   2 +-
 arch/x86/kernel/signal.c                        |   2 +-
 arch/x86/kvm/cpuid.c                            |  22 +-
 arch/x86/kvm/cpuid.h                            |   1 +
 arch/x86/kvm/emulate.c                          |   9 +-
 arch/x86/kvm/svm.c                              | 116 +++++
 arch/x86/kvm/vmx.c                              | 660 ++++++++++++++----------
 arch/x86/kvm/x86.c                              |   1 +
 arch/x86/lib/Makefile                           |   1 +
 arch/x86/lib/getuser.S                          |  10 +
 arch/x86/lib/retpoline.S                        |  57 +-
 arch/x86/lib/usercopy_32.c                      |   8 +-
 arch/x86/mm/tlb.c                               |  33 +-
 drivers/auxdisplay/img-ascii-lcd.c              |   4 +
 drivers/fpga/fpga-region.c                      |  13 +-
 drivers/iio/accel/kxsd9-i2c.c                   |   3 +
 drivers/iio/adc/qcom-vadc-common.c              |   4 +
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c            |   4 +
 drivers/tty/serial/serial_core.c                |   2 +
 include/linux/fdtable.h                         |   5 +-
 include/linux/init.h                            |   9 +-
 include/linux/module.h                          |   9 +
 include/linux/nospec.h                          |  72 +++
 kernel/module.c                                 |  11 +
 net/wireless/nl80211.c                          |   9 +-
 scripts/faddr2line                              |   8 +-
 scripts/mod/modpost.c                           |   9 +
 sound/soc/codecs/pcm512x-spi.c                  |   4 +
 tools/objtool/check.c                           |  89 ++--
 tools/objtool/orc_gen.c                         |   5 +
 63 files changed, 1355 insertions(+), 643 deletions(-)
