Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3651ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F23A208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F23A208DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbeIOPWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 11:22:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47806 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeIOPWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 11:22:22 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0EDEFACD;
        Sat, 15 Sep 2018 10:03:55 +0000 (UTC)
Date:   Sat, 15 Sep 2018 12:03:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.156
Message-ID: <20180915100353.GA31010@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.156 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                       |    2=20
 arch/arm/configs/imx_v6_v7_defconfig           |    2=20
 arch/arm/include/asm/arch_gicv3.h              |    1=20
 arch/powerpc/platforms/pseries/ras.c           |    2=20
 arch/powerpc/sysdev/mpic_msgr.c                |    2=20
 arch/s390/lib/mem.S                            |    9 +-
 arch/x86/include/asm/pgtable-3level.h          |    7 -
 arch/x86/include/asm/pgtable.h                 |    2=20
 drivers/irqchip/irq-bcm7038-l1.c               |    4 +
 drivers/irqchip/irq-gic-v3-its.c               |   34 +++++----
 drivers/irqchip/irq-gic.c                      |    2=20
 drivers/md/dm-kcopyd.c                         |    2=20
 drivers/mfd/sm501.c                            |    1=20
 drivers/misc/mei/pci-me.c                      |    5 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.h |    3=20
 drivers/net/ethernet/broadcom/genet/bcmmii.c   |   10 ++
 drivers/net/ethernet/cisco/enic/enic_main.c    |    2=20
 drivers/net/ethernet/qlogic/qlge/qlge_main.c   |   23 ++----
 drivers/pci/host/pci-mvebu.c                   |    2=20
 drivers/platform/x86/asus-nb-wmi.c             |    1=20
 drivers/s390/block/dasd_eckd.c                 |    7 +
 drivers/scsi/aic94xx/aic94xx_init.c            |    4 -
 drivers/staging/android/ion/ion.c              |   60 +++++++++-------
 drivers/staging/comedi/drivers/ni_mio_common.c |    3=20
 fs/btrfs/dev-replace.c                         |    6 +
 fs/btrfs/disk-io.c                             |   10 +-
 fs/btrfs/extent-tree.c                         |    2=20
 fs/btrfs/relocation.c                          |   23 +++---
 fs/cifs/cifs_debug.c                           |    8 ++
 fs/cifs/smb2misc.c                             |    7 +
 fs/cifs/smb2pdu.c                              |    2=20
 fs/dcache.c                                    |    3=20
 fs/fat/cache.c                                 |   19 +++--
 fs/fat/fat.h                                   |    5 +
 fs/fat/fatent.c                                |    6 -
 fs/hfs/brec.c                                  |    7 +
 fs/hfsplus/dir.c                               |    4 -
 fs/hfsplus/super.c                             |    4 -
 fs/overlayfs/copy_up.c                         |   26 ------
 fs/overlayfs/dir.c                             |   67 +-----------------
 fs/overlayfs/overlayfs.h                       |    3=20
 fs/overlayfs/readdir.c                         |   93 +++++++++++++++++++-=
-----
 fs/overlayfs/super.c                           |   20 ++++-
 fs/reiserfs/reiserfs.h                         |    2=20
 kernel/fork.c                                  |    2=20
 kernel/irq/chip.c                              |    8 +-
 lib/debugobjects.c                             |    7 +
 mm/fadvise.c                                   |    8 +-
 mm/huge_memory.c                               |    2=20
 net/9p/trans_virtio.c                          |    3=20
 net/ipv4/tcp_minisocks.c                       |    3=20
 net/ipv6/ip6_vti.c                             |    2=20
 net/irda/af_irda.c                             |   13 +++
 net/netfilter/ipvs/ip_vs_core.c                |   15 ++--
 net/sched/sch_hhf.c                            |    3=20
 net/sched/sch_htb.c                            |    5 -
 net/sched/sch_multiq.c                         |    9 --
 net/sched/sch_netem.c                          |    4 -
 net/sched/sch_tbf.c                            |    5 -
 scripts/depmod.sh                              |    4 -
 scripts/mod/modpost.c                          |    8 +-
 sound/soc/codecs/wm8994.c                      |    1=20
 tools/testing/selftests/powerpc/harness.c      |   18 +++-
 63 files changed, 368 insertions(+), 259 deletions(-)

Aleh Filipovich (1):
      platform/x86: asus-nb-wmi: Add keymap entry for lid flip action on UX=
360

Alexey Kodanev (1):
      vti6: remove !skb->ignore_df check from vti6_xmit()

Andrey Ryabinin (1):
      mm/fadvise.c: fix signed overflow UBSAN complaint

Antonio Murdaca (1):
      ovl: override creds with the ones from the superblock mounter

Arnd Bergmann (1):
      reiserfs: change j_timestamp type to time64_t

Breno Leitao (1):
      selftests/powerpc: Kill child processes on SIGINT

