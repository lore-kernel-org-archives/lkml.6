Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E24C282D0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029EB2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761886;
	bh=F3YEdsWLefKATIqiySMxIub4hZzYt/QrPspqWsBSMDU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=LsJeypSGhfX5JGVKkvogDSYONtPPK4BBO0DUdxaZozPlbkihj2tTAmaqQEZLckWHh
	 /Lk3Ai9L5Ok+oNL9W65eeQE3e9TcQ6ngmTmUv01YjOfgxPephc7dMwLtTf1RITm7KS
	 /nrIKAlN23CaHbS5YRDarFYBX4SDfuLb7Jc8duhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfA2LiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:38:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbfA2LiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:38:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2061D20989;
        Tue, 29 Jan 2019 11:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761880;
        bh=F3YEdsWLefKATIqiySMxIub4hZzYt/QrPspqWsBSMDU=;
        h=From:To:Cc:Subject:Date:From;
        b=eLBWalBHxAaocA9abtu765hYTW0AqgnePBqDI8pjfl49Vi7Y2hcC1IsXipHt9xvmK
         1n3gsVH6AkKpN9B+SFnFNm3lCAcbBcnyD2VuofL8AgP5cfVOzKRP3qZ++LOrfpv2xw
         aqcJ5zYSh8957e/IO4J7C2T8wrRr7t2yVxuJD3nw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.20 000/117] 4.20.6-stable review
Date:   Tue, 29 Jan 2019 12:34:11 +0100
Message-Id: <20190129113207.477505932@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.6-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.20.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.20.6-rc1
X-KernelTest-Deadline: 2019-01-31T11:32+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.20.6 release.
There are 117 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Jan 31 11:31:34 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.20.6-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.20.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.20.6-rc1

Christoph Hellwig <hch@lst.de>
    ide: fix a typo in the settings proc file name

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76x0: phy: unify calibration between mt76x0u and mt76x0e

Stanislaw Gruszka <sgruszka@redhat.com>
    mt76x0: antenna select corrections

Stanislaw Gruszka <sgruszka@redhat.com>
    mt76x0: do not perform MCU calibration for MT7630

Stanislaw Gruszka <sgruszka@redhat.com>
    mt76x02: assure we update gain after scan

Stanislaw Gruszka <sgruszka@redhat.com>
    mt76x02: run calibration after scanning

Stanislaw Gruszka <sgruszka@redhat.com>
    mt76x0: use band parameter for LC calibration

Stanislaw Gruszka <sgruszka@redhat.com>
    mt76x0: do not overwrite other MT_BBP(AGC, 8) fields

Jack Pham <jackp@codeaurora.org>
    usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup

Michal Hocko <mhocko@suse.com>
    Revert "mm, memory_hotplug: initialize struct pages for the full memory section"

Dexuan Cui <decui@microsoft.com>
    vmbus: fix subchannel removal

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Remove the useless API vmbus_get_outgoing_channel()

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix inner map masking to prevent oob under speculation

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix sanitation of alu op with pointer / scalar type from different paths

Daniel Borkmann <daniel@iogearbox.net>
    bpf: prevent out of bounds speculation on pointer arithmetic

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix check_map_access smin_value test when pointer contains offset

Daniel Borkmann <daniel@iogearbox.net>
    bpf: restrict unknown scalars of mixed signed bounds for unprivileged

Daniel Borkmann <daniel@iogearbox.net>
    bpf: restrict stack pointer arithmetic for unprivileged

Daniel Borkmann <daniel@iogearbox.net>
    bpf: restrict map value pointer arithmetic for unprivileged

Daniel Borkmann <daniel@iogearbox.net>
    bpf: enable access to ax register also from verifier rewrite

Raju Rangoju <rajur@chelsio.com>
    nvmet-rdma: fix null dereference under heavy load

Israel Rukshin <israelr@mellanox.com>
    nvmet-rdma: Add unlikely for response allocated check

Daniel Borkmann <daniel@iogearbox.net>
    bpf: move tmp variable into ax register in interpreter

Daniel Borkmann <daniel@iogearbox.net>
    bpf: move {prev_,}insn_idx into verifier env

Neil Armstrong <narmstrong@baylibre.com>
    drm/meson: Fix atomic mode switching regression

