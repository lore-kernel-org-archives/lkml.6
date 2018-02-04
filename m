Date: Sun, 4 Feb 2018 11:42:33 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.17
Message-ID: <20180204104233.GA7425@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.17 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                |    2=20
 arch/arm/boot/dts/bcm-nsp.dtsi                          |    4=20
 arch/arm/boot/dts/bcm958623hr.dts                       |    4=20
 arch/arm/boot/dts/bcm958625hr.dts                       |    4=20
 arch/mips/kvm/mips.c                                    |    7=20
 arch/powerpc/kvm/powerpc.c                              |    7=20
 arch/s390/include/asm/mmu_context.h                     |    2=20
 arch/s390/include/asm/topology.h                        |    1=20
 arch/s390/kernel/smp.c                                  |    1=20
 arch/s390/kvm/kvm-s390.c                                |    7=20
 arch/x86/crypto/aesni-intel_asm.S                       |  199 ++++-------=
-----
 arch/x86/crypto/aesni-intel_glue.c                      |   77 ++++--
 arch/x86/include/asm/kvm_host.h                         |    3=20
 arch/x86/include/asm/segment.h                          |   12=20
 arch/x86/kvm/cpuid.h                                    |    2=20
 arch/x86/kvm/emulate.c                                  |   39 ++-
 arch/x86/kvm/ioapic.c                                   |   20 +
 arch/x86/kvm/vmx.c                                      |   55 ++--
 arch/x86/kvm/x86.c                                      |   20 -
 arch/x86/mm/extable.c                                   |    4=20
 arch/x86/xen/enlighten_pv.c                             |   37 +-
 arch/x86/xen/xen-asm_64.S                               |   14 +
 crypto/Kconfig                                          |    2=20
 crypto/af_alg.c                                         |   10=20
 crypto/sha3_generic.c                                   |    5=20
 drivers/acpi/device_sysfs.c                             |    4=20
 drivers/android/binder.c                                |   12=20
 drivers/android/binder_alloc.c                          |    2=20
 drivers/auxdisplay/Kconfig                              |    1=20
 drivers/block/loop.c                                    |   10=20
 drivers/block/null_blk.c                                |    5=20
 drivers/cpufreq/Kconfig                                 |    2=20
 drivers/crypto/inside-secure/safexcel_hash.c            |   56 ++--
 drivers/firmware/efi/Kconfig                            |    5=20
 drivers/gpio/gpio-ath79.c                               |    3=20
 drivers/gpio/gpio-iop.c                                 |    4=20
 drivers/gpio/gpio-stmpe.c                               |   20 -
 drivers/gpio/gpiolib.c                                  |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c       |   47 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                  |    4=20
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c        |    4=20
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c  |   18 +
 drivers/gpu/drm/bridge/lvds-encoder.c                   |   48 +++
 drivers/gpu/drm/bridge/tc358767.c                       |   73 +++--
 drivers/gpu/drm/omapdrm/displays/Kconfig                |    1=20
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c                |    3=20
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c                  |    3=20
 drivers/gpu/drm/vc4/vc4_irq.c                           |    3=20
 drivers/gpu/drm/vc4/vc4_v3d.c                           |    3=20
 drivers/hid/wacom_sys.c                                 |   24 -
 drivers/hid/wacom_wac.c                                 |   16 -
 drivers/hwmon/pmbus/pmbus_core.c                        |   21 -
 drivers/i2c/i2c-boardinfo.c                             |    2=20
 drivers/iio/adc/stm32-adc.c                             |    3=20
 drivers/iio/chemical/ccs811.c                           |   13 -
 drivers/input/rmi4/rmi_driver.c                         |   14 -
 drivers/input/rmi4/rmi_f03.c                            |   64 ++++-
 drivers/md/bcache/btree.c                               |    5=20
 drivers/media/usb/usbtv/usbtv-core.c                    |    1=20
 drivers/misc/mei/pci-me.c                               |    5=20
 drivers/mtd/nand/denali_pci.c                           |    4=20
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c       |    4=20
 drivers/net/ethernet/intel/igb/igb_main.c               |    2=20
 drivers/net/ethernet/marvell/mvpp2.c                    |   20 -
 drivers/net/ethernet/xilinx/Kconfig                     |    1=20
 drivers/net/phy/marvell10g.c                            |    5=20
 drivers/net/wireless/ath/ath9k/channel.c                |    2=20
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h             |    2=20
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c          |    2=20
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c    |    6=20
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c         |    9=20
 drivers/net/wireless/st/cw1200/sta.c                    |    4=20
 drivers/net/wireless/ti/wl1251/main.c                   |    2=20
 drivers/net/wireless/ti/wlcore/cmd.c                    |    5=20
 drivers/net/xen-netfront.c                              |   18 +
 drivers/nvme/host/fabrics.h                             |   30 ++
 drivers/nvme/host/fc.c                                  |   19 +
 drivers/nvme/host/pci.c                                 |   15 -
 drivers/nvme/host/rdma.c                                |   60 ++--
 drivers/nvme/target/fc.c                                |    9=20
 drivers/nvme/target/loop.c                              |   25 +-
 drivers/power/reset/zx-reboot.c                         |    4=20
 drivers/s390/crypto/zcrypt_api.c                        |    4=20
 drivers/scsi/aacraid/aachba.c                           |   15 -
 drivers/scsi/aacraid/commsup.c                          |   11=20
 drivers/scsi/ufs/ufshcd.c                               |    7=20
 drivers/spi/spi-imx.c                                   |   15 +
 drivers/staging/ccree/ssi_cipher.c                      |    1=20
 drivers/staging/ccree/ssi_driver.c                      |    2=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c     |    7=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h     |    2=20
 drivers/staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c  |    6=20
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c          |   14 -
 drivers/tty/serial/8250/8250_of.c                       |    5=20
 drivers/tty/serial/8250/8250_uniphier.c                 |    5=20
 drivers/tty/serial/imx.c                                |   14 -
 drivers/tty/tty_io.c                                    |    8=20
 drivers/tty/tty_ldisc.c                                 |    4=20
 drivers/usb/class/cdc-acm.c                             |    5=20
 drivers/usb/gadget/composite.c                          |    7=20
 drivers/usb/gadget/function/f_fs.c                      |    3=20
 drivers/usb/gadget/udc/core.c                           |    2=20
 drivers/usb/serial/Kconfig                              |    1=20
 drivers/usb/serial/io_edgeport.c                        |    1=20
 drivers/usb/serial/option.c                             |    5=20
 drivers/usb/serial/pl2303.c                             |    1=20
 drivers/usb/serial/pl2303.h                             |    1=20
 drivers/usb/serial/usb-serial-simple.c                  |    7=20
 drivers/usb/storage/uas.c                               |    7=20
 fs/btrfs/file.c                                         |    5=20
 fs/btrfs/free-space-cache.c                             |    3=20
 fs/btrfs/inode.c                                        |   10=20
 fs/btrfs/send.c                                         |  124 ++++++++-
 fs/btrfs/tree-log.c                                     |    2=20
 fs/btrfs/volumes.c                                      |   20 -
 fs/lockd/svc.c                                          |   16 +
 fs/namespace.c                                          |    1=20
 fs/nfs_common/grace.c                                   |   10=20
 fs/nfsd/nfs4state.c                                     |   34 +-
 fs/quota/dquot.c                                        |   22 +
 fs/reiserfs/super.c                                     |    1=20
 fs/xfs/xfs_aops.c                                       |    6=20
 fs/xfs/xfs_bmap_item.c                                  |   23 -
 fs/xfs/xfs_bmap_item.h                                  |    3=20
 fs/xfs/xfs_buf.c                                        |   15 -
 fs/xfs/xfs_dquot.c                                      |   14 -
 fs/xfs/xfs_dquot_item.c                                 |   40 +++
 fs/xfs/xfs_inode.c                                      |   21 +
 fs/xfs/xfs_log_recover.c                                |   75 +++++-
 fs/xfs/xfs_refcount_item.c                              |   21 -
 fs/xfs/xfs_refcount_item.h                              |    3=20
 include/crypto/gcm.h                                    |    8=20
 include/linux/kvm_host.h                                |    3=20
 include/linux/tty.h                                     |    2=20
 include/net/mac80211.h                                  |    8=20
 include/trace/events/rxrpc.h                            |    2=20
 include/uapi/linux/kfd_ioctl.h                          |   22 -
 kernel/events/core.c                                    |    1=20
 kernel/futex.c                                          |    6=20
 lib/test_firmware.c                                     |    1=20
 mm/kmemleak.c                                           |    2=20
 net/mac80211/mesh_hwmp.c                                |   15 -
 net/mac80211/mlme.c                                     |    2=20
 net/mac80211/tx.c                                       |   29 ++
 net/openvswitch/flow_netlink.c                          |   16 -
 net/rxrpc/af_rxrpc.c                                    |   13 +
 net/rxrpc/ar-internal.h                                 |    5=20
 net/rxrpc/call_accept.c                                 |    2=20
 net/rxrpc/call_object.c                                 |   19 +
 net/rxrpc/conn_client.c                                 |    2=20
 net/rxrpc/conn_object.c                                 |   42 +--
 net/rxrpc/net_ns.c                                      |    3=20
 net/rxrpc/sendmsg.c                                     |    5=20
 net/sctp/stream.c                                       |   32 +-
 net/sunrpc/xprtsock.c                                   |    1=20
 scripts/faddr2line                                      |   21 +
 security/integrity/ima/ima_policy.c                     |    2=20
 sound/pci/hda/patch_realtek.c                           |    6=20
 tools/gpio/gpio-event-mon.c                             |    1=20
 tools/power/cpupower/bench/system.c                     |    2=20
 tools/power/cpupower/utils/idle_monitor/cpuidle_sysfs.c |    9=20
 tools/usb/usbip/src/usbip_bind.c                        |    9=20
 tools/usb/usbip/src/usbip_list.c                        |    9=20
 virt/kvm/arm/arm.c                                      |    8=20
 virt/kvm/kvm_main.c                                     |   23 +
 165 files changed, 1520 insertions(+), 728 deletions(-)

