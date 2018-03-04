Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2908601-1520178213-2-8568851229491369807
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: linux-3.2.100.patch
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520178207; b=L65LVZUjhCMG32hacp3QcIMaydsNqHZVsWoTgMWjlWW3EGc
    ieJWHP5xWPNH07zRX721JUMWWX7a9/2DpgdoP2YkAy7RrFskKv0xbNaAsSeIgNEG
    abAWSLVpa51UNyG8aRmpXXhMUGS+orBqc5MSHIY2tIJNo6cjNg0td/4hdHOwpyL7
    DYvSN1AtbORlsxgYzzvLf3hH9R56HmblfoZgPYHtiFsMhE5I16BPmVxxBAnLw376
    m7pssaLtGOF3abjt/yDM2rBAP7g+MBIrry/fjNrbYKwuC8Y8n9y8uTsFeaoC6Ns3
    GsSJiRI0hQkLVqP/unTyBQLvYOM+61X5txDTUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:mime-version
    :content-type:subject:sender:list-id; s=arctest; t=1520178207;
    bh=c3GC2YrkwcJFiHPDmh1ke1qMDl2DvIGxyApYO6JLjLI=; b=MoOWskXiUR5I
    FcBmcdBIi+Lp3zhgTu1ZW6ACIK8JOgGQwKA3HCiwEXwkgG2YRPvXSpMT7CqFgdlA
    KGOO1lrUpme2krNQ8OmoVHDSDKyy5chqs7/WisC54bdP0PCJfBPNazcZLFb1jer1
    ciev8r1zA/4oBTfIL5noubumbZgUoXJzDs/TsbJuR7pw3WjZh0vKww0JvdlzI1sJ
    T2MVmOuINmhE/VCMuXPiMtzsbAHrn4buIGikHxE0DknEbywcCf2RaPkQwc/A5Pkj
    FRRGF+lV+j3eph9ejJwhByQfCsYa3zQtnJUHQQozLrOCHKVG6EZqc/31s+lTmGJg
    GAkYWK8j6Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752606AbeCDPnX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 10:43:23 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38831 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752565AbeCDPnP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Mar 2018 10:43:15 -0500
Date: Sun, 4 Mar 2018 15:42:58 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc: lwn@lwn.net
Message-ID: <20180304154258.GE8564@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqCDj3hiknadvR6t"
Content-Disposition: inline
X-Mailer: LinuxStableQueue (scripts by bwh)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        shadbolt.decadent.org.uk
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=disabled
        version=3.4.0
Subject: Linux 3.2.100
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--AqCDj3hiknadvR6t
Content-Type: multipart/mixed; boundary="+sHJum3is6Tsg7/J"
Content-Disposition: inline


--+sHJum3is6Tsg7/J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.2.100 kernel.

All users of the 3.2 kernel series should upgrade.

The updated 3.2.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
=2Egit linux-3.2.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git

The diff from 3.2.99 is attached to this message.

Ben.

------------

 Makefile                                           |   7 +-
 arch/m32r/kernel/ptrace.c                          |   7 +-
 arch/s390/include/asm/system.h                     |  18 +-
 arch/s390/kernel/compat_linux.c                    |   1 +
 arch/sh/boards/mach-se/770x/setup.c                |  24 +-
 arch/sh/include/mach-se/mach/se.h                  |   1 +
 arch/x86/include/asm/kvm_host.h                    |   4 +-
 arch/x86/include/asm/traps.h                       |   1 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |   5 +
 arch/x86/kernel/entry_64.S                         |   2 +-
 arch/x86/kvm/lapic.c                               |   2 +-
 arch/x86/kvm/vmx.c                                 |  12 +-
 arch/x86/kvm/x86.c                                 |  38 +-
 crypto/algapi.c                                    |  12 +
 drivers/acpi/apei/erst.c                           |   2 +-
 drivers/acpi/sbshc.c                               |   4 +-
 drivers/base/isa.c                                 |  10 +-
 drivers/crypto/n2_core.c                           |   3 +
 drivers/hwmon/pmbus/pmbus_core.c                   |  21 +-
 drivers/i2c/i2c-core.c                             |  13 +-
 drivers/infiniband/hw/cxgb4/cq.c                   |   6 +-
 drivers/input/mouse/elantech.c                     |   2 +-
 drivers/input/mouse/trackpoint.c                   |   7 +-
 drivers/iommu/intel-iommu.c                        |   8 +-
 drivers/md/dm-mpath.c                              |  34 +-
 drivers/md/dm-snap.c                               |  48 +-
 drivers/md/dm-thin-metadata.c                      |  18 +-
 drivers/md/persistent-data/dm-btree.c              |  19 +-
 drivers/media/dvb/dvb-usb/dibusb-common.c          |  16 +-
 drivers/media/video/Makefile                       |   7 +-
 drivers/media/video/v4l2-compat-ioctl32.c          | 973 +++++++++++++----=
----
 drivers/media/video/v4l2-ioctl.c                   |   6 +-
 drivers/misc/eeprom/at24.c                         |   6 +
 drivers/mmc/host/s3cmci.c                          |   6 +-
 drivers/net/can/ti_hecc.c                          |   3 +
 drivers/net/can/usb/ems_usb.c                      |   2 +
 drivers/net/can/usb/esd_usb2.c                     |   2 +
 .../net/ethernet/freescale/fs_enet/fs_enet-main.c  |  16 +-
 drivers/net/ethernet/freescale/fs_enet/fs_enet.h   |   1 +
 drivers/net/ethernet/intel/e1000e/ich8lan.c        |  10 +-
 drivers/net/ethernet/intel/e1000e/lib.c            |  11 +-
 drivers/net/ethernet/intel/e1000e/netdev.c         |   2 +-
 drivers/net/phy/marvell.c                          |   2 +-
 drivers/net/ppp/pppoe.c                            |  11 +-
 drivers/of/fdt.c                                   |   2 +-
 drivers/parisc/lba_pci.c                           |  33 +
 drivers/pci/pci-driver.c                           |   7 +-
 drivers/scsi/libsas/sas_ata.c                      |   4 -
 drivers/scsi/scsi_lib.c                            |  10 +-
 drivers/staging/usbip/stub_dev.c                   |   3 +-
 drivers/staging/usbip/stub_main.c                  |   5 +-
 drivers/staging/usbip/stub_rx.c                    |   9 +-
 drivers/staging/usbip/stub_tx.c                    |   4 +-
 drivers/staging/usbip/usbip_common.c               |  85 +-
 drivers/staging/usbip/usbip_common.h               |   3 +-
 drivers/staging/usbip/userspace/src/utils.c        |   9 +-
 drivers/staging/usbip/vhci_hcd.c                   |  12 +-
 drivers/staging/usbip/vhci_rx.c                    |  26 +-
 drivers/staging/usbip/vhci_tx.c                    |   3 +-
 drivers/tty/n_tty.c                                |   4 +-
 drivers/tty/serial/8250_pci.c                      |   3 +
 drivers/usb/core/config.c                          |  16 +-
 drivers/usb/core/devio.c                           |  14 +-
 drivers/usb/core/quirks.c                          |   6 +-
 drivers/usb/host/ehci-dbg.c                        |   2 +-
 drivers/usb/host/xhci-mem.c                        |  17 +-
 drivers/usb/host/xhci-ring.c                       |  12 +-
 drivers/usb/mon/mon_bin.c                          |   8 +-
 drivers/usb/serial/cp210x.c                        |   2 +
 drivers/usb/serial/ftdi_sio.c                      |   1 +
 drivers/usb/serial/ftdi_sio_ids.h                  |   6 +
 drivers/usb/serial/option.c                        |  12 +
 drivers/usb/storage/unusual_devs.h                 |   7 +
 fs/btrfs/extent-tree.c                             |  14 +-
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/ext4/namei.c                                    |   4 +
 fs/nfsd/auth.c                                     |   3 +
 include/asm-generic/dma-mapping-broken.h           |   3 -
 include/linux/cred.h                               |   1 +
 include/linux/dma-mapping.h                        |   2 -
 include/linux/fscache.h                            |   2 +-
 include/linux/stddef.h                             |  10 +
 include/linux/usb/ch9.h                            |   2 +
 include/net/red.h                                  |  11 +
 include/net/xfrm.h                                 |   1 +
 include/scsi/libsas.h                              |   9 +-
 kernel/debug/kdb/kdb_io.c                          |   2 +-
 kernel/futex.c                                     |   3 +
 kernel/groups.c                                    |   5 +-
 kernel/hrtimer.c                                   |   2 +
 kernel/posix-timers.c                              |  37 +-
 kernel/trace/ring_buffer.c                         |   6 +-
 kernel/uid16.c                                     |   1 +
 mm/mprotect.c                                      |   6 +-
 net/8021q/vlan.c                                   |   6 +-
 net/batman-adv/bat_iv_ogm.c                        |   4 +-
 net/bridge/br_netlink.c                            |   7 +-
 net/can/af_can.c                                   |  12 +-
 net/dccp/ccids/ccid2.c                             |   3 +
 net/ipv4/esp4.c                                    |   1 +
 net/ipv4/igmp.c                                    |  20 +-
 net/ipv4/raw.c                                     | 119 ++-
 net/ipv4/tcp_ipv4.c                                |   2 +-
 net/ipv4/xfrm4_input.c                             |  11 +-
 net/ipv6/esp6.c                                    |   3 +-
 net/ipv6/tcp_ipv6.c                                |   2 +-
 net/ipv6/xfrm6_input.c                             |   9 +-
 net/key/af_key.c                                   |   8 +
 net/packet/af_packet.c                             |   5 +
 net/rds/rdma.c                                     |   2 +-
 net/sched/sch_choke.c                              |   3 +
 net/sched/sch_gred.c                               |   3 +
 net/sched/sch_red.c                                |   2 +
 net/sctp/socket.c                                  |  27 +-
 net/sunrpc/auth_gss/svcauth_gss.c                  |   1 +
 net/sunrpc/svcauth_unix.c                          |   2 +
 net/wireless/core.c                                |   7 +-
 net/wireless/wext-compat.c                         |   3 +-
 net/xfrm/xfrm_input.c                              |  56 ++
 sound/core/oss/pcm_oss.c                           |  41 +-
 sound/core/oss/pcm_plugin.c                        |  14 +-
 sound/core/pcm.c                                   |   2 +
 sound/core/pcm_lib.c                               |   5 +-
 sound/core/rawmidi.c                               |  15 +-
 sound/core/seq/seq_clientmgr.c                     |  15 +-
 sound/core/seq/seq_timer.c                         |   2 +-
 sound/drivers/aloop.c                              |  98 ++-
 sound/usb/mixer.c                                  |  27 +-
 128 files changed, 1509 insertions(+), 882 deletions(-)

Aaron Ma (2):
      Input: elantech - add new icbody type 15
      Input: trackpoint - force 3 buttons if 0 button is reported

Alexey Kodanev (1):
      dccp: don't restart ccid2_hc_tx_rto_expire() if sk in closed state

Andrew Honig (1):
      KVM: x86: Add memory barrier on vmcs field lookup

Andrzej Hajda (1):
      v4l2-compat-ioctl32: fix alignment for ARM64

Anshuman Khandual (1):
      mm/mprotect: add a cond_resched() inside change_pmd_range()

Arnd Bergmann (1):
      mmc: s3mci: mark debug_regs[] as static

Bart Westgeest (1):
      staging: usbip: removed dead code from receive function

Ben Hutchings (3):
      nfsd: auth: Fix gid sorting when rootsquash enabled
      of: fdt: Fix return with value in void function
      Linux 3.2.100

Benjamin Poirier (2):
      e1000e: Separate signaling for link check/link up
      e1000e: Fix e1000_check_for_copper_link_ich8lan return value.

Chandan Rajendra (1):
      ext4: fix crash when a directory's i_size is too small

Christian Holl (1):
      USB: serial: cp210x: add new device ID ELV ALC 8xxx

Christoph Hellwig (1):
      scsi: dma-mapping: always provide dma_get_cache_alignment

Christoph Paasch (1):
      tcp md5sig: Use skb's saddr when replying to an incoming segment

Christophe Leroy (1):
      net: fs_enet: do not call phy_stop() in interrupts

Colin Ian King (1):
      usb: host: fix incorrect updating of offset

Cong Wang (1):
      8021q: fix a memory leak for VLAN 0 device

Dan Williams (1):
      libsas: remove unused ata_task_resp fields

Daniel Mentz (2):
      media: v4l2-compat-ioctl32: Copy v4l2_window->global_alpha
      media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic

Daniel Thompson (1):
      kdb: Fix handling of kallsyms_symbol_next() return value

David Howells (1):
      fscache: Fix the default for fscache_maybe_release_page()

David Kozub (1):
      USB: uas and storage: Add US_FL_BROKEN_FUA for another JMicron JMS567=
 ID

Dennis Yang (1):
      dm thin metadata: THIN_MAX_CONCURRENT_LOCKS should be 6

Denys Vlasenko (1):
      include/stddef.h: Move offsetofend() from vfio.h to a generic kernel =
header

Diego Elio Petten=C3=B2 (1):
      USB: serial: cp210x: add IDs for LifeScan OneTouch Verio IQ

Dmitry Fleytman Dmitry Fleytman (1):
      usb: Add device quirk for Logitech HD Pro Webcam C925e

Eric Biggers (3):
      af_key: fix buffer overread in verify_address_len()
      af_key: fix buffer overread in parse_exthdrs()
      crypto: algapi - fix NULL dereference in crypto_remove_spawns()

Eric Dumazet (1):
      net/packet: fix a race in packet_bind() and packet_notifier()

Felix Fietkau (1):
      net: igmp: fix source address check for IGMPv3 reports

Geert Uytterhoeven (1):
      m32r: fix 'fix breakage from "m32r: use generic ptrace_resume code"' =
fallout

Gleb Natapov (2):
      KVM: VMX: do not try to reexecute failed instruction while emulating =
invalid guest state
      KVM: apic: fix LDR calculation in x2apic mode

Greg Kroah-Hartman (1):
      ACPI: sbshc: remove raw pointer from printk() message

Guennadi Liakhovetski (1):
      V4L2: fix VIDIOC_CREATE_BUFS 32-bit compatibility mode data copy-back

Guillaume Nault (1):
      pppoe: take ->needed_headroom of lower device into account on xmit

Hans Verkuil (12):
      v4l2-compat-ioctl32: fix sparse warnings
      media: v4l2-compat-ioctl32.c: add capabilities field to, v4l2_input32
      media: v4l2-ioctl.c: don't copy back the result for -ENOTTY
      media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
      media: v4l2-compat-ioctl32.c: fix the indentation
      media: v4l2-compat-ioctl32.c: move 'helper' functions to __get/put_v4=
l2_format32
      media: v4l2-compat-ioctl32.c: avoid sizeof(type)
      media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
      media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
      media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
      media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
      media: v4l2-compat-ioctl32.c: don't copy back the result for certain =
errors

Heiko Carstens (1):
      s390: always save and restore all registers on context switch

Heiner Kallweit (1):
      eeprom: at24: check at24_read/write arguments

Helge Deller (1):
      parisc: Hide Diva-built-in serial aux and graphics card

Herbert Xu (5):
      ipv4: Use standard iovec primitive in raw_probe_proto_opt
      ipv4: Avoid reading user iov twice after raw_probe_proto_opt
      xfrm: Reinject transport-mode packets through tasklet
      xfrm: Use __skb_queue_tail in xfrm_trans_queue
      xfrm: Return error on unknown encap_type in init_state

Huacai Chen (2):
      scsi: use dma_get_cache_alignment() as minimum DMA alignment
      scsi: libsas: align sata_device's rps_resp on a cacheline

H=C3=A5kon Bugge (1):
      rds: Fix NULL pointer dereference in __rds_rdma_map

Jaejoong Kim (2):
      ALSA: usb-audio: Fix out-of-bound error
      ALSA: usb-audio: Add check return value for usb_string()

Jan Engelhardt (1):
      crypto: n2 - cure use after free

Jeremy Compostella (1):
      i2c: core-smbus: prevent stack corruption on read I2C_BLOCK_DATA

Joe Thornber (2):
      dm thin metadata: introduce THIN_MAX_CONCURRENT_LOCKS
      dm btree: fix serious bug in btree_split_beneath()

Johannes Berg (2):
      cfg80211: check dev_set_name() return value
      cfg80211: fix station info handling bugs

Johannes Thumshirn (1):
      dm mpath: simplify failure path of dm_multipath_init()

Josef Bacik (1):
      btrfs: clear space cache inode generation always

Juan Zea (1):
      usbip: fix usbip bind writing random string after command in match_bu=
sid

Kevin Cernekee (1):
      net: igmp: Use correct source address on IGMPv3 reports

Lan Tianyu (1):
      KVM/x86: Check input paging mode when cs.l is set

Laurent Caumont (1):
      media: dvb: i2c transfers over usb cannot be done from stack

Li Jinyue (1):
      futex: Prevent overflow by strengthen input validation

Linus Torvalds (2):
      n_tty: fix EXTPROC vs ICANON interaction with TIOCINQ (aka FIONREAD)
      kbuild: add '-fno-stack-check' to kernel build options

Liran Alon (1):
      KVM: x86: Don't re-execute instruction when not passing CR2 value

Marc Kleine-Budde (1):
      can: af_can: can_rcv(): replace WARN_ONCE by pr_warn_once

Martin Kelly (2):
      can: ems_usb: cancel urb on -EPIPE and -EPROTO
      can: esd_usb2: cancel urb on -EPIPE and -EPROTO

Masakazu Mokuno (1):
      USB: core: Add type-specific length check of BOS descriptors

Mathias Nyman (2):
      xhci: Don't show incorrect WARN message about events for empty rings
      xhci: Don't add a virt_dev to the devs array before it's fully alloca=
ted

Matt Wilson (1):
      serial: 8250_pci: Add Amazon PCI serial device ID

Max Schulze (1):
      USB: serial: ftdi_sio: add id for Airbus DS P8GR

Mohamed Ghannam (1):
      net: ipv4: fix for a race condition in raw_sendmsg

Nicolai Stange (1):
      net: ipv4: emulate READ_ONCE() on ->hdrincl bit-field in raw_sendmsg()

Nikolay Aleksandrov (1):
      net: bridge: fix early call to br_stp_change_bridge_id and plug newli=
nk leaks

Nikolay Borisov (1):
      btrfs: Fix possible off-by-one in btrfs_search_path_in_tree

Nogah Frankel (1):
      net_sched: red: Avoid illegal values

Oliver Neukum (2):
      USB: usbfs: Filter flags passed in from user space
      usb: add RESET_RESUME for ELSA MicroLink 56K

Oliver St=C3=A4bler (1):
      can: ti_hecc: Fix napi poll return value for repoll

Oscar Campos (1):
      Input: trackpoint - assume 3 buttons when buttons detection fails

Pete Zaitcev (1):
      USB: fix usbmon BUG trigger

Rafael J. Wysocki (1):
      PCI / PM: Force devices to D0 in pci_pm_thaw_noirq()

Robb Glasser (1):
      ALSA: pcm: prevent UAF in snd_pcm_info

Robert Lippert (1):
      hwmon: (pmbus) Use 64bit math for DIRECT format values

Robin Murphy (1):
      iommu/vt-d: Fix scatterlist offset handling

SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) (1):
      USB: serial: option: adding support for YUGA CLM920-NC5

Sebastian Sjoholm (1):
      USB: serial: option: add Quectel BG96 id

Sergei Shtylyov (2):
      SolutionEngine771x: fix Ether platform data
      SolutionEngine771x: add Ether TSU resource

Shuah Khan (4):
      usbip: vhci: stop printing kernel pointer addresses in messages
      usbip: stub: stop printing kernel pointer addresses in messages
      usbip: prevent leaking socket pointer address in messages
      usbip: remove kernel addresses from usb device and urb debug msgs

Steve Wise (1):
      iw_cxgb4: Only validate the MSN for successful completions

Steven Rostedt (VMware) (1):
      ring-buffer: Mask out the info bits when returning buffer page length

Sven Eckelmann (1):
      batman-adv: Fix lock for ogm cnt access in batadv_iv_ogm_calc_tq

Takashi Iwai (13):
      ALSA: seq: Fix regression by incorrect ioctl_mutex usages
      ALSA: seq: Remove spurious WARN_ON() at timer check
      ALSA: rawmidi: Avoid racy info ioctl via ctl device
      ACPI: APEI / ERST: Fix missing error handling in erst_reader()
      ALSA: usb-audio: Fix the missing ctl name suffix at parsing SU
      ALSA: pcm: Remove incorrect snd_BUG_ON() usages
      ALSA: pcm: Add missing error checks in OSS emulation plugin builder
      ALSA: aloop: Release cable upon open error path
      ALSA: aloop: Fix inconsistent format due to incomplete rule
      ALSA: aloop: Fix racy hw constraints adjustment
      ALSA: pcm: Abort properly at pending signal in OSS read/write loops
      ALSA: pcm: Allow aborting mutex lock at OSS read/write loops
      ALSA: pcm: Remove yet superfluous WARN_ON()

Thiago Rafael Becker (1):
      kernel: make groups_sort calling a responsibility group_info allocato=
rs

Thomas Gleixner (3):
      posix-timer: Properly check sigevent->sigev_notify
      x86/mce: Make machine check speculation protected
      hrtimer: Reset hrtimer cpu base proper on CPU hotplug

Tianyu Lan (1):
      KVM/x86: Fix wrong macro references of X86_CR0_PG_BIT and X86_CR4_PAE=
_BIT in kvm_valid_sregs()

Tiffany Lin (1):
      media: v4l2-compat-ioctl32: fix missing reserved field copy in put_v4=
l2_create32

Wanpeng Li (1):
      KVM: X86: Fix load RFLAGS w/o the fixed bit

William Breathitt Gray (1):
      isa: Prevent NULL dereference in isa_bus driver callbacks

Xin Long (3):
      sctp: use the right sk after waking up from wait_buf sleep
      sctp: return error if the asoc has been peeled off in sctp_wait_for_s=
ndbuf
      sctp: do not allow the v4 socket to bind a v4mapped v6 address

Zhao Qiang (1):
      net: phy: marvell: Limit 88m1101 autoneg errata to 88E1145 as well.

monty_pavel@sina.com (1):
      dm: fix various targets to dm_register_target after module __init res=
ources created


--+sHJum3is6Tsg7/J
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.2.100.patch"
Content-Disposition: attachment; filename="linux-3.2.100.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Makefile b/Makefile
index 71876659ace6..d8a202610b4f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 VERSION =3D 3
 PATCHLEVEL =3D 2
-SUBLEVEL =3D 99
+SUBLEVEL =3D 100
 EXTRAVERSION =3D
-NAME =3D Saber-toothed Squirrel
+NAME =3D Sleepy Otter
=20
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
@@ -631,6 +631,9 @@ KBUILD_CFLAGS +=3D $(call cc-disable-warning, pointer-s=
ign)
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+=3D $(call cc-option,-fno-strict-overflow)
=20
+# Make sure -fstack-check isn't enabled (like gentoo apparently did)
+KBUILD_CFLAGS  +=3D $(call cc-option,-fno-stack-check,)
+
 # conserve stack if available
 KBUILD_CFLAGS   +=3D $(call cc-option,-fconserve-stack)
=20
diff --git a/arch/m32r/kernel/ptrace.c b/arch/m32r/kernel/ptrace.c
index 20743754f2b2..20c5b5c5433b 100644
--- a/arch/m32r/kernel/ptrace.c
+++ b/arch/m32r/kernel/ptrace.c
@@ -592,17 +592,16 @@ void user_enable_single_step(struct task_struct *chil=
d)
=20
 	if (access_process_vm(child, pc&~3, &insn, sizeof(insn), 0)
 	    !=3D sizeof(insn))
-		return -EIO;
+		return;
=20
 	compute_next_pc(insn, pc, &next_pc, child);
 	if (next_pc & 0x80000000)
-		return -EIO;
+		return;
=20
 	if (embed_debug_trap(child, next_pc))
-		return -EIO;
+		return;
=20
 	invalidate_cache();
-	return 0;
 }
=20
 void user_disable_single_step(struct task_struct *child)
diff --git a/arch/s390/include/asm/system.h b/arch/s390/include/asm/system.h
index ef573c1d71a7..b68fef312111 100644
--- a/arch/s390/include/asm/system.h
+++ b/arch/s390/include/asm/system.h
@@ -89,17 +89,13 @@ static inline void restore_access_regs(unsigned int *ac=
rs)
 	asm volatile("lam 0,15,%0" : : "Q" (*acrs));
 }
=20
-#define switch_to(prev,next,last) do {					\
-	if (prev->mm) {							\
-		save_fp_regs(&prev->thread.fp_regs);			\
-		save_access_regs(&prev->thread.acrs[0]);		\
-	}								\
-	if (next->mm) {							\
-		restore_fp_regs(&next->thread.fp_regs);			\
-		restore_access_regs(&next->thread.acrs[0]);		\
-		update_per_regs(next);					\
-	}								\
-	prev =3D __switch_to(prev,next);					\
+#define switch_to(prev, next, last) do {				\
+	save_fp_regs(&prev->thread.fp_regs);				\
+	save_access_regs(&prev->thread.acrs[0]);			\
+	restore_fp_regs(&next->thread.fp_regs);				\
+	restore_access_regs(&next->thread.acrs[0]);			\
+	update_per_regs(next);						\
+	prev =3D __switch_to(prev, next);					\
 } while (0)
=20
 extern void account_vtime(struct task_struct *, struct task_struct *);
diff --git a/arch/s390/kernel/compat_linux.c b/arch/s390/kernel/compat_linu=
x.c
index 38c66455b927..76fdbad69e97 100644
--- a/arch/s390/kernel/compat_linux.c
+++ b/arch/s390/kernel/compat_linux.c
@@ -242,6 +242,7 @@ asmlinkage long sys32_setgroups16(int gidsetsize, u16 _=
_user *grouplist)
 		return retval;
 	}
=20
+	groups_sort(group_info);
 	retval =3D set_current_groups(group_info);
 	put_group_info(group_info);
=20
diff --git a/arch/sh/boards/mach-se/770x/setup.c b/arch/sh/boards/mach-se/7=
70x/setup.c
index 31330c65c0ce..24d7577df84c 100644
--- a/arch/sh/boards/mach-se/770x/setup.c
+++ b/arch/sh/boards/mach-se/770x/setup.c
@@ -8,6 +8,7 @@
  */
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/sh_eth.h>
 #include <mach-se/mach/se.h>
 #include <mach-se/mach/mrshpc.h>
 #include <asm/machvec.h>
