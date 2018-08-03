Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AD9C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E1202173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DsW2s0Zz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1202173F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbeHCLZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:25:18 -0400
Received: from ozlabs.org ([203.11.71.1]:40023 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730617AbeHCLZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:25:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41hhZv1VW2z9s2g;
        Fri,  3 Aug 2018 19:29:43 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533288583;
        bh=JFEM1k694nMQt0vncD+uMVQFNr1HX6eoVUuWi7jXocY=;
        h=Date:From:To:Cc:Subject:From;
        b=DsW2s0ZzV1MbfBVW0KQOpvuMddKjIz8RRTRfiZqicoippy+kNMFpLHfi9HDEya7Ep
         7sdWMgoMAc4K2OGqcpDdk4bdNojmr/GK70xRQML6hbvvxZoFn6hoySm+L6mphzOGcm
         NOcnH+hrtr7T1033d9lUIp/aS8y5r4/GH3MBt+Z8Ih/U/UJOpTiqK9jID5PDdFzYT9
         0z/4v263elKGxqgnUYrzzhPCMKw2J+4XsHTZ8AmxXt6rnLHxC885OqB1gJNjRvczea
         ZTRNMOTyZuNAHOI6ky0wXPRBGHH1d31Sl1iuX2CERnhPBuzjgM66O1Df13rrrDyA+l
         j52qxnUcIS1Rw==
Date:   Fri, 3 Aug 2018 19:29:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Aug 3
Message-ID: <20180803192942.6975df0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wbI1TyVLH_VwTNVay76aExr"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wbI1TyVLH_VwTNVay76aExr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180802:

The dma-mapping tree gained a conflict against the kbuild tree.

The mips tree gained a conflict against the kbuild tree.

The net-next tree gained a build failure so I used the version from
next-20180802.

The wireless-drivers-next tree gained a build failure for which I disabled
a driver.

The staging tree lost its build failure.

The scsi-mkp tree gained conflicts against Linus' tree.

The kspp tree gained a conflict against the kbuild tree.

The akpm-current tree gained a conflict against the kbuild tree.

Non-merge commits (relative to Linus' tree): 10654
 9890 files changed, 452696 insertions(+), 195442 deletions(-)

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
Merging origin/master (ef46808b79eb Merge tag 'pci-v4.18-fixes-5' of git://=
git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (9d3cce1e8b85 Linux 4.18-rc5)
Merging arc-current/for-curr (ec837d620c75 arc: fix type warnings in arc/mm=
/cache.c)
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
Merging net/master (afb41bb03965 drivers: net: lmc: fix case value for targ=
et abort error)
Merging bpf/master (2d55d614fcf5 net: xsk: don't return frames via the allo=
cator on error)
Merging ipsec/master (25432eba9cd8 openvswitch: meter: Fix setting meter id=
 for new entries)
Merging netfilter/master (101f0cd4f221 net: ena: Fix use of uninitialized D=
MA address bits field)
Merging ipvs/master (0026129c8629 rhashtable: add restart routine in rhasht=
able_free_and_destroy())
Merging wireless-drivers/master (299b6365a3b7 brcmfmac: fix regression in p=
arsing NVRAM for multiple devices)
Merging mac80211/master (e31f6456c01c cfg80211: never ignore user regulator=
y hint)
Merging rdma-fixes/for-rc (addb8a6559f0 RDMA/uverbs: Expand primary and alt=
 AV port checks)
Merging sound-current/for-linus (8e82a728792b ALSA: hda: Correct Asrock B85=
M-ITX power_save blacklist entry)
Merging sound-asoc-fixes/for-linus (44e3829ac016 Merge branch 'asoc-4.18' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (d72e90f33aa4 Linux 4.18-rc6)
Merging regulator-fixes/for-linus (61b0049c348c Merge branch 'regulator-4.1=
8' into regulator-linus)
Merging spi-fixes/for-linus (599bd83986be Merge branch 'spi-4.18' into spi-=
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
Merging vfs-fixes/fixes (9ba546c01976 aio: don't expose __aio_sigset in uap=
i)
Merging dma-mapping-fixes/for-linus (7ec916f82c48 Revert "iommu/intel-iommu=
: Enable CONFIG_DMA_DIRECT_OPS=3Dy and clean up intel_{alloc,free}_coherent=
()")
Merging drivers-x86-fixes/fixes (2502e5a02593 platform/x86: dell-laptop: Fi=
x backlight detection)
Merging samsung-krzk-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (ce397d215ccd Linux 4.18-rc1)
Merging devicetree-fixes/dt/linus (b9952b5218ad of: overlay: update phandle=
 cache on overlay apply and remove)
Merging scsi-fixes/fixes (1550ec458e0c scsi: fcoe: clear FC_RP_STARTED flag=
s when receiving a LOGO)
Merging drm-fixes/drm-fixes (51973dc079a9 Merge tag 'drm-misc-fixes-2018-07=
-27' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (0ca9488193e6 drm/i915/glk: Ad=
d Quirk for GLK NUC HDMI port issues.)
Merging mmc-fixes/fixes (3b1074bf9817 mmc: mxcmmc: Fix missing parentheses =
and brace)
Merging rtc-fixes/rtc-fixes (fd6792bb022e rtc: fix alarm read and set offse=
t)
Merging drm-misc-fixes/for-linux-next-fixes (a6a00918d4ad drm/vc4: Reset ->=
{x, y}_scaling[1] when dealing with uniplanar formats)
Merging kbuild/for-next (377659655faf Merge branch 'kconfig' into for-next)
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
Merging arm-soc/for-next (b81f6319ae82 ARM: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (3ff9606cd14c Merge branch 'v4.19/dt64' into tmp/a=
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
Merging rockchip/for-next (0b509c2e1f6c Merge branch 'v4.19-armsoc/dts64' i=
nto for-next)
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
Merging clk/clk-next (689a9554689f Merge branch 'clk-scmi-round' into clk-n=
ext)
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
Merging mips/mips-next (48ae93fdd133 MIPS: Delete unused code in linux32.c)
CONFLICT (content): Merge conflict in arch/mips/kernel/process.c
CONFLICT (content): Merge conflict in arch/mips/Kconfig
Merging nds32/next (d2516b16bcbc nds32: fix logic for module)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (0fbd47b92b06 parisc: Add HAVE_REGS_AND_STACK_AC=
CESS_API feature)
Merging powerpc/next (b87b9cf49353 powerpc/pseries: fix EEH recovery of som=
e IOV devices)
CONFLICT (content): Merge conflict in drivers/vfio/vfio_iommu_spapr_tce.c
CONFLICT (content): Merge conflict in arch/m68k/mac/misc.c
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (acb1872577b3 Linux 4.18-rc7)
Merging s390/features (fb7d7518b0d6 s390/numa: move initial setup of node_t=
o_cpumask_map)
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
Merging btrfs-kdave/for-next (1c286ffc9c85 Merge branch 'for-next-next-v4.1=
9-20180801' into for-next-20180801)
Merging ceph/master (e9da429f9976 ceph: change to void return type for __do=
_request())
Merging cifs/for-next (5450abd8e18d smb3: fix minor debug output for CONFIG=
_CIFS_STATS)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (6aee47d7f61e Pull in fsnotify cleanups from Amir and=
 new inotify IN_MASK_CREATE flag support.)
Merging ext4/dev (bc716523462f ext4: improve code readability in ext4_iget(=
))
Merging f2fs/dev (37b115a82fb6 f2fs: fix to avoid broken of dnode block lis=
t)
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
Merging v9fs/9p-next (76450279848d 9p: fix whitespace issues)
Merging xfs/for-next (e666aa37f433 xfs: avoid COW fork extent lookups in wr=
iteback if the fork didn't change)
Merging file-locks/locks-next (1cf8e5de4055 fs/lock: show locks taken by pr=
ocesses from another pidns)
Merging vfs/for-next (74411a34076b Merge branches 'work.dcache', 'work.moun=
t', 'work.misc' and 'work.mkdir' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (7973c51853f8 Merge branch 'for-4.19-nmi' into for-=
next)
Merging pci/next (a8de4147048a Merge branch 'remotes/lorenzo/pci/vmd')
CONFLICT (content): Merge conflict in drivers/pci/pci.h
CONFLICT (content): Merge conflict in drivers/pci/controller/pci-aardvark.c
Merging pstore/for-next/pstore (48ed452ca6ad pstore: add zstd compression s=
upport)
$ git reset --hard HEAD^
Merging next-20180802 version of pstore
Merging hid/for-next (872d1282470b Merge branch 'for-4.19/intel-ish' into f=
or-next)
Merging i2c/i2c/for-next (9bb27593878f Merge branch 'i2c/for-4.19' into i2c=
/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (12005ec33f3a hwmon: (iio_hwmon) Use devm =
functions)
Merging jc_docs/docs-next (0bf1bd84f365 Merge branch 'rppt' into docs-next)
CONFLICT (content): Merge conflict in Documentation/index.rst
Merging v4l-dvb/master (2c3449fb95c3 media: usb: hackrf: Replace GFP_ATOMIC=
 with GFP_KERNEL)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (044e7ca20496 fbdev: omap2: omapfb: fix ifnull=
free.cocci warnings)
Merging pm/linux-next (f5549675fa90 Merge branch 'pm-cpufreq-fixes' into li=
nux-next)
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
Merging rdma/for-next (26e551c5aec5 RDMA: Fix return code check in rdma_set=
_cq_moderation)
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
Merging net-next/master (6b431d50d2a8 net/socket: remove duplicated init co=
de)
CONFLICT (content): Merge conflict in tools/bpf/bpftool/map.c
CONFLICT (content): Merge conflict in net/smc/smc_ib.c
CONFLICT (content): Merge conflict in net/smc/smc_core.c
CONFLICT (content): Merge conflict in net/rds/ib_send.c
$ git reset --hard HEAD^
Merging next-20180802 version of net-next
CONFLICT (content): Merge conflict in tools/lib/bpf/btf.h
CONFLICT (content): Merge conflict in tools/lib/bpf/btf.c
CONFLICT (content): Merge conflict in tools/bpf/bpftool/map.c
CONFLICT (content): Merge conflict in net/smc/smc_ib.c
CONFLICT (content): Merge conflict in net/smc/smc_core.c
CONFLICT (content): Merge conflict in net/rds/ib_send.c
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
[master 9f4c2b1ceca8] next-20180802/net-next
Merging bpf-next/master (82c018d734a7 Merge branch 'bpf-cgroup-local-storag=
e')
Merging ipsec-next/master (ba7f4b3a3810 xfrm: Make function xfrmi_get_link_=
net() static)
Merging mlx5-next/mlx5-next (664000b6bb43 net/mlx5: Add support for flow ta=
ble destination number)
Merging netfilter-next/master (4ed8eb6570a4 netfilter: nf_tables: Add nativ=
e tproxy support)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (66c524acfb51 netfilter: conntrack: remove l3proto=
 abstraction)
CONFLICT (content): Merge conflict in net/netfilter/Makefile
CONFLICT (content): Merge conflict in net/netfilter/Kconfig
CONFLICT (content): Merge conflict in net/ipv6/netfilter/Kconfig
Merging wireless-drivers-next/master (28b918848390 qtnfmac: implement basic=
 WoWLAN support)
Merging bluetooth/master (7992c18810e5 Bluetooth: hidp: buffer overflow in =
hidp_process_report)
Merging mac80211-next/master (133bf90dbb8b mac80211: restrict delayed tailr=
oom needed decrement)
Merging gfs2/for-next (3f30f929bb17 gfs2: cleanup: call gfs2_rgrp_ondisk2lv=
b from gfs2_rgrp_out)
Merging mtd/mtd/next (76a832254ab0 mtd: partitions: use DT info for parsing=
 partitions with "compatible" prop)
Merging nand/nand/next (ed128e8b757b MAINTAINERS: drop Wenyou Yang from Atm=
el NAND driver support)
Merging spi-nor/spi-nor/next (bb276262e88d mtd: spi-nor: only apply reset h=
acks to broken hardware)
Merging crypto/master (a47890899379 crypto: rmd320 - use swap macro in rmd3=
20_transform)
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fs_ene=
t/mac-fec.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fec_ma=
in.c
Merging drm/drm-next (15da09500a70 Merge branch 'drm-armada-devel' of git:/=
/git.armlinux.org.uk/~rmk/linux-arm into drm-next)
Applying: drm/i915/kvmgt: merge fixup for "Check the pfn got from vfio_pin_=
pages"
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (12a6c931beff drm/i915/icl: avoid unclaime=
d PLANE_NV12_BUF_CFG register)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (2ead1be54b22 drm/vkms: Fix connector leak =
at the module removal)
Merging drm-msm/msm-next (3e91a8b5c158 drm/msm/disp/dpu: fix two spelling m=
istakes)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (e368fc75c190 drm/arm/malidp: Added th=
e late system pm functions)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (64f2cafc3da7 drm/imx: Convert drm_atomic_help=
er_suspend/resume())
Merging etnaviv/etnaviv/next (f6ffbd4fc1a1 drm/etnaviv: replace license tex=
t with SPDX tags)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (0bf0f09cc45b Merge branch 'regmap-4.19' into regma=
p-next)
Merging sound/for-next (789b7f43858f ALSA: sb: Fix a typo)
Merging sound-asoc/for-next (379197c3ac08 Merge branch 'asoc-4.19' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (6078091c9fa8 Input: evdev - switch to bitmap API)
Merging block/for-next (2d0873ea746a Merge branch 'for-4.19/block' into for=
-next)
CONFLICT (content): Merge conflict in drivers/nvme/target/rdma.c
Applying: nvme-dma: merge fix up for replacement of max_sge
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (cae8c38e727c dm cache metadata: save in-cor=
e policy_hint_size to on-disk superblock)
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
Merging regulator/for-next (03a05cf9d2cb Merge branch 'regulator-4.19' into=
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
Merging watchdog/master (81ceed41d0c2 watchdog: add driver for the MEN 16z0=
69 IP-Core)
Merging iommu/next (a6d297302f78 Merge branches 'arm/shmobile', 'arm/renesa=
s', 'arm/msm', 'arm/smmu', 'x86/amd', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (c1abca96b252 samples: mbochs: add DMA_SHARED_BUFFER depe=
ndency)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (baa2a4fdd525 audit: fix use-after-free in audit_add_wat=
ch)
Merging devicetree/for-next (791d3ef2e111 dt-bindings: remove 'interrupt-pa=
rent' from bindings)
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/net=
/can/xilinx_can.txt
Merging mailbox/mailbox-for-next (f83d1cfc8bcd mailbox/drivers/hisi: Consol=
idate the Kconfig for the MAILBOX)
Merging spi/for-next (efd740369fea Merge branch 'spi-4.19' into spi-next)
Merging tip/auto-latest (11719e9375aa Merge branch 'x86/urgent')
CONFLICT (content): Merge conflict in tools/include/uapi/linux/bpf.h
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (190bd6e98afc EDAC, sb_edac: Add support for syst=
ems with segmented PCI buses)
Merging irqchip/irq/irqchip-next (30800b3a1fb1 irqchip/gic-v3-its: Reduce m=
inimum LPI allocation to 1 for PCI devices)
Merging ftrace/for-next (a9235b544a0a ring-buffer: Fix typo in comment)
Merging rcu/rcu/next (d57fa29ddc3c Merge LKMM and RCU commits)
CONFLICT (content): Merge conflict in kernel/sched/core.c
Merging kvm/linux-next (85eae57bbb06 Merge tag 'kvm-s390-next-4.19-1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD)
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
Merging xen-tip/linux-next (2789e83c933d xen/gntdev: don't dereference a nu=
ll gntdev_dmabuf on allocation failure)
Applying: xen/gntdev: fix up for attach callback API change
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (66448bc274ca workqueue: move function definiti=
ons within CONFIG_SMP block)
Merging drivers-x86/for-next (5788f7795911 platform/x86: dell-laptop: Fix b=
acklight detection)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (ce397d215ccd Linux 4.18-rc1)
Merging leds/for-next (6f7b0bad8839 usb: simplify usbport trigger)
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
Merging char-misc/char-misc-next (f019f07ecf6a uio: potential double frees =
if __uio_register_device() fails)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging extcon/extcon-next (8a9dbb779fe8 extcon: Release locking when sendi=
ng the notification of connector state)
Merging staging/staging-next (156c3df8d4db staging: erofs: disable compilin=
g temporarile)
CONFLICT (modify/delete): drivers/staging/skein/skein_generic.c deleted in =
staging/staging-next and modified in HEAD. Version HEAD of drivers/staging/=
skein/skein_generic.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/iio=
/pressure/bmp085.txt
$ git rm -f drivers/staging/skein/skein_generic.c
Merging mux/for-next (335d610c667d Merge branch 'i2c-mux/for-next' into for=
-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging slave-dma/next (fe2309127e8c Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (103c7b7e0184 Merge branch 'misc' into for-next)
CONFLICT (modify/delete): lib/percpu_ida.c deleted in scsi/for-next and mod=
ified in HEAD. Version HEAD of lib/percpu_ida.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
$ git rm -f lib/percpu_ida.c
Merging scsi-mkp/for-next (dc0aa9925881 scsi: qla2xxx: Update driver versio=
n to 10.00.00.08-k)
CONFLICT (content): Merge conflict in drivers/scsi/qla2xxx/qla_init.c
CONFLICT (content): Merge conflict in drivers/scsi/qla2xxx/qla_gs.c
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (ac41b3f0cec0 Merge branch 'for-4.19' into for-next)
Applying: Revert "ata: ahci_platform: allow disabling of hotplug to save po=
wer"
Merging vhost/linux-next (89da619bc18d virtio_balloon: fix another race bet=
ween migration and ballooning)
Merging rpmsg/for-next (02c801b2fc28 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (b366a1e6d563 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (e10382e245d4 Merge branch 'devel' into for-next)
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
Merging kspp/for-next/kspp (163f88362143 Merge branch 'for-next/gcc-plugins=
' into for-next/kspp)
CONFLICT (content): Merge conflict in arch/Kconfig
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging xarray/xarray (f039e3979325 radix tree: Remove radix_tree_clear_tag=
s)
CONFLICT (content): Merge conflict in fs/dax.c
CONFLICT (content): Merge conflict in MAINTAINERS
Merging fsi/master (9840fcd8cc43 fsi: Prevent multiple concurrent rescans)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging ida/ida (d69dd7ae5cd8 ida: Convert to XArray)
Applying: mt76x0: mark MediaTek MT76x0U (USB) support broken for now
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
Merging akpm/master (4ebb9a303a4d drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/wbI1TyVLH_VwTNVay76aExr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltkIIYACgkQAVBC80lX
0Gyj1gf/TSgp5z4nrK5NDgZp4dHvr9qsXaP+kYJ71F45nBSHmm9KfSSjdCp4zAzC
9ZYZ2nuo9YuEzvuQ6lkZ/N/aDPNoVmfrTdkg6vqXP8NTiw0kuJWlN/TbUnXotsjf
nl4fZYx1507tSuT2YqSlW/mXRiYis2gkvllCcoDKuc2lFEmu3Ze3T1Evmcjlx28+
HQ8wCWVoFUYvr2dgYUGrW6yrqyFyQaXr6YDLKrgdGCr0DF/Yz+ozTLYsMcYWjpY4
7Sz1ZlYIAXhuFVJJKThLJ5yHd4TPKN23HrsTlOQjnW+UJxEqla0mOwG/F0WOSQe7
TeBrwB7+ToVV/pXOZF+tRd7SWt4wgQ==
=No+E
-----END PGP SIGNATURE-----

--Sig_/wbI1TyVLH_VwTNVay76aExr--
