Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932421AbeCSIDO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 04:03:14 -0400
Received: from ozlabs.org ([103.22.144.67]:32887 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755338AbeCSIC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 04:02:59 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 19 Mar 2018 19:02:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 19
Message-ID: <20180319190222.0fb5780f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5q7tcYTUM6mhDb5V.fk6AfR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5q7tcYTUM6mhDb5V.fk6AfR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180316:

The asm-generic tree lost its build failure.

The vfs tree gained a build failure for which I reverted a commit.

The net-next tree gained a conflict against the syscalls tree.

The drm-misc tree gained a conflict against the drm tree.

The tip tree gained a conflict against the arm-soc tree.

The akpm-current tree gained conflicts against the vfs and sparc-next
trees.

The akpm tree lost 2 patches that turned up elsewhere.

Non-merge commits (relative to Linus' tree): 8102
 10477 files changed, 358144 insertions(+), 721948 deletions(-)

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

I am currently merging 261 trees (counting Linus' and 44 trees of bug
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
Merging origin/master (9e1909b9da04 Merge branch 'x86-pti-for-linus' of git=
://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/master (7928b2cbe55b Linux 4.16-rc1)
Merging kbuild-current/fixes (55fe6da9efba kbuild: Handle builtin dtb file =
names containing hyphens)
Merging arc-current/for-curr (661e50bc8532 Linux 4.16-rc4)
Merging arm-current/fixes (091f02483df7 ARM: net: bpf: clarify tail_call in=
dex)
Merging arm64-fixes/for-next/fixes (e21da1c99200 arm64: Relax ARM_SMCCC_ARC=
H_WORKAROUND_1 discovery)
Merging m68k-current/for-linus (2334b1ac1235 MAINTAINERS: Add NuBus subsyst=
em entry)
Merging metag-fixes/fixes (b884a190afce metag/usercopy: Add missing fixups)
Merging powerpc-fixes/fixes (e4b79900222b powerpc/64s: Fix NULL AT_BASE_PLA=
TFORM when using DT CPU features)
Merging sparc/master (9c548bb5823d sparc64: Oracle DAX driver depends on SP=
ARC64)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (034f40579389 vmxnet3: use correct flag to indicate LRO =
feature)
Merging bpf/master (b6b76dd62c56 error-injection: Fix to prohibit jump opti=
mization)
Merging ipsec/master (51d4740f88af net sched actions: return explicit error=
 when tunnel_key mode is not specified)
Merging netfilter/master (f89782c2d131 qed: Use after free in qed_rdma_free=
())
Merging ipvs/master (f7fb77fc1235 netfilter: nft_compat: check extension ho=
ok mask only if set)
Merging wireless-drivers/master (125905517028 brcmfmac: drop Inter-Access P=
oint Protocol packets by default)
Merging mac80211/master (a78872363614 cfg80211: add missing dependency to C=
FG80211 suboptions)
Merging rdma-fixes/for-rc (2975d5de6428 RDMA/ucma: Check AF family prior re=
solving address)
Merging sound-current/for-linus (e40bdb03d3cd ALSA: hda/realtek - Always im=
mediately update mute LED with pin VREF)
Merging pci-current/for-linus (fc110ebdd014 PCI: dwc: Fix enumeration end w=
hen reaching root subordinate)
Merging driver-core.current/driver-core-linus (0c8efd610b58 Linux 4.16-rc5)
Merging tty.current/tty-linus (5d7f77ec72d1 serial: imx: fix bogus dev_err)
Merging usb.current/usb-linus (94e46a4f2d5e usb: musb: Fix external abort i=
n musb_remove on omap2430)
Merging usb-gadget-fixes/fixes (c6ba5084ce0d usb: gadget: udc: renesas_usb3=
: add binging for r8a77965)
Merging usb-serial-fixes/usb-linus (7920a87c40db USB: serial: cp210x: add E=
LDAT Easywave RX09 id)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (59fba0869aca phy: qcom-ufs: add MODULE_LICENSE tag)
Merging staging.current/staging-linus (740a5759bf22 staging: android: ashme=
m: Fix possible deadlock in ashmem_ioctl)
Merging char-misc.current/char-misc-linus (655296c8bbef Drivers: hv: vmbus:=
 Fix ring buffer signaling)
Merging input-current/for-linus (3993a16309c7 Input: silead - add Chuwi Hi8=
 support)
Merging crypto-current/master (c927b080c67e crypto: s5p-sss - Fix kernel Oo=
ps in AES-ECB mode)
Merging ide/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_time')
Merging vfio-fixes/for-linus (563b5cbe334e iommu/arm-smmu-v3: Cope with dup=
licated Stream IDs)
Merging kselftest-fixes/fixes (ba004a2955f7 selftests: memory-hotplug: fix =
emit_tests regression)
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711=
_bl: fix device-tree node leaks)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (107b7d9fa94c mfd: rtsx: Release IRQ during=
 shutdown)
Merging v4l-dvb-fixes/fixes (2c27476e398b media: dvb: fix a Kconfig typo)
Merging reset-fixes/reset/fixes (f450f28e70a2 reset: socfpga: fix for 64-bi=
t compilation)
Merging mips-fixes/mips-fixes (06a3f0c9f272 MIPS: BMIPS: Do not mask IPIs d=
uring suspend)
Merging kvm-fixes/master (52be7a467e4b Merge tag 'kvm-ppc-fixes-4.16-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into kvm-maste=
r)
Merging kvms390-fixes/master (f07afa0462b7 KVM: s390: fix memory overwrites=
 when not using SCA entries)
Merging drm-intel-fixes/for-linux-next-fixes (05b429a8eed8 Merge tag 'gvt-f=
ixes-2018-03-15' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging drm-misc-fixes/for-linux-next-fixes (9ca8614980d4 drm/sun4i: Fix an=
 error handling path in 'sun4i_drv_bind()')
Merging syscalls/syscalls-next (0e0b541988c0 Merge branch 'syscalls-net-nex=
t')
Merging kbuild/for-next (912677be388c Merge branch 'kconfig' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging efi-lock-down/efi-lock-down (89bcd5b02f12 lockdown: Print current->=
comm in restriction messages)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (1f674e16f9ce usb: gadget: Add NO_DMA dummies =
for DMA mapping API)
Merging asm-generic/master (b53bc17eb1e8 staging: iio: remove iio-trig-bfin=
-timer driver)
CONFLICT (content): Merge conflict in drivers/input/joystick/analog.c
CONFLICT (modify/delete): arch/blackfin/kernel/bfin_ksyms.c deleted in asm-=
generic/master and modified in HEAD. Version HEAD of arch/blackfin/kernel/b=
fin_ksyms.c left in tree.
$ git rm -f arch/blackfin/kernel/bfin_ksyms.c
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging arm-perf/for-next/perf (44300aed5d28 perf: arm_spe: include linux/v=
malloc.h for vmap())
Merging arm-soc/for-next (e83e3b9ac6f3 Merge branch 'next/soc' into for-nex=
t)
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (a1144b2b1ec4 ARM: dts: alpine: add valid cl=
ock-frequency values)
Merging amlogic/for-next (00ceeac6751f Merge branch 'v4.17/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (dc39260ac782 Merge branch 'at91-soc' of ssh://gitol=
ite.kernel.org/pub/scm/linux/kernel/git/abelloni/linux into at91-next)
Merging bcm2835/for-next (cf172af3be59 Merge branch anholt/bcm2835-defconfi=
g-next into for-next)
Merging imx-mxs/for-next (dee23d344a73 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (dacf37850167 Merge branch 'for_4.17/soc-drivers' int=
o next)
Merging mvebu/for-next (32fbcf84317d Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (08e669eadd88 Merge branch 'omap-for-v4.16/fixes' int=
o for-next)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/logicpd-torpedo-som=
.dtsi
Merging reset/reset/next (de0ba80dc5ca reset: uniphier: add Pro4/Pro5/PXs2 =
audio systems reset control)
Merging qcom/for-next (a54b7e019869 Merge branch 'arm64-defconfig-for-4.17'=
 into all-for-4.17)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (58eb42a95b24 Merge branches 'arm64-defconfig-for-v4.1=
7', 'arm64-dt-for-v4.17', 'defconfig-for-v4.17', 'dt-bindings-for-v4.17', '=
dt-for-v4.17' and 'soc-for-v4.17' into next)
Merging rockchip/for-next (bba558b5d864 Merge branch 'v4.17-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (b54709c99195 Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (fa99960487b5 Merge branches 'sunxi/core-for-4=
.17' and 'sunxi/dt-for-4.17' into sunxi/for-next)
Merging tegra/for-next (0b4db1a92edc Merge branch for-4.17/clk into for-nex=
t)
Merging arm64/for-next/core (654c39c7982c Merge tag 'acpi/iort-for-v4.17' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux into aarch=
64/for-next/core)
Merging clk/clk-next (1bc4b38a2388 Merge branch 'clk-hisi' into clk-next)
Merging clk-samsung/for-next (182c084da5d1 clk: samsung: Add fout=3D1966080=
01 Hz EPLL rate entry for exynos4412)
Merging c6x/for-linux-next (9d440f7a2824 c6x: fix platforms/plldata.c get_c=
oreid build error)
Merging m68k/for-next (275036f3ff78 zorro: Set up z->dev.dma_mask for the D=
MA API)
Merging m68knommu/for-next (661e50bc8532 Linux 4.16-rc4)
Merging metag/for-next (8d06c3302635 i2c: img-scb: Drop METAG dependency)
Merging microblaze/next (b40b3b6b938e microblaze: switch to NO_BOOTMEM)
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (b2ed33a89567 MIPS: pm-cps: Block system suspe=
nd when a JTAG probe is present)
Merging nds32/next (6fc61ee69433 nds32: To use the generic dump_stack())
Merging nios2/for-next (e0691ebb33c1 nios2: defconfig: Cleanup from old Kco=
nfig options)
Merging openrisc/for-next (0fedb7653af7 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (5464408e6bc4 parisc/Kconfig: SMP kernels boot o=
n all machines)
Merging powerpc/next (014a32b30e9d powerpc/mm/slice: remove radix calls to =
the slice code)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (0c8efd610b58 Linux 4.16-rc5)
Merging s390/features (5628683cf77b s390/dasd: set timestamps unconditional=
ly)
Merging sparc-next/master (88fe35293446 Merge branch 'sparc64-ADI')
Merging sh/for-next (6e2fbfdd585f sh: fix futex FUTEX_OP_SET op on userspac=
e addresses)
Merging uml/linux-next (584bfe635481 um: vector: Fix an error handling path=
 in 'vector_parse()')
Merging xtensa/xtensa-for-next (ae6063c83634 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (0b1dfa4cc6c6 fscrypt: fix build with pre-4.6 gcc ve=
rsions)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (7c9a09f56a91 btrfs: don't use async helpers for crcs wh=
en under IO limits)
Applying: f2fs: fixup for cgroup/writeback change
Merging btrfs-kdave/for-next (cf5e97e9c1ea Merge branch 'for-next-next-v4.1=
7-20180317' into for-next-20180317)
Merging ceph/master (1c7892495788 ceph: fix potential memory leak in init_c=
aches())
Merging cifs/for-next (c5473a5bb132 fs: cifs: Replace _free_xid call in cif=
s_root_iget function)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (4670269faba7 eCryptfs: constify attribute_group stru=
ctures.)
Merging ext3/for_next (a9cee1764b6f reiserfs: Remove VLA from fs/reiserfs/r=
eiserfs.h)
Merging ext4/dev (5dc397113d19 ext4: create ext4_kset dynamically)
Merging f2fs/dev (81f5af16f39a f2fs: align memory boundary for bitops)
Merging fuse/for-next (c6cdd51404b7 fuse: fix READDIRPLUS skipping an entry)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (8f5fd927c3a7 Merge tag 'for-4.16-rc5-tag' of git://=
git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging nfs-anna/linux-next (c54c14ba000d xprtrdma: Spread reply processing=
 over more CPUs)
CONFLICT (content): Merge conflict in net/sunrpc/xprtrdma/transport.c
CONFLICT (content): Merge conflict in net/sunrpc/xprt.c
Merging nfsd/nfsd-next (1d28bf4e27c9 nfsd: move nfs4_client allocation to d=
edicated slabcache)
Merging orangefs/for-next (74e938c22705 orangefs: reverse sense of is-inode=
-stale test in d_revalidate)
Merging overlayfs/overlayfs-next (36cd95dfa1ed ovl: update Kconfig texts)
Merging ubifs/linux-next (7f29ae9f977b ubi: block: Fix locking for idr_allo=
c/idr_remove)
Merging xfs/for-next (df79b81b2e6a xfs: minor cleanup for xfs_reflink_end_c=
ow)
Merging file-locks/locks-next (8bad6f173914 locks: change POSIX lock owners=
hip on execve when files_struct is displaced)
Merging vfs/for-next (a1b3758e0ded Merge branch 'work.thaw' into for-next)
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging iversion/iversion-next (581e400ff935 Merge tag 'modules-for-v4.16' =
of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux)
Merging printk/for-next (3d172f44ffab Merge branch 'for-4.17' into for-next)
Merging pci/next (eda9c9dd19d1 Merge remote-tracking branch 'lorenzo/pci/xg=
ene' into next)
Merging pstore/for-next/pstore (58eb5b670747 pstore: fix crypto dependencie=
s)
Merging hid/for-next (b576182794e8 Merge branch 'for-4.16/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (dc07174fd3d8 Merge branch 'i2c/for-4.17' into i2c=
/for-next)
Merging dmi/master (eb693e35e850 firmware: dmi_scan: add DMI_OEM_STRING sup=
port to dmi_matches)
Merging hwmon-staging/hwmon-next (72816cb06e71 hwmon: (ucd9000) Add debugfs=
 attributes to provide mfr_status)
Merging jc_docs/docs-next (6234c7bd8c14 docs: ftrace: fix a few formatting =
issues)
Merging v4l-dvb/master (3f127ce11353 media: em28xx-cards: fix em28xx_duplic=
ate_dev())
CONFLICT (modify/delete): drivers/media/platform/blackfin/bfin_capture.c de=
leted in HEAD and modified in v4l-dvb/master. Version v4l-dvb/master of dri=
vers/media/platform/blackfin/bfin_capture.c left in tree.
$ git rm -f drivers/media/platform/blackfin/bfin_capture.c
Merging v4l-dvb-next/master (a1dfb4c48cc1 media: v4l2-compat-ioctl32.c: ref=
actor compat ioctl32 logic)
Merging fbdev/fbdev-for-next (2c81ee0a28c0 video: fbdev: via: remove VLA us=
age)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
Merging pm/linux-next (222d946a2539 Merge branch 'acpi-battery' into linux-=
next)
Merging cpupower/cpupower (7928b2cbe55b Linux 4.16-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (4a823c0be80f opp: cpu: Replace GFP_ATOMIC with =
GFP_KERNEL in dev_pm_opp_init_cpufreq_table)
Merging thermal/next (134f4010799a Merge branches 'thermal-core', 'thermal-=
intel' and 'thermal-soc' into next)
Merging thermal-soc/next (d0ecbbbe518e thermal/drivers/hisi: Remove bogus c=
onst from function return type)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (9250e523592a dlm: remove dlm_send_rcom_lookup_dump)
Merging swiotlb/linux-next (69369f52d28a swiotlb-xen: implement xen_swiotlb=
_get_sgtable callback)
Merging rdma/for-next (6d06c9aa3816 IB/mlx4: Add Scatter FCS support over W=
Q creation)
Merging net-next/master (e3c72f3d37e4 selftests: pmtu: Drop prints to kerne=
l log from pmtu_vti6_link_change_mtu)
CONFLICT (content): Merge conflict in net/ipv4/xfrm4_policy.c
CONFLICT (content): Merge conflict in include/linux/socket.h
CONFLICT (content): Merge conflict in drivers/net/phy/phy.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlxsw/s=
pectrum.h
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlxsw/s=
pectrum.c
Applying: mlxsw: merge fix for move of SPAN code
Merging bpf-next/master (318df9f01cff Merge branch 'bpf-tools-build-improve=
ments')
Merging ipsec-next/master (415a13296a1a xfrm_policy: use true and false for=
 boolean values)
Merging netfilter-next/master (90eee0957b65 netfilter: nft_ct: add NFT_CT_{=
SRC,DST}_{IP,IP6})
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (a910d20aa007 netfilter: ipvs: Fix space before '[=
' error.)
Merging wireless-drivers-next/master (28bf8312a983 mwifiex: get_channel fro=
m firmware)
Merging bluetooth/master (20e9dcd24f21 Bluetooth: btmrvl: Delete an unneces=
sary variable initialisation in btmrvl_sdio_card_to_host())
Merging mac80211-next/master (2e75bb2f8b89 net: Convert hwsim_net_ops)
Merging gfs2/for-next (ee6ed857c805 gfs2: gfs2_iomap_end tracepoint: log bl=
ock address)
Merging mtd/master (f23def803861 mtd: nand: MTD_NAND_MARVELL should depend =
on HAS_DMA)
Merging l2-mtd/mtd/next (8c4a68a8b0da mtd: maps: remove bfin-async-flash dr=
iver)
Merging nand/nand/next (00324da71e66 mtd: rawnand: remove bf5xx_nand driver)
CONFLICT (content): Merge conflict in drivers/mtd/nand/Kconfig
CONFLICT (modify/delete): arch/cris/arch-v32/drivers/mach-fs/nandflash.c de=
leted in HEAD and modified in nand/nand/next. Version nand/nand/next of arc=
h/cris/arch-v32/drivers/mach-fs/nandflash.c left in tree.
CONFLICT (modify/delete): arch/cris/arch-v32/drivers/mach-a3/nandflash.c de=
leted in HEAD and modified in nand/nand/next. Version nand/nand/next of arc=
h/cris/arch-v32/drivers/mach-a3/nandflash.c left in tree.
$ git rm -f arch/cris/arch-v32/drivers/mach-a3/nandflash.c arch/cris/arch-v=
32/drivers/mach-fs/nandflash.c
Applying: mtd: nand: fix up for raw Kconfig move
Merging spi-nor/spi-nor/next (5c6038af2ed8 dt-bindings: fsl-quadspi: Add th=
e example of two SPI NOR)
Merging crypto/master (a22ad9d922bb crypto: arm64/sm3-ce - yield NEON after=
 every block of input)
CONFLICT (modify/delete): drivers/crypto/bfin_crc.c deleted in HEAD and mod=
ified in crypto/master. Version crypto/master of drivers/crypto/bfin_crc.c =
left in tree.
$ git rm -f drivers/crypto/bfin_crc.c
Merging drm/drm-next (963976cfe9c5 Merge tag 'drm-intel-next-2018-03-08' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/sun4i/sun4i_tcon.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_breadcrumb=
s.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_request.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/hwmgr/s=
mu7_hwmgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/inc/hw=
_sequencer.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (22de4e7a531b drm/i915/pmu: Work around co=
mpiler warnings on some kernel configs)
Merging drm-tegra/drm/tegra/for-next (27e92f1f1600 drm/tegra: prime: Implem=
ent ->{begin,end}_cpu_access())
Merging drm-misc/for-linux-next (0126b23c552c drm/vc4_validate: Remove VLA =
usage)
CONFLICT (content): Merge conflict in sound/pci/hda/hda_intel.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_color.c
Merging drm-msm/msm-next (b666c0f68f33 drm/msm: fix building without debugf=
s)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (6e810eb508f4 drm: mali-dp: Add YUV->R=
GB conversion support for video layers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (4a3928c6f8a5 Linux 4.16-rc3)
Merging etnaviv/etnaviv/next (fc0775da8e60 drm/etnaviv: etnaviv_sched: Stat=
icize functions when possible)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (2889312616ae Merge remote-tracking branches 'regma=
p/topic/debugfs' and 'regmap/topic/mmio-clk' into regmap-next)
Merging sound/for-next (09b9ddfaa183 ALSA: pcm: Use krealloc() for resizing=
 the rules array)
Merging sound-asoc/for-next (b3feebd0ca1d Merge remote-tracking branches 'a=
soc/topic/wm9712', 'asoc/topic/wm9713', 'asoc/topic/wm_adsp' and 'asoc/topi=
c/zx_aud96p22' into asoc-next)
Merging modules/modules-next (3f553b308bb0 module: propagate error in modul=
es_open())
Merging input/next (68106869e802 Input: pxrc - new driver for PhoenixRC Fli=
ght Controller Adapter)
Merging block/for-next (7e9238f82cd6 Merge branch 'for-4.17/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (83260a18a9de dm bufio: support non-power-of=
-two block sizes)
Merging mmc/next (f09a7931bcbc Merge branch 'fixes' into next)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (3de59bb9d551 md/raid1: fix NULL pointer dereference)
Merging mfd/for-mfd-next (e2be8c26c80a mfd: pcf50633: Fix some memory leaks=
 in the error handling path of 'pcf50633_probe()')
Merging backlight/for-backlight-next (ba11349b2a57 dt-bindings: backlight: =
Add binding for RAVE SP backlight driver)
Merging battery/for-next (93619fdec96f power: reset: make function sc27xx_p=
oweroff_shutdown static)
Merging regulator/for-next (39f45aa126d0 Merge remote-tracking branches 're=
gulator/topic/88pg86x', 'regulator/topic/dt' and 'regulator/topic/gpio' int=
o regulator-next)
Merging security/next-testing (39859821366f Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (e540c3c90193 apparmor: update MAINTAINERS f=
ile git and wiki locations)
Merging integrity/next-integrity (638872e2ad9e evm: check for remount ro in=
 progress before writing)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (68741a8adab9 selinux: Fix ltp test connect-syscall fa=
ilure)
CONFLICT (content): Merge conflict in net/sctp/socket.c
Merging tpmdd/next (8d91a21a078d tpm: fix intermittent failure with self te=
sts)
Merging watchdog/master (2e8ebed6ede0 Merge branch 'v4.16-fixes')
Merging iommu/next (c5f40d39014a Merge branches 'x86/amd', 'x86/vt-d', 'arm=
/rockchip', 'arm/omap', 'arm/mediatek', 'arm/exynos' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (46ed90f157f4 vfio: mdev: make a couple of functions and =
structure vfio_mdev_driver static)
Merging trivial/for-next (1972d6c0c86d MAINTAINERS: relinquish kconfig)
Merging audit/next (45b578fe4c3c audit: link denied should not directly gen=
erate PATH record)
Merging devicetree/for-next (54587be4962e of: unittest: local return value =
variable related cleanups)
Merging mailbox/mailbox-for-next (0ae7d327a64b dt-bindings: mailbox: qcom: =
Document the APCS clock binding)
Merging spi/for-next (588dce50eac3 Merge remote-tracking branches 'spi/topi=
c/jcore', 'spi/topic/kconfig', 'spi/topic/orion', 'spi/topic/pxa2xx' and 's=
pi/topic/tegra20-slink' into spi-next)
CONFLICT (content): Merge conflict in drivers/spi/Kconfig
Merging tip/auto-latest (71c47ea4616d Merge branch 'x86/timers')
CONFLICT (content): Merge conflict in drivers/bus/arm-cci.c
CONFLICT (modify/delete): Documentation/trace/ftrace.txt deleted in HEAD an=
d modified in tip/auto-latest. Version tip/auto-latest of Documentation/tra=
ce/ftrace.txt left in tree.
$ git rm -f Documentation/trace/ftrace.txt
Applying: perf/core: merge fix for "drivers/bus: Split Arm CCI driver"
Applying: trace doc: merge fix for "tracing: Unify the "boot" and "mono" tr=
acing clocks"
Applying: perf/core: another merge fix for "drivers/bus: Split Arm CCI driv=
er"
Merging clockevents/clockevents/next (135643b1d63d clocksource/drivers/npcm=
: Add NPCM7xx timer driver)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6fd052665274 EDAC, sb_edac: Remove variable leng=
th array usage)
Merging irqchip/irq/irqchip-next (6ef6386ef7c1 irqchip/gic-v3: Loudly compl=
ain about the use of IRQ_TYPE_NONE)
CONFLICT (content): Merge conflict in drivers/irqchip/Makefile
Merging ftrace/for-next (841a915d20c7 vsprintf: Do not have bprintf derefer=
ence pointers)
Merging rcu/rcu/next (08c5ee913265 softirq: Eliminate unused cond_resched_s=
oftirq() macro)
Merging kvm/linux-next (4956aa3b8b59 Merge tag 'kvm-s390-next-4.17-1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
Merging kvm-arm/next (250be9d61cf8 KVM: arm/arm64: No need to zero CNTVOFF =
in kvm_timer_vcpu_put() for VHE)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (7928b2cbe55b Linux 4.16-rc1)
Merging kvms390/next (ccc40c53c07b KVM: s390: provide counters for all inte=
rrupt injects/delivery)
Merging xen-tip/linux-next (351b2bccede1 xen: xenbus: use put_device() inst=
ead of kfree())
Merging percpu/for-next (4bce8063e393 percpu: include linux/sched.h for con=
d_resched())
Applying: percpu: include sched.h for cond_resched()
Merging workqueues/for-next (6417250d3f89 workqueue: remove unused cancel_w=
ork())
Merging drivers-x86/for-next (cc69c88fbeb9 platform/x86: dell-smbios: Resol=
ve dependency error on DCDBAS)
CONFLICT (content): Merge conflict in drivers/platform/x86/Kconfig
Merging chrome-platform/for-next (0c8efd610b58 Linux 4.16-rc5)
Merging hsi/for-next (b6dc80dbe6cd HSI: cmt_speech: use timespec64 instead =
of timespec)
Merging leds/for-next (d1ed7c558612 leds: Extends disk trigger for reads an=
d writes)
Merging ipmi/for-next (bc48fa1b9d3b ipmi:pci: Blacklist a Realtek "IPMI" de=
vice)
Merging driver-core/driver-core-next (8ddfb47294c0 drivers: base: add descr=
iption for .coredump() callback)
Merging usb/usb-next (225b3dc92da1 USB: wusbcore: crypto: Remove VLA usage)
Merging usb-gadget/next (498f0478aba4 usb: dwc3: Prevent indefinite sleep i=
n _dwc3_set_mode during suspend/resume)
Merging usb-serial/usb-next (858c121d028f USB: serial: option: use mass-sto=
rage class define)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx:=
 Fix ULPI on imx53)
Merging phy-next/next (e7f4da4c44fe phy: tegra: xusb: Uncomment register wr=
ite)
Merging tty/tty-next (e2fea54e4592 8250-men-mcb: add support for 16z025 and=
 16z057)
CONFLICT (content): Merge conflict in drivers/tty/hvc/Makefile
CONFLICT (content): Merge conflict in drivers/tty/hvc/Kconfig
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih418-b2199.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih410-b2260.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih410-b2120.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih407-b2120.dts
Merging char-misc/char-misc-next (f4d029098428 misc: aspeed-lpc-ctrl: Enabl=
e FWH and A2H bridge cycles)
Merging extcon/extcon-next (e1eade1eb5f1 Merge branch 'ib-extcon-drm-dt-v4.=
17' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into ex=
tcon-next)
Merging staging/staging-next (c26dd817d99b uapi: remove telephony headers)
CONFLICT (modify/delete): drivers/staging/lustre/lnet/libcfs/linux/linux-pr=
im.c deleted in staging/staging-next and modified in HEAD. Version HEAD of =
drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c left in tree.
CONFLICT (modify/delete): drivers/staging/lustre/lnet/libcfs/linux/linux-cu=
rproc.c deleted in staging/staging-next and modified in HEAD. Version HEAD =
of drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c left in tree.
CONFLICT (modify/delete): drivers/staging/irda/net/af_irda.c deleted in sta=
ging/staging-next and modified in HEAD. Version HEAD of drivers/staging/ird=
a/net/af_irda.c left in tree.
CONFLICT (modify/delete): drivers/staging/ccree/Makefile deleted in staging=
/staging-next and modified in HEAD. Version HEAD of drivers/staging/ccree/M=
akefile left in tree.
CONFLICT (modify/delete): drivers/staging/ccree/Kconfig deleted in staging/=
staging-next and modified in HEAD. Version HEAD of drivers/staging/ccree/Kc=
onfig left in tree.
$ git rm -f drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c driver=
s/staging/lustre/lnet/libcfs/linux/linux-prim.c drivers/staging/ccree/Kconf=
ig drivers/staging/ccree/Makefile drivers/staging/irda/net/af_irda.c
Merging mux/for-next (fa934c06c0f4 mux: add mux_control_get_optional() API)
Merging slave-dma/next (56c931385f55 Merge branch 'fixes' into next)
Merging cgroup/for-next (d1897c9538ed cgroup: fix rule checking for threade=
d mode switching)
Merging scsi/for-next (435458e41180 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (e1735d9a98ab scsi: csiostor: add support for 32 =
bit port capabilities)
CONFLICT (modify/delete): drivers/scsi/eata.c deleted in scsi-mkp/for-next =
and modified in HEAD. Version HEAD of drivers/scsi/eata.c left in tree.
$ git rm -f drivers/scsi/eata.c
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (905e225c7cf0 Merge branch 'for-4.17' into for-next)
Merging vhost/linux-next (54939f252f97 fw_cfg: write vmcoreinfo details)
Merging rpmsg/for-next (1b62ac156424 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
CONFLICT (content): Merge conflict in samples/Makefile
Merging gpio/for-next (95260c17b27e Merge tag 'v4.16-rc5' into devel)
Merging pinctrl/for-next (dfb1c1da3da7 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging pwm/for-next (bccaa3f917c9 pwm: meson: Add clock source configurati=
on for Meson-AXG)
Merging userns/for-next (6633c0f18910 Merge fuse: mounts from non-init user=
 namespaces)
Merging ktest/for-next (f7c6401ff84a ktest: Make sure wait_for_input does h=
onor the timeout)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (78972f51ccf8 selftests: futex Makefile add top leve=
l TAP header echo to RUN_TESTS)
Merging y2038/y2038 (8bad56707b0b arm64: fix perf_regs.c)
CONFLICT (modify/delete): arch/tile/include/asm/compat.h deleted in HEAD an=
d modified in y2038/y2038. Version y2038/y2038 of arch/tile/include/asm/com=
pat.h left in tree.
$ git rm -f arch/tile/include/asm/compat.h
Merging livepatching/for-next (d13f5d84ca27 Merge branch 'for-4.16/signal-s=
ysfs-force-v2' into for-next)
Merging coresight/next (c24ae3b69146 coresight: etm4x: Fix bit shifting)
Merging rtc/rtc-next (7a96880cb5b4 rtc: pcf85063: fix clearing bits in pcf8=
5063_start_clock)
CONFLICT (modify/delete): drivers/rtc/rtc-tile.c deleted in HEAD and modifi=
ed in rtc/rtc-next. Version rtc/rtc-next of drivers/rtc/rtc-tile.c left in =
tree.
$ git rm -f drivers/rtc/rtc-tile.c
Merging nvdimm/libnvdimm-for-next (18965869271c Merge branch 'for-4.17/libn=
vdimm' into libnvdimm-pending)
CONFLICT (content): Merge conflict in arch/x86/mm/init_64.c
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in L=
DFLAGS too)
Merging at24/at24/for-next (570b7e20f24e dt-bindings: at24: add Renesas R1E=
X24128)
Merging ntb/ntb-next (53c3677c56c7 ntb: intel: change references of skx to =
gen3)
Merging kspp/for-next/kspp (2d00fcb32f71 Merge branch 'kspp/gcc-plugin/infr=
astructure' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Applying: Revert "buffer.c: call thaw_super during emergency thaw"
Merging akpm-current/current (2623866b3006 tools/testing/selftests/sysctl/s=
ysctl.sh: add range clamping test)
CONFLICT (content): Merge conflict in mm/sparse.c
CONFLICT (content): Merge conflict in mm/page_alloc.c
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in drivers/block/zram/zram_drv.h
CONFLICT (modify/delete): arch/tile/mm/mmap.c deleted in HEAD and modified =
in akpm-current/current. Version akpm-current/current of arch/tile/mm/mmap.=
c left in tree.
CONFLICT (modify/delete): arch/tile/kernel/pci_gx.c deleted in HEAD and mod=
ified in akpm-current/current. Version akpm-current/current of arch/tile/ke=
rnel/pci_gx.c left in tree.
CONFLICT (modify/delete): arch/score/mm/cache.c deleted in HEAD and modifie=
d in akpm-current/current. Version akpm-current/current of arch/score/mm/ca=
che.c left in tree.
$ git rm -f arch/score/mm/cache.c arch/tile/kernel/pci_gx.c arch/tile/mm/mm=
ap.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: ipc/mqueue: add missing error code in init_mqueue_fs()
Applying: kexec_file: make use of purgatory optional
Applying: kexec_file-make-an-use-of-purgatory-optional-fix
Applying: kexec_file,x86,powerpc: factor out kexec_file_ops functions
Applying: x86: kexec_file: purge system-ram walking from prepare_elf64_head=
ers()
Applying: x86: kexec_file: remove X86_64 dependency from prepare_elf64_head=
ers()
Applying: x86: kexec_file: lift CRASH_MAX_RANGES limit on crash_mem buffer
Applying: x86: kexec_file: clean up prepare_elf64_headers()
Applying: kexec_file, x86: move re-factored code to generic side
Applying: mm: introduce MAP_FIXED_NOREPLACE
Applying: fs, elf: drop MAP_FIXED usage from elf_map
Applying: elf: enforce MAP_FIXED on overlaying elf segments
Applying: xen, mm: allow deferred page initialization for xen pv domains
Applying: linux/const.h: prefix include guard of uapi/linux/const.h with _U=
API
Applying: linux/const.h: move UL() macro to include/linux/const.h
Applying: linux/const.h: refactor _BITUL and _BITULL a bit
Applying: mm: memcg: remote memcg charging for kmem allocations
Applying: fs: fsnotify: account fsnotify metadata to kmemcg
Applying: fs-fsnotify-account-fsnotify-metadata-to-kmemcg-fix
Applying: headers: untangle kmemleak.h from mm.h
Applying: headers-untangle-kmemleakh-from-mmh-fix
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (52a0b4349604 sparc64: NG4 memset 32 bits overflow)

--Sig_/5q7tcYTUM6mhDb5V.fk6AfR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqvbo4ACgkQAVBC80lX
0GxweAgAhwEngJYIla5f5HQYEDKAHez0aOJPklbcHYY757Nl+0fVa4NSCwDk3kPa
uIWQl3qzp1CPVJlQqgB9xZeku6wx2rEG++D/memXy83SfbiXXb3a1UcjnQDdvnoK
FZrVwdGjS0/Hg5Jh1YFCSw+scJ7NoOUf8j1nGM54DXKgOR6pnXzPgEMbyFUbREhv
zvytED7e2Vk37KuWHy6NiH999lMxHUw8A+7YeuLF4sGbO/JaLeELwRx+sDqy5xiw
E9f+31zRwaH2MO/x0S9Nk+V4vRRBUcVU6NZDUpEhtIGYWHAAz0ObyL5OYv9Qjmqx
MeYgushVJrdgUIjVYWx1ZtQAj59Agg==
=3iQB
-----END PGP SIGNATURE-----

--Sig_/5q7tcYTUM6mhDb5V.fk6AfR--
