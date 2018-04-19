Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2551042-1524124275-2-10780121319218783361
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
    1524124274; b=h3NBR/G7miMxKHiIpiRPEtXpksFh2UuPm0nhBfGB5lvuI/VyVV
    tKYLphpGZh911o99kC6PJ5XS+xoeicgAqbechIcmqkTHv7qmAlr9lVD48FZrQuva
    MtqkdqFmBOVqfna/PtgUSry3ppf5H7ZrqQXG2zEPDrO1BKF3Rw4zhCt7vUSqq7vH
    AwbRX6517PEmOZxZCSYHbJ6gHSBtawjqzyyH0HxHt6/rXqbVm+76xSgUNfAbsiVt
    zPcTL7I3QSQN6GOzHkGegWCvtIjIIdH5+s6JZC+sqWqQxWVAF8a26gWkkhQPvNbO
    Lqz6HyD+7Pn6mW6LQ4SLX7BuUVSuo+MLEfIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524124274;
    bh=HO9/mQgHQ5k3N8aHZ4I+ze0JO/0MwjW9Sz1VnAFSksw=; b=TjsMyPJUR3IP
    RUmb4efU+YeyZecPiDNWpNPol8kxFVIULyiwQRgFPxSvUWuAyXPGCuVN0H5rdr/2
    HPX9hIdoGE3v1je4TVLMWnyxYIQd5F7Tg3icqwgxaUH4cbaa0+vHFHnrRRL2Aao9
    QjJQ/zlDcR19vVsp5ZVcKFOvStGZQkPscYXypyqK/KBO1MscUmMQ43yuztzIv46+
    F9hwjJtTicRVB0dwQNLrolZ9zXPlzomyrajVysgYPmf4Xumh66DugT210EBKQY5D
    Fwcp1mGayZEuuDGdwAX/k4eOh9QsrKhiCa3GP3zgfzFntBfivm6gPh+pMmM12OGy
    yjDXy7FQ/Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfEBAry9v5RWWsz1I8hbNJppCP/tKgi13j2IAyyGgRjrJkr1dgmhC+UxZnBcXlLlP9IAqro6DPcLC91KITtZYp5wSAwuGpb4AwXUy0wpKjWRtCP/uQ2ke
    mhgXzJdwDN9ulv7lUnxm4r3SRyoArZaiRM6nTyqNcrqL82OILTTpmASF5b895ON2GTm53n4ZcDt2zeI3b5DZptvHLFb5IRf+Cw0SltV2MRFuJBCWnp/7hy5d
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=M-990rKKqTtKnmhx41YA:9 a=wPNLvfGTeEIA:10 a=iR5Qu_LmokUIM4z6omoA:9
    a=ONNS8QRKHyMA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeDSHvN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 03:51:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeDSHvN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 03:51:13 -0400
Date: Thu, 19 Apr 2018 09:51:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.15.18
Message-ID: <20180419075107.GA24566@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