@@ -114,13 +115,23 @@ static struct platform_device heartbeat_device =3D {
 #if defined(CONFIG_CPU_SUBTYPE_SH7710) ||\
 	defined(CONFIG_CPU_SUBTYPE_SH7712)
 /* SH771X Ethernet driver */
+static struct sh_eth_plat_data sh_eth_plat =3D {
+	.phy =3D PHY_ID,
+	.phy_interface =3D PHY_INTERFACE_MODE_MII,
+};
+
 static struct resource sh_eth0_resources[] =3D {
 	[0] =3D {
 		.start =3D SH_ETH0_BASE,
-		.end =3D SH_ETH0_BASE + 0x1B8,
+		.end =3D SH_ETH0_BASE + 0x1B8 - 1,
 		.flags =3D IORESOURCE_MEM,
 	},
 	[1] =3D {
+		.start =3D SH_TSU_BASE,
+		.end =3D SH_TSU_BASE + 0x200 - 1,
+		.flags =3D IORESOURCE_MEM,
+	},
+	[2] =3D {
 		.start =3D SH_ETH0_IRQ,
 		.end =3D SH_ETH0_IRQ,
 		.flags =3D IORESOURCE_IRQ,
@@ -131,7 +142,7 @@ static struct platform_device sh_eth0_device =3D {
 	.name =3D "sh-eth",
 	.id	=3D 0,
 	.dev =3D {
-		.platform_data =3D PHY_ID,
+		.platform_data =3D &sh_eth_plat,
 	},
 	.num_resources =3D ARRAY_SIZE(sh_eth0_resources),
 	.resource =3D sh_eth0_resources,
@@ -140,10 +151,15 @@ static struct platform_device sh_eth0_device =3D {
 static struct resource sh_eth1_resources[] =3D {
 	[0] =3D {
 		.start =3D SH_ETH1_BASE,
-		.end =3D SH_ETH1_BASE + 0x1B8,
+		.end =3D SH_ETH1_BASE + 0x1B8 - 1,
 		.flags =3D IORESOURCE_MEM,
 	},
 	[1] =3D {
+		.start =3D SH_TSU_BASE,
+		.end =3D SH_TSU_BASE + 0x200 - 1,
+		.flags =3D IORESOURCE_MEM,
+	},
+	[2] =3D {
 		.start =3D SH_ETH1_IRQ,
 		.end =3D SH_ETH1_IRQ,
 		.flags =3D IORESOURCE_IRQ,
@@ -154,7 +170,7 @@ static struct platform_device sh_eth1_device =3D {
 	.name =3D "sh-eth",
 	.id	=3D 1,
 	.dev =3D {
-		.platform_data =3D PHY_ID,
+		.platform_data =3D &sh_eth_plat,
 	},
 	.num_resources =3D ARRAY_SIZE(sh_eth1_resources),
 	.resource =3D sh_eth1_resources,
diff --git a/arch/sh/include/mach-se/mach/se.h b/arch/sh/include/mach-se/ma=
ch/se.h
index 14be91c5a2f0..0ed7db4927fb 100644
--- a/arch/sh/include/mach-se/mach/se.h
+++ b/arch/sh/include/mach-se/mach/se.h
@@ -98,6 +98,7 @@
 /* Base address */
 #define SH_ETH0_BASE 0xA7000000
 #define SH_ETH1_BASE 0xA7000400
+#define SH_TSU_BASE  0xA7000800
 /* PHY ID */
 #if defined(CONFIG_CPU_SUBTYPE_SH7710)
 # define PHY_ID 0x00
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_hos=
t.h
index 51f85fc08cf1..f0afe865cc12 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -694,13 +694,15 @@ enum emulation_result {
 #define EMULTYPE_NO_DECODE	    (1 << 0)
 #define EMULTYPE_TRAP_UD	    (1 << 1)
 #define EMULTYPE_SKIP		    (1 << 2)
+#define EMULTYPE_NO_REEXECUTE	    (1 << 4)
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, unsigned long cr2,
 			    int emulation_type, void *insn, int insn_len);
=20
 static inline int emulate_instruction(struct kvm_vcpu *vcpu,
 			int emulation_type)
 {
-	return x86_emulate_instruction(vcpu, 0, emulation_type, NULL, 0);
+	return x86_emulate_instruction(vcpu, 0,
+			emulation_type | EMULTYPE_NO_REEXECUTE, NULL, 0);
 }
=20
 void kvm_enable_efer_bits(u64);
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index 88eae2aec619..e8666d8be9c4 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -69,6 +69,7 @@ dotraplinkage void do_simd_coprocessor_error(struct pt_re=
gs *, long);
 #ifdef CONFIG_X86_32
 dotraplinkage void do_iret_error(struct pt_regs *, long);
 #endif
+void do_mce(struct pt_regs *, long);
=20
 static inline int get_si_code(unsigned long condition)
 {
diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/=
mce.c
index 3b678770dba5..fc54c3b3df81 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -1407,6 +1407,11 @@ static void unexpected_machine_check(struct pt_regs =
*regs, long error_code)
 void (*machine_check_vector)(struct pt_regs *, long error_code) =3D
 						unexpected_machine_check;
=20
+void do_mce(struct pt_regs *regs, long error_code)
+{
+	machine_check_vector(regs, error_code);
+}
+
 /*
  * Called for each booted CPU to set up machine checks.
  * Must be called with preempt off:
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index b232bfcf44fb..c13ca52ce42e 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -1399,7 +1399,7 @@ errorentry page_fault do_page_fault
 errorentry async_page_fault do_async_page_fault
 #endif
 #ifdef CONFIG_X86_MCE
-paranoidzeroentry machine_check *machine_check_vector(%rip)
+paranoidzeroentry machine_check do_mce
 #endif
=20
 	/*
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 055cc49ffb10..264b15352dae 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1022,7 +1022,7 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 va=
lue)
 	vcpu->arch.apic_base =3D value;
 	if (apic_x2apic_mode(apic)) {
 		u32 id =3D kvm_apic_id(apic);
-		u32 ldr =3D ((id & ~0xf) << 16) | (1 << (id & 0xf));
+		u32 ldr =3D ((id >> 4) << 16) | (1 << (id & 0xf));
 		apic_set_reg(apic, APIC_LDR, ldr);
 	}
 	apic->base_address =3D apic->vcpu->arch.apic_base &
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 346fac6eab9f..690120f552db 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -573,8 +573,18 @@ static const int max_vmcs_field =3D ARRAY_SIZE(vmcs_fi=
eld_to_offset_table);
=20
 static inline short vmcs_field_to_offset(unsigned long field)
 {
-	if (field >=3D max_vmcs_field || vmcs_field_to_offset_table[field] =3D=3D=
 0)
+	if (field >=3D max_vmcs_field)
 		return -1;
+
+	/*
+	 * FIXME: Mitigation for CVE-2017-5753.  To be replaced with a
+	 * generic mechanism.
+	 */
+	asm("lfence");
+
+	if (vmcs_field_to_offset_table[field] =3D=3D 0)
+		return -1;
+
 	return vmcs_field_to_offset_table[field];
 }
=20
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 29d04a41ee0a..42cc53750c3e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4888,10 +4888,14 @@ static int handle_emulation_failure(struct kvm_vcpu=
 *vcpu)
 	return r;
 }
=20
-static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t gva)
+static bool reexecute_instruction(struct kvm_vcpu *vcpu, gva_t gva,
+				  int emulation_type)
 {
 	gpa_t gpa;
=20
+	if (emulation_type & EMULTYPE_NO_REEXECUTE)
+		return false;
+
 	if (tdp_enabled)
 		return false;
=20
@@ -4942,7 +4946,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 		if (r !=3D EMULATION_OK)  {
 			if (emulation_type & EMULTYPE_TRAP_UD)
 				return EMULATE_FAIL;
-			if (reexecute_instruction(vcpu, cr2))
+			if (reexecute_instruction(vcpu, cr2, emulation_type))
 				return EMULATE_DONE;
 			if (emulation_type & EMULTYPE_SKIP)
 				return EMULATE_FAIL;
@@ -4969,7 +4973,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu,
 		return EMULATE_DONE;
=20
 	if (r =3D=3D EMULATION_FAILED) {
-		if (reexecute_instruction(vcpu, cr2))
+		if (reexecute_instruction(vcpu, cr2, emulation_type))
 			return EMULATE_DONE;
=20
 		return handle_emulation_failure(vcpu);
@@ -6073,7 +6077,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcp=
u, struct kvm_regs *regs)
 #endif
=20
 	kvm_rip_write(vcpu, regs->rip);
-	kvm_set_rflags(vcpu, regs->rflags);
+	kvm_set_rflags(vcpu, regs->rflags | 0x2 /*X86_EFLAGS_FIXED*/);
=20
 	vcpu->arch.exception.pending =3D false;
=20
@@ -6168,6 +6172,29 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_s=
elector, int reason,
 }
 EXPORT_SYMBOL_GPL(kvm_task_switch);
=20
+int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
+{
+	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG)) {
+		/*
+		 * When EFER.LME and CR0.PG are set, the processor is in
+		 * 64-bit mode (though maybe in a 32-bit code segment).
+		 * CR4.PAE and EFER.LMA must be set.
+		 */
+		if (!(sregs->cr4 & X86_CR4_PAE)
+		    || !(sregs->efer & EFER_LMA))
+			return -EINVAL;
+	} else {
+		/*
+		 * Not in 64-bit mode: EFER.LMA is clear and the code
+		 * segment cannot be 64-bit.
+		 */
+		if (sregs->efer & EFER_LMA || sregs->cs.l)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
@@ -6178,6 +6205,9 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vc=
pu,
 	if (!guest_cpuid_has_xsave(vcpu) && (sregs->cr4 & X86_CR4_OSXSAVE))
 		return -EINVAL;
=20
+	if (kvm_valid_sregs(vcpu, sregs))
+		return -EINVAL;
+
 	dt.size =3D sregs->idt.limit;
 	dt.address =3D sregs->idt.base;
 	kvm_x86_ops->set_idt(vcpu, &dt);
diff --git a/crypto/algapi.c b/crypto/algapi.c
index 2f1954885ff9..49e126803c79 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -163,6 +163,18 @@ void crypto_remove_spawns(struct crypto_alg *alg, stru=
ct list_head *list,
=20
 			spawn->alg =3D NULL;
 			spawns =3D &inst->alg.cra_users;
+
+			/*
+			 * We may encounter an unregistered instance here, since
+			 * an instance's spawns are set up prior to the instance
+			 * being registered.  An unregistered instance will have
+			 * NULL ->cra_users.next, since ->cra_users isn't
+			 * properly initialized until registration.  But an
+			 * unregistered instance cannot have any users, so treat
+			 * it the same as ->cra_users being empty.
+			 */
+			if (spawns->next =3D=3D NULL)
+				break;
 		}
 	} while ((spawns =3D crypto_more_spawns(alg, &stack, &top,
 					      &secondary_spawns)));
diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 631b9477b99c..93ef09c403cf 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -1019,7 +1019,7 @@ static ssize_t erst_reader(u64 *id, enum pstore_type_=
id *type,
 	/* The record may be cleared by others, try read next record */
 	if (len =3D=3D -ENOENT)
 		goto skip;
-	else if (len < sizeof(*rcd)) {
+	else if (len < 0 || len < sizeof(*rcd)) {
 		rc =3D -EIO;
 		goto out;
 	}
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index f8d2a472795c..c9cfe4cffe35 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -288,8 +288,8 @@ static int acpi_smbus_hc_add(struct acpi_device *device)
 	device->driver_data =3D hc;
=20
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
-	printk(KERN_INFO PREFIX "SBS HC: EC =3D 0x%p, offset =3D 0x%0x, query_bit=
 =3D 0x%0x\n",
-		hc->ec, hc->offset, hc->query_bit);
+	dev_info(&device->dev, "SBS HC: offset =3D 0x%0x, query_bit =3D 0x%0x\n",
+		 hc->offset, hc->query_bit);
=20
 	return 0;
 }
diff --git a/drivers/base/isa.c b/drivers/base/isa.c
index cd6ccdcf9df0..372d10af2600 100644
--- a/drivers/base/isa.c
+++ b/drivers/base/isa.c
@@ -39,7 +39,7 @@ static int isa_bus_probe(struct device *dev)
 {
 	struct isa_driver *isa_driver =3D dev->platform_data;
=20
-	if (isa_driver->probe)
+	if (isa_driver && isa_driver->probe)
 		return isa_driver->probe(dev, to_isa_dev(dev)->id);
=20
 	return 0;
@@ -49,7 +49,7 @@ static int isa_bus_remove(struct device *dev)
 {
 	struct isa_driver *isa_driver =3D dev->platform_data;
=20
-	if (isa_driver->remove)
+	if (isa_driver && isa_driver->remove)
 		return isa_driver->remove(dev, to_isa_dev(dev)->id);
=20
 	return 0;
@@ -59,7 +59,7 @@ static void isa_bus_shutdown(struct device *dev)
 {
 	struct isa_driver *isa_driver =3D dev->platform_data;
=20
-	if (isa_driver->shutdown)
+	if (isa_driver && isa_driver->shutdown)
 		isa_driver->shutdown(dev, to_isa_dev(dev)->id);
 }
=20
@@ -67,7 +67,7 @@ static int isa_bus_suspend(struct device *dev, pm_message=
_t state)
 {
 	struct isa_driver *isa_driver =3D dev->platform_data;
=20
-	if (isa_driver->suspend)
+	if (isa_driver && isa_driver->suspend)
 		return isa_driver->suspend(dev, to_isa_dev(dev)->id, state);
=20
 	return 0;
@@ -77,7 +77,7 @@ static int isa_bus_resume(struct device *dev)
 {
 	struct isa_driver *isa_driver =3D dev->platform_data;
=20
-	if (isa_driver->resume)
+	if (isa_driver && isa_driver->resume)
 		return isa_driver->resume(dev, to_isa_dev(dev)->id);
=20
 	return 0;
diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 8944dabc0e3c..17e5921b9e8a 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1642,6 +1642,7 @@ static int queue_cache_init(void)
 					  CWQ_ENTRY_SIZE, 0, NULL);
 	if (!queue_cache[HV_NCS_QTYPE_CWQ - 1]) {
 		kmem_cache_destroy(queue_cache[HV_NCS_QTYPE_MAU - 1]);
+		queue_cache[HV_NCS_QTYPE_MAU - 1] =3D NULL;
 		return -ENOMEM;
 	}
 	return 0;
@@ -1651,6 +1652,8 @@ static void queue_cache_destroy(void)
 {
 	kmem_cache_destroy(queue_cache[HV_NCS_QTYPE_MAU - 1]);
 	kmem_cache_destroy(queue_cache[HV_NCS_QTYPE_CWQ - 1]);
+	queue_cache[HV_NCS_QTYPE_MAU - 1] =3D NULL;
+	queue_cache[HV_NCS_QTYPE_CWQ - 1] =3D NULL;
 }
=20
 static int spu_queue_register(struct spu_queue *p, unsigned long q_type)
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_c=
ore.c
index d89b33967a85..d62b08620427 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -19,6 +19,7 @@
  */
=20
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/err.h>
@@ -475,8 +476,8 @@ static long pmbus_reg2data_linear(struct pmbus_data *da=
ta,
 static long pmbus_reg2data_direct(struct pmbus_data *data,
 				  struct pmbus_sensor *sensor)
 {
-	long val =3D (s16) sensor->data;
-	long m, b, R;
+	s64 b, val =3D (s16)sensor->data;
+	s32 m, R;
=20
 	m =3D data->info->m[sensor->class];
 	b =3D data->info->b[sensor->class];
@@ -504,11 +505,12 @@ static long pmbus_reg2data_direct(struct pmbus_data *=
data,
 		R--;
 	}
 	while (R < 0) {
-		val =3D DIV_ROUND_CLOSEST(val, 10);
+		val =3D div_s64(val + 5LL, 10L);  /* round closest */
 		R++;
 	}
=20
-	return (val - b) / m;
+	val =3D div_s64(val - b, m);
+	return clamp_val(val, LONG_MIN, LONG_MAX);
 }
=20
 /*
@@ -620,7 +622,8 @@ static u16 pmbus_data2reg_linear(struct pmbus_data *dat=
a,
 static u16 pmbus_data2reg_direct(struct pmbus_data *data,
 				 enum pmbus_sensor_classes class, long val)
 {
-	long m, b, R;
+	s64 b, val64 =3D val;
+	s32 m, R;
=20
 	m =3D data->info->m[class];
 	b =3D data->info->b[class];
@@ -637,18 +640,18 @@ static u16 pmbus_data2reg_direct(struct pmbus_data *d=
ata,
 		R -=3D 3;		/* Adjust R and b for data in milli-units */
 		b *=3D 1000;
 	}
-	val =3D val * m + b;
+	val64 =3D val64 * m + b;
=20
 	while (R > 0) {
-		val *=3D 10;
+		val64 *=3D 10;
 		R--;
 	}
 	while (R < 0) {
-		val =3D DIV_ROUND_CLOSEST(val, 10);
+		val64 =3D div_s64(val64 + 5LL, 10L);  /* round closest */
 		R++;
 	}
=20
-	return val;
+	return (u16)clamp_val(val64, -32768, 32767);
 }
=20
 static u16 pmbus_data2reg_vid(struct pmbus_data *data,
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index c3793a79fcd2..8d96a478e3b7 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -2009,16 +2009,17 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapt=
er *adapter, u16 addr,
 				   the underlying bus driver */
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (data->block[0] > I2C_SMBUS_BLOCK_MAX) {
+			dev_err(&adapter->dev, "Invalid block %s size %d\n",
+				read_write =3D=3D I2C_SMBUS_READ ? "read" : "write",
+				data->block[0]);
+			return -EINVAL;
+		}
+
 		if (read_write =3D=3D I2C_SMBUS_READ) {
 			msg[1].len =3D data->block[0];
 		} else {
 			msg[0].len =3D data->block[0] + 1;
-			if (msg[0].len > I2C_SMBUS_BLOCK_MAX + 1) {
-				dev_err(&adapter->dev,
-					"Invalid block write size %d\n",
-					data->block[0]);
-				return -EINVAL;
-			}
 			for (i =3D 1; i <=3D data->block[0]; i++)
 				msgbuf0[i] =3D data->block[i];
 		}
diff --git a/drivers/infiniband/hw/cxgb4/cq.c b/drivers/infiniband/hw/cxgb4=
/cq.c
index 3e5f5763c666..29527f606b86 100644
--- a/drivers/infiniband/hw/cxgb4/cq.c
+++ b/drivers/infiniband/hw/cxgb4/cq.c
@@ -484,10 +484,10 @@ static int poll_cq(struct t4_wq *wq, struct t4_cq *cq=
, struct t4_cqe *cqe,
 			ret =3D -EAGAIN;
 			goto skip_cqe;
 		}
-		if (unlikely((CQE_WRID_MSN(hw_cqe) !=3D (wq->rq.msn)))) {
+		if (unlikely(!CQE_STATUS(hw_cqe) &&
+			     CQE_WRID_MSN(hw_cqe) !=3D wq->rq.msn)) {
 			t4_set_wq_in_error(wq);
-			hw_cqe->header |=3D htonl(V_CQE_STATUS(T4_ERR_MSN));
-			goto proc_cqe;
+			hw_cqe->header |=3D cpu_to_be32(V_CQE_STATUS(T4_ERR_MSN));
 		}
 		goto proc_cqe;
 	}
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 537692db93b3..62e9e5e340a6 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1284,7 +1284,7 @@ static int elantech_set_properties(struct elantech_da=
ta *etd)
 		case 5:
 			etd->hw_version =3D 3;
 			break;
-		case 6 ... 14:
+		case 6 ... 15:
 			etd->hw_version =3D 4;
 			break;
 		default:
diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpo=
int.c
index 7836450b3465..46c614558b2f 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -298,8 +298,11 @@ int trackpoint_detect(struct psmouse *psmouse, bool se=
t_properties)
 		return 0;
=20
 	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
-		printk(KERN_WARNING "trackpoint.c: failed to get extended button data\n"=
);
-		button_info =3D 0;
+		printk(KERN_WARNING "trackpoint.c: failed to get extended button data, a=
ssuming 3 buttons\n");
+		button_info =3D 0x33;
+	} else if (!button_info) {
+		printk(KERN_WARNING "trackpoint.c: got 0 in extended button data, assumi=
ng 3 buttons\n");
+		button_info =3D 0x33;
 	}
=20
 	psmouse->private =3D kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 41b74641f6c2..ff037bbfc971 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1783,10 +1783,12 @@ static int __domain_mapping(struct dmar_domain *dom=
ain, unsigned long iov_pfn,
 		uint64_t tmp;
=20
 		if (!sg_res) {
+			unsigned int pgoff =3D sg->offset & ~PAGE_MASK;
+
 			sg_res =3D aligned_nrpages(sg->offset, sg->length);
-			sg->dma_address =3D ((dma_addr_t)iov_pfn << VTD_PAGE_SHIFT) + sg->offse=
t;
+			sg->dma_address =3D ((dma_addr_t)iov_pfn << VTD_PAGE_SHIFT) + pgoff;
 			sg->dma_length =3D sg->length;
-			pteval =3D page_to_phys(sg_page(sg)) | prot;
+			pteval =3D (sg_phys(sg) - pgoff) | prot;
 			phys_pfn =3D pteval >> VTD_PAGE_SHIFT;
 		}
=20
@@ -3085,7 +3087,7 @@ static int intel_nontranslate_map_sg(struct device *h=
ddev,
=20
 	for_each_sg(sglist, sg, nelems, i) {
 		BUG_ON(!sg_page(sg));
-		sg->dma_address =3D page_to_phys(sg_page(sg)) + sg->offset;
+		sg->dma_address =3D sg_phys(sg);
 		sg->dma_length =3D sg->length;
 	}
 	return nelems;
diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 84ad530eedfb..dd0c88222071 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1658,19 +1658,11 @@ static int __init dm_multipath_init(void)
 	if (!_mpio_cache)
 		return -ENOMEM;
=20
-	r =3D dm_register_target(&multipath_target);
-	if (r < 0) {
-		DMERR("register failed %d", r);
-		kmem_cache_destroy(_mpio_cache);
-		return -EINVAL;
-	}
-
 	kmultipathd =3D alloc_workqueue("kmpathd", WQ_MEM_RECLAIM, 0);
 	if (!kmultipathd) {
 		DMERR("failed to create workqueue kmpathd");
-		dm_unregister_target(&multipath_target);
-		kmem_cache_destroy(_mpio_cache);
-		return -ENOMEM;
+		r =3D -ENOMEM;
+		goto bad_alloc_kmultipathd;
 	}
=20
 	/*
@@ -1683,16 +1675,30 @@ static int __init dm_multipath_init(void)
 						  WQ_MEM_RECLAIM);
 	if (!kmpath_handlerd) {
 		DMERR("failed to create workqueue kmpath_handlerd");
-		destroy_workqueue(kmultipathd);
-		dm_unregister_target(&multipath_target);
-		kmem_cache_destroy(_mpio_cache);
-		return -ENOMEM;
+		r =3D -ENOMEM;
+		goto bad_alloc_kmpath_handlerd;
+	}
+
+	r =3D dm_register_target(&multipath_target);
+	if (r < 0) {
+		DMERR("register failed %d", r);
+		r =3D -EINVAL;
+		goto bad_register_target;
 	}
=20
 	DMINFO("version %u.%u.%u loaded",
 	       multipath_target.version[0], multipath_target.version[1],
 	       multipath_target.version[2]);
=20
+	return 0;
+
+bad_register_target:
+	destroy_workqueue(kmpath_handlerd);
+bad_alloc_kmpath_handlerd:
+	destroy_workqueue(kmultipathd);
+bad_alloc_kmultipathd:
+	kmem_cache_destroy(_mpio_cache);
+
 	return r;
 }
=20
diff --git a/drivers/md/dm-snap.c b/drivers/md/dm-snap.c
index 6674ebf959fe..5d6b5334dd42 100644
--- a/drivers/md/dm-snap.c
+++ b/drivers/md/dm-snap.c
@@ -2293,24 +2293,6 @@ static int __init dm_snapshot_init(void)
 		return r;
 	}
=20
-	r =3D dm_register_target(&snapshot_target);
-	if (r < 0) {
-		DMERR("snapshot target register failed %d", r);
-		goto bad_register_snapshot_target;
-	}
-
-	r =3D dm_register_target(&origin_target);
-	if (r < 0) {
-		DMERR("Origin target register failed %d", r);
-		goto bad_register_origin_target;
-	}
-
-	r =3D dm_register_target(&merge_target);
-	if (r < 0) {
-		DMERR("Merge target register failed %d", r);
-		goto bad_register_merge_target;
-	}
-
 	r =3D init_origin_hash();
 	if (r) {
 		DMERR("init_origin_hash failed.");
@@ -2338,8 +2320,32 @@ static int __init dm_snapshot_init(void)
 		goto bad_tracked_chunk_cache;
 	}
=20
+	r =3D dm_register_target(&snapshot_target);
+	if (r < 0) {
+		DMERR("snapshot target register failed %d", r);
+		goto bad_register_snapshot_target;
+	}
+
+	r =3D dm_register_target(&origin_target);
+	if (r < 0) {
+		DMERR("Origin target register failed %d", r);
+		goto bad_register_origin_target;
+	}
+
+	r =3D dm_register_target(&merge_target);
+	if (r < 0) {
+		DMERR("Merge target register failed %d", r);
+		goto bad_register_merge_target;
+	}
+
 	return 0;
=20
+bad_register_merge_target:
+	dm_unregister_target(&origin_target);
+bad_register_origin_target:
+	dm_unregister_target(&snapshot_target);
+bad_register_snapshot_target:
+	kmem_cache_destroy(tracked_chunk_cache);
 bad_tracked_chunk_cache:
 	kmem_cache_destroy(pending_cache);
 bad_pending_cache:
@@ -2347,12 +2353,6 @@ static int __init dm_snapshot_init(void)
 bad_exception_cache:
 	exit_origin_hash();
 bad_origin_hash:
-	dm_unregister_target(&merge_target);
-bad_register_merge_target:
-	dm_unregister_target(&origin_target);
-bad_register_origin_target:
-	dm_unregister_target(&snapshot_target);
-bad_register_snapshot_target:
 	dm_exception_store_exit();
=20
 	return r;
diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index 237571af77fd..b2ad14e000dd 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -80,6 +80,16 @@
 #define THIN_METADATA_CACHE_SIZE 64
 #define SECTOR_TO_BLOCK_SHIFT 3
=20
+/*
+ * For btree insert:
+ *  3 for btree insert +
+ *  2 for btree lookup used within space map
+ * For btree remove:
+ *  2 for shadow spine +
+ *  4 for rebalance 3 child node
+ */
+#define THIN_MAX_CONCURRENT_LOCKS 6
+
 /* This should be plenty */
 #define SPACE_MAP_ROOT_SIZE 128
=20
@@ -669,13 +679,9 @@ struct dm_pool_metadata *dm_pool_metadata_open(struct =
block_device *bdev,
 		return ERR_PTR(-ENOMEM);
 	}
=20
-	/*
-	 * Max hex locks:
-	 *  3 for btree insert +
-	 *  2 for btree lookup used within space map
-	 */
 	bm =3D dm_block_manager_create(bdev, THIN_METADATA_BLOCK_SIZE,
-				     THIN_METADATA_CACHE_SIZE, 5);
+				     THIN_METADATA_CACHE_SIZE,
+				     THIN_MAX_CONCURRENT_LOCKS);
 	if (!bm) {
 		DMERR("could not create block manager");
 		kfree(pmd);
diff --git a/drivers/md/persistent-data/dm-btree.c b/drivers/md/persistent-=
data/dm-btree.c
index a8f4f7efc513..008231ff8488 100644
--- a/drivers/md/persistent-data/dm-btree.c
+++ b/drivers/md/persistent-data/dm-btree.c
@@ -568,23 +568,8 @@ static int btree_split_beneath(struct shadow_spine *s,=
 uint64_t key)
 	pn->keys[1] =3D rn->keys[0];
 	memcpy_disk(value_ptr(pn, 1, sizeof(__le64)), &val, sizeof(__le64));
=20
-	/*
-	 * rejig the spine.  This is ugly, since it knows too
-	 * much about the spine
-	 */
-	if (s->nodes[0] !=3D new_parent) {
-		unlock_block(s->info, s->nodes[0]);
-		s->nodes[0] =3D new_parent;
-	}
-	if (key < le64_to_cpu(rn->keys[0])) {
-		unlock_block(s->info, right);
-		s->nodes[1] =3D left;
-	} else {
-		unlock_block(s->info, left);
-		s->nodes[1] =3D right;
-	}
-	s->count =3D 2;
-
+	unlock_block(s->info, left);
+	unlock_block(s->info, right);
 	return 0;
 }
=20
diff --git a/drivers/media/dvb/dvb-usb/dibusb-common.c b/drivers/media/dvb/=
dvb-usb/dibusb-common.c
index a76bbb29ca36..e314c32227f2 100644
--- a/drivers/media/dvb/dvb-usb/dibusb-common.c
+++ b/drivers/media/dvb/dvb-usb/dibusb-common.c
@@ -169,8 +169,20 @@ EXPORT_SYMBOL(dibusb_i2c_algo);
=20
 int dibusb_read_eeprom_byte(struct dvb_usb_device *d, u8 offs, u8 *val)
 {
-	u8 wbuf[1] =3D { offs };
-	return dibusb_i2c_msg(d, 0x50, wbuf, 1, val, 1);
+	u8 *buf;
+	int rc;
+
+	buf =3D kmalloc(2, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] =3D offs;
+
+	rc =3D dibusb_i2c_msg(d, 0x50, &buf[0], 1, &buf[1], 1);
+	*val =3D buf[1];
+	kfree(buf);
+
+	return rc;
 }
 EXPORT_SYMBOL(dibusb_read_eeprom_byte);
=20
diff --git a/drivers/media/video/Makefile b/drivers/media/video/Makefile
index 117f9c4b4cb9..aa1e164cfb87 100644
--- a/drivers/media/video/Makefile
+++ b/drivers/media/video/Makefile
@@ -13,12 +13,13 @@ omap2cam-objs	:=3D	omap24xxcam.o omap24xxcam-dma.o
 videodev-objs	:=3D	v4l2-dev.o v4l2-ioctl.o v4l2-device.o v4l2-fh.o \
 			v4l2-event.o v4l2-ctrls.o v4l2-subdev.o
=20
+ifeq ($(CONFIG_COMPAT),y)
+  videodev-objs +=3D v4l2-compat-ioctl32.o
+endif
+
 # V4L2 core modules
=20
 obj-$(CONFIG_VIDEO_DEV) +=3D videodev.o v4l2-int-device.o
-ifeq ($(CONFIG_COMPAT),y)
-  obj-$(CONFIG_VIDEO_DEV) +=3D v4l2-compat-ioctl32.o
-endif
=20
 obj-$(CONFIG_VIDEO_V4L2_COMMON) +=3D v4l2-common.o
=20
diff --git a/drivers/media/video/v4l2-compat-ioctl32.c b/drivers/media/vide=
o/v4l2-compat-ioctl32.c
index 2671959f01bb..b431b1fe4d4d 100644
--- a/drivers/media/video/v4l2-compat-ioctl32.c
+++ b/drivers/media/video/v4l2-compat-ioctl32.c
@@ -17,9 +17,20 @@
 #include <linux/videodev2.h>
 #include <linux/module.h>
 #include <media/v4l2-ioctl.h>
+#include <media/v4l2-dev.h>
+#include <media/v4l2-fh.h>
+#include <media/v4l2-ctrls.h>
=20
 #ifdef CONFIG_COMPAT
=20
+/* Use the same argument order as copy_in_user */
+#define assign_in_user(to, from)					\
+({									\
+	typeof(*from) __assign_tmp;					\
+									\
+	get_user(__assign_tmp, from) || put_user(__assign_tmp, to);	\
+})
+
 static long native_ioctl(struct file *file, unsigned int cmd, unsigned lon=
g arg)
 {
 	long ret =3D -ENOIOCTLCMD;
@@ -33,117 +44,88 @@ static long native_ioctl(struct file *file, unsigned i=
nt cmd, unsigned long arg)
=20
 struct v4l2_clip32 {
 	struct v4l2_rect        c;
-	compat_caddr_t 		next;
+	compat_caddr_t		next;
 };
=20
 struct v4l2_window32 {
 	struct v4l2_rect        w;
-	enum v4l2_field  	field;
+	__u32			field;	/* enum v4l2_field */
 	__u32			chromakey;
 	compat_caddr_t		clips; /* actually struct v4l2_clip32 * */
 	__u32			clipcount;
 	compat_caddr_t		bitmap;
+	__u8                    global_alpha;
 };
=20
-static int get_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 =
__user *up)
+static int get_v4l2_window32(struct v4l2_window __user *kp,
+			     struct v4l2_window32 __user *up,
+			     void __user *aux_buf, u32 aux_space)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_window32)) ||
-		copy_from_user(&kp->w, &up->w, sizeof(up->w)) ||
-		get_user(kp->field, &up->field) ||
-		get_user(kp->chromakey, &up->chromakey) ||
-		get_user(kp->clipcount, &up->clipcount))
-			return -EFAULT;
-	if (kp->clipcount > 2048)
-		return -EINVAL;
-	if (kp->clipcount) {
-		struct v4l2_clip32 __user *uclips;
-		struct v4l2_clip __user *kclips;
-		int n =3D kp->clipcount;
-		compat_caddr_t p;
-
-		if (get_user(p, &up->clips))
-			return -EFAULT;
-		uclips =3D compat_ptr(p);
-		kclips =3D compat_alloc_user_space(n * sizeof(struct v4l2_clip));
-		kp->clips =3D kclips;
-		while (--n >=3D 0) {
-			if (copy_in_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
-				return -EFAULT;
-			if (put_user(n ? kclips + 1 : NULL, &kclips->next))
-				return -EFAULT;
-			uclips +=3D 1;
-			kclips +=3D 1;
-		}
-	} else
-		kp->clips =3D NULL;
-	return 0;
-}
-
-static int put_v4l2_window32(struct v4l2_window *kp, struct v4l2_window32 =
__user *up)
-{
-	if (copy_to_user(&up->w, &kp->w, sizeof(kp->w)) ||
-		put_user(kp->field, &up->field) ||
-		put_user(kp->chromakey, &up->chromakey) ||
-		put_user(kp->clipcount, &up->clipcount))
-			return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_pix_format(struct v4l2_pix_format *kp, struct v=
4l2_pix_format __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_pix_format)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane=
 *kp,
-				struct v4l2_pix_format_mplane __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_pix_format_mplane)))
+	struct v4l2_clip32 __user *uclips;
+	struct v4l2_clip __user *kclips;
+	compat_caddr_t p;
+	u32 clipcount;
+
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
+	    copy_in_user(&kp->w, &up->w, sizeof(up->w)) ||
+	    assign_in_user(&kp->field, &up->field) ||
+	    assign_in_user(&kp->chromakey, &up->chromakey) ||
+	    assign_in_user(&kp->global_alpha, &up->global_alpha) ||
+	    get_user(clipcount, &up->clipcount) ||
+	    put_user(clipcount, &kp->clipcount))
 		return -EFAULT;
-	return 0;
-}
+	if (clipcount > 2048)
+		return -EINVAL;
+	if (!clipcount)
+		return put_user(NULL, &kp->clips);
=20
-static inline int put_v4l2_pix_format(struct v4l2_pix_format *kp, struct v=
4l2_pix_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_pix_format)))
+	if (get_user(p, &up->clips))
 		return -EFAULT;
-	return 0;
-}
-
-static inline int put_v4l2_pix_format_mplane(struct v4l2_pix_format_mplane=
 *kp,
-				struct v4l2_pix_format_mplane __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_pix_format_mplane)))
+	uclips =3D compat_ptr(p);
+	if (aux_space < clipcount * sizeof(*kclips))
 		return -EFAULT;