Aaron Armstrong Skomra (1):
      HID: wacom: EKR: ensure devres groups at higher indexes are released

Abhishek Goel (2):
      cpupowerutils: bench - Fix cpu online check
      cpupower : Fix cpupower working when cpu0 is offline

Andrew Elble (1):
      nfsd: check for use of the closed special stateid

Andrey Gusakov (6):
      drm/bridge: tc358767: do no fail on hi-res displays
      drm/bridge: tc358767: filter out too high modes
      drm/bridge: tc358767: fix DP0_MISC register set
      drm/bridge: tc358767: fix timing calculations
      drm/bridge: tc358767: fix AUXDATAn registers access
      drm/bridge: tc358767: fix 1-lane behavior

Antoine Tenart (4):
      crypto: inside-secure - fix hash when length is a multiple of a block
      crypto: inside-secure - avoid unmapping DMA memory that was not mapped
      net: mvpp2: fix the txq_init error path
      net: phy: marvell10g: fix the PHY id mask

Ard Biesheuvel (1):
      crypto: sha3-generic - fixes for alignment and big endian operation

Arnd Bergmann (1):
      drm/omap: displays: panel-dpi: add backlight dependency

Benjamin Herrenschmidt (1):
      usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()

Carlos Maiolino (1):
      xfs: Properly retry failed dquot items in case of error during buffer=
 writeback

