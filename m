Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1855777-1519878067-2-7204480476679752505
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519878066; b=QwU4T1+zMDwQMmfGwWSExGW3KNM0FP6zwYF5jNtCoWFxGJO
    Hrh1YWGXvdG3attwg/e6cj++1QDr9hzEAAIdCrE2RJ2r4CHFLkbdhygcTdoRbv8F
    f3xfGmzgaG9nDHqsHJHAcy39LMu9enM/xsglwvOxr/vzcHh70PEYT7KIUjzNv4GS
    nwpAW5LqrCvTeTB0Q88AnxK89fCW0KmS1+/1r0vsPo81MxxDPRgiITfUPoiVDNjO
    SzTcj6e3WPFuqFbjV0Vd8G1pBb2Dt6GjuPQq5B8FjOhR0HRrCTz3gwv23FstQskE
    ApCcpD5fQ6HGT5THKen+P7000vA9hJHYt8FqLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519878066; bh=Sx0m7jS8LyLZ4gEFZy7XnMZGOL
    MZhgE2z+gvyfFNGjE=; b=IScP6696ePwdLFQjD2UYG7M3bh5u2+rGF4dT9fL7pS
    i/Y9apqyfKBtXeGQKDLx8Ea1LveXQv8troDs2wJc56gSU8ZuzabVwYr66QvVk+re
    oFo8w+/cmniZRyZ+xBmvbMdOM1RZi0IMLnWDIgUOaPt79LF9FgO9q9C+c8e/jC6v
    VqZiqqWKipiVLdC1ncg+AhxzIr4Zp47LqbubtBQ2dI/Gb84pqE6L+uqqvXNfWHfG
    CnmawFDOvPz2DgI/dwxwUYgrUB1Wuf2dz7wtcCViBipI70Ue2+VhjG+BSbzgj9JS
    2S5Cnp18NNF34GBjCxI4UXOWnpa1G6yJzNGHoJpn0FQg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965914AbeCAEUd (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 23:20:33 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48986 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965851AbeCAET7 (ORCPT
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
Subject: [PATCH bpf-next 5/5] samples/bpf: raw tracepoint test
Date: Wed, 28 Feb 2018 20:19:57 -0800
Message-ID: <20180301041957.399230-6-ast@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180301041957.399230-1-ast@kernel.org>
References: <20180301041957.399230-1-ast@kernel.org>
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

empty raw_tracepoint bpf program to test overhead

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 samples/bpf/Makefile                    |  1 +
 samples/bpf/bpf_load.c                  | 13 +++++++++++++
 samples/bpf/test_overhead_raw_tp_kern.c | 17 +++++++++++++++++
 samples/bpf/test_overhead_user.c        | 12 ++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 samples/bpf/test_overhead_raw_tp_kern.c

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 2c2a587e0942..4d6a6edd4bf6 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -119,6 +119,7 @@ always += offwaketime_kern.o
 always += spintest_kern.o
 always += map_perf_test_kern.o
 always += test_overhead_tp_kern.o
+always += test_overhead_raw_tp_kern.o
 always += test_overhead_kprobe_kern.o
 always += parse_varlen.o parse_simple.o parse_ldabs.o
 always += test_cgrp2_tc_kern.o
diff --git a/samples/bpf/bpf_load.c b/samples/bpf/bpf_load.c
index 69806d74fa53..46e9195dc665 100644
--- a/samples/bpf/bpf_load.c
+++ b/samples/bpf/bpf_load.c
@@ -61,6 +61,7 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 	bool is_kprobe = strncmp(event, "kprobe/", 7) == 0;
 	bool is_kretprobe = strncmp(event, "kretprobe/", 10) == 0;
 	bool is_tracepoint = strncmp(event, "tracepoint/", 11) == 0;
+	bool is_raw_tracepoint = strncmp(event, "raw_tracepoint/", 15) == 0;
 	bool is_xdp = strncmp(event, "xdp", 3) == 0;
 	bool is_perf_event = strncmp(event, "perf_event", 10) == 0;
 	bool is_cgroup_skb = strncmp(event, "cgroup/skb", 10) == 0;
@@ -84,6 +85,8 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 		prog_type = BPF_PROG_TYPE_KPROBE;
 	} else if (is_tracepoint) {
 		prog_type = BPF_PROG_TYPE_TRACEPOINT;
+	} else if (is_raw_tracepoint) {
+		prog_type = BPF_PROG_TYPE_RAW_TRACEPOINT;
 	} else if (is_xdp) {
 		prog_type = BPF_PROG_TYPE_XDP;
 	} else if (is_perf_event) {
@@ -128,6 +131,15 @@ static int load_and_attach(const char *event, struct bpf_insn *prog, int size)
 		return populate_prog_array(event, fd);
 	}
 
+	if (is_raw_tracepoint) {
+		efd = bpf_raw_tracepoint_open(event + 15);
+		if (efd < 0) {
+			printf("tracepoint %s %s\n", event + 15, strerror(errno));
+			return -1;
+		}
+		return bpf_prog_attach(fd, efd, BPF_RAW_TRACEPOINT, 0);
+	}
+
 	if (is_kprobe || is_kretprobe) {
 		if (is_kprobe)
 			event += 7;
@@ -584,6 +596,7 @@ static int do_load_bpf_file(const char *path, fixup_map_cb fixup_map)
 		if (memcmp(shname, "kprobe/", 7) == 0 ||
 		    memcmp(shname, "kretprobe/", 10) == 0 ||
 		    memcmp(shname, "tracepoint/", 11) == 0 ||
+		    memcmp(shname, "raw_tracepoint/", 15) == 0 ||
 		    memcmp(shname, "xdp", 3) == 0 ||
 		    memcmp(shname, "perf_event", 10) == 0 ||
 		    memcmp(shname, "socket", 6) == 0 ||
diff --git a/samples/bpf/test_overhead_raw_tp_kern.c b/samples/bpf/test_overhead_raw_tp_kern.c
new file mode 100644
index 000000000000..d2af8bc1c805
--- /dev/null
+++ b/samples/bpf/test_overhead_raw_tp_kern.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2018 Facebook */
+#include <uapi/linux/bpf.h>
+#include "bpf_helpers.h"
+
+SEC("raw_tracepoint/task_rename")
+int prog(struct bpf_raw_tracepoint_args *ctx)
+{
+	return 0;
+}
+
+SEC("raw_tracepoint/urandom_read")
+int prog2(struct bpf_raw_tracepoint_args *ctx)
+{
+	return 0;
+}
+char _license[] SEC("license") = "GPL";
diff --git a/samples/bpf/test_overhead_user.c b/samples/bpf/test_overhead_user.c
index d291167fd3c7..e1d35e07a10e 100644
--- a/samples/bpf/test_overhead_user.c
+++ b/samples/bpf/test_overhead_user.c
@@ -158,5 +158,17 @@ int main(int argc, char **argv)
 		unload_progs();
 	}
 
+	if (test_flags & 0xC0) {
+		snprintf(filename, sizeof(filename),
+			 "%s_raw_tp_kern.o", argv[0]);
+		if (load_bpf_file(filename)) {
+			printf("%s", bpf_log_buf);
+			return 1;
+		}
+		printf("w/RAW_TRACEPOINT\n");
+		run_perf_test(num_cpu, test_flags >> 6);
+		unload_progs();
+	}
+
 	return 0;
 }
-- 
2.9.5

