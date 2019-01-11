Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF65C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A8A21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217073;
	bh=F2kqJdxWfpuk7oc+alO5uLVU0sPo7EW0BCf4dKgpk/A=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IO0AxRk15L3c1Amiou+7KTjozxpNb1Xkc18zNLzQoNPmv7T1detNRNWc/H5OuXUAZ
	 +Y27pDZR4QaePUmbPxkBP07ZW9AIJA/ymX39v8VFB9JD6wK/rQ47+woMSx3/xeQJJe
	 vS74ZF2EH/Ugn6hP2t6vxL8nNbVzN8SaZzulWULI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389120AbfAKObM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:50656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389103AbfAKObI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:31:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C052133F;
        Fri, 11 Jan 2019 14:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217067;
        bh=F2kqJdxWfpuk7oc+alO5uLVU0sPo7EW0BCf4dKgpk/A=;
        h=From:To:Cc:Subject:Date:From;
        b=kVmUR8dzmudcb8VKN+5ScJ86YjN5kUFIIwsLDF3TF2M1ULg0PhBJ9S4c8BHKcQGm4
         WGIT/1it8Sa6Vl3mVBiQTtPUwLxR/QfRcWlnqjmvdszJz5ItOeEREYHDyAyhmRlkk8
         NzP4MnIy95zz4kVxhYZkpzr4lX2zvNmM1g3dDTFg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/105] 4.14.93-stable review
Date:   Fri, 11 Jan 2019 15:13:31 +0100
Message-Id: <20190111131102.899065735@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.93-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.93-rc1
X-KernelTest-Deadline: 2019-01-13T13:11+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.93 release.
There are 105 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jan 13 13:10:07 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.93-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.93-rc1

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Set ->is_yuv to false when num_planes == 1

Christophe Leroy <christophe.leroy@c-s.fr>
    lib: fix build failure in CONFIG_DEBUG_VIRTUAL test

Lubomir Rintel <lkundrak@v3.sk>
    power: supply: olpc_battery: correct the temperature units

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: msu: Fix an off-by-one in attribute store

Christian Borntraeger <borntraeger@de.ibm.com>
    genwqe: Fix size check

Yan, Zheng <zyan@redhat.com>
    ceph: don't update importing cap's mseq when handing cap export

Linus Torvalds <torvalds@linux-foundation.org>
    sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c

Sohil Mehta <sohil.mehta@intel.com>
    iommu/vt-d: Handle domain agaw being less than iommu agaw

Sagi Grimberg <sagi@grimberg.me>
    rxe: fix error completion wr_id and qp_num

Dominique Martinet <dominique.martinet@cea.fr>
    9p/net: put a lower bound on msize

Breno Leitao <leitao@debian.org>
    powerpc/tm: Set MSR[TS] just prior to recheckpoint

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: relocatable: fix inconsistencies in linker script and options

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: drop linker script hack to hide __efistub_ symbols

Benjamin Coddington <bcodding@redhat.com>
    lockd: Show pid of lockd for remote locks

Ondrej Mosnacek <omosnace@redhat.com>
    selinux: policydb - fix byte order and alignment issues

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

Damien Le Moal <damien.lemoal@wdc.com>
    dm zoned: Fix target BIO completion handling

Mikulas Patocka <mpatocka@redhat.com>
    dm verity: fix crash on bufio buffer that was allocated with vmalloc

Stefan Hajnoczi <stefanha@redhat.com>
    vhost/vsock: fix uninitialized vhost_vsock->guest_cid

Joel Stanley <joel@jms.id.au>
    raid6/ppc: Fix build for clang

Joel Stanley <joel@jms.id.au>
    powerpc/boot: Set target when cross-compiling for clang

Joel Stanley <joel@jms.id.au>
    Makefile: Export clang toolchain variables

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: consolidate Clang compiler flags

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: add -no-integrated-as Clang option unconditionally

Matthias Kaehlcke <mka@chromium.org>
    md: raid10: remove VLAIS

Joel Stanley <joel@jms.id.au>
    ftrace: Build with CPPFLAGS to get -Qunused-arguments

Joel Stanley <joel@jms.id.au>
    powerpc: Disable -Wbuiltin-requires-header when setjmp is used

Nicholas Piggin <npiggin@gmail.com>
    powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use SVC_NET() in svcauth_gss_* functions

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: fix cache_head leak due to queued request

Huang Ying <ying.huang@intel.com>
    mm, swap: fix swapoff with KSM pages

Dan Williams <dan.j.williams@intel.com>
    mm, hmm: mark hmm_devmem_{add, add_resource} EXPORT_SYMBOL_GPL

Dan Williams <dan.j.williams@intel.com>
    mm, hmm: use devm semantics for hmm_devmem_{add, remove}

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: kill mapping "System RAM" support

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: mark devm_memremap_pages() EXPORT_SYMBOL_GPL

Michal Hocko <mhocko@suse.com>
    hwpoison, memory_hotplug: allow hwpoisoned pages to be offlined

Minchan Kim <minchan@kernel.org>
    zram: fix double free backing device

