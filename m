Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1465196-1518185782-2-17329464836550449469
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
    t=1518185781; b=m1PO7gXIz5BrnQh+dzykcsBxpjfLNpbU17NwGEfw0vie83G
    BRHPRA4D3iIe8rclgm8z3cqAg0y0XppqbvrL0eNKaZMUwXnnobA+9xSdeSSB4EJT
    HiuxBGJ1qILzTCSim2j2Hp+NCaTw4cT6/tGJpiKGLGE9fcxl1TCLEn6tGJoOEMxj
    Ewt/q0Dg6U/q7kbXkQvimVveNaY55w/wNaPoOradXvM8hlcueFf4kRFHHbmTLAQf
    Nuh1JbaTq25iFFZU+lKrsy1OxoH5RymBaJhuN1JMoM4AVTkrufbHcEk/BZ8O006A
    XiWpPfzDqKKzRM4WvwycRl2JK90oWjVGJuIGlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1518185781; bh=Xmv3iLUTdZah3eRWk6cAGq4c50
    6WzP9+hZleXie8S2g=; b=fiRZjdw2yQOHfIKtbnDKh0G5im72A7+6e7NUZjV43i
    Q58FMTuk4mA1ACHqGnTNLIsO9dEZfkH06ICXaLSixhqopynunAFqCzpx4lnpwAki
    KBoSYmbrMISSqd1DaBHNVCKyv4tJTmwKOpCCvi3NsB9Lh7jM7Wzp3luf2/DARJna
    8GbP+5djWZMNwxhwXqAt3vLF8n6HjYc6URt4SktF+pHmtf5Onmbt0e5M8K2JgePi
    oiwfYWz37HQ4zgZXivMCiVTXGiiQJG1RHrYAB8K0AncHxOcpjLsR1DA0PGHDU2oj
    tao7em8irg3C4YAw0dJaul/g9Yl8F5JapdymeN+W1Q8w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbeBIOQE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 09:16:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752331AbeBINk5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 08:40:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/92] 4.9.81-stable review
Date: Fri,  9 Feb 2018 14:38:29 +0100
Message-Id: <20180209133931.211869118@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.81-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.81-rc1
X-KernelTest-Deadline: 2018-02-11T13:39+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.81 release.
There are 92 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb 11 13:39:04 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.81-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.81-rc1

Borislav Petkov <bp@suse.de>
    x86/microcode: Do the family check first

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    drm: rcar-du: Fix race condition when disabling planes at CRTC stop

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    drm: rcar-du: Use the VBK interrupt for vblank events

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: avoid duplicate free_irq()

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    ASoC: rsnd: don't call free_irq() on Parent SSI

Julian Scheel <julian@jusst.de>
    ASoC: simple-card: Fix misleading error message

Robert Baronescu <robert.baronescu@nxp.com>
    crypto: tcrypt - fix S/G table for test_aead_speed()

KarimAllah Ahmed <karahmed@amazon.de>
    KVM/SVM: Allow direct access to MSR_IA32_SPEC_CTRL

KarimAllah Ahmed <karahmed@amazon.de>
    KVM/VMX: Allow direct access to MSR_IA32_SPEC_CTRL

KarimAllah Ahmed <karahmed@amazon.de>
    KVM/VMX: Emulate MSR_IA32_ARCH_CAPABILITIES

Ashok Raj <ashok.raj@intel.com>
    KVM/x86: Add IBPB support

Paolo Bonzini <pbonzini@redhat.com>
    KVM: VMX: make MSR bitmaps per-VCPU

Paolo Bonzini <pbonzini@redhat.com>
    KVM: VMX: introduce alloc_loaded_vmcs

Jim Mattson <jmattson@google.com>
    KVM: nVMX: Eliminate vmcs02 pool

David Matlack <dmatlack@google.com>
    KVM: nVMX: mark vmcs12 pages dirty on L2 exit

David Hildenbrand <david@redhat.com>
    KVM: nVMX: vmx_complete_nested_posted_interrupt() can't fail

David Hildenbrand <david@redhat.com>
    KVM: nVMX: kmap() can't fail

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

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/paravirt: Remove 'noreplace-paravirt' cmdline option

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

Eric Biggers <ebiggers@google.com>
    KEYS: encrypted: fix buffer overread in valid_master_desc()

