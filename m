Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC688C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873772145D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJtei0U3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 873772145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbeK3BaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeK3BaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:30:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 302DD205C9;
        Thu, 29 Nov 2018 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501484;
        bh=2d3sX0aQhSQhcDHfdeRYhUxlYc0+eGrJmr5JesqSPAU=;
        h=From:To:Cc:Subject:Date:From;
        b=KJtei0U3gfxAlAkVK1aHurp3fxzejAAaBmGQzoluCBr1ofTZz9WR2+pf/uZG4CXEp
         3ZF9d9rZaKFqnEJj896hijcUooFPlEZa9lSnQUofS3kWjJyD3Gt9HkDVB4zFCe1YkS
         /dh11UHjPaQyzUkJQ9n4OIRV+2P3oXKYOSDdvIWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/100] 4.14.85-stable review
Date:   Thu, 29 Nov 2018 15:11:30 +0100
Message-Id: <20181129140058.768942700@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.85-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.85-rc1
X-KernelTest-Deadline: 2018-12-01T14:01+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.85 release.
There are 100 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Dec  1 14:00:29 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.85-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.85-rc1

Mimi Zohar <zohar@linux.vnet.ibm.com>
    ima: re-initialize iint->atomic_flags

Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
    ima: re-introduce own integrity cache lock

Matthew Garrett <mjg59@google.com>
    EVM: Add support for portable signature format

Mimi Zohar <zohar@linux.vnet.ibm.com>
    ima: always measure and audit files in policy

Alexander Aring <aring@mojatatu.com>
    net: ieee802154: 6lowpan: fix frag reassembly

Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    rcu: Make need_resched() respond to urgent RCU-QS needs

Janosch Frank <frankja@linux.ibm.com>
    s390/mm: Check for valid vma before zapping in gmap_discard

Phil Elwell <phil@raspberrypi.org>
    lan78xx: Read MAC address from DT if present

Salvatore Mesoraca <s.mesoraca16@gmail.com>
    namei: allow restricted O_CREAT of FIFOs and regular files

Aaron Ma <aaron.ma@canonical.com>
    usb: xhci: fix uninitialized completion when USB3 port got wrong status

Greg Kroah-Hartman <greg@kroah.com>
    tty: wipe buffer if not echoing data

Linus Torvalds <torvalds@linux-foundation.org>
    tty: wipe buffer.

Sebastien Boisvert <sebhtml@videotron.qc.ca>
    include/linux/pfn_t.h: force '~' to be parsed as an unary operator

Jeffy Chen <jeffy.chen@rock-chips.com>
    driver core: Move device_links_purge() after bus_remove_device()

Krzysztof Kozlowski <krzk@kernel.org>
    ARM: dts: exynos: Fix invalid node referenced by i2c20 alias in Peach Pit and Pi

Marek Szyprowski <m.szyprowski@samsung.com>
    clk: samsung: exynos5250: Add missing clocks for FIMC LITE SYSMMU devices

Alexandre Belloni <alexandre.belloni@free-electrons.com>
    rtc: omap: fix error path when pinctrl_register fails

Mustafa Ismail <mustafa.ismail@intel.com>
    i40iw: Fix memory leak in error path of create QP

Eran Ben Elisha <eranbe@mellanox.com>
    net/mlx4_core: Fix wrong calculation of free counters

Niklas Cassel <niklas.cassel@axis.com>
    PCI: endpoint: Populate func_no before calling pci_epc_add_epf()

Stefan Agner <stefan@agner.ch>
    kbuild: allow to use GCC toolchain not in Clang search path

Matt Chen <matt.chen@intel.com>
    iwlwifi: fix wrong WGDS_WIFI_DATA_SIZE

Ramses Ramírez <ramzeto@gmail.com>
    Input: xpad - add support for Xbox1 PDP Camo series gamepad

Marcus Folkesson <marcus.folkesson@gmail.com>
    Input: xpad - avoid using __set_bit() for capabilities

Leo Sperling <leosperling97@gmail.com>
    Input: xpad - fix some coding style issues

Francis Therien <frtherien@gmail.com>
    Input: xpad - add PDP device id 0x02a4

Richard Weinberger <richard@nod.at>
    ubi: fastmap: Check each mapping only once

Johan Hovold <johan@kernel.org>
    mtd: rawnand: atmel: fix OF child-node lookup

Cherian, George <George.Cherian@cavium.com>
    xhci: Add quirk to workaround the errata seen on Cavium Thunder-X2 Soc

Marc Zyngier <marc.zyngier@arm.com>
    xhci: Allow more than 32 quirks

Greg Hackmann <ghackmann@android.com>
    arm64: remove no-op -p linker flag

