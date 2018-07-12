Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7213C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4998020C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 06:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bE9Eie15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4998020C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeGLG7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 02:59:15 -0400
Received: from ozlabs.org ([203.11.71.1]:48471 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbeGLG7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 02:59:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41R65w0vX3z9s2L;
        Thu, 12 Jul 2018 16:51:00 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1531378260;
        bh=xZZC9amNdRGZ+eE/5ItmqQo8yEsGKqeN3BiZO1tfr6c=;
        h=Date:From:To:Cc:Subject:From;
        b=bE9Eie15u6c7xeL1ZLmAD/1wWOHGY3XltM6eJVNgYQGyL4B4pG4+STwOG8al/rkSF
         P7tTW6pz/PN3lJArZOXZ2tHjHli5FVEIJoG2Dm4xB/3MVI09AyIM9CwHl0Qop6MPfp
         6Q5DGuluVgsNWYLUPno8xtD7xFJgI9TvUsmRal7+avY0ulHMcGr6DbHT7qgyZ2+k66
         GicG73u6Jwp24nF4KBVlm0Kv+VWgeT41rbiYY9i2UrgBnwYxq1aG0t6g49OH8i6P1h
         LKmpM149RsNm1eC59CrfaIzCCNrd/olR83xk6rB1+NCfQiwHykrWZyoLnqc3Zn1cMl
         dIvXWcgfB4NMQ==
Date:   Thu, 12 Jul 2018 16:50:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 12
Message-ID: <20180712165059.0ab009bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/eDRy8yjzhPgYvatEPu=FlZg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eDRy8yjzhPgYvatEPu=FlZg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

News: This release still fails my simple PowerPC qemu boot without
kvm ...

Changes since 20180711:

Non-merge commits (relative to Linus' tree): 5474
 5505 files changed, 200302 insertions(+), 114801 deletions(-)

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

I am currently merging 283 trees (counting Linus' and 65 trees of bug
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
Merging origin/master (c25c74b7476e Merge tag 'trace-v4.18-rc3-2' of git://=
git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (47a18a2dabba scripts: teach extract-vmlinux a=
bout LZ4 and ZSTD)
Merging arc-current/for-curr (6e3761145a9b ARC: Fix CONFIG_SWAP)
Merging arm-current/fixes (6ef09e48c2bc ARM: 8780/1: ftrace: Only set kerne=
l memory back to read-only after boot)
Merging arm64-fixes/for-next/fixes (2fd8eb4ad871 arm64: neon: Fix function =
may_use_simd() return error status)
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (22db552b50fa powerpc/powermac: Fix rtc read/wr=
ite functions)
Merging sparc/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel=
.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (0026129c8629 rhashtable: add restart routine in rhashta=
ble_free_and_destroy())
Merging bpf/master (61d769807f27 bpf: fix availability probing for seg6 hel=
pers)
Merging ipsec/master (7284fdf39a91 esp6: fix memleak on error path in esp6_=
input)
Merging netfilter/master (0026129c8629 rhashtable: add restart routine in r=
hashtable_free_and_destroy())
Merging ipvs/master (312564269535 net: netsec: reduce DMA mask to 40 bits)
Merging wireless-drivers/master (248c690a2dc8 Merge tag 'wireless-drivers-f=
or-davem-2018-07-03' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo=
/wireless-drivers)
Merging mac80211/master (5cf3006cc81d nl80211: Add a missing break in parse=
_station_flags)
Merging rdma-fixes/for-rc (fe48aecb4df8 RDMA/uverbs: Don't fail in creation=
 of multiple flows)
Merging sound-current/for-linus (c6b17f1020d9 ALSA: hda/realtek - two more =
lenovo models need fixup of MIC_LOCATION)
Merging sound-asoc-fixes/for-linus (7dc4ac12ac2b Merge branch 'asoc-4.18' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (1e4b044d2251 Linux 4.18-rc4)
Merging regulator-fixes/for-linus (c1362eb9f806 Merge branch 'regulator-4.1=
8' into regulator-linus)
Merging spi-fixes/for-linus (3c81743ecf5b Merge branch 'spi-4.18' into spi-=
linus)
Merging pci-current/for-linus (a83a21734416 PCI: endpoint: Fix NULL pointer=
 dereference error when CONFIGFS is disabled)
Merging driver-core.current/driver-core-linus (722e5f2b1eec driver core: Pa=
rtially revert "driver core: correct device's shutdown order")
Merging tty.current/tty-linus (021c91791a5e Linux 4.18-rc3)
Merging usb.current/usb-linus (f1e255d60ae6 USB: yurex: fix out-of-bounds u=
access in read handler)
Merging usb-gadget-fixes/fixes (1d8e5c002758 dwc2: gadget: Fix ISOC IN DDMA=
 PID bitfield value calculation)
Merging usb-serial-fixes/usb-linus (794744abfffe USB: serial: mos7840: fix =
status-register error handling)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (ad5003300b07 phy: mapphone-mdm6600: Fix wrong enum used =
for status lines)
Merging staging.current/staging-linus (d59d2f9995d2 staging: r8822be: Fix R=
TL8822be can't find any wireless AP)
Merging char-misc.current/char-misc-linus (87ed1405ef09 nvmem: Don't let a =
NULL cell_id for nvmem_cell_get() crash us)
Merging input-current/for-linus (28501bd2bcda MAINTAINERS: Add file pattern=
s for serio device tree bindings)
Merging crypto-current/master (221e00d1fce9 crypto: x86 - Add missing RETs)
Merging ide/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/abelloni/linux)
Merging vfio-fixes/for-linus (498e8bf51c63 sample: vfio-mdev: avoid deadloc=
k in mdev_access())
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
Merging reset-fixes/reset/fixes (e6914365fd28 reset: uniphier: fix USB cloc=
k line for LD20)
Merging mips-fixes/mips-fixes (523402fa9101 MIPS: Fix ioremap() RAM check)
Merging omap-fixes/fixes (41bd6adf3c5d Revert "ARM: dts: logicpd-som-lv: Fi=
x pinmux controller references")
Merging kvm-fixes/master (6f0d349d922b Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/davem/net)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (1e4b044d2251 Linux 4.18-rc4)
Merging nvdimm-fixes/libnvdimm-fixes (ee6581ceba7f nfit: fix unchecked dere=
ference in acpi_nfit_ctl)
Merging btrfs-fixes/next-fixes (cf63fc9616bc Merge branch 'for-next-current=
-v4.18-20180702' into next-fixes)
Merging vfs-fixes/fixes (877f919e192a proc: add proc_seq_release)
Merging dma-mapping-fixes/for-linus (7ec916f82c48 Revert "iommu/intel-iommu=
: Enable CONFIG_DMA_DIRECT_OPS=3Dy and clean up intel_{alloc,free}_coherent=
()")
Merging drivers-x86-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging samsung-krzk-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (ce397d215ccd Linux 4.18-rc1)
Merging devicetree-fixes/dt/linus (a47c9b394316 dt-bindings: Fix unbalanced=
 quotation marks)
Merging scsi-fixes/fixes (943e59fe78ee scsi: cxlflash: fix assignment of th=
e backend operations)
Merging drm-fixes/drm-fixes (dc81aab1be9f MAINTAINERS: update drm tree)
Merging drm-intel-fixes/for-linux-next-fixes (96a85cc517a9 drm/i915: Fix ho=
tplug irq ack on i965/g4x)
Merging mmc-fixes/fixes (92748beac07c mmc: sdhci-esdhc-imx: allow 1.8V mode=
s without 100/200MHz pinctrl states)
Merging rtc-fixes/rtc-fixes (ca95ef7c9867 rtc: mrst: fix error code in prob=
e())
Merging drm-misc-fixes/for-linux-next-fixes (3156b53c2e2f drm/sun4i: link i=
n front-end code if needed)
Merging kbuild/for-next (006d7d9bfef7 Merge branches 'kbuild' and 'kconfig'=
 into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (2550bbfd4952 dma-direct: don't crash on devic=
e without dma_mask)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (c77e03d01b62 Merge branches 'clkdev', 'fixes', 'misc'=
 and 'spectre' into for-next)
Merging arm-perf/for-next/perf (c13207905340 arm64: perf: Add support for c=
haining event counters)
Merging arm-soc/for-next (5628f09076e6 ARM: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (ccf2d85eccf7 Merge branch 'v4.18/fixes' into tmp/=
aml-rebuild)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (59ef2671a847 ARM: dts: fix PMC compatible)
Merging bcm2835/for-next (5997adb14985 Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
Merging imx-mxs/for-next (f88f8d8bae63 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (ed3bf0f321b9 Merge branch 'for_4.19/drivers-soc' int=
o next)
Merging mediatek/for-next (9378b3427341 Merge branch 'v4.17-next/soc' into =
for-next)
Merging mvebu/for-next (b9cfa4d84abb Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (3108e298906b Merge branch 'omap-for-v4.19/dt' into f=
or-next)
Merging reset/reset/next (d7bab65b1f57 reset: uniphier: add LD11/LD20 strea=
m demux system reset control)
Merging qcom/for-next (376e1f304fc7 firmware: qcom: scm: add a dummy qcom_s=
cm_assign_mem())
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (61a007a13b2d Merge branches 'arm-defconfig-for-v4.19'=
, 'arm-soc-for-v4.19', 'arm-dt-for-v4.19' and 'arm64-defconfig-for-v4.19' i=
nto next)
Merging rockchip/for-next (588455ca08e4 Merge branch 'v4.19-clk/next' into =
for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (ea01929db236 Merge branch 'next/dt' into for=
-next)
Merging sunxi/sunxi/for-next (3061b277089d Merge branches 'sunxi/drivers-fo=
r-4.19' and 'sunxi/dt-for-4.19' into sunxi/for-next)
Merging tegra/for-next (f29cfb31cf00 Merge branch for-4.19/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (db7a2d1809a5 asm-generic: unistd.h: Wire up sy=
s_rseq)
Merging clk/clk-next (513935f8e837 Merge branch 'clk-rockchip' into clk-nex=
t)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (31b02fe54206 c6x: switch to NO_BOOTMEM)
Merging m68k/for-next (b2137956430d m68k: Use generic dma_noncoherent_ops)
Merging m68knommu/for-next (5c71cf45cabe m68knommu: Fix typos in Coldfire 5=
272 DMA debug code)
Merging microblaze/next (bd05a58ddfd7 microblaze: warn if of_iomap() failed)
Merging mips/mips-next (ddba595b7b24 mips: mm: Discard ioremap_uncached_acc=
elerated() method)
CONFLICT (content): Merge conflict in arch/mips/kernel/process.c
Merging nds32/next (987553894f0c nds32: fix build error "relocation truncat=
ed to fit: R_NDS32_25_PCREL_RELA" when make allyesconfig)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (ae15a41a6414 openrisc: entry: Fix delay slot exc=
eption detection)
Merging parisc-hd/for-next (ce397d215ccd Linux 4.18-rc1)
Merging powerpc/next (741c5640a15a powerpc/mpc5200: Remove VLA usage)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (021c91791a5e Linux 4.18-rc3)
Merging s390/features (6c8021503f72 s390/appldata: reuse generic proc handl=
er functions)
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (5ec9121195a4 um: Fix raw interface options)
Merging xtensa/xtensa-for-next (508d2b1d7e29 Merge branch 'xtensa-dma-fixes=
' into xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (fda94b4144b0 Merge branch 'for-next-next-v4.1=
9-20180702' into for-next-20180702)
Merging ceph/master (8b8f53af1ed9 ceph: fix dentry leak in splice_dentry())
Merging cifs/for-next (84d160f4af81 smb3: snapshot mounts are read-only and=
 make sure info is displayable about the mount)
Merging configfs/for-next (1823342a1f2b configfs: replace strncpy with memc=
py)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (6aee47d7f61e Pull in fsnotify cleanups from Amir and=
 new inotify IN_MASK_CREATE flag support.)
Merging ext4/dev (362eca70b533 ext4: fix inline data updates with checksums=
 enabled)
Merging f2fs/dev (9404821d165e f2fs: do checkpoint in kill_sb)
Merging fuse/for-next (44ce5c2e921f fs: fuse: Adding new return type vm_fau=
lt_t)
Merging jfs/jfs-next (bd646104ac5a jfs: use time64_t for otime)
Merging nfs/linux-next (7b0df92ac121 pNFS/flexfiles: Process writeback rese=
nds from nfsiod context as well)
Merging nfs-anna/linux-next (ffbfa2ce88f1 sunrpc: Fix latency trace point c=
rashes)
Merging nfsd/nfsd-next (8163496e78db nfsd: don't advertise a SCSI layout fo=
r an unsupported request_queue)
Merging orangefs/for-next (b1116bc03c00 orangefs: use sparse annotations fo=
r holding locks across function calls.)
Merging overlayfs/overlayfs-next (6137aef754d1 ovl: Enable metadata only fe=
ature)
Merging ubifs/linux-next (f5a926dd5298 mtd: ubi: Update ubi-media.h to dual=
 license)
Merging xfs/for-next (ad468f3e89e5 xfs: Initialize variables in xfs_alloc_g=
et_rec before using them)
Merging file-locks/locks-next (1cf8e5de4055 fs/lock: show locks taken by pr=
ocesses from another pidns)
Merging vfs/for-next (74aec0302234 Merge branches 'work.dcache', 'work.moun=
t', 'work.misc' and 'work.open' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in fs/open.c
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (7973c51853f8 Merge branch 'for-4.19-nmi' into for-=
next)
Merging pci/next (68def813a977 Merge branch 'pci/switchtec')
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (17e39f86b2ee Merge branch 'for-4.19/sony' into for-ne=
xt)
Merging i2c/i2c/for-next (5fa8578ef7cd Merge branch 'i2c/for-4.19' into i2c=
/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (f1fd4a4db777 hwmon: Add NPCM7xx PWM and F=
an driver)
Merging jc_docs/docs-next (6b4c1360e8ad Documentation: Add powerpc options =
for spec_store_bypass_disable)
Merging v4l-dvb/master (666e994aa227 media: platform: s5p-mfc: simplify get=
ting .drvdata)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (34db50e55656 efifb: Copy the ACPI BGRT boot g=
raphics to the framebuffer)
Merging pm/linux-next (e903c11a4c1e Merge branches 'pm-core' and 'pm-domain=
s' into linux-next)
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
Merging rdma/for-next (59b851dbf7dc RDMA/nes: Avoid complaints about unused=
 variables)
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
Merging net-next/master (db560d1612f8 selftests: forwarding: mirror_lib: Ti=
ghten up VLAN capture)
CONFLICT (content): Merge conflict in net/smc/smc_ib.c
CONFLICT (content): Merge conflict in net/sched/act_tunnel_key.c
CONFLICT (content): Merge conflict in net/sched/act_csum.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/aquantia/atlanti=
c/aq_hw.h
Merging bpf-next/master (671dffa7de7b Merge branch 'bpf-bpftool-improved-pr=
og-load')
Merging ipsec-next/master (e4db5b61c572 xfrm: policy: remove pcpu policy ca=
che)
Merging mlx5-next/mlx5-next (31e33a5b41bb net/mlx5: fix uaccess beyond "cou=
nt" in debugfs read/write handlers)
Merging netfilter-next/master (66c524acfb51 netfilter: conntrack: remove l3=
proto abstraction)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e523452ac0e0 netfilter: nf_tables: remove unused =
variables)
Merging wireless-drivers-next/master (4a07ed51cae1 mt76x2: debugfs: add sw =
pulse statistics to dfs debugfs)
Merging bluetooth/master (4d94f95d30c8 Bluetooth: Use extended LE Connectio=
n if supported)
Merging mac80211-next/master (518ea3c54eb7 mac80211_hwsim: Add support for =
HE)
Merging gfs2/for-next (f79caf101801 gfs2: use iomap_readpage for blocksize =
=3D=3D PAGE_SIZE)
CONFLICT (content): Merge conflict in include/linux/iomap.h
CONFLICT (content): Merge conflict in fs/iomap.c
Merging mtd/mtd/next (fb60e87dc4aa mtd: nftl: remove redundant variable nb_=
erases)
Merging nand/nand/next (8b23eadbe849 mtd: rawnand: hynix: Use ->exec_op() i=
n hynix_nand_reg_write_op())
Merging spi-nor/spi-nor/next (a3804084ddf0 mtd: spi-nor: stm32-quadspi: rep=
lace "%p" with "%pK")
Merging crypto/master (5c324a2ffa06 crypto: ccree - rate limit debug print)
Merging drm/drm-next (b861686b1853 Merge tag 'vmwgfx-next-4.19-3' of git://=
people.freedesktop.org/~thomash/linux into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (655250a8d1aa drm/i915/execlists: Switch t=
o rb_root_cached)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_irq.c
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (ae61f61fa802 drm/client: Fix: drm_client_n=
ew: Don't require DRM to be registered)
Merging drm-msm/msm-next (944e333cf9f8 drm/msm/mdp5: fix missing CTL flush)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (e368fc75c190 drm/arm/malidp: Added th=
e late system pm functions)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (518665524272 gpu: ipu-csi: Check for field ty=
pe alternate)
Merging etnaviv/etnaviv/next (f6ffbd4fc1a1 drm/etnaviv: replace license tex=
t with SPDX tags)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (adb14c491b45 Merge branch 'regmap-4.19' into regma=
p-next)
Merging sound/for-next (ff2d6acdf6f1 ALSA: pcm: Fix snd_interval_refine fir=
st/last with open min/max)
Merging sound-asoc/for-next (ec2057ad1331 Merge branch 'asoc-4.19' into aso=
c-next)
Merging modules/modules-next (4d58e7034d19 ARM: module: fix modsign build e=
rror)
Merging input/next (381a2c6fb9c5 Input: iforce - use GFP_KERNEL in iforce_g=
et_id_packet())
Merging block/for-next (1c63d42205cf Merge branch 'for-4.19/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (d284f8248c72 dm writecache: support optiona=
l offset for start of device)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (de37e0d43c5c Revert "mmc: sdhci-esdhc-imx: disable clocks=
 before changing frequency")
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (ebc7709f6500 md/r5cache: remove redundant pointer bio)
Merging mfd/for-mfd-next (94901112b48c mfd: ti_am335x_tscadc: Fix struct cl=
k memory leak)
Merging backlight/for-backlight-next (30000d80b506 backlight: Remove obsole=
te comment for ->state)
Merging battery/for-next (89b135ba1b73 power: supply: adp5061: Fix a couple=
 off by ones)
Merging regulator/for-next (561b172e8485 Merge branch 'regulator-4.19' into=
 regulator-next)
Merging security/next-testing (12aaa9cfc578 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (338d0be437ef apparmor: fix ptrace read chec=
k)
Merging integrity/next-integrity (ac14e8eb4890 evm: Allow non-SHA1 digital =
signatures)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (67b0b4e4988f selinux: Cleanup printk logging in netno=
de)
Merging tpmdd/next (5e19351a8ae3 ima: Get rid of ima_used_chip and use ima_=
tpm_chip !=3D NULL instead)
Merging watchdog/master (16a7eec2fcd0 watchdog: da9063: remove duplicated t=
imeout_to_sel calls)
Merging iommu/next (9494874609c3 Merge branches 'arm/shmobile', 'arm/renesa=
s', 'arm/msm', 'x86/amd', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (c1abca96b252 samples: mbochs: add DMA_SHARED_BUFFER depe=
ndency)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (c72051d5778a audit: use ktime_get_coarse_ts64() for tim=
e access)
Merging devicetree/for-next (11ca58727ee4 dt-bindings: sram: Add 'clocks' a=
s an optional property)
Merging mailbox/mailbox-for-next (f83d1cfc8bcd mailbox/drivers/hisi: Consol=
idate the Kconfig for the MAILBOX)
Merging spi/for-next (eaa05e87f641 Merge branch 'spi-4.19' into spi-next)
Merging tip/auto-latest (28233bc1ab7d Merge branch 'x86/timers')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6663484b4e2d EDAC, thunderx: Remove VLA usage)
Merging irqchip/irq/irqchip-next (6a88c221acba ARM: dts: stm32: Add exti su=
pport to stm32mp157 pinctrl)
Merging ftrace/for-next (a9235b544a0a ring-buffer: Fix typo in comment)
Merging rcu/rcu/next (bd917f682b45 Merge branches 'fixes1.2018.06.26a' and =
'torture1.2018.06.26a' into HEAD)
CONFLICT (content): Merge conflict in kernel/rcu/tree_plugin.h
Merging kvm/linux-next (6f0d349d922b Merge git://git.kernel.org/pub/scm/lin=
ux/kernel/git/davem/net)
Merging kvm-arm/next (e25028c8ded0 KVM: arm/arm64: Bump VGIC_V3_MAX_CPUS to=
 512)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (ce397d215ccd Linux 4.18-rc1)
Merging kvms390/next (2c8180e885c1 KVM: s390: vsie: simplify < 8k address c=
hecks)
Merging xen-tip/linux-next (eef04c7b3786 xen: Remove unnecessary BUG_ON fro=
m __unbind_from_irq())
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (66448bc274ca workqueue: move function definiti=
ons within CONFIG_SMP block)
Merging drivers-x86/for-next (eca4c4e47eb0 platform/x86: asus-wireless: Fix=
 uninitialized symbol usage)
Merging chrome-platform/for-next (40291fb75123 Merge tag 'ib-platform-chrom=
e-mfd-move-cros-ec-transport-for-4.19' into working-branch-for-4.19)
Merging hsi/for-next (ce397d215ccd Linux 4.18-rc1)
Merging leds/for-next (6f7b0bad8839 usb: simplify usbport trigger)
Merging ipmi/for-next (46f2277e45fe ipmi:dmi: Ignore IPMI SMBIOS entries wi=
th a zero base address)
Merging driver-core/driver-core-next (e01afc325025 PM / Domains: Stop defer=
ring probe at the end of initcall)
CONFLICT (content): Merge conflict in drivers/iommu/ipmmu-vmsa.c
Merging usb/usb-next (5f9810730cf4 usb: host: xhci-rcar: Add a condition ch=
eck about PLL active)
Merging usb-gadget/next (47265c067c0d usb: dwc2: gadget: Fix coverity issue)
Merging usb-serial/usb-next (3738c506657f USB: serial: clean up kl5kusb105 =
documentation)
Merging usb-chipidea-next/ci-for-usb-next (ba0ab35a81de usb: chipidea: tegr=
a: Use aligned DMA on Tegra114/124)
Merging phy-next/next (d5f5ee1a16a4 phy: berlin: switch to SPDX license ide=
ntifier)
Merging tty/tty-next (16777ecd1b54 kbd: complete dead keys definitions)
Merging char-misc/char-misc-next (37070d6c940e headers: fix linux/mod_devic=
etable.h inclusions)
Merging extcon/extcon-next (4391c78063e5 extcon: max3355: include mod_devic=
etable.h)
Merging staging/staging-next (d6ff1b52b569 staging: vt6655: remove some red=
undant variables)
CONFLICT (modify/delete): drivers/staging/skein/skein_generic.c deleted in =
staging/staging-next and modified in HEAD. Version HEAD of drivers/staging/=
skein/skein_generic.c left in tree.
$ git rm -f drivers/staging/skein/skein_generic.c
Merging mux/for-next (6a3d4baac84a mux: add mux_control_get_optional() API)
Merging slave-dma/next (443b3707bb46 Merge branch 'topic/intel' into next)
Merging cgroup/for-next (e4f8d81c738d cgroup/tracing: Move taking of spin l=
ock out of trace event handlers)
Merging scsi/for-next (8b1ff4bab168 Merge branch 'misc' into for-next)
CONFLICT (modify/delete): lib/percpu_ida.c deleted in scsi/for-next and mod=
ified in HEAD. Version HEAD of lib/percpu_ida.c left in tree.
CONFLICT (content): Merge conflict in MAINTAINERS
$ git rm -f lib/percpu_ida.c
Merging scsi-mkp/for-next (af8a6722fa39 scsi: remove NCR_Q720 driver)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (e6e26f1a1450 Merge branch 'for-4.19' into for-next)
Merging vhost/linux-next (2eb98105f8c7 virtio: update the comments for tran=
sport features)
Merging rpmsg/for-next (3d065621c921 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (be33610ac55f Merge branch 'devel' into for-next)
Merging pinctrl/for-next (6d0b2ac6ddb4 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (ce397d215ccd Linux 4.18-rc1)
Merging pwm/for-next (c99d64d83220 dt-bindings: pwm: fsl-ftm: Add compatibl=
e string for i.MX8QM)
Merging userns/for-next (04035aa33a12 proc: Don't change mount options on r=
emount failure.)
CONFLICT (content): Merge conflict in fs/proc/root.c
CONFLICT (content): Merge conflict in fs/proc/internal.h
CONFLICT (content): Merge conflict in fs/proc/inode.c
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (bfe80ed3d7c7 vsprintf: add command line option debug_bo=
ot_weak_hash)
Applying: random: fix up for revert of poll_mask changes
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (d2d49495b5c0 selftests: vDSO - fix to return KSFT_S=
KIP when test couldn't be run)
Merging y2038/y2038 (e264abeaf9da pstore: Remove bogus format string defini=
tion)
Merging livepatching/for-next (d7ab8e67aa52 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (1f0a504d39ae coresight: tpiu: Fix disabling timeout=
s)
Merging rtc/rtc-next (3cd7de001fb4 rtc: rtc-bq4802: add error handling for =
devm_ioremap)
Merging nvdimm/libnvdimm-for-next (7daf201d7fe8 Linux 4.18-rc2)
Merging at24/at24/for-next (ce397d215ccd Linux 4.18-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (8cbd32d7bdbd Merge branch 'for-next/usercopy' i=
nto for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging xarray/xarray (434621bde582 radix tree: Remove radix_tree_clear_tag=
s)
Merging fsi/master (fea9cf321c91 fsi: Move various master definitions to a =
common header)
Merging siox/siox/next (6334d7903723 siox: treat type errors as status erro=
rs)
Merging ida/ida (048d463bb481 ida: Convert to XArray)
Merging akpm-current/current (b7311f0e5e1b ipc/util.c: further ipc_idr_allo=
c() cleanups)
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
CONFLICT (content): Merge conflict in include/linux/bitops.h
CONFLICT (content): Merge conflict in drivers/ntb/hw/mscc/ntb_hw_switchtec.c
Applying: fixup for bit.h/bitops.h merge
$ git checkout -b akpm remotes/origin/akpm/master
Applying: drivers/hwtracing/intel_th/msu.c: change return type to vm_fault_t
Applying: fs/nfs/file.c: use new return type vm_fault_t
Applying: fs/afs: use new return type vm_fault_t
Applying: treewide: correct "differenciate" and "instanciate" typos
Applying: fs/proc/vmcore.c: hide vmcoredd_mmap_dumps() for nommu builds
Applying: locking/lockdep: dump state of percpu_rwsem upon hung up
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (946ac5a9c901 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/eDRy8yjzhPgYvatEPu=FlZg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltG+lMACgkQAVBC80lX
0GzyLQf/dFvhozB0DnT4YhT4bXKEWnqOACywjg9A1QZSMvUMiq7BSdOSnDITBu//
qQPv0LqK2CSZRDpIv5+cEVtl19Lt0MXTQruilLzoK1t1y+DPNbJLcZ/BzX6afKV3
BdQktm/2HoBNejP4gw3/uw2P0y95XE3X9rgc6SfypCD9fCD+7FSmwGzi2hyDXTRL
GnEUneQ0ITKwhGjI5w62ar9Z8Tmty7sfLmrDbqs6veGFNN6nHgNaSe3DTWpq9Y1F
hBEGRILviev+DE+BP2sDiJENvKhcdcqsGER2jp6HzAHUxE/f6NzNChd3VgsuxAW7
RvRSwbGM09Ifc+8v2im68w2LMTcK3Q==
=MQdt
-----END PGP SIGNATURE-----

--Sig_/eDRy8yjzhPgYvatEPu=FlZg--
