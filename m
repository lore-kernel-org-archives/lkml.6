Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbeDTGNA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 02:13:00 -0400
Received: from ozlabs.org ([203.11.71.1]:53101 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbeDTGM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 02:12:56 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Fri, 20 Apr 2018 16:11:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Apr 20
Message-ID: <20180420161141.7ea33351@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dO00S=eHeQ/iGeL9GRDH9HE"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dO00S=eHeQ/iGeL9GRDH9HE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180419:

I have added a patch to the arm-current tree to fix build problems
discovered overnight.

Non-merge commits (relative to Linus' tree): 1278
 1324 files changed, 47025 insertions(+), 20625 deletions(-)

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

I am currently merging 258 trees (counting Linus' and 44 trees of bug
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
Merging origin/master (87ef12027b9b Merge tag 'ceph-for-4.17-rc2' of git://=
github.com/ceph/ceph-client)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (28913ee8191a netfilter: nf_nat_snmp_basic: ad=
d correct dependency to Makefile)
Merging arc-current/for-curr (661e50bc8532 Linux 4.16-rc4)
Merging arm-current/fixes (fe680ca02c1e ARM: replace unnecessary perl with =
sed and the shell $(( )) operator)
Applying: arm: check for A as well as B type sybols when calculating BSS si=
ze
Merging arm64-fixes/for-next/fixes (b2d71b3cda19 arm64: signal: don't force=
 known signals to SIGKILL)
Merging m68k-current/for-linus (ecd685580c8f m68k/mac: Remove bogus "FIXME"=
 comment)
Merging powerpc-fixes/fixes (56376c5864f8 powerpc/kvm: Fix lockups when run=
ning KVM guests on Power8)
Merging sparc/master (17dec0a94915 Merge branch 'userns-linus' of git://git=
.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (1255fcb2a655 net/smc: fix shutdown in state SMC_LISTEN)
Merging bpf/master (0a0a7e00a250 tools/bpf: fix test_sock and test_sock_add=
r.sh failure)
Merging ipsec/master (b48c05ab5d32 xfrm: Fix warning in xfrm6_tunnel_net_ex=
it.)
Merging netfilter/master (d71efb599ad4 netfilter: nf_tables: fix out-of-bou=
nds in nft_chain_commit_update)
Merging ipvs/master (765cca91b895 netfilter: conntrack: include kmemleak.h =
for kmemleak_not_leak())
Merging wireless-drivers/master (77e30e10ee28 iwlwifi: mvm: query regdb for=
 wmm rule if needed)
Merging mac80211/master (83826469e36b cfg80211: fix possible memory leak in=
 regdb_query_country())
Merging rdma-fixes/for-rc (60cc43fc8884 Linux 4.17-rc1)
Merging sound-current/for-linus (8a56ef4f3ffb ALSA: rawmidi: Fix missing in=
put substream checks in compat ioctls)
Merging pci-current/for-linus (60cc43fc8884 Linux 4.17-rc1)
Merging driver-core.current/driver-core-linus (ed4564babeee drivers: change=
 struct device_driver::coredump() return type to void)
Merging tty.current/tty-linus (60cc43fc8884 Linux 4.17-rc1)
Merging usb.current/usb-linus (60cc43fc8884 Linux 4.17-rc1)
Merging usb-gadget-fixes/fixes (c6ba5084ce0d usb: gadget: udc: renesas_usb3=
: add binging for r8a77965)
Merging usb-serial-fixes/usb-linus (470b5d6f0cf4 USB: serial: ftdi_sio: use=
 jtag quirk for Arrow USB Blaster)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (60cc43fc8884 Linux 4.17-rc1)
Merging staging.current/staging-linus (edf5c17d866e staging: irda: remove r=
emaining remants of irda code removal)
Merging char-misc.current/char-misc-linus (60cc43fc8884 Linux 4.17-rc1)
Merging input-current/for-linus (664b0bae0b87 Merge branch 'next' into for-=
linus)
Merging crypto-current/master (f444ec106407 crypto: ccree - remove unused e=
nums)
Merging ide/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_time')
Merging vfio-fixes/for-linus (834814e80268 Revert: "vfio-pci: Mask INTx if =
a device is not capabable of enabling it")
Merging kselftest-fixes/fixes (8bf24e831961 selftests/filesystems: Don't ru=
n dnotify_test by default)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711=
_bl: fix device-tree node leaks)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (107b7d9fa94c mfd: rtsx: Release IRQ during=
 shutdown)
Merging v4l-dvb-fixes/fixes (a95845ba184b media: v4l2-core: fix size of dev=
node_nums[] bitarray)
Merging reset-fixes/reset/fixes (f450f28e70a2 reset: socfpga: fix for 64-bi=
t compilation)
Merging mips-fixes/mips-fixes (b3d7e55c3f88 MIPS: uaccess: Add micromips cl=
obbers to bzero invocation)
Merging kvm-fixes/master (c18bb396d3d2 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/davem/net)
Merging kvms390-fixes/master (f07afa0462b7 KVM: s390: fix memory overwrites=
 when not using SCA entries)
Merging drm-intel-fixes/for-linux-next-fixes (60cc43fc8884 Linux 4.17-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (7eb2c4dd54ff drm/i915: Fix LSP=
CON TMDS output buffer enabling from low-power state)
Merging syscalls/syscalls-next (c9a211951c7c bpf: whitelist all syscalls fo=
r error injection)
Merging kbuild/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (9e7f06c8beee swiotlb: fix unexpected swiotlb_=
alloc_coherent failures)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (f592819553ca Merge branches 'fixes' and 'sa1100-for-n=
ext' into for-next)
Merging arm-perf/for-next/perf (44300aed5d28 perf: arm_spe: include linux/v=
malloc.h for vmap())
Merging arm-soc/for-next (cb799267bb65 MAINTAINERS: Update ASPEED entry wit=
h details)
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (b9b2e4f8f5fd ARM64: dts: meson-axg: add tdm pins)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (20d3f36b0fea Merge tag 'at91-ab-4.17-dt2' into at91=
-next)
Merging bcm2835/for-next (cf172af3be59 Merge branch anholt/bcm2835-defconfi=
g-next into for-next)
Merging imx-mxs/for-next (9fa2e1a1fd60 Merge branch 'imx/defconfig' into fo=
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
Merging renesas/next (86fbd9bc1ab2 Merge branches 'arm64-dt-for-v4.18' and =
'dt-for-v4.18' into next)
Merging rockchip/for-next (aaa7709c6703 Merge branch 'v4.18-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (08944e878b7e Merge branch 'next/drivers' int=
o for-next)
Merging sunxi/sunxi/for-next (d0715cb8113f Merge branch 'sunxi/clk-for-4.17=
' into sunxi/for-next)
Merging tegra/for-next (6b9b5116227d Merge branch for-4.17/clk into for-nex=
t)
Merging arm64/for-next/core (24534b351182 arm64: assembler: add macros to c=
onditionally yield the NEON under PREEMPT)
Merging clk/clk-next (3baba436e3a6 Merge branch 'clk-core' into clk-next)
Merging clk-samsung/for-next (182c084da5d1 clk: samsung: Add fout=3D1966080=
01 Hz EPLL rate entry for exynos4412)
Merging c6x/for-linux-next (85fa2cc51104 c6x: pass endianness info to spars=
e)
Merging m68k/for-next (a5de04ccf0b5 m68k: Fix style, spelling, and grammar =
in siginfo_build_tests())
Merging m68knommu/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging microblaze/next (70f6283a372b microblaze: Use generic pci_mmap_reso=
urce_range())
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (3539adf568f5 MIPS: Use generic GCC library ro=
utines from lib/)
Merging nds32/next (a27fc14219f2 Merge branch 'parisc-4.17-3' of git://git.=
kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (d56f3af9e801 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (41dbee81c875 parisc: Document rules regarding c=
hecksum of HPMC handler)
Merging powerpc/next (60cc43fc8884 Linux 4.17-rc1)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging s390/features (fae764912153 s390/signal: cleanup uapi struct sigact=
ion)
Merging sparc-next/master (17dec0a94915 Merge branch 'userns-linus' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace)
Merging sh/for-next (bf9c7e3d7924 arch/sh: pcie-sh7786: handle non-zero DMA=
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
Merging btrfs-kdave/for-next (19d3b4c4bad8 Merge branch 'for-next-next-v4.1=
8-20180419' into for-next-20180419)
Merging ceph/master (e2311baa73a8 ceph: check if mds create snaprealm when =
setting quota)
Merging cifs/for-next (67e72b6a4996 CIFS: fix typo in cifs_dbg)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (b1255ee6a289 Pull UDF UTF-16 handling improvements.)
Merging ext4/dev (b025a674fc5d ext4: force revalidation of directory pointe=
r after seekdir(2))
Merging f2fs/dev (91bb86e196f6 f2fs: call unlock_new_inode() before d_insta=
ntiate())
Merging fuse/for-next (5ba24197b94d fuse: add writeback documentation)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (60cc43fc8884 Linux 4.17-rc1)
Merging nfs-anna/linux-next (98de9ce6f666 NFS: advance nfs_entry cookie onl=
y after decoding completes successfully)
Merging nfsd/nfsd-next (36e000768550 nfsd: update obselete comment referenc=
ing the BKL)
Merging orangefs/for-next (8e9ba5c48ea6 Orangefs: documentation updates)
Merging overlayfs/overlayfs-next (16149013f839 ovl: update documentation w.=
r.t "xino" feature)
Merging ubifs/linux-next (b5094b7f135b ubi: Reject MLC NAND)
Merging xfs/for-next (8c81dd46ef3c Force log to disk before reading the AGF=
 during a fstrim)
Merging file-locks/locks-next (fa28b25b62ba fasync: Fix deadlock between ta=
sk-context and interrupt-context kill_fasync())
Merging vfs/for-next (eb5e8befb894 Merge tag 'afs-next-20180409-c' into for=
-next)
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (cdb7e52d960a vsprintf: Tweak pF/pf comment)
Merging pci/next (60cc43fc8884 Linux 4.17-rc1)
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (00ddd17446aa Merge branch 'for-4.17/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (1eace8344c02 i2c: add param sanity check to i2c_t=
ransfer())
Merging dmi/master (0a5f08c2f0c7 firmware: dmi_scan: Use lowercase letters =
for UUID)
Merging hwmon-staging/hwmon-next (3449f321d6ae Merge tag 'ib-mfd-hwmon-v4.1=
8' into hwmon-next)
Merging jc_docs/docs-next (3b443955596e Docs: tell maintainers to put [GIT =
PULL] in their subject lines)
Merging v4l-dvb/master (42a182282ea2 media: si470x: fix a typo at the Makef=
ile causing build issues)
Merging v4l-dvb-next/master (17dec0a94915 Merge branch 'userns-linus' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace)
Merging fbdev/fbdev-for-next (7c9b845e79ea video: fbdev: s3c-fb: remove dea=
d platform code for Exynos and S5PV210 platforms)
Merging pm/linux-next (1fe43114ea73 Merge tag 'pm-4.17-rc1-2' of git://git.=
kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging cpupower/cpupower (7928b2cbe55b Linux 4.16-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (4a823c0be80f opp: cpu: Replace GFP_ATOMIC with =
GFP_KERNEL in dev_pm_opp_init_cpufreq_table)
Merging thermal/next (b907b408ca64 Merge branches 'thermal-core' and 'therm=
al-soc' into next)
Merging thermal-soc/next (629d835db501 thermal: imx: add i.MX7 thermal sens=
or support)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (9250e523592a dlm: remove dlm_send_rcom_lookup_dump)
Merging swiotlb/linux-next (69369f52d28a swiotlb-xen: implement xen_swiotlb=
_get_sgtable callback)
Merging rdma/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging net-next/master (bda73d4ec943 Merge branch 'Amiga-xsurf100')
Merging bpf-next/master (97e19cce05e5 bpf: reserve xdp_frame size in xdp he=
adroom)
Merging ipsec-next/master (cd027a5433d6 udp: enable UDP checksum offload fo=
r ESP)
Merging netfilter-next/master (159f02977b2f Merge branch 'net-mvneta-improv=
e-suspend-resume')
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (9a17740e0ea1 ipvs: fix multiplicative hashing in =
sh/dh/lblc/lblcr algorithms)
Merging wireless-drivers-next/master (5d1365940a68 Merge git://git.kernel.o=
rg/pub/scm/linux/kernel/git/davem/net)
Merging bluetooth/master (24557b660705 Bluetooth: btqcomsmd: Fix rx/tx stat=
s)
Merging mac80211-next/master (8db0c433692e regulatory: Rename confusing 'co=
untry IE' in log output)
Merging gfs2/for-next (9a38662ba4e2 gfs2: Remove sdp->sd_jheightsize)
Merging mtd/master (87a73eb5b56f mtd: jedec_probe: Fix crash in jedec_read_=
mfr())
Merging l2-mtd/mtd/next (fe5f31a8010a Merge tag 'v4.16-rc2' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/torvalds/linux into mtd/next)
Merging nand/nand/next (097ccca726ff mtd: nand: Fix some function descripti=
on mismatches in core.c)
Merging spi-nor/spi-nor/next (e8de85d5a107 dt-bindings: fsl-quadspi: Add th=
e example of two SPI NOR)
Merging crypto/master (f444ec106407 crypto: ccree - remove unused enums)
Merging drm/drm-next (a10beabba213 Merge branch 'drm-next-4.17' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (b4615730530b drm/i915/audio: Fix audio de=
tection issue on GLK)
Merging drm-tegra/drm/tegra/for-next (27e92f1f1600 drm/tegra: prime: Implem=
ent ->{begin,end}_cpu_access())
Merging drm-misc/for-linux-next (3131f209468d drm/vc4: Fix leak of the file=
_priv that stored the perfmon.)
Merging drm-msm/msm-next (789d4c300e10 drm/msm: don't deref error pointer i=
n the msm_fbdev_create error path)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (6e810eb508f4 drm: mali-dp: Add YUV->R=
GB conversion support for video layers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (22cd2b2b3151 drm/imx: Remove last traces of s=
truct imx_drm_crtc)
Merging etnaviv/etnaviv/next (4ed75c3e5255 drm/etnaviv: bump HW job limit t=
o 4)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (e241e3f2bf97 Merge tag 'for_linus' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging sound/for-next (91a8561d0eed ALSA: usb-audio: add implicit fb quirk=
 for Axe-Fx III)
Merging sound-asoc/for-next (9742eab30c26 Merge branch 'asoc-4.18' into aso=
c-next)
Merging modules/modules-next (c554b8986801 module: Allow to always show the=
 status of modsign)
Merging input/next (04bb1719c4de Input: i8042 - enable MUX on Sony VAIO VGN=
-CS series to fix touchpad)
Merging block/for-next (667eea5d591b Merge branch 'for-4.17/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (a1c0a8e35b88 dm bufio: fix buffer alignment)
Merging mmc/next (924178333b63 mmc: mediatek: use of_device_get_match_data(=
))
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (50c35295db95 MD: fix lock contention for flush bios)
Merging mfd/for-mfd-next (b45bf45f1b82 mfd: arizona: Update reset pin to us=
e GPIOD)
Merging backlight/for-backlight-next (ea388d6cffd4 pwm-backlight: Add suppo=
rt for PWM delays proprieties.)
Merging battery/for-next (fd73a3e61888 power: reset: at91-reset: Switch fro=
m the pr_*() to the dev_*() logging functions)
Merging regulator/for-next (1dced996ee70 regulator: pfuze100: update voltag=
e setting for pfuze3000 sw1a)
Merging security/next-testing (0c245cb58731 security: remove security_setti=
me)
Merging apparmor/apparmor-next (588558eb6d0e apparmor: fix memory leak on b=
uffer on error exit path)
Merging integrity/next-integrity (ab60368ab6a4 ima: Fallback to the builtin=
 hash algorithm)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (d141136f523a audit: normalize MAC_POLICY_LOAD record)
Merging tpmdd/next (6fd6db01dfaf tpm: fix intermittent failure with self te=
sts)
Merging watchdog/master (49d4d277ca54 aspeed: watchdog: Set bootstatus duri=
ng probe)
Merging iommu/next (d4f96fd5c249 Merge branches 'x86/amd', 'x86/vt-d', 'arm=
/rockchip', 'arm/omap', 'arm/mediatek', 'arm/exynos', 'arm/renesas', 'arm/s=
mmu' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (da9147140fe3 MAINTAINERS: vfio/platform: Update sub-main=
tainer)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (60cc43fc8884 Linux 4.17-rc1)
Merging devicetree/for-next (304a39b4bc94 dt-bindings: more status property=
 removal from examples)
Merging mailbox/mailbox-for-next (41c0e939d70d mailbox: Add support for Hi3=
660 mailbox)
Merging spi/for-next (9d7e5766a8fd Merge branch 'spi-4.18' into spi-next)
Merging tip/auto-latest (15a5848cfc2b Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (0136c741ff40 clocksource/drivers/imx-=
tpm: Add different counter width support)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6fd052665274 EDAC, sb_edac: Remove variable leng=
th array usage)
Merging irqchip/irq/irqchip-next (aa08192a254d irqchip/gic: Take lock when =
updating irq type)
Merging ftrace/for-next (0b3dec05dbbc tracing: Enforce passing in filter=3D=
NULL to create_filter())
Merging rcu/rcu/next (3b91e0ea77ce rcu: Exclude near-simultaneous RCU CPU s=
tall warnings)
Merging kvm/linux-next (c18bb396d3d2 Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/davem/net)
Merging kvm-arm/next (dc6ed61d2f82 arm64: Add temporary ERRATA_MIDR_ALL_VER=
SIONS compatibility macro)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (31c8b0d0694a KVM: PPC: Book3S HV: Use __gfn_t=
o_pfn_memslot() in page fault handler)
Merging kvms390/next (ccc40c53c07b KVM: s390: provide counters for all inte=
rrupt injects/delivery)
Merging xen-tip/linux-next (ebf04f331fa1 xen: xenbus_dev_frontend: Really r=
eturn response string)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (1aa3798360db Merge branch 'for-4.17' into for-=
next)
Merging drivers-x86/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging chrome-platform/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging hsi/for-next (70d52ba9e57e hsi: clients: Change return type to vm_f=
ault_t)
Merging leds/for-next (9e50d5fb0d18 leds: add LED driver for CR0014114 boar=
d)
Merging ipmi/for-next (1211229399b3 ipmi_ssif: Fix uninitialized variable i=
ssue)
Merging driver-core/driver-core-next (60cc43fc8884 Linux 4.17-rc1)
Merging usb/usb-next (60cc43fc8884 Linux 4.17-rc1)
Merging usb-gadget/next (60cc43fc8884 Linux 4.17-rc1)
Merging usb-serial/usb-next (60cc43fc8884 Linux 4.17-rc1)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx:=
 Fix ULPI on imx53)
Merging phy-next/next (60cc43fc8884 Linux 4.17-rc1)
Merging tty/tty-next (60cc43fc8884 Linux 4.17-rc1)
Merging char-misc/char-misc-next (60cc43fc8884 Linux 4.17-rc1)
Merging extcon/extcon-next (60cc43fc8884 Linux 4.17-rc1)
Merging staging/staging-next (60cc43fc8884 Linux 4.17-rc1)
Merging mux/for-next (fa934c06c0f4 mux: add mux_control_get_optional() API)
Merging slave-dma/next (72ef08bf651a dmaengine: dmatest: Remove use of VLAs)
Merging cgroup/for-next (d1897c9538ed cgroup: fix rule checking for threade=
d mode switching)
Merging scsi/for-next (acc2587b8cf1 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (69589c9bb9c2 scsi: target: Change return type to=
 vm_fault_t)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (fd17ed684b6e Revert "ata: ahci-platform: add reset=
 control support")
Merging vhost/linux-next (3af494dbae48 ACPI: disable extra P_LVLx access on=
 KVM)
Merging rpmsg/for-next (47c4aebb693c Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (348f3cde84ab gpio: Add Spreadtrum PMIC EIC driver su=
pport)
Merging pinctrl/for-next (4fc97ef94bbf pinctrl: uniphier: add UART hardware=
 flow control pin-mux settings)
Merging pinctrl-samsung/for-next (938a10bb4913 pinctrl: samsung: Document r=
equired order of banks)
Merging pwm/for-next (6873842235d6 pwm: rcar: Add suspend/resume support)
Merging userns/for-next (1f5781725dcb commoncap: Handle memory allocation f=
ailure.)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (60cc43fc8884 Linux 4.17-rc1)
Merging y2038/y2038 (ad17d1754e88 y2038: compat: Move common compat types t=
o asm-generic/compat.h)
Merging livepatching/for-next (3beed9bf1e3d Merge branch 'for-4.17/upstream=
-fixes' into for-next)
Merging coresight/next (53531a9947ed coresight: Moving framework and driver=
s to SPDX identifier)
Merging rtc/rtc-next (36d91a4d401c rtc: cmos: introduce quirks to enable us=
e_acpi_alarm mode)
Merging nvdimm/libnvdimm-for-next (e13e75b86ef2 Merge branch 'for-4.17/dax'=
 into libnvdimm-for-next)
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in L=
DFLAGS too)
Merging at24/at24/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging ntb/ntb-next (53c3677c56c7 ntb: intel: change references of skx to =
gen3)
Merging kspp/for-next/kspp (0adb32858b0b Linux 4.16)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging akpm-current/current (fdb1a3b69d1b exofs: avoid VLA in structures)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: kernel/kexec_file.c: add walk_system_ram_res_rev()
Applying: kernel/kexec_file.c: load kernel at top of system RAM if required
Applying: mm: memcg: remote memcg charging for kmem allocations
Applying: mm: memcg: remote memcg charging for kmem allocations fix
Applying: fs: fsnotify: account fsnotify metadata to kmemcg
Applying: fs-fsnotify-account-fsnotify-metadata-to-kmemcg-fix
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (6cceef4e4fbc sparc64: NG4 memset 32 bits overflow)

--Sig_/dO00S=eHeQ/iGeL9GRDH9HE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlrZhJ0ACgkQAVBC80lX
0GxxCAf8CQ3YEvIZmVq/OZysdidN1PznOJv7UTf1k6uas7/B3sZUq5pg3DE9nJAE
iAvvd+zpFCJf70qdWdirBrrqWBigEwjavTV9L9GYtEMR58MDcWhGNQicDMoEZV/n
JnxouwTWNjGmpN/G3K6uqBoo6I4Qc91GbH56Ggx3lzp+DlXr8fh0O0FV/+rF7YVX
zrWAo3mAqifaQpuvr/8komvyrQr3SQ16Bj4KdF4HcR1WsPkZiRp1XzamROLRWSsg
M75Y/x4Sd2HaYhiVvsCPzt5pKTQlmdXMq4yAci5WcA1KBUW+jOgMNKqJGPakUdiI
LAV8MTS7iHg7Kn/mgP4tQ4NLPIuI/A==
=Q64M
-----END PGP SIGNATURE-----

--Sig_/dO00S=eHeQ/iGeL9GRDH9HE--
