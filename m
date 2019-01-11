Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD75C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E6F20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218586;
	bh=Uo9jnagu4lwcajwmEEIz566SMMF7LPr10fHEUq9AQRE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Mc1c9Eqyr63LnURYZdlCtXTJOaPaaR8FEIWHuKl+nn9ZxXIEx3CTZYoJm45DUdvup
	 Y0cRcwQ9Ko8OAaMZyooaQ+w1Z7AJZC+yfFg0h6vLCGCGlfNrCMoMMXZpOuU/q5fJw9
	 Op4sntwjTyjDzQitgSMoNblKPm3qDhnHfvM3A4PM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390732AbfAKO4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:56:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:56016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389791AbfAKOfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:35:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B6F7204EC;
        Fri, 11 Jan 2019 14:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217344;
        bh=Uo9jnagu4lwcajwmEEIz566SMMF7LPr10fHEUq9AQRE=;
        h=From:To:Cc:Subject:Date:From;
        b=MuATO6ciO8BWiIhBwZUR6wXKxpyiYqHmIpQ+jIHK2ZEi8mKza3iKnEqQVxrG0yBhT
         dVmmcfFh3ts8VeHX3F81mUoFxwzNN9EOdTbJi6TcM9Kb2aFlo59xGFolZSuYe9vcpu
         +HQ+se7N8fDzkMv8x4HlAtS0Aw4GW0Iqw7+tZM3E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.19 000/148] 4.19.15-stable review
Date:   Fri, 11 Jan 2019 15:12:58 +0100
Message-Id: <20190111131114.337122649@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.15-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.15-rc1
X-KernelTest-Deadline: 2019-01-13T13:11+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.19.15 release.
There are 148 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Jan 13 13:10:11 UTC 2019.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.15-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.19.15-rc1

Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
    drm/amd/display: Fix unintialized max_bpc state values

Enric Balletbo i Serra <enric.balletbo@collabora.com>
    drm/rockchip: psr: do not dereference encoder before it is null checked.

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Set ->is_yuv to false when num_planes == 1

Lyude Paul <lyude@redhat.com>
    drm/nouveau/drm/nouveau: Check rc from drm_dp_mst_topology_mgr_resume()

Christophe Leroy <christophe.leroy@c-s.fr>
    lib: fix build failure in CONFIG_DEBUG_VIRTUAL test

Frank Rowand <frank.rowand@sony.com>
    of: __of_detach_node() - remove node from phandle cache

Frank Rowand <frank.rowand@sony.com>
    of: of_node_get()/of_node_put() nodes held in phandle cache

Lubomir Rintel <lkundrak@v3.sk>
    power: supply: olpc_battery: correct the temperature units

Alexander Shishkin <alexander.shishkin@linux.intel.com>
    intel_th: msu: Fix an off-by-one in attribute store

Christian Borntraeger <borntraeger@de.ibm.com>
    genwqe: Fix size check

Shaokun Zhang <zhangshaokun@hisilicon.com>
    drivers/perf: hisi: Fixup one DDRC PMU register offset

YueHaibing <yuehaibing@huawei.com>
    video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"

Yan, Zheng <zyan@redhat.com>
    ceph: don't update importing cap's mseq when handing cap export

Linus Torvalds <torvalds@linux-foundation.org>
    sched/fair: Fix infinite loop in update_blocked_averages() by reverting a9e7f6544b9c

Sohil Mehta <sohil.mehta@intel.com>
    iommu/vt-d: Handle domain agaw being less than iommu agaw

Bart Van Assche <bvanassche@acm.org>
    RDMA/srpt: Fix a use-after-free in the channel release code

Sagi Grimberg <sagi@grimberg.me>
    rxe: fix error completion wr_id and qp_num

Dominique Martinet <dominique.martinet@cea.fr>
    9p/net: put a lower bound on msize

Mircea Caprioru <mircea.caprioru@analog.com>
    iio: dac: ad5686: fix bit shift read register

Breno Leitao <leitao@debian.org>
    powerpc/tm: Set MSR[TS] just prior to recheckpoint

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "powerpc/tm: Unset MSR[TS] if not recheckpointing"

Jerome Brunet <jbrunet@baylibre.com>
    leds: pwm: silently error out on EPROBE_DEFER

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: relocatable: fix inconsistencies in linker script and options

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: drop linker script hack to hide __efistub_ symbols

