Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753329AbeFERS4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:18:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753209AbeFERFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:05:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/61] 4.9.107-stable review
Date: Tue,  5 Jun 2018 19:01:21 +0200
Message-Id: <20180605170117.643936916@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.107-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.107-rc1
X-KernelTest-Deadline: 2018-06-07T17:01+00:00
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.107 release.
There are 61 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jun  7 17:00:59 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.107-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.107-rc1

Aleksey Makarov <aleksey.makarov@linaro.org>
    serial: pl011: add console matching function

David S. Miller <davem@davemloft.net>
    sparc64: Don't clibber fixed registers in __multi4.

Hugh Dickins <hughd@google.com>
    mm: fix the NULL mapping case in __isolate_lru_page()

Al Viro <viro@zeniv.linux.org.uk>
    fix io_destroy()/aio_complete() race

David S. Miller <davem@davemloft.net>
    sparc64: Fix build warnings with gcc 7.

Ondrej Zary <linux@rainbow-software.org>
    drm/i915: Disable LVDS on Radiant P845

Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
    drm/psr: Fix missed entry in PSR setup time table.

Parav Pandit <parav@mellanox.com>
    IB/core: Fix error code for invalid GID entry

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    hwtracing: stm: fix build error on some arches

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    stm class: Use vmalloc for the master map

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: scsi_transport_srp: Fix shost to rport translation

Maciej W. Rozycki <macro@mips.com>
    MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests

Maciej W. Rozycki <macro@mips.com>
    MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs

Martin Kelly <mkelly@xevo.com>
    iio:kfifo_buf: check for uint overflow

Sarah Newman <srn@prgmr.com>
    net/mlx4_en: fix potential use-after-free with dma_unmap_page

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Add support for a store forwarding barrier at kernel entry/exit

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Fix section mismatch warnings from setup_rfi_flush()

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc/pseries: Restore default security feature flags on setup

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc: Move default security feature flags

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc/pseries: Fix clearing of security feature flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Wire up cpu_show_spectre_v2()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Wire up cpu_show_spectre_v1()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Use the security flags in pseries_setup_rfi_flush()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Use the security flags in pnv_setup_rfi_flush()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Enhance the information in cpu_show_meltdown()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Move cpu_show_meltdown()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Set or clear security feature flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Set or clear security feature flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Add security feature flags for Spectre/Meltdown

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Add new H_GET_CPU_CHARACTERISTICS flags

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Call setup_rfi_flush() after LPM migration

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    powerpc/rfi-flush: Differentiate enabled and patched flush types

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Always enable fallback flush on pseries

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Make it possible to call setup_rfi_flush() again

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Move the logic to avoid a redo into the debugfs code

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/powernv: Support firmware disable of RFI flush

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/pseries: Support firmware disable of RFI flush

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/rfi-flush: Move out of HARDLOCKUP_DETECTOR #ifdef

Mark Rutland <mark.rutland@arm.com>
    arm64/cpufeature: don't use mutex in bringup path

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Add hypervisor safe helper for checking constant capabilities

Potomski, MichalX <michalx.potomski@intel.com>
    scsi: ufs: Factor out ufshcd_read_desc_param

Tomas Winkler <tomas.winkler@intel.com>
    scsi: ufs: refactor device descriptor reading

Subhash Jadavani <subhashj@codeaurora.org>
    scsi: ufs: fix failure to read the string descriptor

Eric Dumazet <edumazet@google.com>
    tcp: avoid integer overflows in tcp_rcv_space_adjust()

Juergen Gross <jgross@suse.com>
    x86/amd: don't set X86_BUG_SYSRET_SS_ATTRS when running under Xen

Juergen Gross <jgross@suse.com>
    xen: set cpu capabilities from xen_start_kernel()

Juergen Gross <jgross@suse.com>
    x86/amd: revert commit 944e0fc51a89c9827b9

Colin Ian King <colin.king@canonical.com>
    platform/chrome: cros_ec_lpc: remove redundant pointer request

Colin Ian King <colin.king@canonical.com>
    ASoC: Intel: sst: remove redundant variable dma_dev_name

Matthias Kaehlcke <mka@chromium.org>
    rtlwifi: rtl8192cu: Remove variable self-assignment in rf.c

Colin Ian King <colin.king@canonical.com>
    dma-buf: remove redundant initialization of sg_table

Eric Biggers <ebiggers@google.com>
    cfg80211: further limit wiphy names to 64 bytes

Sachin Grover <sgrover@codeaurora.org>
    selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix crash when freeing instances with event triggers

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    Input: elan_i2c_smbus - fix corrupted stack

Mimi Zohar <zohar@linux.vnet.ibm.com>
    Revert "ima: limit file hash setting by user to fix and log modes"

