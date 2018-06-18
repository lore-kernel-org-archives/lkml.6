Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971E4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BB020864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="CsgeWLgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BB020864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754588AbeFREtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:49:03 -0400
Received: from ozlabs.org ([203.11.71.1]:43309 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754496AbeFREs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:48:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 418JX6620Cz9ry1;
        Mon, 18 Jun 2018 14:48:54 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1529297334;
        bh=gX7L+u/OvpyF5LaZdYZP3jq1CHWPXUPxySyUSL2uoCw=;
        h=Date:From:To:Cc:Subject:From;
        b=CsgeWLgTM7OhHpAPHWrebv6aHHiOzeqy0iblZ4+fdUMZZER1S6efvBdRLJmerHLJL
         5ttscYy6Ro6g85zBZ3V5GDpPn+KdCPO6x2jrbyPwE/NGVd9IvA4v6M9X+RfedwuIAn
         Z8JLZrrF3OJlzkAsnJYaJSpER4Nz+w4HL/WAKDcLINvwBdyEyGPAIX6Ikg3bUuDvSA
         AsopfuJLoOUiqceRZl76yHjAA4k3A+p9G6J6i5abWHGlRpGMFsDxp7YkwZ80lZIOQc
         egPsh3fe7NrpnzTeIWzqH4vM32P2CwtU+ShxHN7HAn/QUAWBg2NJK8XNhWif7/LwV3
         Yn5DkWogannPQ==
Date:   Mon, 18 Jun 2018 14:48:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jun 18
Message-ID: <20180618144854.50185f58@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4/9JneE3NBy2CiWcs+xovI2"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4/9JneE3NBy2CiWcs+xovI2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20180615:

Added trees: xarray, mlx5-next
Removed tree: powerpc-pkey (finished with)

The mac80211-next tree gained a conflict against Linus' tree.

The xarray tree gained a build failure due to an interaction with the
nvdimm tree for which I applied a fix.

Non-merge commits (relative to Linus' tree): 744
 631 files changed, 17646 insertions(+), 10549 deletions(-)

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

I am currently merging 279 trees (counting Linus' and 64 trees of bug
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
Merging origin/master (ce397d215ccd Linux 4.18-rc1)
Merging fixes/master (147a89bc71e7 Merge tag 'kconfig-v4.17' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging kbuild-current/fixes (ce397d215ccd Linux 4.18-rc1)
Merging arc-current/for-curr (e6c62399504c ARCv2: support manual regfile sa=
ve on interrupts)
Merging arm-current/fixes (92d44a42af81 ARM: fix kill( ,SIGFPE) breakage)
Merging arm64-fixes/for-next/fixes (82034c23fcbc arm64: Make sure permissio=
n updates happen for pmd/pud)
Merging m68k-current/for-linus (b12c8a70643f m68k: Set default dma mask for=
 platform devices)
Merging powerpc-fixes/fixes (faf37c44a105 powerpc/64s: Clear PCR on boot)
Merging sparc/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel=
.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (7e85dc8cb35a net_sched: blackhole: tell upper qdisc abo=
ut dropped packets)
Merging bpf/master (6d5fc1957989 xdp: Fix handling of devmap in generic XDP)
Merging ipsec/master (d6990976af7c vti6: fix PMTU caching and reporting on =
xmit)
Merging netfilter/master (60d061e34703 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/pablo/nf)
Merging ipvs/master (312564269535 net: netsec: reduce DMA mask to 40 bits)
Merging wireless-drivers/master (ab1068d6866e iwlwifi: pcie: compare with n=
umber of IRQs requested for, not number of CPUs)
Merging mac80211/master (bf2b61a6838f cfg80211: fix rcu in cfg80211_unregis=
ter_wdev)
Merging rdma-fixes/for-rc (1eb9364ce81d IB/uverbs: Fix ordering of ucontext=
 check in ib_uverbs_write)
Merging sound-current/for-linus (a57a46b93244 ALSA: hda/ca0132: Fix DMic da=
ta rate for Alienware M17x R4)
Merging sound-asoc-fixes/for-linus (2858e2cfc2ef Merge branch 'asoc-4.17' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (97fe106a8027 Merge branch 'regmap-4.17' int=
o regmap-linus)
Merging regulator-fixes/for-linus (59ce5f3e5530 Merge branch 'regulator-4.1=
7' into regulator-linus)
Merging spi-fixes/for-linus (5d3257b8ea48 Merge branch 'spi-4.17' into spi-=
linus)
Merging pci-current/for-linus (0cf22d6b317c PCI: Add "PCIe" to pcie_print_l=
ink_status() messages)
Merging driver-core.current/driver-core-linus (ce397d215ccd Linux 4.18-rc1)
Merging tty.current/tty-linus (ce397d215ccd Linux 4.18-rc1)
Merging usb.current/usb-linus (ce397d215ccd Linux 4.18-rc1)
Merging usb-gadget-fixes/fixes (29dcea88779c Linux 4.17)
Merging usb-serial-fixes/usb-linus (75bc37fefc44 Linux 4.17-rc4)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: m=
sm: fix ulpi-node lookup)
Merging phy/fixes (60cc43fc8884 Linux 4.17-rc1)
Merging staging.current/staging-linus (ce397d215ccd Linux 4.18-rc1)
Merging char-misc.current/char-misc-linus (ce397d215ccd Linux 4.18-rc1)
Merging input-current/for-linus (01f7e67a053f Merge branch 'next' into for-=
linus)
Merging crypto-current/master (837bf7cc3b75 hwrng: core - Always drop the R=
NG in hwrng_unregister())
Merging ide/master (1aaccb5fa0ea Merge tag 'rtc-4.18' of git://git.kernel.o=
rg/pub/scm/linux/kernel/git/abelloni/linux)
Merging vfio-fixes/for-linus (89c29def6b01 Revert "vfio/type1: Improve memo=
ry pinning process for raw PFN mapping")
Merging kselftest-fixes/fixes (75bc37fefc44 Linux 4.17-rc4)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (ce397d215ccd Linux 4.18-rc1)
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711=
_bl: fix device-tree node leaks)
Merging mtd-fixes/master (ce397d215ccd Linux 4.18-rc1)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode =
check)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (11799564fc7e mfd: cros_ec: Retry commands =
when EC is known to be busy)
Merging v4l-dvb-fixes/fixes (e88f5e9ebd54 media: uvcvideo: Prevent setting =
unavailable flags)
Merging reset-fixes/reset/fixes (e6914365fd28 reset: uniphier: fix USB cloc=
k line for LD20)
Merging mips-fixes/mips-fixes (a157fb736dd1 MIPS: BCM47XX: Enable 74K Core =
ExternalSync for PCIe erratum)
Merging omap-fixes/fixes (41bd6adf3c5d Revert "ARM: dts: logicpd-som-lv: Fi=
x pinmux controller references")
Merging kvm-fixes/master (696ca779a928 KVM: x86: fix #UD address of failed =
Hyper-V hypercalls)
Merging kvms390-fixes/master (f4a551b72358 KVM: s390: vsie: fix < 8k check =
for the itdba)
Merging hwmon-fixes/hwmon (91bb8f45f73f hwmon: (nct6775) Fix loop limit)
Merging nvdimm-fixes/libnvdimm-fixes (75bc37fefc44 Linux 4.17-rc4)
Merging btrfs-fixes/next-fixes (3a7e0e2622f6 Merge branch 'misc-4.18' into =
next-fixes)
Merging vfs-fixes/fixes (b1b94fcbd399 Revert "fs: fold open_check_o_direct =
into do_dentry_open")
Merging dma-mapping-fixes/for-linus (cf65a0f6f6ff dma-mapping: move all DMA=
 mapping code to kernel/dma)
Merging drivers-x86-fixes/fixes (32ffd6e8d1f6 platform/x86: asus-wmi: Fix N=
ULL pointer dereference)
Merging samsung-krzk-fixes/fixes (60cc43fc8884 Linux 4.17-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (60cc43fc8884 Linux 4.17-rc1)
Merging devicetree-fixes/dt/linus (737dd8e1a4c4 Documentation: devicetree: =
tilcdc: fix spelling mistake "suppors" -> "supports")
Merging scsi-fixes/fixes (e6d1dd048cd4 scsi: qla2xxx: Spinlock recursion in=
 qla_target)
Merging drm-intel-fixes/for-linux-next-fixes (65b3bdc807ac drm/i915/query: =
nospec expects no more than an unsigned long)
Merging mmc-fixes/fixes (3de06d5a1f05 mmc: sdhci-iproc: add SDHCI_QUIRK2_HO=
ST_OFF_CARD_ON for cygnus)
Merging rtc-fixes/rtc-fixes (60cc43fc8884 Linux 4.17-rc1)
Merging drm-misc-fixes/for-linux-next-fixes (9fcf2b3c1c02 drm/atmel-hlcdc: =
check stride values in the first plane)
Merging kbuild/for-next (ce397d215ccd Linux 4.18-rc1)
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
Merging arm-perf/for-next/perf (73acc0315cd7 ARM: mcpm, perf/arm-cci: expor=
t mcpm_is_available)
Merging arm-soc/for-next (c7953e19db50 ARM: Document merges)
Merging actions/for-next (35afadd11222 Merge branch 'v4.19/drivers' into ne=
xt)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (793d8ab66802 Merge branch 'v4.18/defconfig' into =
tmp/aml-rebuild)
Merging aspeed/for-next (6534b2d0de36 Merge branch 'dt-for-v4.17' into for-=
next)
Merging at91/at91-next (20d3f36b0fea Merge tag 'at91-ab-4.17-dt2' into at91=
-next)
Merging bcm2835/for-next (5c483a0c319c Merge branch anholt/bcm2835-defconfi=
g-64-next into for-next)
Merging imx-mxs/for-next (452daaaf6021 Merge branch 'imx/defconfig' into fo=
r-next)
Merging keystone/next (fb5d812c3cb3 Merge branch 'for_4.18/keystone-dts' in=
to next)
Merging mediatek/for-next (9378b3427341 Merge branch 'v4.17-next/soc' into =
for-next)
Merging mvebu/for-next (78e5d8c26c70 Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (1b7e42c1dfe8 Merge branch 'omap-for-v4.18/soc' into =
for-next)
Merging reset/reset/next (d7bab65b1f57 reset: uniphier: add LD11/LD20 strea=
m demux system reset control)
Merging qcom/for-next (509d20563e5d firmware: qcom: scm: Fix crash in qcom_=
scm_call_atomic1())
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (550ca2e6c090 Merge branch 'fixes-for-v4.18' into next)
Merging rockchip/for-next (eb3eec308a79 Merge branch 'v4.18-armsoc/dts32-fi=
xes' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (fba97222728d Merge branch 'next/dt64' into f=
or-next)
Merging sunxi/sunxi/for-next (e97360054391 Merge branch 'sunxi/dt64-for-4.1=
8' into sunxi/for-next)
Merging tegra/for-next (6de9ae597a79 Merge branch for-4.18/clk into for-nex=
t)
Merging arm64/for-next/core (0fe42512b2f0 arm64: Fix syscall restarting aro=
und signal suppressed by tracer)
Merging clk/clk-next (55913c2d3330 Merge branch 'clk-imx6ul' into clk-next)
Merging clk-samsung/for-next (e8cf870f253b clk: samsung: simplify getting .=
drvdata)
Merging c6x/for-linux-next (85fa2cc51104 c6x: pass endianness info to spars=
e)
Merging m68k/for-next (b12c8a70643f m68k: Set default dma mask for platform=
 devices)
Merging m68knommu/for-next (082f55c45984 m68k: fix ColdFire PCI config read=
s and writes)
Merging microblaze/next (5cf8da7bc035 microblaze: Remove architecture heart=
 beat code)
Merging mips/mips-next (9ed8b56b80c1 MAINTAINERS: Add Paul Burton as MIPS c=
o-maintainer)
Merging nds32/next (e5dd7e2f8a59 nds32: define __NDS32_E[BL]__ for sparse)
Merging nios2/for-next (3d9644ef9a0f nios2: Use read_persistent_clock64() i=
nstead of read_persistent_clock())
Merging openrisc/for-next (d56f3af9e801 openrisc: remove unused __ARCH_HAVE=
_MMU define)
Merging parisc-hd/for-next (8d40c754fbac parisc: Drop struct sigaction from=
 not exported header file)
Merging powerpc/next (ff5bc793e47b powerpc/64s/radix: Fix missing ptesync i=
n flush_cache_vmap)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_=
device)
Merging risc-v/for-next (29dcea88779c Linux 4.17)
Merging s390/features (ec530174c437 s390/dasd: only use preallocated reques=
ts)
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
Merging btrfs/next (7c9a09f56a91 btrfs: don't use async helpers for crcs wh=
en under IO limits)
Applying: f2fs: fixup for cgroup/writeback change
Merging btrfs-kdave/for-next (e4eada7b2b40 Merge branch 'for-next-current-v=
4.17-20180608' into for-next-20180608)
Merging ceph/master (23edca864951 rbd: flush rbd_dev->watch_dwork after wat=
ch is unregistered)
Merging cifs/for-next (83ffdeadb46b cifs: Fix invalid check in __cifs_calc_=
signature())
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type con=
st)
Merging ecryptfs/next (e86281e700cc eCryptfs: don't pass up plaintext names=
 when using filename encryption)
Merging ext3/for_next (20a653d458c3 Merge fsnotify cleanups from Amir into =
for_next)
Merging ext4/dev (a1ded76566ed ext4: include the illegal physical block in =
the bad map ext4_error msg)
Merging f2fs/dev (d54d35c501bc Merge tag 'f2fs-for-4.18' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/jaegeuk/f2fs)
Merging fuse/for-next (543b8f8662fe fuse: don't keep dead fuse_conn at fuse=
_fill_super().)
Merging jfs/jfs-next (92d34134193e jfs: Fix inconsistency between memory al=
location and ea_buf->max_size)
Merging nfs/linux-next (c18c5a82d984 pNFS: Don't send layoutreturn if the l=
ayout is already invalid)
Merging nfs-anna/linux-next (ffbfa2ce88f1 sunrpc: Fix latency trace point c=
rashes)
Merging nfsd/nfsd-next (5b7b15aee641 nfsd: fix corrupted reply to badly ord=
ered compound)
Merging orangefs/for-next (b1116bc03c00 orangefs: use sparse annotations fo=
r holding locks across function calls.)
Merging overlayfs/overlayfs-next (c03e30790cad ovl: Enable metadata only fe=
ature)
CONFLICT (content): Merge conflict in fs/read_write.c
CONFLICT (content): Merge conflict in fs/overlayfs/overlayfs.h
CONFLICT (content): Merge conflict in fs/overlayfs/inode.c
CONFLICT (content): Merge conflict in fs/inode.c
CONFLICT (content): Merge conflict in fs/btrfs/ioctl.c
Applying: overlayfs: merge fix for "vfs: change inode times to use struct t=
imespec64"
Merging ubifs/linux-next (f5a926dd5298 mtd: ubi: Update ubi-media.h to dual=
 license)
Merging xfs/for-next (89e9b5c0915a xfs: update incore per-AG inode count)
Merging file-locks/locks-next (1cf8e5de4055 fs/lock: show locks taken by pr=
ocesses from another pidns)
Merging vfs/for-next (0fe816e0a802 Merge branch 'afs-proc' into for-next)
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsy=
nc())
Merging printk/for-next (ce041c43f222 lib/test_printf.c: accept "ptrval" as=
 valid result for plain 'p' tests)
Merging pci/next (ce4c7b241227 Merge branch 'pci/aer-squash')
Merging pstore/for-next/pstore (e698aaf37f9f pstore: fix crypto dependencie=
s without compression)
Merging hid/for-next (f1b6ae6701a7 Merge branch 'for-4.18/rmi' into for-nex=
t)
Merging i2c/i2c/for-next (1840b5ac656f Merge branch 'i2c/for-4.18' into i2c=
/for-next)
Merging dmi/master (7f73745fec52 firmware: dmi: Add access to the SKU ID st=
ring)
Merging hwmon-staging/hwmon-next (06399c395108 hwmon: (nct7904) Fix UNSPECI=
FIED_INT warning)
Merging jc_docs/docs-next (a49d9c0ae46e Documentation: document hung_task_p=
anic kernel parameter)
Merging v4l-dvb/master (f2809d20b925 media: omap2: fix compile-testing with=
 FB_OMAP2=3Dm)
Merging v4l-dvb-next/master (f10379aad39e media: include/video/omapfb_dss.h=
: use IS_ENABLED())
Merging fbdev/fbdev-for-next (85ebd164de56 fb_omap2: add gpiolib dependency)
Merging pm/linux-next (c243466225cb Merge branch 'acpi-soc' into linux-next)
Merging cpupower/cpupower (f9652d5cae04 cpupower : Fix header name to read =
idle state name)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (8a352fd8787c OPP: Allow same OPP table to be us=
ed for multiple genpd)
Merging thermal/next (e9ed3ee61aa6 Merge branches 'thermal-core' and 'therm=
al-intel' into next)
Merging thermal-soc/next (6d7c70d1cd65 thermal: qcom: tsens: Allow number o=
f sensors to come from DT)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversize=
d DMA reads on JMicron controllers)
Merging dlm/next (da3627c30d22 dlm: remove O_NONBLOCK flag in sctp_connect_=
to_sock)
Merging swiotlb/linux-next (4855c92dbb7b xen-swiotlb: fix the check conditi=
on for xen_swiotlb_free_coherent)
Merging rdma/for-next (c1191a19feca RDMA/mlx5: Update SPDX tags to show pro=
per license)
Merging net-next/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/davem/net)
Merging bpf-next/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/li=
nux/kernel/git/davem/net)
Merging ipsec-next/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/=
linux/kernel/git/davem/net)
Merging mlx5-next/mlx5-next (d2fb9855b533 Merge commit 'shared-part-of-flow=
-counters' into mlx5-next)
Merging netfilter-next/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/=
scm/linux/kernel/git/davem/net)
Merging nfc-next/master (7579d009c4a1 NFC: fdp: Remove __func__ from dev_db=
g())
Merging ipvs-next/master (e523452ac0e0 netfilter: nf_tables: remove unused =
variables)
Merging wireless-drivers-next/master (76606886c9f4 Merge ath-next from git:=
//git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/l=
inux/kernel/git/davem/net)
Merging mac80211-next/master (ef5c51f444b9 mac80211: add support for HE)
CONFLICT (content): Merge conflict in net/mac80211/scan.c
Merging gfs2/for-next (f0dc7f9c6dd9 Merge git://git.kernel.org/pub/scm/linu=
x/kernel/git/davem/net)
Merging mtd/mtd/next (ce397d215ccd Linux 4.18-rc1)
Merging nand/nand/next (ce397d215ccd Linux 4.18-rc1)
Merging spi-nor/spi-nor/next (ce397d215ccd Linux 4.18-rc1)
Merging crypto/master (b268b3506d99 crypto: chtls - free beyond end rspq_sk=
b_cache)
Merging drm/drm-next (daf0678c2036 Merge branch 'drm-next-4.18' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add s=
upport for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (807cba6559cf Merge tag 'gvt-fixes-2018-04=
-19' of https://github.com/intel/gvt-linux into drm-intel-next-fixes)
Merging drm-tegra/drm/tegra/for-next (6134534ca24f drm/tegra: Add kerneldoc=
 for UAPI)
Merging drm-misc/for-linux-next (069035c5db34 drm: Fix possible race condit=
ions while unplugging DRM device)
Merging drm-msm/msm-next (4dd454c371fd drm/msm/gpu: Increase the pm runtime=
 autosuspend for 5xx)
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
Merging regmap/for-next (66431563e0d9 Merge branch 'regmap-4.18' into regma=
p-next)
Merging sound/for-next (d5a6cabf0221 ALSA: hda/realtek - Fix pop noise on L=
enovo P50 & co)
Merging sound-asoc/for-next (5544717d416d Merge branch 'asoc-4.18' into aso=
c-next)
Merging modules/modules-next (c554b8986801 module: Allow to always show the=
 status of modsign)
Merging input/next (5aff29efbec0 Merge branch 'ib/4.17-xen-kbdfront-runtime=
-config' into next)
Merging block/for-next (28313cee1d4f Merge branch 'for-4.18/block' into for=
-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pb=
lk-init.c)
Merging device-mapper/for-next (bbb683cf88f5 dm: use bio_split() when split=
ting out the already processed bio)
Merging pcmcia/pcmcia-next (c3a5307873d4 pcmcia: Use module_pcmcia_driver f=
or scsi drivers)
Merging mmc/next (ef5332c10d4f mmc: renesas_sdhi: really fix WP logic regre=
ssions)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlappin=
g memcpy)
Merging md/for-next (07ecb3a36765 MD: cleanup resources in failure)
Merging mfd/for-mfd-next (556c242045f0 mfd: cros_ec: Remove unused __remove=
 function)
Merging backlight/for-backlight-next (d5318d302e7c backlight: as3711_bl: Fi=
x Device Tree node leaks)
Merging battery/for-next (c42812da1395 MAINTAINERS: add entry for LEGO MIND=
STORMS EV3)
Merging regulator/for-next (13ed4964057e Merge branch 'regulator-4.17' into=
 regulator-4.18 merge window)
Merging security/next-testing (d19289133b1d Merge branch 'next-integrity' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into =
next-testing)
Merging apparmor/apparmor-next (338d0be437ef apparmor: fix ptrace read chec=
k)
Merging integrity/next-integrity (b5c90a7526fe EVM: unlock on error path in=
 evm_read_xattrs())
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to preve=
nt tainting)
Merging selinux/next (d141136f523a audit: normalize MAC_POLICY_LOAD record)
Merging tpmdd/next (3ac7e6225c0b tpm: migrate tpm2_get_random() to use stru=
ct tpm_buf)
Merging watchdog/master (16a7eec2fcd0 watchdog: da9063: remove duplicated t=
imeout_to_sel calls)
Merging iommu/next (1f568357117c Merge branches 'arm/io-pgtable', 'arm/qcom=
', 'arm/tegra', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (c1abca96b252 samples: mbochs: add DMA_SHARED_BUFFER depe=
ndency)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (5b71388663c0 audit: Fix wrong task in comparison of ses=
sion ID)
Merging devicetree/for-next (44acf1058790 dt-bindings: submitting-patches: =
add guidance on patch content and subject)
Merging mailbox/mailbox-for-next (f83d1cfc8bcd mailbox/drivers/hisi: Consol=
idate the Kconfig for the MAILBOX)
Merging spi/for-next (39202ebf0939 Merge branch 'spi-4.18' into spi-next)
Merging tip/auto-latest (cc82cbbdd454 Merge branch 'x86/apic')
Merging clockevents/clockevents/next (6bd9549d8a7d clocksource/drivers/arc_=
timer: Add comments about locking while read GFRC)
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://gi=
t.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (eaa3a1d46cfd EDAC, ghes: Make platform-based whi=
telisting x86-only)
Merging irqchip/irq/irqchip-next (6a88c221acba ARM: dts: stm32: Add exti su=
pport to stm32mp157 pinctrl)
Merging ftrace/for-next (a9235b544a0a ring-buffer: Fix typo in comment)
Merging rcu/rcu/next (443da8397d9f rcu: Make rcu_seq_diff() more exact)
CONFLICT (content): Merge conflict in drivers/iommu/amd_iommu.c
Merging kvm/linux-next (766d3571d8e5 kvm: fix typo in flag name)
Merging kvm-arm/next (e25028c8ded0 KVM: arm/arm64: Bump VGIC_V3_MAX_CPUS to=
 512)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement T=
LBR for T&E)
Merging kvm-ppc/kvm-ppc-next (f61e0d3cc4ae KVM: PPC: Book3S PR: Fix failure=
 status setting in tabort. emulation)
Merging kvms390/next (2c8180e885c1 KVM: s390: vsie: simplify < 8k address c=
hecks)
Merging xen-tip/linux-next (7f47e1c52d0c xen/PVH: Make GDT selectors PVH-sp=
ecific)
Merging percpu/for-next (b3a5d1119944 percpu_ref: Update doc to dissuade us=
ers from depending on internal RCU grace periods)
Merging workqueues/for-next (66448bc274ca workqueue: move function definiti=
ons within CONFIG_SMP block)
Merging drivers-x86/for-next (26ed9d1c07ef platform/x86: silead_dmi: Add en=
try for Chuwi Hi8 tablet touchscreen)
Merging chrome-platform/for-next (c474e9f2be99 platform/chrome: chromeos_tb=
mc - fix SPDX identifier)
Merging hsi/for-next (70d52ba9e57e hsi: clients: Change return type to vm_f=
ault_t)
Merging leds/for-next (6d71021ab3b0 leds: class: ensure workqueue is initia=
lized before setting brightness)
Merging ipmi/for-next (048f7c3e352e ipmi: Properly release srcu locks on er=
ror conditions)
Merging driver-core/driver-core-next (ce397d215ccd Linux 4.18-rc1)
Merging usb/usb-next (ce397d215ccd Linux 4.18-rc1)
Merging usb-gadget/next (47265c067c0d usb: dwc2: gadget: Fix coverity issue)
Merging usb-serial/usb-next (7041d9c3f01b USB: serial: pl2303: add support =
for tx xon/xoff flow control)
Merging usb-chipidea-next/ci-for-usb-next (8bcf4c0bd7fb usb: chipidea: prop=
erly handle host or gadget initialization failure)
Merging phy-next/next (c1eb8f83845b phy: mediatek: add XS-PHY driver)
Merging tty/tty-next (ce397d215ccd Linux 4.18-rc1)
Merging char-misc/char-misc-next (ce397d215ccd Linux 4.18-rc1)
Merging extcon/extcon-next (441492c2256c extcon: Release locking when sendi=
ng the notification of connector state)
Merging staging/staging-next (3053339b17f8 staging: goldfish: Clear audio r=
ead buffer status after each read)
Merging mux/for-next (6a3d4baac84a mux: add mux_control_get_optional() API)
Merging slave-dma/next (ce397d215ccd Linux 4.18-rc1)
Merging cgroup/for-next (d8742e229021 cgroup: css_set_lock should nest insi=
de tasklist_lock)
Merging scsi/for-next (5b10177e2dd8 scsi: qla2xxx: Spinlock recursion in ql=
a_target)
Merging scsi-mkp/for-next (1b5c2cb19668 scsi: lpfc: update driver version t=
o 12.0.0.4)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging libata/for-next (ed058253618e Merge branch 'for-4.17-fixes' into fo=
r-next)
Merging vhost/linux-next (2eb98105f8c7 virtio: update the comments for tran=
sport features)
Merging rpmsg/for-next (1601c6923d66 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (3079a27868c4 gpio: uniphier: set legitimate irq trig=
ger type in .to_irq hook)
Merging pinctrl/for-next (d2b6d0c74dd0 pinctrl: mt7622: fix a kernel panic =
when pio don't work as EINT controller)
Merging pinctrl-samsung/for-next (7c24e71c8a64 pinctrl: samsung: Fix suspen=
d/resume for Exynos5433 GPF1..5 banks)
Merging pwm/for-next (414c52b7899a pwm: stm32: Fix build warning with CONFI=
G_DMA_ENGINE disabled)
Merging userns/for-next (4b245b90065b Merge of my siginfo-next and userns-n=
ext trees for testing in linux-next)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (bfe80ed3d7c7 vsprintf: add command line option debug_bo=
ot_weak_hash)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and c=
ounting against aio-max-nr)
Merging kselftest/next (d7673eecc95d selftests: sync: add config fragment f=
or testing sync framework)
Merging y2038/y2038 (e264abeaf9da pstore: Remove bogus format string defini=
tion)
Merging livepatching/for-next (d7ab8e67aa52 Merge branch 'for-4.18/upstream=
' into for-next)
Merging coresight/next (b66e01615a29 coresight: tmc: Add configuration supp=
ort for trace buffer size)
CONFLICT (content): Merge conflict in drivers/hwtracing/coresight/coresight=
-tmc-etr.c
CONFLICT (content): Merge conflict in Documentation/trace/coresight.txt
Merging rtc/rtc-next (e4302aec8a06 rtc: pxa: fix probe function)
Merging nvdimm/libnvdimm-for-next (d95363c95705 Merge branch 'for-4.18/dax-=
memory-failure' into libnvdimm-for-next)
Merging at24/at24/for-next (ce397d215ccd Linux 4.18-rc1)
Merging ntb/ntb-next (b1ce023ae8a2 ntb_netdev: fix sleep time mismatch)
Merging kspp/for-next/kspp (45888b40d2a6 rslib: Allocate decoder buffers to=
 avoid VLAs)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (5997aab0a11e Merge branch 'fixes' of git://git.kern=
el.org/pub/scm/linux/kernel/git/viro/vfs)
Merging xarray/xarray (688318915a01 xarray: Fix sparse warning in test)
Applying: filesystem-dax: fixups for xaarray changes
Merging akpm-current/current (8b95a15d84a1 bfs: add sanity check at bfs_fil=
l_super())
$ git checkout -b akpm remotes/origin/akpm/master
Applying: kernel/kexec_file.c: add walk_system_ram_res_rev()
Applying: kernel/kexec_file.c: load kernel at top of system RAM if required
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (0747fb4f4b60 sparc64: NG4 memset 32 bits overflow)

--Sig_/4/9JneE3NBy2CiWcs+xovI2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsnObYACgkQAVBC80lX
0GykhAf/RmgOG23nEWH3dEYmYHrVSR8Sm6f6kMHUlZ516ks7yZhMcnIrhhUMZ2yK
lGfuwLnB8cQtmgtIkveSnMUcPzh93yLPeJx6ppM4T4Nlmd79Mi7jqfIR1pfUSO7y
gYlCKiDQXKet+l1u7QFyKmOMovC0JDJ7zFsvawpCOC00U8JUi2gmx+VKvkH7XB4V
4VitTW8yObNgxkfiihSHHvFKuqTWhZ4n/DDd+1c4XqPnNhCSmTm2s/fSYScDjQUI
KhQJJMamZ5O4Zrd4EiXaDowsVEJsvS9OP68QNlfNCXlBqJLKoGoqRa+suWVRAbkI
R66PsLUTK4TtotQCpzVfHDOUaPtLng==
=lgCd
-----END PGP SIGNATURE-----

--Sig_/4/9JneE3NBy2CiWcs+xovI2--
