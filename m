Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48rmN2AMrIqQcgpMoMs6e1YxlvEVyfLo0mTDIQVqldPErdpFuU509oJby7Yc9nSZDaz6Bfz
ARC-Seal: i=1; a=rsa-sha256; t=1523980995; cv=none;
        d=google.com; s=arc-20160816;
        b=UvqVixAdC3KpogP6XhxcsbP/F1G4Y2PZTy+KcIgTSiY3v1ZkC1Fbxr8cVhW3E/U8es
         +UKaxs9E3WnxhITaFd3KrPDL2YuSGw2WXTRX79Xx3yTqGC7Nqoe0auEtdt/o/qTpaDg0
         MK8ZLlxQlNg0gJub7VLx/7zmYaNJXtf0qw3A78ZGbIv/tDC/sFbGIbCS/OfFgeFXNAVo
         PAVkkx9OjhIcRXsFgBJU0Bd2oZySf5V8oF3v+JVPilQHXOzTGedqxQX/VtxgPuCEWDGW
         kaapeFvQSVz5araolEQa+QDKg5JEOdnQOIONJZyqDpXzfCmc+U++2MTXseRkqBFPFEkG
         FWQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jh6XO+jQkN6AmASi8XpoVk5k1hmyj8AxCW80HZ8+NgM=;
        b=bG2ATqh0uKJgaaUWufTnzaXRAsGAKdRowK7pIM3ky9mi2yxFz8ua+mWP1unRdt2pXr
         zd9nHTL2E+nZWqOwhyKqHr4Z/kt0iLUa7zlogNNexxTkObbvAmBrNgZwuQIu0zYUfZS1
         tk+rfpWoTAxjMMvfxL2P+MmHbSXRU2Xj62x3EREM7+yb1c09xFNrGiAyrVPmqFq2uF9o
         VPEgSTpOw+SPpELz1mrRyYhRCLvMnWj4NmDJl1Ojxcl2/OBz5CBQg2TLtUIXHmXN943O
         ZqP+eZdQfCI5F2glIWcN14AaMRBw4/kFGLcVoXfq1mcxiXibSdSLm/oSdrP/eFfVqzLo
         bGcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 46.44.180.42 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuahkh@osg.samsung.com,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.15 00/53] 4.15.18-stable review
Date: Tue, 17 Apr 2018 17:58:25 +0200
Message-Id: <20180417155723.091120060@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.18-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.18-rc1
X-KernelTest-Deadline: 2018-04-19T15:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598009896263734013?=
X-GMAIL-MSGID: =?utf-8?q?1598009896263734013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

------------------------
NOTE, this is the last expected 4.15.y release.  After this one, the
tree is end-of-life.  Please move to 4.16.y at this point in time.
------------------------

This is the start of the stable review cycle for the 4.15.18 release.
There are 53 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Apr 19 15:57:06 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.18-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.18-rc1

Amir Goldstein <amir73il@gmail.com>
    ovl: set lower layer st_dev only if setting lower st_ino

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

Bill Kuzeja <William.Kuzeja@stratus.com>
    scsi: qla2xxx: Fix small memory leak in qla2x00_probe_one on probe failure

J. Bruce Fields <bfields@redhat.com>
    nfsd: fix incorrect umasks

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: fix bug in pgoff overflow checking

Simon Gaiser <simon@invisiblethingslab.com>
    xen: xenbus_dev_frontend: Fix XS_TRANSACTION_END handling

Amir Goldstein <amir73il@gmail.com>
    ovl: fix lookup with middle layer opaque dir and absolute path redirects

Ming Lei <ming.lei@redhat.com>
    blk-mq: don't keep offline CPUs mapped to hctx 0

Ming Lei <ming.lei@redhat.com>
    blk-mq: order getting budget and driver tag

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

Toke Høiland-Jørgensen <toke@toke.dk>
    ath9k: Protect queue draining by rcu_read_lock()

