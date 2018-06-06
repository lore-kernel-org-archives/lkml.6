Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GaaeVLzr"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B90DF601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeFFMHv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 08:07:51 -0400
Received: from ozlabs.org ([203.11.71.1]:49041 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbeFFMHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 08:07:48 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Wed, 6 Jun 2018 22:07:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 6
Message-ID: <20180606220744.1fc67051@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2fdp.4=VL_PAy7290.Z70Ar"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2fdp.4=VL_PAy7290.Z70Ar
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Note: please do *not* add any v4.19 material to your linux-next included
branches until after v4.18-rc1 has been released.

Changes since 20180605:

The net-next tree lost its build failure but gained a conflict against
Linus' tree.

The staging tree gained conflicts against Linus' tree.

The y2038 tree gained conflicts against the ceph and staging trees.

Non-merge commits (relative to Linus' tree): 9959
 9660 files changed, 455178 insertions(+), 582265 deletions(-)

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
Merging origin/master (5037be168f0e Merge branch 'for-linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/s390/linux)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (b04e217704b7 Linux 4.17-rc7)
Merging arc-current/for-curr (661e50bc8532 Linux 4.16-rc4)
Merging arm-current/fixes (92d44a42af81 ARM: fix kill( ,SIGFPE) breakage)
Merging arm64-fixes/for-next/fixes (82034c23fcbc arm64: Make sure permissio=
n updates happen for pmd/pud)
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (faf37c44a105 powerpc/64s: Clear PCR on boot)
Merging sparc/master (1c1ff29da6c8 sparc: fix compat siginfo ABI regression)
CONFLICT (content): Merge conflict in arch/sparc/kernel/traps_64.c
CONFLICT (content): Merge conflict in arch/sparc/kernel/traps_32.c
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (885892fb378d mlx4_core: restore optimal ICM memory allo=
cation)
Merging bpf/master (885892fb378d mlx4_core: restore optimal ICM memory allo=
cation)
Merging ipsec/master (38369f54d97d xfrm Fix potential error pointer derefer=
ence in xfrm_bundle_create.)
Merging netfilter/master (6fcc02e3c2bd ipvs: fix check on xmit to non-local=
 addresses)
Merging ipvs/master (312564269535 net: netsec: reduce DMA mask to 40 bits)
Merging wireless-drivers/master (ab1068d6866e iwlwifi: pcie: compare with n=
umber of IRQs requested for, not number of CPUs)
Merging mac80211/master (885892fb378d mlx4_core: restore optimal ICM memory=
 allocation)
Merging rdma-fixes/for-rc (a840c93ca758 IB/core: Fix error code for invalid=
 GID entry)
Merging sound-current/for-linus (d4d5a1cd298e Merge tag 'asoc-v4.18' of git=
://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus)
Merging sound-asoc-fixes/for-linus (2858e2cfc2ef Merge branch 'asoc-4.17' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (97fe106a8027 Merge branch 'regmap-4.17' int=
o regmap-linus)
Merging regulator-fixes/for-linus (f32fa2c67985 Merge branch 'regulator-4.1=
7' into regulator-linus)
Merging spi-fixes/for-linus (5d3257b8ea48 Merge branch 'spi-4.17' into spi-=
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
Merging staging.current/staging-linus (29dcea88779c Linux 4.17)
Merging char-misc.current/char-misc-linus (29dcea88779c Linux 4.17)
Merging input-current/for-linus (e6e7e9cd8eed Input: elan_i2c - add ELAN061=
2 (Lenovo v330 14IKB) ACPI ID)
Merging crypto-current/master (b268b3506d99 crypto: chtls - free beyond end=
 rspq_skb_cache)
Merging ide/master (47b82e88180c ide: don't enable/disable interrupts in fo=
rce threaded-IRQ mode)
Merging vfio-fixes/for-linus (89c29def6b01 Revert "vfio/type1: Improve memo=
ry pinning process for raw PFN mapping")
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
Merging v4l-dvb-fixes/fixes (e88f5e9ebd54 media: uvcvideo: Prevent setting =
unavailable flags)
Merging reset-fixes/reset/fixes (e6914365fd28 reset: uniphier: fix USB cloc=
k line for LD20)
Merging mips-fixes/mips-fixes (d8a9a51afaa9 MIPS: pb44: Fix i2c-gpio GPIO d=
escriptor table)
Merging omap-fixes/fixes (41bd6adf3c5d Revert "ARM: dts: logicpd-som-lv: Fi=
x pinmux controller references")
Merging kvm-fixes/master (696ca779a928 KVM: x86: fix #UD address of failed =
Hyper-V hypercalls)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (771c577c23ba Linux 4.17-rc6)
Merging nvdimm-fixes/libnvdimm-fixes (75bc37fefc44 Linux 4.17-rc4)
Merging btrfs-fixes/next-fixes (e99d6ba5c506 Merge branch 'misc-4.18' into =
next-fixes)
Merging vfs-fixes/fixes (b1b94fcbd399 Revert "fs: fold open_check_o_direct =
into do_dentry_open")
Merging dma-mapping-fixes/for-linus (05e13bb57e6f swiotlb: silent unwanted =
warning "buffer is full")
Merging drivers-x86-fixes/fixes (32ffd6e8d1f6 platform/x86: asus-wmi: Fix N=
ULL pointer dereference)
Merging samsung-krzk-fixes/fixes (60cc43fc8884 Linux 4.17-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (60cc43fc8884 Linux 4.17-rc1)
Merging devicetree-fixes/dt/linus (f130307054a5 dt-bindings: panel: lvds: F=
ix path to display timing bindings)
Merging scsi-fixes/fixes (c9ddf73476ff scsi: scsi_transport_srp: Fix shost =
to rport translation)
Merging drm-intel-fixes/for-linux-next-fixes (65b3bdc807ac drm/i915/query: =
nospec expects no more than an unsigned long)
Merging mmc-fixes/fixes (3de06d5a1f05 mmc: sdhci-iproc: add SDHCI_QUIRK2_HO=
ST_OFF_CARD_ON for cygnus)
Merging rtc-fixes/rtc-fixes (60cc43fc8884 Linux 4.17-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (889ad63d41ee drm/qxl: Call qxl=
_bo_unref outside atomic context)
Merging kbuild/for-next (e216bbe870c0 Merge branch 'kconfig' into for-next)
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
CONFLICT (content): Merge conflict in arch/arm/mm/fault.c
Merging arm-perf/for-next/perf (73acc0315cd7 ARM: mcpm, perf/arm-cci: expor=
t mcpm_is_available)
Merging arm-soc/for-next (c7953e19db50 ARM: Document merges)
CONFLICT (content): Merge conflict in arch/arm/mach-exynos/Kconfig
CONFLICT (content): Merge conflict in arch/arm/include/asm/cputype.h
CONFLICT (content): Merge conflict in arch/arm/boot/dts/stm32mp157c.dtsi
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (a9f041bd080e Merge branch 'v4.18/defconfig' into =
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
Merging sunxi/sunxi/for-next (e97360054391 Merge branch 'sunxi/dt64-for-4.1=
8' into sunxi/for-next)
Merging tegra/for-next (6de9ae597a79 Merge branch for-4.18/clk into for-nex=
t)
Merging arm64/for-next/core (2520e627dbee ACPI / PPTT: fix build when CONFI=
G_ACPI_PPTT is not enabled)
Merging clk/clk-next (55913c2d3330 Merge branch 'clk-imx6ul' into clk-next)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (85fa2cc51104 c6x: pass endianness info to spars=
e)
Merging m68k/for-next (b12c8a70643f m68k: Set default dma mask for platform=
 devices)
Merging m68knommu/for-next (082f55c45984 m68k: fix ColdFire PCI config read=
s and writes)
Merging microblaze/next (a7a9e2f0410d microblaze: dts: replace 'linux,stdou=
t-path' with 'stdout-path')
Merging mips/mips-next (d1157b107434 MIPS: ptrace: Make FPU context layout =
comments match reality)
CONFLICT (content): Merge conflict in arch/mips/boot/dts/xilfpga/Makefile
Merging nds32/next (e5dd7e2f8a59 nds32: define __NDS32_E[BL]__ for sparse)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (d56f3af9e801 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (8d40c754fbac parisc: Drop struct sigaction from=
 not exported header file)
Merging powerpc/next (0a4ec6aa035a cpuidle: powernv: Fix promotion from sno=
oze if next state disabled)
CONFLICT (content): Merge conflict in arch/powerpc/kernel/module_64.c
Merging powerpc-pkey/topic/pkey (d86a4ba02fc6 powerpc/pkeys: Drop private V=
M_PKEY definitions)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (29dcea88779c Linux 4.17)
Merging s390/features (89a0c0ec0d2e s390/zcrypt: Fix CCA and EP11 CPRB proc=
essing failure memory leak.)
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
Merging btrfs-kdave/for-next (eb4147bcb586 Merge branch 'for-next-current-v=
4.17-20180605' into for-next-20180605)
Merging ceph/master (23edca864951 rbd: flush rbd_dev->watch_dwork after wat=
ch is unregistered)
Merging cifs/for-next (ee25c6dd7b05 cifs: For SMB2 security informaion quer=
y, check for minimum sized security descriptor instead of sizeof FileAllInf=
ormation class)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (20b67d6401f1 Merge fsnotify cleanups from Amir into =
for_next.)
Merging ext4/dev (4f2f76f75143 ext4: fix fencepost error in check for inode=
 count overflow during resize)
Merging f2fs/dev (dfa742803fbb f2fs: fix to clear FI_VOLATILE_FILE correctl=
y)
CONFLICT (content): Merge conflict in fs/f2fs/namei.c
Merging fuse/for-next (543b8f8662fe fuse: don't keep dead fuse_conn at fuse=
_fill_super().)
Merging jfs/jfs-next (92d34134193e jfs: Fix inconsistency between memory al=
location and ea_buf->max_size)
Merging nfs/linux-next (977294c7199e NFSv4: Fix a compiler warning when CON=
FIG_NFS_V4_1 is undefined)
Merging nfs-anna/linux-next (ffbfa2ce88f1 sunrpc: Fix latency trace point c=
rashes)
Merging nfsd/nfsd-next (28771950c592 svcrdma: Fix incorrect return value/ty=
pe in svc_rdma_post_recvs)
Merging orangefs/for-next (b1116bc03c00 orangefs: use sparse annotations fo=
r holding locks across function calls.)
Merging overlayfs/overlayfs-next (c03e30790cad ovl: Enable metadata only fe=
ature)
CONFLICT (content): Merge conflict in fs/read_write.c
CONFLICT (content): Merge conflict in fs/btrfs/ioctl.c
Merging ubifs/linux-next (b5094b7f135b ubi: Reject MLC NAND)
Merging xfs/for-next (89c2e71123ba xfs: use xfs_trans_getsb in xfs_sync_sb_=
buf)
CONFLICT (content): Merge conflict in fs/gfs2/bmap.c
Merging file-locks/locks-next (716a685fdb89 Merge branch 'x86-hyperv-for-li=
nus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging vfs/for-next (5f181c9ca108 Merge branch 'work.compat' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (8bafa2a44ff3 Merge branch 'for-4.18-vsprintf-pcr-r=
emoval' into for-4.18)
CONFLICT (content): Merge conflict in lib/vsprintf.c
Merging pci/next (e649a6be641e Merge branch 'pci/trivial')
CONFLICT (content): Merge conflict in arch/microblaze/include/asm/pci.h
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (f1b6ae6701a7 Merge branch 'for-4.18/rmi' into for-nex=
t)
Merging i2c/i2c/for-next (1840b5ac656f Merge branch 'i2c/for-4.18' into i2c=
/for-next)
Merging dmi/master (5cb06cfce4a8 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (c9bdf291542e hwmon: (asus_atk0110) Make u=
se of device managed memory)
Merging jc_docs/docs-next (a49d9c0ae46e Documentation: document hung_task_p=
anic kernel parameter)
Merging v4l-dvb/master (f2809d20b925 media: omap2: fix compile-testing with=
 FB_OMAP2=3Dm)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (dbeef4fe697b video: fbdev: pxafb: match_strin=
g() conversion fixup)
Merging pm/linux-next (afb856775ab6 Merge branch 'pm-tools' into linux-next)
Merging cpupower/cpupower (f9652d5cae04 cpupower : Fix header name to read =
idle state name)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (8a352fd8787c OPP: Allow same OPP table to be us=
ed for multiple genpd)
Merging thermal/next (d04d6c6d7a8d Merge branch 'thermal-soc' into next)
Merging thermal-soc/next (6d7c70d1cd65 thermal: qcom: tsens: Allow number o=
f sensors to come from DT)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (c1191a19feca RDMA/mlx5: Update SPDX tags to show pro=
per license)
Merging net-next/master (75d4e704fa8d netdev-FAQ: clarify DaveM's position =
for stable backports)
CONFLICT (content): Merge conflict in net/ipv4/ipconfig.c
CONFLICT (content): Merge conflict in arch/x86/net/bpf_jit_comp.c
CONFLICT (content): Merge conflict in arch/s390/net/Makefile
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/qcom/apq8096-db82=
0c.dtsi
CONFLICT (content): Merge conflict in MAINTAINERS
Applying: xsk: update for "net: convert datagram_poll users tp ->poll_mask"
Merging bpf-next/master (75d4e704fa8d netdev-FAQ: clarify DaveM's position =
for stable backports)
Merging ipsec-next/master (f03329627b46 Merge branch 'hns3-next')
Merging netfilter-next/master (f624434a0ec9 Merge tag 'wireless-drivers-nex=
t-for-davem-2018-05-31' of git://git.kernel.org/pub/scm/linux/kernel/git/kv=
alo/wireless-drivers-next)
Merging nfc-next/master (c99f996b2ba4 NFC: st95hf: drop illegal kfree_skb())
Merging ipvs-next/master (e523452ac0e0 netfilter: nf_tables: remove unused =
variables)
Merging wireless-drivers-next/master (76606886c9f4 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (f7225172f25a net/ipv6: prevent use after free in =
ip6_route_mpath_notify)
Merging mac80211-next/master (7d840a606515 Merge git://git.kernel.org/pub/s=
cm/linux/kernel/git/davem/net)
Merging gfs2/for-next (6d1c2cf22475 MAINTAINERS: Add Andreas Gruenbacher as=
 a maintainer for gfs2)
Merging mtd/mtd/next (c64d4419a17c mtd: cfi_cmdset_0002: Change erase one b=
lock to enable XIP once)
Merging nand/nand/next (f567c71f4f91 mtd: nand: Pass mode information to na=
nd_page_io_req)
Merging spi-nor/spi-nor/next (771ff17e82fa mtd: spi-nor: Add support for EN=
25QH32)
Merging crypto/master (b268b3506d99 crypto: chtls - free beyond end rspq_sk=
b_cache)
Merging drm/drm-next (568cf2e6aa0c Merge tag 'drm-amdkfd-next-2018-05-28' o=
f git://people.freedesktop.org/~gabbayo/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_engine_cs.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm.c
Applying: drm/xen-front: merge fix for "drivers: remove force dma flag from=
 buses"
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (bc61ec46e83f drm/i915: Remove stale asser=
ts from i915_gem_find_active_request())
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (069035c5db34 drm: Fix possible race condit=
ions while unplugging DRM device)
Merging drm-msm/msm-next (74d3a3a70775 drm/msm: Fix NULL deref on bind/prob=
e deferral)
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
Merging regmap/for-next (66431563e0d9 Merge branch 'regmap-4.18' into regma=
p-next)
Merging sound/for-next (d4d5a1cd298e Merge tag 'asoc-v4.18' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/broonie/sound into for-linus)
Merging sound-asoc/for-next (5544717d416d Merge branch 'asoc-4.18' into aso=
c-next)
Merging modules/modules-next (c554b8986801 module: Allow to always show the=
 status of modsign)
Merging input/next (24d28e4f1271 Input: synaptics-rmi4 - convert irq distri=
bution to irq_domain)
Merging block/for-next (28313cee1d4f Merge branch 'for-4.18/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (1be8d9c3da01 dm: add writecache target)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (ef5332c10d4f mmc: renesas_sdhi: really fix WP logic regre=
ssions)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (5a409b4f56d5 MD: fix lock contention for flush bios)
CONFLICT (content): Merge conflict in drivers/md/md.c
Merging mfd/for-mfd-next (df7c3bf24f54 mfd: cros_ec_dev: Don't advertise ju=
nk features on failure)
Merging backlight/for-backlight-next (cd4270258cbe backlight: as3711_bl: fi=
x device-tree node leaks)
Merging battery/for-next (c42812da1395 MAINTAINERS: add entry for LEGO MIND=
STORMS EV3)
CONFLICT (content): Merge conflict in drivers/usb/core/hcd.c
Merging regulator/for-next (6d8ca1492f0c Merge branch 'regulator-4.18' into=
 regulator-next)
Merging security/next-testing (d19289133b1d Merge branch 'next-integrity' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into =
next-testing)
Merging apparmor/apparmor-next (430837708c21 apparmor: Fix memory leak of r=
ule on error exit path)
Merging integrity/next-integrity (b5c90a7526fe EVM: unlock on error path in=
 evm_read_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (d141136f523a audit: normalize MAC_POLICY_LOAD record)
Merging tpmdd/next (3ab2011ea368 tpm: fix race condition in tpm_common_writ=
e())
Merging watchdog/master (1c85ffc86a2b dt-bindings: watchdog: renesas-wdt: A=
dd R-Car Gen2 support)
Merging iommu/next (1f568357117c Merge branches 'arm/io-pgtable', 'arm/qcom=
', 'arm/tegra', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (a823b3a1b88b vfio: platform: Fix using devices in PM Dom=
ains)
CONFLICT (content): Merge conflict in drivers/vfio/vfio_iommu_type1.c
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (5b71388663c0 audit: Fix wrong task in comparison of ses=
sion ID)
CONFLICT (content): Merge conflict in security/selinux/selinuxfs.c
Merging devicetree/for-next (522811e944ed of: platform: stop accessing inva=
lid dev in of_platform_device_destroy)
Merging mailbox/mailbox-for-next (dfbc9c5841fc mailbox: Remove depends on H=
AS_DMA in case of platform dependency)
Merging spi/for-next (39202ebf0939 Merge branch 'spi-4.18' into spi-next)
Merging tip/auto-latest (32dab4a92d1f Merge branch 'x86/vdso')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (eaa3a1d46cfd EDAC, ghes: Make platform-based whi=
telisting x86-only)
Merging irqchip/irq/irqchip-next (6a88c221acba ARM: dts: stm32: Add exti su=
pport to stm32mp157 pinctrl)
Merging ftrace/for-next (a9235b544a0a ring-buffer: Fix typo in comment)
Merging rcu/rcu/next (3b46bd8383ac rcu: Add diagnostics for rcutorture writ=
er stall warning)
Merging kvm/linux-next (d7a8bea3638d Merge tag 'kvm-s390-next-4.18-1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
CONFLICT (content): Merge conflict in arch/x86/kvm/hyperv.c
CONFLICT (content): Merge conflict in arch/arm64/kvm/hyp/switch.c
CONFLICT (content): Merge conflict in arch/arm64/include/asm/processor.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/kvm_host.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpufeature.h
Merging kvm-arm/next (e25028c8ded0 KVM: arm/arm64: Bump VGIC_V3_MAX_CPUS to=
 512)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (deeb879de955 KVM: PPC: Book3S PR: Enable kvmp=
pc_get/set_one_reg_pr() for HTM registers)
Merging kvms390/next (2c8180e885c1 KVM: s390: vsie: simplify < 8k address c=
hecks)
Merging xen-tip/linux-next (7f47e1c52d0c xen/PVH: Make GDT selectors PVH-sp=
ecific)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (66448bc274ca workqueue: move function definiti=
ons within CONFIG_SMP block)
Merging drivers-x86/for-next (64b824649b77 platform/x86: dell-wmi: Ignore n=
ew rfkill and fn-lock events)
Merging chrome-platform/for-next (5cd7e690bdc1 platform/chrome: chromeos_tb=
mc - fix SPDX identifier)
Merging hsi/for-next (70d52ba9e57e hsi: clients: Change return type to vm_f=
ault_t)
Merging leds/for-next (6d71021ab3b0 leds: class: ensure workqueue is initia=
lized before setting brightness)
Merging ipmi/for-next (048f7c3e352e ipmi: Properly release srcu locks on er=
ror conditions)
Merging driver-core/driver-core-next (af6c5d5e01ad Merge branch 'for-4.18' =
of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq)
Merging usb/usb-next (af6c5d5e01ad Merge branch 'for-4.18' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/tj/wq)
Merging usb-gadget/next (47265c067c0d usb: dwc2: gadget: Fix coverity issue)
Merging usb-serial/usb-next (7041d9c3f01b USB: serial: pl2303: add support =
for tx xon/xoff flow control)
Merging usb-chipidea-next/ci-for-usb-next (8bcf4c0bd7fb usb: chipidea: prop=
erly handle host or gadget initialization failure)
Merging phy-next/next (c1eb8f83845b phy: mediatek: add XS-PHY driver)
Merging tty/tty-next (af6c5d5e01ad Merge branch 'for-4.18' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/tj/wq)
Merging char-misc/char-misc-next (af6c5d5e01ad Merge branch 'for-4.18' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tj/wq)
Merging extcon/extcon-next (60cc43fc8884 Linux 4.17-rc1)
Merging staging/staging-next (7a2e838d28cf staging: ipx: delete it from the=
 tree)
CONFLICT (modify/delete): drivers/staging/ncpfs/dir.c deleted in staging/st=
aging-next and modified in HEAD. Version HEAD of drivers/staging/ncpfs/dir.=
c left in tree.
CONFLICT (modify/delete): drivers/staging/media/atomisp/TODO deleted in HEA=
D and modified in staging/staging-next. Version staging/staging-next of dri=
vers/staging/media/atomisp/TODO left in tree.
CONFLICT (modify/delete): drivers/staging/ipx/ipx_proc.c deleted in staging=
/staging-next and modified in HEAD. Version HEAD of drivers/staging/ipx/ipx=
_proc.c left in tree.
CONFLICT (modify/delete): drivers/staging/ipx/af_ipx.c deleted in staging/s=
taging-next and modified in HEAD. Version HEAD of drivers/staging/ipx/af_ip=
x.c left in tree.
$ git rm -f drivers/staging/media/atomisp/TODO
$ git rm -f drivers/staging/ipx/af_ipx.c drivers/staging/ipx/ipx_proc.c dri=
vers/staging/ncpfs/dir.c
Merging mux/for-next (6a3d4baac84a mux: add mux_control_get_optional() API)
Merging slave-dma/next (c79c2212f7c9 Merge branch 'for-linus' into next)
Merging cgroup/for-next (d8742e229021 cgroup: css_set_lock should nest insi=
de tasklist_lock)
Merging scsi/for-next (7ce1b53b1b5d Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/qedf/qedf.h
Merging scsi-mkp/for-next (1b5c2cb19668 scsi: lpfc: update driver version t=
o 12.0.0.4)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (ed058253618e Merge branch 'for-4.17-fixes' into fo=
r-next)
Merging vhost/linux-next (cfcde40e8ce3 ACPI: disable extra P_LVLx access on=
 KVM)
Merging rpmsg/for-next (1601c6923d66 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (84bf021ecee4 gpio: pxa: Include the right header)
Merging pinctrl/for-next (86c5dd6860a6 pinctrl: cherryview: limit Strago DM=
I workarounds to version 1.0)
Merging pinctrl-samsung/for-next (7c24e71c8a64 pinctrl: samsung: Fix suspen=
d/resume for Exynos5433 GPF1..5 banks)
Merging pwm/for-next (414c52b7899a pwm: stm32: Fix build warning with CONFI=
G_DMA_ENGINE disabled)
Merging userns/for-next (4b245b90065b Merge of my siginfo-next and userns-n=
ext trees for testing in linux-next)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (fa32156921da selftests: lib: fix prime_numbers modu=
le search and skip logic)
Merging y2038/y2038 (5648f0a54e7d Merge branch 'linux-next' of git://git.li=
nux-nfs.org/projects/trondmy/nfs-2.6 into vfs_timespec64)
CONFLICT (content): Merge conflict in fs/ceph/addr.c
CONFLICT (modify/delete): drivers/staging/lustre/lustre/obdclass/obdo.c del=
eted in HEAD and modified in y2038/y2038. Version y2038/y2038 of drivers/st=
aging/lustre/lustre/obdclass/obdo.c left in tree.
CONFLICT (modify/delete): drivers/staging/lustre/lustre/mdc/mdc_reint.c del=
eted in HEAD and modified in y2038/y2038. Version y2038/y2038 of drivers/st=
aging/lustre/lustre/mdc/mdc_reint.c left in tree.
CONFLICT (modify/delete): drivers/staging/lustre/lustre/lmv/lmv_obd.c delet=
ed in HEAD and modified in y2038/y2038. Version y2038/y2038 of drivers/stag=
ing/lustre/lustre/lmv/lmv_obd.c left in tree.
CONFLICT (modify/delete): drivers/staging/lustre/lustre/llite/namei.c delet=
ed in HEAD and modified in y2038/y2038. Version y2038/y2038 of drivers/stag=
ing/lustre/lustre/llite/namei.c left in tree.
CONFLICT (modify/delete): drivers/staging/lustre/lustre/llite/llite_lib.c d=
eleted in HEAD and modified in y2038/y2038. Version y2038/y2038 of drivers/=
staging/lustre/lustre/llite/llite_lib.c left in tree.
$ git rm -f drivers/staging/lustre/lustre/llite/llite_lib.c drivers/staging=
/lustre/lustre/llite/namei.c drivers/staging/lustre/lustre/lmv/lmv_obd.c dr=
ivers/staging/lustre/lustre/mdc/mdc_reint.c drivers/staging/lustre/lustre/o=
bdclass/obdo.c
Merging livepatching/for-next (d7ab8e67aa52 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (4f73570d1aa3 coresight: include vmalloc.h for vmap/=
vunmap)
CONFLICT (content): Merge conflict in drivers/hwtracing/coresight/coresight=
-tmc-etr.c
Merging rtc/rtc-next (7f85d9f8c862 rtc: ftrtc010: let the core handle range)
Merging nvdimm/libnvdimm-for-next (82f97b0b27bd Merge branch 'for-4.18/dax-=
memory-failure' into libnvdimm-for-next)
CONFLICT (content): Merge conflict in mm/hmm.c
CONFLICT (content): Merge conflict in drivers/dax/super.c
Merging at24/at24/for-next (73b0d922cd5b eeprom: at24: provide a separate r=
outine for creating dummy i2c clients)
Merging ntb/ntb-next (5e083738f65d ntb: ntb_transport: Replace GFP_ATOMIC w=
ith GFP_KERNEL in ntb_transport_create_queue)
Merging kspp/for-next/kspp (45888b40d2a6 rslib: Allocate decoder buffers to=
 avoid VLAs)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (5997aab0a11e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging akpm-current/current (06a5af82ba13 ipc: use new return type vm_faul=
t_t)
CONFLICT (content): Merge conflict in fs/proc/base.c
CONFLICT (content): Merge conflict in fs/dax.c
CONFLICT (content): Merge conflict in arch/sh/Kconfig
$ git checkout -b akpm remotes/origin/akpm/master
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
Merging akpm/master (6084abacf3d9 sparc64: NG4 memset 32 bits overflow)

--Sig_/2fdp.4=VL_PAy7290.Z70Ar
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsXzpAACgkQAVBC80lX
0Gweggf/SsTN2fGSlP9yA/FDRth1uniXJQaRDy/buE1fjvQC2hJeaZZf86hdPaOn
fy8mNiysOhFS0P038KgpNj18QSaZFyfECM4hR8OaBVQEGFv+uLYQVwTKAm9letJA
iQhcF78AUgUo1oLhzGM6mWB4nIpnKQV6qqyrcg9AAXsZH0FEHRRF3jajHPzPL1AN
hxZGN+JVPe7fJkHlgfZzZVAIosfOMKMCieuqyPX7s89/v9dQlqWWKjinKbVqlQ7m
KwF2oyIWPDMyfdzeh/Neh+jRGsMBOqigiBvgceCfrgOewLoGSJbgsLf476E/olYw
fWbsAJ4m9T1gBQ/JcT6dUrl3XFnKHA==
=CaoU
-----END PGP SIGNATURE-----

--Sig_/2fdp.4=VL_PAy7290.Z70Ar--
