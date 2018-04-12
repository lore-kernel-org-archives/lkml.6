Date: Thu, 12 Apr 2018 14:36:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.17
Message-ID: <20180412123637.GA21190@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.15.17 kernel.

All users of the 4.15 kernel series must upgrade.

The updated 4.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.15.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                  |    2=20
 arch/arm/boot/dts/ls1021a.dtsi                            |    2=20
 arch/arm64/mm/context.c                                   |   19 -
 arch/x86/include/asm/microcode.h                          |   10=20
 arch/x86/include/asm/processor.h                          |    1=20
 arch/x86/kernel/aperture_64.c                             |   46 +++
 arch/x86/kernel/cpu/common.c                              |   30 ++
 arch/x86/kernel/cpu/microcode/amd.c                       |   44 ++-
 arch/x86/kernel/cpu/microcode/core.c                      |  181 +++++++++=
+----
 arch/x86/kernel/cpu/microcode/intel.c                     |   62 +++-
 arch/x86/xen/mmu_hvm.c                                    |    2=20
 block/bfq-cgroup.c                                        |    7=20
 block/blk-mq.c                                            |   29 ++
 crypto/Makefile                                           |    1=20
 drivers/acpi/acpi_video.c                                 |   14 -
 drivers/acpi/ec.c                                         |    2=20
 drivers/acpi/ec_sys.c                                     |    2=20
 drivers/acpi/internal.h                                   |    2=20
 drivers/base/power/domain.c                               |   30 +-
 drivers/bluetooth/btusb.c                                 |    1=20
 drivers/bluetooth/hci_bcm.c                               |   25 -
 drivers/char/tpm/tpm-interface.c                          |   28 +-
 drivers/char/tpm/tpm.h                                    |    5=20
 drivers/clk/clk-divider.c                                 |    7=20
 drivers/clk/hisilicon/clkdivider-hi6220.c                 |    2=20
 drivers/clk/meson/clk-mpll.c                              |    2=20
 drivers/clk/nxp/clk-lpc32xx.c                             |    2=20
 drivers/clk/qcom/clk-regmap-divider.c                     |    2=20
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c                     |    4=20
 drivers/clk/sunxi-ng/ccu_div.c                            |    2=20
 drivers/cpufreq/powernv-cpufreq.c                         |   37 +-
 drivers/crypto/amcc/crypto4xx_alg.c                       |    6=20
 drivers/crypto/amcc/crypto4xx_core.c                      |   54 ++--
 drivers/devfreq/devfreq.c                                 |    3=20
 drivers/edac/mv64x60_edac.c                               |    2=20
 drivers/gpio/gpio-thunderx.c                              |    4=20
 drivers/gpio/gpiolib.c                                    |    6=20
 drivers/gpu/drm/amd/powerplay/smumgr/smu7_smumgr.c        |    6=20
 drivers/gpu/drm/i915/intel_bios.c                         |   12=20
 drivers/gpu/drm/msm/adreno/adreno_device.c                |    7=20
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_14nm.c                |    2=20
 drivers/hwmon/ina2xx.c                                    |   87 +++---
 drivers/infiniband/core/cma.c                             |    1=20
 drivers/infiniband/core/ucma.c                            |    7=20
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c                |   27 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c                    |    5=20
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c                  |    6=20
 drivers/infiniband/hw/i40iw/i40iw_d.h                     |    1=20
 drivers/infiniband/hw/i40iw/i40iw_puda.c                  |    2=20
 drivers/infiniband/hw/mlx5/main.c                         |    3=20
 drivers/infiniband/sw/rdmavt/cq.c                         |   10=20
 drivers/infiniband/ulp/ipoib/ipoib_cm.c                   |   10=20
 drivers/infiniband/ulp/ipoib/ipoib_ib.c                   |    2=20
 drivers/input/touchscreen/goodix.c                        |    8=20
 drivers/irqchip/irq-gic-v3.c                              |   11=20
 drivers/irqchip/irq-ompic.c                               |    4=20
 drivers/md/bcache/alloc.c                                 |   19 +
 drivers/md/bcache/request.c                               |   22 +
 drivers/md/bcache/super.c                                 |    6=20
 drivers/media/v4l2-core/videobuf2-core.c                  |    4=20
 drivers/mmc/host/sdhci-pci-core.c                         |    2=20
 drivers/mmc/host/sdhci.c                                  |    7=20
 drivers/mtd/tests/oobtest.c                               |   21 +
 drivers/net/bonding/bond_main.c                           |   73 ++---
 drivers/net/ethernet/chelsio/cxgb4vf/sge.c                |   23 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   |    4=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mdio.c   |    1=20
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_enet.c    |   17 +
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hns3_ethtool.c |   13 -
 drivers/net/ethernet/ibm/ibmvnic.c                        |    6=20
 drivers/net/ethernet/intel/i40evf/i40evf_main.c           |   20 +
 drivers/net/ethernet/marvell/sky2.c                       |    2=20
 drivers/net/ethernet/mellanox/mlx4/en_dcb_nl.c            |   77 +++--
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c           |   33 +-
 drivers/net/ethernet/mellanox/mlx4/en_main.c              |    4=20
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c            |    7=20
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h              |    1=20
 drivers/net/ethernet/mellanox/mlx4/resource_tracker.c     |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c      |   17 +
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c         |   17 -
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c          |   26 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c           |    7=20
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c           |   18 -
 drivers/net/ethernet/mellanox/mlx5/core/vport.c           |   33 ++
 drivers/net/ethernet/netronome/nfp/nfpcore/nfp_nsp.c      |    9=20
 drivers/net/ethernet/realtek/r8169.c                      |    4=20
 drivers/net/ppp/pptp.c                                    |    1=20
 drivers/net/team/team.c                                   |   12=20
 drivers/net/usb/lan78xx.c                                 |   23 +
 drivers/net/vrf.c                                         |    5=20
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c            |   22 +
 drivers/net/wireless/ti/wl1251/main.c                     |    3=20
 drivers/nvme/host/fabrics.c                               |   15 -
 drivers/nvme/host/fabrics.h                               |    2=20
 drivers/nvme/host/fc.c                                    |    1=20
 drivers/nvme/host/rdma.c                                  |    1=20
 drivers/nvme/target/fcloop.c                              |   47 ++-
 drivers/nvme/target/loop.c                                |    1=20
 drivers/pinctrl/intel/pinctrl-baytrail.c                  |    6=20
 drivers/power/supply/axp288_charger.c                     |   13 +
 drivers/rtc/rtc-ac100.c                                   |    6=20
 drivers/scsi/libiscsi.c                                   |   24 +
 drivers/scsi/libsas/sas_event.c                           |   74 ++++-
 drivers/scsi/libsas/sas_expander.c                        |    4=20
 drivers/scsi/libsas/sas_init.c                            |   27 +-
 drivers/scsi/libsas/sas_internal.h                        |    6=20
 drivers/scsi/libsas/sas_phy.c                             |   44 ---
 drivers/scsi/libsas/sas_port.c                            |   18 -
 drivers/scsi/megaraid/megaraid_sas_base.c                 |    2=20
 drivers/scsi/megaraid/megaraid_sas_fp.c                   |   16 -
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                      |   28 +-
 drivers/spi/spi-sh-msiof.c                                |   12=20
 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c      |   13 -
 drivers/target/target_core_user.c                         |    7=20
 drivers/thermal/hisi_thermal.c                            |    2=20
 drivers/thermal/int340x_thermal/int3400_thermal.c         |   10=20
 drivers/thermal/power_allocator.c                         |    2=20
 drivers/tty/n_gsm.c                                       |   17 +
 drivers/tty/serdev/core.c                                 |    5=20
 drivers/uio/uio_hv_generic.c                              |    7=20
 drivers/vhost/net.c                                       |    4=20
 drivers/vhost/vhost.c                                     |   17 -
 drivers/video/backlight/corgi_lcd.c                       |    2=20
 drivers/video/backlight/tdo24m.c                          |    2=20
 drivers/video/backlight/tosa_lcd.c                        |    2=20
 drivers/video/fbdev/vfb.c                                 |   17 +
 drivers/watchdog/dw_wdt.c                                 |   18 +
 fs/dcache.c                                               |   23 +
 fs/f2fs/file.c                                            |   20 -
 include/linux/clk-provider.h                              |    2=20
 include/linux/mlx5/driver.h                               |    2=20
 include/linux/netdevice.h                                 |    4=20
 include/scsi/libsas.h                                     |   17 -
 include/uapi/rdma/mlx5-abi.h                              |    2=20
 net/8021q/vlan_dev.c                                      |    6=20
 net/core/dev.c                                            |    4=20
 net/dsa/dsa_priv.h                                        |    8=20
 net/ipv4/arp.c                                            |    2=20
 net/ipv4/fib_semantics.c                                  |   20 -
 net/ipv4/ip_tunnel.c                                      |   11=20
 net/ipv6/ip6_gre.c                                        |    8=20
 net/ipv6/ip6_output.c                                     |   28 +-
 net/ipv6/ip6_tunnel.c                                     |   11=20
 net/ipv6/ip6_vti.c                                        |    7=20
 net/ipv6/route.c                                          |    3=20
 net/ipv6/seg6_iptunnel.c                                  |   16 -
 net/ipv6/sit.c                                            |    8=20
 net/l2tp/l2tp_netlink.c                                   |    2=20
 net/mac80211/cfg.c                                        |   28 ++
 net/mac80211/driver-ops.h                                 |    3=20
 net/netlink/af_netlink.c                                  |    3=20
 net/rds/bind.c                                            |    1=20
 net/sched/act_api.c                                       |    4=20
 net/sched/act_bpf.c                                       |   12=20
 net/sched/act_sample.c                                    |    3=20
 net/sched/act_skbmod.c                                    |    3=20
 net/sched/act_tunnel_key.c                                |    9=20
 net/sched/act_vlan.c                                      |    3=20
 net/sched/cls_u32.c                                       |    1=20
 net/sched/sch_red.c                                       |   26 +-
 net/sctp/ipv6.c                                           |    4=20
 net/sctp/socket.c                                         |   13 -
 net/strparser/strparser.c                                 |    4=20
 sound/soc/intel/atom/sst/sst_stream.c                     |    2=20
 sound/soc/intel/boards/cht_bsw_rt5645.c                   |    7=20
 sound/soc/intel/skylake/skl-messages.c                    |    4=20
 sound/soc/intel/skylake/skl-pcm.c                         |    4=20
 tools/perf/arch/powerpc/util/sym-handling.c               |    8=20
 tools/perf/builtin-record.c                               |    4=20
 tools/perf/builtin-report.c                               |   18 +
 tools/perf/util/evsel.c                                   |   67 ++++-
 tools/perf/util/probe-event.c                             |   28 ++
 tools/perf/util/python-ext-sources                        |    1=20
 tools/perf/util/symbol.c                                  |    5=20
 tools/perf/util/symbol.h                                  |    1=20
 tools/perf/util/util.c                                    |    2=20
 tools/testing/selftests/net/msg_zerocopy.c                |   21 +
 177 files changed, 1710 insertions(+), 704 deletions(-)

