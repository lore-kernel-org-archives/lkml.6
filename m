Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF949C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B51D214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEIsmUDb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B51D214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbeJJQeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJJQeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:34:07 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D79520645;
        Wed, 10 Oct 2018 09:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539162771;
        bh=cTPK7LxA5en6g4A/doe4hTdaFxVkx0SJZfVbdN4paG0=;
        h=Date:From:To:Cc:Subject:From;
        b=cEIsmUDbUcTgzVeoi+werCLGZr85vtOZlgrkThDNiTQLdsq6NgfJWmNbMP8tLUkxs
         C0posV2I76I8aRLDJoOldceJUFhKCu2wh3MDskaYAfb94fsZWbTmIeOsnYH4CdmktS
         014C95m43UWX3ibXfC/S+1fuTvWWm28UzCCsPNHk=
Date:   Wed, 10 Oct 2018 11:12:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.75
Message-ID: <20181010091249.GA2738@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.75 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                               |    2=20
 arch/arc/include/asm/atomic.h                          |    2=20
 arch/arm64/include/asm/jump_label.h                    |    4=20
 arch/hexagon/include/asm/bitops.h                      |    4=20
 arch/hexagon/kernel/dma.c                              |    2=20
 arch/powerpc/kvm/book3s_64_mmu_hv.c                    |    2=20
 arch/x86/events/intel/lbr.c                            |    4=20
 drivers/crypto/caam/caamalg.c                          |    8 -
 drivers/crypto/mxs-dcp.c                               |   53 +++++-----
 drivers/crypto/qat/qat_c3xxx/adf_drv.c                 |    6 -
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c               |    6 -
 drivers/crypto/qat/qat_c62x/adf_drv.c                  |    6 -
 drivers/crypto/qat/qat_c62xvf/adf_drv.c                |    6 -
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c              |    6 -
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c            |    6 -
 drivers/gpio/gpio-adp5588.c                            |   24 +++-
 drivers/gpio/gpiolib-acpi.c                            |   86 +++++++++---=
-----
 drivers/gpio/gpiolib-of.c                              |    1=20
 drivers/gpio/gpiolib.c                                 |    2=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c       |    1=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c                 |   23 ++--
 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |    2=20
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c          |   17 ++-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c        |    6 -
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c        |    2=20
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h        |    3=20
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c    |    3=20
 drivers/hid/hid-apple.c                                |    9 +
 drivers/hid/hid-ids.h                                  |    3=20
 drivers/hid/hid-saitek.c                               |    2=20
 drivers/hid/hid-sensor-hub.c                           |   23 ++++
 drivers/hv/connection.c                                |    8 -
 drivers/i2c/busses/i2c-uniphier-f.c                    |    7 -
 drivers/i2c/busses/i2c-uniphier.c                      |    7 -
 drivers/iio/temperature/maxim_thermocouple.c           |    1=20
 drivers/infiniband/core/ucma.c                         |    6 +
 drivers/iommu/amd_iommu.c                              |    2=20
 drivers/md/dm-raid.c                                   |    5=20
 drivers/md/dm-thin-metadata.c                          |   34 ++++++
 drivers/md/dm-thin.c                                   |   73 ++++++++++++=
