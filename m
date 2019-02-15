Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8A6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D94B820449
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 06:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="iU7zhXEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbfBOGD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:03:56 -0500
Received: from ozlabs.org ([203.11.71.1]:48437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfBOGDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 01:03:55 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4412kq4JF4z9s5c;
        Fri, 15 Feb 2019 17:03:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550210628;
        bh=c7b2u1bFO4cszf7uy4UnCgejeoXAYSwexuknQtyyfRw=;
        h=Date:From:To:Cc:Subject:From;
        b=iU7zhXEuHVppROxYAfIqvopTvBApVWSKuWoNV9tXul7cK06+swK+NK2DTuLsfs9Zr
         XdSHTtxgvC6ZhO701pDXfgmHXYm4A9kiTJiA8OpiAhCG0l2olS9125x9DwvJ/0XBhH
         3Ig21gDTMnuXjTsAjMxOTkjtgoBRUDNkKCIfzf7XGQ/VJEwJLx6M1VL56MG2Vg/gfn
         pGzjxJVZN+vTe/Xajxo4HV/N0dLb0d8925RMVGmNjluiXj9vs6bGHmbsa7zLZbPWuM
         cSkhWD3gMhlqFeyQZaofjlpQ5P59bUelqhBTxlO0fMXnycKXTfKndfm7vE0gwhRPWL
         MQLsPjM1eCrEg==
Date:   Fri, 15 Feb 2019 17:03:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 15
Message-ID: <20190215170342.1b704e7c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/X0rCEPFSh2nq+pDxagOja0T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X0rCEPFSh2nq+pDxagOja0T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190214:

The tip tree gained a conflict against the net-next tree.

The akpm tree lost a patch that turned up elsewhere,

Non-merge commits (relative to Linus' tree): 7981
 8238 files changed, 332149 insertions(+), 195576 deletions(-)

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

I am currently merging 296 trees (counting Linus' and 69 trees of bug
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
Merging origin/master (23e93c9b2cde Revert "gfs2: read journal in large chu=
nks to locate the head")
Merging fixes/master (0dd62c042779 x86/syscalls: Mark expected switch fall-=
throughs)
Merging kbuild-current/fixes (207a369e3c08 sh: fix build error for invisibl=
e CONFIG_BUILTIN_DTB_SOURCE)
Merging arc-current/for-curr (7e9246a982a6 ARCv2: support manual regfile sa=
ve on interrupts)
Merging arm-current/fixes (fc67e6f120a3 ARM: 8835/1: dma-mapping: Clear DMA=
 ops on teardown)
Merging arm64-fixes/for-next/fixes (ea5736805190 arm64: kexec_file: handle =
empty command-line)
Merging m68k-current/for-linus (bed1369f5190 m68k: Fix memblock-related cra=
shes)
Merging powerpc-fixes/fixes (5a3840a470c4 powerpc/papr_scm: Use the correct=
 bind address)
Merging sparc/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (f9bcc9f3ee4f net: ethernet: freescale: set FEC ethtool =
regs version)
Merging bpf/master (1e405c1a3f66 xsk: do not remove umem from netdevice on =
fall-back to copy-mode)
Merging ipsec/master (fc2d5cfdcfe2 af_key: unconditionally clone on broadca=
st)
Merging netfilter/master (8d6ea932856c net: dsa: bcm_sf2: potential array o=
verflow in bcm_sf2_sw_suspend())
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (d04ca383860b mt76x0u: fix suspend/resume)
Merging mac80211/master (6157ca0d6bfe mac80211: Fix Tx aggregation session =
tear down with ITXQs)
Merging rdma-fixes/for-rc (48396e80fb65 RDMA/srp: Rework SCSI device reset =
handling)
Merging sound-current/for-linus (c8c6ee611926 ALSA: hda/realtek: Disable PC=
 beep in passthrough on alc285)
Merging sound-asoc-fixes/for-linus (585c8c9bcc7c Merge branch 'asoc-5.0' in=
to asoc-linus)
Merging regmap-fixes/for-linus (f17b5f06cb92 Linux 5.0-rc4)
Merging regulator-fixes/for-linus (4b70f636189b Merge branch 'regulator-5.0=
' into regulator-linus)
Merging spi-fixes/for-linus (e7f77d1a86f2 Merge branch 'spi-5.0' into spi-l=
inus)
Merging pci-current/for-linus (f57a98e1b713 PCI: Work around Synopsys dupli=
cate Device ID (HAPS USB3, NXP i.MX))
Merging driver-core.current/driver-core-linus (d13937116f1e Linux 5.0-rc6)
Merging tty.current/tty-linus (d13937116f1e Linux 5.0-rc6)
Merging usb.current/usb-linus (d13937116f1e Linux 5.0-rc6)
Merging usb-gadget-fixes/fixes (a53469a68eb8 usb: phy: am335x: fix race con=
dition in _probe)
Merging usb-serial-fixes/usb-linus (dd9d3d86b08d USB: serial: cp210x: add I=
D for Ingenico 3070)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (827cb0323928 phy: ath79-usb: Fix the main reset name to =
match the DT binding)
Merging staging.current/staging-linus (d13937116f1e Linux 5.0-rc6)
Merging char-misc.current/char-misc-linus (d13937116f1e Linux 5.0-rc6)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (d13937116f1e Linux 5.0-rc6)
Merging input-current/for-linus (f420c54e4b12 Revert "Input: elan_i2c - add=
 ACPI ID for touchpad in ASUS Aspire F5-573G")
Merging crypto-current/master (1358c13a48c4 crypto: ccree - fix resume race=
 condition on init)
Merging ide/master (adf040ddd001 ide: Use of_node_name_eq for node name com=
parisons)
Merging vfio-fixes/for-linus (9a71ac7e15a7 vfio-pci/nvlink2: Fix ancient gc=
c warnings)
Merging kselftest-fixes/fixes (7d4e591bc051 selftests: timers: use LDLIBS i=
nstead of LDFLAGS)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (d13937116f1e Linux 5.0-rc6)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (3e35730dd754 mtd: powernv_flash: Fix device regis=
tration error)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (240809ef6630 media: vim2m: only cancel work if=
 it is for right context)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (74f03104ed46 MIPS: lantiq: pass struct devic=
e to DMA API functions)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
Merging omap-fixes/fixes (dc30e7039137 ARM: OMAP2+: Variable "reg" in funct=
ion omap4_dsi_mux_pads() could be uninitialized)
Merging kvm-fixes/master (98ae70cc476e kvm: vmx: Fix entry number check for=
 add_atomic_switch_msr())
Merging kvms390-fixes/master (b10bd9a256ae s390: vsie: Use effective CRYCBD=
.31 to check CRYCBD validity)
Merging hwmon-fixes/hwmon (2a2ec4aa0577 hwmon: (nct6775) Fix fan6 detection=
 for NCT6793D)
Merging nvdimm-fixes/libnvdimm-fixes (11189c1089da acpi/nfit: Fix command-s=
upported detection)
Merging btrfs-fixes/next-fixes (8834f5600cf3 Linux 5.0-rc5)
Merging vfs-fixes/fixes (fbdb44013202 copy_mount_string: Limit string lengt=
h to PATH_MAX)
Merging dma-mapping-fixes/for-linus (60d8cd572f65 arm64/xen: fix xen-swiotl=
b cache flushing)
Merging i3c-fixes/master (f36c1f9a8dfd i3c: master: dw: fix deadlock)
Merging drivers-x86-fixes/fixes (6a730fcb9cb4 Documentation/ABI: Correct ml=
xreg-io KernelVersion for 5.0)
Merging samsung-krzk-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (388a49959ee4 scsi: qla2xxx: Fix panic from use af=
ter free in qla2x00_async_tm_cmd)
Merging drm-fixes/drm-fixes (cd4c5a487410 Merge tag 'imx-drm-fixes-2019-02-=
12' of git://git.pengutronix.de/pza/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (16eb0f34cdf4 drm/i915/opregio=
n: rvda is relative from opregion base in opregion 2.1+)
Merging mmc-fixes/fixes (83e418a805d8 mmc: meson-gx: fix interrupt name)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (52d3b4949192 hv_netvsc: fix typos in cod=
e comments)
Merging drm-misc-fixes/for-linux-next-fixes (25dc194b34dd drm: Block fb cha=
nges for async plane updates)
Merging kbuild/for-next (a377885461a3 Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (14964fafc811 include/linux=
/module.h: copy __init/__exit attrs to init/cleanup_module)
Merging leaks/leaks-next (982ef2f7ef0a leaking_addresses: Completely remove=
 --version flag)
Merging dma-mapping/for-next (dc2acded3895 dma-mapping: add a kconfig symbo=
l for arch_teardown_dma_ops availability)
Merging asm-generic/master (2b3c5a99d5f3 sh: generate uapi header and sysca=
ll table header files)
Merging arc/for-next (8834f5600cf3 Linux 5.0-rc5)
Merging arm/for-next (d25495e864b9 Merge branches 'fixes', 'misc' and 'smp-=
hotplug' into for-next)
Merging arm64/for-next/core (a80554fc36ba arm64: irqflags: Fix clang build =
warnings)
Merging arm-perf/for-next/perf (cf2d65ec1d21 perf: xgene: Remove set but no=
t used variable 'config')
Merging arm-soc/for-next (06f885da38ae soc: document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (9124db5b4f7c Merge branch 'v5.1/drivers' into tmp=
/aml-rebuild)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (3850dd7a32a0 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (fe0b295f61af Merge branch 'imx/maintainers' into =
for-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (d542127adb0c Merge branch 'v5.0-next/soc' into f=
or-next)
Merging mvebu/for-next (acb05f82fd4e Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (1c84ede3a262 Merge branch 'omap-for-v5.1/dt' into fo=
r-next)
Merging reset/reset/next (dbfc54534dfc dt-bindings: reset: meson: add g12a =
bindings)
Merging qcom/for-next (a863a95f2c78 Merge branch 'dts-for-5.1' into all-for=
-5.1)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/qcom-ipq4019.dtsi
Merging renesas/next (817697a462a4 Merge branches 'fixes-for-v5.0', 'arm-de=
fconfig-for-v5.1', 'arm-dt-for-v5.1', 'arm-soc-for-v5.1', 'arm64-dt-for-v5.=
1', 'arm64-defconfig-for-v5.1' and 'dt-bindings-for-v5.1' into next)
Merging rockchip/for-next (21123b35a4e8 Merge branch 'v5.1-armsoc/dts64' in=
to for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (13427eabb93f Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (1fc3dc289134 Merge remote-tracking branches '=
korg/sunxi/sunxi/dt-for-5.1', 'korg/sunxi/sunxi/dt64-for-5.1' and 'korg/sun=
xi/sunxi/h3-h5-for-5.1' into sunxi/for-next)
Merging tegra/for-next (d92dde4f12f1 Merge branch for-5.1/fixes into for-ne=
xt)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging clk/clk-next (85f0e880e157 Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (81faa30df9b6 clk: samsung: exynos5433: Add se=
lected IMEM clocks)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (131aee8b9807 csky: Fixup dead loop in show_stack)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (28713169d879 m68k: Add -ffreestanding to CFLAGS)
Merging m68knommu/for-next (8461023b52ba m68k: add ColdFire mcf5441x eDMA p=
latform support)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (63f7541ce562 MIPS: BCM47XX: Fix/improve Buffalo WHR=
-G54S support)
CONFLICT (content): Merge conflict in arch/mips/include/asm/pgtable.h
CONFLICT (content): Merge conflict in arch/mips/include/asm/barrier.h
Merging nds32/next (bfeffd155283 Linux 5.0-rc1)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (0b9a52de6874 parisc: Add constants for various =
PDC firmware calls)
Merging powerpc/next (b174b4fb919d powerpc/powernv: Escalate reset when IOD=
A reset fails)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (dd81c8ab819d riscv: use for_each_of_cpu_node itera=
tor)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (058a78515d12 s390/jump_label: Use "jdd" constraint o=
n gcc9)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (940b241d9050 um: Remove obsolete reenable_XX calls)
Merging xtensa/xtensa-for-next (036ef74b3ecb Merge branch 'xtensa-5.1' into=
 xtensa-for-next)
Merging fscrypt/master (f5e55e777cc9 fscrypt: return -EXDEV for incompatibl=
e rename or link into encrypted dir)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (e9804fdaabc5 Merge branch 'for-next-next-v5.0=
-20190213' into for-next-20190213)
Merging ceph/master (1a0fef353593 libceph: handle an empty authorize reply)
Merging cifs/for-next (8bf7b129ab4d cifs: update internal module version nu=
mber)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (4bd0d38cd22a Pull fanotify compilation fix.)
Merging ext4/dev (191ce17876c9 ext4: fix special inode number checks in __e=
xt4_iget())
Merging f2fs/dev (6afbeef75215 f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG)
Merging fuse/for-next (fabf7e0262d0 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (1f947a7a011f Merge branch 'akpm' (patches from Andr=
ew))
Merging nfs-anna/linux-next (bf827d445a47 NFS: Pass error information to th=
e pgio error cleanup routine)
Merging nfsd/nfsd-next (8820bcaa5bd7 svcrdma: Remove syslog warnings in wor=
k completion handlers)
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (993a0b2aec52 ovl: Do not lose security.ca=
pability xattr over metadata file copy-up)
Merging ubifs/linux-next (e58725d51fa8 ubifs: Handle re-linking of inodes c=
orrectly while recovery)
Merging v9fs/9p-next (3bbe8b1a4ae9 9p: mark expected switch fall-through)
Merging xfs/for-next (670105de15cd xfs: compile time offset checks for comm=
on v4/v5 metadata)
Merging file-locks/locks-next (bf77ae4c98d7 locks: fix error in locks_move_=
blocks())
Merging vfs/for-next (b59b26d1f597 Merge branches 'work.mount', 'work.misc'=
 and 'work.iov_iter' into for-next)
CONFLICT (content): Merge conflict in fs/Makefile
Merging printk/for-next (15ff2069cb7f printk: Add caller information to pri=
ntk() output.)
Merging pci/next (cc051d51a4af Merge branch 'remotes/lorenzo/pci/vmd')
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (94b5b50420de Merge branch 'for-5.1/hid-logitech' into=
 for-next)
Merging i2c/i2c/for-next (c604d35a36f0 Merge branch 'i2c/for-5.1' into i2c/=
for-next)
Merging i3c/i3c/next (25ac3da61ba1 i3c: master: cdns: fix I2C transfers in =
Cadence I3C master driver)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (2a22ffc98997 hwmon: (f71882fg) Mark expec=
ted switch fall-through)
Merging jc_docs/docs-next (db693aded3fb doc:dmaengine: clarify DMA desc. po=
inter after submission)
Merging v4l-dvb/master (6fd369dd1cb6 media: vimc: fill in bus_info in media=
_device_info)
CONFLICT (content): Merge conflict in drivers/media/platform/vim2m.c
Merging v4l-dvb-next/master (76097fe1aee6 media: staging/ipu3-imgu: Add MAI=
NTAINERS entry)
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3-v4l2.c
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3-css.c
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/include/in=
tel-ipu3.h
CONFLICT (add/add): Merge conflict in Documentation/media/v4l-drivers/ipu3.=
rst
CONFLICT (add/add): Merge conflict in Documentation/media/uapi/v4l/pixfmt-m=
eta-intel-ipu3.rst
Merging fbdev/fbdev-for-next (f40298444e8c video: fbdev: Fix potential NULL=
 pointer dereference)
Merging pm/linux-next (580a746702bd Merge branch 'pm-core' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (af816ddfbdf0 Merge branch 'cpuf=
req/qcom-hw' into cpufreq/arm/linux-next)
Merging cpupower/cpupower (ae2917093fb6 tools/power/cpupower: Display boost=
 frequency separately)
Merging opp/opp/linux-next (a9a744dd5b82 cpufreq: OMAP: Register an Energy =
Model)
Merging thermal/next (f17b5f06cb92 Linux 5.0-rc4)
Merging thermal-soc/next (8834f5600cf3 Linux 5.0-rc5)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (8526e331c56f dlm: Fix test for -ERESTARTSYS)
Merging swiotlb/linux-next (60513ed06a41 swiotlb: checking whether swiotlb =
buffer is full with io_tlb_used)
Merging rdma/for-next (52a572e9f7d3 RDMA/nes: Use for_each_sg_dma_page iter=
ator for umem SGL)
Merging net-next/master (50f444aa50a4 sfc: ensure recovery after allocation=
 failures)
CONFLICT (content): Merge conflict in net/sched/cls_tcindex.c
CONFLICT (content): Merge conflict in net/ipv6/netfilter/nf_nat_l3proto_ipv=
6.c
CONFLICT (content): Merge conflict in net/ipv4/netfilter/nf_nat_l3proto_ipv=
4.c
Merging bpf-next/master (9875964b9e84 Merge branch 'libbpf-cleanup')
CONFLICT (content): Merge conflict in kernel/bpf/verifier.c
Merging ipsec-next/master (590ce401c207 dt-bindings: net: dsa: ksz9477: fix=
 indentation for switch spi bindings)
Merging mlx5-next/mlx5-next (224d71ccc07c net/mlx5: Align ODP capability fu=
nction with netdev coding style)
Merging netfilter-next/master (7fc38225363d netfilter: reject: skip csum ve=
rification for protocols that don't support it)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (34025a1056a3 rsi: fix indentation iss=
ue with a code block)
Merging bluetooth/master (e20a2e9c42c9 Bluetooth: Fix decrementing referenc=
e count twice in releasing socket)
Merging mac80211-next/master (f440b125450d virt_wifi: Remove REGULATORY_WIP=
HY_SELF_MANAGED)
Merging gfs2/for-next (2abbf9a4d262 gfs: no need to check return value of d=
ebugfs_create functions)
Merging mtd/mtd/next (b0dd77a79642 mtd: docg3: fix a possible memory leak o=
f mtd->name)
Merging nand/nand/next (53bcbb839438 mtd: rawnand: denali_dt: remove single=
 anonymous clock support)
Merging spi-nor/spi-nor/next (2cc788387497 mtd: spi-nor: cadence-quadspi: A=
dd support for Octal SPI controller)
Merging crypto/master (920d7f7215d8 crypto: qat - Remove unused goto label)
Merging drm/drm-next (8d451a4b6e9f Merge tag 'drm-misc-next-2019-02-11' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_debugfs.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/modules/p=
ower/power_helpers.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dc_str=
eam.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdkfd/kfd_crat.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
Merging drm-intel/for-linux-next (8d451a4b6e9f Merge tag 'drm-misc-next-201=
9-02-11' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-tegra/drm/tegra/for-next (79930bafe280 gpu: host1x: Continue CD=
MA execution starting with a next job)
Merging drm-misc/for-linux-next (37406a60fac7 drm: Merge __drm_atomic_helpe=
r_disable_all() into drm_atomic_helper_disable_all())
Merging drm-msm/msm-next (b6bd458c16ac MAINTAINERS: update entry for drm/ms=
m)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (dcc9d76b6d83 drm/komeda: Off by one i=
n komeda_fb_get_pixel_addr())
Merging imx-drm/imx-drm/next (e4a2457f459b drm/imx: only send commit done e=
vent when all state has been applied)
Merging etnaviv/etnaviv/next (9e05352340d3 drm/etnaviv: potential NULL dere=
ference)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (66fb181d6f82 Merge remote-tracking branch 'regmap/=
topic/irq' into regmap-next)
Merging sound/for-next (a06702ca023f ALSA: es1688: Remove set but not used =
variable 'hw')
Merging sound-asoc/for-next (126a6205a578 Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (460f54f0f670 Merge branch 'for-linus' into next)
Merging block/for-next (15e4d31ca305 Merge branch 'io_uring' into for-next)
Merging device-mapper/for-next (4ae280b4ee34 dm thin: fix bug where bio tha=
t overwrites thin block ignores FUA)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (a1b458bca74a mmc: sdhci-xenon: Fixup already marked switc=
h fall-through)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (c1778e5819a9 mfd: cros_ec_dev: Return number of b=
ytes read with CROS_EC_DEV_IOCRDMEM)
CONFLICT (content): Merge conflict in drivers/mfd/Kconfig
Merging backlight/for-backlight-next (cec2b18832e2 backlight: pwm_bl: Use g=
piod_get_value_cansleep() to get initial state)
Merging battery/for-next (74f0aaba7c71 power: supply: ds2782: fix possible =
use-after-free on remove)
Merging regulator/for-next (43ad960bb4ea Merge branch 'regulator-5.1' into =
regulator-next)
Merging security/next-testing (db9ed620ddea Merge branch 'next-integrity' i=
nto next-testing)
Merging apparmor/apparmor-next (df4d55f2e1b8 apparmor: fix double free when=
 unpack of secmark rules fails)
Merging integrity/next-integrity (e7fde070f39b evm: Use defined constant fo=
r UUID representation)
Merging selinux/next (45189a1998e0 selinux: fix avc audit messages)
Merging tpmdd/next (cfb1f7ee3b35 KEYS: trusted: fix -Wvarags warning)
Merging watchdog/master (59600d045ff4 dt-bindings: watchdog: renesas-wdt: D=
ocument r8a77470 support)
Merging iommu/next (f1fc9f79bf1a Merge branches 'arm/msm', 'arm/tegra', 'x8=
6/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (3c8d7ef89bb8 vfio: platform: reset: fix up include direc=
tives to remove ccflags-y)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (131d34cb0795 audit: mark expected switch fall-through)
Merging devicetree/for-next (fca9a2d382e2 of: mark early_init_dt_alloc_rese=
rved_memory_arch static)
CONFLICT (modify/delete): Documentation/devicetree/bindings/interrupt-contr=
oller/arm,gic-v3.txt deleted in devicetree/for-next and modified in HEAD. V=
ersion HEAD of Documentation/devicetree/bindings/interrupt-controller/arm,g=
ic-v3.txt left in tree.
$ git rm -f Documentation/devicetree/bindings/interrupt-controller/arm,gic-=
v3.txt
Merging mailbox/mailbox-for-next (d69e11648e48 mailbox: tegra-hsp: Use devi=
ce-managed registration API)
Merging spi/for-next (f53f03bd3d12 Merge branch 'spi-5.1' into spi-next)
CONFLICT (modify/delete): arch/mips/ath79/dev-spi.h deleted in HEAD and mod=
ified in spi/for-next. Version spi/for-next of arch/mips/ath79/dev-spi.h le=
ft in tree.
$ git rm -f arch/mips/ath79/dev-spi.h
Merging tip/auto-latest (cb6988fee389 Merge branch 'core/rcu')
CONFLICT (content): Merge conflict in include/uapi/linux/time.h
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Applying: time: fix up for "y2038: remove struct definition redirects"
Merging clockevents/clockevents/next (7cd6dca3600d clocksource/drivers/arch=
_timer: Workaround for Allwinner A64 timer instability)
Merging edac-amd/for-next (cbfa482f7e2b EDAC, skx_common: Add code to recog=
nise new compound error code)
Merging irqchip/irq/irqchip-next (612c3a8d3dc1 irqchip: sifive-plic: Implem=
ent irq_set_affinity() for SMP host)
Merging ftrace/for-next (3d739c1f6156 tracing: Use the return of str_has_pr=
efix() to remove open coded numbers)
Merging rcu/rcu/next (e880edadc149 Merge LKMM and RCU)
Merging kvm/linux-next (bfeffd155283 Linux 5.0-rc1)
Merging kvm-arm/next (d35b8e91b2b1 arm64: KVM: Describe data or unified cac=
hes as having 1 set and 1 way)
CONFLICT (content): Merge conflict in arch/arm/include/asm/kvm_host.h
Merging kvm-ppc/kvm-ppc-next (ae59a7e1945b KVM: PPC: Book3S HV: Keep rc bit=
s in shadow pgtable in sync with host)
Merging kvms390/next (b9fa6d6ee9b8 KVM: s390: fix possible null pointer der=
eference in pending_irqs())
Merging xen-tip/linux-next (b023afc88bb0 xen-scsiback: mark expected switch=
 fall-through)
Merging percpu/for-next (718f6757a29b Merge branch 'for-4.21' into for-next)
Merging workqueues/for-next (4d43d395fed1 workqueue: Try to catch flush_wor=
k() without INIT_WORK().)
Merging drivers-x86/for-next (289790a3ea94 platform/x86: dell_rbu: stop abu=
sing the DMA API)
Merging chrome-platform/for-next (79c4ec4869b5 platform/chrome: wilco_ec: A=
dd RTC driver)
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (5ddb0869bfc1 leds: lp55xx: fix null deref on firmwar=
e load failure)
Merging ipmi/for-next (2b835103f84d ipmi: Use dedicated API for copying a U=
UID)
Merging driver-core/driver-core-next (1ea61b68d0f8 async: Add cmdline optio=
n to specify drivers to be async probed)
Merging usb/usb-next (c17c7cf147ac usb: typec: tcpm: Remove unused function=
s)
CONFLICT (content): Merge conflict in drivers/phy/marvell/Makefile
CONFLICT (content): Merge conflict in drivers/phy/marvell/Kconfig
Merging usb-gadget/next (5895d311d28f usb: phy: twl6030-usb: fix possible u=
se-after-free on remove)
Merging usb-serial/usb-next (85bc2d91e9f0 USB: serial: cp210x: add minimum =
baud rate for CP2105 SCI)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (203d9b11928c phy: qcom-qmp: Add QMP UFS PHY support =
for msm8998)
Merging tty/tty-next (361bf8a9d88d tty/n_hdlc: mark expected switch fall-th=
rough)
Merging char-misc/char-misc-next (36f30937922c binder: fix sparse issue in =
binder_alloc_selftest.c)
Merging extcon/extcon-next (3dfed89512d3 extcon: ptn5150: Fix return value =
check in ptn5150_i2c_probe())
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (d13937116f1e Linux 5.0-rc6)
Merging staging/staging-next (e7dd3d47bc72 staging: rtl8192e: rename functi=
on cpMacAddr to copy_mac_addr - style)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (72d282b59342 drm/msm/a6xx: Add support for an interco=
nnect path)
Merging slave-dma/next (95781b704e43 Merge branch 'for-linus' into next)
CONFLICT (content): Merge conflict in drivers/dma/imx-sdma.c
CONFLICT (content): Merge conflict in Documentation/driver-api/dmaengine/cl=
ient.rst
Merging cgroup/for-next (34b43446937e Documentation: cgroup-v2: eliminate m=
arkup warnings)
Merging scsi/for-next (5881a0838820 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in include/linux/blkdev.h
CONFLICT (content): Merge conflict in drivers/scsi/arcmsr/arcmsr_hba.c
Merging scsi-mkp/for-next (df46cac3f71c scsi: sd: Fix typo in sd_first_prin=
tk())
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (53cb6e5b4ab4 arch: move common mmap flags to linu=
x/mman.h)
CONFLICT (content): Merge conflict in kernel/dma/swiotlb.c
Merging rpmsg/for-next (19f5ccc8bbc9 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (e560562c7547 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (68b7587baabf gpio: altera-a10sr: Trivial c=
oding style fix)
Merging pinctrl/for-next (4339d7ef6256 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (7ca17b207127 pwm: imx: Signedness bug in imx_pwm_get_=
state())
Merging userns/for-next (cf43a757fd49 signal: Restore the stop PTRACE_EVENT=
_EXIT)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (6d771c60e50f selftests: ir: skip when non-root user=
 runs the test)
Merging y2038/y2038 (48166e6ea47d y2038: add 64-bit time_t syscalls to all =
32-bit architectures)
Merging livepatching/for-next (b420648f103d Merge branch 'for-5.1-atomic-re=
place' into for-next)
Merging coresight/next (37af13cc74d1 perf record: implement --affinity=3Dno=
de|cpu option)
Merging rtc/rtc-next (f31bbbaaff85 rtc: hid-sensor-time: stop selecting IIO)
Merging nvdimm/libnvdimm-for-next (8a6f7591ddf5 Merge branch 'for-5.0/dax' =
into libnvdimm-for-next)
Merging at24/at24/for-next (950bcbbe3154 eeprom: at24: implement support fo=
r 'num-addresses' property)
Merging ntb/ntb-next (8af642c76ef5 NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (ddf89e25fad8 lib: Introduce test_stackinit modu=
le)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (84a401a27506 Merge branch 'for-x86' into for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging gnss/gnss-next (f9eb86fddaf2 dt-bindings: gnss: add lna-supply prop=
erty)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (81648d8bc222 slimbus: core: add missing spin_lock=
_init on txn_lock)
Merging nvmem/for-next (c86d78c459db nvmem: allow to select i.MX nvmem driv=
er for i.MX 7D)
Merging xarray/xarray (f818b82b8016 XArray: Mark xa_insert and xa_reserve a=
s must_check)
Applying: RDMA/devices: fix up for xa_alloc API change
Merging hyperv/hyperv-next (27207b76011f vmbus: Switch to use new generic U=
UID API)
Merging auxdisplay/auxdisplay (f90c7e9f180a auxdisplay: ht16k33: fix potent=
ial user-after-free on module unload)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (a662d9f6ca22 selftests: add tests for pidfd_send_si=
gnal())
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Merging kspp-gustavo/for-next/kspp (6f6c95f09001 ASN.1: mark expected switc=
h fall-through)
CONFLICT (content): Merge conflict in kernel/time/timer.c
CONFLICT (content): Merge conflict in kernel/time/hrtimer.c
Merging akpm-current/current (0f8b1baa7ec1 zram: default to lzo-rle instead=
 of lzo)
CONFLICT (content): Merge conflict in scripts/gcc-plugins/Kconfig
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/kernfs.h
CONFLICT (content): Merge conflict in include/linux/fs.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: pinctrl: fix pxa2xx.c build warnings
Applying: scripts/atomic/gen-atomics.sh: don't assume that scripts are exec=
utable
Applying: fs: fs_parser: fix printk format warning
Applying: mm: refactor readahead defines in mm.h
Applying: mm-refactor-readahead-defines-in-mmh-fix
Applying: proc: calculate end pointer for /proc/*/* lookup at compile time
Applying: proc: merge fix for proc_pident_lookup() API change
Applying: unicore32: stop printing the virtual memory layout
Applying: arch/nios2/mm/fault.c: remove duplicate include
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: openrisc: prefer memblock APIs returning virtual address
Applying: powerpc: use memblock functions returning virtual address
Applying: memblock: replace memblock_alloc_base(ANYWHERE) with memblock_phy=
s_alloc
Applying: memblock: drop memblock_alloc_base_nid()
Applying: memblock: emphasize that memblock_alloc_range() returns a physica=
l address
Applying: memblock: memblock_phys_alloc_try_nid(): don't panic
Applying: memblock: memblock_phys_alloc(): don't panic
Applying: memblock: drop __memblock_alloc_base()
Applying: memblock: drop memblock_alloc_base()
Applying: memblock: refactor internal allocation functions
Applying: memblock: fix parameter order in memblock_phys_alloc_try_nid()
Applying: memblock: make memblock_find_in_range_node() and choose_memblock_=
flags() static
Applying: arch: use memblock_alloc() instead of memblock_alloc_from(size, a=
lign, 0)
Applying: arch: don't memset(0) memory returned by memblock_alloc()
Applying: ia64: add checks for the return value of memblock_alloc*()
Applying: sparc: add checks for the return value of memblock_alloc*()
Applying: mm/percpu: add checks for the return value of memblock_alloc*()
Applying: init/main: add checks for the return value of memblock_alloc*()
Applying: swiotlb: add checks for the return value of memblock_alloc*()
Applying: treewide: add checks for the return value of memblock_alloc*()
Applying: mm: sparse: Use '%pa' with 'phys_addr_t' type
Applying: memblock: fix format strings for panics after memblock_alloc
Applying: mm/sparse: don't panic if the allocation in sparse_buffer_init fa=
ils
Applying: memblock: memblock_alloc_try_nid: don't panic
Applying: memblock: drop memblock_alloc_*_nopanic() variants
Applying: memblock: remove memblock_{set,clear}_region_flags
Applying: memblock: split checks whether a region should be skipped to a he=
lper function
Applying: mm: memblock: update comments and kernel-doc
Applying: memblock-update-comments-and-kernel-doc-fix
Applying: of: fix kmemleak crash caused by imbalance in early memory reserv=
ation
Applying: mm, memcg: rename ambiguously named memory.stat counters and func=
tions
Applying: mm, memcg: consider subtrees in memory.events
Applying: openvswitch: convert to kvmalloc
Applying: md: convert to kvmalloc
Applying: selinux: convert to kvmalloc
Applying: Generic radix trees
Applying: proc: commit to genradix
Applying: sctp: convert to genradix
Applying: Drop flex_arrays
Applying: include/linux/relay.h: fix percpu annotation in struct rchan
Applying: kernel/fork.c: remove duplicated include
Applying: samples/mic/mpssd/mpssd.h: remove duplicate header
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (a31f621b74c4 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/X0rCEPFSh2nq+pDxagOja0T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxmVj4ACgkQAVBC80lX
0GyNEQgAjncHQ/NFfy8dwaYKYve5V7X8yI8CKmLp1MkxDNzU73VVNxZSKG2xQ1VN
Gxkl1GWoCMyAwEQTgyRc6PoQhLKuGWeY8dJtwElkOj0R4rYBIYuQY0rDaWrD5EQS
IOLnMG7R8PXp4mv4HNIleBk+G9OfxDonmrpsvffvwbsX1d3/CYU2bURcmew7d4rD
1FXDBNoUI3VBOHxgPiXKL7V+jpLKMXQZMStDMnfdIjGWi+LnJ4lzL1Mi2SH7ULY3
+r+Rd9hh4TLSmo88LNJlugWgGckom9Twpy7Qr3VuG/rQwgkJRZGL71hSluAZBcoN
kWf6Y85Q7VxC+Gvogk1hfAd0Plzx5A==
=Cni2
-----END PGP SIGNATURE-----

--Sig_/X0rCEPFSh2nq+pDxagOja0T--