Alex Estrin (1):
      IB/ipoib: Fix for notify send CQ failure messages

Alexander Potapenko (1):
      netlink: make sure nladdr has correct size in netlink_connect()

Alexey Khoroshilov (1):
      thermal: int3400_thermal: fix error handling in int3400_thermal_probe=
()

Andrew Lunn (1):
      net: dsa: Discard frames from unused ports

Andy Shevchenko (1):
      sdhci: Advertise 2.0v supply on SDIO host controller

Archit Taneja (1):
      drm/msm: Fix NULL deref in adreno_load_gpu

Arjun Vynipadath (1):
      cxgb4vf: Fix SGE FL buffer initialization logic for 64K pages

Arnd Bergmann (1):
      crypto: aes-generic - build with -Os on gcc-7+

Ashok Raj (4):
      x86/microcode/intel: Check microcode revision before updating sibling=
 threads
      x86/microcode/intel: Writeback and invalidate caches before updating =
microcode
      x86/microcode: Do not upload microcode if CPUs are offline
      x86/microcode: Synchronize late microcode loading

Borislav Petkov (8):
      x86/microcode: Propagate return value from updating functions
      x86/CPU: Add a microcode loader callback
      x86/CPU: Check CPU feature bits after microcode upgrade
      x86/microcode: Get rid of struct apply_microcode_ctx
      x86/microcode/intel: Look into the patch cache first
      x86/microcode: Request microcode on the BSP
      x86/microcode: Attempt late loading only when new microcode is present
      x86/microcode: Fix CPU synchronization routine

