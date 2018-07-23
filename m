Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D3FECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8471320685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SZTpnwYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8471320685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbeGWLBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:01:08 -0400
Received: from ozlabs.org ([203.11.71.1]:44015 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388071AbeGWLBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:01:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41YxnZ5CWkz9s3N;
        Mon, 23 Jul 2018 20:00:34 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532340034;
        bh=euesMIrkGgY+pPMdTzBb2X0UVOe3ZleZthEDbufw7L0=;
        h=Date:From:To:Cc:Subject:From;
        b=SZTpnwYcOsaKjipJ4ceFbQellU5SBXcJ58zbZp1dNYr/8wIrKR/f+yJxEGDY2SH5J
         z0/8caLb5Sy8wupFEcw6jt7yOMymdF5xiaqIsiilS8U2RrsNEghWIQAhyXYINqziAE
         u0PmKRJNDZA+47UrnOSo0T9svXU05m3GMSye++1W/CGgewYQ1Y8FPv6ciCSsKpKIZJ
         gAVNF3CLf9Fd0kHa/QJRZJZ6snMB8oLUSyrgihgFoFUIZkyPWt9BL3GEPg3gtnhF5m
         5rD9d16BPt8Kun6d5HJglutt5jnQozo7d/NR1UMRnCZqUne1JG7UZjGD3VDGrzJHZz
         cxv5g12vjfUlg==
Date:   Mon, 23 Jul 2018 20:00:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 23
Message-ID: <20180723200032.221a8f18@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/tDif7Mr/O8TRGtup5+t4KHz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tDif7Mr/O8TRGtup5+t4KHz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180720:

Dropped trees: xarray, ida (complex conflicts)

The drm-msm tree gained a conflict against the drm tree and a build
failure due to an interaction with the drm tree for which I added a
merge fix patch.

The kvm-arm tree gained a conflict against the arm64 tree.

The driver-core tree gained a conflict against the net-next tree.

The xarray tree gained complex conflicts against the nvdimm tree so I have
dropped it for today (along with the ida tree that is built on top of it).

The akpm-current tree gained a conflict against Linus' tree and also a
build failure for which I reverted a commit.

Non-merge commits (relative to Linus' tree): 7606
 7110 files changed, 316203 insertions(+), 143278 deletions(-)

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

I am currently merging 285 trees (counting Linus' and 65 trees of bug
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
Merging origin/master (d72e90f33aa4 Linux 4.18-rc6)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (9d3cce1e8b85 Linux 4.18-rc5)
Merging arc-current/for-curr (af1fc5baa724 ARCv2: [plat-hsdk]: Save accl re=
g pair by default)
Merging arm-current/fixes (b4c7e2bd2eb4 ARM: 8780/1: ftrace: Only set kerne=
l memory back to read-only after boot)
Merging arm64-fixes/for-next/fixes (2fd8eb4ad871 arm64: neon: Fix function =
may_use_simd() return error status)
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (b03897cf318d powerpc/powernv: Fix save/restore=
 of SPRG3 on entry/exit from stop (idle))
Merging sparc/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel=
.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (c9ce1fa1c24b net: prevent ISA drivers from building on =
PPC32)
Merging bpf/master (7c3e8b642bad bpf: Use option "help" in the llvm-objcopy=
 test)
Merging ipsec/master (7284fdf39a91 esp6: fix memleak on error path in esp6_=
input)
Merging netfilter/master (6613b6173dee netfilter: conntrack: dccp: treat SY=
NC/SYNCACK as invalid if no prior state)
Merging ipvs/master (0026129c8629 rhashtable: add restart routine in rhasht=
able_free_and_destroy())
Merging wireless-drivers/master (248c690a2dc8 Merge tag 'wireless-drivers-f=
or-davem-2018-07-03' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo=
/wireless-drivers)
Merging mac80211/master (5cf3006cc81d nl80211: Add a missing break in parse=
_station_flags)
Merging rdma-fixes/for-rc (d63c46734c54 RDMA/mlx5: Fix memory leak in mlx5_=
ib_create_srq() error path)
Merging sound-current/for-linus (f3d737b6340b ALSA: hda/realtek - Yet anoth=
er Clevo P950 quirk entry)
Merging sound-asoc-fixes/for-linus (0b86b757f5d7 Merge branch 'asoc-4.18' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (9d3cce1e8b85 Linux 4.18-rc5)
Merging regulator-fixes/for-linus (ce1e5093e95a Merge branch 'regulator-4.1=
8' into regulator-linus)
Merging spi-fixes/for-linus (525e437354b6 Merge branch 'spi-4.18' into spi-=
linus)
Merging pci-current/for-linus (270ed733e689 PCI: v3-semi: Fix I/O space pag=
e leak)
Merging driver-core.current/driver-core-linus (722e5f2b1eec driver core: Pa=
rtially revert "driver core: correct device's shutdown order")
Merging tty.current/tty-linus (021c91791a5e Linux 4.18-rc3)
Merging usb.current/usb-linus (249a32b7eeb3 usb: core: handle hub C_PORT_OV=
ER_CURRENT condition)
Merging usb-gadget-fixes/fixes (eec24f2a0d4d usb: gadget: f_uac2: fix endia=
nness of 'struct cntrl_*_lay3')
Merging usb-serial-fixes/usb-linus (9d3cce1e8b85 Linux 4.18-rc5)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (ad5003300b07 phy: mapphone-mdm6600: Fix wrong enum used =
for status lines)
Merging staging.current/staging-linus (b96fba8d5855 staging: speakup: fix w=
raparound in uaccess length check)
Merging char-misc.current/char-misc-linus (9d3cce1e8b85 Linux 4.18-rc5)
Merging input-current/for-linus (384cf4285b34 Input: i8042 - add Lenovo LaV=
ie Z to the i8042 reset list)
Merging crypto-current/master (46d8c4b28652 crypto: padlock-aes - Fix Nano =
workaround data corruption)
Merging ide/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/abelloni/linux)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (1e4b044d2251 Linux 4.18-rc4)
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (aa7eee8a143a mtd: spi-nor: cadence-quadspi: Fix d=
irect mode write timeouts)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (ce397d215ccd Linux 4.18-rc1)
Merging v4l-dvb-fixes/fixes (0ca54b290541 media: rc: be less noisy when dri=
ver misbehaves)
Merging reset-fixes/reset/fixes (e6914365fd28 reset: uniphier: fix USB cloc=
k line for LD20)
Merging mips-fixes/mips-fixes (bc88ad2efd11 MIPS: ath79: fix register addre=
ss in ath79_ddr_wb_flush())
Merging omap-fixes/fixes (d3f6daede246 ARM: dts: omap4-droid4: fix dts w.r.=
t. pwm)
Merging kvm-fixes/master (63aff65573d7 kvm: x86: vmx: fix vpid leak)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (1e4b044d2251 Linux 4.18-rc4)
Merging nvdimm-fixes/libnvdimm-fixes (ee6581ceba7f nfit: fix unchecked dere=
ference in acpi_nfit_ctl)
Merging btrfs-fixes/next-fixes (0b7162742121 Merge branch 'for-next-current=
-v4.18-20180717' into next-fixes)
Merging vfs-fixes/fixes (9ba546c01976 aio: don't expose __aio_sigset in uap=
i)
Merging dma-mapping-fixes/for-linus (7ec916f82c48 Revert "iommu/intel-iommu=
: Enable CONFIG_DMA_DIRECT_OPS=3Dy and clean up intel_{alloc,free}_coherent=
()")
Merging drivers-x86-fixes/fixes (9d3cce1e8b85 Linux 4.18-rc5)
Merging samsung-krzk-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (ce397d215ccd Linux 4.18-rc1)
Merging devicetree-fixes/dt/linus (b9952b5218ad of: overlay: update phandle=
 cache on overlay apply and remove)
Merging scsi-fixes/fixes (b4146c4929ef scsi: qla2xxx: Return error when TMF=
 returns)
Merging drm-fixes/drm-fixes (02e546eaccea Merge branch 'linux-4.18' of git:=
//github.com/skeggsb/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (09d2da310d61 Merge tag 'gvt-f=
ixes-2018-07-11' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (3b1074bf9817 mmc: mxcmmc: Fix missing parentheses =
and brace)
Merging rtc-fixes/rtc-fixes (fd6792bb022e rtc: fix alarm read and set offse=
t)
Merging drm-misc-fixes/for-linux-next-fixes (d530b5f1ca0b drm: re-enable er=
ror handling)
Merging kbuild/for-next (d5a57dff2213 Merge branch 'kconfig' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (2550bbfd4952 dma-direct: don't crash on devic=
e without dma_mask)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (52e19c3c1eaf Merge branches 'clkdev', 'fixes', 'misc'=
 and 'spectre' into for-next)
Merging arm-perf/for-next/perf (c13207905340 arm64: perf: Add support for c=
haining event counters)
Merging arm-soc/for-next (b2df9d609df1 ARM: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (b3fd49121640 Merge branch 'v4.19/dt64' into tmp/a=
ml-rebuild)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/amlogic/Makefile
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/arm=
/amlogic.txt
Merging aspeed/for-next (403d991cce7d Merge branches 'defconfig-for-v4.19' =
and 'dt-for-v4.19' into for-next)
Merging at91/at91-next (f45853da06e3 Merge tag 'at91-ab-4.19-soc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux into at91-next)
Merging bcm2835/for-next (5997adb14985 Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
CONFLICT (content): Merge conflict in drivers/hwmon/Kconfig
CONFLICT (content): Merge conflict in drivers/firmware/raspberrypi.c
Merging imx-mxs/for-next (7586f152bcad Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (ed3bf0f321b9 Merge branch 'for_4.19/drivers-soc' int=
o next)
Merging mediatek/for-next (b75253e66bc5 Merge branch 'v4.18-next/soc' into =
for-next)
Merging mvebu/for-next (23b7c60b80f6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (d356801075c5 Merge branch 'omap-for-v4.19/dt' into f=
or-next)
Merging reset/reset/next (d903779b58be reset: meson: add meson audio arb dr=
iver)
Merging qcom/for-next (76b9e7f947f1 Merge tag 'qcom-defconfig-for-4.19' int=
o all-for-4.19)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (77ac2a5fc496 Merge branches 'arm-defconfig-for-v4.19'=
, 'arm-soc-for-v4.19', 'arm-dt-for-v4.19', 'arm64-dt-for-v4.19' and 'dt-bin=
dings-for-v4.19' into next)
Merging rockchip/for-next (75589311007d Merge branch 'v4.19-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (44c29c1f2c9f Merge branch 'for-v4.19/exynos5=
440-removal-drivers' into for-next)
Merging sunxi/sunxi/for-next (51c756fe7803 Merge branch 'sunxi/dt64-for-4.1=
9' into sunxi/for-next)
Merging tegra/for-next (f29cfb31cf00 Merge branch for-4.19/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (11527b3e0b57 arm64: Drop asmlinkage qualifier =
from syscall_trace_{enter,exit})
Merging clk/clk-next (4db3ff7a7f11 Merge branch 'clk-qcom-rpmh' into clk-ne=
xt)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging h8300/h8300-next (54692056a201 h8300: Correct signature of test_bit=
())
Merging m68k/for-next (cd629147324c m68k/defconfig: Update defconfigs for v=
4.18-rc1)
Merging m68knommu/for-next (a23aa852f423 m68knommu: Fix typos in Coldfire 5=
272 DMA debug code)
Merging microblaze/next (ed207a743444 microblaze: remove consistent_sync an=
d consistent_sync_page)
Merging mips/mips-next (788654285da7 mips: mm: Discard ioremap_cacheable_co=
w() method)
CONFLICT (content): Merge conflict in arch/mips/kernel/process.c
Merging nds32/next (d2516b16bcbc nds32: fix logic for module)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (ae15a41a6414 openrisc: entry: Fix delay slot exc=
eption detection)
Merging parisc-hd/for-next (ce397d215ccd Linux 4.18-rc1)
Merging powerpc/next (ce57c6610cc2 Merge branch 'topic/ppc-kvm' into next)
CONFLICT (content): Merge conflict in drivers/vfio/vfio_iommu_spapr_tce.c
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (021c91791a5e Linux 4.18-rc3)
Merging s390/features (cd0ed39dc9e8 s390/tape: replace PTR_RET with PTR_ERR=
_OR_ZERO)
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (5ec9121195a4 um: Fix raw interface options)
Merging xtensa/xtensa-for-next (cb6db64ef5a9 Merge branch 'xtensa-dma-fixes=
' into xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6f383855b92d Merge branch 'for-next-next-v4.1=
9-20180716' into for-next-20180716)
Merging ceph/master (8b8f53af1ed9 ceph: fix dentry leak in splice_dentry())
Merging cifs/for-next (887e4f50dc55 smb3: snapshot mounts are read-only and=
 make sure info is displayable about the mount)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (6aee47d7f61e Pull in fsnotify cleanups from Amir and=
 new inotify IN_MASK_CREATE flag support.)
Merging ext4/dev (a0d2ee74e814 ext4: import extended attributes chapter fro=
m wiki page)
Merging f2fs/dev (ea1ac43174f9 f2fs: avoid potential deadlock in f2fs_sbi_s=
tore)
Merging fuse/for-next (8139306548ab fuse: convert last timespec use to time=
spec64)
Merging jfs/jfs-next (bd646104ac5a jfs: use time64_t for otime)
Merging nfs/linux-next (7b0df92ac121 pNFS/flexfiles: Process writeback rese=
nds from nfsiod context as well)
Merging nfs-anna/linux-next (ffbfa2ce88f1 sunrpc: Fix latency trace point c=
rashes)
Merging nfsd/nfsd-next (32620db998a5 NFSD stop ongoing async copies on clie=
nt shutdown)
Merging orangefs/for-next (f35cf2ab06b6 orangefs: remove redundant pointer =
orangefs_inode)
Merging overlayfs/overlayfs-next (989974c80457 ovl: Enable metadata only fe=
ature)
Merging ubifs/linux-next (f5a926dd5298 mtd: ubi: Update ubi-media.h to dual=
 license)
Merging v9fs/9p-next (74622fbdedde net/9p/trans_virtio.c: fix some spell mi=
stakes in comments)
Merging xfs/for-next (efe803277364 xfs: Initialize variables in xfs_alloc_g=
et_rec before using them)
Merging file-locks/locks-next (1cf8e5de4055 fs/lock: show locks taken by pr=
ocesses from another pidns)
Merging vfs/for-next (f6756d7df991 Merge branch 'work.misc' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (7973c51853f8 Merge branch 'for-4.19-nmi' into for-=
next)
Merging pci/next (b3dd889f1a82 Merge branch 'remotes/lorenzo/pci/vmd')
CONFLICT (content): Merge conflict in drivers/pci/controller/pci-aardvark.c
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (57194b035942 Merge branch 'for-4.19/upstream' into fo=
r-next)
Merging i2c/i2c/for-next (1ca65fa64943 Merge branch 'i2c/for-4.19' into i2c=
/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (f1fd4a4db777 hwmon: Add NPCM7xx PWM and F=
an driver)
Merging jc_docs/docs-next (6b4c1360e8ad Documentation: Add powerpc options =
for spec_store_bypass_disable)
Merging v4l-dvb/master (39fbb88165b2 media: bpf: ensure bpf program is free=
d on detach)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (34db50e55656 efifb: Copy the ACPI BGRT boot g=
raphics to the framebuffer)
Merging pm/linux-next (45414aea93b5 Merge branch 'acpi-battery' into linux-=
next)
Merging cpupower/cpupower (ce397d215ccd Linux 4.18-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (c5c2a97b3ac7 PM / OPP: Update voltage in case f=
req =3D=3D old_freq)
Merging thermal/next (e9ed3ee61aa6 Merge branches 'thermal-core' and 'therm=
al-intel' into next)
Merging thermal-soc/next (1d32d387967c thermal: ti-soc-thermal: remove dead=
 code)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (c012691508f5 IB/cm: Remove cma_multicast->igmp_joine=
d)
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
Merging net-next/master (07300f774fec nfp: avoid buffer leak when FW commun=
ication fails)
CONFLICT (content): Merge conflict in net/smc/smc_ib.c
Merging bpf-next/master (8ae71e76cf1f Merge branch 'bpf-offload-sharing')
Merging ipsec-next/master (03dc7a35fcc8 ipv6: xfrm: use 64-bit timestamps)
Merging mlx5-next/mlx5-next (048f31437ac5 net/mlx5: Fix tristate and descri=
ption for MLX5 module)
Merging netfilter-next/master (24c458c485c8 netfilter: nf_osf: add missing =
definitions to header file)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (66c524acfb51 netfilter: conntrack: remove l3proto=
 abstraction)
CONFLICT (content): Merge conflict in net/netfilter/Makefile
CONFLICT (content): Merge conflict in net/netfilter/Kconfig
CONFLICT (content): Merge conflict in net/ipv6/netfilter/Kconfig
Merging wireless-drivers-next/master (4a07ed51cae1 mt76x2: debugfs: add sw =
pulse statistics to dfs debugfs)
Merging bluetooth/master (b71c69c26b49 Bluetooth: Use lock_sock_nested in b=
t_accept_enqueue)
Merging mac80211-next/master (518ea3c54eb7 mac80211_hwsim: Add support for =
HE)
Merging gfs2/for-next (e2b8bd8c3088 gfs2: remove redundant variable 'moved')
Merging mtd/mtd/next (d70420bcd447 mtd: adapt misleading comment in mtd_oob=
_ops structure)
Merging nand/nand/next (db4a671e39ff mtd: rawnand: add hooks that may be ca=
lled during nand_scan())
Merging spi-nor/spi-nor/next (a3804084ddf0 mtd: spi-nor: stm32-quadspi: rep=
lace "%p" with "%pK")
Merging crypto/master (0e7d4d932ffc crypto: sharah - Unregister correct alg=
orithms for SAHARA 3)
Merging drm/drm-next (500775074f88 Merge branch 'drm-next-4.19' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_irq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/smumgr/=
smu7_smumgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/inc/dc=
_link_ddc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce/dc=
e_mem_input.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c_link_ddc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm_services.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm_mst_types.c
Applying: drm/i915/kvmgt: merge fixup for "Check the pfn got from vfio_pin_=
pages"
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (6f15a7de86c8 drm/i915/dsc: Add missing _M=
MIO() from PPS registers)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (106b6c39c870 drm/print: Fix DRM_DEBUG_DP m=
acro)
Merging drm-msm/msm-next (010148c5b155 drm/msm: rework vblank event handlin=
g in dpu_crtc)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/dsi/dsi_manager.c
Applying: drm: msm: merge fix for drm_plane_helper_disable() API change
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (e368fc75c190 drm/arm/malidp: Added th=
e late system pm functions)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (81f2b25addde drm/imx: Remove unused field imx=
_drm_device.pipes)
Merging etnaviv/etnaviv/next (f6ffbd4fc1a1 drm/etnaviv: replace license tex=
t with SPDX tags)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (6714e53130ba Merge branch 'regmap-4.19' into regma=
p-next)
Merging sound/for-next (d10ee9c54236 ALSA: timer: catch invalid timer objec=
t creation)
Merging sound-asoc/for-next (64e942d9d98c Merge branch 'asoc-4.19' into aso=
c-next)
Merging modules/modules-next (4d58e7034d19 ARM: module: fix modsign build e=
rror)
Merging input/next (2b6e68119c47 Input: gpio_keys - add missing include to =
gpio_keys.h)
Merging block/for-next (e7a0c1f1ee45 Merge branch 'for-4.19/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (d284f8248c72 dm writecache: support optiona=
l offset for start of device)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (44350993d01c mmc: tegra: Add and use tegra_sdhci_get_max_=
clock())
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (685dbcaa25be drivers/md/raid5: Use irqsave variant of =
atomic_dec_and_lock())
Merging mfd/for-mfd-next (99266311865e mfd: axp20x: Support AXP806 in I2C m=
ode)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Kconfig
Merging backlight/for-backlight-next (858c5dfc8c33 backlight: adp8860: Mark=
 expected switch fall-through)
Merging battery/for-next (9c7272412bc5 power: supply: lego_ev3_battery: fix=
 Vce offset)
Merging regulator/for-next (23a9f57ff66e Merge branch 'regulator-4.19' into=
 regulator-next)
Merging security/next-testing (530a13df0b0b Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (24b87a16fee0 apparmor: Fix failure to audit=
 context info in build_change_hat)
Merging integrity/next-integrity (3dd0f18c70d9 EVM: fix return value check =
in evm_write_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (631d2b490569 selinux: constify write_op[])
Merging tpmdd/next (776afd171925 ima: Get rid of ima_used_chip and use ima_=
tpm_chip !=3D NULL instead)
Merging watchdog/master (9d3cce1e8b85 Linux 4.18-rc5)
Merging iommu/next (a8cfa7c8491c Merge branches 'iommu/fixes', 'arm/shmobil=
e', 'arm/renesas', 'arm/msm', 'x86/amd', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (c1abca96b252 samples: mbochs: add DMA_SHARED_BUFFER depe=
ndency)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (baa2a4fdd525 audit: fix use-after-free in audit_add_wat=
ch)
Merging devicetree/for-next (3a6372daddeb dt-bindings: sound: wm8994: docum=
ent wlf,csnaddr-pd property)
Merging mailbox/mailbox-for-next (f83d1cfc8bcd mailbox/drivers/hisi: Consol=
idate the Kconfig for the MAILBOX)
Merging spi/for-next (484d5c6c7aad Merge branch 'spi-4.19' into spi-next)
Merging tip/auto-latest (fc3d25e1c8f6 Merge branch 'x86/timers')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6663484b4e2d EDAC, thunderx: Remove VLA usage)
Merging irqchip/irq/irqchip-next (6a88c221acba ARM: dts: stm32: Add exti su=
pport to stm32mp157 pinctrl)
Merging ftrace/for-next (a9235b544a0a ring-buffer: Fix typo in comment)
Merging rcu/rcu/next (d57fa29ddc3c Merge LKMM and RCU commits)
Merging kvm/linux-next (6f0d349d922b Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/davem/net)
Merging kvm-arm/next (b0960b9569db KVM: arm: Add 32bit get/set events suppo=
rt)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpucaps.h
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (0abb75b7a16d KVM: PPC: Book3S HV: Fix constan=
t size warning)
Merging kvms390/next (a3da7b4a3be5 KVM: s390: add etoken support for guests)
Merging xen-tip/linux-next (0ce0bba4e5e0 xen: setup pv irq ops vector earli=
er)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (66448bc274ca workqueue: move function definiti=
ons within CONFIG_SMP block)
Merging drivers-x86/for-next (c2e2a618eb71 platform/x86: toshiba_acpi: Fix =
defined but not used build warnings)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (ce397d215ccd Linux 4.18-rc1)
Merging leds/for-next (6f7b0bad8839 usb: simplify usbport trigger)
Merging ipmi/for-next (a4fb7ddc6356 ipmi: kcs_bmc: don't change device name)
Merging driver-core/driver-core-next (e16f4f3e0b7d base: core: Remove WARN_=
ON from link dependencies check)
CONFLICT (content): Merge conflict in fs/sysfs/group.c
CONFLICT (content): Merge conflict in drivers/iommu/ipmmu-vmsa.c
Merging usb/usb-next (12dcaeb77e67 usb: usbtmc: Add ioctl for termination c=
haracter)
Merging usb-gadget/next (47265c067c0d usb: dwc2: gadget: Fix coverity issue)
Merging usb-serial/usb-next (c8acfe0aadbe USB: serial: cp210x: implement GP=
IO support for CP2102N)
Merging usb-chipidea-next/ci-for-usb-next (ba0ab35a81de usb: chipidea: tegr=
a: Use aligned DMA on Tegra114/124)
Merging phy-next/next (d5f5ee1a16a4 phy: berlin: switch to SPDX license ide=
ntifier)
Merging tty/tty-next (f4c6fbc96eb1 vt: drop unused struct vt_struct)
Merging char-misc/char-misc-next (bce5c2ea350f uio: add SPDX license tags)
Merging extcon/extcon-next (8a9dbb779fe8 extcon: Release locking when sendi=
ng the notification of connector state)
Merging staging/staging-next (9005feae4785 staging: rtl8712: remove redunda=
nt pointer 'nic')
CONFLICT (modify/delete): drivers/staging/skein/skein_generic.c deleted in =
staging/staging-next and modified in HEAD. Version HEAD of drivers/staging/=
skein/skein_generic.c left in tree.
$ git rm -f drivers/staging/skein/skein_generic.c
Applying: Revert "Revert "staging:r8188eu: Use lib80211 to support TKIP""
Merging mux/for-next (6a3d4baac84a mux: add mux_control_get_optional() API)
Merging slave-dma/next (e1966eb8a1b1 Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (d92f5db64445 Merge branch 'misc' into for-next)
CONFLICT (modify/delete): lib/percpu_ida.c deleted in scsi/for-next and mod=
ified in HEAD. Version HEAD of lib/percpu_ida.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
$ git rm -f lib/percpu_ida.c
Merging scsi-mkp/for-next (f4e34f2a5dd9 scsi: hisi_sas: Add SATA FIS check =
for v3 hw)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (48ffb6b32df8 Merge branch 'for-4.18-fixes' into fo=
r-next)
Applying: Revert "ata: ahci_platform: allow disabling of hotplug to save po=
wer"
Merging vhost/linux-next (2eb98105f8c7 virtio: update the comments for tran=
sport features)
Merging rpmsg/for-next (3d065621c921 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (d166d33c1862 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (b283cec1c680 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (ce397d215ccd Linux 4.18-rc1)
Merging pwm/for-next (19ad2b75c643 pwm: mxs: Switch to SPDX identifier)
Merging userns/for-next (04035aa33a12 proc: Don't change mount options on r=
emount failure.)
CONFLICT (content): Merge conflict in fs/proc/root.c
CONFLICT (content): Merge conflict in fs/proc/internal.h
CONFLICT (content): Merge conflict in fs/proc/inode.c
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (067954f27faa random: add a config option to trust the C=
PU's hwrng)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (d2d49495b5c0 selftests: vDSO - fix to return KSFT_S=
KIP when test couldn't be run)
Merging y2038/y2038 (e264abeaf9da pstore: Remove bogus format string defini=
tion)
Merging livepatching/for-next (0eb53cdd58f5 Merge branch 'for-4.19/upstream=
' into for-next)
Merging coresight/next (1f0a504d39ae coresight: tpiu: Fix disabling timeout=
s)
Merging rtc/rtc-next (7e580769b79f rtc: ds1307: support m41t11 variant)
Merging nvdimm/libnvdimm-for-next (823b1d57266d Merge branch 'djiang5/for-4=
.19/dax-memory-failure' into libnvdimm-for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/mcheck/mce.c
Merging at24/at24/for-next (ce397d215ccd Linux 4.18-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (9edc4161661e Merge branch 'for-next/usercopy' i=
nto for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging xarray/xarray (4c8e6fcba165 radix tree: Remove radix_tree_clear_tag=
s)
CONFLICT (content): Merge conflict in fs/dax.c
CONFLICT (content): Merge conflict in MAINTAINERS
$ git reset --hard HEAD
Merging fsi/master (fea9cf321c91 fsi: Move various master definitions to a =
common header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging ida/ida (eafb6e79625d ida: Convert to XArray)
CONFLICT (content): Merge conflict in fs/dax.c
CONFLICT (content): Merge conflict in MAINTAINERS
$ git reset --hard HEAD
Merging akpm-current/current (ebd319901941 ipc/util.c: update return value =
of ipc_getref from int to bool)
CONFLICT (content): Merge conflict in mm/mmap.c
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/bitops.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
Applying: fixup for bit.h/bitops.h merge
$ git checkout -b akpm remotes/origin/akpm/master
Applying: drivers/hwtracing/intel_th/msu.c: change return type to vm_fault_t
Applying: fs/nfs/file.c: use new return type vm_fault_t
Applying: fs/afs: use new return type vm_fault_t
Applying: treewide: correct "differenciate" and "instanciate" typos
Applying: fs/proc/vmcore.c: hide vmcoredd_mmap_dumps() for nommu builds
Applying: drivers/gpu/drm/gma500/: change return type to vm_fault_t
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (3f8cb09b13be drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)
Applying: Revert "proc/kcore: add vmcoreinfo note to /proc/kcore"

--Sig_/tDif7Mr/O8TRGtup5+t4KHz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltVp0AACgkQAVBC80lX
0Gx8egf/RTE5DihbckD/iPmLl43iDeB6bvZ6sKJahueA8b8h7oOIn9M81nc1IZoq
hT65n1yE8JjrzOyMbNZxzHKBdft21VukdBvy1X9oV/uAUss/4epY11SMsVt3YSxF
iUcC3V4hBTfilw4etH0QhijRxtxDJEjVGJ6y/vPWviEilHMILVBrrRK+z5JwqSZm
bFce9J/tb9uOV6e4fyR9g2fC3p8jR0ihNO+7MMk0lILbHEMMSQ43mA/PvL6zdCcJ
kQ7my+TzipMWEjrSFLAGK6XL5fwevUZ2lfPDxOk6tkOb+psYz79wAgAOXaU0qKGl
bDDrSFqhG7KQp0NH216Ba6utyoTuLQ==
=epzN
-----END PGP SIGNATURE-----

--Sig_/tDif7Mr/O8TRGtup5+t4KHz--
