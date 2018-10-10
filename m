Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35EFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69008214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OibGDp81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69008214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeJJQe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:34:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbeJJQeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:34:25 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3DA214DA;
        Wed, 10 Oct 2018 09:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539162789;
        bh=sgQTyZcDaTT0LaKdfKJQOwpi8hV5eJ/FDXVAyjlNW1Q=;
        h=Date:From:To:Cc:Subject:From;
        b=OibGDp81hBZu7TW7PInXnS/DnhxLiGjcMWX5BwULGFJEi/WybYsj40oUDzLqx5u92
         tiwNjJjkIrwUHdRQMTAqGIrpV1d6KmB/dXWnceEdtr1OSSTKMCIvXFVQmLVaDXtngx
         lZGQ2icB7TXMzjI5YnIOByNqccvA8GjSytHqKZUY=
Date:   Wed, 10 Oct 2018 11:13:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.13
Message-ID: <20181010091306.GA2824@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.13 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/net/sh_eth.txt                |    1=20
 Makefile                                                        |    2=20
 arch/arc/include/asm/atomic.h                                   |    2=20
 arch/arm64/include/asm/jump_label.h                             |    4=20
 arch/hexagon/include/asm/bitops.h                               |    4=20
 arch/hexagon/kernel/dma.c                                       |    2=20
 arch/nds32/include/asm/elf.h                                    |    4=20
 arch/nds32/include/asm/uaccess.h                                |   26 -
 arch/nds32/kernel/atl2c.c                                       |    3=20
 arch/nds32/kernel/module.c                                      |    4=20
 arch/nds32/kernel/traps.c                                       |    2=20
 arch/nds32/kernel/vmlinux.lds.S                                 |   12=20
 arch/powerpc/kvm/book3s_64_mmu_hv.c                             |    2=20
 arch/riscv/kernel/setup.c                                       |    7=20
 arch/x86/events/intel/lbr.c                                     |    4=20
 arch/x86/kernel/apm_32.c                                        |    2=20
 block/blk-cgroup.c                                              |   78 +--=
--
 drivers/ata/libata-core.c                                       |    2=20
 drivers/base/firmware_loader/main.c                             |   35 +-
 drivers/cpufreq/qcom-cpufreq-kryo.c                             |    4=20
 drivers/crypto/caam/caamalg.c                                   |    8=20
 drivers/crypto/chelsio/chcr_algo.c                              |   32 +-
 drivers/crypto/chelsio/chcr_crypto.h                            |    2=20
 drivers/crypto/mxs-dcp.c                                        |   53 ++-
 drivers/crypto/qat/qat_c3xxx/adf_drv.c                          |    6=20
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c                        |    6=20
 drivers/crypto/qat/qat_c62x/adf_drv.c                           |    6=20
 drivers/crypto/qat/qat_c62xvf/adf_drv.c                         |    6=20
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c                       |    6=20
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c                     |    6=20
 drivers/firmware/arm_scmi/perf.c                                |    8=20
 drivers/gpio/gpio-adp5588.c                                     |   24 +
 drivers/gpio/gpio-dwapb.c                                       |    1=20
 drivers/gpio/gpiolib-acpi.c                                     |   86 +++=