Catalin Marinas (1):
      arm64: asid: Do not replace active_asids if already 0

Chaitra P B (1):
      scsi: mpt3sas: Proper handling of set/clear of "ATA command pending" =
flag.

Chao Yu (1):
      f2fs: fix lock dependency in between dio_rwsem & i_mmap_sem

Christian Lamparter (1):
      crypto: crypto4xx - perform aead icv check in the driver

Christoph Hellwig (1):
      nvme-fabrics: don't check for non-NULL module in nvmf_register_transp=
ort

Christophe JAILLET (2):
      ASoC: Intel: sst: Fix the return value of 'sst_send_byte_stream_mrfld=
()'
      EDAC, mv64x60: Fix an error handling path

Colin Ian King (1):
      wl1251: check return from call to wl1251_acx_arp_ip_filter

Cong Wang (1):
      net_sched: fix a missing idr_remove() in u32_delete_key()

Craig Dillabaugh (1):
      net sched actions: fix dumping which requires several messages to use=
r space

Daniel Jurgens (1):
      net/mlx5: Fix race for multiple RoCE enable

Dave Watson (1):
      strparser: Fix sign of err codes

David Ahern (2):
      net/ipv6: Fix route leaking between VRFs
      vrf: Fix use after free and double free in vrf_finish_output

