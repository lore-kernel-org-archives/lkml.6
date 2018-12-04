Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274DAC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C436B20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFTT+ekW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C436B20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbeLDLWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:22:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727596AbeLDLCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:02:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EECF214DE;
        Tue,  4 Dec 2018 11:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921334;
        bh=KLBFp6bPyCAte7fuGp5WO3lqcr9X511w1ftQicSrFdU=;
        h=From:To:Cc:Subject:Date:From;
        b=KFTT+ekWQ0e8zJ32E2jWJ2jAM2XBiwAYZS7QnNyyX4sFcGy9BIrzvgpG9ePoI/z9P
         Q96TRE1zRk9Vqyv8/+c2lVnXuL90/fdVhcgjMjMdOxXC569z9/nnJYB039ThiK4YHX
         kvO8eAAMoh09PsWHOBQzxsWBoLe0pgNEYQ0lJhwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/146] 4.14.86-stable review
Date:   Tue,  4 Dec 2018 11:48:06 +0100
Message-Id: <20181204103726.750894136@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.86-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.86-rc1
X-KernelTest-Deadline: 2018-12-06T10:37+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.86 release.
There are 146 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Dec  6 10:36:52 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.86-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.86-rc1

Todd Kjos <tkjos@android.com>
    binder: fix race that allows malicious free of live buffer

YueHaibing <yuehaibing@huawei.com>
    misc: mic/scif: fix copy-paste error in scif_create_remote_lookup

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: check the creation_status in vmbus_establish_gpadl()

Yu Zhao <yuzhao@google.com>
    mm: use swp_offset as key in shmem_replace_page()

Luis Chamberlain <mcgrof@kernel.org>
    lib/test_kmod.c: fix rmmod double free

Martin Kelly <martin@martingkelly.com>
    iio:st_magn: Fix enable device after trigger

Felipe Balbi <felipe.balbi@linux.intel.com>
    Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"

Michael Niewöhner <linux@mniewoehner.de>
    usb: core: quirks: add RESET_RESUME quirk for Cherry G230 Stream series

Kai-Heng Feng <kai.heng.feng@canonical.com>
    USB: usb-storage: Add new IDs to ums-realtek

Larry Finger <Larry.Finger@lwfinger.net>
    staging: rtl8723bs: Add missing return for cfg80211_rtw_get_station

Ben Wolsieffer <benwolsieffer@gmail.com>
    staging: vchiq_arm: fix compat VCHIQ_IOC_AWAIT_COMPLETION

Josef Bacik <josef@toxicpanda.com>
    btrfs: release metadata before running delayed refs

Richard Genoud <richard.genoud@gmail.com>
    dmaengine: at_hdmac: fix module unloading

Richard Genoud <richard.genoud@gmail.com>
    dmaengine: at_hdmac: fix memory leak in at_dma_xlate()

Heiko Stuebner <heiko@sntech.de>
    ARM: dts: rockchip: Remove @0 from the veyron memory node

Pan Bian <bianpan2016@163.com>
    ext2: fix potential use after free

Anisse Astier <anisse@astier.eu>
    ALSA: hda/realtek - fix headset mic detection for MSI MS-B171

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Support ALC300

Takashi Iwai <tiwai@suse.de>
    ALSA: sparc: Fix invalid snd_free_pages() at error path

Takashi Iwai <tiwai@suse.de>
    ALSA: control: Fix race between adding and removing a user element

Takashi Iwai <tiwai@suse.de>
    ALSA: ac97: Fix incorrect bit shift at AC97-SPSA control write

Takashi Iwai <tiwai@suse.de>
    ALSA: wss: Fix invalid snd_free_pages() at error path

Maximilian Heyne <mheyne@amazon.de>
    fs: fix lost error code in dio_complete

Jiri Olsa <jolsa@kernel.org>
    perf/x86/intel: Add generic branch tracing check to intel_pmu_has_bts()

Jiri Olsa <jolsa@kernel.org>
    perf/x86/intel: Move branch tracing setup to the Intel-specific source file

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    x86/fpu: Disable bottom halves while loading FPU registers

Borislav Petkov <bp@suse.de>
    x86/MCE/AMD: Fix the thresholding machinery initialization order

