Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2322533-1523984819-2-11195389093109607755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523984818; b=txbnuRKE3nBc5lYZd9NWcAajeIi/Dy4a4DQag+WpMVkig9bPtA
    hP/ellzbiBrPAfsu6qhSa6yQkCkWIjCx/7ioAt1IVwaVOBvVJlKJxnRkfoGXbQEK
    bObe39dVwyRX9VHjP6Mesv0YT3NFB2F8iMKYWVvxon+ZYky49x4KadkTTZ61UmJK
    YMLrWLo1tAsklBgnoYudmj/h5ltsb98xzYYxqcov5BaQa0VKmAxHqTers3pdBt2v
    jzKuNAJNBcaBgiakBDNeLjlI4yBVpWpnYG7zteUYMFgH1XyUIynmZ3XR9x04ZIVS
    91e5ajPJQ/ENdWg402ysM/pYptk0qxrWTh6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523984818; bh=5Wwt0sXK1mmBOQc3syXSsqz35RUe4T
    vTyLRbP70+ARE=; b=RSKPb4w3Y55H4PuG6CzxGd0k2VAl1T8cAnCFHr78LcJ5Ft
    O6Rj4sxK7x60U3lJi/yWqvYsAt75pxNWXbk2P5I/18xHsNK/YLMwd12aF1kiy7U8
    RghptSkDGw5+X0bf1gPSEu8rhqD5MXSQjs2Lo+PjA5z6sCVCKBbQnenkjy5kok1/
    FEXarRg7ksS/8CpM2Z2EHnd++ZFFJIwWh4GQRO9elxuQRudQuzP2nLPOZVa5c0ta
    gbaGkJNpqymsDBD1ruqfaPvBdBNz8IBDR0KRFbvbSy7SLOIhtZR6iN8J6FQt/3uI
    6nNCIiduOzKi0fRTFAxi/WDRDNo/Yd5LzpfExtcQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPEGyrL2Z1GQ+HWR484DeBzp0ABcoW/6pWj62T2IVCKuw8BZYF1VWjlJwQSoexbzhuTZpJ46rBXbZu7vvxHyyoihtOL9TRnT6AbfH809NSalTozKP6M/
    vm5cALv7D7pn4H+tANc59xGNquSFbOK4qhDdwHUnEEkTsgDrRKOzC5nF3xA4xxHltqvzYvCg2oDqBp2cTB1R6w7qKLkyBytckaXH5P4ehebJGncN6LEsHTRq
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=BXg2v55r-qUA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=fk1lIlRQAAAA:8
    a=20KFwNOVAAAA:8 a=drOt6m5kAAAA:8 a=VnNF1IyMAAAA:8 a=QyXUC8HyAAAA:8
    a=DfNHnWVPAAAA:8 a=JF9118EUAAAA:8 a=uelBKuKpAAAA:8 a=yPCof4ZbAAAA:8
    a=vkfgAjWNAAAA:8 a=pGLkceISAAAA:8 a=nAebDoNsAAAA:8 a=enOvQawGAAAA:8
    a=i0EeH86SAAAA:8 a=1XWaLZrsAAAA:8 a=zuLzuavZAAAA:8 a=bH78PYQqAAAA:8
    a=zd2uoN0lAAAA:8 a=yMhMjlubAAAA:8 a=P1BnusSwAAAA:8 a=WFZIRff2AAAA:8
    a=AeCkNC4mAAAA:8 a=LpQP-O61AAAA:8 a=3ks122f5MkQwzYn3yYIA:9
    a=JBkfpUJzxRzajxhr:21 a=vU9gokjoT2HdfBni:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=U75ogvRika4pmaD_UPO0:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=rjTVMONInIDnV1a_A2c_:22 a=xVlTc564ipvMDusKsbsT:22
    a=wzKOmGq4MlHJBxn66fRI:22 a=s88AYcEWOXMFsoP9cgP2:22 a=ego-_vB8GfJOOuXVi8J-:22
    a=OuzhcWw_GC9nAYdNdRwA:22 a=TrXR8j8ql9YpJ1_1srv2:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeDQQBH (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:01:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60304 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDQQBE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:01:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/68] 4.16.3-stable review
