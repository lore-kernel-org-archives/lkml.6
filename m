Return-Path: <SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr7Fzehvo1VNpB/aeBmRWc/rZ+BjLY2sxhU6AS59mgdkZVV1AHGFTmGt2FT1nxJ2JX8CLhL
ARC-Seal: i=1; a=rsa-sha256; t=1526631735; cv=none;
        d=google.com; s=arc-20160816;
        b=wErnt0BVWW+7IEdvcK/OvLHoM4PIC/8Dn0EyhVg/SFtFgr9SoAueqlCtUx9LrnpoZW
         UtdUz+1lV7GQxQvqQYsxm20rnC9WYmafQhEVQCX/BUjCz7Q4AUzegvOo6ADRBBdacgDY
         hx0uHPnCJpufYi845B945Dn8SWhV32m0daTkQszO7dMfXjyAffE3fSCxGZ2Sg9Qm6cha
         WXr/Ujq9NBQpeEiHZpMd/yGyZXrYmbWadVMPDY7GpCZL7FafzyHSSWUXSIQU0Lx9xc7G
         QxI4RsJiSEvaHu8HlQh4e5gJ8+rvqBXOF7E41xY+RrVN9k8XsZD2M6ggI2wOItFN2ZOW
         G6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:user-agent:mime-version:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=iAURF+DYRgeL6NYikc1FG6zGuc7b/jgAGrBz0vnhvmo=;
        b=kY2GvioDDMQ9qYoEBiKPcnH6h03RJJlSaiRujoohvi6SEvMukpVb4NjOJVDsM6vLMk
         0sfs6ThorqF3u0II3rADhp1MGPd51CSGOdMUEuxvvQZvBrEbME4NPOpchu/eqE7qzD1J
         p6gMvoND5IfuA3SJN5m1/bSHxGkrrEXZc+b3njfVveIRkVkt1Gymg2hrasCq1vghIdQ1
         4x7QwybFQuRFMjU+nRjy5+X6aO7nmg1KymJczPHP+KxU3RUaHAfklLfi++pnyx84ukhb
         pfz/JFrFUfWmo61LN9IfUhcPKr0MYwGlJeT3cXsEh4ktha33MUnHZGT4sZpvcxWuAhGj
         vwkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=r4KLH2iG;
       spf=pass (google.com: domain of srs0=xuy6=if=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=XuY6=IF=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=r4KLH2iG;
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
Subject: [PATCH 4.9 00/33] 4.9.101-stable review
Date: Fri, 18 May 2018 10:15:39 +0200
Message-Id: <20180518081535.096308218@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.101-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.101-rc1
X-KernelTest-Deadline: 2018-05-20T08:15+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1600789399035311439?=
X-GMAIL-MSGID: =?utf-8?q?1600789399035311439?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.101 release.
There are 33 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun May 20 08:15:20 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.101-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.101-rc1

Willy Tarreau <w@1wt.eu>
    proc: do not access cmdline nor environ from file-backed areas

Jakub Kicinski <jakub.kicinski@netronome.com>
    nfp: TX time stamp packets before HW doorbell is rung

James Chapman <jchapman@katalix.com>
    l2tp: revert "l2tp: fix missing print session offset info"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: imx6qdl-wandboard: Fix audio channel swap"

Vasily Averin <vvs@virtuozzo.com>
    lockd: lost rollback of set_grace_period() in lockd_down_net()

Antony Antony <antony@phenome.org>
    xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)

Jiri Slaby <jslaby@suse.cz>
    futex: Remove duplicated code and fix undefined behaviour

Alexey Khoroshilov <khoroshilov@ispras.ru>
    serial: sccnxp: Fix error handling in sccnxp_probe()

Xin Long <lucien.xin@gmail.com>
    sctp: delay the authentication for the duplicated cookie-echo chunk

Xin Long <lucien.xin@gmail.com>
    sctp: fix the issue that the cookie-ack with auth can't get processed

Yuchung Cheng <ycheng@google.com>
    tcp: ignore Fast Open on repair mode

Debabrata Banerjee <dbanerje@akamai.com>
    bonding: send learning packets for vlans on slave

Talat Batheesh <talatb@mellanox.com>
    net/mlx5: Avoid cleaning flow steering table twice during error flow

Debabrata Banerjee <dbanerje@akamai.com>
    bonding: do not allow rlb updates to invalid mac

Michael Chan <michael.chan@broadcom.com>
    tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Neal Cardwell <ncardwell@google.com>
    tcp_bbr: fix to zero idle_restart only upon S/ACKed data

Xin Long <lucien.xin@gmail.com>
    sctp: use the old asoc when making the cookie-ack chunk in dupcook_d

Xin Long <lucien.xin@gmail.com>
    sctp: remove sctp_chunk_put from fail_mark err path in sctp_ulpevent_make_rcvmsg

Xin Long <lucien.xin@gmail.com>
    sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix powering up RTL8168h

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: do not steal interfaces from class drivers

