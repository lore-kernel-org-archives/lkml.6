Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeDEPSK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:18:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751887AbeDEPRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:17:11 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Eugene Syromiatnikov <esyr@redhat.com>, Jiri Benc <jbenc@redhat.com>,
        Stanislav Kozina <skozina@redhat.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 7/9] libbpf: Synchronize uapi bpf.h header
Date: Thu,  5 Apr 2018 17:16:43 +0200
Message-Id: <20180405151645.19130-8-jolsa@kernel.org>
In-Reply-To: <20180405151645.19130-1-jolsa@kernel.org>
References: <20180405151645.19130-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synchronize include/uapi/linux/bpf.h with tools version.

Link: http://lkml.kernel.org/n/tip-gaja0nnet6oku657642nxnaf@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 9d07465023a2..17d8d330e6c7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -308,6 +308,8 @@ union bpf_attr {
 		 * (context accesses, allowed helpers, etc).
 		 */
 		__u32		expected_attach_type;
+		/* Checked when prog_type=kprobe and CONFIG_BPF_BUILDID_CHECK. */
+		__aligned_u64	kern_buildid;
 	};
 
 	struct { /* anonymous struct used by BPF_OBJ_* commands */
@@ -864,6 +866,7 @@ enum bpf_func_id {
 /* BPF_FUNC_skb_set_tunnel_key flags. */
 #define BPF_F_ZERO_CSUM_TX		(1ULL << 1)
 #define BPF_F_DONT_FRAGMENT		(1ULL << 2)
+#define BPF_F_SEQ_NUMBER		(1ULL << 3)
 
 /* BPF_FUNC_perf_event_output, BPF_FUNC_perf_event_read and
  * BPF_FUNC_perf_event_read_value flags.
-- 
2.13.6