Brian Foster <bfoster@redhat.com>
    xfs: detect agfl count corruption and reset agfl

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "pinctrl: msm: Use dynamic GPIO numbering"

Geert Uytterhoeven <geert@linux-m68k.org>
    USB: serial: cp210x: use tcflag_t to fix incompatible pointer type

Michael Neuling <mikey@neuling.org>
    powerpc/64s: Clear PCR on boot

Will Deacon <will.deacon@arm.com>
    arm64: lse: Add early clobbers to some input/output asm operands


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm64/include/asm/atomic_lse.h                |  22 +-
 arch/arm64/include/asm/cpufeature.h                |  27 +-
 arch/arm64/include/asm/kvm_host.h                  |  10 +-
 arch/arm64/include/asm/kvm_mmu.h                   |   2 +-
 arch/arm64/include/asm/mmu.h                       |   2 +-
 arch/arm64/kernel/cpufeature.c                     |  28 ++-
 arch/arm64/kernel/process.c                        |   2 +-
 arch/mips/kernel/process.c                         |   4 +
 arch/mips/kernel/ptrace.c                          |   2 +-
 arch/mips/kernel/ptrace32.c                        |   2 +-
 arch/powerpc/include/asm/exception-64s.h           |  29 +++
 arch/powerpc/include/asm/feature-fixups.h          |  19 ++
 arch/powerpc/include/asm/hvcall.h                  |   3 +
 arch/powerpc/include/asm/security_features.h       |  85 +++++++
 arch/powerpc/include/asm/setup.h                   |   2 +-
 arch/powerpc/kernel/Makefile                       |   2 +-
 arch/powerpc/kernel/cpu_setup_power.S              |   6 +
 arch/powerpc/kernel/exceptions-64s.S               |  16 +-
 arch/powerpc/kernel/security.c                     | 237 ++++++++++++++++++
 arch/powerpc/kernel/setup_64.c                     |  37 ++-
 arch/powerpc/kernel/vmlinux.lds.S                  |  14 ++
 arch/powerpc/lib/feature-fixups.c                  | 124 +++++++++-
 arch/powerpc/platforms/powernv/setup.c             |  92 +++++--
 arch/powerpc/platforms/pseries/mobility.c          |   3 +
 arch/powerpc/platforms/pseries/pseries.h           |   2 +
 arch/powerpc/platforms/pseries/setup.c             |  81 ++++--
 arch/sparc/kernel/ds.c                             |   2 +-
 arch/sparc/lib/multi3.S                            |  24 +-
 arch/x86/xen/enlighten.c                           |  14 +-
 drivers/dma-buf/dma-buf.c                          |   2 +-
 drivers/gpu/drm/drm_dp_helper.c                    |   1 +
 drivers/gpu/drm/i915/intel_lvds.c                  |   8 +
 drivers/hwtracing/stm/core.c                       |   7 +-
 drivers/iio/buffer/kfifo_buf.c                     |   7 +
 drivers/infiniband/core/cache.c                    |   2 +-
 drivers/input/mouse/elan_i2c_smbus.c               |  22 +-
 drivers/irqchip/irq-gic-v3.c                       |  13 +-
 drivers/net/ethernet/mellanox/mlx4/en_rx.c         |  32 ++-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/rf.c    |   3 -
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   2 +-
 drivers/platform/chrome/cros_ec_lpc.c              |   3 -
 drivers/scsi/scsi_transport_srp.c                  |  22 +-
 drivers/scsi/ufs/ufs.h                             |  34 +--
 drivers/scsi/ufs/ufs_quirks.h                      |  28 +--
 drivers/scsi/ufs/ufshcd.c                          | 272 +++++++++++++++------
 drivers/scsi/ufs/ufshcd.h                          |  16 ++
 drivers/tty/serial/amba-pl011.c                    |  55 +++++
 drivers/usb/serial/cp210x.c                        |   8 +-
 fs/aio.c                                           |   3 +-
 fs/xfs/libxfs/xfs_alloc.c                          |  94 +++++++
 fs/xfs/xfs_mount.h                                 |   1 +
 fs/xfs/xfs_trace.h                                 |   9 +-
 include/linux/tcp.h                                |   2 +-
 include/uapi/linux/nl80211.h                       |   2 +-
 kernel/trace/trace_events_trigger.c                |   5 +-
 mm/vmscan.c                                        |   2 +-
 net/ipv4/tcp_input.c                               |  10 +-
 security/integrity/ima/ima_appraise.c              |   8 +-
 security/selinux/ss/services.c                     |   2 +-
 sound/soc/intel/common/sst-firmware.c              |   2 -
 61 files changed, 1277 insertions(+), 297 deletions(-)
