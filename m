Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937CAC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D88521479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+y026zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D88521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730208AbeJIBzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729556AbeJIBzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:55:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52CEC2064A;
        Mon,  8 Oct 2018 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024134;
        bh=Cf+WZP6QlGNtw3/kyoWUeqahdLRgDmG4s/FBA9NWTV0=;
        h=From:To:Cc:Subject:Date:From;
        b=D+y026zoYUGq45bOMLkuxXISchh2cleig17bcM9AodSK0ZlEcDDk0F2nDKHmR4Mi+
         6r3HScdDDWhl6mDNigbM79BQeyMJeESI0FjOFlt+x71crAJ8DjR6KuOQzIbWAXJPkW
         JbApU9rE7XsM8yXEj+bWF38m93KA++nvM8UMCBjk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 00/94] 4.14.75-stable review
Date:   Mon,  8 Oct 2018 20:30:41 +0200
Message-Id: <20181008175605.067676667@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.75-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.75-rc1
X-KernelTest-Deadline: 2018-10-10T17:56+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.14.75 release.
There are 94 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Oct 10 17:55:37 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.75-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.75-rc1

Song Liu <songliubraving@fb.com>
    ixgbe: check return value of napi_complete_done()

Ashish Samant <ashish.samant@oracle.com>
    ocfs2: fix locking for res->tracking and dlm->tracking_list

Jann Horn <jannh@google.com>
    proc: restrict kernel stack dumps to root

Vitaly Kuznetsov <vkuznets@redhat.com>
    tools: hv: fcopy: set 'error' in case an unknown operation was requested

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()

Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
    gpiolib: Free the last requested descriptor

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam/jr - fix ablkcipher_edesc pointer arithmetic

Leonard Crestez <leonard.crestez@nxp.com>
    crypto: mxs-dcp - Fix wait logic on chan threads

Waiman Long <longman@redhat.com>
    crypto: qat - Fix KASAN stack-out-of-bounds bug in adf_probe()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda/realtek - Cannot adjust speaker's volume on Dell XPS 27 7760

Singh, Brijesh <brijesh.singh@amd.com>
    iommu/amd: Clear memory encryption mask from physical address

Aurelien Aptel <aaptel@suse.com>
    smb2: fix missing files in root share directory listing

Andreas Gruenbacher <agruenba@redhat.com>
    sysfs: Do not return POSIX ACL xattrs via listxattr

Miklos Szeredi <mszeredi@redhat.com>
    ovl: fix format of setxattr debug

Amir Goldstein <amir73il@gmail.com>
    ovl: fix memory leak on unlink of indexed file

Amir Goldstein <amir73il@gmail.com>
    ovl: fix access beyond unterminated strings

Josh Abraham <j.abraham1776@gmail.com>
    xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Olaf Hering <olaf@aepfle.de>
    xen: avoid crash in disable_hotplug_cpu

Vitaly Kuznetsov <vkuznets@redhat.com>
    xen/manage: don't complain about an empty value in control/sysrq node

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: read overflow in is_valid_oplock_break()

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: don't dump past end of unknown HW header

Wenjia Zhang <wenjia@linux.ibm.com>
    s390/qeth: use vzalloc for QUERY OAT buffer

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENABLED

Christian König <christian.koenig@amd.com>
    drm/amdgpu: fix error handling in amdgpu_cs_user_fence_chunk

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
    arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"

Randy Dunlap <rdunlap@infradead.org>
    hexagon: modify ffs() and fls() to return int

Randy Dunlap <rdunlap@infradead.org>
    arch/hexagon: fix kernel/dma.c build warning

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: conntrack: timeout interface depend on CONFIG_NF_CONNTRACK_TIMEOUT

Joe Thornber <ejt@redhat.com>
    dm thin metadata: try to avoid ever aborting transactions

Jacek Tomaka <jacek.tomaka@poczta.fm>
    perf/x86/intel: Add support/quirk for the MISPREDICT bit on Knights Landing CPUs

Netanel Belgazal <netanel@amazon.com>
    net: ena: fix missing calls to READ_ONCE

Netanel Belgazal <netanel@amazon.com>
    net: ena: fix driver when PAGE_SIZE == 64kB

Stephen Rothwell <sfr@canb.auug.org.au>
    fs/cifs: suppress a string overflow warning