David Lebrun (1):
      ipv6: sr: fix seg6 encap performances with TSO enabled

Davide Caratti (5):
      net/sched: fix NULL dereference in the error path of tcf_bpf_init()
      net/sched: fix NULL dereference in the error path of tcf_vlan_init()
      net/sched: fix NULL dereference in the error path of tcf_sample_init()
      net/sched: fix NULL dereference in the error path of tunnel_key_init()
      net/sched: fix NULL dereference on the error path of tcf_skbmod_init()

Dirk van der Merwe (1):
      nfp: use full 40 bits of the NSP buffer address

Eran Ben Elisha (1):
      net/mlx4_en: Fix mixed PFC and Global pause user control requests

Eric Dumazet (10):
      net: fix possible out-of-bound read in skb_network_protocol()
      pptp: remove a buggy dst release in pptp_connect()
      sctp: do not leak kernel memory to user space
      sctp: sctp_sockaddr_af must check minimal addr length for AF_INET6
      net: fool proof dev_valid_name()
      ip_tunnel: better validate user provided tunnel names
      ipv6: sit: better validate user provided tunnel names
      ip6_gre: better validate user provided tunnel names
      ip6_tunnel: better validate user provided tunnel names
      vti6: better validate user provided tunnel names

Feras Daoud (1):
      net/mlx5e: IPoIB, Use correct timestamp in child receive flow

