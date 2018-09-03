Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED604C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9445A20779
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9445A20779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeICVMQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:12:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36296 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbeICVMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:12:16 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 44244CEE;
        Mon,  3 Sep 2018 16:51:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/56] 3.18.121-stable review
Date:   Mon,  3 Sep 2018 18:48:50 +0200
Message-Id: <20180903164924.078355019@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.121-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.121-rc1
X-KernelTest-Deadline: 2018-09-05T16:49+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.121 release.
There are 56 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Sep  5 16:49:09 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.121-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.121-rc1

Scott Bauer <scott.bauer@intel.com>
    cdrom: Fix info leak/OOB read in cdrom_ioctl_drive_status

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: core: Avoid that SCSI device removal through sysfs triggers a deadlock

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: sysfs: Introduce sysfs_{un,}break_active_protection()

Maciej W. Rozycki <macro@mips.com>
    MIPS: Correct the 64-bit DSP accumulator register size

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Make list and blacklist root user read only

Sebastian Ott <sebott@linux.ibm.com>
    s390/pci: fix out of bounds access during irq setup

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qdio: reset old sbal_state flags

Dan Carpenter <dan.carpenter@oracle.com>
    pinctrl: freescale: off by one in imx1_pinconf_group_dbg_show()

Gustavo A. R. Silva <gustavo@embeddedor.com>
    ASoC: sirf: Fix potential NULL pointer dereference

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: fix crash due to uninitialized memory

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: handle allocation failure

Mikulas Patocka <mpatocka@redhat.com>
    udl-kms: change down_interruptible to down

Kirill Tkhai <ktkhai@virtuozzo.com>
    fuse: Add missed unlock_page() to fuse_readpages_fill()

Andrey Ryabinin <aryabinin@virtuozzo.com>
    fuse: Don't access pipe->buffers without pipe_lock()

Rian Hunter <rian@alum.mit.edu>
    x86/process: Re-export start_thread()

Punit Agrawal <punit.agrawal@arm.com>
    KVM: arm/arm64: Skip updating PMD entry if no change

Punit Agrawal <punit.agrawal@arm.com>
    KVM: arm/arm64: Skip updating PTE entry if no change

Greg Hackmann <ghackmann@android.com>
    arm64: mm: check for upper PAGE_SHIFT bits in pfn_valid()

Eric Sandeen <sandeen@redhat.com>
    ext4: reset error code in ext4_find_entry in fallback

Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
    s390/kvm: fix deadlock when killed by oom

Josef Bacik <josef@toxicpanda.com>
    btrfs: don't leak ret from do_chunk_alloc

jie@chenjie6@huwei.com <jie@chenjie6@huwei.com>
    mm/memory.c: check return value of ioremap_prot

Jim Gill <jgill@vmware.com>
    scsi: vmw_pvscsi: Return DID_RESET for status SAM_STAT_COMMAND_TERMINATED

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: fcoe: drop frames in ELS LOGO error path

Colin Ian King <colin.king@canonical.com>
    drivers: net: lmc: fix case value for target abort error

Randy Dunlap <rdunlap@infradead.org>
    arc: fix type warnings in arc/mm/cache.c

Randy Dunlap <rdunlap@infradead.org>
    arc: fix build errors in arc/include/asm/delay.h

Govindarajulu Varadarajan <gvaradar@cisco.com>
    enic: handle mtu change for vf properly

Rafał Miłecki <rafal@milecki.pl>
    Revert "MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum"

Calvin Walton <calvin.walton@kepstin.ca>
    tools/power turbostat: Read extended processor family from CPUID

Li Wang <liwang@redhat.com>
    zswap: re-check zswap_is_full() after do zswap_shrink()

Masami Hiramatsu <mhiramat@kernel.org>
    selftests/ftrace: Add snapshot and tracing_on test case

Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
    cachefiles: Wait rather than BUG'ing on "Unexpected object collision"

Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
    cachefiles: Fix refcounting bug in backing-file read monitoring

Kiran Kumar Modukuri <kiran.modukuri@gmail.com>
    fscache: Allow cancelled operations to be enqueued

Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
    net: axienet: Fix double deregister of mdio

Sudarsana Reddy Kalluru <sudarsana.kalluru@cavium.com>
    bnx2x: Fix invalid memory access in rss hash config path.

Guenter Roeck <linux@roeck-us.net>
    media: staging: omap4iss: Include asm/cacheflush.h after generic includes

Nicholas Mc Guire <hofrat@osadl.org>
    can: mpc5xxx_can: check of_iomap return before use

Florian Westphal <fw@strlen.de>
    atl1c: reserve min skb headroom

YueHaibing <yuehaibing@huawei.com>
    net: caif: Add a missing rcu_read_unlock() in caif_flow_cb

Len Brown <len.brown@intel.com>
    tools/power turbostat: fix -S on UP systems

Eugeniu Rosca <roscaeugeniu@gmail.com>
    usb: gadget: f_uac2: fix endianness of 'struct cntrl_*_lay3'

Peter Senna Tschudin <peter.senna@gmail.com>
    tools: usb: ffs-test: Fix build on big endian systems