Heinz Mauelshagen <heinzm@redhat.com>
    dm raid: fix rebuild of specific devices by updating superblock

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/disp: fix DP disable race

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/TBDdevinit: don't fail when PMU/PRE_OS is missing from VBIOS

Daniel Jurgens <danielj@mellanox.com>
    net/mlx5: Consider PCI domain in search for next dev

Sagi Grimberg <sagi@grimberg.me>
    nvmet-rdma: fix possible bogus dereference under heavy load

Ben Hutchings <ben.hutchings@codethink.co.uk>
    USB: yurex: Check for truncation in yurex_read()

Hans de Goede <hdegoede@redhat.com>
    HID: sensor-hub: Restore fixup for Lenovo ThinkPad Helix 2 sensor hub report

Jann Horn <jannh@google.com>
    RDMA/ucma: check fd type in ucma_migrate_id()

Matt Ranostay <matt.ranostay@konsulko.com>
    Revert "iio: temperature: maxim_thermocouple: add MAX31856 part"

Taehee Yoo <ap420073@gmail.com>
    netfilter: nf_tables: release chain in flushing set

Sandipan Das <sandipan@linux.ibm.com>
    perf probe powerpc: Ignore SyS symbols irrespective of endianness

Chris Phlipot <cphlipot0@gmail.com>
    perf util: Fix bad memory access in trace info.

Hisao Tanabe <xtanabe@gmail.com>
    perf evsel: Fix potential null pointer dereference in perf_evsel__new_idx()

Nilesh Javali <nilesh.javali@cavium.com>
    scsi: qedi: Add the CRC size within iSCSI NVM image

Vincent Pelletier <plr.vincent@gmail.com>
    scsi: iscsi: target: Set conn->sess to NULL when iscsi_login_set_conn_values fails

Harry Mallon <hjmallon@gmail.com>
    HID: hid-saitek: Add device ID for RAT 7 Contagion

Stephen Boyd <swboyd@chromium.org>
    pinctrl: msm: Really mask level interrupts to prevent latching

Anton Vasilyev <vasilyev@ispras.ru>
    usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]

Sean O'Brien <seobrien@chromium.org>
    HID: add support for Apple Magic Keyboards

Martin Willi <martin@strongswan.org>
    netfilter: xt_cluster: add dependency on conntrack module

Jann Horn <jannh@google.com>
    bpf: 32-bit RSH verification must truncate input before the ALU op

Daniel Black <daniel@linux.ibm.com>
    mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    tools/vm/page-types.c: fix "defined but not used" warning

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    tools/vm/slabinfo.c: fix sign-compare warning

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: shorten the IBSS debug messages

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: don't Tx a deauth frame if the AP forbade Tx

Ilan Peer <ilan.peer@intel.com>
    mac80211: Fix station bandwidth setting after channel switch

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: fix a race between restart and CSA flows

Dan Carpenter <dan.carpenter@oracle.com>
    cfg80211: fix a type issue in ieee80211_chandef_to_operating_class()

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mac80211: fix an off-by-one issue in A-MSDU max_subframe computation

Jon Kuhn <jkuhn@barracuda.com>
    fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Jia-Ju Bai <baijiaju1990@gmail.com>
    net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Masahiro Yamada <yamada.masahiro@socionext.com>
    i2c: uniphier-f: issue STOP only for last message or I2C_M_STOP

Masahiro Yamada <yamada.masahiro@socionext.com>
    i2c: uniphier: issue STOP only for last message or I2C_M_STOP

Xiao Ni <xni@redhat.com>
    RAID10 BUG_ON in raise_barrier when force is true and conf->barrier is 0

Shaohua Li <shli@fb.com>
    md/raid5-cache: disable reshape completely

Will Deacon <will.deacon@arm.com>
    ARC: atomics: unbork atomic_fetch_##op()

Vincent Whitchurch <vincent.whitchurch@axis.com>
    gpio: Fix crash due to registration race

Stefan Raspl <stefan.raspl@de.ibm.com>
    tools/kvm_stat: fix handling of invalid paths in debugfs provider

Stefan Raspl <stefan.raspl@de.ibm.com>
    tools/kvm_stat: fix python3 issues

Johannes Berg <johannes.berg@intel.com>
    mac80211: always account for A-MSDU header changes

Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
    mac80211: do not convert to A-MSDU if frag/subframe limited

Arunk Khandavalli <akhandav@codeaurora.org>
    cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Peng Li <lipeng321@huawei.com>
    net: hns: add netif_carrier_off before change speed and duplex

