Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ACBC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FBD2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 05:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VjupcR1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FBD2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbeIJJyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 05:54:12 -0400
Received: from ozlabs.org ([203.11.71.1]:44687 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726132AbeIJJyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 05:54:12 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 427wrQ39dHz9s3C;
        Mon, 10 Sep 2018 15:01:58 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536555718;
        bh=b0+aUFdv3ffc318keF3ldZAwS+AvhI+03/w2zuE6nRY=;
        h=Date:From:To:Cc:Subject:From;
        b=VjupcR1nrbv8kVP6X2PjAj4Qaqh+XofzcOYMzjgFIBQ80HSjRH1j55UdHGCBaroYv
         4OtBuDXlYClIGB+a3mH2ZEj1Xv5ITcJ1QcJ1QcuzXH0Bn20MLhs+lyted3pmi7zz7G
         WgGaazWliVqrnGGq59XEB0mkySkdSRwiYR1s7L8jDFu8sw4uWfwaNfIJ4jkqpVSvyW
         Gg14ComO4RabRkilNmteC9Q1Z43GgpR3JCfQB8wMvzI2fOmUxdOSh5kQSay8UItZCq
         vuZKzvSm686qMDKWzJGf71wKzecG2N/bUJTCBbfS6gGj2Qu83n6ps2JukOsuBx77CX
         WdoBXSHDx1Ysw==
Date:   Mon, 10 Sep 2018 15:01:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 10
Message-ID: <20180910150158.1707700a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CP2Dy31BrlEcqp9x1ymA9Uw"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CP2Dy31BrlEcqp9x1ymA9Uw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180907:

Dropped trees: xarray, ida (temporarily)

The vfs tree lost a build failure, but I have still disabled erofs.
It also gained other build failures for which I disabled building some
sampels and reverted a commit.

The net-next tree lost its build failure.

The bfp-next tree lost its build failure.

The akpm-current tree gained a conflict against the dma-mapping tree.

Non-merge commits (relative to Linus' tree): 2637
 2932 files changed, 91931 insertions(+), 59121 deletions(-)

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

I am currently merging 287 trees (counting Linus' and 66 trees of bug
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
Merging origin/master (9a5682765a2e Merge branch 'x86-urgent-for-linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/master (72358c0b59b7 linux-next: build warnings from the buil=
d of Linus' tree)
Merging kbuild-current/fixes (f0b0d88a8251 kbuild: modules_install: warn wh=
en missing System.map file)
Merging arc-current/for-curr (dd45210b6dd4 ARC: don't check for HIGHMEM pag=
es in arch_dma_alloc)
Merging arm-current/fixes (afc9f65e01cd ARM: 8781/1: Fix Thumb-2 syscall re=
turn for binutils 2.29+)
Merging arm64-fixes/for-next/fixes (fac880c7d074 arm64: fix erroneous warni=
ngs in page freeing functions)
Merging m68k-current/for-linus (0986b16ab49b m68k/mac: Use correct PMU resp=
onse format)
Merging powerpc-fixes/fixes (cca19f0b684f powerpc/64s/radix: Fix missing gl=
obal invalidations when removing copro)
Merging sparc/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (5d407b071dc3 ip: frags: fix crash in ip_do_fragment())
Merging bpf/master (28619527b8a7 Merge git://git.kernel.org/pub/scm/linux/k=
ernel/git/davem/net)
Merging ipsec/master (782710e333a5 xfrm: reset crypto_done when iterating o=
ver multiple input xfrms)
Merging netfilter/master (7acfda539c0b netfilter: nf_tables: release chain =
in flushing set)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (5b394b2ddf03 Linux 4.19-rc1)
Merging mac80211/master (6eae4a6c2be3 mac80211: fix pending queue hang due =
to TX_DROP)
Merging rdma-fixes/for-rc (8f28b178f71c RDMA/mlx4: Ensure that maximal send=
/receive SGE less than supported by HW)
Merging sound-current/for-linus (f7c50fa636f7 ALSA: hda: Fix several mismat=
ch for register mask and value)
Merging sound-asoc-fixes/for-linus (65ee95658ef9 Merge branch 'asoc-4.19' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (57361846b52b Linux 4.19-rc2)
Merging regulator-fixes/for-linus (25be6316a30a Merge branch 'regulator-4.1=
9' into regulator-linus)
Merging spi-fixes/for-linus (af37a01f9f7d Merge branch 'spi-4.19' into spi-=
linus)
Merging pci-current/for-linus (342227b42fe8 PCI: pciehp: Fix hot-add vs pow=
erfault detection order)
Merging driver-core.current/driver-core-linus (57361846b52b Linux 4.19-rc2)
Merging tty.current/tty-linus (57361846b52b Linux 4.19-rc2)
Merging usb.current/usb-linus (bfa150f37f80 Merge tag 'fixes-for-v4.19-rc2'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-linus)
Merging usb-gadget-fixes/fixes (d9707490077b usb: dwc2: Fix call location o=
f dwc2_check_core_endianness)
Merging usb-serial-fixes/usb-linus (5dfdd24eb3d3 USB: serial: ti_usb_3410_5=
052: fix array underflow in completion handler)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging staging.current/staging-linus (eca743dc37e1 Merge tag 'iio-fixes-4.=
19a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into stagin=
g-linus)
Merging char-misc.current/char-misc-linus (57361846b52b Linux 4.19-rc2)
Merging soundwire-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging input-current/for-linus (13fe7056bebb Merge branch 'next' into for-=
linus)
Merging crypto-current/master (3d7c82060d1f crypto: cavium/nitrox - fix for=
 command corruption in queue full case with backlog submissions.)
Merging ide/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (111b009f7e8b dmaengine: mic_x100_dma: use de=
vm_kzalloc to fix an issue)
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (336d139f8718 mtd: rawnand: denali: do not pass ze=
ro maxchips to nand_scan())
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (ce397d215ccd Linux 4.18-rc1)
Merging v4l-dvb-fixes/fixes (3799eca51c5b media: camss: add missing include=
s)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (0f02cfbc3d9e MIPS: VDSO: Match data page cac=
he colouring when D$ aliases)
Merging at91-fixes/at91-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging omap-fixes/fixes (c265c0ca76fb ARM: dts: logicpd-som-lv: Fix OMAP35=
/DM37 Compatibility issues)
Merging kvm-fixes/master (bdf7ffc89922 KVM: LAPIC: Fix pv ipis out-of-bound=
s access)
Merging kvms390-fixes/master (df88f3181f10 KVM: s390: Properly lock mm cont=
ext allow_gmap_hpage_1m setting)
Merging hwmon-fixes/hwmon (c793279c7703 hwmon: (nct6775) Fix access to fan =
pulse registers)
Merging nvdimm-fixes/libnvdimm-fixes (ee6581ceba7f nfit: fix unchecked dere=
ference in acpi_nfit_ctl)
Merging btrfs-fixes/next-fixes (784708458494 Merge branch 'for-next-current=
-v4.19-20180823' into next-fixes)
Merging vfs-fixes/fixes (4c0d7cd5c841 make sure that __dentry_kill() always=
 invalidates d_seq, unhashed or not)
Merging dma-mapping-fixes/for-linus (8c89ef7b6b64 of/platform: initialise A=
MBA default DMA masks)
Merging drivers-x86-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging samsung-krzk-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging devicetree-fixes/dt/linus (0413bedabc88 of: Add device_type access =
helper functions)
Merging scsi-fixes/fixes (c77a2fa3ff8f scsi: qedi: Add the CRC size within =
iSCSI NVM image)
Merging drm-fixes/drm-fixes (67c6ed7cf9eb Merge tag 'drm-intel-fixes-2018-0=
9-05' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (2b82435cb90b drm/i915/dp_mst:=
 Fix enabling pipe clock for all streams)
Merging mmc-fixes/fixes (c483a5cc9d09 mmc: meson-mx-sdio: fix OF child-node=
 lookup)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (12de17a0ceb6 drm/sun4i: Remove=
 R40 display pipeline compatibles)
Merging kbuild/for-next (f0b0d88a8251 kbuild: modules_install: warn when mi=
ssing System.map file)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (46053c736854 dma-mapping: clear dev->dma_ops =
in arch_teardown_dma_ops)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (6f6874f70c32 Merge branch 'clkdev' into for-next)
Merging arm-perf/for-next/perf (5b394b2ddf03 Linux 4.19-rc1)
Merging arm-soc/for-next (20856bad5e74 arm-soc: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (67290bfdeacf Merge branch 'v4.20/dt64' into tmp/a=
ml-rebuild)
Merging aspeed/for-next (c224edaa4a46 Merge branches 'defconfig-for-v4.19' =
and 'dt-for-v4.19' into for-next)
Merging at91/at91-next (373950d02422 Merge branch 'at91-defconfig' into at9=
1-next)
Merging bcm2835/for-next (ca5b45b7c5cd Merge branch 'bcm2835-defconfig-next=
' into for-next)
Merging imx-mxs/for-next (0b09a85314e7 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (b75253e66bc5 Merge branch 'v4.18-next/soc' into =
for-next)
Merging mvebu/for-next (23b7c60b80f6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (a04606e5f3a7 Merge branch 'omap-for-v4.20/dt' into f=
or-next)
Merging reset/reset/next (d903779b58be reset: meson: add meson audio arb dr=
iver)
Merging qcom/for-next (76b9e7f947f1 Merge tag 'qcom-defconfig-for-4.19' int=
o all-for-4.19)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (8177d85a70c2 Merge branches 'arm-defconfig-for-v4.20'=
, 'arm-dt-for-v4.20', 'arm-soc-for-v4.20', 'arm64-dt-for-v4.20', 'arm64-soc=
-for-v4.20', 'drivers-for-v4.20' and 'dt-bindings-for-v4.20' into next)
Merging rockchip/for-next (aed6b9a5edcc Merge branch 'v4.20-armsoc/dts32' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (45de718fb0dc Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (84344295689a Merge branches 'sunxi/clk-for-4.=
20', 'sunxi/config64-for-4.20' and 'sunxi/dt-for-4.20' into sunxi/for-next)
Merging tegra/for-next (72cb7a878f5b Merge branch for-4.20/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (cbbac1c3e6a8 Merge branch 'tlb/asm-generic' in=
to aarch64/for-next/core)
Merging clk/clk-next (7be9338d38a6 Merge branch 'clk-mvebu-periph-pm' into =
clk-next)
Merging clk-samsung/for-next (0e9c7c0700d2 clk: samsung: Remove obsolete co=
de for Exynos4412 ISP clocks)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (6abe58d985c4 m68k: fix early memory reservation=
 for ColdFire MMU systems)
Merging microblaze/next (c4347b05440f microblaze/PCI: Remove stale pcibios_=
align_resource() comment)
Merging mips/mips-next (0eb1cfffd543 MIPS: pci-rt2880: set pci controller o=
f_node)
Merging nds32/next (3350139c0ff3 nds32: linker script: GCOV kernel may refe=
rs data in __exit)
Merging nios2/for-next (c7c09dc187f0 nios2: kconfig: remove duplicate DEBUG=
_STACK_USAGE symbol defintions)
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (7efbe131b5b0 parisc: remove the dead ccio-rm-dm=
a driver)
Merging powerpc/next (0f52b3a00c78 powerpc/mce: Fix SLB rebolting during MC=
E recovery path.)
Merging hvc/topic/hvc (9f65b81f36e3 tty: hvc: introduce the hv_ops.flush op=
eration for hvc drivers)
Merging fsl/next (bd96461249bd powerpc/dts/fsl: t2080rdb: use the Cortina P=
HY driver compatible)
Merging risc-v/for-next (cdc7274029ca riscv: Do not overwrite initrd_start =
and initrd_end)
Merging s390/features (edf5f6ced531 s390/dasd: remove unnecessary condition=
 check)
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (d9cbd0e8f667 um: NULL check before kfree is not nee=
ded)
Merging xtensa/xtensa-for-next (6ffa1e97b3e7 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (ec8ec663cdde Merge branch 'for-next-next-v4.2=
0-20180907' into for-next-20180907)
Merging ceph/master (e92c0eaf7543 rbd: support cloning across namespaces)
Merging cifs/for-next (5890184d2b50 fs/cifs: require sha512)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (50559ae2e645 Pull UDF mount fixes.)
Merging ext4/dev (863c37fcb14f ext4: remove unneeded variable "err" in ext4=
_mb_release_inode_pa())
Merging f2fs/dev (6a61c3b5b8d4 f2fs: fix to flush all dirty inodes recovere=
d in readonly fs)
Merging fuse/for-next (30e0d0966c9c fuse: add support for copy_file_range())
Merging jfs/jfs-next (e8d4ceeb34a5 jfs: cache NULL when both default_acl an=
d acl are NULL)
Merging nfs/linux-next (b36fdc6853a3 Merge tag 'gpio-v4.19-2' of git://git.=
kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio)
Merging nfs-anna/linux-next (d34cea1f7fb8 NFS: Don't open code clearing of =
delegation state)
Merging nfsd/nfsd-next (108b833cde9c sunrpc: Add comment defining gssd upca=
ll API keywords)
Merging orangefs/for-next (a3bb1b184669 Orangefs: some error code paths mis=
sed kmem_cache_free to bad effect.)
Merging overlayfs/overlayfs-next (b833a3660394 ovl: add ovl_fadvise())
Merging ubifs/linux-next (6e5461d774bf ubifs: Remove empty file.h)
Merging v9fs/9p-next (b1c7aa81c9e6 9p: Rename req to rreq in trans_fd)
Merging xfs/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging file-locks/locks-next (10f3e23f07cb Merge tag 'ext4_for_linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4)
Merging vfs/for-next (dca83ec58c14 Merge branches 'work.mount', 'work.alpha=
' and 'work.compat' into for-next)
Applying: staging: erofs: disable compiling temporarile
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a4322becd21e Merge branch 'for-4.19-nmi' into for-=
next)
Merging pci/next (3ea7a150795e Merge branch 'pci/hotplug')
Merging pstore/for-next/pstore (57361846b52b Linux 4.19-rc2)
Merging hid/for-next (4c640c41381e Merge branch 'for-4.19/fixes' into for-n=
ext)
Merging i2c/i2c/for-next (fc9f90ddace2 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging dmi/master (72d7b946be6b ACPI / bus: Only call dmi_check_system on =
X86)
CONFLICT (content): Merge conflict in drivers/acpi/bus.c
Merging hwmon-staging/hwmon-next (f1090d66c004 hwmon: (nct6775) Clean up a =
condition)
Merging jc_docs/docs-next (a7ddcea58ae2 Drop all 00-INDEX files from Docume=
ntation/)
Merging v4l-dvb/master (d842a7cf938b media: adv7842: enable reduced fps det=
ection)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (f39684524b39 Documentation/fb: corrections fo=
r fbcon.txt)
Merging pm/linux-next (0ccfa3661a26 Merge branch 'acpi-soc' into linux-next)
Merging cpupower/cpupower (8a7e2d2ea080 cpupower: remove stringop-truncatio=
n waring)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (c5c2a97b3ac7 PM / OPP: Update voltage in case f=
req =3D=3D old_freq)
Merging thermal/next (d7a4303b8d1f dt-bindings: thermal: Allow multiple dev=
ices to share cooling map)
Merging thermal-soc/next (152395fd03d4 thermal: of-thermal: disable passive=
 polling when thermal zone is disabled)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (273993509f05 RDMA/core: Assign device ifindex before=
 publishing the device)
Merging net-next/master (09317da317e5 failover: Fix error return code in ne=
t_failover_create)
Merging bpf-next/master (f6f3bac08ff9 tools/bpf: bpftool: add net support)
Merging ipsec-next/master (4a132095dd64 xfrm: allow driver to quietly refus=
e offload)
Merging mlx5-next/mlx5-next (50acec06f392 net/mlx5: Export packet reformat =
alloc/dealloc functions)
Merging netfilter-next/master (802869f4e542 Merge branch 'ethernet-over-hdl=
c')
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (cf5652c962da orinoco_usb: fix spellin=
g mistake in fall-through annotation)
Merging bluetooth/master (08d70c106258 Bluetooth: hci_serdev: Add protocol =
check in hci_uart_dequeue().)
Merging mac80211-next/master (014f5a250fc4 cfg80211: validate wmm rule when=
 setting)
Merging gfs2/for-next (4f36cb36c9d1 gfs2: Don't set GFS2_RDF_UPTODATE when =
the lvb is updated)
Merging mtd/mtd/next (5b394b2ddf03 Linux 4.19-rc1)
Merging nand/nand/next (9b2c0b94ae32 mtd: rawnand: Do not treat !maxchips s=
pecially in nand_scan_with_ids())
Merging spi-nor/spi-nor/next (bb276262e88d mtd: spi-nor: only apply reset h=
acks to broken hardware)
Merging crypto/master (a1b22a5f45fe crypto: arm/chacha20 - faster 8-bit rot=
ations and other optimizations)
Merging drm/drm-next (1f3eb3461f58 Merge tag 'omapdrm-4.20' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/tomba/linux into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (2693efd99cad drm/i915/audio: Hook up comp=
onent bindings even if displays are disabled)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (72fdb40c1a4b drm: extract drm_atomic_uapi.=
c)
Merging drm-msm/msm-next (e17337cafcaf drm/msm/dpu: use encoder type to ide=
ntify display type)
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
Merging regmap/for-next (ef1b193e6032 Merge remote-tracking branch 'regmap/=
topic/single-rw' into regmap-next)
Merging sound/for-next (70f7922c25cf Merge branch 'topic/pcm-indirect-fixes=
' into for-next)
Merging sound-asoc/for-next (aee0d7223d77 Merge branch 'asoc-4.20' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (100294cee9a9 Input: do not use WARN() in input_alloc_ab=
sinfo())
Merging block/for-next (1d4338dfb965 Merge branch 'for-4.20/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (5380c05b6829 dm raid: bump target version, =
update comments and documentation)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (6d2beaffc5b7 mmc: sunxi: Use new timing mode for A64 eMMC=
 controller)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (9a255eeb01dd raid5: block failing device if raid will =
be failed)
Merging mfd/for-mfd-next (d2c9281c184b mfd: madera: Add register definition=
s for accessory detect)
Merging backlight/for-backlight-next (633786736ed5 backlight: pwm_bl: Fix u=
ninitialized variable)
Merging battery/for-next (231d259f547c power: bq25890_charger.c: Read back =
the current battery voltage)
Merging regulator/for-next (3919d74e3052 Merge branch 'regulator-4.20' into=
 regulator-next)
Merging security/next-testing (72934a2c220f Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (5f997580e8b1 apparmor: Fix network performa=
nce issue in aa_label_sk_perm)
Merging integrity/next-integrity (3dd0f18c70d9 EVM: fix return value check =
in evm_write_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (95ffe194204a selinux: refactor mls_context_to_sid() a=
nd make it stricter)
Merging tpmdd/next (ec403d8ed08c ima: Get rid of ima_used_chip and use ima_=
tpm_chip !=3D NULL instead)
Merging watchdog/master (60c1f89241d4 Merge tag 'dma-mapping-4.19-2' of git=
://git.infradead.org/users/hch/dma-mapping)
Merging iommu/next (6488a7f35eea Merge branches 'arm/shmobile', 'arm/renesa=
s', 'arm/msm', 'arm/smmu', 'arm/omap', 'x86/amd', 'x86/vt-d' and 'core' int=
o next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0dd0e297f0ec vfio-pci: Disable binding to PFs with SR-IO=
V enabled)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (baa2a4fdd525 audit: fix use-after-free in audit_add_wat=
ch)
Merging devicetree/for-next (00b7d1cf4667 of: make default address and size=
 cells sizes private)
Merging mailbox/mailbox-for-next (2bb7005696e2 mailbox: Add support for i.M=
X messaging unit)
Merging spi/for-next (be59b1f1e875 Merge branch 'spi-4.20' into spi-next)
Merging tip/auto-latest (bc6b057ced4f Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (bd1852317ffe EDAC: Get rid of custom ICPU() macr=
o)
Merging irqchip/irq/irqchip-next (4110b5cbb014 irqchip/gic-v3: Allow interr=
upt to be configured as wake-up sources)
Merging ftrace/for-next (bb730b5833b5 tracing: Fix SPDX format headers to u=
se C++ style comments)
Merging rcu/rcu/next (c3570417c680 rcutorture: Add cross-compile capability=
 to initrd.sh)
Merging kvm/linux-next (5b394b2ddf03 Linux 4.19-rc1)
Merging kvm-arm/next (976d34e2dab1 KVM: arm/arm64: Skip updating PTE entry =
if no change)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (46dec40fb741 KVM: PPC: Book3S HV: Don't trunc=
ate HPTE index in xlate function)
Merging kvms390/next (d18f2b18628d KVM: s390: set host program identifier)
Merging xen-tip/linux-next (d3bfd26508ba xen/manage: don't complain about a=
n empty value in control/sysrq node)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (9aec30371fb0 leds: pwm: silently error out on EPROBE=
_DEFER)
Merging ipmi/for-next (bc221b0f7ee3 ipmi: Remove platform driver overrides =
and use the id_table)
Merging driver-core/driver-core-next (57361846b52b Linux 4.19-rc2)
Merging usb/usb-next (57361846b52b Linux 4.19-rc2)
Merging usb-gadget/next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-serial/usb-next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-chipidea-next/ci-for-usb-next (35a334659bcc usb: chipidea: imx:=
 make MODULE_LICENCE and SPDX-identifier match)
Merging phy-next/next (c8d6ebb4abdb phy:phy-lantiq-rcu-usb2: Use PTR_ERR_OR=
_ZERO to replace the open coded version)
Merging tty/tty-next (57361846b52b Linux 4.19-rc2)
Merging char-misc/char-misc-next (57361846b52b Linux 4.19-rc2)
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (14b0c44af4e9 soundwire: intel: Remove duplicate ass=
ignment)
Merging staging/staging-next (3e195a80e096 Staging: octeon-usb: Replaces CV=
MX_WAIT_FOR_FIELD32 macro with a function)
Merging mux/for-next (2c01260df661 mux: add mux_control_get_optional() API)
Merging icc/icc-next (3d46fda12a9d MAINTAINERS: add a maintainer for the in=
terconnect API)
Merging slave-dma/next (c1b85e08ee85 Merge branch 'topic/sprd' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (72086f91011d Merge branch 'fixes' into for-next)
Merging scsi-mkp/for-next (cca6cb8ad7a8 scsi: aic7xxx: Fix build using bare=
-metal toolchain)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (1e05b62ae4bd sh: use the the PCI channels's io_ma=
p_base)
Merging rpmsg/for-next (0205748ea669 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (d5e04cc86231 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (1ab75c1a1deb Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging pwm/for-next (8cdc43afbb2c pwm: mediatek: Add MT7628 support)
Merging userns/for-next (82c9a927bc5d getxattr: use correct xattr length)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9b25436662d5 random: make CPU trust a boot parameter)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (a987785dcd6c Add tests for memory.oom.group)
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (681df3b41937 coresight: etm4x: Configure EL2 except=
ion level when kernel is running in HYP)
Merging rtc/rtc-next (05a0a3441869 rtc: mips: default to rtc-cmos on mips)
Merging nvdimm/libnvdimm-for-next (be5ba2ca053d dax: Fix use of zero page)
Merging at24/at24/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (6fcde9046673 arm64: Drop unneeded stackleak_che=
ck_alloca())
CONFLICT (content): Merge conflict in drivers/misc/lkdtm/core.c
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging fsi/master (15e2a7218c27 fsi: sbefifo: Bump max command length)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Applying: disable building the VFS sample programs
Applying: Revert "compat_ioctl: trim the pointless includes"
Merging akpm-current/current (776a52a8bcdb bfs: add sanity check at bfs_fil=
l_super())
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in arch/hexagon/Kconfig
$ git checkout -b akpm remotes/origin/akpm/master
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (133281bcf07b drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/CP2Dy31BrlEcqp9x1ymA9Uw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluV+sYACgkQAVBC80lX
0GwoPgf8C/XXcYF4YrQZ4V9subbNNqJq8qKjCnZVEsIn12xug3URbo/yeHwZ4VHj
ph6laQL4boHv1UbdtMRDSZWIV47FubyMMNJkxhSzTyw8O2UrN4clrht/wtEYM0HF
TjCwmTpa+/EVzk6//hBmTqojaNsflitZglO1lxsE+Blo+FRAIVzQwz5P6Nq7wt65
hQRccCApA/4XW41NweygHMSPiba2BbJDOijEUFOaikKtf/xNeBA22mWKwTAafi2G
qWkoIkDQb4WDLwOd+X2ZkxKkaYxCPdk7EdFIrsdNRWWua1Jh8oZIEP4D57KucFY7
dJj5FvE2A30GRtGsl+k07vihnnRtFQ==
=/7Sk
-----END PGP SIGNATURE-----

--Sig_/CP2Dy31BrlEcqp9x1ymA9Uw--