-----------------------------
NOTE, this is the last release of the 4.15.y kernel.  It is now
end-of-life.  Please move to the 4.16.y kernel tree at this point in
time.
-----------------------------
I'm announcing the release of the 4.15.18 kernel.

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

 Makefile                                           |    2=20
 arch/parisc/kernel/drivers.c                       |    4=20
 arch/parisc/kernel/hpmc.S                          |    6=20
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |    4=20
 arch/s390/kernel/compat_signal.c                   |    2=20
 arch/s390/kernel/ipl.c                             |    1=20
 arch/x86/include/asm/apic.h                        |    4=20
 arch/x86/kernel/acpi/boot.c                        |   13 -
 arch/x86/kernel/apic/apic_common.c                 |    2=20
 arch/x86/kernel/apic/apic_numachip.c               |    2=20
 arch/x86/kernel/apic/x2apic.h                      |    2=20
 arch/x86/kernel/apic/x2apic_phys.c                 |    2=20
 arch/x86/kernel/apic/x2apic_uv_x.c                 |    2=20
 arch/x86/kernel/cpu/mcheck/mce_amd.c               |   15 +
 arch/x86/xen/apic.c                                |    2=20
 block/blk-core.c                                   |    4=20
 block/blk-mq-cpumap.c                              |    5=20
 block/blk-mq.c                                     |   21 -
 drivers/acpi/nfit/core.c                           |   22 +-
 drivers/block/loop.c                               |   12 -
 drivers/bluetooth/hci_bcm.c                        |   20 -
 drivers/char/ipmi/ipmi_si_intf.c                   |   18 +
 drivers/gpu/drm/i915/intel_dp_link_training.c      |   26 +-
 drivers/hv/channel_mgmt.c                          |    2=20
 drivers/hwmon/ina2xx.c                             |    3=20
 drivers/media/platform/vsp1/vsp1_dl.c              |    3=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |    4=20
 drivers/net/slip/slhc.c                            |    5=20
 drivers/net/usb/cdc_ether.c                        |    6=20
 drivers/net/usb/lan78xx.c                          |    3=20
 drivers/net/wireless/ath/ath9k/xmit.c              |    4=20
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    2=20
 drivers/nvme/host/core.c                           |    1=20
 drivers/pci/host/pci-hyperv.c                      |   92 ++++++--
 drivers/s390/cio/qdio_main.c                       |   42 ++-
 drivers/scsi/qla2xxx/qla_os.c                      |   44 +---
 drivers/vhost/vhost.c                              |   10=20
 drivers/xen/xenbus/xenbus_dev_frontend.c           |    2=20
 fs/f2fs/gc.c                                       |    5=20
 fs/f2fs/segment.c                                  |    3=20
 fs/hugetlbfs/inode.c                               |   10=20
 fs/namei.c                                         |    3=20
 fs/nfsd/nfs4proc.c                                 |   12 -
 fs/nfsd/nfs4xdr.c                                  |    8=20
 fs/nfsd/xdr4.h                                     |    2=20
 fs/overlayfs/inode.c                               |    7=20
 fs/overlayfs/namei.c                               |    9=20
 include/net/bluetooth/hci_core.h                   |    2=20
 include/net/slhc_vj.h                              |    1=20
 kernel/events/core.c                               |    6=20
 lib/bitmap.c                                       |    2=20
 lib/test_bitmap.c                                  |    4=20
 mm/gup.c                                           |    5=20
 mm/gup_benchmark.c                                 |    4=20
 net/bluetooth/hci_conn.c                           |   29 +-
 net/bluetooth/hci_event.c                          |   15 +
 net/bluetooth/l2cap_core.c                         |    2=20
 net/ipv4/ip_gre.c                                  |    6=20
 net/l2tp/l2tp_core.c                               |  225 +++++++++-------=
-----
 net/l2tp/l2tp_core.h                               |    4=20
 net/l2tp/l2tp_netlink.c                            |   22 +-
 net/l2tp/l2tp_ppp.c                                |    9=20
 net/netfilter/ipset/ip_set_core.c                  |    2=20
 net/rds/send.c                                     |   15 -
 net/sunrpc/auth_gss/gss_krb5_crypto.c              |    3=20
 security/apparmor/apparmorfs.c                     |    4=20
 security/apparmor/include/audit.h                  |    8=20
 security/apparmor/include/sig_names.h              |    4=20
 security/apparmor/ipc.c                            |    2=20
 69 files changed, 503 insertions(+), 344 deletions(-)

Al Viro (1):
      getname_kernel() needs to make sure that ->name !=3D ->iname in long =
case

Amir Goldstein (2):
      ovl: fix lookup with middle layer opaque dir and absolute path redire=
cts
      ovl: set lower layer st_dev only if setting lower st_ino

