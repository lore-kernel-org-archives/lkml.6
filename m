Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbeBTCoa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 21:44:30 -0500
Received: from ozlabs.org ([103.22.144.67]:41617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932352AbeBTCo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 21:44:27 -0500
Date: Tue, 20 Feb 2018 13:44:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 20
Message-ID: <20180220134425.585587d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Xb_YuUA9ALfcsUYsoJ/oSlz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Xb_YuUA9ALfcsUYsoJ/oSlz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180219:

The sound-asoc tree lost its build failures.

Non-merge commits (relative to Linus' tree): 2441
 2914 files changed, 105361 insertions(+), 55486 deletions(-)

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

I am currently merging 256 trees (counting Linus' and 44 trees of bug
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
Merging origin/master (79c0ef3e85c0 Merge git://git.kernel.org/pub/scm/linu=
x/kernel/git/davem/net)
Merging fixes/master (7928b2cbe55b Linux 4.16-rc1)
Merging kbuild-current/fixes (36c1681678b5 genksyms: drop *.hash.c from .gi=
tignore)
Merging arc-current/for-curr (053823335956 arc: dts: use 'atmel' as manufac=
turer for at24 in axs10x_mb)
Merging arm-current/fixes (091f02483df7 ARM: net: bpf: clarify tail_call in=
dex)
Merging m68k-current/for-linus (2334b1ac1235 MAINTAINERS: Add NuBus subsyst=
em entry)
Merging metag-fixes/fixes (b884a190afce metag/usercopy: Add missing fixups)
Merging powerpc-fixes/fixes (2c10636a0b9c powerpc/pseries: Check for zero f=
illed ibm,dynamic-memory property)
Merging sparc/master (aebb48f5e465 sparc64: fix typo in CONFIG_CRYPTO_DES_S=
PARC64 =3D> CONFIG_CRYPTO_CAMELLIA_SPARC64)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (506b0a395f26 tg3: APE heartbeat changes)
Merging bpf/master (9c2d63b843a5 bpf: fix mlock precharge on arraymaps)
Merging ipsec/master (510c321b5571 xfrm: reuse uncached_list to track xdsts)
Merging netfilter/master (cfc2c7405333 netfilter: IDLETIMER: be syzkaller f=
riendly)
Merging ipvs/master (f7fb77fc1235 netfilter: nft_compat: check extension ho=
ok mask only if set)
Merging wireless-drivers/master (7ac8ff95f48c mvpp2: fix multicast address =
filter)
Merging mac80211/master (3b07029729e3 mac80211: Fix sending ADDBA response =
for an ongoing session)
Merging rdma-fixes/for-rc (2f08ee363fe0 RDMA/restrack: don't use uaccess_ke=
rnel())
Merging sound-current/for-linus (fdcc968a3b29 ALSA: hda/realtek: PCI quirk =
for Fujitsu U7x7)
Merging pci-current/for-linus (7928b2cbe55b Linux 4.16-rc1)
Merging driver-core.current/driver-core-linus (7928b2cbe55b Linux 4.16-rc1)
Merging tty.current/tty-linus (7928b2cbe55b Linux 4.16-rc1)
Merging usb.current/usb-linus (fc19b1d09414 Merge tag 'fixes-for-v4.16-rc2'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-linus)
Merging usb-gadget-fixes/fixes (98112041bcca usb: dwc3: core: Fix ULPI PHYs=
 and prevent phy_get/ulpi_init during suspend/resume)
Merging usb-serial-fixes/usb-linus (d14ac576d10f USB: serial: cp210x: add n=
ew device ID ELV ALC 8xxx)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging staging.current/staging-linus (6d79bd5bb6c7 staging: android: ion: =
Zero CMA allocated memory)
Merging char-misc.current/char-misc-linus (7ae079aca59f mei: set device cli=
ent to the disconnected state upon suspend.)
Merging input-current/for-linus (ea4f7bd2aca9 Input: matrix_keypad - fix ra=
ce when disabling interrupts)
Merging crypto-current/master (c927b080c67e crypto: s5p-sss - Fix kernel Oo=
ps in AES-ECB mode)
Merging ide/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_time')
Merging vfio-fixes/for-linus (563b5cbe334e iommu/arm-smmu-v3: Cope with dup=
licated Stream IDs)
Merging kselftest-fixes/fixes (9eaa1fb21961 selftests: vm: update .gitignor=
e with new test)
CONFLICT (content): Merge conflict in tools/testing/selftests/x86/Makefile
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711=
_bl: fix device-tree node leaks)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (107b7d9fa94c mfd: rtsx: Release IRQ during=
 shutdown)
Merging v4l-dvb-fixes/fixes (781b045baefd media: imx274: Fix error handling=
, add MAINTAINERS entry)
Merging reset-fixes/reset/fixes (f450f28e70a2 reset: socfpga: fix for 64-bi=
t compilation)
Merging mips-fixes/mips-fixes (5efad9eee33e sparc,leon: Select USB_UHCI_BIG=
_ENDIAN_{MMIO,DESC})
Merging kvm-fixes/master (722c2cd7b7c9 Merge tag 'kvm-s390-master-4.16-1' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
Merging kvms390-fixes/master (baabee67f413 KVM: s390: use switch vs jump ta=
ble in interrupt.c)
Merging drm-intel-fixes/for-linux-next-fixes (ee622fe757f6 drm/i915: Fix DS=
I panels with v1 MIPI sequences without a DEASSERT sequence v3)
Merging drm-misc-fixes/for-linux-next-fixes (06998a756a38 drm/edid: Add 6 b=
pc quirk for CPT panel in Asus UX303LA)
Merging kbuild/for-next (b583b9f9c919 kbuild: process mixture of clean/buil=
d targets one by one)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (04f56534786c MAINTAINERS: add the iommu list =
for swiotlb and xen-swiotlb)
Merging asm-generic/master (a351e9b9fc24 Linux 4.11)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (3a175cdf4392 Merge branches 'fixes', 'misc', 'sa1111'=
 and 'sa1100-for-next' into for-next)
Merging arm-perf/for-next/perf (7928b2cbe55b Linux 4.16-rc1)
Merging arm-soc/for-next (2aa127e4d579 Merge branches 'next/dt' and 'next/d=
rivers' into for-next)
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (a1144b2b1ec4 ARM: dts: alpine: add valid cl=
ock-frequency values)
Merging amlogic/for-next (b1303f3fa73b Merge branch 'v4.17/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (91b55cc53a17 Merge branch 'dt-for-4.17' into for-n=
ext)
Merging at91/at91-next (fa4cf68ab4b1 Merge tag 'at91-ab-4.16-dt' into at91-=
next)
Merging bcm2835/for-next (a6189bcc0012 Merge branch anholt/bcm2835-drivers-=
next into for-next)
Merging imx-mxs/for-next (914867289762 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a29b8b93e158 Merge branch 'for_4.16/keystone-config'=
 into next)
Merging mvebu/for-next (b4e369232fa8 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (64dbb6ed7c33 Merge branch 'omap-for-v4.16/fixes' int=
o for-next)
Merging reset/reset/next (70d2f16a6289 reset: meson: enable level reset sup=
port on Meson8b)
Merging qcom/for-next (f5788d2f2929 Merge tag 'qcom-arm64-defconfig-for-4.1=
6' into tagged-for-4.16)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (aa0ce0bb0b6f Merge branches 'arm64-defconfig-for-v4.1=
7', 'arm64-dt-for-v4.17', 'defconfig-for-v4.17', 'dt-bindings-for-v4.17', '=
dt-for-v4.17' and 'soc-for-v4.17' into next)
Merging rockchip/for-next (cc95e6771f11 Merge branch 'v4.17-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (f9b2bb6c0ee0 Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (017b7e4e23ff Merge branch 'sunxi/dt-for-4.17'=
 into sunxi/for-next)
Merging tegra/for-next (983371acdeda Merge branch for-4.16/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (3a0a397ff5ff arm64: Kill PSCI_GET_VERSION as a=
 variant-2 workaround)
Merging clk/clk-next (c43a52cfd27b Merge branches 'clk-aspeed', 'clk-lock-U=
P', 'clk-mediatek' and 'clk-allwinner' into clk-next)
Merging clk-samsung/for-next (83942bdd992f clk: exynos5433: Extend list of =
available AUD_PLL output frequencies)
Merging c6x/for-linux-next (9d440f7a2824 c6x: fix platforms/plldata.c get_c=
oreid build error)
Merging cris/for-next (fd989db807a0 cris: Fix conflicting types for _etext,=
 _edata, _end)
Merging m68k/for-next (2334b1ac1235 MAINTAINERS: Add NuBus subsystem entry)
Merging m68knommu/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging metag/for-next (e3cd7f013bac metag/mm: Drop pointless increment)
Merging microblaze/next (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-=
nfs.org/~bfields/linux)
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (35868f095948 MIPS: generic: Enable crc32-mips=
 on r6 configs)
Merging nios2/for-next (e0691ebb33c1 nios2: defconfig: Cleanup from old Kco=
nfig options)
Merging openrisc/for-next (0fedb7653af7 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (a156e659f2d2 parisc: Reduce irq overhead when r=
un in qemu)
Merging powerpc/next (7928b2cbe55b Linux 4.16-rc1)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging s390/features (c3ec23b80192 s390/sclp: Add support for Store Data S=
CLP interface)
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
Merging btrfs-kdave/for-next (6537ffbd6382 Merge branch 'for-next-next-v4.1=
6-20180213' into for-next-20180213)
CONFLICT (content): Merge conflict in fs/btrfs/tree-log.c
CONFLICT (content): Merge conflict in fs/btrfs/disk-io.c
Merging ceph/master (16515a6d5418 ceph: improving efficiency of syncfs)
Merging cifs/for-next (1c6614d229e7 CIFS: add sha512 secmech)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (4670269faba7 eCryptfs: constify attribute_group stru=
ctures.)
Merging ext3/for_next (1d37d05f3c2c udf: Fix handling of Partition Descript=
ors)
Merging ext4/dev (5dc397113d19 ext4: create ext4_kset dynamically)
Merging f2fs/dev (1c1d35df7110 f2fs: support inode creation time)
Merging fuse/for-next (c6cdd51404b7 fuse: fix READDIRPLUS skipping an entry)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (91ab883eb213 Linux 4.16-rc2)
Merging nfs-anna/linux-next (c54c14ba000d xprtrdma: Spread reply processing=
 over more CPUs)
CONFLICT (content): Merge conflict in net/sunrpc/xprtrdma/transport.c
CONFLICT (content): Merge conflict in net/sunrpc/xprt.c
Merging nfsd/nfsd-next (175e03101d36 svcrdma: Fix Read chunk round-up)
Merging orangefs/for-next (74e938c22705 orangefs: reverse sense of is-inode=
-stale test in d_revalidate)
Merging overlayfs/overlayfs-next (7168179fcf25 ovl: check ERR_PTR() return =
value from ovl_lookup_real())
Merging ubifs/linux-next (7f29ae9f977b ubi: block: Fix locking for idr_allo=
c/idr_remove)
Merging xfs/for-next (76883f7988e6 xfs: remove experimental tag for reverse=
 mapping)
Merging file-locks/locks-next (1deab8ce2c91 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/sparc)
Merging vfs/for-next (d85e2aa2e34d annotate ep_scan_ready_list())
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging iversion/iversion-next (581e400ff935 Merge tag 'modules-for-v4.16' =
of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux)
Merging printk/for-next (02fffdcaed19 Merge branch 'for-4.17' into for-next)
Merging pci/next (c8989cd7ece7 Merge branch 'pci/sparc' into next)
Merging pstore/for-next/pstore (a99f41a1b441 fs: pstore: remove unused hard=
irq.h)
Merging hid/for-next (ba6986149ce3 Merge branch 'for-4.16/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (a2cdd4be7a2c Merge branch 'i2c/for-4.16' into i2c=
/for-next)
CONFLICT (content): Merge conflict in drivers/i2c/i2c-core-smbus.c
Merging dmi/master (36a840c73dc6 firmware: dmi: handle missing DMI data gra=
cefully)
Merging hwmon-staging/hwmon-next (e464243586cb hwmon: (sht3x) Update data s=
heet URL)
Merging jc_docs/docs-next (b57c847ca6e6 admin-guide: Fix list formatting in=
 tained-kernels.html)
Merging v4l-dvb/master (29422737017b media: rc: get start time just before =
calling driver tx)
Merging v4l-dvb-next/master (a1dfb4c48cc1 media: v4l2-compat-ioctl32.c: ref=
actor compat ioctl32 logic)
Merging fbdev/fbdev-for-next (5865889fe431 video: udlfb: Switch from the pr=
_*() to the dev_*() logging functions)
Merging pm/linux-next (91ab883eb213 Linux 4.16-rc2)
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
Merging net-next/master (26736a08ee0f tipc: don't call sock_release() in at=
omic context)
Merging bpf-next/master (0b6b8a3dd86d Merge branch 'bpf-misc-selftest-impro=
vements')
Merging ipsec-next/master (60aa80460da1 esp4: remove redundant initializati=
on of pointer esph)
Merging netfilter-next/master (c746fc0e8b2d cxgb4: add geneve offload suppo=
rt for T6)
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (a910d20aa007 netfilter: ipvs: Fix space before '[=
' error.)
Merging wireless-drivers-next/master (cf19e5e2054f Merge branch '40GbE' of =
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue)
Merging bluetooth/master (1ec010e70593 tun: export flags, uid, gid, queue i=
nformation over netlink)
Merging mac80211-next/master (b28971dfae9f mac80211: Adjust TSQ pacing shif=
t)
Merging rdma/for-next (3a148896b24a IB/srp: Fix completion vector assignmen=
t algorithm)
Merging gfs2/for-next (6556677a8040 Merge tag 'gfs2-4.16.rc1.fixes' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2)
Merging mtd/master (f23def803861 mtd: nand: MTD_NAND_MARVELL should depend =
on HAS_DMA)
Merging l2-mtd/mtd/next (0dbe4ea78d69 mtd: get rid of the mtd_add_device_pa=
rtitions())
Merging nand/nand/next (4da712e70294 mtd: nand: fsmc: use ->exec_op())
CONFLICT (content): Merge conflict in drivers/mtd/nand/Kconfig
Merging spi-nor/spi-nor/next (7928b2cbe55b Linux 4.16-rc1)
Merging crypto/master (a43a34845a15 crypto: stm32/cryp - add stm32mp1 suppo=
rt)
Merging drm/drm-next (933519a5a269 Merge tag 'topic/hdcp-2018-02-13' of git=
://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_breadcrumb=
s.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.c
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (be3fa6685705 drm/i915/: Initialise trans_=
min for skl_compute_transition_wm())
Merging drm-tegra/drm/tegra/for-next (8f62142e490d drm/tegra: dc: Properly =
cleanup overlay planes)
Applying: mtd: nand: fix up for raw Kconfig move
Merging drm-misc/for-linux-next (761e05a702f5 drm: Check for lessee in DROP=
_MASTER ioctl)
Merging drm-msm/msm-next (8fe2938c9bac drm/msm: Trigger fence completion fr=
om GPU)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (54243016ae35 drm: mali-dp: Disable pl=
anes when their CRTC gets disabled.)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (3addaba8141b gpu: ipu-v3: prg: fix device nod=
e leak in ipu_prg_lookup_by_phandle)
Merging etnaviv/etnaviv/next (246774d17fc0 drm/etnaviv: remove the need for=
 a gpu-subsystem DT node)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (9e4e3b86e5ef Merge remote-tracking branch 'regmap/=
topic/bulk' into regmap-next)
Merging sound/for-next (04f8773a3e98 ALSA: emu10k1: add a IOMMU workaround)
Merging sound-asoc/for-next (5a1dec3a8d43 Merge remote-tracking branches 'a=
soc/topic/wm9712', 'asoc/topic/wm9713', 'asoc/topic/wm9867', 'asoc/topic/wm=
_adsp' and 'asoc/topic/zx_aud96p22' into asoc-next)
Merging modules/modules-next (0cad61d7a3d5 modpost: Remove trailing semicol=
on)
Merging input/next (cdc2466df40f Input: synaptics - handle errors from inpu=
t_mt_init_slots())
Merging block/for-next (0ccfb3c0032b Merge branch 'for-4.16/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (8dd601fa8317 dm: correctly handle chained b=
ios in dec_pending())
Merging mmc/next (80a7d9316496 Merge branch 'fixes' into next)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (01a69cab01c1 md raid10: fix NULL deference in handle_w=
rite_completed())
Merging mfd/for-mfd-next (0f89ffefa4e1 mfd: lpc_ich: Do not touch SPI-NOR w=
rite protection bit on Apollo Lake)
Merging backlight/for-backlight-next (2023b0524a63 backlight: tdo24m: Fix t=
he SPI CS between transfers)
Merging battery/for-next (416a1ae673db power: supply: gpio-charger: use hel=
per variable to access device info)
Merging regulator/for-next (775d434195db Merge remote-tracking branches 're=
gulator/topic/dt' and 'regulator/topic/gpio' into regulator-next)
Merging security/next-testing (400f428062af Merge branch 'next-integrity' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into =
next-testing)
Merging integrity/next-integrity (b79f5f38d87f fuse: introduce new fs_type =
flag FS_IMA_NO_CACHE)
CONFLICT (content): Merge conflict in security/integrity/ima/ima_main.c
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (213d7f947753 netlabel: If PF_INET6, check sk_buff ip =
header version)
Merging tpmdd/next (c3211d722c61 tpm: fix potential buffer overruns caused =
by bit glitches on the bus)
Merging watchdog/master (a17f4f032b61 watchdog: sp5100_tco.c: fix potential=
 build failure)
Merging iommu/next (18b3c16e25fb Merge branches 'x86/amd', 'x86/vt-d', 'arm=
/mediatek', 'arm/exynos' and 'core' into next)
Merging dwmw2-iommu/master (910170442944 iommu/vt-d: Fix PASID table alloca=
tion)
Merging vfio/next (46ed90f157f4 vfio: mdev: make a couple of functions and =
structure vfio_mdev_driver static)
Merging trivial/for-next (1972d6c0c86d MAINTAINERS: relinquish kconfig)
Merging audit/next (94d14e3e7b41 audit: bail before bug check if audit disa=
bled)
Merging devicetree/for-next (7ea5c83472d3 Merge branches 'dt/next' and 'dt/=
linus' into for-next)
Merging mailbox/mailbox-for-next (0ae7d327a64b dt-bindings: mailbox: qcom: =
Document the APCS clock binding)
Merging spi/for-next (a48478413035 Merge remote-tracking branches 'spi/topi=
c/orion' and 'spi/topic/pxa2xx' into spi-next)
Merging tip/auto-latest (cb85c73cf461 Merge branch 'x86/pti')
Merging clockevents/clockevents/next (322fd24f5e67 clocksource/drivers/stm3=
2: Start the timer's counter sooner)
CONFLICT (content): Merge conflict in drivers/clocksource/timer-stm32.c
CONFLICT (content): Merge conflict in drivers/clocksource/timer-of.c
CONFLICT (content): Merge conflict in drivers/clocksource/Kconfig
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (68fa24f9121c EDAC, mv64x60: Fix an error handlin=
g path)
Merging irqchip/irqchip/for-next (c1ae3cfa0e89 Linux 4.11-rc1)
Merging ftrace/for-next (841a915d20c7 vsprintf: Do not have bprintf derefer=
ence pointers)
Merging rcu/rcu/next (2faeeb29ab2b EXP rcu: Add ->qsmask to assertion)
Merging kvm/linux-next (7928b2cbe55b Linux 4.16-rc1)
Merging kvm-arm/next (7928b2cbe55b Linux 4.16-rc1)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (7928b2cbe55b Linux 4.16-rc1)
Merging kvms390/next (baabee67f413 KVM: s390: use switch vs jump table in i=
nterrupt.c)
Merging xen-tip/linux-next (d1a75e0896f5 pvcalls-front: wait for other oper=
ations to return when release passive sockets)
Merging percpu/for-next (554fef1c39ee percpu: allow select gfp to be passed=
 to underlying allocators)
Merging workqueues/for-next (a10eb37ccf1d Merge branch 'for-4.15-fixes' int=
o for-next)
Merging drivers-x86/for-next (c8ba9db2a790 platform/x86: dell-laptop: Remov=
ed duplicates in DMI whitelist)
Merging chrome-platform/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging hsi/for-next (b6dc80dbe6cd HSI: cmt_speech: use timespec64 instead =
of timespec)
Merging leds/for-next (2dd1ea5b8a49 leds: Add more product/board names for =
PC Engines APU2)
Merging ipmi/for-next (09c0179286c7 ipmi: kcs_bmc: mark expected switch fal=
l-through in kcs_bmc_handle_data)
Merging driver-core/driver-core-next (7928b2cbe55b Linux 4.16-rc1)
Merging usb/usb-next (7928b2cbe55b Linux 4.16-rc1)
Merging usb-gadget/next (8ada211d0383 usb: renesas_usbhs: add extcon notifi=
er to set mode for non-otg channel)
Merging usb-serial/usb-next (d1c48227d7c4 USB: serial: f81534: fix tx error=
 on some baud rate)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx:=
 Fix ULPI on imx53)
Merging phy-next/next (7928b2cbe55b Linux 4.16-rc1)
Merging tty/tty-next (7928b2cbe55b Linux 4.16-rc1)
Merging char-misc/char-misc-next (7928b2cbe55b Linux 4.16-rc1)
Merging extcon/extcon-next (7928b2cbe55b Linux 4.16-rc1)
Merging staging/staging-next (f782497c0991 staging: wilc1000: fix line over=
 80 chars in wilc_wlan_handle_txq())
Merging mux/for-next (6cd361c99ef2 mux: add SPDX identifiers to all mux sou=
rce files)
Merging slave-dma/next (5ec91512231a Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (c53593e5cb69 sched, cgroup: Don't reject lower cpu=
.max on ancestors)
Merging scsi/for-next (b00e1e5f242e Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (ec92b59cc03c scsi: ufs: sysfs: attributes)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (d058cdf3cc81 Merge branches 'for-4.16-fixes' and '=
for-4.17' into for-next)
Merging vhost/linux-next (fa08a3b4eba5 virtio/s390: implement PM operations=
 for virtio_ccw)
Merging rpmsg/for-next (ec6e69036956 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (3c87d7c874b2 gpio: davinci: add support for pinmux g=
pio ranges)
Merging pinctrl/for-next (cfc09838477f Merge branch 'devel' into for-next)
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
Merging kselftest/next (7928b2cbe55b Linux 4.16-rc1)
Merging y2038/y2038 (69973b830859 Linux 4.9)
Merging livepatching/for-next (d13f5d84ca27 Merge branch 'for-4.16/signal-s=
ysfs-force-v2' into for-next)
Merging coresight/next (7928b2cbe55b Linux 4.16-rc1)
Merging rtc/rtc-next (9fad33fc0baf rtc: tx4939: avoid unintended sign exten=
sion on a 24 bit shift)
Merging nvdimm/libnvdimm-for-next (ee95f4059a83 Merge branch 'for-4.16/nfit=
' into libnvdimm-for-next)
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in L=
DFLAGS too)
Merging at24/at24/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging ntb/ntb-next (53c3677c56c7 ntb: intel: change references of skx to =
gen3)
Merging kspp/for-next/kspp (2d00fcb32f71 Merge branch 'kspp/gcc-plugin/infr=
astructure' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging akpm-current/current (5682fa508060 elf: enforce MAP_FIXED on overla=
ying elf segments)
CONFLICT (content): Merge conflict in kernel/fork.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: ipc/mqueue: add missing error code in init_mqueue_fs()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (5685a07f937f sparc64: NG4 memset 32 bits overflow)

--Sig_/Xb_YuUA9ALfcsUYsoJ/oSlz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqLi4kACgkQAVBC80lX
0Gw+wQf/YA8mYy2jdnDScejw7vRR8LPxoOuHRbyQbH5JVPDDjTUDoBAGcB3G0y9T
z+OmQba8PVsBt22bQY4n2Dr2OJmTQfvw4wIOi6MiPpkxvOlG+BWbqvKhsOdENvgn
kBUfR7EmUz8g/Wlam/fLL6C/93Jsr1HcW3KAhyj7Q80+qjeZTdC4NbzybW5xgLiR
hfDHdOokypsPDFUjgDDOWrkaNpSwpCHYQ+lFZ0fP1DtjIxQZmDWiHjg4sV7KVoxO
NYQBdO95HiPKhv+tgthj6ffIOmSnb0ysFHzq5Jsuuq7wfzX4K6v+o3/CpztUOFHM
oZvqQPKIbgsM4f5/67iMVe8FP9NYkw==
=1HqP
-----END PGP SIGNATURE-----

--Sig_/Xb_YuUA9ALfcsUYsoJ/oSlz--
