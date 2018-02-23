Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414492-2-7754397850268281579
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414491; b=IVIUm9cmQNUBn36bgKfwXDRfDdjcs8xEP3r4fad+waeKj5u
    1xHpgX8So5ND6ZRRg4WRTBVnN3ulvDLHqb/SKKIzV6R96ZbyDDA9wIl2texUxkWA
    xnARwPU6AMVW2/fW8ASAmsMmghsUCSn54LOwYdOeRPNCwZpaNMu1SCyZG7+T3pB5
    Uygtp1swegFhN9Ro6yc55oKL75HFGS2CaK8ECn+q97LAoVUkd8wBiKVo2kiJ31et
    pBVtlfymIqPamUii+WLKsyN4FrWKzw9BlOHuGAwrMo4viR+mZSyfk2gPEL7vD4nT
    1ZIzBgogMIvmGsALGByQN6OfzLGmQ8xx5JYR2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519414491; bh=0nR0bBy5Q6LiA5VjszqLZhF7uw
    c57A6Jwu9odD95wgw=; b=B/HpqibBjnXJGg3Jak1UseX8sC2McxV/7R2CSxV2TJ
    upH7Yvzjmi+LU3+mH2bdY3mQ0nacNwGGtD3uSjHtMwlao4Wz56hSgn23u92kVdok
    W7uBxjyr7PUHmH1YMqYv0VgyqkKloMgyCJhNvksxdIKG/9Ewh7G8b/SKn4JNNFON
    BMmLFQGVb7uTOGa9tgBc4w+UDI8HIbeLBgYV6gsPtinYOhlOUpyMXyPUH+5zmful
    jVRfFT3x7kLQbW71uXWsq/HW69B9xE+zuyYKIdL7jSRAJnrMJcYIzvrYFwFykjvT
    VADEmUfxDr3ugrMDum3ZWiLpF5i4daCSiImCKwi1WfGA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754634AbeBWTed (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:34:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934313AbeBWSux (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:50:53 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/159] 4.14.22-stable review
Date: Fri, 23 Feb 2018 19:25:08 +0100
Message-Id: <20180223170743.086611315@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.22-rc1
X-KernelTest-Deadline: 2018-02-25T17:08+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.22 release.
There are 159 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb 25 17:06:38 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.22-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.22-rc1

Michal Hocko <mhocko@suse.com>
    vmalloc: fix __GFP_HIGHMEM usage for vmalloc_32 on 32b systems

Tomas Winkler <tomas.winkler@intel.com>
    mei: me: add cannon point device ids for 4th device

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add cannon point device ids

Kamil Konieczny <k.konieczny@partner.samsung.com>
    crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

Arnd Bergmann <arnd@arndb.de>
    drm/i915: fix intel_backlight_device_register declaration

LEROY Christophe <christophe.leroy@c-s.fr>
    crypto: talitos - fix Kernel Oops on hashing an empty file

Jia-Ju Bai <baijiaju1990@163.com>
    hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close

Anju T Sudhakar <anju@linux.vnet.ibm.com>
    powerpc/perf/imc: Fix nest-imc cpuhotplug callback failure

Geert Uytterhoeven <geert+renesas@glider.be>
    PCI: rcar: Fix use-after-free in probe error path

Jan Beulich <JBeulich@suse.com>
    xen: XEN_ACPI_PROCESSOR is Dom0-only

Pali Rohár <pali.rohar@gmail.com>
    platform/x86: dell-laptop: Fix keyboard max lighting for Dell Latitude E6410

Karol Herbst <kherbst@redhat.com>
    x86/mm/kmmio: Fix mmiotrace for page unaligned addresses

Dave Young <dyoung@redhat.com>
    mm/early_ioremap: Fix boot hang with earlyprintk=efi,keep

Andreas Platschek <andreas.platschek@opentech.at>
    usb: dwc3: of-simple: fix missing clk_disable_unprepare

Vincent Pelletier <plr.vincent@gmail.com>
    usb: dwc3: gadget: Wait longer for controller to end command processing

Tobias Jordan <Tobias.Jordan@elektrobit.com>
    dmaengine: jz4740: disable/unprepare clk if probe fails

Stefan Schake <stschake@gmail.com>
    drm/vc4: Release fence after signalling

Jiada Wang <jiada_wang@mentor.com>
    ASoC: rsnd: ssi: fix race condition in rsnd_ssi_pointer_update

Russell King <rmk+kernel@armlinux.org.uk>
    drm/armada: fix leak of crtc structure

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix stack-out-of-bounds with misconfigured transport mode policies.

Guy Levi <guyle@mellanox.com>
    IB/mlx4: Fix RSS hash fields restrictions

Takuo Koguchi <takuo.koguchi@gmail.com>
    spi: sun4i: disable clocks in the remove function

Stefan Potyra <Stefan.Potyra@elektrobit.com>
    ASoC: rockchip: disable clock on error

Dan Carpenter <dan.carpenter@oracle.com>
    staging: ccree: Uninitialized return in ssi_ahash_import()

Cai Li <cai.li@spreadtrum.com>
    clk: fix a panic error caused by accessing NULL pointer

Jann Horn <jannh@google.com>
    netfilter: xt_bpf: add overflow checks

Aviv Heller <avivh@mellanox.com>
    xfrm: Fix xfrm_input() to verify state is valid when (encap_type < 0)

Gustavo A. R. Silva <garsilva@embeddedor.com>
    dmaengine: at_hdmac: fix potential NULL pointer dereference in atc_prep_dma_interleaved

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: ioat: Fix error handling path

Arnd Bergmann <arnd@arndb.de>
    scsi: bfa: fix type conversion warning

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: bfa: fix access to bfad_im_port_s

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: lpfc: Use after free in lpfc_rq_buf_free()

Claudiu Manoil <claudiu.manoil@nxp.com>
    gianfar: Disable EEE autoneg by default

Eric Biggers <ebiggers3@gmail.com>
    509: fix printing uninitialized stack memory when OID is empty

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Unregister MDIO bus on error path

Andrew Lunn <andrew@lunn.ch>
    net: dsa: mv88e6xxx: Fix interrupt masking on removal

Branislav Radocaj <branislav@radocaj.org>
    net: ethernet: arc: fix error handling in emac_rockchip_probe

Yunjian Wang <wangyunjian@huawei.com>
    virtio_net: fix return value check in receive_mergeable()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    brcmfmac: Avoid build error with make W=1

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix possible off-by-one in btrfs_search_path_in_tree

Omar Sandoval <osandov@fb.com>
    Btrfs: disable FUA if mounted with nobarrier

Justin Maggard <jmaggard10@gmail.com>
    btrfs: Fix quota reservation leak on preallocated files

Peter Zijlstra <peterz@infradead.org>
    locking/lockdep: Fix possible NULL deref

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    net: qualcomm: rmnet: Fix leak on transmit failure

Jim Mattson <jmattson@google.com>
    KVM: VMX: fix page leak in hardware_setup()

Stefan Hajnoczi <stefanha@redhat.com>
    VSOCK: fix outdated sk_state value in hvs_release()

Nogah Frankel <nogahf@mellanox.com>
    net_sched: red: Avoid illegal values

Nogah Frankel <nogahf@mellanox.com>
    net_sched: red: Avoid devision by zero

Zumeng Chen <zumeng.chen@gmail.com>
    gianfar: fix a flooded alignment reports because of padding issue.

Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
    nfp: fix port stats for mac representors

Tony Lindgren <tony@atomide.com>
    ARM: dts: Fix elm interrupt compiler warning

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: prevent prefix I/O error

Michael S. Tsirkin <mst@redhat.com>
    s390/virtio: add BSD license to virtio-ccw

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM / runtime: Fix handling of suppliers with disabled runtime PM

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
    powerpc/perf: Fix oops when grouping different pmu events

Greg Ungerer <gerg@linux-m68k.org>
    m68k: add missing SOFTIRQENTRY_TEXT linker section

Gao Feng <gfree.wind@vip.163.com>
    ipvlan: Add the skb->mark as flow4's member to lookup route

Ray Jui <ray.jui@broadcom.com>
    bnxt_en: Need to unconditionally shut down RoCE in bnxt_shutdown

Will Deacon <will.deacon@arm.com>
    scripts/kernel-doc: Don't fail with status != 0 if error encountered with -none

Randy Dunlap <rdunlap@infradead.org>
    iio: fix kernel-doc build errors

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    iio: proximity: sx9500: Assign interrupt from GpioIo()

Shaohua Li <shli@fb.com>
    md/raid1/10: add missed blk plug

Russell King <rmk+kernel@armlinux.org.uk>
    phylink: ensure we take the link down when phylink_stop() is called

Russell King <rmk+kernel@armlinux.org.uk>
    sfp: fix RX_LOS signal handling

Xin Long <lucien.xin@gmail.com>
    sctp: only update outstanding_bytes for transmitted queue when doing prsctp_prune

bingjingc <bingjingc@synology.com>
    md/raid5: correct degraded calculation in raid5_error

Dmitry Monakhov <dmonakhov@openvz.org>
    IB/core: Init subsys if compiled to vmlinuz-core

Moni Shoua <monis@mellanox.com>
    RDMA/cma: Make sure that PSN is not over max allowed

Mustafa Ismail <mustafa.ismail@intel.com>
    i40iw: Correct ARP index mask

Mustafa Ismail <mustafa.ismail@intel.com>
    i40iw: Do not free sqbuf when event is I40IW_TIMER_TYPE_CLOSE

Chien Tin Tung <chien.tin.tung@intel.com>
    i40iw: Allocate a sdbuf per CQP WQE

Marc Zyngier <marc.zyngier@arm.com>
    KVM: arm/arm64: Fix spinlock acquisition in vgic_set_owner

Arnaud Patard <arnaud.patard@rtp-net.org>
    meson-gx-socinfo: Fix package id parsing

Dennis Dalessandro <dennis.dalessandro@intel.com>
    IB/hfi1: Initialize bth1 in 16B rc ack builder

Andre Przywara <andre.przywara@arm.com>
    pinctrl: sunxi: Fix A64 UART mux value

Andre Przywara <andre.przywara@arm.com>
    pinctrl: sunxi: Fix A80 interrupt pin bank

Keerthy <j-keerthy@ti.com>
    gpio: davinci: Assign first bank regs for unbanked case

Geert Uytterhoeven <geert+renesas@glider.be>
    gpio: 74x164: Fix crash during .remove()

Yan Markman <ymarkman@marvell.com>
    net: mvpp2: allocate zeroed tx descriptors

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: ov13858: Select V4L2_FWNODE

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: s5k6aa: describe some function parameters

Xie XiuQi <xiexiuqi@huawei.com>
    trace/xdp: fix compile warning: 'struct bpf_map' declared inside parameter list

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    kvm: arm: don't treat unavailable HYP mode as an error

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    pinctrl: denverton: Fix UART2 RTS pin mode

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf test: Fix test 21 for s390x

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
    perf bench numa: Fixup discontiguous/sparse numa nodes

Jiri Olsa <jolsa@kernel.org>
    perf top: Fix window dimensions change handling

Jiri Olsa <jolsa@kernel.org>
    perf: Fix header.size for namespace events

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf test shell: Fix check open filename arg using 'perf trace' on s390x

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
    perf annotate: Do not truncate instruction names at 6 chars

Namhyung Kim <namhyung@kernel.org>
    perf help: Fix a bug during strstart() conversion

Andi Kleen <ak@linux.intel.com>
    perf record: Fix -c/-F options for cpu event aliases

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: am437x-cm-t43: Correct the dmas property of spi0

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: am4372: Correct the interrupts_properties of McASP

Adam Ford <aford173@gmail.com>
    ARM: dts: logicpd-somlv: Fix wl127x pinmux

Adam Ford <aford173@gmail.com>
    ARM: dts: logicpd-som-lv: Fix gpmc addresses for NAND and enet

Tony Lindgren <tony@atomide.com>
    ARM: dts: Fix omap4 hang with GPS connected to USB by using wakeupgen

Keerthy <j-keerthy@ti.com>
    ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function

Tony Lindgren <tony@atomide.com>
    ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context

Johan Hovold <johan@kernel.org>
    serdev: fix receive_buf return value when no callback

Randy Dunlap <rdunlap@infradead.org>
    usb: build drivers/usb/common/ when USB_SUPPORT is set

Shuah Khan <shuah@kernel.org>
    usbip: keep usbip_device sockfd state in sync with tcp_socket

Alexandru Ardelean <alexandru.ardelean@analog.com>
    staging: iio: ad5933: switch buffer mode to software

Alexandru Ardelean <alexandru.ardelean@analog.com>
    staging: iio: adc: ad7192: fix external frequency setting

Arnd Bergmann <arnd@arndb.de>
    staging: fsl-mc: fix build testing on x86

Todd Kjos <tkjos@android.com>
    binder: replace "%p" with "%pK"

Eric Biggers <ebiggers@google.com>
    binder: check for binder_thread allocation failure in binder_poll()

Ben Hutchings <ben@decadent.org.uk>
    staging: android: ashmem: Fix a race condition in pin ioctls

Martijn Coenen <maco@android.com>
    ANDROID: binder: synchronize_rcu() when using POLLFREE.

Todd Kjos <tkjos@android.com>
    ANDROID: binder: remove WARN() for redundant txn error

Paolo Abeni <pabeni@redhat.com>
    dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Arnd Bergmann <arnd@arndb.de>
    arm64: dts: add #cooling-cells to CPU nodes

Arnd Bergmann <arnd@arndb.de>
    ARM: 8743/1: bL_switcher: add MODULE_LICENSE tag

Arnd Bergmann <arnd@arndb.de>
    video: fbdev/mmp: add MODULE_LICENSE

Arnd Bergmann <arnd@arndb.de>
    ASoC: ux500: add MODULE_LICENSE tag

Eric Dumazet <edumazet@google.com>
    net_sched: gen_estimator: fix lockdep splat

Willem de Bruijn <willemb@google.com>
    net: avoid skb_warn_bad_offload on IS_ERR

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    rds: tcp: atomically purge entries from rds_tcp_conn_list during netns delete

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    rds: tcp: correctly sequence cleanup on netns deletion.

Cong Wang <xiyou.wangcong@gmail.com>
    netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Cong Wang <xiyou.wangcong@gmail.com>
    netfilter: xt_cgroup: initialize info->priv in cgroup_mt_check_v1()

Paolo Abeni <pabeni@redhat.com>
    netfilter: on sockopt() acquire sock lock only in the required scope

Dmitry Vyukov <dvyukov@google.com>
    netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()

Eric Dumazet <edumazet@google.com>
    netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{match|target}

Dmitry Vyukov <dvyukov@google.com>
    netfilter: x_tables: fix int overflow in xt_alloc_table_info()

Dmitry Vyukov <dvyukov@google.com>
    kcov: detect double association with a single task

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: x86: fix escape of guest dr6 to the host

Douglas Gilbert <dgilbert@interlog.com>
    blk_rq_map_user_iov: fix error override

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Switch from WARN to pr_warn

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Add __GFP_NOWARN for system contig heap

Eric Biggers <ebiggers@google.com>
    crypto: x86/twofish-3way - Fix %rbp usage

Andrey Konovalov <andreyknvl@google.com>
    media: pvrusb2: properly check endpoint types

Paul Moore <paul@paul-moore.com>
    selinux: skip bounded transition processing if the policy isn't loaded

Paul Moore <paul@paul-moore.com>
    selinux: ensure the context is NUL terminated in security_context_to_sid_core()

Jason Wang <jasowang@redhat.com>
    ptr_ring: try vmalloc() when kmalloc() fails

Jason Wang <jasowang@redhat.com>
    ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE

Takashi Iwai <tiwai@suse.de>
    ALSA: bcd2000: Add a sanity check for invalid EPs

Takashi Iwai <tiwai@suse.de>
    ALSA: caiaq: Add a sanity check for invalid EPs

Takashi Iwai <tiwai@suse.de>
    ALSA: line6: Add a sanity check for invalid EPs

Chris Wilson <chris@chris-wilson.co.uk>
    drm: Require __GFP_NOFAIL for the legacy drm_modeset_lock_all

Jan Kara <jack@suse.cz>
    dnotify: Handle errors from fsnotify_add_mark_locked() in fcntl_dirnotify()

Jens Axboe <axboe@kernel.dk>
    blktrace: fix unlocked registration of tracepoints

Xin Long <lucien.xin@gmail.com>
    sctp: set frag_point in sctp_setsockopt_maxseg correctly

Cong Wang <xiyou.wangcong@gmail.com>
    xfrm: check id proto in validate_tmpl()

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix stack-out-of-bounds read on socket policy lookup.

Leon Romanovsky <leonro@mellanox.com>
    RDMA/netlink: Fix general protection fault

Lan Tianyu <tianyu.lan@intel.com>
    KVM/x86: Check input paging mode when cs.l is set

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() failed.

Florian Westphal <fw@strlen.de>
    xfrm: skip policies marked as dead while rehashing

Sabrina Dubroca <sd@queasysnail.net>
    xfrm: fix rcu usage in xfrm_get_type_offload

Florian Westphal <fw@strlen.de>
    xfrm: don't call xfrm_policy_cache_flush while holding spinlock

Steffen Klassert <steffen.klassert@secunet.com>
    esp: Fix GRO when the headers not fully in the linear part of the skb.

Johannes Berg <johannes.berg@intel.com>
    mac80211_hwsim: validate number of different channels

Johannes Berg <johannes.berg@intel.com>
    cfg80211: check dev_set_name() return value

Daniel Borkmann <daniel@iogearbox.net>
    bpf: mark dst unknown on inconsistent {s, u}bounds adjustments

Tom Herbert <tom@quantonium.net>
    kcm: Only allow TCP sockets to be attached to a KCM mux

Tom Herbert <tom@quantonium.net>
    kcm: Check if sk_user_data already set in kcm_attach

Jason Wang <jasowang@redhat.com>
    vhost: use mutex_lock_nested() in vhost_dev_lock_vqs()

Takashi Iwai <tiwai@suse.de>
    usb: core: Add a helper function to check the validity of EP type in URB


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/am4372.dtsi                      |   6 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                |   4 +-
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts   |   3 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  16 ++-
 arch/arm/boot/dts/omap4.dtsi                       |   4 +-
 arch/arm/common/bL_switcher_dummy_if.c             |   4 +
 arch/arm/mach-omap2/omap-secure.c                  |  19 ++++
 arch/arm/mach-omap2/omap-secure.h                  |   4 +
 arch/arm/mach-omap2/pm.h                           |   4 -
 arch/arm/mach-omap2/pm34xx.c                       |  13 +--
 arch/arm/mach-omap2/prm33xx.c                      |  12 --
 arch/arm/mach-omap2/sleep34xx.S                    |  26 +----
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   2 +
 arch/m68k/kernel/vmlinux-nommu.lds                 |   2 +
 arch/m68k/kernel/vmlinux-std.lds                   |   2 +
 arch/m68k/kernel/vmlinux-sun3.lds                  |   2 +
 arch/powerpc/perf/core-book3s.c                    |   4 +-
 arch/powerpc/perf/imc-pmu.c                        |  13 +++
 arch/s390/include/uapi/asm/virtio-ccw.h            |   2 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S       | 112 ++++++++++---------
 arch/x86/kvm/vmx.c                                 |   1 -
 arch/x86/kvm/x86.c                                 |  32 ++++++
 arch/x86/mm/ioremap.c                              |   4 +-
 arch/x86/mm/kmmio.c                                |  12 +-
 block/blk-map.c                                    |   4 +-
 drivers/Makefile                                   |   1 +
 drivers/android/binder.c                           |  29 ++++-
 drivers/base/power/runtime.c                       |   3 +-
 drivers/crypto/s5p-sss.c                           |  12 +-
 drivers/crypto/talitos.c                           |   5 +
 drivers/dma/at_hdmac.c                             |   4 +-
 drivers/dma/dma-jz4740.c                           |   4 +-
 drivers/dma/ioat/init.c                            |   2 +-
 drivers/gpio/gpio-74x164.c                         |   4 +-
 drivers/gpio/gpio-davinci.c                        |   2 +-
 drivers/gpu/drm/armada/armada_crtc.c               |  25 +++--
 drivers/gpu/drm/drm_modeset_lock.c                 |   2 +-
 drivers/gpu/drm/i915/intel_drv.h                   |   2 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |   4 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |   1 +
 drivers/iio/industrialio-core.c                    |   4 +-
 drivers/iio/proximity/sx9500.c                     |   9 ++
 drivers/infiniband/core/cma.c                      |   3 +-
 drivers/infiniband/core/device.c                   |   4 +-
 drivers/infiniband/core/iwcm.c                     |   2 +-
 drivers/infiniband/core/nldev.c                    |   2 +-
 drivers/infiniband/hw/hfi1/rc.c                    |   2 +-
 drivers/infiniband/hw/i40iw/i40iw_cm.c             |   6 +-
 drivers/infiniband/hw/i40iw/i40iw_ctrl.c           |  43 ++++---
 drivers/infiniband/hw/i40iw/i40iw_d.h              |   6 +-
 drivers/infiniband/hw/mlx4/qp.c                    |  26 +++--
 drivers/md/raid1.c                                 |   4 +
 drivers/md/raid10.c                                |   4 +
 drivers/md/raid5.c                                 |   2 +-
 drivers/media/i2c/Kconfig                          |   1 +
 drivers/media/i2c/s5k6aa.c                         |   5 +
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c            |  12 ++
 drivers/misc/mei/hw-me-regs.h                      |   5 +
 drivers/misc/mei/pci-me.c                          |   5 +
 drivers/net/dsa/mv88e6xxx/chip.c                   |  34 +++---
 drivers/net/ethernet/arc/emac_rockchip.c           |   7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   3 +-
 drivers/net/ethernet/freescale/gianfar.c           |  11 +-
 drivers/net/ethernet/marvell/mvpp2.c               |   2 +-
 drivers/net/ethernet/netronome/nfp/nfp_net_repr.c  |  15 +--
 .../net/ethernet/qualcomm/rmnet/rmnet_handlers.c   |   8 +-
 drivers/net/hippi/rrunner.c                        |   2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |   1 +
 drivers/net/phy/phylink.c                          |   1 +
 drivers/net/phy/sfp.c                              |   8 +-
 drivers/net/virtio_net.c                           |   2 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   2 +-
 drivers/net/wireless/mac80211_hwsim.c              |   5 +
 drivers/pci/host/pcie-rcar.c                       |   8 +-
 drivers/pinctrl/intel/pinctrl-denverton.c          |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c         |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c          |   6 +-
 drivers/platform/x86/dell-laptop.c                 |  17 +++
 drivers/s390/block/dasd_eckd.c                     |  16 ++-
 drivers/scsi/bfa/bfad_bsg.c                        |   6 +-
 drivers/scsi/bfa/bfad_im.c                         |   6 +-
 drivers/scsi/bfa/bfad_im.h                         |  10 ++
 drivers/scsi/lpfc/lpfc_mem.c                       |   2 +-
 drivers/soc/amlogic/meson-gx-socinfo.c             |   4 +-
 drivers/spi/spi-sun4i.c                            |   2 +-
 drivers/staging/android/ashmem.c                   |  19 ++--
 drivers/staging/android/ion/ion-ioctl.c            |   4 +-
 drivers/staging/android/ion/ion_system_heap.c      |   2 +-
 drivers/staging/ccree/ssi_hash.c                   |   2 +-
 drivers/staging/fsl-mc/bus/Kconfig                 |   2 +-
 drivers/staging/iio/adc/ad7192.c                   |  27 +++--
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   4 +-
 drivers/usb/core/urb.c                             |  30 ++++-
 drivers/usb/dwc3/dwc3-of-simple.c                  |   4 +-
 drivers/usb/dwc3/gadget.c                          |   2 +-
 drivers/usb/usbip/stub_dev.c                       |   3 +
 drivers/usb/usbip/vhci_hcd.c                       |   2 +
 drivers/vhost/vhost.c                              |   2 +-
 drivers/video/fbdev/mmp/core.c                     |   5 +
 drivers/xen/Kconfig                                |   2 +-
 fs/btrfs/disk-io.c                                 |  12 +-
 fs/btrfs/inode.c                                   |   2 +
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/notify/dnotify/dnotify.c                        |   7 +-
 include/linux/ptr_ring.h                           |  15 ++-
 include/linux/serdev.h                             |   2 +-
 include/linux/usb.h                                |   2 +
 include/net/cfg80211.h                             |   2 +
 include/net/red.h                                  |  13 ++-
 include/net/sctp/sctp.h                            |   3 +-
 include/trace/events/clk.h                         |   4 +-
 include/trace/events/xdp.h                         |   1 +
 kernel/bpf/verifier.c                              |  25 +++--
 kernel/events/core.c                               |   5 +-
 kernel/kcov.c                                      |   4 +-
 kernel/locking/lockdep.c                           |   3 +-
 kernel/trace/blktrace.c                            |  32 ++++--
 lib/oid_registry.c                                 |   8 +-
 mm/early_ioremap.c                                 |   2 +-
 mm/vmalloc.c                                       |  10 +-
 mm/vmscan.c                                        |   3 +
 net/core/dev.c                                     |   2 +-
 net/core/gen_estimator.c                           |   4 +
 net/decnet/af_decnet.c                             |  62 ++++++-----
 net/ipv4/esp4_offload.c                            |   3 +-
 net/ipv4/ip_sockglue.c                             |  14 +--
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  16 ++-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     |   6 +-
 net/ipv6/esp6_offload.c                            |   3 +-
 net/ipv6/ipv6_sockglue.c                           |  17 +--
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c     |  18 ++-
 net/kcm/kcmsock.c                                  |  25 ++++-
 net/netfilter/x_tables.c                           |   9 +-
 net/netfilter/xt_RATEEST.c                         |  22 +++-
 net/netfilter/xt_bpf.c                             |   6 +
 net/netfilter/xt_cgroup.c                          |   1 +
 net/rds/connection.c                               |   3 +-
 net/rds/rds.h                                      |   6 +-
 net/rds/tcp.c                                      |  13 ++-
 net/rds/tcp.h                                      |   1 +
 net/sched/sch_choke.c                              |   3 +
 net/sched/sch_gred.c                               |   3 +
 net/sched/sch_red.c                                |   2 +
 net/sched/sch_sfq.c                                |   3 +
 net/sctp/outqueue.c                                |   6 +-
 net/sctp/socket.c                                  |  29 +++--
 net/vmw_vsock/hyperv_transport.c                   |   2 +-
 net/wireless/core.c                                |   8 +-
 net/wireless/core.h                                |   2 -
 net/xfrm/xfrm_input.c                              |  12 +-
 net/xfrm/xfrm_policy.c                             |  15 ++-
 net/xfrm/xfrm_state.c                              |   3 +-
 net/xfrm/xfrm_user.c                               |  24 ++++
 scripts/kernel-doc                                 |   2 +-
 security/selinux/ss/services.c                     |  21 ++--
 sound/soc/rockchip/rockchip_spdif.c                |  18 ++-
 sound/soc/sh/rcar/ssi.c                            |  16 ++-
 sound/soc/ux500/mop500.c                           |   4 +
 sound/soc/ux500/ux500_pcm.c                        |   5 +
 sound/usb/bcd2000/bcd2000.c                        |   7 ++
 sound/usb/caiaq/device.c                           |   7 ++
 sound/usb/line6/driver.c                           |   7 ++
 tools/perf/bench/numa.c                            |  56 +++++++++-
 tools/perf/builtin-help.c                          |   4 +-
 tools/perf/builtin-top.c                           |  15 ++-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   6 +-
 tools/perf/tests/task-exit.c                       |   4 +
 tools/perf/util/annotate.c                         |  18 +--
 tools/perf/util/evsel.c                            |  12 +-
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/parse-events.c                     |   2 +
 tools/perf/util/parse-events.h                     |   3 +
 tools/perf/util/pmu.c                              |   5 +
 tools/testing/selftests/bpf/test_verifier.c        | 123 ++++++++++++++++++++-
 virt/kvm/arm/arm.c                                 |   2 +-
 virt/kvm/arm/vgic/vgic.c                           |   5 +-
 177 files changed, 1201 insertions(+), 490 deletions(-)
