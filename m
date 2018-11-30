Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E3DC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB7220863
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Fa+fCVX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB7220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbeK3RKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:10:21 -0500
Received: from ozlabs.org ([203.11.71.1]:43555 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbeK3RKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:10:20 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 435kLQ0CPRz9s3Z;
        Fri, 30 Nov 2018 17:02:06 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543557726;
        bh=7XPibAYLPFeJhNkxRn9hxvSW7KNE6iWin82cXEjR2QE=;
        h=Date:From:To:Cc:Subject:From;
        b=Fa+fCVX0+hNqRja6o9IUySzcOeEvRimnbzLsjzb347HFq899L95E6yDrRw+Aa59JU
         fT4F+975VXqfOsLyeyxy86IJustpoBcocn2whQfHqrpfSZrSPtBzk9/kjQmgk3NDUK
         LxXzud9/LroZ12xswyW3QII0PQ7XQmwJRHeipZeoGyl697MTOtrQtoypq9dPMoaLiB
         Wj8quFPspL375Z0kfUQxy9qw9Fpwz1FChgOhavJKnQPyi4JeHy/T0wkcAVU+OtWeMr
         IKYKlQ5wTEGWqrx3gpobPAeyNHCDP2qyQt9E2EVSXTIBRsx1/GvkDLcZ20HKZa26RM
         kGuX7dRgWOY5w==
Date:   Fri, 30 Nov 2018 17:02:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Nov 30
Message-ID: <20181130170205.6a28f28e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ckAFUlCaR7.6JIUQYZmO.U3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ckAFUlCaR7.6JIUQYZmO.U3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20181129:

The clk tree gained a build failure so I used the version from
next-20181129.

The akpm tree gained a build failure for which I applied a partial
revert patch.

Non-merge commits (relative to Linus' tree): 5706
 5781 files changed, 274209 insertions(+), 160066 deletions(-)

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
Merging origin/master (60b548237fed Merge git://git.kernel.org/pub/scm/linu=
x/kernel/git/davem/net)
Merging fixes/master (595c647d341e sparc: suppress the implicit-fallthrough=
 warnings)
Merging kbuild-current/fixes (ccda4af0f4b9 Linux 4.20-rc2)
Merging arc-current/for-curr (bf360f3b799f ARC: change defconfig defaults t=
o ARCv2)
Merging arm-current/fixes (e46daee53bb5 ARM: 8806/1: kprobes: Fix false pos=
itive with FORTIFY_SOURCE)
Merging arm64-fixes/for-next/fixes (874bfc6e5422 arm64: ftrace: Fix to enab=
le syscall events on arm64)
Merging m68k-current/for-linus (58c116fb7dc6 m68k/sun3: Remove is_medusa an=
d m68k_pgtable_cachemode)
Merging powerpc-fixes/fixes (462951cd32e1 powerpc/mm: Fix linux page tables=
 build with some configs)
Merging sparc/master (e399ef194171 sparc32: supress another implicit-fallth=
rough warning)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (e869e7b59906 Merge branch 'xps-fixes')
Merging bpf/master (528bff0cdb66 tools: bpftool: fix a bitfield pretty prin=
t issue)
Merging ipsec/master (4a135e538962 xfrm_user: fix freeing of xfrm states on=
 acquire)
Merging netfilter/master (d78a5ebd8b18 Merge branch '1GbE' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/jkirsher/net-queue)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (2e6e902d1850 Linux 4.20-rc4)
Merging mac80211/master (113f3aaa81bd cfg80211: Prevent regulatory restore =
during STA disconnect in concurrent interfaces)
Merging rdma-fixes/for-rc (75b7b86bdb0d IB/mlx5: Fix page fault handling fo=
r MW)
Merging sound-current/for-linus (5363857b916c ALSA: pcm: Fix interval evalu=
ation with openmin/max)
Merging sound-asoc-fixes/for-linus (b586eb05a2b8 Merge branch 'asoc-4.20' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (9ff01193a20d Linux 4.20-rc3)
Merging regulator-fixes/for-linus (af4d024d23b5 Merge branch 'regulator-4.2=
0' into regulator-linus)
Merging spi-fixes/for-linus (5377ce14c76a Merge branch 'spi-4.20' into spi-=
linus)
Merging pci-current/for-linus (0e62205ca505 Merge remote-tracking branch 'l=
orenzo/pci/controller-fixes' into for-linus)
Merging driver-core.current/driver-core-linus (a66d972465d1 devres: Align d=
ata[] to ARCH_KMALLOC_MINALIGN)
Merging tty.current/tty-linus (2a48602615e0 tty: do not set TTY_IO_ERROR fl=
ag if console port)
Merging usb.current/usb-linus (effd14f66cc1 usb: core: quirks: add RESET_RE=
SUME quirk for Cherry G230 Stream series)
Merging usb-gadget-fixes/fixes (069caf5950df USB: omap_udc: fix rejection o=
f out transfers when DMA is used)
Merging usb-serial-fixes/usb-linus (ccda4af0f4b9 Linux 4.20-rc2)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (c88520db18ba phy: qcom-qusb2: Fix HSTX_TRIM tuning with =
fused value for SDM845)
Merging staging.current/staging-linus (c648284f6c96 Merge tag 'iio-fixes-fo=
r-4.20a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into st=
aging-linus)
Merging char-misc.current/char-misc-linus (6484a677294a misc: mic/scif: fix=
 copy-paste error in scif_create_remote_lookup)
Merging soundwire-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging input-current/for-linus (10f91c73cc41 Input: hyper-v - fix wakeup f=
rom suspend-to-idle)
Merging crypto-current/master (e5bde04ccce6 crypto: do not free algorithm b=
efore using)
Merging ide/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (77e75fda94d2 dmaengine: at_hdmac: fix module=
 unloading)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (e8828ec1c003 mtd: spi-nor: fix selection of unifo=
rm erase type in flexible conf)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (10492ee8ed91 mfd: omap-usb-host: Fix dts p=
robe of children)
Merging v4l-dvb-fixes/fixes (a7c3a0d5f8d8 media: mediactl docs: Fix licensi=
ng message)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (7d35baa4e9ec MIPS: ralink: Fix mt7620 nd_sd =
pinmux)
Merging at91-fixes/at91-fixes (4ab7ca092c3c ARM: dts: at91: sama5d2: use th=
e divided clock for SMC)
Merging omap-fixes/fixes (91e43395820b Merge branch 'fixes-dts' into omap-f=
or-v4.20/fixes)
Merging kvm-fixes/master (fd65d3142f73 kvm: svm: Ensure an IBPB on all affe=
cted CPUs when freeing a vmcb)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (09aaf6813cfc hwmon: (w83795) temp4_type has writ=
able permission)
Merging nvdimm-fixes/libnvdimm-fixes (54c87b0caae4 Merge branch 'for-4.20/d=
ax-fixes' into libnvdimm-fixes)
Merging btrfs-fixes/next-fixes (e5a49b0e76d2 Merge branch 'misc-4.20' into =
next-fixes)
Merging vfs-fixes/fixes (78e1f3861707 iov_iter: teach csum_and_copy_to_iter=
() to handle pipe-backed ones)
Merging dma-mapping-fixes/for-linus (cb216b84d6ea swiotlb: Skip cache maint=
enance on map error)
Merging i3c-fixes/master (651022382c7f Linux 4.20-rc1)
Merging drivers-x86-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging samsung-krzk-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (89c38422e072 of, numa: Validate some dis=
tance map rules)
Merging scsi-fixes/fixes (c967590457ca scsi: storvsc: Fix a race in sub-cha=
nnel creation that can cause panic)
Merging drm-fixes/drm-fixes (ebcdcef30333 Merge tag 'drm-misc-fixes-2018-11=
-28-1' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (2455facbb700 Merge tag 'gvt-f=
ixes-2018-11-26' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (5305ec6a27b2 mmc: sdhci-pci: Workaround GLK firmwa=
re failing to restore the tuning value)
Merging rtc-fixes/rtc-fixes (9bde0afb7a90 rtc: pcf2127: fix a kmemleak caus=
ed in pcf2127_i2c_gather_write)
Merging gnss-fixes/gnss-linus (2e6e902d1850 Linux 4.20-rc4)
Merging drm-misc-fixes/for-linux-next-fixes (9765635b3075 Revert "drm/dp_ms=
t: Skip validating ports during destruction, just ref")
Merging kbuild/for-next (959fbcace1a1 Merge branches 'kbuild', 'kbuild2', '=
kconfig' and 'kconfig2' into for-next)
Merging compiler-attributes/compiler-attributes (24efee412c75 Compiler Attr=
ibutes: improve explanation of header)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging dma-mapping/for-next (c9d76d0655c0 dma-mapping: fix return type of =
dma_set_max_seg_size())
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
Merging amlogic/for-next (d7e552e8297f Merge branch 'v4.21/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (3368e06e2a91 ARM: dts: aspeed: Adding Facebook Tio=
gaPass BMC)
Merging at91/at91-next (39d48eea7c35 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (3c9d403d2fe1 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (63e879bf97af Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (42ac5fee3a13 Merge branch 'v4.19-next/soc' into =
for-next)
Merging mvebu/for-next (0f8a14a7cb8c Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (581fb9459050 Merge branch 'omap-for-v4.21/omap1' int=
o for-next)
Merging reset/reset/next (8a1b9fd55f25 reset: uniphier-glue: Add AHCI reset=
 control support in glue layer)
Merging qcom/for-next (e20395ba18ee Merge branch 'qcs404-topic' into all-fo=
r-4.21)
Merging renesas/next (7e57c13447c5 Merge branches 'fixes-for-v4.20', 'dt-bi=
ndings-for-v4.21', 'soc-for-v4.21', 'arm-defconfig-for-v4.21', 'arm-dt-for-=
v4.21', 'arm64-dt-for-v4.21' and 'arm64-defconfig-for-v4.21' into next)
Merging rockchip/for-next (a58e016a88c4 Merge branch 'v4.21-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (529a9b0984a2 Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (737fdee80faf Merge branch 'sunxi/dt-for-4.21'=
 into sunxi/for-next)
Merging tegra/for-next (47e16d964038 Merge branch for-4.21/clk into for-nex=
t)
Merging arm64/for-next/core (3d65b6bbc01e arm64: tlbi: Set MAX_TLBI_OPS to =
PTRS_PER_PTE)
Merging clk/clk-next (a6fda9a3b3fc Merge branch 'clk-imx8mq' into clk-next)
$ git reset --hard HEAD^
Merging next-20181129 version of clk
Merging clk-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (252050365823 dt-bindings: timer: gx6605s SOC timer)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (2e6e902d1850 Linux 4.20-rc4)
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
Merging powerpc/next (721c01ba8b46 powerpc/configs: Add KVM guest defconfig)
Merging fsl/next (b6ae3550c8e2 powerpc/8xx: add missing header in 8xx_mmu.c)
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (c9a2e997c8da automerging branch "kernel.org-palmer=
-linux/next-sg_chain" into "for-next")
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (6155c963bbc4 s390: use common bust_spinlocks())
Merging sparc-next/master (726799a4f919 Merge branch 'sparc-syscall-gen')
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (917e2fd2c53e um: Make line/tty semantics use true w=
rite IRQ)
Merging xtensa/xtensa-for-next (897368ebb6a7 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (2e6e902d1850 Linux 4.20-rc4)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (2566bdc50e6d Merge branch 'for-next-next-v4.2=
0-20181129' into for-next-20181129)
Merging ceph/master (7e241f647dc7 libceph: fall back to sendmsg for slab pa=
ges)
Merging cifs/for-next (86d3c694b89f cifs: suppress some implicit-fallthroug=
h warnings)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (b9ddfe6d2843 Pull dtype cleanup patches.)
Merging ext4/dev (53692ec074d0 ext4: fix buffer leak in ext4_expand_extra_i=
size_ea() on error path)
Merging f2fs/dev (19880e6e5ff3 f2fs: make "f2fs_fault_name[]" const char *)
Merging fuse/for-next (4fc4bb796b0c fuse: Add bad inode check in fuse_destr=
oy_inode())
Merging jfs/jfs-next (a83722f45c5b jfs: fix spelling mistake, EACCESS -> EA=
CCES)
Merging nfs/linux-next (121b018f8c74 Merge tag 'for-4.20-rc4-tag' of git://=
git.kernel.org/pub/scm/linux/kernel/git/kdave/linux)
Merging nfs-anna/linux-next (9f0c5124f4a8 NFS: Don't open code clearing of =
delegation state)
Merging nfsd/nfsd-next (ff33247f4084 svcrdma: Optimize the logic that selec=
ts the R_key to invalidate)
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (155b8a0492a9 ovl: fix decode of dir file =
handle with multi lower layers)
Merging ubifs/linux-next (001260910c46 ubifs: auth: add CONFIG_KEYS depende=
ncy)
Merging v9fs/9p-next (7373bc7654c1 9p/net: put a lower bound on msize)
Merging xfs/for-next (8c110d43c6bc iomap: readpages doesn't zero page tail =
beyond EOF)
Merging file-locks/locks-next (e93531255f64 locks: fix performance regressi=
ons.)
Merging vfs/for-next (d708e87ca399 Merge branch 'work.mount' into for-next)
CONFLICT (content): Merge conflict in fs/proc/inode.c
CONFLICT (content): Merge conflict in fs/f2fs/super.c
CONFLICT (content): Merge conflict in fs/compat_ioctl.c
CONFLICT (content): Merge conflict in fs/Makefile
CONFLICT (content): Merge conflict in drivers/vfio/Kconfig
CONFLICT (content): Merge conflict in drivers/infiniband/Kconfig
CONFLICT (content): Merge conflict in arch/sparc/kernel/setup_64.c
Merging printk/for-next (9adcfaffc34d printk: Make printk_emit() local func=
tion.)
Merging pci/next (651022382c7f Linux 4.20-rc1)
Merging pstore/for-next/pstore (1227daa43bce pstore/ram: Clarify resource r=
eservation labels)
Merging hid/for-next (16e70c1713e8 Merge branch 'for-4.21/hid-cougar' into =
for-next)
Merging i2c/i2c/for-next (62b836a0d248 Merge branch 'i2c/for-5.0' into i2c/=
for-next)
Merging i3c/i3c/next (bbd7cb21737f ic3: off by one in mode_show())
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
Merging pm/linux-next (f9ca83c5c001 Merge branches 'acpi-misc' and 'acpi-ta=
bles' into linux-next)
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
Merging dlm/next (f31a89692830 dlm: NULL check before kmem_cache_destroy is=
 not needed)
Merging swiotlb/linux-next (da689221f952 xen/blkfront: avoid NULL blkfront_=
info dereference on device removal)
Merging rdma/for-next (07f05f40d956 RDMA/uverbs: Use uverbs_attr_bundle to =
pass udata for ioctl())
Merging net-next/master (3d58c9c9f735 net: Don't default Aquantia USB drive=
r to 'y')
CONFLICT (content): Merge conflict in kernel/bpf/btf.c
Merging bpf-next/master (1ad93ab10e24 bpf: Fix various lib and testsuite bu=
ild failures on 32-bit.)
Merging ipsec-next/master (3fcccec008cf xfrm6: remove BUG_ON from xfrm6_dst=
_ifdown)
Merging mlx5-next/mlx5-next (2c89156082b3 net/mlx5: Improve core device eve=
nts handling)
Merging netfilter-next/master (b96609876922 netfilter: nf_flow_table: simpl=
ify nf_flow_offload_gc_step())
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (b72c51a58e6d brcmfmac: Fix out of bou=
nds memory access during fw load)
Merging bluetooth/master (86d1d8b72caf net/ipv4: Fix missing raw_init when =
CONFIG_PROC_FS is disabled)
Merging mac80211-next/master (ecbc12ad6b68 {nl,mac}80211: add rssi to mesh =
candidates)
Merging gfs2/for-next (d8aefef50d80 gfs2: Get rid of potential double-freei=
ng in gfs2_create_inode)
Merging mtd/mtd/next (c0e118c8a1a3 mtd: partitions: Add OF support to RedBo=
ot partitions)
Merging nand/nand/next (c41b8b4e44eb mtd: rawnand: Move ->setup_data_interf=
ace() to nand_controller_ops)
Merging spi-nor/spi-nor/next (fc8d8fdaf4f2 mtd: spi-nor: add entry for mt35=
xu512aba flash)
Merging crypto/master (7a027b57f959 crypto: cavium/nitrox - Enable interrup=
s for PF in SR-IOV mode.)
Merging drm/drm-next (167bfe534dc2 Documentation: drm: Remove dangling poin=
ter from drm-mm.rst)
CONFLICT (content): Merge conflict in drivers/gpu/drm/meson/meson_crtc.c
Merging drm-intel/for-linux-next (d6a09cee2458 drm/i915/fec: Disable FEC st=
ate.)
Merging drm-tegra/drm/tegra/for-next (e75d04771ad6 drm/tegra: dc: Don't cle=
an up unused display controller)
Merging drm-misc/for-linux-next (22be87401289 drm: TODO: Add DRM_MODESET_LO=
CK_ALL* conversion to todo.rst)
Merging drm-msm/msm-next (0bc371c7807e drm/msm/dpu: set geometry for iommu =
domain)
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
Merging sound/for-next (22b3b41c709b Merge branch 'topic/leds-trigger' into=
 for-next)
Merging sound-asoc/for-next (0887b7ee4995 Merge branch 'asoc-4.21' into aso=
c-next)
Merging modules/modules-next (2d25bc552353 module: make it clearer when we'=
re handling kallsyms symbols vs exported symbols)
Merging input/next (ed22cee91a88 Input: olpc_apsp - enable the SP clock)
Merging block/for-next (27fae429acee sbitmap: don't loop for find_next_zero=
_bit() for !round_robin)
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
Merging backlight/for-backlight-next (61170ee93868 backlight: pwm_bl: Fix d=
evicetree parsing with auto-generated brightness tables)
Merging battery/for-next (195ca1703784 power: supply: Add Spreadtrum SC27XX=
 fuel gauge unit driver)
Merging regulator/for-next (67863c2a310b Merge remote-tracking branch 'regu=
lator/topic/coupled' into regulator-next)
Merging security/next-testing (26b76320a8a5 Merge tag 'v4.20-rc2' into next=
-general)
Merging apparmor/apparmor-next (43aa09fee2f0 apparmor: Fix warning about un=
used function apparmor_ipv6_postroute)
Merging integrity/next-integrity (2b48646cd60f docs: Extend trusted keys do=
cumentation for TPM 2.0)
Merging selinux/next (89f5bebcf040 selinux: make "selinux_policycap_names[]=
" const char *)
CONFLICT (content): Merge conflict in security/selinux/hooks.c
Merging tpmdd/next (8f82ffbc5b0b tpm: add support for partial reads)
Merging watchdog/master (7db706a2184d watchdog: npcm: Modify npcm watchdog =
kconfig arch parameter)
Merging iommu/next (f262283c2245 Merge branches 'iommu/fixes', 'arm/renesas=
', 'arm/mediatek', 'arm/tegra', 'arm/omap', 'x86/vt-d', 'x86/amd' and 'core=
' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (104c7405a64d vfio: add edid support to mbochs sample dri=
ver)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (2a1fe215e730 audit: use current whenever possible)
Merging devicetree/for-next (e8b1dee21420 of: Use device_type helpers to ac=
cess the node type)
Merging mailbox/mailbox-for-next (9f0a0a381c5d mailbox: mediatek: Add check=
 for possible failure of kzalloc)
Merging spi/for-next (696dd7b3cd21 Merge remote-tracking branches 'spi/topi=
c/3wire-gpio', 'spi/topic/mem' and 'spi/topic/mtd' into spi-next)
Merging tip/auto-latest (0b02d688ca73 Merge branch 'x86/urgent')
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/resctrl/rdtgroup.c
Merging clockevents/clockevents/next (0aded575609e clocksource/drivers/inte=
grator-ap: Add missing of_node_put())
Merging edac-amd/for-next (8a880560d58a MAINTAINERS, EDAC: Drop bouncing em=
ail)
Merging irqchip/irq/irqchip-next (2130b789b3ef irqchip/gic: Unify GIC prior=
ity definitions)
Merging ftrace/for-next (3054426dc68e sched, trace: Fix prev_state output i=
n sched_switch tracepoint)
Merging rcu/rcu/next (e1426fd9855c Merge LKMM and RCU commits)
Merging kvm/linux-next (22a7cdcae6a4 KVM/nVMX: Do not validate that posted_=
intr_desc_addr is page aligned)
Merging kvm-arm/next (e4e11cc0f81e KVM: arm64: Safety check PSTATE when ent=
ering guest and handle IL)
Merging kvm-ppc/kvm-ppc-next (651022382c7f Linux 4.20-rc1)
Merging kvms390/next (ed3054a30258 Merge branch 'apv11' of git://git.kernel=
.org/pub/scm/linux/kernel/git/kvms390/linux into kernelorgnext)
Merging xen-tip/linux-next (975ef94a0284 pvcalls-front: fixes incorrect err=
or handling)
Merging percpu/for-next (ad19ef010db1 Merge branch 'for-4.19-fixes' into fo=
r-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (91a753608262 platform/x86: ideapad-laptop: Ad=
d Yoga 2 13 to no_hw_rfkill list)
Merging chrome-platform/for-next (6ad16b78a039 platform/chrome: don't repor=
t EC_MKBP_EVENT_SENSOR_FIFO as wakeup)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (e41ca3b1eab8 leds: powernv: add of_node_put())
Merging ipmi/for-next (5e6ddecfc90b ipmi:ssif: Change some pr_xxx to dev_xx=
x calls)
Merging driver-core/driver-core-next (f88184bfee48 driver core: Replace sim=
ple_strto{l,ul} by kstrtou{l,ul})
Merging usb/usb-next (77df6d8d7298 Documentation/usb: Fix typo)
Merging usb-gadget/next (d53701067f04 usb: dwc3: gadget: check if dep->fram=
e_number is still valid)
Merging usb-serial/usb-next (6abd837104a3 USB: serial: ftdi_sio: use roundi=
ng when calculating baud rate divisors)
Merging usb-chipidea-next/ci-for-usb-next (59739131e0ca usb: chipidea: Fix =
otg event handler)
Merging phy-next/next (9b28b23a7a12 phy: cadence: Add driver for Sierra PHY)
Merging tty/tty-next (2d13969ee7d8 serdev: document the write functions usi=
ng kernel-doc)
Merging char-misc/char-misc-next (b5570ca7c475 uio: dismiss waiters on devi=
ce unregistration)
Merging extcon/extcon-next (a2dc50914744 extcon: max8997: Fix lack of path =
setting in USB device mode)
Merging soundwire/next (b1635596860d soundwire: intel: constify snd_soc_dai=
_ops structures)
Merging staging/staging-next (7626e002225a staging: vchiq: add more tasks t=
o the TODO list)
CONFLICT (content): Merge conflict in drivers/staging/vboxvideo/vbox_ttm.c
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (23ba90b47dfc interconnect: fix build error without DE=
BUGFS)
Merging slave-dma/next (786022be93cb Merge branch 'topic/coh' into next)
Merging cgroup/for-next (ec77c03dbd5f Merge branch 'for-4.20-fixes' into fo=
r-next)
Merging scsi/for-next (95150405e108 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (9167f0dcc523 scsi: xen-scsifront: mark expected =
switch fall-through)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (79f800b2e769 MAINTAINERS: remove reference to bog=
us vsock file)
Merging rpmsg/for-next (9099a252d44c Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (0f3e68c2be67 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (ad082326b03c Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (f82d15e22340 pwm: lpc18xx-sct: Don't reconfigure PWM =
in .request and .free)
Merging userns/for-next (1e9c75fb9c47 mnt: fix __detach_mounts infinite loo=
p)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (1d956785da55 selftests/ftrace: Fix invalid SPDX ide=
ntifiers)
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (ebb8e6f8f403 coresight: fix spelling mistake "deffe=
red" -> "deferred")
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
Merging gnss/gnss-next (2e6e902d1850 Linux 4.20-rc4)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (39a577fe6163 slimbus: ngd: fix spelling mistake "=
exeeds" -> "exceeds")
Merging nvmem/for-next (5035d66cc629 nvmem: meson-efuse: add peripheral clo=
ck)
Merging xarray/xarray (fffc9a260e38 XArray tests: Add missing locking)
Merging akpm-current/current (45c94b91c466 ipc: conserve sequence numbers i=
n extended IPCMNI mode)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: scripts/atomic/check-atomics.sh: don't assume that scripts are ex=
ecutable
Applying: kernel/signal.c: remove some duplicated includes
Applying: kernel/signal.c: remove some duplicated includes
Applying: locking/atomics: build atomic headers as required
Applying: mm: replace all open encodings for NUMA_NO_NODE
Applying: mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
Applying: mm/sparse: add common helper to mark all memblocks present
Applying: mm: balloon: update comment about isolation/migration/compaction
Applying: mm: convert PG_balloon to PG_offline
Applying: mm-convert-pg_balloon-to-pg_offline-fix
Applying: kexec: export PG_offline to VMCOREINFO
Applying: xen/balloon: mark inflated pages PG_offline
Applying: hv_balloon: mark inflated pages PG_offline
Applying: vmw_balloon: mark inflated pages PG_offline
Applying: vmw_balloon-mark-inflated-pages-pg_offline-v2
Applying: PM/Hibernate: use pfn_to_online_page()
Applying: PM/Hibernate: exclude all PageOffline() pages
Applying: pm-hibernate-exclude-all-pageoffline-pages-v2
Applying: lib/lzo: tidy-up ifdefs
Applying: lib/lzo: clean-up by introducing COPY16
Applying: lib/lzo: enable 64-bit CTZ on Arm
Applying: lib/lzo: 64-bit CTZ on arm64
Applying: lib/lzo: fast 8-byte copy on arm64
Applying: lib/lzo: implement run-length encoding
Applying: lib/lzo: separate lzo-rle from lzo
Applying: kernel/locking/mutex.c: remove caller signal_pending branch predi=
ctions
Applying: kernel/sched/: remove caller signal_pending branch predictions
Applying: arch/arc/mm/fault.c: remove caller signal_pending_branch predicti=
ons
Applying: mm/: remove caller signal_pending branch predictions
Applying: fs/: remove caller signal_pending branch predictions
Applying: fs-remove-caller-signal_pending-branch-predictions-fix
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: fs: don't open code lru_to_page()
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (35a6bff95cfa drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)
Applying: partial revert (perf) of "mm: replace all open encodings for NUMA=
_NO_NODE"

--Sig_/ckAFUlCaR7.6JIUQYZmO.U3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwA0l0ACgkQAVBC80lX
0GzTDgf/eHLRtpfplijiMWb29fM6zMniQu8eIxEoU6qaKkeSumPSGY6PRDl16hjs
aPsWmpnEq+sziRhImTrL8MW+0lvaI9n1i6BrU2Dai+kATpnLOlDLfnp976Ia9NXo
dZD7qdOeafNEr0bcrBusJd5IhWN4H+8nLQniGgwpeEc9FIO7gLxHXwp0I8is+bmd
o2ZaG4u+VoI7bzVl9meTZgaqQna0B9CR7dQlQ1csNQlyJz+6+YzgeSS7HUPMDzGr
PKSK0shl97P6oO6lH2Tp/+iACaFDa5o38GxgPbdvibSnuXA7uTX8u3gC/lqbSGLo
38Iokj1opQa1jUXQN/HyqwBbyV2j+Q==
=rnNC
-----END PGP SIGNATURE-----

--Sig_/ckAFUlCaR7.6JIUQYZmO.U3--