Takashi Iwai <tiwai@suse.de>
    b43: Add missing MODULE_FIRMWARE()

Jesse Chan <jc@linux.com>
    media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Borislav Petkov <bp@suse.de>
    x86/microcode/AMD: Do not load when running on a hypervisor

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/asm: Fix inline asm call constraints for GCC 4.4

Eric Dumazet <edumazet@google.com>
    soreuseport: fix mem leak in reuseport_add_sock()

Martin KaFai Lau <kafai@fb.com>
    ipv6: Fix SO_REUSEPORT UDP socket with implicit sk_ipv6only

Paolo Abeni <pabeni@redhat.com>
    cls_u32: add missing RCU annotation.

Neal Cardwell <ncardwell@google.com>
    tcp_bbr: fix pacing_gain to always be unity when using lt_bw

Jason Wang <jasowang@redhat.com>
    vhost_net: stop device during reset owner

Li RongQing <lirongqing@baidu.com>
    tcp: release sk_frag.page in tcp_disconnect

Chunhao Lin <hau@realtek.com>
    r8169: fix RTL8168EP take too long to complete driver initialization.

Kristian Evensen <kristian.evensen@gmail.com>
    qmi_wwan: Add support for Quectel EP06

Junxiao Bi <junxiao.bi@oracle.com>
    qlcnic: fix deadlock bug

Eric Dumazet <edumazet@google.com>
    net: igmp: add a missing rcu locking section

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    ip6mr: fix stale iterator

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    serial: core: mark port as initialized after successful IRQ change

Hugh Dickins <hughd@google.com>
    kaiser: allocate pgd with order 0 when pti=off

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pti: Make unpoison of pgd for trusted boot work for real

Hugh Dickins <hughd@google.com>
    kaiser: fix intel_bts perf crashes

Jesse Chan <jc@linux.com>
    ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    pinctrl: pxa: pxa2xx: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    auxdisplay: img-ascii-lcd: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Allow control of RFI flush via debugfs

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Wire up cpu_show_meltdown()

Oliver O'Halloran <oohall@gmail.com>
    powerpc/powernv: Check device-tree for RFI flush settings

Michael Neuling <mikey@neuling.org>
    powerpc/pseries: Query hypervisor for RFI flush settings

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Support disabling RFI flush with no_rfi_flush and nopti

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Add support for RFI flush of L1-D cache

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Convert slb_miss_common to use RFI_TO_USER/KERNEL

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Convert the syscall exit path to use RFI_TO_USER/KERNEL

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Convert fast_exception_return to use RFI_TO_USER/KERNEL

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64: Add macros for annotating the destination of rfid/hrfid

Michael Neuling <mikey@neuling.org>
    powerpc/pseries: Add H_GET_CPU_CHARACTERISTICS flags & wrapper


-------------

