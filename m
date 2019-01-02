Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C4CC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A858F2089F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 05:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nD5kvDpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfABFqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 00:46:46 -0500
Received: from ozlabs.org ([203.11.71.1]:35773 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfABFqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 00:46:45 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43V0RL4rmrz9rxp;
        Wed,  2 Jan 2019 16:46:38 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1546407998;
        bh=PGPl/fNv5W+tZurxpfxnzWrsaBUIZvqsWJsEPQXjlv8=;
        h=Date:From:To:Cc:Subject:From;
        b=nD5kvDpEzqRQAUWMGpuiIDYUL1eKrFK3ZQ1eJHlfbASuA/QCoYhGsHSNVJwKiVcPF
         1+cMY6biu8u2gwoJ1Uku7rjxWPrQT0w4Bs5F7EB233qYj50Z8mwsJoZ97wjUes9F8U
         jcCaZcenO/8Ah4swC7FtWW6uHXdrbhfB50hExzxjvAmQd6COXRKPwF+YojbLFASFf+
         GmApfcN2pZjPXBJusM5/0sghnF9dCqHEQexuAKb2R/CI9qVIL7OWdOlkWCSPRfzhXu
         v9hjWybI0m/pZZxk1tHXpPMCflMHAEJdXiFBvcDyPCiqvx9quDp5qQVrgPCKCom9HT
         aWcEgfWEJn4vQ==
Date:   Wed, 2 Jan 2019 16:46:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 2
Message-ID: <20190102164637.50606f8b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dICq8uj1TbQjZgdTDDEhOYX"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/dICq8uj1TbQjZgdTDDEhOYX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any material destined for the next merge window to
your linux-next included trees until after -rc1 has been released.

Changes since 20181224:

The vfs tree gained conflicts against Linus' and the ext3 trees.  It also
gained a build failure for which I added a work around patch.

Non-merge commits (relative to Linus' tree): 1256
 1353 files changed, 46422 insertions(+), 20486 deletions(-)

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

I am currently merging 293 trees (counting Linus' and 69 trees of bug
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
Merging origin/master (28e8c4bc8eb4 Merge tag 'rtc-4.21' of git://git.kerne=
l.org/pub/scm/linux/kernel/git/abelloni/linux)
Merging fixes/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging kbuild-current/fixes (e1ef035d272e Merge tag 'armsoc-defconfig' of =
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc)
Merging arc-current/for-curr (5fac3149be6f ARC: adjust memblock_reserve of =
kernel memory)
Merging arm-current/fixes (c2a3831df6dc ARM: 8816/1: dma-mapping: fix poten=
tial uninitialized return)
Merging arm64-fixes/for-next/fixes (3238c359acee arm64: dma-mapping: Fix FO=
RCE_CONTIGUOUS buffer clearing)
Merging m68k-current/for-linus (bed1369f5190 m68k: Fix memblock-related cra=
shes)
Merging powerpc-fixes/fixes (a225f1567405 powerpc/ptrace: replace ptrace_re=
port_syscall() with a tracehook call)
Merging sparc/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (e888402789b9 net: hns3: call hns3_nic_net_open() while =
doing HNAE3_UP_CLIENT)
Merging bpf/master (8b6b25cf93b7 selftests/bpf: fix error printing in test_=
devmap())
Merging ipsec/master (3061169a47ee Merge git://git.kernel.org/pub/scm/linux=
/kernel/git/bpf/bpf)
Merging netfilter/master (a007232066f6 netfilter: nf_conncount: fix argumen=
t order to find_next_bit)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (53884577fbce ath10k: skip sending quiet mo=
de cmd for WCN3990)
Merging mac80211/master (1d51b4b1d3f2 Merge tag 'm68k-for-v4.20-tag2' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k)
Merging rdma-fixes/for-rc (37fbd834b4e4 IB/core: Fix oops in netdev_next_up=
per_dev_rcu())
Merging sound-current/for-linus (63d2a9ec310d ALSA: hda/tegra: clear pendin=
g irq handlers)
Merging sound-asoc-fixes/for-linus (6cb3c5b355ab Merge branch 'asoc-4.20' i=
nto asoc-linus)
Merging regmap-fixes/for-linus (8fe28cb58bcb Linux 4.20)
Merging regulator-fixes/for-linus (c8c6b9fda37f Merge branch 'regulator-4.2=
0' into regulator-linus)
Merging spi-fixes/for-linus (21929ad56551 Merge branch 'spi-4.20' into spi-=
linus)
Merging pci-current/for-linus (1063a5148ac9 PCI/AER: Queue one GHES event, =
not several uninitialized ones)
Merging driver-core.current/driver-core-linus (195303136f19 Merge tag 'kcon=
fig-v4.21-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/lin=
ux-kbuild)
Merging tty.current/tty-linus (195303136f19 Merge tag 'kconfig-v4.21-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging usb.current/usb-linus (195303136f19 Merge tag 'kconfig-v4.21-2' of =
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging usb-gadget-fixes/fixes (069caf5950df USB: omap_udc: fix rejection o=
f out transfers when DMA is used)
Merging usb-serial-fixes/usb-linus (28a86092b175 USB: serial: option: add T=
elit LN940 series)
Merging usb-chipidea-fixes/ci-for-usb-stable (a930d8bd94d8 usb: chipidea: A=
lways build ULPI code)
Merging phy/fixes (c88520db18ba phy: qcom-qusb2: Fix HSTX_TRIM tuning with =
fused value for SDM845)
Merging staging.current/staging-linus (195303136f19 Merge tag 'kconfig-v4.2=
1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuil=
d)
Merging char-misc.current/char-misc-linus (195303136f19 Merge tag 'kconfig-=
v4.21-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-k=
build)
Merging soundwire-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging thunderbolt-fixes/fixes (8fe28cb58bcb Linux 4.20)
Merging input-current/for-linus (592b15ba7260 Merge branch 'next' into for-=
linus)
Merging crypto-current/master (c79b411eaa72 crypto: skcipher - remove remna=
nts of internal IV generators)
Merging ide/master (adf040ddd001 ide: Use of_node_name_eq for node name com=
parisons)
Merging vfio-fixes/for-linus (0e714d27786c vfio/pci: Fix potential Spectre =
v1)
Merging kselftest-fixes/fixes (2bd61abead58 selftests/seccomp: Remove SIGST=
OP si_pid check)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (ffe843b18211 dmaengine: dw: Fix FIFO size fo=
r Intel Merrifield)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (40b412897ccb mtd: nand: Fix memory allocation in =
nanddev_bbt_init())
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (078ab3ea2c3b media: Add a Kconfig option for t=
he Request API)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (db1ce3f5d01d MIPS: Fix a R10000_LLSC_WAR log=
ic in atomic.h)
CONFLICT (content): Merge conflict in arch/mips/ralink/Kconfig
CONFLICT (content): Merge conflict in MAINTAINERS
Merging at91-fixes/at91-fixes (4ab7ca092c3c ARM: dts: at91: sama5d2: use th=
e divided clock for SMC)
Merging omap-fixes/fixes (84fb6c7feb14 ARM: dts: Fix OMAP4430 SDP Ethernet =
startup)
Merging kvm-fixes/master (3cf85f9f6bd7 KVM: x86: nSVM: fix switch to guest =
mmu)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (1fcbdf7c2122 hwmon: (lm80) Fix missing unlock on=
 error in set_fan_div())
Merging nvdimm-fixes/libnvdimm-fixes (2c5357c6a2f2 Merge branch 'for-4.20/d=
ax-fixes' into libnvdimm-pending)
Merging btrfs-fixes/next-fixes (72549bc085d6 Merge branch 'misc-4.20' into =
next-fixes)
Merging vfs-fixes/fixes (ea5751ccd665 proc/sysctl: don't return ENOMEM on l=
ookup when a table is unregistering)
Merging dma-mapping-fixes/for-linus (c92a54cfa025 dma-direct: do not includ=
e SME mask in the DMA supported check)
Merging i3c-fixes/master (651022382c7f Linux 4.20-rc1)
Merging drivers-x86-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging samsung-krzk-fixes/fixes (651022382c7f Linux 4.20-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (ab63e725b49c Merge tag 'for_linus' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost)
Merging scsi-fixes/fixes (61cce6f6eece scsi: sd: use mempool for discard sp=
ecial page)
Merging drm-fixes/drm-fixes (b6aac625e579 Merge tag 'drm-misc-fixes-2018-12=
-20' of git://anongit.freedesktop.org/drm/drm-misc into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (8fe28cb58bcb Linux 4.20)
Merging mmc-fixes/fixes (e3ae3401aa19 mmc: core: Use a minimum 1600ms timeo=
ut when enabling CACHE ctrl)
Merging rtc-fixes/rtc-fixes (9bde0afb7a90 rtc: pcf2127: fix a kmemleak caus=
ed in pcf2127_i2c_gather_write)
Merging gnss-fixes/gnss-linus (40e020c129cf Linux 4.20-rc6)
Merging hyperv-fixes/hyperv-fixes (fda2485b9ca4 Drivers: hv: vmbus: Check f=
or ring when getting debug info)
Merging drm-misc-fixes/for-linux-next-fixes (505b5240329b drm/ioctl: Fix Sp=
ectre v1 vulnerabilities)
Merging kbuild/for-next (e1ef035d272e Merge tag 'armsoc-defconfig' of git:/=
/git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc)
Merging compiler-attributes/compiler-attributes (71391bdd2e9a include/linux=
/compiler_types.h: don't pollute userspace with macro definitions)
Merging leaks/leaks-next (9f84a0f7f1a6 leaking_addresses: check if file nam=
e contains address)
Merging dma-mapping/for-next (8b1cce9f5832 dma-mapping: fix inverted logic =
in dma_supported)
Merging asm-generic/master (2b3c5a99d5f3 sh: generate uapi header and sysca=
ll table header files)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (8f839a25b9cc Merge branches 'fixes', 'misc', 'sa1100-=
for-next', 'smp-hotplug' (early part) and 'spectre' into for-next)
Merging arm64/for-next/core (12f799c8c739 arm64: kaslr: print PHYS_OFFSET i=
n dump_kernel_offset())
Merging arm-perf/for-next/perf (69c32972d593 drivers/perf: Add Cavium Thund=
erX2 SoC UNCORE PMU driver)
Merging arm-soc/for-next (d60a40a46570 ARM: Document merges)
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (b28b14c7c157 Merge branch 'v4.21/drivers' into tm=
p/aml-rebuild)
Merging aspeed/for-next (f59cffb441bc Merge branch 'dt-for-v4.21' into for-=
next)
Merging at91/at91-next (d3d7c4c30eb2 Merge branches 'at91-soc' and 'at91-dt=
' into at91-next)
Merging bcm2835/for-next (3c9d403d2fe1 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (467e1ec42943 Merge branch 'imx8mq/dt' into for-ne=
xt)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (c2f7a6c7e1e5 Merge branch 'v4.20-next/soc' into =
for-next)
Merging mvebu/for-next (50eba438c55e Merge branch 'mvebu/dt64' into mvebu/f=
or-next)
Merging omap/for-next (ace233293086 Merge branch 'omap-for-v4.21/dt' into f=
or-next)
Merging reset/reset/next (8a1b9fd55f25 reset: uniphier-glue: Add AHCI reset=
 control support in glue layer)
CONFLICT (content): Merge conflict in arch/arm/mach-socfpga/socfpga.c
Merging qcom/for-next (9bf0624f555d Merge tag 'qcom-drivers-for-4.21-2' int=
o foobar-for-4.21-2)
Merging renesas/next (f0722e173448 Merge branches 'fixes-for-v4.21', 'fixes=
-for-v4.20', 'dt-bindings-for-v4.21', 'drivers-for-v4.21', 'arm-defconfig-f=
or-v4.21', 'arm-dt-for-v4.21' and 'arm64-dt-for-v4.21' into next)
Merging rockchip/for-next (70e6e2983473 dt-bindings: arm: Convert Rockchip =
board/soc bindings to json-schema)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (75c4a4541891 Merge branch 'next/dt64' into f=
or-next)
Merging sunxi/sunxi/for-next (0c42f6e65f0c Merge branches 'sunxi/dt-for-4.2=
1' and 'sunxi/dt64-for-4.21' into sunxi/for-next)
Merging tegra/for-next (2731820ce27b Merge branch for-4.21/clk into for-nex=
t)
Merging clk/clk-next (08972760d366 clk: imx8qxp: make the name of clock ID =
generic)
Merging clk-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (6256734f9173 csky: Add EM_CSKY_OLD 39)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (005e13a96c0e m68k: Generate uapi header and syscall =
table header files)
Merging m68knommu/for-next (40e020c129cf Linux 4.20-rc6)
Merging microblaze/next (19d111ccce9f microblaze: remove the explicit remov=
al of system.dtb)
Merging mips/mips-next (adcc81f148d7 MIPS: math-emu: Write-protect delay sl=
ot emulation pages)
Merging nds32/next (e2f3f8b4a497 nds32: support hardware prefetcher)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (b40df8f74254 parisc: Count IPI function calls)
Merging powerpc/next (12526b0d6c58 Merge branch 'next' of https://git.kerne=
l.org/pub/scm/linux/kernel/git/scottwood/linux into next)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (9c60096d499e automerging branch "kernel.org-palmer=
-linux/next-sg_chain" into "for-next")
CONFLICT (content): Merge conflict in arch/riscv/Kconfig
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (ec10574d00da Merge tag 'vfio-ccw-20181213' of git://=
git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into features)
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
Merging ceph/master (5ccedf1ccd71 ceph: don't encode inode pathes into reco=
nnect message)
Merging cifs/for-next (1f4b6df1eaa5 smb3: fix large reads on encrypted conn=
ections)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (3f0216106126 Pull quota locking fix.)
Merging ext4/dev (18f2c4fcebf2 ext4: check for shutdown and r/o file system=
 in ext4_write_inode())
Merging f2fs/dev (64beba0558fc f2fs: sanity check of xattr entry size)
Merging fuse/for-next (2e64ff154ce6 fuse: continue to send FUSE_RELEASEDIR =
when FUSE_OPEN returns ENOSYS)
Merging jfs/jfs-next (a83722f45c5b jfs: fix spelling mistake, EACCESS -> EA=
CCES)
Merging nfs/linux-next (e1ef035d272e Merge tag 'armsoc-defconfig' of git://=
git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc)
Merging nfs-anna/linux-next (5dada61b6b17 sunrpc: Add xprt after nfs4_test_=
session_trunk())
CONFLICT (modify/delete): net/sunrpc/xprtrdma/fmr_ops.c deleted in nfs-anna=
/linux-next and modified in HEAD. Version HEAD of net/sunrpc/xprtrdma/fmr_o=
ps.c left in tree.
$ git rm -f net/sunrpc/xprtrdma/fmr_ops.c
Merging nfsd/nfsd-next (0ad30ff67bd3 nfs: fixed broken compilation in nfs_c=
allback_up_net())
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (ec7ba118b940 Revert "ovl: relax permissio=
n checking on underlying layers")
Merging ubifs/linux-next (e58725d51fa8 ubifs: Handle re-linking of inodes c=
orrectly while recovery)
Merging v9fs/9p-next (574d356b7a02 9p/net: put a lower bound on msize)
Merging xfs/for-next (90be9b86da90 xfs: xfs_fsops: drop useless LIST_HEAD)
Merging file-locks/locks-next (052b8cfa4070 locks: Use inode_is_open_for_wr=
ite)
Merging vfs/for-next (1fab5fff0a7a Merge branches 'work.mount', 'work.misc'=
, 'misc.misc' and 'work.iov_iter' into for-next)
CONFLICT (content): Merge conflict in security/selinux/hooks.c
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup-v1.c
CONFLICT (content): Merge conflict in include/linux/fs.h
CONFLICT (content): Merge conflict in fs/Makefile
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/resctrl/rdtgroup.c
Merging printk/for-next (15ff2069cb7f printk: Add caller information to pri=
ntk() output.)
Merging pci/next (29222c0c280f Merge branch 'remotes/lorenzo/pci/uniphier')
Merging pstore/for-next/pstore (8665569e97dd pstore/ram: Avoid NULL deref i=
n ftrace merging failure path)
Merging hid/for-next (f8e8ae868301 Merge branch 'for-4.21/ish' into for-nex=
t)
Merging i2c/i2c/for-next (eb7dd4b831c0 Merge branch 'i2c/for-5.0' into i2c/=
for-next)
Merging i3c/i3c/next (25ac3da61ba1 i3c: master: cdns: fix I2C transfers in =
Cadence I3C master driver)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (9aa3aa15f4c2 hwmon: (lm80) fix a missing =
check of bus read in lm80 probe)
Merging jc_docs/docs-next (942104a21ce4 docs: improve pathname-lookup docum=
ent structure)
Merging v4l-dvb/master (4bd46aa0353e media: cx23885: only reset DMA on prob=
lematic CPUs)
Merging v4l-dvb-next/master (76097fe1aee6 media: staging/ipu3-imgu: Add MAI=
NTAINERS entry)
Merging fbdev/fbdev-for-next (2122b40580dd fbdev: fbcon: Fix unregister cra=
sh when more than one framebuffer)
Merging pm/linux-next (f4747b9c68b8 drivers: base: swnode: check if swnode =
is NULL before dereferencing it)
Merging cpupower/cpupower (901d32bc69f3 cpupower : Auto-completion for cpup=
ower tool)
Merging opp/opp/linux-next (ade0c9493e97 Merge branch 'opp/genpd/propagatio=
n' into opp/linux-next)
Merging thermal/next (eaaa598c0a28 Merge branches 'for-rc' and 'thermal-cor=
e' into next)
CONFLICT (content): Merge conflict in drivers/thermal/Kconfig
Applying: drivers: thermal: fixup for Kconfig string parsing tightening up
Merging thermal-soc/next (760eea43f8c6 thermal: da9062/61: Prevent hardware=
 access during system suspend)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (3595c559326d dlm: fix invalid cluster name warning)
Merging swiotlb/linux-next (da689221f952 xen/blkfront: avoid NULL blkfront_=
info dereference on device removal)
Merging rdma/for-next (f617e5ffe04f RDMA/srpt: Use kmem_cache_free() instea=
d of kfree())
Merging net-next/master (b71acb0e3721 Merge branch 'linus' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging bpf-next/master (b71acb0e3721 Merge branch 'linus' of git://git.ker=
nel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging ipsec-next/master (fa89a4593b92 xfrm6_tunnel: Fix spi check in __xf=
rm6_tunnel_alloc_spi)
Merging mlx5-next/mlx5-next (71bef2fd583b IB/mlx5: Introduce uid as part of=
 alloc/dealloc transport domain)
Merging netfilter-next/master (fa2323325e8b selftests: net: reuseport_addr_=
any: silence clang warning)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (fa2323325e8b selftests: net: reusepor=
t_addr_any: silence clang warning)
Merging bluetooth/master (b71acb0e3721 Merge branch 'linus' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging mac80211-next/master (44a7b3b6e3a4 Merge branch 'bnxt_en-next')
Merging gfs2/for-next (bc0205612bbd gfs2: take jdata unstuff into account i=
n do_grow)
Merging mtd/mtd/next (f366d3854ec0 Merge tag 'spi-nor/for-4.21' of git://gi=
t.infradead.org/linux-mtd into mtd/next)
Merging nand/nand/next (732774437ae0 mtd: rawnand: sunxi: Write pageprog re=
lated opcodes to WCMD_SET)
Merging spi-nor/spi-nor/next (b422847877e3 mtd: spi-nor: Add support for is=
25lp016d)
Merging crypto/master (c79b411eaa72 crypto: skcipher - remove remnants of i=
nternal IV generators)
Merging drm/drm-next (74136a3d47f5 Merge branch 'drm-next-4.21' of git://pe=
ople.freedesktop.org/~agd5f/linux into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
Merging drm-intel/for-linux-next (cb6f4c2c3478 Merge tag 'gvt-next-2018-12-=
07' of https://github.com/intel/gvt-linux into drm-intel-next-fixes)
Merging drm-tegra/drm/tegra/for-next (180b46ecdc9f drm/tegra: sor: Reset th=
e SOR if possible)
Merging drm-misc/for-linux-next (c75ff001f4fe drm: Put damage blob when des=
troy plane state)
Merging drm-msm/msm-next (99c66bc051e7 drm/msm: Unblock writer if reader cl=
oses file)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (fd99bd8b805c drm: malidp: Add the siz=
e of the superblocks when calculating total size for AFBC buffers)
Merging imx-drm/imx-drm/next (6cec571b70ec drm/imx: ipuv3-plane: add functi=
on to query atomic update status)
Merging etnaviv/etnaviv/next (801c7a1e5286 drm/etnaviv: remove lastctx memb=
er from gpu struct)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (d851a015bf3c Merge branch 'regmap-4.21' into regma=
p-next)
Merging sound/for-next (63d2a9ec310d ALSA: hda/tegra: clear pending irq han=
dlers)
Merging sound-asoc/for-next (b0b2b8feec72 Merge branch 'asoc-4.21' into aso=
c-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (1e3c336ad8f4 Input: atmel_mxt_ts - don't try to free un=
allocated kernel memory)
Merging block/for-next (c3f57725d1cc Merge branch 'for-4.21/block-late' int=
o for-next)
Merging device-mapper/for-next (bd938bf0b6cf Merge branch 'dm-4.20' into dm=
-next)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (5215b2e952f3 mmc: mediatek: Add MMC_CAP_SDIO_IRQ support)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (6e889719194d mfd: exynos-lpass: Enable UART modul=
e support)
Merging backlight/for-backlight-next (3cee7a7d05b1 backlight: 88pm860x_bl: =
Use of_node_name_eq for node name comparisons)
Merging battery/for-next (958091396648 power: supply: bq25890: fix BAT_COMP=
 field definition)
Merging regulator/for-next (f7c51a85cfe4 Merge branch 'regulator-4.21' into=
 regulator-next)
Merging security/next-testing (aa99a14dfb50 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (43aa09fee2f0 apparmor: Fix warning about un=
used function apparmor_ipv6_postroute)
Merging integrity/next-integrity (eed9de3b4f47 ima: Use inode_is_open_for_w=
rite)
Merging selinux/next (ee1a84fdfeed selinux: overhaul sidtab to fix bug and =
improve performance)
Merging tpmdd/next (9488585b21be tpm: add support for partial reads)
Merging watchdog/master (e3c21e088f89 watchdog: tqmx86: Add watchdog driver=
 for the IO controller)
Merging iommu/next (03ebe48e235f Merge branches 'iommu/fixes', 'arm/renesas=
', 'arm/mediatek', 'arm/tegra', 'arm/omap', 'arm/smmu', 'x86/vt-d', 'x86/am=
d' and 'core' into next)
CONFLICT (content): Merge conflict in arch/powerpc/kernel/iommu.c
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (8ba35b3a0046 vfio-mdev/samples: Use u8 instead of char f=
or handle functions)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (d406db524c32 audit: remove duplicated include from audi=
t.c)
Merging devicetree/for-next (5801169a2ed2 of: __of_detach_node() - remove n=
ode from phandle cache)
Merging mailbox/mailbox-for-next (d69e11648e48 mailbox: tegra-hsp: Use devi=
ce-managed registration API)
Merging spi/for-next (eaf986d9631f Merge branch 'spi-4.21' into spi-next)
Merging tip/auto-latest (8500c25e42f3 Merge branch 'sched/urgent')
Merging clockevents/clockevents/next (bd2bcaa565a2 Merge branch 'clockevent=
s/4.21' of http://git.linaro.org/people/daniel.lezcano/linux into timers/co=
re)
Merging edac-amd/for-next (75dfa87035f9 EDAC, fsl_ddr: Add LS1021A to the l=
ist of supported hardware)
Merging irqchip/irq/irqchip-next (fb94109b764e irqchip/stm32: protect confi=
guration registers with hwspinlock)
Merging ftrace/for-next (3d739c1f6156 tracing: Use the return of str_has_pr=
efix() to remove open coded numbers)
Merging rcu/rcu/next (06aa5694f870 Merge LKMM and RCU commits)
CONFLICT (add/add): Merge conflict in tools/memory-model/scripts/runlitmush=
ist.sh
CONFLICT (add/add): Merge conflict in tools/memory-model/scripts/parseargs.=
sh
CONFLICT (add/add): Merge conflict in tools/memory-model/scripts/newlitmush=
ist.sh
CONFLICT (add/add): Merge conflict in tools/memory-model/scripts/judgelitmu=
s.sh
CONFLICT (add/add): Merge conflict in tools/memory-model/scripts/initlitmus=
hist.sh
CONFLICT (add/add): Merge conflict in tools/memory-model/scripts/checklitmu=
shist.sh
CONFLICT (add/add): Merge conflict in tools/memory-model/scripts/checkghlit=
mus.sh
Merging kvm/linux-next (a0aea130afeb KVM: x86: Add CPUID support for new in=
struction WBNOINVD)
Merging kvm-arm/next (8c33df1afd86 arm: KVM: Add S2_PMD_{MASK,SIZE} constan=
ts)
Merging kvm-ppc/kvm-ppc-next (ae59a7e1945b KVM: PPC: Book3S HV: Keep rc bit=
s in shadow pgtable in sync with host)
Merging kvms390/next (7aedd9d48f2a KVM: s390: fix kmsg component kvm-s390)
Merging xen-tip/linux-next (58f9d806d16a ALSA: xen-front: Use Xen common sh=
ared buffer implementation)
Merging percpu/for-next (718f6757a29b Merge branch 'for-4.21' into for-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (fb7255a92311 platform/x86: mlx-platform: Conv=
ert to use SPDX identifier)
Merging chrome-platform/for-next (2a70a4cda0da MAINTAINERS: platform/chrome=
: Add Enric as a maintainer)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging hsi/for-next (3a658e09a215 HSI: omap_ssi: Change to use DEFINE_SHOW=
_ATTRIBUTE macro)
Merging leds/for-next (8146aace60c7 led: triggers: Initialize LED_INIT_DEFA=
ULT_TRIGGER if trigger is brought after class)
Merging ipmi/for-next (d09eac7d08aa ipmi: Don't initialize anything in the =
core until something uses it)
Merging driver-core/driver-core-next (195303136f19 Merge tag 'kconfig-v4.21=
-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging usb/usb-next (195303136f19 Merge tag 'kconfig-v4.21-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging usb-gadget/next (4fe4f9fecc36 usb: dwc2: Fix disable all EP's on di=
sconnect)
Merging usb-serial/usb-next (8d503f206c33 USB: serial: pl2303: add ids for =
Hewlett-Packard HP POS pole displays)
Merging usb-chipidea-next/ci-for-usb-next (9049fce897ed usb: chipidea: imx:=
 allow to configure oc polarity on i.MX25)
Merging phy-next/next (2e38c2e7026a phy: qcom-qmp: Expose provided clocks t=
o DT)
Merging tty/tty-next (195303136f19 Merge tag 'kconfig-v4.21-2' of git://git=
.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging char-misc/char-misc-next (195303136f19 Merge tag 'kconfig-v4.21-2' =
of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging extcon/extcon-next (a2dc50914744 extcon: max8997: Fix lack of path =
setting in USB device mode)
Merging soundwire/next (b1635596860d soundwire: intel: constify snd_soc_dai=
_ops structures)
Merging thunderbolt/next (dcc3c9e37fbd thunderbolt: Export IOMMU based DMA =
protection support to userspace)
Merging staging/staging-next (195303136f19 Merge tag 'kconfig-v4.21-2' of g=
it://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (f8325633fbae MAINTAINERS: add a maintainer for the in=
terconnect API)
Merging slave-dma/next (8fc4a3d104a3 Merge branch 'topic/fsl' into next)
Merging cgroup/for-next (0623413ee0ba Merge branch 'for-4.21' into for-next)
Merging scsi/for-next (1f0fe08f8a45 Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (da7903092b88 scsi: isci: request: mark expected =
switch fall-through)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (18a3b9c92547 PCI: avoid bridge feature re-probing=
 on hotplug)
Merging rpmsg/for-next (f369d7f18308 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (18a6d70e28cf Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (1a9430db2835 ima: cleanup the match_token =
policy code)
Merging pinctrl/for-next (88cc9fc41c73 dt-bindings: arm: fsl-scu: add imx8q=
m pinctrl support)
Merging pinctrl-samsung/for-next (651022382c7f Linux 4.20-rc1)
Merging pwm/for-next (e94b815524f8 dt-bindings: pwm: rcar: Add r8a774c0 sup=
port)
Merging userns/for-next (1e9c75fb9c47 mnt: fix __detach_mounts infinite loo=
p)
Merging ktest/for-next (6cd110a91f52 ktest: Take submenu into account for g=
rub2 menus)
Merging random/dev (05cbbb6f9ed5 drivers/char/random.c: make primary_crng s=
tatic)
Merging kselftest/next (283ac6d5fb2a selftests: Fix test errors related to =
lib.mk khdr target)
Merging y2038/y2038 (e4b92b108c6c timekeeping: remove obsolete time accesso=
rs)
Merging livepatching/for-next (bd0ab5efe8ec Merge branch 'for-4.21/upstream=
' into for-next)
Merging coresight/next (7ff8957175d6 coresight: Use of_node_name_eq for nod=
e name comparisons)
Merging rtc/rtc-next (36e14f5fdfdf rtc: rename core files)
Merging nvdimm/libnvdimm-for-next (8a6f7591ddf5 Merge branch 'for-5.0/dax' =
into libnvdimm-for-next)
Merging at24/at24/for-next (37cf28d3b5bc eeprom: at24: add support for 24c2=
048)
Merging ntb/ntb-next (d9842b39e9ec ntb_hw_switchtec: Added support of >=3D4=
G memory windows)
Merging kspp/for-next/kspp (be1944712d8e Merge branch 'for-next/gcc-plugin/=
arm-stackprotector' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging cisco/for-next (84a401a27506 Merge branch 'for-x86' into for-next)
CONFLICT (content): Merge conflict in arch/x86/kernel/setup.c
Merging gnss/gnss-next (2595646791c3 Linux 4.20-rc5)
Merging fsi/master (d20810530b71 fsi: fsi-scom.c: Remove duplicate header)
Merging siox/siox/next (1e4b044d2251 Linux 4.18-rc4)
Merging slimbus/for-next (39a577fe6163 slimbus: ngd: fix spelling mistake "=
exeeds" -> "exceeds")
Merging nvmem/for-next (5035d66cc629 nvmem: meson-efuse: add peripheral clo=
ck)
CONFLICT (content): Merge conflict in include/linux/nvmem-provider.h
Merging xarray/xarray (48483614de97 XArray: Fix xa_alloc when id exceeds ma=
x)
Merging hyperv/hyperv-next (651022382c7f Linux 4.20-rc1)
Merging auxdisplay/auxdisplay (d4683eee8cd6 auxdisplay: charlcd: fix x/y co=
mmand parsing)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Applying: vfs: work around CONFIG_PRINTK=3Dn in fs_context logging code
Merging akpm-current/current (e2230989e259 ipc: conserve sequence numbers i=
n extended IPCMNI mode)
$ git checkout -b akpm remotes/origin/akpm/master
Applying: scripts/atomic/check-atomics.sh: don't assume that scripts are ex=
ecutable
Applying: mm: treewide: remove unused address argument from pte_alloc funct=
ions
Applying: mm-treewide-remove-unused-address-argument-from-pte_alloc-functio=
ns-v2-fix
Applying: mm: speed up mremap by 20x on large regions
Applying: mm/mremap: fix 'move_normal_pmd' unused function warning
Applying: mm: select HAVE_MOVE_PMD on x86 for faster mremap
Applying: kernel/async.c: remove some duplicated includes
Applying: kernel/signal.c: remove some duplicated includes
Applying: locking/atomics: build atomic headers as required
Applying: mm: balloon: update comment about isolation/migration/compaction
Applying: mm: convert PG_balloon to PG_offline
Applying: mm-convert-pg_balloon-to-pg_offline-fix
Applying: kexec: export PG_offline to VMCOREINFO
Applying: xen/balloon: mark inflated pages PG_offline
Applying: hv_balloon: mark inflated pages PG_offline
Applying: vmw_balloon: mark inflated pages PG_offline
Applying: vmw_balloon-mark-inflated-pages-pg_offline-v2
Applying: PM/Hibernate: use pfn_to_online_page()
Applying: PM/Hibernate: exclude all PageOffline() pages
Applying: pm-hibernate-exclude-all-pageoffline-pages-v2
Applying: kernel/locking/mutex.c: remove caller signal_pending branch predi=
ctions
Applying: kernel/sched/: remove caller signal_pending branch predictions
Applying: arch/arc/mm/fault.c: remove caller signal_pending_branch predicti=
ons
Applying: mm/: remove caller signal_pending branch predictions
Applying: fs/: remove caller signal_pending branch predictions
Applying: fs-remove-caller-signal_pending-branch-predictions-fix
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: fs: don't open code lru_to_page()
Applying: drivers/base/platform.c: kmemleak ignore a known leak
Applying: docs: fix Co-Developed-by docs
Applying: checkpatch: add Co-developed-by to signature tags
Applying: mm/page_io.c: fix polled swap page in
Applying: kernel/fork.c: remove duplicated include
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Applying: openvswitch: convert to kvmalloc
Applying: md: convert to kvmalloc
Applying: selinux: convert to kvmalloc
Applying: Generic radix trees
Applying: proc: commit to genradix
Applying: sctp: convert to genradix
Applying: Drop flex_arrays
Merging akpm/master (90775de4d86b Drop flex_arrays)

--Sig_/dICq8uj1TbQjZgdTDDEhOYX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwsUD0ACgkQAVBC80lX
0GzhLgf+O3i6vMMbNN6W6IXkJnk44KwYrJ9qmts8EMdi54TvdmrTWjAHR24lP4gU
x1ynLbXCReD2xllXOez9AIPy4NM3IzJOUhM/++ncds7wyNvhyVZePpNwmMAGoCJC
Ftz1vjgdLKNGSOihDdCV6FPAXXqXLL87kv9hQthYWFWQmmr5FiMAASjvtRtH5zgP
eFOjY4zibZCI01P1L3WjgrDSkyYrH2q6tNrbLMPVIVPZqxumrlsDcmFW1TYUBGrI
4rWm8sNT8j6yv6IT494SmdhMAhHFdew/y/4ngoMqbKWNwgzPFq5XjLUvrogHHV1d
KBBs6uH7rZ/mzRxvcOxSMEacYgilCw==
=iAKX
-----END PGP SIGNATURE-----

--Sig_/dICq8uj1TbQjZgdTDDEhOYX--
