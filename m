Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937572-2-1673563789353301269
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937571; b=LarCy/a3g9ZBi+bNW3jH//QOz5iPbWwb7yAYU73/MHnwNxgGpN
    +M/8M5d3iyUg5oLpUX1O7w73r2JdRVpQ4s3YoYGgM9rFNFHe57WSrafhi9+BPWij
    bldfivO48qv2oqODYGaD8hTKCcgx04bN7wez4I0qvCYH/ussBD24P68t7XqSZI8d
    /KD5ZL3OMc34EMXZkitZhVHtETaEpOF/6cIeUFsMbvRinQIwCGve0MiKnp7IrfaD
    YOMT+O4s+1As1YuC+QvQncCuvT5nIOMK9mozfov9n8vEHbyXvK12oDB3ehW38Qhg
    qxTGz55aRBWcDHF7xVRa6975pqAzkT2CjW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526937571; bh=wHBIW9ceA9nb9quU8OrjdHP95A4TPG
    OE/fBxWXPpe8I=; b=FdzS7tUJRe412Hjaiz4IJho+eJCHBY5sDrBFJbuj2yN034
    FUWIa/QiUma9dQoKuWZHtMiMhQrMQBYkFs4kXLkLqkELDbpjcCsj1vIKsXZ9rEki
    d+8WTmxNcA6I7asNnSAPAD0ZhzvbDDWBd38bUUBdbkC7SCU838LOqLkrxXbGhkJ0
    TfGzGCeQiA1nWyJguZyrMfyCc6t3uYKG3lcx9BijDzc0gqKYZFiyUKB4SKLTUtBZ
    gKULIugrvHyvZur6UnrFUXED3/UNIwkY+FmH4zBuq7WCLIrKM1bDQvUXUtgwYgp4
    RD0WYZYd3VFkEqJ8+qiYf/nZxOa0ZwS94BKHaMog==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=J3abEnAF x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=J3abEnAF x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIKA0WodYkGzZf/iwophFrFI7BQT0m1c7qF7KC2Ox7hh+HMHTussZ2wpVOiaSsIpIXgbv8afdPXi64e+QAUYGR7LITPmZlxpKN8QWQzjrP09aGBvTgVy
    kqYHiNH0EqBk7r4iUj11EgUcG9ZCtoxivO1hl9xGwcXVr2Ti0AxBpLLv8Zj1IP7pH3Yf6PGySnRQW7+lg8oJDZE0hCL8RRjbiHHK9PrMIPpZtIbZX754+Csw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=GkQz-2DCOnYA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=zd2uoN0lAAAA:8
    a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8 a=Z4Rwk6OoAAAA:8 a=SRrdq9N9AAAA:8
    a=iox4zFpeAAAA:8 a=omOdbC7AAAAA:8 a=LM7KSAFEAAAA:8 a=yMhMjlubAAAA:8
    a=n2GhSfulAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
    a=pGLkceISAAAA:8 a=xjQjg--fAAAA:8 a=LpQP-O61AAAA:8 a=meVymXHHAAAA:8
    a=wMNdZWldAAAA:8 a=7CQSdrXTAAAA:8 a=20KFwNOVAAAA:8 a=J2zoVyZDAAAA:8
    a=neCYrQnpCd1fm0tuHzwA:9 a=hvGoCZDEtqXY8eC7:21 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=xmb-EsYY8bH0VWELuYED:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=baC4JDFNLZpnPwus_NF9:22 a=Zl4URWtPEaU_QppK162s:22
    a=9NqWk_7B-uqI6kdQTXIl:22 a=cvBusfyB2V15izCimMoJ:22 a=L4vkcYpMSA5nFlNZ2tk3:22
    a=pioyyrs4ZptJ924tMmac:22 a=2JgSa4NbpEOStq-L5dxp:22 a=FUarYpL4UH3yWsho8X8J:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752933AbeEUVTY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752755AbeEUVTU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:19:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/95] 4.14.43-stable review
Date: Mon, 21 May 2018 23:10:50 +0200
Message-Id: <20180521210447.219380974@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.43-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.43-rc1
X-KernelTest-Deadline: 2018-05-23T21:05+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.43 release.
There are 95 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue May 22 21:04:09 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.43-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.43-rc1

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Rename SSBD_NO to SSB_NO