--
 drivers/gpio/gpiolib-of.c                                       |    1=20
 drivers/gpio/gpiolib.c                                          |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                          |   23 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c                          |    7=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c                |    8=20
 drivers/gpu/drm/amd/powerplay/hwmgr/smu8_hwmgr.c                |    6=20
 drivers/gpu/drm/nouveau/nouveau_drm.c                           |   14=20
 drivers/gpu/drm/nouveau/nvkm/engine/disp/base.c                 |   14=20
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c                   |   17 -
 drivers/gpu/drm/nouveau/nvkm/engine/disp/ior.h                  |    1=20
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c                 |    6=20
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c                 |   17 -
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h                 |    4=20
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c             |    3=20
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c                   |    2=20
 drivers/hid/hid-apple.c                                         |    9=20
 drivers/hid/hid-ids.h                                           |    7=20
 drivers/hid/hid-saitek.c                                        |    2=20
 drivers/hid/hid-sensor-hub.c                                    |   23 +
 drivers/hid/i2c-hid/i2c-hid.c                                   |   24 +
 drivers/hid/intel-ish-hid/ipc/hw-ish.h                          |    1=20
 drivers/hid/intel-ish-hid/ipc/pci-ish.c                         |    1=20
 drivers/hv/connection.c                                         |    8=20
 drivers/i2c/busses/i2c-uniphier-f.c                             |    7=20
 drivers/i2c/busses/i2c-uniphier.c                               |    7=20
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c                  |   13=20
 drivers/iio/temperature/maxim_thermocouple.c                    |    1=20
 drivers/infiniband/core/ucma.c                                  |    6=20
 drivers/infiniband/hw/bnxt_re/ib_verbs.c                        |    2=20
 drivers/infiniband/hw/bnxt_re/qplib_fp.c                        |    2=20
 drivers/iommu/amd_iommu.c                                       |    2=20
 drivers/md/dm-raid.c                                            |  144 +++=
------
 drivers/md/dm-thin-metadata.c                                   |   34 ++
 drivers/md/dm-thin.c                                            |   73 ++++
 drivers/md/raid10.c                                             |    5=20
 drivers/md/raid5-log.h                                          |    5=20
 drivers/md/raid5.c                                              |    6=20
 drivers/net/ethernet/amazon/ena/ena_com.c                       |    8=20
 drivers/net/ethernet/amazon/ena/ena_netdev.c                    |   52 +--
 drivers/net/ethernet/amazon/ena/ena_netdev.h                    |   11=20
 drivers/net/ethernet/cadence/macb_main.c                        |    2=20
 drivers/net/ethernet/hisilicon/hns/hnae.h                       |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c               |   67 ++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c              |   36 ++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c               |   44 ++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h               |    8=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c              |   29 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h              |    3=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c               |   23 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h               |    1=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c               |   23 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h               |    1=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h               |    1=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c                   |   21 +
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c                |    2=20
 drivers/net/ethernet/ibm/emac/core.c                            |    6=20
 drivers/net/ethernet/ibm/ibmvnic.c                              |   12=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c                   |   12=20
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c                 |    1=20
 drivers/net/ethernet/mellanox/mlx5/core/dev.c                   |    7=20
 drivers/net/ethernet/realtek/r8169.c                            |   11=20
 drivers/net/ethernet/renesas/sh_eth.c                           |   36 ++
 drivers/net/wireless/broadcom/b43/dma.c                         |    6=20
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c              |   50 ---
 drivers/net/wireless/mac80211_hwsim.c                           |   12=20
 drivers/nvme/target/rdma.c                                      |   27 +
 drivers/s390/net/qeth_core_main.c                               |    5=20
 drivers/s390/net/qeth_l2_main.c                                 |    2=20
 drivers/s390/net/qeth_l3_main.c                                 |    2=20
 drivers/scsi/aacraid/aacraid.h                                  |    2=20
 drivers/scsi/csiostor/csio_hw.c                                 |   71 +++-
 drivers/scsi/csiostor/csio_hw.h                                 |    1=20
 drivers/scsi/csiostor/csio_mb.c                                 |    6=20
 drivers/scsi/qedi/qedi.h                                        |    7=20
 drivers/scsi/qedi/qedi_main.c                                   |   28 +
 drivers/target/iscsi/iscsi_target.c                             |    9=20
 drivers/target/iscsi/iscsi_target_login.c                       |  149 +++=
