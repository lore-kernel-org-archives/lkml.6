Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31CB8ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4B9208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4B9208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIOPWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 11:22:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeIOPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 11:22:48 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 109F5ACD;
        Sat, 15 Sep 2018 10:04:20 +0000 (UTC)
Date:   Sat, 15 Sep 2018 12:04:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.127
Message-ID: <20180915100418.GA31100@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.127 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                       |    2=20
 arch/arm/configs/imx_v6_v7_defconfig           |    2=20
 arch/arm/mach-rockchip/Kconfig                 |    1=20
 arch/arm64/Kconfig.platforms                   |    1=20
 arch/arm64/include/asm/cachetype.h             |    5 +
 arch/arm64/include/asm/cpucaps.h               |    3=20
 arch/arm64/kernel/cpu_errata.c                 |   24 ++++++-
 arch/arm64/kernel/cpufeature.c                 |    4 -
 arch/powerpc/platforms/pseries/ras.c           |    2=20
 arch/powerpc/sysdev/mpic_msgr.c                |    2=20
 arch/s390/kernel/crash_dump.c                  |   17 +++--
 arch/s390/lib/mem.S                            |    9 +-
 arch/x86/include/asm/pgtable-3level.h          |    7 --
 arch/x86/include/asm/pgtable.h                 |    2=20
 block/bio.c                                    |    2=20
 drivers/acpi/scan.c                            |    5 -
 drivers/clk/rockchip/clk-rk3399.c              |    1=20
 drivers/gpu/drm/drm_edid.c                     |    3=20
 drivers/infiniband/hw/hns/hns_roce_pd.c        |    2=20
 drivers/infiniband/hw/hns/hns_roce_qp.c        |    5 +
 drivers/irqchip/irq-bcm7038-l1.c               |    4 +
 drivers/md/dm-kcopyd.c                         |    2=20
 drivers/mfd/sm501.c                            |    1=20
 drivers/misc/mei/pci-me.c                      |    5 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |    3=20
 drivers/net/ethernet/broadcom/genet/bcmmii.c   |   10 ++-
 drivers/net/ethernet/cisco/enic/enic_main.c    |    2=20
 drivers/net/ethernet/qlogic/qlge/qlge_main.c   |   23 ++-----
 drivers/net/ethernet/realtek/r8169.c           |    1=20
 drivers/net/hyperv/netvsc_drv.c                |    5 +
 drivers/pci/host/pci-mvebu.c                   |    2=20
 drivers/platform/x86/asus-nb-wmi.c             |    1=20
 drivers/platform/x86/intel_punit_ipc.c         |    1=20
 drivers/s390/block/dasd_eckd.c                 |   10 ++-
 drivers/scsi/aic94xx/aic94xx_init.c            |    4 -
 drivers/staging/comedi/drivers/ni_mio_common.c |    3=20
 drivers/vhost/vhost.c                          |    2=20
 drivers/virtio/virtio_pci_legacy.c             |   14 +++-
 fs/btrfs/dev-replace.c                         |    6 +
 fs/btrfs/disk-io.c                             |   10 +--
 fs/btrfs/extent-tree.c                         |    2=20
 fs/btrfs/relocation.c                          |   23 +++----
 fs/cifs/cifs_debug.c                           |    8 ++
 fs/cifs/smb2misc.c                             |    7 ++
 fs/cifs/smb2pdu.c                              |    2=20
 fs/dcache.c                                    |    3=20
 fs/fat/cache.c                                 |   19 +++---
 fs/fat/fat.h                                   |    5 +
 fs/fat/fatent.c                                |    6 -
 fs/hfs/brec.c                                  |    7 +-
 fs/hfsplus/dir.c                               |    4 -
 fs/hfsplus/super.c                             |    4 -
 fs/reiserfs/reiserfs.h                         |    2=20
 include/linux/pci_ids.h                        |    2=20
 kernel/fork.c                                  |    2=20
 lib/debugobjects.c                             |    7 +-
 mm/fadvise.c                                   |    8 +-
 mm/huge_memory.c                               |    2=20
 net/9p/trans_fd.c                              |   10 +--
 net/9p/trans_virtio.c                          |    3=20
 net/ipv4/tcp_ipv4.c                            |    6 +
 net/ipv4/tcp_minisocks.c                       |    3=20
 net/ipv4/tcp_probe.c                           |    4 -
 net/ipv6/ip6_vti.c                             |    2=20
 net/irda/af_irda.c                             |   13 +++-
 net/netfilter/ipvs/ip_vs_core.c                |   15 +++-
 net/rds/ib_frmr.c                              |    1=20
 net/sched/act_ife.c                            |   79 ++++++++++++++------=