Fuyun Liang (3):
      net: hns3: fix for getting auto-negotiation state in hclge_get_autoneg
      net: hns3: add Asym Pause support to phy default features
      net: hns3: fix for changing MTU

Gal Pressman (1):
      net: Fix netdev_WARN_ONCE macro

Gautham R. Shenoy (1):
      powernv-cpufreq: Add helper to extract pstate from PMSR

Geert Uytterhoeven (3):
      thermal/drivers/hisi: Remove bogus const from function return type
      spi: sh-msiof: Fix timeout failures for TX-only DMA transfers
      ACPI: EC: Fix debugfs_create_*() usage

Greg Kroah-Hartman (1):
      Linux 4.15.17

Gustavo A. R. Silva (1):
      PM / devfreq: Fix potential NULL pointer dereference in governor_store

Hangbin Liu (2):
      l2tp: fix missing print session offset info
      vlan: also check phy_driver ts_info for vlan's real device

Hans de Goede (6):
      ACPI / video: Default lcd_only to true on Win8-ready and newer machin=
es
      ASoC: Intel: cht_bsw_rt5645: Analog Mic support
      pinctrl: baytrail: Enable glitch filter for GPIOs used as interrupts
      power: supply: axp288_charger: Properly stop work on probe-error / re=
move
      serdev: Fix serdev_uevent failure on ACPI enumerated serdev-controlle=
rs
      Input: goodix - disable IRQs while suspended

Heiner Kallweit (1):
      r8169: fix setting driver_data after register_netdev

Ioan Moldovan (1):
      Bluetooth: Add a new 04ca:3015 QCA_ROME device

Jacob Keller (1):
      i40evf: don't rely on netif_running() outside rtnl_lock()

James Smart (2):
      nvme_fcloop: disassocate local port structs
      nvme_fcloop: fix abort race condition

Jason Wang (3):
      vhost: correctly remove wait queue during poll failure
      vhost: validate log when IOTLB is enabled
      vhost_net: add missing lock nesting notation

Jason Yan (3):
      scsi: libsas: Use dynamic alloced work to avoid sas event lost
      scsi: libsas: fix memory leak in sas_smp_get_phy_events()
      scsi: libsas: fix error when getting phy events

Javier Martinez Canillas (1):
      tpm: return a TPM_RC_COMMAND_CODE response if command is not implemen=
ted

Jeff Barnhill (1):
      net/ipv6: Increment OUTxxx counters after netfilter hook

Jernej =C5=A0krabec (1):
      clk: sunxi-ng: a83t: Add M divider to TCON1 clock

Jerome Brunet (1):
      clk: divider: fix incorrect usage of container_of

Jian Shen (3):
      net: hns3: Fix an error of total drop packet statistics
      net: hns3: Fix a loop index error of tqp statistics query
      net: hns3: Fix an error macro definition of HNS3_TQP_STAT

Jianbo Liu (2):
      net/mlx5e: Fix memory usage issues in offloading TC flows
      net/mlx5e: Don't override vport admin link state in switchdev mode

Jin Yao (1):
      perf report: Fix a no annotate browser displayed issue

Jiri Bohac (1):
      x86/gart: Exclude GART aperture from vmcore

Jiri Olsa (2):
      perf evsel: Fix swap for samples with raw data
      perf tools: Fix copyfile_offset update of output offset

Kai-Heng Feng (1):
      sky2: Increase D3 delay to sky2 stops working after suspend

Leon Romanovsky (1):
      RDMA/cma: Mark end of CMA ID messages

Linus Walleij (1):
      gpio: label descriptors using the device name

Lukas Wunner (1):
      Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO

Maciej Purski (1):
      hwmon: (ina2xx) Make calibration register value fixed

Maor Gottlieb (1):
      IB/mlx5: Report inner RSS capability

Martin Blumenstingl (1):
      clk: meson: mpll: use 64-bit maths in params_from_rate