Nicolas Pitre <nicolas.pitre@linaro.org>
    vt: invoke notifier on screen size change

Nicolas Pitre <nicolas.pitre@linaro.org>
    vt: always call notifier with the console lock held

Nicolas Pitre <nicolas.pitre@linaro.org>
    vt: make vt_console_print() compatible with the unicode screen buffer

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    can: flexcan: fix NULL pointer exception during bringup

Oliver Hartkopp <socketcan@hartkopp.net>
    can: bcm: check timer values before ktime conversion

Manfred Schlaegl <manfred.schlaegl@ginzinger.com>
    can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb by removing it

Marc Zyngier <marc.zyngier@arm.com>
    irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Thomas Gleixner <tglx@linutronix.de>
    net: sun: cassini: Cleanup license conflict

Thomas Gleixner <tglx@linutronix.de>
    posix-cpu-timers: Unbreak timer rearming

Jan Beulich <JBeulich@suse.com>
    x86/entry/64/compat: Fix stack switching for XEN PV

Daniel Drake <drake@endlessm.com>
    x86/kaslr: Fix incorrect i8254 outb() parameters

Dave Hansen <dave.hansen@linux.intel.com>
    x86/selftests/pkeys: Fork() to check for state being preserved

Dave Hansen <dave.hansen@linux.intel.com>
    x86/pkeys: Properly copy pkey state at fork()

Tom Roeder <tmroeder@google.com>
    kvm: x86/vmx: Use kzalloc for cached_vmcs12

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: WARN_ONCE if sending a PV IPI returns a fatal error

Sean Christopherson <sean.j.christopherson@intel.com>
    KVM: x86: Fix PV IPIs for 32-bit KVM host

Alexander Popov <alex.popov@linux.com>
    KVM: x86: Fix single-step debugging

Thor Thayer <thor.thayer@linux.intel.com>
    EDAC, altera: Fix S10 persistent register offset

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: Add APTX quirk for Lenovo laptop

Milan Broz <gmazyland@gmail.com>
    dm crypt: fix parsing of extended IV arguments

Joe Thornber <ejt@redhat.com>
    dm thin: fix passdown_double_checking_shared_status()

Marc Gonzalez <marc.w.gonzalez@free.fr>
    scsi: ufs: Use explicit access size in ufshcd_dump_regs

Dan Williams <dan.j.williams@intel.com>
    acpi/nfit: Fix command-supported detection

Dan Williams <dan.j.williams@intel.com>
    acpi/nfit: Block function zero DSMs

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: uinput - fix undefined behavior in uinput_validate_absinfo()

Deepa Dinamani <deepa.kernel@gmail.com>
    Input: input_event - provide override for sparc64

Tom Panfil <tom@steelseries.com>
    Input: xpad - add support for SteelSeries Stratus Duo

Ronnie Sahlberg <lsahlber@redhat.com>
    smb3: add credits we receive from oplock/break PDUs

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Do not reconnect TCP session in add_credits()

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix credit calculation for encrypted reads with errors

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix credits calculations for reads with errors

Pavel Shilovsky <pshilov@microsoft.com>
    CIFS: Fix possible hang during async MTU reads and writes

Nicolas Pitre <nicolas.pitre@linaro.org>
    vgacon: unconfuse vc_origin when using soft scrollback

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Check for ring when getting debug info

Vitaly Kuznetsov <vkuznets@redhat.com>
    hv_balloon: avoid touching uninitialized struct page during tail onlining

Paul Fulghum <paulkf@microgate.com>
    tty/n_hdlc: fix __might_sleep warning

Samir Virmani <samir@embedur.com>
    uart: Fix crash in uart_write and uart_put_char

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    tty: Handle problem if line discipline does not have receive_buf

Michael Straube <straube.linux@gmail.com>
    staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Remi Pommarel <repk@triplefau.lt>
    mmc: meson-gx: Free irq in release() callback

Liming Sun <lsun@mellanox.com>
    mmc: dw_mmc-bluefield: : Fix the license information

Stefan Wahren <stefan.wahren@i2se.com>
    mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

Gustavo A. R. Silva <gustavo@embeddedor.com>
    char/mwave: fix potential Spectre v1 vulnerability

