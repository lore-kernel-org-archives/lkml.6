Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/SP2bVBqKJzh9g8XKyhiq8TzaXob5UT/jLWs1Y+1HotLItczG+IAFIeKsp+znKr4JLLZX8
ARC-Seal: i=1; a=rsa-sha256; t=1523981365; cv=none;
        d=google.com; s=arc-20160816;
        b=Zkh3F9fd/eeMhbjanXFqKw+93hN8dv7FM2ZEEzjQfXUDwALqGkol5top44aE1XeF0S
         tsxuOL0FhG9wvC5ki9LOl6l/LAazQr+ZdsDxcO8VeU4ndp+d799afmoo6DBNK5zxJixx
         zpQIG6pi9iyGZ6WNYhMYjPMfU+ZNVaeyisxnNasVNzr/hhZI0rWWWahcBmPKFW82JwJ0
         ZgVQrighaFUKrObwkeYiwzWdq0k9U5TNgvOJlG/43MkFo897z60EL/Nxv707J7/Jx+xZ
         nrsV3FQEdjPniorVfCA5TuZiCYRfEHYju7+OX4Fol43flOU4ioPSWWzgP5gKxNNHsZlD
         +FKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=sdCXtLWcYDRYzJDwGV1ucmsO9UIqsM5nGrlmsTyEQog=;
        b=gNDn4RibW3JjEGQJFi2+fOrbFxYNn7rbUXh8M50s1MnpPHrVW/wofN5WYChfRYcg+3
         0PshQtgxqoHDnDqNfcJtvrQMZmgt9TSjsmJABBSUtj2pFj/gOTuwGoYO7oPf6t3tolJe
         tEXA008GHfUs+3IUaTFwkOZc1678F5L0XmMIKd8UY8WMF4Q2PCPXZ4yOWkEHdoaTsZgQ
         9gD9PO/wKydvH0yz6gufie3HYvOWUsImHdkj2UUhUiRa+2y8BhirAL4j+VUCgnIISPpj
         a8DAOiXcfRxhhI7Bi5QJW/CCiBQGX43aNvnPoVVcxGSgUX/p989H0JqizbfezMRuLpld
         ug0g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.9 00/66] 4.9.95-stable review
Date: Tue, 17 Apr 2018 17:58:33 +0200
Message-Id: <20180417155645.868055442@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.95-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.95-rc1
X-KernelTest-Deadline: 2018-04-19T15:56+00:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010284891206038?=
X-GMAIL-MSGID: =?utf-8?q?1598010284891206038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.95 release.
There are 66 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Apr 19 15:56:27 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.95-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.95-rc1

Phil Elwell <phil@raspberrypi.org>
    lan78xx: Correctly indicate invalid OTP

Stefan Hajnoczi <stefanha@redhat.com>
    vhost: fix vhost_vq_access_ok() log check

Tejaswi Tanikella <tejaswit@codeaurora.org>
    slip: Check if rstate is initialized before uncompressing

Ka-Cheong Poon <ka-cheong.poon@oracle.com>
    rds: MP-RDS may use an invalid c_path

Bassem Boubaker <bassem.boubaker@actia.fr>
    cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN

Marek Szyprowski <m.szyprowski@samsung.com>
    hwmon: (ina2xx) Fix access to uninitialized mutex

Sudhir Sreedharan <ssreedharan@mvista.com>
    rtl8187: Fix NULL pointer dereference in priv->conf_mutex

Szymon Janc <szymon.janc@codecoup.pl>
    Bluetooth: Fix connection if directed advertising and privacy is used

Al Viro <viro@zeniv.linux.org.uk>
    getname_kernel() needs to make sure that ->name != ->iname in long case

Vasily Gorbik <gor@linux.ibm.com>
    s390/ipl: ensure loadparm valid flag is set

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qdio: don't merge ERROR output buffers

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qdio: don't retry EQBS after CCQ 96

Dan Williams <dan.j.williams@intel.com>
    nfit: fix region registration vs block-data-window ranges

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    block/loop: fix deadlock after loop_set_status

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "perf tests: Decompress kernel module before objdump"

Eric Biggers <ebiggers@google.com>
    sunrpc: remove incorrect HMAC request initialization

Mark Rutland <mark.rutland@arm.com>
    arm64: Kill PSCI_GET_VERSION as a variant-2 workaround

Mark Rutland <mark.rutland@arm.com>
    arm64: Add ARM_SMCCC_ARCH_WORKAROUND_1 BP hardening support

Mark Rutland <mark.rutland@arm.com>
    arm/arm64: smccc: Implement SMCCC v1.1 inline primitive

