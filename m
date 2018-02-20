Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2727985-1519127858-2-15555615737365552837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519127857; b=o1verZv0rK1GC8LQryGX9MX5La4hgfhe90ybUeIB99hTD71
    dqEh/njfg5LWDlNYaBmdkak4XB5Mw//6xVkmeEj9J7NGS5wlz8sLOcEMEUdJnu9s
    YJRxcy6PnI6Fta4DQcs0OfDsGwLh8wJgd/ooQSUaAnsgTVJsxnQpVYgQNQYxYU9E
    Rkb69WquvqPcQ8siso9TbyuSGRbXwE7FsKra3R+AtWC9Lx1QOwQeZ4Sqq/yinjfk
    HEGZ1cEE16KHITpkS1KzN2y+EOvxvcD80ZM8apPIHZtGfBT1bB7LVWsyk1nQ+NHs
    90mtw2lOBUgyqDfQvk0WxryT12qL8a6ezXSmwtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519127857; bh=HpTgltzIl5a1jZUx2D5YfhZNJ4
    I3O0Y3qttvYXSb4q0=; b=YdRoASHQYQB3SAYDXclQVqnxg/Gx8L2/Xt0nUnnuUI
    zO7RFW+eu3ACOL19yT9vQQX/zcRbWYLwuYLd7arZHhaCNsvQT2tG8fnL0BK6pb7Z
    SKBS+aoNAZJ2jDDkMQGT0M4WjYgwPcNQ5Nm48JbaHodXXLmaRlq1kE+TFP2O2sNe
    9xMRpF5I2fPvBGRhI5SFwVGsOixRmQNwrl6o8NIXTOlmxcuU9h6yznLuD32ngHry
    Vxs7bK4aZIcIWaAjo3mjkl5qwvdLgE0ZNUpxr9iLDxYT7E8khb5H2wFY5+EyazHi
    MHkQIP+E+G5KoynC17KDyNtn+SUdA4AHcGe98YNoXbsg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751510AbeBTL5g (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:57:36 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:37805 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeBTL5e (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 06:57:34 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [4.4-stable 00/22] patches for 'randconfig'
Date: Tue, 20 Feb 2018 12:54:47 +0100
Message-Id: <20180220115527.1806578-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:MI9DU3MKEF9FgtDS7nEvUDtg0K1OKtYIOFQkoYacGVe+FSeZ+CH
 DZjwJ20coyUZhUldoSgwHZze3CDFw4UvK/nfH6AOSO/WZ9C9toYScrlPwx5YgF6IbWl5F+E
 +UJw5Fb/q3pn59ke1uYy+FCCpwc3GS5sVtllVM5gXjSf1tuHuuiUnZK4IDCaJllePHS0Hht
 xHxMHdSWjcmOtdSQnjUfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bo9FwH0yQdM=:3IIPZvJQBBiCd4ToUcC2Dr
 B/NdYIMps80zut7aLIe+GATl9rsu4AmGGega5OhLAVWAVUL4xtSfDjhH4YijOd8tQzGpEEgov
 ki3HZofiGt7MVNomwF3usBYx/0ugRTweLQSaOOZYiJMlz/NCtteYRB51rqgt7PP4S+bIRdLHl
 tx5GUZPGXlyjJux1lic39pUgLsAh8p83NXEsaVbgH/OQe16aQMuGSaWpUIMC4z2KvceuUsysg
 yLkzwWi2tud6xBnUTGQdLEuIuHLEF4FkxXMVG4/rnk1+3cLpRmrgyVfwtDNVo6PwOB2XteOhT
 UP1qN+xE0rW22lsQDRHieUEAORLmDkx63LNhYkMGMp9fp6HlLQb/VJNpVgGxy80JaLnLHixsF
 PVkQ+kvBdakQtlqp7ZEMAVtpY9c4uvg5qD9eSfJo8SbjFXQEKSHXGm4Cx/n2zZ6yfGOiJbXC7
 DFMwDLD0FC+X5ZjWEXcmINPsXL3RgfPwlOWegRJQ2VO5aoLVRInDByap9495MY92oG7Yw7kdC
 6nWjj3Ff3BfauToScbWCWn4SQ2rDf+QOris0g6R7eA8qb010flzwncvGv/t8kCc0QNpFtfNLR
 pPsaRqrwmaGdQCJ7n1B3/MS8yowuuTUAbsk+UErRW6lil55+BfqULbLzAsWeK8TKB9nTh4Z7r
 mgKis3IsKz3yQYY9xUl4MYBPS6bWRObTrZGBIV9VaXAHuACgPdFTJm7Q0iFooSFbyx4uictOC
 YYLL3jCmZIOB3fdRAAx4BWWqnH0ED3LfdmN/tzjLyPKDXzTrv6j+Ya/QVxg=
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Like the earlier series of randconfig build fixes for 4.9, this is the
equivalent for 4.4. Again, most of it is for harmless warnings, but there
are also fixes for excessive stack consumption that can be possibly
dangerous, and the 'genksyms' segfault fix is now needed to build the
backported 'retpoline' support.

Please backport these 89 commits from mainline, and apply the 22 patches
that needed manual changes.

4000fbea945c ("isdn: icn: remove a #warning")
f0bb2d50dfcc ("virtio_balloon: prevent uninitialized variable use")
b115bebc07f2 ("gpio: xgene: mark PM functions as __maybe_unused")
9a232de49996 ("ncpfs: fix unused variable warning")
747a11279a44 ("net: hp100: remove unnecessary #ifdefs")
067fdeb2f391 ("dmaengine: zx: fix build warning")
11d8b05855f3 ("perf/x86: Shut up false-positive -Wmaybe-uninitialized warning")
01ed1e1504ac ("isdn: icn: remove a #warning")
fbdf0e28d061 ("vmxnet3: prevent building with 64K pages")
fbc2a294f29e ("gpio: intel-mid: Fix build warning when !CONFIG_PM")
b4aca383f9af ("platform/x86: intel_mid_thermal: Fix suspend handlers unused warning")
484c7bbf2649 ("video: fbdev: via: remove possibly unused variables")
f46e7cd36b5f ("scsi: advansys: fix build warning for PCI=n")
d4b2ac63b0ea ("x86/ras/inject: Make it depend on X86_LOCAL_APIC=y")
f13d52cb3fad ("arm64: define BUG() instruction without CONFIG_BUG")
75e2f0a6b161 ("x86/fpu/math-emu: Fix possible uninitialized variable use")
e572d0887137 ("tools build: Add tools tree support for 'make -s'")
d460131dd505 ("x86/build: Silence the build with "make -s"")
68fd77cf8a4b ("thermal: fix INTEL_SOC_DTS_IOSF_CORE dependencies")
c2ce3f5d89d5 ("x86: add MULTIUSER dependency for KVM")
d689c64d189e ("x86/platform: Add PCI dependency for PUNIT_ATOM_DEBUG")
44a5b977128c ("scsi: advansys: fix uninitialized data access")
2e449048a25e ("arm64: Kconfig: select COMPAT_BINFMT_ELF only when BINFMT_ELF is set")
46a049dae771 ("ALSA: hda/ca0132 - fix possible NULL pointer use")
ab4949640d66 ("reiserfs: avoid a -Wmaybe-uninitialized warning")
b7e2d195cc52 ("ssb: mark ssb_bus_register as __maybe_unused")
d612c64d1f4d ("thermal: spear: use __maybe_unused for PM functions")
553bbc11aa6c ("x86/boot: Avoid warning for zero-filling .bss")
648a0a7da34f ("scsi: sim710: fix build warning")
cb4396edd84e ("drivers/net: fix eisa_driver probe section mismatch")
f50abb9b63b1 ("dpt_i2o: fix build warning")
ade356b99a41 ("profile: hide unused functions when !CONFIG_PROC_FS")
3312c951efab ("md: avoid warning for 32-bit sector_t")
e70dda0868fa ("mtd: ichxrom: maybe-uninitialized with gcc-4.9")
e4106a7c8236 ("mtd: maps: add __init attribute")
28558f5af50d ("mptfusion: hide unused seq_mpt_print_ioc_summary function")
120f83f8d6f2 ("scsi: fdomain: drop fdomain_pci_tbl when built-in")
32ad61951574 ("video: fbdev: sis: remove unused variable")
9045a4a7e686 ("staging: ste_rmi4: avoid unused function warnings")
5b833fea4377 ("fbdev: sis: enforce selection of at least one backend")
206fc2059815 ("video: Use bool instead int pointer for get_opt_bool() argument")
fddbeb80a904 ("scsi: mvumi: use __maybe_unused to hide pm functions")
d282e2b383e3 ("SCSI: initio: remove duplicate module device table")
1f6bcd011464 ("[media] pwc: hide unused label")
62a6abdd427b ("usb: musb/ux500: remove duplicate check for dma_is_compatible")
e36ae3439936 ("tty: hvc_xen: hide xen_console_remove when unused")
0633e123465b ("target/user: Fix cast from pointer to phys_addr_t")
1f62ff34a904 ("driver-core: use 'dev' argument in dev_dbg_ratelimited stub")
a8a31afad5ff ("fbdev: auo_k190x: avoid unused function warnings")
91eefaabf102 ("amd-xgbe: Fix unused suspend handlers build warning")
1873315fb156 ("mtd: sh_flctl: pass FIFO as physical address")
f5f92b36fbbb ("mtd: cfi: enforce valid geometry configuration")
b54729b6cea7 ("fbdev: s6e8ax0: avoid unused function warnings")
5d06ee20b662 ("modsign: hide openssl output in silent builds")
9220e39b5c90 ("Drivers: hv: vmbus: fix build warning")
24ed78dc2e8b ("fbdev: sm712fb: avoid unused function warnings")
b93f342da176 ("hwrng: exynos - use __maybe_unused to hide pm functions")
f3bb23764fac ("USB: cdc_subset: only build when one driver is enabled")
2acd84648554 ("rtlwifi: fix gcc-6 indentation warning")
b22fa80cdbf4 ("staging: wilc1000: fix kbuild test robot error")
20ab6677716c ("x86/platform/olpc: Fix resume handler build warning")
f6ca9f46f661 ("netfilter: ipvs: avoid unused variable warnings")
52b79e2bdf92 ("ipv4: ipconfig: avoid unused ic_proto_used symbol")
75d7e7d7a8f4 ("tc1100-wmi: fix build warning when CONFIG_PM not enabled")
1e09c106a44c ("tlan: avoid unused label with PCI=n")
0e7c875d1ae9 ("drm/vmwgfx: use *_32_bits() macros")
05ead49691d2 ("tty: cyclades: cyz_interrupt is only used for PCI")
2f44e29cef00 ("genirq/msi: Add stubs for get_cached_msi_msg/pci_write_msi_msg")
ec3995da27e7 ("ASoC: mediatek: add i2c dependency")
7ca6574a7afb ("iio: adc: axp288: remove redundant duplicate const on axp288_adc_channels")
3021376d6d12 ("infiniband: cxgb4: use %pR format string for printing resources")
733d0def3ebd ("[media] b2c2: flexcop: avoid unused function warnings")
836856e3bd61 ("wireless: cw1200: use __maybe_unused to hide pm functions_")
5abe9b26847c ("i2c: remove __init from i2c_register_board_info()")
82ddecfe8de5 ("staging: unisys: visorinput depends on INPUT")
3538aa6ecfb2 ("[media] tc358743: fix register i2c_rd/wr functions")
7fc1503c906f ("cw1200: fix bogus maybe-uninitialized warning")
b74c0a9969f2 ("drm/nouveau: hide gcc-4.9 -Wmaybe-uninitialized")
ea4348c8462a ("Input: tca8418_keypad - hide gcc-4.9 -Wmaybe-uninitialized warning")
16c3ada89cff ("media: r820t: fix r820t_write_reg for KASAN")
e42eef4ba388 ("KVM: add X86_LOCAL_APIC dependency")
fa6317eedd63 ("[media] go7007: add MEDIA_CAMERA_SUPPORT dependency")
190b23b4eb99 ("[media] em28xx: only use mt9v011 if camera support is enabled")
27d807180ae0 ("ISDN: eicon: reduce stack size of sig_ind function")
d8fc2198aab1 ("ASoC: rockchip: use __maybe_unused to hide st_irq_syscfg_resume")
0ff423058432 ("serial: 8250_mid: fix broken DMA dependency")
4f250706211c ("drm/gma500: Sanity-check pipe index")
b97baa3e22e1 ("[media] hdpvr: hide unused variable")
7c8fe516bd81 ("[media] v4l: remove MEDIA_TUNER dependency for VIDEO_TUNER")

      Arnd

Andy Lutomirski (1):
  dell-wmi, dell-laptop: depends DMI

Arnd Bergmann (15):
  gpio: xgene: mark PM functions as __maybe_unused
  Revert "power: bq27xxx_battery: Remove unneeded dependency in Kconfig"
  power: bq27xxx_battery: mark some symbols __maybe_unused
  isdn: sc: work around type mismatch warning
  binfmt_elf: compat: avoid unused function warning
  idle: i7300: add PCI dependency
  usb: phy: msm add regulator dependency
  ncr5380: shut up gcc indentation warning
  ARM: tegra: select USB_ULPI from EHCI rather than platform
  netlink: fix nla_put_{u8,u16,u32} for KASAN
  virtio_balloon: prevent uninitialized variable use
  perf/x86: Shut up false-positive -Wmaybe-uninitialized warning
  cw1200: fix bogus maybe-uninitialized warning
  net: hp100: remove unnecessary #ifdefs
  kasan: rework Kconfig settings

Borislav Petkov (1):
  x86/microcode/AMD: Change load_microcode_amd()'s param to bool to fix
    preemptibility bug

Jun Nie (1):
  dmaengine: zx: fix build warning

Michal Marek (1):
  genksyms: Fix segfault with invalid declarations

Miklos Szeredi (1):
  ncpfs: fix unused variable warning

Sudip Mukherjee (1):
  drm/gma500: remove helper function

Vinod Koul (1):
  ASoC: Intel: Kconfig: fix build when ACPI is not enabled

 arch/arm/mach-tegra/Kconfig               |    2 -
 arch/arm64/Kconfig.platforms              |    2 -
 arch/x86/include/asm/microcode_amd.h      |    1 -
 arch/x86/kernel/cpu/microcode/amd.c       |   17 +-
 arch/x86/kernel/cpu/perf_event.c          |    4 +-
 drivers/dma/zx296702_dma.c                |    2 +-
 drivers/gpio/gpio-xgene.c                 |   13 +-
 drivers/gpu/drm/gma500/mdfld_dsi_output.c |   12 +-
 drivers/idle/Kconfig                      |    1 +
 drivers/isdn/sc/init.c                    |    7 +-
 drivers/net/ethernet/hp/hp100.c           |   18 -
 drivers/net/wireless/cw1200/wsm.c         |    8 +-
 drivers/platform/x86/Kconfig              |    2 +
 drivers/power/Kconfig                     |    1 +
 drivers/power/bq27xxx_battery.c           |    6 +-
 drivers/scsi/g_NCR5380.c                  |    5 +-
 drivers/usb/host/Kconfig                  |    2 +
 drivers/usb/phy/Kconfig                   |    1 +
 drivers/virtio/virtio_balloon.c           |    3 +
 fs/compat_binfmt_elf.c                    |    2 +
 fs/ncpfs/dir.c                            |    3 +-
 include/net/netlink.h                     |   73 +-
 lib/Kconfig.debug                         |    2 +-
 scripts/genksyms/parse.tab.c_shipped      | 1682 ++++++++++++++---------------
 scripts/genksyms/parse.tab.h_shipped      |  133 +--
 scripts/genksyms/parse.y                  |    2 -
 sound/soc/intel/Kconfig                   |    7 +-
 27 files changed, 957 insertions(+), 1054 deletions(-)

-- 
2.9.0
