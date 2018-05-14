Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-436143-1526284584-2-16560224109882798924
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
    1526284583; b=JhG3kzzWu2kkO2FjHfiL1lobAVvRpfSsecs37jZLbzWzzQ2nI+
    gI6VfXHEljxxrGxsdYWuvj6vRZ9h63v7ChgcA6Aa4JOzpGl7igZAJbjBCHZFeN4e
    8VAU7PMJSYSfxqQc4j6vzTSYGxLtwZFzKbtC8fGB9LsH3p7r62Tg8iseA2UVcfTG
    ep4I/rF5GmGDPsAUOwX24Qwf/HcLcdUq55jEYxBekKuAmIlBZj7HPtah18ISNR8C
    y4nUyatz9gL0RdSK7ZlqKbY5ZLsZi+3zJcNfjZ7zutJTMfsS3SnFmmyJkIZPqUee
    +G23BXxdY1KJ5TKjRwa2fNV32zqaaShRIvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1526284583; bh=J2N8kCTiF5lYmqRasNfXxKKLtCAaEw
    wH2Q6/WjQ3k3I=; b=JrRMqK2IS1R1ZYCQpPwYRcZNhBEQ/iRAYCZxBZNya4epyV
    xh0BOfUePq2FqyiD2yuT2uCKTUyechnqpuOG8T2zlo5jjNQjlyGN6AveiZMcnzar
    brtceG9xjI6eQAU7p8r6RMkLUBbp34l5nRzn6fZ51GN15TcswGyVinn5W8zBHzkR
    SWpr54bMGnlYHOQf5WadHsrMvu6jgxJ16Nn/KKcvHKHyO24OxDP7WwK5RwqdEWpB
    cDxT7/zXCF7kmtfUMGcKwJsV6wUBMb1jBRq/TrmM97w1V2xpqW5Ns1JrU0nmc/fR
    VMnE8acSnQcdUn0EKoE5QC2Yxhk5fCZw3msDje1w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=VllDBiRp x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=VllDBiRp x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOYIyGGqKdqUgxbQPkSTOU17jDo2+BFhe+sH++kxYovi1F7iqmxlU7BY6u75VMXor47kxRySEtd5oQ2U0xGOwHpdgDDRsZrvin+5z1WzF7Kip7gizqZf
    wQo8ADDUwOoWzPF1EhuT8k2/zUEqqXCdVd6hOsJ7ybom+u4Td2P5C6xv5+tRXDsN3GGk8jHM3D/9JDfDcdTOqQGQ4s5/K5GqCxQXZDsI6DmB9MCIUdzF2i+F
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=0U73VwB4dlIA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=t0M9nft4AAAA:8
    a=meVymXHHAAAA:8 a=20KFwNOVAAAA:8 a=1XWaLZrsAAAA:8 a=sozttTNsAAAA:8
    a=dZ7Af3Q_AAAA:8 a=CbDCq_QkAAAA:8 a=3-RhneuVAAAA:8 a=VnNF1IyMAAAA:8
    a=i0EeH86SAAAA:8 a=NU4e1nKjIWvzMqsnEs8A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=9blVyPJtsqGH_lG0htnH:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=aeg5Gbbo78KNqacMgKqU:22 a=xnyMoErWsJe9py2mg6Iw:22
    a=1qrBK16LubpBFNPVNq2M:22 a=VLVLkjT_5ZicWzSuYqSo:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752211AbeENGuY (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752169AbeENGuV (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:50:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/23] 3.18.109-stable review
Date: Mon, 14 May 2018 08:48:29 +0200
Message-Id: <20180514064704.046463679@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.109-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.109-rc1
X-KernelTest-Deadline: 2018-05-16T06:47+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.109 release.
There are 23 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed May 16 06:46:49 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.109-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.109-rc1

Masami Hiramatsu <mhiramat@kernel.org>
    tracing/uprobe_event: Fix strncpy corner case

Jimmy Assarsson <extja@kvaser.com>
    can: kvaser_usb: Increase correct stats counter in kvaser_usb_rx_can_msg()

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing: Fix regex_match_front() to not over compare the test string

Hans de Goede <hdegoede@redhat.com>
    libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs

Johan Hovold <johan@kernel.org>
    rfkill: gpio: fix memory leak in probe error path

Eric Dumazet <edumazet@google.com>
    tcp: fix TCP_REPAIR_QUEUE bound checking

Jiri Olsa <jolsa@kernel.org>
    perf: Remove superfluous allocation error check

Eric Dumazet <edumazet@google.com>
    soreuseport: initialise timewait reuseport field

Eric Dumazet <edumazet@google.com>
    net: fix uninit-value in __hw_addr_add_ex()

Eric Dumazet <edumazet@google.com>
    net: initialize skb->peeked when cloning

Eric Dumazet <edumazet@google.com>
    net: fix rtnh_ok()

Eric Dumazet <edumazet@google.com>
    netlink: fix uninit-value in netlink_sendmsg

Bin Liu <b-liu@ti.com>
    usb: musb: host: fix potential NULL pointer dereference

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: visor: handle potential invalid device configuration

SZ Lin (林上智) <sz.lin@moxa.com>
    NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Protect from shift operand overflow

Takashi Iwai <tiwai@suse.de>
    ALSA: aloop: Add missing cable lock to ctl API callbacks

Robert Rosengren <robert.rosengren@axis.com>
    ALSA: aloop: Mark paused device as inactive

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()

Takashi Iwai <tiwai@suse.de>
    ALSA: pcm: Check PCM state at xfern compat ioctl

Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
    perf session: Fix undeclared 'oe'

Tan Xiaojun <tanxiaojun@huawei.com>
    perf/core: Fix the perf_cpu_time_max_percent check

Tejun Heo <tj@kernel.org>
    percpu: include linux/sched.h for cond_resched()


-------------

Diffstat:

 Makefile                           |  4 +--
 drivers/ata/libata-core.c          |  3 ++
 drivers/infiniband/hw/mlx5/qp.c    |  4 +++
 drivers/net/can/usb/kvaser_usb.c   |  2 +-
 drivers/net/usb/qmi_wwan.c         |  1 +
 drivers/usb/musb/musb_host.c       |  4 ++-
 drivers/usb/serial/visor.c         | 69 +++++++++++++++++++-------------------
 include/net/inet_timewait_sock.h   |  1 +
 include/net/nexthop.h              |  2 +-
 kernel/events/callchain.c          | 10 ++----
 kernel/events/core.c               |  2 +-
 kernel/trace/trace_events_filter.c |  3 ++
 kernel/trace/trace_uprobe.c        |  2 ++
 mm/percpu.c                        |  1 +
 net/core/dev_addr_lists.c          |  4 +--
 net/core/skbuff.c                  |  1 +
 net/ipv4/inet_timewait_sock.c      |  1 +
 net/ipv4/tcp.c                     |  2 +-
 net/netlink/af_netlink.c           |  2 ++
 net/rfkill/rfkill-gpio.c           |  7 +++-
 sound/core/pcm_compat.c            |  2 ++
 sound/core/seq/seq_virmidi.c       |  4 +--
 sound/drivers/aloop.c              | 29 +++++++++++++---
 tools/perf/util/session.c          |  1 +
 24 files changed, 102 insertions(+), 59 deletions(-)
