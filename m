Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163920-2-6248903950211916421
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
    1527163919; b=iWGJfpbpMaJSiUxobuqO0WlAbKbuKTwvRBHxFwok+rCaig3VZL
    ZJeyzrlOfjwiMw01L/IwIFmM9+u4J66Ru4cKwGjGLmeMg/IxofxV49GgB6LcXlib
    VtPaFr9e10hwZNKtT6heFEWYc4SJUz68eLBsWGZw++HVf3GGe7/GNLDEYxMv0hYY
    HSGOpbikh6zj2aGMYtB72/zhUALYOo0D5HiGiirvNgX5Y+wMqftdrBJkZ6nLF4oK
    OZiEiCAej7zRx5FMxPxqJeJlRXkT05Dq39+IILUV6qt/VlnWa/hPjQxW3W1+uv9v
    +COqY9rXwa2YyyRLtX18MUULMAYkX5BjQ3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1527163919; bh=bdDjh4cLGu8GWpH0RgRhh9xoT8wnZf
    oNvzWS/bxKs5w=; b=RH6elVeMHmcFVz5N0sGSdxRx4laFo4Gnsk5MKvRM9TGH7D
    7YGQG4cJc5MsQavVc/6icsFZwropXh0z9XYyTBr3uCbOmqpMh+TpdcreTVXDvc/H
    8GenEWXn33Uvwfq+hswIRx5Mmkxmiuabaz4w7b3NU50fz6obz8yhDQ5Hxtz20YP1
    8G+32SW5QQHR1Kgws82Kvy+mQ2F0nJbwV8NICn9RoFTtxmoudkPaIKC3rYzZWytY
    DZm/rf8Fa91GNQzsq1CzQZZtiPsVF5F+tytG5RYhXI+tNZ18O2p/JMXKpar9eeR+
    TMnnBlP+1F6GuIPilmt8g6KkHbQw8+ZyzsgqrIlw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=asBZ/1L5 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=asBZ/1L5 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBRcpuvhBxpERZ1D4nxY3J+bfz685tOK0wc/NAa05OCTCgW5VN2L9gkg3Fad3GnqZ1Jmwn24zFcdfJ4jwd9NKupzDzJtaykizOEkPj733a+CSn+HZ6dU
    Ind4HvKIHy09DnC+2w9aa7O2fE2Eng3HQrJm7AcSSNTSgYrWmn16ufkBp9YXVb14mcerEr//B6Fqg8k9xWpV+IHp9LvKoiSmRnCcSfVGmiQ3YCW9OqDvGSpV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=zhKW8NK6TxkA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8
    a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8 a=i0EeH86SAAAA:8
    a=drOt6m5kAAAA:8 a=SRrdq9N9AAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8
    a=yMhMjlubAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=meVymXHHAAAA:8
    a=MvuuwTCpAAAA:8 a=R_Myd5XaAAAA:8 a=ufHFDILaAAAA:8 a=TYBLyS7eAAAA:8
    a=wMNdZWldAAAA:8 a=J2zoVyZDAAAA:8 a=hD80L64hAAAA:8 a=9-efGfXaAAAA:8
    a=HSIkpTvyAAAA:8 a=7CQSdrXTAAAA:8 a=X7Ea-ya5AAAA:8 a=Q-fNiiVtAAAA:8
    a=CbDCq_QkAAAA:8 a=FOH2dFAWAAAA:8 a=IEaiMLeMbNVxeFxsisUA:9
    a=P73DzLlpwgI54C2Y:21 a=e0vBh4kLvcJoQNTr:21 a=QEXdDO2ut3YA:10
    a=E2q1x9kB5HEA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=cvBusfyB2V15izCimMoJ:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=dVHiktpip_riXrfdqayU:22 a=L2g4Dz8VuBQ37YGmWQah:22
    a=ZmIg1sZ3JBWsdXgziEIF:22 a=zvYvwCWiE4KgVXXeO06c:22 a=FUarYpL4UH3yWsho8X8J:22
    a=DvW0qZC7_2Hvvf243_-1:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966551AbeEXMLa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965973AbeEXJnF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:43:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/92] 4.4.133-stable review
Date: Thu, 24 May 2018 11:37:37 +0200
Message-Id: <20180524093159.286472249@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.133-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.133-rc1
X-KernelTest-Deadline: 2018-05-26T09:32+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.133 release.
There are 92 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat May 26 09:31:28 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.133-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.133-rc1

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    x86/kexec: Avoid double free_page() upon do_kexec_load() failure

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    hfsplus: stop workqueue when fill_super() failed

Johannes Berg <johannes.berg@intel.com>
    cfg80211: limit wiphy names to 128 bytes

Geert Uytterhoeven <geert+renesas@glider.be>
    gpio: rcar: Add Runtime PM handling for interrupts

