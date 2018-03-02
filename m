Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625397-1519997144-2-11948032771465917953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519997142; b=AwSVFtFW5pjazx2y1FKq/g0K7HvlrevdCdHro6aMYG9DgAL
    ParCkxGcYvy6bThXeowOqhvfSleI0DESGrDMEjhg58wLZtOYo3wX69Yucxo0lSt+
    uUhPJT7/wQ5/+HnphE3Il/ThSbuTFbIaKfw3DB8l33BbiS1TcRJoJnM2ofVtigZn
    Ev6LbO8gpK/vI4rH6wel6N3uxxnR9KI4ja9SZVwYlJi10ZFR3EojyDg5ZhLINj2E
    V54AzaI/wtoxLi07FbnUD9n5r+8VuEY8y2D6rGtQXjbkIzsU4Ae8tIRXf64NmRfD
    zH2g9GV+iD5pGdC7vzKyokxZsguCFHkjbSqingg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519997142; bh=E74/zDSGlo73ZymZCd4s759tk/r0SEZLBYw3lq219hg=; b=Z
    CRwk8CbGH2yOZe/tT+Bd8LvqlMJTcDm2KtH1T06Vsvnm+mhZAfBLud2YNMjiRN/x
    JBLUtlYNnbBvbEUsZb28MRTNGTU2VK/1ZQBe0NNrCF/dUKRTl3vJVPak55lPnR7Q
    ArgoFaxdOjrJeUbP2Ih5IhrD/qENVPF97ZIz54jkdZOgnO1cIUC1jAFpAjqNsPUX
    kCv6mItW+v4N3c7JiCBvYgPkpRH+eUZBV21EMj1Xhui4z4wYm0vhdxEeBXyGGekY
    UBJyCzqxnvZwJf9qjpnoha+7HvMVYiGAgFisgvna9iNX0caLc/sQAe5LHi3fUhAW
    eKMGA2iaEEAU/XfoWuw9Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=pWtxQBuE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=pWtxQBuE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=pass (p=quarantine,has-list-id=yes,d=none) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428123AbeCBNZj (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 08:25:39 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:62314 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425249AbeCBNZf (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 08:25:35 -0500
Subject: Re: [PATCH 4.14 000/115] 4.14.24-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC: <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuahkh@osg.samsung.com>,
        <patches@kernelci.org>, <ben.hutchings@codethink.co.uk>,
        <lkft-triage@lists.linaro.org>, <stable@vger.kernel.org>
References: <20180302084503.856536800@linuxfoundation.org>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <735255b8-7ba8-e94e-8dc6-c739275b58e5@ti.com>
Date: Fri, 2 Mar 2018 07:24:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Greg

On 03/02/2018 02:50 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.24 release.
> There are 115 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 

It seems we missed the patch.  It was supposed to be queued up for 4.14.24.

 ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds
    
    [ commit 863204cfdae98626a92535ac928ad79f4d6b74ff upstream ]


Dan

> Responses should be made by Sun Mar  4 08:44:32 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.24-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.14.24-rc1
> 
> Jiri Pirko <jiri@mellanox.com>
>     net: sched: fix use-after-free in tcf_block_put_ext
> 
> Cong Wang <xiyou.wangcong@gmail.com>
>     net_sched: get rid of rcu_barrier() in tcf_block_put_ext()
> 
> Roman Kapl <code@rkapl.cz>
>     net: sched: crash on blocks with goto chain action
> 
> Roman Kapl <code@rkapl.cz>
>     net: sched: fix crash when deleting secondary chains
> 
> Antoine Tenart <antoine.tenart@free-electrons.com>
>     arm64: dts: marvell: mcbin: add comphy references to Ethernet ports
> 
> Antoine Tenart <antoine.tenart@free-electrons.com>
>     arm64: dts: marvell: add comphy nodes on cp110 master and slave
> 
> Sam Bobroff <sam.bobroff@au1.ibm.com>
>     powerpc/pseries: Enable RAS hotplug events later
> 
> James Hogan <jhogan@kernel.org>
>     MIPS: Implement __multi3 for GCC7 MIPS64r6 builds
> 
> Yuval Mintz <yuvalm@mellanox.com>
>     mlxsw: pci: Wait after reset before accessing HW
> 
> Jakub Kicinski <jakub.kicinski@netronome.com>
>     nfp: always unmask aux interrupts at init
> 
> Madalin Bucur <madalin.bucur@nxp.com>
>     of_mdio: avoid MDIO bus removal when a PHY is missing
> 
> Yangbo Lu <yangbo.lu@nxp.com>
>     net: gianfar_ptp: move set_fipers() to spinlock protecting area
> 
> Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>     sctp: make use of pre-calculated len
> 
> Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
>     sctp: add a ceiling to optlen in some sockopts
> 
> Ross Lagerwall <ross.lagerwall@citrix.com>
>     xen/gntdev: Fix partial gntdev_mmap() cleanup
> 
> Ross Lagerwall <ross.lagerwall@citrix.com>
>     xen/gntdev: Fix off-by-one error when unmapping with holes
> 
> Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>     SolutionEngine771x: fix Ether platform data
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     mdio-sun4i: Fix a memory leak
> 
> Eduardo Otubo <otubo@redhat.com>
>     xen-netfront: enable device after manual module load
> 
> Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
>     bnxt_en: Fix the 'Invalid VF' id check in bnxt_vf_ndo_prep routine.
> 
> Sunil Challa <sunilkumar.challa@broadcom.com>
>     bnxt_en: Fix population of flow_type in bnxt_hwrm_cfa_flow_alloc()
> 
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     x86/platform/intel-mid: Revert "Make 'bt_sfi_data' const"
> 
> Ewan D. Milne <emilne@redhat.com>
>     nvme-fabrics: initialize default host->id in nvmf_host_default()
> 
> Michael Ellerman <mpe@ellerman.id.au>
>     powerpc/pseries: Make RAS IRQ explicitly dependent on DLPAR WQ
> 
> Jacek Anaszewski <jacek.anaszewski@gmail.com>
>     leds: core: Fix regression caused by commit 2b83ff96f51d
> 
> John Fastabend <john.fastabend@gmail.com>
>     bpf: sockmap missing NULL psock check
> 
> Valentin Ilie <valentin.ilie@gmail.com>
>     ia64, sched/cputime: Fix build error if CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
> 
> Ming Lei <ming.lei@redhat.com>
>     block: drain queue before waiting for q_usage_counter becoming zero
> 
> Loic Poulain <loic.poulain@linaro.org>
>     wcn36xx: Fix dynamic power saving
> 
> Luu An Phu <phu.luuan@nxp.com>
>     can: flex_can: Correct the checking for frame length in flexcan_start_xmit()
> 
> Johannes Berg <johannes.berg@intel.com>
>     mac80211: mesh: drop frames appearing to be from us
> 
> Hao Chen <flank3rsky@gmail.com>
>     nl80211: Check for the required netlink attribute presence
> 
> Netanel Belgazal <netanel@amazon.com>
>     net: ena: unmask MSI-X only after device initialization is completed
> 
> Jacob Keller <jacob.e.keller@intel.com>
>     i40e: don't remove netdev->dev_addr when syncing uc list
> 
> Alexander Duyck <alexander.h.duyck@intel.com>
>     i40e/i40evf: Account for frags split over multiple descriptors in check linearize
> 
> Felix Janda <felix.janda@posteo.de>
>     uapi libc compat: add fallback for unsupported libcs
> 
> Dave Young <dyoung@redhat.com>
>     x86/efi: Fix kernel param add_efi_memmap regression
> 
> Leon Romanovsky <leonro@mellanox.com>
>     RDMA/netlink: Fix locking around __ib_get_device_by_index
> 
> Xiongwei Song <sxwjean@gmail.com>
>     drm/ttm: check the return value of kzalloc
> 
> SZ Lin (林上智) <sz.lin@moxa.com>
>     NET: usb: qmi_wwan: add support for YUGA CLM920-NC5 PID 0x9625
> 
> Tushar Dave <tushar.n.dave@oracle.com>
>     e1000: fix disabling already-disabled warning
> 
> Gao Feng <gfree.wind@vip.163.com>
>     macvlan: Fix one possible double free
> 
> Aliaksei Karaliou <akaraliou.dev@gmail.com>
>     xfs: quota: check result of register_shrinker()
> 
> Aliaksei Karaliou <akaraliou.dev@gmail.com>
>     xfs: quota: fix missed destroy of qi_tree_lock
> 
> Erez Shitrit <erezsh@mellanox.com>
>     IB/ipoib: Fix race condition in neigh creation
> 
> Leon Romanovsky <leonro@mellanox.com>
>     IB/mlx4: Fix mlx4_ib_alloc_mr error flow
> 
> Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>     Input: xen-kbdfront - do not advertise multi-touch pressure support
> 
> Xin Long <lucien.xin@gmail.com>
>     ip6_tunnel: allow ip6gre dev mtu to be set below 1280
> 
> Nikolay Borisov <nborisov@suse.com>
>     btrfs: Fix flush bio leak
> 
> Stefan Haberland <sth@linux.vnet.ibm.com>
>     s390/dasd: fix wrongly assigned configuration data
> 
> David Howells <dhowells@redhat.com>
>     afs: Fix missing error handling in afs_write_end()
> 
> Guenter Roeck <linux@roeck-us.net>
>     genirq: Guard handle_bad_irq log messages
> 
> Nitzan Carmi <nitzanc@mellanox.com>
>     IB/mlx5: Fix mlx5_ib_alloc_mr error flow
> 
> Matthieu CASTET <matthieu.castet@parrot.com>
>     led: core: Fix brightness setting when setting delay_off=0
> 
> Thomas Gleixner <tglx@linutronix.de>
>     perf/x86/intel: Plug memory leak in intel_pmu_init()
> 
> Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>     bnx2x: Improve reliability in case of nested PCI errors
> 
> Siva Reddy Kallam <siva.kallam@broadcom.com>
>     tg3: Enable PHY reset in MTU change path for 5720
> 
> Siva Reddy Kallam <siva.kallam@broadcom.com>
>     tg3: Add workaround to restrict 5762 MRRS to 2048
> 
> Tommi Rantala <tommi.t.rantala@nokia.com>
>     tipc: fix tipc_mon_delete() oops in tipc_enable_bearer() error path
> 
> Tommi Rantala <tommi.t.rantala@nokia.com>
>     tipc: error path leak fixes in tipc_enable_bearer()
> 
> Hangbin Liu <liuhangbin@gmail.com>
>     netfilter: nf_tables: fix potential NULL-ptr deref in nf_tables_dump_obj_done()
> 
> Antoine Tenart <antoine.tenart@free-electrons.com>
>     crypto: inside-secure - fix request allocations in invalidation path
> 
> Antoine Tenart <antoine.tenart@free-electrons.com>
>     crypto: inside-secure - free requests even if their handling failed
> 
> Ofer Heifetz <oferh@marvell.com>
>     crypto: inside-secure - per request invalidation
> 
> Bogdan Mirea <Bogdan-Stefan_Mirea@mentor.com>
>     arm64: dts: renesas: ulcb: Remove renesas, no-ether-link property
> 
> James Hogan <jhogan@kernel.org>
>     lib/mpi: Fix umul_ppmm() for MIPS64r6
> 
> Jonathan Cameron <Jonathan.Cameron@huawei.com>
>     crypto: af_alg - Fix race around ctx->rcvused by making it atomic_t
> 
> Arnd Bergmann <arnd@arndb.de>
>     ARM: dts: ls1021a: fix incorrect clock references
> 
> Bryan Tan <bryantan@vmware.com>
>     RDMA/vmw_pvrdma: Call ib_umem_release on destroy QP path
> 
> Gabriel Krisman Bertazi <krisman@collabora.co.uk>
>     i915: Reject CCS modifiers for pipe C on Geminilake
> 
> Florian Westphal <fw@strlen.de>
>     netfilter: uapi: correct UNTRACKED conntrack state bit number
> 
> Cathy Avery <cavery@redhat.com>
>     scsi: storvsc: Fix scsi_cmd error assignments in storvsc_handle_error
> 
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: fix chain filter in nf_tables_dump_rules()
> 
> Boris Ostrovsky <boris.ostrovsky@oracle.com>
>     xen/balloon: Mark unallocated host memory as UNUSABLE
> 
> Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>     ASoC: rsnd: fixup ADG register mask
> 
> Moshe Shemesh <moshe@mellanox.com>
>     net/mlx5: Stay in polling mode when command EQ destroy fails
> 
> Moshe Shemesh <moshe@mellanox.com>
>     net/mlx5: Cleanup IRQs in case of unload failure
> 
> Huy Nguyen <huyn@mellanox.com>
>     net/mlx5e: Fix ETS BW check
> 
> Fredrik Hallenberg <megahallon@gmail.com>
>     net: stmmac: Fix bad RX timestamp extraction
> 
> Fredrik Hallenberg <megahallon@gmail.com>
>     net: stmmac: Fix TX timestamp calculation
> 
> Xin Long <lucien.xin@gmail.com>
>     ip6_tunnel: get the min mtu properly in ip6_tnl_xmit
> 
> Xin Long <lucien.xin@gmail.com>
>     ip6_gre: remove the incorrect mtu limit for ipgre tap
> 
> Xin Long <lucien.xin@gmail.com>
>     ip_gre: remove the incorrect mtu limit for ipgre tap
> 
> Xin Long <lucien.xin@gmail.com>
>     vxlan: update skb dst pmtu on tx path
> 
> Alexander Kochetkov <al.kochet@gmail.com>
>     net: arc_emac: fix arc_emac_rx() error paths
> 
> Sean Wang <sean.wang@mediatek.com>
>     net: mediatek: setup proper state for disabled GMAC on the default
> 
> Jan Beulich <JBeulich@suse.com>
>     x86-64/Xen: eliminate W+X mappings
> 
> John Stultz <john.stultz@linaro.org>
>     staging: ion: Fix ion_cma_heap allocations
> 
> Prateek Sood <prsood@codeaurora.org>
>     cgroup: Fix deadlock in cpu hotplug path
> 
> Abhijeet Kumar <abhijeet.kumar@intel.com>
>     ASoC: nau8825: fix issue that pop noise when start capture
> 
> Radu Pirea <radu.pirea@microchip.com>
>     spi: atmel: fixed spin_lock usage inside atmel_spi_remove
> 
> Jia-Ju Bai <baijiaju1990@163.com>
>     mac80211_hwsim: Fix a possible sleep-in-atomic bug in hwsim_get_radio_nl
> 
> Josh Poimboeuf <jpoimboe@redhat.com>
>     x86/stacktrace: Make zombie stack traces reliable
> 
> Herbert Xu <herbert@gondor.apana.org.au>
>     xfrm: Reinject transport-mode packets through tasklet
> 
> Karol Herbst <kherbst@redhat.com>
>     drm/nouveau/pci: do a msi rearm on init
> 
> Alexey Khoroshilov <khoroshilov@ispras.ru>
>     net: phy: xgene: disable clk on error paths
> 
> Al Viro <viro@zeniv.linux.org.uk>
>     sget(): handle failures of register_shrinker()
> 
> Xin Long <lucien.xin@gmail.com>
>     sctp: fix the issue that a __u16 variable may overflow in sctp_ulpq_renege
> 
> Arnaldo Carvalho de Melo <acme@redhat.com>
>     x86/asm: Allow again using asm.h when building for the 'bpf' clang target
> 
> Chunyan Zhang <zhang.lyra@gmail.com>
>     ARM: 8731/1: Fix csum_partial_copy_from_user() stack mismatch
> 
> John David Anglin <dave.anglin@bell.net>
>     parisc: Reduce thread stack to 16 kb
> 
> Brendan McGrath <redmcg@redmandi.dyndns.org>
>     ipv6: icmp6: Allow icmp messages to be looped back
> 
> Albert Hsieh <wen.hsieh@broadcom.com>
>     mtd: nand: brcmnand: Zero bitflip is not an error
> 
> Sascha Hauer <s.hauer@pengutronix.de>
>     mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM
> 
> Daniele Palmas <dnlplm@gmail.com>
>     net: usb: qmi_wwan: add Telit ME910 PID 0x1101 support
> 
> Igor Russkikh <igor.russkikh@aquantia.com>
>     net: aquantia: Fix hardware DMA stream overload on large MRRS
> 
> Igor Russkikh <igor.russkikh@aquantia.com>
>     net: aquantia: Fix actual speed capabilities reporting
> 
> Keith Busch <keith.busch@intel.com>
>     nvme: check hw sectors before setting chunk sectors
> 
> James Smart <jsmart2021@gmail.com>
>     nvme-fc: remove double put reference if admin connect fails
> 
> Arvind Yadav <arvind.yadav.cs@gmail.com>
>     phy: cpcap-usb: Fix platform_get_irq_byname's error checking.
> 
> Andreas Platschek <andreas.platschek@opentech.at>
>     dmaengine: fsl-edma: disable clks on all error paths
> 
> Prasad B Munirathnam <prasad.munirathnam@microsemi.com>
>     scsi: aacraid: Fix I/O drop during reset
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     mm/frame_vector.c: release a semaphore in 'get_vaddr_frames()'
> 
> Arnd Bergmann <arnd@arndb.de>
>     exec: avoid gcc-8 warning for get_task_comm
> 
> Anna-Maria Gleixner <anna-maria@linutronix.de>
>     hrtimer: Ensure POSIX compliance (relative CLOCK_REALTIME hrtimers)
> 
> 
> -------------
> 
> Diffstat:
> 
>  Makefile                                           |  4 +-
>  arch/arm/boot/dts/ls1021a-qds.dts                  |  2 +-
>  arch/arm/boot/dts/ls1021a-twr.dts                  |  2 +-
>  arch/arm/lib/csumpartialcopyuser.S                 |  4 +
>  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts  |  9 +++
>  .../boot/dts/marvell/armada-cp110-master.dtsi      | 38 ++++++++++
>  .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi | 38 ++++++++++
>  arch/arm64/boot/dts/renesas/ulcb.dtsi              |  1 -
>  arch/ia64/kernel/time.c                            |  2 +-
>  arch/mips/lib/Makefile                             |  3 +-
>  arch/mips/lib/libgcc.h                             | 17 +++++
>  arch/mips/lib/multi3.c                             | 54 ++++++++++++++
>  arch/parisc/include/asm/thread_info.h              |  5 ++
>  arch/powerpc/platforms/pseries/dlpar.c             | 21 +++++-
>  arch/powerpc/platforms/pseries/pseries.h           |  2 +
>  arch/powerpc/platforms/pseries/ras.c               | 30 ++++++--
>  arch/sh/boards/mach-se/770x/setup.c                | 10 ++-
>  arch/x86/events/intel/core.c                       |  5 +-
>  arch/x86/include/asm/asm.h                         |  2 +
>  arch/x86/kernel/setup.c                            |  5 +-
>  arch/x86/kernel/stacktrace.c                       |  6 +-
>  .../platform/intel-mid/device_libs/platform_bt.c   |  2 +-
>  arch/x86/xen/enlighten.c                           | 81 +++++++++++++++++++++
>  arch/x86/xen/enlighten_pv.c                        |  3 +
>  arch/x86/xen/mmu_pv.c                              | 12 +++
>  arch/x86/xen/setup.c                               |  6 +-
>  block/blk-core.c                                   |  9 ++-
>  block/blk-mq.c                                     |  2 +
>  block/blk.h                                        |  2 +
>  crypto/af_alg.c                                    |  4 +-
>  crypto/algif_aead.c                                |  2 +-
>  crypto/algif_skcipher.c                            |  2 +-
>  drivers/crypto/inside-secure/safexcel.c            |  1 +
>  drivers/crypto/inside-secure/safexcel_cipher.c     | 85 +++++++++++++++++-----
>  drivers/crypto/inside-secure/safexcel_hash.c       | 79 +++++++++++++++-----
>  drivers/dma/fsl-edma.c                             | 28 +++----
>  drivers/gpu/drm/i915/intel_display.c               |  2 +-
>  drivers/gpu/drm/nouveau/nvkm/subdev/pci/base.c     |  7 ++
>  drivers/gpu/drm/ttm/ttm_page_alloc.c               |  2 +
>  drivers/infiniband/core/core_priv.h                |  2 +-
>  drivers/infiniband/core/device.c                   | 18 ++++-
>  drivers/infiniband/core/nldev.c                    | 54 +++++++++-----
>  drivers/infiniband/hw/mlx4/mr.c                    |  2 +-
>  drivers/infiniband/hw/mlx5/mr.c                    |  1 +
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c       |  7 ++
>  drivers/infiniband/ulp/ipoib/ipoib_main.c          | 25 +++++--
>  drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |  5 +-
>  drivers/input/misc/xen-kbdfront.c                  |  2 -
>  drivers/leds/led-core.c                            |  1 +
>  drivers/mtd/nand/brcmnand/brcmnand.c               |  2 +-
>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c             |  6 +-
>  drivers/net/can/flexcan.c                          |  2 +-
>  drivers/net/ethernet/amazon/ena/ena_netdev.c       | 26 +++----
>  drivers/net/ethernet/aquantia/atlantic/aq_hw.h     |  4 +-
>  drivers/net/ethernet/aquantia/atlantic/aq_nic.c    |  7 +-
>  drivers/net/ethernet/aquantia/atlantic/aq_nic.h    |  2 +-
>  .../net/ethernet/aquantia/atlantic/aq_pci_func.c   |  5 +-
>  .../ethernet/aquantia/atlantic/hw_atl/hw_atl_a0.c  | 13 +++-
>  .../ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c  | 25 ++++++-
>  .../aquantia/atlantic/hw_atl/hw_atl_llh_internal.h |  6 ++
>  drivers/net/ethernet/arc/emac_main.c               | 53 ++++++++------
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c    |  4 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_main.c   | 14 +++-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c    |  2 +-
>  drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c       |  2 +-
>  drivers/net/ethernet/broadcom/tg3.c                | 13 +++-
>  drivers/net/ethernet/broadcom/tg3.h                |  4 +
>  drivers/net/ethernet/freescale/gianfar_ptp.c       |  3 +-
>  drivers/net/ethernet/intel/e1000/e1000.h           |  3 +-
>  drivers/net/ethernet/intel/e1000/e1000_main.c      | 27 +++++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 17 ++++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 26 ++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 26 ++++++-
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c        | 11 +--
>  drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 10 ++-
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c       | 18 +++--
>  drivers/net/ethernet/mellanox/mlxsw/pci.c          |  7 +-
>  drivers/net/ethernet/mellanox/mlxsw/pci_hw.h       |  1 +
>  .../net/ethernet/netronome/nfp/nfp_net_common.c    |  2 +
>  drivers/net/ethernet/stmicro/stmmac/common.h       |  2 +-
>  drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c |  5 +-
>  drivers/net/ethernet/stmicro/stmmac/enh_desc.c     |  3 +-
>  drivers/net/ethernet/stmicro/stmmac/norm_desc.c    |  2 +-
>  .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  |  6 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  2 +-
>  drivers/net/macvlan.c                              |  7 +-
>  drivers/net/phy/mdio-sun4i.c                       |  6 +-
>  drivers/net/phy/mdio-xgene.c                       | 21 ++++--
>  drivers/net/usb/qmi_wwan.c                         |  2 +
>  drivers/net/vxlan.c                                | 14 ++++
>  drivers/net/wireless/ath/wcn36xx/main.c            | 23 +++---
>  drivers/net/wireless/ath/wcn36xx/pmc.c             |  6 +-
>  drivers/net/wireless/mac80211_hwsim.c              |  2 +-
>  drivers/net/xen-netfront.c                         |  1 +
>  drivers/nvme/host/core.c                           |  3 +-
>  drivers/nvme/host/fabrics.c                        |  1 +
>  drivers/nvme/host/fc.c                             |  1 -
>  drivers/of/of_mdio.c                               |  9 ++-
>  drivers/phy/motorola/phy-cpcap-usb.c               |  2 +-
>  drivers/s390/block/dasd_3990_erp.c                 | 10 +++
>  drivers/scsi/aacraid/aacraid.h                     |  1 +
>  drivers/scsi/aacraid/linit.c                       |  2 +-
>  drivers/scsi/storvsc_drv.c                         |  3 +-
>  drivers/spi/spi-atmel.c                            |  2 +-
>  drivers/staging/android/ion/Kconfig                |  2 +-
>  drivers/staging/android/ion/ion_cma_heap.c         | 15 +++-
>  drivers/xen/balloon.c                              | 65 ++++++++++++++---
>  drivers/xen/gntdev.c                               |  8 +-
>  fs/afs/write.c                                     |  8 +-
>  fs/btrfs/volumes.c                                 |  1 -
>  fs/exec.c                                          |  7 +-
>  fs/super.c                                         |  6 +-
>  fs/xfs/xfs_qm.c                                    | 46 ++++++++----
>  include/crypto/if_alg.h                            |  5 +-
>  include/linux/mlx5/driver.h                        |  2 +-
>  include/linux/sched.h                              |  6 +-
>  include/net/sch_generic.h                          |  1 -
>  include/net/xfrm.h                                 |  3 +
>  include/uapi/linux/libc-compat.h                   | 55 +++++++++++++-
>  include/uapi/linux/netfilter/nf_conntrack_common.h |  2 +-
>  include/xen/balloon.h                              |  5 ++
>  kernel/bpf/sockmap.c                               | 11 ++-
>  kernel/cgroup/cgroup-v1.c                          |  6 +-
>  kernel/irq/debug.h                                 |  5 ++
>  kernel/time/hrtimer.c                              |  7 +-
>  lib/mpi/longlong.h                                 | 18 ++++-
>  mm/frame_vector.c                                  |  6 +-
>  net/ipv4/ip_gre.c                                  |  1 +
>  net/ipv4/xfrm4_input.c                             | 12 ++-
>  net/ipv6/ip6_gre.c                                 |  1 +
>  net/ipv6/ip6_tunnel.c                              | 15 ++--
>  net/ipv6/route.c                                   |  1 +
>  net/ipv6/xfrm6_input.c                             | 10 ++-
>  net/mac80211/rx.c                                  |  2 +
>  net/netfilter/nf_tables_api.c                      |  8 +-
>  net/sched/cls_api.c                                | 48 ++++++------
>  net/sctp/socket.c                                  | 26 +++++--
>  net/sctp/ulpqueue.c                                | 24 ++----
>  net/tipc/bearer.c                                  |  5 +-
>  net/tipc/monitor.c                                 |  6 +-
>  net/wireless/nl80211.c                             |  3 +-
>  net/xfrm/xfrm_input.c                              | 57 +++++++++++++++
>  sound/soc/codecs/nau8825.c                         |  1 +
>  sound/soc/sh/rcar/adg.c                            |  6 +-
>  144 files changed, 1332 insertions(+), 367 deletions(-)
> 
> 


-- 
------------------
Dan Murphy