Christoph Muellner <christoph.muellner@theobroma-systems.com>
    arm64: dts: rockchip: Fix PCIe reset polarity for rk3399-puma-haikou.

Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
    PCI: layerscape: Fix wrong invocation of outbound window disable accessor

Pan Bian <bianpan2016@163.com>
    btrfs: relocation: set trans to be NULL after ending transaction

Filipe Manana <fdmanana@suse.com>
    Btrfs: ensure path name is null terminated at btrfs_control_ioctl

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix coprocessor part of ptrace_{get,set}xregs

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix coprocessor context offset definitions

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: enable coprocessors that are being flushed

Wanpeng Li <wanpengli@tencent.com>
    KVM: X86: Fix scan ioapic use-before-initialization

Liran Alon <liran.alon@oracle.com>
    KVM: x86: Fix kernel info-leak in KVM_HC_CLOCK_PAIRING hypercall

Jim Mattson <jmattson@google.com>
    kvm: svm: Ensure an IBPB on all affected CPUs when freeing a vmcb

Junaid Shahid <junaids@google.com>
    kvm: mmu: Fix race in emulated page table writes

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Provide IBPB always command line options

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Add seccomp Spectre v2 user space protection mode

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Enable prctl mode for spectre_v2_user

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Add prctl() control for indirect branch speculation

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Prepare arch_smt_update() for PRCTL mode

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Prevent stale SPEC_CTRL msr content

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Split out TIF update

Thomas Gleixner <tglx@linutronix.de>
    ptrace: Remove unused ptrace_may_access_sched() and MODE_IBRS

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Prepare for conditional IBPB in switch_mm()

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Avoid __switch_to_xtra() calls

Thomas Gleixner <tglx@linutronix.de>
    x86/process: Consolidate and simplify switch_to_xtra() code

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Prepare for per task indirect branch speculation control

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Add command line control for indirect branch speculation

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Unify conditional spectre v2 print functions

Thomas Gleixner <tglx@linutronix.de>
    x86/speculataion: Mark command line parser data __initdata

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Mark string arrays const correctly

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Reorder the spec_v2 code

Thomas Gleixner <tglx@linutronix.de>
    x86/l1tf: Show actual SMT state

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Rework SMT state change

Thomas Gleixner <tglx@linutronix.de>
    sched/smt: Expose sched_smt_present static key

Thomas Gleixner <tglx@linutronix.de>
    x86/Kconfig: Select SCHED_SMT if SMP enabled

Peter Zijlstra (Intel) <peterz@infradead.org>
    sched/smt: Make sched_smt_present track topology

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Reorganize speculation control MSRs update

Thomas Gleixner <tglx@linutronix.de>
    x86/speculation: Rename SSBD update functions

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Disable STIBP when enhanced IBRS is in use

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Move STIPB/IBPB string conditionals out of cpu_show_common()

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Remove unnecessary ret variable in cpu_show_common()

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Clean up spectre_v2_parse_cmdline()

Tim Chen <tim.c.chen@linux.intel.com>
    x86/speculation: Update the TIF_SSBD comment

Zhenzhong Duan <zhenzhong.duan@oracle.com>
    x86/retpoline: Remove minimal retpoline support

Zhenzhong Duan <zhenzhong.duan@oracle.com>
    x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support

Zhenzhong Duan <zhenzhong.duan@oracle.com>
    x86/speculation: Add RETPOLINE_AMD support to the inline asm CALL_NOSPEC variant

Jiri Kosina <jkosina@suse.cz>
    x86/speculation: Propagate information about RSB filling mitigation to sysfs

Jiri Kosina <jkosina@suse.cz>
    x86/speculation: Apply IBPB more strictly to avoid cross-process data leak

Jiri Kosina <jkosina@suse.cz>
    x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation

Tom Lendacky <thomas.lendacky@amd.com>
    x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR

Tom Lendacky <thomas.lendacky@amd.com>
    x86/bugs: Update when to check for the LS_CFG SSBD mitigation

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Switch the selection of mitigation from CPU vendor to CPU features

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Add AMD's SPEC_CTRL MSR usage

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs: Add AMD's variant of SSB_NO

Peter Zijlstra <peterz@infradead.org>
    sched/core: Fix cpu.max vs. cpuhotplug deadlock