Date: Tue, 17 Apr 2018 17:57:13 +0200
Message-Id: <20180417155749.341779147@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.3-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.3-rc1
X-KernelTest-Deadline: 2018-04-19T15:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.3 release.
There are 68 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Apr 19 15:57:33 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.3-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.3-rc1

Sudhir Sreedharan <ssreedharan@mvista.com>
    rtl8187: Fix NULL pointer dereference in priv->conf_mutex

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: hci_bcm: Treat Interrupt ACPI resources as always being active-low

Szymon Janc <szymon.janc@codecoup.pl>
    Bluetooth: Fix connection if directed advertising and privacy is used

Al Viro <viro@zeniv.linux.org.uk>
    getname_kernel() needs to make sure that ->name != ->iname in long case

Michael S. Tsirkin <mst@redhat.com>
    mm/gup_benchmark: handle gup failures

Michael S. Tsirkin <mst@redhat.com>
    get_user_pages_fast(): return -EFAULT on access_ok failure

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390/compat: fix setup_frame32

Vasily Gorbik <gor@linux.ibm.com>
    s390/ipl: ensure loadparm valid flag is set

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qdio: don't merge ERROR output buffers

Julian Wiedmann <jwi@linux.vnet.ibm.com>
    s390/qdio: don't retry EQBS after CCQ 96

Dan Williams <dan.j.williams@intel.com>
    nfit: fix region registration vs block-data-window ranges

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    block/loop: fix deadlock after loop_set_status

John Johansen <john.johansen@canonical.com>
    apparmor: fix resource audit messages when auditing peer

John Johansen <john.johansen@canonical.com>
    apparmor: fix display of .ns_name for containers

John Johansen <john.johansen@canonical.com>
    apparmor: fix logging of the existence test for signals

Bart Van Assche <bart.vanassche@wdc.com>
    Revert "scsi: core: return BLK_STS_OK for DID_OK in __scsi_error_from_host_byte()"

Bill Kuzeja <William.Kuzeja@stratus.com>
    scsi: qla2xxx: Fix small memory leak in qla2x00_probe_one on probe failure

Johannes Thumshirn <jthumshirn@suse.de>
    scsi: scsi_dh: Don't look for NULL devices handlers by name

J. Bruce Fields <bfields@redhat.com>
    nfsd: fix incorrect umasks

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: fix bug in pgoff overflow checking

Simon Gaiser <simon@invisiblethingslab.com>
    xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END handling

Amir Goldstein <amir73il@gmail.com>
    ovl: set lower layer st_dev only if setting lower st_ino

Amir Goldstein <amir73il@gmail.com>
    ovl: set i_ino to the value of st_ino for NFS export

Amir Goldstein <amir73il@gmail.com>
    ovl: fix lookup with middle layer opaque dir and absolute path redirects

Vivek Goyal <vgoyal@redhat.com>
    ovl: Set d->last properly during lookup

Ming Lei <ming.lei@redhat.com>
    blk-mq: don't keep offline CPUs mapped to hctx 0

Ming Lei <ming.lei@redhat.com>
    blk-mq: make sure that correct hctx->next_cpu is set

Ming Lei <ming.lei@redhat.com>
    blk-mq: order getting budget and driver tag

Tejun Heo <tj@kernel.org>
    blk-mq: Directly schedule q->timeout_work when aborting a request

Huacai Chen <chenhc@lemote.com>
    zboot: fix stack protector in compressed boot phase

Yury Norov <ynorov@caviumnetworks.com>
    lib: fix stall in __bitmap_parselist()

Keith Busch <keith.busch@intel.com>
    nvme: Skip checking heads without namespaces