J. Bruce Fields <bfields@redhat.com>
    nfsd4: zero-length WRITE should succeed

Benjamin Coddington <bcodding@redhat.com>
    lockd: Show pid of lockd for remote locks

Jarkko Nikula <jarkko.nikula@linux.intel.com>
    PCI / PM: Allow runtime PM without callback functions

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

Damien Le Moal <damien.lemoal@wdc.com>
    block: mq-deadline: Fix write completion handling

Ming Lei <ming.lei@redhat.com>
    block: deactivate blk_stat timer in wbt_disable_default()

Matthew Wilcox <willy@infradead.org>
    Fix failure path in alloc_pid()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    driver core: Add missing dev->bus->need_parent_lock checks

Dennis Krein <Dennis.Krein@netapp.com>
    srcu: Lock srcu_data structure in srcu_gp_start()

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Always check descriptor sizes in parser code

Hui Peng <benquike@163.com>
    ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Check mixer unit descriptors more strictly

Takashi Iwai <tiwai@suse.de>
    ALSA: usb-audio: Avoid access before bLength check in build_audio_procunit()

Dan Carpenter <dan.carpenter@oracle.com>
    ALSA: cs46xx: Potential NULL dereference in probe

Brad Love <brad@nextdimension.cc>
    media: cx23885: only reset DMA on problematic CPUs

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76x0: init hw capabilities

Lendacky, Thomas <Thomas.Lendacky@amd.com>
    dma-direct: do not include SME mask in the DMA supported check

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

Joel Stanley <joel@jms.id.au>
    powerpc: Disable -Wbuiltin-requires-header when setjmp is used

Nicholas Piggin <npiggin@gmail.com>
    powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer

Nicholas Piggin <npiggin@gmail.com>
    powerpc: consolidate -mno-sched-epilog into FTRACE flags

Nicholas Piggin <npiggin@gmail.com>
    powerpc: remove old GCC version checks

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: use SVC_NET() in svcauth_gss_* functions

Vasily Averin <vvs@virtuozzo.com>
    sunrpc: fix cache_head leak due to queued request

Michal Hocko <mhocko@suse.com>
    memcg, oom: notify on oom killer invocation from the charge path

Huang Ying <ying.huang@intel.com>
    mm, swap: fix swapoff with KSM pages

Dan Williams <dan.j.williams@intel.com>
    mm, hmm: mark hmm_devmem_{add, add_resource} EXPORT_SYMBOL_GPL

Dan Williams <dan.j.williams@intel.com>
    mm, hmm: use devm semantics for hmm_devmem_{add, remove}

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: add MEMORY_DEVICE_PRIVATE support

Dan Williams <dan.j.williams@intel.com>
    mm, devm_memremap_pages: fix shutdown handling

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

Ewan D. Milne <emilne@redhat.com>
    scsi: lpfc: do not set queue->page_count to 0 if pc_sli4_params.wqpcnt is invalid

Steffen Maier <maier@linux.ibm.com>
    scsi: zfcp: fix posting too many status read buffers leading to adapter shutdown

Mans Rullgard <mans@mansr.com>
    auxdisplay: charlcd: fix x/y command parsing

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

Bryan Whitehead <Bryan.Whitehead@microchip.com>
    lan743x: Remove MAC Reset from initialization

Michael S. Tsirkin <mst@redhat.com>
    virtio: fix test build after uio.h change

Geert Uytterhoeven <geert@linux-m68k.org>
    m68k: Fix memblock-related crashes

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: fix false positive warning/error about missing libelf

Sara Sharon <sara.sharon@intel.com>
    mac80211: free skb fraglist before freeing the skb

Johannes Berg <johannes.berg@intel.com>
    nl80211: fix memory leak if validate_pae_over_nl80211() fails

Colin Ian King <colin.king@canonical.com>
    vxge: ensure data0 is initialized in when fetching firmware version information

Jason Martinsen <jasonmartinsen@msn.com>
    lan78xx: Resolve issue with changing MAC address

Bryan Whitehead <Bryan.Whitehead@microchip.com>
    lan743x: Expand phy search for LAN7431

Anssi Hannula <anssi.hannula@bitwise.fi>
    net: macb: add missing barriers when reading descriptors

