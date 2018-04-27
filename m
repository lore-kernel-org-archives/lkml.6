Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-380590-1524843166-2-8481181428014051731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524843165; b=k/NTN0/7y8eTYJgLlWz5BqX4HX8/ILT35cdvsZ+Ou4Kzo+Rqbr
    oi0K27ac+Us5G3LXaBu6sVFTvzycdg3IvFpj/FHr6fDqTo+6vDmpoPIHnrn1zDNt
    w1yh0wxPnD4Cg6uTPZc/DAIM+cmZ+Fj9Cj7RQmNP1zGdUWcwrYAM//X3gayGgysg
    SZ0II+8kNrNE/6qTzX+goPoX0AcRAXrB7T/BHCguLhM/5hDqgckyo88EfZUH5yqV
    2HDoIOGvu/qjHdn5i8MVKlh0uwyfxv+EmFOgeiXVu/+aGNwbAtqnCzgbsaptcZ0H
    j/RMb5/bpO4JIZ9JY9FTdkaLpVg+G766W66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524843165; bh=SQ4OBW6bcR3kuoQkHnSaRqUuMzD6r1
    n1n5093KcMcmE=; b=LL664+A7FkQMcRk27c2tEEzBcUFFSWZid8CWcoPvPnVZKJ
    76fnzoDSxdfmCO1RKkKspGIJ1B4H7SFozN8g3eK9mcWXytnKXHf4ctb2f/btfjkr
    Ccm4yJ7VJXN0vchneZgjePeJLrxWTpLyqiP36UEJGN0lACPS+4eyDmGFICBYifbP
    KnJHUpin3cirYOvSbAKraslzF8fr+txJoS1KgbHey4A4jHCAfi/QhP0X37A/++vc
    WjZHUg3h6gvoN7EzzaZqZnY500lHDDvXwHufK4tqWlTGcXxCI4DAdbDyG/qXMJyJ
    DJpnKCC7UUetNJmohfyDskFc+OCziRG6V7PTvFEQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHIrPXzVLC+k3jSSxlBukL1Gm9OxcPkeA+YFaIioWa1RK2nkPjzaDyYT/KBNviprU0K5H71WSlex54cYYfI5uZ3eyLHTuxwyWYHc7dH8PYc8Z3v5F+uF
    qe9PdJ9QznDMB8kfK4gQwUo/1mlXIkFqI53BTVcgWcgpOu0eVBlhpuXv/MuapxDnylMjsXoqvXbbH5We1QJij4k59261Y0mZNm0GPQVFQDxfqzKpmZ0e7IS2
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=oZq4rTz8mb0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8
    a=1XWaLZrsAAAA:8 a=Qm8iP6mkAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
    a=LpQP-O61AAAA:8 a=cm27Pg_UAAAA:8 a=BTeA3XvPAAAA:8 a=khqpX0FKZ4hUKErDn4MA:9
    a=pZOnptWE6EXd7igr:21 a=RgH05FzTk1lIHaeK:21 a=E2q1x9kB5HEA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=kDhhxE42lZnxL3pOKqYK:22
    a=pioyyrs4ZptJ924tMmac:22 a=xmb-EsYY8bH0VWELuYED:22 a=tafbbOV3vt1XuEhzTjGK:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933041AbeD0Pc2 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 11:32:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932888AbeD0OAt (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:00:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25AA2185A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/50] 4.4.130-stable review
Date: Fri, 27 Apr 2018 15:58:02 +0200
Message-Id: <20180427135655.623669681@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.130-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.130-rc1
X-KernelTest-Deadline: 2018-04-29T13:56+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.4.130 release.
There are 50 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr 29 13:56:42 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.130-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.130-rc1

Heiko Carstens <heiko.carstens@de.ibm.com>
    s390/uprobes: implement arch_uretprobe_is_alive()

Sebastian Ott <sebott@linux.ibm.com>
    s390/cio: update chpid descriptor after resource accessibility event

Dan Carpenter <dan.carpenter@oracle.com>
    cdrom: information leak in cdrom_ioctl_media_changed()

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: mptsas: Disable WRITE SAME

Eric Dumazet <edumazet@google.com>
    ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy

Eric Dumazet <edumazet@google.com>
    net: af_packet: fix race in PACKET_{R|T}X_RING

Eric Dumazet <edumazet@google.com>
    tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets

Wolfgang Bumiller <w.bumiller@proxmox.com>
    net: fix deadlock while clearing neighbor proxy table

Eric Dumazet <edumazet@google.com>
    tipc: add policy for TIPC_NLA_NET_ADDR

Cong Wang <xiyou.wangcong@gmail.com>
    llc: fix NULL pointer deref for SOCK_ZAPPED

Cong Wang <xiyou.wangcong@gmail.com>
    llc: hold llc_sap before release_sock()

Xin Long <lucien.xin@gmail.com>
    sctp: do not check port in sctp_inet6_cmp_addr

Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
    vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Guillaume Nault <g.nault@alphalink.fr>
    pppoe: check sockaddr length in pppoe_connect()

Willem de Bruijn <willemb@google.com>
    packet: fix bitfield update race

Xin Long <lucien.xin@gmail.com>
    team: fix netconsole setup over team

Paolo Abeni <pabeni@redhat.com>
    team: avoid adding twice the same option to the event list

Jann Horn <jannh@google.com>
    tcp: don't read out-of-bounds opsize

Cong Wang <xiyou.wangcong@gmail.com>
    llc: delete timers synchronously in llc_sk_free()

Eric Dumazet <edumazet@google.com>
    net: validate attribute sizes in neigh_dump_table()

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: check sockaddr length in pppol2tp_connect()

