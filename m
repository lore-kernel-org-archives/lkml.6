Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeBAEr6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 23:47:58 -0500
Received: from ozlabs.org ([103.22.144.67]:45971 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbeBAEry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 23:47:54 -0500
Date: Thu, 1 Feb 2018 15:47:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 1
Message-ID: <20180201154751.6a3aceae@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Please do not add any v4.17 material to your linux-next included branches
until after v4.16-rc1 has been released.

News: I am now building everything with:
gcc (Custom f51944395b6aa154) 7.3.1 20180130
ld (Custom 1e4d2a179d04d08b) 2.28.2.20170706

Changes since 20180131:

The pci tree gained a build failure so I sued the version from
next-20180131.

The kvm tree gained a conflict against Linus' tree.

Non-merge commits (relative to Linus' tree): 8307
 8429 files changed, 364419 insertions(+), 243285 deletions(-)

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

I am currently merging 256 trees (counting Linus' and 44 trees of bug
fix patches pending for the current merge release).

Stats about the size of the tree over time can be seen at
http://neuling.org/linux-next-size.html .

Status of my local build tests will be at
http://kisskb.ellerman.id.au/linux-next .  If maintainers want to give
advice about cross compilers/configs that work, we are always open to add
more builds.

Thanks to Randy Dunlap for doing many randconfig builds.  And to Paul
Gortmaker for triage and bug fixes.

-- 
Cheers,
Stephen Rothwell

$ git checkout master
$ git reset --hard stable
Merging origin/master (7b1cd95d65eb Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma)
Merging fixes/master (820bf5c419e4 Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi)
Merging kbuild-current/fixes (36c1681678b5 genksyms: drop *.hash.c from .gitignore)
Merging arc-current/for-curr (a46f24acf8bc ARC: boot log: Fix trailing semicolon)
Merging arm-current/fixes (091f02483df7 ARM: net: bpf: clarify tail_call index)
Merging m68k-current/for-linus (2334b1ac1235 MAINTAINERS: Add NuBus subsystem entry)
Merging metag-fixes/fixes (b884a190afce metag/usercopy: Add missing fixups)
Merging powerpc-fixes/fixes (1b689a95ce74 powerpc/pseries: include linux/types.h in asm/hvcall.h)
Merging sparc/master (aebb48f5e465 sparc64: fix typo in CONFIG_CRYPTO_DES_SPARC64 => CONFIG_CRYPTO_CAMELLIA_SPARC64)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (ba804bb4b72e Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net)
Merging bpf/master (ba804bb4b72e Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net)
Merging ipsec/master (545d8ae7afff xfrm: fix boolean assignment in xfrm_get_type_offload)
Merging netfilter/master (da17c73b6eb7 netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{match|target})
Merging ipvs/master (f7fb77fc1235 netfilter: nft_compat: check extension hook mask only if set)
Merging wireless-drivers/master (a9e6d44ddecc ssb: Do not disable PCI host on non-Mips)
Merging mac80211/master (c4de37ee2b55 mac80211: mesh: fix wrong mesh TTL offset calculation)
Merging rdma-fixes/for-rc (ae59c3f0b6cf RDMA/mlx5: Fix out-of-bound access while querying AH)
Merging sound-current/for-linus (1c9609e3a8cf ALSA: hda - Reduce the suspend time consumption for ALC256)
Merging pci-current/for-linus (838cda369707 x86/PCI: Enable AMD 64-bit window on resume)
Merging driver-core.current/driver-core-linus (30a7acd57389 Linux 4.15-rc6)
Merging tty.current/tty-linus (30a7acd57389 Linux 4.15-rc6)
Merging usb.current/usb-linus (a8750ddca918 Linux 4.15-rc8)
Merging usb-gadget-fixes/fixes (b2cd1df66037 Linux 4.15-rc7)
Merging usb-serial-fixes/usb-linus (d14ac576d10f USB: serial: cp210x: add new device ID ELV ALC 8xxx)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: msm: fix ulpi-node lookup)
Merging phy/fixes (2b88212c4cc6 phy: rcar-gen3-usb2: select USB_COMMON)
Merging staging.current/staging-linus (a8750ddca918 Linux 4.15-rc8)
Merging char-misc.current/char-misc-linus (a8750ddca918 Linux 4.15-rc8)
Merging input-current/for-linus (060403f34008 Revert "Input: synaptics_rmi4 - use devm_device_add_group() for attributes in F01")
Merging crypto-current/master (2d55807b7f7b crypto: picoxcell - Fix error handling in spacc_probe())
Merging ide/master (8b76f5da49f0 ide: remove duplicated assignment to 'cursg')
Merging vfio-fixes/for-linus (563b5cbe334e iommu/arm-smmu-v3: Cope with duplicated Stream IDs)
Merging kselftest-fixes/fixes (ae64f9bd1d36 Linux 4.15-rc2)
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711_bl: fix device-tree node leaks)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode check)
Merging spi-nor-fixes/spi-nor/fixes (10a6a6975691 Revert "dt-bindings: mtd: add sst25wf040b and en25s64 to sip-nor list")
Merging mfd-fixes/for-mfd-fixes (107b7d9fa94c mfd: rtsx: Release IRQ during shutdown)
Merging v4l-dvb-fixes/fixes (781b045baefd media: imx274: Fix error handling, add MAINTAINERS entry)
Merging reset-fixes/reset/fixes (f450f28e70a2 reset: socfpga: fix for 64-bit compilation)
Merging mips-fixes/mips-fixes (f35764e74f0e MIPS: Fix undefined reference to physical_memsize)
Merging kvm-fixes/master (bda646dd182a Merge tag 'kvm-s390-master-4.15-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux)
Merging kvms390-fixes/master (1de1ea7efeb9 KVM: s390: add proper locking for CMMA migration bitmap)
Merging drm-intel-fixes/for-linux-next-fixes (d8a5b80568a9 Linux 4.15)
Merging drm-misc-fixes/for-linux-next-fixes (745fd50f3b04 drm/cirrus: Load lut in crtc_commit)
Merging kbuild/for-next (53a7bc8937df Merge branch 'kconfig' into for-next)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (04f56534786c MAINTAINERS: add the iommu list for swiotlb and xen-swiotlb)
Merging asm-generic/master (a351e9b9fc24 Linux 4.11)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (3d7352b79292 Merge branches 'fixes', 'misc', 'sa1111' and 'sa1100-for-next' into for-next)
Merging arm-perf/for-next/perf (7520fa99246d perf: ARM DynamIQ Shared Unit PMU support)
Merging arm-soc/for-next (2aa127e4d579 Merge branches 'next/dt' and 'next/drivers' into for-next)
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into next)
Merging alpine/alpine/for-next (a1144b2b1ec4 ARM: dts: alpine: add valid clock-frequency values)
Merging amlogic/for-next (33aa6dd12d40 Merge branch 'v4.16/dt64' into tmp/aml-rebuild)
Merging aspeed/for-next (8203ca9789bc Merge branch 'dt-for-v4.16' into for-next)
Merging at91/at91-next (fa4cf68ab4b1 Merge tag 'at91-ab-4.16-dt' into at91-next)
Merging bcm2835/for-next (a6189bcc0012 Merge branch anholt/bcm2835-drivers-next into for-next)
Merging imx-mxs/for-next (824162aa1454 Merge branch 'imx/defconfig' into for-next)
Merging keystone/next (a29b8b93e158 Merge branch 'for_4.16/keystone-config' into next)
Merging mvebu/for-next (91cbd0893d7d Merge branch 'mvebu/dt64' into mvebu/for-next)
Merging omap/for-next (e38c38728951 Merge branch 'omap-for-v4.16/ti-sysc' into for-next)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/dra7.dtsi
Merging reset/reset/next (70d2f16a6289 reset: meson: enable level reset support on Meson8b)
Merging qcom/for-next (f5788d2f2929 Merge tag 'qcom-arm64-defconfig-for-4.16' into tagged-for-4.16)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (b214f9f550fd Merge branches 'fixes-for-v4.15' and 'dt-for-v4.16' into next)
Merging rockchip/for-next (5432915256e7 Merge branch 'v4.16-armsoc/dts64fixes' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (3b6327365aba Merge branch 'next/dt' into for-next)
Merging sunxi/sunxi/for-next (d7ec2c507677 Merge branch 'sunxi/fixes-for-4.15' into sunxi/for-next)
Merging tegra/for-next (983371acdeda Merge branch for-4.16/arm64/dt into for-next)
Merging arm64/for-next/core (ec89ab50a03a arm64: Fix TTBR + PAN + 52-bit PA logic in cpu_do_switch_mm)
Merging clk/clk-next (c43a52cfd27b Merge branches 'clk-aspeed', 'clk-lock-UP', 'clk-mediatek' and 'clk-allwinner' into clk-next)
Merging clk-samsung/for-next (7685570f2ae2 clk: samsung: s3c: Remove unneeded enumeration)
Merging c6x/for-linux-next (9d440f7a2824 c6x: fix platforms/plldata.c get_coreid build error)
Merging cris/for-next (fd989db807a0 cris: Fix conflicting types for _etext, _edata, _end)
Merging m68k/for-next (2334b1ac1235 MAINTAINERS: Add NuBus subsystem entry)
Merging m68knommu/for-next (0d665e7b109d mm, page_vma_mapped: Drop faulty pointer arithmetics in check_pte())
Merging metag/for-next (e3cd7f013bac metag/mm: Drop pointless increment)
Merging microblaze/next (7b6ce52be3f8 microblaze: Setup proper dependency for optimized lib functions)
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-features' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (e0c5f36b2a63 MIPS: Add iomem resource for kernel bss section.)
Merging nios2/for-next (65d1e3ddeae1 nios2: time: Read timer in get_cycles only if initialized)
Merging openrisc/for-next (0fedb7653af7 openrisc: remove unused __ARCH_HAVE_MMU define)
Merging parisc-hd/for-next (bebc6082da0a Linux 4.14)
Merging powerpc/next (015eb1b89e95 powerpc/mm/radix: Fix build error when RADIX_MMU=n)
CONFLICT (content): Merge conflict in drivers/misc/Makefile
CONFLICT (content): Merge conflict in drivers/misc/Kconfig
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_device)
Merging risc-v/for-next (4889dec6c87d riscv: inline set_pgdir into its only caller)
Merging s390/features (47d67facb057 s390/decompressor: discard __ksymtab and .eh_frame sections)
Merging sparc-next/master (2d85ec8acb01 oradax: Fix return value check in dax_attach())
Merging sh/for-next (6e2fbfdd585f sh: fix futex FUTEX_OP_SET op on userspace addresses)
Merging uml/linux-next (02eb0b11eab5 um: Add missing EXPORT for free_irq_by_fd())
Merging xtensa/xtensa-for-next (73b37067623c xtensa: fix futex_atomic_cmpxchg_inatomic)
Merging fscrypt/master (3d204e24d452 fscrypt: remove 'ci' parameter from fscrypt_put_encryption_info())
CONFLICT (content): Merge conflict in fs/f2fs/namei.c
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding standard issues)
Merging btrfs/next (7c9a09f56a91 btrfs: don't use async helpers for crcs when under IO limits)
Applying: f2fs: fixup for cgroup/writeback change
Merging btrfs-kdave/for-next (d69a3372bba2 Merge branch 'for-next-next-v4.16-20180130' into for-next-20180130)
Merging ceph/master (16515a6d5418 ceph: improving efficiency of syncfs)
Merging cifs/for-next (f7b852fd27f7 [SMB3] Add some missing debug fields in server and tcon structs)
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type const)
Merging ecryptfs/next (4670269faba7 eCryptfs: constify attribute_group structures.)
Merging ext3/for_next (f463589a7cd2 ext2: drop unneeded newline)
Merging ext4/dev (a6c927bb894f ext4: create ext4_kset dynamically)
Merging f2fs/dev (1c1d35df7110 f2fs: support inode creation time)
Merging fuse/for-next (c6cdd51404b7 fuse: fix READDIRPLUS skipping an entry)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (e231c6879cfd NFS: Fix a race between mmap() and O_DIRECT)
Merging nfs-anna/linux-next (c54c14ba000d xprtrdma: Spread reply processing over more CPUs)
CONFLICT (content): Merge conflict in net/sunrpc/xprtrdma/transport.c
CONFLICT (content): Merge conflict in net/sunrpc/xprt.c
Merging nfsd/nfsd-next (3ac71a649c3d nfsd: store stat times in fill_pre_wcc() instead of inode times)
CONFLICT (content): Merge conflict in fs/nfsd/nfsfh.h
Merging orangefs/for-next (db0267e7afc7 orangefs: call op_release sooner when creating inodes)
Merging overlayfs/overlayfs-next (8383f1748829 ovl: wire up NFS export operations)
CONFLICT (content): Merge conflict in fs/dcache.c
Merging ubifs/linux-next (7f29ae9f977b ubi: block: Fix locking for idr_alloc/idr_remove)
Merging xfs/for-next (1e369b0e199b xfs: remove experimental tag for reflinks)
Merging file-locks/locks-next (1deab8ce2c91 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc)
Merging vfs/for-next (27f005e635c6 Merge branch 'misc.netdrv' into for-next)
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsync())
Merging iversion/iversion-next (cf72eadd5566 iversion: make inode_cmp_iversion{+raw} return bool instead of s64)
Merging printk/for-next (bb4f552a598d Merge branch 'for-4.16-console-waiter-logic' into for-4.16)
CONFLICT (content): Merge conflict in scripts/checkpatch.pl
CONFLICT (content): Merge conflict in Documentation/printk-formats.txt
Merging pci/next (f4a9034a443c Merge branch 'pci/spdx' into next)
CONFLICT (content): Merge conflict in include/linux/pci.h
CONFLICT (content): Merge conflict in arch/powerpc/platforms/powernv/eeh-powernv.c
Applying: PCI: fix up for "powerpc/eeh: Update VF config space after EEH"
$ git reset --hard HEAD^
Merging next-20180131 version of pci
CONFLICT (content): Merge conflict in include/linux/pci.h
CONFLICT (content): Merge conflict in arch/powerpc/platforms/powernv/eeh-powernv.c
[master 50c360fb35c77fc1f4f6559f7a7121f79a9a4053] next-20180131/pci
Applying: PCI: fix up for "powerpc/eeh: Update VF config space after EEH"
[master 7d33977a974f8a732620cb005c87e88a98955224] next-20180131/pci
Merging pstore/for-next/pstore (a99f41a1b441 fs: pstore: remove unused hardirq.h)
Merging hid/for-next (494622678bc9 Merge branch 'for-4.16/hid-quirks-cleanup/toshiba' into for-next)
Merging i2c/i2c/for-next (a2cdd4be7a2c Merge branch 'i2c/for-4.16' into i2c/for-next)
CONFLICT (content): Merge conflict in drivers/i2c/busses/i2c-designware-platdrv.c
CONFLICT (content): Merge conflict in MAINTAINERS
Merging dmi/master (0bcea5c474d1 firmware: dmi: handle missing DMI data gracefully)
Merging hwmon-staging/hwmon-next (6fbc4232a5ac hwmon: (dell-smm) Disable fan support for Dell Vostro 3360)
Merging jc_docs/docs-next (ae17a87dd7c7 linux-next: docs-rst: Fix typos in kfigure.py)
CONFLICT (content): Merge conflict in Documentation/core-api/printk-formats.rst
Merging v4l-dvb/master (273caa260035 media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs)
CONFLICT (modify/delete): include/media/lirc_dev.h deleted in v4l-dvb/master and modified in HEAD. Version HEAD of include/media/lirc_dev.h left in tree.
CONFLICT (modify/delete): drivers/staging/media/lirc/lirc_zilog.c deleted in v4l-dvb/master and modified in HEAD. Version HEAD of drivers/staging/media/lirc/lirc_zilog.c left in tree.
CONFLICT (content): Merge conflict in drivers/media/rc/lirc_dev.c
CONFLICT (content): Merge conflict in drivers/media/dvb-core/dmxdev.c
$ git rm -f include/media/lirc_dev.h drivers/staging/media/lirc/lirc_zilog.c
Applying: media: videobuf2: fix up for "media: annotate ->poll() instances"
Merging v4l-dvb-next/master (a1dfb4c48cc1 media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic)
Merging fbdev/fbdev-for-next (5865889fe431 video: udlfb: Switch from the pr_*() to the dev_*() logging functions)
Merging pm/linux-next (1c7385dbf8c5 Merge tag 'pnp-4.16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm)
Merging cpupower/cpupower (0e96a0c83f08 cpupower: Remove FSF address)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (e856f078bcf1 OPP: Introduce "required-opp" property)
Merging thermal/next (134f4010799a Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc' into next)
Merging thermal-soc/next (d0ecbbbe518e thermal/drivers/hisi: Remove bogus const from function return type)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversized DMA reads on JMicron controllers)
Merging dlm/next (9250e523592a dlm: remove dlm_send_rcom_lookup_dump)
Merging swiotlb/linux-next (69369f52d28a swiotlb-xen: implement xen_swiotlb_get_sgtable callback)
Merging net-next/master (a54667f6728c tls: Add support for encryption using async offload accelerator)
CONFLICT (content): Merge conflict in net/tipc/socket.c
CONFLICT (content): Merge conflict in net/smc/smc_clc.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
Merging bpf-next/master (868c36dcc949 Merge tag 'wireless-drivers-next-for-davem-2018-01-26' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next)
Merging ipsec-next/master (50bd870a9e5c xfrm: Add ESN support for IPSec HW offload)
Merging netfilter-next/master (c746fc0e8b2d cxgb4: add geneve offload support for T6)
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET support)
Merging ipvs-next/master (a910d20aa007 netfilter: ipvs: Fix space before '[' error.)
Merging wireless-drivers-next/master (f813614f5311 ibmvnic: Wait for device response when changing MAC)
Merging bluetooth/master (a54667f6728c tls: Add support for encryption using async offload accelerator)
Merging mac80211-next/master (ff84e7bfe176 mac80211: Add support to notify ht/vht opmode modification.)
Merging rdma/for-next (e7996a9a77fc Merge tag v4.15 of git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
Merging gfs2/for-next (0be600a5add7 Merge tag 'for-4.16/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm)
Merging mtd/master (fee4380f368e mtd: nand: pxa3xx: Fix READOOB implementation)
Merging l2-mtd/mtd/next (571cb17b23ec Merge tag 'nand/for-4.16' of git://git.infradead.org/linux-mtd into mtd/next)
Merging nand/nand/next (f4c6cd1a7f22 mtd: nand: sunxi: Fix ECC strength choice)
Merging spi-nor/spi-nor/next (23bae78e8a57 mtd: mtk-nor: modify functions' name more generally)
Merging crypto/master (2d55807b7f7b crypto: picoxcell - Fix error handling in spacc_probe())
Merging drm/drm-next (559f17bec508 Merge tag 'drm-misc-next-fixes-2018-01-18' of git://anongit.freedesktop.org/drm/drm-misc into drm-next)
CONFLICT (content): Merge conflict in drivers/gpu/drm/i915/intel_display.c
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add support for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (97e2e7a59b7c Revert "drm/i915: mark all device info struct with __initconst")
Merging drm-tegra/drm/tegra/for-next (8f62142e490d drm/tegra: dc: Properly cleanup overlay planes)
Merging drm-misc/for-linux-next (761e05a702f5 drm: Check for lessee in DROP_MASTER ioctl)
Merging drm-msm/msm-next (78d2b6936ea2 drm/msm/adreno: Rename gpmufw to powerfw)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances of drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (54243016ae35 drm: mali-dp: Disable planes when their CRTC gets disabled.)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/drm-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (4cfea3c1f271 gpu: ipu-v3: allow to build with COMPILE_TEST)
Merging etnaviv/etnaviv/next (a181196c86e1 drm/etnaviv: remove the need for a gpu-subsystem DT node)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (a75de7721184 Merge remote-tracking branches 'regmap/topic/soundwire' and 'regmap/topic/zero' into regmap-next)
Merging sound/for-next (1c9609e3a8cf ALSA: hda - Reduce the suspend time consumption for ALC256)
Merging sound-asoc/for-next (56821b5652e2 Merge remote-tracking branch 'asoc/fix/mtk' into asoc-linus)
Merging modules/modules-next (0cad61d7a3d5 modpost: Remove trailing semicolon)
Merging input/next (fafef982c735 Input: goodix - use generic touchscreen_properties)
Merging block/for-next (0ccfb3c0032b Merge branch 'for-4.16/block' into for-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pblk-init.c)
Merging device-mapper/for-next (de6ff5c58656 Merge branch 'dm-4.16' into block-4.16_dm-4.16)
Merging mmc/next (56174d9a2149 mmc: MMC_SDHI_{SYS,INTERNAL}_DMAC should depend on HAS_DMA)
Merging kgdb/kgdb-next (f1426e70698c kdb: use ktime_get_seconds() instead of ktime_get_ts())
Merging md/for-next (1532d9e87e8b raid5-ppl: PPL support for disks with write-back cache enabled)
Merging mfd/for-mfd-next (0f89ffefa4e1 mfd: lpc_ich: Do not touch SPI-NOR write protection bit on Apollo Lake)
Merging backlight/for-backlight-next (2023b0524a63 backlight: tdo24m: Fix the SPI CS between transfers)
Merging battery/for-next (8be4c3667cf1 MAINTAINERS: Add AXP288 PMIC entry)
Merging regulator/for-next (c8f64f281824 Merge remote-tracking branch 'regulator/fix/suspend' into regulator-linus)
Merging security/next-testing (400f428062af Merge branch 'next-integrity' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into next-testing)
CONFLICT (content): Merge conflict in security/integrity/ima/ima_main.c
Merging integrity/next-integrity (87075a9acb09 ima: re-initialize iint->atomic_flags)
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to prevent tainting)
Merging selinux/next (4b14752ec4e0 selinux: skip bounded transition processing if the policy isn't loaded)
Merging tpmdd/next (68021bf4734d tpm: remove unused variables)
Merging watchdog/master (d040a2ee0e62 watchdog: remove at32ap700x_wdt)
Merging iommu/next (fedbd940d1c2 Merge branches 'arm/renesas', 'arm/omap', 'arm/exynos', 'x86/amd', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (910170442944 iommu/vt-d: Fix PASID table allocation)
Merging vfio/next (46ed90f157f4 vfio: mdev: make a couple of functions and structure vfio_mdev_driver static)
Merging trivial/for-next (1972d6c0c86d MAINTAINERS: relinquish kconfig)
Merging audit/next (d8a5b80568a9 Linux 4.15)
Merging devicetree/for-next (3a6fbcb2e2e4 xtensa: remove arch specific early DT functions)
CONFLICT (content): Merge conflict in drivers/of/Kconfig
Merging mailbox/mailbox-for-next (ca64af43924f mailbox: ti-msgmgr: Use %zu for size_t print format)
Merging spi/for-next (d0cb047a0edb Merge tag 'spi-v4.16' into spi-next)
Merging tip/auto-latest (0f52a0d7229c Merge branch 'perf/core')
Merging clockevents/clockevents/next (322fd24f5e67 clocksource/drivers/stm32: Start the timer's counter sooner)
CONFLICT (content): Merge conflict in drivers/clocksource/timer-stm32.c
CONFLICT (content): Merge conflict in drivers/clocksource/timer-of.c
CONFLICT (content): Merge conflict in drivers/clocksource/Kconfig
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (68fa24f9121c EDAC, mv64x60: Fix an error handling path)
Merging irqchip/irqchip/for-next (c1ae3cfa0e89 Linux 4.11-rc1)
Merging ftrace/for-next (4397f04575c4 tracing: Fix possible double free on failure of allocating trace buffer)
Merging rcu/rcu/next (1dfa55e01987 Merge branches 'cond_resched.2017.12.04a', 'dyntick.2017.11.28a', 'fixes.2017.12.11a', 'srbd.2017.12.05a' and 'torture.2017.12.11a' into HEAD)
Merging kvm/linux-next (e53175395d7e Merge tag 'kvm-arm-for-v4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm)
CONFLICT (content): Merge conflict in virt/kvm/arm/arch_timer.c
CONFLICT (content): Merge conflict in arch/x86/include/asm/cpufeatures.h
CONFLICT (content): Merge conflict in Documentation/virtual/kvm/api.txt
Applying: KVM: x86: don't forget vcpu_put() in kvm_arch_vcpu_ioctl_set_sregs()
Merging kvm-arm/next (cd15d2050c04 KVM: arm/arm64: Fixup userspace irqchip static key optimization)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement TLBR for T&E)
Merging kvm-ppc/kvm-ppc-next (9b9b13a6d153 KVM: PPC: Book3S HV: Keep XIVE escalation interrupt masked unless ceded)
Merging kvms390/next (4b9f952577fb KVM: s390: introduce the format-1 GISA)
Merging xen-tip/linux-next (cf2acf66ad43 xen/gntdev: Fix partial gntdev_mmap() cleanup)
Merging percpu/for-next (85dcbba3b8b1 percpu: percpu_counter_initialized can be boolean)
Merging workqueues/for-next (a10eb37ccf1d Merge branch 'for-4.15-fixes' into for-next)
Merging drivers-x86/for-next (e5778689a965 platform/x86: GPD pocket fan: Stop work on suspend)
CONFLICT (content): Merge conflict in drivers/platform/x86/dell-laptop.c
Merging chrome-platform/for-next (d48b8c58c57f platform/chrome: Use proper protocol transfer function)
Merging hsi/for-next (b6dc80dbe6cd HSI: cmt_speech: use timespec64 instead of timespec)
Merging leds/for-next (6a836631e303 leds: ledtrig-transient: Add SPDX license identifiers)
Merging ipmi/for-next (e45af3d372f1 ipmi_ssif: Remove duplicate NULL check)
Merging driver-core/driver-core-next (c505cbd45f6e device property: Define type of PROPERTY_ENRTY_*() macros)
Merging usb/usb-next (d08dd3f3dd2a USB: serial: pl2303: new device id for Chilitag)
Merging usb-gadget/next (8ada211d0383 usb: renesas_usbhs: add extcon notifier to set mode for non-otg channel)
Merging usb-serial/usb-next (d1c48227d7c4 USB: serial: f81534: fix tx error on some baud rate)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx: Fix ULPI on imx53)
Merging phy-next/next (e4b227c1ca70 phy: phy-mtk-tphy: use of_device_get_match_data())
Merging tty/tty-next (c7e1b4059075 tty: serial: exar: Relocate sleep wake-up handling)
Merging char-misc/char-misc-next (9ff6576e124b char: lp: use true or false for boolean values)
Merging extcon/extcon-next (ca90a64dc671 extcon: axp288: Handle reserved charger-type values better)
Merging staging/staging-next (3384e01179ef staging: rtlwifi: remove redundant initialization of 'cfg_cmd')
CONFLICT (content): Merge conflict in drivers/staging/most/video/video.c
CONFLICT (content): Merge conflict in drivers/staging/most/cdev/cdev.c
CONFLICT (content): Merge conflict in drivers/Makefile
CONFLICT (content): Merge conflict in drivers/Kconfig
Merging mux/for-next (6cd361c99ef2 mux: add SPDX identifiers to all mux source files)
Merging slave-dma/next (6c773ba2c843 Merge branch 'for-linus' into next)
Merging cgroup/for-next (5ecf66c9dc2b Merge branch 'for-4.16' into for-next)
Merging scsi/for-next (f468cd2908f8 Merge branch 'postmerge' into for-next)
Merging scsi-mkp/for-next (a2390348c19d scsi: qla2xxx: Fix logo flag for qlt_free_session_done())
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wake up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (83ab14e6cacc Merge branch 'for-4.16' into for-next)
Merging vhost/linux-next (9991b95cb712 vhost: don't hold onto file pointer for VHOST_SET_LOG_FD)
Merging rpmsg/for-next (163c558b84fe Merge branches 'hwspinlock-next', 'rpmsg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (d58f2bf261fd gpio: Timestamp events in hardirq handler)
Merging pinctrl/for-next (02e389e63e35 pinctrl: mcp23s08: fix irq setup order)
Merging pinctrl-samsung/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging pwm/for-next (bccaa3f917c9 pwm: meson: Add clock source configuration for Meson-AXG)
Merging userns/for-next (9eba1cd4b565 24 Jan 2018 Merge of my siginfo and userns trees for testing in linux-next)
Merging ktest/for-next (f7c6401ff84a ktest: Make sure wait_for_input does honor the timeout)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and counting against aio-max-nr)
Merging kselftest/next (0e9e327d1622 selftests: vm: update .gitignore with missing generated file)
Merging y2038/y2038 (69973b830859 Linux 4.9)
Merging livepatching/for-next (d13f5d84ca27 Merge branch 'for-4.16/signal-sysfs-force-v2' into for-next)
Merging coresight/next (d8a5b80568a9 Linux 4.15)
Merging rtc/rtc-next (796c0ad79ee6 Documentation: rtc: move iotcl interface documentation to ABI)
Merging nvdimm/libnvdimm-for-next (807da390de05 Merge branch 'for-4.16/dax' into libnvdimm-for-next)
CONFLICT (modify/delete): arch/powerpc/sysdev/axonram.c deleted in HEAD and modified in nvdimm/libnvdimm-for-next. Version nvdimm/libnvdimm-for-next of arch/powerpc/sysdev/axonram.c left in tree.
CONFLICT (content): Merge conflict in arch/powerpc/platforms/Kconfig
$ git rm -f arch/powerpc/sysdev/axonram.c
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in LDFLAGS too)
Merging at24/at24/for-next (0f30aca72c3b eeprom: at24: extend the list of chips supported in DT)
Merging ntb/ntb-next (41db09c9cf1d NTB: ntb_perf: fix cast to restricted __le32)
Merging kspp/for-next/kspp (e47e311843de lkdtm: Update usercopy tests for whitelisting)
CONFLICT (content): Merge conflict in net/sctp/socket.c
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging akpm-current/current (70afe1ed7c0f ipc/mqueue.c: have RT tasks queue in by priority in wq_add())
$ git checkout -b akpm remotes/origin/akpm/master
Applying: ipc/mqueue: add missing error code in init_mqueue_fs()
Applying: fs/crypto/hooks.c: fix build with gcc-4.4.4
Applying: net/netfilter/x_tables.c: make allocation less aggressive
Applying: net/netfilter/x_tables.c: remove size check
Applying: arch/score/kernel/setup.c: combine two seq_printf() calls into one call in show_cpuinfo()
Applying: vfs: remove might_sleep() from clear_inode()
Applying: mm/userfaultfd.c: remove duplicate include
Applying: mm: remove unneeded kallsyms include
Applying: hrtimer: remove unneeded kallsyms include
Applying: genirq: remove unneeded kallsyms include
Applying: mm/memblock: memblock_is_map/region_memory can be boolean
Applying: lib/lockref: __lockref_is_dead can be boolean
Applying: kernel/cpuset: current_cpuset_is_being_rebound can be boolean
Applying: kernel/resource: iomem_is_exclusive can be boolean
Applying: kernel/module: module_is_live can be boolean
Applying: kernel/mutex: mutex_is_locked can be boolean
Applying: crash_dump: is_kdump_kernel can be boolean
Applying: certs/blacklist_nohashes.c: fix const confusion in certs blacklist
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer overflow
Applying: kasan: rework Kconfig settings
Applying: sparc64: NG4 memset 32 bits overflow
Applying: pipe, sysctl: drop 'min' parameter from pipe-max-size converter
Applying: pipe, sysctl: remove pipe_proc_fn()
Applying: pipe: actually allow root to exceed the pipe buffer limits
Applying: pipe: fix off-by-one error when checking buffer limits
Applying: pipe: reject F_SETPIPE_SZ with size over UINT_MAX
Applying: pipe: simplify round_pipe_size()
Applying: pipe: read buffer limits atomically
Applying: mm: docs: fixup punctuation
Applying: mm: docs: fix parameter names mismatch
Applying: mm: docs: add blank lines to silence sphinx "Unexpected indentation" errors
Applying: MAINTAINERS: remove ANDROID ION pattern
Applying: MAINTAINERS: remove ARM/CLKDEV SUPPORT file pattern
Applying: MAINTAINERS: update Cortina/Gemini patterns
Applying: MAINTAINERS: update "ARM/OXNAS platform support" patterns
Applying: maintainers-update-arm-oxnas-platform-support-patterns-fix
Applying: MAINTAINERS: update various PALM patterns
Applying: MAINTAINERS: update ARM/QUALCOMM SUPPORT patterns
Merging akpm/master (add1944e4a76 MAINTAINERS: update ARM/QUALCOMM SUPPORT patterns)