Marek Szyprowski <m.szyprowski@samsung.com>
    hwmon: (ina2xx) Fix access to uninitialized mutex

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/mce/AMD: Get address from already initialized block

Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
    perf/core: Fix use-after-free in uprobe_perf_close()

Nicholas Piggin <npiggin@gmail.com>
    KVM: PPC: Book3S HV: trace_tlbie must not be called in realmode

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()

Dexuan Cui <decui@microsoft.com>
    PCI: hv: Serialize the present and eject work items

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: do not mark HV_PCIE as perf_device

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

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
    netfilter: ipset: Missing nfnl_lock()/nfnl_unlock() is added to ip_set_net_exit()

Manasi Navare <manasi.d.navare@intel.com>
    drm/i915/edp: Do not do link training fallback or prune modes on EDP


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/parisc/kernel/drivers.c                       |   4 +
 arch/parisc/kernel/hpmc.S                          |   6 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |   4 -
 arch/s390/kernel/compat_signal.c                   |   2 +-
 arch/s390/kernel/ipl.c                             |   1 +
 arch/x86/include/asm/apic.h                        |   4 +-
 arch/x86/kernel/acpi/boot.c                        |  13 +-
 arch/x86/kernel/apic/apic_common.c                 |   2 +-
 arch/x86/kernel/apic/apic_numachip.c               |   2 +-
 arch/x86/kernel/apic/x2apic.h                      |   2 +-
 arch/x86/kernel/apic/x2apic_phys.c                 |   2 +-
 arch/x86/kernel/apic/x2apic_uv_x.c                 |   2 +-
 arch/x86/kernel/cpu/mcheck/mce_amd.c               |  15 ++
 arch/x86/xen/apic.c                                |   2 +-
 block/blk-core.c                                   |   4 +-
 block/blk-mq-cpumap.c                              |   5 -
 block/blk-mq.c                                     |  21 +-
 drivers/acpi/nfit/core.c                           |  22 +-
 drivers/block/loop.c                               |  12 +-
 drivers/bluetooth/hci_bcm.c                        |  20 +-
 drivers/char/ipmi/ipmi_si_intf.c                   |  18 +-
 drivers/gpu/drm/i915/intel_dp_link_training.c      |  26 ++-
 drivers/hv/channel_mgmt.c                          |   2 +-
 drivers/hwmon/ina2xx.c                             |   3 +-
 drivers/media/platform/vsp1/vsp1_dl.c              |   3 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |   4 +-
 drivers/net/slip/slhc.c                            |   5 +
 drivers/net/usb/cdc_ether.c                        |   6 +
 drivers/net/usb/lan78xx.c                          |   3 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   4 +
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |   2 +-
 drivers/nvme/host/core.c                           |   1 +
 drivers/pci/host/pci-hyperv.c                      |  92 +++++++--
 drivers/s390/cio/qdio_main.c                       |  42 ++--
 drivers/scsi/qla2xxx/qla_os.c                      |  44 ++--
 drivers/vhost/vhost.c                              |  10 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c           |   2 +-
 fs/f2fs/gc.c                                       |   5 +-
 fs/f2fs/segment.c                                  |   3 +-
 fs/hugetlbfs/inode.c                               |  10 +-
 fs/namei.c                                         |   3 +-
 fs/nfsd/nfs4proc.c                                 |  12 +-
 fs/nfsd/nfs4xdr.c                                  |   8 +-
 fs/nfsd/xdr4.h                                     |   2 +
 fs/overlayfs/inode.c                               |   7 +-
 fs/overlayfs/namei.c                               |   9 +
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
 net/netfilter/ipset/ip_set_core.c                  |   2 +
 net/rds/send.c                                     |  15 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c              |   3 -
 security/apparmor/apparmorfs.c                     |   4 +-
 security/apparmor/include/audit.h                  |   8 +-
 security/apparmor/include/sig_names.h              |   4 +-
 security/apparmor/ipc.c                            |   2 +-
 69 files changed, 504 insertions(+), 345 deletions(-)