-	return 0;
-}
-
-static inline int get_v4l2_vbi_format(struct v4l2_vbi_format *kp, struct v=
4l2_vbi_format __user *up)
-{
-	if (copy_from_user(kp, up, sizeof(struct v4l2_vbi_format)))
+	kclips =3D aux_buf;
+	if (put_user(kclips, &kp->clips))
 		return -EFAULT;
-	return 0;
-}
=20
-static inline int put_v4l2_vbi_format(struct v4l2_vbi_format *kp, struct v=
4l2_vbi_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_vbi_format)))
-		return -EFAULT;
+	while (clipcount--) {
+		if (copy_in_user(&kclips->c, &uclips->c, sizeof(uclips->c)))
+			return -EFAULT;
+		if (put_user(clipcount ? kclips + 1 : NULL, &kclips->next))
+			return -EFAULT;
+		uclips++;
+		kclips++;
+	}
 	return 0;
 }
=20
-static inline int get_v4l2_sliced_vbi_format(struct v4l2_sliced_vbi_format=
 *kp, struct v4l2_sliced_vbi_format __user *up)
+static int put_v4l2_window32(struct v4l2_window __user *kp,
+			     struct v4l2_window32 __user *up)
 {
-	if (copy_from_user(kp, up, sizeof(struct v4l2_sliced_vbi_format)))
+	struct v4l2_clip __user *kclips =3D kp->clips;
+	struct v4l2_clip32 __user *uclips;
+	compat_caddr_t p;
+	u32 clipcount;
+
+	if (copy_in_user(&up->w, &kp->w, sizeof(kp->w)) ||
+	    assign_in_user(&up->field, &kp->field) ||
+	    assign_in_user(&up->chromakey, &kp->chromakey) ||
+	    assign_in_user(&up->global_alpha, &kp->global_alpha) ||
+	    get_user(clipcount, &kp->clipcount) ||
+	    put_user(clipcount, &up->clipcount))
 		return -EFAULT;
-	return 0;
-}
+	if (!clipcount)
+		return 0;
=20
-static inline int put_v4l2_sliced_vbi_format(struct v4l2_sliced_vbi_format=
 *kp, struct v4l2_sliced_vbi_format __user *up)
-{
-	if (copy_to_user(up, kp, sizeof(struct v4l2_sliced_vbi_format)))
+	if (get_user(p, &up->clips))
 		return -EFAULT;
+	uclips =3D compat_ptr(p);
+	while (clipcount--) {
+		if (copy_in_user(&uclips->c, &kclips->c, sizeof(uclips->c)))
+			return -EFAULT;
+		uclips++;
+		kclips++;
+	}
 	return 0;
 }
=20
@@ -176,128 +158,185 @@ struct v4l2_create_buffers32 {
 	__u32			reserved[8];
 };
=20
-static int __get_v4l2_format32(struct v4l2_format *kp, struct v4l2_format3=
2 __user *up)
+static int __bufsize_v4l2_format(struct v4l2_format32 __user *up, u32 *siz=
e)
 {
-	if (get_user(kp->type, &up->type))
+	u32 type;
+
+	if (get_user(type, &up->type))
+		return -EFAULT;
+
+	switch (type) {
+	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
+	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY: {
+		u32 clipcount;
+
+		if (get_user(clipcount, &up->fmt.win.clipcount))
+			return -EFAULT;
+		if (clipcount > 2048)
+			return -EINVAL;
+		*size =3D clipcount * sizeof(struct v4l2_clip);
+		return 0;
+	}
+	default:
+		*size =3D 0;
+		return 0;
+	}
+}
+
+static int bufsize_v4l2_format(struct v4l2_format32 __user *up, u32 *size)
+{
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)))
+		return -EFAULT;
+	return __bufsize_v4l2_format(up, size);
+}
+
+static int __get_v4l2_format32(struct v4l2_format __user *kp,
+			       struct v4l2_format32 __user *up,
+			       void __user *aux_buf, u32 aux_space)
+{
+	u32 type;
+
+	if (get_user(type, &up->type) || put_user(type, &kp->type))
 		return -EFAULT;
=20
-	switch (kp->type) {
+	switch (type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
-		return get_v4l2_pix_format(&kp->fmt.pix, &up->fmt.pix);
+		return copy_in_user(&kp->fmt.pix, &up->fmt.pix,
+				    sizeof(kp->fmt.pix)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		return get_v4l2_pix_format_mplane(&kp->fmt.pix_mp,
-						  &up->fmt.pix_mp);
+		return copy_in_user(&kp->fmt.pix_mp, &up->fmt.pix_mp,
+				    sizeof(kp->fmt.pix_mp)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
-		return get_v4l2_window32(&kp->fmt.win, &up->fmt.win);
+		return get_v4l2_window32(&kp->fmt.win, &up->fmt.win,
+					 aux_buf, aux_space);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_VBI_OUTPUT:
-		return get_v4l2_vbi_format(&kp->fmt.vbi, &up->fmt.vbi);
+		return copy_in_user(&kp->fmt.vbi, &up->fmt.vbi,
+				    sizeof(kp->fmt.vbi)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
-		return get_v4l2_sliced_vbi_format(&kp->fmt.sliced, &up->fmt.sliced);
-	case V4L2_BUF_TYPE_PRIVATE:
-		if (copy_from_user(kp, up, sizeof(kp->fmt.raw_data)))
-			return -EFAULT;
-		return 0;
+		return copy_in_user(&kp->fmt.sliced, &up->fmt.sliced,
+				    sizeof(kp->fmt.sliced)) ? -EFAULT : 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-								kp->type);
 		return -EINVAL;
 	}
 }
=20
-static int get_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 =
__user *up)
+static int get_v4l2_format32(struct v4l2_format __user *kp,
+			     struct v4l2_format32 __user *up,
+			     void __user *aux_buf, u32 aux_space)
+{
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)))
+		return -EFAULT;
+	return __get_v4l2_format32(kp, up, aux_buf, aux_space);
+}
+
+static int bufsize_v4l2_create(struct v4l2_create_buffers32 __user *up,
+			       u32 *size)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_format32)))
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)))
 		return -EFAULT;
-	return __get_v4l2_format32(kp, up);
+	return __bufsize_v4l2_format(&up->format, size);
 }
=20
-static int get_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_c=
reate_buffers32 __user *up)
+static int get_v4l2_create32(struct v4l2_create_buffers __user *kp,
+			     struct v4l2_create_buffers32 __user *up,
+			     void __user *aux_buf, u32 aux_space)
 {
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_create_buffers32)) ||
-	    copy_from_user(kp, up, offsetof(struct v4l2_create_buffers32, format)=
))
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
+	    copy_in_user(kp, up,
+			 offsetof(struct v4l2_create_buffers32, format)))
 		return -EFAULT;
-	return __get_v4l2_format32(&kp->format, &up->format);
+	return __get_v4l2_format32(&kp->format, &up->format,
+				   aux_buf, aux_space);
 }
=20
-static int __put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format3=
2 __user *up)
+static int __put_v4l2_format32(struct v4l2_format __user *kp,
+			       struct v4l2_format32 __user *up)
 {
-	switch (kp->type) {
+	u32 type;
+
+	if (get_user(type, &kp->type))
+		return -EFAULT;
+
+	switch (type) {
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT:
-		return put_v4l2_pix_format(&kp->fmt.pix, &up->fmt.pix);
+		return copy_in_user(&up->fmt.pix, &kp->fmt.pix,
+				    sizeof(kp->fmt.pix)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE:
-		return put_v4l2_pix_format_mplane(&kp->fmt.pix_mp,
-						  &up->fmt.pix_mp);
+		return copy_in_user(&up->fmt.pix_mp, &kp->fmt.pix_mp,
+				    sizeof(kp->fmt.pix_mp)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_VIDEO_OVERLAY:
 	case V4L2_BUF_TYPE_VIDEO_OUTPUT_OVERLAY:
 		return put_v4l2_window32(&kp->fmt.win, &up->fmt.win);
 	case V4L2_BUF_TYPE_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_VBI_OUTPUT:
-		return put_v4l2_vbi_format(&kp->fmt.vbi, &up->fmt.vbi);
+		return copy_in_user(&up->fmt.vbi, &kp->fmt.vbi,
+				    sizeof(kp->fmt.vbi)) ? -EFAULT : 0;
 	case V4L2_BUF_TYPE_SLICED_VBI_CAPTURE:
 	case V4L2_BUF_TYPE_SLICED_VBI_OUTPUT:
-		return put_v4l2_sliced_vbi_format(&kp->fmt.sliced, &up->fmt.sliced);
-	case V4L2_BUF_TYPE_PRIVATE:
-		if (copy_to_user(up, kp, sizeof(up->fmt.raw_data)))
-			return -EFAULT;
-		return 0;
+		return copy_in_user(&up->fmt.sliced, &kp->fmt.sliced,
+				    sizeof(kp->fmt.sliced)) ? -EFAULT : 0;
 	default:
-		printk(KERN_INFO "compat_ioctl32: unexpected VIDIOC_FMT type %d\n",
-								kp->type);
 		return -EINVAL;
 	}
 }
=20
-static int put_v4l2_format32(struct v4l2_format *kp, struct v4l2_format32 =
__user *up)
+static int put_v4l2_format32(struct v4l2_format __user *kp,
+			     struct v4l2_format32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_format32)) ||
-		put_user(kp->type, &up->type))
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)))
 		return -EFAULT;
 	return __put_v4l2_format32(kp, up);
 }
=20
-static int put_v4l2_create32(struct v4l2_create_buffers *kp, struct v4l2_c=
reate_buffers32 __user *up)
+static int put_v4l2_create32(struct v4l2_create_buffers __user *kp,
+			     struct v4l2_create_buffers32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_create_buffers32)) ||
-	    copy_to_user(up, kp, offsetof(struct v4l2_create_buffers32, format.fm=
t)))
-			return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
+	    copy_in_user(up, kp,
+			 offsetof(struct v4l2_create_buffers32, format)) ||
+	    copy_in_user(up->reserved, kp->reserved, sizeof(kp->reserved)))
+		return -EFAULT;
 	return __put_v4l2_format32(&kp->format, &up->format);
 }
=20
 struct v4l2_standard32 {
 	__u32		     index;
-	__u32		     id[2]; /* __u64 would get the alignment wrong */
+	compat_u64	     id;
 	__u8		     name[24];
 	struct v4l2_fract    frameperiod; /* Frames, not fields */
 	__u32		     framelines;
 	__u32		     reserved[4];
 };
=20
-static int get_v4l2_standard32(struct v4l2_standard *kp, struct v4l2_stand=
ard32 __user *up)
+static int get_v4l2_standard32(struct v4l2_standard __user *kp,
+			       struct v4l2_standard32 __user *up)
 {
 	/* other fields are not set by the user, nor used by the driver */
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_standard32)) ||
-		get_user(kp->index, &up->index))
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
+	    assign_in_user(&kp->index, &up->index))
 		return -EFAULT;
 	return 0;
 }
=20
-static int put_v4l2_standard32(struct v4l2_standard *kp, struct v4l2_stand=
ard32 __user *up)
+static int put_v4l2_standard32(struct v4l2_standard __user *kp,
+			       struct v4l2_standard32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_standard32)) ||
-		put_user(kp->index, &up->index) ||
-		copy_to_user(up->id, &kp->id, sizeof(__u64)) ||
-		copy_to_user(up->name, kp->name, 24) ||
-		copy_to_user(&up->frameperiod, &kp->frameperiod, sizeof(kp->frameperiod)=
) ||
-		put_user(kp->framelines, &up->framelines) ||
-		copy_to_user(up->reserved, kp->reserved, 4 * sizeof(__u32)))
-			return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
+	    assign_in_user(&up->index, &kp->index) ||
+	    assign_in_user(&up->id, &kp->id) ||
+	    copy_in_user(up->name, kp->name, sizeof(up->name)) ||
+	    copy_in_user(&up->frameperiod, &kp->frameperiod,
+			 sizeof(up->frameperiod)) ||
+	    assign_in_user(&up->framelines, &kp->framelines) ||
+	    copy_in_user(up->reserved, kp->reserved, sizeof(up->reserved)))
+		return -EFAULT;
 	return 0;
 }
=20
@@ -334,191 +373,242 @@ struct v4l2_buffer32 {
 	__u32			reserved;
 };
=20
-static int get_v4l2_plane32(struct v4l2_plane *up, struct v4l2_plane32 *up=
32,
-				enum v4l2_memory memory)
+static int get_v4l2_plane32(struct v4l2_plane __user *up,
+			    struct v4l2_plane32 __user *up32,
+			    enum v4l2_memory memory)
 {
-	void __user *up_pln;
-	compat_long_t p;
+	compat_ulong_t p;
=20
 	if (copy_in_user(up, up32, 2 * sizeof(__u32)) ||
-		copy_in_user(&up->data_offset, &up32->data_offset,
-				sizeof(__u32)))
+	    copy_in_user(&up->data_offset, &up32->data_offset,
+			 sizeof(up->data_offset)))
 		return -EFAULT;
=20
-	if (memory =3D=3D V4L2_MEMORY_USERPTR) {
-		if (get_user(p, &up32->m.userptr))
-			return -EFAULT;
-		up_pln =3D compat_ptr(p);
-		if (put_user((unsigned long)up_pln, &up->m.userptr))
-			return -EFAULT;
-	} else {
+	switch (memory) {
+	case V4L2_MEMORY_MMAP:
+	case V4L2_MEMORY_OVERLAY:
 		if (copy_in_user(&up->m.mem_offset, &up32->m.mem_offset,
-					sizeof(__u32)))
+				 sizeof(up32->m.mem_offset)))
+			return -EFAULT;
+		break;
+	case V4L2_MEMORY_USERPTR:
+		if (get_user(p, &up32->m.userptr) ||
+		    put_user((unsigned long)compat_ptr(p), &up->m.userptr))
 			return -EFAULT;
+		break;
 	}
=20
 	return 0;
 }
=20
-static int put_v4l2_plane32(struct v4l2_plane *up, struct v4l2_plane32 *up=
32,
-				enum v4l2_memory memory)
+static int put_v4l2_plane32(struct v4l2_plane __user *up,
+			    struct v4l2_plane32 __user *up32,
+			    enum v4l2_memory memory)
 {
+	unsigned long p;
+
 	if (copy_in_user(up32, up, 2 * sizeof(__u32)) ||
-		copy_in_user(&up32->data_offset, &up->data_offset,
-				sizeof(__u32)))
+	    copy_in_user(&up32->data_offset, &up->data_offset,
+			 sizeof(up->data_offset)))
 		return -EFAULT;
=20
-	/* For MMAP, driver might've set up the offset, so copy it back.
-	 * USERPTR stays the same (was userspace-provided), so no copying. */
-	if (memory =3D=3D V4L2_MEMORY_MMAP)
+	switch (memory) {
+	case V4L2_MEMORY_MMAP:
+	case V4L2_MEMORY_OVERLAY:
 		if (copy_in_user(&up32->m.mem_offset, &up->m.mem_offset,
-					sizeof(__u32)))
+				 sizeof(up->m.mem_offset)))
+			return -EFAULT;
+		break;
+	case V4L2_MEMORY_USERPTR:
+		if (get_user(p, &up->m.userptr) ||
+		    put_user((compat_ulong_t)ptr_to_compat((__force void *)p),
+			     &up32->m.userptr))
 			return -EFAULT;
+		break;
+	}
=20
 	return 0;
 }
=20
-static int get_v4l2_buffer32(struct v4l2_buffer *kp, struct v4l2_buffer32 =
__user *up)
+static int bufsize_v4l2_buffer(struct v4l2_buffer32 __user *up, u32 *size)
 {
+	u32 type;
+	u32 length;
+
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
+	    get_user(type, &up->type) ||
+	    get_user(length, &up->length))
+		return -EFAULT;
+
+	if (V4L2_TYPE_IS_MULTIPLANAR(type)) {
+		if (length > VIDEO_MAX_PLANES)
+			return -EINVAL;
+
+		/*
+		 * We don't really care if userspace decides to kill itself
+		 * by passing a very big length value
+		 */
+		*size =3D length * sizeof(struct v4l2_plane);
+	} else {
+		*size =3D 0;
+	}
+	return 0;
+}
+
+static int get_v4l2_buffer32(struct v4l2_buffer __user *kp,
+			     struct v4l2_buffer32 __user *up,
+			     void __user *aux_buf, u32 aux_space)
+{
+	u32 type;
+	u32 length;
+	enum v4l2_memory memory;
 	struct v4l2_plane32 __user *uplane32;
 	struct v4l2_plane __user *uplane;
 	compat_caddr_t p;
-	int num_planes;
 	int ret;
=20
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_buffer32)) ||
-		get_user(kp->index, &up->index) ||
-		get_user(kp->type, &up->type) ||
-		get_user(kp->flags, &up->flags) ||
-		get_user(kp->memory, &up->memory) ||
-		get_user(kp->input, &up->input))
-			return -EFAULT;
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
+	    assign_in_user(&kp->index, &up->index) ||
+	    get_user(type, &up->type) ||
+	    put_user(type, &kp->type) ||
+	    assign_in_user(&kp->flags, &up->flags) ||
+	    get_user(memory, &up->memory) ||
+	    put_user(memory, &kp->memory) ||
+	    get_user(length, &up->length) ||
+	    put_user(length, &kp->length))
+		return -EFAULT;
=20
-	if (V4L2_TYPE_IS_OUTPUT(kp->type))
-		if (get_user(kp->bytesused, &up->bytesused) ||
-			get_user(kp->field, &up->field) ||
-			get_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
-			get_user(kp->timestamp.tv_usec,
-					&up->timestamp.tv_usec))
+	if (V4L2_TYPE_IS_OUTPUT(type))
+		if (assign_in_user(&kp->bytesused, &up->bytesused) ||
+		    assign_in_user(&kp->field, &up->field) ||
+		    assign_in_user(&kp->timestamp.tv_sec,
+				   &up->timestamp.tv_sec) ||
+		    assign_in_user(&kp->timestamp.tv_usec,
+				   &up->timestamp.tv_usec))
 			return -EFAULT;
=20
-	if (V4L2_TYPE_IS_MULTIPLANAR(kp->type)) {
-		if (get_user(kp->length, &up->length))
-			return -EFAULT;
+	if (V4L2_TYPE_IS_MULTIPLANAR(type)) {
+		u32 num_planes =3D length;
=20
-		num_planes =3D kp->length;
 		if (num_planes =3D=3D 0) {
-			kp->m.planes =3D NULL;
-			/* num_planes =3D=3D 0 is legal, e.g. when userspace doesn't
-			 * need planes array on DQBUF*/
-			return 0;
+			/*
+			 * num_planes =3D=3D 0 is legal, e.g. when userspace doesn't
+			 * need planes array on DQBUF
+			 */
+			return put_user(NULL, &kp->m.planes);
 		}
+		if (num_planes > VIDEO_MAX_PLANES)
+			return -EINVAL;
=20
 		if (get_user(p, &up->m.planes))
 			return -EFAULT;
=20
 		uplane32 =3D compat_ptr(p);
 		if (!access_ok(VERIFY_READ, uplane32,
-				num_planes * sizeof(struct v4l2_plane32)))
+			       num_planes * sizeof(*uplane32)))
+			return -EFAULT;
+
+		/*
+		 * We don't really care if userspace decides to kill itself
+		 * by passing a very big num_planes value
+		 */
+		if (aux_space < num_planes * sizeof(*uplane))
 			return -EFAULT;
=20
-		/* We don't really care if userspace decides to kill itself
-		 * by passing a very big num_planes value */
-		uplane =3D compat_alloc_user_space(num_planes *
-						sizeof(struct v4l2_plane));
-		kp->m.planes =3D uplane;
+		uplane =3D aux_buf;
+		if (put_user((__force struct v4l2_plane *)uplane,
+			     &kp->m.planes))
+			return -EFAULT;
=20
-		while (--num_planes >=3D 0) {
-			ret =3D get_v4l2_plane32(uplane, uplane32, kp->memory);
+		while (num_planes--) {
+			ret =3D get_v4l2_plane32(uplane, uplane32, memory);
 			if (ret)
 				return ret;
-			++uplane;
-			++uplane32;
+			uplane++;
+			uplane32++;
 		}
 	} else {
-		switch (kp->memory) {
+		switch (memory) {
 		case V4L2_MEMORY_MMAP:
-			if (get_user(kp->length, &up->length) ||
-				get_user(kp->m.offset, &up->m.offset))
+		case V4L2_MEMORY_OVERLAY:
+			if (assign_in_user(&kp->m.offset, &up->m.offset))
 				return -EFAULT;
 			break;
-		case V4L2_MEMORY_USERPTR:
-			{
-			compat_long_t tmp;
+		case V4L2_MEMORY_USERPTR: {
+			compat_ulong_t userptr;
=20
-			if (get_user(kp->length, &up->length) ||
-			    get_user(tmp, &up->m.userptr))
-				return -EFAULT;
-
-			kp->m.userptr =3D (unsigned long)compat_ptr(tmp);
-			}
-			break;
-		case V4L2_MEMORY_OVERLAY:
-			if (get_user(kp->m.offset, &up->m.offset))
+			if (get_user(userptr, &up->m.userptr) ||
+			    put_user((unsigned long)compat_ptr(userptr),
+				     &kp->m.userptr))
 				return -EFAULT;
 			break;
 		}
+ 		}
 	}
=20
 	return 0;
 }
=20
-static int put_v4l2_buffer32(struct v4l2_buffer *kp, struct v4l2_buffer32 =
__user *up)
+static int put_v4l2_buffer32(struct v4l2_buffer __user *kp,
+			     struct v4l2_buffer32 __user *up)
 {
+	u32 type;
+	u32 length;
+	enum v4l2_memory memory;
 	struct v4l2_plane32 __user *uplane32;
 	struct v4l2_plane __user *uplane;
 	compat_caddr_t p;
-	int num_planes;
 	int ret;
=20
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_buffer32)) ||
-		put_user(kp->index, &up->index) ||
-		put_user(kp->type, &up->type) ||
-		put_user(kp->flags, &up->flags) ||
-		put_user(kp->memory, &up->memory) ||
-		put_user(kp->input, &up->input))
-			return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
+	    assign_in_user(&up->index, &kp->index) ||
+	    get_user(type, &kp->type) ||
+	    put_user(type, &up->type) ||
+	    assign_in_user(&up->flags, &kp->flags) ||
+	    get_user(memory, &kp->memory) ||
+	    put_user(memory, &up->memory))
+		return -EFAULT;
=20
-	if (put_user(kp->bytesused, &up->bytesused) ||
-		put_user(kp->field, &up->field) ||
-		put_user(kp->timestamp.tv_sec, &up->timestamp.tv_sec) ||
-		put_user(kp->timestamp.tv_usec, &up->timestamp.tv_usec) ||
-		copy_to_user(&up->timecode, &kp->timecode, sizeof(struct v4l2_timecode))=
 ||
-		put_user(kp->sequence, &up->sequence) ||
-		put_user(kp->reserved, &up->reserved))
-			return -EFAULT;
+	if (assign_in_user(&up->bytesused, &kp->bytesused) ||
+	    assign_in_user(&up->field, &kp->field) ||
+	    assign_in_user(&up->timestamp.tv_sec, &kp->timestamp.tv_sec) ||
+	    assign_in_user(&up->timestamp.tv_usec, &kp->timestamp.tv_usec) ||
+	    copy_in_user(&up->timecode, &kp->timecode, sizeof(kp->timecode)) ||
+	    assign_in_user(&up->sequence, &kp->sequence) ||
+	    assign_in_user(&up->input, &kp->input) ||
+	    assign_in_user(&up->reserved, &kp->reserved) ||
+	    get_user(length, &kp->length) ||
+	    put_user(length, &up->length))
+		return -EFAULT;
+
+	if (V4L2_TYPE_IS_MULTIPLANAR(type)) {
+		u32 num_planes =3D length;
=20
-	if (V4L2_TYPE_IS_MULTIPLANAR(kp->type)) {
-		num_planes =3D kp->length;
 		if (num_planes =3D=3D 0)
 			return 0;
=20
-		uplane =3D kp->m.planes;
+		if (get_user(uplane, ((__force struct v4l2_plane __user **)&kp->m.planes=
)))
+			return -EFAULT;
 		if (get_user(p, &up->m.planes))
 			return -EFAULT;
 		uplane32 =3D compat_ptr(p);
=20
-		while (--num_planes >=3D 0) {
-			ret =3D put_v4l2_plane32(uplane, uplane32, kp->memory);
+		while (num_planes--) {
+			ret =3D put_v4l2_plane32(uplane, uplane32, memory);
 			if (ret)
 				return ret;
 			++uplane;
 			++uplane32;
 		}
 	} else {
-		switch (kp->memory) {
+		switch (memory) {
 		case V4L2_MEMORY_MMAP:
-			if (put_user(kp->length, &up->length) ||
-				put_user(kp->m.offset, &up->m.offset))
+		case V4L2_MEMORY_OVERLAY:
+			if (assign_in_user(&up->m.offset, &kp->m.offset))
 				return -EFAULT;
 			break;
 		case V4L2_MEMORY_USERPTR:
-			if (put_user(kp->length, &up->length) ||
-				put_user(kp->m.userptr, &up->m.userptr))
-				return -EFAULT;
-			break;
-		case V4L2_MEMORY_OVERLAY:
-			if (put_user(kp->m.offset, &up->m.offset))
+			if (assign_in_user(&up->m.userptr, &kp->m.userptr))
 				return -EFAULT;
 			break;
 		}
@@ -530,34 +620,46 @@ static int put_v4l2_buffer32(struct v4l2_buffer *kp, =
struct v4l2_buffer32 __user
 struct v4l2_framebuffer32 {
 	__u32			capability;
 	__u32			flags;
-	compat_caddr_t 		base;
-	struct v4l2_pix_format	fmt;
+	compat_caddr_t		base;
+	struct {
+		__u32		width;
+		__u32		height;
+		__u32		pixelformat;
+		__u32		field;
+		__u32		bytesperline;
+		__u32		sizeimage;
+		__u32		colorspace;
+		__u32		priv;
+	} fmt;
 };
=20
-static int get_v4l2_framebuffer32(struct v4l2_framebuffer *kp, struct v4l2=
_framebuffer32 __user *up)
+static int get_v4l2_framebuffer32(struct v4l2_framebuffer __user *kp,
+				  struct v4l2_framebuffer32 __user *up)
 {
-	u32 tmp;
-
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_framebuffer32)) ||
-		get_user(tmp, &up->base) ||
-		get_user(kp->capability, &up->capability) ||
-		get_user(kp->flags, &up->flags))
-			return -EFAULT;
-	kp->base =3D compat_ptr(tmp);
-	get_v4l2_pix_format(&kp->fmt, &up->fmt);
+	compat_caddr_t tmp;
+
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
+	    get_user(tmp, &up->base) ||
+	    put_user((__force void *)compat_ptr(tmp), &kp->base) ||
+	    assign_in_user(&kp->capability, &up->capability) ||
+	    assign_in_user(&kp->flags, &up->flags) ||
+	    copy_in_user(&kp->fmt, &up->fmt, sizeof(kp->fmt)))
+		return -EFAULT;
 	return 0;
 }
=20
-static int put_v4l2_framebuffer32(struct v4l2_framebuffer *kp, struct v4l2=
_framebuffer32 __user *up)
+static int put_v4l2_framebuffer32(struct v4l2_framebuffer __user *kp,
+				  struct v4l2_framebuffer32 __user *up)
 {
-	u32 tmp =3D (u32)((unsigned long)kp->base);
-
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_framebuffer32)) ||
-		put_user(tmp, &up->base) ||
-		put_user(kp->capability, &up->capability) ||
-		put_user(kp->flags, &up->flags))
-			return -EFAULT;
-	put_v4l2_pix_format(&kp->fmt, &up->fmt);
+	void *base;
+
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
+	    get_user(base, &kp->base) ||
+	    put_user(ptr_to_compat(base), &up->base) ||
+	    assign_in_user(&up->capability, &kp->capability) ||
+	    assign_in_user(&up->flags, &kp->flags) ||
+	    copy_in_user(&up->fmt, &kp->fmt, sizeof(kp->fmt)))
+		return -EFAULT;
 	return 0;
 }
