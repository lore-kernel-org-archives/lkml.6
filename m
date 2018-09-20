Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9F3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A186321525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 05:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Gr4isrmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A186321525
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbeITKyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 06:54:22 -0400
Received: from ozlabs.org ([203.11.71.1]:47115 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbeITKyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 06:54:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 42G4cF029dz9sBy;
        Thu, 20 Sep 2018 15:12:45 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1537420365;
        bh=1xDkZKCuA5BZtb1wLV2zQPg1jDlC5o5MpC8Aipso0sc=;
        h=Date:From:To:Cc:Subject:From;
        b=Gr4isrmvTsTZ+eJxCRMvJIaisoFZT95jQKQqwS/0/Rp5G7SvunKtJbW29WDfSiuZA
         6LCgNo+ajvmh/oxLPte3UHvuq6Qn2/hAQNU7F8bVv/7qs4szs9K/6F7TYsPBgxH0qd
         ITtXoTCkI84zciK2mwbMqxr5Y+VSk3XMzhN7J//9Z6Z9WCRxqfxC8b9F0211eqlljj
         Yo9Jtjg/NIQ+7vYA14vRFC0LBpQZRnRj7wSb7kOCuEkIEw2e3T2ChcLW/V88L+Rx/Q
         9hYNTQaKNROekqW13rvFxeJUcvaHeDjyAYz891z8nWRN3qc57JkWYdUj0EuVVTiYkh
         0qyYOtcmhJqhA==
Date:   Thu, 20 Sep 2018 15:12:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Sep 20
Message-ID: <20180920151243.5524c6ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QAYu3Zm5IXlWRbfXXXYs9tZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QAYu3Zm5IXlWRbfXXXYs9tZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180919:

Dropped trees: xarray, ida (temporarily)

The input-current tree lost its build failure.

I still disabled building some samples in the vfs tree.

Non-merge commits (relative to Linus' tree): 4279
 4792 files changed, 166265 insertions(+), 93138 deletions(-)

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

I am currently merging 288 trees (counting Linus' and 66 trees of bug
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
Merging origin/master (eb9a29f9e585 Merge tag 'hwmon-for-linus-v4.19-rc5' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging)
Merging fixes/master (72358c0b59b7 linux-next: build warnings from the buil=
d of Linus' tree)
Merging kbuild-current/fixes (ef8c4ed9db80 kbuild: allow to use GCC toolcha=
in not in Clang search path)
Merging arc-current/for-curr (40660f1fcee8 ARC: build: Don't set CROSS_COMP=
ILE in arch's Makefile)
Merging arm-current/fixes (afc9f65e01cd ARM: 8781/1: Fix Thumb-2 syscall re=
turn for binutils 2.29+)
Merging arm64-fixes/for-next/fixes (500dd232449e asm-generic: io: Fix iopor=
t_map() for !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO)
Merging m68k-current/for-linus (0986b16ab49b m68k/mac: Use correct PMU resp=
onse format)
Merging powerpc-fixes/fixes (cca19f0b684f powerpc/64s/radix: Fix missing gl=
obal invalidations when removing copro)
Merging sparc/master (df2def49c57b Merge tag 'acpi-4.19-rc1-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (69ba423d35c2 Merge branch 'ipv6-fix-issues-on-accessing=
-fib6_metrics')
Merging bpf/master (080220b68714 tools: bpf: fix license for a compat heade=
r file)
Merging ipsec/master (9e1437937807 xfrm: Fix NULL pointer dereference when =
skb_dst_force clears the dst_entry.)
Merging netfilter/master (0376d5dce0aa Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/bpf/bpf)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (3341ba9f0f26 mt76x0: fix remove_interface)
Merging mac80211/master (c42055105785 mac80211: fix TX status reporting for=
 ieee80211s)
Merging rdma-fixes/for-rc (5fe23f262e05 ucma: fix a use-after-free in ucma_=
resolve_ip())
Merging sound-current/for-linus (196f4eeeb78f Merge tag 'asoc-v4.19-rc4' of=
 https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into for-lin=
us)
Merging sound-asoc-fixes/for-linus (3cd71e0cf7a0 Merge branch 'asoc-4.19' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (7876320f8880 Linux 4.19-rc4)
Merging regulator-fixes/for-linus (b8af4f09c5ec Merge branch 'regulator-4.1=
9' into regulator-linus)
Merging spi-fixes/for-linus (1f7f2e2d2cda Merge branch 'spi-4.19' into spi-=
linus)
Merging pci-current/for-linus (7876320f8880 Linux 4.19-rc4)
Merging driver-core.current/driver-core-linus (7876320f8880 Linux 4.19-rc4)
Merging tty.current/tty-linus (e97267cb4d1e tty: vt_ioctl: fix potential Sp=
ectre v1)
Merging usb.current/usb-linus (7876320f8880 Linux 4.19-rc4)
Merging usb-gadget-fixes/fixes (d9707490077b usb: dwc2: Fix call location o=
f dwc2_check_core_endianness)
Merging usb-serial-fixes/usb-linus (35aecc02b5b6 USB: serial: option: add t=
wo-endpoints device-id flag)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging staging.current/staging-linus (7876320f8880 Linux 4.19-rc4)
Merging char-misc.current/char-misc-linus (59d08d00d43c intel_th: pci: Add =
Ice Lake PCH support)
Merging soundwire-fixes/fixes (8d6ccf5cebbc soundwire: Fix acquiring bus lo=
ck twice during master release)
Merging input-current/for-linus (4fef1250eafd Input: uinput - allow for max=
 =3D=3D min during input_absinfo validation)
Merging crypto-current/master (24568b47d48e crypto: x86/aegis,morus - Do no=
t require OSXSAVE for SSE2)
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
Merging mtd-fixes/master (4a3e85f2674c mtd: devices: m25p80: Make sure the =
buffer passed in op is DMA-able)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (10492ee8ed91 mfd: omap-usb-host: Fix dts p=
robe of children)
Merging v4l-dvb-fixes/fixes (324493fba775 media: platform: fix cros-ec-cec =
build error)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (0f02cfbc3d9e MIPS: VDSO: Match data page cac=
he colouring when D$ aliases)
Merging at91-fixes/at91-fixes (379e36d3f591 ARM: dts: at91: sama5d2_ptc_ek:=
 fix nand pinctrl)
Merging omap-fixes/fixes (c265c0ca76fb ARM: dts: logicpd-som-lv: Fix OMAP35=
/DM37 Compatibility issues)
Merging kvm-fixes/master (1795f81f6167 Merge tag 'kvm-ppc-fixes-4.19-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc into HEAD)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (55066354285b hwmon: (nct6775) Use different regi=
ster to get fan RPM for fan7)
Merging nvdimm-fixes/libnvdimm-fixes (ee6581ceba7f nfit: fix unchecked dere=
ference in acpi_nfit_ctl)
Merging btrfs-fixes/next-fixes (675c168b2b92 Merge branch 'misc-4.19' into =
next-fixes)
Merging vfs-fixes/fixes (ffc4c92227db sysfs: Do not return POSIX ACL xattrs=
 via listxattr)
Merging dma-mapping-fixes/for-linus (8c89ef7b6b64 of/platform: initialise A=
MBA default DMA masks)
Merging drivers-x86-fixes/fixes (ff0e9f26288d platform/x86: alienware-wmi: =
Correct a memory leak)
Merging samsung-krzk-fixes/fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging devicetree-fixes/dt/linus (e54192b48da7 of: fix phandle cache creat=
ion for DTs with no phandles)
Merging scsi-fixes/fixes (83e32a591077 scsi: sd: Contribute to randomness w=
hen running rotational device)
Merging drm-fixes/drm-fixes (2b6318a09fd3 Merge branch 'linux-4.19' of git:=
//github.com/skeggsb/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (a530bf948ab7 Merge tag 'gvt-f=
ixes-2018-09-18' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (2ea15030c3f0 mmc: sdhi: sys_dmac: check for all Ge=
n3 types when whitelisting)
Merging rtc-fixes/rtc-fixes (5b394b2ddf03 Linux 4.19-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (558a9ef94a32 drm: sun4i: drop =
second PLL from A64 HDMI PHY)
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
Merging amlogic/for-next (8787854a1fbf Merge branch 'v4.20/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (c224edaa4a46 Merge branches 'defconfig-for-v4.19' =
and 'dt-for-v4.19' into for-next)
Merging at91/at91-next (4a2a8be2f29d Merge branches 'at91-drivers', 'at91-s=
oc', 'at91-dt' and 'at91-defconfig' into at91-next)
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
Merging renesas/next (883f3822a343 Merge branches 'arm-defconfig-for-v4.20'=
, 'arm-dt-for-v4.20', 'arm-soc-for-v4.20', 'arm64-dt-for-v4.20' and 'driver=
s-for-v4.20' into next)
Merging rockchip/for-next (41c832563530 Merge branch 'v4.20-armsoc/dts64' i=
nto for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (71b2c5109268 Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (9b6c55162e6b Merge branch 'sunxi/fixes-for-4.=
19' into sunxi/for-next)
Merging tegra/for-next (72cb7a878f5b Merge branch for-4.20/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (ab510027dc4d arm64: KVM: Enable Common Not Pri=
vate translations)
Merging clk/clk-next (7be9338d38a6 Merge branch 'clk-mvebu-periph-pm' into =
clk-next)
Merging clk-samsung/for-next (519570ff75a1 clk: samsung: exynos5433: Keep s=
clk_uart clocks enabled in suspend)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging csky/linux-next (da5734d918db dt-bindings: Add vendor prefix for cs=
ky)
Merging h8300/h8300-next (4bdf61ccbe76 h8300: fix IRQ no)
Merging m68k/for-next (58c116fb7dc6 m68k/sun3: Remove is_medusa and m68k_pg=
table_cachemode)
Merging m68knommu/for-next (9b340567a25c m68k: fix command-line parsing whe=
n passed from u-boot)
Merging microblaze/next (c4347b05440f microblaze/PCI: Remove stale pcibios_=
align_resource() comment)
Merging mips/mips-next (c824ad164760 MIPS: Loongson-3: Enable Store Fill Bu=
ffer at runtime)
Merging nds32/next (3350139c0ff3 nds32: linker script: GCOV kernel may refe=
rs data in __exit)
Merging nios2/for-next (c7c09dc187f0 nios2: kconfig: remove duplicate DEBUG=
_STACK_USAGE symbol defintions)
Merging openrisc/for-next (5600779ea5f3 openrisc: use generic dma_noncohere=
nt_ops)
Merging parisc-hd/for-next (7efbe131b5b0 parisc: remove the dead ccio-rm-dm=
a driver)
Merging powerpc/next (0823c68b054b powerpc/fadump: re-register firmware-ass=
isted dump if already registered)
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
Merging btrfs-kdave/for-next (89067b62df5b Merge branch 'for-next-next-v4.2=
0-20180914' into for-next-20180914)
Merging ceph/master (e92c0eaf7543 rbd: support cloning across namespaces)
Merging cifs/for-next (dfcc4fbf23e4 smb3: track the instance of each sessio=
n for debugging)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (50559ae2e645 Pull UDF mount fixes.)
Merging ext4/dev (cce6c9f7e602 ext4, dax: set ext4_dax_aops for dax files)
Merging f2fs/dev (313ed62a3ddc f2fs: cache NULL when both default_acl and a=
cl are NULL)
Merging fuse/for-next (30e0d0966c9c fuse: add support for copy_file_range())
Merging jfs/jfs-next (02645bcdfcc2 jfs: remove quota option from ignore lis=
t)
Merging nfs/linux-next (11da3a7f84f1 Linux 4.19-rc3)
Merging nfs-anna/linux-next (9f0c5124f4a8 NFS: Don't open code clearing of =
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
Merging pstore/for-next/pstore (831b624df1b4 pstore: Fix incorrect persiste=
nt ram buffer mapping)
Merging hid/for-next (9291a1dc6209 Merge branch 'for-4.19/fixes' into for-n=
ext)
Merging i2c/i2c/for-next (fc9f90ddace2 Merge branch 'i2c/for-current' into =
i2c/for-next)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (05f39504bb2a hwmon: (lm92) Fix whitespace=
 issues)
Merging jc_docs/docs-next (a7ddcea58ae2 Drop all 00-INDEX files from Docume=
ntation/)
Merging v4l-dvb/master (985cdcb08a04 media: ov5640: fix restore of last mod=
e set)
Merging v4l-dvb-next/master (357b50f3ccc8 drm: amd: dc: don't use FP math w=
hen Kcov is enabled)
Merging fbdev/fbdev-for-next (f39684524b39 Documentation/fb: corrections fo=
r fbcon.txt)
Merging pm/linux-next (edbdf4828402 Merge branch 'pm-cpufreq' into linux-ne=
xt)
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
Merging rdma/for-next (9a59739bd01f IB/rxe: Revise the ib_wr_opcode enum)
Merging net-next/master (b9d957c5b109 net: wan: remove redundant include)
CONFLICT (modify/delete): Documentation/networking/00-INDEX deleted in HEAD=
 and modified in net-next/master. Version net-next/master of Documentation/=
networking/00-INDEX left in tree.
$ git rm -f Documentation/networking/00-INDEX
Merging bpf-next/master (2dfd184abd38 flow_dissector: fix build failure wit=
hout CONFIG_NET)
Merging ipsec-next/master (4a132095dd64 xfrm: allow driver to quietly refus=
e offload)
Merging mlx5-next/mlx5-next (50acec06f392 net/mlx5: Export packet reformat =
alloc/dealloc functions)
Merging netfilter-next/master (c8204cab9cb5 netfilter: nat: remove unnecess=
ary rcu_read_lock in nf_nat_redirect_ipv{4/6})
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (43e2f2904160 Merge wireless-drivers i=
nto wireless-drivers-next)
Merging bluetooth/master (08d70c106258 Bluetooth: hci_serdev: Add protocol =
check in hci_uart_dequeue().)
Merging mac80211-next/master (ec5b8381e2fc cfg80211: combine duplicate wdev=
 init code)
Merging gfs2/for-next (4f36cb36c9d1 gfs2: Don't set GFS2_RDF_UPTODATE when =
the lvb is updated)
Merging mtd/mtd/next (5b394b2ddf03 Linux 4.19-rc1)
Merging nand/nand/next (729a0db903c8 mtd: rawnand: atmel: Fix potential NUL=
L pointer dereference)
Merging spi-nor/spi-nor/next (8fbb1d4c705e mtd: spi-nor: parse SFDP Sector =
Map Parameter Table)
Merging crypto/master (41a9aca6a2f3 crypto: cavium/nitrox - Added support f=
or SR-IOV configuration.)
Merging drm/drm-next (2dc7bad71cd3 Merge tag 'drm-misc-next-2018-09-13' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_ddi.c
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (2693efd99cad drm/i915/audio: Hook up comp=
onent bindings even if displays are disabled)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (e5264c433c80 gpu: do not double put device=
 node in zx_drm_probe)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_drv.c
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
Merging etnaviv/etnaviv/next (1a866306e0fb drm/etnaviv: add DMA configurati=
on for etnaviv platform device)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (fadf3e019411 Merge remote-tracking branch 'regmap/=
topic/single-rw' into regmap-next)
Merging sound/for-next (05e2ec3b00ed ALSA: atiixp: fix fall-through annotat=
ions)
Merging sound-asoc/for-next (26fbf1666f44 Merge branch 'asoc-4.20' into aso=
c-next)
Merging modules/modules-next (9be936f4b3a2 kernel/module: Use kmemdup to re=
place kmalloc+memcpy)
Merging input/next (100294cee9a9 Input: do not use WARN() in input_alloc_ab=
sinfo())
Merging block/for-next (4e0cd84418eb Merge branch 'for-4.20/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (0328ba90407c dm raid: remove bogus const fr=
om decipher_sync_action() return type)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (c42c3deae1a7 mmc: sdhci: fix __sdhci_adma_write_desc)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (9a255eeb01dd raid5: block failing device if raid will =
be failed)
Merging mfd/for-mfd-next (92d6ba4ff700 mfd: ti-lmu: constify mfd_cell table=
s)
Merging backlight/for-backlight-next (633786736ed5 backlight: pwm_bl: Fix u=
ninitialized variable)
Merging battery/for-next (1c3d7b0364f0 power: supply: Add Spreadtrum SC2731=
 charger support)
Merging regulator/for-next (6c6a9808c077 Merge remote-tracking branch 'regu=
lator/topic/pfuze100' into regulator-next)
Merging security/next-testing (72934a2c220f Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (1f8266ff5884 apparmor: don't try to replace=
 stale label in ptrace access check)
Merging integrity/next-integrity (3dd0f18c70d9 EVM: fix return value check =
in evm_write_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (4458bba09788 selinux: Add __GFP_NOWARN to allocation =
at str_read())
Merging tpmdd/next (8abac8d7b90d tpm: Restore functionality to xen vtpm dri=
ver.)
Merging watchdog/master (60c1f89241d4 Merge tag 'dma-mapping-4.19-2' of git=
://git.infradead.org/users/hch/dma-mapping)
Merging iommu/next (6488a7f35eea Merge branches 'arm/shmobile', 'arm/renesa=
s', 'arm/msm', 'arm/smmu', 'arm/omap', 'x86/amd', 'x86/vt-d' and 'core' int=
o next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (0dd0e297f0ec vfio-pci: Disable binding to PFs with SR-IO=
V enabled)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (57361846b52b Linux 4.19-rc2)
Merging devicetree/for-next (52786e7517a2 scripts/dtc: Update to upstream v=
ersion v1.4.7-14-gc86da84d30e4)
Merging mailbox/mailbox-for-next (2bb7005696e2 mailbox: Add support for i.M=
X messaging unit)
Merging spi/for-next (52ee9c5947db Merge branch 'spi-4.20' into spi-next)
Merging tip/auto-latest (f267a29578f7 Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (c968ed08594d EDAC, sb_edac: Fix signedness bugs =
in *_get_ha() functions)
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
Merging xen-tip/linux-next (d59f532480f5 xen: issue warning message when ou=
t of grant maptrack entries)
Merging percpu/for-next (0b59c25f9100 mm: percpu: remove unnecessary unlike=
ly())
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (ff0e9f26288d platform/x86: alienware-wmi: Cor=
rect a memory leak)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging leds/for-next (2d00f35c55e7 leds: add Panasonic AN30259A support)
Merging ipmi/for-next (10042504ed92 ipmi:ssif: Add support for multi-part t=
ransmit messages > 2 parts)
Merging driver-core/driver-core-next (7876320f8880 Linux 4.19-rc4)
Merging usb/usb-next (1652a83fa494 Merge 4.19-rc4 into usb-next)
Merging usb-gadget/next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-serial/usb-next (5b394b2ddf03 Linux 4.19-rc1)
Merging usb-chipidea-next/ci-for-usb-next (35a334659bcc usb: chipidea: imx:=
 make MODULE_LICENCE and SPDX-identifier match)
Merging phy-next/next (53706a116863 phy: add Rockchip Innosilicon hdmi phy)
Merging tty/tty-next (feacbecb39db TTY: tty_buffer, warn on leaks)
Merging char-misc/char-misc-next (f685fc6ab051 Merge b4.19-rc4 into char-mi=
sc-next)
Merging extcon/extcon-next (2e464ff0a9b1 extcon: int3496: Convert to use SP=
DX identifier)
Merging soundwire/next (502c00d9c315 Documentation: soundwire: fix stream.r=
st markup warnings)
Merging staging/staging-next (9141b60cf6a5 staging: erofs: replace BUG_ON w=
ith DBG_BUGON in data.c)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging mux/for-next (2c01260df661 mux: add mux_control_get_optional() API)
Merging icc/icc-next (3d46fda12a9d MAINTAINERS: add a maintainer for the in=
terconnect API)
Merging slave-dma/next (1576f7e1ef98 Merge branch 'topic/jz' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (3d1edf32e7e7 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (2b08adff433c scsi: qla2xxx: Remove set but not u=
sed variable 'ptr_dma')
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (1e05b62ae4bd sh: use the the PCI channels's io_ma=
p_base)
Merging rpmsg/for-next (0205748ea669 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (4201300305e1 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (716059bc01ff Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (5b394b2ddf03 Linux 4.19-rc1)
Merging pwm/for-next (8cdc43afbb2c pwm: mediatek: Add MT7628 support)
Merging userns/for-next (fb50f5a4011c signal: Pair exports with their funct=
ions)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (9b25436662d5 random: make CPU trust a boot parameter)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (a987785dcd6c Add tests for memory.oom.group)
Merging y2038/y2038 (67314ec7b025 RISC-V: Request newstat syscalls)
Merging livepatching/for-next (c72a7f515329 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (a8182859510f hwtracing: coresight: remove redundant=
 null pointer check before of_node_put and put_device)
Merging rtc/rtc-next (a7c25aa2f977 rtc: test: Switch to SPDX identifier)
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
Merging akpm/master (4a4711c68320 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/QAYu3Zm5IXlWRbfXXXYs9tZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlujLEsACgkQAVBC80lX
0Gy38Af6AlAyGG3Tt5clDSQ/MgVV9WcQS7avTfObru2XfENlYk9YLXOaltJJiIzl
o1gaIuCswJhCAMEl3oHlg9WWlM+3fUnhn7PHRarcggKkSk2/o3cDva5Hy0Yjkh2F
arc9iBgBVOdNZo9k3xyWRscS3Ojg7UYwPl+cXsG0ifaI27rI8dmcWU59ZJv3d1yP
teOlXCq8q095mrRed7+nc1yi6At6bdvlF7gYu2Z+8VvhRcx0pWV8RM/hBKt+P54X
LB77tONuIUvvwf1iezh7qgtClKeaAZV7r+qedqyj0Bsy6+X2R+3bM7YOjlxGSXGi
O7PSiR4Cpef14haYeSZLSLkBvU1exA==
=4WJZ
-----END PGP SIGNATURE-----

--Sig_/QAYu3Zm5IXlWRbfXXXYs9tZ--
