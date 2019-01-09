Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED84C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5CE2146F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YsQ8v3tK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfAIDPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:15:44 -0500
Received: from ozlabs.org ([203.11.71.1]:38781 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfAIDPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:15:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43ZDlt1qH7z9sD9;
        Wed,  9 Jan 2019 14:15:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547003738;
        bh=U9CErxXT5Q/iXxlXE46iavD4VJPAX48EIgX9h2CJCGY=;
        h=Date:From:To:Cc:Subject:From;
        b=YsQ8v3tKf0hiTwuO5kOrm13YksNZtqH3L4jpybJhF38zK256LxHZLGFddPxPPsjxW
         J4fvOhQwRouve1StMrXhwhCe2LzrDFBkE+DeA+Q7EtxPrAC0E0EMoMG2tyjbaicFra
         166QT5kGqmrKmzG9xbEgGcr+paytrk+uT7hVHqyvHkHu059Ns8ZEaH//vwmSdQsCXn
         iHcXtbP9prtFyQw1HXkiRf1jUssdd9ctu4IyAWr6RQKIJ/Q0fXkuJmlfaVkXN3hyMZ
         lwR7i/bZVTWxEBHv69eFmamRmJGThK8l1s4P29Jy7+FtQofHdHB+Cto+pTipVmV7FI
         ONEp/umYFY2Cw==
Date:   Wed, 9 Jan 2019 14:15:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 9
Message-ID: <20190109141535.1facd02a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7vIro16Ly+moUVHYgalgkbJ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7vIro16Ly+moUVHYgalgkbJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190108:

New tree: pidfd

The vfs tree still had its build failure for which I applied a patch.

The drm-misc tree still has its build failure but I have applied a
supplied merge resolution patch.

The akpm-current tree lost its build failure.

Non-merge commits (relative to Linus' tree): 1141
 1181 files changed, 36484 insertions(+), 18562 deletions(-)

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

I am currently merging 294 trees (counting Linus' and 69 trees of bug
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
Merging origin/master (7b5585136713 fork: record start_time late)
Merging fixes/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging kbuild-current/fixes (3bd6e94bec12 arch: restore generic-y +=3D shm=
param.h for some architectures)
Merging arc-current/for-curr (5fac3149be6f ARC: adjust memblock_reserve of =
kernel memory)
Merging arm-current/fixes (c2a3831df6dc ARM: 8816/1: dma-mapping: fix poten=
tial uninitialized return)
Merging arm64-fixes/for-next/fixes (3238c359acee arm64: dma-mapping: Fix FO=
RCE_CONTIGUOUS buffer clearing)
Merging m68k-current/for-linus (bed1369f5190 m68k: Fix memblock-related cra=
shes)
Merging powerpc-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging sparc/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (4314b1f68a3f Merge branch 'mlxsw-fixes')
Merging bpf/master (977e4899c9b4 Merge ra.kernel.org:/pub/scm/linux/kernel/=
git/bpf/bpf)
Merging ipsec/master (3061169a47ee Merge git://git.kernel.org/pub/scm/linux=
/kernel/git/bpf/bpf)
Merging netfilter/master (a0071840d204 lan743x: Remove phy_read from link s=
tatus change function)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (bfeffd155283 Linux 5.0-rc1)
Merging mac80211/master (1d51b4b1d3f2 Merge tag 'm68k-for-v4.20-tag2' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k)
Merging rdma-fixes/for-rc (bfeffd155283 Linux 5.0-rc1)
Merging sound-current/for-linus (f5c9571e2265 ALSA: usb-audio: fix CM6206 r=
egister definitions)
Merging sound-asoc-fixes/for-linus (b3ae23ff5440 Merge branch 'asoc-5.0' in=
to asoc-linus)
Merging regmap-fixes/for-linus (1cd824361eed Merge branch 'regmap-4.21' int=
o regmap-5.0)
Merging regulator-fixes/for-linus (d6afa2bed004 regulator: bcm590xx: Fix .e=
nable_reg for BCM590XX_REG_VSR)
Merging spi-fixes/for-linus (aa54c1c9d90e spi: fix initial SPI_SR value in =
spi-fsl-dspi)
Merging pci-current/for-linus (a3869d43c980 PCI: amlogic: Fix build failure=
 due to missing gpio header)
Merging driver-core.current/driver-core-linus (735df0ff6ece Documentation: =
driver core: remove use of BUS_ATTR)
Merging tty.current/tty-linus (d3a28a53630e serial: lantiq: Do not swap reg=
ister read/writes)
Merging usb.current/usb-linus (b9fcb0e6b705 usb: storage: Remove outdated U=
RL from MAINTAINERS)
Merging usb-gadget-fixes/fixes (069caf5950df USB: omap_udc: fix rejection o=
f out transfers when DMA is used)
Merging usb-serial-fixes/usb-linus (b81c2c33eab7 USB: serial: simple: add M=
otorola Tetra TPG2200 device id)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (3bd6e94bec12 arch: restore generic-y +=3D shmparam.h for=
 some architectures)
Merging staging.current/staging-linus (7775665aadc4 staging: rtl8188eu: Fix=
 module loading from tasklet for WEP encryption)
Merging char-misc.current/char-misc-linus (b6c770d7c9dc binderfs: make each=
 binderfs mount a new instance)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging input-current/for-linus (592b15ba7260 Merge branch 'next' into for-=
linus)
Merging crypto-current/master (c79b411eaa72 crypto: skcipher - remove remna=
nts of internal IV generators)
Merging ide/master (adf040ddd001 ide: Use of_node_name_eq for node name com=
parisons)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (2b6f0090a333 mtd: Check add_mtd_device() ret code)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (565dc8a4f55e MIPS: ath79: Enable OF serial p=
orts in the default config)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
Merging omap-fixes/fixes (ef4a55b9197a ARM: dts: omap4-droid4: Fix typo in =
cpcap IRQ flags)
Merging kvm-fixes/master (3cf85f9f6bd7 KVM: x86: nSVM: fix switch to guest =
mmu)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (cbb59b72b796 hwmon: (occ) Fix potential integer =
overflow)
Merging nvdimm-fixes/libnvdimm-fixes (2c5357c6a2f2 Merge branch 'for-4.20/d=
ax-fixes' into libnvdimm-pending)
Merging btrfs-fixes/next-fixes (72549bc085d6 Merge branch 'misc-4.20' into =
next-fixes)
Merging vfs-fixes/fixes (ea5751ccd665 proc/sysctl: don't return ENOMEM on l=
ookup when a table is unregistering)
Merging dma-mapping-fixes/for-linus (8270f3a11cee dma-direct: fix DMA_ATTR_=
NO_KERNEL_MAPPING for remapped allocations)
Merging i3c-fixes/master (0fac32f24cea i3c: master: Fix an error checking t=
ypo in 'cdns_i3c_master_probe()')
Merging drivers-x86-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging samsung-krzk-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (ab63e725b49c Merge tag 'for_linus' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging scsi-fixes/fixes (61cce6f6eece scsi: sd: use mempool for discard sp=
ecial page)
Merging drm-fixes/drm-fixes (bfeffd155283 Linux 5.0-rc1)
Merging drm-intel-fixes/for-linux-next-fixes (bfeffd155283 Linux 5.0-rc1)
Merging mmc-fixes/fixes (e3ae3401aa19 mmc: core: Use a minimum 1600ms timeo=
ut when enabling CACHE ctrl)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (be936c43b318 hv_balloon: avoid touching =
uninitialized struct page during tail onlining)
Merging drm-misc-fixes/for-linux-next-fixes (bfeffd155283 Linux 5.0-rc1)
Merging kbuild/for-next (3bd6e94bec12 arch: restore generic-y +=3D shmparam=
.h for some architectures)
Merging compiler-attributes/compiler-attributes (71391bdd2e9a include/linux=
/compiler_types.h: don't pollute userspace with macro definitions)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging dma-mapping/for-next (8b1cce9f5832 dma-mapping: fix inverted logic =
in dma_supported)
Merging asm-generic/master (2b3c5a99d5f3 sh: generate uapi header and sysca=
ll table header files)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (8f839a25b9cc Merge branches 'fixes', 'misc', 'sa1100-=
for-next', 'smp-hotplug' (early part) and 'spectre' into for-next)
Merging arm64/for-next/core (7e0b44e870cf arm64: compat: Hook up io_pgeteve=
nts() for 32-bit tasks)
Merging arm-perf/for-next/perf (69c32972d593 drivers/perf: Add Cavium Thund=
erX2 SoC UNCORE PMU driver)
Merging arm-soc/for-next (f217b8e70c76 ARM: Document merges)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (b28b14c7c157 Merge branch 'v4.21/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (f59cffb441bc Merge branch 'dt-for-v4.21' into for-=
next)
Merging at91/at91-next (3850dd7a32a0 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (3c9d403d2fe1 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (467e1ec42943 Merge branch 'imx8mq/dt' into for-ne=
xt)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (c2f7a6c7e1e5 Merge branch 'v4.20-next/soc' into =
for-next)
Merging mvebu/for-next (50eba438c55e Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ace233293086 Merge branch 'omap-for-v4.21/dt' into f=
or-next)
Merging reset/reset/next (d0c2d2101b4c reset: uniphier-glue: Add AHCI reset=
 control support in glue layer)
Merging qcom/for-next (9bf0624f555d Merge tag 'qcom-drivers-for-4.21-2' int=
o foobar-for-4.21-2)
Merging renesas/next (6fa419a576ac Merge branches 'fixes-for-v5.0', 'arm-de=
fconfig-for-v5.1', 'arm-dt-for-v5.1', 'arm-soc-for-v5.1', 'arm64-dt-for-v5.=
1', 'arm64-defconfig-for-v5.1' and 'dt-bindings-for-v5.1' into next)
Merging rockchip/for-next (dc272c55ced8 Merge branch 'v5.0-armsoc/dts32fixe=
s' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (6d225e309a94 Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (eb18f31cf3ab Merge branches 'sunxi/dt-for-5.1=
', 'sunxi/dt64-for-5.1' and 'sunxi/fixes-for-5.0' into sunxi/for-next)
Merging tegra/for-next (2731820ce27b Merge branch for-4.21/clk into for-nex=
t)
Merging clk/clk-next (bfeffd155283 Linux 5.0-rc1)
Merging clk-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (ee8972b1ab82 Documentation/features: Add csky kern=
el features)
CONFLICT (modify/delete): Documentation/features/io/sg-chain/arch-support.t=
xt deleted in HEAD and modified in csky/linux-next. Version csky/linux-next=
 of Documentation/features/io/sg-chain/arch-support.txt left in tree.
$ git rm -f Documentation/features/io/sg-chain/arch-support.txt
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (005e13a96c0e m68k: Generate uapi header and syscall =
table header files)
Merging m68knommu/for-next (3bd6e94bec12 arch: restore generic-y +=3D shmpa=
ram.h for some architectures)
Merging microblaze/next (19d111ccce9f microblaze: remove the explicit remov=
al of system.dtb)
Merging mips/mips-next (adcc81f148d7 MIPS: math-emu: Write-protect delay sl=
ot emulation pages)
Merging nds32/next (e2f3f8b4a497 nds32: support hardware prefetcher)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (f77dfefb9577 parisc: remove meaningless ccflags=
-y in arch/parisc/boot/Makefile)
Merging powerpc/next (bfeffd155283 Linux 5.0-rc1)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (801009424e05 Fix a handful of audit-related issue)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (52a51ad1d9dd s390/vdso: correct vdso mapping for com=
pat tasks)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (940b241d9050 um: Remove obsolete reenable_XX calls)
Merging xtensa/xtensa-for-next (f1589f675d65 Merge branch 'xtensa-jumplabel=
' into xtensa-for-next)
Merging fscrypt/master (cc0146d0bce0 fscrypt: remove CRYPTO_CTR dependency)
CONFLICT (content): Merge conflict in fs/ubifs/Kconfig
CONFLICT (content): Merge conflict in fs/f2fs/dir.c
CONFLICT (content): Merge conflict in Documentation/filesystems/index.rst
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (0078a3f8bf05 Merge branch 'for-next-current-v=
4.19-20181219' into for-next-20181219)
Merging ceph/master (c64a2b0516a0 ceph: use vmf_error() in ceph_filemap_fau=
lt())
Merging cifs/for-next (b2a932fea8c6 cifs: move large array from stack to he=
ap)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (3f0216106126 Pull quota locking fix.)
Merging ext4/dev (191ce17876c9 ext4: fix special inode number checks in __e=
xt4_iget())
Merging f2fs/dev (cd2dcebde8b8 f2fs: sync filesystem after roll-forward rec=
overy)
Merging fuse/for-next (2e64ff154ce6 fuse: continue to send FUSE_RELEASEDIR =
when FUSE_OPEN returns ENOSYS)
Merging jfs/jfs-next (a83722f45c5b jfs: fix spelling mistake, EACCESS -> EA=
CCES)
Merging nfs/linux-next (3bd6e94bec12 arch: restore generic-y +=3D shmparam.=
h for some architectures)
Merging nfs-anna/linux-next (260f71eff493 sunrpc: convert to DEFINE_SHOW_AT=
TRIBUTE)
Merging nfsd/nfsd-next (0ad30ff67bd3 nfs: fixed broken compilation in nfs_c=
allback_up_net())
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (ec7ba118b940 Revert "ovl: relax permissio=
n checking on underlying layers")
Merging ubifs/linux-next (e58725d51fa8 ubifs: Handle re-linking of inodes c=
orrectly while recovery)
Merging v9fs/9p-next (574d356b7a02 9p/net: put a lower bound on msize)
Merging xfs/for-next (90be9b86da90 xfs: xfs_fsops: drop useless LIST_HEAD)
Merging file-locks/locks-next (bf77ae4c98d7 locks: fix error in locks_move_=
blocks())
Merging vfs/for-next (1fab5fff0a7a Merge branches 'work.mount', 'work.misc'=
, 'misc.misc' and 'work.iov_iter' into for-next)
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup-v1.c
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in fs/Makefile
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/resctrl/rdtgroup.c
Applying: vfs: work around CONFIG_PRINTK=3Dn in fs_context logging code
Merging printk/for-next (15ff2069cb7f printk: Add caller information to pri=
ntk() output.)
Merging pci/next (bfeffd155283 Linux 5.0-rc1)
Merging pstore/for-next/pstore (8665569e97dd pstore/ram: Avoid NULL deref i=
n ftrace merging failure path)
Merging hid/for-next (16f3d1f5df35 Merge branch 'for-4.20/upstream-fixes' i=
nto for-next)
Merging i2c/i2c/for-next (bfeffd155283 Linux 5.0-rc1)
Merging i3c/i3c/next (25ac3da61ba1 i3c: master: cdns: fix I2C transfers in =
Cadence I3C master driver)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (c72b77ed3784 devicetree: hwmon: Add bindi=
ngs documentation for HIH6130)
Merging jc_docs/docs-next (787d07ed8b2c doc: fix typo in Documentation/hwmo=
n/f71882fg)
Merging v4l-dvb/master (1e0d0a5fd381 media: s5p-mfc: fix incorrect bus assi=
gnment in virtual child device)
Merging v4l-dvb-next/master (76097fe1aee6 media: staging/ipu3-imgu: Add MAI=
NTAINERS entry)
CONFLICT (add/add): Merge conflict in Documentation/media/v4l-drivers/ipu3.=
rst
CONFLICT (add/add): Merge conflict in Documentation/media/uapi/v4l/pixfmt-m=
eta-intel-ipu3.rst
Merging fbdev/fbdev-for-next (399382f80182 drm/nouveau: fix incorrect FB_BA=
CKLIGHT usage in Kconfig)
Merging pm/linux-next (9651c0a030b8 Merge branch 'acpi-pmic' into linux-nex=
t)
Merging cpupower/cpupower (bfeffd155283 Linux 5.0-rc1)
Merging opp/opp/linux-next (ade0c9493e97 Merge branch 'opp/genpd/propagatio=
n' into opp/linux-next)
Merging thermal/next (24ef9ec891c7 thermal/intel: fixup for Kconfig string =
parsing tightening up)
Merging thermal-soc/next (9d216211fded thermal: generic-adc: Fix adc to tem=
p interpolation)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (3595c559326d dlm: fix invalid cluster name warning)
Merging swiotlb/linux-next (da689221f952 xen/blkfront: avoid NULL blkfront_=
info dereference on device removal)
Merging rdma/for-next (91fb4d83b88a RDMA/hns: Modify the pbl ba page size f=
or hip08)
Merging net-next/master (b71acb0e3721 Merge branch 'linus' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging bpf-next/master (b71acb0e3721 Merge branch 'linus' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging ipsec-next/master (fa89a4593b92 xfrm6_tunnel: Fix spi check in __xf=
rm6_tunnel_alloc_spi)
Merging mlx5-next/mlx5-next (71bef2fd583b IB/mlx5: Introduce uid as part of=
 alloc/dealloc transport domain)
Merging netfilter-next/master (b71acb0e3721 Merge branch 'linus' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (bfeffd155283 Linux 5.0-rc1)
Merging bluetooth/master (b71acb0e3721 Merge branch 'linus' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging mac80211-next/master (44a7b3b6e3a4 Merge branch 'bnxt_en-next')
Merging gfs2/for-next (8e143b90e4d4 Merge tag 'iommu-updates-v4.21' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/joro/iommu)
Merging mtd/mtd/next (f9d27de6fafc mtd: mtdram: Expose module parameters)
Merging nand/nand/next (732774437ae0 mtd: rawnand: sunxi: Write pageprog re=
lated opcodes to WCMD_SET)
Merging spi-nor/spi-nor/next (b422847877e3 mtd: spi-nor: Add support for is=
25lp016d)
Merging crypto/master (c79b411eaa72 crypto: skcipher - remove remnants of i=
nternal IV generators)
Merging drm/drm-next (bfeffd155283 Linux 5.0-rc1)
Merging drm-intel/for-linux-next (f2bb09b63282 drm/i915: Downgrade scare me=
ssage for unknown HuC firmware)
Merging drm-tegra/drm/tegra/for-next (180b46ecdc9f drm/tegra: sor: Reset th=
e SOR if possible)
Merging drm-misc/for-linux-next (00eb5b0da8d2 drm/fb-helper: fix leaks in e=
rror path of drm_fb_helper_fbdev_setup)
Applying: drm/amd/display: fix for drm_atomic_private_obj_init() API change
Merging drm-msm/msm-next (b363cdbd40e8 drm/msm/gpu: fix building without de=
bugfs)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (fd99bd8b805c drm: malidp: Add the siz=
e of the superblocks when calculating total size for AFBC buffers)
Merging imx-drm/imx-drm/next (6cec571b70ec drm/imx: ipuv3-plane: add functi=
on to query atomic update status)
Merging etnaviv/etnaviv/next (72ac64b84b2e drm/etnaviv: move job context po=
inter to etnaviv_gem_submit)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (1cd824361eed Merge branch 'regmap-4.21' into regma=
p-5.0)
Merging sound/for-next (beae77170c60 ALSA: sb: fix a missing check of snd_c=
tl_add)
Merging sound-asoc/for-next (d344bc6c9afe Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (1cdbd3e57698 Input: tm2-touchkey - add support for arie=
s touchkey variant)
Merging block/for-next (c3f57725d1cc Merge branch 'for-4.21/block-late' int=
o for-next)
Merging device-mapper/for-next (bd938bf0b6cf Merge branch 'dm-4.20' into dm=
-next)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (5215b2e952f3 mmc: mediatek: Add MMC_CAP_SDIO_IRQ support)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (3f2d347e851e mfd: exynos-lpass: Enable UART modul=
e support)
Merging backlight/for-backlight-next (3cee7a7d05b1 backlight: 88pm860x_bl: =
Use of_node_name_eq for node name comparisons)
Merging battery/for-next (958091396648 power: supply: bq25890: fix BAT_COMP=
 field definition)
Merging regulator/for-next (6277a2253148 Merge branch 'regulator-5.1' into =
regulator-next)
Merging security/next-testing (aa99a14dfb50 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (43aa09fee2f0 apparmor: Fix warning about un=
used function apparmor_ipv6_postroute)
Merging integrity/next-integrity (eed9de3b4f47 ima: Use inode_is_open_for_w=
rite)
Merging selinux/next (ee1a84fdfeed selinux: overhaul sidtab to fix bug and =
improve performance)
Merging tpmdd/next (9488585b21be tpm: add support for partial reads)
Merging watchdog/master (4a22fc534f2f watchdog: tqmx86: Fix a couple IS_ERR=
() vs NULL bugs)
Merging iommu/next (03ebe48e235f Merge branches 'iommu/fixes', 'arm/renesas=
', 'arm/mediatek', 'arm/tegra', 'arm/omap', 'arm/smmu', 'x86/vt-d', 'x86/am=
d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (8ba35b3a0046 vfio-mdev/samples: Use u8 instead of char f=
or handle functions)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (d406db524c32 audit: remove duplicated include from audi=
t.c)
Merging devicetree/for-next (5801169a2ed2 of: __of_detach_node() - remove n=
ode from phandle cache)
Merging mailbox/mailbox-for-next (d69e11648e48 mailbox: tegra-hsp: Use devi=
ce-managed registration API)
Merging spi/for-next (6e337bbd1640 Merge branch 'spi-5.1' into spi-next)
Merging tip/auto-latest (36e910f755f8 Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (bd2bcaa565a2 Merge branch 'clockevent=
s/4.21' of http://git.linaro.org/people/daniel.lezcano/linux into timers/co=
re)
Merging edac-amd/for-next (75dfa87035f9 EDAC, fsl_ddr: Add LS1021A to the l=
ist of supported hardware)
Merging irqchip/irq/irqchip-next (fb94109b764e irqchip/stm32: protect confi=
guration registers with hwspinlock)
Merging ftrace/for-next (3d739c1f6156 tracing: Use the return of str_has_pr=
efix() to remove open coded numbers)
Merging rcu/rcu/next (9a4e3f13b7dd RCU/torture.txt: Remove section MODULE P=
ARAMETERS)
Merging kvm/linux-next (a0aea130afeb KVM: x86: Add CPUID support for new in=
struction WBNOINVD)
Merging kvm-arm/next (8c33df1afd86 arm: KVM: Add S2_PMD_{MASK,SIZE} constan=
ts)
Merging kvm-ppc/kvm-ppc-next (ae59a7e1945b KVM: PPC: Book3S HV: Keep rc bit=
s in shadow pgtable in sync with host)
Merging kvms390/next (7aedd9d48f2a KVM: s390: fix kmsg component kvm-s390)
Merging xen-tip/linux-next (1f8ce09b36c4 xen/pvcalls: remove set but not us=
ed variable 'intf')
Merging percpu/for-next (718f6757a29b Merge branch 'for-4.21' into for-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (bfeffd155283 Linux 5.0-rc1)
Merging chrome-platform/for-next (bfeffd155283 Linux 5.0-rc1)
Merging hsi/for-next (3a658e09a215 HSI: omap_ssi: Change to use DEFINE_SHOW=
_ATTRIBUTE macro)
Merging leds/for-next (8146aace60c7 led: triggers: Initialize LED_INIT_DEFA=
ULT_TRIGGER if trigger is brought after class)
Merging ipmi/for-next (d09eac7d08aa ipmi: Don't initialize anything in the =
core until something uses it)
Merging driver-core/driver-core-next (bfeffd155283 Linux 5.0-rc1)
Merging usb/usb-next (bfeffd155283 Linux 5.0-rc1)
Merging usb-gadget/next (4fe4f9fecc36 usb: dwc2: Fix disable all EP's on di=
sconnect)
Merging usb-serial/usb-next (bfeffd155283 Linux 5.0-rc1)
Merging usb-chipidea-next/ci-for-usb-next (9049fce897ed usb: chipidea: imx:=
 allow to configure oc polarity on i.MX25)
Merging phy-next/next (3bd6e94bec12 arch: restore generic-y +=3D shmparam.h=
 for some architectures)
Merging tty/tty-next (bfeffd155283 Linux 5.0-rc1)
Merging char-misc/char-misc-next (bfeffd155283 Linux 5.0-rc1)
Merging extcon/extcon-next (a2dc50914744 extcon: max8997: Fix lack of path =
setting in USB device mode)
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (bfeffd155283 Linux 5.0-rc1)
Merging staging/staging-next (c8c270240943 Staging: rts5208: Fix error hand=
ling on rtsx_send_cmd)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (f8325633fbae MAINTAINERS: add a maintainer for the in=
terconnect API)
Merging slave-dma/next (ff82595c1eb5 Merge branch 'topic/xilinx' into next)
Merging cgroup/for-next (0623413ee0ba Merge branch 'for-4.21' into for-next)
Merging scsi/for-next (1f0fe08f8a45 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (da7903092b88 scsi: isci: request: mark expected =
switch fall-through)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (7f86a211fabe virtio: use dependent_ptr_mb)
CONFLICT (content): Merge conflict in drivers/virtio/virtio_ring.c
Merging rpmsg/for-next (e9856d7eb6e4 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (862523297778 gpiolib-acpi: Remove unnecessary WARN_O=
N from acpi_gpiochip_free_interrupts)
Merging gpio-brgl/gpio/for-next (1691632a2e16 gpio: pca953x: add support fo=
r pcal6416 type)
Merging pinctrl/for-next (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (bfeffd155283 Linux 5.0-rc1)
Merging userns/for-next (1e9c75fb9c47 mnt: fix __detach_mounts infinite loo=
p)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (bfeffd155283 Linux 5.0-rc1)
Merging y2038/y2038 (e4b92b108c6c timekeeping: remove obsolete time accesso=
rs)
Merging livepatching/for-next (bd0ab5efe8ec Merge branch 'for-4.21/upstream=
' into for-next)
Merging coresight/next (675e806209e0 coresight: Use of_node_name_eq for nod=
e name comparisons)
Merging rtc/rtc-next (bfeffd155283 Linux 5.0-rc1)
Merging nvdimm/libnvdimm-for-next (8a6f7591ddf5 Merge branch 'for-5.0/dax' =
into libnvdimm-for-next)
Merging at24/at24/for-next (bfeffd155283 Linux 5.0-rc1)
Merging ntb/ntb-next (d9842b39e9ec ntb_hw_switchtec: Added support of >=3D4=
G memory windows)
Merging kspp/for-next/kspp (be1944712d8e Merge branch 'for-next/gcc-plugin/=
arm-stackprotector' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (84a401a27506 Merge branch 'for-x86' into for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging gnss/gnss-next (bfeffd155283 Linux 5.0-rc1)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (bfeffd155283 Linux 5.0-rc1)
Merging nvmem/for-next (bfeffd155283 Linux 5.0-rc1)
Merging xarray/xarray (48483614de97 XArray: Fix xa_alloc when id exceeds ma=
x)
Merging hyperv/hyperv-next (651022382c7f Linux 4.20-rc1)
Merging auxdisplay/auxdisplay (d4683eee8cd6 auxdisplay: charlcd: fix x/y co=
mmand parsing)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (64e160db7675 selftests: add tests for pidfd_send_si=
gnal())
Merging akpm-current/current (594025cb12d5 ipc: conserve sequence numbers i=
n extended IPCMNI mode)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: scripts/atomic/check-atomics.sh: don't assume that scripts are ex=
ecutable
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: locking/atomics: build atomic headers as required
Applying: kernel/fork.c: remove duplicated include
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (c4b43878fe36 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/7vIro16Ly+moUVHYgalgkbJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw1Z1cACgkQAVBC80lX
0GwzLwf+NyNAmCkfDTrEuQbGUwvx9j27QMtJXj01DvXU/CPzGc1wzudM0iAojMTE
zK+xR+27bkfymZhaEcxmBHmHcjXanATo6z/V4Euz6eUNJzCO8/sgNSix5WFF8RXu
5TsmNorYWGHTU5xcfIU7MwCF9umAAGyaI8HfmC22OoxVYlDG+xCEdASwMs9Tm37Q
ykTfFiHH2N098uDaDrOykh9k3lqqsHePqbwAwfqHySLAjS6QS2KevWqA+ST8y0hp
kxPqA129nK76p0qIFq6yVe77GRVffZIdor7jWHhEWP/COT9mwkV1VU9pgsr5JRtO
yhivhUWY96s4v2EvYQzeXCuS9ZY9tg==
=IBt/
-----END PGP SIGNATURE-----

--Sig_/7vIro16Ly+moUVHYgalgkbJ--
