Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-402196-1526281598-2-14371616676782948331
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
    1526281596; b=nU1e4Wes7kQrYYeGsvLh7rt8cCMX0AsmYp4zDbM/3AQJfIDV8c
    OGWpGonQtpyT0eeUQETCuXNjZ6VUBLvBDXE2X4oS8+Qo6CHAf4jWOa3N2i2G2Cfk
    cRaS3+2jpQoQEmlmxGjxy3ET1nuBEyMF28EzlUUDPDyNJQjZq3VW51mP9D+42S7r
    K3UxYW8e4WdPsidsqzDOHy1M1Lta4HOxkW6SQGdmRMOlu7dRDLLlIfirsrJlcPdj
    HhdMWRXXxYpPpThFD1MqZMSrneTdumcmySlDzTi9RetcUfrMdNBXgy6/dujP5hiM
    JFjM7hB5ZGj6vCsLvjs+8WgVZvmhoG1EGhew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526281596; bh=PFYOY7WA65dzLxznRsEKBJmDvFpyKF
    bTQxqo8uWinKM=; b=BoNtXXrKy8EP4YFMkNDLAoyZQ27u4BPJ50c4NcAVyccd/B
    l2S4PyiARMRXr2qAPm554CPl+p279L7BKyfYCErg1dxtK5AJrZMWX3Pc+W4/sUH6
    hJANo3210alFumMH73ptyT2Q3RCHfa2WLcEXeWoJxcyb//ClCOb7nbiRzAdoCo6D
    DlVG74T1Xz5HjUyPq9n9cVS7qHaap4WI82pc7UR5himnmWmD/ldeKihmxJucb4Nq
    GprYpOfAHWhotiagQKrnRYiuaMcbjzpb5RiETe7Z9q9cLJEnruErJ9pJSf9wB+XG
    6JSRxiypeAosxCuKFOPZnuXOZba0l1blbCDXeSUg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=SEijt1TB x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=SEijt1TB x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfABpGuQnFMFN4WGYrcN167AZC5CIbeImgCvia11lhcnz3HtVNCEazeeHvgoiNXMjyiHf/niBErks7KCU+93uU6Zqtks4RprbK7bprA7P9PqYnU9VSZeA
    PFwKqW4vS8xM4HLtP5exT4hiOzYhSq85zvLZtgj1ZLM1xU5bRvO5OuoNbaPleFhCA+m/ekoGgP40EJynIkJKP3Sc4g5yWH4Hz63hovyRWIDs9J6E9aR+w2wj
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=9wKpNP2GB4IA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=JfrnYn6hAAAA:8
    a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=hD80L64hAAAA:8 a=20KFwNOVAAAA:8
    a=DfNHnWVPAAAA:8 a=_Wotqz80AAAA:8 a=ohsIiSDVAAAA:8 a=zd2uoN0lAAAA:8
    a=P-IC7800AAAA:8 a=t0M9nft4AAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8
    a=meVymXHHAAAA:8 a=926zIK9uAAAA:8 a=LpQP-O61AAAA:8 a=NufY4J3AAAAA:8
    a=iox4zFpeAAAA:8 a=FOH2dFAWAAAA:8 a=h-jsSio6AAAA:8 a=sozttTNsAAAA:8
    a=CUMve9cLwR4YaGeW1PcA:9 a=QEXdDO2ut3YA:10 a=N53muDpBR4cA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=rjTVMONInIDnV1a_A2c_:22 a=buJP51TR1BpY-zbLSsyS:22 a=J4EZS_wvcqfZtXBG9__x:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=9blVyPJtsqGH_lG0htnH:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=LlT7wNnaD8DP1V76ktP_:22 a=pioyyrs4ZptJ924tMmac:22 a=TPcZfFuj8SYsoCJAFAiX:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754045AbeENHGc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754047AbeENG7S (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:59:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.16 00/72] 4.16.9-stable review
Date: Mon, 14 May 2018 08:48:17 +0200
Message-Id: <20180514064823.033169170@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.9-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.16.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.16.9-rc1
X-KernelTest-Deadline: 2018-05-16T06:48+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.16.9 release.
There are 72 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May 16 06:47:58 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.9-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.16.9-rc1

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

Peter Zijlstra <peterz@infradead.org>
    sched/autogroup: Fix possible Spectre-v1 indexing for sched_prio_to_weight[]

Peter Zijlstra <peterz@infradead.org>
    sched/core: Fix possible Spectre-v1 indexing for sched_prio_to_weight[]

Jean Delvare <jdelvare@suse.de>
    swiotlb: silent unwanted warning "buffer is full"

Steve French <smfrench@gmail.com>
    smb3: directory sync should not return an error

Charles Machalow <charles.machalow@intel.com>
    nvme: Fix sync controller reset return

Jens Axboe <axboe@kernel.dk>
    nvme: add quirk to force medium priority for SQ creation

Marek Szyprowski <m.szyprowski@samsung.com>
    thermal: exynos: Propagate error value from tmu_read()

