Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B45C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83314214C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzhzeith"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83314214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbeJIBv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbeJIBvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:51:55 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F5BA21479;
        Mon,  8 Oct 2018 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023930;
        bh=L+dmG+aLtXn+aif0szyS1M/qRG3rRTvysFMaPHFKhKY=;
        h=From:To:Cc:Subject:Date:From;
        b=bzhzeithhkdvfuw/lArV8Ang7eITSC5OtaUUbC2jJJc9a5CI40AsymRsZIKj9H/XW
         5CUygYEOtOVRuR4HzEDe+itnqHkWAjbwLt0Z1wefteWxjowdZ8rhd8uKdJzN/HXnJp
         MyQh+kK2jOsBWYaCccJna1JH/bIHS3S5qgXNPxcU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/59] 4.9.132-stable review
Date:   Mon,  8 Oct 2018 20:31:07 +0200
Message-Id: <20181008175546.620836256@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.132-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.132-rc1
X-KernelTest-Deadline: 2018-10-10T17:55+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.132 release.
There are 59 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Oct 10 17:55:28 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.132-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.132-rc1

Ashish Samant <ashish.samant@oracle.com>
    ocfs2: fix locking for res->tracking and dlm->tracking_list

Jann Horn <jannh@google.com>
    proc: restrict kernel stack dumps to root

Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
    gpiolib: Free the last requested descriptor

Leonard Crestez <leonard.crestez@nxp.com>
    crypto: mxs-dcp - Fix wait logic on chan threads

Waiman Long <longman@redhat.com>
    crypto: qat - Fix KASAN stack-out-of-bounds bug in adf_probe()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda/realtek - Cannot adjust speaker's volume on Dell XPS 27 7760

Aurelien Aptel <aaptel@suse.com>
    smb2: fix missing files in root share directory listing

Andreas Gruenbacher <agruenba@redhat.com>
    sysfs: Do not return POSIX ACL xattrs via listxattr

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

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
    arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"

Randy Dunlap <rdunlap@infradead.org>
    hexagon: modify ffs() and fls() to return int

Randy Dunlap <rdunlap@infradead.org>
    arch/hexagon: fix kernel/dma.c build warning

Joe Thornber <ejt@redhat.com>
    dm thin metadata: try to avoid ever aborting transactions

Jacek Tomaka <jacek.tomaka@poczta.fm>
    perf/x86/intel: Add support/quirk for the MISPREDICT bit on Knights Landing CPUs

Netanel Belgazal <netanel@amazon.com>
    net: ena: fix driver when PAGE_SIZE == 64kB

Stephen Rothwell <sfr@canb.auug.org.au>
    fs/cifs: suppress a string overflow warning

Heinz Mauelshagen <heinzm@redhat.com>
    dm raid: fix rebuild of specific devices by updating superblock

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/TBDdevinit: don't fail when PMU/PRE_OS is missing from VBIOS

Daniel Jurgens <danielj@mellanox.com>
    net/mlx5: Consider PCI domain in search for next dev

Sagi Grimberg <sagi@grimberg.me>
    nvmet-rdma: fix possible bogus dereference under heavy load

Ben Hutchings <ben.hutchings@codethink.co.uk>
    USB: yurex: Check for truncation in yurex_read()

Jann Horn <jannh@google.com>
    RDMA/ucma: check fd type in ucma_migrate_id()

Sandipan Das <sandipan@linux.ibm.com>
    perf probe powerpc: Ignore SyS symbols irrespective of endianness

Hisao Tanabe <xtanabe@gmail.com>
    perf evsel: Fix potential null pointer dereference in perf_evsel__new_idx()

Harry Mallon <hjmallon@gmail.com>
    HID: hid-saitek: Add device ID for RAT 7 Contagion

Stephen Boyd <swboyd@chromium.org>
    pinctrl: msm: Really mask level interrupts to prevent latching

Anton Vasilyev <vasilyev@ispras.ru>
    usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]

Sean O'Brien <seobrien@chromium.org>
    HID: add support for Apple Magic Keyboards

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

Will Deacon <will.deacon@arm.com>
    ARC: atomics: unbork atomic_fetch_##op()

Vincent Whitchurch <vincent.whitchurch@axis.com>
    gpio: Fix crash due to registration race

Arunk Khandavalli <akhandav@codeaurora.org>
    cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Peng Li <lipeng321@huawei.com>
    net: hns: add netif_carrier_off before change speed and duplex

Yuan-Chi Pang <fu3mo6goo@gmail.com>
    mac80211: mesh: fix HWMP sequence numbering to follow standard

Michael Hennerich <michael.hennerich@analog.com>
    gpio: adp5588: Fix sleep-in-atomic-context bug