Peng Li <lipeng321@huawei.com>
    net: hns: add the code for cleaning pkt in chip

Hans de Goede <hdegoede@redhat.com>
    gpiolib-acpi: Register GpioInt ACPI event handlers from a late_initcall

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    gpiolib: acpi: Switch to cansleep version of GPIO library call

Sara Sharon <sara.sharon@intel.com>
    mac80211: avoid kernel panic when building AMSDU from non-linear SKB

Yuan-Chi Pang <fu3mo6goo@gmail.com>
    mac80211: mesh: fix HWMP sequence numbering to follow standard

Michael Hennerich <michael.hennerich@analog.com>
    gpio: adp5588: Fix sleep-in-atomic-context bug

Danek Duvall <duvall@comfychair.org>
    mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Danek Duvall <duvall@comfychair.org>
    mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Varun Prakash <varun@chelsio.com>
    scsi: csiostor: add a check for NULL pointer after kmalloc()

Anand Jain <anand.jain@oracle.com>
    btrfs: btrfs_shrink_device should call commit transaction at the end

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Johannes Berg <johannes.berg@intel.com>
    mac80211_hwsim: require at least one channel

Toke Høiland-Jørgensen <toke@toke.dk>
    mac80211: Run TXQ teardown code before de-registering interfaces

Len Brown <len.brown@intel.com>
    tools/power turbostat: fix possible sprintf buffer overflow

Jan Kiszka <jan.kiszka@siemens.com>
    serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Alex Deucher <alexander.deucher@amd.com>
    drm/amdgpu: add another ATPX quirk for TOPAZ

