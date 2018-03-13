Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3628988-1520960697-2-12912213395677862703
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520960695; b=dASmoY0SE3CBBkRC2cr5NmZzBm22IWnxL2AiolMK+ow5KjZ
    sChbFPsbP3rp4Gii7tieVtA8/K6+cTqzg6sTZQ5PY59n32sklvpWDStSjiUvgZGX
    mBQnh2u+LLPGgy9ZkMbEwC7U9dU24986gGRvaHkgpl5kx5kOtvK78v0FokQDyXEE
    cFyI6bsCP2vVbtN0kD3wDgJz9SrhJJDl6CswhxMfQu9gWluHBR+NKCJMzgllmAM0
    asEKA54vG0V+DC9aabQpRNjkOls1tEgF3hykGVUHLjOBcWupBtGo4kaD4e6xCjnf
    gZpdQEcGC9eLfIjRsLJMTy16ijJ4GQ2g5sI3SGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1520960695; bh=vhf9vl41dhPK8QBNHXa/iQ7fla
    yEYiNee4k2VMiWi7k=; b=RgFXYg2cPXHooJhd6Gq5Fmobtnilcm1lnPf/wjHycS
    592hSKB1p5aElkovjr6uOHnSbSNmKX9lNW7lVnmTDFU7IONixTl0BT57codd0SS4
    LszWYKTXfyJcT7siXoH8IToIb/bUKjviNtNQI/0SXiS77yjc8lOvxj3vnxLWA0EX
    MuCtK1qBWdFi/0qCwzT/Mc9KjGpRRpbJ8bbqZ3jT8pR9SuxEXyXPmu1KZJbMt7vy
    xs3fBZGvzRRRBSasE2FcDsbb4fgYk7xAUP+BkkjqvxSlB0RMArJcK15ohF/qAhwB
    Wl7ZDz57f4AovCdmCUW0DLtNVRBsURUP8HQ4+5GIZitQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbeCMP2U (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:28:20 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57482 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932685AbeCMP2Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:28:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.15 000/146] 4.15.10-stable review
Date: Tue, 13 Mar 2018 16:22:47 +0100
Message-Id: <20180313152320.439085687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.10-rc1
X-KernelTest-Deadline: 2018-03-15T15:23+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.10 release.
There are 146 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Mar 15 15:22:37 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.10-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.10-rc1

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix unstable write completion

Trond Myklebust <trond.myklebust@primarydata.com>
    pNFS: Prevent the layout header refcount going to zero in pnfs_roc()

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Fix an incorrect type in struct nfs_direct_req

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix memory leak in dual/target mode

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix system crash in qlt_plogi_ack_unref

Giridhar Malavali <giridhar.malavali@cavium.com>
    scsi: qla2xxx: Remove aborting ELS IOCB call issued as part of timeout.

Giridhar Malavali <giridhar.malavali@cavium.com>
    scsi: qla2xxx: Defer processing of GS IOCB calls

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Clear loop id after delete

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix scan state field for fcport

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix abort command deadlock due to spinlock

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix PRLI state check

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix Relogin being triggered too fast

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Relogin to target port on a cable swap

Sawan Chandak <sawan.chandak@cavium.com>
    scsi: qla2xxx: Fix NPIV host cleanup in target mode

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix login state machine stuck at GPDB

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Serialize GPNID for multiple RSCN

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Retry switch command on time out

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix re-login for Nport Handle in use

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Skip IRQ affinity for Target QPairs

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Move session delete to driver work queue

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix gpnid error processing

Quinn Tran <quinn.tran@cavium.com>
    scsi: qla2xxx: Fix system crash for Notify ack timeout handling

Prarit Bhargava <prarit@redhat.com>
    x86/xen: Calculate __max_logical_packages on PV domains

Javier Martinez Canillas <javierm@redhat.com>
    tpm: only attempt to disable the LPC CLKRUN if is already enabled

Arnd Bergmann <arnd@arndb.de>
    tpm: remove unused variables

Javier Martinez Canillas <javierm@redhat.com>
    tpm: delete the TPM_TIS_CLK_ENABLE flag

