Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B9AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A053B2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbeLQPME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:12:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45178 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726667AbeLQPMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:12:03 -0500
Received: from ben by shadbolt.decadent.org.uk with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gYuYV-00042u-Eb; Mon, 17 Dec 2018 15:11:58 +0000
Date:   Mon, 17 Dec 2018 15:11:39 +0000
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, Jiri Slaby <jslaby@suse.cz>,
        stable@vger.kernel.org
Cc:     lwn@lwn.net
Message-ID: <lsq.1545059432.853471577@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pwu4i46rx4biyqof"
Content-Disposition: inline
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: ben@decadent.org.uk
Subject: Linux 3.16.62
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on shadbolt.decadent.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pwu4i46rx4biyqof
Content-Type: multipart/mixed; boundary="gwpmnc3xw47uimwk"
Content-Disposition: inline


--gwpmnc3xw47uimwk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.16.62 kernel.

All users of the 3.16 kernel series should upgrade.

The updated 3.16.y git tree can be found at:
        https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
=2Egit linux-3.16.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git

The diff from 3.16.61 is attached to this message.

Ben.

------------

 Makefile                                           |   2 +-
 arch/arc/kernel/process.c                          |  20 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   1 +
 arch/arm/kvm/mmu.c                                 |  42 ++-
 arch/arm/mach-hisi/hotplug.c                       |  19 +-
 arch/arm/mm/ioremap.c                              |   2 +-
 arch/arm64/kvm/guest.c                             |  45 +++
 arch/arm64/mm/init.c                               |   6 +-
 arch/mips/include/asm/processor.h                  |  15 +-
 arch/mips/kernel/ptrace.c                          |   2 +-
 arch/mips/kernel/ptrace32.c                        |   2 +-
 arch/mips/lib/memset.S                             |   4 +-
 arch/powerpc/include/asm/fadump.h                  |   3 -
 arch/powerpc/kernel/fadump.c                       |  92 ++++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |   2 +-
 arch/powerpc/mm/numa.c                             |   4 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  37 ++
 arch/powerpc/platforms/pseries/ras.c               |   4 +-
 arch/powerpc/sysdev/mpic_msgr.c                    |   2 +-
 arch/s390/include/asm/qdio.h                       |   1 -
 arch/s390/mm/fault.c                               |   2 +
 arch/s390/pci/pci.c                                |   2 +
 arch/x86/include/asm/kdebug.h                      |  12 +-
 arch/x86/include/asm/microcode_intel.h             |  15 +
 arch/x86/include/asm/percpu.h                      |   8 +-
 arch/x86/include/asm/pgtable_64.h                  |  16 +-
 arch/x86/include/asm/processor.h                   |   4 +-
 arch/x86/kernel/Makefile                           |   1 +
 arch/x86/kernel/cpu/bugs.c                         |  46 ++-
 arch/x86/kernel/cpu/common.c                       |   1 +
 arch/x86/kernel/cpu/intel.c                        |  14 +-
 arch/x86/kernel/cpu/microcode/amd.c                |  22 +-
 arch/x86/kernel/cpu/microcode/intel.c              |  31 +-
 arch/x86/kernel/cpu/microcode/intel_early.c        |  33 +-
 arch/x86/kernel/dumpstack_32.c                     |   2 +-
 arch/x86/kernel/dumpstack_64.c                     |   2 +-
 arch/x86/kernel/eisa.c                             |  24 ++
 arch/x86/kernel/paravirt.c                         |   4 +-
 arch/x86/kernel/process_32.c                       |   4 +-
 arch/x86/kernel/process_64.c                       |  11 +-
 arch/x86/kernel/traps.c                            |  13 -
 arch/x86/mm/kmemcheck/error.c                      |   2 +-
 arch/x86/mm/pgtable.c                              |   6 +-
 arch/x86/vdso/vclock_gettime.c                     |  18 +-
 arch/xtensa/include/asm/cacheasm.h                 |  69 ++--
 block/bio-integrity.c                              |  26 --
 block/partitions/aix.c                             |  13 +-
 crypto/ablkcipher.c                                |  57 ++-
 crypto/blkcipher.c                                 |  54 ++-
 crypto/cts.c                                       |   3 +-
 crypto/sha1_generic.c                              |   2 +-
 crypto/sha256_generic.c                            |   5 +-
 crypto/sha512_generic.c                            |   2 +-
 crypto/tgr192.c                                    |   4 +-
 crypto/vmac.c                                      | 412 +++++++++--------=
----
 crypto/wp512.c                                     |   8 +-
 drivers/acpi/bus.c                                 |  13 +-
 drivers/base/power/main.c                          |   5 +-
 drivers/block/nbd.c                                |   3 +
 drivers/cdrom/cdrom.c                              |   2 +-
 drivers/char/ipmi/ipmi_bt_sm.c                     |  92 ++---
 drivers/crypto/mxs-dcp.c                           |  53 +--
 drivers/edac/edac_mc_sysfs.c                       |   6 +-
 drivers/edac/i7core_edac.c                         |  24 +-
 drivers/gpu/drm/drm_fb_helper.c                    |  91 ++---
 drivers/gpu/drm/i915/i915_reg.h                    |   1 +
 drivers/gpu/drm/i915/intel_ddi.c                   |   4 +
 drivers/gpu/drm/i915/intel_display.c               |   8 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c        |  20 +-
 drivers/gpu/drm/panel/panel-s6e8aa0.c              |   2 +-
 drivers/gpu/drm/udl/udl_fb.c                       |  10 +-
 drivers/gpu/drm/udl/udl_main.c                     |  35 +-
 drivers/hv/connection.c                            |   8 +-
 drivers/hwmon/nct6775.c                            |  28 +-
 drivers/i2c/busses/i2c-xiic.c                      |   4 +
 drivers/iio/frequency/ad9523.c                     |   4 +-
 drivers/infiniband/core/cma.c                      |  12 +-
 drivers/infiniband/core/ucm.c                      |   3 +
 drivers/infiniband/core/ucma.c                     |   9 +
 drivers/infiniband/hw/cxgb4/ev.c                   |   1 +
 drivers/infiniband/hw/cxgb4/qp.c                   |  62 +++-
 drivers/infiniband/hw/cxgb4/t4.h                   |  11 +
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   2 +
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |   1 +
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   6 +-
 drivers/infiniband/ulp/srpt/ib_srpt.h              |   4 +-
 drivers/input/mouse/elantech.c                     |   2 +
 drivers/leds/leds-max8997.c                        |   2 +-
 drivers/md/bcache/bcache.h                         |   1 +
 drivers/md/bcache/closure.h                        |   3 -
 drivers/md/bcache/io.c                             |   1 +
 drivers/md/bcache/journal.c                        |   8 +-
 drivers/md/bcache/request.c                        |  14 +-
 drivers/md/bcache/super.c                          |  29 +-
 drivers/md/dm-cache-metadata.c                     |   3 +-
 drivers/md/dm-cache-target.c                       |   5 +-
 drivers/md/dm-crypt.c                              |   8 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.c |  11 +-
 drivers/media/platform/omap3isp/isp.c              |   2 +-
 drivers/media/usb/dvb-usb-v2/gl861.c               |  17 +-
 drivers/media/usb/dvb-usb-v2/rtl28xxu.c            |   2 +-
 drivers/mfd/sm501.c                                |   1 +
 drivers/misc/hmc6352.c                             |   2 +
 drivers/misc/mei/nfc.c                             |   2 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c            |   4 +-
 drivers/mtd/mtdchar.c                              |  10 +-
 drivers/mtd/nand/mxc_nand.c                        |   4 +-
 drivers/mtd/spi-nor/fsl-quadspi.c                  |  20 +-
 drivers/net/ethernet/cadence/macb.c                |  10 +-
 drivers/net/ethernet/marvell/mvneta.c              |   1 -
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h        |   8 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |   3 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h    |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h     |   3 +-
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c     |  12 +-
 drivers/net/ethernet/realtek/r8169.c               |   8 +-
 drivers/net/ppp/pppoe.c                            |   3 +
 drivers/net/team/team.c                            |   5 +
 drivers/net/usb/asix_common.c                      |   3 +
 drivers/net/usb/ax88179_178a.c                     |   3 +
 drivers/net/usb/r8152.c                            |   3 +
 drivers/net/usb/smsc75xx.c                         |   3 +
 drivers/net/usb/smsc95xx.c                         |   3 +
 drivers/net/usb/sr9800.c                           |   3 +
 drivers/net/vxlan.c                                | 103 ++++--
 drivers/net/wireless/ath/ath10k/mac.c              |   7 +
 drivers/net/wireless/ath/wil6210/wmi.c             |   7 +-
 drivers/net/wireless/b43/leds.c                    |   2 +-
 drivers/net/wireless/b43legacy/leds.c              |   2 +-
 drivers/net/wireless/libertas/dev.h                |   1 +
 drivers/net/wireless/libertas/if_sdio.c            |  34 +-
 drivers/net/wireless/rndis_wlan.c                  |   2 +
 drivers/net/xen-netfront.c                         |   6 +-
 drivers/of/selftest.c                              |  28 +-
 drivers/pci/host/pci-mvebu.c                       |   2 +-
 drivers/pci/hotplug/pci_hotplug_core.c             |   9 +
 drivers/pci/hotplug/pciehp.h                       |   1 +
 drivers/pci/hotplug/pciehp_core.c                  |   5 +
 drivers/pci/hotplug/pciehp_hpc.c                   |  18 +-
 drivers/pci/pci.c                                  |  27 +-
 drivers/pinctrl/berlin/berlin.c                    |  13 +-
 drivers/pinctrl/pinctrl-imx.c                      |   2 +-
 drivers/pinctrl/pinctrl-imx1-core.c                |   2 +-
 drivers/pinctrl/pinctrl-msm.c                      |  10 +-
 drivers/platform/x86/alienware-wmi.c               |   1 +
 drivers/platform/x86/ideapad-laptop.c              |   7 +
 drivers/power/generic-adc-battery.c                |  25 +-
 drivers/ptp/ptp_chardev.c                          |   4 +
 drivers/pwm/pwm-tiehrpwm.c                         |  13 +-
 drivers/regulator/core.c                           |   3 +-
 drivers/s390/cio/qdio_main.c                       |   5 +-
 drivers/scsi/aic94xx/aic94xx_init.c                |   4 +-
 drivers/scsi/scsi_sysfs.c                          |  20 +-
 drivers/scsi/virtio_scsi.c                         |   6 +-
 drivers/spi/spi-rspi.c                             | 140 +++++--
 drivers/spi/spi-sh-msiof.c                         |  57 ++-
 drivers/spi/spi-tegra20-slink.c                    |  31 +-
 drivers/staging/rts5208/sd.c                       |   2 +-
 drivers/staging/usbip/vhci_hcd.c                   |  43 ++-
 drivers/target/iscsi/iscsi_target_login.c          |  35 +-
 drivers/target/iscsi/iscsi_target_tpg.c            |   3 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        |  10 +-
 drivers/tty/serial/pxa.c                           |   3 +-
 drivers/tty/serial/serial_core.c                   |  17 +-
 drivers/tty/tty_ioctl.c                            |  15 +-
 drivers/tty/vt/vt_ioctl.c                          |   4 +
 drivers/uio/uio.c                                  |   3 +-
 drivers/usb/core/devio.c                           |  24 +-
 drivers/usb/core/driver.c                          |  50 +--
 drivers/usb/core/hcd-pci.c                         |   2 -
 drivers/usb/core/message.c                         |  11 +
 drivers/usb/core/quirks.c                          |   7 +
 drivers/usb/core/usb.c                             |   2 +
 drivers/usb/gadget/f_mass_storage.c                |   3 +
 drivers/usb/gadget/net2280.c                       |  36 +-
 drivers/usb/host/u132-hcd.c                        |   2 +-
 drivers/usb/host/xhci-pci.c                        |   2 +
 drivers/usb/misc/uss720.c                          |   4 +-
 drivers/usb/misc/yurex.c                           |   5 +-
 drivers/usb/serial/io_ti.h                         |   2 +-
 drivers/usb/serial/kobil_sct.c                     |  12 +-
 drivers/usb/serial/sierra.c                        |   4 +-
 drivers/usb/serial/ti_usb_3410_5052.c              |  13 +-
 drivers/usb/serial/ti_usb_3410_5052.h              |   2 -
 drivers/usb/serial/usb-serial-simple.c             |   3 +-
 drivers/usb/storage/scsiglue.c                     |   9 +
 drivers/usb/storage/uas.c                          |  20 +
 drivers/usb/storage/unusual_devs.h                 |   7 +
 drivers/video/fbdev/aty/atyfb.h                    |   3 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   7 +-
 drivers/video/fbdev/aty/mach64_ct.c                |  10 +-
 drivers/video/fbdev/core/fbmem.c                   |  38 +-
 drivers/video/fbdev/omap/omapfb_main.c             |   2 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c    |   5 +-
 drivers/video/fbdev/udlfb.c                        | 140 ++++---
 fs/9p/xattr.c                                      |   6 +-
 fs/binfmt_elf.c                                    |   2 +-
 fs/btrfs/disk-io.c                                 |  10 +-
 fs/btrfs/inode.c                                   |  25 --
 fs/btrfs/super.c                                   |   1 -
 fs/btrfs/volumes.c                                 |  10 +-
 fs/cachefiles/namei.c                              |   2 +-
 fs/cifs/cifs_debug.c                               |  30 +-
 fs/cifs/cifsfs.c                                   |  20 +-
 fs/cifs/connect.c                                  |   9 +-
 fs/cifs/inode.c                                    |   2 +
 fs/cifs/readdir.c                                  |  11 +-
 fs/cifs/sess.c                                     |   6 +
 fs/cifs/smb2ops.c                                  |  23 +-
 fs/cifs/smb2pdu.c                                  |  40 +-
 fs/cifs/smb2pdu.h                                  |  11 +
 fs/ext4/dir.c                                      |  20 +-
 fs/ext4/inline.c                                   |   4 +-
 fs/ext4/mballoc.c                                  |   4 +-
 fs/ext4/mmp.c                                      |   1 -
 fs/ext4/namei.c                                    |   6 +
 fs/ext4/resize.c                                   |  45 ++-
 fs/ext4/xattr.c                                    |   2 +
 fs/fuse/cuse.c                                     |   2 +-
 fs/fuse/dev.c                                      |   7 +-
 fs/fuse/file.c                                     |   1 +
 fs/fuse/fuse_i.h                                   |   2 -
 fs/fuse/inode.c                                    |  37 +-
 fs/ocfs2/buffer_head_io.c                          |   1 +
 fs/ocfs2/dlm/dlmmaster.c                           |   4 +-
 fs/proc/base.c                                     |  14 +
 fs/pstore/ram.c                                    |  29 +-
 fs/pstore/ram_core.c                               |  17 +-
 fs/quota/quota.c                                   |   5 +-
 fs/reiserfs/xattr.c                                |   6 +-
 fs/seq_file.c                                      |   7 +-
 fs/sysfs/file.c                                    |  44 +++
 fs/ubifs/journal.c                                 |  16 +-
 fs/ubifs/lprops.c                                  |   8 +-
 fs/ubifs/super.c                                   |   3 +
 fs/xattr.c                                         |   2 +-
 fs/xfs/xfs_attr.c                                  |   9 +-
 include/crypto/vmac.h                              |  63 ----
 include/linux/blkdev.h                             |  38 ++
 include/linux/cpuidle.h                            |   3 +
 include/linux/netdevice.h                          |   7 +
 include/linux/percpu_counter.h                     |  13 +-
 include/linux/posix-timers.h                       |   4 +-
 include/linux/seq_file.h                           |  13 +-
 include/linux/skbuff.h                             |   5 +
 include/linux/sysfs.h                              |  14 +
 include/linux/usb.h                                |   2 +-
 include/net/ip_fib.h                               |   1 +
 include/net/netfilter/nf_tables.h                  |   4 +-
 include/video/udlfb.h                              |   5 +-
 kernel/auditsc.c                                   |   8 +-
 kernel/events/core.c                               |  15 +-
 kernel/kprobes.c                                   |   4 +-
 kernel/posix-cpu-timers.c                          |   2 +-
 kernel/posix-timers.c                              |  31 +-
 kernel/sched/idle.c                                |   2 +-
 kernel/time/alarmtimer.c                           |   3 +-
 kernel/trace/blktrace.c                            |   4 +
 kernel/trace/ring_buffer.c                         |   2 +
 kernel/trace/trace.c                               |   4 +-
 kernel/trace/trace_uprobe.c                        |   2 +-
 lib/percpu_counter.c                               |   6 +-
 mm/huge_memory.c                                   |   6 +-
 mm/madvise.c                                       |   2 +-
 mm/memory.c                                        |  15 +-
 mm/mremap.c                                        |  21 +-
 mm/shmem.c                                         |   2 +
 mm/truncate.c                                      |   8 +-
 mm/vmstat.c                                        |   3 +
 net/9p/client.c                                    |   2 +-
 net/9p/trans_fd.c                                  |   7 +-
 net/9p/trans_rdma.c                                |   3 +
 net/9p/trans_virtio.c                              |  13 +-
 net/batman-adv/gateway_client.c                    |  11 +-
 net/batman-adv/main.c                              |   8 +-
 net/batman-adv/network-coding.c                    |  34 +-
 net/batman-adv/soft-interface.c                    |  27 +-
 net/batman-adv/translation-table.c                 |   6 +-
 net/core/dev.c                                     |  28 +-
 net/core/rtnetlink.c                               |   6 +
 net/core/skbuff.c                                  |  12 +-
 net/ieee802154/6lowpan_rtnl.c                      | 140 +++++--
 net/ipv4/fib_frontend.c                            |   4 +
 net/ipv4/fib_semantics.c                           |  50 +++
 net/ipv4/igmp.c                                    |   8 +-
 net/ipv4/ip_tunnel.c                               |   9 +
 net/ipv6/addrconf.c                                |   6 +-
 net/ipv6/af_inet6.c                                |   4 +-
 net/ipv6/ip6_output.c                              |   3 +-
 net/ipv6/ip6_tunnel.c                              |  13 +-
 net/ipv6/raw.c                                     |  34 +-
 net/ipv6/xfrm6_output.c                            |   2 +
 net/l2tp/l2tp_core.c                               |   2 +-
 net/mac80211/cfg.c                                 |   2 +-
 net/mac802154/tx.c                                 |  35 +-
 net/netfilter/nf_tables_api.c                      |  10 +-
 net/netfilter/nft_hash.c                           |   2 +-
 net/netfilter/nft_rbtree.c                         |   2 +-
 net/sched/act_ipt.c                                |   2 +-
 net/wireless/nl80211.c                             |   1 +
 net/wireless/reg.c                                 |   1 +
 net/xfrm/xfrm_policy.c                             |   5 +-
 net/xfrm/xfrm_user.c                               |  12 +
 security/apparmor/policy_unpack.c                  |  32 --
 security/keys/encrypted-keys/encrypted.c           |  31 +-
 sound/aoa/core/gpio-feature.c                      |   4 +-
 sound/core/memalloc.c                              |   8 +-
 sound/core/seq/oss/seq_oss.c                       |   2 +-
 sound/core/seq/seq_clientmgr.c                     |   2 +-
 sound/core/seq/seq_virmidi.c                       |  10 +
 sound/drivers/vx/vx_pcm.c                          |   6 +-
 sound/firewire/bebob/bebob_maudio.c                |  24 +-
 sound/pci/cs5535audio/cs5535audio.h                |   6 +-
 sound/pci/cs5535audio/cs5535audio_pcm.c            |   4 +-
 sound/pci/emu10k1/emufx.c                          |   2 +-
 sound/pci/vx222/vx222_ops.c                        |  20 +-
 sound/pcmcia/vx/vxp_ops.c                          |  22 +-
 sound/soc/codecs/wm8994.c                          |   1 +
 tools/hv/hv_fcopy_daemon.c                         |   1 +
 tools/hv/hv_kvp_daemon.c                           |   2 +-
 320 files changed, 3009 insertions(+), 1647 deletions(-)

Aaron Knister (1):
      IB/ipoib: Avoid a race condition between start_xmit and cm_rep_handler

Aaron Ma (1):
      Input: elantech - enable middle button of touchpad on ThinkPad P72

Akihiro Tsukada (1):
      media: dvb-usb-v2/gl861: ensure USB message buffers DMA'able

Al Viro (1):
      cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)

Alan Stern (6):
      USB: net2280: Fix erroneous synchronization change
      USB: leave LPM alone if possible when binding/unbinding interface dri=
vers
      USB: remove LPM management from usb_driver_claim_interface()
      USB: fix error handling in usb_driver_claim_interface()
      USB: handle NULL config in usb_find_alt_setting()
      USB: fix the usbfs flag sanitization for control transfers

Alexander Aring (4):
      net: 6lowpan: fix reserved space for single frames
      mac802154: tx: cleanup crc calculation
      mac802154: tx: use put_unaligned_le16 for copy crc
      net: mac802154: tx: expand tailroom if necessary

Anand Jain (1):
      btrfs: rename total_bytes to avoid confusion

Andi Kleen (2):
      x86/spectre: Add missing family 6 check to microcode check
      x86/speculation/l1tf: Increase l1tf memory limit for Nehalem+

Andrei Otcheretianski (1):
      cfg80211: reg: Init wiphy_idx in regulatory_hint_core()

Andrey Ryabinin (1):
      fuse: Don't access pipe->buffers without pipe_lock()

Andy Lutomirski (1):
      x86/vdso: Fix asm constraints on vDSO syscall fallbacks

Anssi Hannula (1):
      net: macb: do not disable MDIO bus at open/close time

Arunk Khandavalli (1):
      cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Ashish Samant (1):
      ocfs2: fix locking for res->tracking and dlm->tracking_list

Ashok Raj (1):
      x86/microcode/intel: Check microcode revision before updating sibling=
 threads

Aurelien Aptel (1):
      smb2: fix missing files in root share directory listing

Bart Van Assche (4):
      IB/srpt: Support HCAs with more than two ports
      scsi: target/iscsi: Make iscsit_ta_authentication() respect the outpu=
t buffer size
      scsi: sysfs: Introduce sysfs_{un,}break_active_protection()
      scsi: core: Avoid that SCSI device removal through sysfs triggers a d=
eadlock

Ben Hutchings (2):
      USB: yurex: Fix buffer over-read in yurex_write()
      Linux 3.16.62

Benjamin Herrenschmidt (1):
      powerpc/powernv/pci: Work around races in PCI bridge enabling

Bhaktipriya Shridhar (1):
      bcache: Remove deprecated create_workqueue

Bin Yang (1):
      pstore: Fix incorrect persistent ram buffer mapping

Boris Ostrovsky (1):
      x86/EISA: Don't probe EISA bus for Xen PV guests

Borislav Petkov (1):
      x86/microcode/intel: Add a helper which gives the microcode revision

Catalin Marinas (1):
      cpuidle: Do not access cpuidle_devices when !CONFIG_CPU_IDLE

Chirantan Ekbote (1):
      9p/net: Fix zero-copy path in the 9p virtio transport

Christian Brauner (1):
      getxattr: use correct xattr length

Christophe JAILLET (1):
      serial: pxa: Fix an error handling path in 'serial_pxa_probe()'

Christophe Leroy (1):
      serial: cpm_uart: return immediately from console poll

Claudio Imbrenda (1):
      s390/kvm: fix deadlock when killed by oom

Colin Ian King (2):
      leds: max8997: use mode when calling max8997_led_set_mode
      staging: rts5208: fix missing error check on call to rtsx_write_regis=
ter

Corey Minyard (1):
      ipmi: Move BT capabilities detection to the detect call

Dan Carpenter (16):
      rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()
      vmci: type promotion bug in qp_host_get_user_memory()
      drm/panel: type promotion bug in s6e8aa0_read_mtp_id()
      mei: bus: type promotion bug in mei_nfc_if_version()
      fbdev: omapfb: off by one in omapfb_register_client()
      pinctrl: imx: off by one in imx_pinconf_group_dbg_show()
      pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()
      uio: potential double frees if __uio_register_device() fails
      scsi: aic94xx: fix an error code in aic94xx_init()
      powerpc: Fix size calculation using resource_size()
      hwmon: (nct6775) Set weight source to zero correctly
      cifs: prevent integer overflow in nxt_dir_entry()
      CIFS: fix wrapping bugs in num_entries()
      cifs: integer overflow in in SMB2_ioctl()
      x86/paravirt: Fix some warning messages
      net: sched: act_ipt: check for underflow in __tcf_ipt_init()

Daniel Black (1):
      mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Daniel Borkmann (2):
      crypto: memzero_explicit - make sure to clear out sensitive data
      bpf, net: add skb_mac_header_len helper

Daniel Drake (1):
      PCI: Reprogram bridge prefetch registers on resume

Daniel Mack (2):
      libertas: fix suspend and resume for SDIO connected cards
      libertas: call into generic suspend code before turning off power

Darrick J. Wong (1):
      xfs: don't fail when converting shortform attr to long form during AT=
TR_REPLACE

Dave Chinner (1):
      percpu_counter: batch size aware __percpu_counter_compare()

Dave Martin (1):
      arm64: KVM: Tighten guest core register access from userspace

David Ahern (1):
      net/ipv6: Fix index counter for unicast addresses in in6_dump_addrs

Denis Drozdov (1):
      IB/IPoIB: Set ah valid flag in multicast send flow

Dexuan Cui (1):
      Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()

Douglas Anderson (1):
      pinctrl: msm: Fix msm_config_group_get() to be compliant

Emil Lundmark (1):
      drm: udl: Destroy framebuffer only if it was initialized

Eric Biggers (5):
      crypto: vmac - require a block cipher with 128-bit block size
      crypto: vmac - separate tfm and request context
      crypto: blkcipher - fix crash flushing dcache in error path
      crypto: ablkcipher - fix crash flushing dcache in error path
      KEYS: encrypted: fix buffer overread in valid_master_desc()

Eric Dumazet (3):
      ipv6: fix possible use-after-free in ip6_xmit()
      rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096
      net: make skb_partial_csum_set() more robust against overflows

Eric W. Biederman (1):
      ipv6: Compute net once in raw6_send_hdrinc

Ethan Lien (1):
      btrfs: use correct compare function of dirty_metadata_bytes

Eugeniy Paltsev (1):
      drm: fb-helper: Reject all pixel format changing requests

Evgenii Lepikhin (1):
      ISCSI: fix minor memory leak

Felipe Balbi (1):
      usb: gadget: udc: net2280: do not rely on 'driver' argument

Felix Fietkau (1):
      mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Filippo Sironi (1):
      x86/microcode: Update the new microcode revision unconditionally

Florian Fainelli (6):
      asix: Check for supported Wake-on-LAN modes
      ax88179_178a: Check for supported Wake-on-LAN modes
      sr9800: Check for supported Wake-on-LAN modes
      r8152: Check for supported Wake-on-LAN Modes
      smsc75xx: Check for Wake-on-LAN modes
      smsc95xx: Check for Wake-on-LAN modes

Florian Schmaus (1):
      bcache: do not assign in if condition in bcache_init()

Florian Westphal (1):
      netfilter: nf_tables: fix register ordering

Geert Uytterhoeven (5):
      spi: sh-msiof: Add more register documentation
      spi: rspi: Fix invalid SPI use during system suspend
      spi: rspi: Handle dmaengine_prep_slave_sg() failures gracefully
      spi: rspi: Fix leaking of unused DMA descriptors
      spi: rspi: Fix interrupted DMA transfers

Greg Edwards (2):
      block: move bio_integrity_{intervals,bytes} into blkdev.h
      scsi: virtio_scsi: fix pi_bytes{out,in} on 4 KiB block size devices

Greg Hackmann (1):
      arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Guenter Roeck (3):
      mfd: sm501: Set coherent_dma_mask when creating subdevices
      hwmon: (nct6775) Fix access to fan pulse registers
      of: unittest: Disable interrupt node tests for old world MAC systems

Guillaume Nault (1):
      pppoe: fix reception of frames with no mac header

Guoju Fang (1):
      bcache: add separate workqueue for journal_write to avoid deadlock

Gustavo A. R. Silva (9):
      ASoC: wm8994: Mark expected switch fall-through
      ASoC: wm8994: Fix missing break in switch
      hwmon: (nct6775) Fix potential Spectre v1
      misc: hmc6352: fix potential Spectre v1
      tty: vt_ioctl: fix potential Spectre v1
      IB/ucm: Fix Spectre v1 vulnerability
      RDMA/ucma: Fix Spectre v1 vulnerability
      usb: gadget: storage: Fix Spectre v1 vulnerability
      ptp: fix Spectre v1 vulnerability

H. Nikolaus Schaller (2):
      power: generic-adc-battery: fix out-of-bounds write when copying chan=
nel properties
      power: generic-adc-battery: check for duplicate properties copied fro=
m iio channels

Haishuang Yan (1):
      vxlan: fix a potential issue when create a new vxlan fdb entry.

Han Xu (1):
      mtd: fsl-quadspi: fix macro collision problems with READ/WRITE

Hangbin Liu (2):
      igmp: fix incorrect unsolicit report count when join group
      igmp: fix incorrect unsolicit report count after link down and up

Hari Bathini (1):
      powerpc/fadump: handle crash memory ranges array index overflow

Heiner Kallweit (1):
      r8169: fix NAPI handling under high load

Hiromitsu Yamasaki (1):
      spi: sh-msiof: Fix handling of write value for SISTR register

Huacai Chen (1):
      MIPS: Change definition of cpu_relax() for Loongson-3

Ido Schimmel (1):
      team: Forbid enslaving team device to itself

Imre Deak (1):
      drm/i915/bdw: Increase IPS disable timeout to 100ms

Jani Nikula (1):
      drm/i915: set DP Main Stream Attribute for color range on DDI platfor=
ms

Jann Horn (6):
      mtdchar: fix overflows in adjustment of `count`
      reiserfs: fix broken xattr handling (heap corruption, bad retval)
      RDMA/ucma: check fd type in ucma_migrate_id()
      x86/process: Don't mix user/kernel regs in 64bit __show_regs()
      proc: restrict kernel stack dumps to root
      mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly

Javier Martinez Canillas (1):
      media: omap3isp: zero-initialize the isp cam_xclk{a,b} initial data

Jean Delvare (1):
      ACPI / bus: Only call dmi_check_system() on X86

Jens Axboe (2):
      nbd: don't allow invalid blocksize settings
      bcache: don't embed 'return' statements in closure macros

Jeremy Cline (2):
      ext4: fix spectre gadget in ext4_mb_regular_allocator()
      fs/quota: Fix spectre gadget in do_quotactl

Jia-Ju Bai (2):
      usb: host: u132-hcd: Fix a sleep-in-atomic-context bug in u132_get_fr=
ame()
      usb: misc: uss720: Fix two sleep-in-atomic-context bugs

Jiri Olsa (2):
      perf/core: Protect PMU device removal with a 'pmu_bus_running' check,=
 to fix CONFIG_DEBUG_TEST_DRIVER_REMOVE=3Dy kernel panic
      perf/ring_buffer: Prevent concurent ring buffer access

Joel Fernandes (Google) (1):
      mm: shmem.c: Correctly annotate new inodes for lockdep

Johan Hovold (8):
      EDAC: Fix memleak in module init error path
      EDAC, i7core: Fix memleaks and use-after-free on probe and remove
      USB: serial: kobil_sct: fix modem-status error handling
      tty: fix termios input-speed encoding
      tty: fix termios input-speed encoding when using BOTHER
      USB: serial: io_ti: fix array underflow in completion handler
      USB: serial: ti_usb_3410_5052: fix array underflow in completion hand=
ler
      USB: serial: simple: add Motorola Tetra MTP6550 id

John Johansen (1):
      apparmor: remove no-op permission check in policy_unpack

John Ogness (1):
      USB: serial: sierra: fix potential deadlock at close

Jon Hunter (1):
      ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Josef Bacik (1):
      Btrfs: fix btrfs_write_inode vs delayed iput deadlock

Julian Wiedmann (1):
      s390/qdio: reset old sbal_state flags

Junxiao Bi (1):
      ocfs2: fix ocfs2 read block panic

K. Y. Srinivasan (1):
      Tools: hv: Fix a bug in the key delete code

Kees Cook (1):
      pstore/ram: Fix failure-path memory leak in ramoops_init

Kirill Tkhai (1):
      fuse: Add missed unlock_page() to fuse_readpages_fill()

Ladislav Michl (2):
      video: udlfb: Remove noisy warnings
      video: udlfb: Fix unaligned access

Lars-Peter Clausen (2):
      iio: ad9523: Fix displayed phase
      iio: ad9523: Fix return value for ad952x_store()

Leonard Crestez (1):
      crypto: mxs-dcp - Fix wait logic on chan threads

Li Dongyang (1):
      ext4: don't mark mmp buffer head dirty

Liang Chen (1):
      bcache: explicitly destroy mutex while exiting

Linus Torvalds (2):
      Make file credentials available to the seqfile interfaces
      mremap: properly flush TLB before releasing the page

Lior David (1):
      wil6210: missing length check in wmi_set_ie

Lukas Wunner (3):
      PCI: hotplug: Don't leak pci_slot on registration failure
      PCI: pciehp: Fix use-after-free on unplug
      PCI: pciehp: Fix unprotected list iteration in IRQ handler

Lyude Paul (1):
      drm/nouveau/drm/nouveau: Use pm_runtime_get_noresume() in connector_d=
etect()

Maciej W. Rozycki (3):
      binfmt_elf: Respect error return from `regset->active'
      MIPS: Correct the 64-bit DSP accumulator register size
      MIPS: memset: Fix CPU_DADDI_WORKAROUNDS `small_fixup' regression

Mahesh Salgaonkar (2):
      powerpc/pseries: Avoid using the size greater than RTAS_ERROR_LOG_MAX.
      powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Marcel Ziswiler (1):
      spi: tegra20-slink: explicitly enable/disable clock

Mario Limonciello (1):
      platform/x86: alienware-wmi: Correct a memory leak

Martin Kaiser (1):
      mtd: rawnand: mxc: remove __init qualifier from mxcnd_probe_dt

Masami Hiramatsu (1):
      kprobes: Make list and blacklist root user read only

Mathias Nyman (3):
      usb: Don't die twice if PCI xhci host is not responding in resume
      usb: Avoid use-after-free by flushing endpoints early in usb_set_inte=
rface()
      xhci: Add missing CAS workaround for Intel Sunrise Point xHCI

Mathieu OTHACEHE (1):
      USB: serial: ti_usb_3410_5052: use functions rather than macros

Matthias Brugger (1):
      tty: fix typo in comment of tty_termios_encode_baud_rate

Mauricio Faria de Oliveira (2):
      partitions/aix: fix usage of uninitialized lv_info and lvname structu=
res
      partitions/aix: append null character to print data from disk

Mauro Carvalho Chehab (1):
      media: rtl28xxu: be sure that it won't go past the array size

Max Filippov (2):
      xtensa: limit offsets in __loop_cache_{all,page}
      xtensa: increase ranges in ___invalidate_{i,d}cache_all

Maxence Dupr=C3=A8s (1):
      USB: add quirk for WORLDE Controller KS49 or Prodipe MIDI 49C USB con=
troller

Mian Yousaf Kaukab (1):
      usb: gadget: net2280: fix pullup handling

Michael Bringmann (1):
      powerpc/pseries: Fix unitialized timer reset on migration

Michael Buesch (2):
      b43/leds: Ensure NUL-termination of LED name string
      b43legacy/leds: Ensure NUL-termination of LED name string

Mika B=C3=A5tsman (1):
      media: gl861: fix probe of dvb_usb_gl861

Mike Christie (1):
      iscsi target: fix session creation failure handling

Mike Snitzer (1):
      dm cache metadata: save in-core policy_hint_size to on-disk superblock

Miklos Szeredi (3):
      fuse: don't wake up reserved req in fuse_conn_kill()
      fuse: flush requests on umount
      fuse: Fix oops at process_init_reply()

Mikulas Patocka (13):
      fb: fix lost console when the user unplugs a USB adapter
      udlfb: fix semaphore value leak
      udlfb: fix display corruption of the last line
      udlfb: don't switch if we are switching to the same videomode
      udlfb: make a local copy of fb_ops
      udlfb: set optimal write delay
      udlfb: handle allocation failure
      udlfb: set line_length in dlfb_ops_set_par
      udl-kms: change down_interruptible to down
      udl-kms: handle allocation failure
      udl-kms: fix crash due to uninitialized memory
      dm: disable CRYPTO_TFM_REQ_MAY_SLEEP to fix a GFP_KERNEL recursion de=
adlock
      mach64: detect the dot clock divider correctly on sparc

Nadav Amit (1):
      x86/mm: Use WRITE_ONCE() when setting PTEs

Nicholas Mc Guire (3):
      ALSA: snd-aoa: add of_node_put() in error path
      ARM: hisi: handle of_iomap and fix missing of_node_put
      cifs: check kmalloc before use

Nicholas Piggin (1):
      mm: move tlb_table_flush to tlb_flush_mmu_free

Oliver Neukum (3):
      usb: uas: add support for more quirk flags
      USB: usbdevfs: sanitize flags more
      USB: usbdevfs: restore warning for nonsensical flags

Olle Liljenzin (1):
      platform/x86: ideapad-laptop: Add Y520-15IKBN to no_hw_rfkill

Ondrej Mosn=C3=A1=C4=8Dek (1):
      audit: Fix extended comparison of GID/EGID

Paolo Abeni (2):
      ip6_tunnel: be careful when accessing the inner header
      ip_tunnel: be careful when accessing the inner header

Parav Pandit (1):
      RDMA/cma: Protect cma dev list with lock

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Pavel Tikhomirov (1):
      mm: cleancache: fix corruption on missed inode invalidation

Peter Zijlstra (3):
      mm/tlb: Remove tlb_remove_table() non-concurrent condition
      perf/core: Fix perf_pmu_unregister() locking
      x86/percpu: Fix this_cpu_read()

Prarit Bhargava (1):
      x86/microcode: Make sure boot_cpu_data.microcode is up-to-date

Punit Agrawal (2):
      KVM: arm/arm64: Skip updating PMD entry if no change
      KVM: arm/arm64: Skip updating PTE entry if no change

Rafael J. Wysocki (1):
      PM / core: Clear the direct_complete flag on errors

Rian Hunter (1):
      x86/process: Re-export start_thread()

Richard Weinberger (4):
      ubifs: Fix synced_i_size calculation for xattr inodes
      ubifs: Fix memory leak in lprobs self-check
      ubifs: Check data node size before truncate
      ubifs: Check for name being NULL while mounting

Roopa Prabhu (2):
      vxlan: add new fdb alloc and create helpers
      vxlan: fix default fdb entry netlink notify ordering during netdev cr=
eate

Sabrina Dubroca (2):
      ipv6: fix cleanup ordering for pingv6 registration
      net: ipv4: update fnhe_pmtu when first hop's MTU changes

Sagi Grimberg (1):
      iscsi-target: nullify session in failed login sequence

Sebastian Ott (1):
      s390/pci: fix out of bounds access during irq setup

Shahed Shaikh (1):
      qlcnic: fix Tx descriptor corruption on 82xx devices

Shenghui Wang (1):
      dm cache: destroy migration_cache if cache target registration failed

Shuah Khan (Samsung OSG) (1):
      usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()

Shubhrajyoti Datta (1):
      i2c: xiic: Make the start and the byte count write atomic

Simon Vincent (1):
      ieee802154: 6lowpan: ensure header compression does not corrupt ipv6 =
header

Steffen Klassert (1):
      xfrm: Validate address prefix lengths in the xfrm selector.

Steve French (4):
      smb3: fill in statfs fsid and correct namelen
      cifs: add missing debug entries for kconfig options
      SMB3: Backup intent flag missing for directory opens with backupuid m=
ounts
      smb3: check for and properly advertise directory lease support

Steve Wise (3):
      RDMA/cxgb4: Only call CQ completion handler if it is armed
      iw_cxgb4: atomically flush the qp
      iw_cxgb4: only allow 1 flush on user qps

Steven Rostedt (VMware) (3):
      tracing: Do not call start/stop() functions when tracing_on does not =
change
      uprobes: Use synchronize_rcu() not synchronize_sched()
      tracing/blktrace: Fix to allow setting same value

Sven Eckelmann (8):
      ath10k: prevent active scans on potential unusable channels
      batman-adv: Prevent duplicated gateway_node entry
      batman-adv: Use kref_get for batadv_nc_get_nc_node
      batman-adv: Prevent duplicated nc_node entry
      batman-adv: Place kref_get for softif_vlan near use
      batman-adv: Prevent duplicated softif_vlan entry
      batman-adv: Prevent duplicated global TT entry
      batman-adv: Prevent duplicated tvlv handler

Sylwester Nawrocki (1):
      media: exynos4-is: Prevent NULL pointer dereference in __isp_video_tr=
y_fmt()

Taehee Yoo (1):
      netfilter: nft_set: fix allocation size overflow in privsize callback.

Takashi Iwai (9):
      EDAC: i7core: Return proper error codes for kzalloc() errors
      platform/x86: ideapad-laptop: Apply no_hw_rfkill to Y20-15IKBM, too
      ALSA: memalloc: Don't exceed over the requested size
      ALSA: seq: Fix poll() error return
      ALSA: vx: Fix possible transfer overflow
      ALSA: vx222: Fix invalid endian conversions
      ALSA: vxpocket: Fix invalid endian conversions
      ALSA: cs5535audio: Fix invalid endian conversion
      ALSA: virmidi: Fix too long output trigger loop

Takashi Sakamoto (1):
      ALSA: bebob: use address returned by kmalloc() instead of kernel stac=
k for streaming DMA mapping

Thadeu Lima de Souza Cascardo (1):
      xfrm6: call kfree_skb when skb is toobig

Theodore Ts'o (6):
      ext4: check for NUL characters in extended attribute's name
      ext4: check to make sure the rename(2)'s destination is not freed
      ext4: avoid divide by zero fault when deleting corrupted inline direc=
tories
      ext4: fix online resize's handling of a too-small final block group
      ext4: prevent online resize with backup superblock
      ext4: fix online resizing for bigalloc file systems with a 1k block s=
ize

Thomas Gleixner (3):
      alarmtimer: Prevent overflow for relative nanosleep
      x86/boot: Move EISA setup to a separate file
      posix-timers: Sanitize overrun handling

Thomas Petazzoni (2):
      PCI: mvebu: Fix I/O space end address calculation
      ARM: 8799/1: mm: fix pci_ioremap_io() offset check

Thomas Werschlein (1):
      cifs: connect to servername instead of IP for IPC$ share

Tim Anderson (1):
      USB: Add quirk to support DJI CineSSD

Tomas Bortoli (3):
      net/9p/client.c: version pointer uninitialized
      net/9p/trans_fd.c: fix race-condition by flushing workqueue before th=
e kfree()
      9p: fix multiple NULL-pointer-dereferences

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak

Tycho Andersen (1):
      uart: fix race between uart_put_char() and uart_shutdown()

Vaibhav Nagarnaik (1):
      ring-buffer: Allow for rescheduling when removing pages

Varka Bhadram (1):
      mac802154: common tx error path

Vignesh R (2):
      pwm: tiehrpwm: Don't use emulation mode bits to control PWM output
      pwm: tiehrpwm: Fix disabling of output of PWMs

Vineet Gupta (1):
      ARC: clone syscall to setp r25 as thread pointer

Vitaly Kuznetsov (2):
      xen-netfront: fix queue name setting
      tools: hv: fcopy: set 'error' in case an unknown operation was reques=
ted

Wei Wang (2):
      l2tp: use sk_dst_check() to avoid race on sk->sk_dst_cache
      ipv6: take rcu lock in rawv6_send_hdrinc()

Willy Tarreau (1):
      ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_I=
OCTL_INFO

Xiao Liang (1):
      xen-netfront: fix warn message as irq device name has '/'

Yelena Krivosheev (1):
      net: mvneta: fix mtu change on port without link

Young_X (1):
      cdrom: fix improper type cast, which can leat to information leak.

Yu Zhao (1):
      regulator: fix crash caused by null driver data

YueHaibing (2):
      xfrm: fix 'passing zero to ERR_PTR()' warning
      pinctrl: berlin: fix 'pctrl->functions' allocation in berlin_pinctrl_=
build_state

jiangyiwen (1):
      9p/virtio: fix off-by-one error in sg list bounds check

piaojun (1):
      fs/9p/xattr.c: catch the error of p9_client_clunk when setting xattr =
failed


--gwpmnc3xw47uimwk
Content-Type: text/x-diff; charset=UTF-8; name="linux-3.16.62.patch"
Content-Disposition: attachment; filename="linux-3.16.62.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/Makefile b/Makefile
index d544d7e6c26a..e8aa5044ebdd 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION =3D 3
 PATCHLEVEL =3D 16
-SUBLEVEL =3D 61
+SUBLEVEL =3D 62
 EXTRAVERSION =3D
 NAME =3D Museum of Fishiegoodies
=20
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index fdd89715d2d3..168c1d835739 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -147,6 +147,26 @@ int copy_thread(unsigned long clone_flags,
 		task_thread_info(current)->thr_ptr;
 	}
=20
+
+	/*
+	 * setup usermode thread pointer #1:
+	 * when child is picked by scheduler, __switch_to() uses @c_callee to
+	 * populate usermode callee regs: this works (despite being in a kernel
+	 * function) since special return path for child @ret_from_fork()
+	 * ensures those regs are not clobbered all the way to RTIE to usermode
+	 */
+	c_callee->r25 =3D task_thread_info(p)->thr_ptr;
+
+#ifdef CONFIG_ARC_CURR_IN_REG
+	/*
+	 * setup usermode thread pointer #2:
+	 * however for this special use of r25 in kernel, __switch_to() sets
+	 * r25 for kernel needs and only in the final return path is usermode
+	 * r25 setup, from pt_regs->user_r25. So set that up as well
+	 */
+	c_regs->user_r25 =3D c_callee->r25;
+#endif
+
 	return 0;
 }
=20
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegr=
a30-cardhu.dtsi
index 0cf0848a82d8..d47acdb7b068 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -193,6 +193,7 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			reg =3D <0x70>;
+			reset-gpio =3D <&gpio TEGRA_GPIO(BB, 0) GPIO_ACTIVE_LOW>;
 		};
 	};
=20
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1c67debe6dfa..0716459fa1ba 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -685,19 +685,35 @@ static int stage2_set_pmd_huge(struct kvm *kvm, struc=
t kvm_mmu_memory_cache
 	pmd =3D stage2_get_pmd(kvm, cache, addr);
 	VM_BUG_ON(!pmd);
=20
-	/*
-	 * Mapping in huge pages should only happen through a fault.  If a
-	 * page is merged into a transparent huge page, the individual
-	 * subpages of that huge page should be unmapped through MMU
-	 * notifiers before we get here.
-	 *
-	 * Merging of CompoundPages is not supported; they should become
-	 * splitting first, unmapped, merged, and mapped back in on-demand.
-	 */
-	VM_BUG_ON(pmd_present(*pmd) && pmd_pfn(*pmd) !=3D pmd_pfn(*new_pmd));
-
 	old_pmd =3D *pmd;
 	if (pmd_present(old_pmd)) {
+		/*
+		 * Multiple vcpus faulting on the same PMD entry, can
+		 * lead to them sequentially updating the PMD with the
+		 * same value. Following the break-before-make
+		 * (pmd_clear() followed by tlb_flush()) process can
+		 * hinder forward progress due to refaults generated
+		 * on missing translations.
+		 *
+		 * Skip updating the page table if the entry is
+		 * unchanged.
+		 */
+		if (pmd_val(old_pmd) =3D=3D pmd_val(*new_pmd))
+			return 0;
+
+		/*
+		 * Mapping in huge pages should only happen through a
+		 * fault.  If a page is merged into a transparent huge
+		 * page, the individual subpages of that huge page
+		 * should be unmapped through MMU notifiers before we
+		 * get here.
+		 *
+		 * Merging of CompoundPages is not supported; they
+		 * should become splitting first, unmapped, merged,
+		 * and mapped back in on-demand.
+		 */
+		VM_BUG_ON(pmd_pfn(old_pmd) !=3D pmd_pfn(*new_pmd));
+
 		pmd_clear(pmd);
 		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	} else {
@@ -742,6 +758,10 @@ static int stage2_set_pte(struct kvm *kvm, struct kvm_=
mmu_memory_cache *cache,
 	/* Create 2nd stage page table mapping - Level 3 */
 	old_pte =3D *pte;
 	if (pte_present(old_pte)) {
+		/* Skip page table update if there is no change */
+		if (pte_val(old_pte) =3D=3D pte_val(*new_pte))
+			return 0;
+
 		kvm_set_pte(pte, __pte(0));
 		kvm_tlb_flush_vmid_ipa(kvm, addr);
 	} else {
diff --git a/arch/arm/mach-hisi/hotplug.c b/arch/arm/mach-hisi/hotplug.c
index abd441b0c604..885a4fca918d 100644
--- a/arch/arm/mach-hisi/hotplug.c
+++ b/arch/arm/mach-hisi/hotplug.c
@@ -137,13 +137,20 @@ static int hi3xxx_hotplug_init(void)
 	struct device_node *node;
=20
 	node =3D of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
-	if (node) {
-		ctrl_base =3D of_iomap(node, 0);
-		id =3D HI3620_CTRL;
-		return 0;
+	if (!node) {
+		id =3D ERROR_CTRL;
+		return -ENOENT;
 	}
-	id =3D ERROR_CTRL;
-	return -ENOENT;
+
+	ctrl_base =3D of_iomap(node, 0);
+	of_node_put(node);
+	if (!ctrl_base) {
+		id =3D ERROR_CTRL;
+		return -ENOMEM;
+	}
+
+	id =3D HI3620_CTRL;
+	return 0;
 }
=20
 void hi3xxx_set_cpu(int cpu, bool enable)
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index d1e5ad7ab3bc..1500d3befe02 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -447,7 +447,7 @@ void pci_ioremap_set_mem_type(int mem_type)
=20
 int pci_ioremap_io(unsigned int offset, phys_addr_t phys_addr)
 {
-	BUG_ON(offset + SZ_64K > IO_SPACE_LIMIT);
+	BUG_ON(offset + SZ_64K - 1 > IO_SPACE_LIMIT);
=20
 	return ioremap_page_range(PCI_IO_VIRT_BASE + offset,
 				  PCI_IO_VIRT_BASE + offset + SZ_64K,
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 3e610f60f031..10b8838c5ee0 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -46,6 +46,45 @@ static u64 core_reg_offset_from_id(u64 id)
 	return id & ~(KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK | KVM_REG_ARM_CORE);
 }
=20
+static int validate_core_offset(const struct kvm_one_reg *reg)
+{
+	u64 off =3D core_reg_offset_from_id(reg->id);
+	int size;
+
+	switch (off) {
+	case KVM_REG_ARM_CORE_REG(regs.regs[0]) ...
+	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
+	case KVM_REG_ARM_CORE_REG(regs.sp):
+	case KVM_REG_ARM_CORE_REG(regs.pc):
+	case KVM_REG_ARM_CORE_REG(regs.pstate):
+	case KVM_REG_ARM_CORE_REG(sp_el1):
+	case KVM_REG_ARM_CORE_REG(elr_el1):
+	case KVM_REG_ARM_CORE_REG(spsr[0]) ...
+	     KVM_REG_ARM_CORE_REG(spsr[KVM_NR_SPSR - 1]):
+		size =3D sizeof(__u64);
+		break;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]) ...
+	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
+		size =3D sizeof(__uint128_t);
+		break;
+
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
+	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
+		size =3D sizeof(__u32);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (KVM_REG_SIZE(reg->id) =3D=3D size &&
+	    IS_ALIGNED(off, size / sizeof(__u32)))
+		return 0;
+
+	return -EINVAL;
+}
+
 static int get_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *r=
eg)
 {
 	/*
@@ -65,6 +104,9 @@ static int get_core_reg(struct kvm_vcpu *vcpu, const str=
uct kvm_one_reg *reg)
 	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >=3D nr_regs)
 		return -ENOENT;
=20
+	if (validate_core_offset(reg))
+		return -EINVAL;
+
 	if (copy_to_user(uaddr, ((u32 *)regs) + off, KVM_REG_SIZE(reg->id)))
 		return -EFAULT;
=20
@@ -87,6 +129,9 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const str=
uct kvm_one_reg *reg)
 	    (off + (KVM_REG_SIZE(reg->id) / sizeof(__u32))) >=3D nr_regs)
 		return -ENOENT;
=20
+	if (validate_core_offset(reg))
+		return -EINVAL;
+
 	if (KVM_REG_SIZE(reg->id) > sizeof(tmp))
 		return -EINVAL;
=20
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 01bfca35b0aa..c260c06e09a7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -113,7 +113,11 @@ static void __init zone_sizes_init(unsigned long min, =
unsigned long max)
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
-	return memblock_is_memory(pfn << PAGE_SHIFT);
+	phys_addr_t addr =3D pfn << PAGE_SHIFT;
+
+	if ((addr >> PAGE_SHIFT) !=3D pfn)
+		return 0;
+	return memblock_is_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
diff --git a/arch/mips/include/asm/processor.h b/arch/mips/include/asm/proc=
essor.h
index 3a05491b851e..223fa59ed1f2 100644
--- a/arch/mips/include/asm/processor.h
+++ b/arch/mips/include/asm/processor.h
@@ -143,7 +143,7 @@ struct mips_fpu_struct {
=20
 #define NUM_DSP_REGS   6
=20
-typedef __u32 dspreg_t;
+typedef unsigned long dspreg_t;
=20
 struct mips_dsp_state {
 	dspreg_t	dspr[NUM_DSP_REGS];
@@ -366,7 +366,20 @@ unsigned long get_wchan(struct task_struct *p);
 #define KSTK_ESP(tsk) (task_pt_regs(tsk)->regs[29])
 #define KSTK_STATUS(tsk) (task_pt_regs(tsk)->cp0_status)
=20
+#ifdef CONFIG_CPU_LOONGSON3
+/*
+ * Loongson-3's SFB (Store-Fill-Buffer) may buffer writes indefinitely whe=
n a
+ * tight read loop is executed, because reads take priority over writes & =
the
+ * hardware (incorrectly) doesn't ensure that writes will eventually occur.
+ *
+ * Since spin loops of any kind should have a cpu_relax() in them, force a=
n SFB
+ * flush from cpu_relax() such that any pending writes will become visible=
 as
+ * expected.
+ */
+#define cpu_relax()	smp_mb()
+#else
 #define cpu_relax()	barrier()
+#endif
=20
 /*
  * Return_address is a replacement for __builtin_return_address(count)
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 3d5b457be415..e24cf0ad3be3 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -790,7 +790,7 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
 				goto out;
 			}
 			dregs =3D __get_dsp_regs(child);
-			tmp =3D (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp =3D dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:
diff --git a/arch/mips/kernel/ptrace32.c b/arch/mips/kernel/ptrace32.c
index 38d99886300c..755ecdf842de 100644
--- a/arch/mips/kernel/ptrace32.c
+++ b/arch/mips/kernel/ptrace32.c
@@ -140,7 +140,7 @@ long compat_arch_ptrace(struct task_struct *child, comp=
at_long_t request,
 				goto out;
 			}
 			dregs =3D __get_dsp_regs(child);
-			tmp =3D (unsigned long) (dregs[addr - DSP_BASE]);
+			tmp =3D dregs[addr - DSP_BASE];
 			break;
 		}
 		case DSP_CONTROL:
diff --git a/arch/mips/lib/memset.S b/arch/mips/lib/memset.S
index 3d3377ca2b22..2500421a7b17 100644
--- a/arch/mips/lib/memset.S
+++ b/arch/mips/lib/memset.S
@@ -213,9 +213,11 @@
 	 nop
=20
 .Lsmall_fixup\@:
+	.set		reorder
 	PTR_SUBU	a2, t1, a0
+	PTR_ADDIU	a2, 1
 	jr		ra
-	 PTR_ADDIU	a2, 1
+	.set		noreorder
=20
 	.endm
=20
diff --git a/arch/powerpc/include/asm/fadump.h b/arch/powerpc/include/asm/f=
adump.h
index a6774560afe3..1b91b129147f 100644
--- a/arch/powerpc/include/asm/fadump.h
+++ b/arch/powerpc/include/asm/fadump.h
@@ -194,9 +194,6 @@ struct fadump_crash_info_header {
 	struct cpumask	cpu_online_mask;
 };
=20
-/* Crash memory ranges */
-#define INIT_CRASHMEM_RANGES	(INIT_MEMBLOCK_REGIONS + 2)
-
 struct fad_crash_memory_ranges {
 	unsigned long long	base;
 	unsigned long long	size;
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 06b6b312ba89..dcbdb3743136 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -35,6 +35,7 @@
 #include <linux/crash_dump.h>
 #include <linux/kobject.h>
 #include <linux/sysfs.h>
+#include <linux/slab.h>
=20
 #include <asm/page.h>
 #include <asm/prom.h>
@@ -48,8 +49,10 @@ static struct fadump_mem_struct fdm;
 static const struct fadump_mem_struct *fdm_active;
=20
 static DEFINE_MUTEX(fadump_mutex);
-struct fad_crash_memory_ranges crash_memory_ranges[INIT_CRASHMEM_RANGES];
+struct fad_crash_memory_ranges *crash_memory_ranges;
+int crash_memory_ranges_size;
 int crash_mem_ranges;
+int max_crash_mem_ranges;
=20
 /* Scan the Firmware Assisted dump configuration details. */
 int __init early_init_dt_scan_fw_dump(unsigned long node,
@@ -726,38 +729,88 @@ static int __init process_fadump(const struct fadump_=
mem_struct *fdm_active)
 	return 0;
 }
=20
-static inline void fadump_add_crash_memory(unsigned long long base,
-					unsigned long long end)
+static void free_crash_memory_ranges(void)
+{
+	kfree(crash_memory_ranges);
+	crash_memory_ranges =3D NULL;
+	crash_memory_ranges_size =3D 0;
+	max_crash_mem_ranges =3D 0;
+}
+
+/*
+ * Allocate or reallocate crash memory ranges array in incremental units
+ * of PAGE_SIZE.
+ */
+static int allocate_crash_memory_ranges(void)
+{
+	struct fad_crash_memory_ranges *new_array;
+	u64 new_size;
+
+	new_size =3D crash_memory_ranges_size + PAGE_SIZE;
+	pr_debug("Allocating %llu bytes of memory for crash memory ranges\n",
+		 new_size);
+
+	new_array =3D krealloc(crash_memory_ranges, new_size, GFP_KERNEL);
+	if (new_array =3D=3D NULL) {
+		pr_err("Insufficient memory for setting up crash memory ranges\n");
+		free_crash_memory_ranges();
+		return -ENOMEM;
+	}
+
+	crash_memory_ranges =3D new_array;
+	crash_memory_ranges_size =3D new_size;
+	max_crash_mem_ranges =3D (new_size /
+				sizeof(struct fad_crash_memory_ranges));
+	return 0;
+}
+
+static inline int fadump_add_crash_memory(unsigned long long base,
+					  unsigned long long end)
 {
 	if (base =3D=3D end)
-		return;
+		return 0;
+
+	if (crash_mem_ranges =3D=3D max_crash_mem_ranges) {
+		int ret;
+
+		ret =3D allocate_crash_memory_ranges();
+		if (ret)
+			return ret;
+	}
=20
 	pr_debug("crash_memory_range[%d] [%#016llx-%#016llx], %#llx bytes\n",
 		crash_mem_ranges, base, end - 1, (end - base));
 	crash_memory_ranges[crash_mem_ranges].base =3D base;
 	crash_memory_ranges[crash_mem_ranges].size =3D end - base;
 	crash_mem_ranges++;
+	return 0;
 }
=20
-static void fadump_exclude_reserved_area(unsigned long long start,
+static int fadump_exclude_reserved_area(unsigned long long start,
 					unsigned long long end)
 {
 	unsigned long long ra_start, ra_end;
+	int ret =3D 0;
=20
 	ra_start =3D fw_dump.reserve_dump_area_start;
 	ra_end =3D ra_start + fw_dump.reserve_dump_area_size;
=20
 	if ((ra_start < end) && (ra_end > start)) {
 		if ((start < ra_start) && (end > ra_end)) {
-			fadump_add_crash_memory(start, ra_start);
-			fadump_add_crash_memory(ra_end, end);
+			ret =3D fadump_add_crash_memory(start, ra_start);
+			if (ret)
+				return ret;
+
+			ret =3D fadump_add_crash_memory(ra_end, end);
 		} else if (start < ra_start) {
-			fadump_add_crash_memory(start, ra_start);
+			ret =3D fadump_add_crash_memory(start, ra_start);
 		} else if (ra_end < end) {
-			fadump_add_crash_memory(ra_end, end);
+			ret =3D fadump_add_crash_memory(ra_end, end);
 		}
 	} else
-		fadump_add_crash_memory(start, end);
+		ret =3D fadump_add_crash_memory(start, end);
+
+	return ret;
 }
=20
 static int fadump_init_elfcore_header(char *bufp)
@@ -793,10 +846,11 @@ static int fadump_init_elfcore_header(char *bufp)
  * Traverse through memblock structure and setup crash memory ranges. These
  * ranges will be used create PT_LOAD program headers in elfcore header.
  */
-static void fadump_setup_crash_memory_ranges(void)
+static int fadump_setup_crash_memory_ranges(void)
 {
 	struct memblock_region *reg;
 	unsigned long long start, end;
+	int ret;
=20
 	pr_debug("Setup crash memory ranges.\n");
 	crash_mem_ranges =3D 0;
@@ -807,7 +861,9 @@ static void fadump_setup_crash_memory_ranges(void)
 	 * specified during fadump registration. We need to create a separate
 	 * program header for this chunk with the correct offset.
 	 */
-	fadump_add_crash_memory(RMA_START, fw_dump.boot_memory_size);
+	ret =3D fadump_add_crash_memory(RMA_START, fw_dump.boot_memory_size);
+	if (ret)
+		return ret;
=20
 	for_each_memblock(memory, reg) {
 		start =3D (unsigned long long)reg->base;
@@ -816,8 +872,12 @@ static void fadump_setup_crash_memory_ranges(void)
 			start =3D fw_dump.boot_memory_size;
=20
 		/* add this range excluding the reserved dump area. */
-		fadump_exclude_reserved_area(start, end);
+		ret =3D fadump_exclude_reserved_area(start, end);
+		if (ret)
+			return ret;
 	}
+
+	return 0;
 }
=20
 /*
@@ -941,6 +1001,7 @@ static void register_fadump(void)
 {
 	unsigned long addr;
 	void *vaddr;
+	int ret;
=20
 	/*
 	 * If no memory is reserved then we can not register for firmware-
@@ -949,7 +1010,9 @@ static void register_fadump(void)
 	if (!fw_dump.reserve_dump_area_size)
 		return;
=20
-	fadump_setup_crash_memory_ranges();
+	ret =3D fadump_setup_crash_memory_ranges();
+	if (ret)
+		return;
=20
 	addr =3D fdm.rmr_region.destination_address + fdm.rmr_region.source_len;
 	/* Initialize fadump crash info header. */
@@ -1028,6 +1091,7 @@ void fadump_cleanup(void)
 	} else if (fw_dump.dump_registered) {
 		/* Un-register Firmware-assisted dump if it was registered. */
 		fadump_unregister_dump(&fdm);
+		free_crash_memory_ranges();
 	}
 }
=20
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_=
64_mmu_hv.c
index 68468d695f12..ccae6963d1cf 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -451,7 +451,7 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcp=
u *vcpu, gva_t eaddr,
 	unsigned long pp, key;
 	unsigned long v, gr;
 	unsigned long *hptep;
-	int index;
+	long int index;
 	int virtmode =3D vcpu->arch.shregs.msr & (data ? MSR_DR : MSR_IR);
=20
 	/* Get SLB entry */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 99960b0540e1..9daf72516606 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1654,8 +1654,8 @@ static struct timer_list topology_timer =3D
 static void reset_topology_timer(void)
 {
 	topology_timer.data =3D 0;
-	topology_timer.expires =3D jiffies + 60 * HZ;
-	mod_timer(&topology_timer, topology_timer.expires);
+	if (vphn_enabled)
+		mod_timer(&topology_timer, jiffies + 60 * HZ);
 }
=20
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platf=
orms/powernv/pci-ioda.c
index 34bd00be8018..910d26ee0712 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1132,6 +1132,41 @@ static void pnv_pci_ioda_create_dbgfs(void)
 #endif /* CONFIG_DEBUG_FS */
 }
=20
+static void pnv_pci_enable_bridge(struct pci_bus *bus)
+{
+	struct pci_dev *dev =3D bus->self;
+	struct pci_bus *child;
+
+	/* Empty bus ? bail */
+	if (list_empty(&bus->devices))
+		return;
+
+	/*
+	 * If there's a bridge associated with that bus enable it. This works
+	 * around races in the generic code if the enabling is done during
+	 * parallel probing. This can be removed once those races have been
+	 * fixed.
+	 */
+	if (dev) {
+		int rc =3D pci_enable_device(dev);
+		if (rc)
+			dev_err(&dev->dev, "Error enabling bridge (%d)\n", rc);
+		pci_set_master(dev);
+	}
+
+	/* Perform the same to child busses */
+	list_for_each_entry(child, &bus->children, node)
+		pnv_pci_enable_bridge(child);
+}
+
+static void pnv_pci_enable_bridges(void)
+{
+	struct pci_controller *hose;
+
+	list_for_each_entry(hose, &hose_list, list_node)
+		pnv_pci_enable_bridge(hose->bus);
+}
+
 static void pnv_pci_ioda_fixup(void)
 {
 	pnv_pci_ioda_setup_PEs();
@@ -1140,6 +1175,8 @@ static void pnv_pci_ioda_fixup(void)
=20
 	pnv_pci_ioda_create_dbgfs();
=20
+	pnv_pci_enable_bridges();
+
 #ifdef CONFIG_EEH
 	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
 	eeh_addr_cache_build();
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/=
pseries/ras.c
index 55cbad443500..c2eb366ff0ac 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -298,7 +298,7 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct =
pt_regs *regs)
 	}
=20
 	savep =3D __va(regs->gpr[3]);
-	regs->gpr[3] =3D savep[0];	/* restore original r3 */
+	regs->gpr[3] =3D be64_to_cpu(savep[0]);	/* restore original r3 */
=20
 	/* If it isn't an extended log we can use the per cpu 64bit buffer */
 	h =3D (struct rtas_error_log *)&savep[1];
@@ -309,7 +309,7 @@ static struct rtas_error_log *fwnmi_get_errinfo(struct =
pt_regs *regs)
 		int len, error_log_length;
=20
 		error_log_length =3D 8 + rtas_error_extended_log_length(h);
-		len =3D max_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
+		len =3D min_t(int, error_log_length, RTAS_ERROR_LOG_MAX);
 		memset(global_mce_data_buf, 0, RTAS_ERROR_LOG_MAX);
 		memcpy(global_mce_data_buf, h, len);
 		errhdr =3D (struct rtas_error_log *)global_mce_data_buf;
diff --git a/arch/powerpc/sysdev/mpic_msgr.c b/arch/powerpc/sysdev/mpic_msg=
r.c
index 2c9b52aa266c..9f34af4ee047 100644
--- a/arch/powerpc/sysdev/mpic_msgr.c
+++ b/arch/powerpc/sysdev/mpic_msgr.c
@@ -196,7 +196,7 @@ static int mpic_msgr_probe(struct platform_device *dev)
=20
 	/* IO map the message register block. */
 	of_address_to_resource(np, 0, &rsrc);
-	msgr_block_addr =3D ioremap(rsrc.start, rsrc.end - rsrc.start);
+	msgr_block_addr =3D ioremap(rsrc.start, resource_size(&rsrc));
 	if (!msgr_block_addr) {
 		dev_err(&dev->dev, "Failed to iomap MPIC message registers");
 		return -EFAULT;
diff --git a/arch/s390/include/asm/qdio.h b/arch/s390/include/asm/qdio.h
index d786c634e052..a20d6132405c 100644
--- a/arch/s390/include/asm/qdio.h
+++ b/arch/s390/include/asm/qdio.h
@@ -271,7 +271,6 @@ struct qdio_outbuf_state {
 	void *user;
 };
=20
-#define QDIO_OUTBUF_STATE_FLAG_NONE	0x00
 #define QDIO_OUTBUF_STATE_FLAG_PENDING	0x01
=20
 #define CHSC_AC1_INITIATE_INPUTQ	0x80
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 6da2b0bf6a32..832392b70b5f 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -497,6 +497,8 @@ static inline int do_exception(struct pt_regs *regs, in=
t access)
 	/* No reason to continue if interrupted by SIGKILL. */
 	if ((fault & VM_FAULT_RETRY) && fatal_signal_pending(current)) {
 		fault =3D VM_FAULT_SIGNAL;
+		if (flags & FAULT_FLAG_RETRY_NOWAIT)
+			goto out_up;
 		goto out;
 	}
 	if (unlikely(fault & VM_FAULT_ERROR))
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 950e7e350780..4350d725b914 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -397,6 +397,8 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec,=
 int type)
 	hwirq =3D 0;
 	list_for_each_entry(msi, &pdev->msi_list, list) {
 		rc =3D -EIO;
+		if (hwirq >=3D msi_vecs)
+			break;
 		irq =3D irq_alloc_desc(0);	/* Alloc irq on node 0 */
 		if (irq < 0)
 			goto out_msi;
diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index 32ce71375b21..5683ea84a6fc 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -21,12 +21,22 @@ enum die_val {
 	DIE_NMIUNKNOWN,
 };
=20
+enum show_regs_mode {
+	SHOW_REGS_SHORT,
+	/*
+	 * For when userspace crashed, but we don't think it's our fault, and
+	 * therefore don't print kernel registers.
+	 */
+	SHOW_REGS_USER,
+	SHOW_REGS_ALL
+};
+
 extern void printk_address(unsigned long address);
 extern void die(const char *, struct pt_regs *,long);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_trace(struct task_struct *t, struct pt_regs *regs,
 		       unsigned long *sp, unsigned long bp);
-extern void __show_regs(struct pt_regs *regs, int all);
+extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
 extern unsigned long oops_begin(void);
 extern void oops_end(unsigned long, struct pt_regs *, int signr);
 #ifdef CONFIG_KEXEC
diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/=
microcode_intel.h
index 9067166409bf..600ed4e90628 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -63,6 +63,21 @@ extern int get_matching_sig(unsigned int csig, int cpf, =
void *mc, int rev);
 extern int
 update_match_revision(struct microcode_header_intel *mc_header, int rev);
=20
+static inline u32 intel_get_microcode_revision(void)
+{
+	u32 rev, dummy;
+
+	native_wrmsrl(MSR_IA32_UCODE_REV, 0);
+
+	/* As documented in the SDM: Do a CPUID 1 here */
+	sync_core();
+
+	/* get the current revision from MSR 0x8B */
+	native_rdmsr(MSR_IA32_UCODE_REV, dummy, rev);
+
+	return rev;
+}
+
 #ifdef CONFIG_MICROCODE_INTEL_EARLY
 extern void __init load_ucode_intel_bsp(void);
 extern void load_ucode_intel_ap(void);
diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 851bcdc5db04..83ad4424d711 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -185,22 +185,22 @@ do {									\
 	typeof(var) pfo_ret__;				\
 	switch (sizeof(var)) {				\
 	case 1:						\
-		asm(op "b "__percpu_arg(1)",%0"		\
+		asm volatile(op "b "__percpu_arg(1)",%0"\
 		    : "=3Dq" (pfo_ret__)			\
 		    : constraint);			\
 		break;					\
 	case 2:						\
-		asm(op "w "__percpu_arg(1)",%0"		\
+		asm volatile(op "w "__percpu_arg(1)",%0"\
 		    : "=3Dr" (pfo_ret__)			\
 		    : constraint);			\
 		break;					\
 	case 4:						\
-		asm(op "l "__percpu_arg(1)",%0"		\
+		asm volatile(op "l "__percpu_arg(1)",%0"\
 		    : "=3Dr" (pfo_ret__)			\
 		    : constraint);			\
 		break;					\
 	case 8:						\
-		asm(op "q "__percpu_arg(1)",%0"		\
+		asm volatile(op "q "__percpu_arg(1)",%0"\
 		    : "=3Dr" (pfo_ret__)			\
 		    : constraint);			\
 		break;					\
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtab=
le_64.h
index 1d0eefbf3e12..df920ab4118b 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -44,15 +44,15 @@ struct mm_struct;
 void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte=
);
=20
=20
-static inline void native_pte_clear(struct mm_struct *mm, unsigned long ad=
dr,
-				    pte_t *ptep)
+static inline void native_set_pte(pte_t *ptep, pte_t pte)
 {
-	*ptep =3D native_make_pte(0);
+	ACCESS_ONCE(*ptep) =3D pte;
 }
=20
-static inline void native_set_pte(pte_t *ptep, pte_t pte)
+static inline void native_pte_clear(struct mm_struct *mm, unsigned long ad=
dr,
+				    pte_t *ptep)
 {
-	*ptep =3D pte;
+	native_set_pte(ptep, native_make_pte(0));
 }
=20
 static inline void native_set_pte_atomic(pte_t *ptep, pte_t pte)
@@ -62,7 +62,7 @@ static inline void native_set_pte_atomic(pte_t *ptep, pte=
_t pte)
=20
 static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 {
-	*pmdp =3D pmd;
+	ACCESS_ONCE(*pmdp) =3D pmd;
 }
=20
 static inline void native_pmd_clear(pmd_t *pmd)
@@ -98,7 +98,7 @@ static inline pmd_t native_pmdp_get_and_clear(pmd_t *xp)
=20
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
-	*pudp =3D pud;
+	ACCESS_ONCE(*pudp) =3D pud;
 }
=20
 static inline void native_pud_clear(pud_t *pud)
@@ -131,7 +131,7 @@ static inline pgd_t *native_get_shadow_pgd(pgd_t *pgdp)
=20
 static inline void native_set_pgd(pgd_t *pgdp, pgd_t pgd)
 {
-	*pgdp =3D kaiser_set_shadow_pgd(pgdp, pgd);
+	ACCESS_ONCE(*pgdp) =3D kaiser_set_shadow_pgd(pgdp, pgd);
 }
=20
 static inline void native_pgd_clear(pgd_t *pgd)
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/proces=
sor.h
index 280bfa055fc2..935d0c063a50 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -127,6 +127,8 @@ struct cpuinfo_x86 {
 	/* Index into per_cpu list: */
 	u16			cpu_index;
 	u32			microcode;
+	/* Address space bits used by the cache internally */
+	u8			x86_cache_bits;
 } __attribute__((__aligned__(SMP_CACHE_BYTES)));
=20
 #define X86_VENDOR_INTEL	0
@@ -167,7 +169,7 @@ extern void fpu_detect(struct cpuinfo_x86 *c);
=20
 static inline unsigned long long l1tf_pfn_limit(void)
 {
-	return BIT_ULL(boot_cpu_data.x86_phys_bits - 1 - PAGE_SHIFT);
+	return BIT_ULL(boot_cpu_data.x86_cache_bits - 1 - PAGE_SHIFT);
 }
=20
 extern void early_cpu_init(void);
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 047f9ff2e36c..3bda2d9ec006 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PARAVIRT)		+=3D paravirt.o paravirt_patch_$(=
BITS).o
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)+=3D paravirt-spinlocks.o
 obj-$(CONFIG_PARAVIRT_CLOCK)	+=3D pvclock.o
=20
+obj-$(CONFIG_EISA)		+=3D eisa.o
 obj-$(CONFIG_PCSPKR_PLATFORM)	+=3D pcspeaker.o
=20
 obj-$(CONFIG_X86_CHECK_BIOS_CORRUPTION) +=3D check.o
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 497657df6616..4364dd458ad6 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -696,6 +696,45 @@ void x86_spec_ctrl_setup_ap(void)
=20
 #undef pr_fmt
 #define pr_fmt(fmt)	"L1TF: " fmt
+/*
+ * These CPUs all support 44bits physical address space internally in the
+ * cache but CPUID can report a smaller number of physical address bits.
+ *
+ * The L1TF mitigation uses the top most address bit for the inversion of
+ * non present PTEs. When the installed memory reaches into the top most
+ * address bit due to memory holes, which has been observed on machines
+ * which report 36bits physical address bits and have 32G RAM installed,
+ * then the mitigation range check in l1tf_select_mitigation() triggers.
+ * This is a false positive because the mitigation is still possible due to
+ * the fact that the cache uses 44bit internally. Use the cache bits
+ * instead of the reported physical bits and adjust them on the affected
+ * machines to 44bit if the reported bits are less than 44.
+ */
+static void override_cache_bits(struct cpuinfo_x86 *c)
+{
+	if (c->x86 !=3D 6)
+		return;
+
+	switch (c->x86_model) {
+	case INTEL_FAM6_NEHALEM:
+	case INTEL_FAM6_WESTMERE:
+	case INTEL_FAM6_SANDYBRIDGE:
+	case INTEL_FAM6_IVYBRIDGE:
+	case INTEL_FAM6_HASWELL_CORE:
+	case INTEL_FAM6_HASWELL_ULT:
+	case INTEL_FAM6_HASWELL_GT3E:
+	case INTEL_FAM6_BROADWELL_CORE:
+	case INTEL_FAM6_BROADWELL_GT3E:
+	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_DESKTOP:
+	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_DESKTOP:
+		if (c->x86_cache_bits < 44)
+			c->x86_cache_bits =3D 44;
+		break;
+	}
+}
+
 static void __init l1tf_select_mitigation(void)
 {
 	u64 half_pa;
@@ -703,16 +742,13 @@ static void __init l1tf_select_mitigation(void)
 	if (!boot_cpu_has_bug(X86_BUG_L1TF))
 		return;
=20
+	override_cache_bits(&boot_cpu_data);
+
 #if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
 	pr_warn("Kernel not compiled for PAE. No mitigation for L1TF\n");
 	return;
 #endif
=20
-	/*
-	 * This is extremely unlikely to happen because almost all
-	 * systems have far more MAX_PA/2 than RAM can be fit into
-	 * DIMM slots.
-	 */
 	half_pa =3D (u64)l1tf_pfn_limit() << PAGE_SHIFT;
 	if (e820_any_mapped(half_pa, ULLONG_MAX - half_pa, E820_RAM)) {
 		pr_warn("System has more than MAX_PA/2 memory. L1TF mitigation not effec=
tive.\n");
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2068a648f893..e8ecf617ca4a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -772,6 +772,7 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
 		c->x86_phys_bits =3D 36;
 #endif
+	c->x86_cache_bits =3D c->x86_phys_bits;
=20
 	if (c->extended_cpuid_level >=3D 0x80000007)
 		c->x86_power =3D cpuid_edx(0x80000007);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 0d41977fb6ad..1fda971a0726 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -14,6 +14,7 @@
 #include <asm/bugs.h>
 #include <asm/cpu.h>
 #include <asm/intel-family.h>
+#include <asm/microcode_intel.h>
=20
 #ifdef CONFIG_X86_64
 #include <linux/topology.h>
@@ -75,6 +76,9 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
 	if (cpu_has(c, X86_FEATURE_HYPERVISOR))
 		return false;
=20
+	if (c->x86 !=3D 6)
+		return false;
+
 	for (i =3D 0; i < ARRAY_SIZE(spectre_bad_microcodes); i++) {
 		if (c->x86_model =3D=3D spectre_bad_microcodes[i].model &&
 		    c->x86_mask =3D=3D spectre_bad_microcodes[i].stepping)
@@ -100,14 +104,8 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		(c->x86 =3D=3D 0x6 && c->x86_model >=3D 0x0e))
 		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
=20
-	if (c->x86 >=3D 6 && !cpu_has(c, X86_FEATURE_IA64)) {
-		unsigned lower_word;
-
-		wrmsr(MSR_IA32_UCODE_REV, 0, 0);
-		/* Required by the SDM */
-		sync_core();
-		rdmsr(MSR_IA32_UCODE_REV, lower_word, c->microcode);
-	}
+	if (c->x86 >=3D 6 && !cpu_has(c, X86_FEATURE_IA64))
+		c->microcode =3D intel_get_microcode_revision();
=20
 	/* Now if any of them are set, check the blacklist and clear the lot */
 	if ((cpu_has(c, X86_FEATURE_SPEC_CTRL) ||
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/micr=
ocode/amd.c
index 8fffd845e22b..ff16949e7f3d 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -214,22 +214,26 @@ int apply_microcode_amd(int cpu)
 	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
=20
 	/* need to apply patch? */
-	if (rev >=3D mc_amd->hdr.patch_id) {
-		c->microcode =3D rev;
-		uci->cpu_sig.rev =3D rev;
-		return 0;
-	}
+	if (rev >=3D mc_amd->hdr.patch_id)
+		goto out;
=20
 	if (__apply_microcode_amd(mc_amd)) {
 		pr_err("CPU%d: update failed for patch_level=3D0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
 		return -1;
 	}
-	pr_info("CPU%d: new patch_level=3D0x%08x\n", cpu,
-		mc_amd->hdr.patch_id);
=20
-	uci->cpu_sig.rev =3D mc_amd->hdr.patch_id;
-	c->microcode =3D mc_amd->hdr.patch_id;
+	rev =3D mc_amd->hdr.patch_id;
+
+	pr_info("CPU%d: new patch_level=3D0x%08x\n", cpu, rev);
+
+out:
+	uci->cpu_sig.rev =3D rev;
+	c->microcode	 =3D rev;
+
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index =3D=3D boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode =3D rev;
=20
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/mi=
crocode/intel.c
index 7a93397bcc35..96fc70c033a2 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -134,9 +134,9 @@ int apply_microcode(int cpu)
 {
 	struct microcode_intel *mc_intel;
 	struct ucode_cpu_info *uci;
-	unsigned int val[2];
 	int cpu_num =3D raw_smp_processor_id();
 	struct cpuinfo_x86 *c =3D &cpu_data(cpu_num);
+	u32 rev;
=20
 	uci =3D ucode_cpu_info + cpu;
 	mc_intel =3D uci->mc;
@@ -155,31 +155,40 @@ int apply_microcode(int cpu)
 	if (get_matching_mc(mc_intel, cpu) =3D=3D 0)
 		return 0;
=20
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev =3D intel_get_microcode_revision();
+	if (rev >=3D mc_intel->hdr.rev)
+		goto out;
+
 	/* write microcode via MSR 0x79 */
 	wrmsr(MSR_IA32_UCODE_WRITE,
 	      (unsigned long) mc_intel->bits,
 	      (unsigned long) mc_intel->bits >> 16 >> 16);
-	wrmsr(MSR_IA32_UCODE_REV, 0, 0);
-
-	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
=20
-	/* get the current revision from MSR 0x8B */
-	rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
+	rev =3D intel_get_microcode_revision();
=20
-	if (val[1] !=3D mc_intel->hdr.rev) {
+	if (rev !=3D mc_intel->hdr.rev) {
 		pr_err("CPU%d update to revision 0x%x failed\n",
 		       cpu_num, mc_intel->hdr.rev);
 		return -1;
 	}
 	pr_info("CPU%d updated to revision 0x%x, date =3D %04x-%02x-%02x\n",
-		cpu_num, val[1],
+		cpu_num, rev,
 		mc_intel->hdr.date & 0xffff,
 		mc_intel->hdr.date >> 24,
 		(mc_intel->hdr.date >> 16) & 0xff);
=20
-	uci->cpu_sig.rev =3D val[1];
-	c->microcode =3D val[1];
+out:
+	uci->cpu_sig.rev =3D rev;
+	c->microcode	 =3D rev;
+
+	/* Update boot_cpu_data's revision too, if we're on the BSP: */
+	if (c->cpu_index =3D=3D boot_cpu_data.cpu_index)
+		boot_cpu_data.microcode =3D rev;
=20
 	return 0;
 }
diff --git a/arch/x86/kernel/cpu/microcode/intel_early.c b/arch/x86/kernel/=
cpu/microcode/intel_early.c
index 43a07bf48dea..d31a60ced5eb 100644
--- a/arch/x86/kernel/cpu/microcode/intel_early.c
+++ b/arch/x86/kernel/cpu/microcode/intel_early.c
@@ -391,15 +391,8 @@ static int collect_cpu_info_early(struct ucode_cpu_inf=
o *uci)
 		native_rdmsr(MSR_IA32_PLATFORM_ID, val[0], val[1]);
 		csig.pf =3D 1 << ((val[1] >> 18) & 7);
 	}
-	native_wrmsr(MSR_IA32_UCODE_REV, 0, 0);
=20
-	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
-
-	/* get the current revision from MSR 0x8B */
-	native_rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
-
-	csig.rev =3D val[1];
+	csig.rev =3D intel_get_microcode_revision();
=20
 	uci->cpu_sig =3D csig;
 	uci->valid =3D 1;
@@ -654,31 +647,37 @@ static int apply_microcode_early(struct mc_saved_data=
 *mc_saved_data,
 				 struct ucode_cpu_info *uci)
 {
 	struct microcode_intel *mc_intel;
-	unsigned int val[2];
+	u32 rev;
=20
 	mc_intel =3D uci->mc;
 	if (mc_intel =3D=3D NULL)
 		return 0;
=20
+	/*
+	 * Save us the MSR write below - which is a particular expensive
+	 * operation - when the other hyperthread has updated the microcode
+	 * already.
+	 */
+	rev =3D intel_get_microcode_revision();
+	if (rev >=3D mc_intel->hdr.rev) {
+		uci->cpu_sig.rev =3D rev;
+		return 0;
+	}
+
 	/* write microcode via MSR 0x79 */
 	native_wrmsr(MSR_IA32_UCODE_WRITE,
 	      (unsigned long) mc_intel->bits,
 	      (unsigned long) mc_intel->bits >> 16 >> 16);
-	native_wrmsr(MSR_IA32_UCODE_REV, 0, 0);
-
-	/* As documented in the SDM: Do a CPUID 1 here */
-	sync_core();
=20
-	/* get the current revision from MSR 0x8B */
-	native_rdmsr(MSR_IA32_UCODE_REV, val[0], val[1]);
-	if (val[1] !=3D mc_intel->hdr.rev)
+	rev =3D intel_get_microcode_revision();
+	if (rev !=3D mc_intel->hdr.rev)
 		return -1;
=20
 #ifdef CONFIG_X86_64
 	/* Flush global tlb. This is precaution. */
 	flush_tlb_early();
 #endif
-	uci->cpu_sig.rev =3D val[1];
+	uci->cpu_sig.rev =3D rev;
=20
 	print_ucode(uci);
=20
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 5abd4cd4230c..cac129fa0e7f 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -123,7 +123,7 @@ void show_regs(struct pt_regs *regs)
 	int i;
=20
 	show_regs_print_info(KERN_EMERG);
-	__show_regs(regs, !user_mode_vm(regs));
+	__show_regs(regs, user_mode_vm(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
=20
 	/*
 	 * When in-kernel, we also print out the stack and code at the
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index ff86f19b5758..879ab159aa49 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -301,7 +301,7 @@ void show_regs(struct pt_regs *regs)
=20
 	sp =3D regs->sp;
 	show_regs_print_info(KERN_DEFAULT);
-	__show_regs(regs, 1);
+	__show_regs(regs, user_mode(regs) ? SHOW_REGS_USER : SHOW_REGS_ALL);
=20
 	/*
 	 * When in-kernel, we also print out the stack and code at the
diff --git a/arch/x86/kernel/eisa.c b/arch/x86/kernel/eisa.c
new file mode 100644
index 000000000000..7d299ff294fb
--- /dev/null
+++ b/arch/x86/kernel/eisa.c
@@ -0,0 +1,24 @@
+/*
+ * EISA specific code
+ *
+ * This file is licensed under the GPL V2
+ */
+#include <linux/ioport.h>
+#include <linux/eisa.h>
+
+#include <xen/xen.h>
+
+static __init int eisa_bus_probe(void)
+{
+	void __iomem *p;
+
+	if (xen_pv_domain() && !xen_initial_domain())
+		return 0;
+
+	p =3D ioremap(0x0FFFD9, 4);
+	if (p && readl(p) =3D=3D 'E' + ('I' << 8) + ('S' << 16) + ('A' << 24))
+		EISA_bus =3D 1;
+	iounmap(p);
+	return 0;
+}
+subsys_initcall(eisa_bus_probe);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index e9e5afd7b2b8..bd86916cba4c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -99,7 +99,7 @@ unsigned paravirt_patch_call(void *insnbuf,
=20
 	if (len < 5) {
 #ifdef CONFIG_RETPOLINE
-		WARN_ONCE("Failing to patch indirect CALL in %ps\n", (void *)addr);
+		WARN_ONCE(1, "Failing to patch indirect CALL in %ps\n", (void *)addr);
 #endif
 		return len;	/* call too long for patch site */
 	}
@@ -119,7 +119,7 @@ unsigned paravirt_patch_jmp(void *insnbuf, const void *=
target,
=20
 	if (len < 5) {
 #ifdef CONFIG_RETPOLINE
-		WARN_ONCE("Failing to patch indirect JMP in %ps\n", (void *)addr);
+		WARN_ONCE(1, "Failing to patch indirect JMP in %ps\n", (void *)addr);
 #endif
 		return len;	/* call too long for patch site */
 	}
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index 7bc86bbe7485..c72b7afd3e02 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -66,7 +66,7 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
 	return ((unsigned long *)tsk->thread.sp)[3];
 }
=20
-void __show_regs(struct pt_regs *regs, int all)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
 	unsigned long cr0 =3D 0L, cr2 =3D 0L, cr3 =3D 0L, cr4 =3D 0L;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -95,7 +95,7 @@ void __show_regs(struct pt_regs *regs, int all)
 	printk(KERN_DEFAULT " DS: %04x ES: %04x FS: %04x GS: %04x SS: %04x\n",
 	       (u16)regs->ds, (u16)regs->es, (u16)regs->fs, gs, ss);
=20
-	if (!all)
+	if (mode !=3D SHOW_REGS_ALL)
 		return;
=20
 	cr0 =3D read_cr0();
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 838d259bca74..512fb8c979ed 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -56,7 +56,7 @@ asmlinkage extern void ret_from_fork(void);
 __visible DEFINE_PER_CPU_USER_MAPPED(unsigned long, old_rsp);
=20
 /* Prints also some state that isn't saved in the pt_regs */
-void __show_regs(struct pt_regs *regs, int all)
+void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 {
 	unsigned long cr0 =3D 0L, cr2 =3D 0L, cr3 =3D 0L, cr4 =3D 0L, fs, gs, sha=
dowgs;
 	unsigned long d0, d1, d2, d3, d6, d7;
@@ -88,9 +88,15 @@ void __show_regs(struct pt_regs *regs, int all)
 	rdmsrl(MSR_GS_BASE, gs);
 	rdmsrl(MSR_KERNEL_GS_BASE, shadowgs);
=20
-	if (!all)
+	if (mode =3D=3D SHOW_REGS_SHORT)
 		return;
=20
+	if (mode =3D=3D SHOW_REGS_USER) {
+		printk(KERN_DEFAULT "FS:  %016lx GS:  %016lx\n",
+		       fs, shadowgs);
+		return;
+	}
+
 	cr0 =3D read_cr0();
 	cr2 =3D read_cr2();
 	cr3 =3D read_cr3();
@@ -254,6 +260,7 @@ start_thread(struct pt_regs *regs, unsigned long new_ip=
, unsigned long new_sp)
 	start_thread_common(regs, new_ip, new_sp,
 			    __USER_CS, __USER_DS, 0);
 }
+EXPORT_SYMBOL_GPL(start_thread);
=20
 #ifdef CONFIG_IA32_EMULATION
 void start_thread_ia32(struct pt_regs *regs, u32 new_ip, u32 new_sp)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 87acf447ef2a..6e0df1be1c19 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -37,11 +37,6 @@
 #include <linux/smp.h>
 #include <linux/io.h>
=20
-#ifdef CONFIG_EISA
-#include <linux/ioport.h>
-#include <linux/eisa.h>
-#endif
-
 #if defined(CONFIG_EDAC)
 #include <linux/edac.h>
 #endif
@@ -796,14 +791,6 @@ void __init trap_init(void)
 {
 	int i;
=20
-#ifdef CONFIG_EISA
-	void __iomem *p =3D early_ioremap(0x0FFFD9, 4);
-
-	if (readl(p) =3D=3D 'E' + ('I'<<8) + ('S'<<16) + ('A'<<24))
-		EISA_bus =3D 1;
-	early_iounmap(p, 4);
-#endif
-
 	set_intr_gate(X86_TRAP_DE, divide_error);
 	set_intr_gate_ist(X86_TRAP_NMI, &nmi, NMI_STACK);
 	/* int4 can be called from all */
diff --git a/arch/x86/mm/kmemcheck/error.c b/arch/x86/mm/kmemcheck/error.c
index dab41876cdd5..efcdcef32e19 100644
--- a/arch/x86/mm/kmemcheck/error.c
+++ b/arch/x86/mm/kmemcheck/error.c
@@ -132,7 +132,7 @@ void kmemcheck_error_recall(void)
 		break;
 	}
=20
-	__show_regs(&e->regs, 1);
+	__show_regs(&e->regs, SHOW_REGS_ALL);
 	print_stack_trace(&e->trace, 0);
 }
=20
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index d230776e9b19..84c6c34c2106 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -242,7 +242,7 @@ static void pgd_mop_up_pmds(struct mm_struct *mm, pgd_t=
 *pgdp)
 		if (pgd_val(pgd) !=3D 0) {
 			pmd_t *pmd =3D (pmd_t *)pgd_page_vaddr(pgd);
=20
-			pgdp[i] =3D native_make_pgd(0);
+			pgd_clear(&pgdp[i]);
=20
 			paravirt_release_pmd(pgd_val(pgd) >> PAGE_SHIFT);
 			pmd_free(mm, pmd);
@@ -352,7 +352,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
 	int changed =3D !pte_same(*ptep, entry);
=20
 	if (changed && dirty) {
-		*ptep =3D entry;
+		set_pte(ptep, entry);
 		pte_update_defer(vma->vm_mm, address, ptep);
 	}
=20
@@ -369,7 +369,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
=20
 	if (changed && dirty) {
-		*pmdp =3D entry;
+		set_pmd(pmdp, entry);
 		pmd_update_defer(vma->vm_mm, address, pmdp);
 		/*
 		 * We had a write-protection fault here and changed the pmd
diff --git a/arch/x86/vdso/vclock_gettime.c b/arch/x86/vdso/vclock_gettime.c
index c3c3cf14680f..00b5ea4d9189 100644
--- a/arch/x86/vdso/vclock_gettime.c
+++ b/arch/x86/vdso/vclock_gettime.c
@@ -50,8 +50,9 @@ extern u8 pvclock_page
 notrace static long vdso_fallback_gettime(long clock, struct timespec *ts)
 {
 	long ret;
-	asm("syscall" : "=3Da" (ret) :
-	    "0" (__NR_clock_gettime), "D" (clock), "S" (ts) : "memory");
+	asm ("syscall" : "=3Da" (ret), "=3Dm" (*ts) :
+	     "0" (__NR_clock_gettime), "D" (clock), "S" (ts) :
+	     "memory", "rcx", "r11");
 	return ret;
 }
=20
@@ -59,8 +60,9 @@ notrace static long vdso_fallback_gtod(struct timeval *tv=
, struct timezone *tz)
 {
 	long ret;
=20
-	asm("syscall" : "=3Da" (ret) :
-	    "0" (__NR_gettimeofday), "D" (tv), "S" (tz) : "memory");
+	asm ("syscall" : "=3Da" (ret), "=3Dm" (*tv), "=3Dm" (*tz) :
+	     "0" (__NR_gettimeofday), "D" (tv), "S" (tz) :
+	     "memory", "rcx", "r11");
 	return ret;
 }
=20
@@ -143,12 +145,12 @@ notrace static long vdso_fallback_gettime(long clock,=
 struct timespec *ts)
 {
 	long ret;
=20
-	asm(
+	asm (
 		"mov %%ebx, %%edx \n"
 		"mov %2, %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
-		: "=3Da" (ret)
+		: "=3Da" (ret), "=3Dm" (*ts)
 		: "0" (__NR_clock_gettime), "g" (clock), "c" (ts)
 		: "memory", "edx");
 	return ret;
@@ -158,12 +160,12 @@ notrace static long vdso_fallback_gtod(struct timeval=
 *tv, struct timezone *tz)
 {
 	long ret;
=20
-	asm(
+	asm (
 		"mov %%ebx, %%edx \n"
 		"mov %2, %%ebx \n"
 		"call __kernel_vsyscall \n"
 		"mov %%edx, %%ebx \n"
-		: "=3Da" (ret)
+		: "=3Da" (ret), "=3Dm" (*tv), "=3Dm" (*tz)
 		: "0" (__NR_gettimeofday), "g" (tv), "c" (tz)
 		: "memory", "edx");
 	return ret;
diff --git a/arch/xtensa/include/asm/cacheasm.h b/arch/xtensa/include/asm/c=
acheasm.h
index 60e18773ecb8..03a5d3a8b54d 100644
--- a/arch/xtensa/include/asm/cacheasm.h
+++ b/arch/xtensa/include/asm/cacheasm.h
@@ -31,16 +31,32 @@
  *
  */
=20
-	.macro	__loop_cache_all ar at insn size line_width
=20
-	movi	\ar, 0
+	.macro	__loop_cache_unroll ar at insn size line_width max_immed
+
+	.if	(1 << (\line_width)) > (\max_immed)
+	.set	_reps, 1
+	.elseif	(2 << (\line_width)) > (\max_immed)
+	.set	_reps, 2
+	.else
+	.set	_reps, 4
+	.endif
+
+	__loopi	\ar, \at, \size, (_reps << (\line_width))
+	.set	_index, 0
+	.rep	_reps
+	\insn	\ar, _index << (\line_width)
+	.set	_index, _index + 1
+	.endr
+	__endla	\ar, \at, _reps << (\line_width)
+
+	.endm
+
=20
-	__loopi	\ar, \at, \size, (4 << (\line_width))
-	\insn	\ar, 0 << (\line_width)
-	\insn	\ar, 1 << (\line_width)
-	\insn	\ar, 2 << (\line_width)
-	\insn	\ar, 3 << (\line_width)
-	__endla	\ar, \at, 4 << (\line_width)
+	.macro	__loop_cache_all ar at insn size line_width max_immed
+
+	movi	\ar, 0
+	__loop_cache_unroll \ar, \at, \insn, \size, \line_width, \max_immed
=20
 	.endm
=20
@@ -57,14 +73,9 @@
 	.endm
=20
=20
-	.macro	__loop_cache_page ar at insn line_width
+	.macro	__loop_cache_page ar at insn line_width max_immed
=20
-	__loopi	\ar, \at, PAGE_SIZE, 4 << (\line_width)
-	\insn	\ar, 0 << (\line_width)
-	\insn	\ar, 1 << (\line_width)
-	\insn	\ar, 2 << (\line_width)
-	\insn	\ar, 3 << (\line_width)
-	__endla	\ar, \at, 4 << (\line_width)
+	__loop_cache_unroll \ar, \at, \insn, PAGE_SIZE, \line_width, \max_immed
=20
 	.endm
=20
@@ -73,7 +84,8 @@
=20
 	.macro	___unlock_dcache_all ar at
=20
-	__loop_cache_all \ar \at diu XCHAL_DCACHE_SIZE XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at diu XCHAL_DCACHE_SIZE \
+		XCHAL_DCACHE_LINEWIDTH 240
=20
 	.endm
=20
@@ -83,37 +95,40 @@
=20
 	.macro	___unlock_icache_all ar at
=20
-	__loop_cache_all \ar \at iiu XCHAL_ICACHE_SIZE XCHAL_ICACHE_LINEWIDTH
+	__loop_cache_all \ar \at iiu XCHAL_ICACHE_SIZE \
+		XCHAL_ICACHE_LINEWIDTH 240
=20
 	.endm
 #endif
=20
 	.macro	___flush_invalidate_dcache_all ar at
=20
-	__loop_cache_all \ar \at diwbi XCHAL_DCACHE_SIZE XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at diwbi XCHAL_DCACHE_SIZE \
+		XCHAL_DCACHE_LINEWIDTH 240
=20
 	.endm
=20
=20
 	.macro	___flush_dcache_all ar at
=20
-	__loop_cache_all \ar \at diwb XCHAL_DCACHE_SIZE XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at diwb XCHAL_DCACHE_SIZE \
+		XCHAL_DCACHE_LINEWIDTH 240
=20
 	.endm
=20
=20
 	.macro	___invalidate_dcache_all ar at
=20
-	__loop_cache_all \ar \at dii __stringify(DCACHE_WAY_SIZE) \
-			 XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_all \ar \at dii XCHAL_DCACHE_SIZE \
+			 XCHAL_DCACHE_LINEWIDTH 1020
=20
 	.endm
=20
=20
 	.macro	___invalidate_icache_all ar at
=20
-	__loop_cache_all \ar \at iii __stringify(ICACHE_WAY_SIZE) \
-			 XCHAL_ICACHE_LINEWIDTH
+	__loop_cache_all \ar \at iii XCHAL_ICACHE_SIZE \
+			 XCHAL_ICACHE_LINEWIDTH 1020
=20
 	.endm
=20
@@ -150,27 +165,27 @@
=20
 	.macro	___flush_invalidate_dcache_page ar as
=20
-	__loop_cache_page \ar \as dhwbi XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_page \ar \as dhwbi XCHAL_DCACHE_LINEWIDTH 1020
=20
 	.endm
=20
=20
 	.macro ___flush_dcache_page ar as
=20
-	__loop_cache_page \ar \as dhwb XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_page \ar \as dhwb XCHAL_DCACHE_LINEWIDTH 1020
=20
 	.endm
=20
=20
 	.macro	___invalidate_dcache_page ar as
=20
-	__loop_cache_page \ar \as dhi XCHAL_DCACHE_LINEWIDTH
+	__loop_cache_page \ar \as dhi XCHAL_DCACHE_LINEWIDTH 1020
=20
 	.endm
=20
=20
 	.macro	___invalidate_icache_page ar as
=20
-	__loop_cache_page \ar \as ihi XCHAL_ICACHE_LINEWIDTH
+	__loop_cache_page \ar \as ihi XCHAL_ICACHE_LINEWIDTH 1020
=20
 	.endm
diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index f56d85b6c5e3..7587f23b2657 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -193,32 +193,6 @@ int bio_integrity_enabled(struct bio *bio)
 }
 EXPORT_SYMBOL(bio_integrity_enabled);
=20
-/**
- * bio_integrity_hw_sectors - Convert 512b sectors to hardware ditto
- * @bi:		blk_integrity profile for device
- * @sectors:	Number of 512 sectors to convert
- *
- * Description: The block layer calculates everything in 512 byte
- * sectors but integrity metadata is done in terms of the hardware
- * sector size of the storage device.  Convert the block layer sectors
- * to physical sectors.
- */
-static inline unsigned int bio_integrity_hw_sectors(struct blk_integrity *=
bi,
-						    unsigned int sectors)
-{
-	/* At this point there are only 512b or 4096b DIF/EPP devices */
-	if (bi->sector_size =3D=3D 4096)
-		return sectors >>=3D 3;
-
-	return sectors;
-}
-
-static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-					       unsigned int sectors)
-{
-	return bio_integrity_hw_sectors(bi, sectors) * bi->tuple_size;
-}
-
 /**
  * bio_integrity_tag_size - Retrieve integrity tag space
  * @bio:	bio to inspect
diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index 0931f5136ab2..e36f9e35fc0f 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -177,7 +177,7 @@ int aix_partition(struct parsed_partitions *state)
 	u32 vgda_sector =3D 0;
 	u32 vgda_len =3D 0;
 	int numlvs =3D 0;
-	struct pvd *pvd;
+	struct pvd *pvd =3D NULL;
 	struct lv_info {
 		unsigned short pps_per_lv;
 		unsigned short pps_found;
@@ -231,10 +231,11 @@ int aix_partition(struct parsed_partitions *state)
 				if (lvip[i].pps_per_lv)
 					foundlvs +=3D 1;
 			}
+			/* pvd loops depend on n[].name and lvip[].pps_per_lv */
+			pvd =3D alloc_pvd(state, vgda_sector + 17);
 		}
 		put_dev_sector(sect);
 	}
-	pvd =3D alloc_pvd(state, vgda_sector + 17);
 	if (pvd) {
 		int numpps =3D be16_to_cpu(pvd->pp_count);
 		int psn_part1 =3D be32_to_cpu(pvd->psn_part1);
@@ -281,10 +282,14 @@ int aix_partition(struct parsed_partitions *state)
 				next_lp_ix +=3D 1;
 		}
 		for (i =3D 0; i < state->limit; i +=3D 1)
-			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous)
+			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
+				char tmp[sizeof(n[i].name) + 1]; // null char
+
+				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
 				pr_warn("partition %s (%u pp's found) is "
 					"not contiguous\n",
-					n[i].name, lvip[i].pps_found);
+					tmp, lvip[i].pps_found);
+			}
 		kfree(pvd);
 	}
 	kfree(n);
diff --git a/crypto/ablkcipher.c b/crypto/ablkcipher.c
index 970b48e70624..59e2b9116fd8 100644
--- a/crypto/ablkcipher.c
+++ b/crypto/ablkcipher.c
@@ -72,11 +72,9 @@ static inline u8 *ablkcipher_get_spot(u8 *start, unsigne=
d int len)
 	return max(start, end_page);
 }
=20
-static inline unsigned int ablkcipher_done_slow(struct ablkcipher_walk *wa=
lk,
-						unsigned int bsize)
+static inline void ablkcipher_done_slow(struct ablkcipher_walk *walk,
+					unsigned int n)
 {
-	unsigned int n =3D bsize;
-
 	for (;;) {
 		unsigned int len_this_page =3D scatterwalk_pagelen(&walk->out);
=20
@@ -88,17 +86,13 @@ static inline unsigned int ablkcipher_done_slow(struct =
ablkcipher_walk *walk,
 		n -=3D len_this_page;
 		scatterwalk_start(&walk->out, scatterwalk_sg_next(walk->out.sg));
 	}
-
-	return bsize;
 }
=20
-static inline unsigned int ablkcipher_done_fast(struct ablkcipher_walk *wa=
lk,
-						unsigned int n)
+static inline void ablkcipher_done_fast(struct ablkcipher_walk *walk,
+					unsigned int n)
 {
 	scatterwalk_advance(&walk->in, n);
 	scatterwalk_advance(&walk->out, n);
-
-	return n;
 }
=20
 static int ablkcipher_walk_next(struct ablkcipher_request *req,
@@ -108,39 +102,40 @@ int ablkcipher_walk_done(struct ablkcipher_request *r=
eq,
 			 struct ablkcipher_walk *walk, int err)
 {
 	struct crypto_tfm *tfm =3D req->base.tfm;
-	unsigned int nbytes =3D 0;
+	unsigned int n; /* bytes processed */
+	bool more;
=20
-	if (likely(err >=3D 0)) {
-		unsigned int n =3D walk->nbytes - err;
+	if (unlikely(err < 0))
+		goto finish;
=20
-		if (likely(!(walk->flags & ABLKCIPHER_WALK_SLOW)))
-			n =3D ablkcipher_done_fast(walk, n);
-		else if (WARN_ON(err)) {
-			err =3D -EINVAL;
-			goto err;
-		} else
-			n =3D ablkcipher_done_slow(walk, n);
+	n =3D walk->nbytes - err;
+	walk->total -=3D n;
+	more =3D (walk->total !=3D 0);
=20
-		nbytes =3D walk->total - n;
-		err =3D 0;
+	if (likely(!(walk->flags & ABLKCIPHER_WALK_SLOW))) {
+		ablkcipher_done_fast(walk, n);
+	} else {
+		if (WARN_ON(err)) {
+			/* unexpected case; didn't process all bytes */
+			err =3D -EINVAL;
+			goto finish;
+		}
+		ablkcipher_done_slow(walk, n);
 	}
=20
-	scatterwalk_done(&walk->in, 0, nbytes);
-	scatterwalk_done(&walk->out, 1, nbytes);
-
-err:
-	walk->total =3D nbytes;
-	walk->nbytes =3D nbytes;
+	scatterwalk_done(&walk->in, 0, more);
+	scatterwalk_done(&walk->out, 1, more);
=20
-	if (nbytes) {
+	if (more) {
 		crypto_yield(req->base.flags);
 		return ablkcipher_walk_next(req, walk);
 	}
-
+	err =3D 0;
+finish:
+	walk->nbytes =3D 0;
 	if (walk->iv !=3D req->info)
 		memcpy(req->info, walk->iv, tfm->crt_ablkcipher.ivsize);
 	kfree(walk->iv_buffer);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(ablkcipher_walk_done);
diff --git a/crypto/blkcipher.c b/crypto/blkcipher.c
index 37130b81d0d4..25f56a3aac53 100644
--- a/crypto/blkcipher.c
+++ b/crypto/blkcipher.c
@@ -70,19 +70,18 @@ static inline u8 *blkcipher_get_spot(u8 *start, unsigne=
d int len)
 	return max(start, end_page);
 }
=20
-static inline unsigned int blkcipher_done_slow(struct blkcipher_walk *walk,
-					       unsigned int bsize)
+static inline void blkcipher_done_slow(struct blkcipher_walk *walk,
+				       unsigned int bsize)
 {
 	u8 *addr;
=20
 	addr =3D (u8 *)ALIGN((unsigned long)walk->buffer, walk->alignmask + 1);
 	addr =3D blkcipher_get_spot(addr, bsize);
 	scatterwalk_copychunks(addr, &walk->out, bsize, 1);
-	return bsize;
 }
=20
-static inline unsigned int blkcipher_done_fast(struct blkcipher_walk *walk,
-					       unsigned int n)
+static inline void blkcipher_done_fast(struct blkcipher_walk *walk,
+				       unsigned int n)
 {
 	if (walk->flags & BLKCIPHER_WALK_COPY) {
 		blkcipher_map_dst(walk);
@@ -96,49 +95,48 @@ static inline unsigned int blkcipher_done_fast(struct b=
lkcipher_walk *walk,
=20
 	scatterwalk_advance(&walk->in, n);
 	scatterwalk_advance(&walk->out, n);
-
-	return n;
 }
=20
 int blkcipher_walk_done(struct blkcipher_desc *desc,
 			struct blkcipher_walk *walk, int err)
 {
-	unsigned int nbytes =3D 0;
+	unsigned int n; /* bytes processed */
+	bool more;
=20
-	if (likely(err >=3D 0)) {
-		unsigned int n =3D walk->nbytes - err;
+	if (unlikely(err < 0))
+		goto finish;
=20
-		if (likely(!(walk->flags & BLKCIPHER_WALK_SLOW)))
-			n =3D blkcipher_done_fast(walk, n);
-		else if (WARN_ON(err)) {
-			err =3D -EINVAL;
-			goto err;
-		} else
-			n =3D blkcipher_done_slow(walk, n);
+	n =3D walk->nbytes - err;
+	walk->total -=3D n;
+	more =3D (walk->total !=3D 0);
=20
-		nbytes =3D walk->total - n;
-		err =3D 0;
+	if (likely(!(walk->flags & BLKCIPHER_WALK_SLOW))) {
+		blkcipher_done_fast(walk, n);
+	} else {
+		if (WARN_ON(err)) {
+			/* unexpected case; didn't process all bytes */
+			err =3D -EINVAL;
+			goto finish;
+		}
+		blkcipher_done_slow(walk, n);
 	}
=20
-	scatterwalk_done(&walk->in, 0, nbytes);
-	scatterwalk_done(&walk->out, 1, nbytes);
-
-err:
-	walk->total =3D nbytes;
-	walk->nbytes =3D nbytes;
+	scatterwalk_done(&walk->in, 0, more);
+	scatterwalk_done(&walk->out, 1, more);
=20
-	if (nbytes) {
+	if (more) {
 		crypto_yield(desc->flags);
 		return blkcipher_walk_next(desc, walk);
 	}
-
+	err =3D 0;
+finish:
+	walk->nbytes =3D 0;
 	if (walk->iv !=3D desc->info)
 		memcpy(desc->info, walk->iv, walk->ivsize);
 	if (walk->buffer !=3D walk->page)
 		kfree(walk->buffer);
 	if (walk->page)
 		free_page((unsigned long)walk->page);
-
 	return err;
 }
 EXPORT_SYMBOL_GPL(blkcipher_walk_done);
diff --git a/crypto/cts.c b/crypto/cts.c
index 60b9da3fa7c1..bd9405820e8a 100644
--- a/crypto/cts.c
+++ b/crypto/cts.c
@@ -202,7 +202,8 @@ static int cts_cbc_decrypt(struct crypto_cts_ctx *ctx,
 	/* 5. Append the tail (BB - Ln) bytes of Xn (tmp) to Cn to create En */
 	memcpy(s + bsize + lastn, tmp + lastn, bsize - lastn);
 	/* 6. Decrypt En to create Pn-1 */
-	memset(iv, 0, sizeof(iv));
+	memzero_explicit(iv, sizeof(iv));
+
 	sg_set_buf(&sgsrc[0], s + bsize, bsize);
 	sg_set_buf(&sgdst[0], d, bsize);
 	err =3D crypto_blkcipher_decrypt_iv(&lcldesc, sgdst, sgsrc, bsize);
diff --git a/crypto/sha1_generic.c b/crypto/sha1_generic.c
index fdf7c00de4b0..a3e50c37eb6f 100644
--- a/crypto/sha1_generic.c
+++ b/crypto/sha1_generic.c
@@ -64,7 +64,7 @@ int crypto_sha1_update(struct shash_desc *desc, const u8 =
*data,
 			src =3D data + done;
 		} while (done + SHA1_BLOCK_SIZE <=3D len);
=20
-		memset(temp, 0, sizeof(temp));
+		memzero_explicit(temp, sizeof(temp));
 		partial =3D 0;
 	}
 	memcpy(sctx->buffer + partial, src, len - done);
diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
index 136381bdd48d..cde0361b9075 100644
--- a/crypto/sha256_generic.c
+++ b/crypto/sha256_generic.c
@@ -210,10 +210,9 @@ static void sha256_transform(u32 *state, const u8 *inp=
ut)
=20
 	/* clear any sensitive info... */
 	a =3D b =3D c =3D d =3D e =3D f =3D g =3D h =3D t1 =3D t2 =3D 0;
-	memset(W, 0, 64 * sizeof(u32));
+	memzero_explicit(W, 64 * sizeof(u32));
 }
=20
-
 static int sha224_init(struct shash_desc *desc)
 {
 	struct sha256_state *sctx =3D shash_desc_ctx(desc);
@@ -316,7 +315,7 @@ static int sha224_final(struct shash_desc *desc, u8 *ha=
sh)
 	sha256_final(desc, D);
=20
 	memcpy(hash, D, SHA224_DIGEST_SIZE);
-	memset(D, 0, SHA256_DIGEST_SIZE);
+	memzero_explicit(D, SHA256_DIGEST_SIZE);
=20
 	return 0;
 }
diff --git a/crypto/sha512_generic.c b/crypto/sha512_generic.c
index 6c6d901a7cc1..d350854eba7e 100644
--- a/crypto/sha512_generic.c
+++ b/crypto/sha512_generic.c
@@ -238,7 +238,7 @@ static int sha384_final(struct shash_desc *desc, u8 *ha=
sh)
 	sha512_final(desc, D);
=20
 	memcpy(hash, D, 48);
-	memset(D, 0, 64);
+	memzero_explicit(D, 64);
=20
 	return 0;
 }
diff --git a/crypto/tgr192.c b/crypto/tgr192.c
index f7ed2fba396c..321bc6ff2a9d 100644
--- a/crypto/tgr192.c
+++ b/crypto/tgr192.c
@@ -612,7 +612,7 @@ static int tgr160_final(struct shash_desc *desc, u8 * o=
ut)
=20
 	tgr192_final(desc, D);
 	memcpy(out, D, TGR160_DIGEST_SIZE);
-	memset(D, 0, TGR192_DIGEST_SIZE);
+	memzero_explicit(D, TGR192_DIGEST_SIZE);
=20
 	return 0;
 }
@@ -623,7 +623,7 @@ static int tgr128_final(struct shash_desc *desc, u8 * o=
ut)
=20
 	tgr192_final(desc, D);
 	memcpy(out, D, TGR128_DIGEST_SIZE);
-	memset(D, 0, TGR192_DIGEST_SIZE);
+	memzero_explicit(D, TGR192_DIGEST_SIZE);
=20
 	return 0;
 }
diff --git a/crypto/vmac.c b/crypto/vmac.c
index bf2d3a89845f..bb2fc787d615 100644
--- a/crypto/vmac.c
+++ b/crypto/vmac.c
@@ -1,6 +1,10 @@
 /*
- * Modified to interface to the Linux kernel
+ * VMAC: Message Authentication Code using Universal Hashing
+ *
+ * Reference: https://tools.ietf.org/html/draft-krovetz-vmac-01
+ *
  * Copyright (c) 2009, Intel Corporation.
+ * Copyright (c) 2018, Google Inc.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -16,14 +20,15 @@
  * Place - Suite 330, Boston, MA 02111-1307 USA.
  */
=20
-/* -----------------------------------------------------------------------=
---
- * VMAC and VHASH Implementation by Ted Krovetz (tdk@acm.org) and Wei Dai.
- * This implementation is herby placed in the public domain.
- * The authors offers no warranty. Use at your own risk.
- * Please send bug reports to the authors.
- * Last modified: 17 APR 08, 1700 PDT
- * -----------------------------------------------------------------------=
 */
+/*
+ * Derived from:
+ *	VMAC and VHASH Implementation by Ted Krovetz (tdk@acm.org) and Wei Dai.
+ *	This implementation is herby placed in the public domain.
+ *	The authors offers no warranty. Use at your own risk.
+ *	Last modified: 17 APR 08, 1700 PDT
+ */
=20
+#include <asm/unaligned.h>
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/crypto.h>
@@ -31,9 +36,35 @@
 #include <linux/scatterlist.h>
 #include <asm/byteorder.h>
 #include <crypto/scatterwalk.h>
-#include <crypto/vmac.h>
 #include <crypto/internal/hash.h>
=20
+/*
+ * User definable settings.
+ */
+#define VMAC_TAG_LEN	64
+#define VMAC_KEY_SIZE	128/* Must be 128, 192 or 256			*/
+#define VMAC_KEY_LEN	(VMAC_KEY_SIZE/8)
+#define VMAC_NHBYTES	128/* Must 2^i for any 3 < i < 13 Standard =3D 128*/
+
+/* per-transform (per-key) context */
+struct vmac_tfm_ctx {
+	struct crypto_cipher *cipher;
+	u64 nhkey[(VMAC_NHBYTES/8)+2*(VMAC_TAG_LEN/64-1)];
+	u64 polykey[2*VMAC_TAG_LEN/64];
+	u64 l3key[2*VMAC_TAG_LEN/64];
+};
+
+/* per-request context */
+struct vmac_desc_ctx {
+	union {
+		u8 partial[VMAC_NHBYTES];	/* partial block */
+		__le64 partial_words[VMAC_NHBYTES / 8];
+	};
+	unsigned int partial_size;	/* size of the partial block */
+	bool first_block_processed;
+	u64 polytmp[2*VMAC_TAG_LEN/64];	/* running total of L2-hash */
+};
+
 /*
  * Constants and masks
  */
@@ -318,13 +349,6 @@ static void poly_step_func(u64 *ahi, u64 *alo,
 	} while (0)
 #endif
=20
-static void vhash_abort(struct vmac_ctx *ctx)
-{
-	ctx->polytmp[0] =3D ctx->polykey[0] ;
-	ctx->polytmp[1] =3D ctx->polykey[1] ;
-	ctx->first_block_processed =3D 0;
-}
-
 static u64 l3hash(u64 p1, u64 p2, u64 k1, u64 k2, u64 len)
 {
 	u64 rh, rl, t, z =3D 0;
@@ -364,280 +388,209 @@ static u64 l3hash(u64 p1, u64 p2, u64 k1, u64 k2, u=
64 len)
 	return rl;
 }
=20
-static void vhash_update(const unsigned char *m,
-			unsigned int mbytes, /* Pos multiple of VMAC_NHBYTES */
-			struct vmac_ctx *ctx)
+/* L1 and L2-hash one or more VMAC_NHBYTES-byte blocks */
+static void vhash_blocks(const struct vmac_tfm_ctx *tctx,
+			 struct vmac_desc_ctx *dctx,
+			 const __le64 *mptr, unsigned int blocks)
 {
-	u64 rh, rl, *mptr;
-	const u64 *kptr =3D (u64 *)ctx->nhkey;
-	int i;
-	u64 ch, cl;
-	u64 pkh =3D ctx->polykey[0];
-	u64 pkl =3D ctx->polykey[1];
-
-	if (!mbytes)
-		return;
-
-	BUG_ON(mbytes % VMAC_NHBYTES);
-
-	mptr =3D (u64 *)m;
-	i =3D mbytes / VMAC_NHBYTES;  /* Must be non-zero */
-
-	ch =3D ctx->polytmp[0];
-	cl =3D ctx->polytmp[1];
-
-	if (!ctx->first_block_processed) {
-		ctx->first_block_processed =3D 1;
+	const u64 *kptr =3D tctx->nhkey;
+	const u64 pkh =3D tctx->polykey[0];
+	const u64 pkl =3D tctx->polykey[1];
+	u64 ch =3D dctx->polytmp[0];
+	u64 cl =3D dctx->polytmp[1];
+	u64 rh, rl;
+
+	if (!dctx->first_block_processed) {
+		dctx->first_block_processed =3D true;
 		nh_vmac_nhbytes(mptr, kptr, VMAC_NHBYTES/8, rh, rl);
 		rh &=3D m62;
 		ADD128(ch, cl, rh, rl);
 		mptr +=3D (VMAC_NHBYTES/sizeof(u64));
-		i--;
+		blocks--;
 	}
=20
-	while (i--) {
+	while (blocks--) {
 		nh_vmac_nhbytes(mptr, kptr, VMAC_NHBYTES/8, rh, rl);
 		rh &=3D m62;
 		poly_step(ch, cl, pkh, pkl, rh, rl);
 		mptr +=3D (VMAC_NHBYTES/sizeof(u64));
 	}
=20
-	ctx->polytmp[0] =3D ch;
-	ctx->polytmp[1] =3D cl;
+	dctx->polytmp[0] =3D ch;
+	dctx->polytmp[1] =3D cl;
 }
=20
-static u64 vhash(unsigned char m[], unsigned int mbytes,
-			u64 *tagl, struct vmac_ctx *ctx)
+static int vmac_setkey(struct crypto_shash *tfm,
+		       const u8 *key, unsigned int keylen)
 {
-	u64 rh, rl, *mptr;
-	const u64 *kptr =3D (u64 *)ctx->nhkey;
-	int i, remaining;
-	u64 ch, cl;
-	u64 pkh =3D ctx->polykey[0];
-	u64 pkl =3D ctx->polykey[1];
-
-	mptr =3D (u64 *)m;
-	i =3D mbytes / VMAC_NHBYTES;
-	remaining =3D mbytes % VMAC_NHBYTES;
-
-	if (ctx->first_block_processed) {
-		ch =3D ctx->polytmp[0];
-		cl =3D ctx->polytmp[1];
-	} else if (i) {
-		nh_vmac_nhbytes(mptr, kptr, VMAC_NHBYTES/8, ch, cl);
-		ch &=3D m62;
-		ADD128(ch, cl, pkh, pkl);
-		mptr +=3D (VMAC_NHBYTES/sizeof(u64));
-		i--;
-	} else if (remaining) {
-		nh_16(mptr, kptr, 2*((remaining+15)/16), ch, cl);
-		ch &=3D m62;
-		ADD128(ch, cl, pkh, pkl);
-		mptr +=3D (VMAC_NHBYTES/sizeof(u64));
-		goto do_l3;
-	} else {/* Empty String */
-		ch =3D pkh; cl =3D pkl;
-		goto do_l3;
-	}
-
-	while (i--) {
-		nh_vmac_nhbytes(mptr, kptr, VMAC_NHBYTES/8, rh, rl);
-		rh &=3D m62;
-		poly_step(ch, cl, pkh, pkl, rh, rl);
-		mptr +=3D (VMAC_NHBYTES/sizeof(u64));
-	}
-	if (remaining) {
-		nh_16(mptr, kptr, 2*((remaining+15)/16), rh, rl);
-		rh &=3D m62;
-		poly_step(ch, cl, pkh, pkl, rh, rl);
-	}
-
-do_l3:
-	vhash_abort(ctx);
-	remaining *=3D 8;
-	return l3hash(ch, cl, ctx->l3key[0], ctx->l3key[1], remaining);
-}
+	struct vmac_tfm_ctx *tctx =3D crypto_shash_ctx(tfm);
+	__be64 out[2];
+	u8 in[16] =3D { 0 };
+	unsigned int i;
+	int err;
=20
-static u64 vmac(unsigned char m[], unsigned int mbytes,
-			const unsigned char n[16], u64 *tagl,
-			struct vmac_ctx_t *ctx)
-{
-	u64 *in_n, *out_p;
-	u64 p, h;
-	int i;
-
-	in_n =3D ctx->__vmac_ctx.cached_nonce;
-	out_p =3D ctx->__vmac_ctx.cached_aes;
-
-	i =3D n[15] & 1;
-	if ((*(u64 *)(n+8) !=3D in_n[1]) || (*(u64 *)(n) !=3D in_n[0])) {
-		in_n[0] =3D *(u64 *)(n);
-		in_n[1] =3D *(u64 *)(n+8);
-		((unsigned char *)in_n)[15] &=3D 0xFE;
-		crypto_cipher_encrypt_one(ctx->child,
-			(unsigned char *)out_p, (unsigned char *)in_n);
-
-		((unsigned char *)in_n)[15] |=3D (unsigned char)(1-i);
+	if (keylen !=3D VMAC_KEY_LEN) {
+		crypto_shash_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
+		return -EINVAL;
 	}
-	p =3D be64_to_cpup(out_p + i);
-	h =3D vhash(m, mbytes, (u64 *)0, &ctx->__vmac_ctx);
-	return le64_to_cpu(p + h);
-}
=20
-static int vmac_set_key(unsigned char user_key[], struct vmac_ctx_t *ctx)
-{
-	u64 in[2] =3D {0}, out[2];
-	unsigned i;
-	int err =3D 0;
-
-	err =3D crypto_cipher_setkey(ctx->child, user_key, VMAC_KEY_LEN);
+	err =3D crypto_cipher_setkey(tctx->cipher, key, keylen);
 	if (err)
 		return err;
=20
 	/* Fill nh key */
-	((unsigned char *)in)[0] =3D 0x80;
-	for (i =3D 0; i < sizeof(ctx->__vmac_ctx.nhkey)/8; i +=3D 2) {
-		crypto_cipher_encrypt_one(ctx->child,
-			(unsigned char *)out, (unsigned char *)in);
-		ctx->__vmac_ctx.nhkey[i] =3D be64_to_cpup(out);
-		ctx->__vmac_ctx.nhkey[i+1] =3D be64_to_cpup(out+1);
-		((unsigned char *)in)[15] +=3D 1;
+	in[0] =3D 0x80;
+	for (i =3D 0; i < ARRAY_SIZE(tctx->nhkey); i +=3D 2) {
+		crypto_cipher_encrypt_one(tctx->cipher, (u8 *)out, in);
+		tctx->nhkey[i] =3D be64_to_cpu(out[0]);
+		tctx->nhkey[i+1] =3D be64_to_cpu(out[1]);
+		in[15]++;
 	}
=20
 	/* Fill poly key */
-	((unsigned char *)in)[0] =3D 0xC0;
-	in[1] =3D 0;
-	for (i =3D 0; i < sizeof(ctx->__vmac_ctx.polykey)/8; i +=3D 2) {
-		crypto_cipher_encrypt_one(ctx->child,
-			(unsigned char *)out, (unsigned char *)in);
-		ctx->__vmac_ctx.polytmp[i] =3D
-			ctx->__vmac_ctx.polykey[i] =3D
-				be64_to_cpup(out) & mpoly;
-		ctx->__vmac_ctx.polytmp[i+1] =3D
-			ctx->__vmac_ctx.polykey[i+1] =3D
-				be64_to_cpup(out+1) & mpoly;
-		((unsigned char *)in)[15] +=3D 1;
+	in[0] =3D 0xC0;
+	in[15] =3D 0;
+	for (i =3D 0; i < ARRAY_SIZE(tctx->polykey); i +=3D 2) {
+		crypto_cipher_encrypt_one(tctx->cipher, (u8 *)out, in);
+		tctx->polykey[i] =3D be64_to_cpu(out[0]) & mpoly;
+		tctx->polykey[i+1] =3D be64_to_cpu(out[1]) & mpoly;
+		in[15]++;
 	}
=20
 	/* Fill ip key */
-	((unsigned char *)in)[0] =3D 0xE0;
-	in[1] =3D 0;
-	for (i =3D 0; i < sizeof(ctx->__vmac_ctx.l3key)/8; i +=3D 2) {
+	in[0] =3D 0xE0;
+	in[15] =3D 0;
+	for (i =3D 0; i < ARRAY_SIZE(tctx->l3key); i +=3D 2) {
 		do {
-			crypto_cipher_encrypt_one(ctx->child,
-				(unsigned char *)out, (unsigned char *)in);
-			ctx->__vmac_ctx.l3key[i] =3D be64_to_cpup(out);
-			ctx->__vmac_ctx.l3key[i+1] =3D be64_to_cpup(out+1);
-			((unsigned char *)in)[15] +=3D 1;
-		} while (ctx->__vmac_ctx.l3key[i] >=3D p64
-			|| ctx->__vmac_ctx.l3key[i+1] >=3D p64);
+			crypto_cipher_encrypt_one(tctx->cipher, (u8 *)out, in);
+			tctx->l3key[i] =3D be64_to_cpu(out[0]);
+			tctx->l3key[i+1] =3D be64_to_cpu(out[1]);
+			in[15]++;
+		} while (tctx->l3key[i] >=3D p64 || tctx->l3key[i+1] >=3D p64);
 	}
=20
-	/* Invalidate nonce/aes cache and reset other elements */
-	ctx->__vmac_ctx.cached_nonce[0] =3D (u64)-1; /* Ensure illegal nonce */
-	ctx->__vmac_ctx.cached_nonce[1] =3D (u64)0;  /* Ensure illegal nonce */
-	ctx->__vmac_ctx.first_block_processed =3D 0;
-
-	return err;
+	return 0;
 }
=20
-static int vmac_setkey(struct crypto_shash *parent,
-		const u8 *key, unsigned int keylen)
+static int vmac_init(struct shash_desc *desc)
 {
-	struct vmac_ctx_t *ctx =3D crypto_shash_ctx(parent);
+	const struct vmac_tfm_ctx *tctx =3D crypto_shash_ctx(desc->tfm);
+	struct vmac_desc_ctx *dctx =3D shash_desc_ctx(desc);
=20
-	if (keylen !=3D VMAC_KEY_LEN) {
-		crypto_shash_set_flags(parent, CRYPTO_TFM_RES_BAD_KEY_LEN);
-		return -EINVAL;
-	}
-
-	return vmac_set_key((u8 *)key, ctx);
-}
-
-static int vmac_init(struct shash_desc *pdesc)
-{
+	dctx->partial_size =3D 0;
+	dctx->first_block_processed =3D false;
+	memcpy(dctx->polytmp, tctx->polykey, sizeof(dctx->polytmp));
 	return 0;
 }
=20
-static int vmac_update(struct shash_desc *pdesc, const u8 *p,
-		unsigned int len)
+static int vmac_update(struct shash_desc *desc, const u8 *p, unsigned int =
len)
 {
-	struct crypto_shash *parent =3D pdesc->tfm;
-	struct vmac_ctx_t *ctx =3D crypto_shash_ctx(parent);
-	int expand;
-	int min;
-
-	expand =3D VMAC_NHBYTES - ctx->partial_size > 0 ?
-			VMAC_NHBYTES - ctx->partial_size : 0;
-
-	min =3D len < expand ? len : expand;
-
-	memcpy(ctx->partial + ctx->partial_size, p, min);
-	ctx->partial_size +=3D min;
-
-	if (len < expand)
-		return 0;
-
-	vhash_update(ctx->partial, VMAC_NHBYTES, &ctx->__vmac_ctx);
-	ctx->partial_size =3D 0;
-
-	len -=3D expand;
-	p +=3D expand;
+	const struct vmac_tfm_ctx *tctx =3D crypto_shash_ctx(desc->tfm);
+	struct vmac_desc_ctx *dctx =3D shash_desc_ctx(desc);
+	unsigned int n;
+
+	if (dctx->partial_size) {
+		n =3D min(len, VMAC_NHBYTES - dctx->partial_size);
+		memcpy(&dctx->partial[dctx->partial_size], p, n);
+		dctx->partial_size +=3D n;
+		p +=3D n;
+		len -=3D n;
+		if (dctx->partial_size =3D=3D VMAC_NHBYTES) {
+			vhash_blocks(tctx, dctx, dctx->partial_words, 1);
+			dctx->partial_size =3D 0;
+		}
+	}
=20
-	if (len % VMAC_NHBYTES) {
-		memcpy(ctx->partial, p + len - (len % VMAC_NHBYTES),
-			len % VMAC_NHBYTES);
-		ctx->partial_size =3D len % VMAC_NHBYTES;
+	if (len >=3D VMAC_NHBYTES) {
+		n =3D round_down(len, VMAC_NHBYTES);
+		/* TODO: 'p' may be misaligned here */
+		vhash_blocks(tctx, dctx, (const __le64 *)p, n / VMAC_NHBYTES);
+		p +=3D n;
+		len -=3D n;
 	}
=20
-	vhash_update(p, len - len % VMAC_NHBYTES, &ctx->__vmac_ctx);
+	if (len) {
+		memcpy(dctx->partial, p, len);
+		dctx->partial_size =3D len;
+	}
=20
 	return 0;
 }
=20
-static int vmac_final(struct shash_desc *pdesc, u8 *out)
+static u64 vhash_final(const struct vmac_tfm_ctx *tctx,
+		       struct vmac_desc_ctx *dctx)
 {
-	struct crypto_shash *parent =3D pdesc->tfm;
-	struct vmac_ctx_t *ctx =3D crypto_shash_ctx(parent);
-	vmac_t mac;
-	u8 nonce[16] =3D {};
-
-	/* vmac() ends up accessing outside the array bounds that
-	 * we specify.  In appears to access up to the next 2-word
-	 * boundary.  We'll just be uber cautious and zero the
-	 * unwritten bytes in the buffer.
-	 */
-	if (ctx->partial_size) {
-		memset(ctx->partial + ctx->partial_size, 0,
-			VMAC_NHBYTES - ctx->partial_size);
+	unsigned int partial =3D dctx->partial_size;
+	u64 ch =3D dctx->polytmp[0];
+	u64 cl =3D dctx->polytmp[1];
+
+	/* L1 and L2-hash the final block if needed */
+	if (partial) {
+		/* Zero-pad to next 128-bit boundary */
+		unsigned int n =3D round_up(partial, 16);
+		u64 rh, rl;
+
+		memset(&dctx->partial[partial], 0, n - partial);
+		nh_16(dctx->partial_words, tctx->nhkey, n / 8, rh, rl);
+		rh &=3D m62;
+		if (dctx->first_block_processed)
+			poly_step(ch, cl, tctx->polykey[0], tctx->polykey[1],
+				  rh, rl);
+		else
+			ADD128(ch, cl, rh, rl);
 	}
-	mac =3D vmac(ctx->partial, ctx->partial_size, nonce, NULL, ctx);
-	memcpy(out, &mac, sizeof(vmac_t));
-	memset(&mac, 0, sizeof(vmac_t));
-	memset(&ctx->__vmac_ctx, 0, sizeof(struct vmac_ctx));
-	ctx->partial_size =3D 0;
+
+	/* L3-hash the 128-bit output of L2-hash */
+	return l3hash(ch, cl, tctx->l3key[0], tctx->l3key[1], partial * 8);
+}
+
+static int vmac_final(struct shash_desc *desc, u8 *out)
+{
+	const struct vmac_tfm_ctx *tctx =3D crypto_shash_ctx(desc->tfm);
+	struct vmac_desc_ctx *dctx =3D shash_desc_ctx(desc);
+	static const u8 nonce[16] =3D {}; /* TODO: this is insecure */
+	union {
+		u8 bytes[16];
+		__be64 pads[2];
+	} block;
+	int index;
+	u64 hash, pad;
+
+	/* Finish calculating the VHASH of the message */
+	hash =3D vhash_final(tctx, dctx);
+
+	/* Generate pseudorandom pad by encrypting the nonce */
+	memcpy(&block, nonce, 16);
+	index =3D block.bytes[15] & 1;
+	block.bytes[15] &=3D ~1;
+	crypto_cipher_encrypt_one(tctx->cipher, block.bytes, block.bytes);
+	pad =3D be64_to_cpu(block.pads[index]);
+
+	/* The VMAC is the sum of VHASH and the pseudorandom pad */
+	put_unaligned_le64(hash + pad, out);
 	return 0;
 }
=20
 static int vmac_init_tfm(struct crypto_tfm *tfm)
 {
-	struct crypto_cipher *cipher;
-	struct crypto_instance *inst =3D (void *)tfm->__crt_alg;
+	struct crypto_instance *inst =3D crypto_tfm_alg_instance(tfm);
 	struct crypto_spawn *spawn =3D crypto_instance_ctx(inst);
-	struct vmac_ctx_t *ctx =3D crypto_tfm_ctx(tfm);
+	struct vmac_tfm_ctx *tctx =3D crypto_tfm_ctx(tfm);
+	struct crypto_cipher *cipher;
=20
 	cipher =3D crypto_spawn_cipher(spawn);
 	if (IS_ERR(cipher))
 		return PTR_ERR(cipher);
=20
-	ctx->child =3D cipher;
+	tctx->cipher =3D cipher;
 	return 0;
 }
=20
 static void vmac_exit_tfm(struct crypto_tfm *tfm)
 {
-	struct vmac_ctx_t *ctx =3D crypto_tfm_ctx(tfm);
-	crypto_free_cipher(ctx->child);
+	struct vmac_tfm_ctx *tctx =3D crypto_tfm_ctx(tfm);
+
+	crypto_free_cipher(tctx->cipher);
 }
=20
 static int vmac_create(struct crypto_template *tmpl, struct rtattr **tb)
@@ -655,6 +608,10 @@ static int vmac_create(struct crypto_template *tmpl, s=
truct rtattr **tb)
 	if (IS_ERR(alg))
 		return PTR_ERR(alg);
=20
+	err =3D -EINVAL;
+	if (alg->cra_blocksize !=3D 16)
+		goto out_put_alg;
+
 	inst =3D shash_alloc_instance("vmac", alg);
 	err =3D PTR_ERR(inst);
 	if (IS_ERR(inst))
@@ -670,11 +627,12 @@ static int vmac_create(struct crypto_template *tmpl, =
struct rtattr **tb)
 	inst->alg.base.cra_blocksize =3D alg->cra_blocksize;
 	inst->alg.base.cra_alignmask =3D alg->cra_alignmask;
=20
-	inst->alg.digestsize =3D sizeof(vmac_t);
-	inst->alg.base.cra_ctxsize =3D sizeof(struct vmac_ctx_t);
+	inst->alg.base.cra_ctxsize =3D sizeof(struct vmac_tfm_ctx);
 	inst->alg.base.cra_init =3D vmac_init_tfm;
 	inst->alg.base.cra_exit =3D vmac_exit_tfm;
=20
+	inst->alg.descsize =3D sizeof(struct vmac_desc_ctx);
+	inst->alg.digestsize =3D VMAC_TAG_LEN / 8;
 	inst->alg.init =3D vmac_init;
 	inst->alg.update =3D vmac_update;
 	inst->alg.final =3D vmac_final;
diff --git a/crypto/wp512.c b/crypto/wp512.c
index 253db94b5479..7ee5a043a988 100644
--- a/crypto/wp512.c
+++ b/crypto/wp512.c
@@ -1102,8 +1102,8 @@ static int wp384_final(struct shash_desc *desc, u8 *o=
ut)
 	u8 D[64];
=20
 	wp512_final(desc, D);
-	memcpy (out, D, WP384_DIGEST_SIZE);
-	memset (D, 0, WP512_DIGEST_SIZE);
+	memcpy(out, D, WP384_DIGEST_SIZE);
+	memzero_explicit(D, WP512_DIGEST_SIZE);
=20
 	return 0;
 }
@@ -1113,8 +1113,8 @@ static int wp256_final(struct shash_desc *desc, u8 *o=
ut)
 	u8 D[64];
=20
 	wp512_final(desc, D);
-	memcpy (out, D, WP256_DIGEST_SIZE);
-	memset (D, 0, WP512_DIGEST_SIZE);
+	memcpy(out, D, WP256_DIGEST_SIZE);
+	memzero_explicit(D, WP512_DIGEST_SIZE);
=20
 	return 0;
 }
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 60a38349f297..244ff338e5c9 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -36,10 +36,10 @@
 #include <linux/regulator/machine.h>
 #ifdef CONFIG_X86
 #include <asm/mpspec.h>
+#include <linux/dmi.h>
 #endif
 #include <linux/pci.h>
 #include <acpi/apei.h>
-#include <linux/dmi.h>
 #include <linux/suspend.h>
=20
 #include "internal.h"
@@ -82,10 +82,6 @@ static struct dmi_system_id dsdt_dmi_table[] __initdata =
=3D {
 	},
 	{}
 };
-#else
-static struct dmi_system_id dsdt_dmi_table[] __initdata =3D {
-	{}
-};
 #endif
=20
 /* -----------------------------------------------------------------------=
---
@@ -508,11 +504,16 @@ void __init acpi_early_init(void)
=20
 	acpi_gbl_permanent_mmap =3D 1;
=20
+#ifdef CONFIG_X86
 	/*
 	 * If the machine falls into the DMI check table,
-	 * DSDT will be copied to memory
+	 * DSDT will be copied to memory.
+	 * Note that calling dmi_check_system() here on other architectures
+	 * would not be OK because only x86 initializes dmi early enough.
+	 * Thankfully only x86 systems need such quirks for now.
 	 */
 	dmi_check_system(dsdt_dmi_table);
+#endif
=20
 	status =3D acpi_reallocate_root_table();
 	if (ACPI_FAILURE(status)) {
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3fc787a02fa0..8c8dcf6c4023 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1336,8 +1336,10 @@ static int __device_suspend(struct device *dev, pm_m=
essage_t state, bool async)
=20
 	dpm_wait_for_children(dev, async);
=20
-	if (async_error)
+	if (async_error) {
+		dev->power.direct_complete =3D false;
 		goto Complete;
+	}
=20
 	/*
 	 * If a device configured to wake up the system from sleep states
@@ -1349,6 +1351,7 @@ static int __device_suspend(struct device *dev, pm_me=
ssage_t state, bool async)
 		pm_wakeup_event(dev, 0);
=20
 	if (pm_wakeup_pending()) {
+		dev->power.direct_complete =3D false;
 		async_error =3D -EBUSY;
 		goto Complete;
 	}
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a1ecedfc9d39..d8ab5c040749 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -667,6 +667,9 @@ static int __nbd_ioctl(struct block_device *bdev, struc=
t nbd_device *nbd,
 	}
=20
 	case NBD_SET_BLKSIZE:
+		if (!arg || !is_power_of_2(arg) || arg < 512 ||
+		    arg > PAGE_SIZE)
+			return -EINVAL;
 		nbd->blksize =3D arg;
 		nbd->bytesize &=3D ~(nbd->blksize-1);
 		bdev->bd_inode->i_size =3D nbd->bytesize;
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index c61de6df44b0..6fd7e418924a 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -2427,7 +2427,7 @@ static int cdrom_ioctl_select_disc(struct cdrom_devic=
e_info *cdi,
 		return -ENOSYS;
=20
 	if (arg !=3D CDSL_CURRENT && arg !=3D CDSL_NONE) {
-		if ((int)arg >=3D cdi->capacity)
+		if (arg >=3D cdi->capacity)
 			return -EINVAL;
 	}
=20
diff --git a/drivers/char/ipmi/ipmi_bt_sm.c b/drivers/char/ipmi/ipmi_bt_sm.c
index 84b5c746124c..6fae34fcf8b7 100644
--- a/drivers/char/ipmi/ipmi_bt_sm.c
+++ b/drivers/char/ipmi/ipmi_bt_sm.c
@@ -31,6 +31,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/ipmi_msgdefs.h>		/* for completion codes */
+#include <linux/sched.h>
 #include "ipmi_si_sm.h"
=20
 #define BT_DEBUG_OFF	0	/* Used in production */
@@ -77,8 +78,6 @@ enum bt_states {
 	BT_STATE_RESET3,
 	BT_STATE_RESTART,
 	BT_STATE_PRINTME,
-	BT_STATE_CAPABILITIES_BEGIN,
-	BT_STATE_CAPABILITIES_END,
 	BT_STATE_LONG_BUSY	/* BT doesn't get hosed :-) */
 };
=20
@@ -104,7 +103,6 @@ struct si_sm_data {
 	int		error_retries;	/* end of "common" fields */
 	int		nonzero_status;	/* hung BMCs stay all 0 */
 	enum bt_states	complete;	/* to divert the state machine */
-	int		BT_CAP_outreqs;
 	long		BT_CAP_req2rsp;
 	int		BT_CAP_retries;	/* Recommended retries */
 };
@@ -155,8 +153,6 @@ static char *state2txt(unsigned char state)
 	case BT_STATE_RESET3:		return("RESET3");
 	case BT_STATE_RESTART:		return("RESTART");
 	case BT_STATE_LONG_BUSY:	return("LONG_BUSY");
-	case BT_STATE_CAPABILITIES_BEGIN: return("CAP_BEGIN");
-	case BT_STATE_CAPABILITIES_END:	return("CAP_END");
 	}
 	return("BAD STATE");
 }
@@ -203,7 +199,6 @@ static unsigned int bt_init_data(struct si_sm_data *bt,=
 struct si_sm_io *io)
 	bt->complete =3D BT_STATE_IDLE;	/* end here */
 	bt->BT_CAP_req2rsp =3D BT_NORMAL_TIMEOUT * USEC_PER_SEC;
 	bt->BT_CAP_retries =3D BT_NORMAL_RETRY_LIMIT;
-	/* BT_CAP_outreqs =3D=3D zero is a flag to read BT Capabilities */
 	return 3; /* We claim 3 bytes of space; ought to check SPMI table */
 }
=20
@@ -469,7 +464,7 @@ static enum si_sm_result error_recovery(struct si_sm_da=
ta *bt,
=20
 static enum si_sm_result bt_event(struct si_sm_data *bt, long time)
 {
-	unsigned char status, BT_CAP[8];
+	unsigned char status;
 	static enum bt_states last_printed =3D BT_STATE_PRINTME;
 	int i;
=20
@@ -522,12 +517,6 @@ static enum si_sm_result bt_event(struct si_sm_data *b=
t, long time)
 		if (status & BT_H_BUSY)		/* clear a leftover H_BUSY */
 			BT_CONTROL(BT_H_BUSY);
=20
-		bt->timeout =3D bt->BT_CAP_req2rsp;
-
-		/* Read BT capabilities if it hasn't been done yet */
-		if (!bt->BT_CAP_outreqs)
-			BT_STATE_CHANGE(BT_STATE_CAPABILITIES_BEGIN,
-					SI_SM_CALL_WITHOUT_DELAY);
 		BT_SI_SM_RETURN(SI_SM_IDLE);
=20
 	case BT_STATE_XACTION_START:
@@ -632,37 +621,6 @@ static enum si_sm_result bt_event(struct si_sm_data *b=
t, long time)
 		BT_STATE_CHANGE(BT_STATE_XACTION_START,
 				SI_SM_CALL_WITH_DELAY);
=20
-	/*
-	 * Get BT Capabilities, using timing of upper level state machine.
-	 * Set outreqs to prevent infinite loop on timeout.
-	 */
-	case BT_STATE_CAPABILITIES_BEGIN:
-		bt->BT_CAP_outreqs =3D 1;
-		{
-			unsigned char GetBT_CAP[] =3D { 0x18, 0x36 };
-			bt->state =3D BT_STATE_IDLE;
-			bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
-		}
-		bt->complete =3D BT_STATE_CAPABILITIES_END;
-		BT_STATE_CHANGE(BT_STATE_XACTION_START,
-				SI_SM_CALL_WITH_DELAY);
-
-	case BT_STATE_CAPABILITIES_END:
-		i =3D bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
-		bt_init_data(bt, bt->io);
-		if ((i =3D=3D 8) && !BT_CAP[2]) {
-			bt->BT_CAP_outreqs =3D BT_CAP[3];
-			bt->BT_CAP_req2rsp =3D BT_CAP[6] * USEC_PER_SEC;
-			bt->BT_CAP_retries =3D BT_CAP[7];
-		} else
-			printk(KERN_WARNING "IPMI BT: using default values\n");
-		if (!bt->BT_CAP_outreqs)
-			bt->BT_CAP_outreqs =3D 1;
-		printk(KERN_WARNING "IPMI BT: req2rsp=3D%ld secs retries=3D%d\n",
-			bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
-		bt->timeout =3D bt->BT_CAP_req2rsp;
-		return SI_SM_CALL_WITHOUT_DELAY;
-
 	default:	/* should never occur */
 		return error_recovery(bt,
 				      status,
@@ -673,6 +631,11 @@ static enum si_sm_result bt_event(struct si_sm_data *b=
t, long time)
=20
 static int bt_detect(struct si_sm_data *bt)
 {
+	unsigned char GetBT_CAP[] =3D { 0x18, 0x36 };
+	unsigned char BT_CAP[8];
+	enum si_sm_result smi_result;
+	int rv;
+
 	/*
 	 * It's impossible for the BT status and interrupt registers to be
 	 * all 1's, (assuming a properly functioning, self-initialized BMC)
@@ -683,6 +646,47 @@ static int bt_detect(struct si_sm_data *bt)
 	if ((BT_STATUS =3D=3D 0xFF) && (BT_INTMASK_R =3D=3D 0xFF))
 		return 1;
 	reset_flags(bt);
+
+	/*
+	 * Try getting the BT capabilities here.
+	 */
+	rv =3D bt_start_transaction(bt, GetBT_CAP, sizeof(GetBT_CAP));
+	if (rv) {
+		pr_warn("BT: Can't start capabilities transaction: %d\n", rv);
+		goto out_no_bt_cap;
+	}
+
+	smi_result =3D SI_SM_CALL_WITHOUT_DELAY;
+	for (;;) {
+		if (smi_result =3D=3D SI_SM_CALL_WITH_DELAY ||
+		    smi_result =3D=3D SI_SM_CALL_WITH_TICK_DELAY) {
+			schedule_timeout_uninterruptible(1);
+			smi_result =3D bt_event(bt, jiffies_to_usecs(1));
+		} else if (smi_result =3D=3D SI_SM_CALL_WITHOUT_DELAY) {
+			smi_result =3D bt_event(bt, 0);
+		} else
+			break;
+	}
+
+	rv =3D bt_get_result(bt, BT_CAP, sizeof(BT_CAP));
+	bt_init_data(bt, bt->io);
+	if (rv < 8) {
+		pr_warn("BT: bt cap response too short: %d\n", rv);
+		goto out_no_bt_cap;
+	}
+
+	if (BT_CAP[2]) {
+		pr_warn("BT: Error fetching bt cap: %x\n", BT_CAP[2]);
+out_no_bt_cap:
+		pr_warn("BT: using default values\n");
+	} else {
+		bt->BT_CAP_req2rsp =3D BT_CAP[6] * USEC_PER_SEC;
+		bt->BT_CAP_retries =3D BT_CAP[7];
+	}
+
+	pr_info("BT: req2rsp=3D%ld secs retries=3D%d\n",
+		 bt->BT_CAP_req2rsp / USEC_PER_SEC, bt->BT_CAP_retries);
+
 	return 0;
 }
=20
diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index b5f7e6db24d4..e94857e56c70 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -63,7 +63,7 @@ struct dcp {
 	struct dcp_coherent_block	*coh;
=20
 	struct completion		completion[DCP_MAX_CHANS];
-	struct mutex			mutex[DCP_MAX_CHANS];
+	spinlock_t			lock[DCP_MAX_CHANS];
 	struct task_struct		*thread[DCP_MAX_CHANS];
 	struct crypto_queue		queue[DCP_MAX_CHANS];
 };
@@ -349,13 +349,20 @@ static int dcp_chan_thread_aes(void *data)
=20
 	int ret;
=20
-	do {
-		__set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
=20
-		mutex_lock(&sdcp->mutex[chan]);
+		spin_lock(&sdcp->lock[chan]);
 		backlog =3D crypto_get_backlog(&sdcp->queue[chan]);
 		arq =3D crypto_dequeue_request(&sdcp->queue[chan]);
-		mutex_unlock(&sdcp->mutex[chan]);
+		spin_unlock(&sdcp->lock[chan]);
+
+		if (!backlog && !arq) {
+			schedule();
+			continue;
+		}
+
+		set_current_state(TASK_RUNNING);
=20
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
@@ -363,11 +370,8 @@ static int dcp_chan_thread_aes(void *data)
 		if (arq) {
 			ret =3D mxs_dcp_aes_block_crypt(arq);
 			arq->complete(arq, ret);
-			continue;
 		}
-
-		schedule();
-	} while (!kthread_should_stop());
+	}
=20
 	return 0;
 }
@@ -407,9 +411,9 @@ static int mxs_dcp_aes_enqueue(struct ablkcipher_reques=
t *req, int enc, int ecb)
 	rctx->ecb =3D ecb;
 	actx->chan =3D DCP_CHAN_CRYPTO;
=20
-	mutex_lock(&sdcp->mutex[actx->chan]);
+	spin_lock(&sdcp->lock[actx->chan]);
 	ret =3D crypto_enqueue_request(&sdcp->queue[actx->chan], &req->base);
-	mutex_unlock(&sdcp->mutex[actx->chan]);
+	spin_unlock(&sdcp->lock[actx->chan]);
=20
 	wake_up_process(sdcp->thread[actx->chan]);
=20
@@ -645,13 +649,20 @@ static int dcp_chan_thread_sha(void *data)
 	struct ahash_request *req;
 	int ret, fini;
=20
-	do {
-		__set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		set_current_state(TASK_INTERRUPTIBLE);
=20
-		mutex_lock(&sdcp->mutex[chan]);
+		spin_lock(&sdcp->lock[chan]);
 		backlog =3D crypto_get_backlog(&sdcp->queue[chan]);
 		arq =3D crypto_dequeue_request(&sdcp->queue[chan]);
-		mutex_unlock(&sdcp->mutex[chan]);
+		spin_unlock(&sdcp->lock[chan]);
+
+		if (!backlog && !arq) {
+			schedule();
+			continue;
+		}
+
+		set_current_state(TASK_RUNNING);
=20
 		if (backlog)
 			backlog->complete(backlog, -EINPROGRESS);
@@ -663,12 +674,8 @@ static int dcp_chan_thread_sha(void *data)
 			ret =3D dcp_sha_req_to_buf(arq);
 			fini =3D rctx->fini;
 			arq->complete(arq, ret);
-			if (!fini)
-				continue;
 		}
-
-		schedule();
-	} while (!kthread_should_stop());
+	}
=20
 	return 0;
 }
@@ -726,9 +733,9 @@ static int dcp_sha_update_fx(struct ahash_request *req,=
 int fini)
 		rctx->init =3D 1;
 	}
=20
-	mutex_lock(&sdcp->mutex[actx->chan]);
+	spin_lock(&sdcp->lock[actx->chan]);
 	ret =3D crypto_enqueue_request(&sdcp->queue[actx->chan], &req->base);
-	mutex_unlock(&sdcp->mutex[actx->chan]);
+	spin_unlock(&sdcp->lock[actx->chan]);
=20
 	wake_up_process(sdcp->thread[actx->chan]);
 	mutex_unlock(&actx->mutex);
@@ -984,7 +991,7 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sdcp);
=20
 	for (i =3D 0; i < DCP_MAX_CHANS; i++) {
-		mutex_init(&sdcp->mutex[i]);
+		spin_lock_init(&sdcp->lock[i]);
 		init_completion(&sdcp->completion[i]);
 		crypto_init_queue(&sdcp->queue[i], 50);
 	}
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index bffb263aa5d7..0cfe126f15fa 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -1161,14 +1161,14 @@ int __init edac_mc_sysfs_init(void)
=20
 	err =3D device_add(mci_pdev);
 	if (err < 0)
-		goto out_dev_free;
+		goto out_put_device;
=20
 	edac_dbg(0, "device %s created\n", dev_name(mci_pdev));
=20
 	return 0;
=20
- out_dev_free:
-	kfree(mci_pdev);
+ out_put_device:
+	put_device(mci_pdev);
  out_put_sysfs:
 	edac_put_sysfs_subsys();
  out:
diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
index f84ef75b6487..8f4ac40dd979 100644
--- a/drivers/edac/i7core_edac.c
+++ b/drivers/edac/i7core_edac.c
@@ -1177,7 +1177,7 @@ static int i7core_create_sysfs_devices(struct mem_ctl=
_info *mci)
=20
 	pvt->addrmatch_dev =3D kzalloc(sizeof(*pvt->addrmatch_dev), GFP_KERNEL);
 	if (!pvt->addrmatch_dev)
-		return rc;
+		return -ENOMEM;
=20
 	pvt->addrmatch_dev->type =3D &addrmatch_type;
 	pvt->addrmatch_dev->bus =3D mci->dev.bus;
@@ -1190,15 +1190,14 @@ static int i7core_create_sysfs_devices(struct mem_c=
tl_info *mci)
=20
 	rc =3D device_add(pvt->addrmatch_dev);
 	if (rc < 0)
-		return rc;
+		goto err_put_addrmatch;
=20
 	if (!pvt->is_registered) {
 		pvt->chancounts_dev =3D kzalloc(sizeof(*pvt->chancounts_dev),
 					      GFP_KERNEL);
 		if (!pvt->chancounts_dev) {
-			put_device(pvt->addrmatch_dev);
-			device_del(pvt->addrmatch_dev);
-			return rc;
+			rc =3D -ENOMEM;
+			goto err_del_addrmatch;
 		}
=20
 		pvt->chancounts_dev->type =3D &all_channel_counts_type;
@@ -1212,9 +1211,18 @@ static int i7core_create_sysfs_devices(struct mem_ct=
l_info *mci)
=20
 		rc =3D device_add(pvt->chancounts_dev);
 		if (rc < 0)
-			return rc;
+			goto err_put_chancounts;
 	}
 	return 0;
+
+err_put_chancounts:
+	put_device(pvt->chancounts_dev);
+err_del_addrmatch:
+	device_del(pvt->addrmatch_dev);
+err_put_addrmatch:
+	put_device(pvt->addrmatch_dev);
+
+	return rc;
 }
=20
 static void i7core_delete_sysfs_devices(struct mem_ctl_info *mci)
@@ -1229,11 +1237,11 @@ static void i7core_delete_sysfs_devices(struct mem_=
ctl_info *mci)
 	device_remove_file(&mci->dev, &dev_attr_inject_enable);
=20
 	if (!pvt->is_registered) {
-		put_device(pvt->chancounts_dev);
 		device_del(pvt->chancounts_dev);
+		put_device(pvt->chancounts_dev);
 	}
-	put_device(pvt->addrmatch_dev);
 	device_del(pvt->addrmatch_dev);
+	put_device(pvt->addrmatch_dev);
 }
=20
 /*************************************************************************=
***
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helpe=
r.c
index a61dcb35606d..9b12e0aae3fe 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -750,6 +750,25 @@ int drm_fb_helper_setcmap(struct fb_cmap *cmap, struct=
 fb_info *info)
 }
 EXPORT_SYMBOL(drm_fb_helper_setcmap);
=20
+static bool drm_fb_pixel_format_equal(const struct fb_var_screeninfo *var_=
1,
+				      const struct fb_var_screeninfo *var_2)
+{
+	return var_1->bits_per_pixel =3D=3D var_2->bits_per_pixel &&
+	       var_1->grayscale =3D=3D var_2->grayscale &&
+	       var_1->red.offset =3D=3D var_2->red.offset &&
+	       var_1->red.length =3D=3D var_2->red.length &&
+	       var_1->red.msb_right =3D=3D var_2->red.msb_right &&
+	       var_1->green.offset =3D=3D var_2->green.offset &&
+	       var_1->green.length =3D=3D var_2->green.length &&
+	       var_1->green.msb_right =3D=3D var_2->green.msb_right &&
+	       var_1->blue.offset =3D=3D var_2->blue.offset &&
+	       var_1->blue.length =3D=3D var_2->blue.length &&
+	       var_1->blue.msb_right =3D=3D var_2->blue.msb_right &&
+	       var_1->transp.offset =3D=3D var_2->transp.offset &&
+	       var_1->transp.length =3D=3D var_2->transp.length &&
+	       var_1->transp.msb_right =3D=3D var_2->transp.msb_right;
+}
+
 /**
  * drm_fb_helper_check_var - implementation for ->fb_check_var
  * @var: screeninfo to check
@@ -760,7 +779,6 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *v=
ar,
 {
 	struct drm_fb_helper *fb_helper =3D info->par;
 	struct drm_framebuffer *fb =3D fb_helper->fb;
-	int depth;
=20
 	if (var->pixclock !=3D 0 || in_dbg_master())
 		return -EINVAL;
@@ -777,72 +795,15 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo =
*var,
 		return -EINVAL;
 	}
=20
-	switch (var->bits_per_pixel) {
-	case 16:
-		depth =3D (var->green.length =3D=3D 6) ? 16 : 15;
-		break;
-	case 32:
-		depth =3D (var->transp.length > 0) ? 32 : 24;
-		break;
-	default:
-		depth =3D var->bits_per_pixel;
-		break;
-	}
-
-	switch (depth) {
-	case 8:
-		var->red.offset =3D 0;
-		var->green.offset =3D 0;
-		var->blue.offset =3D 0;
-		var->red.length =3D 8;
-		var->green.length =3D 8;
-		var->blue.length =3D 8;
-		var->transp.length =3D 0;
-		var->transp.offset =3D 0;
-		break;
-	case 15:
-		var->red.offset =3D 10;
-		var->green.offset =3D 5;
-		var->blue.offset =3D 0;
-		var->red.length =3D 5;
-		var->green.length =3D 5;
-		var->blue.length =3D 5;
-		var->transp.length =3D 1;
-		var->transp.offset =3D 15;
-		break;
-	case 16:
-		var->red.offset =3D 11;
-		var->green.offset =3D 5;
-		var->blue.offset =3D 0;
-		var->red.length =3D 5;
-		var->green.length =3D 6;
-		var->blue.length =3D 5;
-		var->transp.length =3D 0;
-		var->transp.offset =3D 0;
-		break;
-	case 24:
-		var->red.offset =3D 16;
-		var->green.offset =3D 8;
-		var->blue.offset =3D 0;
-		var->red.length =3D 8;
-		var->green.length =3D 8;
-		var->blue.length =3D 8;
-		var->transp.length =3D 0;
-		var->transp.offset =3D 0;
-		break;
-	case 32:
-		var->red.offset =3D 16;
-		var->green.offset =3D 8;
-		var->blue.offset =3D 0;
-		var->red.length =3D 8;
-		var->green.length =3D 8;
-		var->blue.length =3D 8;
-		var->transp.length =3D 8;
-		var->transp.offset =3D 24;
-		break;
-	default:
+	/*
+	 * drm fbdev emulation doesn't support changing the pixel format at all,
+	 * so reject all pixel format changing requests.
+	 */
+	if (!drm_fb_pixel_format_equal(var, &info->var)) {
+		DRM_DEBUG("fbdev emulation doesn't support changing the pixel format\n");
 		return -EINVAL;
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(drm_fb_helper_check_var);
diff --git a/drivers/gpu/drm/i915/i915_reg.h b/drivers/gpu/drm/i915/i915_re=
g.h
index 8196408bb819..0d8bae0ec208 100644
--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -5918,6 +5918,7 @@ enum punit_power_well {
 #define  TRANS_MSA_10_BPC		(2<<5)
 #define  TRANS_MSA_12_BPC		(3<<5)
 #define  TRANS_MSA_16_BPC		(4<<5)
+#define  TRANS_MSA_CEA_RANGE		(1 << 3)
=20
 /* LCPLL Control */
 #define LCPLL_CTL			0x130040
diff --git a/drivers/gpu/drm/i915/intel_ddi.c b/drivers/gpu/drm/i915/intel_=
ddi.c
index b17b9c7c769f..a1572477895b 100644
--- a/drivers/gpu/drm/i915/intel_ddi.c
+++ b/drivers/gpu/drm/i915/intel_ddi.c
@@ -929,6 +929,10 @@ void intel_ddi_set_pipe_settings(struct drm_crtc *crtc)
 	if (type =3D=3D INTEL_OUTPUT_DISPLAYPORT || type =3D=3D INTEL_OUTPUT_EDP)=
 {
=20
 		temp =3D TRANS_MSA_SYNC_CLK;
+
+		if (intel_crtc->config.limited_color_range)
+			temp |=3D TRANS_MSA_CEA_RANGE;
+
 		switch (intel_crtc->config.pipe_bpp) {
 		case 18:
 			temp |=3D TRANS_MSA_6_BPC;
diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/in=
tel_display.c
index 7bcca10ae746..6a5dbe6b1b01 100644
--- a/drivers/gpu/drm/i915/intel_display.c
+++ b/drivers/gpu/drm/i915/intel_display.c
@@ -3794,8 +3794,12 @@ void hsw_disable_ips(struct intel_crtc *crtc)
 		mutex_lock(&dev_priv->rps.hw_lock);
 		WARN_ON(sandybridge_pcode_write(dev_priv, DISPLAY_IPS_CONTROL, 0));
 		mutex_unlock(&dev_priv->rps.hw_lock);
-		/* wait for pcode to finish disabling IPS, which may take up to 42ms */
-		if (wait_for((I915_READ(IPS_CTL) & IPS_ENABLE) =3D=3D 0, 42))
+		/*
+		 * Wait for PCODE to finish disabling IPS. The BSpec specified
+		 * 42ms timeout value leads to occasional timeouts so use 100ms
+		 * instead.
+		 */
+		if (wait_for((I915_READ(IPS_CTL) & IPS_ENABLE) =3D=3D 0, 100))
 			DRM_ERROR("Timed out waiting for IPS disable\n");
 	} else {
 		I915_WRITE(IPS_CTL, 0);
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/=
nouveau/nouveau_connector.c
index 5f8e9711c313..e7187bd081c1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -256,12 +256,16 @@ nouveau_connector_detect(struct drm_connector *connec=
tor, bool force)
 		nv_connector->edid =3D NULL;
 	}
=20
-	/* Outputs are only polled while runtime active, so acquiring a
-	 * runtime PM ref here is unnecessary (and would deadlock upon
-	 * runtime suspend because it waits for polling to finish).
+	/* Outputs are only polled while runtime active, so resuming the
+	 * device here is unnecessary (and would deadlock upon runtime suspend
+	 * because it waits for polling to finish). We do however, want to
+	 * prevent the autosuspend timer from elapsing during this operation
+	 * if possible.
 	 */
-	if (!drm_kms_helper_is_poll_worker()) {
-		ret =3D pm_runtime_get_sync(connector->dev->dev);
+	if (drm_kms_helper_is_poll_worker()) {
+		pm_runtime_get_noresume(dev->dev);
+	} else {
+		ret =3D pm_runtime_get_sync(dev->dev);
 		if (ret < 0 && ret !=3D -EACCES)
 			return conn_status;
 	}
@@ -332,10 +336,8 @@ nouveau_connector_detect(struct drm_connector *connect=
or, bool force)
=20
  out:
=20
-	if (!drm_kms_helper_is_poll_worker()) {
-		pm_runtime_mark_last_busy(connector->dev->dev);
-		pm_runtime_put_autosuspend(connector->dev->dev);
-	}
+	pm_runtime_mark_last_busy(dev->dev);
+	pm_runtime_put_autosuspend(dev->dev);
=20
 	return conn_status;
 }
diff --git a/drivers/gpu/drm/panel/panel-s6e8aa0.c b/drivers/gpu/drm/panel/=
panel-s6e8aa0.c
index 06e57a26db7a..b7b651287ffa 100644
--- a/drivers/gpu/drm/panel/panel-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-s6e8aa0.c
@@ -832,7 +832,7 @@ static void s6e8aa0_read_mtp_id(struct s6e8aa0 *ctx)
 	int ret, i;
=20
 	ret =3D s6e8aa0_dcs_read(ctx, 0xd1, id, ARRAY_SIZE(id));
-	if (ret < ARRAY_SIZE(id) || id[0] =3D=3D 0x00) {
+	if (ret < 0 || ret < ARRAY_SIZE(id) || id[0] =3D=3D 0x00) {
 		dev_err(ctx->dev, "read id failed\n");
 		ctx->error =3D -EIO;
 		return;
diff --git a/drivers/gpu/drm/udl/udl_fb.c b/drivers/gpu/drm/udl/udl_fb.c
index b2abb025c021..08490497f0b5 100644
--- a/drivers/gpu/drm/udl/udl_fb.c
+++ b/drivers/gpu/drm/udl/udl_fb.c
@@ -344,7 +344,7 @@ static int udl_fb_open(struct fb_info *info, int user)
=20
 		struct fb_deferred_io *fbdefio;
=20
-		fbdefio =3D kmalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
+		fbdefio =3D kzalloc(sizeof(struct fb_deferred_io), GFP_KERNEL);
=20
 		if (fbdefio) {
 			fbdefio->delay =3D DL_DEFIO_WRITE_DELAY;
@@ -574,9 +574,11 @@ static void udl_fbdev_destroy(struct drm_device *dev,
 		framebuffer_release(info);
 	}
 	drm_fb_helper_fini(&ufbdev->helper);
-	drm_framebuffer_unregister_private(&ufbdev->ufb.base);
-	drm_framebuffer_cleanup(&ufbdev->ufb.base);
-	drm_gem_object_unreference_unlocked(&ufbdev->ufb.obj->base);
+	if (ufbdev->ufb.obj) {
+		drm_framebuffer_unregister_private(&ufbdev->ufb.base);
+		drm_framebuffer_cleanup(&ufbdev->ufb.base);
+		drm_gem_object_unreference_unlocked(&ufbdev->ufb.obj->base);
+	}
 }
=20
 int udl_fbdev_init(struct drm_device *dev)
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 7094b92d1ec7..0809807e1348 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -141,18 +141,13 @@ static void udl_free_urb_list(struct drm_device *dev)
 	struct list_head *node;
 	struct urb_node *unode;
 	struct urb *urb;
-	int ret;
 	unsigned long flags;
=20
 	DRM_DEBUG("Waiting for completes and freeing all render urbs\n");
=20
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
-
-		/* Getting interrupted means a leak, but ok at shutdown*/
-		ret =3D down_interruptible(&udl->urbs.limit_sem);
-		if (ret)
-			break;
+		down(&udl->urbs.limit_sem);
=20
 		spin_lock_irqsave(&udl->urbs.lock, flags);
=20
@@ -176,17 +171,22 @@ static void udl_free_urb_list(struct drm_device *dev)
 static int udl_alloc_urb_list(struct drm_device *dev, int count, size_t si=
ze)
 {
 	struct udl_device *udl =3D dev->dev_private;
-	int i =3D 0;
 	struct urb *urb;
 	struct urb_node *unode;
 	char *buf;
+	size_t wanted_size =3D count * size;
=20
 	spin_lock_init(&udl->urbs.lock);
=20
+retry:
 	udl->urbs.size =3D size;
 	INIT_LIST_HEAD(&udl->urbs.list);
=20
-	while (i < count) {
+	sema_init(&udl->urbs.limit_sem, 0);
+	udl->urbs.count =3D 0;
+	udl->urbs.available =3D 0;
+
+	while (udl->urbs.count * size < wanted_size) {
 		unode =3D kzalloc(sizeof(struct urb_node), GFP_KERNEL);
 		if (!unode)
 			break;
@@ -202,11 +202,16 @@ static int udl_alloc_urb_list(struct drm_device *dev,=
 int count, size_t size)
 		}
 		unode->urb =3D urb;
=20
-		buf =3D usb_alloc_coherent(udl->ddev->usbdev, MAX_TRANSFER, GFP_KERNEL,
+		buf =3D usb_alloc_coherent(udl->ddev->usbdev, size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			kfree(unode);
 			usb_free_urb(urb);
+			if (size > PAGE_SIZE) {
+				size /=3D 2;
+				udl_free_urb_list(dev);
+				goto retry;
+			}
 			break;
 		}
=20
@@ -217,16 +222,14 @@ static int udl_alloc_urb_list(struct drm_device *dev,=
 int count, size_t size)
=20
 		list_add_tail(&unode->entry, &udl->urbs.list);
=20
-		i++;
+		up(&udl->urbs.limit_sem);
+		udl->urbs.count++;
+		udl->urbs.available++;
 	}
=20
-	sema_init(&udl->urbs.limit_sem, i);
-	udl->urbs.count =3D i;
-	udl->urbs.available =3D i;
-
-	DRM_DEBUG("allocated %d %d byte urbs\n", i, (int) size);
+	DRM_DEBUG("allocated %d %d byte urbs\n", udl->urbs.count, (int) size);
=20
-	return i;
+	return udl->urbs.count;
 }
=20
 struct urb *udl_get_urb(struct drm_device *dev)
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 04e5a98fdc44..0949566ec049 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -68,6 +68,7 @@ static int vmbus_negotiate_version(struct vmbus_channel_m=
sginfo *msginfo,
 					__u32 version)
 {
 	int ret =3D 0;
+	unsigned int cur_cpu;
 	struct vmbus_channel_initiate_contact *msg;
 	unsigned long flags;
=20
@@ -80,8 +81,11 @@ static int vmbus_negotiate_version(struct vmbus_channel_=
msginfo *msginfo,
 	msg->interrupt_page =3D virt_to_phys(vmbus_connection.int_page);
 	msg->monitor_page1 =3D virt_to_phys(vmbus_connection.monitor_pages[0]);
 	msg->monitor_page2 =3D virt_to_phys(vmbus_connection.monitor_pages[1]);
-	if (version =3D=3D VERSION_WIN8_1)
-		msg->target_vcpu =3D hv_context.vp_index[smp_processor_id()];
+	if (version =3D=3D VERSION_WIN8_1) {
+		cur_cpu =3D get_cpu();
+		msg->target_vcpu =3D hv_context.vp_index[cur_cpu];
+		put_cpu();
+	}
=20
 	/*
 	 * Add to list before we send the request since we may
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index a720a75fd5a6..fc842ec066e1 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -57,6 +57,7 @@
 #include <linux/mutex.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
+#include <linux/nospec.h>
 #include "lm75.h"
=20
 #define USE_ALTERNATE
@@ -268,8 +269,9 @@ static const u16 NCT6775_REG_PWM_READ[] =3D {
=20
 static const u16 NCT6775_REG_FAN[] =3D { 0x630, 0x632, 0x634, 0x636, 0x638=
 };
 static const u16 NCT6775_REG_FAN_MIN[] =3D { 0x3b, 0x3c, 0x3d };
-static const u16 NCT6775_REG_FAN_PULSES[] =3D { 0x641, 0x642, 0x643, 0x644=
, 0 };
-static const u16 NCT6775_FAN_PULSE_SHIFT[] =3D { 0, 0, 0, 0, 0, 0 };
+static const u16 NCT6775_REG_FAN_PULSES[NUM_FAN] =3D {
+	0x641, 0x642, 0x643, 0x644 };
+static const u16 NCT6775_FAN_PULSE_SHIFT[NUM_FAN] =3D { };
=20
 static const u16 NCT6775_REG_TEMP[] =3D {
 	0x27, 0x150, 0x250, 0x62b, 0x62c, 0x62d };
@@ -381,7 +383,8 @@ static const u8 NCT6776_REG_PWM_MODE[] =3D { 0x04, 0, 0=
, 0, 0, 0 };
 static const u8 NCT6776_PWM_MODE_MASK[] =3D { 0x01, 0, 0, 0, 0, 0 };
=20
 static const u16 NCT6776_REG_FAN_MIN[] =3D { 0x63a, 0x63c, 0x63e, 0x640, 0=
x642 };
-static const u16 NCT6776_REG_FAN_PULSES[] =3D { 0x644, 0x645, 0x646, 0, 0 =
};
+static const u16 NCT6776_REG_FAN_PULSES[NUM_FAN] =3D {
+	0x644, 0x645, 0x646 };
=20
 static const u16 NCT6776_REG_WEIGHT_DUTY_BASE[] =3D {
 	0x13e, 0x23e, 0x33e, 0x83e, 0x93e, 0xa3e };
@@ -450,7 +453,7 @@ static const s8 NCT6779_BEEP_BITS[] =3D {
=20
 static const u16 NCT6779_REG_FAN[] =3D {
 	0x4b0, 0x4b2, 0x4b4, 0x4b6, 0x4b8, 0x4ba };
-static const u16 NCT6779_REG_FAN_PULSES[] =3D {
+static const u16 NCT6779_REG_FAN_PULSES[NUM_FAN] =3D {
 	0x644, 0x645, 0x646, 0x647, 0x648, 0x649 };
=20
 static const u16 NCT6779_REG_CRITICAL_PWM_ENABLE[] =3D {
@@ -563,8 +566,8 @@ static const u16 NCT6106_REG_TEMP_CONFIG[] =3D {
=20
 static const u16 NCT6106_REG_FAN[] =3D { 0x20, 0x22, 0x24 };
 static const u16 NCT6106_REG_FAN_MIN[] =3D { 0xe0, 0xe2, 0xe4 };
-static const u16 NCT6106_REG_FAN_PULSES[] =3D { 0xf6, 0xf6, 0xf6, 0, 0 };
-static const u16 NCT6106_FAN_PULSE_SHIFT[] =3D { 0, 2, 4, 0, 0 };
+static const u16 NCT6106_REG_FAN_PULSES[] =3D { 0xf6, 0xf6, 0xf6 };
+static const u16 NCT6106_FAN_PULSE_SHIFT[] =3D { 0, 2, 4 };
=20
 static const u8 NCT6106_REG_PWM_MODE[] =3D { 0xf3, 0xf3, 0xf3 };
 static const u8 NCT6106_PWM_MODE_MASK[] =3D { 0x01, 0x02, 0x04 };
@@ -1330,7 +1333,7 @@ static void nct6775_update_pwm(struct device *dev)
 		reg =3D nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[i]);
 		data->pwm_weight_temp_sel[i] =3D reg & 0x1f;
 		/* If weight is disabled, report weight source as 0 */
-		if (j =3D=3D 1 && !(reg & 0x80))
+		if (!(reg & 0x80))
 			data->pwm_weight_temp_sel[i] =3D 0;
=20
 		/* Weight temp data */
@@ -1450,9 +1453,13 @@ static struct nct6775_data *nct6775_update_device(st=
ruct device *dev)
 			if (data->has_fan_min & (1 << i))
 				data->fan_min[i] =3D nct6775_read_value(data,
 					   data->REG_FAN_MIN[i]);
-			data->fan_pulses[i] =3D
-			  (nct6775_read_value(data, data->REG_FAN_PULSES[i])
-				>> data->FAN_PULSE_SHIFT[i]) & 0x03;
+
+			if (data->REG_FAN_PULSES[i]) {
+				data->fan_pulses[i] =3D
+				  (nct6775_read_value(data,
+						      data->REG_FAN_PULSES[i])
+				   >> data->FAN_PULSE_SHIFT[i]) & 0x03;
+			}
=20
 			nct6775_select_fan_div(dev, data, i, reg);
 		}
@@ -2438,6 +2445,7 @@ store_pwm_weight_temp_sel(struct device *dev, struct =
device_attribute *attr,
 		return err;
 	if (val > NUM_TEMP)
 		return -EINVAL;
+	val =3D array_index_nospec(val, NUM_TEMP + 1);
 	if (val && (!(data->have_temp & (1 << (val - 1))) ||
 		    !data->temp_src[val - 1]))
 		return -EINVAL;
diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
index 7731f1795869..b1e2f1d0412f 100644
--- a/drivers/i2c/busses/i2c-xiic.c
+++ b/drivers/i2c/busses/i2c-xiic.c
@@ -504,6 +504,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 {
 	u8 rx_watermark;
 	struct i2c_msg *msg =3D i2c->rx_msg =3D i2c->tx_msg;
+	unsigned long flags;
=20
 	/* Clear and enable Rx full interrupt. */
 	xiic_irq_clr_en(i2c, XIIC_INTR_RX_FULL_MASK | XIIC_INTR_TX_ERROR_MASK);
@@ -519,6 +520,7 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
 		rx_watermark =3D IIC_RX_FIFO_DEPTH;
 	xiic_setreg8(i2c, XIIC_RFD_REG_OFFSET, rx_watermark - 1);
=20
+	local_irq_save(flags);
 	if (!(msg->flags & I2C_M_NOSTART))
 		/* write the address */
 		xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
@@ -529,6 +531,8 @@ static void xiic_start_recv(struct xiic_i2c *i2c)
=20
 	xiic_setreg16(i2c, XIIC_DTR_REG_OFFSET,
 		msg->len | ((i2c->nmsgs =3D=3D 1) ? XIIC_TX_DYN_STOP_MASK : 0));
+	local_irq_restore(flags);
+
 	if (i2c->nmsgs =3D=3D 1)
 		/* very last, enable bus not busy as well */
 		xiic_irq_clr_en(i2c, XIIC_INTR_BNB_MASK);
diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 7c5245d9f99c..4cffd8fc5cae 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -507,7 +507,7 @@ static ssize_t ad9523_store(struct device *dev,
 		return ret;
=20
 	if (!state)
-		return 0;
+		return len;
=20
 	mutex_lock(&indio_dev->mlock);
 	switch ((u32)this_attr->address) {
@@ -641,7 +641,7 @@ static int ad9523_read_raw(struct iio_dev *indio_dev,
 		code =3D (AD9523_CLK_DIST_DIV_PHASE_REV(ret) * 3141592) /
 			AD9523_CLK_DIST_DIV_REV(ret);
 		*val =3D code / 1000000;
-		*val2 =3D (code % 1000000) * 10;
+		*val2 =3D code % 1000000;
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 0c856b380f48..dbe56b1b8302 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -434,6 +434,7 @@ static int cma_resolve_ib_dev(struct rdma_id_private *i=
d_priv)
 	dgid =3D (union ib_gid *) &addr->sib_addr;
 	pkey =3D ntohs(addr->sib_pkey);
=20
+	mutex_lock(&lock);
 	list_for_each_entry(cur_dev, &dev_list, list) {
 		if (rdma_node_get_transport(cur_dev->device->node_type) !=3D RDMA_TRANSP=
ORT_IB)
 			continue;
@@ -455,18 +456,19 @@ static int cma_resolve_ib_dev(struct rdma_id_private =
*id_priv)
 					cma_dev =3D cur_dev;
 					sgid =3D gid;
 					id_priv->id.port_num =3D p;
+					goto found;
 				}
 			}
 		}
 	}
-
-	if (!cma_dev)
-		return -ENODEV;
+	mutex_unlock(&lock);
+	return -ENODEV;
=20
 found:
 	cma_attach_to_dev(id_priv, cma_dev);
-	addr =3D (struct sockaddr_ib *) cma_src_addr(id_priv);
-	memcpy(&addr->sib_addr, &sgid, sizeof sgid);
+	mutex_unlock(&lock);
+	addr =3D (struct sockaddr_ib *)cma_src_addr(id_priv);
+	memcpy(&addr->sib_addr, &sgid, sizeof(sgid));
 	cma_translate_ib(addr, &id_priv->id.route.addr.dev_addr);
 	return 0;
 }
diff --git a/drivers/infiniband/core/ucm.c b/drivers/infiniband/core/ucm.c
index 5befec118a18..23b72417a433 100644
--- a/drivers/infiniband/core/ucm.c
+++ b/drivers/infiniband/core/ucm.c
@@ -46,6 +46,8 @@
 #include <linux/mutex.h>
 #include <linux/slab.h>
=20
+#include <linux/nospec.h>
+
 #include <asm/uaccess.h>
=20
 #include <rdma/ib.h>
@@ -1116,6 +1118,7 @@ static ssize_t ib_ucm_write(struct file *filp, const =
char __user *buf,
=20
 	if (hdr.cmd >=3D ARRAY_SIZE(ucm_cmd_table))
 		return -EINVAL;
+	hdr.cmd =3D array_index_nospec(hdr.cmd, ARRAY_SIZE(ucm_cmd_table));
=20
 	if (hdr.in + sizeof(hdr) > len)
 		return -EINVAL;
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index a213b01b3ce0..fc937cc8d9e9 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -43,6 +43,8 @@
 #include <linux/sysctl.h>
 #include <linux/module.h>
=20
+#include <linux/nospec.h>
+
 #include <rdma/rdma_user_cm.h>
 #include <rdma/ib_marshall.h>
 #include <rdma/rdma_cm.h>
@@ -113,6 +115,8 @@ static DEFINE_MUTEX(mut);
 static DEFINE_IDR(ctx_idr);
 static DEFINE_IDR(multicast_idr);
=20
+static const struct file_operations ucma_fops;
+
 static inline struct ucma_context *_ucma_find_context(int id,
 						      struct ucma_file *file)
 {
@@ -1448,6 +1452,10 @@ static ssize_t ucma_migrate_id(struct ucma_file *new=
_file,
 	f =3D fdget(cmd.fd);
 	if (!f.file)
 		return -ENOENT;
+	if (f.file->f_op !=3D &ucma_fops) {
+		ret =3D -EINVAL;
+		goto file_put;
+	}
=20
 	/* Validate current fd and prevent destruction of id. */
 	ctx =3D ucma_get_ctx(f.file->private_data, cmd.id);
@@ -1534,6 +1542,7 @@ static ssize_t ucma_write(struct file *filp, const ch=
ar __user *buf,
=20
 	if (hdr.cmd >=3D ARRAY_SIZE(ucma_cmd_table))
 		return -EINVAL;
+	hdr.cmd =3D array_index_nospec(hdr.cmd, ARRAY_SIZE(ucma_cmd_table));
=20
 	if (hdr.in + sizeof(hdr) > len)
 		return -EINVAL;
diff --git a/drivers/infiniband/hw/cxgb4/ev.c b/drivers/infiniband/hw/cxgb4=
/ev.c
index d61d0a18f784..a98426fed9ee 100644
--- a/drivers/infiniband/hw/cxgb4/ev.c
+++ b/drivers/infiniband/hw/cxgb4/ev.c
@@ -182,6 +182,7 @@ int c4iw_ev_handler(struct c4iw_dev *dev, u32 qid)
=20
 	chp =3D get_chp(dev, qid);
 	if (chp) {
+		t4_clear_cq_armed(&chp->cq);
 		spin_lock_irqsave(&chp->comp_handler_lock, flag);
 		(*chp->ibcq.comp_handler)(&chp->ibcq, chp->ibcq.cq_context);
 		spin_unlock_irqrestore(&chp->comp_handler_lock, flag);
diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4=
/qp.c
index a8d4ffc0bea8..e58af9b599c9 100644
--- a/drivers/infiniband/hw/cxgb4/qp.c
+++ b/drivers/infiniband/hw/cxgb4/qp.c
@@ -1066,45 +1066,61 @@ static void __flush_qp(struct c4iw_qp *qhp, struct =
c4iw_cq *rchp,
 		       struct c4iw_cq *schp)
 {
 	int count;
-	int flushed;
+	int rq_flushed, sq_flushed;
 	unsigned long flag;
=20
 	PDBG("%s qhp %p rchp %p schp %p\n", __func__, qhp, rchp, schp);
=20
-	/* locking hierarchy: cq lock first, then qp lock. */
+	/* locking hierarchy: cqs lock first, then qp lock. */
 	spin_lock_irqsave(&rchp->lock, flag);
+	if (schp !=3D rchp)
+		spin_lock(&schp->lock);
 	spin_lock(&qhp->lock);
=20
 	if (qhp->wq.flushed) {
 		spin_unlock(&qhp->lock);
+		if (schp !=3D rchp)
+			spin_unlock(&schp->lock);
 		spin_unlock_irqrestore(&rchp->lock, flag);
 		return;
 	}
 	qhp->wq.flushed =3D 1;
+	t4_set_wq_in_error(&qhp->wq);
=20
 	c4iw_flush_hw_cq(rchp, qhp);
 	c4iw_count_rcqes(&rchp->cq, &qhp->wq, &count);
-	flushed =3D c4iw_flush_rq(&qhp->wq, &rchp->cq, count);
-	spin_unlock(&qhp->lock);
-	spin_unlock_irqrestore(&rchp->lock, flag);
-	if (flushed) {
-		spin_lock_irqsave(&rchp->comp_handler_lock, flag);
-		(*rchp->ibcq.comp_handler)(&rchp->ibcq, rchp->ibcq.cq_context);
-		spin_unlock_irqrestore(&rchp->comp_handler_lock, flag);
-	}
+	rq_flushed =3D c4iw_flush_rq(&qhp->wq, &rchp->cq, count);
=20
-	/* locking hierarchy: cq lock first, then qp lock. */
-	spin_lock_irqsave(&schp->lock, flag);
-	spin_lock(&qhp->lock);
 	if (schp !=3D rchp)
 		c4iw_flush_hw_cq(schp, qhp);
-	flushed =3D c4iw_flush_sq(qhp);
+	sq_flushed =3D c4iw_flush_sq(qhp);
+
 	spin_unlock(&qhp->lock);
-	spin_unlock_irqrestore(&schp->lock, flag);
-	if (flushed) {
-		spin_lock_irqsave(&schp->comp_handler_lock, flag);
-		(*schp->ibcq.comp_handler)(&schp->ibcq, schp->ibcq.cq_context);
-		spin_unlock_irqrestore(&schp->comp_handler_lock, flag);
+	if (schp !=3D rchp)
+		spin_unlock(&schp->lock);
+	spin_unlock_irqrestore(&rchp->lock, flag);
+
+	if (schp =3D=3D rchp) {
+		if (t4_clear_cq_armed(&rchp->cq) &&
+		    (rq_flushed || sq_flushed)) {
+			spin_lock_irqsave(&rchp->comp_handler_lock, flag);
+			(*rchp->ibcq.comp_handler)(&rchp->ibcq,
+						   rchp->ibcq.cq_context);
+			spin_unlock_irqrestore(&rchp->comp_handler_lock, flag);
+		}
+	} else {
+		if (t4_clear_cq_armed(&rchp->cq) && rq_flushed) {
+			spin_lock_irqsave(&rchp->comp_handler_lock, flag);
+			(*rchp->ibcq.comp_handler)(&rchp->ibcq,
+						   rchp->ibcq.cq_context);
+			spin_unlock_irqrestore(&rchp->comp_handler_lock, flag);
+		}
+		if (t4_clear_cq_armed(&schp->cq) && sq_flushed) {
+			spin_lock_irqsave(&schp->comp_handler_lock, flag);
+			(*schp->ibcq.comp_handler)(&schp->ibcq,
+						   schp->ibcq.cq_context);
+			spin_unlock_irqrestore(&schp->comp_handler_lock, flag);
+		}
 	}
 }
=20
@@ -1116,8 +1132,14 @@ static void flush_qp(struct c4iw_qp *qhp)
 	rchp =3D to_c4iw_cq(qhp->ibqp.recv_cq);
 	schp =3D to_c4iw_cq(qhp->ibqp.send_cq);
=20
-	t4_set_wq_in_error(&qhp->wq);
 	if (qhp->ibqp.uobject) {
+
+		/* for user qps, qhp->wq.flushed is protected by qhp->mutex */
+		if (qhp->wq.flushed)
+			return;
+
+		qhp->wq.flushed =3D 1;
+		t4_set_wq_in_error(&qhp->wq);
 		t4_set_cq_in_error(&rchp->cq);
 		spin_lock_irqsave(&rchp->comp_handler_lock, flag);
 		(*rchp->ibcq.comp_handler)(&rchp->ibcq, rchp->ibcq.cq_context);
diff --git a/drivers/infiniband/hw/cxgb4/t4.h b/drivers/infiniband/hw/cxgb4=
/t4.h
index 68b0a6bf4eb0..d8d7fa3e446d 100644
--- a/drivers/infiniband/hw/cxgb4/t4.h
+++ b/drivers/infiniband/hw/cxgb4/t4.h
@@ -531,6 +531,10 @@ static inline int t4_wq_db_enabled(struct t4_wq *wq)
 	return !wq->rq.queue[wq->rq.size].status.db_off;
 }
=20
+enum t4_cq_flags {
+	CQ_ARMED	=3D 1,
+};
+
 struct t4_cq {
 	struct t4_cqe *queue;
 	dma_addr_t dma_addr;
@@ -551,12 +555,19 @@ struct t4_cq {
 	u16 cidx_inc;
 	u8 gen;
 	u8 error;
+	unsigned long flags;
 };
=20
+static inline int t4_clear_cq_armed(struct t4_cq *cq)
+{
+	return test_and_clear_bit(CQ_ARMED, &cq->flags);
+}
+
 static inline int t4_arm_cq(struct t4_cq *cq, int se)
 {
 	u32 val;
=20
+	set_bit(CQ_ARMED, &cq->flags);
 	while (cq->cidx_inc > CIDXINC_MASK) {
 		val =3D SEINTARM(0) | CIDXINC(CIDXINC_MASK) | TIMERREG(7) |
 		      INGRESSQID(cq->cqid);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_cm.c b/drivers/infiniband/u=
lp/ipoib/ipoib_cm.c
index 4a5764fe4b23..43d648332e63 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_cm.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_cm.c
@@ -996,12 +996,14 @@ static int ipoib_cm_rep_handler(struct ib_cm_id *cm_i=
d, struct ib_cm_event *even
=20
 	skb_queue_head_init(&skqueue);
=20
+	netif_tx_lock_bh(p->dev);
 	spin_lock_irq(&priv->lock);
 	set_bit(IPOIB_FLAG_OPER_UP, &p->flags);
 	if (p->neigh)
 		while ((skb =3D __skb_dequeue(&p->neigh->queue)))
 			__skb_queue_tail(&skqueue, skb);
 	spin_unlock_irq(&priv->lock);
+	netif_tx_unlock_bh(p->dev);
=20
 	while ((skb =3D __skb_dequeue(&skqueue))) {
 		skb->dev =3D p->dev;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infin=
iband/ulp/ipoib/ipoib_multicast.c
index f76822a84d62..45055d8d0346 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -734,6 +734,7 @@ void ipoib_mcast_send(struct net_device *dev, u8 *daddr=
, struct sk_buff *skb)
 			if (neigh && list_empty(&neigh->list)) {
 				kref_get(&mcast->ah->ref);
 				neigh->ah	=3D mcast->ah;
+				neigh->ah->valid =3D 1;
 				list_add_tail(&neigh->list, &mcast->neigh_list);
 			}
 		}
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp=
/srpt/ib_srpt.c
index 9c128bd1cace..fcf2647cd6c2 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -3147,7 +3147,9 @@ static void srpt_add_one(struct ib_device *device)
 	pr_debug("device =3D %p, device->dma_ops =3D %p\n", device,
 		 device->dma_ops);
=20
-	sdev =3D kzalloc(sizeof *sdev, GFP_KERNEL);
+	sdev =3D kzalloc(sizeof(*sdev) +
+		       device->phys_port_cnt * sizeof(*sdev->port),
+		       GFP_KERNEL);
 	if (!sdev)
 		goto err;
=20
@@ -3220,8 +3222,6 @@ static void srpt_add_one(struct ib_device *device)
 	for (i =3D 0; i < sdev->srq_size; ++i)
 		srpt_post_recv(sdev, sdev->ioctx_ring[i]);
=20
-	WARN_ON(sdev->device->phys_port_cnt > ARRAY_SIZE(sdev->port));
-
 	for (i =3D 1; i <=3D sdev->device->phys_port_cnt; i++) {
 		sport =3D &sdev->port[i - 1];
 		sport->sdev =3D sdev;
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/ulp=
/srpt/ib_srpt.h
index 3dae156905de..5aff650ee12e 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -387,9 +387,9 @@ struct srpt_port {
  * @rch_list:      Per-device channel list -- see also srpt_rdma_ch.list.
  * @ch_releaseQ:   Enables waiting for removal from rch_list.
  * @spinlock:      Protects rch_list and tpg.
- * @port:          Information about the ports owned by this HCA.
  * @event_handler: Per-HCA asynchronous IB event handler.
  * @list:          Node in srpt_dev_list.
+ * @port:          Information about the ports owned by this HCA.
  */
 struct srpt_device {
 	struct ib_device	*device;
@@ -403,9 +403,9 @@ struct srpt_device {
 	struct list_head	rch_list;
 	wait_queue_head_t	ch_releaseQ;
 	spinlock_t		spinlock;
-	struct srpt_port	port[2];
 	struct ib_event_handler	event_handler;
 	struct list_head	list;
+	struct srpt_port        port[];
 };
=20
 /**
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 004b0e0097f9..049aada5e8d9 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1083,6 +1083,8 @@ static const struct dmi_system_id elantech_dmi_has_mi=
ddle_button[] =3D {
 static const char * const middle_button_pnp_ids[] =3D {
 	"LEN2131", /* ThinkPad P52 w/ NFC */
 	"LEN2132", /* ThinkPad P52 */
+	"LEN2133", /* ThinkPad P72 w/ NFC */
+	"LEN2134", /* ThinkPad P72 */
 	NULL
 };
=20
diff --git a/drivers/leds/leds-max8997.c b/drivers/leds/leds-max8997.c
index f449a8bdddc7..9f69ec1241af 100644
--- a/drivers/leds/leds-max8997.c
+++ b/drivers/leds/leds-max8997.c
@@ -262,7 +262,7 @@ static int max8997_led_probe(struct platform_device *pd=
ev)
 		mode =3D pdata->led_pdata->mode[led->id];
 		brightness =3D pdata->led_pdata->brightness[led->id];
=20
-		max8997_led_set_mode(led, pdata->led_pdata->mode[led->id]);
+		max8997_led_set_mode(led, mode);
=20
 		if (brightness > led->cdev.max_brightness)
 			brightness =3D led->cdev.max_brightness;
diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 7cb1b2cb1a10..677e1444f99e 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -898,6 +898,7 @@ void bch_prio_write(struct cache *);
 void bch_write_bdev_super(struct cached_dev *, struct closure *);
=20
 extern struct workqueue_struct *bcache_wq;
+extern struct workqueue_struct *bch_journal_wq;
 extern const char * const bch_cache_modes[];
 extern struct mutex bch_register_lock;
 extern struct list_head bch_cache_sets;
diff --git a/drivers/md/bcache/closure.h b/drivers/md/bcache/closure.h
index a08e3eeac3c5..79a6d63e8ed3 100644
--- a/drivers/md/bcache/closure.h
+++ b/drivers/md/bcache/closure.h
@@ -320,7 +320,6 @@ static inline void closure_wake_up(struct closure_waitl=
ist *list)
 do {									\
 	set_closure_fn(_cl, _fn, _wq);					\
 	closure_sub(_cl, CLOSURE_RUNNING + 1);				\
-	return;								\
 } while (0)
=20
 /**
@@ -349,7 +348,6 @@ do {									\
 do {									\
 	set_closure_fn(_cl, _fn, _wq);					\
 	closure_queue(_cl);						\
-	return;								\
 } while (0)
=20
 /**
@@ -365,7 +363,6 @@ do {									\
 do {									\
 	set_closure_fn(_cl, _destructor, NULL);				\
 	closure_sub(_cl, CLOSURE_RUNNING - CLOSURE_DESTRUCTOR + 1);	\
-	return;								\
 } while (0)
=20
 /**
diff --git a/drivers/md/bcache/io.c b/drivers/md/bcache/io.c
index fa028fa82df4..bfce34bb85e2 100644
--- a/drivers/md/bcache/io.c
+++ b/drivers/md/bcache/io.c
@@ -105,6 +105,7 @@ void bch_generic_make_request(struct bio *bio, struct b=
io_split_pool *p)
 	} while (n !=3D bio);
=20
 	continue_at(&s->cl, bch_bio_submit_split_done, NULL);
+	return;
 submit:
 	generic_make_request(bio);
 }
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 59e82021b5bb..280a1f90f772 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -454,7 +454,7 @@ static void do_journal_discard(struct cache *ca)
=20
 		closure_get(&ca->set->cl);
 		INIT_WORK(&ja->discard_work, journal_discard_work);
-		schedule_work(&ja->discard_work);
+		queue_work(bch_journal_wq, &ja->discard_work);
 	}
 }
=20
@@ -559,7 +559,7 @@ static void journal_write_done(struct closure *cl)
 		: &j->w[0];
=20
 	__closure_wake_up(&w->wait);
-	continue_at_nobarrier(cl, journal_write, system_wq);
+	continue_at_nobarrier(cl, journal_write, bch_journal_wq);
 }
=20
 static void journal_write_unlock(struct closure *cl)
@@ -586,12 +586,14 @@ static void journal_write_unlocked(struct closure *cl)
=20
 	if (!w->need_write) {
 		closure_return_with_destructor(cl, journal_write_unlock);
+		return;
 	} else if (journal_full(&c->journal)) {
 		journal_reclaim(c);
 		spin_unlock(&c->journal.lock);
=20
 		btree_flush_write(c);
-		continue_at(cl, journal_write, system_wq);
+		continue_at(cl, journal_write, bch_journal_wq);
+		return;
 	}
=20
 	c->journal.blocks_free -=3D set_blocks(w->data, block_bytes(c));
diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index fe924f1029d3..046d7fa71243 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -87,8 +87,10 @@ static void bch_data_insert_keys(struct closure *cl)
 	if (journal_ref)
 		atomic_dec_bug(journal_ref);
=20
-	if (!op->insert_data_done)
+	if (!op->insert_data_done) {
 		continue_at(cl, bch_data_insert_start, op->wq);
+		return;
+	}
=20
 	bch_keylist_free(&op->insert_keys);
 	closure_return(cl);
@@ -215,8 +217,10 @@ static void bch_data_insert_start(struct closure *cl)
 		/* 1 for the device pointer and 1 for the chksum */
 		if (bch_keylist_realloc(&op->insert_keys,
 					3 + (op->csum ? 1 : 0),
-					op->c))
+					op->c)) {
 			continue_at(cl, bch_data_insert_keys, op->wq);
+			return;
+		}
=20
 		k =3D op->insert_keys.top;
 		bkey_init(k);
@@ -254,6 +258,7 @@ static void bch_data_insert_start(struct closure *cl)
=20
 	op->insert_data_done =3D true;
 	continue_at(cl, bch_data_insert_keys, op->wq);
+	return;
 err:
 	/* bch_alloc_sectors() blocks if s->writeback =3D true */
 	BUG_ON(op->writeback);
@@ -568,8 +573,10 @@ static void cache_lookup(struct closure *cl)
 	ret =3D bch_btree_map_keys(&s->op, s->iop.c,
 				 &KEY(s->iop.inode, bio->bi_iter.bi_sector, 0),
 				 cache_lookup_fn, MAP_END_KEY);
-	if (ret =3D=3D -EAGAIN)
+	if (ret =3D=3D -EAGAIN) {
 		continue_at(cl, cache_lookup, bcache_wq);
+		return;
+	}
=20
 	closure_return(cl);
 }
@@ -1095,6 +1102,7 @@ static void flash_dev_make_request(struct request_que=
ue *q, struct bio *bio)
 		continue_at_nobarrier(&s->cl,
 				      flash_dev_nodata,
 				      bcache_wq);
+		return;
 	} else if (rw) {
 		bch_keybuf_check_overlapping(&s->iop.c->moving_gc_keys,
 					&KEY(d->id, bio->bi_iter.bi_sector, 0),
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 9c574978c400..e56c2880b01b 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -56,6 +56,7 @@ static int bcache_major;
 static DEFINE_IDA(bcache_minor);
 static wait_queue_head_t unregister_wait;
 struct workqueue_struct *bcache_wq;
+struct workqueue_struct *bch_journal_wq;
=20
 #define BTREE_MAX_PAGES		(256 * 1024 / PAGE_SIZE)
=20
@@ -1543,7 +1544,8 @@ struct cache_set *bch_cache_set_alloc(struct cache_sb=
 *sb)
 	    !(c->fill_iter =3D mempool_create_kmalloc_pool(1, iter_size)) ||
 	    !(c->bio_split =3D bioset_create(4, offsetof(struct bbio, bio))) ||
 	    !(c->uuids =3D alloc_bucket_pages(GFP_KERNEL, c)) ||
-	    !(c->moving_gc_wq =3D create_workqueue("bcache_gc")) ||
+	    !(c->moving_gc_wq =3D alloc_workqueue("bcache_gc",
+						WQ_MEM_RECLAIM, 0)) ||
 	    bch_journal_alloc(c) ||
 	    bch_btree_cache_alloc(c) ||
 	    bch_open_buckets_alloc(c) ||
@@ -2111,9 +2113,13 @@ static void bcache_exit(void)
 		kobject_put(bcache_kobj);
 	if (bcache_wq)
 		destroy_workqueue(bcache_wq);
+	if (bch_journal_wq)
+		destroy_workqueue(bch_journal_wq);
+
 	if (bcache_major)
 		unregister_blkdev(bcache_major, "bcache");
 	unregister_reboot_notifier(&reboot);
+	mutex_destroy(&bch_register_lock);
 }
=20
 static int __init bcache_init(void)
@@ -2132,14 +2138,25 @@ static int __init bcache_init(void)
 	bcache_major =3D register_blkdev(0, "bcache");
 	if (bcache_major < 0) {
 		unregister_reboot_notifier(&reboot);
+		mutex_destroy(&bch_register_lock);
 		return bcache_major;
 	}
=20
-	if (!(bcache_wq =3D create_workqueue("bcache")) ||
-	    !(bcache_kobj =3D kobject_create_and_add("bcache", fs_kobj)) ||
-	    sysfs_create_files(bcache_kobj, files) ||
-	    bch_request_init() ||
-	    bch_debug_init(bcache_kobj))
+	bcache_wq =3D alloc_workqueue("bcache", WQ_MEM_RECLAIM, 0);
+	if (!bcache_wq)
+		goto err;
+
+	bch_journal_wq =3D alloc_workqueue("bch_journal", WQ_MEM_RECLAIM, 0);
+	if (!bch_journal_wq)
+		goto err;
+
+	bcache_kobj =3D kobject_create_and_add("bcache", fs_kobj);
+	if (!bcache_kobj)
+		goto err;
+
+	if (bch_request_init() ||
+	    bch_debug_init(bcache_kobj) ||
+	    sysfs_create_files(bcache_kobj, files))
 		goto err;
=20
 	return 0;
diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
index 01ad0c2c0229..284719d3784d 100644
--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -324,7 +324,7 @@ static int __write_initial_superblock(struct dm_cache_m=
etadata *cmd)
 	disk_super->version =3D cpu_to_le32(MAX_CACHE_VERSION);
 	memset(disk_super->policy_name, 0, sizeof(disk_super->policy_name));
 	memset(disk_super->policy_version, 0, sizeof(disk_super->policy_version));
-	disk_super->policy_hint_size =3D 0;
+	disk_super->policy_hint_size =3D cpu_to_le32(0);
=20
 	__copy_sm_root(cmd, disk_super);
=20
@@ -635,6 +635,7 @@ static int __commit_transaction(struct dm_cache_metadat=
a *cmd,
 	disk_super->policy_version[0] =3D cpu_to_le32(cmd->policy_version[0]);
 	disk_super->policy_version[1] =3D cpu_to_le32(cmd->policy_version[1]);
 	disk_super->policy_version[2] =3D cpu_to_le32(cmd->policy_version[2]);
+	disk_super->policy_hint_size =3D cpu_to_le32(cmd->policy_hint_size);
=20
 	disk_super->read_hits =3D cpu_to_le32(cmd->stats.read_hits);
 	disk_super->read_misses =3D cpu_to_le32(cmd->stats.read_misses);
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index f2dd7ed85ee8..fd4be2898183 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -3109,14 +3109,13 @@ static int __init dm_cache_init(void)
 	int r;
=20
 	migration_cache =3D KMEM_CACHE(dm_cache_migration, 0);
-	if (!migration_cache) {
-		dm_unregister_target(&cache_target);
+	if (!migration_cache)
 		return -ENOMEM;
-	}
=20
 	r =3D dm_register_target(&cache_target);
 	if (r) {
 		DMERR("cache target registration failed: %d", r);
+		kmem_cache_destroy(migration_cache);
 		return r;
 	}
=20
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index c43187b4dc0e..dfab51ff09ea 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -262,7 +262,7 @@ static int crypt_iv_essiv_init(struct crypt_config *cc)
=20
 	sg_init_one(&sg, cc->key, cc->key_size);
 	desc.tfm =3D essiv->hash_tfm;
-	desc.flags =3D CRYPTO_TFM_REQ_MAY_SLEEP;
+	desc.flags =3D 0;
=20
 	err =3D crypto_hash_digest(&desc, &sg, cc->key_size, essiv->salt);
 	if (err)
@@ -533,7 +533,7 @@ static int crypt_iv_lmk_one(struct crypt_config *cc, u8=
 *iv,
 	int i, r;
=20
 	sdesc.desc.tfm =3D lmk->hash_tfm;
-	sdesc.desc.flags =3D CRYPTO_TFM_REQ_MAY_SLEEP;
+	sdesc.desc.flags =3D 0;
=20
 	r =3D crypto_shash_init(&sdesc.desc);
 	if (r)
@@ -690,7 +690,7 @@ static int crypt_iv_tcw_whitening(struct crypt_config *=
cc,
=20
 	/* calculate crc32 for every 32bit part and xor it */
 	sdesc.desc.tfm =3D tcw->crc32_tfm;
-	sdesc.desc.flags =3D CRYPTO_TFM_REQ_MAY_SLEEP;
+	sdesc.desc.flags =3D 0;
 	for (i =3D 0; i < 4; i++) {
 		r =3D crypto_shash_init(&sdesc.desc);
 		if (r)
@@ -891,7 +891,7 @@ static void crypt_alloc_req(struct crypt_config *cc,
=20
 	ablkcipher_request_set_tfm(ctx->req, cc->tfms[key_index]);
 	ablkcipher_request_set_callback(ctx->req,
-	    CRYPTO_TFM_REQ_MAY_BACKLOG | CRYPTO_TFM_REQ_MAY_SLEEP,
+	    CRYPTO_TFM_REQ_MAY_BACKLOG,
 	    kcryptd_async_done, dmreq_of_req(cc, ctx->req));
 }
=20
diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.c b/drivers/m=
edia/platform/exynos4-is/fimc-isp-video.c
index 93f9cf2ebcd6..3927f0f7dea2 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -390,12 +390,17 @@ static void __isp_video_try_fmt(struct fimc_isp *isp,
 				struct v4l2_pix_format_mplane *pixm,
 				const struct fimc_fmt **fmt)
 {
-	*fmt =3D fimc_isp_find_format(&pixm->pixelformat, NULL, 2);
+	const struct fimc_fmt *__fmt;
+
+	__fmt =3D fimc_isp_find_format(&pixm->pixelformat, NULL, 2);
+
+	if (fmt)
+		*fmt =3D __fmt;
=20
 	pixm->colorspace =3D V4L2_COLORSPACE_SRGB;
 	pixm->field =3D V4L2_FIELD_NONE;
-	pixm->num_planes =3D (*fmt)->memplanes;
-	pixm->pixelformat =3D (*fmt)->fourcc;
+	pixm->num_planes =3D __fmt->memplanes;
+	pixm->pixelformat =3D __fmt->fourcc;
 	/*
 	 * TODO: double check with the docmentation these width/height
 	 * constraints are correct.
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform=
/omap3isp/isp.c
index d4fa20852ba3..dea6dde70a58 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -282,7 +282,7 @@ static const char *isp_xclk_parent_name =3D "cam_mclk";
 static int isp_xclk_init(struct isp_device *isp)
 {
 	struct isp_platform_data *pdata =3D isp->pdata;
-	struct clk_init_data init;
+	struct clk_init_data init =3D { 0 };
 	unsigned int i;
=20
 	for (i =3D 0; i < ARRAY_SIZE(isp->xclks); ++i)
diff --git a/drivers/media/usb/dvb-usb-v2/gl861.c b/drivers/media/usb/dvb-u=
sb-v2/gl861.c
index b1b09c547861..9d87161b5c13 100644
--- a/drivers/media/usb/dvb-usb-v2/gl861.c
+++ b/drivers/media/usb/dvb-usb-v2/gl861.c
@@ -20,14 +20,20 @@ static int gl861_i2c_msg(struct dvb_usb_device *d, u8 a=
ddr,
 	u16 value =3D addr << (8 + 1);
 	int wo =3D (rbuf =3D=3D NULL || rlen =3D=3D 0); /* write-only */
 	u8 req, type;
+	u8 *buf;
+	int ret;
=20
 	if (wo) {
 		req =3D GL861_REQ_I2C_WRITE;
 		type =3D GL861_WRITE;
+		buf =3D kmemdup(wbuf, wlen, GFP_KERNEL);
 	} else { /* rw */
 		req =3D GL861_REQ_I2C_READ;
 		type =3D GL861_READ;
+		buf =3D kmalloc(rlen, GFP_KERNEL);
 	}
+	if (!buf)
+		return -ENOMEM;
=20
 	switch (wlen) {
 	case 1:
@@ -40,13 +46,20 @@ static int gl861_i2c_msg(struct dvb_usb_device *d, u8 a=
ddr,
 	default:
 		dev_err(&d->udev->dev, "%s: wlen=3D%d, aborting\n",
 				KBUILD_MODNAME, wlen);
+		kfree(buf);
 		return -EINVAL;
 	}
=20
 	msleep(1); /* avoid I2C errors */
=20
-	return usb_control_msg(d->udev, usb_rcvctrlpipe(d->udev, 0), req, type,
-			       value, index, rbuf, rlen, 2000);
+	ret =3D usb_control_msg(d->udev, usb_rcvctrlpipe(d->udev, 0), req, type,
+			      value, index, buf, rlen, 2000);
+
+	if (!wo && ret > 0)
+		memcpy(rbuf, buf, rlen);
+
+	kfree(buf);
+	return ret;
 }
=20
 /* I2C */
diff --git a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c b/drivers/media/usb/dv=
b-usb-v2/rtl28xxu.c
index a676e4452847..b56f9eb536f2 100644
--- a/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
+++ b/drivers/media/usb/dvb-usb-v2/rtl28xxu.c
@@ -1379,7 +1379,7 @@ static int rtl2832u_rc_query(struct dvb_usb_device *d)
 		goto exit;
=20
 	ret =3D rtl28xx_rd_reg(d, IR_RX_BC, &buf[0]);
-	if (ret)
+	if (ret || buf[0] > sizeof(buf))
 		goto err;
=20
 	len =3D buf[0];
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 81e6d0932bf0..85bc3f7ce210 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -714,6 +714,7 @@ sm501_create_subdev(struct sm501_devdata *sm, char *nam=
e,
 	smdev->pdev.name =3D name;
 	smdev->pdev.id =3D sm->pdev_id;
 	smdev->pdev.dev.parent =3D sm->dev;
+	smdev->pdev.dev.coherent_dma_mask =3D 0xffffffff;
=20
 	if (res_count) {
 		smdev->pdev.resource =3D (struct resource *)(smdev+1);
diff --git a/drivers/misc/hmc6352.c b/drivers/misc/hmc6352.c
index 90520d76633f..9cde4c5bfba4 100644
--- a/drivers/misc/hmc6352.c
+++ b/drivers/misc/hmc6352.c
@@ -27,6 +27,7 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/sysfs.h>
+#include <linux/nospec.h>
=20
 static DEFINE_MUTEX(compass_mutex);
=20
@@ -50,6 +51,7 @@ static int compass_store(struct device *dev, const char *=
buf, size_t count,
 		return ret;
 	if (val >=3D strlen(map))
 		return -EINVAL;
+	val =3D array_index_nospec(val, strlen(map));
 	mutex_lock(&compass_mutex);
 	ret =3D compass_command(c, map[val]);
 	mutex_unlock(&compass_mutex);
diff --git a/drivers/misc/mei/nfc.c b/drivers/misc/mei/nfc.c
index b4d5cdda26cd..1b1fa85648be 100644
--- a/drivers/misc/mei/nfc.c
+++ b/drivers/misc/mei/nfc.c
@@ -292,7 +292,7 @@ static int mei_nfc_if_version(struct mei_nfc_dev *ndev)
 		return -ENOMEM;
=20
 	bytes_recv =3D __mei_cl_recv(cl, (u8 *)reply, if_version_length);
-	if (bytes_recv < if_version_length) {
+	if (bytes_recv < 0 || bytes_recv < if_version_length) {
 		dev_err(&dev->pdev->dev, "Could not read IF version\n");
 		ret =3D -EIO;
 		goto err;
diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmc=
i/vmci_queue_pair.c
index 1b7b303085d2..f929d7a837bb 100644
--- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
+++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
@@ -735,7 +735,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	retval =3D get_user_pages_fast((uintptr_t) produce_uva,
 				     produce_q->kernel_if->num_pages, 1,
 				     produce_q->kernel_if->u.h.header_page);
-	if (retval < produce_q->kernel_if->num_pages) {
+	if (retval < (int)produce_q->kernel_if->num_pages) {
 		pr_warn("get_user_pages(produce) failed (retval=3D%d)", retval);
 		qp_release_pages(produce_q->kernel_if->u.h.header_page,
 				 retval, false);
@@ -746,7 +746,7 @@ static int qp_host_get_user_memory(u64 produce_uva,
 	retval =3D get_user_pages_fast((uintptr_t) consume_uva,
 				     consume_q->kernel_if->num_pages, 1,
 				     consume_q->kernel_if->u.h.header_page);
-	if (retval < consume_q->kernel_if->num_pages) {
+	if (retval < (int)consume_q->kernel_if->num_pages) {
 		pr_warn("get_user_pages(consume) failed (retval=3D%d)", retval);
 		qp_release_pages(consume_q->kernel_if->u.h.header_page,
 				 retval, false);
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index a0f54e80670c..d044af062cfe 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -190,8 +190,12 @@ static ssize_t mtdchar_read(struct file *file, char __=
user *buf, size_t count,
=20
 	pr_debug("MTD_read\n");
=20
-	if (*ppos + count > mtd->size)
-		count =3D mtd->size - *ppos;
+	if (*ppos + count > mtd->size) {
+		if (*ppos < mtd->size)
+			count =3D mtd->size - *ppos;
+		else
+			count =3D 0;
+	}
=20
 	if (!count)
 		return 0;
@@ -276,7 +280,7 @@ static ssize_t mtdchar_write(struct file *file, const c=
har __user *buf, size_t c
=20
 	pr_debug("MTD_write\n");
=20
-	if (*ppos =3D=3D mtd->size)
+	if (*ppos >=3D mtd->size)
 		return -ENOSPC;
=20
 	if (*ppos + count > mtd->size)
diff --git a/drivers/mtd/nand/mxc_nand.c b/drivers/mtd/nand/mxc_nand.c
index 7cf0473c79e8..0bca3de41221 100644
--- a/drivers/mtd/nand/mxc_nand.c
+++ b/drivers/mtd/nand/mxc_nand.c
@@ -1360,7 +1360,7 @@ static const struct of_device_id mxcnd_dt_ids[] =3D {
 	{ /* sentinel */ }
 };
=20
-static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
+static int mxcnd_probe_dt(struct mxc_nand_host *host)
 {
 	struct device_node *np =3D host->dev->of_node;
 	struct mxc_nand_platform_data *pdata =3D &host->pdata;
@@ -1387,7 +1387,7 @@ static int __init mxcnd_probe_dt(struct mxc_nand_host=
 *host)
 	return 0;
 }
 #else
-static int __init mxcnd_probe_dt(struct mxc_nand_host *host)
+static int mxcnd_probe_dt(struct mxc_nand_host *host)
 {
 	return 1;
 }
diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-qu=
adspi.c
index d5269a26c839..56d39f2b22ce 100644
--- a/drivers/mtd/spi-nor/fsl-quadspi.c
+++ b/drivers/mtd/spi-nor/fsl-quadspi.c
@@ -138,15 +138,15 @@
 #define LUT_MODE		4
 #define LUT_MODE2		5
 #define LUT_MODE4		6
-#define LUT_READ		7
-#define LUT_WRITE		8
+#define LUT_FSL_READ		7
+#define LUT_FSL_WRITE		8
 #define LUT_JMP_ON_CS		9
 #define LUT_ADDR_DDR		10
 #define LUT_MODE_DDR		11
 #define LUT_MODE2_DDR		12
 #define LUT_MODE4_DDR		13
-#define LUT_READ_DDR		14
-#define LUT_WRITE_DDR		15
+#define LUT_FSL_READ_DDR		14
+#define LUT_FSL_WRITE_DDR		15
 #define LUT_DATA_LEARN		16
=20
 /*
@@ -306,7 +306,7 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
=20
 	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
 			base + QUADSPI_LUT(lut_base));
-	writel(LUT0(DUMMY, PAD1, dummy) | LUT1(READ, PAD4, rxfifo),
+	writel(LUT0(DUMMY, PAD1, dummy) | LUT1(FSL_READ, PAD4, rxfifo),
 			base + QUADSPI_LUT(lut_base + 1));
=20
 	/* Write enable */
@@ -327,11 +327,11 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
=20
 	writel(LUT0(CMD, PAD1, cmd) | LUT1(ADDR, PAD1, addrlen),
 			base + QUADSPI_LUT(lut_base));
-	writel(LUT0(WRITE, PAD1, 0), base + QUADSPI_LUT(lut_base + 1));
+	writel(LUT0(FSL_WRITE, PAD1, 0), base + QUADSPI_LUT(lut_base + 1));
=20
 	/* Read Status */
 	lut_base =3D SEQID_RDSR * 4;
-	writel(LUT0(CMD, PAD1, SPINOR_OP_RDSR) | LUT1(READ, PAD1, 0x1),
+	writel(LUT0(CMD, PAD1, SPINOR_OP_RDSR) | LUT1(FSL_READ, PAD1, 0x1),
 			base + QUADSPI_LUT(lut_base));
=20
 	/* Erase a sector */
@@ -356,17 +356,17 @@ static void fsl_qspi_init_lut(struct fsl_qspi *q)
=20
 	/* READ ID */
 	lut_base =3D SEQID_RDID * 4;
-	writel(LUT0(CMD, PAD1, SPINOR_OP_RDID) | LUT1(READ, PAD1, 0x8),
+	writel(LUT0(CMD, PAD1, SPINOR_OP_RDID) | LUT1(FSL_READ, PAD1, 0x8),
 			base + QUADSPI_LUT(lut_base));
=20
 	/* Write Register */
 	lut_base =3D SEQID_WRSR * 4;
-	writel(LUT0(CMD, PAD1, SPINOR_OP_WRSR) | LUT1(WRITE, PAD1, 0x2),
+	writel(LUT0(CMD, PAD1, SPINOR_OP_WRSR) | LUT1(FSL_WRITE, PAD1, 0x2),
 			base + QUADSPI_LUT(lut_base));
=20
 	/* Read Configuration Register */
 	lut_base =3D SEQID_RDCR * 4;
-	writel(LUT0(CMD, PAD1, SPINOR_OP_RDCR) | LUT1(READ, PAD1, 0x1),
+	writel(LUT0(CMD, PAD1, SPINOR_OP_RDCR) | LUT1(FSL_READ, PAD1, 0x1),
 			base + QUADSPI_LUT(lut_base));
=20
 	/* Write disable */
diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cad=
ence/macb.c
index 45b13fda6bed..996b3b7d93ec 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -1257,14 +1257,18 @@ static void macb_init_rings(struct macb *bp)
=20
 static void macb_reset_hw(struct macb *bp)
 {
+	u32 ctrl =3D macb_readl(bp, NCR);
+
 	/*
 	 * Disable RX and TX (XXX: Should we halt the transmission
 	 * more gracefully?)
 	 */
-	macb_writel(bp, NCR, 0);
+	ctrl &=3D ~(MACB_BIT(RE) | MACB_BIT(TE));
=20
 	/* Clear the stats registers (XXX: Update stats first?) */
-	macb_writel(bp, NCR, MACB_BIT(CLRSTAT));
+	ctrl |=3D MACB_BIT(CLRSTAT);
+
+	macb_writel(bp, NCR, ctrl);
=20
 	/* Clear all status flags */
 	macb_writel(bp, TSR, -1);
@@ -1400,7 +1404,7 @@ static void macb_init_hw(struct macb *bp)
 	macb_writel(bp, TBQP, bp->tx_ring_dma);
=20
 	/* Enable TX and RX */
-	macb_writel(bp, NCR, MACB_BIT(RE) | MACB_BIT(TE) | MACB_BIT(MPE));
+	macb_writel(bp, NCR, macb_readl(bp, NCR) | MACB_BIT(RE) | MACB_BIT(TE));
=20
 	/* Enable interrupts */
 	macb_writel(bp, IER, (MACB_RX_INT_FLAGS
diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/m=
arvell/mvneta.c
index f88649d5d209..6e6c2e0b779a 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -2475,7 +2475,6 @@ static int mvneta_change_mtu(struct net_device *dev, =
int mtu)
 	}
=20
 	mvneta_start_dev(pp);
-	mvneta_port_up(pp);
=20
 	netdev_update_features(dev);
=20
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h b/drivers/net/ethe=
rnet/qlogic/qlcnic/qlcnic.h
index be618b9e874f..706c40b1bfa5 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic.h
@@ -1793,7 +1793,8 @@ struct qlcnic_hardware_ops {
 	int (*config_loopback) (struct qlcnic_adapter *, u8);
 	int (*clear_loopback) (struct qlcnic_adapter *, u8);
 	int (*config_promisc_mode) (struct qlcnic_adapter *, u32);
-	void (*change_l2_filter) (struct qlcnic_adapter *, u64 *, u16);
+	void (*change_l2_filter)(struct qlcnic_adapter *adapter, u64 *addr,
+				 u16 vlan, struct qlcnic_host_tx_ring *tx_ring);
 	int (*get_board_info) (struct qlcnic_adapter *);
 	void (*set_mac_filter_count) (struct qlcnic_adapter *);
 	void (*free_mac_list) (struct qlcnic_adapter *);
@@ -2035,9 +2036,10 @@ static inline int qlcnic_nic_set_promisc(struct qlcn=
ic_adapter *adapter,
 }
=20
 static inline void qlcnic_change_filter(struct qlcnic_adapter *adapter,
-					u64 *addr, u16 id)
+					u64 *addr, u16 vlan,
+					struct qlcnic_host_tx_ring *tx_ring)
 {
-	adapter->ahw->hw_ops->change_l2_filter(adapter, addr, id);
+	adapter->ahw->hw_ops->change_l2_filter(adapter, addr, vlan, tx_ring);
 }
=20
 static inline int qlcnic_get_board_info(struct qlcnic_adapter *adapter)
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c b/drivers/=
net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
index a4a4ec0b68f8..0992867a3fff 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c
@@ -2095,7 +2095,8 @@ int qlcnic_83xx_sre_macaddr_change(struct qlcnic_adap=
ter *adapter, u8 *addr,
 }
=20
 void qlcnic_83xx_change_l2_filter(struct qlcnic_adapter *adapter, u64 *add=
r,
-				  u16 vlan_id)
+				  u16 vlan_id,
+				  struct qlcnic_host_tx_ring *tx_ring)
 {
 	u8 mac[ETH_ALEN];
 	memcpy(&mac, addr, ETH_ALEN);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h b/drivers/=
net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
index 2bf101a47d02..b12c2d7c78ce 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h
@@ -549,7 +549,8 @@ int qlcnic_83xx_wrt_reg_indirect(struct qlcnic_adapter =
*, ulong, u32);
 int qlcnic_83xx_nic_set_promisc(struct qlcnic_adapter *, u32);
 int qlcnic_83xx_config_hw_lro(struct qlcnic_adapter *, int);
 int qlcnic_83xx_config_rss(struct qlcnic_adapter *, int);
-void qlcnic_83xx_change_l2_filter(struct qlcnic_adapter *, u64 *, u16);
+void qlcnic_83xx_change_l2_filter(struct qlcnic_adapter *adapter, u64 *add=
r,
+				  u16 vlan, struct qlcnic_host_tx_ring *ring);
 int qlcnic_83xx_get_pci_info(struct qlcnic_adapter *, struct qlcnic_pci_in=
fo *);
 int qlcnic_83xx_set_nic_info(struct qlcnic_adapter *, struct qlcnic_info *=
);
 void qlcnic_83xx_initialize_nic(struct qlcnic_adapter *, int);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h b/drivers/net/e=
thernet/qlogic/qlcnic/qlcnic_hw.h
index cbe2399c30a0..480aa1f9f2e1 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h
@@ -172,7 +172,8 @@ int qlcnic_82xx_napi_add(struct qlcnic_adapter *adapter,
 			 struct net_device *netdev);
 void qlcnic_82xx_get_beacon_state(struct qlcnic_adapter *);
 void qlcnic_82xx_change_filter(struct qlcnic_adapter *adapter,
-			       u64 *uaddr, u16 vlan_id);
+			       u64 *uaddr, u16 vlan_id,
+			       struct qlcnic_host_tx_ring *tx_ring);
 int qlcnic_82xx_config_intr_coalesce(struct qlcnic_adapter *,
 				     struct ethtool_coalesce *);
 int qlcnic_82xx_set_rx_coalesce(struct qlcnic_adapter *);
diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/e=
thernet/qlogic/qlcnic/qlcnic_io.c
index df081f64c5c2..e42cd821559b 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -268,13 +268,12 @@ static void qlcnic_add_lb_filter(struct qlcnic_adapte=
r *adapter,
 }
=20
 void qlcnic_82xx_change_filter(struct qlcnic_adapter *adapter, u64 *uaddr,
-			       u16 vlan_id)
+			       u16 vlan_id, struct qlcnic_host_tx_ring *tx_ring)
 {
 	struct cmd_desc_type0 *hwdesc;
 	struct qlcnic_nic_req *req;
 	struct qlcnic_mac_req *mac_req;
 	struct qlcnic_vlan_req *vlan_req;
-	struct qlcnic_host_tx_ring *tx_ring =3D adapter->tx_ring;
 	u32 producer;
 	u64 word;
=20
@@ -301,7 +300,8 @@ void qlcnic_82xx_change_filter(struct qlcnic_adapter *a=
dapter, u64 *uaddr,
=20
 static void qlcnic_send_filter(struct qlcnic_adapter *adapter,
 			       struct cmd_desc_type0 *first_desc,
-			       struct sk_buff *skb)
+			       struct sk_buff *skb,
+			       struct qlcnic_host_tx_ring *tx_ring)
 {
 	struct vlan_ethhdr *vh =3D (struct vlan_ethhdr *)(skb->data);
 	struct ethhdr *phdr =3D (struct ethhdr *)(skb->data);
@@ -335,7 +335,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *a=
dapter,
 		    tmp_fil->vlan_id =3D=3D vlan_id) {
 			if (jiffies > (QLCNIC_READD_AGE * HZ + tmp_fil->ftime))
 				qlcnic_change_filter(adapter, &src_addr,
-						     vlan_id);
+						     vlan_id, tx_ring);
 			tmp_fil->ftime =3D jiffies;
 			return;
 		}
@@ -350,7 +350,7 @@ static void qlcnic_send_filter(struct qlcnic_adapter *a=
dapter,
 	if (!fil)
 		return;
=20
-	qlcnic_change_filter(adapter, &src_addr, vlan_id);
+	qlcnic_change_filter(adapter, &src_addr, vlan_id, tx_ring);
 	fil->ftime =3D jiffies;
 	fil->vlan_id =3D vlan_id;
 	memcpy(fil->faddr, &src_addr, ETH_ALEN);
@@ -766,7 +766,7 @@ netdev_tx_t qlcnic_xmit_frame(struct sk_buff *skb, stru=
ct net_device *netdev)
 	}
=20
 	if (adapter->drv_mac_learn)
-		qlcnic_send_filter(adapter, first_desc, skb);
+		qlcnic_send_filter(adapter, first_desc, skb, tx_ring);
=20
 	tx_ring->tx_stats.tx_bytes +=3D skb->len;
 	tx_ring->tx_stats.xmit_called++;
diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/re=
altek/r8169.c
index b1f22e199c3e..e962993557f0 100644
--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -6417,17 +6417,15 @@ static int rtl8169_poll(struct napi_struct *napi, i=
nt budget)
 	struct rtl8169_private *tp =3D container_of(napi, struct rtl8169_private,=
 napi);
 	struct net_device *dev =3D tp->dev;
 	u16 enable_mask =3D RTL_EVENT_NAPI | tp->event_slow;
-	int work_done=3D 0;
+	int work_done;
 	u16 status;
=20
 	status =3D rtl_get_events(tp);
 	rtl_ack_events(tp, status & ~tp->event_slow);
=20
-	if (status & RTL_EVENT_NAPI_RX)
-		work_done =3D rtl_rx(dev, tp, (u32) budget);
+	work_done =3D rtl_rx(dev, tp, (u32) budget);
=20
-	if (status & RTL_EVENT_NAPI_TX)
-		rtl_tx(dev, tp);
+	rtl_tx(dev, tp);
=20
 	if (status & tp->event_slow) {
 		enable_mask &=3D ~tp->event_slow;
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 942b887d2d27..53b5eebeb726 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -426,6 +426,9 @@ static int pppoe_rcv(struct sk_buff *skb, struct net_de=
vice *dev,
 	if (!skb)
 		goto out;
=20
+	if (skb_mac_header_len(skb) < ETH_HLEN)
+		goto drop;
+
 	if (!pskb_may_pull(skb, sizeof(struct pppoe_hdr)))
 		goto drop;
=20
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index d0f9aa4c59fc..d42bc7a55a03 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1124,6 +1124,11 @@ static int team_port_add(struct team *team, struct n=
et_device *port_dev)
 		return -EBUSY;
 	}
=20
+	if (dev =3D=3D port_dev) {
+		netdev_err(dev, "Cannot enslave team device to itself\n");
+		return -EINVAL;
+	}
+
 	if (port_dev->features & NETIF_F_VLAN_CHALLENGED &&
 	    vlan_uses_dev(dev)) {
 		netdev_err(dev, "Device %s is VLAN challenged and team device has VLAN s=
et up\n",
diff --git a/drivers/net/usb/asix_common.c b/drivers/net/usb/asix_common.c
index 75d6f26729a3..ad81af135a32 100644
--- a/drivers/net/usb/asix_common.c
+++ b/drivers/net/usb/asix_common.c
@@ -417,6 +417,9 @@ int asix_set_wol(struct net_device *net, struct ethtool=
_wolinfo *wolinfo)
 	struct usbnet *dev =3D netdev_priv(net);
 	u8 opt =3D 0;
=20
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |=3D AX_MONITOR_LINK;
 	if (wolinfo->wolopts & WAKE_MAGIC)
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 8cee173eefb2..5f66f4505b33 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -506,6 +506,9 @@ ax88179_set_wol(struct net_device *net, struct ethtool_=
wolinfo *wolinfo)
 	struct usbnet *dev =3D netdev_priv(net);
 	u8 opt =3D 0;
=20
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |=3D AX_MONITOR_MODE_RWLC;
 	if (wolinfo->wolopts & WAKE_MAGIC)
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 580793a8190e..6fa1d2c9c556 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -3106,6 +3106,9 @@ static int rtl8152_set_wol(struct net_device *dev, st=
ruct ethtool_wolinfo *wol)
 	struct r8152 *tp =3D netdev_priv(dev);
 	int ret;
=20
+	if (wol->wolopts & ~WAKE_ANY)
+		return -EINVAL;
+
 	ret =3D usb_autopm_get_interface(tp->intf);
 	if (ret < 0)
 		goto out_set_wol;
diff --git a/drivers/net/usb/smsc75xx.c b/drivers/net/usb/smsc75xx.c
index 551424d6f556..157d4a9a0b3a 100644
--- a/drivers/net/usb/smsc75xx.c
+++ b/drivers/net/usb/smsc75xx.c
@@ -728,6 +728,9 @@ static int smsc75xx_ethtool_set_wol(struct net_device *=
net,
 	struct smsc75xx_priv *pdata =3D (struct smsc75xx_priv *)(dev->data[0]);
 	int ret;
=20
+	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
+		return -EINVAL;
+
 	pdata->wolopts =3D wolinfo->wolopts & SUPPORTED_WAKE;
=20
 	ret =3D device_set_wakeup_enable(&dev->udev->dev, pdata->wolopts);
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index fc629c315adc..ae006e51f6e1 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -726,6 +726,9 @@ static int smsc95xx_ethtool_set_wol(struct net_device *=
net,
 	struct smsc95xx_priv *pdata =3D (struct smsc95xx_priv *)(dev->data[0]);
 	int ret;
=20
+	if (wolinfo->wolopts & ~SUPPORTED_WAKE)
+		return -EINVAL;
+
 	pdata->wolopts =3D wolinfo->wolopts & SUPPORTED_WAKE;
=20
 	ret =3D device_set_wakeup_enable(&dev->udev->dev, pdata->wolopts);
diff --git a/drivers/net/usb/sr9800.c b/drivers/net/usb/sr9800.c
index 953de13267df..0144fb19a099 100644
--- a/drivers/net/usb/sr9800.c
+++ b/drivers/net/usb/sr9800.c
@@ -421,6 +421,9 @@ sr_set_wol(struct net_device *net, struct ethtool_wolin=
fo *wolinfo)
 	struct usbnet *dev =3D netdev_priv(net);
 	u8 opt =3D 0;
=20
+	if (wolinfo->wolopts & ~(WAKE_PHY | WAKE_MAGIC))
+		return -EINVAL;
+
 	if (wolinfo->wolopts & WAKE_PHY)
 		opt |=3D SR_MONITOR_LINK;
 	if (wolinfo->wolopts & WAKE_MAGIC)
diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index 4bb359c79a32..b1aeef151ed4 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -685,8 +685,59 @@ static void vxlan_notify_del_rx_port(struct vxlan_sock=
 *vs)
 		udp_del_offload(&vs->udp_offloads);
 }
=20
-/* Add new entry to forwarding table -- assumes lock held */
+static struct vxlan_fdb *vxlan_fdb_alloc(struct vxlan_dev *vxlan,
+					 const u8 *mac, __u16 state,
+					 __u8 ndm_flags)
+{
+	struct vxlan_fdb *f;
+
+	f =3D kmalloc(sizeof(*f), GFP_ATOMIC);
+	if (!f)
+		return NULL;
+	f->state =3D state;
+	f->flags =3D ndm_flags;
+	f->updated =3D f->used =3D jiffies;
+	INIT_LIST_HEAD(&f->remotes);
+	memcpy(f->eth_addr, mac, ETH_ALEN);
+
+	return f;
+}
+
 static int vxlan_fdb_create(struct vxlan_dev *vxlan,
+			    const u8 *mac, union vxlan_addr *ip,
+			    __u16 state, __be16 port,
+			    __be32 vni, __u32 ifindex, __u8 ndm_flags,
+			    struct vxlan_fdb **fdb)
+{
+	struct vxlan_rdst *rd =3D NULL;
+	struct vxlan_fdb *f;
+	int rc;
+
+	if (vxlan->addrmax && vxlan->addrcnt >=3D vxlan->addrmax)
+		return -ENOSPC;
+
+	netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
+	f =3D vxlan_fdb_alloc(vxlan, mac, state, ndm_flags);
+	if (!f)
+		return -ENOMEM;
+
+	rc =3D vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
+	if (rc < 0) {
+		kfree(f);
+		return rc;
+	}
+
+	++vxlan->addrcnt;
+	hlist_add_head_rcu(&f->hlist,
+			   vxlan_fdb_head(vxlan, mac));
+
+	*fdb =3D f;
+
+	return 0;
+}
+
+/* Add new entry to forwarding table -- assumes lock held */
+static int vxlan_fdb_update(struct vxlan_dev *vxlan,
 			    const u8 *mac, union vxlan_addr *ip,
 			    __u16 state, __u16 flags,
 			    __be16 port, __u32 vni, __u32 ifindex,
@@ -695,6 +746,7 @@ static int vxlan_fdb_create(struct vxlan_dev *vxlan,
 	struct vxlan_rdst *rd =3D NULL;
 	struct vxlan_fdb *f;
 	int notify =3D 0;
+	int rc;
=20
 	f =3D __vxlan_find_mac(vxlan, mac);
 	if (f) {
@@ -729,8 +781,7 @@ static int vxlan_fdb_create(struct vxlan_dev *vxlan,
 		if ((flags & NLM_F_APPEND) &&
 		    (is_multicast_ether_addr(f->eth_addr) ||
 		     is_zero_ether_addr(f->eth_addr))) {
-			int rc =3D vxlan_fdb_append(f, ip, port, vni, ifindex,
-						  &rd);
+			rc =3D vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
=20
 			if (rc < 0)
 				return rc;
@@ -740,31 +791,17 @@ static int vxlan_fdb_create(struct vxlan_dev *vxlan,
 		if (!(flags & NLM_F_CREATE))
 			return -ENOENT;
=20
-		if (vxlan->addrmax && vxlan->addrcnt >=3D vxlan->addrmax)
-			return -ENOSPC;
-
 		/* Disallow replace to add a multicast entry */
 		if ((flags & NLM_F_REPLACE) &&
 		    (is_multicast_ether_addr(mac) || is_zero_ether_addr(mac)))
 			return -EOPNOTSUPP;
=20
 		netdev_dbg(vxlan->dev, "add %pM -> %pIS\n", mac, ip);
-		f =3D kmalloc(sizeof(*f), GFP_ATOMIC);
-		if (!f)
-			return -ENOMEM;
-
+		rc =3D vxlan_fdb_create(vxlan, mac, ip, state, port,
+				      vni, ifindex, ndm_flags, &f);
+		if (rc < 0)
+			return rc;
 		notify =3D 1;
-		f->state =3D state;
-		f->flags =3D ndm_flags;
-		f->updated =3D f->used =3D jiffies;
-		INIT_LIST_HEAD(&f->remotes);
-		memcpy(f->eth_addr, mac, ETH_ALEN);
-
-		vxlan_fdb_append(f, ip, port, vni, ifindex, &rd);
-
-		++vxlan->addrcnt;
-		hlist_add_head_rcu(&f->hlist,
-				   vxlan_fdb_head(vxlan, mac));
 	}
=20
 	if (notify) {
@@ -882,7 +919,7 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlat=
tr *tb[],
 		return -EAFNOSUPPORT;
=20
 	spin_lock_bh(&vxlan->hash_lock);
-	err =3D vxlan_fdb_create(vxlan, addr, &ip, ndm->ndm_state, flags,
+	err =3D vxlan_fdb_update(vxlan, addr, &ip, ndm->ndm_state, flags,
 			       port, vni, ifindex, ndm->ndm_flags);
 	spin_unlock_bh(&vxlan->hash_lock);
=20
@@ -1008,7 +1045,7 @@ static bool vxlan_snoop(struct net_device *dev,
=20
 		/* close off race between vxlan_flush and incoming packets */
 		if (netif_running(dev))
-			vxlan_fdb_create(vxlan, src_mac, src_ip,
+			vxlan_fdb_update(vxlan, src_mac, src_ip,
 					 NUD_REACHABLE,
 					 NLM_F_EXCL|NLM_F_CREATE,
 					 vxlan->dst_port,
@@ -2577,6 +2614,7 @@ static int vxlan_newlink(struct net *net, struct net_=
device *dev,
 	struct vxlan_net *vn =3D net_generic(net, vxlan_net_id);
 	struct vxlan_dev *vxlan =3D netdev_priv(dev), *tmp;
 	struct vxlan_rdst *dst =3D &vxlan->default_dst;
+	struct vxlan_fdb *f =3D NULL;
 	__u32 vni;
 	int err;
 	bool use_ipv6 =3D false;
@@ -2717,24 +2755,35 @@ static int vxlan_newlink(struct net *net, struct ne=
t_device *dev,
 		err =3D vxlan_fdb_create(vxlan, all_zeros_mac,
 				       &vxlan->default_dst.remote_ip,
 				       NUD_REACHABLE|NUD_PERMANENT,
-				       NLM_F_EXCL|NLM_F_CREATE,
 				       vxlan->dst_port,
 				       vxlan->default_dst.remote_vni,
 				       vxlan->default_dst.remote_ifindex,
-				       NTF_SELF);
+				       NTF_SELF, &f);
 		if (err)
 			return err;
 	}
=20
 	err =3D register_netdevice(dev);
+	if (err)
+		goto errout;
+
+	err =3D rtnl_configure_link(dev, NULL);
 	if (err) {
-		vxlan_fdb_delete_default(vxlan);
-		return err;
+		unregister_netdevice(dev);
+		goto errout;
 	}
=20
+	/* notify default fdb entry */
+	if (f)
+		vxlan_fdb_notify(vxlan, f, first_remote_rtnl(f), RTM_NEWNEIGH);
+
 	list_add(&vxlan->next, &vn->vxlan_list);
=20
 	return 0;
+errout:
+	if (f)
+		vxlan_fdb_destroy(vxlan, f);
+	return err;
 }
=20
 static void vxlan_dellink(struct net_device *dev, struct list_head *head)
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/a=
th/ath10k/mac.c
index a21080028c54..6a269c4b5c01 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -1724,6 +1724,13 @@ static int ath10k_update_channel_list(struct ath10k =
*ar)
 			passive =3D channel->flags & IEEE80211_CHAN_NO_IR;
 			ch->passive =3D passive;
=20
+			/* the firmware is ignoring the "radar" flag of the
+			 * channel and is scanning actively using Probe Requests
+			 * on "Radar detection"/DFS channels which are not
+			 * marked as "available"
+			 */
+			ch->passive |=3D ch->chan_radar;
+
 			ch->freq =3D channel->center_freq;
 			ch->min_power =3D 0;
 			ch->max_power =3D channel->max_power * 2;
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/=
ath/wil6210/wmi.c
index 6cc0e182cc70..94ecece55431 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -958,7 +958,12 @@ int wmi_set_ie(struct wil6210_priv *wil, u8 type, u16 =
ie_len, const void *ie)
 {
 	int rc;
 	u16 len =3D sizeof(struct wmi_set_appie_cmd) + ie_len;
-	struct wmi_set_appie_cmd *cmd =3D kzalloc(len, GFP_KERNEL);
+	struct wmi_set_appie_cmd *cmd;
+
+	if (len < ie_len)
+		return -EINVAL;
+
+	cmd =3D kzalloc(len, GFP_KERNEL);
 	if (!cmd)
 		return -ENOMEM;
=20
diff --git a/drivers/net/wireless/b43/leds.c b/drivers/net/wireless/b43/led=
s.c
index d79ab2a227e1..ba3965a114d9 100644
--- a/drivers/net/wireless/b43/leds.c
+++ b/drivers/net/wireless/b43/leds.c
@@ -131,7 +131,7 @@ static int b43_register_led(struct b43_wldev *dev, stru=
ct b43_led *led,
 	led->wl =3D dev->wl;
 	led->index =3D led_index;
 	led->activelow =3D activelow;
-	strncpy(led->name, name, sizeof(led->name));
+	strlcpy(led->name, name, sizeof(led->name));
 	atomic_set(&led->state, 0);
=20
 	led->led_dev.name =3D led->name;
diff --git a/drivers/net/wireless/b43legacy/leds.c b/drivers/net/wireless/b=
43legacy/leds.c
index fd4565389c77..bc922118b6ac 100644
--- a/drivers/net/wireless/b43legacy/leds.c
+++ b/drivers/net/wireless/b43legacy/leds.c
@@ -101,7 +101,7 @@ static int b43legacy_register_led(struct b43legacy_wlde=
v *dev,
 	led->dev =3D dev;
 	led->index =3D led_index;
 	led->activelow =3D activelow;
-	strncpy(led->name, name, sizeof(led->name));
+	strlcpy(led->name, name, sizeof(led->name));
=20
 	led->led_dev.name =3D led->name;
 	led->led_dev.default_trigger =3D default_trigger;
diff --git a/drivers/net/wireless/libertas/dev.h b/drivers/net/wireless/lib=
ertas/dev.h
index 6bd1608992b0..96cf205050b1 100644
--- a/drivers/net/wireless/libertas/dev.h
+++ b/drivers/net/wireless/libertas/dev.h
@@ -102,6 +102,7 @@ struct lbs_private {
 	u8 fw_ready;
 	u8 surpriseremoved;
 	u8 setup_fw_on_resume;
+	u8 power_up_on_resume;
 	int (*hw_host_to_card) (struct lbs_private *priv, u8 type, u8 *payload, u=
16 nb);
 	void (*reset_card) (struct lbs_private *priv);
 	int (*power_save) (struct lbs_private *priv);
diff --git a/drivers/net/wireless/libertas/if_sdio.c b/drivers/net/wireless=
/libertas/if_sdio.c
index 33ceda296c9c..bee1e67afafe 100644
--- a/drivers/net/wireless/libertas/if_sdio.c
+++ b/drivers/net/wireless/libertas/if_sdio.c
@@ -1342,15 +1342,23 @@ static void if_sdio_remove(struct sdio_func *func)
 static int if_sdio_suspend(struct device *dev)
 {
 	struct sdio_func *func =3D dev_to_sdio_func(dev);
-	int ret;
 	struct if_sdio_card *card =3D sdio_get_drvdata(func);
+	struct lbs_private *priv =3D card->priv;
+	int ret;
=20
 	mmc_pm_flag_t flags =3D sdio_get_host_pm_caps(func);
+	priv->power_up_on_resume =3D false;
=20
 	/* If we're powered off anyway, just let the mmc layer remove the
 	 * card. */
-	if (!lbs_iface_active(card->priv))
-		return -ENOSYS;
+	if (!lbs_iface_active(priv)) {
+		if (priv->fw_ready) {
+			priv->power_up_on_resume =3D true;
+			if_sdio_power_off(card);
+		}
+
+		return 0;
+	}
=20
 	dev_info(dev, "%s: suspend: PM flags =3D 0x%x\n",
 		 sdio_func_id(func), flags);
@@ -1358,9 +1366,18 @@ static int if_sdio_suspend(struct device *dev)
 	/* If we aren't being asked to wake on anything, we should bail out
 	 * and let the SD stack power down the card.
 	 */
-	if (card->priv->wol_criteria =3D=3D EHS_REMOVE_WAKEUP) {
+	if (priv->wol_criteria =3D=3D EHS_REMOVE_WAKEUP) {
 		dev_info(dev, "Suspend without wake params -- powering down card\n");
-		return -ENOSYS;
+		if (priv->fw_ready) {
+			ret =3D lbs_suspend(priv);
+			if (ret)
+				return ret;
+
+			priv->power_up_on_resume =3D true;
+			if_sdio_power_off(card);
+		}
+
+		return 0;
 	}
=20
 	if (!(flags & MMC_PM_KEEP_POWER)) {
@@ -1373,7 +1390,7 @@ static int if_sdio_suspend(struct device *dev)
 	if (ret)
 		return ret;
=20
-	ret =3D lbs_suspend(card->priv);
+	ret =3D lbs_suspend(priv);
 	if (ret)
 		return ret;
=20
@@ -1388,6 +1405,11 @@ static int if_sdio_resume(struct device *dev)
=20
 	dev_info(dev, "%s: resume: we're back\n", sdio_func_id(func));
=20
+	if (card->priv->power_up_on_resume) {
+		if_sdio_power_on(card);
+		wait_event(card->pwron_waitq, card->priv->fw_ready);
+	}
+
 	ret =3D lbs_resume(card->priv);
=20
 	return ret;
diff --git a/drivers/net/wireless/rndis_wlan.c b/drivers/net/wireless/rndis=
_wlan.c
index 19a1c9cde772..730aaf9c93d2 100644
--- a/drivers/net/wireless/rndis_wlan.c
+++ b/drivers/net/wireless/rndis_wlan.c
@@ -2917,6 +2917,8 @@ static void rndis_wlan_auth_indication(struct usbnet =
*usbdev,
=20
 	while (buflen >=3D sizeof(*auth_req)) {
 		auth_req =3D (void *)buf;
+		if (buflen < le32_to_cpu(auth_req->length))
+			return;
 		type =3D "unknown";
 		flags =3D le32_to_cpu(auth_req->flags);
 		pairwise_error =3D false;
diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index 7375720ddb0a..08ab42ce81a6 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1632,6 +1632,7 @@ static int xennet_init_queue(struct netfront_queue *q=
ueue)
 {
 	unsigned short i;
 	int err =3D 0;
+	char *devid;
=20
 	spin_lock_init(&queue->tx_lock);
 	spin_lock_init(&queue->rx_lock);
@@ -1645,8 +1646,9 @@ static int xennet_init_queue(struct netfront_queue *q=
ueue)
 	queue->rx_refill_timer.data =3D (unsigned long)queue;
 	queue->rx_refill_timer.function =3D rx_refill_timeout;
=20
-	snprintf(queue->name, sizeof(queue->name), "%s-q%u",
-		 queue->info->netdev->name, queue->id);
+	devid =3D strrchr(queue->info->xbdev->nodename, '/') + 1;
+	snprintf(queue->name, sizeof(queue->name), "vif%s-q%u",
+		 devid, queue->id);
=20
 	/* Initialise tx_skbs as a free chain containing every entry. */
 	queue->tx_skb_freelist =3D 0;
diff --git a/drivers/of/selftest.c b/drivers/of/selftest.c
index 2089ceb6d085..13582c3cd06d 100644
--- a/drivers/of/selftest.c
+++ b/drivers/of/selftest.c
@@ -326,6 +326,9 @@ static void __init of_selftest_parse_interrupts(void)
 	struct of_phandle_args args;
 	int i, rc;
=20
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		return;
+
 	np =3D of_find_node_by_path("/testcase-data/interrupts/interrupts0");
 	if (!np) {
 		pr_err("missing testcase data\n");
@@ -398,6 +401,9 @@ static void __init of_selftest_parse_interrupts_extende=
d(void)
 	struct of_phandle_args args;
 	int i, rc;
=20
+	if (of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)
+		return;
+
 	np =3D of_find_node_by_path("/testcase-data/interrupts/interrupts-extende=
d0");
 	if (!np) {
 		pr_err("missing testcase data\n");
@@ -545,15 +551,19 @@ static void __init of_selftest_platform_populate(void)
 	pdev =3D of_find_device_by_node(np);
 	selftest(pdev, "device 1 creation failed\n");
=20
-	irq =3D platform_get_irq(pdev, 0);
-	selftest(irq =3D=3D -EPROBE_DEFER, "device deferred probe failed - %d\n",=
 irq);
-
-	/* Test that a parsing failure does not return -EPROBE_DEFER */
-	np =3D of_find_node_by_path("/testcase-data/testcase-device2");
-	pdev =3D of_find_device_by_node(np);
-	selftest(pdev, "device 2 creation failed\n");
-	irq =3D platform_get_irq(pdev, 0);
-	selftest(irq < 0 && irq !=3D -EPROBE_DEFER, "device parsing error failed =
- %d\n", irq);
+	if (!(of_irq_workarounds & OF_IMAP_OLDWORLD_MAC)) {
+		irq =3D platform_get_irq(pdev, 0);
+		selftest(irq =3D=3D -EPROBE_DEFER,
+			 "device deferred probe failed - %d\n", irq);
+
+		/* Test that a parsing failure does not return -EPROBE_DEFER */
+		np =3D of_find_node_by_path("/testcase-data/testcase-device2");
+		pdev =3D of_find_device_by_node(np);
+		selftest(pdev, "device 2 creation failed\n");
+		irq =3D platform_get_irq(pdev, 0);
+		selftest(irq < 0 && irq !=3D -EPROBE_DEFER,
+			 "device parsing error failed - %d\n", irq);
+	}
=20
 	np =3D of_find_node_by_path("/testcase-data/platform-tests");
 	if (!np) {
diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
index db5abef6cec0..1258236694c2 100644
--- a/drivers/pci/host/pci-mvebu.c
+++ b/drivers/pci/host/pci-mvebu.c
@@ -940,7 +940,7 @@ static int mvebu_pcie_probe(struct platform_device *pde=
v)
 		pcie->realio.start =3D PCIBIOS_MIN_IO;
 		pcie->realio.end =3D min_t(resource_size_t,
 					 IO_SPACE_LIMIT,
-					 resource_size(&pcie->io));
+					 resource_size(&pcie->io) - 1);
 	} else
 		pcie->realio =3D pcie->io;
=20
diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/p=
ci_hotplug_core.c
index 56d8486dc167..cdc109ec5b82 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -457,8 +457,17 @@ int __pci_hp_register(struct hotplug_slot *slot, struc=
t pci_bus *bus,
 	list_add(&slot->slot_list, &pci_hotplug_slot_list);
=20
 	result =3D fs_add_slot(pci_slot);
+	if (result)
+		goto err_list_del;
+
 	kobject_uevent(&pci_slot->kobj, KOBJ_ADD);
 	dbg("Added slot %s to the list\n", name);
+	goto out;
+
+err_list_del:
+	list_del(&slot->slot_list);
+	pci_slot->hotplug =3D NULL;
+	pci_destroy_slot(pci_slot);
 out:
 	mutex_unlock(&pci_hp_mutex);
 	return result;
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 3e6f98d80fbe..f35692c0e0c3 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -141,6 +141,7 @@ int pciehp_unconfigure_device(struct slot *p_slot);
 void pciehp_queue_pushbutton_work(struct work_struct *work);
 struct controller *pcie_init(struct pcie_device *dev);
 int pcie_init_notification(struct controller *ctrl);
+void pcie_shutdown_notification(struct controller *ctrl);
 int pciehp_enable_slot(struct slot *p_slot);
 int pciehp_disable_slot(struct slot *p_slot);
 void pcie_reenable_notification(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp=
_core.c
index 688bf665991b..dc839576cbe2 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -82,6 +82,10 @@ static void release_slot(struct hotplug_slot *hotplug_sl=
ot)
 	ctrl_dbg(slot->ctrl, "%s: physical_slot =3D %s\n",
 		 __func__, hotplug_slot_name(hotplug_slot));
=20
+	/* queued work needs hotplug_slot name */
+	cancel_delayed_work(&slot->work);
+	drain_workqueue(slot->wq);
+
 	kfree(hotplug_slot->ops);
 	kfree(hotplug_slot->info);
 	kfree(hotplug_slot);
@@ -313,6 +317,7 @@ static void pciehp_remove(struct pcie_device *dev)
 {
 	struct controller *ctrl =3D get_service_data(dev);
=20
+	pcie_shutdown_notification(ctrl);
 	cleanup_slot(ctrl);
 	pciehp_release_ctrl(ctrl);
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_=
hpc.c
index 70664905f8b4..3406cefc174c 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -508,8 +508,6 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl =3D (struct controller *)dev_id;
 	struct pci_dev *pdev =3D ctrl_dev(ctrl);
-	struct pci_bus *subordinate =3D pdev->subordinate;
-	struct pci_dev *dev;
 	struct slot *slot =3D ctrl->slot;
 	u16 detected, intr_loc;
=20
@@ -543,14 +541,9 @@ static irqreturn_t pcie_isr(int irq, void *dev_id)
 		wake_up(&ctrl->queue);
 	}
=20
-	if (subordinate) {
-		list_for_each_entry(dev, &subordinate->devices, bus_list) {
-			if (dev->ignore_hotplug) {
-				ctrl_dbg(ctrl, "ignoring hotplug event %#06x (%s requested no hotplug)=
\n",
-					 intr_loc, pci_name(dev));
-				return IRQ_HANDLED;
-			}
-		}
+	if (pdev->ignore_hotplug) {
+		ctrl_dbg(ctrl, "ignoring hotplug event %#06x\n", intr_loc);
+		return IRQ_HANDLED;
 	}
=20
 	if (!(intr_loc & ~PCI_EXP_SLTSTA_CC))
@@ -687,7 +680,7 @@ int pcie_init_notification(struct controller *ctrl)
 	return 0;
 }
=20
-static void pcie_shutdown_notification(struct controller *ctrl)
+void pcie_shutdown_notification(struct controller *ctrl)
 {
 	if (ctrl->notification_enabled) {
 		pcie_disable_notification(ctrl);
@@ -722,7 +715,7 @@ static int pcie_init_slot(struct controller *ctrl)
 static void pcie_cleanup_slot(struct controller *ctrl)
 {
 	struct slot *slot =3D ctrl->slot;
-	cancel_delayed_work(&slot->work);
+
 	destroy_workqueue(slot->wq);
 	kfree(slot);
 }
@@ -846,7 +839,6 @@ struct controller *pcie_init(struct pcie_device *dev)
=20
 void pciehp_release_ctrl(struct controller *ctrl)
 {
-	pcie_shutdown_notification(ctrl);
 	pcie_cleanup_slot(ctrl);
 	kfree(ctrl);
 }
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 435d3830c181..8490e0e1ed07 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1014,12 +1014,12 @@ int pci_save_state(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_save_state);
=20
 static void pci_restore_config_dword(struct pci_dev *pdev, int offset,
-				     u32 saved_val, int retry)
+				     u32 saved_val, int retry, bool force)
 {
 	u32 val;
=20
 	pci_read_config_dword(pdev, offset, &val);
-	if (val =3D=3D saved_val)
+	if (!force && val =3D=3D saved_val)
 		return;
=20
 	for (;;) {
@@ -1038,25 +1038,36 @@ static void pci_restore_config_dword(struct pci_dev=
 *pdev, int offset,
 }
=20
 static void pci_restore_config_space_range(struct pci_dev *pdev,
-					   int start, int end, int retry)
+					   int start, int end, int retry,
+					   bool force)
 {
 	int index;
=20
 	for (index =3D end; index >=3D start; index--)
 		pci_restore_config_dword(pdev, 4 * index,
 					 pdev->saved_config_space[index],
-					 retry);
+					 retry, force);
 }
=20
 static void pci_restore_config_space(struct pci_dev *pdev)
 {
 	if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_NORMAL) {
-		pci_restore_config_space_range(pdev, 10, 15, 0);
+		pci_restore_config_space_range(pdev, 10, 15, 0, false);
 		/* Restore BARs before the command register. */
-		pci_restore_config_space_range(pdev, 4, 9, 10);
-		pci_restore_config_space_range(pdev, 0, 3, 0);
+		pci_restore_config_space_range(pdev, 4, 9, 10, false);
+		pci_restore_config_space_range(pdev, 0, 3, 0, false);
+	} else if (pdev->hdr_type =3D=3D PCI_HEADER_TYPE_BRIDGE) {
+		pci_restore_config_space_range(pdev, 12, 15, 0, false);
+
+		/*
+		 * Force rewriting of prefetch registers to avoid S3 resume
+		 * issues on Intel PCI bridges that occur when these
+		 * registers are not explicitly written.
+		 */
+		pci_restore_config_space_range(pdev, 9, 11, 0, true);
+		pci_restore_config_space_range(pdev, 0, 8, 0, false);
 	} else {
-		pci_restore_config_space_range(pdev, 0, 15, 0);
+		pci_restore_config_space_range(pdev, 0, 15, 0, false);
 	}
 }
=20
diff --git a/drivers/pinctrl/berlin/berlin.c b/drivers/pinctrl/berlin/berli=
n.c
index 86db2235ab00..605a50a7dc8a 100644
--- a/drivers/pinctrl/berlin/berlin.c
+++ b/drivers/pinctrl/berlin/berlin.c
@@ -237,9 +237,8 @@ static int berlin_pinctrl_build_state(struct platform_d=
evice *pdev)
 	}
=20
 	/* we will reallocate later */
-	pctrl->functions =3D devm_kzalloc(&pdev->dev,
-					max_functions * sizeof(*pctrl->functions),
-					GFP_KERNEL);
+	pctrl->functions =3D kcalloc(max_functions,
+				   sizeof(*pctrl->functions), GFP_KERNEL);
 	if (!pctrl->functions)
 		return -ENOMEM;
=20
@@ -277,8 +276,10 @@ static int berlin_pinctrl_build_state(struct platform_=
device *pdev)
 				function++;
 			}
=20
-			if (!found)
+			if (!found) {
+				kfree(pctrl->functions);
 				return -EINVAL;
+			}
=20
 			if (!function->groups) {
 				function->groups =3D
@@ -286,8 +287,10 @@ static int berlin_pinctrl_build_state(struct platform_=
device *pdev)
 						     function->ngroups * sizeof(char *),
 						     GFP_KERNEL);
=20
-				if (!function->groups)
+				if (!function->groups) {
+					kfree(pctrl->functions);
 					return -ENOMEM;
+				}
 			}
=20
 			groups =3D function->groups;
diff --git a/drivers/pinctrl/pinctrl-imx.c b/drivers/pinctrl/pinctrl-imx.c
index 1c489e179149..1864c34659c2 100644
--- a/drivers/pinctrl/pinctrl-imx.c
+++ b/drivers/pinctrl/pinctrl-imx.c
@@ -388,7 +388,7 @@ static void imx_pinconf_group_dbg_show(struct pinctrl_d=
ev *pctldev,
 	const char *name;
 	int i, ret;
=20
-	if (group > info->ngroups)
+	if (group >=3D info->ngroups)
 		return;
=20
 	seq_printf(s, "\n");
diff --git a/drivers/pinctrl/pinctrl-imx1-core.c b/drivers/pinctrl/pinctrl-=
imx1-core.c
index 815384b377b5..e1abb0f0cd8d 100644
--- a/drivers/pinctrl/pinctrl-imx1-core.c
+++ b/drivers/pinctrl/pinctrl-imx1-core.c
@@ -435,7 +435,7 @@ static void imx1_pinconf_group_dbg_show(struct pinctrl_=
dev *pctldev,
 	const char *name;
 	int i, ret;
=20
-	if (group > info->ngroups)
+	if (group >=3D info->ngroups)
 		return;
=20
 	seq_puts(s, "\n");
diff --git a/drivers/pinctrl/pinctrl-msm.c b/drivers/pinctrl/pinctrl-msm.c
index df6dda4ce803..82554fcec0bf 100644
--- a/drivers/pinctrl/pinctrl-msm.c
+++ b/drivers/pinctrl/pinctrl-msm.c
@@ -275,13 +275,19 @@ static int msm_config_group_get(struct pinctrl_dev *p=
ctldev,
 	/* Convert register value to pinconf value */
 	switch (param) {
 	case PIN_CONFIG_BIAS_DISABLE:
-		arg =3D arg =3D=3D MSM_NO_PULL;
+		if (arg !=3D MSM_NO_PULL)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_DOWN:
-		arg =3D arg =3D=3D MSM_PULL_DOWN;
+		if (arg !=3D MSM_PULL_DOWN)
+			return -EINVAL;
+		arg =3D 1;
 		break;
 	case PIN_CONFIG_BIAS_PULL_UP:
 		arg =3D arg =3D=3D MSM_PULL_UP;
+		if (!arg)
+			return -EINVAL;
 		break;
 	case PIN_CONFIG_DRIVE_STRENGTH:
 		arg =3D msm_regval_to_drive(arg);
diff --git a/drivers/platform/x86/alienware-wmi.c b/drivers/platform/x86/al=
ienware-wmi.c
index 297b6640213f..2899727069e6 100644
--- a/drivers/platform/x86/alienware-wmi.c
+++ b/drivers/platform/x86/alienware-wmi.c
@@ -447,6 +447,7 @@ static acpi_status alienware_hdmi_command(struct hdmi_a=
rgs *in_args,
 		if (obj && obj->type =3D=3D ACPI_TYPE_INTEGER)
 			*out_data =3D (u32) obj->integer.value;
 	}
+	kfree(output.pointer);
 	return status;
=20
 }
diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/i=
deapad-laptop.c
index 64015cc978b1..84f0d74c5440 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -859,6 +859,13 @@ static struct dmi_system_id no_hw_rfkill_list[] =3D {
 			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad Y700-17ISK"),
 		},
 	},
+	{
+		.ident =3D "Lenovo Legion Y520-15IKB",
+		.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Y520-15IKB"),
+		},
+	},
 	{
 		.ident =3D "Lenovo Yoga 2 11 / 13 / Pro",
 		.matches =3D {
diff --git a/drivers/power/generic-adc-battery.c b/drivers/power/generic-ad=
c-battery.c
index 59a1421f9288..8e3e069996aa 100644
--- a/drivers/power/generic-adc-battery.c
+++ b/drivers/power/generic-adc-battery.c
@@ -241,10 +241,10 @@ static int gab_probe(struct platform_device *pdev)
 	struct gab *adc_bat;
 	struct power_supply *psy;
 	struct gab_platform_data *pdata =3D pdev->dev.platform_data;
-	enum power_supply_property *properties;
 	int ret =3D 0;
 	int chan;
-	int index =3D 0;
+	int index =3D ARRAY_SIZE(gab_props);
+	bool any =3D false;
=20
 	adc_bat =3D devm_kzalloc(&pdev->dev, sizeof(*adc_bat), GFP_KERNEL);
 	if (!adc_bat) {
@@ -276,8 +276,6 @@ static int gab_probe(struct platform_device *pdev)
 	}
=20
 	memcpy(psy->properties, gab_props, sizeof(gab_props));
-	properties =3D (enum power_supply_property *)
-				((char *)psy->properties + sizeof(gab_props));
=20
 	/*
 	 * getting channel from iio and copying the battery properties
@@ -291,15 +289,22 @@ static int gab_probe(struct platform_device *pdev)
 			adc_bat->channel[chan] =3D NULL;
 		} else {
 			/* copying properties for supported channels only */
-			memcpy(properties + sizeof(*(psy->properties)) * index,
-					&gab_dyn_props[chan],
-					sizeof(gab_dyn_props[chan]));
-			index++;
+			int index2;
+
+			for (index2 =3D 0; index2 < index; index2++) {
+				if (psy->properties[index2] =3D=3D
+				    gab_dyn_props[chan])
+					break;	/* already known */
+			}
+			if (index2 =3D=3D index)	/* really new */
+				psy->properties[index++] =3D
+					gab_dyn_props[chan];
+			any =3D true;
 		}
 	}
=20
 	/* none of the channels are supported so let's bail out */
-	if (index =3D=3D 0) {
+	if (!any) {
 		ret =3D -ENODEV;
 		goto second_mem_fail;
 	}
@@ -310,7 +315,7 @@ static int gab_probe(struct platform_device *pdev)
 	 * as come channels may be not be supported by the device.So
 	 * we need to take care of that.
 	 */
-	psy->num_properties =3D ARRAY_SIZE(gab_props) + index;
+	psy->num_properties =3D index;
=20
 	ret =3D power_supply_register(&pdev->dev, psy);
 	if (ret)
diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 419056d7887e..f5cf901b2f2b 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -23,6 +23,8 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
=20
+#include <linux/nospec.h>
+
 #include "ptp_private.h"
=20
 static int ptp_disable_pinfunc(struct ptp_clock_info *ops,
@@ -228,6 +230,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd=
, unsigned long arg)
 			err =3D -EINVAL;
 			break;
 		}
+		pin_index =3D array_index_nospec(pin_index, ops->n_pins);
 		if (mutex_lock_interruptible(&ptp->pincfg_mux))
 			return -ERESTARTSYS;
 		pd =3D ops->pin_config[pin_index];
@@ -246,6 +249,7 @@ long ptp_ioctl(struct posix_clock *pc, unsigned int cmd=
, unsigned long arg)
 			err =3D -EINVAL;
 			break;
 		}
+		pin_index =3D array_index_nospec(pin_index, ops->n_pins);
 		if (mutex_lock_interruptible(&ptp->pincfg_mux))
 			return -ERESTARTSYS;
 		err =3D ptp_set_pinfunc(ptp, pin_index, pd.func, pd.chan);
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 95f1ea79e7b6..5fa585a817d9 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -35,10 +35,6 @@
 #define TBCTL			0x00
 #define TBPRD			0x0A
=20
-#define TBCTL_RUN_MASK		(BIT(15) | BIT(14))
-#define TBCTL_STOP_NEXT		0
-#define TBCTL_STOP_ON_CYCLE	BIT(14)
-#define TBCTL_FREE_RUN		(BIT(15) | BIT(14))
 #define TBCTL_PRDLD_MASK	BIT(3)
 #define TBCTL_PRDLD_SHDW	0
 #define TBCTL_PRDLD_IMDT	BIT(3)
@@ -357,7 +353,7 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, str=
uct pwm_device *pwm)
 	/* Channels polarity can be configured from action qualifier module */
 	configure_polarity(pc, pwm->hwpwm);
=20
-	/* Enable TBCLK before enabling PWM device */
+	/* Enable TBCLK */
 	ret =3D clk_enable(pc->tbclk);
 	if (ret) {
 		dev_err(chip->dev, "Failed to enable TBCLK for %s\n",
@@ -365,8 +361,6 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, str=
uct pwm_device *pwm)
 		return ret;
 	}
=20
-	/* Enable time counter for free_run */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_FREE_RUN);
 	return 0;
 }
=20
@@ -384,6 +378,8 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, s=
truct pwm_device *pwm)
 		aqcsfrc_mask =3D AQCSFRC_CSFA_MASK;
 	}
=20
+	/* Update shadow register first before modifying active register */
+	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 	/*
 	 * Changes to immediate action on Action Qualifier. This puts
 	 * Action Qualifier control on PWM output from next TBCLK
@@ -396,9 +392,6 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, s=
truct pwm_device *pwm)
 	/* Disabling TBCLK on PWM disable */
 	clk_disable(pc->tbclk);
=20
-	/* Stop Time base counter */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_STOP_NEXT);
-
 	/* Disable clock on PWM disable */
 	pm_runtime_put_sync(chip->dev);
 }
diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 71fb2037e0b9..04c482d59955 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3470,14 +3470,13 @@ regulator_register(const struct regulator_desc *reg=
ulator_desc,
 	rdev->dev.parent =3D dev;
 	dev_set_name(&rdev->dev, "regulator.%d",
 		     atomic_inc_return(&regulator_no) - 1);
+	dev_set_drvdata(&rdev->dev, rdev);
 	ret =3D device_register(&rdev->dev);
 	if (ret !=3D 0) {
 		put_device(&rdev->dev);
 		goto clean;
 	}
=20
-	dev_set_drvdata(&rdev->dev, rdev);
-
 	if (config->ena_gpio && gpio_is_valid(config->ena_gpio)) {
 		ret =3D regulator_ena_gpio_request(rdev, config);
 		if (ret !=3D 0) {
diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
index fb7298920c8c..90f93c2be8cd 100644
--- a/drivers/s390/cio/qdio_main.c
+++ b/drivers/s390/cio/qdio_main.c
@@ -640,21 +640,20 @@ static inline unsigned long qdio_aob_for_buffer(struc=
t qdio_output_q *q,
 	unsigned long phys_aob =3D 0;
=20
 	if (!q->use_cq)
-		goto out;
+		return 0;
=20
 	if (!q->aobs[bufnr]) {
 		struct qaob *aob =3D qdio_allocate_aob();
 		q->aobs[bufnr] =3D aob;
 	}
 	if (q->aobs[bufnr]) {
-		q->sbal_state[bufnr].flags =3D QDIO_OUTBUF_STATE_FLAG_NONE;
 		q->sbal_state[bufnr].aob =3D q->aobs[bufnr];
 		q->aobs[bufnr]->user1 =3D (u64) q->sbal_state[bufnr].user;
 		phys_aob =3D virt_to_phys(q->aobs[bufnr]);
 		WARN_ON_ONCE(phys_aob & 0xFF);
 	}
=20
-out:
+	q->sbal_state[bufnr].flags =3D 0;
 	return phys_aob;
 }
=20
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic=
94xx_init.c
index c56741fc4b99..f2d5dc164c00 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -1047,8 +1047,10 @@ static int __init aic94xx_init(void)
=20
 	aic94xx_transport_template =3D
 		sas_domain_attach_transport(&aic94xx_transport_functions);
-	if (!aic94xx_transport_template)
+	if (!aic94xx_transport_template) {
+		err =3D -ENOMEM;
 		goto out_destroy_caches;
+	}
=20
 	err =3D pci_register_driver(&aic94xx_pci_driver);
 	if (err)
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 5c35a9578dd7..f26efaf3e7f1 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -651,8 +651,24 @@ static ssize_t
 sdev_store_delete(struct device *dev, struct device_attribute *attr,
 		  const char *buf, size_t count)
 {
-	if (device_remove_file_self(dev, attr))
-		scsi_remove_device(to_scsi_device(dev));
+	struct kernfs_node *kn;
+
+	kn =3D sysfs_break_active_protection(&dev->kobj, &attr->attr);
+	WARN_ON_ONCE(!kn);
+	/*
+	 * Concurrent writes into the "delete" sysfs attribute may trigger
+	 * concurrent calls to device_remove_file() and scsi_remove_device().
+	 * device_remove_file() handles concurrent removal calls by
+	 * serializing these and by ignoring the second and later removal
+	 * attempts.  Concurrent calls of scsi_remove_device() are
+	 * serialized. The second and later calls of scsi_remove_device() are
+	 * ignored because the first call of that function changes the device
+	 * state into SDEV_DEL.
+	 */
+	device_remove_file(dev, attr);
+	scsi_remove_device(to_scsi_device(dev));
+	if (kn)
+		sysfs_unbreak_active_protection(kn);
 	return count;
 };
 static DEVICE_ATTR(delete, S_IWUSR, NULL, sdev_store_delete);
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 42ecf4c18e2e..b8d67f9f9077 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -500,9 +500,11 @@ static void virtio_scsi_init_hdr_pi(struct virtio_scsi=
_cmd_req_pi *cmd_pi,
 	bi =3D blk_get_integrity(rq->rq_disk);
=20
 	if (sc->sc_data_direction =3D=3D DMA_TO_DEVICE)
-		cmd_pi->pi_bytesout =3D blk_rq_sectors(rq) * bi->tuple_size;
+		cmd_pi->pi_bytesout =3D bio_integrity_bytes(bi,
+							blk_rq_sectors(rq));
 	else if (sc->sc_data_direction =3D=3D DMA_FROM_DEVICE)
-		cmd_pi->pi_bytesin =3D blk_rq_sectors(rq) * bi->tuple_size;
+		cmd_pi->pi_bytesin =3D bio_integrity_bytes(bi,
+							blk_rq_sectors(rq));
 }
=20
 static int virtscsi_queuecommand(struct virtio_scsi *vscsi,
diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index ddee9df1547d..237ebbce8282 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -472,25 +472,52 @@ static int rspi_dma_transfer(struct rspi_data *rspi, =
struct sg_table *tx,
 	dma_cookie_t cookie;
 	int ret;
=20
-	if (tx) {
-		desc_tx =3D dmaengine_prep_slave_sg(rspi->master->dma_tx,
-					tx->sgl, tx->nents, DMA_TO_DEVICE,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc_tx)
-			return -EIO;
-
-		irq_mask |=3D SPCR_SPTIE;
-	}
+	/* First prepare and submit the DMA request(s), as this may fail */
 	if (rx) {
 		desc_rx =3D dmaengine_prep_slave_sg(rspi->master->dma_rx,
 					rx->sgl, rx->nents, DMA_FROM_DEVICE,
 					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
-		if (!desc_rx)
-			return -EIO;
+		if (!desc_rx) {
+			ret =3D -EAGAIN;
+			goto no_dma_rx;
+		}
+
+		desc_rx->callback =3D rspi_dma_complete;
+		desc_rx->callback_param =3D rspi;
+		cookie =3D dmaengine_submit(desc_rx);
+		if (dma_submit_error(cookie)) {
+			ret =3D cookie;
+			goto no_dma_rx;
+		}
=20
 		irq_mask |=3D SPCR_SPRIE;
 	}
=20
+	if (tx) {
+		desc_tx =3D dmaengine_prep_slave_sg(rspi->master->dma_tx,
+					tx->sgl, tx->nents, DMA_TO_DEVICE,
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+		if (!desc_tx) {
+			ret =3D -EAGAIN;
+			goto no_dma_tx;
+		}
+
+		if (rx) {
+			/* No callback */
+			desc_tx->callback =3D NULL;
+		} else {
+			desc_tx->callback =3D rspi_dma_complete;
+			desc_tx->callback_param =3D rspi;
+		}
+		cookie =3D dmaengine_submit(desc_tx);
+		if (dma_submit_error(cookie)) {
+			ret =3D cookie;
+			goto no_dma_tx;
+		}
+
+		irq_mask |=3D SPCR_SPTIE;
+	}
+
 	/*
 	 * DMAC needs SPxIE, but if SPxIE is set, the IRQ routine will be
 	 * called. So, this driver disables the IRQ while DMA transfer.
@@ -503,34 +530,26 @@ static int rspi_dma_transfer(struct rspi_data *rspi, =
struct sg_table *tx,
 	rspi_enable_irq(rspi, irq_mask);
 	rspi->dma_callbacked =3D 0;
=20
-	if (rx) {
-		desc_rx->callback =3D rspi_dma_complete;
-		desc_rx->callback_param =3D rspi;
-		cookie =3D dmaengine_submit(desc_rx);
-		if (dma_submit_error(cookie))
-			return cookie;
+	/* Now start DMA */
+	if (rx)
 		dma_async_issue_pending(rspi->master->dma_rx);
-	}
-	if (tx) {
-		if (rx) {
-			/* No callback */
-			desc_tx->callback =3D NULL;
-		} else {
-			desc_tx->callback =3D rspi_dma_complete;
-			desc_tx->callback_param =3D rspi;
-		}
-		cookie =3D dmaengine_submit(desc_tx);
-		if (dma_submit_error(cookie))
-			return cookie;
+	if (tx)
 		dma_async_issue_pending(rspi->master->dma_tx);
-	}
=20
 	ret =3D wait_event_interruptible_timeout(rspi->wait,
 					       rspi->dma_callbacked, HZ);
-	if (ret > 0 && rspi->dma_callbacked)
+	if (ret > 0 && rspi->dma_callbacked) {
 		ret =3D 0;
-	else if (!ret)
-		ret =3D -ETIMEDOUT;
+	} else {
+		if (!ret) {
+			dev_err(&rspi->master->dev, "DMA timeout\n");
+			ret =3D -ETIMEDOUT;
+		}
+		if (tx)
+			dmaengine_terminate_all(rspi->master->dma_tx);
+		if (rx)
+			dmaengine_terminate_all(rspi->master->dma_rx);
+	}
=20
 	rspi_disable_irq(rspi, irq_mask);
=20
@@ -540,6 +559,17 @@ static int rspi_dma_transfer(struct rspi_data *rspi, s=
truct sg_table *tx,
 		enable_irq(rspi->rx_irq);
=20
 	return ret;
+
+no_dma_tx:
+	if (rx)
+		dmaengine_terminate_all(rspi->master->dma_rx);
+no_dma_rx:
+	if (ret =3D=3D -EAGAIN) {
+		pr_warn_once("%s %s: DMA not available, falling back to PIO\n",
+			     dev_driver_string(&rspi->master->dev),
+			     dev_name(&rspi->master->dev));
+	}
+	return ret;
 }
=20
 static void rspi_receive_init(const struct rspi_data *rspi)
@@ -593,8 +623,10 @@ static int rspi_common_transfer(struct rspi_data *rspi,
=20
 	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
 		/* rx_buf can be NULL on RSPI on SH in TX-only Mode */
-		return rspi_dma_transfer(rspi, &xfer->tx_sg,
-					 xfer->rx_buf ? &xfer->rx_sg : NULL);
+		ret =3D rspi_dma_transfer(rspi, &xfer->tx_sg,
+					xfer->rx_buf ? &xfer->rx_sg : NULL);
+		if (ret !=3D -EAGAIN)
+			return ret;
 	}
=20
 	ret =3D rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf, xfer->len);
@@ -648,8 +680,11 @@ static int qspi_transfer_out(struct rspi_data *rspi, s=
truct spi_transfer *xfer)
 {
 	int ret;
=20
-	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer))
-		return rspi_dma_transfer(rspi, &xfer->tx_sg, NULL);
+	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
+		ret =3D rspi_dma_transfer(rspi, &xfer->tx_sg, NULL);
+		if (ret !=3D -EAGAIN)
+			return ret;
+	}
=20
 	ret =3D rspi_pio_transfer(rspi, xfer->tx_buf, NULL, xfer->len);
 	if (ret < 0)
@@ -663,8 +698,11 @@ static int qspi_transfer_out(struct rspi_data *rspi, s=
truct spi_transfer *xfer)
=20
 static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *x=
fer)
 {
-	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer))
-		return rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
+	if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
+		int ret =3D rspi_dma_transfer(rspi, NULL, &xfer->rx_sg);
+		if (ret !=3D -EAGAIN)
+			return ret;
+	}
=20
 	return rspi_pio_transfer(rspi, NULL, xfer->rx_buf, xfer->len);
 }
@@ -1158,6 +1196,29 @@ static struct platform_device_id spi_driver_ids[] =
=3D {
=20
 MODULE_DEVICE_TABLE(platform, spi_driver_ids);
=20
+#ifdef CONFIG_PM_SLEEP
+static int rspi_suspend(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct rspi_data *rspi =3D platform_get_drvdata(pdev);
+
+	return spi_master_suspend(rspi->master);
+}
+
+static int rspi_resume(struct device *dev)
+{
+	struct platform_device *pdev =3D to_platform_device(dev);
+	struct rspi_data *rspi =3D platform_get_drvdata(pdev);
+
+	return spi_master_resume(rspi->master);
+}
+
+static SIMPLE_DEV_PM_OPS(rspi_pm_ops, rspi_suspend, rspi_resume);
+#define DEV_PM_OPS	&rspi_pm_ops
+#else
+#define DEV_PM_OPS	NULL
+#endif /* CONFIG_PM_SLEEP */
+
 static struct platform_driver rspi_driver =3D {
 	.probe =3D	rspi_probe,
 	.remove =3D	rspi_remove,
@@ -1165,6 +1226,7 @@ static struct platform_driver rspi_driver =3D {
 	.driver		=3D {
 		.name =3D "renesas_spi",
 		.owner	=3D THIS_MODULE,
+		.pm =3D DEV_PM_OPS,
 		.of_match_table =3D of_match_ptr(rspi_of_match),
 	},
 };
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 7f0f2ebf3cdc..e53bff9f56b7 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -113,9 +113,61 @@ struct sh_msiof_spi_priv {
 #define CTR_TXE		0x00000200 /* Transmit Enable */
 #define CTR_RXE		0x00000100 /* Receive Enable */
=20
-/* STR and IER */
+/* FCTR */
+#define FCTR_TFWM_MASK	0xe0000000 /* Transmit FIFO Watermark */
+#define FCTR_TFWM_64	0x00000000 /*  Transfer Request when 64 empty stages =
*/
+#define FCTR_TFWM_32	0x20000000 /*  Transfer Request when 32 empty stages =
*/
+#define FCTR_TFWM_24	0x40000000 /*  Transfer Request when 24 empty stages =
*/
+#define FCTR_TFWM_16	0x60000000 /*  Transfer Request when 16 empty stages =
*/
+#define FCTR_TFWM_12	0x80000000 /*  Transfer Request when 12 empty stages =
*/
+#define FCTR_TFWM_8	0xa0000000 /*  Transfer Request when 8 empty stages */
+#define FCTR_TFWM_4	0xc0000000 /*  Transfer Request when 4 empty stages */
+#define FCTR_TFWM_1	0xe0000000 /*  Transfer Request when 1 empty stage */
+#define FCTR_TFUA_MASK	0x07f00000 /* Transmit FIFO Usable Area */
+#define FCTR_TFUA_SHIFT		20
+#define FCTR_TFUA(i)	((i) << FCTR_TFUA_SHIFT)
+#define FCTR_RFWM_MASK	0x0000e000 /* Receive FIFO Watermark */
+#define FCTR_RFWM_1	0x00000000 /*  Transfer Request when 1 valid stages */
+#define FCTR_RFWM_4	0x00002000 /*  Transfer Request when 4 valid stages */
+#define FCTR_RFWM_8	0x00004000 /*  Transfer Request when 8 valid stages */
+#define FCTR_RFWM_16	0x00006000 /*  Transfer Request when 16 valid stages =
*/
+#define FCTR_RFWM_32	0x00008000 /*  Transfer Request when 32 valid stages =
*/
+#define FCTR_RFWM_64	0x0000a000 /*  Transfer Request when 64 valid stages =
*/
+#define FCTR_RFWM_128	0x0000c000 /*  Transfer Request when 128 valid stage=
s */
+#define FCTR_RFWM_256	0x0000e000 /*  Transfer Request when 256 valid stage=
s */
+#define FCTR_RFUA_MASK	0x00001ff0 /* Receive FIFO Usable Area (0x40 =3D fu=
ll) */
+#define FCTR_RFUA_SHIFT		 4
+#define FCTR_RFUA(i)	((i) << FCTR_RFUA_SHIFT)
+
+/* STR */
+#define STR_TFEMP	0x20000000 /* Transmit FIFO Empty */
+#define STR_TDREQ	0x10000000 /* Transmit Data Transfer Request */
 #define STR_TEOF	0x00800000 /* Frame Transmission End */
+#define STR_TFSERR	0x00200000 /* Transmit Frame Synchronization Error */
+#define STR_TFOVF	0x00100000 /* Transmit FIFO Overflow */
+#define STR_TFUDF	0x00080000 /* Transmit FIFO Underflow */
+#define STR_RFFUL	0x00002000 /* Receive FIFO Full */
+#define STR_RDREQ	0x00001000 /* Receive Data Transfer Request */
 #define STR_REOF	0x00000080 /* Frame Reception End */
+#define STR_RFSERR	0x00000020 /* Receive Frame Synchronization Error */
+#define STR_RFUDF	0x00000010 /* Receive FIFO Underflow */
+#define STR_RFOVF	0x00000008 /* Receive FIFO Overflow */
+
+/* IER */
+#define IER_TDMAE	0x80000000 /* Transmit Data DMA Transfer Req. Enable */
+#define IER_TFEMPE	0x20000000 /* Transmit FIFO Empty Enable */
+#define IER_TDREQE	0x10000000 /* Transmit Data Transfer Request Enable */
+#define IER_TEOFE	0x00800000 /* Frame Transmission End Enable */
+#define IER_TFSERRE	0x00200000 /* Transmit Frame Sync Error Enable */
+#define IER_TFOVFE	0x00100000 /* Transmit FIFO Overflow Enable */
+#define IER_TFUDFE	0x00080000 /* Transmit FIFO Underflow Enable */
+#define IER_RDMAE	0x00008000 /* Receive Data DMA Transfer Req. Enable */
+#define IER_RFFULE	0x00002000 /* Receive FIFO Full Enable */
+#define IER_RDREQE	0x00001000 /* Receive Data Transfer Request Enable */
+#define IER_REOFE	0x00000080 /* Frame Reception End Enable */
+#define IER_RFSERRE	0x00000020 /* Receive Frame Sync Error Enable */
+#define IER_RFUDFE	0x00000010 /* Receive FIFO Underflow Enable */
+#define IER_RFOVFE	0x00000008 /* Receive FIFO Overflow Enable */
=20
=20
 static u32 sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
@@ -273,7 +325,8 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_=
spi_priv *p,
=20
 static void sh_msiof_reset_str(struct sh_msiof_spi_priv *p)
 {
-	sh_msiof_write(p, STR, sh_msiof_read(p, STR));
+	sh_msiof_write(p, STR,
+		       sh_msiof_read(p, STR) & ~(STR_TDREQ | STR_RDREQ));
 }
=20
 static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slin=
k.c
index 0b9e32e9f493..4ba5bbb61951 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1063,6 +1063,24 @@ static int tegra_slink_probe(struct platform_device =
*pdev)
 		goto exit_free_master;
 	}
=20
+	/* disabled clock may cause interrupt storm upon request */
+	tspi->clk =3D devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tspi->clk)) {
+		ret =3D PTR_ERR(tspi->clk);
+		dev_err(&pdev->dev, "Can not get clock %d\n", ret);
+		goto exit_free_master;
+	}
+	ret =3D clk_prepare(tspi->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Clock prepare failed %d\n", ret);
+		goto exit_free_master;
+	}
+	ret =3D clk_enable(tspi->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Clock enable failed %d\n", ret);
+		goto exit_free_master;
+	}
+
 	spi_irq =3D platform_get_irq(pdev, 0);
 	tspi->irq =3D spi_irq;
 	ret =3D request_threaded_irq(tspi->irq, tegra_slink_isr,
@@ -1071,14 +1089,7 @@ static int tegra_slink_probe(struct platform_device =
*pdev)
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
 					tspi->irq);
-		goto exit_free_master;
-	}
-
-	tspi->clk =3D devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(tspi->clk)) {
-		dev_err(&pdev->dev, "can not get clock\n");
-		ret =3D PTR_ERR(tspi->clk);
-		goto exit_free_irq;
+		goto exit_clk_disable;
 	}
=20
 	tspi->rst =3D devm_reset_control_get(&pdev->dev, "spi");
@@ -1138,6 +1149,8 @@ static int tegra_slink_probe(struct platform_device *=
pdev)
 	tegra_slink_deinit_dma_param(tspi, true);
 exit_free_irq:
 	free_irq(spi_irq, tspi);
+exit_clk_disable:
+	clk_disable(tspi->clk);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
@@ -1150,6 +1163,8 @@ static int tegra_slink_remove(struct platform_device =
*pdev)
=20
 	free_irq(tspi->irq, tspi);
=20
+	clk_disable(tspi->clk);
+
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
=20
diff --git a/drivers/staging/rts5208/sd.c b/drivers/staging/rts5208/sd.c
index c7c1f5410430..0401eff15169 100644
--- a/drivers/staging/rts5208/sd.c
+++ b/drivers/staging/rts5208/sd.c
@@ -4276,7 +4276,7 @@ int sd_execute_write_data(struct scsi_cmnd *srb, stru=
ct rtsx_chip *chip)
 		if (retval !=3D STATUS_SUCCESS)
 			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
=20
-		rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
+		retval =3D rtsx_write_register(chip, SD_BYTE_CNT_L, 0xFF, 0x00);
 		if (retval !=3D STATUS_SUCCESS)
 			TRACE_GOTO(chip, SD_Execute_Write_Cmd_Failed);
 	}
diff --git a/drivers/staging/usbip/vhci_hcd.c b/drivers/staging/usbip/vhci_=
hcd.c
index 30fcbac8f162..b702855308b5 100644
--- a/drivers/staging/usbip/vhci_hcd.c
+++ b/drivers/staging/usbip/vhci_hcd.c
@@ -234,7 +234,8 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 ty=
peReq, u16 wValue,
 {
 	struct vhci_hcd	*dum;
 	int             retval =3D 0;
-	int		rhport;
+	int		rhport =3D -1;
+	bool invalid_rhport =3D false;
=20
 	u32 prev_port_status[VHCI_NPORTS];
=20
@@ -245,11 +246,23 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 =
typeReq, u16 wValue,
 	 * NOTE:
 	 * wIndex shows the port number and begins from 1.
 	 */
+	wIndex =3D ((__u8)(wIndex & 0x00ff));
 	usbip_dbg_vhci_rh("typeReq %x wValue %x wIndex %x\n", typeReq, wValue,
 			  wIndex);
-	if (wIndex > VHCI_NPORTS)
-		pr_err("invalid port number %d\n", wIndex);
-	rhport =3D ((__u8)(wIndex & 0x00ff)) - 1;
+
+	/*
+	 * wIndex can be 0 for some request types (typeReq). rhport is
+	 * in valid range when wIndex >=3D 1 and < VHCI_HC_PORTS.
+	 *
+	 * Reference port_status[] only with valid rhport when
+	 * invalid_rhport is false.
+	 */
+	if (wIndex < 1 || wIndex > VHCI_NPORTS) {
+		invalid_rhport =3D true;
+		if (wIndex > VHCI_NPORTS)
+			pr_err("invalid port number %d\n", wIndex);
+	} else
+		rhport =3D wIndex - 1;
=20
 	dum =3D hcd_to_vhci(hcd);
=20
@@ -257,8 +270,9 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 ty=
peReq, u16 wValue,
=20
 	/* store old status and compare now and old later */
 	if (usbip_dbg_flag_vhci_rh) {
-		memcpy(prev_port_status, dum->port_status,
-			sizeof(prev_port_status));
+		if (!invalid_rhport)
+			memcpy(prev_port_status, dum->port_status,
+				sizeof(prev_port_status));
 	}
=20
 	switch (typeReq) {
@@ -266,8 +280,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
 		usbip_dbg_vhci_rh(" ClearHubFeature\n");
 		break;
 	case ClearPortFeature:
-		if (rhport < 0)
+		if (invalid_rhport) {
+			pr_err("invalid port number %d\n", wIndex);
 			goto error;
+		}
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (dum->port_status[rhport] & USB_PORT_STAT_SUSPEND) {
@@ -315,9 +331,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
 		break;
 	case GetPortStatus:
 		usbip_dbg_vhci_rh(" GetPortStatus port %x\n", wIndex);
-		if (wIndex > VHCI_NPORTS || wIndex < 1) {
+		if (invalid_rhport) {
 			pr_err("invalid port number %d\n", wIndex);
 			retval =3D -EPIPE;
+			goto error;
 		}
=20
 		/* we do not care about resume. */
@@ -372,8 +389,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
 		case USB_PORT_FEAT_RESET:
 			usbip_dbg_vhci_rh(
 				" SetPortFeature: USB_PORT_FEAT_RESET\n");
-			if (rhport < 0)
+			if (invalid_rhport) {
+				pr_err("invalid port number %d\n", wIndex);
 				goto error;
+			}
 			/* if it's already running, disconnect first */
 			if (dum->port_status[rhport] & USB_PORT_STAT_ENABLE) {
 				dum->port_status[rhport] &=3D
@@ -389,8 +408,10 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 t=
ypeReq, u16 wValue,
 		default:
 			usbip_dbg_vhci_rh(" SetPortFeature: default %d\n",
 					  wValue);
-			if (rhport < 0)
+			if (invalid_rhport) {
+				pr_err("invalid port number %d\n", wIndex);
 				goto error;
+			}
 			dum->port_status[rhport] |=3D (1 << wValue);
 			break;
 		}
@@ -406,7 +427,7 @@ static int vhci_hub_control(struct usb_hcd *hcd, u16 ty=
peReq, u16 wValue,
 	if (usbip_dbg_flag_vhci_rh) {
 		pr_debug("port %d\n", rhport);
 		/* Only dump valid port status */
-		if (rhport >=3D 0) {
+		if (!invalid_rhport) {
 			dump_port_status_diff(prev_port_status[rhport],
 					      dum->port_status[rhport]);
 		}
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/isc=
si/iscsi_target_login.c
index 2ab8081267f9..08c161b434b3 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -323,8 +323,7 @@ static int iscsi_login_zero_tsih_s1(
 		pr_err("idr_alloc() for sess_idr failed\n");
 		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_NO_RESOURCES);
-		kfree(sess);
-		return -ENOMEM;
+		goto free_sess;
 	}
=20
 	sess->creation_time =3D get_jiffies_64();
@@ -340,19 +339,28 @@ static int iscsi_login_zero_tsih_s1(
 				ISCSI_LOGIN_STATUS_NO_RESOURCES);
 		pr_err("Unable to allocate memory for"
 				" struct iscsi_sess_ops.\n");
-		kfree(sess);
-		return -ENOMEM;
+		goto remove_idr;
 	}
=20
 	sess->se_sess =3D transport_init_session(TARGET_PROT_NORMAL);
 	if (IS_ERR(sess->se_sess)) {
 		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_NO_RESOURCES);
-		kfree(sess);
-		return -ENOMEM;
+		goto free_ops;
 	}
=20
 	return 0;
+
+free_ops:
+	kfree(sess->sess_ops);
+remove_idr:
+	spin_lock_bh(&sess_idr_lock);
+	idr_remove(&sess_idr, sess->session_index);
+	spin_unlock_bh(&sess_idr_lock);
+free_sess:
+	kfree(sess);
+	conn->sess =3D NULL;
+	return -ENOMEM;
 }
=20
 static int iscsi_login_zero_tsih_s2(
@@ -1200,15 +1208,16 @@ void iscsi_target_login_sess_out(struct iscsi_conn =
*conn,
 				   ISCSI_LOGIN_STATUS_INIT_ERR);
 	if (!zero_tsih || !conn->sess)
 		goto old_sess_out;
-	if (conn->sess->se_sess)
-		transport_free_session(conn->sess->se_sess);
-	if (conn->sess->session_index !=3D 0) {
-		spin_lock_bh(&sess_idr_lock);
-		idr_remove(&sess_idr, conn->sess->session_index);
-		spin_unlock_bh(&sess_idr_lock);
-	}
+
+	transport_free_session(conn->sess->se_sess);
+
+	spin_lock_bh(&sess_idr_lock);
+	idr_remove(&sess_idr, conn->sess->session_index);
+	spin_unlock_bh(&sess_idr_lock);
+
 	kfree(conn->sess->sess_ops);
 	kfree(conn->sess);
+	conn->sess =3D NULL;
=20
 old_sess_out:
 	iscsi_stop_login_thread_timer(np);
diff --git a/drivers/target/iscsi/iscsi_target_tpg.c b/drivers/target/iscsi=
/iscsi_target_tpg.c
index 79ca361078b8..532d2c0e2f3d 100644
--- a/drivers/target/iscsi/iscsi_target_tpg.c
+++ b/drivers/target/iscsi/iscsi_target_tpg.c
@@ -652,8 +652,7 @@ int iscsit_ta_authentication(struct iscsi_portal_group =
*tpg, u32 authentication)
 		none =3D strstr(buf1, NONE);
 		if (none)
 			goto out;
-		strncat(buf1, ",", strlen(","));
-		strncat(buf1, NONE, strlen(NONE));
+		strlcat(buf1, "," NONE, sizeof(buf1));
 		if (iscsi_update_param_value(param, buf1) < 0)
 			return -EINVAL;
 	}
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/seri=
al/cpm_uart/cpm_uart_core.c
index aa60e6d13eca..90592e6f918e 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1062,8 +1062,8 @@ static int poll_wait_key(char *obuf, struct uart_cpm_=
port *pinfo)
 	/* Get the address of the host memory buffer.
 	 */
 	bdp =3D pinfo->rx_cur;
-	while (bdp->cbd_sc & BD_SC_EMPTY)
-		;
+	if (bdp->cbd_sc & BD_SC_EMPTY)
+		return NO_POLL_CHAR;
=20
 	/* If the buffer address is in the CPM DPRAM, don't
 	 * convert it.
@@ -1097,7 +1097,11 @@ static int cpm_get_poll_char(struct uart_port *port)
 		poll_chars =3D 0;
 	}
 	if (poll_chars <=3D 0) {
-		poll_chars =3D poll_wait_key(poll_buf, pinfo);
+		int ret =3D poll_wait_key(poll_buf, pinfo);
+
+		if (ret =3D=3D NO_POLL_CHAR)
+			return ret;
+		poll_chars =3D ret;
 		pollp =3D poll_buf;
 	}
 	poll_chars--;
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 94c6994e4060..2239496f8424 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -890,7 +890,8 @@ static int serial_pxa_probe(struct platform_device *dev)
 		goto err_clk;
 	if (sport->port.line >=3D ARRAY_SIZE(serial_pxa_ports)) {
 		dev_err(&dev->dev, "serial%d out of range\n", sport->port.line);
-		return -EINVAL;
+		ret =3D -EINVAL;
+		goto err_clk;
 	}
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
=20
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_c=
ore.c
index ba468b11fa04..ad7e13a51b22 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -131,6 +131,7 @@ static int uart_port_startup(struct tty_struct *tty, st=
ruct uart_state *state,
 	struct uart_port *uport =3D state->uart_port;
 	struct tty_port *port =3D &state->port;
 	unsigned long page;
+	unsigned long flags =3D 0;
 	int retval =3D 0;
=20
 	if (uport->type =3D=3D PORT_UNKNOWN)
@@ -145,15 +146,18 @@ static int uart_port_startup(struct tty_struct *tty, =
struct uart_state *state,
 	 * Initialise and allocate the transmit and temporary
 	 * buffer.
 	 */
-	if (!state->xmit.buf) {
-		/* This is protected by the per port mutex */
-		page =3D get_zeroed_page(GFP_KERNEL);
-		if (!page)
-			return -ENOMEM;
+	page =3D get_zeroed_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
=20
+	spin_lock_irqsave(&uport->lock, flags);
+	if (!state->xmit.buf) {
 		state->xmit.buf =3D (unsigned char *) page;
 		uart_circ_clear(&state->xmit);
+	} else {
+		free_page(page);
 	}
+	spin_unlock_irqrestore(&uport->lock, flags);
=20
 	retval =3D uport->ops->startup(uport);
 	if (retval =3D=3D 0) {
@@ -232,6 +236,7 @@ static void uart_shutdown(struct tty_struct *tty, struc=
t uart_state *state)
 {
 	struct uart_port *uport =3D state->uart_port;
 	struct tty_port *port =3D &state->port;
+	unsigned long flags =3D 0;
=20
 	/*
 	 * Set the TTY IO error marker
@@ -262,10 +267,12 @@ static void uart_shutdown(struct tty_struct *tty, str=
uct uart_state *state)
 	/*
 	 * Free the transmit buffer page.
 	 */
+	spin_lock_irqsave(&uport->lock, flags);
 	if (state->xmit.buf) {
 		free_page((unsigned long)state->xmit.buf);
 		state->xmit.buf =3D NULL;
 	}
+	spin_unlock_irqrestore(&uport->lock, flags);
 }
=20
 /**
diff --git a/drivers/tty/tty_ioctl.c b/drivers/tty/tty_ioctl.c
index 22da05d27009..7107991dc4cc 100644
--- a/drivers/tty/tty_ioctl.c
+++ b/drivers/tty/tty_ioctl.c
@@ -407,18 +407,25 @@ void tty_termios_encode_baud_rate(struct ktermios *te=
rmios,
 	termios->c_ospeed =3D obaud;
=20
 #ifdef BOTHER
+	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
+		ibinput =3D 1;	/* An input speed was specified */
+
 	/* If the user asked for a precise weird speed give a precise weird
-	   answer. If they asked for a Bfoo speed they many have problems
+	   answer. If they asked for a Bfoo speed they may have problems
 	   digesting non-exact replies so fuzz a bit */
=20
-	if ((termios->c_cflag & CBAUD) =3D=3D BOTHER)
+	if ((termios->c_cflag & CBAUD) =3D=3D BOTHER) {
 		oclose =3D 0;
+		if (!ibinput)
+			iclose =3D 0;
+	}
 	if (((termios->c_cflag >> IBSHIFT) & CBAUD) =3D=3D BOTHER)
 		iclose =3D 0;
-	if ((termios->c_cflag >> IBSHIFT) & CBAUD)
-		ibinput =3D 1;	/* An input speed was specified */
 #endif
 	termios->c_cflag &=3D ~CBAUD;
+#ifdef IBSHIFT
+	termios->c_cflag &=3D ~(CBAUD << IBSHIFT);
+#endif
=20
 	/*
 	 *	Our goal is to find a close match to the standard baud rate
diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index 2bd78e2ac8ec..cf7ccafa6fc0 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -31,6 +31,8 @@
 #include <asm/io.h>
 #include <asm/uaccess.h>
=20
+#include <linux/nospec.h>
+
 #include <linux/kbd_kern.h>
 #include <linux/vt_kern.h>
 #include <linux/kbd_diacr.h>
@@ -703,6 +705,8 @@ int vt_ioctl(struct tty_struct *tty,
 		if (vsa.console =3D=3D 0 || vsa.console > MAX_NR_CONSOLES)
 			ret =3D -ENXIO;
 		else {
+			vsa.console =3D array_index_nospec(vsa.console,
+							 MAX_NR_CONSOLES + 1);
 			vsa.console--;
 			console_lock();
 			ret =3D vc_allocate(vsa.console);
diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index 079294590c00..452cf8e98131 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -852,8 +852,6 @@ int __uio_register_device(struct module *owner,
 	if (ret)
 		goto err_uio_dev_add_attributes;
=20
-	info->uio_dev =3D idev;
-
 	if (info->irq && (info->irq !=3D UIO_IRQ_CUSTOM)) {
 		ret =3D devm_request_irq(idev->dev, info->irq, uio_interrupt,
 				  info->irq_flags, info->name, idev);
@@ -861,6 +859,7 @@ int __uio_register_device(struct module *owner,
 			goto err_request_irq;
 	}
=20
+	info->uio_dev =3D idev;
 	return 0;
=20
 err_request_irq:
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 6714bbb801ce..b69f98db459a 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1291,10 +1291,13 @@ static int proc_do_submiturb(struct usb_dev_state *=
ps, struct usbdevfs_urb *uurb
 	struct async *as =3D NULL;
 	struct usb_ctrlrequest *dr =3D NULL;
 	unsigned int u, totlen, isofrmlen;
-	int i, ret, is_in, num_sgs =3D 0, ifnum =3D -1;
+	int i, ret, num_sgs =3D 0, ifnum =3D -1;
 	int number_of_packets =3D 0;
 	unsigned int stream_id =3D 0;
 	void *buf;
+	bool is_in;
+	bool allow_short =3D false;
+	bool allow_zero =3D false;
 	unsigned long mask =3D	USBDEVFS_URB_SHORT_NOT_OK |
 				USBDEVFS_URB_BULK_CONTINUATION |
 				USBDEVFS_URB_NO_FSBR |
@@ -1355,6 +1358,8 @@ static int proc_do_submiturb(struct usb_dev_state *ps=
, struct usbdevfs_urb *uurb
 			is_in =3D 0;
 			uurb->endpoint &=3D ~USB_DIR_IN;
 		}
+		if (is_in)
+			allow_short =3D true;
 		snoop(&ps->dev->dev, "control urb: bRequestType=3D%02x "
 			"bRequest=3D%02x wValue=3D%04x "
 			"wIndex=3D%04x wLength=3D%04x\n",
@@ -1366,6 +1371,10 @@ static int proc_do_submiturb(struct usb_dev_state *p=
s, struct usbdevfs_urb *uurb
 		break;
=20
 	case USBDEVFS_URB_TYPE_BULK:
+		if (!is_in)
+			allow_zero =3D true;
+		else
+			allow_short =3D true;
 		switch (usb_endpoint_type(&ep->desc)) {
 		case USB_ENDPOINT_XFER_CONTROL:
 		case USB_ENDPOINT_XFER_ISOC:
@@ -1386,6 +1395,10 @@ static int proc_do_submiturb(struct usb_dev_state *p=
s, struct usbdevfs_urb *uurb
 		if (!usb_endpoint_xfer_int(&ep->desc))
 			return -EINVAL;
  interrupt_urb:
+		if (!is_in)
+			allow_zero =3D true;
+		else
+			allow_short =3D true;
 		break;
=20
 	case USBDEVFS_URB_TYPE_ISO:
@@ -1515,16 +1528,21 @@ static int proc_do_submiturb(struct usb_dev_state *=
ps, struct usbdevfs_urb *uurb
 	u =3D (is_in ? URB_DIR_IN : URB_DIR_OUT);
 	if (uurb->flags & USBDEVFS_URB_ISO_ASAP)
 		u |=3D URB_ISO_ASAP;
-	if (uurb->flags & USBDEVFS_URB_SHORT_NOT_OK && is_in)
+	if (allow_short && uurb->flags & USBDEVFS_URB_SHORT_NOT_OK)
 		u |=3D URB_SHORT_NOT_OK;
 	if (uurb->flags & USBDEVFS_URB_NO_FSBR)
 		u |=3D URB_NO_FSBR;
-	if (uurb->flags & USBDEVFS_URB_ZERO_PACKET)
+	if (allow_zero && uurb->flags & USBDEVFS_URB_ZERO_PACKET)
 		u |=3D URB_ZERO_PACKET;
 	if (uurb->flags & USBDEVFS_URB_NO_INTERRUPT)
 		u |=3D URB_NO_INTERRUPT;
 	as->urb->transfer_flags =3D u;
=20
+	if (!allow_short && uurb->flags & USBDEVFS_URB_SHORT_NOT_OK)
+		dev_warn(&ps->dev->dev, "Requested nonsensical USBDEVFS_URB_SHORT_NOT_OK=
=2E\n");
+	if (!allow_zero && uurb->flags & USBDEVFS_URB_ZERO_PACKET)
+		dev_warn(&ps->dev->dev, "Requested nonsensical USBDEVFS_URB_ZERO_PACKET.=
\n");
+
 	as->urb->transfer_buffer_length =3D uurb->buffer_length;
 	as->urb->setup_packet =3D (unsigned char *)dr;
 	dr =3D NULL;
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 6307c94a59d4..d002c23af6f4 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -298,7 +298,7 @@ static int usb_probe_interface(struct device *dev)
 	struct usb_device *udev =3D interface_to_usbdev(intf);
 	const struct usb_device_id *id;
 	int error =3D -ENODEV;
-	int lpm_disable_error;
+	int lpm_disable_error =3D -ENODEV;
=20
 	dev_dbg(dev, "%s\n", __func__);
=20
@@ -346,12 +346,14 @@ static int usb_probe_interface(struct device *dev)
 	 * setting during probe, that should also be fine.  usb_set_interface()
 	 * will attempt to disable LPM, and fail if it can't disable it.
 	 */
-	lpm_disable_error =3D usb_unlocked_disable_lpm(udev);
-	if (lpm_disable_error && driver->disable_hub_initiated_lpm) {
-		dev_err(&intf->dev, "%s Failed to disable LPM for driver %s\n.",
-				__func__, driver->name);
-		error =3D lpm_disable_error;
-		goto err;
+	if (driver->disable_hub_initiated_lpm) {
+		lpm_disable_error =3D usb_unlocked_disable_lpm(udev);
+		if (lpm_disable_error) {
+			dev_err(&intf->dev, "%s Failed to disable LPM for driver %s\n.",
+					__func__, driver->name);
+			error =3D lpm_disable_error;
+			goto err;
+		}
 	}
=20
 	/* Carry out a deferred switch to altsetting 0 */
@@ -402,7 +404,8 @@ static int usb_unbind_interface(struct device *dev)
 	struct usb_interface *intf =3D to_usb_interface(dev);
 	struct usb_host_endpoint *ep, **eps =3D NULL;
 	struct usb_device *udev;
-	int i, j, error, r, lpm_disable_error;
+	int i, j, error, r;
+	int lpm_disable_error =3D -ENODEV;
=20
 	intf->condition =3D USB_INTERFACE_UNBINDING;
=20
@@ -410,12 +413,13 @@ static int usb_unbind_interface(struct device *dev)
 	udev =3D interface_to_usbdev(intf);
 	error =3D usb_autoresume_device(udev);
=20
-	/* Hub-initiated LPM policy may change, so attempt to disable LPM until
+	/* If hub-initiated LPM policy may change, attempt to disable LPM until
 	 * the driver is unbound.  If LPM isn't disabled, that's fine because it
 	 * wouldn't be enabled unless all the bound interfaces supported
 	 * hub-initiated LPM.
 	 */
-	lpm_disable_error =3D usb_unlocked_disable_lpm(udev);
+	if (driver->disable_hub_initiated_lpm)
+		lpm_disable_error =3D usb_unlocked_disable_lpm(udev);
=20
 	/* Terminate all URBs for this interface unless the driver
 	 * supports "soft" unbinding.
@@ -518,7 +522,6 @@ int usb_driver_claim_interface(struct usb_driver *drive=
r,
 	struct device *dev;
 	struct usb_device *udev;
 	int retval =3D 0;
-	int lpm_disable_error;
=20
 	if (!iface)
 		return -ENODEV;
@@ -535,14 +538,6 @@ int usb_driver_claim_interface(struct usb_driver *driv=
er,
=20
 	iface->condition =3D USB_INTERFACE_BOUND;
=20
-	/* Disable LPM until this driver is bound. */
-	lpm_disable_error =3D usb_unlocked_disable_lpm(udev);
-	if (lpm_disable_error && driver->disable_hub_initiated_lpm) {
-		dev_err(&iface->dev, "%s Failed to disable LPM for driver %s\n.",
-				__func__, driver->name);
-		return -ENOMEM;
-	}
-
 	/* Claimed interfaces are initially inactive (suspended) and
 	 * runtime-PM-enabled, but only if the driver has autosuspend
 	 * support.  Otherwise they are marked active, to prevent the
@@ -561,9 +556,20 @@ int usb_driver_claim_interface(struct usb_driver *driv=
er,
 	if (device_is_registered(dev))
 		retval =3D device_bind_driver(dev);
=20
-	/* Attempt to re-enable USB3 LPM, if the disable was successful. */
-	if (!lpm_disable_error)
-		usb_unlocked_enable_lpm(udev);
+	if (retval) {
+		dev->driver =3D NULL;
+		usb_set_intfdata(iface, NULL);
+		iface->needs_remote_wakeup =3D 0;
+		iface->condition =3D USB_INTERFACE_UNBOUND;
+
+		/*
+		 * Unbound interfaces are always runtime-PM-disabled
+		 * and runtime-PM-suspended
+		 */
+		if (driver->supports_autosuspend)
+			pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+	}
=20
 	return retval;
 }
diff --git a/drivers/usb/core/hcd-pci.c b/drivers/usb/core/hcd-pci.c
index f6bbfaf05573..7d31a0fb946f 100644
--- a/drivers/usb/core/hcd-pci.c
+++ b/drivers/usb/core/hcd-pci.c
@@ -528,8 +528,6 @@ static int resume_common(struct device *dev, int event)
 				event =3D=3D PM_EVENT_RESTORE);
 		if (retval) {
 			dev_err(dev, "PCI post-resume error %d!\n", retval);
-			if (hcd->shared_hcd)
-				usb_hc_died(hcd->shared_hcd);
 			usb_hc_died(hcd);
 		}
 	}
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 66477fef2912..6af648c307b7 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1284,6 +1284,11 @@ void usb_enable_interface(struct usb_device *dev,
  * is submitted that needs that bandwidth.  Some other operating systems
  * allocate bandwidth early, when a configuration is chosen.
  *
+ * xHCI reserves bandwidth and configures the alternate setting in
+ * usb_hcd_alloc_bandwidth(). If it fails the original interface altsetting
+ * may be disabled. Drivers cannot rely on any particular alternate
+ * setting being in effect after a failure.
+ *
  * This call is synchronous, and may not be used in an interrupt context.
  * Also, drivers must not change altsettings while urbs are scheduled for
  * endpoints in that interface; all such urbs must first be completed
@@ -1319,6 +1324,12 @@ int usb_set_interface(struct usb_device *dev, int in=
terface, int alternate)
 			 alternate);
 		return -EINVAL;
 	}
+	/*
+	 * usb3 hosts configure the interface in usb_hcd_alloc_bandwidth,
+	 * including freeing dropped endpoint ring buffers.
+	 * Make sure the interface endpoints are flushed before that
+	 */
+	usb_disable_interface(dev, iface, false);
=20
 	/* Make sure we have enough bandwidth for this alternate interface.
 	 * Remove the current alt setting and add the new alt setting.
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index fab55e29abb3..7b722da17880 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -37,6 +37,10 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	/* CBM - Flash disk */
 	{ USB_DEVICE(0x0204, 0x6025), .driver_info =3D USB_QUIRK_RESET_RESUME },
=20
+	/* WORLDE Controller KS49 or Prodipe MIDI 49C USB controller */
+	{ USB_DEVICE(0x0218, 0x0201), .driver_info =3D
+			USB_QUIRK_CONFIG_INTF_STRINGS },
+
 	/* WORLDE easy key (easykey.25) MIDI controller  */
 	{ USB_DEVICE(0x0218, 0x0401), .driver_info =3D
 			USB_QUIRK_CONFIG_INTF_STRINGS },
@@ -256,6 +260,9 @@ static const struct usb_device_id usb_quirk_list[] =3D {
 	{ USB_DEVICE(0x2040, 0x7200), .driver_info =3D
 			USB_QUIRK_CONFIG_INTF_STRINGS },
=20
+	/* DJI CineSSD */
+	{ USB_DEVICE(0x2ca3, 0x0031), .driver_info =3D USB_QUIRK_NO_LPM },
+
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info =3D USB_QUIRK_RESET_RESUME },
=20
diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index a92273026ecc..d885a07be4df 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -79,6 +79,8 @@ struct usb_host_interface *usb_find_alt_setting(
 	struct usb_interface_cache *intf_cache =3D NULL;
 	int i;
=20
+	if (!config)
+		return NULL;
 	for (i =3D 0; i < config->desc.bNumInterfaces; i++) {
 		if (config->intf_cache[i]->altsetting[0].desc.bInterfaceNumber
 				=3D=3D iface_num) {
diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mas=
s_storage.c
index f0db2ca816c0..43a22a0b20c9 100644
--- a/drivers/usb/gadget/f_mass_storage.c
+++ b/drivers/usb/gadget/f_mass_storage.c
@@ -219,6 +219,8 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/composite.h>
=20
+#include <linux/nospec.h>
+
 #include "gadget_chips.h"
 #include "configfs.h"
=20
@@ -3344,6 +3346,7 @@ static struct config_group *fsg_lun_make(struct confi=
g_group *group,
 	fsg_opts =3D to_fsg_opts(&group->cg_item);
 	if (num >=3D FSG_MAX_LUNS)
 		return ERR_PTR(-ERANGE);
+	num =3D array_index_nospec(num, FSG_MAX_LUNS);
=20
 	mutex_lock(&fsg_opts->lock);
 	if (fsg_opts->refcnt || fsg_opts->common->luns[num]) {
diff --git a/drivers/usb/gadget/net2280.c b/drivers/usb/gadget/net2280.c
index b464ed5e129e..2c637fae9dfc 100644
--- a/drivers/usb/gadget/net2280.c
+++ b/drivers/usb/gadget/net2280.c
@@ -139,6 +139,10 @@ static char *type_string (u8 bmAttributes)
 #define valid_bit	cpu_to_le32 (1 << VALID_BIT)
 #define dma_done_ie	cpu_to_le32 (1 << DMA_DONE_INTERRUPT_ENABLE)
=20
+static void stop_activity(struct net2280 *dev,
+					struct usb_gadget_driver *driver);
+static void ep0_start(struct net2280 *dev);
+
 /*------------------------------------------------------------------------=
-*/
=20
 static int
@@ -1390,13 +1394,19 @@ static int net2280_pullup(struct usb_gadget *_gadge=
t, int is_on)
 	spin_lock_irqsave (&dev->lock, flags);
 	tmp =3D readl (&dev->usb->usbctl);
 	dev->softconnect =3D (is_on !=3D 0);
-	if (is_on)
-		tmp |=3D (1 << USB_DETECT_ENABLE);
-	else
-		tmp &=3D ~(1 << USB_DETECT_ENABLE);
-	writel (tmp, &dev->usb->usbctl);
+	if (is_on) {
+		ep0_start(dev);
+		writel(tmp | BIT(USB_DETECT_ENABLE), &dev->usb->usbctl);
+	} else {
+		writel(tmp & ~BIT(USB_DETECT_ENABLE), &dev->usb->usbctl);
+		stop_activity(dev, NULL);
+	}
+
 	spin_unlock_irqrestore (&dev->lock, flags);
=20
+	if (!is_on && dev->driver)
+		dev->driver->disconnect(&dev->gadget);
+
 	return 0;
 }
=20
@@ -1941,8 +1951,11 @@ stop_activity (struct net2280 *dev, struct usb_gadge=
t_driver *driver)
 		nuke (&dev->ep [i]);
=20
 	/* report disconnect; the driver is already quiesced */
-	if (driver)
+	if (driver) {
+		spin_unlock(&dev->lock);
 		driver->disconnect(&dev->gadget);
+		spin_lock(&dev->lock);
+	}
=20
 	usb_reinit (dev);
 }
@@ -1956,11 +1969,9 @@ static int net2280_stop(struct usb_gadget *_gadget,
 	dev =3D container_of (_gadget, struct net2280, gadget);
=20
 	spin_lock_irqsave (&dev->lock, flags);
-	stop_activity (dev, driver);
+	stop_activity(dev, NULL);
 	spin_unlock_irqrestore (&dev->lock, flags);
=20
-	dev->driver =3D NULL;
-
 	net2280_led_active (dev, 0);
=20
 	/* Disable full-speed test mode */
@@ -1970,7 +1981,8 @@ static int net2280_stop(struct usb_gadget *_gadget,
 	device_remove_file (&dev->pdev->dev, &dev_attr_queues);
=20
 	DEBUG(dev, "unregistered driver '%s'\n",
-			driver ? driver->driver.name : "");
+	      dev->driver ? dev->driver->driver.name : "");
+	dev->driver =3D NULL;
=20
 	return 0;
 }
@@ -2446,6 +2458,8 @@ static void handle_stat0_irqs (struct net2280 *dev, u=
32 stat)
 		| (1 << PCI_RETRY_ABORT_INTERRUPT))
=20
 static void handle_stat1_irqs (struct net2280 *dev, u32 stat)
+__releases(dev->lock)
+__acquires(dev->lock)
 {
 	struct net2280_ep	*ep;
 	u32			tmp, num, mask, scratch;
@@ -2488,6 +2502,7 @@ static void handle_stat1_irqs (struct net2280 *dev, u=
32 stat)
 	tmp =3D (1 << SUSPEND_REQUEST_CHANGE_INTERRUPT);
 	if (stat & tmp) {
 		writel (tmp, &dev->regs->irqstat1);
+		spin_unlock(&dev->lock);
 		if (stat & (1 << SUSPEND_REQUEST_INTERRUPT)) {
 			if (dev->driver->suspend)
 				dev->driver->suspend (&dev->gadget);
@@ -2498,6 +2513,7 @@ static void handle_stat1_irqs (struct net2280 *dev, u=
32 stat)
 				dev->driver->resume (&dev->gadget);
 			/* at high speed, note erratum 0133 */
 		}
+		spin_lock(&dev->lock);
 		stat &=3D ~tmp;
 	}
=20
diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index c0671750671f..ab5128755672 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -2569,7 +2569,7 @@ static int u132_get_frame(struct usb_hcd *hcd)
 	} else {
 		int frame =3D 0;
 		dev_err(&u132->platform_dev->dev, "TODO: u132_get_frame\n");
-		msleep(100);
+		mdelay(100);
 		return frame;
 	}
 }
diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 3a1f57ea174e..06dd8d8a2f8a 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -178,6 +178,8 @@ static void xhci_pci_quirks(struct device *dev, struct =
xhci_hcd *xhci)
 	}
 	if (pdev->vendor =3D=3D PCI_VENDOR_ID_INTEL &&
 	    (pdev->device =3D=3D PCI_DEVICE_ID_INTEL_CHERRYVIEW_XHCI ||
+	     pdev->device =3D=3D PCI_DEVICE_ID_INTEL_SUNRISEPOINT_LP_XHCI ||
+	     pdev->device =3D=3D PCI_DEVICE_ID_INTEL_SUNRISEPOINT_H_XHCI ||
 	     pdev->device =3D=3D PCI_DEVICE_ID_INTEL_APL_XHCI ||
 	     pdev->device =3D=3D PCI_DEVICE_ID_INTEL_DNV_XHCI))
 		xhci->quirks |=3D XHCI_MISSING_CAS;
diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index 3cb05eb5f1df..9bec15f28d56 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -392,7 +392,7 @@ static unsigned char parport_uss720_frob_control(struct=
 parport *pp, unsigned ch
 	mask &=3D 0x0f;
 	val &=3D 0x0f;
 	d =3D (priv->reg[1] & (~mask)) ^ val;
-	if (set_1284_register(pp, 2, d, GFP_KERNEL))
+	if (set_1284_register(pp, 2, d, GFP_ATOMIC))
 		return 0;
 	priv->reg[1] =3D d;
 	return d & 0xf;
@@ -402,7 +402,7 @@ static unsigned char parport_uss720_read_status(struct =
parport *pp)
 {
 	unsigned char ret;
=20
-	if (get_1284_register(pp, 1, &ret, GFP_KERNEL))
+	if (get_1284_register(pp, 1, &ret, GFP_ATOMIC))
 		return 0;
 	return ret & 0xf8;
 }
diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
index cfb29aeab495..3114c8d061e9 100644
--- a/drivers/usb/misc/yurex.c
+++ b/drivers/usb/misc/yurex.c
@@ -437,13 +437,13 @@ static ssize_t yurex_write(struct file *file, const c=
har *user_buffer, size_t co
 {
 	struct usb_yurex *dev;
 	int i, set =3D 0, retval =3D 0;
-	char buffer[16];
+	char buffer[16 + 1];
 	char *data =3D buffer;
 	unsigned long long c, c2 =3D 0;
 	signed long timeout =3D 0;
 	DEFINE_WAIT(wait);
=20
-	count =3D min(sizeof(buffer), count);
+	count =3D min(sizeof(buffer) - 1, count);
 	dev =3D (struct usb_yurex *)file->private_data;
=20
 	/* verify that we actually have some data to write */
@@ -462,6 +462,7 @@ static ssize_t yurex_write(struct file *file, const cha=
r *user_buffer, size_t co
 		retval =3D -EFAULT;
 		goto error;
 	}
+	buffer[count] =3D 0;
 	memset(dev->cntl_buffer, CMD_PADDING, YUREX_BUF_SIZE);
=20
 	switch (buffer[0]) {
diff --git a/drivers/usb/serial/io_ti.h b/drivers/usb/serial/io_ti.h
index 1bd67b24f916..bc9ff5ebd67c 100644
--- a/drivers/usb/serial/io_ti.h
+++ b/drivers/usb/serial/io_ti.h
@@ -178,7 +178,7 @@ struct ump_interrupt {
 }  __attribute__((packed));
=20
=20
-#define TIUMP_GET_PORT_FROM_CODE(c)	(((c) >> 4) - 3)
+#define TIUMP_GET_PORT_FROM_CODE(c)	(((c) >> 6) & 0x01)
 #define TIUMP_GET_FUNC_FROM_CODE(c)	((c) & 0x0f)
 #define TIUMP_INTERRUPT_CODE_LSR	0x03
 #define TIUMP_INTERRUPT_CODE_MSR	0x04
diff --git a/drivers/usb/serial/kobil_sct.c b/drivers/usb/serial/kobil_sct.c
index 95795ef7ecd5..fb4d71b08a03 100644
--- a/drivers/usb/serial/kobil_sct.c
+++ b/drivers/usb/serial/kobil_sct.c
@@ -408,12 +408,20 @@ static int kobil_tiocmget(struct tty_struct *tty)
 			  transfer_buffer_length,
 			  KOBIL_TIMEOUT);
=20
-	dev_dbg(&port->dev, "%s - Send get_status_line_state URB returns: %i. Sta=
tusline: %02x\n",
-		__func__, result, transfer_buffer[0]);
+	dev_dbg(&port->dev, "Send get_status_line_state URB returns: %i\n",
+			result);
+	if (result < 1) {
+		if (result >=3D 0)
+			result =3D -EIO;
+		goto out_free;
+	}
+
+	dev_dbg(&port->dev, "Statusline: %02x\n", transfer_buffer[0]);
=20
 	result =3D 0;
 	if ((transfer_buffer[0] & SUSBCR_GSL_DSR) !=3D 0)
 		result =3D TIOCM_DSR;
+out_free:
 	kfree(transfer_buffer);
 	return result;
 }
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index 26281d331859..443280204afe 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -772,9 +772,9 @@ static void sierra_close(struct usb_serial_port *port)
 		kfree(urb->transfer_buffer);
 		usb_free_urb(urb);
 		usb_autopm_put_interface_async(serial->interface);
-		spin_lock(&portdata->lock);
+		spin_lock_irq(&portdata->lock);
 		portdata->outstanding_urbs--;
-		spin_unlock(&portdata->lock);
+		spin_unlock_irq(&portdata->lock);
 	}
=20
 	sierra_stop_rx_urbs(port);
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_=
usb_3410_5052.c
index 1d314ede0d65..e9bdd5bb2c6c 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -925,6 +925,15 @@ static void ti_break(struct tty_struct *tty, int break=
_state)
 		dev_dbg(&port->dev, "%s - error setting break, %d\n", __func__, status);
 }
=20
+static int ti_get_port_from_code(unsigned char code)
+{
+	return (code >> 6) & 0x01;
+}
+
+static int ti_get_func_from_code(unsigned char code)
+{
+	return code & 0x0f;
+}
=20
 static void ti_interrupt_callback(struct urb *urb)
 {
@@ -966,8 +975,8 @@ static void ti_interrupt_callback(struct urb *urb)
 		goto exit;
 	}
=20
-	port_number =3D TI_GET_PORT_FROM_CODE(data[0]);
-	function =3D TI_GET_FUNC_FROM_CODE(data[0]);
+	port_number =3D ti_get_port_from_code(data[0]);
+	function =3D ti_get_func_from_code(data[0]);
=20
 	dev_dbg(dev, "%s - port_number %d, function %d, data 0x%02X\n",
 		__func__, port_number, function, data[1]);
diff --git a/drivers/usb/serial/ti_usb_3410_5052.h b/drivers/usb/serial/ti_=
usb_3410_5052.h
index 98f35c656c02..f60b5c081451 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.h
+++ b/drivers/usb/serial/ti_usb_3410_5052.h
@@ -227,8 +227,6 @@ struct ti_interrupt {
 } __attribute__((packed));
=20
 /* Interrupt codes */
-#define TI_GET_PORT_FROM_CODE(c)	(((c) >> 4) - 3)
-#define TI_GET_FUNC_FROM_CODE(c)	((c) & 0x0f)
 #define TI_CODE_HARDWARE_ERROR		0xFF
 #define TI_CODE_DATA_ERROR		0x03
 #define TI_CODE_MODEM_STATUS		0x04
diff --git a/drivers/usb/serial/usb-serial-simple.c b/drivers/usb/serial/us=
b-serial-simple.c
index 9745f714ee80..ba00eb4c9972 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -87,7 +87,8 @@ DEVICE(moto_modem, MOTO_IDS);
=20
 /* Motorola Tetra driver */
 #define MOTOROLA_TETRA_IDS()			\
-	{ USB_DEVICE(0x0cad, 0x9011) }	/* Motorola Solutions TETRA PEI */
+	{ USB_DEVICE(0x0cad, 0x9011) },	/* Motorola Solutions TETRA PEI */ \
+	{ USB_DEVICE(0x0cad, 0x9012) }	/* MTP6550 */
 DEVICE(motorola_tetra, MOTOROLA_TETRA_IDS);
=20
 /* Novatel Wireless GPS driver */
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 866b5df36ed1..b6124d894f83 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -341,6 +341,15 @@ static int queuecommand_lck(struct scsi_cmnd *srb,
 		return 0;
 	}
=20
+	if ((us->fflags & US_FL_NO_ATA_1X) &&
+			(srb->cmnd[0] =3D=3D ATA_12 || srb->cmnd[0] =3D=3D ATA_16)) {
+		memcpy(srb->sense_buffer, usb_stor_sense_invalidCDB,
+		       sizeof(usb_stor_sense_invalidCDB));
+		srb->result =3D SAM_STAT_CHECK_CONDITION;
+		done(srb);
+		return 0;
+	}
+
 	/* enqueue the command and wake up the control thread */
 	srb->scsi_done =3D done;
 	us->srb =3D srb;
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index db6a57dfed44..bdd3fc01e6c3 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -991,6 +991,26 @@ static int uas_slave_configure(struct scsi_device *sde=
v)
 	if (devinfo->flags & US_FL_BROKEN_FUA)
 		sdev->broken_fua =3D 1;
=20
+	/*
+	 * Some disks return the total number of blocks in response
+	 * to READ CAPACITY rather than the highest block number.
+	 * If this device makes that mistake, tell the sd driver.
+	 */
+	if (devinfo->flags & US_FL_FIX_CAPACITY)
+		sdev->fix_capacity =3D 1;
+
+	/*
+	 * Some devices don't like MODE SENSE with page=3D0x3f,
+	 * which is the command used for checking if a device
+	 * is write-protected.  Now that we tell the sd driver
+	 * to do a 192-byte transfer with this command the
+	 * majority of devices work fine, but a few still can't
+	 * handle it.  The sd driver will simply assume those
+	 * devices are write-enabled.
+	 */
+	if (devinfo->flags & US_FL_NO_WP_DETECT)
+		sdev->skip_ms_page_3f =3D 1;
+
 	scsi_set_tag_type(sdev, MSG_ORDERED_TAG);
 	scsi_activate_tcq(sdev, devinfo->qdepth - 2);
 	return 0;
diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusu=
al_devs.h
index 01dcd204648f..c03043c6c022 100644
--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2144,6 +2144,13 @@ UNUSUAL_DEV(  0x2735, 0x100b, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_GO_SLOW ),
=20
+/* Reported-by: Tim Anderson <tsa@biglakesoftware.com> */
+UNUSUAL_DEV(  0x2ca3, 0x0031, 0x0000, 0x9999,
+		"DJI",
+		"CineSSD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_ATA_1X),
+
 /* Reported by Frederic Marchal <frederic.marchal@wowcompany.com>
  * Mio Moov 330
  */
diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyf=
b.h
index 1f39a62f899b..4d405d147a33 100644
--- a/drivers/video/fbdev/aty/atyfb.h
+++ b/drivers/video/fbdev/aty/atyfb.h
@@ -335,6 +335,8 @@ extern const struct aty_pll_ops aty_pll_ct; /* Integrat=
ed */
 extern void aty_set_pll_ct(const struct fb_info *info, const union aty_pll=
 *pll);
 extern u8 aty_ld_pll_ct(int offset, const struct atyfb_par *par);
=20
+extern const u8 aty_postdividers[8];
+
=20
     /*
      *  Hardware cursor support
@@ -361,7 +363,6 @@ static inline void wait_for_idle(struct atyfb_par *par)
=20
 extern void aty_reset_engine(const struct atyfb_par *par);
 extern void aty_init_engine(struct atyfb_par *par, struct fb_info *info);
-extern u8   aty_ld_pll_ct(int offset, const struct atyfb_par *par);
=20
 void atyfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 void atyfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty=
/atyfb_base.c
index fba5736acfd6..e9e7181dbe7b 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -3118,17 +3118,18 @@ static int atyfb_setup_sparc(struct pci_dev *pdev, =
struct fb_info *info,
 		/*
 		 * PLL Reference Divider M:
 		 */
-		M =3D pll_regs[2];
+		M =3D pll_regs[PLL_REF_DIV];
=20
 		/*
 		 * PLL Feedback Divider N (Dependent on CLOCK_CNTL):
 		 */
-		N =3D pll_regs[7 + (clock_cntl & 3)];
+		N =3D pll_regs[VCLK0_FB_DIV + (clock_cntl & 3)];
=20
 		/*
 		 * PLL Post Divider P (Dependent on CLOCK_CNTL):
 		 */
-		P =3D 1 << (pll_regs[6] >> ((clock_cntl & 3) << 1));
+		P =3D aty_postdividers[((pll_regs[VCLK_POST_DIV] >> ((clock_cntl & 3) <<=
 1)) & 3) |
+		                     ((pll_regs[PLL_EXT_CNTL] >> (2 + (clock_cntl & 3)))=
 & 4)];
=20
 		/*
 		 * PLL Divider Q:
diff --git a/drivers/video/fbdev/aty/mach64_ct.c b/drivers/video/fbdev/aty/=
mach64_ct.c
index 51f29d627ceb..af54256a20a1 100644
--- a/drivers/video/fbdev/aty/mach64_ct.c
+++ b/drivers/video/fbdev/aty/mach64_ct.c
@@ -114,7 +114,7 @@ static void aty_st_pll_ct(int offset, u8 val, const str=
uct atyfb_par *par)
  */
=20
 #define Maximum_DSP_PRECISION 7
-static u8 postdividers[] =3D {1,2,4,8,3};
+const u8 aty_postdividers[8] =3D {1,2,4,8,3,5,6,12};
=20
 static int aty_dsp_gt(const struct fb_info *info, u32 bpp, struct pll_ct *=
pll)
 {
@@ -221,7 +221,7 @@ static int aty_valid_pll_ct(const struct fb_info *info,=
 u32 vclk_per, struct pll
 		pll->vclk_post_div +=3D (q <  64*8);
 		pll->vclk_post_div +=3D (q <  32*8);
 	}
-	pll->vclk_post_div_real =3D postdividers[pll->vclk_post_div];
+	pll->vclk_post_div_real =3D aty_postdividers[pll->vclk_post_div];
 	//    pll->vclk_post_div <<=3D 6;
 	pll->vclk_fb_div =3D q * pll->vclk_post_div_real / 8;
 	pllvclk =3D (1000000 * 2 * pll->vclk_fb_div) /
@@ -512,7 +512,7 @@ static int aty_init_pll_ct(const struct fb_info *info, =
union aty_pll *pll)
 		u8 mclk_fb_div, pll_ext_cntl;
 		pll->ct.pll_ref_div =3D aty_ld_pll_ct(PLL_REF_DIV, par);
 		pll_ext_cntl =3D aty_ld_pll_ct(PLL_EXT_CNTL, par);
-		pll->ct.xclk_post_div_real =3D postdividers[pll_ext_cntl & 0x07];
+		pll->ct.xclk_post_div_real =3D aty_postdividers[pll_ext_cntl & 0x07];
 		mclk_fb_div =3D aty_ld_pll_ct(MCLK_FB_DIV, par);
 		if (pll_ext_cntl & PLL_MFB_TIMES_4_2B)
 			mclk_fb_div <<=3D 1;
@@ -534,7 +534,7 @@ static int aty_init_pll_ct(const struct fb_info *info, =
union aty_pll *pll)
 		xpost_div +=3D (q <  64*8);
 		xpost_div +=3D (q <  32*8);
 	}
-	pll->ct.xclk_post_div_real =3D postdividers[xpost_div];
+	pll->ct.xclk_post_div_real =3D aty_postdividers[xpost_div];
 	pll->ct.mclk_fb_div =3D q * pll->ct.xclk_post_div_real / 8;
=20
 #ifdef CONFIG_PPC
@@ -583,7 +583,7 @@ static int aty_init_pll_ct(const struct fb_info *info, =
union aty_pll *pll)
 			mpost_div +=3D (q <  64*8);
 			mpost_div +=3D (q <  32*8);
 		}
-		sclk_post_div_real =3D postdividers[mpost_div];
+		sclk_post_div_real =3D aty_postdividers[mpost_div];
 		pll->ct.sclk_fb_div =3D q * sclk_post_div_real / 8;
 		pll->ct.spll_cntl2 =3D mpost_div << 4;
 #ifdef DEBUG
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fb=
mem.c
index b5e85f6c1c26..0b96e34647d2 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1687,12 +1687,12 @@ static int do_register_framebuffer(struct fb_info *=
fb_info)
 	return 0;
 }
=20
-static int do_unregister_framebuffer(struct fb_info *fb_info)
+static int unbind_console(struct fb_info *fb_info)
 {
 	struct fb_event event;
-	int i, ret =3D 0;
+	int ret;
+	int i =3D fb_info->node;
=20
-	i =3D fb_info->node;
 	if (i < 0 || i >=3D FB_MAX || registered_fb[i] !=3D fb_info)
 		return -EINVAL;
=20
@@ -1707,17 +1707,29 @@ static int do_unregister_framebuffer(struct fb_info=
 *fb_info)
 	unlock_fb_info(fb_info);
 	console_unlock();
=20
+	return ret;
+}
+
+static int __unlink_framebuffer(struct fb_info *fb_info);
+
+static int do_unregister_framebuffer(struct fb_info *fb_info)
+{
+	struct fb_event event;
+	int ret;
+
+	ret =3D unbind_console(fb_info);
+
 	if (ret)
 		return -EINVAL;
=20
 	pm_vt_switch_unregister(fb_info->dev);
=20
-	unlink_framebuffer(fb_info);
+	__unlink_framebuffer(fb_info);
 	if (fb_info->pixmap.addr &&
 	    (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
 	fb_destroy_modelist(&fb_info->modelist);
-	registered_fb[i] =3D NULL;
+	registered_fb[fb_info->node] =3D NULL;
 	num_registered_fb--;
 	fb_cleanup_device(fb_info);
 	event.info =3D fb_info;
@@ -1730,7 +1742,7 @@ static int do_unregister_framebuffer(struct fb_info *=
fb_info)
 	return 0;
 }
=20
-int unlink_framebuffer(struct fb_info *fb_info)
+static int __unlink_framebuffer(struct fb_info *fb_info)
 {
 	int i;
=20
@@ -1742,6 +1754,20 @@ int unlink_framebuffer(struct fb_info *fb_info)
 		device_destroy(fb_class, MKDEV(FB_MAJOR, i));
 		fb_info->dev =3D NULL;
 	}
+
+	return 0;
+}
+
+int unlink_framebuffer(struct fb_info *fb_info)
+{
+	int ret;
+
+	ret =3D __unlink_framebuffer(fb_info);
+	if (ret)
+		return ret;
+
+	unbind_console(fb_info);
+
 	return 0;
 }
 EXPORT_SYMBOL(unlink_framebuffer);
diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/o=
map/omapfb_main.c
index d8d028d98711..42cf6381e449 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -982,7 +982,7 @@ int omapfb_register_client(struct omapfb_notifier_block=
 *omapfb_nb,
 {
 	int r;
=20
-	if ((unsigned)omapfb_nb->plane_idx > OMAPFB_PLANE_NUM)
+	if ((unsigned)omapfb_nb->plane_idx >=3D OMAPFB_PLANE_NUM)
 		return -EINVAL;
=20
 	if (!notifier_inited) {
diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c b/drivers/vide=
o/fbdev/omap2/omapfb/omapfb-ioctl.c
index 146b6f5428db..2dbd5687c453 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c
@@ -493,6 +493,9 @@ static int omapfb_memory_read(struct fb_info *fbi,
 	if (!access_ok(VERIFY_WRITE, mr->buffer, mr->buffer_size))
 		return -EFAULT;
=20
+	if (mr->w > 4096 || mr->h > 4096)
+		return -EINVAL;
+
 	if (mr->w * mr->h * 3 > mr->buffer_size)
 		return -EINVAL;
=20
@@ -506,7 +509,7 @@ static int omapfb_memory_read(struct fb_info *fbi,
 			mr->x, mr->y, mr->w, mr->h);
=20
 	if (r > 0) {
-		if (copy_to_user(mr->buffer, buf, mr->buffer_size))
+		if (copy_to_user(mr->buffer, buf, r))
 			r =3D -EFAULT;
 	}
=20
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 4c244c696aa6..75f88b6ab197 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/prefetch.h>
 #include <linux/delay.h>
+#include <asm/unaligned.h>
 #include <video/udlfb.h>
 #include "edid.h"
=20
@@ -443,9 +444,9 @@ static void dlfb_compress_hline(
=20
 		*cmd++ =3D 0xAF;
 		*cmd++ =3D 0x6B;
-		*cmd++ =3D (uint8_t) ((dev_addr >> 16) & 0xFF);
-		*cmd++ =3D (uint8_t) ((dev_addr >> 8) & 0xFF);
-		*cmd++ =3D (uint8_t) ((dev_addr) & 0xFF);
+		*cmd++ =3D dev_addr >> 16;
+		*cmd++ =3D dev_addr >> 8;
+		*cmd++ =3D dev_addr;
=20
 		cmd_pixels_count_byte =3D cmd++; /*  we'll know this later */
 		cmd_pixel_start =3D pixel;
@@ -453,16 +454,16 @@ static void dlfb_compress_hline(
 		raw_pixels_count_byte =3D cmd++; /*  we'll know this later */
 		raw_pixel_start =3D pixel;
=20
-		cmd_pixel_end =3D pixel + min(MAX_CMD_PIXELS + 1,
-			min((int)(pixel_end - pixel),
-			    (int)(cmd_buffer_end - cmd) / bpp));
+		cmd_pixel_end =3D pixel + min3(MAX_CMD_PIXELS + 1UL,
+					(unsigned long)(pixel_end - pixel),
+					(unsigned long)(cmd_buffer_end - 1 - cmd) / bpp);
=20
-		prefetch_range((void *) pixel, (cmd_pixel_end - pixel) * bpp);
+		prefetch_range((void *) pixel, (u8 *)cmd_pixel_end - (u8 *)pixel);
=20
 		while (pixel < cmd_pixel_end) {
 			const uint16_t * const repeating_pixel =3D pixel;
=20
-			*(uint16_t *)cmd =3D cpu_to_be16p(pixel);
+			put_unaligned_be16(*pixel, cmd);
 			cmd +=3D 2;
 			pixel++;
=20
@@ -489,13 +490,16 @@ static void dlfb_compress_hline(
 		if (pixel > raw_pixel_start) {
 			/* finalize last RAW span */
 			*raw_pixels_count_byte =3D (pixel-raw_pixel_start) & 0xFF;
+		} else {
+			/* undo unused byte */
+			cmd--;
 		}
=20
 		*cmd_pixels_count_byte =3D (pixel - cmd_pixel_start) & 0xFF;
-		dev_addr +=3D (pixel - cmd_pixel_start) * bpp;
+		dev_addr +=3D (u8 *)pixel - (u8 *)cmd_pixel_start;
 	}
=20
-	if (cmd_buffer_end <=3D MIN_RLX_CMD_BYTES + cmd) {
+	if (cmd_buffer_end - MIN_RLX_CMD_BYTES <=3D cmd) {
 		/* Fill leftover bytes with no-ops */
 		if (cmd_buffer_end > cmd)
 			memset(cmd, 0xAF, cmd_buffer_end - cmd);
@@ -615,8 +619,11 @@ static int dlfb_handle_damage(struct dlfb_data *dev, i=
nt x, int y,
 	}
=20
 	if (cmd > (char *) urb->transfer_buffer) {
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ =3D 0xAF;
 		/* Send partial buffer remaining before exiting */
-		int len =3D cmd - (char *) urb->transfer_buffer;
+		len =3D cmd - (char *) urb->transfer_buffer;
 		ret =3D dlfb_submit_urb(dev, urb, len);
 		bytes_sent +=3D len;
 	} else
@@ -740,8 +747,11 @@ static void dlfb_dpy_deferred_io(struct fb_info *info,
 	}
=20
 	if (cmd > (char *) urb->transfer_buffer) {
+		int len;
+		if (cmd < (char *) urb->transfer_buffer + urb->transfer_buffer_length)
+			*cmd++ =3D 0xAF;
 		/* Send partial buffer remaining before exiting */
-		int len =3D cmd - (char *) urb->transfer_buffer;
+		len =3D cmd - (char *) urb->transfer_buffer;
 		dlfb_submit_urb(dev, urb, len);
 		bytes_sent +=3D len;
 	} else
@@ -924,29 +934,15 @@ static void dlfb_free(struct kref *kref)
=20
 	if (dev->backing_buffer)
 		vfree(dev->backing_buffer);
-
 	kfree(dev->edid);
-
-	pr_warn("freeing dlfb_data %p\n", dev);
-
 	kfree(dev);
 }
=20
-static void dlfb_release_urb_work(struct work_struct *work)
-{
-	struct urb_node *unode =3D container_of(work, struct urb_node,
-					      release_urb_work.work);
-
-	up(&unode->dev->urbs.limit_sem);
-}
-
 static void dlfb_free_framebuffer(struct dlfb_data *dev)
 {
 	struct fb_info *info =3D dev->info;
=20
 	if (info) {
-		int node =3D info->node;
-
 		unregister_framebuffer(info);
=20
 		if (info->cmap.len !=3D 0)
@@ -962,8 +958,6 @@ static void dlfb_free_framebuffer(struct dlfb_data *dev)
=20
 		/* Assume info structure is freed after this point */
 		framebuffer_release(info);
-
-		pr_warn("fb_info for /dev/fb%d has been freed\n", node);
 	}
=20
 	/* ref taken in probe() as part of registering framebfufer */
@@ -1063,12 +1057,25 @@ static int dlfb_ops_set_par(struct fb_info *info)
 	int result;
 	u16 *pix_framebuffer;
 	int i;
+	struct fb_var_screeninfo fvs;
+
+	/* clear the activate field because it causes spurious miscompares */
+	fvs =3D info->var;
+	fvs.activate =3D 0;
+	fvs.vmode &=3D ~FB_VMODE_SMOOTH_XPAN;
=20
-	pr_notice("set_par mode %dx%d\n", info->var.xres, info->var.yres);
+	if (!memcmp(&dev->current_mode, &fvs, sizeof(struct fb_var_screeninfo)))
+		return 0;
=20
 	result =3D dlfb_set_video_mode(dev, &info->var);
=20
-	if ((result =3D=3D 0) && (dev->fb_count =3D=3D 0)) {
+	if (result)
+		return result;
+
+	dev->current_mode =3D fvs;
+	info->fix.line_length =3D info->var.xres * (info->var.bits_per_pixel / 8);
+
+	if (dev->fb_count =3D=3D 0) {
=20
 		/* paint greenscreen */
=20
@@ -1080,7 +1087,7 @@ static int dlfb_ops_set_par(struct fb_info *info)
 				   info->screen_base);
 	}
=20
-	return result;
+	return 0;
 }
=20
 /* To fonzi the jukebox (e.g. make blanking changes take effect) */
@@ -1168,8 +1175,6 @@ static int dlfb_realloc_framebuffer(struct dlfb_data =
*dev, struct fb_info *info)
 	unsigned char *new_fb;
 	unsigned char *new_back =3D NULL;
=20
-	pr_warn("Reallocating framebuffer. Addresses will change!\n");
-
 	new_len =3D info->fix.line_length * info->var.yres;
=20
 	if (PAGE_ALIGN(new_len) > old_len) {
@@ -1420,9 +1425,6 @@ static ssize_t edid_show(
 	if (off + count > dev->edid_size)
 		count =3D dev->edid_size - off;
=20
-	pr_info("sysfs edid copy %p to %p, %d bytes\n",
-		dev->edid, buf, (int) count);
-
 	memcpy(buf, dev->edid, count);
=20
 	return count;
@@ -1448,7 +1450,6 @@ static ssize_t edid_store(
 	if (!dev->edid || memcmp(src, dev->edid, src_size))
 		return -EINVAL;
=20
-	pr_info("sysfs written EDID is new default\n");
 	dlfb_ops_set_par(fb_info);
 	return src_size;
 }
@@ -1548,15 +1549,16 @@ static int dlfb_parse_vendor_descriptor(struct dlfb=
_data *dev,
 			u8 length;
 			u16 key;
=20
-			key =3D le16_to_cpu(*((u16 *) desc));
-			desc +=3D sizeof(u16);
-			length =3D *desc;
-			desc++;
+			key =3D *desc++;
+			key |=3D (u16)*desc++ << 8;
+			length =3D *desc++;
=20
 			switch (key) {
 			case 0x0200: { /* max_area */
-				u32 max_area;
-				max_area =3D le32_to_cpu(*((u32 *)desc));
+				u32 max_area =3D *desc++;
+				max_area |=3D (u32)*desc++ << 8;
+				max_area |=3D (u32)*desc++ << 16;
+				max_area |=3D (u32)*desc++ << 24;
 				pr_warn("DL chip limited to %d pixel modes\n",
 					max_area);
 				dev->sku_pixel_limit =3D max_area;
@@ -1679,7 +1681,8 @@ static void dlfb_init_framebuffer_work(struct work_st=
ruct *work)
 	dev->info =3D info;
 	info->par =3D dev;
 	info->pseudo_palette =3D dev->pseudo_palette;
-	info->fbops =3D &dlfb_ops;
+	dev->ops =3D dlfb_ops;
+	info->fbops =3D &dev->ops;
=20
 	retval =3D fb_alloc_cmap(&info->cmap, 256, 0);
 	if (retval < 0) {
@@ -1812,14 +1815,7 @@ static void dlfb_urb_completion(struct urb *urb)
 	dev->urbs.available++;
 	spin_unlock_irqrestore(&dev->urbs.lock, flags);
=20
-	/*
-	 * When using fb_defio, we deadlock if up() is called
-	 * while another is waiting. So queue to another process.
-	 */
-	if (fb_defio)
-		schedule_delayed_work(&unode->release_urb_work, 0);
-	else
-		up(&dev->urbs.limit_sem);
+	up(&dev->urbs.limit_sem);
 }
=20
 static void dlfb_free_urb_list(struct dlfb_data *dev)
@@ -1828,18 +1824,11 @@ static void dlfb_free_urb_list(struct dlfb_data *de=
v)
 	struct list_head *node;
 	struct urb_node *unode;
 	struct urb *urb;
-	int ret;
 	unsigned long flags;
=20
-	pr_notice("Freeing all render urbs\n");
-
 	/* keep waiting and freeing, until we've got 'em all */
 	while (count--) {
-
-		/* Getting interrupted means a leak, but ok at disconnect */
-		ret =3D down_interruptible(&dev->urbs.limit_sem);
-		if (ret)
-			break;
+		down(&dev->urbs.limit_sem);
=20
 		spin_lock_irqsave(&dev->urbs.lock, flags);
=20
@@ -1863,25 +1852,27 @@ static void dlfb_free_urb_list(struct dlfb_data *de=
v)
=20
 static int dlfb_alloc_urb_list(struct dlfb_data *dev, int count, size_t si=
ze)
 {
-	int i =3D 0;
 	struct urb *urb;
 	struct urb_node *unode;
 	char *buf;
+	size_t wanted_size =3D count * size;
=20
 	spin_lock_init(&dev->urbs.lock);
=20
+retry:
 	dev->urbs.size =3D size;
 	INIT_LIST_HEAD(&dev->urbs.list);
=20
-	while (i < count) {
+	sema_init(&dev->urbs.limit_sem, 0);
+	dev->urbs.count =3D 0;
+	dev->urbs.available =3D 0;
+
+	while (dev->urbs.count * size < wanted_size) {
 		unode =3D kzalloc(sizeof(struct urb_node), GFP_KERNEL);
 		if (!unode)
 			break;
 		unode->dev =3D dev;
=20
-		INIT_DELAYED_WORK(&unode->release_urb_work,
-			  dlfb_release_urb_work);
-
 		urb =3D usb_alloc_urb(0, GFP_KERNEL);
 		if (!urb) {
 			kfree(unode);
@@ -1889,11 +1880,16 @@ static int dlfb_alloc_urb_list(struct dlfb_data *de=
v, int count, size_t size)
 		}
 		unode->urb =3D urb;
=20
-		buf =3D usb_alloc_coherent(dev->udev, MAX_TRANSFER, GFP_KERNEL,
+		buf =3D usb_alloc_coherent(dev->udev, size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			kfree(unode);
 			usb_free_urb(urb);
+			if (size > PAGE_SIZE) {
+				size /=3D 2;
+				dlfb_free_urb_list(dev);
+				goto retry;
+			}
 			break;
 		}
=20
@@ -1904,16 +1900,12 @@ static int dlfb_alloc_urb_list(struct dlfb_data *de=
v, int count, size_t size)
=20
 		list_add_tail(&unode->entry, &dev->urbs.list);
=20
-		i++;
+		up(&dev->urbs.limit_sem);
+		dev->urbs.count++;
+		dev->urbs.available++;
 	}
=20
-	sema_init(&dev->urbs.limit_sem, i);
-	dev->urbs.count =3D i;
-	dev->urbs.available =3D i;
-
-	pr_notice("allocated %d %d byte urbs\n", i, (int) size);
-
-	return i;
+	return dev->urbs.count;
 }
=20
 static struct urb *dlfb_get_urb(struct dlfb_data *dev)
diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index f95e01e058e4..4062a715f6fc 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -121,7 +121,7 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *=
name,
 		   const void *value, size_t value_len, int flags)
 {
 	u64 offset =3D 0;
-	int retval, msize, write_count;
+	int retval, err, msize, write_count;
=20
 	p9_debug(P9_DEBUG_VFS, "name =3D %s value_len =3D %zu flags =3D %d\n",
 		 name, value_len, flags);
@@ -158,7 +158,9 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *=
name,
 	}
 	retval =3D 0;
 err:
-	p9_client_clunk(fid);
+	err =3D p9_client_clunk(fid);
+	if (!retval && err)
+		retval =3D err;
 	return retval;
 }
=20
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 679e312a9e40..972db0c5350d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1571,7 +1571,7 @@ static int fill_thread_core_info(struct elf_thread_co=
re_info *t,
 		const struct user_regset *regset =3D &view->regsets[i];
 		do_thread_regset_writeback(t->task, regset);
 		if (regset->core_note_type && regset->get &&
-		    (!regset->active || regset->active(t->task, regset))) {
+		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size =3D regset->n * regset->size;
 			void *data =3D kmalloc(size, GFP_KERNEL);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 329707b2148f..430c27e3aa1d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -991,8 +991,9 @@ static int btree_writepages(struct address_space *mappi=
ng,
=20
 		fs_info =3D BTRFS_I(mapping->host)->root->fs_info;
 		/* this is a bit racy, but that's ok */
-		ret =3D percpu_counter_compare(&fs_info->dirty_metadata_bytes,
-					     BTRFS_DIRTY_METADATA_THRESH);
+		ret =3D __percpu_counter_compare(&fs_info->dirty_metadata_bytes,
+					     BTRFS_DIRTY_METADATA_THRESH,
+					     fs_info->dirty_metadata_batch);
 		if (ret < 0)
 			return 0;
 	}
@@ -3793,8 +3794,9 @@ static void __btrfs_btree_balance_dirty(struct btrfs_=
root *root,
 	if (flush_delayed)
 		btrfs_balance_delayed_items(root);
=20
-	ret =3D percpu_counter_compare(&root->fs_info->dirty_metadata_bytes,
-				     BTRFS_DIRTY_METADATA_THRESH);
+	ret =3D __percpu_counter_compare(&root->fs_info->dirty_metadata_bytes,
+				     BTRFS_DIRTY_METADATA_THRESH,
+				     root->fs_info->dirty_metadata_batch);
 	if (ret > 0) {
 		balance_dirty_pages_ratelimited(
 				   root->fs_info->btree_inode->i_mapping);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 367ca3f40fdf..4ebcbac19678 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5542,31 +5542,6 @@ static int btrfs_real_readdir(struct file *file, str=
uct dir_context *ctx)
 	return ret;
 }
=20
-int btrfs_write_inode(struct inode *inode, struct writeback_control *wbc)
-{
-	struct btrfs_root *root =3D BTRFS_I(inode)->root;
-	struct btrfs_trans_handle *trans;
-	int ret =3D 0;
-	bool nolock =3D false;
-
-	if (test_bit(BTRFS_INODE_DUMMY, &BTRFS_I(inode)->runtime_flags))
-		return 0;
-
-	if (btrfs_fs_closing(root->fs_info) && btrfs_is_free_space_inode(inode))
-		nolock =3D true;
-
-	if (wbc->sync_mode =3D=3D WB_SYNC_ALL) {
-		if (nolock)
-			trans =3D btrfs_join_transaction_nolock(root);
-		else
-			trans =3D btrfs_join_transaction(root);
-		if (IS_ERR(trans))
-			return PTR_ERR(trans);
-		ret =3D btrfs_commit_transaction(trans, root);
-	}
-	return ret;
-}
-
 /*
  * This is somewhat expensive, updating the tree every time the
  * inode changes.  But, it is most likely to find the inode in cache.
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 72068ce50d76..838723d6a252 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1852,7 +1852,6 @@ static const struct super_operations btrfs_super_ops =
=3D {
 	.sync_fs	=3D btrfs_sync_fs,
 	.show_options	=3D btrfs_show_options,
 	.show_devname	=3D btrfs_show_devname,
-	.write_inode	=3D btrfs_write_inode,
 	.alloc_inode	=3D btrfs_alloc_inode,
 	.destroy_inode	=3D btrfs_destroy_inode,
 	.statfs		=3D btrfs_statfs,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 52c30fd35a81..4aa1a20fc5d7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2039,7 +2039,7 @@ int btrfs_init_new_device(struct btrfs_root *root, ch=
ar *device_path)
 	struct list_head *devices;
 	struct super_block *sb =3D root->fs_info->sb;
 	struct rcu_string *name;
-	u64 total_bytes;
+	u64 tmp;
 	int seeding_dev =3D 0;
 	int ret =3D 0;
=20
@@ -2142,13 +2142,13 @@ int btrfs_init_new_device(struct btrfs_root *root, =
char *device_path)
 	if (!blk_queue_nonrot(bdev_get_queue(bdev)))
 		root->fs_info->fs_devices->rotating =3D 1;
=20
-	total_bytes =3D btrfs_super_total_bytes(root->fs_info->super_copy);
+	tmp =3D btrfs_super_total_bytes(root->fs_info->super_copy);
 	btrfs_set_super_total_bytes(root->fs_info->super_copy,
-				    total_bytes + device->total_bytes);
+				    tmp + device->total_bytes);
=20
-	total_bytes =3D btrfs_super_num_devices(root->fs_info->super_copy);
+	tmp =3D btrfs_super_num_devices(root->fs_info->super_copy);
 	btrfs_set_super_num_devices(root->fs_info->super_copy,
-				    total_bytes + 1);
+				    tmp + 1);
=20
 	/* add sysfs device entry */
 	btrfs_kobj_add_device(root->fs_info, device);
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index bfeac417f168..8a91ca0e6143 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -317,7 +317,7 @@ static int cachefiles_bury_object(struct cachefiles_cac=
he *cache,
 	trap =3D lock_rename(cache->graveyard, dir);
=20
 	/* do some checks before getting the grave dentry */
-	if (rep->d_parent !=3D dir) {
+	if (rep->d_parent !=3D dir || IS_DEADDIR(d_inode(rep))) {
 		/* the entry was probably culled when we dropped the parent dir
 		 * lock */
 		unlock_rename(cache->graveyard, dir);
diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index ab4f1ce11ed0..6ac55e2ccd2f 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -141,25 +141,41 @@ static int cifs_debug_data_proc_show(struct seq_file =
*m, void *v)
 	seq_printf(m, "CIFS Version %s\n", CIFS_VERSION);
 	seq_printf(m, "Features:");
 #ifdef CONFIG_CIFS_DFS_UPCALL
-	seq_printf(m, " dfs");
+	seq_printf(m, " DFS");
 #endif
 #ifdef CONFIG_CIFS_FSCACHE
-	seq_printf(m, " fscache");
+	seq_printf(m, ",FSCACHE");
+#endif
+#ifdef CONFIG_CIFS_SMB_DIRECT
+	seq_printf(m, ",SMB_DIRECT");
+#endif
+#ifdef CONFIG_CIFS_STATS2
+	seq_printf(m, ",STATS2");
+#elif defined(CONFIG_CIFS_STATS)
+	seq_printf(m, ",STATS");
+#endif
+#ifdef CONFIG_CIFS_DEBUG2
+	seq_printf(m, ",DEBUG2");
+#elif defined(CONFIG_CIFS_DEBUG)
+	seq_printf(m, ",DEBUG");
+#endif
+#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+	seq_printf(m, ",ALLOW_INSECURE_LEGACY");
 #endif
 #ifdef CONFIG_CIFS_WEAK_PW_HASH
-	seq_printf(m, " lanman");
+	seq_printf(m, ",WEAK_PW_HASH");
 #endif
 #ifdef CONFIG_CIFS_POSIX
-	seq_printf(m, " posix");
+	seq_printf(m, ",CIFS_POSIX");
 #endif
 #ifdef CONFIG_CIFS_UPCALL
-	seq_printf(m, " spnego");
+	seq_printf(m, ",UPCALL(SPNEGO)");
 #endif
 #ifdef CONFIG_CIFS_XATTR
-	seq_printf(m, " xattr");
+	seq_printf(m, ",XATTR");
 #endif
 #ifdef CONFIG_CIFS_ACL
-	seq_printf(m, " acl");
+	seq_printf(m, ",ACL");
 #endif
 	seq_putc(m, '\n');
 	seq_printf(m, "Active VFS Requests: %d\n", GlobalTotalActiveXid);
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index bd6ebe78809d..048c0e09f57c 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -190,14 +190,18 @@ cifs_statfs(struct dentry *dentry, struct kstatfs *bu=
f)
=20
 	xid =3D get_xid();
=20
-	/*
-	 * PATH_MAX may be too long - it would presumably be total path,
-	 * but note that some servers (includinng Samba 3) have a shorter
-	 * maximum path.
-	 *
-	 * Instead could get the real value via SMB_QUERY_FS_ATTRIBUTE_INFO.
-	 */
-	buf->f_namelen =3D PATH_MAX;
+	if (le32_to_cpu(tcon->fsAttrInfo.MaxPathNameComponentLength) > 0)
+		buf->f_namelen =3D
+		       le32_to_cpu(tcon->fsAttrInfo.MaxPathNameComponentLength);
+	else
+		buf->f_namelen =3D PATH_MAX;
+
+#ifdef CONFIG_CIFS_SMB2
+	buf->f_fsid.val[0] =3D tcon->vol_serial_number;
+	/* are using part of create time for more randomness, see man statfs */
+	buf->f_fsid.val[1] =3D  (int)le64_to_cpu(tcon->vol_create_time);
+#endif
+
 	buf->f_files =3D 0;	/* undefined */
 	buf->f_ffree =3D 0;	/* unlimited */
=20
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 2b4ffbd37007..8b4ac4566500 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2829,15 +2829,10 @@ get_dfs_path(const unsigned int xid, struct cifs_se=
s *ses, const char *old_path,
 	*referrals =3D NULL;
=20
 	if (ses->ipc_tid =3D=3D 0) {
-		temp_unc =3D kmalloc(2 /* for slashes */ +
-			strnlen(ses->serverName, SERVER_NAME_LEN_WITH_NULL * 2)
-				+ 1 + 4 /* slash IPC$ */ + 2, GFP_KERNEL);
+		temp_unc =3D kasprintf(GFP_KERNEL, "\\\\%s\\IPC$",
+				     ses->server->hostname);
 		if (temp_unc =3D=3D NULL)
 			return -ENOMEM;
-		temp_unc[0] =3D '\\';
-		temp_unc[1] =3D '\\';
-		strcpy(temp_unc + 2, ses->serverName);
-		strcpy(temp_unc + 2 + strlen(ses->serverName), "\\IPC$");
 		rc =3D ses->server->ops->tree_connect(xid, ses, temp_unc, NULL,
 						    nls_codepage);
 		cifs_dbg(FYI, "Tcon rc =3D %d ipc_tid =3D %d\n", rc, ses->ipc_tid);
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index a9a5bee1890e..353d8b690329 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -446,6 +446,8 @@ cifs_sfu_type(struct cifs_fattr *fattr, const char *pat=
h,
 	oparms.cifs_sb =3D cifs_sb;
 	oparms.desired_access =3D GENERIC_READ;
 	oparms.create_options =3D CREATE_NOT_DIR;
+	if (backup_cred(cifs_sb))
+		oparms.create_options |=3D CREATE_OPEN_BACKUP_INTENT;
 	oparms.disposition =3D FILE_OPEN;
 	oparms.path =3D path;
 	oparms.fid =3D &fid;
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 27e4ad7ef172..2859b1b0002b 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -370,8 +370,15 @@ static char *nxt_dir_entry(char *old_entry, char *end_=
of_smb, int level)
=20
 		new_entry =3D old_entry + sizeof(FIND_FILE_STANDARD_INFO) +
 				pfData->FileNameLength;
-	} else
-		new_entry =3D old_entry + le32_to_cpu(pDirInfo->NextEntryOffset);
+	} else {
+		u32 next_offset =3D le32_to_cpu(pDirInfo->NextEntryOffset);
+
+		if (old_entry + next_offset < old_entry) {
+			cifs_dbg(VFS, "invalid offset %u\n", next_offset);
+			return NULL;
+		}
+		new_entry =3D old_entry + next_offset;
+	}
 	cifs_dbg(FYI, "new entry %p old entry %p\n", new_entry, old_entry);
 	/* validate that new_entry is not past end of SMB */
 	if (new_entry >=3D end_of_smb) {
diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 7225ae94006e..7426b06741ce 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -398,6 +398,12 @@ int build_ntlmssp_auth_blob(unsigned char **pbuffer,
 		goto setup_ntlmv2_ret;
 	}
 	*pbuffer =3D kmalloc(size_of_ntlmssp_blob(ses), GFP_KERNEL);
+	if (!*pbuffer) {
+		rc =3D -ENOMEM;
+		cifs_dbg(VFS, "Error %d during NTLMSSP allocation\n", rc);
+		*buflen =3D 0;
+		goto setup_ntlmv2_ret;
+	}
 	sec_blob =3D (AUTHENTICATE_MESSAGE *)*pbuffer;
=20
 	memcpy(sec_blob->Signature, NTLMSSP_SIGNATURE, 8);
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 64fde8bfc339..46bea6c44ec8 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -262,6 +262,8 @@ smb3_qfs_tcon(const unsigned int xid, struct cifs_tcon =
*tcon)
 			FS_ATTRIBUTE_INFORMATION);
 	SMB2_QFS_attr(xid, tcon, fid.persistent_fid, fid.volatile_fid,
 			FS_DEVICE_INFORMATION);
+	SMB2_QFS_attr(xid, tcon, fid.persistent_fid, fid.volatile_fid,
+			FS_VOLUME_INFORMATION);
 	SMB2_QFS_attr(xid, tcon, fid.persistent_fid, fid.volatile_fid,
 			FS_SECTOR_SIZE_INFORMATION); /* SMB3 specific */
 	SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
@@ -313,7 +315,10 @@ smb2_is_path_accessible(const unsigned int xid, struct=
 cifs_tcon *tcon,
 	oparms.tcon =3D tcon;
 	oparms.desired_access =3D FILE_READ_ATTRIBUTES;
 	oparms.disposition =3D FILE_OPEN;
-	oparms.create_options =3D 0;
+	if (backup_cred(cifs_sb))
+		oparms.create_options =3D CREATE_OPEN_BACKUP_INTENT;
+	else
+		oparms.create_options =3D 0;
 	oparms.fid =3D &fid;
 	oparms.reconnect =3D false;
=20
@@ -723,7 +728,10 @@ smb2_query_dir_first(const unsigned int xid, struct ci=
fs_tcon *tcon,
 	oparms.tcon =3D tcon;
 	oparms.desired_access =3D FILE_READ_ATTRIBUTES | FILE_READ_DATA;
 	oparms.disposition =3D FILE_OPEN;
-	oparms.create_options =3D 0;
+	if (backup_cred(cifs_sb))
+		oparms.create_options =3D CREATE_OPEN_BACKUP_INTENT;
+	else
+		oparms.create_options =3D 0;
 	oparms.fid =3D fid;
 	oparms.reconnect =3D false;
=20
@@ -735,7 +743,7 @@ smb2_query_dir_first(const unsigned int xid, struct cif=
s_tcon *tcon,
 	}
=20
 	srch_inf->entries_in_buffer =3D 0;
-	srch_inf->index_of_last_entry =3D 0;
+	srch_inf->index_of_last_entry =3D 2;
=20
 	rc =3D SMB2_query_directory(xid, tcon, fid->persistent_fid,
 				  fid->volatile_fid, 0, srch_inf);
@@ -889,7 +897,10 @@ smb2_query_symlink(const unsigned int xid, struct cifs=
_tcon *tcon,
 	oparms.tcon =3D tcon;
 	oparms.desired_access =3D FILE_READ_ATTRIBUTES;
 	oparms.disposition =3D FILE_OPEN;
-	oparms.create_options =3D 0;
+	if (backup_cred(cifs_sb))
+		oparms.create_options =3D CREATE_OPEN_BACKUP_INTENT;
+	else
+		oparms.create_options =3D 0;
 	oparms.fid =3D &fid;
 	oparms.reconnect =3D false;
=20
@@ -1422,7 +1433,7 @@ struct smb_version_values smb21_values =3D {
 struct smb_version_values smb30_values =3D {
 	.version_string =3D SMB30_VERSION_STRING,
 	.protocol_id =3D SMB30_PROT_ID,
-	.req_capabilities =3D SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB=
2_GLOBAL_CAP_LARGE_MTU,
+	.req_capabilities =3D SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB=
2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_DIRECTORY_LEASING,
 	.large_lock_type =3D 0,
 	.exclusive_lock_type =3D SMB2_LOCKFLAG_EXCLUSIVE_LOCK,
 	.shared_lock_type =3D SMB2_LOCKFLAG_SHARED_LOCK,
@@ -1442,7 +1453,7 @@ struct smb_version_values smb30_values =3D {
 struct smb_version_values smb302_values =3D {
 	.version_string =3D SMB302_VERSION_STRING,
 	.protocol_id =3D SMB302_PROT_ID,
-	.req_capabilities =3D SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB=
2_GLOBAL_CAP_LARGE_MTU,
+	.req_capabilities =3D SMB2_GLOBAL_CAP_DFS | SMB2_GLOBAL_CAP_LEASING | SMB=
2_GLOBAL_CAP_LARGE_MTU | SMB2_GLOBAL_CAP_DIRECTORY_LEASING,
 	.large_lock_type =3D 0,
 	.exclusive_lock_type =3D SMB2_LOCKFLAG_EXCLUSIVE_LOCK,
 	.shared_lock_type =3D SMB2_LOCKFLAG_SHARED_LOCK,
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 49563a5a2af9..7ae11fe72b11 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1211,6 +1211,9 @@ SMB2_open(const unsigned int xid, struct cifs_open_pa=
rms *oparms, __le16 *path,
 	if (!(server->capabilities & SMB2_GLOBAL_CAP_LEASING) ||
 	    *oplock =3D=3D SMB2_OPLOCK_LEVEL_NONE)
 		req->RequestedOplockLevel =3D *oplock;
+	else if (!(server->capabilities & SMB2_GLOBAL_CAP_DIRECTORY_LEASING) &&
+		  (oparms->create_options & CREATE_NOT_FILE))
+		req->RequestedOplockLevel =3D *oplock; /* no srv lease support */
 	else {
 		rc =3D add_lease_context(server, iov, &num_iovecs,
 				       oparms->fid->lease_key, oplock);
@@ -1391,14 +1394,14 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon=
 *tcon, u64 persistent_fid,
 	/* We check for obvious errors in the output buffer length and offset */
 	if (*plen =3D=3D 0)
 		goto ioctl_exit; /* server returned no data */
-	else if (*plen > 0xFF00) {
+	else if (*plen > get_rfc1002_length(rsp) || *plen > 0xFF00) {
 		cifs_dbg(VFS, "srv returned invalid ioctl length: %d\n", *plen);
 		*plen =3D 0;
 		rc =3D -EIO;
 		goto ioctl_exit;
 	}
=20
-	if (get_rfc1002_length(rsp) < le32_to_cpu(rsp->OutputOffset) + *plen) {
+	if (get_rfc1002_length(rsp) - *plen < le32_to_cpu(rsp->OutputOffset)) {
 		cifs_dbg(VFS, "Malformed ioctl resp: len %d offset %d\n", *plen,
 			le32_to_cpu(rsp->OutputOffset));
 		*plen =3D 0;
@@ -2145,33 +2148,38 @@ num_entries(char *bufstart, char *end_of_buf, char =
**lastentry, size_t size)
 	int len;
 	unsigned int entrycount =3D 0;
 	unsigned int next_offset =3D 0;
-	FILE_DIRECTORY_INFO *entryptr;
+	char *entryptr;
+	FILE_DIRECTORY_INFO *dir_info;
=20
 	if (bufstart =3D=3D NULL)
 		return 0;
=20
-	entryptr =3D (FILE_DIRECTORY_INFO *)bufstart;
+	entryptr =3D bufstart;
=20
 	while (1) {
-		entryptr =3D (FILE_DIRECTORY_INFO *)
-					((char *)entryptr + next_offset);
-
-		if ((char *)entryptr + size > end_of_buf) {
+		if (entryptr + next_offset < entryptr ||
+		    entryptr + next_offset > end_of_buf ||
+		    entryptr + next_offset + size > end_of_buf) {
 			cifs_dbg(VFS, "malformed search entry would overflow\n");
 			break;
 		}
=20
-		len =3D le32_to_cpu(entryptr->FileNameLength);
-		if ((char *)entryptr + len + size > end_of_buf) {
+		entryptr =3D entryptr + next_offset;
+		dir_info =3D (FILE_DIRECTORY_INFO *)entryptr;
+
+		len =3D le32_to_cpu(dir_info->FileNameLength);
+		if (entryptr + len < entryptr ||
+		    entryptr + len > end_of_buf ||
+		    entryptr + len + size > end_of_buf) {
 			cifs_dbg(VFS, "directory entry name would overflow frame end of buf %p\=
n",
 				 end_of_buf);
 			break;
 		}
=20
-		*lastentry =3D (char *)entryptr;
+		*lastentry =3D entryptr;
 		entrycount++;
=20
-		next_offset =3D le32_to_cpu(entryptr->NextEntryOffset);
+		next_offset =3D le32_to_cpu(dir_info->NextEntryOffset);
 		if (!next_offset)
 			break;
 	}
@@ -2614,6 +2622,9 @@ SMB2_QFS_attr(const unsigned int xid, struct cifs_tco=
n *tcon,
 	} else if (level =3D=3D FS_SECTOR_SIZE_INFORMATION) {
 		max_len =3D sizeof(struct smb3_fs_ss_info);
 		min_len =3D sizeof(struct smb3_fs_ss_info);
+	} else if (level =3D=3D FS_VOLUME_INFORMATION) {
+		max_len =3D sizeof(struct smb3_fs_vol_info) + MAX_VOL_LABEL_LEN;
+		min_len =3D sizeof(struct smb3_fs_vol_info);
 	} else {
 		cifs_dbg(FYI, "Invalid qfsinfo level %d\n", level);
 		return -EINVAL;
@@ -2650,6 +2661,11 @@ SMB2_QFS_attr(const unsigned int xid, struct cifs_tc=
on *tcon,
 		tcon->ss_flags =3D le32_to_cpu(ss_info->Flags);
 		tcon->perf_sector_size =3D
 			le32_to_cpu(ss_info->PhysicalBytesPerSectorForPerf);
+	} else if (level =3D=3D FS_VOLUME_INFORMATION) {
+		struct smb3_fs_vol_info *vol_info =3D (struct smb3_fs_vol_info *)
+			(offset + (char *)rsp);
+		tcon->vol_serial_number =3D vol_info->VolumeSerialNumber;
+		tcon->vol_create_time =3D vol_info->VolumeCreationTime;
 	}
=20
 qfsattr_exit:
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index fce1cc92c2ff..d57eb9d66209 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -946,6 +946,17 @@ struct smb3_fs_ss_info {
 	__le32 ByteOffsetForPartitionAlignment;
 } __packed;
=20
+/* volume info struct - see MS-FSCC 2.5.9 */
+#define MAX_VOL_LABEL_LEN	32
+struct smb3_fs_vol_info {
+	__le64	VolumeCreationTime;
+	__u32	VolumeSerialNumber;
+	__le32	VolumeLabelLength; /* includes trailing null */
+	__u8	SupportsObjects; /* True if eg like NTFS, supports objects */
+	__u8	Reserved;
+	__u8	VolumeLabel[0]; /* variable len */
+} __packed;
+
 /* partial list of QUERY INFO levels */
 #define FILE_DIRECTORY_INFORMATION	1
 #define FILE_FULL_DIRECTORY_INFORMATION 2
diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 8dd5c51e2200..20e6a870d114 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -77,7 +77,7 @@ int __ext4_check_dir_entry(const char *function, unsigned=
 int line,
 	else if (unlikely(rlen < EXT4_DIR_REC_LEN(de->name_len)))
 		error_msg =3D "rec_len is too small for name_len";
 	else if (unlikely(((char *) de - buf) + rlen > size))
-		error_msg =3D "directory entry across range";
+		error_msg =3D "directory entry overrun";
 	else if (unlikely(le32_to_cpu(de->inode) >
 			le32_to_cpu(EXT4_SB(dir->i_sb)->s_es->s_inodes_count)))
 		error_msg =3D "inode out of bounds";
@@ -86,18 +86,16 @@ int __ext4_check_dir_entry(const char *function, unsign=
ed int line,
=20
 	if (filp)
 		ext4_error_file(filp, function, line, bh->b_blocknr,
-				"bad entry in directory: %s - offset=3D%u(%u), "
-				"inode=3D%u, rec_len=3D%d, name_len=3D%d",
-				error_msg, (unsigned) (offset % size),
-				offset, le32_to_cpu(de->inode),
-				rlen, de->name_len);
+				"bad entry in directory: %s - offset=3D%u, "
+				"inode=3D%u, rec_len=3D%d, name_len=3D%d, size=3D%d",
+				error_msg, offset, le32_to_cpu(de->inode),
+				rlen, de->name_len, size);
 	else
 		ext4_error_inode(dir, function, line, bh->b_blocknr,
-				"bad entry in directory: %s - offset=3D%u(%u), "
-				"inode=3D%u, rec_len=3D%d, name_len=3D%d",
-				error_msg, (unsigned) (offset % size),
-				offset, le32_to_cpu(de->inode),
-				rlen, de->name_len);
+				"bad entry in directory: %s - offset=3D%u, "
+				"inode=3D%u, rec_len=3D%d, name_len=3D%d, size=3D%d",
+				 error_msg, offset, le32_to_cpu(de->inode),
+				 rlen, de->name_len, size);
=20
 	return 1;
 }
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1c84749699d0..06b31f567cf8 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1741,6 +1741,7 @@ int empty_inline_dir(struct inode *dir, int *has_inli=
ne_data)
 {
 	int err, inline_size;
 	struct ext4_iloc iloc;
+	size_t inline_len;
 	void *inline_pos;
 	unsigned int offset;
 	struct ext4_dir_entry_2 *de;
@@ -1768,8 +1769,9 @@ int empty_inline_dir(struct inode *dir, int *has_inli=
ne_data)
 		goto out;
 	}
=20
+	inline_len =3D ext4_get_inline_size(dir);
 	offset =3D EXT4_INLINE_DOTDOT_SIZE;
-	while (offset < dir->i_size) {
+	while (offset < inline_len) {
 		de =3D ext4_get_inline_entry(dir, &iloc, offset,
 					   &inline_pos, &inline_size);
 		if (ext4_check_dir_entry(dir, NULL, de,
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 15e8ab88dfc6..6fe7d6adb33e 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -26,6 +26,7 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/nospec.h>
 #include <trace/events/ext4.h>
=20
 #ifdef CONFIG_EXT4_DEBUG
@@ -2124,7 +2125,8 @@ ext4_mb_regular_allocator(struct ext4_allocation_cont=
ext *ac)
 		 * This should tell if fe_len is exactly power of 2
 		 */
 		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) =3D=3D 0)
-			ac->ac_2order =3D i - 1;
+			ac->ac_2order =3D array_index_nospec(i - 1,
+							   sb->s_blocksize_bits + 2);
 	}
=20
 	/* if stream allocation is enabled, use global goal */
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index 8313ca3324ec..c3922ee59031 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -48,7 +48,6 @@ static int write_mmp_block(struct super_block *sb, struct=
 buffer_head *bh)
 	 */
 	sb_start_write(sb);
 	ext4_mmp_csum_set(sb, mmp);
-	mark_buffer_dirty(bh);
 	lock_buffer(bh);
 	bh->b_end_io =3D end_buffer_write_sync;
 	get_bh(bh);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 7edf1bee591b..deebe58586c2 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3211,6 +3211,12 @@ static int ext4_rename(struct inode *old_dir, struct=
 dentry *old_dentry,
 	int force_reread;
 	int retval;
=20
+	if (new.inode && new.inode->i_nlink =3D=3D 0) {
+		EXT4_ERROR_INODE(new.inode,
+				 "target of rename is already freed");
+		return -EIO;
+	}
+
 	dquot_initialize(old.dir);
 	dquot_initialize(new.dir);
=20
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index cacbf0af6d31..52fb5c7db73d 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -18,11 +18,24 @@
=20
 int ext4_resize_begin(struct super_block *sb)
 {
+	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
 	int ret =3D 0;
=20
 	if (!capable(CAP_SYS_RESOURCE))
 		return -EPERM;
=20
+	/*
+	 * If we are not using the primary superblock/GDT copy don't resize,
+         * because the user tools have no way of handling this.  Probably a
+         * bad time to do it anyways.
+         */
+	if (EXT4_B2C(sbi, sbi->s_sbh->b_blocknr) !=3D
+	    le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) {
+		ext4_warning(sb, "won't resize using backup superblock at %llu",
+			(unsigned long long)EXT4_SB(sb)->s_sbh->b_blocknr);
+		return -EPERM;
+	}
+
 	/*
 	 * We are not allowed to do online-resizing on a filesystem mounted
 	 * with error, because it can destroy the filesystem easily.
@@ -758,18 +771,6 @@ static int add_new_gdb(handle_t *handle, struct inode =
*inode,
 		       "EXT4-fs: ext4_add_new_gdb: adding group block %lu\n",
 		       gdb_num);
=20
-	/*
-	 * If we are not using the primary superblock/GDT copy don't resize,
-         * because the user tools have no way of handling this.  Probably a
-         * bad time to do it anyways.
-         */
-	if (EXT4_SB(sb)->s_sbh->b_blocknr !=3D
-	    le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block)) {
-		ext4_warning(sb, "won't resize using backup superblock at %llu",
-			(unsigned long long)EXT4_SB(sb)->s_sbh->b_blocknr);
-		return -EPERM;
-	}
-
 	gdb_bh =3D sb_bread(sb, gdblock);
 	if (!gdb_bh)
 		return -EIO;
@@ -1957,6 +1958,26 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsbl=
k_t n_blocks_count)
 		}
 	}
=20
+	/*
+	 * Make sure the last group has enough space so that it's
+	 * guaranteed to have enough space for all metadata blocks
+	 * that it might need to hold.  (We might not need to store
+	 * the inode table blocks in the last block group, but there
+	 * will be cases where this might be needed.)
+	 */
+	if ((ext4_group_first_block_no(sb, n_group) +
+	     ext4_group_overhead_blocks(sb, n_group) + 2 +
+	     sbi->s_itb_per_group + sbi->s_cluster_ratio) >=3D n_blocks_count) {
+		n_blocks_count =3D ext4_group_first_block_no(sb, n_group);
+		n_group--;
+		n_blocks_count_retry =3D 0;
+		if (resize_inode) {
+			iput(resize_inode);
+			resize_inode =3D NULL;
+		}
+		goto retry;
+	}
+
 	/* extend the last group */
 	if (n_group =3D=3D o_group)
 		add =3D n_blocks_count - o_blocks_count;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 927c837e2d13..61e89046f8dd 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -193,6 +193,8 @@ ext4_xattr_check_names(struct ext4_xattr_entry *entry, =
void *end,
 		struct ext4_xattr_entry *next =3D EXT4_XATTR_NEXT(e);
 		if ((void *)next >=3D end)
 			return -EIO;
+		if (strnlen(e->e_name, e->e_name_len) !=3D e->e_name_len)
+			return -EIO;
 		e =3D next;
 	}
=20
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 966ace8b243f..28d0c7abba1c 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -415,7 +415,7 @@ static void cuse_process_init_reply(struct fuse_conn *f=
c, struct fuse_req *req)
 err_region:
 	unregister_chrdev_region(devt, 1);
 err:
-	fuse_conn_kill(fc);
+	fuse_abort_conn(fc);
 	goto out;
 }
=20
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f2bbb8513360..0834f5640875 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1913,11 +1913,14 @@ static ssize_t fuse_dev_splice_write(struct pipe_in=
ode_info *pipe,
 	if (!fc)
 		return -EPERM;
=20
+	pipe_lock(pipe);
+
 	bufs =3D kmalloc(pipe->buffers * sizeof(struct pipe_buffer), GFP_KERNEL);
-	if (!bufs)
+	if (!bufs) {
+		pipe_unlock(pipe);
 		return -ENOMEM;
+	}
=20
-	pipe_lock(pipe);
 	nbuf =3D 0;
 	rem =3D 0;
 	for (idx =3D 0; idx < pipe->nrbufs && rem < len; idx++)
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 893c1fcc6931..3bae40c4d40f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -911,6 +911,7 @@ static int fuse_readpages_fill(void *_data, struct page=
 *page)
 	}
=20
 	if (WARN_ON(req->num_pages >=3D req->max_pages)) {
+		unlock_page(page);
 		fuse_put_request(fc, req);
 		return -EIO;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 300619ba8591..8ed9ed08d2a0 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -804,8 +804,6 @@ void fuse_invalidate_atime(struct inode *inode);
  */
 struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
=20
-void fuse_conn_kill(struct fuse_conn *fc);
-
 /**
  * Initialize fuse_conn
  */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 476efb34a18f..513aadb54002 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -376,28 +376,10 @@ static void fuse_bdi_destroy(struct fuse_conn *fc)
 		bdi_destroy(&fc->bdi);
 }
=20
-void fuse_conn_kill(struct fuse_conn *fc)
-{
-	spin_lock(&fc->lock);
-	fc->connected =3D 0;
-	fc->blocked =3D 0;
-	fc->initialized =3D 1;
-	spin_unlock(&fc->lock);
-	/* Flush all readers on this fs */
-	kill_fasync(&fc->fasync, SIGIO, POLL_IN);
-	wake_up_all(&fc->waitq);
-	wake_up_all(&fc->blocked_waitq);
-	wake_up_all(&fc->reserved_req_waitq);
-}
-EXPORT_SYMBOL_GPL(fuse_conn_kill);
-
 static void fuse_put_super(struct super_block *sb)
 {
 	struct fuse_conn *fc =3D get_fuse_conn_super(sb);
=20
-	fuse_send_destroy(fc);
-
-	fuse_conn_kill(fc);
 	mutex_lock(&fuse_mutex);
 	list_del(&fc->entry);
 	fuse_ctl_remove_conn(fc);
@@ -1139,16 +1121,24 @@ static struct dentry *fuse_mount(struct file_system=
_type *fs_type,
 	return mount_nodev(fs_type, flags, raw_data, fuse_fill_super);
 }
=20
-static void fuse_kill_sb_anon(struct super_block *sb)
+static void fuse_sb_destroy(struct super_block *sb)
 {
 	struct fuse_conn *fc =3D get_fuse_conn_super(sb);
=20
 	if (fc) {
+		fuse_send_destroy(fc);
+
+		fuse_abort_conn(fc);
+
 		down_write(&fc->killsb);
 		fc->sb =3D NULL;
 		up_write(&fc->killsb);
 	}
+}
=20
+static void fuse_kill_sb_anon(struct super_block *sb)
+{
+	fuse_sb_destroy(sb);
 	kill_anon_super(sb);
 }
=20
@@ -1171,14 +1161,7 @@ static struct dentry *fuse_mount_blk(struct file_sys=
tem_type *fs_type,
=20
 static void fuse_kill_sb_blk(struct super_block *sb)
 {
-	struct fuse_conn *fc =3D get_fuse_conn_super(sb);
-
-	if (fc) {
-		down_write(&fc->killsb);
-		fc->sb =3D NULL;
-		up_write(&fc->killsb);
-	}
-
+	fuse_sb_destroy(sb);
 	kill_block_super(sb);
 }
=20
diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index 1edcb141f639..d6eab71abe1f 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -330,6 +330,7 @@ int ocfs2_read_blocks(struct ocfs2_caching_info *ci, u6=
4 block, int nr,
 				 * for this bh as it's not marked locally
 				 * uptodate. */
 				status =3D -EIO;
+				clear_buffer_needs_validate(bh);
 				put_bh(bh);
 				bhs[i] =3D NULL;
 				continue;
diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 12bb043f944a..e201a9ce84d8 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -599,9 +599,9 @@ static void dlm_init_lockres(struct dlm_ctxt *dlm,
=20
 	res->last_used =3D 0;
=20
-	spin_lock(&dlm->spinlock);
+	spin_lock(&dlm->track_lock);
 	list_add_tail(&res->tracking, &dlm->tracking_list);
-	spin_unlock(&dlm->spinlock);
+	spin_unlock(&dlm->track_lock);
=20
 	memset(res->lvb, 0, DLM_LVB_LEN);
 	memset(res->refmap, 0, sizeof(res->refmap));
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8233f183a945..3c19b89b9303 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -273,6 +273,20 @@ static int proc_pid_stack(struct seq_file *m, struct p=
id_namespace *ns,
 	int err;
 	int i;
=20
+	/*
+	 * The ability to racily run the kernel stack unwinder on a running task
+	 * and then observe the unwinder output is scary; while it is useful for
+	 * debugging kernel issues, it can also allow an attacker to leak kernel
+	 * stack contents.
+	 * Doing this in a manner that is at least safe from races would require
+	 * some work to ensure that the remote task can not be scheduled; and
+	 * even then, this would still expose the unwinder as local attack
+	 * surface.
+	 * Therefore, this interface is restricted to root.
+	 */
+	if (!file_ns_capable(m->file, &init_user_ns, CAP_SYS_ADMIN))
+		return -EACCES;
+
 	entries =3D kmalloc(MAX_STACK_TRACE_DEPTH * sizeof(*entries), GFP_KERNEL);
 	if (!entries)
 		return -ENOMEM;
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index 5fa34243b1ae..a467edd1a363 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -557,8 +557,22 @@ static struct platform_driver ramoops_driver =3D {
 	},
 };
=20
-static void ramoops_register_dummy(void)
+static inline void ramoops_unregister_dummy(void)
 {
+	platform_device_unregister(dummy);
+	dummy =3D NULL;
+
+	kfree(dummy_data);
+	dummy_data =3D NULL;
+}
+
+static void __init ramoops_register_dummy(void)
+{
+	/*
+	 * Prepare a dummy platform data structure to carry the module
+	 * parameters. If mem_size isn't set, then there are no module
+	 * parameters, and we can skip this.
+	 */
 	if (!mem_size)
 		return;
=20
@@ -588,21 +602,28 @@ static void ramoops_register_dummy(void)
 	if (IS_ERR(dummy)) {
 		pr_info("could not create platform device: %ld\n",
 			PTR_ERR(dummy));
+		dummy =3D NULL;
+		ramoops_unregister_dummy();
 	}
 }
=20
 static int __init ramoops_init(void)
 {
+	int ret;
+
 	ramoops_register_dummy();
-	return platform_driver_register(&ramoops_driver);
+	ret =3D platform_driver_register(&ramoops_driver);
+	if (ret !=3D 0)
+		ramoops_unregister_dummy();
+
+	return ret;
 }
 postcore_initcall(ramoops_init);
=20
 static void __exit ramoops_exit(void)
 {
 	platform_driver_unregister(&ramoops_driver);
-	platform_device_unregister(dummy);
-	kfree(dummy_data);
+	ramoops_unregister_dummy();
 }
 module_exit(ramoops_exit);
=20
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 5fa2200e5b66..ab3d9ffd77ff 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -376,7 +376,12 @@ static void *persistent_ram_vmap(phys_addr_t start, si=
ze_t size,
 	vaddr =3D vmap(pages, page_count, VM_MAP, prot);
 	kfree(pages);
=20
-	return vaddr;
+	/*
+	 * Since vmap() uses page granularity, we must add the offset
+	 * into the page here, to get the byte granularity address
+	 * into the mapping to represent the actual "start" location.
+	 */
+	return vaddr + offset_in_page(start);
 }
=20
 static void *persistent_ram_iomap(phys_addr_t start, size_t size,
@@ -395,6 +400,11 @@ static void *persistent_ram_iomap(phys_addr_t start, s=
ize_t size,
 	else
 		va =3D ioremap_wc(start, size);
=20
+	/*
+	 * Since request_mem_region() and ioremap() are byte-granularity
+	 * there is no need handle anything special like we do when the
+	 * vmap() case in persistent_ram_vmap() above.
+	 */
 	return va;
 }
=20
@@ -415,7 +425,7 @@ static int persistent_ram_buffer_map(phys_addr_t start,=
 phys_addr_t size,
 		return -ENOMEM;
 	}
=20
-	prz->buffer =3D prz->vaddr + offset_in_page(start);
+	prz->buffer =3D prz->vaddr;
 	prz->buffer_size =3D size - sizeof(struct persistent_ram_buffer);
=20
 	return 0;
@@ -461,7 +471,8 @@ void persistent_ram_free(struct persistent_ram_zone *pr=
z)
=20
 	if (prz->vaddr) {
 		if (pfn_valid(prz->paddr >> PAGE_SHIFT)) {
-			vunmap(prz->vaddr);
+			/* We must vunmap() at page-granularity. */
+			vunmap(prz->vaddr - offset_in_page(prz->paddr));
 		} else {
 			iounmap(prz->vaddr);
 			release_mem_region(prz->paddr, prz->size);
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 47bd89700d77..cc138af88442 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -17,6 +17,7 @@
 #include <linux/quotaops.h>
 #include <linux/types.h>
 #include <linux/writeback.h>
+#include <linux/nospec.h>
=20
 static int check_quotactl_permission(struct super_block *sb, int type, int=
 cmd,
 				     qid_t id)
@@ -405,10 +406,12 @@ static int quota_rmxquota(struct super_block *sb, voi=
d __user *addr)
 static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id,
 		       void __user *addr, struct path *path)
 {
+	unsigned int max_quotas =3D XQM_COMMAND(cmd) ? XQM_MAXQUOTAS : MAXQUOTAS;
 	int ret;
=20
-	if (type >=3D (XQM_COMMAND(cmd) ? XQM_MAXQUOTAS : MAXQUOTAS))
+	if (type >=3D max_quotas)
 		return -EINVAL;
+	type =3D array_index_nospec(type, max_quotas);
 	if (!sb->s_qcop)
 		return -ENOSYS;
=20
diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index ca416d099e7d..0ea34b4dc0aa 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -822,10 +822,12 @@ static int listxattr_filler(void *buf, const char *na=
me, int namelen,
 			return 0;
 		if (b->buf) {
 			size =3D handler->list(b->dentry, b->buf + b->pos,
-					 b->size, name, namelen,
+					 b->size - b->pos, name, namelen,
 					 handler->flags);
-			if (size > b->size)
+			if (b->pos + size > b->size) {
+				b->pos =3D -ERANGE;
 				return -ERANGE;
+			}
 		} else {
 			size =3D handler->list(b->dentry, NULL, 0, name,
 					     namelen, handler->flags);
diff --git a/fs/seq_file.c b/fs/seq_file.c
index fbb1688bff87..8f393353880b 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -69,9 +69,10 @@ int seq_open(struct file *file, const struct seq_operati=
ons *op)
 	memset(p, 0, sizeof(*p));
 	mutex_init(&p->lock);
 	p->op =3D op;
-#ifdef CONFIG_USER_NS
-	p->user_ns =3D file->f_cred->user_ns;
-#endif
+
+	// No refcounting: the lifetime of 'p' is constrained
+	// to the lifetime of the file.
+	p->file =3D file;
=20
 	/*
 	 * Wrappers around seq_open(e.g. swaps_open) need to be
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index e9ef59b3abb1..154a4a953887 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -356,6 +356,50 @@ int sysfs_chmod_file(struct kobject *kobj, const struc=
t attribute *attr,
 }
 EXPORT_SYMBOL_GPL(sysfs_chmod_file);
=20
+/**
+ * sysfs_break_active_protection - break "active" protection
+ * @kobj: The kernel object @attr is associated with.
+ * @attr: The attribute to break the "active" protection for.
+ *
+ * With sysfs, just like kernfs, deletion of an attribute is postponed unt=
il
+ * all active .show() and .store() callbacks have finished unless this fun=
ction
+ * is called. Hence this function is useful in methods that implement self
+ * deletion.
+ */
+struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
+						  const struct attribute *attr)
+{
+	struct kernfs_node *kn;
+
+	kobject_get(kobj);
+	kn =3D kernfs_find_and_get(kobj->sd, attr->name);
+	if (kn)
+		kernfs_break_active_protection(kn);
+	return kn;
+}
+EXPORT_SYMBOL_GPL(sysfs_break_active_protection);
+
+/**
+ * sysfs_unbreak_active_protection - restore "active" protection
+ * @kn: Pointer returned by sysfs_break_active_protection().
+ *
+ * Undo the effects of sysfs_break_active_protection(). Since this function
+ * calls kernfs_put() on the kernfs node that corresponds to the 'attr'
+ * argument passed to sysfs_break_active_protection() that attribute may h=
ave
+ * been removed between the sysfs_break_active_protection() and
+ * sysfs_unbreak_active_protection() calls, it is not safe to access @kn a=
fter
+ * this function has returned.
+ */
+void sysfs_unbreak_active_protection(struct kernfs_node *kn)
+{
+	struct kobject *kobj =3D kn->parent->priv;
+
+	kernfs_unbreak_active_protection(kn);
+	kernfs_put(kn);
+	kobject_put(kobj);
+}
+EXPORT_SYMBOL_GPL(sysfs_unbreak_active_protection);
+
 /**
  * sysfs_remove_file_ns - remove an object attribute with a custom ns tag
  * @kobj: object we're acting for
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 2e93c33b1048..8bf3a7fc9da9 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -657,6 +657,11 @@ int ubifs_jnl_update(struct ubifs_info *c, const struc=
t inode *dir,
 	spin_lock(&ui->ui_lock);
 	ui->synced_i_size =3D ui->ui_size;
 	spin_unlock(&ui->ui_lock);
+	if (xent) {
+		spin_lock(&dir_ui->ui_lock);
+		dir_ui->synced_i_size =3D dir_ui->ui_size;
+		spin_unlock(&dir_ui->ui_lock);
+	}
 	mark_inode_clean(c, ui);
 	mark_inode_clean(c, dir_ui);
 	return 0;
@@ -1181,7 +1186,16 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const s=
truct inode *inode,
 		else if (err)
 			goto out_free;
 		else {
-			if (le32_to_cpu(dn->size) <=3D dlen)
+			int dn_len =3D le32_to_cpu(dn->size);
+
+			if (dn_len <=3D 0 || dn_len > UBIFS_BLOCK_SIZE) {
+				ubifs_err("bad data node (block %u, inode %lu)",
+					  blk, inode->i_ino);
+				ubifs_dump_node(c, dn);
+				goto out_free;
+			}
+
+			if (dn_len <=3D dlen)
 				dlen =3D 0; /* Nothing to do */
 			else {
 				int compr_type =3D le16_to_cpu(dn->compr_type);
diff --git a/fs/ubifs/lprops.c b/fs/ubifs/lprops.c
index 46190a7c42a6..a0ee59b3974a 100644
--- a/fs/ubifs/lprops.c
+++ b/fs/ubifs/lprops.c
@@ -1091,10 +1091,6 @@ static int scan_check_cb(struct ubifs_info *c,
 		}
 	}
=20
-	buf =3D __vmalloc(c->leb_size, GFP_NOFS, PAGE_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	/*
 	 * After an unclean unmount, empty and freeable LEBs
 	 * may contain garbage - do not scan them.
@@ -1113,6 +1109,10 @@ static int scan_check_cb(struct ubifs_info *c,
 		return LPT_SCAN_CONTINUE;
 	}
=20
+	buf =3D __vmalloc(c->leb_size, GFP_NOFS, PAGE_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
 	sleb =3D ubifs_scan(c, lnum, 0, buf, 0);
 	if (IS_ERR(sleb)) {
 		ret =3D PTR_ERR(sleb);
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 41433bde933e..1c37196fa435 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1917,6 +1917,9 @@ static struct ubi_volume_desc *open_ubi(const char *n=
ame, int mode)
 	int dev, vol;
 	char *endptr;
=20
+	if (!name || !*name)
+		return ERR_PTR(-EINVAL);
+
 	/* First, try to open using the device node path method */
 	ubi =3D ubi_open_volume_path(name, mode);
 	if (!IS_ERR(ubi))
diff --git a/fs/xattr.c b/fs/xattr.c
index 6b57cbd8c962..284aae8c436b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -466,7 +466,7 @@ getxattr(struct dentry *d, const char __user *name, voi=
d __user *value,
 	if (error > 0) {
 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) =3D=3D 0) ||
 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) =3D=3D 0))
-			posix_acl_fix_xattr_to_user(kvalue, size);
+			posix_acl_fix_xattr_to_user(kvalue, error);
 		if (size && copy_to_user(value, kvalue, error))
 			error =3D -EFAULT;
 	} else if (error =3D=3D -ERANGE && size >=3D XATTR_SIZE_MAX) {
diff --git a/fs/xfs/xfs_attr.c b/fs/xfs/xfs_attr.c
index bfe36fc2cdc2..12a548569f04 100644
--- a/fs/xfs/xfs_attr.c
+++ b/fs/xfs/xfs_attr.c
@@ -540,7 +540,14 @@ xfs_attr_shortform_addname(xfs_da_args_t *args)
 		if (args->flags & ATTR_CREATE)
 			return(retval);
 		retval =3D xfs_attr_shortform_remove(args);
-		ASSERT(retval =3D=3D 0);
+		if (retval)
+			return retval;
+		/*
+		 * Since we have removed the old attr, clear ATTR_REPLACE so
+		 * that the leaf format add routine won't trip over the attr
+		 * not being around.
+		 */
+		args->flags &=3D ~ATTR_REPLACE;
 	}
=20
 	if (args->namelen >=3D XFS_ATTR_SF_ENTSIZE_MAX ||
diff --git a/include/crypto/vmac.h b/include/crypto/vmac.h
deleted file mode 100644
index 6b700c7b2fe1..000000000000
--- a/include/crypto/vmac.h
+++ /dev/null
@@ -1,63 +0,0 @@
-/*
- * Modified to interface to the Linux kernel
- * Copyright (c) 2009, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License f=
or
- * more details.
- *
- * You should have received a copy of the GNU General Public License along=
 with
- * this program; if not, write to the Free Software Foundation, Inc., 59 T=
emple
- * Place - Suite 330, Boston, MA 02111-1307 USA.
- */
-
-#ifndef __CRYPTO_VMAC_H
-#define __CRYPTO_VMAC_H
-
-/* -----------------------------------------------------------------------=
---
- * VMAC and VHASH Implementation by Ted Krovetz (tdk@acm.org) and Wei Dai.
- * This implementation is herby placed in the public domain.
- * The authors offers no warranty. Use at your own risk.
- * Please send bug reports to the authors.
- * Last modified: 17 APR 08, 1700 PDT
- * -----------------------------------------------------------------------=
 */
-
-/*
- * User definable settings.
- */
-#define VMAC_TAG_LEN	64
-#define VMAC_KEY_SIZE	128/* Must be 128, 192 or 256			*/
-#define VMAC_KEY_LEN	(VMAC_KEY_SIZE/8)
-#define VMAC_NHBYTES	128/* Must 2^i for any 3 < i < 13 Standard =3D 128*/
-
-/*
- * This implementation uses u32 and u64 as names for unsigned 32-
- * and 64-bit integer types. These are defined in C99 stdint.h. The
- * following may need adaptation if you are not running a C99 or
- * Microsoft C environment.
- */
-struct vmac_ctx {
-	u64 nhkey[(VMAC_NHBYTES/8)+2*(VMAC_TAG_LEN/64-1)];
-	u64 polykey[2*VMAC_TAG_LEN/64];
-	u64 l3key[2*VMAC_TAG_LEN/64];
-	u64 polytmp[2*VMAC_TAG_LEN/64];
-	u64 cached_nonce[2];
-	u64 cached_aes[2];
-	int first_block_processed;
-};
-
-typedef u64 vmac_t;
-
-struct vmac_ctx_t {
-	struct crypto_cipher *child;
-	struct vmac_ctx __vmac_ctx;
-	u8 partial[VMAC_NHBYTES];	/* partial block */
-	int partial_size;		/* size of the partial block */
-};
-
-#endif /* __CRYPTO_VMAC_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 633ef252850b..b992a89abde2 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1542,6 +1542,32 @@ queue_max_integrity_segments(struct request_queue *q)
 	return q->limits.max_integrity_segments;
 }
=20
+/**
+ * bio_integrity_hw_sectors - Convert 512b sectors to hardware ditto
+ * @bi:		blk_integrity profile for device
+ * @sectors:	Number of 512 sectors to convert
+ *
+ * Description: The block layer calculates everything in 512 byte
+ * sectors but integrity metadata is done in terms of the hardware
+ * sector size of the storage device.  Convert the block layer sectors
+ * to physical sectors.
+ */
+static inline unsigned int bio_integrity_hw_sectors(struct blk_integrity *=
bi,
+						    unsigned int sectors)
+{
+	/* At this point there are only 512b or 4096b DIF/EPP devices */
+	if (bi->sector_size =3D=3D 4096)
+		return sectors >>=3D 3;
+
+	return sectors;
+}
+
+static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
+					       unsigned int sectors)
+{
+	return bio_integrity_hw_sectors(bi, sectors) * bi->tuple_size;
+}
+
 #else /* CONFIG_BLK_DEV_INTEGRITY */
=20
 struct bio;
@@ -1609,6 +1635,18 @@ static inline bool blk_integrity_is_initialized(stru=
ct gendisk *g)
 	return 0;
 }
=20
+static inline unsigned int bio_integrity_hw_sectors(struct blk_integrity *=
bi,
+						   unsigned int sectors)
+{
+	return 0;
+}
+
+static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
+					       unsigned int sectors)
+{
+	return 0;
+}
+
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
=20
 struct block_device_operations {
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 575b7166cb08..d2b963db4254 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -146,6 +146,8 @@ extern int cpuidle_play_dead(void);
 extern void cpuidle_use_deepest_state(bool enable);
=20
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device=
 *dev);
+static inline struct cpuidle_device *cpuidle_get_device(void)
+{return __this_cpu_read(cpuidle_devices); }
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
@@ -179,6 +181,7 @@ static inline int cpuidle_play_dead(void) {return -ENOD=
EV; }
 static inline void cpuidle_use_deepest_state(bool enable) {}
 static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 	struct cpuidle_device *dev) {return NULL; }
+static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL=
; }
 #endif
=20
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 1d2c25984890..5d74c847efec 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1867,6 +1867,13 @@ struct netdev_notifier_info {
 	struct net_device *dev;
 };
=20
+struct netdev_notifier_info_ext {
+	struct netdev_notifier_info info; /* must be first */
+	union {
+		u32 mtu;
+	} ext;
+};
+
 struct netdev_notifier_change_info {
 	struct netdev_notifier_info info; /* must be first */
 	unsigned int flags_changed;
diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index d5dd4657c8d6..607de28af726 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -40,7 +40,12 @@ void percpu_counter_destroy(struct percpu_counter *fbc);
 void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
 void __percpu_counter_add(struct percpu_counter *fbc, s64 amount, s32 batc=
h);
 s64 __percpu_counter_sum(struct percpu_counter *fbc);
-int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs);
+int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batc=
h);
+
+static inline int percpu_counter_compare(struct percpu_counter *fbc, s64 r=
hs)
+{
+	return __percpu_counter_compare(fbc, rhs, percpu_counter_batch);
+}
=20
 static inline void percpu_counter_add(struct percpu_counter *fbc, s64 amou=
nt)
 {
@@ -114,6 +119,12 @@ static inline int percpu_counter_compare(struct percpu=
_counter *fbc, s64 rhs)
 		return 0;
 }
=20
+static inline int
+__percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batch)
+{
+	return percpu_counter_compare(fbc, rhs);
+}
+
 static inline void
 percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 {
diff --git a/include/linux/posix-timers.h b/include/linux/posix-timers.h
index 907f3fd191ac..3e28a1a8d823 100644
--- a/include/linux/posix-timers.h
+++ b/include/linux/posix-timers.h
@@ -65,8 +65,8 @@ struct k_itimer {
 	spinlock_t it_lock;
 	clockid_t it_clock;		/* which timer type */
 	timer_t it_id;			/* timer id */
-	int it_overrun;			/* overrun on pending signal  */
-	int it_overrun_last;		/* overrun on last delivered signal */
+	s64 it_overrun;			/* overrun on pending signal  */
+	s64 it_overrun_last;		/* overrun on last delivered signal */
 	int it_requeue_pending;		/* waiting to requeue this timer */
 #define REQUEUE_PENDING 1
 	int it_sigev_notify;		/* notify word of sigevent struct */
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 6288341db62d..88f08fd6a3e1 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -7,13 +7,10 @@
 #include <linux/mutex.h>
 #include <linux/cpumask.h>
 #include <linux/nodemask.h>
+#include <linux/fs.h>
+#include <linux/cred.h>
=20
 struct seq_operations;
-struct file;
-struct path;
-struct inode;
-struct dentry;
-struct user_namespace;
=20
 struct seq_file {
 	char *buf;
@@ -27,9 +24,7 @@ struct seq_file {
 	struct mutex lock;
 	const struct seq_operations *op;
 	int poll_event;
-#ifdef CONFIG_USER_NS
-	struct user_namespace *user_ns;
-#endif
+	const struct file *file;
 	void *private;
 };
=20
@@ -151,7 +146,7 @@ int seq_put_decimal_ll(struct seq_file *m, char delimit=
er,
 static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 {
 #ifdef CONFIG_USER_NS
-	return seq->user_ns;
+	return seq->file->f_cred->user_ns;
 #else
 	extern struct user_namespace init_user_ns;
 	return &init_user_ns;
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 9b31b6d38da2..024cd7c4e5ee 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1801,6 +1801,11 @@ static inline unsigned char *skb_mac_header(const st=
ruct sk_buff *skb)
 	return skb->head + skb->mac_header;
 }
=20
+static inline u32 skb_mac_header_len(const struct sk_buff *skb)
+{
+	return skb->network_header - skb->mac_header;
+}
+
 static inline int skb_mac_header_was_set(const struct sk_buff *skb)
 {
 	return skb->mac_header !=3D (typeof(skb->mac_header))~0U;
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 39e31f407375..700bc8fc76e9 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -204,6 +204,9 @@ int __must_check sysfs_create_files(struct kobject *kob=
j,
 				   const struct attribute **attr);
 int __must_check sysfs_chmod_file(struct kobject *kobj,
 				  const struct attribute *attr, umode_t mode);
+struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
+						  const struct attribute *attr);
+void sysfs_unbreak_active_protection(struct kernfs_node *kn);
 void sysfs_remove_file_ns(struct kobject *kobj, const struct attribute *at=
tr,
 			  const void *ns);
 bool sysfs_remove_file_self(struct kobject *kobj, const struct attribute *=
attr);
@@ -314,6 +317,17 @@ static inline int sysfs_chmod_file(struct kobject *kob=
j,
 	return 0;
 }
=20
+static inline struct kernfs_node *
+sysfs_break_active_protection(struct kobject *kobj,
+			      const struct attribute *attr)
+{
+	return NULL;
+}
+
+static inline void sysfs_unbreak_active_protection(struct kernfs_node *kn)
+{
+}
+
 static inline void sysfs_remove_file_ns(struct kobject *kobj,
 					const struct attribute *attr,
 					const void *ns)
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 2e47496ace0d..7199f201c7a8 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -1065,7 +1065,7 @@ struct usbdrv_wrap {
  *	for interfaces bound to this driver.
  * @soft_unbind: if set to 1, the USB core will not kill URBs and disable
  *	endpoints before calling the driver's disconnect method.
- * @disable_hub_initiated_lpm: if set to 0, the USB core will not allow hu=
bs
+ * @disable_hub_initiated_lpm: if set to 1, the USB core will not allow hu=
bs
  *	to initiate lower power link state transitions when an idle timeout
  *	occurs.  Device-initiated USB 3.0 link PM will still be allowed.
  *
diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
index 905cd10a9478..68d6df7bc85a 100644
--- a/include/net/ip_fib.h
+++ b/include/net/ip_fib.h
@@ -293,6 +293,7 @@ int ip_fib_check_default(__be32 gw, struct net_device *=
dev);
 int fib_sync_down_dev(struct net_device *dev, int force);
 int fib_sync_down_addr(struct net *net, __be32 local);
 int fib_sync_up(struct net_device *dev);
+void fib_sync_mtu(struct net_device *dev, u32 orig_mtu);
 void fib_select_multipath(struct fib_result *res);
=20
 /* Exported by fib_trie.c */
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_t=
ables.h
index 24097027c5d3..2bfcb201e653 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -183,7 +183,7 @@ enum nft_set_class {
  *	@class: lookup performance class
  */
 struct nft_set_estimate {
-	unsigned int		size;
+	u64			size;
 	enum nft_set_class	class;
 };
=20
@@ -215,7 +215,7 @@ struct nft_set_ops {
 						const struct nft_set *set,
 						struct nft_set_iter *iter);
=20
-	unsigned int			(*privsize)(const struct nlattr * const nla[]);
+	u64				(*privsize)(const struct nlattr * const nla[]);
 	bool				(*estimate)(const struct nft_set_desc *desc,
 						    u32 features,
 						    struct nft_set_estimate *est);
diff --git a/include/video/udlfb.h b/include/video/udlfb.h
index f9466fa54ba4..c0213e02934b 100644
--- a/include/video/udlfb.h
+++ b/include/video/udlfb.h
@@ -19,7 +19,6 @@ struct dloarea {
 struct urb_node {
 	struct list_head entry;
 	struct dlfb_data *dev;
-	struct delayed_work release_urb_work;
 	struct urb *urb;
 };
=20
@@ -52,11 +51,13 @@ struct dlfb_data {
 	int base8;
 	u32 pseudo_palette[256];
 	int blank_mode; /*one of FB_BLANK_ */
+	struct fb_ops ops;
 	/* blit-only rendering path metrics, exposed through sysfs */
 	atomic_t bytes_rendered; /* raw pixel-bytes driver asked to render */
 	atomic_t bytes_identical; /* saved effort with backbuffer comparison */
 	atomic_t bytes_sent; /* to usb, after compression including overhead */
 	atomic_t cpu_kcycles_used; /* transpired during pixel processing */
+	struct fb_var_screeninfo current_mode;
 };
=20
 #define NR_USB_REQUEST_I2C_SUB_IO 0x02
@@ -87,7 +88,7 @@ struct dlfb_data {
 #define MIN_RAW_PIX_BYTES	2
 #define MIN_RAW_CMD_BYTES	(RAW_HEADER_BYTES + MIN_RAW_PIX_BYTES)
=20
-#define DL_DEFIO_WRITE_DELAY    5 /* fb_deferred_io.delay in jiffies */
+#define DL_DEFIO_WRITE_DELAY    msecs_to_jiffies(HZ <=3D 300 ? 4 : 10) /* =
optimal value for 720p video */
 #define DL_DEFIO_WRITE_DISABLE  (HZ*60) /* "disable" with long delay */
=20
 /* remove these once align.h patch is taken into kernel */
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4660027476d2..70d76fa59a11 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -489,20 +489,20 @@ static int audit_filter_rules(struct task_struct *tsk,
 			result =3D audit_gid_comparator(cred->gid, f->op, f->gid);
 			if (f->op =3D=3D Audit_equal) {
 				if (!result)
-					result =3D in_group_p(f->gid);
+					result =3D groups_search(cred->group_info, f->gid);
 			} else if (f->op =3D=3D Audit_not_equal) {
 				if (result)
-					result =3D !in_group_p(f->gid);
+					result =3D !groups_search(cred->group_info, f->gid);
 			}
 			break;
 		case AUDIT_EGID:
 			result =3D audit_gid_comparator(cred->egid, f->op, f->gid);
 			if (f->op =3D=3D Audit_equal) {
 				if (!result)
-					result =3D in_egroup_p(f->gid);
+					result =3D groups_search(cred->group_info, f->gid);
 			} else if (f->op =3D=3D Audit_not_equal) {
 				if (result)
-					result =3D !in_egroup_p(f->gid);
+					result =3D !groups_search(cred->group_info, f->gid);
 			}
 			break;
 		case AUDIT_SGID:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e246925e24e0..17821c290b3b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6276,6 +6276,8 @@ void perf_tp_event(u64 addr, u64 count, void *record,=
 int entry_size,
 			goto unlock;
=20
 		list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+			if (event->cpu !=3D smp_processor_id())
+				continue;
 			if (event->attr.type !=3D PERF_TYPE_TRACEPOINT)
 				continue;
 			if (event->attr.config !=3D entry->type)
@@ -6705,20 +6707,17 @@ static void free_pmu_context(struct pmu *pmu)
 {
 	struct pmu *i;
=20
-	mutex_lock(&pmus_lock);
 	/*
 	 * Like a real lame refcount.
 	 */
 	list_for_each_entry(i, &pmus, entry) {
 		if (i->pmu_cpu_context =3D=3D pmu->pmu_cpu_context) {
 			update_pmu_context(i, pmu);
-			goto out;
+			return;
 		}
 	}
=20
 	free_percpu(pmu->pmu_cpu_context);
-out:
-	mutex_unlock(&pmus_lock);
 }
 static struct idr pmu_idr;
=20
@@ -6932,7 +6931,6 @@ void perf_pmu_unregister(struct pmu *pmu)
 {
 	mutex_lock(&pmus_lock);
 	list_del_rcu(&pmu->entry);
-	mutex_unlock(&pmus_lock);
=20
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
@@ -6944,9 +6942,12 @@ void perf_pmu_unregister(struct pmu *pmu)
 	free_percpu(pmu->pmu_disable_count);
 	if (pmu->type >=3D PERF_TYPE_MAX)
 		idr_remove(&pmu_idr, pmu->type);
-	device_del(pmu->dev);
-	put_device(pmu->dev);
+	if (pmu_bus_running) {
+		device_del(pmu->dev);
+		put_device(pmu->dev);
+	}
 	free_pmu_context(pmu);
+	mutex_unlock(&pmus_lock);
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
=20
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f6397bb4d5f6..f44ab6536beb 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2414,7 +2414,7 @@ static int __init debugfs_kprobe_init(void)
 	if (!dir)
 		return -ENOMEM;
=20
-	file =3D debugfs_create_file("list", 0444, dir, NULL,
+	file =3D debugfs_create_file("list", 0400, dir, NULL,
 				&debugfs_kprobes_operations);
 	if (!file)
 		goto error;
@@ -2424,7 +2424,7 @@ static int __init debugfs_kprobe_init(void)
 	if (!file)
 		goto error;
=20
-	file =3D debugfs_create_file("blacklist", 0444, dir, NULL,
+	file =3D debugfs_create_file("blacklist", 0400, dir, NULL,
 				&debugfs_kprobe_blacklist_ops);
 	if (!file)
 		goto error;
diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
index 4bd1dd7db1a1..34995963516f 100644
--- a/kernel/posix-cpu-timers.c
+++ b/kernel/posix-cpu-timers.c
@@ -103,7 +103,7 @@ static void bump_cpu_timer(struct k_itimer *timer,
 			continue;
=20
 		timer->it.cpu.expires +=3D incr;
-		timer->it_overrun +=3D 1 << i;
+		timer->it_overrun +=3D 1LL << i;
 		delta -=3D incr;
 	}
 }
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 5a4cefc43f40..8bfdf0c43176 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -347,6 +347,17 @@ static __init int init_posix_timers(void)
=20
 __initcall(init_posix_timers);
=20
+/*
+ * The siginfo si_overrun field and the return value of timer_getoverrun(2)
+ * are of type int. Clamp the overrun value to INT_MAX
+ */
+static inline int timer_overrun_to_int(struct k_itimer *timr, int baseval)
+{
+	s64 sum =3D timr->it_overrun_last + (s64)baseval;
+
+	return sum > (s64)INT_MAX ? INT_MAX : (int)sum;
+}
+
 static void schedule_next_timer(struct k_itimer *timr)
 {
 	struct hrtimer *timer =3D &timr->it.real.timer;
@@ -354,12 +365,11 @@ static void schedule_next_timer(struct k_itimer *timr)
 	if (timr->it.real.interval.tv64 =3D=3D 0)
 		return;
=20
-	timr->it_overrun +=3D (unsigned int) hrtimer_forward(timer,
-						timer->base->get_time(),
-						timr->it.real.interval);
+	timr->it_overrun +=3D hrtimer_forward(timer, timer->base->get_time(),
+					    timr->it.real.interval);
=20
 	timr->it_overrun_last =3D timr->it_overrun;
-	timr->it_overrun =3D -1;
+	timr->it_overrun =3D -1LL;
 	++timr->it_requeue_pending;
 	hrtimer_restart(timer);
 }
@@ -388,7 +398,7 @@ void do_schedule_next_timer(struct siginfo *info)
 		else
 			schedule_next_timer(timr);
=20
-		info->si_overrun +=3D timr->it_overrun_last;
+		info->si_overrun =3D timer_overrun_to_int(timr, info->si_overrun);
 	}
=20
 	if (timr)
@@ -483,9 +493,8 @@ static enum hrtimer_restart posix_timer_fn(struct hrtim=
er *timer)
 					now =3D ktime_add(now, kj);
 			}
 #endif
-			timr->it_overrun +=3D (unsigned int)
-				hrtimer_forward(timer, now,
-						timr->it.real.interval);
+			timr->it_overrun +=3D hrtimer_forward(timer, now,
+							    timr->it.real.interval);
 			ret =3D HRTIMER_RESTART;
 			++timr->it_requeue_pending;
 		}
@@ -633,7 +642,7 @@ SYSCALL_DEFINE3(timer_create, const clockid_t, which_cl=
ock,
 	it_id_set =3D IT_ID_SET;
 	new_timer->it_id =3D (timer_t) new_timer_id;
 	new_timer->it_clock =3D which_clock;
-	new_timer->it_overrun =3D -1;
+	new_timer->it_overrun =3D -1LL;
=20
 	if (timer_event_spec) {
 		if (copy_from_user(&event, timer_event_spec, sizeof (event))) {
@@ -763,7 +772,7 @@ common_timer_get(struct k_itimer *timr, struct itimersp=
ec *cur_setting)
 	 * expiry is > now.
 	 */
 	if (iv.tv64 && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
-		timr->it_overrun +=3D (unsigned int) hrtimer_forward(timer, now, iv);
+		timr->it_overrun +=3D hrtimer_forward(timer, now, iv);
=20
 	remaining =3D ktime_sub(hrtimer_get_expires(timer), now);
 	/* Return 0 only, when the timer is expired and not pending */
@@ -825,7 +834,7 @@ SYSCALL_DEFINE1(timer_getoverrun, timer_t, timer_id)
 	if (!timr)
 		return -EINVAL;
=20
-	overrun =3D timr->it_overrun_last;
+	overrun =3D timer_overrun_to_int(timr, 0);
 	unlock_timer(timr, flags);
=20
 	return overrun;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index cf009fb0bc25..0282737944ba 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -76,7 +76,7 @@ void __weak arch_cpu_idle(void)
  */
 static void cpuidle_idle_call(void)
 {
-	struct cpuidle_device *dev =3D __this_cpu_read(cpuidle_devices);
+	struct cpuidle_device *dev =3D cpuidle_get_device();
 	struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);
 	int next_state, entered_state;
 	bool broadcast;
diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 28627a9b667b..8c65c236f26a 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -775,7 +775,8 @@ static int alarm_timer_nsleep(const clockid_t which_clo=
ck, int flags,
 	/* Convert (if necessary) to absolute time */
 	if (flags !=3D TIMER_ABSTIME) {
 		ktime_t now =3D alarm_bases[type].gettime();
-		exp =3D ktime_add(now, exp);
+
+		exp =3D ktime_add_safe(now, exp);
 	}
=20
 	if (alarmtimer_do_nsleep(&alarm, exp))
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 5e93eca7ca16..9a9d0288576b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1778,6 +1778,10 @@ static ssize_t sysfs_blk_trace_attr_store(struct dev=
ice *dev,
 	mutex_lock(&q->blk_trace_mutex);
=20
 	if (attr =3D=3D &dev_attr_enable) {
+		if (!!value =3D=3D !!q->blk_trace) {
+			ret =3D 0;
+			goto out_unlock_bdev;
+		}
 		if (value)
 			ret =3D blk_trace_setup_queue(q, bdev);
 		else
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ee01bb53e420..107e8ce1a87e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1541,6 +1541,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffe=
r, unsigned long nr_pages)
 	tmp_iter_page =3D first_page;
=20
 	do {
+		cond_resched();
+
 		to_remove_page =3D tmp_iter_page;
 		rb_inc_page(cpu_buffer, &tmp_iter_page);
=20
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dbdb406ed6ea..5a4d78fe4bb9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6180,7 +6180,9 @@ rb_simple_write(struct file *filp, const char __user =
*ubuf,
=20
 	if (buffer) {
 		mutex_lock(&trace_types_lock);
-		if (val) {
+		if (!!val =3D=3D tracer_tracing_is_on(tr)) {
+			val =3D 0; /* do nothing */
+		} else if (val) {
 			tracer_tracing_on(tr);
 			if (tr->current_trace->start)
 				tr->current_trace->start(tr);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 68fdc53487a8..d32caa3e1d28 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -949,7 +949,7 @@ probe_event_disable(struct trace_uprobe *tu, struct ftr=
ace_event_file *file)
=20
 		list_del_rcu(&link->list);
 		/* synchronize with u{,ret}probe_trace_func */
-		synchronize_sched();
+		synchronize_rcu();
 		kfree(link);
=20
 		if (!list_empty(&tu->tp.files))
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 7dd33577b905..b4de99e9e7dc 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -193,13 +193,13 @@ static int percpu_counter_hotcpu_callback(struct noti=
fier_block *nb,
  * Compare counter against given value.
  * Return 1 if greater, 0 if equal and -1 if less
  */
-int percpu_counter_compare(struct percpu_counter *fbc, s64 rhs)
+int __percpu_counter_compare(struct percpu_counter *fbc, s64 rhs, s32 batc=
h)
 {
 	s64	count;
=20
 	count =3D percpu_counter_read(fbc);
 	/* Check to see if rough count will be sufficient for comparison */
-	if (abs(count - rhs) > (percpu_counter_batch*num_online_cpus())) {
+	if (abs(count - rhs) > (batch * num_online_cpus())) {
 		if (count > rhs)
 			return 1;
 		else
@@ -214,7 +214,7 @@ int percpu_counter_compare(struct percpu_counter *fbc, =
s64 rhs)
 	else
 		return 0;
 }
-EXPORT_SYMBOL(percpu_counter_compare);
+EXPORT_SYMBOL(__percpu_counter_compare);
=20
 static int __init percpu_counter_startup(void)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 47c8bb45e781..498110500479 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1452,7 +1452,7 @@ int move_huge_pmd(struct vm_area_struct *vma, struct =
vm_area_struct *new_vma,
 	spinlock_t *old_ptl, *new_ptl;
 	int ret =3D 0;
 	pmd_t pmd;
-
+	bool force_flush =3D false;
 	struct mm_struct *mm =3D vma->vm_mm;
=20
 	if ((old_addr & ~HPAGE_PMD_MASK) ||
@@ -1480,6 +1480,8 @@ int move_huge_pmd(struct vm_area_struct *vma, struct =
vm_area_struct *new_vma,
 		if (new_ptl !=3D old_ptl)
 			spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 		pmd =3D pmdp_get_and_clear(mm, old_addr, old_pmd);
+		if (pmd_present(pmd))
+			force_flush =3D true;
 		VM_BUG_ON(!pmd_none(*new_pmd));
=20
 		if (pmd_move_must_withdraw(new_ptl, old_ptl)) {
@@ -1488,6 +1490,8 @@ int move_huge_pmd(struct vm_area_struct *vma, struct =
vm_area_struct *new_vma,
 			pgtable_trans_huge_deposit(mm, new_pmd, pgtable);
 		}
 		set_pmd_at(mm, new_addr, new_pmd, pmd_mksoft_dirty(pmd));
+		if (force_flush)
+			flush_tlb_range(vma, old_addr, old_addr + PMD_SIZE);
 		if (new_ptl !=3D old_ptl)
 			spin_unlock(new_ptl);
 		spin_unlock(old_ptl);
diff --git a/mm/madvise.c b/mm/madvise.c
index 040617386648..a6985e15bd6a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -75,7 +75,7 @@ static long madvise_behavior(struct vm_area_struct *vma,
 		new_flags |=3D VM_DONTDUMP;
 		break;
 	case MADV_DODUMP:
-		if (new_flags & VM_SPECIAL) {
+		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) {
 			error =3D -EINVAL;
 			goto out;
 		}
diff --git a/mm/memory.c b/mm/memory.c
index 06e065489e60..62c2c8a148b0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -236,15 +236,15 @@ static void tlb_flush_mmu_tlbonly(struct mmu_gather *=
tlb)
 {
 	tlb->need_flush =3D 0;
 	tlb_flush(tlb);
-#ifdef CONFIG_HAVE_RCU_TABLE_FREE
-	tlb_table_flush(tlb);
-#endif
 }
=20
 static void tlb_flush_mmu_free(struct mmu_gather *tlb)
 {
 	struct mmu_gather_batch *batch;
=20
+#ifdef CONFIG_HAVE_RCU_TABLE_FREE
+	tlb_table_flush(tlb);
+#endif
 	for (batch =3D &tlb->local; batch; batch =3D batch->next) {
 		free_pages_and_swap_cache(batch->pages, batch->nr);
 		batch->nr =3D 0;
@@ -359,15 +359,6 @@ void tlb_remove_table(struct mmu_gather *tlb, void *ta=
ble)
=20
 	tlb->need_flush =3D 1;
=20
-	/*
-	 * When there's less then two users of this mm there cannot be a
-	 * concurrent page-table walk.
-	 */
-	if (atomic_read(&tlb->mm->mm_users) < 2) {
-		__tlb_remove_table(table);
-		return;
-	}
-
 	if (*batch =3D=3D NULL) {
 		*batch =3D (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_=
NOWARN);
 		if (*batch =3D=3D NULL) {
diff --git a/mm/mremap.c b/mm/mremap.c
index 6d49f62a4863..c3775c77df7a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -95,6 +95,8 @@ static void move_ptes(struct vm_area_struct *vma, pmd_t *=
old_pmd,
 	struct mm_struct *mm =3D vma->vm_mm;
 	pte_t *old_pte, *new_pte, pte;
 	spinlock_t *old_ptl, *new_ptl;
+	bool force_flush =3D false;
+	unsigned long len =3D old_end - old_addr;
=20
 	/*
 	 * When need_rmap_locks is true, we take the i_mmap_mutex and anon_vma
@@ -141,12 +143,26 @@ static void move_ptes(struct vm_area_struct *vma, pmd=
_t *old_pmd,
 		if (pte_none(*old_pte))
 			continue;
 		pte =3D ptep_get_and_clear(mm, old_addr, old_pte);
+		/*
+		 * If we are remapping a valid PTE, make sure
+		 * to flush TLB before we drop the PTL for the PTE.
+		 *
+		 * NOTE! Both old and new PTL matter: the old one
+		 * for racing with page_mkclean(), the new one to
+		 * make sure the physical page stays valid until
+		 * the TLB entry for the old mapping has been
+		 * flushed.
+		 */
+		if (pte_present(pte))
+			force_flush =3D true;
 		pte =3D move_pte(pte, new_vma->vm_page_prot, old_addr, new_addr);
 		pte =3D move_soft_dirty_pte(pte);
 		set_pte_at(mm, new_addr, new_pte, pte);
 	}
=20
 	arch_leave_lazy_mmu_mode();
+	if (force_flush)
+		flush_tlb_range(vma, old_end - len, old_end);
 	if (new_ptl !=3D old_ptl)
 		spin_unlock(new_ptl);
 	pte_unmap(new_pte - 1);
@@ -166,7 +182,6 @@ unsigned long move_page_tables(struct vm_area_struct *v=
ma,
 {
 	unsigned long extent, next, old_end;
 	pmd_t *old_pmd, *new_pmd;
-	bool need_flush =3D false;
 	unsigned long mmun_start;	/* For mmu_notifiers */
 	unsigned long mmun_end;		/* For mmu_notifiers */
=20
@@ -204,7 +219,6 @@ unsigned long move_page_tables(struct vm_area_struct *v=
ma,
 					anon_vma_unlock_write(vma->anon_vma);
 			}
 			if (err > 0) {
-				need_flush =3D true;
 				continue;
 			} else if (!err) {
 				split_huge_page_pmd(vma, old_addr, old_pmd);
@@ -221,10 +235,7 @@ unsigned long move_page_tables(struct vm_area_struct *=
vma,
 			extent =3D LATENCY_LIMIT;
 		move_ptes(vma, old_pmd, old_addr, old_addr + extent,
 			  new_vma, new_pmd, new_addr, need_rmap_locks);
-		need_flush =3D true;
 	}
-	if (likely(need_flush))
-		flush_tlb_range(vma, old_end-len, old_addr);
=20
 	mmu_notifier_invalidate_range_end(vma->vm_mm, mmun_start, mmun_end);
=20
diff --git a/mm/shmem.c b/mm/shmem.c
index 507231b0dfe3..ea44e5ecad75 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1422,6 +1422,8 @@ static struct inode *shmem_get_inode(struct super_blo=
ck *sb, const struct inode
 			mpol_shared_policy_init(&info->policy, NULL);
 			break;
 		}
+
+		lockdep_annotate_inode_mutex_key(inode);
 	} else
 		shmem_free_inode(sb);
 	return inode;
diff --git a/mm/truncate.c b/mm/truncate.c
index 699494e6aba5..f2ca73d989bc 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -461,9 +461,13 @@ void truncate_inode_pages_final(struct address_space *=
mapping)
 		 */
 		spin_lock_irq(&mapping->tree_lock);
 		spin_unlock_irq(&mapping->tree_lock);
-
-		truncate_inode_pages(mapping, 0);
 	}
+
+	/*
+	 * Cleancache needs notification even if there are no pages or shadow
+	 * entries.
+	 */
+	truncate_inode_pages(mapping, 0);
 }
 EXPORT_SYMBOL(truncate_inode_pages_final);
=20
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6c70f6647907..ae3c911843fa 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -864,6 +864,9 @@ const char * const vmstat_text[] =3D {
 #ifdef CONFIG_SMP
 	"nr_tlb_remote_flush",
 	"nr_tlb_remote_flush_received",
+#else
+	"", /* nr_tlb_remote_flush */
+	"", /* nr_tlb_remote_flush_received */
 #endif /* CONFIG_SMP */
 	"nr_tlb_local_flush_all",
 	"nr_tlb_local_flush_one",
diff --git a/net/9p/client.c b/net/9p/client.c
index 90295cc94b82..d150562c4172 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -938,7 +938,7 @@ static int p9_client_version(struct p9_client *c)
 {
 	int err =3D 0;
 	struct p9_req_t *req;
-	char *version;
+	char *version =3D NULL;
 	int msize;
=20
 	p9_debug(P9_DEBUG_9P, ">>> TVERSION msize %d protocol %d\n",
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 80d08f6664cb..9d935dc71b83 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -185,6 +185,8 @@ static void p9_mux_poll_stop(struct p9_conn *m)
 	spin_lock_irqsave(&p9_poll_lock, flags);
 	list_del_init(&m->poll_pending_link);
 	spin_unlock_irqrestore(&p9_poll_lock, flags);
+
+	flush_work(&p9_poll_work);
 }
=20
 /**
@@ -932,7 +934,7 @@ p9_fd_create_tcp(struct p9_client *client, const char *=
addr, char *args)
 	if (err < 0)
 		return err;
=20
-	if (valid_ipaddr4(addr) < 0)
+	if (addr =3D=3D NULL || valid_ipaddr4(addr) < 0)
 		return -EINVAL;
=20
 	csocket =3D NULL;
@@ -980,6 +982,9 @@ p9_fd_create_unix(struct p9_client *client, const char =
*addr, char *args)
=20
 	csocket =3D NULL;
=20
+	if (addr =3D=3D NULL)
+		return -EINVAL;
+
 	if (strlen(addr) >=3D UNIX_PATH_MAX) {
 		pr_err("%s (%d): address too long: %s\n",
 		       __func__, task_pid_nr(current), addr);
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 14ad43b5cf89..d00cb890398b 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -623,6 +623,9 @@ rdma_create_trans(struct p9_client *client, const char =
*addr, char *args)
 	struct ib_qp_init_attr qp_attr;
 	struct ib_device_attr devattr;
=20
+	if (addr =3D=3D NULL)
+		return -EINVAL;
+
 	/* Parse the transport specific mount options */
 	err =3D parse_opts(args, &opts);
 	if (err < 0)
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index bbf55b440da5..421245314be5 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -193,7 +193,7 @@ static int pack_sg_list(struct scatterlist *sg, int sta=
rt,
 		s =3D rest_of_page(data);
 		if (s > count)
 			s =3D count;
-		BUG_ON(index > limit);
+		BUG_ON(index >=3D limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_buf(&sg[index++], data, s);
@@ -239,6 +239,7 @@ pack_sg_list_p(struct scatterlist *sg, int start, int l=
imit,
 		s =3D rest_of_page(data);
 		if (s > count)
 			s =3D count;
+		BUG_ON(index >=3D limit);
 		/* Make sure we don't terminate early. */
 		sg_unmark_end(&sg[index]);
 		sg_set_page(&sg[index++], pdata[i++], s, data_off);
@@ -378,6 +379,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p=
9_req_t *req,
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
=20
 	if (uodata) {
+		__le32 sz;
 		out_nr_pages =3D p9_nr_pages(uodata, outlen);
 		out_pages =3D kmalloc(sizeof(struct page *) * out_nr_pages,
 				    GFP_NOFS);
@@ -393,6 +395,12 @@ p9_virtio_zc_request(struct p9_client *client, struct =
p9_req_t *req,
 			out_pages =3D NULL;
 			goto err_out;
 		}
+		/* The size field of the message must include the length of the
+		 * header and the length of the data.  We didn't actually know
+		 * the length of the data until this point so add it in now.
+		 */
+		sz =3D cpu_to_le32(req->tc->size + outlen);
+		memcpy(&req->tc->sdata[0], &sz, sizeof(sz));
 	}
 	if (uidata) {
 		in_nr_pages =3D p9_nr_pages(uidata, inlen);
@@ -615,6 +623,9 @@ p9_virtio_create(struct p9_client *client, const char *=
devname, char *args)
 	int ret =3D -ENOENT;
 	int found =3D 0;
=20
+	if (devname =3D=3D NULL)
+		return -EINVAL;
+
 	mutex_lock(&virtio_9p_lock);
 	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
 		if (!strncmp(devname, chan->tag, chan->tag_len) &&
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_clien=
t.c
index b22ba87b6b22..5f8e972e465e 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -27,6 +27,7 @@
 #include <linux/ipv6.h>
 #include <linux/udp.h>
 #include <linux/if_vlan.h>
+#include <linux/lockdep.h>
=20
 /* These are the offsets of the "hw type" and "hw address length" in the d=
hcp
  * packet starting at the beginning of the dhcp header
@@ -398,6 +399,9 @@ void batadv_gw_check_election(struct batadv_priv *bat_p=
riv,
  * @bat_priv: the bat priv with all the soft interface information
  * @orig_node: originator announcing gateway capabilities
  * @gateway: announced bandwidth information
+ *
+ * Has to be called with the appropriate locks being acquired
+ * (gw.list_lock).
  */
 static void batadv_gw_node_add(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
@@ -405,6 +409,8 @@ static void batadv_gw_node_add(struct batadv_priv *bat_=
priv,
 {
 	struct batadv_gw_node *gw_node;
=20
+	lockdep_assert_held(&bat_priv->gw.list_lock);
+
 	if (gateway->bandwidth_down =3D=3D 0)
 		return;
=20
@@ -421,9 +427,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_=
priv,
 	gw_node->orig_node =3D orig_node;
 	atomic_set(&gw_node->refcount, 1);
=20
-	spin_lock_bh(&bat_priv->gw.list_lock);
 	hlist_add_head_rcu(&gw_node->list, &bat_priv->gw.list);
-	spin_unlock_bh(&bat_priv->gw.list_lock);
=20
 	batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 		   "Found new gateway %pM -> gw bandwidth: %u.%u/%u.%u MBit\n",
@@ -479,11 +483,14 @@ void batadv_gw_node_update(struct batadv_priv *bat_pr=
iv,
 {
 	struct batadv_gw_node *gw_node, *curr_gw =3D NULL;
=20
+	spin_lock_bh(&bat_priv->gw.list_lock);
 	gw_node =3D batadv_gw_node_get(bat_priv, orig_node);
 	if (!gw_node) {
 		batadv_gw_node_add(bat_priv, orig_node, gateway);
+		spin_unlock_bh(&bat_priv->gw.list_lock);
 		goto out;
 	}
+	spin_unlock_bh(&bat_priv->gw.list_lock);
=20
 	if ((gw_node->bandwidth_down =3D=3D ntohl(gateway->bandwidth_down)) &&
 	    (gw_node->bandwidth_up =3D=3D ntohl(gateway->bandwidth_up)))
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index d1183e882167..1fea2b600b6f 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -1058,15 +1058,20 @@ void batadv_tvlv_handler_register(struct batadv_pri=
v *bat_priv,
 {
 	struct batadv_tvlv_handler *tvlv_handler;
=20
+	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
+
 	tvlv_handler =3D batadv_tvlv_handler_get(bat_priv, type, version);
 	if (tvlv_handler) {
+		spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
 		batadv_tvlv_handler_free_ref(tvlv_handler);
 		return;
 	}
=20
 	tvlv_handler =3D kzalloc(sizeof(*tvlv_handler), GFP_ATOMIC);
-	if (!tvlv_handler)
+	if (!tvlv_handler) {
+		spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
 		return;
+	}
=20
 	tvlv_handler->ogm_handler =3D optr;
 	tvlv_handler->unicast_handler =3D uptr;
@@ -1076,7 +1081,6 @@ void batadv_tvlv_handler_register(struct batadv_priv =
*bat_priv,
 	atomic_set(&tvlv_handler->refcount, 1);
 	INIT_HLIST_NODE(&tvlv_handler->list);
=20
-	spin_lock_bh(&bat_priv->tvlv.handler_list_lock);
 	hlist_add_head_rcu(&tvlv_handler->list, &bat_priv->tvlv.handler_list);
 	spin_unlock_bh(&bat_priv->tvlv.handler_list_lock);
 }
diff --git a/net/batman-adv/network-coding.c b/net/batman-adv/network-codin=
g.c
index 4e718162a26b..8b9db81a88c7 100644
--- a/net/batman-adv/network-coding.c
+++ b/net/batman-adv/network-coding.c
@@ -802,19 +802,29 @@ static struct batadv_nc_node
 	spinlock_t *lock; /* Used to lock list selected by "int in_coding" */
 	struct list_head *list;
=20
+	/* Select ingoing or outgoing coding node */
+	if (in_coding) {
+		lock =3D &orig_neigh_node->in_coding_list_lock;
+		list =3D &orig_neigh_node->in_coding_list;
+	} else {
+		lock =3D &orig_neigh_node->out_coding_list_lock;
+		list =3D &orig_neigh_node->out_coding_list;
+	}
+
+	spin_lock_bh(lock);
+
 	/* Check if nc_node is already added */
 	nc_node =3D batadv_nc_find_nc_node(orig_node, orig_neigh_node, in_coding);
=20
 	/* Node found */
 	if (nc_node)
-		return nc_node;
+		goto unlock;
=20
 	nc_node =3D kzalloc(sizeof(*nc_node), GFP_ATOMIC);
 	if (!nc_node)
-		return NULL;
+		goto unlock;
=20
-	if (!atomic_inc_not_zero(&orig_neigh_node->refcount))
-		goto free;
+	WARN_ON_ONCE(atomic_inc_return(&orig_neigh_node->refcount) < 2);
=20
 	/* Initialize nc_node */
 	INIT_LIST_HEAD(&nc_node->list);
@@ -822,28 +832,16 @@ static struct batadv_nc_node
 	nc_node->orig_node =3D orig_neigh_node;
 	atomic_set(&nc_node->refcount, 2);
=20
-	/* Select ingoing or outgoing coding node */
-	if (in_coding) {
-		lock =3D &orig_neigh_node->in_coding_list_lock;
-		list =3D &orig_neigh_node->in_coding_list;
-	} else {
-		lock =3D &orig_neigh_node->out_coding_list_lock;
-		list =3D &orig_neigh_node->out_coding_list;
-	}
-
 	batadv_dbg(BATADV_DBG_NC, bat_priv, "Adding nc_node %pM -> %pM\n",
 		   nc_node->addr, nc_node->orig_node->orig);
=20
 	/* Add nc_node to orig_node */
-	spin_lock_bh(lock);
 	list_add_tail_rcu(&nc_node->list, list);
+
+unlock:
 	spin_unlock_bh(lock);
=20
 	return nc_node;
-
-free:
-	kfree(nc_node);
-	return NULL;
 }
=20
 /**
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interfac=
e.c
index c8642161b1fc..e4a22971aabf 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -506,15 +506,20 @@ int batadv_softif_create_vlan(struct batadv_priv *bat=
_priv, unsigned short vid)
 	struct batadv_softif_vlan *vlan;
 	int err;
=20
+	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
+
 	vlan =3D batadv_softif_vlan_get(bat_priv, vid);
 	if (vlan) {
 		batadv_softif_vlan_free_ref(vlan);
+		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 		return -EEXIST;
 	}
=20
 	vlan =3D kzalloc(sizeof(*vlan), GFP_ATOMIC);
-	if (!vlan)
+	if (!vlan) {
+		spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
 		return -ENOMEM;
+	}
=20
 	vlan->bat_priv =3D bat_priv;
 	vlan->vid =3D vid;
@@ -522,16 +527,23 @@ int batadv_softif_create_vlan(struct batadv_priv *bat=
_priv, unsigned short vid)
=20
 	atomic_set(&vlan->ap_isolation, 0);
=20
+	atomic_inc(&vlan->refcount);
+	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
+	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
+
+	/* batadv_sysfs_add_vlan cannot be in the spinlock section due to the
+	 * sleeping behavior of the sysfs functions and the fs_reclaim lock
+	 */
 	err =3D batadv_sysfs_add_vlan(bat_priv->soft_iface, vlan);
 	if (err) {
-		kfree(vlan);
+		/* ref for the function */
+		batadv_softif_vlan_free_ref(vlan);
+
+		/* ref for the list */
+		batadv_softif_vlan_free_ref(vlan);
 		return err;
 	}
=20
-	spin_lock_bh(&bat_priv->softif_vlan_list_lock);
-	hlist_add_head_rcu(&vlan->list, &bat_priv->softif_vlan_list);
-	spin_unlock_bh(&bat_priv->softif_vlan_list_lock);
-
 	/* add a new TT local entry. This one will be marked with the NOPURGE
 	 * flag
 	 */
@@ -539,6 +551,9 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_p=
riv, unsigned short vid)
 			    bat_priv->soft_iface->dev_addr, vid,
 			    BATADV_NULL_IFINDEX, BATADV_NO_MARK);
=20
+	/* don't return reference to new softif_vlan */
+	batadv_softif_vlan_free_ref(vlan);
+
 	return 0;
 }
=20
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translatio=
n-table.c
index ce0678140a32..c9ac7d948a21 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1287,6 +1287,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_glob=
al_entry *tt_global,
 {
 	struct batadv_tt_orig_list_entry *orig_entry;
=20
+	spin_lock_bh(&tt_global->list_lock);
+
 	orig_entry =3D batadv_tt_global_orig_entry_find(tt_global, orig_node);
 	if (orig_entry) {
 		/* refresh the ttvn: the current value could be a bogus one that
@@ -1309,10 +1311,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_glo=
bal_entry *tt_global,
 	orig_entry->flags =3D flags;
 	atomic_set(&orig_entry->refcount, 2);
=20
-	spin_lock_bh(&tt_global->list_lock);
 	hlist_add_head_rcu(&orig_entry->list,
 			   &tt_global->orig_list);
-	spin_unlock_bh(&tt_global->list_lock);
 	atomic_inc(&tt_global->orig_list_count);
=20
 sync_flags:
@@ -1320,6 +1320,8 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_glob=
al_entry *tt_global,
 out:
 	if (orig_entry)
 		batadv_tt_orig_list_entry_free_ref(orig_entry);
+
+	spin_unlock_bh(&tt_global->list_lock);
 }
=20
 /**
diff --git a/net/core/dev.c b/net/core/dev.c
index 24afa7203884..0a32a1dcb101 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1598,6 +1598,28 @@ int call_netdevice_notifiers(unsigned long val, stru=
ct net_device *dev)
 }
 EXPORT_SYMBOL(call_netdevice_notifiers);
=20
+/**
+ *	call_netdevice_notifiers_mtu - call all network notifier blocks
+ *	@val: value passed unmodified to notifier function
+ *	@dev: net_device pointer passed unmodified to notifier function
+ *	@arg: additional u32 argument passed to the notifier function
+ *
+ *	Call all network notifier blocks.  Parameters and return value
+ *	are as for raw_notifier_call_chain().
+ */
+static int call_netdevice_notifiers_mtu(unsigned long val,
+					struct net_device *dev, u32 arg)
+{
+	struct netdev_notifier_info_ext info =3D {
+		.info.dev =3D dev,
+		.ext.mtu =3D arg,
+	};
+
+	BUILD_BUG_ON(offsetof(struct netdev_notifier_info_ext, info) !=3D 0);
+
+	return call_netdevice_notifiers_info(val, dev, &info.info);
+}
+
 static struct static_key netstamp_needed __read_mostly;
 #ifdef HAVE_JUMP_LABEL
 static atomic_t netstamp_needed_deferred;
@@ -5688,14 +5710,16 @@ int dev_set_mtu(struct net_device *dev, int new_mtu)
 	err =3D __dev_set_mtu(dev, new_mtu);
=20
 	if (!err) {
-		err =3D call_netdevice_notifiers(NETDEV_CHANGEMTU, dev);
+		err =3D call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
+						   orig_mtu);
 		err =3D notifier_to_errno(err);
 		if (err) {
 			/* setting mtu back and notifying everyone again,
 			 * so that they have a chance to revert changes.
 			 */
 			__dev_set_mtu(dev, orig_mtu);
-			call_netdevice_notifiers(NETDEV_CHANGEMTU, dev);
+			call_netdevice_notifiers_mtu(NETDEV_CHANGEMTU, dev,
+						     new_mtu);
 		}
 	}
 	return err;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 2e6265e644d7..2373ca1d1493 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1831,6 +1831,12 @@ struct net_device *rtnl_create_link(struct net *net,
 	else if (ops->get_num_rx_queues)
 		num_rx_queues =3D ops->get_num_rx_queues();
=20
+	if (num_tx_queues < 1 || num_tx_queues > 4096)
+		return ERR_PTR(-EINVAL);
+
+	if (num_rx_queues < 1 || num_rx_queues > 4096)
+		return ERR_PTR(-EINVAL);
+
 	err =3D -ENOMEM;
 	dev =3D alloc_netdev_mqs(ops->priv_size, ifname, ops->setup,
 			       num_tx_queues, num_rx_queues);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 11cda3cf681c..734d7ca9f74d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3593,14 +3593,16 @@ EXPORT_SYMBOL_GPL(skb_complete_wifi_ack);
  */
 bool skb_partial_csum_set(struct sk_buff *skb, u16 start, u16 off)
 {
-	if (unlikely(start > skb_headlen(skb)) ||
-	    unlikely((int)start + off > skb_headlen(skb) - 2)) {
-		net_warn_ratelimited("bad partial csum: csum=3D%u/%u len=3D%u\n",
-				     start, off, skb_headlen(skb));
+	u32 csum_end =3D (u32)start + (u32)off + sizeof(__sum16);
+	u32 csum_start =3D skb_headroom(skb) + (u32)start;
+
+	if (unlikely(csum_start > U16_MAX || csum_end > skb_headlen(skb))) {
+		net_warn_ratelimited("bad partial csum: csum=3D%u/%u headroom=3D%u headl=
en=3D%u\n",
+				     start, off, skb_headroom(skb), skb_headlen(skb));
 		return false;
 	}
 	skb->ip_summed =3D CHECKSUM_PARTIAL;
-	skb->csum_start =3D skb_headroom(skb) + start;
+	skb->csum_start =3D csum_start;
 	skb->csum_offset =3D off;
 	skb_set_transport_header(skb, start);
 	return true;
diff --git a/net/ieee802154/6lowpan_rtnl.c b/net/ieee802154/6lowpan_rtnl.c
index fe6bd7a71081..bcb7e5b5e0e0 100644
--- a/net/ieee802154/6lowpan_rtnl.c
+++ b/net/ieee802154/6lowpan_rtnl.c
@@ -71,6 +71,21 @@ struct lowpan_dev_record {
 	struct list_head list;
 };
=20
+/* don't save pan id, it's intra pan */
+struct lowpan_addr {
+	u8 mode;
+	union {
+		/* IPv6 needs big endian here */
+		__be64 extended_addr;
+		__be16 short_addr;
+	} u;
+};
+
+struct lowpan_addr_info {
+	struct lowpan_addr daddr;
+	struct lowpan_addr saddr;
+};
+
 static inline struct
 lowpan_dev_info *lowpan_dev_info(const struct net_device *dev)
 {
@@ -84,6 +99,14 @@ static inline void lowpan_address_flip(u8 *src, u8 *dest)
 		(dest)[IEEE802154_ADDR_LEN - i - 1] =3D (src)[i];
 }
=20
+static inline struct
+lowpan_addr_info *lowpan_skb_priv(const struct sk_buff *skb)
+{
+	WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct lowpan_addr_info));
+	return (struct lowpan_addr_info *)(skb->data -
+			sizeof(struct lowpan_addr_info));
+}
+
 static int lowpan_header_create(struct sk_buff *skb,
 			   struct net_device *dev,
 			   unsigned short type, const void *_daddr,
@@ -91,8 +114,7 @@ static int lowpan_header_create(struct sk_buff *skb,
 {
 	const u8 *saddr =3D _saddr;
 	const u8 *daddr =3D _daddr;
-	struct ieee802154_addr sa, da;
-	struct ieee802154_mac_cb *cb =3D mac_cb_init(skb);
+	struct lowpan_addr_info *info;
=20
 	/* TODO:
 	 * if this package isn't ipv6 one, where should it be routed?
@@ -106,41 +128,17 @@ static int lowpan_header_create(struct sk_buff *skb,
 	raw_dump_inline(__func__, "saddr", (unsigned char *)saddr, 8);
 	raw_dump_inline(__func__, "daddr", (unsigned char *)daddr, 8);
=20
-	lowpan_header_compress(skb, dev, type, daddr, saddr, len);
+	info =3D lowpan_skb_priv(skb);
=20
-	/* NOTE1: I'm still unsure about the fact that compression and WPAN
-	 * header are created here and not later in the xmit. So wait for
-	 * an opinion of net maintainers.
-	 */
-	/* NOTE2: to be absolutely correct, we must derive PANid information
-	 * from MAC subif of the 'dev' and 'real_dev' network devices, but
-	 * this isn't implemented in mainline yet, so currently we assign 0xff
-	 */
-	cb->type =3D IEEE802154_FC_TYPE_DATA;
+	/* TODO: Currently we only support extended_addr */
+	info->daddr.mode =3D IEEE802154_ADDR_LONG;
+	memcpy(&info->daddr.u.extended_addr, daddr,
+	       sizeof(info->daddr.u.extended_addr));
+	info->saddr.mode =3D IEEE802154_ADDR_LONG;
+	memcpy(&info->saddr.u.extended_addr, saddr,
+	       sizeof(info->daddr.u.extended_addr));
=20
-	/* prepare wpan address data */
-	sa.mode =3D IEEE802154_ADDR_LONG;
-	sa.pan_id =3D ieee802154_mlme_ops(dev)->get_pan_id(dev);
-	sa.extended_addr =3D ieee802154_devaddr_from_raw(saddr);
-
-	/* intra-PAN communications */
-	da.pan_id =3D sa.pan_id;
-
-	/* if the destination address is the broadcast address, use the
-	 * corresponding short address
-	 */
-	if (lowpan_is_addr_broadcast(daddr)) {
-		da.mode =3D IEEE802154_ADDR_SHORT;
-		da.short_addr =3D cpu_to_le16(IEEE802154_ADDR_BROADCAST);
-	} else {
-		da.mode =3D IEEE802154_ADDR_LONG;
-		da.extended_addr =3D ieee802154_devaddr_from_raw(daddr);
-	}
-
-	cb->ackreq =3D !lowpan_is_addr_broadcast(daddr);
-
-	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
-			type, (void *)&da, (void *)&sa, 0);
+	return 0;
 }
=20
 static int lowpan_give_skb_to_devices(struct sk_buff *skb,
@@ -338,13 +336,83 @@ lowpan_xmit_fragmented(struct sk_buff *skb, struct ne=
t_device *dev,
 	return rc;
 }
=20
+static int lowpan_header(struct sk_buff *skb, struct net_device *dev)
+{
+	struct ieee802154_addr sa, da;
+	struct ieee802154_mac_cb *cb =3D mac_cb_init(skb);
+	struct lowpan_addr_info info;
+	void *daddr, *saddr;
+
+	memcpy(&info, lowpan_skb_priv(skb), sizeof(info));
+
+	/* TODO: Currently we only support extended_addr */
+	daddr =3D &info.daddr.u.extended_addr;
+	saddr =3D &info.saddr.u.extended_addr;
+
+	lowpan_header_compress(skb, dev, ETH_P_IPV6, daddr, saddr, skb->len);
+
+	cb->type =3D IEEE802154_FC_TYPE_DATA;
+
+	/* prepare wpan address data */
+	sa.mode =3D IEEE802154_ADDR_LONG;
+	sa.pan_id =3D ieee802154_mlme_ops(dev)->get_pan_id(dev);
+	sa.extended_addr =3D ieee802154_devaddr_from_raw(saddr);
+
+	/* intra-PAN communications */
+	da.pan_id =3D sa.pan_id;
+
+	/* if the destination address is the broadcast address, use the
+	 * corresponding short address
+	 */
+	if (lowpan_is_addr_broadcast((const u8 *)daddr)) {
+		da.mode =3D IEEE802154_ADDR_SHORT;
+		da.short_addr =3D cpu_to_le16(IEEE802154_ADDR_BROADCAST);
+		cb->ackreq =3D false;
+	} else {
+		da.mode =3D IEEE802154_ADDR_LONG;
+		da.extended_addr =3D ieee802154_devaddr_from_raw(daddr);
+		cb->ackreq =3D true;
+	}
+
+	return dev_hard_header(skb, lowpan_dev_info(dev)->real_dev,
+			ETH_P_IPV6, (void *)&da, (void *)&sa, 0);
+}
+
 static netdev_tx_t lowpan_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ieee802154_hdr wpan_hdr;
-	int max_single;
+	int max_single, ret;
=20
 	pr_debug("package xmit\n");
=20
+	/* We must take a copy of the skb before we modify/replace the ipv6
+	 * header as the header could be used elsewhere
+	 */
+	if (unlikely(skb_headroom(skb) < dev->needed_headroom ||
+		     skb_tailroom(skb) < dev->needed_tailroom)) {
+		struct sk_buff *nskb;
+
+		nskb =3D skb_copy_expand(skb, dev->needed_headroom,
+				       dev->needed_tailroom, GFP_ATOMIC);
+		if (likely(nskb)) {
+			consume_skb(skb);
+			skb =3D nskb;
+		} else {
+			kfree_skb(skb);
+			return NET_XMIT_DROP;
+		}
+	} else {
+		skb =3D skb_unshare(skb, GFP_ATOMIC);
+		if (!skb)
+			return NET_XMIT_DROP;
+	}
+
+	ret =3D lowpan_header(skb, dev);
+	if (ret < 0) {
+		kfree_skb(skb);
+		return NET_XMIT_DROP;
+	}
+
 	if (ieee802154_hdr_peek(skb, &wpan_hdr) < 0) {
 		kfree_skb(skb);
 		return NET_XMIT_DROP;
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 2020abf58812..c8c7e1af4c1b 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -1046,6 +1046,7 @@ static int fib_inetaddr_event(struct notifier_block *=
this, unsigned long event,
 static int fib_netdev_event(struct notifier_block *this, unsigned long eve=
nt, void *ptr)
 {
 	struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
+	struct netdev_notifier_info_ext *info_ext =3D ptr;
 	struct in_device *in_dev;
 	struct net *net =3D dev_net(dev);
=20
@@ -1074,6 +1075,9 @@ static int fib_netdev_event(struct notifier_block *th=
is, unsigned long event, vo
 		fib_disable_ip(dev, 0);
 		break;
 	case NETDEV_CHANGEMTU:
+		fib_sync_mtu(dev, info_ext->ext.mtu);
+		rt_cache_flush(net);
+		break;
 	case NETDEV_CHANGE:
 		rt_cache_flush(net);
 		break;
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 5b4580d7ea7e..6f44569623ae 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1122,6 +1122,56 @@ int fib_sync_down_addr(struct net *net, __be32 local)
 	return ret;
 }
=20
+/* Update the PMTU of exceptions when:
+ * - the new MTU of the first hop becomes smaller than the PMTU
+ * - the old MTU was the same as the PMTU, and it limited discovery of
+ *   larger MTUs on the path. With that limit raised, we can now
+ *   discover larger MTUs
+ * A special case is locked exceptions, for which the PMTU is smaller
+ * than the minimal accepted PMTU:
+ * - if the new MTU is greater than the PMTU, don't make any change
+ * - otherwise, unlock and set PMTU
+ */
+static void nh_update_mtu(struct fib_nh *nh, u32 new, u32 orig)
+{
+	struct fnhe_hash_bucket *bucket;
+	int i;
+
+	bucket =3D rcu_dereference_protected(nh->nh_exceptions, 1);
+	if (!bucket)
+		return;
+
+	for (i =3D 0; i < FNHE_HASH_SIZE; i++) {
+		struct fib_nh_exception *fnhe;
+
+		for (fnhe =3D rcu_dereference_protected(bucket[i].chain, 1);
+		     fnhe;
+		     fnhe =3D rcu_dereference_protected(fnhe->fnhe_next, 1)) {
+			if (fnhe->fnhe_mtu_locked) {
+				if (new <=3D fnhe->fnhe_pmtu) {
+					fnhe->fnhe_pmtu =3D new;
+					fnhe->fnhe_mtu_locked =3D false;
+				}
+			} else if (new < fnhe->fnhe_pmtu ||
+				   orig =3D=3D fnhe->fnhe_pmtu) {
+				fnhe->fnhe_pmtu =3D new;
+			}
+		}
+	}
+}
+
+void fib_sync_mtu(struct net_device *dev, u32 orig_mtu)
+{
+	unsigned int hash =3D fib_devindex_hashfn(dev->ifindex);
+	struct hlist_head *head =3D &fib_info_devhash[hash];
+	struct fib_nh *nh;
+
+	hlist_for_each_entry(nh, head, nh_hash) {
+		if (nh->nh_dev =3D=3D dev)
+			nh_update_mtu(nh, dev->mtu, orig_mtu);
+	}
+}
+
 int fib_sync_down_dev(struct net_device *dev, int force)
 {
 	int ret =3D 0;
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 08dfaeac1b08..48444c4c3c51 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -795,10 +795,9 @@ static void igmp_timer_expire(unsigned long data)
 	spin_lock(&im->lock);
 	im->tm_running =3D 0;
=20
-	if (im->unsolicit_count) {
-		im->unsolicit_count--;
+	if (im->unsolicit_count && --im->unsolicit_count)
 		igmp_start_timer(im, unsolicited_report_interval(in_dev));
-	}
+
 	im->reporter =3D 1;
 	spin_unlock(&im->lock);
=20
@@ -1257,6 +1256,8 @@ static void igmp_group_added(struct ip_mc_list *im)
=20
 	if (in_dev->dead)
 		return;
+
+	im->unsolicit_count =3D IGMP_Unsolicited_Report_Count;
 	if (IGMP_V1_SEEN(in_dev) || IGMP_V2_SEEN(in_dev)) {
 		spin_lock_bh(&im->lock);
 		igmp_start_timer(im, IGMP_Initial_Report_Delay);
@@ -1361,7 +1362,6 @@ void ip_mc_inc_group(struct in_device *in_dev, __be32=
 addr)
 	spin_lock_init(&im->lock);
 #ifdef CONFIG_IP_MULTICAST
 	setup_timer(&im->timer, &igmp_timer_expire, (unsigned long)im);
-	im->unsolicit_count =3D IGMP_Unsolicited_Report_Count;
 #endif
=20
 	im->next_rcu =3D in_dev->mc_list;
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 32f685b35302..f0f64a102837 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -551,6 +551,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_dev=
ice *dev,
 		    const struct iphdr *tnl_params, const u8 protocol)
 {
 	struct ip_tunnel *tunnel =3D netdev_priv(dev);
+	unsigned int inner_nhdr_len =3D 0;
 	const struct iphdr *inner_iph;
 	struct flowi4 fl4;
 	u8     tos, ttl;
@@ -561,6 +562,14 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_de=
vice *dev,
 	int err;
 	bool connected;
=20
+	/* ensure we can access the inner net header, for several users below */
+	if (skb->protocol =3D=3D htons(ETH_P_IP))
+		inner_nhdr_len =3D sizeof(struct iphdr);
+	else if (skb->protocol =3D=3D htons(ETH_P_IPV6))
+		inner_nhdr_len =3D sizeof(struct ipv6hdr);
+	if (unlikely(!pskb_may_pull(skb, inner_nhdr_len)))
+		goto tx_error;
+
 	inner_iph =3D (const struct iphdr *)skb_inner_network_header(skb);
 	connected =3D (tunnel->parms.iph.daddr !=3D 0);
=20
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 22773519912b..1953b79f46b4 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4085,8 +4085,8 @@ static int in6_dump_addrs(struct inet6_dev *idev, str=
uct sk_buff *skb,
=20
 		/* unicast address incl. temp addr */
 		list_for_each_entry(ifa, &idev->addr_list, if_list) {
-			if (++ip_idx < s_ip_idx)
-				continue;
+			if (ip_idx < s_ip_idx)
+				goto next;
 			err =3D inet6_fill_ifaddr(skb, ifa,
 						NETLINK_CB(cb->skb).portid,
 						cb->nlh->nlmsg_seq,
@@ -4095,6 +4095,8 @@ static int in6_dump_addrs(struct inet6_dev *idev, str=
uct sk_buff *skb,
 			if (err <=3D 0)
 				break;
 			nl_dump_check_consistent(cb, nlmsg_hdr(skb));
+next:
+			ip_idx++;
 		}
 		break;
 	}
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index feed46f4d726..d5db3ce7b463 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -860,14 +860,14 @@ static int __init inet6_init(void)
=20
 	err =3D proto_register(&pingv6_prot, 1);
 	if (err)
-		goto out_unregister_ping_proto;
+		goto out_unregister_raw_proto;
=20
 	/* We MUST register RAW sockets before we create the ICMP6,
 	 * IGMP6, or NDISC control sockets.
 	 */
 	err =3D rawv6_init();
 	if (err)
-		goto out_unregister_raw_proto;
+		goto out_unregister_ping_proto;
=20
 	/* Register the family here so that the init calls below will
 	 * be able to create sockets. (?? is this dangerous ??)
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index a94432384bc4..e59b30054b0f 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -183,9 +183,10 @@ int ip6_xmit(struct sock *sk, struct sk_buff *skb, str=
uct flowi6 *fl6,
 				kfree_skb(skb);
 				return -ENOBUFS;
 			}
+			if (skb->sk)
+				skb_set_owner_w(skb2, skb->sk);
 			consume_skb(skb);
 			skb =3D skb2;
-			skb_set_owner_w(skb, sk);
 		}
 		if (opt->opt_flen)
 			ipv6_push_frag_opts(skb, opt, &proto);
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 28736de12459..36484a8565f4 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1085,13 +1085,18 @@ static inline int
 ip4ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip6_tnl *t =3D netdev_priv(dev);
-	const struct iphdr  *iph =3D ip_hdr(skb);
+	const struct iphdr  *iph;
 	int encap_limit =3D -1;
 	struct flowi6 fl6;
 	__u8 dsfield;
 	__u32 mtu;
 	int err;
=20
+	/* ensure we can access the full inner ip header */
+	if (!pskb_may_pull(skb, sizeof(struct iphdr)))
+		return -1;
+
+	iph =3D ip_hdr(skb);
 	if ((t->parms.proto !=3D IPPROTO_IPIP && t->parms.proto !=3D 0) ||
 	    !ip6_tnl_xmit_ctl(t))
 		return -1;
@@ -1126,7 +1131,7 @@ static inline int
 ip6ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ip6_tnl *t =3D netdev_priv(dev);
-	struct ipv6hdr *ipv6h =3D ipv6_hdr(skb);
+	struct ipv6hdr *ipv6h;
 	int encap_limit =3D -1;
 	__u16 offset;
 	struct flowi6 fl6;
@@ -1134,6 +1139,10 @@ ip6ip6_tnl_xmit(struct sk_buff *skb, struct net_devi=
ce *dev)
 	__u32 mtu;
 	int err;
=20
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
+		return -1;
+
+	ipv6h =3D ipv6_hdr(skb);
 	if ((t->parms.proto !=3D IPPROTO_IPV6 && t->parms.proto !=3D 0) ||
 	    !ip6_tnl_xmit_ctl(t) || ip6_tnl_addr_conflict(t, ipv6h))
 		return -1;
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 1412a20eded3..aba53fbdec10 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -618,6 +618,7 @@ static int rawv6_send_hdrinc(struct sock *sk, void *fro=
m, int length,
 			unsigned int flags)
 {
 	struct ipv6_pinfo *np =3D inet6_sk(sk);
+	struct net *net =3D sock_net(sk);
 	struct ipv6hdr *iph;
 	struct sk_buff *skb;
 	int err;
@@ -642,8 +643,6 @@ static int rawv6_send_hdrinc(struct sock *sk, void *fro=
m, int length,
 	skb->protocol =3D htons(ETH_P_IPV6);
 	skb->priority =3D sk->sk_priority;
 	skb->mark =3D sk->sk_mark;
-	skb_dst_set(skb, &rt->dst);
-	*dstp =3D NULL;
=20
 	skb_put(skb, length);
 	skb_reset_network_header(skb);
@@ -653,24 +652,37 @@ static int rawv6_send_hdrinc(struct sock *sk, void *f=
rom, int length,
=20
 	skb->transport_header =3D skb->network_header;
 	err =3D memcpy_fromiovecend((void *)iph, from, 0, length);
-	if (err)
-		goto error_fault;
+	if (err) {
+		err =3D -EFAULT;
+		kfree_skb(skb);
+		goto error;
+	}
=20
-	IP6_UPD_PO_STATS(sock_net(sk), rt->rt6i_idev, IPSTATS_MIB_OUT, skb->len);
+	skb_dst_set(skb, &rt->dst);
+	*dstp =3D NULL;
+
+	/* Acquire rcu_read_lock() in case we need to use rt->rt6i_idev
+	 * in the error path. Since skb has been freed, the dst could
+	 * have been queued for deletion.
+	 */
+	rcu_read_lock();
+	IP6_UPD_PO_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUT, skb->len);
 	err =3D NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, skb, NULL,
 		      rt->dst.dev, dst_output);
 	if (err > 0)
 		err =3D net_xmit_errno(err);
-	if (err)
-		goto error;
+	if (err) {
+		IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);
+		rcu_read_unlock();
+		goto error_check;
+	}
+	rcu_read_unlock();
 out:
 	return 0;
=20
-error_fault:
-	err =3D -EFAULT;
-	kfree_skb(skb);
 error:
-	IP6_INC_STATS(sock_net(sk), rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);
+	IP6_INC_STATS(net, rt->rt6i_idev, IPSTATS_MIB_OUTDISCARDS);
+error_check:
 	if (err =3D=3D -ENOBUFS && !np->recverr)
 		err =3D 0;
 	return err;
diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 0f8cd584cd3d..c2b7e70aa5d4 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -158,9 +158,11 @@ static int __xfrm6_output(struct sk_buff *skb)
=20
 	if (toobig && xfrm6_local_dontfrag(skb)) {
 		xfrm6_local_rxpmtu(skb, mtu);
+		kfree_skb(skb);
 		return -EMSGSIZE;
 	} else if (!skb->ignore_df && toobig && skb->sk) {
 		xfrm_local_error(skb, mtu);
+		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
=20
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 8cd87fbef291..943fc485b5ed 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1195,7 +1195,7 @@ int l2tp_xmit_skb(struct l2tp_session *session, struc=
t sk_buff *skb, int hdr_len
=20
 	/* Get routing info from the tunnel socket */
 	skb_dst_drop(skb);
-	skb_dst_set(skb, dst_clone(__sk_dst_check(sk, 0)));
+	skb_dst_set(skb, sk_dst_check(sk, 0));
=20
 	inet =3D inet_sk(sk);
 	fl =3D &inet->cork.fl;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 4b1a0e5dd701..46d0ecf362bf 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -209,7 +209,7 @@ static int ieee80211_add_key(struct wiphy *wiphy, struc=
t net_device *dev,
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
 		/* Keys without a station are used for TX only */
-		if (key->sta && test_sta_flag(key->sta, WLAN_STA_MFP))
+		if (sta && test_sta_flag(sta, WLAN_STA_MFP))
 			key->conf.flags |=3D IEEE80211_KEY_FLAG_RX_MGMT;
 		break;
 	case NL80211_IFTYPE_ADHOC:
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index 6d1647399d4f..c5a2457940a4 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -24,6 +24,7 @@
 #include <linux/netdevice.h>
 #include <linux/if_arp.h>
 #include <linux/crc-ccitt.h>
+#include <asm/unaligned.h>
=20
 #include <net/ieee802154_netdev.h>
 #include <net/mac802154.h>
@@ -89,25 +90,33 @@ netdev_tx_t mac802154_tx(struct mac802154_priv *priv, s=
truct sk_buff *skb,
=20
 	if (!(priv->phy->channels_supported[page] & (1 << chan))) {
 		WARN_ON(1);
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
+		goto err_tx;
 	}
=20
 	mac802154_monitors_rx(mac802154_to_priv(&priv->hw), skb);
=20
 	if (!(priv->hw.flags & IEEE802154_HW_OMIT_CKSUM)) {
-		u16 crc =3D crc_ccitt(0, skb->data, skb->len);
-		u8 *data =3D skb_put(skb, 2);
-		data[0] =3D crc & 0xff;
-		data[1] =3D crc >> 8;
-	}
+		struct sk_buff *nskb;
+		u16 crc;
+
+		if (unlikely(skb_tailroom(skb) < 2)) {
+			nskb =3D skb_copy_expand(skb, 0, 2, GFP_ATOMIC);
+			if (likely(nskb)) {
+				consume_skb(skb);
+				skb =3D nskb;
+			} else {
+				goto err_tx;
+			}
+		}
=20
-	if (skb_cow_head(skb, priv->hw.extra_tx_headroom)) {
-		kfree_skb(skb);
-		return NETDEV_TX_OK;
+		crc =3D crc_ccitt(0, skb->data, skb->len);
+		put_unaligned_le16(crc, skb_put(skb, 2));
 	}
=20
-	work =3D kzalloc(sizeof(struct xmit_work), GFP_ATOMIC);
+	if (skb_cow_head(skb, priv->hw.extra_tx_headroom))
+		goto err_tx;
+
+	work =3D kzalloc(sizeof(*work), GFP_ATOMIC);
 	if (!work) {
 		kfree_skb(skb);
 		return NETDEV_TX_BUSY;
@@ -128,4 +137,8 @@ netdev_tx_t mac802154_tx(struct mac802154_priv *priv, s=
truct sk_buff *skb,
 	queue_work(priv->dev_workqueue, &work->work);
=20
 	return NETDEV_TX_OK;
+
+err_tx:
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
 }
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b834cd9232c4..1a41bf30bb2e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2519,7 +2519,7 @@ static int nf_tables_newset(struct sock *nlsk, struct=
 sk_buff *skb,
 	struct nft_set *set;
 	struct nft_ctx ctx;
 	char name[IFNAMSIZ];
-	unsigned int size;
+	u64 size;
 	bool create;
 	u32 ktype, dtype, flags, policy;
 	struct nft_set_desc desc;
@@ -4042,6 +4042,10 @@ static int __init nf_tables_module_init(void)
 {
 	int err;
=20
+	err =3D register_pernet_subsys(&nf_tables_net_ops);
+	if (err < 0)
+		return err;
+
 	info =3D kmalloc(sizeof(struct nft_expr_info) * NFT_RULE_MAXEXPRS,
 		       GFP_KERNEL);
 	if (info =3D=3D NULL) {
@@ -4053,17 +4057,19 @@ static int __init nf_tables_module_init(void)
 	if (err < 0)
 		goto err2;
=20
+	/* must be last */
 	err =3D nfnetlink_subsys_register(&nf_tables_subsys);
 	if (err < 0)
 		goto err3;
=20
 	pr_info("nf_tables: (c) 2007-2009 Patrick McHardy <kaber@trash.net>\n");
-	return register_pernet_subsys(&nf_tables_net_ops);
+	return err;
 err3:
 	nf_tables_core_module_exit();
 err2:
 	kfree(info);
 err1:
+	unregister_pernet_subsys(&nf_tables_net_ops);
 	return err;
 }
=20
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index 4080ed6a072b..55d8a62c608d 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -327,7 +327,7 @@ static void nft_hash_walk(const struct nft_ctx *ctx, co=
nst struct nft_set *set,
 	}
 }
=20
-static unsigned int nft_hash_privsize(const struct nlattr * const nla[])
+static u64 nft_hash_privsize(const struct nlattr * const nla[])
 {
 	return sizeof(struct nft_hash);
 }
diff --git a/net/netfilter/nft_rbtree.c b/net/netfilter/nft_rbtree.c
index 0636387c7c80..1a4791467f87 100644
--- a/net/netfilter/nft_rbtree.c
+++ b/net/netfilter/nft_rbtree.c
@@ -211,7 +211,7 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 	spin_unlock_bh(&nft_rbtree_lock);
 }
=20
-static unsigned int nft_rbtree_privsize(const struct nlattr * const nla[])
+static u64 nft_rbtree_privsize(const struct nlattr * const nla[])
 {
 	return sizeof(struct nft_rbtree);
 }
diff --git a/net/sched/act_ipt.c b/net/sched/act_ipt.c
index 8a64a0734aee..745d3071855e 100644
--- a/net/sched/act_ipt.c
+++ b/net/sched/act_ipt.c
@@ -107,7 +107,7 @@ static int tcf_ipt_init(struct net *net, struct nlattr =
*nla, struct nlattr *est,
 		return -EINVAL;
=20
 	td =3D (struct xt_entry_target *)nla_data(tb[TCA_IPT_TARG]);
-	if (nla_len(tb[TCA_IPT_TARG]) < td->u.target_size)
+	if (nla_len(tb[TCA_IPT_TARG]) !=3D td->u.target_size)
 		return -EINVAL;
=20
 	if (tb[TCA_IPT_INDEX] !=3D NULL)
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 591d7772e99b..105fdd8589d7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -9185,6 +9185,7 @@ static int nl80211_update_ft_ies(struct sk_buff *skb,=
 struct genl_info *info)
 		return -EOPNOTSUPP;
=20
 	if (!info->attrs[NL80211_ATTR_MDID] ||
+	    !info->attrs[NL80211_ATTR_IE] ||
 	    !is_valid_ie_attr(info->attrs[NL80211_ATTR_IE]))
 		return -EINVAL;
=20
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 20ccc79d53a2..22a6387b3bcc 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1993,6 +1993,7 @@ static int regulatory_hint_core(const char *alpha2)
 	request->alpha2[0] =3D alpha2[0];
 	request->alpha2[1] =3D alpha2[1];
 	request->initiator =3D NL80211_REGDOM_SET_BY_CORE;
+	request->wiphy_idx =3D WIPHY_IDX_INVALID;
=20
 	queue_regulatory_request(request);
=20
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6e1a7104d66f..bf535ab3b442 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1692,7 +1692,10 @@ xfrm_resolve_and_create_bundle(struct xfrm_policy **=
pols, int num_pols,
 	/* Try to instantiate a bundle */
 	err =3D xfrm_tmpl_resolve(pols, num_pols, fl, xfrm, family);
 	if (err <=3D 0) {
-		if (err !=3D 0 && err !=3D -EAGAIN)
+		if (err =3D=3D 0)
+			return NULL;
+
+		if (err !=3D -EAGAIN)
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTPOLERROR);
 		return ERR_PTR(err);
 	}
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 25dc962431d4..62fbbdc58566 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -150,10 +150,16 @@ static int verify_newsa_info(struct xfrm_usersa_info =
*p,
 	err =3D -EINVAL;
 	switch (p->family) {
 	case AF_INET:
+		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
+			goto out;
+
 		break;
=20
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
+		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128)
+			goto out;
+
 		break;
 #else
 		err =3D -EAFNOSUPPORT;
@@ -1227,10 +1233,16 @@ static int verify_newpolicy_info(struct xfrm_userpo=
licy_info *p)
=20
 	switch (p->sel.family) {
 	case AF_INET:
+		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
+			return -EINVAL;
+
 		break;
=20
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
+		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128)
+			return -EINVAL;
+
 		break;
 #else
 		return  -EAFNOSUPPORT;
diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_u=
npack.c
index a689f10930b5..25ce8e3d6ede 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -290,32 +290,6 @@ static int unpack_strdup(struct aa_ext *e, char **stri=
ng, const char *name)
 	return res;
 }
=20
-#define DFA_VALID_PERM_MASK		0xffffffff
-#define DFA_VALID_PERM2_MASK		0xffffffff
-
-/**
- * verify_accept - verify the accept tables of a dfa
- * @dfa: dfa to verify accept tables of (NOT NULL)
- * @flags: flags governing dfa
- *
- * Returns: 1 if valid accept tables else 0 if error
- */
-static bool verify_accept(struct aa_dfa *dfa, int flags)
-{
-	int i;
-
-	/* verify accept permissions */
-	for (i =3D 0; i < dfa->tables[YYTD_ID_ACCEPT]->td_lolen; i++) {
-		int mode =3D ACCEPT_TABLE(dfa)[i];
-
-		if (mode & ~DFA_VALID_PERM_MASK)
-			return 0;
-
-		if (ACCEPT_TABLE2(dfa)[i] & ~DFA_VALID_PERM2_MASK)
-			return 0;
-	}
-	return 1;
-}
=20
 /**
  * unpack_dfa - unpack a file rule dfa
@@ -351,15 +325,9 @@ static struct aa_dfa *unpack_dfa(struct aa_ext *e)
 		if (IS_ERR(dfa))
 			return dfa;
=20
-		if (!verify_accept(dfa, flags))
-			goto fail;
 	}
=20
 	return dfa;
-
-fail:
-	aa_put_dfa(dfa);
-	return ERR_PTR(-EPROTO);
 }
=20
 /**
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encry=
pted-keys/encrypted.c
index cad4c1f415e3..32437a63002d 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -141,23 +141,22 @@ static int valid_ecryptfs_desc(const char *ecryptfs_d=
esc)
  */
 static int valid_master_desc(const char *new_desc, const char *orig_desc)
 {
-	if (!memcmp(new_desc, KEY_TRUSTED_PREFIX, KEY_TRUSTED_PREFIX_LEN)) {
-		if (strlen(new_desc) =3D=3D KEY_TRUSTED_PREFIX_LEN)
-			goto out;
-		if (orig_desc)
-			if (memcmp(new_desc, orig_desc, KEY_TRUSTED_PREFIX_LEN))
-				goto out;
-	} else if (!memcmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN)) {
-		if (strlen(new_desc) =3D=3D KEY_USER_PREFIX_LEN)
-			goto out;
-		if (orig_desc)
-			if (memcmp(new_desc, orig_desc, KEY_USER_PREFIX_LEN))
-				goto out;
-	} else
-		goto out;
+	int prefix_len;
+
+	if (!strncmp(new_desc, KEY_TRUSTED_PREFIX, KEY_TRUSTED_PREFIX_LEN))
+		prefix_len =3D KEY_TRUSTED_PREFIX_LEN;
+	else if (!strncmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN))
+		prefix_len =3D KEY_USER_PREFIX_LEN;
+	else
+		return -EINVAL;
+
+	if (!new_desc[prefix_len])
+		return -EINVAL;
+
+	if (orig_desc && strncmp(new_desc, orig_desc, prefix_len))
+		return -EINVAL;
+
 	return 0;
-out:
-	return -EINVAL;
 }
=20
 /*
diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index f34153962d07..585b594bd838 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -88,8 +88,10 @@ static struct device_node *get_gpio(char *name,
 	}
=20
 	reg =3D of_get_property(np, "reg", NULL);
-	if (!reg)
+	if (!reg) {
+		of_node_put(np);
 		return NULL;
+	}
=20
 	*gpioptr =3D *reg;
=20
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index 082509eb805d..c5fc489de26f 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -239,16 +239,12 @@ int snd_dma_alloc_pages_fallback(int type, struct dev=
ice *device, size_t size,
 	int err;
=20
 	while ((err =3D snd_dma_alloc_pages(type, device, size, dmab)) < 0) {
-		size_t aligned_size;
 		if (err !=3D -ENOMEM)
 			return err;
 		if (size <=3D PAGE_SIZE)
 			return -ENOMEM;
-		aligned_size =3D PAGE_SIZE << get_order(size);
-		if (size !=3D aligned_size)
-			size =3D aligned_size;
-		else
-			size >>=3D 1;
+		size >>=3D 1;
+		size =3D PAGE_SIZE << get_order(size);
 	}
 	if (! dmab->area)
 		return -ENOMEM;
diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index bb032d7593e3..0b292c5d8ea7 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -194,7 +194,7 @@ odev_poll(struct file *file, poll_table * wait)
 	struct seq_oss_devinfo *dp;
 	dp =3D file->private_data;
 	if (snd_BUG_ON(!dp))
-		return -ENXIO;
+		return POLLERR;
 	return snd_seq_oss_poll(dp, file, wait);
 }
=20
diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index b813ecc6322d..60fb2c708d75 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1110,7 +1110,7 @@ static unsigned int snd_seq_poll(struct file *file, p=
oll_table * wait)
=20
 	/* check client structures are in place */
 	if (snd_BUG_ON(!client))
-		return -ENXIO;
+		return POLLERR;
=20
 	if ((snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_INPUT) &&
 	    client->data.user.fifo) {
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index ef494ffc1369..975a7c939d2f 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -163,6 +163,7 @@ static void snd_virmidi_output_trigger(struct snd_rawmi=
di_substream *substream,
 	int count, res;
 	unsigned char buf[32], *pbuf;
 	unsigned long flags;
+	bool check_resched =3D !in_atomic();
=20
 	if (up) {
 		vmidi->trigger =3D 1;
@@ -200,6 +201,15 @@ static void snd_virmidi_output_trigger(struct snd_rawm=
idi_substream *substream,
 					vmidi->event.type =3D SNDRV_SEQ_EVENT_NONE;
 				}
 			}
+			if (!check_resched)
+				continue;
+			/* do temporary unlock & cond_resched() for avoiding
+			 * CPU soft lockup, which may happen via a write from
+			 * a huge rawmidi buffer
+			 */
+			spin_unlock_irqrestore(&substream->runtime->lock, flags);
+			cond_resched();
+			spin_lock_irqsave(&substream->runtime->lock, flags);
 		}
 	out:
 		spin_unlock_irqrestore(&substream->runtime->lock, flags);
diff --git a/sound/drivers/vx/vx_pcm.c b/sound/drivers/vx/vx_pcm.c
index deed5efff33c..e5ebe2eea020 100644
--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -1071,8 +1071,10 @@ static void vx_pcm_capture_update(struct vx_core *ch=
ip, struct snd_pcm_substream
 		/* ok, let's accelerate! */
 		int align =3D pipe->align * 3;
 		space =3D (count / align) * align;
-		vx_pseudo_dma_read(chip, runtime, pipe, space);
-		count -=3D space;
+		if (space > 0) {
+			vx_pseudo_dma_read(chip, runtime, pipe, space);
+			count -=3D space;
+		}
 	}
 	/* read the rest of bytes */
 	while (count > 0) {
diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/beb=
ob_maudio.c
index 96f770024c3b..3f285d23a9dd 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -96,17 +96,13 @@ int snd_bebob_maudio_load_firmware(struct fw_unit *unit)
 	struct fw_device *device =3D fw_parent_device(unit);
 	int err, rcode;
 	u64 date;
-	__le32 cues[3] =3D {
-		cpu_to_le32(MAUDIO_BOOTLOADER_CUE1),
-		cpu_to_le32(MAUDIO_BOOTLOADER_CUE2),
-		cpu_to_le32(MAUDIO_BOOTLOADER_CUE3)
-	};
+	__le32 *cues;
=20
 	/* check date of software used to build */
 	err =3D snd_bebob_read_block(unit, INFO_OFFSET_SW_DATE,
 				   &date, sizeof(u64));
 	if (err < 0)
-		goto end;
+		return err;
 	/*
 	 * firmware version 5058 or later has date later than "20070401", but
 	 * 'date' is not null-terminated.
@@ -114,20 +110,28 @@ int snd_bebob_maudio_load_firmware(struct fw_unit *un=
it)
 	if (date < 0x3230303730343031LL) {
 		dev_err(&unit->device,
 			"Use firmware version 5058 or later\n");
-		err =3D -ENOSYS;
-		goto end;
+		return -ENXIO;
 	}
=20
+	cues =3D kmalloc_array(3, sizeof(*cues), GFP_KERNEL);
+	if (!cues)
+		return -ENOMEM;
+
+	cues[0] =3D cpu_to_le32(MAUDIO_BOOTLOADER_CUE1);
+	cues[1] =3D cpu_to_le32(MAUDIO_BOOTLOADER_CUE2);
+	cues[2] =3D cpu_to_le32(MAUDIO_BOOTLOADER_CUE3);
+
 	rcode =3D fw_run_transaction(device->card, TCODE_WRITE_BLOCK_REQUEST,
 				   device->node_id, device->generation,
 				   device->max_speed, BEBOB_ADDR_REG_REQ,
-				   cues, sizeof(cues));
+				   cues, 3 * sizeof(*cues));
+	kfree(cues);
 	if (rcode !=3D RCODE_COMPLETE) {
 		dev_err(&unit->device,
 			"Failed to send a cue to load firmware\n");
 		err =3D -EIO;
 	}
-end:
+
 	return err;
 }
=20
diff --git a/sound/pci/cs5535audio/cs5535audio.h b/sound/pci/cs5535audio/cs=
5535audio.h
index 0579daa62215..425d1b664029 100644
--- a/sound/pci/cs5535audio/cs5535audio.h
+++ b/sound/pci/cs5535audio/cs5535audio.h
@@ -66,9 +66,9 @@ struct cs5535audio_dma_ops {
 };
=20
 struct cs5535audio_dma_desc {
-	u32 addr;
-	u16 size;
-	u16 ctlreserved;
+	__le32 addr;
+	__le16 size;
+	__le16 ctlreserved;
 };
=20
 struct cs5535audio_dma {
diff --git a/sound/pci/cs5535audio/cs5535audio_pcm.c b/sound/pci/cs5535audi=
o/cs5535audio_pcm.c
index 9c2dc911d8d7..709f1c584d3e 100644
--- a/sound/pci/cs5535audio/cs5535audio_pcm.c
+++ b/sound/pci/cs5535audio/cs5535audio_pcm.c
@@ -158,8 +158,8 @@ static int cs5535audio_build_dma_packets(struct cs5535a=
udio *cs5535au,
 	lastdesc->addr =3D cpu_to_le32((u32) dma->desc_buf.addr);
 	lastdesc->size =3D 0;
 	lastdesc->ctlreserved =3D cpu_to_le16(PRD_JMP);
-	jmpprd_addr =3D cpu_to_le32(lastdesc->addr +
-				  (sizeof(struct cs5535audio_dma_desc)*periods));
+	jmpprd_addr =3D (u32)dma->desc_buf.addr +
+		sizeof(struct cs5535audio_dma_desc) * periods;
=20
 	dma->substream =3D substream;
 	dma->period_bytes =3D period_bytes;
diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 745f0627c634..acce8c76eff0 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -2521,7 +2521,7 @@ static int snd_emu10k1_fx8010_ioctl(struct snd_hwdep =
* hw, struct file *file, un
 		emu->support_tlv =3D 1;
 		return put_user(SNDRV_EMU10K1_VERSION, (int __user *)argp);
 	case SNDRV_EMU10K1_IOCTL_INFO:
-		info =3D kmalloc(sizeof(*info), GFP_KERNEL);
+		info =3D kzalloc(sizeof(*info), GFP_KERNEL);
 		if (!info)
 			return -ENOMEM;
 		snd_emu10k1_fx8010_info(emu, info);
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index 2d1570273e99..5c7fbf403451 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -264,13 +264,13 @@ static void vx2_dma_write(struct vx_core *chip, struc=
t snd_pcm_runtime *runtime,
=20
 	/* Transfer using pseudo-dma.
 	 */
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >=3D pipe->buffer_bytes) {
 		int length =3D pipe->buffer_bytes - offset;
 		count -=3D length;
 		length >>=3D 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0) {
-			outl(cpu_to_le32(*addr), port);
+		for (; length > 0; length--) {
+			outl(*addr, port);
 			addr++;
 		}
 		addr =3D (u32 *)runtime->dma_area;
@@ -279,8 +279,8 @@ static void vx2_dma_write(struct vx_core *chip, struct =
snd_pcm_runtime *runtime,
 	pipe->hw_ptr +=3D count;
 	count >>=3D 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 0) {
-		outl(cpu_to_le32(*addr), port);
+	for (; count > 0; count--) {
+		outl(*addr, port);
 		addr++;
 	}
=20
@@ -302,21 +302,21 @@ static void vx2_dma_read(struct vx_core *chip, struct=
 snd_pcm_runtime *runtime,
 	vx2_setup_pseudo_dma(chip, 0);
 	/* Transfer using pseudo-dma.
 	 */
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >=3D pipe->buffer_bytes) {
 		int length =3D pipe->buffer_bytes - offset;
 		count -=3D length;
 		length >>=3D 2; /* in 32bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0)
-			*addr++ =3D le32_to_cpu(inl(port));
+		for (; length > 0; length--)
+			*addr++ =3D inl(port);
 		addr =3D (u32 *)runtime->dma_area;
 		pipe->hw_ptr =3D 0;
 	}
 	pipe->hw_ptr +=3D count;
 	count >>=3D 2; /* in 32bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 0)
-		*addr++ =3D le32_to_cpu(inl(port));
+	for (; count > 0; count--)
+		*addr++ =3D inl(port);
=20
 	vx2_release_pseudo_dma(chip);
 }
diff --git a/sound/pcmcia/vx/vxp_ops.c b/sound/pcmcia/vx/vxp_ops.c
index fe33e122e372..894177603b9a 100644
--- a/sound/pcmcia/vx/vxp_ops.c
+++ b/sound/pcmcia/vx/vxp_ops.c
@@ -369,13 +369,13 @@ static void vxp_dma_write(struct vx_core *chip, struc=
t snd_pcm_runtime *runtime,
 	unsigned short *addr =3D (unsigned short *)(runtime->dma_area + offset);
=20
 	vx_setup_pseudo_dma(chip, 1);
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >=3D pipe->buffer_bytes) {
 		int length =3D pipe->buffer_bytes - offset;
 		count -=3D length;
 		length >>=3D 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0) {
-			outw(cpu_to_le16(*addr), port);
+		for (; length > 0; length--) {
+			outw(*addr, port);
 			addr++;
 		}
 		addr =3D (unsigned short *)runtime->dma_area;
@@ -384,8 +384,8 @@ static void vxp_dma_write(struct vx_core *chip, struct =
snd_pcm_runtime *runtime,
 	pipe->hw_ptr +=3D count;
 	count >>=3D 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 0) {
-		outw(cpu_to_le16(*addr), port);
+	for (; count > 0; count--) {
+		outw(*addr, port);
 		addr++;
 	}
 	vx_release_pseudo_dma(chip);
@@ -411,26 +411,26 @@ static void vxp_dma_read(struct vx_core *chip, struct=
 snd_pcm_runtime *runtime,
 	if (snd_BUG_ON(count % 2))
 		return;
 	vx_setup_pseudo_dma(chip, 0);
-	if (offset + count > pipe->buffer_bytes) {
+	if (offset + count >=3D pipe->buffer_bytes) {
 		int length =3D pipe->buffer_bytes - offset;
 		count -=3D length;
 		length >>=3D 1; /* in 16bit words */
 		/* Transfer using pseudo-dma. */
-		while (length-- > 0)
-			*addr++ =3D le16_to_cpu(inw(port));
+		for (; length > 0; length--)
+			*addr++ =3D inw(port);
 		addr =3D (unsigned short *)runtime->dma_area;
 		pipe->hw_ptr =3D 0;
 	}
 	pipe->hw_ptr +=3D count;
 	count >>=3D 1; /* in 16bit words */
 	/* Transfer using pseudo-dma. */
-	while (count-- > 1)
-		*addr++ =3D le16_to_cpu(inw(port));
+	for (; count > 1; count--)
+		*addr++ =3D inw(port);
 	/* Disable DMA */
 	pchip->regDIALOG &=3D ~VXP_DLG_DMAREAD_SEL_MASK;
 	vx_outb(chip, DIALOG, pchip->regDIALOG);
 	/* Read the last word (16 bits) */
-	*addr =3D le16_to_cpu(inw(port));
+	*addr =3D inw(port);
 	/* Disable 16-bit accesses */
 	pchip->regDIALOG &=3D ~VXP_DLG_DMA16_SEL_MASK;
 	vx_outb(chip, DIALOG, pchip->regDIALOG);
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index e1bb8b036909..1105528aa746 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -2427,6 +2427,7 @@ static int wm8994_set_dai_sysclk(struct snd_soc_dai *=
dai,
 			snd_soc_update_bits(codec, WM8994_POWER_MANAGEMENT_2,
 					    WM8994_OPCLK_ENA, 0);
 		}
+		break;
=20
 	default:
 		return -EINVAL;
diff --git a/tools/hv/hv_fcopy_daemon.c b/tools/hv/hv_fcopy_daemon.c
index fba1c75aa484..ee17dfaec22c 100644
--- a/tools/hv/hv_fcopy_daemon.c
+++ b/tools/hv/hv_fcopy_daemon.c
@@ -184,6 +184,7 @@ int main(void)
 			break;
=20
 		default:
+			error =3D HV_E_FAIL;
 			syslog(LOG_ERR, "Unknown operation: %d",
 				in_msg->operation);
=20
diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index f660d3f69ce7..ac32a9234dd2 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -289,7 +289,7 @@ static int kvp_key_delete(int pool, const char *key, in=
t key_size)
 		 * Found a match; just move the remaining
 		 * entries up.
 		 */
-		if (i =3D=3D num_records) {
+		if (i =3D=3D (num_records - 1)) {
 			kvp_file_info[pool].num_records--;
 			kvp_update_file(pool);
 			return 0;

--gwpmnc3xw47uimwk--

--pwu4i46rx4biyqof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlwXvKYACgkQ57/I7JWG
EQll+Q/6AwUGtQO63wc4ehlLZy8cvjnDuHqbe/0Cd/1zyJYjv5by/ztxxJralMJB
yOIdceGtFtr+hKwCCZygTFaFJeHg+a3RvqMIINspvwVOSVX0ka/6F3Gxz/r4WEaB
HLtSIKMSGsUM4xem5zP4mYB3C/7GFQycui73GUzIjHJZlTwDyb8dfnj8R0LFN0Ei
mvRobYlINJK28oCt5yPKw2tg9IfwzxgZeEO4cXkhSjfLuhHOxH6zWPecPxBgUTJH
I2zuaMPf5GFhT54I6zuJGzfXwRhXN4J3ylyXFl8oqSYaIlpasvYSIzKCdCkurp4u
wJphzzIHoIoI543Io4HwwQJV8SD7Fmn9oKhNEajVAi6M3IdJIurWr4Q5WniWCmbD
LNGfKyxqMezhBYHgBXQHEnh0W4wdYlFFmChulJFOGjuCmG8u8UeXVeABUlQwJEUQ
YgpP6kqgklAfiSlXFwEyVLlJyu579os47WqZk4LQFEZcrqE0pFcZp1VdU1YLkrdu
vRx1GADQXuJNhDWQKf0hl5rRsjx8fvnZ3RQtgkkJrEPFakJBRuTA/gW9x5hO2/wk
sCD+CJqXjAGtbm3PXj7jJAU8N6lvJolV6TcBGYpbEvYweFP4//X2zm2E6yqHxR09
elKNPNUclQU48M1wNb4QT+fBQloo3NiNUlahlkH+GfjkiP0diPw=
=DBdk
-----END PGP SIGNATURE-----

--pwu4i46rx4biyqof--
