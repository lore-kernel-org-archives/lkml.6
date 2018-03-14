Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753396AbeCNG15 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 02:27:57 -0400
Received: from ozlabs.org ([103.22.144.67]:49189 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeCNG1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 02:27:52 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 14 Mar 2018 17:27:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 14
Message-ID: <20180314172723.11e7f783@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7Q5RK/WiIku7Xhl.t8SfvNQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7Q5RK/WiIku7Xhl.t8SfvNQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180313:

New tree: syscalls

The syscalls tree gained 2 build failures for which I reverted 2 commits.

The metag tree gained a conflict against the syscalls tree.

The drm tree still had its build failure for which I applied a patch.

The sound-asoc tree lost its build failure.

The tip tree gained a conflict against the jc_docs tree.

The akpm-current tree gained a build failure for which I partially
reverted a commit.

Non-merge commits (relative to Linus' tree): 7056
 7172 files changed, 321119 insertions(+), 180952 deletions(-)

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

I am currently merging 260 trees (counting Linus' and 44 trees of bug
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
Merging origin/master (fc6eabbbf8ef Merge tag 'nfs-for-4.16-4' of git://git=
.linux-nfs.org/projects/trondmy/linux-nfs)
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
Merging powerpc-fixes/fixes (b0c41b8b6e43 powerpc/pseries: Fix vector5 in i=
bm architecture vector table)
Merging sparc/master (aebb48f5e465 sparc64: fix typo in CONFIG_CRYPTO_DES_S=
PARC64 =3D> CONFIG_CRYPTO_CAMELLIA_SPARC64)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (f89782c2d131 qed: Use after free in qed_rdma_free())
Merging bpf/master (b6b76dd62c56 error-injection: Fix to prohibit jump opti=
mization)
Merging ipsec/master (0dcd7876029b net: xfrm: use preempt-safe this_cpu_rea=
d() in ipcomp_alloc_tfms())
Merging netfilter/master (f89782c2d131 qed: Use after free in qed_rdma_free=
())
Merging ipvs/master (f7fb77fc1235 netfilter: nft_compat: check extension ho=
ok mask only if set)
Merging wireless-drivers/master (87de1201ddaa Merge branch 'erspan-fixes')
Merging mac80211/master (a78872363614 cfg80211: add missing dependency to C=
FG80211 suboptions)
Merging rdma-fixes/for-rc (28e9091e3119 RDMA/mlx5: Fix integer overflow whi=
le resizing CQ)
Merging sound-current/for-linus (db45dc9540ea Merge tag 'asoc-fix-v4.16-rc5=
' of https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for=
-linus)
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
Merging input-current/for-linus (1c4bfce1c604 Input: stmpe-keypad - remove =
VLA usage)
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
Merging kvm-fixes/master (45e3b4759d23 Merge tag 'kvm-s390-master-4.16-3' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux)
Merging kvms390-fixes/master (f07afa0462b7 KVM: s390: fix memory overwrites=
 when not using SCA entries)
Merging drm-intel-fixes/for-linux-next-fixes (f1430f145eef drm/i915: Kick t=
he rps worker when changing the boost frequency)
Merging drm-misc-fixes/for-linux-next-fixes (9ca8614980d4 drm/sun4i: Fix an=
 error handling path in 'sun4i_drv_bind()')
Merging syscalls/syscalls-next (9911e601915a fs: add ksys_open() wrapper; r=
emove in-kernel calls to sys_open())
Merging kbuild/for-next (f73f749d9fea Merge branch 'kconfig' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging efi-lock-down/efi-lock-down (89bcd5b02f12 lockdown: Print current->=
comm in restriction messages)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (af1da6868437 dma-debug: fix memory leak in de=
bug_dma_alloc_coherent)
Merging asm-generic/master (a351e9b9fc24 Linux 4.11)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging arm-perf/for-next/perf (44300aed5d28 perf: arm_spe: include linux/v=
malloc.h for vmap())
Merging arm-soc/for-next (74c5a02dedba arm-soc: document merges)
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (a1144b2b1ec4 ARM: dts: alpine: add valid cl=
ock-frequency values)
Merging amlogic/for-next (00ceeac6751f Merge branch 'v4.17/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (91b55cc53a17 Merge branch 'dt-for-4.17' into for-n=
ext)
Merging at91/at91-next (dc39260ac782 Merge branch 'at91-soc' of ssh://gitol=
ite.kernel.org/pub/scm/linux/kernel/git/abelloni/linux into at91-next)
Merging bcm2835/for-next (cf172af3be59 Merge branch anholt/bcm2835-defconfi=
g-next into for-next)
Merging imx-mxs/for-next (5ce066c49aa0 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (dacf37850167 Merge branch 'for_4.17/soc-drivers' int=
o next)
Merging mvebu/for-next (9c980293222d Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (e9f95735cef9 Merge tag 'v4.16-rc4' into for-next to =
avoid a merge conflict in next)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/logicpd-torpedo-som=
.dtsi
Merging reset/reset/next (de0ba80dc5ca reset: uniphier: add Pro4/Pro5/PXs2 =
audio systems reset control)
Merging qcom/for-next (a54b7e019869 Merge branch 'arm64-defconfig-for-4.17'=
 into all-for-4.17)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (10643852ee2f Merge branch 'arm64-dt-for-v4.17' into n=
ext)
Merging rockchip/for-next (54ec45606848 Merge branch 'v4.17-clk/next' into =
for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (0b36483c7f8d Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (fa99960487b5 Merge branches 'sunxi/core-for-4=
.17' and 'sunxi/dt-for-4.17' into sunxi/for-next)
Merging tegra/for-next (cea349de5ccc Merge branch for-4.17/clk into for-nex=
t)
Merging arm64/for-next/core (654c39c7982c Merge tag 'acpi/iort-for-v4.17' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux into aarch=
64/for-next/core)
Merging clk/clk-next (7229f20125e8 Merge branch 'clk-helpers' into clk-next)
Merging clk-samsung/for-next (948e06845456 clk: samsung: exynos5420: Add mo=
re entries to EPLL rate table)
Merging c6x/for-linux-next (9d440f7a2824 c6x: fix platforms/plldata.c get_c=
oreid build error)
Merging m68k/for-next (275036f3ff78 zorro: Set up z->dev.dma_mask for the D=
MA API)
Merging m68knommu/for-next (661e50bc8532 Linux 4.16-rc4)
Merging metag/for-next (8d06c3302635 i2c: img-scb: Drop METAG dependency)
CONFLICT (modify/delete): arch/metag/kernel/sys_metag.c deleted in metag/fo=
r-next and modified in HEAD. Version HEAD of arch/metag/kernel/sys_metag.c =
left in tree.
$ git rm -f arch/metag/kernel/sys_metag.c
Merging microblaze/next (9bf63916cb9d microblaze: Setup dependencies for AS=
M optimized lib functions)
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (b2ed33a89567 MIPS: pm-cps: Block system suspe=
nd when a JTAG probe is present)
Merging nds32/next (f8aad12d62a4 nds32: To use the generic dump_stack())
Merging nios2/for-next (e0691ebb33c1 nios2: defconfig: Cleanup from old Kco=
nfig options)
Merging openrisc/for-next (0fedb7653af7 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (aa32d33d7531 parisc/Kconfig: SMP kernels boot o=
n all machines)
Merging powerpc/next (4bd13772eeb2 powerpc/8xx: Increase number of slices t=
o 64)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (0c8efd610b58 Linux 4.16-rc5)
Merging s390/features (5628683cf77b s390/dasd: set timestamps unconditional=
ly)
Merging sparc-next/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_=
time')
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
Merging btrfs-kdave/for-next (476505288e7e Merge branch 'for-next-next-v4.1=
7-20180308' into for-next-20180308)
Merging ceph/master (1c7892495788 ceph: fix potential memory leak in init_c=
aches())
Merging cifs/for-next (1e00e72f6c7d SMB3.1.1 dialect is no longer experimen=
tal)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (4670269faba7 eCryptfs: constify attribute_group stru=
ctures.)
Merging ext3/for_next (a9cee1764b6f reiserfs: Remove VLA from fs/reiserfs/r=
eiserfs.h)
Merging ext4/dev (5dc397113d19 ext4: create ext4_kset dynamically)
Merging f2fs/dev (7144f0746f5f f2fs: support in-memory inode checksum when =
checking consistency)
Merging fuse/for-next (c6cdd51404b7 fuse: fix READDIRPLUS skipping an entry)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (fc6eabbbf8ef Merge tag 'nfs-for-4.16-4' of git://gi=
t.linux-nfs.org/projects/trondmy/linux-nfs)
Merging nfs-anna/linux-next (c54c14ba000d xprtrdma: Spread reply processing=
 over more CPUs)
CONFLICT (content): Merge conflict in net/sunrpc/xprtrdma/transport.c
CONFLICT (content): Merge conflict in net/sunrpc/xprt.c
Merging nfsd/nfsd-next (219cd595cc46 lockd: make nlm_ntf_refcnt and nlm_ntf=
_wq static)
Merging orangefs/for-next (74e938c22705 orangefs: reverse sense of is-inode=
-stale test in d_revalidate)
Merging overlayfs/overlayfs-next (36cd95dfa1ed ovl: update Kconfig texts)
Merging ubifs/linux-next (7f29ae9f977b ubi: block: Fix locking for idr_allo=
c/idr_remove)
Merging xfs/for-next (0ab32086d0be xfs: account only rmapbt-used blocks aga=
inst rmapbt perag res)
Merging file-locks/locks-next (1deab8ce2c91 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/sparc)
Merging vfs/for-next (de8894756258 Merge branch 'work.dcache' into for-next)
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging iversion/iversion-next (581e400ff935 Merge tag 'modules-for-v4.16' =
of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux)
Merging printk/for-next (06e206db06e9 Merge branch 'for-4.17' into for-next)
Merging pci/next (eda9c9dd19d1 Merge remote-tracking branch 'lorenzo/pci/xg=
ene' into next)
Merging pstore/for-next/pstore (cb3bee0369bc pstore: Use crypto compress AP=
I)
Merging hid/for-next (b576182794e8 Merge branch 'for-4.16/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (371b9546b966 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging dmi/master (eb693e35e850 firmware: dmi_scan: add DMI_OEM_STRING sup=
port to dmi_matches)
Merging hwmon-staging/hwmon-next (81820059a428 hwmon: (nct6775) Add support=
 for NCT6796D)
Merging jc_docs/docs-next (6234c7bd8c14 docs: ftrace: fix a few formatting =
issues)
Merging v4l-dvb/master (3f127ce11353 media: em28xx-cards: fix em28xx_duplic=
ate_dev())
Merging v4l-dvb-next/master (a1dfb4c48cc1 media: v4l2-compat-ioctl32.c: ref=
actor compat ioctl32 logic)
Merging fbdev/fbdev-for-next (2c81ee0a28c0 video: fbdev: via: remove VLA us=
age)
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
Merging net-next/master (be9fc0971a5c net: fix sysctl_fb_tunnels_only_for_i=
nit_net link error)
CONFLICT (content): Merge conflict in drivers/net/phy/phy.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlxsw/s=
pectrum.h
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlxsw/s=
pectrum.c
Applying: mlxsw: merge fix for move of SPAN code
Merging bpf-next/master (6d8cb045cde6 bpf: comment why dots in filenames un=
der BPF virtual FS are not allowed)
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
Merging bluetooth/master (4dd3f238ebac Bluetooth: btmrvl: Delete an unneces=
sary variable initialisation in btmrvl_sdio_card_to_host())
Merging mac80211-next/master (2e75bb2f8b89 net: Convert hwsim_net_ops)
Merging rdma/for-next (29cf1351d450 RDMA/nldev: provide detailed PD informa=
tion)
Merging gfs2/for-next (d39d18e0ef73 gfs2: Improve gfs2_block_map comment)
Merging mtd/master (f23def803861 mtd: nand: MTD_NAND_MARVELL should depend =
on HAS_DMA)
Merging l2-mtd/mtd/next (0dbe4ea78d69 mtd: get rid of the mtd_add_device_pa=
rtitions())
Merging nand/nand/next (3383fb35c9b8 Merge tag 'nand/pxa3xx-removal' of git=
://git.infradead.org/linux-mtd into nand/next)
CONFLICT (content): Merge conflict in drivers/mtd/nand/Kconfig
Applying: mtd: nand: fix up for raw Kconfig move
Merging spi-nor/spi-nor/next (a49a95096a7b mtd: spi-nor: Remove unneeded dr=
iver.bus assignment)
Merging crypto/master (0ee991be4cdd crypto: ccp - Fill the result buffer on=
ly on digest, finup, and final ops)
Merging drm/drm-next (128ccceaba86 Merge branch 'drm-next-4.17' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/sun4i/sun4i_tcon.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_breadcrumb=
s.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/hwmgr/s=
mu7_hwmgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/inc/hw=
_sequencer.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Applying: drm/amd/pp: add another CONFIG_ACPI check
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (62801bf61567 drm/i915/psr: Comment to cla=
rify SRD_DEBUG is called PSR_MASK SKL+)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_request.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem.c
Merging drm-tegra/drm/tegra/for-next (b8f3f500e09c drm/tegra: fb: Implement=
 ->fb_mmap() callback)
Merging drm-misc/for-linux-next (9c936b12f150 drm/meson: Add support for DM=
T modes on HDMI)
Merging drm-msm/msm-next (b666c0f68f33 drm/msm: fix building without debugf=
s)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (92fe715dae97 drm: mali-dp: Turn off C=
RTC vblank when removing module.)
CONFLICT (content): Merge conflict in drivers/gpu/drm/arm/malidp_planes.c
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
Merging sound-asoc/for-next (6ad7defdae01 Merge remote-tracking branches 'a=
soc/topic/wm_adsp' and 'asoc/topic/zx_aud96p22' into asoc-next)
Merging modules/modules-next (3f553b308bb0 module: propagate error in modul=
es_open())
Merging input/next (62f0f079b96d Input: add RAVE SP Powerbutton driver)
Merging block/for-next (d924fd4f65a9 Merge branch 'for-4.17/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (e8f74a0f0011 dm mpath: eliminate need to us=
e scsi_device_from_queue)
Merging mmc/next (611d059f1a13 Merge branch 'fixes' into next)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (3de59bb9d551 md/raid1: fix NULL pointer dereference)
Merging mfd/for-mfd-next (1d7fbb6e03a1 mfd: viperboard: Delete an error mes=
sage for a failed memory allocation in vprbrd_probe())
Merging backlight/for-backlight-next (ba11349b2a57 dt-bindings: backlight: =
Add binding for RAVE SP backlight driver)
Merging battery/for-next (93619fdec96f power: reset: make function sc27xx_p=
oweroff_shutdown static)
Merging regulator/for-next (2e7e01ad29a2 Merge remote-tracking branches 're=
gulator/topic/88pg86x', 'regulator/topic/dt' and 'regulator/topic/gpio' int=
o regulator-next)
Merging security/next-testing (39859821366f Merge branch 'next-general' int=
o next-testing)
Merging integrity/next-integrity (c4c9d3889dc0 ima: drop vla in ima_audit_m=
easurement())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (68741a8adab9 selinux: Fix ltp test connect-syscall fa=
ilure)
CONFLICT (content): Merge conflict in net/sctp/socket.c
Merging tpmdd/next (69c6025bbd15 tpm_crb: use __le64 annotated variable for=
 response buffer address)
Merging watchdog/master (2e8ebed6ede0 Merge branch 'v4.16-fixes')
Merging iommu/next (18b3c16e25fb Merge branches 'x86/amd', 'x86/vt-d', 'arm=
/mediatek', 'arm/exynos' and 'core' into next)
Merging dwmw2-iommu/master (910170442944 iommu/vt-d: Fix PASID table alloca=
tion)
Merging vfio/next (46ed90f157f4 vfio: mdev: make a couple of functions and =
structure vfio_mdev_driver static)
Merging trivial/for-next (1972d6c0c86d MAINTAINERS: relinquish kconfig)
Merging audit/next (45b578fe4c3c audit: link denied should not directly gen=
erate PATH record)
Merging devicetree/for-next (54587be4962e of: unittest: local return value =
variable related cleanups)
Merging mailbox/mailbox-for-next (0ae7d327a64b dt-bindings: mailbox: qcom: =
Document the APCS clock binding)
Merging spi/for-next (e6f5c1f2d4c6 Merge remote-tracking branches 'spi/topi=
c/pxa2xx' and 'spi/topic/tegra20-slink' into spi-next)
Merging tip/auto-latest (557ca5ab59b5 Merge branch 'efi/urgent')
CONFLICT (content): Merge conflict in drivers/bus/arm-cci.c
CONFLICT (modify/delete): Documentation/trace/ftrace.txt deleted in HEAD an=
d modified in tip/auto-latest. Version tip/auto-latest of Documentation/tra=
ce/ftrace.txt left in tree.
$ git rm -f Documentation/trace/ftrace.txt
Applying: perf/core: merge fix for "drivers/bus: Split Arm CCI driver"
Applying: trace doc: merge fix for "tracing: Unify the "boot" and "mono" tr=
acing clocks"
Merging clockevents/clockevents/next (322fd24f5e67 clocksource/drivers/stm3=
2: Start the timer's counter sooner)
CONFLICT (content): Merge conflict in drivers/clocksource/timer-stm32.c
CONFLICT (content): Merge conflict in drivers/clocksource/timer-of.c
CONFLICT (content): Merge conflict in drivers/clocksource/Kconfig
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (28dd6726e7bb EDAC, layerscape: Allow building fo=
r LS1021A)
Merging irqchip/irqchip/for-next (c1ae3cfa0e89 Linux 4.11-rc1)
Merging ftrace/for-next (841a915d20c7 vsprintf: Do not have bprintf derefer=
ence pointers)
Merging rcu/rcu/next (08c5ee913265 softirq: Eliminate unused cond_resched_s=
oftirq() macro)
Merging kvm/linux-next (0c7f650e106c KVM: nVMX: Enforce NMI controls on vme=
ntry of L2 guests)
Merging kvm-arm/next (250be9d61cf8 KVM: arm/arm64: No need to zero CNTVOFF =
in kvm_timer_vcpu_put() for VHE)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (7928b2cbe55b Linux 4.16-rc1)
Merging kvms390/next (dc48ecb6e871 KVM: s390: provide counters for all inte=
rrupt injects/delivery)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
Merging xen-tip/linux-next (351b2bccede1 xen: xenbus: use put_device() inst=
ead of kfree())
Merging percpu/for-next (accd4f36a7d1 percpu: add a schedule point in pcpu_=
balance_workfn())
Applying: percpu: include sched.h for cond_resched()
Merging workqueues/for-next (6417250d3f89 workqueue: remove unused cancel_w=
ork())
Merging drivers-x86/for-next (cc69c88fbeb9 platform/x86: dell-smbios: Resol=
ve dependency error on DCDBAS)
Merging chrome-platform/for-next (0c8efd610b58 Linux 4.16-rc5)
Merging hsi/for-next (b6dc80dbe6cd HSI: cmt_speech: use timespec64 instead =
of timespec)
Merging leds/for-next (d1ed7c558612 leds: Extends disk trigger for reads an=
d writes)
Merging ipmi/for-next (bc48fa1b9d3b ipmi:pci: Blacklist a Realtek "IPMI" de=
vice)
Merging driver-core/driver-core-next (0c8efd610b58 Linux 4.16-rc5)
Merging usb/usb-next (95713fb8aa03 Revert "usb: core: Add "quirks" paramete=
r for usbcore")
Merging usb-gadget/next (498f0478aba4 usb: dwc3: Prevent indefinite sleep i=
n _dwc3_set_mode during suspend/resume)
Merging usb-serial/usb-next (858c121d028f USB: serial: option: use mass-sto=
rage class define)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx:=
 Fix ULPI on imx53)
Merging phy-next/next (d7119224bfe6 phy: allwinner: sun4i-usb: poll vbus ch=
anges on A23/A33 when driving VBUS)
Merging tty/tty-next (6aed2a885041 serial: imx: document functions that are=
 called with port.lock taken)
Merging char-misc/char-misc-next (aeef9c097406 lkdtm: Add missing SPDX-Lice=
nse-Identifier line)
Merging extcon/extcon-next (e1eade1eb5f1 Merge branch 'ib-extcon-drm-dt-v4.=
17' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into ex=
tcon-next)
Merging staging/staging-next (fdff86229f9f staging: fsl-dpaa2/eth: allow th=
e driver to compile multi-arch)
CONFLICT (modify/delete): drivers/staging/lustre/lnet/libcfs/linux/linux-pr=
im.c deleted in staging/staging-next and modified in HEAD. Version HEAD of =
drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c left in tree.
CONFLICT (modify/delete): drivers/staging/lustre/lnet/libcfs/linux/linux-cu=
rproc.c deleted in staging/staging-next and modified in HEAD. Version HEAD =
of drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c left in tree.
$ git rm -f drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c driver=
s/staging/lustre/lnet/libcfs/linux/linux-prim.c
Merging mux/for-next (fa934c06c0f4 mux: add mux_control_get_optional() API)
Merging slave-dma/next (56c931385f55 Merge branch 'fixes' into next)
Merging cgroup/for-next (d1897c9538ed cgroup: fix rule checking for threade=
d mode switching)
Merging scsi/for-next (3571574bd585 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (92eb506262a2 scsi: device_handler: remove VLAs)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (7ce45484c951 Merge branch 'for-4.17' into for-next)
Merging vhost/linux-next (54939f252f97 fw_cfg: write vmcoreinfo details)
Merging rpmsg/for-next (ec6e69036956 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (8b3eba33639c Merge branch 'devel' into for-next)
Merging pinctrl/for-next (dfb1c1da3da7 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging pwm/for-next (bccaa3f917c9 pwm: meson: Add clock source configurati=
on for Meson-AXG)
Merging userns/for-next (9eba1cd4b565 24 Jan 2018 Merge of my siginfo and u=
serns trees for testing in linux-next)
Merging ktest/for-next (f7c6401ff84a ktest: Make sure wait_for_input does h=
onor the timeout)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (78972f51ccf8 selftests: futex Makefile add top leve=
l TAP header echo to RUN_TESTS)
Merging y2038/y2038 (69973b830859 Linux 4.9)
Merging livepatching/for-next (d13f5d84ca27 Merge branch 'for-4.16/signal-s=
ysfs-force-v2' into for-next)
Merging coresight/next (c24ae3b69146 coresight: etm4x: Fix bit shifting)
Merging rtc/rtc-next (7a96880cb5b4 rtc: pcf85063: fix clearing bits in pcf8=
5063_start_clock)
Merging nvdimm/libnvdimm-for-next (949b93250a56 memremap: fix softlockup re=
ports at teardown)
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in L=
DFLAGS too)
Merging at24/at24/for-next (570b7e20f24e dt-bindings: at24: add Renesas R1E=
X24128)
Merging ntb/ntb-next (53c3677c56c7 ntb: intel: change references of skx to =
gen3)
Merging kspp/for-next/kspp (2d00fcb32f71 Merge branch 'kspp/gcc-plugin/infr=
astructure' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Applying: Revert "mm: use do_futex() instead of sys_futex() in mm_release()"
Applying: Revert "mm: add ksys_fadvise64_64() helper; remove in-kernel call=
 to sys_fadvise64_64()"
Merging akpm-current/current (eab9417593d4 tools/testing/selftests/sysctl/s=
ysctl.sh: add range clamping test)
Applying: pertially revert "hugetlbfs-check-for-pgoff-value-overflow-v3-fix"
$ git checkout -b akpm remotes/origin/akpm/master
Applying: ipc/mqueue: add missing error code in init_mqueue_fs()
Applying: drivers/infiniband/core/verbs.c: fix build with gcc-4.4.4
Applying: drivers/infiniband/ulp/srpt/ib_srpt.c: fix build with gcc-4.4.4
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
Merging akpm/master (9fb58d908131 sparc64: NG4 memset 32 bits overflow)

--Sig_/7Q5RK/WiIku7Xhl.t8SfvNQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqowMsACgkQAVBC80lX
0GziuggAmM+gVJ3xB2nVOnCbBRUxe9jW8KJNFpHkUps6xH3wBE+E4jvhJyFAOxTi
gqunb0mDMnki85m1WEK/laOuG4IefWO+940klSLjz+lD7xxg6lmbXtVoopj5StMT
Y+VLzPacf7yIYDftmoTZrsJc5JPgKOf08VzFIUZemSHZQvvrVtzU/Eli310HrN5g
1QFkyMfu+xMknjnsJt8c9d06YOyehvUQv8E2zwzpFrgX9K8jgpFBscytR5+LWixj
9dqFT09/yXWSs427di5rs0ZLJQ0613AbU4Yjpl8g6PvAvI6dBlecyK+CvK9vh+Vp
ZV/J0s2PG5QEo2McluJMYfZE+BFACg==
=ea0i
-----END PGP SIGNATURE-----

--Sig_/7Q5RK/WiIku7Xhl.t8SfvNQ--