Tom Lendacky <thomas.lendacky@amd.com>
    KVM: SVM: Implement VIRT_SPEC_CTRL support for SSBD

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG

Thomas Gleixner <tglx@linutronix.de>
    x86/bugs: Rework spec_ctrl base and mask logic

Thomas Gleixner <tglx@linutronix.de>
    x86/bugs: Remove x86_spec_ctrl_set()

Thomas Gleixner <tglx@linutronix.de>
    x86/bugs: Expose x86_spec_ctrl_base directly

Borislav Petkov <bp@suse.de>
    x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Rework speculative_store_bypass_update()

Tom Lendacky <thomas.lendacky@amd.com>
    x86/speculation: Add virtualized speculative store bypass disable support

Thomas Gleixner <tglx@linutronix.de>
    x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Handle HT correctly on AMD

Thomas Gleixner <tglx@linutronix.de>
    x86/cpufeatures: Add FEATURE_ZEN

Thomas Gleixner <tglx@linutronix.de>
    x86/cpufeatures: Disentangle SSBD enumeration

Thomas Gleixner <tglx@linutronix.de>
    x86/cpufeatures: Disentangle MSR_SPEC_CTRL enumeration from IBRS

Borislav Petkov <bp@suse.de>
    x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP

Thomas Gleixner <tglx@linutronix.de>
    KVM: SVM: Move spec control call after restore of GS

Jim Mattson <jmattson@google.com>
    x86/cpu: Make alternative_msr_write work for 32-bit code

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Fix the parameters alignment and missing void

Jiri Kosina <jkosina@suse.cz>
    x86/bugs: Make cpu_show_common() static

Jiri Kosina <jkosina@suse.cz>
    x86/bugs: Fix __ssb_select_mitigation() return type

Borislav Petkov <bp@suse.de>
    Documentation/spec_ctrl: Do some minor cleanups

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    proc: Use underscores for SSBD in 'status'

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Rename _RDS to _SSBD

Kees Cook <keescook@chromium.org>
    x86/speculation: Make "seccomp" the default mode for Speculative Store Bypass

Thomas Gleixner <tglx@linutronix.de>
    seccomp: Move speculation migitation control to arch code

Kees Cook <keescook@chromium.org>
    seccomp: Add filter flag to opt-out of SSB mitigation

Thomas Gleixner <tglx@linutronix.de>
    seccomp: Use PR_SPEC_FORCE_DISABLE

Thomas Gleixner <tglx@linutronix.de>
    prctl: Add force disable speculation

Kees Cook <keescook@chromium.org>
    x86/bugs: Make boot modes __ro_after_init

Kees Cook <keescook@chromium.org>
    seccomp: Enable speculation flaw mitigations

Kees Cook <keescook@chromium.org>
    proc: Provide details on speculation flaw mitigations

Kees Cook <keescook@chromium.org>
    nospec: Allow getting/setting on non-current task

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Add prctl for Speculative Store Bypass mitigation

Thomas Gleixner <tglx@linutronix.de>
    x86/process: Allow runtime control of Speculative Store Bypass

Thomas Gleixner <tglx@linutronix.de>
    prctl: Add speculation control prctls

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Create spec-ctrl.h to avoid include hell

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs/AMD: Add support to disable RDS on Fam[15,16,17]h if requested

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Whitelist allowed SPEC_CTRL MSR values

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs/intel: Set proper CPU features and setup RDS

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/cpufeatures: Add X86_FEATURE_RDS

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Expose /sys/../spec_store_bypass

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs, KVM: Support the combination of guest and host IBRS

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Read SPEC_CTRL MSR during boot and re-use reserved bits

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Concentrate bug reporting into a separate function

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Concentrate bug detection into a separate function

Linus Torvalds <torvalds@linux-foundation.org>
    x86/nospec: Simplify alternative_msr_write()

Liu Bo <bo.liu@linux.alibaba.com>
    btrfs: fix reading stale metadata blocks after degraded raid1 mounts

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix delalloc inodes invalidation during transaction abort

Nikolay Borisov <nborisov@suse.com>
    btrfs: Split btrfs_del_delalloc_inode into 2 functions

Anand Jain <anand.jain@oracle.com>
    btrfs: fix crash when trying to resume balance without the resume flag

Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
    btrfs: property: Set incompat flag if lzo/zstd compression is set