Chao Yu (1):
      quota: propagate error from __dquot_initialize

Christian K=F6nig (1):
      drm/amdgpu: don't try to move pinned BOs

Christophe JAILLET (2):
      bnxt_en: Fix an error handling path in 'bnxt_get_module_eeprom()'
      drm/omap: Fix error handling path in 'omap_dmm_probe()'

Chun-Yeow Yeoh (1):
      mac80211: fix the update of path metric for RANN frame

Colin Ian King (2):
      i2c: i2c-boardinfo: fix memory leaks on devinfo
      usb: gadget: don't dereference g until after it has been null checked

Corentin LABBE (2):
      crypto: gcm - add GCM IV size constant
      crypto: aesni - Use GCM IV size constant

Darrick J. Wong (3):
      xfs: always free inline data before resetting inode fork during ifree
      xfs: log recovery should replay deferred ops in order
      xfs: ubsan fixes

David Disseldorp (1):
      null_blk: fix dev->badblocks leak

David Hildenbrand (1):
      KVM: x86: fix em_fxstor() sleeping while in atomic

David Howells (3):
      rxrpc: The mutex lock returned by rxrpc_accept_call() needs releasing
      rxrpc: Provide a different lockdep key for call->user_mutex for kerne=
l calls
      rxrpc: Fix service endpoint expiry

