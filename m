Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F3FECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92F220856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="noMUibqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92F220856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbeGXI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:27:19 -0400
Received: from ozlabs.org ([203.11.71.1]:52647 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbeGXI1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:27:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41ZVDG5xVvz9s2M;
        Tue, 24 Jul 2018 17:22:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1532416926;
        bh=71pYJFBPLho22ZfPMsFlNVPdbOomHs8HE969OS4IFTg=;
        h=Date:From:To:Cc:Subject:From;
        b=noMUibqK7W5SEkrnzh5qJ7loZcfewC5OjWEB6DVQZ7QNlSeFUBxpuOHi8DKESTCuT
         754OUrg3/8kvoKrlKObUXSy9Hn6sf6FmY+e1R9MlOc4veUUdDATmyNFMs7dv6r46nG
         hf9MxyDUgvzIsPyU/S0U8CRPNb3TcZ7kG6QQej/4CqhlM7athnNzIbKDgMq7PrumHA
         1tQ0LXoHhg1IUB4YGtWHokwNxeVfy4dn6lMSsILTqpJ4q6R5ebY+BzRDM/GpBVm1ST
         FOBKvYcA5v3x0OINoDJPB841lB/lhiEXamoZ/PgQTIQ1sndgLKdPc/fy7uZvj+VHYt
         s8vy/lyhypXwA==
Date:   Tue, 24 Jul 2018 17:22:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 24
Message-ID: <20180724172206.754508d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/om4eMcJclL7.q6YmzrCUxn6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/om4eMcJclL7.q6YmzrCUxn6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180723:

Dropped trees: xarray, ida (complex conflicts)

The arm64 tree gained a conflict against Linus' tree.

The xarray tree still had its complex conflicts against the nvdimm tree
so I have dropped it again for today (along with the ida tree that is
built on top of it).

The akpm-current tree still had its build failure for which I reverted
a commit.

Non-merge commits (relative to Linus' tree): 7783
 7205 files changed, 322227 insertions(+), 144333 deletions(-)

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

I am currently merging 286 trees (counting Linus' and 65 trees of bug
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
Merging origin/master (d72e90f33aa4 Linux 4.18-rc6)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (9d3cce1e8b85 Linux 4.18-rc5)
Merging arc-current/for-curr (af1fc5baa724 ARCv2: [plat-hsdk]: Save accl re=
g pair by default)
Merging arm-current/fixes (b4c7e2bd2eb4 ARM: 8780/1: ftrace: Only set kerne=
l memory back to read-only after boot)
Merging arm64-fixes/for-next/fixes (2fd8eb4ad871 arm64: neon: Fix function =
may_use_simd() return error status)
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (b03897cf318d powerpc/powernv: Fix save/restore=
 of SPRG3 on entry/exit from stop (idle))
Merging sparc/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel=
.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (1a4f14bab186 Merge branch 'tcp-robust-ooo')
Merging bpf/master (1a4f14bab186 Merge branch 'tcp-robust-ooo')
Merging ipsec/master (7284fdf39a91 esp6: fix memleak on error path in esp6_=
input)
Merging netfilter/master (6613b6173dee netfilter: conntrack: dccp: treat SY=
NC/SYNCACK as invalid if no prior state)
Merging ipvs/master (0026129c8629 rhashtable: add restart routine in rhasht=
able_free_and_destroy())
Merging wireless-drivers/master (248c690a2dc8 Merge tag 'wireless-drivers-f=
or-davem-2018-07-03' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo=
/wireless-drivers)
Merging mac80211/master (5cf3006cc81d nl80211: Add a missing break in parse=
_station_flags)
Merging rdma-fixes/for-rc (d63c46734c54 RDMA/mlx5: Fix memory leak in mlx5_=
ib_create_srq() error path)
Merging sound-current/for-linus (dfef01e15082 ALSA: memalloc: Don't exceed =
over the requested size)
Merging sound-asoc-fixes/for-linus (9357cbb5ae8a Merge branch 'asoc-4.18' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (d72e90f33aa4 Linux 4.18-rc6)
Merging regulator-fixes/for-linus (34d50e73100f Merge branch 'regulator-4.1=
8' into regulator-linus)
Merging spi-fixes/for-linus (f1e620ba2e79 Merge branch 'spi-4.18' into spi-=
linus)
Merging pci-current/for-linus (270ed733e689 PCI: v3-semi: Fix I/O space pag=
e leak)
Merging driver-core.current/driver-core-linus (722e5f2b1eec driver core: Pa=
rtially revert "driver core: correct device's shutdown order")
Merging tty.current/tty-linus (021c91791a5e Linux 4.18-rc3)
Merging usb.current/usb-linus (249a32b7eeb3 usb: core: handle hub C_PORT_OV=
ER_CURRENT condition)
Merging usb-gadget-fixes/fixes (eec24f2a0d4d usb: gadget: f_uac2: fix endia=
nness of 'struct cntrl_*_lay3')
Merging usb-serial-fixes/usb-linus (9d3cce1e8b85 Linux 4.18-rc5)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (ad5003300b07 phy: mapphone-mdm6600: Fix wrong enum used =
for status lines)
Merging staging.current/staging-linus (b96fba8d5855 staging: speakup: fix w=
raparound in uaccess length check)
Merging char-misc.current/char-misc-linus (9d3cce1e8b85 Linux 4.18-rc5)
Merging input-current/for-linus (384cf4285b34 Input: i8042 - add Lenovo LaV=
ie Z to the i8042 reset list)
Merging crypto-current/master (46d8c4b28652 crypto: padlock-aes - Fix Nano =
workaround data corruption)
Merging ide/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/abelloni/linux)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (1e4b044d2251 Linux 4.18-rc4)
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (aa7eee8a143a mtd: spi-nor: cadence-quadspi: Fix d=
irect mode write timeouts)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (ce397d215ccd Linux 4.18-rc1)
Merging v4l-dvb-fixes/fixes (0ca54b290541 media: rc: be less noisy when dri=
ver misbehaves)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (bc88ad2efd11 MIPS: ath79: fix register addre=
ss in ath79_ddr_wb_flush())
Merging omap-fixes/fixes (d3f6daede246 ARM: dts: omap4-droid4: fix dts w.r.=
t. pwm)
Merging kvm-fixes/master (63aff65573d7 kvm: x86: vmx: fix vpid leak)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (1e4b044d2251 Linux 4.18-rc4)
Merging nvdimm-fixes/libnvdimm-fixes (ee6581ceba7f nfit: fix unchecked dere=
ference in acpi_nfit_ctl)
Merging btrfs-fixes/next-fixes (0b7162742121 Merge branch 'for-next-current=
-v4.18-20180717' into next-fixes)
Merging vfs-fixes/fixes (9ba546c01976 aio: don't expose __aio_sigset in uap=
i)
Merging dma-mapping-fixes/for-linus (7ec916f82c48 Revert "iommu/intel-iommu=
: Enable CONFIG_DMA_DIRECT_OPS=3Dy and clean up intel_{alloc,free}_coherent=
()")
Merging drivers-x86-fixes/fixes (9d3cce1e8b85 Linux 4.18-rc5)
Merging samsung-krzk-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (ce397d215ccd Linux 4.18-rc1)
Merging devicetree-fixes/dt/linus (b9952b5218ad of: overlay: update phandle=
 cache on overlay apply and remove)
Merging scsi-fixes/fixes (b4146c4929ef scsi: qla2xxx: Return error when TMF=
 returns)
Merging drm-fixes/drm-fixes (02e546eaccea Merge branch 'linux-4.18' of git:=
//github.com/skeggsb/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (d72e90f33aa4 Linux 4.18-rc6)
Merging mmc-fixes/fixes (3b1074bf9817 mmc: mxcmmc: Fix missing parentheses =
and brace)
Merging rtc-fixes/rtc-fixes (fd6792bb022e rtc: fix alarm read and set offse=
t)
Merging drm-misc-fixes/for-linux-next-fixes (d530b5f1ca0b drm: re-enable er=
ror handling)
Merging kbuild/for-next (d5a57dff2213 Merge branch 'kconfig' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (2550bbfd4952 dma-direct: don't crash on devic=
e without dma_mask)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (52e19c3c1eaf Merge branches 'clkdev', 'fixes', 'misc'=
 and 'spectre' into for-next)
Merging arm-perf/for-next/perf (c13207905340 arm64: perf: Add support for c=
haining event counters)
Merging arm-soc/for-next (b2df9d609df1 ARM: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (471ea3399607 Merge branch 'v4.19/dt64' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (403d991cce7d Merge branches 'defconfig-for-v4.19' =
and 'dt-for-v4.19' into for-next)
Merging at91/at91-next (f45853da06e3 Merge tag 'at91-ab-4.19-soc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux into at91-next)
Merging bcm2835/for-next (5997adb14985 Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
CONFLICT (content): Merge conflict in drivers/hwmon/Kconfig
CONFLICT (content): Merge conflict in drivers/firmware/raspberrypi.c
Merging imx-mxs/for-next (7586f152bcad Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (ed3bf0f321b9 Merge branch 'for_4.19/drivers-soc' int=
o next)
Merging mediatek/for-next (b75253e66bc5 Merge branch 'v4.18-next/soc' into =
for-next)
Merging mvebu/for-next (23b7c60b80f6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (d356801075c5 Merge branch 'omap-for-v4.19/dt' into f=
or-next)
Merging reset/reset/next (d903779b58be reset: meson: add meson audio arb dr=
iver)
Merging qcom/for-next (76b9e7f947f1 Merge tag 'qcom-defconfig-for-4.19' int=
o all-for-4.19)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (7e58fb78c672 Merge branches 'fixes-for-v4.18', 'arm-d=
efconfig-for-v4.19', 'arm-soc-for-v4.19', 'arm-dt-for-v4.19', 'arm64-defcon=
fig-for-v4.19', 'arm64-dt-for-v4.19' and 'dt-bindings-for-v4.19' into next)
Merging rockchip/for-next (75589311007d Merge branch 'v4.19-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (3ea8dc0e9d72 Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (51c756fe7803 Merge branch 'sunxi/dt64-for-4.1=
9' into sunxi/for-next)
Merging tegra/for-next (f29cfb31cf00 Merge branch for-4.19/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (b965746306bc rseq/selftests: Add support for a=
rm64)
CONFLICT (content): Merge conflict in arch/arm64/Makefile
Merging clk/clk-next (4db3ff7a7f11 Merge branch 'clk-qcom-rpmh' into clk-ne=
xt)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging h8300/h8300-next (54692056a201 h8300: Correct signature of test_bit=
())
Merging m68k/for-next (cd629147324c m68k/defconfig: Update defconfigs for v=
4.18-rc1)
Merging m68knommu/for-next (8aea73ec2077 m68knommu: Fix typos in Coldfire 5=
272 DMA debug code)
Merging microblaze/next (ed207a743444 microblaze: remove consistent_sync an=
d consistent_sync_page)
Merging mips/mips-next (a30718868915 MIPS: Change definition of cpu_relax()=
 for Loongson-3)
CONFLICT (content): Merge conflict in arch/mips/kernel/process.c
Merging nds32/next (d2516b16bcbc nds32: fix logic for module)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (ae15a41a6414 openrisc: entry: Fix delay slot exc=
eption detection)
Merging parisc-hd/for-next (ce397d215ccd Linux 4.18-rc1)
Merging powerpc/next (dbc3f77c2fea selftests/powerpc: Consolidate copy/past=
e test logic)
CONFLICT (content): Merge conflict in drivers/vfio/vfio_iommu_spapr_tce.c
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (d72e90f33aa4 Linux 4.18-rc6)
Merging s390/features (ef4b891f7924 s390: vdso_fault return type)
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (5ec9121195a4 um: Fix raw interface options)
Merging xtensa/xtensa-for-next (cb6db64ef5a9 Merge branch 'xtensa-dma-fixes=
' into xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (6f383855b92d Merge branch 'for-next-next-v4.1=
9-20180716' into for-next-20180716)
Merging ceph/master (8b8f53af1ed9 ceph: fix dentry leak in splice_dentry())
Merging cifs/for-next (771d1f7d68aa SMB3: Number of requests sent should be=
 displayed for SMB3 not just CIFS)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (6aee47d7f61e Pull in fsnotify cleanups from Amir and=
 new inotify IN_MASK_CREATE flag support.)
Merging ext4/dev (f4a79b7b4ab5 ext4: fix warning message in ext4_enable_quo=
tas())
Merging f2fs/dev (a5e028bee784 f2fs: fix to do sanity check with inline fla=
gs)
Merging fuse/for-next (8139306548ab fuse: convert last timespec use to time=
spec64)
Merging jfs/jfs-next (bd646104ac5a jfs: use time64_t for otime)
Merging nfs/linux-next (7b0df92ac121 pNFS/flexfiles: Process writeback rese=
nds from nfsiod context as well)
Merging nfs-anna/linux-next (ffbfa2ce88f1 sunrpc: Fix latency trace point c=
rashes)
Merging nfsd/nfsd-next (32620db998a5 NFSD stop ongoing async copies on clie=
nt shutdown)
Merging orangefs/for-next (f35cf2ab06b6 orangefs: remove redundant pointer =
orangefs_inode)
Merging overlayfs/overlayfs-next (989974c80457 ovl: Enable metadata only fe=
ature)
Merging ubifs/linux-next (f5a926dd5298 mtd: ubi: Update ubi-media.h to dual=
 license)
Merging v9fs/9p-next (58b536f23899 net/9p/trans_fd.c: fix race-condition by=
 flushing workqueue before the kfree())
Merging xfs/for-next (efe803277364 xfs: Initialize variables in xfs_alloc_g=
et_rec before using them)
Merging file-locks/locks-next (1cf8e5de4055 fs/lock: show locks taken by pr=
ocesses from another pidns)
Merging vfs/for-next (f6756d7df991 Merge branch 'work.misc' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (7973c51853f8 Merge branch 'for-4.19-nmi' into for-=
next)
Merging pci/next (b3dd889f1a82 Merge branch 'remotes/lorenzo/pci/vmd')
CONFLICT (content): Merge conflict in drivers/pci/controller/pci-aardvark.c
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (4e9544262a93 Merge branch 'for-4.19/cougar' into for-=
next)
Merging i2c/i2c/for-next (5069f9b0ef23 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (12005ec33f3a hwmon: (iio_hwmon) Use devm =
functions)
Merging jc_docs/docs-next (fe3136f44141 mm: Introduce new type vm_fault_t)
Merging v4l-dvb/master (39fbb88165b2 media: bpf: ensure bpf program is free=
d on detach)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (34db50e55656 efifb: Copy the ACPI BGRT boot g=
raphics to the framebuffer)
Merging pm/linux-next (4693ae3406cb Merge branch 'pm-devfreq' into linux-ne=
xt)
Merging cpupower/cpupower (ce397d215ccd Linux 4.18-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (c5c2a97b3ac7 PM / OPP: Update voltage in case f=
req =3D=3D old_freq)
Merging thermal/next (e9ed3ee61aa6 Merge branches 'thermal-core' and 'therm=
al-intel' into next)
Merging thermal-soc/next (1d32d387967c thermal: ti-soc-thermal: remove dead=
 code)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (c012691508f5 IB/cm: Remove cma_multicast->igmp_joine=
d)
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
Merging net-next/master (c9eaaa177398 Merge branch 'lan743x-Add-features-to=
-lan743x-driver')
CONFLICT (content): Merge conflict in net/smc/smc_ib.c
Merging bpf-next/master (fd800f646402 wan/fsl_ucc_hdlc: use IS_ERR_VALUE() =
to check return value of qe_muram_alloc)
Merging ipsec-next/master (5baf4f9c0035 xfrm: Allow xfrmi if_id to be updat=
ed by UPDSA)
Merging mlx5-next/mlx5-next (048f31437ac5 net/mlx5: Fix tristate and descri=
ption for MLX5 module)
Merging netfilter-next/master (0a78c3803d19 net: mediatek: use dma_zalloc_c=
oherent instead of allocator/memset)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (66c524acfb51 netfilter: conntrack: remove l3proto=
 abstraction)
CONFLICT (content): Merge conflict in net/netfilter/Makefile
CONFLICT (content): Merge conflict in net/netfilter/Kconfig
CONFLICT (content): Merge conflict in net/ipv6/netfilter/Kconfig
Merging wireless-drivers-next/master (4a07ed51cae1 mt76x2: debugfs: add sw =
pulse statistics to dfs debugfs)
Merging bluetooth/master (25a13e382de2 bluetooth: hci_qca: Replace GFP_ATOM=
IC with GFP_KERNEL)
Merging mac80211-next/master (518ea3c54eb7 mac80211_hwsim: Add support for =
HE)
Merging gfs2/for-next (e2b8bd8c3088 gfs2: remove redundant variable 'moved')
Merging mtd/mtd/next (d70420bcd447 mtd: adapt misleading comment in mtd_oob=
_ops structure)
Merging nand/nand/next (db4a671e39ff mtd: rawnand: add hooks that may be ca=
lled during nand_scan())
Merging spi-nor/spi-nor/next (a3804084ddf0 mtd: spi-nor: stm32-quadspi: rep=
lace "%p" with "%pK")
Merging crypto/master (0e7d4d932ffc crypto: sharah - Unregister correct alg=
orithms for SAHARA 3)
Merging drm/drm-next (500775074f88 Merge branch 'drm-next-4.19' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_irq.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/powerplay/smumgr/=
smu7_smumgr.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/inc/dc=
_link_ddc.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/dce/dc=
e_mem_input.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/dc/core/d=
c_link_ddc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm_services.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/display/amdgpu_dm=
/amdgpu_dm_mst_types.c
Applying: drm/i915/kvmgt: merge fixup for "Check the pfn got from vfio_pin_=
pages"
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (102506d52922 drm/i915/dp: Refactor max_vs=
wing_tries variable)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (574e0fbfc95e drm/rockchip: Replace drm_dev=
_unref with drm_dev_put)
Merging drm-msm/msm-next (010148c5b155 drm/msm: rework vblank event handlin=
g in dpu_crtc)
CONFLICT (content): Merge conflict in drivers/gpu/drm/msm/dsi/dsi_manager.c
Applying: drm: msm: merge fix for drm_plane_helper_disable() API change
Merging hdlcd/for-upstream/hdlcd (ce40d096e8ce drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (e368fc75c190 drm/arm/malidp: Added th=
e late system pm functions)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (81f2b25addde drm/imx: Remove unused field imx=
_drm_device.pipes)
Merging etnaviv/etnaviv/next (f6ffbd4fc1a1 drm/etnaviv: replace license tex=
t with SPDX tags)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (0bf0f09cc45b Merge branch 'regmap-4.19' into regma=
p-next)
Merging sound/for-next (1ea0358ecb84 ALSA: usb-audio: Generic DSD detection=
 for Thesycon-based implementations)
Merging sound-asoc/for-next (e9fff424b719 Merge branch 'asoc-4.19' into aso=
c-next)
Merging modules/modules-next (4d58e7034d19 ARM: module: fix modsign build e=
rror)
Merging input/next (2b6e68119c47 Input: gpio_keys - add missing include to =
gpio_keys.h)
Merging block/for-next (e7a0c1f1ee45 Merge branch 'for-4.19/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (f88a3f746ff0 dm thinp: update stale "status=
" Documentation)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (44350993d01c mmc: tegra: Add and use tegra_sdhci_get_max_=
clock())
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (08edaaa6d6fa drivers/md/raid5: Do not disable irq on r=
elease_inactive_stripe_list() call)
Merging mfd/for-mfd-next (99266311865e mfd: axp20x: Support AXP806 in I2C m=
ode)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Kconfig
Merging backlight/for-backlight-next (858c5dfc8c33 backlight: adp8860: Mark=
 expected switch fall-through)
Merging battery/for-next (9c7272412bc5 power: supply: lego_ev3_battery: fix=
 Vce offset)
Merging regulator/for-next (835fee3270ea Merge branch 'regulator-4.19' into=
 regulator-next)
Merging security/next-testing (530a13df0b0b Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (24b87a16fee0 apparmor: Fix failure to audit=
 context info in build_change_hat)
Merging integrity/next-integrity (3dd0f18c70d9 EVM: fix return value check =
in evm_write_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (631d2b490569 selinux: constify write_op[])
Merging tpmdd/next (776afd171925 ima: Get rid of ima_used_chip and use ima_=
tpm_chip !=3D NULL instead)
Merging watchdog/master (9d3cce1e8b85 Linux 4.18-rc5)
Merging iommu/next (a8cfa7c8491c Merge branches 'iommu/fixes', 'arm/shmobil=
e', 'arm/renesas', 'arm/msm', 'x86/amd', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (c1abca96b252 samples: mbochs: add DMA_SHARED_BUFFER depe=
ndency)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (baa2a4fdd525 audit: fix use-after-free in audit_add_wat=
ch)
Merging devicetree/for-next (3a6372daddeb dt-bindings: sound: wm8994: docum=
ent wlf,csnaddr-pd property)
Merging mailbox/mailbox-for-next (f83d1cfc8bcd mailbox/drivers/hisi: Consol=
idate the Kconfig for the MAILBOX)
Merging spi/for-next (b21a7862903a Merge branch 'spi-4.19' into spi-next)
Merging tip/auto-latest (fc3d25e1c8f6 Merge branch 'x86/timers')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6663484b4e2d EDAC, thunderx: Remove VLA usage)
Merging irqchip/irq/irqchip-next (6a88c221acba ARM: dts: stm32: Add exti su=
pport to stm32mp157 pinctrl)
Merging ftrace/for-next (a9235b544a0a ring-buffer: Fix typo in comment)
Merging rcu/rcu/next (d57fa29ddc3c Merge LKMM and RCU commits)
Merging kvm/linux-next (6f0d349d922b Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/davem/net)
Merging kvm-arm/next (b0960b9569db KVM: arm: Add 32bit get/set events suppo=
rt)
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpucaps.h
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (0abb75b7a16d KVM: PPC: Book3S HV: Fix constan=
t size warning)
Merging kvms390/next (a3da7b4a3be5 KVM: s390: add etoken support for guests)
Merging xen-tip/linux-next (0ce0bba4e5e0 xen: setup pv irq ops vector earli=
er)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (66448bc274ca workqueue: move function definiti=
ons within CONFIG_SMP block)
Merging drivers-x86/for-next (c2e2a618eb71 platform/x86: toshiba_acpi: Fix =
defined but not used build warnings)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (ce397d215ccd Linux 4.18-rc1)
Merging leds/for-next (6f7b0bad8839 usb: simplify usbport trigger)
Merging ipmi/for-next (a4fb7ddc6356 ipmi: kcs_bmc: don't change device name)
Merging driver-core/driver-core-next (e16f4f3e0b7d base: core: Remove WARN_=
ON from link dependencies check)
CONFLICT (content): Merge conflict in fs/sysfs/group.c
CONFLICT (content): Merge conflict in drivers/iommu/ipmmu-vmsa.c
Merging usb/usb-next (12dcaeb77e67 usb: usbtmc: Add ioctl for termination c=
haracter)
Merging usb-gadget/next (47265c067c0d usb: dwc2: gadget: Fix coverity issue)
Merging usb-serial/usb-next (c8acfe0aadbe USB: serial: cp210x: implement GP=
IO support for CP2102N)
Merging usb-chipidea-next/ci-for-usb-next (ba0ab35a81de usb: chipidea: tegr=
a: Use aligned DMA on Tegra114/124)
Merging phy-next/next (d5f5ee1a16a4 phy: berlin: switch to SPDX license ide=
ntifier)
Merging tty/tty-next (b340cbbea5b8 serial: 8250_exar: Drop unused variable =
in pci_xr17v35x_setup())
Merging char-misc/char-misc-next (bce5c2ea350f uio: add SPDX license tags)
Merging extcon/extcon-next (8a9dbb779fe8 extcon: Release locking when sendi=
ng the notification of connector state)
Merging staging/staging-next (9005feae4785 staging: rtl8712: remove redunda=
nt pointer 'nic')
CONFLICT (modify/delete): drivers/staging/skein/skein_generic.c deleted in =
staging/staging-next and modified in HEAD. Version HEAD of drivers/staging/=
skein/skein_generic.c left in tree.
$ git rm -f drivers/staging/skein/skein_generic.c
Applying: Revert "Revert "staging:r8188eu: Use lib80211 to support TKIP""
Merging mux/for-next (6a3d4baac84a mux: add mux_control_get_optional() API)
Merging slave-dma/next (e1966eb8a1b1 Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (d92f5db64445 Merge branch 'misc' into for-next)
CONFLICT (modify/delete): lib/percpu_ida.c deleted in scsi/for-next and mod=
ified in HEAD. Version HEAD of lib/percpu_ida.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
$ git rm -f lib/percpu_ida.c
Merging scsi-mkp/for-next (f4e34f2a5dd9 scsi: hisi_sas: Add SATA FIS check =
for v3 hw)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (45fd63e2b8c9 Merge branch 'for-4.19' into for-next)
Applying: Revert "ata: ahci_platform: allow disabling of hotplug to save po=
wer"
Merging vhost/linux-next (2eb98105f8c7 virtio: update the comments for tran=
sport features)
Merging rpmsg/for-next (3d065621c921 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (8387c0a88e23 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (254e939f5234 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (ce397d215ccd Linux 4.18-rc1)
Merging pwm/for-next (19ad2b75c643 pwm: mxs: Switch to SPDX identifier)
Merging userns/for-next (04035aa33a12 proc: Don't change mount options on r=
emount failure.)
CONFLICT (content): Merge conflict in fs/proc/root.c
CONFLICT (content): Merge conflict in fs/proc/internal.h
CONFLICT (content): Merge conflict in fs/proc/inode.c
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (eb02b09aa8af random: remove preempt disabled region)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (d2d49495b5c0 selftests: vDSO - fix to return KSFT_S=
KIP when test couldn't be run)
Merging y2038/y2038 (e264abeaf9da pstore: Remove bogus format string defini=
tion)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (1f0a504d39ae coresight: tpiu: Fix disabling timeout=
s)
Merging rtc/rtc-next (7e580769b79f rtc: ds1307: support m41t11 variant)
Merging nvdimm/libnvdimm-for-next (cda5db1ee99c Merge branch 'for-4.19/dax-=
memory-failure' into libnvdimm-for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/mcheck/mce.c
Merging at24/at24/for-next (ce397d215ccd Linux 4.18-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (9edc4161661e Merge branch 'for-next/usercopy' i=
nto for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging xarray/xarray (4c8e6fcba165 radix tree: Remove radix_tree_clear_tag=
s)
CONFLICT (content): Merge conflict in fs/dax.c
CONFLICT (content): Merge conflict in MAINTAINERS
$ git reset --hard HEAD
Merging fsi/master (0a213777d1dd fsi: Add support for device-tree provided =
chip IDs)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging ida/ida (7f9e5cb90e68 ida: Convert to XArray)
CONFLICT (content): Merge conflict in fs/dax.c
CONFLICT (content): Merge conflict in MAINTAINERS
$ git reset --hard HEAD
Merging akpm-current/current (63a0a84adc08 mm, vmacache: hash addresses bas=
ed on pmd fix)
CONFLICT (content): Merge conflict in mm/mmap.c
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/bitops.h
CONFLICT (content): Merge conflict in fs/f2fs/data.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
Applying: fixup for bit.h/bitops.h merge
$ git checkout -b akpm remotes/origin/akpm/master
Applying: drivers/hwtracing/intel_th/msu.c: change return type to vm_fault_t
Applying: fs/nfs/file.c: use new return type vm_fault_t
Applying: fs/afs: use new return type vm_fault_t
Applying: treewide: correct "differenciate" and "instanciate" typos
Applying: fs/proc/vmcore.c: hide vmcoredd_mmap_dumps() for nommu builds
Applying: drivers/gpu/drm/gma500/: change return type to vm_fault_t
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (ff19b504c122 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)
Applying: Revert "proc/kcore: add vmcoreinfo note to /proc/kcore"

--Sig_/om4eMcJclL7.q6YmzrCUxn6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltW054ACgkQAVBC80lX
0GxbIwf9Ey+uN5m40V6E8y8FvN98DU+95ZSA7UIgI26byZJvlz61rY7I5ml5WUwB
CTmOMBsFK0WepBZJw/cIyG6uDpFXf9+Gx0rcuOnWj7wbM9jKrYIU+uo206w9XFll
EXDMUhb3OPcqHKzmI+/6/5a+ulBks/0Vb6gGE4hd9prgho7CqoN66sWyiPzG9FHU
/kgsu7f4KYcTr5H5yEBy4gaJ6vRLy03LM5HMNV9yZmXWhNHzpsJ5FQyMgxz1faW0
229zabzVT5T5I3ay5GIw5H8ujKsalOPk/tcf/ZoVPXD7kck2dMBZmwKLfPD2oZal
gq8jWFUzppHznOFxTDSoIVMDN8aJZw==
=ajeh
-----END PGP SIGNATURE-----

--Sig_/om4eMcJclL7.q6YmzrCUxn6--
