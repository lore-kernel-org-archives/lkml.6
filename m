Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3715653-1526636108-2-12202499777722420454
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526636107; b=PukD1+fyuG12w40wOUvMwKySXVi/mb4MpnMIo6Dwp3x+8fpla+
    vKVclJY3uis4fPbGhO3K4z0U2rkds0XVys54dXPGtHTPlGH50v2euxd2JnxIkftp
    fGaDc/bEzDfFxCG955bGp/nWPKa+Tnz4gGkFl40bmJdLBMMnscug2vs0Y8MJvLu0
    mzFJXn6hr1YVRXZNEKn/AudbhjtAano9mVumJavEb3Mng494eZ/YGQeXlrNrYAUu
    gH9gV3lPJZRXVo1gLOsQjkjDPhOXsdud0O6HtPCGJdJDn8aK/oONLJgtrKlQbBZf
    oICl0jpv/WFXVPnH2+Et9Ijirm47XfpMdyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526636107; bh=OpO+tgFpKvsvKfQpVIrnZBRchQnnri
    HkHXt313+XUss=; b=UBo8Shch9ijNH41ndTcd4jje+lcx/yTTpH7eRFqogU/YsB
    oPX6bdHAvWbnEkcPkhrfx0S0r7fzbH/tQufv3UG+/CFcDN0lPIcj/HUf5KNdSgJI
    vfM9zw1vjGkbCNCiycJhBdpr7w1iB+XGN6S5puCZuh5ahx9Mdopc4n4N+KdIbLlT
    77aestZ30eotY1rebePgCHPR1owQWIsqSMtL7dhaiobYLoLPKzdMNMpB2VBmABT+
    XQmnuPrN9S3VA3cTECDUd5B8zjJf0qVaDnQTqzPAn1WWgyBTrMtHnnH7oFnXapT0
    P7vVgEPli6ws9GM90vg7Lua/la0kpsNTr8dcCqlg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=D1oZwO8X x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=D1oZwO8X x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCvRmZueFb6ET0GUyzD6YKoSUlpCREQ1qL4AwWB7TlNOxU5OisgEnI9Av9ulCm0gJgVyRf9nRo7YkLWQvR2Jw/olWpmKE0Xn4T0CyZ8UQOswp9Ef9efF
    WeH2aIfTY2aUsdsoLfoj96eN1PZyvHwhfXR2+XDxTEDUG6u2H7TbnjSPmdgJH3qGXni+ldkWpFRSlZHkuofAwenldrK7YZir2g0lqiVE2FueWjAy/IaO+1Zy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=cED_tJPvky8A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=MYakio4dAAAA:8
    a=uBuKx8GwAAAA:8 a=VnNF1IyMAAAA:8 a=P-IC7800AAAA:8 a=CbDCq_QkAAAA:8
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=LD2kUS3hAAAA:8
    a=jZVsG21pAAAA:8 a=X7Ea-ya5AAAA:8 a=Q-fNiiVtAAAA:8 a=-nPe0ZbFAAAA:8
    a=FOH2dFAWAAAA:8 a=A7XncKjpAAAA:8 a=sozttTNsAAAA:8 a=uVVE2sHfDrTw2vXYte4A:9
    a=QEXdDO2ut3YA:10 a=E2q1x9kB5HEA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=cei-m1nUyINrUup_78-m:22 a=wZgZ3yaTFkxMEWn-yT5t:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=1qrBK16LubpBFNPVNq2M:22 a=FTB9xuwByZgvWSGbqjUc:22
    a=3Sh2lD0sZASs_lUdrUhf:22 a=f3QdawHiMRSDlnPgGXNW:22 a=Fp8MccfUoT0GBdDC_Lng:22
    a=k4lkcq4DNYWinfFV1uuM:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=R9rPLQDAdC6-Ub70kJmZ:22
    a=aeg5Gbbo78KNqacMgKqU:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeERJev (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 05:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752475AbeERIRU (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 18 May 2018 04:17:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/55] 4.16.10-stable review
Date: Fri, 18 May 2018 10:14:56 +0200
Message-Id: <20180518081457.428920292@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.10-rc1
X-KernelTest-Deadline: 2018-05-20T08:14+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.10 release.
There are 55 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun May 20 08:14:42 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.10-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.10-rc1

Willy Tarreau <w@1wt.eu>
    proc: do not access cmdline nor environ from file-backed areas

Dave Carroll <david.carroll@microsemi.com>
    scsi: aacraid: Correct hba_send to include iu_type

Ursula Braun <ubraun@linux.ibm.com>
    net/smc: keep clcsock reference in smc_tcp_listen_work()

Antoine Tenart <antoine.tenart@bootlin.com>
    net: phy: sfp: fix the BR,min computation

Israel Rukshin <israelr@mellanox.com>
    net/mlx5: Fix mlx5_get_vector_affinity function

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    mlxsw: core: Fix an error handling path in 'mlxsw_core_bus_device_register()'

Hangbin Liu <liuhangbin@gmail.com>
    ipv4: reset fnhe_mtu_locked after cache route flushed

Mohammed Gamal <mgamal@redhat.com>
    hv_netvsc: Fix net device attach on older Windows hosts

Eric Dumazet <edumazet@google.com>
    tipc: fix one byte leak in tipc_sk_set_orig_addr()

Eric Dumazet <edumazet@google.com>
    tcp: restore autocorking

Xin Long <lucien.xin@gmail.com>
    sctp: clear the new asoc's stream outcnt in sctp_stream_update

John Hurley <john.hurley@netronome.com>
    nfp: flower: set tunnel ttl value to net default

Florian Fainelli <f.fainelli@gmail.com>
    net: systemport: Correclty disambiguate driver instances

Huy Nguyen <huyn@mellanox.com>
    net/mlx5e: DCBNL fix min inline header size for dscp

Ido Schimmel <idosch@mellanox.com>
    mlxsw: spectrum_switchdev: Do not remove mrouter port from MDB's ports list

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

Ursula Braun <ubraun@linux.ibm.com>
    net/smc: restrict non-blocking connect finish

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

 Makefile                                           |   4 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/net/bonding/bond_alb.c                     |  15 +--
 drivers/net/bonding/bond_main.c                    |   2 +
 drivers/net/ethernet/broadcom/bcmsysport.c         |  16 ++-
 drivers/net/ethernet/broadcom/tg3.c                |   9 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    |  16 +++
 drivers/net/ethernet/mellanox/mlx4/en_netdev.c     |   8 +-
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   7 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  20 ++--
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |  11 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  23 ++--
 drivers/net/ethernet/mellanox/mlxsw/core.c         |   4 +-
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  12 +--
 drivers/net/ethernet/netronome/nfp/flower/action.c |  10 +-
 drivers/net/ethernet/netronome/nfp/flower/cmsg.h   |   5 +-
 drivers/net/ethernet/realtek/8139too.c             |   2 +-
 drivers/net/ethernet/realtek/r8169.c               |   3 +
 drivers/net/ethernet/sun/niu.c                     |   5 +-
 drivers/net/ethernet/ti/cpsw.c                     |   2 +
 drivers/net/hyperv/netvsc_drv.c                    |   3 +-
 drivers/net/hyperv/rndis_filter.c                  |   2 +-
 drivers/net/phy/sfp-bus.c                          |   2 +-
 drivers/net/usb/qmi_wwan.c                         |  12 +++
 drivers/scsi/aacraid/commsup.c                     |   8 +-
 fs/proc/base.c                                     |   8 +-
 include/linux/mlx5/driver.h                        |  12 +--
 include/linux/mm.h                                 |   1 +
 include/net/bonding.h                              |   1 +
 include/net/tls.h                                  |   1 +
 mm/gup.c                                           |   3 +
 net/bridge/br_if.c                                 |   4 +-
 net/compat.c                                       |   6 +-
 net/dccp/ccids/ccid2.c                             |  14 ++-
 net/dccp/timer.c                                   |   2 +-
 net/ipv4/ping.c                                    |   7 +-
 net/ipv4/route.c                                   | 119 ++++++++++-----------
 net/ipv4/tcp.c                                     |   5 +-
 net/ipv4/tcp_bbr.c                                 |   4 +-
 net/ipv4/udp.c                                     |  11 +-
 net/ipv6/route.c                                   |   7 +-
 net/ipv6/udp.c                                     |   4 +-
 net/llc/af_llc.c                                   |   3 +
 net/nsh/nsh.c                                      |   4 +
 net/openvswitch/flow_netlink.c                     |   9 +-
 net/rds/recv.c                                     |   1 +
 net/sched/act_skbmod.c                             |   5 +-
 net/sched/cls_api.c                                |   2 +-
 net/sched/sch_fq.c                                 |  37 ++++---
 net/sctp/associola.c                               |  30 +++++-
 net/sctp/inqueue.c                                 |   2 +-
 net/sctp/ipv6.c                                    |   3 +
 net/sctp/sm_statefuns.c                            |  88 ++++++++-------
 net/sctp/stream.c                                  |   2 +
 net/sctp/ulpevent.c                                |   1 -
 net/smc/af_smc.c                                   |  18 ++--
 net/tipc/socket.c                                  |   3 +-
 net/tls/tls_main.c                                 |   8 ++
 60 files changed, 398 insertions(+), 245 deletions(-)
