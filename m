Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C076C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FD021104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2WO1ZPb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FD021104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbeKZVz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:55:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730210AbeKZVz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:55:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E943320817;
        Mon, 26 Nov 2018 11:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230101;
        bh=4AGi8NgwK+B9xXyeWgj1XHTpDH18DLma4dlU8KjQmBo=;
        h=From:To:Cc:Subject:Date:From;
        b=Y2WO1ZPb/RsHEDDCOXUrAxrwYhRo+ha9TPLWHGkKxB8UgDdruw8FnsF5mxPMPgWJD
         Nn5nJcWq4WZ36WbqVPn4JCsn8VoILD+XqTGEF7F1b3Ipy5d8d8YVcmm3lbQStfJEMG
         hwSZKIxg9uE2C+60SawVt7FjU2sDGbZDdcsnOfPo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/118] 4.19.5-stable review
Date:   Mon, 26 Nov 2018 11:49:54 +0100
Message-Id: <20181126105059.832485122@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.5-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.5-rc1
X-KernelTest-Deadline: 2018-11-28T10:51+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.5 release.
There are 118 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Nov 28 10:50:22 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.5-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.5-rc1

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76x0: run vco calibration for each channel configuration

Ilya Dryomov <idryomov@gmail.com>
    libceph: fall back to sendmsg for slab pages

Sebastian Parschauer <sparschauer@suse.de>
    HID: Add quirk for Microsoft PIXART OEM mouse

Sebastian Parschauer <sparschauer@suse.de>
    HID: Add quirk for Primax PIXART OEM mice

Eric Biggers <ebiggers@google.com>
    HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Hans de Goede <hdegoede@redhat.com>
    ACPI / platform: Add SMB0001 HID to forbidden_id_list

Gustavo A. R. Silva <gustavo@embeddedor.com>
    drivers/misc/sgi-gru: fix Spectre v1 vulnerability

Johan Hovold <johan@kernel.org>
    mtd: rawnand: atmel: fix OF child-node lookup

Johan Hovold <johan@kernel.org>
    gnss: sirf: fix synchronous write timeout

Johan Hovold <johan@kernel.org>
    gnss: serial: fix synchronous write timeout

Mattias Jacobsson <2pi@mok.nu>
    USB: misc: appledisplay: add 20" Apple Cinema Display

Nathan Chancellor <natechancellor@gmail.com>
    misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
    usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Kai-Heng Feng <kai.heng.feng@canonical.com>
    USB: Wait for extra delay time after USB_PORT_FEAT_RESET for quirky hub

Kai-Heng Feng <kai.heng.feng@canonical.com>
    USB: quirks: Add no-lpm quirk for Raydium touchscreens

Maarten Jacobs <maarten256@outlook.com>
    usb: cdc-acm: add entry for Hiro (Conexant) modem

Jimmy Assarsson <jimmyassarsson@gmail.com>
    can: kvaser_usb: Fix potential uninitialized variable use

Jimmy Assarsson <jimmyassarsson@gmail.com>
    can: kvaser_usb: Fix accessing freed memory in kvaser_usb_start_xmit()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/ca0132 - Call pci_iounmap() instead of iounmap()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda/realtek - Add quirk entry for HP Pavilion 15

Dan Carpenter <dan.carpenter@oracle.com>
    uio: Fix an Oops on load

Olof Johansson <olof@lixom.net>
    RISC-V: Fix raw_copy_{to,from}_user()

Aaro Koskinen <aaro.koskinen@iki.fi>
    MIPS: OCTEON: cavium_octeon_defconfig: re-enable OCTEON USB driver

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: event: Add subscription to list before calling "add" operation

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/ldt: Remove unused variable in map_ldt_struct()

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/ldt: Unmap PTEs for the slot before freeing LDT pages

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/mm: Move LDT remap out of KASLR region on 5-level paging

YueHaibing <yuehaibing@huawei.com>
    SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer()

Guenter Roeck <linux@roeck-us.net>
    Revert "scripts/setlocalversion: git: Make -dirty check more robust"

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: deb-pkg: fix too low build version number

Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
    net: aquantia: invalid checksumm offload implementation

Igor Russkikh <Igor.Russkikh@aquantia.com>
    net: aquantia: fixed enable unicast on 32 macvlan

Dmitry Bogdanov <dmitry.bogdanov@aquantia.com>
    net: aquantia: fix potential IOMMU fault after driver unbind

