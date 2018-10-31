Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A295120657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mFRIZl86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A295120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeJaMzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 08:55:31 -0400
Received: from ozlabs.org ([203.11.71.1]:44053 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbeJaMza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 08:55:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42lF2N2qzyz9sBN;
        Wed, 31 Oct 2018 14:59:08 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1540958348;
        bh=GBgjimG5c5Wl+JS6SbFWin396qMb71Dmv99qXKBsTNk=;
        h=Date:From:To:Cc:Subject:From;
        b=mFRIZl86Wospm055lCaMa+1uk1E4q+WPiM6rZgyvcw2ndTj6V9Q7Mop6u9LpCVMMx
         i24kd9wS5eSre8RYG+oapdYozSbac+YJylUfLpLGLpIqkSRt1cq9ABUaht2RvY1iT+
         c6AcHaJzI3G7+2XsOKn4nDBhLK1l+T95FlVxbDAnEN+u7TaeBp5kRn9She5uTTbiWk
         byz6091NhNvvCjoCNGbNogR6GCC1saSQEIhCQO95VTE4ebNKqbMwXtDo30Tw3L6xaI
         h7dS9PiMdiCBH0AIgcXDFJaUb40vFxv+0WSDWudAGQukzb6+0Zg9Ts5pHD8c8bM4u8
         yvy+ZV9BgjtUg==
Date:   Wed, 31 Oct 2018 14:59:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Oct 31
Message-ID: <20181031145907.1ee2e866@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/N2LbOwjEVBUN3xLvP.BQt6I"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N2LbOwjEVBUN3xLvP.BQt6I
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any v4.21/v5.1 code to your linux-next included trees
until after the merge window closes.

Changes since 20181030:

My fixes tree contains this:

  "drivers: net: include linux/ip.h for iphdr"

The xfs tree gained a conflict against Linus' tree.

The vfs tree gained a conflict against the xfs tree.

Non-merge commits (relative to Linus' tree): 1071
 1632 files changed, 62897 insertions(+), 19314 deletions(-)

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
Merging origin/master (310c7585e830 Merge tag 'nfsd-4.20' of git://linux-nf=
s.org/~bfields/linux)
Merging fixes/master (2941927a2da1 drivers: net: include linux/ip.h for iph=
dr)
Merging kbuild-current/fixes (11743c56785c Merge tag 'rpmsg-v4.20' of git:/=
/github.com/andersson/remoteproc)
Merging arc-current/for-curr (a75e410a8bc2 ARCv2: boot log unaligned access=
 in use)
Merging arm-current/fixes (3a58ac65e2d7 ARM: 8799/1: mm: fix pci_ioremap_io=
() offset check)
Merging arm64-fixes/for-next/fixes (ca2b497253ad arm64: perf: Reject stand-=
alone CHAIN events for PMUv3)
Merging m68k-current/for-linus (58c116fb7dc6 m68k/sun3: Remove is_medusa an=
d m68k_pgtable_cachemode)
Merging powerpc-fixes/fixes (ac1788cc7da4 powerpc/numa: Skip onlining a off=
line node in kdump path)
Merging sparc/master (0f0a691f1ef9 sparc64: Remvoe set_fs() from perf_callc=
hain_user().)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (a6b3a3fa0423 net: mvpp2: Fix affinity hint allocation)
Merging bpf/master (d8fd9e106fbc bpf: fix wrong helper enablement in cgroup=
 local storage)
Merging ipsec/master (533555e5cbb6 xfrm: Fix error return code in xfrm_outp=
ut_one())
Merging netfilter/master (29a0dd66e953 netfilter: xt_IDLETIMER: add sysfs f=
ilename checking routine)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (3baafeffa48a iwlwifi: 1000: set the TFD qu=
eue size)
Merging mac80211/master (8d0be26c781a mac80211_hwsim: fix module init error=
 paths for netlink)
Merging rdma-fixes/for-rc (a3671a4f973e RDMA/ucma: Fix Spectre v1 vulnerabi=
lity)
Merging sound-current/for-linus (826b5de90c0b ALSA: firewire-lib: fix insuf=
ficient PCM rule for period/buffer size)
Merging sound-asoc-fixes/for-linus (f65f0722e85d Merge branch 'asoc-4.19' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (35a7f35ad1b1 Linux 4.19-rc8)
Merging regulator-fixes/for-linus (84df9525b0c2 Linux 4.19)
Merging spi-fixes/for-linus (599eb81f4118 Merge branch 'spi-4.19' into spi-=
linus)
Merging pci-current/for-linus (2edab4df98d9 PCI: Expand the "PF" acronym in=
 Kconfig help text)
Merging driver-core.current/driver-core-linus (9f51ae62c84a Merge git://git=
.kernel.org/pub/scm/linux/kernel/git/davem/net)
Merging tty.current/tty-linus (202dc3cc10b4 serial: sh-sci: Fix receive on =
SCIFA/SCIFB variants with DMA)
Merging usb.current/usb-linus (69d5b97c5973 HID: we do not randomly make ne=
w drivers 'default y')
Merging usb-gadget-fixes/fixes (d9707490077b usb: dwc2: Fix call location o=
f dwc2_check_core_endianness)
Merging usb-serial-fixes/usb-linus (0238df646e62 Linux 4.19-rc7)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging staging.current/staging-linus (11743c56785c Merge tag 'rpmsg-v4.20'=
 of git://github.com/andersson/remoteproc)
Merging char-misc.current/char-misc-linus (9f51ae62c84a Merge git://git.ker=
nel.org/pub/scm/linux/kernel/git/davem/net)
Merging soundwire-fixes/fixes (8d6ccf5cebbc soundwire: Fix acquiring bus lo=
ck twice during master release)
Merging input-current/for-linus (cacd9759eea2 Merge branch 'next' into for-=
linus)
Merging crypto-current/master (a1c6fd4308d3 crypto: chelsio - Update ntx qu=
eue received from cxgb4)
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
Merging v4l-dvb-fixes/fixes (3b796aa60af0 media: rename soc_camera I2C driv=
ers)
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
Merging vfs-fixes/fixes (3df629d873f8 gfs2_meta: ->mount() can get NULL dev=
_name)
Merging dma-mapping-fixes/for-linus (46bbeb69ff2f dma-mapping: add the miss=
ing ARCH_HAS_SYNC_DMA_FOR_CPU_ALL declaration)
CONFLICT (content): Merge conflict in kernel/dma/Kconfig
Merging drivers-x86-fixes/fixes (6bf4ca7fbc85 Linux 4.19-rc5)
Merging samsung-krzk-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging devicetree-fixes/dt/linus (8894891446c9 of: unittest: Disable inter=
rupt node tests for old world MAC systems)
Merging scsi-fixes/fixes (3cc5746e5ad7 scsi: qedi: Initialize the stats mut=
ex lock)
Merging drm-fixes/drm-fixes (fe7acd1e303d Merge tag 'drm-misc-fixes-2018-10=
-19' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (84df9525b0c2 Linux 4.19)
Merging mmc-fixes/fixes (e2b623fbe6a3 Merge tag 's390-4.20-1' of git://git.=
kernel.org/pub/scm/linux/kernel/git/s390/linux)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (e84cb605e02f drm/sun4i: Fix an=
 ulong overflow in the dotclock driver)
Merging kbuild/for-next (4c5c685f2a9c kbuild: remove cc-name variable)
Merging compiler-attributes/compiler-attributes (1ff2fea5e30c compiler-gcc:=
 remove comment about gcc 4.5 from unreachable())
CONFLICT (content): Merge conflict in include/linux/compiler_types.h
CONFLICT (content): Merge conflict in include/linux/compiler-gcc.h
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
Merging arm64/for-next/core (4debef551007 arm64: KVM: Guests can skip __ins=
tall_bp_hardening_cb()s HYP work)
Merging clk/clk-next (9a1d6b232bed Merge branches 'clk-fixed-rate-remove' a=
nd 'clk-qcom-cleanup' into clk-next)
Merging clk-samsung/for-next (9dbcfe1ace4e dt-bindings: clock: samsung: Add=
 SPDX license identifiers)
Merging c6x/for-linux-next (4d8106f0299c c6x: switch to NO_BOOTMEM)
Merging csky/linux-next (252050365823 dt-bindings: timer: gx6605s SOC timer)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging ia64/next (02b4da5f84d1 intel-iommu: mark intel_dma_ops static)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (381fdd62c383 m68k: fix command-line parsing whe=
n passed from u-boot)
Merging microblaze/next (c4347b05440f microblaze/PCI: Remove stale pcibios_=
align_resource() comment)
Merging mips/mips-next (edbb4233e7ef MIPS: Cleanup DSP ASE detection)
Merging nds32/next (3a9e41b52d52 nds32: Power management for nds32)
Merging nios2/for-next (c7c09dc187f0 nios2: kconfig: remove duplicate DEBUG=
_STACK_USAGE symbol defintions)
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (84df9525b0c2 Linux 4.19)
Merging powerpc/next (3b9672fff747 Merge branch 'next' of https://git.kerne=
l.org/pub/scm/linux/kernel/git/scottwood/linux into next)
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (b6ae3550c8e2 powerpc/8xx: add missing header in 8xx_mmu.c)
Merging risc-v/for-next (c31aa5c41f3b automerging branch "kernel.org-palmer=
-linux/next-revert_udivmoddi4" into "for-next")
Merging s390/features (5a2e1853d689 s390: avoid vmlinux segments overlap)
Merging sparc-next/master (345671ea0f92 Merge branch 'akpm' (patches from A=
ndrew))
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (917e2fd2c53e um: Make line/tty semantics use true w=
rite IRQ)
Merging xtensa/xtensa-for-next (c478d6d63f73 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (1056f93314bb Merge branch 'for-next-current-v=
4.19-20181025' into for-next-20181025)
Merging ceph/master (ea4cdc548e5e ceph: new mount option to disable usage o=
f copy-from op)
Merging cifs/for-next (a1986d621512 smb3: on kerberos mount if server doesn=
't specify auth type use krb5)
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
Merging nfs/linux-next (86bbd7422ae6 NFS: change sign of nfs_fh length)
Merging nfs-anna/linux-next (9f0c5124f4a8 NFS: Don't open code clearing of =
delegation state)
Merging nfsd/nfsd-next (93f38b6fae0e lockd: fix access beyond unterminated =
strings in prints)
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (14fa085640a7 ovl: using posix_acl_xattr_s=
ize() to get size instead of posix_acl_to_xattr())
Merging ubifs/linux-next (84db119f5a83 ubifs: Remove unneeded semicolon)
Merging v9fs/9p-next (fb488fc1f2b4 9p/trans_fd: put worker reqs on destroy)
Merging xfs/for-next (bf4a1fcf0bc1 xfs: remove [cm]time update from reflink=
 calls)
CONFLICT (content): Merge conflict in Documentation/filesystems/porting
Merging file-locks/locks-next (9f51ae62c84a Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/net)
Merging vfs/for-next (d708e87ca399 Merge branch 'work.mount' into for-next)
CONFLICT (content): Merge conflict in net/sunrpc/svcsock.c
CONFLICT (content): Merge conflict in fs/read_write.c
CONFLICT (content): Merge conflict in fs/proc/inode.c
CONFLICT (content): Merge conflict in fs/f2fs/super.c
CONFLICT (content): Merge conflict in fs/compat_ioctl.c
CONFLICT (content): Merge conflict in fs/ceph/file.c
CONFLICT (content): Merge conflict in drivers/infiniband/Kconfig
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a61eee132f1e Merge branch 'for-4.20-vsprintf-hash-=
fixes' into for-next)
Merging pci/next (663569db6476 Merge branch 'remotes/lorenzo/pci/tools')
Merging pstore/for-next/pstore (1227daa43bce pstore/ram: Clarify resource r=
eservation labels)
Merging hid/for-next (0aef342184e3 Merge branch 'for-4.19/fixes' into for-n=
ext)
Merging i2c/i2c/for-next (509439b1d981 Merge branch 'i2c/for-4.20' into i2c=
/for-next)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (e7c6a55606b5 hwmon: (pmbus) Fix page coun=
t auto-detection.)
Merging jc_docs/docs-next (aea74de4b216 docs: Fix typos in histogram.rst)
Merging v4l-dvb/master (3b796aa60af0 media: rename soc_camera I2C drivers)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (217188d9f985 video: fbdev: remove redundant '=
default n' from Kconfig-s)
Merging pm/linux-next (9e074f4644f0 Merge branch 'pm-sleep' into linux-next)
Merging cpupower/cpupower (cb91890ddf6f tools cpupower: Override CFLAGS ass=
ignments)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (deac8703da5f PM / OPP: _of_add_opp_table_v2(): =
increment count only if OPP is added)
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
Merging rdma/for-next (a60109dc9a95 IB/mlx5: Add support for extended atomi=
c operations)
Merging net-next/master (4b42745211af Merge tag 'armsoc-soc' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/arm/arm-soc)
Merging bpf-next/master (44adbac8f721 Merge branch 'work.tty-ioctl' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
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
Merging wireless-drivers-next/master (f95cd52476de Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (21ea1d36f6df Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/davem/net)
Merging mac80211-next/master (4b42745211af Merge tag 'armsoc-soc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc)
Merging gfs2/for-next (8e31582a9ab1 gfs2: Fix minor typo: couln't versus co=
uldn't.)
Merging mtd/mtd/next (042c1a5a6021 Merge tag 'nand/for-4.20' of git://git.i=
nfradead.org/linux-mtd into mtd/next)
Merging nand/nand/next (53c83b59759c mtd: rawnand: marvell: fix the IRQ han=
dler complete() condition)
Merging spi-nor/spi-nor/next (41fe242979e4 mtd: spi-nor: fsl-quadspi: fix r=
ead error for flash size larger than 16MB)
Merging crypto/master (a1c6fd4308d3 crypto: chelsio - Update ntx queue rece=
ived from cxgb4)
Merging drm/drm-next (f2bfc71aee75 Merge tag 'drm-intel-next-fixes-2018-10-=
18' of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (f9776280c29e drm/i915/dp: Restrict link r=
etrain workaround to external monitors)
Merging drm-tegra/drm/tegra/for-next (5ac93f81096a drm/tegra: Detach device=
s from IOMMU DMA domain on arm32)
Merging drm-misc/for-linux-next (8f054b6f53ff drm/panel: simple: Innolux TV=
123WAM is actually P120ZDG-BF1)
Merging drm-msm/msm-next (fa81b1ad6976 drm/msm: dpu: Don't set legacy plane=
->crtc pointer)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (fd99bd8b805c drm: malidp: Add the siz=
e of the superblocks when calculating total size for AFBC buffers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (6110ca962547 gpu: ipu-v3: image-convert: allo=
w three rows or columns)
Merging etnaviv/etnaviv/next (1a866306e0fb drm/etnaviv: add DMA configurati=
on for etnaviv platform device)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (031aef723a7d Merge remote-tracking branches 'regma=
p/topic/noinc' and 'regmap/topic/single-rw' into regmap-next)
Merging sound/for-next (826b5de90c0b ALSA: firewire-lib: fix insufficient P=
CM rule for period/buffer size)
Merging sound-asoc/for-next (eb69583e48b3 Merge branch 'asoc-4.20' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (f39f8688888a Input: synaptics - avoid using uninitializ=
ed variable when probing)
Merging block/for-next (f4bd8e08fb9d Merge branch 'for-linus' into for-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (da4ad3a23af3 dm writecache: remove disabled=
 code in memory_entry())
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (e2b623fbe6a3 Merge tag 's390-4.20-1' of git://git.kernel.=
org/pub/scm/linux/kernel/git/s390/linux)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
Merging md/for-next (af9b926de9c5 MD: Memory leak when flush bio size is ze=
ro)
Merging mfd/for-mfd-next (6eb357844373 mfd: cros_ec: Avoid unneeded interna=
l declaration warning)
Merging backlight/for-backlight-next (e1c9f2eaa0fb backlight: Remove ld9040=
 driver)
Merging battery/for-next (cfb347979e71 power: max8925: mark expected switch=
 fall-through)
Merging regulator/for-next (0e2347a145a3 Merge remote-tracking branches 're=
gulator/topic/bd718xx' and 'regulator/topic/pfuze100' into regulator-next)
Merging security/next-testing (3bd5c4efee1c Merge tag 'loadpin-security-nex=
t' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux into next-=
testing)
Merging apparmor/apparmor-next (e1af47796179 apparmor: add #ifdef checks fo=
r secmark filtering)
Merging integrity/next-integrity (34bccd61b139 MAINTAINERS: add Jarkko as m=
aintainer for trusted keys)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (4458bba09788 selinux: Add __GFP_NOWARN to allocation =
at str_read())
Merging tpmdd/next (e22bf023c141 tpm: tpm_ibmvtpm: fix kdoc warnings)
Merging watchdog/master (cd6ba41c192d watchdog: ts4800: release syscon devi=
ce node in ts4800_wdt_probe())
Merging iommu/next (2f2fbfb71ecc Merge branches 'arm/renesas', 'arm/smmu', =
'ppc/pamu', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (104c7405a64d vfio: add edid support to mbochs sample dri=
ver)
CONFLICT (content): Merge conflict in drivers/vfio/Kconfig
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (84df9525b0c2 Linux 4.19)
Merging devicetree/for-next (d061864b89c3 ARM: dt: relicense two DT binding=
 IRQ headers)
Merging mailbox/mailbox-for-next (9f0a0a381c5d mailbox: mediatek: Add check=
 for possible failure of kzalloc)
Merging spi/for-next (f6a196988c58 Merge remote-tracking branch 'spi/topic/=
of' into spi-next)
Merging tip/auto-latest (db9f03a422b6 Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (ad6e16059d8e EDAC, skx_edac: Add address transla=
tion for non-volatile DIMMs)
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
Merging xen-tip/linux-next (7a048cec598e xen: drop writing error messages t=
o xenstore)
Merging percpu/for-next (ad19ef010db1 Merge branch 'for-4.19-fixes' into fo=
r-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (49ad712afa88 platform/x86: Add Intel AtomISP2=
 dummy / power-management driver)
CONFLICT (content): Merge conflict in drivers/platform/x86/intel_telemetry_=
debugfs.c
CONFLICT (content): Merge conflict in drivers/platform/x86/intel_mid_powerb=
tn.c
CONFLICT (content): Merge conflict in drivers/platform/x86/intel_int0002_vg=
pio.c
Merging chrome-platform/for-next (bc3f4b5c60db platform/chrome: chromeos_tb=
mc - Remove unneeded const)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (eabf06ed6169 Fix pattern handling optimalization)
Merging ipmi/for-next (9bab8c2eb206 ipmi: Make the smi watcher be disabled =
immediately when not needed)
Merging driver-core/driver-core-next (9f51ae62c84a Merge git://git.kernel.o=
rg/pub/scm/linux/kernel/git/davem/net)
Merging usb/usb-next (69d5b97c5973 HID: we do not randomly make new drivers=
 'default y')
Merging usb-gadget/next (3b766f453557 USB: net2280: Remove ->disconnect() c=
allback from net2280_pullup())
Merging usb-serial/usb-next (17c42e34997a USB: serial: cypress_m8: remove s=
et but not used variable 'iflag')
Merging usb-chipidea-next/ci-for-usb-next (59739131e0ca usb: chipidea: Fix =
otg event handler)
Merging phy-next/next (566b388440bb phy: renesas: convert to SPDX identifie=
rs)
Merging tty/tty-next (11743c56785c Merge tag 'rpmsg-v4.20' of git://github.=
com/andersson/remoteproc)
Merging char-misc/char-misc-next (9f51ae62c84a Merge git://git.kernel.org/p=
ub/scm/linux/kernel/git/davem/net)
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (502c00d9c315 Documentation: soundwire: fix stream.r=
st markup warnings)
Merging staging/staging-next (11743c56785c Merge tag 'rpmsg-v4.20' of git:/=
/github.com/andersson/remoteproc)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (23ba90b47dfc interconnect: fix build error without DE=
BUGFS)
Merging slave-dma/next (c67a36067d07 Merge branch 'for-linus' into next)
Merging cgroup/for-next (f43d18401569 Merge branch 'for-4.20' into for-next)
Merging scsi/for-next (615a1fed8f42 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (33279c305d07 scsi: mvsas: Remove set but not use=
d variable 'id')
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (3a2abaa7ead7 virtio_blk: add discard and write ze=
roes support)
Merging rpmsg/for-next (0c0e4ddae234 Merge branches 'hwspinlock-next', 'rpm=
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
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9b25436662d5 random: make CPU trust a boot parameter)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (f73581f8d9a3 selftests/ftrace: Strip escape sequenc=
es for log file)
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (af93178ac25e coresight: tmc: Fix bad register addre=
ss for CLAIM)
Merging rtc/rtc-next (3822d1bb0df1 rtc: sc27xx: Always read normal alarm wh=
en registering RTC device)
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
Merging xarray/xarray (3a08cd52c37c radix tree: Remove multiorder support)
Merging akpm-current/current (8e77a3066a33 ipc: conserve sequence numbers i=
n extended IPCMNI mode)
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/compiler_types.h
CONFLICT (content): Merge conflict in include/linux/compiler-gcc.h
CONFLICT (content): Merge conflict in fs/read_write.c
CONFLICT (content): Merge conflict in arch/sparc/kernel/setup_64.c
CONFLICT (content): Merge conflict in arch/c6x/Kconfig
$ git checkout -b akpm remotes/origin/akpm/master
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (8a2a8cd58160 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/N2LbOwjEVBUN3xLvP.BQt6I
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlvZKIsACgkQAVBC80lX
0GxC7gf+P6VvuNyd0iv5Yp0xYDZm429kMnJ3q/HJ6XFrDtpmDbKZObBv7Y2mt/z3
qApaBs1v4+MgCXeor828bDluoLygVG7Tn1XCl6JbXc+4Lrho44nfK5UJbiD30CkD
jNwg7KDIM21uigPBxZQuRSVHi91eE2QJtvVKW2NfOB7GJ5BzymcwRqJwHtbhQHJ0
Qq2KMPnzLtYksQ+2Sr7IKXaAT6ZnZdYfxH/wFVXk5Tu3Pf9CF0sKd4L/ZU1OO6dC
gL058EXRrbpNYqDoR0mCB1n6RHExFE++/WpJ2Dbj2fwCsekmqczcuSc8p9ilz5ET
T4Cv1ACRw0qKNeZdM34f97mEvwXMGA==
=RZD7
-----END PGP SIGNATURE-----

--Sig_/N2LbOwjEVBUN3xLvP.BQt6I--
