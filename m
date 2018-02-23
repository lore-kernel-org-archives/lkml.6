Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519418280-3-4736972021745681790
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418279; b=RxaYhOjEglgPNHFUoIrtJJZsGmdwmXqTULY8UyzCm2Stimy
    4IYR5b6mR4gosI+KKH3O4l/fpreUInlX9YycKzluSdsGRcfKxB+amPCmE1nsz/zz
    PhQhKMn01ScoylQiPulJuVkCLp4ervQFOkqRK0OyXrutDsLPy8Qzs4yHV6XhL8fG
    RiYFa7v4R5Xrai3dgpDpNAtUbDLp8xbZ/bmfyvpmvaUmfEeAZPfC9eFuKGD2qpNp
    spaYQiN2ZBIY6gDx3jLaXE1Y6RNsIld51zPnYbnenqp5Q8GiOmf1RgC0XsbhyLG2
    LVbf9oame2VlPdFcCGmD5S4GNTrMJHLrprTrcZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1519418279; bh=HjT4YwcmmGtQx3Cc5c8a77v8bM
    lkktXFBaclzw5UDoQ=; b=b3mzAZKBeFgDXTnzsizh+YS+3PVC1t/PblHGiST+cI
    TRxHJQ+rrWMx0Cy9M6MOHoPt2p7xlPEUZt1Wwd/T1rJbI7jTrnoURa9kAUaqJB7o
    i3b0fQsKyLMeNe1JpmHPJO1HS7kfCv0beKgVEEEiCfZoFepJFZOC4BToMt+Bxn+j
    tBM/hPNA6+JjpqsTzv7wndyiBS5FmHi1+sEbkduB1EUrbK7hIHG59gHuuwps8f7M
    lDPzyVdKSK2PgZfpDM/X1OhL5h3Uwr9aLdTZd2InBqy6OlmjD3cSIoFYfybpECsk
    ovlZiYU+L5zrLt0AiTySH4cQi8w8tVAvBuzjUA6Duxfg==
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
        id S1753547AbeBWSe2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:34:28 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752518AbeBWSe0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:34:26 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 000/193] 4.4.118-stable review
Date: Fri, 23 Feb 2018 19:23:53 +0100
Message-Id: <20180223170325.997716448@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.118-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.118-rc1
X-KernelTest-Deadline: 2018-02-25T17:03+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.118 release.
There are 193 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb 25 17:02:20 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.118-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.118-rc1

Kamil Konieczny <k.konieczny@partner.samsung.com>
    crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

Jan Dakinevich <jan.dakinevich@gmail.com>
    KVM: nVMX: invvpid handling improvements

Jan Dakinevich <jan.dakinevich@gmail.com>
    KVM: VMX: clean up declaration of VPID/EPT invalidation types

Jim Mattson <jmattson@google.com>
    kvm: nVMX: Fix kernel panics induced by illegal INVEPT/INVVPID types

David Hildenbrand <david@redhat.com>
    KVM: nVMX: vmx_complete_nested_posted_interrupt() can't fail

David Hildenbrand <david@redhat.com>
    KVM: nVMX: kmap() can't fail

Darren Kenny <darren.kenny@oracle.com>
    x86/speculation: Fix typo IBRS_ATT, which should be IBRS_ALL

KarimAllah Ahmed <karahmed@amazon.de>
    x86/spectre: Simplify spectre_v2 command line parsing

David Woodhouse <dwmw@amazon.co.uk>
    x86/retpoline: Avoid retpolines for built-in __init functions

Dan Williams <dan.j.williams@intel.com>
    x86/kvm: Update spectre-v1 mitigation

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/paravirt: Remove 'noreplace-paravirt' cmdline option

Colin Ian King <colin.king@canonical.com>
    x86/spectre: Fix spelling mistake: "vunerable"-> "vulnerable"

Dan Williams <dan.j.williams@intel.com>
    x86/spectre: Report get_user mitigation for spectre_v1

Dan Williams <dan.j.williams@intel.com>
    nl80211: Sanitize array index in parse_txq_params

Dan Williams <dan.j.williams@intel.com>
    vfs, fdtable: Prevent bounds-check bypass via speculative execution

Dan Williams <dan.j.williams@intel.com>
    x86/syscall: Sanitize syscall table de-references under speculation

