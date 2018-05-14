Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-411245-1526283228-2-15981502457091172973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526283227; b=E33Jt1TrRVaaPmecaAZK3VkHSX1Ut/PW9x28QZSij3LzVWLO0B
    11uLIMmBNG7pnM7gWi1jHxKaU69m+j9GgbAUHm7NEpSCvMHUFaksxRODI4DmdkUu
    +quT4y2lOws28vsLagzDNqgyFe0ZHonpyYtwSkY7xM50idUpJeE/1p0zqjwxQK6x
    dnOqBWTjv1+FxP2/mr26d00FmhYL7XXShJ2AsNlJyyjIcf0S2Am8SGoNsnnIj+CP
    tLRm8qW29s+aLHlw6QD5rP4A8xQUz6RWuNmKchoZPYm0EWO4ol3s7nv/Ek9V6gJ5
    KQxMyYCW51jNBb+el19+Cj2m73cTUSfTpAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526283227; bh=8dHUowg7iZCPuy1SgU1IuUAKatUn8U
    4s2J0eKXmRFlw=; b=S2yfJ94j4SKMZyIXS5+bMV2mCXSXQtxQf8w7AWuMNdcf1a
    uWC0PY4p0jEvt0rz6RHv3fHKqLkGW22IyYtl/3u5GWc/e4OuRyF28GS4Zwg/cnRv
    uN7+fNXRdTR2SOFFp/F391Rro/3eq3JnBLTOGJvpv02db4iZcLW21457m1X73aeD
    8D+pq8jzINPDeUl3xpcCP6RgIbGXUXcQBvllsEdoL4WrIqOZT+zwqEw87THuoxBo
    drgQqsvUkF1w6Wfvjdc+7OhBr1NIvM7zhCfcUlQs10QahLAzqq6PiDpfQePWMgV5
    /dFj+LuKrNBx4EvXPfS6zKI0bzv0Lbruq2alkwog==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ucaiSz8p x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ucaiSz8p x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfC1tBdzM87mQfh9KPZwpA0LqIJHtn8/bVaffSF8QuGd3XZxpkTuhASjSIeLB6vVZiYZzuc4M1WVRZeN9+xRVx6Zhgwi/Nmiy86u/7DFO8SQW3WQ5wYPC
    fmIrhoufCHocQwwX3jgLWrLNDD1ifPHFccKjhZWmoloYJb2YsHU+GKbankDjRRZvwZldNAFVXdzGAQgiHj9eVWvv4TmriI7AJv/MYPNe2mB6HmR8gQ9xD3f8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=TttDjgVrrK0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=JfrnYn6hAAAA:8
    a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8 a=_Wotqz80AAAA:8 a=ohsIiSDVAAAA:8
    a=P-IC7800AAAA:8 a=t0M9nft4AAAA:8 a=meVymXHHAAAA:8 a=926zIK9uAAAA:8
    a=LpQP-O61AAAA:8 a=7CQSdrXTAAAA:8 a=i0EeH86SAAAA:8 a=voM4FWlXAAAA:8
    a=1XWaLZrsAAAA:8 a=h-jsSio6AAAA:8 a=4W6lWNB8MfFgJdo1lXcA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=buJP51TR1BpY-zbLSsyS:22 a=J4EZS_wvcqfZtXBG9__x:22 a=d3PnA9EDa4IxuAV0gXij:22
    a=9blVyPJtsqGH_lG0htnH:22 a=2JgSa4NbpEOStq-L5dxp:22 a=LlT7wNnaD8DP1V76ktP_:22
    a=pioyyrs4ZptJ924tMmac:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=IC2XNlieTeVoXbcui8wp:22
    a=cKCw3X4OOXbpJNOXdmIM:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752979AbeENGyA (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:54:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752973AbeENGx7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:53:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 00/36] 4.9.100-stable review
Date: Mon, 14 May 2018 08:48:34 +0200
Message-Id: <20180514064804.252823817@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.100-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.100-rc1
X-KernelTest-Deadline: 2018-05-16T06:48+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.9.100 release.
There are 36 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May 16 06:47:47 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.100-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.100-rc1

Peter Zijlstra <peterz@infradead.org>
    perf/x86: Fix possible Spectre-v1 indexing for x86_pmu::event_map()

Peter Zijlstra <peterz@infradead.org>
    perf/core: Fix possible Spectre-v1 indexing for ->aux_pages[]

Peter Zijlstra <peterz@infradead.org>
    perf/x86/msr: Fix possible Spectre-v1 indexing in the MSR driver

Peter Zijlstra <peterz@infradead.org>
    perf/x86/cstate: Fix possible Spectre-v1 indexing for pkg_msr

Peter Zijlstra <peterz@infradead.org>
    perf/x86: Fix possible Spectre-v1 indexing for hw_perf_event cache_*

Masami Hiramatsu <mhiramat@kernel.org>
    tracing/uprobe_event: Fix strncpy corner case

Marek Szyprowski <m.szyprowski@samsung.com>
    thermal: exynos: Propagate error value from tmu_read()

