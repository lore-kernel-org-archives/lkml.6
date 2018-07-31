Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1323DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503CC208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Mu45iYy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503CC208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeGaKCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:02:13 -0400
Received: from ozlabs.org ([203.11.71.1]:49653 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729598AbeGaKCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:02:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41fqF936W6z9rxx;
        Tue, 31 Jul 2018 18:22:53 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1533025373;
        bh=Lu7Uv1ttV79FYd26+qs7IfsUxbJD+W5gOHoIUCjRUcs=;
        h=Date:From:To:Cc:Subject:From;
        b=Mu45iYy56KNhBOF4Se4yhg7fwxQ2ab/teyjfvTSX8jXAZBGDnsOiytL5l8o55XoEG
         wtlTrY3Qvs6KaktyD+ME2Vocv4UlO7h3986zP3oxs41W4M2GeEl09HN9qv75LX/3Dv
         vkYurQSB+B2pOhAw/xBGvP280e++iHtll+8qJNqE9Ms8fs2lPRzIYMjx5M4woghz8K
         ObCvljTR1goL2XbfomBQHXkiSlaLYCaQCYxX38Pkgda7tCDGAdMvjOhznuHUahvX1c
         1+HQun/qVEliFE7OClDKYGB8ijKZgsrTnD2z7buiWLt4EhjqTPidGHWFT2Qv8/pycP
         3YA2UFVQH1Juw==
Date:   Tue, 31 Jul 2018 18:22:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 31
Message-ID: <20180731182252.17831c15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Nvb3whcRl1qZ82+3=ujsFJ6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Nvb3whcRl1qZ82+3=ujsFJ6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180730:

The block tree gained a build failure so I used the version from
next-20180730.

The kvms390 tree gained a conflict against the kvm-arm tree.

The staging tree still had its build failure due to an interaction with
the vfs tree for which I disabled CONFIG_EROFS_FS.

The mux tree gained a conflict against the battery tree.

The pinctrl tree gained a conflict the devicetree tree.

The kspp tree still had its build failure so I have added a supplied
patch.

Non-merge commits (relative to Linus' tree): 9850
 8993 files changed, 412971 insertions(+), 175848 deletions(-)

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
Merging origin/master (527838d470e3 Merge branch 'x86-urgent-for-linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (9d3cce1e8b85 Linux 4.18-rc5)
Merging arc-current/for-curr (ec837d620c75 arc: fix type warnings in arc/mm=
/cache.c)
Merging arm-current/fixes (afc9f65e01cd ARM: 8781/1: Fix Thumb-2 syscall re=
turn for binutils 2.29+)
Merging arm64-fixes/for-next/fixes (7b0eb6b41a08 arm64: fix vmemmap BUILD_B=
UG_ON() triggering on !vmemmap setups)
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (b03897cf318d powerpc/powernv: Fix save/restore=
 of SPRG3 on entry/exit from stop (idle))
Merging sparc/master (12be1036c536 sparc: use asm-generic version of msi.h)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (61f4b23769f0 netlink: Don't shift with UB on nlk->ngrou=
ps)
Merging bpf/master (71eb5255f55b bpf: use GFP_ATOMIC instead of GFP_KERNEL =
in bpf_parse_prog())
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
Merging sound-current/for-linus (f59cf9a0551d ALSA: hda - Sleep for 10ms af=
ter entering D3 on Conexant codecs)
Merging sound-asoc-fixes/for-linus (3e4b165997cb Merge branch 'asoc-4.18' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (d72e90f33aa4 Linux 4.18-rc6)
Merging regulator-fixes/for-linus (eafcd7ecbfd5 Merge branch 'regulator-4.1=
8' into regulator-linus)
Merging spi-fixes/for-linus (ead98d4ed923 Merge branch 'spi-4.18' into spi-=
linus)
Merging pci-current/for-linus (a54e43f993f8 PCI: mobiveil: Avoid integer ov=
erflow in IB_WIN_SIZE)
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
Merging drivers-x86-fixes/fixes (9d3cce1e8b85 Linux 4.18-rc5)
Merging samsung-krzk-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (ce397d215ccd Linux 4.18-rc1)
Merging devicetree-fixes/dt/linus (b9952b5218ad of: overlay: update phandle=
 cache on overlay apply and remove)
Merging scsi-fixes/fixes (b4146c4929ef scsi: qla2xxx: Return error when TMF=
 returns)
Merging drm-fixes/drm-fixes (acb1872577b3 Linux 4.18-rc7)
Merging drm-intel-fixes/for-linux-next-fixes (0ca9488193e6 drm/i915/glk: Ad=
d Quirk for GLK NUC HDMI port issues.)
Merging mmc-fixes/fixes (3b1074bf9817 mmc: mxcmmc: Fix missing parentheses =
and brace)
Merging rtc-fixes/rtc-fixes (fd6792bb022e rtc: fix alarm read and set offse=
t)
Merging drm-misc-fixes/for-linux-next-fixes (a6a00918d4ad drm/vc4: Reset ->=
{x, y}_scaling[1] when dealing with uniplanar formats)
Merging kbuild/for-next (b56884dbdd97 Merge branch 'kconfig' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (4d8bde883bfb OF: Don't set default coherent D=
MA mask)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (c705dcbf409c Merge branches 'clkdev', 'fixes', 'misc'=
 and 'spectre' into for-next)
Merging arm-perf/for-next/perf (809092dc3e60 drivers/perf: arm-ccn: Use dev=
m_ioremap_resource() to map memory)
Merging arm-soc/for-next (17f076bc11e5 ARM: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (47a99ae970bb Merge branch 'v4.19/dt64' into tmp/a=
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
Merging rockchip/for-next (ed8fcd5d1466 Merge branch 'v4.19-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (babb70ce9674 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (51c756fe7803 Merge branch 'sunxi/dt64-for-4.1=
9' into sunxi/for-next)
Merging tegra/for-next (f29cfb31cf00 Merge branch for-4.19/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (140aada48b5f arm64: kexec: machine_kexec shoul=
d call __flush_icache_range)
CONFLICT (content): Merge conflict in arch/arm64/Makefile
Merging clk/clk-next (bbfbe38ec527 Merge branch 'clk-mvebu-periph-parent' i=
nto clk-next)
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
Merging mips/mips-next (6386889ac23e MIPS: mscc: ocelot: add interrupt cont=
roller properties to GPIO controller)
CONFLICT (content): Merge conflict in arch/mips/kernel/process.c
Merging nds32/next (d2516b16bcbc nds32: fix logic for module)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (ae15a41a6414 openrisc: entry: Fix delay slot exc=
eption detection)
Merging parisc-hd/for-next (ce397d215ccd Linux 4.18-rc1)
Merging powerpc/next (cca3d5290ede tty: hvc: remove unexplained "just in ca=
se" spin delay)
CONFLICT (content): Merge conflict in drivers/vfio/vfio_iommu_spapr_tce.c
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (d72e90f33aa4 Linux 4.18-rc6)
Merging s390/features (6eedfaac712d s390: reenable gcc plugins)
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
Merging btrfs-kdave/for-next (2e68fcb12d4e Merge branch 'for-next-next-v4.1=
9-20180724' into for-next-20180724)
Merging ceph/master (8b8f53af1ed9 ceph: fix dentry leak in splice_dentry())
Merging cifs/for-next (24ca5dbe7fa6 smb3: remove per-session operations fro=
m per-tree connection stats)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (6aee47d7f61e Pull in fsnotify cleanups from Amir and=
 new inotify IN_MASK_CREATE flag support.)
Merging ext4/dev (f4a79b7b4ab5 ext4: fix warning message in ext4_enable_quo=
tas())
Merging f2fs/dev (715a33545d83 f2fs: fix to restrict mount condition when w=
ithout CONFIG_QUOTA)
Merging fuse/for-next (963545357202 fuse: reduce allocation size for splice=
_write)
Merging jfs/jfs-next (bd646104ac5a jfs: use time64_t for otime)
Merging nfs/linux-next (a61246c96195 Fix error code in nfs_lookup_verify_in=
ode())
Merging nfs-anna/linux-next (3b3cce6dad3e sunrpc: whitespace fixes)
Merging nfsd/nfsd-next (32620db998a5 NFSD stop ongoing async copies on clie=
nt shutdown)
Merging orangefs/for-next (f35cf2ab06b6 orangefs: remove redundant pointer =
orangefs_inode)
Merging overlayfs/overlayfs-next (989974c80457 ovl: Enable metadata only fe=
ature)
Merging ubifs/linux-next (f5a926dd5298 mtd: ubi: Update ubi-media.h to dual=
 license)
Merging v9fs/9p-next (76450279848d 9p: fix whitespace issues)
Merging xfs/for-next (51d626903083 xfs: introduce a new xfs_inode_has_cow_d=
ata helper)
Merging file-locks/locks-next (1cf8e5de4055 fs/lock: show locks taken by pr=
ocesses from another pidns)
Merging vfs/for-next (334990db5207 Merge branches 'work.dcache', 'work.moun=
t', 'work.misc' and 'work.mkdir' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (7973c51853f8 Merge branch 'for-4.19-nmi' into for-=
next)
Merging pci/next (d0fd59259b3a Merge branch 'remotes/lorenzo/pci/vmd')
CONFLICT (content): Merge conflict in drivers/pci/controller/pci-aardvark.c
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (4e9544262a93 Merge branch 'for-4.19/cougar' into for-=
next)
Merging i2c/i2c/for-next (c813df8f0069 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (12005ec33f3a hwmon: (iio_hwmon) Use devm =
functions)
Merging jc_docs/docs-next (d1634e1aedbc Documentation: vm.txt: Adding 'nr_h=
ugepages_mempolicy' parameter description.)
Merging v4l-dvb/master (1d06352e18ef media: tvp5150: add g_std callback)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (cb782a3fa952 udlfb: use spin_lock_irq instead=
 of spin_lock_irqsave)
Merging pm/linux-next (55bdd9a7225f Merge branch 'pm-cpufreq' into linux-ne=
xt)
Merging cpupower/cpupower (ce397d215ccd Linux 4.18-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (c5c2a97b3ac7 PM / OPP: Update voltage in case f=
req =3D=3D old_freq)
Merging thermal/next (54c5848c2149 Thermal: Intel SoC DTS: Translate IO-API=
C GSI number to linux irq number)
Merging thermal-soc/next (542cdf406804 thermal: rcar_thermal: avoid NULL de=
reference in absence of IRQ resources)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (7aaa1807e698 IB/cache: Restore compatibility for ib_=
query_gid)
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
Merging net-next/master (6ae746711263 hv_netvsc: Add per-cpu ethtool stats =
for netvsc)
CONFLICT (content): Merge conflict in tools/lib/bpf/btf.h
CONFLICT (content): Merge conflict in tools/lib/bpf/btf.c
CONFLICT (content): Merge conflict in net/smc/smc_ib.c
CONFLICT (content): Merge conflict in net/smc/smc_core.c
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging bpf-next/master (1ce6a9fc1549 bpf: fix build error in libbpf with E=
XTRA_CFLAGS=3D"-Wp, -D_FORTIFY_SOURCE=3D2 -O2")
Merging ipsec-next/master (3f6bcc5162a1 act_bpf: Use kmemdup instead of dup=
licating it in tcf_bpf_init_from_ops)
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
Merging wireless-drivers-next/master (d0db2f7a02e4 mt76x2: fix CCK protecti=
on control frame rate)
Merging bluetooth/master (b3cadaa485f0 Bluetooth: hidp: Fix handling of str=
ncpy for hid->name information)
Merging mac80211-next/master (133bf90dbb8b mac80211: restrict delayed tailr=
oom needed decrement)
Merging gfs2/for-next (3f30f929bb17 gfs2: cleanup: call gfs2_rgrp_ondisk2lv=
b from gfs2_rgrp_out)
Merging mtd/mtd/next (76a832254ab0 mtd: partitions: use DT info for parsing=
 partitions with "compatible" prop)
Merging nand/nand/next (237b81c9dc2d MAINTAINERS: drop Wenyou Yang from Atm=
el NAND driver support)
Merging spi-nor/spi-nor/next (69edac4ef4d1 mtd: spi-nor: cadence-quadspi: f=
ix timeout handling)
Merging crypto/master (a47890899379 crypto: rmd320 - use swap macro in rmd3=
20_transform)
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fs_ene=
t/mac-fec.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/freescale/fec_ma=
in.c
Merging drm/drm-next (3fce46182793 BackMerge v4.18-rc7 into drm-next)
Applying: drm/i915/kvmgt: merge fixup for "Check the pfn got from vfio_pin_=
pages"
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (3d94361aa13a drm/i915/gtt: remove px_page)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (2ead1be54b22 drm/vkms: Fix connector leak =
at the module removal)
Merging drm-msm/msm-next (a7663a793436 dt-bindings: msm/disp: Add bindings =
for Snapdragon 845 DPU)
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
Merging sound/for-next (89b4ab213feb ALSA: seq: virmidi: Use READ_ONCE/WRIT=
E_ONCE() macros)
Merging sound-asoc/for-next (3d59909f9cf5 Merge branch 'asoc-4.19' into aso=
c-next)
Merging modules/modules-next (4d58e7034d19 ARM: module: fix modsign build e=
rror)
Merging input/next (0b64fa0a0ee3 Input: iforce - reorganize joystick config=
uration lists)
Merging block/for-next (b41f308400b9 Merge branch 'for-4.19/block' into for=
-next)
CONFLICT (content): Merge conflict in drivers/nvme/target/rdma.c
Applying: nvme-dma: merge fix up for replacement of max_sge
$ git reset --hard HEAD^
Merging next-20180730 version of block
CONFLICT (content): Merge conflict in drivers/nvme/target/rdma.c
[master dd147ded4a77] next-20180730/block
Applying: nvme-dma: merge fix up for replacement of max_sge
[master c90b9040e003] next-20180730/block
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (63c8ecb6261a dm thin: include metadata_low_=
watermark threshold in pool status)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (fee1ab56663c mmc: tmio: remove unneeded variable in tmio_=
mmc_start_command())
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (08edaaa6d6fa drivers/md/raid5: Do not disable irq on r=
elease_inactive_stripe_list() call)
Merging mfd/for-mfd-next (fe8166c92a5f mfd: sec-core: Export OF module alia=
s table)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/Kconfig
Merging backlight/for-backlight-next (633786736ed5 backlight: pwm_bl: Fix u=
ninitialized variable)
Merging battery/for-next (3d779180c692 power: supply: bq27xxx: Update comme=
nts)
Merging regulator/for-next (e695e2b837d0 Merge branch 'regulator-4.19' into=
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
Merging watchdog/master (9d3cce1e8b85 Linux 4.18-rc5)
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
Merging spi/for-next (979356774789 Merge branch 'spi-4.19' into spi-next)
Merging tip/auto-latest (91a1c5a1b666 Merge branch 'x86/urgent')
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
Merging kvm/linux-next (6f0d349d922b Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/davem/net)
Merging kvm-arm/next (6b8b9a48545e KVM: arm/arm64: vgic: Fix possible spect=
re-v1 write in vgic_mmio_write_apr())
CONFLICT (content): Merge conflict in arch/arm64/include/asm/cpucaps.h
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (b5c6f7607b90 KVM: PPC: Book3S HV: Read kvm->a=
rch.emul_smt_mode under kvm->lock)
Merging kvms390/next (237584619366 Merge tag 'hlp_stage1' of git://git.kern=
el.org/pub/scm/linux/kernel/git/kvms390/linux into kvms390/next)
CONFLICT (content): Merge conflict in include/uapi/linux/kvm.h
Merging xen-tip/linux-next (47b428d14f06 xen/spinlock: Don't use pvqspinloc=
k if only 1 vCPU)
Applying: xen/gntdev: fix up for attach callback API change
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
Merging driver-core/driver-core-next (d2fc88a61b4e Merge 4.18-rc7 into driv=
er-core-next)
CONFLICT (content): Merge conflict in fs/sysfs/group.c
CONFLICT (content): Merge conflict in drivers/iommu/ipmmu-vmsa.c
Merging usb/usb-next (8a7b5d0f75f7 Merge 4.18-rc7 into usb-next)
Merging usb-gadget/next (4ea438da76f4 usb: dwc3: gadget: Check MaxPacketSiz=
e from descriptor)
Merging usb-serial/usb-next (c8acfe0aadbe USB: serial: cp210x: implement GP=
IO support for CP2102N)
Merging usb-chipidea-next/ci-for-usb-next (ba0ab35a81de usb: chipidea: tegr=
a: Use aligned DMA on Tegra114/124)
Merging phy-next/next (ec14b83a1ee4 phy: mvebu-cp110-comphy: switch to SPDX=
 identifier)
Merging tty/tty-next (286d9b8c7d2e serial: 8250: Use cached port name direc=
tly in messages)
Merging char-misc/char-misc-next (7ceb1c37533e Drivers: hv: vmbus: add numa=
_node to sysfs)
Merging extcon/extcon-next (8a9dbb779fe8 extcon: Release locking when sendi=
ng the notification of connector state)
Merging staging/staging-next (c7346797f5fb Revert "staging:r8188eu: Use lib=
80211 to encrypt (TKIP) tx frames")
CONFLICT (modify/delete): drivers/staging/skein/skein_generic.c deleted in =
staging/staging-next and modified in HEAD. Version HEAD of drivers/staging/=
skein/skein_generic.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
CONFLICT (content): Merge conflict in Documentation/devicetree/bindings/iio=
/pressure/bmp085.txt
$ git rm -f drivers/staging/skein/skein_generic.c
Applying: disable erofs for now
Merging mux/for-next (23f13d082c17 Merge branch 'i2c-mux/for-next' into for=
-next)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging slave-dma/next (fe2309127e8c Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (d92f5db64445 Merge branch 'misc' into for-next)
CONFLICT (modify/delete): lib/percpu_ida.c deleted in scsi/for-next and mod=
ified in HEAD. Version HEAD of lib/percpu_ida.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
$ git rm -f lib/percpu_ida.c
Merging scsi-mkp/for-next (c8a75afbf72e Revert "scsi: target/iscsi: Reduce =
number of __iscsit_free_cmd() callers")
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (ac41b3f0cec0 Merge branch 'for-4.19' into for-next)
Applying: Revert "ata: ahci_platform: allow disabling of hotplug to save po=
wer"
Merging vhost/linux-next (89da619bc18d virtio_balloon: fix another race bet=
ween migration and ballooning)
Merging rpmsg/for-next (44b7216cb394 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (aa3dc721a35a Merge branch 'devel' into for-next)
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
Merging random/dev (b34fbaa92893 random: remove preempt disabled region)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (d2d49495b5c0 selftests: vDSO - fix to return KSFT_S=
KIP when test couldn't be run)
Merging y2038/y2038 (e264abeaf9da pstore: Remove bogus format string defini=
tion)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (4395e2562f7b coresight: platform: Cleanup coresight=
 connection handling)
CONFLICT (content): Merge conflict in include/linux/coresight.h
Merging rtc/rtc-next (ec9cf1b7a6af rtc: pcf85063: preserve control register=
 value between stop and start)
Merging nvdimm/libnvdimm-for-next (0f2b7f29cf38 Merge branch 'for-4.19/dax-=
memory-failure' into libnvdimm-for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/mcheck/mce.c
Merging at24/at24/for-next (a2b3bf4846e5 eeprom: at24: Add support for addr=
ess-width property)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (34c837a11879 Merge branch 'for-next/gcc-plugins=
' into for-next/kspp)
Applying: efi/libstub: Only disable stackleak plugin for arm64
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging xarray/xarray (f039e3979325 radix tree: Remove radix_tree_clear_tag=
s)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging fsi/master (9840fcd8cc43 fsi: Prevent multiple concurrent rescans)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging ida/ida (d69dd7ae5cd8 ida: Convert to XArray)
Merging akpm-current/current (5149c8506d15 ipc/util.c: update return value =
of ipc_getref from int to bool)
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
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
Applying: drivers/gpu/drm/gma500/: change return type to vm_fault_t
Applying: treewide: convert ISO_8859-1 text comments to utf-8
Applying: s390: ebcdic: convert comments to UTF-8
Applying: lib/fonts: convert comments to utf-8
Applying: mm: Change return type int to vm_fault_t for fault handlers
Applying: mm-change-return-type-int-to-vm_fault_t-for-fault-handlers-fix
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (530a71985543 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/Nvb3whcRl1qZ82+3=ujsFJ6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltgHFwACgkQAVBC80lX
0GxCdggAiLOlzdlpOab8JKwTXwUdtQcFuYciRUpS6+efWx7KyLirZHkNTiI9db6l
ygEBn0IptCWx6bfvJV/8vVTdbAYJMtmo3XDLMG3fsgOWhAN/sqA5R+Ck3135+Ii7
CrUw5A17Z3hkDc+s6/iG0f2dj9KZucaJ1VOtBb1PgEz05FhOUxwXjGWilY766lsa
wbTTcBw73LjW+JXYzyLaZXSqowVQm+uKjYxVZFepaKnBxlLvcx/IB1LNhOcb7sN4
DZPSicrXDNuUkiBPv6OKUN7oGwVqqttZUt75e/3ObAab5ADbfAdUD+0hLMAo2S9L
+zyBgqoOVNJLihojwY4oZ2Vp0+TRMA==
=d60c
-----END PGP SIGNATURE-----

--Sig_/Nvb3whcRl1qZ82+3=ujsFJ6--