Gustavo A. R. Silva <gustavo@embeddedor.com>
    misc: ibmvsm: Fix potential NULL pointer dereference

David Hildenbrand <david@redhat.com>
    s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

Gerald Schaefer <gerald.schaefer@de.ibm.com>
    s390/smp: fix CPU hotplug deadlock with CPU rescan

Christian Borntraeger <borntraeger@de.ibm.com>
    s390/early: improve machine detection

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/mm: always force a load of the primary ASCE on context switch

Vasily Gorbik <gor@linux.ibm.com>
    s390/vdso: correct vdso mapping for compat tasks

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: perf: map generic branches to correct hardware condition

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARC: adjust memblock_reserve of kernel memory

Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
    ARCv2: lib: memeset: fix doing prefetchw outside of buffer

Anthony Wong <anthony.wong@canonical.com>
    ALSA: hda - Add mute LED support for HP ProBook 470 G5

Kailang Yang <kailang@realtek.com>
    ALSA: hda/realtek - Fix typo for ALC225 model

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    inotify: Fix fd refcount leak in inotify_add_watch().

Dinh Nguyen <dinguyen@kernel.org>
    clk: socfpga: stratix10: fix naming convention for the fixed-clocks

Dinh Nguyen <dinguyen@kernel.org>
    clk: socfpga: stratix10: fix rate calculation for pll clocks

Gustavo A. R. Silva <gustavo@embeddedor.com>
    clk: zynqmp: Fix memory allocation in zynqmp_clk_setup

b-ak <anur.bhargav@gmail.com>
    ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby mode

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: rt5514-spi: Fix potential NULL pointer dereference

Kangjie Lu <kjlu@umn.edu>
    ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

Yan, Zheng <zyan@redhat.com>
    ceph: clear inode pointer when snap realm gets dropped by its inode

Charles Yeh <charlesyeh522@gmail.com>
    USB: serial: pl2303: add new PID to support PL2303TB

Max Schulze <max.schulze@posteo.de>
    USB: serial: simple: add Motorola Tetra TPG2200 device id

Karoly Pados <pados@pados.hu>
    USB: serial: ftdi_sio: fix GPIO not working in autosuspend

Lubomir Rintel <lkundrak@v3.sk>
    USB: EHCI: ehci-mv: add MODULE_DEVICE_TABLE

Christian Lamparter <chunkeey@gmail.com>
    USB: leds: fix regression in usbport led trigger

Tomas Winkler <tomas.winkler@intel.com>
    mei: me: add denverton innovation engine device IDs

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: mark LBG devices as having dma support

Chuck Lever <chuck.lever@oracle.com>
    SUNRPC: Address Kerberos performance/behavior regression

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: fix the cockup in the previous patch

Willem de Bruijn <willemb@google.com>
    tcp: allow MSG_ZEROCOPY transmission also in CLOSE_WAIT state

Hangbin Liu <liuhangbin@gmail.com>
    ip6_gre: update version related info when changing link

Andrew Lunn <andrew@lunn.ch>
    net: phy: marvell: Fix deadlock from wrong locking

Xin Long <lucien.xin@gmail.com>
    erspan: build the header with the right proto according to erspan_ver

Olivier Matz <olivier.matz@6wind.com>
    ip6_gre: fix tunnel list corruption for x-netns

Willem de Bruijn <willemb@google.com>
    udp: with udp_segment release on error path

Ivan Vecera <ivecera@redhat.com>
    net/sched: cls_flower: allocate mask dynamically in fl_change()

Ido Schimmel <idosch@mellanox.com>
    mlxsw: pci: Ring CQ's doorbell before RDQ's

Nir Dotan <nird@mellanox.com>
    mlxsw: spectrum_fid: Update dummy FID index

Ido Schimmel <idosch@mellanox.com>
    net: ipv4: Fix memory leak in network namespace dismantle

Nir Dotan <nird@mellanox.com>
    mlxsw: pci: Increase PCI SW reset timeout

Jason Wang <jasowang@redhat.com>
    vhost: log dirty page correctly

Ross Lagerwall <ross.lagerwall@citrix.com>
    openvswitch: Avoid OOB read when parsing flow nlattrs

Cong Wang <xiyou.wangcong@gmail.com>
    net_sched: refetch skb protocol for each filter

