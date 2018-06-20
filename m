Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89190C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E522083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 04:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="dfvUoqNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24E522083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbeFTEmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 00:42:35 -0400
Received: from ozlabs.org ([203.11.71.1]:59947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeFTEma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 00:42:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 419XHm2nGdz9s4n;
        Wed, 20 Jun 2018 14:42:28 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529469748;
        bh=otWP/1pw9m8mHoskLLa7HuE9bVcIU7EzTf2/pJA4vu8=;
        h=Date:From:To:Cc:Subject:From;
        b=dfvUoqNVCJzFHmMQjgfiC9mPoStMlboCXoE6SugOhpLRHWTEscLMaLs/MMq5MuCvb
         hG9SkZCMgRyyeAXfcQvZIU2Xip1rFruP8RPTzQe94SYJ1RdPSehADd75xsyPRClm45
         4fP22aoxCbIwvCWaunKKNSNj5niwstATGcoUldDPJiT8b0CjVap7Cd/uuNSF8JSHfA
         Q67aVRqXELQZ41VdG45COMzi94iXllT8iFczqaUG7XAZKehAMeIWKUZXTOse50o2Rq
         bSlKvgjXtOHlkn53Kysg2/5jABSqyOQKcvxQJV+i1vzS8e0LhncAW4/WyQQGaSMIXK
         1VoASVoHPUcqg==
Date:   Wed, 20 Jun 2018 14:42:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 20
Message-ID: <20180620144227.18bab881@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/l8aDJSi=2Y=NSpttFCSI2C1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/l8aDJSi=2Y=NSpttFCSI2C1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180619:

Undropped tree: userns

The userns tree gained conflicts against the vfs tree.

The akpm-current tree gained a conflict against the scsi tree.

Non-merge commits (relative to Linus' tree): 1399
 1468 files changed, 45747 insertions(+), 23865 deletions(-)

----------------------------------------------------------------------------

I have created today's linux-next tree at
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
(patches at http://www.kernel.org/pub/linux/kernel/next/ ).  If you
are tracking the linux-next tree using git, you should not use "git pull"
to do so as that will try to merge the new linux-next release with the
old one.  You should use "git fetch" and checkout or reset to the new
master.

You can see which trees have been included by looking in the Next/Trees
file in the source.  There are also quilt-import.log and merge.log
files in the Next directory.  Between each merge, the tree was built
with a ppc64_defconfig for powerpc, an allmodconfig for x86_64, a
multi_v7_defconfig for arm and a native build of tools/perf. After
the final fixups (if any), I do an x86_64 modules_install followed by
builds for x86_64 allnoconfig, powerpc allnoconfig (32 and 64 bit),
ppc44x_defconfig, allyesconfig and pseries_le_defconfig and i386, sparc
and sparc64 defconfig. And finally, a simple boot test of the powerpc
pseries_le_defconfig kernel in qemu (with and without kvm enabled).

Below is a summary of the state of the merge.

I am currently merging 279 trees (counting Linus' and 64 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

--=20
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.co=
m/kleikamp/linux-shaggy)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (ce397d215ccd Linux 4.18-rc1)
Merging arc-current/for-curr (e6c62399504c ARCv2: support manual regfile sa=
ve on interrupts)
Merging arm-current/fixes (92d44a42af81 ARM: fix kill( ,SIGFPE) breakage)
Merging arm64-fixes/for-next/fixes (b154886f7892 arm64: make secondary_star=
t_kernel() notrace)
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (faf37c44a105 powerpc/64s: Clear PCR on boot)
Merging sparc/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel=
.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (7e85dc8cb35a net_sched: blackhole: tell upper qdisc abo=
ut dropped packets)
Merging bpf/master (7e85dc8cb35a net_sched: blackhole: tell upper qdisc abo=
ut dropped packets)
Merging ipsec/master (45c180bc29ba xfrm_user: prevent leaking 2 bytes of ke=
rnel memory)
Merging netfilter/master (ad9852af9758 netfilter: nf_ct_helper: Fix possibl=
e panic after nf_conntrack_helper_unregister)
Merging ipvs/master (312564269535 net: netsec: reduce DMA mask to 40 bits)
Merging wireless-drivers/master (755abd247a3d MAINTAINERS: update Xinming's=
 email address)
Merging mac80211/master (bf2b61a6838f cfg80211: fix rcu in cfg80211_unregis=
ter_wdev)
Merging rdma-fixes/for-rc (375dc53d032f IB/rxe: Fix missing completion for =
mem_reg work requests)
Merging sound-current/for-linus (a57a46b93244 ALSA: hda/ca0132: Fix DMic da=
ta rate for Alienware M17x R4)
Merging sound-asoc-fixes/for-linus (e6eac9600614 Merge branch 'asoc-4.18' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (ce397d215ccd Linux 4.18-rc1)
Merging regulator-fixes/for-linus (4f687fb1244b Merge branch 'regulator-4.1=
8' into regulator-linus)
Merging spi-fixes/for-linus (95a7bdea2f84 Merge branch 'spi-4.18' into spi-=
linus)
Merging pci-current/for-linus (ce397d215ccd Linux 4.18-rc1)
Merging driver-core.current/driver-core-linus (ce397d215ccd Linux 4.18-rc1)
Merging tty.current/tty-linus (ce397d215ccd Linux 4.18-rc1)
Merging usb.current/usb-linus (ce397d215ccd Linux 4.18-rc1)
Merging usb-gadget-fixes/fixes (1d8e5c002758 dwc2: gadget: Fix ISOC IN DDMA=
 PID bitfield value calculation)
Merging usb-serial-fixes/usb-linus (24160628a34a USB: serial: cp210x: add C=
ESINEL device ids)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (60cc43fc8884 Linux 4.17-rc1)
Merging staging.current/staging-linus (ce397d215ccd Linux 4.18-rc1)
Merging char-misc.current/char-misc-linus (ce397d215ccd Linux 4.18-rc1)
Merging input-current/for-linus (01f7e67a053f Merge branch 'next' into for-=
linus)
Merging crypto-current/master (837bf7cc3b75 hwrng: core - Always drop the R=
NG in hwrng_unregister())
Merging ide/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/abelloni/linux)
Merging vfio-fixes/for-linus (08ca1b52f69b vfio/pci: Make IGD support a con=
figurable option)
Merging kselftest-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (356073bcf6db MAINTAINERS: Update email-id of=
 Sinan Kaya)
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711=
_bl: fix device-tree node leaks)
Merging mtd-fixes/master (ce397d215ccd Linux 4.18-rc1)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (11799564fc7e mfd: cros_ec: Retry commands =
when EC is known to be busy)
Merging v4l-dvb-fixes/fixes (e88f5e9ebd54 media: uvcvideo: Prevent setting =
unavailable flags)
Merging reset-fixes/reset/fixes (e6914365fd28 reset: uniphier: fix USB cloc=
k line for LD20)
Merging mips-fixes/mips-fixes (2a027b47dba6 MIPS: BCM47XX: Enable 74K Core =
ExternalSync for PCIe erratum)
Merging omap-fixes/fixes (41bd6adf3c5d Revert "ARM: dts: logicpd-som-lv: Fi=
x pinmux controller references")
Merging kvm-fixes/master (696ca779a928 KVM: x86: fix #UD address of failed =
Hyper-V hypercalls)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (91bb8f45f73f hwmon: (nct6775) Fix loop limit)
Merging nvdimm-fixes/libnvdimm-fixes (75bc37fefc44 Linux 4.17-rc4)
Merging btrfs-fixes/next-fixes (7b0aeeea4309 Merge branch 'misc-4.18' into =
next-fixes)
Merging vfs-fixes/fixes (b1b94fcbd399 Revert "fs: fold open_check_o_direct =
into do_dentry_open")
Merging dma-mapping-fixes/for-linus (cf65a0f6f6ff dma-mapping: move all DMA=
 mapping code to kernel/dma)
Merging drivers-x86-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging samsung-krzk-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (ce397d215ccd Linux 4.18-rc1)
Merging devicetree-fixes/dt/linus (737dd8e1a4c4 Documentation: devicetree: =
tilcdc: fix spelling mistake "suppors" -> "supports")
Merging scsi-fixes/fixes (52ab9768f723 scsi: scsi_debug: Fix memory leak on=
 module unload)
Merging drm-intel-fixes/for-linux-next-fixes (7a3727f385dc drm/i915: Enable=
 provoking vertex fix on Gen9 systems.)
Merging mmc-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging rtc-fixes/rtc-fixes (ce397d215ccd Linux 4.18-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (58b3d02f066e Revert "drm/sun4i=
: Handle DRM_BUS_FLAG_PIXDATA_*EDGE")
Merging kbuild/for-next (ce397d215ccd Linux 4.18-rc1)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (2550bbfd4952 dma-direct: don't crash on devic=
e without dma_mask)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (0ac000e86703 Merge branches 'fixes', 'misc' and 'spec=
tre' into for-linus)
Merging arm-perf/for-next/perf (ce397d215ccd Linux 4.18-rc1)
Merging arm-soc/for-next (c7953e19db50 ARM: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (793d8ab66802 Merge branch 'v4.18/defconfig' into =
tmp/aml-rebuild)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (20d3f36b0fea Merge tag 'at91-ab-4.17-dt2' into at91=
-next)
Merging bcm2835/for-next (5c483a0c319c Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
Merging imx-mxs/for-next (9a403db14975 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (fb5d812c3cb3 Merge branch 'for_4.18/keystone-dts' in=
to next)
Merging mediatek/for-next (9378b3427341 Merge branch 'v4.17-next/soc' into =
for-next)
Merging mvebu/for-next (78e5d8c26c70 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (1b7e42c1dfe8 Merge branch 'omap-for-v4.18/soc' into =
for-next)
Merging reset/reset/next (d7bab65b1f57 reset: uniphier: add LD11/LD20 strea=
m demux system reset control)
Merging qcom/for-next (509d20563e5d firmware: qcom: scm: Fix crash in qcom_=
scm_call_atomic1())
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (55bb9da815fe Merge branches 'arm-defconfig-for-v4.19'=
, 'arm-soc-for-v4.19', 'arm-dt-for-v4.19', 'arm64-defconfig-for-v4.19', 'ar=
m64-dt-for-v4.19' and 'dt-bindings-for-v4.19' into next)
Merging rockchip/for-next (d5a5df7cf0ad Merge branch 'v4.18-armsoc/dts32-fi=
xes' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (ce397d215ccd Linux 4.18-rc1)
Merging sunxi/sunxi/for-next (9c2cc863c256 Merge branches 'sunxi/drivers-fo=
r-4.19' and 'sunxi/dt64-for-4.19' into sunxi/for-next)
Merging tegra/for-next (6de9ae597a79 Merge branch for-4.18/clk into for-nex=
t)
Merging arm64/for-next/core (0fe42512b2f0 arm64: Fix syscall restarting aro=
und signal suppressed by tracer)
Merging clk/clk-next (3827dd558187 Merge branch 'clk-core-duty-cycle' into =
clk-next)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (85fa2cc51104 c6x: pass endianness info to spars=
e)
Merging m68k/for-next (b12c8a70643f m68k: Set default dma mask for platform=
 devices)
Merging m68knommu/for-next (4067b4a40c3d m68k: fix "bad page state" oops on=
 ColdFire boot)
Merging microblaze/next (5cf8da7bc035 microblaze: Remove architecture heart=
 beat code)
Merging mips/mips-next (9202ed144c27 mips: ftrace: fix static function grap=
h tracing)
Merging nds32/next (a78945c357f5 nds32: Fix build error caused by configura=
tion flag rename)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (d56f3af9e801 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (8d40c754fbac parisc: Drop struct sigaction from=
 not exported header file)
Merging powerpc/next (ff5bc793e47b powerpc/64s/radix: Fix missing ptesync i=
n flush_cache_vmap)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (29dcea88779c Linux 4.17)
Merging s390/features (777c5c1c6084 s390: hypfs: use ktime_get_seconds() in=
stead of get_seconds())
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (5ec9121195a4 um: Fix raw interface options)
Merging xtensa/xtensa-for-next (ae6063c83634 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (a8c65bd24e2e Merge branch 'for-next-next-v4.1=
9-20180619' into for-next-20180619)
Merging ceph/master (23edca864951 rbd: flush rbd_dev->watch_dwork after wat=
ch is unregistered)
Merging cifs/for-next (ac9d2b006ed1 cifs: Silence uninitialized variable wa=
rning)
Merging configfs/for-next (707c62352909 configfs: use kvasprintf() instead =
of open-coding it)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (20a653d458c3 Merge fsnotify cleanups from Amir into =
for_next)
Merging ext4/dev (0238a85e379f ext4: add more mount time checks of the supe=
rblock)
Merging f2fs/dev (d54d35c501bc Merge tag 'f2fs-for-4.18' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging fuse/for-next (543b8f8662fe fuse: don't keep dead fuse_conn at fuse=
_fill_super().)
Merging jfs/jfs-next (bd646104ac5a jfs: use time64_t for otime)
Merging nfs/linux-next (0dae72d581df sunrpc: Prevent duplicate XID allocati=
on)
Merging nfs-anna/linux-next (ffbfa2ce88f1 sunrpc: Fix latency trace point c=
rashes)
Merging nfsd/nfsd-next (8163496e78db nfsd: don't advertise a SCSI layout fo=
r an unsupported request_queue)
Merging orangefs/for-next (b1116bc03c00 orangefs: use sparse annotations fo=
r holding locks across function calls.)
Merging overlayfs/overlayfs-next (46311f3ec53c ovl: Enable metadata only fe=
ature)
Merging ubifs/linux-next (f5a926dd5298 mtd: ubi: Update ubi-media.h to dual=
 license)
Merging xfs/for-next (89e9b5c0915a xfs: update incore per-AG inode count)
Merging file-locks/locks-next (1cf8e5de4055 fs/lock: show locks taken by pr=
ocesses from another pidns)
Merging vfs/for-next (1f15c298fa29 Merge branch 'work.mount' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Applying: overlayfs: fix up for MS_ constants moving
Applying: scsi: cxlflash: update for fs_type->mount API change
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (ce041c43f222 lib/test_printf.c: accept "ptrval" as=
 valid result for plain 'p' tests)
Merging pci/next (ce397d215ccd Linux 4.18-rc1)
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (f1b6ae6701a7 Merge branch 'for-4.18/rmi' into for-nex=
t)
Merging i2c/i2c/for-next (ce397d215ccd Linux 4.18-rc1)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (06399c395108 hwmon: (nct7904) Fix UNSPECI=
FIED_INT warning)
Merging jc_docs/docs-next (a49d9c0ae46e Documentation: document hung_task_p=
anic kernel parameter)
Merging v4l-dvb/master (f2809d20b925 media: omap2: fix compile-testing with=
 FB_OMAP2=3Dm)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (85ebd164de56 fb_omap2: add gpiolib dependency)
Merging pm/linux-next (c64d64510912 Merge branch 'acpi-ec' into linux-next)
Merging cpupower/cpupower (ce397d215ccd Linux 4.18-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (c5c2a97b3ac7 PM / OPP: Update voltage in case f=
req =3D=3D old_freq)
Merging thermal/next (e9ed3ee61aa6 Merge branches 'thermal-core' and 'therm=
al-intel' into next)
Merging thermal-soc/next (6d7c70d1cd65 thermal: qcom: tsens: Allow number o=
f sensors to come from DT)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (33023fb85a42 IB/core: add max_send_sge and max_recv_=
sge attributes)
Merging net-next/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/davem/net)
Merging bpf-next/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/davem/net)
Merging ipsec-next/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/=
linux/kernel/git/davem/net)
Merging mlx5-next/mlx5-next (38b7ca927d6a net/mlx5: Expose DEVX specificati=
on)
Merging netfilter-next/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/net)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e523452ac0e0 netfilter: nf_tables: remove unused =
variables)
Merging wireless-drivers-next/master (4cf44d525548 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/davem/net)
Merging mac80211-next/master (8ba6731ad4c7 rfkill: add header files to MAIN=
TAINERS)
CONFLICT (content): Merge conflict in net/mac80211/scan.c
Merging gfs2/for-next (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linu=
x/kernel/git/davem/net)
Merging mtd/mtd/next (ce397d215ccd Linux 4.18-rc1)
Merging nand/nand/next (ce397d215ccd Linux 4.18-rc1)
Merging spi-nor/spi-nor/next (9882b5375df5 mtd: m25p80: Use SPI_MEM_OP_NO_D=
UMMY instead of SPI_MEM_OP_DUMMY(0, x))
Merging crypto/master (b268b3506d99 crypto: chtls - free beyond end rspq_sk=
b_cache)
Merging drm/drm-next (daf0678c2036 Merge branch 'drm-next-4.18' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (ac2bf28ad1a1 Merge tag 'gvt-next-2018-06-=
19' of https://github.com/intel/gvt-linux into drm-intel-next-queued)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_crt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem.c
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (069035c5db34 drm: Fix possible race condit=
ions while unplugging DRM device)
Merging drm-msm/msm-next (4dd454c371fd drm/msm/gpu: Increase the pm runtime=
 autosuspend for 5xx)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (6e810eb508f4 drm: mali-dp: Add YUV->R=
GB conversion support for video layers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (518665524272 gpu: ipu-csi: Check for field ty=
pe alternate)
Merging etnaviv/etnaviv/next (f6ffbd4fc1a1 drm/etnaviv: replace license tex=
t with SPDX tags)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (ce397d215ccd Linux 4.18-rc1)
Merging sound/for-next (6c5e1ac0e144 ALSA: firewire-motu: add support for M=
otu Traveler)
Merging sound-asoc/for-next (9a37ee20e492 Merge branch 'asoc-4.19' into aso=
c-next)
Merging modules/modules-next (9f2d1e68cf4d module: exclude SHN_UNDEF symbol=
s from kallsyms api)
Merging input/next (5aff29efbec0 Merge branch 'ib/4.17-xen-kbdfront-runtime=
-config' into next)
Merging block/for-next (28313cee1d4f Merge branch 'for-4.18/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (eaa87d09d34e dm thin metadata: remove needl=
ess work from __commit_transaction)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (ce397d215ccd Linux 4.18-rc1)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (bfc9dfdcb6e9 MD: cleanup resources in failure)
Merging mfd/for-mfd-next (556c242045f0 mfd: cros_ec: Remove unused __remove=
 function)
Merging backlight/for-backlight-next (980d7812fdb4 dt-bindings: pwm-backlig=
ht: Move brightness-levels to optional.)
Merging battery/for-next (ce397d215ccd Linux 4.18-rc1)
Merging regulator/for-next (3d6f3106e0d8 Merge branch 'regulator-4.19' into=
 regulator-next)
Merging security/next-testing (d19289133b1d Merge branch 'next-integrity' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into =
next-testing)
Merging apparmor/apparmor-next (338d0be437ef apparmor: fix ptrace read chec=
k)
Merging integrity/next-integrity (b5c90a7526fe EVM: unlock on error path in=
 evm_read_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (67b0b4e4988f selinux: Cleanup printk logging in netno=
de)
Merging tpmdd/next (e9234540d1fe tpm_tis_spi: Pass the SPI IRQ down to the =
driver)
Merging watchdog/master (16a7eec2fcd0 watchdog: da9063: remove duplicated t=
imeout_to_sel calls)
Merging iommu/next (1f568357117c Merge branches 'arm/io-pgtable', 'arm/qcom=
', 'arm/tegra', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (c1abca96b252 samples: mbochs: add DMA_SHARED_BUFFER depe=
ndency)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (f7859590d976 audit: eliminate audit_enabled magic numbe=
r comparison)
Merging devicetree/for-next (ac840f898808 dt-bindings: Add bitmain vendor p=
refix)
Merging mailbox/mailbox-for-next (f83d1cfc8bcd mailbox/drivers/hisi: Consol=
idate the Kconfig for the MAILBOX)
Merging spi/for-next (695ecff24964 Merge branch 'spi-4.19' into spi-next)
Merging tip/auto-latest (cc82cbbdd454 Merge branch 'x86/apic')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6c974d4dfafe EDAC, i7core: Fix memleaks and use-=
after-free on probe and remove)
Merging irqchip/irq/irqchip-next (6a88c221acba ARM: dts: stm32: Add exti su=
pport to stm32mp157 pinctrl)
Merging ftrace/for-next (a9235b544a0a ring-buffer: Fix typo in comment)
Merging rcu/rcu/next (443da8397d9f rcu: Make rcu_seq_diff() more exact)
CONFLICT (content): Merge conflict in drivers/iommu/amd_iommu.c
Merging kvm/linux-next (766d3571d8e5 kvm: fix typo in flag name)
Merging kvm-arm/next (e25028c8ded0 KVM: arm/arm64: Bump VGIC_V3_MAX_CPUS to=
 512)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (ce397d215ccd Linux 4.18-rc1)
Merging kvms390/next (2c8180e885c1 KVM: s390: vsie: simplify < 8k address c=
hecks)
Merging xen-tip/linux-next (7c63ca24c878 xen/scsiback: add error handling f=
or xenbus_printf)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (66448bc274ca workqueue: move function definiti=
ons within CONFIG_SMP block)
Merging drivers-x86/for-next (ce397d215ccd Linux 4.18-rc1)
Merging chrome-platform/for-next (c474e9f2be99 platform/chrome: chromeos_tb=
mc - fix SPDX identifier)
Merging hsi/for-next (ce397d215ccd Linux 4.18-rc1)
Merging leds/for-next (d30c8d203125 leds: ledtrig-activity: use ktime_get_b=
oot_ns())
Merging ipmi/for-next (ded74ec6b83f ipmi: Change to ktime_get_ts64())
Merging driver-core/driver-core-next (ce397d215ccd Linux 4.18-rc1)
Merging usb/usb-next (ce397d215ccd Linux 4.18-rc1)
Merging usb-gadget/next (47265c067c0d usb: dwc2: gadget: Fix coverity issue)
Merging usb-serial/usb-next (ce397d215ccd Linux 4.18-rc1)
Merging usb-chipidea-next/ci-for-usb-next (8bcf4c0bd7fb usb: chipidea: prop=
erly handle host or gadget initialization failure)
Merging phy-next/next (c1eb8f83845b phy: mediatek: add XS-PHY driver)
Merging tty/tty-next (ce397d215ccd Linux 4.18-rc1)
Merging char-misc/char-misc-next (ce397d215ccd Linux 4.18-rc1)
Merging extcon/extcon-next (441492c2256c extcon: Release locking when sendi=
ng the notification of connector state)
Merging staging/staging-next (3053339b17f8 staging: goldfish: Clear audio r=
ead buffer status after each read)
Merging mux/for-next (6a3d4baac84a mux: add mux_control_get_optional() API)
Merging slave-dma/next (047e55436f89 Merge branch 'topic/ioat' into next)
Merging cgroup/for-next (d8742e229021 cgroup: css_set_lock should nest insi=
de tasklist_lock)
Merging scsi/for-next (4795364a4959 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (20eea80e9574 scsi: libsas: dynamically allocate =
and free ata host)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (313c1b5a6bef Merge branch 'for-4.18-fixes' into fo=
r-next)
Merging vhost/linux-next (2eb98105f8c7 virtio: update the comments for tran=
sport features)
Merging rpmsg/for-next (ce397d215ccd Linux 4.18-rc1)
Merging gpio/for-next (8968e4ced9b1 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (1fd2a5dce0dc Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (ce397d215ccd Linux 4.18-rc1)
Merging pwm/for-next (414c52b7899a pwm: stm32: Fix build warning with CONFI=
G_DMA_ENGINE disabled)
Merging userns/for-next (04035aa33a12 proc: Don't change mount options on r=
emount failure.)
CONFLICT (content): Merge conflict in fs/proc/root.c
CONFLICT (content): Merge conflict in fs/proc/internal.h
CONFLICT (content): Merge conflict in fs/proc/inode.c
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (bfe80ed3d7c7 vsprintf: add command line option debug_bo=
ot_weak_hash)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (eb83d5f7d07e selftests: sparc64: Add missing SPDX L=
icense Identifiers)
Merging y2038/y2038 (e264abeaf9da pstore: Remove bogus format string defini=
tion)
Merging livepatching/for-next (d7ab8e67aa52 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (dd2e68bb385e coresight: Handle errors in finding in=
put/output ports)
Merging rtc/rtc-next (ce397d215ccd Linux 4.18-rc1)
Merging nvdimm/libnvdimm-for-next (d95363c95705 Merge branch 'for-4.18/dax-=
memory-failure' into libnvdimm-for-next)
Merging at24/at24/for-next (ce397d215ccd Linux 4.18-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (45888b40d2a6 rslib: Allocate decoder buffers to=
 avoid VLAs)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging xarray/xarray (1886ca9f6ee4 Fix filemap_range_has_page conversion t=
o XArray)
Applying: filesystem-dax: fixups for xaarray changes
Merging akpm-current/current (8b95a15d84a1 bfs: add sanity check at bfs_fil=
l_super())
CONFLICT (modify/delete): lib/percpu_ida.c deleted in HEAD and modified in =
akpm-current/current. Version akpm-current/current of lib/percpu_ida.c left=
 in tree.
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
$ git rm -f lib/percpu_ida.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: kernel/kexec_file.c: add walk_system_ram_res_rev()
Applying: kernel/kexec_file.c: load kernel at top of system RAM if required
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (ec8f1a0d468b sparc64: NG4 memset 32 bits overflow)

--Sig_/l8aDJSi=2Y=NSpttFCSI2C1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsp2zMACgkQAVBC80lX
0GzVvgf/VLfoJy9UpXK5r9yz9O9Dct1NWBqSl57TnRSSCT4OwtbXZsYYIpxDmVId
qDACEMCl1E9XAs415dNpSyoQSdv/Vnqqg7YlQKd6HuJFuTxOAUVTvmtvW1GHjeOC
LeSOoPG0cYwUsT4xunaeIks3UUsDuvhja7Lmh1bDqluW7+gD8SYLQROtDjQtPmwl
r2kahZcBZ/dB7c6DIP01ofu0hxShSXTHs9u0qr4voXF1UKpKtn0xyr4NN6rbQ8AM
92a1GjPRAqg5/FQWQNDQZfcbV4O9bId+a/Ds2JpIOJn+rKkrgISKMz6692Mjv6iN
2yb686JDhqgItj8vY++X08nRLh380g==
=oKoY
-----END PGP SIGNATURE-----

--Sig_/l8aDJSi=2Y=NSpttFCSI2C1--