Thor Thayer <thor.thayer@linux.intel.com>
    net: stmmac: Fix RX packet size > 8191

Sagiv Ozeri <sagiv.ozeri@cavium.com>
    qed: Fix potential memory corruption

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix SPQ entries not returned to pool in error flows

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix blocking/unlimited SPQ entries leak

Denis Bolotin <denis.bolotin@cavium.com>
    qed: Fix memory/entry leak in qed_init_sp_request()

Jacob Keller <jacob.e.keller@intel.com>
    i40e: restore NETIF_F_GSO_IPXIP[46] to netdev features

Chinh T Cao <chinh.t.cao@intel.com>
    ice: Change req_speeds to be u16

Brett Creeley <brett.creeley@intel.com>
    ice: Fix the bytecount sent to netdev_tx_sent_queue

Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
    ice: Fix dead device link issue with flow control

Jiri Olsa <jolsa@kernel.org>
    perf tools: Do not zero sample_id_all for group members

Gustavo Romero <gromero@linux.vnet.ibm.com>
    perf tools: Fix undefined symbol scnprintf in libperf-jvmti.so

Valentin Schneider <valentin.schneider@arm.com>
    sched/core: Take the hotplug lock in sched_init_smp()

Stephen Boyd <swboyd@chromium.org>
    i2c: qcom-geni: Fix runtime PM mismatch with child devices

Vignesh R <vigneshr@ti.com>
    i2c: omap: Enable for ARCH_K3

Sagi Grimberg <sagi@grimberg.me>
    nvme: make sure ns head inherits underlying device limits

Robin Murphy <robin.murphy@arm.com>
    of/device: Really only set bus DMA mask when appropriate

Luis Henriques <lhenriques@suse.com>
    ceph: quota: fix null pointer dereference in quota check

Thomas Richter <tmricht@linux.ibm.com>
    s390/perf: Change CPUM_CF return code in event init function

Lyude Paul <lyude@redhat.com>
    drm/amd/amdgpu/dm: Fix dm_dp_create_fake_mst_encoder()

Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
    drm/amd/display: Drop reusing drm connector for MST

Keith Busch <keith.busch@intel.com>
    block: Clear kernel memory before copying to user

Harry Wentland <harry.wentland@amd.com>
    drm/amd/display: Stop leaking planes

Jeremy Linton <jeremy.linton@arm.com>
    lib/raid6: Fix arm64 test build

Boris Brezillon <boris.brezillon@bootlin.com>
    mtd: nand: Fix nanddev_pos_next_page() kernel-doc header

Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
    clk: fixed-factor: fix of_node_get-put imbalance

Liam Merwick <Liam.Merwick@oracle.com>
    xen/grant-table: Fix incorrect gnttab_dma_free_pages() pr_debug message

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    arm64: dts: renesas: condor: switch from EtherAVB to GEther

Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    arm64: dts: renesas: r8a7795: add missing dma-names on hscif2

Inki Dae <inki.dae@samsung.com>
    Revert "drm/exynos/decon5433: implement frame counter"

Rob Herring <robh@kernel.org>
    ARM: dts: fsl: Fix improperly quoted stdout-path values

Oleksij Rempel <o.rempel@pengutronix.de>
    ARM: dts: imx6sll: fix typo for fsl,imx6sll-i2c node

Geert Uytterhoeven <geert@linux-m68k.org>
    hwmon: (ibmpowernv) Remove bogus __init annotations

Yunsheng Lin <linyunsheng@huawei.com>
    net: hns3: Fix for out-of-bounds access when setting pfc back pressure

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: unregister netdevice only when registered

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: fix HiperSockets sniffer

Florian Westphal <fw@strlen.de>
    netfilter: nft_compat: ebtables 'nat' table is normal chain type

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
    netfilter: ipset: Fix calling ip_set() macro at dumping

Taehee Yoo <ap420073@gmail.com>
    netfilter: xt_IDLETIMER: add sysfs filename checking routine

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
    netfilter: ipset: Correct rcu_dereference() call in ip_set_put_comment()

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix bpf_prog_get_info_by_fd to return 0 func_lens for unpriv

Justin M. Forbes <jforbes@fedoraproject.org>
    s390/mm: Fix ERROR: "__node_distance" undefined!

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/mm: fix mis-accounting of pgtable_bytes

Andrey Ryabinin <aryabinin@virtuozzo.com>
    netfilter: ipset: fix ip_set_list allocation failure

