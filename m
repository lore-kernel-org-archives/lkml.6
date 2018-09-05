Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A54C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EC42075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EC42075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbeIESyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:54:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34080 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbeIESyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:54:05 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 97B241147;
        Wed,  5 Sep 2018 14:22:57 +0000 (UTC)
Date:   Wed, 5 Sep 2018 16:22:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.121
Message-ID: <20180905142255.GA8883@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.121 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                  |    2=20
 arch/arc/include/asm/delay.h                              |    3=20
 arch/arc/mm/cache_arc700.c                                |    7 -
 arch/arm/kvm/mmu.c                                        |   42 +++++--
 arch/arm64/mm/init.c                                      |    6 -
 arch/mips/bcm47xx/setup.c                                 |    6 -
 arch/mips/include/asm/mipsregs.h                          |    3=20
 arch/mips/include/asm/processor.h                         |    2=20
 arch/mips/kernel/ptrace.c                                 |    2=20
 arch/mips/kernel/ptrace32.c                               |    2=20
 arch/s390/include/asm/qdio.h                              |    1=20
 arch/s390/mm/fault.c                                      |    2=20
 arch/s390/pci/pci.c                                       |    2=20
 arch/x86/kernel/process_64.c                              |    1=20
 drivers/cdrom/cdrom.c                                     |    2=20
 drivers/gpu/drm/udl/udl_fb.c                              |    2=20
 drivers/gpu/drm/udl/udl_main.c                            |   35 +++---
 drivers/net/can/mscan/mpc5xxx_can.c                       |    5=20
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c           |    1=20
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c       |   13 +-
 drivers/net/ethernet/cisco/enic/enic_main.c               |   78 ++++-----=
-----
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c         |    1=20
 drivers/net/wan/lmc/lmc_main.c                            |    2=20
 drivers/pinctrl/freescale/pinctrl-imx1-core.c             |    2=20
 drivers/s390/cio/qdio_main.c                              |    5=20
 drivers/scsi/fcoe/fcoe_ctlr.c                             |    4=20
 drivers/scsi/libiscsi.c                                   |   12 +-
 drivers/scsi/scsi_sysfs.c                                 |   20 +++
 drivers/scsi/vmw_pvscsi.c                                 |   11 +
 drivers/staging/imx-drm/imx-ldb.c                         |    9 +
 drivers/staging/media/omap4iss/iss_video.c                |    3=20
 drivers/usb/gadget/function/f_uac2.c                      |   20 +--
 drivers/usb/gadget/udc/r8a66597-udc.c                     |    6 -
 drivers/usb/phy/phy-fsl-usb.c                             |    4=20
 fs/btrfs/extent-tree.c                                    |    2=20
 fs/cachefiles/namei.c                                     |    1=20
 fs/cachefiles/rdwr.c                                      |   17 ++-
 fs/ext4/namei.c                                           |    1=20
 fs/fscache/operation.c                                    |    6 -
 fs/fuse/dev.c                                             |    7 -
 fs/fuse/file.c                                            |    1=20
 fs/sysfs/file.c                                           |   44 +++++++
 include/linux/sysfs.h                                     |   14 ++
 kernel/kprobes.c                                          |    4=20
 kernel/sysctl.c                                           |    3=20
 mm/memory.c                                               |    3=20
 mm/zswap.c                                                |    9 +
 net/caif/caif_dev.c                                       |    4=20
 net/ipv4/cipso_ipv4.c                                     |   12 +-
 net/mac80211/util.c                                       |    3=20
 net/wireless/nl80211.c                                    |    1=20
 net/xfrm/xfrm_policy.c                                    |    3=20
 net/xfrm/xfrm_user.c                                      |   10 +
 sound/soc/sirf/sirf-usp.c                                 |    7 -
 tools/power/x86/turbostat/turbostat.c                     |    8 -
 tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc |   28 +++++
 tools/usb/ffs-test.c                                      |   19 ++-
 57 files changed, 353 insertions(+), 170 deletions(-)

Andrey Ryabinin (1):
      fuse: Don't access pipe->buffers without pipe_lock()

Bart Van Assche (2):
      scsi: sysfs: Introduce sysfs_{un,}break_active_protection()
      scsi: core: Avoid that SCSI device removal through sysfs triggers a d=
eadlock

Bernd Edlinger (1):
      nl80211: Add a missing break in parse_station_flags

Calvin Walton (1):
      tools/power turbostat: Read extended processor family from CPUID

Claudio Imbrenda (1):
      s390/kvm: fix deadlock when killed by oom

Colin Ian King (1):
      drivers: net: lmc: fix case value for target abort error

Dan Carpenter (1):
      pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()

Eric Sandeen (1):
      ext4: reset error code in ext4_find_entry in fallback

Ethan Zhao (1):
      sched/sysctl: Check user input value of sysctl_sched_time_avg

Eugeniu Rosca (1):
      usb: gadget: f_uac2: fix endianness of 'struct cntrl_*_lay3'

Florian Westphal (2):
      xfrm: free skb if nlsk pointer is NULL
      atl1c: reserve min skb headroom

Govindarajulu Varadarajan (1):
      enic: handle mtu change for vf properly

Greg Hackmann (1):
      arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Greg Kroah-Hartman (1):
      Linux 3.18.121

