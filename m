Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4643C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA4F21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 17:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dY3X7fEW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA4F21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbeJSCAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:00:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbeJSCAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:00:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44AF521479;
        Thu, 18 Oct 2018 17:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885514;
        bh=AaVLTS/JSVx+hMfNZHVPWLPCq6egaRCNWHvWuRcjKc4=;
        h=From:To:Cc:Subject:Date:From;
        b=dY3X7fEWi8KpLsvIIy48nZJQOXI20eDxwqxxsl4lDCoOEzMLFoRc6o2tbJmMBK6+g
         O7yFdTxCalHoZ5lRB/wlkFTNrJEitB7byl4JDqF5Gpj103s6cQric2LPa2qJZqB82x
         cd2g2UzT/lHJO9BRRnysP8Z94puwQnAPB11BlIJU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.18 00/53] 4.18.16-stable review
Date:   Thu, 18 Oct 2018 19:53:53 +0200
Message-Id: <20181018175416.561567978@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.16-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.18.16-rc1
X-KernelTest-Deadline: 2018-10-20T17:54+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.18.16 release.
There are 53 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Oct 20 17:53:52 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.18.16-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.18.16-rc1

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: build: Don't set CROSS_COMPILE in arch's Makefile

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: build: Get rid of toolchain check

Linus Torvalds <torvalds@linux-foundation.org>
    mremap: properly flush TLB before releasing the page

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "vfs: fix freeze protection in mnt_want_write_file() for overlayfs"

Kairui Song <kasong@redhat.com>
    x86/boot: Fix kexec booting failure in the SEV bit detection code

Arindam Nath <arindam.nath@amd.com>
    iommu/amd: Return devid as alias for ACPI HID devices

Srikar Dronamraju <srikar@linux.vnet.ibm.com>
    powerpc/numa: Use associativity if VPHN hcall is successful

Michael Neuling <mikey@neuling.org>
    powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Michael Neuling <mikey@neuling.org>
    powerpc/tm: Fix userspace r13 corruption

Daniel Kurtz <djkurtz@chromium.org>
    pinctrl/amd: poll InterruptEnable bits in amd_gpio_irq_set_type

Heiko Stuebner <heiko@sntech.de>
    iommu/rockchip: Free irqs in shutdown handler

James Cowgill <jcowgill@debian.org>
    RISC-V: include linux/ftrace.h in asm-prototypes.h

Selvin Xavier <selvin.xavier@broadcom.com>
    RDMA/bnxt_re: Fix system crash during RDMA resource initialization

Tao Ren <taoren@fb.com>
    clocksource/drivers/fttmr010: Fix set_next_event handler

Nathan Chancellor <natechancellor@gmail.com>
    net/mlx4: Use cpumask_available for eq->affinity_mask

John Fastabend <john.fastabend@gmail.com>
    bpf: test_maps, only support ESTABLISHED socks

John Fastabend <john.fastabend@gmail.com>
    bpf: sockmap, fix transition through disconnect without close

John Fastabend <john.fastabend@gmail.com>
    bpf: sockmap only allow ESTABLISHED sock state

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sd: don't crash the host on invalid commands

Wen Xiong <wenxiong@linux.vnet.ibm.com>
    scsi: ipr: System hung while dlpar adding primary ipr adapter back

Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
    drm: mali-dp: Call drm_crtc_vblank_reset on device init

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Synchronize access to remoteport via rport

Majd Dibbiny <majd@mellanox.com>
    RDMA/uverbs: Fix validity check for modify QP

Jisheng Zhang <Jisheng.Zhang@synaptics.com>
    PCI: dwc: Fix scheduling while atomic issues

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Do not add VLAN 0 tag to untagged frames in multi-function mode.

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    qed: Fix populating the invalid stag value in multi function mode.

YueHaibing <yuehaibing@huawei.com>
    net/smc: fix sizeof to int comparison

Ursula Braun <ubraun@linux.ibm.com>
    net/smc: fix non-blocking connect problem

Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
    ravb: do not write 1 to reserved bits

Christian Lamparter <chunkeey@gmail.com>
    net: emac: fix fixed-link setup for the RTL8363SB switch

Sabrina Dubroca <sd@queasysnail.net>
    selftests: pmtu: properly redirect stderr to /dev/null

Michael Schmitz <schmitzmic@gmail.com>
    Input: atakbd - fix Atari CapsLock behaviour

Andreas Schwab <schwab@linux-m68k.org>
    Input: atakbd - fix Atari keymap

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: pci: Add Ice Lake PCH support

Laura Abbott <labbott@redhat.com>
    scsi: ibmvscsis: Ensure partition name is properly NUL terminated

Laura Abbott <labbott@redhat.com>
    scsi: ibmvscsis: Fix a stringop-overflow warning

Keerthy <j-keerthy@ti.com>
    clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for non-am43 SoCs

Steve Wise <swise@opengridcomputing.com>
    cxgb4: fix abort_req_rss6 struct

Marek Lindner <mareklindner@neomailbox.ch>
    batman-adv: fix hardif_neigh refcount on queue_work() failure

Marek Lindner <mareklindner@neomailbox.ch>
    batman-adv: fix backbone_gw refcount on queue_work() failure

