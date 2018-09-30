Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2992C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F356206B2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 15:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F356206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbeI3Vgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 17:36:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeI3Vgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 17:36:32 -0400
Received: from localhost (c-73-221-170-44.hsd1.wa.comcast.net [73.221.170.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B69C7E32;
        Sun, 30 Sep 2018 15:03:09 +0000 (UTC)
Date:   Sun, 30 Sep 2018 08:03:08 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Linux 4.19-rc6
Message-ID: <20180930150308.GA5010@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

It's been another week, so as normal, another -rc release is here.  For
a -rc6 release, it's pretty normal.  There are more individual merges
from different trees than -rc5, but the number of changes is much lower
than last week.  Lots of different driver tree updates, along with some
some x86 and a risc-v fix.

Full details are in the shortlog below, and as always, please go test
and report any problems.  It all "just works" on my systems, and I have
not heard of any major outstanding issues as of this point in time.

thanks,

greg k-h

Aaron Ma (1):
      Input: elantech - enable middle button of touchpad on ThinkPad P72

Adrian Hunter (1):
      scsi: ufs: Disable blk-mq for now

Alaa Hleihel (1):
      net/mlx5: Check for SQ and not RQ state when modifying hairpin SQ

Alan Stern (3):
      USB: remove LPM management from usb_driver_claim_interface()
      USB: fix error handling in usb_driver_claim_interface()
      USB: handle NULL config in usb_find_alt_setting()

Alexander Shishkin (3):
      intel_th: Fix device removal logic
      intel_th: Fix resource handling for ACPI glue layer
      intel_th: pci: Add Ice Lake PCH support

Alexandre Belloni (1):
      clocksource/drivers/timer-atmel-pit: Properly handle error cases

Alexandru Gheorghe (2):
      drm: mali-dp: Call drm_crtc_vblank_reset on device init
      drm/malidp: Fix writeback in NV12

Alexey Kardashevskiy (1):
      powerpc/powernv/ioda2: Reduce upper limit for DMA window size (again)

Andreas Schwab (1):
      Input: atakbd - fix Atari keymap

Anson Huang (1):
      Input: egalax_ts - add system wakeup support

Antoine Tenart (4):
      net: mvpp2: fix a txq_done race condition
      net: mvneta: fix the Rx desc buffer DMA unmapping
      net: mscc: fix the frame extraction into the skb
      net: mvneta: fix the remaining Rx descriptor unmapping issues

Arindam Nath (1):
      iommu/amd: Return devid as alias for ACPI HID devices

Arnd Bergmann (2):
      media: camss: mark PM functions as __maybe_unused
      media: camss: add missing includes

Bart Van Assche (1):
      IB/srp: Avoid that sg_reset -d ${srp_device} triggers an infinite loop

Bhawanpreet Lakha (1):
      drm/amd/display: Fix Edid emulation for linux

Bin Liu (1):
      usb: musb: dsps: do not disable CPPI41 irq in driver teardown

Bjorn Helgaas (1):
      MAINTAINERS: Update PPC contacts for PCI core error handling

Boris Brezillon (2):
      spi: spi-mem: Add missing description for data.nbytes field
      spi: spi-mem: Move the DMA-able constraint doc to the kerneldoc header

Boris Ostrovsky (1):
      xen/blkfront: When purging persistent grants, keep them in the buffer

Christian Lamparter (1):
      net: emac: fix fixed-link setup for the RTL8363SB switch

Christoph Hellwig (1):
      dma-mapping: add the missing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration

Christophe Leroy (2):
      serial: cpm_uart: return immediately from console poll
      powerpc: fix csum_ipv6_magic() on little endian platforms

Cong Wang (1):
      ucma: fix a use-after-free in ucma_resolve_ip()

Damien Le Moal (1):
      block: fix deadline elevator drain for zoned block devices

Dan Carpenter (1):
      devlink: double free in devlink_resource_fill()

Daniel Kurtz (1):
      pinctrl/amd: poll InterruptEnable bits in amd_gpio_irq_set_type

Dave Jiang (2):
      uaccess: Fix is_source param for check_copy_size() in copy_to_iter_mcsafe()
      device-dax: Add missing address_space_operations

David S. Miller (1):
      rds: Fix build regression.

Davide Caratti (1):
      bnxt_en: don't try to offload VLAN 'modify' action

Dmitry Safonov (1):
      tty: Drop tty->count on tty_reopen() failure

Eli Cohen (1):
      net/mlx5: Fix read from coherent memory

Eric Dumazet (15):
      netpoll: make ndo_poll_controller() optional
      bonding: use netpoll_poll_dev() helper
      ixgbe: remove ndo_poll_controller
      ixgbevf: remove ndo_poll_controller
      fm10k: remove ndo_poll_controller
      ixgb: remove ndo_poll_controller
      igb: remove ndo_poll_controller
      ice: remove ndo_poll_controller
      i40evf: remove ndo_poll_controller
      mlx4: remove ndo_poll_controller
      mlx5: remove ndo_poll_controller
      bnx2x: remove ndo_poll_controller
      bnxt: remove ndo_poll_controller
      nfp: remove ndo_poll_controller
      tun: remove ndo_poll_controller

Friedemann Gerold (1):
      net: aquantia: memory corruption on jumbo frames

Gaku Inami (1):
      spi: sh-msiof: Fix invalid SPI use during system suspend

Geert Uytterhoeven (2):
      spi: rspi: Fix invalid SPI use during system suspend
      spi: rspi: Fix interrupted DMA transfers

Greg Kroah-Hartman (1):
      Linux 4.19-rc6

Guoju Fang (1):
      bcache: add separate workqueue for journal_write to avoid deadlock

Gustavo A. R. Silva (1):
      tty: vt_ioctl: fix potential Spectre v1

Hans Verkuil (2):
      media: video_function_calls.rst: drop obsolete video-set-attributes reference
      media: staging/media/mt9t031/Kconfig: remove bogus entry

Harry Pan (1):
      usb: core: safely deal with the dynamic quirk lists

Heikki Krogerus (2):
      usb: roles: Take care of driver module reference counting
      usb: typec: mux: Take care of driver module reference counting

Heiko Stuebner (1):
      iommu/rockchip: Free irqs in shutdown handler

Heiner Kallweit (1):
      r8169: fix autoneg issue on resume with RTL8168E

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix handling of write value for SISTR register

Ilya Dryomov (1):
      blk-mq: I/O and timer unplugs are inverted in blktrace

Ira Weiny (1):
      IB/hfi1: Fix SL array bounds check

Jacopo Mondi (1):
      media: i2c: mt9v111: Fix v4l2-ctrl error handling

Jakub Kicinski (1):
      tools: bpf: fix license for a compat header file

James Cowgill (1):
      RISC-V: include linux/ftrace.h in asm-prototypes.h

James Smart (1):
      scsi: lpfc: Synchronize access to remoteport via rport

Jan Kara (1):
      dax: Fix deadlock in dax_lock_mapping_entry()

Jan Kiszka (1):
      serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Jason Ekstrand (1):
      drm/syncobj: Don't leak fences when WAIT_FOR_SUBMIT is set

Jeff Barnhill (1):
      net/ipv6: Display all addresses in output of /proc/net/if_inet6

Jens Axboe (1):
      Revert "xen/blkfront: When purging persistent grants, keep them in the buffer"

Jisheng Zhang (1):
      PCI: dwc: Fix scheduling while atomic issues

Johannes Berg (1):
      smc: generic netlink family should be __ro_after_init

Johannes Thumshirn (1):
      scsi: sd: don't crash the host on invalid commands

John Fastabend (3):
      bpf: sockmap only allow ESTABLISHED sock state
      bpf: sockmap, fix transition through disconnect without close
      bpf: test_maps, only support ESTABLISHED socks

Jose Abreu (2):
      net: stmmac: Rework coalesce timer and fix multi-queue races
      net: stmmac: Fixup the tail addr setting in xmit path

Jozef Balga (1):
      media: af9035: prevent buffer overflow on write

Juergen Gross (1):
      xen/blkfront: correct purging of persistent grants

Kairui Song (1):
      x86/boot: Fix kexec booting failure in the SEV bit detection code

Karsten Graul (1):
      net/smc: no urgent data check for listen sockets

Kazuya Mizuguchi (1):
      ravb: do not write 1 to reserved bits

Keerthy (1):
      clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for non-am43 SoCs

Keith Busch (1):
      blk-mq: Allow blocking queue tag iter callbacks

Laura Abbott (2):
      scsi: ibmvscsis: Fix a stringop-overflow warning
      scsi: ibmvscsis: Ensure partition name is properly NUL terminated

Linus Walleij (2):
      spi: gpio: Fix copy-and-paste error
      Revert "drm/panel: Add device_link from panel device to DRM device"

Lorenzo Pieralisi (1):
      MAINTAINERS: Move mobiveil PCI driver entry where it belongs

Lu Baolu (1):
      iommu/vt-d: Handle memory shortage on pasid table allocation

Lubomir Rintel (1):
      Revert "uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct member name"

Lucas Stach (1):
      drm/etnaviv: add DMA configuration for etnaviv platform device

Maciej Żenczykowski (1):
      net-ethtool: ETHTOOL_GUFO did not and should not require CAP_NET_ADMIN

Majd Dibbiny (1):
      RDMA/uverbs: Fix validity check for modify QP

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock

Marek Lindner (2):
      batman-adv: fix backbone_gw refcount on queue_work() failure
      batman-adv: fix hardif_neigh refcount on queue_work() failure

Marek Szyprowski (1):
      regulator: Fix 'do-nothing' value for regulators without suspend state

Mark Bloch (1):
      IB/uverbs: Free uapi on destroy

Matthew Wilcox (1):
      filesystem-dax: Fix use of zero page

Matti Vaittinen (1):
      regulator: bd71837: Disable voltage monitoring for LDO3/4

Michael Bringmann (1):
      powerpc/pseries: Fix unitialized timer reset on migration

Michael Ellerman (1):
      selftests/powerpc: Fix Makefiles for headers_install change

Michael J. Ruhl (3):
      IB/hfi1: Invalid user input can result in crash
      IB/hfi1: Fix context recovery when PBC has an UnsupportedVL
      IB/hfi1: Fix destroy_qp hang after a link down

Michael Neuling (4):
      KVM: PPC: Book3S HV: Fix guest r11 corruption with POWER9 TM workarounds
      powerpc: Avoid code patching freed init sections
      powerpc/tm: Fix userspace r13 corruption
      powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Michael Schmitz (1):
      Input: atakbd - fix Atari CapsLock behaviour

Miguel Ojeda (1):
      MAINTAINERS: fix reference to moved drivers/{misc => auxdisplay}/panel.c

Mika Westerberg (3):
      pinctrl: cannonlake: Fix HOSTSW_OWN register offset of H variant
      Revert "pinctrl: intel: Do pin translation when lock IRQ"
      ACPI / hotplug / PCI: Don't scan for non-hotplug bridges if slot is not bridge

Nathan Chancellor (3):
      net/mlx4: Use cpumask_available for eq->affinity_mask
      RDS: IB: Use DEFINE_PER_CPU_SHARED_ALIGNED for rds_ib_stats
      cpufreq: qcom-kryo: Fix section annotations

Oliver Neukum (2):
      USB: usbdevfs: sanitize flags more
      USB: usbdevfs: restore warning for nonsensical flags

Paolo Abeni (2):
      ip6_tunnel: be careful when accessing the inner header
      ip_tunnel: be careful when accessing the inner header

Parav Pandit (1):
      RDMA/core: Set right entry state before releasing reference

Peter Hutterer (1):
      Input: uinput - allow for max == min during input_absinfo validation

Petr Machata (1):
      mlxsw: spectrum: Bump required firmware version

Philipp Zabel (1):
      regulator: da9063: fix DT probing with constraints

Randy Dunlap (1):
      media: platform: fix cros-ec-cec build error

Reinette Chatre (1):
      perf/core: Add sanity check to deal with pinned event failure

Rex Zhu (1):
      drm/amdgpu: Fix vce work queue was not cancelled when suspend

Roman Li (1):
      drm/amd/display: Fix Vega10 lightup on S3 resume

Russell King (1):
      sfp: fix oops with ethtool -m

Sabrina Dubroca (1):
      selftests: pmtu: properly redirect stderr to /dev/null

Saeed Mahameed (1):
      net/mlx5e: TLS, Read capabilities only when it is safe

Saif Hasan (1):
      mpls: allow routes on ip6gre devices

Sanyog Kale (1):
      soundwire: Fix acquiring bus lock twice during master release

Sean Tranchetti (1):
      netlabel: check for IPV4MASK in addrinfo_get

Sebastian Andrzej Siewior (1):
      Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()"

Selvin Xavier (1):
      RDMA/bnxt_re: Fix system crash during RDMA resource initialization

Shreyas NC (2):
      soundwire: Fix duplicate stream state assignment
      soundwire: Fix incorrect exit after configuring stream

Song Qiang (1):
      Input: gpio-keys - fix a documentation index issue

Srikar Dronamraju (1):
      powerpc/numa: Use associativity if VPHN hcall is successful

Stefan Agner (1):
      tty: serial: lpuart: avoid leaking struct tty_struct

Steve Wise (2):
      cxgb4: fix abort_req_rss6 struct
      RDMA/uverbs: Atomically flush and mark closed the comp event queue

Sudarsana Reddy Kalluru (3):
      qed: Fix populating the invalid stag value in multi function mode.
      qed: Do not add VLAN 0 tag to untagged frames in multi-function mode.
      qed: Add missing device config for RoCE EDPM in UFP mode.

Suren Baghdasaryan (2):
      NFC: Fix possible memory corruption when handling SHDLC I-Frame commands
      NFC: Fix the number of pipes

Susobhan Dey (1):
      nvme: properly propagate errors in nvme_mpath_init

Sven Eckelmann (9):
      batman-adv: Avoid probe ELP information leak
      batman-adv: Fix segfault when writing to throughput_override
      batman-adv: Fix segfault when writing to sysfs elp_interval
      batman-adv: Prevent duplicated gateway_node entry
      batman-adv: Prevent duplicated nc_node entry
      batman-adv: Prevent duplicated softif_vlan entry
      batman-adv: Prevent duplicated global TT entry
      batman-adv: Prevent duplicated tvlv handler
      batman-adv: Increase version number to 2018.3

Tao Ren (1):
      clocksource/drivers/fttmr010: Fix set_next_event handler

Thiago Jung Bauermann (1):
      powerpc/pkeys: Fix reading of ibm, processor-storage-keys property

Todor Tomov (1):
      media: camss: Use managed memory allocations

Toshi Kani (1):
      ext2, dax: set ext2_dax_aops for dax files

Ursula Braun (3):
      net/smc: fix non-blocking connect problem
      net/smc: remove duplicate mutex_unlock
      net/smc: enable fallback for connection abort in state INIT

Uwe Kleine-König (1):
      serial: imx: restore handshaking irq for imx1

Vincent Pelletier (2):
      scsi: target: iscsi: Use hex2bin instead of a re-implementation
      scsi: target: iscsi: Use bin2hex instead of a re-implementation

Wei Wang (2):
      Revert "ipv6: fix double refcount of fib6_metrics"
      ipv6: fix memory leak on dst->_metrics

Wei Yongjun (1):
      PCI: hv: Fix return value check in hv_pci_assign_slots()

Wen Xiong (1):
      scsi: ipr: System hung while dlpar adding primary ipr adapter back

Xin Long (1):
      sctp: update dst pmtu with the correct daddr

Xuewei Zhang (1):
      scsi: sd: Contribute to randomness when running rotational device

Yishai Hadas (1):
      IB/mlx5: Destroy the DEVX object upon error flow

Yu Zhao (1):
      regulator: fix crash caused by null driver data

YueHaibing (7):
      net/smc: fix sizeof to int comparison
      net: seeq: fix return type of ndo_start_xmit function
      net: cirrus: fix return type of ndo_start_xmit function
      net: sgi: fix return type of ndo_start_xmit function
      net: wiznet: fix return type of ndo_start_xmit function
      net: i825xx: fix return type of ndo_start_xmit function
      net: apple: fix return type of ndo_start_xmit function

zhong jiang (1):
      net: bnxt: Fix a uninitialized variable warning.

