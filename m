Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524837492-2-16644514216760917985
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
    1524837491; b=Bm8pX8gPLCJZUk5ZiK99dolS6GZAvuz8ggvwKnJGQz5StWjQx8
    38cBsDVoOksM2Tpe8v5SjCEAEVmNmNrMl+3vtsbwnx5Fhfv8IJSqcJ0hfw652ZKF
    ZvggKBNZEQP+e+4KSbfyR/iodvsUjRjGrPiJEJCAontjTY3A+qs89MFwgCxtak0U
    uUUuZTenzT6Sz/Epn3Sf/n/JOotXLU7iS/VCWVL7+J7JaOu3ow0OPwjDu8KcdI/2
    qkJnkOH/eFfpcZENlRxQNVpD+GFlKsCa5qfP6zlfh5UT4uD0X18hR0vTg3lNSFFT
    XXc/8b1IvIokromHs64RL+jXbLfOBByMh9Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524837491; bh=Uf5YoyTPpqZacuQtrKTGMyEHPV1pE7
    ekpzHqRROgz5I=; b=MeFoxsZBUehBLggXAtvSbEaKnM4JCFjn/5cy8WTGOWAJWL
    cbqcnxGs1LfC+rDNAlG2gpIUEMiXu4E0kUnjhjN4MBeqdotJJVZcbw9ae/ZmK4gs
    QFwGRKMQvB3zWMDRE07+h3FD/WZNfZveIwfS66hJRdzUGrqxmNfa2j3EFvTKUtcW
    1jlNvko2NGtM7q0Ixo7lD7eKGSPUGKxryUzWlPMGyZ0HTxGE/J7rskikRVhCrakB
    Q8eE7OGCJb+R6i8paIJKTGs3VuOW8sb1MJv/l8qpTlIk9nU+jdQWYGp2CYwWFF3q
    cbjmBiA5S8ELj671WLV4zFA0nLJF0GstMH6r/PuQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfP2aB+szzkTjQlmCZ6JOU8WszR34f2L48kbqcIB6Je9/qtGfE1vcZL72eEmAsWREUSvvak937P6CVaTRiuJ6SYfXVEvA7VD/68sETpbI/WwrFzw5Ldec
    TsRH/lTXjMJ1QpDSvsABpPSVZ4kwn2LrLv3USRS+i2eX10gRDkhCHyFR9GC/neJ2dhmHhXz4BNngxVyxvrRyHBeBj2ifd8aEWML45HxcRq4baCz8TPT5g/qU
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=28HZq395EAYA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8
    a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=LpQP-O61AAAA:8 a=yMhMjlubAAAA:8
    a=1RTuLK3dAAAA:8 a=aXbLEC-0wkSVMBbg0BQA:9 a=Y0oAFDQ7iyaFm1OS:21
    a=H2sdvtVfxehaFZFq:21 a=E2q1x9kB5HEA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=pioyyrs4ZptJ924tMmac:22 a=kRpfLKi8w9umh8uBmg1i:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeD0N6K (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 09:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932666AbeD0N6J (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 09:58:09 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3AE21890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/24] 3.18.107-stable review
Date: Fri, 27 Apr 2018 15:57:35 +0200
Message-Id: <20180427135631.584839868@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.107-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.107-rc1
X-KernelTest-Deadline: 2018-04-29T13:56+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.107 release.
There are 24 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Apr 29 13:56:20 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.107-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.107-rc1

Dan Carpenter <dan.carpenter@oracle.com>
    cdrom: information leak in cdrom_ioctl_media_changed()

Martin K. Petersen <martin.petersen@oracle.com>
    scsi: mptsas: Disable WRITE SAME

Eric Dumazet <edumazet@google.com>
    ipv6: add RTA_TABLE and RTA_PREFSRC to rtm_ipv6_policy

Cong Wang <xiyou.wangcong@gmail.com>
    llc: delete timers synchronously in llc_sk_free()

Eric Dumazet <edumazet@google.com>
    net: af_packet: fix race in PACKET_{R|T}X_RING

Eric Dumazet <edumazet@google.com>
    tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets

Willem de Bruijn <willemb@google.com>
    packet: fix bitfield update race

Cong Wang <xiyou.wangcong@gmail.com>
    llc: fix NULL pointer deref for SOCK_ZAPPED

Cong Wang <xiyou.wangcong@gmail.com>
    llc: hold llc_sap before release_sock()

Guillaume Nault <g.nault@alphalink.fr>
    pppoe: check sockaddr length in pppoe_connect()

Xin Long <lucien.xin@gmail.com>
    team: fix netconsole setup over team

Paolo Abeni <pabeni@redhat.com>
    team: avoid adding twice the same option to the event list

Jann Horn <jannh@google.com>
    tcp: don't read out-of-bounds opsize

Guillaume Nault <g.nault@alphalink.fr>
    l2tp: check sockaddr length in pppol2tp_connect()

Eric Biggers <ebiggers@google.com>
    KEYS: DNS: limit the length of option strings

Xin Long <lucien.xin@gmail.com>
    bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave

Sahitya Tummala <stummala@codeaurora.org>
    jbd2: fix use after free in kjournald2()

Matthew Wilcox <mawilcox@microsoft.com>
    mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Jiri Olsa <jolsa@kernel.org>
    perf: Return proper values for user stack errors

Theodore Ts'o <tytso@mit.edu>
    ext4: don't update checksum of new initialized bitmaps

wangguang <wang.guang55@zte.com.cn>
    ext4: bugfix for mmaped pages in mpage_release_unused_pages()

Theodore Ts'o <tytso@mit.edu>
    ext4: fix deadlock between inline_data and ext4_expand_extra_isize_ea()

Xiaoming Gao <gxm.linux.kernel@gmail.com>
    x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Steve French <smfrench@gmail.com>
    cifs: do not allow creating sockets except with SMB1 posix exensions


-------------

Diffstat:

 Makefile                        |  4 +-
 arch/x86/kernel/tsc.c           |  2 +-
 drivers/cdrom/cdrom.c           |  2 +-
 drivers/message/fusion/mptsas.c |  1 +
 drivers/net/bonding/bond_main.c |  3 +-
 drivers/net/ppp/pppoe.c         |  4 ++
 drivers/net/team/team.c         | 38 ++++++++++++++----
 fs/cifs/dir.c                   |  9 +++--
 fs/ext4/balloc.c                |  3 +-
 fs/ext4/ialloc.c                | 43 ++------------------
 fs/ext4/inline.c                | 66 ++++++++++++++-----------------
 fs/ext4/inode.c                 |  2 +
 fs/ext4/xattr.c                 | 30 ++++++--------
 fs/ext4/xattr.h                 | 32 +++++++++++++++
 fs/jbd2/journal.c               |  2 +-
 include/net/llc_conn.h          |  1 +
 kernel/events/core.c            |  4 +-
 mm/filemap.c                    |  4 +-
 net/dns_resolver/dns_key.c      | 13 +++---
 net/ipv4/tcp.c                  |  6 ++-
 net/ipv4/tcp_input.c            |  7 +---
 net/ipv6/route.c                |  2 +
 net/l2tp/l2tp_ppp.c             |  7 ++++
 net/llc/af_llc.c                | 14 ++++++-
 net/llc/llc_c_ac.c              |  9 +----
 net/llc/llc_conn.c              | 22 ++++++++++-
 net/packet/af_packet.c          | 88 +++++++++++++++++++++++++++++------------
 net/packet/internal.h           | 10 ++---
 28 files changed, 254 insertions(+), 174 deletions(-)
