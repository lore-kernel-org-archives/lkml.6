Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2245+LmlqVPjavfUr+2Iez688wvayL5su4/EMOYihCoYKWi0nboD62iBjj9923F9hVRACR9k
ARC-Seal: i=1; a=rsa-sha256; t=1519412299; cv=none;
        d=google.com; s=arc-20160816;
        b=lAWxtjyGZeBsikuVsr1ZmK33tIEBSueyZCOaCnGrEELOXkDgZwJW/tLPj4imuoZjAC
         vsDpNsHtSc4Qg7u4F4wh8GmSPlX4h14Al47CmHOUurCyMq7BSbu1+wfOp6sM6JoqMnTc
         ngHGpPXRlAECKcgVGgtmO5F5fKc4hbRYFa5WJjPhAd3Y6yVR4D4fXmsup8usbIR1gfRB
         Sr2BEb9UfLy3vvHHAnsKCBSlfQ6XmyxcOiRA4OXUkvfzUv/1a5ZK5sykYFJ2HTEwr2SD
         cD4zgyC2BJ5UGpgFt6F3htwmqeH8s0cYT4ifXt06buAcJEYjMhXyQr5UkkOU9kUf+7fD
         E39Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=i8vKlHMGOO4HbWc/U/GMo1jmQJTT2RL1huTkeePKepk=;
        b=r7G8wP7h9ArStYWGGxa7nzRN3udSt6oSVDRvL3r8o++ut5r4EPMNNBqua1YUHIZRta
         6tJw1ROLcTJfzm6yKFekYco9YHppl1151HBhwB3JuFDdGrM37VS18t+czP7iz9iBo312
         RFNSEfzzduiqfUObTXFke9+4I5ccch5OxVaVxrkz0BkI91LGmvm8HFSVoaKsdnTMvFKZ
         yUsUFpNri4fDyWNFIV388Ya7BAHeB2XIMKAPAXsL9sabZ5nb8Z+jMhsNvNdxzvnI0YbI
         MQzXJl37nk5NfH4s1moFCk2raJ0hfaJkqlC54vh37hfUQ2zokh9N0q57JdlBOpOYvO8O
         4CPw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.15 00/45] 4.15.6-stable review
Date: Fri, 23 Feb 2018 19:28:39 +0100
Message-Id: <20180223170715.197760019@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.6-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.15.6-rc1
X-KernelTest-Deadline: 2018-02-25T17:07+00:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593219271451312603?=
X-GMAIL-MSGID: =?utf-8?q?1593219271451312603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.15.6 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb 25 17:06:43 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.6-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.15.6-rc1

Michal Hocko <mhocko@suse.com>
    vmalloc: fix __GFP_HIGHMEM usage for vmalloc_32 on 32b systems

Tomas Winkler <tomas.winkler@intel.com>
    mei: me: add cannon point device ids for 4th device

Alexander Usyskin <alexander.usyskin@intel.com>
    mei: me: add cannon point device ids

Kamil Konieczny <k.konieczny@partner.samsung.com>
    crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

Shuah Khan <shuah@kernel.org>
    usbip: keep usbip_device sockfd state in sync with tcp_socket

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    xhci: fix xhci debugfs errors in xhci_stop

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    xhci: xhci debugfs device nodes weren't removed after device plugged out

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    xhci: Fix xhci debugfs devices node disappearance after hibernation

Zhengjun Xing <zhengjun.xing@linux.intel.com>
    xhci: Fix NULL pointer in xhci debugfs

Alexandru Ardelean <alexandru.ardelean@analog.com>
    staging: iio: ad5933: switch buffer mode to software

Alexandru Ardelean <alexandru.ardelean@analog.com>
    staging: iio: adc: ad7192: fix external frequency setting

Arnd Bergmann <arnd@arndb.de>
    staging: fsl-mc: fix build testing on x86

Todd Kjos <tkjos@android.com>
    binder: replace "%p" with "%pK"

Eric Biggers <ebiggers@google.com>
    binder: check for binder_thread allocation failure in binder_poll()

Ben Hutchings <ben@decadent.org.uk>
    staging: android: ashmem: Fix a race condition in pin ioctls

Martijn Coenen <maco@android.com>
    ANDROID: binder: synchronize_rcu() when using POLLFREE.

Todd Kjos <tkjos@android.com>
    ANDROID: binder: remove WARN() for redundant txn error

Paolo Abeni <pabeni@redhat.com>
    dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Arnd Bergmann <arnd@arndb.de>
    arm64: dts: add #cooling-cells to CPU nodes

Arnd Bergmann <arnd@arndb.de>
    ARM: 8743/1: bL_switcher: add MODULE_LICENSE tag

Arnd Bergmann <arnd@arndb.de>
    video: fbdev/mmp: add MODULE_LICENSE

Arnd Bergmann <arnd@arndb.de>
    ASoC: ux500: add MODULE_LICENSE tag

Jesse Chan <jc@linux.com>
    soc: qcom: rmtfs_mem: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Eric Dumazet <edumazet@google.com>
    net_sched: gen_estimator: fix lockdep splat

Willem de Bruijn <willemb@google.com>
    net: avoid skb_warn_bad_offload on IS_ERR

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    rds: tcp: atomically purge entries from rds_tcp_conn_list during netns delete

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    rds: tcp: correctly sequence cleanup on netns deletion.

