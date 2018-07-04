Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B216C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7F8244C1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 05:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tUcg6nwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA7F8244C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932779AbeGDF54 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 01:57:56 -0400
Received: from ozlabs.org ([203.11.71.1]:53997 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752990AbeGDF5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 01:57:52 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41L9JG63NXz9s4c;
        Wed,  4 Jul 2018 15:57:50 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530683870;
        bh=2vwSCx/emKd6cE44ZcMCNndCpibHXhJGsrt5SiGeKnE=;
        h=Date:From:To:Cc:Subject:From;
        b=tUcg6nwtyiZM6l3yj2R7cUez6EVfrpto67IfB8XCJ1J2gMXsz6C8277CK97010FVi
         YmqszMbEKgLkAU37xumFxodXqI2Fiwzky2b6UySqo08Va6gf4P5y5zvks3zYQHa0Ov
         BJ3aYLsvSPIVrf1ooLoamQnbhcuLjRaYp6mfa0L0Ze9X5WFhgRj41HilQ/EesvwIiZ
         AoAURjaHMtOoRuUfOssDylEOf66Zbvj6gBR1wNW+MmNmMfpESi6/G+RLEQSFmvHfe5
         RnM6qJvUDaqS+F5Z83y9zqMRFfsijkyUHaP1jCCGwHXLR3nQOacyHfc8K0uKBXLPEy
         NQkIjLO0C+2iw==
Date:   Wed, 4 Jul 2018 15:57:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jul 4
Message-ID: <20180704155749.1abc3a03@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OXkCoTj=6ia8viic_+d/+Dp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OXkCoTj=6ia8viic_+d/+Dp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180703:

The net-next tree lost its build failure.

The akpm-current tree lost its build failure.

Non-merge commits (relative to Linus' tree): 3555
 3796 files changed, 134005 insertions(+), 74047 deletions(-)

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

I am currently merging 282 trees (counting Linus' and 65 trees of bug
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
Merging origin/master (410da1e12ffe net/smc: fix up merge error with poll c=
hanges)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (021c91791a5e Linux 4.18-rc3)
Merging arc-current/for-curr (3d561d86e99f ARC: Enable CONFIG_SWAP)
Merging arm-current/fixes (92d44a42af81 ARM: fix kill( ,SIGFPE) breakage)
Merging arm64-fixes/for-next/fixes (24fe1b0efad4 arm64: Remove unnecessary =
ISBs from set_{pte,pmd,pud})
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (22db552b50fa powerpc/powermac: Fix rtc read/wr=
ite functions)
Merging sparc/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel=
.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (248c690a2dc8 Merge tag 'wireless-drivers-for-davem-2018=
-07-03' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-dri=
vers)
Merging bpf/master (ed2b82c03dc1 bpf: hash map: decrement counter on error)
Merging ipsec/master (7284fdf39a91 esp6: fix memleak on error path in esp6_=
input)
Merging netfilter/master (24ac3a08e658 net/smc: rebuild nonblocking connect)
Merging ipvs/master (312564269535 net: netsec: reduce DMA mask to 40 bits)
Merging wireless-drivers/master (248c690a2dc8 Merge tag 'wireless-drivers-f=
or-davem-2018-07-03' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo=
/wireless-drivers)
Merging mac80211/master (19103a4bfb42 mac80211: add stations tied to AP_VLA=
Ns during hw reconfig)
Merging rdma-fixes/for-rc (b697d7d8c741 IB/hfi1: Fix incorrect mixing of ER=
R_PTR and NULL return values)
Merging sound-current/for-linus (aaa23f86001b ALSA: hda - Handle pm failure=
 during hotplug)
Merging sound-asoc-fixes/for-linus (16a27dd8d9e3 Merge branch 'asoc-4.18' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (7daf201d7fe8 Linux 4.18-rc2)
Merging regulator-fixes/for-linus (69e00058b86c Merge branch 'regulator-4.1=
8' into regulator-linus)
Merging spi-fixes/for-linus (d28cbf8dcb01 Merge branch 'spi-4.18' into spi-=
linus)
Merging pci-current/for-linus (83235822b8b4 nfp: stop limiting VFs to 0)
Merging driver-core.current/driver-core-linus (7daf201d7fe8 Linux 4.18-rc2)
Merging tty.current/tty-linus (021c91791a5e Linux 4.18-rc3)
Merging usb.current/usb-linus (b3a653288e1a i2c-cht-wc: Fix bq24190 supplie=
r)
Merging usb-gadget-fixes/fixes (1d8e5c002758 dwc2: gadget: Fix ISOC IN DDMA=
 PID bitfield value calculation)
Merging usb-serial-fixes/usb-linus (021c91791a5e Linux 4.18-rc3)
Merging usb-chipidea-fixes/ci-for-usb-stable (90f26cc6bb90 usb: chipidea: h=
ost: fix disconnection detect issue)
Merging phy/fixes (ad5003300b07 phy: mapphone-mdm6600: Fix wrong enum used =
for status lines)
Merging staging.current/staging-linus (920c92448839 staging: rtl8723bs: Pre=
vent an underflow in rtw_check_beacon_data().)
Merging char-misc.current/char-misc-linus (b7a020bff313 mei: discard messag=
es from not connected client during power down.)
Merging input-current/for-linus (03ae3a9caf4a Input: psmouse - fix button r=
eporting for basic protocols)
Merging crypto-current/master (221e00d1fce9 crypto: x86 - Add missing RETs)
Merging ide/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/abelloni/linux)
Merging vfio-fixes/for-linus (bb94b55af346 vfio: Use get_user_pages_longter=
m correctly)
Merging kselftest-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (c4c2b7644cc9 dmaengine: k3dma: Off by one in=
 k3_of_dma_simple_xlate())
Merging backlight-fixes/for-backlight-fixes (ce397d215ccd Linux 4.18-rc1)
Merging mtd-fixes/master (021c91791a5e Linux 4.18-rc3)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (11799564fc7e mfd: cros_ec: Retry commands =
when EC is known to be busy)
Merging v4l-dvb-fixes/fixes (0ca54b290541 media: rc: be less noisy when dri=
ver misbehaves)
Merging reset-fixes/reset/fixes (e6914365fd28 reset: uniphier: fix USB cloc=
k line for LD20)
Merging mips-fixes/mips-fixes (b63e132b6433 MIPS: Use async IPIs for arch_t=
rigger_cpumask_backtrace())
Merging omap-fixes/fixes (41bd6adf3c5d Revert "ARM: dts: logicpd-som-lv: Fi=
x pinmux controller references")
Merging kvm-fixes/master (6f0d349d922b Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/davem/net)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (7daf201d7fe8 Linux 4.18-rc2)
Merging nvdimm-fixes/libnvdimm-fixes (75bc37fefc44 Linux 4.17-rc4)
Merging btrfs-fixes/next-fixes (cf63fc9616bc Merge branch 'for-next-current=
-v4.18-20180702' into next-fixes)
Merging vfs-fixes/fixes (877f919e192a proc: add proc_seq_release)
Merging dma-mapping-fixes/for-linus (210d0797c97d swiotlb: export swiotlb_d=
ma_ops)
Merging drivers-x86-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging samsung-krzk-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (ce397d215ccd Linux 4.18-rc1)
Merging devicetree-fixes/dt/linus (a47c9b394316 dt-bindings: Fix unbalanced=
 quotation marks)
Merging scsi-fixes/fixes (26b5b874aff5 scsi: sg: mitigate read/write abuse)
Merging drm-fixes/drm-fixes (2d8aa4ef6aac Merge tag 'drm-misc-fixes-2018-06=
-28' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (3030deda0971 Merge tag 'gvt-f=
ixes-2018-07-03' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (7a6b9f4d601d mmc: dw_mmc: fix card threshold contr=
ol configuration)
Merging rtc-fixes/rtc-fixes (ca95ef7c9867 rtc: mrst: fix error code in prob=
e())
Merging drm-misc-fixes/for-linux-next-fixes (718b5406cd76 drm: Use kvzalloc=
 for allocating blob property memory)
Merging kbuild/for-next (8f242becdd9b Merge branch 'kconfig' into for-next)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (2550bbfd4952 dma-direct: don't crash on devic=
e without dma_mask)
Merging asm-generic/master (a71e7c44ffb7 io: change writeX_relaxed() to rem=
ove barriers)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (0ac000e86703 Merge branches 'fixes', 'misc' and 'spec=
tre' into for-linus)
Merging arm-perf/for-next/perf (1201a5a25cf0 perf/arm-cci: Remove VLA usage)
Merging arm-soc/for-next (0356e1670571 Merge branch 'fixes' into for-next)
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
Merging imx-mxs/for-next (24973f755f94 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (43d473dce2e7 Merge branch 'for_4.19/keystone-config'=
 into next)
Merging mediatek/for-next (9378b3427341 Merge branch 'v4.17-next/soc' into =
for-next)
Merging mvebu/for-next (674c3754561e Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (6f56a58a2ed1 Merge branch 'omap-for-v4.19/soc' into =
for-next)
Merging reset/reset/next (d7bab65b1f57 reset: uniphier: add LD11/LD20 strea=
m demux system reset control)
Merging qcom/for-next (376e1f304fc7 firmware: qcom: scm: add a dummy qcom_s=
cm_assign_mem())
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (6d67c566bc94 Merge branches 'arm-soc-for-v4.19', 'arm=
-dt-for-v4.19', 'arm64-dt-for-v4.19' and 'dt-bindings-for-v4.19' into next)
Merging rockchip/for-next (b12b0bd0db32 Merge branch 'v4.18-armsoc/dts32-fi=
xes' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (29de814e31dd Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (17a81b4cc149 Merge branch 'sunxi/dt-for-4.19'=
, remote-tracking branches 'korg/sunxi/sunxi/clk-for-4.19', 'korg/sunxi/sun=
xi/drivers-for-4.19' and 'korg/sunxi/sunxi/dt64-for-4.19' into sunxi/for-ne=
xt)
Merging tegra/for-next (83fbebec33c3 Merge branch for-4.19/arm64/dt into fo=
r-next)
Merging arm64/for-next/core (0fe42512b2f0 arm64: Fix syscall restarting aro=
und signal suppressed by tracer)
Merging clk/clk-next (cf5777d93281 Merge branch 'clk-imx6-video-parent' int=
o clk-next)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (85fa2cc51104 c6x: pass endianness info to spars=
e)
Merging m68k/for-next (b2137956430d m68k: Use generic dma_noncoherent_ops)
Merging m68knommu/for-next (109f5e551b18 m68knommu: Fix typos in Coldfire 5=
272 DMA debug code)
Merging microblaze/next (45df561a7ae2 microblaze: consolidate GPIO reset ha=
ndling)
Merging mips/mips-next (6b5939d2e528 MIPS: AR7: Normalize clk API)
CONFLICT (content): Merge conflict in arch/mips/kernel/process.c
Merging nds32/next (a78945c357f5 nds32: Fix build error caused by configura=
tion flag rename)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (ae15a41a6414 openrisc: entry: Fix delay slot exc=
eption detection)
Merging parisc-hd/for-next (ce397d215ccd Linux 4.18-rc1)
Merging powerpc/next (ff5bc793e47b powerpc/64s/radix: Fix missing ptesync i=
n flush_cache_vmap)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (7daf201d7fe8 Linux 4.18-rc2)
Merging s390/features (d053d639f00c s390/tools: fix gcc 8 stringop-truncati=
on warnings)
Merging sparc-next/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (5ec9121195a4 um: Fix raw interface options)
Merging xtensa/xtensa-for-next (ae6063c83634 Merge branch 'xtensa-fixes' in=
to xtensa-for-next)
Merging fscrypt/master (e1cc40e5d42a fscrypt: log the crypto algorithm impl=
ementations)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (fda94b4144b0 Merge branch 'for-next-next-v4.1=
9-20180702' into for-next-20180702)
Merging ceph/master (8b8f53af1ed9 ceph: fix dentry leak in splice_dentry())
Merging cifs/for-next (57ee2f5a1022 smb3: remove noisy warning message on m=
ount)
Merging configfs/for-next (1823342a1f2b configfs: replace strncpy with memc=
py)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (6aee47d7f61e Pull in fsnotify cleanups from Amir and=
 new inotify IN_MASK_CREATE flag support.)
Merging ext4/dev (275413a010bb ext4: check superblock mapped prior to commi=
tting)
Merging f2fs/dev (f57494321cbf Merge tag 'xfs-4.18-fixes-2' of git://git.ke=
rnel.org/pub/scm/fs/xfs/xfs-linux)
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
Merging overlayfs/overlayfs-next (46311f3ec53c ovl: Enable metadata only fe=
ature)
Merging ubifs/linux-next (f5a926dd5298 mtd: ubi: Update ubi-media.h to dual=
 license)
Merging xfs/for-next (d8cb5e423789 xfs: fix fdblocks accounting w/ RMAPBT p=
er-AG reservation)
Merging file-locks/locks-next (1cf8e5de4055 fs/lock: show locks taken by pr=
ocesses from another pidns)
Merging vfs/for-next (6c06e521993d Merge branch 'fixes' into for-next)
CONFLICT (content): Merge conflict in include/linux/fs.h
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (ce041c43f222 lib/test_printf.c: accept "ptrval" as=
 valid result for plain 'p' tests)
Merging pci/next (ce397d215ccd Linux 4.18-rc1)
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (0bd89960cb03 Merge branch 'for-4.18/upstream-fixes_v2=
' into for-next)
Merging i2c/i2c/for-next (5fa8578ef7cd Merge branch 'i2c/for-4.19' into i2c=
/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (31428d33634d hwmon: (mlxreg-fan) Add supp=
ort for Mellanox FAN driver)
Merging jc_docs/docs-next (ea272257ccba docs: histogram.txt: convert it to =
ReST file format)
Merging v4l-dvb/master (3c4a737267e8 media: ov5640: fix frame interval enum=
eration)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (34db50e55656 efifb: Copy the ACPI BGRT boot g=
raphics to the framebuffer)
Merging pm/linux-next (703d2063afb7 Merge branch 'acpi-tables' into linux-n=
ext)
Merging cpupower/cpupower (ce397d215ccd Linux 4.18-rc1)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (c5c2a97b3ac7 PM / OPP: Update voltage in case f=
req =3D=3D old_freq)
Merging thermal/next (e9ed3ee61aa6 Merge branches 'thermal-core' and 'therm=
al-intel' into next)
Merging thermal-soc/next (632e92f49e89 thermal: armada: average over sample=
s to avoid glitches)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (1c77483e4c50 IB: Improve uverbs_cleanup_ucontext alg=
orithm)
CONFLICT (content): Merge conflict in drivers/infiniband/core/uverbs_cmd.c
Merging net-next/master (44a4c4698ee8 Merge branch 'aquantia-various-ethtoo=
l-ops-implementation')
CONFLICT (content): Merge conflict in net/smc/smc_ib.c
Merging bpf-next/master (0b9e3d543f9f Merge branch 'bpf-bpftool-libbpf-impr=
ovements')
Merging ipsec-next/master (e4db5b61c572 xfrm: policy: remove pcpu policy ca=
che)
Merging mlx5-next/mlx5-next (b30408d7a383 net/mlx5: Rate limit errors in co=
mmand interface)
Merging netfilter-next/master (c37979958e08 openvswitch: use nf_ct_get_tupl=
epr, invert_tuplepr)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e523452ac0e0 netfilter: nf_tables: remove unused =
variables)
Merging wireless-drivers-next/master (c3ae2103e069 mt76: improve gain adjus=
tment in noisy environments)
Merging bluetooth/master (1a84d7fdb5fc Merge branch 'mlxsw-Add-resource-sca=
le-tests')
Merging mac80211-next/master (1a84d7fdb5fc Merge branch 'mlxsw-Add-resource=
-scale-tests')
Merging gfs2/for-next (42c59abaeb37 fs: gfs2: Adding new return type vm_fau=
lt_t)
Merging mtd/mtd/next (7a1f1b594a3d mtd: replace VMLINUX_SYMBOL_STR() with s=
tring literal)
Merging nand/nand/next (862f3dd9d300 mtd: rawnand: denali: optimize timing =
parameters for data interface)
Merging spi-nor/spi-nor/next (9882b5375df5 mtd: m25p80: Use SPI_MEM_OP_NO_D=
UMMY instead of SPI_MEM_OP_DUMMY(0, x))
Merging crypto/master (e4e4730698c9 crypto: skcipher - remove the exporting=
 of skcipher_walk_next)
Merging drm/drm-next (eab976693153 Merge tag 'drm-misc-next-2018-06-27' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_lrc.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_crt.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem.c
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (a608987970b9 drm/i915: Wait for PSR exit =
before checking for vblank evasion)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (a1de8d0a7e2c drm/i810: off by one in i810_=
dma_vertex())
Merging drm-msm/msm-next (944e333cf9f8 drm/msm/mdp5: fix missing CTL flush)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances o=
f drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (6e810eb508f4 drm: mali-dp: Add YUV->R=
GB conversion support for video layers)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/dr=
m-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (518665524272 gpu: ipu-csi: Check for field ty=
pe alternate)
Merging etnaviv/etnaviv/next (f6ffbd4fc1a1 drm/etnaviv: replace license tex=
t with SPDX tags)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (7daf201d7fe8 Linux 4.18-rc2)
Merging sound/for-next (1259d239799b ALSA: usb-midi: use irqsave() in USB's=
 complete callback)
Merging sound-asoc/for-next (97312de5bfcb Merge branch 'asoc-4.19' into aso=
c-next)
Merging modules/modules-next (f314dfea16a0 modsign: log module name in the =
event of an error)
Merging input/next (3a658f23fb68 Input: add bu21029 touch driver)
Merging block/for-next (28313cee1d4f Merge branch 'for-4.18/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (d284f8248c72 dm writecache: support optiona=
l offset for start of device)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (29c2f0784c81 Merge branch 'fixes' into next)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (bda3153998f3 md/raid10: fix that replacement cannot co=
mplete recovery after reassemble)
Merging mfd/for-mfd-next (556c242045f0 mfd: cros_ec: Remove unused __remove=
 function)
Merging backlight/for-backlight-next (980d7812fdb4 dt-bindings: pwm-backlig=
ht: Move brightness-levels to optional.)
Merging battery/for-next (ce397d215ccd Linux 4.18-rc1)
Merging regulator/for-next (be5c29e6f431 Merge branch 'regulator-4.19' into=
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
Merging tpmdd/next (bfbe1078d276 tpm: Convert tpm_find_get_ops() to use tpm=
_default_chip())
Merging watchdog/master (16a7eec2fcd0 watchdog: da9063: remove duplicated t=
imeout_to_sel calls)
Merging iommu/next (1f568357117c Merge branches 'arm/io-pgtable', 'arm/qcom=
', 'arm/tegra', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (c1abca96b252 samples: mbochs: add DMA_SHARED_BUFFER depe=
ndency)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (c72051d5778a audit: use ktime_get_coarse_ts64() for tim=
e access)
Merging devicetree/for-next (f1f517b8f555 dt-bindings: gpio: pca953x: Docum=
ent interrupts, update example)
Merging mailbox/mailbox-for-next (f83d1cfc8bcd mailbox/drivers/hisi: Consol=
idate the Kconfig for the MAILBOX)
Merging spi/for-next (dd24a748f625 Merge branch 'spi-4.19' into spi-next)
Merging tip/auto-latest (72d1fd086cbf Merge branch 'x86/hyperv')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (6c974d4dfafe EDAC, i7core: Fix memleaks and use-=
after-free on probe and remove)
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
Merging drivers-x86/for-next (4cf2afd6ef0d platform/x86: intel_pmc_core: Ad=
d CNP SLPS0 debug registers)
Merging chrome-platform/for-next (c474e9f2be99 platform/chrome: chromeos_tb=
mc - fix SPDX identifier)
Merging hsi/for-next (ce397d215ccd Linux 4.18-rc1)
Merging leds/for-next (07abd4325e70 leds: lm3692x: Support LED sync configu=
ration)
Merging ipmi/for-next (46f2277e45fe ipmi:dmi: Ignore IPMI SMBIOS entries wi=
th a zero base address)
Merging driver-core/driver-core-next (7daf201d7fe8 Linux 4.18-rc2)
Merging usb/usb-next (399111aaa7b9 USB: typec: fsusb302: Drop empty set_cur=
rent_limit implementation)
Merging usb-gadget/next (47265c067c0d usb: dwc2: gadget: Fix coverity issue)
Merging usb-serial/usb-next (1d1de580a3e0 USB: serial: digi_acceleport: ren=
ame tty flag variable)
Merging usb-chipidea-next/ci-for-usb-next (ba0ab35a81de usb: chipidea: tegr=
a: Use aligned DMA on Tegra114/124)
Merging phy-next/next (ce397d215ccd Linux 4.18-rc1)
Merging tty/tty-next (16ecf49c10a1 Merge 4.18-rc3 into tty-next)
Merging char-misc/char-misc-next (10f146639fee gnss: add receiver type supp=
ort)
Merging extcon/extcon-next (441492c2256c extcon: Release locking when sendi=
ng the notification of connector state)
Merging staging/staging-next (0d7fa8fa9cbc staging: fbtft: indent fbtft_dev=
ice_display - last entry - pdev - dev)
Merging mux/for-next (6a3d4baac84a mux: add mux_control_get_optional() API)
Merging slave-dma/next (a11fac98a173 Merge branch 'topic/fsl' into next)
Merging cgroup/for-next (d8742e229021 cgroup: css_set_lock should nest insi=
de tasklist_lock)
Merging scsi/for-next (dc047dc7c64f Merge branch 'misc' into for-next)
CONFLICT (modify/delete): lib/percpu_ida.c deleted in scsi/for-next and mod=
ified in HEAD. Version HEAD of lib/percpu_ida.c left in tree.
$ git rm -f lib/percpu_ida.c
Merging scsi-mkp/for-next (e936a38ac92d scsi: target: Remove se_dev_entry.u=
a_count)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (30f3cc35787d Merge branch 'for-4.18-fixes' into fo=
r-next)
Merging vhost/linux-next (2eb98105f8c7 virtio: update the comments for tran=
sport features)
Merging rpmsg/for-next (a39440457e24 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (244bd2000066 Merge branch 'devel' into for-next)
Merging pinctrl/for-next (14a5de9d9436 Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (ce397d215ccd Linux 4.18-rc1)
Merging pwm/for-next (414c52b7899a pwm: stm32: Fix build warning with CONFI=
G_DMA_ENGINE disabled)
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
Merging kselftest/next (eb83d5f7d07e selftests: sparc64: Add missing SPDX L=
icense Identifiers)
Merging y2038/y2038 (e264abeaf9da pstore: Remove bogus format string defini=
tion)
Merging livepatching/for-next (d7ab8e67aa52 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (2f21e5073887 coresight: catu: Plug in CATU as a bac=
kend for ETR buffer)
Merging rtc/rtc-next (3cd7de001fb4 rtc: rtc-bq4802: add error handling for =
devm_ioremap)
Merging nvdimm/libnvdimm-for-next (7daf201d7fe8 Linux 4.18-rc2)
Merging at24/at24/for-next (ce397d215ccd Linux 4.18-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (8cbd32d7bdbd Merge branch 'for-next/usercopy' i=
nto for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (ce397d215ccd Linux 4.18-rc1)
Merging xarray/xarray (66e0b8e41bb5 radix tree: Remove radix_tree_clear_tag=
s)
Merging fsi/master (6b293258cded fsi: scom: Major overhaul)
Merging siox/siox/next (6334d7903723 siox: treat type errors as status erro=
rs)
Merging akpm-current/current (94ced11d8f0c bfs: add sanity check at bfs_fil=
l_super())
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: drivers/hwtracing/intel_th/msu.c: change return type to vm_fault_t
Applying: fs/nfs/file.c: use new return type vm_fault_t
Applying: fs/afs: use new return type vm_fault_t
Applying: treewide: correct "differenciate" and "instanciate" typos
Applying: fs/proc/vmcore.c: hide vmcoredd_mmap_dumps() for nommu builds
Applying: kernel/kexec_file.c: add walk_system_ram_res_rev()
Applying: kernel/kexec_file.c: load kernel at top of system RAM if required
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (908286695937 sparc64: NG4 memset 32 bits overflow)

--Sig_/OXkCoTj=6ia8viic_+d/+Dp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls8Yd0ACgkQAVBC80lX
0Gx6vQgAnzufZ3PYbK9ehHs+e3nUXC5XmARb2yvmAowIHTfrFPb4s5bhbe3RBx8O
sd1i8LZiHlNo/Yqds8qMixS/AGtrHML6BTR8TPseSGDviJrGD4o+avM3ALqfj4ev
nuUErOMG3iOwRwhpg3g7LyWApDQc1M886hz8StY2Z/8pZtP976JBpH6Q5Kx1grN0
9KwcdHSJWBuEzkDm2pg3+fn7WLVhVvxCJzqHqOmYCWrTj+y7+c4IxPw1He7ycUm0
TH9O0gjZmeutWDqdAVet+ThzXZQr5zIInWoXPDbzyPfGvbprmPVXM2TmAwj5ohpA
ciYNOxcu/8kkd9z8TzdmnKPjpx49dA==
=TZMI
-----END PGP SIGNATURE-----

--Sig_/OXkCoTj=6ia8viic_+d/+Dp--
