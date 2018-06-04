Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751858AbeFDBMV (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:12:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43410 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFDBMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:12:18 -0400
Date: Mon, 4 Jun 2018 02:12:17 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] vfs, pile 3
Message-ID: <20180604011217.GF30522@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Christoph's proc_create_... cleanups series.

The following changes since commit 67b8d5c7081221efa252e111cd52532ec6d4266f:

  Linux 4.17-rc5 (2018-05-13 16:15:17 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git hch.procfs

for you to fetch changes up to 5ef03dbd91855544cd4c7c1910c3ef5226ee87e8:

  xfs, proc: hide unused xfs procfs helpers (2018-05-25 20:43:08 -0400)

----------------------------------------------------------------
Arnd Bergmann (1):
      xfs, proc: hide unused xfs procfs helpers

Christoph Hellwig (43):
      net/can: single_open_net needs to be paired with single_release_net
      proc: introduce a proc_pid_ns helper
      proc: don't detour through seq->private to get the inode
      proc: simplify proc_register calling conventions
      proc: add a proc_create_reg helper
      proc: introduce proc_create_seq{,_data}
      proc: introduce proc_create_seq_private
      proc: introduce proc_create_single{,_data}
      ipv{4,6}/udp{,lite}: simplify proc registration
      ipv{4,6}/tcp: simplify procfs registration
      ipv{4,6}/ping: simplify proc file creation
      ipv{4,6}/raw: simplify ѕeq_file code
      ipv6/flowlabel: simplify pid namespace lookup
      net/kcm: simplify proc registration
      netfilter/x_tables: simplify ѕeq_file code
      net: move seq_file_single_net to <linux/seq_file_net.h>
      proc: introduce proc_create_net{,_data}
      proc: introduce proc_create_net_single
      acpi/battery: simplify procfs code
      sgi-gru: simplify procfs code
      megaraid: simplify procfs code
      sg: simplify procfs code
      afs: simplify procfs code
      ext4: simplify procfs code
      jfs: simplify procfs code
      staging/rtl8192u: simplify procfs code
      resource: switch to proc_create_seq_data
      drbd: switch to proc_create_single
      rtc/proc: switch to proc_create_single_data
      bonding: switch to proc_create_seq_data
      hostap: switch to proc_create_{seq,single}_data
      neigh: switch to proc_create_seq_data
      netfilter/xt_hashlimit: switch to proc_create_{seq,single}_data
      netfilter/x_tables: switch to proc_create_seq_private
      bluetooth: switch to proc_create_seq_data
      atm: simplify procfs code
      atm: switch to proc_create_seq_private
      isdn: replace ->proc_fops with ->proc_show
      ide: remove ide_driver_proc_write
      ide: replace ->proc_fops with ->proc_show
      tty: replace ->proc_fops with ->proc_show
      proc: update SIZEOF_PDE_INLINE_NAME for the new pde fields
      isdn/gigaset: add back gigaset_procinfo assignment

 arch/arm/kernel/dma.c                              |  14 +-
 arch/arm/kernel/swp_emulate.c                      |  15 +-
 arch/arm/mach-rpc/ecard.c                          |  16 +-
 arch/ia64/hp/common/sba_iommu.c                    |  15 +-
 arch/ia64/hp/sim/simserial.c                       |  15 +-
 arch/ia64/kernel/palinfo.c                         |  16 +-
 arch/ia64/kernel/perfmon.c                         |  16 +-
 arch/ia64/kernel/salinfo.c                         |  42 ++---
 arch/ia64/sn/kernel/sn2/prominfo_proc.c            |  32 +---
 arch/ia64/sn/kernel/sn2/sn_proc_fs.c               |  62 +------
 arch/m68k/kernel/setup_mm.c                        |  14 +-
 arch/mips/pci/ops-pmcmsp.c                         |  28 +---
 arch/mips/sibyte/common/bus_watcher.c              |  16 +-
 arch/parisc/kernel/pci-dma.c                       |  17 +-
 arch/parisc/kernel/pdc_chassis.c                   |  14 +-
 arch/powerpc/kernel/eeh.c                          |  14 +-
 arch/powerpc/kernel/rtas-proc.c                    |  32 +---
 arch/powerpc/platforms/cell/spufs/sched.c          |  14 +-
 arch/s390/kernel/sysinfo.c                         |  28 +---
 arch/sh/drivers/dma/dma-api.c                      |  14 +-
 arch/sparc/kernel/ioport.c                         |  19 +--
 arch/um/drivers/ubd_kern.c                         |  16 +-
 arch/x86/kernel/apm_32.c                           |  15 +-
 arch/xtensa/platforms/iss/console.c                |  15 +-
 block/genhd.c                                      |  28 +---
 crypto/proc.c                                      |  14 +-
 drivers/acpi/ac.c                                  |  21 +--
 drivers/acpi/battery.c                             | 121 +++-----------
 drivers/acpi/button.c                              |  19 +--
 drivers/block/DAC960.c                             |  49 +-----
 drivers/block/drbd/drbd_int.h                      |   2 +-
 drivers/block/drbd/drbd_main.c                     |   3 +-
 drivers/block/drbd/drbd_proc.c                     |  34 +---
 drivers/block/pktcdvd.c                            |  14 +-
 drivers/block/ps3vram.c                            |  17 +-
 drivers/char/apm-emulation.c                       |  15 +-
 drivers/char/ds1620.c                              |  14 +-
 drivers/char/efirtc.c                              |  15 +-
 drivers/char/misc.c                                |  15 +-
 drivers/char/nvram.c                               |  15 +-
 drivers/char/pcmcia/synclink_cs.c                  |  15 +-
 drivers/char/rtc.c                                 |  19 +--
 drivers/char/toshiba.c                             |  15 +-
 drivers/connector/connector.c                      |  15 +-
 drivers/ide/ide-cd.c                               |  15 +-
 drivers/ide/ide-disk_proc.c                        |  62 +------
 drivers/ide/ide-floppy_proc.c                      |  17 +-
 drivers/ide/ide-proc.c                             | 182 ++-------------------
 drivers/ide/ide-tape.c                             |  17 +-
 drivers/input/misc/hp_sdc_rtc.c                    |  14 +-
 drivers/isdn/capi/capi.c                           |  30 +---
 drivers/isdn/capi/capidrv.c                        |  15 +-
 drivers/isdn/capi/kcapi.c                          |   3 +-
 drivers/isdn/capi/kcapi_proc.c                     |  80 +--------
 drivers/isdn/gigaset/capi.c                        |  15 +-
 drivers/isdn/hardware/avm/avmcard.h                |   4 +-
 drivers/isdn/hardware/avm/b1.c                     |  17 +-
 drivers/isdn/hardware/avm/b1dma.c                  |  17 +-
 drivers/isdn/hardware/avm/b1isa.c                  |   2 +-
 drivers/isdn/hardware/avm/b1pci.c                  |   4 +-
 drivers/isdn/hardware/avm/b1pcmcia.c               |   2 +-
 drivers/isdn/hardware/avm/c4.c                     |  15 +-
 drivers/isdn/hardware/avm/t1isa.c                  |   2 +-
 drivers/isdn/hardware/avm/t1pci.c                  |   2 +-
 drivers/isdn/hardware/eicon/capimain.c             |  15 +-
 drivers/isdn/hardware/eicon/diva_didd.c            |  17 +-
 drivers/isdn/hardware/eicon/divasi.c               |  17 +-
 drivers/isdn/hysdn/hycapi.c                        |  15 +-
 drivers/macintosh/via-pmu.c                        |  57 ++-----
 drivers/media/pci/saa7164/saa7164-core.c           |  14 +-
 drivers/media/pci/zoran/videocodec.c               |  16 +-
 drivers/message/fusion/mptbase.c                   |  57 ++-----
 drivers/misc/sgi-gru/gruprocfs.c                   |  81 ++-------
 drivers/mmc/core/sdio_uart.c                       |  15 +-
 drivers/mtd/mtdcore.c                              |  14 +-
 drivers/net/bonding/bond_procfs.c                  |  36 +---
 drivers/net/hamradio/bpqether.c                    |  16 +-
 drivers/net/hamradio/scc.c                         |  17 +-
 drivers/net/hamradio/yam.c                         |  16 +-
 drivers/net/ppp/pppoe.c                            |  18 +-
 drivers/net/wireless/atmel/atmel.c                 |  15 +-
 drivers/net/wireless/intersil/hostap/hostap_ap.c   |  86 ++--------
 drivers/net/wireless/intersil/hostap/hostap_hw.c   |  17 +-
 drivers/net/wireless/intersil/hostap/hostap_proc.c | 143 +++-------------
 drivers/net/wireless/ray_cs.c                      |  15 +-
 drivers/nubus/proc.c                               |  51 +-----
 drivers/parisc/ccio-dma.c                          |  34 +---
 drivers/parisc/sba_iommu.c                         |  32 +---
 drivers/pci/proc.c                                 |  17 +-
 drivers/platform/x86/toshiba_acpi.c                |  17 +-
 drivers/pnp/pnpbios/proc.c                         |  78 +--------
 drivers/rtc/rtc-proc.c                             |  33 +---
 drivers/s390/block/dasd_proc.c                     |  17 +-
 drivers/s390/char/tape_proc.c                      |  19 +--
 drivers/scsi/megaraid.c                            | 140 ++++------------
 drivers/scsi/megaraid.h                            |  12 --
 drivers/scsi/sg.c                                  | 124 ++------------
 drivers/staging/comedi/proc.c                      |  18 +-
 drivers/staging/fwserial/fwserial.c                |  15 +-
 drivers/staging/ipx/ipx_proc.c                     |  45 +----
 drivers/staging/rtl8192u/r8192U_core.c             |  67 ++------
 drivers/tty/amiserial.c                            |  15 +-
 drivers/tty/cyclades.c                             |  15 +-
 drivers/tty/serial/serial_core.c                   |  15 +-
 drivers/tty/synclink.c                             |  15 +-
 drivers/tty/synclink_gt.c                          |  15 +-
 drivers/tty/synclinkmp.c                           |  15 +-
 drivers/tty/tty_ldisc.c                            |  15 +-
 drivers/usb/gadget/udc/at91_udc.c                  |  16 +-
 drivers/usb/gadget/udc/fsl_udc_core.c              |  18 +-
 drivers/usb/gadget/udc/goku_udc.c                  |  18 +-
 drivers/usb/gadget/udc/omap_udc.c                  |  15 +-
 drivers/usb/serial/usb-serial.c                    |  15 +-
 drivers/video/fbdev/core/fbmem.c                   |  15 +-
 drivers/video/fbdev/via/viafbdev.c                 |  17 +-
 drivers/zorro/proc.c                               |  17 +-
 fs/afs/proc.c                                      | 134 ++-------------
 fs/cachefiles/proc.c                               |  19 +--
 fs/cifs/cifs_debug.c                               |  15 +-
 fs/ext4/ext4.h                                     |   2 +-
 fs/ext4/mballoc.c                                  |  29 +---
 fs/ext4/sysfs.c                                    |  49 +-----
 fs/f2fs/sysfs.c                                    |  29 +---
 fs/filesystems.c                                   |  14 +-
 fs/fscache/histogram.c                             |  17 +-
 fs/fscache/internal.h                              |   5 +-
 fs/fscache/proc.c                                  |   8 +-
 fs/fscache/stats.c                                 |  17 +-
 fs/jfs/jfs_debug.c                                 |  43 ++---
 fs/jfs/jfs_debug.h                                 |  10 +-
 fs/jfs/jfs_logmgr.c                                |  14 +-
 fs/jfs/jfs_metapage.c                              |  14 +-
 fs/jfs/jfs_txnmgr.c                                |  28 +---
 fs/jfs/jfs_xtree.c                                 |  14 +-
 fs/locks.c                                         |  16 +-
 fs/nfs/client.c                                    |  43 +----
 fs/proc/array.c                                    |  23 +--
 fs/proc/base.c                                     |  18 +-
 fs/proc/cmdline.c                                  |  14 +-
 fs/proc/consoles.c                                 |  14 +-
 fs/proc/devices.c                                  |  14 +-
 fs/proc/generic.c                                  | 148 ++++++++++++-----
 fs/proc/internal.h                                 |  13 +-
 fs/proc/interrupts.c                               |  14 +-
 fs/proc/loadavg.c                                  |  14 +-
 fs/proc/meminfo.c                                  |  14 +-
 fs/proc/nommu.c                                    |  14 +-
 fs/proc/proc_net.c                                 | 104 ++++++++----
 fs/proc/proc_tty.c                                 |  22 +--
 fs/proc/self.c                                     |   4 +-
 fs/proc/softirqs.c                                 |  14 +-
 fs/proc/thread_self.c                              |   4 +-
 fs/proc/uptime.c                                   |  14 +-
 fs/proc/version.c                                  |  14 +-
 fs/reiserfs/procfs.c                               |  16 +-
 fs/xfs/xfs_stats.c                                 |  33 +---
 include/linux/atalk.h                              |   7 +-
 include/linux/ide.h                                |   6 +-
 include/linux/isdn/capilli.h                       |   2 +-
 include/linux/proc_fs.h                            |  39 +++++
 include/linux/seq_file_net.h                       |  19 ++-
 include/linux/tty.h                                |   3 +-
 include/linux/tty_driver.h                         |   2 +-
 include/net/ax25.h                                 |   5 +-
 include/net/ip6_fib.h                              |  10 +-
 include/net/ip_vs.h                                |  12 --
 include/net/netrom.h                               |   5 +-
 include/net/phonet/pn_dev.h                        |   4 +-
 include/net/ping.h                                 |  11 --
 include/net/raw.h                                  |   4 -
 include/net/rose.h                                 |   6 +-
 include/net/tcp.h                                  |  11 +-
 include/net/udp.h                                  |  20 +--
 kernel/cgroup/cgroup-internal.h                    |   2 +-
 kernel/cgroup/cgroup-v1.c                          |  14 +-
 kernel/cgroup/cgroup.c                             |   2 +-
 kernel/dma.c                                       |  14 +-
 kernel/exec_domain.c                               |  14 +-
 kernel/irq/proc.c                                  |  82 ++--------
 kernel/locking/lockdep_proc.c                      |  45 +----
 kernel/resource.c                                  |  43 +----
 kernel/sched/debug.c                               |  28 +---
 kernel/sched/stats.c                               |  15 +-
 kernel/time/timer_list.c                           |  16 +-
 mm/vmalloc.c                                       |  21 +--
 mm/vmstat.c                                        |  56 +------
 net/8021q/vlanproc.c                               |  39 +----
 net/appletalk/aarp.c                               |  20 +--
 net/appletalk/atalk_proc.c                         |  51 +-----
 net/atm/br2684.c                                   |  14 +-
 net/atm/clip.c                                     |  17 +-
 net/atm/lec.c                                      |  15 +-
 net/atm/proc.c                                     | 131 ++-------------
 net/ax25/af_ax25.c                                 |  21 +--
 net/ax25/ax25_route.c                              |  15 +-
 net/ax25/ax25_uid.c                                |  15 +-
 net/bluetooth/af_bluetooth.c                       |  40 +----
 net/bluetooth/cmtp/capi.c                          |  14 +-
 net/can/bcm.c                                      |  16 +-
 net/can/proc.c                                     | 127 +++-----------
 net/core/neighbour.c                               |  31 +---
 net/core/net-procfs.c                              |  65 +-------
 net/core/sock.c                                    |  16 +-
 net/decnet/af_decnet.c                             |  17 +-
 net/decnet/dn_dev.c                                |  15 +-
 net/decnet/dn_neigh.c                              |  18 +-
 net/decnet/dn_route.c                              |  19 +--
 net/ipv4/arp.c                                     |  17 +-
 net/ipv4/fib_trie.c                                |  48 +-----
 net/ipv4/igmp.c                                    |  33 +---
 net/ipv4/ipconfig.c                                |  14 +-
 net/ipv4/ipmr.c                                    |  32 +---
 net/ipv4/ping.c                                    |  52 +-----
 net/ipv4/proc.c                                    |  48 +-----
 net/ipv4/raw.c                                     |  45 ++---
 net/ipv4/route.c                                   |  15 +-
 net/ipv4/tcp_ipv4.c                                |  82 +++-------
 net/ipv4/udp.c                                     |  94 ++++-------
 net/ipv4/udplite.c                                 |  21 +--
 net/ipv6/addrconf.c                                |  16 +-
 net/ipv6/anycast.c                                 |  16 +-
 net/ipv6/ip6_fib.c                                 |  18 +-
 net/ipv6/ip6_flowlabel.c                           |  42 +----
 net/ipv6/ip6mr.c                                   |  32 +---
 net/ipv6/mcast.c                                   |  34 +---
 net/ipv6/ping.c                                    |  23 ++-
 net/ipv6/proc.c                                    |  48 +-----
 net/ipv6/raw.c                                     |  15 +-
 net/ipv6/route.c                                   |  26 +--
 net/ipv6/tcp_ipv6.c                                |  22 ++-
 net/ipv6/udp.c                                     |  23 ++-
 net/ipv6/udplite.c                                 |  22 +--
 net/kcm/kcmproc.c                                  |  83 ++--------
 net/key/af_key.c                                   |  16 +-
 net/l2tp/l2tp_ppp.c                                |  22 +--
 net/llc/llc_proc.c                                 |  28 +---
 net/netfilter/ipvs/ip_vs_app.c                     |  16 +-
 net/netfilter/ipvs/ip_vs_conn.c                    |  35 +---
 net/netfilter/ipvs/ip_vs_ctl.c                     |  47 +-----
 net/netfilter/nf_conntrack_expect.c                |  17 +-
 net/netfilter/nf_conntrack_standalone.c            |  33 +---
 net/netfilter/nf_log.c                             |  19 +--
 net/netfilter/nf_synproxy_core.c                   |  17 +-
 net/netfilter/nfnetlink_log.c                      |  18 +-
 net/netfilter/nfnetlink_queue.c                    |  18 +-
 net/netfilter/x_tables.c                           |  95 ++---------
 net/netfilter/xt_hashlimit.c                       |  92 ++---------
 net/netlink/af_netlink.c                           |  18 +-
 net/netrom/af_netrom.c                             |  18 +-
 net/netrom/nr_route.c                              |  29 +---
 net/packet/af_packet.c                             |  17 +-
 net/phonet/pn_dev.c                                |   6 +-
 net/phonet/socket.c                                |  30 +---
 net/rose/af_rose.c                                 |  26 +--
 net/rose/rose_route.c                              |  44 +----
 net/rxrpc/ar-internal.h                            |   4 +-
 net/rxrpc/net_ns.c                                 |   7 +-
 net/rxrpc/proc.c                                   |  31 +---
 net/sched/sch_api.c                                |  14 +-
 net/sctp/objcnt.c                                  |  16 +-
 net/sctp/proc.c                                    |  71 +-------
 net/unix/af_unix.c                                 |  17 +-
 net/wireless/wext-proc.c                           |  17 +-
 net/x25/x25_proc.c                                 |  48 +-----
 net/xfrm/xfrm_proc.c                               |  16 +-
 security/keys/proc.c                               |  34 +---
 266 files changed, 1230 insertions(+), 6032 deletions(-)
