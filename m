Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2270Egya6vxkvKeyr64oXz7T9a16nSZjJMz3MCqM0WocE1JsR4aVHeqADNk/5YuKptbbdPim
ARC-Seal: i=1; a=rsa-sha256; t=1518183967; cv=none;
        d=google.com; s=arc-20160816;
        b=WaMJ45FX3jtOrQBvV7f/znA7fcv1zJXxuaXA9JDQhHkTQHfzju5yWyKKAN2lCia4ZE
         YTK8cXufNVR0ENNLtXqheljKeM6jX6pDRM78Va32+RTGX2pU5FDDgf7xwWaZnCJgYss2
         F/jCetMSc+J0bOs2p9n0tOwyuLkW+vfIOJP7uVC3aSqmuNolteRT9Mlb6bbRt+ypTzws
         k/kLTBYKAVjcxTeGMMa+M66LnrJgwPFkXVj01MTqyzWaKASMDEljWgmd3ipuRURIUrej
         fYQY0j/fH3rjFomAZJla8slU0iXye48dOfHmVA14ak513My1oeqNZyh4SOXRVvD0Ku6B
         IyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=dAUTm7jCE4v+tHrvCenWqNHMjuDdhrWvdhuxBszI6xY=;
        b=ZZuX7cj9TJmVWLKYL2WfgLWVoQSxE0/pZFS4QxVKXRyEEZi8/+5Pg3CK+D2wKpHShs
         mo5VnnHbTveQPabl+B0S6aYIbtex9IMpYOzlAQ05/k2NUBn2Cxcupe/dNDCP9YMTNntL
         Xz4gIO8gS0mtlTptxZMUgifF07/iu0e9ukcQl3lsTRYn2e7PMB72N2cr9yIl4A24Kl+Y
         XUbWP9oocD684pUTZLDPN8wUpPH1EMDCxIXANxfPJSmV5P+m02IEwOfB7FxeHCt/3Pa7
         y9N671W+UsKHWR8On3S8+LbMWe2KSkZsYH6N35hlyxCJeOm3iMcOsab1BXEn4WFkiNOP
         dWTw==
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
Subject: [PATCH 4.14 00/22] 4.14.19-stable review
Date: Fri,  9 Feb 2018 14:39:49 +0100
Message-Id: <20180209133934.024795822@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.19-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.19-rc1
X-KernelTest-Deadline: 2018-02-11T13:39+00:00
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591931271366574701?=
X-GMAIL-MSGID: =?utf-8?q?1591931271366574701?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.19 release.
There are 22 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb 11 13:39:12 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.19-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.19-rc1

Dan Carpenter <dan.carpenter@oracle.com>
    scsi: storvsc: missing error code in storvsc_probe()

Andrew Morton <akpm@linux-foundation.org>
    kernel/exit.c: export abort() to modules

Sudip Mukherjee <sudipm.mukherjee@gmail.com>
    arch: define weak abort()

Robert Baronescu <robert.baronescu@nxp.com>
    crypto: tcrypt - fix S/G table for test_aead_speed()

Jesse Chan <jc@linux.com>
    media: soc_camera: soc_scale_crop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION

Eric Dumazet <edumazet@google.com>
    soreuseport: fix mem leak in reuseport_add_sock()

Martin KaFai Lau <kafai@fb.com>
    ipv6: Fix SO_REUSEPORT UDP socket with implicit sk_ipv6only

Neal Cardwell <ncardwell@google.com>
    tcp_bbr: fix pacing_gain to always be unity when using lt_bw

Jiri Pirko <jiri@mellanox.com>
    rocker: fix possible null pointer dereference in rocker_router_fib_event_work

David Ahern <dsahern@gmail.com>
    net: ipv6: send unsolicited NA after DAD

Roman Gushchin <guro@fb.com>
    Revert "defer call to mem_cgroup_sk_alloc()"

Jason Wang <jasowang@redhat.com>
    vhost_net: stop device during reset owner

Li RongQing <lirongqing@baidu.com>
    tcp: release sk_frag.page in tcp_disconnect

Chunhao Lin <hau@realtek.com>
    r8169: fix RTL8168EP take too long to complete driver initialization.

Kristian Evensen <kristian.evensen@gmail.com>
    qmi_wwan: Add support for Quectel EP06

Junxiao Bi <junxiao.bi@oracle.com>
    qlcnic: fix deadlock bug

Eric Dumazet <edumazet@google.com>
    net: igmp: add a missing rcu locking section

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    ip6mr: fix stale iterator

Masahiro Yamada <yamada.masahiro@socionext.com>
    kbuild: rpm-pkg: keep spec file until make mrproper

Masahiro Yamada <yamada.masahiro@socionext.com>
    .gitignore: move *.dtb and *.dtb.S patterns to the top-level .gitignore

Masahiro Yamada <yamada.masahiro@socionext.com>
    .gitignore: sort normal pattern rules alphabetically


-------------

Diffstat:

 .gitignore                                         | 49 ++++++++++++----------
 Makefile                                           |  4 +-
 arch/arc/boot/.gitignore                           |  1 -
 arch/arm/boot/.gitignore                           |  1 -
 arch/arm/kernel/traps.c                            |  1 -
 arch/arm64/boot/dts/.gitignore                     |  1 -
 arch/m32r/kernel/traps.c                           |  1 -
 arch/metag/boot/.gitignore                         |  1 -
 arch/microblaze/boot/.gitignore                    |  1 -
 arch/mips/boot/.gitignore                          |  1 -
 arch/nios2/boot/.gitignore                         |  1 -
 arch/powerpc/boot/.gitignore                       |  1 -
 arch/unicore32/kernel/traps.c                      |  1 -
 arch/xtensa/boot/.gitignore                        |  1 -
 crypto/tcrypt.c                                    |  6 ++-
 .../media/platform/mtk-vcodec/mtk_vcodec_util.c    |  3 ++
 drivers/media/platform/soc_camera/soc_scale_crop.c |  4 ++
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    | 18 ++++----
 drivers/net/ethernet/realtek/r8169.c               |  4 +-
 drivers/net/ethernet/rocker/rocker_main.c          | 18 ++++----
 drivers/net/usb/qmi_wwan.c                         |  1 +
 drivers/of/unittest-data/.gitignore                |  2 -
 drivers/scsi/storvsc_drv.c                         |  4 +-
 drivers/vhost/net.c                                |  1 +
 kernel/exit.c                                      |  9 ++++
 mm/memcontrol.c                                    | 14 +++++++
 net/core/sock.c                                    |  5 +--
 net/core/sock_reuseport.c                          | 35 +++++++++-------
 net/ipv4/igmp.c                                    |  4 ++
 net/ipv4/inet_connection_sock.c                    |  1 -
 net/ipv4/tcp.c                                     |  6 +++
 net/ipv4/tcp_bbr.c                                 |  6 +--
 net/ipv6/addrconf.c                                | 30 +++++++++++--
 net/ipv6/af_inet6.c                                | 11 +++--
 net/ipv6/ip6mr.c                                   |  1 +
 net/ipv6/ndisc.c                                   |  5 +++
 scripts/package/Makefile                           |  4 +-
 37 files changed, 164 insertions(+), 93 deletions(-)
