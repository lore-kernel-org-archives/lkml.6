Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EF7ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF432145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF432145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbeIXR55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:57:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51980 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbeIXR54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:57:56 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4C291073;
        Mon, 24 Sep 2018 11:56:07 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/70] 4.4.158-stable review
Date:   Mon, 24 Sep 2018 13:51:59 +0200
Message-Id: <20180924113058.420454070@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.158-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.158-rc1
X-KernelTest-Deadline: 2018-09-26T11:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.158 release.
There are 70 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep 26 11:30:25 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.158-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.158-rc1

Paul Burton <paul.burton@imgtec.com>
    MIPS: VDSO: Drop gic_get_usm_range() usage

Paul Burton <paul.burton@mips.com>
    MIPS: VDSO: Match data page cache colouring when D$ aliases

David Rivshin <drivshin@allworx.com>
    drivers: net: cpsw: fix segfault in case of bad phy-handle

Dan Carpenter <dan.carpenter@oracle.com>
    mei: bus: type promotion bug in mei_nfc_if_version()

Johan Hovold <johan@kernel.org>
    USB: serial: ti_usb_3410_5052: fix array underflow in completion handler

Douglas Anderson <dianders@chromium.org>
    pinctrl: qcom: spmi-gpio: Fix pmic_gpio_config_get() to be compliant

Bart Van Assche <bart.vanassche@wdc.com>
    IB/nes: Fix a compiler warning

Dan Carpenter <dan.carpenter@oracle.com>
    drm/panel: type promotion bug in s6e8aa0_read_mtp_id()

John Stultz <john.stultz@linaro.org>
    selftest: timers: Tweak raw_skew to SKIP when ADJ_OFFSET/other clock adjustments are in progress

Timo Wischer <twischer@de.adit-jv.com>
    ALSA: pcm: Fix snd_interval_refine first/last with open min/max

Zhouyang Jia <jiazhouyang09@gmail.com>
    rtc: bq4802: add error handling for devm_ioremap

Wei Lu <wei.lu2@amd.com>
    drm/amdkfd: Fix error codes in kfd_get_process

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: Mark gpio_suffixes array with __maybe_unused

Robin Murphy <robin.murphy@arm.com>
    coresight: tpiu: Fix disabling timeouts

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: Handle errors in finding input/output ports

Julia Lawall <Julia.Lawall@lip6.fr>
    parport: sunbpp: fix error return code

Thierry Reding <treding@nvidia.com>
    drm/nouveau: tegra: Detach from ARM DMA/IOMMU mapping

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: check of_iomap and fix missing of_node_put

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: fix error handling and missing of_node_put

Nicholas Mc Guire <hofrat@osadl.org>
    ARM: hisi: handle of_iomap and fix missing of_node_put

Paul Burton <paul.burton@mips.com>
    MIPS: loongson64: cs5536: Fix PCI_OHCI_INT_REG reads

Jann Horn <jannh@google.com>
    mtdchar: fix overflows in adjustment of `count`

Ronny Chevalier <ronny.chevalier@hp.com>
    audit: fix use-after-free in audit_add_watch