++-----
 drivers/target/iscsi/iscsi_target_login.h                       |    2=20
 drivers/usb/gadget/udc/fotg210-udc.c                            |   15 -
 drivers/usb/host/xhci-plat.c                                    |   27 +
 drivers/usb/misc/yurex.c                                        |    3=20
 drivers/xen/cpu_hotplug.c                                       |   15 -
 drivers/xen/events/events_base.c                                |    2=20
 drivers/xen/manage.c                                            |    6=20
 fs/afs/proc.c                                                   |   15 -
 fs/btrfs/ctree.h                                                |    1=20
 fs/btrfs/disk-io.c                                              |    1=20
 fs/btrfs/inode.c                                                |   25 -
 fs/btrfs/ioctl.c                                                |   16 +
 fs/btrfs/volumes.c                                              |    7=20
 fs/ceph/super.c                                                 |   16 -
 fs/cifs/cifs_unicode.c                                          |    3=20
 fs/cifs/cifssmb.c                                               |   11=20
 fs/cifs/misc.c                                                  |    8=20
 fs/cifs/smb2ops.c                                               |    2=20
 fs/dcache.c                                                     |    2=20
 fs/inode.c                                                      |   53 +++
 fs/notify/fsnotify.c                                            |   13=20
 fs/ocfs2/dlm/dlmmaster.c                                        |    4=20
 fs/overlayfs/dir.c                                              |    4=20
 fs/overlayfs/namei.c                                            |    2=20
 fs/overlayfs/overlayfs.h                                        |    4=20
 fs/overlayfs/util.c                                             |    3=20
 fs/proc/base.c                                                  |   14=20
 fs/xattr.c                                                      |   24 -
 include/asm-generic/io.h                                        |    3=20
 include/linux/blk-cgroup.h                                      |    1=20
 include/linux/fs.h                                              |    6=20
 include/net/cfg80211.h                                          |    4=20
 include/net/regulatory.h                                        |    4=20
 kernel/bpf/sockmap.c                                            |   64 ++--
 kernel/bpf/verifier.c                                           |   10=20
 kernel/sched/topology.c                                         |    5=20
 mm/madvise.c                                                    |    2=20
 net/core/filter.c                                               |   57 ++-
 net/ipv4/netfilter/Kconfig                                      |    8=20
 net/mac80211/ibss.c                                             |   22 -
 net/mac80211/main.c                                             |   28 +
 net/mac80211/mesh_hwmp.c                                        |    4=20
 net/mac80211/mlme.c                                             |   70 ++++
 net/mac80211/tx.c                                               |   54 ++-
 net/mac80211/util.c                                             |   11=20
 net/netfilter/Kconfig                                           |   12=20
 net/netfilter/nf_tables_api.c                                   |    1=20
 net/netfilter/nfnetlink_queue.c                                 |    1=20
 net/netfilter/xt_CHECKSUM.c                                     |   22 +
 net/netfilter/xt_cluster.c                                      |   14=20
 net/netfilter/xt_hashlimit.c                                    |   18 -
 net/tipc/diag.c                                                 |    2=20
 net/tipc/netlink.c                                              |    2=20
 net/tipc/socket.c                                               |   76 +++=
--
 net/tipc/socket.h                                               |    2=20
 net/wireless/nl80211.c                                          |   15 -
 net/wireless/reg.c                                              |   91 ---=
---
 net/wireless/util.c                                             |    2=20
 sound/pci/hda/patch_realtek.c                                   |    1=20
 tools/hv/hv_fcopy_daemon.c                                      |    1=20
 tools/kvm/kvm_stat/kvm_stat                                     |   25 +
 tools/perf/arch/powerpc/util/sym-handling.c                     |    4=20
 tools/perf/util/annotate.c                                      |   32 +-
 tools/perf/util/annotate.h                                      |    1=20
 tools/perf/util/evsel.c                                         |    5=20
 tools/perf/util/trace-event-info.c                              |    2=20
 tools/testing/selftests/net/pmtu.sh                             |    7=20
 tools/testing/selftests/rseq/param_test.c                       |   19 -
 tools/testing/selftests/tc-testing/tc-tests/actions/police.json |   48 +++
 tools/vm/page-types.c                                           |    6=20
 tools/vm/slabinfo.c                                             |    4=20
 182 files changed, 1827 insertions(+), 990 deletions(-)

