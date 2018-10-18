Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309C9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CE021479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yt3SOHSd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CE021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbeJSCEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeJSCEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:04:10 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0476D2148D;
        Thu, 18 Oct 2018 18:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885723;
        bh=+HFiUT+PpIA7lx0hS74prd+yG1Y5yIuWr90mXMZEp2w=;
        h=From:To:Cc:Subject:Date:From;
        b=Yt3SOHSdRSLy0yW0JB0xnPZJCHxZDDktVhKy20ZnWoGIhZBTuGQi6EL2FDVe35V/t
         jO3tix2qGGr0HHp1e1izfhUGlN7yLdCGPUFqyONyIMYXLQexrR2PI0iUELVL4/6o7Q
         VrRJI5j1OYqVF65cyPyegfSQRHJsWrpE3WWkxWBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/41] 4.14.78-stable review
Date:   Thu, 18 Oct 2018 19:54:15 +0200
Message-Id: <20181018175416.718399607@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.78-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.78-rc1
X-KernelTest-Deadline: 2018-10-20T17:54+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.78 release.
There are 41 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Oct 20 17:53:55 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.78-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.78-rc1

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Fix destroy_qp hang after a link down

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: handle RXDMA HW behaviour on Gen3

Clint Taylor <clinton.a.taylor@intel.com>
    drm/i915/glk: Add Quirk for GLK NUC HDMI port issues.

Dave Jiang <dave.jiang@intel.com>
    mm: disallow mappings that conflict for devm_memremap_pages()

Gilad Ben-Yossef <gilad@benyossef.com>
    staging: ccree: check DMA pool buf !NULL before free

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Nuke the LVDS lid notifier

Natanael Copa <ncopa@alpinelinux.org>
    HID: quirks: fix support for Apple Magic Keyboards

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: build: Don't set CROSS_COMPILE in arch's Makefile

Alexey Brodkin <abrodkin@synopsys.com>
    ARC: build: Get rid of toolchain check

Linus Torvalds <torvalds@linux-foundation.org>
    mremap: properly flush TLB before releasing the page

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "vfs: fix freeze protection in mnt_want_write_file() for overlayfs"

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/lib/feature-fixups: use raw_patch_instruction()

Arindam Nath <arindam.nath@amd.com>
    iommu/amd: Return devid as alias for ACPI HID devices

Michael Neuling <mikey@neuling.org>
    powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Michael Neuling <mikey@neuling.org>
    powerpc/tm: Fix userspace r13 corruption

James Cowgill <jcowgill@debian.org>
    RISC-V: include linux/ftrace.h in asm-prototypes.h

Tao Ren <taoren@fb.com>
    clocksource/drivers/fttmr010: Fix set_next_event handler

Nathan Chancellor <natechancellor@gmail.com>
    net/mlx4: Use cpumask_available for eq->affinity_mask

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: sd: don't crash the host on invalid commands

Wen Xiong <wenxiong@linux.vnet.ibm.com>
    scsi: ipr: System hung while dlpar adding primary ipr adapter back

Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
    drm: mali-dp: Call drm_crtc_vblank_reset on device init

Jisheng Zhang <Jisheng.Zhang@synaptics.com>
    PCI: dwc: Fix scheduling while atomic issues

Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
    ravb: do not write 1 to reserved bits

Christian Lamparter <chunkeey@gmail.com>
    net: emac: fix fixed-link setup for the RTL8363SB switch

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

Jozef Balga <jozef.balga@gmail.com>
    media: af9035: prevent buffer overflow on write


-------------

Diffstat:

 Makefile                                 |   4 +-
 arch/arc/Makefile                        |  24 +-----
 arch/powerpc/include/asm/code-patching.h |   1 +
 arch/powerpc/kernel/tm.S                 |  20 ++++-
 arch/powerpc/lib/code-patching.c         |   4 +-
 arch/powerpc/lib/feature-fixups.c        |   8 +-
 arch/riscv/include/asm/asm-prototypes.h  |   7 ++
 drivers/clocksource/timer-fttmr010.c     |  18 ++--
 drivers/clocksource/timer-ti-32k.c       |   3 +
 drivers/gpu/drm/arm/malidp_drv.c         |   1 +
 drivers/gpu/drm/i915/i915_drv.c          |  10 ---
 drivers/gpu/drm/i915/i915_drv.h          |   9 +-
 drivers/gpu/drm/i915/intel_ddi.c         |  13 ++-
 drivers/gpu/drm/i915/intel_display.c     |  21 ++++-
 drivers/gpu/drm/i915/intel_drv.h         |   3 +-
 drivers/gpu/drm/i915/intel_lvds.c        | 136 +------------------------------
 drivers/hid/hid-core.c                   |   3 +
 drivers/hwtracing/intel_th/pci.c         |   5 ++
 drivers/i2c/busses/i2c-rcar.c            |  54 +++++++++++-
 drivers/infiniband/hw/hfi1/chip.c        |   7 +-
 drivers/infiniband/hw/hfi1/pio.c         |  42 ++++++++--
 drivers/infiniband/hw/hfi1/pio.h         |   2 +
 drivers/input/keyboard/atakbd.c          |  74 +++++++----------
 drivers/iommu/amd_iommu.c                |   6 ++
 drivers/media/usb/dvb-usb-v2/af9035.c    |   6 +-
 drivers/net/ethernet/ibm/emac/core.c     |  15 ++--
 drivers/net/ethernet/mellanox/mlx4/eq.c  |   3 +-
 drivers/net/ethernet/renesas/ravb.h      |   5 ++
 drivers/net/ethernet/renesas/ravb_main.c |  11 +--
 drivers/net/ethernet/renesas/ravb_ptp.c  |   2 +-
 drivers/pci/dwc/pcie-designware.c        |   8 +-
 drivers/pci/dwc/pcie-designware.h        |   3 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c |   5 +-
 drivers/scsi/ipr.c                       | 106 ++++++++++++++----------
 drivers/scsi/ipr.h                       |   1 +
 drivers/scsi/sd.c                        |   3 +-
 drivers/staging/ccree/ssi_buffer_mgr.c   |   3 +-
 fs/namespace.c                           |   7 +-
 include/linux/huge_mm.h                  |   2 +-
 kernel/memremap.c                        |  18 +++-
 mm/huge_memory.c                         |  10 +--
 mm/mremap.c                              |  30 +++----
 net/batman-adv/bat_v_elp.c               |  10 ++-
 net/batman-adv/bridge_loop_avoidance.c   |  10 ++-
 net/batman-adv/gateway_client.c          |  11 ++-
 net/batman-adv/network-coding.c          |  27 +++---
 net/batman-adv/soft-interface.c          |  25 ++++--
 net/batman-adv/sysfs.c                   |  30 ++++---
 net/batman-adv/translation-table.c       |   6 +-
 net/batman-adv/tvlv.c                    |   8 +-
 50 files changed, 445 insertions(+), 395 deletions(-)


