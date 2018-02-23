Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3795596-1519416577-2-7081823474885438665
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
    t=1519416575; b=bCq5+uGB5J0Q7Hs14Yno8hBUgbNTHNgsV1/wIYWG9X0QPLE
    o6QWQmUSlvhlrA3BWuH2fYPRLcp9+Ccq3JBo4QYyA+iZ9SzMUu+Ctu6h1xuqwb0E
    vaQtjloSPlmJB0saFZ7KEJ/Sjig97WSbL22MXEVKMZKpgR8YlZ9wGRFydEMDmMqm
    PEUvqrbNbJo0/yxPFggkTc9aq2Pf5pPmB2x05f0c07QwuXZL4VZz0mdKmMCDggRC
    jJogFbXrvAPZfne+Kl/ya3uFf8qEVNxURE1WKulVRIwf3At6fitguhm2QHd4ae4T
    l+sXRQj/zt8Sq9BZErAH6J44hT4nhOW8P+wEXiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519416575; bh=YW2Ou+qvFhYXKPcMJrLVcr2MGG
    mNCKuiGsqxlgCtyKk=; b=fjtxaFt2jDVwr1Oo8sje5NtIeosySYhk7FfGbdhBZ+
    5RBZNA2WZ8ouwOSjr2mAvuYNHrg6yEhXF2z1sVS6vJs46lj5SUb4VSGH2I08OkD1
    2M25ZW9aXfnp79fslhWfu2qs4bMSzSCxIlJynhBuLTqyYnpKeUKf0BNZcpUziclE
    tnM5EiVIiB8r60+3bgnaVJfodca7wcXxyMyrJZYNTOcQkgXtHwy/UyjO6JwR+VD2
    VR+6FgwK8cvRY+YsuEgr5KVS9bcDH74Ix5ij6dHkcRywETbmJrrIVT2wAWXr8gEl
    MSUWRXVgSTDd5CBRHeN/TNV2I2e4dHsJjn6c9uzfxuAw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933025AbeBWSmX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:42:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932515AbeBWSmU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/145] 4.9.84-stable review
Date: Fri, 23 Feb 2018 19:25:06 +0100
Message-Id: <20180223170724.669759283@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.84-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.84-rc1
X-KernelTest-Deadline: 2018-02-25T17:07+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.84 release.
There are 145 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb 25 17:06:27 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.84-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.84-rc1

Kamil Konieczny <k.konieczny@partner.samsung.com>
    crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

Jan Dakinevich <jan.dakinevich@gmail.com>
    KVM: nVMX: invvpid handling improvements

Jan Dakinevich <jan.dakinevich@gmail.com>
    KVM: VMX: clean up declaration of VPID/EPT invalidation types

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: async_pf: Fix #DF due to inject "Page not Present" and "Page Ready" exceptions simultaneously

Borislav Petkov <bp@suse.de>
    x86/microcode/AMD: Change load_microcode_amd()'s param to bool to fix preemptibility bug

Arnd Bergmann <arnd@arndb.de>
    usb: phy: msm add regulator dependency

Arnd Bergmann <arnd@arndb.de>
    arm64: fix warning about swapper_pg_dir overflow

Arnd Bergmann <arnd@arndb.de>
    idle: i7300: add PCI dependency

Arnd Bergmann <arnd@arndb.de>
    spi: bcm-qspi: shut up warning about cfi header inclusion

Arnd Bergmann <arnd@arndb.de>
    binfmt_elf: compat: avoid unused function warning

Arnd Bergmann <arnd@arndb.de>
    arm64: sunxi: always enable reset controller

Arnd Bergmann <arnd@arndb.de>
    drm/i915: hide unused intel_panel_set_backlight function

Arnd Bergmann <arnd@arndb.de>
    kasan: rework Kconfig settings

Tobias Regnery <tobias.regnery@gmail.com>
    clk: meson: gxbb: fix build error without RESET_CONTROLLER

Arnd Bergmann <arnd@arndb.de>
    ISDN: eicon: reduce stack size of sig_ind function

Arnd Bergmann <arnd@arndb.de>
    tw5864: use dev_warn instead of WARN to shut up warning

Arnd Bergmann <arnd@arndb.de>
    em28xx: only use mt9v011 if camera support is enabled

