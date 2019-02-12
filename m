Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D307FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0572083B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 06:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g/mnVUrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfBLGvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 01:51:07 -0500
Received: from ozlabs.org ([203.11.71.1]:45653 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbfBLGvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 01:51:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43zCwh6Yjnz9s2P;
        Tue, 12 Feb 2019 17:51:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549954261;
        bh=IWgPuD87ZHt9UYQulSpGJbAUEVdK9Lx5C1D+OvE663A=;
        h=Date:From:To:Cc:Subject:From;
        b=g/mnVUrmi2uJ5nBjRw13GYXZ4SpcV1NrkYdvabAyHtH/iUoM9MoFavSDG8/+kLcW8
         v0iZlABhPLqZb2WS1tZdgzD3Whz9+A1WQi4Vbe6zCPG+r2v7rSAvFeEublQSoHWb6o
         XFijhRqy6E/t63xG0f7OvralQo2KuLu0Vrkp6Od/amSS84Qs4jeWv+VVjkVC8DstgM
         IulGyS9kCEZkf972UvRjibL6O12wPx8/09KN26DiiJ20EU6HEfXFr4YmvjSsymaX1E
         gR/j0uLc4Sv9ftyFZ8ZPdeSQUaMtZixs4GASunD1lcZdqtyBlsat6daadArVC6hVXv
         8+KnBo5dFreFQ==
Date:   Tue, 12 Feb 2019 17:50:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 12
Message-ID: <20190212175059.1ea4c16c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vB299ox52V5aKrfvNA_sKMY"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vB299ox52V5aKrfvNA_sKMY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190211:

The tegra tree gained a conflict against the imx-mxs tree.

The net-next tree gained a conflict against the net tree.

The drm-misc tree lost its build failure.

The rtc tree lost its build failure.

The xarray tree gained a build failure for which I added a merge fix
patch.

The akpm tree gained a conflict against the bpf tree.

Non-merge commits (relative to Linus' tree): 7147
 7676 files changed, 298091 insertions(+), 188993 deletions(-)

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
Merging origin/master (fb7453e61a2b Merge tag 's390-5.0-3' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/s390/linux)
Merging fixes/master (0dd62c042779 x86/syscalls: Mark expected switch fall-=
throughs)
Merging kbuild-current/fixes (6db2983cd806 kallsyms: Handle too long symbol=
s in kallsyms.c)
Merging arc-current/for-curr (a50d1c471ec5 ARC: boot: robustify u-boot arg =
referencing)
Merging arm-current/fixes (1b5ba3507842 ARM: 8824/1: fix a migrating irq bu=
g when hotplug cpu)
Merging arm64-fixes/for-next/fixes (ea5736805190 arm64: kexec_file: handle =
empty command-line)
Merging m68k-current/for-linus (bed1369f5190 m68k: Fix memblock-related cra=
shes)
Merging powerpc-fixes/fixes (5a3840a470c4 powerpc/papr_scm: Use the correct=
 bind address)
Merging sparc/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (4d73eaee24ff Merge git://git.kernel.org/pub/scm/linux/k=
ernel/git/pablo/nf)
Merging bpf/master (e451eb510684 xsk: share the mmap_sem for page pinning)
Merging ipsec/master (f75a2804da39 xfrm: destroy xfrm_state synchronously o=
n net exit path)
Merging netfilter/master (8303b7e8f018 netfilter: nat: fix spurious connect=
ion timeouts)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (d04ca383860b mt76x0u: fix suspend/resume)
Merging mac80211/master (6157ca0d6bfe mac80211: Fix Tx aggregation session =
tear down with ITXQs)
Merging rdma-fixes/for-rc (48396e80fb65 RDMA/srp: Rework SCSI device reset =
handling)
Merging sound-current/for-linus (00a399cad1a0 ALSA: pcm: Revert capture str=
eam behavior change in blocking mode)
Merging sound-asoc-fixes/for-linus (bb62989dccca Merge branch 'asoc-5.0' in=
to asoc-linus)
Merging regmap-fixes/for-linus (f17b5f06cb92 Linux 5.0-rc4)
Merging regulator-fixes/for-linus (a71f59222522 Merge branch 'regulator-5.0=
' into regulator-linus)
Merging spi-fixes/for-linus (a4a9ebe8cb0f Merge branch 'spi-5.0' into spi-l=
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
Merging input-current/for-linus (a342083abe57 Input: matrix_keypad - use fl=
ush_delayed_work())
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
Merging mtd-fixes/master (d5d27fd9826b mtd: rawnand: gpmi: fix MX28 bus mas=
ter lockup problem)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (240809ef6630 media: vim2m: only cancel work if=
 it is for right context)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (94ee12b507db MIPS: fix truncation in __cmpxc=
hg_small for short values)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
Merging omap-fixes/fixes (dc30e7039137 ARM: OMAP2+: Variable "reg" in funct=
ion omap4_dsi_mux_pads() could be uninitialized)
Merging kvm-fixes/master (ecec76885bcf KVM: nVMX: unconditionally cancel pr=
eemption timer in free_nested (CVE-2019-7221))
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
Merging scsi-fixes/fixes (93c085911ec7 scsi: cxlflash: Prevent deadlock whe=
n adapter probe fails)
Merging drm-fixes/drm-fixes (d13937116f1e Linux 5.0-rc6)
Merging drm-intel-fixes/for-linux-next-fixes (d13937116f1e Linux 5.0-rc6)
Merging mmc-fixes/fixes (dcf6e2e38a1c mmc: block: handle complete_work on s=
eparate workqueue)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (52d3b4949192 hv_netvsc: fix typos in cod=
e comments)
Merging drm-misc-fixes/for-linux-next-fixes (7fd56e0260a2 drm/vkms: Fix lic=
ense inconsistent)
Merging kbuild/for-next (fdda04c089c8 Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (14964fafc811 include/linux=
/module.h: copy __init/__exit attrs to init/cleanup_module)
Merging leaks/leaks-next (8fe28cb58bcb Linux 4.20)
Merging dma-mapping/for-next (0a3b192c26da dma-debug: add dumping facility =
via debugfs)
Merging asm-generic/master (2b3c5a99d5f3 sh: generate uapi header and sysca=
ll table header files)
Merging arc/for-next (8834f5600cf3 Linux 5.0-rc5)
Merging arm/for-next (c43658cedf4d Merge branches 'fixes', 'misc' and 'smp-=
hotplug' into for-next)
Merging arm64/for-next/core (81dc19231d10 arm64: irqflags: Use ICC_PMR_EL1 =
for interrupt masking)
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
Merging imx-mxs/for-next (672680c195c5 Merge branch 'imx/maintainers' into =
for-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (d542127adb0c Merge branch 'v5.0-next/soc' into f=
or-next)
Merging mvebu/for-next (acb05f82fd4e Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (8430a9d2e9fc Merge branch 'omap-for-v5.1/dt' into fo=
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
Merging tegra/for-next (b96e404404fb Merge branch for-5.1/arm64/defconfig i=
nto for-next)
CONFLICT (content): Merge conflict in arch/arm64/configs/defconfig
Merging clk/clk-next (81d9f06c35cd Merge branch 'clk-devm-clkdev-register' =
into clk-next)
Merging clk-samsung/for-next (81faa30df9b6 clk: samsung: exynos5433: Add se=
lected IMEM clocks)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (757dc82a8766 csky: Fixup dead loop in show_stack)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (28713169d879 m68k: Add -ffreestanding to CFLAGS)
Merging m68knommu/for-next (8461023b52ba m68k: add ColdFire mcf5441x eDMA p=
latform support)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (3d2521810ec9 MIPS: OCTEON: program rx/tx-delay alwa=
ys from DT)
CONFLICT (content): Merge conflict in arch/mips/include/asm/pgtable.h
CONFLICT (content): Merge conflict in arch/mips/include/asm/barrier.h
Merging nds32/next (bfeffd155283 Linux 5.0-rc1)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (ac248b179b54 parisc: Show machine product numbe=
r during boot)
Merging powerpc/next (b174b4fb919d powerpc/powernv: Escalate reset when IOD=
A reset fails)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (801009424e05 Fix a handful of audit-related issue)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (b96027d3b760 Merge tag 'vfio-ccw-20190204' of git://=
git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into features)
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
Merging btrfs-kdave/for-next (35d0ea9f2e49 Merge branch 'for-next-next-v5.0=
-20190211' into for-next-20190211)
Merging ceph/master (1a0fef353593 libceph: handle an empty authorize reply)
Merging cifs/for-next (df634b4e31d2 cifs: update internal module version nu=
mber)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (772989eab6a5 Merge ext2 cleanups and fixes.)
Merging ext4/dev (191ce17876c9 ext4: fix special inode number checks in __e=
xt4_iget())
Merging f2fs/dev (72aa2995d2b3 f2fs: do not use mutex lock in atomic contex=
t)
Merging fuse/for-next (e057f7fc89c2 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (d13937116f1e Linux 5.0-rc6)
Merging nfs-anna/linux-next (8fc75bed96bb NFS: Fix up return value on fatal=
 errors in nfs_page_async_flush())
Merging nfsd/nfsd-next (8820bcaa5bd7 svcrdma: Remove syslog warnings in wor=
k completion handlers)
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (2424e1c7256c overlayfs: During copy up, f=
irst copy up data and then xattrs)
Merging ubifs/linux-next (e58725d51fa8 ubifs: Handle re-linking of inodes c=
orrectly while recovery)
Merging v9fs/9p-next (3bbe8b1a4ae9 9p: mark expected switch fall-through)
Merging xfs/for-next (add46b3b0212 xfs: set buffer ops when repair probes f=
or btree type)
Merging file-locks/locks-next (bf77ae4c98d7 locks: fix error in locks_move_=
blocks())
Merging vfs/for-next (b59b26d1f597 Merge branches 'work.mount', 'work.misc'=
 and 'work.iov_iter' into for-next)
CONFLICT (content): Merge conflict in fs/Makefile
Merging printk/for-next (15ff2069cb7f printk: Add caller information to pri=
ntk() output.)
Merging pci/next (93a86e858552 Merge branch 'remotes/lorenzo/pci/vmd')
Merging pstore/for-next/pstore (182ca6e0ae23 pstore/ram: Replace dummy_data=
 heap memory with stack memory)
Merging hid/for-next (f463fe19f12c Merge branch 'for-5.1/hid-topseed' into =
for-next)
Merging i2c/i2c/for-next (91baa5104ebd Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging i3c/i3c/next (25ac3da61ba1 i3c: master: cdns: fix I2C transfers in =
Cadence I3C master driver)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (d79d81923274 hwmon: (lm85) add support fo=
r LM96000 high frequencies)
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
Merging pm/linux-next (a06639e89e47 Merge branches 'pm-cpuidle' and 'pm-cpu=
freq' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (af816ddfbdf0 Merge branch 'cpuf=
req/qcom-hw' into cpufreq/arm/linux-next)
Merging cpupower/cpupower (bfeffd155283 Linux 5.0-rc1)
Merging opp/opp/linux-next (a9a744dd5b82 cpufreq: OMAP: Register an Energy =
Model)
CONFLICT (content): Merge conflict in drivers/cpufreq/scmi-cpufreq.c
Merging thermal/next (f17b5f06cb92 Linux 5.0-rc4)
Merging thermal-soc/next (8834f5600cf3 Linux 5.0-rc5)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (8526e331c56f dlm: Fix test for -ERESTARTSYS)
Merging swiotlb/linux-next (227a76b64718 swiotlb: clear io_tlb_start and io=
_tlb_end in swiotlb_exit)
Merging rdma/for-next (f368ff188ae4 iw_cxgb4: fix srqidx leak during connec=
tion abort)
Merging net-next/master (b904aada8033 devlink: Add WARN_ON to catch errors =
of not cleaning devlink objects)
CONFLICT (content): Merge conflict in net/ipv6/netfilter/nf_nat_l3proto_ipv=
6.c
CONFLICT (content): Merge conflict in net/ipv4/netfilter/nf_nat_l3proto_ipv=
4.c
Merging bpf-next/master (d105fa983c58 Merge branch 'skb_sk-sk_fullsock-tcp_=
sock')
CONFLICT (content): Merge conflict in kernel/bpf/verifier.c
Merging ipsec-next/master (590ce401c207 dt-bindings: net: dsa: ksz9477: fix=
 indentation for switch spi bindings)
Merging mlx5-next/mlx5-next (1fbf1252df0e mlx5: use RCU lock in mlx5_eq_cq_=
get())
Merging netfilter-next/master (6ca64ef37da9 netfilter: xt_recent: Use struc=
t_size() in kvzalloc())
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
Merging spi-nor/spi-nor/next (9558281572e3 mtd: spi-nor: cadence-quadspi: w=
rite upto 8-bytes data in STIG mode)
Merging crypto/master (920d7f7215d8 crypto: qat - Remove unused goto label)
Merging drm/drm-next (16065fcdd19d drm/virtio: do NOT reuse resource ids)
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
Merging drm-intel/for-linux-next (ed06fddc2203 drm/i915: Include the curren=
t timeline seqno for debugging execlists)
Merging drm-tegra/drm/tegra/for-next (79930bafe280 gpu: host1x: Continue CD=
MA execution starting with a next job)
Merging drm-misc/for-linux-next (6649a95d35d8 drm/komeda: fix build with dr=
m_modeset_helper.h update)
Merging drm-msm/msm-next (d3db61caf45a drm/msm/dpu: remove struct encoder_k=
ickoff_params)
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
Merging sound/for-next (d9c0b2afe820 ALSA: PCM: check if ops are defined be=
fore suspending PCM)
Merging sound-asoc/for-next (bdfc54c16c45 Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (460f54f0f670 Merge branch 'for-linus' into next)
Merging block/for-next (6ddaa1638daa Merge branch 'for-5.1/block' into for-=
next)
Merging device-mapper/for-next (fa8db4948f52 dm: don't use bio_trim() after=
all)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (91182844b01d Merge branch 'fixes' into next)
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
Merging battery/for-next (f83a6ece6997 power: supply: bq25890: show max cha=
rge current/voltage as configured)
Merging regulator/for-next (18e31e0feff3 Merge branch 'regulator-5.1' into =
regulator-next)
Merging security/next-testing (d87331e4a620 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (d071661b4755 apparmor: fix blob compression=
 build failure on ppc)
Merging integrity/next-integrity (e7fde070f39b evm: Use defined constant fo=
r UUID representation)
Merging selinux/next (45189a1998e0 selinux: fix avc audit messages)
Merging tpmdd/next (873657e1ea72 tpm/ppi: Enable submission of optional com=
mand parameter for PPI 1.3)
Merging watchdog/master (59600d045ff4 dt-bindings: watchdog: renesas-wdt: D=
ocument r8a77470 support)
Merging iommu/next (f1fc9f79bf1a Merge branches 'arm/msm', 'arm/tegra', 'x8=
6/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (3c8d7ef89bb8 vfio: platform: reset: fix up include direc=
tives to remove ccflags-y)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (cd108b5c51db audit: hide auditsc_get_stamp and audit_se=
rial prototypes)
Merging devicetree/for-next (42e45a9449f1 media: s5p-mfc: Fix memdev DMA co=
nfiguration)
Merging mailbox/mailbox-for-next (d69e11648e48 mailbox: tegra-hsp: Use devi=
ce-managed registration API)
Merging spi/for-next (e0d6cc719052 Merge branch 'spi-5.1' into spi-next)
CONFLICT (modify/delete): arch/mips/ath79/dev-spi.h deleted in HEAD and mod=
ified in spi/for-next. Version spi/for-next of arch/mips/ath79/dev-spi.h le=
ft in tree.
$ git rm -f arch/mips/ath79/dev-spi.h
Merging tip/auto-latest (9649be2211eb Merge branch 'x86/platform')
Merging clockevents/clockevents/next (7cd6dca3600d clocksource/drivers/arch=
_timer: Workaround for Allwinner A64 timer instability)
Merging edac-amd/for-next (cbfa482f7e2b EDAC, skx_common: Add code to recog=
nise new compound error code)
Merging irqchip/irq/irqchip-next (56841070ccc8 irqchip/gic-v3-its: Fix ITT_=
entry_size accessor)
Merging ftrace/for-next (3d739c1f6156 tracing: Use the return of str_has_pr=
efix() to remove open coded numbers)
Merging rcu/rcu/next (345ce896cac4 Merge LKMM and RCU)
Merging kvm/linux-next (bfeffd155283 Linux 5.0-rc1)
Merging kvm-arm/next (d35b8e91b2b1 arm64: KVM: Describe data or unified cac=
hes as having 1 set and 1 way)
Merging kvm-ppc/kvm-ppc-next (ae59a7e1945b KVM: PPC: Book3S HV: Keep rc bit=
s in shadow pgtable in sync with host)
Merging kvms390/next (b9fa6d6ee9b8 KVM: s390: fix possible null pointer der=
eference in pending_irqs())
Merging xen-tip/linux-next (9ab7d228e972 MAINTAINERS: unify reference to xe=
n-devel list)
Merging percpu/for-next (718f6757a29b Merge branch 'for-4.21' into for-next)
Merging workqueues/for-next (4d43d395fed1 workqueue: Try to catch flush_wor=
k() without INIT_WORK().)
Merging drivers-x86/for-next (289790a3ea94 platform/x86: dell_rbu: stop abu=
sing the DMA API)
Merging chrome-platform/for-next (79c4ec4869b5 platform/chrome: wilco_ec: A=
dd RTC driver)
Merging hsi/for-next (3a658e09a215 HSI: omap_ssi: Change to use DEFINE_SHOW=
_ATTRIBUTE macro)
Merging leds/for-next (0f85e8498a48 leds: trigger: timer: Add initializatio=
n from Device Tree)
Merging ipmi/for-next (2b835103f84d ipmi: Use dedicated API for copying a U=
UID)
Merging driver-core/driver-core-next (9481caf39bf5 Merge 5.0-rc6 into drive=
r-core-next)
Merging usb/usb-next (15e99b13b44b Merge 5.0-rc6 into usb-next)
Merging usb-gadget/next (e26bdb013150 fotg210-udc: pass struct device to DM=
A API functions)
Merging usb-serial/usb-next (85bc2d91e9f0 USB: serial: cp210x: add minimum =
baud rate for CP2105 SCI)
Merging usb-chipidea-next/ci-for-usb-next (bc65fae4b1f0 usb: chipidea: imx:=
 set power polarity)
Merging phy-next/next (aa1996e201b4 phy: bcm-sr-pcie: Change operation when=
 PIPEMUX=3D1)
CONFLICT (content): Merge conflict in drivers/phy/marvell/Makefile
CONFLICT (content): Merge conflict in drivers/phy/marvell/Kconfig
Merging tty/tty-next (c744ca39f28f Merge 5.0-rc6 into tty-next)
Merging char-misc/char-misc-next (21698fd57984 parport_pc: fix find_superio=
 io compare code, should use equal test.)
Merging extcon/extcon-next (3dfed89512d3 extcon: ptn5150: Fix return value =
check in ptn5150_i2c_probe())
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (d13937116f1e Linux 5.0-rc6)
Merging staging/staging-next (3b6effbc3805 Merge 5.0-rc6 into staging-next)
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
Merging scsi/for-next (624fca90e24e Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in include/linux/blkdev.h
CONFLICT (content): Merge conflict in drivers/scsi/arcmsr/arcmsr_hba.c
Merging scsi-mkp/for-next (4a8bec88f71a scsi: hisi_sas: Do some more tidy-u=
p)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (2fafb16e2123 arch: move common mmap flags to linu=
x/mman.h)
Merging rpmsg/for-next (19f5ccc8bbc9 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (b06c2427fea4 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (c4b7b0d25d79 gpio: altera-a10sr: Trivial c=
oding style fix)
Merging pinctrl/for-next (2309125aa3fe Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (7ca17b207127 pwm: imx: Signedness bug in imx_pwm_get_=
state())
Merging userns/for-next (7146db3317c6 signal: Better detection of synchrono=
us signals)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (bfeffd155283 Linux 5.0-rc1)
Merging y2038/y2038 (48166e6ea47d y2038: add 64-bit time_t syscalls to all =
32-bit architectures)
Merging livepatching/for-next (586f1a151c7b Merge branch 'for-5.1-atomic-re=
place' into for-next)
Merging coresight/next (37af13cc74d1 perf record: implement --affinity=3Dno=
de|cpu option)
Merging rtc/rtc-next (bf0e0bbe570c rtc: meson: remove useless rtc_nvmem_unr=
egister call)
Merging nvdimm/libnvdimm-for-next (8a6f7591ddf5 Merge branch 'for-5.0/dax' =
into libnvdimm-for-next)
Merging at24/at24/for-next (3b0548784079 eeprom: at24: remove at24_platform=
_data)
Merging ntb/ntb-next (8af642c76ef5 NTB: ntb_test: Fix bug when counting rem=
ote files)
Merging kspp/for-next/kspp (be1944712d8e Merge branch 'for-next/gcc-plugin/=
arm-stackprotector' into for-next/kspp)
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
Merging akpm-current/current (5dfd8e97afb6 zram: default to lzo-rle instead=
 of lzo)
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/kernfs.h
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in arch/powerpc/mm/pgtable-book3s64.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: scripts/atomic/check-atomics.sh: don't assume that scripts are ex=
ecutable
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
Merging akpm/master (37c9540210ba drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/vB299ox52V5aKrfvNA_sKMY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxibNMACgkQAVBC80lX
0Gw90Qf9G7LuFqkMKp+K6IAXWkJ64UI2BIfAIZSum/2MMB94IMpRXwSc7e3HejQ/
hYgHRLQVKMGaq77JX3GQ5q4cUVNZWgUCdWCsfe2DdhH76K/WVXwkzh0mP5iZyy0O
eZMp1sUK0qxczJTXVPzOqki6aqf+6XdZEwT6GLFqTFXFh52P8LPsEu2CbqTkaVXd
6b3M3BLwMGCUmCzwPSXXcFDnJqnJOYi/LhDb1Tl2nS9lo1MvPIXP8tkMbxXTr7T0
xWGy6pnzCryRGo3oGbH/wLbZ5TE5AsDUun6rOKNxzZuUcCtRk51tdw8LaoVt49qI
ejaPFRcV0lS6VVllwA8jp6mvE2z9Kw==
=2dvq
-----END PGP SIGNATURE-----

--Sig_/vB299ox52V5aKrfvNA_sKMY--
