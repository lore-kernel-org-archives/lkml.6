Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519980948-2-8426207967528464593
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519980947; b=ZJwQwyZ4FuOC1JL8iBo2hpaahz45Wb6vwij4UjYAEmx17NC
    LgAHrsXmxrK7NQV7dLjIDV8ZqwaP+DavnCm/LbRp1hMer6ywMhkFMktPSG7ddLKS
    q7sLr+Wn13J/g7LPhvY76zdapAKsmrmT+62gLhDR/skFuWP1btq6chaRKb6u4tN2
    x4Vm8dwAjk7Y+MEPhluAKlempra+pMsPyczZLYm7DQFZ44MNR3iks1JMNCLNnN99
    I7YUDtWxwueN4uEQDJ4NJz5P+9M5mOqHYM/D8RiYFN7Vt/FwMTa7i/PXdLOCvsYm
    pzTS13m6PLQmGr6a4rQairPooCnaRv3Zi3SSY5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519980947; bh=bzWhCgh9N6noAo1HC5/rY5zPCR
    n8fvDa3iI3Y4Qk/gk=; b=v6/k656WrJC+4bh2dJRjM4ke3Rc1hVekDG4ZbArC+v
    dTKfGNQpHxHcLV81D9KKjT+/iCJklIQKZ7HpRnynioj72M0mHJH+CYrMQtBIV4Xb
    6D5Ksjc576+c57xnPWQHIMCYTHhi9BDp4DrVBZMfDUc/gC9Iy6JWhCeUcGohxzOa
    tCJkH3tf2aiKaCjWPzq2NJ7Xry3V6QS558tsb7XiyuPa/Aw8BY0lGs4sDXjPH0/V
    OekZxpAm/qEsPkJeQ+KXJGaqEQWZjMTr5ye8+yYSQWzEOsyKF4+AURI5xMoJXScl
    wSShCIKQRNz3ZvgufT2N/MMHcT26Lqwb578PvnzuwH8A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423718AbeCBIzn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 03:55:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423712AbeCBIzk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:55:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/34] 4.4.120-stable review
Date: Fri,  2 Mar 2018 09:50:56 +0100
Message-Id: <20180302084435.842679610@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.120-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.120-rc1
X-KernelTest-Deadline: 2018-03-04T08:44+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.120 release.
There are 34 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar  4 08:44:20 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.120-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.120-rc1

James Hogan <jhogan@kernel.org>
    MIPS: Implement __multi3 for GCC7 MIPS64r6 builds

Yangbo Lu <yangbo.lu@nxp.com>
    net: gianfar_ptp: move set_fipers() to spinlock protecting area

Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
    sctp: make use of pre-calculated len

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/gntdev: Fix partial gntdev_mmap() cleanup

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/gntdev: Fix off-by-one error when unmapping with holes

Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
    SolutionEngine771x: fix Ether platform data

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mdio-sun4i: Fix a memory leak

Eduardo Otubo <otubo@redhat.com>
    xen-netfront: enable device after manual module load

Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
    bnxt_en: Fix the 'Invalid VF' id check in bnxt_vf_ndo_prep routine.

Luu An Phu <phu.luuan@nxp.com>
    can: flex_can: Correct the checking for frame length in flexcan_start_xmit()

Johannes Berg <johannes.berg@intel.com>
    mac80211: mesh: drop frames appearing to be from us

Xiongwei Song <sxwjean@gmail.com>
    drm/ttm: check the return value of kzalloc

Tushar Dave <tushar.n.dave@oracle.com>
    e1000: fix disabling already-disabled warning

Aliaksei Karaliou <akaraliou.dev@gmail.com>
    xfs: quota: check result of register_shrinker()

Aliaksei Karaliou <akaraliou.dev@gmail.com>
    xfs: quota: fix missed destroy of qi_tree_lock

Erez Shitrit <erezsh@mellanox.com>
    IB/ipoib: Fix race condition in neigh creation

Leon Romanovsky <leonro@mellanox.com>
    IB/mlx4: Fix mlx4_ib_alloc_mr error flow

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: fix wrongly assigned configuration data

