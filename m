Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeDWG7e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 02:59:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754162AbeDWG7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 02:59:31 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 2/3] tools bpf: Sync bpf.h uapi header
Date: Mon, 23 Apr 2018 08:59:26 +0200
Message-Id: <20180423065927.23127-3-jolsa@kernel.org>
In-Reply-To: <20180423065927.23127-1-jolsa@kernel.org>
References: <20180423065927.23127-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syncing the bpf.h uapi header with tools.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/uapi/linux/bpf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7f7fbb9d0253..b7298ee177e7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -239,6 +239,8 @@ enum bpf_attach_type {
 
 #define BPF_OBJ_NAME_LEN 16U
 
+#define BPF_OBJ_LICENSE_LEN 128U
+
 /* Flags for accessing BPF object */
 #define BPF_F_RDONLY		(1U << 3)
 #define BPF_F_WRONLY		(1U << 4)
@@ -884,6 +886,7 @@ enum bpf_func_id {
 /* BPF_FUNC_skb_set_tunnel_key flags. */
 #define BPF_F_ZERO_CSUM_TX		(1ULL << 1)
 #define BPF_F_DONT_FRAGMENT		(1ULL << 2)
+#define BPF_F_SEQ_NUMBER		(1ULL << 3)
 
 /* BPF_FUNC_perf_event_output, BPF_FUNC_perf_event_read and
  * BPF_FUNC_perf_event_read_value flags.
@@ -1038,6 +1041,7 @@ struct bpf_prog_info {
 	__u32 ifindex;
 	__u64 netns_dev;
 	__u64 netns_ino;
+	char license[BPF_OBJ_LICENSE_LEN];
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.13.6
