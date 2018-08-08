Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56251C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C944621727
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="N27DDngc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C944621727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeHHKMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:12:10 -0400
Received: from ozlabs.org ([203.11.71.1]:57521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeHHKMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:12:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41lkCd3f9Tz9ryt;
        Wed,  8 Aug 2018 17:53:33 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533714813;
        bh=hhnhh2LHkwCXnrW7vsnFxrCnMtB4k6g90uAHDZ4J5Ao=;
        h=Date:From:To:Cc:Subject:From;
        b=N27DDngcsKZE/rtXpc/bhMNuFHJ53FOlkaRhi6hUD0+izzhiUkatJM3++hg/uDSL3
         QO/L431Z0GFLu8xYOQRBZunwZcikldfugBrCKrQI5TmR7ZC1CJNJdIKEvY5iNFZzUZ
         zkIvcY//7Q0quzsoIaSbaQ2CWrmYU8Ip9+u7aroIaNFgaxbgy7fd4HugzaVMgfwGmh
         aGCMJ8O5ZfNTzralT7QX1g3xGNDbATdeH0+l/VStwZr6hhJLVTBpDnioKSEyjuwPHh
         SHZJ5/PQwzJwOhP6JGffpQ8kugitxiyI1NyRQ6PWrQwKMihWqfr6zHbbW3Q2Vfy5b7
         PNQKrCy+07Tow==
Date:   Wed, 8 Aug 2018 17:53:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 8
Message-ID: <20180808175332.0b356ab4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QM.Pefwi=9JC7vqN0c10FTh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QM.Pefwi=9JC7vqN0c10FTh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180807:

The vfs tree still had its build failure but today I applied a suggested
patch and I have still disabled CONFIG_SAMPLE_STATX.

The kvm tree gained a semantic conflict against the tip tree (actually
yesterday) for which I applied a merge fix patch.

Non-merge commits (relative to Linus' tree): 11342
 10339 files changed, 488780 insertions(+), 202892 deletions(-)

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
Merging origin/master (1236568ee3cb Merge tag 'gpio-v4.18-3' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (9d3cce1e8b85 Linux 4.18-rc5)
Merging arc-current/for-curr (7945121f56a2 ARC: [plat-axs*]: Enable SWAP)
Merging arm-current/fixes (afc9f65e01cd ARM: 8781/1: Fix Thumb-2 syscall re=
turn for binutils 2.29+)
Merging arm64-fixes/for-next/fixes (c7513c2a2714 crypto/arm64: aes-ce-gcm -=
 add missing kernel_neon_begin/end pair)
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (cca19f0b684f powerpc/64s/radix: Fix missing gl=
obal invalidations when removing copro)
Merging sparc/master (c1d61e7fe376 Merge tag 'scsi-fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (37436d9c0e8f tipc: fix an interrupt unsafe locking scen=
ario)
Merging bpf/master (74682128c6e4 bpf: btf: Change tools/lib/bpf/btf to LGPL)
Merging ipsec/master (25432eba9cd8 openvswitch: meter: Fix setting meter id=
 for new entries)
Merging netfilter/master (16e98cec49a4 ipvs: don't show negative times in i=
p_vs_conn)
Merging ipvs/master (16e98cec49a4 ipvs: don't show negative times in ip_vs_=
conn)
Merging wireless-drivers/master (299b6365a3b7 brcmfmac: fix regression in p=
arsing NVRAM for multiple devices)
Merging mac80211/master (e31f6456c01c cfg80211: never ignore user regulator=
y hint)
Merging rdma-fixes/for-rc (addb8a6559f0 RDMA/uverbs: Expand primary and alt=
 AV port checks)
Merging sound-current/for-linus (627661ced824 ALSA: dice: fix wrong copy to=
 rx parameters for Alesis iO26)
Merging sound-asoc-fixes/for-linus (6dfefdfcf59d Merge branch 'asoc-4.18' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (d72e90f33aa4 Linux 4.18-rc6)
Merging regulator-fixes/for-linus (50f6ab5ed897 Merge branch 'regulator-4.1=
8' into regulator-linus)
Merging spi-fixes/for-linus (a5e97ad82ebf Merge branch 'spi-4.18' into spi-=
linus)
Merging pci-current/for-linus (44bda4b7d26e PCI: Fix is_added/is_busmaster =
race condition)
Merging driver-core.current/driver-core-linus (acb1872577b3 Linux 4.18-rc7)
Merging tty.current/tty-linus (021c91791a5e Linux 4.18-rc3)
Merging usb.current/usb-linus (acb1872577b3 Linux 4.18-rc7)
Merging usb-gadget-fixes/fixes (acb1872577b3 Linux 4.18-rc7)
Merging usb-serial-fixes/usb-linus (9d3cce1e8b85 Linux 4.18-rc5)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (ad5003300b07 phy: mapphone-mdm6600: Fix wrong enum used =
for status lines)
Merging staging.current/staging-linus (acb1872577b3 Linux 4.18-rc7)
Merging char-misc.current/char-misc-linus (9d3cce1e8b85 Linux 4.18-rc5)
Merging input-current/for-linus (ce1d6f22fa69 Input: elan_i2c_smbus - cast =
sizeof to int for comparison)
Merging crypto-current/master (877ccce7cbe8 crypto: x86/aegis,morus - Fix a=
nd simplify CPUID checks)
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
Merging v4l-dvb-fixes/fixes (8eb0e6421958 media: v4l: vsp1: Fix deadlock in=
 VSPDL DRM pipelines)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (d5ea019f8a38 Revert "MIPS: BCM47XX: Enable 7=
4K Core ExternalSync for PCIe erratum")
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
Merging vfs-fixes/fixes (90bad5e05bcd root dentries need RCU-delayed freein=
g)
Merging dma-mapping-fixes/for-linus (7ec916f82c48 Revert "iommu/intel-iommu=
: Enable CONFIG_DMA_DIRECT_OPS=3Dy and clean up intel_{alloc,free}_coherent=
()")
Merging drivers-x86-fixes/fixes (2502e5a02593 platform/x86: dell-laptop: Fi=
x backlight detection)
Merging samsung-krzk-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (ce397d215ccd Linux 4.18-rc1)
Merging devicetree-fixes/dt/linus (b9952b5218ad of: overlay: update phandle=
 cache on overlay apply and remove)
Merging scsi-fixes/fixes (e95153b64d03 scsi: vmw_pvscsi: Return DID_RESET f=
or status SAM_STAT_COMMAND_TERMINATED)
Merging drm-fixes/drm-fixes (51973dc079a9 Merge tag 'drm-misc-fixes-2018-07=
-27' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (1ffaddd029c8 Linux 4.18-rc8)
Merging mmc-fixes/fixes (3b1074bf9817 mmc: mxcmmc: Fix missing parentheses =
and brace)
Merging rtc-fixes/rtc-fixes (fd6792bb022e rtc: fix alarm read and set offse=
t)
Merging drm-misc-fixes/for-linux-next-fixes (404fb5c9ef26 drm/vc4: Fix the =
"no scaling" case on multi-planar YUV formats)
Merging kbuild/for-next (a42bb5681020 Merge branch 'kbuild' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (6fa1d28e38cf sh: use generic dma_noncoherent_=
ops)
CONFLICT (content): Merge conflict in arch/nios2/Kconfig
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (f13960dd3890 Merge branches 'clkdev', 'fixes', 'misc'=
 and 'spectre' into for-next)
Merging arm-perf/for-next/perf (809092dc3e60 drivers/perf: arm-ccn: Use dev=
m_ioremap_resource() to map memory)
Merging arm-soc/for-next (cd0a9070a96a arm-soc: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (b4a2f821c4a1 Merge branch 'v4.19/dt64' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (c224edaa4a46 Merge branches 'defconfig-for-v4.19' =
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
Merging rockchip/for-next (efdcb339b730 Merge branch 'v4.19-clk/next' into =
for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (babb70ce9674 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (51c756fe7803 Merge branch 'sunxi/dt64-for-4.1=
9' into sunxi/for-next)
Merging tegra/for-next (f29cfb31cf00 Merge branch for-4.19/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (dcab90d90935 arm64: kexec: Add comment to expl=
ain use of __flush_icache_range())
CONFLICT (content): Merge conflict in arch/arm64/Makefile
Merging clk/clk-next (d89bee6307c4 Merge branch 'clk-cs2000-spdx' into clk-=
next)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging h8300/h8300-next (54692056a201 h8300: Correct signature of test_bit=
())
Merging m68k/for-next (71a896687b85 m68k/defconfig: Update defconfigs for v=
4.18-rc6)
Merging m68knommu/for-next (58064e1f46b1 m68knommu: Fix typos in Coldfire 5=
272 DMA debug code)
Merging microblaze/next (9fe37714c13c microblaze: delete wrong comment abou=
t machine_early_init)
Merging mips/mips-next (36dc5b20e31d MIPS: Use dins to simplify __write_64b=
it_c0_split())
CONFLICT (content): Merge conflict in arch/mips/kernel/process.c
CONFLICT (content): Merge conflict in arch/mips/Kconfig
Merging nds32/next (d2516b16bcbc nds32: fix logic for module)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (f3ab52be339b parisc: Define mb() and add memory=
 barriers to assembler unlock sequences)
Merging powerpc/next (77b5f703dcc8 powerpc/powernv/opal: Use standard inter=
rupts property when available)
CONFLICT (content): Merge conflict in drivers/vfio/vfio_iommu_spapr_tce.c
CONFLICT (content): Merge conflict in arch/m68k/mac/misc.c
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (c1e8b252489c RISC-V: Align .Lsecondary_park)
Merging s390/features (26f843848bae s390: fix br_r1_trampoline for machines=
 without exrl)
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
Merging btrfs-kdave/for-next (bba3fea4997e Merge branch 'for-next-next-v4.1=
9-20180803' into for-next-20180803)
Merging ceph/master (e9da429f9976 ceph: change to void return type for __do=
_request())
Merging cifs/for-next (468d677954c0 smb3: display stats counters for number=
 of slow commands)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (6aee47d7f61e Pull in fsnotify cleanups from Amir and=
 new inotify IN_MASK_CREATE flag support.)
Merging ext4/dev (863c37fcb14f ext4: remove unneeded variable "err" in ext4=
_mb_release_inode_pa())
Merging f2fs/dev (a86e98df9f78 f2fs: wake up gc thread immediately when gc_=
urgent is set)
Merging fuse/for-next (963545357202 fuse: reduce allocation size for splice=
_write)
Merging jfs/jfs-next (bd646104ac5a jfs: use time64_t for otime)
Merging nfs/linux-next (6ea76bf51339 NFSv4: Fix _nfs4_do_setlk())
Merging nfs-anna/linux-next (8e22b011b242 NFSv4: Mark the inode change attr=
ibute up to date in update_changeattr())
Merging nfsd/nfsd-next (6676ba16eedb nfsd: Mark expected switch fall-throug=
h)
Merging orangefs/for-next (f35cf2ab06b6 orangefs: remove redundant pointer =
orangefs_inode)
Merging overlayfs/overlayfs-next (989974c80457 ovl: Enable metadata only fe=
ature)
Merging ubifs/linux-next (f5a926dd5298 mtd: ubi: Update ubi-media.h to dual=
 license)
Merging v9fs/9p-next (9f961802a781 net/9p/trans_virtio.c: add null terminal=
 for mount tag)
Merging xfs/for-next (a0e336ba3e3d xfs: fix a comment in xfs_log_reserve)
Merging file-locks/locks-next (96c25b777442 mailmap: remap some of my email=
 addresses to kernel.org address)
Merging vfs/for-next (4f12336e3d97 Merge branch 'fixes' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Applying: Try to get the headers installed before we build the samples
Applying: vfs: samples: fix up for HOSTLOADLIBES rename
Applying: disable CONFIG_SAMPLE_STATX for now
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a4322becd21e Merge branch 'for-4.19-nmi' into for-=
next)
Merging pci/next (2ec20b4fd890 Merge branch 'remotes/lorenzo/pci/vmd')
CONFLICT (content): Merge conflict in drivers/pci/pci.h
CONFLICT (content): Merge conflict in drivers/pci/controller/pci-aardvark.c
Merging pstore/for-next/pstore (1021bcf44d0e pstore: add zstd compression s=
upport)
Merging hid/for-next (872d1282470b Merge branch 'for-4.19/intel-ish' into f=
or-next)
Merging i2c/i2c/for-next (4e1faaef496d Merge branch 'i2c/for-4.19' into i2c=
/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (484a84f25ca7 hwmon: (k10temp) 27C Offset =
needed for Threadripper2)
Merging jc_docs/docs-next (673bb2dfc364 scripts/kernel-doc: Escape all lite=
ral braces in regexes)
CONFLICT (content): Merge conflict in Documentation/index.rst
Merging v4l-dvb/master (4effa8bfe4f6 media: i2c: fix warning in Aptina MT9V=
111)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (044e7ca20496 fbdev: omap2: omapfb: fix ifnull=
free.cocci warnings)
Merging pm/linux-next (9630385fa600 Merge branch 'pm-cpufreq' into linux-ne=
xt)
Merging cpupower/cpupower (ce397d215ccd Linux 4.18-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (c5c2a97b3ac7 PM / OPP: Update voltage in case f=
req =3D=3D old_freq)
Merging thermal/next (5043f06ecec6 MAINTAINERS: Add Daniel Lezcano as desig=
nated reviewer for thermal)
Merging thermal-soc/next (542cdf406804 thermal: rcar_thermal: avoid NULL de=
reference in absence of IRQ resources)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (760109760455 IB/ipoib: Consolidate checking of the p=
roposed child interface)
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_main.c
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
Merging net-next/master (541ad323db3a selftests: forwarding: gre_multipath:=
 Update next-hop statistics match criteria)
CONFLICT (content): Merge conflict in net/smc/smc_ib.c
CONFLICT (content): Merge conflict in net/smc/smc_core.c
CONFLICT (content): Merge conflict in net/rds/ib_send.c
CONFLICT (content): Merge conflict in net/netfilter/ipvs/ip_vs_conn.c
Merging bpf-next/master (85fc4b16aaf0 bpf: introduce update_effective_progs=
())
Merging ipsec-next/master (ba7f4b3a3810 xfrm: Make function xfrmi_get_link_=
net() static)
Merging mlx5-next/mlx5-next (664000b6bb43 net/mlx5: Add support for flow ta=
ble destination number)
Merging netfilter-next/master (981467033a37 tc-testing: remove duplicate sp=
aces in skbedit match patterns)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (981467033a37 tc-testing: remove duplicate spaces =
in skbedit match patterns)
Merging wireless-drivers-next/master (33c740411ada Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (7d2eb6de6e63 MAINTAINERS: add an entry for MediaT=
ek Bluetooth driver)
Merging mac80211-next/master (133bf90dbb8b mac80211: restrict delayed tailr=
oom needed decrement)
Merging gfs2/for-next (dffe12a82826 gfs2: Fix gfs2_testbit to use clone bit=
maps)
Merging mtd/mtd/next (76a832254ab0 mtd: partitions: use DT info for parsing=
 partitions with "compatible" prop)
Merging nand/nand/next (ed128e8b757b MAINTAINERS: drop Wenyou Yang from Atm=
el NAND driver support)
Merging spi-nor/spi-nor/next (bb276262e88d mtd: spi-nor: only apply reset h=
acks to broken hardware)
Merging crypto/master (22240df7ac6d crypto: arm64/ghash-ce - implement 4-wa=
y aggregation)
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fs_ene=
t/mac-fec.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fec_ma=
in.c
Merging drm/drm-next (824da016fde1 Merge tag 'drm-intel-next-fixes-2018-08-=
06' of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Applying: drm/i915/kvmgt: merge fixup for "Check the pfn got from vfio_pin_=
pages"
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (3237c0dbe21f drm/i915/kvmgt: Fix compilat=
ion error)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (2ead1be54b22 drm/vkms: Fix connector leak =
at the module removal)
Merging drm-msm/msm-next (dabc10ef8b45 drm/msm: Add A6XX device support)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (e368fc75c190 drm/arm/malidp: Added th=
e late system pm functions)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (5c41bb607125 gpu: ipu-v3: add support for XRG=
B32 and XBGR32 V4L2 pixel formats)
Merging etnaviv/etnaviv/next (5b1474655323 drm/etnaviv: fix crash in GPU su=
spend when init failed due to buffer placement)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (0bf0f09cc45b Merge branch 'regmap-4.19' into regma=
p-next)
Merging sound/for-next (d2f884612c42 ALSA: intel_hdmi: remove redundant var=
iable cfg_val)
Merging sound-asoc/for-next (250cbe79662a Merge branch 'asoc-4.19' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (6078091c9fa8 Input: evdev - switch to bitmap API)
Merging block/for-next (d29fa65e8fbf Merge branch 'for-4.19/block' into for=
-next)
CONFLICT (content): Merge conflict in drivers/nvme/target/rdma.c
Applying: nvme-dma: merge fix up for replacement of max_sge
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (1c65e3945825 dm kcopyd: avoid softlockup in=
 run_complete_job)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (7f38abf220e2 mmc: core: improve reasonableness of bus wid=
th setting for HS400es)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (d63e2fc804c4 md/raid5: fix data corruption of replacem=
ents after originals dropped)
Merging mfd/for-mfd-next (fe8166c92a5f mfd: sec-core: Export OF module alia=
s table)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Kconfig
Merging backlight/for-backlight-next (633786736ed5 backlight: pwm_bl: Fix u=
ninitialized variable)
Merging battery/for-next (3d779180c692 power: supply: bq27xxx: Update comme=
nts)
Merging regulator/for-next (69e2b476076a Merge branch 'regulator-4.19' into=
 regulator-next)
Merging security/next-testing (d83c732fffc3 Merge branch 'smack-for-4.19-a'=
 of https://github.com/cschaufler/next-smack into next-testing)
Merging apparmor/apparmor-next (24b87a16fee0 apparmor: Fix failure to audit=
 context info in build_change_hat)
Merging integrity/next-integrity (3dd0f18c70d9 EVM: fix return value check =
in evm_write_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (631d2b490569 selinux: constify write_op[])
Merging tpmdd/next (ec403d8ed08c ima: Get rid of ima_used_chip and use ima_=
tpm_chip !=3D NULL instead)
Merging watchdog/master (12aea518a202 watchdog: fix dependencies of menz69_=
wdt.o)
Merging iommu/next (a6d297302f78 Merge branches 'arm/shmobile', 'arm/renesa=
s', 'arm/msm', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0dd0e297f0ec vfio-pci: Disable binding to PFs with SR-IO=
V enabled)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (baa2a4fdd525 audit: fix use-after-free in audit_add_wat=
ch)
Merging devicetree/for-next (a3cfcecdb38b dt-bindings: Add Y Soft Corporati=
on vendor prefix)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/net=
/can/xilinx_can.txt
Merging mailbox/mailbox-for-next (623a6143a845 mailbox: mediatek: Add Media=
tek CMDQ driver)
Merging spi/for-next (58b4da82cafd Merge branch 'spi-4.19' into spi-next)
Merging tip/auto-latest (d9c665147478 Merge branch 'sched/urgent' into auto=
-latest)
CONFLICT (content): Merge conflict in drivers/infiniband/core/rdma_core.c
CONFLICT (content): Merge conflict in arch/openrisc/Kconfig
CONFLICT (content): Merge conflict in arch/arm64/Kconfig
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (190bd6e98afc EDAC, sb_edac: Add support for syst=
ems with segmented PCI buses)
Merging irqchip/irq/irqchip-next (a8db74564b0c irqchip/gic-v3-its: Make its=
_lock a raw_spin_lock_t)
Merging ftrace/for-next (a9235b544a0a ring-buffer: Fix typo in comment)
Merging rcu/rcu/next (d57fa29ddc3c Merge LKMM and RCU commits)
CONFLICT (content): Merge conflict in kernel/sched/core.c
Merging kvm/linux-next (fd8ca6dac9b4 KVM/x86: Use CC_SET()/CC_OUT in arch/x=
86/kvm/vmx.c)
CONFLICT (content): Merge conflict in arch/x86/include/asm/trace/hyperv.h
Applying: kvm: x86: fix semantic conflict in platform init
Merging kvm-arm/next (245715cbe83c KVM: arm/arm64: Fix lost IRQs from emula=
ted physcial timer when blocked)
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpucaps.h
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (b5c6f7607b90 KVM: PPC: Book3S HV: Read kvm->a=
rch.emul_smt_mode under kvm->lock)
Merging kvms390/next (237584619366 Merge tag 'hlp_stage1' of git://git.kern=
el.org/pub/scm/linux/kernel/git/kvms390/linux into kvms390/next)
Merging xen-tip/linux-next (cd9139220b87 xen: don't use privcmd_call() from=
 xen_mc_flush())
Applying: xen/gntdev: fix up for attach callback API change
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (66448bc274ca workqueue: move function definiti=
ons within CONFIG_SMP block)
Merging drivers-x86/for-next (0b4e30f49aa4 platform/x86: mlx-platform: Remo=
ve unused define)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (ce397d215ccd Linux 4.18-rc1)
Merging leds/for-next (2224f2ff9670 leds: ns2: Change unsigned to unsigned =
int)
Merging ipmi/for-next (a4fb7ddc6356 ipmi: kcs_bmc: don't change device name)
Merging driver-core/driver-core-next (d2fc88a61b4e Merge 4.18-rc7 into driv=
er-core-next)
CONFLICT (content): Merge conflict in fs/sysfs/group.c
CONFLICT (content): Merge conflict in drivers/iommu/ipmmu-vmsa.c
Merging usb/usb-next (29c692c96b3a USB: serial: pl2303: add a new device id=
 for ATEN)
Merging usb-gadget/next (4ea438da76f4 usb: dwc3: gadget: Check MaxPacketSiz=
e from descriptor)
Merging usb-serial/usb-next (c8acfe0aadbe USB: serial: cp210x: implement GP=
IO support for CP2102N)
Merging usb-chipidea-next/ci-for-usb-next (ba0ab35a81de usb: chipidea: tegr=
a: Use aligned DMA on Tegra114/124)
Merging phy-next/next (ec14b83a1ee4 phy: mvebu-cp110-comphy: switch to SPDX=
 identifier)
Merging tty/tty-next (60ab0fafc4b6 serial: 8250_exar: Read INT0 from slave =
device, too)
Merging char-misc/char-misc-next (a39284ae9d2a misc: mic: SCIF Fix scif_get=
_new_port() error handling)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging extcon/extcon-next (8a9dbb779fe8 extcon: Release locking when sendi=
ng the notification of connector state)
Merging staging/staging-next (2bc7596438ab staging: erofs: fix if assignmen=
t style issue)
CONFLICT (modify/delete): drivers/staging/skein/skein_generic.c deleted in =
staging/staging-next and modified in HEAD. Version HEAD of drivers/staging/=
skein/skein_generic.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/iio=
/pressure/bmp085.txt
$ git rm -f drivers/staging/skein/skein_generic.c
Merging mux/for-next (2c01260df661 mux: add mux_control_get_optional() API)
Merging slave-dma/next (fe2309127e8c Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (2bf00908cc35 Merge branch 'misc' into for-next)
CONFLICT (modify/delete): lib/percpu_ida.c deleted in scsi/for-next and mod=
ified in HEAD. Version HEAD of lib/percpu_ida.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
$ git rm -f lib/percpu_ida.c
Merging scsi-mkp/for-next (dc0aa9925881 scsi: qla2xxx: Update driver versio=
n to 10.00.00.08-k)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (cc28cd5c6181 Merge branch 'for-4.19' into for-next)
Merging vhost/linux-next (89da619bc18d virtio_balloon: fix another race bet=
ween migration and ballooning)
Merging rpmsg/for-next (02c801b2fc28 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (46136a390af5 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (cb85d2b04b40 pinctrl: intel: Don't shadow error c=
ode of gpiochip_lock_as_irq())
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/pin=
ctrl/st,stm32-pinctrl.txt
Merging pinctrl-samsung/for-next (b3793159249b dt-bindings: pinctrl: samsun=
g: Add SPDX license identifier)
Merging pwm/for-next (19ad2b75c643 pwm: mxs: Switch to SPDX identifier)
Merging userns/for-next (04035aa33a12 proc: Don't change mount options on r=
emount failure.)
CONFLICT (content): Merge conflict in fs/proc/root.c
CONFLICT (content): Merge conflict in fs/proc/internal.h
CONFLICT (content): Merge conflict in fs/proc/inode.c
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9a47249d444d random: Make crng state queryable)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (d2d49495b5c0 selftests: vDSO - fix to return KSFT_S=
KIP when test couldn't be run)
Merging y2038/y2038 (e264abeaf9da pstore: Remove bogus format string defini=
tion)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (a154bd6aec53 coresight: etm-perf: Add support for E=
TR backend)
Merging rtc/rtc-next (5a5ba10f44fa rtc: remove struct rtc_task)
Merging nvdimm/libnvdimm-for-next (64742dbc88dc Merge branch 'for-4.19/dax-=
memory-failure' into libnvdimm-for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/mcheck/mce.c
Merging at24/at24/for-next (a2b3bf4846e5 eeprom: at24: Add support for addr=
ess-width property)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (8e4ec2134312 Merge branch 'vla/leftovers' into =
for-next/kspp)
CONFLICT (content): Merge conflict in arch/Kconfig
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging xarray/xarray (f039e3979325 radix tree: Remove radix_tree_clear_tag=
s)
CONFLICT (content): Merge conflict in fs/dax.c
CONFLICT (content): Merge conflict in MAINTAINERS
Merging fsi/master (15e2a7218c27 fsi: sbefifo: Bump max command length)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging ida/ida (d69dd7ae5cd8 ida: Convert to XArray)
Merging akpm-current/current (2b6be492ab11 ipc/util.c: update return value =
of ipc_getref from int to bool)
CONFLICT (content): Merge conflict in lib/Kconfig.debug
CONFLICT (content): Merge conflict in kernel/fork.c
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/bitops.h
CONFLICT (content): Merge conflict in fs/f2fs/data.c
CONFLICT (content): Merge conflict in drivers/xen/gntdev.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
CONFLICT (content): Merge conflict in drivers/firmware/efi/libstub/Makefile
Applying: fixup for bit.h/bitops.h merge
$ git checkout -b akpm remotes/origin/akpm/master
Applying: drivers/hwtracing/intel_th/msu.c: change return type to vm_fault_t
Applying: fs/afs: use new return type vm_fault_t
Applying: treewide: correct "differenciate" and "instanciate" typos
Applying: fs/proc/vmcore.c: hide vmcoredd_mmap_dumps() for nommu builds
Applying: mm/util: make strndup_user description a kernel-doc comment
Applying: mm/util: add kernel-doc for kvfree
Applying: docs/core-api: kill trailing whitespace in kernel-api.rst
Applying: docs/core-api: move *{str,mem}dup* to "String Manipulation"
Applying: docs/core-api: split memory management API to a separate file
Applying: docs/mm: make GFP flags descriptions usable as kernel-doc
Applying: docs/core-api: mm-api: add section about GFP flags
Applying: drivers/gpu/drm/gma500/: change return type to vm_fault_t
Applying: treewide: convert ISO_8859-1 text comments to utf-8
Applying: s390: ebcdic: convert comments to UTF-8
Applying: lib/fonts: convert comments to utf-8
Applying: mm: Change return type int to vm_fault_t for fault handlers
Applying: mm-change-return-type-int-to-vm_fault_t-for-fault-handlers-fix
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (36d9b611e4bf drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/QM.Pefwi=9JC7vqN0c10FTh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltqoXwACgkQAVBC80lX
0GzqqAf+M6sCIc/P5/JjQuUeywAgBbSnQkR4WaEVZHDpK5PVLY4e4iHGgwyPj59L
iTBKIcFmZ/luyfIoh8as5wOlORvWwEcSO0iGwQYZvgmy7yh0sfflN+vt9aOT+PFv
O2DZRhrI6L3jmNT2ugbWN1sEjGjF/E+0wEKfnf67OvlwykioGWe/w6zLfNMHqNpU
XwfuJIKjDIf0OYoFnnWRUwluDkZtSiSvaX6X5YJ4hUI26pxNV34p9BOh5zPfRw8l
/i+zIGlhzSXaoI0uOmFQmDUPajTQ7S98YbGbqQhAHOOlzWAPUOkdxOoATZUYvMrw
fzVJgfWTA97aQrkNZsXbTvFlTPtT9w==
=7FVK
-----END PGP SIGNATURE-----

--Sig_/QM.Pefwi=9JC7vqN0c10FTh--