-----
 net/sched/cls_u32.c                            |    8 +-
 net/sched/sch_hhf.c                            |    3=20
 net/sched/sch_htb.c                            |    5 -
 net/sched/sch_multiq.c                         |    9 --
 net/sched/sch_netem.c                          |    4 -
 net/sched/sch_tbf.c                            |    5 -
 net/sctp/proc.c                                |    4 -
 net/sctp/socket.c                              |   22 ++++--
 net/sunrpc/auth_gss/gss_krb5_crypto.c          |   12 ++-
 scripts/depmod.sh                              |    4 -
 scripts/mod/modpost.c                          |    8 +-
 sound/soc/codecs/wm8994.c                      |    1=20
 tools/perf/arch/powerpc/util/sym-handling.c    |    4 -
 tools/testing/selftests/powerpc/harness.c      |   18 +++--
 82 files changed, 375 insertions(+), 189 deletions(-)

Aleh Filipovich (1):
      platform/x86: asus-nb-wmi: Add keymap entry for lid flip action on UX=
360

Alexey Kodanev (1):
      vti6: remove !skb->ignore_df check from vti6_xmit()

Andrey Ryabinin (1):
      mm/fadvise.c: fix signed overflow UBSAN complaint

Anthony Wong (1):
      r8169: add support for NCube 8168 network card

Arnd Bergmann (1):
      reiserfs: change j_timestamp type to time64_t

Breno Leitao (1):
      selftests/powerpc: Kill child processes on SIGINT

