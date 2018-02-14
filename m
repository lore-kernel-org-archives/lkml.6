Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463544-1518631755-2-2908785067242683619
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: linux-3.2.99.patch
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518631750; b=lF8+QtwBMys8KzXEihnY25sSs338elcDw8QY7S96K+Qigje
    TytzNK8ViR1nH2yVVuLGo374G6J61M0yTbV4ySjPwmC1/8qRJeSWL3dAue/tLxIT
    f8xJ/QSHGgJumeBpt0jiVbIIFUFAjeHxFKhHQbC/tUcbBvn36mpIyR8jWC6ur6IH
    KjOMgVMc94bbLBqVzwnpgbhdQl/nxfi9cAm66LPnUxtYcCYIyKpOpNg1CJKajUjd
    ekGWBIfqNqJ5TQMva9oUpVbJEeg4EEVibI0xtmNwOgNLX9eDlDvXnSqnYvC9Wyn8
    qWtGTZq2Sb8SZjx8U4KwhmtDsbkWq9w9t6lcDwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:message-id:mime-version
    :content-type:subject:sender:list-id; s=arctest; t=1518631750;
    bh=B/DOqEW83bUZNmQKUH0nzeR41YWrqXTpvJO1Yhn73k8=; b=NCthh+Ajy9m1
    2hoI8BdGzj12mVit4/Ac3No1tc0oA782A4VSX0HR9MpO9F7sTZ1p9ivO8GoXEIZb
    3gWW09xTFuAMfGAgqMEkL28XHmgKIg/K72kSwqNDa3g8qDc4X06E5DZ8halh5Of3
    7ycfFr1cjQpZ8BqX6fHS0hMVTZCCwxAB1Z9g/f41moTtsjES2kkyOVUymm6pe6mH
    3wYXBU5flvmhoZyBgArHyqg/ScdiHkmkZSz0l/OO9mOctigttHktJ9vLIOUTQzNh
    9Vc/tMg9mqsxqvJ3i7uezk9oXP5ksoVqLbG5mAoxdqym6ZEPrv7wHAvuKMrUIvjU
    dF1LOc+Syw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161636AbeBNSJH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 13:09:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38720 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161585AbeBNSJA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 13:09:00 -0500
Date: Wed, 14 Feb 2018 18:08:50 +0000
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc: lwn@lwn.net
Message-ID: <20180214180849.GC8564@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
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
Subject: Linux 3.2.99
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--MAH+hnPXVZWQ5cD/
Content-Type: multipart/mixed; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 3.2.99 kernel.

All users of the 3.2 kernel series should upgrade.

The updated 3.2.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.2.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git

The diff from 3.2.98 is attached to this message.

Ben.

------------

 Documentation/kernel-parameters.txt                |   3 -
 Makefile                                           |   2 +-
 arch/s390/kernel/dis.c                             |   4 +-
 arch/x86/include/asm/alternative.h                 |   4 +-
 arch/x86/kernel/alternative.c                      | 129 +++-------
 arch/x86/kernel/smpboot.c                          |  20 +-
 arch/x86/kvm/svm.c                                 |   7 +
 arch/x86/kvm/vmx.c                                 |   4 +
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/kvm/x86.h                                 |   2 +
 arch/x86/lib/x86-opcode-map.txt                    |   2 +-
 arch/x86/mm/kaiser.c                               |   5 +-
 arch/x86/xen/smp.c                                 |   6 +-
 block/blk-core.c                                   |   3 +
 drivers/char/tpm/tpm.c                             |   6 +
 drivers/infiniband/hw/mlx4/qp.c                    |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  23 +-
 drivers/input/misc/adxl34x.c                       |   2 +-
 drivers/md/dm-bufio.c                              |  15 +-
 drivers/md/dm-table.c                              |  32 ++-
 drivers/md/dm.c                                    |  12 +-
 drivers/media/rc/ir-lirc-codec.c                   |   9 +-
 drivers/media/video/cx231xx/cx231xx-cards.c        |   3 +-
 drivers/media/video/omap/omap_vout.c               |   3 +-
 drivers/mtd/nand/nand_base.c                       |   9 +-
 drivers/net/wireless/rt2x00/rt2x00usb.c            |   6 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |   9 +-
 drivers/rtc/interface.c                            |  16 +-
 drivers/scsi/bfa/bfad_debugfs.c                    |   5 +-
 drivers/staging/media/as102/as102_fw.c             |  28 ++-
 drivers/staging/usbip/stub_rx.c                    |  58 +++--
 drivers/staging/usbip/stub_tx.c                    |   7 +
 drivers/staging/usbip/usbip_common.h               |   1 +
 .../staging/usbip/userspace/libsrc/usbip_common.c  |   2 +-
 .../staging/usbip/userspace/libsrc/vhci_driver.c   |   8 +-
 drivers/staging/usbip/vhci_hcd.c                   |  39 ---
 drivers/staging/usbip/vhci_sysfs.c                 |  20 +-
 drivers/usb/core/devio.c                           |  14 ++
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/serial/garmin_gps.c                    |  22 +-
 drivers/video/udlfb.c                              |  10 +-
 fs/9p/vfs_inode.c                                  |   3 +
 fs/9p/vfs_inode_dotl.c                             |   3 +
 fs/autofs4/waitq.c                                 |  45 +++-
 fs/coda/upcall.c                                   |   3 +-
 fs/ecryptfs/messaging.c                            |   8 +-
 fs/isofs/isofs.h                                   |   2 +-
 fs/isofs/rock.h                                    |   2 +-
 fs/isofs/util.c                                    |   2 +-
 fs/nfs/nfs4proc.c                                  |  18 +-
 fs/nilfs2/segment.c                                |   6 +-
 fs/ocfs2/alloc.c                                   |   2 +-
 fs/ocfs2/file.c                                    |   9 +-
 include/linux/blkdev.h                             |   1 +
 include/linux/usb/ch9.h                            |  19 ++
 include/net/sctp/sctp.h                            |   2 +
 include/net/sctp/structs.h                         |   8 +-
 kernel/cpu.c                                       |  11 -
 kernel/extable.c                                   |   2 +
 kernel/trace/blktrace.c                            |  76 ++++--
 net/9p/client.c                                    |   3 +-
 net/9p/trans_virtio.c                              |  13 +-
 net/l2tp/l2tp_core.c                               |  42 ++--
 net/l2tp/l2tp_core.h                               |   3 +
 net/l2tp/l2tp_eth.c                                |  96 +++++--
 net/l2tp/l2tp_ppp.c                                | 276 ++++++++++++---------
 net/netfilter/xt_TCPMSS.c                          |  43 ++--
 net/netfilter/xt_TCPOPTSTRIP.c                     |  19 +-
 net/rds/rdma.c                                     |   4 +
 net/sctp/ipv6.c                                    | 160 ++++++------
 net/sctp/protocol.c                                |  12 +-
 net/sctp/socket.c                                  |  33 ++-
 net/sctp/transport.c                               |   4 +-
 net/sctp/ulpevent.c                                |   2 +-
 sound/core/seq/seq_clientmgr.c                     |  10 +-
 sound/core/seq/seq_clientmgr.h                     |   1 +
 sound/core/timer_compat.c                          |  12 +-
 sound/pci/hda/hda_intel.c                          |   3 +
 sound/usb/clock.c                                  |   9 +-
 sound/usb/mixer.c                                  |  15 +-
 80 files changed, 906 insertions(+), 636 deletions(-)

Al Viro (2):
      autofs4: autofs4_wait() vs. autofs4_catatonic_mode() race
      autofs4: catatonic_mode vs. notify_daemon race

Alan (1):
      usbip: Fix sscanf handling

Alan Stern (1):
      USB: usbfs: compute urb->actual_length for isochronous

Alexander Potapenko (1):
      sctp: fully initialize the IPv6 address in sctp_v6_to_addr()

Alexander Steffen (1):
      tpm-dev-common: Reject too short writes

Alexandre Belloni (1):
      rtc: set the alarm to the next expiring timer

Andreas Rohner (1):
      nilfs2: fix race condition that causes file system corruption

Arnd Bergmann (2):
      Input: adxl34x - do not treat FIFO_MODE() as boolean
      isofs: fix timestamps beyond 2027

Bart Van Assche (1):
      IB/srp: Avoid that a cable pull can trigger a kernel crash

Bart Westgeest (1):
      staging: usbip: removed #if 0'd out code

Ben Hutchings (1):
      Linux 3.2.99

Bernhard Rosenkraenzer (1):
      USB: Add delay-init quirk for Corsair K70 LUX keyboards

Brent Taylor (1):
      mtd: nand: Fix writing mtdoops to nand flash.

Chuck Lever (1):
      nfs: Fix ugly referral attributes

Colin Ian King (1):
      rtc: interface: ignore expired timers when enqueuing new timers

Dan Carpenter (2):
      scsi: bfa: integer overflow in debugfs
      eCryptfs: use after free in ecryptfs_release_messaging()

Eric Biggers (1):
      dm bufio: fix integer overflow when limiting maximum cache size

Eric Dumazet (1):
      netfilter: xt_TCPMSS: add more sanity tests on tcph->doff

Eric W. Biederman (1):
      net/sctp: Always set scope_id in sctp_inet6_skb_msgname

Felipe Balbi (1):
      usb: add helper to extract bits 12:11 of wMaxPacketSize

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

Hou Tao (1):
      dm: fix race between dm_get_from_kobject() and __dm_destroy()

Jan Harkes (1):
      coda: fix 'kernel memory exposure attempt' in fsync

Jason Gunthorpe (1):
      sctp: Fixup v4mapped behaviour to comply with Sock API

Jens Axboe (1):
      blktrace: fix unlocked access to init/start-stop/teardown

Johan Hovold (2):
      USB: serial: garmin_gps: fix I/O after failed probe and remove
      USB: serial: garmin_gps: fix memory leak on probe errors

Ladi Prosek (1):
      KVM: nVMX: set IDTR and GDTR limits when loading L1 host state

Ladislav Michl (1):
      video: udlfb: Fix read EDID timeout

Lepton Wu (1):
      kaiser: Set _PAGE_NX only if supported

Mark Bloch (1):
      IB/mlx4: Increase maximal message size under UD QP

Markus Elfring (1):
      media: omap_vout: Fix a possible null pointer dereference in omap_vout_open()

Masami Hiramatsu (1):
      x86/decoder: Add new TEST instruction pattern

Mauro Carvalho Chehab (1):
      cx231xx: Fix the max number of interfaces

Michele Baldessari (1):
      media: Don't do DMA on stack for firmware upload in the AS102 driver

Mike Snitzer (1):
      dm: discard support requires all targets in a table support discards

Mohamed Ghannam (2):
      RDS: Heap OOB write in rds_message_alloc_sgs()
      RDS: null pointer dereference in rds_atomic_free_op

Nadav Amit (1):
      KVM: vmx: Inject #GP on invalid PAT CR

NeilBrown (2):
      autofs: don't fail mount for transient error
      autofs: fix careless error in recent commit

Pablo Neira Ayuso (3):
      netfilter: xt_TCPOPTSTRIP: fix possible mangling beyond packet boundary
      netfilter: xt_TCPOPTSTRIP: don't use tcp_hdr()
      netfilter: xt_TCPMSS: fix handling of malformed TCP header and options

Paolo Bonzini (1):
      KVM: SVM: obey guest PAT

Phil Oester (2):
      netfilter: xt_TCPMSS: Fix missing fragmentation handling
      netfilter: xt_TCPMSS: correct return value in tcpmss_mangle_packet

Rusty Russell (1):
      x86/smp: Don't ever patch back to UP if we unplug cpus

Sean Young (1):
      media: rc: check for integer overflow

Shuah Khan (4):
      usbip: fix stub_rx: get_pipe() to validate endpoint number
      usbip: fix stub_rx: harden CMD_SUBMIT path to handle malicious input
      usbip: prevent vhci_hcd driver from leaking a socket pointer address
      usbip: fix stub_send_ret_submit() vulnerability to null transfer_buffer

Stanislaw Gruszka (1):
      rt2x00usb: mark device removed when get ENOENT usb error

Takashi Iwai (5):
      ALSA: timer: Remove kernel warning at compat ioctl error paths
      ALSA: usb-audio: Add sanity checks to FE parser
      ALSA: usb-audio: Fix potential out-of-bound access at parsing SU
      ALSA: usb-audio: Add sanity checks in v2 clock parsers
      ALSA: seq: Make ioctls race-free

Tom Parkin (3):
      l2tp: add session reorder queue purge function to core
      l2tp: purge session reorder queue on delete
      l2tp: push all ppp pseudowire shutdown through .release handler

Tuomas Tynkkynen (2):
      fs/9p: Compare qid.path in v9fs_test_inode
      net/9p: Switch to wait_event_killable()

Vasily Gorbik (1):
      s390/disassembler: increase show_code buffer size

Vijendar Mukunda (1):
      ALSA: hda: Add Raven PCI ID

Waiman Long (1):
      blktrace: Fix potential deadlock between delete & sysfs ops

Younger Liu (1):
      ocfs2: fix issue that ocfs2_setattr() does not deal with new_i_size==i_size

Zhou Chengming (1):
      kprobes, x86/alternatives: Use text_mutex to protect smp_alt_modules


--s9fJI615cBHmzTOP
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.2.99.patch"
Content-Disposition: attachment; filename="linux-3.2.99.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-par=
ameters.txt
index ccaf4be39d17..0d27ce60d452 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -2440,9 +2440,6 @@ bytes respectively. Such letter suffixes can also be =
entirely omitted.
 	smart2=3D		[HW]
 			Format: <io1>[,<io2>[,...,<io8>]]
=20
-	smp-alt-once	[X86-32,SMP] On a hotplug CPU system, only
-			attempt to substitute SMP alternatives once at boot.
-
 	smsc-ircc2.nopnp	[HW] Don't use PNP to discover SMC devices
 	smsc-ircc2.ircc_cfg=3D	[HW] Device configuration I/O port
 	smsc-ircc2.ircc_sir=3D	[HW] SIR base I/O port
diff --git a/Makefile b/Makefile
index c726e4d97049..71876659ace6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 2
-SUBLEVEL =3D 98
+SUBLEVEL =3D 99
 EXTRAVERSION =3D
 NAME =3D Saber-toothed Squirrel