Dan Williams <dan.j.williams@intel.com>
    x86/get_user: Use pointer masking to limit speculation

Dan Williams <dan.j.williams@intel.com>
    x86: Introduce barrier_nospec

Dan Williams <dan.j.williams@intel.com>
    x86: Implement array_index_mask_nospec

Dan Williams <dan.j.williams@intel.com>
    array_index_nospec: Sanitize speculative array de-references

Mark Rutland <mark.rutland@arm.com>
    Documentation: Document array_index_nospec

Dou Liyang <douly.fnst@cn.fujitsu.com>
    x86/spectre: Check CONFIG_RETPOLINE in command line parser

Thomas Gleixner <tglx@linutronix.de>
    x86/cpu/bugs: Make retpoline module warning conditional

Borislav Petkov <bp@suse.de>
    x86/bugs: Drop one "mitigation" from dmesg

Borislav Petkov <bp@suse.de>
    x86/nospec: Fix header guards names

Andi Kleen <ak@linux.intel.com>
    module/retpoline: Warn about missing retpoline in module

Peter Zijlstra <peterz@infradead.org>
    KVM: VMX: Make indirect call speculation safe

Peter Zijlstra <peterz@infradead.org>
    KVM: x86: Make indirect calls in emulator speculation safe

Waiman Long <longman@redhat.com>
    x86/retpoline: Remove the esp/rsp thunk

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: async_pf: Fix #DF due to inject "Page not Present" and "Page Ready" exceptions simultaneously

Arnd Bergmann <arnd@arndb.de>
    kasan: rework Kconfig settings

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    drm/gma500: remove helper function

Borislav Petkov <bp@suse.de>
    x86/microcode/AMD: Change load_microcode_amd()'s param to bool to fix preemptibility bug

Michal Marek <mmarek@suse.com>
    genksyms: Fix segfault with invalid declarations

Andy Lutomirski <luto@kernel.org>
    dell-wmi, dell-laptop: depends DMI

Arnd Bergmann <arnd@arndb.de>
    netlink: fix nla_put_{u8,u16,u32} for KASAN

Vinod Koul <vinod.koul@intel.com>
    ASoC: Intel: Kconfig: fix build when ACPI is not enabled

Arnd Bergmann <arnd@arndb.de>
    ARM: tegra: select USB_ULPI from EHCI rather than platform

Arnd Bergmann <arnd@arndb.de>
    ncr5380: shut up gcc indentation warning

Arnd Bergmann <arnd@arndb.de>
    usb: phy: msm add regulator dependency

Arnd Bergmann <arnd@arndb.de>
    idle: i7300: add PCI dependency

Arnd Bergmann <arnd@arndb.de>
    binfmt_elf: compat: avoid unused function warning

Arnd Bergmann <arnd@arndb.de>
    isdn: sc: work around type mismatch warning

Arnd Bergmann <arnd@arndb.de>
    power: bq27xxx_battery: mark some symbols __maybe_unused

Arnd Bergmann <arnd@arndb.de>
    Revert "power: bq27xxx_battery: Remove unneeded dependency in Kconfig"

Miklos Szeredi <mszeredi@redhat.com>
    ncpfs: fix unused variable warning

Arnd Bergmann <arnd@arndb.de>
    gpio: xgene: mark PM functions as __maybe_unused

Arnd Bergmann <arnd@arndb.de>
    net: hp100: remove unnecessary #ifdefs

Jun Nie <jun.nie@linaro.org>
    dmaengine: zx: fix build warning

Arnd Bergmann <arnd@arndb.de>
    perf/x86: Shut up false-positive -Wmaybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    wireless: cw1200: use __maybe_unused to hide pm functions_

Arnd Bergmann <arnd@arndb.de>
    cw1200: fix bogus maybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    v4l: remove MEDIA_TUNER dependency for VIDEO_TUNER

Arnd Bergmann <arnd@arndb.de>
    hdpvr: hide unused variable

Thierry Reding <treding@nvidia.com>
    drm/gma500: Sanity-check pipe index

Heikki Krogerus <heikki.krogerus@linux.intel.com>
    serial: 8250_mid: fix broken DMA dependency

Arnd Bergmann <arnd@arndb.de>
    ASoC: rockchip: use __maybe_unused to hide st_irq_syscfg_resume

