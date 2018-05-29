Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933088AbeE2Kod (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:44:33 -0400
Received: from ozlabs.org ([203.11.71.1]:33803 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933205AbeE2KoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:44:13 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 29 May 2018 20:44:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for May 29
Message-ID: <20180529204410.63477f88@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/x.APkm9_7GuDg4y5a1BYl6K"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x.APkm9_7GuDg4y5a1BYl6K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180525:

New trees: scsi-fixes

The drm-intel-fixes tree gained a build failure for which I reverted
a commit.

The kbuild tree lost its build failure.

The overlayfs tree gained a conflict against the btrfs-kdave tree.

The vfs tree gained a conflict against the overlayfs tree.

The printk tree gained a conflict against Linus' tree.

The net-next tree gained a conflict against the s390 tree, a build
failure for which I reverted 3 commits and another due to an interaction
with the vfs tree for which I applied a merge fix patch.

The block tree gained conflicts against the vfs tree.

The irqchip tree gained a conflict against the arm-soc tree.

The scsi tree gained a conflict against the net-next tree.

The crypto tree gained build failures so I marked some features as BROKEN.

The akpm-current tree gained a conflict against the vfs tree.

Non-merge commits (relative to Linus' tree): 9631
 9779 files changed, 411515 insertions(+), 347180 deletions(-)

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

I am currently merging 278 trees (counting Linus' and 64 trees of bug
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
Merging origin/master (786b71f5b754 Merge tag 'nds32-for-linus-4.17-fixes' =
of git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (b04e217704b7 Linux 4.17-rc7)
Merging arc-current/for-curr (661e50bc8532 Linux 4.16-rc4)
Merging arm-current/fixes (92d44a42af81 ARM: fix kill( ,SIGFPE) breakage)
Merging arm64-fixes/for-next/fixes (82034c23fcbc arm64: Make sure permissio=
n updates happen for pmd/pud)
Merging m68k-current/for-linus (ecd685580c8f m68k/mac: Remove bogus "FIXME"=
 comment)
Merging powerpc-fixes/fixes (faf37c44a105 powerpc/64s: Clear PCR on boot)
Merging sparc/master (fff75eb2a08c Merge tag 'errseq-v4.17' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/jlayton/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew))
Merging bpf/master (c93552c443eb bpf: properly enforce index mask to preven=
t out-of-bounds speculation)
Merging ipsec/master (d9f92772e8ec xfrm6: avoid potential infinite loop in =
_decode_session6())
Merging netfilter/master (4b83a9049a98 netfilter: provide correct argument =
to nla_strlcpy())
Merging ipvs/master (2f99aa31cd7a netfilter: nf_tables: skip synchronize_rc=
u if transaction log is empty)
Merging wireless-drivers/master (813477aa49aa MAINTAINERS: change Kalle as =
wcn36xx maintainer)
Merging mac80211/master (fed4825096cf mac80211_hwsim: Fix radio dump for ra=
dio idx 0)
Merging rdma-fixes/for-rc (6e04b1035689 RDMA/bnxt_re: Fix broken RoCE drive=
r due to recent L2 driver changes)
Merging sound-current/for-linus (009f8c90f571 ALSA: hda - Fix runtime PM)
Merging sound-asoc-fixes/for-linus (7fa481817a31 Merge branch 'asoc-4.17' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (4b1b7043a286 Merge branch 'regmap-4.17' int=
o regmap-linus)
Merging regulator-fixes/for-linus (b7758b8a2ce5 Merge branch 'regulator-4.1=
7' into regulator-linus)
Merging spi-fixes/for-linus (c61801a06cf5 Merge branch 'spi-4.17' into spi-=
linus)
Merging pci-current/for-linus (0cf22d6b317c PCI: Add "PCIe" to pcie_print_l=
ink_status() messages)
Merging driver-core.current/driver-core-linus (6da6c0db5316 Linux v4.17-rc3)
Merging tty.current/tty-linus (6da6c0db5316 Linux v4.17-rc3)
Merging usb.current/usb-linus (771c577c23ba Linux 4.17-rc6)
Merging usb-gadget-fixes/fixes (6d08b06e67cd Linux 4.17-rc2)
Merging usb-serial-fixes/usb-linus (75bc37fefc44 Linux 4.17-rc4)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (60cc43fc8884 Linux 4.17-rc1)
Merging staging.current/staging-linus (9d569b1cf7a2 Merge tag 'iio-fixes-fo=
r-4.17a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into st=
aging-linus)
Merging char-misc.current/char-misc-linus (806e30873f0e hwtracing: stm: fix=
 build error on some arches)
Merging input-current/for-linus (40f7090bb1b4 Input: elan_i2c_smbus - fix c=
orrupted stack)
Merging crypto-current/master (bf4407f081f3 crypto: inside-secure - do not =
use memset on MMIO)
Merging ide/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_time')
Merging vfio-fixes/for-linus (834814e80268 Revert: "vfio-pci: Mask INTx if =
a device is not capabable of enabling it")
Merging kselftest-fixes/fixes (75bc37fefc44 Linux 4.17-rc4)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (dbad41e7bb5f dmaengine: qcom: bam_dma: check=
 if the runtime pm enabled)
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711=
_bl: fix device-tree node leaks)
Merging mtd-fixes/master (9f825e74d761 mtd: rawnand: Fix return type of __D=
IVIDE() when called with 32-bit)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (11799564fc7e mfd: cros_ec: Retry commands =
when EC is known to be busy)
Merging v4l-dvb-fixes/fixes (b84c8fdf8e6c media: uvcvideo: Prevent setting =
unavailable flags)
Merging reset-fixes/reset/fixes (e6914365fd28 reset: uniphier: fix USB cloc=
k line for LD20)
Merging mips-fixes/mips-fixes (32795631e67e MIPS: lantiq: gphy: Drop reboot=
/remove reset asserts)
Merging omap-fixes/fixes (41bd6adf3c5d Revert "ARM: dts: logicpd-som-lv: Fi=
x pinmux controller references")
Merging kvm-fixes/master (696ca779a928 KVM: x86: fix #UD address of failed =
Hyper-V hypercalls)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (771c577c23ba Linux 4.17-rc6)
Merging nvdimm-fixes/libnvdimm-fixes (75bc37fefc44 Linux 4.17-rc4)
Merging btrfs-fixes/next-fixes (e97ce3cc9888 Merge branch 'misc-4.17' into =
next-fixes)
Merging vfs-fixes/fixes (4faa99965e02 fix io_destroy()/aio_complete() race)
Merging dma-mapping-fixes/for-linus (05e13bb57e6f swiotlb: silent unwanted =
warning "buffer is full")
Merging drivers-x86-fixes/fixes (54940fa60ad3 platform/x86: DELL_WMI use de=
pends on instead of select for DELL_SMBIOS)
Merging samsung-krzk-fixes/fixes (60cc43fc8884 Linux 4.17-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (60cc43fc8884 Linux 4.17-rc1)
Merging devicetree-fixes/dt/linus (f130307054a5 dt-bindings: panel: lvds: F=
ix path to display timing bindings)
Merging scsi-fixes/fixes (a45b599ad808 scsi: sg: allocate with __GFP_ZERO i=
n sg_build_indirect())
Merging drm-intel-fixes/for-linux-next-fixes (540ead8c5a0e drm/i915/query: =
Protect tainted function pointer lookup)
Merging mmc-fixes/fixes (3de06d5a1f05 mmc: sdhci-iproc: add SDHCI_QUIRK2_HO=
ST_OFF_CARD_ON for cygnus)
Merging rtc-fixes/rtc-fixes (60cc43fc8884 Linux 4.17-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (2bc5ff0bdc00 drm/omap: fix NUL=
L deref crash with SDI displays)
Merging kbuild/for-next (8017541bd63f Merge branch 'kconfig' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (0ead51c3fbd1 x86/pci-dma: switch the VIA 32-b=
it DMA quirk to use the struct device flag)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (062d50c5433d Merge branches 'fixes' and 'misc' into f=
or-next)
Merging arm-perf/for-next/perf (b89205bd508e drivers/perf: Remove ARM_SPE_P=
MU explicit PERF_EVENTS dependency)
Merging arm-soc/for-next (933d3cf3d416 ARM: Document merges)
CONFLICT (content): Merge conflict in arch/arm/mach-exynos/Kconfig
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (9999d2013e27 Merge branch 'v4.18/defconfig' into =
tmp/aml-rebuild)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (20d3f36b0fea Merge tag 'at91-ab-4.17-dt2' into at91=
-next)
Merging bcm2835/for-next (5c483a0c319c Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
Merging imx-mxs/for-next (452daaaf6021 Merge branch 'imx/defconfig' into fo=
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
Merging renesas/next (e800ff91fb67 Merge branches 'fixes-for-v4.17', 'arm64=
-dt-for-v4.18', 'arm64-defconfig-for-v4.18', 'defconfig-for-v4.18', 'dt-bin=
dings-for-v4.18', 'dt-for-v4.18' and 'soc-for-v4.18' into next)
Merging rockchip/for-next (42568f346f65 Merge branch 'v4.18-clk/next' into =
for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (fba97222728d Merge branch 'next/dt64' into f=
or-next)
Merging sunxi/sunxi/for-next (47322fab0754 Merge branch 'sunxi/dt64-for-4.1=
8', tag 'sunxi-dt-for-4.18' into sunxi/for-next)
Merging tegra/for-next (6de9ae597a79 Merge branch for-4.18/clk into for-nex=
t)
Merging arm64/for-next/core (159fd7b8d3d1 arm64/sve: Write ZCR_EL1 on conte=
xt switch only if changed)
Merging clk/clk-next (d94d64514475 Merge branch 'clk-at91-recalc' into clk-=
next)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (85fa2cc51104 c6x: pass endianness info to spars=
e)
Merging m68k/for-next (3f90f9ef2dda m68k/mm: Adjust VM area to be unmapped =
by gap size for __iounmap())
Merging m68knommu/for-next (082f55c45984 m68k: fix ColdFire PCI config read=
s and writes)
Merging microblaze/next (a7a9e2f0410d microblaze: dts: replace 'linux,stdou=
t-path' with 'stdout-path')
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (21325631f395 MIPS: memset.S: Reinstate delay =
slot indentation)
CONFLICT (content): Merge conflict in arch/mips/boot/dts/xilfpga/Makefile
Merging nds32/next (3c6b01addf6e nds32: Fix compiler warning, Wstringop-ove=
rflow, in vdso.c)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (d56f3af9e801 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (8d40c754fbac parisc: Drop struct sigaction from=
 not exported header file)
Merging powerpc/next (d647b210ac73 powerpc: Add a missing include header)
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/ftrace.h
Merging powerpc-pkey/topic/pkey (d86a4ba02fc6 powerpc/pkeys: Drop private V=
M_PKEY definitions)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (67b8d5c70812 Linux 4.17-rc5)
Merging s390/features (3376d98021e9 s390/archrandom: Rework arch random imp=
lementation.)
Merging sparc-next/master (17dec0a94915 Merge branch 'userns-linus' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (e40238dedb48 Fix vector raw inintialization logic)
Merging xtensa/xtensa-for-next (ae6063c83634 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (7c9a09f56a91 btrfs: don't use async helpers for crcs wh=
en under IO limits)
Applying: f2fs: fixup for cgroup/writeback change
Merging btrfs-kdave/for-next (2a5f1dd6fff0 Merge branch 'for-next-next-v4.1=
8-20180524' into for-next-20180524)
Merging ceph/master (fc218544fbc8 ceph: fix iov_iter issues in ceph_direct_=
read_write())
Merging cifs/for-next (784d57bf931b smb3: allow "posix" mount option to ena=
ble new SMB311 protocol extensions)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (20b67d6401f1 Merge fsnotify cleanups from Amir into =
for_next.)
Merging ext4/dev (8a2b307c21d4 ext4: correctly handle a zero-length xattr w=
ith a non-zero e_value_offs)
Merging f2fs/dev (2432f61d309c f2fs: add fsync_mode=3Dnobarrier for non-ato=
mic files)
CONFLICT (content): Merge conflict in fs/f2fs/namei.c
Merging fuse/for-next (5ba24197b94d fuse: add writeback documentation)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (036db8bd9637 Merge branch 'for-4.17-fixes' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/tj/libata)
Merging nfs-anna/linux-next (ffbfa2ce88f1 sunrpc: Fix latency trace point c=
rashes)
Merging nfsd/nfsd-next (28771950c592 svcrdma: Fix incorrect return value/ty=
pe in svc_rdma_post_recvs)
Merging orangefs/for-next (8d720dc81d4d orangefs: formatting cleanups)
Merging overlayfs/overlayfs-next (b0ee6e9a4c53 ovl: Enable metadata only fe=
ature)
CONFLICT (content): Merge conflict in fs/btrfs/ioctl.c
Merging ubifs/linux-next (b5094b7f135b ubi: Reject MLC NAND)
Merging xfs/for-next (19e129618d47 iomap: don't allow holes in swapfiles)
Merging file-locks/locks-next (7a107c0f55a3 fasync: Fix deadlock between ta=
sk-context and interrupt-context kill_fasync())
Merging vfs/for-next (1e9d358032bc Merge branches 'work.rmdir' and 'work.lo=
okup' into for-next)
CONFLICT (content): Merge conflict in fs/read_write.c
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (913a61197c1f Merge branch 'for-4.18-vsprintf-clean=
up' into for-4.18)
CONFLICT (content): Merge conflict in lib/vsprintf.c
Merging pci/next (a39b04c31a77 Merge branch 'pci/kconfig')
CONFLICT (content): Merge conflict in arch/microblaze/include/asm/pci.h
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (0bdd81293667 Merge branch 'for-4.18/wacom' into for-n=
ext)
Merging i2c/i2c/for-next (32331abc96c0 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging dmi/master (5cb06cfce4a8 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (9e3699fcfd38 Merge tag 'ib-mfd-hwmon-v4.1=
8' into hwmon-next)
Merging jc_docs/docs-next (8962e40c1993 docs: update kernel versions and da=
tes in tables)
CONFLICT (modify/delete): Documentation/features/io/dma-api-debug/arch-supp=
ort.txt deleted in HEAD and modified in jc_docs/docs-next. Version jc_docs/=
docs-next of Documentation/features/io/dma-api-debug/arch-support.txt left =
in tree.
$ git rm -f Documentation/features/io/dma-api-debug/arch-support.txt
Merging v4l-dvb/master (a00031c15974 media: ddbridge: conditionally enable =
fast TS for stv0910-equipped bridges)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (dbeef4fe697b video: fbdev: pxafb: match_strin=
g() conversion fixup)
Merging pm/linux-next (c9c6b793ea2a Merge branches 'pm-avs' and 'pm-tools' =
into linux-next)
Merging cpupower/cpupower (9fd0c4045146 cpupower: fix spelling mistake: "lo=
gilename" -> "logfilename")
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (6a89e012aaf4 PM / OPP: silence an uninitialized=
 variable warning)
Merging thermal/next (e76a4386b2f5 thermal: Use DEVICE_ATTR_{RO|RW|WO}() va=
riants)
Merging thermal-soc/next (9efc58dfa14a thermal: mediatek: use of_device_get=
_match_data())
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (f706d830154b dlm: make sctp_connect_to_sock() return in s=
pecified time)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (d59fcacc4b08 RDMA/hns: Increase checking CMQ status =
timeout value)
Merging net-next/master (5b79c2af667c Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/davem/net)
CONFLICT (content): Merge conflict in net/ipv4/ipconfig.c
CONFLICT (content): Merge conflict in arch/s390/net/Makefile
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/qcom/apq8096-db82=
0c.dtsi
Applying: Revert "bpfilter: don't pass O_CREAT when opening console for deb=
ug"
Applying: Revert "bpfilter: fix build dependency"
Applying: Revert "net: add skeleton of bpfilter kernel module"
Applying: xsk: update for "net: convert datagram_poll users tp ->poll_mask"
Merging bpf-next/master (f198222f0567 Merge branch 'bpf-sendmsg-hook')
Merging ipsec-next/master (724e47a149f5 net-next/hinic: add pci device ids =
for 25ge and 100ge card)
Merging netfilter-next/master (9f05308844e5 netfilter: nf_tables: remove un=
used variables)
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (90278871d4b0 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/pablo/nf-next)
Merging wireless-drivers-next/master (b8248236e927 brcmfmac: trigger memory=
 dump on SDIO firmware halt message)
Merging bluetooth/master (13bf167470f5 Bluetooth: btusb: Add Dell Inspiron =
5565 to btusb_needs_reset_resume_table)
Merging mac80211-next/master (bad292973363 nl80211: Reject disconnect comma=
nds except from conn_owner)
Merging gfs2/for-next (9a38662ba4e2 gfs2: Remove sdp->sd_jheightsize)
Merging mtd/mtd/next (34c819073c8b mtd: cmdlinepart: Update comment for int=
roduction of OFFSET_CONTINUOUS)
Merging nand/nand/next (782d1967d047 mtd: rawnand: Do not check FAIL bit wh=
en executing a SET_FEATURES op)
Merging spi-nor/spi-nor/next (771ff17e82fa mtd: spi-nor: Add support for EN=
25QH32)
Merging crypto/master (dd09f58ce0c7 crypto: x86/aegis256 - Fix wrong key bu=
ffer size)
Merging drm/drm-next (dd41fb8547c2 Merge branch 'drm-next-4.18' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_engine_cs.c
Applying: drm/xen-front: merge fix for "drivers: remove force dma flag from=
 buses"
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (315852b42297 drm: rcar-du: Fix build fail=
ure)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (2045b22461c0 Merge tag 'drm-misc-next-2018=
-05-15' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-msm/msm-next (64cb96587ba6 drm/msm: Switch to atomic_helper_com=
mit())
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (6e810eb508f4 drm: mali-dp: Add YUV->R=
GB conversion support for video layers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (d34515f6779c gpu: ipu-v3: csi: support RGB565=
 on parallel bus)
Merging etnaviv/etnaviv/next (f6ffbd4fc1a1 drm/etnaviv: replace license tex=
t with SPDX tags)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (16c66b8804fa Merge branch 'regmap-4.18' into regma=
p-next)
Merging sound/for-next (f25ecf8f987d ALSA: usb-audio: Follow standard codin=
g style)
Merging sound-asoc/for-next (b0d4b0a30391 Merge branch 'asoc-4.18' into aso=
c-next)
Merging modules/modules-next (c554b8986801 module: Allow to always show the=
 status of modsign)
Merging input/next (ca1cd36cef00 Input: atmel_mxt_ts - fix reset-gpio for l=
evel based irqs)
Merging block/for-next (ce4c3e19e520 bcache: Replace bch_read_string_list()=
 by __sysfs_match_string())
CONFLICT (content): Merge conflict in drivers/block/drbd/drbd_main.c
CONFLICT (content): Merge conflict in drivers/block/DAC960.c
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (2b7eb8d36945 x86: optimize memcpy_flushcach=
e)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (eaa437749e82 mmc: sunxi: mark PM functions as __maybe_unu=
sed)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (5a409b4f56d5 MD: fix lock contention for flush bios)
Merging mfd/for-mfd-next (1768391c3674 mfd: tps65911-comparator: Fix an off=
 by one bug)
Merging backlight/for-backlight-next (cd4270258cbe backlight: as3711_bl: fi=
x device-tree node leaks)
Merging battery/for-next (1f140ff46708 Merge tag 'tags/tcpm-pps-4.18' into =
psy-next)
CONFLICT (content): Merge conflict in drivers/usb/core/hcd.c
Merging regulator/for-next (a7e55f08c9ed Merge branch 'regulator-4.18' into=
 regulator-next)
Merging security/next-testing (d19289133b1d Merge branch 'next-integrity' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into =
next-testing)
Merging apparmor/apparmor-next (430837708c21 apparmor: Fix memory leak of r=
ule on error exit path)
Merging integrity/next-integrity (6f0911a666d1 ima: fix updating the ima_ap=
praise flag)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (d141136f523a audit: normalize MAC_POLICY_LOAD record)
Merging tpmdd/next (424eaf910c32 tpm: reduce polling time to usecs for even=
 finer granularity)
Merging watchdog/master (1c85ffc86a2b dt-bindings: watchdog: renesas-wdt: A=
dd R-Car Gen2 support)
Merging iommu/next (00dcb938d482 Merge branches 'iommu/fixes', 'arm/io-pgta=
ble', 'arm/qcom', 'arm/tegra', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (4c1a86f00fda vfio: use match_string() helper)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (5b71388663c0 audit: Fix wrong task in comparison of ses=
sion ID)
CONFLICT (content): Merge conflict in security/selinux/selinuxfs.c
Merging devicetree/for-next (399d9e069577 dt-bindings: Add vendor prefix fo=
r Logic PD)
Merging mailbox/mailbox-for-next (dfbc9c5841fc mailbox: Remove depends on H=
AS_DMA in case of platform dependency)
Merging spi/for-next (c68546d34ef6 Merge branch 'spi-4.18' into spi-next)
Merging tip/auto-latest (760c3aa70029 Merge branch 'x86/vdso')
CONFLICT (content): Merge conflict in arch/x86/net/bpf_jit_comp.c
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (eaa3a1d46cfd EDAC, ghes: Make platform-based whi=
telisting x86-only)
Merging irqchip/irq/irqchip-next (6a88c221acba ARM: dts: stm32: Add exti su=
pport to stm32mp157 pinctrl)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stm32mp157c.dtsi
Merging ftrace/for-next (0c5a9acc8b4e tracing: Fix the file mode of stack t=
racer)
Merging rcu/rcu/next (09ad34c32895 cpufreq: Use static SRCU initializer)
Merging kvm/linux-next (0ea3286e2df7 KVM: x86: Expose CLDEMOTE CPU feature =
to guest VM)
Merging kvm-arm/next (e25028c8ded0 KVM: arm/arm64: Bump VGIC_V3_MAX_CPUS to=
 512)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (acc9eb9305fe KVM: PPC: Reimplement LOAD_VMX/S=
TORE_VMX instruction mmio emulation with analyse_instr() input)
Merging kvms390/next (2c8180e885c1 KVM: s390: vsie: simplify < 8k address c=
hecks)
Merging xen-tip/linux-next (c78ad1667036 xen/PVH: Make GDT selectors PVH-sp=
ecific)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (197f6accacda workqueue: Make sure struct worke=
r is accessible for wq_worker_comm())
Merging drivers-x86/for-next (8b0695841da8 platform/x86: dell-wmi: Set corr=
ect keycode for Fn + left arrow)
Merging chrome-platform/for-next (1eb89893ecaa Merge branch 'ib-chrome-plat=
form-atmel-mxt-ts-device-properties' into working-branch-for-4.18)
Merging hsi/for-next (70d52ba9e57e hsi: clients: Change return type to vm_f=
ault_t)
Merging leds/for-next (6d71021ab3b0 leds: class: ensure workqueue is initia=
lized before setting brightness)
Merging ipmi/for-next (048f7c3e352e ipmi: Properly release srcu locks on er=
ror conditions)
Merging driver-core/driver-core-next (0dda2bb62423 driver-core: return EINV=
AL error instead of BUG_ON())
Merging usb/usb-next (2c093cdb0a5e Merge tag 'phy-for-4.18' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/kishon/linux-phy into usb-next)
Merging usb-gadget/next (47265c067c0d usb: dwc2: gadget: Fix coverity issue)
Merging usb-serial/usb-next (7041d9c3f01b USB: serial: pl2303: add support =
for tx xon/xoff flow control)
Merging usb-chipidea-next/ci-for-usb-next (8bcf4c0bd7fb usb: chipidea: prop=
erly handle host or gadget initialization failure)
Merging phy-next/next (c1eb8f83845b phy: mediatek: add XS-PHY driver)
Merging tty/tty-next (4b4ecd9cb853 vt: Perform safe console erase only once)
Merging char-misc/char-misc-next (d6edc07cca93 MAINTAINERS: Add driver-api/=
fpga path)
Merging extcon/extcon-next (60cc43fc8884 Linux 4.17-rc1)
Merging staging/staging-next (7a5abc3d9699 staging: lustre: fix more build =
errors in errno.c)
CONFLICT (modify/delete): drivers/staging/media/atomisp/TODO deleted in HEA=
D and modified in staging/staging-next. Version staging/staging-next of dri=
vers/staging/media/atomisp/TODO left in tree.
$ git rm -f drivers/staging/media/atomisp/TODO
Merging mux/for-next (8e33ca72cc2e Merge branch 'i2c-mux/for-next' into for=
-next)
Merging slave-dma/next (cece9f043feb Merge branch 'topic/sprd' into next)
Merging cgroup/for-next (d8742e229021 cgroup: css_set_lock should nest insi=
de tasklist_lock)
Merging scsi/for-next (914ed9c1fa96 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/qedf/qedf.h
Merging scsi-mkp/for-next (1b5c2cb19668 scsi: lpfc: update driver version t=
o 12.0.0.4)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (b09eb2391482 Merge branch 'for-4.17-fixes' into fo=
r-next)
Merging vhost/linux-next (cfcde40e8ce3 ACPI: disable extra P_LVLx access on=
 KVM)
Merging rpmsg/for-next (1584606330bc Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (84bf021ecee4 gpio: pxa: Include the right header)
Merging pinctrl/for-next (6c1b317ff0d8 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (7c24e71c8a64 pinctrl: samsung: Fix suspen=
d/resume for Exynos5433 GPF1..5 banks)
Merging pwm/for-next (692099cdcf27 pwm: simplify getting .drvdata)
Merging userns/for-next (989329c98489 24 May 2018 Merge of my siginfo and u=
serns trees for testing in linux-next)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (505a139d7e43 selftests/intel_pstate: Enhance table =
printing)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/vmx_tsc_a=
djust_test.c
Merging y2038/y2038 (5dc0b1529d21 y2038: ipc: Redirect ipc(SEMTIMEDOP, ...)=
 to compat_ksys_semtimedop)
Merging livepatching/for-next (d7ab8e67aa52 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (ec1df1673899 coresight: Remove function coresight_v=
pid_to_pid())
Merging rtc/rtc-next (b22e568f658f Fix a typo in RTC documentation for RTC_=
DRV_JZ4740)
Merging nvdimm/libnvdimm-for-next (1dcdf20fcf9c Merge branch 'for-4.18/mcsa=
fe' into libnvdimm-for-next)
CONFLICT (content): Merge conflict in mm/hmm.c
Merging at24/at24/for-next (73b0d922cd5b eeprom: at24: provide a separate r=
outine for creating dummy i2c clients)
Merging ntb/ntb-next (5e083738f65d ntb: ntb_transport: Replace GFP_ATOMIC w=
ith GFP_KERNEL in ntb_transport_create_queue)
Merging kspp/for-next/kspp (45888b40d2a6 rslib: Allocate decoder buffers to=
 avoid VLAs)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Applying: crypto: make common SIMD glue code for MORUS as BROKEN for now
Applying: Revert "drm/i915/query: Protect tainted function pointer lookup"
Merging akpm-current/current (598a4da7c01e ipc: use new return type vm_faul=
t_t)
CONFLICT (content): Merge conflict in fs/proc/base.c
CONFLICT (content): Merge conflict in arch/sh/Kconfig
$ git checkout -b akpm remotes/origin/akpm/master
Applying: scripts: fix printf format mismatch
Applying: mm: use octal not symbolic permissions
Applying: treewide: use PHYS_ADDR_MAX to avoid type casting ULLONG_MAX
Applying: mm: fix oom_kill event handling
Applying: hexagon: fix printk format warning in setup.c
Applying: hexagon: drop the unused variable zero_page_mask
Applying: mm, memcg: propagate memory effective protection on setting memor=
y.min/low
Applying: mm, memcg: don't skip memory guarantee calculations
Applying: selftests: cgroup: add test for memory.low corner cases
Applying: kernel/kexec_file.c: add walk_system_ram_res_rev()
Applying: kernel/kexec_file.c: load kernel at top of system RAM if required
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (f81d4d108954 sparc64: NG4 memset 32 bits overflow)

--Sig_/x.APkm9_7GuDg4y5a1BYl6K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsNLvoACgkQAVBC80lX
0Gzz5Qf9HUGKEHhlbW1TBvZM89d41oNCobJKtGvSMC0OTQ5DiJOZqFcOQ+gwJP0/
axvlOjgtlxuyVHbQ1JqvN8GqLevLG/D1sy6iyajFJFkbAducxcNhtNnmc4Yr3cES
ro4R9Zgwu72a+FHcfh9inj9kliC3WbfpdYRY/MMRt7ZMh4vaIRCfSm0Mj6GICeWe
qROg1E1slBL9d0J5hhtQrw03xnmJtFnM3eXhs50UkCmW4GYh42dRWDn6i9rTInJC
O6JVtFVa9ickcFRnTAE8BYAExFnITiVbbaW9SSMaAJ8EHgKayPcKFissER3FpQEX
nmjEOQwdg/Z2c6kGEF5W1kEAUbGlSA==
=16Yv
-----END PGP SIGNATURE-----

--Sig_/x.APkm9_7GuDg4y5a1BYl6K--