Bernd Eckstein <3erndeckstein@gmail.com>
    usbnet: ipheth: fix potential recvmsg bug and recvmsg bug 2

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix length check in SNMP processing

Pan Bian <bianpan2016@163.com>
    rapidio/rionet: do not free skb before reading its length

Willem de Bruijn <willemb@google.com>
    packet: copy user buffers before orphan or clone

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: thunderx: set tso_hdrs pointer to NULL in nicvf_free_snd_queue

Jason Wang <jasowang@redhat.com>
    virtio-net: fail XDP set if guest csum is negotiated

Jason Wang <jasowang@redhat.com>
    virtio-net: disable guest csum during XDP set

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: thunderx: set xdp_prog to NULL if bpf_prog_add fails

Petr Machata <petrm@mellanox.com>
    net: skb_scrub_packet(): Scrub offload_fwd_mark

Sasha Levin <sashal@kernel.org>
    Revert "wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()"

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: don't fail when converting shortform attr to long form during ATTR_REPLACE

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with cp_pack_start_sum

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with i_extra_isize

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with block address in main area

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with node footer and iblocks

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with user_block_count

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with extra_attr feature

Ben Hutchings <ben.hutchings@codethink.co.uk>
    f2fs: Add sanity_check_inode() function

Chao Yu <yuchao0@huawei.com>
    f2fs: fix to do sanity check with secs_per_zone

Chao Yu <yuchao0@huawei.com>
    f2fs: introduce and spread verify_blkaddr

Chao Yu <yuchao0@huawei.com>
    f2fs: clean up with is_valid_blkaddr()

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: enhance sanity_check_raw_super() to avoid potential overflow

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: sanity check on sit entry

Yunlei He <heyunlei@huawei.com>
    f2fs: check blkaddr more accuratly before issue a bio

Shaokun Zhang <zhangshaokun@hisilicon.com>
    btrfs: tree-checker: Fix misleading group system information

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Check level for leaves and nodes

Qu Wenruo <wqu@suse.com>
    btrfs: Check that each block group has corresponding chunk at mount time

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Detect invalid and empty essential trees

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Verify block_group_item

David Sterba <dsterba@suse.com>
    btrfs: tree-check: reduce stack consumption in check_dir_item

Arnd Bergmann <arnd@arndb.de>
    btrfs: tree-checker: use %zu format string for size_t

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Add checker for dir item

Qu Wenruo <wqu@suse.com>
    btrfs: tree-checker: Fix false panic for sanity test

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: tree-checker: Enhance btrfs_check_node output

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Move leaf and node validation checker to tree-checker.c

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Add checker for EXTENT_CSUM

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Add sanity check for EXTENT_DATA when reading out leaf

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Check if item pointer overlaps with the item itself

Qu Wenruo <quwenruo.btrfs@gmx.com>
    btrfs: Refactor check_leaf function for later expansion

Qu Wenruo <wqu@suse.com>
    btrfs: Verify that every chunk has corresponding block group at mount time

Gu Jinxiang <gujx@cn.fujitsu.com>
    btrfs: validate type when reading a chunk

Lior David <qca_liord@qca.qualcomm.com>
    wil6210: missing length check in wmi_set_ie

Vakul Garg <vakul.garg@nxp.com>
    net/tls: Fixed return value when tls_complete_pending_work() fails

Boris Pismenny <borisp@mellanox.com>
    tls: Use correct sk->sk_prot for IPV6

Ilya Lesokhin <ilyal@mellanox.com>
    tls: don't override sk_write_space if tls_set_sw_offload fails.

Ilya Lesokhin <ilyal@mellanox.com>
    tls: Avoid copying crypto_info again after cipher_type check.

Ilya Lesokhin <ilyal@mellanox.com>
    tls: Fix TLS ulp context leak, when TLS_TX setsockopt is not used.

Ilya Lesokhin <ilyal@mellanox.com>
    tls: Add function to update the TLS socket configuration

Alexei Starovoitov <ast@kernel.org>
    bpf: Prevent memory disambiguation attack

Ilya Dryomov <idryomov@gmail.com>
    libceph: implement CEPHX_V2 calculation mode

Ilya Dryomov <idryomov@gmail.com>
    libceph: add authorizer challenge

