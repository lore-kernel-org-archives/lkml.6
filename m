Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo1gPquf6ApoP8ffX7iCYs3Zn5GDwmqsltkMeRVZ7LxFzRiBsKQiseud/dBrQ39SJVcPJRu
ARC-Seal: i=1; a=rsa-sha256; t=1526631602; cv=none;
        d=google.com; s=arc-20160816;
        b=T7OP7sh05m41wtmaOw44rC5AShsSQqI+XuOndhC21FeRCtZlP3wlW0xV3qkJQOCXFq
         BedZ7NP2qNYD8Kb0G5RmfSfDGAhVuTwbEiD6sFhMNYViq3eIgQ7BvhH6vh4rJEeJoq0t
         fxZOcrrpVmapqgdEY/nM3nWHhhECYYkvIjbNzZxpUHwY8mYZI2RvxYHTEo+YJkO72DuI
         BBaVlcCG+rSPgzWpYKkwZNnx/846h/aOgq2O45oNJCaX3K1L82FKVxpzZ4wjC2nrA0+J
         x4WNyQmoir18RxtLHpV7lI3x/pycBpbYFT5X7DszsEbaSSBUx3p4d0Hg9sZGB0gNac9q
         Yh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=PnOTtlhWFzUtQs3X32WlH93eaor89T4jZIK7EiJqsSg=;
        b=v9XjoXwI3/aL+Iv0ru+/qUy6JRls+xysim4NL8r5OaLU51I7FqwVLYTKbR0mjac8//
         iKggIiPqgjUuTLQm2gBBULKub583MNnPzY8XhjGwGbguoP3tNN47tCg1o1GRaGxnFw8g
         csFK9GQiqVzKvA7tWwy0tY/ostPZHTW9YtbN/Tdam46+TT/wa0DzMtxcMmStIgWoTmDd
         RbyYG6h8VOEiqrpZeF6dxw2h+cil1VHx6Cl8E8ss/r/x7BhgT1IrImfRfNMiBjXKKfr+
         +9kkifNdncrs3P7R9+1Qza972L2+HdeAmsg2RoMXshsif10wo6ZnXvz7D/pPSjQvTCLY
         JWYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=s0/7ADM5;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=s0/7ADM5;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: [PATCH 4.14 00/45] 4.14.42-stable review
Date: Fri, 18 May 2018 10:15:17 +0200
Message-Id: <20180518081530.331586165@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.42-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.42-rc1
X-KernelTest-Deadline: 2018-05-20T08:15+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789259885055441?=
X-GMAIL-MSGID: =?utf-8?q?1600789259885055441?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.42 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun May 20 08:15:14 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.42-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.42-rc1

Willy Tarreau <w@1wt.eu>
    proc: do not access cmdline nor environ from file-backed areas

James Chapman <jchapman@katalix.com>
    l2tp: revert "l2tp: fix missing print session offset info"

Antony Antony <antony@phenome.org>
    xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)

ethanwu <ethanwu@synology.com>
    btrfs: Take trans lock before access running trans in check_delayed_ref

Herbert Xu <herbert@gondor.apana.org.au>
    xfrm: Use __skb_queue_tail in xfrm_trans_queue

Dave Carroll <david.carroll@microsemi.com>
    scsi: aacraid: Correct hba_send to include iu_type

Paolo Abeni <pabeni@redhat.com>
    udp: fix SO_BINDTODEVICE

Eric Dumazet <edumazet@google.com>
    nsh: fix infinite loop

Jianbo Liu <jianbol@mellanox.com>
    net/mlx5e: Allow offloading ipv4 header re-write for icmp

Eric Dumazet <edumazet@google.com>
    ipv6: fix uninit-value in ip6_multipath_l3_keys()

Stephen Hemminger <stephen@networkplumber.org>
    hv_netvsc: set master device

Talat Batheesh <talatb@mellanox.com>
    net/mlx5: Avoid cleaning flow steering table twice during error flow

Tariq Toukan <tariqt@mellanox.com>
    net/mlx5e: TX, Use correct counter in dma_map error flow

Jiri Pirko <jiri@mellanox.com>
    net: sched: fix error path in tcf_proto_create() when modules are not configured

Debabrata Banerjee <dbanerje@akamai.com>
    bonding: send learning packets for vlans on slave

Debabrata Banerjee <dbanerje@akamai.com>
    bonding: do not allow rlb updates to invalid mac

Michael Chan <michael.chan@broadcom.com>
    tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Yuchung Cheng <ycheng@google.com>
    tcp: ignore Fast Open on repair mode

Neal Cardwell <ncardwell@google.com>
    tcp_bbr: fix to zero idle_restart only upon S/ACKed data

Xin Long <lucien.xin@gmail.com>
    sctp: use the old asoc when making the cookie-ack chunk in dupcook_d

Xin Long <lucien.xin@gmail.com>
    sctp: remove sctp_chunk_put from fail_mark err path in sctp_ulpevent_make_rcvmsg

Xin Long <lucien.xin@gmail.com>
    sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr

