Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A402C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1E020652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="JFbWJ5K5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A1E020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeICHP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:15:29 -0400
Received: from ozlabs.org ([203.11.71.1]:37309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeICHP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:15:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 423ZPr5hrBz9ryn;
        Mon,  3 Sep 2018 12:57:20 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1535943440;
        bh=fCx0A6ZcTN7MT66bJXxm3RiJd041IvYcwW4O6sN70bY=;
        h=Date:From:To:Cc:Subject:From;
        b=JFbWJ5K5mD6Ihm+46HxvtagSrfjyN3L9/I0TTGLNmJ//0GfG43aW6ttmy6Zkqyr52
         wfg8sI91mMc+JYyYW2lDBYwvyL79dNL6ymgJjZ+XZEmWv9oaBjynx5i7TI0jIMPioz
         HgFThO0uWuySFoIYEOToFcKkkVvFAtB+HLMw8xULKdDkcDlGeSo3quZ9uj2//3ALcA
         1qizAA+Pmdbt2WR/MnilXGhtPZEhCZXbOR20oTMjtp1vCyUj1jmBO/zKVCvl1R60gY
         KLxTE4ILhxshfG24kC+vI/QVlyoEAI0BDRD80MhYTkKvl9dCX4qEdVGwH9WOejMUbQ
         cI1lNRUgS8d/Q==
Date:   Mon, 3 Sep 2018 12:57:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 3
Message-ID: <20180903125712.0461baac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/u4a13F.cqdxxB0Q1Mwi+qq+"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u4a13F.cqdxxB0Q1Mwi+qq+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180831:

Dropped trees: xarray, ida (temporarily)

The net-next tree gained a build failure for which I reverted a commit.

Non-merge commits (relative to Linus' tree): 1489
 1812 files changed, 56535 insertions(+), 18845 deletions(-)

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

I am currently merging 286 trees (counting Linus' and 66 trees of bug
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
Merging origin/master (57361846b52b Linux 4.19-rc2)
Merging fixes/master (217c3e019675 disable stringop truncation warnings for=
 now)
Merging kbuild-current/fixes (914b087ff9e0 kbuild: make missing $DEPMOD a W=
arning instead of an Error)
Merging arc-current/for-curr (3fcbb8260a87 ARC: atomics: unbork atomic_fetc=
h_##op())
Merging arm-current/fixes (afc9f65e01cd ARM: 8781/1: Fix Thumb-2 syscall re=
turn for binutils 2.29+)
Merging arm64-fixes/for-next/fixes (f52bb98f5ade arm64: mm: always enable C=
ONFIG_HOLES_IN_ZONE)
Merging m68k-current/for-linus (0986b16ab49b m68k/mac: Use correct PMU resp=
onse format)
Merging powerpc-fixes/fixes (cca19f0b684f powerpc/64s/radix: Fix missing gl=
obal invalidations when removing copro)
Merging sparc/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (15a81b418e22 net/ipv6: Only update MTU metric if it set)
Merging bpf/master (597222f72a94 bpf: avoid misuse of psock when TCP_ULP_BP=
F collides with another ULP)
Merging ipsec/master (25432eba9cd8 openvswitch: meter: Fix setting meter id=
 for new entries)
Merging netfilter/master (7acfda539c0b netfilter: nf_tables: release chain =
in flushing set)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (53ae914d898e net/rds: Use rdma_read_gids t=
o get connection SGID/DGID in IPv6)
Merging mac80211/master (aa58acf325b4 mac80211: always account for A-MSDU h=
eader changes)
Merging rdma-fixes/for-rc (5b394b2ddf03 Linux 4.19-rc1)
Merging sound-current/for-linus (16037643969e ALSA: hda - Fix cancel_work_s=
ync() stall from jackpoll work)
Merging sound-asoc-fixes/for-linus (f26f753fa175 Merge branch 'asoc-4.19' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging regulator-fixes/for-linus (ef394f3fbecb regulator: da9063: fix DT p=
robing with constraints)
Merging spi-fixes/for-linus (8e9f6c9dd001 Merge branch 'spi-4.19' into spi-=
linus)
Merging pci-current/for-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging driver-core.current/driver-core-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging tty.current/tty-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging usb.current/usb-linus (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-gadget-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-serial-fixes/usb-linus (5dfdd24eb3d3 USB: serial: ti_usb_3410_5=
052: fix array underflow in completion handler)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (ad5003300b07 phy: mapphone-mdm6600: Fix wrong enum used =
for status lines)
Merging staging.current/staging-linus (f86cf25a6091 Revert "staging: erofs:=
 disable compiling temporarile")
Merging char-misc.current/char-misc-linus (5b394b2ddf03 Linux 4.19-rc1)
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
Merging omap-fixes/fixes (2d59bb602314 ARM: dts: omap4-droid4: Fix emmc err=
ors seen on some devices)
Merging kvm-fixes/master (5b394b2ddf03 Linux 4.19-rc1)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (d49dbfade96d hwmon: (nct6775) Fix potential Spec=
tre v1)
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
Merging drm-fixes/drm-fixes (49a51c4b4064 Merge tag 'drm-intel-fixes-2018-0=
8-29' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (80ab316901bc drm/i915/audio: =
Hook up component bindings even if displays are disabled)
Merging mmc-fixes/fixes (d2332f887ddf mmc: renesas_sdhi_internal_dmac: mask=
 DMAC interrupts)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (12de17a0ceb6 drm/sun4i: Remove=
 R40 display pipeline compatibles)
Merging kbuild/for-next (914b087ff9e0 kbuild: make missing $DEPMOD a Warnin=
g instead of an Error)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (6fa1d28e38cf sh: use generic dma_noncoherent_=
ops)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (6f6874f70c32 Merge branch 'clkdev' into for-next)
Merging arm-perf/for-next/perf (5b394b2ddf03 Linux 4.19-rc1)
Merging arm-soc/for-next (16f739917dc7 Merge branch 'fixes' into for-next)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (aba1d0325bc2 ARM: dts: meson8b: fix the clock con=
troller register size)
Merging aspeed/for-next (c224edaa4a46 Merge branches 'defconfig-for-v4.19' =
and 'dt-for-v4.19' into for-next)
Merging at91/at91-next (3760871946ca Merge branch 'at91-defconfig' into at9=
1-next)
Merging bcm2835/for-next (f615939e77c8 Merge branch 'bcm2835-dt-64-next' in=
to for-next)
Merging imx-mxs/for-next (abadb73b9b3b Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (b75253e66bc5 Merge branch 'v4.18-next/soc' into =
for-next)
Merging mvebu/for-next (23b7c60b80f6 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging reset/reset/next (d903779b58be reset: meson: add meson audio arb dr=
iver)
Merging qcom/for-next (76b9e7f947f1 Merge tag 'qcom-defconfig-for-4.19' int=
o all-for-4.19)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (7bcab9a6530a Merge branches 'arm-defconfig-for-v4.20'=
, 'arm-soc-for-v4.20', 'arm64-dt-for-v4.20', 'arm64-soc-for-v4.20', 'driver=
s-for-v4.20' and 'dt-bindings-for-v4.20' into next)
Merging rockchip/for-next (fcabb76ac322 Merge branch 'v4.20-clk/next' into =
for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (9ca03e735017 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (bb107114d290 Merge branches 'sunxi/h3-h5-for-=
4.20' and 'sunxi/dt64-for-4.20' into sunxi/for-next)
Merging tegra/for-next (72cb7a878f5b Merge branch for-4.20/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (3c4d9137eefe arm64: alternative: Use true and =
false for boolean values)
Merging clk/clk-next (7be9338d38a6 Merge branch 'clk-mvebu-periph-pm' into =
clk-next)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (08df5c54356b m68k: fix early memory reservation=
 for ColdFire MMU systems)
Merging microblaze/next (c4347b05440f microblaze/PCI: Remove stale pcibios_=
align_resource() comment)
Merging mips/mips-next (52c985acf3fe MIPS: Move arch_mem_init() comment nea=
r definition)
Merging nds32/next (a5fe7c46e245 nds32: fix build error because of wrong se=
micolon)
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
Merging risc-v/for-next (2421a97a0fc5 riscv: Do not overwrite initrd_start =
and initrd_end)
Merging s390/features (4658aff6eeaa Merge tag 'drm-fixes-2018-08-31' of git=
://anongit.freedesktop.org/drm/drm)
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (d9cbd0e8f667 um: NULL check before kfree is not nee=
ded)
Merging xtensa/xtensa-for-next (7bc8c12abba0 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (1e5f18740238 Merge branch 'for-next-current-v=
4.19-20180817' into for-next-20180817)
Merging ceph/master (ed72a66f8ee2 ceph: avoid a use-after-free in ceph_dest=
roy_options())
Merging cifs/for-next (ab5deb20ecaa cifs: connect to servername instead of =
IP for IPC$ share)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (ee4af50ca94f udf: Fix mounting of Win7 created UDF f=
ilesystems)
Merging ext4/dev (863c37fcb14f ext4: remove unneeded variable "err" in ext4=
_mb_release_inode_pa())
Merging f2fs/dev (3f16503b7d22 Merge branch 'fixes' of git://git.kernel.org=
/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal)
Merging fuse/for-next (963545357202 fuse: reduce allocation size for splice=
_write)
Merging jfs/jfs-next (bd646104ac5a jfs: use time64_t for otime)
Merging nfs/linux-next (94710cac0ef4 Linux 4.18)
Merging nfs-anna/linux-next (0af4c8be97a1 pNFS: Remove unwanted optimisatio=
n of layoutget)
Merging nfsd/nfsd-next (108b833cde9c sunrpc: Add comment defining gssd upca=
ll API keywords)
Merging orangefs/for-next (e1b437691a62 orangefs: remove redundant pointer =
orangefs_inode)
Merging overlayfs/overlayfs-next (9882b83f4373 ovl: add ovl_fadvise())
Merging ubifs/linux-next (6e5461d774bf ubifs: Remove empty file.h)
Merging v9fs/9p-next (62e3941776fe 9p: clear dangling pointers in p9stat_fr=
ee)
Merging xfs/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging file-locks/locks-next (10f3e23f07cb Merge tag 'ext4_for_linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4)
Merging vfs/for-next (851ac0e8b7d6 Merge branch 'work.mount' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Applying: vfs: samples: fix up for HOSTLOADLIBES rename
Applying: staging: erofs: disable compiling temporarile
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a4322becd21e Merge branch 'for-4.19-nmi' into for-=
next)
Merging pci/next (5b394b2ddf03 Linux 4.19-rc1)
Merging pstore/for-next/pstore (1021bcf44d0e pstore: add zstd compression s=
upport)
Merging hid/for-next (bdcc7211aaa0 Merge branch 'for-4.19/fixes' into for-n=
ext)
Merging i2c/i2c/for-next (34b7be301d4c Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (62f5146e137b hwmon: (ibmpowernv) drop unn=
ecessary OF name NULL checks)
Merging jc_docs/docs-next (9eff4a2e92a2 docs: dev-tools: coccinelle: Update=
 documentation)
Merging v4l-dvb/master (d842a7cf938b media: adv7842: enable reduced fps det=
ection)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (f39684524b39 Documentation/fb: corrections fo=
r fbcon.txt)
Merging pm/linux-next (501b192d0299 Merge branches 'pm-cpuidle' and 'pm-cor=
e' into linux-next)
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
Merging rdma/for-next (030e46e495af IB/rxe: fixes for rdma read retry)
Merging net-next/master (743e481580b4 tcp: remove useless add operation whe=
n init sysctl_max_tw_buckets)
Applying: Revert "i40e: move ethtool stats boiler plate code to i40e_ethtoo=
l_stats.h"
Merging bpf-next/master (2d5c28859839 net: bgmac: remove set but not used v=
ariable 'err')
Merging ipsec-next/master (4a132095dd64 xfrm: allow driver to quietly refus=
e offload)
Merging mlx5-next/mlx5-next (664000b6bb43 net/mlx5: Add support for flow ta=
ble destination number)
Merging netfilter-next/master (f0259b6ac4a3 Merge tag 'mac80211-next-for-da=
vem-2018-08-29' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac8=
0211-next)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (ac5d5b3f199e mt76: verify evt type in=
 usb mcu response)
Merging bluetooth/master (bb010103671c Bluetooth: hci_serdev: Add protocol =
check in hci_uart_dequeue().)
Merging mac80211-next/master (9c06602b1b92 cfg80211: clarify frames covered=
 by average ACK signal report)
Merging gfs2/for-next (4f36cb36c9d1 gfs2: Don't set GFS2_RDF_UPTODATE when =
the lvb is updated)
Merging mtd/mtd/next (5b394b2ddf03 Linux 4.19-rc1)
Merging nand/nand/next (ed128e8b757b MAINTAINERS: drop Wenyou Yang from Atm=
el NAND driver support)
Merging spi-nor/spi-nor/next (bb276262e88d mtd: spi-nor: only apply reset h=
acks to broken hardware)
Merging crypto/master (22240df7ac6d crypto: arm64/ghash-ce - implement 4-wa=
y aggregation)
Merging drm/drm-next (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (2693efd99cad drm/i915/audio: Hook up comp=
onent bindings even if displays are disabled)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (b972cece9448 drm: Describe pixel_blend_mod=
e in drm_plane_state)
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
Merging regmap/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging sound/for-next (56e91b126886 Merge tag 'hda-codec-h-move' of git://=
git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-next)
Merging sound-asoc/for-next (53e5561d699c Merge branch 'asoc-4.20' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (100294cee9a9 Input: do not use WARN() in input_alloc_ab=
sinfo())
Merging block/for-next (63793d9a535b Merge branch 'for-4.20/libata' into fo=
r-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (43323993e68a dm verity: fix crash on bufio =
buffer that was allocated with vmalloc)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (495466714970 mmc: tegra: Enable UHS and HS200 modes for T=
egra186)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (41a950411265 md-cluster: release RESYNC lock after the=
 last resync message)
Merging mfd/for-mfd-next (d2c9281c184b mfd: madera: Add register definition=
s for accessory detect)
Merging backlight/for-backlight-next (633786736ed5 backlight: pwm_bl: Fix u=
ninitialized variable)
Merging battery/for-next (231d259f547c power: bq25890_charger.c: Read back =
the current battery voltage)
Merging regulator/for-next (0f6c50c90aaf Merge branch 'regulator-4.20' into=
 regulator-next)
Merging security/next-testing (d83c732fffc3 Merge branch 'smack-for-4.19-a'=
 of https://github.com/cschaufler/next-smack into next-testing)
Merging apparmor/apparmor-next (c037bd615885 apparmor: remove no-op permiss=
ion check in policy_unpack)
Merging integrity/next-integrity (3dd0f18c70d9 EVM: fix return value check =
in evm_write_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (7e4237faa721 selinux: cleanup dentry and inodes on er=
ror in selinuxfs)
Merging tpmdd/next (ec403d8ed08c ima: Get rid of ima_used_chip and use ima_=
tpm_chip !=3D NULL instead)
Merging watchdog/master (74081c9f16a2 dt-bindings: watchdog: renesas-wdt: D=
ocument r8a774a1 support)
Merging iommu/next (6488a7f35eea Merge branches 'arm/shmobile', 'arm/renesa=
s', 'arm/msm', 'arm/smmu', 'arm/omap', 'x86/amd', 'x86/vt-d' and 'core' int=
o next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0dd0e297f0ec vfio-pci: Disable binding to PFs with SR-IO=
V enabled)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (baa2a4fdd525 audit: fix use-after-free in audit_add_wat=
ch)
Merging devicetree/for-next (32c7ed751e21 of: make PowerMac cache node sear=
ch conditional on CONFIG_PPC_PMAC)
Merging mailbox/mailbox-for-next (2bb7005696e2 mailbox: Add support for i.M=
X messaging unit)
Merging spi/for-next (f5b7ec0866bf Merge branch 'spi-4.20' into spi-next)
Merging tip/auto-latest (a3866dde4d78 Merge branch 'x86/urgent' into auto-l=
atest)
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (8960de4a5ca7 EDAC, amd64: Add Family 17h, models=
 10h-2fh support)
Merging irqchip/irq/irqchip-next (4110b5cbb014 irqchip/gic-v3: Allow interr=
upt to be configured as wake-up sources)
Merging ftrace/for-next (bb730b5833b5 tracing: Fix SPDX format headers to u=
se C++ style comments)
Merging rcu/rcu/next (d57fa29ddc3c Merge LKMM and RCU commits)
Merging kvm/linux-next (5b394b2ddf03 Linux 4.19-rc1)
Merging kvm-arm/next (976d34e2dab1 KVM: arm/arm64: Skip updating PTE entry =
if no change)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (46dec40fb741 KVM: PPC: Book3S HV: Don't trunc=
ate HPTE index in xlate function)
Merging kvms390/next (237584619366 Merge tag 'hlp_stage1' of git://git.kern=
el.org/pub/scm/linux/kernel/git/kvms390/linux into kvms390/next)
Merging xen-tip/linux-next (6d3c8ce012ce x86/xen: remove redundant variable=
 save_pud)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (f813eec972ee leds: Convert to using %pOFn instead of=
 device_node.name)
Merging ipmi/for-next (bc221b0f7ee3 ipmi: Remove platform driver overrides =
and use the id_table)
Merging driver-core/driver-core-next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb/usb-next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-gadget/next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-serial/usb-next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-chipidea-next/ci-for-usb-next (ba0ab35a81de usb: chipidea: tegr=
a: Use aligned DMA on Tegra114/124)
Merging phy-next/next (ec14b83a1ee4 phy: mvebu-cp110-comphy: switch to SPDX=
 identifier)
Merging tty/tty-next (5b394b2ddf03 Linux 4.19-rc1)
Merging char-misc/char-misc-next (5b394b2ddf03 Linux 4.19-rc1)
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (14b0c44af4e9 soundwire: intel: Remove duplicate ass=
ignment)
Merging staging/staging-next (3e195a80e096 Staging: octeon-usb: Replaces CV=
MX_WAIT_FOR_FIELD32 macro with a function)
Merging mux/for-next (2c01260df661 mux: add mux_control_get_optional() API)
Merging slave-dma/next (f9916dc9104d Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (714d7fe777fc Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/qla2xxx/qla_init.c
Merging scsi-mkp/for-next (cca6cb8ad7a8 scsi: aic7xxx: Fix build using bare=
-metal toolchain)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (1e05b62ae4bd sh: use the the PCI channels's io_ma=
p_base)
Merging rpmsg/for-next (4c6ece8d46c9 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (f86e1a639a54 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (1ab75c1a1deb Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging pwm/for-next (8cdc43afbb2c pwm: mediatek: Add MT7628 support)
Merging userns/for-next (82c9a927bc5d getxattr: use correct xattr length)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9a47249d444d random: Make crng state queryable)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (c31d02d1290e selftests: kselftest: Remove outdated =
comment)
Merging y2038/y2038 (49c39f8464a9 y2038: signal: Change rt_sigtimedwait to =
use __kernel_timespec)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (9cda9e8f28d7 coresight: etb10: Splitting function e=
tb_enable())
Merging rtc/rtc-next (de96bc39951f rtc: mrst: remove set but not used varia=
ble 'valid')
Merging nvdimm/libnvdimm-for-next (be5ba2ca053d dax: Fix use of zero page)
Merging at24/at24/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (43bd0619727c Merge branch 'for-next/gcc-plugin-=
infrastructure' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging fsi/master (15e2a7218c27 fsi: sbefifo: Bump max command length)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging akpm-current/current (68565082aedf mm/page_alloc.c: clean up check_=
for_memory())
CONFLICT (content): Merge conflict in include/linux/sched.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (433dd6566199 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/u4a13F.cqdxxB0Q1Mwi+qq+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluMowgACgkQAVBC80lX
0GwKUQf/Wx4yqEj6xyy8WoGuYHhyE4ZKsPuejY5mus8IHJ6+3dlmPUvMRmQXHrFk
OLX60+6VcjdEeaVLGkNcN3CChQi5kI2eoxEfC6eE7+OjWTWaCU4kwfIj90I3uyIs
QlwHzCoGWNfVf0H5waZqH8kgauQciomOL79OemCYi83rE7YVspzIK9SASGeDlO3P
UaXDuoM51Om+Hr6VdSC27OgxFOns/7WWVouA2aXOWT5d3RJcTb48Wy6kBcoaKHuG
Io3PIevrw1YnjwowR2+1IyTuzdtCMvOCA0HRz7UFiGPZ5mbVUISwPmWBfYlGEOuQ
NFATIgMT54NuBbMmon/Qk65L1svYSQ==
=Kc99
-----END PGP SIGNATURE-----

--Sig_/u4a13F.cqdxxB0Q1Mwi+qq+--