Cong Wang <xiyou.wangcong@gmail.com>
    netfilter: xt_RATEEST: acquire xt_rateest_mutex for hash insert

Cong Wang <xiyou.wangcong@gmail.com>
    netfilter: xt_cgroup: initialize info->priv in cgroup_mt_check_v1()

Paolo Abeni <pabeni@redhat.com>
    netfilter: on sockopt() acquire sock lock only in the required scope

Dmitry Vyukov <dvyukov@google.com>
    netfilter: ipt_CLUSTERIP: fix out-of-bounds accesses in clusterip_tg_check()

Eric Dumazet <edumazet@google.com>
    netfilter: x_tables: avoid out-of-bounds reads in xt_request_find_{match|target}

Dmitry Vyukov <dvyukov@google.com>
    netfilter: x_tables: fix int overflow in xt_alloc_table_info()

Dmitry Vyukov <dvyukov@google.com>
    kcov: detect double association with a single task

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: x86: fix escape of guest dr6 to the host

Douglas Gilbert <dgilbert@interlog.com>
    blk_rq_map_user_iov: fix error override

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Switch from WARN to pr_warn

Laura Abbott <labbott@redhat.com>
    staging: android: ion: Add __GFP_NOWARN for system contig heap

Eric Biggers <ebiggers@google.com>
    crypto: x86/twofish-3way - Fix %rbp usage

Andrey Konovalov <andreyknvl@google.com>
    media: pvrusb2: properly check endpoint types

Paul Moore <paul@paul-moore.com>
    selinux: skip bounded transition processing if the policy isn't loaded

Paul Moore <paul@paul-moore.com>
    selinux: ensure the context is NUL terminated in security_context_to_sid_core()

Jason Wang <jasowang@redhat.com>
    ptr_ring: try vmalloc() when kmalloc() fails

Jason Wang <jasowang@redhat.com>
    ptr_ring: fail early if queue occupies more than KMALLOC_MAX_SIZE

Eric Dumazet <edumazet@google.com>
    tun: fix tun_napi_alloc_frags() frag allocator


-------------

Diffstat:

 Makefile                                        |   4 +-
 arch/arm/common/bL_switcher_dummy_if.c          |   4 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |   2 +
 arch/x86/crypto/twofish-x86_64-asm_64-3way.S    | 112 +++++++++++++-----------
 arch/x86/kvm/x86.c                              |   6 ++
 block/blk-map.c                                 |   4 +-
 drivers/android/binder.c                        |  29 ++++--
 drivers/crypto/s5p-sss.c                        |  12 ++-
 drivers/media/usb/pvrusb2/pvrusb2-hdw.c         |  12 +++
 drivers/misc/mei/hw-me-regs.h                   |   5 ++
 drivers/misc/mei/pci-me.c                       |   5 ++
 drivers/net/tun.c                               |  16 ++--
 drivers/soc/qcom/rmtfs_mem.c                    |   4 +
 drivers/staging/android/ashmem.c                |  19 ++--
 drivers/staging/android/ion/ion-ioctl.c         |   4 +-
 drivers/staging/android/ion/ion_system_heap.c   |   2 +-
 drivers/staging/fsl-mc/bus/Kconfig              |   2 +-
 drivers/staging/iio/adc/ad7192.c                |  27 ++++--
 drivers/staging/iio/impedance-analyzer/ad5933.c |   4 +-
 drivers/usb/host/xhci-debugfs.c                 |   4 +-
 drivers/usb/host/xhci.c                         |  10 +--
 drivers/usb/usbip/stub_dev.c                    |   3 +
 drivers/usb/usbip/vhci_hcd.c                    |   2 +
 drivers/video/fbdev/mmp/core.c                  |   5 ++
 include/linux/ptr_ring.h                        |  15 ++--
 kernel/kcov.c                                   |   4 +-
 mm/vmalloc.c                                    |  10 ++-
 net/core/dev.c                                  |   2 +-
 net/core/gen_estimator.c                        |   4 +
 net/decnet/af_decnet.c                          |  62 +++++++------
 net/ipv4/ip_sockglue.c                          |  14 +--
 net/ipv4/netfilter/ipt_CLUSTERIP.c              |  16 +++-
 net/ipv4/netfilter/nf_conntrack_l3proto_ipv4.c  |   6 +-
 net/ipv6/ipv6_sockglue.c                        |  17 ++--
 net/ipv6/netfilter/nf_conntrack_l3proto_ipv6.c  |  18 ++--
 net/netfilter/x_tables.c                        |   9 +-
 net/netfilter/xt_RATEEST.c                      |  22 +++--
 net/netfilter/xt_cgroup.c                       |   1 +
 net/rds/connection.c                            |   3 +-
 net/rds/rds.h                                   |   6 +-
 net/rds/tcp.c                                   |  13 ++-
 net/rds/tcp.h                                   |   1 +
 security/selinux/ss/services.c                  |  21 ++---
 sound/soc/ux500/mop500.c                        |   4 +
 sound/soc/ux500/ux500_pcm.c                     |   5 ++
 45 files changed, 348 insertions(+), 202 deletions(-)