Marek Szyprowski <m.szyprowski@samsung.com>
    thermal: exynos: Reading temperature makes sense only when TMU is turned on

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: btusb: Only check needs_reset_resume DMI table for QCA rome chipsets

Hans de Goede <hdegoede@redhat.com>
    Bluetooth: btusb: Add Dell XPS 13 9360 to btusb_needs_reset_resume_table

Hans de Goede <hdegoede@redhat.com>
    Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    arm: dts: imx[35]*: declare flexcan devices to be compatible to imx25's flexcan

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    cpufreq: schedutil: Avoid using invalid next_freq

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PCI / PM: Check device_may_wakeup() in pci_enable_wake()

Kai Heng Feng <kai.heng.feng@canonical.com>
    PCI / PM: Always check PME wakeup capability for runtime wakeup support

Gustavo A. R. Silva <gustavo@embeddedor.com>
    atm: zatm: Fix potential Spectre v1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: atm: Fix potential Spectre v1

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/atomic: Clean private obj old_state/new_state in drm_atomic_state_default_clear()

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm/atomic: Clean old_state/new_state in drm_atomic_state_default_clear()

Ben Skeggs <bskeggs@redhat.com>
    drm/nouveau/ttm: don't dereference nvbo::cli, it can outlive client

Lyude Paul <lyude@redhat.com>
    drm/nouveau: Fix deadlock in nv50_mstm_register_connector()

Rodrigo Vivi <rodrigo.vivi@intel.com>
    drm/i915: Adjust eDP's logical vco in a reliable place.

Florent Flament <contact@florentflament.com>
    drm/i915: Fix drm:intel_enable_lvds ERROR message in kernel log

Michel Dänzer <michel.daenzer@amd.com>
    drm/ttm: Use GFP_TRANSHUGE_LIGHT for allocating huge pages

Boris Brezillon <boris.brezillon@bootlin.com>
    drm/vc4: Fix scaling of uni-planar formats

Boris Brezillon <boris.brezillon@bootlin.com>
    mtd: rawnand: Make sure we wait tWB before polling the STATUS reg

Miquel Raynal <miquel.raynal@bootlin.com>
    mtd: rawnand: marvell: fix command xtype in BCH write hook

Chris Packham <chris.packham@alliedtelesis.co.nz>
    mtd: rawnand: marvell: pass ms delay to wait_op

Lukas Wunner <lukas@wunner.de>
    can: hi311x: Work around TX complete interrupt erratum

Lukas Wunner <lukas@wunner.de>
    can: hi311x: Acquire SPI lock on ->do_get_berr_counter

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    can: flexcan: fix endianess detection

Ilya Dryomov <idryomov@gmail.com>
    ceph: fix rsize/wsize capping in ceph_direct_read_write()

David Rientjes <rientjes@google.com>
    mm, oom: fix concurrent munlock and oom reaper unmap, v3

Pavel Tatashin <pasha.tatashin@oracle.com>
    mm: sections are not offlined during memory hotremove

Vitaly Wool <vitalywool@gmail.com>
    z3fold: fix reclaim lock-ups

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix regex_match_front() to not over compare the test string

Mikulas Patocka <mpatocka@redhat.com>
    dm integrity: use kvfree for kvmalloc'd memory

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

Jann Horn <jannh@google.com>
    compat: fix 4-byte infoleak via uninitialized struct field

Jan Kara <jack@suse.cz>
    bdi: Fix oops in wb_workfn()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    bdi: Fix use after free bug in debugfs_remove()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    bdi: wake up concurrent wb_shutdown() callers.

Eric Dumazet <edumazet@google.com>
    tcp: fix TCP_REPAIR_QUEUE bound checking

Alexander Popov <alex.popov@linux.com>
    i2c: dev: prevent ZERO_SIZE_PTR deref in i2cdev_ioctl_rdwr()

Jiri Olsa <jolsa@kernel.org>
    perf: Remove superfluous allocation error check

Michal Hocko <mhocko@suse.com>
    memcg: fix per_node_info cleanup

Yonghong Song <yhs@fb.com>
    bpf/tracing: fix a deadlock in perf_event_detach_bpf_prog

Eric Dumazet <edumazet@google.com>
    inetpeer: fix uninit-value in inet_getpeer

Eric Dumazet <edumazet@google.com>
    soreuseport: initialise timewait reuseport field

Eric Dumazet <edumazet@google.com>
    ipv4: fix uninit-value in ip_route_output_key_hash_rcu()

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

Sowmini Varadhan <sowmini.varadhan@oracle.com>
    rds: tcp: must use spin_lock_irq* and not spin_lock_bh with rds_tcp_conn_lock

Tom Herbert <tom@quantonium.net>
    kcm: Call strp_stop before strp_done in kcm_attach

Tero Kristo <t-kristo@ti.com>
    clk: ti: fix flag space conflict with clkctrl clocks

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: don't attempt to allocate 0-sized compat array