David Herrmann <dh.herrmann@gmail.com>
    fork: record start_time late

Martin Kelly <martin@martingkelly.com>
    tools: fix cross-compile var clobbering

Thomas Gleixner <tglx@linutronix.de>
    genirq/affinity: Don't return with empty affinity masks on error

Ewan D. Milne <emilne@redhat.com>
    scsi: lpfc: do not set queue->page_count to 0 if pc_sli4_params.wqpcnt is invalid

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix posting too many status read buffers leading to adapter shutdown

Yangtao Li <tiny.windzz@gmail.com>
    serial/sunsu: fix refcount leak

Daniele Palmas <dnlplm@gmail.com>
    qmi_wwan: Fix qmap header retrieval in qmimux_rx_fixup

Kangjie Lu <kjlu@umn.edu>
    net: netxen: fix a missing check and an uninitialized use

Mantas Mikulėnas <grawity@gmail.com>
    Input: synaptics - enable SMBus for HP EliteBook 840 G4

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    gpio: mvebu: only fail on missing clk if pwm is actually to be used

Michael S. Tsirkin <mst@redhat.com>
    virtio: fix test build after uio.h change

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: fix false positive warning/error about missing libelf

Sara Sharon <sara.sharon@intel.com>
    mac80211: free skb fraglist before freeing the skb

Colin Ian King <colin.king@canonical.com>
    vxge: ensure data0 is initialized in when fetching firmware version information

Jason Martinsen <jasonmartinsen@msn.com>
    lan78xx: Resolve issue with changing MAC address

Anssi Hannula <anssi.hannula@bitwise.fi>
    net: macb: fix dropped RX frames due to a race

Anssi Hannula <anssi.hannula@bitwise.fi>
    net: macb: fix random memory corruption on RX with 64-bit DMA

Dan Carpenter <dan.carpenter@oracle.com>
    qed: Fix an error code qed_ll2_start_xmit()

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix a race with XPRT_CONNECTING

Yonglong Liu <liuyonglong@huawei.com>
    net: hns: Fix ping failed when use net bridge and send multicast

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

Sinan Kaya <okaya@kernel.org>
    x86, hyperv: remove PCI dependency

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

Florian Westphal <fw@strlen.de>
    netfilter: nat: can't use dst_hold on noref dst

Pan Bian <bianpan2016@163.com>
    netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel

Stefan Assmann <sassmann@kpanic.de>
    i40e: fix mac filter delete when setting mac address

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/dump_pagetables: Fix LDT remap address marker

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/mm: Fix guard hole handling

YueHaibing <yuehaibing@huawei.com>
    ieee802154: ca8210: fix possible u8 overflow in ca8210_rx_done

Thomas Falcon <tlfalcon@linux.ibm.com>
    ibmvnic: Fix non-atomic memory allocation in IRQ context

Yussuf Khalil <dev@pp3345.net>
    Input: synaptics - enable RMI on ThinkPad T560

Tony Lindgren <tony@atomide.com>
    Input: omap-keypad - fix idle configuration to not block SoC idle states

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: bnx2fc: Fix NULL dereference in error handling

Florian Westphal <fw@strlen.de>
    netfilter: seqadj: re-load tcp header pointer after possible head reallocation

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix NULL pointer dereference in xfrm_input when skb_dst_force clears the dst_entry.

Benjamin Poirier <bpoirier@suse.com>
    xfrm: Fix bucket count reported to userspace

Wei Yongjun <weiyongjun1@huawei.com>
    xfrm: Fix error return code in xfrm_output_one()

Qian Cai <cai@lca.pw>
    checkstack.pl: fix for aarch64

Peter Hutterer <peter.hutterer@who-t.net>
    Input: restore EV_ABS ABS_RESERVED

Fabio Estevam <festevam@gmail.com>
    ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Anson Huang <anson.huang@nxp.com>
    ARM: imx: update the cpu power up timing setting on i.mx6sx

Hans de Goede <hdegoede@redhat.com>
    HID: ite: Add USB id match for another ITE based keyboard rfkill key quirk

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix linux page tables build with some configs

Paul Mackerras <paulus@ozlabs.org>
    powerpc: Fix COFF zImage booting on old powermacs

Jerome Brunet <jbrunet@baylibre.com>
    pinctrl: meson: fix pull enable register calculation


-------------

