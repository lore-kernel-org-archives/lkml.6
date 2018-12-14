Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A34DC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CBA214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789634;
	bh=Gcxkj+089TejqXCgl+rB75Pmj7dG6tICGDWZTwIyQtM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q+891XbTTVaH8RalcVxcJSVmVmAQLcPlwiw98VYQigf7GFO/XBwizCobqA2V6kvPD
	 CqoPhNj15LN5hSAJoeeNk9DH6az2jinT7U/ll5VQmpYwzKc8sERCRrMLwlNSSIChbj
	 /aFbvrpcrJjM+dZH8yjwM0MGlZRZCNGiLR6zOSjk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CBA214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbeLNMNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:13:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732208AbeLNMNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:13:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E10892133F;
        Fri, 14 Dec 2018 12:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789628;
        bh=Gcxkj+089TejqXCgl+rB75Pmj7dG6tICGDWZTwIyQtM=;
        h=From:To:Cc:Subject:Date:From;
        b=CQ6X7+15Ot1BI2resBv7Ct+wIjG5hMqezgzfO+Am4V2TYWzVlHCijXdOKd98J9T3R
         8TkD1vk1Y0CwrCvBiarguDMKpNYn3GgQ/6MGZvlGAgYz6VZWdJMLXWpRxw1PnFPIB4
         VIgfZRGayzUgQDKl4YW4nelUOAr8219Olx6tmVRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/88] 4.4.168-stable review
Date:   Fri, 14 Dec 2018 12:59:34 +0100
Message-Id: <20181214115702.151309521@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.168-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.168-rc1
X-KernelTest-Deadline: 2018-12-16T11:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.168 release.
There are 88 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Dec 16 11:56:41 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.168-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.168-rc1

Shuah Khan <shuahkh@osg.samsung.com>
    selftests: Move networking/timestamping from Documentation

Arnd Bergmann <arnd@arndb.de>
    rocker: fix rocker_tlv_put_* functions for KASAN

Guenter Roeck <linux@roeck-us.net>
    staging: speakup: Replace strncpy with memcpy

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    matroxfb: fix size of memcpy

Arnd Bergmann <arnd@arndb.de>
    media: dvb-frontends: fix i2c access helpers for KASAN

Willy Tarreau <w@1wt.eu>
    proc: do not access cmdline nor environ from file-backed areas

Linus Torvalds <torvalds@linux-foundation.org>
    proc: don't use FOLL_FORCE for reading cmdline and environment

Lorenzo Stoakes <lstoakes@gmail.com>
    mm: replace access_remote_vm() write parameter with gup_flags

Lorenzo Stoakes <lstoakes@gmail.com>
    mm: replace __access_remote_vm() write parameter with gup_flags

Lorenzo Stoakes <lstoakes@gmail.com>
    mm: replace get_user_pages() write/force parameters with gup_flags

Lorenzo Stoakes <lstoakes@gmail.com>
    mm: replace get_vaddr_frames() write/force parameters with gup_flags

Lorenzo Stoakes <lstoakes@gmail.com>
    mm: replace get_user_pages_locked() write/force parameters with gup_flags

Lorenzo Stoakes <lstoakes@gmail.com>
    mm: replace get_user_pages_unlocked() write/force parameters with gup_flags

Lorenzo Stoakes <lstoakes@gmail.com>
    mm: remove write/force parameters from __get_user_pages_unlocked()

Lorenzo Stoakes <lstoakes@gmail.com>
    mm: remove write/force parameters from __get_user_pages_locked()

Jens Axboe <axboe@kernel.dk>
    sr: pass down correctly sized SCSI sense buffer

Kees Cook <keescook@chromium.org>
    swiotlb: clean up reporting

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: fix bug in pgoff overflow checking

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: check for pgoff value overflow

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: fix offset overflow in hugetlbfs mmap

Mike Kravetz <mike.kravetz@oracle.com>
    mm/hugetlb.c: don't call region_abort if region_chg fails

Thomas Gleixner <tglx@linutronix.de>
    posix-timers: Sanitize overrun handling

Lior David <qca_liord@qca.qualcomm.com>
    wil6210: missing length check in wmi_set_ie

Alexei Starovoitov <ast@kernel.org>
    bpf: Prevent memory disambiguation attack

Ben Hutchings <ben.hutchings@codethink.co.uk>
    bpf/verifier: Pass instruction index to check_mem_access() and check_xadd()

Ben Hutchings <ben.hutchings@codethink.co.uk>
    bpf/verifier: Add spi variable to check_stack_write()

Alexei Starovoitov <ast@fb.com>
    bpf: support 8-byte metafield access

Tom Lendacky <thomas.lendacky@amd.com>
    KVM: SVM: Implement VIRT_SPEC_CTRL support for SSBD