Arnd Bergmann <arnd@arndb.de>
    go7007: add MEDIA_CAMERA_SUPPORT dependency

Arnd Bergmann <arnd@arndb.de>
    tc358743: fix register i2c_rd/wr functions

Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
    shmem: fix compilation warnings on unused functions

Arnd Bergmann <arnd@arndb.de>
    KVM: add X86_LOCAL_APIC dependency

Arnd Bergmann <arnd@arndb.de>
    Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    drm/nouveau: hide gcc-4.9 -Wmaybe-uninitialized

Ilya Dryomov <idryomov@gmail.com>
    rbd: silence bogus -Wmaybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    drm: exynos: mark pm functions as __maybe_unused

Arnd Bergmann <arnd@arndb.de>
    security/keys: BIG_KEY requires CONFIG_CRYPTO

Arnd Bergmann <arnd@arndb.de>
    cw1200: fix bogus maybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    reiserfs: avoid a -Wmaybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    ALSA: hda/ca0132 - fix possible NULL pointer use

Kefeng Wang <wangkefeng.wang@huawei.com>
    arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set

Arnd Bergmann <arnd@arndb.de>
    scsi: advansys: fix uninitialized data access

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    x86/vm86: Fix unused variable warning if THP is disabled

Arnd Bergmann <arnd@arndb.de>
    x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG

Jun Nie <jun.nie@linaro.org>
    dmaengine: zx: fix build warning

Arnd Bergmann <arnd@arndb.de>
    x86: add MULTIUSER dependency for KVM

Arnd Bergmann <arnd@arndb.de>
    thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies

Arnd Bergmann <arnd@arndb.de>
    x86/build: Silence the build with "make -s"

Josh Poimboeuf <jpoimboe@redhat.com>
    tools build: Add tools tree support for 'make -s'

Arnd Bergmann <arnd@arndb.de>
    x86/fpu/math-emu: Fix possible uninitialized variable use

Arnd Bergmann <arnd@arndb.de>
    arm64: define BUG() instruction without CONFIG_BUG

Arnd Bergmann <arnd@arndb.de>
    gpio: xgene: mark PM functions as __maybe_unused

Borislav Petkov <bp@suse.de>
    x86/ras/inject: Make it depend on X86_LOCAL_APIC=y

Arnd Bergmann <arnd@arndb.de>
    scsi: advansys: fix build warning for PCI=n

Arnd Bergmann <arnd@arndb.de>
    video: fbdev: via: remove possibly unused variables

Stephen Boyd <sboyd@codeaurora.org>
    perf: xgene: Include module.h

Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
    PCI: Change pci_host_common_probe() visibility

Jérémy Lefaure <jeremy.lefaure@lse.epita.fr>
    usb: musb: fix compilation warning on unused function

Borislav Petkov <bp@suse.de>
    platform/x86: intel_mid_thermal: Fix suspend handlers unused warning

Augusto Mecking Caringi <augustocaringi@gmail.com>
    gpio: intel-mid: Fix build warning when !CONFIG_PM

Borislav Petkov <bp@suse.de>
    PCI: vmd: Fix suspend handlers defined-but-not-used warning

Arnd Bergmann <arnd@arndb.de>
    perf/x86: Shut up false-positive -Wmaybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    vmxnet3: prevent building with 64K pages

Tobias Regnery <tobias.regnery@gmail.com>
    clk: sunxi-ng: fix build error without CONFIG_RESET_CONTROLLER

Arnd Bergmann <arnd@arndb.de>
    shmem: avoid maybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    drm/i915: fix intel_backlight_device_register declaration

LEROY Christophe <christophe.leroy@c-s.fr>
    crypto: talitos - fix Kernel Oops on hashing an empty file

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Improve RFI L1-D cache flush fallback

Nicholas Piggin <npiggin@gmail.com>
    powerpc/64s: Simple RFI macro conversions

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/64s: Fix conversion of slb_miss_common to use RFI_TO_USER/KERNEL

Jia-Ju Bai <baijiaju1990@163.com>
    hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close

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

Russell King <rmk+kernel@armlinux.org.uk>
    drm/armada: fix leak of crtc structure

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix stack-out-of-bounds with misconfigured transport mode policies.

