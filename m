Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2442479-1524124210-2-548321201434180531
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524124209; b=jHokJjItCQP/DYTquoLaY7cKtVkqJq/Dtfp9tsRzfyxb06tJWD
    dOu81H8KmSy2UNhBS5IYHT0/CTyfXqqW5mH+st+YOoZidug9eD5BOPBwGJSIL4vh
    Fs1LZCBjSPD014O4vKvJnDfRCVaouvnw5gBTL+AFC7othU6Mv0Q9z76Bi1FFOSXN
    1J6S8tbGHXDrob7heqhMF+g41hyRGD2aAV2V8q/dGD46cPWW35S4NZqPbBXNdzIn
    OYE9bmCdays7ZCbsDljskajLxcI0/EDKtu5LXxlFn0vCGo90dskNbWy5uI63CdJR
    7W3E8ogGKQqXjLzWGrQ6YtALMeqbYd5NGe0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524124209;
    bh=Q9BHMzRSjpW0L0lXUdQkLqgogs+gbjPPZnb+PFG54Zc=; b=PlkhvA51kvf+
    QJKNBOQCVzxMDK06ngy2AR8gSWjvCzIPJndyh0zz2t4/hpGMQSTqqENTt1WrOn0Y
    mr2AhlFDbRsB05w6KGeS8N1rH1axn2knJXDwFbTK+T1mwOhBEG8uDiTesxlXFAqi
    B1pvHxWeWuBIsLV/RAMPRWgt8013790hjioMhlm/gCOx7molpqtgJ/OR2LNgxRzH
    cv/MYEjw4qIhWBwZfE0x8qf/Us9w12BV7eiZ38s9YgnG1pT5ELxKW84eeCYZ9tEK
    0xO7jpt0wu/zY6gqweUmLBiyzIYctvd+54RnkeHU1ptcdns+DcL5+IbJvGDBMTbx
    ijR4w9QZMA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAxQsPsjduXpKwFfzev0GsHoEa6G39heyRYUOSOOaRKBBTD5pmDHtzLtVCiUw0fjyNPkhBsOslgpIWFTSvSbZRipo5CmwGRySCbqmm9J1hsLBeVdL0vl
    JWBCGuFo0Pj85hmqs2NGtwR3CXry9qhD18dkQv+2UqR1a+PP+Od4Wpfk4gUsKaRiIc4ZpGVuhfuRcKVWjdrE7CkYUkvrjPFTgT8BFf41zQXSr7MvmGc0FtTp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=0sq-WYf4My0-eM7VsMkA:9 a=XGVJNeDquKDIPuay:21 a=pHaym1Ph2pU9ZgIF:21
    a=wPNLvfGTeEIA:10 a=uppHbsEuxFvELT8L2mkA:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeDSHuH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 03:50:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDSHuF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 03:50:05 -0400
Date: Thu, 19 Apr 2018 09:49:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.16.3
Message-ID: <20180419074956.GA22325@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.16.3 kernel.

All users of the 4.16 kernel series must upgrade.