Anssi Hannula <anssi.hannula@bitwise.fi>
    net: macb: fix dropped RX frames due to a race

Anssi Hannula <anssi.hannula@bitwise.fi>
    net: macb: fix random memory corruption on RX with 64-bit DMA

Dan Carpenter <dan.carpenter@oracle.com>
    qed: Fix an error code qed_ll2_start_xmit()

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix a race with XPRT_CONNECTING

Sara Sharon <sara.sharon@intel.com>
    mac80211: fix a kernel panic when TXing after TXQ teardown

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

Atul Gupta <atul.gupta@chelsio.com>
    net/tls: Init routines in create_ctx

Nathan Chancellor <natechancellor@gmail.com>
    drivers: net: xgene: Remove unnecessary forward declarations

Sinan Kaya <okaya@kernel.org>
    x86, hyperv: remove PCI dependency

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mt76: fix potential NULL pointer dereference in mt76_stop_tx_queues

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

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_conncount: use rb_link_node_rcu() instead of rb_link_node()

Florian Westphal <fw@strlen.de>
    netfilter: nat: can't use dst_hold on noref dst

Pan Bian <bianpan2016@163.com>
    netfilter: ipset: do not call ipset_nest_end after nla_nest_cancel

Ross Lagerwall <ross.lagerwall@citrix.com>
    ixgbe: Fix race when the VF driver does a reset

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

Thomas Falcon <tlfalcon@linux.ibm.com>
    ibmvnic: Convert reset work item mutex to spin lock

Yussuf Khalil <dev@pp3345.net>
    Input: synaptics - enable RMI on ThinkPad T560

Tony Lindgren <tony@atomide.com>
    Input: omap-keypad - fix idle configuration to not block SoC idle states

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: bnx2fc: Fix NULL dereference in error handling

Himanshu Madhani <hmadhani@marvell.com>
    Revert "scsi: qla2xxx: Fix NVMe Target discovery"

Florian Westphal <fw@strlen.de>
    netfilter: seqadj: re-load tcp header pointer after possible head reallocation

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: fix suspicious RCU usage in nft_chain_stats_replace()

Alexander Aring <aring@mojatatu.com>
    ieee802154: hwsim: fix off-by-one in parse nested

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix NULL pointer dereference in xfrm_input when skb_dst_force clears the dst_entry.

Benjamin Poirier <bpoirier@suse.com>
    xfrm: Fix bucket count reported to userspace

Wei Yongjun <weiyongjun1@huawei.com>
    xfrm: Fix error return code in xfrm_output_one()

Qian Cai <cai@lca.pw>
    checkstack.pl: fix for aarch64

Mark Zhang <markz@mellanox.com>
    IB/core: Fix oops in netdev_next_upper_dev_rcu()

Andrey Grodzovsky <andrey.grodzovsky@amd.com>
    drm/amdgpu: Fix DEBUG_LOCKS_WARN_ON(depth <= 0) in amdgpu_ctx.lock

Oliver O'Halloran <oohall@gmail.com>
    powerpc/mm: Fallback to RAM if the altmap is unusable

Peter Hutterer <peter.hutterer@who-t.net>
    Input: restore EV_ABS ABS_RESERVED

Yishai Hadas <yishaih@mellanox.com>
    IB/mlx5: Block DEVX umem from the non applicable cases

Fabio Estevam <festevam@gmail.com>
    ARM: dts: imx7d-nitrogen7: Fix the description of the Wifi clock

Anson Huang <anson.huang@nxp.com>
    ARM: imx: update the cpu power up timing setting on i.mx6sx

Fabio Estevam <festevam@gmail.com>
    ARM: dts: imx7d-pico: Describe the Wifi clock

Hans de Goede <hdegoede@redhat.com>
    HID: ite: Add USB id match for another ITE based keyboard rfkill key quirk

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix linux page tables build with some configs

Paul Mackerras <paulus@ozlabs.org>
    powerpc: Fix COFF zImage booting on old powermacs

Ryder Lee <ryder.lee@mediatek.com>
    arm64: dts: mt7622: fix no more console output on rfb1

Jerome Brunet <jbrunet@baylibre.com>
    pinctrl: meson: fix pull enable register calculation

Corentin Labbe <clabbe@baylibre.com>
    ARM: dts: sun8i: a83t: bananapi-m3: increase vcc-pd voltage to 3.3V


-------------

