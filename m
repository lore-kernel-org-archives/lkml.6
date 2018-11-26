Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4536DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BD720855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 09:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Z3TcjudM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BD720855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbeKZT5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:57:21 -0500
Received: from ozlabs.org ([203.11.71.1]:36385 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbeKZT5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:57:21 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 433LYv35Nqz9s29;
        Mon, 26 Nov 2018 20:03:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543223027;
        bh=5V5dNiX60MCAOXtSt2HlaqE19X+++eIm1XFU/2qSPpk=;
        h=Date:From:To:Cc:Subject:From;
        b=Z3TcjudMflaq+d9tBK28Bf6PNKtF72v2i9X/3QOZ9RsjSucBbDZvV6veW+qohDp/A
         Ha7Scjb/6ubT7gwNA6elZiRD0vWzYhPPeLH8Rp4qy8XyIHwAbW+r/qINnTXJ9Dqoma
         KBLjVwf+rPSatZ02YqqD0Gy1H4B70WzX5+74RF5MMWUB6jgF1d13z47ZXd+82RKxWG
         tsHmvL/gj9yBnTq728/eNoo96d3zrtZ0oE7jhM904qWBPi2ekTdEz94/OLj4x+Rezw
         TPOMSq8jsba3gUG568xqRABgrS4UF2i+iKBm3fiKdJkqVo5/bDqTdcJgoMpi5oXc09
         LjEiKWx9QxZFw==
Date:   Mon, 26 Nov 2018 20:03:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 26
Message-ID: <20181126200343.24442f5d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LhbiKSSkTrzI6rTVtl_tL0o"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LhbiKSSkTrzI6rTVtl_tL0o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20181123:

I am now building with the -Wimplicit-fallthrough gcc flag to help Kees
Cook prevent new such warnings from being added.

The mips-misc tree gained a conflict against the kbuild tree.

The drm tree gained a conflict against the drm-misc-fixes tree.

The etnaviv tree gained a conflict against the drm-misc tree.

The tip tree gained a conflict against the vfs tree.

Non-merge commits (relative to Linus' tree): 4655
 4896 files changed, 241327 insertions(+), 146539 deletions(-)

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

I am currently merging 286 trees (counting Linus' and 67 trees of bug
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
Merging origin/master (d6d460b89378 Merge tag 'dma-mapping-4.20-3' of git:/=
/git.infradead.org/users/hch/dma-mapping)
Merging fixes/master (4d8360ade996 Check for new cases of implict fallthrou=
gh)
Applying: powerpc: tag implicit fall throughs
Merging kbuild-current/fixes (ccda4af0f4b9 Linux 4.20-rc2)
Merging arc-current/for-curr (6b04114f6fae arc: [devboards] Add support of =
NFSv3 ACL)
Merging arm-current/fixes (e46daee53bb5 ARM: 8806/1: kprobes: Fix false pos=
itive with FORTIFY_SOURCE)
Merging arm64-fixes/for-next/fixes (4f9f49646a57 arm64: cpufeature: Fix mis=
merge of CONFIG_ARM64_SSBD block)
Merging m68k-current/for-linus (58c116fb7dc6 m68k/sun3: Remove is_medusa an=
d m68k_pgtable_cachemode)
Merging powerpc-fixes/fixes (b2fed34a628d selftests/powerpc: Adjust wild_bc=
tr to build with old binutils)
Merging sparc/master (86322ba9571a arch/sparc: Use kzalloc_node)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (aba36930a35e net: always initialize pagedlen)
Merging bpf/master (1efb6ee3edea bpf: fix check of allowed specifiers in bp=
f_trace_printk)
Merging ipsec/master (ca92e173ab34 xfrm: Fix bucket count reported to users=
pace)
Merging netfilter/master (38d37baa8123 ipvs: call ip_vs_dst_notifier earlie=
r than ipv6_dev_notf)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (1770f0fa978e mt76: fix uninitialized mutex=
 access setting rts threshold)
Merging mac80211/master (113f3aaa81bd cfg80211: Prevent regulatory restore =
during STA disconnect in concurrent interfaces)
Merging rdma-fixes/for-rc (24c3456c8d5e iser: set sector for ambiguous mr s=
tatus errors)
Merging sound-current/for-linus (e1a7bfe38079 ALSA: control: Fix race betwe=
en adding and removing a user element)
Merging sound-asoc-fixes/for-linus (0e37f0eb78f0 Merge branch 'asoc-4.20' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (9ff01193a20d Linux 4.20-rc3)
Merging regulator-fixes/for-linus (400dba3b3914 Merge branch 'regulator-4.2=
0' into regulator-linus)
Merging spi-fixes/for-linus (30373c19b907 Merge branch 'spi-4.20' into spi-=
linus)
Merging pci-current/for-linus (1a87119b7bcf Revert "ACPI/PCI: Pay attention=
 to device-specific _PXM node values")
Merging driver-core.current/driver-core-linus (a66d972465d1 devres: Align d=
ata[] to ARCH_KMALLOC_MINALIGN)
Merging tty.current/tty-linus (ccda4af0f4b9 Linux 4.20-rc2)
Merging usb.current/usb-linus (edeca3a769ad Merge tag 'sound-4.20-rc4' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound)
Merging usb-gadget-fixes/fixes (2fc6d4be35fb usb: dwc3: gadget: fix ISOC TR=
B type on unaligned transfers)
Merging usb-serial-fixes/usb-linus (ccda4af0f4b9 Linux 4.20-rc2)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (c88520db18ba phy: qcom-qusb2: Fix HSTX_TRIM tuning with =
fused value for SDM845)
Merging staging.current/staging-linus (c648284f6c96 Merge tag 'iio-fixes-fo=
r-4.20a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into st=
aging-linus)
Merging char-misc.current/char-misc-linus (edeca3a769ad Merge tag 'sound-4.=
20-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound)
Merging soundwire-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging input-current/for-linus (10f91c73cc41 Input: hyper-v - fix wakeup f=
rom suspend-to-idle)
Merging crypto-current/master (9f4debe38415 crypto: user - Zeroize whole st=
ructure given to user space)
Merging ide/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (e8828ec1c003 mtd: spi-nor: fix selection of unifo=
rm erase type in flexible conf)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (10492ee8ed91 mfd: omap-usb-host: Fix dts p=
robe of children)
Merging v4l-dvb-fixes/fixes (ea2fc769719f media: Revert "media: dt-bindings=
: Document the Rockchip VPU bindings")
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (c50cbd85cd70 mips: fix mips_get_syscall_arg =
o32 check)
Merging at91-fixes/at91-fixes (4ab7ca092c3c ARM: dts: at91: sama5d2: use th=
e divided clock for SMC)
Merging omap-fixes/fixes (91e43395820b Merge branch 'fixes-dts' into omap-f=
or-v4.20/fixes)
Merging kvm-fixes/master (caf54f59e57e Merge tag 'kvm-ppc-fixes-4.20-1' of =
https://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into HEAD)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (09aaf6813cfc hwmon: (w83795) temp4_type has writ=
able permission)
Merging nvdimm-fixes/libnvdimm-fixes (2121db096301 Revert "acpi, nfit: Furt=
her restrict userspace ARS start requests")
Merging btrfs-fixes/next-fixes (e5a49b0e76d2 Merge branch 'misc-4.20' into =
next-fixes)
Merging vfs-fixes/fixes (2084ac6c505a exportfs: do not read dentry after fr=
ee)
Merging dma-mapping-fixes/for-linus (cb216b84d6ea swiotlb: Skip cache maint=
enance on map error)
Merging i3c-fixes/master (651022382c7f Linux 4.20-rc1)
Merging drivers-x86-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging samsung-krzk-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (89c38422e072 of, numa: Validate some dis=
tance map rules)
Merging scsi-fixes/fixes (8e4829c6f747 scsi: ufs: Fix hynix ufs bug with qu=
irk on hi36xx SoC)
Merging drm-fixes/drm-fixes (98c9cdfd34fb Merge tag 'drm-intel-fixes-2018-1=
1-22' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (f559156c399c drm/i915: Add ro=
tation readout for plane initial config)
Merging mmc-fixes/fixes (5305ec6a27b2 mmc: sdhci-pci: Workaround GLK firmwa=
re failing to restore the tuning value)
Merging rtc-fixes/rtc-fixes (9bde0afb7a90 rtc: pcf2127: fix a kmemleak caus=
ed in pcf2127_i2c_gather_write)
Merging gnss-fixes/gnss-linus (1decef370456 gnss: sirf: fix synchronous wri=
te timeout)
Merging drm-misc-fixes/for-linux-next-fixes (47ebfb6ed13e drm/meson: Fixes =
for drm_crtc_vblank_on/off support)
Merging kbuild/for-next (dd002b94a7bb Merge branches 'kbuild', 'kbuild2', '=
kconfig' and 'kconfig2' into for-next)
Merging compiler-attributes/compiler-attributes (24efee412c75 Compiler Attr=
ibutes: improve explanation of header)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging dma-mapping/for-next (886643b76632 arm64: use the generic swiotlb_d=
ma_ops)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (1f2b7bda0949 Merge branches 'fixes', 'misc' and 'spec=
tre' into for-next)
Merging arm-perf/for-next/perf (cbb72a3c19ef drivers/perf: xgene: Add CPU h=
otplug support)
Merging arm-soc/for-next (ec534ead9922 ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (0750a835f0b0 Merge branch 'v4.21/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (3368e06e2a91 ARM: dts: aspeed: Adding Facebook Tio=
gaPass BMC)
Merging at91/at91-next (39d48eea7c35 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (3c9d403d2fe1 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (3540844ed257 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (42ac5fee3a13 Merge branch 'v4.19-next/soc' into =
for-next)
Merging mvebu/for-next (0f8a14a7cb8c Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (442f7fdf48da Merge branch 'omap-for-v4.21/dt' into f=
or-next)
Merging reset/reset/next (8a1b9fd55f25 reset: uniphier-glue: Add AHCI reset=
 control support in glue layer)
Merging qcom/for-next (e20395ba18ee Merge branch 'qcs404-topic' into all-fo=
r-4.21)
Merging renesas/next (4b1a7599fb81 Merge branches 'arm-dt-for-v4.21' and 'a=
rm64-dt-for-v4.21' into next)
Merging rockchip/for-next (30e7d1a017f5 Merge branch 'v4.21-clk/next' into =
for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (529a9b0984a2 Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (3f6666824ed4 Merge branches 'sunxi/clk-for-4.=
21' and 'sunxi/dt64-for-4.21' into sunxi/for-next)
Merging tegra/for-next (257e4daadc1a Merge branch for-4.21/clk into for-nex=
t)
Merging arm64/for-next/core (c8ebf64eab74 arm64/module: use plt section ind=
ices for relocations)
Merging clk/clk-next (f1603e431a12 Merge branch 'clk-protected-binding' int=
o clk-next)
Merging clk-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (252050365823 dt-bindings: timer: gx6605s SOC timer)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (9ff01193a20d Linux 4.20-rc3)
Merging microblaze/next (1e17ab5320a6 microblaze: generate uapi header and =
system call table files)
Merging mips/mips-next (66a4059ba72c MIPS: Only include mmzone.h when CONFI=
G_NEED_MULTIPLE_NODES=3Dy)
CONFLICT (content): Merge conflict in arch/mips/Kconfig
Merging nds32/next (e2f3f8b4a497 nds32: support hardware prefetcher)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (84df9525b0c2 Linux 4.19)
Merging powerpc/next (ccda4af0f4b9 Linux 4.20-rc2)
Merging fsl/next (b6ae3550c8e2 powerpc/8xx: add missing header in 8xx_mmu.c)
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (e156606242ea automerging branch "kernel.org-palmer=
-linux/next-sg_chain" into "for-next")
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (005af85c50f7 Merge tag 'vfio-ccw-20181113' of git://=
git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into fixes)
Merging sparc-next/master (726799a4f919 Merge branch 'sparc-syscall-gen')
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (917e2fd2c53e um: Make line/tty semantics use true w=
rite IRQ)
Merging xtensa/xtensa-for-next (fcec7756107d Merge branch 'xtensa-syscall-r=
ework' into xtensa-for-next)
CONFLICT (content): Merge conflict in arch/xtensa/Makefile
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (a30d1244d38f Merge branch 'for-next-next-v4.2=
0-20181122' into for-next-20181122)
Merging ceph/master (7e241f647dc7 libceph: fall back to sendmsg for slab pa=
ges)
Merging cifs/for-next (af84fcece38a Add vers=3D3.0.2 as a valid option for =
SMBv3.0.2)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (3f8b018bf310 Pull ext2 cleanups.)
Merging ext4/dev (53692ec074d0 ext4: fix buffer leak in ext4_expand_extra_i=
size_ea() on error path)
Merging f2fs/dev (c6316db7b1bf f2fs: fix race between write_checkpoint and =
write_begin)
Merging fuse/for-next (4fc4bb796b0c fuse: Add bad inode check in fuse_destr=
oy_inode())
Merging jfs/jfs-next (a83722f45c5b jfs: fix spelling mistake, EACCESS -> EA=
CCES)
Merging nfs/linux-next (d6d460b89378 Merge tag 'dma-mapping-4.20-3' of git:=
//git.infradead.org/users/hch/dma-mapping)
Merging nfs-anna/linux-next (9f0c5124f4a8 NFS: Don't open code clearing of =
delegation state)
Merging nfsd/nfsd-next (f98c23b62461 nfsd4: skip unused assignment)
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (155b8a0492a9 ovl: fix decode of dir file =
handle with multi lower layers)
Merging ubifs/linux-next (001260910c46 ubifs: auth: add CONFIG_KEYS depende=
ncy)
Merging v9fs/9p-next (7373bc7654c1 9p/net: put a lower bound on msize)
Merging xfs/for-next (8c110d43c6bc iomap: readpages doesn't zero page tail =
beyond EOF)
Merging file-locks/locks-next (ab621b9a6388 VFS: locks: remove unnecessary =
white space.)
Merging vfs/for-next (d708e87ca399 Merge branch 'work.mount' into for-next)
CONFLICT (content): Merge conflict in fs/proc/inode.c
CONFLICT (content): Merge conflict in fs/f2fs/super.c
CONFLICT (content): Merge conflict in fs/compat_ioctl.c
CONFLICT (content): Merge conflict in drivers/vfio/Kconfig
CONFLICT (content): Merge conflict in drivers/infiniband/Kconfig
CONFLICT (content): Merge conflict in arch/sparc/kernel/setup_64.c
Merging printk/for-next (c7c3f05e341a panic: avoid deadlocks in re-entrant =
console drivers)
Merging pci/next (651022382c7f Linux 4.20-rc1)
Merging pstore/for-next/pstore (1227daa43bce pstore/ram: Clarify resource r=
eservation labels)
Merging hid/for-next (16e70c1713e8 Merge branch 'for-4.21/hid-cougar' into =
for-next)
Merging i2c/i2c/for-next (ccda4af0f4b9 Linux 4.20-rc2)
Merging i3c/i3c/next (87e6c8c5c2dd i3c: master: dw: fix mask operation by u=
sing the correct operator)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (9f7d3bd88cd1 hwmon: (ina3221) Convert to =
using %pOFn instead of device_node.name)
Merging jc_docs/docs-next (3d9bfb19bd70 scripts/kernel-doc: Fix struct and =
struct field attribute processing)
Merging v4l-dvb/master (708d75fe1c7c media: dvb-pll: don't re-validate tune=
r frequencies)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (217188d9f985 video: fbdev: remove redundant '=
default n' from Kconfig-s)
Merging pm/linux-next (b3f1df1c3f53 Merge branch 'pm-tools' into linux-next)
Merging cpupower/cpupower (dbc4ca339c8d tools cpupower: Override CFLAGS ass=
ignments)
Merging opp/opp/linux-next (e822eac560a8 Merge branch 'opp/genpd/required-o=
pps' into opp/linux-next)
Merging thermal/next (c2b59d279dbb thermal: core: using power_efficient_wq =
for thermal worker)
Merging thermal-soc/next (760eea43f8c6 thermal: da9062/61: Prevent hardware=
 access during system suspend)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (8fc6ed9a3508 dlm: fix missing idr_destroy for recover_idr)
Merging swiotlb/linux-next (da689221f952 xen/blkfront: avoid NULL blkfront_=
info dereference on device removal)
Merging rdma/for-next (01b671170d7f RDMA/core: Sync unregistration with net=
link commands)
Merging net-next/master (358be656406d selftests/net: add txring_overwrite)
Merging bpf-next/master (ffac28f95a98 bpf: align map type names formatting.)
CONFLICT (content): Merge conflict in tools/testing/selftests/bpf/Makefile
CONFLICT (content): Merge conflict in net/core/filter.c
Merging ipsec-next/master (3fcccec008cf xfrm6: remove BUG_ON from xfrm6_dst=
_ifdown)
Merging mlx5-next/mlx5-next (6d2d6fc83a28 net/mlx5: EQ, Make EQE access met=
hods inline)
Merging netfilter-next/master (b96609876922 netfilter: nf_flow_table: simpl=
ify nf_flow_offload_gc_step())
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (12d56175c89c Merge tag 'iwlwifi-next-=
for-kalle-2018-11-11' of git://git.kernel.org/pub/scm/linux/kernel/git/iwlw=
ifi/iwlwifi-next)
Merging bluetooth/master (358be656406d selftests/net: add txring_overwrite)
Merging mac80211-next/master (ecbc12ad6b68 {nl,mac}80211: add rssi to mesh =
candidates)
Merging gfs2/for-next (009cf0d9392d gfs2: Remove vestigial bd_ops)
Merging mtd/mtd/next (c0e118c8a1a3 mtd: partitions: Add OF support to RedBo=
ot partitions)
Merging nand/nand/next (c41b8b4e44eb mtd: rawnand: Move ->setup_data_interf=
ace() to nand_controller_ops)
Merging spi-nor/spi-nor/next (fc8d8fdaf4f2 mtd: spi-nor: add entry for mt35=
xu512aba flash)
Merging crypto/master (059c2a4d8e16 crypto: adiantum - add Adiantum support)
Merging drm/drm-next (b239499f927f Merge tag 'drm-misc-next-2018-11-21' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/meson/meson_crtc.c
Merging drm-intel/for-linux-next (0e39037b3165 drm/i915: Cache the error st=
ring)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gpu_error.c
Merging drm-tegra/drm/tegra/for-next (5ac93f81096a drm/tegra: Detach device=
s from IOMMU DMA domain on arm32)
Merging drm-misc/for-linux-next (a42facc82c3d docs: drm: remove no longer r=
elevant TODO entry)
CONFLICT (content): Merge conflict in drivers/gpu/drm/Makefile
Merging drm-msm/msm-next (fa81b1ad6976 drm/msm: dpu: Don't set legacy plane=
->crtc pointer)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/hdmi/hdmi.c
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (fd99bd8b805c drm: malidp: Add the siz=
e of the superblocks when calculating total size for AFBC buffers)
Merging imx-drm/imx-drm/next (6cec571b70ec drm/imx: ipuv3-plane: add functi=
on to query atomic update status)
Merging etnaviv/etnaviv/next (99e294492ef9 drm/etnaviv: Replace drm_dev_unr=
ef with drm_dev_put)
CONFLICT (content): Merge conflict in drivers/gpu/drm/etnaviv/etnaviv_drv.c
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (52d613b36fb7 Merge remote-tracking branch 'regmap/=
topic/irq' into regmap-next)
Merging sound/for-next (3a6d1980fe96 ALSA: Replace snd_malloc_pages() and s=
nd_free_pages() with standard helpers)
Merging sound-asoc/for-next (4a53fa824848 Merge branch 'asoc-4.21' into aso=
c-next)
Merging modules/modules-next (e84cd7ee630e modsign: use all trusted keys to=
 verify module signature)
Merging input/next (ed22cee91a88 Input: olpc_apsp - enable the SP clock)
Merging block/for-next (1db4909e76f6 blk-mq: not embed .mq_kobj and ctx->ko=
bj into queue instance)
Merging device-mapper/for-next (c49f3571b597 dm mpath: only flush workqueue=
 when needed)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (ae7b8b9b91ee mmc: sdhci: imx: Use the slot GPIO descripto=
r)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
Merging md/for-next (cac09f066f0f md: remvoe redundant condition check)
Merging mfd/for-mfd-next (a521dcb18b6d mfd: tps6586x: Handle interrupts on =
suspend)
Merging backlight/for-backlight-next (e1c9f2eaa0fb backlight: Remove ld9040=
 driver)
Merging battery/for-next (195ca1703784 power: supply: Add Spreadtrum SC27XX=
 fuel gauge unit driver)
Merging regulator/for-next (13f0d7155259 Merge remote-tracking branch 'regu=
lator/topic/coupled' into regulator-next)
Merging security/next-testing (26b76320a8a5 Merge tag 'v4.20-rc2' into next=
-general)
Merging apparmor/apparmor-next (43aa09fee2f0 apparmor: Fix warning about un=
used function apparmor_ipv6_postroute)
Merging integrity/next-integrity (2b48646cd60f docs: Extend trusted keys do=
cumentation for TPM 2.0)
Merging selinux/next (5386e6caa671 selinux: refactor sidtab conversion)
Merging tpmdd/next (09c573ab853d tpm: tpm_ibmvtpm: fix kdoc warnings)
Merging watchdog/master (7db706a2184d watchdog: npcm: Modify npcm watchdog =
kconfig arch parameter)
Merging iommu/next (f262283c2245 Merge branches 'iommu/fixes', 'arm/renesas=
', 'arm/mediatek', 'arm/tegra', 'arm/omap', 'x86/vt-d', 'x86/amd' and 'core=
' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (104c7405a64d vfio: add edid support to mbochs sample dri=
ver)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (c8fc5d49c341 audit: remove WATCH and TREE config option=
s)
Merging devicetree/for-next (570d54fe2463 dt-bindings: rng: update bindings=
 for MT7629 SoC)
Merging mailbox/mailbox-for-next (9f0a0a381c5d mailbox: mediatek: Add check=
 for possible failure of kzalloc)
Merging spi/for-next (f7c2b8080b03 Merge remote-tracking branches 'spi/topi=
c/3wire-gpio', 'spi/topic/mem' and 'spi/topic/mtd' into spi-next)
Merging tip/auto-latest (fd20b0c7a2bf Merge branch 'x86/urgent')
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/resctrl/rdtgroup.c
Merging clockevents/clockevents/next (0aded575609e clocksource/drivers/inte=
grator-ap: Add missing of_node_put())
Merging edac-amd/for-next (8a880560d58a MAINTAINERS, EDAC: Drop bouncing em=
ail)
Merging irqchip/irq/irqchip-next (2130b789b3ef irqchip/gic: Unify GIC prior=
ity definitions)
Merging ftrace/for-next (fdda10ef50bf function_graph: Have profiler use cur=
r_ret_stack and not depth)
Merging rcu/rcu/next (e1426fd9855c Merge LKMM and RCU commits)
Merging kvm/linux-next (22a7cdcae6a4 KVM/nVMX: Do not validate that posted_=
intr_desc_addr is page aligned)
Merging kvm-arm/next (e4e11cc0f81e KVM: arm64: Safety check PSTATE when ent=
ering guest and handle IL)
Merging kvm-ppc/kvm-ppc-next (651022382c7f Linux 4.20-rc1)
Merging kvms390/next (ed3054a30258 Merge branch 'apv11' of git://git.kernel=
.org/pub/scm/linux/kernel/git/kvms390/linux into kernelorgnext)
Merging xen-tip/linux-next (f2a5fef1248b x86/xen: cleanup includes in arch/=
x86/xen/spinlock.c)
Merging percpu/for-next (ad19ef010db1 Merge branch 'for-4.19-fixes' into fo=
r-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (8122e7cd806d platform/x86: intel_pmc_core: De=
code Snoop / Non Snoop LTR)
Merging chrome-platform/for-next (6ad16b78a039 platform/chrome: don't repor=
t EC_MKBP_EVENT_SENSOR_FIFO as wakeup)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (e41ca3b1eab8 leds: powernv: add of_node_put())
Merging ipmi/for-next (ae5f2fa3bc76 ipmi:ssif: Fix handling of multi-part r=
eturn messages)
Merging driver-core/driver-core-next (6be244dcd59b kobject: Fix warnings in=
 lib/kobject_uevent.c)
Merging usb/usb-next (f4b614adbf3a drivers: usb: early: clean up indentatio=
n, remove extraneous tabs)
Merging usb-gadget/next (3b766f453557 USB: net2280: Remove ->disconnect() c=
allback from net2280_pullup())
Merging usb-serial/usb-next (6abd837104a3 USB: serial: ftdi_sio: use roundi=
ng when calculating baud rate divisors)
Merging usb-chipidea-next/ci-for-usb-next (59739131e0ca usb: chipidea: Fix =
otg event handler)
Merging phy-next/next (9b28b23a7a12 phy: cadence: Add driver for Sierra PHY)
Merging tty/tty-next (c17a1ca14cbb Merge 4.20-rc2 into tty-next)
Merging char-misc/char-misc-next (24438e46268c uio: uio_fsl_elbc_gpcm: simp=
lify getting .driver_data)
Merging extcon/extcon-next (a2dc50914744 extcon: max8997: Fix lack of path =
setting in USB device mode)
Merging soundwire/next (b1635596860d soundwire: intel: constify snd_soc_dai=
_ops structures)
Merging staging/staging-next (16c44c57ecd8 staging: vboxvideo: Rename uint3=
2_t type to u32)
CONFLICT (content): Merge conflict in drivers/staging/vboxvideo/vbox_ttm.c
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (23ba90b47dfc interconnect: fix build error without DE=
BUGFS)
Merging slave-dma/next (2f04b25e7326 Merge branch 'topic/dirn_remove' into =
next)
Merging cgroup/for-next (ec77c03dbd5f Merge branch 'for-4.20-fixes' into fo=
r-next)
Merging scsi/for-next (da3c564cb06b Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (359d0ac1e806 scsi: lpfc: Use dma_zalloc_coherent)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (79f800b2e769 MAINTAINERS: remove reference to bog=
us vsock file)
Merging rpmsg/for-next (9099a252d44c Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (347b71219f52 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (9af3853e777a Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (f82d15e22340 pwm: lpc18xx-sct: Don't reconfigure PWM =
in .request and .free)
Merging userns/for-next (1e9c75fb9c47 mnt: fix __detach_mounts infinite loo=
p)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (e55c884ea5c6 media: rc: self test for IR encoders a=
nd decoders)
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (903242b80a97 coresight: etm3x: Release CLAIM tag wh=
en operated from perf)
Merging rtc/rtc-next (73852e56827f rtc: dt-binding: abx80x: fix resistance =
scale)
Merging nvdimm/libnvdimm-for-next (594861215c83 acpi, nfit: Further restric=
t userspace ARS start requests)
Merging at24/at24/for-next (9ff01193a20d Linux 4.20-rc3)
Merging ntb/ntb-next (651022382c7f Linux 4.20-rc1)
Merging kspp/for-next/kspp (ec9b3877c2fd Merge branch 'for-next/array_size'=
 into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (84a401a27506 Merge branch 'for-x86' into for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging gnss/gnss-next (ccda4af0f4b9 Linux 4.20-rc2)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (e178307d3459 slimbus: ngd: QCOM_QMI_HELPERS has t=
o be selected)
Merging nvmem/for-next (5035d66cc629 nvmem: meson-efuse: add peripheral clo=
ck)
Merging xarray/xarray (fffc9a260e38 XArray tests: Add missing locking)
Applying: sparc: suppress the implicit-fallthrough warning
Applying: sparc32: suppress an implicit-fallthrough warning
Applying: sparc32: supress another implicit-fallthrough warning
Merging akpm-current/current (379c80d931fe ipc: conserve sequence numbers i=
n extended IPCMNI mode)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: scripts/atomic/check-atomics.sh: don't assume that scripts are ex=
ecutable
Applying: mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
Applying: mm/sparse: add common helper to mark all memblocks present
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (ccc034d736d4 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/LhbiKSSkTrzI6rTVtl_tL0o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlv7tu8ACgkQAVBC80lX
0GznCQgAkgXJU6UxkoH+2agPclV31iJxKceYrO4Lzd7gFNLQf9Gkm/m+9flCfpJP
GrIoNJGkZUdy7m4kZ8q65/j97xHH6FMr1DxPl3N1BjwlQ7BhsBs6je7wwPAY6doC
c5YWfepDGVG923U6qXMiKyrA+AVE8tZ8VGZ4fBMT+AzBeRyuEH3bhgjbBqbi4EAp
j52WpUCFH/1qbEsud87BdWBET8SKMN8gTxzaNMX1J+amuK8wGYaNFuTNQEEZXMqk
4vHj3MPGtUBM+ZQ59ob8E4Kf8FihI0Gcznf8XWwoWZn+eEgNdOQievA/54cfzwyB
okxV2z/AOD1w4TRzf2SE0XH5Fmodqg==
=Ds2v
-----END PGP SIGNATURE-----

--Sig_/LhbiKSSkTrzI6rTVtl_tL0o--