Marek Szyprowski <m.szyprowski@samsung.com>
    thermal: exynos: Reading temperature makes sense only when TMU is turned on

Hans de Goede <hdegoede@redhat.com>
    Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"

Gustavo A. R. Silva <gustavo@embeddedor.com>
    atm: zatm: Fix potential Spectre v1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: atm: Fix potential Spectre v1

Florent Flament <contact@florentflament.com>
    drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Fix scaling of uni-planar formats

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix regex_match_front() to not over compare the test string

Hans de Goede <hdegoede@redhat.com>
    libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs

Johan Hovold <johan@kernel.org>
    rfkill: gpio: fix memory leak in probe error path

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    gpio: fix error path in lineevent_create

Govert Overgaauw <govert.overgaauw@prodrive-technologies.com>
    gpio: fix aspeed_gpio unmask irq

Timur Tabi <timur@codeaurora.org>
    gpioib: do not free unrequested descriptors

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Add work around for Arm Cortex-A55 Erratum 1024718

Wei Fang <fangwei1@huawei.com>
    f2fs: fix a dead loop in f2fs_fiemap()

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Fix trap number return from __kvmppc_vcore_entry

Jan Kara <jack@suse.cz>
    bdi: Fix oops in wb_workfn()

Eric Dumazet <edumazet@google.com>
    tcp: fix TCP_REPAIR_QUEUE bound checking

Jiri Olsa <jolsa@kernel.org>
    perf: Remove superfluous allocation error check

Eric Dumazet <edumazet@google.com>
    soreuseport: initialise timewait reuseport field

Eric Dumazet <edumazet@google.com>
    dccp: initialize ireq->ir_mark

Eric Dumazet <edumazet@google.com>
    net: fix uninit-value in __hw_addr_add_ex()

Eric Dumazet <edumazet@google.com>
    net: initialize skb->peeked when cloning

Eric Dumazet <edumazet@google.com>
    net: fix rtnh_ok()

Eric Dumazet <edumazet@google.com>
    netlink: fix uninit-value in netlink_sendmsg

Eric Dumazet <edumazet@google.com>
    crypto: af_alg - fix possible uninit-value in alg_bind()

Tom Herbert <tom@quantonium.net>
    kcm: Call strp_stop before strp_done in kcm_attach

Sagi Grimberg <sagi@grimberg.me>
    IB/device: Convert ib-comp-wq to be CPU-bound

Julian Anastasov <ja@ssi.bg>
    ipvs: fix rtnl_lock lockups caused by start_sync_thread


-------------

Diffstat:

 Documentation/arm64/silicon-errata.txt  |   1 +
 Makefile                                |   4 +-
 arch/arm64/Kconfig                      |  14 +++
 arch/arm64/include/asm/assembler.h      |  40 +++++++++
 arch/arm64/include/asm/cputype.h        |   5 ++
 arch/arm64/mm/proc.S                    |   5 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   8 +-
 arch/x86/events/core.c                  |   8 +-
 arch/x86/events/intel/cstate.c          |   2 +
 arch/x86/events/msr.c                   |   9 +-
 crypto/af_alg.c                         |   8 +-
 drivers/ata/libata-core.c               |   3 +
 drivers/atm/zatm.c                      |   3 +
 drivers/bluetooth/btusb.c               |   2 +-
 drivers/gpio/gpio-aspeed.c              |   2 +-
 drivers/gpio/gpiolib.c                  |   7 +-
 drivers/gpu/drm/i915/intel_lvds.c       |   3 +-
 drivers/gpu/drm/vc4/vc4_plane.c         |   2 +-
 drivers/infiniband/core/device.c        |   3 +-
 drivers/net/can/usb/kvaser_usb.c        |   2 +-
 drivers/thermal/samsung/exynos_tmu.c    |  14 ++-
 fs/f2fs/data.c                          |   2 +-
 fs/fs-writeback.c                       |   2 +-
 include/net/inet_timewait_sock.h        |   1 +
 include/net/nexthop.h                   |   2 +-
 kernel/events/callchain.c               |  10 +--
 kernel/events/ring_buffer.c             |   7 +-
 kernel/trace/trace_events_filter.c      |   3 +
 kernel/trace/trace_uprobe.c             |   2 +
 net/atm/lec.c                           |   9 +-
 net/core/dev_addr_lists.c               |   4 +-
 net/core/skbuff.c                       |   1 +
 net/dccp/ipv4.c                         |   1 +
 net/dccp/ipv6.c                         |   1 +
 net/ipv4/inet_timewait_sock.c           |   1 +
 net/ipv4/tcp.c                          |   2 +-
 net/kcm/kcmsock.c                       |   1 +
 net/netfilter/ipvs/ip_vs_ctl.c          |   8 --
 net/netfilter/ipvs/ip_vs_sync.c         | 155 ++++++++++++++++----------------
 net/netlink/af_netlink.c                |   2 +
 net/rfkill/rfkill-gpio.c                |   7 +-
 41 files changed, 238 insertions(+), 128 deletions(-)
