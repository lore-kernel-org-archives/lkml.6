Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB8C282C9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB76820870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GvEbTXaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfAVEgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:36:55 -0500
Received: from ozlabs.org ([203.11.71.1]:35583 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfAVEgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:36:54 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43kFxY6DMwz9s4s;
        Tue, 22 Jan 2019 15:36:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548131809;
        bh=VdIDCMfryu8dn5ySABK8krvzjeQa2oy0DFumvCC4EVI=;
        h=Date:From:To:Cc:Subject:From;
        b=GvEbTXaGGeLQ1DCay97l3IgyMpFIaKZ6cKbkG3ZZSuZ6/YNK7hgf/rRyQlpiv37CB
         fwvWoi7mOgZKJmlEWphu4t4ZOM5ASncEngOwqQuTvizpIScXxNfg1prPimjjYjqz0K
         PSdQxJqLfAoChLjKw8UqxYq7CLdWZOLMlaMV+oaBlm8cpnIipBgMaBEZ3ztSxcIMs3
         DFs802eIK5vjMHCiz42Ic0SXqu9G3EvNMXTh37AqRr6ykRt/JOzyW269HV9R6tYpPM
         yKYZVFAVAZkak4ROYdmfLFU4C3ceA1nurhFczPfZ4NdNQhs7k/KlGbmWyv56P9s7x4
         FCMQobJaesW6A==
Date:   Tue, 22 Jan 2019 15:36:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 22
Message-ID: <20190122153649.77efe7cc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/raH0W59RnBwsuyv+Py2Nz9Z"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/raH0W59RnBwsuyv+Py2Nz9Z
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190121:

The vfs tree still had its build failure for which I applied a patch.

The netfilter-next tree still had its build failures but I applied some
supplied patches.

The mali-dp tree still had its failure for which I applied a merge
fix patch.

The pidfd tree changed its conflict against the y2038 tree.

The akpm tree gained a conflict against the kbuild tree.

Non-merge commits (relative to Linus' tree): 2882
 3171 files changed, 98258 insertions(+), 63840 deletions(-)

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
Merging origin/master (52e60b754438 Merge tag 'iommu-fixes-v5.0-rc3' of git=
://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu)
Merging fixes/master (d8d0c3a7f601 x86/syscalls: Mark expected switch fall-=
throughs)
Merging kbuild-current/fixes (49a57857aeea Linux 5.0-rc3)
Merging arc-current/for-curr (e6a72b7daeeb ARCv2: lib: memeset: fix doing p=
refetchw outside of buffer)
Merging arm-current/fixes (c2a3831df6dc ARM: 8816/1: dma-mapping: fix poten=
tial uninitialized return)
Merging arm64-fixes/for-next/fixes (7fa1e2e6afa7 kasan, arm64: remove redun=
dant ARCH_SLAB_MINALIGN define)
Merging m68k-current/for-linus (bed1369f5190 m68k: Fix memblock-related cra=
shes)
Merging powerpc-fixes/fixes (7bea7ac0ca01 powerpc/syscalls: Fix syscall tra=
cing)
Merging sparc/master (b71acb0e3721 Merge branch 'linus' of git://git.kernel=
.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (49a57857aeea Linux 5.0-rc3)
Merging bpf/master (e7c87bd6cc4e bpf: in __bpf_redirect_no_mac pull mac onl=
y if present)
Merging ipsec/master (e2612cd496e7 xfrm: Make set-mark default behavior bac=
kward compatible)
Merging netfilter/master (b2e3d68d1251 netfilter: nft_compat: destroy funct=
ion must not have side effects)
Merging ipvs/master (feb9f55c33e5 netfilter: nft_dynset: allow dynamic upda=
tes of non-anonymous set)
Merging wireless-drivers/master (ec5aecc0b227 iwlwifi: make IWLWIFI depend =
on CFG80211)
Merging mac80211/master (f9d672f1c2ca virt_wifi: fix error return code in v=
irt_wifi_newlink())
Merging rdma-fixes/for-rc (d6f4a21f309d RDMA/uverbs: Mark ioctl responses w=
ith UVERBS_ATTR_F_VALID_OUTPUT)
Merging sound-current/for-linus (699390381a7b ALSA: hda - Add mute LED supp=
ort for HP ProBook 470 G5)
Merging sound-asoc-fixes/for-linus (e19eb57017b2 Merge branch 'asoc-5.0' in=
to asoc-linus)
Merging regmap-fixes/for-linus (b3ffce399349 Merge branch 'regmap-5.0' into=
 regmap-linus)
Merging regulator-fixes/for-linus (1c386468e824 Merge branch 'regulator-5.0=
' into regulator-linus)
Merging spi-fixes/for-linus (e63f389c18de Merge branch 'spi-5.0' into spi-l=
inus)
Merging pci-current/for-linus (d2fd6e81912a PCI: Fix __initdata issue with =
"pci=3Ddisable_acs_redir" parameter)
Merging driver-core.current/driver-core-linus (1c7fc5cbc339 Linux 5.0-rc2)
Merging tty.current/tty-linus (27cfb3a53be4 tty: Handle problem if line dis=
cipline does not have receive_buf)
Merging usb.current/usb-linus (4f9b83892781 Merge tag 'usb-serial-5.0-rc3' =
of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into us=
b-linus)
Merging usb-gadget-fixes/fixes (87b6d2c56825 usb: dwc2: gadget: Fix Remote =
Wakeup interrupt bit clearing)
Merging usb-serial-fixes/usb-linus (527c1e567ead USB: serial: keyspan_usa: =
add proper SPDX lines for .h files)
Merging usb-chipidea-fixes/ci-for-usb-stable (d6d768a0ec3c usb: chipidea: f=
ix static checker warning for NULL pointer)
Merging phy/fixes (827cb0323928 phy: ath79-usb: Fix the main reset name to =
match the DT binding)
Merging staging.current/staging-linus (97715058b70d staging: rtl8723bs: Fix=
 build error with Clang when inlining is disabled)
Merging char-misc.current/char-misc-linus (d8e346eb3037 misc: pvpanic: fix =
warning implicit declaration)
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (49a57857aeea Linux 5.0-rc3)
Merging input-current/for-linus (d77651a227f8 Input: uinput - fix undefined=
 behavior in uinput_validate_absinfo())
Merging crypto-current/master (d45a90cb5d06 crypto: sm3 - fix undefined shi=
ft by >=3D width of value)
Merging ide/master (adf040ddd001 ide: Use of_node_name_eq for node name com=
parisons)
Merging vfio-fixes/for-linus (58fec830fc19 vfio/type1: Fix unmap overflow o=
ff-by-one)
Merging kselftest-fixes/fixes (3d244c192afe selftests/seccomp: Abort withou=
t user notification support)
Merging modules-fixes/modules-linus (be71eda5383f module: Fix display of wr=
ong module .text address)
Merging slave-dma-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging backlight-fixes/for-backlight-fixes (651022382c7f Linux 4.20-rc1)
Merging mtd-fixes/master (1c7fc5cbc339 Linux 5.0-rc2)
Merging spi-nor-fixes/spi-nor/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging mfd-fixes/for-mfd-fixes (48a2ca0ee399 Revert "mfd: cros_ec: Use dev=
m_kzalloc for private data")
Merging v4l-dvb-fixes/fixes (240809ef6630 media: vim2m: only cancel work if=
 it is for right context)
Merging reset-fixes/reset/fixes (26fce0557fa6 reset: imx7: Fix always writi=
ng bits as 0)
Merging mips-fixes/mips-fixes (8a644c64a9f1 MIPS: OCTEON: fix kexec support)
Merging at91-fixes/at91-fixes (bfeffd155283 Linux 5.0-rc1)
Merging omap-fixes/fixes (935853fa3e1b ARM: dts: omap3-gta04: Fix graph_por=
t warning)
Merging kvm-fixes/master (826c1362e79a x86/kvm/nVMX: don't skip emulated in=
struction twice when vmptr address is not backed)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (d7393226d15a Merge tag 'for-linus' of git://git.=
kernel.org/pub/scm/linux/kernel/git/rdma/rdma)
Merging nvdimm-fixes/libnvdimm-fixes (faa8bd6e12e6 libnvdimm/security: Fix =
nvdimm_security_state() state request selection)
Merging btrfs-fixes/next-fixes (1c7fc5cbc339 Linux 5.0-rc2)
Merging vfs-fixes/fixes (61aa329d0762 cgroup: saner refcounting for cgroup_=
root)
Merging dma-mapping-fixes/for-linus (222e3872c2de swiotlb: clear io_tlb_sta=
rt and io_tlb_end in swiotlb_exit)
Merging i3c-fixes/master (f29fd331aa05 i3c: master: dw-i3c-master: fix i3c_=
attach/reattach)
Merging drivers-x86-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging samsung-krzk-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (75a080cde08d powerpc: chrp: Use of_node_=
is_type to access device_type)
Merging scsi-fixes/fixes (9e8f1c798314 scsi: cxgb4i: add wait_for_completio=
n())
Merging drm-fixes/drm-fixes (9420151d88ca Merge branch 'linux-4.21' of git:=
//github.com/skeggsb/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (49a57857aeea Linux 5.0-rc3)
Merging mmc-fixes/fixes (2bd44dadd5bf mmc: sdhci-iproc: handle mmc_of_parse=
() errors during probe)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (a986435b3297 hv_netvsc: fix typos in cod=
e comments)
Merging drm-misc-fixes/for-linux-next-fixes (49a57857aeea Linux 5.0-rc3)
Merging kbuild/for-next (35a09846f9d7 kbuild: descend to scripts/kconfig/ d=
irectly when syncconfig is needed)
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
Merging arm64/for-next/core (5b498e139fb5 MAINTAINERS: Add LAKML list to AC=
PI for ARM64 entry)
Merging arm-perf/for-next/perf (c061ce249f9b dt-bindings: arm: Convert PMU =
binding to json-schema)
Merging arm-soc/for-next (f217b8e70c76 ARM: Document merges)
CONFLICT (content): Merge conflict in MAINTAINERS
Merging actions/for-next (fb9c1c1deb5e Merge branch 'v4.20/drivers+s900-sps=
' into next)
Merging alpine/alpine/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging amlogic/for-next (170993277576 Merge branch 'v5.1/dt64' into tmp/am=
l-rebuild)
Merging aspeed/for-next (d5e12a2c968d Merge branch 'aspeed-5.1-devicetree' =
into for-next)
Merging at91/at91-next (3850dd7a32a0 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (9ef81d65b288 Merge branch 'bcm2835-dt-64-next' in=
to for-next)
Merging imx-mxs/for-next (32cb82a0e36b Merge branch 'imx/maintainers' into =
for-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (ecee13a082e0 Merge branch 'v5.0-next/dts64' into=
 for-next)
Merging mvebu/for-next (b5f034845e70 ARM: dts: kirkwood: Fix polarity of GP=
IO fan lines)
Merging omap/for-next (ace233293086 Merge branch 'omap-for-v4.21/dt' into f=
or-next)
Merging reset/reset/next (c196cdc7659d reset: Add Broadcom STB SW_INIT rese=
t controller driver)
Merging qcom/for-next (a3ece12f1917 Merge branch 'arm64-for-5.1' into all-f=
or-5.1)
Merging renesas/next (352baaa81f86 Merge branch 'arm64-dt-for-v5.1' into ne=
xt)
Merging rockchip/for-next (0355b8299d0a Merge branch 'v5.1-armsoc/dts64' in=
to for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (2e625e23d6bf Merge branch 'next/defconfig' i=
nto for-next)
Merging sunxi/sunxi/for-next (69ac2faf3bc9 Merge branch 'sunxi/fixes-for-5.=
0' into sunxi/for-next)
Merging tegra/for-next (2731820ce27b Merge branch for-4.21/clk into for-nex=
t)
Merging clk/clk-next (1f7e1389516e Merge branch 'clk-fixes' into clk-next)
Merging clk-samsung/for-next (bfeffd155283 Linux 5.0-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (db0debb0f767 dt-bindings: interrupt-controller: Up=
date csky mpintc)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (28713169d879 m68k: Add -ffreestanding to CFLAGS)
Merging m68knommu/for-next (49a57857aeea Linux 5.0-rc3)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (f263f2a2c682 MIPS: Compile post DMA flush only when=
 needed)
Merging nds32/next (bfeffd155283 Linux 5.0-rc1)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (0293c953c7a4 CREDITS/MAINTAINERS: Adjust parisc=
-linux.org email addresses)
Merging powerpc/next (bfeffd155283 Linux 5.0-rc1)
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (801009424e05 Fix a handful of audit-related issue)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (6b8530b6520f Merge branch 'compat' of git://git.kern=
el.org/pub/scm/linux/kernel/git/s390/linux into features)
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
Merging btrfs-kdave/for-next (fd340d0f68cc btrfs: wakeup cleaner thread whe=
n adding delayed iput)
Merging ceph/master (74827ee29565 ceph: quota: cleanup license mess)
Merging cifs/for-next (10080377d0f5 smb3: Cleanup license mess)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (125892edfe69 inotify: Fix fd refcount leak in inotif=
y_add_watch().)
Merging ext4/dev (191ce17876c9 ext4: fix special inode number checks in __e=
xt4_iget())
Merging f2fs/dev (cd2dcebde8b8 f2fs: sync filesystem after roll-forward rec=
overy)
Merging fuse/for-next (cc4249fdc6c9 fuse: use atomic64_t for khctr)
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (52e60b754438 Merge tag 'iommu-fixes-v5.0-rc3' of gi=
t://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu)
Merging nfs-anna/linux-next (deaa5c96c2f7 SUNRPC: Address Kerberos performa=
nce/behavior regression)
Merging nfsd/nfsd-next (978c707df559 svcrdma: Use struct_size() in kmalloc(=
))
Merging orangefs/for-next (22fc9db296fc orangefs: no need to check for serv=
ice_operation returns > 0)
Merging overlayfs/overlayfs-next (2424e1c7256c overlayfs: During copy up, f=
irst copy up data and then xattrs)
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
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/resctrl/rdtgroup.c
Applying: vfs: work around CONFIG_PRINTK=3Dn in fs_context logging code
Merging printk/for-next (15ff2069cb7f printk: Add caller information to pri=
ntk() output.)
Merging pci/next (4cd74d833a4d Merge branch 'pci/misc')
Merging pstore/for-next/pstore (8665569e97dd pstore/ram: Avoid NULL deref i=
n ftrace merging failure path)
Merging hid/for-next (0a84e89382d6 Merge branch 'for-5.0/upstream-fixes' in=
to for-next)
Merging i2c/i2c/for-next (b33a02aadcc6 i2c: acpi: Move I2C bits from acpi.h=
 to i2c.h)
Merging i3c/i3c/next (25ac3da61ba1 i3c: master: cdns: fix I2C transfers in =
Cadence I3C master driver)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (01a6206125e6 hwmon: (via-cputemp) Use per=
mission specific SENSOR[_DEVICE]_ATTR variants)
Merging jc_docs/docs-next (31f433307043 Documentation: DMA-API: fix two typ=
os)
Merging v4l-dvb/master (337e90ed0286 media: imx-csi: Input connections to C=
SI should be optional)
Merging v4l-dvb-next/master (76097fe1aee6 media: staging/ipu3-imgu: Add MAI=
NTAINERS entry)
CONFLICT (add/add): Merge conflict in Documentation/media/v4l-drivers/ipu3.=
rst
CONFLICT (add/add): Merge conflict in Documentation/media/uapi/v4l/pixfmt-m=
eta-intel-ipu3.rst
Merging fbdev/fbdev-for-next (890d14d2d4b5 fbdev: fbmem: convert CONFIG_FB_=
LOGO_CENTER into a cmd line option)
Merging pm/linux-next (5fe38f46ad84 Merge branches 'pm-core', 'pm-cpuidle' =
and 'pm-cpufreq' into linux-next)
Merging cpufreq-arm/cpufreq/arm/linux-next (0c192d7c7dc8 cpufreq: s5pv210: =
Defer probe if getting regulators fail)
Merging cpupower/cpupower (bfeffd155283 Linux 5.0-rc1)
Merging opp/opp/linux-next (ade0c9493e97 Merge branch 'opp/genpd/propagatio=
n' into opp/linux-next)
Merging thermal/next (301c9a43e158 Merge branches 'for-rc' and 'thermal-int=
el' into next)
Merging thermal-soc/next (9d216211fded thermal: generic-adc: Fix adc to tem=
p interpolation)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (3595c559326d dlm: fix invalid cluster name warning)
Merging swiotlb/linux-next (227a76b64718 swiotlb: clear io_tlb_start and io=
_tlb_end in swiotlb_exit)
Merging rdma/for-next (57b26497fabe IB/iser: Pass the correct number of ent=
ries for dma mapped SGL)
Merging net-next/master (28f9d1a3d4fe Merge branch 'mlxsw-spectrum_router-A=
dd-GRE-tunnel-support-for-Spectrum-2')
CONFLICT (content): Merge conflict in Documentation/networking/snmp_counter=
.rst
Merging bpf-next/master (d0b2818efbe2 bpf: fix a (false) compiler warning)
Merging ipsec-next/master (590ce401c207 dt-bindings: net: dsa: ksz9477: fix=
 indentation for switch spi bindings)
Merging mlx5-next/mlx5-next (73f5a82bb3c9 RDMA/mad: Reduce MAD scope to mlx=
5_ib only)
Merging netfilter-next/master (0123a75e1d57 Revert "netfilter: nft_hash: ad=
d map lookups for hashing operations")
Applying: netfilter: conntrack: fix IPV6=3Dn builds
Applying: netfilter: conntrack: fix bogus port values for other l4 protocols
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (26a1ccc6c117 bpf: test: fix spelling mistake "REU=
SEEPORT" -> "REUSEPORT")
Merging wireless-drivers-next/master (4ad0be160544 brcmfmac: Use firmware_r=
equest_nowarn for the clm_blob)
Merging bluetooth/master (be042bd216ea Bluetooth: btmrvl: Drop unused GPIO =
includes)
Merging mac80211-next/master (e073f7caa26c virt_wifi: remove set but not us=
ed variable 'w_priv')
Merging gfs2/for-next (8e143b90e4d4 Merge tag 'iommu-updates-v4.21' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/joro/iommu)
Merging mtd/mtd/next (2431c4f5b46c mtd: Implement mtd_{read,write}() as wra=
ppers around mtd_{read,write}_oob())
Merging nand/nand/next (9f952302802f mtd: rawnand: Simplify the locking)
Merging spi-nor/spi-nor/next (0837ae46ff00 mtd: m25p80: add support of octa=
l mode I/O transfer)
Merging crypto/master (a0d608ee5ebf crypto: testmgr - unify the AEAD encryp=
tion and decryption test vectors)
Merging drm/drm-next (f164a94c2c87 Merge tag 'drm-misc-next-2019-01-16' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-intel/for-linux-next (24bf86ccf9f5 drm/i915/dsi: Enable ditheri=
ng for 6 bpc panels)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_drv.h
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_dp.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_gem.c
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/i915_debugfs.c
Merging drm-tegra/drm/tegra/for-next (db5adf4d6dce drm/tegra: hdmi: Fix aud=
io to work with any pixel clock rate)
Merging drm-misc/for-linux-next (47ef63e0cac8 drm: fix drm_can_sleep() comm=
ent)
Merging drm-msm/msm-next (b7f0be8ef36a dt-bindings: drm/msm/a6xx: Document =
GMU bindings)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (874cf192964e drm: arm/komeda: Remove =
IRQ parsing from initial series)
Applying: drm/komeda: merge fix for drm_atomic_private_obj_init() API change
Merging imx-drm/imx-drm/next (69ce8e6230a9 drm/imx: ipuv3-plane: add zpos p=
roperty)
Merging etnaviv/etnaviv/next (fd4b77e8deea drm/etnaviv: don't restrict to c=
ertain architectures)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (b3ffce399349 Merge branch 'regmap-5.0' into regmap=
-linus)
Merging sound/for-next (fd1cc9de64c2 ALSA: fireface: add support for Firefa=
ce UCX)
Merging sound-asoc/for-next (a9e2657a4d8a Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (b6eba86030bf Input: edt-ft5x06 - add offset support for=
 ev-ft5726)
Merging block/for-next (fae5efba43c2 mtip32xx: =D1=95top abusing the manage=
d resource APIs)
Merging device-mapper/for-next (3d0eccbfad5b dm: fix dm_wq_work() to only u=
se __split_and_process_bio() if appropriate)
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (e0fc4f56e724 mmc: sdhci-esdhc-imx: add DCMD support for C=
MDQ)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (c52b8fd546d8 mfd: wm8400-core: Make it explicitly=
 non-modular)
Merging backlight/for-backlight-next (3cee7a7d05b1 backlight: 88pm860x_bl: =
Use of_node_name_eq for node name comparisons)
Merging battery/for-next (2a7b0a29b375 drivers: power: supply: goldfish_bat=
tery: Add support for reading more properties)
Merging regulator/for-next (10ec2329c732 Merge branch 'regulator-5.1' into =
regulator-next)
Merging security/next-testing (91421ab037e0 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (43aa09fee2f0 apparmor: Fix warning about un=
used function apparmor_ipv6_postroute)
Merging integrity/next-integrity (eed9de3b4f47 ima: Use inode_is_open_for_w=
rite)
Merging selinux/next (53e0c2aa9a59 selinux: do not override context on cont=
ext mounts)
Merging tpmdd/next (c1a85a00ea66 LSM: generalize flag passing to security_c=
apable)
Merging watchdog/master (4a22fc534f2f watchdog: tqmx86: Fix a couple IS_ERR=
() vs NULL bugs)
Merging iommu/next (da1b3b7fb56d Merge branches 'iommu/fixes', 'arm/msm', '=
arm/tegra', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (8ba35b3a0046 vfio-mdev/samples: Use u8 instead of char f=
or handle functions)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (98bfd51dceeb audit: add syscall information to CONFIG_C=
HANGE records)
Merging devicetree/for-next (5801169a2ed2 of: __of_detach_node() - remove n=
ode from phandle cache)
Merging mailbox/mailbox-for-next (d69e11648e48 mailbox: tegra-hsp: Use devi=
ce-managed registration API)
Merging spi/for-next (c72ffa59b986 Merge branch 'spi-5.1' into spi-next)
Merging tip/auto-latest (e8e9921f8133 Merge branch 'sched/core')
Merging clockevents/clockevents/next (bd2bcaa565a2 Merge branch 'clockevent=
s/4.21' of http://git.linaro.org/people/daniel.lezcano/linux into timers/co=
re)
Merging edac-amd/for-next (5296bab33b60 dt-bindings, EDAC: Add Aspeed AST25=
00)
Merging irqchip/irq/irqchip-next (8208d1708b88 irqchip/gic-v3-its: Align PC=
I Multi-MSI allocation on their size)
Merging ftrace/for-next (3d739c1f6156 tracing: Use the return of str_has_pr=
efix() to remove open coded numbers)
Merging rcu/rcu/next (f25bcbbbf561 Merge LKMM and RCU commits)
Merging kvm/linux-next (bfeffd155283 Linux 5.0-rc1)
Merging kvm-arm/next (8c33df1afd86 arm: KVM: Add S2_PMD_{MASK,SIZE} constan=
ts)
Merging kvm-ppc/kvm-ppc-next (ae59a7e1945b KVM: PPC: Book3S HV: Keep rc bit=
s in shadow pgtable in sync with host)
Merging kvms390/next (7aedd9d48f2a KVM: s390: fix kmsg component kvm-s390)
Merging xen-tip/linux-next (867cefb4cb10 xen: Fix x86 sched_clock() interfa=
ce for xen)
Merging percpu/for-next (718f6757a29b Merge branch 'for-4.21' into for-next)
Merging workqueues/for-next (87915adc3f0a workqueue: re-add lockdep depende=
ncies for flushing)
Merging drivers-x86/for-next (bfeffd155283 Linux 5.0-rc1)
Merging chrome-platform/for-next (bfeffd155283 Linux 5.0-rc1)
Merging hsi/for-next (3a658e09a215 HSI: omap_ssi: Change to use DEFINE_SHOW=
_ATTRIBUTE macro)
Merging leds/for-next (0f85e8498a48 leds: trigger: timer: Add initializatio=
n from Device Tree)
Merging ipmi/for-next (29e6d1e0c042 ipmi: Prevent use-after-free in deliver=
_response)
Merging driver-core/driver-core-next (570d0200123f driver core: move device=
->knode_class to device_private)
Merging usb/usb-next (d7a6c0ce8d26 USB: Consolidate LPM checks to avoid ena=
bling LPM twice)
Merging usb-gadget/next (1c7fc5cbc339 Linux 5.0-rc2)
Merging usb-serial/usb-next (bfeffd155283 Linux 5.0-rc1)
Merging usb-chipidea-next/ci-for-usb-next (9049fce897ed usb: chipidea: imx:=
 allow to configure oc polarity on i.MX25)
Merging phy-next/next (49ee1406355e phy: qcom-qusb2: Add QUSB2 PHY support =
for msm8998)
Merging tty/tty-next (04afcd3aaf33 vt: ignore sequences that contain ':' in=
 parameters.)
Merging char-misc/char-misc-next (e3575c1201f0 misc: enclosure: Use struct_=
size() in kzalloc())
Merging extcon/extcon-next (bfeffd155283 Linux 5.0-rc1)
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (49a57857aeea Linux 5.0-rc3)
Merging staging/staging-next (9a413526140b staging: Mediatek: Use individua=
l config flags in Makefile)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (e01e08d2f261 drm/msm/a6xx: Add support for an interco=
nnect path)
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
Merging vhost/linux-next (b03f1d919455 virtio_balloon: remove the unnecessa=
ry 0-initialization)
CONFLICT (content): Merge conflict in include/linux/compiler.h
CONFLICT (content): Merge conflict in drivers/net/virtio_net.c
Merging rpmsg/for-next (e9856d7eb6e4 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (99784a0da951 Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (0bfb75115506 Documentation: gpio: driver: =
fix wire name for I2C)
Merging pinctrl/for-next (59e9b2badb05 Merge branch 'devel' into for-next)
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
Merging y2038/y2038 (0bd4bb9c5612 y2038: add 64-bit time_t syscalls to all =
32-bit architectures)
Merging livepatching/for-next (e1fd0398d1e7 Merge branch 'for-5.1/fake-sign=
al' into for-next)
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
Merging slimbus/for-next (81648d8bc222 slimbus: core: add missing spin_lock=
_init on txn_lock)
Merging nvmem/for-next (ff3b9b5c6b1b nvmem: core: Avoid useless iterations =
in nvmem_cell_get_from_lookup())
Merging xarray/xarray (edcddd4c879a XArray: Fix an arithmetic error in xa_i=
s_err)
Merging hyperv/hyperv-next (651022382c7f Linux 4.20-rc1)
Merging auxdisplay/auxdisplay (bfeffd155283 Linux 5.0-rc1)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (4607de57fff5 selftests: add tests for pidfd_send_si=
gnal())
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Merging akpm-current/current (fc4d4bfc99da ipc: conserve sequence numbers i=
n extended IPCMNI mode)
CONFLICT (content): Merge conflict in security/selinux/ss/services.c
CONFLICT (content): Merge conflict in mm/rmap.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: scripts/atomic/check-atomics.sh: don't assume that scripts are ex=
ecutable
Applying: include/linux/sched/signal.h: replace `tsk' with `task'
Applying: locking/atomics: build atomic headers as required
CONFLICT (content): Merge conflict in Makefile
Applying: kernel/fork.c: remove duplicated include
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer ove=
rflow
Merging akpm/master (3841d08b3596 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/raH0W59RnBwsuyv+Py2Nz9Z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxGneEACgkQAVBC80lX
0GySawf/XHEDTQu82eGHW01WqyIRH4A5O/Rm5zwksBtTBSkuUINB7TTz5tbXzMKq
/Mgnzp59NXWD+uXp7sAExa1FuxM5IFoH2tK7ieJww3p1+FK9LQfUyQKnBMFr1Pn6
eVn3mR+WgMcCaXB5L6JlV7x1oFgn4rGeTA/IFyNK4ZvjLukLxObn4Mi1qf3G3W90
w4M/bmENZdooJH0VNAjK1XFc9yY1L+3BHCMXn3LyrggbTJyDpznhCOCUggWerzAl
Mi3OUGFap0gxTgXHM34P89ykAL65SbPLwmLHzFtyelYPOZl/3swWetPEPbR+1OMq
5igLnViUSwb3/FLbGiXbFlhX9G2oGA==
=SDES
-----END PGP SIGNATURE-----

--Sig_/raH0W59RnBwsuyv+Py2Nz9Z--