Matthieu CASTET <matthieu.castet@parrot.com>
    led: core: Fix brightness setting when setting delay_off=0

Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
    bnx2x: Improve reliability in case of nested PCI errors

Siva Reddy Kallam <siva.kallam@broadcom.com>
    tg3: Enable PHY reset in MTU change path for 5720

Siva Reddy Kallam <siva.kallam@broadcom.com>
    tg3: Add workaround to restrict 5762 MRRS to 2048

James Hogan <jhogan@kernel.org>
    lib/mpi: Fix umul_ppmm() for MIPS64r6

Arnd Bergmann <arnd@arndb.de>
    ARM: dts: ls1021a: fix incorrect clock references

Cathy Avery <cavery@redhat.com>
    scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error

Alexander Kochetkov <al.kochet@gmail.com>
    net: arc_emac: fix arc_emac_rx() error paths

Radu Pirea <radu.pirea@microchip.com>
    spi: atmel: fixed spin_lock usage inside atmel_spi_remove

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/pci: do a msi rearm on init

Al Viro <viro@zeniv.linux.org.uk>
    sget(): handle failures of register_shrinker()

Chunyan Zhang <zhang.lyra@gmail.com>
    ARM: 8731/1: Fix csum_partial_copy_from_user() stack mismatch

Brendan McGrath <redmcg@redmandi.dyndns.org>
    ipv6: icmp6: Allow icmp messages to be looped back

Sascha Hauer <s.hauer@pengutronix.de>
    mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM

Yunlei He <heyunlei@huawei.com>
    f2fs: fix a bug caused by NULL extent tree

Anna-Maria Gleixner <anna-maria@linutronix.de>
    hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)


-------------

Diffstat:

 Makefile                                         |  4 +-
 arch/arm/boot/dts/ls1021a-qds.dts                |  2 +-
 arch/arm/boot/dts/ls1021a-twr.dts                |  2 +-
 arch/arm/lib/csumpartialcopyuser.S               |  4 ++
 arch/mips/lib/Makefile                           |  3 +-
 arch/mips/lib/libgcc.h                           | 17 ++++++++
 arch/mips/lib/multi3.c                           | 54 ++++++++++++++++++++++++
 arch/sh/boards/mach-se/770x/setup.c              | 10 ++++-
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c   |  7 +++
 drivers/gpu/drm/ttm/ttm_page_alloc.c             |  2 +
 drivers/infiniband/hw/mlx4/mr.c                  |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c        | 25 ++++++++---
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c   |  5 ++-
 drivers/leds/led-core.c                          |  2 +-
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c           |  6 +--
 drivers/net/can/flexcan.c                        |  2 +-
 drivers/net/ethernet/arc/emac_main.c             | 53 +++++++++++++----------
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |  4 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c | 14 +++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c  |  2 +-
 drivers/net/ethernet/broadcom/tg3.c              | 13 +++++-
 drivers/net/ethernet/broadcom/tg3.h              |  4 ++
 drivers/net/ethernet/freescale/gianfar_ptp.c     |  3 +-
 drivers/net/ethernet/intel/e1000/e1000.h         |  3 +-
 drivers/net/ethernet/intel/e1000/e1000_main.c    | 27 +++++++++---
 drivers/net/phy/mdio-sun4i.c                     |  6 ++-
 drivers/net/xen-netfront.c                       |  1 +
 drivers/s390/block/dasd_3990_erp.c               | 10 +++++
 drivers/scsi/storvsc_drv.c                       |  3 +-
 drivers/spi/spi-atmel.c                          |  2 +-
 drivers/xen/gntdev.c                             |  8 ++--
 fs/f2fs/extent_cache.c                           | 10 ++++-
 fs/super.c                                       |  6 ++-
 fs/xfs/xfs_qm.c                                  | 46 +++++++++++++-------
 kernel/time/hrtimer.c                            |  7 ++-
 lib/mpi/longlong.h                               | 18 +++++++-
 net/ipv6/route.c                                 |  1 +
 net/mac80211/rx.c                                |  2 +
 net/sctp/socket.c                                | 16 ++++---
 39 files changed, 316 insertions(+), 90 deletions(-)