Robbie Ko <robbieko@synology.com>
    Btrfs: send, fix invalid access to commit roots due to concurrent snapshotting

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix xattr loss after power failure

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8770/1: kprobes: Prohibit probing on optimized_callback

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8769/1: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed

Dexuan Cui <decui@microsoft.com>
    tick/broadcast: Use for_each_cpu() specially on UP kernels

Dmitry Safonov <dima@arista.com>
    x86/mm: Drop TS_COMPAT on 64-bit exec() syscall

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32' definition for mixed mode

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys: Do not special case protection key 0

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys: Override pkey when moving away from PROT_EXEC

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: remove indirect branch from do_softirq_own_stack

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qdio: don't release memory in qdio_setup_irq()

Hendrik Brueckner <brueckner@linux.ibm.com>
    s390/cpum_sf: ensure sample frequency of perf event attributes is non-zero

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qdio: fix access to uninitialized qdio_q fields

Michel Thierry <michel.thierry@intel.com>
    drm/i915/gen9: Add WaClearHIZ_WM_CHICKEN3 for bxt and glk

Pavel Tatashin <pasha.tatashin@oracle.com>
    mm: don't allow deferred pages with NEED_PER_CPU_KM

Ross Zwisler <ross.zwisler@linux.intel.com>
    radix tree: fix multi-order iteration race

Matthew Wilcox <mawilcox@microsoft.com>
    lib/test_bitmap.c: fix bitmap optimisation tests to report errors correctly

Haneen Mohammed <hamohammed.sa@gmail.com>
    drm: Match sysfs name in link removal to link creation

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Alexander Monakov <amonakov@ispras.ru>
    i2c: designware: fix poll-after-enable regression

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    netfilter: nf_socket: Fix out of bounds access in nf_sk_lookup_slow_v{4,6}

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: can't fail after linking rule into active rule list

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: free set name in error path

Jann Horn <jannh@google.com>
    tee: shm: fix use-after-free via temporarily dropped reference

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flush_tlb{_all}

Halil Pasic <pasic@linux.vnet.ibm.com>
    vfio: ccw: fix cleanup if cp_prefetch fails

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    powerpc: Don't preempt_disable() in show_cpuinfo()

Andre Przywara <andre.przywara@arm.com>
    KVM: arm/arm64: VGIC/ITS: protect kvm_read_guest() calls with SRCU lock

Andre Przywara <andre.przywara@arm.com>
    KVM: arm/arm64: VGIC/ITS save/restore: protect kvm_read_guest() calls

Kamal Dasu <kdasu.kdev@gmail.com>
    spi: bcm-qspi: Always read and set BSPI_MAST_N_BOOT_CTRL

Kamal Dasu <kdasu.kdev@gmail.com>
    spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    spi: pxa2xx: Allow 64-bit DMA

Wenwen Wang <wang6495@umn.edu>
    ALSA: control: fix a redundant-copy issue

Hans de Goede <hdegoede@redhat.com>
    ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist

Federico Cuello <fedux@fedux.com.ar>
    ALSA: usb: mixer: volume quirk for CM102-A+/102S+

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: fix bad unlock balance during stub_probe()

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: fix NULL-ptr deref and use-after-free errors

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: run rebind from exit when module is removed

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: delete device from busid_table after rebind