--
 drivers/md/raid10.c                                    |    5=20
 drivers/md/raid5-log.h                                 |    5=20
 drivers/md/raid5.c                                     |    6 -
 drivers/net/ethernet/amazon/ena/ena_com.c              |    8 -
 drivers/net/ethernet/amazon/ena/ena_netdev.c           |   10 -
 drivers/net/ethernet/amazon/ena/ena_netdev.h           |   11 ++
 drivers/net/ethernet/cadence/macb_main.c               |    2=20
 drivers/net/ethernet/hisilicon/hns/hnae.h              |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c      |   67 +++++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c     |   36 +++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c      |   44 ++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h      |    8 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c     |   29 +++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h     |    3=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c      |   23 ++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h      |    1=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c      |   23 ++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h      |    1=20
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h      |    1=20
 drivers/net/ethernet/hisilicon/hns/hns_enet.c          |   21 +++-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c       |    2=20
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c          |   12 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c          |    7 -
 drivers/net/ethernet/realtek/r8169.c                   |    9 +
 drivers/net/wireless/mac80211_hwsim.c                  |    8 -
 drivers/nvme/target/rdma.c                             |   27 ++++-
 drivers/s390/net/qeth_core_main.c                      |    5=20
 drivers/s390/net/qeth_l2_main.c                        |    2=20
 drivers/s390/net/qeth_l3_main.c                        |    2=20
 drivers/scsi/csiostor/csio_hw.c                        |   16 +--
 drivers/scsi/qedi/qedi.h                               |    7 +
 drivers/scsi/qedi/qedi_main.c                          |   28 ++---
 drivers/target/iscsi/iscsi_target_login.c              |    8 -
 drivers/tty/serial/mvebu-uart.c                        |    4=20
 drivers/usb/gadget/udc/fotg210-udc.c                   |   15 +-
 drivers/usb/misc/yurex.c                               |    3=20
 drivers/xen/cpu_hotplug.c                              |   15 +-
 drivers/xen/events/events_base.c                       |    2=20
 drivers/xen/manage.c                                   |    6 -
 fs/btrfs/volumes.c                                     |    7 +
 fs/cifs/cifs_unicode.c                                 |    3=20
 fs/cifs/cifssmb.c                                      |   11 +-
 fs/cifs/misc.c                                         |    8 +
 fs/cifs/smb2ops.c                                      |    2=20
 fs/ocfs2/dlm/dlmmaster.c                               |    4=20
 fs/overlayfs/namei.c                                   |    2=20
 fs/overlayfs/overlayfs.h                               |    4=20
 fs/overlayfs/util.c                                    |    3=20
 fs/proc/base.c                                         |   14 ++
 fs/xattr.c                                             |   24 ++--
 kernel/bpf/verifier.c                                  |   10 +
 mm/madvise.c                                           |    2=20
 net/mac80211/ibss.c                                    |   22 ++--
 net/mac80211/main.c                                    |   28 ++++-
 net/mac80211/mesh_hwmp.c                               |    4=20
 net/mac80211/mlme.c                                    |   70 +++++++++++++
 net/mac80211/tx.c                                      |   54 +++++-----
 net/netfilter/nf_tables_api.c                          |    1=20
 net/netfilter/xt_cluster.c                             |   14 ++
 net/wireless/nl80211.c                                 |    1=20
 net/wireless/util.c                                    |    2=20
 sound/pci/hda/patch_realtek.c                          |    1=20
 tools/hv/hv_fcopy_daemon.c                             |    1=20
 tools/kvm/kvm_stat/kvm_stat                            |   14 ++
 tools/perf/arch/powerpc/util/sym-handling.c            |    4=20
 tools/perf/util/evsel.c                                |    5=20
 tools/perf/util/trace-event-info.c                     |    2=20
 tools/power/x86/turbostat/turbostat.c                  |    2=20
 tools/vm/page-types.c                                  |    6 -
 tools/vm/slabinfo.c                                    |    4=20
 110 files changed, 974 insertions(+), 306 deletions(-)

Alex Deucher (1):
      drm/amdgpu: add another ATPX quirk for TOPAZ

Amir Goldstein (2):
      ovl: fix access beyond unterminated strings
      ovl: fix memory leak on unlink of indexed file

Anand Jain (1):
      btrfs: btrfs_shrink_device should call commit transaction at the end

Andreas Gruenbacher (1):
      sysfs: Do not return POSIX ACL xattrs via listxattr

Andy Shevchenko (1):
      gpiolib: acpi: Switch to cansleep version of GPIO library call

Anton Vasilyev (1):
      usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]

Arunk Khandavalli (1):
      cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Ashish Samant (1):
      ocfs2: fix locking for res->tracking and dlm->tracking_list

Aurelien Aptel (1):
      smb2: fix missing files in root share directory listing

Ben Hutchings (1):
      USB: yurex: Check for truncation in yurex_read()

Ben Skeggs (2):
      drm/nouveau/TBDdevinit: don't fail when PMU/PRE_OS is missing from VB=
IOS
      drm/nouveau/disp: fix DP disable race

Chris Phlipot (1):
      perf util: Fix bad memory access in trace info.

Christian K=C3=B6nig (1):
      drm/amdgpu: fix error handling in amdgpu_cs_user_fence_chunk

Colin Ian King (1):
      drm/amd/pp: initialize result to before or'ing in data

Dan Carpenter (2):
      cfg80211: fix a type issue in ieee80211_chandef_to_operating_class()
      cifs: read overflow in is_valid_oplock_break()

Danek Duvall (2):
      mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X
      mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Daniel Black (1):
      mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Daniel Jurgens (1):
      net/mlx5: Consider PCI domain in search for next dev

Dexuan Cui (1):
      Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()

Emmanuel Grumbach (3):
      mac80211: fix a race between restart and CSA flows
      mac80211: don't Tx a deauth frame if the AP forbade Tx
      mac80211: shorten the IBSS debug messages

Greg Kroah-Hartman (1):
      Linux 4.14.75

Hans de Goede (2):
      gpiolib-acpi: Register GpioInt ACPI event handlers from a late_initca=
ll
      HID: sensor-hub: Restore fixup for Lenovo ThinkPad Helix 2 sensor hub=
 report

Harry Mallon (1):
      HID: hid-saitek: Add device ID for RAT 7 Contagion

Heinz Mauelshagen (1):
      dm raid: fix rebuild of specific devices by updating superblock

Hisao Tanabe (1):
      perf evsel: Fix potential null pointer dereference in perf_evsel__new=
_idx()

Horia Geant=C4=83 (1):
      crypto: caam/jr - fix ablkcipher_edesc pointer arithmetic

Ilan Peer (1):
      mac80211: Fix station bandwidth setting after channel switch

Jacek Tomaka (1):
      perf/x86/intel: Add support/quirk for the MISPREDICT bit on Knights L=
anding CPUs