Xin Long <lucien.xin@gmail.com>
    sctp: fix the issue that the cookie-ack with auth can't get processed

Xin Long <lucien.xin@gmail.com>
    sctp: delay the authentication for the duplicated cookie-echo chunk

Eric Dumazet <edumazet@google.com>
    rds: do not leak kernel memory to user land

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix powering up RTL8168h

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: do not steal interfaces from class drivers

Stefano Brivio <sbrivio@redhat.com>
    openvswitch: Don't swap table in nlattr_set() after OVS_ATTR_NESTED is found

Andre Tomt <andre@tomt.net>
    net/tls: Fix connection stall on partial tls record

Dave Watson <davejwatson@fb.com>
    net/tls: Don't recursively call push_record during tls_write_space callbacks

Lance Richardson <lance.richardson.net@gmail.com>
    net: support compat 64-bit time in {s,g}etsockopt

Eric Dumazet <edumazet@google.com>
    net_sched: fq: take care of throttled flows before reuse

Roman Mashak <mrv@mojatatu.com>
    net sched actions: fix refcnt leak in skbmod

Adi Nissim <adin@mellanox.com>
    net/mlx5: E-Switch, Include VF RDMA stats in vport statistics

Roi Dayan <roid@mellanox.com>
    net/mlx5e: Err if asked to offload TC match on frag being first

Moshe Shemesh <moshe@mellanox.com>
    net/mlx4_en: Verify coalescing parameters are in range

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    net/mlx4_en: Fix an error handling path in 'mlx4_en_init_netdev()'

Grygorii Strashko <grygorii.strashko@ti.com>
    net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode

Rob Taglang <rob@taglang.io>
    net: ethernet: sun: niu set correct packet size in skb

Eric Dumazet <edumazet@google.com>
    llc: better deal with too small mtu

Andrey Ignatov <rdna@fb.com>
    ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Julian Anastasov <ja@ssi.bg>
    ipv4: fix fnhe usage by non-cached routes

Eric Dumazet <edumazet@google.com>
    dccp: fix tasklet usage

Hangbin Liu <liuhangbin@gmail.com>
    bridge: check iface upper dev when setting master via ioctl

Ingo Molnar <mingo@elte.hu>
    8139too: Use disable_irq_nosync() in rtl8139_poll_controller()


-------------

Diffstat:

 Makefile                                          |   4 +-
 drivers/net/bonding/bond_alb.c                    |  15 +--
 drivers/net/bonding/bond_main.c                   |   2 +
 drivers/net/ethernet/broadcom/tg3.c               |   9 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c   |  16 +++
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c    |   8 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h      |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c   |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c   |  20 ++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |  23 +++--
 drivers/net/ethernet/realtek/8139too.c            |   2 +-
 drivers/net/ethernet/realtek/r8169.c              |   3 +
 drivers/net/ethernet/sun/niu.c                    |   5 +-
 drivers/net/ethernet/ti/cpsw.c                    |   2 +
 drivers/net/hyperv/netvsc_drv.c                   |   3 +-
 drivers/net/usb/qmi_wwan.c                        |  12 +++
 drivers/scsi/aacraid/commsup.c                    |   8 +-
 fs/btrfs/extent-tree.c                            |   7 ++
 fs/proc/base.c                                    |   8 +-
 include/linux/mm.h                                |   1 +
 include/net/bonding.h                             |   1 +
 include/net/tls.h                                 |   1 +
 mm/gup.c                                          |   3 +
 net/bridge/br_if.c                                |   4 +-
 net/compat.c                                      |   6 +-
 net/dccp/ccids/ccid2.c                            |  14 ++-
 net/dccp/timer.c                                  |   2 +-
 net/ipv4/ping.c                                   |   7 +-
 net/ipv4/route.c                                  | 118 ++++++++++------------
 net/ipv4/tcp.c                                    |   3 +-
 net/ipv4/tcp_bbr.c                                |   4 +-
 net/ipv4/udp.c                                    |  11 +-
 net/ipv6/route.c                                  |   7 +-
 net/ipv6/udp.c                                    |   4 +-
 net/l2tp/l2tp_netlink.c                           |   2 -
 net/llc/af_llc.c                                  |   3 +
 net/nsh/nsh.c                                     |   2 +
 net/openvswitch/flow_netlink.c                    |   9 +-
 net/rds/recv.c                                    |   1 +
 net/sched/act_skbmod.c                            |   5 +-
 net/sched/cls_api.c                               |   2 +-
 net/sched/sch_fq.c                                |  37 ++++---
 net/sctp/associola.c                              |  30 +++++-
 net/sctp/inqueue.c                                |   2 +-
 net/sctp/ipv6.c                                   |   3 +
 net/sctp/sm_statefuns.c                           |  88 ++++++++--------
 net/sctp/ulpevent.c                               |   1 -
 net/tls/tls_main.c                                |   8 ++
 net/xfrm/xfrm_input.c                             |   2 +-
 net/xfrm/xfrm_state.c                             |   1 +
 51 files changed, 349 insertions(+), 205 deletions(-)
