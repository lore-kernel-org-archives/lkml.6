Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2442479-1524124344-2-14716119341482040627
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
    1524124343; b=gfS13lGZLOsSHdvBiVDzzpup1Zn4qNH+2fDqWHtksNNlbWPxD7
    wuk/mRQTVapvbbgLS1gvTC6PPDPw1bx46MrNKZdJD+NUwXydsKCFvfrAjYmMb5qM
    7sOfMs68GI0bDhNCkKGtdJap2ad5UsgiNFI+TSI5yCZpUVMhIXMed0sRPLDu//Cq
    F+IIvOuNhJHlAanqLzcoI/hyhnv1Pge/cr8UVq6PJbanTgEvSa3xT0+P+KG5TQXC
    OJ0Y8pRIIaUUAiyVOzK85tusBf9fBvaY/wPbDEGsphrOeYnLyxWdMWw8qHf9tf8/
    B8TepifxdeenZ8WUY/RVqYubZeZXar+hMFnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524124343;
    bh=grtpiMQZXSrF3+shaGvaEjlm/BBFH3RsZrYy5CAt2wE=; b=uHkCzp99XSzb
    cCNNZrQLUircIIVgEBE1yKwoJJRd+Gpy7Zk/vXNgSMwlQjECgVmOZLmj97QJ6HNR
    tIEfNFCXovMd2Er7E/kLc9tM/9wcUlKoi8g/ytRSaWpmeZICiJyKoEzySZJR4G6s
    GS5oxCFyf+vkE5vpoxqC0KdoGxeQ1/b+DnkfEgCZ6ZMQ4kG/EIdMl+m3xcs3XHxJ
    4FSBYLdtmLmlU7p9b/mUkFA6+1YkQkuuVWtt4JCAe0ydLzvNGP5ySfex7pWt9nVi
    ubgKZ4+CKD+3n6P70mRdKN8nN6ihcZVu/fyrIVlKOZy+w/lPsV9ziytJ1aSSx7Jg
    fRBet2ukhg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfNVOct6/mMU7i5/LwcKfdM0TvoeK94J381pBZONeeDtQfmTMbRpVyherS6ftVqF/ysiCJUUh7UlUkdjcijyjwn2iHwqDCtTyg/SemqTyAAKmGfUiY6SK
    e3uqmJl41wxgvlcxWUNIr9wal7RN5ykVTe1LEyuQCWof5HEgRHHF6bicv3huJ0rMEy4baV4HC7UrdYW6K4z/viX+RQ57k3+5Dsa26wrJsxe1RXvLgXSLD17K
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=TBiW29iDEYjsJ763JB0A:9 a=z-GEBE3G2xM7hO0Z:21 a=H6fMCVtJR7tyj22p:21
    a=wPNLvfGTeEIA:10 a=Cl7ay3eDo-GZCIvcKg4A:9 a=ONNS8QRKHyMA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeDSHvk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 03:51:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39692 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751822AbeDSHvj (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 03:51:39 -0400
Date: Thu, 19 Apr 2018 09:51:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.35
Message-ID: <20180419075132.GA27731@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.35 kernel.

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

 Makefile                                            |    2=20
 arch/parisc/kernel/drivers.c                        |    4 +
 arch/parisc/kernel/hpmc.S                           |    6 +
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                 |    4 -
 arch/s390/kernel/ipl.c                              |    1=20
 arch/x86/include/asm/mce.h                          |    3=20
 arch/x86/kernel/cpu/mcheck/mce.c                    |    4 -
 arch/x86/kernel/cpu/mcheck/mce_amd.c                |   54 +++++++++++++++-
 block/blk-mq-cpumap.c                               |    5 -
 drivers/acpi/nfit/core.c                            |   22 ++++--
 drivers/block/loop.c                                |   12 ++-
 drivers/bluetooth/hci_bcm.c                         |   20 ------
 drivers/edac/mce_amd.c                              |   11 ++-
 drivers/gpu/drm/radeon/radeon_object.c              |    3=20
 drivers/hv/channel_mgmt.c                           |    2=20
 drivers/hwmon/ina2xx.c                              |    3=20
 drivers/media/platform/vsp1/vsp1_dl.c               |    3=20
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c       |    4 -
 drivers/net/slip/slhc.c                             |    5 +
 drivers/net/usb/cdc_ether.c                         |    6 +
 drivers/net/usb/lan78xx.c                           |    3=20
 drivers/net/wireless/ath/ath9k/xmit.c               |    4 +
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c  |    2=20
 drivers/pci/host/pci-hyperv.c                       |   34 +++++-----
 drivers/s390/cio/qdio_main.c                        |   42 ++++++-------
 drivers/scsi/qla2xxx/qla_os.c                       |   44 ++++++-------
 drivers/vhost/vhost.c                               |   10 +--
 drivers/xen/xenbus/xenbus_dev_frontend.c            |    2=20
 fs/f2fs/gc.c                                        |    5 -
 fs/f2fs/segment.c                                   |    3=20
 fs/hugetlbfs/inode.c                                |   10 ++-
 fs/namei.c                                          |    3=20
 fs/nfsd/nfs4proc.c                                  |   12 +++
 fs/nfsd/nfs4xdr.c                                   |    8 --
 fs/nfsd/xdr4.h                                      |    2=20
 fs/overlayfs/namei.c                                |    9 ++
 include/net/bluetooth/hci_core.h                    |    2=20
 include/net/slhc_vj.h                               |    1=20
 kernel/events/core.c                                |    6 +
 lib/bitmap.c                                        |    2=20
 lib/test_bitmap.c                                   |    4 +
 mm/gup.c                                            |    5 +
 net/bluetooth/hci_conn.c                            |   29 ++++++---
 net/bluetooth/hci_event.c                           |   15 +++-
 net/bluetooth/l2cap_core.c                          |    2=20
 net/netfilter/ipset/ip_set_core.c                   |    2=20
 net/rds/send.c                                      |   15 +++-
 net/sunrpc/auth_gss/gss_krb5_crypto.c               |    3=20
 security/apparmor/apparmorfs.c                      |    4 -
 security/apparmor/include/audit.h                   |    8 +-
 security/apparmor/include/sig_names.h               |    4 -
 security/apparmor/ipc.c                             |    2=20
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.c |   64 +++++++++------=
-----
 tools/perf/util/intel-pt-decoder/intel-pt-decoder.h |    2=20
 tools/perf/util/intel-pt.c                          |   37 +++++++++--
 55 files changed, 360 insertions(+), 214 deletions(-)

Adrian Hunter (4):
      perf intel-pt: Fix overlap detection to identify consecutive buffers =
correctly
      perf intel-pt: Fix sync_switch
      perf intel-pt: Fix error recovery from missing TIP packet
      perf intel-pt: Fix timestamp following overflow

Al Viro (1):
      getname_kernel() needs to make sure that ->name !=3D ->iname in long =
case

Amir Goldstein (1):
      ovl: fix lookup with middle layer opaque dir and absolute path redire=
cts

Arnd Bergmann (1):
      radeon: hide pointless #warning when compile testing

Bassem Boubaker (1):
      cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN

Bill Kuzeja (1):
      scsi: qla2xxx: Fix small memory leak in qla2x00_probe_one on probe fa=
ilure

Dan Williams (1):
      nfit: fix region registration vs block-data-window ranges

Dexuan Cui (2):
      Drivers: hv: vmbus: do not mark HV_PCIE as perf_device
      PCI: hv: Serialize the present and eject work items

Eric Auger (1):
      vhost: Fix vhost_copy_to_user()

Eric Biggers (1):
      sunrpc: remove incorrect HMAC request initialization

Greg Kroah-Hartman (1):
      Linux 4.14.35

Hans de Goede (1):
      Bluetooth: hci_bcm: Treat Interrupt ACPI resources as always being ac=
tive-low

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

Kieran Bingham (1):
      media: v4l: vsp1: Fix header display list status check in continuous =
mode

Marek Szyprowski (1):
      hwmon: (ina2xx) Fix access to uninitialized mutex

Mauro Carvalho Chehab (1):
      media: v4l2-compat-ioctl32: don't oops on overlay

Michael S. Tsirkin (1):
      get_user_pages_fast(): return -EFAULT on access_ok failure

Mike Kravetz (1):
      hugetlbfs: fix bug in pgoff overflow checking

Ming Lei (1):
      blk-mq: don't keep offline CPUs mapped to hctx 0

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode

Phil Elwell (1):
      lan78xx: Correctly indicate invalid OTP

Prashant Bhole (1):
      perf/core: Fix use-after-free in uprobe_perf_close()

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

Yazen Ghannam (5):
      x86/MCE/AMD: Define a function to get SMCA bank type
      x86/MCE: Report only DRAM ECC as memory errors on AMD systems
      x86/mce/AMD: Pass the bank number to smca_get_bank_type()
      x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type
      x86/mce/AMD: Get address from already initialized block

Yunlong Song (1):
      f2fs: fix heap mode to reset it back

Yury Norov (1):
      lib: fix stall in __bitmap_parselist()


--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlrYSoMACgkQONu9yGCS
aT67NxAAj9wk79RGKJGFQgVHtckWRUmjc/6D6zV3mNYhKNg5WFu+d7ihB/rG2ehd
fHFCwrEjg8aENhlFgTrFFrFBIKETbOqrsi4LcofHJ5eYId9spT7J+60vSY03Oegq
I63QdogwxZc381E/gjmsd7z5Wkf96UUdMWoDjC5SLWc1LlwUjLquojQmm8fuphqk
BXstS/Xrkhg3hcpnzvvFhftBlLpeP2B+iBMs8FgfMGO24l5XAtDNrtWzbHGwCHh5
iPTimHhA2+vNWZ3i0FijXx5covKQu/96hYjGa4PTFrRL6rZD4kre57Xwc2j/5A4B
i1+d37J3If0mOWgRM7UDQEkI1QGCbn9mbTDMuGGRvGLyVYJR/2YsaJJuXOoJupDs
0V6P1jQpJyw5BFJW4BrqAfbtpNAPAnTDLWZ7AzYZPQVuKCzx8nTglgzWyuuHDxMa
EYnWzFgkzTtFAf09BixJiys0OM6hiFE6OU7BbhfTdTG6t3+6hGufLegv4Tn0Iws1
BWrKQLntPU0zSg5lHJtx8InoX8WijrFDz+oo0CuIb9neswrit2FvJSgnO/TR4Clj
5N6/JdeGPtGWdhL4F89h+1gmH27Um6z9U57ojuNKeQ5DwEsTSN+K1ySIuZQa7cRL
RynDvlzQZnAALLsx3avv0N35RXoXyt5/Jrs1OEaZ8EpvG+rHDGU=
=bAkp
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
