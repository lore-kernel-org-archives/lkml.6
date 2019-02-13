Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305BDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB82D20835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083761;
	bh=K4VKhz2T3gWllJXJEVwrAX8IVd0NN7K07vdHZOQG14Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=jYk75AqzD1isv9PlHPSrVB+PfitxDn9qGIGf9E4VYQScplX6NE+095N5RIGkRpVQi
	 IQLmudf9jOVVPKjy1FzHThwCQ4BZokVj4QCm5H2oILiQeccw7HKJOr8QGkekg7VmCC
	 RKm0CdAJP3+zHlvBjjgLjqL/5LOCnNsGZLb9UHk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390946AbfBMStT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:44052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388098AbfBMSpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0458D20835;
        Wed, 13 Feb 2019 18:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083524;
        bh=K4VKhz2T3gWllJXJEVwrAX8IVd0NN7K07vdHZOQG14Y=;
        h=From:To:Cc:Subject:Date:From;
        b=wXcVby+mXnb1yCCcRiqlkx+PgHYssaoIbYMlg0ElJilMVbnDwGEeDM2A+hIQRAf+s
         7d6ZIO2BP6uPqv6L3KbJyc9k8Nz0uL0MRNiDqTtJdgBGlu+Ou5nMsxntI4AVzcEY0S
         XvxhzfbBp/knP/h7PxIzl9Cv8EwFSZAbnhfYVaCI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.20 00/50] 4.20.9-stable review
Date:   Wed, 13 Feb 2019 19:38:05 +0100
Message-Id: <20190213183655.747168774@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.20.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.20.9-rc1
X-KernelTest-Deadline: 2019-02-15T18:36+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.20.9 release.
There are 50 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Feb 15 18:36:30 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.20.9-rc1

Sven Eckelmann <sven@narfation.org>
    batman-adv: Force mac header to start of data on xmit

Sven Eckelmann <sven@narfation.org>
    batman-adv: Avoid WARN on net_device without parent in netns

Florian Westphal <fw@strlen.de>
    xfrm: refine validation of template and selector families

Ilya Dryomov <idryomov@gmail.com>
    libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Theodore Ts'o <tytso@mit.edu>
    Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Try to sanitize bogus DPLL state left over by broken SNB BIOSen

Benedict Wong <benedictwong@google.com>
    xfrm: Make set-mark default behavior backward compatible

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Return error code from vmw_execbuf_copy_fence_user

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix an uninitialized fence handle value

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix setting of dma masks

Lucas De Marchi <lucas.demarchi@intel.com>
    drm/i915: always return something on DDI clock selection

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drm/amd/powerplay: Fix missing break in switch

Sandy Huang <hjc@rock-chips.com>
    drm/rockchip: rgb: update SPDX license identifier

Tina Zhang <tina.zhang@intel.com>
    drm/modes: Prevent division by zero htotal

Felix Fietkau <nbd@nbd.name>
    mac80211: ensure that mgmt tx skbs have tailroom for encryption

Vincent Whitchurch <vincent.whitchurch@axis.com>
    mic: vop: Fix use-after-free on remove

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    powerpc/radix: Fix kernel crash with mremap()

Oliver O'Halloran <oohall@gmail.com>
    powerpc/papr_scm: Use the correct bind address

Sudeep Holla <sudeep.holla@arm.com>
    firmware: arm_scmi: provide the mandatory device release callback

Bartosz Golaszewski <bgolaszewski@baylibre.com>
    ARM: dts: da850: fix interrupt numbers for clocksource

Marc Gonzalez <marc.w.gonzalez@free.fr>
    ARM: tango: Improve ARCH_MULTIPLATFORM compatibility

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: iop32x/n2100: fix PCI IRQ mapping

Paul Burton <paul.burton@mips.com>
    MIPS: VDSO: Include $(ccflags-vdso) in o32,n32 .lds builds

Yifeng Li <tomli@tomli.me>
    mips: loongson64: remove unreachable(), fix loongson_poweroff().

Paul Burton <paul.burton@mips.com>
    MIPS: VDSO: Use same -m%-float cflag as the kernel proper

Aaro Koskinen <aaro.koskinen@iki.fi>
    MIPS: OCTEON: don't set octeon_dma_bar_type if PCI is disabled

Paul Burton <paul.burton@mips.com>
    MIPS: Use lower case for addresses in nexys4ddr.dts

Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
    mips: cm: reprime error cause

Andreas Ziegler <andreas.ziegler@fau.de>
    tracing: uprobes: Fix typo in pr_fmt string

Andreas Ziegler <andreas.ziegler@fau.de>
    tracing/uprobes: Fix output for multiple string arguments

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    pinctrl: cherryview: fix Strago DMI workaround

Chen-Yu Tsai <wens@csie.org>
    pinctrl: sunxi: Correct number of IRQ banks on H6 main pin controller

Chuck Lever <chuck.lever@oracle.com>
    svcrdma: Remove max_sge check at connect time

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    debugfs: fix debugfs_rename parameter checking

Tomas Winkler <tomas.winkler@intel.com>
    samples: mei: use /dev/mei0 instead of /dev/mei