Al Viro (1):
      new primitive: discard_new_inode()

Alexey Khoroshilov (1):
      gpio: dwapb: Fix error handling in dwapb_gpio_probe()

Amir Goldstein (3):
      fsnotify: fix ignore mask logic in fsnotify()
      ovl: fix access beyond unterminated strings
      ovl: fix memory leak on unlink of indexed file

Anand Jain (1):
      btrfs: btrfs_shrink_device should call commit transaction at the end

Andreas Bosch (1):
      HID: intel-ish-hid: Enable Sunrise Point-H ish driver

Andreas Gruenbacher (1):
      sysfs: Do not return POSIX ACL xattrs via listxattr

Andrew Murray (1):
      asm-generic: io: Fix ioport_map() for !CONFIG_GENERIC_IOMAP && CONFIG=
_INDIRECT_PIO

Andy Shevchenko (1):
      gpiolib: acpi: Switch to cansleep version of GPIO library call

Anisse Astier (1):
      HID: i2c-hid: disable runtime PM operations on hantick touchpad

Anton Vasilyev (1):
      usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]

Anurag Kumar Vulisha (1):
      usb: host: xhci-plat: Iterate over parent nodes for finding quirks

Arunk Khandavalli (1):
      cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Ashish Samant (1):
      ocfs2: fix locking for res->tracking and dlm->tracking_list

Aurelien Aptel (1):
      smb2: fix missing files in root share directory listing

Baruch Siach (1):
      net: mvpp2: initialize port of_node pointer

Ben Hutchings (1):
      USB: yurex: Check for truncation in yurex_read()

Ben Skeggs (5):
      drm/nouveau: fix oops in client init failure path
      drm/nouveau/mmu: don't attempt to dereference vmm without valid insta=
nce pointer
      drm/nouveau/TBDdevinit: don't fail when PMU/PRE_OS is missing from VB=
IOS
      drm/nouveau/disp: fix DP disable race
      drm/nouveau/disp/gm200-: enforce identity-mapped SOR assignment for L=
VDS/eDP panels

Bjorn Andersson (1):
      firmware: Always initialize the fw_priv list object

Chris Brandt (1):
      sh_eth: Add R7S9210 support

Chris Phlipot (1):
      perf util: Fix bad memory access in trace info.

Christian K=C3=B6nig (1):
      drm/amdgpu: fix error handling in amdgpu_cs_user_fence_chunk

Cong Wang (2):
      tipc: switch to rhashtable iterator
      netfilter: xt_hashlimit: use s->file instead of s->private

Dan Carpenter (3):
      scsi: aacraid: fix a signedness bug
      cfg80211: fix a type issue in ieee80211_chandef_to_operating_class()
      cifs: read overflow in is_valid_oplock_break()

Danek Duvall (2):
      mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X
      mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Daniel Black (1):
      mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Daniel Borkmann (6):
      bpf, sockmap: fix potential use after free in bpf_tcp_close
      bpf, sockmap: fix psock refcount leak in bpf_tcp_recvmsg
      bpf: fix several offset tests in bpf_msg_pull_data
      bpf: fix msg->data/data_end after sg shift repair in bpf_msg_pull_data
      bpf: fix shift upon scatterlist ring wrap-around in bpf_msg_pull_data
      bpf: fix sg shift repair start offset in bpf_msg_pull_data

Daniel Jurgens (1):
      net/mlx5: Consider PCI domain in search for next dev

David Howells (1):
      afs: Fix cell specification to permit an empty address list

Dennis Zhou (Facebook) (1):
      Revert "blk-throttle: fix race between blkcg_bio_issue_check() and cg=
roup_rmdir()"

Dexuan Cui (1):
      Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()

Dreyfuss, Haim (1):
      mac80211: fix WMM TXOP calculation

Emmanuel Grumbach (3):
      mac80211: fix a race between restart and CSA flows
      mac80211: don't Tx a deauth frame if the AP forbade Tx
      mac80211: shorten the IBSS debug messages

