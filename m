Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48W++4QQ8JH0/whsJj+pJ8CNy1fQ67NVb6lzydNmvrgo5Gd9T1JRuOEsawogv9dR7/iGQR3
ARC-Seal: i=1; a=rsa-sha256; t=1523981211; cv=none;
        d=google.com; s=arc-20160816;
        b=yVrCAMa6nZoEBzMz6qXuLqYWXnvOQVvAhDEY1dRMYOf/3/CfoS5m1807FNvy87Qhft
         TslvwUGCSPa8+pJV6TDpgB7GaEN+6zqA6oR+xT2AThkF4XBvy0dYxsH/1O65HS/bcNrW
         2gxbiwDgdU+c+M7qDTRQIHMskJepGDCgQYKICIlKVYTtmKcIDtScF5ApCy3udlYJTrW5
         8dbctwPADrr+VzsfsyBnbluEVRcHMFZGPFHJ4WEv8+5pPrh4mtbkhj7dig8bmAOOy1nI
         Pa8PPNwGDu1dN+uz4BF8DgvGtDIg+tbXK35s1sUzagDznITGVxVrfKjpbG5pcAcHf1gP
         3n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=vPBppJplWXEiGnfIpdWL7JM7c3PN0lBd4bsSdij1x3A=;
        b=v0PUODF/hNTALuKtg7++W6Divp/VCDG+toubi9JUvqiKesuS0XTMM0Hg0tLBAr/tBr
         DTkoO/U1WFCwG6xOMRhsEpDp90/7RRpDavZ20Am7DL1gsP+p0aqc2APkkQ5XJgBt2w2J
         cwZMxF6O466apr8PGExek5lfUn7ZHtp7vKUsovTxIwHDuS3LaU8oNc4gIhHxirliJTTR
         4U3vIcSUAlxWyiYUq5z6giYcCbJLncw/s8oyl5/FwytD3FGSQCbvZPmfpDTRCLD7/sH4
         mevDTX0QdMVLrMYyF6KQRQtrlvAkEKqPiJeBpYW95ZOQm1U/BxP6pVBpxFm8UeqoGdaa
         yENw==
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
Subject: [PATCH 4.14 00/49] 4.14.35-stable review
Date: Tue, 17 Apr 2018 17:58:39 +0200
Message-Id: <20180417155715.032245882@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.35-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.35-rc1
X-KernelTest-Deadline: 2018-04-19T15:57+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598010122739110875?=
X-GMAIL-MSGID: =?utf-8?q?1598010122739110875?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.35 release.
There are 49 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Thu Apr 19 15:56:59 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.35-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.35-rc1

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

Yury Norov <ynorov@caviumnetworks.com>
    lib: fix stall in __bitmap_parselist()

Yunlong Song <yunlong.song@huawei.com>
    f2fs: fix heap mode to reset it back

Eric Biggers <ebiggers@google.com>
    sunrpc: remove incorrect HMAC request initialization

Toke Høiland-Jørgensen <toke@toke.dk>
    ath9k: Protect queue draining by rcu_read_lock()

Marek Szyprowski <m.szyprowski@samsung.com>
    hwmon: (ina2xx) Fix access to uninitialized mutex

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/mce/AMD: Get address from already initialized block

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/mce/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/mce/AMD: Pass the bank number to smca_get_bank_type()

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/MCE: Report only DRAM ECC as memory errors on AMD systems

Sudhir Sreedharan <ssreedharan@mvista.com>
    rtl8187: Fix NULL pointer dereference in priv->conf_mutex

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: hci_bcm: Treat Interrupt ACPI resources as always being active-low

Szymon Janc <szymon.janc@codecoup.pl>
    Bluetooth: Fix connection if directed advertising and privacy is used

Al Viro <viro@zeniv.linux.org.uk>
    getname_kernel() needs to make sure that ->name != ->iname in long case

Michael S. Tsirkin <mst@redhat.com>
    get_user_pages_fast(): return -EFAULT on access_ok failure

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

Yazen Ghannam <yazen.ghannam@amd.com>
    x86/MCE/AMD: Define a function to get SMCA bank type

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
    PCI: hv: Serialize the present and eject work items