Azhar Shaikh <azhar.shaikh@intel.com>
    tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()

Azhar Shaikh <azhar.shaikh@intel.com>
    tpm_tis: Move ilb_base_addr to tpm_tis_data

Eric Dumazet <edumazet@google.com>
    netfilter: use skb_to_full_sk in ip6_route_me_harder

Florian Westphal <fw@strlen.de>
    netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt

Florian Westphal <fw@strlen.de>
    netfilter: bridge: ebt_among: add missing match size checks

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets

Eric Dumazet <edumazet@google.com>
    netfilter: IDLETIMER: be syzkaller friendly

Paolo Abeni <pabeni@redhat.com>
    netfilter: nat: cope with negative port range

Paolo Abeni <pabeni@redhat.com>
    netfilter: x_tables: fix missing timer initialization in xt_LED

Eric Dumazet <edumazet@google.com>
    netfilter: xt_hashlimit: fix lock imbalance

Cong Wang <xiyou.wangcong@gmail.com>
    netfilter: ipt_CLUSTERIP: fix a race condition of proc file creation

Florian Westphal <fw@strlen.de>
    netfilter: add back stackpointer size checks

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: Remove legacy NMI sourcing.

Arnd Bergmann <arnd@arndb.de>
    watchdog: hpwdt: fix unused variable warning

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: Check source of NMI

Jerry Hoemann <jerry.hoemann@hpe.com>
    watchdog: hpwdt: SMBIOS check

Francis Deslauriers <francis.deslauriers@efficios.com>
    x86/kprobes: Fix kernel crash when probing .entry_trampoline code

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Fix 32-bit build

Josh Poimboeuf <jpoimboe@redhat.com>
    objtool: Fix another switch table detection issue

Peter Zijlstra <peterz@infradead.org>
    objtool, retpolines: Integrate objtool with retpoline support more closely

Peter Zijlstra <peterz@infradead.org>
    objtool: Add module specific retpoline rules

Peter Zijlstra <peterz@infradead.org>
    objtool: Add retpoline validation

Peter Zijlstra <peterz@infradead.org>
    objtool: Use existing global variables for options

Peter Zijlstra <peterz@infradead.org>
    x86/mm/sme, objtool: Annotate indirect call in sme_encrypt_execute()

Peter Zijlstra <peterz@infradead.org>
    x86/boot, objtool: Annotate indirect jump in secondary_startup_64()

Peter Zijlstra <peterz@infradead.org>
    x86/paravirt, objtool: Annotate indirect calls

Ingo Molnar <mingo@kernel.org>
    x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP

Peter Zijlstra <peterz@infradead.org>
    x86/speculation, objtool: Annotate indirect calls/jumps for objtool

David Woodhouse <dwmw@amazon.co.uk>
    x86/retpoline: Support retpoline builds with Clang

David Woodhouse <dwmw@amazon.co.uk>
    x86/speculation: Use IBRS if available before calling into firmware

David Woodhouse <dwmw@amazon.co.uk>
    Revert "x86/retpoline: Simplify vmexit_fill_RSB()"

Jan Beulich <JBeulich@suse.com>
    x86-64/realmode: Add instruction suffix

Jan Beulich <JBeulich@suse.com>
    x86/LDT: Avoid warning in 32-bit builds with older gcc

Jan Beulich <JBeulich@suse.com>
    x86/IO-APIC: Avoid warning in 32-bit builds

Jan Beulich <JBeulich@suse.com>
    x86/asm: Improve how GEN_*_SUFFIXED_RMWcc() specify clobbers

Jann Horn <jannh@google.com>
    x86/mm: Remove stale comment about KMEMCHECK

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry/64: Use 'xorl' for faster register clearing

Dominik Brodowski <linux@dominikbrodowski.net>
    x86/entry: Reduce the code footprint of the 'idtentry' macro

Dan Williams <dan.j.williams@intel.com>
    nospec: Include <asm/barrier.h> dependency

Dan Williams <dan.j.williams@intel.com>
    nospec: Kill array_index_nospec_mask_check()