Dmitry Eremin (1):
      staging: lustre: separate a connection destroy from free struct kib_c=
onn

Dmitry Torokhov (2):
      Input: synaptics-rmi4 - unmask F03 interrupts when port is opened
      Input: synaptics-rmi4 - do not delete interrupt memory too early

Dmitry V. Levin (1):
      uapi: fix linux/kfd_ioctl.h userspace compilation errors

Eduardo Otubo (1):
      xen-netfront: remove warning when unloading module

Emmanuel Grumbach (1):
      iwlwifi: mvm: fix the TX queue hang timeout for MONITOR vif type

Eric Anholt (1):
      drm/bridge: Fix lvds-encoder since the panel_bridge rework.

Fabio Estevam (1):
      serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS

Fabrice Gasnier (1):
      iio: adc: stm32: fix scan of multiple channels with DMA

Felix Kuehling (2):
      drm/amdgpu: Fix SDMA load/unload sequence on HWS disabled mode
      drm/amdkfd: Fix SDMA oversubsription handling

Filipe Manana (1):
      Btrfs: incremental send, fix wrong unlink path after renaming file

Florian Fainelli (2):
      ARM: dts: NSP: Disable AHCI controller for HR NSP boards
      ARM: dts: NSP: Fix PPI interrupt types

Ganesh Mahendran (1):
      android: binder: use VM_ALLOC to get vm area

Gaurav Kohli (1):
      tty: fix data race between tty_init_dev and flush of buf

Geert Uytterhoeven (1):
      net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit

Gilad Ben-Yossef (2):
      staging: ccree: NULLify backup_info when unused
      staging: ccree: fix fips event irq handling build

Greg Kroah-Hartman (2):
      USB: serial: pl2303: new device id for Chilitag
      Linux 4.14.17

Guilherme G. Piccoli (1):
      scsi: aacraid: Prevent crash in case of free interrupt during scsi EH=
 path

Gustavo A. R. Silva (1):
      scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_c=
onfig_vreg

Hans de Goede (2):
      ACPI / bus: Leave modalias empty for devices which are not present
      USB: cdc-acm: Do not log urb submission errors on disconnect

Harald Freudenberger (1):
      s390/zcrypt: Fix wrong comparison leading to strange load balancing

Hauke Mehrtens (1):
      crypto: ecdh - fix typo in KPP dependency of CRYPTO_ECDH

Hemant Kumar (1):
      usb: f_fs: Prevent gadget unbind if it is already unbound

Icenowy Zheng (1):
      media: usbtv: add a new usbid

James Hogan (1):
      cpufreq: Add Loongson machine dependencies

James Smart (1):
      nvmet-fc: correct ref counting error when deferred rcv used

Jan H. Sch=F6nherr (1):
      KVM: Let KVM_SET_SIGNAL_MASK work as advertised

Janakarajan Natarajan (1):
      KVM: x86: Fix CPUID function for word 6 (80000001_ECX)

Jason Gerecke (1):
      HID: wacom: Fix reporting of touch toggle (WACOM_HID_WD_MUTE_DEVICE) =
events

Jeff Layton (1):
      reiserfs: remove unneeded i_version bump

Jesse Chan (4):
      power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE
      gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE
      mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jia-Ju Bai (1):
      USB: serial: io_edgeport: fix possible sleep-in-atomic

Joel Stanley (1):
      tools/gpio: Fix build error with musl libc

Johan Hovold (1):
      USB: serial: simple: add Motorola Tetra driver

Johannes Berg (1):
      mac80211: use QoS NDP for AP probing

Josef Bacik (1):
      btrfs: fix deadlock when writing out space cache

