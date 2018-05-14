Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-436143-1526283705-2-8605013904473450226
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
    1526283704; b=B6+C0O2JjHdkti1/vk17CTA3ArcFvtbpzk94AVxskjBmwxC/uY
    aOR+jKTcl7fxI2O1yfUowaa4EaUUaKqO59h4xU/LtnUB0d5s9EZg8FE8NDft7Lja
    +XHl0OfaDv24XYQ0RKwAnWsvqVD9e3MbPcd2GXJI5cDZadCiUYFOwUV1/+xWeAlF
    bVsB6edtYufuqg8n+SYvXFkzBXN3F5eLy9tJK04yK8oz1gQtARRu1wxzVFajvasJ
    3kYIXYgBV0SAcig5qrk+JJ9BzCuv9BrWJwCwtESpG6TxX4JX4ivncv7Su5kCC9ty
    aNaR/MZJ9pSJ+QjYbtyoQJ6aBAYjK9r5366w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526283704; bh=f85petV7iljwsCwIK/dL146fZCz5C7
    XripxBPvW0ZLQ=; b=Jb3hMhyPDXCeGITZUIvwUqiSJIelgNaGlQXBP00hHj/HZk
    /XpnFQsyd3QGTbYx1Bu9JI8pa3RlvaR+8Vd1g1dFV53xONwvkDdewEQI2Sh47RT8
    NxDeoWWyh76Uz2WKbTPewcoqfqinjax+pik6d2nbfbMzyd5AMY8Kpkx7ujz3SNOJ
    r9oGC5exiZOMk0dxIVSWlSsD1G562QUL6Fg+eIBvcICOgohD35sJq/99m4CBhUvm
    RjvEUyRbycIyHzyqmYBIxS5OjWapevzdOr2+iwzwWGXA9xHtDh5ry/tViYrGUX6P
    s2EB6cm1jeNVrhzqftwSezL36265B+2gTSyGnefg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cI0SEL8e x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=cI0SEL8e x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFCBkwM3D7xBLyk385cS0lYO3okpOrCMv9pdS/gInPyfqExzwpybNE4DJ4dK6mjqkZ+gVlO5abrj36eKgvXryfQdw/zktW4ASshZSaKeK6gPElonW8YB
    VN20VhPCKeiXJTScTm7ZP0wUzQJZtempkym0OWmk46ld+iwLi6MPYbSMMgjsuqG6SDFUQHkkJ/GBKlkN/ADDoMghOB+xt4uJXX+wh5GQckFdX/CFtwwRHQB9
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=_yzArvceousA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=JfrnYn6hAAAA:8
    a=20KFwNOVAAAA:8 a=_Wotqz80AAAA:8 a=t0M9nft4AAAA:8 a=meVymXHHAAAA:8
    a=t7CeM3EgAAAA:8 a=i0EeH86SAAAA:8 a=1XWaLZrsAAAA:8 a=sozttTNsAAAA:8
    a=dZ7Af3Q_AAAA:8 a=1EsaE_6oAAAA:8 a=eh1Yez-EAAAA:8 a=CbDCq_QkAAAA:8
    a=WTJdmG3rAAAA:8 a=yPCof4ZbAAAA:8 a=rEqvwrX8AAAA:8 a=pGLkceISAAAA:8
    a=7d_E57ReAAAA:8 a=3-RhneuVAAAA:8 a=EUspDBNiAAAA:8 a=QyXUC8HyAAAA:8
    a=VnNF1IyMAAAA:8 a=FOH2dFAWAAAA:8 a=6HqC31iMbdQxTYMCFBMA:9
    a=eQJVtvdJB1Pdw7NO:21 a=8L8TqKtc0mv_kM05:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=buJP51TR1BpY-zbLSsyS:22 a=9blVyPJtsqGH_lG0htnH:22 a=2JgSa4NbpEOStq-L5dxp:22
    a=FdTzh2GWekK77mhwV6Dw:22 a=aeg5Gbbo78KNqacMgKqU:22 a=xnyMoErWsJe9py2mg6Iw:22
    a=3ZumFrijQQ-2J9H5h8ct:22 a=1qrBK16LubpBFNPVNq2M:22 a=q3NGepEMMmKWaCv8Sx90:22
    a=2B8fXRCmRxTqFPaLtVU6:22 a=jhqOcbufqs7Y1TYCrUUU:22 a=VLVLkjT_5ZicWzSuYqSo:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752535AbeENHl2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 03:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752623AbeENGwL (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:52:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/56] 4.4.132-stable review