Paul Burton <paul.burton@mips.com>
    MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()

Paul Burton <paul.burton@mips.com>
    dt-bindings: Document mti,mips-cpc binding

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix recursion while sending terminate exchange

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix NULL pointer crash due to probe failure

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP ProBook 640 G2

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda: add dock and led support for HP EliteBook 820 G3

Hui Wang <hui.wang@canonical.com>
    ALSA: hda - Fix a wrong FIXUP for alc289 on Dell machines

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: More protection for concurrent write and ioctl races

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Don't allow resizing pool in use

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    ALSA: hda/realtek - Make dock sound work on ThinkPad L570

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520

Benjamin Berg <bberg@redhat.com>
    ALSA: hda/realtek: Limit mic boost on T480

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add headset mode support for Dell laptop

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Add support headset mode for DELL WYSE

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/spectre_v2: Don't check microcode versions when running under hypervisors

Adrian Hunter <adrian.hunter@intel.com>
    perf tools: Fix trigger class trigger_on()

Seunghun Han <kkamagui@gmail.com>
    x86/MCE: Serialize sysfs changes

Tony Luck <tony.luck@intel.com>
    x86/MCE: Save microcode revision in machine check records

Michael Lyle <mlyle@lyle.org>
    bcache: don't attach backing with duplicate UUID

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix crashes in duplicate cache device register

Sergey Gorenko <sergeygo@mellanox.com>
    IB/mlx5: Fix incorrect size of klms in the memory region

Arnd Bergmann <arnd@arndb.de>
    dm bufio: avoid false-positive Wmaybe-uninitialized warning

James Hogan <jhogan@kernel.org>
    kbuild: Handle builtin dtb file names containing hyphens

Christoph Hellwig <hch@lst.de>
    Revert "nvme: create 'slaves' and 'holders' entries for hidden controllers"

Parav Pandit <parav@mellanox.com>
    IB/core: Fix missing RDMA cgroups release in case of failure to register device

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: mm: fix thinko in non-global page table attribute check

David Hildenbrand <david@redhat.com>
    KVM: s390: fix memory overwrites when not using SCA entries

Tiwei Bie <tiwei.bie@intel.com>
    virtio_ring: fix num_free handling in error case

Ross Zwisler <ross.zwisler@linux.intel.com>
    loop: Fix lost writes caused by missing flag

Matthew Wilcox <mawilcox@microsoft.com>
    Documentation/sphinx: Fix Directive import error

Daniel Vacek <neelx@redhat.com>
    mm/page_alloc: fix memmap_init_zone pageblock alignment

Daniel Vacek <neelx@redhat.com>
    mm/memblock.c: hardcode the end_pfn being -1

Kees Cook <keescook@chromium.org>
    lib/bug.c: exclude non-BUG/WARN exceptions from report_bug()

Kees Cook <keescook@chromium.org>
    bug: use %pB in BUG and stack protector failure

Arkadiusz Hiler <arkadiusz.hiler@intel.com>
    Revert "Input: synaptics - Lenovo Thinkpad T460p devices should use RMI"

Zhang Bo <zbsdta@126.com>
    Input: matrix_keypad - fix race when disabling interrupts

Koen Vandeputte <koen.vandeputte@ncentric.com>
    PCI: dwc: Fix enumeration end when reaching root subordinate

Colin Ian King <colin.king@canonical.com>
    MIPS: OCTEON: irq: Check for null return on kzalloc allocation

Colin Ian King <colin.king@canonical.com>
    MIPS: ath25: Check for kzalloc allocation failure

Justin Chen <justinpopo6@gmail.com>
    MIPS: BMIPS: Do not mask IPIs during suspend

Vivek Goyal <vgoyal@redhat.com>
    ovl: redirect_dir=nofollow should not follow redirect for opaque lower

James Zhu <James.Zhu@amd.com>
    drm/amdgpu:Always save uvd vcpu_bo in VM Mode

James Zhu <James.Zhu@amd.com>
    drm/amdgpu:Correct max uvd handles

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: fix KV harvesting