Johan Hovold <johan@kernel.org>
    power: supply: twl4030-charger: fix OF sibling-node lookup

Johan Hovold <johan@kernel.org>
    drm/mediatek: fix OF sibling-node lookup

Johan Hovold <johan@kernel.org>
    net: bcmgenet: fix OF child-node lookup

Johan Hovold <johan@kernel.org>
    NFC: nfcmrvl_uart: fix OF child-node lookup

Johan Hovold <johan@kernel.org>
    of: add helper to lookup compatible child node

Michal Hocko <mhocko@suse.com>
    mm, page_alloc: check for max order in hot path

Yufen Yu <yuyufen@huawei.com>
    tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative offset

Vitaly Wool <vitalywool@gmail.com>
    z3fold: fix possible reclaim races

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi/arm: Revert deferred unmap of early memmap mapping

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
    powerpc/numa: Suppress "VPHN is not supported" messages

Prarit Bhargava <prarit@redhat.com>
    kdb: Use strscpy with destination buffer size

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix a bogus get/put in generic_key_to_expire()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: spectre-v2: per-CPU vtables to work around big.Little systems

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: add PROC_VTABLE and PROC_TABLE macros

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: clean up per-processor check_bugs method call

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: make lookup_processor_type() non-__init

Kan Liang <kan.liang@linux.intel.com>
    perf/x86/intel/uncore: Add more IMC PCI IDs for KabyLake and CoffeeLake CPUs

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/io: Fix the IO workarounds code to work with Radix

Jens Axboe <axboe@kernel.dk>
    floppy: fix race condition in __floppy_read_block_0()

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: simd - correctly take reqsize of wrapped skcipher into account

Xulin Sun <xulin.sun@windriver.com>
    rtc: pcf2127: fix a kmemleak caused in pcf2127_i2c_gather_write

Anson Huang <anson.huang@nxp.com>
    cpufreq: imx6q: add return value check for voltage scale

Scott Wood <oss@buserror.net>
    KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE

Jerome Brunet <jbrunet@baylibre.com>
    pinctrl: meson: fix pinconf bias disable

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Eliminate races in the SDMA send error path

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: AML interpreter: add region addresses in global list during initialization

Lukas Wunner <lukas@wunner.de>
    can: hi311x: Use level-triggered interrupt

Oliver Hartkopp <socketcan@hartkopp.net>
    can: raw: check for CAN FD capable netdev in raw_sendmsg()

Oleksij Rempel <o.rempel@pengutronix.de>
    can: rx-offload: rename can_rx_offload_irq_queue_err_skb() to can_rx_offload_queue_tail()

Oleksij Rempel <o.rempel@pengutronix.de>
    can: rx-offload: introduce can_rx_offload_get_echo_skb() and can_rx_offload_queue_sorted() functions

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::echo_skb is accessed out of bounds

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_frame to access frame length

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: can_get_echo_skb(): factor out non sending code to __can_get_echo_skb()

Thomas Zimmermann <tzimmermann@suse.de>
    drm/ast: Remove existing framebuffers before loading driver

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: fixed cursor may disappear sometimes

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: change resolution may cause screen blurred

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: xhci: Prevent bus suspend if a port connect change or polling state is detected

Parav Pandit <parav@mellanox.com>
    IB/core: Perform modify QP on real one

Eric Dumazet <edumazet@google.com>
    tcp: do not release socket ownership in tcp_close()

Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
    mm/memory.c: recheck page table entry with page table lock held

Dmitry Vyukov <dvyukov@google.com>
    mm: don't warn about large allocations for slab

Eric Dumazet <edumazet@google.com>
    llc: do not use sk_eat_skb()

Andrew Price <anprice@redhat.com>
    gfs2: Don't leave s_fs_info pointing to freed memory in init_sbd

Xin Long <lucien.xin@gmail.com>
    sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    bfs: add sanity check at bfs_fill_super()

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: synaptics - avoid using uninitialized variable when probing

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
    selinux: Add __GFP_NOWARN to allocation at str_read()

Dominique Martinet <dominique.martinet@cea.fr>
    v9fs_dir_readdir: fix double-free on p9stat_read error

Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
    tools/power/cpupower: fix compilation with STATIC=true

Rafał Miłecki <rafal@milecki.pl>
    brcmfmac: fix reporting support for 160 MHz channels

Luca Coelho <luciano.coelho@intel.com>
    iwlwifi: mvm: don't use SAR Geo if basic SAR is not used

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: fix regulatory domain update when the firmware starts

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: support sta_statistics() even on older firmware

Vladimir Zapolskiy <vz@mleia.com>
    gpio: don't free unallocated ida on gpiochip_add_data_with_key() error path

