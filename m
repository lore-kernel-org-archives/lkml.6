Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932672AbeCEE3T (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 23:29:19 -0500
Received: from ozlabs.org ([103.22.144.67]:46635 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752225AbeCEE3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 23:29:13 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Date: Mon, 5 Mar 2018 15:28:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Mar 5
Message-ID: <20180305152856.09052758@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/U5eOiPSUoJf_=JgC4Z877oN"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/U5eOiPSUoJf_=JgC4Z877oN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180302:

The net-next tree gained a conflict against the net tree.

The sound-asoc tree lost its build failure.

The selinux tree gained a conflict against the net-next tree.

Non-merge commits (relative to Linus' tree): 4722
 5201 files changed, 199378 insertions(+), 136922 deletions(-)

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
Merging origin/master (e64b9562ba28 Merge branch 'x86/urgent' of git://git.=
kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/master (7928b2cbe55b Linux 4.16-rc1)
Merging kbuild-current/fixes (534ac8d2b4e6 Coccinelle: memdup: Fix typo in =
warning messages)
Merging arc-current/for-curr (a29a25275452 ARC: setup cpu possible mask acc=
ording to possible-cpus dts property)
Merging arm-current/fixes (091f02483df7 ARM: net: bpf: clarify tail_call in=
dex)
Merging arm64-fixes/for-next/fixes (b08e5fd90bfc arm_pmu: Use disable_irq_n=
osync when disabling SPI in CPU teardown hook)
Merging m68k-current/for-linus (2334b1ac1235 MAINTAINERS: Add NuBus subsyst=
em entry)
Merging metag-fixes/fixes (b884a190afce metag/usercopy: Add missing fixups)
Merging powerpc-fixes/fixes (eb0a2d2620ae powerpc/powernv: Support firmware=
 disable of RFI flush)
Merging sparc/master (aebb48f5e465 sparc64: fix typo in CONFIG_CRYPTO_DES_S=
PARC64 =3D> CONFIG_CRYPTO_CAMELLIA_SPARC64)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (4e00f5d5f9fc Merge tag 'batadv-net-for-davem-20180302' =
of git://git.open-mesh.org/linux-merge)
Merging bpf/master (d02f51cbcf12 bpf: fix bpf_skb_adjust_net/bpf_skb_proto_=
xlat to deal with gso sctp skbs)
Merging ipsec/master (b8b549eec818 xfrm: Fix ESN sequence number handling f=
or IPsec GSO packets.)
Merging netfilter/master (4e00f5d5f9fc Merge tag 'batadv-net-for-davem-2018=
0302' of git://git.open-mesh.org/linux-merge)
Merging ipvs/master (f7fb77fc1235 netfilter: nft_compat: check extension ho=
ok mask only if set)
Merging wireless-drivers/master (78dc897b7ee6 rtlwifi: rtl8723be: Fix loss =
of signal)
Merging mac80211/master (a78872363614 cfg80211: add missing dependency to C=
FG80211 suboptions)
Merging rdma-fixes/for-rc (4cd482c12be4 IB/core : Add null pointer check in=
 addr_resolve)
Merging sound-current/for-linus (d5078193e56b ALSA: hda - Fix a wrong FIXUP=
 for alc289 on Dell machines)
Merging pci-current/for-linus (c37406e05d1e PCI: Allow release of resources=
 that were never assigned)
Merging driver-core.current/driver-core-linus (4a3928c6f8a5 Linux 4.16-rc3)
Merging tty.current/tty-linus (5d7f77ec72d1 serial: imx: fix bogus dev_err)
Merging usb.current/usb-linus (4a3928c6f8a5 Linux 4.16-rc3)
Merging usb-gadget-fixes/fixes (98112041bcca usb: dwc3: core: Fix ULPI PHYs=
 and prevent phy_get/ulpi_init during suspend/resume)
Merging usb-serial-fixes/usb-linus (0a17f9fef994 USB: serial: ftdi_sio: add=
 RT Systems VX-8 cable)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging staging.current/staging-linus (cb57469c9573 staging: android: ashme=
m: Fix lockdep issue during llseek)
Merging char-misc.current/char-misc-linus (4a3928c6f8a5 Linux 4.16-rc3)
Merging input-current/for-linus (ea4f7bd2aca9 Input: matrix_keypad - fix ra=
ce when disabling interrupts)
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
Merging v4l-dvb-fixes/fixes (7dbdd16a79a9 media: vb2: Makefile: place vb2-t=
race together with vb2-core)
Merging reset-fixes/reset/fixes (f450f28e70a2 reset: socfpga: fix for 64-bi=
t compilation)
Merging mips-fixes/mips-fixes (fde9fc766e96 signals: Move put_compat_sigset=
 to compat.h to silence hardened usercopy)
Merging kvm-fixes/master (b7e31be38558 KVM: x86: fix vcpu initialization wi=
th userspace lapic)
Merging kvms390-fixes/master (0e7def5fb0dc KVM: s390: provide only a single=
 function for setting the tod (fix SCK))
Merging drm-intel-fixes/for-linux-next-fixes (fa89782b4f9c drm/i915: Make g=
lobal seqno known in i915_gem_request_execute tracepoint)
Merging drm-misc-fixes/for-linux-next-fixes (f3e5feeb92a1 drm/sun4i: Releas=
e exclusive clock lock when disabling TCON)
Merging kbuild/for-next (4ae9e45af41d Merge branch 'kconfig' into for-next)
Merging leaks/leaks-next (9db33987ee2e leaking_addresses: remove version nu=
mber)
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
Merging arm-soc/for-next (8f148f32926c Merge tag 'arm-soc/for-4.16/drivers-=
fixes' of https://github.com/Broadcom/stblinux into fixes)
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into ne=
xt)
Merging alpine/alpine/for-next (a1144b2b1ec4 ARM: dts: alpine: add valid cl=
ock-frequency values)
Merging amlogic/for-next (b1303f3fa73b Merge branch 'v4.17/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (91b55cc53a17 Merge branch 'dt-for-4.17' into for-n=
ext)
Merging at91/at91-next (dc39260ac782 Merge branch 'at91-soc' of ssh://gitol=
ite.kernel.org/pub/scm/linux/kernel/git/abelloni/linux into at91-next)
Merging bcm2835/for-next (f0b8461e980a Merge branch anholt/bcm2835-defconfi=
g-next into for-next)
Merging imx-mxs/for-next (ba160a451a62 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a29b8b93e158 Merge branch 'for_4.16/keystone-config'=
 into next)
Merging mvebu/for-next (ffd4accd76bb Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (3948d765f8a2 Merge branch 'omap-for-v4.17/dt' into f=
or-next)
Merging reset/reset/next (940821732839 reset: add support for non-DT system=
s)
Merging qcom/for-next (f5788d2f2929 Merge tag 'qcom-arm64-defconfig-for-4.1=
6' into tagged-for-4.16)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (98380de154e1 Merge branch 'arm64-dt-for-v4.17' into n=
ext)
Merging rockchip/for-next (e49afc797ca5 Merge branch 'v4.17-clk/next' into =
for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (0d9fb4e4feb3 Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (c65610a7ed69 Merge branches 'sunxi/h3-h5-for-=
4.17' and 'sunxi/clk-for-4.17' into sunxi/for-next)
Merging tegra/for-next (983371acdeda Merge branch for-4.16/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (3a0a397ff5ff arm64: Kill PSCI_GET_VERSION as a=
 variant-2 workaround)
Merging clk/clk-next (7928b2cbe55b Linux 4.16-rc1)
Merging clk-samsung/for-next (1d5013f1b64d clk: samsung: Add compile time P=
LL rate validators)
Merging c6x/for-linux-next (9d440f7a2824 c6x: fix platforms/plldata.c get_c=
oreid build error)
Merging cris/for-next (fd989db807a0 cris: Fix conflicting types for _etext,=
 _edata, _end)
Merging m68k/for-next (018bb90d5043 m68k/time: Stop validating rtc_time in =
.read_time)
Merging m68knommu/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging metag/for-next (ef9fb83815db i2c: img-scb: Drop METAG dependency)
Merging microblaze/next (9bf63916cb9d microblaze: Setup dependencies for AS=
M optimized lib functions)
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-fea=
tures' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (35868f095948 MIPS: generic: Enable crc32-mips=
 on r6 configs)
Merging nds32/next (f78cbbe68e2b nios2: add ioremap_nocache declaration bef=
ore include asm-generic/io.h.)
Merging nios2/for-next (e0691ebb33c1 nios2: defconfig: Cleanup from old Kco=
nfig options)
Merging openrisc/for-next (0fedb7653af7 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (72e8504320c5 parisc: Move various functions and=
 strings to init section)
Merging powerpc/next (4a3928c6f8a5 Linux 4.16-rc3)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (4a3928c6f8a5 Linux 4.16-rc3)
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
Merging btrfs-kdave/for-next (9ea9be899a66 Merge branch 'for-next-next-v4.1=
7-20180302' into for-next-20180302)
Merging ceph/master (1c7892495788 ceph: fix potential memory leak in init_c=
aches())
Merging cifs/for-next (13b8cb522ed3 [SMB3] fix smb3-encryption breakage whe=
n CONFIG_DEBUG_SG=3Dy)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (4670269faba7 eCryptfs: constify attribute_group stru=
ctures.)
Merging ext3/for_next (785dffe1daf9 udf: fix potential refcnt problem of nl=
s module)
Merging ext4/dev (5dc397113d19 ext4: create ext4_kset dynamically)
Merging f2fs/dev (3664ce2d9309 Merge tag 'powerpc-4.16-4' of git://git.kern=
el.org/pub/scm/linux/kernel/git/powerpc/linux)
Merging fuse/for-next (c6cdd51404b7 fuse: fix READDIRPLUS skipping an entry)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (5fbdefcf685d Merge branch 'parisc-4.16-1' of git://=
git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux)
Merging nfs-anna/linux-next (c54c14ba000d xprtrdma: Spread reply processing=
 over more CPUs)
CONFLICT (content): Merge conflict in net/sunrpc/xprtrdma/transport.c
CONFLICT (content): Merge conflict in net/sunrpc/xprt.c
Merging nfsd/nfsd-next (219cd595cc46 lockd: make nlm_ntf_refcnt and nlm_ntf=
_wq static)
Merging orangefs/for-next (74e938c22705 orangefs: reverse sense of is-inode=
-stale test in d_revalidate)
Merging overlayfs/overlayfs-next (d1fe96c0e4de ovl: redirect_dir=3Dnofollow=
 should not follow redirect for opaque lower)
Merging ubifs/linux-next (7f29ae9f977b ubi: block: Fix locking for idr_allo=
c/idr_remove)
Merging xfs/for-next (ff3d8b9c4cb9 xfs: don't block on the ilock for RWF_NO=
WAIT)
Merging file-locks/locks-next (1deab8ce2c91 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/sparc)
Merging vfs/for-next (d85e2aa2e34d annotate ep_scan_ready_list())
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging iversion/iversion-next (581e400ff935 Merge tag 'modules-for-v4.16' =
of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux)
Merging printk/for-next (1230eb711420 Merge branch 'for-4.17' into for-next)
Merging pci/next (612468a27d3b Merge remote-tracking branch 'lorenzo/pci/xg=
ene' into next)
Merging pstore/for-next/pstore (a99f41a1b441 fs: pstore: remove unused hard=
irq.h)
Merging hid/for-next (ba6986149ce3 Merge branch 'for-4.16/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (371b9546b966 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging dmi/master (4a3928c6f8a5 Linux 4.16-rc3)
Merging hwmon-staging/hwmon-next (e464243586cb hwmon: (sht3x) Update data s=
heet URL)
Merging jc_docs/docs-next (c7899551ff3a Documentation: rapidio: move sysfs =
interface to ABI)
Merging v4l-dvb/master (e3e389f931a1 media: rc: fix race condition in ir_ra=
w_event_store_edge() handling)
Merging v4l-dvb-next/master (a1dfb4c48cc1 media: v4l2-compat-ioctl32.c: ref=
actor compat ioctl32 logic)
Merging fbdev/fbdev-for-next (5865889fe431 video: udlfb: Switch from the pr=
_*() to the dev_*() logging functions)
Merging pm/linux-next (981020918bad Merge branch 'pm-cpufreq' into linux-ne=
xt)
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
Merging net-next/master (413033149c65 Merge branch 'dsa-serdes-stats')
CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/test_veri=
fier.c
CONFLICT (content): Merge conflict in net/smc/smc_core.c
CONFLICT (content): Merge conflict in net/ipv6/netfilter/nft_fib_ipv6.c
CONFLICT (content): Merge conflict in net/ipv4/ip_tunnel.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/mellanox/mlxsw/s=
pectrum.c
Applying: devlink: merge fix up for resource_size_param changes
Merging bpf-next/master (c51a63797acc Merge branch 'bpf-bpftool-batch-impro=
vements')
Merging ipsec-next/master (5211fcfb8110 esp: check the NETIF_F_HW_ESP_TX_CS=
UM bit before segmenting)
Merging netfilter-next/master (efab163bbc19 tools: tc-testing: Add notap op=
tion)
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET su=
pport)
Merging ipvs-next/master (a910d20aa007 netfilter: ipvs: Fix space before '[=
' error.)
Merging wireless-drivers-next/master (fee05843801c mt7601u: make write with=
 mask access atomic)
Merging bluetooth/master (fe31f824652f Bluetooth: btmrvl: support sysfs ini=
tiated firmware coredump)
Merging mac80211-next/master (2e75bb2f8b89 net: Convert hwsim_net_ops)
Merging rdma/for-next (c33bab622d47 IB/rxe: Remove unused variable (char *r=
xe_qp_state_name[]))
Merging gfs2/for-next (9803255bc99c GFS2: Make function gfs2_remove_from_ai=
l static)
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
Merging crypto/master (23ea8b63a1e2 include: psp-sev: Capitalize invalid le=
ngth enum)
Merging drm/drm-next (f073d78eeb8e Merge tag 'drm-intel-next-2018-02-21' of=
 git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_breadcrumb=
s.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_pmu.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/hwmgr/s=
mu7_hwmgr.c
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (7b026763cff9 drm/i915/huc: Mark firmware =
as failed on auth failure)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_request.c
Merging drm-tegra/drm/tegra/for-next (8f62142e490d drm/tegra: dc: Properly =
cleanup overlay planes)
Merging drm-misc/for-linux-next (c8624ede3ed3 drm/i915: Add support for the=
 YCbCr COLOR_RANGE property)
Merging drm-msm/msm-next (b666c0f68f33 drm/msm: fix building without debugf=
s)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (54243016ae35 drm: mali-dp: Disable pl=
anes when their CRTC gets disabled.)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (4a3928c6f8a5 Linux 4.16-rc3)
Merging etnaviv/etnaviv/next (246774d17fc0 drm/etnaviv: remove the need for=
 a gpu-subsystem DT node)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (c5839736bb52 Merge remote-tracking branches 'regma=
p/topic/debugfs' and 'regmap/topic/mmio-clk' into regmap-next)
Merging sound/for-next (338e17d3f58e ALSA: ice1712: replace strcpy() with s=
trlcpy())
Merging sound-asoc/for-next (1c854e02a2e4 Merge remote-tracking branches 'a=
soc/topic/wm_adsp' and 'asoc/topic/zx_aud96p22' into asoc-next)
Merging modules/modules-next (0cad61d7a3d5 modpost: Remove trailing semicol=
on)
Merging input/next (cdc2466df40f Input: synaptics - handle errors from inpu=
t_mt_init_slots())
Merging block/for-next (f168127a96c5 Merge branch 'for-4.17/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (d69e3085be1d dm raid: fix incorrect sync_ra=
tio when degraded)
Merging mmc/next (f9efe3e94b1b mmc: sdhci-pci: Respect PM flags when enabli=
ng card detect GPIO IRQ wakeup)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (3de59bb9d551 md/raid1: fix NULL pointer dereference)
Merging mfd/for-mfd-next (0f89ffefa4e1 mfd: lpc_ich: Do not touch SPI-NOR w=
rite protection bit on Apollo Lake)
Merging backlight/for-backlight-next (cfce992766ff Merge branch 'ib-backlig=
ht-drm-4.17' into ibs-for-backlight-merged)
Merging battery/for-next (416a1ae673db power: supply: gpio-charger: use hel=
per variable to access device info)
Merging regulator/for-next (679140947200 Merge remote-tracking branches 're=
gulator/topic/coupled', 'regulator/topic/dt' and 'regulator/topic/gpio' int=
o regulator-next)
Merging security/next-testing (a58e3226e2e4 Merge tag 'v4.16-rc2' into next=
-testing)
Merging integrity/next-integrity (5f26b1bddb4a IMA: Support using new creds=
 in appraisal policy)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (68741a8adab9 selinux: Fix ltp test connect-syscall fa=
ilure)
CONFLICT (content): Merge conflict in net/sctp/socket.c
Merging tpmdd/next (895fbcaba75d tpm_tis: fix potential buffer overruns cau=
sed by bit glitches on the bus)
Merging watchdog/master (755ae8427820 watchdog: hpwdt: Update driver versio=
n.)
Merging iommu/next (18b3c16e25fb Merge branches 'x86/amd', 'x86/vt-d', 'arm=
/mediatek', 'arm/exynos' and 'core' into next)
Merging dwmw2-iommu/master (910170442944 iommu/vt-d: Fix PASID table alloca=
tion)
Merging vfio/next (46ed90f157f4 vfio: mdev: make a couple of functions and =
structure vfio_mdev_driver static)
Merging trivial/for-next (1972d6c0c86d MAINTAINERS: relinquish kconfig)
Merging audit/next (ce423631ce1f audit: track the owner of the command mute=
x ourselves)
Merging devicetree/for-next (7ea5c83472d3 Merge branches 'dt/next' and 'dt/=
linus' into for-next)
Merging mailbox/mailbox-for-next (0ae7d327a64b dt-bindings: mailbox: qcom: =
Document the APCS clock binding)
Merging spi/for-next (0896f481fb4a Merge remote-tracking branch 'spi/topic/=
pxa2xx' into spi-next)
Merging tip/auto-latest (5fe8ab055d6d Merge branch 'WIP.sched/core')
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
Merging rcu/rcu/next (db7e9d236672 torture: Fold parse-torture.sh into pars=
e-console.sh)
Merging kvm/linux-next (7928b2cbe55b Linux 4.16-rc1)
Merging kvm-arm/next (250be9d61cf8 KVM: arm/arm64: No need to zero CNTVOFF =
in kvm_timer_vcpu_put() for VHE)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (7928b2cbe55b Linux 4.16-rc1)
Merging kvms390/next (0278c630103d s390/setup : enable display support for =
KVM guest)
CONFLICT (content): Merge conflict in drivers/video/console/Kconfig
Merging xen-tip/linux-next (d811bcee1f7a pvcalls-front: 64-bit align flags)
Merging percpu/for-next (accd4f36a7d1 percpu: add a schedule point in pcpu_=
balance_workfn())
Applying: percpu: include sched.h for cond_resched()
Merging workqueues/for-next (a10eb37ccf1d Merge branch 'for-4.15-fixes' int=
o for-next)
Merging drivers-x86/for-next (501f7e52de8a platform/x86: wmi: Fix misuse of=
 vsprintf extension %pULL)
Merging chrome-platform/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging hsi/for-next (b6dc80dbe6cd HSI: cmt_speech: use timespec64 instead =
of timespec)
Merging leds/for-next (2dd1ea5b8a49 leds: Add more product/board names for =
PC Engines APU2)
Merging ipmi/for-next (9df1007fb473 ipmi: use ARRAY_SIZE for poweroff_funct=
ions array sizing calculation)
Merging driver-core/driver-core-next (4a3928c6f8a5 Linux 4.16-rc3)
Merging usb/usb-next (134d1fd44221 Merge 4.16-rc3 into usb-next)
Merging usb-gadget/next (8ada211d0383 usb: renesas_usbhs: add extcon notifi=
er to set mode for non-otg channel)
Merging usb-serial/usb-next (4a3928c6f8a5 Linux 4.16-rc3)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx:=
 Fix ULPI on imx53)
Merging phy-next/next (1f846be367fb phy: allwinner: sun4i-usb: poll vbus ch=
anges on A23/A33 when driving VBUS)
Merging tty/tty-next (6aed2a885041 serial: imx: document functions that are=
 called with port.lock taken)
Merging char-misc/char-misc-next (4a3928c6f8a5 Linux 4.16-rc3)
Merging extcon/extcon-next (9fdb930deceb extcon: gpio: Convert to fully use=
 GPIO descriptor)
Merging staging/staging-next (d8c85d238d6b staging: fsl-mc: Cleanup dpbp an=
d dpcon API)
Merging mux/for-next (fa934c06c0f4 mux: add mux_control_get_optional() API)
Merging slave-dma/next (33ea7627a9be Merge branch 'topic/qcom' into next)
Merging cgroup/for-next (d1897c9538ed cgroup: fix rule checking for threade=
d mode switching)
Merging scsi/for-next (046e9e78b709 Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (18d595bf9de9 scsi: sd: Documentation: add sd-par=
ameters.txt)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (20a26a6b8848 Merge branch 'for-4.16-fixes' into fo=
r-next)
Merging vhost/linux-next (4d1cf217d2cd ptr_ring: linked list fallback)
Merging rpmsg/for-next (ec6e69036956 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (e5dc4c2e6715 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (76adc6a2fd83 Merge branch 'devel' into for-next)
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
Merging rtc/rtc-next (7952587cd881 rtc: isl12026: fixup nvmem registration)
Merging nvdimm/libnvdimm-for-next (949b93250a56 memremap: fix softlockup re=
ports at teardown)
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in L=
DFLAGS too)
Merging at24/at24/for-next (56868c9b7e33 dt-bindings: at24: add Renesas R1E=
X24128)
Merging ntb/ntb-next (53c3677c56c7 ntb: intel: change references of skx to =
gen3)
Merging kspp/for-next/kspp (2d00fcb32f71 Merge branch 'kspp/gcc-plugin/infr=
astructure' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging akpm-current/current (9ec53107cdd9 ipc: clamp msgmni and shmmni to =
the real IPC_MNI limit)
CONFLICT (content): Merge conflict in fs/notify/inotify/inotify_fsnotify.c
CONFLICT (content): Merge conflict in fs/notify/fanotify/fanotify_user.c
CONFLICT (content): Merge conflict in fs/notify/fanotify/fanotify.h
CONFLICT (content): Merge conflict in fs/notify/fanotify/fanotify.c
CONFLICT (modify/delete): arch/metag/kernel/process.c deleted in HEAD and m=
odified in akpm-current/current. Version akpm-current/current of arch/metag=
/kernel/process.c left in tree.
$ git rm -f arch/metag/kernel/process.c
Applying: KEYS: include vmalloc.h for vmap etc
$ git checkout -b akpm remotes/origin/akpm/master
Applying: ipc/mqueue: add missing error code in init_mqueue_fs()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (3789f213fa84 sparc64: NG4 memset 32 bits overflow)

--Sig_/U5eOiPSUoJf_=JgC4Z877oN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlqcx4gACgkQAVBC80lX
0GzkxQf8DsW7AX3LGuE3vojgY+JlIe0kMFl79PWnJsqHxACCOcij9Ylcn7C+73Gd
pyzji3pLpUa1OVAzYdVCvSKUnHoK8oW1voQSWTghXn5jrlZlFI3/PQkp4EjE6Zs9
JKm7N2KXnxyM4+mIxjCP3bsjVWnnffDRXgUd0Rf1LKyR0V0eZYce+fPAJhQWY/rJ
6GxnkHOnVVhLKvt7PTaKvoMlN3fJ2E987Il9pYHPg4JjC5jYZxwxUQzLTPnJj//G
CbR0NElu22gqnloimkXAoDQORxzgaDgXtFeZTwZorjYYXNbuUkdBwztgpfPlDCqQ
a7iIpW8N3dkQtVwNNdL03MjcBoEflg==
=6vM9
-----END PGP SIGNATURE-----

--Sig_/U5eOiPSUoJf_=JgC4Z877oN--