Arnd Bergmann <arnd@arndb.de>
    ISDN: eicon: reduce stack size of sig_ind function

Arnd Bergmann <arnd@arndb.de>
    em28xx: only use mt9v011 if camera support is enabled

Arnd Bergmann <arnd@arndb.de>
    go7007: add MEDIA_CAMERA_SUPPORT dependency

Arnd Bergmann <arnd@arndb.de>
    KVM: add X86_LOCAL_APIC dependency

Arnd Bergmann <arnd@arndb.de>
    Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    drm/nouveau: hide gcc-4.9 -Wmaybe-uninitialized

Arnd Bergmann <arnd@arndb.de>
    tc358743: fix register i2c_rd/wr functions

Randy Dunlap <rdunlap@infradead.org>
    staging: unisys: visorinput depends on INPUT

Luis R. Rodriguez <mcgrof@kernel.org>
    i2c: remove __init from i2c_register_board_info()

Arnd Bergmann <arnd@arndb.de>
    b2c2: flexcop: avoid unused function warnings

Arnd Bergmann <arnd@arndb.de>
    infiniband: cxgb4: use %pR format string for printing resources

Colin Ian King <colin.king@canonical.com>
    iio: adc: axp288: remove redundant duplicate const on axp288_adc_channels

Arnd Bergmann <arnd@arndb.de>
    ASoC: mediatek: add i2c dependency

Arnd Bergmann <arnd@arndb.de>
    genirq/msi: Add stubs for get_cached_msi_msg/pci_write_msi_msg

Arnd Bergmann <arnd@arndb.de>
    tty: cyclades: cyz_interrupt is only used for PCI

Paul Bolle <pebolle@tiscali.nl>
    drm/vmwgfx: use *_32_bits() macros

Arnd Bergmann <arnd@arndb.de>
    tlan: avoid unused label with PCI=n

Colin Ian King <colin.king@canonical.com>
    tc1100-wmi: fix build warning when CONFIG_PM not enabled

Arnd Bergmann <arnd@arndb.de>
    ipv4: ipconfig: avoid unused ic_proto_used symbol

Arnd Bergmann <arnd@arndb.de>
    netfilter: ipvs: avoid unused variable warnings

Borislav Petkov <bp@suse.de>
    x86/platform/olpc: Fix resume handler build warning

Glen Lee <glen.lee@atmel.com>
    staging: wilc1000: fix kbuild test robot error

Arnd Bergmann <arnd@arndb.de>
    rtlwifi: fix gcc-6 indentation warning

Arnd Bergmann <arnd@arndb.de>
    USB: cdc_subset: only build when one driver is enabled

Arnd Bergmann <arnd@arndb.de>
    hwrng: exynos - use __maybe_unused to hide pm functions

Arnd Bergmann <arnd@arndb.de>
    fbdev: sm712fb: avoid unused function warnings

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    Drivers: hv: vmbus: fix build warning

Arnd Bergmann <arnd@arndb.de>
    modsign: hide openssl output in silent builds

Arnd Bergmann <arnd@arndb.de>
    fbdev: s6e8ax0: avoid unused function warnings

Arnd Bergmann <arnd@arndb.de>
    mtd: cfi: enforce valid geometry configuration

Arnd Bergmann <arnd@arndb.de>
    mtd: sh_flctl: pass FIFO as physical address

Borislav Petkov <bp@suse.de>
    amd-xgbe: Fix unused suspend handlers build warning

Arnd Bergmann <arnd@arndb.de>
    fbdev: auo_k190x: avoid unused function warnings

Arnd Bergmann <arnd@arndb.de>
    driver-core: use 'dev' argument in dev_dbg_ratelimited stub

Arnd Bergmann <arnd@arndb.de>
    target/user: Fix cast from pointer to phys_addr_t

Arnd Bergmann <arnd@arndb.de>
    tty: hvc_xen: hide xen_console_remove when unused

Arnd Bergmann <arnd@arndb.de>
    usb: musb/ux500: remove duplicate check for dma_is_compatible

Arnd Bergmann <arnd@arndb.de>
    pwc: hide unused label

Arnd Bergmann <arnd@arndb.de>
    SCSI: initio: remove duplicate module device table

Arnd Bergmann <arnd@arndb.de>
    scsi: mvumi: use __maybe_unused to hide pm functions