Bart Van Assche (1):
      block: Change a rcu_read_{lock,unlock}_sched() pair into rcu_read_{lo=
ck,unlock}()

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

Eric Auger (1):
      vhost: Fix vhost_copy_to_user()

Eric Biggers (1):
      sunrpc: remove incorrect HMAC request initialization

Greg Kroah-Hartman (1):
      Linux 4.15.18

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

J. Bruce Fields (1):
      nfsd: fix incorrect umasks

John Johansen (3):
      apparmor: fix logging of the existence test for signals
      apparmor: fix display of .ns_name for containers
      apparmor: fix resource audit messages when auditing peer

Jozsef Kadlecsik (1):
      netfilter: ipset: Missing nfnl_lock()/nfnl_unlock() is added to ip_se=
t_net_exit()

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

Manasi Navare (1):
      drm/i915/edp: Do not do link training fallback or prune modes on EDP

Marek Szyprowski (1):
      hwmon: (ina2xx) Fix access to uninitialized mutex

Mauro Carvalho Chehab (1):
      media: v4l2-compat-ioctl32: don't oops on overlay

Michael S. Tsirkin (2):
      get_user_pages_fast(): return -EFAULT on access_ok failure
      mm/gup_benchmark: handle gup failures

Mike Kravetz (1):
      hugetlbfs: fix bug in pgoff overflow checking

Ming Lei (2):
      blk-mq: order getting budget and driver tag
      blk-mq: don't keep offline CPUs mapped to hctx 0

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode

Phil Elwell (1):
      lan78xx: Correctly indicate invalid OTP

Prashant Bhole (1):
      perf/core: Fix use-after-free in uprobe_perf_close()

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

Tetsuo Handa (1):
      block/loop: fix deadlock after loop_set_status

Toke H=F8iland-J=F8rgensen (1):
      ath9k: Protect queue draining by rcu_read_lock()

Vasily Gorbik (1):
      s390/ipl: ensure loadparm valid flag is set

Yazen Ghannam (1):
      x86/mce/AMD: Get address from already initialized block

Yunlong Song (1):
      f2fs: fix heap mode to reset it back

Yury Norov (1):
      lib: fix stall in __bitmap_parselist()


--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrYSmkACgkQONu9yGCS
aT750RAAoh87G8LrNCiQTMBXZ1xP620qPrrxASadC7JIrQlTeYZbzSeAKDahNrLQ
QY0DyjPU0iUHMbKOsIZO/ehav4LNrSCnSqYIR4fNaujZKkw4xwbRFWYj997hMRzs
CeVE7nPrgEtcU7mR7ktPC7Wf4hT+MG8gDePjlJwDRUDspxozod1PwVAvnguFmhd1
ggM+aCRBKneULMFGRN9ypyz9kNIYeKSvDjv6sIfm+O4FcJ0xsByRO+RWsRN8xhiD
IOh7m/O/5fHEc1k4gkNL+TG/CKCcls9uFLzKFQcm6QSEMkJVIcgbF8/rfXI29CJc
bI3Y6DDJ+c01RE9mG7DQH+SevtHiiXIaDFBdJGl+/oG4EIATNb7OSVFPUDNWo9uq
hNfgzyD1Jb2BNTc4sapVAsKPU1WIwFt3Kp0Sn9vliXB887FmFYzLN0h03qV56OG/
WSScyh28nZCOCAJlOTgJ9+JU0LBJVxAUAHw8djCgj0OQTiv6KWI+QGvFst/vkqpY
wjR2eWl9Y+GXEg620CGOtKC3i5Vu87ssQ7ZO5//KhH2qsKrSSIuj5p1RJFyLkiJw
61ukt4yv1Np7ChYBJX1mm6i/eMY37lj2368IAjhsV2MVSgsYgsYe2lgQTskBPLGb
LUgnIDaWd7w697lTckzOruQ24IzB8KhjhgLoPMwnie9a3W1h6C4=
=8T5o
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