Bart Van Assche <bart.vanassche@wdc.com>
    block: Change a rcu_read_{lock,unlock}_sched() pair into rcu_read_{lock,unlock}()

Yunlong Song <yunlong.song@huawei.com>
    f2fs: fix heap mode to reset it back

Eric Biggers <ebiggers@google.com>
    sunrpc: remove incorrect HMAC request initialization

Li RongQing <lirongqing@baidu.com>
    x86/apic: Fix signedness bug in APIC ID validity checks

Dmitry V. Levin <ldv@altlinux.org>
    x86/uapi: Fix asm/bootparam.h userspace compilation errors

Toke Høiland-Jørgensen <toke@toke.dk>
    ath9k: Protect queue draining by rcu_read_lock()

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/mce/AMD: Get address from already initialized block

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/mce/AMD: Pass the bank number to smca_get_bank_type()

Arnd Bergmann <arnd@arndb.de>
    radeon: hide pointless #warning when compile testing

Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
    perf/core: Fix use-after-free in uprobe_perf_close()

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix timestamp following overflow

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix error recovery from missing TIP packet

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix sync_switch

Adrian Hunter <adrian.hunter@intel.com>
    perf intel-pt: Fix overlap detection to identify consecutive buffers correctly

Nicholas Piggin <npiggin@gmail.com>
    KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Serialize the present and eject work items

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: do not mark HV_PCIE as perf_device

Luca Coelho <luciano.coelho@intel.com>
    iwlwifi: add a bunch of new 9000 PCI IDs

Helge Deller <deller@gmx.de>
    parisc: Fix HPMC handler by increasing size to multiple of 16 bytes

Helge Deller <deller@gmx.de>
    parisc: Fix out of array access in match_pci_device()

Corey Minyard <cminyard@mvista.com>
    ipmi: Fix some error cleanup issues

Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
    media: v4l: vsp1: Fix header display list status check in continuous mode

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: v4l2-compat-ioctl32: don't oops on overlay

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: v4l2-core: fix size of devnode_nums[] bitarray

Rob Gardner <rob.gardner@oracle.com>
    sparc64: Properly range check DAX completion index

Phil Elwell <phil@raspberrypi.org>
    lan78xx: Correctly indicate invalid OTP

Eric Auger <eric.auger@redhat.com>
    vhost: Fix vhost_copy_to_user()

Sabrina Dubroca <sd@queasysnail.net>
    ip_gre: clear feature flags when incompatible o_flags are set

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: fix race in duplicate tunnel detection

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: fix races in tunnel creation

Stefan Hajnoczi <stefanha@redhat.com>
    vhost: fix vhost_vq_access_ok() log check

Tejaswi Tanikella <tejaswit@codeaurora.org>
    slip: Check if rstate is initialized before uncompressing

Ka-Cheong Poon <ka-cheong.poon@oracle.com>
    rds: MP-RDS may use an invalid c_path