Stefano Brivio <sbrivio@redhat.com>
    openvswitch: Don't swap table in nlattr_set() after OVS_ATTR_NESTED is found

Lance Richardson <lance.richardson.net@gmail.com>
    net: support compat 64-bit time in {s,g}etsockopt

Eric Dumazet <edumazet@google.com>
    net_sched: fq: take care of throttled flows before reuse

Adi Nissim <adin@mellanox.com>
    net/mlx5: E-Switch, Include VF RDMA stats in vport statistics

Moshe Shemesh <moshe@mellanox.com>
    net/mlx4_en: Verify coalescing parameters are in range

Grygorii Strashko <grygorii.strashko@ti.com>
    net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode

Rob Taglang <rob@taglang.io>
    net: ethernet: sun: niu set correct packet size in skb

Eric Dumazet <edumazet@google.com>
    llc: better deal with too small mtu

Andrey Ignatov <rdna@fb.com>
    ipv4: fix memory leaks in udp_sendmsg, ping_v4_sendmsg

Eric Dumazet <edumazet@google.com>
    dccp: fix tasklet usage

Hangbin Liu <liuhangbin@gmail.com>
    bridge: check iface upper dev when setting master via ioctl

Ingo Molnar <mingo@elte.hu>
    8139too: Use disable_irq_nosync() in rtl8139_poll_controller()


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/alpha/include/asm/futex.h                     | 26 ++-----
 arch/arc/include/asm/futex.h                       | 40 ++--------
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |  1 -
 arch/arm/include/asm/futex.h                       | 26 +------
 arch/arm64/include/asm/futex.h                     | 27 +------
 arch/frv/include/asm/futex.h                       |  3 +-
 arch/frv/kernel/futex.c                            | 27 +------
 arch/hexagon/include/asm/futex.h                   | 38 +--------
 arch/ia64/include/asm/futex.h                      | 25 +-----
 arch/microblaze/include/asm/futex.h                | 38 +--------
 arch/mips/include/asm/futex.h                      | 25 +-----
 arch/parisc/include/asm/futex.h                    | 26 +------
 arch/powerpc/include/asm/futex.h                   | 26 ++-----
 arch/s390/include/asm/futex.h                      | 23 ++----
 arch/sh/include/asm/futex.h                        | 26 +------
 arch/sparc/include/asm/futex_64.h                  | 26 ++-----
 arch/tile/include/asm/futex.h                      | 40 ++--------
 arch/x86/include/asm/futex.h                       | 40 ++--------
 arch/xtensa/include/asm/futex.h                    | 27 ++-----
 drivers/net/bonding/bond_alb.c                     | 15 ++--
 drivers/net/bonding/bond_main.c                    |  2 +
 drivers/net/ethernet/broadcom/tg3.c                |  9 ++-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c    | 16 ++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h       |  7 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  | 11 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 21 +++--
 .../net/ethernet/netronome/nfp/nfp_net_common.c    |  4 +-
 drivers/net/ethernet/realtek/8139too.c             |  2 +-
 drivers/net/ethernet/realtek/r8169.c               |  3 +
 drivers/net/ethernet/sun/niu.c                     |  5 +-
 drivers/net/ethernet/ti/cpsw.c                     |  2 +
 drivers/net/usb/qmi_wwan.c                         | 12 +++
 drivers/tty/serial/sccnxp.c                        | 13 +++-
 fs/lockd/svc.c                                     |  2 +
 fs/proc/base.c                                     | 10 +--
 include/asm-generic/futex.h                        | 50 +++---------
 include/linux/mm.h                                 |  1 +
 include/net/bonding.h                              |  1 +
 kernel/futex.c                                     | 39 ++++++++++
 mm/gup.c                                           |  3 +
 net/bridge/br_if.c                                 |  4 +-
 net/compat.c                                       |  6 +-
 net/dccp/ccids/ccid2.c                             | 14 +++-
 net/dccp/timer.c                                   |  2 +-
 net/ipv4/ping.c                                    |  7 +-
 net/ipv4/tcp.c                                     |  2 +-
 net/ipv4/tcp_bbr.c                                 |  4 +-
 net/ipv4/udp.c                                     |  7 +-
 net/l2tp/l2tp_netlink.c                            |  2 -
 net/llc/af_llc.c                                   |  3 +
 net/openvswitch/flow_netlink.c                     |  9 +--
 net/sched/sch_fq.c                                 | 37 ++++++---
 net/sctp/associola.c                               | 30 +++++++-
 net/sctp/inqueue.c                                 |  2 +-
 net/sctp/ipv6.c                                    |  3 +
 net/sctp/sm_statefuns.c                            | 89 ++++++++++++----------
 net/sctp/ulpevent.c                                |  1 -
 net/xfrm/xfrm_state.c                              |  1 +
 59 files changed, 380 insertions(+), 585 deletions(-)