Maciej W. Rozycki <macro@mips.com>
    binfmt_elf: Respect error return from `regset->active'

Dan Carpenter <dan.carpenter@oracle.com>
    CIFS: fix wrapping bugs in num_entries()

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: prevent integer overflow in nxt_dir_entry()

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()

Ben Hutchings <ben.hutchings@codethink.co.uk>
    USB: yurex: Fix buffer over-read in yurex_write()

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: misc: uss720: Fix two sleep-in-atomic-context bugs

Johan Hovold <johan@kernel.org>
    USB: serial: io_ti: fix array underflow in completion handler

Alan Stern <stern@rowland.harvard.edu>
    USB: net2280: Fix erroneous synchronization change

Maxence Duprès <xpros64@hotmail.fr>
    USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C USB controller

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_frame()

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: Avoid use-after-free by flushing endpoints early in usb_set_interface()

Tim Anderson <tsa@biglakesoftware.com>
    USB: Add quirk to support DJI CineSSD

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: Don't die twice if PCI xhci host is not responding in resume

Gustavo A. R. Silva <gustavo@embeddedor.com>
    misc: hmc6352: fix potential Spectre v1

K. Y. Srinivasan <kys@microsoft.com>
    Tools: hv: Fix a bug in the key delete code

Aaron Knister <aaron.s.knister@nasa.gov>
    IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler

Juergen Gross <jgross@suse.com>
    xen/netfront: fix waiting for xenbus state change

Bin Yang <bin.yang@intel.com>
    pstore: Fix incorrect persistent ram buffer mapping

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Protect cma dev list with lock

Xiao Liang <xiliang@redhat.com>
    xen-netfront: fix warn message as irq device name has '/'

Michael Müller <michael@fds-team.de>
    crypto: sharah - Unregister correct algorithms for SAHARA 3

Randy Dunlap <rdunlap@infradead.org>
    platform/x86: toshiba_acpi: Fix defined but not used build warnings

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: reset layer2 attribute on layer switch

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix race in used-buffer accounting

Loic Poulain <loic.poulain@linaro.org>
    arm64: dts: qcom: db410c: Fix Bluetooth LED trigger

Vitaly Kuznetsov <vkuznets@redhat.com>
    xen-netfront: fix queue name setting

Manikanta Pubbisetty <mpubbise@codeaurora.org>
    mac80211: restrict delayed tailroom needed decrement

Paul Cercueil <paul@crapouillou.net>
    MIPS: jz4740: Bump zload address

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: opal_put_chars partial write fix

Sandipan Das <sandipan@linux.ibm.com>
    perf powerpc: Fix callchain ip filtering

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: exynos: Clear global variable on init error path

Fredrik Noring <noring@nocrew.org>
    fbdev: Distinguish between interlaced and progressive modes

Sandipan Das <sandipan@linux.ibm.com>
    perf powerpc: Fix callchain ip filtering when return address is in a register

Randy Dunlap <rdunlap@infradead.org>
    fbdev/via: fix defined but not used warning

Anton Vasilyev <vasilyev@ispras.ru>
    video: goldfishfb: fix memory leak on driver remove

Dan Carpenter <dan.carpenter@oracle.com>
    fbdev: omapfb: off by one in omapfb_register_client()

Randy Dunlap <rdunlap@infradead.org>
    mtd/maps: fix solutionengine.c printk format warnings

Hans Verkuil <hverkuil@xs4all.nl>
    media: videobuf2-core: check for q->error in vb2_core_qbuf()

Felix Fietkau <nbd@nbd.name>
    MIPS: ath79: fix system restart

John Keeping <john@metanate.com>
    dmaengine: pl330: fix irq race with terminate_all

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: add .DELETE_ON_ERROR special target

Nicholas Mc Guire <hofrat@osadl.org>
    clk: imx6ul: fix missing of_node_put()

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Special-case rindex for gfs2_grow

YueHaibing <yuehaibing@huawei.com>
    xfrm: fix 'passing zero to ERR_PTR()' warning

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Fix multiple definitions in AU0828_DEVICE() macro

Takashi Iwai <tiwai@suse.de>
    ALSA: msnd: Fix the default sample sizes

Miao Zhong <zhongmiao@hisilicon.com>
    iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer register


-------------

Diffstat:

 Makefile                                           |  4 +--
 arch/arm/mach-exynos/suspend.c                     |  1 +
 arch/arm/mach-hisi/hotplug.c                       | 41 ++++++++++++++--------
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  2 +-
 arch/mips/ath79/setup.c                            |  1 +
 arch/mips/include/asm/mach-ath79/ath79.h           |  1 +
 arch/mips/jz4740/Platform                          |  2 +-
 arch/mips/kernel/vdso.c                            | 35 ++++++++++++------
 arch/mips/loongson64/common/cs5536/cs5536_ohci.c   |  2 +-
 arch/powerpc/platforms/powernv/opal.c              |  2 +-
 drivers/clk/imx/clk-imx6ul.c                       |  1 +
 drivers/crypto/sahara.c                            |  4 +--
 drivers/dma/pl330.c                                |  5 +--
 drivers/gpio/gpiolib.h                             |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c           |  2 ++
 drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 +++++++
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c      |  2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c       |  7 ++--
 drivers/hwtracing/coresight/coresight.c            |  7 ++--
 drivers/infiniband/core/cma.c                      | 12 ++++---
 drivers/infiniband/hw/nes/nes.h                    |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |  2 ++
 drivers/iommu/arm-smmu-v3.c                        |  1 +
 drivers/media/v4l2-core/videobuf2-core.c           |  5 +++
 drivers/misc/hmc6352.c                             |  2 ++
 drivers/misc/mei/bus-fixup.c                       |  2 +-
 drivers/mtd/maps/solutionengine.c                  |  6 ++--
 drivers/mtd/mtdchar.c                              | 10 ++++--
 drivers/net/ethernet/ti/cpsw.c                     | 37 +++++++++++--------
 drivers/net/xen-netfront.c                         | 30 ++++++++--------
 drivers/parport/parport_sunbpp.c                   |  8 +++--
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c           | 32 ++++++++++++-----
 drivers/platform/x86/toshiba_acpi.c                |  3 +-
 drivers/rtc/rtc-bq4802.c                           |  4 +++
 drivers/s390/net/qeth_core_main.c                  |  3 +-
 drivers/s390/net/qeth_core_sys.c                   |  1 +
 drivers/usb/class/cdc-wdm.c                        |  2 +-
 drivers/usb/core/hcd-pci.c                         |  2 --
 drivers/usb/core/message.c                         | 11 ++++++
 drivers/usb/core/quirks.c                          |  7 ++++
 drivers/usb/gadget/udc/net2280.c                   | 16 +++++++--
 drivers/usb/host/u132-hcd.c                        |  2 +-
 drivers/usb/misc/uss720.c                          |  4 +--
 drivers/usb/misc/yurex.c                           |  5 +--
 drivers/usb/serial/io_ti.h                         |  2 +-
 drivers/usb/serial/ti_usb_3410_5052.h              |  2 +-
 drivers/usb/storage/scsiglue.c                     |  9 +++++
 drivers/usb/storage/unusual_devs.h                 |  7 ++++
 drivers/video/fbdev/core/modedb.c                  | 41 ++++++++++++++++------
 drivers/video/fbdev/goldfishfb.c                   |  1 +
 drivers/video/fbdev/omap/omapfb_main.c             |  2 +-
 drivers/video/fbdev/via/viafbdev.c                 |  3 +-
 fs/binfmt_elf.c                                    |  2 +-
 fs/cifs/readdir.c                                  | 11 ++++--
 fs/cifs/smb2pdu.c                                  | 25 +++++++------
 fs/gfs2/bmap.c                                     |  2 +-
 fs/pstore/ram_core.c                               | 17 +++++++--
 kernel/audit_watch.c                               | 12 ++++++-
 net/mac80211/cfg.c                                 |  2 +-
 net/mac80211/key.c                                 | 24 ++++++++-----
 net/xfrm/xfrm_policy.c                             |  5 ++-
 scripts/Kbuild.include                             |  3 ++
 sound/core/pcm_lib.c                               | 14 +++++---
 sound/isa/msnd/msnd_pinnacle.c                     |  4 +--
 sound/usb/quirks-table.h                           |  3 +-
 tools/hv/hv_kvp_daemon.c                           |  2 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  | 10 ++++--
 tools/testing/selftests/timers/raw_skew.c          |  5 +++
 68 files changed, 389 insertions(+), 162 deletions(-)


