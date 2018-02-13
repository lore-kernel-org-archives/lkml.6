Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933413AbeBMEPy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 23:15:54 -0500
Received: from ozlabs.org ([103.22.144.67]:43149 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933025AbeBMEPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 23:15:49 -0500
Date: Tue, 13 Feb 2018 15:15:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Tree for Feb 13
Message-ID: <20180213151545.43e078ca@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Changes since 20180212:

Non-merge commits (relative to Linus' tree): 963
 1297 files changed, 63627 insertions(+), 31515 deletions(-)

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
Merging origin/master (178e834c47b0 Merge branch 'linus' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6)
Merging fixes/master (7928b2cbe55b Linux 4.16-rc1)
Merging kbuild-current/fixes (36c1681678b5 genksyms: drop *.hash.c from .gitignore)
Merging arc-current/for-curr (053823335956 arc: dts: use 'atmel' as manufacturer for at24 in axs10x_mb)
Merging arm-current/fixes (091f02483df7 ARM: net: bpf: clarify tail_call index)
Merging m68k-current/for-linus (2334b1ac1235 MAINTAINERS: Add NuBus subsystem entry)
Merging metag-fixes/fixes (b884a190afce metag/usercopy: Add missing fixups)
Merging powerpc-fixes/fixes (4dd5f8a99e79 powerpc/mm/radix: Split linear mapping on hot-unplug)
Merging sparc/master (aebb48f5e465 sparc64: fix typo in CONFIG_CRYPTO_DES_SPARC64 => CONFIG_CRYPTO_CAMELLIA_SPARC64)
Merging fscrypt-current/for-stable (ae64f9bd1d36 Linux 4.15-rc2)
Merging net/master (07a2e1cf3981 net: cavium: fix NULL pointer dereference in cavium_ptp_put)
Merging bpf/master (1b12580af1d0 bridge: check brport attr show in brport_show)
Merging ipsec/master (545d8ae7afff xfrm: fix boolean assignment in xfrm_get_type_offload)
Merging netfilter/master (fd2c19b2a28b netfilter: x_tables: remove size check)
Merging ipvs/master (f7fb77fc1235 netfilter: nft_compat: check extension hook mask only if set)
Merging wireless-drivers/master (7ac8ff95f48c mvpp2: fix multicast address filter)
Merging mac80211/master (c4de37ee2b55 mac80211: mesh: fix wrong mesh TTL offset calculation)
Merging rdma-fixes/for-rc (7928b2cbe55b Linux 4.16-rc1)
Merging sound-current/for-linus (1dcb1859dd67 Merge branch 'topic/fixes' into for-linus)
Merging pci-current/for-linus (7928b2cbe55b Linux 4.16-rc1)
Merging driver-core.current/driver-core-linus (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging tty.current/tty-linus (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging usb.current/usb-linus (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging usb-gadget-fixes/fixes (b2cd1df66037 Linux 4.15-rc7)
Merging usb-serial-fixes/usb-linus (d14ac576d10f USB: serial: cp210x: add new device ID ELV ALC 8xxx)
Merging usb-chipidea-fixes/ci-for-usb-stable (964728f9f407 USB: chipidea: msm: fix ulpi-node lookup)
Merging phy/fixes (7928b2cbe55b Linux 4.16-rc1)
Merging staging.current/staging-linus (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging char-misc.current/char-misc-linus (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging input-current/for-linus (ea4f7bd2aca9 Input: matrix_keypad - fix race when disabling interrupts)
Merging crypto-current/master (2e7d1d61ea6c crypto: sun4i_ss_prng - convert lock to _bh in sun4i_ss_prng_generate)
Merging ide/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_time')
Merging vfio-fixes/for-linus (563b5cbe334e iommu/arm-smmu-v3: Cope with duplicated Stream IDs)
Merging kselftest-fixes/fixes (ae64f9bd1d36 Linux 4.15-rc2)
Merging backlight-fixes/for-backlight-fixes (8ff5cbc6e3c5 backlight: as3711_bl: fix device-tree node leaks)
Merging nand-fixes/nand/fixes (ee02f73e04c0 mtd: nand: atmel: Fix EDO mode check)
Merging spi-nor-fixes/spi-nor/fixes (10a6a6975691 Revert "dt-bindings: mtd: add sst25wf040b and en25s64 to sip-nor list")
Merging mfd-fixes/for-mfd-fixes (107b7d9fa94c mfd: rtsx: Release IRQ during shutdown)
Merging v4l-dvb-fixes/fixes (781b045baefd media: imx274: Fix error handling, add MAINTAINERS entry)
Merging reset-fixes/reset/fixes (f450f28e70a2 reset: socfpga: fix for 64-bit compilation)
Merging mips-fixes/mips-fixes (ad233a6acb5e MIPS: BMIPS: Fix section mismatch warning)
Merging kvm-fixes/master (d8a5b80568a9 Linux 4.15)
Merging kvms390-fixes/master (1de1ea7efeb9 KVM: s390: add proper locking for CMMA migration bitmap)
Merging drm-intel-fixes/for-linux-next-fixes (d8a5b80568a9 Linux 4.15)
Merging drm-misc-fixes/for-linux-next-fixes (54f809cfbd6b drm/atomic: Fix memleak on ERESTARTSYS during non-blocking commits)
Merging kbuild/for-next (9a61df9e5f74 Merge tag 'kbuild-v4.16-2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild)
Merging uuid/for-next (c0020756315e efi: switch to use new generic UUID API)
Merging dma-mapping/for-next (04f56534786c MAINTAINERS: add the iommu list for swiotlb and xen-swiotlb)
Merging asm-generic/master (a351e9b9fc24 Linux 4.11)
Merging arc/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging arm/for-next (3a175cdf4392 Merge branches 'fixes', 'misc', 'sa1111' and 'sa1100-for-next' into for-next)
Merging arm-perf/for-next/perf (7520fa99246d perf: ARM DynamIQ Shared Unit PMU support)
Merging arm-soc/for-next (2aa127e4d579 Merge branches 'next/dt' and 'next/drivers' into for-next)
Merging actions/for-next (61862a89e6ac Merge branch 'v4.16/drivers' into next)
Merging alpine/alpine/for-next (a1144b2b1ec4 ARM: dts: alpine: add valid clock-frequency values)
Merging amlogic/for-next (b1303f3fa73b Merge branch 'v4.17/drivers' into tmp/aml-rebuild)
Merging aspeed/for-next (8203ca9789bc Merge branch 'dt-for-v4.16' into for-next)
Merging at91/at91-next (fa4cf68ab4b1 Merge tag 'at91-ab-4.16-dt' into at91-next)
Merging bcm2835/for-next (a6189bcc0012 Merge branch anholt/bcm2835-drivers-next into for-next)
Merging imx-mxs/for-next (914867289762 Merge branch 'imx/defconfig' into for-next)
Merging keystone/next (a29b8b93e158 Merge branch 'for_4.16/keystone-config' into next)
Merging mvebu/for-next (91cbd0893d7d Merge branch 'mvebu/dt64' into mvebu/for-next)
Merging omap/for-next (e38c38728951 Merge branch 'omap-for-v4.16/ti-sysc' into for-next)
CONFLICT (content): Merge conflict in arch/arm/boot/dts/dra7.dtsi
Merging reset/reset/next (70d2f16a6289 reset: meson: enable level reset support on Meson8b)
Merging qcom/for-next (f5788d2f2929 Merge tag 'qcom-arm64-defconfig-for-4.16' into tagged-for-4.16)
Merging realtek/for-next (2b6286eb7ab8 Merge branch 'v4.15/dt64' into next)
Merging renesas/next (1b8c4dc7334d Merge branches 'arm64-dt-for-v4.17', 'defconfig-for-v4.17', 'dt-bindings-for-v4.17', 'dt-for-v4.17' and 'soc-for-v4.17' into next)
Merging rockchip/for-next (3f140011fa63 Merge branch 'v4.17-clk/next' into for-next)
Merging samsung/for-next (bebc6082da0a Linux 4.14)
Merging samsung-krzk/for-next (e57dfafc0beb Merge branch 'next/drivers' into for-next)
Merging sunxi/sunxi/for-next (d7ec2c507677 Merge branch 'sunxi/fixes-for-4.15' into sunxi/for-next)
Merging tegra/for-next (983371acdeda Merge branch for-4.16/arm64/dt into for-next)
Merging arm64/for-next/core (3a0a397ff5ff arm64: Kill PSCI_GET_VERSION as a variant-2 workaround)
Merging clk/clk-next (c43a52cfd27b Merge branches 'clk-aspeed', 'clk-lock-UP', 'clk-mediatek' and 'clk-allwinner' into clk-next)
Merging clk-samsung/for-next (7685570f2ae2 clk: samsung: s3c: Remove unneeded enumeration)
Merging c6x/for-linux-next (9d440f7a2824 c6x: fix platforms/plldata.c get_coreid build error)
Merging cris/for-next (fd989db807a0 cris: Fix conflicting types for _etext, _edata, _end)
Merging m68k/for-next (2334b1ac1235 MAINTAINERS: Add NuBus subsystem entry)
Merging m68knommu/for-next (0d665e7b109d mm, page_vma_mapped: Drop faulty pointer arithmetics in check_pte())
Merging metag/for-next (e3cd7f013bac metag/mm: Drop pointless increment)
Merging microblaze/next (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging mips/mips-next (ea4d340cbea4 Merge branches '4.15-fixes', '4.16-features' and 'octeon-3-net-mips-bits' into mips-next)
Merging mips-james/mips-next (791412dafbbf MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base())
Merging nios2/for-next (e0691ebb33c1 nios2: defconfig: Cleanup from old Kconfig options)
Merging openrisc/for-next (0fedb7653af7 openrisc: remove unused __ARCH_HAVE_MMU define)
Merging parisc-hd/for-next (bebc6082da0a Linux 4.14)
Merging powerpc/next (015eb1b89e95 powerpc/mm/radix: Fix build error when RADIX_MMU=n)
Merging fsl/next (c095ff93f901 powerpc/sysdev: change CPM GPIO to platform_device)
Merging risc-v/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging s390/features (48973df8c9c5 s390/kconfig: Remove ARCH_WANTS_PROT_NUMA_PROT_NONE select)
Merging sparc-next/master (8e44e6600caa Merge branch 'KASAN-read_word_at_a_time')
Merging sh/for-next (6e2fbfdd585f sh: fix futex FUTEX_OP_SET op on userspace addresses)
Merging uml/linux-next (02eb0b11eab5 um: Add missing EXPORT for free_irq_by_fd())
Merging xtensa/xtensa-for-next (e69bf251406b Merge branch 'xtensa-fixes' into xtensa-for-next)
Merging fscrypt/master (0b1dfa4cc6c6 fscrypt: fix build with pre-4.6 gcc versions)
Merging befs/for-next (55d945e2e4aa fs: befs: btree: Fixed some coding standard issues)
Merging btrfs/next (7c9a09f56a91 btrfs: don't use async helpers for crcs when under IO limits)
Applying: f2fs: fixup for cgroup/writeback change
Merging btrfs-kdave/for-next (993b08a92e32 Merge branch 'for-next-next-v4.16-20180207' into for-next-20180207)
CONFLICT (content): Merge conflict in fs/btrfs/tree-log.c
CONFLICT (content): Merge conflict in fs/btrfs/disk-io.c
Merging ceph/master (16515a6d5418 ceph: improving efficiency of syncfs)
Merging cifs/for-next (64ffdd6b6cfe CIFS: SMBD: fix spelling mistake: "faield" and "legnth")
Merging configfs/for-next (6ace4f6bbcfd RDMA/cma: make config_item_type const)
Merging ecryptfs/next (4670269faba7 eCryptfs: constify attribute_group structures.)
Merging ext3/for_next (f463589a7cd2 ext2: drop unneeded newline)
Merging ext4/dev (5dc397113d19 ext4: create ext4_kset dynamically)
Merging f2fs/dev (1c1d35df7110 f2fs: support inode creation time)
Merging fuse/for-next (c6cdd51404b7 fuse: fix READDIRPLUS skipping an entry)
Merging jfs/jfs-next (86313903430d MAINTAINERS: fix jfs tree location)
Merging nfs/linux-next (7928b2cbe55b Linux 4.16-rc1)
Merging nfs-anna/linux-next (c54c14ba000d xprtrdma: Spread reply processing over more CPUs)
CONFLICT (content): Merge conflict in net/sunrpc/xprtrdma/transport.c
CONFLICT (content): Merge conflict in net/sunrpc/xprt.c
Merging nfsd/nfsd-next (175e03101d36 svcrdma: Fix Read chunk round-up)
Merging orangefs/for-next (74e938c22705 orangefs: reverse sense of is-inode-stale test in d_revalidate)
Merging overlayfs/overlayfs-next (9b6faee07470 ovl: check ERR_PTR() return value from ovl_encode_fh())
Merging ubifs/linux-next (7f29ae9f977b ubi: block: Fix locking for idr_alloc/idr_remove)
Merging xfs/for-next (76883f7988e6 xfs: remove experimental tag for reverse mapping)
Merging file-locks/locks-next (1deab8ce2c91 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc)
Merging vfs/for-next (d85e2aa2e34d annotate ep_scan_ready_list())
Merging vfs-miklos/next (0eb8af4916a5 vfs: use helper for calling f_op->fsync())
Merging iversion/iversion-next (581e400ff935 Merge tag 'modules-for-v4.16' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux)
Merging printk/for-next (02fffdcaed19 Merge branch 'for-4.17' into for-next)
Merging pci/next (7928b2cbe55b Linux 4.16-rc1)
Merging pstore/for-next/pstore (a99f41a1b441 fs: pstore: remove unused hardirq.h)
Merging hid/for-next (494622678bc9 Merge branch 'for-4.16/hid-quirks-cleanup/toshiba' into for-next)
Merging i2c/i2c/for-next (a2cdd4be7a2c Merge branch 'i2c/for-4.16' into i2c/for-next)
CONFLICT (content): Merge conflict in drivers/i2c/i2c-core-smbus.c
Merging dmi/master (36a840c73dc6 firmware: dmi: handle missing DMI data gracefully)
Merging hwmon-staging/hwmon-next (e464243586cb hwmon: (sht3x) Update data sheet URL)
Merging jc_docs/docs-next (7928b2cbe55b Linux 4.16-rc1)
Merging v4l-dvb/master (61605f79d576 Merge tag 'v4.16-rc1' into patchwork)
Merging v4l-dvb-next/master (a1dfb4c48cc1 media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic)
Merging fbdev/fbdev-for-next (5865889fe431 video: udlfb: Switch from the pr_*() to the dev_*() logging functions)
Merging pm/linux-next (7928b2cbe55b Linux 4.16-rc1)
Merging cpupower/cpupower (0e96a0c83f08 cpupower: Remove FSF address)
Merging idle/next (8a5776a5f498 Linux 4.14-rc4)
Merging opp/opp/linux-next (4a823c0be80f opp: cpu: Replace GFP_ATOMIC with GFP_KERNEL in dev_pm_opp_init_cpufreq_table)
Merging thermal/next (134f4010799a Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc' into next)
Merging thermal-soc/next (d0ecbbbe518e thermal/drivers/hisi: Remove bogus const from function return type)
Merging ieee1394/for-next (188775181bc0 firewire-ohci: work around oversized DMA reads on JMicron controllers)
Merging dlm/next (9250e523592a dlm: remove dlm_send_rcom_lookup_dump)
Merging swiotlb/linux-next (69369f52d28a swiotlb-xen: implement xen_swiotlb_get_sgtable callback)
Merging net-next/master (9b2c45d479d0 net: make getname() functions return length rather than use int* parameter)
Merging bpf-next/master (7928b2cbe55b Linux 4.16-rc1)
Merging ipsec-next/master (255442c93843 Merge tag 'docs-4.16' of git://git.lwn.net/linux)
Merging netfilter-next/master (c746fc0e8b2d cxgb4: add geneve offload support for T6)
Merging nfc-next/master (4d63adfe12dd NFC: Add NFC_CMD_DEACTIVATE_TARGET support)
Merging ipvs-next/master (a910d20aa007 netfilter: ipvs: Fix space before '[' error.)
Merging wireless-drivers-next/master (99ffd198f07f Merge ath-current from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git)
Merging bluetooth/master (907f84990924 Bluetooth: btrtl: Add RTL8723D and RTL8821C devices)
Merging mac80211-next/master (ff84e7bfe176 mac80211: Add support to notify ht/vht opmode modification.)
Merging rdma/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging gfs2/for-next (35277995e179 Merge branch 'x86-pti-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip)
Merging mtd/master (f23def803861 mtd: nand: MTD_NAND_MARVELL should depend on HAS_DMA)
Merging l2-mtd/mtd/next (571cb17b23ec Merge tag 'nand/for-4.16' of git://git.infradead.org/linux-mtd into mtd/next)
Merging nand/nand/next (1b8c90985f59 mtd: nand: vf610: check mtd_device_register() return code)
Merging spi-nor/spi-nor/next (23bae78e8a57 mtd: mtk-nor: modify functions' name more generally)
Merging crypto/master (2d55807b7f7b crypto: picoxcell - Fix error handling in spacc_probe())
Merging drm/drm-next (94fc27ac487a Merge tag 'drm-intel-next-fixes-2018-02-07' of git://anongit.freedesktop.org/drm/drm-intel into drm-next)
Merging drm-panel/drm/panel/for-next (e4bac408b084 drm/panel: simple: Add support for Winstar WF35LTIACD)
Merging drm-intel/for-linux-next (6dd3104e7894 drm/i915/bios: add DP max link rate to VBT child device struct)
Merging drm-tegra/drm/tegra/for-next (8f62142e490d drm/tegra: dc: Properly cleanup overlay planes)
Merging drm-misc/for-linux-next (761e05a702f5 drm: Check for lessee in DROP_MASTER ioctl)
Merging drm-msm/msm-next (9afe236df559 drm/msm/dsi: Fix potential NULL pointer dereference in msm_dsi_modeset_init)
Merging hdlcd/for-upstream/hdlcd (f73e8b825315 drm/arm: Replace instances of drm_dev_unref with drm_dev_put.)
Merging mali-dp/for-upstream/mali-dp (54243016ae35 drm: mali-dp: Disable planes when their CRTC gets disabled.)
Merging sunxi-drm/sunxi-drm/for-next (7dafb83edd32 Merge branches 'sunxi/drm-fixes-for-4.13' and 'sunxi/drm-for-4.14' into sunxi-drm/for-next)
Merging imx-drm/imx-drm/next (4cfea3c1f271 gpu: ipu-v3: allow to build with COMPILE_TEST)
Merging etnaviv/etnaviv/next (246774d17fc0 drm/etnaviv: remove the need for a gpu-subsystem DT node)
Merging kconfig/for-next (bebc6082da0a Linux 4.14)
Merging regmap/for-next (285f9d04b0e2 Merge remote-tracking branch 'regmap/fix/i2c' into regmap-linus)
Merging sound/for-next (bafeca673f04 Merge branch 'topic/hda-sync-power' into for-next)
Merging sound-asoc/for-next (3f9916c9745f Merge remote-tracking branches 'asoc/topic/wm9713', 'asoc/topic/wm9867', 'asoc/topic/wm_adsp' and 'asoc/topic/zx_aud96p22' into asoc-next)
Merging modules/modules-next (0cad61d7a3d5 modpost: Remove trailing semicolon)
Merging input/next (cdc2466df40f Input: synaptics - handle errors from input_mt_init_slots())
Merging block/for-next (0ccfb3c0032b Merge branch 'for-4.16/block' into for-next)
Merging lightnvm/for-next (1c6286f26301 lightnvm: fix some error code in pblk-init.c)
Merging device-mapper/for-next (de6ff5c58656 Merge branch 'dm-4.16' into block-4.16_dm-4.16)
CONFLICT (content): Merge conflict in include/linux/blk_types.h
CONFLICT (content): Merge conflict in block/blk-mq.c
CONFLICT (content): Merge conflict in block/blk-core.c
Merging mmc/next (56174d9a2149 mmc: MMC_SDHI_{SYS,INTERNAL}_DMAC should depend on HAS_DMA)
Merging kgdb/kgdb-next (2cf2f0d5b91f kdb: use memmove instead of overlapping memcpy)
Merging md/for-next (1532d9e87e8b raid5-ppl: PPL support for disks with write-back cache enabled)
Merging mfd/for-mfd-next (0f89ffefa4e1 mfd: lpc_ich: Do not touch SPI-NOR write protection bit on Apollo Lake)
Merging backlight/for-backlight-next (2023b0524a63 backlight: tdo24m: Fix the SPI CS between transfers)
Merging battery/for-next (8be4c3667cf1 MAINTAINERS: Add AXP288 PMIC entry)
Merging regulator/for-next (545beb2e3da5 Merge remote-tracking branch 'regulator/topic/core' into regulator-next)
Merging security/next-testing (400f428062af Merge branch 'next-integrity' of git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity into next-testing)
Merging integrity/next-integrity (b79f5f38d87f fuse: introduce new fs_type flag FS_IMA_NO_CACHE)
CONFLICT (content): Merge conflict in security/integrity/ima/ima_main.c
Merging keys/keys-next (1e684d3820d8 pkcs7: Set the module licence to prevent tainting)
Merging selinux/next (7928b2cbe55b Linux 4.16-rc1)
Merging tpmdd/next (68021bf4734d tpm: remove unused variables)
Merging watchdog/master (7928b2cbe55b Linux 4.16-rc1)
Merging iommu/next (fedbd940d1c2 Merge branches 'arm/renesas', 'arm/omap', 'arm/exynos', 'x86/amd', 'x86/vt-d' and 'core' into next)
Merging dwmw2-iommu/master (910170442944 iommu/vt-d: Fix PASID table allocation)
Merging vfio/next (46ed90f157f4 vfio: mdev: make a couple of functions and structure vfio_mdev_driver static)
Merging trivial/for-next (1972d6c0c86d MAINTAINERS: relinquish kconfig)
Merging audit/next (d8a5b80568a9 Linux 4.15)
Merging devicetree/for-next (7ea5c83472d3 Merge branches 'dt/next' and 'dt/linus' into for-next)
Merging mailbox/mailbox-for-next (0ae7d327a64b dt-bindings: mailbox: qcom: Document the APCS clock binding)
Merging spi/for-next (74c673eb103a Merge remote-tracking branches 'spi/topic/dw', 'spi/topic/kconfig' and 'spi/topic/pxa2xx' into spi-next)
Merging tip/auto-latest (edf28e12ae74 Merge branch 'linus')
Merging clockevents/clockevents/next (322fd24f5e67 clocksource/drivers/stm32: Start the timer's counter sooner)
CONFLICT (content): Merge conflict in drivers/clocksource/timer-stm32.c
CONFLICT (content): Merge conflict in drivers/clocksource/timer-of.c
CONFLICT (content): Merge conflict in drivers/clocksource/Kconfig
Merging edac/linux_next (345fb0a9a634 Merge tag 'edac_for_4.11' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp)
Merging edac-amd/for-next (68fa24f9121c EDAC, mv64x60: Fix an error handling path)
Merging irqchip/irqchip/for-next (c1ae3cfa0e89 Linux 4.11-rc1)
Merging ftrace/for-next (841a915d20c7 vsprintf: Do not have bprintf dereference pointers)
Merging rcu/rcu/next (1dfa55e01987 Merge branches 'cond_resched.2017.12.04a', 'dyntick.2017.11.28a', 'fixes.2017.12.11a', 'srbd.2017.12.05a' and 'torture.2017.12.11a' into HEAD)
Merging kvm/linux-next (1ab03c072feb Merge tag 'kvm-ppc-next-4.16-2' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc)
Merging kvm-arm/next (cd15d2050c04 KVM: arm/arm64: Fixup userspace irqchip static key optimization)
Merging kvm-mips/next (dc44abd6aad2 KVM: MIPS/Emulate: Properly implement TLBR for T&E)
Merging kvm-ppc/kvm-ppc-next (09f984961c13 KVM: PPC: Book3S: Add MMIO emulation for VMX instructions)
Merging kvms390/next (3d647e1f290c KVM: s390: use switch vs jump table in interrupt.c)
Merging xen-tip/linux-next (156ba2a25614 x86/xen: Calculate __max_logical_packages on PV domains)
Merging percpu/for-next (685469e5bf9d percpu: add Dennis Zhou as a percpu co-maintainer)
Merging workqueues/for-next (a10eb37ccf1d Merge branch 'for-4.15-fixes' into for-next)
Merging drivers-x86/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging chrome-platform/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging hsi/for-next (b6dc80dbe6cd HSI: cmt_speech: use timespec64 instead of timespec)
Merging leds/for-next (6204f03d3f54 leds: Clarify supported chips by LM355x driver)
Merging ipmi/for-next (e45af3d372f1 ipmi_ssif: Remove duplicate NULL check)
Merging driver-core/driver-core-next (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging usb/usb-next (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging usb-gadget/next (8ada211d0383 usb: renesas_usbhs: add extcon notifier to set mode for non-otg channel)
Merging usb-serial/usb-next (d1c48227d7c4 USB: serial: f81534: fix tx error on some baud rate)
Merging usb-chipidea-next/ci-for-usb-next (ce4c1b820c52 usb: chipidea: imx: Fix ULPI on imx53)
Merging phy-next/next (7928b2cbe55b Linux 4.16-rc1)
Merging tty/tty-next (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging char-misc/char-misc-next (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging extcon/extcon-next (7928b2cbe55b Linux 4.16-rc1)
Merging staging/staging-next (f1517df8701c Merge tag 'nfsd-4.16' of git://linux-nfs.org/~bfields/linux)
Merging mux/for-next (6cd361c99ef2 mux: add SPDX identifiers to all mux source files)
Merging slave-dma/next (5ec91512231a Merge branch 'topic/renesas' into next)
Merging cgroup/for-next (c53593e5cb69 sched, cgroup: Don't reject lower cpu.max on ancestors)
Merging scsi/for-next (7aa28b43b8ff Merge branch 'misc' into for-next)
Merging scsi-mkp/for-next (d4136d612a52 scsi: pmcraid: remove redundant initializations of pointer 'ioadl')
Merging target-updates/for-next (1c130ae00b76 iscsi-target: make sure to wake up sleeping login worker)
Merging target-bva/for-next (4fbd8d194f06 Linux 4.15-rc1)
Merging libata/for-next (da77d76b95a0 sata_rcar: Reset SATA PHY when Salvator-X board resumes)
Merging vhost/linux-next (26d99834f89e 9p/trans_virtio: discard zero-length reply)
Merging rpmsg/for-next (ec6e69036956 Merge branches 'hwspinlock-next', 'rpmsg-next' and 'rproc-next' into for-next)
Merging gpio/for-next (3c87d7c874b2 gpio: davinci: add support for pinmux gpio ranges)
Merging pinctrl/for-next (cfc09838477f Merge branch 'devel' into for-next)
Merging pinctrl-samsung/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging pwm/for-next (bccaa3f917c9 pwm: meson: Add clock source configuration for Meson-AXG)
Merging userns/for-next (9eba1cd4b565 24 Jan 2018 Merge of my siginfo and userns trees for testing in linux-next)
Merging ktest/for-next (f7c6401ff84a ktest: Make sure wait_for_input does honor the timeout)
Merging random/dev (9e66317d3c92 Linux 4.14-rc3)
Merging aio/master (2a8a98673c13 fs: aio: fix the increment of aio-nr and counting against aio-max-nr)
Merging kselftest/next (0e9e327d1622 selftests: vm: update .gitignore with missing generated file)
Merging y2038/y2038 (69973b830859 Linux 4.9)
Merging livepatching/for-next (d13f5d84ca27 Merge branch 'for-4.16/signal-sysfs-force-v2' into for-next)
Merging coresight/next (7928b2cbe55b Linux 4.16-rc1)
Merging rtc/rtc-next (7928b2cbe55b Linux 4.16-rc1)
Merging nvdimm/libnvdimm-for-next (ee95f4059a83 Merge branch 'for-4.16/nfit' into libnvdimm-for-next)
Merging idr/idr-4.11 (f0f3f2d0a3e0 radix tree test suite: Specify -m32 in LDFLAGS too)
Merging at24/at24/for-next (7928b2cbe55b Linux 4.16-rc1)
Merging ntb/ntb-next (53c3677c56c7 ntb: intel: change references of skx to gen3)
Merging kspp/for-next/kspp (2d00fcb32f71 Merge branch 'kspp/gcc-plugin/infrastructure' into for-next/kspp)
Merging init_task/init_task (e1e871aff3de Expand INIT_STRUCT_PID and remove)
Merging akpm-current/current (0f2ac581fd9b uapi: fix linux/sysctl.h userspace compilation errors)
CONFLICT (content): Merge conflict in kernel/fork.c
$ git checkout -b akpm remotes/origin/akpm/master
Applying: ipc/mqueue: add missing error code in init_mqueue_fs()
Applying: drivers/media/platform/sti/delta/delta-ipc.c: fix read buffer overflow
Applying: sparc64: NG4 memset 32 bits overflow
Merging akpm/master (ac2b2cb60c37 sparc64: NG4 memset 32 bits overflow)