Mark Rutland <mark.rutland@arm.com>
    arm/arm64: smccc: Make function identifiers an unsigned quantity

Mark Rutland <mark.rutland@arm.com>
    firmware/psci: Expose SMCCC version through psci_ops

Mark Rutland <mark.rutland@arm.com>
    firmware/psci: Expose PSCI conduit

Mark Rutland <mark.rutland@arm.com>
    arm64: KVM: Add SMCCC_ARCH_WORKAROUND_1 fast handling

Mark Rutland <mark.rutland@arm.com>
    arm64: KVM: Report SMCCC_ARCH_WORKAROUND_1 BP hardening support

Mark Rutland <mark.rutland@arm.com>
    arm/arm64: KVM: Turn kvm_psci_version into a static inline

Mark Rutland <mark.rutland@arm.com>
    arm64: KVM: Make PSCI_VERSION a fast path

Mark Rutland <mark.rutland@arm.com>
    arm/arm64: KVM: Advertise SMCCC v1.1

Mark Rutland <mark.rutland@arm.com>
    arm/arm64: KVM: Implement PSCI 1.0 support

Mark Rutland <mark.rutland@arm.com>
    arm/arm64: KVM: Add smccc accessors to PSCI code

Mark Rutland <mark.rutland@arm.com>
    arm/arm64: KVM: Add PSCI_VERSION helper

Mark Rutland <mark.rutland@arm.com>
    arm/arm64: KVM: Consolidate the PSCI include files

Mark Rutland <mark.rutland@arm.com>
    arm64: KVM: Increment PC after handling an SMC trap

Mark Rutland <mark.rutland@arm.com>
    arm64: Branch predictor hardening for Cavium ThunderX2

Mark Rutland <mark.rutland@arm.com>
    arm64: Implement branch predictor hardening for affected Cortex-A CPUs

Mark Rutland <mark.rutland@arm.com>
    arm64: cpu_errata: Allow an erratum to be match for all revisions of a core

Mark Rutland <mark.rutland@arm.com>
    arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75

Mark Rutland <mark.rutland@arm.com>
    arm64: entry: Apply BP hardening for suspicious interrupts from EL0

Mark Rutland <mark.rutland@arm.com>
    arm64: entry: Apply BP hardening for high-priority synchronous exceptions

Mark Rutland <mark.rutland@arm.com>
    arm64: KVM: Use per-CPU vector when BP hardening is enabled

Mark Rutland <mark.rutland@arm.com>
    mm: Introduce lm_alias

Mark Rutland <mark.rutland@arm.com>
    arm64: Move BP hardening to check_and_switch_context

Mark Rutland <mark.rutland@arm.com>
    arm64: Add skeleton to harden the branch predictor against aliasing attacks

Mark Rutland <mark.rutland@arm.com>
    arm64: Move post_ttbr_update_workaround to C code

Mark Rutland <mark.rutland@arm.com>
    arm64: Factor out TTBR0_EL1 post-update workaround into a specific asm macro

Mark Rutland <mark.rutland@arm.com>
    drivers/firmware: Expose psci_get_version through psci_ops structure

Mark Rutland <mark.rutland@arm.com>
    arm64: cpufeature: Pass capability structure to ->enable callback

Mark Rutland <mark.rutland@arm.com>
    arm64: Run enable method for errata work arounds on late CPUs

Mark Rutland <mark.rutland@arm.com>
    arm64: cpufeature: __this_cpu_has_cap() shouldn't stop early

Mark Rutland <mark.rutland@arm.com>
    arm64: uaccess: Mask __user pointers for __arch_{clear, copy_*}_user

Mark Rutland <mark.rutland@arm.com>
    arm64: uaccess: Don't bother eliding access_ok checks in __{get, put}_user

Mark Rutland <mark.rutland@arm.com>
    arm64: uaccess: Prevent speculative use of the current addr_limit

Mark Rutland <mark.rutland@arm.com>
    arm64: entry: Ensure branch through syscall table is bounded under speculation

Mark Rutland <mark.rutland@arm.com>
    arm64: Use pointer masking to limit uaccess speculation

Mark Rutland <mark.rutland@arm.com>
    arm64: Make USER_DS an inclusive limit

Mark Rutland <mark.rutland@arm.com>
    arm64: move TASK_* definitions to <asm/processor.h>

Mark Rutland <mark.rutland@arm.com>
    arm64: Implement array_index_mask_nospec()

Mark Rutland <mark.rutland@arm.com>
    arm64: barrier: Add CSDB macros to control data-value prediction