Takuo Koguchi <takuo.koguchi@gmail.com>
    spi: sun4i: disable clocks in the remove function

Stefan Potyra <Stefan.Potyra@elektrobit.com>
    ASoC: rockchip: disable clock on error

Cai Li <cai.li@spreadtrum.com>
    clk: fix a panic error caused by accessing NULL pointer

Gustavo A. R. Silva <garsilva@embeddedor.com>
    dmaengine: at_hdmac: fix potential NULL pointer dereference in atc_prep_dma_interleaved

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: ioat: Fix error handling path

Claudiu Manoil <claudiu.manoil@nxp.com>
    gianfar: Disable EEE autoneg by default

Eric Biggers <ebiggers3@gmail.com>
    509: fix printing uninitialized stack memory when OID is empty

Branislav Radocaj <branislav@radocaj.org>
    net: ethernet: arc: fix error handling in emac_rockchip_probe

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    brcmfmac: Avoid build error with make W=1

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix possible off-by-one in btrfs_search_path_in_tree

Nogah Frankel <nogahf@mellanox.com>
    net_sched: red: Avoid illegal values

Nogah Frankel <nogahf@mellanox.com>
    net_sched: red: Avoid devision by zero

Zumeng Chen <zumeng.chen@gmail.com>
    gianfar: fix a flooded alignment reports because of padding issue.

Tony Lindgren <tony@atomide.com>
    ARM: dts: Fix elm interrupt compiler warning

Stefan Haberland <sth@linux.vnet.ibm.com>
    s390/dasd: prevent prefix I/O error

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
    powerpc/perf: Fix oops when grouping different pmu events

Greg Ungerer <gerg@linux-m68k.org>
    m68k: add missing SOFTIRQENTRY_TEXT linker section

Gao Feng <gfree.wind@vip.163.com>
    ipvlan: Add the skb->mark as flow4's member to lookup route

Will Deacon <will.deacon@arm.com>
    scripts/kernel-doc: Don't fail with status != 0 if error encountered with -none

Xin Long <lucien.xin@gmail.com>
    sctp: only update outstanding_bytes for transmitted queue when doing prsctp_prune

Moni Shoua <monis@mellanox.com>
    RDMA/cma: Make sure that PSN is not over max allowed

Mustafa Ismail <mustafa.ismail@intel.com>
    i40iw: Correct ARP index mask

Andre Przywara <andre.przywara@arm.com>
    pinctrl: sunxi: Fix A64 UART mux value

Andre Przywara <andre.przywara@arm.com>
    pinctrl: sunxi: Fix A80 interrupt pin bank

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: s5k6aa: describe some function parameters

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
    perf bench numa: Fixup discontiguous/sparse numa nodes

Jiri Olsa <jolsa@kernel.org>
    perf top: Fix window dimensions change handling

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

Randy Dunlap <rdunlap@infradead.org>
    usb: build drivers/usb/common/ when USB_SUPPORT is set

Shuah Khan <shuah@kernel.org>
    usbip: keep usbip_device sockfd state in sync with tcp_socket

Alexandru Ardelean <alexandru.ardelean@analog.com>
    staging: iio: ad5933: switch buffer mode to software

Alexandru Ardelean <alexandru.ardelean@analog.com>
    staging: iio: adc: ad7192: fix external frequency setting

Eric Biggers <ebiggers@google.com>
    binder: check for binder_thread allocation failure in binder_poll()

Ben Hutchings <ben@decadent.org.uk>
    staging: android: ashmem: Fix a race condition in pin ioctls

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

Eric Biggers <ebiggers@google.com>
    crypto: hash - prevent using keyed hashes without setting key

Eric Biggers <ebiggers@google.com>
    crypto: hash - annotate algorithms taking optional key

Willem de Bruijn <willemb@google.com>
    net: avoid skb_warn_bad_offload on IS_ERR

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    rds: tcp: atomically purge entries from rds_tcp_conn_list during netns delete

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

Paul Moore <paul@paul-moore.com>
    selinux: skip bounded transition processing if the policy isn't loaded

Paul Moore <paul@paul-moore.com>
    selinux: ensure the context is NUL terminated in security_context_to_sid_core()