Tomas Winkler <tomas.winkler@intel.com>
    mei: me: add ice lake point device id.

Johannes Berg <johannes.berg@intel.com>
    cfg80211: call disconnect_wk when AP stops

Dan Carpenter <dan.carpenter@oracle.com>
    misc: vexpress: Off by one in vexpress_syscfg_exec()

Eric W. Biederman <ebiederm@xmission.com>
    signal: Better detection of synchronous signals

Eric W. Biederman <ebiederm@xmission.com>
    signal: Always notice exiting tasks

Eric W. Biederman <ebiederm@xmission.com>
    signal: Always attempt to allocate siginfo for SIGSTOP

Dan Murphy <dmurphy@ti.com>
    iio: ti-ads8688: Update buffer allocation for timestamps

Matt Ranostay <matt.ranostay@konsulko.com>
    iio: chemical: atlas-ph-sensor: correct IIO_TEMP values to millicelsius

Hans de Goede <hdegoede@redhat.com>
    iio: adc: axp288: Fix TS-pin handling

Martin Kelly <mkelly@xevo.com>
    tools: iio: iio_generic_buffer: make num_loops signed

Hans de Goede <hdegoede@redhat.com>
    libata: Add NOLPM quirk for SAMSUNG MZ7TE512HMHP-000L1 SSD

Martin Kepplinger <martink@posteo.de>
    mtd: rawnand: gpmi: fix MX28 bus master lockup problem

Boris Brezillon <bbrezillon@kernel.org>
    mtd: spinand: Fix the error/cleanup path in spinand_init()

Boris Brezillon <bbrezillon@kernel.org>
    mtd: spinand: Handle the case where PROGRAM LOAD does not reset the cache

Boris Brezillon <bbrezillon@kernel.org>
    mtd: Make sure mtd->erasesize is valid even if the partition is of size 0


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/arm/boot/dts/da850.dtsi                      |   2 +-
 arch/arm/mach-iop32x/n2100.c                      |   3 +-
 arch/arm/mach-tango/pm.c                          |   6 +-
 arch/arm/mach-tango/pm.h                          |   7 ++
 arch/arm/mach-tango/setup.c                       |   2 +
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts          |   8 +-
 arch/mips/kernel/mips-cm.c                        |   2 +-
 arch/mips/loongson64/common/reset.c               |   7 +-
 arch/mips/pci/pci-octeon.c                        |  10 +--
 arch/mips/vdso/Makefile                           |   5 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h      |  22 ++---
 arch/powerpc/mm/pgtable-book3s64.c                |  22 +++++
 arch/powerpc/platforms/pseries/papr_scm.c         |   5 +-
 drivers/ata/libata-core.c                         |   1 +
 drivers/firmware/arm_scmi/bus.c                   |   9 +-
 drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c |   1 +
 drivers/gpu/drm/drm_modes.c                       |   2 +-
 drivers/gpu/drm/i915/intel_ddi.c                  |   2 +-
 drivers/gpu/drm/i915/intel_display.c              |  51 +++++++++--
 drivers/gpu/drm/rockchip/rockchip_rgb.c           |  11 +--
 drivers/gpu/drm/rockchip/rockchip_rgb.h           |  11 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c               |   9 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c           |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |   4 +-
 drivers/iio/adc/axp288_adc.c                      |  76 ++++++++++++----
 drivers/iio/adc/ti-ads8688.c                      |   3 +-
 drivers/iio/chemical/atlas-ph-sensor.c            |   7 +-
 drivers/misc/mei/hw-me-regs.h                     |   2 +
 drivers/misc/mei/pci-me.c                         |   2 +
 drivers/misc/mic/vop/vop_main.c                   |   4 +-
 drivers/misc/vexpress-syscfg.c                    |   2 +-
 drivers/mtd/mtdpart.c                             |   4 +
 drivers/mtd/nand/raw/gpmi-nand/gpmi-lib.c         |  13 ++-
 drivers/mtd/nand/spi/core.c                       |  46 +++++-----
 drivers/pinctrl/intel/pinctrl-cherryview.c        |   8 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c         |   2 +-
 fs/debugfs/inode.c                                |   7 ++
 fs/ext4/fsync.c                                   |  13 +--
 kernel/signal.c                                   |  63 ++++++++++++-
 kernel/trace/trace_uprobe.c                       |   9 +-
 net/batman-adv/hard-interface.c                   |   5 +-
 net/batman-adv/soft-interface.c                   |   2 +
 net/ceph/messenger.c                              |   5 +-
 net/mac80211/tx.c                                 |  12 ++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c             | 105 ++++++++++++++++++++--
 net/sunrpc/xprtrdma/svc_rdma_transport.c          |   9 +-
 net/wireless/ap.c                                 |   2 +
 net/wireless/core.h                               |   2 +
 net/wireless/sme.c                                |   2 +-
 net/xfrm/xfrm_policy.c                            |   5 +-
 net/xfrm/xfrm_user.c                              |  13 ++-
 samples/mei/mei-amt-version.c                     |   2 +-
 tools/iio/iio_generic_buffer.c                    |   2 +-
 54 files changed, 461 insertions(+), 174 deletions(-)