Alex Deucher <alexander.deucher@amd.com>
    drm/radeon: fix KV harvesting

Rex Zhu <Rex.Zhu@amd.com>
    drm/amdgpu: Notify sbios device ready before send request

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: used cached pcie gen info for SI (v2)

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Default HDMI6G support to true. Log VBIOS table error.

Eric Huang <JinHuiEric.Huang@amd.com>
    drm/amd/powerplay: fix power over limit on Fiji

Ben Crocker <bcrocker@redhat.com>
    drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE

Shirish S <shirish.s@amd.com>
    drm/amd/display: check for ipp before calling cursor operations

Alex Deucher <alexander.deucher@amd.com>
    Revert "drm/radeon/pm: autoswitch power state when in balanced mode"

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/powerplay/vega10: allow mclk switching with no displays

Alex Deucher <alexander.deucher@amd.com>
    drm/amd/powerplay/smu7: allow mclk switching with no displays

Ilia Mirkin <imirkin@alum.mit.edu>
    drm/nouveau: prefer XBGR2101010 for addfb ioctl

Lukas Wunner <lukas@wunner.de>
    drm/amdgpu: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm/radeon: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm/nouveau: Fix deadlock on runtime suspend

Lukas Wunner <lukas@wunner.de>
    drm: Allow determining if current task is output poll worker

Lukas Wunner <lukas@wunner.de>
    workqueue: Allow retrieval of current task's work struct

Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    drm/i915: Always call to intel_display_set_init_power() in resume_early.

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: core: Avoid that ATA error handling can trigger a kernel hang or oops

Lionel Landwerlin <lionel.g.landwerlin@intel.com>
    drm/i915/perf: fix perf stream opening lock

Stefan Brüns <stefan.bruens@rwth-aachen.de>
    drm/i915: Try EDID bitbanging on HDMI after failed read

Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
    drm/i915: Update watermark state correctly in sanitize_watermarks

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Disable DC states around GMBUS on GLK

Chris Wilson <chris@chris-wilson.co.uk>
    drm/i915: Clear the in-use marker on execbuf failure

Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
    drm/i915: Fix rsvd2 mask when out-fence is returned

Jani Nikula <jani.nikula@intel.com>
    drm/i915/audio: fix check for av_enc_map overflow

Mika Kahola <mika.kahola@intel.com>
    drm/i915: Check for fused or unused pipes

Fabrice Gasnier <fabrice.gasnier@st.com>
    regulator: stm32-vrefbuf: fix check on ready flag

Davide Caratti <dcaratti@redhat.com>
    net/smc: fix NULL pointer dereference on sock_create_kern() error path

Johannes Berg <johannes.berg@intel.com>
    mac80211_hwsim: don't use WQ_MEM_RECLAIM

Jason Gunthorpe <jgg@ziepe.ca>
    IB/uverbs: Improve lockdep_check

Jason Wang <jasowang@redhat.com>
    bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC in __cpu_map_entry_alloc()

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix integer overflow while resizing CQ

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Check that user doesn't overflow QP state

Leon Romanovsky <leonro@mellanox.com>
    RDMA/ucma: Limit possible option size


-------------