=20
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 847ea1598f12..eaf12bb2435c 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -1542,7 +1542,7 @@ void show_code(struct pt_regs *regs)
 {
 	char *mode =3D (regs->psw.mask & PSW_MASK_PSTATE) ? "User" : "Krnl";
 	unsigned char code[64];
-	char buffer[64], *ptr;
+	char buffer[128], *ptr;
 	mm_segment_t old_fs;
 	unsigned long addr;
 	int start, end, opsize, hops, i;
@@ -1600,7 +1600,7 @@ void show_code(struct pt_regs *regs)
 		start +=3D opsize;
 		printk(buffer);
 		ptr =3D buffer;
-		ptr +=3D sprintf(ptr, "\n          ");
+		ptr +=3D sprintf(ptr, "\n\t  ");
 		hops++;
 	}
 	printk("\n");
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alte=
rnative.h
index 132bf12ddb6a..e1c00154b610 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -61,7 +61,7 @@ extern void alternatives_smp_module_add(struct module *mo=
d, char *name,
 					void *locks, void *locks_end,
 					void *text, void *text_end);
 extern void alternatives_smp_module_del(struct module *mod);
-extern void alternatives_smp_switch(int smp);
+extern void alternatives_enable_smp(void);
 extern int alternatives_text_reserved(void *start, void *end);
 extern bool skip_smp_alternatives;
 #else
@@ -69,7 +69,7 @@ static inline void alternatives_smp_module_add(struct mod=
ule *mod, char *name,
 					       void *locks, void *locks_end,
 					       void *text, void *text_end) {}
 static inline void alternatives_smp_module_del(struct module *mod) {}