Masami Hiramatsu (2):
      perf probe: Find versioned symbols from map
      perf probe: Add warning message if there is unexpected event name

Mauro Carvalho Chehab (1):
      media: videobuf2-core: don't go out of the buffer range

Mengting Zhang (1):
      perf evsel: Enable ignore_missing_thread for pid option

Miguel Fadon Perlines (1):
      arp: fix arp_filter on l3slave devices

Mike Christie (1):
      tcmu: release blocks for partially setup cmds

Mike Marciniszyn (1):
      IB/rdmavt: Allocate CQ memory on the correct node

Ming Lei (3):
      blk-mq: avoid to map CPU into stale hw queue
      blk-mq: fix race between updating nr_hw_queues and switching io sched
      blk-mq: fix kernel oops in blk_mq_tag_idle()

Miquel Raynal (1):
      mtd: mtd_oobtest: Handle bitflips during reads

Moni Shoua (1):
      net/mlx4_en: Change default QoS settings

Moshe Shemesh (2):
      net/mlx5e: Verify coalescing parameters in range
      net/mlx4_core: Fix memory leak while delete slave's resources

Nathan Fontenot (1):
      ibmvnic: Don't handle RX interrupts when not up.

NeilBrown (2):
      VFS: close race between getcwd() and d_move()
      staging: lustre: disable preempt while sampling processor id.

Nogah Frankel (1):
      net_sch: red: Fix the new offload indication

Oleksij Rempel (1):
      watchdog: dw_wdt: add stop watchdog operation

Or Gerlitz (1):
      net/mlx5e: Avoid using the ipv6 stub in the TC offload neigh update p=
ath

Paolo Abeni (1):
      ipv6: the entire IPv6 header chain must fit the first fragment

Paolo Valente (1):
      block, bfq: put async queues for root bfq groups too

Parav Pandit (1):
      RDMA/cma: Fix rdma_cm path querying for RoCE

Pardha Saradhi K (1):
      ASoC: Intel: Skylake: Disable clock gating during firmware and librar=
y download

Peng Li (1):
      net: hns3: free the ring_data structrue when change tqps

Peter Gro=C3=9Fe (1):
      mac80211: Fix setting TX power on monitor interfaces

Pieter \"PoroCYon\" Sluys (1):
      vfb: fix video mode and line_length being set when loaded

Rafael David Tinoco (1):
      scsi: libiscsi: Allow sd_shutdown on bad transport

Raghuram Chary J (1):
      lan78xx: Crash in lan78xx_writ_reg (Workqueue: events lan78xx_deferre=
d_multicast_write)

Rasmus Villemoes (1):
      ARM: dts: ls1021a: add "fsl,ls1021a-esdhc" compatible string to esdhc=
 node

Robert Jarzmik (1):
      backlight: tdo24m: Fix the SPI CS between transfers

Rodrigo Vivi (2):
      drm/i915/cnp: Ignore VBT request for know invalid DDC pin.
      drm/i915/cnp: Properly handle VBT ddc pin out of bounds.

Roi Dayan (1):
      net/mlx5e: Fix traffic being dropped on VF representor

Ronald Tschal=C3=A4r (1):
      Bluetooth: hci_bcm: Validate IRQ before using it

Roy Shterman (1):
      nvme-fabrics: protect against module unload during create_ctrl

Rui Hua (1):
      bcache: ret IOERR when read meets metadata error

Shahar Klein (1):
      net/mlx5e: Sync netdev vxlan ports at open

Shanker Donthineni (1):
      irqchip/gic-v3: Fix the driver probe() fail due to disabled GICC entry

Shiraz Saleem (2):
      i40iw: Fix sequence number for the first partial FPDU
      i40iw: Correct Q1/XF object count equation

Shivasharan S (2):
      scsi: megaraid_sas: Error handling for invalid ldcount provided by fi=
rmware in RAID map
      scsi: megaraid_sas: unload flag should be set after scsi_remove_host =
is called