Randy Dunlap <rdunlap@infradead.org>
    usb/phy: fix PPC64 build errors in phy-fsl-usb.c

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: gadget: r8a66597: Fix a possible sleep-in-atomic-context bugs in r8a66597_queue()

Jia-Ju Bai <baijiaju1990@gmail.com>
    usb: gadget: r8a66597: Fix two possible sleep-in-atomic-context bugs in init_controller()

Lucas Stach <l.stach@pengutronix.de>
    drm/imx: imx-ldb: check if channel is enabled before printing warning

Lucas Stach <l.stach@pengutronix.de>
    drm/imx: imx-ldb: disable LDB on driver bind

Varun Prakash <varun@chelsio.com>
    scsi: libiscsi: fix possible NULL pointer dereference in case of TMF

Bernd Edlinger <bernd.edlinger@hotmail.de>
    nl80211: Add a missing break in parse_station_flags

mpubbise@codeaurora.org <mpubbise@codeaurora.org>
    mac80211: add stations tied to AP_VLANs during hw reconfig

Florian Westphal <fw@strlen.de>
    xfrm: free skb if nlsk pointer is NULL

Tommi Rantala <tommi.t.rantala@nokia.com>
    xfrm: fix missing dst_release() after policy blocking lbcast and multicast

yujuan.qi <yujuan.qi@mediatek.com>
    Cipso: cipso_v4_optptr enter infinite loop

Ethan Zhao <ethan.zhao@oracle.com>
    sched/sysctl: Check user input value of sysctl_sched_time_avg


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arc/include/asm/delay.h                       |  3 +
 arch/arc/mm/cache_arc700.c                         |  7 +-
 arch/arm/kvm/mmu.c                                 | 42 +++++++++---
 arch/arm64/mm/init.c                               |  6 +-
 arch/mips/bcm47xx/setup.c                          |  6 --
 arch/mips/include/asm/mipsregs.h                   |  3 -
 arch/mips/include/asm/processor.h                  |  2 +-
 arch/mips/kernel/ptrace.c                          |  2 +-
 arch/mips/kernel/ptrace32.c                        |  2 +-
 arch/s390/include/asm/qdio.h                       |  1 -
 arch/s390/mm/fault.c                               |  2 +
 arch/s390/pci/pci.c                                |  2 +
 arch/x86/kernel/process_64.c                       |  1 +
 drivers/cdrom/cdrom.c                              |  2 +-
 drivers/gpu/drm/udl/udl_fb.c                       |  2 +-
 drivers/gpu/drm/udl/udl_main.c                     | 35 +++++-----
 drivers/net/can/mscan/mpc5xxx_can.c                |  5 ++
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c    |  1 +
 .../net/ethernet/broadcom/bnx2x/bnx2x_ethtool.c    | 13 +++-
 drivers/net/ethernet/cisco/enic/enic_main.c        | 78 ++++++++--------------
 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c  |  1 +
 drivers/net/wan/lmc/lmc_main.c                     |  2 +-
 drivers/pinctrl/freescale/pinctrl-imx1-core.c      |  2 +-
 drivers/s390/cio/qdio_main.c                       |  5 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  4 +-
 drivers/scsi/libiscsi.c                            | 12 ++--
 drivers/scsi/scsi_sysfs.c                          | 20 +++++-
 drivers/scsi/vmw_pvscsi.c                          | 11 ++-
 drivers/staging/imx-drm/imx-ldb.c                  |  9 ++-
 drivers/staging/media/omap4iss/iss_video.c         |  3 +-
 drivers/usb/gadget/function/f_uac2.c               | 20 +++---
 drivers/usb/gadget/udc/r8a66597-udc.c              |  6 +-
 drivers/usb/phy/phy-fsl-usb.c                      |  4 +-
 fs/btrfs/extent-tree.c                             |  2 +-
 fs/cachefiles/namei.c                              |  1 -
 fs/cachefiles/rdwr.c                               | 17 +++--
 fs/ext4/namei.c                                    |  1 +
 fs/fscache/operation.c                             |  6 +-
 fs/fuse/dev.c                                      |  7 +-
 fs/fuse/file.c                                     |  1 +
 fs/sysfs/file.c                                    | 44 ++++++++++++
 include/linux/sysfs.h                              | 14 ++++
 kernel/kprobes.c                                   |  4 +-
 kernel/sysctl.c                                    |  3 +-
 mm/memory.c                                        |  3 +
 mm/zswap.c                                         |  9 +++
 net/caif/caif_dev.c                                |  4 +-
 net/ipv4/cipso_ipv4.c                              | 12 +++-
 net/mac80211/util.c                                |  3 +-
 net/wireless/nl80211.c                             |  1 +
 net/xfrm/xfrm_policy.c                             |  3 +
 net/xfrm/xfrm_user.c                               | 10 +--
 sound/soc/sirf/sirf-usp.c                          |  7 +-
 tools/power/x86/turbostat/turbostat.c              |  8 +--
 .../selftests/ftrace/test.d/00basic/snapshot.tc    | 28 ++++++++
 tools/usb/ffs-test.c                               | 19 +++++-
 57 files changed, 354 insertions(+), 171 deletions(-)