Guenter Roeck (1):
      media: staging: omap4iss: Include asm/cacheflush.h after generic incl=
udes

Gustavo A. R. Silva (1):
      ASoC: sirf: Fix potential NULL pointer dereference

Jia-Ju Bai (2):
      usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs =
in init_controller()
      usb: gadget: r8a66597: Fix a possible sleep-in-atomic-context bugs in=
 r8a66597_queue()

Jim Gill (1):
      scsi: vmw_pvscsi: Return DID_RESET for status SAM_STAT_COMMAND_TERMIN=
ATED

Johannes Thumshirn (1):
      scsi: fcoe: drop frames in ELS LOGO error path

Josef Bacik (1):
      btrfs: don't leak ret from do_chunk_alloc

Julian Wiedmann (1):
      s390/qdio: reset old sbal_state flags

Kiran Kumar Modukuri (3):
      fscache: Allow cancelled operations to be enqueued
      cachefiles: Fix refcounting bug in backing-file read monitoring
      cachefiles: Wait rather than BUG'ing on "Unexpected object collision"

Kirill Tkhai (1):
      fuse: Add missed unlock_page() to fuse_readpages_fill()

Len Brown (1):
      tools/power turbostat: fix -S on UP systems

Li Wang (1):
      zswap: re-check zswap_is_full() after do zswap_shrink()

Lucas Stach (2):
      drm/imx: imx-ldb: disable LDB on driver bind
      drm/imx: imx-ldb: check if channel is enabled before printing warning

Maciej W. Rozycki (1):
      MIPS: Correct the 64-bit DSP accumulator register size

Masami Hiramatsu (2):
      selftests/ftrace: Add snapshot and tracing_on test case
      kprobes: Make list and blacklist root user read only

Mikulas Patocka (3):
      udl-kms: change down_interruptible to down
      udl-kms: handle allocation failure
      udl-kms: fix crash due to uninitialized memory

Nicholas Mc Guire (1):
      can: mpc5xxx_can: check of_iomap return before use

Peter Senna Tschudin (1):
      tools: usb: ffs-test: Fix build on big endian systems

Punit Agrawal (2):
      KVM: arm/arm64: Skip updating PTE entry if no change
      KVM: arm/arm64: Skip updating PMD entry if no change

Rafa=C5=82 Mi=C5=82ecki (1):
      Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"

Randy Dunlap (3):
      usb/phy: fix PPC64 build errors in phy-fsl-usb.c
      arc: fix build errors in arc/include/asm/delay.h
      arc: fix type warnings in arc/mm/cache.c

Rian Hunter (1):
      x86/process: Re-export start_thread()

Scott Bauer (1):
      cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

Sebastian Ott (1):
      s390/pci: fix out of bounds access during irq setup

Shubhrajyoti Datta (1):
      net: axienet: Fix double deregister of mdio

Sudarsana Reddy Kalluru (1):
      bnx2x: Fix invalid memory access in rss hash config path.

Tommi Rantala (1):
      xfrm: fix missing dst_release() after policy blocking lbcast and mult=
icast

Varun Prakash (1):
      scsi: libiscsi: fix possible NULL pointer dereference in case of TMF

YueHaibing (1):
      net: caif: Add a missing rcu_read_unlock() in caif_flow_cb

jie@chenjie6@huwei.com (1):
      mm/memory.c: check return value of ioremap_prot

mpubbise@codeaurora.org (1):
      mac80211: add stations tied to AP_VLANs during hw reconfig

yujuan.qi (1):
      Cipso: cipso_v4_optptr enter infinite loop


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluP5rwACgkQONu9yGCS
aT5WMBAApjoi3cFi1CGm1MRn3KBZA9Ji+oDViEqU/QuHIytnZ7JMSR6y4nj2g/+4
qSvNbFuAHho3ncU8tbRUkFyVK87KFT20Lrxa2tRAL1dInMI6/PPxVXuEorSOmTAi
yewRuKauFcMuWYpK2iNjsuOQeZhiGCx+goSoiRltUXP3JbRV5L/MnDfOtnCwP14w
EXOH76adQwTzLbP1h4acmbaa6xyD1CFkhOqoJ11pC4vngC7gY4V3kolIvwrfHSOZ
mXlshtVLMclZ7nRf1R5ysgMwSrHRScGWqr4IApms8f/6ZTruahoyxuPbkHjjjpsi
1nGruSWjHQrvhYDoLeVgyy7vAjghk/ghgxmw/CCWzt2KDWMSv6OmteXrQSl64sF7
josCM63kS6EdHYmRUZ7APxAr/2wTneuY3Pu2KrMFwH+RXuhI5zo8mSDu9j7eS+Nz
V4UxLuLJPRzTJ0Wd8s5UhFOKwMFnHCwqrxYWs/fXLIzgtTWuMJdBP8Ch4aAyGz94
oExIu6iLzXkDVdvVw1ZEsGpOZODJ0kpLXuEiFurJaRH+GpKPG9kPRfgVpx+BdRcc
2pRIOgopbbKRi+weK9Y8gKeX4KZQTvG4goONaFznmw8lCsqn/tQv/gjMZzZfcp2t
Y2+1WacMwA23bbr/jv01Je6KgbjF9ftYmpvHT/QXs6i4aOzMLr0=
=dFf5
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