Juergen Gross (1):
      x86/xen: Support early interrupts in xen pv guests

Junaid Shahid (2):
      crypto: aesni - Fix out-of-bounds access of the data buffer in generi=
c-gcm-aesni
      crypto: aesni - Fix out-of-bounds access of the AAD buffer in generic=
-gcm-aesni

Kai-Heng Feng (1):
      nvme-pci: disable APST on Samsung SSD 960 EVO + ASUS PRIME B350M-A

Larry Finger (1):
      staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID

Linus Torvalds (1):
      loop: fix concurrent lo_open/lo_release

Linus Walleij (1):
      gpio: Fix kernel stack leak to userspace

Liran Alon (4):
      KVM: nVMX/nSVM: Don't intercept #UD when running L2
      KVM: x86: emulator: Return to user-mode on L1 CPL=3D0 emulation failu=
re
      KVM: x86: Don't re-execute instruction when not passing CR2 value
      KVM: nVMX: Fix vmx_check_nested_events() return value in case an even=
t was reinjected to L2

Liu Bo (2):
      Btrfs: bail out gracefully rather than BUG_ON
      Btrfs: fix list_add corruption and soft lockups in fsync

Liu, Changcheng (1):
      scripts/faddr2line: extend usage on generic arch

Lyude Paul (1):
      igb: Free IRQs when device is hotplugged

Markus Trippelsdorf (1):
      VFS: Handle lazytime in do_mount()

Martijn Coenen (1):
      ANDROID: binder: remove waitqueue when thread exits.

Martin Schwidefsky (1):
      s390: fix alloc_pgste check in init_new_context again

Masahiro Yamada (1):
      serial: 8250_of: fix return code when probe function fails to get res=
et

Matthew Garrett (1):
      x86/efi: Clarify that reset attack mitigation needs appropriate users=
pace

Michael Lyle (1):
      bcache: check return value of register_shrinker

Michal Hocko (1):
      xfs: fortify xfs_alloc_buftarg error handling

Mike Rapoport (1):
      ima/policy: fix parsing of fsuuid

Minwoo Im (2):
      nvme-pci: avoid hmb desc array idx out-of-bound when hmmaxd set.
      nvme-pci: fix NULL pointer dereference in nvme_free_host_mem()

Mirza Krak (1):
      drm/rockchip: dw-mipi-dsi: fix possible un-balanced runtime PM enable

Narcisa Ana Maria Vasile (1):
      iio: chemical: ccs811: Fix output of IIO_CONCENTRATION channels

Nikita Leshenko (3):
      KVM: x86: ioapic: Fix level-triggered EOI and IOAPIC reconfigure race
      KVM: x86: ioapic: Clear Remote IRR when entry is switched to edge-tri=
ggered
      KVM: x86: ioapic: Preserve read-only values in the redirection table

Nikolay Borisov (1):
      btrfs: Fix transaction abort during failure in btrfs_rm_dev_item

OKAMOTO Yoshiaki (1):
      usb: option: Add support for FS040U modem

Oliver Neukum (2):
      CDC-ACM: apply quirk for card reader
      usb: uas: unconditionally bring back host after reset

Paolo Bonzini (1):
      KVM: x86: emulate #UD while in guest mode

Patrice Chotard (1):
      gpio: stmpe: i2c transfer are forbiden in atomic context

Peter Zijlstra (1):
      futex: Fix OWNER_DEAD fixup

Raghava Aditya Renukunta (2):
      scsi: aacraid: Fix udev inquiry race condition
      scsi: aacraid: Fix hang in kdump

Robert Lippert (1):
      hwmon: (pmbus) Use 64bit math for DIRECT format values

Sabrina Dubroca (2):
      crypto: aesni - fix typo in generic_gcmaes_decrypt
      crypto: aesni - add wrapper for generic gcm(aes)

Sagi Grimberg (4):
      nvme-fabrics: introduce init command check for a queue that is not al=
ive
      nvme-fc: check if queue is ready in queue_rq
      nvme-loop: check if queue is ready in queue_rq
      nvme-rdma: don't complete requests before a send work request has com=
pleted

Sara Sharon (1):
      iwlwifi: fix access to prph when transport is stopped