Diffstat:

 Documentation/kernel-parameters.txt                |   2 -
 Documentation/speculation.txt                      |  90 +++
 Makefile                                           |   4 +-
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/include/asm/exception-64e.h           |   6 +
 arch/powerpc/include/asm/exception-64s.h           |  53 ++
 arch/powerpc/include/asm/feature-fixups.h          |  15 +
 arch/powerpc/include/asm/hvcall.h                  |  17 +
 arch/powerpc/include/asm/paca.h                    |  10 +
 arch/powerpc/include/asm/plpar_wrappers.h          |  14 +
 arch/powerpc/include/asm/setup.h                   |  13 +
 arch/powerpc/kernel/asm-offsets.c                  |   4 +
 arch/powerpc/kernel/entry_64.S                     |  30 +-
 arch/powerpc/kernel/exceptions-64s.S               | 108 ++-
 arch/powerpc/kernel/setup_64.c                     | 139 ++++
 arch/powerpc/kernel/vmlinux.lds.S                  |   9 +
 arch/powerpc/lib/feature-fixups.c                  |  42 ++
 arch/powerpc/platforms/powernv/setup.c             |  50 ++
 arch/powerpc/platforms/pseries/setup.c             |  35 +
 arch/x86/entry/common.c                            |   9 +-
 arch/x86/entry/entry_32.S                          |   3 +-
 arch/x86/entry/entry_64.S                          | 134 +---
 arch/x86/entry/syscall_64.c                        |   7 +-
 arch/x86/events/intel/bts.c                        |  44 +-
 arch/x86/include/asm/asm-prototypes.h              |   4 +-
 arch/x86/include/asm/asm.h                         |   4 +-
 arch/x86/include/asm/barrier.h                     |  28 +
 arch/x86/include/asm/cpufeature.h                  |   7 +-
 arch/x86/include/asm/cpufeatures.h                 |  22 +-
 arch/x86/include/asm/disabled-features.h           |   3 +-
 arch/x86/include/asm/intel-family.h                |   7 +-
 arch/x86/include/asm/msr-index.h                   |  12 +
 arch/x86/include/asm/msr.h                         |   3 +-
 arch/x86/include/asm/nospec-branch.h               |  91 +--
 arch/x86/include/asm/pgalloc.h                     |  11 -
 arch/x86/include/asm/pgtable.h                     |   6 +
 arch/x86/include/asm/processor.h                   |   2 -
 arch/x86/include/asm/required-features.h           |   3 +-
 arch/x86/include/asm/syscall.h                     |   6 +-
 arch/x86/include/asm/thread_info.h                 |   3 +-
 arch/x86/include/asm/uaccess.h                     |  15 +-
 arch/x86/include/asm/uaccess_32.h                  |  12 +-
 arch/x86/include/asm/uaccess_64.h                  |  12 +-
 arch/x86/kernel/alternative.c                      |  28 +-
 arch/x86/kernel/cpu/bugs.c                         | 128 +++-
 arch/x86/kernel/cpu/common.c                       |  70 +-
 arch/x86/kernel/cpu/intel.c                        |  66 ++
 arch/x86/kernel/cpu/microcode/core.c               |  47 +-
 arch/x86/kernel/cpu/scattered.c                    |   2 -
 arch/x86/kernel/process_64.c                       |   4 +-
 arch/x86/kernel/ptrace.c                           |   2 +-
 arch/x86/kernel/signal.c                           |   2 +-
 arch/x86/kernel/tboot.c                            |  10 +
 arch/x86/kvm/cpuid.c                               |  21 +-
 arch/x86/kvm/cpuid.h                               |  31 +
 arch/x86/kvm/emulate.c                             |  10 +-
 arch/x86/kvm/svm.c                                 | 116 ++++
 arch/x86/kvm/vmx.c                                 | 763 +++++++++++----------
 arch/x86/kvm/x86.c                                 |   1 +
 arch/x86/lib/Makefile                              |   1 +
 arch/x86/lib/getuser.S                             |  10 +
 arch/x86/lib/retpoline.S                           |  57 +-
 arch/x86/lib/usercopy_32.c                         |   8 +-
 crypto/tcrypt.c                                    |   6 +-
 drivers/auxdisplay/img-ascii-lcd.c                 |   4 +
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |  55 +-
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |   8 +
 drivers/media/platform/soc_camera/soc_scale_crop.c |   4 +
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |  18 +-
 drivers/net/ethernet/realtek/r8169.c               |   4 +-
 drivers/net/usb/qmi_wwan.c                         |   1 +
 drivers/net/wireless/broadcom/b43/main.c           |  10 +
 drivers/pinctrl/pxa/pinctrl-pxa2xx.c               |   4 +
 drivers/tty/serial/serial_core.c                   |   2 +
 drivers/vhost/net.c                                |   1 +
 include/linux/fdtable.h                            |   5 +-
 include/linux/init.h                               |   9 +-
 include/linux/module.h                             |   9 +
 include/linux/nospec.h                             |  72 ++
 kernel/module.c                                    |  11 +
 net/core/sock_reuseport.c                          |  35 +-
 net/ipv4/igmp.c                                    |   4 +
 net/ipv4/tcp.c                                     |   6 +
 net/ipv4/tcp_bbr.c                                 |   6 +-
 net/ipv6/af_inet6.c                                |  11 +-
 net/ipv6/ip6mr.c                                   |   1 +
 net/sched/cls_u32.c                                |  12 +-
 net/wireless/nl80211.c                             |   9 +-
 scripts/mod/modpost.c                              |   9 +
 security/keys/encrypted-keys/encrypted.c           |  31 +-
 sound/soc/codecs/pcm512x-spi.c                     |   4 +
 sound/soc/generic/simple-card.c                    |   8 +-
 sound/soc/sh/rcar/ssi.c                            |   5 +
 93 files changed, 2034 insertions(+), 797 deletions(-)