Florian Westphal (2):
      netfilter: xt_checksum: ignore gso skbs
      netfilter: kconfig: nat related expression depend on nftables core

Geert Uytterhoeven (1):
      scsi: libata: Add missing newline at end of file

Greentime Hu (3):
      nds32: fix logic for module
      nds32: fix build error because of wrong semicolon
      nds32: linker script: GCOV kernel may refers data in __exit

Greg Kroah-Hartman (2):
      Revert "drm/amd/pp: Send khz clock values to DC for smu7/8"
      Linux 4.18.13

Guenter Roeck (1):
      riscv: Do not overwrite initrd_start and initrd_end

Haim Dreyfuss (2):
      nl80211: Fix nla_put_u8 to u16 for NL80211_WMMR_TXOP
      nl80211: Pass center frequency in kHz instead of MHz

Hans de Goede (2):
      gpiolib-acpi: Register GpioInt ACPI event handlers from a late_initca=
ll
      HID: sensor-hub: Restore fixup for Lenovo ThinkPad Helix 2 sensor hub=
 report

Harry Mallon (1):
      HID: hid-saitek: Add device ID for RAT 7 Contagion

Harsh Jain (1):
      crypto: chelsio - Fix memory corruption in DMA Mapped buffers.

Heinz Mauelshagen (4):
      dm raid: fix reshape race on small devices
      dm raid: fix stripe adding reshape deadlock
      dm raid: fix rebuild of specific devices by updating superblock
      dm raid: fix RAID leg rebuild errors

Hisao Tanabe (1):
      perf evsel: Fix potential null pointer dereference in perf_evsel__new=
_idx()

Horia Geant=C4=83 (1):
      crypto: caam/jr - fix ablkcipher_edesc pointer arithmetic

Ilan Peer (1):
      mac80211: Fix station bandwidth setting after channel switch

Ilya Dryomov (1):
      ceph: avoid a use-after-free in ceph_destroy_options()

Ivan Mikhaylov (1):
      net/ibm/emac: wrong emac_calc_base call was used by typo

Jacek Tomaka (1):
      perf/x86/intel: Add support/quirk for the MISPREDICT bit on Knights L=
anding CPUs

Jann Horn (3):
      bpf: 32-bit RSH verification must truncate input before the ALU op
      RDMA/ucma: check fd type in ucma_migrate_id()
      proc: restrict kernel stack dumps to root

Jia-Ju Bai (1):
      net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Jinbum Park (1):
      mac80211_hwsim: Fix possible Spectre-v1 for hwsim_world_regdom_custom

Joe Thornber (1):
      dm thin metadata: try to avoid ever aborting transactions

Johannes Berg (3):
      mac80211_hwsim: require at least one channel
      cfg80211: remove division by size of sizeof(struct ieee80211_wmm_rule)
      mac80211: always account for A-MSDU header changes

John Fastabend (2):
      bpf: sockmap, decrement copied count correctly in redirect error case
      bpf: avoid misuse of psock when TCP_ULP_BPF collides with another ULP

Jon Kuhn (1):
      fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Josh Abraham (1):
      xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Julian Wiedmann (1):
      s390/qeth: don't dump past end of unknown HW header

Kai-Heng Feng (3):
      HID: i2c-hid: Don't reset device upon system resume
      r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENAB=
LED
      ALSA: hda/realtek - Cannot adjust speaker's volume on Dell XPS 27 7760

Kim Phillips (1):
      perf annotate: Fix parsing aarch64 branch instructions after objdump =
update

Larry Finger (1):
      b43: fix DMA error related regression with proprietary firmware

Leonard Crestez (1):
      crypto: mxs-dcp - Fix wait logic on chan threads

Lorenzo Bianconi (3):
      mac80211: do not convert to A-MSDU if frag/subframe limited
      mac80211: fix an off-by-one issue in A-MSDU max_subframe computation
      iio: imu: st_lsm6dsx: take into account ts samples in wm configuration