The updated 4.16.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.16.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                            |    2=20
 arch/arm/boot/compressed/misc.c                     |    9=20
 arch/mips/boot/compressed/decompress.c              |    9=20
 arch/parisc/kernel/drivers.c                        |    4=20
 arch/parisc/kernel/hpmc.S                           |    6=20
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                 |    4=20
 arch/s390/kernel/compat_signal.c                    |    2=20
 arch/s390/kernel/ipl.c                              |    1=20
 arch/sh/boot/compressed/misc.c                      |    9=20
 arch/x86/include/asm/apic.h                         |    4=20
 arch/x86/include/asm/mce.h                          |    1=20
 arch/x86/include/uapi/asm/bootparam.h               |   18 -
 arch/x86/kernel/acpi/boot.c                         |   13 -
 arch/x86/kernel/apic/apic_common.c                  |    2=20
 arch/x86/kernel/apic/apic_numachip.c                |    2=20
 arch/x86/kernel/apic/x2apic.h                       |    2=20
 arch/x86/kernel/apic/x2apic_phys.c                  |    2=20
 arch/x86/kernel/apic/x2apic_uv_x.c                  |    2=20
 arch/x86/kernel/cpu/mcheck/mce_amd.c                |   37 ++-
 arch/x86/xen/apic.c                                 |    2=20
 block/blk-core.c                                    |    4=20
 block/blk-mq-cpumap.c                               |    5=20
 block/blk-mq.c                                      |   23 +-
 block/blk-timeout.c                                 |    2=20
 drivers/acpi/nfit/core.c                            |   22 +
 drivers/block/loop.c                                |   12 -
 drivers/bluetooth/hci_bcm.c                         |   20 -
 drivers/char/ipmi/ipmi_si_intf.c                    |   18 +
 drivers/edac/mce_amd.c                              |   11=20
 drivers/gpu/drm/radeon/radeon_object.c              |    3=20
 drivers/hv/channel_mgmt.c                           |    2=20
 drivers/media/platform/vsp1/vsp1_dl.c               |    3=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c       |    4=20
 drivers/media/v4l2-core/v4l2-dev.c                  |    8=20
 drivers/net/slip/slhc.c                             |    5=20
 drivers/net/usb/cdc_ether.c                         |    6=20
 drivers/net/usb/lan78xx.c                           |    3=20
 drivers/net/wireless/ath/ath9k/xmit.c               |    4=20
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c       |  157 +++++++++++++
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c  |    2=20
 drivers/nvme/host/core.c                            |    1=20
 drivers/pci/host/pci-hyperv.c                       |   92 ++++++--
 drivers/s390/cio/qdio_main.c                        |   42 +--
 drivers/sbus/char/oradax.c                          |    2=20
 drivers/scsi/qla2xxx/qla_os.c                       |   44 +--
 drivers/scsi/scsi_dh.c                              |    3=20
 drivers/scsi/scsi_lib.c                             |    2=20
 drivers/vhost/vhost.c                               |   10=20
 drivers/xen/xenbus/xenbus_dev_frontend.c            |    2=20
 fs/f2fs/gc.c                                        |    5=20
 fs/f2fs/segment.c                                   |    3=20
 fs/hugetlbfs/inode.c                                |   10=20
 fs/namei.c                                          |    3=20
 fs/nfsd/nfs4proc.c                                  |   12 -
 fs/nfsd/nfs4xdr.c                                   |    8=20
 fs/nfsd/xdr4.h                                      |    2=20
 fs/overlayfs/inode.c                                |   28 +-
 fs/overlayfs/namei.c                                |   17 +
 fs/overlayfs/util.c                                 |    8=20
 include/media/v4l2-dev.h                            |   12 -
 include/net/bluetooth/hci_core.h                    |    2=20
 include/net/slhc_vj.h                               |    1=20
 kernel/events/core.c                                |    6=20
 lib/bitmap.c                                        |    2=20
 lib/test_bitmap.c                                   |    4=20
 mm/gup.c                                            |    5=20
 mm/gup_benchmark.c                                  |    4=20
 net/bluetooth/hci_conn.c                            |   29 +-
 net/bluetooth/hci_event.c                           |   15 -
 net/bluetooth/l2cap_core.c                          |    2=20
 net/ipv4/ip_gre.c                                   |    6=20
 net/l2tp/l2tp_core.c                                |  225 ++++++++-------=
-----
 net/l2tp/l2tp_core.h                                |    4=20
 net/l2tp/l2tp_netlink.c                             |   22 +
 net/l2tp/l2tp_ppp.c                                 |    9=20
 net/rds/send.c                                      |   15 -
 net/sunrpc/auth_gss/gss_krb5_crypto.c               |    3=20
 security/apparmor/apparmorfs.c                      |    4=20
 security/apparmor/include/audit.h                   |    8=20
 security/apparmor/include/sig_names.h               |    4=20
 security/apparmor/ipc.c                             |    2=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   64 ++---
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |    2=20
 tools/perf/util/intel-pt.c                          |   37 ++-
 84 files changed, 784 insertions(+), 442 deletions(-)

Adrian Hunter (4):
      perf intel-pt: Fix overlap detection to identify consecutive buffers =
correctly
      perf intel-pt: Fix sync_switch
      perf intel-pt: Fix error recovery from missing TIP packet
      perf intel-pt: Fix timestamp following overflow

Al Viro (1):
      getname_kernel() needs to make sure that ->name !=3D ->iname in long =
case

Amir Goldstein (3):
      ovl: fix lookup with middle layer opaque dir and absolute path redire=
cts
      ovl: set i_ino to the value of st_ino for NFS export
      ovl: set lower layer st_dev only if setting lower st_ino

Arnd Bergmann (1):
      radeon: hide pointless #warning when compile testing

Bart Van Assche (2):
      block: Change a rcu_read_{lock,unlock}_sched() pair into rcu_read_{lo=
ck,unlock}()
      Revert "scsi: core: return BLK_STS_OK for DID_OK in __scsi_error_from=
_host_byte()"

Bassem Boubaker (1):
      cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN

Bill Kuzeja (1):
      scsi: qla2xxx: Fix small memory leak in qla2x00_probe_one on probe fa=
ilure

Corey Minyard (1):
      ipmi: Fix some error cleanup issues

Dan Williams (1):
      nfit: fix region registration vs block-data-window ranges

Dexuan Cui (3):
      Drivers: hv: vmbus: do not mark HV_PCIE as perf_device
      PCI: hv: Serialize the present and eject work items
      PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()

Dmitry V. Levin (1):
      x86/uapi: Fix asm/bootparam.h userspace compilation errors

Eric Auger (1):
      vhost: Fix vhost_copy_to_user()

Eric Biggers (1):
      sunrpc: remove incorrect HMAC request initialization

Greg Kroah-Hartman (1):
      Linux 4.16.3

Guillaume Nault (2):
      l2tp: fix races in tunnel creation
      l2tp: fix race in duplicate tunnel detection

Hans de Goede (1):
      Bluetooth: hci_bcm: Treat Interrupt ACPI resources as always being ac=
tive-low

Heiko Carstens (1):
      s390/compat: fix setup_frame32

