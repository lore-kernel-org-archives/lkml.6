Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906373-1527164438-2-13703805191497755272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527164437; b=JiRzBCWdyDrSKZGlFxTqRmjo8pY9r97ibMjEW1Qy+yNcB6+4jN
    ih83mNhJy7qpBN0OplW8UcZjAxNh9EDow21D73s7I8B1evRABKQJAJA+weOHmYPx
    wEpVxOq76BfjM+v/dcANeWhqI1AjxmmGX0F4CycpAU0ZQ7Dmscd/G3+Luu+UzKgX
    oaNbKcbGcwsFotqrcJRDAqztYo34leFMvelf7C58Nhpgp98V5lZtw3P4O16eKCjJ
    i+xEQq7KmtBXBWxsTyADiqxYCRtahJUH34XBGakxWtAaZjjbQgvixKKFpeFDU16J
    WIqi7TMAQdkdMsSVoH2FkRs9CTtJUcsVyuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1527164437; bh=RsCnYErmLUpRL6D3WLr1tcMz9s+Cbi
    wBWXNiXmwoOcI=; b=nDU5ZqDHLByK++QH38AjpwHAbiFHZXdlh+qhOCB+7DKdUU
    O/XeClFVXWaiQmEycJXyKbYtEZiUP/PTLo0HbMUuhfgTIzj+zOnfe+ZpNWp1y/S2
    d/ce7GJVBquw+DncMMWzabOFHPvZBJqIF2o9LMe1seyti9GLDvv/2ndAbiwQUjuc
    WxOfjApJLRNBa+XFGnmeDA2RIyqi0RPXOZkNKh7dSUAf6Qby1pu3GzRfGwt4PsvE
    sI9fN0l3BWjGXv2h0R9LbC4xbqI+IYHgFz7OT4k7WxEkyipV7tVlmv2WbA1CyBlN
    36tcfwUZIPNH5WzAsyF/yEzniLFZrARAaznB5X3g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jVt/fpJE x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=jVt/fpJE x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDfFtGdCAkf6PSYszcco179hrI0l5+cQKICXSc1mnbCqdarkNUdSIxdHMN6K/7VxNjaYAGO3hopAjvY2muta1PYPmQi3YcI//iDWMyTeGY7btFZ88HhI
    yOwiXPzaFofVOKpsf4NHOmVSFbUB1ZnDYghYRH7CH/Qt/jqSU2Ba/3zQfv34G9toSTFZrLm3sZ0V+x7xgyRgFzMplYBkRCrxTAYxtCI/BQsqKSTgzuTJstXm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=MQJW2e49u_IA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8
    a=1XWaLZrsAAAA:8 a=i0EeH86SAAAA:8 a=drOt6m5kAAAA:8 a=yMhMjlubAAAA:8
    a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=meVymXHHAAAA:8 a=wMNdZWldAAAA:8
    a=J2zoVyZDAAAA:8 a=xjQjg--fAAAA:8 a=hD80L64hAAAA:8 a=9-efGfXaAAAA:8
    a=TYBLyS7eAAAA:8 a=X7Ea-ya5AAAA:8 a=Q-fNiiVtAAAA:8 a=CbDCq_QkAAAA:8
    a=FOH2dFAWAAAA:8 a=0cqKjQ2z8FOgYVdMUNAA:9 a=1ldaPwlFNOpW3c4E:21
    a=G8LKQDOLXEjSrY65:21 a=QEXdDO2ut3YA:10 a=lDnDdKCQng8A:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=cvBusfyB2V15izCimMoJ:22 a=2JgSa4NbpEOStq-L5dxp:22 a=FUarYpL4UH3yWsho8X8J:22
    a=DvW0qZC7_2Hvvf243_-1:22 a=L4vkcYpMSA5nFlNZ2tk3:22 a=76mzCeYM3W7A2q4738_3:22
    a=zvYvwCWiE4KgVXXeO06c:22 a=f3QdawHiMRSDlnPgGXNW:22 a=Fp8MccfUoT0GBdDC_Lng:22
    a=1qrBK16LubpBFNPVNq2M:22 a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966309AbeEXMUI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:20:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966044AbeEXJlb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/45] 3.18.110-stable review
Date: Thu, 24 May 2018 11:38:08 +0200
Message-Id: <20180524093120.599252450@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.110-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.110-rc1
X-KernelTest-Deadline: 2018-05-26T09:31+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.110 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat May 26 09:30:59 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.110-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.110-rc1

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    hfsplus: stop workqueue when fill_super() failed

Johannes Berg <johannes.berg@intel.com>
    cfg80211: limit wiphy names to 128 bytes

Alexander Potapenko <glider@google.com>
    scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: defer ata device eh commands to libata

Al Viro <viro@zeniv.linux.org.uk>
    ext2: fix a block leak

Eric Dumazet <edumazet@google.com>
    tcp: purge write queue in tcp_connect_init()

Willem de Bruijn <willemb@google.com>
    net: test tailroom before appending to linear skb

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions

Dexuan Cui <decui@microsoft.com>
    tick/broadcast: Use for_each_cpu() specially on UP kernels

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32' definition for mixed mode

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flush_tlb{_all}

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    powerpc: Don't preempt_disable() in show_cpuinfo()

Wenwen Wang <wang6495@umn.edu>
    ALSA: control: fix a redundant-copy issue

