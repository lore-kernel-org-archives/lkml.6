Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADE0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2694C2184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216891;
	bh=Pns9y9VYMwCMQC2IekF5eLC6XrR1jo+cd+tOftlo8bQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=N/sV2SAWBs2tlkC716UFkvES8ReAKNeA9CksAFoC4ypCK9g9+tF18vvPSma9N0OIQ
	 s1Kh9r+tSpVwu8MeLoxiJ40/zM4mgnkufUmY0y4bI9T10/ho3lgidAj8eCAoDt995N
	 rywOsY7AYkgky+5zTpF9wx2KUaxESGSifskZT4Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbfAKO2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388452AbfAKO2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:28:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60BD62133F;
        Fri, 11 Jan 2019 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216884;
        bh=Pns9y9VYMwCMQC2IekF5eLC6XrR1jo+cd+tOftlo8bQ=;
        h=From:To:Cc:Subject:Date:From;
        b=j7ZqeO75Zbt/j2+r7PGSjB0Jcdtk+flnMTRg6edq+Ff0Au+X/K9L2AMDEr7PIsmFO
         idnA3UvLd+BsBhB6+AJmyYmSLw3vYAW/1vR5jJmv+FzoJNLk/BKFmZR+X9aee+fV99
         1wPo5n51//f8WpshL2vhB4NVqZeM7bd3/Ii2ROBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/63] 4.9.150-stable review
Date:   Fri, 11 Jan 2019 15:14:03 +0100
Message-Id: <20190111131046.387528003@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.150-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.150-rc1
X-KernelTest-Deadline: 2019-01-13T13:10+00:00
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.150 release.
There are 63 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jan 13 13:10:03 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.150-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.150-rc1

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Set ->is_yuv to false when num_planes == 1

Lubomir Rintel <lkundrak@v3.sk>
    power: supply: olpc_battery: correct the temperature units

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: msu: Fix an off-by-one in attribute store

Christian Borntraeger <borntraeger@de.ibm.com>
    genwqe: Fix size check

Yan, Zheng <zyan@redhat.com>
    ceph: don't update importing cap's mseq when handing cap export

Sohil Mehta <sohil.mehta@intel.com>
    iommu/vt-d: Handle domain agaw being less than iommu agaw

Sagi Grimberg <sagi@grimberg.me>
    rxe: fix error completion wr_id and qp_num

Dominique Martinet <dominique.martinet@cea.fr>
    9p/net: put a lower bound on msize

Breno Leitao <leitao@debian.org>
    powerpc/tm: Set MSR[TS] just prior to recheckpoint

Larry Finger <Larry.Finger@lwfinger.net>
    b43: Fix error in cordic routine

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Fix loop in gfs2_rbm_find

Andreas Gruenbacher <agruenba@redhat.com>
    gfs2: Get rid of potential double-freeing in gfs2_create_inode

Vasily Averin <vvs@virtuozzo.com>
    dlm: memory leaks on error path in dlm_user_request()

Vasily Averin <vvs@virtuozzo.com>
    dlm: lost put_lkb on error path in receive_convert() and receive_unlock()

Vasily Averin <vvs@virtuozzo.com>
    dlm: possible memory leak on error path in create_lkb()

Vasily Averin <vvs@virtuozzo.com>
    dlm: fixed memory leaks after failed ls_remove_names allocation

Hui Peng <benquike@163.com>
    ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Avoid access before bLength check in build_audio_procunit()

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: cs46xx: Potential NULL dereference in probe

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Incorrect sizing of sge for PIO will OOPs

Stefan Hajnoczi <stefanha@redhat.com>
    vhost/vsock: fix uninitialized vhost_vsock->guest_cid

Eric Biggers <ebiggers@google.com>
    crypto: x86/chacha20 - avoid sleeping with preemption disabled

Paul Burton <paul.burton@mips.com>
    MIPS: math-emu: Write-protect delay slot emulation pages

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use SVC_NET() in svcauth_gss_* functions

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: fix cache_head leak due to queued request

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: kill mapping "System RAM" support

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL

Michal Hocko <mhocko@suse.com>
    hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined

David Herrmann <dh.herrmann@gmail.com>
    fork: record start_time late

Ilya Dryomov <idryomov@gmail.com>
    libceph: fix CEPH_FEATURE_CEPHX_V2 check in calc_signature()

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix posting too many status read buffers leading to adapter shutdown

Yangtao Li <tiny.windzz@gmail.com>
    serial/sunsu: fix refcount leak

Kangjie Lu <kjlu@umn.edu>
    net: netxen: fix a missing check and an uninitialized use

Colin Ian King <colin.king@canonical.com>
    vxge: ensure data0 is initialized in when fetching firmware version information

Jason Martinsen <jasonmartinsen@msn.com>
    lan78xx: Resolve issue with changing MAC address

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix a race with XPRT_CONNECTING

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Add mac pcs config when enable|disable mac

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fix ntuple-filters status error.

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Avoid net reset caused by pause frames storm

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Free irq when exit from abnormal branch

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Clean rx fbd when ae stopped.

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fixed bug that netdev was opened twice

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Some registers use wrong address according to the datasheet.

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: All ports can not work when insmod hns ko after rmmod.

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Incorrect offset address used for some registers.

