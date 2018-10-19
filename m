Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB485ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDA420869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b/zmoniD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDA420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJSPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:21:47 -0400
Received: from ozlabs.org ([203.11.71.1]:35521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726758AbeJSPVr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:21:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42by063dphz9sCW;
        Fri, 19 Oct 2018 18:16:54 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1539933414;
        bh=X/RdMMC0S9ADjMPWClJYDzmPSchW45vSWHf9BlJNAio=;
        h=Date:From:To:Cc:Subject:From;
        b=b/zmoniDMgaASj79wB7tgWQVrZDspXmWT43LE3YPOzjyKmo/6B0v4soLNK9ZIbetj
         BFByX9D0Fu8R6LnarhJ+weAzN4NDalOZq9HMxbKTToB5kWAm2DLqFIQJOpjSb+CvDH
         iVjl3+CDfgwtblGIpwMW1JA6P2/uFN8K0w3ERhzgV2X0ZQN+DeeH0vsuosEgNJiWgz
         H/loazAPgftFL219w24cNyLH2R3ik62D6EaiKYoeoFsuUI4Wv29CsH4WzIF4u4w2iO
         XAZPfMZyGcTefoki3lXLzyMei7sMXqp0Rk8YxA7/fKwcdSnNOYMuUbV8aUfxg7ewv4
         HfKtbhEhUnTlw==
Date:   Fri, 19 Oct 2018 18:16:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 19
Message-ID: <20181019181653.198552cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/upRvFSA+G/IFaFZzBZ/q7aM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/upRvFSA+G/IFaFZzBZ/q7aM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: I will not be doing linux-next releases next week.  Unfortunately
this will probably be the first week of the merge window. :-(

Changes since 20181018:

The net-next tree gained a conflict against the net tree and a build
failure due to an interaction with the rdma tree for which I applied a
merge fix patch.

The kvm tree gained a conflict against the tip tree.

Non-merge commits (relative to Linus' tree): 11382
 10233 files changed, 562372 insertions(+), 243395 deletions(-)

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

I am currently merging 291 trees (counting Linus' and 66 trees of bug
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
Merging origin/master (fa520c47eaa1 fscache: Fix out of bound read in long =
cookie keys)
Merging fixes/master (eb81bfb224ce Merge branch 'for-linus' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/dtor/input)
Merging kbuild-current/fixes (5318321d367c samples: disable CONFIG_SAMPLES =
for UML)
Merging arc-current/for-curr (56d02dd9e794 ARC: IOC: panic if kernel was st=
arted with previously enabled IOC)
Merging arm-current/fixes (3a58ac65e2d7 ARM: 8799/1: mm: fix pci_ioremap_io=
() offset check)
Merging arm64-fixes/for-next/fixes (ca2b497253ad arm64: perf: Reject stand-=
alone CHAIN events for PMUv3)
Merging m68k-current/for-linus (0986b16ab49b m68k/mac: Use correct PMU resp=
onse format)
Merging powerpc-fixes/fixes (ac1788cc7da4 powerpc/numa: Skip onlining a off=
line node in kdump path)
Merging sparc/master (27faeebd0081 sparc: Revert unintended perf changes.)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (6b839b6cf9ea r8169: fix NAPI handling under high load)
Merging bpf/master (bd8be2cf8b69 Merge branch 'nfp-fix-pedit-set-action-off=
loads')
Merging ipsec/master (9dffff200fd1 xfrm: policy: use hlist rcu variants on =
insert)
Merging netfilter/master (cb20f2d2c050 netfilter: xt_nat: fix DNAT target f=
or shifted portmap ranges)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (3baafeffa48a iwlwifi: 1000: set the TFD qu=
eue size)
Merging mac80211/master (8d0be26c781a mac80211_hwsim: fix module init error=
 paths for netlink)
Merging rdma-fixes/for-rc (a3671a4f973e RDMA/ucma: Fix Spectre v1 vulnerabi=
lity)
Merging sound-current/for-linus (709ae62e8e6d ALSA: hda/realtek - Cannot ad=
just speaker's volume on Dell XPS 27 7760)
Merging sound-asoc-fixes/for-linus (98027961025e Merge branch 'asoc-4.19' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (7876320f8880 Linux 4.19-rc4)
Merging regulator-fixes/for-linus (35a7f35ad1b1 Linux 4.19-rc8)
Merging spi-fixes/for-linus (bc7a6ca6f446 Merge branch 'spi-4.19' into spi-=
linus)
Merging pci-current/for-linus (2edab4df98d9 PCI: Expand the "PF" acronym in=
 Kconfig help text)
Merging driver-core.current/driver-core-linus (7876320f8880 Linux 4.19-rc4)
Merging tty.current/tty-linus (202dc3cc10b4 serial: sh-sci: Fix receive on =
SCIFA/SCIFB variants with DMA)
Merging usb.current/usb-linus (9ae24af36691 usb: gadget: storage: Fix Spect=
re v1 vulnerability)
Merging usb-gadget-fixes/fixes (d9707490077b usb: dwc2: Fix call location o=
f dwc2_check_core_endianness)
Merging usb-serial-fixes/usb-linus (0238df646e62 Linux 4.19-rc7)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging staging.current/staging-linus (7876320f8880 Linux 4.19-rc4)
Merging char-misc.current/char-misc-linus (0238df646e62 Linux 4.19-rc7)
Merging soundwire-fixes/fixes (8d6ccf5cebbc soundwire: Fix acquiring bus lo=
ck twice during master release)
Merging input-current/for-linus (13c1c5e4d7f8 Input: elan_i2c - add ACPI ID=
 for Lenovo IdeaPad 330-15IGM)
Merging crypto-current/master (ba439a6cbfa2 crypto: qat - Fix KASAN stack-o=
ut-of-bounds bug in adf_probe())
Merging ide/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (ce01a1575f45 rseq/selftests: fix parametrize=
d test with -fpie)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (111b009f7e8b dmaengine: mic_x100_dma: use de=
vm_kzalloc to fix an issue)
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (f0fe77f601c3 lib/bch: fix possible stack overrun)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (10492ee8ed91 mfd: omap-usb-host: Fix dts p=
robe of children)
Merging v4l-dvb-fixes/fixes (ad608fbcf166 media: v4l: event: Prevent freein=
g event subscriptions while accessed)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (c61c7def1fa0 MIPS: VDSO: Reduce VDSO_RANDOMI=
ZE_SIZE to 64MB for 64bit)
Merging at91-fixes/at91-fixes (379e36d3f591 ARM: dts: at91: sama5d2_ptc_ek:=
 fix nand pinctrl)
Merging omap-fixes/fixes (c265c0ca76fb ARM: dts: logicpd-som-lv: Fix OMAP35=
/DM37 Compatibility issues)
Merging kvm-fixes/master (5f8bb004bca4 KVM: vmx: hyper-v: don't pass EPT co=
nfiguration info to vmx_hv_remote_flush_tlb())
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (234b69e3e089 ocfs2: fix ocfs2 read block panic)
Merging nvdimm-fixes/libnvdimm-fixes (4628a64591e6 mm: Preserve _PAGE_DEVMA=
P across mprotect() calls)
Merging btrfs-fixes/next-fixes (675c168b2b92 Merge branch 'misc-4.19' into =
next-fixes)
Merging vfs-fixes/fixes (b07581d2d5ad cachefiles: fix the race between cach=
efiles_bury_object() and rmdir(2))
Merging dma-mapping-fixes/for-linus (46bbeb69ff2f dma-mapping: add the miss=
ing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration)
Merging drivers-x86-fixes/fixes (6bf4ca7fbc85 Linux 4.19-rc5)
Merging samsung-krzk-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging devicetree-fixes/dt/linus (8894891446c9 of: unittest: Disable inter=
rupt node tests for old world MAC systems)
Merging scsi-fixes/fixes (3cc5746e5ad7 scsi: qedi: Initialize the stats mut=
ex lock)
Merging drm-fixes/drm-fixes (5ba15878f23c Merge branch 'linux-4.19' of git:=
//github.com/skeggsb/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (35a7f35ad1b1 Linux 4.19-rc8)
Merging mmc-fixes/fixes (4f666675cdff libertas: call into generic suspend c=
ode before turning off power)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (4364bcb2cd21 drm: Get ref on C=
RTC commit object when waiting for flip_done)
Merging kbuild/for-next (4afdb7867b61 Merge branch 'kbuild' into for-next)
Merging compiler-attributes/compiler-attributes (f0604f63033d Compiler Attr=
ibutes: ext4: remove local __nonstring definition)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (b9fd04262a8a dma-direct: respect DMA_ATTR_NO_=
WARN)
CONFLICT (content): Merge conflict in kernel/dma/Kconfig
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (3e98d240981a Merge branches 'fixes', 'misc' and 'spec=
tre' into for-next)
Merging arm-perf/for-next/perf (5b394b2ddf03 Linux 4.19-rc1)
Merging arm-soc/for-next (239f4143bab2 arm-soc: documetn merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (6456dc61314e Merge branch 'v4.20/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (3368e06e2a91 ARM: dts: aspeed: Adding Facebook Tio=
gaPass BMC)
Merging at91/at91-next (128f53d05feb Merge branches 'at91-drivers', 'at91-s=
oc', 'at91-dt' and 'at91-defconfig' into at91-next)
Merging bcm2835/for-next (ca5b45b7c5cd Merge branch 'bcm2835-defconfig-next=
' into for-next)
Merging imx-mxs/for-next (f3e6f97d9e27 Merge branch 'imx/drivers' into for-=
next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (42ac5fee3a13 Merge branch 'v4.19-next/soc' into =
for-next)
Merging mvebu/for-next (0f8a14a7cb8c Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (21f0bd425b67 Merge branch 'omap-for-v4.20/omap1' int=
o for-next)
Merging reset/reset/next (6805ae4a9bc4 ARC: HSDK: improve reset driver)
Merging qcom/for-next (6252f3298861 Merge tag 'qcom-arm64-defconfig-for-4.2=
0' into 4.20-tagged)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (dbe57871fba4 Merge branch 'fixes-for-v4.20' into next)
Merging rockchip/for-next (f6976ae4a29d Merge branch 'v4.20-clk/next' into =
for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (d7a88a82dc0a Merge branch 'next/soc64' into =
for-next)
Merging sunxi/sunxi/for-next (25c5fc5a4923 Merge branch 'sunxi/h3-h5-for-4.=
20' into sunxi/for-next)
CONFLICT (content): Merge conflict in arch/arm64/boot/dts/allwinner/sun50i-=
h5.dtsi
CONFLICT (content): Merge conflict in arch/arm/boot/dts/sun8i-h3.dtsi
Merging tegra/for-next (22fed951fe3b Merge branch for-4.20/arm64/dt into fo=
r-next)
CONFLICT (content): Merge conflict in drivers/firmware/tegra/bpmp.c
Merging arm64/for-next/core (4afe8e79da92 arm64: cpufeature: Trap CTR_EL0 a=
ccess only where it is necessary)
Merging clk/clk-next (71cc8bb98f8d Merge branch 'clk-fixed-rate-remove' int=
o clk-next)
Merging clk-samsung/for-next (9dbcfe1ace4e dt-bindings: clock: samsung: Add=
 SPDX license identifiers)
Merging c6x/for-linux-next (929ba9300082 c6x: switch to NO_BOOTMEM)
Merging csky/linux-next (4bc11ff0cff5 csky: support dword access for get_us=
er_size())
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging ia64/next (02b4da5f84d1 intel-iommu: mark intel_dma_ops static)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (381fdd62c383 m68k: fix command-line parsing whe=
n passed from u-boot)
Merging microblaze/next (c4347b05440f microblaze/PCI: Remove stale pcibios_=
align_resource() comment)
Merging mips/mips-next (edbb4233e7ef MIPS: Cleanup DSP ASE detection)
CONFLICT (content): Merge conflict in arch/mips/lib/memset.S
Merging nds32/next (3350139c0ff3 nds32: linker script: GCOV kernel may refe=
rs data in __exit)
Merging nios2/for-next (c7c09dc187f0 nios2: kconfig: remove duplicate DEBUG=
_STACK_USAGE symbol defintions)
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (3847dab77421 parisc: Add alternative coding inf=
rastructure)
Merging powerpc/next (4ffe713b7587 powerpc/mm: Increase the max addressable=
 memory to 2PB)
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (bd96461249bd powerpc/dts/fsl: t2080rdb: use the Cortina P=
HY driver compatible)
Merging risc-v/for-next (bb2fb311552c automerging branch "kernel.org-palmer=
-linux/next-smp" into "for-next")
Merging s390/features (b5130dc2224d s390/sthyi: Fix machine name validity i=
ndication)
CONFLICT (content): Merge conflict in include/linux/compiler-gcc.h
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (d9cbd0e8f667 um: NULL check before kfree is not nee=
ded)
Merging xtensa/xtensa-for-next (0fc042bfb322 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (fdf45738bafa Merge branch 'for-next-next-v4.2=
0-20181017' into for-next-20181017)
Merging ceph/master (7137319dbf3d libceph: don't consume a ref on pagelist =
in ceph_msg_data_add_pagelist())
Merging cifs/for-next (2642bb7c1622 cifs: update internal module version nu=
mber for cifs.ko to 2.14)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (3df77b04f624 Pull fanotify support for reporting PID=
 instead of TGID and other fsnotify cleanups.)
Merging ext4/dev (33458eaba4df ext4: fix use-after-free race in ext4_remoun=
t()'s error path)
Merging f2fs/dev (4f061750ae5e f2fs: cleanup dirty pages if recover failed)
Merging fuse/for-next (5571f1e65486 fuse: enable caching of symlinks)
Merging jfs/jfs-next (1390643d1d5c jfs: remove redundant dquot_initialize()=
 in jfs_evict_inode())
Merging nfs/linux-next (93bdcf9fdb89 Merge tag 'nfs-rdma-for-4.20-1' of git=
://git.linux-nfs.org/projects/anna/linux-nfs)
Merging nfs-anna/linux-next (9f0c5124f4a8 NFS: Don't open code clearing of =
delegation state)
Merging nfsd/nfsd-next (154303cfcb6c svcrdma: Increase the default connecti=
on credit limit)
Applying: svcrdma: fix up for recv_lock rename
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (1a8f8d2a443e ovl: fix format of setxattr =
debug)
Merging ubifs/linux-next (f061c1cc404a Revert "ubifs: xattr: Don't operate =
on deleted inodes")
Merging v9fs/9p-next (fb488fc1f2b4 9p/trans_fd: put worker reqs on destroy)
Merging xfs/for-next (96987eea537d xfs: cancel COW blocks before swapext)
Merging file-locks/locks-next (10f3e23f07cb Merge tag 'ext4_for_linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4)
Merging vfs/for-next (458b53cdbddf Merge branch 'work.misc' into for-next)
CONFLICT (content): Merge conflict in fs/f2fs/super.c
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a61eee132f1e Merge branch 'for-4.20-vsprintf-hash-=
fixes' into for-next)
Merging pci/next (f622e9f6428b Merge branch 'remotes/lorenzo/pci/tools')
Merging pstore/for-next/pstore (674e63d2dfad pstore/ram: Clarify resource r=
eservation labels)
Merging hid/for-next (0aef342184e3 Merge branch 'for-4.19/fixes' into for-n=
ext)
Merging i2c/i2c/for-next (9b9c82ffa371 Merge branch 'i2c/for-4.20' into i2c=
/for-next)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (e7c6a55606b5 hwmon: (pmbus) Fix page coun=
t auto-detection.)
Merging jc_docs/docs-next (84253c8be37d docs: Introduce deprecated APIs lis=
t)
CONFLICT (content): Merge conflict in Documentation/driver-api/index.rst
Merging v4l-dvb/master (490d84f6d73c media: cec: forgot to cancel delayed w=
ork)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (64f83a816b27 Revert "video: ssd1307fb: Do not=
 hard code active-low reset sequence")
Merging pm/linux-next (dfb2bb2f07cf Merge branch 'pm-cpuidle' into linux-ne=
xt)
Merging cpupower/cpupower (f40834d7765d tools/power/cpupower: fix compilati=
on with STATIC=3Dtrue)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (deac8703da5f PM / OPP: _of_add_opp_table_v2(): =
increment count only if OPP is added)
Merging thermal/next (c2b59d279dbb thermal: core: using power_efficient_wq =
for thermal worker)
Merging thermal-soc/next (152395fd03d4 thermal: of-thermal: disable passive=
 polling when thermal zone is disabled)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (551d315e34a5 RDMA/umad: Use kernel API to allocate u=
mad indexes)
CONFLICT (content): Merge conflict in drivers/infiniband/Kconfig
Merging net-next/master (40b06553c906 cxgb4: fix the error path of cxgb4_ul=
d_register())
CONFLICT (content): Merge conflict in net/sched/cls_api.c
CONFLICT (content): Merge conflict in net/ipv4/ipmr_base.c
CONFLICT (modify/delete): Documentation/networking/00-INDEX deleted in HEAD=
 and modified in net-next/master. Version net-next/master of Documentation/=
networking/00-INDEX left in tree.
$ git rm -f Documentation/networking/00-INDEX
Applying: net/mlx5: fix up for has_flow_tag changing to a flag
Merging bpf-next/master (1a8555f6f46e Merge branch 'cg_skb_direct_pkt_acces=
s')
Merging ipsec-next/master (8d4b6bce2559 xfrm: use complete IPv6 addresses f=
or hash)
Merging mlx5-next/mlx5-next (94a04d1d3d36 net/mlx5: Expose DC scatter to CQ=
E capability bit)
Merging netfilter-next/master (95c97998aa9f netfilter: nf_nat_snmp_basic: a=
dd missing helper alias name)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (f95cd52476de Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (c614ca3f7476 Bluetooth: hci_qca: Add support for =
controller debug logs.)
Merging mac80211-next/master (f8252e7b5a83 mac80211: implement ieee80211_tx=
_rate_update to update rate)
Merging gfs2/for-next (c9e58fb2aad5 gfs2: write revokes should traverse sd_=
ail1_list in reverse)
Merging mtd/mtd/next (92e2921f7eee jffs2: free jffs2_sb_info through jffs2_=
kill_sb())
Merging nand/nand/next (53c83b59759c mtd: rawnand: marvell: fix the IRQ han=
dler complete() condition)
Merging spi-nor/spi-nor/next (41fe242979e4 mtd: spi-nor: fsl-quadspi: fix r=
ead error for flash size larger than 16MB)
Merging crypto/master (a1c6fd4308d3 crypto: chelsio - Update ntx queue rece=
ived from cxgb4)
CONFLICT (content): Merge conflict in net/wireless/lib80211_crypt_wep.c
CONFLICT (content): Merge conflict in net/wireless/lib80211_crypt_tkip.c
CONFLICT (content): Merge conflict in include/linux/compiler_types.h
Applying: crypto: fixup for movement of __aligned_largest
Merging drm/drm-next (c13bbf4a78aa Merge branch 'drm-next-4.20' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (835fe6d75d14 firmware/dmc/icl: Add missin=
g MODULE_FIRMWARE() for Icelake.)
Merging drm-tegra/drm/tegra/for-next (5ac93f81096a drm/tegra: Detach device=
s from IOMMU DMA domain on arm32)
Merging drm-misc/for-linux-next (0e8afefd5da4 drm: panel-orientation-quirks=
: Add quirk for Acer One 10 (S1003))
Merging drm-msm/msm-next (8bb1f9ec3367 drm/msm: fix handling of cmdstream o=
ffset)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (fd99bd8b805c drm: malidp: Add the siz=
e of the superblocks when calculating total size for AFBC buffers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (888a060d668f drm/imx: Switch to SPDX identifi=
er)
Merging etnaviv/etnaviv/next (1a866306e0fb drm/etnaviv: add DMA configurati=
on for etnaviv platform device)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (fadf3e019411 Merge remote-tracking branch 'regmap/=
topic/single-rw' into regmap-next)
Merging sound/for-next (5cb6b5fc013e ALSA: hda: Add 2 more models to the po=
wer_save blacklist)
Merging sound-asoc/for-next (01ef4860ddc9 Merge branch 'asoc-4.20' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (902370519224 Input: xen-kbdfront - mark expected switch=
 fall-through)
Merging block/for-next (70ee54b191df Merge branch 'for-4.20/block' into for=
-next)
CONFLICT (content): Merge conflict in include/linux/blkdev.h
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (3d4e73831132 dm zoned: fix various dmz_get_=
mblock() issues)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (fd82cc3020a0 mmc: mediatek: drop too much code of tuning =
method)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
Merging md/for-next (ea89238c0a7b md-cluster: remove suspend_info)
Merging mfd/for-mfd-next (de6f25ddc428 mfd: cros_ec: Avoid unneeded interna=
l declaration warning)
Merging backlight/for-backlight-next (e1c9f2eaa0fb backlight: Remove ld9040=
 driver)
Merging battery/for-next (a4ac1f5ced58 power: reset: qcom-pon: Add pms405 p=
on support)
Merging regulator/for-next (f42523ad6984 Merge remote-tracking branches 're=
gulator/topic/bd718xx' and 'regulator/topic/pfuze100' into regulator-next)
Merging security/next-testing (f7ecb3f11995 Merge branch 'next-integrity' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into =
next-testing)
Merging apparmor/apparmor-next (e1af47796179 apparmor: add #ifdef checks fo=
r secmark filtering)
Merging integrity/next-integrity (34bccd61b139 MAINTAINERS: add Jarkko as m=
aintainer for trusted keys)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (4458bba09788 selinux: Add __GFP_NOWARN to allocation =
at str_read())
Merging tpmdd/next (e487a0f52301 tpm: Restore functionality to xen vtpm dri=
ver.)
Merging watchdog/master (c8ca6e70fb74 watchdog: armada_37xx_wdt: use do_div=
 for u64 division)
Merging iommu/next (2f2fbfb71ecc Merge branches 'arm/renesas', 'arm/smmu', =
'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (104c7405a64d vfio: add edid support to mbochs sample dri=
ver)
CONFLICT (content): Merge conflict in drivers/vfio/Kconfig
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (57361846b52b Linux 4.19-rc2)
Merging devicetree/for-next (885882a493c5 dt-bindings: Add OLPC vendor pref=
ix)
CONFLICT (content): Merge conflict in drivers/soc/qcom/apr.c
CONFLICT (content): Merge conflict in arch/c6x/kernel/setup.c
Merging mailbox/mailbox-for-next (9f0a0a381c5d mailbox: mediatek: Add check=
 for possible failure of kzalloc)
Merging spi/for-next (b5684db5c660 Merge remote-tracking branch 'spi/topic/=
of' into spi-next)
Merging tip/auto-latest (ff16f53e4ee7 Merge branch 'x86/vdso')
CONFLICT (content): Merge conflict in drivers/powercap/intel_rapl.c
CONFLICT (content): Merge conflict in drivers/idle/intel_idle.c
CONFLICT (content): Merge conflict in arch/s390/Kconfig
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in Documentation/scheduler/completion.txt
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (4cf841e39850 ACPI/ADXL: Add address translation =
interface using an ACPI DSM)
Merging irqchip/irq/irqchip-next (2130b789b3ef irqchip/gic: Unify GIC prior=
ity definitions)
Merging ftrace/for-next (a6ca88b241d5 trace_uprobe: support reference count=
er in fd-based uprobe)
Merging rcu/rcu/next (0b1aba265b93 Merge LKMM and RCU branches)
Merging kvm/linux-next (1e58e5e59148 KVM: VMX: enable nested virtualization=
 by default)
CONFLICT (content): Merge conflict in tools/include/uapi/linux/kvm.h
CONFLICT (content): Merge conflict in arch/x86/kvm/vmx.c
Merging kvm-arm/next (58bf437ff64e arm/arm64: KVM: Enable 32 bits kvm vcpu =
events support)
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/kvm_mmu.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/kvm_arm.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpufeature.h
CONFLICT (content): Merge conflict in arch/arm/include/asm/kvm_mmu.h
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (901f8c3f6feb KVM: PPC: Book3S HV: Add NO_HASH=
 flag to GET_SMMU_INFO ioctl result)
Merging kvms390/next (ed3054a30258 Merge branch 'apv11' of git://git.kernel=
.org/pub/scm/linux/kernel/git/kvms390/linux into kernelorgnext)
Merging xen-tip/linux-next (7d01a4e888d0 xen/balloon: Support xend-based to=
olstack)
Merging percpu/for-next (ad19ef010db1 Merge branch 'for-4.19-fixes' into fo=
r-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (cacad0b2e395 platform/x86: touchscreen_dmi: A=
dd info for the Trekstor Primebook C11 convertible)
CONFLICT (content): Merge conflict in drivers/platform/x86/intel_mid_powerb=
tn.c
CONFLICT (content): Merge conflict in drivers/platform/x86/intel_int0002_vg=
pio.c
Merging chrome-platform/for-next (bc3f4b5c60db platform/chrome: chromeos_tb=
mc - Remove unneeded const)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (8dbac65f5c18 leds: sc27xx: Add pattern_set/clear int=
erfaces for LED controller)
Merging ipmi/for-next (0711e8c1b457 ipmi: Fix timer race with module unload)
Merging driver-core/driver-core-next (a75e78f21f9a kernfs: Fix range checks=
 in kernfs_get_target_path)
Merging usb/usb-next (89303c7ea770 Merge tag 'usb-serial-4.20-rc1' of https=
://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next)
Merging usb-gadget/next (3b766f453557 USB: net2280: Remove ->disconnect() c=
allback from net2280_pullup())
Merging usb-serial/usb-next (17c42e34997a USB: serial: cypress_m8: remove s=
et but not used variable 'iflag')
Merging usb-chipidea-next/ci-for-usb-next (59739131e0ca usb: chipidea: Fix =
otg event handler)
Merging phy-next/next (566b388440bb phy: renesas: convert to SPDX identifie=
rs)
Merging tty/tty-next (2088cfd882d0 serial: uartps: Do not allow use aliases=
 >=3D MAX_UART_INSTANCES)
Merging char-misc/char-misc-next (93048c094415 lib: Fix ia64 bootloader lin=
kage)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (502c00d9c315 Documentation: soundwire: fix stream.r=
st markup warnings)
Merging staging/staging-next (dd71c89b2c1a staging: MAINTAINERS: remove obs=
olete IPX staging directory)
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-media-o=
f.c
CONFLICT (content): Merge conflict in drivers/staging/media/imx/imx-media-d=
ev.c
CONFLICT (modify/delete): drivers/staging/dgnc/dgnc_tty.c deleted in stagin=
g/staging-next and modified in HEAD. Version HEAD of drivers/staging/dgnc/d=
gnc_tty.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (modify/delete): Documentation/filesystems/00-INDEX deleted in HEA=
D and modified in staging/staging-next. Version staging/staging-next of Doc=
umentation/filesystems/00-INDEX left in tree.
$ git rm -f Documentation/filesystems/00-INDEX drivers/staging/dgnc/dgnc_tt=
y.c
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (23ba90b47dfc interconnect: fix build error without DE=
BUGFS)
Merging slave-dma/next (c67a36067d07 Merge branch 'for-linus' into next)
Merging cgroup/for-next (b4eb6bdca334 Merge branch 'for-4.19-fixes' into fo=
r-next)
Merging scsi/for-next (77c5bf5647b5 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (4d5b4ac1eae4 scsi: fnic: replace gross legacy ta=
g hack with blk-mq hack)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (1e05b62ae4bd sh: use the the PCI channels's io_ma=
p_base)
Merging rpmsg/for-next (888f4b430214 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (40f5ff4f9f23 gpio: Clarify kerneldoc on gpiochip_set=
_chained_irqchip())
Merging pinctrl/for-next (a93a676b0791 pinctrl: sunxi: Fix a memory leak in=
 'sunxi_pinctrl_build_state()')
Merging pinctrl-samsung/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging pwm/for-next (786e0cfa9d6f dt-bindings: pwm: rcar: Add r8a774a1 sup=
port)
Merging userns/for-next (a36700589b85 signal: Guard against negative signal=
 numbers in copy_siginfo_from_user32)
CONFLICT (content): Merge conflict in kernel/signal.c
CONFLICT (content): Merge conflict in arch/x86/mm/fault.c
CONFLICT (content): Merge conflict in arch/x86/kernel/traps.c
CONFLICT (content): Merge conflict in arch/arm64/kernel/traps.c
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9b25436662d5 random: make CPU trust a boot parameter)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (c4f15134cc7c selftests/ftrace: Strip escape sequenc=
es for log file)
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/dirty_log=
_test.c
CONFLICT (content): Merge conflict in tools/testing/selftests/kvm/Makefile
CONFLICT (content): Merge conflict in tools/testing/selftests/gpio/Makefile
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (29c222d1a9f5 Merge 4.19-rc6)
Merging rtc/rtc-next (c3e04915b867 rtc: m41t80: mark expected switch fall-t=
hrough)
Merging nvdimm/libnvdimm-for-next (594861215c83 acpi, nfit: Further restric=
t userspace ARS start requests)
Merging at24/at24/for-next (9a9e295e7c5c eeprom: at24: fix unexpected timeo=
ut under high load)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (ec9b3877c2fd Merge branch 'for-next/array_size'=
 into for-next/kspp)
CONFLICT (content): Merge conflict in drivers/misc/lkdtm/core.c
CONFLICT (content): Merge conflict in Documentation/x86/x86_64/mm.txt
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ff6401301656 Merge branch 'for-powerpc' into for-ne=
xt)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging fsi/master (15e2a7218c27 fsi: sbefifo: Bump max command length)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging xarray/xarray (bc8fe3faf31f radix tree: Remove multiorder support)
CONFLICT (content): Merge conflict in fs/f2fs/data.c
CONFLICT (content): Merge conflict in fs/dax.c
Merging akpm-current/current (d80d610cdc60 lib/lz4: update LZ4 decompressor=
 module)
CONFLICT (content): Merge conflict in mm/workingset.c
CONFLICT (content): Merge conflict in mm/swap_state.c
CONFLICT (content): Merge conflict in kernel/memremap.c
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/compiler_types.h
CONFLICT (content): Merge conflict in include/linux/compiler-gcc.h
CONFLICT (content): Merge conflict in fs/proc/inode.c
CONFLICT (content): Merge conflict in block/blk-iolatency.c
CONFLICT (content): Merge conflict in arch/hexagon/Kconfig
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
$ git checkout -b akpm remotes/origin/akpm/master
Applying: kbuild: fix kernel/bounds.c 'W=3D1' warning
Applying: percpu: remove PER_CPU_DEF_ATTRIBUTES macro
Applying: mm: remove CONFIG_NO_BOOTMEM
Applying: mm: remove now defunct NO_BOOTMEM from depends list for deferred =
init
Applying: mm: remove CONFIG_HAVE_MEMBLOCK
Applying: of/fdt: fixup #ifdefs after removal of HAVE_MEMBLOCK config option
Applying: csky: fixups after bootmem removal
Applying: memblock: remove stale #else and the code it protects
Applying: mm: remove bootmem allocator implementation.
Applying: mm: nobootmem: remove dead code
Applying: memblock: rename memblock_alloc{_nid,_try_nid} to memblock_phys_a=
lloc*
Applying: memblock: remove _virt from APIs returning virtual address
Applying: memblock: replace alloc_bootmem_align with memblock_alloc
Applying: memblock: replace alloc_bootmem_low with memblock_alloc_low
Applying: memblock: replace __alloc_bootmem_node_nopanic with memblock_allo=
c_try_nid_nopanic
Applying: memblock: replace alloc_bootmem_pages_nopanic with memblock_alloc=
_nopanic
Applying: memblock: replace alloc_bootmem_low with memblock_alloc_low (2)
Applying: memblock: replace __alloc_bootmem_nopanic with memblock_alloc_fro=
m_nopanic
Applying: memblock: add align parameter to memblock_alloc_node()
Applying: memblock: replace alloc_bootmem_pages_node with memblock_alloc_no=
de
Applying: memblock: replace __alloc_bootmem_node with appropriate memblock_=
 API
Applying: memblock: replace alloc_bootmem_node with memblock_alloc_node
Applying: memblock: replace alloc_bootmem_low_pages with memblock_alloc_low
Applying: memblock: replace alloc_bootmem_pages with memblock_alloc
Applying: memblock: replace __alloc_bootmem with memblock_alloc_from
Applying: memblock: replace alloc_bootmem with memblock_alloc
Applying: mm: nobootmem: remove bootmem allocation APIs
Applying: memblock: replace free_bootmem{_node} with memblock_free
Applying: memblock: replace free_bootmem_late with memblock_free_late
Applying: memblock: rename free_all_bootmem to memblock_free_all
Applying: memblock: rename __free_pages_bootmem to memblock_free_pages
Applying: mm: remove nobootmem
Applying: memblock: replace BOOTMEM_ALLOC_* with MEMBLOCK variants
Applying: mm: remove include/linux/bootmem.h
Applying: dma-direct: fix up for the removal of linux/bootmem.h
Applying: powerpc: fix up for removal of linux/bootmem.h
Applying: x86/kaslr, ACPI/NUMA: fix for linux/bootmem.h removal
Applying: docs/boot-time-mm: remove bootmem documentation
Applying: memblock: stop using implicit alignment to SMP_CACHE_BYTES
Applying: memblock-stop-using-implicit-alignement-to-smp_cache_bytes-checkp=
atch-fixes
Applying: memblock: fix missed uses of implicit alignment
Applying: mm/memblock.c: warn if zero alignment was requested
Applying: mm/memblock.c: use dump_stack() instead of WARN_ON_ONCE for the a=
lignment checks
Applying: memblock-warn-if-zero-alignment-was-requested-fix-fix
Applying: drivers/android/binder_alloc.c: replace vm_insert_page with vmf_i=
nsert_page
Applying: mm/memory_hotplug: make remove_memory() take the device_hotplug_l=
ock
Applying: mm/memory_hotplug: make add_memory() take the device_hotplug_lock
Applying: mm/memory_hotplug: fix online/offline_pages called w.o. mem_hotpl=
ug_lock
Applying: powerpc/powernv: hold device_hotplug_lock when calling device_onl=
ine()
Applying: powerpc/powernv: hold device_hotplug_lock when calling memtrace_o=
ffline_pages()
Applying: powerpc-powernv-hold-device_hotplug_lock-when-calling-memtrace_of=
fline_pages-v3
Applying: memory-hotplug.rst: add some details about locking internals
Applying: mm: Fix warning in insert_pfn()
Applying: mm/gup.c: fix __get_user_pages_fast() comment
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (6cf1824f7f7b drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/upRvFSA+G/IFaFZzBZ/q7aM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvJhOUACgkQAVBC80lX
0GzuxQgAjyd/0i0HikOwdBVL0kzco9nLw3W0KQD92wDH9HZJmze/8Qs+A+dixWv4
7oPlEbdCjs4EyeyGskZAeXuu6/dGcA/Gb7NnacHC8sM1p0XPZSPkcmeqeepAFtWz
mO75FBDArGi6WxAz+vuQ/JtzBHy5b/P4aKj0IOGwMmonLjoJftwghUmOEIWrTSbb
EAvPEx9N7icIQwU8i5kypEt+E5Z6R1FPk0PhGN/fYGRCLgphJrVevjOxm7dXPmhq
TFbiBf+INuOp88p+iod4GeXmIRXf9OMnIa9PEIPKYvsTKCB+9MvRoZ8qZffYPxWo
xY8u8/vJfp+0+ywhVzHx2n5gjp9tZg==
=SWbw
-----END PGP SIGNATURE-----

--Sig_/upRvFSA+G/IFaFZzBZ/q7aM--