Rajat Jain <rajatja@google.com>
    mmc: sdhci-pci: Try "cd" for card-detect lookup before using NULL

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    MAINTAINERS: Add Sasha as a stable branch maintainer

Takashi Iwai <tiwai@suse.de>
    ALSA: oss: Use kvzalloc() for local buffer allocations

Aaron Ma <aaron.ma@canonical.com>
    usb: xhci: fix timeout for transition from RExit to U0

Sandeep Singh <sandeep.singh@amd.com>
    xhci: Add check for invalid byte size error when UAS devices are connected.

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    usb: dwc3: core: Clean up ULPI device

Thinh Nguyen <Thinh.Nguyen@synopsys.com>
    usb: dwc3: gadget: Properly check last unaligned/zero chain TRB

Felipe Balbi <felipe.balbi@linux.intel.com>
    usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    usb: core: Fix hub port connection events lost

Stefan Agner <stefan@agner.ch>
    ARM: trusted_foundations: do not use naked function

Stefan Agner <stefan@agner.ch>
    bus: arm-cci: remove unnecessary unreachable()

Stefan Agner <stefan@agner.ch>
    ARM: 8767/1: add support for building ARM kernel with clang

Stefan Agner <stefan@agner.ch>
    ARM: 8766/1: drop no-thumb-interwork in EABI mode

Alistair Strachan <astrachan@google.com>
    efi/libstub: arm: support building with clang


-------------

