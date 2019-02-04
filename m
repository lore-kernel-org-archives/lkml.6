Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F8FC282D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F280F2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 05:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="e7dAH4tL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfBDFgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 00:36:06 -0500
Received: from ozlabs.org ([203.11.71.1]:46939 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfBDFgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 00:36:05 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43tGdp2P9tz9s4Z;
        Mon,  4 Feb 2019 16:35:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1549258558;
        bh=l2pkd856boZ9hcJSLnpaxTfJZwU9WSkK12p6BfVLBlc=;
        h=Date:From:To:Cc:Subject:From;
        b=e7dAH4tL9Bm3or94igapDLVCI3MbEX4loxzHwwOkiA+FaYqOcFpD5VhqH0OK0Lee9
         ZbqZnSr01Ve8W4SU2N0EHYSSlm8ZMd3/zWPNef9B3svoYorCIaDYm/nHbOfe+/SVSY
         lkXVUGXQRl2voG7RWcKkfksFMMDaBSJ6Rrha1JNVlDJPIb/ttFsVbMluF8f23gpguw
         s0TlexT51I5K/YujFoiJzKLcLqvUruxk7s/if17rWaiOmHmomErQ/lDoA+n/zeiaVq
         3O9a8XcB6FWEE+CWoRjXk9/rZlD0X2Uw7yg9NTWcZqbNFhsXLLdqmUoeoblCCAlV8h
         x+HHWXJ5Y32bQ==
Date:   Mon, 4 Feb 2019 16:35:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 4
Message-ID: <20190204163557.05afe904@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vlZ55iXOvLoB_+tD4/xd5cH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vlZ55iXOvLoB_+tD4/xd5cH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190201:

The vfs tree still had its build failure for which I applied a patch.

The net-next tree gained a build failure for which I applied a fix patch.

The drm-tegra tree gained a build failure so I used the version from
next-20190201.

The driver-core tree lost its build failure.

Non-merge commits (relative to Linus' tree): 5280
 6047 files changed, 219992 insertions(+), 146740 deletions(-)

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

I am currently merging 296 trees (counting Linus' and 69 trees of bug
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
Merging origin/master (24b888d8d598 Merge branch 'x86-urgent-for-linus' of =
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging fixes/master (d8d0c3a7f601 x86/syscalls: Mark expected switch fall-=
throughs)
Merging kbuild-current/fixes (6db2983cd806 kallsyms: Handle too long symbol=
s in kallsyms.c)
Merging arc-current/for-curr (c4a8fb41246c ARCv2: lib: memcpy: fix doing pr=
efetchw outside of buffer)
Merging arm-current/fixes (1b5ba3507842 ARM: 8824/1: fix a migrating irq bu=
g when hotplug cpu)
Merging arm64-fixes/for-next/fixes (f7daa9c8fd19 arm64: hibernate: Clean th=
e __hyp_text to PoC after resume)
Merging m68k-current/for-linus (bed1369f5190 m68k: Fix memblock-related cra=
shes)
Merging powerpc-fixes/fixes (7bea7ac0ca01 powerpc/syscalls: Fix syscall tra=
cing)
Merging sparc/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (8dfb8d2cceb7 net: systemport: Fix WoL with password aft=
er deep sleep)
Merging bpf/master (e7b816415e03 Merge git://git.kernel.org/pub/scm/linux/k=
ernel/git/bpf/bpf)
Merging ipsec/master (09db51241118 esp: Skip TX bytes accounting when sendi=
ng from a request socket)
Merging netfilter/master (ba59fb027307 sctp: walk the list of asoc safely)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (8c22d81d5535 MAINTAINERS: add entry for re=
dpine wireless driver)
Merging mac80211/master (e005bd7ddea0 cfg80211: call disconnect_wk when AP =
stops)
Merging rdma-fixes/for-rc (7b21b69ab203 IB/uverbs: Fix OOPs in uverbs_user_=
mmap_disassociate)
Merging sound-current/for-linus (305a0ade1809 ALSA: hda - Serialize codec r=
egistrations)
Merging sound-asoc-fixes/for-linus (923ed80588cf Merge branch 'asoc-5.0' in=
to asoc-linus)
Merging regmap-fixes/for-linus (f17b5f06cb92 Linux 5.0-rc4)
Merging regulator-fixes/for-linus (c05e202d60de Merge branch 'regulator-5.0=
' into regulator-linus)
Merging spi-fixes/for-linus (2186097e00f9 Merge branch 'spi-5.0' into spi-l=
inus)
Merging pci-current/for-linus (f14bcc0add3a Revert "PCI: armada8k: Add supp=
ort for gpio controlled reset signal")
Merging driver-core.current/driver-core-linus (36991ca68db9 blk-mq: protect=
 debugfs_create_files() from failures)
Merging tty.current/tty-linus (fedb5760648a serial: fix race between flush_=
to_ldisc and tty_open)
Merging usb.current/usb-linus (a07ddce4df80 usb: typec: tcpm: Correct the P=
PS out_volt calculation)
Merging usb-gadget-fixes/fixes (a53469a68eb8 usb: phy: am335x: fix race con=
dition in _probe)
Merging usb-serial-fixes/usb-linus (f17b5f06cb92 Linux 5.0-rc4)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (827cb0323928 phy: ath79-usb: Fix the main reset name to =
match the DT binding)
Merging staging.current/staging-linus (6d923f8fe821 Merge tag 'iio-fixes-5.=
0a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging=
-linus)
Merging char-misc.current/char-misc-linus (4bf13fdbc356 mic: vop: Fix crash=
 on remove)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (f17b5f06cb92 Linux 5.0-rc4)
Merging input-current/for-linus (94803aef3533 Input: pwm-vibra - stop regul=
ator after disabling pwm, not before)
Merging crypto-current/master (356690d029e1 crypto: cavium/nitrox - Invoke =
callback after DMA unmap)
Merging ide/master (adf040ddd001 ide: Use of_node_name_eq for node name com=
parisons)
Merging vfio-fixes/for-linus (9a71ac7e15a7 vfio-pci/nvlink2: Fix ancient gc=
c warnings)
Merging kselftest-fixes/fixes (7d4e591bc051 selftests: timers: use LDLIBS i=
nstead of LDFLAGS)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (455e7b387b44 mtd: rawnand: fix kernel-doc warning=
s)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (240809ef6630 media: vim2m: only cancel work if=
 it is for right context)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (67fc5dc8a541 MIPS: VDSO: Include $(ccflags-v=
dso) in o32,n32 .lds builds)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
Merging omap-fixes/fixes (dc30e7039137 ARM: OMAP2+: Variable "reg" in funct=
ion omap4_dsi_mux_pads() could be uninitialized)
Merging kvm-fixes/master (826c1362e79a x86/kvm/nVMX: don't skip emulated in=
struction twice when vmptr address is not backed)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (2a2ec4aa0577 hwmon: (nct6775) Fix fan6 detection=
 for NCT6793D)
Merging nvdimm-fixes/libnvdimm-fixes (11189c1089da acpi/nfit: Fix command-s=
upported detection)
Merging btrfs-fixes/next-fixes (351a823f6c45 Merge branch 'misc-4.21' into =
next-fixes)
Merging vfs-fixes/fixes (fbdb44013202 copy_mount_string: Limit string lengt=
h to PATH_MAX)
Merging dma-mapping-fixes/for-linus (60d8cd572f65 arm64/xen: fix xen-swiotl=
b cache flushing)
Merging i3c-fixes/master (f36c1f9a8dfd i3c: master: dw: fix deadlock)
Merging drivers-x86-fixes/fixes (6a730fcb9cb4 Documentation/ABI: Correct ml=
xreg-io KernelVersion for 5.0)
Merging samsung-krzk-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (8437fcf14dee scsi: 53c700: pass correct "dev" to =
dma_alloc_attrs())
Merging drm-fixes/drm-fixes (f0e7ce1eef58 Merge tag 'drm-msm-fixes-2019-01-=
24' of git://people.freedesktop.org/~robclark/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (f17b5f06cb92 Linux 5.0-rc4)
Merging mmc-fixes/fixes (3751e008da0d mmc: mediatek: fix incorrect register=
 setting of hs400_cmd_int_delay)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (52d3b4949192 hv_netvsc: fix typos in cod=
e comments)
Merging drm-misc-fixes/for-linux-next-fixes (b14e945bda8a drm/sun4i: tcon: =
Prepare and enable TCON channel 0 clock at init)
Merging kbuild/for-next (9b676182bf01 Merge branch 'kconfig' into for-next)
Merging compiler-attributes/compiler-attributes (058b472f2035 lib/crc32.c: =
mark crc32_le_base/__crc32c_le_base aliases as __pure)
Merging leaks/leaks-next (8fe28cb58bcb Linux 4.20)
Merging dma-mapping/for-next (0a3b192c26da dma-debug: add dumping facility =
via debugfs)
Merging asm-generic/master (2b3c5a99d5f3 sh: generate uapi header and sysca=
ll table header files)
Merging arc/for-next (529c44807715 ARCv2: Add explcit unaligned access supp=
ort (and ability to disable too))
Merging arm/for-next (c43658cedf4d Merge branches 'fixes', 'misc' and 'smp-=
hotplug' into for-next)
Merging arm64/for-next/core (e2a2e56e4082 arm64: dump: no need to check ret=
urn value of debugfs_create functions)
Merging arm-perf/for-next/perf (cf2d65ec1d21 perf: xgene: Remove set but no=
t used variable 'config')
Merging arm-soc/for-next (06f885da38ae soc: document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (59f249fca4f0 Merge branch 'v5.1/dt64' into tmp/am=
l-rebuild)
Merging aspeed/for-next (e15425214990 ARM: dts: aspeed: quanta-q71l: enable=
 uart1)
Merging at91/at91-next (3850dd7a32a0 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (376c79c46ca2 Merge branch 'imx/maintainers' into =
for-next)
Merging keystone/next (3c3a43c81bda Merge branch 'for_5.1/soc-drivers' into=
 next)
Merging mediatek/for-next (ecee13a082e0 Merge branch 'v5.0-next/dts64' into=
 for-next)
Merging mvebu/for-next (b5f034845e70 ARM: dts: kirkwood: Fix polarity of GP=
IO fan lines)
Merging omap/for-next (e6e7b013aca0 Merge branch 'omap-for-v5.0/fixes-v2' i=
nto for-next)
Merging reset/reset/next (c979dbf59987 reset: imx7: Add support for i.MX8MQ=
 IP block variant)
Merging qcom/for-next (d11e824d7e8d Merge branch 'arm64-for-5.1-2' into all=
-for-5.1)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/qcom-ipq4019.dtsi
Merging renesas/next (077d339df29e Merge branch 'dt-bindings-for-v5.1' into=
 next)
Merging rockchip/for-next (21123b35a4e8 Merge branch 'v5.1-armsoc/dts64' in=
to for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (13427eabb93f Merge branch 'next/soc' into fo=
r-next)
Merging sunxi/sunxi/for-next (03c80f694271 Merge branch 'sunxi/dt64-for-5.1=
' into sunxi/for-next)
Merging tegra/for-next (45bfb6b333ab Merge branch for-5.1/arm64/dt into for=
-next)
Merging clk/clk-next (15961a572b90 Merge branch 'clk-json-schema' into clk-=
next)
Merging clk-samsung/for-next (81faa30df9b6 clk: samsung: exynos5433: Add se=
lected IMEM clocks)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (d1b5a330692a csky: Fixup dead loop in show_stack)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (28713169d879 m68k: Add -ffreestanding to CFLAGS)
Merging m68knommu/for-next (799485d37b07 m68k: add ColdFire mcf5441x eDMA p=
latform support)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (ce680c8c99fd MIPS: OCTEON: delete unused cvmx-smix-=
defs.h)
Merging nds32/next (bfeffd155283 Linux 5.0-rc1)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (47e157d5206d parisc: Use F_EXTEND() macro in io=
sapic code)
Merging powerpc/next (63da6caeb84c powerpc: remove unnecessary unlikely())
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (801009424e05 Fix a handful of audit-related issue)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (7dd541a3fb34 s390: no need to check return value of =
debugfs_create functions)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (940b241d9050 um: Remove obsolete reenable_XX calls)
Merging xtensa/xtensa-for-next (20d45b2c3fe9 Merge branch 'xtensa-5.0-fixes=
' into xtensa-for-next)
Merging fscrypt/master (f5e55e777cc9 fscrypt: return -EXDEV for incompatibl=
e rename or link into encrypted dir)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (35dccd9c1e97 Merge branch 'for-next-next-v5.0=
-20190123' into for-next-20190123)
Merging ceph/master (74827ee29565 ceph: quota: cleanup license mess)
Merging cifs/for-next (5ab64dea28e0 cifs: Fix NULL pointer dereference of d=
evname)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (772989eab6a5 Merge ext2 cleanups and fixes.)
Merging ext4/dev (191ce17876c9 ext4: fix special inode number checks in __e=
xt4_iget())
Merging f2fs/dev (5d4be10bd660 f2fs: fix to avoid deadlock of atomic file o=
perations)
Merging fuse/for-next (5a86a6974d52 fuse: support clients that don't implem=
ent 'opendir')
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (cd984a5be215 Merge tag 'xtensa-20190201' of git://g=
ithub.com/jcmvbkbc/linux-xtensa)
Merging nfs-anna/linux-next (8fc75bed96bb NFS: Fix up return value on fatal=
 errors in nfs_page_async_flush())
Merging nfsd/nfsd-next (978c707df559 svcrdma: Use struct_size() in kmalloc(=
))
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (2424e1c7256c overlayfs: During copy up, f=
irst copy up data and then xattrs)
Merging ubifs/linux-next (e58725d51fa8 ubifs: Handle re-linking of inodes c=
orrectly while recovery)
Merging v9fs/9p-next (3bbe8b1a4ae9 9p: mark expected switch fall-through)
Merging xfs/for-next (4ea899ead278 iomap: fix a use after free in iomap_dio=
_rw)
Merging file-locks/locks-next (bf77ae4c98d7 locks: fix error in locks_move_=
blocks())
Merging vfs/for-next (c66e6086c001 Merge branches 'work.mount' and 'work.mi=
sc' into for-next)
CONFLICT (content): Merge conflict in fs/Makefile
Applying: vfs: work around CONFIG_PRINTK=3Dn in fs_context logging code
Merging printk/for-next (15ff2069cb7f printk: Add caller information to pri=
ntk() output.)
Merging pci/next (4e4af4fc53c1 Merge branch 'remotes/lorenzo/pci/vmd')
Merging pstore/for-next/pstore (182ca6e0ae23 pstore/ram: Replace dummy_data=
 heap memory with stack memory)
Merging hid/for-next (06e284aafd45 Merge branch 'for-5.1/ish' into for-next)
Merging i2c/i2c/for-next (44783efdfed1 i2c: aspeed: Remove hard-coded bus t=
imeout value setting)
Merging i3c/i3c/next (25ac3da61ba1 i3c: master: cdns: fix I2C transfers in =
Cadence I3C master driver)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (bb3b529277b6 hwmon: (via-cputemp) Use per=
mission specific SENSOR[_DEVICE]_ATTR variants)
Merging jc_docs/docs-next (8f7e6d134bda doc: process: GPL -> GPL-compatible)
Merging v4l-dvb/master (f0ef022c85a8 media: vim2m: allow setting the defaul=
t transaction time via parameter)
CONFLICT (content): Merge conflict in drivers/media/platform/vim2m.c
Merging v4l-dvb-next/master (76097fe1aee6 media: staging/ipu3-imgu: Add MAI=
NTAINERS entry)
CONFLICT (add/add): Merge conflict in Documentation/media/v4l-drivers/ipu3.=
rst
CONFLICT (add/add): Merge conflict in Documentation/media/uapi/v4l/pixfmt-m=
eta-intel-ipu3.rst
Merging fbdev/fbdev-for-next (890d14d2d4b5 fbdev: fbmem: convert CONFIG_FB_=
LOGO_CENTER into a cmd line option)
Merging pm/linux-next (924e00689c73 Merge branches 'pm-core-fixes' and 'pm-=
cpuidle-fixes' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (5471b2c9bd08 cpufreq: qcom: Rea=
d voltage LUT and populate OPP)
Merging cpupower/cpupower (bfeffd155283 Linux 5.0-rc1)
Merging opp/opp/linux-next (c257a22bea9b PM / OPP: Remove unused parameter =
of _generic_set_opp_clk_only())
Merging thermal/next (301c9a43e158 Merge branches 'for-rc' and 'thermal-int=
el' into next)
Merging thermal-soc/next (9d216211fded thermal: generic-adc: Fix adc to tem=
p interpolation)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (5c1597bfeb2c dlm: retry wait_event_interruptible in event=
 of ERESTARTSYS)
Merging swiotlb/linux-next (227a76b64718 swiotlb: clear io_tlb_start and io=
_tlb_end in swiotlb_exit)
Merging rdma/for-next (02da37509705 RDMA/core: Use the ops infrastructure t=
o keep all callbacks in one place)
Merging net-next/master (9fb20801dab4 net: Fix ip_mc_{dec,inc}_group alloca=
tion context)
Merging bpf-next/master (a68a8481353a Merge branch 'hns3-next')
Merging ipsec-next/master (590ce401c207 dt-bindings: net: dsa: ksz9477: fix=
 indentation for switch spi bindings)
Merging mlx5-next/mlx5-next (46861e3e88be net/mlx5: Set ODP SRQ support in =
firmware)
Merging netfilter-next/master (0604628bb03a netfilter: nf_tables: add NFTA_=
RULE_POSITION_ID to nla_policy)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (030b43671ae8 wireless: prefix header =
search paths with $(srctree)/)
Merging bluetooth/master (017a01ccfbc5 Bluetooth: btusb: Add shutdown routi=
ne for BTUSB_INTEL_NEW devices)
Merging mac80211-next/master (7d4194633b29 mac80211: fix missing/malformed =
documentation)
Merging gfs2/for-next (2abbf9a4d262 gfs: no need to check return value of d=
ebugfs_create functions)
Merging mtd/mtd/next (b0dd77a79642 mtd: docg3: fix a possible memory leak o=
f mtd->name)
Merging nand/nand/next (e74745d96478 mtd: rawnand: fsmc: Disable NAND on re=
move())
Merging spi-nor/spi-nor/next (a2126b0a0109 mtd: spi-nor: refine Spansion S2=
5FL512S ID)
Merging crypto/master (8336bdf12a9e crypto: arm64/crct10dif - register PMUL=
L variants as separate algos)
Merging drm/drm-next (74b7d6a91311 Merge branch 'for-upstream/mali-dp' of g=
it://linux-arm.org/linux-ld into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_debugfs.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/amdgpu_dev=
ice.c
Merging drm-intel/for-linux-next (46c0cd8c562b drm/i915: Update DRIVER_DATE=
 to 20190202)
Merging drm-tegra/drm/tegra/for-next (e01c78172871 drm/tegra: sor: Support =
device tree crossbar configuration)
$ git reset --hard HEAD^
Merging next-20190201 version of drm-tegra
Merging drm-misc/for-linux-next (ba420afab565 drm/vkms: Bugfix racing hrtim=
er vblank handle)
Merging drm-msm/msm-next (8aa82766de12 dt-bindings: drm/msm/a6xx: Document =
GMU bindings)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (dcc9d76b6d83 drm/komeda: Off by one i=
n komeda_fb_get_pixel_addr())
Merging imx-drm/imx-drm/next (e4a2457f459b drm/imx: only send commit done e=
vent when all state has been applied)
Merging etnaviv/etnaviv/next (fd4b77e8deea drm/etnaviv: don't restrict to c=
ertain architectures)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (66fb181d6f82 Merge remote-tracking branch 'regmap/=
topic/irq' into regmap-next)
Merging sound/for-next (0b6a2c9cf4a0 ALSA: isa: Avoid passing NULL to memor=
y allocators)
Merging sound-asoc/for-next (efff79c93355 Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (281d5e66e01e Input: sx8654 - convert #defined flags to =
BIT(x))
Merging block/for-next (9dccbf6da0f6 Merge branch 'for-5.1/block' into for-=
next)
Merging device-mapper/for-next (075c18c3e124 dm: add missing trace_block_sp=
lit() to __split_and_process_bio())
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (dc5c8daecc7e mmc: tegra: HW Command Queue Support for Teg=
ra SDMMC)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (c52b8fd546d8 mfd: wm8400-core: Make it explicitly=
 non-modular)
Merging backlight/for-backlight-next (cec2b18832e2 backlight: pwm_bl: Use g=
piod_get_value_cansleep() to get initial state)
Merging battery/for-next (f83a6ece6997 power: supply: bq25890: show max cha=
rge current/voltage as configured)
Merging regulator/for-next (d69bb97b9a11 Merge branch 'regulator-5.1' into =
regulator-next)
Merging security/next-testing (d87331e4a620 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (43aa09fee2f0 apparmor: Fix warning about un=
used function apparmor_ipv6_postroute)
Merging integrity/next-integrity (cd0b86fe9529 ima: define ima_post_create_=
tmpfile() hook and add missing call)
Merging selinux/next (e6f2f381e401 selinux: replace BUG_ONs with WARN_ONs i=
n avc.c)
Merging tpmdd/next (20a2e0a7a26d tpm: don't return bool from update_timeout=
s)
Merging watchdog/master (59600d045ff4 dt-bindings: watchdog: renesas-wdt: D=
ocument r8a77470 support)
Merging iommu/next (af728567eaac Merge branches 'iommu/fixes', 'arm/msm', '=
arm/tegra', 'x86/vt-d', 'x86/amd' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (8ba35b3a0046 vfio-mdev/samples: Use u8 instead of char f=
or handle functions)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (5f3d544f1671 audit: remove audit_context when CONFIG_ A=
UDIT and not AUDITSYSCALL)
Merging devicetree/for-next (42e45a9449f1 media: s5p-mfc: Fix memdev DMA co=
nfiguration)
Merging mailbox/mailbox-for-next (d69e11648e48 mailbox: tegra-hsp: Use devi=
ce-managed registration API)
Merging spi/for-next (57b20d4d93f7 Merge branch 'spi-5.1' into spi-next)
CONFLICT (modify/delete): arch/mips/ath79/dev-spi.h deleted in HEAD and mod=
ified in spi/for-next. Version spi/for-next of arch/mips/ath79/dev-spi.h le=
ft in tree.
$ git rm -f arch/mips/ath79/dev-spi.h
Merging tip/auto-latest (50214dc149fd Merge branch 'x86/cleanups')
Merging clockevents/clockevents/next (7cd6dca3600d clocksource/drivers/arch=
_timer: Workaround for Allwinner A64 timer instability)
Merging edac-amd/for-next (d4dc89d069aa EDAC, i10nm: Add a driver for Intel=
 10nm server processors)
Merging irqchip/irq/irqchip-next (56841070ccc8 irqchip/gic-v3-its: Fix ITT_=
entry_size accessor)
Merging ftrace/for-next (3d739c1f6156 tracing: Use the return of str_has_pr=
efix() to remove open coded numbers)
Merging rcu/rcu/next (e81e38da861d Merge LKMM and RCU commits)
Merging kvm/linux-next (bfeffd155283 Linux 5.0-rc1)
Merging kvm-arm/next (bb16c22a780e arm64: KVM: Describe data or unified cac=
hes as having 1 set and 1 way)
Merging kvm-ppc/kvm-ppc-next (ae59a7e1945b KVM: PPC: Book3S HV: Keep rc bit=
s in shadow pgtable in sync with host)
Merging kvms390/next (7aedd9d48f2a KVM: s390: fix kmsg component kvm-s390)
Merging xen-tip/linux-next (8d2df8a2d0fa arch/arm/xen: Remove duplicate hea=
der)
Merging percpu/for-next (718f6757a29b Merge branch 'for-4.21' into for-next)
Merging workqueues/for-next (4d43d395fed1 workqueue: Try to catch flush_wor=
k() without INIT_WORK().)
Merging drivers-x86/for-next (e7706a4359f0 platform/x86: mlx-platform: Add =
support for new VMOD0007 board name)
Merging chrome-platform/for-next (bfeffd155283 Linux 5.0-rc1)
Merging hsi/for-next (3a658e09a215 HSI: omap_ssi: Change to use DEFINE_SHOW=
_ATTRIBUTE macro)
Merging leds/for-next (0f85e8498a48 leds: trigger: timer: Add initializatio=
n from Device Tree)
Merging ipmi/for-next (2b835103f84d ipmi: Use dedicated API for copying a U=
UID)
Merging driver-core/driver-core-next (7cbc2b421ee3 firmware: intel_stratix1=
0_service: remove COMPILE_TEST)
Merging usb/usb-next (a2fd23b93733 usbip: Fix vep_free_request() null point=
er checks on input args)
Merging usb-gadget/next (1c7fc5cbc339 Linux 5.0-rc2)
Merging usb-serial/usb-next (a49e1abf0770 USB: serial: cp210x: support all =
gpios on CP2102N QFN28 package)
Merging usb-chipidea-next/ci-for-usb-next (9049fce897ed usb: chipidea: imx:=
 allow to configure oc polarity on i.MX25)
Merging phy-next/next (49ee1406355e phy: qcom-qusb2: Add QUSB2 PHY support =
for msm8998)
Merging tty/tty-next (9c6a2583f115 serial: mps2-uart: Add parentheses aroun=
d conditional in mps2_uart_shutdown)
Merging char-misc/char-misc-next (9f23379c67fa nvmem: allow to select i.MX =
nvmem driver for i.MX 7D)
Merging extcon/extcon-next (a9857d45edf3 extcon: ptn5150: Fix return value =
check in ptn5150_i2c_probe())
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (f17b5f06cb92 Linux 5.0-rc4)
Merging staging/staging-next (1c516c54acf6 staging: rtl8188eu: refactor rtw=
_reset_securitypriv())
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (1c7fc5cbc339 Linux 5.0-rc2)
Merging slave-dma/next (84aca9e007d2 Merge branch 'topic/xilinx' into next)
CONFLICT (content): Merge conflict in drivers/dma/imx-sdma.c
Merging cgroup/for-next (6b3a6a132dfc MAINTAINERS: Update cgroup entry)
Merging scsi/for-next (e999fb7cc97c Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/arcmsr/arcmsr_hba.c
Merging scsi-mkp/for-next (ede2afb9c8ed scsi: hisi_sas: Add missing seq_pri=
ntf() call in hisi_sas_show_row_32())
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (ae5d11d206fc arch: move common mmap flags to linu=
x/mman.h)
CONFLICT (content): Merge conflict in drivers/pci/setup-bus.c
Merging rpmsg/for-next (19f5ccc8bbc9 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (6292247c07f9 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (060175a657f0 gpio: altera-a10sr: Trivial c=
oding style fix)
CONFLICT (content): Merge conflict in drivers/gpio/gpio-altera-a10sr.c
Merging pinctrl/for-next (fb5ed1b8df2b Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (7ca17b207127 pwm: imx: Signedness bug in imx_pwm_get_=
state())
Merging userns/for-next (ee17e5d6201c signal: Make siginmask safe when pass=
ed a signal of 0)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (bfeffd155283 Linux 5.0-rc1)
Merging y2038/y2038 (4ad44aba07b7 y2038: add 64-bit time_t syscalls to all =
32-bit architectures)
Merging livepatching/for-next (62ecab9b2482 Merge branch 'for-5.1-atomic-re=
place' into for-next)
Merging coresight/next (c714bc38ebee coresight: Use event attributes for si=
nk selection)
Merging rtc/rtc-next (75455e258ea2 rtc: abx80x: Configure reserved bits in =
RV1805)
Merging nvdimm/libnvdimm-for-next (8a6f7591ddf5 Merge branch 'for-5.0/dax' =
into libnvdimm-for-next)
Merging at24/at24/for-next (3b0548784079 eeprom: at24: remove at24_platform=
_data)
Merging ntb/ntb-next (d9842b39e9ec ntb_hw_switchtec: Added support of >=3D4=
G memory windows)
Merging kspp/for-next/kspp (be1944712d8e Merge branch 'for-next/gcc-plugin/=
arm-stackprotector' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (84a401a27506 Merge branch 'for-x86' into for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging gnss/gnss-next (f9eb86fddaf2 dt-bindings: gnss: add lna-supply prop=
erty)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (81648d8bc222 slimbus: core: add missing spin_lock=
_init on txn_lock)
Merging nvmem/for-next (c86d78c459db nvmem: allow to select i.MX nvmem driv=
er for i.MX 7D)
Merging xarray/xarray (edcddd4c879a XArray: Fix an arithmetic error in xa_i=
s_err)
Merging hyperv/hyperv-next (27207b76011f vmbus: Switch to use new generic U=
UID API)
Merging auxdisplay/auxdisplay (49a57857aeea Linux 5.0-rc3)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (a662d9f6ca22 selftests: add tests for pidfd_send_si=
gnal())
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Merging kspp-gustavo/for-next/kspp (f993bd3e061d ASN.1: mark expected switc=
h fall-through)
CONFLICT (content): Merge conflict in kernel/time/timer.c
CONFLICT (content): Merge conflict in kernel/time/hrtimer.c
Applying: socket: fix for Add SO_TIMESTAMP[NS]_NEW
Merging akpm-current/current (a787181ed2cb ipc/sem.c: replace kvmalloc/mems=
et with kvzalloc and use struct_size)
CONFLICT (content): Merge conflict in security/selinux/ss/services.c
CONFLICT (content): Merge conflict in include/linux/sched.h
CONFLICT (content): Merge conflict in include/linux/kernfs.h
$ git checkout -b akpm remotes/origin/akpm/master
Applying: scripts/atomic/check-atomics.sh: don't assume that scripts are ex=
ecutable
Applying: proc: calculate end pointer for /proc/*/* lookup at compile time
Applying: proc: merge fix for proc_pident_lookup() API change
Applying: unicore32: stop printing the virtual memory layout
Applying: arch/nios2/mm/fault.c: remove duplicate include
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: openrisc: prefer memblock APIs returning virtual address
Applying: powerpc: use memblock functions returning virtual address
Applying: memblock: replace memblock_alloc_base(ANYWHERE) with memblock_phy=
s_alloc
Applying: memblock: drop memblock_alloc_base_nid()
Applying: memblock: emphasize that memblock_alloc_range() returns a physica=
l address
Applying: memblock: memblock_phys_alloc_try_nid(): don't panic
Applying: memblock: memblock_phys_alloc(): don't panic
Applying: memblock: drop __memblock_alloc_base()
Applying: memblock: drop memblock_alloc_base()
Applying: memblock: refactor internal allocation functions
Applying: memblock: make memblock_find_in_range_node() and choose_memblock_=
flags() static
Applying: arch: use memblock_alloc() instead of memblock_alloc_from(size, a=
lign, 0)
Applying: arch: don't memset(0) memory returned by memblock_alloc()
Applying: ia64: add checks for the return value of memblock_alloc*()
Applying: sparc: add checks for the return value of memblock_alloc*()
Applying: mm/percpu: add checks for the return value of memblock_alloc*()
Applying: init/main: add checks for the return value of memblock_alloc*()
Applying: swiotlb: add checks for the return value of memblock_alloc*()
Applying: treewide: add checks for the return value of memblock_alloc*()
Applying: mm: sparse: Use '%pa' with 'phys_addr_t' type
Applying: memblock: fix format strings for panics after memblock_alloc
Applying: mm/sparse: don't panic if the allocation in sparse_buffer_init fa=
ils
Applying: memblock: memblock_alloc_try_nid: don't panic
Applying: memblock: drop memblock_alloc_*_nopanic() variants
Applying: include/linux/relay.h: fix percpu annotation in struct rchan
Applying: kernel/fork.c: remove duplicated include
Applying: samples/mic/mpssd/mpssd.h: remove duplicate header
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (63ea5acfbf2a drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/vlZ55iXOvLoB_+tD4/xd5cH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxXzz0ACgkQAVBC80lX
0Gz/Nwf6A9eKEqExfHcMFcpAaKFy2fg5k3MvCRthmy+teSlYXTijOOBnHHqpe987
pgSNtQCnwbAdiSwrjflCUZ6yoiNTtvlwS9h4KxhUze4W0E2TSHotMgA7BD7gjR+y
vqW7/eTYjXO7rx2cP0TjW7eHgZWSKQg+00VaTzx025Xh3fiB/StAVV0mD8VQ/f4F
Cwiy3EDFH4ICU5zcJKdEzCUel0e0rT8pLFXLwq0rtUCoDxNfFvrWm9IpjaoswgMq
sM37jeObO3quf0PxkbIBFl3g69YWNMpj1D+dahMgadnXbA4TVul44rdT/ZRUwt4L
yq7mlWJhg0KLTneoP5tdu1zdnswu0Q==
=BQc0
-----END PGP SIGNATURE-----

--Sig_/vlZ55iXOvLoB_+tD4/xd5cH--
