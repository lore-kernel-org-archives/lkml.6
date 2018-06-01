Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751653AbeFALGm (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 07:06:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41097 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750831AbeFALGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 07:06:31 -0400
Message-ID: <a3d2d2b2c3559217eb8315d25df0c5883f922066.camel@decadent.org.uk>
Subject: Linux 3.2.102
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc: lwn@lwn.net
Date: Fri, 01 Jun 2018 12:06:17 +0100
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-QPz5tfK+Qmc29jfeNm4c"
X-Mailer: Evolution 3.28.2-1 
Mime-Version: 1.0
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QPz5tfK+Qmc29jfeNm4c
Content-Type: multipart/mixed; boundary="=-W9vyz0jz2fY6yPFuuJmg"


--=-W9vyz0jz2fY6yPFuuJmg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.2.102 kernel.

All users of the 3.2 kernel series should upgrade.  However, this is
likely to be the final stable update for 3.2.  Users should plan to
switch to a newer longterm stable branch such as 4.14, 4.9 or 4.4 in
the near future.

The updated 3.2.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
.git linux-3.2.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.gi=
t

The diff from 3.2.101 is attached to this message.

Ben.

------------

 Documentation/device-mapper/thin-provisioning.txt |   8 +-
 Documentation/filesystems/ext4.txt                |   2 +-
 Makefile                                          |   2 +-
 arch/alpha/kernel/pci_impl.h                      |   3 +-
 arch/alpha/kernel/process.c                       |  12 +--
 arch/mips/boot/compressed/Makefile                |   6 +-
 arch/mips/txx9/generic/setup.c                    |  12 +--
 arch/mips/txx9/generic/setup_tx4939.c             |   2 +-
 arch/mips/txx9/rbtx4939/setup.c                   |  11 +-
 arch/mn10300/mm/misalignment.c                    |   2 +-
 arch/openrisc/kernel/traps.c                      |  10 +-
 arch/powerpc/include/asm/topology.h               |   8 ++
 arch/powerpc/platforms/pseries/hotplug-cpu.c      |   2 +
 arch/s390/kernel/compat_linux.c                   |   8 +-
 arch/sh/kernel/traps_32.c                         |   3 +-
 arch/x86/crypto/crc32c-intel.c                    |   1 +
 arch/x86/include/asm/mce.h                        |   4 +
 arch/x86/include/asm/pgtable.h                    |   4 +-
 arch/x86/include/asm/pgtable_types.h              |   5 +
 arch/x86/kernel/cpu/mcheck/mce.c                  |  26 ++++-
 arch/x86/kernel/entry_64.S                        |   2 +-
 arch/x86/kernel/traps.c                           |  20 +++-
 crypto/af_alg.c                                   |   5 +
 crypto/ahash.c                                    |  33 +++++-
 crypto/algif_hash.c                               |  54 +++-------
 crypto/crc32c.c                                   |   1 +
 crypto/cryptd.c                                   |   6 +-
 crypto/shash.c                                    |  25 ++++-
 drivers/ata/ahci.c                                |   4 +-
 drivers/ata/libata-core.c                         |  13 ++-
 drivers/ata/libata-scsi.c                         |   4 +-
 drivers/block/pktcdvd.c                           |   4 +-
 drivers/cdrom/cdrom.c                             |   2 +-
 drivers/char/tpm/tpm_tis.c                        |   5 +-
 drivers/firmware/dmi_scan.c                       |  30 +++---
 drivers/gpu/drm/radeon/radeon_connectors.c        |  31 +++---
 drivers/gpu/drm/radeon/radeon_device.c            |   4 +
 drivers/gpu/drm/ttm/ttm_bo.c                      |   2 +-
 drivers/hid/hid-roccat-kovaplus.c                 |   2 +
 drivers/infiniband/core/cma.c                     |   3 +
 drivers/infiniband/core/ucma.c                    |  33 ++++--
 drivers/input/keyboard/matrix_keypad.c            |   4 +-
 drivers/media/dvb/bt8xx/bt878.c                   |   3 +-
 drivers/media/dvb/dvb-usb/cxusb.c                 |   2 +
 drivers/media/dvb/dvb-usb/dib0700_devices.c       |   1 +
 drivers/media/video/cpia2/cpia2_v4l.c             |   4 +-
 drivers/mmc/card/block.c                          |  21 ++++
 drivers/mtd/chips/jedec_probe.c                   |   2 +
 drivers/mtd/ubi/vmt.c                             |  15 ++-
 drivers/net/bonding/bond_main.c                   |   5 +-
 drivers/net/ethernet/intel/e1000e/ich8lan.c       |   2 +-
 drivers/net/ethernet/intel/e1000e/lib.c           |   6 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c   |  27 +++--
 drivers/net/ethernet/mellanox/mlx4/en_main.c      |   4 +-
 drivers/net/slip/slip.c                           |   4 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c     |   4 +
 drivers/s390/net/qeth_core.h                      |   5 +
 drivers/s390/net/qeth_core_main.c                 |  16 +--
 drivers/s390/net/qeth_l2_main.c                   |   2 +-
 drivers/s390/net/qeth_l3_main.c                   |   2 +-
 drivers/scsi/aacraid/aachba.c                     |  22 ++--
 drivers/scsi/arm/fas216.c                         |   2 +-
 drivers/scsi/ibmvscsi/ibmvfc.h                    |   2 +-
 drivers/scsi/libsas/sas_expander.c                |   3 +-
 drivers/tty/n_tty.c                               |   6 ++
 drivers/tty/serial/sh-sci.c                       |   2 +
 drivers/tty/vt/vt.c                               |   8 +-
 drivers/usb/class/cdc-acm.c                       |   5 +-
 drivers/usb/core/message.c                        |   4 +
 drivers/usb/core/quirks.c                         |   6 +-
 drivers/usb/dwc3/gadget.c                         |   2 +
 drivers/usb/host/ohci-q.c                         |  24 ++---
 drivers/usb/host/xhci-pci.c                       |   3 +
 drivers/usb/host/xhci.c                           |   3 +
 drivers/usb/host/xhci.h                           |   1 +
 drivers/usb/mon/mon_text.c                        | 124 ++++++++++++++----=
----
 drivers/usb/serial/io_edgeport.c                  |   1 -
 drivers/usb/serial/pl2303.c                       |   1 +
 drivers/usb/serial/pl2303.h                       |   1 +
 drivers/video/console/dummycon.c                  |   1 -
 drivers/video/sbuslib.c                           |   4 +-
 fs/btrfs/tree-log.c                               |   5 +-
 fs/cifs/file.c                                    |  26 +++--
 fs/ext4/balloc.c                                  |  25 ++++-
 fs/ext4/ialloc.c                                  |   7 ++
 fs/ext4/inode.c                                   |   7 ++
 fs/ext4/super.c                                   |   1 +
 fs/hugetlbfs/inode.c                              |  26 ++++-
 fs/jffs2/fs.c                                     |   1 -
 fs/namei.c                                        |   5 +-
 fs/ncpfs/ncplib_kernel.c                          |   4 +
 fs/nfs/super.c                                    |   2 +
 fs/ocfs2/cluster/nodemanager.c                    |  63 +++++++++--
 include/crypto/hash.h                             |  34 ++++--
 include/crypto/internal/hash.h                    |   2 +
 include/linux/crypto.h                            |   8 ++
 include/linux/fs.h                                |   4 +
 include/linux/nospec.h                            |   3 +-
 include/linux/perf_event.h                        |   2 +
 include/linux/usb/audio.h                         |   4 +-
 include/linux/usb/quirks.h                        |   3 +
 include/net/regulatory.h                          |   2 +-
 include/net/sctp/sctp.h                           |   7 +-
 kernel/events/core.c                              |   2 +-
 kernel/events/hw_breakpoint.c                     |  41 +++----
 kernel/hrtimer.c                                  |   7 +-
 kernel/posix-timers.c                             |  15 ++-
 kernel/relay.c                                    |   2 +-
 kernel/trace/trace_kprobe.c                       |  11 +-
 mm/hugetlb.c                                      |   9 ++
 mm/madvise.c                                      |   2 +-
 mm/mempolicy.c                                    |   3 +
 mm/vmscan.c                                       |  14 ++-
 net/9p/trans_virtio.c                             |   3 +-
 net/batman-adv/soft-interface.c                   |   7 +-
 net/bridge/br_sysfs_if.c                          |   3 +
 net/bridge/netfilter/ebt_among.c                  |  55 +++++++++-
 net/bridge/netfilter/ebtables.c                   |  17 ++-
 net/core/dev.c                                    |  12 ++-
 net/core/skbuff.c                                 |   4 +-
 net/dccp/proto.c                                  |   5 +
 net/decnet/af_decnet.c                            |  62 ++++++-----
 net/ipv4/igmp.c                                   |   4 +
 net/ipv4/ip_sockglue.c                            |  21 +---
 net/ipv4/netfilter/ipt_CLUSTERIP.c                |  24 ++++-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c    |   6 +-
 net/ipv4/netfilter/nf_nat_proto_common.c          |   7 +-
 net/ipv6/ipv6_sockglue.c                          |  27 ++---
 net/l2tp/l2tp_core.c                              |   8 +-
 net/l2tp/l2tp_netlink.c                           |   2 +
 net/l2tp/l2tp_ppp.c                               |  62 +++++------
 net/netfilter/xt_IDLETIMER.c                      |   9 +-
 net/netfilter/xt_LED.c                            |  12 +--
 net/netfilter/xt_RATEEST.c                        |  22 +++-
 net/netlink/af_netlink.c                          |   3 +
 net/netlink/genetlink.c                           |  12 ++-
 net/sctp/sm_make_chunk.c                          |   8 +-
 net/xfrm/xfrm_user.c                              |  21 ++--
 sound/core/oss/pcm_oss.c                          |   4 +-
 sound/core/pcm_native.c                           |   2 +-
 sound/core/seq/seq_clientmgr.c                    |  29 +++--
 sound/core/seq/seq_fifo.c                         |   4 +-
 sound/core/seq/seq_memory.c                       |  14 ++-
 sound/core/seq/seq_memory.h                       |   3 +-
 sound/core/seq/seq_prioq.c                        |  27 ++---
 sound/core/seq/seq_prioq.h                        |   6 +-
 sound/core/seq/seq_queue.c                        |  28 ++---
 sound/drivers/aloop.c                             |  17 ++-
 sound/soc/au1x/ac97c.c                            |   6 +-
 sound/soc/nuc900/nuc900-ac97.c                    |   4 +-
 sound/usb/quirks-table.h                          |  47 ++++++++
 151 files changed, 1139 insertions(+), 583 deletions(-)

AMAN DEEP (1):
      usb: ohci: Proper handling of ed_rm_list to handle race condition bet=
ween usb_kill_urb() and finish_unlinks()

Adam Goode (1):
      ALSA: seq: correctly detect input buffer overflow

Alan Stern (1):
      USB: OHCI: Fix race between ED unlink and URB submission

Alexander Potapenko (1):
      netlink: make sure nladdr has correct size in netlink_connect()

Alexey Kodanev (2):
      dccp: check sk for closed state in dccp_sendmsg()
      sctp: verify size of a new chunk in _sctp_make_chunk()

Andy Lutomirski (1):
      x86/entry/64: Don't use IST entry for #BP stack

Anna-Maria Gleixner (1):
      hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)

Arnd Bergmann (1):
      scsi: fas216: fix sense buffer initialization

Bart Van Assche (1):
      pktcdvd: Fix pkt_setup_dev() error path

Bastian Stender (1):
      mmc: block: fix updating ext_csd caches on ioctl call

Ben Crocker (1):
      drm/radeon: insist on 32-bit DMA for Cedar on PPC64/PPC64LE

Ben Hutchings (1):
      Linux 3.2.102

Benjamin Poirier (1):
      e1000e: Fix check_for_link return value with autoneg off

Chien Tin Tung (1):
      RDMA/ucma: Correct option size check using optlen

Christophe JAILLET (1):
      media: bt8xx: Fix err 'bt878_probe()'

Clay McClure (1):
      ubi: Fix race condition between ubi volume creation and udev

Colin Ian King (1):
      scsi: aacraid: remove redundant setting of variable c

Cong Wang (2):
      netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert
      netfilter: ipt_CLUSTERIP: fix a refcount bug in clusterip_config_find=
_get()

Corentin Labbe (1):
      powerpc/pseries: Add empty update_numa_cpu_lookup_table() for NUMA=3D=
n

Dan Carpenter (8):
      staging: ncpfs: memory corruption in ncp_read_kernel()
      cdrom: information leak in cdrom_ioctl_media_changed()
      media: cpia2: Fix a couple off by one bugs
      ASoC: nuc900: Fix a loop timeout test
      ath9k_htc: Add a sanity check in ath9k_htc_ampdu_action()
      ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()
      HID: roccat: prevent an out of bounds read in kovaplus_profile_activa=
ted()
      ALSA: pcm: potential uninitialized return values

Danilo Krummrich (1):
      usb: quirks: add control message delay for 1b1c:1b20

Darrick J. Wong (1):
      ext4: fix block bitmap validation when bigalloc, ^flex_bg

David Rientjes (1):
      kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE

Dmitry Vyukov (1):
      netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_=
check()

Eran Ben Elisha (1):
      net/mlx4_en: Fix mixed PFC and Global pause user control requests

Eric Biggers (6):
      crypto: hash - introduce crypto_hash_alg_has_setkey()
      crypto: cryptd - pass through absence of ->setkey()
      crypto: hash - annotate algorithms taking optional key
      crypto: hash - prevent using keyed hashes without setting key
      libata: fix length validation of ATAPI-relayed SCSI commands
      libata: remove WARN() for DMA or PIO command without data

Eric Dumazet (3):
      net: igmp: add a missing rcu locking section
      netfilter: IDLETIMER: be syzkaller friendly
      l2tp: do not accept arbitrary sockets

Eric W. Biederman (4):
      signal/sh: Ensure si_signo is initialized in do_divide_error
      signal/openrisc: Fix do_unaligned_access to send the proper signal
      mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user=
 copy
      fs: Teach path_connected to handle nfs filesystems with multiple root=
s.

Erik Veijola (1):
      ALSA: usb-audio: Add a quirck for B&W PX headphones

Ernesto A. Fern=C3=A1ndez (1):
      ext4: correct documentation for grpid mount option

Eugene Syromiatnikov (1):
      s390: fix handling of -1 in set{,fs}[gu]id16 syscalls

Felix Kuehling (1):
      drm/ttm: Don't add swapped BOs to swap-LRU list

Florian Fainelli (1):
      MIPS: TXX9: use IS_ENABLED() macro

Florian Westphal (5):
      netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
      netfilter: ebtables: fix erroneous reject of last rule
      xfrm_user: uncoditionally validate esn replay attribute struct
      netfilter: bridge: ebt_among: add missing match size checks
      netfilter: bridge: ebt_among: add more missing match size checks

Greg Kroah-Hartman (1):
      USB: serial: pl2303: new device id for Chilitag

Greg Kurz (1):
      9p/trans_virtio: discard zero-length reply

Hangbin Liu (1):
      l2tp: fix missing print session offset info

Hans de Goede (5):
      USB: cdc-acm: Do not log urb submission errors on disconnect
      libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
      ahci: Add PCI-id for the Highpoint Rocketraid 644L card
      libata: Apply NOLPM quirk to Crucial M500 480 and 960GB SSDs
      libata: Make Crucial BX100 500GB LPM quirk apply to all firmware vers=
ions

Ivan Vecera (1):
      net/mlx4_en: do not ignore autoneg in mlx4_en_set_pauseparam()

Jack Stocker (1):
      Add delay-init quirk for Corsair K70 RGB keyboards

Jake Daryll Obina (1):
      jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path

Jakub Kicinski (1):
      net: fix race on decreasing number of TX queues

James Chapman (2):
      l2tp: don't use inet_shutdown on ppp session destroy
      l2tp: fix race in pppol2tp_release with session object destroy

James Hogan (1):
      MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}

Jan Beulich (1):
      x86/mm: Fix {pmd,pud}_{set,clear}_flags()

Jason Gunthorpe (1):
      sctp: Fix mangled IPv4 addresses on a IPv6 listening socket

Jason Yan (2):
      scsi: libsas: fix memory leak in sas_smp_get_phy_events()
      scsi: libsas: fix error when getting phy events

Jean Delvare (2):
      firmware/dmi_scan: constify strings
      firmware: dmi_scan: Fix handling of empty DMI strings

Jeremy Boone (1):
      tpm_tis: fix potential buffer overruns caused by bit glitches on the =
bus

Jia-Ju Bai (1):
      USB: serial: io_edgeport: fix possible sleep-in-atomic

Johannes Berg (1):
      regulatory: add NUL to request alpha2

Julia Lawall (1):
      USB: usbmon: remove assignment from IS_ERR argument

Julian Wiedmann (2):
      s390/qeth: fix SETIP command handling
      s390/qeth: free netdevice when removing a card

K.Prasad (1):
      perf/hwpb: Invoke __perf_event_disable() if interrupts are already di=
sabled

Kai-Heng Feng (2):
      libata: disable LPM for Crucial BX100 SSD 500GB drive
      xhci: Fix front USB ports on ASUS PRIME B350M-A

Kirill Marinushkin (1):
      ALSA: usb-audio: Fix parsing descriptor of UAC2 processing unit

Leon Romanovsky (7):
      RDMA/ucma: Limit possible option size
      RDMA/ucma: Check that user doesn't overflow QP state
      RDMA/ucma: Fix access to non-initialized CM_ID object
      RDMA/ucma: Fix use-after-free access in ucma_close
      RDMA/ucma: Ensure that CM_ID exists prior to access it
      RDMA/ucma: Check that device is connected prior to access it
      RDMA/ucma: Check that device exists prior to accessing it

Linus Torvalds (2):
      perf/hwbp: Simplify the perf-hwbp code, fix documentation
      tty: vt: fix up tabstops properly

Linus Walleij (1):
      mtd: jedec_probe: Fix crash in jedec_read_mfr()

Liu Bo (1):
      Btrfs: fix extent state leak from tree log

Lukas Czerner (1):
      ext4: fix bitmap position validation

Marc Kleine-Budde (1):
      slip: sl_alloc(): remove unused parameter "dev_t line"

Masami Hiramatsu (1):
      tracing: probeevent: Fix to support minus offset from symbol

Matt Redfearn (1):
      MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS

Matthew Wilcox (1):
      cifs: Fix missing put_xid in cifs_file_strict_mmap

Matthias Schiffer (1):
      batman-adv: fix packet checksum in receive path

Mauro Carvalho Chehab (1):
      media: cxusb, dib0700: ignore XC2028_I2C_FLUSH

Mel Gorman (1):
      mm: pin address_space before dereferencing it while isolating an LRU =
page

Michel D=C3=A4nzer (1):
      drm/radeon: Don't turn off DP sink when disconnected

Mike Kravetz (2):
      hugetlbfs: fix offset overflow in hugetlbfs mmap
      hugetlbfs: check for pgoff value overflow

Mikulas Patocka (2):
      alpha: fix reboot on Avanti platform
      alpha: fix crash if pthread_create races with signal delivery

Nathan Fontenot (1):
      powerpc/numa: Invalidate numa_cpu_lookup_table on cpu remove

Nicolas Dichtel (2):
      netlink: ensure to loop over all netns in genlmsg_multicast_allns()
      netlink: avoid a double skb free in genlmsg_mcast()

Nicolas Pitre (1):
      console/dummy: leave .con_font_get set to NULL

Oliver Neukum (1):
      CDC-ACM: apply quirk for card reader

Paolo Abeni (5):
      netfilter: on sockopt() acquire sock lock only in the required scope
      netfilter: drop outermost socket lock in getsockopt()
      netfilter: x_tables: fix missing timer initialization in xt_LED
      netfilter: nat: cope with negative port range
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Pete Zaitcev (1):
      usb: usbmon: Read text within supplied buffer size

Peter Malone (1):
      fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbus=
fb_ioctl_helper().

Raghava Aditya Renukunta (1):
      scsi: aacraid: Fix udev inquiry race condition

Rasmus Villemoes (1):
      nospec: Allow index argument to have const-qualified type

Seunghun Han (1):
      x86/MCE: Serialize sysfs changes

Stefan Roese (1):
      ALSA: pcm: Use dma_bytes as size parameter in dma_mmap_coherent()

Stephan Mueller (1):
      crypto: af_alg - whitelist mask and type

Takashi Iwai (7):
      ALSA: seq: Fix racy pool initializations
      ALSA: seq: Don't allow resizing pool in use
      ALSA: seq: More protection for concurrent write and ioctl races
      ALSA: seq: Fix possible UAF in snd_seq_check_queue()
      ALSA: seq: Clear client entry before deleting else at closing
      ALSA: aloop: Sync stale timer before release
      ALSA: aloop: Fix access to not-yet-ready substream via cable

Tejun Heo (1):
      tty: make n_tty_read() always abort if hangup is in progress

Theodore Ts'o (2):
      ext4: fail ext4_iget for root directory if unallocated
      ext4: add validity checks for bitmap block numbers

Thinh Nguyen (1):
      usb: dwc3: gadget: Set maxpacket size for ep0 IN

Thomas Gleixner (1):
      posix-timers: Protect posix clock array access against speculation

Tony Luck (1):
      x86/MCE: Save microcode revision in machine check records

Tyrel Datwyler (1):
      scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info

Ulrich Hecht (1):
      serial: sh-sci: prevent lockup on full TTY buffers

Vinicius Costa Gomes (1):
      skbuff: Fix not waking applications when errors are enqueued

Wang Nan (1):
      x86/traps: Enable DEBUG_STACK after cpu_init() for TRAP_DB/BP

Xin Long (2):
      bridge: check brport attr show in brport_show
      bonding: process the err returned by dev_set_allmulti properly in bon=
d_enslave

Yisheng Xie (1):
      mm/mempolicy.c: avoid use uninitialized preferred_node

Zhang Bo (1):
      Input: matrix_keypad - fix race when disabling interrupts

Zhouyi Zhou (1):
      ext4: save error to disk in __ext4_grp_locked_error()

alex chen (1):
      ocfs2: subsystem.su_mutex is required while accessing the item->ci_pa=
rent

chenjie (1):
      mm/madvise.c: fix madvise() infinite loop under special circumstances

mulhern (1):
      dm thin: fix documentation relative to low water mark threshold

--=20
Ben Hutchings
This sentence contradicts itself - no actually it doesn't.


--=-W9vyz0jz2fY6yPFuuJmg
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.2.102.patch"
Content-Disposition: attachment; filename="linux-3.2.102.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Documentation/device-mapper/thin-provisioning.txt b/Documentat=
ion/device-mapper/thin-provisioning.txt
index 801d9d1cf82b..55faf875ef99 100644
--- a/Documentation/device-mapper/thin-provisioning.txt
+++ b/Documentation/device-mapper/thin-provisioning.txt
@@ -109,9 +109,11 @@ $low_water_mark is expressed in blocks of size $data_b=
lock_size.  If
 free space on the data device drops below this level then a dm event
 will be triggered which a userspace daemon should catch allowing it to
 extend the pool device.  Only one such event will be sent.
-Resuming a device with a new table itself triggers an event so the
-userspace daemon can use this to detect a situation where a new table
-already exceeds the threshold.
+
+No special event is triggered if a just resumed device's free space is bel=
ow
+the low water mark. However, resuming a device always triggers an
+event; a userspace daemon should verify that free space exceeds the low
+water mark when handling this event.
=20
 Thin provisioning
 -----------------
diff --git a/Documentation/filesystems/ext4.txt b/Documentation/filesystems=
/ext4.txt
index 4917cf24a5e0..447384b88128 100644
--- a/Documentation/filesystems/ext4.txt
+++ b/Documentation/filesystems/ext4.txt
@@ -238,7 +238,7 @@ data_err=3Dignore(*)	Just print an error message if an =
error occurs
 data_err=3Dabort		Abort the journal if an error occurs in a file
 			data buffer in ordered mode.
=20
-grpid			Give objects the same group ID as their creator.
+grpid			New objects have the group ID of their parent.
 bsdgroups
=20
 nogrpid		(*)	New objects have the group ID of their creator.
diff --git a/Makefile b/Makefile
index b571211a32b5..46779a681440 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 2
-SUBLEVEL =3D 101
+SUBLEVEL =3D 102
 EXTRAVERSION =3D
 NAME =3D Sleepy Otter
=20
diff --git a/arch/alpha/kernel/pci_impl.h b/arch/alpha/kernel/pci_impl.h
index 85457b2d4516..cc742131a88b 100644
--- a/arch/alpha/kernel/pci_impl.h
+++ b/arch/alpha/kernel/pci_impl.h
@@ -143,7 +143,8 @@ struct pci_iommu_arena
 };
=20
 #if defined(CONFIG_ALPHA_SRM) && \
