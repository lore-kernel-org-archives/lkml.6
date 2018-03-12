Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeCLJrz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 05:47:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38524 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752360AbeCLJnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 05:43:18 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 01/13] lib bpf: Add bpf_program__insns function
Date: Mon, 12 Mar 2018 10:43:01 +0100
Message-Id: <20180312094313.18738-2-jolsa@kernel.org>
In-Reply-To: <20180312094313.18738-1-jolsa@kernel.org>
References: <20180312094313.18738-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding bpf_program__insns helper function to retrieve
prog's instructions. It's used later in the patchset.

Link: http://lkml.kernel.org/n/tip-xvpbbusx8gie33kj0et5wx6l@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/bpf/libbpf.c | 7 +++++++
 tools/lib/bpf/libbpf.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5bbbf285af74..6b9df10470e8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -261,6 +261,13 @@ struct bpf_object {
 };
 #define obj_elf_valid(o)	((o)->efile.elf)
 
+struct bpf_insn*
+bpf_program__insns(struct bpf_program *prog, int *insns_cnt)
+{
+	*insns_cnt = prog->insns_cnt;
+	return prog->insns;
+}
+
 static void bpf_program__unload(struct bpf_program *prog)
 {
 	int i;
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index f85906533cdd..bfc4d0411ec5 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -180,6 +180,9 @@ int bpf_program__set_prep(struct bpf_program *prog, int nr_instance,
 
 int bpf_program__nth_fd(struct bpf_program *prog, int n);
 
+struct bpf_insn*
+bpf_program__insns(struct bpf_program *prog, int *insns_cnt);
+
 /*
  * Adjust type of bpf program. Default is kprobe.
  */
-- 
2.13.6
