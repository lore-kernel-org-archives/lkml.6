Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755187AbeDCJEo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 05:04:44 -0400
Received: from ozlabs.org ([103.22.144.67]:35335 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbeDCJEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 05:04:34 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Tue, 3 Apr 2018 19:03:39 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 3
Message-ID: <20180403190339.391f811b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Le1sF=fB+MyprTB6b4LhrEV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Le1sF=fB+MyprTB6b4LhrEV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any v4.18 destined stuff to your linux-next included
trees until after v4.17-rc1 has been released.

Changes since 20180329:

The kbuild tree lost its build failure.

The asm-generic tree gained a conflict against Linus' tree.

The vfs tree still had its build failure for which I reverted a commit.

The pci tree gained conflicts against Linus', the asm-generic and
arm-soc trees.

The net-next tree gained a conflict against the pci tree.

The selinux tree gained a conflict against the security tree.

Non-merge commits (relative to Linus' tree): 9213
 11817 files changed, 430998 insertions(+), 772860 deletions(-)

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
Merging origin/master (46e0d28bdb8e Merge branch 'sched-core-for-linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/master (7928b2cbe55b Linux 4.16-rc1)
Merging kbuild-current/fixes (28913ee8191a netfilter: nf_nat_snmp_basic: ad=
d correct dependency to Makefile)
Merging arc-current/for-curr (661e50bc8532 Linux 4.16-rc4)
Merging arm-current/fixes (1b8837b61714 ARM: 8750/1: deflate_xip_data.sh: m=
inor fixes)
Merging arm64-fixes/for-next/fixes (e21da1c99200 arm64: Relax ARM_SMCCC_ARC=
H_WORKAROUND_1 discovery)
Merging m68k-current/for-linus (ecd685580c8f m68k/mac: Remove bogus "FIXME"=
 comment)
Merging metag-fixes/fixes (b884a190afce metag/usercopy: Add missing fixups)
Merging powerpc-fixes/fixes (52396500f97c powerpc/64s: Fix i-side SLB miss =
bad address handler saving nonvolatile GPRs)
Merging sparc/master (9c548bb5823d sparc64: Oracle DAX driver depends on SP=
ARC64)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (b5dbc28762fd Merge tag 'kbuild-fixes-v4.16-3' of git://=
git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging bpf/master (e8a4796ee295 nfp: bpf: fix check of program max insn co=
unt)
Merging ipsec/master (9a3fb9fb84cc xfrm: Fix transport mode skb control buf=
fer usage.)
Merging netfilter/master (b9fc828debc8 qede: Fix barrier usage after tx doo=
rbell write.)
Merging ipvs/master (f7fb77fc1235 netfilter: nft_compat: check extension ho=
ok mask only if set)
Merging wireless-drivers/master (9b9322db5c5a brcmfmac: Fix check for ISO31=
66 code)
Merging mac80211/master (1dfe82ebd7d8 net: fix possible out-of-bound read i=
n skb_network_protocol())
Merging rdma-fixes/for-rc (84652aefb347 RDMA/ucma: Introduce safer rdma_add=
r_size() variants)
Merging sound-current/for-linus (903d271a3f83 Merge tag 'asoc-v4.17' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus)
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
Merging staging.current/staging-linus (a0306db6e575 Merge 4.16-rc7 into sta=
ging-next)
Merging char-misc.current/char-misc-linus (3eb2ce825ea1 Linux 4.16-rc7)
Merging input-current/for-linus (567b9b549cfa Input: ALPS - fix TrackStick =
detection on Thinkpad L570 and Latitude 7370)
Merging crypto-current/master (c927b080c67e crypto: s5p-sss - Fix kernel Oo=
ps in AES-ECB mode)
Merging ide/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_time')
Merging vfio-fixes/for-linus (834814e80268 Revert: "vfio-pci: Mask INTx if =
a device is not capabable of enabling it")
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
Merging kvm-fixes/master (17a1079d9c63 KVM: x86: Fix pv tlb flush dependenc=
ies)
Merging kvms390-fixes/master (f07afa0462b7 KVM: s390: fix memory overwrites=
 when not using SCA entries)
Merging drm-intel-fixes/for-linux-next-fixes (3eb2ce825ea1 Linux 4.16-rc7)
Merging drm-misc-fixes/for-linux-next-fixes (5a9f698feb11 drm/ast: Fixed 12=
80x800 Display Issue)
Merging syscalls/syscalls-next (c9a211951c7c bpf: whitelist all syscalls fo=
r error injection)
Merging kbuild/for-next (1b7bdaa0f91e Merge branches 'kbuild', 'kconfig' an=
d 'kbuild2' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging efi-lock-down/efi-lock-down (89bcd5b02f12 lockdown: Print current->=
comm in restriction messages)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (1f674e16f9ce usb: gadget: Add NO_DMA dummies =
for DMA mapping API)
Merging asm-generic/master (dd3b8c329aa2 MAINTAINERS: UNICORE32: Change ema=
il account)
CONFLICT (content): Merge conflict in lib/Kconfig.debug
CONFLICT (content): Merge conflict in drivers/input/joystick/analog.c
CONFLICT (modify/delete): arch/metag/boot/dts/Makefile deleted in asm-gener=
ic/master and modified in HEAD. Version HEAD of arch/metag/boot/dts/Makefil=
e left in tree.
CONFLICT (modify/delete): arch/blackfin/kernel/bfin_ksyms.c deleted in asm-=
generic/master and modified in HEAD. Version HEAD of arch/blackfin/kernel/b=
fin_ksyms.c left in tree.
$ git rm -f arch/blackfin/kernel/bfin_ksyms.c arch/metag/boot/dts/Makefile
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (1c98ff49448a Merge branch 'devel-stable' into for-nex=
t)
Merging arm-perf/for-next/perf (44300aed5d28 perf: arm_spe: include linux/v=
malloc.h for vmap())
Merging arm-soc/for-next (37c8295552b6 Merge branch 'next/dt' into for-next)
CONFLICT (content): Merge conflict in drivers/bus/arm-cci.c
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (059e40d90876 Merge branch 'v4.17/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (20d3f36b0fea Merge tag 'at91-ab-4.17-dt2' into at91=
-next)
Merging bcm2835/for-next (cf172af3be59 Merge branch anholt/bcm2835-defconfi=
g-next into for-next)
Merging imx-mxs/for-next (98f9530adda3 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (dacf37850167 Merge branch 'for_4.17/soc-drivers' int=
o next)
Merging mvebu/for-next (4c1b45a44e35 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (d1cc5c055f7a Merge branch 'omap-for-v4.17/defconfig'=
 into for-next)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/logicpd-torpedo-som=
.dtsi
Merging reset/reset/next (0089313d8595 Merge branch 'reset/lookup' into res=
et/next)
Merging qcom/for-next (186d88395e05 Merge tag 'qcom-arm64-defconfig-for-4.1=
7' into all-for-4.17-final)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (58eb42a95b24 Merge branches 'arm64-defconfig-for-v4.1=
7', 'arm64-dt-for-v4.17', 'defconfig-for-v4.17', 'dt-bindings-for-v4.17', '=
dt-for-v4.17' and 'soc-for-v4.17' into next)
Merging rockchip/for-next (f5a45eb97728 Merge branch 'v4.17-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (0bc590a59ce6 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (2d567752a056 Merge branch 'sunxi/clk-for-4.17=
' into sunxi/for-next)
Merging tegra/for-next (6b9b5116227d Merge branch for-4.17/clk into for-nex=
t)
Merging arm64/for-next/core (65896545b69f arm64: uaccess: Fix omissions fro=
m usercopy whitelist)
CONFLICT (content): Merge conflict in include/uapi/asm-generic/siginfo.h
CONFLICT (content): Merge conflict in arch/arm64/kernel/cpu_errata.c
Merging clk/clk-next (804a4481ff50 Merge branch 'clk-si544' into clk-next)
Merging clk-samsung/for-next (182c084da5d1 clk: samsung: Add fout=3D1966080=
01 Hz EPLL rate entry for exynos4412)
Merging c6x/for-linux-next (9d440f7a2824 c6x: fix platforms/plldata.c get_c=
oreid build error)
Merging m68k/for-next (ecd685580c8f m68k/mac: Remove bogus "FIXME" comment)
Merging m68knommu/for-next (f61e64310b75 m68k: set dma and coherent masks f=
or platform FEC ethernets)
Merging metag/for-next (8d06c3302635 i2c: img-scb: Drop METAG dependency)
Merging microblaze/next (70f6283a372b microblaze: Use generic pci_mmap_reso=
urce_range())
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (272641206100 MIPS: BCM47XX: Add Luxul XAP1500=
/XWR1750 WiFi LEDs)
Merging nds32/next (6fc61ee69433 nds32: To use the generic dump_stack())
Merging nios2/for-next (e0691ebb33c1 nios2: defconfig: Cleanup from old Kco=
nfig options)
Merging openrisc/for-next (0fedb7653af7 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (899f04ea7977 ipmi/parisc: Add IPMI chassis powe=
roff for certain HP PA-RISC and IA-64 servers)
Merging powerpc/next (19e68b2aec3c powerpc/mm/radix: Fix always false compa=
rison against MMU_NO_CONTEXT)
CONFLICT (content): Merge conflict in lib/raid6/test/Makefile
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (3eb2ce825ea1 Linux 4.16-rc7)
Merging s390/features (92fa7a13c845 s390/kvm: improve stack frame constants=
 in entry.S)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
Merging sparc-next/master (49d7006d9f01 sparc64: Properly range check DAX c=
ompletion index)
CONFLICT (content): Merge conflict in arch/x86/kernel/signal_compat.c
Merging sh/for-next (d67cbbb113b7 arch/sh: pcie-sh7786: handle non-zero DMA=
 offset)
Merging uml/linux-next (e40238dedb48 Fix vector raw inintialization logic)
Merging xtensa/xtensa-for-next (ae6063c83634 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (0b1dfa4cc6c6 fscrypt: fix build with pre-4.6 gcc ve=
rsions)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (7c9a09f56a91 btrfs: don't use async helpers for crcs wh=
en under IO limits)
Applying: f2fs: fixup for cgroup/writeback change
Merging btrfs-kdave/for-next (65fff2ba326d Merge branch 'for-next-next-v4.1=
7-20180331' into for-next-20180331)
Merging ceph/master (9122eed5281e ceph: quota: report root dir quota usage =
in statfs)
Merging cifs/for-next (07108d0e7c7f cifs: Add minor debug message during ne=
gprot)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (f62fd7a77717 ecryptfs: fix spelling mistake: "cadida=
te" -> "candidate")
Merging ext3/for_next (b91ed9d8082c quota: Kill an unused extern entry form=
 quota.h)
Merging ext4/dev (b025a674fc5d ext4: force revalidation of directory pointe=
r after seekdir(2))
Merging f2fs/dev (e89fbc550b5b f2fs: truncate preallocated blocks in error =
case)
Merging fuse/for-next (5ba24197b94d fuse: add writeback documentation)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (0adb32858b0b Linux 4.16)
Merging nfs-anna/linux-next (7e8b4fa9fce9 NFSv4.1: Fix exclusive create)
Merging nfsd/nfsd-next (81cea12ec51b NFS: Fix unstable write completion)
Merging orangefs/for-next (74e938c22705 orangefs: reverse sense of is-inode=
-stale test in d_revalidate)
Merging overlayfs/overlayfs-next (55c23fb569e4 ovl: cleanup ovl_update_time=
())
Merging ubifs/linux-next (7f29ae9f977b ubi: block: Fix locking for idr_allo=
c/idr_remove)
Merging xfs/for-next (dc1baa715bbf xfs: do not log/recover swapext extent o=
wner changes for deleted inodes)
Merging file-locks/locks-next (8bad6f173914 locks: change POSIX lock owners=
hip on execve when files_struct is displaced)
Merging vfs/for-next (fd70f4425f9b Merge branches 'work.dcache', 'old.dcach=
e', 'work.misc', 'work.thaw', 'misc.compat' and 'misc.sparc' into for-next)
CONFLICT (content): Merge conflict in fs/open.c
CONFLICT (content): Merge conflict in fs/internal.h
CONFLICT (modify/delete): drivers/staging/lustre/lnet/libcfs/linux/linux-pr=
im.c deleted in HEAD and modified in vfs/for-next. Version vfs/for-next of =
drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c left in tree.
CONFLICT (modify/delete): drivers/staging/lustre/lnet/libcfs/linux/linux-cu=
rproc.c deleted in HEAD and modified in vfs/for-next. Version vfs/for-next =
of drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c left in tree.
CONFLICT (content): Merge conflict in arch/sparc/kernel/sys_sparc32.c
$ git rm -f drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c driver=
s/staging/lustre/lnet/libcfs/linux/linux-prim.c
Applying: Revert "buffer.c: call thaw_super during emergency thaw"
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging iversion/iversion-next (581e400ff935 Merge tag 'modules-for-v4.16' =
of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux)
Merging printk/for-next (23545acc2a0e Merge branch 'for-4.17' into for-next)
Merging pci/next (2c48194d63cb Merge branch 'lorenzo/pci/xilinx')
CONFLICT (content): Merge conflict in drivers/pci/quirks.c
CONFLICT (content): Merge conflict in drivers/bus/Makefile
CONFLICT (modify/delete): arch/mn10300/unit-asb2305/pci.c deleted in HEAD a=
nd modified in pci/next. Version pci/next of arch/mn10300/unit-asb2305/pci.=
c left in tree.
CONFLICT (modify/delete): arch/frv/mb93090-mb00/pci-vdk.c deleted in HEAD a=
nd modified in pci/next. Version pci/next of arch/frv/mb93090-mb00/pci-vdk.=
c left in tree.
CONFLICT (modify/delete): arch/cris/arch-v32/drivers/pci/bios.c deleted in =
HEAD and modified in pci/next. Version pci/next of arch/cris/arch-v32/drive=
rs/pci/bios.c left in tree.
$ git rm -f arch/cris/arch-v32/drivers/pci/bios.c arch/frv/mb93090-mb00/pci=
-vdk.c arch/mn10300/unit-asb2305/pci.c
Applying: PCI/cxgb4: morge fix up for move of quirk_chelsio_extend_vpd()
Merging pstore/for-next/pstore (58eb5b670747 pstore: fix crypto dependencie=
s)
Merging hid/for-next (e221c81efb0c Merge branch 'for-4.17/google-hammer' in=
to for-next)
Merging i2c/i2c/for-next (2a0b8aadb47a Merge branch 'i2c/for-current' into =
i2c/for-next)
CONFLICT (modify/delete): arch/blackfin/mach-bf561/boards/acvilon.c deleted=
 in HEAD and modified in i2c/i2c/for-next. Version i2c/i2c/for-next of arch=
/blackfin/mach-bf561/boards/acvilon.c left in tree.
$ git rm -f arch/blackfin/mach-bf561/boards/acvilon.c
Merging dmi/master (eb693e35e850 firmware: dmi_scan: add DMI_OEM_STRING sup=
port to dmi_matches)
Merging hwmon-staging/hwmon-next (e3a2d2be510e hwmon: (via-cputemp) support=
 new centaur CPUs)
Merging jc_docs/docs-next (86afad7d87f5 Documentation/process: update FUSE =
project website)
Merging v4l-dvb/master (6ccd228e0cfc media: fimc-capture: get rid of two wa=
rnings)
CONFLICT (modify/delete): drivers/media/platform/blackfin/bfin_capture.c de=
leted in HEAD and modified in v4l-dvb/master. Version v4l-dvb/master of dri=
vers/media/platform/blackfin/bfin_capture.c left in tree.
$ git rm -f drivers/media/platform/blackfin/bfin_capture.c
Merging v4l-dvb-next/master (a1dfb4c48cc1 media: v4l2-compat-ioctl32.c: ref=
actor compat ioctl32 logic)
Merging fbdev/fbdev-for-next (7c9b845e79ea video: fbdev: s3c-fb: remove dea=
d platform code for Exynos and S5PV210 platforms)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
Merging pm/linux-next (4606b87beeff Merge branch 'acpi-pm' into linux-next)
Merging cpupower/cpupower (7928b2cbe55b Linux 4.16-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (4a823c0be80f opp: cpu: Replace GFP_ATOMIC with =
GFP_KERNEL in dev_pm_opp_init_cpufreq_table)
Merging thermal/next (7d7cbe54e7da Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal into thermal-soc)
Merging thermal-soc/next (2db48884bb51 dt-bindings: thermal: Remove "coolin=
g-{min|max}-level" properties)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (9250e523592a dlm: remove dlm_send_rcom_lookup_dump)
Merging swiotlb/linux-next (69369f52d28a swiotlb-xen: implement xen_swiotlb=
_get_sgtable callback)
Merging rdma/for-next (2253fc0caa80 RDMA/CMA: Add rdma_port_space to UAPI)
CONFLICT (content): Merge conflict in drivers/infiniband/core/ucma.c
Merging net-next/master (159f02977b2f Merge branch 'net-mvneta-improve-susp=
end-resume')
CONFLICT (content): Merge conflict in include/linux/socket.h
CONFLICT (modify/delete): drivers/staging/irda/net/af_irda.c deleted in HEA=
D and modified in net-next/master. Version net-next/master of drivers/stagi=
ng/irda/net/af_irda.c left in tree.
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlx5/co=
re/en_main.c
$ git rm -f drivers/staging/irda/net/af_irda.c
Merging bpf-next/master (7828f20e3779 Merge branch 'bpf-cgroup-bind-connect=
')
Merging ipsec-next/master (415a13296a1a xfrm_policy: use true and false for=
 boolean values)
Merging netfilter-next/master (159f02977b2f Merge branch 'net-mvneta-improv=
e-suspend-resume')
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (a910d20aa007 netfilter: ipvs: Fix space before '[=
' error.)
Merging wireless-drivers-next/master (14c99949a339 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (159f02977b2f Merge branch 'net-mvneta-improve-sus=
pend-resume')
Merging mac80211-next/master (c470bdc1aaf3 mac80211: don't WARN on bad WMM =
parameters from buggy APs)
Merging gfs2/for-next (5e86d9d122d0 gfs2: time journal recovery steps accur=
ately)
Merging mtd/master (87a73eb5b56f mtd: jedec_probe: Fix crash in jedec_read_=
mfr())
Merging l2-mtd/mtd/next (b756816dad0a mtd: ftl: Use DIV_ROUND_UP())
Merging nand/nand/next (097ccca726ff mtd: nand: Fix some function descripti=
on mismatches in core.c)
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
Merging spi-nor/spi-nor/next (e8de85d5a107 dt-bindings: fsl-quadspi: Add th=
e example of two SPI NOR)
Merging crypto/master (f444ec106407 crypto: ccree - remove unused enums)
CONFLICT (modify/delete): drivers/staging/ccree/Makefile deleted in HEAD an=
d modified in crypto/master. Version crypto/master of drivers/staging/ccree=
/Makefile left in tree.
CONFLICT (modify/delete): drivers/staging/ccree/Kconfig deleted in HEAD and=
 modified in crypto/master. Version crypto/master of drivers/staging/ccree/=
Kconfig left in tree.
$ git rm -f drivers/staging/ccree/Kconfig drivers/staging/ccree/Makefile
Merging drm/drm-next (694f54f680f7 Merge branch 'drm-misc-next-fixes' of gi=
t://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (9f36f9c8eed8 Merge tag 'drm-amdkfd-next-2=
018-03-27' of git://people.freedesktop.org/~gabbayo/linux into drm-next)
Merging drm-tegra/drm/tegra/for-next (27e92f1f1600 drm/tegra: prime: Implem=
ent ->{begin,end}_cpu_access())
Merging drm-misc/for-linux-next (8cd1b5bd70cc ALSA: hda - Silence PM ops bu=
ild warning)
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
Merging sound/for-next (903d271a3f83 Merge tag 'asoc-v4.17' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus)
Merging sound-asoc/for-next (445bb423f6a3 Merge remote-tracking branch 'aso=
c/topic/zx_aud96p22' into asoc-next)
Merging modules/modules-next (3f553b308bb0 module: propagate error in modul=
es_open())
Merging input/next (adf313f41a0d Input: stmfts, s6sy761 - update my e-mail)
Merging block/for-next (667eea5d591b Merge branch 'for-4.17/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (14b58fe15e2f Merge branch 'dm-4.17' into fo=
r-next)
Applying: dm: merge fix for queue_flag_set_unlocked to blk_queue_flag_set A=
PI change
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
Merging regulator/for-next (36fd679f45a2 Merge remote-tracking branches 're=
gulator/topic/88pg86x', 'regulator/topic/dt', 'regulator/topic/formatting' =
and 'regulator/topic/gpio' into regulator-next)
Merging security/next-testing (3f3122c1b84c Fixup after manual conflict mer=
ge, for testing only.)
Merging apparmor/apparmor-next (588558eb6d0e apparmor: fix memory leak on b=
uffer on error exit path)
Merging integrity/next-integrity (ab60368ab6a4 ima: Fallback to the builtin=
 hash algorithm)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (6b6bc6205d98 selinux: wrap AVC state)
CONFLICT (content): Merge conflict in security/selinux/hooks.c
CONFLICT (content): Merge conflict in net/sctp/socket.c
CONFLICT (content): Merge conflict in include/linux/lsm_hooks.h
Merging tpmdd/next (2be8ffed093b tpm: fix intermittent failure with self te=
sts)
Merging watchdog/master (1991a55dc87e Merge branch 'v4.17-rc1')
Merging iommu/next (d4f96fd5c249 Merge branches 'x86/amd', 'x86/vt-d', 'arm=
/rockchip', 'arm/omap', 'arm/mediatek', 'arm/exynos', 'arm/renesas', 'arm/s=
mmu' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (da9147140fe3 MAINTAINERS: vfio/platform: Update sub-main=
tainer)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (ea841bafda3f audit: add refused symlink to audit_names)
Merging devicetree/for-next (827473268ee4 of: unittest: fix an error code i=
n of_unittest_apply_overlay())
Merging mailbox/mailbox-for-next (41c0e939d70d mailbox: Add support for Hi3=
660 mailbox)
Merging spi/for-next (0930437e8f9d Merge remote-tracking branches 'spi/topi=
c/sh-msiof', 'spi/topic/sprd' and 'spi/topic/tegra20-slink' into spi-next)
CONFLICT (content): Merge conflict in drivers/spi/Kconfig
Merging tip/auto-latest (25951761f5f7 Merge branch 'x86/timers')
CONFLICT (content): Merge conflict in drivers/irqchip/Makefile
CONFLICT (modify/delete): Documentation/trace/ftrace.txt deleted in HEAD an=
d modified in tip/auto-latest. Version tip/auto-latest of Documentation/tra=
ce/ftrace.txt left in tree.
$ git rm -f Documentation/trace/ftrace.txt
Applying: perf/core: merge fix for "drivers/bus: Split Arm CCI driver"
Applying: perf/core: another merge fix for "drivers/bus: Split Arm CCI driv=
er"
Applying: trace doc: merge fix for "tracing: Unify the "boot" and "mono" tr=
acing clocks"
Applying: sched/wait: merge fix up for wait_on_atomic() API removal
Merging clockevents/clockevents/next (0136c741ff40 clocksource/drivers/imx-=
tpm: Add different counter width support)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6fd052665274 EDAC, sb_edac: Remove variable leng=
th array usage)
Merging irqchip/irq/irqchip-next (aa08192a254d irqchip/gic: Take lock when =
updating irq type)
Merging ftrace/for-next (80765597bc58 tracing: Rewrite filter logic to be s=
impler and faster)
CONFLICT (modify/delete): Documentation/trace/ftrace.txt deleted in HEAD an=
d modified in ftrace/for-next. Version ftrace/for-next of Documentation/tra=
ce/ftrace.txt left in tree.
CONFLICT (content): Merge conflict in Documentation/trace/events.rst
$ git rm -f Documentation/trace/ftrace.txt
Applying: trace doc: merge fix for rst conversion of ftrace.txt
Merging rcu/rcu/next (338c46403f16 Merge branches 'fixes.2018.02.23a', 'src=
u.2018.02.20a' and 'torture.2018.02.20a' into HEAD)
Merging kvm/linux-next (27aa8962817a Merge tag 'kvm-ppc-next-4.17-1' of git=
://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
CONFLICT (content): Merge conflict in drivers/video/Kconfig
CONFLICT (content): Merge conflict in arch/x86/kvm/vmx.c
CONFLICT (content): Merge conflict in arch/x86/kernel/kvm.c
CONFLICT (content): Merge conflict in arch/arm64/kernel/cpufeature.c
Merging kvm-arm/next (dc6ed61d2f82 arm64: Add temporary ERRATA_MIDR_ALL_VER=
SIONS compatibility macro)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (31c8b0d0694a KVM: PPC: Book3S HV: Use __gfn_t=
o_pfn_memslot() in page fault handler)
Merging kvms390/next (ccc40c53c07b KVM: s390: provide counters for all inte=
rrupt injects/delivery)
Merging xen-tip/linux-next (c37a3c947758 xen/acpi: off by one in read_acpi_=
id())
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (1aa3798360db Merge branch 'for-4.17' into for-=
next)
Merging drivers-x86/for-next (7129707ec235 platform/x86: Fix dell driver in=
it order)
Merging chrome-platform/for-next (3b7cedb42420 platform/chrome: cros_ec_lpc=
: Add support for Google devices using custom coreboot firmware)
Merging hsi/for-next (e3d7fbab062b HSI: hsi_char: Delete an error message f=
or a failed memory allocation in hsc_probe())
Merging leds/for-next (92d7ec1d71e3 leds: Fix wrong dmi_match on PC Engines=
 APU LEDs)
Merging ipmi/for-next (c6185e285c5c ipmi/parisc: Add IPMI chassis poweroff =
for certain HP PA-RISC and IA-64 servers)
Merging driver-core/driver-core-next (1fe56e0cafd7 drivers: base: remove ch=
eck for callback in coredump_store())
Merging usb/usb-next (5267c5e09c25 Revert "USB: serial: ftdi_sio: add Id fo=
r Physik Instrumente E-870")
Merging usb-gadget/next (aaeab02ddcc8 usb/gadget: Add an EP dispose() callb=
ack for EP lifetime tracking)
Merging usb-serial/usb-next (79a0b33165d8 USB: serial: ftdi_sio: add Id for=
 Physik Instrumente E-870)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx:=
 Fix ULPI on imx53)
Merging phy-next/next (e7f4da4c44fe phy: tegra: xusb: Uncomment register wr=
ite)
Merging tty/tty-next (4f794097797f serial: expose buf_overrun count through=
 proc interface)
CONFLICT (content): Merge conflict in drivers/tty/hvc/Makefile
CONFLICT (content): Merge conflict in drivers/tty/hvc/Kconfig
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih418-b2199.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih410-b2260.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih410-b2120.dts
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stih407-b2120.dts
Merging char-misc/char-misc-next (86f690e8bfd1 Merge tag 'stm-intel_th-for-=
greg-20180329' of git://git.kernel.org/pub/scm/linux/kernel/git/ash/stm int=
o char-misc-next)
Merging extcon/extcon-next (eb7768e774d1 Merge branch 'ib-extcon-drm-dt-v4.=
17' into extcon-next)
Merging staging/staging-next (049b5e2ae30b staging: rtl8723bs: Remove yield=
 call, replace with cond_resched())
Merging mux/for-next (fa934c06c0f4 mux: add mux_control_get_optional() API)
Merging slave-dma/next (d853f94a2da8 Merge branch 'topic/dw_axi' into next)
Merging cgroup/for-next (d1897c9538ed cgroup: fix rule checking for threade=
d mode switching)
Merging scsi/for-next (bde133d1320f Merge branch 'fixes' into for-next)
CONFLICT (modify/delete): drivers/scsi/eata.c deleted in scsi/for-next and =
modified in HEAD. Version HEAD of drivers/scsi/eata.c left in tree.
$ git rm -f drivers/scsi/eata.c
Applying: scsi: qla2xxx: merge fix in qla_gs.c
Merging scsi-mkp/for-next (e5ad16982403 scsi: fnic: fix spelling mistake: "=
abord" -> "abort")
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (d64c228ea181 Merge branch 'for-4.17' into for-next)
Merging vhost/linux-next (54939f252f97 fw_cfg: write vmcoreinfo details)
Merging rpmsg/for-next (1e2832764f26 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
CONFLICT (content): Merge conflict in samples/Makefile
Merging gpio/for-next (348f3cde84ab gpio: Add Spreadtrum PMIC EIC driver su=
pport)
Merging pinctrl/for-next (4fc97ef94bbf pinctrl: uniphier: add UART hardware=
 flow control pin-mux settings)
Merging pinctrl-samsung/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging pwm/for-next (6873842235d6 pwm: rcar: Add suspend/resume support)
Merging userns/for-next (2236d4d39035 ipc/shm: Fix pid freeing.)
CONFLICT (content): Merge conflict in ipc/msg.c
Merging ktest/for-next (f7c6401ff84a ktest: Make sure wait_for_input does h=
onor the timeout)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (6aa69043d9f3 selftests/intel_pstate: Fix build rule=
 for x86)
Merging y2038/y2038 (ce380619fab9 Merge tag 'please-pull-ia64_misc' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/aegl/linux)
Merging livepatching/for-next (d13f5d84ca27 Merge branch 'for-4.16/signal-s=
ysfs-force-v2' into for-next)
Merging coresight/next (7e7408725e0d coresight: use put_device() instead of=
 kfree())
Merging rtc/rtc-next (7bbd523c73c9 rtc: ab8500: Drop AB8540 support)
Merging nvdimm/libnvdimm-for-next (f412942642c8 Merge branch 'for-4.17/dax'=
 into libnvdimm-for-next)
CONFLICT (content): Merge conflict in fs/xfs/xfs_inode.h
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in L=
DFLAGS too)
Merging at24/at24/for-next (84e10623c0b9 dt-bindings: at24: add Renesas R1E=
X24128)
Merging ntb/ntb-next (53c3677c56c7 ntb: intel: change references of skx to =
gen3)
Merging kspp/for-next/kspp (0adb32858b0b Linux 4.16)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging akpm-current/current (91e13c71f74f ipc/shm.c: shm_split(): remove u=
nneeded test for NULL shm_file_data.vm_ops)
CONFLICT (content): Merge conflict in mm/memory.c
CONFLICT (content): Merge conflict in fs/ocfs2/filecheck.c
CONFLICT (content): Merge conflict in drivers/block/zram/zram_drv.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: fs/dcache.c: add cond_resched() in shrink_dentry_list()
Applying: MAINTAINERS: update bouncing aacraid@adaptec.com addresses
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
Applying: linux/const.h: prefix include guard of uapi/linux/const.h with _U=
API
Applying: linux/const.h: move UL() macro to include/linux/const.h
Applying: linux/const.h: refactor _BITUL and _BITULL a bit
Applying: mm: memcg: remote memcg charging for kmem allocations
Applying: mm: memcg: remote memcg charging for kmem allocations fix
Applying: fs: fsnotify: account fsnotify metadata to kmemcg
Applying: fs-fsnotify-account-fsnotify-metadata-to-kmemcg-fix
Applying: radix tree: use GFP_ZONEMASK bits of gfp_t for flags
Applying: mac80211_hwsim: use DEFINE_IDA
Applying: arm64: turn flush_dcache_mmap_lock into a no-op
Applying: unicore32: turn flush_dcache_mmap_lock into a no-op
Applying: export __set_page_dirty
Applying: fscache: use appropriate radix tree accessors
Applying: xarray: add the xa_lock to the radix_tree_root
Applying: page cache: use xa_lock
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (d85e20b28568 sparc64: NG4 memset 32 bits overflow)

--Sig_/Le1sF=fB+MyprTB6b4LhrEV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrDQ2sACgkQAVBC80lX
0GwEXwf/WHIIGSCiZGIN9bP6T2oRDTu8ErV/B9DATqNJM5S2GkedRyeglQaXsRyn
R/Q7WGDexRL7viB8lr9DA43xUzRy0Uhqpd1lD+kO0CfqZEfWkUDPnAq5QWicRcwW
vvduu3VKxK2xMDLJA8+Qw3fxFPNiH/qCN5Wea9BO6G/o4L581IFlVLSp8+AawzKj
PiMqFBAK8P4mgW5Q/mFa8/JrX/T3feCgtBsUbkTXJ0L4FN4uo42ztgLLDf8DgHBX
ck6aA4BGwCk8R5gB2uHcb1Wg1m2yw/+gcH+ZSAu34Er2U+16vfQrJ+2TLuFgupus
cYXF2q6/BydgUA9MtcUmErfTJ7J/hg==
=JHOg
-----END PGP SIGNATURE-----

--Sig_/Le1sF=fB+MyprTB6b4LhrEV--