Arnd Bergmann <arnd@arndb.de>
    w90p910_ether: remove incorrect __init annotation

Nathan Chancellor <natechancellor@gmail.com>
    drivers: net: xgene: Remove unnecessary forward declarations

Varun Prakash <varun@chelsio.com>
    scsi: target: iscsi: cxgbit: add missing spin_lock_init()

Varun Prakash <varun@chelsio.com>
    scsi: target: iscsi: cxgbit: fix csk leak

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Send update-svid ramrod with retry/poll flags enabled

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Remove configured vlans as part of unload sequence.

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Clear fip MAC when fcoe offload support is disabled

Pan Bian <bianpan2016@163.com>
    netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel

Tony Lindgren <tony@atomide.com>
    Input: omap-keypad - fix idle configuration to not block SoC idle states

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: bnx2fc: Fix NULL dereference in error handling

Florian Westphal <fw@strlen.de>
    netfilter: seqadj: re-load tcp header pointer after possible head reallocation

Benjamin Poirier <bpoirier@suse.com>
    xfrm: Fix bucket count reported to userspace

Qian Cai <cai@lca.pw>
    checkstack.pl: fix for aarch64

Peter Hutterer <peter.hutterer@who-t.net>
    Input: restore EV_ABS ABS_RESERVED

Fabio Estevam <festevam@gmail.com>
    ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Anson Huang <anson.huang@nxp.com>
    ARM: imx: update the cpu power up timing setting on i.mx6sx

Paul Mackerras <paulus@ozlabs.org>
    powerpc: Fix COFF zImage booting on old powermacs

Jerome Brunet <jbrunet@baylibre.com>
    pinctrl: meson: fix pull enable register calculation


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |   9 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |   2 +-
 arch/mips/kernel/vdso.c                            |   4 +-
 arch/mips/math-emu/dsemul.c                        |  38 ++--
 arch/powerpc/boot/crt0.S                           |   4 +-
 arch/powerpc/kernel/signal_32.c                    |  20 +-
 arch/powerpc/kernel/signal_64.c                    |  44 ++--
 arch/x86/crypto/chacha20_glue.c                    |   1 +
 drivers/gpu/drm/vc4/vc4_plane.c                    |   1 +
 drivers/hwtracing/intel_th/msu.c                   |   3 +-
 drivers/infiniband/hw/hfi1/verbs.c                 |   2 +
 drivers/infiniband/sw/rxe/rxe_resp.c               |  13 +-
 drivers/input/keyboard/omap4-keypad.c              |  16 +-
 drivers/iommu/intel-iommu.c                        |   4 +-
 drivers/misc/genwqe/card_utils.c                   |   2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |   3 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  48 +++-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h     |   4 +-
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |   3 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  14 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  15 ++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 246 ++++++++++-----------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  13 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  43 +++-
 drivers/net/ethernet/neterion/vxge/vxge-config.c   |   2 +-
 drivers/net/ethernet/nuvoton/w90p910_ether.c       |   2 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_init.c   |   3 +-
 drivers/net/usb/lan78xx.c                          |   4 +
 drivers/net/wireless/broadcom/b43/phy_common.c     |   2 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |   3 +-
 drivers/power/supply/olpc_battery.c                |   4 +-
 drivers/s390/scsi/zfcp_aux.c                       |   6 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |   2 +-
 drivers/target/iscsi/cxgbit/cxgbit_cm.c            |   5 +-
 drivers/target/iscsi/cxgbit/cxgbit_main.c          |   1 +
 drivers/tty/serial/sunsu.c                         |  31 ++-
 drivers/vhost/vsock.c                              |   2 +
 fs/ceph/caps.c                                     |   1 -
 fs/dlm/lock.c                                      |  17 +-
 fs/dlm/lockspace.c                                 |   2 +-
 fs/gfs2/inode.c                                    |  18 +-
 fs/gfs2/rgrp.c                                     |   2 +-
 include/uapi/linux/input-event-codes.h             |   9 +
 kernel/fork.c                                      |  13 +-
 kernel/memremap.c                                  |  11 +-
 mm/memory_hotplug.c                                |  16 ++
 net/9p/client.c                                    |  21 ++
 net/ceph/auth_x.c                                  |   2 +-
 net/netfilter/ipset/ip_set_list_set.c              |   2 +-
 net/netfilter/nf_conntrack_seqadj.c                |   7 +-
 net/sunrpc/auth_gss/svcauth_gss.c                  |   8 +-
 net/sunrpc/cache.c                                 |  10 +-
 net/sunrpc/xprtsock.c                              |   4 +-
 net/xfrm/xfrm_state.c                              |   2 +-
 scripts/checkstack.pl                              |   4 +-
 sound/pci/cs46xx/dsp_spos.c                        |   3 +
 sound/usb/mixer.c                                  |  10 +-
 sound/usb/quirks-table.h                           |   3 +
 tools/testing/nvdimm/test/iomap.c                  |   2 +-
 61 files changed, 517 insertions(+), 274 deletions(-)