Julian Anastasov <ja@ssi.bg>
    ipvs: fix rtnl_lock lockups caused by start_sync_thread


-------------

Diffstat:

 Makefile                                 |   4 +-
 arch/arm/boot/dts/imx35.dtsi             |   4 +-
 arch/arm/boot/dts/imx53.dtsi             |   4 +-
 arch/x86/events/core.c                   |   8 +-
 arch/x86/events/intel/cstate.c           |   2 +
 arch/x86/events/msr.c                    |   9 +-
 crypto/af_alg.c                          |   8 +-
 drivers/ata/libata-core.c                |   3 +
 drivers/atm/zatm.c                       |   3 +
 drivers/bluetooth/btusb.c                |  19 +++-
 drivers/clk/ti/clock.h                   |   9 +-
 drivers/gpio/gpio-aspeed.c               |   2 +-
 drivers/gpio/gpiolib.c                   |   7 +-
 drivers/gpu/drm/drm_atomic.c             |   8 ++
 drivers/gpu/drm/i915/intel_cdclk.c       |  41 +++++++-
 drivers/gpu/drm/i915/intel_dp.c          |  20 ----
 drivers/gpu/drm/i915/intel_lvds.c        |   3 +-
 drivers/gpu/drm/nouveau/nouveau_bo.c     |   1 -
 drivers/gpu/drm/nouveau/nouveau_bo.h     |   2 -
 drivers/gpu/drm/nouveau/nouveau_ttm.c    |   6 +-
 drivers/gpu/drm/nouveau/nv50_display.c   |   7 +-
 drivers/gpu/drm/ttm/ttm_page_alloc.c     |  11 ++-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c |   3 +-
 drivers/gpu/drm/vc4/vc4_plane.c          |   2 +-
 drivers/i2c/i2c-dev.c                    |   2 +-
 drivers/md/dm-integrity.c                |   2 +-
 drivers/mtd/nand/marvell_nand.c          |  12 ++-
 drivers/mtd/nand/nand_base.c             |   5 +
 drivers/net/can/flexcan.c                |  26 +++---
 drivers/net/can/spi/hi311x.c             |  11 ++-
 drivers/net/can/usb/kvaser_usb.c         |   2 +-
 drivers/nvme/host/core.c                 |   3 +-
 drivers/nvme/host/nvme.h                 |   5 +
 drivers/nvme/host/pci.c                  |  12 ++-
 drivers/pci/pci.c                        |  37 ++++++--
 drivers/thermal/samsung/exynos_tmu.c     |  14 ++-
 fs/ceph/file.c                           |  10 +-
 fs/cifs/cifsfs.c                         |  13 +++
 fs/fs-writeback.c                        |   2 +-
 include/linux/bpf.h                      |   4 +-
 include/linux/oom.h                      |   2 +
 include/linux/wait_bit.h                 |  17 ++++
 include/net/inet_timewait_sock.h         |   1 +
 include/net/nexthop.h                    |   2 +-
 kernel/bpf/core.c                        |  45 +++++----
 kernel/compat.c                          |   1 +
 kernel/events/callchain.c                |  10 +-
 kernel/events/ring_buffer.c              |   7 +-
 kernel/sched/autogroup.c                 |   7 +-
 kernel/sched/core.c                      |   7 +-
 kernel/sched/cpufreq_schedutil.c         |   3 +-
 kernel/trace/bpf_trace.c                 |  25 ++++-
 kernel/trace/trace_events_filter.c       |   3 +
 kernel/trace/trace_uprobe.c              |   2 +
 lib/swiotlb.c                            |   2 +-
 mm/backing-dev.c                         |   3 +-
 mm/memcontrol.c                          |   3 +
 mm/mmap.c                                |  44 +++++----
 mm/oom_kill.c                            |  81 ++++++++--------
 mm/sparse.c                              |   2 +-
 mm/z3fold.c                              |  42 ++++++---
 net/atm/lec.c                            |   9 +-
 net/bridge/netfilter/ebtables.c          |  11 ++-
 net/core/dev_addr_lists.c                |   4 +-
 net/core/skbuff.c                        |   1 +
 net/dccp/ipv4.c                          |   1 +
 net/dccp/ipv6.c                          |   1 +
 net/ipv4/inet_timewait_sock.c            |   1 +
 net/ipv4/inetpeer.c                      |   1 +
 net/ipv4/route.c                         |  11 ++-
 net/ipv4/tcp.c                           |   2 +-
 net/kcm/kcmsock.c                        |   1 +
 net/netfilter/ipvs/ip_vs_ctl.c           |   8 --
 net/netfilter/ipvs/ip_vs_sync.c          | 155 ++++++++++++++++---------------
 net/netlink/af_netlink.c                 |   2 +
 net/rds/tcp.c                            |  17 ++--
 net/rfkill/rfkill-gpio.c                 |   7 +-
 77 files changed, 563 insertions(+), 324 deletions(-)