Daniel Wagner <daniel.wagner@bmw-carit.de>
    video: Use bool instead int pointer for get_opt_bool() argument

Arnd Bergmann <arnd@arndb.de>
    fbdev: sis: enforce selection of at least one backend

Arnd Bergmann <arnd@arndb.de>
    staging: ste_rmi4: avoid unused function warnings

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    video: fbdev: sis: remove unused variable

Arnd Bergmann <arnd@arndb.de>
    scsi: fdomain: drop fdomain_pci_tbl when built-in

Arnd Bergmann <arnd@arndb.de>
    mptfusion: hide unused seq_mpt_print_ioc_summary function

Julia Lawall <julia.lawall@lip6.fr>
    mtd: maps: add __init attribute

Arnd Bergmann <arnd@arndb.de>
    mtd: ichxrom: maybe-uninitialized with gcc-4.9

Arnd Bergmann <arnd@arndb.de>
    md: avoid warning for 32-bit sector_t

Arnd Bergmann <arnd@arndb.de>
    profile: hide unused functions when !CONFIG_PROC_FS

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    dpt_i2o: fix build warning

Fabian Frederick <fabf@skynet.be>
    drivers/net: fix eisa_driver probe section mismatch

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    scsi: sim710: fix build warning

Arnd Bergmann <arnd@arndb.de>
    x86/boot: Avoid warning for zero-filling .bss

Arnd Bergmann <arnd@arndb.de>
    thermal: spear: use __maybe_unused for PM functions

Arnd Bergmann <arnd@arndb.de>
    ssb: mark ssb_bus_register as __maybe_unused

Arnd Bergmann <arnd@arndb.de>
    reiserfs: avoid a -Wmaybe-uninitialized warning

Arnd Bergmann <arnd@arndb.de>
    ALSA: hda/ca0132 - fix possible NULL pointer use

Kefeng Wang <wangkefeng.wang@huawei.com>
    arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set

Arnd Bergmann <arnd@arndb.de>
    scsi: advansys: fix uninitialized data access

Arnd Bergmann <arnd@arndb.de>
    x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG

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

Borislav Petkov <bp@suse.de>
    x86/ras/inject: Make it depend on X86_LOCAL_APIC=y

Arnd Bergmann <arnd@arndb.de>
    scsi: advansys: fix build warning for PCI=n

Arnd Bergmann <arnd@arndb.de>
    video: fbdev: via: remove possibly unused variables

Borislav Petkov <bp@suse.de>
    platform/x86: intel_mid_thermal: Fix suspend handlers unused warning

Augusto Mecking Caringi <augustocaringi@gmail.com>
    gpio: intel-mid: Fix build warning when !CONFIG_PM

Arnd Bergmann <arnd@arndb.de>
    vmxnet3: prevent building with 64K pages

Arnd Bergmann <arnd@arndb.de>
    isdn: icn: remove a #warning

Arnd Bergmann <arnd@arndb.de>
    virtio_balloon: prevent uninitialized variable use

Jia-Ju Bai <baijiaju1990@163.com>
    hippi: Fix a Fix a possible sleep-in-atomic bug in rr_close

Jan Beulich <JBeulich@suse.com>
    xen: XEN_ACPI_PROCESSOR is Dom0-only

Karol Herbst <kherbst@redhat.com>
    x86/mm/kmmio: Fix mmiotrace for page unaligned addresses

Dave Young <dyoung@redhat.com>
    mm/early_ioremap: Fix boot hang with earlyprintk=efi,keep

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

Eric Biggers <ebiggers3@gmail.com>
    509: fix printing uninitialized stack memory when OID is empty

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix possible off-by-one in btrfs_search_path_in_tree

Nogah Frankel <nogahf@mellanox.com>
    net_sched: red: Avoid illegal values

Nogah Frankel <nogahf@mellanox.com>
    net_sched: red: Avoid devision by zero

Zumeng Chen <zumeng.chen@gmail.com>
    gianfar: fix a flooded alignment reports because of padding issue.

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

Moni Shoua <monis@mellanox.com>
    RDMA/cma: Make sure that PSN is not over max allowed

Andre Przywara <andre.przywara@arm.com>
    pinctrl: sunxi: Fix A80 interrupt pin bank