Federico Cuello <fedux@fedux.com.ar>
    ALSA: usb: mixer: volume quirk for CM102-A+/102S+

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: fix bad unlock balance during stub_probe()

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: fix NULL-ptr deref and use-after-free errors

Alexey Khoroshilov <khoroshilov@ispras.ru>
    usbip: fix error handling in stub_probe()

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: run rebind from exit when module is removed

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: delete device from busid_table after rebind

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: usbip_host: refine probe and disconnect debug msgs to be useful

zhongjiang <zhongjiang@huawei.com>
    kernel/exit.c: avoid undefined behaviour when calling wait4()

Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
    pipe: cap initial pipe capacity according to pipe-max-size limit

James Chapman <jchapman@katalix.com>
    l2tp: revert "l2tp: fix missing print session offset info"

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Revert "ARM: dts: imx6qdl-wandboard: Fix audio channel swap"

Vasily Averin <vvs@virtuozzo.com>
    lockd: lost rollback of set_grace_period() in lockd_down_net()

Bjørn Mork <bjorn@mork.no>
    qmi_wwan: do not steal interfaces from class drivers

Xin Long <lucien.xin@gmail.com>
    sctp: delay the authentication for the duplicated cookie-echo chunk

Xin Long <lucien.xin@gmail.com>
    sctp: fix the issue that the cookie-ack with auth can't get processed

Yuchung Cheng <ycheng@google.com>
    tcp: ignore Fast Open on repair mode

Debabrata Banerjee <dbanerje@akamai.com>
    bonding: do not allow rlb updates to invalid mac

Michael Chan <michael.chan@broadcom.com>
    tg3: Fix vunmap() BUG_ON() triggered from tg3_free_consistent().

Xin Long <lucien.xin@gmail.com>
    sctp: use the old asoc when making the cookie-ack chunk in dupcook_d

Heiner Kallweit <hkallweit1@gmail.com>
    r8169: fix powering up RTL8168h

Lance Richardson <lance.richardson.net@gmail.com>
    net: support compat 64-bit time in {s,g}etsockopt

Eric Dumazet <edumazet@google.com>
    net_sched: fq: take care of throttled flows before reuse

Moshe Shemesh <moshe@mellanox.com>
    net/mlx4_en: Verify coalescing parameters are in range

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

 Makefile                                        |   4 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi        |   1 -
 arch/arm/include/asm/assembler.h                |  10 +++
 arch/arm/kernel/traps.c                         |   5 +-
 arch/arm/lib/getuser.S                          |  10 +++
 arch/powerpc/kernel/setup-common.c              |  11 ---
 arch/powerpc/platforms/powernv/opal-nvram.c     |  14 +++-
 arch/x86/boot/compressed/eboot.c                |   6 +-
 arch/x86/kernel/machine_kexec_32.c              |   6 +-
 arch/x86/kernel/machine_kexec_64.c              |   4 +-
 arch/x86/xen/mmu.c                              |   4 -
 drivers/net/bonding/bond_alb.c                  |   2 +-
 drivers/net/ethernet/broadcom/tg3.c             |   9 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |  16 ++++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h    |   7 +-
 drivers/net/ethernet/realtek/8139too.c          |   2 +-
 drivers/net/ethernet/realtek/r8169.c            |   3 +
 drivers/net/ethernet/sun/niu.c                  |   5 +-
 drivers/net/usb/qmi_wwan.c                      |  13 +++
 drivers/scsi/libsas/sas_scsi_host.c             |  33 +++-----
 drivers/scsi/sg.c                               |   2 +-
 drivers/usb/usbip/stub.h                        |   2 +
 drivers/usb/usbip/stub_dev.c                    |  69 +++++++++-------
 drivers/usb/usbip/stub_main.c                   | 105 +++++++++++++++++++++---
 fs/ext2/inode.c                                 |  10 ---
 fs/hfsplus/super.c                              |   1 +
 fs/lockd/svc.c                                  |   2 +
 fs/pipe.c                                       |   3 +
 include/linux/efi.h                             |   8 +-
 include/trace/events/xen.h                      |  16 ----
 include/uapi/linux/nl80211.h                    |   2 +
 kernel/exit.c                                   |   4 +
 kernel/time/tick-broadcast.c                    |   8 ++
 net/bridge/br_if.c                              |   4 +-
 net/compat.c                                    |   6 +-
 net/dccp/ccids/ccid2.c                          |  14 +++-
 net/dccp/timer.c                                |   2 +-
 net/ipv4/ip_output.c                            |   3 +-
 net/ipv4/ping.c                                 |   7 +-
 net/ipv4/tcp.c                                  |   2 +-
 net/ipv4/tcp_output.c                           |   7 +-
 net/ipv4/udp.c                                  |   7 +-
 net/ipv6/ip6_output.c                           |   3 +-
 net/l2tp/l2tp_netlink.c                         |   2 -
 net/llc/af_llc.c                                |   3 +
 net/sched/sch_fq.c                              |  37 ++++++---
 net/sctp/associola.c                            |  30 ++++++-
 net/sctp/inqueue.c                              |   2 +-
 net/sctp/sm_statefuns.c                         |  89 +++++++++++---------
 net/wireless/core.c                             |   3 +
 sound/core/control_compat.c                     |   3 +-
 sound/usb/mixer.c                               |   8 ++
 52 files changed, 427 insertions(+), 202 deletions(-)