Maciej S. Szmigiero (1):
      r8169: set TxConfig register after TX / RX is enabled, just like RxCo=
nfig

Martin Li=C5=A1ka (1):
      perf annotate: Properly interpret indirect call

Martin Willi (1):
      netfilter: xt_cluster: add dependency on conntrack module

Masahiro Yamada (2):
      i2c: uniphier: issue STOP only for last message or I2C_M_STOP
      i2c: uniphier-f: issue STOP only for last message or I2C_M_STOP

Mathieu Desnoyers (1):
      rseq/selftests: fix parametrized test with -fpie

Matt Ranostay (1):
      Revert "iio: temperature: maxim_thermocouple: add MAX31856 part"

Michael Hennerich (1):
      gpio: adp5588: Fix sleep-in-atomic-context bug

Michal 'vorner' Vaner (1):
      netfilter: nfnetlink_queue: Solve the NFQUEUE/conntrack clash for NF_=
REPEAT

Miguel Ojeda (1):
      arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"

Mike Christie (1):
      scsi: iscsi: target: Fix conn_ops double free

Mike Snitzer (1):
      dm thin metadata: fix __udivdi3 undefined on 32-bit

Miklos Szeredi (3):
      vfs: don't evict uninitialized inode
      ovl: set I_CREATING on inode being created
      ovl: fix format of setxattr debug

Naoya Horiguchi (2):
      tools/vm/slabinfo.c: fix sign-compare warning
      tools/vm/page-types.c: fix "defined but not used" warning

Nathan Chancellor (1):
      cpufreq: qcom-kryo: Fix section annotations

Netanel Belgazal (6):
      net: ena: fix surprise unplug NULL dereference kernel crash
      net: ena: fix driver when PAGE_SIZE =3D=3D 64kB
      net: ena: fix device destruction to gracefully free resources
      net: ena: fix potential double ena_destroy_device()
      net: ena: fix missing lock during device destruction
      net: ena: fix missing calls to READ_ONCE

Nilesh Javali (1):
      scsi: qedi: Add the CRC size within iSCSI NVM image

Olaf Hering (1):
      xen: avoid crash in disable_hotplug_cpu

Paolo Abeni (1):
      tc-testing: add test-cases for numeric and invalid control action

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Peng Li (2):
      net: hns: add the code for cleaning pkt in chip
      net: hns: add netif_carrier_off before change speed and duplex

Randy Dunlap (3):
      arch/hexagon: fix kernel/dma.c build warning
      hexagon: modify ffs() and fls() to return int
      x86/APM: Fix build warning when PROC_FS is not enabled

Ricardo Ribalda Delgado (1):
      gpiolib: Free the last requested descriptor

Rishabh Bhatnagar (1):
      firmware: Fix security issue with request_firmware_into_buf()

Robbie Ko (1):
      Btrfs: fix unexpected failure of nocow buffered writes after snapshot=
ting when low on space

Sabrina Dubroca (2):
      selftests: pmtu: maximum MTU for vti4 is 2^16-1-20
      selftests: pmtu: detect correct binary to ping ipv6 addresses

Sagi Grimberg (1):
      nvmet-rdma: fix possible bogus dereference under heavy load

Sandipan Das (1):
      perf probe powerpc: Ignore SyS symbols irrespective of endianness

Sara Sharon (1):
      mac80211: avoid kernel panic when building AMSDU from non-linear SKB

Sean O'Brien (1):
      HID: add support for Apple Magic Keyboards

Shaohua Li (1):
      md/raid5-cache: disable reshape completely

Singh, Brijesh (1):
      iommu/amd: Clear memory encryption mask from physical address

Somnath Kotur (1):
      bnxt_re: Fix couple of memory leaks that could lead to IOMMU call tra=
ces

Song Liu (1):
      ixgbe: check return value of napi_complete_done()

Srikar Dronamraju (1):
      sched/topology: Set correct NUMA topology type