Helge Deller (2):
      parisc: Fix out of array access in match_pci_device()
      parisc: Fix HPMC handler by increasing size to multiple of 16 bytes

Huacai Chen (1):
      zboot: fix stack protector in compressed boot phase

J. Bruce Fields (1):
      nfsd: fix incorrect umasks

Johannes Thumshirn (1):
      scsi: scsi_dh: Don't look for NULL devices handlers by name

John Johansen (3):
      apparmor: fix logging of the existence test for signals
      apparmor: fix display of .ns_name for containers
      apparmor: fix resource audit messages when auditing peer

Julian Wiedmann (2):
      s390/qdio: don't retry EQBS after CCQ 96
      s390/qdio: don't merge ERROR output buffers

Ka-Cheong Poon (1):
      rds: MP-RDS may use an invalid c_path

Keith Busch (1):
      nvme: Skip checking heads without namespaces

Kieran Bingham (1):
      media: v4l: vsp1: Fix header display list status check in continuous =
mode

Li RongQing (1):
      x86/apic: Fix signedness bug in APIC ID validity checks

Luca Coelho (1):
      iwlwifi: add a bunch of new 9000 PCI IDs

Mauro Carvalho Chehab (2):
      media: v4l2-core: fix size of devnode_nums[] bitarray
      media: v4l2-compat-ioctl32: don't oops on overlay

Michael S. Tsirkin (2):
      get_user_pages_fast(): return -EFAULT on access_ok failure
      mm/gup_benchmark: handle gup failures

Mike Kravetz (1):
      hugetlbfs: fix bug in pgoff overflow checking

Ming Lei (3):
      blk-mq: order getting budget and driver tag
      blk-mq: make sure that correct hctx->next_cpu is set
      blk-mq: don't keep offline CPUs mapped to hctx 0

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode

Phil Elwell (1):
      lan78xx: Correctly indicate invalid OTP

Prashant Bhole (1):
      perf/core: Fix use-after-free in uprobe_perf_close()

Rob Gardner (1):
      sparc64: Properly range check DAX completion index

Sabrina Dubroca (1):
      ip_gre: clear feature flags when incompatible o_flags are set

Simon Gaiser (1):
      xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END handling

Stefan Hajnoczi (1):
      vhost: fix vhost_vq_access_ok() log check

Sudhir Sreedharan (1):
      rtl8187: Fix NULL pointer dereference in priv->conf_mutex

Szymon Janc (1):
      Bluetooth: Fix connection if directed advertising and privacy is used

Tejaswi Tanikella (1):
      slip: Check if rstate is initialized before uncompressing

Tejun Heo (1):
      blk-mq: Directly schedule q->timeout_work when aborting a request

Tetsuo Handa (1):
      block/loop: fix deadlock after loop_set_status

Toke H=F8iland-J=F8rgensen (1):
      ath9k: Protect queue draining by rcu_read_lock()

Vasily Gorbik (1):
      s390/ipl: ensure loadparm valid flag is set

Vivek Goyal (1):
      ovl: Set d->last properly during lookup

Yazen Ghannam (3):
      x86/mce/AMD: Pass the bank number to smca_get_bank_type()
      x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type
      x86/mce/AMD: Get address from already initialized block

Yunlong Song (1):
      f2fs: fix heap mode to reset it back

Yury Norov (1):
      lib: fix stall in __bitmap_parselist()


--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrYSiAACgkQONu9yGCS
aT56WQ/+O/DWlxNbS68hfX50+K1aZbjxLSOtft10HTOH2PbWW/W4HidqDOMsZ+Ou
42l5iA5Wjb4Ht6LNLRHbRpEsw2ivZEnHmvcheb4muYxnFhHQd5fFE08nnIxHX1Gs
0n1VWgOkqCVQyAF1UVDXjHPbhR0gNFxpWs6zBgKtVzPjClyeswHnAvcJ451ZtjWg
gMK+GJbH3vr4aqnB5xWlRlQz0goSEgDgk4D2aRPXcsCMOOj3whvfPdInFafPHqA0
G9BdfMNt5FRmXGZHNjRtW8TkSUt6WFJiQ0G7InO0vay1dKyTHJJQx5zuQaVARiQQ
przhQRwV+n8Y4sqYO9humlJAH1raU37sbdyJPbPrFhyoHePw65cKk4yIgwGofFLk
iZc+d6TFydZsAeP4qWM2HXgkPowqrmafOO515kdB+JnTunwQTtq7TjeL5AVU7GC1
CkO0Qgmad/KKAx7wd+VD9kNiKig84wfw3ommTUqkHd/s5MTxJdrhuYhlOOYdwT9q
IJF/XqXwY7PEV3DGaKAlf5QdMc3wX2O5MiJUpA0/jua6eRZJ+A/k6w+dWLbdnoz7
EgafGSIkPRZZbUVJkN1H39aUPsiMwSDUBmNWLQjIqL6j/Xtk3pRiRucVL8I4jrU0
nR3MgSmSwvcZxJoDFuTvMYCGwGeHC70aZkWKu7wbVKNPDc9bUnI=
=DUTS
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
