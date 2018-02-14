Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3458174-1518631784-2-18203483849810952298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Attached: linux-3.16.54.patch
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518631775; b=KC5Pzv82sJ4JF6ZbTtoXaVGZ6rr9uAX/dli4CWHiKFA81Qh
    rFDNAS7q+/aDNYbRQp32cXgDA2O0ABVw9fAvyyXjtWb36FWSYFSIl1jcTyjJ9dQm
    FC020x/6W6qsRSJ0FTHQDSPjI+96d0mKP8XpJ+YC2ySAinpXetp++lRt4VDOHsLn
    AVKyz9/fORPZBKPomSSsQp7RA2iA9TCsACPAA2gZx8Dzy9Z0QV/ixP+OK7LbnNnR
    6VHpH5GlWH6w7VGOnKKOCeLl9GXSjrY4WJxEUOMpJDBjqn1p21+bTfI0BCt91FfT
    U4bGRqCu2mF1zkzVTH2PCCsSSE0fjgjoOSwXyGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:mime-version
    :content-type:subject:sender:list-id; s=arctest; t=1518631775;
    bh=CKAutZ0JRdKkqGEpdc0HbHlU+XY7v5TXc8xO6dBQPlY=; b=u9436l6pD7Ox
    ymgTl7wWbKFladnOrIFnYKFBQHxlP29z6uC1aGDqUIwmogxM54t6u++6RpDBldf4
    CZS2J7vo2CA048mQJdAeYylguZ/u9f7dIi9+Tu6rwx7UhiJotb7YhHPw8IXRy3dV
    bnoq/0/dcWoD+kajLL7AMlr+9+SkZGoTFYsH4LGATMoZnZGGd8/GwMtVokMDpNro
    W0njIi4P/5UYR8m1egbmQAkHpE6MVy7EOTWE4RI6H8Cd8LqhZBSD+jiYncgftgQM
    9gYRJcgO0hLqTTRivU7H3mRAHAS5H7/huEnn48MDtKae8oI28NEyX2vne4H917ys
    itTYs1crzA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161673AbeBNSJc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 13:09:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161672AbeBNSJS (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 13:09:18 -0500
Date: Wed, 14 Feb 2018 18:09:03 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc: lwn@lwn.net
Message-ID: <20180214180903.GD8564@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
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
Subject: Linux 3.16.54
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--+jhVVhN62yS6hEJ8
Content-Type: multipart/mixed; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.16.54 kernel.

All users of the 3.16 kernel series should upgrade.

The updated 3.16.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
=2Egit linux-3.16.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git

The diff from 3.16.53 is attached to this message.

Ben.

------------

 .../devicetree/bindings/sound/cs42l56.txt          |   2 +-
 Makefile                                           |   2 +-
 arch/arm/mm/dump.c                                 |   4 +-
 arch/arm64/kernel/vdso/gettimeofday.S              |   3 +-
 arch/mips/kernel/ptrace.c                          |  17 ++
 arch/parisc/kernel/syscall.S                       |   6 +-
 arch/powerpc/kernel/vio.c                          |   2 +
 arch/powerpc/platforms/powernv/opal-async.c        |   6 +-
 arch/powerpc/platforms/powernv/setup.c             |   2 +-
 arch/s390/include/asm/switch_to.h                  |   2 +-
 arch/s390/kernel/dis.c                             |   4 +-
 arch/s390/kernel/early.c                           |   4 +-
 arch/s390/kernel/process.c                         |   1 +
 arch/s390/kernel/runtime_instr.c                   |   4 +-
 arch/x86/include/asm/fixmap.h                      |  11 +-
 arch/x86/include/asm/pvclock.h                     |  15 +-
 arch/x86/include/asm/vdso.h                        |  19 +-
 arch/x86/kernel/alternative.c                      |  26 +-
 arch/x86/kernel/kvmclock.c                         |  16 +-
 arch/x86/kernel/pvclock.c                          |  68 -----
 arch/x86/kvm/svm.c                                 |   7 +
 arch/x86/kvm/vmx.c                                 |   4 +
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/kvm/x86.h                                 |   2 +
 arch/x86/lib/x86-opcode-map.txt                    |   2 +-
 arch/x86/mm/kaiser.c                               |   7 +-
 arch/x86/platform/uv/uv_nmi.c                      |   1 +
 arch/x86/vdso/vclock_gettime.c                     | 103 ++++---
 arch/x86/vdso/vdso-layout.lds.S                    |  45 ++-
 arch/x86/vdso/vdso2c.c                             |  15 +-
 arch/x86/vdso/vdso2c.h                             |  25 +-
 arch/x86/vdso/vma.c                                |  34 ++-
 block/blk-core.c                                   |   3 +
 drivers/acpi/apei/ghes.c                           |  85 +-----
 drivers/char/ipmi/ipmi_msghandler.c                |  10 +-
 drivers/char/tpm/tpm-dev.c                         |   6 +
 drivers/clk/tegra/clk-tegra30.c                    |   2 +-
 drivers/clk/ti/clk-dra7-atl.c                      |   3 +-
 drivers/crypto/caam/desc.h                         |   2 +-
 drivers/gpu/drm/gma500/mdfld_intel_display.c       |   2 +-
 drivers/gpu/drm/i915/intel_bios.c                  |   2 +-
 drivers/gpu/drm/i915/intel_display.c               |  14 +-
 drivers/gpu/drm/i915/intel_dp.c                    |   2 +-
 drivers/gpu/drm/radeon/atombios_dp.c               |  38 ++-
 drivers/gpu/drm/ttm/ttm_bo_util.c                  |   1 +
 drivers/infiniband/hw/mlx4/qp.c                    |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +
 drivers/infiniband/ulp/srp/ib_srp.c                |  23 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   9 +-
 drivers/input/misc/adxl34x.c                       |   2 +-
 drivers/iommu/dmar.c                               |   7 +-
 drivers/iommu/intel-iommu.c                        |  10 +
 drivers/md/bcache/alloc.c                          |   3 +-
 drivers/md/bcache/request.c                        |  10 +-
 drivers/md/dm-bufio.c                              |  15 +-
 drivers/md/dm-table.c                              |  32 +-
 drivers/md/dm.c                                    |  12 +-
 drivers/media/platform/omap/omap_vout.c            |   3 +-
 drivers/media/rc/ir-lirc-codec.c                   |   9 +-
 drivers/media/usb/cx231xx/cx231xx-cards.c          |   3 +-
 drivers/mtd/nand/nand_base.c                       |   9 +-
 drivers/mtd/nand/omap2.c                           | 340 ++++++++++++++---=
----
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  56 +---
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_txrx.c        |   2 +-
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c      |   2 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   2 +-
 drivers/net/ethernet/intel/igbvf/netdev.c          |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |   2 +-
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   2 +-
 drivers/net/wireless/p54/main.c                    |   7 +-
 drivers/net/wireless/rt2x00/rt2x00usb.c            |   6 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |   9 +-
 drivers/platform/x86/sony-laptop.c                 |  14 +-
 drivers/rtc/interface.c                            |  16 +-
 drivers/scsi/bfa/bfad_debugfs.c                    |   5 +-
 drivers/staging/android/ashmem.c                   |   2 +
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |   2 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c          |   3 +-
 drivers/staging/usbip/stub.h                       |   1 -
 drivers/staging/usbip/stub_dev.c                   |   4 +-
 drivers/staging/usbip/stub_rx.c                    |  66 ++--
 drivers/staging/usbip/stub_tx.c                    |  13 +-
 drivers/staging/usbip/usbip_common.h               |   1 +
 drivers/staging/usbip/userspace/Makefile.am        |   3 +-
 .../staging/usbip/userspace/libsrc/vhci_driver.c   |   8 +-
 drivers/staging/usbip/vhci_sysfs.c                 |  20 +-
 drivers/target/iscsi/iscsi_target.c                |  49 ++-
 drivers/target/target_core_tmr.c                   |  10 +
 drivers/target/target_core_transport.c             |   2 +
 drivers/usb/core/devio.c                           |  14 +
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/serial/garmin_gps.c                    |  22 +-
 drivers/usb/serial/metro-usb.c                     |  11 +-
 drivers/usb/serial/qcserial.c                      |   1 +
 drivers/video/fbdev/udlfb.c                        |  10 +-
 fs/9p/vfs_inode.c                                  |   3 +
 fs/9p/vfs_inode_dotl.c                             |   3 +
 fs/autofs4/waitq.c                                 |  16 +-
 fs/binfmt_elf_fdpic.c                              |   2 +
 fs/btrfs/super.c                                   |   4 +-
 fs/coda/upcall.c                                   |   3 +-
 fs/ecryptfs/messaging.c                            |   7 +-
 fs/ext4/extents.c                                  |   6 +-
 fs/f2fs/file.c                                     |   5 +
 fs/f2fs/segment.c                                  |  20 +-
 fs/isofs/isofs.h                                   |   2 +-
 fs/isofs/rock.h                                    |   2 +-
 fs/isofs/util.c                                    |   2 +-
 fs/nfs/nfs4proc.c                                  |  18 +-
 fs/nfs/nfs4trace.h                                 |   8 +-
 fs/nfs/super.c                                     |   2 +-
 fs/nilfs2/segment.c                                |   6 +-
 include/linux/blkdev.h                             |   1 +
 include/linux/dmar.h                               |   1 +
 include/linux/sched.h                              |   8 -
 include/net/sctp/sctp.h                            |   2 +
 include/net/sctp/structs.h                         |   8 +-
 include/target/target_core_base.h                  |   2 +
 kernel/extable.c                                   |   2 +
 kernel/sched/core.c                                |  15 -
 kernel/trace/blktrace.c                            |  76 ++++-
 lib/int_sqrt.c                                     |   3 +
 net/9p/client.c                                    |   3 +-
 net/9p/trans_virtio.c                              |  13 +-
 net/bluetooth/l2cap_core.c                         |  20 +-
 net/ipv4/route.c                                   |  14 +-
 net/l2tp/l2tp_core.c                               |  21 +-
 net/l2tp/l2tp_core.h                               |   3 +
 net/l2tp/l2tp_eth.c                                | 101 ++++--
 net/l2tp/l2tp_ppp.c                                | 236 ++++++++------
 net/netfilter/xt_TCPMSS.c                          |   6 +-
 net/nfc/core.c                                     |   2 +-
 net/rds/rdma.c                                     |   4 +
 net/sctp/ipv6.c                                    | 160 +++++-----
 net/sctp/protocol.c                                |  12 +-
 net/sctp/socket.c                                  |  33 +-
 net/sctp/transport.c                               |   4 +-
 net/sctp/ulpevent.c                                |   2 +-
 net/wireless/nl80211.c                             |  26 +-
 security/apparmor/domain.c                         |  53 +++-
 security/integrity/ima/ima_main.c                  |   4 +
 sound/core/seq/seq_clientmgr.c                     |  10 +-
 sound/core/seq/seq_clientmgr.h                     |   1 +
 sound/core/timer_compat.c                          |  12 +-
 sound/pci/hda/hda_intel.c                          |   3 +
 sound/usb/clock.c                                  |   9 +-
 sound/usb/mixer.c                                  |  15 +-
 148 files changed, 1470 insertions(+), 1021 deletions(-)

Alan Stern (1):
      USB: usbfs: compute urb->actual_length for isochronous

Alexander Popov (1):
      usbip: fix NULL pointer dereference on errors

Alexander Potapenko (1):
      sctp: fully initialize the IPv6 address in sctp_v6_to_addr()

Alexander Steffen (1):
      tpm-dev-common: Reject too short writes

Alexandre Belloni (1):
      rtc: set the alarm to the next expiring timer

Andreas Rohner (1):
      nilfs2: fix race condition that causes file system corruption

Andrew F. Davis (1):
      ASoC: cs42l56: Fix reset GPIO name in example DT binding

Andrey Konovalov (1):
      p54: don't unregister leds when they are not initialized

Andy Lutomirski (4):
      x86, vdso: Move the vvar area before the vdso text
      x86, vdso, pvclock: Simplify and speed up the vdso pvclock reader
      x86/vdso: Get pvclock data from the vvar VMA instead of the fixmap
      x86/vdso: Remove pvclock fixmap machinery

Anna Schumaker (1):
      NFS: Avoid RCU usage in tracepoints

Arnd Bergmann (4):
      drm: gma500: fix logic error
      Input: adxl34x - do not treat FIFO_MODE() as boolean
      elf_fdpic: fix unused variable warning
      isofs: fix timestamps beyond 2027

Bart Van Assche (3):
      IB/srpt: Do not accept invalid initiator port names
      IB/srp: Avoid that a cable pull can trigger a kernel crash
      target/iscsi: Fix iSCSI task reassignment handling

Ben Hutchings (2):
      usbip: tools: Install all headers needed for libusbip development
      Linux 3.16.54

Ben Seri (1):
      Bluetooth: Prevent stack info leak from the EFS element.

Bernhard Rosenkraenzer (1):
      USB: Add delay-init quirk for Corsair K70 LUX keyboards

Boshi Wang (1):
      ima: fix hash algorithm initialization

Brent Taylor (1):
      mtd: nand: Fix writing mtdoops to nand flash.

Brian King (6):
      ixgbe: Fix skb list corruption on Power systems
      i40e: Use smp_rmb rather than read_barrier_depends
      ixgbevf: Use smp_rmb rather than read_barrier_depends
      igbvf: Use smp_rmb rather than read_barrier_depends
      igb: Use smp_rmb rather than read_barrier_depends
      i40evf: Use smp_rmb rather than read_barrier_depends

Christian K=C3=B6nig (1):
      drm/ttm: once more fix ttm_buffer_object_transfer

Chuck Lever (1):
      nfs: Fix ugly referral attributes

Colin Ian King (3):
      rtc: interface: ignore expired timers when enqueuing new timers
      btrfs: avoid null pointer dereference on fs_info when calling btrfs_c=
rit
      staging: rtl8188eu: avoid a null dereference on pmlmepriv

Coly Li (2):
      bcache: check ca->alloc_thread initialized before wake up it
      bcache: only permit to recovery read error when cache device is clean

Corey Minyard (1):
      ipmi: fix unsigned long underflow

Dan Carpenter (2):
      scsi: bfa: integer overflow in debugfs
      eCryptfs: use after free in ecryptfs_release_messaging()

Dongho Sim (1):
      f2fs: remove redundant lines in allocate_data_block

Doug Berger (1):
      net: bcmgenet: enable loopback during UniMAC sw_reset

Douglas Fischer (1):
      USB: serial: qcserial: add pid/vid for Sierra Wireless EM7355 fw upda=
te

Eric Biggers (1):
      dm bufio: fix integer overflow when limiting maximum cache size

Eric Dumazet (1):
      netfilter: xt_TCPMSS: add more sanity tests on tcph->doff

Eric W. Biederman (1):
      net/sctp: Always set scope_id in sctp_inet6_skb_msgname

Gabriele Paoloni (1):
      PCI/AER: Report non-fatal errors only to the affected endpoint

Guenter Roeck (1):
      kaiser: Set _PAGE_NX only if supported

Guillaume Nault (5):
      l2tp: ensure sessions are freed after their PPPOL2TP socket
      l2tp: don't register sessions in l2tp_session_create()
      l2tp: initialise l2tp_eth sessions before registering them
      l2tp: protect sock pointer of struct pppol2tp_session with RCU
      l2tp: initialise PPP sessions before registering them

Heiko Carstens (2):
      s390/runtime instrumention: fix possible memory corruption
      s390: fix transactional execution control register handling

Hou Tao (1):
      dm: fix race between dm_get_from_kobject() and __dm_destroy()

Ingo Molnar (1):
      x86/platform/uv: Include clocksource.h for clocksource_touch_watchdog=
()

Jaegeuk Kim (1):
      f2fs: expose some sectors to user in inline data or dentry case

James Morse (2):
      ACPI / APEI: Replace ioremap_page_range() with fixmap
      ACPI / APEI: Remove ghes_ioremap_area

Jan Harkes (1):
      coda: fix 'kernel memory exposure attempt' in fsync

Jani Nikula (1):
      drm/i915/bios: parse DDI ports also for CHV for HDMI DDC pin and DP A=
UX channel

Jason Gunthorpe (1):
      sctp: Fixup v4mapped behaviour to comply with Sock API

Jens Axboe (1):
      blktrace: fix unlocked access to init/start-stop/teardown

Joerg Roedel (1):
      iommu/vt-d: Don't register bus-notifier under dmar_global_lock

Johan Hovold (5):
      USB: serial: garmin_gps: fix I/O after failed probe and remove
      USB: serial: garmin_gps: fix memory leak on probe errors
      USB: serial: metro-usb: stop I/O after failed open
      NFC: fix device-allocation error return
      clk: ti: dra7-atl-clock: fix child-node lookups

Johannes Berg (1):
      nl80211: don't expose wdev->ssid for most interfaces

John David Anglin (1):
      parisc: Fix validity check of pointer size argument in new CAS implem=
entation

John Johansen (1):
      apparmor: ensure that undecidable profile attachments fail

Joshua Watt (1):
      NFS: Fix typo in nomigration mount option

Juerg Haefliger (1):
      Revert "x86: kvmclock: Disable use from vDSO if KPTI is enabled"

Ladi Prosek (1):
      KVM: nVMX: set IDTR and GDTR limits when loading L1 host state

Ladislav Michl (1):
      video: udlfb: Fix read EDID timeout

Lepton Wu (1):
      kaiser: Set _PAGE_NX only if supported

Maciej W. Rozycki (1):
      MIPS: Fix an n32 core file generation regset support regression

Majd Dibbiny (1):
      IB/mlx5: Assign send CQ and recv CQ of UMR QP

Manasi Navare (1):
      drm/i915/edp: Get the Panel Power Off timestamp after panel is off

Mark Bloch (1):
      IB/mlx4: Increase maximal message size under UD QP

Mark Rutland (1):
      arm64: vdso: fix clock_getres for 4GiB-aligned res

Markus Elfring (2):
      media: omap_vout: Fix a possible null pointer dereference in omap_vou=
t_open()
      platform/x86: sony-laptop: Fix error handling in sony_nc_setup_rfkill=
()

Masami Hiramatsu (1):
      x86/decoder: Add new TEST instruction pattern

Mauro Carvalho Chehab (1):
      cx231xx: Fix the max number of interfaces

Micha=C5=82 Miros=C5=82aw (1):
      clk: tegra: Fix cclk_lp divisor register

Mike Snitzer (1):
      dm: discard support requires all targets in a table support discards

Mohamed Ghannam (2):
      RDS: Heap OOB write in rds_message_alloc_sgs()
      RDS: null pointer dereference in rds_atomic_free_op

Nadav Amit (2):
      staging: lustre: ptlrpc: kfree used instead of kvfree
      KVM: vmx: Inject #GP on invalid PAT CR

Nathan Lynch (1):
      arm64: vdso: minor ABI fix for clock_getres

NeilBrown (2):
      autofs: don't fail mount for transient error
      autofs: fix careless error in recent commit

Nicholas Bellinger (3):
      target: Avoid early CMD_T_PRE_EXECUTE failures during ABORT_TASK
      iscsi-target: Make TASK_REASSIGN use proper se_cmd->cmd_kref
      iscsi-target: Fix non-immediate TMR reference leak

Paolo Bonzini (2):
      KVM: SVM: obey guest PAT
      x86: pvclock: Really remove the sched notifier for cross-cpu migratio=
ns

Peter Ujfalusi (1):
      clk: ti: dra7-atl-clock: Fix of_node reference counting

Peter Zijlstra (1):
      lib/int_sqrt: optimize small argument

Philip Derrin (1):
      ARM: 8721/1: mm: dump: check hardware RO bit for LPAE

Radu Alexe (1):
      crypto: caam - fix incorrect define

Roger Quadros (1):
      mtd: nand: omap2: Fix subpage write

Roman Kapl (1):
      drm/radeon: fix atombios on big endian

Sean Young (1):
      media: rc: check for integer overflow

Shriya (1):
      powerpc/powernv/cpufreq: Fix the frequency read by /proc/cpuinfo

Shuah Khan (4):
      usbip: fix stub_rx: get_pipe() to validate endpoint number
      usbip: fix stub_rx: harden CMD_SUBMIT path to handle malicious input
      usbip: prevent vhci_hcd driver from leaking a socket pointer address
      usbip: fix stub_send_ret_submit() vulnerability to null transfer_buff=
er

Stanislaw Gruszka (1):
      rt2x00usb: mark device removed when get ENOENT usb error

Takashi Iwai (5):
      ALSA: timer: Remove kernel warning at compat ioctl error paths
      ALSA: usb-audio: Add sanity checks to FE parser
      ALSA: usb-audio: Fix potential out-of-bound access at parsing SU
      ALSA: usb-audio: Add sanity checks in v2 clock parsers
      ALSA: seq: Make ioctls race-free

Theodore Ts'o (1):
      ext4: fix interaction between i_size, fallocate, and delalloc after a=
 crash

Tuomas Tynkkynen (2):
      fs/9p: Compare qid.path in v9fs_test_inode
      net/9p: Switch to wait_event_killable()

Tyrel Datwyler (1):
      powerpc/pseries/vio: Dispose of virq mapping on vdevice unregister

Vasily Gorbik (1):
      s390/disassembler: increase show_code buffer size

Vijendar Mukunda (1):
      ALSA: hda: Add Raven PCI ID

Viktor Slavkovic (1):
      staging: android: ashmem: fix a race condition in ASHMEM_SET_SIZE ioc=
tl

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Read timings from the correct transcoder in intel_crtc_mode=
_get()

Waiman Long (1):
      blktrace: Fix potential deadlock between delete & sysfs ops

William A. Kennington III (1):
      powerpc/opal: Fix EBUSY bug in acquiring tokens

Xin Long (2):
      route: update fnhe_expires for redirect when the fnhe exists
      route: also update fnhe_genid when updating a route cache

Yunlong Song (1):
      Revert "f2fs: handle dirty segments inside refresh_sit_entry"

Zhou Chengming (1):
      kprobes, x86/alternatives: Use text_mutex to protect smp_alt_modules


--7LkOrbQMr4cezO2T
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.16.54.patch"
Content-Disposition: attachment; filename="linux-3.16.54.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Documentation/devicetree/bindings/sound/cs42l56.txt b/Document=
ation/devicetree/bindings/sound/cs42l56.txt
index 4feb0eb27ea4..4ba520a28ae8 100644
--- a/Documentation/devicetree/bindings/sound/cs42l56.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l56.txt
@@ -55,7 +55,7 @@ CS42L52 audio CODEC
 codec: codec@4b {
 	compatible =3D "cirrus,cs42l56";
 	reg =3D <0x4b>;
-	gpio-reset =3D <&gpio 10 0>;
+	cirrus,gpio-nreset =3D <&gpio 10 0>;
 	cirrus,chgfreq-divisor =3D <0x05>;
 	cirrus.ain1_ref_cfg;
 	cirrus,micbias-lvl =3D <5>;
diff --git a/Makefile b/Makefile
index 4386eb2679ae..cafa8cf0dfc1 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 16
-SUBLEVEL =3D 53
+SUBLEVEL =3D 54
 EXTRAVERSION =3D
 NAME =3D Museum of Fishiegoodies
=20
diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
index 59424937e52b..e223322fc71b 100644
--- a/arch/arm/mm/dump.c
+++ b/arch/arm/mm/dump.c
@@ -126,8 +126,8 @@ static const struct prot_bits section_bits[] =3D {
 		.val	=3D PMD_SECT_USER,
 		.set	=3D "USR",
 	}, {
-		.mask	=3D L_PMD_SECT_RDONLY,
-		.val	=3D L_PMD_SECT_RDONLY,
+		.mask	=3D L_PMD_SECT_RDONLY | PMD_SECT_AP2,
+		.val	=3D L_PMD_SECT_RDONLY | PMD_SECT_AP2,
 		.set	=3D "ro",
 		.clear	=3D "RW",
 #elif __LINUX_ARM_ARCH__ >=3D 6
diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso=
/gettimeofday.S
index fe652ffd34c2..0419069a6c97 100644
--- a/arch/arm64/kernel/vdso/gettimeofday.S
+++ b/arch/arm64/kernel/vdso/gettimeofday.S
@@ -174,8 +174,6 @@ ENDPROC(__kernel_clock_gettime)
 /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
 ENTRY(__kernel_clock_getres)
 	.cfi_startproc
-	cbz	w1, 3f
-
 	cmp	w0, #CLOCK_REALTIME
 	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
 	b.ne	1f
@@ -188,6 +186,7 @@ ENTRY(__kernel_clock_getres)
 	b.ne	4f
 	ldr	x2, 6f
 2:
+	cbz	x1, 3f
 	stp	xzr, x2, [x1]
=20
 3:	/* res =3D=3D NULL. */
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index cdb8cc7800a2..b094c4a8ce71 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -522,6 +522,19 @@ static const struct user_regset_view user_mips64_view =
=3D {
 	.n		=3D ARRAY_SIZE(mips64_regsets),
 };
=20
+#ifdef CONFIG_MIPS32_N32
+
+static const struct user_regset_view user_mipsn32_view =3D {
+	.name		=3D "mipsn32",
+	.e_flags	=3D EF_MIPS_ABI2,
+	.e_machine	=3D ELF_ARCH,
+	.ei_osabi	=3D ELF_OSABI,
+	.regsets	=3D mips64_regsets,
+	.n		=3D ARRAY_SIZE(mips64_regsets),
+};
+
+#endif /* CONFIG_MIPS32_N32 */
+
 #endif /* CONFIG_64BIT */
=20
 const struct user_regset_view *task_user_regset_view(struct task_struct *t=
ask)
@@ -532,6 +545,10 @@ const struct user_regset_view *task_user_regset_view(s=
truct task_struct *task)
 #ifdef CONFIG_MIPS32_O32
 	if (test_tsk_thread_flag(task, TIF_32BIT_REGS))
 		return &user_mips_view;
+#endif
+#ifdef CONFIG_MIPS32_N32
+	if (test_tsk_thread_flag(task, TIF_32BIT_ADDR))
+		return &user_mipsn32_view;
 #endif
 	return &user_mips64_view;
 #endif
diff --git a/arch/parisc/kernel/syscall.S b/arch/parisc/kernel/syscall.S
index df6ff75c03ce..3284a3bbd9fb 100644
--- a/arch/parisc/kernel/syscall.S
+++ b/arch/parisc/kernel/syscall.S
@@ -690,15 +690,15 @@ ENTRY(linux_gateway_page)
 	/* ELF32 Process entry path */
 lws_compare_and_swap_2:
 #ifdef CONFIG_64BIT
-	/* Clip the input registers */
+	/* Clip the input registers. We don't need to clip %r23 as we
+	   only use it for word operations */
 	depdi	0, 31, 32, %r26
 	depdi	0, 31, 32, %r25
 	depdi	0, 31, 32, %r24
-	depdi	0, 31, 32, %r23
 #endif
=20
 	/* Check the validity of the size pointer */
-	subi,>>=3D 4, %r23, %r0
+	subi,>>=3D 3, %r23, %r0
 	b,n	lws_exit_nosys
=20
 	/* Jump to the functions which will load the old and new values into
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 904c66128fae..f30807e7697b 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1572,6 +1572,8 @@ static struct device_attribute vio_dev_attrs[] =3D {
 void vio_unregister_device(struct vio_dev *viodev)
 {
 	device_unregister(&viodev->dev);
+	if (viodev->family =3D=3D VDEVICE)
+		irq_dispose_mapping(viodev->irq);
 }
 EXPORT_SYMBOL(vio_unregister_device);
=20
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/pla=
tforms/powernv/opal-async.c
index 32e2adfa5320..d867e51cb709 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -38,18 +38,18 @@ int __opal_async_get_token(void)
 	int token;
=20
 	spin_lock_irqsave(&opal_async_comp_lock, flags);
-	token =3D find_first_bit(opal_async_complete_map, opal_max_async_tokens);
+	token =3D find_first_zero_bit(opal_async_token_map, opal_max_async_tokens=
);
 	if (token >=3D opal_max_async_tokens) {
 		token =3D -EBUSY;
 		goto out;
 	}
=20
-	if (__test_and_set_bit(token, opal_async_token_map)) {
+	if (!__test_and_clear_bit(token, opal_async_complete_map)) {
 		token =3D -EBUSY;
 		goto out;
 	}
=20
-	__clear_bit(token, opal_async_complete_map);
+	__set_bit(token, opal_async_token_map);
=20
 out:
 	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platform=
s/powernv/setup.c
index d9b88fa7c5a3..51b2c6aae0ec 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -309,7 +309,7 @@ unsigned long pnv_get_proc_freq(unsigned int cpu)
 {
 	unsigned long ret_freq;
=20
-	ret_freq =3D cpufreq_quick_get(cpu) * 1000ul;
+	ret_freq =3D cpufreq_get(cpu) * 1000ul;
=20
 	/*
 	 * If the backend cpufreq driver does not exist,
diff --git a/arch/s390/include/asm/switch_to.h b/arch/s390/include/asm/swit=
ch_to.h
index 716df3a992d0..7d8ed6de0858 100644
--- a/arch/s390/include/asm/switch_to.h
+++ b/arch/s390/include/asm/switch_to.h
@@ -124,12 +124,12 @@ static inline void restore_access_regs(unsigned int *=
acrs)
 		save_access_regs(&prev->thread.acrs[0]);		\
 		save_ri_cb(prev->thread.ri_cb);				\
 	}								\
+	update_cr_regs(next);						\
 	if (next->mm) {							\
 		restore_fp_ctl(&next->thread.fp_regs.fpc);		\
 		restore_fp_regs(next->thread.fp_regs.fprs);		\
 		restore_access_regs(&next->thread.acrs[0]);		\
 		restore_ri_cb(next->thread.ri_cb, prev->thread.ri_cb);	\
-		update_cr_regs(next);					\
 	}								\
 	prev =3D __switch_to(prev,next);					\
 } while (0)
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 3d942314818b..a0c29638a707 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -1765,7 +1765,7 @@ void show_code(struct pt_regs *regs)
 {
 	char *mode =3D user_mode(regs) ? "User" : "Krnl";
 	unsigned char code[64];
-	char buffer[64], *ptr;
+	char buffer[128], *ptr;
 	mm_segment_t old_fs;
 	unsigned long addr;
 	int start, end, opsize, hops, i;
@@ -1828,7 +1828,7 @@ void show_code(struct pt_regs *regs)
 		start +=3D opsize;
 		printk(buffer);
 		ptr =3D buffer;
-		ptr +=3D sprintf(ptr, "\n          ");
+		ptr +=3D sprintf(ptr, "\n\t  ");
 		hops++;
 	}
 	printk("\n");
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 0dff972a169c..ec372dd54c7f 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -388,8 +388,10 @@ static __init void detect_machine_facilities(void)
 		S390_lowcore.machine_flags |=3D MACHINE_FLAG_IDTE;
 	if (test_facility(40))
 		S390_lowcore.machine_flags |=3D MACHINE_FLAG_LPP;
-	if (test_facility(50) && test_facility(73))
+	if (test_facility(50) && test_facility(73)) {
 		S390_lowcore.machine_flags |=3D MACHINE_FLAG_TE;
+		__ctl_set_bit(0, 55);
+	}
 	if (test_facility(66))
 		S390_lowcore.machine_flags |=3D MACHINE_FLAG_RRBM;
 	if (test_facility(51))
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 8a7f7732db1f..604b3e7577db 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -123,6 +123,7 @@ int copy_thread(unsigned long clone_flags, unsigned lon=
g new_stackp,
 	memset(&p->thread.per_user, 0, sizeof(p->thread.per_user));
 	memset(&p->thread.per_event, 0, sizeof(p->thread.per_event));
 	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
+	p->thread.per_flags =3D 0;
 	/* Initialize per thread user and system timer values */
 	ti =3D task_thread_info(p);
 	ti->user_timer =3D 0;
diff --git a/arch/s390/kernel/runtime_instr.c b/arch/s390/kernel/runtime_in=
str.c
index 26b4ae96fdd7..ddbec1054f75 100644
--- a/arch/s390/kernel/runtime_instr.c
+++ b/arch/s390/kernel/runtime_instr.c
@@ -53,12 +53,14 @@ void exit_thread_runtime_instr(void)
 {
 	struct task_struct *task =3D current;
=20
+	preempt_disable();
 	if (!task->thread.ri_cb)
 		return;
 	disable_runtime_instr();
 	kfree(task->thread.ri_cb);
 	task->thread.ri_signum =3D 0;
 	task->thread.ri_cb =3D NULL;
+	preempt_enable();
 }
=20
 static void runtime_instr_int_handler(struct ext_code ext_code,
@@ -100,9 +102,7 @@ SYSCALL_DEFINE2(s390_runtime_instr, int, command, int, =
signum)
 		return -EOPNOTSUPP;
=20
 	if (command =3D=3D S390_RUNTIME_INSTR_STOP) {
-		preempt_disable();
 		exit_thread_runtime_instr();
-		preempt_enable();
 		return 0;
 	}
=20
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index ffb1733ac91f..ce8cbba4dd34 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -19,7 +19,6 @@
 #include <asm/acpi.h>
 #include <asm/apicdef.h>
 #include <asm/page.h>
-#include <asm/pvclock.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
 #include <asm/kmap_types.h>
@@ -70,10 +69,6 @@ enum fixed_addresses {
 	FIX_HOLE,
 #else
 	VSYSCALL_PAGE =3D (FIXADDR_TOP - VSYSCALL_ADDR) >> PAGE_SHIFT,
-#ifdef CONFIG_PARAVIRT_CLOCK
-	PVCLOCK_FIXMAP_BEGIN,
-	PVCLOCK_FIXMAP_END =3D PVCLOCK_FIXMAP_BEGIN+PVCLOCK_VSYSCALL_NR_PAGES-1,
-#endif
 #endif
 	FIX_DBGP_BASE,
 	FIX_EARLYCON_MEM_BASE,
@@ -103,6 +98,12 @@ enum fixed_addresses {
 #ifdef	CONFIG_X86_INTEL_MID
 	FIX_LNW_VRTC,
 #endif
+#ifdef CONFIG_ACPI_APEI_GHES
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+	FIX_APEI_GHES_NMI,
+#endif
+
 	__end_of_permanent_fixed_addresses,
=20
 	/*
diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index 25b1cc07d496..b80536e62fae 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -4,6 +4,15 @@
 #include <linux/clocksource.h>
 #include <asm/pvclock-abi.h>
=20
+#ifdef CONFIG_PARAVIRT_CLOCK
+extern struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void);
+#else
+static inline struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void)
+{
+	return NULL;
+}
+#endif
+
 /* some helper functions for xen and kvm pv clock sources */
 cycle_t pvclock_clocksource_read(struct pvclock_vcpu_time_info *src);
 u8 pvclock_read_flags(struct pvclock_vcpu_time_info *src);
@@ -95,14 +104,8 @@ unsigned __pvclock_read_cycles(const struct pvclock_vcp=
u_time_info *src,
=20
 struct pvclock_vsyscall_time_info {
 	struct pvclock_vcpu_time_info pvti;
-	u32 migrate_count;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
=20
 #define PVTI_SIZE sizeof(struct pvclock_vsyscall_time_info)
-#define PVCLOCK_VSYSCALL_NR_PAGES (((NR_CPUS-1)/(PAGE_SIZE/PVTI_SIZE))+1)
-
-int __init pvclock_init_vsyscall(struct pvclock_vsyscall_time_info *i,
-				 int size);
-struct pvclock_vcpu_time_info *pvclock_get_vsyscall_time_info(int cpu);
=20
 #endif /* _ASM_X86_PVCLOCK_H */
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 30be253dd283..f97d32664779 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -18,15 +18,16 @@ struct vdso_image {
=20
 	unsigned long alt, alt_len;
=20
-	unsigned long sym_end_mapping;  /* Total size of the mapping */
-
-	unsigned long sym_vvar_page;
-	unsigned long sym_hpet_page;
-	unsigned long sym_VDSO32_NOTE_MASK;
-	unsigned long sym___kernel_sigreturn;
-	unsigned long sym___kernel_rt_sigreturn;
-	unsigned long sym___kernel_vsyscall;
-	unsigned long sym_VDSO32_SYSENTER_RETURN;
+	long sym_vvar_start;  /* Negative offset to the vvar area */
+
+	long sym_vvar_page;
+	long sym_hpet_page;
+	long sym_pvclock_page;
+	long sym_VDSO32_NOTE_MASK;
+	long sym___kernel_sigreturn;
+	long sym___kernel_rt_sigreturn;
+	long sym___kernel_vsyscall;
+	long sym_VDSO32_SYSENTER_RETURN;
 };
=20
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index af397cc98d05..fa030d032eb7 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -409,7 +409,6 @@ static void alternatives_smp_lock(const s32 *start, con=
st s32 *end,
 {
 	const s32 *poff;
=20
-	mutex_lock(&text_mutex);
 	for (poff =3D start; poff < end; poff++) {
 		u8 *ptr =3D (u8 *)poff + *poff;
=20
@@ -419,7 +418,6 @@ static void alternatives_smp_lock(const s32 *start, con=
st s32 *end,
 		if (*ptr =3D=3D 0x3e)
 			text_poke(ptr, ((unsigned char []){0xf0}), 1);
 	}
-	mutex_unlock(&text_mutex);
 }
=20
 static void alternatives_smp_unlock(const s32 *start, const s32 *end,
@@ -427,7 +425,6 @@ static void alternatives_smp_unlock(const s32 *start, c=
onst s32 *end,
 {
 	const s32 *poff;
=20
-	mutex_lock(&text_mutex);
 	for (poff =3D start; poff < end; poff++) {
 		u8 *ptr =3D (u8 *)poff + *poff;
=20
@@ -437,7 +434,6 @@ static void alternatives_smp_unlock(const s32 *start, c=
onst s32 *end,
 		if (*ptr =3D=3D 0xf0)
 			text_poke(ptr, ((unsigned char []){0x3E}), 1);
 	}
-	mutex_unlock(&text_mutex);
 }
=20
 struct smp_alt_module {
@@ -456,8 +452,7 @@ struct smp_alt_module {
 	struct list_head next;
 };
 static LIST_HEAD(smp_alt_modules);
-static DEFINE_MUTEX(smp_alt);
-static bool uniproc_patched =3D false;	/* protected by smp_alt */
+static bool uniproc_patched =3D false;	/* protected by text_mutex */
=20
 void __init_or_module alternatives_smp_module_add(struct module *mod,
 						  char *name,
@@ -466,7 +461,7 @@ void __init_or_module alternatives_smp_module_add(struc=
t module *mod,
 {
 	struct smp_alt_module *smp;
=20
-	mutex_lock(&smp_alt);
+	mutex_lock(&text_mutex);
 	if (!uniproc_patched)
 		goto unlock;
=20
@@ -493,14 +488,14 @@ void __init_or_module alternatives_smp_module_add(str=
uct module *mod,
 smp_unlock:
 	alternatives_smp_unlock(locks, locks_end, text, text_end);
 unlock:
-	mutex_unlock(&smp_alt);
+	mutex_unlock(&text_mutex);
 }
=20
 void __init_or_module alternatives_smp_module_del(struct module *mod)
 {
 	struct smp_alt_module *item;
=20
-	mutex_lock(&smp_alt);
+	mutex_lock(&text_mutex);
 	list_for_each_entry(item, &smp_alt_modules, next) {
 		if (mod !=3D item->mod)
 			continue;
@@ -508,7 +503,7 @@ void __init_or_module alternatives_smp_module_del(struc=
t module *mod)
 		kfree(item);
 		break;
 	}
-	mutex_unlock(&smp_alt);
+	mutex_unlock(&text_mutex);
 }
=20
 void alternatives_enable_smp(void)
@@ -518,7 +513,7 @@ void alternatives_enable_smp(void)
 	/* Why bother if there are no other CPUs? */
 	BUG_ON(num_possible_cpus() =3D=3D 1);
=20
-	mutex_lock(&smp_alt);
+	mutex_lock(&text_mutex);
=20
 	if (uniproc_patched) {
 		pr_info("switching to SMP code\n");
@@ -530,10 +525,13 @@ void alternatives_enable_smp(void)
 					      mod->text, mod->text_end);
 		uniproc_patched =3D false;
 	}
-	mutex_unlock(&smp_alt);
+	mutex_unlock(&text_mutex);
 }
=20
-/* Return 1 if the address range is reserved for smp-alternatives */
+/*
+ * Return 1 if the address range is reserved for SMP-alternatives.
+ * Must hold text_mutex.
+ */
 int alternatives_text_reserved(void *start, void *end)
 {
 	struct smp_alt_module *mod;
@@ -541,6 +539,8 @@ int alternatives_text_reserved(void *start, void *end)
 	u8 *text_start =3D start;
 	u8 *text_end =3D end;
=20
+	lockdep_assert_held(&text_mutex);
+
 	list_for_each_entry(mod, &smp_alt_modules, next) {
 		if (mod->text > text_end || mod->text_end < text_start)
 			continue;
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 206aa5a2afe0..218035f29166 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -24,7 +24,6 @@
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
 #include <linux/memblock.h>
-#include <linux/kaiser.h>
=20
 #include <asm/x86_init.h>
 #include <asm/reboot.h>
@@ -44,6 +43,11 @@ early_param("no-kvmclock", parse_no_kvmclock);
 static struct pvclock_vsyscall_time_info *hv_clock;
 static struct pvclock_wall_clock wall_clock;
=20
+struct pvclock_vsyscall_time_info *pvclock_pvti_cpu0_va(void)
+{
+	return hv_clock;
+}
+
 /*
  * The wallclock is the time of day when we booted. Since then, some time =
may
  * have elapsed since the hypervisor wrote the data. So we try to account =
for
@@ -274,7 +278,6 @@ int __init kvm_setup_vsyscall_timeinfo(void)
 {
 #ifdef CONFIG_X86_64
 	int cpu;
-	int ret;
 	u8 flags;
 	struct pvclock_vcpu_time_info *vcpu_time;
 	unsigned int size;
@@ -282,10 +285,6 @@ int __init kvm_setup_vsyscall_timeinfo(void)
 	if (!hv_clock)
 		return 0;
=20
-	/* FIXME: Need to add pvclock pages to user-space page tables */
-	if (kaiser_enabled)
-		return 0;
-
 	size =3D PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
=20
 	preempt_disable();
@@ -299,11 +298,6 @@ int __init kvm_setup_vsyscall_timeinfo(void)
 		return 1;
 	}
=20
-	if ((ret =3D pvclock_init_vsyscall(hv_clock, size))) {
-		preempt_enable();
-		return ret;
-	}
-
 	preempt_enable();
=20
 	kvm_clock.archdata.vclock_mode =3D VCLOCK_PVCLOCK;
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index e5ecd20e72dd..99bfc025111d 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -140,71 +140,3 @@ void pvclock_read_wallclock(struct pvclock_wall_clock =
*wall_clock,
=20
 	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
 }
-
-static struct pvclock_vsyscall_time_info *pvclock_vdso_info;
-
-static struct pvclock_vsyscall_time_info *
-pvclock_get_vsyscall_user_time_info(int cpu)
-{
-	if (!pvclock_vdso_info) {
-		BUG();
-		return NULL;
-	}
-
-	return &pvclock_vdso_info[cpu];
-}
-
-struct pvclock_vcpu_time_info *pvclock_get_vsyscall_time_info(int cpu)
-{
-	return &pvclock_get_vsyscall_user_time_info(cpu)->pvti;
-}
-
-#ifdef CONFIG_X86_64
-static int pvclock_task_migrate(struct notifier_block *nb, unsigned long l,
-			        void *v)
-{
-	struct task_migration_notifier *mn =3D v;
-	struct pvclock_vsyscall_time_info *pvti;
-
-	pvti =3D pvclock_get_vsyscall_user_time_info(mn->from_cpu);
-
-	/* this is NULL when pvclock vsyscall is not initialized */
-	if (unlikely(pvti =3D=3D NULL))
-		return NOTIFY_DONE;
-
-	pvti->migrate_count++;
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block pvclock_migrate =3D {
-	.notifier_call =3D pvclock_task_migrate,
-};
-
-/*
- * Initialize the generic pvclock vsyscall state.  This will allocate
- * a/some page(s) for the per-vcpu pvclock information, set up a
- * fixmap mapping for the page(s)
- */
-
-int __init pvclock_init_vsyscall(struct pvclock_vsyscall_time_info *i,
-				 int size)
-{
-	int idx;
-
-	WARN_ON (size !=3D PVCLOCK_VSYSCALL_NR_PAGES*PAGE_SIZE);
-
-	pvclock_vdso_info =3D i;
-
-	for (idx =3D 0; idx <=3D (PVCLOCK_FIXMAP_END-PVCLOCK_FIXMAP_BEGIN); idx++=
) {
-		__set_fixmap(PVCLOCK_FIXMAP_BEGIN + idx,
-			     __pa(i) + (idx*PAGE_SIZE),
-			     PAGE_KERNEL_VVAR);
-	}
-
-
-	register_task_migration_notifier(&pvclock_migrate);
-
-	return 0;
-}
-#endif
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 2003a07de9ad..5ac22e7c3bf7 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3157,6 +3157,13 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct=
 msr_data *msr)
 	u32 ecx =3D msr->index;
 	u64 data =3D msr->data;
 	switch (ecx) {
+	case MSR_IA32_CR_PAT:
+		if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
+			return 1;
+		vcpu->arch.pat =3D data;
+		svm->vmcb->save.g_pat =3D data;
+		mark_dirty(svm->vmcb, VMCB_NPT);
+		break;
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, msr);
 		break;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 6f6f77a5145c..329eb2260ade 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2599,6 +2599,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct =
msr_data *msr_info)
 		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
+			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
+				return 1;
 			vmcs_write64(GUEST_IA32_PAT, data);
 			vcpu->arch.pat =3D data;
 			break;
@@ -8695,6 +8697,8 @@ static void load_vmcs12_host_state(struct kvm_vcpu *v=
cpu,
 	vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->host_ia32_sysenter_eip);
 	vmcs_writel(GUEST_IDTR_BASE, vmcs12->host_idtr_base);
 	vmcs_writel(GUEST_GDTR_BASE, vmcs12->host_gdtr_base);
+	vmcs_write32(GUEST_IDTR_LIMIT, 0xFFFF);
+	vmcs_write32(GUEST_GDTR_LIMIT, 0xFFFF);
=20
 	/* If not VM_EXIT_CLEAR_BNDCFGS, the L2 value propagates to L1.  */
 	if (vmcs12->vm_exit_controls & VM_EXIT_CLEAR_BNDCFGS)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d0847b33282f..64052c92ba5c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1742,7 +1742,7 @@ static bool valid_mtrr_type(unsigned t)
 	return t < 8 && (1 << t) & 0x73; /* 0, 1, 4, 5, 6 */
 }
=20
-static bool mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+bool kvm_mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	int i;
=20
@@ -1768,12 +1768,13 @@ static bool mtrr_valid(struct kvm_vcpu *vcpu, u32 m=
sr, u64 data)
 	/* variable MTRRs */
 	return valid_mtrr_type(data & 0xff);
 }
+EXPORT_SYMBOL_GPL(kvm_mtrr_valid);
=20
 static int set_msr_mtrr(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	u64 *p =3D (u64 *)&vcpu->arch.mtrr_state.fixed_ranges;
=20
-	if (!mtrr_valid(vcpu, msr, data))
+	if (!kvm_mtrr_valid(vcpu, msr, data))
 		return 1;
=20
 	if (msr =3D=3D MSR_MTRRdefType) {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index b0b17e6f0431..8bc086f5c5a6 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -132,6 +132,8 @@ int kvm_write_guest_virt_system(struct x86_emulate_ctxt=
 *ctxt,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
=20
+bool kvm_mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data);
+
 #define KVM_SUPPORTED_XCR0     (XSTATE_FP | XSTATE_SSE | XSTATE_YMM \
 				| XSTATE_BNDREGS | XSTATE_BNDCSR)
 extern u64 host_xcr0;
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.=
txt
index 1a2be7c6895d..3ce0dcc56ce5 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -814,7 +814,7 @@ EndTable
=20
 GrpTable: Grp3_1
 0: TEST Eb,Ib
-1:
+1: TEST Eb,Ib
 2: NOT Eb
 3: NEG Eb
 4: MUL AL,Eb
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index 8d1019d176e2..8a07537dae08 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -195,6 +195,8 @@ static int kaiser_add_user_map(const void *__start_addr=
, unsigned long size,
 	 * requires that not to be #defined to 0): so mask it off here.
 	 */
 	flags &=3D ~_PAGE_GLOBAL;
+	if (!(__supported_pte_mask & _PAGE_NX))
+		flags &=3D ~_PAGE_NX;
=20
 	for (; address < end_addr; address +=3D PAGE_SIZE) {
 		target_address =3D get_pa_from_mapping(address);
@@ -322,7 +324,7 @@ void __init kaiser_check_boottime_disable(void)
  */
 void __init kaiser_init(void)
 {
-	int cpu, idx;
+	int cpu;
=20
 	if (!kaiser_enabled)
 		return;
@@ -428,7 +430,8 @@ pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd)
 			 * get out to userspace running on the kernel CR3,
 			 * userspace will crash instead of running.
 			 */
-			pgd.pgd |=3D _PAGE_NX;
+			if (__supported_pte_mask & _PAGE_NX)
+				pgd.pgd |=3D _PAGE_NX;
 		}
 	} else if (!pgd.pgd) {
 		/*
diff --git a/arch/x86/platform/uv/uv_nmi.c b/arch/x86/platform/uv/uv_nmi.c
index c89c93320c12..30777beb345a 100644
--- a/arch/x86/platform/uv/uv_nmi.c
+++ b/arch/x86/platform/uv/uv_nmi.c
@@ -28,6 +28,7 @@
 #include <linux/nmi.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/clocksource.h>
=20
 #include <asm/apic.h>
 #include <asm/current.h>
diff --git a/arch/x86/vdso/vclock_gettime.c b/arch/x86/vdso/vclock_gettime.c
index 40d2473836c9..c3c3cf14680f 100644
--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -36,11 +36,15 @@ static notrace cycle_t vread_hpet(void)
 }
 #endif
=20
+#ifdef CONFIG_PARAVIRT_CLOCK
+extern u8 pvclock_page
+	__attribute__((visibility("hidden")));
+#endif
+
 #ifndef BUILD_VDSO32
=20
 #include <linux/kernel.h>
 #include <asm/vsyscall.h>
-#include <asm/fixmap.h>
 #include <asm/pvclock.h>
=20
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
@@ -62,67 +66,66 @@ notrace static long vdso_fallback_gtod(struct timeval *=
tv, struct timezone *tz)
=20
 #ifdef CONFIG_PARAVIRT_CLOCK
=20
-static notrace const struct pvclock_vsyscall_time_info *get_pvti(int cpu)
+static notrace const struct pvclock_vsyscall_time_info *get_pvti0(void)
 {
-	const struct pvclock_vsyscall_time_info *pvti_base;
-	int idx =3D cpu / (PAGE_SIZE/PVTI_SIZE);
-	int offset =3D cpu % (PAGE_SIZE/PVTI_SIZE);
-
-	BUG_ON(PVCLOCK_FIXMAP_BEGIN + idx > PVCLOCK_FIXMAP_END);
-
-	pvti_base =3D (struct pvclock_vsyscall_time_info *)
-		    __fix_to_virt(PVCLOCK_FIXMAP_BEGIN+idx);
-
-	return &pvti_base[offset];
+	return (const struct pvclock_vsyscall_time_info *)&pvclock_page;
 }
=20
 static notrace cycle_t vread_pvclock(int *mode)
 {
-	const struct pvclock_vsyscall_time_info *pvti;
+	const struct pvclock_vcpu_time_info *pvti =3D &get_pvti0()->pvti;
 	cycle_t ret;
-	u64 last;
-	u32 version;
-	u32 migrate_count;
-	u8 flags;
-	unsigned cpu, cpu1;
-
+	u64 tsc, pvti_tsc;
+	u64 last, delta, pvti_system_time;
+	u32 version, pvti_tsc_to_system_mul, pvti_tsc_shift;
=20
 	/*
-	 * When looping to get a consistent (time-info, tsc) pair, we
-	 * also need to deal with the possibility we can switch vcpus,
-	 * so make sure we always re-fetch time-info for the current vcpu.
+	 * Note: The kernel and hypervisor must guarantee that cpu ID
+	 * number maps 1:1 to per-CPU pvclock time info.
+	 *
+	 * Because the hypervisor is entirely unaware of guest userspace
+	 * preemption, it cannot guarantee that per-CPU pvclock time
+	 * info is updated if the underlying CPU changes or that that
+	 * version is increased whenever underlying CPU changes.
+	 *
+	 * On KVM, we are guaranteed that pvti updates for any vCPU are
+	 * atomic as seen by *all* vCPUs.  This is an even stronger
+	 * guarantee than we get with a normal seqlock.
+	 *
+	 * On Xen, we don't appear to have that guarantee, but Xen still
+	 * supplies a valid seqlock using the version field.
+
+	 * We only do pvclock vdso timing at all if
+	 * PVCLOCK_TSC_STABLE_BIT is set, and we interpret that bit to
+	 * mean that all vCPUs have matching pvti and that the TSC is
+	 * synced, so we can just look at vCPU 0's pvti.
 	 */
+
+	if (unlikely(!(pvti->flags & PVCLOCK_TSC_STABLE_BIT))) {
+		*mode =3D VCLOCK_NONE;
+		return 0;
+	}
+
 	do {
-		cpu =3D __getcpu() & VGETCPU_CPU_MASK;
-		/* TODO: We can put vcpu id into higher bits of pvti.version.
-		 * This will save a couple of cycles by getting rid of
-		 * __getcpu() calls (Gleb).
-		 */
-
-		/* Make sure migrate_count will change if we leave the VCPU. */
-		do {
-			pvti =3D get_pvti(cpu);
-			migrate_count =3D pvti->migrate_count;
-
-			cpu1 =3D cpu;
-			cpu =3D __getcpu() & VGETCPU_CPU_MASK;
-		} while (unlikely(cpu !=3D cpu1));
-
-		version =3D __pvclock_read_cycles(&pvti->pvti, &ret, &flags);
-
-		/*
-		 * Test we're still on the cpu as well as the version.
-		 * - We must read TSC of pvti's VCPU.
-		 * - KVM doesn't follow the versioning protocol, so data could
-		 *   change before version if we left the VCPU.
-		 */
+		version =3D pvti->version;
+
+		/* This is also a read barrier, so we'll read version first. */
+		rdtsc_barrier();
+		tsc =3D __native_read_tsc();
+
+		pvti_tsc_to_system_mul =3D pvti->tsc_to_system_mul;
+		pvti_tsc_shift =3D pvti->tsc_shift;
+		pvti_system_time =3D pvti->system_time;
+		pvti_tsc =3D pvti->tsc_timestamp;
+
+		/* Make sure that the version double-check is last. */
 		smp_rmb();
-	} while (unlikely((pvti->pvti.version & 1) ||
-			  pvti->pvti.version !=3D version ||
-			  pvti->migrate_count !=3D migrate_count));
+	} while (unlikely((version & 1) || version !=3D pvti->version));
=20
-	if (unlikely(!(flags & PVCLOCK_TSC_STABLE_BIT)))
-		*mode =3D VCLOCK_NONE;
+	delta =3D tsc - pvti_tsc;
+	ret =3D pvti_system_time +
+		pvclock_scale_delta(delta, pvti_tsc_to_system_mul,
+				    pvti_tsc_shift);
=20
 	/* refer to tsc.c read_tsc() comment for rationale */
 	last =3D gtod->cycle_last;
diff --git a/arch/x86/vdso/vdso-layout.lds.S b/arch/x86/vdso/vdso-layout.ld=
s.S
index 9197544eea9a..4158acc17df0 100644
--- a/arch/x86/vdso/vdso-layout.lds.S
+++ b/arch/x86/vdso/vdso-layout.lds.S
@@ -18,6 +18,26 @@
=20
 SECTIONS
 {
+	/*
+	 * User/kernel shared data is before the vDSO.  This may be a little
+	 * uglier than putting it after the vDSO, but it avoids issues with
+	 * non-allocatable things that dangle past the end of the PT_LOAD
+	 * segment.
+	 */
+
+	vvar_start =3D . - 3 * PAGE_SIZE;
+	vvar_page =3D vvar_start;
+
+	/* Place all vvars at the offsets in asm/vvar.h. */
+#define EMIT_VVAR(name, offset) vvar_ ## name =3D vvar_page + offset;
+#define __VVAR_KERNEL_LDS
+#include <asm/vvar.h>
+#undef __VVAR_KERNEL_LDS
+#undef EMIT_VVAR
+
+	hpet_page =3D vvar_start + PAGE_SIZE;
+	pvclock_page =3D vvar_start + 2 * PAGE_SIZE;
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
@@ -74,31 +94,6 @@ SECTIONS
 	.altinstructions	: { *(.altinstructions) }	:text
 	.altinstr_replacement	: { *(.altinstr_replacement) }	:text
=20
-	/*
-	 * The remainder of the vDSO consists of special pages that are
-	 * shared between the kernel and userspace.  It needs to be at the
-	 * end so that it doesn't overlap the mapping of the actual
-	 * vDSO image.
-	 */
-
-	. =3D ALIGN(PAGE_SIZE);
-	vvar_page =3D .;
-
-	/* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) vvar_ ## name =3D vvar_page + offset;
-#define __VVAR_KERNEL_LDS
-#include <asm/vvar.h>
-#undef __VVAR_KERNEL_LDS
-#undef EMIT_VVAR
-
-	. =3D vvar_page + PAGE_SIZE;
-
-	hpet_page =3D .;
-	. =3D . + PAGE_SIZE;
-
-	. =3D ALIGN(PAGE_SIZE);
-	end_mapping =3D .;
-
 	/DISCARD/ : {
 		*(.discard)
 		*(.discard.*)
diff --git a/arch/x86/vdso/vdso2c.c b/arch/x86/vdso/vdso2c.c
index 238dbe82776e..b68127538571 100644
--- a/arch/x86/vdso/vdso2c.c
+++ b/arch/x86/vdso/vdso2c.c
@@ -20,9 +20,10 @@ const char *outfilename;
=20
 /* Symbols that we need in vdso2c. */
 enum {
+	sym_vvar_start,
 	sym_vvar_page,
 	sym_hpet_page,
-	sym_end_mapping,
+	sym_pvclock_page,
 	sym_VDSO_FAKE_SECTION_TABLE_START,
 	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
@@ -30,6 +31,7 @@ enum {
 const int special_pages[] =3D {
 	sym_vvar_page,
 	sym_hpet_page,
+	sym_pvclock_page,
 };
=20
 struct vdso_sym {
@@ -38,9 +40,10 @@ struct vdso_sym {
 };
=20
 struct vdso_sym required_syms[] =3D {
+	[sym_vvar_start] =3D {"vvar_start", true},
 	[sym_vvar_page] =3D {"vvar_page", true},
 	[sym_hpet_page] =3D {"hpet_page", true},
-	[sym_end_mapping] =3D {"end_mapping", true},
+	[sym_pvclock_page] =3D {"pvclock_page", true},
 	[sym_VDSO_FAKE_SECTION_TABLE_START] =3D {
 		"VDSO_FAKE_SECTION_TABLE_START", false
 	},
@@ -96,9 +99,11 @@ extern void bad_put_le(void);
=20
 #define NSYMS (sizeof(required_syms) / sizeof(required_syms[0]))
=20
-#define BITSFUNC3(name, bits) name##bits
-#define BITSFUNC2(name, bits) BITSFUNC3(name, bits)
-#define BITSFUNC(name) BITSFUNC2(name, ELF_BITS)
+#define BITSFUNC3(name, bits, suffix) name##bits##suffix
+#define BITSFUNC2(name, bits, suffix) BITSFUNC3(name, bits, suffix)
+#define BITSFUNC(name) BITSFUNC2(name, ELF_BITS, )
+
+#define INT_BITS BITSFUNC2(int, ELF_BITS, _t)
=20
 #define ELF_BITS_XFORM2(bits, x) Elf##bits##_##x
 #define ELF_BITS_XFORM(bits, x) ELF_BITS_XFORM2(bits, x)
diff --git a/arch/x86/vdso/vdso2c.h b/arch/x86/vdso/vdso2c.h
index 11b65d4f9414..2da32fbc46da 100644
--- a/arch/x86/vdso/vdso2c.h
+++ b/arch/x86/vdso/vdso2c.h
@@ -132,7 +132,7 @@ static void BITSFUNC(go)(void *addr, size_t len,
 		*alt_sec =3D NULL;
 	ELF(Dyn) *dyn =3D 0, *dyn_end =3D 0;
 	const char *secstrings;
-	uint64_t syms[NSYMS] =3D {};
+	INT_BITS syms[NSYMS] =3D {};
=20
 	struct BITSFUNC(fake_sections) fake_sections =3D {};
=20
@@ -209,6 +209,13 @@ static void BITSFUNC(go)(void *addr, size_t len,
 					fail("duplicate symbol %s\n",
 					     required_syms[k].name);
 				}
+
+				/*
+				 * Careful: we use negative addresses, but
+				 * st_value is unsigned, so we rely
+				 * on syms[k] being a signed type of the
+				 * correct width.
+				 */
 				syms[k] =3D GET_LE(&sym->st_value);
 			}
 		}
@@ -263,15 +270,15 @@ static void BITSFUNC(go)(void *addr, size_t len,
 		if (syms[i] % 4096)
 			fail("%s must be a multiple of 4096\n",
 			     required_syms[i].name);
-		if (syms[i] < data_size)
-			fail("%s must be after the text mapping\n",
+		if (syms[sym_vvar_start] > syms[i] + 4096)
+			fail("%s underruns begin_vvar\n",
 			     required_syms[i].name);
-		if (syms[sym_end_mapping] < syms[i] + 4096)
-			fail("%s overruns end_mapping\n",
+		if (syms[i] + 4096 > 0)
+			fail("%s is on the wrong side of the vdso text\n",
 			     required_syms[i].name);
 	}
-	if (syms[sym_end_mapping] % 4096)
-		fail("end_mapping must be a multiple of 4096\n");
+	if (syms[sym_vvar_start] % 4096)
+		fail("vvar_begin must be a multiple of 4096\n");
=20
 	if (!name) {
 		fwrite(addr, load_size, 1, outfile);
@@ -311,8 +318,8 @@ static void BITSFUNC(go)(void *addr, size_t len,
 	}
 	for (i =3D 0; i < NSYMS; i++) {
 		if (required_syms[i].export && syms[i])
-			fprintf(outfile, "\t.sym_%s =3D 0x%" PRIx64 ",\n",
-				required_syms[i].name, syms[i]);
+			fprintf(outfile, "\t.sym_%s =3D %" PRIi64 ",\n",
+				required_syms[i].name, (int64_t)syms[i]);
 	}
 	fprintf(outfile, "};\n");
 }
diff --git a/arch/x86/vdso/vma.c b/arch/x86/vdso/vma.c
index 3ae68edd8c52..91b2677213cf 100644
--- a/arch/x86/vdso/vma.c
+++ b/arch/x86/vdso/vma.c
@@ -11,6 +11,7 @@
 #include <linux/random.h>
 #include <linux/elf.h>
 #include <asm/vsyscall.h>
+#include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
 #include <asm/vdso.h>
@@ -106,36 +107,39 @@ static int map_vdso(const struct vdso_image *image, b=
ool calculate_addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
-	unsigned long addr;
+	unsigned long addr, text_start;
 	int ret =3D 0;
 	static struct page *no_pages[] =3D {NULL};
 	static struct vm_special_mapping vvar_mapping =3D {
 		.name =3D "[vvar]",
 		.pages =3D no_pages,
 	};
+	struct pvclock_vsyscall_time_info *pvti;
=20
 	if (calculate_addr) {
 		addr =3D vdso_addr(current->mm->start_stack,
-				 image->sym_end_mapping);
+				 image->size - image->sym_vvar_start);
 	} else {
 		addr =3D 0;
 	}
=20
 	down_write(&mm->mmap_sem);
=20
-	addr =3D get_unmapped_area(NULL, addr, image->sym_end_mapping, 0, 0);
+	addr =3D get_unmapped_area(NULL, addr,
+				 image->size - image->sym_vvar_start, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret =3D addr;
 		goto up_fail;
 	}
=20
-	current->mm->context.vdso =3D (void __user *)addr;
+	text_start =3D addr - image->sym_vvar_start;
+	current->mm->context.vdso =3D (void __user *)text_start;
=20
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
 	 */
 	vma =3D _install_special_mapping(mm,
-				       addr,
+				       text_start,
 				       image->size,
 				       VM_READ|VM_EXEC|
 				       VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
@@ -147,8 +151,8 @@ static int map_vdso(const struct vdso_image *image, boo=
l calculate_addr)
 	}
=20
 	vma =3D _install_special_mapping(mm,
-				       addr + image->size,
-				       image->sym_end_mapping - image->size,
+				       addr,
+				       -image->sym_vvar_start,
 				       VM_READ,
 				       &vvar_mapping);
=20
@@ -159,7 +163,7 @@ static int map_vdso(const struct vdso_image *image, boo=
l calculate_addr)
=20
 	if (image->sym_vvar_page)
 		ret =3D remap_pfn_range(vma,
-				      addr + image->sym_vvar_page,
+				      text_start + image->sym_vvar_page,
 				      __pa_symbol(&__vvar_page) >> PAGE_SHIFT,
 				      PAGE_SIZE,
 				      PAGE_READONLY);
@@ -170,7 +174,7 @@ static int map_vdso(const struct vdso_image *image, boo=
l calculate_addr)
 #ifdef CONFIG_HPET_TIMER
 	if (hpet_address && image->sym_hpet_page) {
 		ret =3D io_remap_pfn_range(vma,
-			addr + image->sym_hpet_page,
+			text_start + image->sym_hpet_page,
 			hpet_address >> PAGE_SHIFT,
 			PAGE_SIZE,
 			pgprot_noncached(PAGE_READONLY));
@@ -180,6 +184,18 @@ static int map_vdso(const struct vdso_image *image, bo=
ol calculate_addr)
 	}
 #endif
=20
+	pvti =3D pvclock_pvti_cpu0_va();
+	if (pvti && image->sym_pvclock_page) {
+		ret =3D remap_pfn_range(vma,
+				      text_start + image->sym_pvclock_page,
+				      __pa(pvti) >> PAGE_SHIFT,
+				      PAGE_SIZE,
+				      PAGE_READONLY);
+
+		if (ret)
+			goto up_fail;
+	}
+
 up_fail:
 	if (ret)
 		current->mm->context.vdso =3D NULL;
diff --git a/block/blk-core.c b/block/blk-core.c
index 972e08de8ef8..be6fd704d2a4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -611,6 +611,9 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_ma=
sk, int node_id)
=20
 	kobject_init(&q->kobj, &blk_queue_ktype);
=20
+#ifdef CONFIG_BLK_DEV_IO_TRACE
+	mutex_init(&q->blk_trace_mutex);
+#endif
 	mutex_init(&q->sysfs_lock);
 	spin_lock_init(&q->__queue_lock);
=20
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index ccb6876d9d86..019db73c01fa 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -49,6 +49,7 @@
 #include <linux/aer.h>
=20
 #include <acpi/ghes.h>
+#include <asm/fixmap.h>
 #include <asm/mce.h>
 #include <asm/tlbflush.h>
 #include <asm/nmi.h>
@@ -110,22 +111,10 @@ static DEFINE_RAW_SPINLOCK(ghes_nmi_lock);
  * Because the memory area used to transfer hardware error information
  * from BIOS to Linux can be determined only in NMI, IRQ or timer
  * handler, but general ioremap can not be used in atomic context, so
- * a special version of atomic ioremap is implemented for that.
- */
-
-/*
- * Two virtual pages are used, one for NMI context, the other for
- * IRQ/PROCESS context
- */
-#define GHES_IOREMAP_PAGES		2
-#define GHES_IOREMAP_NMI_PAGE(base)	(base)
-#define GHES_IOREMAP_IRQ_PAGE(base)	((base) + PAGE_SIZE)
-
-/* virtual memory area for atomic ioremap */
-static struct vm_struct *ghes_ioremap_area;
-/*
- * These 2 spinlock is used to prevent atomic ioremap virtual memory
- * area from being mapped simultaneously.
+ * the fixmap is used instead.
+ *
+ * These 2 spinlocks are used to prevent the fixmap entries from being used
+ * simultaneously.
  */
 static DEFINE_RAW_SPINLOCK(ghes_ioremap_lock_nmi);
 static DEFINE_SPINLOCK(ghes_ioremap_lock_irq);
@@ -146,63 +135,28 @@ static struct irq_work ghes_proc_irq_work;
 struct ghes_estatus_cache *ghes_estatus_caches[GHES_ESTATUS_CACHES_SIZE];
 static atomic_t ghes_estatus_cache_alloced;
=20
-static int ghes_ioremap_init(void)
-{
-	ghes_ioremap_area =3D __get_vm_area(PAGE_SIZE * GHES_IOREMAP_PAGES,
-		VM_IOREMAP, VMALLOC_START, VMALLOC_END);
-	if (!ghes_ioremap_area) {
-		pr_err(GHES_PFX "Failed to allocate virtual memory area for atomic iorem=
ap.\n");
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void ghes_ioremap_exit(void)
-{
-	free_vm_area(ghes_ioremap_area);
-}
-
 static void __iomem *ghes_ioremap_pfn_nmi(u64 pfn)
 {
-	unsigned long vaddr;
-
-	vaddr =3D (unsigned long)GHES_IOREMAP_NMI_PAGE(ghes_ioremap_area->addr);
-	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
-			   pfn << PAGE_SHIFT, PAGE_KERNEL);
+	__set_fixmap(FIX_APEI_GHES_NMI, pfn << PAGE_SHIFT, PAGE_KERNEL);
=20
-	return (void __iomem *)vaddr;
+	return (void __iomem *) fix_to_virt(FIX_APEI_GHES_NMI);
 }
=20
 static void __iomem *ghes_ioremap_pfn_irq(u64 pfn)
 {
-	unsigned long vaddr;
-
-	vaddr =3D (unsigned long)GHES_IOREMAP_IRQ_PAGE(ghes_ioremap_area->addr);
-	ioremap_page_range(vaddr, vaddr + PAGE_SIZE,
-			   pfn << PAGE_SHIFT, PAGE_KERNEL);
+	__set_fixmap(FIX_APEI_GHES_IRQ, pfn << PAGE_SHIFT, PAGE_KERNEL);
=20
-	return (void __iomem *)vaddr;
+	return (void __iomem *) fix_to_virt(FIX_APEI_GHES_IRQ);
 }
=20
-static void ghes_iounmap_nmi(void __iomem *vaddr_ptr)
+static void ghes_iounmap_nmi(void)
 {
-	unsigned long vaddr =3D (unsigned long __force)vaddr_ptr;
-	void *base =3D ghes_ioremap_area->addr;
-
-	BUG_ON(vaddr !=3D (unsigned long)GHES_IOREMAP_NMI_PAGE(base));
-	unmap_kernel_range_noflush(vaddr, PAGE_SIZE);
-	__flush_tlb_one(vaddr);
+	clear_fixmap(FIX_APEI_GHES_NMI);
 }
=20
-static void ghes_iounmap_irq(void __iomem *vaddr_ptr)
+static void ghes_iounmap_irq(void)
 {
-	unsigned long vaddr =3D (unsigned long __force)vaddr_ptr;
-	void *base =3D ghes_ioremap_area->addr;
-
-	BUG_ON(vaddr !=3D (unsigned long)GHES_IOREMAP_IRQ_PAGE(base));
-	unmap_kernel_range_noflush(vaddr, PAGE_SIZE);
-	__flush_tlb_one(vaddr);
+	clear_fixmap(FIX_APEI_GHES_IRQ);
 }
=20
 static int ghes_estatus_pool_init(void)
@@ -341,10 +295,10 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 p=
addr, u32 len,
 		paddr +=3D trunk;
 		buffer +=3D trunk;
 		if (in_nmi) {
-			ghes_iounmap_nmi(vaddr);
+			ghes_iounmap_nmi();
 			raw_spin_unlock(&ghes_ioremap_lock_nmi);
 		} else {
-			ghes_iounmap_irq(vaddr);
+			ghes_iounmap_irq();
 			spin_unlock_irqrestore(&ghes_ioremap_lock_irq, flags);
 		}
 	}
@@ -1080,13 +1034,9 @@ static int __init ghes_init(void)
=20
 	init_irq_work(&ghes_proc_irq_work, ghes_proc_in_irq);
=20
-	rc =3D ghes_ioremap_init();
-	if (rc)
-		goto err;
-
 	rc =3D ghes_estatus_pool_init();
 	if (rc)
-		goto err_ioremap_exit;
+		goto err;
=20
 	rc =3D ghes_estatus_pool_expand(GHES_ESTATUS_CACHE_AVG_SIZE *
 				      GHES_ESTATUS_CACHE_ALLOCED_MAX);
@@ -1110,8 +1060,6 @@ static int __init ghes_init(void)
 	return 0;
 err_pool_exit:
 	ghes_estatus_pool_exit();
-err_ioremap_exit:
-	ghes_ioremap_exit();
 err:
 	return rc;
 }
@@ -1120,7 +1068,6 @@ static void __exit ghes_exit(void)
 {
 	platform_driver_unregister(&ghes_platform_driver);
 	ghes_estatus_pool_exit();
-	ghes_ioremap_exit();
 }
=20
 module_init(ghes_init);
diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_m=
sghandler.c
index e6db9381b2c7..edeadbf962d7 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4007,7 +4007,8 @@ smi_from_recv_msg(ipmi_smi_t intf, struct ipmi_recv_m=
sg *recv_msg,
 }
=20
 static void check_msg_timeout(ipmi_smi_t intf, struct seq_table *ent,
-			      struct list_head *timeouts, long timeout_period,
+			      struct list_head *timeouts,
+			      unsigned long timeout_period,
 			      int slot, unsigned long *flags,
 			      unsigned int *waiting_msgs)
 {
@@ -4020,8 +4021,8 @@ static void check_msg_timeout(ipmi_smi_t intf, struct=
 seq_table *ent,
 	if (!ent->inuse)
 		return;
=20
-	ent->timeout -=3D timeout_period;
-	if (ent->timeout > 0) {
+	if (timeout_period < ent->timeout) {
+		ent->timeout -=3D timeout_period;
 		(*waiting_msgs)++;
 		return;
 	}
@@ -4088,7 +4089,8 @@ static void check_msg_timeout(ipmi_smi_t intf, struct=
 seq_table *ent,
 	}
 }
=20
-static unsigned int ipmi_timeout_handler(ipmi_smi_t intf, long timeout_per=
iod)
+static unsigned int ipmi_timeout_handler(ipmi_smi_t intf,
+					 unsigned long timeout_period)
 {
 	struct list_head     timeouts;
 	struct ipmi_recv_msg *msg, *msg2;
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index d9b774e02a1f..2a86a75a5e28 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -139,6 +139,12 @@ static ssize_t tpm_write(struct file *file, const char=
 __user *buf,
 		return -EFAULT;
 	}
=20
+	if (in_size < 6 ||
+	    in_size < be32_to_cpu(*((__be32 *) (priv->data_buffer + 2)))) {
+		mutex_unlock(&priv->buffer_mutex);
+		return -EINVAL;
+	}
+
 	/* atomic tpm command send and result receive */
 	out_size =3D tpm_transmit(priv->chip, priv->data_buffer,
 				sizeof(priv->data_buffer));
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra3=
0.c
index 8b10c38b6e3c..7609f5a4cebf 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1060,7 +1060,7 @@ static void __init tegra30_super_clk_init(void)
 	 * U71 divider of cclk_lp.
 	 */
 	clk =3D tegra_clk_register_divider("pll_p_out3_cclklp", "pll_p_out3",
-				clk_base + SUPER_CCLKG_DIVIDER, 0,
+				clk_base + SUPER_CCLKLP_DIVIDER, 0,
 				TEGRA_DIVIDER_INT, 16, 8, 1, NULL);
 	clk_register_clkdev(clk, "pll_p_out3_cclklp", NULL);
=20
diff --git a/drivers/clk/ti/clk-dra7-atl.c b/drivers/clk/ti/clk-dra7-atl.c
index d1db76887b8b..e4405d19e669 100644
--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -262,7 +262,7 @@ static int of_dra7_atl_clk_probe(struct platform_device=
 *pdev)
=20
 		/* Get configuration for the ATL instances */
 		snprintf(prop, sizeof(prop), "atl%u", i);
-		cfg_node =3D of_find_node_by_name(node, prop);
+		cfg_node =3D of_get_child_by_name(node, prop);
 		if (cfg_node) {
 			ret =3D of_property_read_u32(cfg_node, "bws",
 						   &cdesc->bws);
@@ -275,6 +275,7 @@ static int of_dra7_atl_clk_probe(struct platform_device=
 *pdev)
 				atl_write(cinfo, DRA7_ATL_AWSMUX_REG(i),
 					  cdesc->aws);
 			}
+			of_node_put(cfg_node);
 		}
=20
 		cdesc->probed =3D true;
diff --git a/drivers/crypto/caam/desc.h b/drivers/crypto/caam/desc.h
index 7e4500f18df6..9c3f9e183b67 100644
--- a/drivers/crypto/caam/desc.h
+++ b/drivers/crypto/caam/desc.h
@@ -1434,7 +1434,7 @@ struct sec4_sg_entry {
 #define MATH_SRC1_REG2		(0x02 << MATH_SRC1_SHIFT)
 #define MATH_SRC1_REG3		(0x03 << MATH_SRC1_SHIFT)
 #define MATH_SRC1_IMM		(0x04 << MATH_SRC1_SHIFT)
-#define MATH_SRC1_DPOVRD	(0x07 << MATH_SRC0_SHIFT)
+#define MATH_SRC1_DPOVRD	(0x07 << MATH_SRC1_SHIFT)
 #define MATH_SRC1_INFIFO	(0x0a << MATH_SRC1_SHIFT)
 #define MATH_SRC1_OUTFIFO	(0x0b << MATH_SRC1_SHIFT)
 #define MATH_SRC1_ONE		(0x0c << MATH_SRC1_SHIFT)
diff --git a/drivers/gpu/drm/gma500/mdfld_intel_display.c b/drivers/gpu/drm=
/gma500/mdfld_intel_display.c
index 8cc8a5abbc7b..95a05c5976d7 100644
--- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
+++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
@@ -99,7 +99,7 @@ void mdfldWaitForPipeEnable(struct drm_device *dev, int p=
ipe)
 	/* Wait for for the pipe enable to take effect. */
 	for (count =3D 0; count < COUNT_MAX; count++) {
 		temp =3D REG_READ(map->conf);
-		if ((temp & PIPEACONF_PIPE_STATE) =3D=3D 1)
+		if (temp & PIPEACONF_PIPE_STATE)
 			break;
 	}
 }
diff --git a/drivers/gpu/drm/i915/intel_bios.c b/drivers/gpu/drm/i915/intel=
_bios.c
index e03526a10340..367a1ab8e7ca 100644
--- a/drivers/gpu/drm/i915/intel_bios.c
+++ b/drivers/gpu/drm/i915/intel_bios.c
@@ -1007,7 +1007,7 @@ static void parse_ddi_ports(struct drm_i915_private *=
dev_priv,
 	struct drm_device *dev =3D dev_priv->dev;
 	enum port port;
=20
-	if (!HAS_DDI(dev))
+	if (!HAS_DDI(dev) && !IS_CHERRYVIEW(dev))
 		return;
=20
 	if (!dev_priv->vbt.child_dev_num)
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/in=
tel_display.c
index 3a3afe1b15bd..7bcca10ae746 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -8662,13 +8662,10 @@ struct drm_display_mode *intel_crtc_mode_get(struct=
 drm_device *dev,
 {
 	struct drm_i915_private *dev_priv =3D dev->dev_private;
 	struct intel_crtc *intel_crtc =3D to_intel_crtc(crtc);
-	enum transcoder cpu_transcoder =3D intel_crtc->config.cpu_transcoder;
+	enum transcoder cpu_transcoder;
 	struct drm_display_mode *mode;
 	struct intel_crtc_config pipe_config;
-	int htot =3D I915_READ(HTOTAL(cpu_transcoder));
-	int hsync =3D I915_READ(HSYNC(cpu_transcoder));
-	int vtot =3D I915_READ(VTOTAL(cpu_transcoder));
-	int vsync =3D I915_READ(VSYNC(cpu_transcoder));
+	u32 htot, hsync, vtot, vsync;
 	enum pipe pipe =3D intel_crtc->pipe;
=20
 	mode =3D kzalloc(sizeof(*mode), GFP_KERNEL);
@@ -8690,6 +8687,13 @@ struct drm_display_mode *intel_crtc_mode_get(struct =
drm_device *dev,
 	i9xx_crtc_clock_get(intel_crtc, &pipe_config);
=20
 	mode->clock =3D pipe_config.port_clock / pipe_config.pixel_multiplier;
+
+	cpu_transcoder =3D pipe_config.cpu_transcoder;
+	htot =3D I915_READ(HTOTAL(cpu_transcoder));
+	hsync =3D I915_READ(HSYNC(cpu_transcoder));
+	vtot =3D I915_READ(VTOTAL(cpu_transcoder));
+	vsync =3D I915_READ(VSYNC(cpu_transcoder));
+
 	mode->hdisplay =3D (htot & 0xffff) + 1;
 	mode->htotal =3D ((htot & 0xffff0000) >> 16) + 1;
 	mode->hsync_start =3D (hsync & 0xffff) + 1;
diff --git a/drivers/gpu/drm/i915/intel_dp.c b/drivers/gpu/drm/i915/intel_d=
p.c
index b5660eb078f6..16b14c02236b 100644
--- a/drivers/gpu/drm/i915/intel_dp.c
+++ b/drivers/gpu/drm/i915/intel_dp.c
@@ -1365,8 +1365,8 @@ void intel_edp_panel_off(struct intel_dp *intel_dp)
 	I915_WRITE(pp_ctrl_reg, pp);
 	POSTING_READ(pp_ctrl_reg);
=20
-	intel_dp->last_power_cycle =3D jiffies;
 	wait_panel_off(intel_dp);
+	intel_dp->last_power_cycle =3D jiffies;
=20
 	/* We got a reference when we enabled the VDD. */
 	power_domain =3D intel_display_port_power_domain(intel_encoder);
diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/=
atombios_dp.c
index f9db2aabc2ac..7a475cbd1aa9 100644
--- a/drivers/gpu/drm/radeon/atombios_dp.c
+++ b/drivers/gpu/drm/radeon/atombios_dp.c
@@ -45,34 +45,32 @@ static char *pre_emph_names[] =3D {
=20
 /***** radeon AUX functions *****/
=20
-/* Atom needs data in little endian format
- * so swap as appropriate when copying data to
- * or from atom. Note that atom operates on
- * dw units.
+/* Atom needs data in little endian format so swap as appropriate when cop=
ying
+ * data to or from atom. Note that atom operates on dw units.
+ *
+ * Use to_le=3Dtrue when sending data to atom and provide at least
+ * ALIGN(num_bytes,4) bytes in the dst buffer.
+ *
+ * Use to_le=3Dfalse when receiving data from atom and provide ALIGN(num_b=
ytes,4)
+ * byes in the src buffer.
  */
 void radeon_atom_copy_swap(u8 *dst, u8 *src, u8 num_bytes, bool to_le)
 {
 #ifdef __BIG_ENDIAN
-	u8 src_tmp[20], dst_tmp[20]; /* used for byteswapping */
-	u32 *dst32, *src32;
+	u32 src_tmp[5], dst_tmp[5];
 	int i;
+	u8 align_num_bytes =3D ALIGN(num_bytes, 4);
=20
-	memcpy(src_tmp, src, num_bytes);
-	src32 =3D (u32 *)src_tmp;
-	dst32 =3D (u32 *)dst_tmp;
 	if (to_le) {
-		for (i =3D 0; i < ((num_bytes + 3) / 4); i++)
-			dst32[i] =3D cpu_to_le32(src32[i]);
-		memcpy(dst, dst_tmp, num_bytes);
+		memcpy(src_tmp, src, num_bytes);
+		for (i =3D 0; i < align_num_bytes / 4; i++)
+			dst_tmp[i] =3D cpu_to_le32(src_tmp[i]);
+		memcpy(dst, dst_tmp, align_num_bytes);
 	} else {
-		u8 dws =3D num_bytes & ~3;
-		for (i =3D 0; i < ((num_bytes + 3) / 4); i++)
-			dst32[i] =3D le32_to_cpu(src32[i]);
-		memcpy(dst, dst_tmp, dws);
-		if (num_bytes % 4) {
-			for (i =3D 0; i < (num_bytes % 4); i++)
-				dst[dws+i] =3D dst_tmp[dws+i];
-		}
+		memcpy(src_tmp, src, align_num_bytes);
+		for (i =3D 0; i < align_num_bytes / 4; i++)
+			dst_tmp[i] =3D le32_to_cpu(src_tmp[i]);
+		memcpy(dst, dst_tmp, num_bytes);
 	}
 #else
 	memcpy(dst, src, num_bytes);
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo=
_util.c
index 1df856f78568..2248cd68657f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -463,6 +463,7 @@ static int ttm_buffer_object_transfer(struct ttm_buffer=
_object *bo,
 	INIT_LIST_HEAD(&fbo->lru);
 	INIT_LIST_HEAD(&fbo->swap);
 	INIT_LIST_HEAD(&fbo->io_reserve_lru);
+	mutex_init(&fbo->wu_mutex);
 	drm_vma_node_reset(&fbo->vma_node);
 	atomic_set(&fbo->cpu_writers, 0);
=20
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/q=
p.c
index 3e1ea0323983..5a2aab8c75ea 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1468,7 +1468,7 @@ static int __mlx4_ib_modify_qp(struct ib_qp *ibqp,
 			context->mtu_msgmax =3D (IB_MTU_4096 << 5) |
 					      ilog2(dev->dev->caps.max_gso_sz);
 		else
-			context->mtu_msgmax =3D (IB_MTU_4096 << 5) | 12;
+			context->mtu_msgmax =3D (IB_MTU_4096 << 5) | 13;
 	} else if (attr_mask & IB_QP_PATH_MTU) {
 		if (attr->path_mtu < IB_MTU_256 || attr->path_mtu > IB_MTU_4096) {
 			pr_err("path MTU (%u) is invalid\n",
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5=
/main.c
index b7e8515dfaf1..1936cbfc3c5e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1164,6 +1164,8 @@ static int create_umr_res(struct mlx5_ib_dev *dev)
 	qp->real_qp    =3D qp;
 	qp->uobject    =3D NULL;
 	qp->qp_type    =3D MLX5_IB_QPT_REG_UMR;
+	qp->send_cq    =3D init_attr->send_cq;
+	qp->recv_cq    =3D init_attr->recv_cq;
=20
 	attr->qp_state =3D IB_QPS_INIT;
 	attr->port_num =3D 1;
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/s=
rp/ib_srp.c
index 6311fd448c36..4591cc7b8240 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -600,12 +600,19 @@ static void srp_path_rec_completion(int status,
=20
 static int srp_lookup_path(struct srp_target_port *target)
 {
-	int ret;
+	int ret =3D -ENODEV;
=20
 	target->path.numb_path =3D 1;
=20
 	init_completion(&target->done);
=20
+	/*
+	 * Avoid that the SCSI host can be removed by srp_remove_target()
+	 * before srp_path_rec_completion() is called.
+	 */
+	if (!scsi_host_get(target->scsi_host))
+		goto out;
+
 	target->path_query_id =3D ib_sa_path_rec_get(&srp_sa_client,
 						   target->srp_host->srp_dev->dev,
 						   target->srp_host->port,
@@ -619,18 +626,24 @@ static int srp_lookup_path(struct srp_target_port *ta=
rget)
 						   GFP_KERNEL,
 						   srp_path_rec_completion,
 						   target, &target->path_query);
-	if (target->path_query_id < 0)
-		return target->path_query_id;
+	ret =3D target->path_query_id;
+	if (ret < 0)
+		goto put;
=20
 	ret =3D wait_for_completion_interruptible(&target->done);
 	if (ret < 0)
 		return ret;
=20
-	if (target->status < 0)
+	ret =3D target->status;
+	if (ret < 0)
 		shost_printk(KERN_WARNING, target->scsi_host,
 			     PFX "Path record query failed\n");
=20
-	return target->status;
+put:
+	scsi_host_put(target->scsi_host);
+
+out:
+	return ret;
 }
=20
 static int srp_send_req(struct srp_target_port *target)
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp=
/srpt/ib_srpt.c
index 1f15b4d0fd10..0ee17bb7f7b2 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3521,7 +3521,7 @@ static int srpt_parse_i_port_id(u8 i_port_id[16], con=
st char *name)
 {
 	const char *p;
 	unsigned len, count, leading_zero_bytes;
-	int ret, rc;
+	int ret;
=20
 	p =3D name;
 	if (strnicmp(p, "0x", 2) =3D=3D 0)
@@ -3533,10 +3533,9 @@ static int srpt_parse_i_port_id(u8 i_port_id[16], co=
nst char *name)
 	count =3D min(len / 2, 16U);
 	leading_zero_bytes =3D 16 - count;
 	memset(i_port_id, 0, leading_zero_bytes);
-	rc =3D hex2bin(i_port_id + leading_zero_bytes, p, count);
-	if (rc < 0)
-		pr_debug("hex2bin failed for srpt_parse_i_port_id: %d\n", rc);
-	ret =3D 0;
+	ret =3D hex2bin(i_port_id + leading_zero_bytes, p, count);
+	if (ret < 0)
+		pr_debug("hex2bin failed for srpt_parse_i_port_id: %d\n", ret);
 out:
 	return ret;
 }
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 2b2d02f408bb..a3e79bf5a04b 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -796,7 +796,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int i=
rq,
=20
 	if (pdata->watermark) {
 		ac->int_mask |=3D WATERMARK;
-		if (!FIFO_MODE(pdata->fifo_mode))
+		if (FIFO_MODE(pdata->fifo_mode) =3D=3D FIFO_BYPASS)
 			ac->pdata.fifo_mode |=3D FIFO_STREAM;
 	} else {
 		ac->int_mask |=3D DATA_READY;
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index bccfacabbae7..3793d6695ed3 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -718,13 +718,16 @@ int __init dmar_dev_scope_init(void)
 				dmar_free_pci_notify_info(info);
 			}
 		}
-
-		bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
 	}
=20
 	return dmar_dev_scope_status;
 }
=20
+void dmar_register_bus_notifier(void)
+{
+	bus_register_notifier(&pci_bus_type, &dmar_pci_bus_nb);
+}
+
=20
 int __init dmar_table_init(void)
 {
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 5b331109b4c4..a2a8a45c3217 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4044,6 +4044,16 @@ int __init intel_iommu_init(void)
 		goto out_free_dmar;
 	}
=20
+	up_write(&dmar_global_lock);
+
+	/*
+	 * The bus notifier takes the dmar_global_lock, so lockdep will
+	 * complain later when we register it under the lock.
+	 */
+	dmar_register_bus_notifier();
+
+	down_write(&dmar_global_lock);
+
 	if (no_iommu || dmar_disabled)
 		goto out_free_dmar;
=20
diff --git a/drivers/md/bcache/alloc.c b/drivers/md/bcache/alloc.c
index 443d03fbac47..7bf9fdb62751 100644
--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -406,7 +406,8 @@ long bch_bucket_alloc(struct cache *ca, unsigned reserv=
e, bool wait)
=20
 	finish_wait(&ca->set->bucket_wait, &w);
 out:
-	wake_up_process(ca->alloc_thread);
+	if (ca->alloc_thread)
+		wake_up_process(ca->alloc_thread);
=20
 	trace_bcache_alloc(ca, reserve);
=20
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index cd41f03b91c2..04d2fc7282f9 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -698,8 +698,16 @@ static void cached_dev_read_error(struct closure *cl)
 {
 	struct search *s =3D container_of(cl, struct search, cl);
 	struct bio *bio =3D &s->bio.bio;
+	struct cached_dev *dc =3D container_of(s->d, struct cached_dev, disk);
=20
-	if (s->recoverable) {
+	/*
+	 * If cache device is dirty (dc->has_dirty is non-zero), then
+	 * recovery a failed read request from cached device may get a
+	 * stale data back. So read failure recovery is only permitted
+	 * when cache device is clean.
+	 */
+	if (s->recoverable &&
+	    (dc && !atomic_read(&dc->has_dirty))) {
 		/* Retry from the backing device: */
 		trace_bcache_read_retry(s->orig_bio);
=20
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index c0e44d210326..1c9e542e3161 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -888,7 +888,8 @@ static void __get_memory_limit(struct dm_bufio_client *=
c,
 		buffers =3D c->minimum_buffers;
=20
 	*limit_buffers =3D buffers;
-	*threshold_buffers =3D buffers * DM_BUFIO_WRITEBACK_PERCENT / 100;
+	*threshold_buffers =3D mult_frac(buffers,
+				       DM_BUFIO_WRITEBACK_PERCENT, 100);
 }
=20
 /*
@@ -1778,19 +1779,15 @@ static int __init dm_bufio_init(void)
 	memset(&dm_bufio_caches, 0, sizeof dm_bufio_caches);
 	memset(&dm_bufio_cache_names, 0, sizeof dm_bufio_cache_names);
=20
-	mem =3D (__u64)((totalram_pages - totalhigh_pages) *
-		      DM_BUFIO_MEMORY_PERCENT / 100) << PAGE_SHIFT;
+	mem =3D (__u64)mult_frac(totalram_pages - totalhigh_pages,
+			       DM_BUFIO_MEMORY_PERCENT, 100) << PAGE_SHIFT;
=20
 	if (mem > ULONG_MAX)
 		mem =3D ULONG_MAX;
=20
 #ifdef CONFIG_MMU
-	/*
-	 * Get the size of vmalloc space the same way as VMALLOC_TOTAL
-	 * in fs/proc/internal.h
-	 */
-	if (mem > (VMALLOC_END - VMALLOC_START) * DM_BUFIO_VMALLOC_PERCENT / 100)
-		mem =3D (VMALLOC_END - VMALLOC_START) * DM_BUFIO_VMALLOC_PERCENT / 100;
+	if (mem > mult_frac(VMALLOC_TOTAL, DM_BUFIO_VMALLOC_PERCENT, 100))
+		mem =3D mult_frac(VMALLOC_TOTAL, DM_BUFIO_VMALLOC_PERCENT, 100);
 #endif
=20
 	dm_bufio_default_cache_size =3D mem;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index c932b6b0d54c..f5f1837dfa5b 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1643,12 +1643,12 @@ void dm_table_run_md_queue_async(struct dm_table *t)
 }
 EXPORT_SYMBOL(dm_table_run_md_queue_async);
=20
-static int device_discard_capable(struct dm_target *ti, struct dm_dev *dev,
-				  sector_t start, sector_t len, void *data)
+static int device_not_discard_capable(struct dm_target *ti, struct dm_dev =
*dev,
+				      sector_t start, sector_t len, void *data)
 {
 	struct request_queue *q =3D bdev_get_queue(dev->bdev);
=20
-	return q && blk_queue_discard(q);
+	return q && !blk_queue_discard(q);
 }
=20
 bool dm_table_supports_discards(struct dm_table *t)
@@ -1656,26 +1656,22 @@ bool dm_table_supports_discards(struct dm_table *t)
 	struct dm_target *ti;
 	unsigned i =3D 0;
=20
-	/*
-	 * Unless any target used by the table set discards_supported,
-	 * require at least one underlying device to support discards.
-	 * t->devices includes internal dm devices such as mirror logs
-	 * so we need to use iterate_devices here, which targets
-	 * supporting discard selectively must provide.
-	 */
 	while (i < dm_table_get_num_targets(t)) {
 		ti =3D dm_table_get_target(t, i++);
=20
 		if (!ti->num_discard_bios)
-			continue;
-
-		if (ti->discards_supported)
-			return 1;
+			return false;
=20
-		if (ti->type->iterate_devices &&
-		    ti->type->iterate_devices(ti, device_discard_capable, NULL))
-			return 1;
+		/*
+		 * Either the target provides discard support (as implied by setting
+		 * 'discards_supported') or it relies on _all_ data devices having
+		 * discard support.
+		 */
+		if (!ti->discards_supported &&
+		    (!ti->type->iterate_devices ||
+		     ti->type->iterate_devices(ti, device_not_discard_capable, NULL)))
+			return false;
 	}
=20
-	return 0;
+	return true;
 }
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 98a47dbf48c2..043ad8d8d700 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2912,11 +2912,15 @@ struct mapped_device *dm_get_from_kobject(struct ko=
bject *kobj)
=20
 	md =3D container_of(kobj, struct mapped_device, kobj_holder.kobj);
=20
-	if (test_bit(DMF_FREEING, &md->flags) ||
-	    dm_deleting_md(md))
-		return NULL;
-
+	spin_lock(&_minor_lock);
+	if (test_bit(DMF_FREEING, &md->flags) || dm_deleting_md(md)) {
+		md =3D NULL;
+		goto out;
+	}
 	dm_get(md);
+out:
+	spin_unlock(&_minor_lock);
+
 	return md;
 }
=20
diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platfo=
rm/omap/omap_vout.c
index 9a726eacb29b..af9bb7425b34 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -1017,11 +1017,12 @@ static int omap_vout_open(struct file *file)
 	struct omap_vout_device *vout =3D NULL;
=20
 	vout =3D video_drvdata(file);
-	v4l2_dbg(1, debug, &vout->vid_dev->v4l2_dev, "Entering %s\n", __func__);
=20
 	if (vout =3D=3D NULL)
 		return -ENODEV;
=20
+	v4l2_dbg(1, debug, &vout->vid_dev->v4l2_dev, "Entering %s\n", __func__);
+
 	/* for now, we only support single open */
 	if (vout->opened)
 		return -EBUSY;
diff --git a/drivers/media/rc/ir-lirc-codec.c b/drivers/media/rc/ir-lirc-co=
dec.c
index 33d6c05352a2..a9c1c2eac2b1 100644
--- a/drivers/media/rc/ir-lirc-codec.c
+++ b/drivers/media/rc/ir-lirc-codec.c
@@ -289,11 +289,14 @@ static long ir_lirc_ioctl(struct file *filep, unsigne=
d int cmd,
 		if (!dev->max_timeout)
 			return -ENOSYS;
=20
+		/* Check for multiply overflow */
+		if (val > U32_MAX / 1000)
+			return -EINVAL;
+
 		tmp =3D val * 1000;
=20
-		if (tmp < dev->min_timeout ||
-		    tmp > dev->max_timeout)
-				return -EINVAL;
+		if (tmp < dev->min_timeout || tmp > dev->max_timeout)
+			return -EINVAL;
=20
 		dev->timeout =3D tmp;
 		break;
diff --git a/drivers/media/usb/cx231xx/cx231xx-cards.c b/drivers/media/usb/=
cx231xx/cx231xx-cards.c
index 5cc7f9220d51..84b129e109ca 100644
--- a/drivers/media/usb/cx231xx/cx231xx-cards.c
+++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
@@ -1185,8 +1185,7 @@ static int cx231xx_usb_probe(struct usb_interface *in=
terface,
 	dev->vbi_or_sliced_cc_mode =3D 0;
=20
 	/* get maximum no.of IAD interfaces */
-	assoc_desc =3D udev->actconfig->intf_assoc[0];
-	dev->max_iad_interface_count =3D assoc_desc->bInterfaceCount;
+	dev->max_iad_interface_count =3D udev->config->desc.bNumInterfaces;
=20
 	/* init CIR module TBD */
=20
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 529f42a8d7f8..857e6cc4a91e 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2466,15 +2466,18 @@ static int panic_nand_write(struct mtd_info *mtd, l=
off_t to, size_t len,
 			    size_t *retlen, const uint8_t *buf)
 {
 	struct nand_chip *chip =3D mtd->priv;
+	int chipnr =3D (int)(to >> chip->chip_shift);
 	struct mtd_oob_ops ops;
 	int ret;
=20
-	/* Wait for the device to get ready */
-	panic_nand_wait(mtd, chip, 400);
-
 	/* Grab the device */
 	panic_nand_get_device(chip, mtd, FL_WRITING);
=20
+	chip->select_chip(mtd, chipnr);
+
+	/* Wait for the device to get ready */
+	panic_nand_wait(mtd, chip, 400);
+
 	ops.len =3D len;
 	ops.datbuf =3D (uint8_t *)buf;
 	ops.oobbuf =3D NULL;
diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 575a015c8394..6ffb1eab4344 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -1163,130 +1163,174 @@ static u8  bch8_polynomial[] =3D {0xef, 0x51, 0x2=
e, 0x09, 0xed, 0x93, 0x9a, 0xc2,
 				0x97, 0x79, 0xe5, 0x24, 0xb5};
=20
 /**
- * omap_calculate_ecc_bch - Generate bytes of ECC bytes
+ * _omap_calculate_ecc_bch - Generate ECC bytes for one sector
  * @mtd:	MTD device structure
  * @dat:	The pointer to data on which ecc is computed
  * @ecc_code:	The ecc_code buffer
+ * @i:		The sector number (for a multi sector page)
  *
- * Support calculating of BCH4/8 ecc vectors for the page
+ * Support calculating of BCH4/8/16 ECC vectors for one sector
+ * within a page. Sector number is in @i.
  */
-static int __maybe_unused omap_calculate_ecc_bch(struct mtd_info *mtd,
-					const u_char *dat, u_char *ecc_calc)
+static int _omap_calculate_ecc_bch(struct mtd_info *mtd,
+				   const u_char *dat, u_char *ecc_calc, int i)
 {
 	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_info,
 						   mtd);
 	int eccbytes	=3D info->nand.ecc.bytes;
 	struct gpmc_nand_regs	*gpmc_regs =3D &info->reg;
 	u8 *ecc_code;
-	unsigned long nsectors, bch_val1, bch_val2, bch_val3, bch_val4;
+	unsigned long bch_val1, bch_val2, bch_val3, bch_val4;
 	u32 val;
-	int i, j;
+	int j;
+
+	ecc_code =3D ecc_calc;
+	switch (info->ecc_opt) {
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+	case OMAP_ECC_BCH8_CODE_HW:
+		bch_val1 =3D readl(gpmc_regs->gpmc_bch_result0[i]);
+		bch_val2 =3D readl(gpmc_regs->gpmc_bch_result1[i]);
+		bch_val3 =3D readl(gpmc_regs->gpmc_bch_result2[i]);
+		bch_val4 =3D readl(gpmc_regs->gpmc_bch_result3[i]);
+		*ecc_code++ =3D (bch_val4 & 0xFF);
+		*ecc_code++ =3D ((bch_val3 >> 24) & 0xFF);
+		*ecc_code++ =3D ((bch_val3 >> 16) & 0xFF);
+		*ecc_code++ =3D ((bch_val3 >> 8) & 0xFF);
+		*ecc_code++ =3D (bch_val3 & 0xFF);
+		*ecc_code++ =3D ((bch_val2 >> 24) & 0xFF);
+		*ecc_code++ =3D ((bch_val2 >> 16) & 0xFF);
+		*ecc_code++ =3D ((bch_val2 >> 8) & 0xFF);
+		*ecc_code++ =3D (bch_val2 & 0xFF);
+		*ecc_code++ =3D ((bch_val1 >> 24) & 0xFF);
+		*ecc_code++ =3D ((bch_val1 >> 16) & 0xFF);
+		*ecc_code++ =3D ((bch_val1 >> 8) & 0xFF);
+		*ecc_code++ =3D (bch_val1 & 0xFF);
+		break;
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+	case OMAP_ECC_BCH4_CODE_HW:
+		bch_val1 =3D readl(gpmc_regs->gpmc_bch_result0[i]);
+		bch_val2 =3D readl(gpmc_regs->gpmc_bch_result1[i]);
+		*ecc_code++ =3D ((bch_val2 >> 12) & 0xFF);
+		*ecc_code++ =3D ((bch_val2 >> 4) & 0xFF);
+		*ecc_code++ =3D ((bch_val2 & 0xF) << 4) |
+			((bch_val1 >> 28) & 0xF);
+		*ecc_code++ =3D ((bch_val1 >> 20) & 0xFF);
+		*ecc_code++ =3D ((bch_val1 >> 12) & 0xFF);
+		*ecc_code++ =3D ((bch_val1 >> 4) & 0xFF);
+		*ecc_code++ =3D ((bch_val1 & 0xF) << 4);
+		break;
+	case OMAP_ECC_BCH16_CODE_HW:
+		val =3D readl(gpmc_regs->gpmc_bch_result6[i]);
+		ecc_code[0]  =3D ((val >>  8) & 0xFF);
+		ecc_code[1]  =3D ((val >>  0) & 0xFF);
+		val =3D readl(gpmc_regs->gpmc_bch_result5[i]);
+		ecc_code[2]  =3D ((val >> 24) & 0xFF);
+		ecc_code[3]  =3D ((val >> 16) & 0xFF);
+		ecc_code[4]  =3D ((val >>  8) & 0xFF);
+		ecc_code[5]  =3D ((val >>  0) & 0xFF);
+		val =3D readl(gpmc_regs->gpmc_bch_result4[i]);
+		ecc_code[6]  =3D ((val >> 24) & 0xFF);
+		ecc_code[7]  =3D ((val >> 16) & 0xFF);
+		ecc_code[8]  =3D ((val >>  8) & 0xFF);
+		ecc_code[9]  =3D ((val >>  0) & 0xFF);
+		val =3D readl(gpmc_regs->gpmc_bch_result3[i]);
+		ecc_code[10] =3D ((val >> 24) & 0xFF);
+		ecc_code[11] =3D ((val >> 16) & 0xFF);
+		ecc_code[12] =3D ((val >>  8) & 0xFF);
+		ecc_code[13] =3D ((val >>  0) & 0xFF);
+		val =3D readl(gpmc_regs->gpmc_bch_result2[i]);
+		ecc_code[14] =3D ((val >> 24) & 0xFF);
+		ecc_code[15] =3D ((val >> 16) & 0xFF);
+		ecc_code[16] =3D ((val >>  8) & 0xFF);
+		ecc_code[17] =3D ((val >>  0) & 0xFF);
+		val =3D readl(gpmc_regs->gpmc_bch_result1[i]);
+		ecc_code[18] =3D ((val >> 24) & 0xFF);
+		ecc_code[19] =3D ((val >> 16) & 0xFF);
+		ecc_code[20] =3D ((val >>  8) & 0xFF);
+		ecc_code[21] =3D ((val >>  0) & 0xFF);
+		val =3D readl(gpmc_regs->gpmc_bch_result0[i]);
+		ecc_code[22] =3D ((val >> 24) & 0xFF);
+		ecc_code[23] =3D ((val >> 16) & 0xFF);
+		ecc_code[24] =3D ((val >>  8) & 0xFF);
+		ecc_code[25] =3D ((val >>  0) & 0xFF);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* ECC scheme specific syndrome customizations */
+	switch (info->ecc_opt) {
+	case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
+		/* Add constant polynomial to remainder, so that
+		 * ECC of blank pages results in 0x0 on reading back
+		 */
+		for (j =3D 0; j < eccbytes; j++)
+			ecc_calc[j] ^=3D bch4_polynomial[j];
+		break;
+	case OMAP_ECC_BCH4_CODE_HW:
+		/* Set  8th ECC byte as 0x0 for ROM compatibility */
+		ecc_calc[eccbytes - 1] =3D 0x0;
+		break;
+	case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
+		/* Add constant polynomial to remainder, so that
+		 * ECC of blank pages results in 0x0 on reading back
+		 */
+		for (j =3D 0; j < eccbytes; j++)
+			ecc_calc[j] ^=3D bch8_polynomial[j];
+		break;
+	case OMAP_ECC_BCH8_CODE_HW:
+		/* Set 14th ECC byte as 0x0 for ROM compatibility */
+		ecc_calc[eccbytes - 1] =3D 0x0;
+		break;
+	case OMAP_ECC_BCH16_CODE_HW:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * omap_calculate_ecc_bch_sw - ECC generator for sector for SW based corre=
ction
+ * @mtd:	MTD device structure
+ * @dat:	The pointer to data on which ecc is computed
+ * @ecc_code:	The ecc_code buffer
+ *
+ * Support calculating of BCH4/8/16 ECC vectors for one sector. This is us=
ed
+ * when SW based correction is required as ECC is required for one sector
+ * at a time.
+ */
+static int omap_calculate_ecc_bch_sw(struct mtd_info *mtd,
+				     const u_char *dat, u_char *ecc_calc)
+{
+	return _omap_calculate_ecc_bch(mtd, dat, ecc_calc, 0);
+}
+
+/**
+ * omap_calculate_ecc_bch_multi - Generate ECC for multiple sectors
+ * @mtd:	MTD device structure
+ * @dat:	The pointer to data on which ecc is computed
+ * @ecc_code:	The ecc_code buffer
+ *
+ * Support calculating of BCH4/8/16 ecc vectors for the entire page in one=
 go.
+ */
+static int omap_calculate_ecc_bch_multi(struct mtd_info *mtd,
+					const u_char *dat, u_char *ecc_calc)
+{
+	struct omap_nand_info *info =3D container_of(mtd, struct omap_nand_info,
+						   mtd);
+	int eccbytes =3D info->nand.ecc.bytes;
+	unsigned long nsectors;
+	int i, ret;
=20
 	nsectors =3D ((readl(info->reg.gpmc_ecc_config) >> 4) & 0x7) + 1;
 	for (i =3D 0; i < nsectors; i++) {
-		ecc_code =3D ecc_calc;
-		switch (info->ecc_opt) {
-		case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
-		case OMAP_ECC_BCH8_CODE_HW:
-			bch_val1 =3D readl(gpmc_regs->gpmc_bch_result0[i]);
-			bch_val2 =3D readl(gpmc_regs->gpmc_bch_result1[i]);
-			bch_val3 =3D readl(gpmc_regs->gpmc_bch_result2[i]);
-			bch_val4 =3D readl(gpmc_regs->gpmc_bch_result3[i]);
-			*ecc_code++ =3D (bch_val4 & 0xFF);
-			*ecc_code++ =3D ((bch_val3 >> 24) & 0xFF);
-			*ecc_code++ =3D ((bch_val3 >> 16) & 0xFF);
-			*ecc_code++ =3D ((bch_val3 >> 8) & 0xFF);
-			*ecc_code++ =3D (bch_val3 & 0xFF);
-			*ecc_code++ =3D ((bch_val2 >> 24) & 0xFF);
-			*ecc_code++ =3D ((bch_val2 >> 16) & 0xFF);
-			*ecc_code++ =3D ((bch_val2 >> 8) & 0xFF);
-			*ecc_code++ =3D (bch_val2 & 0xFF);
-			*ecc_code++ =3D ((bch_val1 >> 24) & 0xFF);
-			*ecc_code++ =3D ((bch_val1 >> 16) & 0xFF);
-			*ecc_code++ =3D ((bch_val1 >> 8) & 0xFF);
-			*ecc_code++ =3D (bch_val1 & 0xFF);
-			break;
-		case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
-		case OMAP_ECC_BCH4_CODE_HW:
-			bch_val1 =3D readl(gpmc_regs->gpmc_bch_result0[i]);
-			bch_val2 =3D readl(gpmc_regs->gpmc_bch_result1[i]);
-			*ecc_code++ =3D ((bch_val2 >> 12) & 0xFF);
-			*ecc_code++ =3D ((bch_val2 >> 4) & 0xFF);
-			*ecc_code++ =3D ((bch_val2 & 0xF) << 4) |
-				((bch_val1 >> 28) & 0xF);
-			*ecc_code++ =3D ((bch_val1 >> 20) & 0xFF);
-			*ecc_code++ =3D ((bch_val1 >> 12) & 0xFF);
-			*ecc_code++ =3D ((bch_val1 >> 4) & 0xFF);
-			*ecc_code++ =3D ((bch_val1 & 0xF) << 4);
-			break;
-		case OMAP_ECC_BCH16_CODE_HW:
-			val =3D readl(gpmc_regs->gpmc_bch_result6[i]);
-			ecc_code[0]  =3D ((val >>  8) & 0xFF);
-			ecc_code[1]  =3D ((val >>  0) & 0xFF);
-			val =3D readl(gpmc_regs->gpmc_bch_result5[i]);
-			ecc_code[2]  =3D ((val >> 24) & 0xFF);
-			ecc_code[3]  =3D ((val >> 16) & 0xFF);
-			ecc_code[4]  =3D ((val >>  8) & 0xFF);
-			ecc_code[5]  =3D ((val >>  0) & 0xFF);
-			val =3D readl(gpmc_regs->gpmc_bch_result4[i]);
-			ecc_code[6]  =3D ((val >> 24) & 0xFF);
-			ecc_code[7]  =3D ((val >> 16) & 0xFF);
-			ecc_code[8]  =3D ((val >>  8) & 0xFF);
-			ecc_code[9]  =3D ((val >>  0) & 0xFF);
-			val =3D readl(gpmc_regs->gpmc_bch_result3[i]);
-			ecc_code[10] =3D ((val >> 24) & 0xFF);
-			ecc_code[11] =3D ((val >> 16) & 0xFF);
-			ecc_code[12] =3D ((val >>  8) & 0xFF);
-			ecc_code[13] =3D ((val >>  0) & 0xFF);
-			val =3D readl(gpmc_regs->gpmc_bch_result2[i]);
-			ecc_code[14] =3D ((val >> 24) & 0xFF);
-			ecc_code[15] =3D ((val >> 16) & 0xFF);
-			ecc_code[16] =3D ((val >>  8) & 0xFF);
-			ecc_code[17] =3D ((val >>  0) & 0xFF);
-			val =3D readl(gpmc_regs->gpmc_bch_result1[i]);
-			ecc_code[18] =3D ((val >> 24) & 0xFF);
-			ecc_code[19] =3D ((val >> 16) & 0xFF);
-			ecc_code[20] =3D ((val >>  8) & 0xFF);
-			ecc_code[21] =3D ((val >>  0) & 0xFF);
-			val =3D readl(gpmc_regs->gpmc_bch_result0[i]);
-			ecc_code[22] =3D ((val >> 24) & 0xFF);
-			ecc_code[23] =3D ((val >> 16) & 0xFF);
-			ecc_code[24] =3D ((val >>  8) & 0xFF);
-			ecc_code[25] =3D ((val >>  0) & 0xFF);
-			break;
-		default:
-			return -EINVAL;
-		}
+		ret =3D _omap_calculate_ecc_bch(mtd, dat, ecc_calc, i);
+		if (ret)
+			return ret;
=20
-		/* ECC scheme specific syndrome customizations */
-		switch (info->ecc_opt) {
-		case OMAP_ECC_BCH4_CODE_HW_DETECTION_SW:
-			/* Add constant polynomial to remainder, so that
-			 * ECC of blank pages results in 0x0 on reading back */
-			for (j =3D 0; j < eccbytes; j++)
-				ecc_calc[j] ^=3D bch4_polynomial[j];
-			break;
-		case OMAP_ECC_BCH4_CODE_HW:
-			/* Set  8th ECC byte as 0x0 for ROM compatibility */
-			ecc_calc[eccbytes - 1] =3D 0x0;
-			break;
-		case OMAP_ECC_BCH8_CODE_HW_DETECTION_SW:
-			/* Add constant polynomial to remainder, so that
-			 * ECC of blank pages results in 0x0 on reading back */
-			for (j =3D 0; j < eccbytes; j++)
-				ecc_calc[j] ^=3D bch8_polynomial[j];
-			break;
-		case OMAP_ECC_BCH8_CODE_HW:
-			/* Set 14th ECC byte as 0x0 for ROM compatibility */
-			ecc_calc[eccbytes - 1] =3D 0x0;
-			break;
-		case OMAP_ECC_BCH16_CODE_HW:
-			break;
-		default:
-			return -EINVAL;
-		}
-
-	ecc_calc +=3D eccbytes;
+		ecc_calc +=3D eccbytes;
 	}
=20
 	return 0;
@@ -1527,7 +1571,7 @@ static int omap_write_page_bch(struct mtd_info *mtd, =
struct nand_chip *chip,
 	chip->write_buf(mtd, buf, mtd->writesize);
=20
 	/* Update ecc vector from GPMC result registers */
-	chip->ecc.calculate(mtd, buf, &ecc_calc[0]);
+	omap_calculate_ecc_bch_multi(mtd, buf, &ecc_calc[0]);
=20
 	for (i =3D 0; i < chip->ecc.total; i++)
 		chip->oob_poi[eccpos[i]] =3D ecc_calc[i];
@@ -1537,6 +1581,72 @@ static int omap_write_page_bch(struct mtd_info *mtd,=
 struct nand_chip *chip,
 	return 0;
 }
=20
+/**
+ * omap_write_subpage_bch - BCH hardware ECC based subpage write
+ * @mtd:	mtd info structure
+ * @chip:	nand chip info structure
+ * @offset:	column address of subpage within the page
+ * @data_len:	data length
+ * @buf:	data buffer
+ * @oob_required: must write chip->oob_poi to OOB
+ * @page: page number to write
+ *
+ * OMAP optimized subpage write method.
+ */
+static int omap_write_subpage_bch(struct mtd_info *mtd,
+				  struct nand_chip *chip, u32 offset,
+				  u32 data_len, const u8 *buf,
+				  int oob_required, int page)
+{
+	u8 *ecc_calc =3D chip->buffers->ecccalc;
+	int ecc_size      =3D chip->ecc.size;
+	int ecc_bytes     =3D chip->ecc.bytes;
+	int ecc_steps     =3D chip->ecc.steps;
+	u32 start_step =3D offset / ecc_size;
+	u32 end_step   =3D (offset + data_len - 1) / ecc_size;
+	int step, ret =3D 0;
+
+	/*
+	 * Write entire page at one go as it would be optimal
+	 * as ECC is calculated by hardware.
+	 * ECC is calculated for all subpages but we choose
+	 * only what we want.
+	 */
+
+	/* Enable GPMC ECC engine */
+	chip->ecc.hwctl(mtd, NAND_ECC_WRITE);
+
+	/* Write data */
+	chip->write_buf(mtd, buf, mtd->writesize);
+
+	for (step =3D 0; step < ecc_steps; step++) {
+		/* mask ECC of un-touched subpages by padding 0xFF */
+		if (step < start_step || step > end_step)
+			memset(ecc_calc, 0xff, ecc_bytes);
+		else
+			ret =3D _omap_calculate_ecc_bch(mtd, buf, ecc_calc, step);
+
+		if (ret)
+			return ret;
+
+		buf +=3D ecc_size;
+		ecc_calc +=3D ecc_bytes;
+	}
+
+	/* copy calculated ECC for whole page to chip->buffer->oob */
+	/* this include masked-value(0xFF) for unwritten subpages */
+	ecc_calc =3D chip->buffers->ecccalc;
+	ret =3D mtd_ooblayout_set_eccbytes(mtd, ecc_calc, chip->oob_poi, 0,
+					 chip->ecc.total);
+	if (ret)
+		return ret;
+
+	/* write OOB buffer to NAND device */
+	chip->write_buf(mtd, chip->oob_poi, mtd->oobsize);
+
+	return 0;
+}
+
 /**
  * omap_read_page_bch - BCH ecc based page read function for entire page
  * @mtd:		mtd info structure
@@ -1574,7 +1684,7 @@ static int omap_read_page_bch(struct mtd_info *mtd, s=
truct nand_chip *chip,
 	chip->read_buf(mtd, oob, chip->ecc.total);
=20
 	/* Calculate ecc bytes */
-	chip->ecc.calculate(mtd, buf, ecc_calc);
+	omap_calculate_ecc_bch_multi(mtd, buf, ecc_calc);
=20
 	memcpy(ecc_code, &chip->oob_poi[eccpos[0]], chip->ecc.total);
=20
@@ -1823,7 +1933,7 @@ static int omap_nand_probe(struct platform_device *pd=
ev)
 		nand_chip->ecc.strength		=3D 4;
 		nand_chip->ecc.hwctl		=3D omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		=3D nand_bch_correct_data;
-		nand_chip->ecc.calculate	=3D omap_calculate_ecc_bch;
+		nand_chip->ecc.calculate	=3D omap_calculate_ecc_bch_sw;
 		/* define ECC layout */
 		ecclayout->eccbytes		=3D nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -1863,9 +1973,9 @@ static int omap_nand_probe(struct platform_device *pd=
ev)
 		nand_chip->ecc.strength		=3D 4;
 		nand_chip->ecc.hwctl		=3D omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		=3D omap_elm_correct_data;
-		nand_chip->ecc.calculate	=3D omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	=3D omap_read_page_bch;
 		nand_chip->ecc.write_page	=3D omap_write_page_bch;
+		nand_chip->ecc.write_subpage	=3D omap_write_subpage_bch;
 		/* define ECC layout */
 		ecclayout->eccbytes		=3D nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -1898,7 +2008,7 @@ static int omap_nand_probe(struct platform_device *pd=
ev)
 		nand_chip->ecc.strength		=3D 8;
 		nand_chip->ecc.hwctl		=3D omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		=3D nand_bch_correct_data;
-		nand_chip->ecc.calculate	=3D omap_calculate_ecc_bch;
+		nand_chip->ecc.calculate	=3D omap_calculate_ecc_bch_sw;
 		/* define ECC layout */
 		ecclayout->eccbytes		=3D nand_chip->ecc.bytes *
 							(mtd->writesize /
@@ -1939,9 +2049,9 @@ static int omap_nand_probe(struct platform_device *pd=
ev)
 		nand_chip->ecc.strength		=3D 8;
 		nand_chip->ecc.hwctl		=3D omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		=3D omap_elm_correct_data;
-		nand_chip->ecc.calculate	=3D omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	=3D omap_read_page_bch;
 		nand_chip->ecc.write_page	=3D omap_write_page_bch;
+		nand_chip->ecc.write_subpage	=3D omap_write_subpage_bch;
 		/* This ECC scheme requires ELM H/W block */
 		err =3D is_elm_present(info, pdata->elm_of_node, BCH8_ECC);
 		if (err < 0) {
@@ -1974,9 +2084,9 @@ static int omap_nand_probe(struct platform_device *pd=
ev)
 		nand_chip->ecc.strength		=3D 16;
 		nand_chip->ecc.hwctl		=3D omap_enable_hwecc_bch;
 		nand_chip->ecc.correct		=3D omap_elm_correct_data;
-		nand_chip->ecc.calculate	=3D omap_calculate_ecc_bch;
 		nand_chip->ecc.read_page	=3D omap_read_page_bch;
 		nand_chip->ecc.write_page	=3D omap_write_page_bch;
+		nand_chip->ecc.write_subpage	=3D omap_write_subpage_bch;
 		/* This ECC scheme requires ELM H/W block */
 		err =3D is_elm_present(info, pdata->elm_of_node, BCH16_ECC);
 		if (err < 0) {
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/e=
thernet/broadcom/genet/bcmgenet.c
index f22654e2060d..eb99d65f87f3 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1509,12 +1509,8 @@ static void bcmgenet_free_rx_buffers(struct bcmgenet=
_priv *priv)
 	}
 }
=20
-static int reset_umac(struct bcmgenet_priv *priv)
+static void reset_umac(struct bcmgenet_priv *priv)
 {
-	struct device *kdev =3D &priv->pdev->dev;
-	unsigned int timeout =3D 0;
-	u32 reg;
-
 	/* 7358a0/7552a0: bad default in RBUF_FLUSH_CTRL.umac_sw_rst */
 	bcmgenet_rbuf_ctrl_set(priv, 0);
 	udelay(10);
@@ -1522,38 +1518,21 @@ static int reset_umac(struct bcmgenet_priv *priv)
 	/* disable MAC while updating its registers */
 	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
=20
-	/* issue soft reset, wait for it to complete */
-	bcmgenet_umac_writel(priv, CMD_SW_RESET, UMAC_CMD);
-	while (timeout++ < 1000) {
-		reg =3D bcmgenet_umac_readl(priv, UMAC_CMD);
-		if (!(reg & CMD_SW_RESET))
-			return 0;
-
-		udelay(1);
-	}
-
-	if (timeout =3D=3D 1000) {
-		dev_err(kdev,
-			"timeout waiting for MAC to come out of resetn\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	/* issue soft reset with (rg)mii loopback to ensure a stable rxclk */
+	bcmgenet_umac_writel(priv, CMD_SW_RESET | CMD_LCL_LOOP_EN, UMAC_CMD);
+	udelay(2);
+	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
 }
=20
-static int init_umac(struct bcmgenet_priv *priv)
+static void init_umac(struct bcmgenet_priv *priv)
 {
 	struct device *kdev =3D &priv->pdev->dev;
-	int ret;
 	u32 reg, cpu_mask_clear;
=20
 	dev_dbg(&priv->pdev->dev, "bcmgenet: init_umac\n");
=20
-	ret =3D reset_umac(priv);
-	if (ret)
-		return ret;
+	reset_umac(priv);
=20
-	bcmgenet_umac_writel(priv, 0, UMAC_CMD);
 	/* clear tx/rx counter */
 	bcmgenet_umac_writel(priv,
 		MIB_RESET_RX | MIB_RESET_TX | MIB_RESET_RUNT, UMAC_MIB_CTRL);
@@ -1604,8 +1583,6 @@ static int init_umac(struct bcmgenet_priv *priv)
=20
 	/* Enable rx/tx engine.*/
 	dev_dbg(kdev, "done init umac\n");
-
-	return 0;
 }
=20
 /* Initialize all house-keeping variables for a TX ring, along
@@ -1994,14 +1971,10 @@ static void bcmgenet_set_hw_addr(struct bcmgenet_pr=
iv *priv,
=20
 static int bcmgenet_wol_resume(struct bcmgenet_priv *priv)
 {
-	int ret;
-
 	/* From WOL-enabled suspend, switch to regular clock */
 	clk_disable(priv->clk_wol);
 	/* init umac registers to synchronize s/w with h/w */
-	ret =3D init_umac(priv);
-	if (ret)
-		return ret;
+	init_umac(priv);
=20
 	phy_init_hw(priv->phydev);
 	/* Speed settings must be restored */
@@ -2062,14 +2035,7 @@ static int bcmgenet_open(struct net_device *dev)
 	/* take MAC out of reset */
 	bcmgenet_umac_reset(priv);
=20
-	ret =3D init_umac(priv);
-	if (ret)
-		goto err_clk_disable;
-
-	/* disable ethernet MAC while updating its registers */
-	reg =3D bcmgenet_umac_readl(priv, UMAC_CMD);
-	reg &=3D ~(CMD_TX_EN | CMD_RX_EN);
-	bcmgenet_umac_writel(priv, reg, UMAC_CMD);
+	init_umac(priv);
=20
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
=20
@@ -2603,9 +2569,7 @@ static int bcmgenet_probe(struct platform_device *pde=
v)
 	    !strcasecmp(phy_mode_str, "internal"))
 		bcmgenet_power_up(priv, GENET_POWER_PASSIVE);
=20
-	err =3D reset_umac(priv);
-	if (err)
-		goto err_clk_disable;
+	reset_umac(priv);
=20
 	err =3D bcmgenet_mii_init(dev);
 	if (err)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_main.c
index fd388cc8c22e..01254f25f9fc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3047,7 +3047,7 @@ static bool i40e_clean_fdir_tx_irq(struct i40e_ring *=
tx_ring, int budget)
 			break;
=20
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
=20
 		/* if the descriptor isn't done, no work yet to do */
 		if (!(eop_desc->cmd_type_offset_bsz &
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethe=
rnet/intel/i40e/i40e_txrx.c
index 7b1be746dd30..63090f461b7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -657,7 +657,7 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring=
, int budget)
 			break;
=20
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
=20
 		/* we have caught up to head, no work left to do */
 		if (tx_head =3D=3D tx_desc)
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c b/drivers/net/et=
hernet/intel/i40evf/i40e_txrx.c
index 48ebb6cd69f2..7e9a54fe5ab5 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -216,7 +216,7 @@ static bool i40e_clean_tx_irq(struct i40e_ring *tx_ring=
, int budget)
 			break;
=20
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
=20
 		/* we have caught up to head, no work left to do */
 		if (tx_head =3D=3D tx_desc)
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethern=
et/intel/igb/igb_main.c
index b844902d12a0..905328f3db86 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6360,7 +6360,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_v=
ector)
 			break;
=20
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
=20
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(E1000_TXD_STAT_DD)))
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethern=
et/intel/igbvf/netdev.c
index d608599e123a..296559052d45 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -808,7 +808,7 @@ static bool igbvf_clean_tx_irq(struct igbvf_ring *tx_ri=
ng)
 			break;
=20
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
=20
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(E1000_TXD_STAT_DD)))
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/et=
hernet/intel/ixgbe/ixgbe_main.c
index a125d3c35856..1d1af2e62811 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -1086,7 +1086,7 @@ static bool ixgbe_clean_tx_irq(struct ixgbe_q_vector =
*q_vector,
 			break;
=20
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
=20
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/ne=
t/ethernet/intel/ixgbevf/ixgbevf_main.c
index e626b73ca00e..c932436c6a47 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -249,7 +249,7 @@ static bool ixgbevf_clean_tx_irq(struct ixgbevf_q_vecto=
r *q_vector,
 			break;
=20
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
=20
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
diff --git a/drivers/net/wireless/p54/main.c b/drivers/net/wireless/p54/mai=
n.c
index 7be3a4839640..1084e1d04279 100644
--- a/drivers/net/wireless/p54/main.c
+++ b/drivers/net/wireless/p54/main.c
@@ -851,12 +851,11 @@ void p54_unregister_common(struct ieee80211_hw *dev)
 {
 	struct p54_common *priv =3D dev->priv;
=20
-#ifdef CONFIG_P54_LEDS
-	p54_unregister_leds(priv);
-#endif /* CONFIG_P54_LEDS */
-
 	if (priv->registered) {
 		priv->registered =3D false;
+#ifdef CONFIG_P54_LEDS
+		p54_unregister_leds(priv);
+#endif /* CONFIG_P54_LEDS */
 		ieee80211_unregister_hw(dev);
 	}
=20
diff --git a/drivers/net/wireless/rt2x00/rt2x00usb.c b/drivers/net/wireless=
/rt2x00/rt2x00usb.c
index 86c43d112a4b..b949116a472e 100644
--- a/drivers/net/wireless/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/rt2x00/rt2x00usb.c
@@ -62,7 +62,7 @@ int rt2x00usb_vendor_request(struct rt2x00_dev *rt2x00dev,
 		 * -ENODEV: Device has disappeared, no point continuing.
 		 * All other errors: Try again.
 		 */
-		else if (status =3D=3D -ENODEV) {
+		else if (status =3D=3D -ENODEV || status =3D=3D -ENOENT) {
 			clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
 			break;
 		}
@@ -325,7 +325,7 @@ static bool rt2x00usb_kick_tx_entry(struct queue_entry =
*entry, void *data)
=20
 	status =3D usb_submit_urb(entry_priv->urb, GFP_ATOMIC);
 	if (status) {
-		if (status =3D=3D -ENODEV)
+		if (status =3D=3D -ENODEV || status =3D=3D -ENOENT)
 			clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
 		set_bit(ENTRY_DATA_IO_FAILED, &entry->flags);
 		rt2x00lib_dmadone(entry);
@@ -414,7 +414,7 @@ static bool rt2x00usb_kick_rx_entry(struct queue_entry =
*entry, void *data)
=20
 	status =3D usb_submit_urb(entry_priv->urb, GFP_ATOMIC);
 	if (status) {
-		if (status =3D=3D -ENODEV)
+		if (status =3D=3D -ENODEV || status =3D=3D -ENOENT)
 			clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
 		set_bit(ENTRY_DATA_IO_FAILED, &entry->flags);
 		rt2x00lib_dmadone(entry);
diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerd=
rv_core.c
index b60a325234c5..cca4b4789ac4 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -360,7 +360,14 @@ static pci_ers_result_t broadcast_error_message(struct=
 pci_dev *dev,
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
 		 */
-		pci_walk_bus(dev->bus, cb, &result_data);
+		if (state =3D=3D pci_channel_io_normal)
+			/*
+			 * the error is non fatal so the bus is ok, just invoke
+			 * the callback for the function that logged the error.
+			 */
+			cb(dev, &result_data);
+		else
+			pci_walk_bus(dev->bus, cb, &result_data);
 	}
=20
 	return result_data.result;
diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony=
-laptop.c
index 9c5a07417b2b..e7ff8152ef2b 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1654,17 +1654,19 @@ static int sony_nc_setup_rfkill(struct acpi_device =
*device,
 	if (!rfk)
 		return -ENOMEM;
=20
-	if (sony_call_snc_handle(sony_rfkill_handle, 0x200, &result) < 0) {
+	err =3D sony_call_snc_handle(sony_rfkill_handle, 0x200, &result);
+	if (err < 0) {
 		rfkill_destroy(rfk);
-		return -1;
+		return err;
 	}
 	hwblock =3D !(result & 0x1);
=20
-	if (sony_call_snc_handle(sony_rfkill_handle,
-				sony_rfkill_address[nc_type],
-				&result) < 0) {
+	err =3D sony_call_snc_handle(sony_rfkill_handle,
+				   sony_rfkill_address[nc_type],
+				   &result);
+	if (err < 0) {
 		rfkill_destroy(rfk);
-		return -1;
+		return err;
 	}
 	swblock =3D !(result & 0x2);
=20
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 5813fa52c3d4..05eeeb537ff8 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -778,9 +778,23 @@ EXPORT_SYMBOL_GPL(rtc_irq_set_freq);
  */
 static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *tim=
er)
 {
+	struct timerqueue_node *next =3D timerqueue_getnext(&rtc->timerqueue);
+	struct rtc_time tm;
+	ktime_t now;
+
 	timer->enabled =3D 1;
+	__rtc_read_time(rtc, &tm);
+	now =3D rtc_tm_to_ktime(tm);
+
+	/* Skip over expired timers */
+	while (next) {
+		if (next->expires.tv64 >=3D now.tv64)
+			break;
+		next =3D timerqueue_iterate_next(next);
+	}
+
 	timerqueue_add(&rtc->timerqueue, &timer->node);
-	if (&timer->node =3D=3D timerqueue_getnext(&rtc->timerqueue)) {
+	if (!next || ktime_before(timer->node.expires, next->expires)) {
 		struct rtc_wkalrm alarm;
 		int err;
 		alarm.time =3D rtc_ktime_to_tm(timer->node.expires);
diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugf=
s.c
index 8e83d0474fe7..996f3170a7ab 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -254,7 +254,8 @@ bfad_debugfs_write_regrd(struct file *file, const char =
__user *buf,
 	struct bfad_s *bfad =3D port->bfad;
 	struct bfa_s *bfa =3D &bfad->bfa;
 	struct bfa_ioc_s *ioc =3D &bfa->ioc;
-	int addr, len, rc, i;
+	int addr, rc, i;
+	u32 len;
 	u32 *regbuf;
 	void __iomem *rb, *reg_addr;
 	unsigned long flags;
@@ -274,7 +275,7 @@ bfad_debugfs_write_regrd(struct file *file, const char =
__user *buf,
 	}
=20
 	rc =3D sscanf(kern_buf, "%x:%x", &addr, &len);
-	if (rc < 2) {
+	if (rc < 2 || len > (UINT_MAX >> 2)) {
 		printk(KERN_INFO
 			"bfad[%d]: %s failed to read user buf\n",
 			bfad->inst_no, __func__);
diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ash=
mem.c
index 713a97226787..be2958f0ce28 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -758,10 +758,12 @@ static long ashmem_ioctl(struct file *file, unsigned =
int cmd, unsigned long arg)
 		break;
 	case ASHMEM_SET_SIZE:
 		ret =3D -EINVAL;
+		mutex_lock(&ashmem_mutex);
 		if (!asma->file) {
 			ret =3D 0;
 			asma->size =3D (size_t) arg;
 		}
+		mutex_unlock(&ashmem_mutex);
 		break;
 	case ASHMEM_GET_SIZE:
 		ret =3D asma->size;
diff --git a/drivers/staging/lustre/lustre/ptlrpc/sec.c b/drivers/staging/l=
ustre/lustre/ptlrpc/sec.c
index 28ac824a73fb..1961de7934e2 100644
--- a/drivers/staging/lustre/lustre/ptlrpc/sec.c
+++ b/drivers/staging/lustre/lustre/ptlrpc/sec.c
@@ -867,7 +867,7 @@ void sptlrpc_request_out_callback(struct ptlrpc_request=
 *req)
 	if (req->rq_pool || !req->rq_reqbuf)
 		return;
=20
-	OBD_FREE(req->rq_reqbuf, req->rq_reqbuf_len);
+	OBD_FREE_LARGE(req->rq_reqbuf, req->rq_reqbuf_len);
 	req->rq_reqbuf =3D NULL;
 	req->rq_reqbuf_len =3D 0;
 }
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rt=
l8188eu/core/rtw_mlme.c
index 155282ef78fb..6412e2e759a8 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -120,9 +120,8 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlme=
priv)
=20
 void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-	rtw_free_mlme_priv_ie_data(pmlmepriv);
-
 	if (pmlmepriv) {
+		rtw_free_mlme_priv_ie_data(pmlmepriv);
 		if (pmlmepriv->free_bss_buf)
 			vfree(pmlmepriv->free_bss_buf);
 	}
diff --git a/drivers/staging/usbip/stub.h b/drivers/staging/usbip/stub.h
index 266e2b0ce9a8..910f027773aa 100644
--- a/drivers/staging/usbip/stub.h
+++ b/drivers/staging/usbip/stub.h
@@ -33,7 +33,6 @@
 #define STUB_BUSID_ALLOC 3
=20
 struct stub_device {
-	struct usb_interface *interface;
 	struct usb_device *udev;
=20
 	struct usbip_device ud;
diff --git a/drivers/staging/usbip/stub_dev.c b/drivers/staging/usbip/stub_=
dev.c
index 51d0c7188738..2107aed62ebd 100644
--- a/drivers/staging/usbip/stub_dev.c
+++ b/drivers/staging/usbip/stub_dev.c
@@ -246,7 +246,7 @@ static void stub_device_reset(struct usbip_device *ud)
=20
 	dev_dbg(&udev->dev, "device reset");
=20
-	ret =3D usb_lock_device_for_reset(udev, sdev->interface);
+	ret =3D usb_lock_device_for_reset(udev, NULL);
 	if (ret < 0) {
 		dev_err(&udev->dev, "lock for reset\n");
 		spin_lock_irq(&ud->lock);
@@ -279,7 +279,7 @@ static void stub_device_unusable(struct usbip_device *u=
d)
=20
 /**
  * stub_device_alloc - allocate a new stub_device struct
- * @interface: usb_interface of a new device
+ * @udev: usb_device of a new device
  *
  * Allocates and initializes a new stub_device struct.
  */
diff --git a/drivers/staging/usbip/stub_rx.c b/drivers/staging/usbip/stub_r=
x.c
index e0b6d6b42728..35f59747122a 100644
--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -165,12 +165,7 @@ static int tweak_reset_device_cmd(struct urb *urb)
=20
 	dev_info(&urb->dev->dev, "usb_queue_reset_device\n");
=20
-	/*
-	 * With the implementation of pre_reset and post_reset the driver no
-	 * longer unbinds. This allows the use of synchronous reset.
-	 */
-
-	if (usb_lock_device_for_reset(sdev->udev, sdev->interface) < 0) {
+	if (usb_lock_device_for_reset(sdev->udev, NULL) < 0) {
 		dev_err(&urb->dev->dev, "could not obtain lock to reset device\n");
 		return 0;
 	}
@@ -321,7 +316,7 @@ static struct stub_priv *stub_priv_alloc(struct stub_de=
vice *sdev,
=20
 	priv =3D kmem_cache_zalloc(stub_priv_cache, GFP_ATOMIC);
 	if (!priv) {
-		dev_err(&sdev->interface->dev, "alloc stub_priv\n");
+		dev_err(&sdev->udev->dev, "alloc stub_priv\n");
 		spin_unlock_irqrestore(&sdev->priv_lock, flags);
 		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
 		return NULL;
@@ -341,23 +336,34 @@ static struct stub_priv *stub_priv_alloc(struct stub_=
device *sdev,
 	return priv;
 }
=20
-static int get_pipe(struct stub_device *sdev, int epnum, int dir)
+static int get_pipe(struct stub_device *sdev, struct usbip_header *pdu)
 {
 	struct usb_device *udev =3D sdev->udev;
 	struct usb_host_endpoint *ep;
 	struct usb_endpoint_descriptor *epd =3D NULL;
+	int epnum =3D pdu->base.ep;
+	int dir =3D pdu->base.direction;
+
+	if (epnum < 0 || epnum > 15)
+		goto err_ret;
=20
 	if (dir =3D=3D USBIP_DIR_IN)
 		ep =3D udev->ep_in[epnum & 0x7f];
 	else
 		ep =3D udev->ep_out[epnum & 0x7f];
-	if (!ep) {
-		dev_err(&sdev->interface->dev, "no such endpoint?, %d\n",
-			epnum);
-		BUG();
-	}
+	if (!ep)
+		goto err_ret;
=20
 	epd =3D &ep->desc;
+
+	/* validate transfer_buffer_length */
+	if (pdu->u.cmd_submit.transfer_buffer_length > INT_MAX) {
+		dev_err(&sdev->udev->dev,
+			"CMD_SUBMIT: -EMSGSIZE transfer_buffer_length %d\n",
+			pdu->u.cmd_submit.transfer_buffer_length);
+		return -1;
+	}
+
 	if (usb_endpoint_xfer_control(epd)) {
 		if (dir =3D=3D USBIP_DIR_OUT)
 			return usb_sndctrlpipe(udev, epnum);
@@ -380,15 +386,31 @@ static int get_pipe(struct stub_device *sdev, int epn=
um, int dir)
 	}
=20
 	if (usb_endpoint_xfer_isoc(epd)) {
+		/* validate packet size and number of packets */
+		unsigned int maxp, packets, bytes;
+
+		maxp =3D usb_endpoint_maxp(epd);
+		maxp *=3D usb_endpoint_maxp_mult(epd);
+		bytes =3D pdu->u.cmd_submit.transfer_buffer_length;
+		packets =3D DIV_ROUND_UP(bytes, maxp);
+
+		if (pdu->u.cmd_submit.number_of_packets < 0 ||
+		    pdu->u.cmd_submit.number_of_packets > packets) {
+			dev_err(&sdev->udev->dev,
+				"CMD_SUBMIT: isoc invalid num packets %d\n",
+				pdu->u.cmd_submit.number_of_packets);
+			return -1;
+		}
 		if (dir =3D=3D USBIP_DIR_OUT)
 			return usb_sndisocpipe(udev, epnum);
 		else
 			return usb_rcvisocpipe(udev, epnum);
 	}
=20
+err_ret:
 	/* NOT REACHED */
-	dev_err(&sdev->interface->dev, "get pipe, epnum %d\n", epnum);
-	return 0;
+	dev_err(&sdev->udev->dev, "CMD_SUBMIT: invalid epnum %d\n", epnum);
+	return -1;
 }
=20
 static void masking_bogus_flags(struct urb *urb)
@@ -452,7 +474,10 @@ static void stub_recv_cmd_submit(struct stub_device *s=
dev,
 	struct stub_priv *priv;
 	struct usbip_device *ud =3D &sdev->ud;
 	struct usb_device *udev =3D sdev->udev;
-	int pipe =3D get_pipe(sdev, pdu->base.ep, pdu->base.direction);
+	int pipe =3D get_pipe(sdev, pdu);
+
+	if (pipe =3D=3D -1)
+		return;
=20
 	priv =3D stub_priv_alloc(sdev, pdu);
 	if (!priv)
@@ -466,13 +491,14 @@ static void stub_recv_cmd_submit(struct stub_device *=
sdev,
 		priv->urb =3D usb_alloc_urb(0, GFP_KERNEL);
=20
 	if (!priv->urb) {
-		dev_err(&sdev->interface->dev, "malloc urb\n");
+		dev_err(&udev->dev, "malloc urb\n");
 		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
 		return;
 	}
=20
 	/* allocate urb transfer buffer, if needed */
-	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
+	if (pdu->u.cmd_submit.transfer_buffer_length > 0 &&
+	    pdu->u.cmd_submit.transfer_buffer_length <=3D INT_MAX) {
 		priv->urb->transfer_buffer =3D
 			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
 				GFP_KERNEL);
@@ -486,7 +512,7 @@ static void stub_recv_cmd_submit(struct stub_device *sd=
ev,
 	priv->urb->setup_packet =3D kmemdup(&pdu->u.cmd_submit.setup, 8,
 					  GFP_KERNEL);
 	if (!priv->urb->setup_packet) {
-		dev_err(&sdev->interface->dev, "allocate setup_packet\n");
+		dev_err(&udev->dev, "allocate setup_packet\n");
 		usbip_event_add(ud, SDEV_EVENT_ERROR_MALLOC);
 		return;
 	}
@@ -517,7 +543,7 @@ static void stub_recv_cmd_submit(struct stub_device *sd=
ev,
 		usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
 				  pdu->base.seqnum);
 	else {
-		dev_err(&sdev->interface->dev, "submit_urb error, %d\n", ret);
+		dev_err(&udev->dev, "submit_urb error, %d\n", ret);
 		usbip_dump_header(pdu);
 		usbip_dump_urb(priv->urb);
=20
diff --git a/drivers/staging/usbip/stub_tx.c b/drivers/staging/usbip/stub_t=
x.c
index 021003c4de53..28760119629f 100644
--- a/drivers/staging/usbip/stub_tx.c
+++ b/drivers/staging/usbip/stub_tx.c
@@ -178,6 +178,13 @@ static int stub_send_ret_submit(struct stub_device *sd=
ev)
 		memset(&pdu_header, 0, sizeof(pdu_header));
 		memset(&msg, 0, sizeof(msg));
=20
+		if (urb->actual_length > 0 && !urb->transfer_buffer) {
+			dev_err(&sdev->udev->dev,
+				"urb: actual_length %d transfer_buffer null\n",
+				urb->actual_length);
+			return -1;
+		}
+
 		if (usb_pipetype(urb->pipe) =3D=3D PIPE_ISOCHRONOUS)
 			iovnum =3D 2 + urb->number_of_packets;
 		else
@@ -233,7 +240,7 @@ static int stub_send_ret_submit(struct stub_device *sde=
v)
 			}
=20
 			if (txsize !=3D sizeof(pdu_header) + urb->actual_length) {
-				dev_err(&sdev->interface->dev,
+				dev_err(&sdev->udev->dev,
 					"actual length of urb %d does not match iso packet sizes %zu\n",
 					urb->actual_length,
 					txsize-sizeof(pdu_header));
@@ -265,7 +272,7 @@ static int stub_send_ret_submit(struct stub_device *sde=
v)
 		ret =3D kernel_sendmsg(sdev->ud.tcp_socket, &msg,
 						iov,  iovnum, txsize);
 		if (ret !=3D txsize) {
-			dev_err(&sdev->interface->dev,
+			dev_err(&sdev->udev->dev,
 				"sendmsg failed!, retval %d for %zd\n",
 				ret, txsize);
 			kfree(iov);
@@ -340,7 +347,7 @@ static int stub_send_ret_unlink(struct stub_device *sde=
v)
 		ret =3D kernel_sendmsg(sdev->ud.tcp_socket, &msg, iov,
 				     1, txsize);
 		if (ret !=3D txsize) {
-			dev_err(&sdev->interface->dev,
+			dev_err(&sdev->udev->dev,
 				"sendmsg failed!, retval %d for %zd\n",
 				ret, txsize);
 			usbip_event_add(&sdev->ud, SDEV_EVENT_ERROR_TCP);
diff --git a/drivers/staging/usbip/usbip_common.h b/drivers/staging/usbip/u=
sbip_common.h
index 4da3866a037d..01be15a2066e 100644
--- a/drivers/staging/usbip/usbip_common.h
+++ b/drivers/staging/usbip/usbip_common.h
@@ -261,6 +261,7 @@ struct usbip_device {
 	/* lock for status */
 	spinlock_t lock;
=20
+	int sockfd;
 	struct socket *tcp_socket;
=20
 	struct task_struct *tcp_rx;
diff --git a/drivers/staging/usbip/userspace/Makefile.am b/drivers/staging/=
usbip/userspace/Makefile.am
index 66f8bf038c9f..a2f302cb679f 100644
--- a/drivers/staging/usbip/userspace/Makefile.am
+++ b/drivers/staging/usbip/userspace/Makefile.am
@@ -1,6 +1,7 @@
 SUBDIRS :=3D libsrc src
 includedir =3D @includedir@/usbip
 include_HEADERS :=3D $(addprefix libsrc/, \
-		     usbip_common.h vhci_driver.h usbip_host_driver.h)
+		     usbip_common.h vhci_driver.h usbip_host_driver.h \
+		     list.h sysfs_utils.h)
=20
 dist_man_MANS :=3D $(addprefix doc/, usbip.8 usbipd.8)
diff --git a/drivers/staging/usbip/userspace/libsrc/vhci_driver.c b/drivers=
/staging/usbip/userspace/libsrc/vhci_driver.c
index ad9204773533..1274f326242c 100644
--- a/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
+++ b/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
@@ -55,12 +55,12 @@ static int parse_status(const char *value)
=20
 	while (*c !=3D '\0') {
 		int port, status, speed, devid;
-		unsigned long socket;
+		int sockfd;
 		char lbusid[SYSFS_BUS_ID_SIZE];
=20
-		ret =3D sscanf(c, "%d %d %d %x %lx %31s\n",
+		ret =3D sscanf(c, "%d %d %d %x %u %31s\n",
 				&port, &status, &speed,
-				&devid, &socket, lbusid);
+				&devid, &sockfd, lbusid);
=20
 		if (ret < 5) {
 			dbg("sscanf failed: %d", ret);
@@ -69,7 +69,7 @@ static int parse_status(const char *value)
=20
 		dbg("port %d status %d speed %d devid %x",
 				port, status, speed, devid);
-		dbg("socket %lx lbusid %s", socket, lbusid);
+		dbg("sockfd %u lbusid %s", sockfd, lbusid);
=20
=20
 		/* if a device is connected, look at it */
diff --git a/drivers/staging/usbip/vhci_sysfs.c b/drivers/staging/usbip/vhc=
i_sysfs.c
index 211f43f67ea2..14267d55bf0d 100644
--- a/drivers/staging/usbip/vhci_sysfs.c
+++ b/drivers/staging/usbip/vhci_sysfs.c
@@ -39,13 +39,18 @@ static ssize_t status_show(struct device *dev, struct d=
evice_attribute *attr,
=20
 	/*
 	 * output example:
-	 * prt sta spd dev socket           local_busid
-	 * 000 004 000 000         c5a7bb80 1-2.3
-	 * 001 004 000 000         d8cee980 2-3.4
+	 * prt sta spd dev sockfd    local_busid
+	 * 000 004 000 000 3         1-2.3
+	 * 001 004 000 000 4         2-3.4
+	 *
+	 * Output includes socket fd instead of socket pointer address to avoid
+	 * leaking kernel memory address in:
+	 *	/sys/devices/platform/vhci_hcd.0/status and in debug output.
+	 * The socket pointer address is not used at the moment and it was made
+	 * visible as a convenient way to find IP address from socket pointer
+	 * address by looking up /proc/net/{tcp,tcp6}. As this opens a security
+	 * hole, the change is made to use sockfd instead.
 	 *
-	 * IP address can be retrieved from a socket pointer address by looking
-	 * up /proc/net/{tcp,tcp6}. Also, a userland program may remember a
-	 * port number and its peer IP address.
 	 */
 	out +=3D sprintf(out,
 		       "prt sta spd bus dev socket           local_busid\n");
@@ -59,7 +64,7 @@ static ssize_t status_show(struct device *dev, struct dev=
ice_attribute *attr,
 		if (vdev->ud.status =3D=3D VDEV_ST_USED) {
 			out +=3D sprintf(out, "%03u %08x ",
 				       vdev->speed, vdev->devid);
-			out +=3D sprintf(out, "%16p ", vdev->ud.tcp_socket);
+			out +=3D sprintf(out, "%u", vdev->ud.sockfd);
 			out +=3D sprintf(out, "%s", dev_name(&vdev->udev->dev));
=20
 		} else {
@@ -223,6 +228,7 @@ static ssize_t store_attach(struct device *dev, struct =
device_attribute *attr,
=20
 	vdev->devid         =3D devid;
 	vdev->speed         =3D speed;
+	vdev->ud.sockfd     =3D sockfd;
 	vdev->ud.tcp_socket =3D socket;
 	vdev->ud.status     =3D VDEV_ST_NOTASSIGNED;
=20
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/isc=
si_target.c
index e137dc7cfc72..f7eab402cd4f 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -1753,8 +1753,7 @@ iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, s=
truct iscsi_cmd *cmd,
 	struct iscsi_tmr_req *tmr_req;
 	struct iscsi_tm *hdr;
 	int out_of_order_cmdsn =3D 0, ret;
-	bool sess_ref =3D false;
-	u8 function;
+	u8 function, tcm_function =3D TMR_UNKNOWN;
=20
 	hdr			=3D (struct iscsi_tm *) buf;
 	hdr->flags &=3D ~ISCSI_FLAG_CMD_FINAL;
@@ -1795,23 +1794,18 @@ iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn,=
 struct iscsi_cmd *cmd,
 					     buf);
 	}
=20
+	transport_init_se_cmd(&cmd->se_cmd,
+			      &lio_target_fabric_configfs->tf_ops,
+			      conn->sess->se_sess, 0, DMA_NONE,
+			      MSG_SIMPLE_TAG, cmd->sense_buffer + 2);
+
+	target_get_sess_cmd(conn->sess->se_sess, &cmd->se_cmd, true);
+
 	/*
 	 * TASK_REASSIGN for ERL=3D2 / connection stays inside of
 	 * LIO-Target $FABRIC_MOD
 	 */
 	if (function !=3D ISCSI_TM_FUNC_TASK_REASSIGN) {
-
-		u8 tcm_function;
-		int ret;
-
-		transport_init_se_cmd(&cmd->se_cmd,
-				      &lio_target_fabric_configfs->tf_ops,
-				      conn->sess->se_sess, 0, DMA_NONE,
-				      MSG_SIMPLE_TAG, cmd->sense_buffer + 2);
-
-		target_get_sess_cmd(conn->sess->se_sess, &cmd->se_cmd, true);
-		sess_ref =3D true;
-
 		switch (function) {
 		case ISCSI_TM_FUNC_ABORT_TASK:
 			tcm_function =3D TMR_ABORT_TASK;
@@ -1840,15 +1834,14 @@ iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn,=
 struct iscsi_cmd *cmd,
 			return iscsit_add_reject_cmd(cmd,
 				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
 		}
-
-		ret =3D core_tmr_alloc_req(&cmd->se_cmd, cmd->tmr_req,
-					 tcm_function, GFP_KERNEL);
-		if (ret < 0)
-			return iscsit_add_reject_cmd(cmd,
+	}
+	ret =3D core_tmr_alloc_req(&cmd->se_cmd, cmd->tmr_req, tcm_function,
+				 GFP_KERNEL);
+	if (ret < 0)
+		return iscsit_add_reject_cmd(cmd,
 				ISCSI_REASON_BOOKMARK_NO_RESOURCES, buf);
=20
-		cmd->tmr_req->se_tmr_req =3D cmd->se_cmd.se_tmr_req;
-	}
+	cmd->tmr_req->se_tmr_req =3D cmd->se_cmd.se_tmr_req;
=20
 	cmd->iscsi_opcode	=3D ISCSI_OP_SCSI_TMFUNC;
 	cmd->i_state		=3D ISTATE_SEND_TASKMGTRSP;
@@ -1924,12 +1917,14 @@ iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn,=
 struct iscsi_cmd *cmd,
=20
 	if (!(hdr->opcode & ISCSI_OP_IMMEDIATE)) {
 		int cmdsn_ret =3D iscsit_sequence_cmd(conn, cmd, buf, hdr->cmdsn);
-		if (cmdsn_ret =3D=3D CMDSN_HIGHER_THAN_EXP)
+		if (cmdsn_ret =3D=3D CMDSN_HIGHER_THAN_EXP) {
 			out_of_order_cmdsn =3D 1;
-		else if (cmdsn_ret =3D=3D CMDSN_LOWER_THAN_EXP)
+		} else if (cmdsn_ret =3D=3D CMDSN_LOWER_THAN_EXP) {
+			target_put_sess_cmd(conn->sess->se_sess, &cmd->se_cmd);
 			return 0;
-		else if (cmdsn_ret =3D=3D CMDSN_ERROR_CANNOT_RECOVER)
+		} else if (cmdsn_ret =3D=3D CMDSN_ERROR_CANNOT_RECOVER) {
 			return -1;
+		}
 	}
 	iscsit_ack_from_expstatsn(conn, be32_to_cpu(hdr->exp_statsn));
=20
@@ -1949,12 +1944,8 @@ iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, =
struct iscsi_cmd *cmd,
 	 * For connection recovery, this is also the default action for
 	 * TMR TASK_REASSIGN.
 	 */
-	if (sess_ref) {
-		pr_debug("Handle TMR, using sess_ref=3Dtrue check\n");
-		target_put_sess_cmd(conn->sess->se_sess, &cmd->se_cmd);
-	}
-
 	iscsit_add_cmd_to_response_queue(cmd, conn, cmd->i_state);
+	target_put_sess_cmd(conn->sess->se_sess, &cmd->se_cmd);
 	return 0;
 }
 EXPORT_SYMBOL(iscsit_handle_task_mgt_cmd);
diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_=
tmr.c
index e6fe1b3dd76f..43a9b0168972 100644
--- a/drivers/target/target_core_tmr.c
+++ b/drivers/target/target_core_tmr.c
@@ -141,6 +141,16 @@ static bool __target_check_io_state(struct se_cmd *se_=
cmd,
 		spin_unlock(&se_cmd->t_state_lock);
 		return false;
 	}
+	if (se_cmd->transport_state & CMD_T_PRE_EXECUTE) {
+		if (se_cmd->scsi_status) {
+			pr_debug("Attempted to abort io tag: %u early failure"
+				 " status: 0x%02x\n",
+				 se_cmd->se_tfo->get_task_tag(se_cmd),
+				 se_cmd->scsi_status);
+			spin_unlock(&se_cmd->t_state_lock);
+			return false;
+		}
+	}
 	if (sess->sess_tearing_down || se_cmd->cmd_wait_set) {
 		pr_debug("Attempted to abort io tag: %u already shutdown,"
 			" skipping\n", se_cmd->se_tfo->get_task_tag(se_cmd));
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target=
_core_transport.c
index da00938c6dfa..1f06969c6102 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -1797,6 +1797,7 @@ void target_execute_cmd(struct se_cmd *cmd)
 	}
=20
 	cmd->t_state =3D TRANSPORT_PROCESSING;
+	cmd->transport_state &=3D ~CMD_T_PRE_EXECUTE;
 	cmd->transport_state |=3D CMD_T_ACTIVE|CMD_T_BUSY|CMD_T_SENT;
 	spin_unlock_irq(&cmd->t_state_lock);
 	/*
@@ -2441,6 +2442,7 @@ int target_get_sess_cmd(struct se_session *se_sess, s=
truct se_cmd *se_cmd,
 		ret =3D -ESHUTDOWN;
 		goto out;
 	}
+	se_cmd->transport_state |=3D CMD_T_PRE_EXECUTE;
 	list_add_tail(&se_cmd->se_cmd_list, &se_sess->sess_cmd_list);
 out:
 	spin_unlock_irqrestore(&se_sess->sess_cmd_lock, flags);
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 72cf56086c91..f5a0b850f4aa 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1650,6 +1650,18 @@ static int proc_unlinkurb(struct usb_dev_state *ps, =
void __user *arg)
 	return 0;
 }
=20
+static void compute_isochronous_actual_length(struct urb *urb)
+{
+	unsigned int i;
+
+	if (urb->number_of_packets > 0) {
+		urb->actual_length =3D 0;
+		for (i =3D 0; i < urb->number_of_packets; i++)
+			urb->actual_length +=3D
+					urb->iso_frame_desc[i].actual_length;
+	}
+}
+
 static int processcompl(struct async *as, void __user * __user *arg)
 {
 	struct urb *urb =3D as->urb;
@@ -1657,6 +1669,7 @@ static int processcompl(struct async *as, void __user=
 * __user *arg)
 	void __user *addr =3D as->userurb;
 	unsigned int i;
=20
+	compute_isochronous_actual_length(urb);
 	if (as->userbuffer && urb->actual_length) {
 		if (copy_urb_data_to_user(as->userbuffer, urb))
 			goto err_out;
@@ -1826,6 +1839,7 @@ static int processcompl_compat(struct async *as, void=
 __user * __user *arg)
 	void __user *addr =3D as->userurb;
 	unsigned int i;
=20
+	compute_isochronous_actual_length(urb);
 	if (as->userbuffer && urb->actual_length) {
 		if (copy_urb_data_to_user(as->userbuffer, urb))
 			return -EFAULT;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 25d0eed708a3..6f5ffed75ca1 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -218,6 +218,9 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info =3D USB_QUIRK_DELAY_INIT },
=20
+	/* Corsair K70 LUX */
+	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info =3D USB_QUIRK_DELAY_INIT },
+
 	/* MIDI keyboard WORLDE MINI */
 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =3D
 			USB_QUIRK_CONFIG_INTF_STRINGS },
diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gp=
s.c
index 37d0e8cc7af6..2220c1b9df10 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -138,6 +138,7 @@ struct garmin_data {
 	__u8   privpkt[4*6];
 	spinlock_t lock;
 	struct list_head pktlist;
+	struct usb_anchor write_urbs;
 };
=20
=20
@@ -906,13 +907,19 @@ static int garmin_init_session(struct usb_serial_port=
 *port)
 					sizeof(GARMIN_START_SESSION_REQ), 0);
=20
 			if (status < 0)
-				break;
+				goto err_kill_urbs;
 		}
=20
 		if (status > 0)
 			status =3D 0;
 	}
=20
+	return status;
+
+err_kill_urbs:
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
+	usb_kill_urb(port->interrupt_in_urb);
+
 	return status;
 }
=20
@@ -931,7 +938,6 @@ static int garmin_open(struct tty_struct *tty, struct u=
sb_serial_port *port)
 	spin_unlock_irqrestore(&garmin_data_p->lock, flags);
=20
 	/* shutdown any bulk reads that might be going on */
-	usb_kill_urb(port->write_urb);
 	usb_kill_urb(port->read_urb);
=20
 	if (garmin_data_p->state =3D=3D STATE_RESET)
@@ -954,7 +960,7 @@ static void garmin_close(struct usb_serial_port *port)
=20
 	/* shutdown our urbs */
 	usb_kill_urb(port->read_urb);
-	usb_kill_urb(port->write_urb);
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
=20
 	/* keep reset state so we know that we must start a new session */
 	if (garmin_data_p->state !=3D STATE_RESET)
@@ -1038,12 +1044,14 @@ static int garmin_write_bulk(struct usb_serial_port=
 *port,
 	}
=20
 	/* send it down the pipe */
+	usb_anchor_urb(urb, &garmin_data_p->write_urbs);
 	status =3D usb_submit_urb(urb, GFP_ATOMIC);
 	if (status) {
 		dev_err(&port->dev,
 		   "%s - usb_submit_urb(write bulk) failed with status =3D %d\n",
 				__func__, status);
 		count =3D status;
+		usb_unanchor_urb(urb);
 		kfree(buffer);
 	}
=20
@@ -1402,9 +1410,16 @@ static int garmin_port_probe(struct usb_serial_port =
*port)
 	garmin_data_p->state =3D 0;
 	garmin_data_p->flags =3D 0;
 	garmin_data_p->count =3D 0;
+	init_usb_anchor(&garmin_data_p->write_urbs);
 	usb_set_serial_port_data(port, garmin_data_p);
=20
 	status =3D garmin_init_session(port);
+	if (status)
+		goto err_free;
+
+	return 0;
+err_free:
+	kfree(garmin_data_p);
=20
 	return status;
 }
@@ -1414,6 +1429,7 @@ static int garmin_port_remove(struct usb_serial_port =
*port)
 {
 	struct garmin_data *garmin_data_p =3D usb_get_serial_port_data(port);
=20
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
 	usb_kill_urb(port->interrupt_in_urb);
 	del_timer_sync(&garmin_data_p->timer);
 	kfree(garmin_data_p);
diff --git a/drivers/usb/serial/metro-usb.c b/drivers/usb/serial/metro-usb.c
index 45182c65fa1f..72f7b23b1495 100644
--- a/drivers/usb/serial/metro-usb.c
+++ b/drivers/usb/serial/metro-usb.c
@@ -217,7 +217,7 @@ static int metrousb_open(struct tty_struct *tty, struct=
 usb_serial_port *port)
 		dev_err(&port->dev,
 			"%s - failed submitting interrupt in urb, error code=3D%d\n",
 			__func__, result);
-		goto exit;
+		return result;
 	}
=20
 	/* Send activate cmd to device */
@@ -226,11 +226,16 @@ static int metrousb_open(struct tty_struct *tty, stru=
ct usb_serial_port *port)
 		dev_err(&port->dev,
 			"%s - failed to configure device, error code=3D%d\n",
 			__func__, result);
-		goto exit;
+		goto err_kill_urb;
 	}
=20
 	dev_dbg(&port->dev, "%s - port open\n", __func__);
-exit:
+
+	return 0;
+
+err_kill_urb:
+	usb_kill_urb(port->interrupt_in_urb);
+
 	return result;
 }
=20
diff --git a/drivers/usb/serial/qcserial.c b/drivers/usb/serial/qcserial.c
index 996dc09b00b8..7b3ce6e42fc6 100644
--- a/drivers/usb/serial/qcserial.c
+++ b/drivers/usb/serial/qcserial.c
@@ -147,6 +147,7 @@ static const struct usb_device_id id_table[] =3D {
 	{DEVICE_SWI(0x114f, 0x68a2)},	/* Sierra Wireless MC7750 */
 	{DEVICE_SWI(0x1199, 0x68a2)},	/* Sierra Wireless MC7710 */
 	{DEVICE_SWI(0x1199, 0x901c)},	/* Sierra Wireless EM7700 */
+	{DEVICE_SWI(0x1199, 0x901e)},	/* Sierra Wireless EM7355 QDL */
 	{DEVICE_SWI(0x1199, 0x901f)},	/* Sierra Wireless EM7355 */
 	{DEVICE_SWI(0x1199, 0x9040)},	/* Sierra Wireless Modem */
 	{DEVICE_SWI(0x1199, 0x9051)},	/* Netgear AirCard 340U */
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 77b890e4d296..4c244c696aa6 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -769,11 +769,11 @@ static int dlfb_get_edid(struct dlfb_data *dev, char =
*edid, int len)
=20
 	for (i =3D 0; i < len; i++) {
 		ret =3D usb_control_msg(dev->udev,
-				    usb_rcvctrlpipe(dev->udev, 0), (0x02),
-				    (0x80 | (0x02 << 5)), i << 8, 0xA1, rbuf, 2,
-				    HZ);
-		if (ret < 1) {
-			pr_err("Read EDID byte %d failed err %x\n", i, ret);
+				      usb_rcvctrlpipe(dev->udev, 0), 0x02,
+				      (0x80 | (0x02 << 5)), i << 8, 0xA1,
+				      rbuf, 2, USB_CTRL_GET_TIMEOUT);
+		if (ret < 2) {
+			pr_err("Read EDID byte %d failed: %d\n", i, ret);
 			i--;
 			break;
 		}
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index d0b7320b17c4..e1f366fa59a2 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -483,6 +483,9 @@ static int v9fs_test_inode(struct inode *inode, void *d=
ata)
=20
 	if (v9inode->qid.type !=3D st->qid.type)
 		return 0;
+
+	if (v9inode->qid.path !=3D st->qid.path)
+		return 0;
 	return 1;
 }
=20
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index f03024e5bcbe..84b611ff4b65 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -87,6 +87,9 @@ static int v9fs_test_inode_dotl(struct inode *inode, void=
 *data)
=20
 	if (v9inode->qid.type !=3D st->qid.type)
 		return 0;
+
+	if (v9inode->qid.path !=3D st->qid.path)
+		return 0;
 	return 1;
 }
=20
diff --git a/fs/autofs4/waitq.c b/fs/autofs4/waitq.c
index 116fd38ee472..d5d0f819b64a 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -87,7 +87,8 @@ static int autofs4_write(struct autofs_sb_info *sbi,
 		spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
=20
-	return (bytes > 0);
+	/* if 'wr' returned 0 (impossible) we assume -EIO (safe) */
+	return bytes =3D=3D 0 ? 0 : wr < 0 ? wr : -EIO;
 }
 =09
 static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
@@ -101,6 +102,7 @@ static void autofs4_notify_daemon(struct autofs_sb_info=
 *sbi,
 	} pkt;
 	struct file *pipe =3D NULL;
 	size_t pktsz;
+	int ret;
=20
 	DPRINTK("wait id =3D 0x%08lx, name =3D %.*s, type=3D%d",
 		(unsigned long) wq->wait_queue_token, wq->name.len, wq->name.name, type);
@@ -172,8 +174,18 @@ static void autofs4_notify_daemon(struct autofs_sb_inf=
o *sbi,
=20
 	mutex_unlock(&sbi->wq_mutex);
=20
-	if (autofs4_write(sbi, pipe, &pkt, pktsz))
+	switch (ret =3D autofs4_write(sbi, pipe, &pkt, pktsz)) {
+	case 0:
+		break;
+	case -ENOMEM:
+	case -ERESTARTSYS:
+		/* Just fail this one */
+		autofs4_wait_release(sbi, wq->wait_queue_token, ret);
+		break;
+	default:
 		autofs4_catatonic_mode(sbi);
+		break;
+	}
 	fput(pipe);
 }
=20
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index fe2a643ee005..f1c68f8df674 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1487,7 +1487,9 @@ static bool elf_fdpic_dump_segments(struct coredump_p=
arams *cprm)
 	struct vm_area_struct *vma;
=20
 	for (vma =3D current->mm->mmap; vma; vma =3D vma->vm_next) {
+#ifdef CONFIG_MMU
 		unsigned long addr;
+#endif
=20
 		if (!maydump(vma, cprm->mm_flags))
 			continue;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 3cec2fb4fdc1..72068ce50d76 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -185,7 +185,6 @@ static const char * const logtypes[] =3D {
=20
 void btrfs_printk(const struct btrfs_fs_info *fs_info, const char *fmt, ..=
=2E)
 {
-	struct super_block *sb =3D fs_info->sb;
 	char lvl[4];
 	struct va_format vaf;
 	va_list args;
@@ -207,7 +206,8 @@ void btrfs_printk(const struct btrfs_fs_info *fs_info, =
const char *fmt, ...)
 	vaf.fmt =3D fmt;
 	vaf.va =3D &args;
=20
-	printk("%sBTRFS %s (device %s): %pV\n", lvl, type, sb->s_id, &vaf);
+	printk("%sBTRFS %s (device %s): %pV\n", lvl, type,
+		fs_info ? fs_info->sb->s_id : "<unknown>", &vaf);
=20
 	va_end(args);
 }
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 21fcf8dcb9cd..19233dd073aa 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -446,8 +446,7 @@ int venus_fsync(struct super_block *sb, struct CodaFid =
*fid)
 	UPARG(CODA_FSYNC);
=20
 	inp->coda_fsync.VFid =3D *fid;
-	error =3D coda_upcall(coda_vcp(sb), sizeof(union inputArgs),
-			    &outsize, inp);
+	error =3D coda_upcall(coda_vcp(sb), insize, &outsize, inp);
=20
 	CODA_FREE(inp, insize);
 	return error;
diff --git a/fs/ecryptfs/messaging.c b/fs/ecryptfs/messaging.c
index e57380e5f6bd..3ca7f48bd540 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -443,15 +443,16 @@ void ecryptfs_release_messaging(void)
 	}
 	if (ecryptfs_daemon_hash) {
 		struct ecryptfs_daemon *daemon;
+		struct hlist_node *n;
 		int i;
=20
 		mutex_lock(&ecryptfs_daemon_hash_mux);
 		for (i =3D 0; i < (1 << ecryptfs_hash_bits); i++) {
 			int rc;
=20
-			hlist_for_each_entry(daemon,
-					     &ecryptfs_daemon_hash[i],
-					     euid_chain) {
+			hlist_for_each_entry_safe(daemon, n,
+						  &ecryptfs_daemon_hash[i],
+						  euid_chain) {
 				rc =3D ecryptfs_exorcise_daemon(daemon);
 				if (rc)
 					printk(KERN_ERR "%s: Error whilst "
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index d4b31664a75b..ea90ab336d76 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4810,7 +4810,8 @@ static long ext4_zero_range(struct file *file, loff_t=
 offset,
 	}
=20
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	     offset + len > i_size_read(inode)) {
+	    (offset + len > i_size_read(inode) ||
+	     offset + len > EXT4_I(inode)->i_disksize)) {
 		new_size =3D offset + len;
 		ret =3D inode_newsize_ok(inode, new_size);
 		if (ret)
@@ -4956,7 +4957,8 @@ long ext4_fallocate(struct file *file, int mode, loff=
_t offset, loff_t len)
 	}
=20
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
-	     offset + len > i_size_read(inode)) {
+	    (offset + len > i_size_read(inode) ||
+	     offset + len > EXT4_I(inode)->i_disksize)) {
 		new_size =3D offset + len;
 		ret =3D inode_newsize_ok(inode, new_size);
 		if (ret)
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 010c2af33858..89c3f2ca3c9b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -460,6 +460,11 @@ int f2fs_getattr(struct vfsmount *mnt,
 	struct inode *inode =3D dentry->d_inode;
 	generic_fillattr(inode, stat);
 	stat->blocks <<=3D 3;
+
+	/* we need to show initial sectors used for inline_data/dentries */
+	if (S_ISREG(inode->i_mode) && f2fs_has_inline_data(inode))
+		stat->blocks +=3D (stat->size + 511) >> 9;
+
 	return 0;
 }
=20
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 00dec8840068..cd4d5dccc9fd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -969,14 +969,12 @@ void allocate_data_block(struct f2fs_sb_info *sbi, st=
ruct page *page,
 {
 	struct sit_info *sit_i =3D SIT_I(sbi);
 	struct curseg_info *curseg;
-	unsigned int old_cursegno;
=20
 	curseg =3D CURSEG_I(sbi, type);
=20
 	mutex_lock(&curseg->curseg_mutex);
=20
 	*new_blkaddr =3D NEXT_FREE_BLKADDR(sbi, curseg);
-	old_cursegno =3D curseg->segno;
=20
 	/*
 	 * __add_sum_entry should be resided under the curseg_mutex
@@ -990,14 +988,24 @@ void allocate_data_block(struct f2fs_sb_info *sbi, st=
ruct page *page,
=20
 	stat_inc_block_count(sbi, curseg);
=20
-	if (!__has_curseg_space(sbi, type))
-		sit_i->s_ops->allocate_segment(sbi, type, false);
 	/*
 	 * SIT information should be updated before segment allocation,
 	 * since SSR needs latest valid block information.
 	 */
-	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
-	locate_dirty_segment(sbi, old_cursegno);
+	update_sit_entry(sbi, *new_blkaddr, 1);
+	if (GET_SEGNO(sbi, old_blkaddr) !=3D NULL_SEGNO)
+		update_sit_entry(sbi, old_blkaddr, -1);
+
+	if (!__has_curseg_space(sbi, type))
+		sit_i->s_ops->allocate_segment(sbi, type, false);
+
+	/*
+	 * segment dirty status should be updated after segment allocation,
+	 * so we just need to update status only one time after previous
+	 * segment being closed.
+	 */
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
+	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
=20
 	mutex_unlock(&sit_i->sentry_lock);
=20
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 0ac4c1f73fbd..25177e6bd603 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -103,7 +103,7 @@ static inline unsigned int isonum_733(char *p)
 	/* Ignore bigendian datum due to broken mastering programs */
 	return get_unaligned_le32(p);
 }
-extern int iso_date(char *, int);
+extern int iso_date(u8 *, int);
=20
 struct inode;		/* To make gcc happy */
=20
diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
index ed09e2b08637..f835976ce033 100644
--- a/fs/isofs/rock.h
+++ b/fs/isofs/rock.h
@@ -65,7 +65,7 @@ struct RR_PL_s {
 };
=20
 struct stamp {
-	char time[7];
+	__u8 time[7];		/* actually 6 unsigned, 1 signed */
 } __attribute__ ((packed));
=20
 struct RR_TF_s {
diff --git a/fs/isofs/util.c b/fs/isofs/util.c
index 01e1ee7a998b..5cdf5359b0e9 100644
--- a/fs/isofs/util.c
+++ b/fs/isofs/util.c
@@ -14,7 +14,7 @@
  * to GMT.  Thus  we should always be correct.
  */
=20
-int iso_date(char * p, int flag)
+int iso_date(u8 *p, int flag)
 {
 	int year, month, day, hour, minute, second, tz;
 	int crtime, days, i;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 18d314b3f80f..7f9b6f799aa2 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -243,15 +243,12 @@ const u32 nfs4_fsinfo_bitmap[3] =3D { FATTR4_WORD0_MA=
XFILESIZE
 };
=20
 const u32 nfs4_fs_locations_bitmap[3] =3D {
-	FATTR4_WORD0_TYPE
-	| FATTR4_WORD0_CHANGE
+	FATTR4_WORD0_CHANGE
 	| FATTR4_WORD0_SIZE
 	| FATTR4_WORD0_FSID
 	| FATTR4_WORD0_FILEID
 	| FATTR4_WORD0_FS_LOCATIONS,
-	FATTR4_WORD1_MODE
-	| FATTR4_WORD1_NUMLINKS
-	| FATTR4_WORD1_OWNER
+	FATTR4_WORD1_OWNER
 	| FATTR4_WORD1_OWNER_GROUP
 	| FATTR4_WORD1_RAWDEV
 	| FATTR4_WORD1_SPACE_USED
@@ -6015,9 +6012,7 @@ static int _nfs4_proc_fs_locations(struct rpc_clnt *c=
lient, struct inode *dir,
 				   struct page *page)
 {
 	struct nfs_server *server =3D NFS_SERVER(dir);
-	u32 bitmask[3] =3D {
-		[0] =3D FATTR4_WORD0_FSID | FATTR4_WORD0_FS_LOCATIONS,
-	};
+	u32 bitmask[3];
 	struct nfs4_fs_locations_arg args =3D {
 		.dir_fh =3D NFS_FH(dir),
 		.name =3D name,
@@ -6036,12 +6031,15 @@ static int _nfs4_proc_fs_locations(struct rpc_clnt =
*client, struct inode *dir,
=20
 	dprintk("%s: start\n", __func__);
=20
+	bitmask[0] =3D nfs4_fattr_bitmap[0] | FATTR4_WORD0_FS_LOCATIONS;
+	bitmask[1] =3D nfs4_fattr_bitmap[1];
+
 	/* Ask for the fileid of the absent filesystem if mounted_on_fileid
 	 * is not supported */
 	if (NFS_SERVER(dir)->attr_bitmask[1] & FATTR4_WORD1_MOUNTED_ON_FILEID)
-		bitmask[1] |=3D FATTR4_WORD1_MOUNTED_ON_FILEID;
+		bitmask[0] &=3D ~FATTR4_WORD0_FILEID;
 	else
-		bitmask[0] |=3D FATTR4_WORD0_FILEID;
+		bitmask[1] &=3D ~FATTR4_WORD1_MOUNTED_ON_FILEID;
=20
 	nfs_fattr_init(&fs_locations->fattr);
 	fs_locations->server =3D server;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 1c32adbe728d..14e589195cae 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -201,17 +201,13 @@ DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_ARGS(clp, error),
=20
 		TP_STRUCT__entry(
-			__string(dstaddr,
-				rpc_peeraddr2str(clp->cl_rpcclient,
-					RPC_DISPLAY_ADDR))
+			__string(dstaddr, clp->cl_hostname)
 			__field(int, error)
 		),
=20
 		TP_fast_assign(
 			__entry->error =3D error;
-			__assign_str(dstaddr,
-				rpc_peeraddr2str(clp->cl_rpcclient,
-						RPC_DISPLAY_ADDR));
+			__assign_str(dstaddr, clp->cl_hostname);
 		),
=20
 		TP_printk(
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 3fd83327bbad..b04563f7be69 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1319,7 +1319,7 @@ static int nfs_parse_mount_options(char *raw,
 			mnt->options |=3D NFS_OPTION_MIGRATION;
 			break;
 		case Opt_nomigration:
-			mnt->options &=3D NFS_OPTION_MIGRATION;
+			mnt->options &=3D ~NFS_OPTION_MIGRATION;
 			break;
=20
 		/*
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 14538a865102..2ef7f51d7950 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1883,8 +1883,6 @@ static int nilfs_segctor_collect_dirty_files(struct n=
ilfs_sc_info *sci,
 					      "failed to get inode block.\n");
 				return err;
 			}
-			mark_buffer_dirty(ibh);
-			nilfs_mdt_mark_dirty(ifile);
 			spin_lock(&nilfs->ns_inode_lock);
 			if (likely(!ii->i_bh))
 				ii->i_bh =3D ibh;
@@ -1893,6 +1891,10 @@ static int nilfs_segctor_collect_dirty_files(struct =
nilfs_sc_info *sci,
 			goto retry;
 		}
=20
+		// Always redirty the buffer to avoid race condition
+		mark_buffer_dirty(ii->i_bh);
+		nilfs_mdt_mark_dirty(ifile);
+
 		clear_bit(NILFS_I_QUEUED, &ii->i_state);
 		set_bit(NILFS_I_BUSY, &ii->i_state);
 		list_move_tail(&ii->i_dirty, &sci->sc_dirty_files);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 2ec13bc4deb3..af700530622f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -448,6 +448,7 @@ struct request_queue {
 	int			node;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace	*blk_trace;
+	struct mutex		blk_trace_mutex;
 #endif
 	/*
 	 * for flush operations
diff --git a/include/linux/dmar.h b/include/linux/dmar.h
index 23c8db129560..7052a36f5c80 100644
--- a/include/linux/dmar.h
+++ b/include/linux/dmar.h
@@ -100,6 +100,7 @@ static inline bool dmar_rcu_check(void)
=20
 extern int dmar_table_init(void);
 extern int dmar_dev_scope_init(void);
+extern void dmar_register_bus_notifier(void);
 extern int dmar_parse_dev_scope(void *start, void *end, int *cnt,
 				struct dmar_dev_scope **devices, u16 segment);
 extern void *dmar_alloc_dev_scope(void *start, void *end, int *cnt);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ca9589027893..34af72b8b296 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -174,14 +174,6 @@ extern unsigned long this_cpu_load(void);
 extern void calc_global_load(unsigned long ticks);
 extern void update_cpu_load_nohz(void);
=20
-/* Notifier for when a task gets migrated to a new CPU */
-struct task_migration_notifier {
-	struct task_struct *task;
-	int from_cpu;
-	int to_cpu;
-};
-extern void register_task_migration_notifier(struct notifier_block *n);
-
 extern unsigned long get_parent_ip(unsigned long addr);
=20
 extern void dump_cpu_task(int cpu);
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 6c9979b24eba..775724d054cd 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -583,6 +583,8 @@ static inline void sctp_v6_map_v4(union sctp_addr *addr)
 static inline void sctp_v4_map_v6(union sctp_addr *addr)
 {
 	addr->v6.sin6_family =3D AF_INET6;
+	addr->v6.sin6_flowinfo =3D 0;
+	addr->v6.sin6_scope_id =3D 0;
 	addr->v6.sin6_port =3D addr->v4.sin_port;
 	addr->v6.sin6_addr.s6_addr32[3] =3D addr->v4.sin_addr.s_addr;
 	addr->v6.sin6_addr.s6_addr32[0] =3D 0;
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 2f256a202e97..9e4f596f2175 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -465,10 +465,6 @@ struct sctp_af {
 					 int saddr);
 	void		(*from_sk)	(union sctp_addr *,
 					 struct sock *sk);
-	void		(*to_sk_saddr)	(union sctp_addr *,
-					 struct sock *sk);
-	void		(*to_sk_daddr)	(union sctp_addr *,
-					 struct sock *sk);
 	void		(*from_addr_param) (union sctp_addr *,
 					    union sctp_addr_param *,
 					    __be16 port, int iif);
@@ -509,7 +505,9 @@ struct sctp_pf {
 	int  (*supported_addrs)(const struct sctp_sock *, __be16 *);
 	struct sock *(*create_accept_sk) (struct sock *sk,
 					  struct sctp_association *asoc);
-	void (*addr_v4map) (struct sctp_sock *, union sctp_addr *);
+	int (*addr_to_user)(struct sctp_sock *sk, union sctp_addr *addr);
+	void (*to_sk_saddr)(union sctp_addr *, struct sock *sk);
+	void (*to_sk_daddr)(union sctp_addr *, struct sock *sk);
 	struct sctp_af *af;
 };
=20
diff --git a/include/target/target_core_base.h b/include/target/target_core=
_base.h
index 5c755a85630b..23af3c8569be 100644
--- a/include/target/target_core_base.h
+++ b/include/target/target_core_base.h
@@ -230,6 +230,7 @@ enum tcm_tmreq_table {
 	TMR_LUN_RESET		=3D 5,
 	TMR_TARGET_WARM_RESET	=3D 6,
 	TMR_TARGET_COLD_RESET	=3D 7,
+	TMR_UNKNOWN		=3D 0xff,
 };
=20
 /* fabric independent task management response values */
@@ -536,6 +537,7 @@ struct se_cmd {
 #define CMD_T_BUSY		(1 << 9)
 #define CMD_T_TAS		(1 << 10)
 #define CMD_T_FABRIC_STOP	(1 << 11)
+#define CMD_T_PRE_EXECUTE	(1 << 12)
 	spinlock_t		t_state_lock;
 	struct completion	t_transport_stop_comp;
=20
diff --git a/kernel/extable.c b/kernel/extable.c
index d8a6446adbcb..f7f4771f00c5 100644
--- a/kernel/extable.c
+++ b/kernel/extable.c
@@ -28,6 +28,8 @@
  * mutex protecting text section modification (dynamic code patching).
  * some users need to sleep (allocating memory...) while they hold this lo=
ck.
  *
+ * Note: Also protects SMP-alternatives modification on x86.
+ *
  * NOT exported to modules - patching kernel text is a really delicate mat=
ter.
  */
 DEFINE_MUTEX(text_mutex);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d776fb7d902a..c2e902a52c6d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1041,13 +1041,6 @@ void check_preempt_curr(struct rq *rq, struct task_s=
truct *p, int flags)
 		rq->skip_clock_update =3D 1;
 }
=20
-static ATOMIC_NOTIFIER_HEAD(task_migration_notifier);
-
-void register_task_migration_notifier(struct notifier_block *n)
-{
-	atomic_notifier_chain_register(&task_migration_notifier, n);
-}
-
 #ifdef CONFIG_SMP
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
@@ -1078,18 +1071,10 @@ void set_task_cpu(struct task_struct *p, unsigned i=
nt new_cpu)
 	trace_sched_migrate_task(p, new_cpu);
=20
 	if (task_cpu(p) !=3D new_cpu) {
-		struct task_migration_notifier tmn;
-
 		if (p->sched_class->migrate_task_rq)
 			p->sched_class->migrate_task_rq(p, new_cpu);
 		p->se.nr_migrations++;
 		perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
-
-		tmn.task =3D p;
-		tmn.from_cpu =3D task_cpu(p);
-		tmn.to_cpu =3D new_cpu;
-
-		atomic_notifier_call_chain(&task_migration_notifier, 0, &tmn);
 	}
=20
 	__set_task_cpu(p, new_cpu);
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index c1bd4ada2a04..a2f934e638c7 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -307,7 +307,7 @@ static void blk_trace_cleanup(struct blk_trace *bt)
 		blk_unregister_tracepoints();
 }
=20
-int blk_trace_remove(struct request_queue *q)
+static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
=20
@@ -320,6 +320,17 @@ int blk_trace_remove(struct request_queue *q)
=20
 	return 0;
 }
+
+int blk_trace_remove(struct request_queue *q)
+{
+	int ret;
+
+	mutex_lock(&q->blk_trace_mutex);
+	ret =3D __blk_trace_remove(q);
+	mutex_unlock(&q->blk_trace_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_trace_remove);
=20
 static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
@@ -536,9 +547,8 @@ int do_blk_trace_setup(struct request_queue *q, char *n=
ame, dev_t dev,
 	return ret;
 }
=20
-int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
-		    struct block_device *bdev,
-		    char __user *arg)
+static int __blk_trace_setup(struct request_queue *q, char *name, dev_t de=
v,
+			     struct block_device *bdev, char __user *arg)
 {
 	struct blk_user_trace_setup buts;
 	int ret;
@@ -557,6 +567,19 @@ int blk_trace_setup(struct request_queue *q, char *nam=
e, dev_t dev,
 	}
 	return 0;
 }
+
+int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
+		    struct block_device *bdev,
+		    char __user *arg)
+{
+	int ret;
+
+	mutex_lock(&q->blk_trace_mutex);
+	ret =3D __blk_trace_setup(q, name, dev, bdev, arg);
+	mutex_unlock(&q->blk_trace_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_trace_setup);
=20
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
@@ -593,7 +616,7 @@ static int compat_blk_trace_setup(struct request_queue =
*q, char *name,
 }
 #endif
=20
-int blk_trace_startstop(struct request_queue *q, int start)
+static int __blk_trace_startstop(struct request_queue *q, int start)
 {
 	int ret;
 	struct blk_trace *bt =3D q->blk_trace;
@@ -632,8 +655,25 @@ int blk_trace_startstop(struct request_queue *q, int s=
tart)
=20
 	return ret;
 }
+
+int blk_trace_startstop(struct request_queue *q, int start)
+{
+	int ret;
+
+	mutex_lock(&q->blk_trace_mutex);
+	ret =3D __blk_trace_startstop(q, start);
+	mutex_unlock(&q->blk_trace_mutex);
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(blk_trace_startstop);
=20
+/*
+ * When reading or writing the blktrace sysfs files, the references to the
+ * opened sysfs or device files should prevent the underlying block device
+ * from being removed. So no further delete protection is really needed.
+ */
+
 /**
  * blk_trace_ioctl: - handle the ioctls associated with tracing
  * @bdev:	the block device
@@ -651,12 +691,12 @@ int blk_trace_ioctl(struct block_device *bdev, unsign=
ed cmd, char __user *arg)
 	if (!q)
 		return -ENXIO;
=20
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&q->blk_trace_mutex);
=20
 	switch (cmd) {
 	case BLKTRACESETUP:
 		bdevname(bdev, b);
-		ret =3D blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
+		ret =3D __blk_trace_setup(q, b, bdev->bd_dev, bdev, arg);
 		break;
 #if defined(CONFIG_COMPAT) && defined(CONFIG_X86_64)
 	case BLKTRACESETUP32:
@@ -667,17 +707,17 @@ int blk_trace_ioctl(struct block_device *bdev, unsign=
ed cmd, char __user *arg)
 	case BLKTRACESTART:
 		start =3D 1;
 	case BLKTRACESTOP:
-		ret =3D blk_trace_startstop(q, start);
+		ret =3D __blk_trace_startstop(q, start);
 		break;
 	case BLKTRACETEARDOWN:
-		ret =3D blk_trace_remove(q);
+		ret =3D __blk_trace_remove(q);
 		break;
 	default:
 		ret =3D -ENOTTY;
 		break;
 	}
=20
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&q->blk_trace_mutex);
 	return ret;
 }
=20
@@ -688,10 +728,14 @@ int blk_trace_ioctl(struct block_device *bdev, unsign=
ed cmd, char __user *arg)
  **/
 void blk_trace_shutdown(struct request_queue *q)
 {
+	mutex_lock(&q->blk_trace_mutex);
+
 	if (q->blk_trace) {
-		blk_trace_startstop(q, 0);
-		blk_trace_remove(q);
+		__blk_trace_startstop(q, 0);
+		__blk_trace_remove(q);
 	}
+
+	mutex_unlock(&q->blk_trace_mutex);
 }
=20
 /*
@@ -1670,7 +1714,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct devic=
e *dev,
 	if (q =3D=3D NULL)
 		goto out_bdput;
=20
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&q->blk_trace_mutex);
=20
 	if (attr =3D=3D &dev_attr_enable) {
 		ret =3D sprintf(buf, "%u\n", !!q->blk_trace);
@@ -1689,7 +1733,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct devic=
e *dev,
 		ret =3D sprintf(buf, "%llu\n", q->blk_trace->end_lba);
=20
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&q->blk_trace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
@@ -1731,7 +1775,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct devi=
ce *dev,
 	if (q =3D=3D NULL)
 		goto out_bdput;
=20
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&q->blk_trace_mutex);
=20
 	if (attr =3D=3D &dev_attr_enable) {
 		if (value)
@@ -1757,7 +1801,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct devi=
ce *dev,
 	}
=20
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&q->blk_trace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
diff --git a/lib/int_sqrt.c b/lib/int_sqrt.c
index 1ef4cc344977..1afb545a37c5 100644
--- a/lib/int_sqrt.c
+++ b/lib/int_sqrt.c
@@ -22,6 +22,9 @@ unsigned long int_sqrt(unsigned long x)
 		return x;
=20
 	m =3D 1UL << (BITS_PER_LONG - 2);
+	while (m > x)
+		m >>=3D 2;
+
 	while (m !=3D 0) {
 		b =3D y + m;
 		y >>=3D 1;
diff --git a/net/9p/client.c b/net/9p/client.c
index 1a39a660dd18..90295cc94b82 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -753,8 +753,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const c=
har *fmt, ...)
 	}
 again:
 	/* Wait for the response */
-	err =3D wait_event_interruptible(*req->wq,
-				       req->status >=3D REQ_STATUS_RCVD);
+	err =3D wait_event_killable(*req->wq, req->status >=3D REQ_STATUS_RCVD);
=20
 	/*
 	 * Make sure our req is coherent with regard to updates in other
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 6940d8fe8971..2121d9e5f801 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -292,8 +292,8 @@ p9_virtio_request(struct p9_client *client, struct p9_r=
eq_t *req)
 		if (err =3D=3D -ENOSPC) {
 			chan->ring_bufs_avail =3D 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err =3D wait_event_interruptible(*chan->vc_wq,
-							chan->ring_bufs_avail);
+			err =3D wait_event_killable(*chan->vc_wq,
+						  chan->ring_bufs_avail);
 			if (err  =3D=3D -ERESTARTSYS)
 				return err;
=20
@@ -324,7 +324,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 		 * Other zc request to finish here
 		 */
 		if (atomic_read(&vp_pinned) >=3D chan->p9_max_pages) {
-			err =3D wait_event_interruptible(vp_wq,
+			err =3D wait_event_killable(vp_wq,
 			      (atomic_read(&vp_pinned) < chan->p9_max_pages));
 			if (err =3D=3D -ERESTARTSYS)
 				return err;
@@ -454,8 +454,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p=
9_req_t *req,
 		if (err =3D=3D -ENOSPC) {
 			chan->ring_bufs_avail =3D 0;
 			spin_unlock_irqrestore(&chan->lock, flags);
-			err =3D wait_event_interruptible(*chan->vc_wq,
-						       chan->ring_bufs_avail);
+			err =3D wait_event_killable(*chan->vc_wq,
+						  chan->ring_bufs_avail);
 			if (err  =3D=3D -ERESTARTSYS)
 				goto err_out;
=20
@@ -472,8 +472,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p=
9_req_t *req,
 	virtqueue_kick(chan->vq);
 	spin_unlock_irqrestore(&chan->lock, flags);
 	p9_debug(P9_DEBUG_TRANS, "virtio request kicked\n");
-	err =3D wait_event_interruptible(*req->wq,
-				       req->status >=3D REQ_STATUS_RCVD);
+	err =3D wait_event_killable(*req->wq, req->status >=3D REQ_STATUS_RCVD);
 	/*
 	 * Non kernel buffers are pinned, unpin them
 	 */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0dbc437958ec..3be30519e741 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3349,9 +3349,10 @@ static int l2cap_parse_conf_req(struct l2cap_chan *c=
han, void *data, size_t data
 			break;
=20
 		case L2CAP_CONF_EFS:
-			remote_efs =3D 1;
-			if (olen =3D=3D sizeof(efs))
+			if (olen =3D=3D sizeof(efs)) {
+				remote_efs =3D 1;
 				memcpy(&efs, (void *) val, olen);
+			}
 			break;
=20
 		case L2CAP_CONF_EWS:
@@ -3570,16 +3571,17 @@ static int l2cap_parse_conf_rsp(struct l2cap_chan *=
chan, void *rsp, int len,
 			break;
=20
 		case L2CAP_CONF_EFS:
-			if (olen =3D=3D sizeof(efs))
+			if (olen =3D=3D sizeof(efs)) {
 				memcpy(&efs, (void *)val, olen);
=20
-			if (chan->local_stype !=3D L2CAP_SERV_NOTRAFIC &&
-			    efs.stype !=3D L2CAP_SERV_NOTRAFIC &&
-			    efs.stype !=3D chan->local_stype)
-				return -ECONNREFUSED;
+				if (chan->local_stype !=3D L2CAP_SERV_NOTRAFIC &&
+				    efs.stype !=3D L2CAP_SERV_NOTRAFIC &&
+				    efs.stype !=3D chan->local_stype)
+					return -ECONNREFUSED;
=20
-			l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
-					   (unsigned long) &efs, endptr - ptr);
+				l2cap_add_conf_opt(&ptr, L2CAP_CONF_EFS, sizeof(efs),
+						   (unsigned long) &efs, endptr - ptr);
+			}
 			break;
=20
 		case L2CAP_CONF_FCS:
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d0c1d3781b1d..a7c1d6f798ea 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -623,9 +623,12 @@ static void update_or_create_fnhe(struct fib_nh *nh, _=
_be32 daddr, __be32 gw,
 	struct fnhe_hash_bucket *hash;
 	struct fib_nh_exception *fnhe;
 	struct rtable *rt;
+	u32 genid, hval;
 	unsigned int i;
 	int depth;
-	u32 hval =3D fnhe_hashfun(daddr);
+
+	genid =3D fnhe_genid(dev_net(nh->nh_dev));
+	hval =3D fnhe_hashfun(daddr);
=20
 	spin_lock_bh(&fnhe_lock);
=20
@@ -648,12 +651,13 @@ static void update_or_create_fnhe(struct fib_nh *nh, =
__be32 daddr, __be32 gw,
 	}
=20
 	if (fnhe) {
+		if (fnhe->fnhe_genid !=3D genid)
+			fnhe->fnhe_genid =3D genid;
 		if (gw)
 			fnhe->fnhe_gw =3D gw;
-		if (pmtu) {
+		if (pmtu)
 			fnhe->fnhe_pmtu =3D pmtu;
-			fnhe->fnhe_expires =3D max(1UL, expires);
-		}
+		fnhe->fnhe_expires =3D max(1UL, expires);
 		/* Update all cached dsts too */
 		rt =3D rcu_dereference(fnhe->fnhe_rth_input);
 		if (rt)
@@ -672,7 +676,7 @@ static void update_or_create_fnhe(struct fib_nh *nh, __=
be32 daddr, __be32 gw,
 			fnhe->fnhe_next =3D hash->chain;
 			rcu_assign_pointer(hash->chain, fnhe);
 		}
-		fnhe->fnhe_genid =3D fnhe_genid(dev_net(nh->nh_dev));
+		fnhe->fnhe_genid =3D genid;
 		fnhe->fnhe_daddr =3D daddr;
 		fnhe->fnhe_gw =3D gw;
 		fnhe->fnhe_pmtu =3D pmtu;
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 1f3677610ad7..c79d70b77402 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -370,8 +370,8 @@ struct l2tp_session *l2tp_session_get_by_ifname(const s=
truct net *net,
 }
 EXPORT_SYMBOL_GPL(l2tp_session_get_by_ifname);
=20
-static int l2tp_session_add_to_tunnel(struct l2tp_tunnel *tunnel,
-				      struct l2tp_session *session)
+int l2tp_session_register(struct l2tp_session *session,
+			  struct l2tp_tunnel *tunnel)
 {
 	struct l2tp_session *session_walk;
 	struct hlist_head *g_head;
@@ -419,6 +419,10 @@ static int l2tp_session_add_to_tunnel(struct l2tp_tunn=
el *tunnel,
 	hlist_add_head(&session->hlist, head);
 	write_unlock_bh(&tunnel->hlist_lock);
=20
+	/* Ignore management session in session count value */
+	if (session->session_id !=3D 0)
+		atomic_inc(&l2tp_session_count);
+
 	return 0;
=20
 err_tlock_pnlock:
@@ -428,6 +432,7 @@ static int l2tp_session_add_to_tunnel(struct l2tp_tunne=
l *tunnel,
=20
 	return err;
 }
+EXPORT_SYMBOL_GPL(l2tp_session_register);
=20
 /* Lookup a tunnel by id
  */
@@ -1868,7 +1873,6 @@ EXPORT_SYMBOL_GPL(l2tp_session_set_header_len);
 struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel=
 *tunnel, u32 session_id, u32 peer_session_id, struct l2tp_session_cfg *cfg)
 {
 	struct l2tp_session *session;
-	int err;
=20
 	session =3D kzalloc(sizeof(struct l2tp_session) + priv_size, GFP_KERNEL);
 	if (session !=3D NULL) {
@@ -1926,17 +1930,6 @@ struct l2tp_session *l2tp_session_create(int priv_si=
ze, struct l2tp_tunnel *tunn
=20
 		l2tp_session_inc_refcount(session);
=20
-		err =3D l2tp_session_add_to_tunnel(tunnel, session);
-		if (err) {
-			kfree(session);
-
-			return ERR_PTR(err);
-		}
-
-		/* Ignore management session in session count value */
-		if (session->session_id !=3D 0)
-			atomic_inc(&l2tp_session_count);
-
 		return session;
 	}
=20
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index b56ca9346038..faa2d3e2f9bd 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -274,6 +274,9 @@ struct l2tp_session *l2tp_session_create(int priv_size,
 					 struct l2tp_tunnel *tunnel,
 					 u32 session_id, u32 peer_session_id,
 					 struct l2tp_session_cfg *cfg);
+int l2tp_session_register(struct l2tp_session *session,
+			  struct l2tp_tunnel *tunnel);
+
 void __l2tp_session_unhash(struct l2tp_session *session);
 int l2tp_session_delete(struct l2tp_session *session);
 void l2tp_session_free(struct l2tp_session *session);
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index a719bf9afb04..6355fd449412 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -51,7 +51,7 @@ struct l2tp_eth {
=20
 /* via l2tp_session_priv() */
 struct l2tp_eth_sess {
-	struct net_device	*dev;
+	struct net_device __rcu *dev;
 };
=20
=20
@@ -69,7 +69,14 @@ static int l2tp_eth_dev_init(struct net_device *dev)
=20
 static void l2tp_eth_dev_uninit(struct net_device *dev)
 {
-	dev_put(dev);
+	struct l2tp_eth *priv =3D netdev_priv(dev);
+	struct l2tp_eth_sess *spriv;
+
+	spriv =3D l2tp_session_priv(priv->session);
+	RCU_INIT_POINTER(spriv->dev, NULL);
+	/* No need for synchronize_net() here. We're called by
+	 * unregister_netdev*(), which does the synchronisation for us.
+	 */
 }
=20
 static int l2tp_eth_dev_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -123,8 +130,8 @@ static void l2tp_eth_dev_setup(struct net_device *dev)
 static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff=
 *skb, int data_len)
 {
 	struct l2tp_eth_sess *spriv =3D l2tp_session_priv(session);
-	struct net_device *dev =3D spriv->dev;
-	struct l2tp_eth *priv =3D netdev_priv(dev);
+	struct net_device *dev;
+	struct l2tp_eth *priv;
=20
 	if (session->debug & L2TP_MSG_DATA) {
 		unsigned int length;
@@ -148,16 +155,25 @@ static void l2tp_eth_dev_recv(struct l2tp_session *se=
ssion, struct sk_buff *skb,
 	skb_dst_drop(skb);
 	nf_reset(skb);
=20
+	rcu_read_lock();
+	dev =3D rcu_dereference(spriv->dev);
+	if (!dev)
+		goto error_rcu;
+
+	priv =3D netdev_priv(dev);
 	if (dev_forward_skb(dev, skb) =3D=3D NET_RX_SUCCESS) {
 		atomic_long_inc(&priv->rx_packets);
 		atomic_long_add(data_len, &priv->rx_bytes);
 	} else {
 		atomic_long_inc(&priv->rx_errors);
 	}
+	rcu_read_unlock();
+
 	return;
=20
+error_rcu:
+	rcu_read_unlock();
 error:
-	atomic_long_inc(&priv->rx_errors);
 	kfree_skb(skb);
 }
=20
@@ -168,11 +184,15 @@ static void l2tp_eth_delete(struct l2tp_session *sess=
ion)
=20
 	if (session) {
 		spriv =3D l2tp_session_priv(session);
-		dev =3D spriv->dev;
+
+		rtnl_lock();
+		dev =3D rtnl_dereference(spriv->dev);
 		if (dev) {
-			unregister_netdev(dev);
-			spriv->dev =3D NULL;
+			unregister_netdevice(dev);
+			rtnl_unlock();
 			module_put(THIS_MODULE);
+		} else {
+			rtnl_unlock();
 		}
 	}
 }
@@ -182,9 +202,20 @@ static void l2tp_eth_show(struct seq_file *m, void *ar=
g)
 {
 	struct l2tp_session *session =3D arg;
 	struct l2tp_eth_sess *spriv =3D l2tp_session_priv(session);
-	struct net_device *dev =3D spriv->dev;
+	struct net_device *dev;
+
+	rcu_read_lock();
+	dev =3D rcu_dereference(spriv->dev);
+	if (!dev) {
+		rcu_read_unlock();
+		return;
+	}
+	dev_hold(dev);
+	rcu_read_unlock();
=20
 	seq_printf(m, "   interface %s\n", dev->name);
+
+	dev_put(dev);
 }
 #endif
=20
@@ -204,7 +235,7 @@ static int l2tp_eth_create(struct net *net, struct l2tp=
_tunnel *tunnel,
 		if (dev) {
 			dev_put(dev);
 			rc =3D -EEXIST;
-			goto out;
+			goto err;
 		}
 		strlcpy(name, cfg->ifname, IFNAMSIZ);
 	} else
@@ -214,13 +245,13 @@ static int l2tp_eth_create(struct net *net, struct l2=
tp_tunnel *tunnel,
 				      peer_session_id, cfg);
 	if (IS_ERR(session)) {
 		rc =3D PTR_ERR(session);
-		goto out;
+		goto err;
 	}
=20
 	dev =3D alloc_netdev(sizeof(*priv), name, l2tp_eth_dev_setup);
 	if (!dev) {
 		rc =3D -ENOMEM;
-		goto out_del_session;
+		goto err_sess;
 	}
=20
 	dev_net_set(dev, net);
@@ -241,26 +272,48 @@ static int l2tp_eth_create(struct net *net, struct l2=
tp_tunnel *tunnel,
 #endif
=20
 	spriv =3D l2tp_session_priv(session);
-	spriv->dev =3D dev;
=20
-	rc =3D register_netdev(dev);
-	if (rc < 0)
-		goto out_del_dev;
+	l2tp_session_inc_refcount(session);
+
+	rtnl_lock();
+
+	/* Register both device and session while holding the rtnl lock. This
+	 * ensures that l2tp_eth_delete() will see that there's a device to
+	 * unregister, even if it happened to run before we assign spriv->dev.
+	 */
+	rc =3D l2tp_session_register(session, tunnel);
+	if (rc < 0) {
+		rtnl_unlock();
+		goto err_sess_dev;
+	}
+
+	rc =3D register_netdevice(dev);
+	if (rc < 0) {
+		rtnl_unlock();
+		l2tp_session_delete(session);
+		l2tp_session_dec_refcount(session);
+		free_netdev(dev);
+
+		return rc;
+	}
=20
-	__module_get(THIS_MODULE);
-	/* Must be done after register_netdev() */
 	strlcpy(session->ifname, dev->name, IFNAMSIZ);
+	rcu_assign_pointer(spriv->dev, dev);
=20
-	dev_hold(dev);
+	rtnl_unlock();
+
+	l2tp_session_dec_refcount(session);
+
+	__module_get(THIS_MODULE);
=20
 	return 0;
=20
-out_del_dev:
+err_sess_dev:
+	l2tp_session_dec_refcount(session);
 	free_netdev(dev);
-	spriv->dev =3D NULL;
-out_del_session:
-	l2tp_session_delete(session);
-out:
+err_sess:
+	kfree(session);
+err:
 	return rc;
 }
=20
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 22d74e6b6461..8d6e261704df 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -122,8 +122,11 @@
 struct pppol2tp_session {
 	int			owner;		/* pid that opened the socket */
=20
-	struct sock		*sock;		/* Pointer to the session
+	struct mutex		sk_lock;	/* Protects .sk */
+	struct sock __rcu	*sk;		/* Pointer to the session
 						 * PPPoX socket */
+	struct sock		*__sk;		/* Copy of .sk, for cleanup */
+	struct rcu_head		rcu;		/* For asynchronous release */
 	struct sock		*tunnel_sock;	/* Pointer to the tunnel UDP
 						 * socket */
 	int			flags;		/* accessed by PPPIOCGFLAGS.
@@ -138,6 +141,24 @@ static const struct ppp_channel_ops pppol2tp_chan_ops =
=3D {
=20
 static const struct proto_ops pppol2tp_ops;
=20
+/* Retrieves the pppol2tp socket associated to a session.
+ * A reference is held on the returned socket, so this function must be pa=
ired
+ * with sock_put().
+ */
+static struct sock *pppol2tp_session_get_sock(struct l2tp_session *session)
+{
+	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
+	struct sock *sk;
+
+	rcu_read_lock();
+	sk =3D rcu_dereference(ps->sk);
+	if (sk)
+		sock_hold(sk);
+	rcu_read_unlock();
+
+	return sk;
+}
+
 /* Helpers to obtain tunnel/session contexts from sockets.
  */
 static inline struct l2tp_session *pppol2tp_sock_to_session(struct sock *s=
k)
@@ -225,7 +246,8 @@ static void pppol2tp_recv(struct l2tp_session *session,=
 struct sk_buff *skb, int
 	/* If the socket is bound, send it in to PPP's input queue. Otherwise
 	 * queue it on the session socket.
 	 */
-	sk =3D ps->sock;
+	rcu_read_lock();
+	sk =3D rcu_dereference(ps->sk);
 	if (sk =3D=3D NULL)
 		goto no_sock;
=20
@@ -263,30 +285,16 @@ static void pppol2tp_recv(struct l2tp_session *sessio=
n, struct sk_buff *skb, int
 			kfree_skb(skb);
 		}
 	}
+	rcu_read_unlock();
=20
 	return;
=20
 no_sock:
+	rcu_read_unlock();
 	l2tp_info(session, PPPOL2TP_MSG_DATA, "%s: no socket\n", session->name);
 	kfree_skb(skb);
 }
=20
-static void pppol2tp_session_sock_hold(struct l2tp_session *session)
-{
-	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
-
-	if (ps->sock)
-		sock_hold(ps->sock);
-}
-
-static void pppol2tp_session_sock_put(struct l2tp_session *session)
-{
-	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
-
-	if (ps->sock)
-		sock_put(ps->sock);
-}
-
 /************************************************************************
  * Transmit handling
  ***********************************************************************/
@@ -450,16 +458,15 @@ static int pppol2tp_xmit(struct ppp_channel *chan, st=
ruct sk_buff *skb)
  */
 static void pppol2tp_session_close(struct l2tp_session *session)
 {
-	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
-	struct sock *sk =3D ps->sock;
-	struct socket *sock =3D sk->sk_socket;
+	struct sock *sk;
=20
 	BUG_ON(session->magic !=3D L2TP_SESSION_MAGIC);
=20
-	if (sock) {
-		inet_shutdown(sock, 2);
-		/* Don't let the session go away before our socket does */
-		l2tp_session_inc_refcount(session);
+	sk =3D pppol2tp_session_get_sock(session);
+	if (sk) {
+		if (sk->sk_socket)
+			inet_shutdown(sk->sk_socket, SEND_SHUTDOWN);
+		sock_put(sk);
 	}
 }
=20
@@ -480,6 +487,14 @@ static void pppol2tp_session_destruct(struct sock *sk)
 	}
 }
=20
+static void pppol2tp_put_sk(struct rcu_head *head)
+{
+	struct pppol2tp_session *ps;
+
+	ps =3D container_of(head, typeof(*ps), rcu);
+	sock_put(ps->__sk);
+}
+
 /* Called when the PPPoX socket (session) is closed.
  */
 static int pppol2tp_release(struct socket *sock)
@@ -505,11 +520,23 @@ static int pppol2tp_release(struct socket *sock)
=20
 	session =3D pppol2tp_sock_to_session(sk);
=20
-	/* Purge any queued data */
 	if (session !=3D NULL) {
-		__l2tp_session_unhash(session);
-		l2tp_session_queue_purge(session);
-		sock_put(sk);
+		struct pppol2tp_session *ps;
+
+		l2tp_session_delete(session);
+
+		ps =3D l2tp_session_priv(session);
+		mutex_lock(&ps->sk_lock);
+		ps->__sk =3D rcu_dereference_protected(ps->sk,
+						     lockdep_is_held(&ps->sk_lock));
+		RCU_INIT_POINTER(ps->sk, NULL);
+		mutex_unlock(&ps->sk_lock);
+		call_rcu(&ps->rcu, pppol2tp_put_sk);
+
+		/* Rely on the sock_put() call at the end of the function for
+		 * dropping the reference held by pppol2tp_sock_to_session().
+		 * The last reference will be dropped by pppol2tp_put_sk().
+		 */
 	}
 	release_sock(sk);
=20
@@ -576,16 +603,47 @@ static int pppol2tp_create(struct net *net, struct so=
cket *sock)
 static void pppol2tp_show(struct seq_file *m, void *arg)
 {
 	struct l2tp_session *session =3D arg;
-	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
+	struct sock *sk;
+
+	sk =3D pppol2tp_session_get_sock(session);
+	if (sk) {
+		struct pppox_sock *po =3D pppox_sk(sk);
=20
-	if (ps) {
-		struct pppox_sock *po =3D pppox_sk(ps->sock);
-		if (po)
-			seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
+		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
+		sock_put(sk);
 	}
 }
 #endif
=20
+static void pppol2tp_session_init(struct l2tp_session *session)
+{
+	struct pppol2tp_session *ps;
+	struct dst_entry *dst;
+
+	session->recv_skb =3D pppol2tp_recv;
+	session->session_close =3D pppol2tp_session_close;
+#if IS_ENABLED(CONFIG_L2TP_DEBUGFS)
+	session->show =3D pppol2tp_show;
+#endif
+
+	ps =3D l2tp_session_priv(session);
+	mutex_init(&ps->sk_lock);
+	ps->tunnel_sock =3D session->tunnel->sock;
+	ps->owner =3D current->pid;
+
+	/* If PMTU discovery was enabled, use the MTU that was discovered */
+	dst =3D sk_dst_get(session->tunnel->sock);
+	if (dst) {
+		u32 pmtu =3D dst_mtu(dst);
+
+		if (pmtu) {
+			session->mtu =3D pmtu - PPPOL2TP_HEADER_OVERHEAD;
+			session->mru =3D pmtu - PPPOL2TP_HEADER_OVERHEAD;
+		}
+		dst_release(dst);
+	}
+}
+
 /* connect() handler. Attach a PPPoX socket to a tunnel UDP socket
  */
 static int pppol2tp_connect(struct socket *sock, struct sockaddr *uservadd=
r,
@@ -597,7 +655,6 @@ static int pppol2tp_connect(struct socket *sock, struct=
 sockaddr *uservaddr,
 	struct l2tp_session *session =3D NULL;
 	struct l2tp_tunnel *tunnel;
 	struct pppol2tp_session *ps;
-	struct dst_entry *dst;
 	struct l2tp_session_cfg cfg =3D { 0, };
 	int error =3D 0;
 	u32 tunnel_id, peer_tunnel_id;
@@ -715,13 +772,17 @@ static int pppol2tp_connect(struct socket *sock, stru=
ct sockaddr *uservaddr,
 		/* Using a pre-existing session is fine as long as it hasn't
 		 * been connected yet.
 		 */
-		if (ps->sock) {
+		mutex_lock(&ps->sk_lock);
+		if (rcu_dereference_protected(ps->sk,
+					      lockdep_is_held(&ps->sk_lock))) {
+			mutex_unlock(&ps->sk_lock);
 			error =3D -EEXIST;
 			goto end;
 		}
=20
 		/* consistency checks */
 		if (ps->tunnel_sock !=3D tunnel->sock) {
+			mutex_unlock(&ps->sk_lock);
 			error =3D -EEXIST;
 			goto end;
 		}
@@ -737,35 +798,19 @@ static int pppol2tp_connect(struct socket *sock, stru=
ct sockaddr *uservaddr,
 			error =3D PTR_ERR(session);
 			goto end;
 		}
-	}
-
-	/* Associate session with its PPPoL2TP socket */
-	ps =3D l2tp_session_priv(session);
-	ps->owner	     =3D current->pid;
-	ps->sock	     =3D sk;
-	ps->tunnel_sock =3D tunnel->sock;
-
-	session->recv_skb	=3D pppol2tp_recv;
-	session->session_close	=3D pppol2tp_session_close;
-#if defined(CONFIG_L2TP_DEBUGFS) || defined(CONFIG_L2TP_DEBUGFS_MODULE)
-	session->show		=3D pppol2tp_show;
-#endif
=20
-	/* We need to know each time a skb is dropped from the reorder
-	 * queue.
-	 */
-	session->ref =3D pppol2tp_session_sock_hold;
-	session->deref =3D pppol2tp_session_sock_put;
-
-	/* If PMTU discovery was enabled, use the MTU that was discovered */
-	dst =3D sk_dst_get(tunnel->sock);
-	if (dst !=3D NULL) {
-		u32 pmtu =3D dst_mtu(dst);
+		pppol2tp_session_init(session);
+		ps =3D l2tp_session_priv(session);
+		l2tp_session_inc_refcount(session);
=20
-		if (pmtu !=3D 0)
-			session->mtu =3D session->mru =3D pmtu -
-				PPPOL2TP_HEADER_OVERHEAD;
-		dst_release(dst);
+		mutex_lock(&ps->sk_lock);
+		error =3D l2tp_session_register(session, tunnel);
+		if (error < 0) {
+			mutex_unlock(&ps->sk_lock);
+			kfree(session);
+			goto end;
+		}
+		drop_refcnt =3D true;
 	}
=20
 	/* Special case: if source & dest session_id =3D=3D 0x0000, this
@@ -790,12 +835,23 @@ static int pppol2tp_connect(struct socket *sock, stru=
ct sockaddr *uservaddr,
 	po->chan.mtu	 =3D session->mtu;
=20
 	error =3D ppp_register_net_channel(sock_net(sk), &po->chan);
-	if (error)
+	if (error) {
+		mutex_unlock(&ps->sk_lock);
 		goto end;
+	}
=20
 out_no_ppp:
 	/* This is how we get the session context from the socket. */
 	sk->sk_user_data =3D session;
+	rcu_assign_pointer(ps->sk, sk);
+	mutex_unlock(&ps->sk_lock);
+
+	/* Keep the reference we've grabbed on the session: sk doesn't expect
+	 * the session to disappear. pppol2tp_session_destruct() is responsible
+	 * for dropping it.
+	 */
+	drop_refcnt =3D false;
+
 	sk->sk_state =3D PPPOX_CONNECTED;
 	l2tp_info(session, PPPOL2TP_MSG_CONTROL, "%s: created\n",
 		  session->name);
@@ -819,12 +875,11 @@ static int pppol2tp_session_create(struct net *net, s=
truct l2tp_tunnel *tunnel,
 {
 	int error;
 	struct l2tp_session *session;
-	struct pppol2tp_session *ps;
=20
 	/* Error if tunnel socket is not prepped */
 	if (!tunnel->sock) {
 		error =3D -ENOENT;
-		goto out;
+		goto err;
 	}
=20
 	/* Default MTU values. */
@@ -839,18 +894,20 @@ static int pppol2tp_session_create(struct net *net, s=
truct l2tp_tunnel *tunnel,
 				      peer_session_id, cfg);
 	if (IS_ERR(session)) {
 		error =3D PTR_ERR(session);
-		goto out;
+		goto err;
 	}
=20
-	ps =3D l2tp_session_priv(session);
-	ps->tunnel_sock =3D tunnel->sock;
+	pppol2tp_session_init(session);
=20
-	l2tp_info(session, PPPOL2TP_MSG_CONTROL, "%s: created\n",
-		  session->name);
+	error =3D l2tp_session_register(session, tunnel);
+	if (error < 0)
+		goto err_sess;
=20
-	error =3D 0;
+	return 0;
=20
-out:
+err_sess:
+	kfree(session);
+err:
 	return error;
 }
=20
@@ -1011,12 +1068,10 @@ static int pppol2tp_session_ioctl(struct l2tp_sessi=
on *session,
 		 "%s: pppol2tp_session_ioctl(cmd=3D%#x, arg=3D%#lx)\n",
 		 session->name, cmd, arg);
=20
-	sk =3D ps->sock;
+	sk =3D pppol2tp_session_get_sock(session);
 	if (!sk)
 		return -EBADR;
=20
-	sock_hold(sk);
-
 	switch (cmd) {
 	case SIOCGIFMTU:
 		err =3D -ENXIO;
@@ -1292,7 +1347,6 @@ static int pppol2tp_session_setsockopt(struct sock *s=
k,
 				       int optname, int val)
 {
 	int err =3D 0;
-	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
=20
 	switch (optname) {
 	case PPPOL2TP_SO_RECVSEQ:
@@ -1313,8 +1367,8 @@ static int pppol2tp_session_setsockopt(struct sock *s=
k,
 		}
 		session->send_seq =3D val ? -1 : 0;
 		{
-			struct sock *ssk      =3D ps->sock;
-			struct pppox_sock *po =3D pppox_sk(ssk);
+			struct pppox_sock *po =3D pppox_sk(sk);
+
 			po->chan.hdrlen =3D val ? PPPOL2TP_L2TP_HDR_SIZE_SEQ :
 				PPPOL2TP_L2TP_HDR_SIZE_NOSEQ;
 		}
@@ -1653,8 +1707,9 @@ static void pppol2tp_seq_session_show(struct seq_file=
 *m, void *v)
 {
 	struct l2tp_session *session =3D v;
 	struct l2tp_tunnel *tunnel =3D session->tunnel;
-	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
-	struct pppox_sock *po =3D pppox_sk(ps->sock);
+	unsigned char state;
+	char user_data_ok;
+	struct sock *sk;
 	u32 ip =3D 0;
 	u16 port =3D 0;
=20
@@ -1664,6 +1719,15 @@ static void pppol2tp_seq_session_show(struct seq_fil=
e *m, void *v)
 		port =3D ntohs(inet->inet_sport);
 	}
=20
+	sk =3D pppol2tp_session_get_sock(session);
+	if (sk) {
+		state =3D sk->sk_state;
+		user_data_ok =3D (session =3D=3D sk->sk_user_data) ? 'Y' : 'N';
+	} else {
+		state =3D 0;
+		user_data_ok =3D 'N';
+	}
+
 	seq_printf(m, "  SESSION '%s' %08X/%d %04X/%04X -> "
 		   "%04X/%04X %d %c\n",
 		   session->name, ip, port,
@@ -1671,9 +1735,7 @@ static void pppol2tp_seq_session_show(struct seq_file=
 *m, void *v)
 		   session->session_id,
 		   tunnel->peer_tunnel_id,
 		   session->peer_session_id,
-		   ps->sock->sk_state,
-		   (session =3D=3D ps->sock->sk_user_data) ?
-		   'Y' : 'N');
+		   state, user_data_ok);
 	seq_printf(m, "   %d/%d/%c/%c/%s %08x %u\n",
 		   session->mtu, session->mru,
 		   session->recv_seq ? 'R' : '-',
@@ -1690,8 +1752,12 @@ static void pppol2tp_seq_session_show(struct seq_fil=
e *m, void *v)
 		   atomic_long_read(&session->stats.rx_bytes),
 		   atomic_long_read(&session->stats.rx_errors));
=20
-	if (po)
+	if (sk) {
+		struct pppox_sock *po =3D pppox_sk(sk);
+
 		seq_printf(m, "   interface %s\n", ppp_dev_name(&po->chan));
+		sock_put(sk);
+	}
 }
=20
 static int pppol2tp_seq_show(struct seq_file *m, void *v)
diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
index e762de5ee89b..6531d7039b11 100644
--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -104,7 +104,7 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	tcph =3D (struct tcphdr *)(skb_network_header(skb) + tcphoff);
 	tcp_hdrlen =3D tcph->doff * 4;
=20
-	if (len < tcp_hdrlen)
+	if (len < tcp_hdrlen || tcp_hdrlen < sizeof(struct tcphdr))
 		return -1;
=20
 	if (info->mss =3D=3D XT_TCPMSS_CLAMP_PMTU) {
@@ -156,6 +156,10 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	if (len > tcp_hdrlen)
 		return 0;
=20
+	/* tcph->doff has 4 bits, do not wrap it to 0 */
+	if (tcp_hdrlen >=3D 15 * 4)
+		return 0;
+
 	/*
 	 * MSS Option not found ?! add it..
 	 */
diff --git a/net/nfc/core.c b/net/nfc/core.c
index 2ff3c924b64f..a8e8756878de 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -1074,7 +1074,7 @@ struct nfc_dev *nfc_allocate_device(struct nfc_ops *o=
ps,
 err_free_dev:
 	kfree(dev);
=20
-	return ERR_PTR(rc);
+	return NULL;
 }
 EXPORT_SYMBOL(nfc_allocate_device);
=20
diff --git a/net/rds/rdma.c b/net/rds/rdma.c
index 4e37c1cbe8b2..6fcd65a923ea 100644
--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -516,6 +516,9 @@ int rds_rdma_extra_size(struct rds_rdma_args *args)
=20
 	local_vec =3D (struct rds_iovec __user *)(unsigned long) args->local_vec_=
addr;
=20
+	if (args->nr_local =3D=3D 0)
+		return -EINVAL;
+
 	/* figure out the number of pages in the vector */
 	for (i =3D 0; i < args->nr_local; i++) {
 		if (copy_from_user(&vec, &local_vec[i],
@@ -852,6 +855,7 @@ int rds_cmsg_atomic(struct rds_sock *rs, struct rds_mes=
sage *rm,
 err:
 	if (page)
 		put_page(page);
+	rm->atomic.op_active =3D 0;
 	kfree(rm->atomic.op_notifier);
=20
 	return ret;
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 7f47fbdeb414..4128c0d7f845 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -434,7 +434,7 @@ static void sctp_v6_from_sk(union sctp_addr *addr, stru=
ct sock *sk)
 /* Initialize sk->sk_rcv_saddr from sctp_addr. */
 static void sctp_v6_to_sk_saddr(union sctp_addr *addr, struct sock *sk)
 {
-	if (addr->sa.sa_family =3D=3D AF_INET && sctp_sk(sk)->v4mapped) {
+	if (addr->sa.sa_family =3D=3D AF_INET) {
 		sk->sk_v6_rcv_saddr.s6_addr32[0] =3D 0;
 		sk->sk_v6_rcv_saddr.s6_addr32[1] =3D 0;
 		sk->sk_v6_rcv_saddr.s6_addr32[2] =3D htonl(0x0000ffff);
@@ -448,7 +448,7 @@ static void sctp_v6_to_sk_saddr(union sctp_addr *addr, =
struct sock *sk)
 /* Initialize sk->sk_daddr from sctp_addr. */
 static void sctp_v6_to_sk_daddr(union sctp_addr *addr, struct sock *sk)
 {
-	if (addr->sa.sa_family =3D=3D AF_INET && sctp_sk(sk)->v4mapped) {
+	if (addr->sa.sa_family =3D=3D AF_INET) {
 		sk->sk_v6_daddr.s6_addr32[0] =3D 0;
 		sk->sk_v6_daddr.s6_addr32[1] =3D 0;
 		sk->sk_v6_daddr.s6_addr32[2] =3D htonl(0x0000ffff);
@@ -491,7 +491,9 @@ static void sctp_v6_to_addr(union sctp_addr *addr, stru=
ct in6_addr *saddr,
 {
 	addr->sa.sa_family =3D AF_INET6;
 	addr->v6.sin6_port =3D port;
+	addr->v6.sin6_flowinfo =3D 0;
 	addr->v6.sin6_addr =3D *saddr;
+	addr->v6.sin6_scope_id =3D 0;
 }
=20
 /* Compare addresses exactly.
@@ -558,8 +560,6 @@ static int sctp_v6_available(union sctp_addr *addr, str=
uct sctp_sock *sp)
 	if (IPV6_ADDR_ANY =3D=3D type)
 		return 1;
 	if (type =3D=3D IPV6_ADDR_MAPPED) {
-		if (sp && !sp->v4mapped)
-			return 0;
 		if (sp && ipv6_only_sock(sctp_opt2sk(sp)))
 			return 0;
 		sctp_v6_map_v4(addr);
@@ -589,8 +589,6 @@ static int sctp_v6_addr_valid(union sctp_addr *addr,
 		/* Note: This routine is used in input, so v4-mapped-v6
 		 * are disallowed here when there is no sctp_sock.
 		 */
-		if (!sp || !sp->v4mapped)
-			return 0;
 		if (sp && ipv6_only_sock(sctp_opt2sk(sp)))
 			return 0;
 		sctp_v6_map_v4(addr);
@@ -688,11 +686,23 @@ static struct sock *sctp_v6_create_accept_sk(struct s=
ock *sk,
 	return newsk;
 }
=20
-/* Map v4 address to mapped v6 address */
-static void sctp_v6_addr_v4map(struct sctp_sock *sp, union sctp_addr *addr)
+/* Format a sockaddr for return to user space. This makes sure the return =
is
+ * AF_INET or AF_INET6 depending on the SCTP_I_WANT_MAPPED_V4_ADDR option.
+ */
+static int sctp_v6_addr_to_user(struct sctp_sock *sp, union sctp_addr *add=
r)
 {
-	if (sp->v4mapped && AF_INET =3D=3D addr->sa.sa_family)
-		sctp_v4_map_v6(addr);
+	if (sp->v4mapped) {
+		if (addr->sa.sa_family =3D=3D AF_INET)
+			sctp_v4_map_v6(addr);
+	} else {
+		if (addr->sa.sa_family =3D=3D AF_INET6 &&
+		    ipv6_addr_v4mapped(&addr->v6.sin6_addr))
+			sctp_v6_map_v4(addr);
+	}
+
+	if (addr->sa.sa_family =3D=3D AF_INET)
+		return sizeof(struct sockaddr_in);
+	return sizeof(struct sockaddr_in6);
 }
=20
 /* Where did this skb come from?  */
@@ -719,82 +729,70 @@ static void sctp_v6_ecn_capable(struct sock *sk)
 	inet6_sk(sk)->tclass |=3D INET_ECN_ECT_0;
 }
=20
-/* Initialize a PF_INET6 socket msg_name. */
-static void sctp_inet6_msgname(char *msgname, int *addr_len)
-{
-	struct sockaddr_in6 *sin6;
-
-	sin6 =3D (struct sockaddr_in6 *)msgname;
-	sin6->sin6_family =3D AF_INET6;
-	sin6->sin6_flowinfo =3D 0;
-	sin6->sin6_scope_id =3D 0; /*FIXME */
-	*addr_len =3D sizeof(struct sockaddr_in6);
-}
-
 /* Initialize a PF_INET msgname from a ulpevent. */
 static void sctp_inet6_event_msgname(struct sctp_ulpevent *event,
 				     char *msgname, int *addrlen)
 {
-	struct sockaddr_in6 *sin6, *sin6from;
-
-	if (msgname) {
-		union sctp_addr *addr;
-		struct sctp_association *asoc;
-
-		asoc =3D event->asoc;
-		sctp_inet6_msgname(msgname, addrlen);
-		sin6 =3D (struct sockaddr_in6 *)msgname;
-		sin6->sin6_port =3D htons(asoc->peer.port);
-		addr =3D &asoc->peer.primary_addr;
+	union sctp_addr *addr;
+	struct sctp_association *asoc;
+	union sctp_addr *paddr;
=20
-		/* Note: If we go to a common v6 format, this code
-		 * will change.
-		 */
+	if (!msgname)
+		return;
=20
-		/* Map ipv4 address into v4-mapped-on-v6 address.  */
-		if (sctp_sk(asoc->base.sk)->v4mapped &&
-		    AF_INET =3D=3D addr->sa.sa_family) {
-			sctp_v4_map_v6((union sctp_addr *)sin6);
-			sin6->sin6_addr.s6_addr32[3] =3D
-				addr->v4.sin_addr.s_addr;
-			return;
-		}
+	addr =3D (union sctp_addr *)msgname;
+	asoc =3D event->asoc;
+	paddr =3D &asoc->peer.primary_addr;
=20
-		sin6from =3D &asoc->peer.primary_addr.v6;
-		sin6->sin6_addr =3D sin6from->sin6_addr;
-		if (ipv6_addr_type(&sin6->sin6_addr) & IPV6_ADDR_LINKLOCAL)
-			sin6->sin6_scope_id =3D sin6from->sin6_scope_id;
+	if (paddr->sa.sa_family =3D=3D AF_INET) {
+		addr->v4.sin_family =3D AF_INET;
+		addr->v4.sin_port =3D htons(asoc->peer.port);
+		addr->v4.sin_addr =3D paddr->v4.sin_addr;
+	} else {
+		addr->v6.sin6_family =3D AF_INET6;
+		addr->v6.sin6_flowinfo =3D 0;
+		if (ipv6_addr_type(&paddr->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL)
+			addr->v6.sin6_scope_id =3D paddr->v6.sin6_scope_id;
+		else
+			addr->v6.sin6_scope_id =3D 0;
+		addr->v6.sin6_port =3D htons(asoc->peer.port);
+		addr->v6.sin6_addr =3D paddr->v6.sin6_addr;
 	}
+
+	*addrlen =3D sctp_v6_addr_to_user(sctp_sk(asoc->base.sk), addr);
 }
=20
 /* Initialize a msg_name from an inbound skb. */
 static void sctp_inet6_skb_msgname(struct sk_buff *skb, char *msgname,
 				   int *addr_len)
 {
+	union sctp_addr *addr;
 	struct sctphdr *sh;
-	struct sockaddr_in6 *sin6;
-
-	if (msgname) {
-		sctp_inet6_msgname(msgname, addr_len);
-		sin6 =3D (struct sockaddr_in6 *)msgname;
-		sh =3D sctp_hdr(skb);
-		sin6->sin6_port =3D sh->source;
-
-		/* Map ipv4 address into v4-mapped-on-v6 address. */
-		if (sctp_sk(skb->sk)->v4mapped &&
-		    ip_hdr(skb)->version =3D=3D 4) {
-			sctp_v4_map_v6((union sctp_addr *)sin6);
-			sin6->sin6_addr.s6_addr32[3] =3D ip_hdr(skb)->saddr;
-			return;
-		}
=20
-		/* Otherwise, just copy the v6 address. */
-		sin6->sin6_addr =3D ipv6_hdr(skb)->saddr;
-		if (ipv6_addr_type(&sin6->sin6_addr) & IPV6_ADDR_LINKLOCAL) {
+	if (!msgname)
+		return;
+
+	addr =3D (union sctp_addr *)msgname;
+	sh =3D sctp_hdr(skb);
+
+	if (ip_hdr(skb)->version =3D=3D 4) {
+		addr->v4.sin_family =3D AF_INET;
+		addr->v4.sin_port =3D sh->source;
+		addr->v4.sin_addr.s_addr =3D  ip_hdr(skb)->saddr;
+	} else {
+		addr->v6.sin6_family =3D AF_INET6;
+		addr->v6.sin6_flowinfo =3D 0;
+		addr->v6.sin6_port =3D sh->source;
+		addr->v6.sin6_addr =3D ipv6_hdr(skb)->saddr;
+		if (ipv6_addr_type(&addr->v6.sin6_addr) & IPV6_ADDR_LINKLOCAL) {
 			struct sctp_ulpevent *ev =3D sctp_skb2event(skb);
-			sin6->sin6_scope_id =3D ev->iif;
+			addr->v6.sin6_scope_id =3D ev->iif;
+		} else {
+			addr->v6.sin6_scope_id =3D 0;
 		}
 	}
+
+	*addr_len =3D sctp_v6_addr_to_user(sctp_sk(skb->sk), addr);
 }
=20
 /* Do we support this AF? */
@@ -870,9 +868,6 @@ static int sctp_inet6_bind_verify(struct sctp_sock *opt=
, union sctp_addr *addr)
 				return 0;
 			}
 			rcu_read_unlock();
-		} else if (type =3D=3D IPV6_ADDR_MAPPED) {
-			if (!opt->v4mapped)
-				return 0;
 		}
=20
 		af =3D opt->pf->af;
@@ -927,6 +922,23 @@ static int sctp_inet6_supported_addrs(const struct sct=
p_sock *opt,
 	return 1;
 }
=20
+/* Handle SCTP_I_WANT_MAPPED_V4_ADDR for getpeername() and getsockname() */
+static int sctp_getname(struct socket *sock, struct sockaddr *uaddr,
+			int *uaddr_len, int peer)
+{
+	int rc;
+
+	rc =3D inet6_getname(sock, uaddr, uaddr_len, peer);
+
+	if (rc !=3D 0)
+		return rc;
+
+	*uaddr_len =3D sctp_v6_addr_to_user(sctp_sk(sock->sk),
+					  (union sctp_addr *)uaddr);
+
+	return rc;
+}
+
 static const struct proto_ops inet6_seqpacket_ops =3D {
 	.family		   =3D PF_INET6,
 	.owner		   =3D THIS_MODULE,
@@ -935,7 +947,7 @@ static const struct proto_ops inet6_seqpacket_ops =3D {
 	.connect	   =3D inet_dgram_connect,
 	.socketpair	   =3D sock_no_socketpair,
 	.accept		   =3D inet_accept,
-	.getname	   =3D inet6_getname,
+	.getname	   =3D sctp_getname,
 	.poll		   =3D sctp_poll,
 	.ioctl		   =3D inet6_ioctl,
 	.listen		   =3D sctp_inet_listen,
@@ -987,8 +999,6 @@ static struct sctp_af sctp_af_inet6 =3D {
 	.copy_addrlist	   =3D sctp_v6_copy_addrlist,
 	.from_skb	   =3D sctp_v6_from_skb,
 	.from_sk	   =3D sctp_v6_from_sk,
-	.to_sk_saddr	   =3D sctp_v6_to_sk_saddr,
-	.to_sk_daddr	   =3D sctp_v6_to_sk_daddr,
 	.from_addr_param   =3D sctp_v6_from_addr_param,
 	.to_addr_param	   =3D sctp_v6_to_addr_param,
 	.cmp_addr	   =3D sctp_v6_cmp_addr,
@@ -1018,7 +1028,9 @@ static struct sctp_pf sctp_pf_inet6 =3D {
 	.send_verify   =3D sctp_inet6_send_verify,
 	.supported_addrs =3D sctp_inet6_supported_addrs,
 	.create_accept_sk =3D sctp_v6_create_accept_sk,
-	.addr_v4map    =3D sctp_v6_addr_v4map,
+	.addr_to_user  =3D sctp_v6_addr_to_user,
+	.to_sk_saddr   =3D sctp_v6_to_sk_saddr,
+	.to_sk_daddr   =3D sctp_v6_to_sk_daddr,
 	.af            =3D &sctp_af_inet6,
 };
=20
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index c143f74a25b9..eccd9ebc5ebd 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -578,10 +578,10 @@ static struct sock *sctp_v4_create_accept_sk(struct s=
ock *sk,
 	return newsk;
 }
=20
-/* Map address, empty for v4 family */
-static void sctp_v4_addr_v4map(struct sctp_sock *sp, union sctp_addr *addr)
+static int sctp_v4_addr_to_user(struct sctp_sock *sp, union sctp_addr *add=
r)
 {
-	/* Empty */
+	/* No address mapping for V4 sockets */
+	return sizeof(struct sockaddr_in);
 }
=20
 /* Dump the v4 addr to the seq file. */
@@ -978,7 +978,9 @@ static struct sctp_pf sctp_pf_inet =3D {
 	.send_verify   =3D sctp_inet_send_verify,
 	.supported_addrs =3D sctp_inet_supported_addrs,
 	.create_accept_sk =3D sctp_v4_create_accept_sk,
-	.addr_v4map	=3D sctp_v4_addr_v4map,
+	.addr_to_user  =3D sctp_v4_addr_to_user,
+	.to_sk_saddr   =3D sctp_v4_to_sk_saddr,
+	.to_sk_daddr   =3D sctp_v4_to_sk_daddr,
 	.af            =3D &sctp_af_inet
 };
=20
@@ -1049,8 +1051,6 @@ static struct sctp_af sctp_af_inet =3D {
 	.copy_addrlist	   =3D sctp_v4_copy_addrlist,
 	.from_skb	   =3D sctp_v4_from_skb,
 	.from_sk	   =3D sctp_v4_from_sk,
-	.to_sk_saddr	   =3D sctp_v4_to_sk_saddr,
-	.to_sk_daddr	   =3D sctp_v4_to_sk_daddr,
 	.from_addr_param   =3D sctp_v4_from_addr_param,
 	.to_addr_param	   =3D sctp_v4_to_addr_param,
 	.cmp_addr	   =3D sctp_v4_cmp_addr,
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index b0f068937260..6785522788f0 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -254,7 +254,7 @@ static struct sctp_transport *sctp_addr_id2transport(st=
ruct sock *sk,
 	if (id_asoc && (id_asoc !=3D addr_asoc))
 		return NULL;
=20
-	sctp_get_pf_specific(sk->sk_family)->addr_v4map(sctp_sk(sk),
+	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sctp_sk(sk),
 						(union sctp_addr *)addr);
=20
 	return transport;
@@ -396,7 +396,7 @@ static int sctp_do_bind(struct sock *sk, union sctp_add=
r *addr, int len)
 	/* Copy back into socket for getsockname() use. */
 	if (!ret) {
 		inet_sk(sk)->inet_sport =3D htons(inet_sk(sk)->inet_num);
-		af->to_sk_saddr(addr, sk);
+		sp->pf->to_sk_saddr(addr, sk);
 	}
=20
 	return ret;
@@ -1053,7 +1053,6 @@ static int __sctp_connect(struct sock *sk,
 	struct sctp_association *asoc2;
 	struct sctp_transport *transport;
 	union sctp_addr to;
-	struct sctp_af *af;
 	sctp_scope_t scope;
 	long timeo;
 	int err =3D 0;
@@ -1081,6 +1080,8 @@ static int __sctp_connect(struct sock *sk,
 	/* Walk through the addrs buffer and count the number of addresses. */
 	addr_buf =3D kaddrs;
 	while (walk_size < addrs_size) {
+		struct sctp_af *af;
+
 		if (walk_size + sizeof(sa_family_t) > addrs_size) {
 			err =3D -EINVAL;
 			goto out_free;
@@ -1205,8 +1206,7 @@ static int __sctp_connect(struct sock *sk,
=20
 	/* Initialize sk's dport and daddr for getpeername() */
 	inet_sk(sk)->inet_dport =3D htons(asoc->peer.port);
-	af =3D sctp_get_af_specific(sa_addr->sa.sa_family);
-	af->to_sk_daddr(sa_addr, sk);
+	sp->pf->to_sk_daddr(sa_addr, sk);
 	sk->sk_err =3D 0;
=20
 	/* in-kernel sockets don't generally have a file allocated to them
@@ -4166,7 +4166,7 @@ static int sctp_getsockopt_sctp_status(struct sock *s=
k, int len,
 	memcpy(&status.sstat_primary.spinfo_address, &transport->ipaddr,
 			transport->af_specific->sockaddr_len);
 	/* Map ipv4 address into v4-mapped-on-v6 address.  */
-	sctp_get_pf_specific(sk->sk_family)->addr_v4map(sctp_sk(sk),
+	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sctp_sk(sk),
 		(union sctp_addr *)&status.sstat_primary.spinfo_address);
 	status.sstat_primary.spinfo_state =3D transport->state;
 	status.sstat_primary.spinfo_cwnd =3D transport->cwnd;
@@ -4324,8 +4324,8 @@ static int sctp_getsockopt_autoclose(struct sock *sk,=
 int len, char __user *optv
 int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id, struct socket **sock=
p)
 {
 	struct sctp_association *asoc =3D sctp_id2assoc(sk, id);
+	struct sctp_sock *sp =3D sctp_sk(sk);
 	struct socket *sock;
-	struct sctp_af *af;
 	int err =3D 0;
=20
 	/* Do not peel off from one netns to another one. */
@@ -4357,8 +4357,7 @@ int sctp_do_peeloff(struct sock *sk, sctp_assoc_t id,=
 struct socket **sockp)
 	/* Make peeled-off sockets more like 1-1 accepted sockets.
 	 * Set the daddr and initialize id to something more random
 	 */
-	af =3D sctp_get_af_specific(asoc->peer.primary_addr.sa.sa_family);
-	af->to_sk_daddr(&asoc->peer.primary_addr, sk);
+	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sk);
=20
 	/* Populate the fields of the newsk from the oldsk and migrate the
 	 * asoc to the newsk.
@@ -4742,8 +4741,8 @@ static int sctp_getsockopt_peer_addrs(struct sock *sk=
, int len,
 	list_for_each_entry(from, &asoc->peer.transport_addr_list,
 				transports) {
 		memcpy(&temp, &from->ipaddr, sizeof(temp));
-		sctp_get_pf_specific(sk->sk_family)->addr_v4map(sp, &temp);
-		addrlen =3D sctp_get_af_specific(temp.sa.sa_family)->sockaddr_len;
+		addrlen =3D sctp_get_pf_specific(sk->sk_family)
+			      ->addr_to_user(sp, &temp);
 		if (space_left < addrlen)
 			return -ENOMEM;
 		if (copy_to_user(to, &temp, addrlen))
@@ -4787,9 +4786,9 @@ static int sctp_copy_laddrs(struct sock *sk, __u16 po=
rt, void *to,
 		if (!temp.v4.sin_port)
 			temp.v4.sin_port =3D htons(port);
=20
-		sctp_get_pf_specific(sk->sk_family)->addr_v4map(sctp_sk(sk),
-								&temp);
-		addrlen =3D sctp_get_af_specific(temp.sa.sa_family)->sockaddr_len;
+		addrlen =3D sctp_get_pf_specific(sk->sk_family)
+			      ->addr_to_user(sctp_sk(sk), &temp);
+
 		if (space_left < addrlen) {
 			cnt =3D  -ENOMEM;
 			break;
@@ -4877,8 +4876,8 @@ static int sctp_getsockopt_local_addrs(struct sock *s=
k, int len,
 	 */
 	list_for_each_entry(addr, &bp->address_list, list) {
 		memcpy(&temp, &addr->a, sizeof(temp));
-		sctp_get_pf_specific(sk->sk_family)->addr_v4map(sp, &temp);
-		addrlen =3D sctp_get_af_specific(temp.sa.sa_family)->sockaddr_len;
+		addrlen =3D sctp_get_pf_specific(sk->sk_family)
+			      ->addr_to_user(sp, &temp);
 		if (space_left < addrlen) {
 			err =3D  -ENOMEM; /*fixme: right error?*/
 			goto out;
@@ -4937,7 +4936,7 @@ static int sctp_getsockopt_primary_addr(struct sock *=
sk, int len,
 	memcpy(&prim.ssp_addr, &asoc->peer.primary_path->ipaddr,
 		asoc->peer.primary_path->af_specific->sockaddr_len);
=20
-	sctp_get_pf_specific(sk->sk_family)->addr_v4map(sp,
+	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sp,
 			(union sctp_addr *)&prim.ssp_addr);
=20
 	if (put_user(len, optlen))
diff --git a/net/sctp/transport.c b/net/sctp/transport.c
index d27f064e2d06..b71fc5880706 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -289,8 +289,8 @@ void sctp_transport_route(struct sctp_transport *transp=
ort,
 		 */
 		if (asoc && (!asoc->peer.primary_path ||
 				(transport =3D=3D asoc->peer.active_path)))
-			opt->pf->af->to_sk_saddr(&transport->saddr,
-						 asoc->base.sk);
+			opt->pf->to_sk_saddr(&transport->saddr,
+					     asoc->base.sk);
 	} else
 		transport->pathmtu =3D SCTP_DEFAULT_MAXSEGMENT;
 }
diff --git a/net/sctp/ulpevent.c b/net/sctp/ulpevent.c
index b6842fdb53d4..dd5787f877e7 100644
--- a/net/sctp/ulpevent.c
+++ b/net/sctp/ulpevent.c
@@ -341,7 +341,7 @@ struct sctp_ulpevent *sctp_ulpevent_make_peer_addr_chan=
ge(
 	memcpy(&spc->spc_aaddr, aaddr, sizeof(struct sockaddr_storage));
=20
 	/* Map ipv4 address into v4-mapped-on-v6 address.  */
-	sctp_get_pf_specific(asoc->base.sk->sk_family)->addr_v4map(
+	sctp_get_pf_specific(asoc->base.sk->sk_family)->addr_to_user(
 					sctp_sk(asoc->base.sk),
 					(union sctp_addr *)&spc->spc_aaddr);
=20
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index eb71b29eb647..173915a2be1e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2341,10 +2341,32 @@ static int nl80211_send_iface(struct sk_buff *msg, =
u32 portid, u32 seq, int flag
 		}
 	}
=20
-	if (wdev->ssid_len) {
-		if (nla_put(msg, NL80211_ATTR_SSID, wdev->ssid_len, wdev->ssid))
+	wdev_lock(wdev);
+	switch (wdev->iftype) {
+	case NL80211_IFTYPE_AP:
+		if (wdev->ssid_len &&
+		    nla_put(msg, NL80211_ATTR_SSID, wdev->ssid_len, wdev->ssid))
 			goto nla_put_failure;
+		break;
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_ADHOC: {
+		const u8 *ssid_ie;
+		if (!wdev->current_bss)
+			break;
+		ssid_ie =3D ieee80211_bss_get_ie(&wdev->current_bss->pub,
+					       WLAN_EID_SSID);
+		if (!ssid_ie)
+			break;
+		if (nla_put(msg, NL80211_ATTR_SSID, ssid_ie[1], ssid_ie + 2))
+			goto nla_put_failure;
+		break;
+		}
+	default:
+		/* nothing */
+		break;
 	}
+	wdev_unlock(wdev);
=20
 	return genlmsg_end(msg, hdr);
=20
diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 24a21cd72b4c..4830e8ac3e85 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -126,6 +126,7 @@ static struct file_perms change_profile_perms(struct aa=
_profile *profile,
  * __attach_match_ - find an attachment match
  * @name - to match against  (NOT NULL)
  * @head - profile list to walk  (NOT NULL)
+ * @info - info message if there was an error (NOT NULL)
  *
  * Do a linear search on the profiles in the list.  There is a matching
  * preference where an exact match is preferred over a name which uses
@@ -137,28 +138,44 @@ static struct file_perms change_profile_perms(struct =
aa_profile *profile,
  * Returns: profile or NULL if no match found
  */
 static struct aa_profile *__attach_match(const char *name,
-					 struct list_head *head)
+					 struct list_head *head,
+					 const char **info)
 {
 	int len =3D 0;
+	bool conflict =3D false;
 	struct aa_profile *profile, *candidate =3D NULL;
=20
 	list_for_each_entry_rcu(profile, head, base.list) {
 		if (profile->flags & PFLAG_NULL)
 			continue;
-		if (profile->xmatch && profile->xmatch_len > len) {
-			unsigned int state =3D aa_dfa_match(profile->xmatch,
-							  DFA_START, name);
-			u32 perm =3D dfa_user_allow(profile->xmatch, state);
-			/* any accepting state means a valid match. */
-			if (perm & MAY_EXEC) {
-				candidate =3D profile;
-				len =3D profile->xmatch_len;
+		if (profile->xmatch) {
+			if (profile->xmatch_len =3D=3D len) {
+				conflict =3D true;
+				continue;
+			} else if (profile->xmatch_len > len) {
+				unsigned int state;
+				u32 perm;
+
+				state =3D aa_dfa_match(profile->xmatch,
+						     DFA_START, name);
+				perm =3D dfa_user_allow(profile->xmatch, state);
+				/* any accepting state means a valid match. */
+				if (perm & MAY_EXEC) {
+					candidate =3D profile;
+					len =3D profile->xmatch_len;
+					conflict =3D false;
+				}
 			}
 		} else if (!strcmp(profile->base.name, name))
 			/* exact non-re match, no more searching required */
 			return profile;
 	}
=20
+	if (conflict) {
+		*info =3D "conflicting profile attachments";
+		return NULL;
+	}
+
 	return candidate;
 }
=20
@@ -167,16 +184,18 @@ static struct aa_profile *__attach_match(const char *=
name,
  * @ns: the current namespace  (NOT NULL)
  * @list: list to search  (NOT NULL)
  * @name: the executable name to match against  (NOT NULL)
+ * @info: info message if there was an error
  *
  * Returns: profile or NULL if no match found
  */
 static struct aa_profile *find_attach(struct aa_namespace *ns,
-				      struct list_head *list, const char *name)
+				      struct list_head *list, const char *name,
+				      const char **info)
 {
 	struct aa_profile *profile;
=20
 	rcu_read_lock();
-	profile =3D aa_get_profile(__attach_match(name, list));
+	profile =3D aa_get_profile(__attach_match(name, list, info));
 	rcu_read_unlock();
=20
 	return profile;
@@ -298,7 +317,8 @@ static struct aa_profile *x_table_lookup(struct aa_prof=
ile *profile, u32 xindex)
  * Returns: refcounted profile or NULL if not found available
  */
 static struct aa_profile *x_to_profile(struct aa_profile *profile,
-				       const char *name, u32 xindex)
+				       const char *name, u32 xindex,
+				       const char **info)
 {
 	struct aa_profile *new_profile =3D NULL;
 	struct aa_namespace *ns =3D profile->ns;
@@ -312,11 +332,11 @@ static struct aa_profile *x_to_profile(struct aa_prof=
ile *profile,
 		if (xindex & AA_X_CHILD)
 			/* released by caller */
 			new_profile =3D find_attach(ns, &profile->base.profiles,
-						  name);
+						  name, info);
 		else
 			/* released by caller */
 			new_profile =3D find_attach(ns, &ns->base.profiles,
-						  name);
+						  name, info);
 		break;
 	case AA_X_TABLE:
 		/* released by caller */
@@ -385,7 +405,8 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
 			/* change_profile on exec already been granted */
 			new_profile =3D aa_get_profile(cxt->onexec);
 		else
-			new_profile =3D find_attach(ns, &ns->base.profiles, name);
+			new_profile =3D find_attach(ns, &ns->base.profiles, name,
+						  &info);
 		if (!new_profile)
 			goto cleanup;
 		/*
@@ -421,7 +442,7 @@ int apparmor_bprm_set_creds(struct linux_binprm *bprm)
=20
 	if (perms.allow & MAY_EXEC) {
 		/* exec permission determine how to transition */
-		new_profile =3D x_to_profile(profile, name, perms.xindex);
+		new_profile =3D x_to_profile(profile, name, perms.xindex, &info);
 		if (!new_profile) {
 			if (perms.xindex & AA_X_INHERIT) {
 				/* (p|c|n)ix - don't change profile but do
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima=
_main.c
index ac2e2cee7a2a..6d88467a0de1 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -52,6 +52,8 @@ static int __init hash_setup(char *str)
 			ima_hash_algo =3D HASH_ALGO_SHA1;
 		else if (strncmp(str, "md5", 3) =3D=3D 0)
 			ima_hash_algo =3D HASH_ALGO_MD5;
+		else
+			return 1;
 		goto out;
 	}
=20
@@ -61,6 +63,8 @@ static int __init hash_setup(char *str)
 			break;
 		}
 	}
+	if (i =3D=3D HASH_ALGO__LAST)
+		return 1;
 out:
 	hash_setup_done =3D 1;
 	return 1;
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 0a52e377a617..83bf65ae8251 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -236,6 +236,7 @@ static struct snd_seq_client *seq_create_client1(int cl=
ient_index, int poolsize)
 	rwlock_init(&client->ports_lock);
 	mutex_init(&client->ports_mutex);
 	INIT_LIST_HEAD(&client->ports_list_head);
+	mutex_init(&client->ioctl_mutex);
=20
 	/* find free slot in the client table */
 	spin_lock_irqsave(&clients_lock, flags);
@@ -2200,6 +2201,7 @@ static int snd_seq_do_ioctl(struct snd_seq_client *cl=
ient, unsigned int cmd,
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
+	int ret;
=20
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2213,8 +2215,12 @@ static int snd_seq_do_ioctl(struct snd_seq_client *c=
lient, unsigned int cmd,
 	if (! arg)
 		return -EFAULT;
 	for (p =3D ioctl_tables; p->cmd; p++) {
-		if (p->cmd =3D=3D cmd)
-			return p->func(client, arg);
+		if (p->cmd =3D=3D cmd) {
+			mutex_lock(&client->ioctl_mutex);
+			ret =3D p->func(client, arg);
+			mutex_unlock(&client->ioctl_mutex);
+			return ret;
+		}
 	}
 	pr_debug("ALSA: seq unknown ioctl() 0x%x (type=3D'%c', number=3D0x%02x)\n=
",
 		   cmd, _IOC_TYPE(cmd), _IOC_NR(cmd));
diff --git a/sound/core/seq/seq_clientmgr.h b/sound/core/seq/seq_clientmgr.h
index 20f0a725ec7d..91f8f165bfdc 100644
--- a/sound/core/seq/seq_clientmgr.h
+++ b/sound/core/seq/seq_clientmgr.h
@@ -59,6 +59,7 @@ struct snd_seq_client {
 	struct list_head ports_list_head;
 	rwlock_t ports_lock;
 	struct mutex ports_mutex;
+	struct mutex ioctl_mutex;
 	int convert32;		/* convert 32->64bit */
=20
 	/* output pool */
diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index 0b4b028e8e98..de9155eed727 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -40,11 +40,11 @@ static int snd_timer_user_info_compat(struct file *file,
 	struct snd_timer *t;
=20
 	tu =3D file->private_data;
-	if (snd_BUG_ON(!tu->timeri))
-		return -ENXIO;
+	if (!tu->timeri)
+		return -EBADFD;
 	t =3D tu->timeri->timer;
-	if (snd_BUG_ON(!t))
-		return -ENXIO;
+	if (!t)
+		return -EBADFD;
 	memset(&info, 0, sizeof(info));
 	info.card =3D t->card ? t->card->number : -1;
 	if (t->hw.flags & SNDRV_TIMER_HW_SLAVE)
@@ -73,8 +73,8 @@ static int snd_timer_user_status_compat(struct file *file,
 	struct snd_timer_status32 status;
 =09
 	tu =3D file->private_data;
-	if (snd_BUG_ON(!tu->timeri))
-		return -ENXIO;
+	if (!tu->timeri)
+		return -EBADFD;
 	memset(&status, 0, sizeof(status));
 	status.tstamp.tv_sec =3D tu->tstamp.tv_sec;
 	status.tstamp.tv_nsec =3D tu->tstamp.tv_nsec;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 7823dc0aabd7..93cfc305f04e 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1914,6 +1914,9 @@ static const struct pci_device_id azx_ids[] =3D {
 	/* AMD Hudson */
 	{ PCI_DEVICE(0x1022, 0x780d),
 	  .driver_data =3D AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
+	/* AMD Raven */
+	{ PCI_DEVICE(0x1022, 0x15e3),
+	  .driver_data =3D AZX_DRIVER_GENERIC | AZX_DCAPS_PRESET_ATI_SB },
 	/* ATI HDMI */
 	{ PCI_DEVICE(0x1002, 0x793b),
 	  .driver_data =3D AZX_DRIVER_ATIHDMI | AZX_DCAPS_PRESET_ATI_HDMI },
diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 56216a23277f..09feedbd80c9 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -43,7 +43,7 @@ static struct uac_clock_source_descriptor *
 	while ((cs =3D snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_SOURCE))) {
-		if (cs->bClockID =3D=3D clock_id)
+		if (cs->bLength >=3D sizeof(*cs) && cs->bClockID =3D=3D clock_id)
 			return cs;
 	}
=20
@@ -59,8 +59,11 @@ static struct uac_clock_selector_descriptor *
 	while ((cs =3D snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_SELECTOR))) {
-		if (cs->bClockID =3D=3D clock_id)
+		if (cs->bLength >=3D sizeof(*cs) && cs->bClockID =3D=3D clock_id) {
+			if (cs->bLength < 5 + cs->bNrInPins)
+				return NULL;
 			return cs;
+		}
 	}
=20
 	return NULL;
@@ -75,7 +78,7 @@ static struct uac_clock_multiplier_descriptor *
 	while ((cs =3D snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_MULTIPLIER))) {
-		if (cs->bClockID =3D=3D clock_id)
+		if (cs->bLength >=3D sizeof(*cs) && cs->bClockID =3D=3D clock_id)
 			return cs;
 	}
=20
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 6d7605db36d0..2784ed187fee 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1378,6 +1378,12 @@ static int parse_audio_feature_unit(struct mixer_bui=
ld *state, int unitid,
 	__u8 *bmaControls;
=20
 	if (state->mixer->protocol =3D=3D UAC_VERSION_1) {
+		if (hdr->bLength < 7) {
+			usb_audio_err(state->chip,
+				      "unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
+				      unitid);
+			return -EINVAL;
+		}
 		csize =3D hdr->bControlSize;
 		if (!csize) {
 			usb_audio_dbg(state->chip,
@@ -1395,6 +1401,12 @@ static int parse_audio_feature_unit(struct mixer_bui=
ld *state, int unitid,
 		}
 	} else {
 		struct uac2_feature_unit_descriptor *ftr =3D _ftr;
+		if (hdr->bLength < 6) {
+			usb_audio_err(state->chip,
+				      "unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
+				      unitid);
+			return -EINVAL;
+		}
 		csize =3D 4;
 		channels =3D (hdr->bLength - 6) / 4 - 1;
 		bmaControls =3D ftr->bmaControls;
@@ -2008,7 +2020,8 @@ static int parse_audio_selector_unit(struct mixer_bui=
ld *state, int unitid,
 	const struct usbmix_name_map *map;
 	char **namelist;
=20
-	if (!desc->bNrInPins || desc->bLength < 5 + desc->bNrInPins) {
+	if (desc->bLength < 5 || !desc->bNrInPins ||
+	    desc->bLength < 5 + desc->bNrInPins) {
 		usb_audio_err(state->chip,
 			"invalid SELECTOR UNIT descriptor %d\n", unitid);
 		return -EINVAL;

--7LkOrbQMr4cezO2T--

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWoR7Pue/yOyVhhEJAQpoCg//UMoFba6N4IjUyeYjOCeW2+3scn6FVzHK
pWFJFEzQvkcbtzRmp6qMNl43nOuBMBNv1WHqwdJMMNgk7gbUrvUL5r/JgYVLxaiV
lD8C3Crv3k2L7MWstLsgO3ruSo6YOlwkaKSLtq5oMZQ0W6x7olEprej+c24pnA3Z
8Dy+jXh3nzsjRVNSqVeaO+TugeRFYC8QdUbeVkYOEw1+qsvXj91O6WbF+Kk43Rbi
NCuDNCQSs9oQEhPGUPCI+9OCVhiLit9uvp7cfujMztRPieTlJdjraez1+c9xxjV9
QOjHBzVWhuxhRutkS0X+4srkuHtZNr/Dz3RB4IMUunsxNCZ5EncX78UramzV5S4l
4qFW9W8L2r7qI7+iDRdtJJfgCXNd5J2XzzcrgLax98zmCNgB8HlFZAmE9/tD8GLQ
HkheHucZ1qZKkSW13iDUGtZuypuhS+gfiELELka5+/nathebrTsKt506BRnppRy+
djGfA/E9V7vFMD8et9LQJMWjeeMK8wzX3aOmjo4RPGAUd5EUgdmMFT0PTR91qX2Y
rV1dAwSG2gBoVj/94r5E+8dW+LOZ1NNAj092/Gdm4XAzUUKaWmK/feaCyKxx3xFk
lu5Q/LerGmBKidomcTxjilUXRWmQ9D/LmYj9dnSiTU868d5yxmXCwQcpvQ/wZpoV
yfWUGXmVIxs=
=GRQ4
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