-static inline void alternatives_smp_switch(int smp) {}
+static inline void alternatives_enable_smp(void) {}
 static inline int alternatives_text_reserved(void *start, void *end)
 {
 	return 0;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ca2430fbc6b3..81193ea301e2 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -21,19 +21,6 @@
=20
 #define MAX_PATCH_LEN (255-1)
=20
-#ifdef CONFIG_HOTPLUG_CPU
-static int smp_alt_once;
-
-static int __init bootonly(char *str)
-{
-	smp_alt_once =3D 1;
-	return 1;
-}
-__setup("smp-alt-boot", bootonly);
-#else
-#define smp_alt_once 1
-#endif
-
 static int __initdata_or_module debug_alternative;
=20
 static int __init debug_alt(char *str)
@@ -420,7 +407,6 @@ static void alternatives_smp_lock(const s32 *start, con=
st s32 *end,
 {
 	const s32 *poff;
=20
-	mutex_lock(&text_mutex);
 	for (poff =3D start; poff < end; poff++) {
 		u8 *ptr =3D (u8 *)poff + *poff;
=20
@@ -430,7 +416,6 @@ static void alternatives_smp_lock(const s32 *start, con=
st s32 *end,
 		if (*ptr =3D=3D 0x3e)
 			text_poke(ptr, ((unsigned char []){0xf0}), 1);
 	};
-	mutex_unlock(&text_mutex);
 }
=20
 static void alternatives_smp_unlock(const s32 *start, const s32 *end,
@@ -438,10 +423,6 @@ static void alternatives_smp_unlock(const s32 *start, =
const s32 *end,
 {
 	const s32 *poff;
=20
-	if (noreplace_smp)
-		return;
-
-	mutex_lock(&text_mutex);
 	for (poff =3D start; poff < end; poff++) {
 		u8 *ptr =3D (u8 *)poff + *poff;
=20
@@ -451,7 +432,6 @@ static void alternatives_smp_unlock(const s32 *start, c=
onst s32 *end,
 		if (*ptr =3D=3D 0xf0)
 			text_poke(ptr, ((unsigned char []){0x3E}), 1);
 	};
-	mutex_unlock(&text_mutex);
 }
=20
 struct smp_alt_module {
@@ -470,8 +450,7 @@ struct smp_alt_module {
 	struct list_head next;
 };
 static LIST_HEAD(smp_alt_modules);
-static DEFINE_MUTEX(smp_alt);
-static int smp_mode =3D 1;	/* protected by smp_alt */
+static bool uniproc_patched =3D false;	/* protected by text_mutex */
=20
 void __init_or_module alternatives_smp_module_add(struct module *mod,
 						  char *name,
@@ -480,19 +459,18 @@ void __init_or_module alternatives_smp_module_add(str=
uct module *mod,
 {
 	struct smp_alt_module *smp;
=20
-	if (noreplace_smp)
-		return;
+	mutex_lock(&text_mutex);
+	if (!uniproc_patched)
+		goto unlock;
=20
-	if (smp_alt_once) {
-		if (boot_cpu_has(X86_FEATURE_UP))
-			alternatives_smp_unlock(locks, locks_end,
-						text, text_end);
-		return;
-	}
+	if (num_possible_cpus() =3D=3D 1)
+		/* Don't bother remembering, we'll never have to undo it. */
+		goto smp_unlock;
=20
 	smp =3D kzalloc(sizeof(*smp), GFP_KERNEL);
 	if (NULL =3D=3D smp)
-		return; /* we'll run the (safe but slow) SMP code then ... */
+		/* we'll run the (safe but slow) SMP code then ... */
+		goto unlock;
=20
 	smp->mod	=3D mod;
 	smp->name	=3D name;
@@ -504,36 +482,29 @@ void __init_or_module alternatives_smp_module_add(str=
uct module *mod,
 		smp->locks, smp->locks_end,
 		smp->text, smp->text_end, smp->name);
=20
-	mutex_lock(&smp_alt);
 	list_add_tail(&smp->next, &smp_alt_modules);
-	if (boot_cpu_has(X86_FEATURE_UP))
-		alternatives_smp_unlock(smp->locks, smp->locks_end,
-					smp->text, smp->text_end);
-	mutex_unlock(&smp_alt);
+smp_unlock:
+	alternatives_smp_unlock(locks, locks_end, text, text_end);
+unlock:
+	mutex_unlock(&text_mutex);
 }
=20
 void __init_or_module alternatives_smp_module_del(struct module *mod)
 {
 	struct smp_alt_module *item;
=20
-	if (smp_alt_once || noreplace_smp)
-		return;
-
-	mutex_lock(&smp_alt);
+	mutex_lock(&text_mutex);
 	list_for_each_entry(item, &smp_alt_modules, next) {
 		if (mod !=3D item->mod)
 			continue;
 		list_del(&item->next);
-		mutex_unlock(&smp_alt);
-		DPRINTK("%s\n", item->name);
 		kfree(item);
-		return;
+		break;
 	}
-	mutex_unlock(&smp_alt);
+	mutex_unlock(&text_mutex);
 }
=20
-bool skip_smp_alternatives;
-void alternatives_smp_switch(int smp)
+void alternatives_enable_smp(void)
 {
 	struct smp_alt_module *mod;
=20
@@ -548,38 +519,28 @@ void alternatives_smp_switch(int smp)
 	printk("lockdep: fixing up alternatives.\n");
 #endif
=20
-	if (noreplace_smp || smp_alt_once || skip_smp_alternatives)
-		return;
-	BUG_ON(!smp && (num_online_cpus() > 1));
+	/* Why bother if there are no other CPUs? */
+	BUG_ON(num_possible_cpus() =3D=3D 1);
=20
-	mutex_lock(&smp_alt);
+	mutex_lock(&text_mutex);
=20
-	/*
-	 * Avoid unnecessary switches because it forces JIT based VMs to
-	 * throw away all cached translations, which can be quite costly.
-	 */
-	if (smp =3D=3D smp_mode) {
-		/* nothing */
-	} else if (smp) {
+	if (uniproc_patched) {
 		printk(KERN_INFO "SMP alternatives: switching to SMP code\n");
+		BUG_ON(num_online_cpus() !=3D 1);
 		clear_cpu_cap(&boot_cpu_data, X86_FEATURE_UP);
 		clear_cpu_cap(&cpu_data(0), X86_FEATURE_UP);
 		list_for_each_entry(mod, &smp_alt_modules, next)
 			alternatives_smp_lock(mod->locks, mod->locks_end,
 					      mod->text, mod->text_end);
-	} else {
-		printk(KERN_INFO "SMP alternatives: switching to UP code\n");
-		set_cpu_cap(&boot_cpu_data, X86_FEATURE_UP);
-		set_cpu_cap(&cpu_data(0), X86_FEATURE_UP);
-		list_for_each_entry(mod, &smp_alt_modules, next)
-			alternatives_smp_unlock(mod->locks, mod->locks_end,
-						mod->text, mod->text_end);
+		uniproc_patched =3D false;
 	}
-	smp_mode =3D smp;
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
@@ -587,6 +548,8 @@ int alternatives_text_reserved(void *start, void *end)
 	u8 *text_start =3D start;
 	u8 *text_end =3D end;
=20
+	lockdep_assert_held(&text_mutex);
+
 	list_for_each_entry(mod, &smp_alt_modules, next) {
 		if (mod->text > text_end || mod->text_end < text_start)
 			continue;
@@ -652,40 +615,22 @@ void __init alternative_instructions(void)
=20
 	apply_alternatives(__alt_instructions, __alt_instructions_end);
=20
-	/* switch to patch-once-at-boottime-only mode and free the
-	 * tables in case we know the number of CPUs will never ever
-	 * change */
-#ifdef CONFIG_HOTPLUG_CPU
-	if (num_possible_cpus() < 2)
-		smp_alt_once =3D 1;
-#endif
-
 #ifdef CONFIG_SMP
-	if (smp_alt_once) {
-		if (1 =3D=3D num_possible_cpus()) {
-			printk(KERN_INFO "SMP alternatives: switching to UP code\n");
-			set_cpu_cap(&boot_cpu_data, X86_FEATURE_UP);
-			set_cpu_cap(&cpu_data(0), X86_FEATURE_UP);
-
-			alternatives_smp_unlock(__smp_locks, __smp_locks_end,
-						_text, _etext);
-		}
-	} else {
+	/* Patch to UP if other cpus not imminent. */
+	if (!noreplace_smp && (num_present_cpus() =3D=3D 1 || setup_max_cpus <=3D=
 1)) {
+		uniproc_patched =3D true;
 		alternatives_smp_module_add(NULL, "core kernel",
 					    __smp_locks, __smp_locks_end,
 					    _text, _etext);
-
-		/* Only switch to UP mode if we don't immediately boot others */
-		if (num_present_cpus() =3D=3D 1 || setup_max_cpus <=3D 1)
-			alternatives_smp_switch(0);
 	}
-#endif
- 	apply_paravirt(__parainstructions, __parainstructions_end);
=20
-	if (smp_alt_once)
+	if (!uniproc_patched || num_possible_cpus() =3D=3D 1)
 		free_init_pages("SMP alternatives",
 				(unsigned long)__smp_locks,
 				(unsigned long)__smp_locks_end);
+#endif
+
+	apply_paravirt(__parainstructions, __parainstructions_end);
=20
 	restart_nmi();
 }
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index bb28f2cae364..a5591d43fc31 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -689,7 +689,8 @@ static int __cpuinit do_boot_cpu(int apicid, int cpu)
=20
 	INIT_WORK_ONSTACK(&c_idle.work, do_fork_idle);
=20
-	alternatives_smp_switch(1);
+	/* Just in case we booted with a single CPU. */
+	alternatives_enable_smp();
=20
 	c_idle.idle =3D get_idle_for_cpu(cpu);
=20
@@ -1109,20 +1110,6 @@ void __init native_smp_prepare_cpus(unsigned int max=
_cpus)
 	preempt_enable();
 }
=20
-void arch_disable_nonboot_cpus_begin(void)
-{
-	/*
-	 * Avoid the smp alternatives switch during the disable_nonboot_cpus().
-	 * In the suspend path, we will be back in the SMP mode shortly anyways.
-	 */
-	skip_smp_alternatives =3D true;
-}
-
-void arch_disable_nonboot_cpus_end(void)
-{
-	skip_smp_alternatives =3D false;
-}
-
 void arch_enable_nonboot_cpus_begin(void)
 {
 	set_mtrr_aps_delayed_init();
@@ -1321,9 +1308,6 @@ void native_cpu_die(unsigned int cpu)
 		if (per_cpu(cpu_state, cpu) =3D=3D CPU_DEAD) {
 			if (system_state =3D=3D SYSTEM_RUNNING)
 				pr_info("CPU %u is now offline\n", cpu);
-
-			if (1 =3D=3D num_online_cpus())
-				alternatives_smp_switch(0);
 			return;
 		}
 		msleep(100);
diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index fba31b73e4bc..4bdd0acc68c3 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3040,6 +3040,13 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, unsign=
ed ecx, u64 data)
 	struct vcpu_svm *svm =3D to_svm(vcpu);
=20
 	switch (ecx) {
+	case MSR_IA32_CR_PAT:
+		if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
+			return 1;
+		vcpu->arch.pat =3D data;
+		svm->vmcb->save.g_pat =3D data;
+		mark_dirty(svm->vmcb, VMCB_NPT);
+		break;
 	case MSR_IA32_TSC:
 		kvm_write_tsc(vcpu, data);
 		break;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 39d40adcaaf0..346fac6eab9f 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -2204,6 +2204,8 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, u32 msr=
_index, u64 data)
 		break;
 	case MSR_IA32_CR_PAT:
 		if (vmcs_config.vmentry_ctrl & VM_ENTRY_LOAD_IA32_PAT) {
+			if (!kvm_mtrr_valid(vcpu, MSR_IA32_CR_PAT, data))
+				return 1;
 			vmcs_write64(GUEST_IA32_PAT, data);
 			vcpu->arch.pat =3D data;
 			break;
@@ -7076,6 +7078,8 @@ void load_vmcs12_host_state(struct kvm_vcpu *vcpu, st=
ruct vmcs12 *vmcs12)
 	vmcs_writel(GUEST_SYSENTER_EIP, vmcs12->host_ia32_sysenter_eip);
 	vmcs_writel(GUEST_IDTR_BASE, vmcs12->host_idtr_base);
 	vmcs_writel(GUEST_GDTR_BASE, vmcs12->host_gdtr_base);
+	vmcs_write32(GUEST_IDTR_LIMIT, 0xFFFF);
+	vmcs_write32(GUEST_GDTR_LIMIT, 0xFFFF);
 	vmcs_writel(GUEST_TR_BASE, vmcs12->host_tr_base);
 	vmcs_writel(GUEST_GS_BASE, vmcs12->host_gs_base);
 	vmcs_writel(GUEST_FS_BASE, vmcs12->host_fs_base);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7e6094b0308b..29d04a41ee0a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1274,7 +1274,7 @@ static bool valid_mtrr_type(unsigned t)
 	return t < 8 && (1 << t) & 0x73; /* 0, 1, 4, 5, 6 */
 }
=20
-static bool mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data)
+bool kvm_mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data)
 {
 	int i;
=20
@@ -1300,12 +1300,13 @@ static bool mtrr_valid(struct kvm_vcpu *vcpu, u32 m=
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
index 6c3c94f6379e..10eb76532a46 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -135,6 +135,8 @@ int kvm_write_guest_virt_system(struct x86_emulate_ctxt=
 *ctxt,
 	gva_t addr, void *val, unsigned int bytes,
 	struct x86_exception *exception);
=20
+bool kvm_mtrr_valid(struct kvm_vcpu *vcpu, u32 msr, u64 data);
+
 extern unsigned int min_timer_period_us;
=20
 #endif
diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.=
txt
index a793da5e560e..d9cc8293ca4e 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -759,7 +759,7 @@ EndTable
=20
 GrpTable: Grp3_1
 0: TEST Eb,Ib
-1:
+1: TEST Eb,Ib
 2: NOT Eb
 3: NEG Eb
 4: MUL AL,Eb
diff --git a/arch/x86/mm/kaiser.c b/arch/x86/mm/kaiser.c
index a95acd4c71fa..b6c645ec4906 100644
--- a/arch/x86/mm/kaiser.c
+++ b/arch/x86/mm/kaiser.c
@@ -189,6 +189,8 @@ static int kaiser_add_user_map(const void *__start_addr=
, unsigned long size,
 	 * requires that not to be #defined to 0): so mask it off here.
 	 */
 	flags &=3D ~_PAGE_GLOBAL;
+	if (!(__supported_pte_mask & _PAGE_NX))
+		flags &=3D ~_PAGE_NX;
=20
 	if (flags & _PAGE_USER)
 		BUG_ON(address < FIXADDR_START || end_addr >=3D FIXADDR_TOP);
@@ -411,7 +413,8 @@ pgd_t kaiser_set_shadow_pgd(pgd_t *pgdp, pgd_t pgd)
 			 * get out to userspace running on the kernel CR3,
 			 * userspace will crash instead of running.
 			 */
-			pgd.pgd |=3D _PAGE_NX;
+			if (__supported_pte_mask & _PAGE_NX)
+				pgd.pgd |=3D _PAGE_NX;
 		}
 	} else if (!pgd.pgd) {
 		/*
diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
index 6e4d5dcc22ff..a8991d4c32c2 100644
--- a/arch/x86/xen/smp.c
+++ b/arch/x86/xen/smp.c
@@ -368,7 +368,8 @@ static int __cpuinit xen_cpu_up(unsigned int cpu)
 		return rc;
=20
 	if (num_online_cpus() =3D=3D 1)
-		alternatives_smp_switch(1);
+		/* Just in case we booted with a single CPU. */
+		alternatives_enable_smp();
=20
 	rc =3D xen_smp_intr_init(cpu);
 	if (rc)
@@ -414,9 +415,6 @@ static void xen_cpu_die(unsigned int cpu)
 	unbind_from_irqhandler(per_cpu(xen_callfuncsingle_irq, cpu), NULL);
 	xen_uninit_lock_cpu(cpu);
 	xen_teardown_timer(cpu);
-
-	if (num_online_cpus() =3D=3D 1)
-		alternatives_smp_switch(0);
 }
=20
 static void __cpuinit xen_play_dead(void) /* used only with HOTPLUG_CPU */
diff --git a/block/blk-core.c b/block/blk-core.c
index 60d3e42fae4c..416b263921bc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -499,6 +499,9 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_ma=
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
diff --git a/drivers/char/tpm/tpm.c b/drivers/char/tpm/tpm.c
index 2c71cc4f3039..706c583cd5c7 100644
--- a/drivers/char/tpm/tpm.c
+++ b/drivers/char/tpm/tpm.c
@@ -1114,6 +1114,12 @@ ssize_t tpm_write(struct file *file, const char __us=
er *buf,
 		return -EFAULT;
 	}
=20
+	if (in_size < 6 ||
+	    in_size < be32_to_cpu(*((__be32 *) (chip->data_buffer + 2)))) {
+		mutex_unlock(&chip->buffer_mutex);
+		return -EINVAL;
+	}
+
 	/* atomic tpm command send and result receive */
 	out_size =3D tpm_transmit(chip, chip->data_buffer, TPM_BUFSIZE);
 	if (out_size < 0) {
diff --git a/drivers/infiniband/hw/mlx4/qp.c b/drivers/infiniband/hw/mlx4/q=
p.c
index df1a2def6379..8850b8d45af5 100644
--- a/drivers/infiniband/hw/mlx4/qp.c
+++ b/drivers/infiniband/hw/mlx4/qp.c
@@ -1047,7 +1047,7 @@ static int __mlx4_ib_modify_qp(struct ib_qp *ibqp,
 			context->mtu_msgmax =3D (IB_MTU_4096 << 5) |
 					      ilog2(dev->dev->caps.max_gso_sz);
 		else
-			context->mtu_msgmax =3D (IB_MTU_4096 << 5) | 12;
+			context->mtu_msgmax =3D (IB_MTU_4096 << 5) | 13;
 	} else if (attr_mask & IB_QP_PATH_MTU) {
 		if (attr->path_mtu < IB_MTU_256 || attr->path_mtu > IB_MTU_4096) {
 			printk(KERN_ERR "path MTU (%u) is invalid\n",
diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/s=
rp/ib_srp.c
index 8770d4449d6f..ded023c07a75 100644
--- a/drivers/infiniband/ulp/srp/ib_srp.c
+++ b/drivers/infiniband/ulp/srp/ib_srp.c
@@ -310,10 +310,19 @@ static void srp_path_rec_completion(int status,
=20
 static int srp_lookup_path(struct srp_target_port *target)
 {
+	int ret =3D -ENODEV;
+
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
@@ -327,16 +336,22 @@ static int srp_lookup_path(struct srp_target_port *ta=
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
 	wait_for_completion(&target->done);
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
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 09244804fb97..89b2f5b80a3a 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -797,7 +797,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int i=
rq,
=20
 	if (pdata->watermark) {
 		ac->int_mask |=3D WATERMARK;
-		if (!FIFO_MODE(pdata->fifo_mode))
+		if (FIFO_MODE(pdata->fifo_mode) =3D=3D FIFO_BYPASS)
 			ac->pdata.fifo_mode |=3D FIFO_STREAM;
 	} else {
 		ac->int_mask |=3D DATA_READY;
diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 3bf726796906..ec24a1c071b9 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -839,7 +839,8 @@ static void __get_memory_limit(struct dm_bufio_client *=
c,
 		buffers =3D DM_BUFIO_MIN_BUFFERS;
=20
 	*limit_buffers =3D buffers;
-	*threshold_buffers =3D buffers * DM_BUFIO_WRITEBACK_PERCENT / 100;
+	*threshold_buffers =3D mult_frac(buffers,
+				       DM_BUFIO_WRITEBACK_PERCENT, 100);
 }
=20
 /*
@@ -1620,19 +1621,15 @@ static int __init dm_bufio_init(void)
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
+	if (mem > mult_frac(VMALLOC_END - VMALLOC_START, DM_BUFIO_VMALLOC_PERCENT=
, 100))
+		mem =3D mult_frac(VMALLOC_END - VMALLOC_START, DM_BUFIO_VMALLOC_PERCENT,=
 100);
 #endif
=20
 	dm_bufio_default_cache_size =3D mem;
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index 0d0bc044a69c..5ec02399af30 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1584,12 +1584,12 @@ struct mapped_device *dm_table_get_md(struct dm_tab=
le *t)
 }
 EXPORT_SYMBOL(dm_table_get_md);
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
@@ -1597,26 +1597,22 @@ bool dm_table_supports_discards(struct dm_table *t)
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
 		if (!ti->num_discard_requests)
-			continue;
+			return false;
=20
-		if (ti->discards_supported)
-			return 1;
-
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
index ca688a28e219..d7e639900547 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -2685,11 +2685,15 @@ struct mapped_device *dm_get_from_kobject(struct ko=
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
diff --git a/drivers/media/rc/ir-lirc-codec.c b/drivers/media/rc/ir-lirc-co=
dec.c
index 695fef9ce6b1..4ee9f4e5a71d 100644
--- a/drivers/media/rc/ir-lirc-codec.c
+++ b/drivers/media/rc/ir-lirc-codec.c
@@ -255,11 +255,14 @@ static long ir_lirc_ioctl(struct file *filep, unsigne=
d int cmd,
 		if (!dev->max_timeout)
 			return -ENOSYS;
=20
+		/* Check for multiply overflow */
+		if (val > (u32)(-1) / 1000)
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
diff --git a/drivers/media/video/cx231xx/cx231xx-cards.c b/drivers/media/vi=
deo/cx231xx/cx231xx-cards.c
index 10b8b85bc259..7b52600c9352 100644
--- a/drivers/media/video/cx231xx/cx231xx-cards.c
+++ b/drivers/media/video/cx231xx/cx231xx-cards.c
@@ -1070,8 +1070,7 @@ static int cx231xx_usb_probe(struct usb_interface *in=
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
diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/oma=
p/omap_vout.c
index d34521537767..6e84fa0f0cd3 100644
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -1003,11 +1003,12 @@ static int omap_vout_open(struct file *file)
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
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 89b85838cf3f..e1596e56dd40 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2290,6 +2290,7 @@ static int panic_nand_write(struct mtd_info *mtd, lof=
f_t to, size_t len,
 			    size_t *retlen, const uint8_t *buf)
 {
 	struct nand_chip *chip =3D mtd->priv;
+	int chipnr =3D (int)(to >> chip->chip_shift);
 	struct mtd_oob_ops ops;
 	int ret;
=20
@@ -2299,12 +2300,14 @@ static int panic_nand_write(struct mtd_info *mtd, l=
off_t to, size_t len,
 	if (!len)
 		return 0;
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
diff --git a/drivers/net/wireless/rt2x00/rt2x00usb.c b/drivers/net/wireless=
/rt2x00/rt2x00usb.c
index ba28807c0ebd..f62b7ec676d1 100644
--- a/drivers/net/wireless/rt2x00/rt2x00usb.c
+++ b/drivers/net/wireless/rt2x00/rt2x00usb.c
@@ -64,7 +64,7 @@ int rt2x00usb_vendor_request(struct rt2x00_dev *rt2x00dev,
 		 * -ENODEV: Device has disappeared, no point continuing.
 		 * All other errors: Try again.
 		 */
-		else if (status =3D=3D -ENODEV) {
+		else if (status =3D=3D -ENODEV || status =3D=3D -ENOENT) {
 			clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
 			break;
 		}
@@ -311,7 +311,7 @@ static bool rt2x00usb_kick_tx_entry(struct queue_entry =
*entry, void* data)
=20
 	status =3D usb_submit_urb(entry_priv->urb, GFP_ATOMIC);
 	if (status) {
-		if (status =3D=3D -ENODEV)
+		if (status =3D=3D -ENODEV || status =3D=3D -ENOENT)
 			clear_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
 		set_bit(ENTRY_DATA_IO_FAILED, &entry->flags);
 		rt2x00lib_dmadone(entry);
@@ -400,7 +400,7 @@ static bool rt2x00usb_kick_rx_entry(struct queue_entry =
*entry, void* data)
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
index 21addfa2f89e..8bca1d7a524a 100644
--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -367,7 +367,14 @@ static pci_ers_result_t broadcast_error_message(struct=
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
diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 565742b9f0d0..3b58f94be227 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -749,9 +749,23 @@ EXPORT_SYMBOL_GPL(rtc_irq_set_freq);
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
+	if (!next || timer->node.expires.tv64 < next->expires.tv64) {
 		struct rtc_wkalrm alarm;
 		int err;
 		alarm.time =3D rtc_ktime_to_tm(timer->node.expires);
diff --git a/drivers/scsi/bfa/bfad_debugfs.c b/drivers/scsi/bfa/bfad_debugf=
s.c
index dee1a094c2c2..8b3ee6fcab1c 100644
--- a/drivers/scsi/bfa/bfad_debugfs.c
+++ b/drivers/scsi/bfa/bfad_debugfs.c
@@ -276,7 +276,8 @@ bfad_debugfs_write_regrd(struct file *file, const char =
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
@@ -296,7 +297,7 @@ bfad_debugfs_write_regrd(struct file *file, const char =
__user *buf,
 	}
=20
 	rc =3D sscanf(kern_buf, "%x:%x", &addr, &len);
-	if (rc < 2) {
+	if (rc < 2 || len > (UINT_MAX >> 2)) {
 		printk(KERN_INFO
 			"bfad[%d]: %s failed to read user buf\n",
 			bfad->inst_no, __func__);
diff --git a/drivers/staging/media/as102/as102_fw.c b/drivers/staging/media=
/as102/as102_fw.c
index c019df933cc9..9ff1595b067f 100644
--- a/drivers/staging/media/as102/as102_fw.c
+++ b/drivers/staging/media/as102/as102_fw.c
@@ -106,20 +106,25 @@ static int as102_firmware_upload(struct as102_bus_ada=
pter_t *bus_adap,
 				 unsigned char *cmd,
 				 const struct firmware *firmware) {
=20
-	struct as10x_fw_pkt_t fw_pkt;
+	struct as10x_fw_pkt_t *fw_pkt;
 	int total_read_bytes =3D 0, errno =3D 0;
 	unsigned char addr_has_changed =3D 0;
=20
 	ENTER();
=20
+	fw_pkt =3D kmalloc(sizeof(*fw_pkt), GFP_KERNEL);
+	if (!fw_pkt)
+		return -ENOMEM;
+
+
 	for (total_read_bytes =3D 0; total_read_bytes < firmware->size; ) {
 		int read_bytes =3D 0, data_len =3D 0;
=20
 		/* parse intel hex line */
 		read_bytes =3D parse_hex_line(
 				(u8 *) (firmware->data + total_read_bytes),
-				fw_pkt.raw.address,
-				fw_pkt.raw.data,
+				fw_pkt->raw.address,
+				fw_pkt->raw.data,
 				&data_len,
 				&addr_has_changed);
=20
@@ -129,28 +134,28 @@ static int as102_firmware_upload(struct as102_bus_ada=
pter_t *bus_adap,
 		/* detect the end of file */
 		total_read_bytes +=3D read_bytes;
 		if (total_read_bytes =3D=3D firmware->size) {
-			fw_pkt.u.request[0] =3D 0x00;
-			fw_pkt.u.request[1] =3D 0x03;
+			fw_pkt->u.request[0] =3D 0x00;
+			fw_pkt->u.request[1] =3D 0x03;
=20
 			/* send EOF command */
 			errno =3D bus_adap->ops->upload_fw_pkt(bus_adap,
 							     (uint8_t *)
-							     &fw_pkt, 2, 0);
+							     fw_pkt, 2, 0);
 			if (errno < 0)
 				goto error;
 		} else {
 			if (!addr_has_changed) {
 				/* prepare command to send */
-				fw_pkt.u.request[0] =3D 0x00;
-				fw_pkt.u.request[1] =3D 0x01;
+				fw_pkt->u.request[0] =3D 0x00;
+				fw_pkt->u.request[1] =3D 0x01;
=20
-				data_len +=3D sizeof(fw_pkt.u.request);
-				data_len +=3D sizeof(fw_pkt.raw.address);
+				data_len +=3D sizeof(fw_pkt->u.request);
+				data_len +=3D sizeof(fw_pkt->raw.address);
=20
 				/* send cmd to device */
 				errno =3D bus_adap->ops->upload_fw_pkt(bus_adap,
 								     (uint8_t *)
-								     &fw_pkt,
+								     fw_pkt,
 								     data_len,
 								     0);
 				if (errno < 0)
@@ -159,6 +164,7 @@ static int as102_firmware_upload(struct as102_bus_adapt=
er_t *bus_adap,
 		}
 	}
 error:
+	kfree(fw_pkt);
 	LEAVE();
 	return (errno =3D=3D 0) ? total_read_bytes : errno;
 }
diff --git a/drivers/staging/usbip/stub_rx.c b/drivers/staging/usbip/stub_r=
x.c
index 6b4e3e182de8..22d933183cb9 100644
--- a/drivers/staging/usbip/stub_rx.c
+++ b/drivers/staging/usbip/stub_rx.c
@@ -350,32 +350,34 @@ static struct stub_priv *stub_priv_alloc(struct stub_=
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
-#if 0
-	/* epnum 0 is always control */
-	if (epnum =3D=3D 0) {
-		if (dir =3D=3D USBIP_DIR_OUT)
-			return usb_sndctrlpipe(udev, 0);
-		else
-			return usb_rcvctrlpipe(udev, 0);
+
+	/* validate transfer_buffer_length */
+	if (pdu->u.cmd_submit.transfer_buffer_length > INT_MAX) {
+		dev_err(&sdev->interface->dev,
+			"CMD_SUBMIT: -EMSGSIZE transfer_buffer_length %d\n",
+			pdu->u.cmd_submit.transfer_buffer_length);
+		return -1;
 	}
-#endif
+
 	if (usb_endpoint_xfer_control(epd)) {
 		if (dir =3D=3D USBIP_DIR_OUT)
 			return usb_sndctrlpipe(udev, epnum);
@@ -398,15 +400,31 @@ static int get_pipe(struct stub_device *sdev, int epn=
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
+			dev_err(&sdev->interface->dev,
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
+	dev_err(&sdev->interface->dev, "CMD_SUBMIT: invalid epnum %d\n", epnum);
+	return -1;
 }
=20
 static void masking_bogus_flags(struct urb *urb)
@@ -470,7 +488,10 @@ static void stub_recv_cmd_submit(struct stub_device *s=
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
@@ -490,7 +511,8 @@ static void stub_recv_cmd_submit(struct stub_device *sd=
ev,
 	}
=20
 	/* set priv->urb->transfer_buffer */
-	if (pdu->u.cmd_submit.transfer_buffer_length > 0) {
+	if (pdu->u.cmd_submit.transfer_buffer_length > 0 &&
+	    pdu->u.cmd_submit.transfer_buffer_length <=3D INT_MAX) {
 		priv->urb->transfer_buffer =3D
 			kzalloc(pdu->u.cmd_submit.transfer_buffer_length,
 				GFP_KERNEL);
diff --git a/drivers/staging/usbip/stub_tx.c b/drivers/staging/usbip/stub_t=
x.c
index 1d01109017bb..af6cb2ecd4b3 100644
--- a/drivers/staging/usbip/stub_tx.c
+++ b/drivers/staging/usbip/stub_tx.c
@@ -178,6 +178,13 @@ static int stub_send_ret_submit(struct stub_device *sd=
ev)
 		memset(&pdu_header, 0, sizeof(pdu_header));
 		memset(&msg, 0, sizeof(msg));
=20
+		if (urb->actual_length > 0 && !urb->transfer_buffer) {
+			dev_err(&sdev->interface->dev,
+				"urb: actual_length %d transfer_buffer null\n",
+				urb->actual_length);
+			return -1;
+		}
+
 		if (usb_pipetype(urb->pipe) =3D=3D PIPE_ISOCHRONOUS)
 			iovnum =3D 2 + urb->number_of_packets;
 		else
diff --git a/drivers/staging/usbip/usbip_common.h b/drivers/staging/usbip/u=
sbip_common.h
index e547dba77845..1d854f87e476 100644
--- a/drivers/staging/usbip/usbip_common.h
+++ b/drivers/staging/usbip/usbip_common.h
@@ -276,6 +276,7 @@ struct usbip_device {
 	/* lock for status */
 	spinlock_t lock;
=20
+	int sockfd;
 	struct socket *tcp_socket;
=20
 	struct task_struct *tcp_rx;
diff --git a/drivers/staging/usbip/userspace/libsrc/usbip_common.c b/driver=
s/staging/usbip/userspace/libsrc/usbip_common.c
index 154b4b1103ec..8751ebd7ccc4 100644
--- a/drivers/staging/usbip/userspace/libsrc/usbip_common.c
+++ b/drivers/staging/usbip/userspace/libsrc/usbip_common.c
@@ -164,7 +164,7 @@ int read_attr_speed(struct sysfs_device *dev)
 		goto err;
 	}
=20
-	ret =3D sscanf(attr->value, "%s\n", speed);
+	ret =3D sscanf(attr->value, "%99s\n", speed);
 	if (ret < 1) {
 		dbg("sscanf failed");
 		goto err;
diff --git a/drivers/staging/usbip/userspace/libsrc/vhci_driver.c b/drivers=
/staging/usbip/userspace/libsrc/vhci_driver.c
index 269787751b20..1c91becaaa4a 100644
--- a/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
+++ b/drivers/staging/usbip/userspace/libsrc/vhci_driver.c
@@ -63,12 +63,12 @@ static int parse_status(char *value)
=20
 	while (*c !=3D '\0') {
 		int port, status, speed, devid;
-		unsigned long socket;
+		int sockfd;
 		char lbusid[SYSFS_BUS_ID_SIZE];
=20
-		ret =3D sscanf(c, "%d %d %d %x %lx %s\n",
+		ret =3D sscanf(c, "%d %d %d %x %u %31s\n",
 				&port, &status, &speed,
-				&devid, &socket, lbusid);
+				&devid, &sockfd, lbusid);
=20
 		if (ret < 5) {
 			dbg("sscanf failed: %d", ret);
@@ -77,7 +77,7 @@ static int parse_status(char *value)
=20
 		dbg("port %d status %d speed %d devid %x",
 				port, status, speed, devid);
-		dbg("socket %lx lbusid %s", socket, lbusid);
+		dbg("sockfd %u lbusid %s", sockfd, lbusid);
=20
=20
 		/* if a device is connected, look at it */
diff --git a/drivers/staging/usbip/vhci_hcd.c b/drivers/staging/usbip/vhci_=
hcd.c
index 68f9af85b9cb..0bea1cb70307 100644
--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -391,29 +391,6 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
 				dum->port_status[rhport] |=3D
 					USB_PORT_STAT_ENABLE;
 			}
-#if 0
-			if (dum->driver) {
-				dum->port_status[rhport] |=3D
-					USB_PORT_STAT_ENABLE;
-				/* give it the best speed we agree on */
-				dum->gadget.speed =3D dum->driver->speed;
-				dum->gadget.ep0->maxpacket =3D 64;
-				switch (dum->gadget.speed) {
-				case USB_SPEED_HIGH:
-					dum->port_status[rhport] |=3D
-						USB_PORT_STAT_HIGH_SPEED;
-					break;
-				case USB_SPEED_LOW:
-					dum->gadget.ep0->maxpacket =3D 8;
-					dum->port_status[rhport] |=3D
-						USB_PORT_STAT_LOW_SPEED;
-					break;
-				default:
-					dum->gadget.speed =3D USB_SPEED_FULL;
-					break;
-				}
-			}
-#endif
 		}
 		((u16 *) buf)[0] =3D cpu_to_le16(dum->port_status[rhport]);
 		((u16 *) buf)[1] =3D cpu_to_le16(dum->port_status[rhport] >> 16);
@@ -430,15 +407,6 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
 		case USB_PORT_FEAT_SUSPEND:
 			usbip_dbg_vhci_rh(" SetPortFeature: "
 					  "USB_PORT_FEAT_SUSPEND\n");
-#if 0
-			dum->port_status[rhport] |=3D
-				(1 << USB_PORT_FEAT_SUSPEND);
-			if (dum->driver->suspend) {
-				spin_unlock(&dum->lock);
-				dum->driver->suspend(&dum->gadget);
-				spin_lock(&dum->lock);
-			}
-#endif
 			break;
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(" SetPortFeature: "
@@ -449,13 +417,6 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
 					~(USB_PORT_STAT_ENABLE |
 					  USB_PORT_STAT_LOW_SPEED |
 					  USB_PORT_STAT_HIGH_SPEED);
-#if 0
-				if (dum->driver) {
-					dev_dbg(hardware, "disconnect\n");
-					stop_activity(dum, dum->driver);
-				}
-#endif
-
 				/* FIXME test that code path! */
 			}
 			/* 50msec reset signaling */
diff --git a/drivers/staging/usbip/vhci_sysfs.c b/drivers/staging/usbip/vhc=
i_sysfs.c
index 0cd039bb5fd6..ae305d05bf2d 100644
--- a/drivers/staging/usbip/vhci_sysfs.c
+++ b/drivers/staging/usbip/vhci_sysfs.c
@@ -38,13 +38,18 @@ static ssize_t show_status(struct device *dev, struct d=
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
 	out +=3D sprintf(out, "prt sta spd bus dev socket           "
 		       "local_busid\n");
@@ -58,7 +63,7 @@ static ssize_t show_status(struct device *dev, struct dev=
ice_attribute *attr,
 		if (vdev->ud.status =3D=3D VDEV_ST_USED) {
 			out +=3D sprintf(out, "%03u %08x ",
 				       vdev->speed, vdev->devid);
-			out +=3D sprintf(out, "%16p ", vdev->ud.tcp_socket);
+			out +=3D sprintf(out, "%u", vdev->ud.sockfd);
 			out +=3D sprintf(out, "%s", dev_name(&vdev->udev->dev));
=20
 		} else {
@@ -215,6 +220,7 @@ static ssize_t store_attach(struct device *dev, struct =
device_attribute *attr,
=20
 	vdev->devid         =3D devid;
 	vdev->speed         =3D speed;
+	vdev->ud.sockfd     =3D sockfd;
 	vdev->ud.tcp_socket =3D socket;
 	vdev->ud.status     =3D VDEV_ST_NOTASSIGNED;
=20
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index bf5de831ec4f..caf710028b30 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1402,6 +1402,18 @@ static int proc_unlinkurb(struct dev_state *ps, void=
 __user *arg)
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
@@ -1409,6 +1421,7 @@ static int processcompl(struct async *as, void __user=
 * __user *arg)
 	void __user *addr =3D as->userurb;
 	unsigned int i;
=20
+	compute_isochronous_actual_length(urb);
 	if (as->userbuffer && urb->actual_length) {
 		if (urb->number_of_packets > 0)		/* Isochronous */
 			i =3D urb->transfer_buffer_length;
@@ -1581,6 +1594,7 @@ static int processcompl_compat(struct async *as, void=
 __user * __user *arg)
 	void __user *addr =3D as->userurb;
 	unsigned int i;
=20
+	compute_isochronous_actual_length(urb);
 	if (as->userbuffer && urb->actual_length) {
 		if (urb->number_of_packets > 0)		/* Isochronous */
 			i =3D urb->transfer_buffer_length;
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 512c2a4493f8..84ee955a000d 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -205,6 +205,9 @@ static const struct usb_device_id usb_quirk_list[] =3D {
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
index 0c1c8ca85e1f..23fd89092f87 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -142,6 +142,7 @@ struct garmin_data {
 	__u8   privpkt[4*6];
 	spinlock_t lock;
 	struct list_head pktlist;
+	struct usb_anchor write_urbs;
 };
=20
=20
@@ -923,13 +924,19 @@ static int garmin_init_session(struct usb_serial_port=
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
@@ -950,7 +957,6 @@ static int garmin_open(struct tty_struct *tty, struct u=
sb_serial_port *port)
 	spin_unlock_irqrestore(&garmin_data_p->lock, flags);
=20
 	/* shutdown any bulk reads that might be going on */
-	usb_kill_urb(port->write_urb);
 	usb_kill_urb(port->read_urb);
=20
 	if (garmin_data_p->state =3D=3D STATE_RESET)
@@ -977,7 +983,7 @@ static void garmin_close(struct usb_serial_port *port)
=20
 	/* shutdown our urbs */
 	usb_kill_urb(port->read_urb);
-	usb_kill_urb(port->write_urb);
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
=20
 	/* keep reset state so we know that we must start a new session */
 	if (garmin_data_p->state !=3D STATE_RESET)
@@ -1069,12 +1075,14 @@ static int garmin_write_bulk(struct usb_serial_port=
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
@@ -1464,9 +1472,16 @@ static int garmin_attach(struct usb_serial *serial)
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
@@ -1479,6 +1494,7 @@ static void garmin_disconnect(struct usb_serial *seri=
al)
=20
 	dbg("%s", __func__);
=20
+	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
 	usb_kill_urb(port->interrupt_in_urb);
 	del_timer_sync(&garmin_data_p->timer);
 }
diff --git a/drivers/video/udlfb.c b/drivers/video/udlfb.c
index cb5988f15d03..f1dbaeb086bb 100644
--- a/drivers/video/udlfb.c
+++ b/drivers/video/udlfb.c
@@ -765,11 +765,11 @@ static int dlfb_get_edid(struct dlfb_data *dev, char =
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
index 34defa195a80..2e99ded4f780 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -469,6 +469,9 @@ static int v9fs_test_inode(struct inode *inode, void *d=
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
index 781e56e328eb..da24b857dbd1 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -105,6 +105,9 @@ static int v9fs_test_inode_dotl(struct inode *inode, vo=
id *data)
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
index e1fbdeef85db..933738f183d0 100644
--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -88,7 +88,8 @@ static int autofs4_write(struct file *file, const void *a=
ddr, int bytes)
 		spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
=20
-	return (bytes > 0);
+	/* if 'wr' returned 0 (impossible) we assume -EIO (safe) */
+	return bytes =3D=3D 0 ? 0 : wr < 0 ? wr : -EIO;
 }
 =09
 static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
@@ -102,6 +103,7 @@ static void autofs4_notify_daemon(struct autofs_sb_info=
 *sbi,
 	} pkt;
 	struct file *pipe =3D NULL;
 	size_t pktsz;
+	int ret;
=20
 	DPRINTK("wait id =3D 0x%08lx, name =3D %.*s, type=3D%d",
 		(unsigned long) wq->wait_queue_token, wq->name.len, wq->name.name, type);
@@ -110,6 +112,13 @@ static void autofs4_notify_daemon(struct autofs_sb_inf=
o *sbi,
=20
 	pkt.hdr.proto_version =3D sbi->version;
 	pkt.hdr.type =3D type;
+	mutex_lock(&sbi->wq_mutex);
+
+	/* Check if we have become catatonic */
+	if (sbi->catatonic) {
+		mutex_unlock(&sbi->wq_mutex);
+		return;
+	}
 	switch (type) {
 	/* Kernel protocol v4 missing and expire packets */
 	case autofs_ptype_missing:
@@ -163,22 +172,28 @@ static void autofs4_notify_daemon(struct autofs_sb_in=
fo *sbi,
 	}
 	default:
 		printk("autofs4_notify_daemon: bad type %d!\n", type);
+		mutex_unlock(&sbi->wq_mutex);
 		return;
 	}
=20
-	/* Check if we have become catatonic */
-	mutex_lock(&sbi->wq_mutex);
-	if (!sbi->catatonic) {
-		pipe =3D sbi->pipe;
-		get_file(pipe);
-	}
+	pipe =3D sbi->pipe;
+	get_file(pipe);
+
 	mutex_unlock(&sbi->wq_mutex);
=20
-	if (pipe) {
-		if (autofs4_write(pipe, &pkt, pktsz))
-			autofs4_catatonic_mode(sbi);
-		fput(pipe);
+	switch (ret =3D autofs4_write(pipe, &pkt, pktsz)) {
+	case 0:
+		break;
+	case -ENOMEM:
+	case -ERESTARTSYS:
+		/* Just fail this one */
+		autofs4_wait_release(sbi, wq->wait_queue_token, ret);
+		break;
+	default:
+		autofs4_catatonic_mode(sbi);
+		break;
 	}
+	fput(pipe);
 }
=20
 static int autofs4_getpath(struct autofs_sb_info *sbi,
@@ -257,6 +272,9 @@ static int validate_request(struct autofs_wait_queue **=
wait,
 	struct autofs_wait_queue *wq;
 	struct autofs_info *ino;
=20
+	if (sbi->catatonic)
+		return -ENOENT;
+
 	/* Wait in progress, continue; */
 	wq =3D autofs4_find_wait(sbi, qstr);
 	if (wq) {
@@ -289,6 +307,9 @@ static int validate_request(struct autofs_wait_queue **=
wait,
 			if (mutex_lock_interruptible(&sbi->wq_mutex))
 				return -EINTR;
=20
+			if (sbi->catatonic)
+				return -ENOENT;
+
 			wq =3D autofs4_find_wait(sbi, qstr);
 			if (wq) {
 				*wait =3D wq;
@@ -389,7 +410,7 @@ int autofs4_wait(struct autofs_sb_info *sbi, struct den=
try *dentry,
=20
 	ret =3D validate_request(&wq, sbi, &qstr, dentry, notify);
 	if (ret <=3D 0) {
-		if (ret =3D=3D 0)
+		if (ret !=3D -EINTR)
 			mutex_unlock(&sbi->wq_mutex);
 		kfree(qstr.name);
 		return ret;
diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 9727e0c52579..446d6b61c9c2 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -447,8 +447,7 @@ int venus_fsync(struct super_block *sb, struct CodaFid =
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
index ab2248090515..966a31f1fbf8 100644
--- a/fs/ecryptfs/messaging.c
+++ b/fs/ecryptfs/messaging.c
@@ -550,17 +550,17 @@ void ecryptfs_release_messaging(void)
 		mutex_unlock(&ecryptfs_msg_ctx_lists_mux);
 	}
 	if (ecryptfs_daemon_hash) {
-		struct hlist_node *elem;
 		struct ecryptfs_daemon *daemon;
+		struct hlist_node *elem, *n;
 		int i;
=20
 		mutex_lock(&ecryptfs_daemon_hash_mux);
 		for (i =3D 0; i < (1 << ecryptfs_hash_bits); i++) {
 			int rc;
=20
-			hlist_for_each_entry(daemon, elem,
-					     &ecryptfs_daemon_hash[i],
-					     euid_chain) {
+			hlist_for_each_entry_safe(daemon, elem, n,
+						  &ecryptfs_daemon_hash[i],
+						  euid_chain) {
 				rc =3D ecryptfs_exorcise_daemon(daemon);
 				if (rc)
 					printk(KERN_ERR "%s: Error whilst "
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index f9c9793fa94a..2c696a619826 100644
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
index 8f509a030f68..0e7f45f43885 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -151,15 +151,12 @@ const u32 nfs4_fsinfo_bitmap[3] =3D { FATTR4_WORD0_MA=
XFILESIZE
 };
=20
 const u32 nfs4_fs_locations_bitmap[2] =3D {
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
@@ -4805,9 +4802,7 @@ int nfs4_proc_fs_locations(struct inode *dir, const s=
truct qstr *name,
 		struct nfs4_fs_locations *fs_locations, struct page *page)
 {
 	struct nfs_server *server =3D NFS_SERVER(dir);
-	u32 bitmask[2] =3D {
-		[0] =3D FATTR4_WORD0_FSID | FATTR4_WORD0_FS_LOCATIONS,
-	};
+	u32 bitmask[2];
 	struct nfs4_fs_locations_arg args =3D {
 		.dir_fh =3D NFS_FH(dir),
 		.name =3D name,
@@ -4826,12 +4821,15 @@ int nfs4_proc_fs_locations(struct inode *dir, const=
 struct qstr *name,
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
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 6bba1069c40e..3f7c5dfac8c4 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1880,8 +1880,6 @@ static int nilfs_segctor_collect_dirty_files(struct n=
ilfs_sc_info *sci,
 					      "failed to get inode block.\n");
 				return err;
 			}
-			mark_buffer_dirty(ibh);
-			nilfs_mdt_mark_dirty(ifile);
 			spin_lock(&nilfs->ns_inode_lock);
 			if (likely(!ii->i_bh))
 				ii->i_bh =3D ibh;
@@ -1890,6 +1888,10 @@ static int nilfs_segctor_collect_dirty_files(struct =
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
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index b4ebdc12e40b..88614cdbbab0 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7127,7 +7127,7 @@ int ocfs2_truncate_inline(struct inode *inode, struct=
 buffer_head *di_bh,
 	if (end > i_size_read(inode))
 		end =3D i_size_read(inode);
=20
-	BUG_ON(start >=3D end);
+	BUG_ON(start > end);
=20
 	if (!(OCFS2_I(inode)->ip_dyn_features & OCFS2_INLINE_DATA_FL) ||
 	    !(le16_to_cpu(di->i_dyn_features) & OCFS2_INLINE_DATA_FL) ||
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index a678e2287f52..a22b5c9ac56b 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -474,11 +474,6 @@ static int ocfs2_truncate_file(struct inode *inode,
 		goto bail;
 	}
=20
-	/* lets handle the simple truncate cases before doing any more
-	 * cluster locking. */
-	if (new_i_size =3D=3D le64_to_cpu(fe->i_size))
-		goto bail;
-
 	down_write(&OCFS2_I(inode)->ip_alloc_sem);
=20
 	ocfs2_resv_discard(&osb->osb_la_resmap,
@@ -1149,14 +1144,14 @@ int ocfs2_setattr(struct dentry *dentry, struct iat=
tr *attr)
 		goto bail_unlock_rw;
 	}
=20
-	if (size_change && attr->ia_size !=3D i_size_read(inode)) {
+	if (size_change) {
 		status =3D inode_newsize_ok(inode, attr->ia_size);
 		if (status)
 			goto bail_unlock;
=20
 		inode_dio_wait(inode);
=20
-		if (i_size_read(inode) > attr->ia_size) {
+		if (i_size_read(inode) >=3D attr->ia_size) {
 			if (ocfs2_should_order_data(inode)) {
 				status =3D ocfs2_begin_ordered_truncate(inode,
 								      attr->ia_size);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c7e834bb1658..fa3cd7fad5cc 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -361,6 +361,7 @@ struct request_queue {
 	int			node;
 #ifdef CONFIG_BLK_DEV_IO_TRACE
 	struct blk_trace	*blk_trace;
+	struct mutex		blk_trace_mutex;
 #endif
 	/*
 	 * for flush operations
diff --git a/include/linux/usb/ch9.h b/include/linux/usb/ch9.h
index 046b1f4382df..68a3b10d8e0b 100644
--- a/include/linux/usb/ch9.h
+++ b/include/linux/usb/ch9.h
@@ -390,6 +390,11 @@ struct usb_endpoint_descriptor {
 #define USB_ENDPOINT_XFER_INT		3
 #define USB_ENDPOINT_MAX_ADJUSTABLE	0x80
=20
+#define USB_EP_MAXP_MULT_SHIFT	11
+#define USB_EP_MAXP_MULT_MASK	(3 << USB_EP_MAXP_MULT_SHIFT)
+#define USB_EP_MAXP_MULT(m) \
+	(((m) & USB_EP_MAXP_MULT_MASK) >> USB_EP_MAXP_MULT_SHIFT)
+
 #define USB_ENDPOINT_SYNCTYPE		0x0c
 #define USB_ENDPOINT_SYNC_NONE		(0 << 2)
 #define USB_ENDPOINT_SYNC_ASYNC		(1 << 2)
@@ -592,6 +597,20 @@ static inline int usb_endpoint_maxp(const struct usb_e=
ndpoint_descriptor *epd)
 	return __le16_to_cpu(epd->wMaxPacketSize);
 }
=20
+/**
+ * usb_endpoint_maxp_mult - get endpoint's transactional opportunities
+ * @epd: endpoint to be checked
+ *
+ * Return @epd's wMaxPacketSize[12:11] + 1
+ */
+static inline int
+usb_endpoint_maxp_mult(const struct usb_endpoint_descriptor *epd)
+{
+	int maxp =3D __le16_to_cpu(epd->wMaxPacketSize);
+
+	return USB_EP_MAXP_MULT(maxp) + 1;
+}
+
 /*------------------------------------------------------------------------=
-*/
=20
 /* USB_DT_SS_ENDPOINT_COMP: SuperSpeed Endpoint Companion descriptor */
diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
index 505eca3ce49a..343929bed649 100644
--- a/include/net/sctp/sctp.h
+++ b/include/net/sctp/sctp.h
@@ -705,6 +705,8 @@ static inline void sctp_v6_map_v4(union sctp_addr *addr)
 static inline void sctp_v4_map_v6(union sctp_addr *addr)
 {
 	addr->v6.sin6_family =3D AF_INET6;
+	addr->v6.sin6_flowinfo =3D 0;
+	addr->v6.sin6_scope_id =3D 0;
 	addr->v6.sin6_port =3D addr->v4.sin_port;
 	addr->v6.sin6_addr.s6_addr32[3] =3D addr->v4.sin_addr.s_addr;
 	addr->v6.sin6_addr.s6_addr32[0] =3D 0;
diff --git a/include/net/sctp/structs.h b/include/net/sctp/structs.h
index 9069f8df7ed1..c6f6d6019150 100644
--- a/include/net/sctp/structs.h
+++ b/include/net/sctp/structs.h
@@ -603,10 +603,6 @@ struct sctp_af {
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
@@ -647,7 +643,9 @@ struct sctp_pf {
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
diff --git a/kernel/cpu.c b/kernel/cpu.c
index f735a58bf7b4..00251dd8d9e6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -406,14 +406,6 @@ int __cpuinit cpu_up(unsigned int cpu)
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
=20
-void __weak arch_disable_nonboot_cpus_begin(void)
-{
-}
-
-void __weak arch_disable_nonboot_cpus_end(void)
-{
-}
-
 int disable_nonboot_cpus(void)
 {
 	int cpu, first_cpu, error =3D 0;
@@ -425,7 +417,6 @@ int disable_nonboot_cpus(void)
 	 * with the userspace trying to use the CPU hotplug at the same time
 	 */
 	cpumask_clear(frozen_cpus);
-	arch_disable_nonboot_cpus_begin();
=20
 	printk("Disabling non-boot CPUs ...\n");
 	for_each_online_cpu(cpu) {
@@ -441,8 +432,6 @@ int disable_nonboot_cpus(void)
 		}
 	}
=20
-	arch_disable_nonboot_cpus_end();
-
 	if (!error) {
 		BUG_ON(num_online_cpus() > 1);
 		/* Make sure the CPUs won't be enabled by someone else */
diff --git a/kernel/extable.c b/kernel/extable.c
index 5339705b8241..ce211bb6aea9 100644
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
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 92cac05aa7d1..c1dfb6545dae 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -296,7 +296,7 @@ static void blk_trace_cleanup(struct blk_trace *bt)
 		blk_unregister_tracepoints();
 }
=20
-int blk_trace_remove(struct request_queue *q)
+static int __blk_trace_remove(struct request_queue *q)
 {
 	struct blk_trace *bt;
=20
@@ -309,6 +309,17 @@ int blk_trace_remove(struct request_queue *q)
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
 static int blk_dropped_open(struct inode *inode, struct file *filp)
@@ -538,9 +549,8 @@ int do_blk_trace_setup(struct request_queue *q, char *n=
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
@@ -559,6 +569,19 @@ int blk_trace_setup(struct request_queue *q, char *nam=
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
@@ -596,7 +619,7 @@ static int compat_blk_trace_setup(struct request_queue =
*q, char *name,
 }
 #endif
=20
-int blk_trace_startstop(struct request_queue *q, int start)
+static int __blk_trace_startstop(struct request_queue *q, int start)
 {
 	int ret;
 	struct blk_trace *bt =3D q->blk_trace;
@@ -629,8 +652,25 @@ int blk_trace_startstop(struct request_queue *q, int s=
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
@@ -648,12 +688,12 @@ int blk_trace_ioctl(struct block_device *bdev, unsign=
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
@@ -664,17 +704,17 @@ int blk_trace_ioctl(struct block_device *bdev, unsign=
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
@@ -685,10 +725,14 @@ int blk_trace_ioctl(struct block_device *bdev, unsign=
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
@@ -1660,7 +1704,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct devic=
e *dev,
 	if (q =3D=3D NULL)
 		goto out_bdput;
=20
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&q->blk_trace_mutex);
=20
 	if (attr =3D=3D &dev_attr_enable) {
 		ret =3D sprintf(buf, "%u\n", !!q->blk_trace);
@@ -1679,7 +1723,7 @@ static ssize_t sysfs_blk_trace_attr_show(struct devic=
e *dev,
 		ret =3D sprintf(buf, "%llu\n", q->blk_trace->end_lba);
=20
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&q->blk_trace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
@@ -1721,7 +1765,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct devi=
ce *dev,
 	if (q =3D=3D NULL)
 		goto out_bdput;
=20
-	mutex_lock(&bdev->bd_mutex);
+	mutex_lock(&q->blk_trace_mutex);
=20
 	if (attr =3D=3D &dev_attr_enable) {
 		if (value)
@@ -1747,7 +1791,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct devi=
ce *dev,
 	}
=20
 out_unlock_bdev:
-	mutex_unlock(&bdev->bd_mutex);
+	mutex_unlock(&q->blk_trace_mutex);
 out_bdput:
 	bdput(bdev);
 out:
diff --git a/net/9p/client.c b/net/9p/client.c
index 87173bb26410..3e61ba193bd9 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -740,8 +740,7 @@ p9_client_rpc(struct p9_client *c, int8_t type, const c=
har *fmt, ...)
 		goto reterr;
 	}
 	/* Wait for the response */
-	err =3D wait_event_interruptible(*req->wq,
-				       req->status >=3D REQ_STATUS_RCVD);
+	err =3D wait_event_killable(*req->wq, req->status >=3D REQ_STATUS_RCVD);
=20
 	if (req->status =3D=3D REQ_STATUS_ERROR) {
 		P9_DPRINTK(P9_DEBUG_ERROR, "req_status error %d\n", req->t_err);
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 55f0c09da5a4..0a05ac1056ef 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -276,8 +276,8 @@ p9_virtio_request(struct p9_client *client, struct p9_r=
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
@@ -309,7 +309,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 		 * Other zc request to finish here
 		 */
 		if (atomic_read(&vp_pinned) >=3D chan->p9_max_pages) {
-			err =3D wait_event_interruptible(vp_wq,
+			err =3D wait_event_killable(vp_wq,
 			      (atomic_read(&vp_pinned) < chan->p9_max_pages));
 			if (err =3D=3D -ERESTARTSYS)
 				return err;
@@ -419,8 +419,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p=
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
@@ -438,8 +438,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p=
9_req_t *req,
 	virtqueue_kick(chan->vq);
 	spin_unlock_irqrestore(&chan->lock, flags);
 	P9_DPRINTK(P9_DEBUG_TRANS, "9p debug: virtio request kicked\n");
-	err =3D wait_event_interruptible(*req->wq,
-				       req->status >=3D REQ_STATUS_RCVD);
+	err =3D wait_event_killable(*req->wq, req->status >=3D REQ_STATUS_RCVD);
 	/*
 	 * Non kernel buffers are pinned, unpin them
 	 */
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 5fa906881b86..d5fe136ed0b8 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -327,8 +327,8 @@ struct l2tp_session *l2tp_session_get_by_ifname(const s=
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
@@ -377,6 +377,10 @@ static int l2tp_session_add_to_tunnel(struct l2tp_tunn=
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
@@ -386,6 +390,7 @@ static int l2tp_session_add_to_tunnel(struct l2tp_tunne=
l *tunnel,
=20
 	return err;
 }
+EXPORT_SYMBOL_GPL(l2tp_session_register);
=20
 /* Lookup a tunnel by id
  */
@@ -830,6 +835,23 @@ void l2tp_recv_common(struct l2tp_session *session, st=
ruct sk_buff *skb,
 }
 EXPORT_SYMBOL(l2tp_recv_common);
=20
+/* Drop skbs from the session's reorder_q
+ */
+int l2tp_session_queue_purge(struct l2tp_session *session)
+{
+	struct sk_buff *skb =3D NULL;
+	BUG_ON(!session);
+	BUG_ON(session->magic !=3D L2TP_SESSION_MAGIC);
+	while ((skb =3D skb_dequeue(&session->reorder_q))) {
+		session->stats.rx_errors++;
+		kfree_skb(skb);
+		if (session->deref)
+			(*session->deref)(session);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(l2tp_session_queue_purge);
+
 /* Internal UDP receive frame. Do the real work of receiving an L2TP data =
frame
  * here. The skb is not on a list when we get here.
  * Returns 0 if the packet was a data packet and was successfully passed o=
n.
@@ -1330,6 +1352,8 @@ static void l2tp_tunnel_closeall(struct l2tp_tunnel *=
tunnel)
 				synchronize_rcu();
 			}
=20
+			l2tp_session_queue_purge(session);
+
 			if (session->session_close !=3D NULL)
 				(*session->session_close)(session);
=20
@@ -1652,6 +1676,8 @@ EXPORT_SYMBOL_GPL(l2tp_session_free);
  */
 int l2tp_session_delete(struct l2tp_session *session)
 {
+	l2tp_session_queue_purge(session);
+
 	if (session->session_close !=3D NULL)
 		(*session->session_close)(session);
=20
@@ -1682,7 +1708,6 @@ static void l2tp_session_set_header_len(struct l2tp_s=
ession *session, int versio
 struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp_tunnel=
 *tunnel, u32 session_id, u32 peer_session_id, struct l2tp_session_cfg *cfg)
 {
 	struct l2tp_session *session;
-	int err;
=20
 	session =3D kzalloc(sizeof(struct l2tp_session) + priv_size, GFP_KERNEL);
 	if (session !=3D NULL) {
@@ -1731,17 +1756,6 @@ struct l2tp_session *l2tp_session_create(int priv_si=
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
index c7ad6b9835dd..316937958216 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -246,9 +246,12 @@ extern struct l2tp_tunnel *l2tp_tunnel_find_nth(struct=
 net *net, int nth);
 extern int l2tp_tunnel_create(struct net *net, int fd, int version, u32 tu=
nnel_id, u32 peer_tunnel_id, struct l2tp_tunnel_cfg *cfg, struct l2tp_tunne=
l **tunnelp);
 extern int l2tp_tunnel_delete(struct l2tp_tunnel *tunnel);
 extern struct l2tp_session *l2tp_session_create(int priv_size, struct l2tp=
_tunnel *tunnel, u32 session_id, u32 peer_session_id, struct l2tp_session_c=
fg *cfg);
+int l2tp_session_register(struct l2tp_session *session,
+			  struct l2tp_tunnel *tunnel);
 extern int l2tp_session_delete(struct l2tp_session *session);
 extern void l2tp_session_free(struct l2tp_session *session);
 extern void l2tp_recv_common(struct l2tp_session *session, struct sk_buff =
*skb, unsigned char *ptr, unsigned char *optr, u16 hdrflags, int length, in=
t (*payload_hook)(struct sk_buff *skb));
+extern int l2tp_session_queue_purge(struct l2tp_session *session);
 extern int l2tp_udp_encap_recv(struct sock *sk, struct sk_buff *skb);
=20
 extern int l2tp_xmit_skb(struct l2tp_session *session, struct sk_buff *skb=
, int hdr_len);
diff --git a/net/l2tp/l2tp_eth.c b/net/l2tp/l2tp_eth.c
index ec1148c1f12d..35c897357ea3 100644
--- a/net/l2tp/l2tp_eth.c
+++ b/net/l2tp/l2tp_eth.c
@@ -43,7 +43,7 @@ struct l2tp_eth {
=20
 /* via l2tp_session_priv() */
 struct l2tp_eth_sess {
-	struct net_device	*dev;
+	struct net_device __rcu *dev;
 };
=20
=20
@@ -60,7 +60,14 @@ static int l2tp_eth_dev_init(struct net_device *dev)
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
@@ -93,7 +100,7 @@ static void l2tp_eth_dev_setup(struct net_device *dev)
 static void l2tp_eth_dev_recv(struct l2tp_session *session, struct sk_buff=
 *skb, int data_len)
 {
 	struct l2tp_eth_sess *spriv =3D l2tp_session_priv(session);
-	struct net_device *dev =3D spriv->dev;
+	struct net_device *dev;
=20
 	if (session->debug & L2TP_MSG_DATA) {
 		unsigned int length;
@@ -125,14 +132,22 @@ static void l2tp_eth_dev_recv(struct l2tp_session *se=
ssion, struct sk_buff *skb,
 	skb_dst_drop(skb);
 	nf_reset(skb);
=20
+	rcu_read_lock();
+	dev =3D rcu_dereference(spriv->dev);
+	if (!dev)
+		goto error_rcu;
+
 	if (dev_forward_skb(dev, skb) =3D=3D NET_RX_SUCCESS) {
 		dev->stats.rx_packets++;
 		dev->stats.rx_bytes +=3D data_len;
 	} else
 		dev->stats.rx_errors++;
+	rcu_read_unlock();
=20
 	return;
=20
+error_rcu:
+	rcu_read_unlock();
 error:
 	dev->stats.rx_errors++;
 	kfree_skb(skb);
@@ -145,11 +160,15 @@ static void l2tp_eth_delete(struct l2tp_session *sess=
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
@@ -159,9 +178,20 @@ static void l2tp_eth_show(struct seq_file *m, void *ar=
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
@@ -181,7 +211,7 @@ static int l2tp_eth_create(struct net *net, struct l2tp=
_tunnel *tunnel,
 		if (dev) {
 			dev_put(dev);
 			rc =3D -EEXIST;
-			goto out;
+			goto err;
 		}
 		strlcpy(name, cfg->ifname, IFNAMSIZ);
 	} else
@@ -191,13 +221,13 @@ static int l2tp_eth_create(struct net *net, struct l2=
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
@@ -218,26 +248,48 @@ static int l2tp_eth_create(struct net *net, struct l2=
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
index c67e9f6243f1..f25cb19bc22d 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -95,6 +95,7 @@
 #include <net/ip.h>
 #include <net/udp.h>
 #include <net/xfrm.h>
+#include <net/inet_common.h>
=20
 #include <asm/byteorder.h>
 #include <linux/atomic.h>
@@ -125,8 +126,11 @@
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
@@ -141,6 +145,24 @@ static const struct ppp_channel_ops pppol2tp_chan_ops =
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
@@ -228,7 +250,8 @@ static void pppol2tp_recv(struct l2tp_session *session,=
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
@@ -264,31 +287,17 @@ static void pppol2tp_recv(struct l2tp_session *sessio=
n, struct sk_buff *skb, int
 		session->stats.rx_errors++;
 		kfree_skb(skb);
 	}
+	rcu_read_unlock();
=20
 	return;
=20
 no_sock:
+	rcu_read_unlock();
 	PRINTK(session->debug, PPPOL2TP_MSG_DATA, KERN_INFO,
 	       "%s: no socket\n", session->name);
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
@@ -458,36 +467,17 @@ static int pppol2tp_xmit(struct ppp_channel *chan, st=
ruct sk_buff *skb)
  */
 static void pppol2tp_session_close(struct l2tp_session *session)
 {
-	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
-	struct sock *sk =3D ps->sock;
-	struct sk_buff *skb;
+	struct sock *sk;
=20
 	BUG_ON(session->magic !=3D L2TP_SESSION_MAGIC);
=20
-	if (session->session_id =3D=3D 0)
-		goto out;
-
-	if (sk !=3D NULL) {
-		lock_sock(sk);
-
-		if (sk->sk_state & (PPPOX_CONNECTED | PPPOX_BOUND)) {
-			pppox_unbind_sock(sk);
-			sk->sk_state =3D PPPOX_DEAD;
-			sk->sk_state_change(sk);
-		}
=20
-		/* Purge any queued data */
-		skb_queue_purge(&sk->sk_receive_queue);
-		skb_queue_purge(&sk->sk_write_queue);
-		while ((skb =3D skb_dequeue(&session->reorder_q))) {
-			kfree_skb(skb);
-			sock_put(sk);
-		}
-
-		release_sock(sk);
+	sk =3D pppol2tp_session_get_sock(session);
+	if (sk) {
+		if (sk->sk_socket)
+			inet_shutdown(sk->sk_socket, SEND_SHUTDOWN);
+		sock_put(sk);
 	}
-
-out:
 	return;
 }
=20
@@ -512,6 +502,14 @@ static void pppol2tp_session_destruct(struct sock *sk)
 	return;
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
@@ -537,17 +535,26 @@ static int pppol2tp_release(struct socket *sock)
=20
 	session =3D pppol2tp_sock_to_session(sk);
=20
-	/* Purge any queued data */
-	skb_queue_purge(&sk->sk_receive_queue);
-	skb_queue_purge(&sk->sk_write_queue);
 	if (session !=3D NULL) {
-		struct sk_buff *skb;
-		while ((skb =3D skb_dequeue(&session->reorder_q))) {
-			kfree_skb(skb);
-			sock_put(sk);
-		}
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
+	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge(&sk->sk_write_queue);
=20
 	release_sock(sk);
=20
@@ -614,16 +621,47 @@ static int pppol2tp_create(struct net *net, struct so=
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
@@ -636,7 +674,6 @@ static int pppol2tp_connect(struct socket *sock, struct=
 sockaddr *uservaddr,
 	struct l2tp_session *session =3D NULL;
 	struct l2tp_tunnel *tunnel;
 	struct pppol2tp_session *ps;
-	struct dst_entry *dst;
 	struct l2tp_session_cfg cfg =3D { 0, };
 	int error =3D 0;
 	u32 tunnel_id, peer_tunnel_id;
@@ -733,13 +770,17 @@ static int pppol2tp_connect(struct socket *sock, stru=
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
@@ -755,35 +796,19 @@ static int pppol2tp_connect(struct socket *sock, stru=
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
@@ -808,12 +833,23 @@ static int pppol2tp_connect(struct socket *sock, stru=
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
 	PRINTK(session->debug, PPPOL2TP_MSG_CONTROL, KERN_INFO,
 	       "%s: created\n", session->name);
@@ -837,12 +873,11 @@ static int pppol2tp_session_create(struct net *net, s=
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
@@ -857,33 +892,23 @@ static int pppol2tp_session_create(struct net *net, s=
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
-	PRINTK(session->debug, PPPOL2TP_MSG_CONTROL, KERN_INFO,
-	       "%s: created\n", session->name);
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
-/* Called when deleting sessions via the netlink interface.
- */
-static int pppol2tp_session_delete(struct l2tp_session *session)
-{
-	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
-
-	if (ps->sock =3D=3D NULL)
-		l2tp_session_dec_refcount(session);
-
-	return 0;
-}
-
 #endif /* CONFIG_L2TP_V3 */
=20
 /* getname() support.
@@ -1001,12 +1026,10 @@ static int pppol2tp_session_ioctl(struct l2tp_sessi=
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
@@ -1282,7 +1305,6 @@ static int pppol2tp_session_setsockopt(struct sock *s=
k,
 				       int optname, int val)
 {
 	int err =3D 0;
-	struct pppol2tp_session *ps =3D l2tp_session_priv(session);
=20
 	switch (optname) {
 	case PPPOL2TP_SO_RECVSEQ:
@@ -1302,8 +1324,8 @@ static int pppol2tp_session_setsockopt(struct sock *s=
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
@@ -1638,8 +1660,9 @@ static void pppol2tp_seq_session_show(struct seq_file=
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
@@ -1649,6 +1672,15 @@ static void pppol2tp_seq_session_show(struct seq_fil=
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
@@ -1656,9 +1688,7 @@ static void pppol2tp_seq_session_show(struct seq_file=
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
@@ -1675,8 +1705,12 @@ static void pppol2tp_seq_session_show(struct seq_fil=
e *m, void *v)
 		   (unsigned long long)session->stats.rx_bytes,
 		   (unsigned long long)session->stats.rx_errors);
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
@@ -1801,7 +1835,7 @@ static const struct pppox_proto pppol2tp_proto =3D {
=20
 static const struct l2tp_nl_cmd_ops pppol2tp_nl_cmd_ops =3D {
 	.session_create	=3D pppol2tp_session_create,
-	.session_delete	=3D pppol2tp_session_delete,
+	.session_delete	=3D l2tp_session_delete,
 };
=20
 #endif /* CONFIG_L2TP_V3 */
diff --git a/net/netfilter/xt_TCPMSS.c b/net/netfilter/xt_TCPMSS.c
index 9e63b43faeed..07741640d9b6 100644
--- a/net/netfilter/xt_TCPMSS.c
+++ b/net/netfilter/xt_TCPMSS.c
@@ -44,25 +44,34 @@ optlen(const u_int8_t *opt, unsigned int offset)
=20
 static int
 tcpmss_mangle_packet(struct sk_buff *skb,
-		     const struct xt_tcpmss_info *info,
+		     const struct xt_action_param *par,
 		     unsigned int in_mtu,
 		     unsigned int tcphoff,
 		     unsigned int minlen)
 {
+	const struct xt_tcpmss_info *info =3D par->targinfo;
 	struct tcphdr *tcph;
-	unsigned int tcplen, i;
+	int len, tcp_hdrlen;
+	unsigned int i;
 	__be16 oldval;
 	u16 newmss;
 	u8 *opt;
=20
+	/* This is a fragment, no TCP header is available */
+	if (par->fragoff !=3D 0)
+		return 0;
+
 	if (!skb_make_writable(skb, skb->len))
 		return -1;
=20
-	tcplen =3D skb->len - tcphoff;
+	len =3D skb->len - tcphoff;
+	if (len < (int)sizeof(struct tcphdr))
+		return -1;
+
 	tcph =3D (struct tcphdr *)(skb_network_header(skb) + tcphoff);
+	tcp_hdrlen =3D tcph->doff * 4;
=20
-	/* Header cannot be larger than the packet */
-	if (tcplen < tcph->doff*4)
+	if (len < tcp_hdrlen || tcp_hdrlen < sizeof(struct tcphdr))
 		return -1;
=20
 	if (info->mss =3D=3D XT_TCPMSS_CLAMP_PMTU) {
@@ -83,9 +92,8 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 		newmss =3D info->mss;
=20
 	opt =3D (u_int8_t *)tcph;
-	for (i =3D sizeof(struct tcphdr); i < tcph->doff*4; i +=3D optlen(opt, i)=
) {
-		if (opt[i] =3D=3D TCPOPT_MSS && tcph->doff*4 - i >=3D TCPOLEN_MSS &&
-		    opt[i+1] =3D=3D TCPOLEN_MSS) {
+	for (i =3D sizeof(struct tcphdr); i <=3D tcp_hdrlen - TCPOLEN_MSS; i +=3D=
 optlen(opt, i)) {
+		if (opt[i] =3D=3D TCPOPT_MSS && opt[i+1] =3D=3D TCPOLEN_MSS) {
 			u_int16_t oldmss;
=20
 			oldmss =3D (opt[i+2] << 8) | opt[i+3];
@@ -108,9 +116,14 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	}
=20
 	/* There is data after the header so the option can't be added
-	   without moving it, and doing so may make the SYN packet
-	   itself too large. Accept the packet unmodified instead. */
-	if (tcplen > tcph->doff*4)
+	 * without moving it, and doing so may make the SYN packet
+	 * itself too large. Accept the packet unmodified instead.
+	 */
+	if (len > tcp_hdrlen)
+		return 0;
+
+	/* tcph->doff has 4 bits, do not wrap it to 0 */
+	if (tcp_hdrlen >=3D 15 * 4)
 		return 0;
=20
 	/*
@@ -127,10 +140,10 @@ tcpmss_mangle_packet(struct sk_buff *skb,
 	skb_put(skb, TCPOLEN_MSS);
=20
 	opt =3D (u_int8_t *)tcph + sizeof(struct tcphdr);
-	memmove(opt + TCPOLEN_MSS, opt, tcplen - sizeof(struct tcphdr));
+	memmove(opt + TCPOLEN_MSS, opt, len - sizeof(struct tcphdr));
=20
 	inet_proto_csum_replace2(&tcph->check, skb,
-				 htons(tcplen), htons(tcplen + TCPOLEN_MSS), 1);
+				 htons(len), htons(len + TCPOLEN_MSS), 1);
 	opt[0] =3D TCPOPT_MSS;
 	opt[1] =3D TCPOLEN_MSS;
 	opt[2] =3D (newmss & 0xff00) >> 8;
@@ -183,7 +196,7 @@ tcpmss_tg4(struct sk_buff *skb, const struct xt_action_=
param *par)
 	__be16 newlen;
 	int ret;
=20
-	ret =3D tcpmss_mangle_packet(skb, par->targinfo,
+	ret =3D tcpmss_mangle_packet(skb, par,
 				   tcpmss_reverse_mtu(skb, PF_INET),
 				   iph->ihl * 4,
 				   sizeof(*iph) + sizeof(struct tcphdr));
@@ -211,7 +224,7 @@ tcpmss_tg6(struct sk_buff *skb, const struct xt_action_=
param *par)
 	tcphoff =3D ipv6_skip_exthdr(skb, sizeof(*ipv6h), &nexthdr);
 	if (tcphoff < 0)
 		return NF_DROP;
-	ret =3D tcpmss_mangle_packet(skb, par->targinfo,
+	ret =3D tcpmss_mangle_packet(skb, par,
 				   tcpmss_reverse_mtu(skb, PF_INET6),
 				   tcphoff,
 				   sizeof(*ipv6h) + sizeof(struct tcphdr));
diff --git a/net/netfilter/xt_TCPOPTSTRIP.c b/net/netfilter/xt_TCPOPTSTRIP.c
index 9dc9ecfdd546..817ffa7980c3 100644
--- a/net/netfilter/xt_TCPOPTSTRIP.c
+++ b/net/netfilter/xt_TCPOPTSTRIP.c
@@ -30,18 +30,31 @@ static inline unsigned int optlen(const u_int8_t *opt, =
unsigned int offset)
=20
 static unsigned int
 tcpoptstrip_mangle_packet(struct sk_buff *skb,
-			  const struct xt_tcpoptstrip_target_info *info,
+			  const struct xt_action_param *par,
 			  unsigned int tcphoff, unsigned int minlen)
 {
+	const struct xt_tcpoptstrip_target_info *info =3D par->targinfo;
 	unsigned int optl, i, j;
 	struct tcphdr *tcph;
 	u_int16_t n, o;
 	u_int8_t *opt;
+	int len;
+
+	/* This is a fragment, no TCP header is available */
+	if (par->fragoff !=3D 0)
+		return XT_CONTINUE;
=20
 	if (!skb_make_writable(skb, skb->len))
 		return NF_DROP;
=20
+	len =3D skb->len - tcphoff;
+	if (len < (int)sizeof(struct tcphdr))
+		return NF_DROP;
+
 	tcph =3D (struct tcphdr *)(skb_network_header(skb) + tcphoff);
+	if (tcph->doff * 4 > len)
+		return NF_DROP;
+
 	opt  =3D (u_int8_t *)tcph;
=20
 	/*
@@ -76,7 +89,7 @@ tcpoptstrip_mangle_packet(struct sk_buff *skb,
 static unsigned int
 tcpoptstrip_tg4(struct sk_buff *skb, const struct xt_action_param *par)
 {
-	return tcpoptstrip_mangle_packet(skb, par->targinfo, ip_hdrlen(skb),
+	return tcpoptstrip_mangle_packet(skb, par, ip_hdrlen(skb),
 	       sizeof(struct iphdr) + sizeof(struct tcphdr));
 }
=20
@@ -93,7 +106,7 @@ tcpoptstrip_tg6(struct sk_buff *skb, const struct xt_act=
ion_param *par)
 	if (tcphoff < 0)
 		return NF_DROP;
=20
-	return tcpoptstrip_mangle_packet(skb, par->targinfo, tcphoff,
+	return tcpoptstrip_mangle_packet(skb, par, tcphoff,
 	       sizeof(*ipv6h) + sizeof(struct tcphdr));
 }
 #endif
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
index 762b61d84ac1..b41393eaa978 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -430,7 +430,7 @@ static void sctp_v6_from_sk(union sctp_addr *addr, stru=
ct sock *sk)
 /* Initialize sk->sk_rcv_saddr from sctp_addr. */
 static void sctp_v6_to_sk_saddr(union sctp_addr *addr, struct sock *sk)
 {
-	if (addr->sa.sa_family =3D=3D AF_INET && sctp_sk(sk)->v4mapped) {
+	if (addr->sa.sa_family =3D=3D AF_INET) {
 		inet6_sk(sk)->rcv_saddr.s6_addr32[0] =3D 0;
 		inet6_sk(sk)->rcv_saddr.s6_addr32[1] =3D 0;
 		inet6_sk(sk)->rcv_saddr.s6_addr32[2] =3D htonl(0x0000ffff);
@@ -444,7 +444,7 @@ static void sctp_v6_to_sk_saddr(union sctp_addr *addr, =
struct sock *sk)
 /* Initialize sk->sk_daddr from sctp_addr. */
 static void sctp_v6_to_sk_daddr(union sctp_addr *addr, struct sock *sk)
 {
-	if (addr->sa.sa_family =3D=3D AF_INET && sctp_sk(sk)->v4mapped) {
+	if (addr->sa.sa_family =3D=3D AF_INET) {
 		inet6_sk(sk)->daddr.s6_addr32[0] =3D 0;
 		inet6_sk(sk)->daddr.s6_addr32[1] =3D 0;
 		inet6_sk(sk)->daddr.s6_addr32[2] =3D htonl(0x0000ffff);
@@ -487,7 +487,9 @@ static void sctp_v6_to_addr(union sctp_addr *addr, stru=
ct in6_addr *saddr,
 {
 	addr->sa.sa_family =3D AF_INET6;
 	addr->v6.sin6_port =3D port;
+	addr->v6.sin6_flowinfo =3D 0;
 	ipv6_addr_copy(&addr->v6.sin6_addr, saddr);
+	addr->v6.sin6_scope_id =3D 0;
 }
=20
 /* Compare addresses exactly.
@@ -554,8 +556,6 @@ static int sctp_v6_available(union sctp_addr *addr, str=
uct sctp_sock *sp)
 	if (IPV6_ADDR_ANY =3D=3D type)
 		return 1;
 	if (type =3D=3D IPV6_ADDR_MAPPED) {
-		if (sp && !sp->v4mapped)
-			return 0;
 		if (sp && ipv6_only_sock(sctp_opt2sk(sp)))
 			return 0;
 		sctp_v6_map_v4(addr);
@@ -585,8 +585,6 @@ static int sctp_v6_addr_valid(union sctp_addr *addr,
 		/* Note: This routine is used in input, so v4-mapped-v6
 		 * are disallowed here when there is no sctp_sock.
 		 */
-		if (!sp || !sp->v4mapped)
-			return 0;
 		if (sp && ipv6_only_sock(sctp_opt2sk(sp)))
 			return 0;
 		sctp_v6_map_v4(addr);
@@ -682,11 +680,23 @@ static struct sock *sctp_v6_create_accept_sk(struct s=
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
@@ -713,82 +723,70 @@ static void sctp_v6_ecn_capable(struct sock *sk)
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
-		ipv6_addr_copy(&sin6->sin6_addr, &sin6from->sin6_addr);
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
-		ipv6_addr_copy(&sin6->sin6_addr, &ipv6_hdr(skb)->saddr);
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
@@ -864,9 +862,6 @@ static int sctp_inet6_bind_verify(struct sctp_sock *opt=
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
@@ -921,6 +916,23 @@ static int sctp_inet6_supported_addrs(const struct sct=
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
@@ -929,7 +941,7 @@ static const struct proto_ops inet6_seqpacket_ops =3D {
 	.connect	   =3D inet_dgram_connect,
 	.socketpair	   =3D sock_no_socketpair,
 	.accept		   =3D inet_accept,
-	.getname	   =3D inet6_getname,
+	.getname	   =3D sctp_getname,
 	.poll		   =3D sctp_poll,
 	.ioctl		   =3D inet6_ioctl,
 	.listen		   =3D sctp_inet_listen,
@@ -983,8 +995,6 @@ static struct sctp_af sctp_af_inet6 =3D {
 	.copy_addrlist	   =3D sctp_v6_copy_addrlist,
 	.from_skb	   =3D sctp_v6_from_skb,
 	.from_sk	   =3D sctp_v6_from_sk,
-	.to_sk_saddr	   =3D sctp_v6_to_sk_saddr,
-	.to_sk_daddr	   =3D sctp_v6_to_sk_daddr,
 	.from_addr_param   =3D sctp_v6_from_addr_param,
 	.to_addr_param	   =3D sctp_v6_to_addr_param,
 	.cmp_addr	   =3D sctp_v6_cmp_addr,
@@ -1014,7 +1024,9 @@ static struct sctp_pf sctp_pf_inet6 =3D {
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
index 149deaefc0d6..c16eac2c77db 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -615,10 +615,10 @@ static struct sock *sctp_v4_create_accept_sk(struct s=
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
@@ -1010,7 +1010,9 @@ static struct sctp_pf sctp_pf_inet =3D {
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
@@ -1081,8 +1083,6 @@ static struct sctp_af sctp_af_inet =3D {
 	.copy_addrlist	   =3D sctp_v4_copy_addrlist,
 	.from_skb	   =3D sctp_v4_from_skb,
 	.from_sk	   =3D sctp_v4_from_sk,
-	.to_sk_saddr	   =3D sctp_v4_to_sk_saddr,
-	.to_sk_daddr	   =3D sctp_v4_to_sk_daddr,
 	.from_addr_param   =3D sctp_v4_from_addr_param,
 	.to_addr_param	   =3D sctp_v4_to_addr_param,
 	.cmp_addr	   =3D sctp_v4_cmp_addr,
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 3975265d743e..c285bed60ff6 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -265,7 +265,7 @@ static struct sctp_transport *sctp_addr_id2transport(st=
ruct sock *sk,
 	if (id_asoc && (id_asoc !=3D addr_asoc))
 		return NULL;
=20
-	sctp_get_pf_specific(sk->sk_family)->addr_v4map(sctp_sk(sk),
+	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sctp_sk(sk),
 						(union sctp_addr *)addr);
=20
 	return transport;
@@ -410,7 +410,7 @@ SCTP_STATIC int sctp_do_bind(struct sock *sk, union sct=
p_addr *addr, int len)
 	/* Copy back into socket for getsockname() use. */
 	if (!ret) {
 		inet_sk(sk)->inet_sport =3D htons(inet_sk(sk)->inet_num);
-		af->to_sk_saddr(addr, sk);
+		sp->pf->to_sk_saddr(addr, sk);
 	}
=20
 	return ret;
@@ -1061,7 +1061,6 @@ static int __sctp_connect(struct sock* sk,
 	struct sctp_association *asoc2;
 	struct sctp_transport *transport;
 	union sctp_addr to;
-	struct sctp_af *af;
 	sctp_scope_t scope;
 	long timeo;
 	int err =3D 0;
@@ -1089,6 +1088,8 @@ static int __sctp_connect(struct sock* sk,
 	/* Walk through the addrs buffer and count the number of addresses. */
 	addr_buf =3D kaddrs;
 	while (walk_size < addrs_size) {
+		struct sctp_af *af;
+
 		if (walk_size + sizeof(sa_family_t) > addrs_size) {
 			err =3D -EINVAL;
 			goto out_free;
@@ -1212,8 +1213,7 @@ static int __sctp_connect(struct sock* sk,
=20
 	/* Initialize sk's dport and daddr for getpeername() */
 	inet_sk(sk)->inet_dport =3D htons(asoc->peer.port);
-	af =3D sctp_get_af_specific(sa_addr->sa.sa_family);
-	af->to_sk_daddr(sa_addr, sk);
+	sp->pf->to_sk_daddr(sa_addr, sk);
 	sk->sk_err =3D 0;
=20
 	/* in-kernel sockets don't generally have a file allocated to them
@@ -4080,7 +4080,7 @@ static int sctp_getsockopt_sctp_status(struct sock *s=
k, int len,
 	memcpy(&status.sstat_primary.spinfo_address, &transport->ipaddr,
 			transport->af_specific->sockaddr_len);
 	/* Map ipv4 address into v4-mapped-on-v6 address.  */
-	sctp_get_pf_specific(sk->sk_family)->addr_v4map(sctp_sk(sk),
+	sctp_get_pf_specific(sk->sk_family)->addr_to_user(sctp_sk(sk),
 		(union sctp_addr *)&status.sstat_primary.spinfo_address);
 	status.sstat_primary.spinfo_state =3D transport->state;
 	status.sstat_primary.spinfo_cwnd =3D transport->cwnd;
@@ -4239,8 +4239,8 @@ SCTP_STATIC int sctp_do_peeloff(struct sctp_associati=
on *asoc,
 				struct socket **sockp)
 {
 	struct sock *sk =3D asoc->base.sk;
+	struct sctp_sock *sp =3D sctp_sk(sk);
 	struct socket *sock;
-	struct sctp_af *af;
 	int err =3D 0;
=20
 	/* Do not peel off from one netns to another one. */
@@ -4269,8 +4269,7 @@ SCTP_STATIC int sctp_do_peeloff(struct sctp_associati=
on *asoc,
 	/* Make peeled-off sockets more like 1-1 accepted sockets.
 	 * Set the daddr and initialize id to something more random
 	 */
-	af =3D sctp_get_af_specific(asoc->peer.primary_addr.sa.sa_family);
-	af->to_sk_daddr(&asoc->peer.primary_addr, sk);
+	sp->pf->to_sk_daddr(&asoc->peer.primary_addr, sk);
=20
 	/* Populate the fields of the newsk from the oldsk and migrate the
 	 * asoc to the newsk.
@@ -4645,8 +4644,8 @@ static int sctp_getsockopt_peer_addrs(struct sock *sk=
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
@@ -4689,9 +4688,9 @@ static int sctp_copy_laddrs(struct sock *sk, __u16 po=
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
@@ -4779,8 +4778,8 @@ static int sctp_getsockopt_local_addrs(struct sock *s=
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
@@ -4839,7 +4838,7 @@ static int sctp_getsockopt_primary_addr(struct sock *=
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
index 8da4481ed30a..9e3d3682ee89 100644
--- a/net/sctp/transport.c
+++ b/net/sctp/transport.c
@@ -274,8 +274,8 @@ void sctp_transport_route(struct sctp_transport *transp=
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
index 57da44707eb1..d6baddcc57f9 100644
--- a/net/sctp/ulpevent.c
+++ b/net/sctp/ulpevent.c
@@ -348,7 +348,7 @@ struct sctp_ulpevent *sctp_ulpevent_make_peer_addr_chan=
ge(
 	memcpy(&spc->spc_aaddr, aaddr, sizeof(struct sockaddr_storage));
=20
 	/* Map ipv4 address into v4-mapped-on-v6 address.  */
-	sctp_get_pf_specific(asoc->base.sk->sk_family)->addr_v4map(
+	sctp_get_pf_specific(asoc->base.sk->sk_family)->addr_to_user(
 					sctp_sk(asoc->base.sk),
 					(union sctp_addr *)&spc->spc_aaddr);
=20
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index c789f91b4c2a..dd9da625b44e 100644
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
@@ -2188,6 +2189,7 @@ static int snd_seq_do_ioctl(struct snd_seq_client *cl=
ient, unsigned int cmd,
 			    void __user *arg)
 {
 	struct seq_ioctl_table *p;
+	int ret;
=20
 	switch (cmd) {
 	case SNDRV_SEQ_IOCTL_PVERSION:
@@ -2201,8 +2203,12 @@ static int snd_seq_do_ioctl(struct snd_seq_client *c=
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
 	snd_printd("seq unknown ioctl() 0x%x (type=3D'%c', number=3D0x%02x)\n",
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
index bfd2b8dd3f8a..80343b95b393 100644
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
index 1da4738fcad2..fbfdbe44cc56 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3045,6 +3045,9 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) =3D {
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
index 4c01f877227c..1fc26e4c6354 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -42,7 +42,7 @@ static struct uac_clock_source_descriptor *
 	while ((cs =3D snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_SOURCE))) {
-		if (cs->bClockID =3D=3D clock_id)
+		if (cs->bLength >=3D sizeof(*cs) && cs->bClockID =3D=3D clock_id)
 			return cs;
 	}
=20
@@ -58,8 +58,11 @@ static struct uac_clock_selector_descriptor *
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
@@ -74,7 +77,7 @@ static struct uac_clock_multiplier_descriptor *
 	while ((cs =3D snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_MULTIPLIER))) {
-		if (cs->bClockID =3D=3D clock_id)
+		if (cs->bLength >=3D sizeof(*cs) && cs->bClockID =3D=3D clock_id)
 			return cs;
 	}
=20
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index a489f2fbe4d8..a96184ad1479 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1255,6 +1255,12 @@ static int parse_audio_feature_unit(struct mixer_bui=
ld *state, int unitid, void
 	__u8 *bmaControls;
=20
 	if (state->mixer->protocol =3D=3D UAC_VERSION_1) {
+		if (hdr->bLength < 7) {
+			snd_printk(KERN_ERR
+				   "usbaudio: unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
+				   unitid);
+			return -EINVAL;
+		}
 		csize =3D hdr->bControlSize;
 		if (!csize) {
 			snd_printdd(KERN_ERR "usbaudio: unit %u: "
@@ -1271,6 +1277,12 @@ static int parse_audio_feature_unit(struct mixer_bui=
ld *state, int unitid, void
 		}
 	} else {
 		struct uac2_feature_unit_descriptor *ftr =3D _ftr;
+		if (hdr->bLength < 6) {
+			snd_printk(KERN_ERR
+				   "usbaudio: unit %u: invalid UAC_FEATURE_UNIT descriptor\n",
+				   unitid);
+			return -EINVAL;
+		}
 		csize =3D 4;
 		channels =3D (hdr->bLength - 6) / 4 - 1;
 		bmaControls =3D ftr->bmaControls;
@@ -1833,7 +1845,8 @@ static int parse_audio_selector_unit(struct mixer_bui=
ld *state, int unitid, void
 	const struct usbmix_name_map *map;
 	char **namelist;
=20
-	if (!desc->bNrInPins || desc->bLength < 5 + desc->bNrInPins) {
+	if (desc->bLength < 5 || !desc->bNrInPins ||
+	    desc->bLength < 5 + desc->bNrInPins) {
 		snd_printk(KERN_ERR "invalid SELECTOR UNIT descriptor %d\n", unitid);
 		return -EINVAL;
 	}

--s9fJI615cBHmzTOP--

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBWoR7Mee/yOyVhhEJAQqcsQ/+On7iknobUcqPrs/DdpARWoDNuL3icPFF
TPFanrPUTM1DFFNytU5NttBth9m6PI7yBQf7eqYXbMJJXAX61FLF8VRNuBDEykzj
FdhykbttTHZtvEEkXb1mK1Nr1RyRonKwc//ZN13rR6Uqdat5kUUrhK2reAZ056lz
q7WNJBSL4XJOBuLQS6/4iZJzavChil3hZPe0rPz8LDB/6q17GbDSmj8Q8HBvYoBS
q/HGMBNT9XJrNPkWCGVIWfhP2Q2i1P8/lHU8bqUf0uCB7hG85sIDRgoyoVqWZKeO
xSqizvtP+BC1AtOaP5ckTJHDJ15BNratXjIs3v4dzd0RcH8lq7wRxa8od2YJYBuN
n2G0x/EmlpL7eNKF0AYBMH+sFGO2PFK/9w0Rog04G4R1WZi/yBlPnTgpibATC9di
q9FyyztoH8cV9oHC15e9+fxV2hYbkpNpCche6+F4AMkFiVtyz5c5PWi6bexsrdaB
mD6kB+TAviqCBL4CuYGWGt0epPIe516UE+DRqt7Jvt6NzxQcDrDfuuYg4J4BOjma
QrNTK9glpSgIPT811YE/WpG5AurEBPSZzWskDRodCDBBAj2QyVXgKL2wmbcUHoza
fgL3Vr7grA3TASH12JYxfEd2hUDqiM+qs8SRfzupe2kHRmjzY9BpHDNKQeW49EeQ
8poqb12PZuk=
=sOPp
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