Danek Duvall <duvall@comfychair.org>
    mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Danek Duvall <duvall@comfychair.org>
    mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Toke Høiland-Jørgensen <toke@toke.dk>
    mac80211: Run TXQ teardown code before de-registering interfaces

Frederic Weisbecker <fweisbec@gmail.com>
    time: Introduce jiffies64_to_nsecs()

Jan Kiszka <jan.kiszka@siemens.com>
    serial: mvebu-uart: Fix reporting of effective CSIZE to userspace


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arc/include/asm/atomic.h                      |  2 +-
 arch/arm64/include/asm/jump_label.h                |  4 +-
 arch/hexagon/include/asm/bitops.h                  |  4 +-
 arch/hexagon/kernel/dma.c                          |  2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |  2 +-
 arch/x86/events/intel/lbr.c                        |  4 ++
 drivers/crypto/mxs-dcp.c                           | 53 +++++++++-------
 drivers/crypto/qat/qat_c3xxx/adf_drv.c             |  6 +-
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c           |  6 +-
 drivers/crypto/qat/qat_c62x/adf_drv.c              |  6 +-
 drivers/crypto/qat/qat_c62xvf/adf_drv.c            |  6 +-
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c          |  6 +-
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c        |  6 +-
 drivers/gpio/gpio-adp5588.c                        | 24 +++++--
 drivers/gpio/gpiolib-of.c                          |  1 +
 drivers/gpio/gpiolib.c                             |  2 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c    |  3 +-
 drivers/hid/hid-apple.c                            |  9 ++-
 drivers/hid/hid-ids.h                              |  3 +
 drivers/hid/hid-saitek.c                           |  2 +
 drivers/i2c/busses/i2c-uniphier-f.c                |  7 +--
 drivers/i2c/busses/i2c-uniphier.c                  |  7 +--
 drivers/infiniband/core/ucma.c                     |  6 ++
 drivers/md/dm-raid.c                               |  5 ++
 drivers/md/dm-thin-metadata.c                      | 36 ++++++++++-
 drivers/md/dm-thin.c                               | 73 +++++++++++++++++++---
 drivers/md/raid10.c                                |  5 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c       | 10 +--
 drivers/net/ethernet/amazon/ena/ena_netdev.h       | 11 ++++
 drivers/net/ethernet/cadence/macb.c                |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c   |  2 +
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |  7 ++-
 drivers/net/ethernet/realtek/r8169.c               |  9 ++-
 drivers/net/wireless/mac80211_hwsim.c              |  3 -
 drivers/nvme/target/rdma.c                         | 27 +++++++-
 drivers/pinctrl/qcom/pinctrl-msm.c                 | 24 +++++++
 drivers/s390/net/qeth_core_main.c                  |  5 +-
 drivers/s390/net/qeth_l2_main.c                    |  2 +-
 drivers/s390/net/qeth_l3_main.c                    |  2 +-
 drivers/tty/serial/mvebu-uart.c                    |  4 +-
 drivers/usb/gadget/udc/fotg210-udc.c               | 15 +++--
 drivers/usb/misc/yurex.c                           |  3 +
 drivers/xen/cpu_hotplug.c                          | 15 ++---
 drivers/xen/events/events_base.c                   |  2 +-
 drivers/xen/manage.c                               |  6 +-
 fs/cifs/cifs_unicode.c                             |  3 -
 fs/cifs/cifssmb.c                                  | 11 +++-
 fs/cifs/misc.c                                     |  8 +++
 fs/cifs/smb2ops.c                                  |  2 +-
 fs/ocfs2/dlm/dlmmaster.c                           |  4 +-
 fs/proc/base.c                                     | 14 +++++
 fs/xattr.c                                         | 24 +++----
 include/linux/jiffies.h                            |  2 +
 kernel/time/time.c                                 | 10 +++
 kernel/time/timeconst.bc                           |  6 ++
 mm/madvise.c                                       |  2 +-
 net/mac80211/ibss.c                                | 22 +++----
 net/mac80211/main.c                                | 28 +++++++--
 net/mac80211/mesh_hwmp.c                           |  4 ++
 net/mac80211/mlme.c                                | 70 ++++++++++++++++++++-
 net/wireless/nl80211.c                             |  1 +
 net/wireless/util.c                                |  2 +-
 sound/pci/hda/patch_realtek.c                      |  1 +
 tools/perf/arch/powerpc/util/sym-handling.c        |  4 +-
 tools/perf/util/evsel.c                            |  5 +-
 tools/vm/page-types.c                              |  6 --
 tools/vm/slabinfo.c                                |  4 +-
 68 files changed, 510 insertions(+), 166 deletions(-)