Davide Caratti <dcaratti@redhat.com>
    net/sched: act_tunnel_key: fix memory leak in case of action replace

Camelia Groza <camelia.groza@nxp.com>
    net: phy: phy driver features are mandatory

Thomas Petazzoni <thomas.petazzoni@bootlin.com>
    net: phy: mdio_bus: add missing device_del() in mdiobus_register() error handling

Andrew Lunn <andrew@lunn.ch>
    net: phy: marvell: Errata for mv88e6390 internal PHYs

Ross Lagerwall <ross.lagerwall@citrix.com>
    net: Fix usage of pskb_trim_rcsum

Yunjian Wang <wangyunjian@huawei.com>
    net: bridge: Fix ethernet header pointer before check skb forwardable

Lendacky, Thomas <Thomas.Lendacky@amd.com>
    amd-xgbe: Fix mdio access for non-zero ports and clause 45 PHYs


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/include/asm/perf_event.h                  |   3 +-
 arch/arc/lib/memset-archs.S                        |  40 ++-
 arch/arc/mm/init.c                                 |   3 +-
 arch/arm/mm/proc-macros.S                          |   4 +-
 arch/s390/include/asm/mmu_context.h                |   7 +-
 arch/s390/kernel/early.c                           |   4 +-
 arch/s390/kernel/setup.c                           |   2 +
 arch/s390/kernel/smp.c                             |  11 +-
 arch/s390/kernel/vdso.c                            |   5 +-
 arch/x86/entry/entry_64_compat.S                   |   6 +-
 arch/x86/include/asm/mmu_context.h                 |  18 +
 arch/x86/kernel/kvm.c                              |   7 +-
 arch/x86/kvm/vmx.c                                 |  12 +-
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/lib/kaslr.c                               |   4 +-
 drivers/acpi/nfit/core.c                           |  61 +++-
 drivers/char/mwave/mwavedd.c                       |   7 +
 drivers/clk/socfpga/clk-pll-s10.c                  |   2 +-
 drivers/clk/socfpga/clk-s10.c                      |  20 +-
 drivers/clk/zynqmp/clkc.c                          |   4 +-
 drivers/edac/altera_edac.h                         |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |   1 +
 drivers/gpu/drm/meson/meson_crtc.c                 |  23 +-
 drivers/gpu/drm/meson/meson_drv.c                  |   5 +
 drivers/hv/channel.c                               |  10 +-
 drivers/hv/channel_mgmt.c                          |  44 ---
 drivers/hv/hv_balloon.c                            |  10 +-
 drivers/hv/ring_buffer.c                           |  31 +-
 drivers/hv/vmbus_drv.c                             |  91 +++--
 drivers/ide/ide-proc.c                             |   2 +-
 drivers/input/joystick/xpad.c                      |   3 +
 drivers/input/misc/uinput.c                        |   5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  25 +-
 drivers/md/dm-crypt.c                              |  25 +-
 drivers/md/dm-thin-metadata.c                      |   4 +-
 drivers/md/dm-thin-metadata.h                      |   2 +-
 drivers/md/dm-thin.c                               |  10 +-
 drivers/misc/ibmvmc.c                              |   7 +-
 drivers/misc/mei/hw-me-regs.h                      |   2 +
 drivers/misc/mei/pci-me.c                          |   4 +-
 drivers/mmc/host/dw_mmc-bluefield.c                |   5 -
 drivers/mmc/host/meson-gx-mmc.c                    |  18 +-
 drivers/mmc/host/sdhci-iproc.c                     |   5 +-
 drivers/net/can/dev.c                              |  27 +-
 drivers/net/can/flexcan.c                          |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-common.h        |   2 -
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c           |  22 +-
 drivers/net/ethernet/mellanox/mlxsw/pci.c          |  12 +-
 drivers/net/ethernet/mellanox/mlxsw/pci_hw.h       |   3 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c |   4 +-
 drivers/net/ethernet/sun/cassini.c                 |  15 +-
 drivers/net/ethernet/sun/cassini.h                 |  15 +-
 drivers/net/phy/marvell.c                          |  37 ++-
 drivers/net/phy/mdio_bus.c                         |   1 +
 drivers/net/phy/phy_device.c                       |   5 +
 drivers/net/ppp/pppoe.c                            |   1 +
 drivers/net/wireless/mediatek/mt76/mt76.h          |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c   |   9 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/mt76x0.h |   5 +
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c    | 170 +++-------
 drivers/net/wireless/mediatek/mt76/mt76x0/usb.c    |   1 +
 drivers/net/wireless/mediatek/mt76/mt76x02.h       |   1 +
 .../net/wireless/mediatek/mt76/mt76x02_eeprom.h    |  10 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_phy.c   |   1 +
 .../net/wireless/mediatek/mt76/mt76x2/usb_main.c   |   3 +
 drivers/nvme/target/rdma.c                         |  17 +-
 drivers/s390/char/sclp_config.c                    |   2 +
 drivers/scsi/ufs/ufshcd.c                          |  10 +-
 drivers/staging/rtl8188eu/os_dep/usb_intf.c        |   1 +
 drivers/tty/n_hdlc.c                               |   1 +
 drivers/tty/serial/serial_core.c                   |  12 +-
 drivers/tty/tty_io.c                               |   3 +-
 drivers/tty/vt/vt.c                                |  50 +--
 drivers/usb/core/ledtrig-usbport.c                 |  17 +-
 drivers/usb/dwc3/gadget.c                          |   2 +
 drivers/usb/host/ehci-mv.c                         |   1 +
 drivers/usb/serial/ftdi_sio.c                      |  15 +-
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   2 +
 drivers/usb/serial/usb-serial-simple.c             |   3 +-
 drivers/vhost/net.c                                |   3 +-
 drivers/vhost/vhost.c                              |  97 +++++-
 drivers/vhost/vhost.h                              |   3 +-
 drivers/video/console/vgacon.c                     |   7 +-
 fs/ceph/caps.c                                     |   2 +
 fs/cifs/cifssmb.c                                  |  35 +-
 fs/cifs/connect.c                                  |  21 ++
 fs/cifs/smb2misc.c                                 |   7 +
 fs/cifs/smb2ops.c                                  |  62 ++--
 fs/notify/inotify/inotify_user.c                   |   6 +-
 include/linux/bpf_verifier.h                       |  13 +
 include/linux/filter.h                             |  10 +-
 include/linux/hyperv.h                             |  22 +-
 include/linux/phy.h                                |   4 +-
 include/linux/skbuff.h                             |   1 +
 include/net/ip_fib.h                               |   2 +-
 include/uapi/linux/input.h                         |   6 +-
 kernel/bpf/core.c                                  |  54 ++-
 kernel/bpf/map_in_map.c                            |  17 +-
 kernel/bpf/verifier.c                              | 369 +++++++++++++++++----
 kernel/time/posix-cpu-timers.c                     |   1 +
 mm/page_alloc.c                                    |  12 -
 net/bridge/br_forward.c                            |   9 +-
 net/bridge/br_netfilter_ipv6.c                     |   1 +
 net/bridge/netfilter/nft_reject_bridge.c           |   1 +
 net/can/bcm.c                                      |  27 ++
 net/ipv4/fib_frontend.c                            |   4 +-
 net/ipv4/fib_trie.c                                |  15 +-
 net/ipv4/ip_gre.c                                  |  23 +-
 net/ipv4/ip_input.c                                |   1 +
 net/ipv4/tcp.c                                     |   2 +-
 net/ipv4/udp.c                                     |  16 +-
 net/ipv6/ip6_gre.c                                 |  14 +-
 net/ipv6/udp.c                                     |  16 +-
 net/openvswitch/flow_netlink.c                     |   2 +-
 net/sched/act_tunnel_key.c                         |  19 +-
 net/sched/cls_api.c                                |   3 +-
 net/sched/cls_flower.c                             |  19 +-
 net/sunrpc/xprt.c                                  |   2 +-
 sound/pci/hda/patch_conexant.c                     |   1 +
 sound/pci/hda/patch_realtek.c                      |   2 +-
 sound/soc/codecs/rt5514-spi.c                      |   2 +
 sound/soc/codecs/tlv320aic32x4.c                   |   4 +
 sound/soc/intel/atom/sst-mfld-platform-pcm.c       |   8 +-
 tools/testing/selftests/x86/protection_keys.c      |  41 ++-
 126 files changed, 1326 insertions(+), 709 deletions(-)