Diffstat:

 Makefile                                           |  31 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |   9 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |   2 +-
 arch/arm64/Makefile                                |   2 +-
 arch/arm64/kernel/image.h                          |  44 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   9 +-
 arch/powerpc/Makefile                              |   7 +-
 arch/powerpc/boot/Makefile                         |   5 +
 arch/powerpc/boot/crt0.S                           |   4 +-
 arch/powerpc/kernel/Makefile                       |   3 +
 arch/powerpc/kernel/signal_32.c                    |  20 +-
 arch/powerpc/kernel/signal_64.c                    |  44 +-
 arch/powerpc/mm/dump_linuxpagetables.c             |   1 +
 arch/powerpc/xmon/Makefile                         |   5 +-
 arch/x86/include/asm/pgtable_64_types.h            |   5 +
 arch/x86/mm/dump_pagetables.c                      |  15 +-
 arch/x86/xen/mmu_pv.c                              |  11 +-
 drivers/block/zram/zram_drv.c                      |   4 +-
 drivers/gpio/gpio-mvebu.c                          |   6 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |   1 +
 drivers/hid/hid-ids.h                              |   3 +
 drivers/hid/hid-ite.c                              |   1 +
 drivers/hv/Kconfig                                 |   2 +-
 drivers/hwtracing/intel_th/msu.c                   |   3 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  13 +-
 drivers/input/keyboard/omap4-keypad.c              |  16 +-
 drivers/input/mouse/synaptics.c                    |   2 +
 drivers/iommu/intel-iommu.c                        |   4 +-
 drivers/md/dm-verity-target.c                      |  24 +-
 drivers/md/dm-zoned-target.c                       | 122 ++---
 drivers/md/raid10.c                                |  15 +-
 drivers/misc/genwqe/card_utils.c                   |   2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |   3 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  48 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h     |   4 +-
 drivers/net/ethernet/cadence/macb_main.c           |  14 +-
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |   3 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  14 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  15 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 503 ++++++++++++++-------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  13 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  43 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  14 +-
 drivers/net/ethernet/neterion/vxge/vxge-config.c   |   2 +-
 drivers/net/ethernet/nuvoton/w90p910_ether.c       |   2 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_init.c   |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |   1 +
 drivers/net/ieee802154/ca8210.c                    |   4 +-
 drivers/net/usb/lan78xx.c                          |   4 +
 drivers/net/usb/qmi_wwan.c                         |  15 +-
 drivers/net/wireless/broadcom/b43/phy_common.c     |   2 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |   3 +-
 drivers/power/supply/olpc_battery.c                |   4 +-
 drivers/s390/scsi/zfcp_aux.c                       |   6 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |   2 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   3 +-
 drivers/target/iscsi/cxgbit/cxgbit_cm.c            |   5 +-
 drivers/target/iscsi/cxgbit/cxgbit_main.c          |   1 +
 drivers/tty/serial/sunsu.c                         |  31 +-
 drivers/vhost/vsock.c                              |   2 +
 fs/ceph/caps.c                                     |   1 -
 fs/dlm/lock.c                                      |  17 +-
 fs/dlm/lockspace.c                                 |   2 +-
 fs/gfs2/inode.c                                    |  18 +-
 fs/gfs2/rgrp.c                                     |   2 +-
 fs/lockd/clntproc.c                                |   2 +-
 fs/lockd/xdr.c                                     |   4 +-
 fs/lockd/xdr4.c                                    |   4 +-
 include/linux/hmm.h                                |   4 +-
 include/uapi/linux/input-event-codes.h             |   9 +
 kernel/fork.c                                      |  13 +-
 kernel/irq/affinity.c                              |  15 +-
 kernel/memremap.c                                  |  11 +-
 kernel/sched/fair.c                                |  43 +-
 lib/raid6/Makefile                                 |  15 +
 lib/test_debug_virtual.c                           |   1 +
 mm/hmm.c                                           | 131 ++----
 mm/memory_hotplug.c                                |  16 +
 mm/swapfile.c                                      |   3 +-
 net/9p/client.c                                    |  21 +
 net/mac80211/status.c                              |   5 +
 net/netfilter/ipset/ip_set_list_set.c              |   2 +-
 net/netfilter/nf_conntrack_seqadj.c                |   7 +-
 net/netfilter/nf_nat_core.c                        |   3 +-
 net/sunrpc/auth_gss/svcauth_gss.c                  |   8 +-
 net/sunrpc/cache.c                                 |  10 +-
 net/sunrpc/xprtsock.c                              |   4 +-
 net/xfrm/xfrm_input.c                              |   7 +-
 net/xfrm/xfrm_output.c                             |   1 +
 net/xfrm/xfrm_state.c                              |   2 +-
 scripts/Makefile.build                             |   2 +-
 scripts/checkstack.pl                              |   4 +-
 security/selinux/ss/policydb.c                     |  51 ++-
 sound/pci/cs46xx/dsp_spos.c                        |   3 +
 sound/usb/mixer.c                                  |  10 +-
 sound/usb/quirks-table.h                           |   3 +
 tools/cgroup/Makefile                              |   1 -
 tools/gpio/Makefile                                |   2 -
 tools/hv/Makefile                                  |   1 -
 tools/iio/Makefile                                 |   2 -
 tools/laptop/freefall/Makefile                     |   1 -
 tools/leds/Makefile                                |   1 -
 tools/perf/Makefile.perf                           |   6 -
 tools/power/acpi/Makefile.config                   |   3 -
 tools/scripts/Makefile.include                     |  18 +
 tools/spi/Makefile                                 |   2 -
 tools/testing/nvdimm/test/iomap.c                  |   2 +-
 tools/usb/Makefile                                 |   1 -
 tools/virtio/linux/kernel.h                        |   4 +
 tools/vm/Makefile                                  |   1 -
 112 files changed, 1035 insertions(+), 666 deletions(-)


