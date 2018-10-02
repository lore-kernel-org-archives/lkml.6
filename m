Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96748C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF3720652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MkcrvWCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF3720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJBQAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:00:40 -0400
Received: from ozlabs.org ([203.11.71.1]:47515 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbeJBQAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:00:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42PYV25Qcvz9s55;
        Tue,  2 Oct 2018 19:18:18 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1538471898;
        bh=1n1RgtPIwQJMD7YAAtDGGEOlDZtJZyFr9M6nldGbNf0=;
        h=Date:From:To:Cc:Subject:From;
        b=MkcrvWCG13rcc0bZLvPnHUnyLBIAlb8L3EmDqb9lXaJQSVqG/0u9PntjK5a5otpHx
         E/tfs7QrghOXQknB4y+fyXd4czIfAQFwYstxoaMdA99GGgbPSe5CH9cISio6EOx8eG
         SZe26NMZb3ktEZYdtXS847KkKC+nY2erOllPWqhB0rk+llcpeu1L5J0+ZVAQv8TgRG
         f7wu6b95FeYfW2j7tpdJyQhMoBnGz3BWwXPnlMAX40PCVAQkznPFEtnrIQK+UqzXmb
         fjsd2Wy0hFoKAlKBRT5BQ7rqllfG6qjdDHKFllZ+lylVJtlYo6UJGPf6E1gEgnS7U9
         1qZS3iyAbsV/Q==
Date:   Tue, 2 Oct 2018 19:18:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 2
Message-ID: <20181002191818.1c2eec51@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/cWmvwE448F=LurxZ0ZQ.5F."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cWmvwE448F=LurxZ0ZQ.5F.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180928:

Restored trees: ia64, xarray

Removed tree: ida

The devicetree tree gained a conflict against the qcom tree.

The cisco tree gained a conflict against the vfs tree.

The xarray tree gained a conflict against Linus' tree.

The akpm-current tree gained conflicts against the block and xarray trees.

The akpm tree gained conflicts against the dma-mapping tree.

Non-merge commits (relative to Linus' tree): 7593
 7465 files changed, 345368 insertions(+), 156173 deletions(-)

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

I am currently merging 290 trees (counting Linus' and 66 trees of bug
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
Merging origin/master (17b57b1883c1 Linux 4.19-rc6)
Merging fixes/master (72358c0b59b7 linux-next: build warnings from the buil=
d of Linus' tree)
Merging kbuild-current/fixes (ef8c4ed9db80 kbuild: allow to use GCC toolcha=
in not in Clang search path)
Merging arc-current/for-curr (40660f1fcee8 ARC: build: Don't set CROSS_COMP=
ILE in arch's Makefile)
Merging arm-current/fixes (3a58ac65e2d7 ARM: 8799/1: mm: fix pci_ioremap_io=
() offset check)
Merging arm64-fixes/for-next/fixes (2a3f93459d68 arm64: KVM: Sanitize PSTAT=
E.M when being set from userspace)
Merging m68k-current/for-linus (0986b16ab49b m68k/mac: Use correct PMU resp=
onse format)
Merging powerpc-fixes/fixes (7e0cf1c983b5 selftests/powerpc: Fix Makefiles =
for headers_install change)
Merging sparc/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (43955a45dc0b netlink: fix typo in nla_parse_nested() co=
mment)
Merging bpf/master (4288ea006c73 bpf: harden flags check in cgroup_storage_=
update_elem())
Merging ipsec/master (32bf94fb5c2e xfrm: validate template mode)
Merging netfilter/master (40e4f26e6a14 netfilter: xt_socket: check sk befor=
e checking for netns.)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (3baafeffa48a iwlwifi: 1000: set the TFD qu=
eue size)
Merging mac80211/master (848e616e66d4 cfg80211: fix wext-compat memory leak)
Merging rdma-fixes/for-rc (5c5702e259dc RDMA/core: Set right entry state be=
fore releasing reference)
Merging sound-current/for-linus (b3a5402cbceb ALSA: hda: Fix the audio-comp=
onent completion timeout)
Merging sound-asoc-fixes/for-linus (6f450574b28f Merge branch 'asoc-4.19' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (7876320f8880 Linux 4.19-rc4)
Merging regulator-fixes/for-linus (17b57b1883c1 Linux 4.19-rc6)
Merging spi-fixes/for-linus (17b57b1883c1 Linux 4.19-rc6)
Merging pci-current/for-linus (95375f2ab296 PCI: mvebu: Fix PCI I/O mapping=
 creation sequence)
Merging driver-core.current/driver-core-linus (7876320f8880 Linux 4.19-rc4)
Merging tty.current/tty-linus (17b57b1883c1 Linux 4.19-rc6)
Merging usb.current/usb-linus (17b57b1883c1 Linux 4.19-rc6)
Merging usb-gadget-fixes/fixes (d9707490077b usb: dwc2: Fix call location o=
f dwc2_check_core_endianness)
Merging usb-serial-fixes/usb-linus (f5fad711c06e USB: serial: simple: add M=
otorola Tetra MTP6550 id)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging staging.current/staging-linus (7876320f8880 Linux 4.19-rc4)
Merging char-misc.current/char-misc-linus (7012040576c6 firmware: Always in=
itialize the fw_priv list object)
Merging soundwire-fixes/fixes (8d6ccf5cebbc soundwire: Fix acquiring bus lo=
ck twice during master release)
Merging input-current/for-linus (4fef1250eafd Input: uinput - allow for max=
 =3D=3D min during input_absinfo validation)
Merging crypto-current/master (ba439a6cbfa2 crypto: qat - Fix KASAN stack-o=
ut-of-bounds bug in adf_probe())
Merging ide/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (ce01a1575f45 rseq/selftests: fix parametrize=
d test with -fpie)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (111b009f7e8b dmaengine: mic_x100_dma: use de=
vm_kzalloc to fix an issue)
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (6bf4ca7fbc85 Linux 4.19-rc5)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (10492ee8ed91 mfd: omap-usb-host: Fix dts p=
robe of children)
Merging v4l-dvb-fixes/fixes (324493fba775 media: platform: fix cros-ec-cec =
build error)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (e7e86f42fa68 MAINTAINERS: MIPS/LOONGSON2 ARC=
HITECTURE - Use the normal wildcard style)
Merging at91-fixes/at91-fixes (379e36d3f591 ARM: dts: at91: sama5d2_ptc_ek:=
 fix nand pinctrl)
Merging omap-fixes/fixes (c265c0ca76fb ARM: dts: logicpd-som-lv: Fix OMAP35=
/DM37 Compatibility issues)
Merging kvm-fixes/master (26b471c7e2f7 KVM: nVMX: Fix bad cleanup on error =
of get/set nested state IOCTLs)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (234b69e3e089 ocfs2: fix ocfs2 read block panic)
Merging nvdimm-fixes/libnvdimm-fixes (f52afc93cd01 dax: Fix deadlock in dax=
_lock_mapping_entry())
Merging btrfs-fixes/next-fixes (675c168b2b92 Merge branch 'misc-4.19' into =
next-fixes)
Merging vfs-fixes/fixes (ffc4c92227db sysfs: Do not return POSIX ACL xattrs=
 via listxattr)
Merging dma-mapping-fixes/for-linus (46bbeb69ff2f dma-mapping: add the miss=
ing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration)
Merging drivers-x86-fixes/fixes (6bf4ca7fbc85 Linux 4.19-rc5)
Merging samsung-krzk-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging devicetree-fixes/dt/linus (e54192b48da7 of: fix phandle cache creat=
ion for DTs with no phandles)
Merging scsi-fixes/fixes (3cc5746e5ad7 scsi: qedi: Initialize the stats mut=
ex lock)
Merging drm-fixes/drm-fixes (fcb1349a2af5 Merge branch 'drm-fixes-4.19' of =
git://people.freedesktop.org/~agd5f/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (4ca8ca9fe7dc drm/i915: Avoid =
compiler warning for maybe unused gu_misc_iir)
Merging mmc-fixes/fixes (1b09d9c232cd mmc: slot-gpio: Fix debounce time to =
use miliseconds again)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (d6a77ba0eb92 Revert "drm/panel=
: Add device_link from panel device to DRM device")
Merging kbuild/for-next (7163c4dce053 Merge branch 'kbuild' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (9d7a224b463e dma-direct: always allow dma mas=
k <=3D physiscal memory size)
CONFLICT (content): Merge conflict in kernel/dma/Kconfig
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (db2add336999 Merge branches 'fixes', 'misc' and 'spec=
tre' into for-next)
Merging arm-perf/for-next/perf (5b394b2ddf03 Linux 4.19-rc1)
Merging arm-soc/for-next (bf05961936be arm-soc: document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (6c61c0e7d95a Merge branch 'v4.20/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (3368e06e2a91 ARM: dts: aspeed: Adding Facebook Tio=
gaPass BMC)
Merging at91/at91-next (4a2a8be2f29d Merge branches 'at91-drivers', 'at91-s=
oc', 'at91-dt' and 'at91-defconfig' into at91-next)
Merging bcm2835/for-next (ca5b45b7c5cd Merge branch 'bcm2835-defconfig-next=
' into for-next)
Merging imx-mxs/for-next (2ed85963b996 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (42ac5fee3a13 Merge branch 'v4.19-next/soc' into =
for-next)
Merging mvebu/for-next (f93389899892 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (88f222be04a7 Merge branch 'omap-for-v4.20/dt' into f=
or-next)
Merging reset/reset/next (d903779b58be reset: meson: add meson audio arb dr=
iver)
Merging qcom/for-next (6252f3298861 Merge tag 'qcom-arm64-defconfig-for-4.2=
0' into 4.20-tagged)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (2586035c01f6 Merge branches 'arm-defconfig-for-v4.20'=
, 'arm-dt-for-v4.20', 'arm-soc-for-v4.20', 'arm64-dt-for-v4.20' and 'driver=
s-for-v4.20' into next)
Merging rockchip/for-next (276647f89f9c Merge branch 'v4.20-armsoc/defconfi=
g64' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (b9acde832ba8 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (25c5fc5a4923 Merge branch 'sunxi/h3-h5-for-4.=
20' into sunxi/for-next)
Merging tegra/for-next (22fed951fe3b Merge branch for-4.20/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (c219bc4e9205 arm64: Trap WFI executed in users=
pace)
Merging clk/clk-next (173861bea8a1 Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (519570ff75a1 clk: samsung: exynos5433: Keep s=
clk_uart clocks enabled in suspend)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging csky/linux-next (c4b17dd4a3cc csky: remove NSIGXXX in abiv2/fpu.c)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging ia64/next (02b4da5f84d1 intel-iommu: mark intel_dma_ops static)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (bbd4744f8a27 m68k: fix command-line parsing whe=
n passed from u-boot)
Merging microblaze/next (c4347b05440f microblaze/PCI: Remove stale pcibios_=
align_resource() comment)
Merging mips/mips-next (2f0b649b3b4a MIPS: stop using _PTRS_PER_PGD)
Merging nds32/next (3350139c0ff3 nds32: linker script: GCOV kernel may refe=
rs data in __exit)
Merging nios2/for-next (c7c09dc187f0 nios2: kconfig: remove duplicate DEBUG=
_STACK_USAGE symbol defintions)
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (2c18d35d677d parisc: Remove PTE load and fault =
check from L2_ptep macro)
Merging powerpc/next (0823c68b054b powerpc/fadump: re-register firmware-ass=
isted dump if already registered)
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (bd96461249bd powerpc/dts/fsl: t2080rdb: use the Cortina P=
HY driver compatible)
Merging risc-v/for-next (6bf4ca7fbc85 Linux 4.19-rc5)
Merging s390/features (ccc413f62143 s390/qdio: clean up AOB handling)
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (d9cbd0e8f667 um: NULL check before kfree is not nee=
ded)
Merging xtensa/xtensa-for-next (c9efd0d7beb3 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (89067b62df5b Merge branch 'for-next-next-v4.2=
0-20180914' into for-next-20180914)
Merging ceph/master (e92c0eaf7543 rbd: support cloning across namespaces)
Merging cifs/for-next (07f9750589c7 smb3: add tracepoint for sending lease =
break responses to server)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (12f0d3d810c0 Merge fanotify support for reporting PI=
D instead of TGID.)
Merging ext4/dev (cce6c9f7e602 ext4, dax: set ext4_dax_aops for dax files)
Merging f2fs/dev (61f7725aa148 f2fs: return correct errno in f2fs_gc)
Merging fuse/for-next (e52a8250480a fuse: realloc page array)
Merging jfs/jfs-next (1390643d1d5c jfs: remove redundant dquot_initialize()=
 in jfs_evict_inode())
Merging nfs/linux-next (c7944ebb9ce9 NFSv4: Fix lookup revalidate of regula=
r files)
Merging nfs-anna/linux-next (9f0c5124f4a8 NFS: Don't open code clearing of =
delegation state)
Merging nfsd/nfsd-next (7d20b6a2728f nfsd: remove set but not used variable=
 'dirp')
Merging orangefs/for-next (a3bb1b184669 Orangefs: some error code paths mis=
sed kmem_cache_free to bad effect.)
Merging overlayfs/overlayfs-next (69383c5913a5 ovl: make symbol 'ovl_aops' =
static)
Merging ubifs/linux-next (f061c1cc404a Revert "ubifs: xattr: Don't operate =
on deleted inodes")
Merging v9fs/9p-next (76b600d46911 9p: potential NULL dereference)
Merging xfs/for-next (e55ec4ddbef9 xfs: fix error handling in xfs_bmap_exte=
nts_to_btree)
Merging file-locks/locks-next (10f3e23f07cb Merge tag 'ext4_for_linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4)
Merging vfs/for-next (f022b08a0a9b Merge branches 'work.mount', 'work.alpha=
' and 'work.compat' into for-next)
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a6ae928c2583 Revert "printk: make sure to print lo=
g on console.")
Merging pci/next (b51b273e4c5e Merge branch 'remotes/lorenzo/pci/mediatek')
Merging pstore/for-next/pstore (bac6f6cda206 pstore/ram: Fix failure-path m=
emory leak in ramoops_init)
Merging hid/for-next (c05be11e7762 Merge branch 'for-4.20/i2c-hid' into for=
-next)
Merging i2c/i2c/for-next (210932079eb9 Merge branch 'i2c/for-4.20' into i2c=
/for-next)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (7de1ab9dac8e hwmon: (ina3221) Add suspend=
 and resume functions)
Merging jc_docs/docs-next (ff348763775e doc: Fix acronym "FEKEK" in ecryptf=
s)
Merging v4l-dvb/master (4158757395b3 media: davinci: Fix implicit enum conv=
ersion warning)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (7c968791f775 video/fbdev/stifb: Fix spelling =
mistake in fall-through annotation)
Merging pm/linux-next (2eb458f5f636 Merge branches 'acpi-debug' and 'acpi-s=
oc' into linux-next)
Merging cpupower/cpupower (8a7e2d2ea080 cpupower: remove stringop-truncatio=
n waring)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (5ed4cecd75e9 OPP: Pass OPP table to _of_add_opp=
_table_v{1|2}())
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
Merging rdma/for-next (c8b53d0c5eb8 IB/sa: simplify return code logic for i=
b_nl_send_msg())
CONFLICT (content): Merge conflict in drivers/infiniband/core/cache.c
Merging net-next/master (3bd09b05b068 Merge tag 'mlx5e-updates-2018-10-01' =
of git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux)
CONFLICT (modify/delete): Documentation/networking/00-INDEX deleted in HEAD=
 and modified in net-next/master. Version net-next/master of Documentation/=
networking/00-INDEX left in tree.
$ git rm -f Documentation/networking/00-INDEX
Merging bpf-next/master (cb86d0f878be Merge branch 'bpf-per-cpu-cgroup-stor=
age')
Merging ipsec-next/master (4a132095dd64 xfrm: allow driver to quietly refus=
e offload)
Merging mlx5-next/mlx5-next (bd37197554eb net/mlx5: Update mlx5_ifc with DE=
VX UID bits)
Merging netfilter-next/master (a2d88182d28d netfilter: nf_tables: use rhash=
table_lookup() instead of rhashtable_lookup_fast())
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (08b0109eea36 Merge tag 'iwlwifi-next-=
for-kalle-2018-09-28' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlw=
ifi/iwlwifi-next)
Merging bluetooth/master (30d65e0804d5 Bluetooth: Fix debugfs NULL pointer =
dereference)
Merging mac80211-next/master (fe80610bedf2 mac80211: Remove unused initiali=
zation)
Merging gfs2/for-next (4f36cb36c9d1 gfs2: Don't set GFS2_RDF_UPTODATE when =
the lvb is updated)
Merging mtd/mtd/next (5b394b2ddf03 Linux 4.19-rc1)
Merging nand/nand/next (40667c037a3d mtd: rawnand: Allow selection of ECC b=
yte ordering at runtime)
Merging spi-nor/spi-nor/next (af8b35f392bb mtd: spi-nor: cadence-quadspi: U=
se proper enum for dma_[un]map_single)
Merging crypto/master (79517e8f8e6d crypto: cavium - remove redundant null =
pointer check before kfree)
Merging drm/drm-next (87c2ee740c07 Merge branch 'drm-next-4.20' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (87c2ee740c07 Merge branch 'drm-next-4.20'=
 of git://people.freedesktop.org/~agd5f/linux into drm-next)
Merging drm-tegra/drm/tegra/for-next (5ac93f81096a drm/tegra: Detach device=
s from IOMMU DMA domain on arm32)
Merging drm-misc/for-linux-next (87c2ee740c07 Merge branch 'drm-next-4.20' =
of git://people.freedesktop.org/~agd5f/linux into drm-next)
Merging drm-msm/msm-next (96ab39afea7b drm/msm/A6xx: Send the right perf in=
dex value to GMU)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (bfde4538e64c drm/arm/malidp: Validate=
 rotations for compressed/uncompressed framebuffers for each layer)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (5c41bb607125 gpu: ipu-v3: add support for XRG=
B32 and XBGR32 V4L2 pixel formats)
Merging etnaviv/etnaviv/next (1a866306e0fb drm/etnaviv: add DMA configurati=
on for etnaviv platform device)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (fadf3e019411 Merge remote-tracking branch 'regmap/=
topic/single-rw' into regmap-next)
Merging sound/for-next (edb1b3abdb20 ALSA: hda/ca0132 - Add AE-5 exit funct=
ion)
Merging sound-asoc/for-next (dce5c4639f31 Merge branch 'asoc-4.20' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (d2587800598c Input: atmel_mxt_ts - fix multiple <linux/=
property.h> includes)
Merging block/for-next (72915e1a096c Merge branch 'for-4.20/libata' into fo=
r-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (cd3085739323 dm cache: fix resize crash if =
user doesn't reload cache table)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (a1d467600ca6 Merge branch 'fixes' into next)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
Merging md/for-next (d595567dc4f0 MD: fix invalid stored role for a disk)
Merging mfd/for-mfd-next (92d6ba4ff700 mfd: ti-lmu: constify mfd_cell table=
s)
Merging backlight/for-backlight-next (633786736ed5 backlight: pwm_bl: Fix u=
ninitialized variable)
Merging battery/for-next (a4ac1f5ced58 power: reset: qcom-pon: Add pms405 p=
on support)
Merging regulator/for-next (77ca23434f3f Merge remote-tracking branch 'regu=
lator/topic/pfuze100' into regulator-next)
Merging security/next-testing (ad33b870a66b Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (1f8266ff5884 apparmor: don't try to replace=
 stale label in ptrace access check)
Merging integrity/next-integrity (3dd0f18c70d9 EVM: fix return value check =
in evm_write_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (4458bba09788 selinux: Add __GFP_NOWARN to allocation =
at str_read())
Merging tpmdd/next (8abac8d7b90d tpm: Restore functionality to xen vtpm dri=
ver.)
Merging watchdog/master (17b57b1883c1 Linux 4.19-rc6)
Merging iommu/next (dae804ddad96 Merge branches 'iommu/fixes', 'arm/renesas=
', 'ppc/pamu', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (cf3f98c7f466 drivers/vfio: Allow type-1 IOMMU instantiat=
ion with all ARM/ARM64 IOMMUs)
CONFLICT (content): Merge conflict in drivers/vfio/Kconfig
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (57361846b52b Linux 4.19-rc2)
Merging devicetree/for-next (b2efb5b04591 soc: Convert to using %pOFn inste=
ad of device_node.name)
CONFLICT (content): Merge conflict in drivers/soc/qcom/apr.c
Merging mailbox/mailbox-for-next (9f0a0a381c5d mailbox: mediatek: Add check=
 for possible failure of kzalloc)
Merging spi/for-next (2de6642ce7f3 Merge remote-tracking branch 'spi/topic/=
of' into spi-next)
Merging tip/auto-latest (3b78dbfb8fbe Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (432de7fd7630 EDAC, {i7core,sb,skx}_edac: Fix unc=
orrected error counting)
Merging irqchip/irq/irqchip-next (b4bf3d7ad3da dt-bindings: irqchip: renesa=
s-irqc: Document r8a7744 support)
Merging ftrace/for-next (5a5e3d3ceae2 perf probe: Support SDT markers havin=
g reference counter (semaphore))
Merging rcu/rcu/next (0b1aba265b93 Merge LKMM and RCU branches)
Merging kvm/linux-next (5b394b2ddf03 Linux 4.19-rc1)
Merging kvm-arm/next (976d34e2dab1 KVM: arm/arm64: Skip updating PTE entry =
if no change)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (46dec40fb741 KVM: PPC: Book3S HV: Don't trunc=
ate HPTE index in xlate function)
Merging kvms390/next (55d09dd4c860 Merge branch 'apv11' of git://git.kernel=
.org/pub/scm/linux/kernel/git/kvms390/linux into kernelorgnext)
Merging xen-tip/linux-next (811e0345cfc1 xen/balloon: Grammar s/Is it/It is=
/)
Merging percpu/for-next (b5bb42587118 arm64: percpu: Initialize ret in the =
default case)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (7eccb5edba24 platform/x86: intel-wmi-thunderb=
olt: Add dynamic debugging)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (2d00f35c55e7 leds: add Panasonic AN30259A support)
Merging ipmi/for-next (10042504ed92 ipmi:ssif: Add support for multi-part t=
ransmit messages > 2 parts)
Merging driver-core/driver-core-next (a75e78f21f9a kernfs: Fix range checks=
 in kernfs_get_target_path)
Merging usb/usb-next (29f79155b9b3 Merge 4.19-rc6 into usb-next)
Merging usb-gadget/next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-serial/usb-next (ba93cc7da896 USB: serial: ftdi_sio: implement =
GPIO support for FT-X devices)
Merging usb-chipidea-next/ci-for-usb-next (35a334659bcc usb: chipidea: imx:=
 make MODULE_LICENCE and SPDX-identifier match)
Merging phy-next/next (566b388440bb phy: renesas: convert to SPDX identifie=
rs)
Merging tty/tty-next (669c5d8d5f2b Merge 4.19-rc6 into tty-next)
Merging char-misc/char-misc-next (29c222d1a9f5 Merge 4.19-rc6)
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (502c00d9c315 Documentation: soundwire: fix stream.r=
st markup warnings)
Merging staging/staging-next (e2c3860ba27d staging: vboxvideo: Use more drm=
_fb_helper functions)
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (modify/delete): Documentation/filesystems/00-INDEX deleted in HEA=
D and modified in staging/staging-next. Version staging/staging-next of Doc=
umentation/filesystems/00-INDEX left in tree.
$ git rm -f Documentation/filesystems/00-INDEX
Merging mux/for-next (2c01260df661 mux: add mux_control_get_optional() API)
Merging icc/icc-next (8f023d0cb757 interconnect: core: Fix unused variable =
compiler warning)
Merging slave-dma/next (1576f7e1ef98 Merge branch 'topic/jz' into next)
Merging cgroup/for-next (808c43b7c7f7 cgroup: Simplify cgroup_ancestor)
Merging scsi/for-next (257f0d4d404c Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (ef801f07e7b3 scsi: qla2xxx: Return switch comman=
d on a timeout)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (1e05b62ae4bd sh: use the the PCI channels's io_ma=
p_base)
Merging rpmsg/for-next (3c3310493636 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (e6248f37f7d0 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (54a58185bfaf pinctrl: core: make sure strcmp() do=
esn't get a null parameter)
Merging pinctrl-samsung/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging pwm/for-next (8cdc43afbb2c pwm: mediatek: Add MT7628 support)
Merging userns/for-next (f040d23c8186 signal/unicore32: Use force_sig_fault=
 where appropriate)
CONFLICT (content): Merge conflict in arch/x86/kernel/traps.c
CONFLICT (content): Merge conflict in arch/arm64/kernel/traps.c
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9b25436662d5 random: make CPU trust a boot parameter)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (b76c2bbcb049 selftests: watchdog: Fix ioctl SET* er=
ror paths to take oneshot exit path)
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (29c222d1a9f5 Merge 4.19-rc6)
Merging rtc/rtc-next (9a90a5bcc73e rtc: ab8500: remove useless check)
Merging nvdimm/libnvdimm-for-next (be5ba2ca053d dax: Fix use of zero page)
Merging at24/at24/for-next (523b3213561f eeprom: at24: fix unexpected timeo=
ut under high load)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (6fcde9046673 arm64: Drop unneeded stackleak_che=
ck_alloca())
CONFLICT (content): Merge conflict in drivers/misc/lkdtm/core.c
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ff6401301656 Merge branch 'for-powerpc' into for-ne=
xt)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging fsi/master (15e2a7218c27 fsi: sbefifo: Bump max command length)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging xarray/xarray (f176eda90aeb radix tree: Remove multiorder support)
CONFLICT (content): Merge conflict in fs/dax.c
Merging akpm-current/current (ac6c789471e5 lib/lz4: update LZ4 decompressor=
 module)
CONFLICT (content): Merge conflict in mm/workingset.c
CONFLICT (content): Merge conflict in mm/swap_state.c
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/radix-tree.h
CONFLICT (content): Merge conflict in block/blk-iolatency.c
CONFLICT (content): Merge conflict in arch/hexagon/Kconfig
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
$ git checkout -b akpm remotes/origin/akpm/master
Applying: percpu: remove PER_CPU_DEF_ATTRIBUTES macro
Applying: mm: remove CONFIG_NO_BOOTMEM
Applying: mm: remove CONFIG_HAVE_MEMBLOCK
CONFLICT (content): Merge conflict in arch/unicore32/Kconfig
Applying: of/fdt: fixup #ifdefs after removal of HAVE_MEMBLOCK config option
Applying: mm: remove bootmem allocator implementation.
Applying: mm: nobootmem: remove dead code
Applying: memblock: rename memblock_alloc{_nid,_try_nid} to memblock_phys_a=
lloc*
Applying: memblock: remove _virt from APIs returning virtual address
Applying: memblock: replace alloc_bootmem_align with memblock_alloc
Applying: memblock: replace alloc_bootmem_low with memblock_alloc_low
Applying: memblock: replace __alloc_bootmem_node_nopanic with memblock_allo=
c_try_nid_nopanic
Applying: memblock: replace alloc_bootmem_pages_nopanic with memblock_alloc=
_nopanic
Applying: memblock: replace alloc_bootmem_low with memblock_alloc_low (2)
Applying: memblock: replace __alloc_bootmem_nopanic with memblock_alloc_fro=
m_nopanic
Applying: memblock: add align parameter to memblock_alloc_node()
Applying: memblock: replace alloc_bootmem_pages_node with memblock_alloc_no=
de
Applying: memblock: replace __alloc_bootmem_node with appropriate memblock_=
 API
Applying: memblock: replace alloc_bootmem_node with memblock_alloc_node
Applying: memblock: replace alloc_bootmem_low_pages with memblock_alloc_low
Applying: memblock: replace alloc_bootmem_pages with memblock_alloc
Applying: memblock: replace __alloc_bootmem with memblock_alloc_from
Applying: memblock: replace alloc_bootmem with memblock_alloc
Applying: mm: nobootmem: remove bootmem allocation APIs
Applying: memblock: replace free_bootmem{_node} with memblock_free
Applying: memblock: replace free_bootmem_late with memblock_free_late
Applying: memblock: rename free_all_bootmem to memblock_free_all
Applying: memblock: rename __free_pages_bootmem to memblock_free_pages
Applying: mm: remove nobootmem
Applying: memblock: replace BOOTMEM_ALLOC_* with MEMBLOCK variants
Applying: mm: remove include/linux/bootmem.h
Applying: docs/boot-time-mm: remove bootmem documentation
Applying: drivers/android/binder_alloc.c: replace vm_insert_page with vmf_i=
nsert_page
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (3bb04576efea drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)
Applying: dma-direct: fix up for the removal of linux/bootmem.h

--Sig_/cWmvwE448F=LurxZ0ZQ.5F.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluzN9oACgkQAVBC80lX
0GxAtAgAntc00QjQFEGKfs9Uwgv94TAqVnpD3VbklgUCjfv0DwKEfrboLl8E/4lw
Iz/tbVu0Swjcjm5vo0xyXJE+urMOLdqrHyQKT39fqpkDa0t+4zfMIuGmnewOPmMc
nO3cRgBoSM8uiCwu6QfQTPcCrx8V6nNMWbHexG6JnFckGDYhLa/w1SSv193a72oq
ioLQ/m6eBNNG/yZ3yKv1QqIRK4C91tGAgpgERFkUcob6T3LBCjtboLwxcG1BD9af
VFT5tas2PPiyDj5Dd3oaEJfMVaQACBnY1Eex4zR2vkx2YNiI3QFCasLKb8UwCAMx
FqDYEJX4kSnSkFT11WBeSSC+7HCJnQ==
=ZDsJ
-----END PGP SIGNATURE-----

--Sig_/cWmvwE448F=LurxZ0ZQ.5F.--