Arnd Bergmann <arnd@arndb.de>
    radeon: hide pointless #warning when compile testing

Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
    perf/core: Fix use-after-free in uprobe_perf_close()

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix timestamp following overflow

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix error recovery from missing TIP packet

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix sync_switch

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix overlap detection to identify consecutive buffers correctly

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: do not mark HV_PCIE as perf_device

Helge Deller <deller@gmx.de>
    parisc: Fix out of array access in match_pci_device()

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: v4l2-compat-ioctl32: don't oops on overlay


-------------

Diffstat:

 Makefile                                           |    4 +-
 arch/arm/include/asm/kvm_host.h                    |    6 +
 arch/arm/include/asm/kvm_mmu.h                     |   10 +
 arch/arm/include/asm/kvm_psci.h                    |   27 -
 arch/arm/kvm/arm.c                                 |   11 +-
 arch/arm/kvm/handle_exit.c                         |    4 +-
 arch/arm/kvm/psci.c                                |  143 +-
 arch/arm64/Kconfig                                 |   17 +
 arch/arm64/crypto/sha256-core.S                    | 2061 ++++++++++++++++++++
 arch/arm64/crypto/sha512-core.S                    | 1085 +++++++++++
 arch/arm64/include/asm/assembler.h                 |   19 +
 arch/arm64/include/asm/barrier.h                   |   23 +
 arch/arm64/include/asm/cpucaps.h                   |    3 +-
 arch/arm64/include/asm/cputype.h                   |    6 +
 arch/arm64/include/asm/kvm_host.h                  |    5 +
 arch/arm64/include/asm/kvm_mmu.h                   |   38 +
 arch/arm64/include/asm/kvm_psci.h                  |   27 -
 arch/arm64/include/asm/memory.h                    |   15 -
 arch/arm64/include/asm/mmu.h                       |   39 +
 arch/arm64/include/asm/processor.h                 |   24 +
 arch/arm64/include/asm/sysreg.h                    |    2 +
 arch/arm64/include/asm/uaccess.h                   |  153 +-
 arch/arm64/kernel/Makefile                         |    4 +
 arch/arm64/kernel/arm64ksyms.c                     |    4 +-
 arch/arm64/kernel/bpi.S                            |   75 +
 arch/arm64/kernel/cpu_errata.c                     |  189 +-
 arch/arm64/kernel/cpufeature.c                     |   10 +-
 arch/arm64/kernel/entry.S                          |   25 +-
 arch/arm64/kvm/handle_exit.c                       |   16 +-
 arch/arm64/kvm/hyp/hyp-entry.S                     |   20 +-
 arch/arm64/kvm/hyp/switch.c                        |    5 +-
 arch/arm64/lib/clear_user.S                        |    6 +-
 arch/arm64/lib/copy_in_user.S                      |    4 +-
 arch/arm64/mm/context.c                            |   12 +
 arch/arm64/mm/fault.c                              |   34 +-
 arch/arm64/mm/proc.S                               |    7 +-
 arch/parisc/kernel/drivers.c                       |    4 +
 arch/s390/kernel/ipl.c                             |    1 +
 drivers/acpi/nfit/core.c                           |   22 +-
 drivers/block/loop.c                               |   12 +-
 drivers/firmware/psci.c                            |   57 +-
 drivers/gpu/drm/radeon/radeon_object.c             |    3 +-
 drivers/hv/channel_mgmt.c                          |    2 +-
 drivers/hwmon/ina2xx.c                             |    3 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |    4 +-
 drivers/net/slip/slhc.c                            |    5 +
 drivers/net/usb/cdc_ether.c                        |    6 +
 drivers/net/usb/lan78xx.c                          |    3 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    2 +-
 drivers/s390/cio/qdio_main.c                       |   42 +-
 drivers/vhost/vhost.c                              |    8 +-
 fs/namei.c                                         |    3 +-
 include/kvm/arm_psci.h                             |   51 +
 include/linux/arm-smccc.h                          |  165 +-
 include/linux/mm.h                                 |    4 +
 include/linux/psci.h                               |   14 +
 include/net/bluetooth/hci_core.h                   |    2 +-
 include/net/slhc_vj.h                              |    1 +
 include/uapi/linux/psci.h                          |    3 +
 kernel/events/core.c                               |    6 +
 net/bluetooth/hci_conn.c                           |   29 +-
 net/bluetooth/hci_event.c                          |   15 +-
 net/bluetooth/l2cap_core.c                         |    2 +-
 net/rds/send.c                                     |   15 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c              |    3 -
 tools/perf/tests/code-reading.c                    |   20 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |   64 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |    2 +-
 tools/perf/util/intel-pt.c                         |   37 +-
 69 files changed, 4423 insertions(+), 320 deletions(-)