Eric Westbrook <eric@westbrook.io>
    netfilter: ipset: actually allow allowable CIDR 0 in hash:net,port,net

Stefano Brivio <sbrivio@redhat.com>
    netfilter: ipset: list:set: Decrease refcount synchronously on deletion and replace

Pablo Neira Ayuso <pablo@netfilter.org>
    Revert "netfilter: nft_numgen: add map lookups for numgen random operations"

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    HID: alps: allow incoming reports when only the trackstick is opened

Benjamin Tissoires <benjamin.tissoires@redhat.com>
    Revert "HID: add NOGET quirk for Eaton Ellipse MAX UPS"

Kai-Heng Feng <kai.heng.feng@canonical.com>
    HID: i2c-hid: Add a small delay after sleep command for Raydium touchpanel

Vasily Gorbik <gor@linux.ibm.com>
    s390/vdso: add missing FORCE to build targets

Vasily Gorbik <gor@linux.ibm.com>
    s390/decompressor: add missing FORCE to build targets

Jiri Slaby <jslaby@suse.cz>
    netfilter: bridge: define INT_MIN & INT_MAX in userspace

Florian Westphal <fw@strlen.de>
    netfilter: ipv6: fix oops when defragmenting locally generated fragments

Geert Uytterhoeven <geert+renesas@glider.be>
    serial: sh-sci: Fix receive on SCIFA/SCIFB variants with DMA

Johan Hovold <johan@kernel.org>
    clk: ti: fix OF child-node lookup

Phil Edworthy <phil.edworthy@renesas.com>
    clk: renesas: r9a06g032: Fix UART34567 clock rate

Jerome Brunet <jbrunet@baylibre.com>
    clk: meson: clk-pll: drop CLK_GET_RATE_NOCACHE where unnecessary

Nathan Chancellor <natechancellor@gmail.com>
    arm64: percpu: Initialize ret in the default case

Yixun Lan <yixun.lan@amlogic.com>
    clk: meson-axg: pcie: drop the mpll3 clock parent

Paul Gortmaker <paul.gortmaker@windriver.com>
    platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307

Feng Tang <feng.tang@intel.com>
    x86/earlyprintk: Add a force option for pciserial device

Zubin Mithra <zsm@chromium.org>
    apparmor: Fix uninitialized value in aa_split_fqname

Marek Szyprowski <m.szyprowski@samsung.com>
    clk: samsung: exynos5420: Enable PERIS clocks for suspend

Chengguang Xu <cgxu519@gmx.com>
    fs/exofs: fix potential memory leak in mount option parsing

David Miller <davem@davemloft.net>
    perf symbols: Set PLT entry/header sizes properly on Sparc

Alan Tull <atull@kernel.org>
    clk: fixed-rate: fix of_node_get-put imbalance

Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
    platform/x86: intel_telemetry: report debugfs failure

David Howells <dhowells@redhat.com>
    afs: Handle EIO from delivery function

Lee, Shawn C <shawn.c.lee@intel.com>
    drm/edid: Add 6 bpc quirk for BOE panel.

Richard Weinberger <richard@nod.at>
    um: Give start_idle_thread() a return code

Milian Wolff <milian.wolff@kdab.com>
    perf unwind: Take pgoff into account when reporting elf to libdwfl

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfsplus: prevent btree data loss on root split

Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>
    hfs: prevent btree data loss on root split

Jann Horn <jannh@google.com>
    reiserfs: propagate errors from fill_with_dentries() properly

Radoslaw Tyl <radoslawx.tyl@intel.com>
    ixgbe: fix MAC anti-spoofing filter after VFLR

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: bugfix for the initialization of command queue's spin lock

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: bugfix for handling mailbox while the command queue reinitialized

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: bugfix for rtnl_lock's range in the hclge_reset()

Huazhong Tan <tanhuazhong@huawei.com>
    net: hns3: bugfix for rtnl_lock's range in the hclgevf_reset()

Ming Lei <ming.lei@redhat.com>
    block: brd: associate with queue until adding disk

Keith Busch <keith.busch@intel.com>
    nvme-pci: fix conflicting p2p resource adds

Anders Roxell <anders.roxell@linaro.org>
    arm64: kprobe: make page to RO mode when allocate it

Ronnie Sahlberg <lsahlber@redhat.com>
    cifs: fix return value for cifs_listxattr

Colin Ian King <colin.king@canonical.com>
    cifs: don't dereference smb_file_target before null check

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/i915: Replace some PAGE_SIZE with I915_GTT_PAGE_SIZE