Shuah Khan (2):
      usbip: prevent bind loops on devices attached to vhci_hcd
      usbip: list: don't list devices attached to vhci_hcd

Stefan Agner (1):
      spi: imx: do not access registers while clocks disabled

Stefan Schake (2):
      drm/vc4: Account for interrupts in flight
      drm/vc4: Move IRQ enable to PM path

Stephan Mueller (2):
      crypto: aesni - handle zero length dst buffer
      crypto: af_alg - whitelist mask and type

Takashi Iwai (1):
      ALSA: hda - Reduce the suspend time consumption for ALC256

Tetsuo Handa (1):
      quota: Check for register_shrinker() failure.

Thomas Meyer (1):
      auxdisplay: img-ascii-lcd: Only build on archs that have IOMEM

Thomas Richter (1):
      s390/topology: fix compile error in file arch/s390/kernel/smp.c

Tomas Winkler (1):
      mei: me: allow runtime pm for platform with D0i3

Trond Myklebust (3):
      nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>=
0)
      nfsd: Ensure we check stateid validity in the seqid operation checks
      SUNRPC: Allow connect to return EHOSTUNREACH

Vasily Averin (4):
      grace: replace BUG_ON by WARN_ONCE in exit_net hook
      race of lockd inetaddr notifiers vs nlmsvc_rqst change
      lockd: fix "list_add double add" caused by legacy signal interface
      perf/core: Fix memory leak triggered by perf --namespace

Wanpeng Li (4):
      KVM: X86: Fix operand/address-size during instruction decoding
      KVM: nVMX: Fix mmu context after VMLAUNCH/VMRESUME failure
      KVM: X86: Fix softlockup when get the current kvmclock
      KVM: VMX: Fix rflags cache during vCPU reset

Wei Yongjun (2):
      serial: 8250_uniphier: fix error return code in uniphier_uart_probe()
      test_firmware: fix missing unlock on error in config_num_requests_sto=
re()

Xin Long (3):
      sctp: only allow the asoc reset when the asoc outq is empty
      sctp: avoid flushing unsent queue when doing asoc reset
      sctp: set sender next_tsn for the old result with ctsn_ack_point plus=
 1

Yisheng Xie (1):
      kmemleak: add scheduling point to kmemleak_scan()

shaoyunl (1):
      drm/amdkfd: Fix SDMA ring buffer size calculation

zhangliping (1):
      openvswitch: fix the incorrect flow action alloc size


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlp245gACgkQONu9yGCS
aT6Y3BAAnTC82uY99coJdFWMFhnmo35wpEJHjIQpQPsIRaBUTtb7OL9tKkHPKQC8
krdvTEilkawGZ6+dHZ4ZOSzhBSRSlszMC56/ThcFCm9DglG5glo3gqIfyIvAG1nU
bqZpUGJ21jV47YcM5KJ0mg0PX7ZXVT2kWHjgpnoBTqyLFAfBsjbMsud+Xwimd2lt
vse3RR6ESBgqrvdLVAoveQS/ea1SknD9jgcxQOFCC4L9ssVwS32D2HoCO6UD8niB
xUmYDthEH+pOE9qcyaW6XJclSj+1e50zx7trPGa8GkQWmcYprxtLfQDd9C4QLvrU
MMCQD6vLHUOxssXgRYCynkb8nQfVBdZXI0+VFQNvfy1RO+1SJJXMEap7z8sBoHr2
MLIDLia5MZt9ZKH8hEOBamGDb74Lvkvx82fc/krcFI5vdxRLYz/FQSBHf91afm2T
kHXVR+APyqScLnylWYELmK97IF6FALcuaO/Y/wQK+C4NNudz+XJOck5Pds3yx4Uz
Ejk9r7awBExpk0bEClxvnEVJvMW+UKvqAsEgAqw3h3LgP16PMAeeI9KnFn6mRCyM
Go47MM+4rJ3mU9g9fPD65uFfFjAFiFKKw32bY0KMItChSP3rS0RYoNMja3p+DhIr
GTALh1Da6bcQfJBR86p4UOz4A6RRHVW01O7mkpSzooD2KqMSPyc=
=DzsO
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
