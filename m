Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20904C32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B702086B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 03:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G+XSH2NT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B702086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbeKGMpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:45:13 -0500
Received: from ozlabs.org ([203.11.71.1]:59493 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbeKGMpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:45:12 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42qWm64P47z9sCX;
        Wed,  7 Nov 2018 14:16:38 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1541560598;
        bh=2hCoHi4fVIqUTU/5F4g8k2hbC8+k6ngmOQ8QzHKRCvE=;
        h=Date:From:To:Cc:Subject:From;
        b=G+XSH2NTFSyLtUaLhyoZ0KgwxTkSQE0dWXAq8FYqrVQsGsr6e9hMq2pE8vM/3Mebz
         WwgN2eCl4TLH1EqIcDnjnYc/ivqpUxDRi/7qycVJmLipOnf6sG//dFo9KFCJ5igCSN
         Sxwl6OhyvudOxSv57Ze9DxZYfpV9P36Ct6qIrArROlgPLeyrX8EA4HcpmdErc0FkzT
         STgFXOIwBAlcbkXUbHhGjaSEouYsDB71lFpea5OwwY6V1FRsd98LFrpXkN6YWLDQmr
         RANt8VY06QLo/y1WN1H9OnSkxLoV0NapGqL4H9h3oNJ1yo4J6jQU4PdOxOwXzV3CXT
         /uv9jCPQCC4VA==
Date:   Wed, 7 Nov 2018 14:16:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 7
Message-ID: <20181107141637.7237e47a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_p4+cIjU+++G0d4vwXvAksH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_p4+cIjU+++G0d4vwXvAksH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20181106:

New trees: slimbus, nvmem

The tip tree still had its build failure for which I applied a fix patch.

Non-merge commits (relative to Linus' tree): 1408
 1540 files changed, 69938 insertions(+), 65849 deletions(-)

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

I am currently merging 296 trees (counting Linus' and 67 trees of bug
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
Merging origin/master (8053e5b93eca Merge tag 'trace-v4.20-rc1' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace)
Merging fixes/master (7c6c54b505b8 Merge branch 'i2c/for-next' of git://git=
.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging kbuild-current/fixes (02826a6ba301 kbuild: deb-pkg: fix bindeb-pkg =
breakage when O=3D is used)
Merging arc-current/for-curr (d94cf77e44d5 ARC: [plat-hsdk] Enable DW APB G=
PIO support)
Merging arm-current/fixes (3a58ac65e2d7 ARM: 8799/1: mm: fix pci_ioremap_io=
() offset check)
Merging arm64-fixes/for-next/fixes (ca2b497253ad arm64: perf: Reject stand-=
alone CHAIN events for PMUv3)
Merging m68k-current/for-linus (58c116fb7dc6 m68k/sun3: Remove is_medusa an=
d m68k_pgtable_cachemode)
Merging powerpc-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging sparc/master (1f2b5b8e2df4 sparc64: Wire up compat getpeername and =
getsockname.)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (042cb5647815 net: phy: Allow BCM54616S PHY to setup int=
ernal TX/RX clock delay)
Merging bpf/master (ea53abfab960 bonding/802.3ad: fix link_failure_count tr=
acking)
Merging ipsec/master (533555e5cbb6 xfrm: Fix error return code in xfrm_outp=
ut_one())
Merging netfilter/master (a422757e8c32 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/pablo/nf)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (b374e8686fc3 mt76: fix building without CO=
NFIG_LEDS_CLASS)
Merging mac80211/master (8d0be26c781a mac80211_hwsim: fix module init error=
 paths for netlink)
Merging rdma-fixes/for-rc (651022382c7f Linux 4.20-rc1)
Merging sound-current/for-linus (5e93a125f521 ALSA: hda - Fix incorrect cle=
arance of thinkpad_acpi hooks)
Merging sound-asoc-fixes/for-linus (6eeb153e005f Merge branch 'asoc-4.20' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (35a7f35ad1b1 Linux 4.19-rc8)
Merging regulator-fixes/for-linus (651022382c7f Linux 4.20-rc1)
Merging spi-fixes/for-linus (66460685fb71 Merge branch 'spi-4.20' into spi-=
linus)
Merging pci-current/for-linus (651022382c7f Linux 4.20-rc1)
Merging driver-core.current/driver-core-linus (651022382c7f Linux 4.20-rc1)
Merging tty.current/tty-linus (202dc3cc10b4 serial: sh-sci: Fix receive on =
SCIFA/SCIFB variants with DMA)
Merging usb.current/usb-linus (651022382c7f Linux 4.20-rc1)
Merging usb-gadget-fixes/fixes (d9707490077b usb: dwc2: Fix call location o=
f dwc2_check_core_endianness)
Merging usb-serial-fixes/usb-linus (0238df646e62 Linux 4.19-rc7)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (651022382c7f Linux 4.20-rc1)
Merging staging.current/staging-linus (651022382c7f Linux 4.20-rc1)
Merging char-misc.current/char-misc-linus (651022382c7f Linux 4.20-rc1)
Merging soundwire-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging input-current/for-linus (cacd9759eea2 Merge branch 'next' into for-=
linus)
Merging crypto-current/master (a1c6fd4308d3 crypto: chelsio - Update ntx qu=
eue received from cxgb4)
Merging ide/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (98ee3fc7ef83 mtd: nand: Fix nanddev_pos_next_page=
() kernel-doc header)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (10492ee8ed91 mfd: omap-usb-host: Fix dts p=
robe of children)
Merging v4l-dvb-fixes/fixes (df18bfd35bbf media: v4l: fix uapi mpeg slice p=
arams definition)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (d01501f85249 MIPS: Fix `dma_alloc_coherent' =
returning a non-coherent allocation)
Merging at91-fixes/at91-fixes (651022382c7f Linux 4.20-rc1)
Merging omap-fixes/fixes (c265c0ca76fb ARM: dts: logicpd-som-lv: Fix OMAP35=
/DM37 Compatibility issues)
Merging kvm-fixes/master (5f8bb004bca4 KVM: vmx: hyper-v: don't pass EPT co=
nfiguration info to vmx_hv_remote_flush_tlb())
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (e3e61f01d755 hwmon: (ibmpowernv) Remove bogus __=
init annotations)
Merging nvdimm-fixes/libnvdimm-fixes (4628a64591e6 mm: Preserve _PAGE_DEVMA=
P across mprotect() calls)
Merging btrfs-fixes/next-fixes (7cd1961f67f4 Merge branch 'misc-4.20' into =
next-fixes)
Merging vfs-fixes/fixes (3df629d873f8 gfs2_meta: ->mount() can get NULL dev=
_name)
Merging dma-mapping-fixes/for-linus (f62717551b2b arm64: fix warnings witho=
ut CONFIG_IOMMU_DMA)
Merging i3c-fixes/master (651022382c7f Linux 4.20-rc1)
Merging drivers-x86-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging samsung-krzk-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging devicetree-fixes/dt/linus (c961cb3be906 of: Fix cpu node iterator t=
o not ignore disabled cpu nodes)
Merging scsi-fixes/fixes (85ee0a7b2d53 Revert "scsi: ufs: Disable blk-mq fo=
r now")
Merging drm-fixes/drm-fixes (651022382c7f Linux 4.20-rc1)
Merging drm-intel-fixes/for-linux-next-fixes (df5e31c204b3 drm/i915: Fix il=
k+ watermarks when disabling pipes)
Merging mmc-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (a8939766c75c drm/sun4i: tcon: =
prevent tcon->panel dereference if NULL)
Merging kbuild/for-next (a4219aff51b8 kernel hacking: support building kern=
el with -Og optimization level)
Merging compiler-attributes/compiler-attributes (651022382c7f Linux 4.20-rc=
1)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (886643b76632 arm64: use the generic swiotlb_d=
ma_ops)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (3e98d240981a Merge branches 'fixes', 'misc' and 'spec=
tre' into for-next)
Merging arm-perf/for-next/perf (5b394b2ddf03 Linux 4.19-rc1)
Merging arm-soc/for-next (eb8380cd4bc7 ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (6456dc61314e Merge branch 'v4.20/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (3368e06e2a91 ARM: dts: aspeed: Adding Facebook Tio=
gaPass BMC)
Merging at91/at91-next (651022382c7f Linux 4.20-rc1)
Merging bcm2835/for-next (a4c701c5cf86 Merge branch 'bcm2835-soc-next' into=
 for-next)
Merging imx-mxs/for-next (d52afa81dfba Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (42ac5fee3a13 Merge branch 'v4.19-next/soc' into =
for-next)
Merging mvebu/for-next (0f8a14a7cb8c Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (21f0bd425b67 Merge branch 'omap-for-v4.20/omap1' int=
o for-next)
Merging reset/reset/next (79ae4910fe00 ARC: HSDK: improve reset driver)
Merging qcom/for-next (6252f3298861 Merge tag 'qcom-arm64-defconfig-for-4.2=
0' into 4.20-tagged)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (f9e55cfb6b4e Merge branches 'fixes-for-v4.20', 'dt-bi=
ndings-for-v4.21', 'arm-defconfig-for-v4.21', 'arm-dt-for-v4.21', 'arm64-dt=
-for-v4.21' and 'arm64-defconfig-for-v4.21' into next)
Merging rockchip/for-next (a4b41c9496ca Merge branch 'v4.21-armsoc/drivers'=
 into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (d7a88a82dc0a Merge branch 'next/soc64' into =
for-next)
Merging sunxi/sunxi/for-next (19357aba5f14 Merge branches 'sunxi/clk-for-4.=
21', 'sunxi/config64-for-4.21', 'sunxi/dt-for-4.21', 'sunxi/dt64-for-4.21' =
and 'sunxi/h3-h5-for-4.21' into sunxi/for-next)
Merging tegra/for-next (22fed951fe3b Merge branch for-4.20/arm64/dt into fo=
r-next)
CONFLICT (content): Merge conflict in drivers/firmware/tegra/bpmp.c
Merging arm64/for-next/core (966866892cf8 arm64: kprobe: make page to RO mo=
de when allocate it)
Merging clk/clk-next (532d059c04f9 Merge branch 'clk-qcom-qcs404-rpm' into =
clk-next)
Merging clk-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (252050365823 dt-bindings: timer: gx6605s SOC timer)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging ia64/next (f84cb541f67c ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (651022382c7f Linux 4.20-rc1)
Merging microblaze/next (c4347b05440f microblaze/PCI: Remove stale pcibios_=
align_resource() comment)
Merging mips/mips-next (b3a428b4b18d MIPS: Enable IOREMAP_PROT config optio=
n for MIPS cpus)
Merging nds32/next (62d353f973a5 math-emu/soft-fp.h: (_FP_ROUND_ZERO) cast =
0 to void to fix warning)
Merging nios2/for-next (c7c09dc187f0 nios2: kconfig: remove duplicate DEBUG=
_STACK_USAGE symbol defintions)
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (86d4d068df57 parisc: Revert "Release spinlocks =
using ordered store")
Merging powerpc/next (651022382c7f Linux 4.20-rc1)
Merging fsl/next (b6ae3550c8e2 powerpc/8xx: add missing header in 8xx_mmu.c)
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (c31aa5c41f3b automerging branch "kernel.org-palmer=
-linux/next-revert_udivmoddi4" into "for-next")
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (02522ad77fb7 s390: update defconfigs)
Merging sparc-next/master (345671ea0f92 Merge branch 'akpm' (patches from A=
ndrew))
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (917e2fd2c53e um: Make line/tty semantics use true w=
rite IRQ)
Merging xtensa/xtensa-for-next (11418596b31f Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (e18b78fa9833 Merge branch 'for-next-next-v4.2=
0-20181106' into for-next-20181106)
Merging ceph/master (ea4cdc548e5e ceph: new mount option to disable usage o=
f copy-from op)
Merging cifs/for-next (f217ada478a7 smb3: do not call cifs functions in err=
or path in rename)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (cebea08e6f31 Pull fsnotify umount race fix.)
Merging ext4/dev (33458eaba4df ext4: fix use-after-free race in ext4_remoun=
t()'s error path)
Merging f2fs/dev (78130819695f f2fs: fix to keep project quota consistent)
Merging fuse/for-next (5571f1e65486 fuse: enable caching of symlinks)
Merging jfs/jfs-next (a83722f45c5b jfs: fix spelling mistake, EACCESS -> EA=
CCES)
Merging nfs/linux-next (8697930f00dc NFSv4: Ensure that the state manager e=
xits the loop on SIGKILL)
Merging nfs-anna/linux-next (9f0c5124f4a8 NFS: Don't open code clearing of =
delegation state)
Merging nfsd/nfsd-next (2ab42ae2621d nfsd4: forbid all renames during grace=
 period)
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (d47748e5ae5a ovl: automatically enable re=
direct_dir on metacopy=3Don)
Merging ubifs/linux-next (84db119f5a83 ubifs: Remove unneeded semicolon)
Merging v9fs/9p-next (fb488fc1f2b4 9p/trans_fd: put worker reqs on destroy)
Merging xfs/for-next (837514f7a4ca xfs: fix overflow in xfs_attr3_leaf_veri=
fy)
Merging file-locks/locks-next (f29209fcb47f VFS: locks: remove unnecessary =
white space.)
Merging vfs/for-next (d708e87ca399 Merge branch 'work.mount' into for-next)
CONFLICT (content): Merge conflict in fs/proc/inode.c
CONFLICT (content): Merge conflict in fs/f2fs/super.c
CONFLICT (content): Merge conflict in fs/compat_ioctl.c
CONFLICT (content): Merge conflict in drivers/vfio/Kconfig
CONFLICT (content): Merge conflict in drivers/infiniband/Kconfig
CONFLICT (content): Merge conflict in arch/sparc/kernel/setup_64.c
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a61eee132f1e Merge branch 'for-4.20-vsprintf-hash-=
fixes' into for-next)
Merging pci/next (651022382c7f Linux 4.20-rc1)
Merging pstore/for-next/pstore (1227daa43bce pstore/ram: Clarify resource r=
eservation labels)
Merging hid/for-next (0aef342184e3 Merge branch 'for-4.19/fixes' into for-n=
ext)
Merging i2c/i2c/for-next (012ebc3b7801 MAINTAINERS: add maintainer for IMX =
LPI2C driver)
Merging i3c/i3c/next (71e60757e1ea dt-bindings: i3c: Document Cadence I3C m=
aster bindings)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (175acd4a6930 hwmon: (adt7475) document ma=
pping of sysfs entries to inputs)
Merging jc_docs/docs-next (aea74de4b216 docs: Fix typos in histogram.rst)
Merging v4l-dvb/master (fbe57dde7126 media: ov7740: constify structures sto=
red in fields of v4l2_subdev_ops structure)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (217188d9f985 video: fbdev: remove redundant '=
default n' from Kconfig-s)
Merging pm/linux-next (9e074f4644f0 Merge branch 'pm-sleep' into linux-next)
Merging cpupower/cpupower (dbc4ca339c8d tools cpupower: Override CFLAGS ass=
ignments)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (534245cc69c2 OPP: Remove of_dev_pm_opp_find_req=
uired_opp())
Merging thermal/next (c2b59d279dbb thermal: core: using power_efficient_wq =
for thermal worker)
Merging thermal-soc/next (760eea43f8c6 thermal: da9062/61: Prevent hardware=
 access during system suspend)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (da689221f952 xen/blkfront: avoid NULL blkfront_=
info dereference on device removal)
Merging rdma/for-next (651022382c7f Linux 4.20-rc1)
Merging net-next/master (5882d526d887 Merge branch 'net-dsa-bcm_sf2-Store-r=
ules-in-lists')
Merging bpf-next/master (5e1abdc3fe56 net: skbuff.h: remove unnecessary unl=
ikely())
Merging ipsec-next/master (8d4b6bce2559 xfrm: use complete IPv6 addresses f=
or hash)
Merging mlx5-next/mlx5-next (94a04d1d3d36 net/mlx5: Expose DC scatter to CQ=
E capability bit)
Merging netfilter-next/master (44adbac8f721 Merge branch 'work.tty-ioctl' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (7d129adff3af rtlwifi: rtl8192de: Fix =
misleading REG_MCUFWDL information)
Merging bluetooth/master (8053e5b93eca Merge tag 'trace-v4.20-rc1' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace)
Merging mac80211-next/master (4b42745211af Merge tag 'armsoc-soc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc)
Merging gfs2/for-next (82a3ca565664 gfs2: Put bitmap buffers in put_super)
Merging mtd/mtd/next (d24dbd7541ff mtd: maps: Get rid of the latch-addr-fla=
sh driver)
Merging nand/nand/next (647ad49ca672 staging: Remove the mt29f_spinand driv=
er)
Merging spi-nor/spi-nor/next (41fe242979e4 mtd: spi-nor: fsl-quadspi: fix r=
ead error for flash size larger than 16MB)
Merging crypto/master (a1c6fd4308d3 crypto: chelsio - Update ntx queue rece=
ived from cxgb4)
Merging drm/drm-next (651022382c7f Linux 4.20-rc1)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (f45a7977d114 drm/i915: Don't oops during =
modeset shutdown after lpe audio deinit)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_reg.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_irq.c
Merging drm-tegra/drm/tegra/for-next (5ac93f81096a drm/tegra: Detach device=
s from IOMMU DMA domain on arm32)
Merging drm-misc/for-linux-next (e7afb623b4fb drm: Add drm_any_plane_has_fo=
rmat())
Merging drm-msm/msm-next (fa81b1ad6976 drm/msm: dpu: Don't set legacy plane=
->crtc pointer)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/hdmi/hdmi.c
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (fd99bd8b805c drm: malidp: Add the siz=
e of the superblocks when calculating total size for AFBC buffers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (6cec571b70ec drm/imx: ipuv3-plane: add functi=
on to query atomic update status)
Merging etnaviv/etnaviv/next (3283ee771c88 drm/etnaviv: consolidate hardwar=
e fence handling in etnaviv_gpu)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (031aef723a7d Merge remote-tracking branches 'regma=
p/topic/noinc' and 'regmap/topic/single-rw' into regmap-next)
Merging sound/for-next (ad43d528a7ac ALSA: usb-audio: Define registers for =
CM6206)
Merging sound-asoc/for-next (716e61839e8f Merge branch 'asoc-4.21' into aso=
c-next)
Merging modules/modules-next (651022382c7f Linux 4.20-rc1)
Merging input/next (f39f8688888a Input: synaptics - avoid using uninitializ=
ed variable when probing)
Merging block/for-next (f4bd8e08fb9d Merge branch 'for-linus' into for-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (da4ad3a23af3 dm writecache: remove disabled=
 code in memory_entry())
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (a15874957b40 dt-bindings: mmc: fsl-imx-esdhc: add imx8qxp=
 compatible string)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
Merging md/for-next (af9b926de9c5 MD: Memory leak when flush bio size is ze=
ro)
Merging mfd/for-mfd-next (6eb357844373 mfd: cros_ec: Avoid unneeded interna=
l declaration warning)
Merging backlight/for-backlight-next (e1c9f2eaa0fb backlight: Remove ld9040=
 driver)
Merging battery/for-next (651022382c7f Linux 4.20-rc1)
Merging regulator/for-next (61d0de0543a6 regulator: pfuze100-regulator: add=
 coin support to PF0100)
Merging security/next-testing (3bd5c4efee1c Merge tag 'loadpin-security-nex=
t' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-=
testing)
Merging apparmor/apparmor-next (5f21585384a4 Merge tag 'for-linus-20181102'=
 of git://git.kernel.dk/linux-block)
Merging integrity/next-integrity (34bccd61b139 MAINTAINERS: add Jarkko as m=
aintainer for trusted keys)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (5df275cd4cf5 selinux: policydb - fix byte order and a=
lignment issues)
Merging tpmdd/next (cfafe7fa5eb2 tpm: tpm_ibmvtpm: fix kdoc warnings)
Merging watchdog/master (cd6ba41c192d watchdog: ts4800: release syscon devi=
ce node in ts4800_wdt_probe())
Merging iommu/next (4e381e925dca Merge branches 'iommu/fixes', 'arm/renesas=
', 'arm/mediatek' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (104c7405a64d vfio: add edid support to mbochs sample dri=
ver)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (ea956d8be91e audit: print empty EXECVE args)
Merging devicetree/for-next (d061864b89c3 ARM: dt: relicense two DT binding=
 IRQ headers)
Merging mailbox/mailbox-for-next (9f0a0a381c5d mailbox: mediatek: Add check=
 for possible failure of kzalloc)
Merging spi/for-next (e4c54276eeca Merge branch 'spi-4.21' into spi-next)
Merging tip/auto-latest (11b080f48a8a Merge branch 'x86/urgent')
Applying: fix for "locking/atomics: Check generated headers are up-to-date"
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (8fd8cbfeada5 EDAC, qcom_edac: Remove irq_handled=
 local variable)
Merging irqchip/irq/irqchip-next (2130b789b3ef irqchip/gic: Unify GIC prior=
ity definitions)
Merging ftrace/for-next (a2acce536921 tracing: Have stack tracer trace full=
 stack)
Merging rcu/rcu/next (0b1aba265b93 Merge LKMM and RCU branches)
Merging kvm/linux-next (22a7cdcae6a4 KVM/nVMX: Do not validate that posted_=
intr_desc_addr is page aligned)
Merging kvm-arm/next (e4e11cc0f81e KVM: arm64: Safety check PSTATE when ent=
ering guest and handle IL)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (6e301a8e56e4 KVM: PPC: Optimize clearing TCEs=
 for sparse tables)
Merging kvms390/next (ed3054a30258 Merge branch 'apv11' of git://git.kernel=
.org/pub/scm/linux/kernel/git/kvms390/linux into kernelorgnext)
Merging xen-tip/linux-next (6cc4a0863c97 xen-blkfront: fix kernel panic wit=
h negotiate_mq error path)
Merging percpu/for-next (ad19ef010db1 Merge branch 'for-4.19-fixes' into fo=
r-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (651022382c7f Linux 4.20-rc1)
Merging chrome-platform/for-next (bc3f4b5c60db platform/chrome: chromeos_tb=
mc - Remove unneeded const)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (eabf06ed6169 Fix pattern handling optimalization)
Merging ipmi/for-next (99d18a3da861 ipmi: clean an indentation issue, remov=
e extraneous space)
Merging driver-core/driver-core-next (651022382c7f Linux 4.20-rc1)
Merging usb/usb-next (651022382c7f Linux 4.20-rc1)
Merging usb-gadget/next (3b766f453557 USB: net2280: Remove ->disconnect() c=
allback from net2280_pullup())
Merging usb-serial/usb-next (17c42e34997a USB: serial: cypress_m8: remove s=
et but not used variable 'iflag')
Merging usb-chipidea-next/ci-for-usb-next (59739131e0ca usb: chipidea: Fix =
otg event handler)
Merging phy-next/next (651022382c7f Linux 4.20-rc1)
Merging tty/tty-next (651022382c7f Linux 4.20-rc1)
Merging char-misc/char-misc-next (651022382c7f Linux 4.20-rc1)
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (651022382c7f Linux 4.20-rc1)
Merging staging/staging-next (c49d3f3fa686 staging: greybus: loopback.c: re=
move unused lists)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (23ba90b47dfc interconnect: fix build error without DE=
BUGFS)
Merging slave-dma/next (651022382c7f Linux 4.20-rc1)
Merging cgroup/for-next (e4b97fff6f7f cpuset: Use descriptive text when rea=
ding/writing cpuset.sched.partition)
Merging scsi/for-next (615a1fed8f42 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (33279c305d07 scsi: mvsas: Remove set but not use=
d variable 'id')
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (79f800b2e769 MAINTAINERS: remove reference to bog=
us vsock file)
Merging rpmsg/for-next (0c0e4ddae234 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (f06db74ce447 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (b533adfdb2f6 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging pwm/for-next (2153bbc12f77 pwm: lpss: Only set update bit if we are=
 actually changing the settings)
Merging userns/for-next (a36700589b85 signal: Guard against negative signal=
 numbers in copy_siginfo_from_user32)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9b25436662d5 random: make CPU trust a boot parameter)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (e55c884ea5c6 media: rc: self test for IR encoders a=
nd decoders)
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (24a3858f031e coresight: tmc: Fix bad register addre=
ss for CLAIM)
Merging rtc/rtc-next (3822d1bb0df1 rtc: sc27xx: Always read normal alarm wh=
en registering RTC device)
Merging nvdimm/libnvdimm-for-next (594861215c83 acpi, nfit: Further restric=
t userspace ARS start requests)
Merging at24/at24/for-next (9a9e295e7c5c eeprom: at24: fix unexpected timeo=
ut under high load)
Merging ntb/ntb-next (651022382c7f Linux 4.20-rc1)
Merging kspp/for-next/kspp (ec9b3877c2fd Merge branch 'for-next/array_size'=
 into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ff6401301656 Merge branch 'for-powerpc' into for-ne=
xt)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging fsi/master (15e2a7218c27 fsi: sbefifo: Bump max command length)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (3651f0177f22 slimbus: qcom-ctrl: simplify getting=
 .driver_data)
Merging nvmem/for-next (668f51ae2fd2 nvmem: core: fix regression in of_nvme=
m_cell_get())
Merging xarray/xarray (8f3f4351bac3 XArray: Correct some 64-bit assumptions)
Merging akpm-current/current (3b2dca79c671 ipc: conserve sequence numbers i=
n extended IPCMNI mode)
CONFLICT (content): Merge conflict in include/linux/compiler-gcc.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (9be757b36db8 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/_p4+cIjU+++G0d4vwXvAksH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlviWRUACgkQAVBC80lX
0GycVAf/XXSNvAx8Gr6OGOb5rMiQ9g57rilhUpld/uaxDm3b4loW0r15DAD49dFx
HWH6CSKlSzK1UDPKcsCAzbUYB+ReMwMZqubN9O3ZN6hzk7kjghTUpBYwFkyhJLgt
J3m9t0NK1+mF8TSJUCJOUBSznRO2ZPYp2grBZdH1jBaPQg2r+1Qo0b2wJLDQ6nLm
Y1JTWCHvf2uTtgDTrXHnMvsDFromeudrdXO9HMMfmkyM5x9Sr/HBlQK0koB+ZOAu
a5PaKX1Uet5Bfo1zly48PAiSiJ7DebKNC/Qr8r4M85osDbNFUwSiW96GwLdIP+Sa
mxYcR6kSSn6n/fPENYcdE5VWqUAHwg==
=GOIR
-----END PGP SIGNATURE-----

--Sig_/_p4+cIjU+++G0d4vwXvAksH--
