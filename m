Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4764CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6DA82085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 03:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YHzLwbxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfAOD2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 22:28:17 -0500
Received: from ozlabs.org ([203.11.71.1]:54657 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfAOD2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 22:28:16 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43dwlZ0pcsz9s2P;
        Tue, 15 Jan 2019 14:28:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1547522890;
        bh=XTYQAFRU/Tjw1eunGO3ZtcNzvpJ/nEc+inp7gmCU7z0=;
        h=Date:From:To:Cc:Subject:From;
        b=YHzLwbxiOq+vwCAt0x8fauj+Xx9d1oIz6dYvHEzOIDSpjd2UCzifXZFz6Y/yFMhTt
         x5sxZ0sy1qSoxFNGNJqpNy3X4IypEJlaJfHaeWUc73/LogteGbAmvEkIpstv8PUENH
         2WfRuGZg1InbvWTyXOle1hbpHbNt/oqY54cgQeSgR1E9KkUdD82sl29kCRJRyW8l8K
         ruxz2ofpbxNAOjjVyQ0KN8qZJxtchZMdytpBQY28CHzO6YJlivkO4MV6gxDKSrpNOd
         KoqmKB35iKIixzX/IVmrDRyLJAH32vWNzJCJv88UjVYT3R2PgqACsWl3+DIQhKiAuH
         8Q3B+FD80g89w==
Date:   Tue, 15 Jan 2019 14:28:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 15
Message-ID: <20190115142808.4c9436e9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/epRTClWKnVuI9gW7BRZ0vK6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/epRTClWKnVuI9gW7BRZ0vK6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190114:

The vfs tree still had its build failure for which I applied a patch.

The mali-dp tree lost its build failure but gained another for which
I applied a merge fix patch.

Non-merge commits (relative to Linus' tree): 1856
 1927 files changed, 62318 insertions(+), 28921 deletions(-)

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

I am currently merging 295 trees (counting Linus' and 69 trees of bug
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
Merging origin/master (3719876809e7 sbitmap: Protect swap_lock from softirq=
s)
Merging fixes/master (75d4f49b8a3b drm/nouveau/nvkm: mark expected switch f=
all-throughs)
Merging kbuild-current/fixes (beedd844b014 openrisc: remove unneeded code i=
n arch/openrisc/Makefile)
Merging arc-current/for-curr (5fac3149be6f ARC: adjust memblock_reserve of =
kernel memory)
Merging arm-current/fixes (c2a3831df6dc ARM: 8816/1: dma-mapping: fix poten=
tial uninitialized return)
Merging arm64-fixes/for-next/fixes (279667212ab2 arm64: kexec_file: return =
successfully even if kaslr-seed doesn't exist)
Merging m68k-current/for-linus (bed1369f5190 m68k: Fix memblock-related cra=
shes)
Merging powerpc-fixes/fixes (6bca51591751 powerpc/powernv/npu: Fix oops in =
pnv_try_setup_npu_table_group())
Merging sparc/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (2f960bd05640 Merge branch 'bnxt_en-Bug-fixes-for-57500-=
chips')
Merging bpf/master (fb4129b9279d Merge branch 'bpf-fix-bitfield-printing')
Merging ipsec/master (35e6103861a3 xfrm: refine validation of template and =
selector families)
Merging netfilter/master (2314e879747e netfilter: nft_flow_offload: fix che=
cking method of conntrack helper)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (bfeffd155283 Linux 5.0-rc1)
Merging mac80211/master (1d51b4b1d3f2 Merge tag 'm68k-for-v4.20-tag2' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k)
Merging rdma-fixes/for-rc (9d9f59b4204b RDMA/mthca: Clear QP objects during=
 their allocation)
Merging sound-current/for-linus (687ae9e287b3 ASoC: intel: skl: Fix display=
 power regression)
Merging sound-asoc-fixes/for-linus (d9c51542207a Merge branch 'asoc-5.0' in=
to asoc-linus)
Merging regmap-fixes/for-linus (1cd824361eed Merge branch 'regmap-4.21' int=
o regmap-5.0)
Merging regulator-fixes/for-linus (9cfc6bd21a94 Merge branch 'regulator-5.0=
' into regulator-linus)
Merging spi-fixes/for-linus (fde2955e773f Merge branch 'spi-5.0' into spi-l=
inus)
Merging pci-current/for-linus (a3869d43c980 PCI: amlogic: Fix build failure=
 due to missing gpio header)
Merging driver-core.current/driver-core-linus (735df0ff6ece Documentation: =
driver core: remove use of BUS_ATTR)
Merging tty.current/tty-linus (d3736d82e816 tty: Don't hold ldisc lock in t=
ty_reopen() if ldisc present)
Merging usb.current/usb-linus (b9fcb0e6b705 usb: storage: Remove outdated U=
RL from MAINTAINERS)
Merging usb-gadget-fixes/fixes (069caf5950df USB: omap_udc: fix rejection o=
f out transfers when DMA is used)
Merging usb-serial-fixes/usb-linus (a8eda9fa1bd8 USB: serial: ftdi_sio: fix=
 GPIO not working in autosuspend)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (3bd6e94bec12 arch: restore generic-y +=3D shmparam.h for=
 some architectures)
Merging staging.current/staging-linus (06382deac2b8 Revert "staging: rtl872=
3bs: Mark ACPI table declaration as used")
Merging char-misc.current/char-misc-linus (f7ee8ead151f mei: me: add denver=
ton innovation engine device IDs)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging input-current/for-linus (4add635b4e00 Input: raspberrypi-ts - fix l=
ink error)
Merging crypto-current/master (d45a90cb5d06 crypto: sm3 - fix undefined shi=
ft by >=3D width of value)
Merging ide/master (adf040ddd001 ide: Use of_node_name_eq for node name com=
parisons)
Merging vfio-fixes/for-linus (58fec830fc19 vfio/type1: Fix unmap overflow o=
ff-by-one)
Merging kselftest-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (81d9bdf59092 mtd: rawnand: qcom: fix memory corru=
ption that causes panic)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (ff8542c76fab MIPS: OCTEON: fix kexec support)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
Merging omap-fixes/fixes (935853fa3e1b ARM: dts: omap3-gta04: Fix graph_por=
t warning)
Merging kvm-fixes/master (826c1362e79a x86/kvm/nVMX: don't skip emulated in=
struction twice when vmptr address is not backed)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (cbb59b72b796 hwmon: (occ) Fix potential integer =
overflow)
Merging nvdimm-fixes/libnvdimm-fixes (1cb95e072ede libnvdimm/dimm: Fix secu=
rity capability detection for non-Intel NVDIMMs)
Merging btrfs-fixes/next-fixes (65b4e1469131 Merge branch 'ext/josef/iput-f=
ixes-for-5.0' into next-fixes)
Merging vfs-fixes/fixes (61aa329d0762 cgroup: saner refcounting for cgroup_=
root)
Merging dma-mapping-fixes/for-linus (8270f3a11cee dma-direct: fix DMA_ATTR_=
NO_KERNEL_MAPPING for remapped allocations)
Merging i3c-fixes/master (0fac32f24cea i3c: master: Fix an error checking t=
ypo in 'cdns_i3c_master_probe()')
Merging drivers-x86-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging samsung-krzk-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (8217724eb7c5 doc: bindings: fix bad refe=
rence to ARM CPU bindings)
Merging scsi-fixes/fixes (9e8f1c798314 scsi: cxgb4i: add wait_for_completio=
n())
Merging drm-fixes/drm-fixes (e2d3c414ec0f Merge tag 'drm-intel-fixes-2019-0=
1-11' of git://anongit.freedesktop.org/drm/drm-intel into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (1c7fc5cbc339 Linux 5.0-rc2)
Merging mmc-fixes/fixes (2bd44dadd5bf mmc: sdhci-iproc: handle mmc_of_parse=
() errors during probe)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (b5679cebf780 vmbus: fix subchannel remov=
al)
Merging drm-misc-fixes/for-linux-next-fixes (f672b93e4a0a drm/meson: add mi=
ssing of_node_put)
Merging kbuild/for-next (bd352a739fde kbuild: remove unused baseprereq)
Merging compiler-attributes/compiler-attributes (3e2ffd655cc6 include/linux=
/compiler*.h: fix OPTIMIZER_HIDE_VAR)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging dma-mapping/for-next (8b1cce9f5832 dma-mapping: fix inverted logic =
in dma_supported)
Merging asm-generic/master (2b3c5a99d5f3 sh: generate uapi header and sysca=
ll table header files)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (8f839a25b9cc Merge branches 'fixes', 'misc', 'sa1100-=
for-next', 'smp-hotplug' (early part) and 'spectre' into for-next)
Merging arm64/for-next/core (7e0b44e870cf arm64: compat: Hook up io_pgeteve=
nts() for 32-bit tasks)
Merging arm-perf/for-next/perf (c061ce249f9b dt-bindings: arm: Convert PMU =
binding to json-schema)
Merging arm-soc/for-next (f217b8e70c76 ARM: Document merges)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (a8d87cf95c85 Merge branch 'v5.1/dt64' into tmp/am=
l-rebuild)
Merging aspeed/for-next (f59cffb441bc Merge branch 'dt-for-v4.21' into for-=
next)
Merging at91/at91-next (3850dd7a32a0 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (9ef81d65b288 Merge branch 'bcm2835-dt-64-next' in=
to for-next)
Merging imx-mxs/for-next (0b886de8f8db Merge branch 'imx/maintainers' into =
for-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (ecee13a082e0 Merge branch 'v5.0-next/dts64' into=
 for-next)
Merging mvebu/for-next (b5f034845e70 ARM: dts: kirkwood: Fix polarity of GP=
IO fan lines)
Merging omap/for-next (ace233293086 Merge branch 'omap-for-v4.21/dt' into f=
or-next)
Merging reset/reset/next (d3490aa43e56 reset: socfpga: declare socfpga_rese=
t_init in a header file)
Merging qcom/for-next (a3ece12f1917 Merge branch 'arm64-for-5.1' into all-f=
or-5.1)
Merging renesas/next (8a7c2bd44677 Merge branch 'arm64-dt-for-v5.1' into ne=
xt)
Merging rockchip/for-next (9290e9a9def3 Merge branch 'v5.1-armsoc/dts64' in=
to for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (2e625e23d6bf Merge branch 'next/defconfig' i=
nto for-next)
Merging sunxi/sunxi/for-next (69ac2faf3bc9 Merge branch 'sunxi/fixes-for-5.=
0' into sunxi/for-next)
Merging tegra/for-next (2731820ce27b Merge branch for-4.21/clk into for-nex=
t)
Merging clk/clk-next (960fc67321e4 Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (bfeffd155283 Linux 5.0-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (b8f80b1d2072 csky: fixup _PAGE_GLOBAL bit for 610 =
tlb entry)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (005e13a96c0e m68k: Generate uapi header and syscall =
table header files)
Merging m68knommu/for-next (3bd6e94bec12 arch: restore generic-y +=3D shmpa=
ram.h for some architectures)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (adcc81f148d7 MIPS: math-emu: Write-protect delay sl=
ot emulation pages)
Merging nds32/next (bfeffd155283 Linux 5.0-rc1)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (0c1d7fc698da CREDITS/MAINTAINERS: Adjust parisc=
-linux.org email addresses)
Merging powerpc/next (bfeffd155283 Linux 5.0-rc1)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (801009424e05 Fix a handful of audit-related issue)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (a28028959ea8 s390/hypfs: Use struct_size() in kzallo=
c())
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (940b241d9050 um: Remove obsolete reenable_XX calls)
Merging xtensa/xtensa-for-next (f1589f675d65 Merge branch 'xtensa-jumplabel=
' into xtensa-for-next)
Merging fscrypt/master (cc0146d0bce0 fscrypt: remove CRYPTO_CTR dependency)
CONFLICT (content): Merge conflict in fs/ubifs/Kconfig
CONFLICT (content): Merge conflict in fs/f2fs/dir.c
CONFLICT (content): Merge conflict in Documentation/filesystems/index.rst
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (0078a3f8bf05 Merge branch 'for-next-current-v=
4.19-20181219' into for-next-20181219)
Merging ceph/master (85f5a4d666fd rbd: don't return 0 on unmap if RBD_DEV_F=
LAG_REMOVING is set)
Merging cifs/for-next (1c7fc5cbc339 Linux 5.0-rc2)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (3f0216106126 Pull quota locking fix.)
Merging ext4/dev (191ce17876c9 ext4: fix special inode number checks in __e=
xt4_iget())
Merging f2fs/dev (cd2dcebde8b8 f2fs: sync filesystem after roll-forward rec=
overy)
Merging fuse/for-next (03bcbf09c2fd Merge branch 'scalability' into for-nex=
t)
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (3bd6e94bec12 arch: restore generic-y +=3D shmparam.=
h for some architectures)
Merging nfs-anna/linux-next (e7f45099442a sunrpc: kernel BUG at kernel/cred=
.c:825!)
Merging nfsd/nfsd-next (92d669f210de svcrpc: fix unlikely races preventing =
queueing of sockets)
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (ec7ba118b940 Revert "ovl: relax permissio=
n checking on underlying layers")
Merging ubifs/linux-next (e58725d51fa8 ubifs: Handle re-linking of inodes c=
orrectly while recovery)
Merging v9fs/9p-next (574d356b7a02 9p/net: put a lower bound on msize)
Merging xfs/for-next (90be9b86da90 xfs: xfs_fsops: drop useless LIST_HEAD)
Merging file-locks/locks-next (bf77ae4c98d7 locks: fix error in locks_move_=
blocks())
Merging vfs/for-next (1fab5fff0a7a Merge branches 'work.mount', 'work.misc'=
, 'misc.misc' and 'work.iov_iter' into for-next)
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup-v1.c
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup-internal.h
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in fs/Makefile
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/resctrl/rdtgroup.c
Applying: vfs: work around CONFIG_PRINTK=3Dn in fs_context logging code
Merging printk/for-next (15ff2069cb7f printk: Add caller information to pri=
ntk() output.)
Merging pci/next (bfeffd155283 Linux 5.0-rc1)
Merging pstore/for-next/pstore (8665569e97dd pstore/ram: Avoid NULL deref i=
n ftrace merging failure path)
Merging hid/for-next (5664144391bd Merge branch 'for-5.1/hid-maltron' into =
for-next)
Merging i2c/i2c/for-next (bfeffd155283 Linux 5.0-rc1)
Merging i3c/i3c/next (25ac3da61ba1 i3c: master: cdns: fix I2C transfers in =
Cadence I3C master driver)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (dd336374267f hwmon: (pmbus) add support f=
or DPS-650AB)
Merging jc_docs/docs-next (5591a3075e95 Documentation: add ibmvmc to toctre=
e(index) and fix warnings)
Merging v4l-dvb/master (1e0d0a5fd381 media: s5p-mfc: fix incorrect bus assi=
gnment in virtual child device)
Merging v4l-dvb-next/master (76097fe1aee6 media: staging/ipu3-imgu: Add MAI=
NTAINERS entry)
CONFLICT (add/add): Merge conflict in Documentation/media/v4l-drivers/ipu3.=
rst
CONFLICT (add/add): Merge conflict in Documentation/media/uapi/v4l/pixfmt-m=
eta-intel-ipu3.rst
Merging fbdev/fbdev-for-next (00257e0cc550 fbdev: offb: Fix OF node name ha=
ndling)
Merging pm/linux-next (1c7fc5cbc339 Linux 5.0-rc2)
Merging cpufreq-arm/cpufreq/arm/linux-next (d4990efa8c5f cpufreq: qcom-hw: =
Move to device_initcall)
Merging cpupower/cpupower (bfeffd155283 Linux 5.0-rc1)
Merging opp/opp/linux-next (ade0c9493e97 Merge branch 'opp/genpd/propagatio=
n' into opp/linux-next)
Merging thermal/next (24ef9ec891c7 thermal/intel: fixup for Kconfig string =
parsing tightening up)
Merging thermal-soc/next (9d216211fded thermal: generic-adc: Fix adc to tem=
p interpolation)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (3595c559326d dlm: fix invalid cluster name warning)
Merging swiotlb/linux-next (da689221f952 xen/blkfront: avoid NULL blkfront_=
info dereference on device removal)
Merging rdma/for-next (0ada768517da RDMA/mlx5: Delete declaration of alread=
y removed function)
Merging net-next/master (b71acb0e3721 Merge branch 'linus' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging bpf-next/master (b71acb0e3721 Merge branch 'linus' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging ipsec-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging mlx5-next/mlx5-next (71bef2fd583b IB/mlx5: Introduce uid as part of=
 alloc/dealloc transport domain)
Merging netfilter-next/master (b71acb0e3721 Merge branch 'linus' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (4ad0be160544 brcmfmac: Use firmware_r=
equest_nowarn for the clm_blob)
Merging bluetooth/master (b71acb0e3721 Merge branch 'linus' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging mac80211-next/master (44a7b3b6e3a4 Merge branch 'bnxt_en-next')
Merging gfs2/for-next (8e143b90e4d4 Merge tag 'iommu-updates-v4.21' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/joro/iommu)
Merging mtd/mtd/next (f9d27de6fafc mtd: mtdram: Expose module parameters)
Merging nand/nand/next (732774437ae0 mtd: rawnand: sunxi: Write pageprog re=
lated opcodes to WCMD_SET)
Merging spi-nor/spi-nor/next (b422847877e3 mtd: spi-nor: Add support for is=
25lp016d)
Merging crypto/master (6b476662b09c crypto: algapi - reject NULL crypto_spa=
wn::inst)
Merging drm/drm-next (e3d093070eb0 Merge tag 'tilcdc-4.22' of https://githu=
b.com/jsarha/linux into drm-next)
Merging drm-intel/for-linux-next (305dc3f9834c drm/i915: Differentiate betw=
een ggtt->mutex and ppgtt->mutex)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_debugfs.c
Merging drm-tegra/drm/tegra/for-next (180b46ecdc9f drm/tegra: sor: Reset th=
e SOR if possible)
Merging drm-misc/for-linux-next (ed20151a7699 drm/vblank: Allow dynamic per=
-crtc max_vblank_count)
Merging drm-msm/msm-next (24937c540917 dt-bindings: drm/msm/a6xx: Document =
GMU and update GPU bindings)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (ab6911b73493 MAINTAINERS: Add maintai=
ner for Arm komeda driver)
Applying: drm/komeda: merge fix for drm_atomic_private_obj_init() API change
Merging imx-drm/imx-drm/next (6cec571b70ec drm/imx: ipuv3-plane: add functi=
on to query atomic update status)
Merging etnaviv/etnaviv/next (a20ca6744ba7 Build etnaviv on non-ARM archite=
ctures)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (b3ffce399349 Merge branch 'regmap-5.0' into regmap=
-linus)
Merging sound/for-next (36c346e1c581 ALSA: usb-audio: Remove set but not us=
ed variable 'first_ch_bits')
Merging sound-asoc/for-next (1a48ca129c0d Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (b6eba86030bf Input: edt-ft5x06 - add offset support for=
 ev-ft5726)
Merging block/for-next (c3f57725d1cc Merge branch 'for-4.21/block-late' int=
o for-next)
Merging device-mapper/for-next (bd938bf0b6cf Merge branch 'dm-4.20' into dm=
-next)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (e0fc4f56e724 mmc: sdhci-esdhc-imx: add DCMD support for C=
MDQ)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (3f2d347e851e mfd: exynos-lpass: Enable UART modul=
e support)
Merging backlight/for-backlight-next (3cee7a7d05b1 backlight: 88pm860x_bl: =
Use of_node_name_eq for node name comparisons)
Merging battery/for-next (958091396648 power: supply: bq25890: fix BAT_COMP=
 field definition)
Merging regulator/for-next (1488c1d4973a Merge branch 'regulator-5.1' into =
regulator-next)
Merging security/next-testing (f30160f982fc Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (43aa09fee2f0 apparmor: Fix warning about un=
used function apparmor_ipv6_postroute)
Merging integrity/next-integrity (eed9de3b4f47 ima: Use inode_is_open_for_w=
rite)
Merging selinux/next (53e0c2aa9a59 selinux: do not override context on cont=
ext mounts)
Merging tpmdd/next (9488585b21be tpm: add support for partial reads)
Merging watchdog/master (4a22fc534f2f watchdog: tqmx86: Fix a couple IS_ERR=
() vs NULL bugs)
Merging iommu/next (33798a966b8b Merge branches 'iommu/fixes', 'arm/msm', '=
x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (8ba35b3a0046 vfio-mdev/samples: Use u8 instead of char f=
or handle functions)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (9e36a5d49c3a audit: hand taken context to audit_kill_tr=
ees for syscall logging)
Merging devicetree/for-next (5801169a2ed2 of: __of_detach_node() - remove n=
ode from phandle cache)
Merging mailbox/mailbox-for-next (d69e11648e48 mailbox: tegra-hsp: Use devi=
ce-managed registration API)
Merging spi/for-next (b0e53a04479a Merge branch 'spi-5.1' into spi-next)
Merging tip/auto-latest (36e910f755f8 Merge branch 'x86/urgent')
Merging clockevents/clockevents/next (bd2bcaa565a2 Merge branch 'clockevent=
s/4.21' of http://git.linaro.org/people/daniel.lezcano/linux into timers/co=
re)
Merging edac-amd/for-next (75dfa87035f9 EDAC, fsl_ddr: Add LS1021A to the l=
ist of supported hardware)
Merging irqchip/irq/irqchip-next (fb94109b764e irqchip/stm32: protect confi=
guration registers with hwspinlock)
Merging ftrace/for-next (3d739c1f6156 tracing: Use the return of str_has_pr=
efix() to remove open coded numbers)
Merging rcu/rcu/next (f25bcbbbf561 Merge LKMM and RCU commits)
Merging kvm/linux-next (bfeffd155283 Linux 5.0-rc1)
Merging kvm-arm/next (8c33df1afd86 arm: KVM: Add S2_PMD_{MASK,SIZE} constan=
ts)
Merging kvm-ppc/kvm-ppc-next (ae59a7e1945b KVM: PPC: Book3S HV: Keep rc bit=
s in shadow pgtable in sync with host)
Merging kvms390/next (7aedd9d48f2a KVM: s390: fix kmsg component kvm-s390)
Merging xen-tip/linux-next (5268c8f39e0e always clear the X2APIC_ENABLE bit=
 for PV guest)
Merging percpu/for-next (718f6757a29b Merge branch 'for-4.21' into for-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (bfeffd155283 Linux 5.0-rc1)
Merging chrome-platform/for-next (bfeffd155283 Linux 5.0-rc1)
Merging hsi/for-next (3a658e09a215 HSI: omap_ssi: Change to use DEFINE_SHOW=
_ATTRIBUTE macro)
Merging leds/for-next (8146aace60c7 led: triggers: Initialize LED_INIT_DEFA=
ULT_TRIGGER if trigger is brought after class)
Merging ipmi/for-next (d09eac7d08aa ipmi: Don't initialize anything in the =
core until something uses it)
Merging driver-core/driver-core-next (a4723041857e driver core: drop use of=
 BUS_ATTR())
Merging usb/usb-next (6756f4c375db USB: core: urb: Use struct_size() in kma=
lloc())
Merging usb-gadget/next (4fe4f9fecc36 usb: dwc2: Fix disable all EP's on di=
sconnect)
Merging usb-serial/usb-next (bfeffd155283 Linux 5.0-rc1)
Merging usb-chipidea-next/ci-for-usb-next (9049fce897ed usb: chipidea: imx:=
 allow to configure oc polarity on i.MX25)
Merging phy-next/next (3bd6e94bec12 arch: restore generic-y +=3D shmparam.h=
 for some architectures)
Merging tty/tty-next (385298abbe96 tty: serial: qcom_geni_serial: Use u32 f=
or register variables)
Merging char-misc/char-misc-next (4ad84cb56b00 mei: squash single_recv_buf =
into one bit in client properties)
Merging extcon/extcon-next (bfeffd155283 Linux 5.0-rc1)
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (bfeffd155283 Linux 5.0-rc1)
Merging staging/staging-next (4b03f3f4ccb8 staging: erofs: Add identifier f=
or function definition arguments)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (13ebd0668d7e MAINTAINERS: add a maintainer for the in=
terconnect API)
Merging slave-dma/next (8160320bd8eb Merge branch 'topic/imx' into next)
Merging cgroup/for-next (0623413ee0ba Merge branch 'for-4.21' into for-next)
Merging scsi/for-next (6de89c8b7dbe Merge branch 'misc' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
CONFLICT (content): Merge conflict in drivers/scsi/arcmsr/arcmsr_hba.c
Merging scsi-mkp/for-next (326a859b2814 scsi: ufs: Remove select of phy-qco=
m-ufs from ufs-qcom)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (7f86a211fabe virtio: use dependent_ptr_mb)
CONFLICT (content): Merge conflict in include/linux/compiler.h
CONFLICT (content): Merge conflict in drivers/virtio/virtio_ring.c
Merging rpmsg/for-next (e9856d7eb6e4 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (08589fe40380 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (1691632a2e16 gpio: pca953x: add support fo=
r pcal6416 type)
Merging pinctrl/for-next (489d4832bfba Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (38c7bc7c60f7 pwm: imx: Signedness bug in imx_pwm_get_=
state())
Merging userns/for-next (ee17e5d6201c signal: Make siginmask safe when pass=
ed a signal of 0)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (bfeffd155283 Linux 5.0-rc1)
Merging y2038/y2038 (e4b92b108c6c timekeeping: remove obsolete time accesso=
rs)
Merging livepatching/for-next (704f63ef69b5 Merge branch 'for-5.1/atomic-re=
place' into for-next)
Merging coresight/next (675e806209e0 coresight: Use of_node_name_eq for nod=
e name comparisons)
Merging rtc/rtc-next (c8c97a4fb52c rtc: isl1208: fix negative digital trim =
reporting)
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
Merging gnss/gnss-next (bfeffd155283 Linux 5.0-rc1)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (bfeffd155283 Linux 5.0-rc1)
Merging nvmem/for-next (bfeffd155283 Linux 5.0-rc1)
Merging xarray/xarray (19ba9ecf2418 XArray: Fix typo in comment)
Merging hyperv/hyperv-next (651022382c7f Linux 4.20-rc1)
Merging auxdisplay/auxdisplay (bfeffd155283 Linux 5.0-rc1)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (4607de57fff5 selftests: add tests for pidfd_send_si=
gnal())
Merging akpm-current/current (915ba99f044b ipc: conserve sequence numbers i=
n extended IPCMNI mode)
CONFLICT (content): Merge conflict in security/selinux/ss/services.c
CONFLICT (content): Merge conflict in mm/rmap.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: scripts/atomic/check-atomics.sh: don't assume that scripts are ex=
ecutable
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: locking/atomics: build atomic headers as required
Applying: kernel/fork.c: remove duplicated include
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (b16280f814de drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/epRTClWKnVuI9gW7BRZ0vK6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlw9U0gACgkQAVBC80lX
0GykOwf/UgW8cYVC2q5mwOcRfMNMiI+xYYD7i+9YPQDjgkEWMUurjJ3mdToRekCR
t50D6/XPnDPcJCXhlqX/aLDebAEb81a8UDLOG2p5WMhVKaFL0J+IdMNp3NVxGe2B
+xwZv/QLMvyPwb8xAXN83rpqCLKX/Qg+lzNExeTg8xSrDvVGlm1VnfY+ak+eyEsP
WpgS9cNtylu0C248hI+osYFVY/aMmlbqryxXFmxsyhQxItTmqcKzBTtNyfP+CH6/
frg5KzWROM4XaVe0SvKYWrHcV8PH8tS6H+MRGHQMUyvmlrQXiyT4Z4QIfkex3lfJ
YreulOngVpfsb6rSAOCevm9ARrh5sg==
=3vw1
-----END PGP SIGNATURE-----

--Sig_/epRTClWKnVuI9gW7BRZ0vK6--