Sven Eckelmann <sven@narfation.org>
    batman-adv: Prevent duplicated tvlv handler

Sven Eckelmann <sven@narfation.org>
    batman-adv: Prevent duplicated global TT entry

Sven Eckelmann <sven@narfation.org>
    batman-adv: Prevent duplicated softif_vlan entry

Sven Eckelmann <sven@narfation.org>
    batman-adv: Prevent duplicated nc_node entry

Sven Eckelmann <sven@narfation.org>
    batman-adv: Prevent duplicated gateway_node entry

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix segfault when writing to sysfs elp_interval

Sven Eckelmann <sven@narfation.org>
    batman-adv: Fix segfault when writing to throughput_override

Sven Eckelmann <sven@narfation.org>
    batman-adv: Avoid probe ELP information leak

Linus Walleij <linus.walleij@linaro.org>
    spi: gpio: Fix copy-and-paste error

Jozef Balga <jozef.balga@gmail.com>
    media: af9035: prevent buffer overflow on write

Sanyog Kale <sanyog.r.kale@intel.com>
    soundwire: Fix acquiring bus lock twice during master release

Shreyas NC <shreyas.nc@intel.com>
    soundwire: Fix incorrect exit after configuring stream

Shreyas NC <shreyas.nc@intel.com>
    soundwire: Fix duplicate stream state assignment


-------------

Diffstat:

 Makefile                                     |   4 +-
 arch/arc/Makefile                            |  24 +-----
 arch/powerpc/kernel/tm.S                     |  20 ++++-
 arch/powerpc/mm/numa.c                       |   4 +-
 arch/riscv/include/asm/asm-prototypes.h      |   7 ++
 arch/x86/boot/compressed/mem_encrypt.S       |  19 -----
 drivers/clocksource/timer-fttmr010.c         |  18 +++--
 drivers/clocksource/timer-ti-32k.c           |   3 +
 drivers/gpu/drm/arm/malidp_drv.c             |   1 +
 drivers/hwtracing/intel_th/pci.c             |   5 ++
 drivers/infiniband/core/uverbs_cmd.c         |  68 +++++++++++------
 drivers/infiniband/hw/bnxt_re/main.c         |  93 ++++++++++-------------
 drivers/input/keyboard/atakbd.c              |  74 +++++++------------
 drivers/iommu/amd_iommu.c                    |   6 ++
 drivers/iommu/rockchip-iommu.c               |   6 ++
 drivers/media/usb/dvb-usb-v2/af9035.c        |   6 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_msg.h  |   1 -
 drivers/net/ethernet/ibm/emac/core.c         |  15 ++--
 drivers/net/ethernet/mellanox/mlx4/eq.c      |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.c   |   9 ++-
 drivers/net/ethernet/qlogic/qed/qed_dcbx.h   |   1 +
 drivers/net/ethernet/qlogic/qed/qed_dev.c    |  15 +++-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h    |   4 +
 drivers/net/ethernet/renesas/ravb.h          |   5 ++
 drivers/net/ethernet/renesas/ravb_main.c     |  11 +--
 drivers/net/ethernet/renesas/ravb_ptp.c      |   2 +-
 drivers/pci/controller/dwc/pcie-designware.c |   8 +-
 drivers/pci/controller/dwc/pcie-designware.h |   3 +-
 drivers/pinctrl/pinctrl-amd.c                |  33 ++++++---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c     |   5 +-
 drivers/scsi/ipr.c                           | 106 +++++++++++++++------------
 drivers/scsi/ipr.h                           |   1 +
 drivers/scsi/lpfc/lpfc_attr.c                |  15 ++--
 drivers/scsi/lpfc/lpfc_debugfs.c             |  10 +--
 drivers/scsi/lpfc/lpfc_nvme.c                |  11 ++-
 drivers/scsi/sd.c                            |   3 +-
 drivers/soundwire/stream.c                   |  23 ++++--
 drivers/spi/spi-gpio.c                       |   4 +-
 fs/namespace.c                               |   7 +-
 include/linux/huge_mm.h                      |   2 +-
 kernel/bpf/sockmap.c                         |  91 ++++++++++++++++++-----
 mm/huge_memory.c                             |  10 +--
 mm/mremap.c                                  |  30 ++++----
 net/batman-adv/bat_v_elp.c                   |  10 ++-
 net/batman-adv/bridge_loop_avoidance.c       |  10 ++-
 net/batman-adv/gateway_client.c              |  11 ++-
 net/batman-adv/network-coding.c              |  27 ++++---
 net/batman-adv/soft-interface.c              |  25 +++++--
 net/batman-adv/sysfs.c                       |  30 +++++---
 net/batman-adv/translation-table.c           |   6 +-
 net/batman-adv/tvlv.c                        |   8 +-
 net/smc/af_smc.c                             |   7 +-
 net/smc/smc_clc.c                            |  14 ++--
 tools/testing/selftests/bpf/test_maps.c      |  10 ++-
 tools/testing/selftests/net/pmtu.sh          |   4 +-
 55 files changed, 563 insertions(+), 385 deletions(-)