Date: Mon, 14 May 2018 08:48:05 +0200
Message-Id: <20180514064754.853201981@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.132-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.132-rc1
X-KernelTest-Deadline: 2018-05-16T06:48+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.132 release.
There are 56 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May 16 06:47:39 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.132-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.132-rc1

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

Hans de Goede <hdegoede@redhat.com>
    Revert "Bluetooth: btusb: Fix quirk for Atheros 1525/QCA6174"

Gustavo A. R. Silva <gustavo@embeddedor.com>
    atm: zatm: Fix potential Spectre v1

Gustavo A. R. Silva <gustavo@embeddedor.com>
    net: atm: Fix potential Spectre v1

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix regex_match_front() to not over compare the test string

Hans de Goede <hdegoede@redhat.com>
    libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs

Johan Hovold <johan@kernel.org>
    rfkill: gpio: fix memory leak in probe error path

Yi Zhao <yi.zhao@windriver.com>
    xfrm_user: fix return value from xfrm_user_rcv_msg

Wei Fang <fangwei1@huawei.com>
    f2fs: fix a dead loop in f2fs_fiemap()

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

Julian Anastasov <ja@ssi.bg>
    ipvs: fix rtnl_lock lockups caused by start_sync_thread

Bin Liu <b-liu@ti.com>
    usb: musb: host: fix potential NULL pointer dereference

SZ Lin (林上智) <sz.lin@moxa.com>
    USB: serial: option: adding support for ublox R410M

Johan Hovold <johan@kernel.org>
    USB: serial: option: reimplement interface masking

Alan Stern <stern@rowland.harvard.edu>
    USB: Accept bulk endpoints with 1024-byte maxpacket

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: visor: handle potential invalid device configuration

Ben Hutchings <ben.hutchings@codethink.co.uk>
    test_firmware: fix setting old custom fw path back on exit, second try

Thomas Hellstrom <thellstrom@vmware.com>
    drm/vmwgfx: Fix a buffer object leak

Danit Goldberg <danitg@mellanox.com>
    IB/mlx5: Use unlimited rate when static rate is not supported

SZ Lin (林上智) <sz.lin@moxa.com>
    NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Protect from shift operand overflow

Roland Dreier <roland@purestorage.com>
    RDMA/ucma: Allow resolving address w/o specifying source address

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: prevent creating negative-sized file via INSERT_RANGE

Vittorio Gambaletta (VittGam) <linuxbugs@vittgam.net>
    Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: leds - fix out of bound access

Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    tracepoint: Do not warn on ENOMEM

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Add missing cable lock to ctl API callbacks

Robert Rosengren <robert.rosengren@axis.com>
    ALSA: aloop: Mark paused device as inactive

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Check PCM state at xfern compat ioctl

Kristian Evensen <kristian.evensen@gmail.com>
    USB: serial: option: Add support for Quectel EP06

Markus Pargmann <mpa@pengutronix.de>
    gpmi-nand: Handle ECC Errors in erased pages

Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
    ath10k: rebuild crypto header in rx data frames

Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
    ath10k: fix rfc1042 header retrieval in QCA4019 with eth decap mode

David Spinadel <david.spinadel@intel.com>
    mac80211: Add RX flag to indicate ICV stripped

Sara Sharon <sara.sharon@intel.com>
    mac80211: allow same PN for AMSDU sub-frames

Sara Sharon <sara.sharon@intel.com>
    mac80211: allow not sending MIC up from driver for HW crypto

Tejun Heo <tj@kernel.org>
    percpu: include linux/sched.h for cond_resched()

Alexander Yarygin <yarygin@linux.vnet.ibm.com>
    KVM: s390: Enable all facility bits that are known good for passthrough

