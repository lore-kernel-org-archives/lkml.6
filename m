Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751600AbeFAK4b (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:56:31 -0400
Received: from ozlabs.org ([203.11.71.1]:48373 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750795AbeFAK4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:56:25 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 1 Jun 2018 20:56:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 1
Message-ID: <20180601205621.11f1b9dd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uih5zR+s82McUVvVW0Zv7YU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uih5zR+s82McUVvVW0Zv7YU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180531:

Removed tree: mips (by request)
Renamed tree: mips-james to mips

The cifs tree gained a build failure so I used the version from
next-20180531.

The vfs tree gained conflicts against Linus' and the ext3 trees.

The net-next tree still had its build failure for which I reverted
3 commits.

The device-mapper tree lost its build failure.

The kvm-arm tree gained conflicts againct the arm64 tree.

The driver-core tree gained a conflict against the dma-mapping tree.

The nvdimm tree gained a conflict against the xfs tree.

Non-merge commits (relative to Linus' tree): 10359
 10266 files changed, 450438 insertions(+), 383341 deletions(-)

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
Merging origin/master (0512e0134582 Merge tag 'xfs-4.17-fixes-3' of git://g=
it.kernel.org/pub/scm/fs/xfs/xfs-linux)
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
Merging net/master (8005b09d99fa net: ethernet: davinci_emac: fix error han=
dling in probe())
Merging bpf/master (c93552c443eb bpf: properly enforce index mask to preven=
t out-of-bounds speculation)
Merging ipsec/master (38369f54d97d xfrm Fix potential error pointer derefer=
ence in xfrm_bundle_create.)
Merging netfilter/master (312564269535 net: netsec: reduce DMA mask to 40 b=
its)
Merging ipvs/master (2f99aa31cd7a netfilter: nf_tables: skip synchronize_rc=
u if transaction log is empty)
Merging wireless-drivers/master (ab1068d6866e iwlwifi: pcie: compare with n=
umber of IRQs requested for, not number of CPUs)
Merging mac80211/master (312564269535 net: netsec: reduce DMA mask to 40 bi=
ts)
Merging rdma-fixes/for-rc (a840c93ca758 IB/core: Fix error code for invalid=
 GID entry)
Merging sound-current/for-linus (009f8c90f571 ALSA: hda - Fix runtime PM)
Merging sound-asoc-fixes/for-linus (32c3a8b8c3bd Merge branch 'asoc-4.17' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (4b1b7043a286 Merge branch 'regmap-4.17' int=
o regmap-linus)
Merging regulator-fixes/for-linus (1ead77b61050 Merge branch 'regulator-4.1=
7' into regulator-linus)
Merging spi-fixes/for-linus (ea783ec61508 Merge branch 'spi-4.17' into spi-=
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
Merging mips-fixes/mips-fixes (c7e814628df6 MIPS: ptrace: Fix PTRACE_PEEKUS=
R requests for 64-bit FGRs)
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
Merging drm-misc-fixes/for-linux-next-fixes (c32048d9e93a drm/bridge/synops=
ys: dw-hdmi: fix dw_hdmi_setup_rx_sense)
Merging kbuild/for-next (57282f7da50c Merge branch 'kconfig' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (2550bbfd4952 dma-direct: don't crash on devic=
e without dma_mask)
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (0ad6ae990467 Merge branches 'fixes' and 'misc'; commi=
t 'spectre^{/^ARM: spectre-v1: fix syscall entry}' into for-next)
Merging arm-perf/for-next/perf (73acc0315cd7 ARM: mcpm, perf/arm-cci: expor=
t mcpm_is_available)
Merging arm-soc/for-next (933d3cf3d416 ARM: Document merges)
CONFLICT (content): Merge conflict in arch/arm/mach-exynos/Kconfig
CONFLICT (content): Merge conflict in arch/arm/include/asm/cputype.h
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
Merging sunxi/sunxi/for-next (e97360054391 Merge branch 'sunxi/dt64-for-4.1=
8' into sunxi/for-next)
Merging tegra/for-next (6de9ae597a79 Merge branch for-4.18/clk into for-nex=
t)
Merging arm64/for-next/core (cb877710e58f Merge branch 'for-next/perf' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
Merging clk/clk-next (5f016be1c548 Merge remote-tracking branch 'clk/clk-da=
vinci' into clk-next)
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
Merging nds32/next (3c6b01addf6e nds32: Fix compiler warning, Wstringop-ove=
rflow, in vdso.c)
CONFLICT (content): Merge conflict in arch/nds32/Kconfig
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (d56f3af9e801 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (8d40c754fbac parisc: Drop struct sigaction from=
 not exported header file)
Merging powerpc/next (d647b210ac73 powerpc: Add a missing include header)
CONFLICT (content): Merge conflict in arch/powerpc/kernel/module_64.c
CONFLICT (content): Merge conflict in arch/powerpc/include/asm/ftrace.h
Merging powerpc-pkey/topic/pkey (d86a4ba02fc6 powerpc/pkeys: Drop private V=
M_PKEY definitions)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (b04e217704b7 Linux 4.17-rc7)
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
Merging btrfs-kdave/for-next (f146e3341b73 Merge branch 'for-next-current-v=
4.17-20180531' into for-next-20180531)
Merging ceph/master (fc218544fbc8 ceph: fix iov_iter issues in ceph_direct_=
read_write())
Merging cifs/for-next (cc9797849fc4 smb3: on reconnect set PreviousSessionI=
d field)
$ git reset --hard HEAD^
Merging next-20180531 version of cifs
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (20b67d6401f1 Merge fsnotify cleanups from Amir into =
for_next.)
Merging ext4/dev (4f2f76f75143 ext4: fix fencepost error in check for inode=
 count overflow during resize)
Merging f2fs/dev (cba608493d3d f2fs: turn down IO priority of discard from =
background)
CONFLICT (content): Merge conflict in fs/f2fs/namei.c
Merging fuse/for-next (543b8f8662fe fuse: don't keep dead fuse_conn at fuse=
_fill_super().)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (a3cf9bca2ace NFSv4: Don't add a new lock on an inte=
rrupted wait for LOCK)
Merging nfs-anna/linux-next (ffbfa2ce88f1 sunrpc: Fix latency trace point c=
rashes)
Merging nfsd/nfsd-next (28771950c592 svcrdma: Fix incorrect return value/ty=
pe in svc_rdma_post_recvs)
Merging orangefs/for-next (8d720dc81d4d orangefs: formatting cleanups)
Merging overlayfs/overlayfs-next (b0ee6e9a4c53 ovl: Enable metadata only fe=
ature)
CONFLICT (content): Merge conflict in fs/btrfs/ioctl.c
Merging ubifs/linux-next (b5094b7f135b ubi: Reject MLC NAND)
Merging xfs/for-next (80660f20252d dax: change bdev_dax_supported() to supp=
ort boolean returns)
Merging file-locks/locks-next (7a107c0f55a3 fasync: Fix deadlock between ta=
sk-context and interrupt-context kill_fasync())
Merging vfs/for-next (d888ee6a7e8c Merge branch 'afs-proc' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in fs/read_write.c
CONFLICT (content): Merge conflict in fs/afs/fsclient.c
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (b5e940c8fb5a Merge branch 'for-4.18-vsprintf-clean=
up' into for-4.18)
CONFLICT (content): Merge conflict in lib/vsprintf.c
Merging pci/next (6bf16b354ddc Merge branch 'pci/kconfig')
CONFLICT (content): Merge conflict in arch/microblaze/include/asm/pci.h
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (f1b6ae6701a7 Merge branch 'for-4.18/rmi' into for-nex=
t)
Merging i2c/i2c/for-next (1840b5ac656f Merge branch 'i2c/for-4.18' into i2c=
/for-next)
Merging dmi/master (5cb06cfce4a8 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (853d5e4b9a48 hwmon: (gpio-fan) Fix "#cool=
ing-cells" property name in bindings)
Merging jc_docs/docs-next (a49d9c0ae46e Documentation: document hung_task_p=
anic kernel parameter)
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
Merging pm/linux-next (c7533d0fd82f Merge branch 'pm-cpuidle' into linux-ne=
xt)
Merging cpupower/cpupower (f9652d5cae04 cpupower : Fix header name to read =
idle state name)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (8a352fd8787c OPP: Allow same OPP table to be us=
ed for multiple genpd)
Merging thermal/next (e76a4386b2f5 thermal: Use DEVICE_ATTR_{RO|RW|WO}() va=
riants)
Merging thermal-soc/next (9efc58dfa14a thermal: mediatek: use of_device_get=
_match_data())
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (f3ca0ab114e0 Merge branch 'mini_cqe' into git://git.=
kernel.org/pub/scm/linux/kernel/git/rdma/rdma for-next)
Merging net-next/master (7bb8c9969d91 net: dsa: mv88e6xxx: Be explicit abou=
t DT or pdata)
CONFLICT (content): Merge conflict in net/ipv4/ipconfig.c
CONFLICT (content): Merge conflict in arch/s390/net/Makefile
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/qcom/apq8096-db82=
0c.dtsi
Applying: xsk: update for "net: convert datagram_poll users tp ->poll_mask"
Applying: net: bpfilter: mark as BROKEN for now
Merging bpf-next/master (bcece5dc40b9 bpf: Change bpf_fib_lookup to return =
-EAFNOSUPPORT for unsupported address families)
Merging ipsec-next/master (f03329627b46 Merge branch 'hns3-next')
Merging netfilter-next/master (e523452ac0e0 netfilter: nf_tables: remove un=
used variables)
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (90278871d4b0 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/pablo/nf-next)
Merging wireless-drivers-next/master (76606886c9f4 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (1cd2fabf4bdc Bluetooth: btusb: Add additional dev=
ice ID for RTL8822BE)
Merging mac80211-next/master (f03329627b46 Merge branch 'hns3-next')
Merging gfs2/for-next (9a38662ba4e2 gfs2: Remove sdp->sd_jheightsize)
Merging mtd/mtd/next (c64d4419a17c mtd: cfi_cmdset_0002: Change erase one b=
lock to enable XIP once)
Merging nand/nand/next (782d1967d047 mtd: rawnand: Do not check FAIL bit wh=
en executing a SET_FEATURES op)
Merging spi-nor/spi-nor/next (771ff17e82fa mtd: spi-nor: Add support for EN=
25QH32)
Merging crypto/master (b268b3506d99 crypto: chtls - free beyond end rspq_sk=
b_cache)
Merging drm/drm-next (568cf2e6aa0c Merge tag 'drm-amdkfd-next-2018-05-28' o=
f git://people.freedesktop.org/~gabbayo/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_engine_cs.c
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
Merging drm-msm/msm-next (5ee37246c579 drm/msm: Fix NULL deref on bind/prob=
e deferral)
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
Merging sound/for-next (9ee92f5355f8 ALSA: oxygen: use match_string() helpe=
r)
Merging sound-asoc/for-next (a9ac77cd2b0e Merge branch 'asoc-4.18' into aso=
c-next)
Merging modules/modules-next (c554b8986801 module: Allow to always show the=
 status of modsign)
Merging input/next (22a844b85368 Input: ti_am335x_tsc - prevent system susp=
end when TSC is in use)
Merging block/for-next (6cd76cb05d5e Merge branch 'for-4.18/block' into for=
-next)
CONFLICT (content): Merge conflict in drivers/block/drbd/drbd_main.c
CONFLICT (content): Merge conflict in drivers/block/DAC960.c
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (ae4c15db96d2 dm: add writecache target)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (77252da7cd2c mmc: mvsdio: Enable MMC_CAP_ERASE)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (5a409b4f56d5 MD: fix lock contention for flush bios)
CONFLICT (content): Merge conflict in drivers/md/md.c
Merging mfd/for-mfd-next (d28b62520830 mfd: intel-lpss: Program REMAP regis=
ter in PIO mode)
Merging backlight/for-backlight-next (cd4270258cbe backlight: as3711_bl: fi=
x device-tree node leaks)
Merging battery/for-next (1f140ff46708 Merge tag 'tags/tcpm-pps-4.18' into =
psy-next)
CONFLICT (content): Merge conflict in drivers/usb/core/hcd.c
Merging regulator/for-next (7a5421d2f6c1 Merge branch 'regulator-4.18' into=
 regulator-next)
CONFLICT (content): Merge conflict in arch/arm/mach-omap1/board-ams-delta.c
Merging security/next-testing (d19289133b1d Merge branch 'next-integrity' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into =
next-testing)
Merging apparmor/apparmor-next (430837708c21 apparmor: Fix memory leak of r=
ule on error exit path)
Merging integrity/next-integrity (a41d80acfa27 EVM: prevent array underflow=
 in evm_write_xattrs())
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
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (5b71388663c0 audit: Fix wrong task in comparison of ses=
sion ID)
CONFLICT (content): Merge conflict in security/selinux/selinuxfs.c
Merging devicetree/for-next (399d9e069577 dt-bindings: Add vendor prefix fo=
r Logic PD)
Merging mailbox/mailbox-for-next (dfbc9c5841fc mailbox: Remove depends on H=
AS_DMA in case of platform dependency)
Merging spi/for-next (4f5b9b33a5cd Merge branch 'spi-4.18' into spi-next)
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
CONFLICT (content): Merge conflict in arch/arm64/kvm/hyp/switch.c
CONFLICT (content): Merge conflict in arch/arm64/include/asm/kvm_host.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpufeature.h
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (deeb879de955 KVM: PPC: Book3S PR: Enable kvmp=
pc_get/set_one_reg_pr() for HTM registers)
Merging kvms390/next (2c8180e885c1 KVM: s390: vsie: simplify < 8k address c=
hecks)
Merging xen-tip/linux-next (c78ad1667036 xen/PVH: Make GDT selectors PVH-sp=
ecific)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (197f6accacda workqueue: Make sure struct worke=
r is accessible for wq_worker_comm())
Merging drivers-x86/for-next (cc5cceff288f platform/x86: asus-wireless: Fix=
 format specifier)
Merging chrome-platform/for-next (79a3d60300fc platform/chrome: Use to_cros=
_ec_dev more broadly)
Merging hsi/for-next (70d52ba9e57e hsi: clients: Change return type to vm_f=
ault_t)
Merging leds/for-next (6d71021ab3b0 leds: class: ensure workqueue is initia=
lized before setting brightness)
Merging ipmi/for-next (048f7c3e352e ipmi: Properly release srcu locks on er=
ror conditions)
Merging driver-core/driver-core-next (8c97a46af04b driver core: hold dev's =
parent lock when needed)
CONFLICT (content): Merge conflict in include/linux/device.h
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
Merging mux/for-next (6a3d4baac84a mux: add mux_control_get_optional() API)
Merging slave-dma/next (cece9f043feb Merge branch 'topic/sprd' into next)
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
Merging rpmsg/for-next (454575aba6e4 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (84bf021ecee4 gpio: pxa: Include the right header)
Merging pinctrl/for-next (6c1b317ff0d8 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (7c24e71c8a64 pinctrl: samsung: Fix suspen=
d/resume for Exynos5433 GPF1..5 banks)
Merging pwm/for-next (692099cdcf27 pwm: simplify getting .drvdata)
Merging userns/for-next (4b245b90065b Merge of my siginfo-next and userns-n=
ext trees for testing in linux-next)
CONFLICT (content): Merge conflict in arch/arm/mm/fault.c
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (fa32156921da selftests: lib: fix prime_numbers modu=
le search and skip logic)
Merging y2038/y2038 (5dc0b1529d21 y2038: ipc: Redirect ipc(SEMTIMEDOP, ...)=
 to compat_ksys_semtimedop)
Merging livepatching/for-next (d7ab8e67aa52 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (66ede2c0b89d coresight: tmc: Add configuration supp=
ort for trace buffer size)
CONFLICT (content): Merge conflict in drivers/hwtracing/coresight/coresight=
-tmc-etr.c
Merging rtc/rtc-next (696fa1d043ec rtc: test: remove irq sysfs file)
Merging nvdimm/libnvdimm-for-next (1dcdf20fcf9c Merge branch 'for-4.18/mcsa=
fe' into libnvdimm-for-next)
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
Merging akpm/master (00105f98ec0f sparc64: NG4 memset 32 bits overflow)

--Sig_/uih5zR+s82McUVvVW0Zv7YU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsRJlUACgkQAVBC80lX
0Gz/VAf/YeTjp/vEJ2RWw1AyBX9UmOm6TLtE3U7qaqFao7SKojSfUa/6iZAoC3LS
4ByQNkz/q3IPTX9X4E4E2hFwWHMx9RZvpuTRiZ04ghL29PUGOaXsmRO4zk5+TfcL
ZLDTpGnfjSs/waXhgCTclf7FaiuveDFFGRIZLeoqITZOFRNRkzP7VoX4qCp7maul
GxV8j3e7SubV9M6Cv5OuxGR6XDhEDxSF+HVnDpQzvUSCJU76sMvfOYN/XpPhGguX
LQovUJFb6zDJJSC/+ARbL0uED345ZnzK9BzsRwk/CM9IrvmXXmSxzzIAPiGb91bA
RYQt7GUebQIrS/5tdG+N9kA/gRp0HA==
=EJrb
-----END PGP SIGNATURE-----

--Sig_/uih5zR+s82McUVvVW0Zv7YU--