Chas Williams (1):
      Fixes: Commit cdbf92675fad ("mm: numa: avoid waiting on freed migrate=
d pages")

Dan Carpenter (2):
      powerpc: Fix size calculation using resource_size()
      scsi: aic94xx: fix an error code in aic94xx_init()

Doug Berger (1):
      net: bcmgenet: use MAC link status for fixed phy

Ernesto A. Fern=E1ndez (2):
      hfs: prevent crash on exit from failed search
      hfsplus: fix NULL dereference in hfsplus_lookup()

Ethan Lien (1):
      btrfs: use correct compare function of dirty_metadata_bytes

Fabio Estevam (1):
      Revert "ARM: imx_v6_v7_defconfig: Select ULPI support"

Florian Westphal (1):
      tcp: do not restart timewait timer on rst reception

Govindarajulu Varadarajan (1):
      enic: do not call enic_change_mtu in enic_probe

Greg Hackmann (1):
      staging: android: ion: fix ION_IOC_{MAP,SHARE} use-after-free

Greg Kroah-Hartman (1):
      Linux 4.4.156

Guenter Roeck (1):
      mfd: sm501: Set coherent_dma_mask when creating subdevices

Gustavo A. R. Silva (1):
      ASoC: wm8994: Fix missing break in switch

Ian Abbott (1):
      staging: comedi: ni_mio_common: fix subdevice flags for PFI subdevice

Jann Horn (1):
      fork: don't copy inconsistent signal handler state to child

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

Mahesh Salgaonkar (1):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.

Manish Chopra (1):
      qlge: Fix netdev features configuration.

Marc Zyngier (3):
      irqchip/gic-v3-its: Recompute the number of pages on page size change
      irqchip/gic-v3: Add missing barrier to 32bit version of gic_read_iar()
      irqchip/gic: Make interrupt ID 1020 invalid

Martin Schwidefsky (1):
      s390/lib: use expoline for all bcr instructions

Michal Hocko (1):
      x86/speculation/l1tf: Fix up pte->pfn conversion for PAE

Miklos Szeredi (2):
      ovl: rename is_merge to is_lowest
      ovl: proper cleanup of workdir

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

Qu Wenruo (2):
      btrfs: relocation: Only remove reloc rb_trees if reloc control has be=
en initialized
      btrfs: Don't remove block group that still has pinned down bytes

Randy Dunlap (2):
      scripts: modpost: check memory allocation results
      kbuild: make missing $DEPMOD a Warning instead of an Error

Ronnie Sahlberg (1):
      cifs: check if SMB2 PDU size has been padded and suppress the warning

Shanker Donthineni (2):
      irqchip/gicv3-its: Fix memory leak in its_free_tables()
      irqchip/gicv3-its: Avoid cache flush beyond ITS_BASERn memory size

Stefan Haberland (1):
      s390/dasd: fix hanging offline processing due to canceled worker

Steve French (2):
      smb3: fix reset of bytes read and written stats
      SMB3: Number of requests sent should be displayed for SMB3 not just C=
IFS

Sudeep Holla (1):
      genirq: Delay incrementing interrupt count if it's disabled/pending

Tan Hu (1):
      ipvs: fix race between ip_vs_conn_new() and ip_vs_del_dest()

Tetsuo Handa (2):
      hfsplus: don't return 0 when fill_super() failed
      fs/dcache.c: fix kmemcheck splat at take_dentry_name_snapshot()

Thomas Petazzoni (1):
      PCI: mvebu: Fix I/O space end address calculation

Tomas Winkler (1):
      mei: me: allow runtime pm for platform with D0i3

Tyler Hicks (2):
      irda: Fix memory leak caused by repeated binds of irda socket
      irda: Only insert new objects into the global database via setsockopt


--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluc2QYACgkQONu9yGCS
aT4yQg//XnxTEcnClOcRMtgbrdgK6I6ro6E4FK9dxJf3JB8AlbpaWzl45oEoIDeh
DBDd98Znv6XQqqyQKVV25r2Zgs0pvu/iCzPEZkbjLWIQYoblgfdiHqxSsTI/Vvuy
BdPtuCkUbVKDhRzRb/by8sQcqlj6WCO1cg+3utDv2B90BxLgnXpb2Hpj9TKkNe56
3nN0AWWz7un2s9saEsxhGgCDfFedUqmPnHyG+svnXb/TgwugCJOkGRIjfYUkw1p3
CHjBqQH26Ze1nbGRmuJbQ0BPlC8Zx1p+mQpKsrypR+RRLSjvYJgVp3sIyUvUlfYk
KPQq0PFrpa7/5HG2Rx6iC/+7mcdkopX5cMyWh7b3vpLbAlN152+RTUHrOaV6OwdH
FvbKv/LW+caRuZk7asWPZDtC/ZaT5ag3f8Na8dVV4xldK6Qx7oJ+jrGJMI3XK8d+
BnFfI8g9BBoD5lE35HOwptn1jCRuCE/9fCTnIb6Lp/AP/B41F54wZsoqYEHEfGNG
mQFygLvCOQ1q4G65CVHBM+Cd5i/PuVbCNDN5qQDzBC9EAz6ZJtUwAVaazO2s7NHs
fx/BpX8OctWo7f7ixPTkcYHn7dVT6w2oWR0ivYTZg+NDDAHfra/aPp66cNrs60da
B+Dv1UInM9dHm/l96RVRzZAMSNEhA6tCZnvn5s4ObhnskLnDLNY=
=I669
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