Eric Biggers <ebiggers@google.com>
    KEYS: DNS: limit the length of option strings

Xin Long <lucien.xin@gmail.com>
    bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: correct module section names for expoline code revert

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: correct nospec auto detection init order

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add sysfs attributes for spectre

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: report spectre mitigation via syslog

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add automatic detection of the spectre defense

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: move nobp parameter functions to nospec-branch.c

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/entry.S: fix spurious zeroing of r0

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: do not bypass BPENTER for interrupt system calls

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: Replace IS_ENABLED(EXPOLINE_*) with IS_ENABLED(CONFIG_EXPOLINE_*)

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: introduce execute-trampolines for branches

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: run user space and KVM guests with modified branch prediction

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add options to change branch prediction behaviour for the kernel

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390/alternative: use a copy of the facility bit mask

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: add optimized array_index_mask_nospec

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: scrub registers on kernel entry and KVM exit

Martin Schwidefsky <schwidefsky@de.ibm.com>
    KVM: s390: wire up bpb feature

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: enable CPU alternatives unconditionally

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: introduce CPU alternatives

Karthikeyan Periyasamy <periyasa@codeaurora.org>
    Revert "ath10k: send (re)assoc peer command when NSS changed"

Sahitya Tummala <stummala@codeaurora.org>
    jbd2: fix use after free in kjournald2()

Felix Fietkau <nbd@nbd.name>
    ath9k_hw: check if the chip failed to wake up

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: drv260x - fix initializing overdrive voltage

Grant Grundler <grundler@chromium.org>
    r8152: add Linksys USB3GIGV1 id

Chen Feng <puck.chen@hisilicon.com>
    staging: ion : Donnot wakeup kswapd in ion system alloc

Jiri Olsa <jolsa@kernel.org>
    perf: Return proper values for user stack errors

Xiaoming Gao <gxm.linux.kernel@gmail.com>
    x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Steve French <smfrench@gmail.com>
    cifs: do not allow creating sockets except with SMB1 posix exensions


-------------

Diffstat:

 Documentation/kernel-parameters.txt           |   3 +
 Makefile                                      |   4 +-
 arch/s390/Kconfig                             |  47 +++++
 arch/s390/Makefile                            |  10 ++
 arch/s390/include/asm/alternative.h           | 149 +++++++++++++++
 arch/s390/include/asm/barrier.h               |  24 +++
 arch/s390/include/asm/facility.h              |  18 ++
 arch/s390/include/asm/kvm_host.h              |   3 +-
 arch/s390/include/asm/lowcore.h               |   7 +-
 arch/s390/include/asm/nospec-branch.h         |  17 ++
 arch/s390/include/asm/processor.h             |   4 +
 arch/s390/include/asm/thread_info.h           |   4 +
 arch/s390/include/uapi/asm/kvm.h              |   3 +
 arch/s390/kernel/Makefile                     |   5 +-
 arch/s390/kernel/alternative.c                | 112 ++++++++++++
 arch/s390/kernel/early.c                      |   5 +
 arch/s390/kernel/entry.S                      | 250 +++++++++++++++++++++++---
 arch/s390/kernel/ipl.c                        |   1 +
 arch/s390/kernel/module.c                     |  65 ++++++-
 arch/s390/kernel/nospec-branch.c              | 169 +++++++++++++++++
 arch/s390/kernel/processor.c                  |  18 ++
 arch/s390/kernel/setup.c                      |  14 +-
 arch/s390/kernel/smp.c                        |   7 +-
 arch/s390/kernel/uprobes.c                    |   9 +
 arch/s390/kernel/vmlinux.lds.S                |  37 ++++
 arch/s390/kvm/kvm-s390.c                      |  13 +-
 arch/x86/kernel/tsc.c                         |   2 +-
 drivers/cdrom/cdrom.c                         |   2 +-
 drivers/input/misc/drv260x.c                  |   2 +-
 drivers/message/fusion/mptsas.c               |   1 +
 drivers/net/bonding/bond_main.c               |   3 +-
 drivers/net/ppp/pppoe.c                       |   4 +
 drivers/net/team/team.c                       |  38 +++-
 drivers/net/usb/cdc_ether.c                   |  10 ++
 drivers/net/usb/r8152.c                       |   2 +
 drivers/net/wireless/ath/ath10k/mac.c         |   5 +-
 drivers/net/wireless/ath/ath9k/hw.c           |   4 +
 drivers/s390/char/Makefile                    |   2 +
 drivers/s390/cio/chsc.c                       |  14 +-
 drivers/staging/android/ion/ion_system_heap.c |   2 +-
 fs/cifs/dir.c                                 |   9 +-
 fs/jbd2/journal.c                             |   2 +-
 include/linux/if_vlan.h                       |   7 +-
 include/net/llc_conn.h                        |   1 +
 include/uapi/linux/kvm.h                      |   1 +
 kernel/events/core.c                          |   4 +-
 net/core/dev.c                                |   2 +-
 net/core/neighbour.c                          |  40 +++--
 net/dns_resolver/dns_key.c                    |  13 +-
 net/ipv4/tcp.c                                |   6 +-
 net/ipv4/tcp_input.c                          |   7 +-
 net/ipv6/route.c                              |   2 +
 net/l2tp/l2tp_ppp.c                           |   7 +
 net/llc/af_llc.c                              |  14 +-
 net/llc/llc_c_ac.c                            |   9 +-
 net/llc/llc_conn.c                            |  22 ++-
 net/packet/af_packet.c                        |  88 ++++++---
 net/packet/internal.h                         |  10 +-
 net/sctp/ipv6.c                               |  60 +++----
 net/tipc/net.c                                |   3 +-
 60 files changed, 1228 insertions(+), 168 deletions(-)
