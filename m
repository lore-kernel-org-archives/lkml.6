Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A42C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875A420644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Lg0PQru0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875A420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeH3HBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:01:23 -0400
Received: from ozlabs.org ([203.11.71.1]:44783 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbeH3HBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:01:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4216hJ5n84z9ryn;
        Thu, 30 Aug 2018 13:01:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535598080;
        bh=794Fn30Xn0ASl03RMiIW6dPW7ylymGxLjkqIQUq3vYQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Lg0PQru0dWu9B50wd2gFXSa+D7Z3EjrIh3a6xJFvb6TcwzbGbap1idMzCW1M8wkDD
         0MPPGjfJ4fpodwb3Pks9nPYbwJo8iCaWt5lbATbUcXpSWebKPkK3V1yHrua89Ue4/v
         1GoV6UQK+zFnycSyxnJOQKbsoLQtl+OrDzX/kxFjsSkYnJjK3+wMv7ujIE1mAorNuY
         qLeIdGWeDZb6MtXK9oL9kohenlpCMbG1luj+mBjuFVr8pmwgNUj3rxlMk7ImvXBSF7
         A8kJ6L2ph05ivyjQpDBUJ/D62YOuUKl8tAs3WVNkPDjxjp9qXZOw3lcorTVwSBEMax
         rJY+ZSRv+EKMA==
Date:   Thu, 30 Aug 2018 13:01:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 30
Message-ID: <20180830130119.7697f43e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LuY.AF1Nq1rdbzoo_P6ENJs"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LuY.AF1Nq1rdbzoo_P6ENJs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180829:

New trees: soundwire and soundwire-fixes

Dropped trees: xarray, ida (temporarily)

The spi tree lost its build failure.

Non-merge commits (relative to Linus' tree): 1087
 1284 files changed, 44936 insertions(+), 12978 deletions(-)

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

I am currently merging 286 trees (counting Linus' and 66 trees of bug
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
Merging origin/master (3f16503b7d22 Merge branch 'fixes' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (ad1d69735878 Merge tag 'fuse-update-4.19' of =
git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse)
Merging arc-current/for-curr (fce0d0affdc5 ARC: cleanup show_faulting_vma())
Merging arm-current/fixes (afc9f65e01cd ARM: 8781/1: Fix Thumb-2 syscall re=
turn for binutils 2.29+)
Merging arm64-fixes/for-next/fixes (5ad356eabc47 arm64: mm: check for upper=
 PAGE_SHIFT bits in pfn_valid())
Merging m68k-current/for-linus (71a896687b85 m68k/defconfig: Update defconf=
igs for v4.18-rc6)
Merging powerpc-fixes/fixes (cca19f0b684f powerpc/64s/radix: Fix missing gl=
obal invalidations when removing copro)
Merging sparc/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (53ae914d898e net/rds: Use rdma_read_gids to get connect=
ion SGID/DGID in IPv6)
Merging bpf/master (d65e6c80c6bb Merge branch 'bpf_msg_pull_data-fixes')
Merging ipsec/master (25432eba9cd8 openvswitch: meter: Fix setting meter id=
 for new entries)
Merging netfilter/master (0434ccdcf883 netfilter: nf_tables: rework ct time=
out set support)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (53ae914d898e net/rds: Use rdma_read_gids t=
o get connection SGID/DGID in IPv6)
Merging mac80211/master (166ac9d55b0a mac80211: avoid kernel panic when bui=
lding AMSDU from non-linear SKB)
Merging rdma-fixes/for-rc (5b394b2ddf03 Linux 4.19-rc1)
Merging sound-current/for-linus (8a328ac1f9eb ALSA: hda/realtek - Fix HP He=
adset Mic can't record)
Merging sound-asoc-fixes/for-linus (c4305768a542 Merge branch 'asoc-4.19' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging regulator-fixes/for-linus (823f18f8b860 regulator: bd71837: Disable=
 voltage monitoring for LDO3/4)
Merging spi-fixes/for-linus (9a92a569272a Merge branch 'spi-4.19' into spi-=
linus)
Merging pci-current/for-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging driver-core.current/driver-core-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging tty.current/tty-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging usb.current/usb-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-gadget-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-serial-fixes/usb-linus (5dfdd24eb3d3 USB: serial: ti_usb_3410_5=
052: fix array underflow in completion handler)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (ad5003300b07 phy: mapphone-mdm6600: Fix wrong enum used =
for status lines)
Merging staging.current/staging-linus (f86cf25a6091 Revert "staging: erofs:=
 disable compiling temporarile")
Merging char-misc.current/char-misc-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging soundwire-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging input-current/for-linus (13fe7056bebb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (3d7c82060d1f crypto: cavium/nitrox - fix for=
 command corruption in queue full case with backlog submissions.)
Merging ide/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (111b009f7e8b dmaengine: mic_x100_dma: use de=
vm_kzalloc to fix an issue)
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (336d139f8718 mtd: rawnand: denali: do not pass ze=
ro maxchips to nand_scan())
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (ce397d215ccd Linux 4.18-rc1)
Merging v4l-dvb-fixes/fixes (3799eca51c5b media: camss: add missing include=
s)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (d5ea019f8a38 Revert "MIPS: BCM47XX: Enable 7=
4K Core ExternalSync for PCIe erratum")
Merging at91-fixes/at91-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging omap-fixes/fixes (2d59bb602314 ARM: dts: omap4-droid4: Fix emmc err=
ors seen on some devices)
Merging kvm-fixes/master (5b394b2ddf03 Linux 4.19-rc1)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (d49dbfade96d hwmon: (nct6775) Fix potential Spec=
tre v1)
Merging nvdimm-fixes/libnvdimm-fixes (ee6581ceba7f nfit: fix unchecked dere=
ference in acpi_nfit_ctl)
Merging btrfs-fixes/next-fixes (784708458494 Merge branch 'for-next-current=
-v4.19-20180823' into next-fixes)
Merging vfs-fixes/fixes (4c0d7cd5c841 make sure that __dentry_kill() always=
 invalidates d_seq, unhashed or not)
Merging dma-mapping-fixes/for-linus (f4d89008e95d kernel/dma/direct: take D=
MA offset into account in dma_direct_supported)
Merging drivers-x86-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging samsung-krzk-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging devicetree-fixes/dt/linus (b9952b5218ad of: overlay: update phandle=
 cache on overlay apply and remove)
Merging scsi-fixes/fixes (b9eb3b14f1db scsi: aacraid: fix a signedness bug)
Merging drm-fixes/drm-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-intel-fixes/for-linux-next-fixes (80ab316901bc drm/i915/audio: =
Hook up component bindings even if displays are disabled)
Merging mmc-fixes/fixes (d2332f887ddf mmc: renesas_sdhi_internal_dmac: mask=
 DMAC interrupts)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (6dcece71c721 drm/pl111: Make s=
ure of_device_id tables are NULL terminated)
Merging kbuild/for-next (d503ac531a52 kbuild: rename LDFLAGS to KBUILD_LDFL=
AGS)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (6fa1d28e38cf sh: use generic dma_noncoherent_=
ops)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (6f6874f70c32 Merge branch 'clkdev' into for-next)
Merging arm-perf/for-next/perf (5b394b2ddf03 Linux 4.19-rc1)
Merging arm-soc/for-next (165f6fe1c2bf ARM: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (aba1d0325bc2 ARM: dts: meson8b: fix the clock con=
troller register size)
Merging aspeed/for-next (c224edaa4a46 Merge branches 'defconfig-for-v4.19' =
and 'dt-for-v4.19' into for-next)
Merging at91/at91-next (f69ee8eba4f2 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (5997adb14985 Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
CONFLICT (content): Merge conflict in drivers/hwmon/Kconfig
CONFLICT (content): Merge conflict in drivers/firmware/raspberrypi.c
Merging imx-mxs/for-next (abadb73b9b3b Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (b75253e66bc5 Merge branch 'v4.18-next/soc' into =
for-next)
Merging mvebu/for-next (23b7c60b80f6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging reset/reset/next (d903779b58be reset: meson: add meson audio arb dr=
iver)
Merging qcom/for-next (76b9e7f947f1 Merge tag 'qcom-defconfig-for-4.19' int=
o all-for-4.19)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (313824b0dedc Merge branches 'arm-defconfig-for-v4.20'=
, 'arm-dt-for-v4.20', 'arm-soc-for-v4.20', 'arm64-dt-for-v4.20', 'arm64-def=
config-for-v4.20', 'drivers-for-v4.20' and 'dt-bindings-for-v4.20' into nex=
t)
Merging rockchip/for-next (01489c481858 Merge branch 'v4.20-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (64858773d78e ARM: dts: exynos: Fix sound in =
Snow-rev5 Chromebook)
Merging sunxi/sunxi/for-next (bb107114d290 Merge branches 'sunxi/h3-h5-for-=
4.20' and 'sunxi/dt64-for-4.20' into sunxi/for-next)
Merging tegra/for-next (f29cfb31cf00 Merge branch for-4.19/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (3c4d9137eefe arm64: alternative: Use true and =
false for boolean values)
Merging clk/clk-next (f338c65f7529 Merge branch 'clk-qcom-qspi' into clk-ne=
xt)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging m68k/for-next (71a896687b85 m68k/defconfig: Update defconfigs for v=
4.18-rc6)
Merging m68knommu/for-next (08df5c54356b m68k: fix early memory reservation=
 for ColdFire MMU systems)
Merging microblaze/next (c4347b05440f microblaze/PCI: Remove stale pcibios_=
align_resource() comment)
Merging mips/mips-next (feef7918667b MIPS: BCM47XX: Enable USB power on Net=
gear WNDR3400v3)
Merging nds32/next (a5fe7c46e245 nds32: fix build error because of wrong se=
micolon)
Merging nios2/for-next (c7c09dc187f0 nios2: kconfig: remove duplicate DEBUG=
_STACK_USAGE symbol defintions)
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (7efbe131b5b0 parisc: remove the dead ccio-rm-dm=
a driver)
Merging powerpc/next (0f52b3a00c78 powerpc/mce: Fix SLB rebolting during MC=
E recovery path.)
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (bd96461249bd powerpc/dts/fsl: t2080rdb: use the Cortina P=
HY driver compatible)
Merging risc-v/for-next (2421a97a0fc5 riscv: Do not overwrite initrd_start =
and initrd_end)
Merging s390/features (4ec84835900b s390: remove gcc version check (4.3 or =
newer))
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (d9cbd0e8f667 um: NULL check before kfree is not nee=
ded)
Merging xtensa/xtensa-for-next (7bc8c12abba0 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (1e5f18740238 Merge branch 'for-next-current-v=
4.19-20180817' into for-next-20180817)
Merging ceph/master (ed72a66f8ee2 ceph: avoid a use-after-free in ceph_dest=
roy_options())
Merging cifs/for-next (8166a20b5af4 SMB3: Backup intent flag missing from c=
ompounded ops)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (ee4af50ca94f udf: Fix mounting of Win7 created UDF f=
ilesystems)
Merging ext4/dev (863c37fcb14f ext4: remove unneeded variable "err" in ext4=
_mb_release_inode_pa())
Merging f2fs/dev (3f16503b7d22 Merge branch 'fixes' of git://git.kernel.org=
/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal)
Merging fuse/for-next (963545357202 fuse: reduce allocation size for splice=
_write)
Merging jfs/jfs-next (bd646104ac5a jfs: use time64_t for otime)
Merging nfs/linux-next (94710cac0ef4 Linux 4.18)
Merging nfs-anna/linux-next (0af4c8be97a1 pNFS: Remove unwanted optimisatio=
n of layoutget)
Merging nfsd/nfsd-next (108b833cde9c sunrpc: Add comment defining gssd upca=
ll API keywords)
Merging orangefs/for-next (e1b437691a62 orangefs: remove redundant pointer =
orangefs_inode)
Merging overlayfs/overlayfs-next (989974c80457 ovl: Enable metadata only fe=
ature)
Merging ubifs/linux-next (6e5461d774bf ubifs: Remove empty file.h)
Merging v9fs/9p-next (62e3941776fe 9p: clear dangling pointers in p9stat_fr=
ee)
Merging xfs/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging file-locks/locks-next (10f3e23f07cb Merge tag 'ext4_for_linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4)
Merging vfs/for-next (851ac0e8b7d6 Merge branch 'work.mount' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Applying: vfs: samples: fix up for HOSTLOADLIBES rename
Applying: staging: erofs: disable compiling temporarile
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a4322becd21e Merge branch 'for-4.19-nmi' into for-=
next)
Merging pci/next (5b394b2ddf03 Linux 4.19-rc1)
Merging pstore/for-next/pstore (1021bcf44d0e pstore: add zstd compression s=
upport)
Merging hid/for-next (18c31465c84e Merge branch 'for-4.20/core' into for-ne=
xt)
Merging i2c/i2c/for-next (00efcdce67a3 i2c: don't use any __deprecated hand=
ling anymore)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (62f5146e137b hwmon: (ibmpowernv) drop unn=
ecessary OF name NULL checks)
Merging jc_docs/docs-next (3d83d3188460 Documentation: corrections to conso=
le/console.txt)
Merging v4l-dvb/master (3799eca51c5b media: camss: add missing includes)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (f39684524b39 Documentation/fb: corrections fo=
r fbcon.txt)
Merging pm/linux-next (501b192d0299 Merge branches 'pm-cpuidle' and 'pm-cor=
e' into linux-next)
Merging cpupower/cpupower (8a7e2d2ea080 cpupower: remove stringop-truncatio=
n waring)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (c5c2a97b3ac7 PM / OPP: Update voltage in case f=
req =3D=3D old_freq)
Merging thermal/next (d7a4303b8d1f dt-bindings: thermal: Allow multiple dev=
ices to share cooling map)
Merging thermal-soc/next (152395fd03d4 thermal: of-thermal: disable passive=
 polling when thermal zone is disabled)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging net-next/master (817e60a7a2bb Merge branch 'nfp-add-NFP5000-support=
')
Merging bpf-next/master (29b5e0f34359 Merge branch 'AF_XDP-zerocopy-for-i40=
e')
Merging ipsec-next/master (4a132095dd64 xfrm: allow driver to quietly refus=
e offload)
Merging mlx5-next/mlx5-next (664000b6bb43 net/mlx5: Add support for flow ta=
ble destination number)
Merging netfilter-next/master (2ad0d5269970 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/net)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (9cac6a9b6297 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (bb010103671c Bluetooth: hci_serdev: Add protocol =
check in hci_uart_dequeue().)
Merging mac80211-next/master (9c06602b1b92 cfg80211: clarify frames covered=
 by average ACK signal report)
Merging gfs2/for-next (4f36cb36c9d1 gfs2: Don't set GFS2_RDF_UPTODATE when =
the lvb is updated)
Merging mtd/mtd/next (5b394b2ddf03 Linux 4.19-rc1)
Merging nand/nand/next (ed128e8b757b MAINTAINERS: drop Wenyou Yang from Atm=
el NAND driver support)
Merging spi-nor/spi-nor/next (bb276262e88d mtd: spi-nor: only apply reset h=
acks to broken hardware)
Merging crypto/master (22240df7ac6d crypto: arm64/ghash-ce - implement 4-wa=
y aggregation)
Merging drm/drm-next (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (2693efd99cad drm/i915/audio: Hook up comp=
onent bindings even if displays are disabled)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (a6edf83922ef drm/rockchip: vop: fix some r=
egister define error for px30)
Merging drm-msm/msm-next (546907de9952 drm/msm: a6xx: fix spelling mistake:=
 "initalization" -> "initialization")
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (e368fc75c190 drm/arm/malidp: Added th=
e late system pm functions)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (5c41bb607125 gpu: ipu-v3: add support for XRG=
B32 and XBGR32 V4L2 pixel formats)
Merging etnaviv/etnaviv/next (5b1474655323 drm/etnaviv: fix crash in GPU su=
spend when init failed due to buffer placement)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging sound/for-next (87246f7fd572 ALSA: intel_hdmi: Use the new non-cach=
ed allocation)
Merging sound-asoc/for-next (7d18ba6aece8 Merge branch 'asoc-4.20' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (100294cee9a9 Input: do not use WARN() in input_alloc_ab=
sinfo())
Merging block/for-next (0c27b3c578ff Merge branch 'for-4.19/post' into for-=
next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (1e1132ea21da dm writecache: fix a crash due=
 to reading past end of dirty_bitmap)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (3c864d356034 mmc: sdhci-of-dwcmshc: solve 128MB DMA bound=
ary limitation)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (d63e2fc804c4 md/raid5: fix data corruption of replacem=
ents after originals dropped)
Merging mfd/for-mfd-next (d2c9281c184b mfd: madera: Add register definition=
s for accessory detect)
Merging backlight/for-backlight-next (633786736ed5 backlight: pwm_bl: Fix u=
ninitialized variable)
Merging battery/for-next (7b38ebdf7430 power: supply: maxim: Add SPDX licen=
se identifiers)
Merging regulator/for-next (af9f7220fddc Merge branch 'regulator-4.20' into=
 regulator-next)
Merging security/next-testing (d83c732fffc3 Merge branch 'smack-for-4.19-a'=
 of https://github.com/cschaufler/next-smack into next-testing)
Merging apparmor/apparmor-next (c037bd615885 apparmor: remove no-op permiss=
ion check in policy_unpack)
Merging integrity/next-integrity (3dd0f18c70d9 EVM: fix return value check =
in evm_write_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (7e4237faa721 selinux: cleanup dentry and inodes on er=
ror in selinuxfs)
Merging tpmdd/next (ec403d8ed08c ima: Get rid of ima_used_chip and use ima_=
tpm_chip !=3D NULL instead)
Merging watchdog/master (74081c9f16a2 dt-bindings: watchdog: renesas-wdt: D=
ocument r8a774a1 support)
Merging iommu/next (6488a7f35eea Merge branches 'arm/shmobile', 'arm/renesa=
s', 'arm/msm', 'arm/smmu', 'arm/omap', 'x86/amd', 'x86/vt-d' and 'core' int=
o next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0dd0e297f0ec vfio-pci: Disable binding to PFs with SR-IO=
V enabled)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (baa2a4fdd525 audit: fix use-after-free in audit_add_wat=
ch)
Merging devicetree/for-next (f11b9abc9318 Documentation: remove dynamic-res=
olution-notes reference to non-existent file)
Merging mailbox/mailbox-for-next (2bb7005696e2 mailbox: Add support for i.M=
X messaging unit)
Merging spi/for-next (5a5d2c4118a5 Merge branch 'spi-4.20' into spi-next)
Merging tip/auto-latest (e3a5dc08715a x86/Kconfig: Fix trivial typo)
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (8960de4a5ca7 EDAC, amd64: Add Family 17h, models=
 10h-2fh support)
Merging irqchip/irq/irqchip-next (4110b5cbb014 irqchip/gic-v3: Allow interr=
upt to be configured as wake-up sources)
Merging ftrace/for-next (bb730b5833b5 tracing: Fix SPDX format headers to u=
se C++ style comments)
Merging rcu/rcu/next (d57fa29ddc3c Merge LKMM and RCU commits)
Merging kvm/linux-next (5b394b2ddf03 Linux 4.19-rc1)
Merging kvm-arm/next (976d34e2dab1 KVM: arm/arm64: Skip updating PTE entry =
if no change)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (46dec40fb741 KVM: PPC: Book3S HV: Don't trunc=
ate HPTE index in xlate function)
Merging kvms390/next (237584619366 Merge tag 'hlp_stage1' of git://git.kern=
el.org/pub/scm/linux/kernel/git/kvms390/linux into kvms390/next)
Merging xen-tip/linux-next (6d3c8ce012ce x86/xen: remove redundant variable=
 save_pud)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (f813eec972ee leds: Convert to using %pOFn instead of=
 device_node.name)
Merging ipmi/for-next (0192915d2331 ipmi: Convert pr_xxx() to dev_xxx() in =
the BT code)
Merging driver-core/driver-core-next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb/usb-next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-gadget/next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-serial/usb-next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-chipidea-next/ci-for-usb-next (ba0ab35a81de usb: chipidea: tegr=
a: Use aligned DMA on Tegra114/124)
Merging phy-next/next (ec14b83a1ee4 phy: mvebu-cp110-comphy: switch to SPDX=
 identifier)
Merging tty/tty-next (5b394b2ddf03 Linux 4.19-rc1)
Merging char-misc/char-misc-next (5b394b2ddf03 Linux 4.19-rc1)
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (14b0c44af4e9 soundwire: intel: Remove duplicate ass=
ignment)
Merging staging/staging-next (3e195a80e096 Staging: octeon-usb: Replaces CV=
MX_WAIT_FOR_FIELD32 macro with a function)
Merging mux/for-next (2c01260df661 mux: add mux_control_get_optional() API)
Merging slave-dma/next (f9916dc9104d Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (714d7fe777fc Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/qla2xxx/qla_init.c
Merging scsi-mkp/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (1e05b62ae4bd sh: use the the PCI channels's io_ma=
p_base)
Merging rpmsg/for-next (5d449f919685 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (f86e1a639a54 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (1ab75c1a1deb Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging pwm/for-next (8cdc43afbb2c pwm: mediatek: Add MT7628 support)
Merging userns/for-next (82c9a927bc5d getxattr: use correct xattr length)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9a47249d444d random: Make crng state queryable)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (c31d02d1290e selftests: kselftest: Remove outdated =
comment)
Merging y2038/y2038 (49c39f8464a9 y2038: signal: Change rt_sigtimedwait to =
use __kernel_timespec)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (9cda9e8f28d7 coresight: etb10: Splitting function e=
tb_enable())
Merging rtc/rtc-next (ac771ed746c8 rtc: rv8803: add Epson RX8803 support)
Merging nvdimm/libnvdimm-for-next (af429e33d308 Merge branch 'for-4.19/dax-=
memory-failure' into libnvdimm-for-next)
Merging at24/at24/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (43bd0619727c Merge branch 'for-next/gcc-plugin-=
infrastructure' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging fsi/master (15e2a7218c27 fsi: sbefifo: Bump max command length)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging akpm-current/current (68565082aedf mm/page_alloc.c: clean up check_=
for_memory())
CONFLICT (content): Merge conflict in include/linux/sched.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (2e4467d930d3 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/LuY.AF1Nq1rdbzoo_P6ENJs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluHXf8ACgkQAVBC80lX
0GyXdgf/cO09HKR0lHSWnn1Wdi5FMnwdQM8iHWCUbSvshhGTaf5CIXNKkRfONyyS
ylQS0DclGpF3zkK1W4tWXwVPXMFV5EUGy2uobUoj91/g8nhuOSMe4dalIFA6faPf
cMIL/QqJl35w4ijkc/XjcxnJTOD4PqZCYPbm9WGOf6zHgOKb7SSFr48cWeZwO1Cg
INfCYZjpr7FgYxAWVTUg1mfcH6UIYkxL2es6d/G/CkbPJWwsJM4d2SfkInrHXoE7
MalfJwaoZexRlH4oJi355DqQW6j5Wb95FlbFMG/7SdySCMUsC6yr/iFm5KXsoG9x
52M2PlVVXRIqWqnjlbjFscctgljGcA==
=n1pr
-----END PGP SIGNATURE-----

--Sig_/LuY.AF1Nq1rdbzoo_P6ENJs--