Colin Ian King <colin.king@canonical.com>
    drm/amd/pp: initialize result to before or'ing in data


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arc/include/asm/atomic.h                      |  2 +-
 arch/arm64/include/asm/jump_label.h                |  4 +-
 arch/hexagon/include/asm/bitops.h                  |  4 +-
 arch/hexagon/kernel/dma.c                          |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |  2 +-
 arch/x86/events/intel/lbr.c                        |  4 +
 drivers/crypto/caam/caamalg.c                      |  8 +-
 drivers/crypto/mxs-dcp.c                           | 53 +++++++------
 drivers/crypto/qat/qat_c3xxx/adf_drv.c             |  6 +-
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c           |  6 +-
 drivers/crypto/qat/qat_c62x/adf_drv.c              |  6 +-
 drivers/crypto/qat/qat_c62xvf/adf_drv.c            |  6 +-
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c          |  6 +-
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c        |  6 +-
 drivers/gpio/gpio-adp5588.c                        | 24 +++++-
 drivers/gpio/gpiolib-acpi.c                        | 86 +++++++++++++---------
 drivers/gpio/gpiolib-of.c                          |  1 +
 drivers/gpio/gpiolib.c                             |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c   |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             | 23 ++++--
 .../gpu/drm/amd/powerplay/hwmgr/vega10_powertune.c |  2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/dp.c      | 17 +++--
 drivers/gpu/drm/nouveau/nvkm/engine/disp/nv50.c    |  6 +-
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.c    |  2 +
 drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h    |  3 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c    |  3 +-
 drivers/hid/hid-apple.c                            |  9 ++-
 drivers/hid/hid-ids.h                              |  3 +
 drivers/hid/hid-saitek.c                           |  2 +
 drivers/hid/hid-sensor-hub.c                       | 23 ++++++
 drivers/hv/connection.c                            |  8 +-
 drivers/i2c/busses/i2c-uniphier-f.c                |  7 +-
 drivers/i2c/busses/i2c-uniphier.c                  |  7 +-
 drivers/iio/temperature/maxim_thermocouple.c       |  1 -
 drivers/infiniband/core/ucma.c                     |  6 ++
 drivers/iommu/amd_iommu.c                          |  2 +-
 drivers/md/dm-raid.c                               |  5 ++
 drivers/md/dm-thin-metadata.c                      | 36 ++++++++-
 drivers/md/dm-thin.c                               | 73 ++++++++++++++++--
 drivers/md/raid10.c                                |  5 +-
 drivers/md/raid5-log.h                             |  5 ++
 drivers/md/raid5.c                                 |  6 +-
 drivers/net/ethernet/amazon/ena/ena_com.c          |  8 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       | 10 +--
 drivers/net/ethernet/amazon/ena/ena_netdev.h       | 11 +++
 drivers/net/ethernet/cadence/macb_main.c           |  2 +-
 drivers/net/ethernet/hisilicon/hns/hnae.h          |  2 +
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c  | 67 ++++++++++++++++-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_gmac.c | 36 +++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c  | 44 +++++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.h  |  8 ++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 29 ++++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.h |  3 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c  | 23 ++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.h  |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c  | 23 ++++++
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h  |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h  |  1 +
 drivers/net/ethernet/hisilicon/hns/hns_enet.c      | 21 +++++-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |  2 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      | 12 +--
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  7 +-
 drivers/net/ethernet/realtek/r8169.c               |  9 ++-
 drivers/net/wireless/mac80211_hwsim.c              |  8 +-
 drivers/nvme/target/rdma.c                         | 27 ++++++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 | 24 ++++++
 drivers/s390/net/qeth_core_main.c                  |  5 +-
 drivers/s390/net/qeth_l2_main.c                    |  2 +-
 drivers/s390/net/qeth_l3_main.c                    |  2 +-
 drivers/scsi/csiostor/csio_hw.c                    | 16 ++--
 drivers/scsi/qedi/qedi.h                           |  7 +-
 drivers/scsi/qedi/qedi_main.c                      | 28 +++----
 drivers/target/iscsi/iscsi_target_login.c          |  8 +-
 drivers/tty/serial/mvebu-uart.c                    |  4 +-
 drivers/usb/gadget/udc/fotg210-udc.c               | 15 ++--
 drivers/usb/misc/yurex.c                           |  3 +
 drivers/xen/cpu_hotplug.c                          | 15 ++--
 drivers/xen/events/events_base.c                   |  2 +-
 drivers/xen/manage.c                               |  6 +-
 fs/btrfs/volumes.c                                 |  7 +-
 fs/cifs/cifs_unicode.c                             |  3 -
 fs/cifs/cifssmb.c                                  | 11 ++-
 fs/cifs/misc.c                                     |  8 ++
 fs/cifs/smb2ops.c                                  |  2 +-
 fs/ocfs2/dlm/dlmmaster.c                           |  4 +-
 fs/overlayfs/namei.c                               |  2 +-
 fs/overlayfs/overlayfs.h                           |  4 +-
 fs/overlayfs/util.c                                |  3 +-
 fs/proc/base.c                                     | 14 ++++
 fs/xattr.c                                         | 24 +++---
 kernel/bpf/verifier.c                              | 10 ++-
 mm/madvise.c                                       |  2 +-
 net/ipv4/netfilter/nf_conntrack_proto_icmp.c       |  8 +-
 net/ipv6/netfilter/nf_conntrack_proto_icmpv6.c     |  8 +-
 net/mac80211/ibss.c                                | 22 +++---
 net/mac80211/main.c                                | 28 +++++--
 net/mac80211/mesh_hwmp.c                           |  4 +
 net/mac80211/mlme.c                                | 70 +++++++++++++++++-
 net/mac80211/tx.c                                  | 54 ++++++++------
 net/netfilter/nf_conntrack_proto_dccp.c            | 12 +--
 net/netfilter/nf_conntrack_proto_generic.c         |  8 +-
 net/netfilter/nf_conntrack_proto_gre.c             |  8 +-
 net/netfilter/nf_conntrack_proto_sctp.c            | 14 ++--
 net/netfilter/nf_conntrack_proto_tcp.c             | 12 +--
 net/netfilter/nf_conntrack_proto_udp.c             | 20 ++---
 net/netfilter/nf_tables_api.c                      |  1 +
 net/netfilter/xt_cluster.c                         | 14 +++-
 net/wireless/nl80211.c                             |  1 +
 net/wireless/util.c                                |  2 +-
 sound/pci/hda/patch_realtek.c                      |  1 +
 tools/hv/hv_fcopy_daemon.c                         |  1 +
 tools/kvm/kvm_stat/kvm_stat                        | 14 +++-
 tools/perf/arch/powerpc/util/sym-handling.c        |  4 +-
 tools/perf/util/evsel.c                            |  5 +-
 tools/perf/util/trace-event-info.c                 |  2 +-
 tools/power/x86/turbostat/turbostat.c              |  2 +-
 tools/vm/page-types.c                              |  6 --
 tools/vm/slabinfo.c                                |  4 +-
 119 files changed, 1046 insertions(+), 352 deletions(-)


