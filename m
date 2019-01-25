Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOCALPART_IN_SUBJECT,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DE8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB716218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nSDg88xk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfAYEfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 23:35:38 -0500
Received: from ozlabs.org ([203.11.71.1]:40519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbfAYEfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 23:35:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 43m5mf4Nrcz9s4s;
        Fri, 25 Jan 2019 15:35:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1548390930;
        bh=9hD1V1kKfnaGj/VmI42BRq01wpRphnUDsPsMZiiNOG4=;
        h=Date:From:To:Cc:Subject:From;
        b=nSDg88xkcXaa1BiFCft0WHFh/w+X1Ifu9CSjKsosOJQcqH6u1dOLWn7iH4giTEjGn
         I1CexZkmmxkYGk5BnOhP5QBE/vnzv5aeWyZM8zIJB/MJIZeU5KZj1qdecqtmzGIWqg
         CKlu+moVGUrbg7YmamwjNd7aelQ1JhAAd/156sAe2adlGXTuVGrpjT1Bk9i/pcdjQJ
         F76sVFbGEXTssI1SFnf5E31jiGl9oE8eCxOSkLQqsiQerQO/Uua1MifB6LHcxTosej
         cKX1R7CP0jGxN0Ovaoe+YGfVMrmGGfe2QxJdPn46FEJ7f44NsAujwpoS1JY7c9pUW5
         Ry2gtV9OHWujg==
Date:   Fri, 25 Jan 2019 15:35:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Jan 25
Message-ID: <20190125153530.5a0d3d08@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/WmBHDqLfGA55lAdRWrc6ZnR"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WmBHDqLfGA55lAdRWrc6ZnR
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Changes since 20190124:

The vfs tree still had its build failure for which I applied a patch.

Non-merge commits (relative to Linus' tree): 3454
 3915 files changed, 114384 insertions(+), 72024 deletions(-)

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
Merging origin/master (cffd425b9014 Merge tag 'for-5.0/dm-fixes' of git://g=
it.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm)
Merging fixes/master (d8d0c3a7f601 x86/syscalls: Mark expected switch fall-=
throughs)
Merging kbuild-current/fixes (49a57857aeea Linux 5.0-rc3)
Merging arc-current/for-curr (c9573c7ff30e ARC: DTB: [scripted] fix node na=
me and address spelling)
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
Merging net/master (63530aba7826 ax25: fix possible use-after-free)
Merging bpf/master (c9e4576743ee bpf: sock recvbuff must be limited by rmem=
_max in bpf_setsockopt())
Merging ipsec/master (e2612cd496e7 xfrm: Make set-mark default behavior bac=
kward compatible)
Merging netfilter/master (53ab60baa1ac ipvs: Fix signed integer overflow wh=
en setsockopt timeout)
Merging ipvs/master (b2e3d68d1251 netfilter: nft_compat: destroy function m=
ust not have side effects)
Merging wireless-drivers/master (13e62626c578 wlcore: sdio: Fixup power on/=
off sequence)
Merging mac80211/master (f9d672f1c2ca virt_wifi: fix error return code in v=
irt_wifi_newlink())
Merging rdma-fixes/for-rc (951d01b96f17 IB/mlx5: Fix how advise_mr() launch=
es async work)
Merging sound-current/for-linus (699390381a7b ALSA: hda - Add mute LED supp=
ort for HP ProBook 470 G5)
Merging sound-asoc-fixes/for-linus (63a2031f84ca Merge branch 'asoc-5.0' in=
to asoc-linus)
Merging regmap-fixes/for-linus (49a57857aeea Linux 5.0-rc3)
Merging regulator-fixes/for-linus (11c104263531 Merge branch 'regulator-5.0=
' into regulator-linus)
Merging spi-fixes/for-linus (5b3965d0936f Merge branch 'spi-5.0' into spi-l=
inus)
Merging pci-current/for-linus (d2fd6e81912a PCI: Fix __initdata issue with =
"pci=3Ddisable_acs_redir" parameter)
Merging driver-core.current/driver-core-linus (3a34c986324c cacheinfo: Keep=
 the old value if of_property_read_u32 fails)
Merging tty.current/tty-linus (815d835b7ba4 serial: fsl_lpuart: fix maximum=
 acceptable baud rate with over-sampling)
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
Merging staging.current/staging-linus (31eb79db420a staging: android: ion: =
Support cpu access during dma_buf_detach)
Merging char-misc.current/char-misc-linus (52768f324241 i3c: master: Fix an=
 error checking typo in 'cdns_i3c_master_probe()')
Merging soundwire-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt-fixes/fixes (49a57857aeea Linux 5.0-rc3)
Merging input-current/for-linus (141e5dcaa735 Input: input_event - fix the =
CONFIG_SPARC64 mixup)
Merging crypto-current/master (d45a90cb5d06 crypto: sm3 - fix undefined shi=
ft by >=3D width of value)
Merging ide/master (adf040ddd001 ide: Use of_node_name_eq for node name com=
parisons)
Merging vfio-fixes/for-linus (9a71ac7e15a7 vfio-pci/nvlink2: Fix ancient gc=
c warnings)
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
Merging omap-fixes/fixes (063c20e12f8b ARM: dts: am335x-shc.dts: fix wrong =
cd pin level)
Merging kvm-fixes/master (826c1362e79a x86/kvm/nVMX: don't skip emulated in=
struction twice when vmptr address is not backed)
Merging kvms390-fixes/master (40ebdb8e59df KVM: s390: Make huge pages unava=
ilable in ucontrol VMs)
Merging hwmon-fixes/hwmon (49a57857aeea Linux 5.0-rc3)
Merging nvdimm-fixes/libnvdimm-fixes (11189c1089da acpi/nfit: Fix command-s=
upported detection)
Merging btrfs-fixes/next-fixes (8358baa85b6a Merge branch 'misc-4.21' into =
next-fixes)
Merging vfs-fixes/fixes (61aa329d0762 cgroup: saner refcounting for cgroup_=
root)
Merging dma-mapping-fixes/for-linus (60d8cd572f65 arm64/xen: fix xen-swiotl=
b cache flushing)
Merging i3c-fixes/master (f29fd331aa05 i3c: master: dw-i3c-master: fix i3c_=
attach/reattach)
Merging drivers-x86-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging samsung-krzk-fixes/fixes (bfeffd155283 Linux 5.0-rc1)
Merging pinctrl-samsung-fixes/pinctrl-fixes (651022382c7f Linux 4.20-rc1)
Merging devicetree-fixes/dt/linus (5fa98c2eda35 dt-bindings: Fix dt_binding=
_check target for in tree builds)
Merging scsi-fixes/fixes (d67247566450 scsi: ufs: Use explicit access size =
in ufshcd_dump_regs)
Merging drm-fixes/drm-fixes (edaf690170c8 Merge branch 'drm-fixes-5.0' of g=
it://people.freedesktop.org/~agd5f/linux into drm-fixes)
Merging drm-intel-fixes/for-linux-next-fixes (b42606b0397d Merge tag 'gvt-f=
ixes-2019-01-24' of https://github.com/intel/gvt-linux into drm-intel-fixes)
Merging mmc-fixes/fixes (f3716b8ae934 mmc: dw_mmc-bluefield: : Fix the lice=
nse information)
Merging rtc-fixes/rtc-fixes (bfeffd155283 Linux 5.0-rc1)
Merging gnss-fixes/gnss-linus (bfeffd155283 Linux 5.0-rc1)
Merging hyperv-fixes/hyperv-fixes (52d3b4949192 hv_netvsc: fix typos in cod=
e comments)
Merging drm-misc-fixes/for-linux-next-fixes (a2fcd5c84f7a drm/modes: Preven=
t division by zero htotal)
Merging kbuild/for-next (35a09846f9d7 kbuild: descend to scripts/kconfig/ d=
irectly when syncconfig is needed)
Merging compiler-attributes/compiler-attributes (06615fb9ce9e lib/crc32.c: =
mark crc32_le_base/__crc32c_le_base aliases as __pure)
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
Merging amlogic/for-next (59f249fca4f0 Merge branch 'v5.1/dt64' into tmp/am=
l-rebuild)
Merging aspeed/for-next (d5e12a2c968d Merge branch 'aspeed-5.1-devicetree' =
into for-next)
Merging at91/at91-next (3850dd7a32a0 Merge branch 'at91-dt' into at91-next)
Merging bcm2835/for-next (1ee128f4fff2 Merge branch 'bcm2835-drivers-next' =
into for-next)
Merging imx-mxs/for-next (acb061708204 Merge branch 'imx/maintainers' into =
for-next)
Merging keystone/next (a74cab3c7dcb Merge branch 'for_4.20/drivers-soc' int=
o next)
Merging mediatek/for-next (ecee13a082e0 Merge branch 'v5.0-next/dts64' into=
 for-next)
Merging mvebu/for-next (b5f034845e70 ARM: dts: kirkwood: Fix polarity of GP=
IO fan lines)
Merging omap/for-next (e58fca2baa78 Merge branch 'omap-for-v5.1/dt-ti81xx' =
into for-next)
Merging reset/reset/next (057c784597d0 reset: imx7: Add support for i.MX8MQ=
 IP block variant)
Merging qcom/for-next (cd7e9fbf79c4 Merge branch 'arm64-for-5.1' into all-f=
or-5.1)
Merging renesas/next (58b152dbe6e4 Merge branches 'fixes-for-v5.0', 'arm-de=
fconfig-for-v5.1', 'arm-dt-for-v5.1', 'arm-soc-for-v5.1', 'arm64-dt-for-v5.=
1', 'arm64-defconfig-for-v5.1' and 'dt-bindings-for-v5.1' into next)
Merging rockchip/for-next (0355b8299d0a Merge branch 'v5.1-armsoc/dts64' in=
to for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (2e625e23d6bf Merge branch 'next/defconfig' i=
nto for-next)
Merging sunxi/sunxi/for-next (1e0dfc8d5e9d Merge branches 'sunxi/dt64-for-5=
.1' and 'sunxi/h3-h5-for-5.1' into sunxi/for-next)
Merging tegra/for-next (2731820ce27b Merge branch for-4.21/clk into for-nex=
t)
Merging clk/clk-next (35d571ec34fb Merge branch 'clk-renesas' into clk-next)
Merging clk-samsung/for-next (bfeffd155283 Linux 5.0-rc1)
Merging c6x/for-linux-next (8adcc59974b8 Merge branch 'work.misc' of git://=
git.kernel.org/pub/scm/linux/kernel/git/viro/vfs)
Merging csky/linux-next (52f8451955dd csky: coding convention: use task_sta=
ck_page)
Merging h8300/h8300-next (21c7acc439b5 h8300: pci: Remove local declaration=
 of pcibios_penalize_isa_irq)
Merging ia64/next (c51836246f97 ia64: generate uapi header and system call =
table files)
Merging m68k/for-next (28713169d879 m68k: Add -ffreestanding to CFLAGS)
Merging m68knommu/for-next (49a57857aeea Linux 5.0-rc3)
Merging microblaze/next (226a893bbb1f microblaze: no need to check return v=
alue of debugfs_create functions)
Merging mips/mips-next (a0f0b69f2c15 MIPS: remove meaningless generic-(CONF=
IG_GENERIC_CSUM) +=3D checksum.h)
Merging nds32/next (bfeffd155283 Linux 5.0-rc1)
Merging nios2/for-next (1c286267aedf nios2: update_mmu_cache preload the TL=
B with the new PTE)
Merging openrisc/for-next (57ce8ba0fd3a openrisc: Fix broken paths to arch/=
or32)
Merging parisc-hd/for-next (0293c953c7a4 CREDITS/MAINTAINERS: Adjust parisc=
-linux.org email addresses)
Merging powerpc/next (63da6caeb84c powerpc: remove unnecessary unlikely())
Merging fsl/next (63d86876f324 Revert "powerpc/fsl_pci: simplify fsl_pci_dm=
a_set_mask")
Merging risc-v-pjw/for-next (467e050e9760 Merge branch 'i2c/for-current' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging risc-v/for-next (801009424e05 Fix a handful of audit-related issue)
Merging sifive/for-next (467e050e9760 Merge branch 'i2c/for-current' of git=
://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux)
Merging s390/features (58661489a84c Merge branch 'compat' of git://git.kern=
el.org/pub/scm/linux/kernel/git/s390/linux into features)
Merging sparc-next/master (b71acb0e3721 Merge branch 'linus' of git://git.k=
ernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging sh/for-next (ac21fc2dcb40 sh: switch to NO_BOOTMEM)
Merging uml/linux-next (940b241d9050 um: Remove obsolete reenable_XX calls)
Merging xtensa/xtensa-for-next (f1589f675d65 Merge branch 'xtensa-jumplabel=
' into xtensa-for-next)
Merging fscrypt/master (f5e55e777cc9 fscrypt: return -EXDEV for incompatibl=
e rename or link into encrypted dir)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding stan=
dard issues)
Merging btrfs/next (29dcea88779c Linux 4.17)
Merging btrfs-kdave/for-next (35dccd9c1e97 Merge branch 'for-next-next-v5.0=
-20190123' into for-next-20190123)
Merging ceph/master (74827ee29565 ceph: quota: cleanup license mess)
Merging cifs/for-next (a5f1a81f701c cifs: print CIFSMaxBufSize as part of /=
proc/fs/cifs/DebugData)
Merging configfs/for-next (cc57c07343bd configfs: fix registered group remo=
val)
Merging ecryptfs/next (5dcea554d5ce eCryptfs: fix a couple type promotion b=
ugs)
Merging ext3/for_next (e92dfb845b33 Pull ext2 fixes.)
Merging ext4/dev (191ce17876c9 ext4: fix special inode number checks in __e=
xt4_iget())
Merging f2fs/dev (cd2dcebde8b8 f2fs: sync filesystem after roll-forward rec=
overy)
Merging fuse/for-next (cc4249fdc6c9 fuse: use atomic64_t for khctr)
Merging jfs/jfs-next (2e3bc6125154 fs/jfs: Switch to use new generic UUID A=
PI)
Merging nfs/linux-next (30bac164aca7 Revert "Change mincore() to count "map=
ped" pages rather than "cached" pages")
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
Merging v9fs/9p-next (3bbe8b1a4ae9 9p: mark expected switch fall-through)
Merging xfs/for-next (90be9b86da90 xfs: xfs_fsops: drop useless LIST_HEAD)
Merging file-locks/locks-next (bf77ae4c98d7 locks: fix error in locks_move_=
blocks())
Merging vfs/for-next (1fab5fff0a7a Merge branches 'work.mount', 'work.misc'=
, 'misc.misc' and 'work.iov_iter' into for-next)
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup.c
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup-v1.c
CONFLICT (content): Merge conflict in kernel/cgroup/cgroup-internal.h
CONFLICT (content): Merge conflict in arch/x86/kernel/cpu/resctrl/rdtgroup.c
Applying: vfs: work around CONFIG_PRINTK=3Dn in fs_context logging code
Merging printk/for-next (15ff2069cb7f printk: Add caller information to pri=
ntk() output.)
Merging pci/next (4cd74d833a4d Merge branch 'pci/misc')
Merging pstore/for-next/pstore (182ca6e0ae23 pstore/ram: Replace dummy_data=
 heap memory with stack memory)
Merging hid/for-next (fcee620b2daf Merge branch 'for-5.1/ish' into for-next)
Merging i2c/i2c/for-next (44783efdfed1 i2c: aspeed: Remove hard-coded bus t=
imeout value setting)
Merging i3c/i3c/next (25ac3da61ba1 i3c: master: cdns: fix I2C transfers in =
Cadence I3C master driver)
Merging dmi/master (57361846b52b Linux 4.19-rc2)
Merging hwmon-staging/hwmon-next (b11316dff5cf hwmon: (via-cputemp) Use per=
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
Merging pm/linux-next (76200a38f2c5 Merge branch 'acpi-debug' into linux-ne=
xt)
Merging cpufreq-arm/cpufreq/arm/linux-next (5887f50a1a61 MAINTAINERS: Updat=
e the active pm tree for ARM)
Merging cpupower/cpupower (bfeffd155283 Linux 5.0-rc1)
Merging opp/opp/linux-next (dd7ac2422a9b opp: no need to check return value=
 of debugfs_create functions)
Merging thermal/next (301c9a43e158 Merge branches 'for-rc' and 'thermal-int=
el' into next)
Merging thermal-soc/next (9d216211fded thermal: generic-adc: Fix adc to tem=
p interpolation)
Merging ieee1394/for-next (c820518f6ca1 firewire: Remove depends on HAS_DMA=
 in case of platform dependency)
Merging dlm/next (49a57857aeea Linux 5.0-rc3)
Merging swiotlb/linux-next (227a76b64718 swiotlb: clear io_tlb_start and io=
_tlb_end in swiotlb_exit)
Merging rdma/for-next (6113cc44015b IB/mlx5: Don't override existing ip_pro=
tocol)
Merging net-next/master (254764e55652 r8169: improve firmware handling)
Merging bpf-next/master (d9ff286a0f59 bpf: allow BPF programs access skb_sh=
ared_info->gso_segs field)
Merging ipsec-next/master (590ce401c207 dt-bindings: net: dsa: ksz9477: fix=
 indentation for switch spi bindings)
Merging mlx5-next/mlx5-next (73f5a82bb3c9 RDMA/mad: Reduce MAD scope to mlx=
5_ib only)
Merging netfilter-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus=
 port values for other l4 protocols)
Merging nfc-next/master (1f008cfec5d5 NFC: fdp: Fix unused variable warning=
s)
Merging ipvs-next/master (e2f7cc72cbf4 netfilter: conntrack: fix bogus port=
 values for other l4 protocols)
Merging wireless-drivers-next/master (4ad0be160544 brcmfmac: Use firmware_r=
equest_nowarn for the clm_blob)
Merging bluetooth/master (6317950c1b9c Bluetooth: Mark expected switch fall=
-throughs)
Merging mac80211-next/master (e073f7caa26c virt_wifi: remove set but not us=
ed variable 'w_priv')
Merging gfs2/for-next (2abbf9a4d262 gfs: no need to check return value of d=
ebugfs_create functions)
Merging mtd/mtd/next (2431c4f5b46c mtd: Implement mtd_{read,write}() as wra=
ppers around mtd_{read,write}_oob())
Merging nand/nand/next (9f952302802f mtd: rawnand: Simplify the locking)
Merging spi-nor/spi-nor/next (a2126b0a0109 mtd: spi-nor: refine Spansion S2=
5FL512S ID)
Merging crypto/master (a0d608ee5ebf crypto: testmgr - unify the AEAD encryp=
tion and decryption test vectors)
Merging drm/drm-next (f91168f48556 Merge tag 'drm-misc-next-2019-01-23' of =
git://anongit.freedesktop.org/drm/drm-misc into drm-next)
Merging drm-intel/for-linux-next (85baa5dbf791 drm/i915: Update DRIVER_DATE=
 to 20190124)
Merging drm-tegra/drm/tegra/for-next (1f0df2a88028 gpu: host1x: Support 40-=
bit addressing on Tegra186)
Merging drm-misc/for-linux-next (fcd70cd36b9b drm: Split out drm_probe_help=
er.h)
Merging drm-msm/msm-next (b62414c85767 dt-bindings: drm/msm/a6xx: Document =
GMU bindings)
Merging hdlcd/for-upstream/hdlcd (d664b851eb2b drm/arm/hdlcd: Reject atomic=
 commits that disable only the plane)
Merging mali-dp/for-upstream/mali-dp (874cf192964e drm: arm/komeda: Remove =
IRQ parsing from initial series)
Applying: drm/komeda: merge fix for drm_atomic_private_obj_init() API change
Merging imx-drm/imx-drm/next (257ff80474ab drm/imx: allow building under CO=
MPILE_TEST)
Merging etnaviv/etnaviv/next (fd4b77e8deea drm/etnaviv: don't restrict to c=
ertain architectures)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (478a2aa27919 Merge remote-tracking branch 'regmap/=
topic/irq' into regmap-next)
Merging sound/for-next (205d6bcf9bb8 Merge branch 'topic/pcm-lock-refactor'=
 into for-next)
Merging sound-asoc/for-next (9aabf74b02fb Merge branch 'asoc-5.1' into asoc=
-next)
Merging modules/modules-next (93d77e7f1410 ARM: module: Fix function kallsy=
ms on Thumb-2)
Merging input/next (b6eba86030bf Input: edt-ft5x06 - add offset support for=
 ev-ft5726)
Merging block/for-next (fae5efba43c2 mtip32xx: =D1=95top abusing the manage=
d resource APIs)
Merging device-mapper/for-next (075c18c3e124 dm: add missing trace_block_sp=
lit() to __split_and_process_bio())
Merging pcmcia/pcmcia-next (95691e3eddc4 pcmcia: Implement CLKRUN protocol =
disabling for Ricoh bridges)
Merging mmc/next (0cd89886d03b Merge branch 'fixes' into next)
Merging kgdb/kgdb-next (3bd67b37e350 kdb: print real address of pointers in=
stead of hashed addresses)
CONFLICT (content): Merge conflict in kernel/debug/kdb/kdb_bt.c
Merging md/for-next (e820d55cb99d md: fix raid10 hang issue caused by barri=
er)
Merging mfd/for-mfd-next (c52b8fd546d8 mfd: wm8400-core: Make it explicitly=
 non-modular)
Merging backlight/for-backlight-next (3cee7a7d05b1 backlight: 88pm860x_bl: =
Use of_node_name_eq for node name comparisons)
Merging battery/for-next (f83a6ece6997 power: supply: bq25890: show max cha=
rge current/voltage as configured)
Merging regulator/for-next (dae7d0d33e81 Merge branch 'regulator-5.1' into =
regulator-next)
Merging security/next-testing (820cf8c12d89 Merge branch 'next-general' int=
o next-testing)
Merging apparmor/apparmor-next (43aa09fee2f0 apparmor: Fix warning about un=
used function apparmor_ipv6_postroute)
Merging integrity/next-integrity (cd0b86fe9529 ima: define ima_post_create_=
tmpfile() hook and add missing call)
Merging selinux/next (53e0c2aa9a59 selinux: do not override context on cont=
ext mounts)
Merging tpmdd/next (c1a85a00ea66 LSM: generalize flag passing to security_c=
apable)
Merging watchdog/master (4a22fc534f2f watchdog: tqmx86: Fix a couple IS_ERR=
() vs NULL bugs)
Merging iommu/next (796c6a901d01 Merge branches 'iommu/fixes', 'arm/msm', '=
arm/tegra', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (d8a5b80568a9 Linux 4.15)
Merging vfio/next (8ba35b3a0046 vfio-mdev/samples: Use u8 instead of char f=
or handle functions)
Merging trivial/for-next (75a24b822d38 kfifo: fix inaccurate comment)
Merging audit/next (98bfd51dceeb audit: add syscall information to CONFIG_C=
HANGE records)
Merging devicetree/for-next (42e45a9449f1 media: s5p-mfc: Fix memdev DMA co=
nfiguration)
Merging mailbox/mailbox-for-next (d69e11648e48 mailbox: tegra-hsp: Use devi=
ce-managed registration API)
Merging spi/for-next (1816b4572c38 Merge branch 'spi-5.1' into spi-next)
CONFLICT (modify/delete): arch/mips/ath79/dev-spi.h deleted in HEAD and mod=
ified in spi/for-next. Version spi/for-next of arch/mips/ath79/dev-spi.h le=
ft in tree.
$ git rm -f arch/mips/ath79/dev-spi.h
Merging tip/auto-latest (e8e9921f8133 Merge branch 'sched/core')
Merging clockevents/clockevents/next (7cd6dca3600d clocksource/drivers/arch=
_timer: Workaround for Allwinner A64 timer instability)
Merging edac-amd/for-next (912ebd99edfa EDAC: Do not check return value of =
debugfs_create() functions)
Merging irqchip/irq/irqchip-next (8208d1708b88 irqchip/gic-v3-its: Align PC=
I Multi-MSI allocation on their size)
Merging ftrace/for-next (3d739c1f6156 tracing: Use the return of str_has_pr=
efix() to remove open coded numbers)
Merging rcu/rcu/next (f25bcbbbf561 Merge LKMM and RCU commits)
Merging kvm/linux-next (bfeffd155283 Linux 5.0-rc1)
Merging kvm-arm/next (790c3a04f2af KVM: arm/arm64: Move kvm_is_write_fault =
to header file)
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
CONFLICT (content): Merge conflict in drivers/char/ipmi/ipmi_ssif.c
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
Merging extcon/extcon-next (6a8e7f788e80 extcon: Add support for ptn5150 ex=
tcon driver)
Merging soundwire/next (bfeffd155283 Linux 5.0-rc1)
Merging thunderbolt/next (49a57857aeea Linux 5.0-rc3)
Merging staging/staging-next (9a413526140b staging: Mediatek: Use individua=
l config flags in Makefile)
Merging mux/for-next (a1ad5ff63944 Merge branch 'i2c-mux/for-next' into for=
-next)
Merging icc/icc-next (1c7fc5cbc339 Linux 5.0-rc2)
Merging slave-dma/next (84aca9e007d2 Merge branch 'topic/xilinx' into next)
CONFLICT (content): Merge conflict in drivers/dma/imx-sdma.c
Merging cgroup/for-next (0623413ee0ba Merge branch 'for-4.21' into for-next)
Merging scsi/for-next (75aee64ff6db Merge branch 'fixes' into for-next)
CONFLICT (content): Merge conflict in drivers/scsi/arcmsr/arcmsr_hba.c
Merging scsi-mkp/for-next (dfeba64dd66b scsi: arcmsr: Update driver version=
 to v1.40.00.10-20190116)
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wa=
ke up sleeping login worker)
Merging target-bva/for-next (60cc43fc8884 Linux 4.17-rc1)
Merging vhost/linux-next (ae5d11d206fc arch: move common mmap flags to linu=
x/mman.h)
Merging rpmsg/for-next (ac1b79e48631 Merge branches 'hwspinlock-next', 'rpm=
sg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (5c08179cd15f Merge branch 'devel' into for-next)
Merging gpio-brgl/gpio/for-next (c243d54fb339 gpio: altera-a10sr: Trivial c=
oding style fix)
CONFLICT (content): Merge conflict in drivers/gpio/gpio-altera-a10sr.c
Merging pinctrl/for-next (5fe473106ea6 Merge branch 'devel' into for-next)
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
Merging livepatching/for-next (5b99cc230388 Merge branch 'for-5.0/upstream-=
fixes' into for-next)
Merging coresight/next (675e806209e0 coresight: Use of_node_name_eq for nod=
e name comparisons)
Merging rtc/rtc-next (42986fb81199 rtc: Add Cadence RTC driver)
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
Merging hyperv/hyperv-next (27207b76011f vmbus: Switch to use new generic U=
UID API)
Merging auxdisplay/auxdisplay (49a57857aeea Linux 5.0-rc3)
Merging kgdb-dt/kgdb/for-next (97498c96a186 kgdb/treewide: constify struct =
kgdb_arch arch_kgdb_ops)
Merging pidfd/for-next (5d4254ab421b selftests: add tests for pidfd_send_si=
gnal())
CONFLICT (content): Merge conflict in include/uapi/asm-generic/unistd.h
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_64.tbl
CONFLICT (content): Merge conflict in arch/x86/entry/syscalls/syscall_32.tbl
Merging kspp-gustavo/for-next/kspp (8390ee0131b2 scsi: sym53c8xx_2: sym_nvr=
am: Mark expected switch fall-through)
Merging akpm-current/current (fc4d4bfc99da ipc: conserve sequence numbers i=
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
Merging akpm/master (bedae28d6429 drivers/media/platform/sti/delta/delta-ip=
c.c: fix read buffer overflow)

--Sig_/WmBHDqLfGA55lAdRWrc6ZnR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxKkhIACgkQAVBC80lX
0GyI8gf/d+AU6vZtuqkTFc+kxIgJ5rQWxx0+qRsX0A2NQxBDN8od6irwqTdQ4Q9q
fjaMEVSoh6ng//R4v0u6J9jQiL0hpHyYCsUQRTQAC1v/EclSrdpzkXgy+WZzW1Qk
0KD6EfoX1NBwUQMZY9SQ6DzAobrivNoWpx7ou/XcZqtTCzcmCWJo7o3ApJXpDTT0
u3uJR35nqx5PkP/muTc1VQlxpL/4XS5Me9N6qSl6jhDbled8apt9wL/vm8QJpAYF
L8nhWuC4l4/EDxJ+MfL2WFrow/K1QXw05atGhkhobNmioROZl/7ap+HblBqbGtrC
QGJo+RHEHkVo1cvbNMJ1iMBt0w218w==
=e8dA
-----END PGP SIGNATURE-----

--Sig_/WmBHDqLfGA55lAdRWrc6ZnR--
