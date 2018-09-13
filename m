Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB6BC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D69A20854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 05:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nCMc5uk8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D69A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeIMKfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 06:35:53 -0400
Received: from ozlabs.org ([203.11.71.1]:60397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbeIMKfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 06:35:53 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 429nGz6bz1z9s3x;
        Thu, 13 Sep 2018 15:27:55 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1536816475;
        bh=iXlIWEaV6bwPi8i2efAOT0pwDSaR760ozVWGWBS7yxc=;
        h=Date:From:To:Cc:Subject:From;
        b=nCMc5uk8S9Hlzu5dTifqdo3gd6x7Vygz2VOAWjTnLErDqfSQzJgOUwNGuX1687BYL
         sdr/Le5ycz4b4n8n89x1ZF6/2wV4GR/V6yKEL27AiG4KtjCEQauxlFwO9XRiMWniCo
         nF4K8nlwtSujI1/ATbRzCRzhqjW8iJ31828pmv5ajMJCRNip6pLfEr4YYnTqnN27Ck
         hbUr9vAH31I9nJHtqgUaxuIV5oSEGBEAhUJ+46ldOFwb+/36Mze4Ivjh1s1IROcqq0
         y9wlKUoptCMlraBlAfQaSM/28MR023LDWs/YF/ggXXOJHcKMjsgQ+vO8TPvsckx4+h
         01pr1dGMgwFvA==
Date:   Thu, 13 Sep 2018 15:27:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 13
Message-ID: <20180913152753.60866288@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/V4goP7Zdd2qFV6cshdrj1pM"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/V4goP7Zdd2qFV6cshdrj1pM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: there will be no linux-next releases on Friday or Monday.

Changes since 20180912:

Dropped trees: xarray, ida (temporarily)

I still disabled building some samples in the vfs tree.

I added a supplied patch to the akpm-current tree.

The akpm tree lost a patch for a bug that was fixed elsewhere.

Non-merge commits (relative to Linus' tree): 3643
 4039 files changed, 119566 insertions(+), 73090 deletions(-)

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
Merging origin/master (96eddb810b14 Merge tag 'riscv-for-linus-4.19-rc3' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux)
Merging fixes/master (72358c0b59b7 linux-next: build warnings from the buil=
d of Linus' tree)
Merging kbuild-current/fixes (11da3a7f84f1 Linux 4.19-rc3)
Merging arc-current/for-curr (00a99339f0a3 ARCv2: build: use mcpu=3Dhs38 is=
o generic mcpu=3Darchs)
Merging arm-current/fixes (afc9f65e01cd ARM: 8781/1: Fix Thumb-2 syscall re=
turn for binutils 2.29+)
Merging arm64-fixes/for-next/fixes (84c57dbd3c48 arm64: kernel: arch_crash_=
save_vmcoreinfo() should depend on CONFIG_CRASH_CORE)
Merging m68k-current/for-linus (0986b16ab49b m68k/mac: Use correct PMU resp=
onse format)
Merging powerpc-fixes/fixes (cca19f0b684f powerpc/64s/radix: Fix missing gl=
obal invalidations when removing copro)
Merging sparc/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (4851bfd64d42 Merge branch 'nfp-flower-fixes')
Merging bpf/master (dd066823db2a bpf/verifier: disallow pointer subtraction)
Merging ipsec/master (9e1437937807 xfrm: Fix NULL pointer dereference when =
skb_dst_force clears the dst_entry.)
Merging netfilter/master (1286df269f49 netfilter: xt_hashlimit: use s->file=
 instead of s->private)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (5b394b2ddf03 Linux 4.19-rc1)
Merging mac80211/master (c42055105785 mac80211: fix TX status reporting for=
 ieee80211s)
Merging rdma-fixes/for-rc (9f34519a8235 cxgb4: fix abort_req_rss6 struct)
Merging sound-current/for-linus (49434c6c575d ALSA: emu10k1: fix possible i=
nfo leak to userspace on SNDRV_EMU10K1_IOCTL_INFO)
Merging sound-asoc-fixes/for-linus (de7609683fef Merge branch 'asoc-4.19' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (57361846b52b Linux 4.19-rc2)
Merging regulator-fixes/for-linus (b832dd4f2c04 Merge branch 'regulator-4.1=
9' into regulator-linus)
Merging spi-fixes/for-linus (9029858be9ef Merge branch 'spi-4.19' into spi-=
linus)
Merging pci-current/for-linus (9d27e39d309c PCI: Fix enabling of PASID on R=
C integrated endpoints)
Merging driver-core.current/driver-core-linus (11da3a7f84f1 Linux 4.19-rc3)
Merging tty.current/tty-linus (7f2bf7840b74 tty: hvc: hvc_write() fix break=
 condition)
Merging usb.current/usb-linus (df3aa13c7bbb Revert "cdc-acm: implement put_=
char() and flush_chars()")
Merging usb-gadget-fixes/fixes (d9707490077b usb: dwc2: Fix call location o=
f dwc2_check_core_endianness)
Merging usb-serial-fixes/usb-linus (5dfdd24eb3d3 USB: serial: ti_usb_3410_5=
052: fix array underflow in completion handler)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging staging.current/staging-linus (65aac1742328 staging: vboxvideo: Cha=
nge address of scanout buffer on page-flip)
Merging char-misc.current/char-misc-linus (422b3db2a503 firmware: Fix secur=
ity issue with request_firmware_into_buf())
Merging soundwire-fixes/fixes (8d6ccf5cebbc soundwire: Fix acquiring bus lo=
ck twice during master release)
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
Merging mfd-fixes/for-mfd-fixes (10492ee8ed91 mfd: omap-usb-host: Fix dts p=
robe of children)
Merging v4l-dvb-fixes/fixes (dab99a0f77e9 media: staging/media/mt9t031/Kcon=
fig: remove bogus entry)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (0f02cfbc3d9e MIPS: VDSO: Match data page cac=
he colouring when D$ aliases)
Merging at91-fixes/at91-fixes (379e36d3f591 ARM: dts: at91: sama5d2_ptc_ek:=
 fix nand pinctrl)
Merging omap-fixes/fixes (c265c0ca76fb ARM: dts: logicpd-som-lv: Fix OMAP35=
/DM37 Compatibility issues)
Merging kvm-fixes/master (bdf7ffc89922 KVM: LAPIC: Fix pv ipis out-of-bound=
s access)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (c793279c7703 hwmon: (nct6775) Fix access to fan =
pulse registers)
Merging nvdimm-fixes/libnvdimm-fixes (ee6581ceba7f nfit: fix unchecked dere=
ference in acpi_nfit_ctl)
Merging btrfs-fixes/next-fixes (675c168b2b92 Merge branch 'misc-4.19' into =
next-fixes)
Merging vfs-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging dma-mapping-fixes/for-linus (8c89ef7b6b64 of/platform: initialise A=
MBA default DMA masks)
Merging drivers-x86-fixes/fixes (ff0e9f26288d platform/x86: alienware-wmi: =
Correct a memory leak)
Merging samsung-krzk-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging devicetree-fixes/dt/linus (e54192b48da7 of: fix phandle cache creat=
ion for DTs with no phandles)
Merging scsi-fixes/fixes (cbe3fd39d223 scsi: qla2xxx: Fix an endian bug in =
fcpcmd_is_corrupted())
Merging drm-fixes/drm-fixes (2887e5ce15dd Merge branch 'linux-4.19' of git:=
//github.com/skeggsb/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (17dc7af70e89 drm/i915/overlay=
: Allocate physical registers from stolen)
Merging mmc-fixes/fixes (c483a5cc9d09 mmc: meson-mx-sdio: fix OF child-node=
 lookup)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (6ee67e351cda drm/fb-helper: Re=
move set but not used variable 'connector_funcs')
Merging kbuild/for-next (0d91bf584fe5 kbuild: remove old check for CFLAGS u=
se)
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
Merging at91/at91-next (fb3cd261d0c8 Merge branch 'at91-defconfig' into at9=
1-next)
Merging bcm2835/for-next (ca5b45b7c5cd Merge branch 'bcm2835-defconfig-next=
' into for-next)
Merging imx-mxs/for-next (ceba5ca0e35a Merge branch 'imx/defconfig' into fo=
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
Merging renesas/next (cbc5086f7524 Merge branches 'arm-defconfig-for-v4.20'=
, 'arm-dt-for-v4.20', 'arm-soc-for-v4.20', 'arm64-defconfig-for-v4.20', 'ar=
m64-dt-for-v4.20', 'arm64-soc-for-v4.20', 'drivers-for-v4.20' and 'dt-bindi=
ngs-for-v4.20' into next)
Merging rockchip/for-next (04e66fbe4984 Merge branch 'v4.20-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (a8fbbcccc1d3 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (c740d5b07be1 Merge branches 'sunxi/drivers-fo=
r-4.20' and 'sunxi/dt64-for-4.20' into sunxi/for-next)
Merging tegra/for-next (72cb7a878f5b Merge branch for-4.20/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (7f08872774eb arm64: tlb: Rewrite stale comment=
 in asm/tlbflush.h)
Merging clk/clk-next (7be9338d38a6 Merge branch 'clk-mvebu-periph-pm' into =
clk-next)
Merging clk-samsung/for-next (519570ff75a1 clk: samsung: exynos5433: Keep s=
clk_uart clocks enabled in suspend)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (86bc194810d7 m68k: fix command-line parsing whe=
n passed from u-boot)
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
Merging s390/features (c48e4c3f32a2 s390/tape: fix spelling mistake "partio=
n" -> "partition")
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (d9cbd0e8f667 um: NULL check before kfree is not nee=
ded)
Merging xtensa/xtensa-for-next (c9efd0d7beb3 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (d2a571eafd46 Merge branch 'for-next-next-v4.2=
0-20180911' into for-next-20180911)
Merging ceph/master (e92c0eaf7543 rbd: support cloning across namespaces)
Merging cifs/for-next (097f5863b1a0 cifs: read overflow in is_valid_oplock_=
break())
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (50559ae2e645 Pull UDF mount fixes.)
Merging ext4/dev (63bfa461b93d ext4: close race between direct IO and ext4_=
break_layouts())
Merging f2fs/dev (313ed62a3ddc f2fs: cache NULL when both default_acl and a=
cl are NULL)
Merging fuse/for-next (30e0d0966c9c fuse: add support for copy_file_range())
Merging jfs/jfs-next (02645bcdfcc2 jfs: remove quota option from ignore lis=
t)
Merging nfs/linux-next (11da3a7f84f1 Linux 4.19-rc3)
Merging nfs-anna/linux-next (d34cea1f7fb8 NFS: Don't open code clearing of =
delegation state)
Merging nfsd/nfsd-next (108b833cde9c sunrpc: Add comment defining gssd upca=
ll API keywords)
Merging orangefs/for-next (a3bb1b184669 Orangefs: some error code paths mis=
sed kmem_cache_free to bad effect.)
Merging overlayfs/overlayfs-next (8c25741aaad8 ovl: fix oopses in ovl_fill_=
super() failure paths)
Merging ubifs/linux-next (6e5461d774bf ubifs: Remove empty file.h)
Merging v9fs/9p-next (b4dc44b3cac9 9p locks: fix glock.client_id leak in do=
_lock)
Merging xfs/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging file-locks/locks-next (10f3e23f07cb Merge tag 'ext4_for_linus' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4)
Merging vfs/for-next (87a0a1536d35 Merge branches 'work.mount', 'work.alpha=
' and 'work.compat' into for-next)
Applying: disable building the VFS sample programs
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (a6ae928c2583 Revert "printk: make sure to print lo=
g on console.")
Merging pci/next (3ea7a150795e Merge branch 'pci/hotplug')
Merging pstore/for-next/pstore (172e596c15ff pstore: fix incorrect persiste=
nt ram buffer mapping)
Merging hid/for-next (4c640c41381e Merge branch 'for-4.19/fixes' into for-n=
ext)
Merging i2c/i2c/for-next (fc9f90ddace2 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (65ca18190667 hwmon: (lm75) Add MAX31725/6=
 support)
Merging jc_docs/docs-next (a7ddcea58ae2 Drop all 00-INDEX files from Docume=
ntation/)
Merging v4l-dvb/master (78cf8c842c11 media: drxj: fix spelling mistake in f=
all-through annotations)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (f39684524b39 Documentation/fb: corrections fo=
r fbcon.txt)
Merging pm/linux-next (11da3a7f84f1 Linux 4.19-rc3)
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
Merging rdma/for-next (b53ae6bc7e39 IB/hfi1: set_intr_bits uses incorrect s=
ource for register modification)
Merging net-next/master (eca09be82eb8 nfp: report FW vNIC stats in interfac=
e stats)
Merging bpf-next/master (1edb6e035eb7 net/core/filter: fix unused-variable =
warning)
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
Merging mac80211-next/master (2e8a1aa0dadf cfg80211: remove redundant check=
 of !scan_plan)
Merging gfs2/for-next (4f36cb36c9d1 gfs2: Don't set GFS2_RDF_UPTODATE when =
the lvb is updated)
Merging mtd/mtd/next (5b394b2ddf03 Linux 4.19-rc1)
Merging nand/nand/next (9b2c0b94ae32 mtd: rawnand: Do not treat !maxchips s=
pecially in nand_scan_with_ids())
Merging spi-nor/spi-nor/next (bb276262e88d mtd: spi-nor: only apply reset h=
acks to broken hardware)
Merging crypto/master (a1b22a5f45fe crypto: arm/chacha20 - faster 8-bit rot=
ations and other optimizations)
Merging drm/drm-next (b1c1566822ab Merge tag 'drm-intel-next-2018-09-06-2' =
of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_ddi.c
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (2693efd99cad drm/i915/audio: Hook up comp=
onent bindings even if displays are disabled)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (185e0bebb44f drm/sun4i: fix build failure =
with CONFIG_DRM_SUN8I_MIXER=3Dm)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.h
Merging drm-msm/msm-next (2a56b5c8a7ca drm/msm/dpu: remove RM topology defi=
nition)
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
Merging sound/for-next (64b6acf60b66 ALSA: pcm: Update hardware pointer bef=
ore start capture)
Merging sound-asoc/for-next (cb6c25385540 Merge branch 'asoc-4.20' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (100294cee9a9 Input: do not use WARN() in input_alloc_ab=
sinfo())
Merging block/for-next (4e36415fa9ce Merge branch 'for-4.20/libata' into fo=
r-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (3ab918281668 dm thin metadata: try to avoid=
 ever aborting transactions)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (6d2beaffc5b7 mmc: sunxi: Use new timing mode for A64 eMMC=
 controller)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (9a255eeb01dd raid5: block failing device if raid will =
be failed)
Merging mfd/for-mfd-next (92d6ba4ff700 mfd: ti-lmu: constify mfd_cell table=
s)
Merging backlight/for-backlight-next (633786736ed5 backlight: pwm_bl: Fix u=
ninitialized variable)
Merging battery/for-next (231d259f547c power: bq25890_charger.c: Read back =
the current battery voltage)
Merging regulator/for-next (0f27fac7a4b9 Merge remote-tracking branch 'regu=
lator/topic/pfuze100' into regulator-next)
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
Merging spi/for-next (3892bb313931 Merge branch 'spi-4.20' into spi-next)
Merging tip/auto-latest (41e351e0d8bc Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (8489b17ce29d EDAC, sb_edac: Fix reporting for pa=
trol scrubber errors)
Merging irqchip/irq/irqchip-next (4110b5cbb014 irqchip/gic-v3: Allow interr=
upt to be configured as wake-up sources)
Merging ftrace/for-next (bb730b5833b5 tracing: Fix SPDX format headers to u=
se C++ style comments)
Merging rcu/rcu/next (9859adc81304 rcutorture: Make use of nolibc when avai=
lable)
Merging kvm/linux-next (5b394b2ddf03 Linux 4.19-rc1)
Merging kvm-arm/next (976d34e2dab1 KVM: arm/arm64: Skip updating PTE entry =
if no change)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (46dec40fb741 KVM: PPC: Book3S HV: Don't trunc=
ate HPTE index in xlate function)
Merging kvms390/next (2b6d5b5ad116 s390/mm: optimize locking without huge p=
ages in gmap_pmd_op_walk())
Merging xen-tip/linux-next (de1ab150ae47 xen: avoid crash in disable_hotplu=
g_cpu)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (ff0e9f26288d platform/x86: alienware-wmi: Cor=
rect a memory leak)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (2d00f35c55e7 leds: add Panasonic AN30259A support)
Merging ipmi/for-next (bc221b0f7ee3 ipmi: Remove platform driver overrides =
and use the id_table)
Merging driver-core/driver-core-next (11da3a7f84f1 Linux 4.19-rc3)
Merging usb/usb-next (d6142b91e9cc usb: core: remove flags variable in __us=
b_hcd_giveback_urb())
Merging usb-gadget/next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-serial/usb-next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-chipidea-next/ci-for-usb-next (35a334659bcc usb: chipidea: imx:=
 make MODULE_LICENCE and SPDX-identifier match)
Merging phy-next/next (53706a116863 phy: add Rockchip Innosilicon hdmi phy)
Merging tty/tty-next (30ecfff4de7c Merge tag 'ib-mfd-spi-tty-v4.20-1' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd into tty-next)
Merging char-misc/char-misc-next (79c6f4b84b6e uio: convert to vm_fault_t)
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (14b0c44af4e9 soundwire: intel: Remove duplicate ass=
ignment)
CONFLICT (content): Merge conflict in drivers/soundwire/stream.c
Merging staging/staging-next (645923e441d3 staging: rtl8188eu: change array=
 type to u8)
Merging mux/for-next (2c01260df661 mux: add mux_control_get_optional() API)
Merging icc/icc-next (3d46fda12a9d MAINTAINERS: add a maintainer for the in=
terconnect API)
Merging slave-dma/next (6e7cb32e9f64 Merge branch 'topic/jz' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (08097a7777f8 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (94e989dee2b7 scsi: message: fusion: fix a few tr=
ivial spelling mistakes)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (1e05b62ae4bd sh: use the the PCI channels's io_ma=
p_base)
Merging rpmsg/for-next (0205748ea669 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (29e687c2be7d Merge branch 'devel' into for-next)
Merging pinctrl/for-next (1ab75c1a1deb Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging pwm/for-next (8cdc43afbb2c pwm: mediatek: Add MT7628 support)
Merging userns/for-next (4ff4c31a6e85 signal: Remove SEND_SIG_FORCED)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9b25436662d5 random: make CPU trust a boot parameter)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (a987785dcd6c Add tests for memory.oom.group)
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (327c7ebeb14f coreisght: tmc: Claim device before us=
e)
Merging rtc/rtc-next (749e36d0a0d7 rtc: abx80x: add basic watchdog support)
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
Merging akpm-current/current (c6247557bc4e ipc: conserve sequence numbers i=
n extended IPCMNI mode)
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in arch/hexagon/Kconfig
$ git checkout -b akpm remotes/origin/akpm/master
Applying: percpu: remove PER_CPU_DEF_ATTRIBUTES macro
Applying: vfs: replace current_kernel_time64 with ktime equivalent
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (568e39651081 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/V4goP7Zdd2qFV6cshdrj1pM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAluZ9VkACgkQAVBC80lX
0GytYAf/QoBgjBi8ixHiUTH3OhmIo6gJESCSFSee9AkYdvh+luVK03y9lWofZnef
WOAkLBwLvnTPZZzaSW7rinru2pUGMwSKKl1KohyYnwhPZ/BgXfJ06TMALHkoVnYc
++dsGahG30AGcRbmySotupIl84+PbsqESHModOdAaJpAMQdm2HpTjO2NU8XS97DU
ql7glmJ/TDm2zIO7Aq/B9rlcGERNNeCgdx2idWNcdU77oALO1aWU+PBSX7x/oCR3
sfae8WzwyvZNmQdwvco/+ciVL7hdjgEfWHZl5UytGJVblZ/diloqGc3bKj2VlFfN
u8H/oS9971TsMBLYR+eSkT90uHL+1g==
=M92n
-----END PGP SIGNATURE-----

--Sig_/V4goP7Zdd2qFV6cshdrj1pM--