Stanislaw Gruszka (1):
      cfg80211: make wmm_rule part of the reg_rule structure

Stefan Raspl (3):
      tools/kvm_stat: fix python3 issues
      tools/kvm_stat: fix handling of invalid paths in debugfs provider
      tools/kvm_stat: fix updates for dead guests

Stephen Rothwell (1):
      fs/cifs: suppress a string overflow warning

Sudeep Holla (1):
      firmware: arm_scmi: fix divide by zero when sustained_perf_level is z=
ero

Taehee Yoo (1):
      netfilter: nf_tables: release chain in flushing set

Tao Zhou (1):
      drm/amdgpu: Fix SDMA hang in prt mode v2

Thomas Falcon (1):
      ibmvnic: Include missing return code checks in reset function

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      mac80211: Run TXQ teardown code before de-registering interfaces

Tushar Dave (1):
      bpf: Fix bpf_msg_pull_data()

Varun Prakash (2):
      scsi: csiostor: add a check for NULL pointer after kmalloc()
      scsi: csiostor: fix incorrect port capabilities

Vincent Pelletier (1):
      scsi: iscsi: target: Set conn->sess to NULL when iscsi_login_set_conn=
_values fails

Vincent Whitchurch (1):
      gpio: Fix crash due to registration race

Vitaly Kuznetsov (2):
      xen/manage: don't complain about an empty value in control/sysrq node
      tools: hv: fcopy: set 'error' in case an unknown operation was reques=
ted

Waiman Long (1):
      crypto: qat - Fix KASAN stack-out-of-bounds bug in adf_probe()

Wenjia Zhang (1):
      s390/qeth: use vzalloc for QUERY OAT buffer

Will Deacon (1):
      ARC: atomics: unbork atomic_fetch_##op()

Xiao Ni (1):
      RAID10 BUG_ON in raise_barrier when force is true and conf->barrier i=
s 0

Yuan-Chi Pang (1):
      mac80211: mesh: fix HWMP sequence numbering to follow standard

YueHaibing (1):
      nds32: add NULL entry to the end of_device_id array

Zong Li (2):
      nds32: Fix empty call trace
      nds32: Fix get_user/put_user macro expand pointer problem


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlu9wqIACgkQONu9yGCS
aT7AQw//TaXSUUCFL/YGe8hZVEQGk6i19GJyk+92ubWx+Tj1Ehbo/8fCMftGArs9
ou+iKrYv3PeUBdSJQKfdoUeM1eW1iIsOOFrex34doLdjcIRTaIkurZBuWBwkOjHR
3SgnBZ0QVFg50kHeaL9optBHzh374xReBiCq/OJWBbaPS0lMvV93khPrsMlk7MOB
qAM5Cto4DBgWT1esz9wNRy8yYwr6z4wnxZy1UqXUyg01CYOir1SF2p5hknA74B34
fX1lnxNMMQT5Qq9HQucxJLQBuQGUzel1EvKMIFM4L7Th18rAoA7BxuMt4+aG/jVw
1KheLWW/sQZDyBnInG3UyXt/rkLsjgqgBlAb37XyrEhECLaAuJsguT9eyW/LimUy
4wJUmbJQVWF3rUjBfeG1USNhWOlfvevhgihWpe+fuHPDQtAmbcj3N8aSfw8hSSPb
VpnqpXlfv304+mpz0ilmIKtvbn7gJe8Fw0sjqjvX/vnB+vJ/he5GnkadLV1pe+PQ
WqhAjayNaCGfgQTyG03q79UXDbBZlnaoOdBMKhvReLqMNN/86FW5TfJdWt/Fx1RJ
wH67BOF6FMk9wANMO2bbMhQgLw2e+jgKxTOUCZ+/u+VL0YYPA9/WhD+F/cOSjJef
lK8EXnV24iLpbwLwBKQnpDjF1SeOE1ZPoN8DBk7mYCUJuWlVbPg=
=E9ob
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