Shuah Khan <shuah@kernel.org>
    usbip: usbip_host: refine probe and disconnect debug msgs to be useful


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-devices-system-cpu |   1 +
 Documentation/admin-guide/kernel-parameters.txt    |  45 +++
 Documentation/userspace-api/index.rst              |   1 +
 Documentation/userspace-api/spec_ctrl.rst          |  94 +++++
 Makefile                                           |   4 +-
 arch/arm/include/asm/assembler.h                   |  10 +
 arch/arm/include/asm/kvm_mmu.h                     |  16 +
 arch/arm/kernel/traps.c                            |   5 +-
 arch/arm/lib/getuser.S                             |  10 +
 arch/arm/probes/kprobes/opt-arm.c                  |   4 +-
 arch/arm64/include/asm/kvm_mmu.h                   |  16 +
 arch/powerpc/kernel/setup-common.c                 |  11 -
 arch/powerpc/platforms/powernv/opal-nvram.c        |  14 +-
 arch/s390/kernel/irq.c                             |   5 +-
 arch/s390/kernel/perf_cpum_sf.c                    |   4 +
 arch/x86/boot/compressed/eboot.c                   |   6 +-
 arch/x86/include/asm/cpufeatures.h                 |  18 +-
 arch/x86/include/asm/kvm_host.h                    |   2 +-
 arch/x86/include/asm/mmu_context.h                 |   2 +-
 arch/x86/include/asm/msr-index.h                   |   9 +
 arch/x86/include/asm/nospec-branch.h               |  43 ++-
 arch/x86/include/asm/pkeys.h                       |  18 +-
 arch/x86/include/asm/spec-ctrl.h                   |  80 +++++
 arch/x86/include/asm/thread_info.h                 |   4 +-
 arch/x86/kernel/cpu/amd.c                          |  22 ++
 arch/x86/kernel/cpu/bugs.c                         | 397 ++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c                       |  77 +++-
 arch/x86/kernel/cpu/cpu.h                          |   2 +
 arch/x86/kernel/cpu/intel.c                        |   3 +
 arch/x86/kernel/process.c                          | 146 ++++++++
 arch/x86/kernel/process_64.c                       |   1 +
 arch/x86/kernel/smpboot.c                          |   5 +
 arch/x86/kvm/cpuid.c                               |  21 +-
 arch/x86/kvm/svm.c                                 |  66 ++--
 arch/x86/kvm/vmx.c                                 |  32 +-
 arch/x86/kvm/x86.c                                 |  13 +-
 arch/x86/mm/pkeys.c                                |  21 +-
 arch/x86/xen/mmu.c                                 |   4 +-
 arch/x86/xen/mmu_pv.c                              |   4 +-
 drivers/base/cpu.c                                 |   8 +
 drivers/gpu/drm/drm_drv.c                          |   2 +-
 drivers/gpu/drm/i915/i915_reg.h                    |   3 +
 drivers/gpu/drm/i915/intel_engine_cs.c             |   4 +
 drivers/i2c/busses/i2c-designware-master.c         |   5 +-
 drivers/s390/cio/qdio_setup.c                      |  12 +-
 drivers/s390/cio/vfio_ccw_cp.c                     |  13 +-
 drivers/spi/spi-bcm-qspi.c                         |  28 +-
 drivers/spi/spi-pxa2xx.h                           |   2 +-
 drivers/tee/tee_shm.c                              |   5 +-
 drivers/usb/usbip/stub.h                           |   2 +
 drivers/usb/usbip/stub_dev.c                       |  43 ++-
 drivers/usb/usbip/stub_main.c                      | 105 +++++-
 fs/btrfs/ctree.c                                   |  22 +-
 fs/btrfs/ctree.h                                   |   2 +
 fs/btrfs/disk-io.c                                 |  26 +-
 fs/btrfs/inode.c                                   |  13 +-
 fs/btrfs/props.c                                   |  12 +-
 fs/btrfs/tree-log.c                                |   7 +
 fs/btrfs/volumes.c                                 |   9 +
 fs/proc/array.c                                    |  25 ++
 include/linux/cpu.h                                |   2 +
 include/linux/efi.h                                |   8 +-
 include/linux/nospec.h                             |  10 +
 include/linux/sched.h                              |  10 +-
 include/linux/seccomp.h                            |   5 +-
 include/trace/events/xen.h                         |  16 -
 include/uapi/linux/prctl.h                         |  12 +
 include/uapi/linux/seccomp.h                       |   5 +-
 kernel/seccomp.c                                   |  21 +-
 kernel/sys.c                                       |  23 ++
 kernel/time/tick-broadcast.c                       |   8 +
 lib/radix-tree.c                                   |   6 +-
 lib/test_bitmap.c                                  |  21 +-
 mm/Kconfig                                         |   1 +
 net/ipv4/netfilter/nf_socket_ipv4.c                |   6 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                |   6 +-
 net/netfilter/nf_tables_api.c                      |  67 ++--
 sound/core/control_compat.c                        |   3 +-
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/usb/mixer.c                                  |   8 +
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  22 +-
 virt/kvm/arm/vgic/vgic-its.c                       |  19 +-
 virt/kvm/arm/vgic/vgic-v3.c                        |   4 +-
 83 files changed, 1557 insertions(+), 312 deletions(-)
