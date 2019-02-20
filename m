Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A29C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5615A20449
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 07:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nyX4rqOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfBTHnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 02:43:51 -0500
Received: from ozlabs.org ([203.11.71.1]:44551 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbfBTHnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 02:43:50 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 4448jp2b3qz9s5c;
        Wed, 20 Feb 2019 18:43:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1550648622;
        bh=sicCWLP2WtApRqqsAe5jSQyL2cVmn0FJKoe/2T8GGQw=;
        h=Date:From:To:Cc:Subject:From;
        b=nyX4rqOJt8rICEDkXaTYGcKbRGFnL4LmA53YWkIFxl6wNB0JIX8q/JsuTiXc+SSYx
         sSVWpD8o89MtjAEIfACx+pFuaidVvLVHtoXndNKsUqjh3iIvkxQaFO/tLJ7AKtxK/4
         V4GgZozdTnyrwoo2z0zplTEAM8cu/1IuiXAF3xa4ov3+fMdTUNEWd3W04u/ARc2Sh5
         nSnPoo9V6BCEu3w0cykNlXx0QKliOhljdukmNI0Gs1qbR7qnK0RsJJbnl76lX3zTCK
         hOJTfjhjERIjjFw7qYAACuU96T4AvZohlkX6Mz3AtQFmALkAdbQKT/WlLT/lGkwiUC
         HHrYHHVGLaNOQ==
Date:   Wed, 20 Feb 2019 18:43:41 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 20
Message-ID: <20190220184341.73bd2084@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/uvWtato.4/sj52T7v+snXRO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uvWtato.4/sj52T7v+snXRO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190219:

The asm-generic tree lost its build failure.

The v4l-dvb tree lost its build failure.

The net-next tree gained a conflict against the bpf tree.

The kvm tree still had its build failure so I used a supplied patch.

The akpm-current tree gained a build failure due to an interaction with
the drm tree for which I applied a merge fix patch.

Non-merge commits (relative to Linus' tree): 8846
 9249 files changed, 416125 insertions(+), 220692 deletions(-)

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
Merging origin/master (b5372fe5dc84 exec: load_script: Do not exec truncate=
d interpreter path)
Merging fixes/master (ed3ce4cfc919 adfs: mark expected switch fall-throughs)
Merging kspp-gustavo/for-next/kspp (6f6c95f09001 ASN.1: mark expected switc=
h fall-through)
Merging kbuild-current/fixes (207a369e3c08 sh: fix build error for invisibl=
e CONFIG_BUILTIN_DTB_SOURCE)
Merging arc-current/for-curr (3a939df742e5 ARC: enable uboot support uncond=
itionally)
Merging arm-current/fixes (fc67e6f120a3 ARM: 8835/1: dma-mapping: Clear DMA=
 ops on teardown)
Merging arm64-fixes/for-next/fixes (0738c8b5915c arm64/neon: Disable -Winco=
mpatible-pointer-types when building with Clang)
Merging m68k-current/for-linus (bed1369f5190 m68k: Fix memblock-related cra=
shes)
Merging powerpc-fixes/fixes (a58007621be3 powerpc/64s: Fix possible corrupt=
ion on big endian due to pgd/pud_present())
Merging sparc/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (5cd856a5ef9a Merge git://git.kernel.org/pub/scm/linux/k=
ernel/git/pablo/nf)
Merging bpf/master (f6be4d16039b selftests/bpf: make sure signal interrupts=
 BPF_PROG_TEST_RUN)
Merging ipsec/master (660899ddf06a xfrm: Fix inbound traffic via XFRM inter=
faces across network namespaces)
Merging netfilter/master (c93a49b9769e ipvs: fix warning on unused variable)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (d04ca383860b mt76x0u: fix suspend/resume)
Merging mac80211/master (83e37e0bdd14 mac80211: Restore vif beacon interval=
 if start ap fails)
Merging rdma-fixes/for-rc (48396e80fb65 RDMA/srp: Rework SCSI device reset =
handling)
Merging sound-current/for-linus (268836649c07 Merge tag 'asoc-fix-v5.0-rc6'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-li=
nus)
Merging sound-asoc-fixes/for-linus (e080eee63441 Merge branch 'asoc-5.0' in=
to asoc-linus)
Merging regmap-fixes/for-linus (f17b5f06cb92 Linux 5.0-rc4)
Merging regulator-fixes/for-linus (86d2d637fd84 Merge branch 'regulator-5.0=
' into regulator-linus)
Merging spi-fixes/for-linus (5035e90c71bf Merge branch 'spi-5.0' into spi-l=
inus)
Merging pci-current/for-linus (f57a98e1b713 PCI: Work around Synopsys dupli=
cate Device ID (HAPS USB3, NXP i.MX))
Merging driver-core.current/driver-core-linus (d13937116f1e Linux 5.0-rc6)
Merging tty.current/tty-linus (d13937116f1e Linux 5.0-rc6)
Merging usb.current/usb-linus (d13937116f1e Linux 5.0-rc6)
Merging usb-gadget-fixes/fixes (a53469a68eb8 usb: phy: am335x: fix race con=
dition in _probe)
Merging usb-serial-fixes/usb-linus (8d7fa3d4ea3f USB: serial: ftdi_sio: add=
 ID for Hjelmslund Electronics USB485)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (827cb0323928 phy: ath79-usb: Fix the main reset name to =
match the DT binding)
Merging staging.current/staging-linus (d13937116f1e Linux 5.0-rc6)
Merging char-misc.current/char-misc-linus (d13937116f1e Linux 5.0-rc6)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (d13937116f1e Linux 5.0-rc6)
Merging input-current/for-linus (7ad222b3aed3 Input: elan_i2c - add ACPI ID=
 for touchpad in Lenovo V330-15ISK)
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
Merging v4l-dvb-fixes/fixes (7bdf2c8fee51 media: v4l: ioctl: Sanitize num_p=
lanes before using it)
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
Merging hwmon-fixes/hwmon (ff066653aeed hwmon: (pmbus/tps53679) Fix driver =
info initialization in probe routine)
Merging nvdimm-fixes/libnvdimm-fixes (11189c1089da acpi/nfit: Fix command-s=
upported detection)
Merging btrfs-fixes/next-fixes (8834f5600cf3 Linux 5.0-rc5)
Merging vfs-fixes/fixes (f612acfae86a exec: Fix mem leak in kernel_read_fil=
e)
Merging dma-mapping-fixes/for-linus (60d8cd572f65 arm64/xen: fix xen-swiotl=
b cache flushing)
Merging i3c-fixes/master (f36c1f9a8dfd i3c: master: dw: fix deadlock)
Merging drivers-x86-fixes/fixes (6a730fcb9cb4 Documentation/ABI: Correct ml=
xreg-io KernelVersion for 5.0)
Merging samsung-krzk-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (4a067cf823d9 scsi: core: reset host byte in DID_N=
EXUS_FAILURE case)
Merging drm-fixes/drm-fixes (a3b22b9f11d9 Linux 5.0-rc7)
Merging drm-intel-fixes/for-linux-next-fixes (a3b22b9f11d9 Linux 5.0-rc7)
Merging mmc-fixes/fixes (83e418a805d8 mmc: meson-gx: fix interrupt name)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (52d3b4949192 hv_netvsc: fix typos in cod=
e comments)
Merging drm-misc-fixes/for-linux-next-fixes (25dc194b34dd drm: Block fb cha=
nges for async plane updates)
Merging kbuild/for-next (a377885461a3 Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (a3b22b9f11d9 Linux 5.0-rc7)
Merging leaks/leaks-next (982ef2f7ef0a leaking_addresses: Completely remove=
 --version flag)
Merging dma-mapping/for-next (dc2acded3895 dma-mapping: add a kconfig symbo=
l for arch_teardown_dma_ops availability)
Merging asm-generic/master (746c9398f5ac arch: move common mmap flags to li=
nux/mman.h)
Merging arc/for-next (8834f5600cf3 Linux 5.0-rc5)
Merging arm/for-next (d25495e864b9 Merge branches 'fixes', 'misc' and 'smp-=
hotplug' into for-next)
Merging arm64/for-next/core (0543371a57e3 Merge branch 'for-next/perf' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/will/linux)
Merging arm-perf/for-next/perf (cf2d65ec1d21 perf: xgene: Remove set but no=
t used variable 'config')
Merging arm-soc/for-next (2c0ece7d2ae9 arm-soc: document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (a7c5fed5c7e4 Merge branch 'v5.1/drivers' into tmp=
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
Merging omap/for-next (fa2b1eeaeb1d Merge branch 'omap-for-v5.0/fixes-v2' i=
nto for-next)
Merging reset/reset/next (dbfc54534dfc dt-bindings: reset: meson: add g12a =
bindings)
Merging qcom/for-next (4d216cf2443b Merge tag 'qcom-drivers-for-5.1-3' into=
 5.1-final)
Merging renesas/next (817697a462a4 Merge branches 'fixes-for-v5.0', 'arm-de=
fconfig-for-v5.1', 'arm-dt-for-v5.1', 'arm-soc-for-v5.1', 'arm64-dt-for-v5.=
1', 'arm64-defconfig-for-v5.1' and 'dt-bindings-for-v5.1' into next)
Merging rockchip/for-next (8444545ff72a Merge branch 'v5.1-clk/next' into f=
or-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (02b73248d5ec Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (1fc3dc289134 Merge remote-tracking branches '=
korg/sunxi/sunxi/dt-for-5.1', 'korg/sunxi/sunxi/dt64-for-5.1' and 'korg/sun=
xi/sunxi/h3-h5-for-5.1' into sunxi/for-next)
Merging tegra/for-next (d92dde4f12f1 Merge branch for-5.1/fixes into for-ne=
xt)
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
Merging m68knommu/for-next (6ce1874de854 m68k: add ColdFire mcf5441x eDMA p=
latform support)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (72faa7a773ca MIPS: irq: Allocate accurate order pag=
es for irq stack)
CONFLICT (content): Merge conflict in arch/mips/include/asm/pgtable.h
CONFLICT (content): Merge conflict in arch/mips/include/asm/barrier.h
Merging nds32/next (bfeffd155283 Linux 5.0-rc1)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (4305d070711c parisc: Fix ptrace syscall number =
modification)
Merging powerpc/next (b174b4fb919d powerpc/powernv: Escalate reset when IOD=
A reset fails)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (79a47bad61bb riscv: remove the HAVE_KPROBES option)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (41fc866a5f3f s390/setup: fix boot crash for machine =
without EDAT-1)
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
Merging btrfs-kdave/for-next (8d293bf657b3 Merge branch 'for-next-next-v5.0=
-20190218' into for-next-20190218)
Merging ceph/master (04242ff3ac0a ceph: avoid repeatedly adding inode to md=
sc->snap_flush_list)
Merging cifs/for-next (166829b8b273 smb3: fix credit reconnect problem)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (d43388dea04b eCryptfs: fix permission denied with ec=
ryptfs_xattr mount option when create readonly file)
Merging ext3/for_next (ab581583f0d7 Pull UDF cleanup in udf_sync_fs().)
Merging ext4/dev (191ce17876c9 ext4: fix special inode number checks in __e=
xt4_iget())
Merging f2fs/dev (6afbeef75215 f2fs: don't clear CP_QUOTA_NEED_FSCK_FLAG)
Merging fuse/for-next (fabf7e0262d0 fuse: cache readdir calls if filesystem=
 opts out of opendir)
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (b5372fe5dc84 exec: load_script: Do not exec truncat=
ed interpreter path)
Merging nfs-anna/linux-next (7517d01d20e1 NFS: Pass error information to th=
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
Merging vfs/for-next (b799a82237a5 Merge branches 'fixes' and 'work.misc' i=
nto for-next)
CONFLICT (content): Merge conflict in fs/Makefile
Merging printk/for-next (15ff2069cb7f printk: Add caller information to pri=
ntk() output.)
Merging pci/next (1a6ccb159371 Merge branch 'remotes/lorenzo/pci/vmd')
Merging pstore/for-next/pstore (93ee4b7d9f06 pstore/ram: Avoid needless all=
oc during header write)
Merging hid/for-next (b235b5129b19 Merge branch 'for-5.1/i2c-hid' into for-=
next)
Merging i2c/i2c/for-next (44bfa3e9e2ea Merge branch 'i2c/for-5.1' into i2c/=
for-next)
Merging i3c/i3c/next (25ac3da61ba1 i3c: master: cdns: fix I2C transfers in =
Cadence I3C master driver)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (e4e6c0b0ad79 hwmon: (f71882fg) Mark expec=
ted switch fall-through)
Merging jc_docs/docs-next (e85a198e30e9 perf-security: wrap paragraphs on 7=
2 columns)
Merging v4l-dvb/master (9fabe1d108ca media: ipu3-mmu: fix some kernel-doc m=
acros)
Merging v4l-dvb-next/master (76097fe1aee6 media: staging/ipu3-imgu: Add MAI=
NTAINERS entry)
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3.c
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3-v4l2.c
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3-css.h
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3-css.c
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3-css-p=
arams.h
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3-css-p=
arams.c
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3-css-f=
w.h
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/ipu3-css-f=
w.c
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/include/in=
tel-ipu3.h
CONFLICT (content): Merge conflict in drivers/staging/media/ipu3/TODO
CONFLICT (add/add): Merge conflict in Documentation/media/v4l-drivers/ipu3.=
rst
CONFLICT (content): Merge conflict in Documentation/media/v4l-drivers/index=
.rst
CONFLICT (add/add): Merge conflict in Documentation/media/uapi/v4l/pixfmt-m=
eta-intel-ipu3.rst
Merging fbdev/fbdev-for-next (f40298444e8c video: fbdev: Fix potential NULL=
 pointer dereference)
Merging pm/linux-next (a65b747c7753 Merge branch 'pm-cpufreq-fixes' into li=
nux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (40b46b3b2f09 cpufreq: davinci: =
move configuration to include/linux/platform_data)
Merging cpupower/cpupower (ae2917093fb6 tools/power/cpupower: Display boost=
 frequency separately)
Merging opp/opp/linux-next (a9a744dd5b82 cpufreq: OMAP: Register an Energy =
Model)
Merging thermal/next (f17b5f06cb92 Linux 5.0-rc4)
Merging thermal-soc/next (8834f5600cf3 Linux 5.0-rc5)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (8526e331c56f dlm: Fix test for -ERESTARTSYS)
Merging swiotlb/linux-next (22cb45d7692a swiotlb: drop pointless static qua=
lifier in swiotlb_create_debugfs())
Merging rdma/for-next (0dd9ce18b9f3 IB/ipoib: Use __func__ instead of funct=
ion's name)
Merging net-next/master (d2cf821ff677 Merge branch 'ieee802154-for-davem-20=
19-02-19' of git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-ne=
xt)
CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/test_prog=
s.c
CONFLICT (content): Merge conflict in net/ipv4/tcp.c
CONFLICT (content): Merge conflict in kernel/bpf/verifier.c
CONFLICT (content): Merge conflict in drivers/infiniband/hw/mlx5/ib_rep.c
Merging bpf-next/master (74e31ca850c1 bpf: add skb->queue_mapping write acc=
ess from tc clsact)
Merging ipsec-next/master (590ce401c207 dt-bindings: net: dsa: ksz9477: fix=
 indentation for switch spi bindings)
Merging mlx5-next/mlx5-next (37b6bb77c6fd net/mlx5: Factor out HCA capabili=
ties functions)
Merging netfilter-next/master (d2cf821ff677 Merge branch 'ieee802154-for-da=
vem-2019-02-19' of git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/w=
pan-next)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (c7ff1bfeaf1c rt2800: comment and simp=
lify AGC init for RT6352)
Merging bluetooth/master (e0b67035a90b Bluetooth: mediatek: update the comm=
on setup between MT7622 and other devices)
Merging mac80211-next/master (f440b125450d virt_wifi: Remove REGULATORY_WIP=
HY_SELF_MANAGED)
Merging gfs2/for-next (2abbf9a4d262 gfs: no need to check return value of d=
ebugfs_create functions)
Merging mtd/mtd/next (b0dd77a79642 mtd: docg3: fix a possible memory leak o=
f mtd->name)
Merging nand/nand/next (53bcbb839438 mtd: rawnand: denali_dt: remove single=
 anonymous clock support)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging spi-nor/spi-nor/next (2cc788387497 mtd: spi-nor: cadence-quadspi: A=
dd support for Octal SPI controller)
Merging crypto/master (cf64e495fe22 crypto: caam - weak key checking for cb=
c des, 3des)
Merging drm/drm-next (71f4e45a4ed3 Merge branch 'linux-5.1' of git://github=
.com/skeggsb/linux into drm-next)
Merging drm-intel/for-linux-next (24d2727ccc14 drm/i915/selftests: Always f=
ree spinner on __sseu_prepare error)
Merging drm-tegra/drm/tegra/for-next (ca52507efc03 drm/tegra: vic: Fix impl=
icit function declaration warning)
Merging drm-misc/for-linux-next (37406a60fac7 drm: Merge __drm_atomic_helpe=
r_disable_all() into drm_atomic_helper_disable_all())
Merging drm-msm/msm-next (860433ed2a55 drm/msm: Truncate the buffer object =
name if the copy from user failed)
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
Merging sound/for-next (c7a13264918b ALSA: usb-audio: Expose sample resolut=
ion through proc interface)
CONFLICT (content): Merge conflict in sound/soc/generic/simple-card.c
Merging sound-asoc/for-next (ef69a5a98a83 Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (44466306ebec Input: ti_am335x_tsc - remove set but not =
used variable 'tscadc_dev')
Merging block/for-next (352d8a911df5 Merge branch 'for-5.1/block' into for-=
next)
CONFLICT (content): Merge conflict in fs/gfs2/lops.c
CONFLICT (content): Merge conflict in fs/btrfs/extent_io.c
Merging device-mapper/for-next (afdd7a651332 dm mpath: add support for dm_n=
oclone and its per-bio-data)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (a1b458bca74a mmc: sdhci-xenon: Fixup already marked switc=
h fall-through)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (d2d833e0bf2b mfd: mxs-lradc: Mark expected switch=
 fall-through)
CONFLICT (content): Merge conflict in drivers/mfd/Kconfig
Merging backlight/for-backlight-next (cec2b18832e2 backlight: pwm_bl: Use g=
piod_get_value_cansleep() to get initial state)
Merging battery/for-next (655ab0bc462d power: reset: at91-reset: add suppor=
t for sam9x60 SoC)
Merging regulator/for-next (2bcdb5577073 Merge branch 'regulator-5.1' into =
regulator-next)
CONFLICT (modify/delete): arch/arm/mach-pxa/raumfeld.c deleted in HEAD and =
modified in regulator/for-next. Version regulator/for-next of arch/arm/mach=
-pxa/raumfeld.c left in tree.
$ git rm -f arch/arm/mach-pxa/raumfeld.c
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
Merging vfio/next (0cfd027be1d6 vfio_pci: Enable memory accesses before cal=
ling pci_map_rom)
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
Merging spi/for-next (638fdadeb85f Merge branch 'spi-5.1' into spi-next)
CONFLICT (modify/delete): arch/mips/ath79/dev-spi.h deleted in HEAD and mod=
ified in spi/for-next. Version spi/for-next of arch/mips/ath79/dev-spi.h le=
ft in tree.
$ git rm -f arch/mips/ath79/dev-spi.h
Merging tip/auto-latest (7bb209768006 Merge branch 'perf/core')
CONFLICT (content): Merge conflict in kernel/time/timer.c
CONFLICT (content): Merge conflict in kernel/time/hrtimer.c
CONFLICT (content): Merge conflict in include/uapi/linux/time.h
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Applying: time: fix up for "y2038: remove struct definition redirects"
Merging clockevents/clockevents/next (7cd6dca3600d clocksource/drivers/arch=
_timer: Workaround for Allwinner A64 timer instability)
Merging edac-amd/for-next (7f736599d632 EDAC, altera: Add missing of_node_p=
ut())
Merging irqchip/irq/irqchip-next (612c3a8d3dc1 irqchip: sifive-plic: Implem=
ent irq_set_affinity() for SMP host)
Merging ftrace/for-next (3d739c1f6156 tracing: Use the return of str_has_pr=
efix() to remove open coded numbers)
Merging rcu/rcu/next (e880edadc149 Merge LKMM and RCU)
Merging kvm/linux-next (eb9d5fef66c5 Revert "KVM: Eliminate extra function =
calls in kvm_get_dirty_log_protect()")
CONFLICT (content): Merge conflict in arch/x86/kvm/vmx/vmx.h
CONFLICT (content): Merge conflict in arch/x86/kvm/vmx/vmx.c
Applying: KVM: x86: Add missed file
Merging kvm-arm/next (1b44471b5559 KVM: arm64: Fix comment for KVM_PHYS_SHI=
FT)
CONFLICT (content): Merge conflict in arch/arm/include/asm/kvm_host.h
Merging kvm-ppc/kvm-ppc-next (ae59a7e1945b KVM: PPC: Book3S HV: Keep rc bit=
s in shadow pgtable in sync with host)
Merging kvms390/next (b9fa6d6ee9b8 KVM: s390: fix possible null pointer der=
eference in pending_irqs())
Merging xen-tip/linux-next (1d988ed46543 x86/xen: dont add memory above max=
 allowed allocation)
Merging percpu/for-next (718f6757a29b Merge branch 'for-4.21' into for-next)
Merging workqueues/for-next (4d43d395fed1 workqueue: Try to catch flush_wor=
k() without INIT_WORK().)
Merging drivers-x86/for-next (289790a3ea94 platform/x86: dell_rbu: stop abu=
sing the DMA API)
Merging chrome-platform/for-next (505b510acccc platform/chrome: wilco_ec: A=
dd RTC driver)
Merging hsi/for-next (1ff85bfa1614 HSI: omap_ssi_port: fix debugfs_simple_a=
ttr.cocci warnings)
Merging leds/for-next (5ddb0869bfc1 leds: lp55xx: fix null deref on firmwar=
e load failure)
Merging ipmi/for-next (2b835103f84d ipmi: Use dedicated API for copying a U=
UID)
Merging driver-core/driver-core-next (1ea61b68d0f8 async: Add cmdline optio=
n to specify drivers to be async probed)
Merging usb/usb-next (dc8b2a691dc8 Merge tag 'usb-for-v5.1' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next)
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
Merging char-misc/char-misc-next (eadf24990649 Update MAINTAINERS and CREDI=
TS with habanalabs info)
Merging extcon/extcon-next (3dfed89512d3 extcon: ptn5150: Fix return value =
check in ptn5150_i2c_probe())
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (d13937116f1e Linux 5.0-rc6)
Merging staging/staging-next (cbebe5d05dd7 staging: erofs: match alignment =
with open parentheses)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (a3b22b9f11d9 Linux 5.0-rc7)
Merging slave-dma/next (95781b704e43 Merge branch 'for-linus' into next)
CONFLICT (content): Merge conflict in drivers/dma/imx-sdma.c
CONFLICT (content): Merge conflict in Documentation/driver-api/dmaengine/cl=
ient.rst
Merging cgroup/for-next (6a613d24effc cpuset: remove unused task_has_mempol=
icy())
Merging scsi/for-next (a4908d243762 Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in include/linux/blkdev.h
CONFLICT (modify/delete): fs/exofs/ore_raid.c deleted in scsi/for-next and =
modified in HEAD. Version HEAD of fs/exofs/ore_raid.c left in tree.
CONFLICT (modify/delete): fs/exofs/ore.c deleted in scsi/for-next and modif=
ied in HEAD. Version HEAD of fs/exofs/ore.c left in tree.
CONFLICT (content): Merge conflict in drivers/scsi/arcmsr/arcmsr_hba.c
$ git rm -f fs/exofs/ore.c fs/exofs/ore_raid.c
Merging scsi-mkp/for-next (8beb90aaf334 scsi: fcoe: make use of fip_mode en=
um complete)
CONFLICT (content): Merge conflict in drivers/scsi/qla2xxx/qla_init.c
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (53cb6e5b4ab4 arch: move common mmap flags to linu=
x/mman.h)
CONFLICT (content): Merge conflict in kernel/dma/swiotlb.c
Merging rpmsg/for-next (19f5ccc8bbc9 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (63867e5c5191 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (2a9e27408e12 gpio: mockup: rework debugfs =
interface)
Merging pinctrl/for-next (267f57cf060e Merge branch 'devel' into for-next)
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
Merging y2038/y2038 (a2318b6a16a8 riscv: Use latest system call ABI)
Merging livepatching/for-next (b420648f103d Merge branch 'for-5.1-atomic-re=
place' into for-next)
Merging coresight/next (37af13cc74d1 perf record: implement --affinity=3Dno=
de|cpu option)
Merging rtc/rtc-next (67075b63cce2 rtc: add AB-RTCMC-32.768kHz-EOZ9 RTC sup=
port)
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
Merging gnss/gnss-next (d4584bbfcf2a gnss: add driver for mediatek receiver=
s)
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
Merging auxdisplay/auxdisplay (a3b22b9f11d9 Linux 5.0-rc7)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (f67dcc84eb36 selftests: add tests for pidfd_send_si=
gnal())
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Merging akpm-current/current (6f09fa191b50 zram: default to lzo-rle instead=
 of lzo)
CONFLICT (content): Merge conflict in scripts/gcc-plugins/Kconfig
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/kernfs.h
CONFLICT (content): Merge conflict in include/linux/fs.h
Applying: drm/nouveau/dmem: update for struct hmm_devmem_ops member change
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
Applying: treewide-add-checks-for-the-return-value-of-memblock_alloc-fix-3-=
fix
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
Merging akpm/master (bee76a9b4d0e drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/uvWtato.4/sj52T7v+snXRO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxtBS0ACgkQAVBC80lX
0GwJpwf+PSNG6V4eNjoFLjAFoiXcwH3yDnHIUstkJ158+WBi5iVDeMDOXRnDQ8xO
PMV0LE1sn8cJR/2Yb7Wq1V+4c3u4S5MCONA71snnSH355h3axid+OAVA+9j6dbnZ
yjRaBPqRyXjGQ/LDIOMfThnTEf7BMpwXHRq3XMaO3WhY3tA+F7PMVbVjmSEo9czx
8kZ4RpF1cBLeCVSmZA6jhwj+FXTEbTG2xiNHMn8mWN+4lpBN2tPjXS0m8eLltIUX
0hj4OWxCyWzYdtsXt3Lcl4HI8inB5MFTPvEFXnOmfVilrPgdrbHtQnl9188dETv/
dM53eZJKmUdfQSBi3UENwjzpXvATfg==
=lJ3s
-----END PGP SIGNATURE-----

--Sig_/uvWtato.4/sj52T7v+snXRO--
