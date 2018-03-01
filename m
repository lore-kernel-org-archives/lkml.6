Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1794019-1519878050-2-12638775901438599920
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519878049; b=steHA1iBWrRGcBkBBUHeq2rgCRs2lEIKVRkfsdl6bd9gcqx
    v9DRIYovjFuHFpb1NvmWln9UpcXQD1cqrkVQhMguRGjWugEiUa7eXww/TT1O7cIu
    0MWOYnC9r16R2wrO7atATYLQ/xfk4QlKoYCyzAP44PqcBb0wa7qcx/iFV/m1ndlF
    HraPguENqG8giKhDr441JhJieQUX67yRrsrXHit/PfmM+qBqVvD4Y3xQzdR1VX7V
    gwe/KPL9ZuDTqYlfNwlQNPKl57LjwNY9ZPefHDDDT2nfMi0EfbYz/+PVSVFL5YqX
    cDgyivXxSTBrOsTJfOXSYyenk+9i0GZtUTn0ctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519878049; bh=AFu9/DaOUst41p6OIVIpDM2xMrCKkckcvnP9CmwZ2IM=; b=i
    9hSCRchs6UYleBYdXOmfOKpf/0cNU6xMkWdzExIg2uwTTSmxPNa/sqiYyWHUKDB7
    pV0OveWdOzDU2a0KHxr4n93H1jNroFQHklYWVsTb73ItYy6rc/mHhQ4kYxGbZI/0
    CR5+GKTpjDdWyd9p41j5zMxkLQSMYMtGa3Dsg13rfUip95xAu+Lsnzajz7L5XrL+
    jKu+pzvr+ks3EumXEQuA7as+Jx/ZJ5eCm7mqMAzb5zwkv5tTAyyGebE12sFMLO6V
    v1DjTECyb0U9UE4aTZhNKNBbkA8EUyFuVvgc+f+3s4Knah5JS4NUUWww2xY6GP67
    T97Tc+ZkQAdm119AocGog==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965930AbeCAEUg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 23:20:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965827AbeCAET7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Feb 2018 23:19:59 -0500
Smtp-Origin-Hostprefix: devbig
From: Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig500.prn1.facebook.com
To: <davem@davemloft.net>
CC: <daniel@iogearbox.net>, <torvalds@linux-foundation.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <rostedt@goodmis.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-api@vger.kernel.org>
Smtp-Origin-Cluster: prn1c29
Subject: [PATCH bpf-next 0/5] bpf, tracing: introduce bpf raw tracepoints
Date: Wed, 28 Feb 2018 20:19:52 -0800
Message-ID: <20180301041957.399230-1-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch set is a different way to address the pressing need to access
task_struct pointers in sched tracepoints from bpf programs.

The first approach simply added these pointers to sched tracepoints:
https://lkml.org/lkml/2017/12/14/753
which Peter nacked.
Few options were discussed and eventually the discussion converged on
doing bpf specific tracepoint_probe_register() probe functions.
Details here:
https://lkml.org/lkml/2017/12/20/929

Patch 1 is kernel wide cleanup of pass-struct-by-value into
pass-struct-by-reference into tracepoints.

Patch 2 minor prep work to expose number of arguments passed
into tracepoints.

Patch 3 introduces BPF_RAW_TRACEPOINT api.
the auto-cleanup and multiple concurrent users are must have
features of tracing api. For bpf raw tracepoints it looks like:
  // load bpf prog with BPF_PROG_TYPE_RAW_TRACEPOINT type
  prog_fd = bpf_prog_load(...);

  // receive anon_inode fd for given bpf_raw_tracepoint
  raw_tp_fd = bpf_raw_tracepoint_open("xdp_exception");

  // attach bpf program to given tracepoint
  bpf_prog_attach(prog_fd, raw_tp_fd, BPF_RAW_TRACEPOINT);

Ctrl-C of tracing daemon or cmdline tool will automatically
detach bpf program, unload it and unregister tracepoint probe.
More details in patch 3.

Patch 4, 5 - user space lib and tests

samples/bpf/test_overhead performance on 1 cpu:

tracepoint    base  kprobe+bpf tracepoint+bpf raw_tracepoint+bpf
task_rename   1.1M   769K        947K            1.0M
urandom_read  789K   697K        750K            755K

Alexei Starovoitov (5):
  treewide: remove struct-pass-by-value from tracepoints arguments
  tracepoint: compute num_args at build time
  bpf: introduce BPF_RAW_TRACEPOINT
  libbpf: add bpf_raw_tracepoint_open helper
  samples/bpf: raw tracepoint test

 arch/x86/xen/mmu_pv.c                    |  16 +--
 drivers/gpu/drm/i915/i915_trace.h        |  13 +-
 drivers/infiniband/hw/hfi1/file_ops.c    |   2 +-
 drivers/infiniband/hw/hfi1/trace_ctxts.h |  12 +-
 drivers/s390/cio/ioasm.c                 |  18 +--
 drivers/s390/cio/trace.h                 |  50 ++++----
 fs/dax.c                                 |   2 +-
 include/linux/bpf_types.h                |   1 +
 include/linux/trace_events.h             |  57 +++++++++
 include/linux/tracepoint-defs.h          |   1 +
 include/linux/tracepoint.h               |  32 +++--
 include/trace/bpf_probe.h                |  87 +++++++++++++
 include/trace/define_trace.h             |  15 ++-
 include/trace/events/f2fs.h              |   2 +-
 include/trace/events/fs_dax.h            |   6 +-
 include/trace/events/rcu.h               |   4 +-
 include/trace/events/xen.h               |  32 ++---
 include/uapi/linux/bpf.h                 |  11 ++
 kernel/bpf/syscall.c                     | 108 ++++++++++++++++
 kernel/rcu/tree.c                        |  10 +-
 kernel/trace/bpf_trace.c                 | 211 +++++++++++++++++++++++++++++++
 kernel/tracepoint.c                      |  27 ++--
 net/wireless/trace.h                     |   2 +-
 samples/bpf/Makefile                     |   1 +
 samples/bpf/bpf_load.c                   |  13 ++
 samples/bpf/test_overhead_raw_tp_kern.c  |  17 +++
 samples/bpf/test_overhead_user.c         |  12 ++
 sound/firewire/amdtp-stream-trace.h      |   2 +-
 tools/include/uapi/linux/bpf.h           |  11 ++
 tools/lib/bpf/bpf.c                      |  10 ++
 tools/lib/bpf/bpf.h                      |   1 +
 31 files changed, 677 insertions(+), 109 deletions(-)
 create mode 100644 include/trace/bpf_probe.h
 create mode 100644 samples/bpf/test_overhead_raw_tp_kern.c

-- 
2.9.5