Chas Williams (1):
      Fixes: Commit 2aa6d036b716 ("mm: numa: avoid waiting on freed migrate=
d pages")

Cong Wang (3):
      act_ife: fix a potential use-after-free
      act_ife: move tcfa_lock down to where necessary
      act_ife: fix a potential deadlock

Dan Carpenter (2):
      powerpc: Fix size calculation using resource_size()
      scsi: aic94xx: fix an error code in aic94xx_init()

Doug Berger (1):
      net: bcmgenet: use MAC link status for fixed phy

Eric Dumazet (2):
      ipv4: tcp: send zero IPID for RST and ACK sent in SYN-RECV and TIME-W=
AIT state
      tcp: Revert "tcp: tcp_probe: use spin_lock_bh()"

Ernesto A. Fern=E1ndez (2):
      hfs: prevent crash on exit from failed search
      hfsplus: fix NULL dereference in hfsplus_lookup()

Ethan Lien (1):
      btrfs: use correct compare function of dirty_metadata_bytes

Fabio Estevam (1):
      Revert "ARM: imx_v6_v7_defconfig: Select ULPI support"

Florian Westphal (1):
      tcp: do not restart timewait timer on rst reception

Gal Pressman (1):
      RDMA/hns: Fix usage of bitmap allocation functions return values

Govindarajulu Varadarajan (1):
      enic: do not call enic_change_mtu in enic_probe

Greg Edwards (1):
      block: bvec_nr_vecs() returns value for wrong slab

Greg Kroah-Hartman (1):
      Linux 4.9.127

Guenter Roeck (1):
      mfd: sm501: Set coherent_dma_mask when creating subdevices

Gustavo A. R. Silva (1):
      ASoC: wm8994: Fix missing break in switch

Hans de Goede (1):
      ACPI / scan: Initialize status to ACPI_STA_DEFAULT

Ian Abbott (1):
      staging: comedi: ni_mio_common: fix subdevice flags for PFI subdevice

Jann Horn (1):
      fork: don't copy inconsistent signal handler state to child

Jason Wang (1):
      vhost: correctly check the iova range when waking virtqueue

Jean-Philippe Brucker (1):
      net/9p: fix error path of p9_virtio_probe

Joel Fernandes (Google) (1):
      debugobjects: Make stack check warning more informative

John Pittman (1):
      dm kcopyd: avoid softlockup in run_complete_job

Jonas Gorski (1):
      irqchip/bcm7038-l1: Hide cpu offline callback when building for !SMP

Juergen Gross (1):
      x86/pae: use 64 bit atomic xchg function in native_ptep_get_and_clear

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for SDC panel in Lenovo B50-80

Kees Cook (1):
      net: sched: Fix memory exposure from short TCA_U32_SEL

Laura Abbott (1):
      sunrpc: Don't use stack buffer with scatterlist

Levin Du (1):
      clk: rockchip: Add pclk_rkpwm_pmu to PMU critical clocks in rk3399

Mahesh Salgaonkar (1):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.

Manish Chopra (1):
      qlge: Fix netdev features configuration.

Marc Zyngier (2):
      arm64: rockchip: Force CONFIG_PM on Rockchip systems
      ARM: rockchip: Force CONFIG_PM on Rockchip systems

Martin Schwidefsky (1):
      s390/lib: use expoline for all bcr instructions

Michal Hocko (1):
      x86/speculation/l1tf: Fix up pte->pfn conversion for PAE

Misono Tomohiro (1):
      btrfs: replace: Reset on-disk dev stats value after replace

Nikolay Aleksandrov (5):
      sch_htb: fix crash on init failure
      sch_multiq: fix double free on init failure
      sch_hhf: fix null pointer dereference on init failure
      sch_netem: avoid null pointer deref on init failure
      sch_tbf: fix two null pointer dereferences on init failure

OGAWA Hirofumi (1):
      fat: validate ->i_start before using

Philipp Rudo (1):
      s390/kdump: Fix memleak in nt_vmcoreinfo

Qu Wenruo (2):
      btrfs: relocation: Only remove reloc rb_trees if reloc control has be=
en initialized
      btrfs: Don't remove block group that still has pinned down bytes

Randy Dunlap (3):
      scripts: modpost: check memory allocation results
      platform/x86: intel_punit_ipc: fix build errors
      kbuild: make missing $DEPMOD a Warning instead of an Error

Ronnie Sahlberg (1):
      cifs: check if SMB2 PDU size has been padded and suppress the warning

Sandipan Das (1):
      perf probe powerpc: Fix trace event post-processing

Stefan Haberland (2):
      s390/dasd: fix hanging offline processing due to canceled worker
      s390/dasd: fix panic for failed online processing

Stephen Hemminger (1):
      hv_netvsc: ignore devices that are not PCI

Steve French (2):
      smb3: fix reset of bytes read and written stats
      SMB3: Number of requests sent should be displayed for SMB3 not just C=
IFS

Suzuki K Poulose (3):
      virtio: pci-legacy: Validate queue pfn
      arm64: Fix mismatched cache line size detection
      arm64: Handle mismatched cache type

Tan Hu (1):
      ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Tetsuo Handa (2):
      hfsplus: don't return 0 when fill_super() failed
      fs/dcache.c: fix kmemcheck splat at take_dentry_name_snapshot()

Thomas Petazzoni (1):
      PCI: mvebu: Fix I/O space end address calculation

Tomas Bortoli (1):
      net/9p/trans_fd.c: fix race by holding the lock

Tomas Winkler (1):
      mei: me: allow runtime pm for platform with D0i3

Tyler Hicks (2):
      irda: Fix memory leak caused by repeated binds of irda socket
      irda: Only insert new objects into the global database via setsockopt

Vlad Buslov (1):
      net: sched: action_ife: take reference to meta module

Xin Long (1):
      sctp: hold transport before accessing its asoc in sctp_transport_get_=
next

YueHaibing (1):
      RDS: IB: fix 'passing zero to ERR_PTR()' warning


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluc2SIACgkQONu9yGCS
aT79qg/9FjV4r0Z+YxnqEh/QdpYSFC3bhHFmsiHifaujzhFn7DGWJlXQbR7SM1tg
OAjtPuboULHVQFfOZySxxPackVg7HW47nZ9hQh9v9fizPPAZuBYfeX3vW8FMwqmI
gGwfIbgP+mssdwqyuCnGArWs6zbavuchgBi+Xpjvfz2z21Rt9PIXatDNLIz7XJD9
u6sA+8CeNOuRReElwi97D7GGmlQFRYpd7RM5cDXdGca6o01et2idccuCHq4i7uD0
UHIr+moMb6JpEWEKeCC34NjQP06UrH1HRlO9CaQbgosMfvuBJpZhMzMs6KyleAQM
FMl+7gouv4pd0t5Nom6p8ySOvPahgMRTzcTzQB4law00UeyscMdn7ojtOa8sLdO2
o2sllaLEBQD13hphd7VmOdjmZeEK4zpSvn3piMcKuJDovsOAfb83DQHzUlwHx9tW
+q26Udk0hPCNzawu5MhKKo/OWb51H3/OP0bAzW+j0hxk47VzDcaVCSeBGYz84aVg
wq1Xze0RMKAS31iVjuz6844qHtppSUzqk6Bt6L2qenyIptTpcqhXnOKOkkfjaIM3
glOn6oj+5vLNkQy5tvNPDr+NdeDEmoZb3SDpOuk+ZFfvYRPgcCEbt4n5//dA5MNT
3ZJNx2ow7jxiCLF6RMwgIU5A/6cLdRZdtU9JjIXz2u3XSKhT1Os=
=tLXz
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