John Stultz <john.stultz@linaro.org>
    time: Fix CLOCK_MONOTONIC_RAW sub-nanosecond accounting

Vinod Koul <vinod.koul@intel.com>
    dmaengine: ensure dmaengine helpers check valid callback

Jens Remus <jremus@linux.ibm.com>
    scsi: zfcp: fix infinite iteration on ERP ready list

Alexander Potapenko <glider@google.com>
    scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Jason Yan <yanaijie@huawei.com>
    scsi: libsas: defer ata device eh commands to libata

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: use expoline thunks in the BPF JIT

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: extend expoline to BC instructions

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move spectre sysfs attribute code

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/kernel: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/ftrace: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/lib: use expoline for indirect branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move expoline assembler macros to a header

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add assembler macros for CPU alternatives

Al Viro <viro@zeniv.linux.org.uk>
    ext2: fix a block leak

Eric Dumazet <edumazet@google.com>
    tcp: purge write queue in tcp_connect_init()

Eric Dumazet <edumazet@google.com>
    sock_diag: fix use-after-free read in __sk_free

Willem de Bruijn <willemb@google.com>
    packet: in packet_snd start writing at link layer allocation

Willem de Bruijn <willemb@google.com>
    net: test tailroom before appending to linear skb

Liu Bo <bo.liu@linux.alibaba.com>
    btrfs: fix reading stale metadata blocks after degraded raid1 mounts

Anand Jain <anand.jain@oracle.com>
    btrfs: fix crash when trying to resume balance without the resume flag

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix xattr loss after power failure

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8772/1: kprobes: Prohibit kprobes on get_user functions

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8770/1: kprobes: Prohibit probing on optimized_callback

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8769/1: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed

Dexuan Cui <decui@microsoft.com>
    tick/broadcast: Use for_each_cpu() specially on UP kernels

Masami Hiramatsu <mhiramat@kernel.org>
    ARM: 8771/1: kprobes: Prohibit kprobes on do_undefinstr

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    efi: Avoid potential crashes, fix the 'struct efi_pci_io_protocol_32' definition for mixed mode

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: remove indirect branch from do_softirq_own_stack

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qdio: don't release memory in qdio_setup_irq()

Hendrik Brueckner <brueckner@linux.ibm.com>
    s390/cpum_sf: ensure sample frequency of perf event attributes is non-zero

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qdio: fix access to uninitialized qdio_q fields

Pavel Tatashin <pasha.tatashin@oracle.com>
    mm: don't allow deferred pages with NEED_PER_CPU_KM

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: Fix NVRAM sleep in invalid context when crashing

Janis Danisevskis <jdanis@google.com>
    procfs: fix pthread cross-thread naming if !PR_DUMPABLE

Mateusz Guzik <mguzik@redhat.com>
    proc read mm's {arg,env}_{start,end} with mmap semaphore taken.

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tracing/x86/xen: Remove zero data size trace events trace_xen_mmu_flush_tlb{_all}

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
    cpufreq: intel_pstate: Enable HWP by default

Waiman Long <Waiman.Long@hpe.com>
    signals: avoid unnecessary taking of sighand->siglock

Mel Gorman <mgorman@techsingularity.net>
    mm: filemap: avoid unnecessary calls to lock_page when waiting for IO to complete during a read

Mel Gorman <mgorman@techsingularity.net>
    mm: filemap: remove redundant code in do_read_cache_page

Johannes Weiner <hannes@cmpxchg.org>
    proc: meminfo: estimate available memory more conservatively

Vladimir Davydov <vdavydov@virtuozzo.com>
    vmscan: do not force-scan file lru if its absolute size is small

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    powerpc: Don't preempt_disable() in show_cpuinfo()

Anders Roxell <anders.roxell@linaro.org>
    cpuidle: coupled: remove unused define cpuidle_coupled_lock

Stewart Smith <stewart@linux.vnet.ibm.com>
    powerpc/powernv: remove FW_FEATURE_OPALv3 and just use FW_FEATURE_OPAL

Stewart Smith <stewart@linux.vnet.ibm.com>
    powerpc/powernv: Remove OPALv2 firmware define and references

Stewart Smith <stewart@linux.vnet.ibm.com>
    powerpc/powernv: panic() on OPAL < V3

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    spi: pxa2xx: Allow 64-bit DMA

Wenwen Wang <wang6495@umn.edu>
    ALSA: control: fix a redundant-copy issue

Hans de Goede <hdegoede@redhat.com>
    ALSA: hda: Add Lenovo C50 All in one to the power_save blacklist