Diffstat:

 Makefile                                           |  31 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |   9 +-
 arch/arm/boot/dts/imx7d-pico.dtsi                  |  22 +-
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts       |   4 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |   2 +-
 arch/arm64/Makefile                                |   2 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts       |   7 +-
 arch/arm64/kernel/image.h                          |  46 +-
 arch/arm64/kernel/vmlinux.lds.S                    |   9 +-
 arch/m68k/kernel/setup_mm.c                        |   2 -
 arch/m68k/mm/motorola.c                            |   2 +
 arch/powerpc/Makefile                              |  47 +-
 arch/powerpc/boot/Makefile                         |   5 +
 arch/powerpc/boot/crt0.S                           |   4 +-
 arch/powerpc/kernel/Makefile                       |  11 +-
 arch/powerpc/kernel/signal_32.c                    |  38 +-
 arch/powerpc/kernel/signal_64.c                    |  64 +--
 arch/powerpc/kernel/trace/Makefile                 |   2 +-
 arch/powerpc/mm/dump_linuxpagetables.c             |   1 +
 arch/powerpc/mm/init_64.c                          |  19 +-
 arch/powerpc/platforms/powermac/Makefile           |   2 +-
 arch/powerpc/xmon/Makefile                         |   7 +-
 arch/x86/include/asm/pgtable_64_types.h            |   5 +
 arch/x86/mm/dump_pagetables.c                      |  15 +-
 arch/x86/xen/mmu_pv.c                              |  11 +-
 block/blk-mq-sched.c                               |   3 +-
 block/blk-mq-sched.h                               |   1 +
 block/blk-stat.h                                   |   5 +
 block/blk-wbt.c                                    |   4 +-
 block/mq-deadline.c                                |  12 +-
 drivers/auxdisplay/charlcd.c                       |   3 +
 drivers/base/dd.c                                  |   4 +-
 drivers/block/zram/zram_drv.c                      |   4 +-
 drivers/dax/pmem.c                                 |  14 +-
 drivers/gpio/gpio-mvebu.c                          |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   4 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  12 +-
 drivers/gpu/drm/rockchip/rockchip_drm_psr.c        |   4 +-
 drivers/gpu/drm/vc4/vc4_plane.c                    |   1 +
 drivers/hid/hid-ids.h                              |   3 +
 drivers/hid/hid-ite.c                              |   1 +
 drivers/hv/Kconfig                                 |   2 +-
 drivers/hwtracing/intel_th/msu.c                   |   3 +-
 drivers/iio/dac/ad5686.c                           |   3 +-
 drivers/infiniband/core/roce_gid_mgmt.c            |   3 +
 drivers/infiniband/hw/mlx5/devx.c                  |   4 +-
 drivers/infiniband/sw/rxe/rxe_resp.c               |  13 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |  18 +-
 drivers/input/keyboard/omap4-keypad.c              |  16 +-
 drivers/input/mouse/synaptics.c                    |   2 +
 drivers/iommu/intel-iommu.c                        |   4 +-
 drivers/leds/leds-pwm.c                            |   5 +-
 drivers/media/pci/cx23885/cx23885-core.c           |  55 ++-
 drivers/media/pci/cx23885/cx23885.h                |   2 +
 drivers/misc/genwqe/card_utils.c                   |   2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c   |   3 -
 drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        |   1 +
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   |  48 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.h     |   4 +-
 drivers/net/ethernet/cadence/macb_main.c           |  27 +-
 drivers/net/ethernet/cadence/macb_ptp.c            |   2 +
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  |   3 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c |  14 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  |  15 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 503 ++++++++++++++-------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  13 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      |  43 +-
 drivers/net/ethernet/ibm/ibmvnic.c                 |  18 +-
 drivers/net/ethernet/ibm/ibmvnic.h                 |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |  14 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |  11 +-
 drivers/net/ethernet/microchip/lan743x_main.c      |  11 +-
 drivers/net/ethernet/neterion/vxge/vxge-config.c   |   2 +-
 drivers/net/ethernet/nuvoton/w90p910_ether.c       |   2 +-
 .../net/ethernet/qlogic/netxen/netxen_nic_init.c   |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c          |   1 +
 drivers/net/ieee802154/ca8210.c                    |   4 +-
 drivers/net/ieee802154/mac802154_hwsim.c           |   4 +-
 drivers/net/usb/lan78xx.c                          |   4 +
 drivers/net/usb/qmi_wwan.c                         |  15 +-
 drivers/net/wireless/broadcom/b43/phy_common.c     |   2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/init.c   |   1 +
 drivers/net/wireless/mediatek/mt76/tx.c            |   7 +-
 drivers/nvdimm/pmem.c                              |  13 +-
 drivers/of/base.c                                  | 101 ++++-
 drivers/of/dynamic.c                               |   3 +
 drivers/of/of_private.h                            |   4 +
 drivers/pci/pci-driver.c                           |  27 +-
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c      |   4 +-
 drivers/pinctrl/meson/pinctrl-meson.c              |   3 +-
 drivers/power/supply/olpc_battery.c                |   4 +-
 drivers/s390/scsi/zfcp_aux.c                       |   6 +-
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c                  |   2 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   3 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   4 +-
 drivers/target/iscsi/cxgbit/cxgbit_cm.c            |   5 +-
 drivers/target/iscsi/cxgbit/cxgbit_main.c          |   1 +
 drivers/tty/serial/sunsu.c                         |  31 +-
 drivers/video/fbdev/pxafb.c                        |   4 +-
 fs/ceph/caps.c                                     |   1 -
 fs/dlm/lock.c                                      |  17 +-
 fs/dlm/lockspace.c                                 |   2 +-
 fs/gfs2/inode.c                                    |  18 +-
 fs/gfs2/rgrp.c                                     |   2 +-
 fs/lockd/clntproc.c                                |   2 +-
 fs/lockd/xdr.c                                     |   4 +-
 fs/lockd/xdr4.c                                    |   4 +-
 fs/nfsd/nfs4proc.c                                 |   2 -
 include/linux/hmm.h                                |   4 +-
 include/linux/memremap.h                           |   2 +
 include/linux/netfilter/nfnetlink.h                |  12 -
 include/uapi/linux/input-event-codes.h             |   9 +
 kernel/dma/direct.c                                |  13 +-
 kernel/fork.c                                      |  13 +-
 kernel/memremap.c                                  |  95 ++--
 kernel/pid.c                                       |   6 +-
 kernel/rcu/srcutree.c                              |   2 +
 kernel/sched/fair.c                                |  43 +-
 lib/raid6/Makefile                                 |  15 +
 lib/test_debug_virtual.c                           |   1 +
 mm/hmm.c                                           | 131 ++----
 mm/memcontrol.c                                    |  20 +-
 mm/memory_hotplug.c                                |  16 +
 mm/swapfile.c                                      |   3 +-
 net/9p/client.c                                    |  21 +
 net/mac80211/iface.c                               |   3 +
 net/mac80211/main.c                                |   2 -
 net/mac80211/status.c                              |   5 +
 net/netfilter/ipset/ip_set_list_set.c              |   2 +-
 net/netfilter/nf_conncount.c                       |   2 +-
 net/netfilter/nf_conntrack_seqadj.c                |   7 +-
 net/netfilter/nf_nat_core.c                        |   3 +-
 net/netfilter/nf_tables_api.c                      |  21 +-
 net/netfilter/nf_tables_core.c                     |   2 +-
 net/sunrpc/auth_gss/svcauth_gss.c                  |   8 +-
 net/sunrpc/cache.c                                 |  10 +-
 net/sunrpc/xprtsock.c                              |   4 +-
 net/tls/tls_main.c                                 |   6 +-
 net/wireless/nl80211.c                             |   4 +-
 net/xfrm/xfrm_input.c                              |   7 +-
 net/xfrm/xfrm_output.c                             |   1 +
 net/xfrm/xfrm_state.c                              |   2 +-
 scripts/checkstack.pl                              |   4 +-
 security/selinux/ss/policydb.c                     |  51 ++-
 sound/pci/cs46xx/dsp_spos.c                        |   3 +
 sound/usb/card.c                                   |   2 +-
 sound/usb/mixer.c                                  |  29 +-
 sound/usb/quirks-table.h                           |   6 +
 sound/usb/stream.c                                 |  36 +-
 tools/testing/nvdimm/test/iomap.c                  |  17 +-
 tools/virtio/linux/kernel.h                        |   4 +
 152 files changed, 1458 insertions(+), 815 deletions(-)