Mauro Carvalho Chehab <mchehab@s-opensource.com>
    media: s5k6aa: describe some function parameters

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
    perf bench numa: Fixup discontiguous/sparse numa nodes

Jiri Olsa <jolsa@kernel.org>
    perf top: Fix window dimensions change handling

Peter Ujfalusi <peter.ujfalusi@ti.com>
    ARM: dts: am4372: Correct the interrupts_properties of McASP

Tony Lindgren <tony@atomide.com>
    ARM: dts: Fix omap4 hang with GPS connected to USB by using wakeupgen

Keerthy <j-keerthy@ti.com>
    ARM: AM33xx: PRM: Remove am33xx_pwrdm_read_prev_pwrst function

Tony Lindgren <tony@atomide.com>
    ARM: OMAP2+: Fix SRAM virt to phys translation for save_secure_ram_context

Randy Dunlap <rdunlap@infradead.org>
    usb: build drivers/usb/common/ when USB_SUPPORT is set

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: keep usbip_device sockfd state in sync with tcp_socket

Alexandru Ardelean <alexandru.ardelean@analog.com>
    staging: iio: adc: ad7192: fix external frequency setting

Eric Biggers <ebiggers@google.com>
    binder: check for binder_thread allocation failure in binder_poll()

Ben Hutchings <ben@decadent.org.uk>
    staging: android: ashmem: Fix a race condition in pin ioctls

Paolo Abeni <pabeni@redhat.com>
    dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Dave Jones <davej@codemonkey.org.uk>
    Make DST_CACHE a silent config option

Arnd Bergmann <arnd@arndb.de>
    arm64: dts: add #cooling-cells to CPU nodes

Arnd Bergmann <arnd@arndb.de>
    video: fbdev/mmp: add MODULE_LICENSE

Arnd Bergmann <arnd@arndb.de>
    ASoC: ux500: add MODULE_LICENSE tag

Willem de Bruijn <willemb@google.com>
    net: avoid skb_warn_bad_offload on IS_ERR

Cong Wang <xiyou.wangcong@gmail.com>
    netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Paolo Abeni <pabeni@redhat.com>
    netfilter: on sockopt() acquire sock lock only in the required scope

Dmitry Vyukov <dvyukov@google.com>
    netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()

Eric Dumazet <edumazet@google.com>
    netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{match|target}

Dmitry Vyukov <dvyukov@google.com>
    netfilter: x_tables: fix int overflow in xt_alloc_table_info()

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: x86: fix escape of guest dr6 to the host

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

Chris Wilson <chris@chris-wilson.co.uk>
    drm: Require __GFP_NOFAIL for the legacy drm_modeset_lock_all

Jens Axboe <axboe@kernel.dk>
    blktrace: fix unlocked registration of tracepoints

Cong Wang <xiyou.wangcong@gmail.com>
    xfrm: check id proto in validate_tmpl()

Steffen Klassert <steffen.klassert@secunet.com>
    xfrm: Fix stack-out-of-bounds read on socket policy lookup.

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    mm,vmscan: Make unregister_shrinker() no-op if register_shrinker() failed.

Johannes Berg <johannes.berg@intel.com>
    cfg80211: check dev_set_name() return value

Paolo Abeni <pabeni@redhat.com>
    net: replace dst_cache ip6_tunnel implementation with the generic one

Paolo Abeni <pabeni@redhat.com>
    net: add dst_cache support


-------------