Jan Kiszka (1):
      serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Jann Horn (3):
      bpf: 32-bit RSH verification must truncate input before the ALU op
      RDMA/ucma: check fd type in ucma_migrate_id()
      proc: restrict kernel stack dumps to root

Jia-Ju Bai (1):
      net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Joe Thornber (1):
      dm thin metadata: try to avoid ever aborting transactions

Johannes Berg (2):
      mac80211_hwsim: require at least one channel
      mac80211: always account for A-MSDU header changes

Jon Kuhn (1):
      fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Josh Abraham (1):
      xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Julian Wiedmann (1):
      s390/qeth: don't dump past end of unknown HW header

Kai-Heng Feng (2):
      r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENAB=
LED
      ALSA: hda/realtek - Cannot adjust speaker's volume on Dell XPS 27 7760

Len Brown (1):
      tools/power turbostat: fix possible sprintf buffer overflow

Leonard Crestez (1):
      crypto: mxs-dcp - Fix wait logic on chan threads

Lorenzo Bianconi (2):
      mac80211: do not convert to A-MSDU if frag/subframe limited
      mac80211: fix an off-by-one issue in A-MSDU max_subframe computation

Martin Willi (1):
      netfilter: xt_cluster: add dependency on conntrack module

Masahiro Yamada (2):
      i2c: uniphier: issue STOP only for last message or I2C_M_STOP
      i2c: uniphier-f: issue STOP only for last message or I2C_M_STOP

Matt Ranostay (1):
      Revert "iio: temperature: maxim_thermocouple: add MAX31856 part"

Michael Hennerich (1):
      gpio: adp5588: Fix sleep-in-atomic-context bug

Miguel Ojeda (1):
      arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"

Mike Snitzer (1):
      dm thin metadata: fix __udivdi3 undefined on 32-bit

Miklos Szeredi (1):
      ovl: fix format of setxattr debug

Naoya Horiguchi (2):
      tools/vm/slabinfo.c: fix sign-compare warning
      tools/vm/page-types.c: fix "defined but not used" warning

Netanel Belgazal (2):
      net: ena: fix driver when PAGE_SIZE =3D=3D 64kB
      net: ena: fix missing calls to READ_ONCE

Nilesh Javali (1):
      scsi: qedi: Add the CRC size within iSCSI NVM image

Olaf Hering (1):
      xen: avoid crash in disable_hotplug_cpu

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Peng Li (2):
      net: hns: add the code for cleaning pkt in chip
      net: hns: add netif_carrier_off before change speed and duplex

Randy Dunlap (2):
      arch/hexagon: fix kernel/dma.c build warning
      hexagon: modify ffs() and fls() to return int

Ricardo Ribalda Delgado (1):
      gpiolib: Free the last requested descriptor

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

Song Liu (1):
      ixgbe: check return value of napi_complete_done()

Stefan Raspl (2):
      tools/kvm_stat: fix python3 issues
      tools/kvm_stat: fix handling of invalid paths in debugfs provider

Stephen Rothwell (1):
      fs/cifs: suppress a string overflow warning

Taehee Yoo (1):
      netfilter: nf_tables: release chain in flushing set

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      mac80211: Run TXQ teardown code before de-registering interfaces

Varun Prakash (1):
      scsi: csiostor: add a check for NULL pointer after kmalloc()

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


--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlu9wpEACgkQONu9yGCS
aT4zXhAAucW+1BoGA68vSfz0YCx5R+eMEjvBiqt4nPAeWxtvKDPsal61vj7vuhLU
2JFjmDLl1N5NOn5TYB6MhUKBc7Q86EDpdRADSP59NBB69gnF7aXsZylj9IJQQgU9
BVwOkv9f5YRY97ycTKAtxzfgomh850OS9nzdD0HQ7Gzg4kc0ssRcmY2983Fh1MR1
og2Vm5wD8QHE5JTXG8WLWZvDA2TGO9PwU956Op+Unc3aWK9Gk+WjOvxzna5M9JQB
4Upym1+LXk6VS4PNzOB6CEJLQNx9/MttU8jr6RObSFMuAhMLbw3hNuWm9tlYn0Qx
vc8IDDnmHuAKV/PaqlR67jmxx2r6DaqXR7eyfYynD2ry0SHRT85rb1jfiXrKz+kr
BQNcGPj4U+Jiu/PqvMPe1Pz/1Dli/WxjVez+7XOzSpn5tUpY2mXLtHPlED+YbHdS
0qb64mst9Vncd0r3Gvb26Tl3jMCgUIAC9e9BK2bMulJZT5H91RMOSuxZ3dY3yIgJ
SVyo7N8F8nAUqVflW8RGPou4tOrPT3zeMpcHWK/haVc/rN66BOcnU0UnygGjk+PQ
7+vpF+lIZvCZFZ1HWd0gn0qZsV+QK+UFHA48so3VyiUvr3+JNONh4YI5wiakFs3d
gaU09x1XjYNE7VJG17p4quSZXfvQAAKKSmlnFhLiFUl23qm2b8I=
=FF8M
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