=20
@@ -567,33 +669,38 @@ struct v4l2_input32 {
 	__u32	     type;		/*  Type of input */
 	__u32	     audioset;		/*  Associated audios (bitfield) */
 	__u32        tuner;             /*  Associated tuner */
-	v4l2_std_id  std;
+	compat_u64   std;
 	__u32	     status;
-	__u32	     reserved[4];
-} __attribute__ ((packed));
+	__u32	     capabilities;
+	__u32	     reserved[3];
+};
=20
-/* The 64-bit v4l2_input struct has extra padding at the end of the struct.
-   Otherwise it is identical to the 32-bit version. */
-static inline int get_v4l2_input32(struct v4l2_input *kp, struct v4l2_inpu=
t32 __user *up)
+/*
+ * The 64-bit v4l2_input struct has extra padding at the end of the struct.
+ * Otherwise it is identical to the 32-bit version.
+ */
+static inline int get_v4l2_input32(struct v4l2_input __user *kp,
+				   struct v4l2_input32 __user *up)
 {
-	if (copy_from_user(kp, up, sizeof(struct v4l2_input32)))
+	if (copy_in_user(kp, up, sizeof(*up)))
 		return -EFAULT;
 	return 0;
 }
=20
-static inline int put_v4l2_input32(struct v4l2_input *kp, struct v4l2_inpu=
t32 __user *up)
+static inline int put_v4l2_input32(struct v4l2_input __user *kp,
+				   struct v4l2_input32 __user *up)
 {
-	if (copy_to_user(up, kp, sizeof(struct v4l2_input32)))
+	if (copy_in_user(up, kp, sizeof(*up)))
 		return -EFAULT;
 	return 0;
 }
=20
 struct v4l2_ext_controls32 {
-       __u32 ctrl_class;
-       __u32 count;
-       __u32 error_idx;
-       __u32 reserved[2];
-       compat_caddr_t controls; /* actually struct v4l2_ext_control32 * */
+	__u32 ctrl_class;
+	__u32 count;
+	__u32 error_idx;
+	__u32 reserved[2];
+	compat_caddr_t controls; /* actually struct v4l2_ext_control32 * */
 };
=20
 struct v4l2_ext_control32 {
@@ -607,53 +714,88 @@ struct v4l2_ext_control32 {
 	};
 } __attribute__ ((packed));
=20
-/* The following function really belong in v4l2-common, but that causes
-   a circular dependency between modules. We need to think about this, but
-   for now this will do. */
-
-/* Return non-zero if this control is a pointer type. Currently only
-   type STRING is a pointer type. */
-static inline int ctrl_is_pointer(u32 id)
+/* Return true if this control is a pointer type. */
+static inline bool ctrl_is_pointer(struct file *file, u32 id)
 {
-	switch (id) {
-	case V4L2_CID_RDS_TX_PS_NAME:
-	case V4L2_CID_RDS_TX_RADIO_TEXT:
-		return 1;
-	default:
-		return 0;
+	struct video_device *vdev =3D video_devdata(file);
+	struct v4l2_fh *fh =3D NULL;
+	struct v4l2_ctrl_handler *hdl =3D NULL;
+
+	if (test_bit(V4L2_FL_USES_V4L2_FH, &vdev->flags))
+		fh =3D file->private_data;
+
+	if (fh && fh->ctrl_handler)
+		hdl =3D fh->ctrl_handler;
+	else if (vdev->ctrl_handler)
+		hdl =3D vdev->ctrl_handler;
+
+	if (hdl) {
+		struct v4l2_ctrl *ctrl =3D v4l2_ctrl_find(hdl, id);
+
+		return ctrl && ctrl->type =3D=3D V4L2_CTRL_TYPE_STRING;
 	}
+	return false;
+}
+
+static int bufsize_v4l2_ext_controls(struct v4l2_ext_controls32 __user *up,
+				     u32 *size)
+{
+	u32 count;
+
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
+	    get_user(count, &up->count))
+		return -EFAULT;
+	if (count > V4L2_CID_MAX_CTRLS)
+		return -EINVAL;
+	*size =3D count * sizeof(struct v4l2_ext_control);
+	return 0;
 }