Diffstat:

 Documentation/kernel-parameters.txt                |    2 -
 Documentation/speculation.txt                      |   90 ++
 Makefile                                           |   10 +-
 arch/arm/boot/dts/am4372.dtsi                      |    6 +-
 arch/arm/boot/dts/omap4.dtsi                       |    2 -
 arch/arm/mach-omap2/omap-secure.c                  |   19 +
 arch/arm/mach-omap2/omap-secure.h                  |    4 +
 arch/arm/mach-omap2/pm.h                           |    4 -
 arch/arm/mach-omap2/pm34xx.c                       |   13 +-
 arch/arm/mach-omap2/prm33xx.c                      |   12 -
 arch/arm/mach-omap2/sleep34xx.S                    |   26 +-
 arch/arm/mach-tegra/Kconfig                        |    2 -
 arch/arm64/Kconfig                                 |    2 +-
 arch/arm64/Kconfig.platforms                       |    2 -
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |    2 +
 arch/arm64/include/asm/bug.h                       |   33 +-
 arch/m68k/kernel/vmlinux-nommu.lds                 |    2 +
 arch/m68k/kernel/vmlinux-std.lds                   |    2 +
 arch/m68k/kernel/vmlinux-sun3.lds                  |    2 +
 arch/powerpc/perf/core-book3s.c                    |    4 +-
 arch/x86/Kconfig                                   |    2 +-
 arch/x86/Kconfig.debug                             |    1 +
 arch/x86/boot/Makefile                             |    5 +-
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S       |  112 +-
 arch/x86/entry/common.c                            |    2 +
 arch/x86/include/asm/asm-prototypes.h              |    1 -
 arch/x86/include/asm/barrier.h                     |   28 +
 arch/x86/include/asm/microcode_amd.h               |    1 -
 arch/x86/include/asm/msr.h                         |    3 +-
 arch/x86/include/asm/nospec-branch.h               |    8 +-
 arch/x86/include/asm/vmx.h                         |    5 +-
 arch/x86/kernel/alternative.c                      |   14 -
 arch/x86/kernel/cpu/bugs.c                         |  122 +-
 arch/x86/kernel/cpu/mcheck/mce-inject.c            |    5 +-
 arch/x86/kernel/cpu/microcode/amd.c                |   17 +-
 arch/x86/kernel/cpu/perf_event.c                   |    4 +-
 arch/x86/kernel/head_32.S                          |    9 +-
 arch/x86/kvm/Kconfig                               |    3 +-
 arch/x86/kvm/emulate.c                             |    9 +-
 arch/x86/kvm/vmx.c                                 |   83 +-
 arch/x86/kvm/x86.c                                 |   40 +-
 arch/x86/lib/getuser.S                             |   10 +
 arch/x86/lib/retpoline.S                           |    1 -
 arch/x86/math-emu/Makefile                         |    4 +-
 arch/x86/math-emu/reg_compare.c                    |   16 +-
 arch/x86/mm/ioremap.c                              |    4 +-
 arch/x86/mm/kmmio.c                                |   12 +-
 arch/x86/platform/olpc/olpc-xo15-sci.c             |    2 +
 certs/Makefile                                     |   33 +-
 drivers/Makefile                                   |    1 +
 drivers/android/binder.c                           |    2 +
 drivers/char/hw_random/exynos-rng.c                |   10 +-
 drivers/crypto/s5p-sss.c                           |   13 +-
 drivers/dma/at_hdmac.c                             |    4 +-
 drivers/dma/dma-jz4740.c                           |    4 +-
 drivers/dma/ioat/init.c                            |    2 +-
 drivers/dma/zx296702_dma.c                         |    2 +-
 drivers/gpio/gpio-intel-mid.c                      |    2 +-
 drivers/gpio/gpio-xgene.c                          |   13 +-
 drivers/gpu/drm/armada/armada_crtc.c               |   25 +-
 drivers/gpu/drm/drm_modeset_lock.c                 |    2 +-
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c             |   10 +-
 drivers/gpu/drm/gma500/mdfld_dsi_output.c          |   12 +-
 drivers/gpu/drm/nouveau/nouveau_gem.c              |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c             |    7 +-
 drivers/hv/hv.c                                    |    5 +-
 drivers/i2c/i2c-boardinfo.c                        |    4 +-
 drivers/idle/Kconfig                               |    1 +
 drivers/iio/adc/axp288_adc.c                       |    2 +-
 drivers/infiniband/core/cma.c                      |    1 +
 drivers/infiniband/hw/cxgb4/device.c               |    5 +-
 drivers/input/keyboard/tca8418_keypad.c            |   21 +-
 drivers/isdn/hardware/eicon/message.c              |   16 +-
 drivers/isdn/icn/icn.c                             |    2 +-
 drivers/isdn/sc/init.c                             |    7 +-
 drivers/md/md.c                                    |   10 +-
 drivers/media/common/b2c2/flexcop-fe-tuner.c       |    4 +-
 drivers/media/i2c/s5k6aa.c                         |    5 +
 drivers/media/i2c/tc358743.c                       |   46 +-
 drivers/media/usb/em28xx/Kconfig                   |    2 +-
 drivers/media/usb/go7007/Kconfig                   |    2 +-
 drivers/media/usb/hdpvr/hdpvr-core.c               |    2 +
 drivers/media/usb/pwc/pwc-if.c                     |    2 +
 drivers/media/v4l2-core/Kconfig                    |    1 -
 drivers/message/fusion/mptbase.c                   |    2 +
 drivers/mtd/chips/Kconfig                          |    4 +
 drivers/mtd/maps/ck804xrom.c                       |    4 +-
 drivers/mtd/maps/esb2rom.c                         |    4 +-
 drivers/mtd/maps/ichxrom.c                         |   10 +-
 drivers/mtd/nand/sh_flctl.c                        |    5 +-
 drivers/net/Kconfig                                |    3 +
 drivers/net/ethernet/3com/3c509.c                  |    2 +-
 drivers/net/ethernet/3com/3c59x.c                  |    2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-main.c          |    4 +-
 drivers/net/ethernet/dec/tulip/de4x5.c             |    2 +-
 drivers/net/ethernet/freescale/gianfar.c           |    6 +-
 drivers/net/ethernet/hp/hp100.c                    |   20 +-
 drivers/net/ethernet/ti/tlan.c                     |    2 +-
 drivers/net/hippi/rrunner.c                        |    2 +-
 drivers/net/ipvlan/ipvlan_core.c                   |    1 +
 drivers/net/usb/Kconfig                            |   10 +
 drivers/net/usb/Makefile                           |    2 +-
 drivers/net/wireless/cw1200/cw1200_spi.c           |    9 +-
 drivers/net/wireless/cw1200/pm.h                   |    9 +-
 drivers/net/wireless/cw1200/wsm.c                  |    8 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/dm.c    |    6 +-
 drivers/pinctrl/sunxi/pinctrl-sun9i-a80.c          |    6 +-
 drivers/platform/x86/Kconfig                       |    2 +
 drivers/platform/x86/intel_mid_thermal.c           |    2 +
 drivers/platform/x86/tc1100-wmi.c                  |    2 +
 drivers/power/Kconfig                              |    1 +
 drivers/power/bq27xxx_battery.c                    |    6 +-
 drivers/s390/block/dasd_eckd.c                     |   16 +-
 drivers/scsi/advansys.c                            |   24 +-
 drivers/scsi/dpt_i2o.c                             |    3 +
 drivers/scsi/fdomain.c                             |    2 +-
 drivers/scsi/g_NCR5380.c                           |    5 +-
 drivers/scsi/initio.c                              |   16 -
 drivers/scsi/mvumi.c                               |    4 +-
 drivers/scsi/sim710.c                              |    3 +-
 drivers/spi/spi-sun4i.c                            |    2 +-
 drivers/ssb/main.c                                 |    7 +-
 drivers/staging/android/ashmem.c                   |   19 +-
 drivers/staging/android/ion/ion_system_heap.c      |    2 +-
 drivers/staging/iio/adc/ad7192.c                   |   27 +-
 drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c      |    7 +-
 drivers/staging/unisys/visorinput/Kconfig          |    2 +-
 drivers/staging/wilc1000/wilc_wlan_if.h            |    1 +
 drivers/target/target_core_user.c                  |    2 +-
 drivers/thermal/Kconfig                            |    4 +-
 drivers/thermal/spear_thermal.c                    |    6 +-
 drivers/tty/Kconfig                                |    2 +-
 drivers/tty/hvc/hvc_xen.c                          |    2 +-
 drivers/tty/serial/8250/Kconfig                    |    2 +-
 drivers/usb/host/Kconfig                           |    2 +
 drivers/usb/musb/ux500_dma.c                       |    3 -
 drivers/usb/phy/Kconfig                            |    1 +
 drivers/usb/usbip/stub_dev.c                       |    3 +
 drivers/usb/usbip/vhci_hcd.c                       |    2 +
 drivers/video/fbdev/Kconfig                        |    1 +
 drivers/video/fbdev/auo_k190x.c                    |   11 +-
 drivers/video/fbdev/exynos/s6e8ax0.c               |   13 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c           |    2 +-
 drivers/video/fbdev/mmp/core.c                     |    5 +
 drivers/video/fbdev/sis/init301.c                  |   10 +-
 drivers/video/fbdev/sm712fb.c                      |   16 +-
 drivers/video/fbdev/via/viafbdev.c                 |    8 +-
 drivers/virtio/virtio_balloon.c                    |    2 +
 drivers/xen/Kconfig                                |    2 +-
 fs/btrfs/ioctl.c                                   |    2 +-
 fs/compat_binfmt_elf.c                             |    2 +
 fs/ncpfs/dir.c                                     |    3 +-
 fs/reiserfs/lbalance.c                             |    2 +-
 fs/reiserfs/reiserfs.h                             |    1 -
 include/linux/device.h                             |    7 +-
 include/linux/fdtable.h                            |    5 +-
 include/linux/init.h                               |    9 +-
 include/linux/module.h                             |    9 +
 include/linux/msi.h                                |   11 +-
 include/linux/mtd/sh_flctl.h                       |    1 +
 include/linux/nospec.h                             |   72 +
 include/linux/string.h                             |    1 +
 include/net/dst_cache.h                            |   97 ++
 include/net/ip6_tunnel.h                           |   15 +-
 include/net/netlink.h                              |   73 +-
 include/net/red.h                                  |   13 +-
 include/trace/events/clk.h                         |    4 +-
 kernel/module.c                                    |   11 +
 kernel/profile.c                                   |    4 +-
 kernel/trace/blktrace.c                            |   32 +-
 lib/Kconfig.debug                                  |    2 +-
 lib/oid_registry.c                                 |    8 +-
 mm/early_ioremap.c                                 |    2 +-
 mm/util.c                                          |   24 +
 mm/vmscan.c                                        |    3 +
 net/Kconfig                                        |    4 +
 net/core/Makefile                                  |    1 +
 net/core/dev.c                                     |    2 +-
 net/core/dst_cache.c                               |  168 ++
 net/decnet/af_decnet.c                             |   62 +-
 net/ipv4/ip_sockglue.c                             |   14 +-
 net/ipv4/ipconfig.c                                |    4 +
 net/ipv4/netfilter/ipt_CLUSTERIP.c                 |   16 +-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c     |    6 +-
 net/ipv6/Kconfig                                   |    1 +
 net/ipv6/ip6_gre.c                                 |   12 +-
 net/ipv6/ip6_tunnel.c                              |  149 +-
 net/ipv6/ip6_vti.c                                 |    2 +-
 net/ipv6/ipv6_sockglue.c                           |   17 +-
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c     |   18 +-
 net/netfilter/ipvs/ip_vs_app.c                     |    8 +-
 net/netfilter/ipvs/ip_vs_ctl.c                     |   15 +-
 net/netfilter/x_tables.c                           |   10 +-
 net/netfilter/xt_RATEEST.c                         |   22 +-
 net/sched/sch_choke.c                              |    3 +
 net/sched/sch_gred.c                               |    3 +
 net/sched/sch_red.c                                |    2 +
 net/sched/sch_sfq.c                                |    3 +
 net/wireless/core.c                                |    8 +-
 net/wireless/nl80211.c                             |    9 +-
 net/xfrm/xfrm_policy.c                             |    8 +-
 net/xfrm/xfrm_user.c                               |   24 +
 scripts/genksyms/parse.tab.c_shipped               | 1682 +++++++++-----------
 scripts/genksyms/parse.tab.h_shipped               |  133 +-
 scripts/genksyms/parse.y                           |    2 -
 scripts/kernel-doc                                 |    2 +-
 scripts/mod/modpost.c                              |    9 +
 security/selinux/ss/services.c                     |   21 +-
 sound/pci/hda/patch_ca0132.c                       |    3 +
 sound/soc/intel/Kconfig                            |    7 +-
 sound/soc/mediatek/Kconfig                         |    4 +-
 sound/soc/rockchip/rockchip_spdif.c                |   22 +-
 sound/soc/ux500/mop500.c                           |    4 +
 sound/soc/ux500/ux500_pcm.c                        |    5 +
 tools/build/Makefile.build                         |   10 +
 tools/perf/bench/numa.c                            |   56 +-
 tools/perf/builtin-top.c                           |   15 +-
 tools/scripts/Makefile.include                     |   12 +-
 218 files changed, 2535 insertions(+), 1875 deletions(-)