Sowmini Varadhan (2):
      rds; Reset rs->rs_bound_addr in rds_add_bound() failure path
      selftests/net: fix bugs in address and port initialization

Stanislaw Gruszka (1):
      rt2x00: do not pause queue unconditionally on error path

Stefan Wahren (1):
      Bluetooth: hci_bcm: Make shutdown and device wake GPIO optional

Stephen Hemminger (1):
      uio_hv_generic: check that host supports monitor page

Tal Gilboa (1):
      net/mlx5e: Set EQE based as default TX interrupt moderation mode

Tang Junhui (2):
      bcache: stop writeback thread after detaching
      bcache: segregate flash only volume write streams

Tatyana Nikolova (1):
      i40iw: Validate correct IRD/ORD connection parameters

Tobias Brunner (1):
      ipv6: Reinject IPv6 packets if IPsec policy matches after SNAT

Tony Lindgren (1):
      tty: n_gsm: Allow ADM response in addition to UA for control dlci

Ulf Hansson (1):
      PM / domains: Don't skip driver's ->suspend|resume_noirq() callbacks

Vladimir Zapolskiy (1):
      gpiolib: don't dereference a desc before validation

Wei Yongjun (2):
      irqchip/ompic: fix return value check in ompic_of_init()
      gpio: thunderx: fix error return code in thunderx_gpio_probe()

Xin Long (5):
      bonding: fix the err path for dev hwaddr sync in bond_enslave
      bonding: move dev_mc_sync after master_upper_dev_link in bond_enslave
      bonding: process the err returned by dev_set_allmulti properly in bon=
d_enslave
      route: check sysctl_fib_multipath_use_neigh earlier than hash
      team: move dev_mc_sync after master_upper_dev_link in team_port_add

Yi Zeng (1):
      thermal: power_allocator: fix one race condition issue for thermal_in=
stances list

Yintian Tao (1):
      drm/amd/powerplay: fix memory leakage when reload (v2)

chenxiang (1):
      scsi: libsas: initialize sas_phy status according to response of DISC=
OVER

oulijun (1):
      RDMA/hns: Update the usage of sr_max and rr_max field


--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrPUtQACgkQONu9yGCS
aT5ScA//X6CM2hHMr1pG+J3vDrGI9tuXs1n9nik8AnX4UCB6yvQOpjObCcd2RDPD
0jAkhZT8Rgw2Wt619xVcI3BlOUHaXAlGs47JHqlonbTcshR8s8GVO4G+Cg4yf8gr
jcbHg6MCgqjQhII5AuBqlTTdlXIEaQ3yhX7RSFSRIHMrJbbHeBFVnHJtpJGyuVSD
HjuLJx1yrcm0HN/ohrGxW+ZduszfRQuD+NMI8TRCw0foiOl93JutpICFRtB0geN/
LahqM/0AL0OaAzSCCJ7sQTcErGrEYJvrXGk8VhiyBX1u9NCrIc/H9mqCDBfZ3nn2
VkX8ARfYnN1XOgrhlJsGo/5wj/FV/eH/kXah2tRolZXO209H7q0kljOvq7QSFECX
zB0NROOyX5oPpcqPlzcdjC2ULlnt60Ic5axXr8fbM0BIid3Md4kiPt6I5soKnzrx
AMzv4bRM6q60/dQ1QCVmiA5oTBUF1eyhZcgHgmfTLiCjnSESvQvKMJaJfFRx5cgQ
wdZj9iiBtoHaU6yq4A6mGZRrkyExNUtQeusMe5f/4hmPY+w0xbLgQ6LlkL9DNyNa
MTcUlrCWAwxat6/Wdrl3RRbjOrYhkEBblX5L220SGtc0zZRGB9k78HpMFpodV8fz
On3+VVuveh/fqQUGn5CXvhx9O8CMZe89UPqB8cbeK9zPZsu6tMQ=
=iDF2
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