Bassem Boubaker <bassem.boubaker@actia.fr>
    cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/compressed/misc.c                    |   9 +-
 arch/mips/boot/compressed/decompress.c             |   9 +-
 arch/parisc/kernel/drivers.c                       |   4 +
 arch/parisc/kernel/hpmc.S                          |   6 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |   4 -
 arch/s390/kernel/compat_signal.c                   |   2 +-
 arch/s390/kernel/ipl.c                             |   1 +
 arch/sh/boot/compressed/misc.c                     |   9 +-
 arch/x86/include/asm/apic.h                        |   4 +-
 arch/x86/include/asm/mce.h                         |   1 +
 arch/x86/include/uapi/asm/bootparam.h              |  18 +-
 arch/x86/kernel/acpi/boot.c                        |  13 +-
 arch/x86/kernel/apic/apic_common.c                 |   2 +-
 arch/x86/kernel/apic/apic_numachip.c               |   2 +-
 arch/x86/kernel/apic/x2apic.h                      |   2 +-
 arch/x86/kernel/apic/x2apic_phys.c                 |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c                 |   2 +-
 arch/x86/kernel/cpu/mcheck/mce_amd.c               |  37 +++-
 arch/x86/xen/apic.c                                |   2 +-
 block/blk-core.c                                   |   4 +-
 block/blk-mq-cpumap.c                              |   5 -
 block/blk-mq.c                                     |  23 ++-
 block/blk-timeout.c                                |   2 +-
 drivers/acpi/nfit/core.c                           |  22 +-
 drivers/block/loop.c                               |  12 +-
 drivers/bluetooth/hci_bcm.c                        |  20 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |  18 +-
 drivers/edac/mce_amd.c                             |  11 +-
 drivers/gpu/drm/radeon/radeon_object.c             |   3 +-
 drivers/hv/channel_mgmt.c                          |   2 +-
 drivers/media/platform/vsp1/vsp1_dl.c              |   3 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |   4 +-
 drivers/media/v4l2-core/v4l2-dev.c                 |   8 +-
 drivers/net/slip/slhc.c                            |   5 +
 drivers/net/usb/cdc_ether.c                        |   6 +
 drivers/net/usb/lan78xx.c                          |   3 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   4 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      | 157 +++++++++++++-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |   2 +-
 drivers/nvme/host/core.c                           |   1 +
 drivers/pci/host/pci-hyperv.c                      |  92 +++++++--
 drivers/s390/cio/qdio_main.c                       |  42 ++--
 drivers/sbus/char/oradax.c                         |   2 +-
 drivers/scsi/qla2xxx/qla_os.c                      |  44 ++--
 drivers/scsi/scsi_dh.c                             |   3 +
 drivers/scsi/scsi_lib.c                            |   2 -
 drivers/vhost/vhost.c                              |  10 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c           |   2 +-
 fs/f2fs/gc.c                                       |   5 +-
 fs/f2fs/segment.c                                  |   3 +-
 fs/hugetlbfs/inode.c                               |  10 +-
 fs/namei.c                                         |   3 +-
 fs/nfsd/nfs4proc.c                                 |  12 +-
 fs/nfsd/nfs4xdr.c                                  |   8 +-
 fs/nfsd/xdr4.h                                     |   2 +
 fs/overlayfs/inode.c                               |  28 ++-
 fs/overlayfs/namei.c                               |  17 +-
 fs/overlayfs/util.c                                |   8 +-
 include/media/v4l2-dev.h                           |  12 +-
 include/net/bluetooth/hci_core.h                   |   2 +-
 include/net/slhc_vj.h                              |   1 +
 kernel/events/core.c                               |   6 +
 lib/bitmap.c                                       |   2 +-
 lib/test_bitmap.c                                  |   4 +
 mm/gup.c                                           |   5 +-
 mm/gup_benchmark.c                                 |   4 +-
 net/bluetooth/hci_conn.c                           |  29 ++-
 net/bluetooth/hci_event.c                          |  15 +-
 net/bluetooth/l2cap_core.c                         |   2 +-
 net/ipv4/ip_gre.c                                  |   6 +
 net/l2tp/l2tp_core.c                               | 225 +++++++++------------
 net/l2tp/l2tp_core.h                               |   4 +-
 net/l2tp/l2tp_netlink.c                            |  22 +-
 net/l2tp/l2tp_ppp.c                                |   9 +
 net/rds/send.c                                     |  15 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c              |   3 -
 security/apparmor/apparmorfs.c                     |   4 +-
 security/apparmor/include/audit.h                  |   8 +-
 security/apparmor/include/sig_names.h              |   4 +-
 security/apparmor/ipc.c                            |   2 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  64 +++---
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   2 +-
 tools/perf/util/intel-pt.c                         |  37 +++-
 84 files changed, 785 insertions(+), 443 deletions(-)