Diffstat:

 .../devicetree/bindings/net/can/holt_hi311x.txt    |   2 +-
 Documentation/sysctl/fs.txt                        |  36 +++++++
 MAINTAINERS                                        |   1 +
 Makefile                                           |  12 ++-
 arch/arm/Makefile                                  |   2 +-
 arch/arm/boot/compressed/Makefile                  |   2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   4 +-
 arch/arm/firmware/trusted_foundations.c            |  14 ++-
 arch/arm/include/asm/proc-fns.h                    |  61 ++++++++---
 arch/arm/kernel/bugs.c                             |   4 +-
 arch/arm/kernel/head-common.S                      |   6 +-
 arch/arm/kernel/setup.c                            |   9 +-
 arch/arm/kernel/smp.c                              |  31 ++++++
 arch/arm/mm/proc-v7-bugs.c                         |  17 +--
 arch/arm64/Makefile                                |   2 +-
 arch/powerpc/include/asm/io.h                      |  20 ++--
 arch/powerpc/kvm/trace.h                           |   8 +-
 arch/powerpc/kvm/trace_booke.h                     |   9 +-
 arch/powerpc/kvm/trace_hv.h                        |   9 +-
 arch/powerpc/kvm/trace_pr.h                        |   9 +-
 arch/powerpc/mm/numa.c                             |   2 +-
 arch/s390/mm/gmap.c                                |   2 +
 arch/x86/events/intel/uncore_snb.c                 | 115 ++++++++++++++++++++-
 crypto/simd.c                                      |   5 +-
 drivers/acpi/acpica/dsopcode.c                     |   4 +
 drivers/base/core.c                                |   2 +-
 drivers/block/floppy.c                             |   3 +-
 drivers/bus/arm-cci.c                              |   2 -
 drivers/clk/samsung/clk-exynos5250.c               |   6 ++
 drivers/cpufreq/imx6q-cpufreq.c                    |   7 +-
 drivers/firmware/efi/arm-init.c                    |   4 +
 drivers/firmware/efi/arm-runtime.c                 |   2 +-
 drivers/firmware/efi/libstub/Makefile              |   3 +-
 drivers/firmware/efi/memmap.c                      |   3 +
 drivers/gpio/gpiolib.c                             |   5 +-
 drivers/gpu/drm/ast/ast_drv.c                      |  21 ++++
 drivers/gpu/drm/ast/ast_mode.c                     |   3 +-
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |   5 +-
 drivers/infiniband/core/verbs.c                    |   5 +-
 drivers/infiniband/hw/hfi1/user_sdma.c             |  87 +++++++---------
 drivers/infiniband/hw/hfi1/user_sdma.h             |   3 -
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |   2 +-
 drivers/input/joystick/xpad.c                      |  45 +++++---
 drivers/input/mouse/synaptics.c                    |   4 +-
 drivers/mmc/host/sdhci-pci-core.c                  |   7 +-
 drivers/mtd/nand/atmel/nand-controller.c           |  11 +-
 drivers/mtd/ubi/build.c                            |   1 +
 drivers/mtd/ubi/eba.c                              |   4 +
 drivers/mtd/ubi/fastmap.c                          |  20 ++++
 drivers/mtd/ubi/ubi.h                              |  11 ++
 drivers/mtd/ubi/vmt.c                              |   1 +
 drivers/mtd/ubi/vtbl.c                             |  16 ++-
 drivers/net/can/dev.c                              |  48 ++++++---
 drivers/net/can/flexcan.c                          |   4 +-
 drivers/net/can/rx-offload.c                       |  51 ++++++++-
 drivers/net/can/spi/hi311x.c                       |   2 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   2 +-
 .../net/ethernet/mellanox/mlx4/resource_tracker.c  |   1 -
 drivers/net/usb/lan78xx.c                          |  42 ++++----
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  40 +++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  12 +--
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c       |   5 +-
 drivers/nfc/nfcmrvl/uart.c                         |   5 +-
 drivers/of/base.c                                  |  25 +++++
 drivers/pci/endpoint/pci-ep-cfs.c                  |  14 ++-
 drivers/pinctrl/meson/pinctrl-meson.c              |   2 +-
 drivers/power/supply/twl4030_charger.c             |   5 +-
 drivers/rtc/rtc-omap.c                             |   3 +-
 drivers/rtc/rtc-pcf2127.c                          |   3 +
 drivers/tty/n_tty.c                                |  20 +++-
 drivers/tty/tty_buffer.c                           |   6 +-
 drivers/usb/core/hub.c                             |   4 +-
 drivers/usb/dwc3/core.c                            |   1 +
 drivers/usb/dwc3/gadget.c                          |   8 +-
 drivers/usb/host/xhci-hub.c                        |  66 +++++++++---
 drivers/usb/host/xhci-pci.c                        |   5 +
 drivers/usb/host/xhci-ring.c                       |  38 ++++++-
 drivers/usb/host/xhci.c                            |   6 +-
 drivers/usb/host/xhci.h                            |  67 ++++++------
 fs/9p/vfs_dir.c                                    |  11 --
 fs/bfs/inode.c                                     |   9 +-
 fs/gfs2/ops_fstype.c                               |   2 +-
 fs/namei.c                                         |  53 +++++++++-
 include/linux/can/dev.h                            |   1 +
 include/linux/can/rx-offload.h                     |   7 +-
 include/linux/fs.h                                 |   2 +
 include/linux/integrity.h                          |   1 +
 include/linux/of.h                                 |   8 ++
 include/linux/pfn_t.h                              |   2 +-
 include/net/sock.h                                 |   1 +
 kernel/debug/kdb/kdb_io.c                          |  15 +--
 kernel/debug/kdb/kdb_private.h                     |   2 +-
 kernel/debug/kdb/kdb_support.c                     |  10 +-
 kernel/rcu/tree.c                                  |   9 ++
 kernel/sysctl.c                                    |  18 ++++
 mm/memory.c                                        |  34 +++++-
 mm/page_alloc.c                                    |  20 ++--
 mm/shmem.c                                         |   4 +-
 mm/slab.c                                          |   4 +
 mm/slab_common.c                                   |  12 +--
 mm/z3fold.c                                        | 101 +++++++++++-------
 net/can/raw.c                                      |  15 +--
 net/core/sock.c                                    |   2 +-
 net/ieee802154/6lowpan/6lowpan_i.h                 |   4 +-
 net/ieee802154/6lowpan/reassembly.c                |  14 +--
 net/ipv4/tcp.c                                     |  11 +-
 net/llc/af_llc.c                                   |  11 +-
 net/sctp/associola.c                               |  10 +-
 net/sunrpc/auth_generic.c                          |   8 +-
 security/integrity/evm/evm.h                       |   2 +-
 security/integrity/evm/evm_crypto.c                |  75 ++++++++++++--
 security/integrity/evm/evm_main.c                  |  29 ++++--
 security/integrity/iint.c                          |   3 +
 security/integrity/ima/ima_api.c                   |  67 +++++++-----
 security/integrity/ima/ima_appraise.c              |  31 +++---
 security/integrity/ima/ima_crypto.c                |  10 ++
 security/integrity/ima/ima_main.c                  |  77 +++++++++-----
 security/integrity/integrity.h                     |  18 +++-
 security/selinux/ss/policydb.c                     |   2 +-
 sound/core/oss/pcm_oss.c                           |   6 +-
 sound/core/oss/pcm_plugin.c                        |   6 +-
 tools/power/cpupower/bench/Makefile                |   2 +-
 tools/power/cpupower/lib/cpufreq.c                 |   2 +-
 tools/power/cpupower/lib/cpuidle.c                 |   2 +-
 tools/power/cpupower/lib/cpupower.c                |   4 +-
 tools/power/cpupower/lib/cpupower_intern.h         |   2 +-
 128 files changed, 1351 insertions(+), 549 deletions(-)