Ilya Dryomov <idryomov@gmail.com>
    libceph: factor out encrypt_authorizer()

Ilya Dryomov <idryomov@gmail.com>
    libceph: factor out __ceph_x_decrypt()

Ilya Dryomov <idryomov@gmail.com>
    libceph: factor out __prepare_write_connect()

Ilya Dryomov <idryomov@gmail.com>
    libceph: store ceph_auth_handshake pointer in ceph_connection

Richard Weinberger <richard@nod.at>
    ubi: Initialize Fastmap checkmapping correctly

Matthias Schwarzott <zzam@gentoo.org>
    media: em28xx: Fix use-after-free when disconnecting

Hugh Dickins <hughd@google.com>
    mm/khugepaged: collapse_shmem() do not crash on Compound

Hugh Dickins <hughd@google.com>
    mm/khugepaged: collapse_shmem() without freezing new_page

Hugh Dickins <hughd@google.com>
    mm/khugepaged: minor reorderings in collapse_shmem()

Hugh Dickins <hughd@google.com>
    mm/khugepaged: collapse_shmem() remember to clear holes

Hugh Dickins <hughd@google.com>
    mm/khugepaged: fix crashes due to misaccounted holes

Hugh Dickins <hughd@google.com>
    mm/khugepaged: collapse_shmem() stop if punched or truncated

Hugh Dickins <hughd@google.com>
    mm/huge_memory: fix lockdep complaint on 32-bit i_size_read()

Hugh Dickins <hughd@google.com>
    mm/huge_memory: splitting set mapping+index before unfreeze

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    mm/huge_memory.c: reorder operations in __split_huge_page_tail()