Borislav Petkov <bp@suse.de>
    x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP

Thomas Gleixner <tglx@linutronix.de>
    x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL

Thomas Gleixner <tglx@linutronix.de>
    KVM: SVM: Move spec control call after restore of GS

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest

Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
    x86/bugs, KVM: Support the combination of guest and host IBRS

Dan Williams <dan.j.williams@intel.com>
    x86/uaccess: Use __uaccess_begin_nospec() and uaccess_try_nospec

Dan Williams <dan.j.williams@intel.com>
    x86/usercopy: Replace open coded stac/clac with __uaccess_{begin, end}

Dan Williams <dan.j.williams@intel.com>
    x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec

Linus Torvalds <torvalds@linux-foundation.org>
    x86: fix SMAP in 32-bit environments

Linus Torvalds <torvalds@linux-foundation.org>
    x86: reorganize SMAP handling in user space accesses

Paolo Bonzini <pbonzini@redhat.com>
    KVM/x86: Remove indirect MSR op calls from SPEC_CTRL

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

Radim Krčmář <rkrcmar@redhat.com>
    KVM: nVMX: fix msr bitmaps to prevent L2 from accessing L0 x2APIC

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: pcm: remove SNDRV_PCM_IOCTL1_INFO internal command

Namhyung Kim <namhyung@kernel.org>
    pstore: Convert console write to use ->write_buf

Pan Bian <bianpan2016@163.com>
    ocfs2: fix potential use after free

Qian Cai <cai@gmx.us>
    debugobjects: avoid recursive calls with kmemleak

Pan Bian <bianpan2016@163.com>
    hfsplus: do not free node before using

Pan Bian <bianpan2016@163.com>
    hfs: do not free node before using

Larry Chen <lchen@suse.com>
    ocfs2: fix deadlock caused by ocfs2_defrag_extent()

Colin Ian King <colin.king@canonical.com>
    fscache, cachefiles: remove redundant variable 'cache'

NeilBrown <neilb@suse.com>
    fscache: fix race between enablement and dropping of object

Srikanth Boddepalli <boddepalli.srikanth@gmail.com>
    xen: xlate_mmu: add missing header to fix 'W=1' warning

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: fixed reading monitor EDID not stable issue

Pan Bian <bianpan2016@163.com>
    net: hisilicon: remove unexpected free_netdev

Josh Elsasser <jelsasser@appneta.com>
    ixgbe: recognize 1000BaseLX SFP modules as 1Gbps

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    net: thunderx: fix NULL pointer dereference in nic_remove

Yi Wang <wang.yi59@zte.com.cn>
    KVM: x86: fix empty-body warnings

Aaro Koskinen <aaro.koskinen@iki.fi>
    USB: omap_udc: fix USB gadget functionality on Palm Tungsten E

Aaro Koskinen <aaro.koskinen@iki.fi>
    USB: omap_udc: fix omap_udc_start() on 15xx machines

Aaro Koskinen <aaro.koskinen@iki.fi>
    USB: omap_udc: fix crashes on probe error and module removal

Aaro Koskinen <aaro.koskinen@iki.fi>
    USB: omap_udc: use devm_request_irq()

Martynas Pumputis <m@lambda.lt>
    bpf: fix check of allowed specifiers in bpf_trace_printk

Pan Bian <bianpan2016@163.com>
    exportfs: do not read dentry after free

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ASoC: omap-dmic: Add pm_qos handling to avoid overruns with CPU_IDLE

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ASoC: omap-mcpdm: Add pm_qos handling to avoid under/overruns with CPU_IDLE

Robbie Ko <robbieko@synology.com>
    Btrfs: send, fix infinite loop due to directory rename dependencies

Huacai Chen <chenhc@lemote.com>
    hwmon: (w83795) temp4_type has writable permission

Tzung-Bi Shih <tzungbi@google.com>
    ASoC: dapm: Recalculate audio map forcely when card instantiated

Nicolin Chen <nicoleotsuka@gmail.com>
    hwmon: (ina2xx) Fix current value calculation

Thomas Richter <tmricht@linux.ibm.com>
    s390/cpum_cf: Reject request for sampling in event initialization

YueHaibing <yuehaibing@huawei.com>
    sysv: return 'err' instead of 0 in __sysv_write_inode

Janusz Krzysztofik <jmkrzyszt@gmail.com>
    ARM: OMAP1: ams-delta: Fix possible use of uninitialized field

Nathan Chancellor <natechancellor@gmail.com>
    ARM: OMAP2+: prm44xx: Fix section annotation on omap44xx_prm_enable_io_wakeup