-    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA))
+    (defined(CONFIG_ALPHA_CIA) || defined(CONFIG_ALPHA_LCA) || \
+     defined(CONFIG_ALPHA_AVANTI))
 # define NEED_SRM_SAVE_RESTORE
 #else
 # undef NEED_SRM_SAVE_RESTORE
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
index 89bbe5b41145..42c2481535dc 100644
--- a/arch/alpha/kernel/process.c
+++ b/arch/alpha/kernel/process.c
@@ -279,7 +279,7 @@ copy_thread(unsigned long clone_flags, unsigned long us=
p,
 	struct thread_info *childti =3D task_thread_info(p);
 	struct pt_regs * childregs;
 	struct switch_stack * childstack, *stack;
-	unsigned long stack_offset, settls;
+	unsigned long stack_offset;
=20
 	stack_offset =3D PAGE_SIZE - sizeof(struct pt_regs);
 	if (!(regs->ps & 8))
@@ -288,11 +288,9 @@ copy_thread(unsigned long clone_flags, unsigned long u=
sp,
 	  (stack_offset + PAGE_SIZE + task_stack_page(p));
 	=09
 	*childregs =3D *regs;
-	settls =3D regs->r20;
 	childregs->r0 =3D 0;
 	childregs->r19 =3D 0;
 	childregs->r20 =3D 1;	/* OSF/1 has some strange fork() semantics.  */
-	regs->r20 =3D 0;
 	stack =3D ((struct switch_stack *) regs) - 1;
 	childstack =3D ((struct switch_stack *) childregs) - 1;
 	*childstack =3D *stack;
@@ -302,16 +300,16 @@ copy_thread(unsigned long clone_flags, unsigned long =
usp,
 	childti->pcb.flags =3D 1;	/* set FEN, clear everything else */
=20
 	/* Set a new TLS for the child thread?  Peek back into the
-	   syscall arguments that we saved on syscall entry.  Oops,
-	   except we'd have clobbered it with the parent/child set
-	   of r20.  Read the saved copy.  */
+	   syscall arguments that we saved on syscall entry. */
 	/* Note: if CLONE_SETTLS is not set, then we must inherit the
 	   value from the parent, which will have been set by the block
 	   copy in dup_task_struct.  This is non-intuitive, but is
 	   required for proper operation in the case of a threaded
 	   application calling fork.  */
 	if (clone_flags & CLONE_SETTLS)
-		childti->pcb.unique =3D settls;
+		childti->pcb.unique =3D regs->r20;
+	else
+		regs->r20 =3D 0;	/* OSF/1 has some strange fork() semantics.  */
=20
 	return 0;
 }
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed=
/Makefile
index 5042d51b0512..35034cf81047 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -105,4 +105,8 @@ OBJCOPYFLAGS_vmlinuz.srec :=3D $(OBJCOPYFLAGS) -S -O sr=
ec
 vmlinuz.srec: vmlinuz
 	$(call cmd,objcopy)
=20
-clean-files :=3D $(objtree)/vmlinuz $(objtree)/vmlinuz.{32,ecoff,bin,srec}
+clean-files +=3D $(objtree)/vmlinuz
+clean-files +=3D $(objtree)/vmlinuz.32
+clean-files +=3D $(objtree)/vmlinuz.ecoff
+clean-files +=3D $(objtree)/vmlinuz.bin
+clean-files +=3D $(objtree)/vmlinuz.srec
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.=
c
index ec38e00b2559..f9f07ba63072 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -632,7 +632,7 @@ void __init txx9_physmap_flash_init(int no, unsigned lo=
ng addr,
 				    unsigned long size,
 				    const struct physmap_flash_data *pdata)
 {
-#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
+#if IS_ENABLED(CONFIG_MTD_PHYSMAP)
 	struct resource res =3D {
 		.start =3D addr,
 		.end =3D addr + size - 1,
@@ -670,8 +670,7 @@ void __init txx9_physmap_flash_init(int no, unsigned lo=
ng addr,
 void __init txx9_ndfmc_init(unsigned long baseaddr,
 			    const struct txx9ndfmc_platform_data *pdata)
 {
-#if defined(CONFIG_MTD_NAND_TXX9NDFMC) || \
-	defined(CONFIG_MTD_NAND_TXX9NDFMC_MODULE)
+#if IS_ENABLED(CONFIG_MTD_NAND_TXX9NDFMC)
 	struct resource res =3D {
 		.start =3D baseaddr,
 		.end =3D baseaddr + 0x1000 - 1,
@@ -687,7 +686,7 @@ void __init txx9_ndfmc_init(unsigned long baseaddr,
 #endif
 }
=20
-#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+#if IS_ENABLED(CONFIG_LEDS_GPIO)
 static DEFINE_SPINLOCK(txx9_iocled_lock);
=20
 #define TXX9_IOCLED_MAXLEDS 8
@@ -810,7 +809,7 @@ void __init txx9_iocled_init(unsigned long baseaddr,
 void __init txx9_dmac_init(int id, unsigned long baseaddr, int irq,
 			   const struct txx9dmac_platform_data *pdata)
 {
-#if defined(CONFIG_TXX9_DMAC) || defined(CONFIG_TXX9_DMAC_MODULE)
+#if IS_ENABLED(CONFIG_TXX9_DMAC)
 	struct resource res[] =3D {
 		{
 			.start =3D baseaddr,
@@ -866,8 +865,7 @@ void __init txx9_aclc_init(unsigned long baseaddr, int =
irq,
 			   unsigned int dma_chan_out,
 			   unsigned int dma_chan_in)
 {
-#if defined(CONFIG_SND_SOC_TXX9ACLC) || \
-	defined(CONFIG_SND_SOC_TXX9ACLC_MODULE)
+#if IS_ENABLED(CONFIG_SND_SOC_TXX9ACLC)
 	unsigned int dma_base =3D dmac_id * TXX9_DMA_MAX_NR_CHANNELS;
 	struct resource res[] =3D {
 		{
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic=
/setup_tx4939.c
index ba3cec3155df..3cbeacc4ada7 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -317,7 +317,7 @@ void __init tx4939_sio_init(unsigned int sclk, unsigned=
 int cts_mask)
 	}
 }
=20
-#if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
+#if IS_ENABLED(CONFIG_TC35815)
 static u32 tx4939_get_eth_speed(struct net_device *dev)
 {
 	struct ethtool_cmd cmd;
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setu=
p.c
index 2ad8973ba13d..120343f7d234 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -40,8 +40,7 @@ static void __init rbtx4939_time_init(void)
 	tx4939_time_init(0);
 }
=20
-#if defined(__BIG_ENDIAN) && \
-	(defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE))
+#if defined(__BIG_ENDIAN) && IS_ENABLED(CONFIG_SMC91X)
 #define HAVE_RBTX4939_IOSWAB
 #define IS_CE1_ADDR(addr) \
 	((((unsigned long)(addr) - IO_BASE) & 0xfff00000) =3D=3D TXX9_CE(1))
@@ -187,7 +186,7 @@ static void __init rbtx4939_update_ioc_pen(void)
=20
 #define RBTX4939_MAX_7SEGLEDS	8
=20
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 static u8 led_val[RBTX4939_MAX_7SEGLEDS];
 struct rbtx4939_led_data {
 	struct led_classdev cdev;
@@ -263,7 +262,7 @@ static inline void rbtx4939_led_setup(void)
=20
 static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
 {
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#if IS_BUILTIN(CONFIG_LEDS_CLASS)
 	unsigned long flags;
 	local_irq_save(flags);
 	/* bit7: reserved for LED class */
@@ -287,7 +286,7 @@ static void rbtx4939_7segled_putc(unsigned int pos, uns=
igned char val)
 	__rbtx4939_7segled_putc(pos, val);
 }
=20
-#if defined(CONFIG_MTD_RBTX4939) || defined(CONFIG_MTD_RBTX4939_MODULE)
+#if IS_ENABLED(CONFIG_MTD_RBTX4939)
 /* special mapping for boot rom */
 static unsigned long rbtx4939_flash_fixup_ofs(unsigned long ofs)
 {
@@ -463,7 +462,7 @@ static void __init rbtx4939_device_init(void)
 		.flags =3D SMC91X_USE_16BIT,
 	};
 	struct platform_device *pdev;
-#if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
+#if IS_ENABLED(CONFIG_TC35815)
 	int i, j;
 	unsigned char ethaddr[2][6];
 	u8 bdipsw =3D readb(rbtx4939_bdipsw_addr) & 0x0f;
diff --git a/arch/mn10300/mm/misalignment.c b/arch/mn10300/mm/misalignment.=
c
index f9bb8cb1c14a..c91d8add40c0 100644
--- a/arch/mn10300/mm/misalignment.c
+++ b/arch/mn10300/mm/misalignment.c
@@ -438,7 +438,7 @@ asmlinkage void misalignment(struct pt_regs *regs, enum=
 exception_code code)
=20
 	info.si_signo	=3D SIGSEGV;
 	info.si_errno	=3D 0;
-	info.si_code	=3D 0;
+	info.si_code	=3D SEGV_MAPERR;
 	info.si_addr	=3D (void *) regs->pc;
 	force_sig_info(SIGSEGV, &info, current);
 	return;
diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index a4ec44a052b2..9ced6e966802 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -313,12 +313,12 @@ asmlinkage void do_unaligned_access(struct pt_regs *r=
egs, unsigned long address)
 	siginfo_t info;
=20
 	if (user_mode(regs)) {
-		/* Send a SIGSEGV */
-		info.si_signo =3D SIGSEGV;
+		/* Send a SIGBUS */
+		info.si_signo =3D SIGBUS;
 		info.si_errno =3D 0;
-		/* info.si_code has been set above */
-		info.si_addr =3D (void *)address;
-		force_sig_info(SIGSEGV, &info, current);
+		info.si_code =3D BUS_ADRALN;
+		info.si_addr =3D (void __user *)address;
+		force_sig_info(SIGBUS, &info, current);
 	} else {
 		printk("KERNEL: Unaligned Access 0x%.8lx\n", address);
 		show_registers(regs);
diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm=
/topology.h
index 1e104af08483..60097b3beaf6 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -89,6 +89,11 @@ extern void __init dump_numa_cpu_topology(void);
 extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
 extern void sysfs_remove_device_from_node(struct sys_device *dev, int nid)=
;
=20
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node=
)
+{
+	numa_cpu_lookup_table[cpu] =3D node;
+}
+
 #else
=20
 static inline void dump_numa_cpu_topology(void) {}
@@ -102,6 +107,9 @@ static inline void sysfs_remove_device_from_node(struct=
 sys_device *dev,
 						int nid)
 {
 }
+
+static inline void update_numa_cpu_lookup_table(unsigned int cpu, int node=
) {}
+
 #endif /* CONFIG_NUMA */
=20
 #if defined(CONFIG_NUMA) && defined(CONFIG_PPC_SPLPAR)
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/pl=
atforms/pseries/hotplug-cpu.c
index c986d08d0807..c01165d4eefc 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -32,6 +32,7 @@
 #include <asm/pSeries_reconfig.h>
 #include <asm/xics.h>
 #include "plpar_wrappers.h"
+#include <asm/topology.h>
 #include "offline_states.h"
=20
 /* This version can't take the spinlock, because it never returns */
@@ -319,6 +320,7 @@ static void pseries_remove_processor(struct device_node=
 *np)
 			BUG_ON(cpu_online(cpu));
 			set_cpu_present(cpu, false);
 			set_hard_smp_processor_id(cpu, -1);
+			update_numa_cpu_lookup_table(cpu, -1);
 			break;
 		}
 		if (cpu >=3D nr_cpu_ids)
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linu=
x.c
index 76fdbad69e97..93ce6deef5a9 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -114,7 +114,7 @@ asmlinkage long sys32_setregid16(u16 rgid, u16 egid)
=20
 asmlinkage long sys32_setgid16(u16 gid)
 {
-	return sys_setgid((gid_t)gid);
+	return sys_setgid(low2highgid(gid));
 }
=20
 asmlinkage long sys32_setreuid16(u16 ruid, u16 euid)
@@ -124,7 +124,7 @@ asmlinkage long sys32_setreuid16(u16 ruid, u16 euid)
=20
 asmlinkage long sys32_setuid16(u16 uid)
 {
-	return sys_setuid((uid_t)uid);
+	return sys_setuid(low2highuid(uid));
 }
=20
 asmlinkage long sys32_setresuid16(u16 ruid, u16 euid, u16 suid)
@@ -163,12 +163,12 @@ asmlinkage long sys32_getresgid16(u16 __user *rgid, u=
16 __user *egid, u16 __user
=20
 asmlinkage long sys32_setfsuid16(u16 uid)
 {
-	return sys_setfsuid((uid_t)uid);
+	return sys_setfsuid(low2highuid(uid));
 }
=20
 asmlinkage long sys32_setfsgid16(u16 gid)
 {
-	return sys_setfsgid((gid_t)gid);
+	return sys_setfsgid(low2highgid(gid));
 }
=20
 static int groups16_to_user(u16 __user *grouplist, struct group_info *grou=
p_info)
diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 7bbef95c9d1b..13a257d74b72 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -706,7 +706,8 @@ asmlinkage void do_divide_error(unsigned long r4, unsig=
ned long r5,
 		break;
 	}
=20
-	force_sig_info(SIGFPE, &info, current);
+	info.si_signo =3D SIGFPE;
+	force_sig_info(info.si_signo, &info, current);
 }
 #endif
=20
diff --git a/arch/x86/crypto/crc32c-intel.c b/arch/x86/crypto/crc32c-intel.=
c
index 7dad700304fc..da4e96b999f0 100644
--- a/arch/x86/crypto/crc32c-intel.c
+++ b/arch/x86/crypto/crc32c-intel.c
@@ -166,6 +166,7 @@ static struct shash_alg alg =3D {
 		.cra_name		=3D	"crc32c",
 		.cra_driver_name	=3D	"crc32c-intel",
 		.cra_priority		=3D	200,
+		.cra_flags		=3D	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=3D	CHKSUM_BLOCK_SIZE,
 		.cra_ctxsize		=3D	sizeof(u32),
 		.cra_module		=3D	THIS_MODULE,
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 0e8ae57d3656..589e4850e4ff 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -76,6 +76,10 @@ struct mce {
 	__u32 socketid;	/* CPU socket ID */
 	__u32 apicid;	/* CPU initial apic ID */
 	__u64 mcgcap;	/* MCGCAP MSR: machine check capabilities of CPU */
+	__u64 synd;	/* MCA_SYND MSR: only valid on SMCA systems */
+	__u64 ipid;	/* MCA_IPID MSR: only valid on SMCA systems */
+	__u64 ppin;	/* Protected Processor Inventory Number */
+	__u32 microcode;/* Microcode revision */
 };
=20
 /*
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.=
h
index 859dc4ae92ea..daaf934bb3d4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -254,14 +254,14 @@ static inline pmd_t pmd_set_flags(pmd_t pmd, pmdval_t=
 set)
 {
 	pmdval_t v =3D native_pmd_val(pmd);
=20
-	return __pmd(v | set);
+	return native_make_pmd(v | set);
 }
=20
 static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 {
 	pmdval_t v =3D native_pmd_val(pmd);
=20
-	return __pmd(v & ~clear);
+	return native_make_pmd(v & ~clear);
 }
=20
 static inline pmd_t pmd_mkold(pmd_t pmd)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pg=
table_types.h
index 34501e647214..3c46723d3b6d 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -271,6 +271,11 @@ static inline pmdval_t native_pmd_val(pmd_t pmd)
 #else
 #include <asm-generic/pgtable-nopmd.h>
=20
+static inline pmd_t native_make_pmd(pmdval_t val)
+{
+	return (pmd_t) { .pud.pgd =3D native_make_pgd(val) };
+}
+
 static inline pmdval_t native_pmd_val(pmd_t pmd)
 {
 	return native_pgd_val(pmd.pud.pgd);
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/=
mce.c
index fc54c3b3df81..1f439d48e7c6 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -52,6 +52,9 @@ static DEFINE_MUTEX(mce_chrdev_read_mutex);
 			      rcu_read_lock_sched_held() || \
 			      lockdep_is_held(&mce_chrdev_read_mutex))
=20
+/* sysfs synchronization */
+static DEFINE_MUTEX(mce_sysfs_mutex);
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/mce.h>
=20
@@ -122,6 +125,8 @@ void mce_setup(struct mce *m)
 	m->socketid =3D cpu_data(m->extcpu).phys_proc_id;
 	m->apicid =3D cpu_data(m->extcpu).initial_apicid;
 	rdmsrl(MSR_IA32_MCG_CAP, m->mcgcap);
+
+	m->microcode =3D boot_cpu_data.microcode;
 }
=20
 DEFINE_PER_CPU(struct mce, injectm);
@@ -218,7 +223,7 @@ static void print_mce(struct mce *m)
 	 */
 	pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x microcode %x=
\n",
 		m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
-		cpu_data(m->extcpu).microcode);
+		m->microcode);
=20
 	/*
 	 * Print out human-readable details about the MCE error,
@@ -1883,6 +1888,7 @@ static ssize_t set_ignore_ce(struct sys_device *s,
 	if (strict_strtoull(buf, 0, &new) < 0)
 		return -EINVAL;
=20
+	mutex_lock(&mce_sysfs_mutex);
 	if (mce_ignore_ce ^ !!new) {
 		if (new) {
 			/* disable ce features */
@@ -1895,6 +1901,8 @@ static ssize_t set_ignore_ce(struct sys_device *s,
 			on_each_cpu(mce_enable_ce, (void *)1, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
=20
@@ -1907,6 +1915,7 @@ static ssize_t set_cmci_disabled(struct sys_device *s=
,
 	if (strict_strtoull(buf, 0, &new) < 0)
 		return -EINVAL;
=20
+	mutex_lock(&mce_sysfs_mutex);
 	if (mce_cmci_disabled ^ !!new) {
 		if (new) {
 			/* disable cmci */
@@ -1918,6 +1927,8 @@ static ssize_t set_cmci_disabled(struct sys_device *s=
,
 			on_each_cpu(mce_enable_ce, NULL, 1);
 		}
 	}
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return size;
 }
=20
@@ -1925,8 +1936,19 @@ static ssize_t store_int_with_restart(struct sys_dev=
ice *s,
 				      struct sysdev_attribute *attr,
 				      const char *buf, size_t size)
 {
-	ssize_t ret =3D sysdev_store_int(s, attr, buf, size);
+	unsigned long old_check_interval =3D check_interval;
+	ssize_t ret =3D sysdev_store_ulong(s, attr, buf, size);
+
+	if (check_interval =3D=3D old_check_interval)
+		return ret;
+
+	if (check_interval < 1)
+		check_interval =3D 1;
+
+	mutex_lock(&mce_sysfs_mutex);
 	mce_restart();
+	mutex_unlock(&mce_sysfs_mutex);
+
 	return ret;
 }
=20
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index e992680d0eab..b15af620f6bd 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1401,7 +1401,7 @@ apicinterrupt XEN_HVM_EVTCHN_CALLBACK \
 	.pushsection .kprobes.text, "ax"
=20
 paranoidzeroentry_ist debug do_debug DEBUG_STACK
-paranoidzeroentry_ist int3 do_int3 DEBUG_STACK
+zeroentry int3 do_int3
 errorentry stack_segment do_stack_segment
 #ifdef CONFIG_XEN
 zeroentry xen_debug do_debug
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index edbd30a152c1..f755bffa2bb6 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -314,7 +314,6 @@ do_general_protection(struct pt_regs *regs, long error_=
code)
 	die("general protection fault", regs, error_code);
 }
=20
-/* May run on IST stack. */
 dotraplinkage void __kprobes do_int3(struct pt_regs *regs, long error_code=
)
 {
 #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
@@ -718,9 +717,17 @@ dotraplinkage void do_iret_error(struct pt_regs *regs,=
 long error_code)
 /* Set of traps needed for early debugging. */
 void __init early_trap_init(void)
 {
-	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
+	/*
+	 * Don't set ist to DEBUG_STACK as it doesn't work until TSS is
+	 * ready in cpu_init() <-- trap_init(). Before trap_init(), CPU
+	 * runs at ring 0 so it is impossible to hit an invalid stack.
+	 * Using the original stack works well enough at this early
+	 * stage. DEBUG_STACK will be equipped after cpu_init() in
+	 * trap_init().
+	 */
+	set_intr_gate_ist(X86_TRAP_DB, &debug, 0);
 	/* int3 can be called from all */
-	set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
+	set_system_intr_gate_ist(X86_TRAP_BP, &int3, 0);
 	set_intr_gate(X86_TRAP_PF, &page_fault);
 	load_idt(&idt_descr);
 }
@@ -781,5 +788,12 @@ void __init trap_init(void)
 	 */
 	cpu_init();
=20
+	/*
+	 * X86_TRAP_DB was installed in early_trap_init(). However,
+	 * DEBUG_STACK works only after cpu_init() loads TSS. See comments
+	 * in early_trap_init().
+	 */
+	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
+
 	x86_init.irqs.trap_init();
 }
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 68ec1ac4104a..db3e5ec4ce30 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -149,6 +149,7 @@ EXPORT_SYMBOL_GPL(af_alg_release_parent);
=20
 static int alg_bind(struct socket *sock, struct sockaddr *uaddr, int addr_=
len)
 {
+	const u32 allowed =3D 0;
 	struct sock *sk =3D sock->sk;
 	struct alg_sock *ask =3D alg_sk(sk);
 	struct sockaddr_alg *sa =3D (void *)uaddr;
@@ -156,6 +157,10 @@ static int alg_bind(struct socket *sock, struct sockad=
dr *uaddr, int addr_len)
 	void *private;
 	int err;
=20
+	/* If caller uses non-allowed flag, return error. */
+	if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
+		return -EINVAL;
+
 	if (sock->state =3D=3D SS_CONNECTED)
 		return -EINVAL;
=20
diff --git a/crypto/ahash.c b/crypto/ahash.c
index a6f94c4d7564..555c5e59c4a2 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -172,11 +172,18 @@ int crypto_ahash_setkey(struct crypto_ahash *tfm, con=
st u8 *key,
 			unsigned int keylen)
 {
 	unsigned long alignmask =3D crypto_ahash_alignmask(tfm);
+	int err;
=20
 	if ((unsigned long)key & alignmask)
-		return ahash_setkey_unaligned(tfm, key, keylen);
+		err =3D ahash_setkey_unaligned(tfm, key, keylen);
+	else
+		err =3D tfm->setkey(tfm, key, keylen);
+
+	if (err)
+		return err;
=20
-	return tfm->setkey(tfm, key, keylen);
+	crypto_ahash_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_ahash_setkey);
=20
@@ -349,7 +356,12 @@ EXPORT_SYMBOL_GPL(crypto_ahash_finup);
=20
 int crypto_ahash_digest(struct ahash_request *req)
 {
-	return crypto_ahash_op(req, crypto_ahash_reqtfm(req)->digest);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return crypto_ahash_op(req, tfm->digest);
 }
 EXPORT_SYMBOL_GPL(crypto_ahash_digest);
=20
@@ -435,7 +447,6 @@ static int crypto_ahash_init_tfm(struct crypto_tfm *tfm=
)
 	struct ahash_alg *alg =3D crypto_ahash_alg(hash);
=20
 	hash->setkey =3D ahash_nosetkey;
-	hash->has_setkey =3D false;
 	hash->export =3D ahash_no_export;
 	hash->import =3D ahash_no_import;
=20
@@ -450,7 +461,8 @@ static int crypto_ahash_init_tfm(struct crypto_tfm *tfm=
)
=20
 	if (alg->setkey) {
 		hash->setkey =3D alg->setkey;
-		hash->has_setkey =3D true;
+		if (!(alg->halg.base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY))
+			crypto_ahash_set_flags(hash, CRYPTO_TFM_NEED_KEY);
 	}
 	if (alg->export)
 		hash->export =3D alg->export;
@@ -599,5 +611,16 @@ struct hash_alg_common *ahash_attr_alg(struct rtattr *=
rta, u32 type, u32 mask)
 }
 EXPORT_SYMBOL_GPL(ahash_attr_alg);
=20
+bool crypto_hash_alg_has_setkey(struct hash_alg_common *halg)
+{
+	struct crypto_alg *alg =3D &halg->base;
+
+	if (alg->cra_type !=3D &crypto_ahash_type)
+		return crypto_shash_alg_has_setkey(__crypto_shash_alg(alg));
+
+	return __crypto_ahash_alg(alg)->setkey !=3D NULL;
+}
+EXPORT_SYMBOL_GPL(crypto_hash_alg_has_setkey);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Asynchronous cryptographic hash type");
diff --git a/crypto/algif_hash.c b/crypto/algif_hash.c
index d11d431251f7..3aa8890feef6 100644
--- a/crypto/algif_hash.c
+++ b/crypto/algif_hash.c
@@ -34,11 +34,6 @@ struct hash_ctx {
 	struct ahash_request req;
 };
=20
-struct algif_hash_tfm {
-	struct crypto_ahash *hash;
-	bool has_key;
-};
-
 static int hash_sendmsg(struct kiocb *unused, struct socket *sock,
 			struct msghdr *msg, size_t ignored)
 {
@@ -258,7 +253,7 @@ static int hash_check_key(struct socket *sock)
 	int err =3D 0;
 	struct sock *psk;
 	struct alg_sock *pask;
-	struct algif_hash_tfm *tfm;
+	struct crypto_ahash *tfm;
 	struct sock *sk =3D sock->sk;
 	struct alg_sock *ask =3D alg_sk(sk);
=20
@@ -272,7 +267,7 @@ static int hash_check_key(struct socket *sock)
=20
 	err =3D -ENOKEY;
 	lock_sock_nested(psk, SINGLE_DEPTH_NESTING);
-	if (!tfm->has_key)
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		goto unlock;
=20
 	if (!pask->refcnt++)
@@ -363,41 +358,17 @@ static struct proto_ops algif_hash_ops_nokey =3D {
=20
 static void *hash_bind(const char *name, u32 type, u32 mask)
 {
-	struct algif_hash_tfm *tfm;
-	struct crypto_ahash *hash;
-
-	tfm =3D kzalloc(sizeof(*tfm), GFP_KERNEL);
-	if (!tfm)
-		return ERR_PTR(-ENOMEM);
-
-	hash =3D crypto_alloc_ahash(name, type, mask);
-	if (IS_ERR(hash)) {
-		kfree(tfm);
-		return ERR_CAST(hash);
-	}
-
-	tfm->hash =3D hash;
-
-	return tfm;
+	return crypto_alloc_ahash(name, type, mask);
 }
=20
 static void hash_release(void *private)
 {
-	struct algif_hash_tfm *tfm =3D private;
-
-	crypto_free_ahash(tfm->hash);
-	kfree(tfm);
+	crypto_free_ahash(private);
 }
=20
 static int hash_setkey(void *private, const u8 *key, unsigned int keylen)
 {
-	struct algif_hash_tfm *tfm =3D private;
-	int err;
-
-	err =3D crypto_ahash_setkey(tfm->hash, key, keylen);
-	tfm->has_key =3D !err;
-
-	return err;
+	return crypto_ahash_setkey(private, key, keylen);
 }
=20
 static void hash_sock_destruct(struct sock *sk)
@@ -413,12 +384,11 @@ static void hash_sock_destruct(struct sock *sk)
=20
 static int hash_accept_parent_nokey(void *private, struct sock *sk)
 {
-	struct hash_ctx *ctx;
+	struct crypto_ahash *tfm =3D private;
 	struct alg_sock *ask =3D alg_sk(sk);
-	struct algif_hash_tfm *tfm =3D private;
-	struct crypto_ahash *hash =3D tfm->hash;
-	unsigned len =3D sizeof(*ctx) + crypto_ahash_reqsize(hash);
-	unsigned ds =3D crypto_ahash_digestsize(hash);
+	struct hash_ctx *ctx;
+	unsigned int len =3D sizeof(*ctx) + crypto_ahash_reqsize(tfm);
+	unsigned ds =3D crypto_ahash_digestsize(tfm);
=20
 	ctx =3D sock_kmalloc(sk, len, GFP_KERNEL);
 	if (!ctx)
@@ -438,7 +408,7 @@ static int hash_accept_parent_nokey(void *private, stru=
ct sock *sk)
=20
 	ask->private =3D ctx;
=20
-	ahash_request_set_tfm(&ctx->req, hash);
+	ahash_request_set_tfm(&ctx->req, tfm);
 	ahash_request_set_callback(&ctx->req, CRYPTO_TFM_REQ_MAY_BACKLOG,
 				   af_alg_complete, &ctx->completion);
=20
@@ -449,9 +419,9 @@ static int hash_accept_parent_nokey(void *private, stru=
ct sock *sk)
=20
 static int hash_accept_parent(void *private, struct sock *sk)
 {
-	struct algif_hash_tfm *tfm =3D private;
+	struct crypto_ahash *tfm =3D private;
=20
-	if (!tfm->has_key && crypto_ahash_has_setkey(tfm->hash))
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
 		return -ENOKEY;
=20
 	return hash_accept_parent_nokey(private, sk);
diff --git a/crypto/crc32c.c b/crypto/crc32c.c
index b2c030b256eb..55f5ed1a8403 100644
--- a/crypto/crc32c.c
+++ b/crypto/crc32c.c
@@ -234,6 +234,7 @@ static struct shash_alg alg =3D {
 		.cra_name		=3D	"crc32c",
 		.cra_driver_name	=3D	"crc32c-generic",
 		.cra_priority		=3D	100,
+		.cra_flags		=3D	CRYPTO_ALG_OPTIONAL_KEY,
 		.cra_blocksize		=3D	CHKSUM_BLOCK_SIZE,
 		.cra_alignmask		=3D	3,
 		.cra_ctxsize		=3D	sizeof(struct chksum_ctx),
diff --git a/crypto/cryptd.c b/crypto/cryptd.c
index d85fab975514..3443c1145a1f 100644
--- a/crypto/cryptd.c
+++ b/crypto/cryptd.c
@@ -603,7 +603,8 @@ static int cryptd_create_hash(struct crypto_template *t=
mpl, struct rtattr **tb,
 	if (err)
 		goto out_free_inst;
=20
-	inst->alg.halg.base.cra_flags =3D CRYPTO_ALG_ASYNC;
+	inst->alg.halg.base.cra_flags =3D CRYPTO_ALG_ASYNC |
+		(alg->cra_flags & CRYPTO_ALG_OPTIONAL_KEY);
=20
 	inst->alg.halg.digestsize =3D salg->digestsize;
 	inst->alg.halg.base.cra_ctxsize =3D sizeof(struct cryptd_hash_ctx);
@@ -617,7 +618,8 @@ static int cryptd_create_hash(struct crypto_template *t=
mpl, struct rtattr **tb,
 	inst->alg.finup  =3D cryptd_hash_finup_enqueue;
 	inst->alg.export =3D cryptd_hash_export;
 	inst->alg.import =3D cryptd_hash_import;
-	inst->alg.setkey =3D cryptd_hash_setkey;
+	if (crypto_shash_alg_has_setkey(salg))
+		inst->alg.setkey =3D cryptd_hash_setkey;
 	inst->alg.digest =3D cryptd_hash_digest_enqueue;
=20
 	err =3D ahash_register_instance(tmpl, inst);
diff --git a/crypto/shash.c b/crypto/shash.c
index 0d66c2edc6d8..5441f4ee0d59 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -57,11 +57,18 @@ int crypto_shash_setkey(struct crypto_shash *tfm, const=
 u8 *key,
 {
 	struct shash_alg *shash =3D crypto_shash_alg(tfm);
 	unsigned long alignmask =3D crypto_shash_alignmask(tfm);
+	int err;
=20
 	if ((unsigned long)key & alignmask)
-		return shash_setkey_unaligned(tfm, key, keylen);
+		err =3D shash_setkey_unaligned(tfm, key, keylen);
+	else
+		err =3D shash->setkey(tfm, key, keylen);
+
+	if (err)
+		return err;
=20
-	return shash->setkey(tfm, key, keylen);
+	crypto_shash_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_shash_setkey);
=20
@@ -179,6 +186,9 @@ int crypto_shash_digest(struct shash_desc *desc, const =
u8 *data,
 	struct shash_alg *shash =3D crypto_shash_alg(tfm);
 	unsigned long alignmask =3D crypto_shash_alignmask(tfm);
=20
+	if (crypto_shash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
 	if (((unsigned long)data | (unsigned long)out) & alignmask)
 		return shash_digest_unaligned(desc, data, len, out);
=20
@@ -358,7 +368,8 @@ int crypto_init_shash_ops_async(struct crypto_tfm *tfm)
 	crt->digest =3D shash_async_digest;
 	crt->setkey =3D shash_async_setkey;
=20
-	crt->has_setkey =3D alg->setkey !=3D shash_no_setkey;
+	crypto_ahash_set_flags(crt, crypto_shash_get_flags(shash) &
+				    CRYPTO_TFM_NEED_KEY);
=20
 	if (alg->export)
 		crt->export =3D shash_async_export;
@@ -518,8 +529,14 @@ static unsigned int crypto_shash_ctxsize(struct crypto=
_alg *alg, u32 type,
 static int crypto_shash_init_tfm(struct crypto_tfm *tfm)
 {
 	struct crypto_shash *hash =3D __crypto_shash_cast(tfm);
+	struct shash_alg *alg =3D crypto_shash_alg(hash);
+
+	hash->descsize =3D alg->descsize;
+
+	if (crypto_shash_alg_has_setkey(alg) &&
+	    !(alg->base.cra_flags & CRYPTO_ALG_OPTIONAL_KEY))
+		crypto_shash_set_flags(hash, CRYPTO_TFM_NEED_KEY);
=20
-	hash->descsize =3D crypto_shash_alg(hash)->descsize;
 	return 0;
 }
=20
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 93ace9bbd182..476a41405eac 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -542,7 +542,9 @@ static const struct pci_device_id ahci_pci_tbl[] =3D {
 	  .driver_data =3D board_ahci_yes_fbs },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL_EXT, 0x9230),
 	  .driver_data =3D board_ahci_yes_fbs },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642),
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0642), /* highpoint rocketraid 642L */
+	  .driver_data =3D board_ahci_yes_fbs },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TTI, 0x0645), /* highpoint rocketraid 644L */
 	  .driver_data =3D board_ahci_yes_fbs },
=20
 	/* Promise */
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 4e9beffa9979..ddfdb9c99001 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4155,6 +4155,16 @@ static const struct ata_blacklist_entry ata_device_b=
lacklist [] =3D {
 	{ "PIONEER DVD-RW  DVR-212D",	NULL,	ATA_HORKAGE_NOSETXFER },
 	{ "PIONEER DVD-RW  DVR-216D",	NULL,	ATA_HORKAGE_NOSETXFER },
=20
+	/* Crucial BX100 SSD 500GB has broken LPM support */
+	{ "CT500BX100SSD1",		NULL,	ATA_HORKAGE_NOLPM },
+
+	/* The 512GB version of the MX100 has LPM issues */
+	{ "Crucial_CT512MX100*",	NULL,	ATA_HORKAGE_NOLPM, },
+
+	/* 480GB+ M500 SSDs have LPM issues */
+	{ "Crucial_CT480M500*",		NULL,	ATA_HORKAGE_NOLPM, },
+	{ "Crucial_CT960M500*",		NULL,	ATA_HORKAGE_NOLPM, },
+
 	/* devices that don't properly handle TRIM commands */
 	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
=20
@@ -5060,8 +5070,7 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	 * We guarantee to LLDs that they will have at least one
 	 * non-zero sg if the command is a data command.
 	 */
-	if (WARN_ON_ONCE(ata_is_data(prot) &&
-			 (!qc->sg || !qc->n_elem || !qc->nbytes)))
+	if (ata_is_data(prot) && (!qc->sg || !qc->n_elem || !qc->nbytes))
 		goto sys_err;
=20
 	if (ata_is_dma(prot) || (ata_is_pio(prot) &&
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c6f7fa440f12..a7cd2106612f 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -3194,7 +3194,9 @@ static inline int __ata_scsi_queuecmd(struct scsi_cmn=
d *scmd,
 		if (likely((scsi_op !=3D ATA_16) || !atapi_passthru16)) {
 			/* relay SCSI command to ATAPI device */
 			int len =3D COMMAND_SIZE(scsi_op);
-			if (unlikely(len > scmd->cmd_len || len > dev->cdb_len))
+			if (unlikely(len > scmd->cmd_len ||
+				     len > dev->cdb_len ||
+				     scmd->cmd_len > ATAPI_CDB_LEN))
 				goto bad_cdb_len;
=20
 			xlat_func =3D atapi_xlat;
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a63b0a2b7805..87ba51e93b27 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2885,7 +2885,7 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	pd->pkt_dev =3D MKDEV(pktdev_major, idx);
 	ret =3D pkt_new_dev(pd, dev);
 	if (ret)
-		goto out_new_dev;
+		goto out_mem2;
=20
 	/* inherit events of the host device */
 	disk->events =3D pd->bdev->bd_disk->events;
@@ -2903,8 +2903,6 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	mutex_unlock(&ctl_mutex);
 	return 0;
=20
-out_new_dev:
-	blk_cleanup_queue(disk->queue);
 out_mem2:
 	put_disk(disk);
 out_mem:
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index a03e849158d4..3792f5cbc8e8 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2342,7 +2342,7 @@ static int cdrom_ioctl_media_changed(struct cdrom_dev=
ice_info *cdi,
 	if (!CDROM_CAN(CDC_SELECT_DISC) || arg =3D=3D CDSL_CURRENT)
 		return media_changed(cdi, 1);
=20
-	if ((unsigned int)arg >=3D cdi->capacity)
+	if (arg >=3D cdi->capacity)
 		return -EINVAL;
=20
 	info =3D kmalloc(sizeof(*info), GFP_KERNEL);
diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index 0c4885dd43b8..34c60cdf16e5 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -253,7 +253,8 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, si=
ze_t count)
 static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	int size =3D 0;
-	int expected, status;
+	int status;
+	u32 expected;
=20
 	if (count < TPM_HEADER_SIZE) {
 		size =3D -EIO;
@@ -268,7 +269,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf,=
 size_t count)
 	}
=20
 	expected =3D be32_to_cpu(*(__be32 *) (buf + 2));
-	if (expected > count) {
+	if (expected > count || expected < TPM_HEADER_SIZE) {
 		size =3D -EIO;
 		goto out;
 	}
diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
index 20f7daa33d1e..bde7ebb60a6d 100644
--- a/drivers/firmware/dmi_scan.c
+++ b/drivers/firmware/dmi_scan.c
@@ -14,7 +14,7 @@
  * of and an antecedent to, SMBIOS, which stands for System
  * Management BIOS.  See further: http://www.dmtf.org/standards
  */
-static char dmi_empty_string[] =3D "        ";
+static const char dmi_empty_string[] =3D "";
=20
 static u16 __initdata dmi_ver;
 /*
@@ -25,28 +25,24 @@ static int dmi_initialized;
 static const char * __init dmi_string_nosave(const struct dmi_header *dm, =
u8 s)
 {
 	const u8 *bp =3D ((u8 *) dm) + dm->length;
+	const u8 *nsp;
=20
 	if (s) {
-		s--;
-		while (s > 0 && *bp) {
+		while (--s > 0 && *bp)
 			bp +=3D strlen(bp) + 1;
-			s--;
-		}
-
-		if (*bp !=3D 0) {
-			size_t len =3D strlen(bp)+1;
-			size_t cmp_len =3D len > 8 ? 8 : len;
=20
-			if (!memcmp(bp, dmi_empty_string, cmp_len))
-				return dmi_empty_string;
+		/* Strings containing only spaces are considered empty */
+		nsp =3D bp;
+		while (*nsp =3D=3D ' ')
+			nsp++;
+		if (*nsp !=3D '\0')
 			return bp;
-		}
 	}
=20
-	return "";
+	return dmi_empty_string;
 }
=20
-static char * __init dmi_string(const struct dmi_header *dm, u8 s)
+static const char * __init dmi_string(const struct dmi_header *dm, u8 s)
 {
 	const char *bp =3D dmi_string_nosave(dm, s);
 	char *str;
@@ -130,7 +126,7 @@ static int __init dmi_checksum(const u8 *buf, u8 len)
 	return sum =3D=3D 0;
 }
=20
-static char *dmi_ident[DMI_STRING_MAX];
+static const char *dmi_ident[DMI_STRING_MAX];
 static LIST_HEAD(dmi_devices);
 int dmi_available;
=20
@@ -140,7 +136,7 @@ int dmi_available;
 static void __init dmi_save_ident(const struct dmi_header *dm, int slot, i=
nt string)
 {
 	const char *d =3D (const char*) dm;
-	char *p;
+	const char *p;
=20
 	if (dmi_ident[slot])
 		return;
@@ -246,7 +242,7 @@ static void __init dmi_save_oem_strings_devices(const s=
truct dmi_header *dm)
 	struct dmi_device *dev;
=20
 	for (i =3D 1; i <=3D count; i++) {
-		char *devname =3D dmi_string(dm, i);
+		const char *devname =3D dmi_string(dm, i);
=20
 		if (devname =3D=3D dmi_empty_string)
 			continue;
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/r=
adeon/radeon_connectors.c
index 40633f3ad044..7f40e0a9b3c5 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -76,25 +76,18 @@ void radeon_connector_hotplug(struct drm_connector *con=
nector)
 		/* don't do anything if sink is not display port, i.e.,
 		 * passive dp->(dvi|hdmi) adaptor
 		 */
-		if (dig_connector->dp_sink_type =3D=3D CONNECTOR_OBJECT_ID_DISPLAYPORT) =
{
-			int saved_dpms =3D connector->dpms;
-			/* Only turn off the display if it's physically disconnected */
-			if (!radeon_hpd_sense(rdev, radeon_connector->hpd.hpd)) {
-				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
-			} else if (radeon_dp_needs_link_train(radeon_connector)) {
-				/* Don't try to start link training before we
-				 * have the dpcd */
-				if (!radeon_dp_getdpcd(radeon_connector))
-					return;
-
-				/* set it to OFF so that drm_helper_connector_dpms()
-				 * won't return immediately since the current state
-				 * is ON at this point.
-				 */
-				connector->dpms =3D DRM_MODE_DPMS_OFF;
-				drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
-			}
-			connector->dpms =3D saved_dpms;
+		if (dig_connector->dp_sink_type =3D=3D CONNECTOR_OBJECT_ID_DISPLAYPORT &=
&
+		    radeon_hpd_sense(rdev, radeon_connector->hpd.hpd) &&
+		    radeon_dp_needs_link_train(radeon_connector)) {
+			/* Don't start link training before we have the DPCD */
+			if (!radeon_dp_getdpcd(radeon_connector))
+				return;
+
+			/* Turn the connector off and back on immediately, which
+			 * will trigger link training
+			 */
+			drm_helper_connector_dpms(connector, DRM_MODE_DPMS_OFF);
+			drm_helper_connector_dpms(connector, DRM_MODE_DPMS_ON);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeo=
n/radeon_device.c
index f122e6132d35..2cc26a1cc3bc 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -784,6 +784,10 @@ int radeon_device_init(struct radeon_device *rdev,
 	if ((rdev->flags & RADEON_IS_PCI) &&
 	    (rdev->family <=3D CHIP_RS740))
 		rdev->need_dma32 =3D true;
+#ifdef CONFIG_PPC64
+	if (rdev->family =3D=3D CHIP_CEDAR)
+		rdev->need_dma32 =3D true;
+#endif
=20
 	dma_bits =3D rdev->need_dma32 ? 32 : 40;
 	r =3D pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index f5e5037e0daa..35d98cf42b21 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -184,7 +184,7 @@ void ttm_bo_add_to_lru(struct ttm_buffer_object *bo)
 		list_add_tail(&bo->lru, &man->lru);
 		kref_get(&bo->list_kref);
=20
-		if (bo->ttm !=3D NULL) {
+		if (bo->ttm && !(bo->ttm->page_flags & TTM_PAGE_FLAG_SWAPPED)) {
 			list_add_tail(&bo->swap, &bo->glob->swap_lru);
 			kref_get(&bo->list_kref);
 		}
diff --git a/drivers/hid/hid-roccat-kovaplus.c b/drivers/hid/hid-roccat-kov=
aplus.c
index 112d934132c8..3d37c8971b21 100644
--- a/drivers/hid/hid-roccat-kovaplus.c
+++ b/drivers/hid/hid-roccat-kovaplus.c
@@ -37,6 +37,8 @@ static uint kovaplus_convert_event_cpi(uint value)
 static void kovaplus_profile_activated(struct kovaplus_device *kovaplus,
 		uint new_profile_index)
 {
+	if (new_profile_index >=3D ARRAY_SIZE(kovaplus->profile_settings))
+		return;
 	kovaplus->actual_profile =3D new_profile_index;
 	kovaplus->actual_cpi =3D kovaplus->profile_settings[new_profile_index].cp=
i_startup_level;
 	kovaplus->actual_x_sensitivity =3D kovaplus->profile_settings[new_profile=
_index].sensitivity_x;
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 87c1e055ac7e..f51c6e47752a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -3131,6 +3131,9 @@ int rdma_join_multicast(struct rdma_cm_id *id, struct=
 sockaddr *addr,
 	struct cma_multicast *mc;
 	int ret;
=20
+	if (!id->device)
+		return -EINVAL;
+
 	id_priv =3D container_of(id, struct rdma_id_private, id);
 	if (!cma_comp(id_priv, RDMA_CM_ADDR_BOUND) &&
 	    !cma_comp(id_priv, RDMA_CM_ADDR_RESOLVED))
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.=
c
index 91e82b7dadfa..49d94c146c0b 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -126,7 +126,7 @@ static inline struct ucma_context *_ucma_find_context(i=
nt id,
 	ctx =3D idr_find(&ctx_idr, id);
 	if (!ctx)
 		ctx =3D ERR_PTR(-ENOENT);
-	else if (ctx->file !=3D file)
+	else if (ctx->file !=3D file || !ctx->cm_id)
 		ctx =3D ERR_PTR(-EINVAL);
 	return ctx;
 }
@@ -393,6 +393,7 @@ static ssize_t ucma_create_id(struct ucma_file *file, c=
onst char __user *inbuf,
 	struct rdma_ucm_create_id cmd;
 	struct rdma_ucm_create_id_resp resp;
 	struct ucma_context *ctx;
+	struct rdma_cm_id *cm_id;
 	enum ib_qp_type qp_type;
 	int ret;
=20
@@ -413,9 +414,9 @@ static ssize_t ucma_create_id(struct ucma_file *file, c=
onst char __user *inbuf,
 		return -ENOMEM;
=20
 	ctx->uid =3D cmd.uid;
-	ctx->cm_id =3D rdma_create_id(ucma_event_handler, ctx, cmd.ps, qp_type);
-	if (IS_ERR(ctx->cm_id)) {
-		ret =3D PTR_ERR(ctx->cm_id);
+	cm_id =3D rdma_create_id(ucma_event_handler, ctx, cmd.ps, qp_type);
+	if (IS_ERR(cm_id)) {
+		ret =3D PTR_ERR(cm_id);
 		goto err1;
 	}
=20
@@ -425,14 +426,19 @@ static ssize_t ucma_create_id(struct ucma_file *file,=
 const char __user *inbuf,
 		ret =3D -EFAULT;
 		goto err2;
 	}
+
+	ctx->cm_id =3D cm_id;
 	return 0;
=20
 err2:
-	rdma_destroy_id(ctx->cm_id);
+	rdma_destroy_id(cm_id);
 err1:
 	mutex_lock(&mut);
 	idr_remove(&ctx_idr, ctx->id);
 	mutex_unlock(&mut);
+	mutex_lock(&file->mut);
+	list_del(&ctx->list);
+	mutex_unlock(&file->mut);
 	kfree(ctx);
 	return ret;
 }
@@ -873,10 +879,18 @@ static ssize_t ucma_init_qp_attr(struct ucma_file *fi=
le,
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
=20
+	if (cmd.qp_state > IB_QPS_ERR)
+		return -EINVAL;
+
 	ctx =3D ucma_get_ctx(file, cmd.id);
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	if (!ctx->cm_id->device) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
 	resp.qp_attr_mask =3D 0;
 	memset(&qp_attr, 0, sizeof qp_attr);
 	qp_attr.qp_state =3D cmd.qp_state;
@@ -1000,6 +1014,9 @@ static ssize_t ucma_set_option(struct ucma_file *file=
, const char __user *inbuf,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
+	if (unlikely(cmd.optlen > KMALLOC_MAX_SIZE))
+		return -EINVAL;
+
 	optval =3D kmalloc(cmd.optlen, GFP_KERNEL);
 	if (!optval) {
 		ret =3D -ENOMEM;
@@ -1026,7 +1043,7 @@ static ssize_t ucma_notify(struct ucma_file *file, co=
nst char __user *inbuf,
 {
 	struct rdma_ucm_notify cmd;
 	struct ucma_context *ctx;
-	int ret;
+	int ret =3D -EINVAL;
=20
 	if (copy_from_user(&cmd, inbuf, sizeof(cmd)))
 		return -EFAULT;
@@ -1035,7 +1052,9 @@ static ssize_t ucma_notify(struct ucma_file *file, co=
nst char __user *inbuf,
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
=20
-	ret =3D rdma_notify(ctx->cm_id, (enum ib_event_type) cmd.event);
+	if (ctx->cm_id->device)
+		ret =3D rdma_notify(ctx->cm_id, (enum ib_event_type)cmd.event);
+
 	ucma_put_ctx(ctx);
 	return ret;
 }
diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboar=
d/matrix_keypad.c
index e2ae657717ea..4389ed39dbed 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -214,8 +214,10 @@ static void matrix_keypad_stop(struct input_dev *dev)
 {
 	struct matrix_keypad *keypad =3D input_get_drvdata(dev);
=20
+	spin_lock_irq(&keypad->lock);
 	keypad->stopped =3D true;
-	mb();
+	spin_unlock_irq(&keypad->lock);
+
 	flush_work(&keypad->work.work);
 	/*
 	 * matrix_keypad_scan() will leave IRQs enabled;
diff --git a/drivers/media/dvb/bt8xx/bt878.c b/drivers/media/dvb/bt8xx/bt87=
8.c
index b34fa95185e4..db5382470bcd 100644
--- a/drivers/media/dvb/bt8xx/bt878.c
+++ b/drivers/media/dvb/bt8xx/bt878.c
@@ -434,8 +434,7 @@ static int __devinit bt878_probe(struct pci_dev *dev,
 	       bt878_num);
 	if (bt878_num >=3D BT878_MAX) {
 		printk(KERN_ERR "bt878: Too many devices inserted\n");
-		result =3D -ENOMEM;
-		goto fail0;
+		return -ENOMEM;
 	}
 	if (pci_enable_device(dev))
 		return -EIO;
diff --git a/drivers/media/dvb/dvb-usb/cxusb.c b/drivers/media/dvb/dvb-usb/=
cxusb.c
index 9f2a02c48377..0955935d0c39 100644
--- a/drivers/media/dvb/dvb-usb/cxusb.c
+++ b/drivers/media/dvb/dvb-usb/cxusb.c
@@ -772,6 +772,8 @@ static int dvico_bluebird_xc2028_callback(void *ptr, in=
t component,
 	case XC2028_RESET_CLK:
 		deb_info("%s: XC2028_RESET_CLK %d\n", __func__, arg);
 		break;
+	case XC2028_I2C_FLUSH:
+		break;
 	default:
 		deb_info("%s: unknown command %d, arg %d\n", __func__,
 			 command, arg);
diff --git a/drivers/media/dvb/dvb-usb/dib0700_devices.c b/drivers/media/dv=
b/dvb-usb/dib0700_devices.c
index f313182eb9d5..d25ea8892e64 100644
--- a/drivers/media/dvb/dvb-usb/dib0700_devices.c
+++ b/drivers/media/dvb/dvb-usb/dib0700_devices.c
@@ -405,6 +405,7 @@ static int stk7700ph_xc3028_callback(void *ptr, int com=
ponent,
 		dib7000p_set_gpio(adap->fe_adap[0].fe, 8, 0, 1);
 		break;
 	case XC2028_RESET_CLK:
+	case XC2028_I2C_FLUSH:
 		break;
 	default:
 		err("%s: unknown command %d, arg %d\n", __func__,
diff --git a/drivers/media/video/cpia2/cpia2_v4l.c b/drivers/media/video/cp=
ia2/cpia2_v4l.c
index 077eb1db80a1..4c6777ff7a5f 100644
--- a/drivers/media/video/cpia2/cpia2_v4l.c
+++ b/drivers/media/video/cpia2/cpia2_v4l.c
@@ -1152,7 +1152,7 @@ static int cpia2_querybuf(struct file *file, void *fh=
, struct v4l2_buffer *buf)
 	struct camera_data *cam =3D video_drvdata(file);
=20
 	if(buf->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE ||
-	   buf->index > cam->num_frames)
+	   buf->index >=3D cam->num_frames)
 		return -EINVAL;
=20
 	buf->m.offset =3D cam->buffers[buf->index].data - cam->frame_buffer;
@@ -1201,7 +1201,7 @@ static int cpia2_qbuf(struct file *file, void *fh, st=
ruct v4l2_buffer *buf)
=20
 	if(buf->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE ||
 	   buf->memory !=3D V4L2_MEMORY_MMAP ||
-	   buf->index > cam->num_frames)
+	   buf->index >=3D cam->num_frames)
 		return -EINVAL;
=20
 	DBG("QBUF #%d\n", buf->index);
diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index 1a3d6229fac3..1c72dba3f999 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -59,6 +59,9 @@ MODULE_ALIAS("mmc:block");
 #define INAND_CMD38_ARG_SECTRIM1 0x81
 #define INAND_CMD38_ARG_SECTRIM2 0x88
=20
+#define MMC_EXTRACT_INDEX_FROM_ARG(x) ((x & 0x00FF0000) >> 16)
+#define MMC_EXTRACT_VALUE_FROM_ARG(x) ((x & 0x0000FF00) >> 8)
+
 static DEFINE_MUTEX(block_mutex);
=20
 /*
@@ -392,6 +395,24 @@ static int mmc_blk_ioctl_cmd(struct block_device *bdev=
,
 		goto cmd_rel_host;
 	}
=20
+	/*
+	 * Make sure the cache of the PARTITION_CONFIG register and
+	 * PARTITION_ACCESS bits is updated in case the ioctl ext_csd write
+	 * changed it successfully.
+	 */
+	if ((MMC_EXTRACT_INDEX_FROM_ARG(cmd.arg) =3D=3D EXT_CSD_PART_CONFIG) &&
+	    (cmd.opcode =3D=3D MMC_SWITCH)) {
+		struct mmc_blk_data *main_md =3D dev_get_drvdata(&card->dev);
+		u8 value =3D MMC_EXTRACT_VALUE_FROM_ARG(cmd.arg);
+
+		/*
+		 * Update cache so the next mmc_blk_part_switch call operates
+		 * on up-to-date data.
+		 */
+		card->ext_csd.part_config =3D value;
+		main_md->part_curr =3D value & EXT_CSD_PART_CONFIG_ACC_MASK;
+	}
+
 	/*
 	 * According to the SD specs, some commands require a delay after
 	 * issuing the command.
diff --git a/drivers/mtd/chips/jedec_probe.c b/drivers/mtd/chips/jedec_prob=
e.c
index c443f527a53a..88ce823f9233 100644
--- a/drivers/mtd/chips/jedec_probe.c
+++ b/drivers/mtd/chips/jedec_probe.c
@@ -1888,6 +1888,8 @@ static inline u32 jedec_read_mfr(struct map_info *map=
, uint32_t base,
 	do {
 		uint32_t ofs =3D cfi_build_cmd_addr(0 + (bank << 8), map, cfi);
 		mask =3D (1 << (cfi->device_type * 8)) - 1;
+		if (ofs >=3D map->size)
+			return 0;
 		result =3D map_read(map, base + ofs);
 		bank++;
 	} while ((result.x[0] & mask) =3D=3D CFI_MFR_CONTINUATION);
diff --git a/drivers/mtd/ubi/vmt.c b/drivers/mtd/ubi/vmt.c
index 863835f4aefe..83ac8b43c4bd 100644
--- a/drivers/mtd/ubi/vmt.c
+++ b/drivers/mtd/ubi/vmt.c
@@ -312,6 +312,12 @@ int ubi_create_volume(struct ubi_device *ubi, struct u=
bi_mkvol_req *req)
 			vol->last_eb_bytes =3D vol->usable_leb_size;
 	}
=20
+	/* Make volume "available" before it becomes accessible via sysfs */
+	spin_lock(&ubi->volumes_lock);
+	ubi->volumes[vol_id] =3D vol;
+	ubi->vol_count +=3D 1;
+	spin_unlock(&ubi->volumes_lock);
+
 	/* Register character device for the volume */
 	cdev_init(&vol->cdev, &ubi_vol_cdev_operations);
 	vol->cdev.owner =3D THIS_MODULE;
@@ -354,11 +360,6 @@ int ubi_create_volume(struct ubi_device *ubi, struct u=
bi_mkvol_req *req)
 	if (err)
 		goto out_sysfs;
=20
-	spin_lock(&ubi->volumes_lock);
-	ubi->volumes[vol_id] =3D vol;
-	ubi->vol_count +=3D 1;
-	spin_unlock(&ubi->volumes_lock);
-
 	ubi_volume_notify(ubi, vol, UBI_VOLUME_ADDED);
 	if (paranoid_check_volumes(ubi))
 		dbg_err("check failed while creating volume %d", vol_id);
@@ -379,6 +380,10 @@ int ubi_create_volume(struct ubi_device *ubi, struct u=
bi_mkvol_req *req)
 out_cdev:
 	cdev_del(&vol->cdev);
 out_mapping:
+	spin_lock(&ubi->volumes_lock);
+	ubi->volumes[vol_id] =3D NULL;
+	ubi->vol_count -=3D 1;
+	spin_unlock(&ubi->volumes_lock);
 	if (do_free)
 		kfree(vol->eba_tbl);
 out_acc:
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_mai=
n.c
index 9145834cdebe..18ebffab9e7c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1704,8 +1704,11 @@ int bond_enslave(struct net_device *bond_dev, struct=
 net_device *slave_dev)
 		/* set allmulti level to new slave */
 		if (bond_dev->flags & IFF_ALLMULTI) {
 			res =3D dev_set_allmulti(slave_dev, 1);
-			if (res)
+			if (res) {
+				if (bond_dev->flags & IFF_PROMISC)
+					dev_set_promiscuity(slave_dev, -1);
 				goto err_close;
+			}
 		}
=20
 		netif_addr_lock_bh(bond_dev);
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethe=
rnet/intel/e1000e/ich8lan.c
index 72b994e69c03..55895afcb8fb 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -746,7 +746,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e=
1000_hw *hw)
 	 * we have already determined whether we have link or not.
 	 */
 	if (!mac->autoneg) {
-		ret_val =3D -E1000_ERR_CONFIG;
+		ret_val =3D 1;
 		goto out;
 	}
=20
diff --git a/drivers/net/ethernet/intel/e1000e/lib.c b/drivers/net/ethernet=
/intel/e1000e/lib.c
index 8224a12cdad4..bfc80c30829f 100644
--- a/drivers/net/ethernet/intel/e1000e/lib.c
+++ b/drivers/net/ethernet/intel/e1000e/lib.c
@@ -478,10 +478,8 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 	 * If we are forcing speed/duplex, then we simply return since
 	 * we have already determined whether we have link or not.
 	 */
-	if (!mac->autoneg) {
-		ret_val =3D -E1000_ERR_CONFIG;
-		return ret_val;
-	}
+	if (!mac->autoneg)
+		return 1;
=20
 	/*
 	 * Auto-Neg is enabled.  Auto Speed Detection takes care
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c b/drivers/net/=
ethernet/mellanox/mlx4/en_ethtool.c
index 26d080a87cd8..11c51bc9792b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_ethtool.c
@@ -362,18 +362,29 @@ static int mlx4_en_set_pauseparam(struct net_device *=
dev,
 {
 	struct mlx4_en_priv *priv =3D netdev_priv(dev);
 	struct mlx4_en_dev *mdev =3D priv->mdev;
+	u8 tx_pause, tx_ppp, rx_pause, rx_ppp;
 	int err;
=20
-	priv->prof->tx_pause =3D pause->tx_pause !=3D 0;
-	priv->prof->rx_pause =3D pause->rx_pause !=3D 0;
+	if (pause->autoneg)
+		return -EINVAL;
+
+	tx_pause =3D !!(pause->tx_pause);
+	rx_pause =3D !!(pause->rx_pause);
+	rx_ppp =3D priv->prof->rx_ppp && !(tx_pause || rx_pause);
+	tx_ppp =3D priv->prof->tx_ppp && !(tx_pause || rx_pause);
+
 	err =3D mlx4_SET_PORT_general(mdev->dev, priv->port,
 				    priv->rx_skb_size + ETH_FCS_LEN,
-				    priv->prof->tx_pause,
-				    priv->prof->tx_ppp,
-				    priv->prof->rx_pause,
-				    priv->prof->rx_ppp);
-	if (err)
-		en_err(priv, "Failed setting pause params\n");
+				    tx_pause, tx_ppp, rx_pause, rx_ppp);
+	if (err) {
+		en_err(priv, "Failed setting pause params, err =3D %d\n", err);
+		return err;
+	}
+
+	priv->prof->tx_pause =3D tx_pause;
+	priv->prof->rx_pause =3D rx_pause;
+	priv->prof->tx_ppp =3D tx_ppp;
+	priv->prof->rx_ppp =3D rx_ppp;
=20
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx4/en_main.c b/drivers/net/eth=
ernet/mellanox/mlx4/en_main.c
index a06096fcc0b8..725ac1771ec9 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_main.c
@@ -112,9 +112,9 @@ static int mlx4_en_get_profile(struct mlx4_en_dev *mdev=
)
 		params->udp_rss =3D 0;
 	}
 	for (i =3D 1; i <=3D MLX4_MAX_PORTS; i++) {
-		params->prof[i].rx_pause =3D 1;
+		params->prof[i].rx_pause =3D !(pfcrx || pfctx);
 		params->prof[i].rx_ppp =3D pfcrx;
-		params->prof[i].tx_pause =3D 1;
+		params->prof[i].tx_pause =3D !(pfcrx || pfctx);
 		params->prof[i].tx_ppp =3D pfctx;
 		params->prof[i].tx_ring_size =3D MLX4_EN_DEF_TX_RING_SIZE;
 		params->prof[i].rx_ring_size =3D MLX4_EN_DEF_RX_RING_SIZE;
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 1a6e2eac2de6..d9ebe38b2bec 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -719,7 +719,7 @@ static void sl_sync(void)
=20
=20
 /* Find a free SLIP channel, and link in this `tty' line. */
-static struct slip *sl_alloc(dev_t line)
+static struct slip *sl_alloc(void)
 {
 	int i;
 	char name[IFNAMSIZ];
@@ -800,7 +800,7 @@ static int slip_open(struct tty_struct *tty)
=20
 	/* OK.  Find a free SLIP channel to use. */
 	err =3D -ENFILE;
-	sl =3D sl_alloc(tty_devnum(tty));
+	sl =3D sl_alloc();
 	if (sl =3D=3D NULL)
 		goto err_exit;
=20
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_main.c b/drivers/net/wi=
reless/ath/ath9k/htc_drv_main.c
index b6cd36c70823..f051e0cf808b 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_main.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_main.c
@@ -1640,6 +1640,10 @@ static int ath9k_htc_ampdu_action(struct ieee80211_h=
w *hw,
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
+		if (tid >=3D ATH9K_HTC_MAX_TID) {
+			ret =3D -EINVAL;
+			break;
+		}
 		ista =3D (struct ath9k_htc_sta *) sta->drv_priv;
 		spin_lock_bh(&priv->tx.tx_lock);
 		ista->tid_state[tid] =3D AGGR_OPERATIONAL;
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 4abc79d3963f..be1d5b5df3c8 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -578,6 +578,11 @@ struct qeth_cmd_buffer {
 	void (*callback) (struct qeth_channel *, struct qeth_cmd_buffer *);
 };
=20
+static inline struct qeth_ipa_cmd *__ipa_cmd(struct qeth_cmd_buffer *iob)
+{
+	return (struct qeth_ipa_cmd *)(iob->data + IPA_PDU_HEADER_SIZE);
+}
+
 /**
  * definition of a qeth channel, used for read and write
  */
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core=
_main.c
index 55f6488fc512..0c2f7a54ab42 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1932,7 +1932,7 @@ int qeth_send_control_data(struct qeth_card *card, in=
t len,
 	unsigned long flags;
 	struct qeth_reply *reply =3D NULL;
 	unsigned long timeout, event_timeout;
-	struct qeth_ipa_cmd *cmd;
+	struct qeth_ipa_cmd *cmd =3D NULL;
=20
 	QETH_CARD_TEXT(card, 2, "sendctl");
=20
@@ -1959,10 +1959,13 @@ int qeth_send_control_data(struct qeth_card *card, =
int len,
 	while (atomic_cmpxchg(&card->write.irq_pending, 0, 1)) ;
 	qeth_prepare_control_data(card, len, iob);
=20
-	if (IS_IPA(iob->data))
+	if (IS_IPA(iob->data)) {
+		cmd =3D __ipa_cmd(iob);
 		event_timeout =3D QETH_IPA_TIMEOUT;
-	else
+	} else {
 		event_timeout =3D QETH_TIMEOUT;
+	}
+
 	timeout =3D jiffies + event_timeout;
=20
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
@@ -1987,9 +1990,8 @@ int qeth_send_control_data(struct qeth_card *card, in=
t len,
=20
 	/* we have only one long running ipassist, since we can ensure
 	   process context of this command we can sleep */
-	cmd =3D (struct qeth_ipa_cmd *)(iob->data+IPA_PDU_HEADER_SIZE);
-	if ((cmd->hdr.command =3D=3D IPA_CMD_SETIP) &&
-	    (cmd->hdr.prot_version =3D=3D QETH_PROT_IPV4)) {
+	if (cmd && cmd->hdr.command =3D=3D IPA_CMD_SETIP &&
+	    cmd->hdr.prot_version =3D=3D QETH_PROT_IPV4) {
 		if (!wait_event_timeout(reply->wait_q,
 		    atomic_read(&reply->received), event_timeout))
 			goto time_err;
@@ -4576,8 +4578,6 @@ static void qeth_core_free_card(struct qeth_card *car=
d)
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 	qeth_clean_channel(&card->read);
 	qeth_clean_channel(&card->write);
-	if (card->dev)
-		free_netdev(card->dev);
 	kfree(card->ip_tbd_list);
 	qeth_free_qdio_buffers(card);
 	unregister_service_level(&card->qeth_service_level);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_mai=
n.c
index fc7565910a05..f4a620360600 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -897,8 +897,8 @@ static void qeth_l2_remove_device(struct ccwgroup_devic=
e *cgdev)
 		qeth_l2_set_offline(cgdev);
=20
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev =3D NULL;
 	}
 	return;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_mai=
n.c
index fa38a3647c41..a55748773707 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3395,8 +3395,8 @@ static void qeth_l3_remove_device(struct ccwgroup_dev=
ice *cgdev)
 		qeth_l3_set_offline(cgdev);
=20
 	if (card->dev) {
-		netif_napi_del(&card->napi);
 		unregister_netdev(card->dev);
+		free_netdev(card->dev);
 		card->dev =3D NULL;
 	}
=20
diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index 6ebfe8e76646..29ffc652929a 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -758,8 +758,16 @@ static void setinqstr(struct aac_dev *dev, void *data,=
 int tindex)
 	memset(str, ' ', sizeof(*str));
=20
 	if (dev->supplement_adapter_info.AdapterTypeText[0]) {
-		char * cp =3D dev->supplement_adapter_info.AdapterTypeText;
 		int c;
+		char *cp;
+		char *cname =3D kmemdup(dev->supplement_adapter_info.AdapterTypeText,
+				sizeof(dev->supplement_adapter_info.AdapterTypeText),
+								GFP_ATOMIC);
+
+		if (!cname)
+			return;
+
+		cp =3D cname;
 		if ((cp[0] =3D=3D 'A') && (cp[1] =3D=3D 'O') && (cp[2] =3D=3D 'C'))
 			inqstrcpy("SMC", str->vid);
 		else {
@@ -768,8 +776,7 @@ static void setinqstr(struct aac_dev *dev, void *data, =
int tindex)
 				++cp;
 			c =3D *cp;
 			*cp =3D '\0';
-			inqstrcpy (dev->supplement_adapter_info.AdapterTypeText,
-				   str->vid);
+			inqstrcpy(cname, str->vid);
 			*cp =3D c;
 			while (*cp && *cp !=3D ' ')
 				++cp;
@@ -777,14 +784,11 @@ static void setinqstr(struct aac_dev *dev, void *data=
, int tindex)
 		while (*cp =3D=3D ' ')
 			++cp;
 		/* last six chars reserved for vol type */
-		c =3D 0;
-		if (strlen(cp) > sizeof(str->pid)) {
-			c =3D cp[sizeof(str->pid)];
+		if (strlen(cp) > sizeof(str->pid))
 			cp[sizeof(str->pid)] =3D '\0';
-		}
 		inqstrcpy (cp, str->pid);
-		if (c)
-			cp[sizeof(str->pid)] =3D c;
+
+		kfree(cname);
 	} else {
 		struct aac_driver_ident *mp =3D aac_get_driver_ident(dev->cardtype);
=20
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index e85c40b6e19b..922e30b986b6 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2009,7 +2009,7 @@ static void fas216_rq_sns_done(FAS216_Info *info, str=
uct scsi_cmnd *SCpnt,
 		 * have valid data in the sense buffer that could
 		 * confuse the higher levels.
 		 */
-		memset(SCpnt->sense_buffer, 0, sizeof(SCpnt->sense_buffer));
+		memset(SCpnt->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
 //printk("scsi%d.%c: sense buffer: ", info->host->host_no, '0' + SCpnt->de=
vice->id);
 //{ int i; for (i =3D 0; i < 32; i++) printk("%02x ", SCpnt->sense_buffer[=
i]); printk("\n"); }
 	/*
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.=
h
index 834c37fc7ce9..b187a6f0886d 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -365,7 +365,7 @@ enum ibmvfc_fcp_rsp_info_codes {
 };
=20
 struct ibmvfc_fcp_rsp_info {
-	u16 reserved;
+	u8 reserved[3];
 	u8 rsp_code;
 	u8 reserved2[4];
 }__attribute__((packed, aligned (2)));
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_e=
xpander.c
index dbe3568b6a92..143569526ae6 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -557,7 +557,7 @@ int sas_smp_get_phy_events(struct sas_phy *phy)
 	res =3D smp_execute_task(dev, req, RPEL_REQ_SIZE,
 			            resp, RPEL_RESP_SIZE);
=20
-	if (!res)
+	if (res)
 		goto out;
=20
 	phy->invalid_dword_count =3D scsi_to_u32(&resp[12]);
@@ -566,6 +566,7 @@ int sas_smp_get_phy_events(struct sas_phy *phy)
 	phy->phy_reset_problem_count =3D scsi_to_u32(&resp[24]);
=20
  out:
+	kfree(req);
 	kfree(resp);
 	return res;
=20
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 304f58ee440d..8e3169652e04 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1809,6 +1809,12 @@ static ssize_t n_tty_read(struct tty_struct *tty, st=
ruct file *file,
 			}
 			if (tty_hung_up_p(file))
 				break;
+			/*
+			 * Abort readers for ttys which never actually
+			 * get hung up.  See __tty_hangup().
+			 */
+			if (test_bit(TTY_HUPPING, &tty->flags))
+				break;
 			if (!timeout)
 				break;
 			if (file->f_flags & O_NONBLOCK) {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 60f71ec60992..4b735250f10e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -668,6 +668,8 @@ static void sci_receive_chars(struct uart_port *port)
 		/* Tell the rest of the system the news. New characters! */
 		tty_flip_buffer_push(tty);
 	} else {
+		/* TTY buffers full; read from RX reg to prevent lockup */
+		sci_in(port, SCxRDR);
 		sci_in(port, SCxSR); /* dummy read */
 		sci_out(port, SCxSR, SCxSR_RDxF_CLEAR(port));
 	}
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 306f844db714..0dd569212f0d 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1676,7 +1676,7 @@ static void reset_terminal(struct vc_data *vc, int do=
_clear)
 	default_attr(vc);
 	update_attr(vc);
=20
-	vc->vc_tab_stop[0]	=3D 0x01010100;
+	vc->vc_tab_stop[0]	=3D
 	vc->vc_tab_stop[1]	=3D
 	vc->vc_tab_stop[2]	=3D
 	vc->vc_tab_stop[3]	=3D
@@ -1715,7 +1715,7 @@ static void do_con_trol(struct tty_struct *tty, struc=
t vc_data *vc, int c)
 		vc->vc_pos -=3D (vc->vc_x << 1);
 		while (vc->vc_x < vc->vc_cols - 1) {
 			vc->vc_x++;
-			if (vc->vc_tab_stop[vc->vc_x >> 5] & (1 << (vc->vc_x & 31)))
+			if (vc->vc_tab_stop[7 & (vc->vc_x >> 5)] & (1 << (vc->vc_x & 31)))
 				break;
 		}
 		vc->vc_pos +=3D (vc->vc_x << 1);
@@ -1775,7 +1775,7 @@ static void do_con_trol(struct tty_struct *tty, struc=
t vc_data *vc, int c)
 			lf(vc);
 			return;
 		case 'H':
-			vc->vc_tab_stop[vc->vc_x >> 5] |=3D (1 << (vc->vc_x & 31));
+			vc->vc_tab_stop[7 & (vc->vc_x >> 5)] |=3D (1 << (vc->vc_x & 31));
 			return;
 		case 'Z':
 			respond_ID(tty);
@@ -1968,7 +1968,7 @@ static void do_con_trol(struct tty_struct *tty, struc=
t vc_data *vc, int c)
 			return;
 		case 'g':
 			if (!vc->vc_par[0])
-				vc->vc_tab_stop[vc->vc_x >> 5] &=3D ~(1 << (vc->vc_x & 31));
+				vc->vc_tab_stop[7 & (vc->vc_x >> 5)] &=3D ~(1 << (vc->vc_x & 31));
 			else if (vc->vc_par[0] =3D=3D 3) {
 				vc->vc_tab_stop[0] =3D
 					vc->vc_tab_stop[1] =3D
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 95fb78bbdbce..6322c3e148a1 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -353,7 +353,7 @@ static int acm_submit_read_urb(struct acm *acm, int ind=
ex, gfp_t mem_flags)
=20
 	res =3D usb_submit_urb(acm->read_urbs[index], mem_flags);
 	if (res) {
-		if (res !=3D -EPERM) {
+		if (res !=3D -EPERM && res !=3D -ENODEV) {
 			dev_err(&acm->data->dev,
 					"%s - usb_submit_urb failed: %d\n",
 					__func__, res);
@@ -1530,6 +1530,9 @@ static const struct usb_device_id acm_ids[] =3D {
 	{ USB_DEVICE(0x0ace, 0x1611), /* ZyDAS 56K USB MODEM - new version */
 	.driver_info =3D SINGLE_RX_URB, /* firmware bug */
 	},
+	{ USB_DEVICE(0x11ca, 0x0201), /* VeriFone Mx870 Gadget Serial */
+	.driver_info =3D SINGLE_RX_URB,
+	},
 	{ USB_DEVICE(0x22b8, 0x7000), /* Motorola Q Phone */
 	.driver_info =3D NO_UNION_NORMAL, /* has no union descriptor */
 	},
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index ab11ca3c79a5..16fca16912c4 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -150,6 +150,10 @@ int usb_control_msg(struct usb_device *dev, unsigned i=
nt pipe, __u8 request,
=20
 	ret =3D usb_internal_control_msg(dev, pipe, dr, data, size, timeout);
=20
+	/* Linger a bit, prior to the next control message. */
+	if (dev->quirks & USB_QUIRK_DELAY_CTRL_MSG)
+		msleep(200);
+
 	kfree(dr);
=20
 	return ret;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 41d75c9a4324..215fdefc824a 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -206,8 +206,12 @@ static const struct usb_device_id usb_quirk_list[] =3D=
 {
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =3D
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
=20
+	/* Corsair K70 RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info =3D USB_QUIRK_DELAY_INIT },
+
 	/* Corsair Strafe RGB */
-	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info =3D USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info =3D USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
=20
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info =3D USB_QUIRK_DELAY_INIT },
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 33fe3d3bebbd..47b83584f284 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1821,6 +1821,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc=
3 *dwc)
 		break;
 	}
=20
+	dwc->eps[1]->endpoint.maxpacket =3D dwc->gadget.ep0->maxpacket;
+
 	/* Disable unneded PHY */
 	dwc3_gadget_disable_phy(dwc, dwc->gadget.speed);
=20
diff --git a/drivers/usb/host/ohci-q.c b/drivers/usb/host/ohci-q.c
index 6c43152d15a6..e81e0de005e6 100644
--- a/drivers/usb/host/ohci-q.c
+++ b/drivers/usb/host/ohci-q.c
@@ -908,10 +908,6 @@ finish_unlinks (struct ohci_hcd *ohci, u16 tick)
 		int			completed, modified;
 		__hc32			*prev;
=20
-		/* Is this ED already invisible to the hardware? */
-		if (ed->state =3D=3D ED_IDLE)
-			goto ed_idle;
-
 		/* only take off EDs that the HC isn't using, accounting for
 		 * frame counter wraps and EDs with partially retired TDs
 		 */
@@ -942,19 +938,19 @@ finish_unlinks (struct ohci_hcd *ohci, u16 tick)
 		}
=20
 		/* ED's now officially unlinked, hc doesn't see */
-		ed->state =3D ED_IDLE;
 		if (quirk_zfmicro(ohci) && ed->type =3D=3D PIPE_INTERRUPT)
 			ohci->eds_scheduled--;
 		ed->hwHeadP &=3D ~cpu_to_hc32(ohci, ED_H);
 		ed->hwNextED =3D 0;
 		wmb();
 		ed->hwINFO &=3D ~cpu_to_hc32(ohci, ED_SKIP | ED_DEQUEUE);
-ed_idle:
=20
 		/* reentrancy:  if we drop the schedule lock, someone might
 		 * have modified this list.  normally it's just prepending
 		 * entries (which we'd ignore), but paranoia won't hurt.
 		 */
+		*last =3D ed->ed_next;
+		ed->ed_next =3D NULL;
 		modified =3D 0;
=20
 		/* unlink urbs as requested, but rescan the list after
@@ -1013,19 +1009,21 @@ finish_unlinks (struct ohci_hcd *ohci, u16 tick)
 			goto rescan_this;
=20
 		/*
-		 * If no TDs are queued, take ED off the ed_rm_list.
+		 * If no TDs are queued, ED is now idle.
 		 * Otherwise, if the HC is running, reschedule.
-		 * If not, leave it on the list for further dequeues.
+		 * If the HC isn't running, add ED back to the
+		 * start of the list for later processing.
 		 */
 		if (list_empty(&ed->td_list)) {
-			*last =3D ed->ed_next;
-			ed->ed_next =3D NULL;
+			ed->state =3D ED_IDLE;
 		} else if (HC_IS_RUNNING(ohci_to_hcd(ohci)->state)) {
-			*last =3D ed->ed_next;
-			ed->ed_next =3D NULL;
 			ed_schedule(ohci, ed);
 		} else {
-			last =3D &ed->ed_next;
+			ed->ed_next =3D ohci->ed_rm_list;
+			ohci->ed_rm_list =3D ed;
+			/* Don't loop on the same ED */
+			if (last =3D=3D &ohci->ed_rm_list)
+				last =3D &ed->ed_next;
 		}
=20
 		if (modified)
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 39cd9320e4d9..636b5d963653 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -112,6 +112,9 @@ static void xhci_pci_quirks(struct device *dev, struct =
xhci_hcd *xhci)
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
 		xhci->quirks |=3D XHCI_AMD_PLL_FIX;
=20
+	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD && pdev->device =3D=3D 0x43bb)
+		xhci->quirks |=3D XHCI_SUSPEND_DELAY;
+
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_AMD)
 		xhci->quirks |=3D XHCI_TRUST_TX_LENGTH;
=20
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 547a03949dee..550f4e714f1f 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -936,6 +936,9 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 	del_timer_sync(&hcd->rh_timer);
=20
+	if (xhci->quirks & XHCI_SUSPEND_DELAY)
+		usleep_range(1000, 1500);
+
 	spin_lock_irq(&xhci->lock);
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &xhci->shared_hcd->flags);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7642c017bf5a..f3677ff707b7 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1503,6 +1503,7 @@ struct xhci_hcd {
 #define XHCI_PME_STUCK_QUIRK	(1 << 20)
 #define XHCI_MISSING_CAS	(1 << 24)
 #define XHCI_U2_DISABLE_WAKE	(1 << 27)
+#define XHCI_SUSPEND_DELAY	(1 << 30)
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
 	/* There are two roothubs to keep track of bus suspend info for */
diff --git a/drivers/usb/mon/mon_text.c b/drivers/usb/mon/mon_text.c
index ad408251d955..108dcc5f5350 100644
--- a/drivers/usb/mon/mon_text.c
+++ b/drivers/usb/mon/mon_text.c
@@ -82,6 +82,8 @@ struct mon_reader_text {
=20
 	wait_queue_head_t wait;
 	int printf_size;
+	size_t printf_offset;
+	size_t printf_togo;
 	char *printf_buf;
 	struct mutex printf_lock;
=20
@@ -373,73 +375,103 @@ static int mon_text_open(struct inode *inode, struct=
 file *file)
 	return rc;
 }
=20
-/*
- * For simplicity, we read one record in one system call and throw out
- * what does not fit. This means that the following does not work:
- *   dd if=3D/dbg/usbmon/0t bs=3D10
- * Also, we do not allow seeks and do not bother advancing the offset.
- */
+static ssize_t mon_text_copy_to_user(struct mon_reader_text *rp,
+    char __user * const buf, const size_t nbytes)
+{
+	const size_t togo =3D min(nbytes, rp->printf_togo);
+
+	if (copy_to_user(buf, &rp->printf_buf[rp->printf_offset], togo))
+		return -EFAULT;
+	rp->printf_togo -=3D togo;
+	rp->printf_offset +=3D togo;
+	return togo;
+}
+
+/* ppos is not advanced since the llseek operation is not permitted. */
 static ssize_t mon_text_read_t(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+    size_t nbytes, loff_t *ppos)
 {
 	struct mon_reader_text *rp =3D file->private_data;
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
+	ssize_t ret;
=20
-	if (IS_ERR(ep =3D mon_text_read_wait(rp, file)))
-		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
-	ptr.cnt =3D 0;
-	ptr.pbuf =3D rp->printf_buf;
-	ptr.limit =3D rp->printf_size;
-
-	mon_text_read_head_t(rp, &ptr, ep);
-	mon_text_read_statset(rp, &ptr, ep);
-	ptr.cnt +=3D snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
-	    " %d", ep->length);
-	mon_text_read_data(rp, &ptr, ep);
-
-	if (copy_to_user(buf, rp->printf_buf, ptr.cnt))
-		ptr.cnt =3D -EFAULT;
+
+	if (rp->printf_togo =3D=3D 0) {
+
+		ep =3D mon_text_read_wait(rp, file);
+		if (IS_ERR(ep)) {
+			mutex_unlock(&rp->printf_lock);
+			return PTR_ERR(ep);
+		}
+		ptr.cnt =3D 0;
+		ptr.pbuf =3D rp->printf_buf;
+		ptr.limit =3D rp->printf_size;
+
+		mon_text_read_head_t(rp, &ptr, ep);
+		mon_text_read_statset(rp, &ptr, ep);
+		ptr.cnt +=3D snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
+		    " %d", ep->length);
+		mon_text_read_data(rp, &ptr, ep);
+
+		rp->printf_togo =3D ptr.cnt;
+		rp->printf_offset =3D 0;
+
+		kmem_cache_free(rp->e_slab, ep);
+	}
+
+	ret =3D mon_text_copy_to_user(rp, buf, nbytes);
 	mutex_unlock(&rp->printf_lock);
-	kmem_cache_free(rp->e_slab, ep);
-	return ptr.cnt;
+	return ret;
 }
=20
+/* ppos is not advanced since the llseek operation is not permitted. */
 static ssize_t mon_text_read_u(struct file *file, char __user *buf,
-				size_t nbytes, loff_t *ppos)
+    size_t nbytes, loff_t *ppos)
 {
 	struct mon_reader_text *rp =3D file->private_data;
 	struct mon_event_text *ep;
 	struct mon_text_ptr ptr;
+	ssize_t ret;
=20
-	if (IS_ERR(ep =3D mon_text_read_wait(rp, file)))
-		return PTR_ERR(ep);
 	mutex_lock(&rp->printf_lock);
-	ptr.cnt =3D 0;
-	ptr.pbuf =3D rp->printf_buf;
-	ptr.limit =3D rp->printf_size;
=20
-	mon_text_read_head_u(rp, &ptr, ep);
-	if (ep->type =3D=3D 'E') {
-		mon_text_read_statset(rp, &ptr, ep);
-	} else if (ep->xfertype =3D=3D USB_ENDPOINT_XFER_ISOC) {
-		mon_text_read_isostat(rp, &ptr, ep);
-		mon_text_read_isodesc(rp, &ptr, ep);
-	} else if (ep->xfertype =3D=3D USB_ENDPOINT_XFER_INT) {
-		mon_text_read_intstat(rp, &ptr, ep);
-	} else {
-		mon_text_read_statset(rp, &ptr, ep);
+	if (rp->printf_togo =3D=3D 0) {
+
+		ep =3D mon_text_read_wait(rp, file);
+		if (IS_ERR(ep)) {
+			mutex_unlock(&rp->printf_lock);
+			return PTR_ERR(ep);
+		}
+		ptr.cnt =3D 0;
+		ptr.pbuf =3D rp->printf_buf;
+		ptr.limit =3D rp->printf_size;
+
+		mon_text_read_head_u(rp, &ptr, ep);
+		if (ep->type =3D=3D 'E') {
+			mon_text_read_statset(rp, &ptr, ep);
+		} else if (ep->xfertype =3D=3D USB_ENDPOINT_XFER_ISOC) {
+			mon_text_read_isostat(rp, &ptr, ep);
+			mon_text_read_isodesc(rp, &ptr, ep);
+		} else if (ep->xfertype =3D=3D USB_ENDPOINT_XFER_INT) {
+			mon_text_read_intstat(rp, &ptr, ep);
+		} else {
+			mon_text_read_statset(rp, &ptr, ep);
+		}
+		ptr.cnt +=3D snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
+		    " %d", ep->length);
+		mon_text_read_data(rp, &ptr, ep);
+
+		rp->printf_togo =3D ptr.cnt;
+		rp->printf_offset =3D 0;
+
+		kmem_cache_free(rp->e_slab, ep);
 	}
-	ptr.cnt +=3D snprintf(ptr.pbuf + ptr.cnt, ptr.limit - ptr.cnt,
-	    " %d", ep->length);
-	mon_text_read_data(rp, &ptr, ep);
=20
-	if (copy_to_user(buf, rp->printf_buf, ptr.cnt))
-		ptr.cnt =3D -EFAULT;
+	ret =3D mon_text_copy_to_user(rp, buf, nbytes);
 	mutex_unlock(&rp->printf_lock);
-	kmem_cache_free(rp->e_slab, ep);
-	return ptr.cnt;
+	return ret;
 }
=20
 static struct mon_event_text *mon_text_read_wait(struct mon_reader_text *r=
p,
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgep=
ort.c
index d4109f221e1e..eb70184d0b36 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -2387,7 +2387,6 @@ static int write_cmd_usb(struct edgeport_port *edge_p=
ort,
 		dev_err(&edge_port->port->dev,
 		    "%s - usb_submit_urb(write command) failed, status =3D %d\n",
 							__func__, status);
-		usb_kill_urb(urb);
 		usb_free_urb(urb);
 		atomic_dec(&CmdUrbs);
 		return status;
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 5910dacee8cc..1d5379ece937 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -45,6 +45,7 @@ static const struct usb_device_id id_table[] =3D {
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_RSAQ2) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_DCU11) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_RSAQ3) },
+	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_CHILITAG) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_PHAROS) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_ALDIGA) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_MMX) },
diff --git a/drivers/usb/serial/pl2303.h b/drivers/usb/serial/pl2303.h
index 09d9be88209e..f379e00920bd 100644
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -17,6 +17,7 @@
 #define PL2303_PRODUCT_ID_DCU11		0x1234
 #define PL2303_PRODUCT_ID_PHAROS	0xaaa0
 #define PL2303_PRODUCT_ID_RSAQ3		0xaaa2
+#define PL2303_PRODUCT_ID_CHILITAG	0xaaa8
 #define PL2303_PRODUCT_ID_ALDIGA	0x0611
 #define PL2303_PRODUCT_ID_MMX		0x0612
 #define PL2303_PRODUCT_ID_GPRS		0x0609
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummy=
con.c
index b63860f7beab..821b598f4a43 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -71,7 +71,6 @@ const struct consw dummy_con =3D {
     .con_switch =3D	DUMMY,
     .con_blank =3D	DUMMY,
     .con_font_set =3D	DUMMY,
-    .con_font_get =3D	DUMMY,
     .con_font_default =3D	DUMMY,
     .con_font_copy =3D	DUMMY,
     .con_set_palette =3D	DUMMY,
diff --git a/drivers/video/sbuslib.c b/drivers/video/sbuslib.c
index 37d764ad56b0..51c0df134098 100644
--- a/drivers/video/sbuslib.c
+++ b/drivers/video/sbuslib.c
@@ -122,7 +122,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned lon=
g arg,
 		unsigned char __user *ured;
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
-		int index, count, i;
+		unsigned int index, count, i;
=20
 		if (get_user(index, &c->index) ||
 		    __get_user(count, &c->count) ||
@@ -161,7 +161,7 @@ int sbusfb_ioctl_helper(unsigned long cmd, unsigned lon=
g arg,
 		unsigned char __user *ugreen;
 		unsigned char __user *ublue;
 		struct fb_cmap *cmap =3D &info->cmap;
-		int index, count, i;
+		unsigned int index, count, i;
 		u8 red, green, blue;
=20
 		if (get_user(index, &c->index) ||
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 6479b853c09a..998a9cbb7f3e 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2216,12 +2216,13 @@ static void free_log_tree(struct btrfs_trans_handle=
 *trans,
=20
 	while (1) {
 		ret =3D find_first_extent_bit(&log->dirty_log_pages,
-				0, &start, &end, EXTENT_DIRTY | EXTENT_NEW);
+				0, &start, &end,
+				EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT);
 		if (ret)
 			break;
=20
 		clear_extent_bits(&log->dirty_log_pages, start, end,
-				  EXTENT_DIRTY | EXTENT_NEW, GFP_NOFS);
+				  EXTENT_DIRTY | EXTENT_NEW | EXTENT_NEED_WAIT, GFP_NOFS);
 	}
=20
 	free_extent_buffer(log->node);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index f9d28635a702..a491aefc9b60 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2530,20 +2530,18 @@ static struct vm_operations_struct cifs_file_vm_ops=
 =3D {
=20
 int cifs_file_strict_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	int rc, xid;
+	int xid, rc =3D 0;
 	struct inode *inode =3D file->f_path.dentry->d_inode;
=20
 	xid =3D GetXid();
=20
-	if (!CIFS_I(inode)->clientCanCacheRead) {
+	if (!CIFS_I(inode)->clientCanCacheRead)
 		rc =3D cifs_invalidate_mapping(inode);
-		if (rc)
-			return rc;
-	}
-
-	rc =3D generic_file_mmap(file, vma);
-	if (rc =3D=3D 0)
+	if (!rc)
+		rc =3D generic_file_mmap(file, vma);
+	if (!rc)
 		vma->vm_ops =3D &cifs_file_vm_ops;
+
 	FreeXid(xid);
 	return rc;
 }
@@ -2553,15 +2551,15 @@ int cifs_file_mmap(struct file *file, struct vm_are=
a_struct *vma)
 	int rc, xid;
=20
 	xid =3D GetXid();
+
 	rc =3D cifs_revalidate_file(file);
-	if (rc) {
+	if (rc)
 		cFYI(1, "Validation prior to mmap failed, error=3D%d", rc);
-		FreeXid(xid);
-		return rc;
-	}
-	rc =3D generic_file_mmap(file, vma);
-	if (rc =3D=3D 0)
+	if (!rc)
+		rc =3D generic_file_mmap(file, vma);
+	if (!rc)
 		vma->vm_ops =3D &cifs_file_vm_ops;
+
 	FreeXid(xid);
 	return rc;
 }
diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 2845a1f4f2e7..91d325c9b912 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -278,8 +278,10 @@ static int ext4_valid_block_bitmap(struct super_block =
*sb,
 					unsigned int block_group,
 					struct buffer_head *bh)
 {
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	ext4_grpblk_t offset;
 	ext4_grpblk_t next_zero_bit;
+	ext4_grpblk_t max_bit =3D EXT4_CLUSTERS_PER_GROUP(sb);
 	ext4_fsblk_t bitmap_blk;
 	ext4_fsblk_t group_first_block;
=20
@@ -297,24 +299,30 @@ static int ext4_valid_block_bitmap(struct super_block=
 *sb,
 	/* check whether block bitmap block number is set */
 	bitmap_blk =3D ext4_block_bitmap(sb, desc);
 	offset =3D bitmap_blk - group_first_block;
-	if (!ext4_test_bit(offset, bh->b_data))
+	if (offset < 0 || EXT4_B2C(sbi, offset) >=3D max_bit ||
+	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
=20
 	/* check whether the inode bitmap block number is set */
 	bitmap_blk =3D ext4_inode_bitmap(sb, desc);
 	offset =3D bitmap_blk - group_first_block;
-	if (!ext4_test_bit(offset, bh->b_data))
+	if (offset < 0 || EXT4_B2C(sbi, offset) >=3D max_bit ||
+	    !ext4_test_bit(EXT4_B2C(sbi, offset), bh->b_data))
 		/* bad block bitmap */
 		goto err_out;
=20
 	/* check whether the inode table block number is set */
 	bitmap_blk =3D ext4_inode_table(sb, desc);
 	offset =3D bitmap_blk - group_first_block;
+	if (offset < 0 || EXT4_B2C(sbi, offset) >=3D max_bit ||
+	    EXT4_B2C(sbi, offset + sbi->s_itb_per_group) >=3D max_bit)
+		goto err_out;
 	next_zero_bit =3D ext4_find_next_zero_bit(bh->b_data,
-				offset + EXT4_SB(sb)->s_itb_per_group,
-				offset);
-	if (next_zero_bit >=3D offset + EXT4_SB(sb)->s_itb_per_group)
+			EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group),
+			EXT4_B2C(sbi, offset));
+	if (next_zero_bit >=3D
+	    EXT4_B2C(sbi, offset + EXT4_SB(sb)->s_itb_per_group))
 		/* good bitmap for inode tables */
 		return 1;
=20
@@ -337,6 +345,7 @@ struct buffer_head *
 ext4_read_block_bitmap(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	struct buffer_head *bh =3D NULL;
 	ext4_fsblk_t bitmap_blk;
=20
@@ -344,6 +353,12 @@ ext4_read_block_bitmap(struct super_block *sb, ext4_gr=
oup_t block_group)
 	if (!desc)
 		return NULL;
 	bitmap_blk =3D ext4_block_bitmap(sb, desc);
+	if ((bitmap_blk <=3D le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >=3D ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid block bitmap block %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return NULL;
+	}
 	bh =3D sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot read block bitmap - "
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 476caae17161..9603b79a9224 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -102,6 +102,7 @@ static struct buffer_head *
 ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 {
 	struct ext4_group_desc *desc;
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	struct buffer_head *bh =3D NULL;
 	ext4_fsblk_t bitmap_blk;
=20
@@ -110,6 +111,12 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_gr=
oup_t block_group)
 		return NULL;
=20
 	bitmap_blk =3D ext4_inode_bitmap(sb, desc);
+	if ((bitmap_blk <=3D le32_to_cpu(sbi->s_es->s_first_data_block)) ||
+	    (bitmap_blk >=3D ext4_blocks_count(sbi->s_es))) {
+		ext4_error(sb, "Invalid inode bitmap blk %llu in "
+			   "block_group %u", bitmap_blk, block_group);
+		return NULL;
+	}
 	bh =3D sb_getblk(sb, bitmap_blk);
 	if (unlikely(!bh)) {
 		ext4_error(sb, "Cannot read inode bitmap - "
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fde77a79d814..af268ba1c998 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3902,6 +3902,13 @@ struct inode *ext4_iget(struct super_block *sb, unsi=
gned long ino)
 	if (ret < 0)
 		goto bad_inode;
 	raw_inode =3D ext4_raw_inode(&iloc);
+
+	if ((ino =3D=3D EXT4_ROOT_INO) && (raw_inode->i_links_count =3D=3D 0)) {
+		EXT4_ERROR_INODE(inode, "root inode unallocated");
+		ret =3D -EIO;
+		goto bad_inode;
+	}
+
 	inode->i_mode =3D le16_to_cpu(raw_inode->i_mode);
 	inode->i_uid =3D (uid_t)le16_to_cpu(raw_inode->i_uid_low);
 	inode->i_gid =3D (gid_t)le16_to_cpu(raw_inode->i_gid_low);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index afd4a2dfa814..1afb99df2686 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -700,6 +700,7 @@ __acquires(bitlock)
 	}
=20
 	ext4_unlock_group(sb, grp);
+	ext4_commit_super(sb, 1);
 	ext4_handle_error(sb);
 	/*
 	 * We only get here in the ERRORS_RO case; relocking the group
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 99c51d6cb925..906bcbd385e8 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -76,6 +76,16 @@ static void huge_pagevec_release(struct pagevec *pvec)
 	pagevec_reinit(pvec);
 }
=20
+/*
+ * Mask used when checking the page offset value passed in via system
+ * calls.  This value will be converted to a loff_t which is signed.
+ * Therefore, we want to check the upper PAGE_SHIFT + 1 bits of the
+ * value.  The extra bit (- 1 in the shift value) is to take the sign
+ * bit into account.
+ */
+#define PGOFF_LOFFT_MAX \
+	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
+
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *v=
ma)
 {
 	struct inode *inode =3D file->f_path.dentry->d_inode;
@@ -94,17 +104,27 @@ static int hugetlbfs_file_mmap(struct file *file, stru=
ct vm_area_struct *vma)
 	vma->vm_flags |=3D VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops =3D &hugetlb_vm_ops;
=20
+	/*
+	 * page based offset in vm_pgoff could be sufficiently large to
+	 * overflow a (l)off_t when converted to byte offset.
+	 */
+	if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
+		return -EINVAL;
+
+	/* must be huge page aligned */
 	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
=20
 	vma_len =3D (loff_t)(vma->vm_end - vma->vm_start);
+	len =3D vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+	/* check for overflow */
+	if (len < vma_len)
+		return -EINVAL;
=20
 	mutex_lock(&inode->i_mutex);
 	file_accessed(file);
=20
 	ret =3D -ENOMEM;
-	len =3D vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
-
 	if (hugetlb_reserve_pages(inode,
 				vma->vm_pgoff >> huge_page_order(h),
 				len >> huge_page_shift(h), vma,
@@ -114,7 +134,7 @@ static int hugetlbfs_file_mmap(struct file *file, struc=
t vm_area_struct *vma)
 	ret =3D 0;
 	hugetlb_prefault_arch_hook(vma->vm_mm);
 	if (vma->vm_flags & VM_WRITE && inode->i_size < len)
-		inode->i_size =3D len;
+		i_size_write(inode, len);
 out:
 	mutex_unlock(&inode->i_mutex);
=20
diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 73652b2093b4..05f4ae6d4f03 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -352,7 +352,6 @@ struct inode *jffs2_iget(struct super_block *sb, unsign=
ed long ino)
 	ret =3D -EIO;
 error:
 	mutex_unlock(&f->sem);
-	jffs2_do_clear_inode(c, f);
 	iget_failed(inode);
 	return ERR_PTR(ret);
 }
diff --git a/fs/namei.c b/fs/namei.c
index 2c226559c637..466d6eee6ffa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -408,9 +408,10 @@ EXPORT_SYMBOL(path_put);
 static bool path_connected(const struct path *path)
 {
 	struct vfsmount *mnt =3D path->mnt;
+	struct super_block *sb =3D mnt->mnt_sb;
=20
-	/* Only bind mounts can have disconnected paths */
-	if (mnt->mnt_root =3D=3D mnt->mnt_sb->s_root)
+	/* Bind mounts and multi-root filesystems can have disconnected paths */
+	if (!(sb->s_iflags & SB_I_MULTIROOT) && (mnt->mnt_root =3D=3D sb->s_root)=
)
 		return true;
=20
 	return is_subdir(path->dentry, mnt->mnt_root);
diff --git a/fs/ncpfs/ncplib_kernel.c b/fs/ncpfs/ncplib_kernel.c
index 981a95617fc9..76c6a8e3e830 100644
--- a/fs/ncpfs/ncplib_kernel.c
+++ b/fs/ncpfs/ncplib_kernel.c
@@ -982,6 +982,10 @@ ncp_read_kernel(struct ncp_server *server, const char =
*file_id,
 		goto out;
 	}
 	*bytes_read =3D ncp_reply_be16(server, 0);
+	if (*bytes_read > to_read) {
+		result =3D -EINVAL;
+		goto out;
+	}
 	source =3D ncp_reply_data(server, 2 + (offset & 1));
=20
 	memcpy(target, source, *bytes_read);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 19438987bbe4..ba41561e682c 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2288,6 +2288,8 @@ static struct dentry *nfs_fs_mount(struct file_system=
_type *fs_type,
 		/* initial superblock/root creation */
 		nfs_fill_super(s, data);
 		nfs_fscache_get_super_cookie(s, data->fscache_uniq, NULL);
+		if (!(server->flags & NFS_MOUNT_UNSHARED))
+			s->s_iflags |=3D SB_I_MULTIROOT;
 	}
=20
 	mntroot =3D nfs_get_root(s, mntfh, dev_name);
diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.=
c
index bb240647ca5f..c76302a51aed 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -41,6 +41,9 @@ char *o2nm_fence_method_desc[O2NM_FENCE_METHODS] =3D {
 		"panic",	/* O2NM_FENCE_PANIC */
 };
=20
+static inline void o2nm_lock_subsystem(void);
+static inline void o2nm_unlock_subsystem(void);
+
 struct o2nm_node *o2nm_get_node_by_num(u8 node_num)
 {
 	struct o2nm_node *node =3D NULL;
@@ -182,7 +185,10 @@ static struct o2nm_cluster *to_o2nm_cluster_from_node(=
struct o2nm_node *node)
 {
 	/* through the first node_set .parent
 	 * mycluster/nodes/mynode =3D=3D o2nm_cluster->o2nm_node_group->o2nm_node=
 */
-	return to_o2nm_cluster(node->nd_item.ci_parent->ci_parent);
+	if (node->nd_item.ci_parent)
+		return to_o2nm_cluster(node->nd_item.ci_parent->ci_parent);
+	else
+		return NULL;
 }
=20
 enum {
@@ -195,7 +201,7 @@ enum {
 static ssize_t o2nm_node_num_write(struct o2nm_node *node, const char *pag=
e,
 				   size_t count)
 {
-	struct o2nm_cluster *cluster =3D to_o2nm_cluster_from_node(node);
+	struct o2nm_cluster *cluster;
 	unsigned long tmp;
 	char *p =3D (char *)page;
=20
@@ -214,6 +220,13 @@ static ssize_t o2nm_node_num_write(struct o2nm_node *n=
ode, const char *page,
 	    !test_bit(O2NM_NODE_ATTR_PORT, &node->nd_set_attributes))
 		return -EINVAL; /* XXX */
=20
+	o2nm_lock_subsystem();
+	cluster =3D to_o2nm_cluster_from_node(node);
+	if (!cluster) {
+		o2nm_unlock_subsystem();
+		return -EINVAL;
+	}
+
 	write_lock(&cluster->cl_nodes_lock);
 	if (cluster->cl_nodes[tmp])
 		p =3D NULL;
@@ -223,6 +236,8 @@ static ssize_t o2nm_node_num_write(struct o2nm_node *no=
de, const char *page,
 		set_bit(tmp, cluster->cl_nodes_bitmap);
 	}
 	write_unlock(&cluster->cl_nodes_lock);
+	o2nm_unlock_subsystem();
+
 	if (p =3D=3D NULL)
 		return -EEXIST;
=20
@@ -262,7 +277,7 @@ static ssize_t o2nm_node_ipv4_address_write(struct o2nm=
_node *node,
 					    const char *page,
 					    size_t count)
 {
-	struct o2nm_cluster *cluster =3D to_o2nm_cluster_from_node(node);
+	struct o2nm_cluster *cluster;
 	int ret, i;
 	struct rb_node **p, *parent;
 	unsigned int octets[4];
@@ -279,6 +294,13 @@ static ssize_t o2nm_node_ipv4_address_write(struct o2n=
m_node *node,
 		be32_add_cpu(&ipv4_addr, octets[i] << (i * 8));
 	}
=20
+	o2nm_lock_subsystem();
+	cluster =3D to_o2nm_cluster_from_node(node);
+	if (!cluster) {
+		o2nm_unlock_subsystem();
+		return -EINVAL;
+	}
+
 	ret =3D 0;
 	write_lock(&cluster->cl_nodes_lock);
 	if (o2nm_node_ip_tree_lookup(cluster, ipv4_addr, &p, &parent))
@@ -288,6 +310,8 @@ static ssize_t o2nm_node_ipv4_address_write(struct o2nm=
_node *node,
 		rb_insert_color(&node->nd_ip_node, &cluster->cl_node_ip_tree);
 	}
 	write_unlock(&cluster->cl_nodes_lock);
+	o2nm_unlock_subsystem();
+
 	if (ret)
 		return ret;
=20
@@ -304,7 +328,7 @@ static ssize_t o2nm_node_local_read(struct o2nm_node *n=
ode, char *page)
 static ssize_t o2nm_node_local_write(struct o2nm_node *node, const char *p=
age,
 				     size_t count)
 {
-	struct o2nm_cluster *cluster =3D to_o2nm_cluster_from_node(node);
+	struct o2nm_cluster *cluster;
 	unsigned long tmp;
 	char *p =3D (char *)page;
 	ssize_t ret;
@@ -322,17 +346,26 @@ static ssize_t o2nm_node_local_write(struct o2nm_node=
 *node, const char *page,
 	    !test_bit(O2NM_NODE_ATTR_PORT, &node->nd_set_attributes))
 		return -EINVAL; /* XXX */
=20
+	o2nm_lock_subsystem();
+	cluster =3D to_o2nm_cluster_from_node(node);
+	if (!cluster) {
+		ret =3D -EINVAL;
+		goto out;
+	}
+
 	/* the only failure case is trying to set a new local node
 	 * when a different one is already set */
 	if (tmp && tmp =3D=3D cluster->cl_has_local &&
-	    cluster->cl_local_node !=3D node->nd_num)
-		return -EBUSY;
+	    cluster->cl_local_node !=3D node->nd_num) {
+		ret =3D -EBUSY;
+		goto out;
+	}
=20
 	/* bring up the rx thread if we're setting the new local node. */
 	if (tmp && !cluster->cl_has_local) {
 		ret =3D o2net_start_listening(node);
 		if (ret)
-			return ret;
+			goto out;
 	}
=20
 	if (!tmp && cluster->cl_has_local &&
@@ -347,7 +380,11 @@ static ssize_t o2nm_node_local_write(struct o2nm_node =
*node, const char *page,
 		cluster->cl_local_node =3D node->nd_num;
 	}
=20
-	return count;
+	ret =3D count;
+
+out:
+	o2nm_unlock_subsystem();
+	return ret;
 }
=20
 struct o2nm_node_attribute {
@@ -890,6 +927,16 @@ static struct o2nm_cluster_group o2nm_cluster_group =
=3D {
 	},
 };
=20
+static inline void o2nm_lock_subsystem(void)
+{
+	mutex_lock(&o2nm_cluster_group.cs_subsys.su_mutex);
+}
+
+static inline void o2nm_unlock_subsystem(void)
+{
+	mutex_unlock(&o2nm_cluster_group.cs_subsys.su_mutex);
+}
+
 int o2nm_depend_item(struct config_item *item)
 {
 	return configfs_depend_item(&o2nm_cluster_group.cs_subsys, item);
diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index c8c79878c082..9fa0f77632a0 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -94,7 +94,6 @@ struct crypto_ahash {
 		      unsigned int keylen);
=20
 	unsigned int reqsize;
-	bool has_setkey;
 	struct crypto_tfm base;
 };
=20
@@ -182,11 +181,6 @@ static inline void *ahash_request_ctx(struct ahash_req=
uest *req)
=20
 int crypto_ahash_setkey(struct crypto_ahash *tfm, const u8 *key,
 			unsigned int keylen);
-static inline bool crypto_ahash_has_setkey(struct crypto_ahash *tfm)
-{
-	return tfm->has_setkey;
-}
-
 int crypto_ahash_finup(struct ahash_request *req);
 int crypto_ahash_final(struct ahash_request *req);
 int crypto_ahash_digest(struct ahash_request *req);
@@ -198,12 +192,22 @@ static inline int crypto_ahash_export(struct ahash_re=
quest *req, void *out)
=20
 static inline int crypto_ahash_import(struct ahash_request *req, const voi=
d *in)
 {
-	return crypto_ahash_reqtfm(req)->import(req, in);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return tfm->import(req, in);
 }
=20
 static inline int crypto_ahash_init(struct ahash_request *req)
 {
-	return crypto_ahash_reqtfm(req)->init(req);
+	struct crypto_ahash *tfm =3D crypto_ahash_reqtfm(req);
+
+	if (crypto_ahash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return tfm->init(req);
 }
=20
 static inline int crypto_ahash_update(struct ahash_request *req)
@@ -342,12 +346,22 @@ static inline int crypto_shash_export(struct shash_de=
sc *desc, void *out)
=20
 static inline int crypto_shash_import(struct shash_desc *desc, const void =
*in)
 {
-	return crypto_shash_alg(desc->tfm)->import(desc, in);
+	struct crypto_shash *tfm =3D desc->tfm;
+
+	if (crypto_shash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return crypto_shash_alg(tfm)->import(desc, in);
 }
=20
 static inline int crypto_shash_init(struct shash_desc *desc)
 {
-	return crypto_shash_alg(desc->tfm)->init(desc);
+	struct crypto_shash *tfm =3D desc->tfm;
+
+	if (crypto_shash_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -ENOKEY;
+
+	return crypto_shash_alg(tfm)->init(desc);
 }
=20
 int crypto_shash_update(struct shash_desc *desc, const u8 *data,
diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.=
h
index b813ae921506..df48747c54a3 100644
--- a/include/crypto/internal/hash.h
+++ b/include/crypto/internal/hash.h
@@ -78,6 +78,8 @@ static inline bool crypto_shash_alg_has_setkey(struct sha=
sh_alg *alg)
 	return alg->setkey !=3D shash_no_setkey;
 }
=20
+bool crypto_hash_alg_has_setkey(struct hash_alg_common *halg);
+
 int crypto_init_ahash_spawn(struct crypto_ahash_spawn *spawn,
 			    struct hash_alg_common *alg,
 			    struct crypto_instance *inst);
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 6f501deccf41..5c511ba76131 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -88,9 +88,17 @@
  */
 #define CRYPTO_ALG_INSTANCE		0x00000800
=20
+/*
+ * Set if the algorithm has a ->setkey() method but can be used without
+ * calling it first, i.e. there is a default key.
+ */
+#define CRYPTO_ALG_OPTIONAL_KEY		0x00004000
+
 /*
  * Transform masks and values (for crt_flags).
  */
+#define CRYPTO_TFM_NEED_KEY		0x00000001
+
 #define CRYPTO_TFM_REQ_MASK		0x000fff00
 #define CRYPTO_TFM_RES_MASK		0xfff00000
=20
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8c63ec58b015..7e9ab8f5cb76 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1416,6 +1416,9 @@ extern int send_sigurg(struct fown_struct *fown);
 #define UMOUNT_NOFOLLOW	0x00000008	/* Don't follow symlink on umount */
 #define UMOUNT_UNUSED	0x80000000	/* Flag guaranteed to be unused */
=20
+/* sb->s_iflags */
+#define SB_I_MULTIROOT	0x00000008	/* Multiple roots to the dentry tree */
+
 extern struct list_head super_blocks;
 extern spinlock_t sb_lock;
=20
@@ -1432,6 +1435,7 @@ struct super_block {
 	const struct quotactl_ops	*s_qcop;
 	const struct export_operations *s_export_op;
 	unsigned long		s_flags;
+	unsigned long		s_iflags;	/* internal SB_I_* flags */
 	unsigned long		s_magic;
 	struct dentry		*s_root;
 	struct rw_semaphore	s_umount;
diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index 4232e73f0b11..6f065898f8fb 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -53,7 +53,6 @@ static inline unsigned long array_index_mask_nospec(unsig=
ned long index,
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
 									\
-	_i &=3D _mask;							\
-	_i;								\
+	(typeof(_i)) (_i & _mask);					\
 })
 #endif /* _LINUX_NOSPEC_H */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0aa2c4f528af..bee2357fd2d3 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1140,6 +1140,7 @@ extern int perf_swevent_get_recursion_context(void);
 extern void perf_swevent_put_recursion_context(int rctx);
 extern void perf_event_enable(struct perf_event *event);
 extern void perf_event_disable(struct perf_event *event);
+extern int __perf_event_disable(void *info);
 extern void perf_event_task_tick(void);
 #else
 static inline void
@@ -1178,6 +1179,7 @@ static inline int  perf_swevent_get_recursion_context=
(void)		{ return -1; }
 static inline void perf_swevent_put_recursion_context(int rctx)		{ }
 static inline void perf_event_enable(struct perf_event *event)		{ }
 static inline void perf_event_disable(struct perf_event *event)		{ }
+static inline int __perf_event_disable(void *info)			{ return -1; }
 static inline void perf_event_task_tick(void)				{ }
 #endif
=20
diff --git a/include/linux/usb/audio.h b/include/linux/usb/audio.h
index 6f8b026b3396..4ca049ba0fe7 100644
--- a/include/linux/usb/audio.h
+++ b/include/linux/usb/audio.h
@@ -369,7 +369,7 @@ static inline __u8 uac_processing_unit_bControlSize(str=
uct uac_processing_unit_d
 {
 	return (protocol =3D=3D UAC_VERSION_1) ?
 		desc->baSourceID[desc->bNrInPins + 4] :
-		desc->baSourceID[desc->bNrInPins + 6];
+		2; /* in UAC2, this value is constant */
 }
=20
 static inline __u8 *uac_processing_unit_bmControls(struct uac_processing_u=
nit_descriptor *desc,
@@ -377,7 +377,7 @@ static inline __u8 *uac_processing_unit_bmControls(stru=
ct uac_processing_unit_de
 {
 	return (protocol =3D=3D UAC_VERSION_1) ?
 		&desc->baSourceID[desc->bNrInPins + 5] :
-		&desc->baSourceID[desc->bNrInPins + 7];
+		&desc->baSourceID[desc->bNrInPins + 6];
 }
=20
 static inline __u8 uac_processing_unit_iProcessing(struct uac_processing_u=
nit_descriptor *desc,
diff --git a/include/linux/usb/quirks.h b/include/linux/usb/quirks.h
index 15c99b727a5b..abada7844a5e 100644
--- a/include/linux/usb/quirks.h
+++ b/include/linux/usb/quirks.h
@@ -50,4 +50,7 @@
  */
 #define USB_QUIRK_LINEAR_FRAME_INTR_BINTERVAL	BIT(11)
=20
+/* Device needs a pause after every control message. */
+#define USB_QUIRK_DELAY_CTRL_MSG		BIT(13)
+
 #endif /* __LINUX_USB_QUIRKS_H */
diff --git a/include/net/regulatory.h b/include/net/regulatory.h
index c3c22e0ff416..068fc6508de9 100644
--- a/include/net/regulatory.h
+++ b/include/net/regulatory.h
@@ -66,7 +66,7 @@ enum environment_cap {
 struct regulatory_request {
 	int wiphy_idx;
 	enum nl80211_reg_initiator initiator;
-	char alpha2[2];
+	char alpha2[3];
 	bool intersect;
 	bool processed;
 	enum environment_cap country_ie_env;
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 343929bed649..b2fd7af3ef07 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -704,11 +704,14 @@ static inline void sctp_v6_map_v4(union sctp_addr *ad=
dr)
 /* Map v4 address to v4-mapped v6 address */
 static inline void sctp_v4_map_v6(union sctp_addr *addr)
 {
+	__be16 port;
+
+	port =3D addr->v4.sin_port;
+	addr->v6.sin6_addr.s6_addr32[3] =3D addr->v4.sin_addr.s_addr;
+	addr->v6.sin6_port =3D port;
 	addr->v6.sin6_family =3D AF_INET6;
 	addr->v6.sin6_flowinfo =3D 0;
 	addr->v6.sin6_scope_id =3D 0;
-	addr->v6.sin6_port =3D addr->v4.sin_port;
-	addr->v6.sin6_addr.s6_addr32[3] =3D addr->v4.sin_addr.s_addr;
 	addr->v6.sin6_addr.s6_addr32[0] =3D 0;
 	addr->v6.sin6_addr.s6_addr32[1] =3D 0;
 	addr->v6.sin6_addr.s6_addr32[2] =3D htonl(0x0000ffff);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 103b563f6540..beeac8ebdf63 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1344,7 +1344,7 @@ static void perf_remove_from_context(struct perf_even=
t *event, bool detach_group
 /*
  * Cross CPU call to disable a performance event
  */
-static int __perf_event_disable(void *info)
+int __perf_event_disable(void *info)
 {
 	struct perf_event *event =3D info;
 	struct perf_event_context *ctx =3D event->ctx;
diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 98ac24e30da7..eeb84bbc45f9 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -443,42 +443,35 @@ EXPORT_SYMBOL_GPL(register_user_hw_breakpoint);
  * modify_user_hw_breakpoint - modify a user-space hardware breakpoint
  * @bp: the breakpoint structure to modify
  * @attr: new breakpoint attributes
- * @triggered: callback to trigger when we hit the breakpoint
- * @tsk: pointer to 'task_struct' of the process to which the address belo=
ngs
  */
 int modify_user_hw_breakpoint(struct perf_event *bp, struct perf_event_att=
r *attr)
 {
-	u64 old_addr =3D bp->attr.bp_addr;
-	u64 old_len =3D bp->attr.bp_len;
-	int old_type =3D bp->attr.bp_type;
-	int err =3D 0;
-
-	perf_event_disable(bp);
+	/*
+	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence =
it
+	 * will not be possible to raise IPIs that invoke __perf_event_disable.
+	 * So call the function directly after making sure we are targeting the
+	 * current task.
+	 */
+	if (irqs_disabled() && bp->ctx && bp->ctx->task =3D=3D current)
+		__perf_event_disable(bp);
+	else
+		perf_event_disable(bp);
=20
 	bp->attr.bp_addr =3D attr->bp_addr;
 	bp->attr.bp_type =3D attr->bp_type;
 	bp->attr.bp_len =3D attr->bp_len;
+	bp->attr.disabled =3D 1;
=20
-	if (attr->disabled)
-		goto end;
+	if (!attr->disabled) {
+		int err =3D validate_hw_breakpoint(bp);
=20
-	err =3D validate_hw_breakpoint(bp);
-	if (!err)
-		perf_event_enable(bp);
-
-	if (err) {
-		bp->attr.bp_addr =3D old_addr;
-		bp->attr.bp_type =3D old_type;
-		bp->attr.bp_len =3D old_len;
-		if (!bp->attr.disabled)
-			perf_event_enable(bp);
+		if (err)
+			return err;
=20
-		return err;
+		perf_event_enable(bp);
+		bp->attr.disabled =3D 0;
 	}
=20
-end:
-	bp->attr.disabled =3D attr->disabled;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(modify_user_hw_breakpoint);
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index f3fdd40d670a..00ebf9a6406c 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -1200,7 +1200,12 @@ static void __hrtimer_init(struct hrtimer *timer, cl=
ockid_t clock_id,
=20
 	cpu_base =3D &__raw_get_cpu_var(hrtimer_bases);
=20
-	if (clock_id =3D=3D CLOCK_REALTIME && mode !=3D HRTIMER_MODE_ABS)
+	/*
+	 * POSIX magic: Relative CLOCK_REALTIME timers are not affected by
+	 * clock modifications, so they needs to become CLOCK_MONOTONIC to
+	 * ensure POSIX compliance.
+	 */
+	if (clock_id =3D=3D CLOCK_REALTIME && mode & HRTIMER_MODE_REL)
 		clock_id =3D CLOCK_MONOTONIC;
=20
 	base =3D hrtimer_clockid_to_base(clock_id);
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 4a32f9cd96dc..3130973c2d13 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -47,6 +47,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
=20
 /*
  * Management arrays for POSIX timers.	 Timers are kept in slab memory
@@ -520,13 +521,21 @@ static void release_posix_timer(struct k_itimer *tmr,=
 int it_id_set)
=20
 static struct k_clock *clockid_to_kclock(const clockid_t id)
 {
-	if (id < 0)
+	clockid_t idx =3D id;
+	struct k_clock *kc;
+
+	if (id < 0) {
 		return (id & CLOCKFD_MASK) =3D=3D CLOCKFD ?
 			&clock_posix_dynamic : &clock_posix_cpu;
+	}
+
+	if (id >=3D ARRAY_SIZE(posix_clocks))
+		return NULL;
=20
-	if (id >=3D MAX_CLOCKS || !posix_clocks[id].clock_getres)
+	kc =3D &posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
+	if (!kc->clock_getres)
 		return NULL;
-	return &posix_clocks[id];
+	return kc;
 }
=20
 static int common_timer_create(struct k_itimer *new_timer)
diff --git a/kernel/relay.c b/kernel/relay.c
index a535fc91a7ba..8995ceb56057 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -166,7 +166,7 @@ static struct rchan_buf *relay_create_buf(struct rchan =
*chan)
 {
 	struct rchan_buf *buf;
=20
-	if (chan->n_subbufs > UINT_MAX / sizeof(size_t *))
+	if (chan->n_subbufs > KMALLOC_MAX_SIZE / sizeof(size_t *))
 		return NULL;
=20
 	buf =3D kzalloc(sizeof(struct rchan_buf), GFP_KERNEL);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 2ec1a389a939..367b36511018 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -920,7 +920,7 @@ static struct notifier_block trace_probe_module_nb =3D =
{
 };
=20
 /* Split symbol and offset. */
-static int split_symbol_offset(char *symbol, unsigned long *offset)
+static int split_symbol_offset(char *symbol, long *offset)
 {
 	char *tmp;
 	int ret;
@@ -928,10 +928,9 @@ static int split_symbol_offset(char *symbol, unsigned =
long *offset)
 	if (!offset)
 		return -EINVAL;
=20
-	tmp =3D strchr(symbol, '+');
+	tmp =3D strpbrk(symbol, "+-");
 	if (tmp) {
-		/* skip sign because strict_strtol doesn't accept '+' */
-		ret =3D strict_strtoul(tmp + 1, 0, offset);
+		ret =3D kstrtol(tmp, 0, offset);
 		if (ret)
 			return ret;
 		*tmp =3D '\0';
@@ -1165,7 +1164,7 @@ static int create_trace_probe(int argc, char **argv)
 	int is_return =3D 0, is_delete =3D 0;
 	char *symbol =3D NULL, *event =3D NULL, *group =3D NULL;
 	char *arg;
-	unsigned long offset =3D 0;
+	long offset =3D 0;
 	void *addr =3D NULL;
 	char buf[MAX_EVENT_NAME_LEN];
=20
@@ -1238,7 +1237,7 @@ static int create_trace_probe(int argc, char **argv)
 		symbol =3D argv[1];
 		/* TODO: support .init module functions */
 		ret =3D split_symbol_offset(symbol, &offset);
-		if (ret) {
+		if (ret || offset < 0 || offset > UINT_MAX) {
 			pr_info("Failed to parse either an address or a symbol.\n");
 			return ret;
 		}
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 390f0ac4eed6..a489d9338ac4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -18,6 +18,7 @@
 #include <linux/bootmem.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
+#include <linux/mmdebug.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
 #include <linux/swapops.h>
@@ -3097,6 +3098,14 @@ int hugetlb_reserve_pages(struct inode *inode,
 	struct hstate *h =3D hstate_inode(inode);
 	struct hugepage_subpool *spool =3D subpool_inode(inode);
=20
+	/* This should never happen */
+	if (from > to) {
+#ifdef CONFIG_DEBUG_VM
+		WARN(1, "%s called with a negative range\n", __func__);
+#endif
+		return -EINVAL;
+	}
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
diff --git a/mm/madvise.c b/mm/madvise.c
index 23d3a6b3764f..ec8e59c08d54 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -128,6 +128,7 @@ static long madvise_willneed(struct vm_area_struct * vm=
a,
 {
 	struct file *file =3D vma->vm_file;
=20
+	*prev =3D vma;
 	if (!file)
 		return -EBADF;
=20
@@ -136,7 +137,6 @@ static long madvise_willneed(struct vm_area_struct * vm=
a,
 		return 0;
 	}
=20
-	*prev =3D vma;
 	start =3D ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
 	if (end > vma->vm_end)
 		end =3D vma->vm_end;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 1ea67ad062db..b056dc2f73da 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2019,6 +2019,9 @@ int __mpol_equal(struct mempolicy *a, struct mempolic=
y *b)
 	case MPOL_INTERLEAVE:
 		return nodes_equal(a->v.nodes, b->v.nodes);
 	case MPOL_PREFERRED:
+		/* a's ->flags is the same as b's */
+		if (a->flags & MPOL_F_LOCAL)
+			return true;
 		return a->v.preferred_node =3D=3D b->v.preferred_node;
 	default:
 		BUG();
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ab98dc6b1677..4de949ba7cea 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1085,6 +1085,7 @@ int __isolate_lru_page(struct page *page, isolate_mod=
e_t mode, int file)
=20
 		if (PageDirty(page)) {
 			struct address_space *mapping;
+			bool migrate_dirty;
=20
 			/* ISOLATE_CLEAN means only clean pages */
 			if (mode & ISOLATE_CLEAN)
@@ -1093,10 +1094,19 @@ int __isolate_lru_page(struct page *page, isolate_m=
ode_t mode, int file)
 			/*
 			 * Only pages without mappings or that have a
 			 * ->migratepage callback are possible to migrate
-			 * without blocking
+			 * without blocking. However, we can be racing with
+			 * truncation so it's necessary to lock the page
+			 * to stabilise the mapping as truncation holds
+			 * the page lock until after the page is removed
+			 * from the page cache.
 			 */
+			if (!trylock_page(page))
+				return ret;
+
 			mapping =3D page_mapping(page);
-			if (mapping && !mapping->a_ops->migratepage)
+			migrate_dirty =3D mapping && mapping->a_ops->migratepage;
+			unlock_page(page);
+			if (!migrate_dirty)
 				return ret;
 		}
 	}
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 0a05ac1056ef..a10726537d0b 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -163,7 +163,8 @@ static void req_done(struct virtqueue *vq)
 		P9_DPRINTK(P9_DEBUG_TRANS, ": lookup tag %d\n", rc->tag);
 		req =3D p9_tag_lookup(chan->client, rc->tag);
 		req->status =3D REQ_STATUS_RCVD;
-		p9_client_cb(chan->client, req);
+		if (len)
+			p9_client_cb(chan->client, req);
 	}
 }
=20
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interfac=
e.c
index a8f4627a426e..dbe1a8c2b51a 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -733,12 +733,7 @@ void interface_rx(struct net_device *soft_iface,
=20
 	/* skb->dev & skb->pkt_type are set here */
 	skb->protocol =3D eth_type_trans(skb, soft_iface);
-
-	/* should not be necessary anymore as we use skb_pull_rcsum()
-	 * TODO: please verify this and remove this TODO
-	 * -- Dec 21st 2009, Simon Wunderlich */
-
-/*	skb->ip_summed =3D CHECKSUM_UNNECESSARY;*/
+	skb_postpull_rcsum(skb, eth_hdr(skb), ETH_HLEN);
=20
 	bat_priv->stats.rx_packets++;
 	bat_priv->stats.rx_bytes +=3D skb->len + sizeof(struct ethhdr);
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 6229b62749e8..d1f6604c3ca5 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -196,6 +196,9 @@ static ssize_t brport_show(struct kobject * kobj,
 	struct brport_attribute * brport_attr =3D to_brport_attr(attr);
 	struct net_bridge_port * p =3D to_brport(kobj);
=20
+	if (!brport_attr->show)
+		return -EINVAL;
+
 	return brport_attr->show(p, buf);
 }
=20
diff --git a/net/bridge/netfilter/ebt_among.c b/net/bridge/netfilter/ebt_am=
ong.c
index 8b84c581be30..06db7071572c 100644
--- a/net/bridge/netfilter/ebt_among.c
+++ b/net/bridge/netfilter/ebt_among.c
@@ -172,18 +172,69 @@ ebt_among_mt(const struct sk_buff *skb, struct xt_act=
ion_param *par)
 	return true;
 }
=20
+static bool poolsize_invalid(const struct ebt_mac_wormhash *w)
+{
+	return w && w->poolsize >=3D (INT_MAX / sizeof(struct ebt_mac_wormhash_tu=
ple));
+}
+
+static bool wormhash_offset_invalid(int off, unsigned int len)
+{
+	if (off =3D=3D 0) /* not present */
+		return false;
+
+	if (off < (int)sizeof(struct ebt_among_info) ||
+	    off % __alignof__(struct ebt_mac_wormhash))
+		return true;
+
+	off +=3D sizeof(struct ebt_mac_wormhash);
+
+	return off > len;
+}
+
+static bool wormhash_sizes_valid(const struct ebt_mac_wormhash *wh, int a,=
 int b)
+{
+	if (a =3D=3D 0)
+		a =3D sizeof(struct ebt_among_info);
+
+	return ebt_mac_wormhash_size(wh) + a =3D=3D b;
+}
+
 static int ebt_among_mt_check(const struct xt_mtchk_param *par)
 {
 	const struct ebt_among_info *info =3D par->matchinfo;
 	const struct ebt_entry_match *em =3D
 		container_of(par->matchinfo, const struct ebt_entry_match, data);
-	int expected_length =3D sizeof(struct ebt_among_info);
+	unsigned int expected_length =3D sizeof(struct ebt_among_info);
 	const struct ebt_mac_wormhash *wh_dst, *wh_src;
 	int err;
=20
+	if (expected_length > em->match_size)
+		return -EINVAL;
+
+	if (wormhash_offset_invalid(info->wh_dst_ofs, em->match_size) ||
+	    wormhash_offset_invalid(info->wh_src_ofs, em->match_size))
+		return -EINVAL;
+
 	wh_dst =3D ebt_among_wh_dst(info);
-	wh_src =3D ebt_among_wh_src(info);
+	if (poolsize_invalid(wh_dst))
+		return -EINVAL;
+
 	expected_length +=3D ebt_mac_wormhash_size(wh_dst);
+	if (expected_length > em->match_size)
+		return -EINVAL;
+
+	wh_src =3D ebt_among_wh_src(info);
+	if (poolsize_invalid(wh_src))
+		return -EINVAL;
+
+	if (info->wh_src_ofs < info->wh_dst_ofs) {
+		if (!wormhash_sizes_valid(wh_src, info->wh_src_ofs, info->wh_dst_ofs))
+			return -EINVAL;
+	} else {
+		if (!wormhash_sizes_valid(wh_dst, info->wh_dst_ofs, info->wh_src_ofs))
+			return -EINVAL;
+	}
+
 	expected_length +=3D ebt_mac_wormhash_size(wh_src);
=20
 	if (em->match_size !=3D EBT_ALIGN(expected_length)) {
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtable=
s.c
index 45f93f8a10c8..9cde6d308a1b 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2004,7 +2004,9 @@ static int ebt_size_mwt(struct compat_ebt_entry_mwt *=
match32,
 		if (match_kern)
 			match_kern->match_size =3D ret;
=20
-		WARN_ON(type =3D=3D EBT_COMPAT_TARGET && size_left);
+		if (WARN_ON(type =3D=3D EBT_COMPAT_TARGET && size_left))
+			return -EINVAL;
+
 		match32 =3D (struct compat_ebt_entry_mwt *) buf;
 	}
=20
@@ -2061,6 +2063,19 @@ static int size_entry_mwt(struct ebt_entry *entry, c=
onst unsigned char *base,
 	 *
 	 * offsets are relative to beginning of struct ebt_entry (i.e., 0).
 	 */
+	for (i =3D 0; i < 4 ; ++i) {
+		if (offsets[i] > *total)
+			return -EINVAL;
+
+		if (i < 3 && offsets[i] =3D=3D *total)
+			return -EINVAL;
+
+		if (i =3D=3D 0)
+			continue;
+		if (offsets[i-1] > offsets[i])
+			return -EINVAL;
+	}
+
 	for (i =3D 0, j =3D 1 ; j < 4 ; j++, i++) {
 		struct compat_ebt_entry_mwt *match32;
 		unsigned int size;
diff --git a/net/core/dev.c b/net/core/dev.c
index bb7a0cc037e9..56a6ad8031eb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1750,8 +1750,11 @@ static void netif_setup_tc(struct net_device *dev, u=
nsigned int txq)
  */
 int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 {
+	bool disabling;
 	int rc;
=20
+	disabling =3D txq < dev->real_num_tx_queues;
+
 	if (txq < 1 || txq > dev->num_tx_queues)
 		return -EINVAL;
=20
@@ -1767,11 +1770,16 @@ int netif_set_real_num_tx_queues(struct net_device =
*dev, unsigned int txq)
 		if (dev->num_tc)
 			netif_setup_tc(dev, txq);
=20
-		if (txq < dev->real_num_tx_queues)
+		dev->real_num_tx_queues =3D txq;
+
+		if (disabling) {
+			synchronize_net();
 			qdisc_reset_all_tx_gt(dev, txq);
+		}
+	} else {
+		dev->real_num_tx_queues =3D txq;
 	}
=20
-	dev->real_num_tx_queues =3D txq;
 	return 0;
 }
 EXPORT_SYMBOL(netif_set_real_num_tx_queues);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 847b314b3a70..c5337c25d32d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3093,8 +3093,6 @@ static void sock_rmem_free(struct sk_buff *skb)
  */
 int sock_queue_err_skb(struct sock *sk, struct sk_buff *skb)
 {
-	int len =3D skb->len;
-
 	if (atomic_read(&sk->sk_rmem_alloc) + skb->truesize >=3D
 	    (unsigned)sk->sk_rcvbuf)
 		return -ENOMEM;
@@ -3109,7 +3107,7 @@ int sock_queue_err_skb(struct sock *sk, struct sk_buf=
f *skb)
=20
 	skb_queue_tail(&sk->sk_error_queue, skb);
 	if (!sock_flag(sk, SOCK_DEAD))
-		sk->sk_data_ready(sk, len);
+		sk->sk_error_report(sk);
 	return 0;
 }
 EXPORT_SYMBOL(sock_queue_err_skb);
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 4c9061eab75e..975dcdf98892 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -785,6 +785,11 @@ int dccp_sendmsg(struct kiocb *iocb, struct sock *sk, =
struct msghdr *msg,
 	if (skb =3D=3D NULL)
 		goto out_release;
=20
+	if (sk->sk_state =3D=3D DCCP_CLOSED) {
+		rc =3D -ENOTCONN;
+		goto out_discard;
+	}
+
 	skb_reserve(skb, sk->sk_prot->max_header);
 	rc =3D memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len);
 	if (rc !=3D 0)
diff --git a/net/decnet/af_decnet.c b/net/decnet/af_decnet.c
index c0486c8877c9..0b427743409a 100644
--- a/net/decnet/af_decnet.c
+++ b/net/decnet/af_decnet.c
@@ -1338,6 +1338,12 @@ static int dn_setsockopt(struct socket *sock, int le=
vel, int optname, char __use
 	lock_sock(sk);
 	err =3D __dn_setsockopt(sock, level, optname, optval, optlen, 0);
 	release_sock(sk);
+#ifdef CONFIG_NETFILTER
+	/* we need to exclude all possible ENOPROTOOPTs except default case */
+	if (err =3D=3D -ENOPROTOOPT && optname !=3D DSO_LINKINFO &&
+	    optname !=3D DSO_STREAM && optname !=3D DSO_SEQPACKET)
+		err =3D nf_setsockopt(sk, PF_DECnet, optname, optval, optlen);
+#endif
=20
 	return err;
 }
@@ -1445,15 +1451,6 @@ static int __dn_setsockopt(struct socket *sock, int =
level,int optname, char __us
 		dn_nsp_send_disc(sk, 0x38, 0, sk->sk_allocation);
 		break;
=20
-	default:
-#ifdef CONFIG_NETFILTER
-		return nf_setsockopt(sk, PF_DECnet, optname, optval, optlen);
-#endif
-	case DSO_LINKINFO:
-	case DSO_STREAM:
-	case DSO_SEQPACKET:
-		return -ENOPROTOOPT;
-
 	case DSO_MAXWINDOW:
 		if (optlen !=3D sizeof(unsigned long))
 			return -EINVAL;
@@ -1501,6 +1498,12 @@ static int __dn_setsockopt(struct socket *sock, int =
level,int optname, char __us
 			return -EINVAL;
 		scp->info_loc =3D u.info;
 		break;
+
+	case DSO_LINKINFO:
+	case DSO_STREAM:
+	case DSO_SEQPACKET:
+	default:
+		return -ENOPROTOOPT;
 	}
=20
 	return 0;
@@ -1514,6 +1517,20 @@ static int dn_getsockopt(struct socket *sock, int le=
vel, int optname, char __use
 	lock_sock(sk);
 	err =3D __dn_getsockopt(sock, level, optname, optval, optlen, 0);
 	release_sock(sk);
+#ifdef CONFIG_NETFILTER
+	if (err =3D=3D -ENOPROTOOPT && optname !=3D DSO_STREAM &&
+	    optname !=3D DSO_SEQPACKET && optname !=3D DSO_CONACCEPT &&
+	    optname !=3D DSO_CONREJECT) {
+		int len;
+
+		if (get_user(len, optlen))
+			return -EFAULT;
+
+		err =3D nf_getsockopt(sk, PF_DECnet, optname, optval, &len);
+		if (err >=3D 0)
+			err =3D put_user(len, optlen);
+	}
+#endif
=20
 	return err;
 }
@@ -1579,26 +1596,6 @@ static int __dn_getsockopt(struct socket *sock, int =
level,int optname, char __us
 		r_data =3D &link;
 		break;
=20
-	default:
-#ifdef CONFIG_NETFILTER
-	{
-		int ret, len;
-
-		if (get_user(len, optlen))
-			return -EFAULT;
-
-		ret =3D nf_getsockopt(sk, PF_DECnet, optname, optval, &len);
-		if (ret >=3D 0)
-			ret =3D put_user(len, optlen);
-		return ret;
-	}
-#endif
-	case DSO_STREAM:
-	case DSO_SEQPACKET:
-	case DSO_CONACCEPT:
-	case DSO_CONREJECT:
-		return -ENOPROTOOPT;
-
 	case DSO_MAXWINDOW:
 		if (r_len > sizeof(unsigned long))
 			r_len =3D sizeof(unsigned long);
@@ -1630,6 +1627,13 @@ static int __dn_getsockopt(struct socket *sock, int =
level,int optname, char __us
 			r_len =3D sizeof(unsigned char);
 		r_data =3D &scp->info_rem;
 		break;
+
+	case DSO_STREAM:
+	case DSO_SEQPACKET:
+	case DSO_CONACCEPT:
+	case DSO_CONREJECT:
+	default:
+		return -ENOPROTOOPT;
 	}
=20
 	if (r_data) {
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 96ad44a69899..59155c1b84bc 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -363,7 +363,11 @@ static struct sk_buff *igmpv3_newpack(struct net_devic=
e *dev, unsigned int mtu)
 	pip->frag_off =3D htons(IP_DF);
 	pip->ttl      =3D 1;
 	pip->daddr    =3D fl4.daddr;
+
+	rcu_read_lock();
 	pip->saddr    =3D igmpv3_get_srcaddr(dev, &fl4);
+	rcu_read_unlock();
+
 	pip->protocol =3D IPPROTO_IGMP;
 	pip->tot_len  =3D 0;	/* filled in later */
 	ip_select_ident(skb, NULL);
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index a6e1eeb02267..ff4dd68f2b87 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1030,11 +1030,8 @@ int ip_setsockopt(struct sock *sk, int level,
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D IP_HDRINCL &&
 			optname !=3D IP_IPSEC_POLICY &&
 			optname !=3D IP_XFRM_POLICY &&
-			!ip_mroute_opt(optname)) {
-		lock_sock(sk);
+			!ip_mroute_opt(optname))
 		err =3D nf_setsockopt(sk, PF_INET, optname, optval, optlen);
-		release_sock(sk);
-	}
 #endif
 	return err;
 }
@@ -1059,12 +1056,9 @@ int compat_ip_setsockopt(struct sock *sk, int level,=
 int optname,
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D IP_HDRINCL &&
 			optname !=3D IP_IPSEC_POLICY &&
 			optname !=3D IP_XFRM_POLICY &&
-			!ip_mroute_opt(optname)) {
-		lock_sock(sk);
-		err =3D compat_nf_setsockopt(sk, PF_INET, optname,
-					   optval, optlen);
-		release_sock(sk);
-	}
+			!ip_mroute_opt(optname))
+		err =3D compat_nf_setsockopt(sk, PF_INET, optname, optval,
+					   optlen);
 #endif
 	return err;
 }
@@ -1314,10 +1308,7 @@ int ip_getsockopt(struct sock *sk, int level,
 		if (get_user(len, optlen))
 			return -EFAULT;
=20
-		lock_sock(sk);
-		err =3D nf_getsockopt(sk, PF_INET, optname, optval,
-				&len);
-		release_sock(sk);
+		err =3D nf_getsockopt(sk, PF_INET, optname, optval, &len);
 		if (err >=3D 0)
 			err =3D put_user(len, optlen);
 		return err;
@@ -1349,9 +1340,7 @@ int compat_ip_getsockopt(struct sock *sk, int level, =
int optname,
 		if (get_user(len, optlen))
 			return -EFAULT;
=20
-		lock_sock(sk);
 		err =3D compat_nf_getsockopt(sk, PF_INET, optname, optval, &len);
-		release_sock(sk);
 		if (err >=3D 0)
 			err =3D put_user(len, optlen);
 		return err;
diff --git a/net/ipv4/netfilter/ipt_CLUSTERIP.c b/net/ipv4/netfilter/ipt_CL=
USTERIP.c
index a639967eb727..cb21acc35b61 100644
--- a/net/ipv4/netfilter/ipt_CLUSTERIP.c
+++ b/net/ipv4/netfilter/ipt_CLUSTERIP.c
@@ -135,8 +135,12 @@ clusterip_config_find_get(__be32 clusterip, int entry)
 	if (c) {
 		if (unlikely(!atomic_inc_not_zero(&c->refcount)))
 			c =3D NULL;
-		else if (entry)
-			atomic_inc(&c->entries);
+		else if (entry) {
+			if (unlikely(!atomic_inc_not_zero(&c->entries))) {
+				clusterip_config_put(c);
+				c =3D NULL;
+			}
+		}
 	}
 	rcu_read_unlock_bh();
=20
@@ -354,7 +358,7 @@ static int clusterip_tg_check(const struct xt_tgchk_par=
am *par)
 	struct ipt_clusterip_tgt_info *cipinfo =3D par->targinfo;
 	const struct ipt_entry *e =3D par->entryinfo;
 	struct clusterip_config *config;
-	int ret;
+	int ret, i;
=20
 	if (cipinfo->hash_mode !=3D CLUSTERIP_HASHMODE_SIP &&
 	    cipinfo->hash_mode !=3D CLUSTERIP_HASHMODE_SIP_SPT &&
@@ -368,8 +372,18 @@ static int clusterip_tg_check(const struct xt_tgchk_pa=
ram *par)
 		pr_info("Please specify destination IP\n");
 		return -EINVAL;
 	}
-
-	/* FIXME: further sanity checks */
+	if (cipinfo->num_local_nodes > ARRAY_SIZE(cipinfo->local_nodes)) {
+		pr_info("bad num_local_nodes %u\n", cipinfo->num_local_nodes);
+		return -EINVAL;
+	}
+	for (i =3D 0; i < cipinfo->num_local_nodes; i++) {
+		if (cipinfo->local_nodes[i] - 1 >=3D
+		    sizeof(config->local_nodes) * 8) {
+			pr_info("bad local_nodes[%d] %u\n",
+				i, cipinfo->local_nodes[i]);
+			return -EINVAL;
+		}
+	}
=20
 	config =3D clusterip_config_find_get(e->ip.dst.s_addr, 1);
 	if (!config) {
diff --git a/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c b/net/ipv4/netf=
ilter/nf_conntrack_l3proto_ipv4.c
index d7d63f410495..6791f3a127b1 100644
--- a/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
+++ b/net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c
@@ -258,15 +258,19 @@ getorigdst(struct sock *sk, int optval, void __user *=
user, int *len)
 	struct nf_conntrack_tuple tuple;
=20
 	memset(&tuple, 0, sizeof(tuple));
+
+	lock_sock(sk);
 	tuple.src.u3.ip =3D inet->inet_rcv_saddr;
 	tuple.src.u.tcp.port =3D inet->inet_sport;
 	tuple.dst.u3.ip =3D inet->inet_daddr;
 	tuple.dst.u.tcp.port =3D inet->inet_dport;
 	tuple.src.l3num =3D PF_INET;
 	tuple.dst.protonum =3D sk->sk_protocol;
+	release_sock(sk);
=20
 	/* We only do TCP and SCTP at the moment: is there a better way? */
-	if (sk->sk_protocol !=3D IPPROTO_TCP && sk->sk_protocol !=3D IPPROTO_SCTP=
) {
+	if (tuple.dst.protonum !=3D IPPROTO_TCP &&
+	    tuple.dst.protonum !=3D IPPROTO_SCTP) {
 		pr_debug("SO_ORIGINAL_DST: Not a TCP/SCTP socket\n");
 		return -ENOPROTOOPT;
 	}
diff --git a/net/ipv4/netfilter/nf_nat_proto_common.c b/net/ipv4/netfilter/=
nf_nat_proto_common.c
index a3d997618602..ccb69ce15989 100644
--- a/net/ipv4/netfilter/nf_nat_proto_common.c
+++ b/net/ipv4/netfilter/nf_nat_proto_common.c
@@ -42,7 +42,7 @@ void nf_nat_proto_unique_tuple(struct nf_conntrack_tuple =
*tuple,
 			       const struct nf_conn *ct,
 			       u_int16_t *rover)
 {
-	unsigned int range_size, min, i;
+	unsigned int range_size, min, max, i;
 	__be16 *portptr;
 	u_int16_t off;
=20
@@ -72,7 +72,10 @@ void nf_nat_proto_unique_tuple(struct nf_conntrack_tuple=
 *tuple,
 		}
 	} else {
 		min =3D ntohs(range->min.all);
-		range_size =3D ntohs(range->max.all) - min + 1;
+		max =3D ntohs(range->max.all);
+		if (unlikely(max < min))
+			swap(max, min);
+		range_size =3D max - min + 1;
 	}
=20
 	if (range->flags & IP_NAT_RANGE_PROTO_RANDOM)
diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 9af3f5c4ef5c..4af98c8fd95d 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -841,12 +841,8 @@ int ipv6_setsockopt(struct sock *sk, int level, int op=
tname,
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D IPV6_IPSEC_POLICY &&
-			optname !=3D IPV6_XFRM_POLICY) {
-		lock_sock(sk);
-		err =3D nf_setsockopt(sk, PF_INET6, optname, optval,
-				optlen);
-		release_sock(sk);
-	}
+			optname !=3D IPV6_XFRM_POLICY)
+		err =3D nf_setsockopt(sk, PF_INET6, optname, optval, optlen);
 #endif
 	return err;
 }
@@ -877,12 +873,9 @@ int compat_ipv6_setsockopt(struct sock *sk, int level,=
 int optname,
 #ifdef CONFIG_NETFILTER
 	/* we need to exclude all possible ENOPROTOOPTs except default case */
 	if (err =3D=3D -ENOPROTOOPT && optname !=3D IPV6_IPSEC_POLICY &&
-	    optname !=3D IPV6_XFRM_POLICY) {
-		lock_sock(sk);
-		err =3D compat_nf_setsockopt(sk, PF_INET6, optname,
-					   optval, optlen);
-		release_sock(sk);
-	}
+	    optname !=3D IPV6_XFRM_POLICY)
+		err =3D compat_nf_setsockopt(sk, PF_INET6, optname, optval,
+					   optlen);
 #endif
 	return err;
 }
@@ -1244,10 +1237,7 @@ int ipv6_getsockopt(struct sock *sk, int level, int =
optname,
 		if (get_user(len, optlen))
 			return -EFAULT;
=20
-		lock_sock(sk);
-		err =3D nf_getsockopt(sk, PF_INET6, optname, optval,
-				&len);
-		release_sock(sk);
+		err =3D nf_getsockopt(sk, PF_INET6, optname, optval, &len);
 		if (err >=3D 0)
 			err =3D put_user(len, optlen);
 	}
@@ -1287,10 +1277,7 @@ int compat_ipv6_getsockopt(struct sock *sk, int leve=
l, int optname,
 		if (get_user(len, optlen))
 			return -EFAULT;
=20
-		lock_sock(sk);
-		err =3D compat_nf_getsockopt(sk, PF_INET6,
-					   optname, optval, &len);
-		release_sock(sk);
+		err =3D compat_nf_getsockopt(sk, PF_INET6, optname, optval, &len);
 		if (err >=3D 0)
 			err =3D put_user(len, optlen);
 	}
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index d5fe136ed0b8..a7f078ee911b 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1505,9 +1505,14 @@ int l2tp_tunnel_create(struct net *net, int fd, int =
version, u32 tunnel_id, u32
 		encap =3D cfg->encap;
=20
 	/* Quick sanity checks */
+	err =3D -EPROTONOSUPPORT;
+	if (sk->sk_type !=3D SOCK_DGRAM) {
+		pr_debug("tunl %hu: fd %d wrong socket type\n",
+			 tunnel_id, fd);
+		goto err;
+	}
 	switch (encap) {
 	case L2TP_ENCAPTYPE_UDP:
-		err =3D -EPROTONOSUPPORT;
 		if (sk->sk_protocol !=3D IPPROTO_UDP) {
 			printk(KERN_ERR "tunl %hu: fd %d wrong protocol, got %d, expected %d\n"=
,
 			       tunnel_id, fd, sk->sk_protocol, IPPROTO_UDP);
@@ -1515,7 +1520,6 @@ int l2tp_tunnel_create(struct net *net, int fd, int v=
ersion, u32 tunnel_id, u32
 		}
 		break;
 	case L2TP_ENCAPTYPE_IP:
-		err =3D -EPROTONOSUPPORT;
 		if (sk->sk_protocol !=3D IPPROTO_L2TP) {
 			printk(KERN_ERR "tunl %hu: fd %d wrong protocol, got %d, expected %d\n"=
,
 			       tunnel_id, fd, sk->sk_protocol, IPPROTO_L2TP);
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 12c0e8aca956..9f80edf8f0aa 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -589,6 +589,8 @@ static int l2tp_nl_session_send(struct sk_buff *skb, u3=
2 pid, u32 seq, int flags
=20
 	if (session->ifname && session->ifname[0])
 		NLA_PUT_STRING(skb, L2TP_ATTR_IFNAME, session->ifname);
+	if (session->offset)
+		NLA_PUT_U16(skb, L2TP_ATTR_OFFSET, session->offset);
 	if (session->cookie_len)
 		NLA_PUT(skb, L2TP_ATTR_COOKIE, session->cookie_len, &session->cookie[0])=
;
 	if (session->peer_cookie_len)
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index f25cb19bc22d..62d7e71f55fb 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -463,22 +463,28 @@ static int pppol2tp_xmit(struct ppp_channel *chan, st=
ruct sk_buff *skb)
  * Session (and tunnel control) socket create/destroy.
  *************************************************************************=
****/
=20
+static void pppol2tp_put_sk(struct rcu_head *head)
+{
+	struct pppol2tp_session *ps;
+
+	ps =3D container_of(head, typeof(*ps), rcu);
+	sock_put(ps->__sk);
+}
+
 /* Called by l2tp_core when a session socket is being closed.
  */
 static void pppol2tp_session_close(struct l2tp_session *session)
 {
-	struct sock *sk;
-
-	BUG_ON(session->magic !=3D L2TP_SESSION_MAGIC);
-
+	struct pppol2tp_session *ps;
=20
-	sk =3D pppol2tp_session_get_sock(session);
-	if (sk) {
-		if (sk->sk_socket)
-			inet_shutdown(sk->sk_socket, SEND_SHUTDOWN);
-		sock_put(sk);
-	}
-	return;
+	ps =3D l2tp_session_priv(session);
+	mutex_lock(&ps->sk_lock);
+	ps->__sk =3D rcu_dereference_protected(ps->sk,
+					     lockdep_is_held(&ps->sk_lock));
+	RCU_INIT_POINTER(ps->sk, NULL);
+	if (ps->__sk)
+		call_rcu(&ps->rcu, pppol2tp_put_sk);
+	mutex_unlock(&ps->sk_lock);
 }
=20
 /* Really kill the session socket. (Called from sock_put() if
@@ -502,14 +508,6 @@ static void pppol2tp_session_destruct(struct sock *sk)
 	return;
 }
=20
-static void pppol2tp_put_sk(struct rcu_head *head)
-{
-	struct pppol2tp_session *ps;
-
-	ps =3D container_of(head, typeof(*ps), rcu);
-	sock_put(ps->__sk);
-}
-
 /* Called when the PPPoX socket (session) is closed.
  */
 static int pppol2tp_release(struct socket *sock)
@@ -533,26 +531,17 @@ static int pppol2tp_release(struct socket *sock)
 	sock_orphan(sk);
 	sock->sk =3D NULL;
=20
+	/* If the socket is associated with a session,
+	 * l2tp_session_delete will call pppol2tp_session_close which
+	 * will drop the session's ref on the socket.
+	 */
 	session =3D pppol2tp_sock_to_session(sk);
-
-	if (session !=3D NULL) {
-		struct pppol2tp_session *ps;
-
+	if (session) {
 		l2tp_session_delete(session);
-
-		ps =3D l2tp_session_priv(session);
-		mutex_lock(&ps->sk_lock);
-		ps->__sk =3D rcu_dereference_protected(ps->sk,
-						     lockdep_is_held(&ps->sk_lock));
-		RCU_INIT_POINTER(ps->sk, NULL);
-		mutex_unlock(&ps->sk_lock);
-		call_rcu(&ps->rcu, pppol2tp_put_sk);
-
-		/* Rely on the sock_put() call at the end of the function for
-		 * dropping the reference held by pppol2tp_sock_to_session().
-		 * The last reference will be dropped by pppol2tp_put_sk().
-		 */
+		/* drop the ref obtained by pppol2tp_sock_to_session */
+		sock_put(sk);
 	}
+
 	skb_queue_purge(&sk->sk_receive_queue);
 	skb_queue_purge(&sk->sk_write_queue);
=20
@@ -840,6 +829,7 @@ static int pppol2tp_connect(struct socket *sock, struct=
 sockaddr *uservaddr,
=20
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
+	sock_hold(sk);
 	sk->sk_user_data =3D session;
 	rcu_assign_pointer(ps->sk, sk);
 	mutex_unlock(&ps->sk_lock);
diff --git a/net/netfilter/xt_IDLETIMER.c b/net/netfilter/xt_IDLETIMER.c
index f407ebc13481..95b6dedc5ac7 100644
--- a/net/netfilter/xt_IDLETIMER.c
+++ b/net/netfilter/xt_IDLETIMER.c
@@ -146,11 +146,11 @@ static int idletimer_tg_create(struct idletimer_tg_in=
fo *info)
 		    (unsigned long) info->timer);
 	info->timer->refcnt =3D 1;
=20
+	INIT_WORK(&info->timer->work, idletimer_tg_work);
+
 	mod_timer(&info->timer->timer,
 		  msecs_to_jiffies(info->timeout * 1000) + jiffies);
=20
-	INIT_WORK(&info->timer->work, idletimer_tg_work);
-
 	return 0;
=20
 out_free_attr:
@@ -191,7 +191,10 @@ static int idletimer_tg_checkentry(const struct xt_tgc=
hk_param *par)
 		pr_debug("timeout value is zero\n");
 		return -EINVAL;
 	}
-
+	if (info->timeout >=3D INT_MAX / 1000) {
+		pr_debug("timeout value is too big\n");
+		return -EINVAL;
+	}
 	if (info->label[0] =3D=3D '\0' ||
 	    strnlen(info->label,
 		    MAX_IDLETIMER_LABEL_SIZE) =3D=3D MAX_IDLETIMER_LABEL_SIZE) {
diff --git a/net/netfilter/xt_LED.c b/net/netfilter/xt_LED.c
index 993de2ba89d3..d944bc17c10c 100644
--- a/net/netfilter/xt_LED.c
+++ b/net/netfilter/xt_LED.c
@@ -139,10 +139,11 @@ static int led_tg_check(const struct xt_tgchk_param *=
par)
 		goto exit_alloc;
 	}
=20
-	/* See if we need to set up a timer */
-	if (ledinfo->delay > 0)
-		setup_timer(&ledinternal->timer, led_timeout_callback,
-			    (unsigned long)ledinternal);
+	/* Since the letinternal timer can be shared between multiple targets,
+	 * always set it up, even if the current target does not need it
+	 */
+	setup_timer(&ledinternal->timer, led_timeout_callback,
+		    (unsigned long)ledinternal);
=20
 	list_add_tail(&ledinternal->list, &xt_led_triggers);
=20
@@ -179,8 +180,7 @@ static void led_tg_destroy(const struct xt_tgdtor_param=
 *par)
=20
 	list_del(&ledinternal->list);
=20
-	if (ledinfo->delay > 0)
-		del_timer_sync(&ledinternal->timer);
+	del_timer_sync(&ledinternal->timer);
=20
 	led_trigger_unregister(&ledinternal->netfilter_led_trigger);
=20
diff --git a/net/netfilter/xt_RATEEST.c b/net/netfilter/xt_RATEEST.c
index f264032b8c56..309a520bd78a 100644
--- a/net/netfilter/xt_RATEEST.c
+++ b/net/netfilter/xt_RATEEST.c
@@ -40,24 +40,32 @@ static void xt_rateest_hash_insert(struct xt_rateest *e=
st)
 	hlist_add_head(&est->list, &rateest_hash[h]);
 }
=20
-struct xt_rateest *xt_rateest_lookup(const char *name)
+static struct xt_rateest *__xt_rateest_lookup(const char *name)
 {
 	struct xt_rateest *est;
 	struct hlist_node *n;
 	unsigned int h;
=20
 	h =3D xt_rateest_hash(name);
-	mutex_lock(&xt_rateest_mutex);
 	hlist_for_each_entry(est, n, &rateest_hash[h], list) {
 		if (strcmp(est->name, name) =3D=3D 0) {
 			est->refcnt++;
-			mutex_unlock(&xt_rateest_mutex);
 			return est;
 		}
 	}
-	mutex_unlock(&xt_rateest_mutex);
+
 	return NULL;
 }
+
+struct xt_rateest *xt_rateest_lookup(const char *name)
+{
+	struct xt_rateest *est;
+
+	mutex_lock(&xt_rateest_mutex);
+	est =3D __xt_rateest_lookup(name);
+	mutex_unlock(&xt_rateest_mutex);
+	return est;
+}
 EXPORT_SYMBOL_GPL(xt_rateest_lookup);
=20
 void xt_rateest_put(struct xt_rateest *est)
@@ -105,8 +113,10 @@ static int xt_rateest_tg_checkentry(const struct xt_tg=
chk_param *par)
 		rnd_inited =3D true;
 	}
=20
-	est =3D xt_rateest_lookup(info->name);
+	mutex_lock(&xt_rateest_mutex);
+	est =3D __xt_rateest_lookup(info->name);
 	if (est) {
+		mutex_unlock(&xt_rateest_mutex);
 		/*
 		 * If estimator parameters are specified, they must match the
 		 * existing estimator.
@@ -144,11 +154,13 @@ static int xt_rateest_tg_checkentry(const struct xt_t=
gchk_param *par)
=20
 	info->est =3D est;
 	xt_rateest_hash_insert(est);
+	mutex_unlock(&xt_rateest_mutex);
 	return 0;
=20
 err2:
 	kfree(est);
 err1:
+	mutex_unlock(&xt_rateest_mutex);
 	return ret;
 }
=20
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 2369e9620aa4..d1017ad64edc 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -706,6 +706,9 @@ static int netlink_connect(struct socket *sock, struct =
sockaddr *addr,
 	if (addr->sa_family !=3D AF_NETLINK)
 		return -EINVAL;
=20
+	if (alen < sizeof(struct sockaddr_nl))
+		return -EINVAL;
+
 	/* Only superuser is allowed to send multicasts */
 	if (nladdr->nl_groups && !netlink_capable(sock, NL_NONROOT_SEND))
 		return -EPERM;
diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 874f8ffbe423..c41301ab943f 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -917,6 +917,7 @@ static int genlmsg_mcast(struct sk_buff *skb, u32 pid, =
unsigned long group,
 {
 	struct sk_buff *tmp;
 	struct net *net, *prev =3D NULL;
+	bool delivered =3D false;
 	int err;
=20
 	for_each_net_rcu(net) {
@@ -928,14 +929,21 @@ static int genlmsg_mcast(struct sk_buff *skb, u32 pid=
, unsigned long group,
 			}
 			err =3D nlmsg_multicast(prev->genl_sock, tmp,
 					      pid, group, flags);
-			if (err)
+			if (!err)
+				delivered =3D true;
+			else if (err !=3D -ESRCH)
 				goto error;
 		}
=20
 		prev =3D net;
 	}
=20
-	return nlmsg_multicast(prev->genl_sock, skb, pid, group, flags);
+	err =3D nlmsg_multicast(prev->genl_sock, skb, pid, group, flags);
+	if (!err)
+		delivered =3D true;
+	else if (err !=3D -ESRCH)
+		return err;
+	return delivered ? 0 : -ESRCH;
  error:
 	kfree_skb(skb);
 	return err;
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 743a6445f4cf..89d03afba62a 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1324,10 +1324,14 @@ struct sctp_chunk *sctp_make_chunk(const struct sct=
p_association *asoc,
 	sctp_chunkhdr_t *chunk_hdr;
 	struct sk_buff *skb;
 	struct sock *sk;
+	int chunklen;
+
+	chunklen =3D WORD_ROUND(sizeof(*chunk_hdr) + paylen);
+	if (chunklen > SCTP_MAX_CHUNK_LEN)
+		goto nodata;
=20
 	/* No need to allocate LL here, as this is only a chunk. */
-	skb =3D alloc_skb(WORD_ROUND(sizeof(sctp_chunkhdr_t) + paylen),
-			GFP_ATOMIC);
+	skb =3D alloc_skb(chunklen, GFP_ATOMIC);
 	if (!skb)
 		goto nodata;
=20
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 6723bb2810e5..7bb00d408119 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -125,22 +125,17 @@ static inline int verify_replay(struct xfrm_usersa_in=
fo *p,
 	struct nlattr *rt =3D attrs[XFRMA_REPLAY_ESN_VAL];
 	struct xfrm_replay_state_esn *rs;
=20
-	if (p->flags & XFRM_STATE_ESN) {
-		if (!rt)
-			return -EINVAL;
+	if (!rt)
+		return (p->flags & XFRM_STATE_ESN) ? -EINVAL : 0;
=20
-		rs =3D nla_data(rt);
+	rs =3D nla_data(rt);
=20
-		if (rs->bmp_len > XFRMA_REPLAY_ESN_MAX / sizeof(rs->bmp[0]) / 8)
-			return -EINVAL;
-
-		if (nla_len(rt) < xfrm_replay_state_esn_len(rs) &&
-		    nla_len(rt) !=3D sizeof(*rs))
-			return -EINVAL;
-	}
+	if (rs->bmp_len > XFRMA_REPLAY_ESN_MAX / sizeof(rs->bmp[0]) / 8)
+		return -EINVAL;
=20
-	if (!rt)
-		return 0;
+	if (nla_len(rt) < (int)xfrm_replay_state_esn_len(rs) &&
+	    nla_len(rt) !=3D sizeof(*rs))
+		return -EINVAL;
=20
 	if (p->id.proto !=3D IPPROTO_ESP)
 		return -EINVAL;
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 15ae27863d02..5343f341d8cc 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -1367,7 +1367,7 @@ static ssize_t snd_pcm_oss_write2(struct snd_pcm_subs=
tream *substream, const cha
 static ssize_t snd_pcm_oss_write1(struct snd_pcm_substream *substream, con=
st char __user *buf, size_t bytes)
 {
 	size_t xfer =3D 0;
-	ssize_t tmp;
+	ssize_t tmp =3D 0;
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
=20
 	if (atomic_read(&substream->mmap_count))
@@ -1474,7 +1474,7 @@ static ssize_t snd_pcm_oss_read2(struct snd_pcm_subst=
ream *substream, char *buf,
 static ssize_t snd_pcm_oss_read1(struct snd_pcm_substream *substream, char=
 __user *buf, size_t bytes)
 {
 	size_t xfer =3D 0;
-	ssize_t tmp;
+	ssize_t tmp =3D 0;
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
=20
 	if (atomic_read(&substream->mmap_count))
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 8a00555d8529..4de0ba9927dc 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -3187,7 +3187,7 @@ int snd_pcm_lib_default_mmap(struct snd_pcm_substream=
 *substream,
 					 area,
 					 substream->runtime->dma_area,
 					 substream->runtime->dma_addr,
-					 area->vm_end - area->vm_start);
+					 substream->runtime->dma_bytes);
 #elif defined(CONFIG_MIPS) && defined(CONFIG_DMA_NONCOHERENT)
 	if (substream->dma_buffer.dev.type =3D=3D SNDRV_DMA_TYPE_DEV &&
 	    !plat_device_is_coherent(substream->dma_buffer.dev.dev))
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.=
c
index f71c7d0b89cb..08d50033d762 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -270,12 +270,12 @@ static int seq_free_client1(struct snd_seq_client *cl=
ient)
=20
 	if (!client)
 		return 0;
-	snd_seq_delete_all_ports(client);
-	snd_seq_queue_client_leave(client->number);
 	spin_lock_irqsave(&clients_lock, flags);
 	clienttablock[client->number] =3D 1;
 	clienttab[client->number] =3D NULL;
 	spin_unlock_irqrestore(&clients_lock, flags);
+	snd_seq_delete_all_ports(client);
+	snd_seq_queue_client_leave(client->number);
 	snd_use_lock_sync(&client->use_lock);
 	snd_seq_queue_client_termination(client->number);
 	if (client->pool)
@@ -907,7 +907,8 @@ int snd_seq_dispatch_event(struct snd_seq_event_cell *c=
ell, int atomic, int hop)
 static int snd_seq_client_enqueue_event(struct snd_seq_client *client,
 					struct snd_seq_event *event,
 					struct file *file, int blocking,
-					int atomic, int hop)
+					int atomic, int hop,
+					struct mutex *mutexp)
 {
 	struct snd_seq_event_cell *cell;
 	int err;
@@ -945,7 +946,8 @@ static int snd_seq_client_enqueue_event(struct snd_seq_=
client *client,
 		return -ENXIO; /* queue is not allocated */
=20
 	/* allocate an event cell */
-	err =3D snd_seq_event_dup(client->pool, event, &cell, !blocking || atomic=
, file);
+	err =3D snd_seq_event_dup(client->pool, event, &cell, !blocking || atomic=
,
+				file, mutexp);
 	if (err < 0)
 		return err;
=20
@@ -1000,7 +1002,7 @@ static ssize_t snd_seq_write(struct file *file, const=
 char __user *buf,
 {
 	struct snd_seq_client *client =3D file->private_data;
 	int written =3D 0, len;
-	int err =3D -EINVAL;
+	int err;
 	struct snd_seq_event event;
=20
 	if (!(snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT))
@@ -1014,12 +1016,15 @@ static ssize_t snd_seq_write(struct file *file, con=
st char __user *buf,
 		return -ENXIO;
=20
 	/* allocate the pool now if the pool is not allocated yet */=20
+	mutex_lock(&client->ioctl_mutex);
 	if (client->pool->size > 0 && !snd_seq_write_pool_allocated(client)) {
-		if (snd_seq_pool_init(client->pool) < 0)
-			return -ENOMEM;
+		err =3D snd_seq_pool_init(client->pool);
+		if (err < 0)
+			goto out;
 	}
=20
 	/* only process whole events */
+	err =3D -EINVAL;
 	while (count >=3D sizeof(struct snd_seq_event)) {
 		/* Read in the event header from the user */
 		len =3D sizeof(event);
@@ -1066,7 +1071,7 @@ static ssize_t snd_seq_write(struct file *file, const=
 char __user *buf,
 		/* ok, enqueue it */
 		err =3D snd_seq_client_enqueue_event(client, &event, file,
 						   !(file->f_flags & O_NONBLOCK),
-						   0, 0);
+						   0, 0, &client->ioctl_mutex);
 		if (err < 0)
 			break;
=20
@@ -1077,6 +1082,8 @@ static ssize_t snd_seq_write(struct file *file, const=
 char __user *buf,
 		written +=3D len;
 	}
=20
+ out:
+	mutex_unlock(&client->ioctl_mutex);
 	return written ? written : err;
 }
=20
@@ -1913,6 +1920,9 @@ static int snd_seq_ioctl_set_client_pool(struct snd_s=
eq_client *client,
 	    (! snd_seq_write_pool_allocated(client) ||
 	     info.output_pool !=3D client->pool->size)) {
 		if (snd_seq_write_pool_allocated(client)) {
+			/* is the pool in use? */
+			if (atomic_read(&client->pool->counter))
+				return -EBUSY;
 			/* remove all existing cells */
 			snd_seq_pool_mark_closing(client->pool);
 			snd_seq_queue_client_leave_cells(client->number);
@@ -2336,7 +2346,8 @@ static int kernel_client_enqueue(int client, struct s=
nd_seq_event *ev,
 	if (! cptr->accept_output)
 		result =3D -EPERM;
 	else /* send it */
-		result =3D snd_seq_client_enqueue_event(cptr, ev, file, blocking, atomic=
, hop);
+		result =3D snd_seq_client_enqueue_event(cptr, ev, file, blocking,
+						      atomic, hop, NULL);
=20
 	snd_seq_client_unlock(cptr);
 	return result;
diff --git a/sound/core/seq/seq_fifo.c b/sound/core/seq/seq_fifo.c
index 490b697e83ff..9d429bc09538 100644
--- a/sound/core/seq/seq_fifo.c
+++ b/sound/core/seq/seq_fifo.c
@@ -125,9 +125,9 @@ int snd_seq_fifo_event_in(struct snd_seq_fifo *f,
 		return -EINVAL;
=20
 	snd_use_lock_use(&f->use_lock);
-	err =3D snd_seq_event_dup(f->pool, event, &cell, 1, NULL); /* always non-=
blocking */
+	err =3D snd_seq_event_dup(f->pool, event, &cell, 1, NULL, NULL); /* alway=
s non-blocking */
 	if (err < 0) {
-		if (err =3D=3D -ENOMEM)
+		if ((err =3D=3D -ENOMEM) || (err =3D=3D -EAGAIN))
 			atomic_inc(&f->overflow);
 		snd_use_lock_free(&f->use_lock);
 		return err;
diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 6fc211dcb342..ce5d003cd8ec 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -221,7 +221,8 @@ void snd_seq_cell_free(struct snd_seq_event_cell * cell=
)
  */
 static int snd_seq_cell_alloc(struct snd_seq_pool *pool,
 			      struct snd_seq_event_cell **cellp,
-			      int nonblock, struct file *file)
+			      int nonblock, struct file *file,
+			      struct mutex *mutexp)
 {
 	struct snd_seq_event_cell *cell;
 	unsigned long flags;
@@ -245,7 +246,11 @@ static int snd_seq_cell_alloc(struct snd_seq_pool *poo=
l,
 		set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&pool->output_sleep, &wait);
 		spin_unlock_irq(&pool->lock);
+		if (mutexp)
+			mutex_unlock(mutexp);
 		schedule();
+		if (mutexp)
+			mutex_lock(mutexp);
 		spin_lock_irq(&pool->lock);
 		remove_wait_queue(&pool->output_sleep, &wait);
 		/* interrupted? */
@@ -288,7 +293,7 @@ static int snd_seq_cell_alloc(struct snd_seq_pool *pool=
,
  */
 int snd_seq_event_dup(struct snd_seq_pool *pool, struct snd_seq_event *eve=
nt,
 		      struct snd_seq_event_cell **cellp, int nonblock,
-		      struct file *file)
+		      struct file *file, struct mutex *mutexp)
 {
 	int ncells, err;
 	unsigned int extlen;
@@ -305,7 +310,7 @@ int snd_seq_event_dup(struct snd_seq_pool *pool, struct=
 snd_seq_event *event,
 	if (ncells >=3D pool->total_elements)
 		return -ENOMEM;
=20
-	err =3D snd_seq_cell_alloc(pool, &cell, nonblock, file);
+	err =3D snd_seq_cell_alloc(pool, &cell, nonblock, file, mutexp);
 	if (err < 0)
 		return err;
=20
@@ -331,7 +336,8 @@ int snd_seq_event_dup(struct snd_seq_pool *pool, struct=
 snd_seq_event *event,
 			int size =3D sizeof(struct snd_seq_event);
 			if (len < size)
 				size =3D len;
-			err =3D snd_seq_cell_alloc(pool, &tmp, nonblock, file);
+			err =3D snd_seq_cell_alloc(pool, &tmp, nonblock, file,
+						 mutexp);
 			if (err < 0)
 				goto __error;
 			if (cell->event.data.ext.ptr =3D=3D NULL)
diff --git a/sound/core/seq/seq_memory.h b/sound/core/seq/seq_memory.h
index 32f959c17786..3abe306c394a 100644
--- a/sound/core/seq/seq_memory.h
+++ b/sound/core/seq/seq_memory.h
@@ -66,7 +66,8 @@ struct snd_seq_pool {
 void snd_seq_cell_free(struct snd_seq_event_cell *cell);
=20
 int snd_seq_event_dup(struct snd_seq_pool *pool, struct snd_seq_event *eve=
nt,
-		      struct snd_seq_event_cell **cellp, int nonblock, struct file *file=
);
+		      struct snd_seq_event_cell **cellp, int nonblock,
+		      struct file *file, struct mutex *mutexp);
=20
 /* return number of unused (free) cells */
 static inline int snd_seq_unused_cells(struct snd_seq_pool *pool)
diff --git a/sound/core/seq/seq_prioq.c b/sound/core/seq/seq_prioq.c
index 29896ab23403..15c5d67c8288 100644
--- a/sound/core/seq/seq_prioq.c
+++ b/sound/core/seq/seq_prioq.c
@@ -89,7 +89,7 @@ void snd_seq_prioq_delete(struct snd_seq_prioq **fifo)
 	if (f->cells > 0) {
 		/* drain prioQ */
 		while (f->cells > 0)
-			snd_seq_cell_free(snd_seq_prioq_cell_out(f));
+			snd_seq_cell_free(snd_seq_prioq_cell_out(f, NULL));
 	}
 =09
 	kfree(f);
@@ -216,8 +216,18 @@ int snd_seq_prioq_cell_in(struct snd_seq_prioq * f,
 	return 0;
 }
=20
+/* return 1 if the current time >=3D event timestamp */
+static int event_is_ready(struct snd_seq_event *ev, void *current_time)
+{
+	if ((ev->flags & SNDRV_SEQ_TIME_STAMP_MASK) =3D=3D SNDRV_SEQ_TIME_STAMP_T=
ICK)
+		return snd_seq_compare_tick_time(current_time, &ev->time.tick);
+	else
+		return snd_seq_compare_real_time(current_time, &ev->time.time);
+}
+
 /* dequeue cell from prioq */
-struct snd_seq_event_cell *snd_seq_prioq_cell_out(struct snd_seq_prioq *f)
+struct snd_seq_event_cell *snd_seq_prioq_cell_out(struct snd_seq_prioq *f,
+						  void *current_time)
 {
 	struct snd_seq_event_cell *cell;
 	unsigned long flags;
@@ -229,6 +239,8 @@ struct snd_seq_event_cell *snd_seq_prioq_cell_out(struc=
t snd_seq_prioq *f)
 	spin_lock_irqsave(&f->lock, flags);
=20
 	cell =3D f->head;
+	if (cell && current_time && !event_is_ready(&cell->event, current_time))
+		cell =3D NULL;
 	if (cell) {
 		f->head =3D cell->next;
=20
@@ -255,17 +267,6 @@ int snd_seq_prioq_avail(struct snd_seq_prioq * f)
 }
=20
=20
-/* peek at cell at the head of the prioq */
-struct snd_seq_event_cell *snd_seq_prioq_cell_peek(struct snd_seq_prioq * =
f)
-{
-	if (f =3D=3D NULL) {
-		snd_printd("oops: snd_seq_prioq_cell_in() called with NULL prioq\n");
-		return NULL;
-	}
-	return f->head;
-}
-
-
 static inline int prioq_match(struct snd_seq_event_cell *cell,
 			      int client, int timestamp)
 {
diff --git a/sound/core/seq/seq_prioq.h b/sound/core/seq/seq_prioq.h
index d38bb78d9345..2c315ca10fc4 100644
--- a/sound/core/seq/seq_prioq.h
+++ b/sound/core/seq/seq_prioq.h
@@ -44,14 +44,12 @@ void snd_seq_prioq_delete(struct snd_seq_prioq **fifo);
 int snd_seq_prioq_cell_in(struct snd_seq_prioq *f, struct snd_seq_event_ce=
ll *cell);
=20
 /* dequeue cell from prioq */=20
-struct snd_seq_event_cell *snd_seq_prioq_cell_out(struct snd_seq_prioq *f)=
;
+struct snd_seq_event_cell *snd_seq_prioq_cell_out(struct snd_seq_prioq *f,
+						  void *current_time);
=20
 /* return number of events available in prioq */
 int snd_seq_prioq_avail(struct snd_seq_prioq *f);
=20
-/* peek at cell at the head of the prioq */
-struct snd_seq_event_cell *snd_seq_prioq_cell_peek(struct snd_seq_prioq *f=
);
-
 /* client left queue */
 void snd_seq_prioq_leave(struct snd_seq_prioq *f, int client, int timestam=
p);       =20
=20
diff --git a/sound/core/seq/seq_queue.c b/sound/core/seq/seq_queue.c
index 17fe04d892f9..cfe942cb5274 100644
--- a/sound/core/seq/seq_queue.c
+++ b/sound/core/seq/seq_queue.c
@@ -275,30 +275,20 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int=
 atomic, int hop)
=20
       __again:
 	/* Process tick queue... */
-	while ((cell =3D snd_seq_prioq_cell_peek(q->tickq)) !=3D NULL) {
-		if (snd_seq_compare_tick_time(&q->timer->tick.cur_tick,
-					      &cell->event.time.tick)) {
-			cell =3D snd_seq_prioq_cell_out(q->tickq);
-			if (cell)
-				snd_seq_dispatch_event(cell, atomic, hop);
-		} else {
-			/* event remains in the queue */
+	for (;;) {
+		cell =3D snd_seq_prioq_cell_out(q->tickq,
+					      &q->timer->tick.cur_tick);
+		if (!cell)
 			break;
-		}
+		snd_seq_dispatch_event(cell, atomic, hop);
 	}
=20
-
 	/* Process time queue... */
-	while ((cell =3D snd_seq_prioq_cell_peek(q->timeq)) !=3D NULL) {
-		if (snd_seq_compare_real_time(&q->timer->cur_time,
-					      &cell->event.time.time)) {
-			cell =3D snd_seq_prioq_cell_out(q->timeq);
-			if (cell)
-				snd_seq_dispatch_event(cell, atomic, hop);
-		} else {
-			/* event remains in the queue */
+	for (;;) {
+		cell =3D snd_seq_prioq_cell_out(q->timeq, &q->timer->cur_time);
+		if (!cell)
 			break;
-		}
+		snd_seq_dispatch_event(cell, atomic, hop);
 	}
=20
 	/* free lock */
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 70012368df87..4e01b027f746 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -195,6 +195,11 @@ static inline void loopback_timer_stop(struct loopback=
_pcm *dpcm)
 	spin_unlock(&dpcm->timer_lock);
 }
=20
+static inline void loopback_timer_stop_sync(struct loopback_pcm *dpcm)
+{
+	del_timer_sync(&dpcm->timer);
+}
+
 #define CABLE_VALID_PLAYBACK	(1 << SNDRV_PCM_STREAM_PLAYBACK)
 #define CABLE_VALID_CAPTURE	(1 << SNDRV_PCM_STREAM_CAPTURE)
 #define CABLE_VALID_BOTH	(CABLE_VALID_PLAYBACK|CABLE_VALID_CAPTURE)
@@ -328,6 +333,8 @@ static int loopback_prepare(struct snd_pcm_substream *s=
ubstream)
 	struct loopback_cable *cable =3D dpcm->cable;
 	int bps, salign;
=20
+	loopback_timer_stop_sync(dpcm);
+
 	salign =3D (snd_pcm_format_width(runtime->format) *
 						runtime->channels) / 8;
 	bps =3D salign * runtime->rate;
@@ -649,7 +656,9 @@ static void free_cable(struct snd_pcm_substream *substr=
eam)
 		return;
 	if (cable->streams[!substream->stream]) {
 		/* other stream is still alive */
+		spin_lock_irq(&cable->lock);
 		cable->streams[substream->stream] =3D NULL;
+		spin_unlock_irq(&cable->lock);
 	} else {
 		/* free the cable */
 		loopback->cables[substream->number][dev] =3D NULL;
@@ -690,7 +699,6 @@ static int loopback_open(struct snd_pcm_substream *subs=
tream)
 		loopback->cables[substream->number][dev] =3D cable;
 	}
 	dpcm->cable =3D cable;
-	cable->streams[substream->stream] =3D dpcm;
=20
 	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
=20
@@ -722,6 +730,11 @@ static int loopback_open(struct snd_pcm_substream *sub=
stream)
 		runtime->hw =3D loopback_pcm_hardware;
 	else
 		runtime->hw =3D cable->hw;
+
+	spin_lock_irq(&cable->lock);
+	cable->streams[substream->stream] =3D dpcm;
+	spin_unlock_irq(&cable->lock);
+
  unlock:
 	if (err < 0) {
 		free_cable(substream);
@@ -736,7 +749,7 @@ static int loopback_close(struct snd_pcm_substream *sub=
stream)
 	struct loopback *loopback =3D substream->private_data;
 	struct loopback_pcm *dpcm =3D substream->runtime->private_data;
=20
-	loopback_timer_stop(dpcm);
+	loopback_timer_stop_sync(dpcm);
 	mutex_lock(&loopback->cable_lock);
 	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index 726bd651a105..d79aa7c83d46 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -91,8 +91,8 @@ static unsigned short au1xac97c_ac97_read(struct snd_ac97=
 *ac97,
 	do {
 		mutex_lock(&ctx->lock);
=20
-		tmo =3D 5;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		tmo =3D 6;
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			udelay(21);	/* wait an ac97 frame time */
 		if (!tmo) {
 			pr_debug("ac97rd timeout #1\n");
@@ -105,7 +105,7 @@ static unsigned short au1xac97c_ac97_read(struct snd_ac=
97 *ac97,
 		 * poll, Forrest, poll...
 		 */
 		tmo =3D 0x10000;
-		while ((RD(ctx, AC97_STATUS) & STAT_CP) && tmo--)
+		while ((RD(ctx, AC97_STATUS) & STAT_CP) && --tmo)
 			asm volatile ("nop");
 		data =3D RD(ctx, AC97_CMDRESP);
=20
diff --git a/sound/soc/nuc900/nuc900-ac97.c b/sound/soc/nuc900/nuc900-ac97.=
c
index a4e3237956e2..9c70feae715b 100644
--- a/sound/soc/nuc900/nuc900-ac97.c
+++ b/sound/soc/nuc900/nuc900-ac97.c
@@ -66,7 +66,7 @@ static unsigned short nuc900_ac97_read(struct snd_ac97 *a=
c97,
=20
 	/* polling the AC_R_FINISH */
 	while (!(AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_R_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
=20
 	if (!timeout) {
@@ -120,7 +120,7 @@ static void nuc900_ac97_write(struct snd_ac97 *ac97, un=
signed short reg,
=20
 	/* polling the AC_W_FINISH */
 	while ((AUDIO_READ(nuc900_audio->mmio + ACTL_ACCON) & AC_W_FINISH)
-								&& timeout--)
+								&& --timeout)
 		mdelay(1);
=20
 	if (!timeout)
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 172799a4f41e..e3f0c7d5e6bc 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2766,4 +2766,51 @@ AU0828_DEVICE(0x2040, 0x7270, "Hauppauge", "HVR-950Q=
"),
 	}
 },
=20
+{
+	/*
+	 * Bower's & Wilkins PX headphones only support the 48 kHz sample rate
+	 * even though it advertises more. The capture interface doesn't work
+	 * even on windows.
+	 */
+	USB_DEVICE(0x19b5, 0x0021),
+	.driver_info =3D (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.ifnum =3D QUIRK_ANY_INTERFACE,
+		.type =3D QUIRK_COMPOSITE,
+		.data =3D (const struct snd_usb_audio_quirk[]) {
+			{
+				.ifnum =3D 0,
+				.type =3D QUIRK_AUDIO_STANDARD_MIXER,
+			},
+			/* Capture */
+			{
+				.ifnum =3D 1,
+				.type =3D QUIRK_IGNORE_INTERFACE,
+			},
+			/* Playback */
+			{
+				.ifnum =3D 2,
+				.type =3D QUIRK_AUDIO_FIXED_ENDPOINT,
+				.data =3D &(const struct audioformat) {
+					.formats =3D SNDRV_PCM_FMTBIT_S16_LE,
+					.channels =3D 2,
+					.iface =3D 2,
+					.altsetting =3D 1,
+					.altset_idx =3D 1,
+					.attributes =3D UAC_EP_CS_ATTR_FILL_MAX |
+						UAC_EP_CS_ATTR_SAMPLE_RATE,
+					.endpoint =3D 0x03,
+					.ep_attr =3D USB_ENDPOINT_XFER_ISOC,
+					.rates =3D SNDRV_PCM_RATE_48000,
+					.rate_min =3D 48000,
+					.rate_max =3D 48000,
+					.nr_rates =3D 1,
+					.rate_table =3D (unsigned int[]) {
+						48000
+					}
+				}
+			},
+		}
+	}
+},
+
 #undef USB_DEVICE_VENDOR_SPEC
=0D
--=-W9vyz0jz2fY6yPFuuJmg--

--=-QPz5tfK+Qmc29jfeNm4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlsRKKkACgkQ57/I7JWG
EQnUnxAAreZW/qrY9cBqwHHDVATTWqi/MnUt9PNkujUX6I8GG8M/t9mOF5JVdzZa
vnZTZ/k7zNCl4byvqBClykQuGLpOtWbOdbbiZMFb44Bs11mhyhO44+A0CylxZWKI
9YJpfTNbLwIfPfBwb6k6P1xTQ8w6lxNzCdsQiCs6VmK6ObSbSJ1gCxDaZLQ3WUZ7
7kotS4QvObZPop6wBamXiDf6PKuBN2w9FntHMx3DmBMFFCFeNMI4DoRZ89nSJmLk
tlqJSlUQMciyGWzyur6VXkaxd3ICvH8HIeTjdEgL99yN0GPDGonZL0g5dSzOrpmT
H6+NbTfgK0xQh2xdBJg0fv22AVdjXTPtSNLyjIJytOmsbwUt0E1kFLsHn4bThW9S
tN0QmGWZefIL1pVIL/brbiei1VqfPNUhWQGb320ujvDJFfuPUlncpDgsoVKeblke
KyahHR2LA0c0uCFFAxxD7XdKk9f5dF6dDvImEAGPNzHYEhcFiujcAV04BlHjrwuh
AmAvoB+zoiDV2T16olpCqbz0w83NlydavGuSye792WoS5ZS2xLG+pFUB8RbmMZKM
K7r4H3dsQ8To1oGnwpcIfIGdrBypSotX8F2+cFOpDZenhvLJsKdgr24VJ3vg2WYv
E55udj/nWPJt1sLHE7YRdht8kRBP2PCK8WU7Jr0JenP8OYTu080=
=ZwN9
-----END PGP SIGNATURE-----

--=-QPz5tfK+Qmc29jfeNm4c--
