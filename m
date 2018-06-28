Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06583C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E3B26FAC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Y8j+vu5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83E3B26FAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeF1GUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:20:23 -0400
Received: from ozlabs.org ([203.11.71.1]:49409 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932094AbeF1GUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:20:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41GV4x2xGKz9s1B;
        Thu, 28 Jun 2018 16:20:17 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530166817;
        bh=VAfOJKdI2AlqecNtMtCME2EDrgszlZUjANutsFTZk/k=;
        h=Date:From:To:Cc:Subject:From;
        b=Y8j+vu5PwdH5vpCGzxmQ3manUIR1p2lSDxQ1a1YxU4kRGu5eOwFkaSsOmLoW1mk2C
         H/+aWpx0JlnStdqF8xL56vf3vQlzPYmUuxHBOJmYpQGa76HgcFd36vdjLNqPkvd8W/
         GZvifpi7AHcb5GwWhsFjBrXfZZxmyDdaK3JzFXK0HUIxKJAT9mUB04Kx9C3IvvnPKR
         xS2PEIhPGROoyiM1WcS2Wq7jJTmgxryw8jIJnCRSEzmc+x4W1u0kpRFuwEszoqNcfs
         1Hj5kjSf3yjVBlzUmDdD2u+M1q8//HXG3rbz5kBqTgf5243Z2Jm8HahNoggQ5xTOXq
         aWZmwbBPJ2Zbw==
Date:   Thu, 28 Jun 2018 16:20:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 28
Message-ID: <20180628162016.114e6655@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WmS3mKlr9rLkJl+6y9ZwdTX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WmS3mKlr9rLkJl+6y9ZwdTX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180627:

The sunxi tree gained a build failure so I used the version from
next-20180627.

The btrfs-kdave tree gained a build failure so I used the version from
next-20180626.

The drm tree lost its build failure.

The xarray tree gained a conflict against the wireless-drivers-next tree.

Non-merge commits (relative to Linus' tree): 2513
 2732 files changed, 87273 insertions(+), 42976 deletions(-)

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

I am currently merging 281 trees (counting Linus' and 65 trees of bug
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
Merging origin/master (f57494321cbf Merge tag 'xfs-4.18-fixes-2' of git://g=
it.kernel.org/pub/scm/fs/xfs/xfs-linux)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (bcb3726a6034 kbuild: reword help of LD_DEAD_C=
ODE_DATA_ELIMINATION)
Merging arc-current/for-curr (6ddb19a32e79 ARC: Improve cmpxchg syscall imp=
lementation)
Merging arm-current/fixes (92d44a42af81 ARM: fix kill( ,SIGFPE) breakage)
Merging arm64-fixes/for-next/fixes (7838306f5ace Merge branch 'perf/fixes' =
of git://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (22db552b50fa powerpc/powermac: Fix rtc read/wr=
ite functions)
Merging sparc/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel=
.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (2d2595719a97 nfp: cast sizeof() to int when comparing w=
ith error code)
Merging bpf/master (dd349c3ffd93 selftests: bpf: notification about privile=
ge required to run test_lwt_seg6local.sh testing script)
Merging ipsec/master (7284fdf39a91 esp6: fix memleak on error path in esp6_=
input)
Merging netfilter/master (b36e4523d4d5 netfilter: nf_conncount: fix garbage=
 collection confirm race)
Merging ipvs/master (312564269535 net: netsec: reduce DMA mask to 40 bits)
Merging wireless-drivers/master (92963318a255 mt7601u: remove warning when =
avg_rssi is zero)
Merging mac80211/master (bf2b61a6838f cfg80211: fix rcu in cfg80211_unregis=
ter_wdev)
Merging rdma-fixes/for-rc (b697d7d8c741 IB/hfi1: Fix incorrect mixing of ER=
R_PTR and NULL return values)
Merging sound-current/for-linus (4fb88a15f5dd ALSA: hda - Handle pm failure=
 during hotplug)
Merging sound-asoc-fixes/for-linus (cf6c692c746c Merge branch 'asoc-4.18' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (7daf201d7fe8 Linux 4.18-rc2)
Merging regulator-fixes/for-linus (bd4929a3ac1e Merge branch 'regulator-4.1=
8' into regulator-linus)
Merging spi-fixes/for-linus (58c2ec73d535 Merge branch 'spi-4.18' into spi-=
linus)
Merging pci-current/for-linus (925d31668d5b PCI: controller: Move PCI_DOMAI=
NS selection to arch Kconfig)
Merging driver-core.current/driver-core-linus (7daf201d7fe8 Linux 4.18-rc2)
Merging tty.current/tty-linus (ce397d215ccd Linux 4.18-rc1)
Merging usb.current/usb-linus (90f26cc6bb90 usb: chipidea: host: fix discon=
nection detect issue)
Merging usb-gadget-fixes/fixes (1d8e5c002758 dwc2: gadget: Fix ISOC IN DDMA=
 PID bitfield value calculation)
Merging usb-serial-fixes/usb-linus (24160628a34a USB: serial: cp210x: add C=
ESINEL device ids)
Merging usb-chipidea-fixes/ci-for-usb-stable (90f26cc6bb90 usb: chipidea: h=
ost: fix disconnection detect issue)
Merging phy/fixes (ce397d215ccd Linux 4.18-rc1)
Merging staging.current/staging-linus (ebc2dc5f9b23 Merge tag 'iio-fixes-4.=
18a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into stagin=
g-linus)
Merging char-misc.current/char-misc-linus (7daf201d7fe8 Linux 4.18-rc2)
Merging input-current/for-linus (03ae3a9caf4a Input: psmouse - fix button r=
eporting for basic protocols)
Merging crypto-current/master (837bf7cc3b75 hwrng: core - Always drop the R=
NG in hwrng_unregister())
Merging ide/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/abelloni/linux)
Merging vfio-fixes/for-linus (7733e05b34f5 sample/mdev/mbochs: add mbochs_k=
unmap_dmabuf)
Merging kselftest-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (356073bcf6db MAINTAINERS: Update email-id of=
 Sinan Kaya)
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711=
_bl: fix device-tree node leaks)
Merging mtd-fixes/master (3f6e6986045d mtd: rawnand: denali_dt: set clk_x_r=
ate to 200 MHz unconditionally)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (11799564fc7e mfd: cros_ec: Retry commands =
when EC is known to be busy)
Merging v4l-dvb-fixes/fixes (0ca54b290541 media: rc: be less noisy when dri=
ver misbehaves)
Merging reset-fixes/reset/fixes (e6914365fd28 reset: uniphier: fix USB cloc=
k line for LD20)
Merging mips-fixes/mips-fixes (662d855c66c0 MIPS: Add ksig argument to rseq=
_{signal_deliver,handle_notify_resume})
Merging omap-fixes/fixes (41bd6adf3c5d Revert "ARM: dts: logicpd-som-lv: Fi=
x pinmux controller references")
Merging kvm-fixes/master (2ddc64981013 KVM: fix KVM_CAP_HYPERV_TLBFLUSH par=
agraph number)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (7daf201d7fe8 Linux 4.18-rc2)
Merging nvdimm-fixes/libnvdimm-fixes (75bc37fefc44 Linux 4.17-rc4)
Merging btrfs-fixes/next-fixes (03a4f726ad37 Merge branch 'misc-4.18' into =
next-fixes)
Merging vfs-fixes/fixes (b1b94fcbd399 Revert "fs: fold open_check_o_direct =
into do_dentry_open")
Merging dma-mapping-fixes/for-linus (cf65a0f6f6ff dma-mapping: move all DMA=
 mapping code to kernel/dma)
Merging drivers-x86-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging samsung-krzk-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (ce397d215ccd Linux 4.18-rc1)
Merging devicetree-fixes/dt/linus (a47c9b394316 dt-bindings: Fix unbalanced=
 quotation marks)
Merging scsi-fixes/fixes (26b5b874aff5 scsi: sg: mitigate read/write abuse)
Merging drm-fixes/drm-fixes (f3294568bbb1 Merge tag 'drm-misc-fixes-2018-06=
-21' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (7daf201d7fe8 Linux 4.18-rc2)
Merging mmc-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging rtc-fixes/rtc-fixes (ca95ef7c9867 rtc: mrst: fix error code in prob=
e())
Merging drm-misc-fixes/for-linux-next-fixes (01a9e9493fb3 drm/meson: Fix an=
 un-handled error path in 'meson_drv_bind_master()')
Merging kbuild/for-next (6ab0a18be890 Merge branch 'fixes' into for-next)
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
Merging arm-soc/for-next (366cd9cde1d7 Merge branch 'fixes' into for-next)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (e3a900fa843e Merge branch 'v4.18/fixes' into tmp/=
aml-rebuild)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (59ef2671a847 ARM: dts: fix PMC compatible)
Merging bcm2835/for-next (5997adb14985 Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
Merging imx-mxs/for-next (9a403db14975 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (6511bb383f45 Merge branch 'for_4.19/drivers-soc' int=
o next)
Merging mediatek/for-next (9378b3427341 Merge branch 'v4.17-next/soc' into =
for-next)
Merging mvebu/for-next (f5b691b04382 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (1b7e42c1dfe8 Merge branch 'omap-for-v4.18/soc' into =
for-next)
Merging reset/reset/next (d7bab65b1f57 reset: uniphier: add LD11/LD20 strea=
m demux system reset control)
Merging qcom/for-next (38b0d9941227 arm64: dts: sdm845: Add rpmh-clk node)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (5da09acf2880 Merge branches 'fixes-for-v4.18', 'arm-d=
efconfig-for-v4.19', 'arm-soc-for-v4.19', 'arm-dt-for-v4.19', 'arm64-defcon=
fig-for-v4.19', 'arm64-dt-for-v4.19' and 'dt-bindings-for-v4.19' into next)
Merging rockchip/for-next (b12b0bd0db32 Merge branch 'v4.18-armsoc/dts32-fi=
xes' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (29de814e31dd Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (5c5d30fd542e Merge branches 'sunxi/clk-for-4.=
19', 'sunxi/drivers-for-4.19', 'sunxi/dt-for-4.19' and 'sunxi/dt64-for-4.19=
' into sunxi/for-next)
$ git reset --hard HEAD^
Merging next-20180627 version of sunxi
Merging tegra/for-next (6de9ae597a79 Merge branch for-4.18/clk into for-nex=
t)
Merging arm64/for-next/core (0fe42512b2f0 arm64: Fix syscall restarting aro=
und signal suppressed by tracer)
Merging clk/clk-next (003cfd706bb1 Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (85fa2cc51104 c6x: pass endianness info to spars=
e)
Merging m68k/for-next (b12c8a70643f m68k: Set default dma mask for platform=
 devices)
Merging m68knommu/for-next (7114171afb07 m68knommu: Fix typos in Coldfire 5=
272 DMA debug code)
Merging microblaze/next (45df561a7ae2 microblaze: consolidate GPIO reset ha=
ndling)
Merging mips/mips-next (829caee7e382 arch: mips: mm: page: Remove unused fu=
nction)
Merging nds32/next (a78945c357f5 nds32: Fix build error caused by configura=
tion flag rename)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (560b423dd9af openrisc: Call destructor during __=
pte_free_tlb)
Merging parisc-hd/for-next (8d40c754fbac parisc: Drop struct sigaction from=
 not exported header file)
Merging powerpc/next (ff5bc793e47b powerpc/64s/radix: Fix missing ptesync i=
n flush_cache_vmap)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (7daf201d7fe8 Linux 4.18-rc2)
Merging s390/features (c879f71c746c Merge branch 'zcrypt' into features)
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
Merging btrfs-kdave/for-next (34ebbfa8958b Merge branch 'for-next-next-v4.1=
9-20180626' into for-next-20180626)
$ git reset --hard HEAD^
Merging next-20180626 version of btrfs-kdave
Merging ceph/master (8b8f53af1ed9 ceph: fix dentry leak in splice_dentry())
Merging cifs/for-next (06d1affe3286 cifs: Fix use after free of a mid_q_ent=
ry)
Merging configfs/for-next (707c62352909 configfs: use kvasprintf() instead =
of open-coding it)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (6aee47d7f61e Pull in fsnotify cleanups from Amir and=
 new inotify IN_MASK_CREATE flag support.)
Merging ext4/dev (0238a85e379f ext4: add more mount time checks of the supe=
rblock)
Merging f2fs/dev (f57494321cbf Merge tag 'xfs-4.18-fixes-2' of git://git.ke=
rnel.org/pub/scm/fs/xfs/xfs-linux)
Merging fuse/for-next (44ce5c2e921f fs: fuse: Adding new return type vm_fau=
lt_t)
Merging jfs/jfs-next (bd646104ac5a jfs: use time64_t for otime)
Merging nfs/linux-next (7b0df92ac121 pNFS/flexfiles: Process writeback rese=
nds from nfsiod context as well)
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
Merging xfs/for-next (d8cb5e423789 xfs: fix fdblocks accounting w/ RMAPBT p=
er-AG reservation)
Merging file-locks/locks-next (1cf8e5de4055 fs/lock: show locks taken by pr=
ocesses from another pidns)
Merging vfs/for-next (6c06e521993d Merge branch 'fixes' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (ce041c43f222 lib/test_printf.c: accept "ptrval" as=
 valid result for plain 'p' tests)
Merging pci/next (ce397d215ccd Linux 4.18-rc1)
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (5686cd09f441 Merge branch 'for-4.18/upstream-fixes_v2=
' into for-next)
Merging i2c/i2c/for-next (5a219b6a7583 Merge branch 'i2c/precise-locking-na=
mes' into i2c/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (24489aed1836 hwmon: (nct6775) Fix comment=
 in the description of pwm_mode)
Merging jc_docs/docs-next (37912da4387f doc:it_IT: translation for doc-guid=
e)
Merging v4l-dvb/master (f6f630327de9 media: v4l: cadence: add VIDEO_V4L2 de=
pendency)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (85ebd164de56 fb_omap2: add gpiolib dependency)
Merging pm/linux-next (b1d2b5b3bc24 Merge branch 'pm-cpufreq' into linux-ne=
xt)
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
Merging rdma/for-next (5e62d5ff1b9a IB/mlx4: Create slave AH's directly)
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
Merging net-next/master (b1a5046b2497 Merge branch 'Multipath-tests-for-tun=
nel-devices')
Merging bpf-next/master (a7f7547f5e2b selftests/bpf: Test sys_connect BPF h=
ooks with TFO)
Merging ipsec-next/master (e4db5b61c572 xfrm: policy: remove pcpu policy ca=
che)
Merging mlx5-next/mlx5-next (b30408d7a383 net/mlx5: Rate limit errors in co=
mmand interface)
Merging netfilter-next/master (c37979958e08 openvswitch: use nf_ct_get_tupl=
epr, invert_tuplepr)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e523452ac0e0 netfilter: nf_tables: remove unused =
variables)
Merging wireless-drivers-next/master (c3ae2103e069 mt76: improve gain adjus=
tment in noisy environments)
Merging bluetooth/master (0ef8b4567d08 tls: Removed unused variable)
Merging mac80211-next/master (8ba6731ad4c7 rfkill: add header files to MAIN=
TAINERS)
CONFLICT (content): Merge conflict in net/mac80211/scan.c
Merging gfs2/for-next (ffc84e55cbf5 gfs2: using posix_acl_xattr_size instea=
d of posix_acl_to_xattr)
Merging mtd/mtd/next (02361bc77888 lib/bch: Remove VLA usage)
Merging nand/nand/next (11e9e7667e98 mtd: rawnand: micron: detect forced on=
-die ECC)
Merging spi-nor/spi-nor/next (9882b5375df5 mtd: m25p80: Use SPI_MEM_OP_NO_D=
UMMY instead of SPI_MEM_OP_DUMMY(0, x))
Merging crypto/master (38641b83ebc5 crypto: atmel-ecc - remove overly verbo=
se dev_info)
Merging drm/drm-next (3c8daa7db46d drm/omap: remove now unused functions)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (3160422251b2 drm/i915/icp: Add Interrupt =
Support)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_crt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem_execbuf=
fer.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem.c
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (57e23de02f48 drm/sun4i: DW HDMI: Expand al=
gorithm for possible crtcs)
CONFLICT (content): Merge conflict in MAINTAINERS
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
Merging regmap/for-next (7daf201d7fe8 Linux 4.18-rc2)
Merging sound/for-next (c288248f5b26 ALSA: intel_hdmi: Use strlcpy() instea=
d of strncpy())
Merging sound-asoc/for-next (665a698c2b73 Merge remote-tracking branches 'a=
soc/topic/doc' and 'asoc/topic/trace' into asoc-next)
Merging modules/modules-next (996302c5e856 module: replace VMLINUX_SYMBOL_S=
TR() with __stringify() or string literal)
Merging input/next (3a658f23fb68 Input: add bu21029 touch driver)
Merging block/for-next (28313cee1d4f Merge branch 'for-4.18/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (4cd7e9d2455d dm: prevent DAX mounts if not =
supported)
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
Merging regulator/for-next (aca94d6bb60c Merge branch 'regulator-4.19' into=
 regulator-next)
Merging security/next-testing (12aaa9cfc578 Merge branch 'next-general' int=
o next-testing)
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
Merging devicetree/for-next (f1f517b8f555 dt-bindings: gpio: pca953x: Docum=
ent interrupts, update example)
Merging mailbox/mailbox-for-next (f83d1cfc8bcd mailbox/drivers/hisi: Consol=
idate the Kconfig for the MAILBOX)
Merging spi/for-next (e1e4cb274b8d Merge branch 'spi-4.19' into spi-next)
Merging tip/auto-latest (72d1fd086cbf Merge branch 'x86/hyperv')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6c974d4dfafe EDAC, i7core: Fix memleaks and use-=
after-free on probe and remove)
Merging irqchip/irq/irqchip-next (6a88c221acba ARM: dts: stm32: Add exti su=
pport to stm32mp157 pinctrl)
Merging ftrace/for-next (a9235b544a0a ring-buffer: Fix typo in comment)
Merging rcu/rcu/next (bd917f682b45 Merge branches 'fixes1.2018.06.26a' and =
'torture1.2018.06.26a' into HEAD)
CONFLICT (content): Merge conflict in kernel/rcu/tree_plugin.h
Merging kvm/linux-next (ce397d215ccd Linux 4.18-rc1)
Merging kvm-arm/next (e25028c8ded0 KVM: arm/arm64: Bump VGIC_V3_MAX_CPUS to=
 512)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (ce397d215ccd Linux 4.18-rc1)
Merging kvms390/next (2c8180e885c1 KVM: s390: vsie: simplify < 8k address c=
hecks)
Merging xen-tip/linux-next (eef04c7b3786 xen: Remove unnecessary BUG_ON fro=
m __unbind_from_irq())
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (66448bc274ca workqueue: move function definiti=
ons within CONFIG_SMP block)
Merging drivers-x86/for-next (f193f7985f48 Documentation/ABI: Add documenta=
tion mlxreg-io sysfs interfaces)
Merging chrome-platform/for-next (c474e9f2be99 platform/chrome: chromeos_tb=
mc - fix SPDX identifier)
Merging hsi/for-next (ce397d215ccd Linux 4.18-rc1)
Merging leds/for-next (dfa32216711f can: mark led trigger as broken)
Merging ipmi/for-next (46f2277e45fe ipmi:dmi: Ignore IPMI SMBIOS entries wi=
th a zero base address)
Merging driver-core/driver-core-next (7daf201d7fe8 Linux 4.18-rc2)
Merging usb/usb-next (dc748b66dbfb dt-bindings: usb: new ehci-npcm7xx dt)
Merging usb-gadget/next (47265c067c0d usb: dwc2: gadget: Fix coverity issue)
Merging usb-serial/usb-next (1d1de580a3e0 USB: serial: digi_acceleport: ren=
ame tty flag variable)
Merging usb-chipidea-next/ci-for-usb-next (ba0ab35a81de usb: chipidea: tegr=
a: Use aligned DMA on Tegra114/124)
Merging phy-next/next (ce397d215ccd Linux 4.18-rc1)
Merging tty/tty-next (ce397d215ccd Linux 4.18-rc1)
Merging char-misc/char-misc-next (7daf201d7fe8 Linux 4.18-rc2)
Merging extcon/extcon-next (441492c2256c extcon: Release locking when sendi=
ng the notification of connector state)
Merging staging/staging-next (71e9bd3ff847 staging: rtl8188eu: add SPDX ide=
ntifiers)
Merging mux/for-next (6a3d4baac84a mux: add mux_control_get_optional() API)
Merging slave-dma/next (f8ccde4a31d3 Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (d8742e229021 cgroup: css_set_lock should nest insi=
de tasklist_lock)
Merging scsi/for-next (dc047dc7c64f Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (0c218e16a850 scsi: tcmu: Don't pass KERN_ERR to =
pr_err)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (313c1b5a6bef Merge branch 'for-4.18-fixes' into fo=
r-next)
Merging vhost/linux-next (2eb98105f8c7 virtio: update the comments for tran=
sport features)
Merging rpmsg/for-next (b039e1ccb07f Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
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
Merging rtc/rtc-next (3cd7de001fb4 rtc: rtc-bq4802: add error handling for =
devm_ioremap)
Merging nvdimm/libnvdimm-for-next (7daf201d7fe8 Linux 4.18-rc2)
Merging at24/at24/for-next (ce397d215ccd Linux 4.18-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (fcd21109bba1 doc: self-protection: Add informat=
ion about STACKLEAK feature)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging xarray/xarray (1886ca9f6ee4 Fix filemap_range_has_page conversion t=
o XArray)
CONFLICT (content): Merge conflict in lib/Kconfig.debug
Merging fsi/master (6b293258cded fsi: scom: Major overhaul)
Merging akpm-current/current (43b4ee660206 bfs: add sanity check at bfs_fil=
l_super())
CONFLICT (modify/delete): lib/percpu_ida.c deleted in HEAD and modified in =
akpm-current/current. Version akpm-current/current of lib/percpu_ida.c left=
 in tree.
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
CONFLICT (content): Merge conflict in ipc/sem.c
$ git rm -f lib/percpu_ida.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: kernel/kexec_file.c: add walk_system_ram_res_rev()
Applying: kernel/kexec_file.c: load kernel at top of system RAM if required
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (d3d095fd03af sparc64: NG4 memset 32 bits overflow)

--Sig_/WmS3mKlr9rLkJl+6y9ZwdTX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls0fiAACgkQAVBC80lX
0GyjbQf9HqMi7jVlxx3c9S6SuBYC1AXfNj8y6SFXruuy1xqNuMVnVqaBQ20oR9/H
nxeVhtBPngFtAoXh+Pi5VBMyeb2P/IjJI2dk124GemPYM1f3bH0d+GrVjmVEzOOV
I5XQFpu3IbH9H68lWfUWZgc1mQajkJ5hPplormYeNR5rf5p3V8AVydQhG/r82wym
HAHd/0oX5IOu2EUzGYJziU+7PeOaQKiwl79ifuu8OTtAvS6xnIrRGmSuvqJi4txe
jDvhcPxw/h8woiLVt0o2jtSCmvhXTEEuE2IJD9IDB4P0y8ZwpWarIAA1ZcSOrUwe
VT/RRL0YGKJyCWDM3ParNga2JZT5dg==
=XESY
-----END PGP SIGNATURE-----

--Sig_/WmS3mKlr9rLkJl+6y9ZwdTX--