Teng Qin <qinteng@fb.com>
    bpf: map_get_next_key to return first key on NULL

Tan Xiaojun <tanxiaojun@huawei.com>
    perf/core: Fix the perf_cpu_time_max_percent check


-------------

Diffstat:

 Makefile                                          |   4 +-
 arch/s390/kvm/kvm-s390.c                          |   4 +-
 arch/x86/kernel/cpu/perf_event.c                  |   8 +-
 arch/x86/kernel/cpu/perf_event_intel_cstate.c     |   2 +
 arch/x86/kernel/cpu/perf_event_msr.c              |   9 +-
 crypto/af_alg.c                                   |   8 +-
 drivers/ata/libata-core.c                         |   3 +
 drivers/atm/zatm.c                                |   3 +
 drivers/bluetooth/btusb.c                         |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c               |   1 +
 drivers/infiniband/core/ucma.c                    |   2 +-
 drivers/infiniband/hw/mlx5/qp.c                   |  22 +-
 drivers/input/input-leds.c                        |   8 +-
 drivers/input/touchscreen/atmel_mxt_ts.c          |   9 +
 drivers/mtd/nand/gpmi-nand/gpmi-nand.c            |  78 +++-
 drivers/net/can/usb/kvaser_usb.c                  |   2 +-
 drivers/net/usb/qmi_wwan.c                        |   1 +
 drivers/net/wireless/ath/ath10k/core.c            |   8 +
 drivers/net/wireless/ath/ath10k/core.h            |   4 +
 drivers/net/wireless/ath/ath10k/htt_rx.c          | 100 ++++-
 drivers/net/wireless/ath/wcn36xx/txrx.c           |   2 +-
 drivers/usb/core/config.c                         |   4 +-
 drivers/usb/musb/musb_host.c                      |   4 +-
 drivers/usb/serial/option.c                       | 448 ++++++++--------------
 drivers/usb/serial/visor.c                        |  69 ++--
 fs/f2fs/data.c                                    |   2 +-
 fs/fs-writeback.c                                 |   2 +-
 fs/xfs/xfs_file.c                                 |  14 +-
 include/net/inet_timewait_sock.h                  |   1 +
 include/net/mac80211.h                            |  14 +-
 include/net/nexthop.h                             |   2 +-
 kernel/bpf/arraymap.c                             |   2 +-
 kernel/bpf/hashtab.c                              |   9 +-
 kernel/bpf/syscall.c                              |  20 +-
 kernel/events/callchain.c                         |  10 +-
 kernel/events/core.c                              |   2 +-
 kernel/events/ring_buffer.c                       |   7 +-
 kernel/trace/trace_events_filter.c                |   3 +
 kernel/trace/trace_uprobe.c                       |   2 +
 kernel/tracepoint.c                               |   4 +-
 mm/percpu.c                                       |   1 +
 net/atm/lec.c                                     |   9 +-
 net/core/dev_addr_lists.c                         |   4 +-
 net/core/skbuff.c                                 |   1 +
 net/dccp/ipv4.c                                   |   1 +
 net/dccp/ipv6.c                                   |   1 +
 net/ipv4/inet_timewait_sock.c                     |   1 +
 net/ipv4/tcp.c                                    |   2 +-
 net/mac80211/util.c                               |   5 +-
 net/mac80211/wep.c                                |   3 +-
 net/mac80211/wpa.c                                |  45 ++-
 net/netfilter/ipvs/ip_vs_ctl.c                    |   8 -
 net/netfilter/ipvs/ip_vs_sync.c                   | 155 ++++----
 net/netlink/af_netlink.c                          |   2 +
 net/rfkill/rfkill-gpio.c                          |   7 +-
 net/xfrm/xfrm_user.c                              |   2 +-
 sound/core/pcm_compat.c                           |   2 +
 sound/core/seq/seq_virmidi.c                      |   4 +-
 sound/drivers/aloop.c                             |  29 +-
 tools/testing/selftests/firmware/fw_filesystem.sh |   6 +-
 60 files changed, 656 insertions(+), 531 deletions(-)