=20
-static int get_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4=
l2_ext_controls32 __user *up)
+static int get_v4l2_ext_controls32(struct file *file,
+				   struct v4l2_ext_controls __user *kp,
+				   struct v4l2_ext_controls32 __user *up,
+				   void __user *aux_buf, u32 aux_space)
 {
 	struct v4l2_ext_control32 __user *ucontrols;
 	struct v4l2_ext_control __user *kcontrols;
-	int n;
+	u32 count;
+	u32 n;
 	compat_caddr_t p;
=20
-	if (!access_ok(VERIFY_READ, up, sizeof(struct v4l2_ext_controls32)) ||
-		get_user(kp->ctrl_class, &up->ctrl_class) ||
-		get_user(kp->count, &up->count) ||
-		get_user(kp->error_idx, &up->error_idx) ||
-		copy_from_user(kp->reserved, up->reserved, sizeof(kp->reserved)))
-			return -EFAULT;
-	n =3D kp->count;
-	if (n =3D=3D 0) {
-		kp->controls =3D NULL;
-		return 0;
-	}
+	if (!access_ok(VERIFY_READ, up, sizeof(*up)) ||
+	    assign_in_user(&kp->ctrl_class, &up->ctrl_class) ||
+	    get_user(count, &up->count) ||
+	    put_user(count, &kp->count) ||
+	    assign_in_user(&kp->error_idx, &up->error_idx) ||
+	    copy_in_user(kp->reserved, up->reserved, sizeof(kp->reserved)))
+		return -EFAULT;
+
+	if (count =3D=3D 0)
+		return put_user(NULL, &kp->controls);
+	if (count > V4L2_CID_MAX_CTRLS)
+		return -EINVAL;
 	if (get_user(p, &up->controls))
 		return -EFAULT;
 	ucontrols =3D compat_ptr(p);
-	if (!access_ok(VERIFY_READ, ucontrols,
-			n * sizeof(struct v4l2_ext_control32)))
+	if (!access_ok(VERIFY_READ, ucontrols, count * sizeof(*ucontrols)))
 		return -EFAULT;
-	kcontrols =3D compat_alloc_user_space(n * sizeof(struct v4l2_ext_control)=
);
-	kp->controls =3D kcontrols;
-	while (--n >=3D 0) {
+	if (aux_space < count * sizeof(*kcontrols))
+		return -EFAULT;
+	kcontrols =3D aux_buf;
+	if (put_user((__force struct v4l2_ext_control *)kcontrols,
+		     &kp->controls))
+		return -EFAULT;
+
+	for (n =3D 0; n < count; n++) {
+		u32 id;
+
 		if (copy_in_user(kcontrols, ucontrols, sizeof(*ucontrols)))
 			return -EFAULT;
-		if (ctrl_is_pointer(kcontrols->id)) {
+
+		if (get_user(id, &kcontrols->id))
+			return -EFAULT;
+
+		if (ctrl_is_pointer(file, id)) {
 			void __user *s;
=20
 			if (get_user(p, &ucontrols->string))
@@ -668,39 +810,55 @@ static int get_v4l2_ext_controls32(struct v4l2_ext_co=
ntrols *kp, struct v4l2_ext
 	return 0;
 }
=20
-static int put_v4l2_ext_controls32(struct v4l2_ext_controls *kp, struct v4=
l2_ext_controls32 __user *up)
+static int put_v4l2_ext_controls32(struct file *file,
+				   struct v4l2_ext_controls __user *kp,
+				   struct v4l2_ext_controls32 __user *up)
 {
 	struct v4l2_ext_control32 __user *ucontrols;
-	struct v4l2_ext_control __user *kcontrols =3D kp->controls;
-	int n =3D kp->count;
+	struct v4l2_ext_control __user *kcontrols;
+	u32 count;
+	u32 n;
 	compat_caddr_t p;
=20
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_ext_controls32)) ||
-		put_user(kp->ctrl_class, &up->ctrl_class) ||
-		put_user(kp->count, &up->count) ||
-		put_user(kp->error_idx, &up->error_idx) ||
-		copy_to_user(up->reserved, kp->reserved, sizeof(up->reserved)))
-			return -EFAULT;
-	if (!kp->count)
-		return 0;
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
+	    assign_in_user(&up->ctrl_class, &kp->ctrl_class) ||
+	    get_user(count, &kp->count) ||
+	    put_user(count, &up->count) ||
+	    assign_in_user(&up->error_idx, &kp->error_idx) ||
+	    copy_in_user(up->reserved, kp->reserved, sizeof(up->reserved)) ||
+	    get_user(kcontrols, &kp->controls))
+		return -EFAULT;
=20
+	if (!count)
+		return 0;
 	if (get_user(p, &up->controls))
 		return -EFAULT;
 	ucontrols =3D compat_ptr(p);
-	if (!access_ok(VERIFY_WRITE, ucontrols,
-			n * sizeof(struct v4l2_ext_control32)))
+	if (!access_ok(VERIFY_WRITE, ucontrols, count * sizeof(*ucontrols)))
 		return -EFAULT;
=20
-	while (--n >=3D 0) {
-		unsigned size =3D sizeof(*ucontrols);
+	for (n =3D 0; n < count; n++) {
+		unsigned int size =3D sizeof(*ucontrols);
+		u32 id;
=20
-		/* Do not modify the pointer when copying a pointer control.
-		   The contents of the pointer was changed, not the pointer
-		   itself. */
-		if (ctrl_is_pointer(kcontrols->id))
+		if (get_user(id, &kcontrols->id) ||
+		    put_user(id, &ucontrols->id) ||
+		    assign_in_user(&ucontrols->size, &kcontrols->size) ||
+		    copy_in_user(&ucontrols->reserved2, &kcontrols->reserved2,
+				 sizeof(ucontrols->reserved2)))
+			return -EFAULT;
+
+		/*
+		 * Do not modify the pointer when copying a pointer control.
+		 * The contents of the pointer was changed, not the pointer
+		 * itself.
+		 */
+		if (ctrl_is_pointer(file, id))
 			size -=3D sizeof(ucontrols->value64);
+
 		if (copy_in_user(ucontrols, kcontrols, size))
 			return -EFAULT;
+
 		ucontrols++;
 		kcontrols++;
 	}
@@ -710,6 +868,7 @@ static int put_v4l2_ext_controls32(struct v4l2_ext_cont=
rols *kp, struct v4l2_ext
 struct v4l2_event32 {
 	__u32				type;
 	union {
+		compat_s64		value64;
 		__u8			data[64];
 	} u;
 	__u32				pending;
@@ -719,17 +878,19 @@ struct v4l2_event32 {
 	__u32				reserved[8];
 };
=20
-static int put_v4l2_event32(struct v4l2_event *kp, struct v4l2_event32 __u=
ser *up)
+static int put_v4l2_event32(struct v4l2_event __user *kp,
+			    struct v4l2_event32 __user *up)
 {
-	if (!access_ok(VERIFY_WRITE, up, sizeof(struct v4l2_event32)) ||
-		put_user(kp->type, &up->type) ||
-		copy_to_user(&up->u, &kp->u, sizeof(kp->u)) ||
-		put_user(kp->pending, &up->pending) ||
-		put_user(kp->sequence, &up->sequence) ||
-		put_compat_timespec(&kp->timestamp, &up->timestamp) ||
-		put_user(kp->id, &up->id) ||
-		copy_to_user(up->reserved, kp->reserved, 8 * sizeof(__u32)))
-			return -EFAULT;
+	if (!access_ok(VERIFY_WRITE, up, sizeof(*up)) ||
+	    assign_in_user(&up->type, &kp->type) ||
+	    copy_in_user(&up->u, &kp->u, sizeof(kp->u)) ||
+	    assign_in_user(&up->pending, &kp->pending) ||
+	    assign_in_user(&up->sequence, &kp->sequence) ||
+	    assign_in_user(&up->timestamp.tv_sec, &kp->timestamp.tv_sec) ||
+	    assign_in_user(&up->timestamp.tv_nsec, &kp->timestamp.tv_nsec) ||
+	    assign_in_user(&up->id, &kp->id) ||
+	    copy_in_user(up->reserved, kp->reserved, sizeof(up->reserved)))
+		return -EFAULT;
 	return 0;
 }
=20
@@ -742,7 +903,7 @@ static int put_v4l2_event32(struct v4l2_event *kp, stru=
ct v4l2_event32 __user *u
 #define VIDIOC_DQBUF32		_IOWR('V', 17, struct v4l2_buffer32)
 #define VIDIOC_ENUMSTD32	_IOWR('V', 25, struct v4l2_standard32)
 #define VIDIOC_ENUMINPUT32	_IOWR('V', 26, struct v4l2_input32)
-#define VIDIOC_TRY_FMT32      	_IOWR('V', 64, struct v4l2_format32)
+#define VIDIOC_TRY_FMT32	_IOWR('V', 64, struct v4l2_format32)
 #define VIDIOC_G_EXT_CTRLS32    _IOWR('V', 71, struct v4l2_ext_controls32)
 #define VIDIOC_S_EXT_CTRLS32    _IOWR('V', 72, struct v4l2_ext_controls32)
 #define VIDIOC_TRY_EXT_CTRLS32  _IOWR('V', 73, struct v4l2_ext_controls32)
@@ -758,21 +919,23 @@ static int put_v4l2_event32(struct v4l2_event *kp, st=
ruct v4l2_event32 __user *u
 #define VIDIOC_G_OUTPUT32	_IOR ('V', 46, s32)
 #define VIDIOC_S_OUTPUT32	_IOWR('V', 47, s32)
=20
+static int alloc_userspace(unsigned int size, u32 aux_space,
+			   void __user **up_native)
+{
+	*up_native =3D compat_alloc_user_space(size + aux_space);
+	if (!*up_native)
+		return -ENOMEM;
+	if (clear_user(*up_native, size))
+		return -EFAULT;
+	return 0;
+}
+
 static long do_video_ioctl(struct file *file, unsigned int cmd, unsigned l=
ong arg)
 {
-	union {
-		struct v4l2_format v2f;
-		struct v4l2_buffer v2b;
-		struct v4l2_framebuffer v2fb;
-		struct v4l2_input v2i;
-		struct v4l2_standard v2s;
-		struct v4l2_ext_controls v2ecs;
-		struct v4l2_event v2ev;
-		struct v4l2_create_buffers v2crt;
-		unsigned long vx;
-		int vi;
-	} karg;
 	void __user *up =3D compat_ptr(arg);
+	void __user *up_native =3D NULL;
+	void __user *aux_buf;
+	u32 aux_space;
 	int compatible_arg =3D 1;
 	long err =3D 0;
=20
@@ -809,24 +972,44 @@ static long do_video_ioctl(struct file *file, unsigne=
d int cmd, unsigned long ar
 	case VIDIOC_STREAMOFF:
 	case VIDIOC_S_INPUT:
 	case VIDIOC_S_OUTPUT:
-		err =3D get_user(karg.vi, (s32 __user *)up);
+		err =3D alloc_userspace(sizeof(unsigned int), 0, &up_native);
+		if (!err && assign_in_user((unsigned int __user *)up_native,
+					   (compat_uint_t __user *)up))
+			err =3D -EFAULT;
 		compatible_arg =3D 0;
 		break;
=20
 	case VIDIOC_G_INPUT:
 	case VIDIOC_G_OUTPUT:
+		err =3D alloc_userspace(sizeof(unsigned int), 0, &up_native);
 		compatible_arg =3D 0;
 		break;
=20
 	case VIDIOC_G_FMT:
 	case VIDIOC_S_FMT:
 	case VIDIOC_TRY_FMT:
-		err =3D get_v4l2_format32(&karg.v2f, up);
+		err =3D bufsize_v4l2_format(up, &aux_space);
+		if (!err)
+			err =3D alloc_userspace(sizeof(struct v4l2_format),
+					      aux_space, &up_native);
+		if (!err) {
+			aux_buf =3D up_native + sizeof(struct v4l2_format);
+			err =3D get_v4l2_format32(up_native, up,
+						aux_buf, aux_space);
+		}
 		compatible_arg =3D 0;
 		break;
=20
 	case VIDIOC_CREATE_BUFS:
-		err =3D get_v4l2_create32(&karg.v2crt, up);
+		err =3D bufsize_v4l2_create(up, &aux_space);
+		if (!err)
+			err =3D alloc_userspace(sizeof(struct v4l2_create_buffers),
+					      aux_space, &up_native);
+		if (!err) {
+			aux_buf =3D up_native + sizeof(struct v4l2_create_buffers);
+			err =3D get_v4l2_create32(up_native, up,
+						aux_buf, aux_space);
+		}
 		compatible_arg =3D 0;
 		break;
=20
@@ -834,36 +1017,63 @@ static long do_video_ioctl(struct file *file, unsign=
ed int cmd, unsigned long ar
 	case VIDIOC_QUERYBUF:
 	case VIDIOC_QBUF:
 	case VIDIOC_DQBUF:
-		err =3D get_v4l2_buffer32(&karg.v2b, up);
+		err =3D bufsize_v4l2_buffer(up, &aux_space);
+		if (!err)
+			err =3D alloc_userspace(sizeof(struct v4l2_buffer),
+					      aux_space, &up_native);
+		if (!err) {
+			aux_buf =3D up_native + sizeof(struct v4l2_buffer);
+			err =3D get_v4l2_buffer32(up_native, up,
+						aux_buf, aux_space);
+		}
 		compatible_arg =3D 0;
 		break;
=20
 	case VIDIOC_S_FBUF:
-		err =3D get_v4l2_framebuffer32(&karg.v2fb, up);
+		err =3D alloc_userspace(sizeof(struct v4l2_framebuffer), 0,
+				      &up_native);
+		if (!err)
+			err =3D get_v4l2_framebuffer32(up_native, up);
 		compatible_arg =3D 0;
 		break;
=20
 	case VIDIOC_G_FBUF:
+		err =3D alloc_userspace(sizeof(struct v4l2_framebuffer), 0,
+				      &up_native);
 		compatible_arg =3D 0;
 		break;
=20
 	case VIDIOC_ENUMSTD:
-		err =3D get_v4l2_standard32(&karg.v2s, up);
+		err =3D alloc_userspace(sizeof(struct v4l2_standard), 0,
+				      &up_native);
+		if (!err)
+			err =3D get_v4l2_standard32(up_native, up);
 		compatible_arg =3D 0;
 		break;
=20
 	case VIDIOC_ENUMINPUT:
-		err =3D get_v4l2_input32(&karg.v2i, up);
+		err =3D alloc_userspace(sizeof(struct v4l2_input), 0, &up_native);
+		if (!err)
+			err =3D get_v4l2_input32(up_native, up);
 		compatible_arg =3D 0;
 		break;
=20
 	case VIDIOC_G_EXT_CTRLS:
 	case VIDIOC_S_EXT_CTRLS:
 	case VIDIOC_TRY_EXT_CTRLS:
-		err =3D get_v4l2_ext_controls32(&karg.v2ecs, up);
+		err =3D bufsize_v4l2_ext_controls(up, &aux_space);
+		if (!err)
+			err =3D alloc_userspace(sizeof(struct v4l2_ext_controls),
+					      aux_space, &up_native);
+		if (!err) {
+			aux_buf =3D up_native + sizeof(struct v4l2_ext_controls);
+			err =3D get_v4l2_ext_controls32(file, up_native, up,
+						      aux_buf, aux_space);
+		}
 		compatible_arg =3D 0;
 		break;
 	case VIDIOC_DQEVENT:
+		err =3D alloc_userspace(sizeof(struct v4l2_event), 0, &up_native);
 		compatible_arg =3D 0;
 		break;
 	}
@@ -872,22 +1082,22 @@ static long do_video_ioctl(struct file *file, unsign=
ed int cmd, unsigned long ar
=20
 	if (compatible_arg)
 		err =3D native_ioctl(file, cmd, (unsigned long)up);
-	else {
-		mm_segment_t old_fs =3D get_fs();
+	else
+		err =3D native_ioctl(file, cmd, (unsigned long)up_native);
=20
-		set_fs(KERNEL_DS);
-		err =3D native_ioctl(file, cmd, (unsigned long)&karg);
-		set_fs(old_fs);
-	}
+	if (err =3D=3D -ENOTTY)
+		return err;
=20
-	/* Special case: even after an error we need to put the
-	   results back for these ioctls since the error_idx will
-	   contain information on which control failed. */
+	/*
+	 * Special case: even after an error we need to put the
+	 * results back for these ioctls since the error_idx will
+	 * contain information on which control failed.
+	 */
 	switch (cmd) {
 	case VIDIOC_G_EXT_CTRLS:
 	case VIDIOC_S_EXT_CTRLS:
 	case VIDIOC_TRY_EXT_CTRLS:
-		if (put_v4l2_ext_controls32(&karg.v2ecs, up))
+		if (put_v4l2_ext_controls32(file, up_native, up))
 			err =3D -EFAULT;
 		break;
 	}
@@ -899,39 +1109,42 @@ static long do_video_ioctl(struct file *file, unsign=
ed int cmd, unsigned long ar
 	case VIDIOC_S_OUTPUT:
 	case VIDIOC_G_INPUT:
 	case VIDIOC_G_OUTPUT:
-		err =3D put_user(((s32)karg.vi), (s32 __user *)up);
+		if (assign_in_user((compat_uint_t __user *)up,
+				   ((unsigned int __user *)up_native)))
+			err =3D -EFAULT;
 		break;
=20
 	case VIDIOC_G_FBUF:
-		err =3D put_v4l2_framebuffer32(&karg.v2fb, up);
+		err =3D put_v4l2_framebuffer32(up_native, up);
 		break;
=20
 	case VIDIOC_DQEVENT:
-		err =3D put_v4l2_event32(&karg.v2ev, up);
+		err =3D put_v4l2_event32(up_native, up);
 		break;
=20
 	case VIDIOC_G_FMT:
 	case VIDIOC_S_FMT:
 	case VIDIOC_TRY_FMT:
-		err =3D put_v4l2_format32(&karg.v2f, up);
+		err =3D put_v4l2_format32(up_native, up);
 		break;
=20
 	case VIDIOC_CREATE_BUFS:
-		err =3D put_v4l2_create32(&karg.v2crt, up);
+		err =3D put_v4l2_create32(up_native, up);
 		break;
=20
+	case VIDIOC_PREPARE_BUF:
 	case VIDIOC_QUERYBUF:
 	case VIDIOC_QBUF:
 	case VIDIOC_DQBUF:
-		err =3D put_v4l2_buffer32(&karg.v2b, up);
+		err =3D put_v4l2_buffer32(up_native, up);
 		break;
=20
 	case VIDIOC_ENUMSTD:
-		err =3D put_v4l2_standard32(&karg.v2s, up);
+		err =3D put_v4l2_standard32(up_native, up);
 		break;
=20
 	case VIDIOC_ENUMINPUT:
-		err =3D put_v4l2_input32(&karg.v2i, up);
+		err =3D put_v4l2_input32(up_native, up);
 		break;
 	}
 	return err;
@@ -1026,8 +1239,8 @@ long v4l2_compat_ioctl32(struct file *file, unsigned =
int cmd, unsigned long arg)
=20
 	default:
 		printk(KERN_WARNING "compat_ioctl32: "
-			"unknown ioctl '%c', dir=3D%d, #%d (0x%08x)\n",
-			_IOC_TYPE(cmd), _IOC_DIR(cmd), _IOC_NR(cmd), cmd);
+		       "unknown ioctl '%c', dir=3D%d, #%d (0x%08x)\n",
+		       _IOC_TYPE(cmd), _IOC_DIR(cmd), _IOC_NR(cmd), cmd);
 		break;
 	}
 	return ret;
diff --git a/drivers/media/video/v4l2-ioctl.c b/drivers/media/video/v4l2-io=
ctl.c
index 639abeee3392..bae5dd776d82 100644
--- a/drivers/media/video/v4l2-ioctl.c
+++ b/drivers/media/video/v4l2-ioctl.c
@@ -2308,8 +2308,10 @@ video_usercopy(struct file *file, unsigned int cmd, =
unsigned long arg,
=20
 	/* Handles IOCTL */
 	err =3D func(file, cmd, parg);
-	if (err =3D=3D -ENOIOCTLCMD)
-		err =3D -EINVAL;
+	if (err =3D=3D -ENOTTY || err =3D=3D -ENOIOCTLCMD) {
+		err =3D -ENOTTY;
+		goto out;
+	}
=20
 	if (has_array_args) {
 		*kernel_ptr =3D user_ptr;
diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index ab1ad41786d1..18b2decd14b2 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -274,6 +274,9 @@ static ssize_t at24_read(struct at24_data *at24,
 	if (unlikely(!count))
 		return count;
=20
+	if (off + count > at24->chip.byte_len)
+		return -EINVAL;
+
 	/*
 	 * Read data from chip, protecting against concurrent updates
 	 * from this host, but not from other I2C masters.
@@ -396,6 +399,9 @@ static ssize_t at24_write(struct at24_data *at24, const=
 char *buf, loff_t off,
 	if (unlikely(!count))
 		return count;
=20
+	if (off + count > at24->chip.byte_len)
+		return -EINVAL;
+
 	/*
 	 * Write data to chip, protecting against concurrent updates
 	 * from this host, but not from other I2C masters.
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 720f99334a7f..1530fb424316 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1460,7 +1460,9 @@ static const struct file_operations s3cmci_fops_state=
 =3D {
 struct s3cmci_reg {
 	unsigned short	addr;
 	unsigned char	*name;
-} debug_regs[] =3D {
+};
+
+static const struct s3cmci_reg debug_regs[] =3D {
 	DBG_REG(CON),
 	DBG_REG(PRE),
 	DBG_REG(CMDARG),
@@ -1482,7 +1484,7 @@ struct s3cmci_reg {
 static int s3cmci_regs_show(struct seq_file *seq, void *v)
 {
 	struct s3cmci_host *host =3D seq->private;
-	struct s3cmci_reg *rptr =3D debug_regs;
+	const struct s3cmci_reg *rptr =3D debug_regs;
=20
 	for (; rptr->name; rptr++)
 		seq_printf(seq, "SDI%s\t=3D0x%08x\n", rptr->name,
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index a5eeeb189764..af3abc6f47bc 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -651,6 +651,9 @@ static int ti_hecc_rx_poll(struct napi_struct *napi, in=
t quota)
 		mbx_mask =3D hecc_read(priv, HECC_CANMIM);
 		mbx_mask |=3D HECC_TX_MBOX_MASK;
 		hecc_write(priv, HECC_CANMIM, mbx_mask);
+	} else {
+		/* repoll is done only if whole budget is used */
+		num_pkts =3D quota;
 	}
=20
 	return num_pkts;
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 3b8c4da11f3e..96f500c4a836 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -292,6 +292,8 @@ static void ems_usb_read_interrupt_callback(struct urb =
*urb)
=20
 	case -ECONNRESET: /* unlink */
 	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
=20
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 8e6b832ea061..68b51c06dd92 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -393,6 +393,8 @@ static void esd_usb2_read_bulk_callback(struct urb *urb)
 		break;
=20
 	case -ENOENT:
+	case -EPIPE:
+	case -EPROTO:
 	case -ESHUTDOWN:
 		return;
=20
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/driver=
s/net/ethernet/freescale/fs_enet/fs_enet-main.c
index 5bf5471f06ff..fa595534ffae 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -706,9 +706,11 @@ static int fs_enet_start_xmit(struct sk_buff *skb, str=
uct net_device *dev)
 	return NETDEV_TX_OK;
 }
=20
-static void fs_timeout(struct net_device *dev)
+static void fs_timeout_work(struct work_struct *work)
 {
-	struct fs_enet_private *fep =3D netdev_priv(dev);
+	struct fs_enet_private *fep =3D container_of(work, struct fs_enet_private,
+						   timeout_work);
+	struct net_device *dev =3D fep->ndev;
 	unsigned long flags;
 	int wake =3D 0;
=20
@@ -720,7 +722,6 @@ static void fs_timeout(struct net_device *dev)
 		phy_stop(fep->phydev);
 		(*fep->ops->stop)(dev);
 		(*fep->ops->restart)(dev);
-		phy_start(fep->phydev);
 	}
=20
 	phy_start(fep->phydev);
@@ -731,6 +732,13 @@ static void fs_timeout(struct net_device *dev)
 		netif_wake_queue(dev);
 }
=20
+static void fs_timeout(struct net_device *dev)
+{
+	struct fs_enet_private *fep =3D netdev_priv(dev);
+
+	schedule_work(&fep->timeout_work);
+}
+
 /*------------------------------------------------------------------------=
-----
  *  generic link-change handler - should be sufficient for most cases
  *------------------------------------------------------------------------=
-----*/
@@ -857,6 +865,7 @@ static int fs_enet_close(struct net_device *dev)
 	netif_carrier_off(dev);
 	if (fep->fpi->use_napi)
 		napi_disable(&fep->napi);
+	cancel_work_sync(&fep->timeout_work);
 	phy_stop(fep->phydev);
=20
 	spin_lock_irqsave(&fep->lock, flags);
@@ -1080,6 +1089,7 @@ static int __devinit fs_enet_probe(struct platform_de=
vice *ofdev)
=20
 	ndev->netdev_ops =3D &fs_enet_netdev_ops;
 	ndev->watchdog_timeo =3D 2 * HZ;
+	INIT_WORK(&fep->timeout_work, fs_timeout_work);
 	if (fpi->use_napi)
 		netif_napi_add(ndev, &fep->napi, fs_enet_rx_napi,
 		               fpi->napi_weight);
diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h b/drivers/net=
/ethernet/freescale/fs_enet/fs_enet.h
index 1ece4b1a689e..65b5c5ffcffe 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet.h
@@ -124,6 +124,7 @@ struct fs_enet_private {
 	spinlock_t lock;	/* during all ops except TX pckt processing */
 	spinlock_t tx_lock;	/* during fs_start_xmit and fs_tx         */
 	struct fs_platform_info *fpi;
+	struct work_struct timeout_work;
 	const struct fs_ops *ops;
 	int rx_ring, tx_ring;
 	dma_addr_t ring_mem_addr;
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethe=
rnet/intel/e1000e/ich8lan.c
index e2a80a283fd3..72b994e69c03 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -657,6 +657,9 @@ static s32 e1000_set_eee_pchlan(struct e1000_hw *hw)
  *  Checks to see of the link status of the hardware has changed.  If a
  *  change in link status has been detected, then we read the PHY registers
  *  to get the current speed/duplex if link exists.
+ *
+ *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (li=
nk
+ *  up).
  **/
 static s32 e1000_check_for_copper_link_ich8lan(struct e1000_hw *hw)
 {
@@ -672,7 +675,7 @@ static s32 e1000_check_for_copper_link_ich8lan(struct e=
1000_hw *hw)
 	 * Change or Rx Sequence Error interrupt.
 	 */
 	if (!mac->get_link_status) {
-		ret_val =3D 0;
+		ret_val =3D 1;
 		goto out;
 	}
=20
@@ -761,9 +764,12 @@ static s32 e1000_check_for_copper_link_ich8lan(struct =
e1000_hw *hw)
 	 * different link partner.
 	 */
 	ret_val =3D e1000e_config_fc_after_link_up(hw);
-	if (ret_val)
+	if (ret_val) {
 		e_dbg("Error configuring flow control\n");
+		return ret_val;
+	}
=20
+	ret_val =3D 1;
 out:
 	return ret_val;
 }
diff --git a/drivers/net/ethernet/intel/e1000e/lib.c b/drivers/net/ethernet=
/intel/e1000e/lib.c
index 0893ab107adf..8224a12cdad4 100644
--- a/drivers/net/ethernet/intel/e1000e/lib.c
+++ b/drivers/net/ethernet/intel/e1000e/lib.c
@@ -435,6 +435,9 @@ void e1000e_clear_hw_cntrs_base(struct e1000_hw *hw)
  *  Checks to see of the link status of the hardware has changed.  If a
  *  change in link status has been detected, then we read the PHY registers
  *  to get the current speed/duplex if link exists.
+ *
+ *  Returns a negative error code (-E1000_ERR_*) or 0 (link down) or 1 (li=
nk
+ *  up).
  **/
 s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 {
@@ -449,7 +452,7 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 	 * Change or Rx Sequence Error interrupt.
 	 */
 	if (!mac->get_link_status)
-		return 0;
+		return 1;
=20
 	/*
 	 * First we want to see if the MII Status Register reports
@@ -494,10 +497,12 @@ s32 e1000e_check_for_copper_link(struct e1000_hw *hw)
 	 * different link partner.
 	 */
 	ret_val =3D e1000e_config_fc_after_link_up(hw);
-	if (ret_val)
+	if (ret_val) {
 		e_dbg("Error configuring flow control\n");
+		return ret_val;
+	}
=20
-	return ret_val;
+	return 1;
 }
=20
 /**
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ether=
net/intel/e1000e/netdev.c
index a783530e4bcf..73cc0f6c1227 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -4222,7 +4222,7 @@ static bool e1000e_has_link(struct e1000_adapter *ada=
pter)
 	case e1000_media_type_copper:
 		if (hw->mac.get_link_status) {
 			ret_val =3D hw->mac.ops.check_for_link(hw);
-			link_active =3D !hw->mac.get_link_status;
+			link_active =3D ret_val > 0;
 		} else {
 			link_active =3D 1;
 		}
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 4915d106f94b..6394850c18c0 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -808,7 +808,7 @@ static struct phy_driver marvell_drivers[] =3D {
 		.features =3D PHY_GBIT_FEATURES,
 		.flags =3D PHY_HAS_INTERRUPT,
 		.config_init =3D &m88e1145_config_init,
-		.config_aneg =3D &marvell_config_aneg,
+		.config_aneg =3D &m88e1101_config_aneg,
 		.read_status =3D &genphy_read_status,
 		.ack_interrupt =3D &marvell_ack_interrupt,
 		.config_intr =3D &marvell_config_intr,
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 239e6e71781c..abbc4307115e 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -838,6 +838,7 @@ static int pppoe_sendmsg(struct kiocb *iocb, struct soc=
ket *sock,
 	struct pppoe_hdr *ph;
 	struct net_device *dev;
 	char *start;
+	int hlen;
=20
 	lock_sock(sk);
 	if (sock_flag(sk, SOCK_DEAD) || !(sk->sk_state & PPPOX_CONNECTED)) {
@@ -856,16 +857,16 @@ static int pppoe_sendmsg(struct kiocb *iocb, struct s=
ocket *sock,
 	if (total_len > (dev->mtu + dev->hard_header_len))
 		goto end;
=20
-
-	skb =3D sock_wmalloc(sk, total_len + dev->hard_header_len + 32,
-			   0, GFP_KERNEL);
+	hlen =3D LL_RESERVED_SPACE(dev);
+	skb =3D sock_wmalloc(sk, hlen + sizeof(*ph) + total_len +
+			   dev->needed_tailroom, 0, GFP_KERNEL);
 	if (!skb) {
 		error =3D -ENOMEM;
 		goto end;
 	}
=20
 	/* Reserve space for headers. */
-	skb_reserve(skb, dev->hard_header_len);
+	skb_reserve(skb, hlen);
 	skb_reset_network_header(skb);
=20
 	skb->dev =3D dev;
@@ -926,7 +927,7 @@ static int __pppoe_xmit(struct sock *sk, struct sk_buff=
 *skb)
 	/* Copy the data if there is no space for the header or if it's
 	 * read-only.
 	 */
-	if (skb_cow_head(skb, sizeof(*ph) + dev->hard_header_len))
+	if (skb_cow_head(skb, LL_RESERVED_SPACE(dev) + sizeof(*ph)))
 		goto abort;
=20
 	__skb_push(skb, sizeof(*ph));
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 29f121e9345b..a84c03c7b00c 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -389,7 +389,7 @@ static void __unflatten_device_tree(struct boot_param_h=
eader *blob,
 	mem =3D (unsigned long)
 		dt_alloc(size + 4, __alignof__(struct device_node));
 	if (!mem)
-		return NULL;
+		return;
=20
 	memset((void *)mem, 0, size);
=20
diff --git a/drivers/parisc/lba_pci.c b/drivers/parisc/lba_pci.c
index 3aeb3279c92a..37d8fdca5961 100644
--- a/drivers/parisc/lba_pci.c
+++ b/drivers/parisc/lba_pci.c
@@ -1603,3 +1603,36 @@ void lba_set_iregs(struct parisc_device *lba, u32 ib=
ase, u32 imask)
 	iounmap(base_addr);
 }
=20
+
+/*
+ * The design of the Diva management card in rp34x0 machines (rp3410, rp34=
40)
+ * seems rushed, so that many built-in components simply don't work.
+ * The following quirks disable the serial AUX port and the built-in ATI R=
V100
+ * Radeon 7000 graphics card which both don't have any external connectors=
 and
+ * thus are useless, and even worse, e.g. the AUX port occupies ttyS0 and =
as
+ * such makes those machines the only PARISC machines on which we can't use
+ * ttyS0 as boot console.
+ */
+static void quirk_diva_ati_card(struct pci_dev *dev)
+{
+	if (dev->subsystem_vendor !=3D PCI_VENDOR_ID_HP ||
+	    dev->subsystem_device !=3D 0x1292)
+		return;
+
+	dev_info(&dev->dev, "Hiding Diva built-in ATI card");
+	dev->device =3D 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RADEON_QY,
+	quirk_diva_ati_card);
+
+static void quirk_diva_aux_disable(struct pci_dev *dev)
+{
+	if (dev->subsystem_vendor !=3D PCI_VENDOR_ID_HP ||
+	    dev->subsystem_device !=3D 0x1291)
+		return;
+
+	dev_info(&dev->dev, "Hiding Diva built-in AUX serial device");
+	dev->device =3D 0;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_DIVA_AUX,
+	quirk_diva_aux_disable);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index fa635079f6d3..5dde000e32bf 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -872,7 +872,12 @@ static int pci_pm_thaw_noirq(struct device *dev)
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
=20
-	pci_update_current_state(pci_dev, PCI_D0);
+	/*
+	 * pci_restore_state() requires the device to be in D0 (because of MSI
+	 * restoration among other things), so force it into D0 in case the
+	 * driver's "freeze" callbacks put it into a low-power state directly.
+	 */
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
=20
 	if (drv && drv->pm && drv->pm->thaw_noirq)
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 33e0c1828660..62687fda3c40 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -121,10 +121,6 @@ static void sas_ata_task_done(struct sas_task *task)
 			if (unlikely(link->eh_info.err_mask))
 				qc->flags |=3D ATA_QCFLAG_FAILED;
 		}
-
-		dev->sata_dev.sstatus =3D resp->sstatus;
-		dev->sata_dev.serror =3D resp->serror;
-		dev->sata_dev.scontrol =3D resp->scontrol;
 	} else {
 		ac =3D sas_to_ata_err(stat);
 		if (ac) {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f6a464a80a3f..823f0e95869a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1688,11 +1688,13 @@ struct request_queue *__scsi_alloc_queue(struct Scs=
i_Host *shost,
 		q->limits.cluster =3D 0;
=20
 	/*
-	 * set a reasonable default alignment on word boundaries: the
-	 * host and device may alter it using
-	 * blk_queue_update_dma_alignment() later.
+	 * Set a reasonable default alignment:  The larger of 32-byte (dword),
+	 * which is a common minimum for HBAs, and the minimum DMA alignment,
+	 * which is set by the platform.
+	 *
+	 * Devices that require a bigger alignment can increase it later.
 	 */
-	blk_queue_dma_alignment(q, 0x03);
+	blk_queue_dma_alignment(q, max(4, dma_get_cache_alignment()) - 1);
=20
 	return q;
 }
diff --git a/drivers/staging/usbip/stub_dev.c b/drivers/staging/usbip/stub_=
dev.c
index 55c0b510889c..d98821a82612 100644
--- a/drivers/staging/usbip/stub_dev.c
+++ b/drivers/staging/usbip/stub_dev.c
@@ -186,8 +186,7 @@ static void stub_shutdown_connection(struct usbip_devic=
e *ud)
 	 * step 1?
 	 */
 	if (ud->tcp_socket) {
-		dev_dbg(&sdev->udev->dev, "shutdown tcp_socket %p\n",
-			ud->tcp_socket);
+		dev_dbg(&sdev->udev->dev, "shutdown sockfd %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
=20
diff --git a/drivers/staging/usbip/stub_main.c b/drivers/staging/usbip/stub=
_main.c
index 2446e09666b4..4d7c8a5069c7 100644
--- a/drivers/staging/usbip/stub_main.c
+++ b/drivers/staging/usbip/stub_main.c
@@ -227,11 +227,12 @@ void stub_device_cleanup_urbs(struct stub_device *sde=
v)
 	struct stub_priv *priv;
 	struct urb *urb;
=20
-	dev_dbg(&sdev->udev->dev, "free sdev %p\n", sdev);
+	dev_dbg(&sdev->udev->dev, "Stub device cleaning up urbs\n");
=20
 	while ((priv =3D stub_priv_pop(sdev))) {
 		urb =3D priv->urb;
-		dev_dbg(&sdev->udev->dev, "free urb %p\n", urb);
+		dev_dbg(&sdev->udev->dev, "free urb seqnum %lu\n",
+			priv->seqnum);
 		usb_kill_urb(urb);
=20
 		kmem_cache_free(stub_priv_cache, priv);
diff --git a/drivers/staging/usbip/stub_rx.c b/drivers/staging/usbip/stub_r=
x.c
index 22d933183cb9..67757b6df94c 100644
--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -239,9 +239,6 @@ static int stub_recv_cmd_unlink(struct stub_device *sde=
v,
 		if (priv->seqnum =3D=3D pdu->u.cmd_unlink.seqnum) {
 			int ret;
=20
-			dev_info(&priv->urb->dev->dev, "unlink urb %p\n",
-				 priv->urb);
-
 			/*
 			 * This matched urb is not completed yet (i.e., be in
 			 * flight in usb hcd hardware/driver). Now we are
@@ -280,8 +277,8 @@ static int stub_recv_cmd_unlink(struct stub_device *sde=
v,
 			ret =3D usb_unlink_urb(priv->urb);
 			if (ret !=3D -EINPROGRESS)
 				dev_err(&priv->urb->dev->dev,
-					"failed to unlink a urb %p, ret %d\n",
-					priv->urb, ret);
+					"failed to unlink a urb # %lu, ret %d\n",
+					priv->seqnum, ret);
 			return 0;
 		}
 	}
@@ -586,7 +583,7 @@ static void stub_rx_pdu(struct usbip_device *ud)
 	memset(&pdu, 0, sizeof(pdu));
=20
 	/* 1. receive a pdu header */
-	ret =3D usbip_xmit(0, ud->tcp_socket, (char *) &pdu, sizeof(pdu), 0);
+	ret =3D usbip_recv(ud->tcp_socket, &pdu, sizeof(pdu));
 	if (ret !=3D sizeof(pdu)) {
 		dev_err(dev, "recv a header, %d\n", ret);
 		usbip_event_add(ud, SDEV_EVENT_ERROR_TCP);
diff --git a/drivers/staging/usbip/stub_tx.c b/drivers/staging/usbip/stub_t=
x.c
index af6cb2ecd4b3..7f2117033328 100644
--- a/drivers/staging/usbip/stub_tx.c
+++ b/drivers/staging/usbip/stub_tx.c
@@ -201,8 +201,8 @@ static int stub_send_ret_submit(struct stub_device *sde=
v)
=20
 		/* 1. setup usbip_header */
 		setup_ret_submit_pdu(&pdu_header, urb);
-		usbip_dbg_stub_tx("setup txdata seqnum: %d urb: %p\n",
-				  pdu_header.base.seqnum, urb);
+		usbip_dbg_stub_tx("setup txdata seqnum: %d\n",
+				  pdu_header.base.seqnum);
 		/*usbip_dump_header(pdu_header);*/
 		usbip_header_correct_endian(&pdu_header, 1);
=20
diff --git a/drivers/staging/usbip/usbip_common.c b/drivers/staging/usbip/u=
sbip_common.c
index 4fbef0c28343..499f7744ac8d 100644
--- a/drivers/staging/usbip/usbip_common.c
+++ b/drivers/staging/usbip/usbip_common.c
@@ -115,7 +115,7 @@ static void usbip_dump_usb_device(struct usb_device *ud=
ev)
 		break;
 	}
=20
-	pr_debug("tt %p, ttport %d\n", udev->tt, udev->ttport);
+	pr_debug("tt hub ttport %d\n", udev->ttport);
=20
 	dev_dbg(dev, "                    ");
 	for (i =3D 0; i < 16; i++)
@@ -148,11 +148,8 @@ static void usbip_dump_usb_device(struct usb_device *u=
dev)
 	}
 	pr_debug("\n");
=20
-	dev_dbg(dev, "parent %p, bus %p\n", udev->parent, udev->bus);
-
-	dev_dbg(dev, "descriptor %p, config %p, actconfig %p, "
-		"rawdescriptors %p\n", &udev->descriptor, udev->config,
-		udev->actconfig, udev->rawdescriptors);
+	dev_dbg(dev, "parent %s, bus %s\n", dev_name(&udev->parent->dev),
+		udev->bus->bus_name);
=20
 	dev_dbg(dev, "have_langid %d, string_langid %d\n",
 		udev->have_langid, udev->string_langid);
@@ -261,9 +258,6 @@ void usbip_dump_urb(struct urb *urb)
=20
 	dev =3D &urb->dev->dev;
=20
-	dev_dbg(dev, "   urb                   :%p\n", urb);
-	dev_dbg(dev, "   dev                   :%p\n", urb->dev);
-
 	usbip_dump_usb_device(urb->dev);
=20
 	dev_dbg(dev, "   pipe                  :%08x ", urb->pipe);
@@ -272,11 +266,9 @@ void usbip_dump_urb(struct urb *urb)
=20
 	dev_dbg(dev, "   status                :%d\n", urb->status);
 	dev_dbg(dev, "   transfer_flags        :%08X\n", urb->transfer_flags);
-	dev_dbg(dev, "   transfer_buffer       :%p\n", urb->transfer_buffer);
 	dev_dbg(dev, "   transfer_buffer_length:%d\n",
 						urb->transfer_buffer_length);
 	dev_dbg(dev, "   actual_length         :%d\n", urb->actual_length);
-	dev_dbg(dev, "   setup_packet          :%p\n", urb->setup_packet);
=20
 	if (urb->setup_packet && usb_pipetype(urb->pipe) =3D=3D PIPE_CONTROL)
 		usbip_dump_usb_ctrlrequest(
@@ -286,8 +278,6 @@ void usbip_dump_urb(struct urb *urb)
 	dev_dbg(dev, "   number_of_packets     :%d\n", urb->number_of_packets);
 	dev_dbg(dev, "   interval              :%d\n", urb->interval);
 	dev_dbg(dev, "   error_count           :%d\n", urb->error_count);
-	dev_dbg(dev, "   context               :%p\n", urb->context);
-	dev_dbg(dev, "   complete              :%p\n", urb->complete);
 }
 EXPORT_SYMBOL_GPL(usbip_dump_urb);
=20
@@ -334,9 +324,8 @@ void usbip_dump_header(struct usbip_header *pdu)
 }
 EXPORT_SYMBOL_GPL(usbip_dump_header);
=20
-/* Send/receive messages over TCP/IP. I refer drivers/block/nbd.c */
-int usbip_xmit(int send, struct socket *sock, char *buf, int size,
-	       int msg_flags)
+/* Receive data over TCP/IP. */
+int usbip_recv(struct socket *sock, void *buf, int size)
 {
 	int result;
 	struct msghdr msg;
@@ -347,26 +336,10 @@ int usbip_xmit(int send, struct socket *sock, char *b=
uf, int size,
 	char *bp =3D buf;
 	int osize =3D size;
=20
-	usbip_dbg_xmit("enter\n");
-
-	if (!sock || !buf || !size) {
-		pr_err("invalid arg, sock %p buff %p size %d\n", sock, buf,
-		       size);
+	if (!sock || !buf || !size)
 		return -EINVAL;
-	}
=20
-	if (usbip_dbg_flag_xmit) {
-		if (send) {
-			if (!in_interrupt())
-				pr_debug("%-10s:", current->comm);
-			else
-				pr_debug("interrupt  :");
-
-			pr_debug("sending... , sock %p, buf %p, size %d, "
-				 "msg_flags %d\n", sock, buf, size, msg_flags);
-			usbip_dump_buffer(buf, size);
-		}
-	}
+	usbip_dbg_xmit("enter\n");
=20
 	do {
 		sock->sk->sk_allocation =3D GFP_NOIO;
@@ -377,42 +350,27 @@ int usbip_xmit(int send, struct socket *sock, char *b=
uf, int size,
 		msg.msg_control =3D NULL;
 		msg.msg_controllen =3D 0;
 		msg.msg_namelen    =3D 0;
-		msg.msg_flags      =3D msg_flags | MSG_NOSIGNAL;
-
-		if (send)
-			result =3D kernel_sendmsg(sock, &msg, &iov, 1, size);
-		else
-			result =3D kernel_recvmsg(sock, &msg, &iov, 1, size,
-						MSG_WAITALL);
+		msg.msg_flags      =3D MSG_NOSIGNAL;
=20
-		if (result <=3D 0) {
-			pr_debug("%s sock %p buf %p size %u ret %d total %d\n",
-				 send ? "send" : "receive", sock, buf, size,
-				 result, total);
+		result =3D kernel_recvmsg(sock, &msg, &iov, 1, size, MSG_WAITALL);
+		if (result <=3D 0)
 			goto err;
-		}
=20
 		size -=3D result;
 		buf +=3D result;
 		total +=3D result;
-
 	} while (size > 0);
=20
 	if (usbip_dbg_flag_xmit) {
-		if (!send) {
-			if (!in_interrupt())
-				pr_debug("%-10s:", current->comm);
-			else
-				pr_debug("interrupt  :");
-
-			pr_debug("receiving....\n");
-			usbip_dump_buffer(bp, osize);
-			pr_debug("received, osize %d ret %d size %d total %d\n",
-				 osize, result, size, total);
-		}
+		if (!in_interrupt())
+			pr_debug("%-10s:", current->comm);
+		else
+			pr_debug("interrupt  :");
=20
-		if (send)
-			pr_debug("send, total %d\n", total);
+		pr_debug("receiving....\n");
+		usbip_dump_buffer(bp, osize);
+		pr_debug("received, osize %d ret %d size %d total %d\n",
+			osize, result, size, total);
 	}
=20
 	return total;
@@ -420,7 +378,7 @@ int usbip_xmit(int send, struct socket *sock, char *buf=
, int size,
 err:
 	return result;
 }
-EXPORT_SYMBOL_GPL(usbip_xmit);
+EXPORT_SYMBOL_GPL(usbip_recv);
=20
 struct socket *sockfd_to_socket(unsigned int sockfd)
 {
@@ -712,7 +670,7 @@ int usbip_recv_iso(struct usbip_device *ud, struct urb =
*urb)
 	if (!buff)
 		return -ENOMEM;
=20
-	ret =3D usbip_xmit(0, ud->tcp_socket, buff, size, 0);
+	ret =3D usbip_recv(ud->tcp_socket, buff, size);
 	if (ret !=3D size) {
 		dev_err(&urb->dev->dev, "recv iso_frame_descriptor, %d\n",
 			ret);
@@ -831,8 +789,7 @@ int usbip_recv_xbuff(struct usbip_device *ud, struct ur=
b *urb)
 		}
 	}
=20
-	ret =3D usbip_xmit(0, ud->tcp_socket, (char *)urb->transfer_buffer,
-			 size, 0);
+	ret =3D usbip_recv(ud->tcp_socket, urb->transfer_buffer, size);
 	if (ret !=3D size) {
 		dev_err(&urb->dev->dev, "recv xbuf, %d\n", ret);
 		if (ud->side =3D=3D USBIP_STUB) {
diff --git a/drivers/staging/usbip/usbip_common.h b/drivers/staging/usbip/u=
sbip_common.h
index 1d854f87e476..1057c1d8bf25 100644
--- a/drivers/staging/usbip/usbip_common.h
+++ b/drivers/staging/usbip/usbip_common.h
@@ -306,8 +306,7 @@ void setreuse(struct socket *);
 void usbip_dump_urb(struct urb *purb);
 void usbip_dump_header(struct usbip_header *pdu);
=20
-int usbip_xmit(int send, struct socket *sock, char *buf, int size,
-	       int msg_flags);
+int usbip_recv(struct socket *sock, void *buf, int size);
 struct socket *sockfd_to_socket(unsigned int sockfd);
=20
 void usbip_pack_pdu(struct usbip_header *pdu, struct urb *urb, int cmd,
diff --git a/drivers/staging/usbip/userspace/src/utils.c b/drivers/staging/=
usbip/userspace/src/utils.c
index 2d4966e6289c..a52189fa1609 100644
--- a/drivers/staging/usbip/userspace/src/utils.c
+++ b/drivers/staging/usbip/userspace/src/utils.c
@@ -34,6 +34,7 @@ int modify_match_busid(char *busid, int add)
 	char match_busid_attr_path[SYSFS_PATH_MAX];
 	struct sysfs_attribute *match_busid_attr;
 	int rc, ret =3D 0;
+	int cmd_size;
=20
 	if (strnlen(busid, SYSFS_BUS_ID_SIZE) > SYSFS_BUS_ID_SIZE - 1) {
 		dbg("busid is too long");
@@ -58,13 +59,15 @@ int modify_match_busid(char *busid, int add)
 	}
=20
 	if (add)
-		snprintf(buff, SYSFS_BUS_ID_SIZE + 4, "add %s", busid);
+		cmd_size =3D snprintf(buff, SYSFS_BUS_ID_SIZE + 4, "add %s",
+				    busid);
 	else
-		snprintf(buff, SYSFS_BUS_ID_SIZE + 4, "del %s", busid);
+		cmd_size =3D snprintf(buff, SYSFS_BUS_ID_SIZE + 4, "del %s",
+				    busid);
=20
 	dbg("write \"%s\" to %s", buff, match_busid_attr->path);
=20
-	rc =3D sysfs_write_attribute(match_busid_attr, buff, sizeof(buff));
+	rc =3D sysfs_write_attribute(match_busid_attr, buff, cmd_size);
 	if (rc < 0) {
 		dbg("failed to write match_busid: %s", strerror(errno));
 		ret =3D -1;
diff --git a/drivers/staging/usbip/vhci_hcd.c b/drivers/staging/usbip/vhci_=
hcd.c
index 0bea1cb70307..40172b95ab8f 100644
--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -516,9 +516,6 @@ static int vhci_urb_enqueue(struct usb_hcd *hcd, struct=
 urb *urb,
 	unsigned long flags;
 	struct vhci_device *vdev;
=20
-	usbip_dbg_vhci_hc("enter, usb_hcd %p urb %p mem_flags %d\n",
-			  hcd, urb, mem_flags);
-
 	/* patch to usb_sg_init() is in 2.5.60 */
 	BUG_ON(!urb->transfer_buffer && urb->transfer_buffer_length);
=20
@@ -677,8 +674,6 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct=
 urb *urb, int status)
 	struct vhci_priv *priv;
 	struct vhci_device *vdev;
=20
-	pr_info("dequeue a urb %p\n", urb);
-
 	spin_lock_irqsave(&the_controller->lock, flags);
=20
 	priv =3D urb->hcpriv;
@@ -707,7 +702,6 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct=
 urb *urb, int status)
=20
 		spin_lock_irqsave(&vdev->priv_lock, flags2);
=20
-		pr_info("device %p seems to be disconnected\n", vdev);
 		list_del(&priv->list);
 		kfree(priv);
 		urb->hcpriv =3D NULL;
@@ -719,8 +713,6 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct=
 urb *urb, int status)
 		 * vhci_rx will receive RET_UNLINK and give back the URB.
 		 * Otherwise, we give back it here.
 		 */
-		pr_info("gives back urb %p\n", urb);
-
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
=20
 		spin_unlock_irqrestore(&the_controller->lock, flags);
@@ -751,8 +743,6 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct=
 urb *urb, int status)
=20
 		unlink->unlink_seqnum =3D priv->seqnum;
=20
-		pr_info("device %p seems to be still connected\n", vdev);
-
 		/* send cmd_unlink and try to cancel the pending URB in the
 		 * peer */
 		list_add_tail(&unlink->list, &vdev->unlink_tx);
@@ -821,7 +811,7 @@ static void vhci_shutdown_connection(struct usbip_devic=
e *ud)
=20
 	/* need this? see stub_dev.c */
 	if (ud->tcp_socket) {
-		pr_debug("shutdown tcp_socket %p\n", ud->tcp_socket);
+		pr_debug("shutdown tcp_socket %d\n", ud->sockfd);
 		kernel_sock_shutdown(ud->tcp_socket, SHUT_RDWR);
 	}
=20
diff --git a/drivers/staging/usbip/vhci_rx.c b/drivers/staging/usbip/vhci_r=
x.c
index 1a7afaabd25f..3b008e6e0475 100644
--- a/drivers/staging/usbip/vhci_rx.c
+++ b/drivers/staging/usbip/vhci_rx.c
@@ -35,21 +35,19 @@ struct urb *pickup_urb_and_free_priv(struct vhci_device=
 *vdev, __u32 seqnum)
 			urb =3D priv->urb;
 			status =3D urb->status;
=20
-			usbip_dbg_vhci_rx("find urb %p vurb %p seqnum %u\n",
-					  urb, priv, seqnum);
+			usbip_dbg_vhci_rx("find urb seqnum %u\n", seqnum);
=20
 			/* TODO: fix logic here to improve indent situtation */
 			if (status !=3D -EINPROGRESS) {
 				if (status =3D=3D -ENOENT ||
 				    status =3D=3D -ECONNRESET)
-					dev_info(&urb->dev->dev,
-						 "urb %p was unlinked "
-						 "%ssynchronuously.\n", urb,
-						 status =3D=3D -ENOENT ? "" : "a");
+					dev_dbg(&urb->dev->dev,
+						"urb seq# %u was unlinked %ssynchronuously\n",
+						seqnum, status =3D=3D -ENOENT ? "" : "a");
 				else
-					dev_info(&urb->dev->dev,
-						 "urb %p may be in a error, "
-						 "status %d\n", urb, status);
+					dev_dbg(&urb->dev->dev,
+						"urb seq# %u may be in a error, status %d\n",
+						seqnum, status);
 			}
=20
 			list_del(&priv->list);
@@ -75,8 +73,8 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 	spin_unlock(&vdev->priv_lock);
=20
 	if (!urb) {
-		pr_err("cannot find a urb of seqnum %u\n", pdu->base.seqnum);
-		pr_info("max seqnum %d\n",
+		pr_err("cannot find a urb of seqnum %u max seqnum %d\n",
+			pdu->base.seqnum,
 			atomic_read(&the_controller->seqnum));
 		usbip_event_add(ud, VDEV_EVENT_ERROR_TCP);
 		return;
@@ -99,7 +97,7 @@ static void vhci_recv_ret_submit(struct vhci_device *vdev,
 	if (usbip_dbg_flag_vhci_rx)
 		usbip_dump_urb(urb);
=20
-	usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+	usbip_dbg_vhci_rx("now giveback urb %u\n", pdu->base.seqnum);
=20
 	spin_lock_irqsave(&the_controller->lock, flags);
 	usb_hcd_unlink_urb_from_ep(vhci_to_hcd(the_controller), urb);
@@ -165,7 +163,7 @@ static void vhci_recv_ret_unlink(struct vhci_device *vd=
ev,
 		pr_info("the urb (seqnum %d) was already given backed\n",
 			pdu->base.seqnum);
 	} else {
-		usbip_dbg_vhci_rx("now giveback urb %p\n", urb);
+		usbip_dbg_vhci_rx("now giveback urb %d\n", pdu->base.seqnum);
=20
 		/* If unlink is succeed, status is -ECONNRESET */
 		urb->status =3D pdu->u.ret_unlink.status;
@@ -205,7 +203,7 @@ static void vhci_rx_pdu(struct usbip_device *ud)
 	memset(&pdu, 0, sizeof(pdu));
=20
 	/* 1. receive a pdu header */
-	ret =3D usbip_xmit(0, ud->tcp_socket, (char *) &pdu, sizeof(pdu), 0);
+	ret =3D usbip_recv(ud->tcp_socket, &pdu, sizeof(pdu));
 	if (ret < 0) {
 		if (ret =3D=3D -ECONNRESET)
 			pr_info("connection reset by peer\n");
diff --git a/drivers/staging/usbip/vhci_tx.c b/drivers/staging/usbip/vhci_t=
x.c
index 9b437e7ef1a7..d0342612f4dc 100644
--- a/drivers/staging/usbip/vhci_tx.c
+++ b/drivers/staging/usbip/vhci_tx.c
@@ -83,7 +83,8 @@ static int vhci_send_cmd_submit(struct vhci_device *vdev)
 		memset(&msg, 0, sizeof(msg));
 		memset(&iov, 0, sizeof(iov));
=20
-		usbip_dbg_vhci_tx("setup txdata urb %p\n", urb);
+		usbip_dbg_vhci_tx("setup txdata urb seqnum %lu\n",
+				  priv->seqnum);
=20
 		/* 1. setup usbip_header */
 		setup_cmd_submit_pdu(&pdu_header, urb);
diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 4671f8d671be..304f58ee440d 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1459,7 +1459,7 @@ static void n_tty_set_termios(struct tty_struct *tty,=
 struct ktermios *old)
 	BUG_ON(!tty);
=20
 	if (old)
-		canon_change =3D (old->c_lflag ^ tty->termios->c_lflag) & ICANON;
+		canon_change =3D (old->c_lflag ^ tty->termios->c_lflag) & (ICANON | EXTP=
ROC);
 	if (canon_change) {
 		memset(&tty->read_flags, 0, sizeof tty->read_flags);
 		tty->canon_head =3D tty->read_tail;
@@ -2096,7 +2096,7 @@ static int n_tty_ioctl(struct tty_struct *tty, struct=
 file *file,
 	case TIOCINQ:
 		/* FIXME: Locking */
 		retval =3D tty->read_cnt;
-		if (L_ICANON(tty))
+		if (L_ICANON(tty) && !L_EXTPROC(tty))
 			retval =3D inq_canon(tty);
 		return put_user(retval, (unsigned int __user *) arg);
 	default:
diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
index 7619e98828ab..f613bf3385c6 100644
--- a/drivers/tty/serial/8250_pci.c
+++ b/drivers/tty/serial/8250_pci.c
@@ -4175,6 +4175,9 @@ static struct pci_device_id serial_pci_tbl[] =3D {
 	{ PCI_DEVICE(0x1601, 0x0800), .driver_data =3D pbn_b0_4_1250000 },
 	{ PCI_DEVICE(0x1601, 0xa801), .driver_data =3D pbn_b0_4_1250000 },
=20
+	/* Amazon PCI serial device */
+	{ PCI_DEVICE(0x1d0f, 0x8250), .driver_data =3D pbn_b0_1_115200 },
+
 	/*
 	 * These entries match devices with class COMMUNICATION_SERIAL,
 	 * COMMUNICATION_MODEM or COMMUNICATION_MULTISERIAL
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 0a80b5991773..4c09812a0aa3 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -878,6 +878,13 @@ void usb_release_bos_descriptor(struct usb_device *dev)
 	}
 }
=20
+static const __u8 bos_desc_len[256] =3D {
+	[USB_CAP_TYPE_WIRELESS_USB] =3D USB_DT_USB_WIRELESS_CAP_SIZE,
+	[USB_CAP_TYPE_EXT]          =3D USB_DT_USB_EXT_CAP_SIZE,
+	[USB_SS_CAP_TYPE]           =3D USB_DT_USB_SS_CAP_SIZE,
+	[CONTAINER_ID_TYPE]         =3D USB_DT_USB_SS_CONTN_ID_SIZE,
+};
+
 /* Get BOS descriptor set */
 int usb_get_bos_descriptor(struct usb_device *dev)
 {
@@ -886,6 +893,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 	struct usb_dev_cap_header *cap;
 	unsigned char *buffer;
 	int length, total_len, num, i;
+	__u8 cap_type;
 	int ret;
=20
 	bos =3D kzalloc(sizeof(struct usb_bos_descriptor), GFP_KERNEL);
@@ -938,7 +946,13 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 			dev->bos->desc->bNumDeviceCaps =3D i;
 			break;
 		}
+		cap_type =3D cap->bDevCapabilityType;
 		length =3D cap->bLength;
+		if (bos_desc_len[cap_type] && length < bos_desc_len[cap_type]) {
+			dev->bos->desc->bNumDeviceCaps =3D i;
+			break;
+		}
+
 		total_len -=3D length;
=20
 		if (cap->bDescriptorType !=3D USB_DT_DEVICE_CAPABILITY) {
@@ -946,7 +960,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 			continue;
 		}
=20
-		switch (cap->bDevCapabilityType) {
+		switch (cap_type) {
 		case USB_CAP_TYPE_WIRELESS_USB:
 			/* Wireless USB cap descriptor is handled by wusb */
 			break;
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index caf710028b30..a33e3cbe67de 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1093,14 +1093,18 @@ static int proc_do_submiturb(struct dev_state *ps, =
struct usbdevfs_urb *uurb,
 	unsigned int u, totlen, isofrmlen;
 	int ret, ifnum =3D -1;
 	int is_in;
-
-	if (uurb->flags & ~(USBDEVFS_URB_ISO_ASAP |
-				USBDEVFS_URB_SHORT_NOT_OK |
+	unsigned long mask =3D	USBDEVFS_URB_SHORT_NOT_OK |
 				USBDEVFS_URB_BULK_CONTINUATION |
 				USBDEVFS_URB_NO_FSBR |
 				USBDEVFS_URB_ZERO_PACKET |
-				USBDEVFS_URB_NO_INTERRUPT))
-		return -EINVAL;
+				USBDEVFS_URB_NO_INTERRUPT;
+	/* USBDEVFS_URB_ISO_ASAP is a special case */
+	if (uurb->type =3D=3D USBDEVFS_URB_TYPE_ISO)
+		mask |=3D USBDEVFS_URB_ISO_ASAP;
+
+	if (uurb->flags & ~mask)
+			return -EINVAL;
+
 	if (uurb->buffer_length > 0 && !uurb->buffer)
 		return -EINVAL;
 	if (!(uurb->type =3D=3D USBDEVFS_URB_TYPE_CONTROL &&
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 84ee955a000d..41d75c9a4324 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -53,10 +53,11 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	/* Microsoft LifeCam-VX700 v2.0 */
 	{ USB_DEVICE(0x045e, 0x0770), .driver_info =3D USB_QUIRK_RESET_RESUME },
=20
-	/* Logitech HD Pro Webcams C920, C920-C and C930e */
+	/* Logitech HD Pro Webcams C920, C920-C, C925e and C930e */
 	{ USB_DEVICE(0x046d, 0x082d), .driver_info =3D USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0841), .driver_info =3D USB_QUIRK_DELAY_INIT },
 	{ USB_DEVICE(0x046d, 0x0843), .driver_info =3D USB_QUIRK_DELAY_INIT },
+	{ USB_DEVICE(0x046d, 0x085b), .driver_info =3D USB_QUIRK_DELAY_INIT },
=20
 	/* Logitech ConferenceCam CC3000e */
 	{ USB_DEVICE(0x046d, 0x0847), .driver_info =3D USB_QUIRK_DELAY_INIT },
@@ -128,6 +129,9 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	/* appletouch */
 	{ USB_DEVICE(0x05ac, 0x021a), .driver_info =3D USB_QUIRK_RESET_RESUME },
=20
+	/* ELSA MicroLink 56K */
+	{ USB_DEVICE(0x05cc, 0x2267), .driver_info =3D USB_QUIRK_RESET_RESUME },
+
 	/* Avision AV600U */
 	{ USB_DEVICE(0x0638, 0x0a13), .driver_info =3D
 	  USB_QUIRK_STRING_FETCH_255 },
diff --git a/drivers/usb/host/ehci-dbg.c b/drivers/usb/host/ehci-dbg.c
index d6d74d2e09f4..f0a54c59e16a 100644
--- a/drivers/usb/host/ehci-dbg.c
+++ b/drivers/usb/host/ehci-dbg.c
@@ -785,7 +785,7 @@ static ssize_t fill_registers_buffer(struct debug_buffe=
r *buf)
 			default:		/* unknown */
 				break;
 			}
-			temp =3D (cap >> 8) & 0xff;
+			offset =3D (cap >> 8) & 0xff;
 		}
 	}
 #endif
diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 841eb6878e97..187cabc14291 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -873,10 +873,9 @@ int xhci_alloc_virt_device(struct xhci_hcd *xhci, int =
slot_id,
 		return 0;
 	}
=20
-	xhci->devs[slot_id] =3D kzalloc(sizeof(*xhci->devs[slot_id]), flags);
-	if (!xhci->devs[slot_id])
+	dev =3D kzalloc(sizeof(*dev), flags);
+	if (!dev)
 		return 0;
-	dev =3D xhci->devs[slot_id];
=20
 	/* Allocate the (output) device context that will be used in the HC. */
 	dev->out_ctx =3D xhci_alloc_container_ctx(xhci, XHCI_CTX_TYPE_DEVICE, fla=
gs);
@@ -925,9 +924,19 @@ int xhci_alloc_virt_device(struct xhci_hcd *xhci, int =
slot_id,
 		 &xhci->dcbaa->dev_context_ptrs[slot_id],
 		 le64_to_cpu(xhci->dcbaa->dev_context_ptrs[slot_id]));
=20
+	xhci->devs[slot_id] =3D dev;
+
 	return 1;
 fail:
-	xhci_free_virt_device(xhci, slot_id);
+
+	if (dev->eps[0].ring)
+		xhci_ring_free(xhci, dev->eps[0].ring);
+	if (dev->in_ctx)
+		xhci_free_container_ctx(xhci, dev->in_ctx);
+	if (dev->out_ctx)
+		xhci_free_container_ctx(xhci, dev->out_ctx);
+	kfree(dev);
+
 	return 0;
 }
=20
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 74ed2108ea0f..ba0122c4be46 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2396,12 +2396,16 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		 */
 		if (list_empty(&ep_ring->td_list)) {
 			/*
-			 * A stopped endpoint may generate an extra completion
-			 * event if the device was suspended.  Don't print
-			 * warnings.
+			 * Don't print wanings if it's due to a stopped endpoint
+			 * generating an extra completion event if the device
+			 * was suspended. Or, a event for the last TRB of a
+			 * short TD we already got a short event for.
+			 * The short TD is already removed from the TD list.
 			 */
+
 			if (!(trb_comp_code =3D=3D COMP_STOP ||
-						trb_comp_code =3D=3D COMP_STOP_INVAL)) {
+			      trb_comp_code =3D=3D COMP_STOP_INVAL ||
+			      ep_ring->last_td_was_short)) {
 				xhci_warn(xhci, "WARN Event TRB for slot %d ep %d with no TDs queued?\=
n",
 						TRB_TO_SLOT_ID(le32_to_cpu(event->flags)),
 						ep_index);
diff --git a/drivers/usb/mon/mon_bin.c b/drivers/usb/mon/mon_bin.c
index 91cd85076a44..76f47f18155f 100644
--- a/drivers/usb/mon/mon_bin.c
+++ b/drivers/usb/mon/mon_bin.c
@@ -1000,7 +1000,9 @@ static long mon_bin_ioctl(struct file *file, unsigned=
 int cmd, unsigned long arg
 		break;
=20
 	case MON_IOCQ_RING_SIZE:
+		mutex_lock(&rp->fetch_lock);
 		ret =3D rp->b_size;
+		mutex_unlock(&rp->fetch_lock);
 		break;
=20
 	case MON_IOCT_RING_SIZE:
@@ -1227,12 +1229,16 @@ static int mon_bin_vma_fault(struct vm_area_struct =
*vma, struct vm_fault *vmf)
 	unsigned long offset, chunk_idx;
 	struct page *pageptr;
=20
+	mutex_lock(&rp->fetch_lock);
 	offset =3D vmf->pgoff << PAGE_SHIFT;
-	if (offset >=3D rp->b_size)
+	if (offset >=3D rp->b_size) {
+		mutex_unlock(&rp->fetch_lock);
 		return VM_FAULT_SIGBUS;
+	}
 	chunk_idx =3D offset / CHUNK_SIZE;
 	pageptr =3D rp->b_vec[chunk_idx].pg;
 	get_page(pageptr);
+	mutex_unlock(&rp->fetch_lock);
 	vmf->page =3D pageptr;
 	return 0;
 }
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 6594ddcc2281..47369652e264 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -126,6 +126,7 @@ static const struct usb_device_id id_table[] =3D {
 	{ USB_DEVICE(0x10C4, 0x8470) }, /* Juniper Networks BX Series System Cons=
ole */
 	{ USB_DEVICE(0x10C4, 0x8477) }, /* Balluff RFID */
 	{ USB_DEVICE(0x10C4, 0x84B6) }, /* Starizona Hyperion */
+	{ USB_DEVICE(0x10C4, 0x85A7) }, /* LifeScan OneTouch Verio IQ */
 	{ USB_DEVICE(0x10C4, 0x85EA) }, /* AC-Services IBUS-IF */
 	{ USB_DEVICE(0x10C4, 0x85EB) }, /* AC-Services CIS-IBUS */
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
@@ -176,6 +177,7 @@ static const struct usb_device_id id_table[] =3D {
 	{ USB_DEVICE(0x1843, 0x0200) }, /* Vaisala USB Instrument Cable */
 	{ USB_DEVICE(0x18EF, 0xE00F) }, /* ELV USB-I2C-Interface */
 	{ USB_DEVICE(0x18EF, 0xE025) }, /* ELV Marble Sound Board 1 */
+	{ USB_DEVICE(0x18EF, 0xE030) }, /* ELV ALC 8xxx Battery Charger */
 	{ USB_DEVICE(0x18EF, 0xE032) }, /* ELV TFD500 Data Logger */
 	{ USB_DEVICE(0x1901, 0x0190) }, /* GE B850 CP2105 Recorder interface */
 	{ USB_DEVICE(0x1901, 0x0193) }, /* GE B650 CP2104 PMC interface */
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index c4c4d024b701..b79aac73a149 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1037,6 +1037,7 @@ static struct usb_device_id id_table_combined [] =3D {
 		.driver_info =3D (kernel_ulong_t)&ftdi_jtag_quirk },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_BT_USB_PID) },
 	{ USB_DEVICE(CYPRESS_VID, CYPRESS_WICED_WL_USB_PID) },
+	{ USB_DEVICE(AIRBUS_DS_VID, AIRBUS_DS_P8GR) },
 	{ },					/* Optional parameter entry */
 	{ }					/* Terminating entry */
 };
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_si=
o_ids.h
index 28640a8177b2..0b3de2ce1044 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -898,6 +898,12 @@
 #define ICPDAS_I7561U_PID		0x0104
 #define ICPDAS_I7563U_PID		0x0105
=20
+/*
+ * Airbus Defence and Space
+ */
+#define AIRBUS_DS_VID			0x1e8e  /* Vendor ID */
+#define AIRBUS_DS_P8GR			0x6001  /* Tetra P8GR */
+
 /*
  * RT Systems programming cables for various ham radios
  */
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index eb9018e7e0ba..3073881c7279 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -237,11 +237,14 @@ static void option_instat_callback(struct urb *urb);
 /* These Quectel products use Qualcomm's vendor ID */
 #define QUECTEL_PRODUCT_UC20			0x9003
 #define QUECTEL_PRODUCT_UC15			0x9090
+/* These Yuga products use Qualcomm's vendor ID */
+#define YUGA_PRODUCT_CLM920_NC5			0x9625
=20
 #define QUECTEL_VENDOR_ID			0x2c7c
 /* These Quectel products use Quectel's vendor ID */
 #define QUECTEL_PRODUCT_EC21			0x0121
 #define QUECTEL_PRODUCT_EC25			0x0125
+#define QUECTEL_PRODUCT_BG96			0x0296
=20
 #define CMOTECH_VENDOR_ID			0x16d8
 #define CMOTECH_PRODUCT_6001			0x6001
@@ -656,6 +659,10 @@ static const struct option_blacklist_info telit_le922_=
blacklist_usbcfg3 =3D {
 	.reserved =3D BIT(1) | BIT(2) | BIT(3),
 };
=20
+static const struct option_blacklist_info yuga_clm920_nc5_blacklist =3D {
+	.reserved =3D BIT(1) | BIT(4),
+};
+
 static const struct usb_device_id option_ids[] =3D {
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_COLT) },
 	{ USB_DEVICE(OPTION_VENDOR_ID, OPTION_PRODUCT_RICOLA) },
@@ -1160,11 +1167,16 @@ static const struct usb_device_id option_ids[] =3D {
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC15)},
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC20),
 	  .driver_info =3D (kernel_ulong_t)&net_intf4_blacklist },
+	/* Yuga products use Qualcomm vendor ID */
+	{ USB_DEVICE(QUALCOMM_VENDOR_ID, YUGA_PRODUCT_CLM920_NC5),
+	  .driver_info =3D (kernel_ulong_t)&yuga_clm920_nc5_blacklist },
 	/* Quectel products using Quectel vendor ID */
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC21),
 	  .driver_info =3D (kernel_ulong_t)&net_intf4_blacklist },
 	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC25),
 	  .driver_info =3D (kernel_ulong_t)&net_intf4_blacklist },
+	{ USB_DEVICE(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_BG96),
+	  .driver_info =3D (kernel_ulong_t)&net_intf4_blacklist },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6003),
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusu=
al_devs.h
index 93e49bd7c16f..5f08ce6f535c 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -1961,6 +1961,13 @@ UNUSUAL_DEV(  0x152d, 0x0567, 0x0114, 0x0114,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BROKEN_FUA ),
=20
+/* Reported by David Kozub <zub@linux.fjfi.cvut.cz> */
+UNUSUAL_DEV(0x152d, 0x0578, 0x0000, 0x9999,
+		"JMicron",
+		"JMS567",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_BROKEN_FUA),
+
 /* Reported by Alexandre Oliva <oliva@lsd.ic.unicamp.br>
  * JMicron responds to USN and several other SCSI ioctls with a
  * residue that causes subsequent I/O requests to fail.  */
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index da528f830cdd..57c4ad3bc1a0 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2759,13 +2759,6 @@ static int cache_save_setup(struct btrfs_block_group=
_cache *block_group,
 		goto again;
 	}
=20
-	/* We've already setup this transaction, go ahead and exit */
-	if (block_group->cache_generation =3D=3D trans->transid &&
-	    i_size_read(inode)) {
-		dcs =3D BTRFS_DC_SETUP;
-		goto out_put;
-	}
-
 	/*
 	 * We want to set the generation to 0, that way if anything goes wrong
 	 * from here on out we know not to trust this cache when we load up next
@@ -2775,6 +2768,13 @@ static int cache_save_setup(struct btrfs_block_group=
_cache *block_group,
 	ret =3D btrfs_update_inode(trans, root, inode);
 	WARN_ON(ret);
=20
+	/* We've already setup this transaction, go ahead and exit */
+	if (block_group->cache_generation =3D=3D trans->transid &&
+	    i_size_read(inode)) {
+		dcs =3D BTRFS_DC_SETUP;
+		goto out_put;
+	}
+
 	if (i_size_read(inode) > 0) {
 		ret =3D btrfs_truncate_free_space_cache(root, trans, path,
 						      inode);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 231fbe1db357..205d588e2ef0 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1751,7 +1751,7 @@ static noinline int btrfs_search_path_in_tree(struct =
btrfs_fs_info *info,
 	if (!path)
 		return -ENOMEM;
=20
-	ptr =3D &name[BTRFS_INO_LOOKUP_PATH_MAX];
+	ptr =3D &name[BTRFS_INO_LOOKUP_PATH_MAX - 1];
=20
 	key.objectid =3D tree_id;
 	key.type =3D BTRFS_ROOT_ITEM_KEY;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index ede3a33a2f1a..6047b7fb9739 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -892,6 +892,10 @@ static struct buffer_head * ext4_find_entry (struct in=
ode *dir,
 			       "falling back\n"));
 	}
 	nblocks =3D dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
+	if (!nblocks) {
+		ret =3D NULL;
+		goto cleanup_and_exit;
+	}
 	start =3D EXT4_I(dir)->i_dir_start_lookup;
 	if (start >=3D nblocks)
 		start =3D 0;
diff --git a/fs/nfsd/auth.c b/fs/nfsd/auth.c
index 79717a40daba..3d3f14c11d57 100644
--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -61,6 +61,9 @@ int nfsd_setuser(struct svc_rqst *rqstp, struct svc_expor=
t *exp)
 			else
 				GROUP_AT(gi, i) =3D GROUP_AT(rqgi, i);
 		}
+
+		/* Each thread allocates its own gi, no race */
+		groups_sort(gi);
 	} else {
 		gi =3D get_group_info(rqgi);
 	}
diff --git a/include/asm-generic/dma-mapping-broken.h b/include/asm-generic=
/dma-mapping-broken.h
index ccf7b4f34a3c..12ec4b1b2760 100644
--- a/include/asm-generic/dma-mapping-broken.h
+++ b/include/asm-generic/dma-mapping-broken.h
@@ -69,9 +69,6 @@ dma_supported(struct device *dev, u64 mask);
 extern int
 dma_set_mask(struct device *dev, u64 mask);
=20
-extern int
-dma_get_cache_alignment(void);
-
 extern void
 dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
diff --git a/include/linux/cred.h b/include/linux/cred.h
index 40308969ed00..c9900b31da18 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -67,6 +67,7 @@ extern void groups_free(struct group_info *);
 extern int set_current_groups(struct group_info *);
 extern int set_groups(struct cred *, struct group_info *);
 extern int groups_search(const struct group_info *, gid_t);
+extern void groups_sort(struct group_info *);
=20
 /* access the groups "array" with this macro */
 #define GROUP_AT(gi, i) \
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e13117cbd2f7..4b46319ec497 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -130,7 +130,6 @@ static inline void *dma_zalloc_coherent(struct device *=
dev, size_t size,
 	return ret;
 }
=20
-#ifdef CONFIG_HAS_DMA
 static inline int dma_get_cache_alignment(void)
 {
 #ifdef ARCH_DMA_MINALIGN
@@ -138,7 +137,6 @@ static inline int dma_get_cache_alignment(void)
 #endif
 	return 1;
 }
-#endif
=20
 /* flags for the coherent memory api */
 #define	DMA_MEMORY_MAP			0x01
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 9ec20dec3353..851a91037ba3 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -642,7 +642,7 @@ bool fscache_maybe_release_page(struct fscache_cookie *=
cookie,
 {
 	if (fscache_cookie_valid(cookie) && PageFsCache(page))
 		return __fscache_maybe_release_page(cookie, page, gfp);
-	return false;
+	return true;
 }
=20
 /**
diff --git a/include/linux/stddef.h b/include/linux/stddef.h
index 6a40c76bdcf1..ff9bbb6732cb 100644
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -23,6 +23,16 @@ enum {
 #else
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 #endif
+
+/**
+ * offsetofend(TYPE, MEMBER)
+ *
+ * @TYPE: The type of the structure
+ * @MEMBER: The member within the structure to get the end offset of
+ */
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof(((TYPE *)0)->MEMBER))
+
 #endif /* __KERNEL__ */
=20
 #endif
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 68a3b10d8e0b..e89e286fae97 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -800,6 +800,8 @@ struct usb_wireless_cap_descriptor {	/* Ultra Wide Band=
 */
 	__u8  bReserved;
 } __attribute__((packed));
=20
+#define USB_DT_USB_WIRELESS_CAP_SIZE	11
+
 /* USB 2.0 Extension descriptor */
 #define	USB_CAP_TYPE_EXT		2
=20
diff --git a/include/net/red.h b/include/net/red.h
index b72a3b833936..d2eb24d72e63 100644
--- a/include/net/red.h
+++ b/include/net/red.h
@@ -124,6 +124,17 @@ static inline u32 red_rmask(u8 Plog)
 	return Plog < 32 ? ((1 << Plog) - 1) : ~0UL;
 }
=20
+static inline bool red_check_params(u32 qth_min, u32 qth_max, u8 Wlog)
+{
+	if (fls(qth_min) + Wlog > 32)
+		return false;
+	if (fls(qth_max) + Wlog > 32)
+		return false;
+	if (qth_max < qth_min)
+		return false;
+	return true;
+}
+
 static inline void red_set_parms(struct red_parms *p,
 				 u32 qth_min, u32 qth_max, u8 Wlog, u8 Plog,
 				 u8 Scell_log, u8 *stab)
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 9e5f33784ea1..19386d1a6fb6 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1439,6 +1439,7 @@ extern int xfrm_prepare_input(struct xfrm_state *x, s=
truct sk_buff *skb);
 extern int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi,
 		      int encap_type);
 extern int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
+int xfrm_trans_queue(struct sk_buff *skb, int (*finish)(struct sk_buff *));
 extern int xfrm_output_resume(struct sk_buff *skb, int err);
 extern int xfrm_output(struct sk_buff *skb);
 extern int xfrm_inner_extract_output(struct xfrm_state *x, struct sk_buff =
*skb);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 9cc517ad4159..40e5fb93d6d8 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -163,7 +163,6 @@ enum ata_command_set {
=20
 struct sata_device {
         enum   ata_command_set command_set;
-        struct smp_resp        rps_resp; /* report_phy_sata_resp */
         __le16 *identify_device;
         __le16 *identify_packet_device;
=20
@@ -172,10 +171,8 @@ struct sata_device {
=20
 	struct ata_port *ap;
 	struct ata_host ata_host;
+	struct smp_resp rps_resp ____cacheline_aligned; /* report_phy_sata_resp */
 	u8     fis[ATA_RESP_FIS_SIZE];
-	u32 sstatus;
-	u32 serror;
-	u32 scontrol;
 };
=20
 /* ---------- Domain device ---------- */
@@ -492,10 +489,6 @@ enum exec_status {
 struct ata_task_resp {
 	u16  frame_len;
 	u8   ending_fis[ATA_RESP_FIS_SIZE];	  /* dev to host or data-in */
-	u32  sstatus;
-	u32  serror;
-	u32  scontrol;
-	u32  sactive;
 };
=20
 #define SAS_STATUS_BUF_SIZE 96
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 4802eb5840e1..c3c5b705c80c 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -349,7 +349,7 @@ static char *kdb_read(char *buffer, size_t bufsize)
 			}
 			kdb_printf("\n");
 			for (i =3D 0; i < count; i++) {
-				if (kallsyms_symbol_next(p_tmp, i) < 0)
+				if (WARN_ON(!kallsyms_symbol_next(p_tmp, i)))
 					break;
 				kdb_printf("%s ", p_tmp);
 				*(p_tmp + len) =3D '\0';
diff --git a/kernel/futex.c b/kernel/futex.c
index 3854e754f641..5e483785d43f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1376,6 +1376,9 @@ static int futex_requeue(u32 __user *uaddr1, unsigned=
 int flags,
 	struct plist_head *head1;
 	struct futex_q *this, *next;
=20
+	if (nr_wake < 0 || nr_requeue < 0)
+		return -EINVAL;
+
 	if (requeue_pi) {
 		/*
 		 * Requeue PI only works on two distinct uaddrs. This
diff --git a/kernel/groups.c b/kernel/groups.c
index 99b53d1eb7ea..b65d45c9dfb2 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -103,7 +103,7 @@ static int groups_from_user(struct group_info *group_in=
fo,
 }
=20
 /* a simple Shell sort */
-static void groups_sort(struct group_info *group_info)
+void groups_sort(struct group_info *group_info)
 {
 	int base, max, stride;
 	int gidsetsize =3D group_info->ngroups;
@@ -130,6 +130,7 @@ static void groups_sort(struct group_info *group_info)
 		stride /=3D 3;
 	}
 }
+EXPORT_SYMBOL(groups_sort);
=20
 /* a simple bsearch */
 int groups_search(const struct group_info *group_info, gid_t grp)
@@ -164,7 +165,6 @@ int groups_search(const struct group_info *group_info, =
gid_t grp)
 int set_groups(struct cred *new, struct group_info *group_info)
 {
 	put_group_info(new->group_info);
-	groups_sort(group_info);
 	get_group_info(group_info);
 	new->group_info =3D group_info;
 	return 0;
@@ -247,6 +247,7 @@ SYSCALL_DEFINE2(setgroups, int, gidsetsize, gid_t __use=
r *, grouplist)
 		return retval;
 	}
=20
+	groups_sort(group_info);
 	retval =3D set_current_groups(group_info);
 	put_group_info(group_info);
=20
diff --git a/kernel/hrtimer.c b/kernel/hrtimer.c
index 6918c031363e..f3fdd40d670a 100644
--- a/kernel/hrtimer.c
+++ b/kernel/hrtimer.c
@@ -657,6 +657,7 @@ static int hrtimer_reprogram(struct hrtimer *timer,
 static inline void hrtimer_init_hres(struct hrtimer_cpu_base *base)
 {
 	base->expires_next.tv64 =3D KTIME_MAX;
+	base->hang_detected =3D 0;
 	base->hres_active =3D 0;
 }
=20
@@ -1702,6 +1703,7 @@ static void __cpuinit init_hrtimers_cpu(int cpu)
 		timerqueue_init_head(&cpu_base->clock_base[i].active);
 	}
=20
+	cpu_base->active_bases =3D 0;
 	hrtimer_init_hres(cpu_base);
 }
=20
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 67661832ac2b..4a32f9cd96dc 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -440,17 +440,22 @@ static struct pid *good_sigevent(sigevent_t * event)
 {
 	struct task_struct *rtn =3D current->group_leader;
=20
-	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
-		(!(rtn =3D find_task_by_vpid(event->sigev_notify_thread_id)) ||
-		 !same_thread_group(rtn, current) ||
-		 (event->sigev_notify & ~SIGEV_THREAD_ID) !=3D SIGEV_SIGNAL))
+	switch (event->sigev_notify) {
+	case SIGEV_SIGNAL | SIGEV_THREAD_ID:
+		rtn =3D find_task_by_vpid(event->sigev_notify_thread_id);
+		if (!rtn || !same_thread_group(rtn, current))
+			return NULL;
+		/* FALLTHRU */
+	case SIGEV_SIGNAL:
+	case SIGEV_THREAD:
+		if (event->sigev_signo <=3D 0 || event->sigev_signo > SIGRTMAX)
+			return NULL;
+		/* FALLTHRU */
+	case SIGEV_NONE:
+		return task_pid(rtn);
+	default:
 		return NULL;
-
-	if (((event->sigev_notify & ~SIGEV_THREAD_ID) !=3D SIGEV_NONE) &&
-	    ((event->sigev_signo <=3D 0) || (event->sigev_signo > SIGRTMAX)))
-		return NULL;
-
-	return task_pid(rtn);
+	}
 }
=20
 void posix_timers_register_clock(const clockid_t clock_id,
@@ -683,16 +688,17 @@ common_timer_get(struct k_itimer *timr, struct itimer=
spec *cur_setting)
 {
 	ktime_t now, remaining, iv;
 	struct hrtimer *timer =3D &timr->it.real.timer;
+	bool sig_none;
=20
 	memset(cur_setting, 0, sizeof(struct itimerspec));
=20
+	sig_none =3D timr->it_sigev_notify =3D=3D SIGEV_NONE;
 	iv =3D timr->it.real.interval;
=20
 	/* interval timer ? */
 	if (iv.tv64)
 		cur_setting->it_interval =3D ktime_to_timespec(iv);
-	else if (!hrtimer_active(timer) &&
-		 (timr->it_sigev_notify & ~SIGEV_THREAD_ID) !=3D SIGEV_NONE)
+	else if (!hrtimer_active(timer) && !sig_none)
 		return;
=20
 	now =3D timer->base->get_time();
@@ -702,8 +708,7 @@ common_timer_get(struct k_itimer *timr, struct itimersp=
ec *cur_setting)
 	 * timer move the expiry time forward by intervals, so
 	 * expiry is > now.
 	 */
-	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING ||
-	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) =3D=3D SIGEV_NONE))
+	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
 		timr->it_overrun +=3D (unsigned int) hrtimer_forward(timer, now, iv);
=20
 	remaining =3D __hrtimer_expires_remaining_adjusted(timer, now);
@@ -713,7 +718,7 @@ common_timer_get(struct k_itimer *timr, struct itimersp=
ec *cur_setting)
 		 * A single shot SIGEV_NONE timer must return 0, when
 		 * it is expired !
 		 */
-		if ((timr->it_sigev_notify & ~SIGEV_THREAD_ID) !=3D SIGEV_NONE)
+		if (!sig_none)
 			cur_setting->it_value.tv_nsec =3D 1;
 	} else
 		cur_setting->it_value =3D ktime_to_timespec(remaining);
@@ -811,7 +816,7 @@ common_timer_set(struct k_itimer *timr, int flags,
 	timr->it.real.interval =3D timespec_to_ktime(new_setting->it_interval);
=20
 	/* SIGEV_NONE timers are not queued ! See common_timer_get */
-	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) =3D=3D SIGEV_NONE)) {
+	if (timr->it_sigev_notify =3D=3D SIGEV_NONE) {
 		/* Setup correct expiry time for relative timers */
 		if (mode =3D=3D HRTIMER_MODE_REL) {
 			hrtimer_add_expires(timer, timer->base->get_time());
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d6899c42d491..c9954f33446a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -360,6 +360,8 @@ EXPORT_SYMBOL_GPL(ring_buffer_event_data);
 /* Missed count stored at end */
 #define RB_MISSED_STORED	(1 << 30)
=20
+#define RB_MISSED_FLAGS		(RB_MISSED_EVENTS|RB_MISSED_STORED)
+
 struct buffer_data_page {
 	u64		 time_stamp;	/* page time stamp */
 	local_t		 commit;	/* write committed index */
@@ -411,7 +413,9 @@ static void rb_init_page(struct buffer_data_page *bpage)
  */
 size_t ring_buffer_page_len(void *page)
 {
-	return local_read(&((struct buffer_data_page *)page)->commit)
+	struct buffer_data_page *bpage =3D page;
+
+	return (local_read(&bpage->commit) & ~RB_MISSED_FLAGS)
 		+ BUF_PAGE_HDR_SIZE;
 }
=20
diff --git a/kernel/uid16.c b/kernel/uid16.c
index 51c6e89e8619..204340b135d2 100644
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -203,6 +203,7 @@ SYSCALL_DEFINE2(setgroups16, int, gidsetsize, old_gid_t=
 __user *, grouplist)
 		return retval;
 	}
=20
+	groups_sort(group_info);
 	retval =3D set_current_groups(group_info);
 	put_group_info(group_info);
=20
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 5a688a2756be..ac64860a60a4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -92,13 +92,15 @@ static inline void change_pmd_range(struct vm_area_stru=
ct *vma, pud_t *pud,
 			if (next - addr !=3D HPAGE_PMD_SIZE)
 				split_huge_page_pmd(vma->vm_mm, pmd);
 			else if (change_huge_pmd(vma, pmd, addr, newprot))
-				continue;
+				goto next;
 			/* fall through */
 		}
 		if (pmd_none_or_clear_bad(pmd))
-			continue;
+			goto next;
 		change_pte_range(vma->vm_mm, pmd, addr, next, newprot,
 				 dirty_accountable);
+next:
+		cond_resched();
 	} while (pmd++, addr =3D next, addr !=3D end);
 }
=20
diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 963f285e69ca..ff240391b484 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -132,11 +132,7 @@ void unregister_vlan_dev(struct net_device *dev, struc=
t list_head *head)
 		call_rcu(&grp->rcu, vlan_rcu_free);
 	}
=20
-	/* Take it out of our own structures, but be sure to interlock with
-	 * HW accelerating devices or SW vlan input packet processing if
-	 * VLAN is not 0 (leave it there for 802.1p).
-	 */
-	if (vlan_id && (real_dev->features & NETIF_F_HW_VLAN_FILTER))
+	if (real_dev->features & NETIF_F_HW_VLAN_FILTER)
 		ops->ndo_vlan_rx_kill_vid(real_dev, vlan_id);
=20
 	/* Get rid of the vlan's reference to real_dev */
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 3512e251545b..b74e6730ba3b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -760,10 +760,10 @@ static int bat_ogm_calc_tq(struct orig_node *orig_nod=
e,
 	orig_node->last_valid =3D jiffies;
=20
 	/* find packet count of corresponding one hop neighbor */
-	spin_lock_bh(&orig_node->ogm_cnt_lock);
+	spin_lock_bh(&orig_neigh_node->ogm_cnt_lock);
 	orig_eq_count =3D orig_neigh_node->bcast_own_sum[if_incoming->if_num];
 	neigh_rq_count =3D neigh_node->real_packet_count;
-	spin_unlock_bh(&orig_node->ogm_cnt_lock);
+	spin_unlock_bh(&orig_neigh_node->ogm_cnt_lock);
=20
 	/* pay attention to not get a value bigger than 100 % */
 	total_count =3D (orig_eq_count > neigh_rq_count ?
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 99a48a39c009..8b2960836a4c 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -215,6 +215,11 @@ static int br_dev_newlink(struct net *src_net, struct =
net_device *dev,
 			  struct nlattr *tb[], struct nlattr *data[])
 {
 	struct net_bridge *br =3D netdev_priv(dev);
+	int err;
+
+	err =3D register_netdevice(dev);
+	if (err)
+		return err;
=20
 	if (tb[IFLA_ADDRESS]) {
 		spin_lock_bh(&br->lock);
@@ -222,7 +227,7 @@ static int br_dev_newlink(struct net *src_net, struct n=
et_device *dev,
 		spin_unlock_bh(&br->lock);
 	}
=20
-	return register_netdevice(dev);
+	return 0;
 }
=20
 struct rtnl_link_ops br_link_ops __read_mostly =3D {
diff --git a/net/can/af_can.c b/net/can/af_can.c
index 3ddc74960959..57c43649a715 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -653,13 +653,13 @@ static int can_rcv(struct sk_buff *skb, struct net_de=
vice *dev,
 	if (!net_eq(dev_net(dev), &init_net))
 		goto drop;
=20
-	if (WARN_ONCE(dev->type !=3D ARPHRD_CAN ||
-		      skb->len !=3D sizeof(struct can_frame) ||
-		      cf->can_dlc > 8,
-		      "PF_CAN: dropped non conform skbuf: "
-		      "dev type %d, len %d, can_dlc %d\n",
-		      dev->type, skb->len, cf->can_dlc))
+	if (unlikely(dev->type !=3D ARPHRD_CAN ||
+		     skb->len !=3D sizeof(struct can_frame) ||
+		     cf->can_dlc > 8)) {
+		pr_warn_once("PF_CAN: dropped non conform CAN skbuf: dev type %d, len %d=
, can_dlc %d\n",
+			     dev->type, skb->len, cf->can_dlc);
 		goto drop;
+	}
=20
 	/* update statistics */
 	can_stats.rx_frames++;
diff --git a/net/dccp/ccids/ccid2.c b/net/dccp/ccids/ccid2.c
index 67164bb6ae4d..eaa9d3e9452c 100644
--- a/net/dccp/ccids/ccid2.c
+++ b/net/dccp/ccids/ccid2.c
@@ -140,6 +140,9 @@ static void ccid2_hc_tx_rto_expire(unsigned long data)
=20
 	ccid2_pr_debug("RTO_EXPIRE\n");
=20
+	if (sk->sk_state =3D=3D DCCP_CLOSED)
+		goto out;
+
 	/* back-off timer */
 	hc->tx_rto <<=3D 1;
 	if (hc->tx_rto > DCCP_RTO_MAX)
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 238fc3b055eb..20a140cc1226 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -658,6 +658,7 @@ static int esp_init_state(struct xfrm_state *x)
=20
 		switch (encap->encap_type) {
 		default:
+			err =3D -EINVAL;
 			goto error;
 		case UDP_ENCAP_ESPINUDP:
 			x->props.header_len +=3D sizeof(struct udphdr);
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 0a35f0846142..96ad44a69899 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -89,6 +89,7 @@
 #include <linux/if_arp.h>
 #include <linux/rtnetlink.h>
 #include <linux/times.h>
+#include <linux/byteorder/generic.h>
=20
 #include <net/net_namespace.h>
 #include <net/arp.h>
@@ -299,6 +300,23 @@ igmp_scount(struct ip_mc_list *pmc, int type, int gdel=
eted, int sdeleted)
 	return scount;
 }
=20
+/* source address selection per RFC 3376 section 4.2.13 */
+static __be32 igmpv3_get_srcaddr(struct net_device *dev,
+				 const struct flowi4 *fl4)
+{
+	struct in_device *in_dev =3D __in_dev_get_rcu(dev);
+
+	if (!in_dev)
+		return htonl(INADDR_ANY);
+
+	for_ifa(in_dev) {
+		if (fl4->saddr =3D=3D ifa->ifa_local)
+			return fl4->saddr;
+	} endfor_ifa(in_dev);
+
+	return htonl(INADDR_ANY);
+}
+
 static struct sk_buff *igmpv3_newpack(struct net_device *dev, unsigned int=
 mtu)
 {
 	struct sk_buff *skb;
@@ -345,7 +363,7 @@ static struct sk_buff *igmpv3_newpack(struct net_device=
 *dev, unsigned int mtu)
 	pip->frag_off =3D htons(IP_DF);
 	pip->ttl      =3D 1;
 	pip->daddr    =3D fl4.daddr;
-	pip->saddr    =3D fl4.saddr;
+	pip->saddr    =3D igmpv3_get_srcaddr(dev, &fl4);
 	pip->protocol =3D IPPROTO_IGMP;
 	pip->tot_len  =3D 0;	/* filled in later */
 	ip_select_ident(skb, NULL);
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index e6430963e994..8a9233ed322b 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -78,6 +78,16 @@
 #include <linux/netfilter.h>
 #include <linux/netfilter_ipv4.h>
 #include <linux/compat.h>
+#include <linux/uio.h>
+
+struct raw_frag_vec {
+	struct iovec *iov;
+	union {
+		struct icmphdr icmph;
+		char c[1];
+	} hdr;
+	int hlen;
+};
=20
 static struct raw_hashinfo raw_v4_hashinfo =3D {
 	.lock =3D __RW_LOCK_UNLOCKED(raw_v4_hashinfo.lock),
@@ -409,53 +419,57 @@ static int raw_send_hdrinc(struct sock *sk, struct fl=
owi4 *fl4,
 	return err;
 }
=20
-static int raw_probe_proto_opt(struct flowi4 *fl4, struct msghdr *msg)
+static int raw_probe_proto_opt(struct raw_frag_vec *rfv, struct flowi4 *fl=
4)
 {
-	struct iovec *iov;
-	u8 __user *type =3D NULL;
-	u8 __user *code =3D NULL;
-	int probed =3D 0;
-	unsigned int i;
+	int err;
=20
-	if (!msg->msg_iov)
+	if (fl4->flowi4_proto !=3D IPPROTO_ICMP)
 		return 0;
=20
-	for (i =3D 0; i < msg->msg_iovlen; i++) {
-		iov =3D &msg->msg_iov[i];
-		if (!iov)
-			continue;
-
-		switch (fl4->flowi4_proto) {
-		case IPPROTO_ICMP:
-			/* check if one-byte field is readable or not. */
-			if (iov->iov_base && iov->iov_len < 1)
-				break;
-
-			if (!type) {
-				type =3D iov->iov_base;
-				/* check if code field is readable or not. */
-				if (iov->iov_len > 1)
-					code =3D type + 1;
-			} else if (!code)
-				code =3D iov->iov_base;
-
-			if (type && code) {
-				if (get_user(fl4->fl4_icmp_type, type) ||
-				    get_user(fl4->fl4_icmp_code, code))
-					return -EFAULT;
-				probed =3D 1;
-			}
-			break;
-		default:
-			probed =3D 1;
-			break;
-		}
-		if (probed)
-			break;
-	}
+	/* We only need the first two bytes. */
+	rfv->hlen =3D 2;
+
+	err =3D memcpy_fromiovec(rfv->hdr.c, rfv->iov, rfv->hlen);
+	if (err)
+		return err;
+
+	fl4->fl4_icmp_type =3D rfv->hdr.icmph.type;
+	fl4->fl4_icmp_code =3D rfv->hdr.icmph.code;
+
 	return 0;
 }
=20
+static int raw_getfrag(void *from, char *to, int offset, int len, int odd,
+		       struct sk_buff *skb)
+{
+	struct raw_frag_vec *rfv =3D from;
+
+	if (offset < rfv->hlen) {
+		int copy =3D min(rfv->hlen - offset, len);
+
+		if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL)
+			memcpy(to, rfv->hdr.c + offset, copy);
+		else
+			skb->csum =3D csum_block_add(
+				skb->csum,
+				csum_partial_copy_nocheck(rfv->hdr.c + offset,
+							  to, copy, 0),
+				odd);
+
+		odd =3D 0;
+		offset +=3D copy;
+		to +=3D copy;
+		len -=3D copy;
+
+		if (!len)
+			return 0;
+	}
+
+	offset -=3D rfv->hlen;
+
+	return ip_generic_getfrag(rfv->iov, to, offset, len, odd, skb);
+}
+
 static int raw_sendmsg(struct kiocb *iocb, struct sock *sk, struct msghdr =
*msg,
 		       size_t len)
 {
@@ -469,11 +483,19 @@ static int raw_sendmsg(struct kiocb *iocb, struct soc=
k *sk, struct msghdr *msg,
 	u8  tos;
 	int err;
 	struct ip_options_data opt_copy;
+	struct raw_frag_vec rfv;
+	int hdrincl;
=20
 	err =3D -EMSGSIZE;
 	if (len > 0xFFFF)
 		goto out;
=20
+	/* hdrincl should be READ_ONCE(inet->hdrincl)
+	 * but READ_ONCE() doesn't work with bit fields.
+	 * Doing this indirectly yields the same result.
+	 */
+	hdrincl =3D inet->hdrincl;
+	hdrincl =3D ACCESS_ONCE(hdrincl);
 	/*
 	 *	Check the flags.
 	 */
@@ -549,7 +571,7 @@ static int raw_sendmsg(struct kiocb *iocb, struct sock =
*sk, struct msghdr *msg,
 		/* Linux does not mangle headers on raw sockets,
 		 * so that IP options + IP_HDRINCL is non-sense.
 		 */
-		if (inet->hdrincl)
+		if (hdrincl)
 			goto done;
 		if (ipc.opt->opt.srr) {
 			if (!daddr)
@@ -570,12 +592,15 @@ static int raw_sendmsg(struct kiocb *iocb, struct soc=
k *sk, struct msghdr *msg,
=20
 	flowi4_init_output(&fl4, ipc.oif, sk->sk_mark, tos,
 			   RT_SCOPE_UNIVERSE,
-			   inet->hdrincl ? IPPROTO_RAW : sk->sk_protocol,
+			   hdrincl ? IPPROTO_RAW : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) | FLOWI_FLAG_CAN_SLEEP,
 			   daddr, saddr, 0, 0);
=20
-	if (!inet->hdrincl) {
-		err =3D raw_probe_proto_opt(&fl4, msg);
+	if (!hdrincl) {
+		rfv.iov =3D msg->msg_iov;
+		rfv.hlen =3D 0;
+
+		err =3D raw_probe_proto_opt(&rfv, &fl4);
 		if (err)
 			goto done;
 	}
@@ -596,7 +621,7 @@ static int raw_sendmsg(struct kiocb *iocb, struct sock =
*sk, struct msghdr *msg,
 		goto do_confirm;
 back_from_confirm:
=20
-	if (inet->hdrincl)
+	if (hdrincl)
 		err =3D raw_send_hdrinc(sk, &fl4, msg->msg_iov, len,
 				      &rt, msg->msg_flags);
=20
@@ -604,8 +629,8 @@ static int raw_sendmsg(struct kiocb *iocb, struct sock =
*sk, struct msghdr *msg,
 		if (!ipc.addr)
 			ipc.addr =3D fl4.daddr;
 		lock_sock(sk);
-		err =3D ip_append_data(sk, &fl4, ip_generic_getfrag,
-				     msg->msg_iov, len, 0,
+		err =3D ip_append_data(sk, &fl4, raw_getfrag,
+				     &rfv, len, 0,
 				     &ipc, &rt, msg->msg_flags);
 		if (err)
 			ip_flush_pending_frames(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4ba77eea6b85..52646b107976 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -764,7 +764,7 @@ static void tcp_v4_reqsk_send_ack(struct sock *sk, stru=
ct sk_buff *skb,
 			tcp_rsk(req)->rcv_isn + 1, req->rcv_wnd,
 			req->ts_recent,
 			0,
-			tcp_v4_md5_do_lookup(sk, ip_hdr(skb)->daddr),
+			tcp_v4_md5_do_lookup(sk, ip_hdr(skb)->saddr),
 			inet_rsk(req)->no_srccheck ? IP_REPLY_ARG_NOSRCCHECK : 0,
 			ip_hdr(skb)->tos);
 }
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index 06814b6216dc..1620fa2f7453 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -22,6 +22,11 @@ int xfrm4_extract_input(struct xfrm_state *x, struct sk_=
buff *skb)
 	return xfrm4_extract_header(skb);
 }
=20
+static int xfrm4_rcv_encap_finish2(struct sk_buff *skb)
+{
+	return dst_input(skb);
+}
+
 static inline int xfrm4_rcv_encap_finish(struct sk_buff *skb)
 {
 	if (skb_dst(skb) =3D=3D NULL) {
@@ -31,7 +36,11 @@ static inline int xfrm4_rcv_encap_finish(struct sk_buff =
*skb)
 					 iph->tos, skb->dev))
 			goto drop;
 	}
-	return dst_input(skb);
+
+	if (xfrm_trans_queue(skb, xfrm4_rcv_encap_finish2))
+		goto drop;
+
+	return 0;
 drop:
 	kfree_skb(skb);
 	return NET_RX_DROP;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 65dd5433f08b..b154ae4c3949 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -606,13 +606,12 @@ static int esp6_init_state(struct xfrm_state *x)
 			x->props.header_len +=3D IPV4_BEET_PHMAXLEN +
 				               (sizeof(struct ipv6hdr) - sizeof(struct iphdr));
 		break;
+	default:
 	case XFRM_MODE_TRANSPORT:
 		break;
 	case XFRM_MODE_TUNNEL:
 		x->props.header_len +=3D sizeof(struct ipv6hdr);
 		break;
-	default:
-		goto error;
 	}
=20
 	align =3D ALIGN(crypto_aead_blocksize(aead), 4);
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f0a1b0b247a6..abc2cd52da65 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1116,7 +1116,7 @@ static void tcp_v6_reqsk_send_ack(struct sock *sk, st=
ruct sk_buff *skb,
 				  struct request_sock *req)
 {
 	tcp_v6_send_ack(skb, tcp_rsk(req)->snt_isn + 1, tcp_rsk(req)->rcv_isn + 1=
, req->rcv_wnd, req->ts_recent,
-			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->daddr), 0);
+			tcp_v6_md5_do_lookup(sk, &ipv6_hdr(skb)->saddr), 0);
 }
=20
=20
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index f8c3cf842f53..11b6df976571 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -29,6 +29,13 @@ int xfrm6_rcv_spi(struct sk_buff *skb, int nexthdr, __be=
32 spi)
 }
 EXPORT_SYMBOL(xfrm6_rcv_spi);
=20
+static int xfrm6_transport_finish2(struct sk_buff *skb)
+{
+	if (xfrm_trans_queue(skb, ip6_rcv_finish))
+		__kfree_skb(skb);
+	return -1;
+}
+
 int xfrm6_transport_finish(struct sk_buff *skb, int async)
 {
 	skb_network_header(skb)[IP6CB(skb)->nhoff] =3D
@@ -43,7 +50,7 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 	__skb_push(skb, skb->data - skb_network_header(skb));
=20
 	NF_HOOK(NFPROTO_IPV6, NF_INET_PRE_ROUTING, skb, skb->dev, NULL,
-		ip6_rcv_finish);
+		xfrm6_transport_finish2);
 	return -1;
 }
=20
diff --git a/net/key/af_key.c b/net/key/af_key.c
index c839f2d99efd..e588b1711905 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -398,6 +398,11 @@ static int verify_address_len(const void *p)
 #endif
 	int len;
=20
+	if (sp->sadb_address_len <
+	    DIV_ROUND_UP(sizeof(*sp) + offsetofend(typeof(*addr), sa_family),
+			 sizeof(uint64_t)))
+		return -EINVAL;
+
 	switch (addr->sa_family) {
 	case AF_INET:
 		len =3D DIV_ROUND_UP(sizeof(*sp) + sizeof(*sin), sizeof(uint64_t));
@@ -508,6 +513,9 @@ static int parse_exthdrs(struct sk_buff *skb, const str=
uct sadb_msg *hdr, void *
 		uint16_t ext_type;
 		int ext_len;
=20
+		if (len < sizeof(*ehdr))
+			return -EINVAL;
+
 		ext_len  =3D ehdr->sadb_ext_len;
 		ext_len *=3D sizeof(uint64_t);
 		ext_type =3D ehdr->sadb_ext_type;
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 4f6392d71ea2..34cc788ad5b8 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2516,6 +2516,10 @@ static int packet_do_bind(struct sock *sk, const cha=
r *name, int ifindex,
=20
 	if (po->running) {
 		rcu_read_unlock();
+		/* prevents packet_notifier() from calling
+		 * register_prot_hook()
+		 */
+		po->num =3D 0;
 		__unregister_prot_hook(sk, true);
 		rcu_read_lock();
 		dev_curr =3D po->prot_hook.dev;
@@ -2523,6 +2527,7 @@ static int packet_do_bind(struct sock *sk, const char=
 *name, int ifindex,
 			unlisted =3D !dev_get_by_index_rcu(sock_net(sk),
 							 dev->ifindex);
 	}
+	BUG_ON(po->running);
 	po->num =3D protocol;
 	po->prot_hook.type =3D protocol;
=20
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index 6fcd65a923ea..11335aa5d665 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -184,7 +184,7 @@ static int __rds_rdma_map(struct rds_sock *rs, struct r=
ds_get_mr_args *args,
 	long i;
 	int ret;
=20
-	if (rs->rs_bound_addr =3D=3D 0) {
+	if (rs->rs_bound_addr =3D=3D 0 || !rs->rs_transport) {
 		ret =3D -ENOTCONN; /* XXX not a great errno */
 		goto out;
 	}
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 081ffb9188d5..f3b1ed07ef64 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -479,6 +479,9 @@ static int choke_change(struct Qdisc *sch, struct nlatt=
r *opt)
=20
 	ctl =3D nla_data(tb[TCA_CHOKE_PARMS]);
=20
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (ctl->limit > CHOKE_MAX_QUEUE)
 		return -EINVAL;
=20
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index e1afe0c205fa..c65c8315e889 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -384,6 +384,9 @@ static inline int gred_change_vq(struct Qdisc *sch, int=
 dp,
 	struct gred_sched *table =3D qdisc_priv(sch);
 	struct gred_sched_data *q;
=20
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
+
 	if (table->tab[dp] =3D=3D NULL) {
 		table->tab[dp] =3D kzalloc(sizeof(*q), GFP_ATOMIC);
 		if (table->tab[dp] =3D=3D NULL)
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index d617161f8dd3..bbf2dfdab831 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -189,6 +189,8 @@ static int red_change(struct Qdisc *sch, struct nlattr =
*opt)
 		return -EINVAL;
=20
 	ctl =3D nla_data(tb[TCA_RED_PARMS]);
+	if (!red_check_params(ctl->qth_min, ctl->qth_max, ctl->Wlog))
+		return -EINVAL;
=20
 	if (ctl->limit > 0) {
 		child =3D fifo_create_dflt(sch, &bfifo_qdisc_ops, ctl->limit);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c285bed60ff6..a572b4389a4f 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -93,7 +93,7 @@
 /* Forward declarations for internal helper functions. */
 static int sctp_writeable(struct sock *sk);
 static void sctp_wfree(struct sk_buff *skb);
-static int sctp_wait_for_sndbuf(struct sctp_association *, long *timeo_p,
+static int sctp_wait_for_sndbuf(struct sctp_association *asoc, long *timeo=
_p,
 				size_t msg_len);
 static int sctp_wait_for_packet(struct sock * sk, int *err, long *timeo_p);
 static int sctp_wait_for_connect(struct sctp_association *, long *timeo_p);
@@ -314,16 +314,14 @@ static struct sctp_af *sctp_sockaddr_af(struct sctp_s=
ock *opt,
 	if (len < sizeof (struct sockaddr))
 		return NULL;
=20
+	if (!opt->pf->af_supported(addr->sa.sa_family, opt))
+		return NULL;
+
 	/* V4 mapped address are really of AF_INET family */
 	if (addr->sa.sa_family =3D=3D AF_INET6 &&
-	    ipv6_addr_v4mapped(&addr->v6.sin6_addr)) {
-		if (!opt->pf->af_supported(AF_INET, opt))
-			return NULL;
-	} else {
-		/* Does this PF support this AF? */
-		if (!opt->pf->af_supported(addr->sa.sa_family, opt))
-			return NULL;
-	}
+	    ipv6_addr_v4mapped(&addr->v6.sin6_addr) &&
+	    !opt->pf->af_supported(AF_INET, opt))
+		return NULL;
=20
 	/* If we get this far, af is valid. */
 	af =3D sctp_get_af_specific(addr->sa.sa_family);
@@ -1911,6 +1909,7 @@ SCTP_STATIC int sctp_sendmsg(struct kiocb *iocb, stru=
ct sock *sk,
=20
 	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	if (!sctp_wspace(asoc)) {
+		/* sk can be changed by peel off when waiting for buf. */
 		err =3D sctp_wait_for_sndbuf(asoc, &timeo, msg_len);
 		if (err)
 			goto out_free;
@@ -4247,12 +4246,6 @@ SCTP_STATIC int sctp_do_peeloff(struct sctp_associat=
ion *asoc,
 	if (!net_eq(current->nsproxy->net_ns, sock_net(sk)))
 		return -EINVAL;
=20
-	/* If there is a thread waiting on more sndbuf space for
-	 * sending on this asoc, it cannot be peeled.
-	 */
-	if (waitqueue_active(&asoc->wait))
-		return -EBUSY;
-
 	/* An association cannot be branched off from an already peeled-off
 	 * socket, nor is this supported for tcp style sockets.
 	 */
@@ -6473,9 +6466,9 @@ static int sctp_wait_for_sndbuf(struct sctp_associati=
on *asoc, long *timeo_p,
 				size_t msg_len)
 {
 	struct sock *sk =3D asoc->base.sk;
-	int err =3D 0;
 	long current_timeo =3D *timeo_p;
 	DEFINE_WAIT(wait);
+	int err =3D 0;
=20
 	SCTP_DEBUG_PRINTK("wait_for_sndbuf: asoc=3D%p, timeo=3D%ld, msg_len=3D%zu=
\n",
 			  asoc, (long)(*timeo_p), msg_len);
@@ -6503,6 +6496,8 @@ static int sctp_wait_for_sndbuf(struct sctp_associati=
on *asoc, long *timeo_p,
 		sctp_release_sock(sk);
 		current_timeo =3D schedule_timeout(current_timeo);
 		sctp_lock_sock(sk);
+		if (sk !=3D asoc->base.sk)
+			goto do_error;
=20
 		*timeo_p =3D current_timeo;
 	}
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcaut=
h_gss.c
index f7a9906c474b..f5c6068668f6 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -477,6 +477,7 @@ static int rsc_parse(struct cache_detail *cd,
 				goto out;
 			GROUP_AT(rsci.cred.cr_group_info, i) =3D gid;
 		}
+		groups_sort(rsci.cred.cr_group_info);
=20
 		/* mech name */
 		len =3D qword_get(&mesg, buf, mlen);
diff --git a/net/sunrpc/svcauth_unix.c b/net/sunrpc/svcauth_unix.c
index ce136323da8b..26d5f0d062bb 100644
--- a/net/sunrpc/svcauth_unix.c
+++ b/net/sunrpc/svcauth_unix.c
@@ -539,6 +539,7 @@ static int unix_gid_parse(struct cache_detail *cd,
 		GROUP_AT(ug.gi, i) =3D gid;
 	}
=20
+	groups_sort(ug.gi);
 	ugp =3D unix_gid_lookup(uid);
 	if (ugp) {
 		struct cache_head *ch;
@@ -806,6 +807,7 @@ svcauth_unix_accept(struct svc_rqst *rqstp, __be32 *aut=
hp)
 		return SVC_CLOSE;
 	for (i =3D 0; i < slen; i++)
 		GROUP_AT(cred->cr_group_info, i) =3D svc_getnl(argv);
+	groups_sort(cred->cr_group_info);
 	if (svc_getu32(argv) !=3D htonl(RPC_AUTH_NULL) || svc_getu32(argv) !=3D 0=
) {
 		*authp =3D rpc_autherr_badverf;
 		return SVC_DENIED;
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4043f71792cd..57fd882dc6f4 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -329,6 +329,7 @@ struct wiphy *wiphy_new(const struct cfg80211_ops *ops,=
 int sizeof_priv)
=20
 	struct cfg80211_registered_device *rdev;
 	int alloc_size;
+	int rv;
=20
 	WARN_ON(ops->add_key && (!ops->del_key || !ops->set_default_key));
 	WARN_ON(ops->auth && (!ops->assoc || !ops->deauth || !ops->disassoc));
@@ -362,7 +363,11 @@ struct wiphy *wiphy_new(const struct cfg80211_ops *ops=
, int sizeof_priv)
 	mutex_unlock(&cfg80211_mutex);
=20
 	/* give it a proper name */
-	dev_set_name(&rdev->wiphy.dev, PHY_NAME "%d", rdev->wiphy_idx);
+	rv =3D dev_set_name(&rdev->wiphy.dev, PHY_NAME "%d", rdev->wiphy_idx);
+	if (rv < 0) {
+		kfree(rdev);
+		return NULL;
+	}
=20
 	mutex_init(&rdev->mtx);
 	mutex_init(&rdev->devlist_mtx);
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 6897436b1d3f..de366fb2ed3a 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -1265,8 +1265,7 @@ static int cfg80211_wext_giwrate(struct net_device *d=
ev,
 {
 	struct wireless_dev *wdev =3D dev->ieee80211_ptr;
 	struct cfg80211_registered_device *rdev =3D wiphy_to_dev(wdev->wiphy);
-	/* we are under RTNL - globally locked - so can use a static struct */
-	static struct station_info sinfo;
+	struct station_info sinfo =3D {};
 	u8 addr[ETH_ALEN];
 	int err;
=20
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 2529dab5af47..363e3c718694 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -7,15 +7,31 @@
  *
  */
=20
+#include <linux/bottom_half.h>
+#include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
+#include <linux/percpu.h>
 #include <net/dst.h>
 #include <net/ip.h>
 #include <net/xfrm.h>
=20
+struct xfrm_trans_tasklet {
+	struct tasklet_struct tasklet;
+	struct sk_buff_head queue;
+};
+
+struct xfrm_trans_cb {
+	int (*finish)(struct sk_buff *skb);
+};
+
+#define XFRM_TRANS_SKB_CB(__skb) ((struct xfrm_trans_cb *)&((__skb)->cb[0]=
))
+
 static struct kmem_cache *secpath_cachep __read_mostly;
=20
+static DEFINE_PER_CPU(struct xfrm_trans_tasklet, xfrm_trans_tasklet);
+
 void __secpath_destroy(struct sec_path *sp)
 {
 	int i;
@@ -285,10 +301,50 @@ int xfrm_input_resume(struct sk_buff *skb, int nexthd=
r)
 }
 EXPORT_SYMBOL(xfrm_input_resume);
=20
+static void xfrm_trans_reinject(unsigned long data)
+{
+	struct xfrm_trans_tasklet *trans =3D (void *)data;
+	struct sk_buff_head queue;
+	struct sk_buff *skb;
+
+	__skb_queue_head_init(&queue);
+	skb_queue_splice_init(&trans->queue, &queue);
+
+	while ((skb =3D __skb_dequeue(&queue)))
+		XFRM_TRANS_SKB_CB(skb)->finish(skb);
+}
+
+int xfrm_trans_queue(struct sk_buff *skb, int (*finish)(struct sk_buff *))
+{
+	struct xfrm_trans_tasklet *trans;
+
+	trans =3D this_cpu_ptr(&xfrm_trans_tasklet);
+
+	if (skb_queue_len(&trans->queue) >=3D netdev_max_backlog)
+		return -ENOBUFS;
+
+	XFRM_TRANS_SKB_CB(skb)->finish =3D finish;
+	__skb_queue_tail(&trans->queue, skb);
+	tasklet_schedule(&trans->tasklet);
+	return 0;
+}
+EXPORT_SYMBOL(xfrm_trans_queue);
+
 void __init xfrm_input_init(void)
 {
+	int i;
+
 	secpath_cachep =3D kmem_cache_create("secpath_cache",
 					   sizeof(struct sec_path),
 					   0, SLAB_HWCACHE_ALIGN|SLAB_PANIC,
 					   NULL);
+
+	for_each_possible_cpu(i) {
+		struct xfrm_trans_tasklet *trans;
+
+		trans =3D &per_cpu(xfrm_trans_tasklet, i);
+		__skb_queue_head_init(&trans->queue);
+		tasklet_init(&trans->tasklet, xfrm_trans_reinject,
+			     (unsigned long)trans);
+	}
 }
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index fa49a27226f0..15ae27863d02 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -465,7 +465,6 @@ static int snd_pcm_hw_param_near(struct snd_pcm_substre=
am *pcm,
 		v =3D snd_pcm_hw_param_last(pcm, params, var, dir);
 	else
 		v =3D snd_pcm_hw_param_first(pcm, params, var, dir);
-	snd_BUG_ON(v < 0);
 	return v;
 }
=20
@@ -1376,8 +1375,11 @@ static ssize_t snd_pcm_oss_write1(struct snd_pcm_sub=
stream *substream, const cha
=20
 	if ((tmp =3D snd_pcm_oss_make_ready(substream)) < 0)
 		return tmp;
-	mutex_lock(&runtime->oss.params_lock);
 	while (bytes > 0) {
+		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
+			tmp =3D -ERESTARTSYS;
+			break;
+		}
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			tmp =3D bytes;
 			if (tmp + runtime->oss.buffer_used > runtime->oss.period_bytes)
@@ -1421,14 +1423,18 @@ static ssize_t snd_pcm_oss_write1(struct snd_pcm_su=
bstream *substream, const cha
 			xfer +=3D tmp;
 			if ((substream->f_flags & O_NONBLOCK) !=3D 0 &&
 			    tmp !=3D runtime->oss.period_bytes)
-				break;
+				tmp =3D -EAGAIN;
 		}
-	}
-	mutex_unlock(&runtime->oss.params_lock);
-	return xfer;
-
  err:
-	mutex_unlock(&runtime->oss.params_lock);
+		mutex_unlock(&runtime->oss.params_lock);
+		if (tmp < 0)
+			break;
+		if (signal_pending(current)) {
+			tmp =3D -ERESTARTSYS;
+			break;
+		}
+		tmp =3D 0;
+	}
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
=20
@@ -1476,8 +1482,11 @@ static ssize_t snd_pcm_oss_read1(struct snd_pcm_subs=
tream *substream, char __use
=20
 	if ((tmp =3D snd_pcm_oss_make_ready(substream)) < 0)
 		return tmp;
-	mutex_lock(&runtime->oss.params_lock);
 	while (bytes > 0) {
+		if (mutex_lock_interruptible(&runtime->oss.params_lock)) {
+			tmp =3D -ERESTARTSYS;
+			break;
+		}
 		if (bytes < runtime->oss.period_bytes || runtime->oss.buffer_used > 0) {
 			if (runtime->oss.buffer_used =3D=3D 0) {
 				tmp =3D snd_pcm_oss_read2(substream, runtime->oss.buffer, runtime->oss=
=2Eperiod_bytes, 1);
@@ -1508,12 +1517,16 @@ static ssize_t snd_pcm_oss_read1(struct snd_pcm_sub=
stream *substream, char __use
 			bytes -=3D tmp;
 			xfer +=3D tmp;
 		}
-	}
-	mutex_unlock(&runtime->oss.params_lock);
-	return xfer;
-
  err:
-	mutex_unlock(&runtime->oss.params_lock);
+		mutex_unlock(&runtime->oss.params_lock);
+		if (tmp < 0)
+			break;
+		if (signal_pending(current)) {
+			tmp =3D -ERESTARTSYS;
+			break;
+		}
+		tmp =3D 0;
+	}
 	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 }
=20
diff --git a/sound/core/oss/pcm_plugin.c b/sound/core/oss/pcm_plugin.c
index 71cc3ddf5c15..c6cecf7cb3fa 100644
--- a/sound/core/oss/pcm_plugin.c
+++ b/sound/core/oss/pcm_plugin.c
@@ -589,18 +589,26 @@ snd_pcm_sframes_t snd_pcm_plug_write_transfer(struct =
snd_pcm_substream *plug, st
 	snd_pcm_sframes_t frames =3D size;
=20
 	plugin =3D snd_pcm_plug_first(plug);
-	while (plugin && frames > 0) {
+	while (plugin) {
+		if (frames <=3D 0)
+			return frames;
 		if ((next =3D plugin->next) !=3D NULL) {
 			snd_pcm_sframes_t frames1 =3D frames;
-			if (plugin->dst_frames)
+			if (plugin->dst_frames) {
 				frames1 =3D plugin->dst_frames(plugin, frames);
+				if (frames1 <=3D 0)
+					return frames1;
+			}
 			if ((err =3D next->client_channels(next, frames1, &dst_channels)) < 0) {
 				return err;
 			}
 			if (err !=3D frames1) {
 				frames =3D err;
-				if (plugin->src_frames)
+				if (plugin->src_frames) {
 					frames =3D plugin->src_frames(plugin, frames1);
+					if (frames <=3D 0)
+						return frames;
+				}
 			}
 		} else
 			dst_channels =3D NULL;
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 13eaeb353d28..00905d128b94 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -145,7 +145,9 @@ static int snd_pcm_control_ioctl(struct snd_card *card,
 				err =3D -ENXIO;
 				goto _error;
 			}
+			mutex_lock(&pcm->open_mutex);
 			err =3D snd_pcm_info_user(substream, info);
+			mutex_unlock(&pcm->open_mutex);
 		_error:
 			mutex_unlock(&register_mutex);
 			return err;
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index b36544a62b40..44e180a1aa2a 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -590,7 +590,6 @@ static inline unsigned int muldiv32(unsigned int a, uns=
igned int b,
 {
 	u_int64_t n =3D (u_int64_t) a * b;
 	if (c =3D=3D 0) {
-		snd_BUG_ON(!n);
 		*r =3D 0;
 		return UINT_MAX;
 	}
@@ -1546,7 +1545,7 @@ int snd_pcm_hw_param_first(struct snd_pcm_substream *=
pcm,
 		return changed;
 	if (params->rmask) {
 		int err =3D snd_pcm_hw_refine(pcm, params);
-		if (snd_BUG_ON(err < 0))
+		if (err < 0)
 			return err;
 	}
 	return snd_pcm_hw_param_value(params, var, dir);
@@ -1592,7 +1591,7 @@ int snd_pcm_hw_param_last(struct snd_pcm_substream *p=
cm,
 		return changed;
 	if (params->rmask) {
 		int err =3D snd_pcm_hw_refine(pcm, params);
-		if (snd_BUG_ON(err < 0))
+		if (err < 0)
 			return err;
 	}
 	return snd_pcm_hw_param_value(params, var, dir);
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index 25f636536ec9..74a7fab960e7 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -575,15 +575,14 @@ static int snd_rawmidi_info_user(struct snd_rawmidi_s=
ubstream *substream,
 	return 0;
 }
=20
-int snd_rawmidi_info_select(struct snd_card *card, struct snd_rawmidi_info=
 *info)
+static int __snd_rawmidi_info_select(struct snd_card *card,
+				     struct snd_rawmidi_info *info)
 {
 	struct snd_rawmidi *rmidi;
 	struct snd_rawmidi_str *pstr;
 	struct snd_rawmidi_substream *substream;
=20
-	mutex_lock(&register_mutex);
 	rmidi =3D snd_rawmidi_search(card, info->device);
-	mutex_unlock(&register_mutex);
 	if (!rmidi)
 		return -ENXIO;
 	if (info->stream < 0 || info->stream > 1)
@@ -600,6 +599,16 @@ int snd_rawmidi_info_select(struct snd_card *card, str=
uct snd_rawmidi_info *info
 	return -ENXIO;
 }
=20
+int snd_rawmidi_info_select(struct snd_card *card, struct snd_rawmidi_info=
 *info)
+{
+	int ret;
+
+	mutex_lock(&register_mutex);
+	ret =3D __snd_rawmidi_info_select(card, info);
+	mutex_unlock(&register_mutex);
+	return ret;
+}
+
 static int snd_rawmidi_info_select_user(struct snd_card *card,
 					struct snd_rawmidi_info __user *_info)
 {
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index dd9da625b44e..f71c7d0b89cb 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2189,7 +2189,6 @@ static int snd_seq_do_ioctl(struct snd_seq_client *cl=
ient, unsigned int cmd,
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
-	int ret;
=20
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2203,12 +2202,8 @@ static int snd_seq_do_ioctl(struct snd_seq_client *c=
lient, unsigned int cmd,
 	if (! arg)
 		return -EFAULT;
 	for (p =3D ioctl_tables; p->cmd; p++) {
-		if (p->cmd =3D=3D cmd) {
-			mutex_lock(&client->ioctl_mutex);
-			ret =3D p->func(client, arg);
-			mutex_unlock(&client->ioctl_mutex);
-			return ret;
-		}
+		if (p->cmd =3D=3D cmd)
+			return p->func(client, arg);
 	}
 	snd_printd("seq unknown ioctl() 0x%x (type=3D'%c', number=3D0x%02x)\n",
 		   cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
@@ -2219,11 +2214,15 @@ static int snd_seq_do_ioctl(struct snd_seq_client *=
client, unsigned int cmd,
 static long snd_seq_ioctl(struct file *file, unsigned int cmd, unsigned lo=
ng arg)
 {
 	struct snd_seq_client *client =3D file->private_data;
+	long ret;
=20
 	if (snd_BUG_ON(!client))
 		return -ENXIO;
 	=09
-	return snd_seq_do_ioctl(client, cmd, (void __user *) arg);
+	mutex_lock(&client->ioctl_mutex);
+	ret =3D snd_seq_do_ioctl(client, cmd, (void __user *) arg);
+	mutex_unlock(&client->ioctl_mutex);
+	return ret;
 }
=20
 #ifdef CONFIG_COMPAT
diff --git a/sound/core/seq/seq_timer.c b/sound/core/seq/seq_timer.c
index 6ec30a98a92a..755cf45d5b74 100644
--- a/sound/core/seq/seq_timer.c
+++ b/sound/core/seq/seq_timer.c
@@ -357,7 +357,7 @@ static int initialize_timer(struct snd_seq_timer *tmr)
 	unsigned long freq;
=20
 	t =3D tmr->timeri->timer;
-	if (snd_BUG_ON(!t))
+	if (!t)
 		return -EINVAL;
=20
 	freq =3D tmr->preferred_resolution;
diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 42b876d28e56..70012368df87 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -39,6 +39,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/info.h>
 #include <sound/initval.h>
=20
@@ -307,19 +308,6 @@ static int loopback_trigger(struct snd_pcm_substream *=
substream, int cmd)
 	return 0;
 }
=20
-static void params_change_substream(struct loopback_pcm *dpcm,
-				    struct snd_pcm_runtime *runtime)
-{
-	struct snd_pcm_runtime *dst_runtime;
-
-	if (dpcm =3D=3D NULL || dpcm->substream =3D=3D NULL)
-		return;
-	dst_runtime =3D dpcm->substream->runtime;
-	if (dst_runtime =3D=3D NULL)
-		return;
-	dst_runtime->hw =3D dpcm->cable->hw;
-}
-
 static void params_change(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
@@ -331,10 +319,6 @@ static void params_change(struct snd_pcm_substream *su=
bstream)
 	cable->hw.rate_max =3D runtime->rate;
 	cable->hw.channels_min =3D runtime->channels;
 	cable->hw.channels_max =3D runtime->channels;
-	params_change_substream(cable->streams[SNDRV_PCM_STREAM_PLAYBACK],
-				runtime);
-	params_change_substream(cable->streams[SNDRV_PCM_STREAM_CAPTURE],
-				runtime);
 }
=20
 static int loopback_prepare(struct snd_pcm_substream *substream)
@@ -610,26 +594,29 @@ static unsigned int get_cable_index(struct snd_pcm_su=
bstream *substream)
 static int rule_format(struct snd_pcm_hw_params *params,
 		       struct snd_pcm_hw_rule *rule)
 {
+	struct loopback_pcm *dpcm =3D rule->private;
+	struct loopback_cable *cable =3D dpcm->cable;
+	struct snd_mask m;
=20
-	struct snd_pcm_hardware *hw =3D rule->private;
-	struct snd_mask *maskp =3D hw_param_mask(params, rule->var);
-
-	maskp->bits[0] &=3D (u_int32_t)hw->formats;
-	maskp->bits[1] &=3D (u_int32_t)(hw->formats >> 32);
-	memset(maskp->bits + 2, 0, (SNDRV_MASK_MAX-64) / 8); /* clear rest */
-	if (! maskp->bits[0] && ! maskp->bits[1])
-		return -EINVAL;
-	return 0;
+	snd_mask_none(&m);
+	mutex_lock(&dpcm->loopback->cable_lock);
+	m.bits[0] =3D (u_int32_t)cable->hw.formats;
+	m.bits[1] =3D (u_int32_t)(cable->hw.formats >> 32);
+	mutex_unlock(&dpcm->loopback->cable_lock);
+	return snd_mask_refine(hw_param_mask(params, rule->var), &m);
 }
=20
 static int rule_rate(struct snd_pcm_hw_params *params,
 		     struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hardware *hw =3D rule->private;
+	struct loopback_pcm *dpcm =3D rule->private;
+	struct loopback_cable *cable =3D dpcm->cable;
 	struct snd_interval t;
=20
-        t.min =3D hw->rate_min;
-        t.max =3D hw->rate_max;
+	mutex_lock(&dpcm->loopback->cable_lock);
+	t.min =3D cable->hw.rate_min;
+	t.max =3D cable->hw.rate_max;
+	mutex_unlock(&dpcm->loopback->cable_lock);
         t.openmin =3D t.openmax =3D 0;
         t.integer =3D 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
@@ -638,22 +625,44 @@ static int rule_rate(struct snd_pcm_hw_params *params,
 static int rule_channels(struct snd_pcm_hw_params *params,
 			 struct snd_pcm_hw_rule *rule)
 {
-	struct snd_pcm_hardware *hw =3D rule->private;
+	struct loopback_pcm *dpcm =3D rule->private;
+	struct loopback_cable *cable =3D dpcm->cable;
 	struct snd_interval t;
=20
-        t.min =3D hw->channels_min;
-        t.max =3D hw->channels_max;
+	mutex_lock(&dpcm->loopback->cable_lock);
+	t.min =3D cable->hw.channels_min;
+	t.max =3D cable->hw.channels_max;
+	mutex_unlock(&dpcm->loopback->cable_lock);
         t.openmin =3D t.openmax =3D 0;
         t.integer =3D 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
 }
=20
+static void free_cable(struct snd_pcm_substream *substream)
+{
+	struct loopback *loopback =3D substream->private_data;
+	int dev =3D get_cable_index(substream);
+	struct loopback_cable *cable;
+
+	cable =3D loopback->cables[substream->number][dev];
+	if (!cable)
+		return;
+	if (cable->streams[!substream->stream]) {
+		/* other stream is still alive */
+		cable->streams[substream->stream] =3D NULL;
+	} else {
+		/* free the cable */
+		loopback->cables[substream->number][dev] =3D NULL;
+		kfree(cable);
+	}
+}
+
 static int loopback_open(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime =3D substream->runtime;
 	struct loopback *loopback =3D substream->private_data;
 	struct loopback_pcm *dpcm;
-	struct loopback_cable *cable;
+	struct loopback_cable *cable =3D NULL;
 	int err =3D 0;
 	int dev =3D get_cable_index(substream);
=20
@@ -673,7 +682,6 @@ static int loopback_open(struct snd_pcm_substream *subs=
tream)
 	if (!cable) {
 		cable =3D kzalloc(sizeof(*cable), GFP_KERNEL);
 		if (!cable) {
-			kfree(dpcm);
 			err =3D -ENOMEM;
 			goto unlock;
 		}
@@ -691,19 +699,19 @@ static int loopback_open(struct snd_pcm_substream *su=
bstream)
 	/* are cached -> they do not reflect the actual state */
 	err =3D snd_pcm_hw_rule_add(runtime, 0,
 				  SNDRV_PCM_HW_PARAM_FORMAT,
-				  rule_format, &runtime->hw,
+				  rule_format, dpcm,
 				  SNDRV_PCM_HW_PARAM_FORMAT, -1);
 	if (err < 0)
 		goto unlock;
 	err =3D snd_pcm_hw_rule_add(runtime, 0,
 				  SNDRV_PCM_HW_PARAM_RATE,
-				  rule_rate, &runtime->hw,
+				  rule_rate, dpcm,
 				  SNDRV_PCM_HW_PARAM_RATE, -1);
 	if (err < 0)
 		goto unlock;
 	err =3D snd_pcm_hw_rule_add(runtime, 0,
 				  SNDRV_PCM_HW_PARAM_CHANNELS,
-				  rule_channels, &runtime->hw,
+				  rule_channels, dpcm,
 				  SNDRV_PCM_HW_PARAM_CHANNELS, -1);
 	if (err < 0)
 		goto unlock;
@@ -715,6 +723,10 @@ static int loopback_open(struct snd_pcm_substream *sub=
stream)
 	else
 		runtime->hw =3D cable->hw;
  unlock:
+	if (err < 0) {
+		free_cable(substream);
+		kfree(dpcm);
+	}
 	mutex_unlock(&loopback->cable_lock);
 	return err;
 }
@@ -723,20 +735,10 @@ static int loopback_close(struct snd_pcm_substream *s=
ubstream)
 {
 	struct loopback *loopback =3D substream->private_data;
 	struct loopback_pcm *dpcm =3D substream->runtime->private_data;
-	struct loopback_cable *cable;
-	int dev =3D get_cable_index(substream);
=20
 	loopback_timer_stop(dpcm);
 	mutex_lock(&loopback->cable_lock);
-	cable =3D loopback->cables[substream->number][dev];
-	if (cable->streams[!substream->stream]) {
-		/* other stream is still alive */
-		cable->streams[substream->stream] =3D NULL;
-	} else {
-		/* free the cable */
-		loopback->cables[substream->number][dev] =3D NULL;
-		kfree(cable);
-	}
+	free_cable(substream);
 	mutex_unlock(&loopback->cable_lock);
 	return 0;
 }
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index a96184ad1479..0ba78dc2df4e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -197,6 +197,10 @@ static void *find_audio_control_unit(struct mixer_buil=
d *state, unsigned char un
 static int snd_usb_copy_string_desc(struct mixer_build *state, int index, =
char *buf, int maxlen)
 {
 	int len =3D usb_string(state->chip->dev, index, buf, maxlen - 1);
+
+	if (len < 0)
+		return 0;
+
 	buf[len] =3D 0;
 	return len;
 }
@@ -1919,18 +1923,25 @@ static int parse_audio_selector_unit(struct mixer_b=
uild *state, int unitid, void
 	kctl->private_value =3D (unsigned long)namelist;
 	kctl->private_free =3D usb_mixer_selector_elem_free;
=20
-	nameid =3D uac_selector_unit_iSelector(desc);
+	/* check the static mapping table at first */
 	len =3D check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
-	if (len)
-		;
-	else if (nameid)
-		snd_usb_copy_string_desc(state, nameid, kctl->id.name, sizeof(kctl->id.n=
ame));
-	else {
-		len =3D get_term_name(state, &state->oterm,
+	if (!len) {
+		/* no mapping ? */
+		/* if iSelector is given, use it */
+		nameid =3D uac_selector_unit_iSelector(desc);
+		if (nameid)
+			len =3D snd_usb_copy_string_desc(state, nameid,
+						       kctl->id.name,
+						       sizeof(kctl->id.name));
+		/* ... or pick up the terminal name at next */
+		if (!len)
+			len =3D get_term_name(state, &state->oterm,
 				    kctl->id.name, sizeof(kctl->id.name), 0);
-		if (! len)
+		/* ... or use the fixed string "USB" as the last resort */
+		if (!len)
 			strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
=20
+		/* and add the proper suffix */
 		if (desc->bDescriptorSubtype =3D=3D UAC2_CLOCK_SELECTOR)
 			append_ctl_name(kctl, " Clock Source");
 		else if ((state->oterm.type & 0xff00) =3D=3D 0x0100)

--+sHJum3is6Tsg7/J--

--AqCDj3hiknadvR6t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWpwUAue/yOyVhhEJAQqztBAAyXhwd7WIYuMZMTyQiGdmKpDUvIJ/NEMN
AS8HCKsznvAVwUH+tL5qg5qLn7R8pFrMwf3BNiCRDm4vUpMFiE4MfIQYXe6f2pis
9SySU351ZbXpCOyKMkvj9eZyA75u3MQv2XltQ9S+s9cfWMWKnGfFey2HMqKyeMBs
WGaPXyyy1Lo6Zaxzrli0WjBxmXGkHtnx0ZMNY9Wj27/UxB8hgwOFMoHIUn5wLTpe
TfLADrPWqaYCJMbYDGnHiwYrROcGvGUX1YCP90TJ0Ol/SOEMPdNWPc8h79BR07YQ
LkvbivNH1sk+LpQdIodNkarlqN83s4jTb22k9wnDYkNmnUFkQtfFnnnzo1i+ILlY
xuIz7xdbfuPVPICvqQ/VLJ4Zh4xl9o1NRkm2aerejp+aTCTjsz20BCQW1QL+W+pz
8Zy4kC1hyNnHbRvzDogoJKihY71XAXlI0UXMfMnyK2wslZr2btCFkWJvGGB2zLh6
ayC7FCrv8hB2QG3Ly6oDagAD4AQ7NUATMmQNR8kYmJzfNrywqOtx76ps49lpD2Yz
vOvcZ2Gs/TDfaLeK0+XKWbbZZIaIgpjkfrocHE9p7y3FKfHAEofNRvoQXt/CBTjn
IJBWnnxlEHI+N3dy8ylR4HTVUJnYyQFw+38r4C3aqD5MCTJNsr2FkBqVucZMMGWy
Zwssk/tcAMo=
=QTZ0
-----END PGP SIGNATURE-----

--AqCDj3hiknadvR6t--