Federico Cuello <fedux@fedux.com.ar>
    ALSA: usb: mixer: volume quirk for CM102-A+/102S+

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: fix bad unlock balance during stub_probe()

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: fix NULL-ptr deref and use-after-free errors

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: run rebind from exit when module is removed

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip: usbip_host: delete device from busid_table after rebind

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: usbip_host: refine probe and disconnect debug msgs to be useful

zhongjiang <zhongjiang@huawei.com>
    kernel/exit.c: avoid undefined behaviour when calling wait4()

Jiri Slaby <jslaby@suse.cz>
    futex: futex_wake_op, fix sign_extend32 sign bits

Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
    pipe: cap initial pipe capacity according to pipe-max-size limit

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

Mel Gorman <mgorman@suse.de>
    futex: Remove unnecessary warning from get_futex_key

Suzuki K Poulose <suzuki.poulose@arm.com>
    arm64: Add work around for Arm Cortex-A55 Erratum 1024718

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    arm64: introduce mov_q macro to move a constant into a 64-bit register

Richard Guy Briggs <rgb@redhat.com>
    audit: move calcs after alloc and check when logging set loginuid

Takashi Iwai <tiwai@suse.de>
    ALSA: timer: Call notifier in the same spinlock

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
 arch/alpha/include/asm/futex.h                  |  26 +--
 arch/arc/include/asm/futex.h                    |  40 +----
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi        |   1 -
 arch/arm/include/asm/assembler.h                |  10 ++
 arch/arm/include/asm/futex.h                    |  26 +--
 arch/arm/kernel/traps.c                         |   5 +-
 arch/arm/lib/getuser.S                          |  10 ++
 arch/arm/probes/kprobes/opt-arm.c               |   4 +-
 arch/arm64/Kconfig                              |  14 ++
 arch/arm64/include/asm/assembler.h              |  60 +++++++
 arch/arm64/include/asm/cputype.h                |  11 ++
 arch/arm64/include/asm/futex.h                  |  26 +--
 arch/arm64/mm/proc.S                            |   5 +
 arch/frv/include/asm/futex.h                    |   3 +-
 arch/frv/kernel/futex.c                         |  27 +--
 arch/hexagon/include/asm/futex.h                |  38 +---
 arch/ia64/include/asm/futex.h                   |  25 +--
 arch/microblaze/include/asm/futex.h             |  38 +---
 arch/mips/include/asm/futex.h                   |  25 +--
 arch/parisc/include/asm/futex.h                 |  25 +--
 arch/powerpc/include/asm/firmware.h             |   5 +-
 arch/powerpc/include/asm/futex.h                |  26 +--
 arch/powerpc/kernel/setup-common.c              |  11 --
 arch/powerpc/platforms/powernv/eeh-powernv.c    |   4 +-
 arch/powerpc/platforms/powernv/idle.c           |   2 +-
 arch/powerpc/platforms/powernv/opal-nvram.c     |  14 +-
 arch/powerpc/platforms/powernv/opal-xscom.c     |   2 +-
 arch/powerpc/platforms/powernv/opal.c           |  36 ++--
 arch/powerpc/platforms/powernv/pci-ioda.c       |   2 +-
 arch/powerpc/platforms/powernv/setup.c          |  12 +-
 arch/powerpc/platforms/powernv/smp.c            |  74 ++++----
 arch/s390/include/asm/alternative-asm.h         | 108 ++++++++++++
 arch/s390/include/asm/futex.h                   |  23 +--
 arch/s390/include/asm/nospec-insn.h             | 193 +++++++++++++++++++++
 arch/s390/kernel/Makefile                       |   1 +
 arch/s390/kernel/asm-offsets.c                  |   1 +
 arch/s390/kernel/base.S                         |  24 +--
 arch/s390/kernel/entry.S                        | 105 +++--------
 arch/s390/kernel/irq.c                          |   5 +-
 arch/s390/kernel/mcount.S                       |  14 +-
 arch/s390/kernel/nospec-branch.c                |  43 +++--
 arch/s390/kernel/nospec-sysfs.c                 |  21 +++
 arch/s390/kernel/perf_cpum_sf.c                 |   4 +
 arch/s390/kernel/reipl.S                        |   5 +-
 arch/s390/kernel/swsusp.S                       |  10 +-
 arch/s390/lib/mem.S                             |   9 +-
 arch/s390/net/bpf_jit.S                         |  16 +-
 arch/s390/net/bpf_jit_comp.c                    |  63 ++++++-
 arch/sh/include/asm/futex.h                     |  26 +--
 arch/sparc/include/asm/futex_64.h               |  26 +--
 arch/tile/include/asm/futex.h                   |  40 +----
 arch/x86/boot/compressed/eboot.c                |   6 +-
 arch/x86/include/asm/futex.h                    |  40 +----
 arch/x86/kernel/machine_kexec_32.c              |   6 +-
 arch/x86/kernel/machine_kexec_64.c              |   4 +-
 arch/x86/xen/mmu.c                              |   4 -
 arch/xtensa/include/asm/futex.h                 |  27 +--
 drivers/cpufreq/intel_pstate.c                  |  34 ++--
 drivers/cpufreq/powernv-cpufreq.c               |   2 +-
 drivers/cpuidle/coupled.c                       |   1 -
 drivers/cpuidle/cpuidle-powernv.c               |   2 +-
 drivers/gpio/gpio-rcar.c                        |  46 +++++
 drivers/net/bonding/bond_alb.c                  |   2 +-
 drivers/net/ethernet/broadcom/tg3.c             |   9 +-
 drivers/net/ethernet/mellanox/mlx4/en_ethtool.c |  16 ++
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h    |   7 +-
 drivers/net/ethernet/realtek/8139too.c          |   2 +-
 drivers/net/ethernet/realtek/r8169.c            |   3 +
 drivers/net/ethernet/sun/niu.c                  |   5 +-
 drivers/net/usb/qmi_wwan.c                      |  12 ++
 drivers/s390/cio/qdio_setup.c                   |  12 +-
 drivers/s390/scsi/zfcp_dbf.c                    |  23 ++-
 drivers/s390/scsi/zfcp_ext.h                    |   5 +-
 drivers/s390/scsi/zfcp_scsi.c                   |  14 +-
 drivers/scsi/libsas/sas_scsi_host.c             |  33 ++--
 drivers/scsi/sg.c                               |   2 +-
 drivers/spi/spi-pxa2xx.h                        |   2 +-
 drivers/usb/usbip/stub.h                        |   2 +
 drivers/usb/usbip/stub_dev.c                    |  43 +++--
 drivers/usb/usbip/stub_main.c                   | 105 +++++++++--
 fs/btrfs/ctree.c                                |   6 +-
 fs/btrfs/tree-log.c                             |   7 +
 fs/btrfs/volumes.c                              |   9 +
 fs/ext2/inode.c                                 |  10 --
 fs/hfsplus/super.c                              |   1 +
 fs/lockd/svc.c                                  |   2 +
 fs/pipe.c                                       |   3 +
 fs/proc/base.c                                  |  55 +++++-
 fs/proc/meminfo.c                               |   5 +-
 include/asm-generic/futex.h                     |  50 +-----
 include/linux/dmaengine.h                       |  20 ++-
 include/linux/efi.h                             |   8 +-
 include/linux/signal.h                          |  17 ++
 include/linux/timekeeper_internal.h             |   4 +-
 include/trace/events/xen.h                      |  16 --
 include/uapi/linux/nl80211.h                    |   2 +
 kernel/auditsc.c                                |   7 +-
 kernel/exit.c                                   |   4 +
 kernel/futex.c                                  |  44 ++++-
 kernel/signal.c                                 |   7 +
 kernel/time/tick-broadcast.c                    |   8 +
 kernel/time/timekeeping.c                       |  20 +--
 mm/Kconfig                                      |   1 +
 mm/filemap.c                                    |  90 ++++++----
 mm/util.c                                       |  16 +-
 mm/vmscan.c                                     |  12 +-
 net/bridge/br_if.c                              |   4 +-
 net/compat.c                                    |   6 +-
 net/core/sock.c                                 |   2 +-
 net/dccp/ccids/ccid2.c                          |  14 +-
 net/dccp/timer.c                                |   2 +-
 net/ipv4/ip_output.c                            |   3 +-
 net/ipv4/ping.c                                 |   7 +-
 net/ipv4/tcp.c                                  |   2 +-
 net/ipv4/tcp_output.c                           |   7 +-
 net/ipv4/udp.c                                  |   7 +-
 net/ipv6/ip6_output.c                           |   3 +-
 net/l2tp/l2tp_netlink.c                         |   2 -
 net/llc/af_llc.c                                |   3 +
 net/openvswitch/flow_netlink.c                  |   9 +-
 net/packet/af_packet.c                          |   4 +-
 net/sched/sch_fq.c                              |  37 ++--
 net/sctp/associola.c                            |  30 +++-
 net/sctp/inqueue.c                              |   2 +-
 net/sctp/ipv6.c                                 |   3 +
 net/sctp/sm_statefuns.c                         |  89 +++++-----
 net/wireless/core.c                             |   3 +
 net/xfrm/xfrm_state.c                           |   1 +
 sound/core/control_compat.c                     |   3 +-
 sound/core/timer.c                              | 220 +++++++++++-------------
 sound/pci/hda/hda_intel.c                       |   2 +
 sound/usb/mixer.c                               |   8 +
 133 files changed, 1605 insertions(+), 1109 deletions(-)