Hugh Dickins <hughd@google.com>
    mm/huge_memory: rename freeze_page() to unmap_page()


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |  56 +-
 Documentation/userspace-api/spec_ctrl.rst          |   9 +
 Makefile                                           |   4 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   6 +-
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |   2 +-
 arch/x86/Kconfig                                   |  12 +-
 arch/x86/Makefile                                  |   5 +-
 arch/x86/events/core.c                             |  20 -
 arch/x86/events/intel/core.c                       |  52 +-
 arch/x86/events/perf_event.h                       |  13 +-
 arch/x86/include/asm/cpufeatures.h                 |   2 +
 arch/x86/include/asm/msr-index.h                   |   5 +-
 arch/x86/include/asm/nospec-branch.h               |  44 +-
 arch/x86/include/asm/spec-ctrl.h                   |  20 +-
 arch/x86/include/asm/switch_to.h                   |   3 -
 arch/x86/include/asm/thread_info.h                 |  20 +-
 arch/x86/include/asm/tlbflush.h                    |   8 +-
 arch/x86/kernel/cpu/amd.c                          |   4 +-
 arch/x86/kernel/cpu/bugs.c                         | 510 ++++++++++++----
 arch/x86/kernel/cpu/common.c                       |   9 +-
 arch/x86/kernel/cpu/mcheck/mce_amd.c               |  19 +-
 arch/x86/kernel/fpu/signal.c                       |   4 +-
 arch/x86/kernel/process.c                          | 101 +++-
 arch/x86/kernel/process.h                          |  39 ++
 arch/x86/kernel/process_32.c                       |   8 +-
 arch/x86/kernel/process_64.c                       |  10 +-
 arch/x86/kvm/cpuid.c                               |  10 +-
 arch/x86/kvm/mmu.c                                 |  27 +-
 arch/x86/kvm/svm.c                                 |  28 +-
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/mm/tlb.c                                  | 115 +++-
 arch/xtensa/kernel/asm-offsets.c                   |  16 +-
 arch/xtensa/kernel/process.c                       |   5 +-
 arch/xtensa/kernel/ptrace.c                        |  42 +-
 drivers/android/binder.c                           |  21 +-
 drivers/android/binder_alloc.c                     |  14 +-
 drivers/android/binder_alloc.h                     |   3 +-
 drivers/dma/at_hdmac.c                             |  10 +-
 drivers/hv/channel.c                               |   8 +
 drivers/iio/magnetometer/st_magn_buffer.c          |  12 +-
 drivers/media/usb/em28xx/em28xx-dvb.c              |   3 +-
 drivers/misc/mic/scif/scif_rma.c                   |   2 +-
 drivers/mtd/ubi/vtbl.c                             |  20 +-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c   |   9 +-
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   4 +-
 drivers/net/rionet.c                               |   2 +-
 drivers/net/usb/ipheth.c                           |  10 +-
 drivers/net/virtio_net.c                           |  13 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |   8 +-
 drivers/net/wireless/ti/wlcore/cmd.c               |   6 -
 drivers/pci/dwc/pci-layerscape.c                   |   2 +-
 drivers/s390/net/qeth_core_main.c                  |  27 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |   7 +-
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/dwc3/gadget.c                          |   5 -
 drivers/usb/storage/unusual_realtek.h              |  10 +
 fs/btrfs/Makefile                                  |   2 +-
 fs/btrfs/disk-io.c                                 | 153 +----
 fs/btrfs/extent-tree.c                             |  86 ++-
 fs/btrfs/relocation.c                              |   1 +
 fs/btrfs/super.c                                   |   1 +
 fs/btrfs/transaction.c                             |   6 +-
 fs/btrfs/tree-checker.c                            | 649 +++++++++++++++++++++
 fs/btrfs/tree-checker.h                            |  38 ++
 fs/btrfs/volumes.c                                 |  30 +-
 fs/btrfs/volumes.h                                 |   2 +
 fs/ceph/mds_client.c                               |  11 +
 fs/direct-io.c                                     |   4 +-
 fs/ext2/xattr.c                                    |   2 +-
 fs/f2fs/checkpoint.c                               |  43 +-
 fs/f2fs/data.c                                     |  52 +-
 fs/f2fs/f2fs.h                                     |  41 +-
 fs/f2fs/file.c                                     |  21 +-
 fs/f2fs/inode.c                                    |  78 ++-
 fs/f2fs/node.c                                     |   9 +-
 fs/f2fs/recovery.c                                 |   6 +-
 fs/f2fs/segment.c                                  |  13 +-
 fs/f2fs/segment.h                                  |  24 +-
 fs/f2fs/super.c                                    |  96 ++-
 fs/xfs/libxfs/xfs_attr.c                           |   9 +-
 include/linux/bpf_verifier.h                       |   1 +
 include/linux/ceph/auth.h                          |   8 +
 include/linux/ceph/ceph_features.h                 |   7 +-
 include/linux/ceph/messenger.h                     |   6 +-
 include/linux/ceph/msgr.h                          |   2 +-
 include/linux/jump_label.h                         |   7 +
 include/linux/ptrace.h                             |   4 +-
 include/linux/sched.h                              |   9 +
 include/linux/sched/smt.h                          |  20 +
 include/linux/skbuff.h                             |  18 +-
 include/net/tls.h                                  |   4 +-
 include/uapi/linux/btrfs_tree.h                    |   1 +
 include/uapi/linux/prctl.h                         |   1 +
 kernel/bpf/verifier.c                              |  62 +-
 kernel/cpu.c                                       |  14 +-
 kernel/jump_label.c                                |  12 +-
 kernel/sched/core.c                                |  19 +-
 kernel/sched/fair.c                                |   4 +-
 kernel/sched/sched.h                               |   4 +-
 lib/test_kmod.c                                    |   1 -
 mm/huge_memory.c                                   |  79 +--
 mm/khugepaged.c                                    | 129 ++--
 mm/shmem.c                                         |  12 +-
 net/ceph/auth.c                                    |  16 +
 net/ceph/auth_x.c                                  | 217 +++++--
 net/ceph/auth_x_protocol.h                         |   7 +
 net/ceph/messenger.c                               |  86 +--
 net/ceph/osd_client.c                              |  11 +
 net/core/skbuff.c                                  |   4 +
 net/packet/af_packet.c                             |   4 +-
 net/tls/tls_main.c                                 | 124 ++--
 net/tls/tls_sw.c                                   |  13 +-
 scripts/Makefile.build                             |   2 -
 sound/core/control.c                               |  80 +--
 sound/isa/wss/wss_lib.c                            |   2 -
 sound/pci/ac97/ac97_codec.c                        |   2 +-
 sound/pci/hda/patch_realtek.c                      |   9 +
 sound/sparc/cs4231.c                               |   8 +-
 119 files changed, 2912 insertions(+), 907 deletions(-)


