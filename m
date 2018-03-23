Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCWH2d (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:28:33 -0400
Received: from ozlabs.org ([103.22.144.67]:40937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbeCWH22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:28:28 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 23 Mar 2018 18:27:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 23
Message-ID: <20180323182744.04e8a720@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uPTjBNp.59/VGpAPQl=Du=n"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uPTjBNp.59/VGpAPQl=Du=n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180322:

The vfs tree still had its build failure for which I reverted a commit.

The tip tree gained a conflict against the pm tree.

The akpm-current tree gained a conflict against the tip tree.

Non-merge commits (relative to Linus' tree): 9556
 11897 files changed, 437709 insertions(+), 774126 deletions(-)

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
Merging origin/master (3215b9d57a2c Merge tag 'clk-fixes-for-linus' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging fixes/master (7928b2cbe55b Linux 4.16-rc1)
Merging kbuild-current/fixes (0f0e8de334c5 kbuild: set no-integrated-as bef=
ore incl. arch Makefile)
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
Merging net/master (5dcd8400884c macsec: missing dev_put() on error in macs=
ec_newlink())
Merging bpf/master (ba9a190872e6 Merge branch 'net-sched-action-idr-leak')
Merging ipsec/master (f8a554b4aa96 vti6: Fix dev->max_mtu setting)
Merging netfilter/master (aebfa52a925d netfilter: drop template ct when con=
ntrack is skipped.)
Merging ipvs/master (f7fb77fc1235 netfilter: nft_compat: check extension ho=
ok mask only if set)
Merging wireless-drivers/master (9b9322db5c5a brcmfmac: Fix check for ISO31=
66 code)
Merging mac80211/master (60b01bcce971 ath9k_htc: use non-QoS NDP for AP pro=
bing)
Merging rdma-fixes/for-rc (caf61b1b8b88 RDMA/qedr: Fix QP state initializat=
ion race)
Merging sound-current/for-linus (8e6b1a72a75b ALSA: aloop: Fix access to no=
t-yet-ready substream via cable)
Merging pci-current/for-linus (fc110ebdd014 PCI: dwc: Fix enumeration end w=
hen reaching root subordinate)
Merging driver-core.current/driver-core-linus (0c8efd610b58 Linux 4.16-rc5)
Merging tty.current/tty-linus (c698ca527893 Linux 4.16-rc6)
Merging usb.current/usb-linus (c698ca527893 Linux 4.16-rc6)
Merging usb-gadget-fixes/fixes (c6ba5084ce0d usb: gadget: udc: renesas_usb3=
: add binging for r8a77965)
Merging usb-serial-fixes/usb-linus (86d71233b615 USB: serial: ftdi_sio: add=
 support for Harman FirmwareHubEmulator)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (59fba0869aca phy: qcom-ufs: add MODULE_LICENSE tag)
Merging staging.current/staging-linus (4c41aa24baa4 staging: ncpfs: memory =
corruption in ncp_read_kernel())
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
Merging mips-fixes/mips-fixes (a63d706ea719 MIPS: ralink: Fix booting on MT=
7621)
Merging kvm-fixes/master (52be7a467e4b Merge tag 'kvm-ppc-fixes-4.16-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into kvm-maste=
r)
Merging kvms390-fixes/master (f07afa0462b7 KVM: s390: fix memory overwrites=
 when not using SCA entries)
Merging drm-intel-fixes/for-linux-next-fixes (3a088dd1b72d drm/i915: Specif=
y which engines to reset following semaphore/event lockups)
Merging drm-misc-fixes/for-linux-next-fixes (3b82a4db8eac drm: udl: Properl=
y check framebuffer mmap offsets)
Merging syscalls/syscalls-next (0978e2fc1338 bpf: whitelist all syscalls fo=
r error injection)
Merging kbuild/for-next (06ad04ea19b8 Merge branches 'kbuild' and 'kconfig'=
 into for-next)
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
Merging amlogic/for-next (5f1dd1796c7c Merge branch 'v4.17/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (20d3f36b0fea Merge tag 'at91-ab-4.17-dt2' into at91=
-next)
Merging bcm2835/for-next (cf172af3be59 Merge branch anholt/bcm2835-defconfi=
g-next into for-next)
Merging imx-mxs/for-next (dee23d344a73 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (dacf37850167 Merge branch 'for_4.17/soc-drivers' int=
o next)
Merging mvebu/for-next (a1110f3c567f Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (d1cc5c055f7a Merge branch 'omap-for-v4.17/defconfig'=
 into for-next)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/logicpd-torpedo-som=
.dtsi
Merging reset/reset/next (a2d34cbe8004 reset: stm32mp1: Enable stm32mp1 res=
et driver)
Merging qcom/for-next (186d88395e05 Merge tag 'qcom-arm64-defconfig-for-4.1=
7' into all-for-4.17-final)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (58eb42a95b24 Merge branches 'arm64-defconfig-for-v4.1=
7', 'arm64-dt-for-v4.17', 'defconfig-for-v4.17', 'dt-bindings-for-v4.17', '=
dt-for-v4.17' and 'soc-for-v4.17' into next)
Merging rockchip/for-next (bba558b5d864 Merge branch 'v4.17-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (0bc590a59ce6 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (2d567752a056 Merge branch 'sunxi/clk-for-4.17=
' into sunxi/for-next)
Merging tegra/for-next (6b9b5116227d Merge branch for-4.17/clk into for-nex=
t)
Merging arm64/for-next/core (af4a81b9cd84 arm64: fpsimd: Fix bad si_code fo=
r undiagnosed SIGFPE)
CONFLICT (content): Merge conflict in include/uapi/asm-generic/siginfo.h
Merging clk/clk-next (8b229cb16695 Merge branch 'clk-hisi' into clk-next)
Merging clk-samsung/for-next (182c084da5d1 clk: samsung: Add fout=3D1966080=
01 Hz EPLL rate entry for exynos4412)
Merging c6x/for-linux-next (9d440f7a2824 c6x: fix platforms/plldata.c get_c=
oreid build error)
Merging m68k/for-next (51fd62769d41 m68k/defconfig: Update defconfigs for v=
4.16-rc5)
Merging m68knommu/for-next (661e50bc8532 Linux 4.16-rc4)
Merging metag/for-next (8d06c3302635 i2c: img-scb: Drop METAG dependency)
Merging microblaze/next (70f6283a372b microblaze: Use generic pci_mmap_reso=
urce_range())
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (b9120c016da8 MAINTAINERS: Add entry for Micro=
semi MIPS SoCs)
Merging nds32/next (6fc61ee69433 nds32: To use the generic dump_stack())
Merging nios2/for-next (e0691ebb33c1 nios2: defconfig: Cleanup from old Kco=
nfig options)
Merging openrisc/for-next (0fedb7653af7 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (5464408e6bc4 parisc/Kconfig: SMP kernels boot o=
n all machines)
Merging powerpc/next (78e5dfea84dc powerpc: dts: replace 'linux,stdout-path=
' with 'stdout-path')
CONFLICT (content): Merge conflict in lib/raid6/test/Makefile
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (c698ca527893 Linux 4.16-rc6)
Merging s390/features (bcbd41da3b0a Merge tag 'vfio-ccw-20180305' of git://=
git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into features)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
Merging sparc-next/master (257a1aac7a9a sparc: Make auxiliary vectors for A=
DI available on 32-bit as well)
CONFLICT (content): Merge conflict in arch/x86/kernel/signal_compat.c
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
Merging btrfs-kdave/for-next (b23ea5fe1f19 Merge branch 'for-next-next-v4.1=
7-20180319' into for-next-20180319)
Merging ceph/master (1c7892495788 ceph: fix potential memory leak in init_c=
aches())
Merging cifs/for-next (7181198b3b6a [SMB3] Don't log expected error on DFS =
referral request)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (4670269faba7 eCryptfs: constify attribute_group stru=
ctures.)
Merging ext3/for_next (a9cee1764b6f reiserfs: Remove VLA from fs/reiserfs/r=
eiserfs.h)
Merging ext4/dev (5dc397113d19 ext4: create ext4_kset dynamically)
Merging f2fs/dev (81f5af16f39a f2fs: align memory boundary for bitops)
Merging fuse/for-next (5ba24197b94d fuse: add writeback documentation)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (3215b9d57a2c Merge tag 'clk-fixes-for-linus' of git=
://git.kernel.org/pub/scm/linux/kernel/git/clk/linux)
Merging nfs-anna/linux-next (27f002315892 nfs4: wake any lock waiters on su=
ccessful RECLAIM_COMPLETE)
Merging nfsd/nfsd-next (aacbc447c42b NFS: Fix unstable write completion)
Merging orangefs/for-next (74e938c22705 orangefs: reverse sense of is-inode=
-stale test in d_revalidate)
Merging overlayfs/overlayfs-next (36cd95dfa1ed ovl: update Kconfig texts)
Merging ubifs/linux-next (7f29ae9f977b ubi: block: Fix locking for idr_allo=
c/idr_remove)
Merging xfs/for-next (df79b81b2e6a xfs: minor cleanup for xfs_reflink_end_c=
ow)
Merging file-locks/locks-next (8bad6f173914 locks: change POSIX lock owners=
hip on execve when files_struct is displaced)
Merging vfs/for-next (98a972e27841 Merge branch 'work.thaw' into for-next)
Applying: Revert "buffer.c: call thaw_super during emergency thaw"
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
Merging hwmon-staging/hwmon-next (7add371c835b hwmon: (pmbus/adm1275) Add s=
upport for ADM1272)
Merging jc_docs/docs-next (aebb47d4e7a9 Input: trackpoint: document sysfs i=
nterface)
Merging v4l-dvb/master (f67449fdba3b media: debugfs-cec-error-inj: document=
 CEC error inj debugfs ABI)
CONFLICT (modify/delete): drivers/media/platform/blackfin/bfin_capture.c de=
leted in HEAD and modified in v4l-dvb/master. Version v4l-dvb/master of dri=
vers/media/platform/blackfin/bfin_capture.c left in tree.
$ git rm -f drivers/media/platform/blackfin/bfin_capture.c
Merging v4l-dvb-next/master (a1dfb4c48cc1 media: v4l2-compat-ioctl32.c: ref=
actor compat ioctl32 logic)
Merging fbdev/fbdev-for-next (2c81ee0a28c0 video: fbdev: via: remove VLA us=
age)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
Merging pm/linux-next (a8e4e5ec7e77 Merge branch 'pm-cpuidle' into linux-ne=
xt)
Merging cpupower/cpupower (7928b2cbe55b Linux 4.16-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (4a823c0be80f opp: cpu: Replace GFP_ATOMIC with =
GFP_KERNEL in dev_pm_opp_init_cpufreq_table)
Merging thermal/next (0f1a0183eae6 Merge branches 'thermal-core' and 'therm=
al-soc' into next)
Merging thermal-soc/next (d0ecbbbe518e thermal/drivers/hisi: Remove bogus c=
onst from function return type)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (9250e523592a dlm: remove dlm_send_rcom_lookup_dump)
Merging swiotlb/linux-next (69369f52d28a swiotlb-xen: implement xen_swiotlb=
_get_sgtable callback)
Merging rdma/for-next (98f1f4e0ed26 IB/core: Refer to RoCE port property in=
stead of GID table property)
CONFLICT (content): Merge conflict in drivers/infiniband/core/ucma.c
Merging net-next/master (6686c459e144 Merge branch 'hns3-VF-reset')
CONFLICT (content): Merge conflict in net/mac80211/debugfs.c
CONFLICT (content): Merge conflict in net/ipv4/xfrm4_policy.c
CONFLICT (content): Merge conflict in include/net/mac80211.h
CONFLICT (content): Merge conflict in include/linux/socket.h
CONFLICT (content): Merge conflict in drivers/net/phy/phy.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlxsw/s=
pectrum.h
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlxsw/s=
pectrum.c
Applying: mlxsw: merge fix for move of SPAN code
Merging bpf-next/master (454bfe97837a Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/bpf/bpf-next)
Merging ipsec-next/master (415a13296a1a xfrm_policy: use true and false for=
 boolean values)
Merging netfilter-next/master (78d9f4d49bbe netfilter: ebtables: add suppor=
t for matching IGMP type)
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (a910d20aa007 netfilter: ipvs: Fix space before '[=
' error.)
Merging wireless-drivers-next/master (28bf8312a983 mwifiex: get_channel fro=
m firmware)
Merging bluetooth/master (243fc8da6518 Bluetooth: Remove VLA usage in aes_c=
mac)
Merging mac80211-next/master (13cf6dec93e0 cfg80211/nl80211: add DFS offloa=
d flag)
Merging gfs2/for-next (ee6ed857c805 gfs2: gfs2_iomap_end tracepoint: log bl=
ock address)
Merging mtd/master (6de564939e14 mtdchar: fix usage of mtd_ooblayout_ecc())
Merging l2-mtd/mtd/next (5741a164ff6f mtd: maps: remove bfin-async-flash dr=
iver)
Merging nand/nand/next (b1206122069a mtd: rawnand: gpmi: use core timings i=
nstead of an empirical derivation)
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
Merging crypto/master (1a3713c7cd8c crypto: arm64/sha256-neon - play nice w=
ith CONFIG_PREEMPT kernels)
CONFLICT (modify/delete): drivers/crypto/bfin_crc.c deleted in HEAD and mod=
ified in crypto/master. Version crypto/master of drivers/crypto/bfin_crc.c =
left in tree.
$ git rm -f drivers/crypto/bfin_crc.c
Merging drm/drm-next (b4eec0fa5371 Merge tag 'drm-intel-next-fixes-2018-03-=
22' of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in sound/pci/hda/hda_intel.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/sun4i/sun4i_tcon.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/sun4i/sun4i_tcon.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_breadcrumb=
s.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_request.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/gvt/scheduler.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/hwmgr/s=
mu7_hwmgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/amd_pow=
erplay.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/inc/hw=
_sequencer.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dcn10/=
dcn10_hw_sequencer.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce110=
/dce110_hw_sequencer.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce/dc=
e_link_encoder.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce/dc=
e_hwseq.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c_stream.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/si.c
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (8c5cb3c1c570 Merge tag 'gvt-next-fixes-20=
18-03-20' of https://github.com/intel/gvt-linux into drm-intel-next-fixes)
Merging drm-tegra/drm/tegra/for-next (27e92f1f1600 drm/tegra: prime: Implem=
ent ->{begin,end}_cpu_access())
Merging drm-misc/for-linux-next (3ae7fb202d86 drm: Remove drm_property_{un/=
reference}_blob aliases)
Merging drm-msm/msm-next (288e5c8898c4 drm/msm: fix building without debugf=
s)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (6e810eb508f4 drm: mali-dp: Add YUV->R=
GB conversion support for video layers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (4a3928c6f8a5 Linux 4.16-rc3)
Merging etnaviv/etnaviv/next (4ed75c3e5255 drm/etnaviv: bump HW job limit t=
o 4)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (2889312616ae Merge remote-tracking branches 'regma=
p/topic/debugfs' and 'regmap/topic/mmio-clk' into regmap-next)
Merging sound/for-next (9a2fe9b801f5 ALSA: usb: initial USB Audio Device Cl=
ass 3.0 support)
Merging sound-asoc/for-next (3c0239e01a18 Merge remote-tracking branch 'aso=
c/topic/zx_aud96p22' into asoc-next)
Merging modules/modules-next (3f553b308bb0 module: propagate error in modul=
es_open())
Merging input/next (68106869e802 Input: pxrc - new driver for PhoenixRC Fli=
ght Controller Adapter)
Merging block/for-next (4993fa4a2753 Merge branch 'for-4.17/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (83260a18a9de dm bufio: support non-power-of=
-two block sizes)
Merging mmc/next (4472f0fc248e mmc: renesas_sdhi: replace EXT_ACC with HOST=
_MODE)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (3de59bb9d551 md/raid1: fix NULL pointer dereference)
Merging mfd/for-mfd-next (e2be8c26c80a mfd: pcf50633: Fix some memory leaks=
 in the error handling path of 'pcf50633_probe()')
Merging backlight/for-backlight-next (ba11349b2a57 dt-bindings: backlight: =
Add binding for RAVE SP backlight driver)
Merging battery/for-next (fd73a3e61888 power: reset: at91-reset: Switch fro=
m the pr_*() to the dev_*() logging functions)
Merging regulator/for-next (3eae442950c8 Merge remote-tracking branches 're=
gulator/topic/88pg86x', 'regulator/topic/dt', 'regulator/topic/formatting' =
and 'regulator/topic/gpio' into regulator-next)
Merging security/next-testing (884a1561c87b Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (e540c3c90193 apparmor: update MAINTAINERS f=
ile git and wiki locations)
Merging integrity/next-integrity (638872e2ad9e evm: check for remount ro in=
 progress before writing)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (6b6bc6205d98 selinux: wrap AVC state)
CONFLICT (content): Merge conflict in security/selinux/hooks.c
CONFLICT (content): Merge conflict in net/sctp/socket.c
Merging tpmdd/next (800091ee50ec tpm: fix intermittent failure with self te=
sts)
Merging watchdog/master (2e8ebed6ede0 Merge branch 'v4.16-fixes')
Merging iommu/next (5388d81be69c Merge branches 'x86/amd', 'x86/vt-d', 'arm=
/rockchip', 'arm/omap', 'arm/mediatek', 'arm/exynos', 'arm/renesas' and 'co=
re' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (356e88ebe447 vfio/type1: Improve memory pinning process =
for raw PFN mapping)
Merging trivial/for-next (1972d6c0c86d MAINTAINERS: relinquish kconfig)
Merging audit/next (ea841bafda3f audit: add refused symlink to audit_names)
Merging devicetree/for-next (827473268ee4 of: unittest: fix an error code i=
n of_unittest_apply_overlay())
Merging mailbox/mailbox-for-next (41c0e939d70d mailbox: Add support for Hi3=
660 mailbox)
Merging spi/for-next (357982f0ad1d Merge remote-tracking branches 'spi/topi=
c/sprd' and 'spi/topic/tegra20-slink' into spi-next)
CONFLICT (content): Merge conflict in drivers/spi/Kconfig
Merging tip/auto-latest (f9281a9cfc4e Merge branch 'irq/core')
CONFLICT (content): Merge conflict in kernel/sched/cpufreq_schedutil.c
CONFLICT (content): Merge conflict in drivers/bus/arm-cci.c
CONFLICT (modify/delete): Documentation/trace/ftrace.txt deleted in HEAD an=
d modified in tip/auto-latest. Version tip/auto-latest of Documentation/tra=
ce/ftrace.txt left in tree.
$ git rm -f Documentation/trace/ftrace.txt
Applying: perf/core: merge fix for "drivers/bus: Split Arm CCI driver"
Applying: perf/core: another merge fix for "drivers/bus: Split Arm CCI driv=
er"
Applying: trace doc: merge fix for "tracing: Unify the "boot" and "mono" tr=
acing clocks"
Merging clockevents/clockevents/next (135643b1d63d clocksource/drivers/npcm=
: Add NPCM7xx timer driver)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6fd052665274 EDAC, sb_edac: Remove variable leng=
th array usage)
Merging irqchip/irq/irqchip-next (19d99164480a irqchip: Add a driver for th=
e Microsemi Ocelot controller)
CONFLICT (content): Merge conflict in drivers/irqchip/Makefile
Merging ftrace/for-next (80765597bc58 tracing: Rewrite filter logic to be s=
impler and faster)
CONFLICT (modify/delete): Documentation/trace/ftrace.txt deleted in HEAD an=
d modified in ftrace/for-next. Version ftrace/for-next of Documentation/tra=
ce/ftrace.txt left in tree.
CONFLICT (content): Merge conflict in Documentation/trace/events.rst
$ git rm -f Documentation/trace/ftrace.txt
Applying: trace doc: merge fix for rst conversion of ftrace.txt
Merging rcu/rcu/next (08c5ee913265 softirq: Eliminate unused cond_resched_s=
oftirq() macro)
Merging kvm/linux-next (4956aa3b8b59 Merge tag 'kvm-s390-next-4.17-1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
CONFLICT (content): Merge conflict in drivers/video/Kconfig
Merging kvm-arm/next (f9f5dc19509b arm64: KVM: Use SMCCC_ARCH_WORKAROUND_1 =
for Falkor BP hardening)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (7928b2cbe55b Linux 4.16-rc1)
Merging kvms390/next (ccc40c53c07b KVM: s390: provide counters for all inte=
rrupt injects/delivery)
Merging xen-tip/linux-next (4d0f1ce69559 xen/acpi: upload _PSD info for non=
 Dom0 CPUs too)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (1aa3798360db Merge branch 'for-4.17' into for-=
next)
Merging drivers-x86/for-next (cc69c88fbeb9 platform/x86: dell-smbios: Resol=
ve dependency error on DCDBAS)
CONFLICT (content): Merge conflict in drivers/platform/x86/Kconfig
Merging chrome-platform/for-next (3b7cedb42420 platform/chrome: cros_ec_lpc=
: Add support for Google devices using custom coreboot firmware)
Merging hsi/for-next (e3d7fbab062b HSI: hsi_char: Delete an error message f=
or a failed memory allocation in hsc_probe())
Merging leds/for-next (92d7ec1d71e3 leds: Fix wrong dmi_match on PC Engines=
 APU LEDs)
Merging ipmi/for-next (bc48fa1b9d3b ipmi:pci: Blacklist a Realtek "IPMI" de=
vice)
Merging driver-core/driver-core-next (d723522b0be4 mt7601u: use firmware_re=
quest_cache() to address cache on reboot)
Merging usb/usb-next (29bca25e1bc4 usb: skip phys initialization of shared =
hcd)
Merging usb-gadget/next (2f710c1bb666 usb: phy: ab8500: Drop AB8540/9540 su=
pport)
Merging usb-serial/usb-next (9b284d8e648b USB: serial: option: use mass-sto=
rage class define)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx:=
 Fix ULPI on imx53)
Merging phy-next/next (e7f4da4c44fe phy: tegra: xusb: Uncomment register wr=
ite)
Merging tty/tty-next (c685af1108d7 serial: mvebu-uart: fix tx lost characte=
rs)
CONFLICT (content): Merge conflict in drivers/tty/hvc/Makefile
CONFLICT (content): Merge conflict in drivers/tty/hvc/Kconfig
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih418-b2199.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih410-b2260.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih410-b2120.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih407-b2120.dts
Merging char-misc/char-misc-next (c50099f856bf Merge tag 'extcon-next-for-4=
.17' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into c=
har-misc-next)
Merging extcon/extcon-next (eb7768e774d1 Merge branch 'ib-extcon-drm-dt-v4.=
17' into extcon-next)
Merging staging/staging-next (12a0148711a4 staging: mt7621-eth: fix spellin=
g mistake: "devictree" -> "devicetree")
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
Merging slave-dma/next (f865c320453b Merge branch 'fixes' into next)
Merging cgroup/for-next (d1897c9538ed cgroup: fix rule checking for threade=
d mode switching)
Merging scsi/for-next (435458e41180 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (ad448378825f scsi: ufs: Add support for Auto-Hib=
ernate Idle Timer)
CONFLICT (content): Merge conflict in drivers/scsi/qla2xxx/qla_os.c
CONFLICT (modify/delete): drivers/scsi/eata.c deleted in scsi-mkp/for-next =
and modified in HEAD. Version HEAD of drivers/scsi/eata.c left in tree.
$ git rm -f drivers/scsi/eata.c
Applying: scsi: qla2xxx: merge fix in qla_gs.c
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (d09c02fa64a5 Merge branch 'for-4.17' into for-next)
Merging vhost/linux-next (54939f252f97 fw_cfg: write vmcoreinfo details)
Merging rpmsg/for-next (6366ff79e09f Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
CONFLICT (content): Merge conflict in samples/Makefile
Merging gpio/for-next (6e9554a48bd1 gpio: ks8695: Include the right header)
Merging pinctrl/for-next (dfb1c1da3da7 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging pwm/for-next (bccaa3f917c9 pwm: meson: Add clock source configurati=
on for Meson-AXG)
Merging userns/for-next (dd206bec9a44 pidns: simpler allocation of pid_* ca=
ches)
Merging ktest/for-next (f7c6401ff84a ktest: Make sure wait_for_input does h=
onor the timeout)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (6c3b6d508391 selftests/seccomp: Allow get_metadata =
to XFAIL)
Merging y2038/y2038 (8bad56707b0b arm64: fix perf_regs.c)
CONFLICT (modify/delete): arch/tile/include/asm/compat.h deleted in HEAD an=
d modified in y2038/y2038. Version y2038/y2038 of arch/tile/include/asm/com=
pat.h left in tree.
$ git rm -f arch/tile/include/asm/compat.h
Merging livepatching/for-next (d13f5d84ca27 Merge branch 'for-4.16/signal-s=
ysfs-force-v2' into for-next)
Merging coresight/next (c24ae3b69146 coresight: etm4x: Fix bit shifting)
Merging rtc/rtc-next (1358dd1cc91a rtc: ab8500: Drop AB8540 support)
Merging nvdimm/libnvdimm-for-next (539a95dc4083 Merge branch 'for-4.17/dax'=
 into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/xfs/xfs_inode.h
CONFLICT (content): Merge conflict in arch/x86/mm/init_64.c
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in L=
DFLAGS too)
Merging at24/at24/for-next (84e10623c0b9 dt-bindings: at24: add Renesas R1E=
X24128)
Merging ntb/ntb-next (53c3677c56c7 ntb: intel: change references of skx to =
gen3)
Merging kspp/for-next/kspp (2d00fcb32f71 Merge branch 'kspp/gcc-plugin/infr=
astructure' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging akpm-current/current (382a597787e7 ipc/shm.c: shm_split(): remove u=
nneeded test for NULL shm_file_data.vm_ops)
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in fs/ocfs2/filecheck.c
CONFLICT (content): Merge conflict in drivers/block/zram/zram_drv.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: ipc/mqueue: add missing error code in init_mqueue_fs()
Applying: fs/dcache.c: add cond_resched() in shrink_dentry_list()
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
Applying: include/linux/kexec.h: silence compile warnings
Applying: kernel/kexec_file.c: remove checks in kexec_purgatory_load
Applying: kernel/kexec_file.c: make purgatory_info->ehdr const
Applying: kernel/kexec_file.c: search symbols in read-only kexec_purgatory
Applying: kernel/kexec_file.c: use read-only sections in arch_kexec_apply_r=
elocations*
Applying: kernel/kexec_file.c: split up __kexec_load_puragory
Applying: kernel/kexec_file.c: remove unneeded for-loop in kexec_purgatory_=
setup_sechdrs
Applying: kernel/kexec_file.c: remove unneeded variables in kexec_purgatory=
_setup_sechdrs
Applying: kernel/kexec_file.c: remove mis-use of sh_offset field during pur=
gatory load
Applying: kernel/kexec_file.c: allow archs to set purgatory load address
Applying: kernel/kexec_file.c: move purgatories sha256 to common code
Applying: kernel/kexec_file.c: add walk_system_ram_res_rev()
Applying: kernel/kexec_file.c: load kernel at top of system RAM if required
Applying: mm: introduce MAP_FIXED_NOREPLACE
Applying: fs, elf: drop MAP_FIXED usage from elf_map
Applying: elf: enforce MAP_FIXED on overlaying elf segments
Applying: xen, mm: allow deferred page initialization for xen pv domains
Applying: zboot: fix stack protector in compressed boot phase
Applying: linux/const.h: prefix include guard of uapi/linux/const.h with _U=
API
Applying: linux/const.h: move UL() macro to include/linux/const.h
Applying: linux/const.h: refactor _BITUL and _BITULL a bit
Applying: mm: memcg: remote memcg charging for kmem allocations
Applying: mm: memcg: remote memcg charging for kmem allocations fix
Applying: fs: fsnotify: account fsnotify metadata to kmemcg
Applying: fs-fsnotify-account-fsnotify-metadata-to-kmemcg-fix
Applying: treewide: align function definition open/close braces
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (0824d53e631e sparc64: NG4 memset 32 bits overflow)

--Sig_/uPTjBNp.59/VGpAPQl=Du=n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlq0rHAACgkQAVBC80lX
0GzThwf+Le1ckSJ/l7UGsnJudbPmsCMe9lEPkFdpl0/NL/DwHDME9VH0WlXVrLQs
hWYP/mctnWV9uhe5LrRRJ/uPKiOjf5lwOuP9q0XrPNIVCvxjOz2ViuV3egXHkaaz
kUYmsCbq0aC6ig4/GHRkpyjIebLVRR3FmHmw/+zvzW8JXIOl79mnCxXK+SOMjI4F
0BLUk9Z0gi0ej1fXzM5nuje3wTBVRzZTYvxuxDs+B8yAafa305+mdreo+NXFVSXs
0XkPIEjIaWjcG5nepAAdMZCWl6C6KYi13a6VE7Ib/jJp7wiEyLAqMAtQHb6zZ+rW
48JVnP6h9Y0tPeznKjoqJKuIP98GTQ==
=od+h
-----END PGP SIGNATURE-----

--Sig_/uPTjBNp.59/VGpAPQl=Du=n--