Diffstat:

 .../devicetree/bindings/power/mti,mips-cpc.txt     |   8 +
 Documentation/sphinx/kerneldoc.py                  |   3 +-
 MAINTAINERS                                        |   1 +
 Makefile                                           |   9 +-
 arch/arm64/mm/mmu.c                                |   8 +-
 arch/mips/ath25/board.c                            |   2 +
 arch/mips/cavium-octeon/octeon-irq.c               |   2 +
 arch/mips/kernel/mips-cpc.c                        |  13 +
 arch/mips/kernel/smp-bmips.c                       |   8 +-
 arch/s390/kvm/kvm-s390.c                           |   1 +
 arch/x86/Kconfig                                   |   1 +
 arch/x86/Makefile                                  |   7 +-
 arch/x86/entry/calling.h                           |  27 +-
 arch/x86/entry/entry_32.S                          |   3 +-
 arch/x86/entry/entry_64.S                          |  21 +-
 arch/x86/entry/entry_64_compat.S                   |  54 +--
 arch/x86/include/asm/apm.h                         |   6 +
 arch/x86/include/asm/asm-prototypes.h              |   3 -
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/efi.h                         |  17 +-
 arch/x86/include/asm/mmu_context.h                 |   1 +
 arch/x86/include/asm/nospec-branch.h               | 138 +++++-
 arch/x86/include/asm/paravirt.h                    |  17 +-
 arch/x86/include/asm/paravirt_types.h              |   5 +-
 arch/x86/include/asm/refcount.h                    |   4 +-
 arch/x86/include/asm/rmwcc.h                       |  16 +-
 arch/x86/include/asm/sections.h                    |   1 +
 arch/x86/include/asm/smp.h                         |   1 +
 arch/x86/include/uapi/asm/mce.h                    |   1 +
 arch/x86/kernel/apic/io_apic.c                     |   2 +-
 arch/x86/kernel/cpu/bugs.c                         |  12 +-
 arch/x86/kernel/cpu/intel.c                        |   7 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |  26 +-
 arch/x86/kernel/head_64.S                          |   2 +
 arch/x86/kernel/kprobes/core.c                     |  10 +-
 arch/x86/kernel/smpboot.c                          |  10 +-
 arch/x86/kernel/vmlinux.lds.S                      |   2 +
 arch/x86/lib/Makefile                              |   1 -
 arch/x86/lib/retpoline.S                           |  56 ---
 arch/x86/mm/fault.c                                |   4 -
 arch/x86/mm/mem_encrypt_boot.S                     |   2 +
 arch/x86/realmode/rm/trampoline_64.S               |   2 +-
 arch/x86/xen/smp.c                                 |   2 +
 drivers/block/loop.c                               |   2 +-
 drivers/char/tpm/tpm-interface.c                   |   6 +
 drivers/char/tpm/tpm_tis.c                         | 108 -----
 drivers/char/tpm/tpm_tis_core.c                    | 121 ++++-
 drivers/char/tpm/tpm_tis_core.h                    |  16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c           |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |  58 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c            |  13 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c              |  30 +-
 drivers/gpu/drm/amd/amdgpu/si.c                    |  22 +-
 drivers/gpu/drm/amd/amdgpu/si_dpm.c                |  50 +-
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c    |   6 +-
 .../gpu/drm/amd/display/dc/dce/dce_link_encoder.c  |  16 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c   |  18 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c |  11 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   4 +
 drivers/gpu/drm/drm_probe_helper.c                 |  20 +
 drivers/gpu/drm/i915/i915_drv.c                    |   2 +
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |   4 +-
 drivers/gpu/drm/i915/i915_perf.c                   |  38 +-
 drivers/gpu/drm/i915/intel_audio.c                 |   6 +-
 drivers/gpu/drm/i915/intel_display.c               |   2 +
 drivers/gpu/drm/i915/intel_hdmi.c                  |  14 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c            |   1 +
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  18 +-
 drivers/gpu/drm/nouveau/nv50_display.c             |   1 +
 drivers/gpu/drm/radeon/cik.c                       |  31 +-
 drivers/gpu/drm/radeon/radeon_connectors.c         |  74 ++-
 drivers/gpu/drm/radeon/radeon_device.c             |   4 +
 drivers/gpu/drm/radeon/radeon_pm.c                 |   6 +-
 drivers/infiniband/core/device.c                   |   6 +-
 drivers/infiniband/core/rdma_core.c                |  12 +-
 drivers/infiniband/core/ucma.c                     |   6 +
 drivers/infiniband/hw/mlx5/cq.c                    |   7 +-
 drivers/infiniband/hw/mlx5/mr.c                    |   2 +-
 drivers/input/keyboard/matrix_keypad.c             |   4 +-
 drivers/input/mouse/synaptics.c                    |   1 -
 drivers/md/bcache/super.c                          |  27 +-
 drivers/md/dm-bufio.c                              |  16 +-
 drivers/net/wireless/mac80211_hwsim.c              |   2 +-
 drivers/nvme/host/core.c                           |   2 -
 drivers/nvme/host/multipath.c                      |  30 --
 drivers/nvme/host/nvme.h                           |   8 -
 drivers/pci/dwc/pcie-designware-host.c             |   2 +-
 drivers/regulator/stm32-vrefbuf.c                  |   2 +-
 drivers/scsi/hosts.c                               |   3 -
 drivers/scsi/qla2xxx/qla_def.h                     |  49 +-
 drivers/scsi/qla2xxx/qla_gs.c                      | 230 ++++++++--
 drivers/scsi/qla2xxx/qla_init.c                    |  70 ++-
 drivers/scsi/qla2xxx/qla_iocb.c                    |  13 -
 drivers/scsi/qla2xxx/qla_isr.c                     |   7 +-
 drivers/scsi/qla2xxx/qla_mbx.c                     |   3 +-
 drivers/scsi/qla2xxx/qla_mid.c                     |  42 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  86 +++-
 drivers/scsi/qla2xxx/qla_target.c                  |  61 ++-
 drivers/scsi/scsi_error.c                          |   5 +-
 drivers/scsi/scsi_lib.c                            |   2 +
 drivers/virtio/virtio_ring.c                       |   2 -
 drivers/watchdog/hpwdt.c                           | 507 +--------------------
 fs/nfs/direct.c                                    |   2 +-
 fs/nfs/pnfs.c                                      |  13 +-
 fs/nfs/write.c                                     |  83 ++--
 fs/overlayfs/namei.c                               |   6 +-
 include/drm/drm_crtc_helper.h                      |   1 +
 include/drm/drm_drv.h                              |   1 +
 include/linux/compiler-clang.h                     |   5 +
 include/linux/compiler-gcc.h                       |   4 +
 include/linux/init.h                               |   8 +-
 include/linux/nospec.h                             |  23 +-
 include/linux/tpm.h                                |   1 +
 include/linux/workqueue.h                          |   1 +
 include/scsi/scsi_cmnd.h                           |   3 +
 include/scsi/scsi_host.h                           |   2 -
 kernel/bpf/cpumap.c                                |   2 +-
 kernel/panic.c                                     |   2 +-
 kernel/workqueue.c                                 |  16 +
 lib/bug.c                                          |   4 +-
 mm/memblock.c                                      |  10 +-
 mm/page_alloc.c                                    |   9 +-
 net/bridge/netfilter/ebt_among.c                   |  21 +-
 net/bridge/netfilter/ebtables.c                    |  13 +-
 net/ipv4/netfilter/arp_tables.c                    |   4 +
 net/ipv4/netfilter/ip_tables.c                     |   7 +-
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  12 +-
 net/ipv6/netfilter.c                               |   9 +-
 net/ipv6/netfilter/ip6_tables.c                    |   4 +
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c           |   4 +
 net/netfilter/nf_nat_proto_common.c                |   7 +-
 net/netfilter/xt_IDLETIMER.c                       |   9 +-
 net/netfilter/xt_LED.c                             |  10 +-
 net/netfilter/xt_hashlimit.c                       |   2 +-
 net/smc/af_smc.c                                   |   4 +-
 scripts/Makefile.build                             |   8 +
 scripts/Makefile.lib                               |   8 +-
 sound/core/seq/seq_clientmgr.c                     |  21 +-
 sound/core/seq/seq_fifo.c                          |   2 +-
 sound/core/seq/seq_memory.c                        |  14 +-
 sound/core/seq/seq_memory.h                        |   3 +-
 sound/pci/hda/patch_conexant.c                     |   2 +
 sound/pci/hda/patch_realtek.c                      |  45 +-
 tools/objtool/builtin-check.c                      |   6 +-
 tools/objtool/builtin-orc.c                        |   6 +-
 tools/objtool/builtin.h                            |   5 +
 tools/objtool/check.c                              |  93 +++-
 tools/objtool/check.h                              |   3 +-
 tools/perf/util/trigger.h                          |   9 +-
 149 files changed, 1582 insertions(+), 1374 deletions(-)