Jiri Wiesner <jwiesner@suse.com>
    ipv4: ipv6: netfilter: Adjust the frag mem limit when truesize changes

Stefano Brivio <sbrivio@redhat.com>
    neighbour: Avoid writing before skb->head in neigh_hh_output()

Nicolas Dichtel <nicolas.dichtel@6wind.com>
    tun: forbid iface creation with rtnl ops

Yuchung Cheng <ycheng@google.com>
    tcp: fix NULL ref in tail loss probe

Eric Dumazet <edumazet@google.com>
    rtnetlink: ndo_dflt_fdb_dump() only work for ARPHRD_ETHER devices

Christoph Paasch <cpaasch@apple.com>
    net: Prevent invalid access to skb->prev in __qdisc_drop_all

Heiner Kallweit <hkallweit1@gmail.com>
    net: phy: don't allow __set_phy_supported to add unsupported modes

Su Yanjun <suyj.fnst@cn.fujitsu.com>
    net: 8139cp: fix a BUG triggered by changing mtu with network traffic

Stefano Brivio <sbrivio@redhat.com>
    ipv6: Check available headroom in ip6_xmit() even without options


-------------

Diffstat:

 Documentation/Makefile                             |   3 +-
 Documentation/networking/Makefile                  |   1 -
 Documentation/networking/timestamping/Makefile     |  14 -
 Makefile                                           |   4 +-
 arch/arm/mach-omap1/board-ams-delta.c              |   3 +
 arch/arm/mach-omap2/prm44xx.c                      |   2 +-
 arch/cris/arch-v32/drivers/cryptocop.c             |   4 +-
 arch/ia64/kernel/err_inject.c                      |   2 +-
 arch/mips/mm/gup.c                                 |   2 +-
 arch/s390/kernel/perf_cpum_cf.c                    |   2 +
 arch/s390/mm/gup.c                                 |   2 +-
 arch/sh/mm/gup.c                                   |   3 +-
 arch/sparc/mm/gup.c                                |   3 +-
 arch/x86/include/asm/kvm_host.h                    |   2 +-
 arch/x86/include/asm/uaccess.h                     |  64 +-
 arch/x86/include/asm/uaccess_32.h                  |  26 +
 arch/x86/include/asm/uaccess_64.h                  |  94 ++-
 arch/x86/kernel/cpu/common.c                       |   3 +-
 arch/x86/kvm/cpuid.c                               |  31 +-
 arch/x86/kvm/cpuid.h                               |  40 ++
 arch/x86/kvm/lapic.c                               |   2 +-
 arch/x86/kvm/svm.c                                 | 143 +++-
 arch/x86/kvm/vmx.c                                 | 741 ++++++++++++---------
 arch/x86/kvm/x86.c                                 |  14 +-
 arch/x86/lib/usercopy_32.c                         |  20 +-
 arch/x86/mm/gup.c                                  |   2 +-
 arch/x86/mm/mpx.c                                  |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c            |   6 +-
 drivers/gpu/drm/ast/ast_mode.c                     |  36 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c            |   3 +-
 drivers/gpu/drm/i915/i915_gem_userptr.c            |   6 +-
 drivers/gpu/drm/radeon/radeon_ttm.c                |   2 +-
 drivers/gpu/drm/via/via_dmablit.c                  |   4 +-
 drivers/hwmon/ina2xx.c                             |   2 +-
 drivers/hwmon/w83795.c                             |   2 +-
 drivers/infiniband/core/umem.c                     |   6 +-
 drivers/infiniband/core/umem_odp.c                 |   7 +-
 drivers/infiniband/hw/mthca/mthca_memfree.c        |   4 +-
 drivers/infiniband/hw/qib/qib_user_pages.c         |   3 +-
 drivers/infiniband/hw/usnic/usnic_uiom.c           |   5 +-
 drivers/media/dvb-frontends/ascot2e.c              |   4 +-
 drivers/media/dvb-frontends/cxd2841er.c            |   4 +-
 drivers/media/dvb-frontends/horus3a.c              |   4 +-
 drivers/media/dvb-frontends/itd1000.c              |   5 +-
 drivers/media/dvb-frontends/mt312.c                |   5 +-
 drivers/media/dvb-frontends/stb0899_drv.c          |   3 +-
 drivers/media/dvb-frontends/stb6100.c              |   6 +-
 drivers/media/dvb-frontends/stv0367.c              |   4 +-
 drivers/media/dvb-frontends/stv090x.c              |   4 +-
 drivers/media/dvb-frontends/stv6110x.c             |   4 +-
 drivers/media/dvb-frontends/zl10039.c              |   4 +-
 drivers/media/pci/ivtv/ivtv-udma.c                 |   3 +-
 drivers/media/pci/ivtv/ivtv-yuv.c                  |   8 +-
 drivers/media/platform/omap/omap_vout.c            |   2 +-
 drivers/media/v4l2-core/videobuf-dma-sg.c          |   7 +-
 drivers/media/v4l2-core/videobuf2-memops.c         |   6 +-
 drivers/misc/mic/scif/scif_rma.c                   |   3 +-
 drivers/misc/sgi-gru/grufault.c                    |   2 +-
 drivers/net/ethernet/cavium/thunder/nic_main.c     |   3 +
 drivers/net/ethernet/hisilicon/hip04_eth.c         |   4 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      |   4 +-
 drivers/net/ethernet/realtek/8139cp.c              |   5 +
 drivers/net/ethernet/rocker/rocker.c               |  24 +-
 drivers/net/phy/phy_device.c                       |  19 +-
 drivers/net/tun.c                                  |   6 +-
 drivers/net/wireless/ath/wil6210/wmi.c             |   8 +-
 drivers/scsi/sr_ioctl.c                            |  21 +-
 drivers/scsi/st.c                                  |   5 +-
 drivers/staging/rdma/hfi1/user_pages.c             |   2 +-
 drivers/staging/rdma/ipath/ipath_user_pages.c      |   2 +-
 drivers/staging/speakup/kobjects.c                 |   4 +-
 drivers/usb/gadget/udc/omap_udc.c                  |  87 +--
 drivers/video/fbdev/matrox/matroxfb_Ti3026.c       |   2 +-
 drivers/video/fbdev/pvr2fb.c                       |   2 +-
 drivers/virt/fsl_hypervisor.c                      |   4 +-
 drivers/xen/xlate_mmu.c                            |   1 +
 fs/btrfs/send.c                                    |  11 +-
 fs/cachefiles/rdwr.c                               |   3 -
 fs/exec.c                                          |   9 +-
 fs/exportfs/expfs.c                                |   2 +-
 fs/fscache/object.c                                |   3 +
 fs/hfs/btree.c                                     |   3 +-
 fs/hfsplus/btree.c                                 |   3 +-
 fs/hugetlbfs/inode.c                               |  30 +-
 fs/ocfs2/export.c                                  |   2 +-
 fs/ocfs2/move_extents.c                            |  47 +-
 fs/proc/base.c                                     |  19 +-
 fs/pstore/platform.c                               |   4 +-
 fs/sysv/inode.c                                    |   2 +-
 include/linux/mm.h                                 |  15 +-
 include/linux/posix-timers.h                       |   4 +-
 include/net/neighbour.h                            |  28 +-
 include/sound/pcm.h                                |   2 +-
 kernel/bpf/verifier.c                              |  98 ++-
 kernel/events/uprobes.c                            |   4 +-
 kernel/time/posix-cpu-timers.c                     |   2 +-
 kernel/time/posix-timers.c                         |  29 +-
 kernel/trace/bpf_trace.c                           |   8 +-
 lib/debugobjects.c                                 |   3 +-
 lib/swiotlb.c                                      |  20 +-
 mm/frame_vector.c                                  |   9 +-
 mm/gup.c                                           |  42 +-
 mm/hugetlb.c                                       |  12 +-
 mm/memory.c                                        |  18 +-
 mm/mempolicy.c                                     |   2 +-
 mm/nommu.c                                         |  38 +-
 mm/process_vm_access.c                             |   6 +-
 mm/util.c                                          |   2 +-
 net/ceph/pagevec.c                                 |   2 +-
 net/core/rtnetlink.c                               |   3 +
 net/ipv4/ip_fragment.c                             |   7 +
 net/ipv4/tcp_output.c                              |  12 +-
 net/ipv6/ip6_output.c                              |  42 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   8 +-
 net/ipv6/reassembly.c                              |   8 +-
 net/sched/sch_netem.c                              |   3 +
 security/tomoyo/domain.c                           |   3 +-
 sound/core/pcm_lib.c                               |   2 -
 sound/core/pcm_native.c                            |   6 +-
 sound/soc/omap/omap-dmic.c                         |   9 +
 sound/soc/omap/omap-mcpdm.c                        |  43 +-
 sound/soc/soc-core.c                               |   1 +
 .../selftests}/networking/timestamping/.gitignore  |   0
 .../selftests/networking/timestamping/Makefile     |   8 +
 .../networking/timestamping/hwtstamp_config.c      |   0
 .../networking/timestamping/timestamping.c         |   0
 .../networking/timestamping/txtimestamp.c          |   0
 virt/kvm/async_pf.c                                |   2 +-
 virt/kvm/kvm_main.c                                |  11 +-
 129 files changed, 1455 insertions(+), 792 deletions(-)