-------------

Diffstat:

 Documentation/admin-guide/kernel-parameters.txt    |   8 +-
 Documentation/x86/x86_64/mm.txt                    |  10 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |   2 +-
 arch/arm/boot/dts/imx6sll.dtsi                     |   2 +-
 arch/arm/boot/dts/vf610m4-colibri.dts              |   4 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   2 +-
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts    |  47 ++++----
 arch/arm64/include/asm/percpu.h                    |   3 +
 arch/arm64/kernel/probes/kprobes.c                 |  27 +++--
 arch/mips/configs/cavium_octeon_defconfig          |   1 +
 arch/riscv/include/asm/uaccess.h                   |   4 +-
 arch/s390/boot/compressed/Makefile                 |  14 +--
 arch/s390/include/asm/mmu_context.h                |   5 -
 arch/s390/include/asm/pgalloc.h                    |   6 +-
 arch/s390/include/asm/pgtable.h                    |  18 +++
 arch/s390/include/asm/tlb.h                        |   6 +-
 arch/s390/kernel/perf_cpum_cf.c                    |   2 +-
 arch/s390/kernel/vdso32/Makefile                   |   6 +-
 arch/s390/kernel/vdso64/Makefile                   |   6 +-
 arch/s390/mm/pgalloc.c                             |   1 +
 arch/s390/numa/numa.c                              |   1 +
 arch/um/os-Linux/skas/process.c                    |   5 +
 arch/x86/include/asm/page_64_types.h               |  12 +-
 arch/x86/include/asm/pgtable_64_types.h            |   4 +-
 arch/x86/kernel/early_printk.c                     |  29 +++--
 arch/x86/kernel/ldt.c                              |  59 ++++++----
 arch/x86/xen/mmu_pv.c                              |   6 +-
 block/bio.c                                        |   1 +
 drivers/acpi/acpi_platform.c                       |   1 +
 drivers/block/brd.c                                |  16 ++-
 drivers/clk/clk-fixed-factor.c                     |   1 +
 drivers/clk/clk-fixed-rate.c                       |   1 +
 drivers/clk/meson/axg.c                            |   7 +-
 drivers/clk/meson/gxbb.c                           |  12 +-
 drivers/clk/meson/meson8b.c                        |   3 -
 drivers/clk/renesas/r9a06g032-clocks.c             |   3 +-
 drivers/clk/samsung/clk-exynos5420.c               |   1 +
 drivers/clk/ti/clk.c                               |  13 ++-
 drivers/gnss/serial.c                              |   3 +-
 drivers/gnss/sirf.c                                |   3 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   2 -
 .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |  45 ++------
 drivers/gpu/drm/drm_edid.c                         |   3 +
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   9 --
 drivers/gpu/drm/exynos/exynos_drm_crtc.c           |  11 --
 drivers/gpu/drm/exynos/exynos_drm_drv.h            |   1 -
 drivers/gpu/drm/i915/i915_drv.h                    |   2 +-
 drivers/gpu/drm/i915/i915_gem_gtt.c                |  18 +--
 drivers/hid/hid-alps.c                             |  18 +++
 drivers/hid/hid-ids.h                              |   6 +
 drivers/hid/hid-quirks.c                           |   4 +-
 drivers/hid/i2c-hid/i2c-hid.c                      |  19 +++
 drivers/hid/uhid.c                                 |  12 ++
 drivers/hwmon/ibmpowernv.c                         |   7 +-
 drivers/i2c/busses/Kconfig                         |   2 +-
 drivers/i2c/busses/i2c-qcom-geni.c                 |  15 +--
 drivers/media/v4l2-core/v4l2-event.c               |  43 ++++---
 drivers/misc/atmel-ssc.c                           |   2 +-
 drivers/misc/sgi-gru/grukdump.c                    |   4 +
 drivers/mtd/nand/raw/atmel/nand-controller.c       |  11 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   |   4 +-
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c  |  10 +-
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |   2 +-
 drivers/net/ethernet/aquantia/atlantic/aq_ring.c   |  35 ++++--
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  |  42 ++++---
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c |   8 ++
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.h |   3 +
 .../aquantia/atlantic/hw_atl/hw_atl_llh_internal.h |  18 +++
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.c |  14 ++-
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    |   3 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c |   6 +
 .../net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c  |  10 +-
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c  |   5 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c       |   7 +-
 drivers/net/ethernet/intel/ice/ice_txrx.c          |   2 +-
 drivers/net/ethernet/intel/ice/ice_type.h          |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   4 +-
 drivers/net/ethernet/qlogic/qed/qed_fcoe.c         |  11 +-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c        |   1 +
 drivers/net/ethernet/qlogic/qed/qed_l2.c           |  12 +-
 drivers/net/ethernet/qlogic/qed/qed_rdma.c         |   1 +
 drivers/net/ethernet/qlogic/qed/qed_roce.c         |   1 +
 drivers/net/ethernet/qlogic/qed/qed_sp.h           |  14 +++
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c  |  22 +++-
 drivers/net/ethernet/qlogic/qed/qed_spq.c          |  69 +++++------
 drivers/net/ethernet/qlogic/qed/qed_sriov.c        |   1 +
 drivers/net/ethernet/stmicro/stmmac/common.h       |   3 +-
 drivers/net/ethernet/stmicro/stmmac/descs_com.h    |   2 +-
 drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |   2 +-
 drivers/net/ethernet/stmicro/stmmac/ring_mode.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    |   4 +-
 drivers/nvme/host/core.c                           |   4 +-
 drivers/nvme/host/multipath.c                      |   1 +
 drivers/nvme/host/pci.c                            |   5 +-
 drivers/of/device.c                                |   4 +-
 drivers/platform/x86/acerhdf.c                     |   1 +
 drivers/platform/x86/intel_telemetry_debugfs.c     |   8 +-
 drivers/s390/net/qeth_core.h                       |   5 +
 drivers/s390/net/qeth_l2_main.c                    |   5 +-
 drivers/s390/net/qeth_l3_main.c                    |  13 ++-
 drivers/tty/serial/sh-sci.c                        |   4 +-
 drivers/uio/uio.c                                  |   7 +-
 drivers/usb/class/cdc-acm.c                        |   3 +
 drivers/usb/core/hub.c                             |  14 ++-
 drivers/usb/core/quirks.c                          |  14 +++
 drivers/usb/misc/appledisplay.c                    |   1 +
 drivers/xen/grant-table.c                          |   2 +-
 fs/afs/rxrpc.c                                     |   5 +-
 fs/ceph/quota.c                                    |   3 +-
 fs/cifs/cifsfs.c                                   |   7 +-
 fs/cifs/smb2ops.c                                  |  11 +-
 fs/exofs/super.c                                   |   5 +-
 fs/hfs/brec.c                                      |   4 +
 fs/hfsplus/brec.c                                  |   4 +
 fs/reiserfs/xattr.c                                |   7 ++
 include/linux/mtd/nand.h                           |   2 +-
 include/linux/netfilter/ipset/ip_set.h             |   2 +-
 include/linux/netfilter/ipset/ip_set_comment.h     |   4 +-
 include/linux/usb/quirks.h                         |   3 +
 include/uapi/linux/netfilter/nf_tables.h           |   4 +-
 include/uapi/linux/netfilter_bridge.h              |   4 +
 kernel/bpf/syscall.c                               |   1 +
 kernel/sched/core.c                                |   5 +-
 lib/raid6/test/Makefile                            |   4 +-
 net/ceph/messenger.c                               |  12 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |  13 ++-
 net/netfilter/ipset/ip_set_core.c                  |  43 +++----
 net/netfilter/ipset/ip_set_hash_netportnet.c       |   8 +-
 net/netfilter/ipset/ip_set_list_set.c              |  17 ++-
 net/netfilter/nft_compat.c                         |  21 ++--
 net/netfilter/nft_numgen.c                         | 127 ---------------------
 net/netfilter/xt_IDLETIMER.c                       |  20 ++++
 net/sunrpc/xdr.c                                   |   2 +-
 scripts/package/mkdebian                           |   7 +-
 scripts/setlocalversion                            |   2 +-
 security/apparmor/lib.c                            |   6 +-
 sound/pci/hda/patch_ca0132.c                       |   2 +-
 sound/pci/hda/patch_realtek.c                      |   1 +
 tools/perf/jvmti/jvmti_agent.c                     |  49 ++++++--
 tools/perf/tests/attr/test-record-group-sampling   |   1 -
 tools/perf/util/evsel.c                            |   1 -
 tools/perf/util/symbol-elf.c                       |  12 +-
 tools/perf/util/unwind-libdw.c                     |   4 +-
 146 files changed, 853 insertions(+), 578 deletions(-)