David Howells <dhowells@redhat.com>
    Provide a function to create a NUL-terminated string from unterminated data

Jason Wang <jasowang@redhat.com>
    ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE

Chris Wilson <chris@chris-wilson.co.uk>
    drm: Require __GFP_NOFAIL for the legacy drm_modeset_lock_all

Jens Axboe <axboe@kernel.dk>
    blktrace: fix unlocked registration of tracepoints

Xin Long <lucien.xin@gmail.com>
    sctp: set frag_point in sctp_setsockopt_maxseg correctly

Cong Wang <xiyou.wangcong@gmail.com>
    xfrm: check id proto in validate_tmpl()

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix stack-out-of-bounds read on socket policy lookup.

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() failed.

Florian Westphal <fw@strlen.de>
    xfrm: skip policies marked as dead while rehashing

Johannes Berg <johannes.berg@intel.com>
    cfg80211: check dev_set_name() return value

Tom Herbert <tom@quantonium.net>
    kcm: Only allow TCP sockets to be attached to a KCM mux

Tom Herbert <tom@quantonium.net>
    kcm: Check if sk_user_data already set in kcm_attach

Jason Wang <jasowang@redhat.com>
    vhost: use mutex_lock_nested() in vhost_dev_lock_vqs()


-------------

Diffstat:

 Makefile                                           |  10 +-
 arch/arm/boot/dts/am4372.dtsi                      |   6 +-
 arch/arm/boot/dts/am437x-cm-t43.dts                |   4 +-
 arch/arm/boot/dts/logicpd-som-lv-37xx-devkit.dts   |   3 +-
 arch/arm/boot/dts/logicpd-som-lv.dtsi              |  16 +--
 arch/arm/boot/dts/omap4.dtsi                       |   4 +-
 arch/arm/common/bL_switcher_dummy_if.c             |   4 +
 arch/arm/mach-omap2/omap-secure.c                  |  19 ++++
 arch/arm/mach-omap2/omap-secure.h                  |   4 +
 arch/arm/mach-omap2/pm.h                           |   4 -
 arch/arm/mach-omap2/pm34xx.c                       |  13 +--
 arch/arm/mach-omap2/prm33xx.c                      |  12 ---
 arch/arm/mach-omap2/sleep34xx.S                    |  26 +----
 arch/arm64/Kconfig                                 |   2 +-
 arch/arm64/Kconfig.platforms                       |   2 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   2 +
 arch/arm64/crypto/crc32-arm64.c                    |   2 +
 arch/arm64/include/asm/bug.h                       |  33 +++---
 arch/arm64/mm/mmu.c                                |   2 +-
 arch/m68k/kernel/vmlinux-nommu.lds                 |   2 +
 arch/m68k/kernel/vmlinux-std.lds                   |   2 +
 arch/m68k/kernel/vmlinux-sun3.lds                  |   2 +
 arch/powerpc/crypto/crc32c-vpmsum_glue.c           |   1 +
 arch/powerpc/include/asm/exception-64s.h           |   2 +-
 arch/powerpc/include/asm/paca.h                    |   3 +-
 arch/powerpc/kernel/asm-offsets.c                  |   3 +-
 arch/powerpc/kernel/entry_64.S                     |   9 +-
 arch/powerpc/kernel/exceptions-64s.S               |  99 +++++++++---------
 arch/powerpc/kernel/idle_book3s.S                  |   7 +-
 arch/powerpc/kernel/setup_64.c                     |  13 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S            |   7 +-
 arch/powerpc/kvm/book3s_rmhandlers.S               |   7 +-
 arch/powerpc/kvm/book3s_segment.S                  |   4 +-
 arch/powerpc/perf/core-book3s.c                    |   4 +-
 arch/s390/crypto/crc32-vx.c                        |   3 +
 arch/sparc/crypto/crc32c_glue.c                    |   1 +
 arch/x86/Kconfig                                   |   2 +-
 arch/x86/Kconfig.debug                             |   1 +
 arch/x86/boot/Makefile                             |   5 +-
 arch/x86/crypto/crc32-pclmul_glue.c                |   1 +
 arch/x86/crypto/crc32c-intel_glue.c                |   1 +
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S       | 112 +++++++++++----------
 arch/x86/events/core.c                             |   4 +-
 arch/x86/include/asm/microcode_amd.h               |   1 -
 arch/x86/include/asm/vmx.h                         |   5 +-
 arch/x86/kernel/cpu/mcheck/mce-inject.c            |   5 +-
 arch/x86/kernel/cpu/microcode/amd.c                |  17 ++--
 arch/x86/kernel/vm86_32.c                          |   5 +-
 arch/x86/kvm/Kconfig                               |   3 +-
 arch/x86/kvm/vmx.c                                 |  36 ++++---
 arch/x86/kvm/x86.c                                 |  40 ++++++--
 arch/x86/math-emu/Makefile                         |   4 +-
 arch/x86/math-emu/reg_compare.c                    |  16 +--
 arch/x86/mm/ioremap.c                              |   4 +-
 arch/x86/mm/kmmio.c                                |  12 ++-
 block/blk-map.c                                    |   4 +-
 crypto/ahash.c                                     |  22 +++-
 crypto/algif_hash.c                                |  52 ++--------
 crypto/crc32_generic.c                             |   1 +
 crypto/crc32c_generic.c                            |   1 +
 crypto/cryptd.c                                    |   7 +-
 crypto/mcryptd.c                                   |   7 +-
 crypto/shash.c                                     |  25 ++++-
 drivers/Makefile                                   |   1 +
 drivers/android/binder.c                           |   2 +
 drivers/block/rbd.c                                |   2 +-
 drivers/clk/meson/Kconfig                          |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |   1 +
 drivers/crypto/bfin_crc.c                          |   3 +-
 drivers/crypto/s5p-sss.c                           |  12 ++-
 drivers/crypto/talitos.c                           |   5 +
 drivers/dma/at_hdmac.c                             |   4 +-
 drivers/dma/dma-jz4740.c                           |   4 +-
 drivers/dma/ioat/init.c                            |   2 +-
 drivers/dma/zx296702_dma.c                         |   2 +-
 drivers/gpio/gpio-intel-mid.c                      |   2 +-
 drivers/gpio/gpio-xgene.c                          |  13 +--
 drivers/gpu/drm/armada/armada_crtc.c               |  25 ++---
 drivers/gpu/drm/drm_modeset_lock.c                 |   2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   6 +-
 drivers/gpu/drm/i915/intel_drv.h                   |   2 +-
 drivers/gpu/drm/i915/intel_panel.c                 |  86 ++++++++--------
 drivers/gpu/drm/nouveau/nouveau_gem.c              |   2 +-
 drivers/idle/Kconfig                               |   1 +
 drivers/infiniband/core/cma.c                      |   1 +
 drivers/infiniband/hw/i40iw/i40iw_d.h              |   2 +-
 drivers/input/keyboard/tca8418_keypad.c            |  21 ++--
 drivers/isdn/hardware/eicon/message.c              |  16 +--
 drivers/media/i2c/s5k6aa.c                         |   5 +
 drivers/media/i2c/tc358743.c                       |  46 +++++----
 drivers/media/pci/tw5864/tw5864-video.c            |   6 +-
 drivers/media/usb/em28xx/Kconfig                   |   2 +-
 drivers/media/usb/go7007/Kconfig                   |   2 +-
 drivers/net/Kconfig                                |   3 +
 drivers/net/ethernet/arc/emac_rockchip.c           |   7 +-
 drivers/net/ethernet/freescale/gianfar.c           |  11 +-
 drivers/net/hippi/rrunner.c                        |   2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |   1 +
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   2 +-
 drivers/net/wireless/st/cw1200/wsm.c               |   8 +-
 drivers/pci/host/vmd.c                             |   2 +-
 drivers/perf/xgene_pmu.c                           |   1 +
 drivers/pinctrl/sunxi/pinctrl-sun50i-a64.c         |   2 +-
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c          |   6 +-
 drivers/platform/x86/dell-laptop.c                 |  17 ++++
 drivers/platform/x86/intel_mid_thermal.c           |   2 +
 drivers/s390/block/dasd_eckd.c                     |  16 +--
 drivers/scsi/advansys.c                            |  24 +++--
 drivers/spi/Kconfig                                |   1 +
 drivers/spi/spi-sun4i.c                            |   2 +-
 drivers/staging/android/ashmem.c                   |  19 ++--
 drivers/staging/android/ion/ion-ioctl.c            |   4 +-
 drivers/staging/android/ion/ion_system_heap.c      |   2 +-
 drivers/staging/iio/adc/ad7192.c                   |  27 +++--
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   4 +-
 .../lustre/lnet/libcfs/linux/linux-crypto-adler.c  |   1 +
 drivers/thermal/Kconfig                            |   4 +-
 drivers/usb/dwc3/dwc3-of-simple.c                  |   4 +-
 drivers/usb/dwc3/gadget.c                          |   2 +-
 drivers/usb/musb/musb_core.c                       |   2 +
 drivers/usb/phy/Kconfig                            |   1 +
 drivers/usb/usbip/stub_dev.c                       |   3 +
 drivers/usb/usbip/vhci_hcd.c                       |   2 +
 drivers/vhost/vhost.c                              |   2 +-
 drivers/video/fbdev/mmp/core.c                     |   5 +
 drivers/video/fbdev/via/viafbdev.c                 |   8 +-
 drivers/xen/Kconfig                                |   2 +-
 fs/btrfs/ioctl.c                                   |   2 +-
 fs/compat_binfmt_elf.c                             |   2 +
 fs/reiserfs/lbalance.c                             |   2 +-
 fs/reiserfs/reiserfs.h                             |   1 -
 include/crypto/hash.h                              |  34 +++++--
 include/linux/crypto.h                             |   8 ++
 include/linux/pci-ecam.h                           |   2 +-
 include/linux/ptr_ring.h                           |   2 +
 include/linux/string.h                             |   1 +
 include/net/red.h                                  |  13 ++-
 include/net/sctp/sctp.h                            |   3 +-
 include/trace/events/clk.h                         |   4 +-
 kernel/kcov.c                                      |   4 +-
 kernel/trace/blktrace.c                            |  32 ++++--
 lib/Kconfig.debug                                  |   1 -
 lib/oid_registry.c                                 |   8 +-
 mm/early_ioremap.c                                 |   2 +-
 mm/shmem.c                                         |   6 +-
 mm/util.c                                          |  24 +++++
 mm/vmscan.c                                        |   3 +
 net/core/dev.c                                     |   2 +-
 net/decnet/af_decnet.c                             |  62 ++++++------
 net/ipv4/ip_sockglue.c                             |  14 +--
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |  16 ++-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     |   6 +-
 net/ipv6/ipv6_sockglue.c                           |  17 +---
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c     |  18 ++--
 net/kcm/kcmsock.c                                  |  25 ++++-
 net/netfilter/x_tables.c                           |  10 +-
 net/netfilter/xt_RATEEST.c                         |  22 +++-
 net/netfilter/xt_cgroup.c                          |   1 +
 net/rds/tcp.c                                      |   9 +-
 net/rds/tcp.h                                      |   1 +
 net/sched/sch_choke.c                              |   3 +
 net/sched/sch_gred.c                               |   3 +
 net/sched/sch_red.c                                |   2 +
 net/sched/sch_sfq.c                                |   3 +
 net/sctp/outqueue.c                                |   6 +-
 net/sctp/socket.c                                  |  29 ++++--
 net/wireless/core.c                                |   8 +-
 net/xfrm/xfrm_policy.c                             |  11 +-
 net/xfrm/xfrm_user.c                               |  24 +++++
 scripts/kernel-doc                                 |   2 +-
 security/keys/Kconfig                              |   1 +
 security/selinux/ss/services.c                     |  21 ++--
 sound/pci/hda/patch_ca0132.c                       |   3 +
 sound/soc/rockchip/rockchip_spdif.c                |  18 +++-
 sound/soc/ux500/mop500.c                           |   4 +
 sound/soc/ux500/ux500_pcm.c                        |   5 +
 tools/build/Makefile.build                         |  10 ++
 tools/perf/bench/numa.c                            |  56 ++++++++++-
 tools/perf/builtin-top.c                           |  15 ++-
 tools/scripts/Makefile.include                     |  12 ++-
 180 files changed, 1121 insertions(+), 680 deletions(-)