Dexuan Cui <decui@microsoft.com>
    Drivers: hv: vmbus: do not mark HV_PCIE as perf_device

Helge Deller <deller@gmx.de>
    parisc: Fix HPMC handler by increasing size to multiple of 16 bytes

Helge Deller <deller@gmx.de>
    parisc: Fix out of array access in match_pci_device()

Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
    media: v4l: vsp1: Fix header display list status check in continuous mode

Mauro Carvalho Chehab <mchehab@kernel.org>
    media: v4l2-compat-ioctl32: don't oops on overlay

Phil Elwell <phil@raspberrypi.org>
    lan78xx: Correctly indicate invalid OTP

Eric Auger <eric.auger@redhat.com>
    vhost: Fix vhost_copy_to_user()

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


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/parisc/kernel/drivers.c                       |  4 ++
 arch/parisc/kernel/hpmc.S                          |  6 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c                |  4 --
 arch/s390/kernel/ipl.c                             |  1 +
 arch/x86/include/asm/mce.h                         |  3 +
 arch/x86/kernel/cpu/mcheck/mce.c                   |  4 +-
 arch/x86/kernel/cpu/mcheck/mce_amd.c               | 54 ++++++++++++++++--
 block/blk-mq-cpumap.c                              |  5 --
 drivers/acpi/nfit/core.c                           | 22 +++++---
 drivers/block/loop.c                               | 12 ++--
 drivers/bluetooth/hci_bcm.c                        | 20 +------
 drivers/edac/mce_amd.c                             | 11 ++--
 drivers/gpu/drm/radeon/radeon_object.c             |  3 +-
 drivers/hv/channel_mgmt.c                          |  2 +-
 drivers/hwmon/ina2xx.c                             |  3 +-
 drivers/media/platform/vsp1/vsp1_dl.c              |  3 +-
 drivers/media/v4l2-core/v4l2-compat-ioctl32.c      |  4 +-
 drivers/net/slip/slhc.c                            |  5 ++
 drivers/net/usb/cdc_ether.c                        |  6 ++
 drivers/net/usb/lan78xx.c                          |  3 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |  4 ++
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |  2 +-
 drivers/pci/host/pci-hyperv.c                      | 34 ++++++------
 drivers/s390/cio/qdio_main.c                       | 42 +++++++-------
 drivers/scsi/qla2xxx/qla_os.c                      | 44 +++++++--------
 drivers/vhost/vhost.c                              | 10 ++--
 drivers/xen/xenbus/xenbus_dev_frontend.c           |  2 +-
 fs/f2fs/gc.c                                       |  5 +-
 fs/f2fs/segment.c                                  |  3 +-
 fs/hugetlbfs/inode.c                               | 10 +++-
 fs/namei.c                                         |  3 +-
 fs/nfsd/nfs4proc.c                                 | 12 +++-
 fs/nfsd/nfs4xdr.c                                  |  8 +--
 fs/nfsd/xdr4.h                                     |  2 +
 fs/overlayfs/namei.c                               |  9 +++
 include/net/bluetooth/hci_core.h                   |  2 +-
 include/net/slhc_vj.h                              |  1 +
 kernel/events/core.c                               |  6 ++
 lib/bitmap.c                                       |  2 +-
 lib/test_bitmap.c                                  |  4 ++
 mm/gup.c                                           |  5 +-
 net/bluetooth/hci_conn.c                           | 29 +++++++---
 net/bluetooth/hci_event.c                          | 15 +++--
 net/bluetooth/l2cap_core.c                         |  2 +-
 net/netfilter/ipset/ip_set_core.c                  |  2 +
 net/rds/send.c                                     | 15 +++--
 net/sunrpc/auth_gss/gss_krb5_crypto.c              |  3 -
 security/apparmor/apparmorfs.c                     |  4 +-
 security/apparmor/include/audit.h                  |  8 +--
 security/apparmor/include/sig_names.h              |  4 +-
 security/apparmor/ipc.c                            |  2 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  | 64 +++++++++++-----------
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |  2 +-
 tools/perf/util/intel-pt.c                         | 37 ++++++++++---
 55 files changed, 361 insertions(+), 215 deletions(-)
